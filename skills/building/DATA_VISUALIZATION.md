---
name: "building-data-visualization"
description: "Data visualization: tables, bar charts, sparklines, stacked bars, line charts, horizontal bars, progress rings, heatmaps."
---

# Data Visualization

Charts, tables, and visualization patterns. Load for any dashboard, analytics, or data product task.

> **Adapt freely.** These show how data visualizations are constructed. Change colors, dimensions, data points, and structure. If your chart has the exact same values as an example below, you haven't adapted enough.

> **Chart cards typically benefit from shadows** to lift them off the background. The examples below include them as good defaults — adapt to your design's personality (see TECHNIQUES.md). A minimal dashboard may use borders only; a rich analytics page wants layered shadows on every card.

## Clip-Outside-Stroke Technique

Hide strokes on specific edges of a closed vector path. Used by sparkline area fills and line chart area fills — any path where curve edges need visible stroke but closing edges don't.

**Three-part technique:**

1. **Close the path** at the bounding box boundary (add nodes at bottom corners + straight edges)
2. **Outside stroke** (`o`) — pushes boundary-edge strokes beyond the bounding box
3. **Clip frame** — `al(v,pad(SW,0,0,0)) s(hug,hug) clip` crops the pushed-out strokes

```
{id} al(v,pad(2,0,0,0)) s(hug,hug) clip "ClipFrame"
  {id} v(nodes[...curve nodes...,(N,W,H),(N+1,0,H)],edges[...curve edges...,(N-1,N),(N,N+1),(N+1,0)],closed) s(W,H) f[(f1,solid(#hex,0.12))] st[(s1,#hex,1.5,n,n,o)] "Shape"
```

**Rules:**
- **ONE vector** with both fill and stroke — never two separate vectors
- Clip frame MUST be `s(hug,hug)` — `s(fill,...)` stretches the vector
- Top padding >= stroke width (e.g., `pad(2,0,0,0)` for 1.5px stroke)
- Bottom/left/right padding = 0 so closing-edge strokes get clipped

## Data Table

Uses the **Row-Major Grid** pattern from LAYOUTS.md. Each row is `al(h)` with children matching the same sizing per column position.

**Data-specific rules:**
- `g(0)` on the table frame so rows touch (no spacing between)
- Alternate row fills (`#F8FAFC` on even rows) for visual rhythm
- **Column alignment:** Every row (header + body) must use the **same sizing per column position** — `s(fill,hug)` for flexible columns, `s(fill:N,hug)` for weighted columns (e.g., name `fill:3` wider than status `fill:1`), `s(100,hug)` for known-width columns (status, actions, dates). This ensures fill columns split the same remaining space in every row
- Use `g(12)` (not `spaceBetween`) for consistent inter-column spacing
- Header text: `Inter,13,sb` in `#64748B`. Body text: `Inter,14` in `#0F172A`

## Bar Chart

Uses the **Bottom-Aligned Columns** pattern from LAYOUTS.md. Each bar + label wrapped in a column:

```
al(v,g(8),pad(16)) s(hug,hug) f[(f1,#FFFFFF)] st[(s1,#E2E8F0,1)] rd(12) clip shadow(#000000,o(0.06),y(1),blur(3)) shadow(#000000,o(0.04),y(2),blur(8)) "Chart"
  t("Monthly Revenue",Inter,14,sb) f[(f1,#0F172A)] "Title"
  al(h,a(s,e),g(4)) s(hug,120) "Cols"
    al(v,a(e,c),g(4)) s(hug,fill) "Col"
      r s(24,40) f[(f1,#3B82F6)] rd(3,3,0,0) "Bar"
      t("Jan",Inter,10,m,c) f[(f1,#94A3B8)] "Label"
    al(v,a(e,c),g(4)) s(hug,fill) "Col"
      r s(24,72) f[(f1,#3B82F6)] rd(3,3,0,0) "Bar"
      t("Feb",Inter,10,m,c) f[(f1,#94A3B8)] "Label"
    al(v,a(e,c),g(4)) s(hug,fill) "Col"
      r s(24,90) f[(f1,#3B82F6)] rd(3,3,0,0) "Bar"
      t("Mar",Inter,10,m,c) f[(f1,#94A3B8)] "Label"
    al(v,a(e,c),g(4)) s(hug,fill) "Col"
      r s(24,65) f[(f1,#3B82F6)] rd(3,3,0,0) "Bar"
      t("Apr",Inter,10,m,c) f[(f1,#94A3B8)] "Label"
```

