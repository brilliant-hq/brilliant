## Knowledge — get_knowledge(keys: [...])

Before any design task using Brilliant's DSL, load relevant knowledge.

Over-load, never under-load (files are 5-50 lines). Max 6 keys per call — split across 2-4 calls. Many chats require 20-25 knowledge files.

CRITICAL: NEVER start designing via Brilliant's DSL before loading *a minimum of 12 knowledge keys*.

Load **all rows that apply** — most designs match 3-5 rows:

| Task | Keys to load |
|------|-------------|
| **Any new design** | `design-systems/core` + `design/foundations` + `blueprint/components` + relevant `design/blocks/*` |
| **Authoring or modifying a design system** (only when the user asks) | `design-systems/authoring` (+ `design-systems/authoring-modes` if overriding default mode behavior) |
| **Effects** | + `effects/{glass,neon,clay,dark-mode}` |
| **Dashboard / analytics** | + relevant `charts/*` |
| **Recreate from image** | `recreation/from-image` |
| **Recreate from URL** | `recreation/from-web` |
| **Modify existing elements** (parent/before/clone/replace/delete) | + `blueprint/directives` |
| **Lines / arrows / flowcharts / dependency arrows / callouts** | + `blueprint/lines` |
| **Shaders** | + `blueprint/shaders/{overview,...}` |
| **Export to web with shaders** | + `webgl/overview` + relevant `webgl/*` shader |
| **Deep color / typography** | + `design/colors`, `design/typography` |
| **AI images** | + `images/prompts`, `images/templates` |
| **Answer a question** | relevant `reference/*` key |

design/blocks: `actions` (buttons), `layout` (hero/header/footer), `data-display` (cards/stats), `navigation`, `inputs` (forms), `feedback` (modals/toasts), `patterns`. When unsure, load all — they're small.

```
WRONG:  get_knowledge(keys: ["design/foundations"])
        ← "I'll load more if I need it" — you won't know what you're missing

RIGHT:  get_knowledge(keys: ["design-systems/core", "design/foundations", "design/colors",
          "design/typography", "design/blocks/actions", "design/blocks/layout"])
        get_knowledge(keys: ["design/blocks/data-display", "blueprint/components",
          "effects/glass", "blueprint/shaders/overview"])
```

### Available keys

- design-systems/{core, authoring, authoring-modes}
- blueprint/{core, layout, layout-patterns, paint, text, styled-ranges, effects, vectors, components, lines (straight lines, arrows, flowchart/dependency arrows, callouts), arcs (progress rings, donut/pie charts, activity meters, partial circles), images, commands, directives}
- blueprint/gradients/{linear, radial, angular}
- blueprint/shaders/{overview, metaballs, metal, irid, steel}
- design/{foundations, colors, typography, shadows, backgrounds, gradients, brand}
- design/blocks/{actions, inputs, navigation, data-display, feedback, layout, patterns}
- effects/{glass, neon, clay, dark-mode}
- charts/{tables, bar-charts, line-charts, sparklines, misc}
- images/{prompts, templates, integration}
- recreation/{from-image, from-web}
- reference/{shortcuts, tools, ui, editing, canvas, frames, text, vectors, components, styling, effects, export, design-systems, crop, shaders, canvases, layout-guides, ai}
- webgl/{overview, setup, metaballs, liquid-metal, holographic, liquid-stainless-steel, dithering, reactive-grid, color-adjust, noise-grain, halftone, pixelate, duotone, posterize, dither}

## Canvas Exploration

- `lookup` — find or read elements. Pass `scope` (canvas paths, element IDs, or `#refs`) to constrain, and/or filters (`query`, `textContent`, `type`, `fillColor`, `componentName`) to narrow. Default `format: "summary"` returns compact metadata; use `"blueprint"` (with optional `depth`) for full element trees. Examples: `lookup({query: "Card"})` discovery across canvases · `lookup({scope: ["#dashboard"], query: "Button"})` search a subtree · `lookup({scope: ["#card"], format: "blueprint"})` inspect a specific element. **NEVER** call `lookup` with no input on large repos — at least one of `scope` or a filter is required.
- `export` — visual check (png, jpeg, webp, svg, pdf)

## Rules

- **NEVER answer about Brilliant's capabilities from memory** — load relevant `reference/*` key first.
- Phosphor icons: `svg(icon:name)` or `<i data-icon="name">`, kebab-case. Regular and fill weights are bundled (`house`, `house-fill`); `-bold`/`-light`/`-thin`/`-duotone` fall back to regular.
- Feedback: `/feedback` in chat files directly to the Brilliant team.
