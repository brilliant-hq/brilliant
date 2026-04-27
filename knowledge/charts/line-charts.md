---
assumes: blueprint/vectors, blueprint/text, blueprint/components
---
# Data Viz: Line Charts

Assumes: `blueprint/vectors`, `blueprint/components`

## Structure

Frame Overlay — gridlines, axis labels, and data curves overlap in `fr s(hug,hug) clip`.

**Body:** Clipped frame. Gridlines = 1px rects at `p(offset,Y)`. Y labels at `p(0,Y)`. Data curves = `v()` with `mi` nodes at `p(offset,0)` sharing plot bbox. X-axis labels = `al(h,x(sb),y(c))` with left padding matching plot offset.

```
$brand=#F97316
$neutral=#64748B
fr s(hug,hug) clip "Body" #chart_body
  r p(44,0) s(336,1) f[($neutral.5)] "Gridline" #gridline
  t("\$50K",Inter,10,m) p(0,-6) f[($neutral.40)] "Y Label" #y_label
  v(nodes[(0,0,104,mi),(1,28,91,mi),...,(12,336,7,mi)])
    p(44,0) s(336,130) st[($brand.50,w(2))] "Revenue" #revenue
```

**Y positions:** `y = chart_height × (1 - value / max_value)`

**Legend:** Dot + label pairs with `comp` + `inst()`.

## Area Fill

Uses Clip-Outside-Stroke technique (see `blueprint/vectors`). Close curve at bottom, gradient fill, outside stroke + clip:

```
$brand=#F97316
al(v,g($spacing.none),pad(2,$spacing.none,$spacing.none,$spacing.none)) p(44,0) s(hug,hug) clip "RevClip" #rev_clip
  v(nodes[...curve...,(...,W,H),(...,0,H)],edges[...],closed)
    s(W,H) f[(linear(180,stop($brand.50,0,o(0.12)),stop($brand.50,1,o(0))))]
    st[($brand.50,w(2),pos(o))] #rev_area
```

Clip frame at same offset as plot area.
