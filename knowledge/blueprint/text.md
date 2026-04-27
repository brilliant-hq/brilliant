---
assumes: blueprint/core
dsl: [t(, lh, ls, eb, bl]
---
# Blueprint Text

```
t("Dashboard",Inter,24,b) f[(#0F172A)]
t("Chapter One",Playfair Display,20,italic) f[(#8B5CF6)]
t("LAUNCH DAY",Inter,11,sb,ls(0.12)) f[(#EF4444)]
t("Updated 5 min ago",Inter,12,m,align(r)) s(fill,hug) f[(#94A3B8)]
t("Long description that wraps",Inter,14,lh(1.4)) s(fill,hug) f[(#64748B)]
t("Hello\nWorld",Fira Code,16) f[(#10B981)]
t("Outlined",Inter,28,b) f[] st[(#0F172A,w(2),pos(o))]
t("Glow",Inter,28,b) f[(#FFF)] shadow(#8B5CF6,blur(12))
```

First 3 positional: `t("content",family,size)`, then any order:
Weights: `r`(400) body/descriptions · `m`(500) labels/captions · `sb`(600) subheadings/nav/card titles · `b`(700) headings/hero/CTAs · `eb`(800) display headlines · `bl`(900) watermarks. Align: `align(l)` left · `align(c)` center · `align(r)` right · `align(j)` justify. Direction: `rtl` or `ltr` (default) — RTL auto-defaults to right alignment unless overridden. `lh(N)` line-height multiplier (e.g. `1.4`). `ls(N)` letter spacing as em multiplier of the rendered font size (`ls(0.12)` = 12% tracking, matches CSS `letter-spacing: 0.12em`). For absolute pixels, suffix with `px`: `ls(2px)`. Negative values tighten: `ls(-0.02)`. `italic`, `underline`. Escapes: `\"` quote, `\uXXXX` unicode.

~290 bundled Google Fonts. Unavailable fonts silently fall back. Omit `s()` for short labels (hug). Use `s(fill,hug)` for any text that could exceed its parent's width.

⚠ Text fill defaults to white — always specify `f[(#hex)]`.
⚠ **Text overflows when hug width exceeds parent width.** Text defaults to `hug` (single line) — correct for labels, values, headings. When text content is wider than its parent's resolved width, it overflows. Use `s(fill,hug)` on descriptions, subtitles, and paragraphs so they wrap instead of overflowing.
