# Brilliant — AI Design Tool

Brilliant is a Figma-like 2D vector design tool. Auto layout, frames, groups, hug/fill/fixed sizing, fills, strokes, components — all work like Figma. This doc is the complete reference for working with Brilliant programmatically — the element DSL, available commands, design skills, and critical layout rules.

## Workflow: Load Skills, Then Build

Ask clarifying questions if the request is ambiguous — but once you know WHAT to build, start building immediately. Don't over-plan, don't describe what you're going to build, don't deliberate endlessly over choices. Load skills, make confident creative decisions (colors, fonts, layouts, copy), and build. The user can iterate after seeing a first draft.

## Session Context

Your session provides key values — use them in all element operations:

- **`canvasId`** — absolute path to the active `.design` file
- **`repoRoot`** — absolute path to the design repository root
- **`streamingApi`** — URL for batch element creation via POST
- **`wsElementsApi`** — WebSocket URL for progressive element creation (see below)

> Call `init()` to get these if they're not already in your context.

Repository structure:
```
{repoRoot}/
├── .brilliant/             # Repo settings
├── Assets/                 # Root-level assets (images)
├── Homepage.design         # Canvas files (YAML)
└── Projects/
    ├── Assets/             # Folder-level assets
    └── Dashboard.design
```

## Canvas Exploration

The initial context includes a canvas summary. For large canvases this is truncated — use these tools to explore efficiently:

| Need | Tool | Example |
|------|------|---------|
| Find elements by name/type/color | `search_elements` | `search_elements(fillColor: "#3B82F6")` |
| Inspect specific elements | `get_blueprint(elementIds: [...])` | Pass IDs from search results or context |
| Visual check | `export_to_png` | Render specific elements or regions |

**NEVER call `get_blueprint` without `elementIds` on a large canvas.** It returns the full canvas which can consume your entire context window in a single call. Use `search_elements` for discovery, then `get_blueprint(elementIds: [...])` for targeted detail.

### Cross-Canvas Search

Your session starts on **one canvas**, but the user's project may have many. When the user mentions an element you can't find on the current canvas, or asks about elements "everywhere" / "on all pages" / "on the dashboard" — use `search_elements` before asking the user which canvas. It searches all canvases by name, text content, type, fill color (perceptual matching — "find yellow elements"), or component usage (no `canvasId` required).

## CRITICAL: Brilliant MCP Tools Only

You may see MCP tools from other servers (e.g., `mcp__pencil__*`). **Ignore all non-Brilliant MCP tools for design tasks.** Only use `mcp__brilliant__*` tools.

Do NOT use:
- `get_style_guide` / `get_style_guide_tags` (Pencil — not Brilliant)
- `batch_get` / `batch_design` / `get_screenshot` (Pencil `.pen` file tools)
- Any tool prefixed with `mcp__pencil__`

Color, typography, and style direction come from the building skills (`COLORS.md`, `TYPOGRAPHY.md`, `TECHNIQUES.md`) — not from external style guide tools.

## CRITICAL: Load Skills Before You Build

Brilliant's domain knowledge is spread across **skill files** organized in a tree. You MUST load ALL relevant skills before calling `create_modify_elements`. Never build without loading skills first — designs without them are consistently generic and low quality.

**Use the `get_skill` tool** — e.g. `get_skill({ skill: "building" })` or `get_skill({ skill: "building/LAYOUTS" })` for a sub-skill.

**Tell the user what you're doing** — output a brief message before loading skills so they see activity instead of silence.

### Skill Tree

