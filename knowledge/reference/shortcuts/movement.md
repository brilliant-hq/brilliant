---
name: "knowledge-shortcuts-movement"
description: "Nudge shortcuts, the measurement overlay, and move, resize, and rotation modifiers."
assumes: reference/shortcuts
---

# Shortcuts: Movement

| Action | Shortcut |
|--------|----------|
| Nudge selection 1px (up/down/left/right) | Arrow keys (ids `move_elements_up`, `_down`, `_left`, `_right`) |
| Nudge selection 10px | Shift+Arrow keys (ids `move_elements_*_fast`) |
| Enter move mode | (no default, id `enter_move_mode`) |

### Measurement Overlay

| Modifier | Effect |
|----------|--------|
| Alt/Option + Hover | Show distance measurements between selection and hovered element |

### Move Modifiers (While Dragging)

| Modifier | Effect |
|----------|--------|
| Alt/Option | Duplicate while moving |
| Shift | Constrain movement to one axis |

### Resize Modifiers (While Dragging Handle)

| Modifier | Effect |
|----------|--------|
| Shift | Proportional (maintain aspect ratio) |
| Ctrl | Scale mode: proportional resize + scales font sizes, strokes, corner radii, and descendant elements |
| Cmd | Preserve crop position (image stays in place) |

**Scale mode toggle (K):** Pressing K enables persistent scale mode: all resizes behave as if Ctrl is held until K is pressed again, you switch tools, or you press Escape (Escape keeps your selection). See `reference/tools/move`.

### Rotation Modifiers

| Modifier | Effect |
|----------|--------|
| Shift | Snap to 15-degree increments |
