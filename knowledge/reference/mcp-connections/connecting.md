---
name: "knowledge-mcp-connections-connecting"
description: "The three ways a user connects an external MCP tool to Brilliant, and the restart and first chat that make it live."
assumes: reference/mcp-connections
---

# How a user connects a tool

Three equivalent paths:

1. **Settings → MCP Connections.** One flat list showing every supported tool;
   each row is just the tool name and a checkmark. The checkmark reflects one
   thing: whether Brilliant is in that tool's MCP config. Flip it on to add
   Brilliant, off to remove it. There is no install detection, so a tool you
   haven't installed yet is still listed and still toggleable: enabling it just
   writes the config, and the tool picks Brilliant up once it is installed. The
   refresh button re-reads each config from disk. Tools that can't be supported
   yet (Claude Desktop) show a reason instead of a toggle. A config hand-edited
   to a different address shows as unchecked; toggling on rewrites it to the
   correct local URL.
2. **Palette.** "MCP Connections" opens that settings page
   (`open_mcp_connections_settings`). Every supported tool also has its own
   always-available command, e.g. "Toggle Cursor MCP Connection"
   (`toggle_<client>_mcp`).
3. **From the chat.** Choosing to bring your own AI (from Settings, or from the
   door at a wall) opens the short setup conversation whose first question offers
   **Connect a coding agent (MCP)**; picking it lists every supported tool as one
   flat list, and choosing one connects it. On desktop, connecting shows a
   numbered checklist (Brilliant writes the config, then restart the tool and
   start a session). In the web editor it shows the exact command to copy and
   checks off automatically once the agent connects. It keeps looking for the
   agent for about ten minutes while the tab is visible, then "Show the command
   again" starts it looking again.

After connecting, **the tool must be restarted** to pick up the new server
(the UI shows a restart note). A restart alone shows nothing: **nothing happens
until a chat starts.** Clients like Cursor and Codex spawn the `brilliant` MCP
server only when a chat or session begins, not on launch, so the user must open
the tool's AI chat (in Cursor, `Cmd+I`) or start a session and send a message.
The `brilliant` tools connect on that first call, and Brilliant's own checklist
ticks its last step then. Starting a new chat or session never opens Brilliant
or brings its window forward: the tool connects to the running app in place.
