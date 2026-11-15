---
name: "knowledge-mcp-connections-server"
description: "The local MCP server: its address and port rules, and why Safari cannot connect an agent from the web editor."
assumes: reference/mcp-connections
---

# The local MCP server

The server is a local HTTP endpoint, normally `http://127.0.0.1:3333/mcp`. At
startup it takes the first free port of 3333, 3334, 3335. It supports multiple
clients at once. **Brilliant must be running for a connected tool to reach
it.** Within one run the port is stable: if the listener drops (for example
across sleep/wake), Brilliant rebinds the **same** port rather than walking to a
neighbor. Two caveats: (1) the port pool is shared with any OTHER running
Brilliant instance, so if a second instance already holds 3333 this one lands on
3334/3335, and a client hardcoded to 3333 reaches whichever instance owns 3333,
not necessarily the one you are looking at; (2) if all three ports are taken,
the server cannot bind at all and shows a port-unavailable notice with a Retry,
so the configured URL is not live until it binds.

**Safari cannot connect an agent.** In the web editor the agent reaches
Brilliant over the user's own machine (a loopback connection to `127.0.0.1`),
and Safari blocks that for every website, with no setting that turns it on. In
Safari, both the in-chat flow and Settings → MCP Connections say so and point
at Chrome, Edge, Firefox, or the desktop app rather than offering a connect
that can never land. Chrome may ask once for local network permission on its
first connect; granting it is a normal part of setup.
If that prompt is closed without an answer, it is not shown again until the
user connects again (in the chat, "Show the command again").
