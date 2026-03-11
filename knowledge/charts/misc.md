---
assumes: blueprint/layout, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Stacked Bars & Heatmaps

Assumes: `blueprint/core`, `blueprint/layout`

## Stacked Horizontal Bar

Flex segments — proportional, no pixel math:
```
al(h) s(280,12) rd(9999) clip "Stacked"
  r s(fill:40,fill) f[(#6366F1)] "Seg 1"
  r s(fill:30,fill) f[(#818CF8)] "Seg 2"
  r s(fill:20,fill) f[(#EC4899)] "Seg 3"
  r s(fill:10,fill) f[(#F97316)] "Seg 4"
```

Parent `rd(9999) clip` rounds ends. `s(fill,12)` for responsive.

**Legend:** Dot + label with `comp`:
```
al(h,a(s,c),g(16)) s(hug,hug) "Legend"
  al(h,a(s,c),g(6)) s(hug,hug) comp #leg
    r s(8,8) f[(#6366F1)] rd(9999) "Dot"
    t("Deep Sleep",Inter,12) f[(#64748B)] "Label"
  inst(#leg)
    "Dot" f[(#818CF8)]
    "Label" t("Light Sleep")
```

## Contribution Heatmap

Column-Major Grid. Each week = vertical column of 7 cells.

- Cell: `s(11,11) rd(2)` with `g(3)` between
- Day labels: V-stack with spacer frames matching stride
- Month labels: fixed width `s(70,hug)` matching ~5 weeks
- Legend: 5 color swatches Less→More

**5-level intensity:**

| Level | Color |
|-------|-------|
| 0 (empty) | `#EBEDF0` |
| 1 (low) | `#9BE9A8` |
| 2 (medium) | `#40C463` |
| 3 (high) | `#30A14E` |
| 4 (max) | `#216E39` |

Adapt colors: blues for coding, purples for design, reds for incidents.
