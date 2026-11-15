---
name: "knowledge-frames-masks"
description: "Masks: creating with Ctrl+Cmd+M, editing the mask shape, mask types, and mask properties."
assumes: reference/frames
---

# Masks (Ctrl+Cmd+M)

A mask uses one element to clip others, like a cookie cutter. The **topmost element** (last in z-order) becomes the clip shape; everything below is clipped to it.

## Creating a Mask

1. Select 2+ elements
2. Press **Ctrl+Cmd+M** (or right-click → Mask, or palette → "Mask")
3. A Mask parent wraps the selection (per-parent: one mask per source parent)

**At creation:**
- The mask shape includes **stroke geometry** in the clip (a circle with a thick stroke masks a wider area than its fill alone)
- The mask shape is invisible in normal mode
- Mask defaults: Hug on both axes, no fill, no stroke, clip content off (clipping is done by the mask shape, not by bounds)

## Editing the Mask Shape

- **Double-click** into the mask to enter edit mode with the layer under the cursor selected: the mask shape becomes visible and editable
- Modify it (resize, change arc, edit vector nodes, etc.); the clip path updates live
- **Escape** or click outside to exit

## Mask Types

| Type | Description |
|------|-------------|
| Vector (default) | Clip via the mask shape's vector outline including stroke geometry |
| Alpha | Not selectable in the UI |
| Luminance | Not selectable in the UI |

The active masking type is always Vector. Alpha and Luminance round-trip through saved files but cannot be selected via the right toolbar.

## Mask Properties

- **Sizing**: always Hug on both axes
- **Fill, stroke, corner radius, effects**: fills/strokes are painted on the combined result shape
- **Tip**: any element type can be the mask shape (rectangle, circle, vector, text). Reorder children in the layers explorer to change which is the mask shape (last/topmost = mask).
