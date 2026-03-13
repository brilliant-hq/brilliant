# Blueprint Core

One element per line, 2-space indent = child. Properties space-separated, any order.

## Annotated example

```
al(v,g(16),pad(24)) p(100,100) s(360,hug) f[(#FFF)] st[(#E2E8F0,w(1))] rd(12) shadow(#000,o(0.06),y(2),blur(8)) "Card" #card
  t("Settings",Inter,20,sb) f[(#0F172A)] "Title"
  t("Manage preferences",Inter,14) s(fill,hug) f[(#64748B)] "Desc"
  r s(fill,1) f[(#E2E8F0)] "Divider"
  al(h,a(sb,c)) s(fill,hug) "Row"
    t("Dark mode",Inter,14,m) f[(#334155)]
    c s(20,20) f[(#8B5CF6)] rd(9999) "Dot"
  al(h,a(c,c),g(8),pad(10,20)) s(fill,hug) f[(#0F172A)] rd(8) "Button"
    svg(icon:check) s(16,16) f[(#FFF)]
    t("Save",Inter,14,sb) f[(#FFF)]
```

Types: `r` rect · `c` circle · `t("text",Font,size)` · `l` line · `fr` frame · `gr` group · `al()` auto-layout · `svg(icon:name)` Phosphor icon · `v()` vector path (charts only, NOT icons) · `delete(id)` remove element.
Only `fr`, `gr`, `al()` can have children. `gr` without `s()` auto-fits to wrap its children tightly.

Props: `p(x,y)` position · `s(w,h)` size (number/fill/fill:N/hug) · `rd(N)` or `rd(TL,TR,BR,BL)` corners · `rot(N)` rotation · `o(N)` opacity · `clip` (parents) · `flip(h,v)` · `arc(start,sweep)` · `ratio(N)` inner radius · `scaleTo(w,N)` scale to width · `scaleTo(h,N)` scale to height · `cb(#hex)` recolor fills/strokes of children (excludes parent) · `tsm(auto|autoHeight|autoWidth|fixed)` text sizing mode · `front` / `front(N)` bring to front/forward N · `back` / `back(N)` send to back/backward N.

Auto-layout alignment `a(main,cross)`: `s` start · `c` center · `e` end · `sb` spaceBetween (main only). `al(v)` main = vertical, cross = horizontal. `al(h)` main = horizontal, cross = vertical. Bottom-center in a column = `a(e,c)` NOT `a(c,e)`. Don't think in `(x,y)` — think in `(main,cross)`.

Relative deltas (modify only): `p+(dx,dy)` offset position · `s+(dw,dh)` offset size · `rd+(n)` offset corner radius · `rot+(n)` offset rotation · `o+(n)` offset opacity.

IDs: Omit for new elements (auto-generated). Existing 16-char hex ID as first token = modify. `#ref` trailing = assign, leading = modify by ref. `override(#ref)` for child overrides inside `clone()`/`inst()`. `"quoted"` trailing = name. **Assign `#ref` to any element you may modify later** — without a ref or ID you cannot target it.

⚠ Text fill defaults to white — always set `f[(#hex)]`. Text defaults to `hug` width (single line, never wraps). This is correct for labels, values, and headings. Use `s(fill,hug)` only when the text content may be wider than its parent — descriptions, subtitles, paragraphs — so it wraps instead of overflowing. `pad()`/`g()` only work inside `al()`. Modifications go flat (no indent) unless reparenting. Indenting a NEW element (no ID/ref) under a parent **creates** a child — it does NOT replace existing children. To change an existing child, use its ID or `#ref` as first token, flat. Delete with `delete(#ref)` directive, not `execute_commands`.

⚠ **Use components for repeated structure.** Default to `comp` + `inst()` whenever you'd write similar elements more than once — cards in a grid, table rows, tabs, nav items, stat tiles, chart columns, toggle states. Make the first a master (`comp`), stamp out the rest as `inst()`. Instances cut token cost ~in half, render faster, and keep the design consistent for free. See `blueprint/components` for full syntax.
