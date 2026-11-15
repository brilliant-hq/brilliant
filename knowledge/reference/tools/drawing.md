---
name: "knowledge-tools-drawing"
description: "Drawing modifiers and the Pen, Pencil, Line, and Arrow tools."
assumes: reference/tools
---

# Tools: Drawing Modifiers, Pen, Pencil, Line, Arrow

## Drawing Modifiers

| Modifier | Effect |
|----------|--------|
| Shift (while dragging) | Constrains proportions: perfect square (Rectangle, Frame, Snip), perfect circle (Circle), 45 degree angle (Line, Arrow, Pencil), 15 degree angle (Pen node placement and handle drag) |
| Space (while dragging) | Repositions the in-progress element without resizing it |
| Alt (Pen handle drag) | Creates disconnected handles (each side independent) instead of mirrored |
| Pixel-grid snap | Default on. Start and end points round to integer pixels on axes where element-to-element snap did not win. Toggled with Shift+Cmd+' |

## Pen Tool (P)

Creates vector paths node by node with optional bezier handles. The Pen tool stays active while the path is open, and the editor stays in vector edit mode so additional nodes can be added. Double-clicking on empty canvas, pressing Escape twice, or switching tools finishes the path and returns to Move.

| Modifier | Effect |
|----------|--------|
| Shift (placing nodes) | Constrains next node position to 15 degree increments from the last node |
| Alt (dragging bezier handles) | Creates disconnected handles (each side independent) instead of mirrored |
| Shift (dragging bezier handles) | Snaps handle angle to 15 degree increments |

Vector edit mode is also entered by double-clicking an existing vector element with the Move tool (once a click selects it; a vector inside a container takes one double-click per level first). Inside vector edit mode: drag nodes, drag bezier handles, marquee-select nodes, copy/cut/paste/delete nodes, and align nodes (alignment commands operate on selected nodes). Boolean edit mode is similar but operates on a boolean parent's children.

## Pencil Tool (Shift+P)

Freehand vector paths from a sampled mouse trail. Drag to draw; release to finish. The resulting element is a vector with editable nodes. Shift constrains segments to 45 degree increments while drawing.

## Line Tool (L)

Straight lines between two points. Shift snaps to 45 degree increments.

## Arrow Tool (Shift+L)

A line with an end-cap arrowhead. Shift snaps to 45 degree increments. Start and end caps are independently configurable in the right toolbar's stroke section: none, round, square, arrow, circle (filled dot marker).
