---
name: "knowledge-canvas-cursors"
description: "Keyboard selection navigation, arrow-key nudge, cursor states, and the highlights rendered during work."
assumes: reference/canvas
---

# Canvas: Navigation, Cursors, Highlights

### Selection navigation (keyboard)

| Key | Action |
|-----|--------|
| Tab | Select previous sibling (within the current parent's children, wrapping around). With nothing selected, selects the first top-level element. |
| Shift+Tab | Select next sibling (within the current parent's children, wrapping around). With nothing selected, selects the last top-level element. |
| Shift+Enter | Select parent of the current selection (Enter dives into a parent) |
| Cmd+A | Select all top-level elements |
| Escape | Clear selection (when no other Escape target consumes the event first) |

### Nudge (arrow keys)

| Key | Action |
|-----|--------|
| Arrow | Move selection 1 px |
| Shift+Arrow | Move selection 10 px |

Both nudge variants register undo and respect per-parent constraints. An edit made right after a nudge keeps both, whatever made it (a shortcut, the inspector, the AI): Undo takes the edit back first, then the nudge.

### Cursor states

| Cursor | When |
|--------|------|
| Arrow | Default (Move tool) |
| Crosshair | Drawing tools (Rectangle, Circle, Line, Arrow, Pen, Pencil, Frame, Text, Snip) |
| Open hand | Hand tool (H) idle |
| Closed hand | Hand tool dragging, or window-drag in the top toolbar bar |
| Resize arrows | Hovering a selection handle (axis-aware) |
| Rotate | Hovering diagonally outside a selection corner (outside both of its edges) |
| Eyedropper | Color pick mode (Ctrl+Shift+C; Alt+Shift+C on Windows) |
| I-beam | Hovering a text element while in Move tool |

### Highlights rendered during work

- Hover highlight: thin outline on the element under the cursor
- Selection rectangles: one per parent with selected children, plus resize/rotate handles
- Snap guides: solid alignment lines and dashed spacing/distribution/size labels
- Measurement overlays: Alt+hover shows pixel distances and frame padding
- Frame labels: above top-level frames; click selects the frame. At low zoom labels declutter: frames too small on screen drop their label, and colliding labels keep only the widest frame's name (hovered or selected frames always keep theirs)
