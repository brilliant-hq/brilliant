---
name: "knowledge-mcp-connections-troubleshooting"
description: "Verifying an MCP connection and troubleshooting a tool that does not see Brilliant."
assumes: reference/mcp-connections
---

# Verifying and troubleshooting

- **Verify:** in the connected tool, ask it to create or read something in
  Brilliant. It should call `mcp__brilliant__*` tools and the result should
  appear on the canvas. Brilliant must be open.
- **Connecting a tool you haven't installed yet:** fine. The toggle just writes
  Brilliant into that tool's config; the tool reads it once installed and
  launched. There is nothing to "detect" first.
- **Checkmark off even though the config has a `brilliant` entry:** the entry
  points somewhere else (the config was hand-edited). Toggling on rewrites it to
  the correct local URL.
- **Connected but the tool doesn't see Brilliant:** it usually needs a restart
  after enabling, and Brilliant must be running. Remember that a restart alone
  does nothing until a chat starts: the client spawns the server on the first
  chat/session, so open its AI chat and send a message before expecting the
  `brilliant` tools.
- **Cursor shows `brilliant` as Error after Brilliant relaunches (or after
  sleep):** open Cursor's MCP settings and reload the `brilliant` server (or
  toggle it off and on); it reconnects to the running app.
