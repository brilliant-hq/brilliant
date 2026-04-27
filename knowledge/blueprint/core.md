# Blueprint Core

One element per line, 2-space indent = child. Properties space-separated, any order.

## Annotated example

```
$brand=#E11D48
$neutral=#64748B
$spacing=4
$radius=8
$font=Inter
al(v,g($spacing.4),pad($spacing.6)) p(100,100) s(360,hug) f[(#FFF)] st[($neutral.20,w(1))] rd($radius.md) shadow(#000,o(0.06),y(2),blur(8)) "Card" #card
  t("Settings",$font,20,sb) f[($brand.90)] "Title" #title
  t("Manage preferences",$font,14) s(fill,hug) f[($neutral.50)] "Desc" #desc
  r s(fill,1) f[($neutral.20)] "Divider"
  al(h,x(sb),y(c),g($spacing.3),pad($spacing.none)) s(fill,hug) "Row" #row
    t("Dark mode",$font,14,m) f[($brand.80)] #label
    al(h,x(e),y(c),g($spacing.none),pad($spacing.1)) s(44,26) f[(#8B5CF6)] rd($radius.full) "Toggle" #toggle
      al(h,x(c),y(c),g($spacing.none),pad($spacing.none)) s(20,20) f[(#FFF)] rd($radius.full) shadow(#000,o(0.15),y(1),blur(2)) "Knob"
  al(h,x(c),y(c),g($spacing.2),pad($spacing.3,$spacing.4)) s(fill,hug) f[($brand.90)] rd($radius.sm) "Button" #btn
    svg(icon:check) s(16,16) f[(#FFF)] #icon
    t("Save",$font,14,sb) f[(#FFF)] #btn_label
```

Types (these are the ONLY valid types — no aliases like `rect`, `el`, `div`, `sq`, `sp`, `img`, `section`): `r` rect · `c` circle · `t("text",Font,size)` · `line(N)` geometric line of length N (use `rot()` for angle, `cap(_, ar)` for arrowhead) · `connect(#A,#B)` topological connector between two existing elements (see below) · `fr` frame · `gr` group · `al()` auto-layout · `svg(icon:name)` Phosphor icon · `v()` vector path (charts only, NOT icons) · `delete(id)` remove element.

Connectors: `connect(#A, #B)` — auto-routes a line between two existing refs. Resolved at end of block (refs must be defined somewhere in the same `create_modify_elements` call, even after the connect line). Use this for dependency arrows, flowcharts, sequence diagrams — NEVER hand-roll arrows with `v()` paths between elements.

**Defaults** (no params): `route(elbow)` + `avoid(all)`. The path picks an orthogonal shape AND dodges other elements between the endpoints. You usually want this — only override when you have a specific reason.

- `intent(dependency|flow|annotation)` — preset that seeds defaults for route, avoid, cap, and stroke. Explicit tokens always win.
  - `dependency` → elbow + endpoint avoidance + arrow cap + gray 1.5px stroke (Gantt deps, prerequisite chains)
  - `flow` → elbow + endpoint avoidance + arrow cap + dark 2px stroke (flowcharts, sequence steps)
  - `annotation` → straight + no avoid + no cap + gray 1px stroke (callouts, labels)
- `route(straight|elbow|elbow2|bezier)` — explicit shape. Default `elbow`. `elbow` = orthogonal routing (auto-promotes to 2 bends when both anchors share orientation, e.g. `from(r)`+`to(l)`, so endpoints stay perpendicular). `elbow2` = always 2 bends. `bezier` = smooth curve.
- `avoid(none|endpoints|all)` — obstacle behavior. Default `all`. `endpoints` only checks the source/target rects (cheap; handles weird anchor choices like `from(t)` with target below). `all` queries every element in the route's bounding region.
- `from(POS)` / `to(POS)` — explicit anchor on each endpoint. Three forms:
  - `from(r)` — bare side from the 9-cell grid: `tl t tr l c r bl b br`
  - `from(r, 0.25)` — side + fraction (0..1) along the edge: 25% down the right edge
  - `from(#child_id)` — anchor on a nested element by session ref (must be a descendant of the endpoint)
  - Omit `from`/`to` to auto-pick anchors. Same row → horizontal (`r↔l`). Different row → perpendicular entry on target (`r→t` for next-row dependency, `r→b` for previous-row). Same column → vertical (`b↔t`). This matches the Gantt/flowchart convention so arrows enter the next bar/card from above instead of overlapping its leading text.
- Stroke required for visibility — unless `intent` provides one. `cap(n,ar)` adds an arrowhead at the destination. A `connect()` with no `intent` and no `st[]` resolves to an invisible path and emits a warning.
- Placement: `connect()` at the top level auto-routes into the lowest common ancestor of its endpoints, so the connector inherits z-order and clipping from the same frame as the bars/cards it joins (e.g. a Gantt timeline, a flowchart canvas). To override — pin to a specific frame, or keep at root — indent under that frame or use `parent(#frame)`. When the resolved parent is an auto-layout frame, the connector is automatically marked `abs` so its computed path doesn't get displaced by flow rules (and doesn't push the surrounding rows around).
- Modify works the same way: `#dep connect(#A, #B, route(elbow2))` re-routes an existing connector.
- Examples:
  - `connect(#card1, #card2)` — defaults: elbow, full avoidance, auto anchors. Add `st[]` for visibility.
  - `connect(#card1, #card2, intent(dependency))` — bundles preset, no other params needed.
  - `connect(#card1, #card2, intent(dependency)) st[(#FF0000,w(3))]` — dependency preset but red 3px stroke instead of gray 1.5.
  - `connect(#A, #B, route(straight), avoid(none))` — opt out of smart behavior; draw a literal straight line.
  - `connect(#A, #B, from(#a_port), to(#b_port))` — anchor on nested ports.
