---
name: "knowledge-effects-properties"
description: "Drop shadow, outer glow and element blur properties, ranges and defaults."
assumes: reference/effects
---

# Effect Properties

Numeric fields can be typed directly, or scrubbed by dragging their leading symbol (the X, the Y, the blur icon); a field with no leading symbol is typed only. Opacity displays as 0-100% in the UI.

## Drop Shadow

| Property | Range | Default |
|----------|-------|---------|
| X offset | -200 to 200 | 0 |
| Y offset | -200 to 200 | 4 |
| Blur | 0 to 200 | 8 |
| Spread | -100 to 100 | 0 |
| Color | Any | Black |
| Opacity | 0 to 100% | 25% |
| Blend Mode | Any of the standard blend modes | Normal |
| Show Behind Transparent Areas | toggle | off |

**Show Behind Transparent Areas:** when off (default), the element's shape is knocked out of the shadow (Figma-style). When on, the shadow shows through transparent fills. This toggle is exposed in the UI for drop shadow only.

## Outer Glow

| Property | Range | Default |
|----------|-------|---------|
| Blur | 0 to 200 | 8 |
| Spread | -100 to 100 | 0 |
| Color | Any | White |
| Opacity | 0 to 100% | 60% |
| Blend Mode | Any | Screen |

Outer glow is symmetric: there are no X/Y offset fields in the inspector (it always emanates evenly).

## Element Blur

| Property | Range | Default |
|----------|-------|---------|
| Radius | 0 to 200 | 4 |

Element Blur has no color or blend mode. The effect row still shows the inline opacity % field (shared by all effect rows), but opacity has no rendering effect for a blur. Element Blur blurs the entire element (fills, strokes, drop shadows, and outer glows) as one unit, inside the element's opacity layer.
