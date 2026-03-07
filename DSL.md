## Element Format Reference

`create_modify_elements` accepts one element per line, indentation (2 spaces) for hierarchy. Properties are space-separated — order doesn't matter. Two syntax patterns: `name(params)` for records, `name[items]` for arrays. See BUILDING_BLOCKS.md for full examples of every pattern below.

### Line Structure

```
{id} {type} {properties...} ["name"]
```

- **ID**: 16-character hex string. New ID + type = create. Existing ID = modify (only provided fields change).
- **`match("Name")`** — modifies ALL elements matching that name (case-sensitive).
- **Name**: Optional trailing `"quoted string"`.

### Element Types

| Type | Notes |
|------|-------|
| `r` | Rectangle |
| `c` | Ellipse — add `arc(start,sweep)` for arcs, `ratio(N)` for donuts |
| `t("content",family,size,<params>)` | Text — content + font inline, then weight/align/lh/ls in any order |
| `l` | Line — strokes only, no fills |
| `fr` | Frame — fixed/fill/hug sizing. Elements auto-reparent into frames when dragged |
| `gr` | Group — always hug×hug. Changing sizing from hug to fixed converts to frame |
| `al(dir,a(main,cross),g(N),pad(N))` | Auto-layout frame — children positioned by layout engine |
| `v(nodes[...],edges[...],closed)` | Vector path — for sparklines/charts, NOT icons |
| `svg(source)` | SVG import — source: `icon:name`, URL, or local path |

`fr`, `gr`, and `al()` are **parent types** — they can have children. No other type can. For text inside a shape, use `al()` with `rd(9999)` for circles.

### Vectors

`v(nodes[(id,x,y,type),...],edges[(id,nodeA,nodeB,haX,haY,hbX,hbY),...],closed)`

**Node types:** `st` (straight, default) · `mi` (mirrored/smooth) · `as` (asymmetric) · `di` (disconnected)

**Auto-smooth curves:** Mark nodes as `mi` for automatic smooth bezier handles — no manual handle coordinates needed. The system computes tangent-based handles at 30% of edge length. Edges without explicit handles default to `(0,0,0,0)` and are auto-computed for `mi` nodes. If edges are omitted entirely, they're generated sequentially (node 0→1→2→...).

```
v(nodes[(0,0,20,mi),(1,30,8,mi),(2,60,6,mi)]) s(60,24) st[(#3B82F6,1.5)]
```

For area fills, close the path with straight bottom nodes (default `st`):
```
v(nodes[(0,0,20,mi),(1,30,8,mi),(2,60,6,mi),(3,60,24),(4,0,24)],edges[(0,0,1),(1,1,2),(2,2,3),(3,3,4),(4,4,0)],closed)
```

### Properties

`p(x,y)` position · `s(w,h)` size (`number`/`fill`/`fill:N`/`hug`) · `rot(N)` rotation · `skew(x,y)` · `flip(h,v)` (1/0) · `clip` (parents only) · `o(N)` opacity · `rd(N)` or `rd(TL,TR,BR,BL)` corner radius · `arc(start,sweep)` circle arc (start=degrees 0–360, sweep=percentage 0–100) · `ratio(N)` circle inner radius fraction (0–1, for donut/ring shapes)

`fill:N` — flex-weighted fill. `fill:3` + `fill:1` siblings = 75%/25% split. Plain `fill` = flex 1.

### Text

`t("content",family,size,<params>)` — first 3 positional (content, font, size), then remaining params in any order: weights `r/m/sb/b/eb/bl`, align `l/c/r/j`, `lh(N)`, `ls(N)`. `lh(N)` is a **multiplier** of font size (e.g., `lh(1.5)` = 1.5x font size). Bare flags: `italic`, `underline`. Escapes: `\n` newline, `\"` quote, `\uXXXX` unicode.

**Styled ranges** — `spans[...]` continuation line for mixed formatting. Use text-match syntax:
```
a1b2c3d4 t("Get started for free today",Inter,18)
  spans[("Get started",b),("free",b,#3B82F6)]
```
Duplicate words: add 0-based occurrence index — `("the",0,b),("the",1,i)`. Mods: `b` `i` `u` `w(N)` `s(N)` `f(family)` `#hex`.

