---
assumes: blueprint/layout, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Bar Charts

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/components`

## Vertical Bar Chart

Uses Bottom-Aligned Columns pattern. Each bar + label in a column:

```
al(h,a(s,e),g(4)) s(hug,120) "Cols"
  al(v,a(e,c),g(4)) s(hug,fill) comp #col "Col"
    r s(24,40) f[(#3B82F6)] rd(3,3,0,0) "Bar"
    t("Jan",Inter,10,m,c) f[(#94A3B8)] "Label"
  inst(#col)
    "Bar" s(24,72)
    "Label" t("Feb")
```

### Rules

| Rule | Why |
|------|-----|
| Columns `s(hug,fill)` NOT `hug,hug` | `fill` gives `e` room to push bars down |
| Cols container fixed height | Sets chart area |
| Column main axis `e` | Bars grow upward |
| Bar radius `rd(N,N,0,0)` | Rounded top, flat bottom |
| Use `g()` not `spaceBetween` | Uniform spacing |

### Variants

- **Value labels:** Text above bar, `g(2)` tight spacing
- **Grouped:** Paired bars in `al(h,a(s,e),g(2))`, narrower (16px), legend with dots
- **Mixed-width:** Wider (48px) with gradient for important, narrower for secondary

## Horizontal Bar Chart

Label + bar + value per row.

**Static:** Fixed pixel widths. Labels `s(56,hug)` fixed. Bar width = `max_width × (value / max)`. Bar `rd(0,4,4,0)`.

**Flex (responsive):** Bar in `s(fill,20)` track frame. `fill:VALUE` + `fill:(SCALE-VALUE)`:
```
al(v,g(8)) s(hug,hug) "HBar"
  al(h,a(c,s),g(8)) s(hug,hug) comp #hrow
    t("Sales",Inter,12,m,r) s(50,hug) f[(#64748B)] "Label"
    al(h) s(200,16) f[(#F1F5F9)] rd(4) clip "Track"
      r s(160,fill) f[(#3B82F6)] rd(4) "Fill"
  inst(#hrow)
    "Label" t("Ops")
    "Fill" s(120,fill) f[(#10B981)]
  inst(#hrow)
    "Label" t("Dev")
    "Fill" s(90,fill) f[(#F59E0B)]
```

Same SCALE for all rows. Chart uses `s(fill,hug)`.
