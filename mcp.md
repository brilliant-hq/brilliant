# Brilliant — AI Design Tool

Brilliant is a Figma-like 2D vector design tool. Auto layout, frames, groups, hug/fill/fixed sizing, fills, strokes, components — all work like Figma.

## Session Identity

`init` returns a unique session ID (`mcp:<id>`). **Pass that exact string as the `sessionId` argument on every `create_modify_elements` and `create_html` call.** It scopes your element refs (`#name`) and design-system state so concurrent agents never collide, and gives you your own distinct labelled cursor on the canvas — two agents that each echo their ID show as two separate cursors instead of one thrashing between both. Omitting it falls back to a shared stateless session (and a shared cursor) — fine for a single agent, but always prefer the minted ID.

Optionally pass `agentName` (a short 2-3 word label) to `init` to name your canvas cursor; otherwise a name is auto-assigned.

## Element Creation

- **`create_html`** (default) — HTML + inline CSS. No knowledge loading needed. Icons: `<i data-icon="name">`.
- **`create_modify_elements`** — Blueprint DSL. Load knowledge first via `get_knowledge`.

They compose: build with `create_html`, iterate with Blueprint DSL.

Session refs: `id="name"` in HTML → `#name` ref usable in both tools and `execute_commands`.
Use `mcp__brilliant__*` tools only. Ignore other design servers (Paper, Pencil, etc.).

## Design System (`designSystem` argument)

`init` shows the project's `default` design system catalog. `create_modify_elements` takes an optional `designSystem` argument that picks how you work with design tokens. It is **sticky** — set it once and it persists for later calls until you change it. If you never pass it, the session stays sovereign (`none`). `create_html` does **not** take this argument and is always sovereign — HTML/CSS cannot reference tokens. For any token-disciplined work, use `create_modify_elements` (Blueprint).

- **`designSystem: "default"`** — build against the `default` design system. Token discipline is enforced: colors, fonts, and scale slots must be token references (`$color.surface`, `$spacing.md`, ...). No bare hex or numeric literals on tokenizable slots.
- **`designSystem: "new"`** — author your own design system. Your first move must be a `ds_file("name") <body>` directive (before any element rows). It inherits the `default` catalog — override only what differs. Later calls then behave like `"default"` against your brand. Re-select it by passing `designSystem: "<name>"`.
- **`designSystem: "none"`** — sovereign mode. No constraints; bare hex/numeric values are fine.

You can only select `default`, `new`, `none`, or a brand you authored yourself this session. The user's pre-existing brands are not selectable — author your own with `"new"` if you need a custom system.
