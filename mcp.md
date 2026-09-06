# Brilliant: AI Design Tool

Brilliant is a Figma-like 2D vector design tool. Auto layout, frames, groups, hug/fill/fixed sizing, fills, strokes, components, all work like Figma.

## Session Identity

`init` returns a unique session ID (`mcp:<id>`). **Pass that exact string as the `sessionId` argument on every `create_modify_elements` and `create_html` call.** It scopes your element refs (`#name`) and design-system state so concurrent agents never collide, and gives you your own distinct labelled cursor on the canvas, two agents that each echo their ID show as two separate cursors instead of one thrashing between both. Omitting it falls back to a shared stateless session (and a shared cursor), fine for a single agent, but always prefer the minted ID.

Optionally pass `agentName` (a short 2-3 word label) to `init` to name your canvas cursor; otherwise a name is auto-assigned.

If you **cannot read images**, pass `vision: false` to `init` (it defaults to true). Then whenever you request a preview (`previewRows` / `previewIds` on `create_modify_elements` or `execute_commands`) you get a compact **textual render summary** in place of the inline PNG: each element's bounds in its parent and in world space, layout/overflow checks, and a fill or text one-liner, so you can confirm your write landed without seeing it.

## Working across projects

By default your session is bound to the project currently open on screen. You can reach **any** project the user owns, including ones that are not open.

- **`list_projects`** returns every project: its `name`, `key` (a folder path or `brilliant-cloud://` key), `backing` (local/synced/cloud), `openState`, and `canvasCount`.
- Pass **`project`** to `init` to bind your whole session to a different project, or to any single canvas tool (`create_modify_elements`, `create_html`, `lookup`, `get_selection`, `export`, `execute_commands`) to run just that one call against another project. Give the exact name or key from `list_projects`, or an unambiguous part of the name; an unknown or ambiguous value is refused with the candidates listed, so it never guesses.
- A project that is not open is opened for you in the background (the user is told an agent is working there and offered to open it). Your edits are saved to that project and are fully undoable. When you address another project, always give the real `canvasId` from `list_projects` / `lookup`, addressing a project without naming a real canvas will NOT create a new canvas there.

## Element Creation

- **`create_html`** (default): HTML + inline CSS. No knowledge loading needed. Icons: `<i data-icon="name">`.
- **`create_modify_elements`**: Blueprint DSL. Load knowledge first via `get_knowledge`.

They compose: build with `create_html`, iterate with Blueprint DSL.

Session refs: `id="name"` in HTML → `#name` ref usable in both tools and `execute_commands`.
Use `mcp__brilliant__*` tools only. Ignore other design servers (Paper, Pencil, etc.).

**Which canvas your write lands on.** Always pass a real `canvasId` from `init` / `list_projects` / `lookup`. A canvasId that differs from an existing canvas only in letter-case or a trailing `.bl` targets that existing canvas (so `Main`, `main.bl`, and `main` all reach `main`). A canvasId that names nothing yet is CREATED as a new canvas, and the response tells you so: a `createdCanvas` field names the new canvas and a warning line says a new canvas was created. If you did not mean to make a new canvas, that field is your signal that the id was a typo, so check it against `get_canvases`. `execute_commands` verbs that do not act on a specific canvas (like `get_canvases`) add a `canvasIdIgnored` note if you hand them a canvasId that matches nothing, rather than accepting it silently.

## Retrying a Create (`requestId` argument)

`create_modify_elements` and `create_html` take an optional **`requestId`**: a stable, unique id you invent for one logical request. Pass it on the call, and if that call comes back as a timeout or a relay error, **retry with the same `requestId` and the same `sessionId`**. The retry then converges on the original: it joins the still-running original if it is still working, or replays what it returned, instead of creating the elements a second time.

This matters because a heavy create can succeed on the app side and still time out on the way back to you. A blind retry duplicates everything it just built.

- A result is remembered for **2 minutes** after the call completes, and only if it SUCCEEDED. A call that came back as an error is not remembered, so retrying it really does re-run.
- Reuse a token **only for a genuine retry of the same request**. A new request needs a new id: the token is matched on its own, not on your content, so reusing one with a different blueprint inside those 2 minutes replays the old result and writes nothing.
- Without a `requestId` there is no protection. If an error says the operation may still have applied, verify with `lookup` or `get_selection` before you retry a mutation.

## Design System (`designSystem` argument)

`init` shows the project's `default` design system catalog. `create_modify_elements` takes an optional `designSystem` argument that picks how you work with design tokens. It is **sticky**, set it once and it persists for later calls until you change it. If you never pass it, the session stays sovereign (`none`). `create_html` does **not** take this argument and is always sovereign, HTML/CSS cannot reference tokens. For any token-disciplined work, use `create_modify_elements` (Blueprint).

- **`designSystem: "default"`**: build against the `default` design system. Token discipline is enforced: colors, fonts, and scale slots must be token references (`$color.surface`, `$spacing.md`, ...). No bare hex or numeric literals on tokenizable slots.
- **`designSystem: "new"`**: author your own design system. Your first move must be a `ds_file("name") <body>` directive (before any element rows). It inherits the `default` catalog, override only what differs. Later calls then behave like `"default"` against your brand. Re-select it by passing `designSystem: "<name>"`.
- **`designSystem: "none"`**: sovereign mode. No constraints; bare hex/numeric values are fine.

You can only select `default`, `new`, `none`, or a brand you authored yourself this session. The user's pre-existing brands are not selectable, author your own with `"new"` if you need a custom system.
