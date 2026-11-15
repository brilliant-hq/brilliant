---
name: "knowledge-editing-rotation"
description: "Rotation handles, keyboard rotation levels, and flipping."
assumes: reference/editing
---

# Editing: Rotation and Flipping

### Rotation Handles

Rotation lives diagonally outside each corner: past the corner square, out to about 16px further, in the area outside both edges that meet at that corner. Just outside an edge is always resize, never rotate. Drag to rotate around the selection center. Hold **Shift** to snap to 15-degree increments.

### Keyboard Rotation

Keyboard rotation uses a clock-position metaphor. Each level sets an absolute rotation in 30-degree increments: level 0 is 0 degrees (12 o'clock); levels 1-9 are N times 30 degrees.

| Level | Clock | Angle |
|-------|-------|-------|
| 0 | 12 | 0° |
| 1 | 1 | 30° |
| 2 | 2 | 60° |
| 3 | 3 | 90° |
| 4 | 4 | 120° |
| 5 | 5 | 150° |
| 6 | 6 | 180° |
| 7 | 7 | 210° |
| 8 | 8 | 240° |
| 9 | 9 | 270° |

| Action | Shortcut | Amount |
|--------|----------|--------|
| Set rotation to level 0-9 | Cmd+Ctrl+0 through Cmd+Ctrl+9 | absolute (above) |
| Rotate clockwise | Cmd+Ctrl+Shift+= | +15° (relative) |
| Rotate counter-clockwise | Cmd+Ctrl+- | -15° (relative) |

You can also type an exact angle in the rotation field in the right toolbar.

## Flipping

| Action | Shortcut | What it does |
|--------|----------|------|
| Flip horizontally | Shift+H | Mirrors across the vertical axis |
| Flip vertically | Shift+V | Mirrors across the horizontal axis |

Flipping is a per-element property toggle, not a geometry rebuild. Children of flipped frames render flipped via the rendering transform.
