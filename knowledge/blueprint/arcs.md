---
assumes: blueprint/core
dsl: [arc, ring, sweep, cap, ratio]
---
# Blueprint Arcs & Rings

## `arc(start,sweep)`

- **start** — degrees (0-360). **0° = RIGHT (3 o'clock)**, counter-clockwise. **90° = TOP**. For progress rings starting at top: `arc(90,N)`.
- **sweep** — percentage (0-100). Fills **clockwise** from start.

## `ratio(N)`

Inner radius as fraction of outer (0-1). 0 = solid. >0 = ring/donut shape. **Omit `ratio()` entirely for solid circles** — only use it for rings/donuts. `ratio(1)` = stroke-only ring (zero fill area).

## Pie/Donut Charts

Multiple arcs on same-size circles. Formula: `next_start = prev_start - (prev_sweep% x 3.6)`.

```
$brand=#6366F1
$warn=#F59E0B
$accent=#EC4899
$muted=#94A3B8
gr s(100,100) #donut
  c s(100,100) f[($brand.50)] arc(90,45) ratio(0.55)
  c s(100,100) f[($accent.50)] arc(288,25) ratio(0.55)
  c s(100,100) f[($warn.50)] arc(198,20) ratio(0.55)
  c s(100,100) f[($muted.50)] arc(126,10) ratio(0.55)
```

Omit `ratio()` for solid pie. Round caps `cap(r,r)` for <80% sweep. Flat (omit caps) for >90% — round caps overlap at high sweeps.

## Multi-Ring

Concentric rings — each a different metric with its own color:
```
$neutral=#64748B
gr s(80,80) #multi_ring
  c s(80,80) st[(#E2E8F0,w(5))] ratio(1)
  c s(80,80) st[(#6366F1,w(5),cap(r,r))] arc(90,72) ratio(1)
  c p(12,12) s(56,56) st[(#E2E8F0,w(4))] ratio(1)
  c p(12,12) s(56,56) st[(#EC4899,w(4),cap(r,r))] arc(90,55) ratio(1)
  c p(22,22) s(36,36) st[(#E2E8F0,w(3))] ratio(1)
  c p(22,22) s(36,36) st[(#F59E0B,w(3),cap(r,r))] arc(90,90) ratio(1)
t("Activity",Inter,11,m,align(c)) f[($neutral.50)]
```

## Progress Ring

Track + arc + center text in a group:
```
gr s(80,80) #ring
  c s(80,80) st[(#E2E8F0,w(4))] ratio(1) "Track" #ring_track
  c s(80,80) st[(#10B981,w(4),cap(r,r))] arc(90,75) ratio(1) "Arc" #ring_arc
  t("75%",Inter,18,b) p(c,c) f[(#0F172A)] "Pct" #ring_pct
```

Track and arc are same size — arc stroke overlaps track stroke exactly.
