---
assumes: blueprint/layout, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Bar Charts

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/components`

## Vertical Bar Chart

Uses Bottom-Aligned Columns pattern. Each bar + label in a column:

Same brand color, different values. Use seed steps for emphasis (`.50` normal, `.70` highlight). One tuple per column:
```
$brand=#F97316
$neutral=#64748B
al(h,x(s),y(e),g(4),pad($spacing.none)) s(hug,120) "Cols" #cols
  for(vars[$month,$h,$tone], in([
    (Jan,40,$brand.40),
    (Feb,72,$brand.40),
    (Mar,56,$brand.40),
    (Apr,96,$brand.60),
    (May,64,$brand.40),
  ]))
    al(v,y(e),x(c),g(4),pad($spacing.none)) s(hug,fill) "Col $month" #col
      r s(24,$h) f[($tone)] rd(3,3,0,0) "Bar" #col_bar
      t("$month",Inter,10,m,align(c)) f[($neutral.40)] "Label" #col_label
```
After expansion, `#col_Apr` is the highlighted column, `#col_bar_Apr` its bar — modify either to push values further.

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
- **Grouped:** Paired bars in `al(h,x(s),y(e),g(2))`, narrower (16px), legend with dots
- **Mixed-width:** Wider (48px) with gradient for important, narrower for secondary

## Horizontal Bar Chart

Label + bar + value per row.

**Static:** Fixed pixel widths. Labels `s(56,hug)` fixed. Bar width = `max_width × (value / max)`. Bar `rd(0,4,4,0)`.

**Flex (responsive):** Bar in `s(fill,20)` track frame. `fill:VALUE` + `fill:(SCALE-VALUE)`:
Categorical palette — each row a distinct color (never semantic tokens like `$success`/`$warning`). One tuple per row:
```
$neutral=#64748B
al(v,g(8),pad($spacing.none)) s(hug,hug) "HBar" #hbar
  for(vars[$label,$w,$color], in([
    (Sales,160,#E11D48),
    (Ops,120,#F59E0B),
    (Dev,90,#14B8A6),
  ]))
    al(h,x(c),y(s),g(8),pad($spacing.none)) s(hug,hug) "Row $label" #hrow
      t("$label",Inter,12,m,align(r)) s(50,hug) f[($neutral.50)] "Label" #hrow_label
      al(h,g($spacing.none),pad($spacing.none)) s(200,16) f[($neutral.5)] rd(4) clip "Track" #hrow_track
        r s($w,fill) f[($color)] rd(4) "Fill" #hrow_fill
```

Same SCALE for all rows. Chart uses `s(fill,hug)`.
