---
name: "knowledge-mcp-external-servers-config"
description: "The mcpServers config format for external MCP servers: stdio and HTTP transports with examples."
assumes: reference/mcp-external-servers
---

# Config format

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
project `.mcp.json` is not picked up, see `reference/mcp-external-servers/discovery`).