Only `fr`, `gr`, `al()` can have children. `gr` without `s()` auto-fits to wrap its children tightly.
SVG sizing: `svg(icon:name) s(W,H)` — size goes in `s()`, NOT inside `svg()`. `svg(icon:check,w(16),h(16))` is WRONG.

Props (use these exact names — CSS names like `position()`, `width()`, `height()`, `background()`, `border()`, `opacity()` are NOT valid): `p(x,y)` position · `s(w,h)` size (number/fill/fill:N/hug) · `rd(N)` or `rd(TL,TR,BR,BL)` corners · `rot(N)` rotation · `o(N)` opacity · `clip` / `no-clip` (parents) · `abs` / `no-abs` absolute position (child ignores auto layout flow, use with `p(x,y)`; `no-abs` puts a previously-`abs` child back into flow) · `flip(h,v)` · `arc(start,sweep)` · `ratio(N)` inner radius · `scaleTo(w,N)` scale to width · `scaleTo(h,N)` scale to height · `cb(#hex)` recolor fills/strokes of children (excludes parent) · `tsm(auto|autoHeight|autoWidth|fixed)` text sizing mode · `front` / `front(N)` bring to front/forward N · `back` / `back(N)` send to back/backward N. Use `c` in `p()` to center: `p(c,c)`, `p(c,200)`, `p(100,c)`.

Auto-layout: `x()`, `y()`, `g()`, and `pad()` go INSIDE `al()` parentheses, comma-separated. They are NOT standalone tokens.
```
WRONG: al(v) pad(16) g(12)
RIGHT: al(v,g(12),pad(16))
```
Alignment: `x()` aligns along the X axis (horizontal), `y()` aligns along the Y axis (vertical). Values: `s` start · `c` center · `e` end · `sb` spaceBetween. The axes are physical and never flip with layout direction. Inside `al(h)`, `x()` is the main axis; inside `al(v)`, `y()` is the main axis. `sb` is only valid on the main axis (`x(sb)` with `al(h)`, `y(sb)` with `al(v)`). Bottom-center in a column = `y(e),x(c)`. Right-center in a row = `x(e),y(c)`.

Relative deltas (modify only): `p+(dx,dy)` offset position · `s+(dw,dh)` offset size · `rd+(n)` offset corner radius · `rot+(n)` offset rotation · `o+(n)` offset opacity.

IDs: Omit for new elements (auto-generated). Existing 16-char hex ID as first token = modify. `#ref` trailing = assign, leading = modify by ref. `override(#ref)` for child overrides inside `clone()`/`inst()`. `"quoted"` trailing = name (label only — names CANNOT be used to modify elements). **Assign `#ref` to ALL text, icons, and content elements** — without a ref you cannot modify them later, forcing delete+recreate. Refs are free; missing refs are expensive.

Comments: `//` or `--` on their own line are ignored. Inline comments are NOT supported (`r s(50,50) // comment` will error).

⚠ Text fill defaults to white — always set `f[(#hex)]`. Text defaults to `hug` width (single line, never wraps). This is correct for labels, values, and headings. Use `s(fill,hug)` only when the text content may be wider than its parent — descriptions, subtitles, paragraphs — so it wraps instead of overflowing. `pad()` and `g()` are **required** on every `al()` — use `$spacing.none` for zero. Delete with `delete(#ref)` directive, not `execute_commands`.

⚠ **Modify = flat, one line per element.** Each line is routed independently: has ID or `#ref` as first token → **modify**; no ID → **create**. Indenting a modify line reparents it (breaks layout). Indenting a line without an ID/ref creates a duplicate child.
```
WRONG — creates a duplicate child (no ID/ref = always create):
#card f[(#FF0000)]
  t("New title",Inter,20,b) f[(#000)]

WRONG — reparents title (breaks nested layout):
#card f[(#FF0000)]
  #title t("New title",Inter,20,b) f[(#000)]

RIGHT — modifies each element flat:
#card f[(#FF0000)]
#title t("New title",Inter,20,b) f[(#000)]
```
To reparent, use `parent()`: `#title parent(#other_card)`

⚠ **Use `$var` seeds + iteration.** Every design should start with seeds — color (`$brand=#E11D48`, `$neutral=#64748B`), spacing (`$spacing=4`), radius (`$radius=8`). Each seed auto-generates a scale of values. For 3+ near-identical elements driven by tabular data (calendar days, stat tiles, swatches, nav items), reach for `for(...)` — it expands to comp+inst automatically. Drop to manual `comp + inst()` only when iterations differ heavily in shape. See `blueprint/variables` and `blueprint/components` for full syntax.
