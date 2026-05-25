---
assumes: blueprint/layout, blueprint/paint, blueprint/text
---
# Data Viz: Tables

Assumes: `blueprint/core`, `blueprint/layout`

## Structure

Row-Major Grid: `al(v,g(0))` → `al(h,g(12)) s(fill,hug)` rows → cells with matching sizing per column.

## Rules

- `g(0)` on table frame — rows touch (no spacing)
- Alternate row fills (`$color.surface.container` on even rows)
- **Column alignment:** Every row uses same sizing per column position — `s(fill,hug)` flexible, `s(fill:N,hug)` weighted, `s(100,hug)` fixed-width
- Use `g($spacing.md)` for inter-column spacing (not spaceBetween)
- Header: `$font.family,$font.size.sm,sb` in `$color.text.secondary`. Body: `$font.family,$font.size.sm` in `$color.text.primary`
- Right-align number columns
- 1px dividers between rows
- Same cell count in every row
