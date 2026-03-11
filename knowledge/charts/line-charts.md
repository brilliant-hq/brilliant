---
assumes: blueprint/vectors, blueprint/text, blueprint/components
---
# Data Viz: Line Charts

Assumes: `blueprint/vectors`, `blueprint/components`

## Structure

Frame Overlay — gridlines, axis labels, and data curves overlap in `fr s(hug,hug) clip`.

**Body:** Clipped frame. Gridlines = 1px rects at `p(offset,Y)`. Y labels at `p(0,Y)`. Data curves = `v()` with `mi` nodes at `p(offset,0)` sharing plot bbox. X-axis labels = `al(h,a(sb,c))` with left padding matching plot offset.

```
fr s(hug,hug) clip "Body"
  r p(44,0) s(336,1) f[(#F1F5F9)] "Gridline"
  t("$50K",Inter,10,m) p(0,-6) f[(#94A3B8)] "Y Label"
  v(nodes[(0,0,104,mi),(1,28,91,mi),...,(12,336,7,mi)])
    p(44,0) s(336,130) st[(#3B82F6,w(2))] "Revenue"
```

**Y positions:** `y = chart_height × (1 - value / max_value)`

**Legend:** Dot + label pairs with `comp` + `inst()`.

## Area Fill

Uses Clip-Outside-Stroke technique (see `blueprint/vectors`). Close curve at bottom, gradient fill, outside stroke + clip:

```
al(v,pad(2,0,0,0)) p(44,0) s(hug,hug) clip "RevClip"
  v(nodes[...curve...,(...,W,H),(...,0,H)],edges[...],closed)
    s(W,H) f[(linear(180,stop(#3B82F6,0,o(0.12)),stop(#3B82F6,1,o(0))))]
    st[(#3B82F6,w(2),pos(o))]
```

Clip frame at same offset as plot area.
