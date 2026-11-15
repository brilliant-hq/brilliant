---
name: "knowledge-crop-enter-exit"
description: "Entering image crop mode (double-click, Enter, the Scale Mode dropdown), the element type rules, and every way crop mode exits."
assumes: reference/crop
---

# Image Crop Mode: Entering and Exiting

## Entering Crop Mode

| Method | Behavior |
|--------|----------|
| **Double-click** an element with an image fill | Once a click selects the element (inside a group or nested frame, each double-click first goes one level deeper until it is selected), enters crop on the topmost image fill (or the focused fill, if one is currently focused in the right toolbar). For childless parent frames with image fills, double-click also enters crop. Requires the Move tool (V) active. |
| **Enter** key on a selected non-parent element with an image fill | Enters crop on the focused fill, or the topmost image fill. Not while a drag is in progress: Enter during a move, resize or selection drag does nothing and the drag finishes normally. **Does NOT enter crop on parent frames** (Enter never enters crop on frames). For childless image-fill frames, use double-click instead. |
| **Scale Mode dropdown -> Crop** | Auto-enters crop on that fill or stroke when exactly one element is selected |

When entering crop mode:
- The element is selected
- If the current scale mode is not already Crop, it is auto-converted to Crop. The crop is initialized to cover the element (visual stays the same)
- The crop overlay appears (ghost image + container brackets at corners and edge midpoints)
- An undo entry is registered when entering changed the element (the switch to Crop, or the initial cover crop). Undoing it reverts the element to its pre-entry state and exits crop mode. Re-entering an image that is already in Crop changes nothing and adds no undo entry

**Element type rules (double-click):**
- Rectangle / circle with an image fill (or image stroke) enters crop
- **Childless parent frame** with an image fill enters crop (used as a clipped image container)
- Text element enters text editing mode (NOT crop) even if it has an image fill
- Vector enters vector editing mode (NOT crop) even if it has an image fill
- **Frame with children** drills into its children (NOT crop). Only **childless** frames with an image fill enter crop

**Element type rules (Enter key):**
- Same as double-click EXCEPT parent frames are skipped entirely (no crop entry, no children drill-down)

## Exiting Crop Mode

| Action | Result |
|--------|--------|
| **Enter** | Exit, keeping the crop, same as Escape (each crop operation registered its own undo, so individual steps can still be undone afterward) |
| **Escape** | Exit (only while in crop mode and the palette is closed) |
| **Enter or Escape with the mouse still down** (mid pan, image resize or image rotate) | Exit, keeping the crop as one undo step; the rest of that drag does nothing |
| **Click outside the element** (mouseup, no drag) | Exit |
| **Double-click anywhere** | Exit |
| **Change scale mode** to Fill / Fit / Repeat | Exit (then mode change applied) |
| Canvas switch, repo switch, studio/overlay switch | Auto-exit (state cleared) |
| Delete the cropped element | Auto-exit before deletion |
| Undo/redo that invalidates crop state (element deleted, fill removed, scale mode changed) | Auto-exit |
