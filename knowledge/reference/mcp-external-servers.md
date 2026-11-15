---
name: "knowledge-mcp-external-servers"
description: "Using external MCP servers inside Brilliant's integrated chat: how the built-in AI discovers servers from the top-level mcpServers in your ~/.claude.json (project-scoped config is not reachable), the stdio and HTTP transport options with JSON examples, the mcp__ tool prefix and on-demand loading, the auto-injected playwright server, which chat backends support it (API-key models and Claude Code, not Codex), the desktop-only limit, and troubleshooting a server that does not appear. This is the opposite direction from `reference/mcp-connections`, which drives Brilliant from your own tool."
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
another tool so it can drive the canvas)? See `reference/mcp-connections`.

- `reference/mcp-external-servers/discovery`: how Brilliant finds your servers (top-level `~/.claude.json` only), and the auto-injected playwright server
- `reference/mcp-external-servers/config`: the `mcpServers` config format, stdio and HTTP
- `reference/mcp-external-servers/where`: where the tools show up, which chat backends support them, desktop only
- `reference/mcp-external-servers/troubleshooting`: a server that fails to start or does not appear
