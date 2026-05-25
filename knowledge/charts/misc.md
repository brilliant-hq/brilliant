---
assumes: blueprint/layout, blueprint/paint, blueprint/text, blueprint/components
---
# Data Viz: Stacked Bars & Heatmaps

## Stacked horizontal bar

Flex segments give proportions with no pixel math. Wrap each segment as
an `fr` (so `comp` is valid) holding a fill `r`; the flex weight is an
`s(fill:N,...)` frame property on the `inst()` line, the color an
`override` on the inner `r`. The track is `rd($radius.full) clip` to
round the ends.

```
al(h,g($spacing.none),pad($spacing.none)) s(280,12) rd($radius.full) clip "Stacked"
  fr comp s(fill:40,fill) "Deep" #seg
    r s(fill,fill) f[($indigo.mid)] #seg_fill
  inst(#seg) s(fill:30,fill) "Light"
    override(#seg_fill) f[($indigo.soft)]
  inst(#seg) s(fill:20,fill) "REM"
    override(#seg_fill) f[($pink.mid)]
```

A legend is the same `comp`/`inst` idea: a row of dot-plus-label pairs,
one palette stop per segment.

## Contribution heatmap

A column-major grid: each week is a vertical column of 7 day cells,
`s(11,11) rd($radius.xs)` with a small gap. Encode intensity as a 5-stop
ramp of one palette (`$green.subtle` through `$green.strong`, or `$blue`,
`$violet`, ...), with `$color.surface.container` for empty cells. Add
day-of-week labels down the side and month labels along the top, plus a
Less-to-More legend of the five swatches.
