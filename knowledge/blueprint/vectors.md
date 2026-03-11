---
assumes: blueprint/paint
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
v(nodes[(0,0,40,mi),(1,60,16,mi),(2,120,12,mi)]) s(120,48) st[(#3B82F6,w(1.5))]
```

## Area fill (closed path)

Close with straight bottom nodes:
```
v(nodes[(0,0,40,mi),(1,60,16,mi),(2,120,12,mi),(3,120,48),(4,0,48)],edges[(0,0,1),(1,1,2),(2,2,3),(3,3,4),(4,4,0)],closed) s(120,48) f[(#DBEAFE)] st[(#3B82F6,w(1.5))]
```

## Clip-Outside-Stroke Technique

Hide strokes on closing edges (sparkline area fills, line chart fills):

1. Close path at bounding box boundary (bottom corners + straight edges)
2. Outside stroke `pos(o)` — pushes boundary strokes beyond bbox
3. Clip frame — `al(v,pad(SW,0,0,0)) s(hug,hug) clip` crops pushed-out strokes

```
al(v,pad(2,0,0,0)) s(hug,hug) clip "ClipFrame"
  v(nodes[...curve...,(N,W,H),(N+1,0,H)],edges[...],closed) s(W,H) f[(linear(180,stop(#hex,0,o(0.15)),stop(#hex,1,o(0))))] st[(#hex,w(1.5),pos(o))]
```

**Rules:** ONE vector with both fill and stroke. Clip frame MUST be `s(hug,hug)`. Top padding >= stroke width.

## Coordinates

`(0,0)` = top-left (highest value), `(W,H)` = bottom-right (lowest). Every node MUST have 3 or 4 values: `(index,x,y)` or `(index,x,y,type)`.
