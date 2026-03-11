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

Uses Clip-Outside-Stroke:
```
al(v,pad(2,0,0,0)) s(hug,hug) clip "Spark"
  v(nodes[(0,0,21.6,mi),(1,12,16.8,mi),(2,28,12,mi),(3,38,15.6,mi),(4,50,7.2,mi),(5,60,0,mi),(6,60,24),(7,0,24)],edges[(0,0,1),(1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6),(6,6,7),(7,7,0)],closed) s(60,24) f[(linear(180,stop(#3B82F6,0,o(0.40)),stop(#3B82F6,1,o(0))))] st[(#3B82F6,w(1.5),pos(o))]
```

**ONE vector** with fill + stroke. Clip frame `s(hug,hug)`. Vector `s(fixed)`.

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
