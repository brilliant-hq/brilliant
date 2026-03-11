---
assumes: blueprint/core
---
# Blueprint Layout

Every level: direction `al(v)` or `al(h)`, sizing `hug`/`fill`/`fixed`, spacing `pad()` + `g()`.

## Layout in action

```
al(v,g(24),pad(32)) s(400,hug) "Page"                    ← v=vertical, g=gap, pad=padding
  al(h,a(sb,c)) s(fill,hug) "Header"                     ← sb=spaceBetween, fill=stretch to parent
    t("Logo",Inter,18,b) f[(#0F172A)]
    al(h,g(8)) s(hug,hug) "Nav"                           ← hug=shrink to content
      t("Home",Inter,14,m) f[(#64748B)]
      t("About",Inter,14,m) f[(#64748B)]
  al(h,g(16)) s(fill,hug) "Content"
    al(v,g(12)) s(fill:2,hug) "Main"                      ← fill:2 = 2/3 width
      t("Welcome back",Inter,24,sb) f[(#0F172A)]
      t("Here's what happened today",Inter,14) s(fill,hug) f[(#64748B)]  ← s(fill,hug) = text wraps
    al(v,g(12),pad(16)) s(fill:1,hug) f[(#F8FAFC)] rd(8) "Sidebar"  ← fill:1 = 1/3 width
      t("Quick stats",Inter,14,sb) f[(#0F172A)]
      t("Overview of today",Inter,13) s(fill,hug) f[(#64748B)]
```

## Sizing: `s(W,H)` — "who decides this size?"
Content → `hug` (default for text, buttons). Parent → `fill`. Design spec → fixed number. `fill:N` for proportional splits (fill:3 + fill:1 = 75/25%).

Typical sizing: root component fixed-or-hug/hug · label/value omit `s()` · prose `s(fill,hug)` · nested frame in v-parent fill/hug · button hug/hug · icon/avatar fixed/fixed · equal-width siblings all `fill`.

⚠ **Fill inside hug = collapses to 0.** A `fill` child needs a `fixed` or `fill` ancestor on that axis. Cross-axis fill always works. Fill inheritance: walk up the main-axis chain — hit `fixed` before `hug` → fill works; hit `hug` first → collapses. `al(v)`: fill-width child needs parent with fixed/fill width. `al(h)`: fill-height child needs parent with fixed/fill height.

## Spacing
`pad(V,H)` or `pad(T,R,B,L)` edges. `g(N)` between children. Both on the **parent**.
Gaps: 2-4 tightly coupled · 6-8 related items · 12-16 siblings in section · 20-32 major groups · 40-64 page-level.

## Text wrapping
⚠ **Text overflows when hug width exceeds parent width.** Text defaults to `hug` (single line) — correct for labels, values, headings. But if the text content is wider than its parent's resolved width, it overflows. Use `s(fill,hug)` on descriptions, subtitles, and paragraphs so they wrap instead.
