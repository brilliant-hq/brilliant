---
name: "knowledge-mcp-connections"
description: "Connecting external MCP clients (Cursor, Claude Code, VS Code, Windsurf, Zed, Codex CLI, Gemini CLI, Antigravity, OpenCode, Amp, Muse Code) to Brilliant so a user can drive the canvas from their own coding tool: the MCP Connections settings page, the per-client toggle commands, the in-chat setup branch, what enabling writes to each tool's config, restart semantics, and how to verify or troubleshoot."
---

# MCP Connections (drive Brilliant from your coding tool)

Brilliant runs a local MCP server, so any external MCP client can call
Brilliant's canvas tools. "MCP Connections" is the feature that registers
Brilliant into another tool's config for the user. This is distinct from the
integrated chat inside Brilliant; here the user designs from *their own* tool.
MCP itself is local-only: nothing an external agent sends or receives over MCP
routes through Brilliant's servers, except an image `generate_image` makes on
Brilliant AI (no Google key of your own set). (Inside Brilliant's own chat there are two
lanes: Brilliant AI goes through Brilliant's servers to Google; your own AI's text goes
straight to your provider. Images draw on your Brilliant AI usage unless you add your
own Google key, in either lane and over MCP alike.)

External MCP agents never count against any cap and stay unlimited on every plan, including Free, except an image generated on Brilliant AI, which draws on your Brilliant AI usage and, on Free, runs up to three every five minutes. Image calls on Brilliant AI need the `sessionId` that `init` returns.

Looking for the other direction (using external MCP servers *inside*
Brilliant's own chat)? See `reference/mcp-external-servers`.

Supported clients include Claude Code, Cursor, VS Code (Copilot), Windsurf, Zed,
Codex CLI (the same connection also serves the ChatGPT desktop app, which reads the same ~/.codex/config.toml), Gemini CLI, Antigravity, OpenCode (opencode.ai), Amp (ampcode.com), and Muse Code (Meta's `muse` CLI). The roster keeps
growing; the MCP Connections list is the live source of truth for which tools
Brilliant can connect right now.

- `reference/mcp-connections/connecting`: the three ways to connect a tool, and the restart and first chat that make it live
- `reference/mcp-connections/server`: the local server's address and ports, and why Safari cannot connect an agent
- `reference/mcp-connections/enabling`: what enabling writes, and the config file per tool
- `reference/mcp-connections/troubleshooting`: verifying a connection and fixing one that does not show up