```
skills/
├── building/                    ← BUILDING KNOWLEDGE
│   ├── SKILL.md                 ← Entry point: bundled icon reference (ALWAYS load this)
│   ├── BUILDING_BLOCKS.md       ← Atomic UI components with DSL examples (ALWAYS load)
│   ├── LAYOUTS.md               ← Auto layout sizing rules, structural skeletons, debugging (ALWAYS load)
│   ├── TECHNIQUES.md            ← AI anti-patterns, design toolkit, DSL patterns, shadows, brand DNA (ALWAYS load)
│   ├── RECIPES.md               ← Effect combos, glass, neon, button states, dark mode, claymorphism (load for effects-heavy designs)
│   ├── DATA_VISUALIZATION.md    ← Charts, sparklines, tables, progress rings, heatmaps (load for data)
│   ├── COLORS.md                ← Deep color: palettes, psychology, gradients, dark mode
│   ├── TYPOGRAPHY.md            ← Deep type: scales, pairing, hierarchy, styled ranges
│   └── IMAGE_GENERATION.md     ← AI image gen: prompt engineering, quality settings, use-case templates
│
├── recreation/                  ← RECREATING FROM REFERENCES
│   ├── SKILL.md                 ← Entry point: sub-skill routing
│   └── IMAGE.md                 ← Recreating from screenshot/image — section-by-section building
│
├── knowledge/                   ← ANSWERING USER QUESTIONS (not building)
│   ├── SKILL.md                 ← Entry point with routing to sub-skills
│   ├── TOOLS.md                 ← Drawing tools, shortcuts, modifiers
│   ├── EDITING.md               ← Selection, move, resize, rotate, align, z-order
│   ├── FRAMES.md                ← Parent types, groups, auto layout, nesting
│   ├── TEXT.md                  ← Text editing, sizing modes, fonts, styled ranges
│   ├── STYLING.md               ← Colors, fills, strokes, opacity, corner radius
│   ├── CANVAS.md                ← Zoom, pan, snap guides, background modes
│   ├── UI.md                    ← Toolbars, command palette, color picker, menus
│   ├── COMPONENTS.md            ← Component masters, instances, overrides
│   ├── CANVASES.md              ← Canvas management, folders, import/export
│   ├── SHORTCUTS.md             ← Complete keyboard shortcut reference
│   ├── VECTORS.md               ← Pen tool, node editing, bezier handles
│   ├── EFFECTS.md               ← Shadow, glow, blur details
│   ├── DESIGN_SYSTEM.md         ← Tokens, .styles files
│   ├── AI.md                    ← AI commands, multi-provider chat, BYOK
│   ├── CROP.md                  ← Image crop mode, scale modes (Fill/Fit/Crop)
│   └── EXPORT.md                ← Export (PNG/JPEG/SVG/PDF), Copy As, import
│
└── assets/
    └── FONTS.md                 ← ~290 bundled Google Fonts catalog
```

### How to Load Skills

Look at the tree above, identify ALL files relevant to your task, and **load them all with `get_skill`**. Don't load the entry point first and then sub-skills — load everything at once.

**NEVER** launch an agent to read skills for you.
**ALWAYS** Use `get_skill` to load all relevant skill files.

> **Data products deserve data viz.** When the request involves analytics, dashboards, monitoring, or any data product — always include `DATA_VISUALIZATION.md` even if the task seems like "just a hero" or "just a landing page." Dashboard heroes should show sparklines and stat previews, not gray placeholder boxes.

| Task | Load ALL of these |
|------|-------------------|
| **Any design task** | `get_skill("building")` + `get_skill("building/BUILDING_BLOCKS")` + `get_skill("building/LAYOUTS")` + `get_skill("building/TECHNIQUES")` (foundation — always load) |
| **Effects-heavy designs** | Foundation + `get_skill("building/RECIPES")` (glass, neon, button states, dark mode, claymorphism, liquid glass) |
| **Dashboard / analytics** | Foundation + `get_skill("building/DATA_VISUALIZATION")` |
| **Recreating from image** | Foundation + `get_skill("recreation/IMAGE")` (section-by-section building, color/proportion matching) |
| **Deep color choices** | Add `get_skill("building/COLORS")` to any task where palette matters (branding, dark mode, data viz) |
| **Deep typography choices** | Add `get_skill("building/TYPOGRAPHY")` to any task where type matters (heroes, editorial, pricing) |
| **Design with real images** | Add `get_skill("building/IMAGE_GENERATION")` when design needs photos, product shots, textures, or illustrations |
| **Answer a question** | `get_skill("knowledge")` + relevant knowledge sub-skills |

