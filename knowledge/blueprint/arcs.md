---
assumes: blueprint/core
dsl: [arc, ring, sweep, cap, ratio]
---
# Blueprint Arcs & Rings

**For circular progress, ALWAYS use `c arc() ratio()` — never `v() path:d(...A...)`.** SVG arc commands inside vector paths require hand-computed endpoints (`M38,8A30,30,0,1,1,12.02,53` style) and produce hairline gaps where start meets end. The native arc form is one element per ring and renders cleanly.

## `arc(start,sweep)`

- **start** — degrees (0-360). **0° = RIGHT (3 o'clock)**, counter-clockwise. **90° = TOP**. Progress rings start at top → `arc(90,N)`.
- **sweep** — percentage (0-100). Fills **clockwise** from start.

## `ratio(N)`

Inner radius as fraction of outer (0-1). 0 = solid. >0 = ring/donut. **Omit `ratio()` for solid circles.** `ratio(1)` = stroke-only ring (zero fill).

## Wrap rings in `gr`, never `al(...)`

For concentric or overlapping children, the wrapper must be `gr` (or `fr`). `al`'s `x(c)/y(c)` aligns children **within flow** — they stack end-to-end on the main axis, not on top of each other. Sizes 200 + 160 + 120 inside a 200px `al` wrapper overflow the parent by ~440px total.

```
WRONG — children stack vertically, overflow the wrapper:
al(v,x(c),y(c),g(0),pad(0)) s(200,200)
  c s(200,200) ...
  c s(160,160) ...
  c s(120,120) ...

RIGHT — gr + p(c,c) centers each child on the parent center:
gr s(200,200)
  c p(c,c) s(200,200) ...
  c p(c,c) s(160,160) ...
  c p(c,c) s(120,120) ...
```

Inside `al`, every child must be `abs p(c,c)` to escape flow. Works, but `gr` is shorter and clearer.

## Progress Ring (track + arc + center text)

The canonical pattern — most habit/dashboard rings use this:

```
gr s(80,80) #ring
  c s(80,80) st[(#E2E8F0,w(4))] ratio(1) "Track" #ring_track
  c s(80,80) st[(#10B981,w(4),cap(r,r))] arc(90,75) ratio(1) "Arc" #ring_arc
  t("75%",Inter,18,b) p(c,c) f[(#0F172A)] "Pct" #ring_pct
```

Track and arc are same size — arc stroke overlaps track stroke exactly. `cap(r,r)` for sweep <80% (rounded ends). Flat (omit caps) for >90% — round caps overlap at high sweeps.

For a *completed* ring with glow: stack three circles — outer glow stroke, track, full-360 arc:

```
gr s(82,82) #ring_done
  c s(82,82) st[(#49F7A9,w(18))] o(0.20) ratio(1) "Glow"
  c s(82,82) st[(#244236,w(8))] ratio(1) "Track"
  c s(82,82) st[(#49F7A9,w(9),cap(r,r))] arc(90,100) ratio(1) "Done arc"
  t("✓",Inter,22,b) p(c,c) f[(#DFFFF0)] "Check"
```

## Pie/Donut Charts

Multiple arcs on same-size circles. Formula: `next_start = prev_start - (prev_sweep% × 3.6)`.

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

Omit `ratio()` for solid pie. Round caps `cap(r,r)` for <80% sweep. Flat for >90%.

## Multi-Ring (concentric)

Each ring a different metric with its own color. `p(c,c)` centers every child on the wrapper, regardless of size:

```
$neutral=#64748B
gr s(80,80) #multi_ring
  c p(c,c) s(80,80) st[(#E2E8F0,w(5))] ratio(1)
  c p(c,c) s(80,80) st[(#6366F1,w(5),cap(r,r))] arc(90,72) ratio(1)
  c p(c,c) s(56,56) st[(#E2E8F0,w(4))] ratio(1)
  c p(c,c) s(56,56) st[(#EC4899,w(4),cap(r,r))] arc(90,55) ratio(1)
  c p(c,c) s(36,36) st[(#E2E8F0,w(3))] ratio(1)
  c p(c,c) s(36,36) st[(#F59E0B,w(3),cap(r,r))] arc(90,90) ratio(1)
  t("Activity",Inter,11,m,align(c)) p(c,c) f[($neutral.50)]
```
