---
name: "knowledge-frames-auto-layout-absolute"
description: "Absolute position: auto layout children that opt out of the layout flow."
assumes: reference/frames
---

# Absolute Position

Children of auto layout frames can opt out of layout flow with **absolute positioning**. An absolute child stays nested (clipping, coordinate space, z-order) but does not participate in positioning, spacing, or hug sizing. It moves and resizes freely.

**Toggle:**
- Pin button in the right toolbar's **Element** section position row (next to the Y field), or
- Palette → "Toggle Ignore Auto Layout"

The pin button only appears when at least one selected element is inside an auto layout frame.

**Use cases:** badges, notification dots, floating buttons, watermarks, decorative overlays.

**Behavior:**
- Excluded from gap, spacing, and hug calculations
- Excluded from drag reorder and arrow-key reorder (arrow keys nudge them like normal elements)
- Toggling back to flow re-inserts at the element's z-order position
- Absolute flag is **stripped automatically** when the parent is converted to a non-auto-layout type
