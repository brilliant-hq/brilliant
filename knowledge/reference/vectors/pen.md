---
name: "knowledge-vectors-pen"
description: "Drawing vector paths with the Pen tool (clicks, drags, constraints) and the Pencil tool (freehand)."
assumes: reference/vectors
---

# Vectors: Pen and Pencil

## Pen Tool

The Pen tool creates vector paths by placing nodes one at a time with optional Bezier curve control.

### Basic Usage

1. Activate the Pen tool.
2. **Click** to place a corner node (straight edges to/from the previous node).
3. **Click and drag** to place a node with mirrored Bezier handles (smooth curve).
4. Continue clicking/dragging to add more nodes.
5. **Click the first node** of an open path to close it into a shape.
6. Press **Escape** to finish.

### Straight Lines vs Curves

- **Click** (no drag): the new node is a **Straight** corner (no handles).
- **Click and drag**: pulls out symmetric Bezier handles. Drag direction sets curve direction, drag distance sets curve intensity. The new node's point type is **Mirrored**.
- **Alt/Option + drag** while placing a node creates only the outgoing handle (the incoming handle stays at the node); the node's point type is set to **Disconnected**.
- Alternate freely between clicks and drags to mix sharp corners and smooth curves.

### Constraints While Drawing

- Hold **Shift** while clicking the next point to constrain the new edge angle to 15-degree increments from the previous node.
- Hold **Shift** while dragging out handles to snap the handle angle to 15-degree increments.
- Snap guides also fire if vector snapping is enabled (see `reference/vectors/node-snaps`).

### Tips

- Closed paths can have fills and strokes; open paths render strokes only.
- After creation, refine in vector edit mode (select the path, press **Enter**).
- With the Pen tool active, clicking on an existing edge inserts a node into that path rather than starting a new disconnected segment.

## Pencil Tool

The Pencil tool creates freehand vector paths by drawing with the mouse.

1. Activate the Pencil tool (**Shift+P**).
2. Click and drag on the canvas to draw.
3. Release to finish the stroke.

The captured points are smoothed into a cubic Bezier path with mirrored handles. The result is a standard vector element editable in vector edit mode. The Pencil produces **open paths with strokes** (no fill); it never auto-closes. Hold **Shift** during the drag to constrain segments to 45-degree directions. Very short taps (fewer than 2 sample points) are discarded.
