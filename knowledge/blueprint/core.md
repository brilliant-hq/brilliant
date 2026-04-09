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
  al(h,a(sb,c),g($spacing.3),pad($spacing.none)) s(fill,hug) "Row" #row
    t("Dark mode",$font,14,m) f[($brand.80)] #label
    al(h,a(e,c),g($spacing.none),pad($spacing.1)) s(44,26) f[(#8B5CF6)] rd($radius.full) "Toggle" #toggle
      al(h,a(c,c),g($spacing.none),pad($spacing.none)) s(20,20) f[(#FFF)] rd($radius.full) shadow(#000,o(0.15),y(1),blur(2)) "Knob"
  al(h,a(c,c),g($spacing.2),pad($spacing.3,$spacing.4)) s(fill,hug) f[($brand.90)] rd($radius.sm) "Button" #btn
    svg(icon:check) s(16,16) f[(#FFF)] #icon
    t("Save",$font,14,sb) f[(#FFF)] #btn_label
```

Types (these are the ONLY valid types — no aliases like `rect`, `el`, `div`, `sq`, `sp`, `img`, `section`): `r` rect · `c` circle · `t("text",Font,size)` · `l` line (2-node vector) · `fr` frame · `gr` group · `al()` auto-layout · `svg(icon:name)` Phosphor icon · `v()` vector path (charts only, NOT icons) · `delete(id)` remove element.
Only `fr`, `gr`, `al()` can have children. `gr` without `s()` auto-fits to wrap its children tightly.
SVG sizing: `svg(icon:name) s(W,H)` — size goes in `s()`, NOT inside `svg()`. `svg(icon:check,w(16),h(16))` is WRONG.

Props (use these exact names — CSS names like `position()`, `width()`, `height()`, `background()`, `border()`, `opacity()` are NOT valid): `p(x,y)` position · `s(w,h)` size (number/fill/fill:N/hug) · `rd(N)` or `rd(TL,TR,BR,BL)` corners · `rot(N)` rotation · `o(N)` opacity · `clip` (parents) · `abs` absolute position (child ignores auto layout flow, use with `p(x,y)`) · `flip(h,v)` · `arc(start,sweep)` · `ratio(N)` inner radius · `scaleTo(w,N)` scale to width · `scaleTo(h,N)` scale to height · `cb(#hex)` recolor fills/strokes of children (excludes parent) · `tsm(auto|autoHeight|autoWidth|fixed)` text sizing mode · `front` / `front(N)` bring to front/forward N · `back` / `back(N)` send to back/backward N. Use `c` in `p()` to center: `p(c,c)`, `p(c,200)`, `p(100,c)`.

Auto-layout: `a()`, `g()`, and `pad()` go INSIDE `al()` parentheses, comma-separated. They are NOT standalone tokens.
```
WRONG: al(v) pad(16) g(12)
RIGHT: al(v,g(12),pad(16))
```
Alignment `a(main,cross)`: `s` start · `c` center · `e` end · `sb` spaceBetween (main only). `al(v)` main = vertical, cross = horizontal. `al(h)` main = horizontal, cross = vertical. Bottom-center in a column = `a(e,c)` NOT `a(c,e)`. Don't think in `(x,y)` — think in `(main,cross)`.

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

⚠ **Use `$var` seeds + components.** Every design should start with seeds — color (`$brand=#E11D48`, `$neutral=#64748B`), spacing (`$spacing=4`), radius (`$radius=8`). Each seed auto-generates a scale of values. Use `comp` + `inst()` for repeated structure (cards, rows, tabs). See `blueprint/variables` and `blueprint/components` for full syntax.
