---
name: "knowledge-tools-frame-text"
description: "The Frame tool and frame conversions, the Text tool, the Snip tool, and the creation style."
assumes: reference/tools
---

# Tools: Frame, Text, Snip, Creation Style

## Frame Tool (F)

Creates parent containers (frames). New frames auto-capture sibling elements whose bounding box is fully contained within the frame bounds, reparenting them with z-order preserved. Frames support fills, strokes, per-corner radius, layout grids, and clip-content (clip children to bounds). Shift while dragging produces a perfect square.

Frame conversions:

| Action | Shortcut | Result |
|--------|----------|--------|
| Group selection | Cmd+G | Wraps selection in a group (always hug-sized) |
| Ungroup | Cmd+Shift+G | Removes the group, promoting children to its parent |
| Frame selection | Cmd+F | Wraps selection in a frame |
| Add auto layout | Shift+A | Wraps selection in an auto-layout frame (or converts a selected frame) |

## Text Tool (T)

Creates text elements with inline editing.

1. T activates the tool
2. Click on the canvas to place an insertion point
3. Type to enter text
4. Escape, Cmd+Enter (Ctrl+Enter on Windows), or clicking outside finishes editing (Enter and Shift+Enter insert a new line)

After commit, the tool auto-reverts to Move. Re-enter editing on an existing text element by double-clicking with Move (a text inside a group or nested frame takes one double-click per level to reach it first).

Text styling lives in the right toolbar: family, weight, size, line height, letter spacing, paragraph spacing, alignment, decoration, list style, OpenType features. Cmd+B / Cmd+I / Cmd+U toggle bold/italic/underline. Cmd+Alt+L/T/R align text left/center/right.

## Snip Tool (S)

Captures a screen region as an image element. Drag to define the capture rectangle; Shift constrains to a square. The native macOS screen capture is invoked with the snip preview rectangle hidden, so the screenshot does not include the marquee outline. The captured image becomes an image fill on a new rectangle element (no stroke). After capture, the tool auto-reverts to Move and the new element is selected. Snip is macOS-only, has no dedicated bottom-toolbar button, and is invoked with S or via the palette.

## Creation Style

The creation style decides whether new rectangles and circles include a fill, a stroke, or both. The setting persists across canvas operations until changed. The right toolbar has no checkboxes for it; the shortcuts below set it.

The fill/stroke variant shortcuts (R vs Shift+R, O vs Shift+O) set the active creation style to that single style. Pressing R or O after Shift+R or Shift+O resets the creation style to fill-only (or stroke-only respectively).