### Bar Chart Rules

| Rule | Why |
|------|-----|
| Columns are `s(hug,fill)`, NOT `s(hug,hug)` | `fill` height gives `e` alignment room to push bars down. `hug` collapses and bars top-align |
| Cols container is `s(hug,N)` or `s(fill,N)` | `hug` for standalone, `fill` when inside a card. Fixed height sets the chart area |
| Column main axis is `e` | Pushes bar+label stack to bottom of column — bars grow upward |
| Bar radius is `rd(N,N,0,0)` | Rounded top, flat bottom — bars sit flush on the baseline |
| Use `g()` on Cols, not `spaceBetween` | `g()` gives uniform spacing. `spaceBetween` stretches unevenly with mixed-width columns |

### Variants

- **Value labels:** Add a value text above the bar inside the same column (`g(2)` for tight spacing)
- **Grouped/paired:** Wrap paired bars in `al(h,a(s,e),g(2)) s(hug,hug)` inside each column. Use narrower bars (16px). Add a legend with dot + label pairs
- **Mixed-width:** Wider bars (48px) with gradient fills for important items, narrower (28px) with lighter fills for secondary

## Horizontal Bar Chart

Each row: fixed-width label + bar + value text. Proportional bar width represents the data value.

**Static variant** (fixed pixel widths):

```
al(v,g(16),pad(24)) s(hug,hug) f[(f1,#FFFFFF)] st[(s1,#E2E8F0,1)] rd(16) clip shadow(#000000,o(0.06),y(1),blur(3)) shadow(#000000,o(0.04),y(2),blur(8)) "Chart"
  t("Top Features",Inter,14,sb) f[(f1,#0F172A)] "Title"
  al(v,g(8)) s(hug,hug) "Rows"
    al(h,a(s,c),g(8)) s(hug,hug) "Row"
      t("Search",Inter,12,m) s(56,hug) f[(f1,#0F172A)] "Lbl"
      r s(200,20) f[(f1,linear(90,#3B82F6,#2563EB))] rd(0,4,4,0) "Bar"
      t("2,412",Inter,11,b) f[(f1,#3B82F6)] "Val"
    al(h,a(s,c),g(8)) s(hug,hug) "Row"
      t("Filter",Inter,12,m) s(56,hug) f[(f1,#0F172A)] "Lbl"
      r s(150,20) f[(f1,#3B82F6)] rd(0,4,4,0) "Bar"
      t("1,800",Inter,11,b) f[(f1,#64748B)] "Val"
    al(h,a(s,c),g(8)) s(hug,hug) "Row"
      t("API",Inter,12,m) s(56,hug) f[(f1,#0F172A)] "Lbl"
      r s(38,20) f[(f1,#93C5FD)] rd(0,4,4,0) "Bar"
      t("450",Inter,11,b) f[(f1,#64748B)] "Val"
```

**Key:** Labels use uniform fixed width (`s(56,hug)`) so bars start at the same X. Bar radius `rd(0,4,4,0)` — flat left, rounded right. Bar width = `max_bar_width × (value / max_value)`. Top item gets gradient fill, lower items lighter fills.

**Flex variant** (responsive — bars resize with parent, no pixel math):

```
a1b2c3d4e5f70010 al(v,g(16),pad(24)) s(fill,hug) f[(f1,#FFFFFF)] st[(s1,#E2E8F0,1)] rd(16) clip shadow(#000000,o(0.06),y(1),blur(3)) shadow(#000000,o(0.04),y(2),blur(8)) "Chart"
  a1b2c3d4e5f70011 t("Top Features",Inter,14,sb) f[(f1,#0F172A)] "Title"
  a1b2c3d4e5f70012 al(v,g(8)) s(fill,hug) "Rows"
    a1b2c3d4e5f70013 al(h,a(s,c),g(8)) s(fill,hug) "Row"
      a1b2c3d4e5f70014 t("Search",Inter,12,m) s(56,hug) f[(f1,#0F172A)] "Lbl"
      a1b2c3d4e5f70015 al(h) s(fill,20) "Track"
        a1b2c3d4e5f70016 r s(fill:2412,fill) f[(f1,linear(90,#3B82F6,#2563EB))] rd(0,4,4,0) "Bar"
        a1b2c3d4e5f70017 r s(fill:588,fill) "Empty"
      a1b2c3d4e5f70018 t("2,412",Inter,11,b) f[(f1,#3B82F6)] "Val"
    a1b2c3d4e5f70019 al(h,a(s,c),g(8)) s(fill,hug) "Row"
      a1b2c3d4e5f7001a t("Filter",Inter,12,m) s(56,hug) f[(f1,#0F172A)] "Lbl"
      a1b2c3d4e5f7001b al(h) s(fill,20) "Track"
        a1b2c3d4e5f7001c r s(fill:1800,fill) f[(f1,#3B82F6)] rd(0,4,4,0) "Bar"
        a1b2c3d4e5f7001d r s(fill:1200,fill) "Empty"
      a1b2c3d4e5f7001e t("1,800",Inter,11,b) f[(f1,#64748B)] "Val"
    a1b2c3d4e5f7001f al(h,a(s,c),g(8)) s(fill,hug) "Row"
      a1b2c3d4e5f70020 t("API",Inter,12,m) s(56,hug) f[(f1,#0F172A)] "Lbl"
      a1b2c3d4e5f70021 al(h) s(fill,20) "Track"
        a1b2c3d4e5f70022 r s(fill:450,fill) f[(f1,#93C5FD)] rd(0,4,4,0) "Bar"
        a1b2c3d4e5f70023 r s(fill:2550,fill) "Empty"
      a1b2c3d4e5f70024 t("450",Inter,11,b) f[(f1,#64748B)] "Val"
```

