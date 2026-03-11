## Knowledge Loading

Load knowledge via `get_knowledge(keys: [...])`. Prerequisites are automatic — the server resolves dependencies.

**Load generously.** Each knowledge file is small (5–50 lines), so loading extra keys costs almost nothing. When in doubt, include the key — missing knowledge leads to worse designs. A single `get_knowledge` call with 10+ keys is perfectly fine.

Tell the user what you're doing before loading so they see activity.

## Knowledge Keys

| Category | Keys | Required for |
|----------|------|-------------|
| blueprint/* | core, layout, layout-patterns, paint, text, styled-ranges, effects, vectors, components, arcs, images, commands, directives, gradients/{linear,radial,angular}, shaders/{overview,metaballs,metal,holo,steel} | Blueprint DSL |
| design/* | foundations, colors, typography, shadows, backgrounds, gradients, brand, blocks/{actions,inputs,navigation,data-display,feedback,layout,patterns} | Optional — improves design quality with either path |
| effects/* | glass, neon, clay, dark-mode | Blueprint DSL — effect recipes |
| charts/* | tables, bar-charts, line-charts, sparklines, rings, misc | Blueprint DSL — data visualization |
| images/prompts, images/templates | — | Optional — AI image generation guidance, either path |
| images/integration | — | Blueprint DSL — image placement patterns |
| recreation/* | from-image, from-web | Blueprint DSL — recreating designs |
| reference/* | shortcuts, tools, editing, frames, text, styling, canvas, vectors, components, effects, export, design-system, crop, shaders, canvases, layout-guides, ai, ui | Neither — self-contained answers to user questions |

## Task → Keys

| Task | Keys to load |
|------|-------------|
| **Any new design** | `design/foundations` + relevant `design/blocks/*` |
| **Effects-heavy** | + `effects/glass` or `effects/neon` or `effects/clay` |
| **Dashboard / analytics** | + relevant `charts/*` |
| **Recreating from image** | `recreation/from-image` |
| **Recreating from URL** | `recreation/from-web` |
| **Deep color choices** | + `design/colors` |
| **Deep typography** | + `design/typography` |
| **Real images** | + `images/prompts`, `images/templates` |
| **Answer a question** | Relevant `reference/*` file(s) |
| **Shaders** | + specific shader type under `blueprint/shaders/*` |

> **Which `design/blocks/*`?** `actions` (buttons) for everything. `layout` (hero, header, footer) for pages. `data-display` (cards, stats, tables) for dashboards. `navigation` for multi-page. `inputs` for forms. `feedback` (modals, toasts) for interactive UI. When unsure, load all — they're small.

## Large Designs: Chunked Creation

Split `create_modify_elements` calls into ~20-25 elements per chunk. Structure chunks around logical groups (one card, one section) so undo remains useful.

## Reading Canvas State

Every `create_modify_elements` and `execute_commands` response includes a `blueprint` field with IDs. Use these for subsequent operations.

## Bundled Icons

All **Phosphor regular-weight** icons bundled. Use `svg(icon:name)` with kebab-case. Browse at [phosphoricons.com](https://phosphoricons.com). **ALL ICONS = SVGs.** Never `vector` for icons. Never emoji.