```
WRONG:  User asks for pricing page → immediately call create_modify_elements
RIGHT:  User asks for pricing page → get_skill("building") + get_skill("building/BUILDING_BLOCKS") + get_skill("building/LAYOUTS") + get_skill("building/TECHNIQUES") → THEN build
```

## Streaming Element Creation (Preferred)

For element creation, **prefer the WebSocket streaming endpoint** over the `create_modify_elements` MCP tool. The WebSocket endpoint creates elements progressively — they appear on the canvas one-by-one as lines arrive, matching the hosted `<objects>` experience.

The `streamingApi` URL is provided in your session context from `init()`. Derive the WebSocket URL by replacing `http://` with `ws://` and `/api/stream-elements` with `/api/ws-elements`.

### How to use

Connect via WebSocket using `websocat`. Each line you send is processed and rendered immediately:

```bash
# Derive the WS URL from streamingApi
# e.g., streamingApi = http://127.0.0.1:3333/api/stream-elements
# → ws://127.0.0.1:3333/api/ws-elements?canvasId=CANVAS_ID

# Build an array of blueprint lines, then send each with a small delay
lines=(
  'al(v,g(16),pad(24)) p(100,100) s(hug,hug) f[(#FFFFFF)] st[(#E2E8F0,1)] rd(12) "Card"'
  '  t("Dashboard",Inter,24,b) f[(#0F172A)] "Title"'
  '  t("Welcome back",Inter,14) s(fill,hug) f[(#64748B)] "Subtitle"'
  '  al(h,a(c,c),pad(10,20)) s(hug,hug) f[(#3B82F6)] rd(8) "Button"'
  '    t("Get Started",Inter,14,sb) f[(#FFFFFF)] "Label"'
)

(for line in "${lines[@]}"; do echo "$line"; sleep 0.05; done) \
  | websocat -n "ws://127.0.0.1:3333/api/ws-elements?canvasId=CANVAS_ID"
```

Each line creates an element immediately. The `sleep 0.05` (50ms) delay between lines gives the canvas time to render each element progressively. Adjust the delay to control speed.

### Protocol

| Direction | Message | Description |
|-----------|---------|-------------|
| Client → Server | Blueprint line (text) | Parsed and created immediately |
| Server → Client | `{"type":"created","row":1,"id":"abc","name":"Card"}` | Element created |
| Server → Client | `{"type":"modified","row":2,"id":"abc"}` | Element modified |
| Server → Client | `{"type":"error","row":3,"message":"..."}` | Line failed |
| Client closes | — | Server ends undo group, finalizes |

### When to use each

- **WebSocket endpoint** — Large designs (5+ elements), new layouts, anything the user will watch being built
- **`create_modify_elements`** — Small modifications (1-3 elements), property changes on existing elements, when you need session ref (`#N`) resolution in follow-up tool calls
- **POST `/api/stream-elements`** — Batch creation without WebSocket (all elements appear at once, but faster than MCP round-trip)

### Fallback: POST endpoint

If `websocat` is not available, the POST endpoint still works for batch creation:

```bash
curl -s -X POST \
  'STREAMING_API_URL?canvasId=CANVAS_ID' \
  -H 'Content-Type: text/plain' \
  --data-binary @- <<'BLUEPRINT'
al(v,g(16),pad(24)) p(100,100) s(hug,hug) f[(#FFFFFF)] rd(12) "Card"
  t("Dashboard",Inter,24,b) f[(#0F172A)] "Title"
BLUEPRINT
```

## Building Skills

See the routing table above for which skills to load per task. ~290 bundled Google Fonts listed in `assets/FONTS.md`.
