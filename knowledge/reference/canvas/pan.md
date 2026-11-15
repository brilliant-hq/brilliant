---
name: "knowledge-canvas-pan"
description: "Panning the canvas (Hand tool, Space, trackpad, scroll wheel, middle mouse) and the four coordinate spaces."
assumes: reference/canvas
---

# Canvas: Pan and Coordinate Spaces

### Infinite Canvas Panning

Pan works at any zoom level, including 100% with zero offset. The only constraint is when "Disable Zoom Out" is active: pan is clamped to canvas bounds.

### Hand Tool (H)

H activates the Hand tool; click and drag pans. Press V to return to Move.

### Temporary Pan (Space)

Holding Space in any tool temporarily switches to Hand-tool pan behavior. Release returns to the previous tool.

### Two-Finger Trackpad

Two-finger drag on trackpad pans. Cmd+two-finger drag zooms around the cursor.

### Scroll-Wheel Pan

Mouse scroll wheel pans (vertical scroll = vertical pan). Shift+scroll pans horizontally. Cmd+scroll zooms around the cursor instead. Trackpad pan and hand-tool drag include momentum: a quick flick keeps gliding and decelerates after release, and stops on the next click or scroll. Mouse scroll wheel has no added momentum (the OS handles its own acceleration).

### Middle-Mouse Drag

Press and drag the middle mouse button to pan. This temporarily swaps to the Hand tool (same code path as holding Space), so the cursor shows "grabbing" and the bottom toolbar reflects the mode. Release to return to the previous tool.

## Coordinate Spaces

The canvas has four nested coordinate systems. Understanding which space a coordinate lives in matters when reasoning about positions.

| Space | What it is | Where it shows up |
|-------|-----------|-------------------|
| **Screen** | Raw pointer pixel coordinates from the OS | Pointer events, before any transform |
| **World** | Absolute canvas coordinates, after inverse zoom transform | Hit testing input, rendering output, marquee rects |
| **Parent-local** | Position relative to the element's parent frame | An element's stored X/Y position and bounds |
| **Element-local** | Geometry inside an element's own frame | Vector path nodes, internal text layout |

An element's stored X/Y/width/height are **parent-local**: relative to the frame that contains it. Top-level elements live under a synthetic root parent, so for top-level elements parent-local equals world. A child inside a rotated frame sits in a rotated parent-local space, so its world bounds are computed by rotating about the frame center.

The position shown in the right toolbar's X/Y fields is parent-local (relative to the selected element's parent frame).
