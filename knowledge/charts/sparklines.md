---
assumes: blueprint/vectors
---
# Data Viz: Sparklines

Compact inline charts drawn as a `v()` vector path. Node type sets the
feel: all `mi` for smooth (revenue, users), all `st` for jagged (latency,
prices), mixed for realism. Avoid AI tells: same shape every chart,
perfectly even X spacing, symmetric rises, clean sine waves.

```
-- Simple, stroke-only, no axis. NO clip needed (nothing to mask).
al(v,g($spacing.none),pad($spacing.none)) s(120,48) "Spark"
  v(nodes[(0,0,40,mi),(1,30,32,mi),(2,60,22,mi),(3,90,10,mi),(4,120,4,mi)]) s(fill,40) st[($primary.mid,w($stroke.width.soft))]

-- Medium, leading Y label gutter (two FLOW columns, never abs + fill).
al(h,x(s),y(c),g($spacing.sm),pad($spacing.none)) s(200,40) "Tile"
  t("0",$font.family,$font.size.xs,m,align(r)) s(28,hug) f[($color.text.secondary)]
  v(nodes[(0,0,40,mi),(1,40,30,mi),(2,80,22,mi),(3,120,8,mi),(4,160,2,mi)]) s(fill,40) st[($primary.mid,w($stroke.width.soft))]
-- abs+fill in the SAME parent silently overlap: fill expands UNDER abs.

-- Complex, area fill, label gutter, gridline at label baseline.
al(h,x(s),y(c),g($spacing.sm),pad($spacing.none)) s(240,56) "TileFull"
  al(v,x(e),y(sb),g($spacing.none),pad($spacing.none)) s(28,fill) "YAxis"
    t("30K",$font.family,$font.size.xs,m,align(r)) f[($color.text.disabled)]
    t("0",$font.family,$font.size.xs,m,align(r)) f[($color.text.disabled)]
  fr s(fill,fill) "SparkCol"
    r abs p(0,8) s(fill,1) f[($color.outline.variant)]    -- gridline at label BASELINE, not its top
    r abs p(0,48) s(fill,1) f[($color.outline.variant)]
    al(v,g($spacing.none),pad($spacing.lg,$spacing.none,$spacing.none,$spacing.none)) abs p(0,0) s(fill,56) clip "SparkClip"
      v(nodes[(0,0,40,mi),(1,40,30,mi),(2,80,22,mi),(3,120,8,mi),(4,160,2,mi),(5,160,56),(6,0,56)],edges[(0,0,1),(1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6),(6,6,0)],closed) s(fill,fill) f[(linear(180,stop($primary.mid,0,o($visibility.soft)),stop($primary.mid,1,o($visibility.invisible))))] st[($primary.mid,w($stroke.width.soft),pos(o))]
```

**Three things every model gets wrong, in order of damage:**

1. **`clip` is only for area fills**, never stroke-only curves. Closed paths leak their closing edges past the path bbox; `clip` masks them. Open stroke paths have nothing to mask, adding `clip` invites every overshoot warning below.
2. **Top pad must cover stroke width + bezier handle bulge.** `mi` nodes generate auto-tangents at 30% of edge length; a curve dropping from y=40 to y=2 over a single edge can bulge ~12px above the top node. `$spacing.lg` covers most cases; raise it when rises are steep.
3. **Gridlines sit at the label's baseline**, not its top. A 12px-tall `$font.size.xs` label has its baseline ~8-9px below its `p(_, y)` top, put gridlines there so they slide under the glyph instead of through it.