Each row wraps the bar in a `s(fill,20)` track frame. Bar uses `fill:VALUE`, empty uses `fill:(SCALE - VALUE)` with the same SCALE for all rows (here 3000). Chart and rows use `s(fill,hug)` so fill children have a concrete width ancestor. Bars stay proportional when the chart resizes.

**When to use which:** Flex when the chart lives inside a resizable container (dashboard cards, responsive layouts). Static when you need exact pixel control or the chart width is fixed.

## Line Chart with Axes

Uses a **Frame Overlay** pattern — gridlines, axis labels, and data curves overlap in the same `fr` (hug×hug, clip) space. Data curves use `mi` (mirrored) node types for **auto-smooth bezier curves** — no manual handle coordinates needed:

```
al(v,g(12),pad(24)) s(hug,hug) f[(f1,#FFFFFF)] st[(s1,#E2E8F0,1)] rd(16) clip shadow(#000000,o(0.06),y(1),blur(3)) shadow(#000000,o(0.04),y(2),blur(8)) "Chart"
  al(h,a(sb,c)) s(380,hug) "Header"
    t("Revenue Over Time",Inter,14,sb) f[(f1,#0F172A)] "Title"
    al(h,a(s,c),g(16)) s(hug,hug) "Legend"
      al(h,a(s,c),g(4)) s(hug,hug) "LR"
        r s(8,8) f[(f1,#3B82F6)] rd(9999) "Dot"
        t("Revenue",Inter,11,m) f[(f1,#64748B)] "Lbl"
      al(h,a(s,c),g(4)) s(hug,hug) "LP"
        r s(8,8) f[(f1,#10B981)] rd(9999) "Dot"
        t("Profit",Inter,11,m) f[(f1,#64748B)] "Lbl"
  fr s(hug,hug) clip "Body"
    r p(44,0) s(336,1) f[(f1,#F1F5F9)] "G5"
    r p(44,26) s(336,1) f[(f1,#F1F5F9)] "G4"
    r p(44,52) s(336,1) f[(f1,#F1F5F9)] "G3"
    r p(44,78) s(336,1) f[(f1,#F1F5F9)] "G2"
    r p(44,104) s(336,1) f[(f1,#F1F5F9)] "G1"
    r p(44,130) s(336,1) f[(f1,#F1F5F9)] "G0"
    t("$50K",Inter,10,m) p(0,-6) f[(f1,#94A3B8)] "Y5"
    t("$40K",Inter,10,m) p(0,20) f[(f1,#94A3B8)] "Y4"
    t("$30K",Inter,10,m) p(0,46) f[(f1,#94A3B8)] "Y3"
    t("$20K",Inter,10,m) p(0,72) f[(f1,#94A3B8)] "Y2"
    t("$10K",Inter,10,m) p(0,98) f[(f1,#94A3B8)] "Y1"
    t("$0",Inter,10,m) p(0,124) f[(f1,#94A3B8)] "Y0"
    v(nodes[(0,0,104,mi),(1,28,91,mi),(2,56,78,mi),(3,84,65,mi),(4,112,52,mi),(5,140,58,mi),(6,168,46,mi),(7,196,39,mi),(8,224,33,mi),(9,252,26,mi),(10,280,20,mi),(11,308,13,mi),(12,336,7,mi)]) p(44,0) s(336,130) st[(s1,#3B82F6,2)] "Revenue"
    v(nodes[(0,0,117,mi),(1,28,111,mi),(2,56,104,mi),(3,84,98,mi),(4,112,91,mi),(5,140,97,mi),(6,168,85,mi),(7,196,78,mi),(8,224,72,mi),(9,252,65,mi),(10,280,59,mi),(11,308,52,mi),(12,336,39,mi)]) p(44,0) s(336,130) st[(s1,#10B981,2)] "Profit"
  al(h,a(sb,c),pad(0,0,0,44)) s(380,hug) "X Axis"
    t("Jan",Inter,10,m,c) f[(f1,#94A3B8)] "X1"
    t("Mar",Inter,10,m,c) f[(f1,#94A3B8)] "X2"
    t("May",Inter,10,m,c) f[(f1,#94A3B8)] "X3"
    t("Jul",Inter,10,m,c) f[(f1,#94A3B8)] "X4"
    t("Sep",Inter,10,m,c) f[(f1,#94A3B8)] "X5"
    t("Nov",Inter,10,m,c) f[(f1,#94A3B8)] "X6"
```

