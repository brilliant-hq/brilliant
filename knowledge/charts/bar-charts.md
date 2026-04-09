---
assumes: blueprint/layout, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Bar Charts

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/components`

## Vertical Bar Chart

Uses Bottom-Aligned Columns pattern. Each bar + label in a column:

Same brand color, different values. Use seed steps for emphasis (`.50` normal, `.70` highlight):
```
$brand=#F97316
$neutral=#64748B
al(h,a(s,e),g(4),pad($spacing.none)) s(hug,120) "Cols" #cols
  al(v,a(e,c),g(4),pad($spacing.none)) s(hug,fill) comp #col "Col"
    r s(24,40) f[($brand.40)] rd(3,3,0,0) "Bar" #col_bar
    t("Jan",Inter,10,m,align(c)) f[($neutral.40)] "Label" #col_label
  inst(#col)
    override(#col_bar) s(24,72) f[($brand.40)]
    override(#col_label) t("Feb")
  inst(#col)
    override(#col_bar) s(24,56) f[($brand.40)]
    override(#col_label) t("Mar")
  inst(#col)
    override(#col_bar) s(24,96) f[($brand.60)]
    override(#col_label) t("Apr")
  inst(#col)
    override(#col_bar) s(24,64) f[($brand.40)]
    override(#col_label) t("May")
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
Categorical palette — each row a distinct color (never semantic tokens like `$success`/`$warning`):
```
$neutral=#64748B
al(v,g(8),pad($spacing.none)) s(hug,hug) "HBar" #hbar
  al(h,a(c,s),g(8),pad($spacing.none)) s(hug,hug) comp #hrow
    t("Sales",Inter,12,m,align(r)) s(50,hug) f[($neutral.50)] "Label" #hrow_label
    al(h,g($spacing.none),pad($spacing.none)) s(200,16) f[($neutral.5)] rd(4) clip "Track" #hrow_track
      r s(160,fill) f[(#E11D48)] rd(4) "Fill" #hrow_fill
  inst(#hrow)
    override(#hrow_label) t("Ops")
    override(#hrow_fill) s(120,fill) f[(#F59E0B)]
  inst(#hrow)
    override(#hrow_label) t("Dev")
    override(#hrow_fill) s(90,fill) f[(#14B8A6)]
```

Same SCALE for all rows. Chart uses `s(fill,hug)`.
