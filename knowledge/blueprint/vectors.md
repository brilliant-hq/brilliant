---
assumes: blueprint/paint
dsl: [v(, mi, st, as, di]
---
# Blueprint Vectors

Assumes: `blueprint/core`, `blueprint/paint`

## Syntax

`v(nodes[(id,x,y,type),...],edges[(id,nodeA,nodeB,haX,haY,hbX,hbY),...],closed)`

**Node types:** `st` (straight, default) · `mi` (mirrored/smooth) · `as` (asymmetric) · `di` (disconnected)

**Auto-smooth curves:** Mark nodes as `mi` — system computes tangent-based handles at 30% of edge length. No manual handle coordinates needed. Edges without explicit handles default to `(0,0,0,0)` and are auto-computed for `mi` nodes.

**Auto edges:** If edges are omitted entirely, they're generated sequentially (node 0→1→2→...).

## Stroke-only curve

```
v(nodes[(0,0,40,mi),(1,60,16,mi),(2,120,12,mi)]) s(120,48) st[(#14B8A6,w(1.5))]
```

## Area fill (closed path)

Close with straight bottom nodes + outside stroke + clip frame to hide closing edges:
```
al(v,g($spacing.none),pad(2,$spacing.none,$spacing.none,$spacing.none)) s(hug,hug) clip "ClipFrame"
  v(nodes[(0,0,40,mi),(1,60,16,mi),(2,120,12,mi),(3,120,48),(4,0,48)],edges[(0,0,1),(1,1,2),(2,2,3),(3,3,4),(4,4,0)],closed) s(120,48) f[(#CCFBF1)] st[(#14B8A6,w(1.5),pos(o))]
```

Outside stroke `pos(o)` pushes boundary strokes beyond the bbox. Clip frame crops them. Top padding >= stroke width. ONE vector with both fill and stroke.

## Coordinates

`(0,0)` = top-left (highest value), `(W,H)` = bottom-right (lowest). Every node MUST have 3 or 4 values: `(index,x,y)` or `(index,x,y,type)`.