### Fills

`f[(spec),...]` — multiple fills stack in order. IDs are optional (auto-generated). Multi: `f[(#3B82F6),(inner(#000,0.3,0,2,4))]`

**Solid:** `(#hex)` · `(solid(#hex,0.8))` with opacity

**Linear gradient** — directional sweep: `(linear())` default (180°, black→white) · `(linear(angle,#start,#end))` · `(linear(#start,#end))` default 180° · `(linear(angle,stop(#hex,pos),...))` with stops

**Radial gradient** — point-source light: `(radial())` default (centered, white→black) · `(radial(#center,#edge))` · `(radial(solid(#hex,0.3),solid(#hex,0)))` with opacity · `(radial(cx(25),cy(15),r(50),#hex,#hex))` named % (cx/cy: 0=left/top, 50=center; r/rx/ry: 50=edge from center) · `(radial(rx(80),ry(40),#hex,#hex))` elliptical · `(radial(cx,cy,rx,ry,stop(#hex,pos),...))` positional

**Angular gradient** — colors sweep around a center point (conic/sweep): `(angular())` default (centered, black→white) · `(angular(#start,#end))` · `(angular(cx,cy,ax,ay,stop(#hex,pos),...))` full · `(angular(cx,cy,ax,ay,w(wx,wy),stop(#hex,pos),...))` elliptical

**Image:** `(img(path))`

**Effects as fills:** `(inner())` inner shadow · `(inner(#hex,opacity,offsetX,offsetY,blur))` custom · `(glow())` inner glow · `(glow(#hex,opacity,blur))` custom · `(blur())` background blur · `(blur(16))` custom radius · named: `sp(n)` spread, `blend(mode)`

**Shaders:** `(metaballs())` defaults · `(metaballs(#hex,...,count(n),size(n),speed(n)))` custom

### Region Fills (Vectors)

Vectors with multiple closed regions show per-region sub-paths as `vr()` continuation lines:
```
abc123 v() s(200,200) "Logo"
  vr(r1, M0,0 C50,-20 100,0 100,100 C50,120 0,100 0,0 Z) f[(#FF6611)]
  vr(r2, M30,30 L70,30 L70,70 L30,70 Z) f[(inner(#000,0.3,0,2,4))]
  vr(r3, M40,40 L60,40 L60,60 L40,60 Z) hole
```

- Each `vr(rN, path)` shows a region's boundary as SVG path data + its fills
- `r1` = largest region, `r2` = next, etc. — ordered by area
- `hole` = cutout region (transparency)
- All fill types work per-region: solid, gradient, shader, inner shadow, glow, blur, image
- To modify fills: `vr(rN) f[...]` — geometry not needed, just the region ID
- Flat `f[...]` on the element line still applies to all regions uniformly

### Strokes

`st[(paintStyle,width,startCap,endCap,position),...]` — IDs are optional (auto-generated). Trailing defaults can be omitted. **Strokes support ALL fill types** — solid, gradients, and shaders.

- `st[(#E5E7EB,1)]` — 1pt solid, all defaults
- `st[(solid(#3B82F6,0.5),2)]` — 50% opacity stroke
- `st[(linear(90,#3B82F6,#8B5CF6),2)]` — gradient stroke
- `st[(metal(),2)]` — liquid metal shader stroke
- `st[(holo(intensity(0.5)),3)]` — holographic shader stroke
- Caps: `n` none, `r` round, `sq` square, `ar` arrow — e.g. `st[(#000,2,n,ar)]`
- Position: `c` center, `i` inside, `o` outside — e.g. `st[(#000,1,r,r,i)]`

### Effects (Drop Shadow, Outer Glow, Element Blur)

Element-level effects — stack multiple on the same element. All params are named and optional.

