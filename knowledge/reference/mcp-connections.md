---
name: "knowledge-mcp-connections"
description: "Connecting external MCP clients (Cursor, Claude Code, VS Code, Windsurf, Zed, Codex CLI, Gemini CLI, Antigravity, OpenCode) to Brilliant so a user can drive the canvas from their own coding tool: the MCP Connections settings page, the per-client toggle commands, the in-chat setup branch, what enabling writes to each tool's config, restart semantics, and how to verify or troubleshoot."
---

# MCP Connections (drive Brilliant from your coding tool)

Brilliant runs a local MCP server, so any external MCP client can call
Brilliant's canvas tools. "MCP Connections" is the feature that registers
Brilliant into another tool's config for the user. This is distinct from the
integrated BYOK chat (that runs a provider *inside* Brilliant); here the user
designs from *their own* tool. Brilliant is BYOK-only; nothing routes through
Brilliant servers.

The server is a local HTTP endpoint, normally `http://127.0.0.1:3333/mcp`
(falls back to 3334/3335 at startup if the port is busy). It supports multiple
clients at once. **Brilliant must be running for a connected tool to reach
it.** Once bound, the port is stable for the app's lifetime: if the listener
ever drops (e.g. across sleep/wake), Brilliant rebinds the same port
automatically, so a configured client URL stays valid.

Supported clients include Claude Code, Cursor, VS Code (Copilot), Windsurf, Zed,
Codex CLI, Gemini CLI, Antigravity, and OpenCode (opencode.ai). The roster keeps
growing; the MCP Connections list is the live source of truth for which tools
Brilliant can connect right now.

## How a user connects a tool

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
2. **Command palette.** "MCP Connections" opens that settings page
   (`open_mcp_connections_settings`). Every supported tool also has its own
   always-available command, e.g. "Toggle Cursor MCP Connection"
   (`toggle_<client>_mcp`).
3. **First-run / demo chat.** The setup Q&A offers **"Drive Brilliant via MCP"**
   (subtitle "Cursor, Claude Code, Codex, Antigravity, and more"); picking it
   lists every supported tool as one flat list, and choosing one connects it.

After connecting, **the tool must be restarted** to pick up the new server
(the UI shows a restart note). Then, inside that tool, the user asks it to
design in Brilliant and it calls the `brilliant` MCP tools.

## What enabling actually does

Enabling writes a `brilliant` MCP server entry (pointing at the local URL) into
**that tool's own config file**. That file is the source of truth; Brilliant
stores no separate toggle state. The state shown is always read fresh from the
file. Disabling removes only Brilliant's entry; other servers and comments are
preserved.

| Tool | Config file it writes | Notes |
|------|----------------------|-------|
| Claude Code | `~/.claude.json` | already may use Brilliant per-project too |
| Cursor | `~/.cursor/mcp.json` | |
| VS Code (Copilot) | `.../Code/User/mcp.json` | comments preserved |
| Windsurf | `~/.codeium/windsurf/mcp_config.json` | |
| Zed | `~/.config/zed/settings.json` | comments preserved |
| Codex CLI | `~/.codex/config.toml` | Brilliant also auto-adds this on launch |
| Gemini CLI | `~/.gemini/settings.json` | |
| Antigravity | `~/.gemini/antigravity/mcp_config.json` | |
| OpenCode | `~/.config/opencode/opencode.json` | comments preserved |
| Claude Desktop | (not writable) | disabled: its config supports only local stdio servers, not a remote URL |

## Verifying and troubleshooting

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
  after enabling, and Brilliant must be running.
