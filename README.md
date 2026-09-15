# Brilliant docs

[Brilliant](https://brilliant.design) is a Figma-like 2D vector design tool that AI agents drive directly: auto layout, frames, components, design-system tokens, effects, and export, all created through the same MCP surface a person edits by hand.

This repo holds the agent and product documentation: how to connect to Brilliant, how to author designs, and how the app behaves. It is the reference an agent (or a curious human) reads while designing.

## What's here

- **Connecting** ([`agent.md`](agent.md)): the single source, composed per door (external MCP, HTTP/BYOK, hosted CLI, and sub-agent), for each way an agent talks to Brilliant. The `<objects>` tag form for emitting Blueprint in a reply lives in the same file.
- **Authoring and design guidance** ([`knowledge/`](knowledge/)): design foundations, color, typography, layout blocks, effects, charts, images, WebGL shaders, design systems, and the product reference (canvas, tools, components, export, shortcuts, and more).
- **Sharing feedback** ([`skills/feedback/`](skills/feedback/)): how the assistant helps you file a bug or request.

## Related repos

- **[brilliant-hq/blueprint](https://github.com/brilliant-hq/blueprint)**: the Blueprint language itself, the formal spec plus the authoring reference. Start there for the grammar and the lossless storage format.
- **[brilliant-hq/feedback](https://github.com/brilliant-hq/feedback)**: the public issue tracker for bugs, feature requests, and RFCs.
