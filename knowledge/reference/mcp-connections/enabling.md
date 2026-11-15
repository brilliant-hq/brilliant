---
name: "knowledge-mcp-connections-enabling"
description: "What enabling an MCP connection writes, and the config file Brilliant writes for each tool."
assumes: reference/mcp-connections
---

# What enabling actually does

Enabling writes a `brilliant` MCP server entry (pointing at the local URL) into
**that tool's own config file**. That file is the source of truth; Brilliant
stores no separate toggle state. The state shown is always read fresh from the
file. Disabling removes only Brilliant's entry; other servers and comments are
preserved.

Every tool you connected follows Brilliant's local address on every start, so
it stays checked and keeps its connection after a relaunch or an update with
no re-toggle. A tool you never connected, or disconnected, is left untouched.

| Tool | Config file it writes | Notes |
|------|----------------------|-------|
| Claude Code | `~/.claude.json` | already may use Brilliant per-project too |
| Cursor | `~/.cursor/mcp.json` | |
| VS Code (Copilot) | `.../Code/User/mcp.json` | comments preserved |
| Windsurf | `~/.codeium/windsurf/mcp_config.json` | |
| Zed | `~/.config/zed/settings.json` (Windows: `%APPDATA%\Zed\settings.json`) | comments preserved |
| Codex CLI | `~/.codex/config.toml` | Brilliant also auto-adds this on launch, but only when `~/.codex/` already exists (Codex installed); skipped otherwise so a non-Codex home is not touched |
| Gemini CLI | `~/.gemini/settings.json` | |
| Antigravity | `~/.gemini/config/mcp_config.json` | |
| OpenCode | `~/.config/opencode/opencode.json` | comments preserved |
| Amp | `~/.config/amp/settings.json` | under the `amp.mcpServers` key, comments preserved |
| Muse Code | `~/.config/muse/settings.json` | under the `mcpServers` key; schema_version kept (added as `1` when the file has none, since Muse Code refuses a file without it); a legacy `mcp_servers` key is renamed to `mcpServers`, never left beside it. Restart your muse session to connect |
| Claude Desktop | (not writable) | disabled: its config supports only local stdio servers, not a remote URL |
