---
assumes: blueprint/core
---
# Blueprint Text

```
t("Dashboard",Inter,24,b) f[(#0F172A)]                    ← font, size, weight, fill
t("Updated 5 min ago",Inter,12,m,r) f[(#94A3B8)]          ← medium weight, right-aligned
t("Long description text here",Inter,14,lh(0.9)) s(fill,hug) f[(#64748B)]  ← wrapping text
t("BETA",Inter,11,sb,ls(0.08em)) f[(#8B5CF6)]             ← letter spacing
t("Hello\nWorld",Inter,16) f[(#0F172A)]                    ← newline escape
```

First 3 positional: `t("content",family,size)`, then any order:
Weights: `r`(400) body/descriptions · `m`(500) labels/captions · `sb`(600) subheadings/nav/card titles · `b`(700) headings/hero/CTAs · `eb`(800) display headlines · `bl`(900) watermarks. Align: `l` `c` `r` `j`. `lh(N)` line height. `ls(N)` letter spacing. `italic`, `underline`. Escapes: `\"` quote, `\uXXXX` unicode.

~290 bundled Google Fonts. Unavailable fonts silently fall back. Omit `s()` for short labels (hug). Use `s(fill,hug)` for any text that could exceed its parent's width.

⚠ Text fill defaults to white — always specify `f[(#hex)]`.
⚠ **Text overflows when hug width exceeds parent width.** Text defaults to `hug` (single line) — correct for labels, values, headings. When text content is wider than its parent's resolved width, it overflows. Use `s(fill,hug)` on descriptions, subtitles, and paragraphs so they wrap instead of overflowing.
