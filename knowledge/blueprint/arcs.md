---
assumes: blueprint/core
---
# Blueprint Arcs & Rings

## `arc(start,sweep)`

- **start** — degrees (0-360). **0° = RIGHT (3 o'clock)**, counter-clockwise. **90° = TOP**. For progress rings starting at top: `arc(90,N)`.
- **sweep** — percentage (0-100). Fills **clockwise** from start.

## `ratio(N)`

Inner radius as fraction of outer (0-1). 0 = solid. >0 = ring/donut shape.

## Examples

```
c s(80,80) st[(#3B82F6,w(4),cap(r,r))] arc(90,75) ratio(1)     ← progress ring 75%
c s(80,80) f[(#3B82F6)] arc(90,25)                               ← pie sector 25%
c s(80,80) f[(#FF6B35)] arc(90,50) ratio(0.5)                    ← donut sector 50%
c s(80,80) f[(#3B82F6)] ratio(0.5)                               ← full donut
c s(24,24) arc(90,75) ratio(1) st[(#3B82F6,w(3))]               ← spinner
c s(80,80) st[(angular(#3B82F6,#8B5CF6),w(4),cap(r,r))] arc(90,84) ratio(1)  ← gradient ring
```

Round caps `cap(r,r)` for <80% sweep. Flat (omit caps) for >90% — round caps overlap at high sweeps.

## Progress Ring Structure

Track + arc + center text in a group:
```
gr s(80,80) "Graphic"
  c s(80,80) st[(#E2E8F0,w(4))] ratio(1) "Track"
  c s(80,80) st[(#3B82F6,w(4),cap(r,r))] arc(90,75) ratio(1) "Arc"
  t("75%",Inter,18,b,c) p(0,28) s(80,24) f[(#0F172A)] "Pct"
```

Track and arc are same size — arc stroke overlaps track stroke exactly.
