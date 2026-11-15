---
name: "knowledge-mcp-external-servers-troubleshooting"
description: "Troubleshooting an external MCP server that fails to start or does not appear in the chat."
assumes: reference/mcp-external-servers
---

# Troubleshooting

**A server that fails to start is never silent.** If a configured server can't
be spawned or doesn't complete the MCP handshake, the chat shows a card naming
the server, its command, and the reason, including the server's own error
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
