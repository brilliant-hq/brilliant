---
name: "knowledge-canvas-scroll"
description: "Scroll wheel and trackpad gestures, the zoom percentage field, and Disable Zoom Out."
assumes: reference/canvas
---

# Canvas: Scroll, Trackpad, Zoom Percentage

### Scroll and Trackpad

- Scroll wheel: pans the canvas (vertical scroll = vertical pan)
- **Shift+scroll wheel:** pans horizontally (Figma/Penpot convention). Tilt-wheel x-deltas are folded in.
- Cmd+scroll wheel: zooms around cursor position
- Trackpad two-finger drag: pans the canvas
- Trackpad pinch: zooms around focal point
- Cmd+trackpad drag: zooms around cursor position
- **Middle-mouse drag:** temporarily swaps to the Hand tool while held (same as holding Space). Cursor flips to grabbing; bottom toolbar reflects the mode. Release to return to the previous tool.

### Zoom Percentage

Displayed in the right toolbar header. The percentage is a draggable value (drag horizontally to adjust interactively). It is per-canvas and updates on canvas switch.

### Disable Zoom Out

**Cmd+Ctrl+D** (Alt+D on Windows) toggles a clamp that prevents zooming below 100% and constrains pan to canvas bounds. Useful for overlay mode and presentations.