- `shadow()` — drop shadow (defaults: #000, 0.25 opacity, 0/4 offset, 8 blur)
- `shadow(#3B82F6,o(0.15),y(2),blur(12))` — blue shadow, custom params
- `shadow(#000,o(0.06),blur(4)) shadow(#000,o(0.10),y(8),blur(24))` — layered shadows
- `outerglow()` — outer glow (defaults: #FFF, 0.6 opacity, 8 blur, screen blend)
- `outerglow(#3B82F6,o(0.3),blur(16))` — blue glow
- `eblur(4)` — element blur (radius 4)

Named params: `o(N)` opacity, `x(N)` offsetX, `y(N)` offsetY, `blur(N)` blur radius, `sp(N)` spread, `blend(mode)` blend mode. Bare `#hex` is color.

**Key distinction:** `shadow()`/`outerglow()`/`eblur()` are element-level effects. `inner()`/`glow()`/`blur()` are fill types in `f[...]` — they participate in fill z-ordering.

### Directives

| Directive | Syntax | Description |
|-----------|--------|-------------|
| Clone | `clone(sourceId)` | Deep copy including children. Indent child lines to override cloned children |
| Replace | `replace(elementId)` | Atomically delete old + insert new at same position |
| Insert before | `before(siblingId)` | Position before a sibling — works on both create and modify lines |

**Reordering existing elements:** Use `before()` on a modify line to move an element before a sibling. Same parent = reorder; different parent = reparent + position. Example: `abc123 before(def456)` moves element `abc123` before `def456`.

### Reparenting Existing Elements

To move an element into a different parent, **indent its modify line under the new parent**. The parser detects the parent change and reparents automatically — coordinates transform to the target's local space.

```
# Move #5 and #6 into #2 (appends to end of #2's children)
#2
  #5
  #6

# Reparent #8 into #3, and also change its fill
#3
  #8 f[(#FF0000)]

# Reparent #10 before a specific sibling in the new parent
#10 before(#11)
```

**Never delete and recreate elements to move them between parents** — reparenting preserves element IDs, undo history, and is significantly more efficient.

### Creating Variations with `clone()`

**To create variations of an existing element, use `clone()` with indented child overrides.** This is the correct approach — never recreate elements from scratch or use duplicate + modify workflows.

`clone(sourceId)` deep-copies the source element and all its children (with new IDs). Indent child lines under the clone to override cloned children — matched by original child ID or by name.

```
clone(abc123) p(400,0) "Card — Dark Theme"
  def456 f[(#1E293B)]
  match("Title") f[(#F8FAFC)]

clone(abc123) p(800,0) "Card — Gradient"
  def456 f[(linear(135,#6366F1,#EC4899))]
```

- **Top-level overrides** (position, size, name, fills) apply to the cloned parent
- **Indented child overrides** match by original child ID (translated to cloned child) or by `match("Name")`
- All variations in one `create_modify_elements` call — no need for separate duplicate + modify steps
- The original element is untouched — each clone is independent

### Modifying Elements

When modifying existing elements, **list all modifications flat at depth 0** — one line per element, no indentation hierarchy. Re-expressing the parent-child hierarchy with indentation would accidentally trigger reparenting.

```
WRONG — re-nesting modifications (accidentally reparents #10 into #4):
#4 s(800,hug)
  #10 f[(#FF0000)]
    #11 t("Updated")

RIGHT — flat modifications (no parent changes):
#4 s(800,hug)
#10 f[(#FF0000)]
#11 t("Updated")
```

**Exception — intentional reparenting:** Indent a modify line under a new parent to reparent it (see "Reparenting Existing Elements" above). Only indent when you specifically want to change an element's parent.

**Always verify modifications with a preview.** After modifying elements, pass `previewIds` (with the modified element IDs) and `previewScale: 2` to confirm the changes look correct. This is especially important for size and layout changes where the result may not match expectations.

### SVG Import

`svg(icon:house)` bundled Phosphor · `svg(https://...)` URL (fetched at import — don't `curl` to `/tmp/`) · `svg(/tmp/file.svg)` local. Fills/strokes on SVG lines override imported fills/strokes — all fill types work (solid, shader, gradient, image). Example: `svg(icon:house) f[(#3B82F6)]`, `svg(https://...) f[(metal())]`. To recolor after creation, use `recolor_children` command.

#### Bundled Phosphor Icons (324)

**Never guess icon names.** The full categorized list is in `building/SKILL.md` (always loaded for design tasks). Use `svg(icon:name)` syntax.

#### Other Icon Libraries (via URL)

- Phosphor CDN: `svg(https://unpkg.com/@phosphor-icons/core/assets/regular/{name}.svg)`
- Lucide: `svg(https://unpkg.com/lucide-static@latest/icons/{name}.svg)`
- Simple Icons (monochrome brands): `svg(https://unpkg.com/simple-icons@latest/icons/{slug}.svg)`
- Wikimedia (full-color logos, flags): `svg(https://commons.wikimedia.org/wiki/Special:Redirect/file/{Filename}.svg)`

### Images

| Source | Fill Syntax |
|--------|-------------|
| Photos | `f[(img(https://picsum.photos/id/{n}/800/400))]` |
| Avatars | `f[(img(https://i.pravatar.cc/150?img={n}))]` |
| Letter avatars | `f[(img(https://ui-avatars.com/api/?name=John+Smith&size=150&background=3B82F6&color=fff))]` |
| SVG avatars | Use `svg(https://api.dicebear.com/9.x/notionists/svg?seed={name})` |

### AI Image Generation (`generate_image`)

Generate custom images with Nano Banana 2 (Gemini Image). The tool saves the image to the project Assets folder and returns an `assetPath` for use in fills: `f[(img(assetPath))]`.

**Parameters:** `prompt` (required), `canvasId` (required), `aspectRatio`, `imageSize`, `referenceElementIds`

| Quality | imageSize | Speed |
|---------|-----------|-------|
| Quick draft | `"1K"` | ~5s |
| High quality | `"2K"` | ~15-20s |
| Maximum quality | `"4K"` | Slowest |

**Aspect ratios:** `1:1` (default), `3:2`, `2:3`, `3:4`, `4:3`, `4:5`, `5:4`, `9:16`, `16:9`, `21:9`, `1:4`, `4:1`, `1:8`, `8:1`

**Workflow:** Generate → get `assetPath` → place on canvas: `r s(400,300) f[(img(assetPath))] rd(8) clip "Hero Image"`

**Prompt tips:** Write descriptive paragraphs (not keywords). Include subject, style, composition, lighting. Be specific. For text in images, state the exact text. For reference-based edits, change one thing at a time.

## execute_commands

```json
{ "canvasId": "...", "commands": [{ "commandId": "...", "elementIds": [...], "params": {...} }], "previewIds": [...], "previewScale": 2 }
```

Multiple commands execute sequentially in one call.

**Selection & Lifecycle:** `select_elements`, `deselect_all`, `delete_command`, `duplicate_elements`, `cut`, `rename_layer` (params: `{ "value": "Name" }`)

**Move:** `move_elements` (params: `{ "dx": 50, "dy": -20 }`)

**Align (2+ elements):** `align_left`, `align_right`, `align_top`, `align_bottom`, `align_horizontally`, `align_vertically`

**Center on canvas:** `center_horizontally`, `center_vertically`

**Distribute (3+):** `distribute_horizontally`, `distribute_vertically`

**Z-Order:** `bring_to_front`, `send_to_back`, `bring_forward`, `send_backward`

**Group:** `group`, `add_auto_layout`, `ungroup`

**Flip & Scale:** `flip_horizontally`, `flip_vertically`, `scale_elements_to_width`, `scale_elements_to_height` (params: `{ "value": N }`)

**Skew:** `skew_elements` (params: `{ "skewX": -8.0, "skewY": 0.0 }`)

**Layout:** `set_width_sizing_mode`, `set_height_sizing_mode` (params: `{ "value": "fill"|"hug"|"fixed" }`), `set_layout_direction` (params: `{ "value": "horizontal"|"vertical" }`), `draggable_set_item_spacing`, `draggable_set_all_padding` (params: `{ "value": N }`), `set_layout_main_axis_alignment`, `set_layout_cross_axis_alignment` (params: `{ "value": "start"|"center"|"end"|"spaceBetween" }`)

**Text:** `align_text_left`, `align_text_center`, `align_text_right`, `set_text_sizing_mode` (params: `{ "value": "autoSize"|"autoHeight"|"fixedSize" }`)

**Recolor:** `recolor_children` (params: `{ "color": "#hex" }`) — recursively recolors all fills/strokes on element and descendants.

**Import:**  `import_figma` (params: `{ "figmaUrl": "https://www.figma.com/design/{{FILE_KEY}}/Name" }` — imports a Figma file with the given URL; opens browser sign-in if needed).

**Canvas:** `create_canvas` (params: `{ "fullPath": "Projects/Name" }`), `get_canvases`, `rename_canvas`, `delete_canvas`, `duplicate_canvas`, `create_folder`, `delete_folder`, `create_structure`.

**Background:** `set_background_color` (params: `{ "value": "#hex" }`) — automatically enables background visibility if it was off. Only change the canvas background if the user explicitly asks or it's clearly needed to resolve the user's request.

**Provider API Keys:** `set_anthropic_api_key`, `set_openai_api_key`, `set_google_api_key`, `set_openrouter_api_key` — opens the API key input for the given provider. The user pastes their key, it's validated and saved securely.

**Keybindings:** `list_keybindings` (params: `{ "group": "drawingToolsAndShapes", "search": "align" }` both optional — `group` filters by command group, `search` is a case-insensitive regex matched against id/name/description), `set_keybinding` (params: `{ "bindings": [{ "commandId": "change_tool_pen", "key": "P", "modifiers": ["shift"] }] }` — batch set; omit key/modifiers to clear). Group names: `drawingToolsAndShapes`, `colorManagement`, `size`, `cornerRadius`, `scale`, `moveElements`, `transformationAndAlignment`, `selectionAndEditing`, `canvasManagement`, `undoAndRedo`, `applicationControl`, `views`, `text`, `windowManagement`, `canvasManagement`, `layout`.

## Reading Canvas State

Every `create_modify_elements` and `execute_commands` response includes a `blueprint` field with element names and IDs in the same format as the DSL input. **Use these IDs for subsequent operations** — don't re-read the canvas.

If you need the full canvas state, use `get_blueprint` (with no `elementIds` — but only on small canvases). For targeted inspection, pass specific `elementIds`.

## DSL Gotchas

1. **Default text fill is white.** If you omit the fill on a text element, it renders white (invisible on light backgrounds). Always specify text fill color.
2. **SVG fills are creation-only overrides.** Fills/strokes on SVG lines replace existing fills/strokes in the imported SVG at import time. They work with all fill types (solid, shader, gradient, image). To recolor after creation, use `recolor_children` command.
3. **`pad()` and `g()` are NOT standalone properties.** They only work inside `al()` — e.g. `al(v,g(16),pad(24))`. Writing `pad(0,80)` or `g(16)` outside `al()` is silently ignored. Standalone properties are: `p()`, `s()`, `rot()`, `skew()`, `flip()`, `clip`, `o()`, `rd()`, `arc()`, `ratio()`, `shadow()`, `outerglow()`, `eblur()`.
4. **Two effect systems — don't confuse them.** `shadow()`/`outerglow()`/`eblur()` are standalone element-level effects. `inner()`/`glow()`/`blur()` go inside `f[...]` as fill types. Writing `shadow()` inside `f[...]` or `inner()` as a standalone token won't work.
5. **Modifications go flat, not nested.** When modifying existing elements, list each at depth 0 — indentation triggers reparenting. Only indent modify lines to intentionally reparent, create new children, or override children inside a `clone()` line. Never delete and recreate elements to move them — use reparenting instead.
6. **Preview after modify.** Always pass `previewIds` + `previewScale: 2` after modifying elements, especially for size/layout changes. Don't iterate blindly — verify visually.
