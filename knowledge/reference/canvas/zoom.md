---
name: "knowledge-canvas-zoom"
description: "Canvas zoom shortcuts, zoom behavior and limits, and zoom to content (fit all, zoom to selection, center)."
assumes: reference/canvas
---

# Canvas: Zoom

### Zoom Shortcuts

| Action | Shortcut |
|--------|----------|
| Zoom in (2x, viewport-centered) | Cmd+= |
| Zoom out (0.5x, viewport-centered) | Cmd+- |
| Zoom 100%, 200%, ..., 900% | 1, 2, 3, 4, 5, 6, 7, 8, 9 (Move or Hand tool only, no text input, no palette). Pressing the same digit twice resets to 100%. |
| Toggle zoom | 0 (Move or Hand tool only) toggles between 100% and the previously-zoomed state. With no previous state it jumps to 200%. |
| Cmd+scroll, Cmd+trackpad drag | Zoom around cursor |
| Trackpad pinch | Zoom around focal point |

Note: there is no built-in "Zoom to 100%" Cmd+0 binding. `0` alone (without Cmd) is `toggle_zoom`; Cmd+0 focuses chat session 10. To jump to 100% explicitly, press `1`.

### Zoom Behavior

- **Multiplicative steps:** Cmd+= and Cmd+- zoom by 2x and 0.5x (100% to 200% to 400% to 800%)
- **Max zoom:** 25600% (256x)
- **Min zoom:** 2% (0.02x), unless "Disable Zoom Out" (Cmd+Ctrl+D) is active, which clamps to 100% and constrains pan to canvas bounds
- **Keyboard zoom (Cmd+= and Cmd+-):** centers on the viewport
- **Cmd+scroll, Cmd+trackpad drag, trackpad pinch:** zoom around the cursor
- **Smooth animation:** zoom transitions ease smoothly, so retargeting mid-flight stays smooth. Toggle via "Toggle Zoom Animation" command (no default shortcut).
- **Per-canvas zoom state:** each canvas remembers its own zoom and pan; switching canvases restores them. The first time a canvas with content is opened, the viewport zoom-fits to its bounds automatically.

### Zoom to Content

| Action | Shortcut | Description |
|--------|----------|-------------|
| Fit all content | Cmd+Ctrl+A | Zoom and pan to show all elements on the canvas |
| Zoom to selection | Cmd+Ctrl+F | Zoom and pan to fit the current selection. Falls back to fit-all when nothing is selected. |
| Center on selection | Cmd+Ctrl+C (macOS; unbound on Windows) | Pan to center the selection without changing zoom |
| Reset zoom | (no default; `reset_zoom`) | Snap back to 100% and zero pan; user-bindable |
| Toggle zoom | 0 (Move or Hand tool only) | Toggle between 100% and the previously-zoomed state. With no previous state it jumps to 200%. |

Fit all content, zoom to selection and center on selection frame the content in the part of the canvas you can see: between the left and right panels (when they are open) and between the top tabs and the bottom toolbar. Closing a panel gives its space back to the next fit.

**Windows remaps:** the Cmd+Ctrl+* chords above collapse onto essential Ctrl commands on Windows, so three are re-homed to Alt: Fit all content = Alt+A, Zoom to selection = Alt+Z, Disable zoom out = Alt+D. Center on selection is unbound on Windows (palette only).