**Structure:** Body is `fr s(hug,hug) clip` — a clipped frame where children overlap freely. Gridlines are 1px rects at `p(44,Y)` (offset for Y-axis labels). Y labels at `p(0,Y)` aligned with gridlines (Y minus ~6px). Data curves use `v()` with `mi` nodes at `p(44,0)` sharing the plot bounding box — edges are auto-generated sequentially and handles are auto-computed. X-axis labels use `al(h,a(sb,c))` with `pad(0,0,0,44)` to align with plot area. Adapt by recalculating Y positions: `y = chart_height × (1 - value / max_value)`.

### Area Fill on Line Charts

Uses the **Clip-Outside-Stroke** technique above. Close the curve at the bottom, add gradient fill, use outside stroke + clip frame. Curve nodes use `mi` for auto-smooth; bottom-closing nodes stay `st` (straight):

```
    al(v,pad(2,0,0,0)) p(44,0) s(hug,hug) clip "RevClip"
      v(nodes[(0,0,104,mi),(1,28,91,mi),...same curve nodes...,(12,336,7,mi),(13,336,130),(14,0,130)],edges[(0,0,1),(1,1,2),...same curve edges...,(11,11,12),(12,12,13),(13,13,14),(14,14,0)],closed) s(336,130) f[(f1,linear(180,stop(#3B82F6,0,0.12),stop(#3B82F6,1,0)))] st[(s1,#3B82F6,2,n,n,o)] "Revenue"
```

Position the clip frame at `p(44,0)` inside the group — same offset as the plot area.

## Sparkline

Compact inline chart. Three node type strategies create wildly different looks:

| Strategy | Node types | Look | Use for |
|----------|-----------|------|---------|
| All `mi` | Smooth flowing curves | Polished, organic | Revenue, users, growth |
| All `st` (default) | Angular/jagged segments | Raw, volatile | Latency, stock price, errors |
| Mixed `mi` + `st` | Smooth baseline + sharp spikes | Realistic, data-like | Alerts, incidents, bursts |

**Coordinates:** `(0,0)` = top-left (highest value), `(W,H)` = bottom-right (lowest). For area fills, close at bottom with nodes at `(W,H)` and `(0,H)`.

### 1. Volatile Zigzag — Stroke Only

All `st` (default) — no type needed. Angular segments, no curves. Open path, edges auto-generated:

```
v(nodes[(0,0,16),(1,10,6),(2,18,20),(3,28,4),(4,38,18),(5,48,8),(6,60,2)]) s(60,24) st[(s1,#EF4444,1.5)] "Sparkline"
```

Jagged look suits latency, error rates, volatile metrics. Use red/amber stroke for warning indicators.

### 2. Smooth Growth with Pullback — Area Fill

All `mi` for flowing curves. Node 3 dips back up (y=17 vs y=14) for a realistic micro-pullback. Uses **Clip-Outside-Stroke** technique:

```
al(v,pad(2,0,0,0)) s(hug,hug) clip "Spark"
  v(nodes[(0,0,22,mi),(1,12,18,mi),(2,28,14,mi),(3,38,17,mi),(4,50,10,mi),(5,60,4,mi),(6,60,24),(7,0,24)],edges[(0,0,1),(1,1,2),(2,2,3),(3,3,4),(4,4,5),(5,5,6),(6,6,7),(7,7,0)],closed) s(60,24) f[(f1,linear(180,stop(#3B82F6,0,0.15),stop(#3B82F6,1,0)))] st[(s1,#3B82F6,1.5,n,n,o)] "Line"
```

