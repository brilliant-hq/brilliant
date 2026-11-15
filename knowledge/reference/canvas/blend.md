---
name: "knowledge-canvas-blend"
description: "Blend modes at element, fill, stroke, and effect scope, the 18 supported modes, and rendering performance."
assumes: reference/canvas
---

# Canvas: Blend Modes and Rendering

## Blend Modes

Brilliant supports blend modes at four scopes: element, fill, stroke, and effect. All default to Normal.

| Scope | Where to set it | What it composites |
|-------|-----------------|--------------------|
| Element | Blend-mode dropdown in the right toolbar's element/canvas section (next to opacity) | Entire element (all fills + strokes + effects) against the canvas underneath |
| Fill | Blend-mode control on a fill row (right toolbar Fill section) | This single fill against the canvas underneath |
| Stroke | Blend-mode control on a stroke row (right toolbar Stroke section) | This single stroke against the canvas underneath |
| Effect | Blend-mode dropdown on a drop shadow / outer glow / element blur (right toolbar Effects section). Inner shadow and inner glow carry their own blend mode (inner glow defaults to Screen). | Per-effect output |

Element-level blend mode wraps the whole element in a single composite layer so its fills, strokes and effects composite normally with each other first, then the unit blends against the canvas. Fill, stroke, and effect modes are independent and apply only to their own render pass.

Supported modes (18): Normal, Darken, Multiply, Color Burn, Plus Darker, Lighten, Screen, Color Dodge, Plus Lighter, Overlay, Soft Light, Hard Light, Difference, Exclusion, Hue, Saturation, Color, Luminosity. Plus Darker (Figma's Linear Burn) and Plus Lighter (Linear Dodge) are the additive/subtractive pair, grouped with the darken and lighten families. In the Blueprint DSL they are `blend(plusDarker)` / `blend(plusLighter)`. All 16 classic modes export cleanly to SVG (`mix-blend-mode`) and PDF; Plus Lighter/Plus Darker have no portable SVG/PDF equivalent and fall back to Normal in those exports (the canvas and PNG/JPEG/WebP raster export render them faithfully).

## Rendering Performance

Brilliant renders all canvas content through a native GPU engine that scales to very large canvases (tens of thousands of elements) automatically; no user action or mode switching is needed.

### Studio vs Overlay screen capture

When the canvas is zoomed/panned in overlay mode, the OS desktop image is captured and painted as the background behind the canvas content. In studio mode this is skipped (capture would record the app's own window); the void background fills the area instead.
