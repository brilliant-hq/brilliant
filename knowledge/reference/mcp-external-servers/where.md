---
name: "knowledge-mcp-external-servers-where"
description: "Where external MCP tools show up in the chat, which chat backends support them, and the desktop-only limit."
assumes: reference/mcp-external-servers
---

# Where the tools show up

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
| API-key models (Anthropic, OpenAI, Google, OpenRouter, Meta, custom OpenAI-compatible) | Yes, via Brilliant's built-in MCP client |
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
