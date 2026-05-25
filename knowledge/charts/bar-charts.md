---
assumes: blueprint/layout, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Bar Charts

## Vertical bars

Columns sit in a fixed-height `al(h)` (the chart area) with `y(e)` so
they share a baseline. Each column is `al(v,y(e))` sized `s(hug,fill)`:
`fill` gives it the full height, `y(e)` drops the bar to the bottom so it
grows upward. Bar corners are `rd($radius.sm,$radius.sm,$radius.none,$radius.none)` (rounded
top, flat bottom). Stamp the column as a `comp`, varying bar height and
tone per instance:

```
al(h,x(s),y(e),g($spacing.xs),pad($spacing.none)) s(hug,120) "Cols"
  al(v,y(e),x(c),g($spacing.xs),pad($spacing.none)) comp s(hug,fill) "Jan" #col
    r s(24,40) f[($primary.soft)] rd($radius.sm,$radius.sm,$radius.none,$radius.none) "Bar" #col_bar
    t("Jan",$font.family,$font.size.xs,m,align(c)) f[($color.text.secondary)] #col_label
  inst(#col) "Feb"
    override(#col_bar) r s(24,72) f[($primary.soft)] rd($radius.sm,$radius.sm,$radius.none,$radius.none)
    override(#col_label) t("Feb")
  inst(#col) "Mar" #mar
    override(#col_bar) r s(24,96) f[($primary.firm)] rd($radius.sm,$radius.sm,$radius.none,$radius.none)
    override(#col_label) t("Mar")
```

Keep one brand hue across the bars and lift the highlight with a firmer
stop (`$primary.firm`). A trailing `#ref` on an `inst()` keeps that column
addressable. Grouped bars: pair narrower bars in a nested `al(h)` with a
dot legend.

## Horizontal bars

One row is a label plus a track frame holding the fill bar; make the
track `clip` so the fill's corners stay inside it. Responsive version:
track `s(fill,16)`, fill width by `fill:VALUE` against the same scale on
every row. Categorical data uses a distinct palette stop per row, never
semantic roles.

```
al(v,g($spacing.sm),pad($spacing.none)) s(hug,hug) "HBar"
  al(h,x(c),y(s),g($spacing.sm),pad($spacing.none)) comp s(hug,hug) "Sales" #hrow
    t("Sales",$font.family,$font.size.xs,m,align(r)) s(50,hug) f[($color.text.secondary)] #hrow_label
    al(h,g($spacing.none),pad($spacing.none)) s(200,16) f[($color.surface.container)] rd($radius.sm) clip "Track"
      r s(160,fill) f[($rose.mid)] rd($radius.sm) "Fill" #hrow_fill
  inst(#hrow) "Ops"
    override(#hrow_label) t("Ops")
    override(#hrow_fill) r s(120,fill) f[($amber.mid)] rd($radius.sm)
```