Gradient `linear(180,stop(#hex,0,0.15),stop(#hex,1,0))` fades from ~15% opacity at top to 0% at bottom. For simpler fills use `solid(#hex,0.12)`.

**WRONG:** Two separate vectors (fill-only + stroke-only). ALWAYS one vector with both fill and stroke, wrapped in a clip frame.

**Common mistake:** `s(fill,N)` on the clip frame or vector stretches the sparkline. **Always `s(hug,hug)` on clip frame, fixed size on vector.**

**Scaling to larger area charts:** The same pattern works at any size — scale up coordinates, keep the structure. Every node MUST have 3 or 4 values: `(index, x, y)` or `(index, x, y, type)`. Two-value nodes like `(0,28)` are **invalid** — always include both x and y. The closing nodes (bottom-right, bottom-left) are always straight (no type suffix): `(N,width,height),(N+1,0,height)`.

### Realistic Path Shapes

**Pick a DIFFERENT path archetype for each sparkline on the canvas** — never reuse the same shape. Match the archetype to the metric:

| Metric type | Archetype | Technique |
|---|---|---|
| Revenue, MRR, users | Gradual upward + 1-2 pullbacks | All `mi`, vary X spacing |
| Latency, response time | Flat with isolated sharp spikes | `mi` baseline + `st` spike tips |
| Error rate, incidents | Near-zero + sudden bursts | `mi` near-bottom + `st` burst peaks |
| Stock price, volatility | Rapid zigzag, big amplitude | All `st` for angular feel |
| Storage, plan upgrades | Flat → step jump → flat | `st` at step edges, `mi` on flats |
| Conversion, engagement | Seasonal dip in middle, recovers | All `mi`, dip node mid-path |

**Fake tells to avoid:**

| Fake tell | Fix |
|---|---|
| Every sparkline same shape | Different archetype per metric |
| Evenly spaced X coordinates | 3-4px during change, 6-8px during plateaus |
| Uniform oscillation amplitude | Mix 6-8px swings with 2-3px |
| Perfectly smooth upward curve | Add 1-2 pullback nodes |
| Symmetric rises and falls | Steeper drops than rises |
| Sine wave pattern | Irregular periods, random amplitudes |

## Stacked Horizontal Bar

Segmented bar using flex — proportional segments that resize with parent, no pixel math:

```
al(h) s(280,12) rd(9999) clip "Stacked Bar"
  r s(fill:40,fill) f[(f1,#6366F1)] "Segment 1"
  r s(fill:30,fill) f[(f1,#818CF8)] "Segment 2"
  r s(fill:20,fill) f[(f1,#EC4899)] "Segment 3"
  r s(fill:10,fill) f[(f1,#F97316)] "Segment 4"
```

`fill:40` + `fill:30` + `fill:20` + `fill:10` = 40%/30%/20%/10% split. Parent `rd(9999) clip` rounds the ends — no per-segment corner radius needed. Change the parent to `s(fill,12)` and it stretches with its container.

**Legend:** Dot + label pairs in `al(h,g(16))`:
```
al(h,a(s,c),g(16)) s(hug,hug) "Legend"
  al(h,a(s,c),g(6)) s(hug,hug) "Item"
    r s(8,8) f[(f1,#6366F1)] rd(9999) "Dot"
    t("Deep Sleep",Inter,12) f[(f1,#64748B)] "Label"
```

## Circular Progress Ring

Uses `arc(start,sweep)` on circle elements — no vector math needed. Track = full circle stroke, arc = circle with `arc()` for the filled portion.

```
al(v,a(c,c),g(8)) s(hug,hug) "Ring"
  gr s(80,80) "Graphic"
    c s(80,80) st[(s1,#E2E8F0,4)] ratio(1) "Track"
    c s(80,80) st[(s1,#3B82F6,4,r,r)] arc(0,75) ratio(1) "Arc"
    t("75%",Inter,18,b,c) p(0,28) s(80,24) f[(f1,#0F172A)] "Pct"
  t("Revenue",Inter,11,m,c) f[(f1,#64748B)] "Label"
```

**Structure:** Track and arc are the same size — both `s(80,80)` — so the arc stroke overlaps the track stroke exactly. Arc = `arc(0,75)` starts at top, fills 75%. Center text = `p(0,28)` + `s(80,24)` centered. Round caps (`r,r`) on arc stroke.

