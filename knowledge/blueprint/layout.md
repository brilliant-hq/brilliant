---
assumes: blueprint/core
dsl: [fill, hug]
---
# Blueprint Layout

Every level: direction `al(v)` or `al(h)`, sizing `hug`/`fill`/`fixed`, spacing `pad()` + `g()`. **Always specify `g()` and `pad()`.** Use `g($spacing.none)` and `pad($spacing.none)` when you intentionally want zero (children touch, e.g. progress bar segments, table rows).

## Wrap
`al(h,wrap,g(8),pad(12))` — children that overflow the main axis flow to the next row/column (CSS `flex-wrap: wrap`). Same gap between rows as between items. Requires fixed/fill main-axis size (hug has nothing to wrap against). Fill children fill their row, not the frame.

## Layout in action

```
$brand=#14B8A6
$neutral=#64748B
$spacing=4
$radius=8
$font=Inter
al(v,g($spacing.6),pad($spacing.8)) s(400,hug) "Page" #page               ← v=vertical, g=gap, pad=padding
  al(h,x(sb),y(c),g($spacing.4),pad($spacing.none)) s(fill,hug) "Header" #header              ← sb=spaceBetween, fill=stretch to parent
    t("Logo",$font,18,b) f[($brand.90)] #logo
    al(h,g($spacing.2),pad($spacing.none)) s(hug,hug) "Nav" #nav              ← hug=shrink to content
      t("Home",$font,14,m) f[($neutral.50)] #nav_home
      t("About",$font,14,m) f[($neutral.50)] #nav_about
  al(h,g($spacing.4),pad($spacing.none)) s(fill,hug) "Content" #content
    al(v,g($spacing.3),pad($spacing.none)) s(fill:2,hug) "Main" #main         ← fill:2 = 2/3 width
      t("Welcome back",$font,24,sb) f[($brand.90)] #heading
      t("Here's what happened today",$font,14) s(fill,hug) f[($neutral.50)] #subhead  ← s(fill,hug) = text wraps
    al(v,g($spacing.3),pad($spacing.4)) s(fill:1,hug) f[($neutral.5)] rd($radius.sm) "Sidebar" #sidebar  ← fill:1 = 1/3 width
      t("Quick stats",$font,14,sb) f[($brand.90)] #sidebar_title
      t("Overview of today",$font,13) s(fill,hug) f[($neutral.50)] #sidebar_desc
```

## Sizing: `s(W,H)` — "who decides this size?"
Content → `hug` (default for text, buttons). Parent → `fill`. Design spec → fixed number. `fill:N` for proportional splits (fill:3 + fill:1 = 75/25%).

Typical sizing: root component fixed-or-hug/hug · label/value omit `s()` · prose `s(fill,hug)` · nested frame in v-parent fill/hug · button hug/hug · icon/avatar fixed/fixed · equal-width siblings all `fill`.

⚠ **Fill inside hug = collapses to 0.** A `fill` child needs a `fixed` or `fill` ancestor on that axis. Cross-axis fill always works. Fill inheritance: walk up the main-axis chain — hit `fixed` before `hug` → fill works; hit `hug` first → collapses. `al(v)`: fill-width child needs parent with fixed/fill width. `al(h)`: fill-height child needs parent with fixed/fill height.

## Spacing
`pad(N)` uniform · `pad(V,H)` vertical/horizontal · `pad(T,R,B,L)` all four edges. 3 values is NOT valid. `g(N)` between children. Both on the **parent**, inside `al()`.
Gaps: 2-4 tightly coupled · 6-8 related items · 12-16 siblings in section · 20-32 major groups · 40-64 page-level.

## Centering and absolute positioning
Use `c` in `p()` to center a child: `p(c,c)` centers both axes, `p(c,20)` centers horizontally at fixed y, `p(20,c)` centers vertically at fixed x. Two cases:
- Inside a `fr` or `gr` parent: `p(c,c)` works directly (the child is positioned absolutely inside the frame).
- Inside an auto-layout parent (`al(...)`): centering only applies to children that opt out of flow with `abs` — write `abs p(c,c)`. Without `abs`, auto-layout overrides the position and `p()` is ignored.

```
fr s(120,120) f[(#1E293B)] rd(12)
  t("center",Inter,13,sb) p(c,c) f[(#FFF)]
fr s(120,120) f[(#1E293B)] rd(12)
  t("center",Inter,13,sb) p(c,20) f[(#FFF)]
fr s(120,120) f[(#1E293B)] rd(12)
  t("center",Inter,13,sb) p(20,c) f[(#FFF)]
```

## Absolute positioning: `abs`
`abs` lets a child ignore auto layout flow while staying nested in the frame. The child positions freely with `p(x,y)` — it doesn't affect siblings, spacing, or hug sizing.

```
al(v,g(12),pad(16)) s(240,hug) f[(#FFF)] rd(8) "Card"
  t("Title",Inter,16,sb) f[(#000)]
  t("Description",Inter,14) s(fill,hug) f[(#666)]
  al(h,x(c),y(c),g($spacing.none),pad($spacing.1,$spacing.3)) abs p(204,-12) s(hug,hug) f[(#EF4444)] rd(99) "Badge"
    t("New",Inter,11,sb) f[(#FFF)]
```

Use `abs` for badges, notification dots, floating buttons, watermarks — anything that overlays auto layout content. Without `abs` you'd need a `gr` wrapper around the whole thing, adding an extra nesting level. `abs p(c,c)` centers an element inside an auto layout frame without disrupting the flow.

To clear the flag on an existing element (put it back into auto-layout flow), use `no-abs` — mirrors `no-clip`. Omitting `abs` on a modify call **preserves** the existing value; you must say `no-abs` explicitly to turn it off.

## Text wrapping
⚠ **Text overflows when hug width exceeds parent width.** Text defaults to `hug` (single line) — correct for labels, values, headings. But if the text content is wider than its parent's resolved width, it overflows. Use `s(fill,hug)` on descriptions, subtitles, and paragraphs so they wrap instead.
