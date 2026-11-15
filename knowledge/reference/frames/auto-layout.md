---
name: "knowledge-frames-auto-layout"
description: "Auto layout (Shift+A): creating it, zero layout shift, and what is inferred at creation."
assumes: reference/frames
---

# Auto Layout (Shift+A)

Auto layout frames flow children in a row or column, with optional wrap.

## Creating Auto Layout

1. Select elements
2. Press **Shift+A**
3. Direction, spacing, padding, and cross-axis alignment are inferred from element positions

**Zero layout shift:** wrapping never rearranges your design. The frame
reproduces the selection's current arrangement exactly: elements keep their
canvas positions whenever the arrangement fits the flow model (one axis, one
gap, one alignment), and near-misses within half a pixel snap cleanly to the
inferred alignment. A bottom-aligned row of mixed-height elements stays a
bottom-aligned row.

**Inference applied at creation:**

| Field | With 2+ elements | With a single element |
|-------|------------------|-----------------------|
| Direction | From shape, not just spread: elements that sit beside each other (side-by-side boxes, even of very different heights) read as a row; stacked ones read as a column. Ambiguous scatters fall back to the wider spread | Horizontal |
| Main-axis alignment | Start | Start |
| Cross-axis alignment | The alignment that moves elements least (a cleanly aligned top/center/bottom edge is detected exactly) | Start |
| Spacing | Mean gap between consecutive elements, signed: overlapping chains (avatar stacks) infer a negative gap and keep overlapping. Fractional gaps are kept (quantized to 2dp) | 10 |
| Padding (all four sides) | 0 | 0 |
| Wrap | Off | Off |

Order follows spatial position along the flow axis; elements at the same
position keep their existing z-order. When overlapping elements flow in the
opposite order to their z-order (an avatar stack whose leftmost sits on top),
the frame gets **Canvas stacking: First on top** so nothing changes what
paints over what (see auto-layout-controls).

The new auto layout frame is created Hug on both axes.