### arc(start,sweep) Syntax

`arc(start,sweep)` — two values:
- **start** — degrees (0–360). **0° = TOP (12 o'clock)**, clockwise. Where the arc begins. IMPORTANT: This is NOT the math convention where 0° = right. For progress rings starting at top, use `arc(0,N)` — never `arc(270,N)`.
- **sweep** — percentage (0–100). How much of the circle to fill.

`ratio(n)` — optional, separate property:
- **n** — 0 to 1. Inner radius as fraction of outer. 0 = solid/stroke arc. >0 = ring/donut shape.

Omitting `arc()` = full circle (default). Omitting `ratio()` = 0 (solid). **Always use `ratio(1)` for progress rings and spinners.**

### Examples

**Progress ring (84%):** `c s(80,80) st[(s1,#3B82F6,4,r,r)] arc(0,84) ratio(1)`

**Cap choice for arcs:** Round caps (`r,r`) extend beyond the arc endpoints. At >90% sweep, round ends overlap — the start and end caps visually merge. **Omit caps (default flat) for arcs above 90%.** Round caps look best under ~80%.

| Sweep | Caps | Example |
|-------|------|---------|
| < 80% | Round (`r,r`) | `st[(s1,#3B82F6,4,r,r)] arc(0,75) ratio(1)` |
| 80–90% | Either works | `st[(s1,#3B82F6,4,r,r)] arc(0,84) ratio(1)` |
| > 90% | Flat (omit) | `st[(s1,#3B82F6,4)] arc(0,95) ratio(1)` |

**Gradient progress ring (84%):** `c s(80,80) st[(s1,angular(#3B82F6,#8B5CF6),4,r,r)] arc(0,84) ratio(1)` — angular gradient follows the arc naturally.

**Pie sector (25%):** `c s(80,80) f[(f1,#3B82F6)] arc(0,25)`

**Donut sector (50%):** `c s(80,80) f[(f1,#FF6B35)] arc(0,50) ratio(0.5)`

**Full donut ring:** `c s(80,80) f[(f1,#3B82F6)] ratio(0.5)`

**Starting at 90° (3 o'clock):** `c s(80,80) st[(s1,#10B981,4,r,r)] arc(90,50) ratio(1)`

### Multi-Ring Dashboard Widget

```
al(v,a(c,c),g(8)) s(hug,hug) "Ring Card"
  gr s(80,80) "Graphic"
    c s(80,80) st[(s1,#E2E8F0,5)] ratio(1) "Track Outer"
    c s(80,80) st[(s1,#3B82F6,5,r,r)] arc(0,78) ratio(1) "Outer"
    c p(12,12) s(56,56) st[(s1,#E2E8F0,4)] ratio(1) "Track Inner"
    c p(12,12) s(56,56) st[(s1,#10B981,4,r,r)] arc(0,62) ratio(1) "Inner"
    t("78%",Inter,14,b,c) p(0,30) s(80,20) f[(f1,#0F172A)] "Pct"
  t("Completion",Inter,11,m,c) f[(f1,#64748B)] "Label"
```

**Color by status:** Blue (`#3B82F6`) neutral, green (`#10B981`) on-track, amber (`#F59E0B`) warning, red (`#EF4444`) critical.

## Contribution Heatmap

Uses the **Column-Major Grid** pattern from LAYOUTS.md. Each week = vertical column of 7 cells, weeks flow horizontally.

**Data-specific details:**
- **Cell size:** `s(11,11)` with `rd(2)` and `g(3)` between cells
- **Day labels:** `al(v,g(3))` column with invisible spacer frames (`s(24,11)`) for Tue/Thu/Sat/Sun positions — maintains the same 11px+3px stride as grid cells
- **Month labels:** Fixed width `s(70,hug)` matching ~5 weeks of cells. Left padding `pad(0,0,0,30)` offsets for day label column
- **Legend:** `al(h,a(e,c),g(4))` with 5 color swatches from Less to More

**5-level intensity scale:**

| Level | Color | Meaning |
|-------|-------|---------|
| 0 (empty) | `#EBEDF0` | No activity |
| 1 (low) | `#9BE9A8` | Low |
| 2 (medium) | `#40C463` | Medium |
| 3 (high) | `#30A14E` | High |
| 4 (max) | `#216E39` | Maximum |

Adapt colors freely — blues for coding, purples for design, reds for incidents.
