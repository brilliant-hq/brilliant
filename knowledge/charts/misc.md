---
assumes: blueprint/layout, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Stacked Bars & Heatmaps

Assumes: `blueprint/core`, `blueprint/layout`

## Stacked Horizontal Bar

Flex segments — proportional, no pixel math:
```
$seg1=#6366F1
$seg2=#818CF8
$seg3=#EC4899
$seg4=#F97316
al(h,g($spacing.none),pad($spacing.none)) s(280,12) rd($radius.full) clip "Stacked" #stacked
  r s(fill:40,fill) f[($seg1)] "Seg 1"
  r s(fill:30,fill) f[($seg2)] "Seg 2"
  r s(fill:20,fill) f[($seg3)] "Seg 3"
  r s(fill:10,fill) f[($seg4)] "Seg 4"
```

Parent `rd($radius.full) clip` rounds ends. `s(fill,12)` for responsive.

**Legend:** Dot + label with `comp` — reuse the same `$var` colors:
```
$neutral=#64748B
al(h,a(s,c),g(16),pad($spacing.none)) s(hug,hug) "Legend" #legend
  al(h,a(s,c),g(6),pad($spacing.none)) s(hug,hug) comp #leg
    r s(8,8) f[($seg1)] rd($radius.full) "Dot" #leg_dot
    t("Deep Sleep",Inter,12) f[($neutral.50)] "Label" #leg_label
  inst(#leg)
    override(#leg_dot) f[($seg2)]
    override(#leg_label) t("Light Sleep")
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
