---
name: "knowledge-mcp-external-servers"
description: "Using external MCP servers inside Brilliant's integrated chat: how the built-in AI discovers servers from the top-level mcpServers in your ~/.claude.json (project-scoped config is not reachable), the stdio and HTTP transport options with JSON examples, the mcp__ tool prefix and on-demand loading, the auto-injected playwright server, which chat backends support it (API-key models and Claude Code, not Codex), the desktop-only limit, and troubleshooting a server that does not appear. This is the opposite direction from mcp-connections.md, which drives Brilliant from your own tool."
---

# External MCP servers (use other tools' MCP inside Brilliant's chat)

Brilliant's integrated chat can call the tools of any MCP server you have
configured on your machine. If a service ships an MCP server (a component
library, a docs search, an issue tracker, reui.io's server, whatever), you can
point Brilliant at it and the chat can use its tools right alongside the canvas
tools while it designs for you.

This is the reverse of MCP Connections. There, an external tool like Cursor or
Claude Code drives Brilliant. Here, Brilliant's own chat reaches out to *your*
MCP servers. Looking for that other direction (registering Brilliant into
another tool so it can drive the canvas)? See `mcp-connections.md`.

## How Brilliant finds your servers

Brilliant reads the same config shape the Claude Code CLI uses, but the chat
runs in a private per-session working directory (a temp folder Brilliant
creates), NOT your project folder. That one fact decides which config actually
takes effect:

1. `~/.claude.json`, the top-level `mcpServers` block: **works.** It applies to
   every chat, so this is where to put servers you want the chat to reach.
2. `~/.claude.json`, `projects["<dir>"].mcpServers`: **does not take effect.**
   The key would have to be the session's temp directory, which is never a
   project you configured, so a project-scoped block never matches.
3. `.mcp.json` in your project folder: **does not take effect.** The only
   `.mcp.json` on the walked path is the one Brilliant writes into the session
   directory itself (see below); your project's `.mcp.json` is not in that
   chain.

So configure external servers at the **user (top-level) scope** in
`~/.claude.json`. Project-scoped configuration is not reachable from the chat.

A server named `brilliant` is always ignored here, since that name is reserved
for Brilliant's own canvas server.

## The auto-injected playwright server

Brilliant writes its own `.mcp.json` into each session directory, carrying the
`brilliant` canvas server and a **`playwright`** server (`npx -y
@playwright/mcp`). The playwright server is therefore present in every desktop
chat without you configuring anything. It is spawned on demand like any stdio
server: if `@playwright/mcp` cannot be fetched or run (no network, `npx`
missing, and so on), the "server failed to start" card names `playwright` even
though you never added it. That card is about the auto-injected server, not
your own config.

## Config format

Every source uses the same `mcpServers` shape. Two transports are supported.

**Stdio** (Brilliant launches the server as a local subprocess). Give it a
`command`, optional `args`, and optional `env`:

```json
{
  "mcpServers": {
    "my-tools": {
      "command": "npx",
      "args": ["-y", "some-mcp-server"],
      "env": { "API_KEY": "your-key-here" }
    }
  }
}
```

**HTTP** (Brilliant connects to a running server over the network). Set
`type` to `http` and give it a `url`:

```json
{
  "mcpServers": {
    "reui": {
      "type": "http",
      "url": "https://your-mcp-host.example.com/mcp"
    }
  }
}
```

Use whatever `command`, `args`, `env`, or `url` the server's own setup docs
tell you to use. Put the block in the **top-level** `mcpServers` of
`~/.claude.json`: that is the scope the chat reads (a project-scoped block or a
project `.mcp.json` is not picked up, see "How Brilliant finds your servers").

## Where the tools show up

Tools from an external server appear to the model with an `mcp__` prefix:
`mcp__<server-name>__<tool-name>`. A `search` tool on a server you named
`reui` becomes `mcp__reui__search`.

Servers load on demand to keep the chat fast. On the first message of a chat
session, Brilliant connects to every server it found and tells the model which
servers exist and roughly what each does, but it does not load all their tools
up front. When the model needs one, it loads that server, and the full tool set
plus the server's own instructions become available for the rest of the
conversation. In practice you do not have to do anything special: just ask the
chat to use the capability and it will load the server and call it.

## Which chat backends support this

| Backend | External MCP servers? |
|---------|----------------------|
| API-key models (Anthropic, OpenAI, Google, OpenRouter, custom OpenAI-compatible) | Yes, via Brilliant's built-in MCP client |
| Claude Code CLI | Yes, natively (the CLI reads the same `~/.claude.json` and `.mcp.json`) |
| Codex (ChatGPT-subscription) | No |

The Codex backend only receives Brilliant's own canvas server, not your
external servers. If you need external MCP tools in chat, use an API-key model
or the Claude Code backend.

## Desktop only

External MCP servers work in the Brilliant desktop app only. The feature needs
your local config files and, for stdio servers, the ability to spawn
subprocesses, and neither of those exists in a browser. The web app's chat does
not load external servers.

## Troubleshooting

**A server that fails to start is never silent.** If a configured server can't
be spawned or doesn't complete the MCP handshake, the chat shows a card naming
the server, its command, and the reason — including the server's own error
output when it printed any. The model is told too, so you can simply ask the
chat why a server's tools are missing.

**A server does not appear:** almost always a config file problem.

- Check the file is valid JSON. One stray comma breaks the whole `mcpServers`
  block.
- Check the scope. Only the **top-level** `mcpServers` in `~/.claude.json` is
  read. A project-scoped block (`projects[...]` in `~/.claude.json`, or a
  `.mcp.json` in your project folder) never takes effect, because the chat runs
  in its own session directory, not your project. Move the server up to the
  top-level block.
- For a stdio server, make sure the `command` is installed and on your PATH.
  On Windows, npm-installed commands (like `npx`) are `.cmd` shims; Brilliant
  resolves them the way a shell would, so the same bare `"command": "npx"`
  config works on every platform.
- For an HTTP server, make sure `type` is `"http"` and the `url` is reachable.
- Brilliant reads your config when a chat session first connects, so after
  editing config, start a new chat session (or send the first message in a
  fresh one) to pick up the change.
- Remember the name `brilliant` is reserved and skipped here.
