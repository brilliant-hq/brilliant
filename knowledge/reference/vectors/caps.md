---
name: "knowledge-vectors-caps"
description: "Per-node stroke caps (none, round, square, arrow, circle) and when to use vectors vs other elements."
assumes: reference/vectors
---

# Vectors: Stroke Caps and When to Use Vectors

## Stroke Caps (Per-Node)

Vector path endpoints (leaf nodes with degree 1) can have individual stroke caps. Select a vector that has a stroke, then configure caps in the **right toolbar's stroke section**:

| Cap Type | Description |
|----------|-------------|
| **None** | Butt cap (no extension past the endpoint) |
| **Round** | Semicircle cap (default) |
| **Square** | Extends by half the stroke thickness past the endpoint |
| **Arrow** | Arrowhead pointing outward along the path tangent |
| **Circle** | Filled dot marker at the endpoint |

- **Two-endpoint open paths** (lines, simple curves) and **circle arcs** (sweep < 100%) show separate start-cap and end-cap dropdowns side by side for independent control.
- **Multi-endpoint vectors** (3+ leaf nodes) show a unified dropdown that sets all endpoints to the same cap.

Arrow caps scale with stroke width automatically. This makes arrows out of a line or curve without any separate triangle element.

## When to Use Vectors vs Other Elements

| Visual Element | Use |
|----------------|-----|
| Icons | Built-in SVG icons (~1,515 names, each in two weights: regular and fill, so ~3,000 SVGs), not hand-drawn vectors |
| Sparklines, trend lines | Vector with a stroke and smooth curves |
| Area charts (filled region under a curve) | A closed vector path with both fill and stroke |
| Straight or diagonal arrows | A line with an arrow stroke cap |
| Arrows connecting two elements | A line whose endpoints anchor to the two elements (auto-routes) |
| Curved / freeform arrows | A vector curve with an arrow stroke cap |
| Simple colored rectangles | Rectangle element |
| Circles, dots | Circle element |
| Progress rings | A circle stroked as a track plus a circle arc for the progress |

To author vectors, arrows, sparklines, area charts, and per-region fills via the DSL (path syntax, connector routing, region IDs), see the blueprint knowledge files. For complete chart patterns, see the chart knowledge files (sparklines, bar charts, line charts).
