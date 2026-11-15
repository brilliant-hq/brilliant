---
name: "knowledge-mcp-external-servers-discovery"
description: "How Brilliant's chat finds your MCP servers (only the top-level mcpServers in ~/.claude.json), and the auto-injected playwright server."
assumes: reference/mcp-external-servers
---

# How Brilliant finds your servers

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
