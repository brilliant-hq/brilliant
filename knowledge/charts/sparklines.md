---
assumes: blueprint/vectors
---
# Data Viz: Sparklines

Assumes: `blueprint/vectors`

Compact inline charts. Three node strategies:

| Strategy | Nodes | Look | Use for |
|----------|-------|------|---------|
| All `mi` | Smooth curves | Polished, organic | Revenue, users |
| All `st` | Angular/jagged | Raw, volatile | Latency, stock price |
| Mixed | Smooth + sharp | Realistic | Alerts, bursts |

## Stroke-Only (Volatile)

```
v(nodes[(0,0,21),(1,10,11),(2,17.68,19.32),(3,25.21,11),(4,32,18),(5,34.36,13.43),(6,43.32,22.67),(7,60,0)]) s(60,22.67) st[(#EF4444,w(1.5))]
```

## Area Fill (Smooth Growth)

Uses Clip-Outside-Stroke. ONE closed vector with both fill and stroke, inside a clipping `al()` frame with top padding only:
```
$brand=#14B8A6
al(v,g($spacing.none),pad(2,$spacing.none,$spacing.none,$spacing.none)) s(fill,26) clip "Spark" #spark
  v(nodes[(0,0,21.6,mi),(1,12,16.8,mi),(2,28,12,mi),(3,38,15.6,mi),(4,50,7.2,mi),(5,60,0,mi),(6,60,24),(7,0,24)],edges[(0,0,1),(1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6),(6,6,7),(7,7,0)],closed) s(fill,fill) f[(linear(180,stop($brand.50,0,o(0.40)),stop($brand.50,1,o(0))))] st[($brand.50,w(1.5),pos(o))] #spark_area
```

### Crucial invariant: the clip frame's interior must match the vector's bounds

The closing edges of the area fill (the bottom and sides of the closed path) sit AT the vector's bounding box. The clip frame crops them ONLY if its interior (frame size minus padding) is the same size as the vector. Two safe configurations:

| Frame | Vector | How they stay matched |
|---|---|---|
| `s(fill, FIXED)` or `s(FIXED, FIXED)` | `s(fill, fill)` | Vector stretches to the frame — bounds equal frame interior. **Recommended** — single source of truth for chart size. |
| `s(hug, hug)` | `s(W, H)` (fixed) | Frame shrinks to wrap the vector — bounds equal the vector. Use when the chart should size to its data extent, not its container. |

**What breaks it:** fixed-size frame + a vector with any *different* fixed dimension on the same axis. Common failure:
```
al(v,pad(2,0,0,0)) s(620,198) clip "Spark"
  v() s(fill,180) ... path:d(... L620,180 L0,180 Z)
```
Frame is 198 tall, vector is 180 tall → vector bottom lands at y=182 (after 2px pad), clip boundary is at y=198 → 16px of unclipped closing-edge stroke is visible at the bottom. Either drop the vector to `s(fill,fill)` (so it grows into the 196px-tall interior) or shrink the frame to `s(620, 182)` (so it hugs the vector).

The top `pad(2,0,0,0)` leaves room for the outside stroke above the curve so the topmost arc isn't clipped. No padding on the other sides — those closing-edge strokes are intentionally clipped.

## Realistic Path Shapes

**Pick DIFFERENT archetype per sparkline:**

| Metric | Archetype |
|---|---|
| Revenue, MRR | Gradual up + 1-2 pullbacks |
| Latency | Flat + isolated sharp spikes |
| Error rate | Near-zero + sudden bursts |
| Stock price | Rapid zigzag, big amplitude |
| Conversion | Seasonal dip, recovers |

## Fake Tells to Avoid

| Tell | Fix |
|---|---|
| Same shape everywhere | Different archetype per metric |
| Even X spacing | 3-4px during change, 6-8px during plateaus |
| Symmetric rises/falls | Steeper drops than rises |
| Sine wave | Irregular periods, random amplitudes |
