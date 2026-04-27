---
assumes: blueprint/layout, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Stacked Bars & Heatmaps

Assumes: `blueprint/core`, `blueprint/layout`

## Stacked Horizontal Bar

Flex segments — proportional, no pixel math. Encode each segment's weight,
color, and label as one tuple:
```
$neutral=#64748B
al(h,g($spacing.none),pad($spacing.none)) s(280,12) rd($radius.full) clip "Stacked" #stacked
  for(vars[$w,$color,$name], in([
    (40,#6366F1,Deep),
    (30,#818CF8,Light),
    (20,#EC4899,REM),
    (10,#F97316,Awake),
  ]))
    r s(fill:$w,fill) f[($color)] "$name" #seg
```

Parent `rd($radius.full) clip` rounds ends. `s(fill,12)` for responsive.

**Legend:** Dot + label per segment — same tuple data, separate loop:
```
al(h,x(s),y(c),g(16),pad($spacing.none)) s(hug,hug) "Legend" #legend
  for(vars[$color,$name], in([
    (#6366F1,Deep Sleep),
    (#818CF8,Light Sleep),
    (#EC4899,REM),
    (#F97316,Awake),
  ]))
    al(h,x(s),y(c),g(6),pad($spacing.none)) s(hug,hug) "Item $name" #leg
      r s(8,8) f[($color)] rd($radius.full) #leg_dot
      t("$name",Inter,12) f[($neutral.50)] #leg_label
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
