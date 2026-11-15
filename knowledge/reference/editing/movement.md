---
name: "knowledge-editing-movement"
description: "Drag to move, arrow-key nudge, duplicate while moving, auto-reparenting, snap guides, pixel grid snap, and X/Y fields."
assumes: reference/editing
---

# Editing: Movement

### Drag to Move

Select and drag. Snap guides appear automatically. Hold **Shift** while dragging to constrain movement to the X or Y axis (whichever has the larger delta from the drag-start position).

**Reparenting during drag:** Leaving a frame reparents to root immediately. Entering a frame is **deferred until drop**: the target frame highlights while you hover, and reparenting happens on release. Holding **Cmd** during the drag drops into the parent of the deepest matching frame (useful for nested layouts).

### Nudge with Arrow Keys

| Action | Shortcut |
|--------|----------|
| Move 1px | Arrow keys |
| Move 10px | Shift+Arrow keys |

Rapid arrow-key presses are combined into a single undo entry (1 second of inactivity finalizes it). When **all** selected elements share the same auto layout parent, arrow keys **reorder** the children within that frame along the layout axis instead of nudging spatially. Mixed selections (some in auto layout, some not, or in different parents) fall back to spatial nudge.

### Duplicate While Moving

Hold **Alt/Option** while dragging to create a duplicate at the cursor while the original returns to its starting position. Releasing Alt mid-drag cancels the duplication (the duplicate is removed and the original takes the dragged position). The full hierarchy duplicates (frames with all children).

### Auto-Reparenting

Dragging elements over a frame or auto layout frame automatically reparents them on drop. The following are **not** reparent targets, so dragging over them won't reparent into them:

- Groups
- Boolean parents
- Masks
- Component instances (and anything nested inside a component instance)

Children of a group, boolean parent, or mask cannot be dragged out: they stay clipped/grouped. Holding **Space** during a drag prevents reparenting: the dragged element cannot leave its parent or be captured by another frame (an auto layout child keeps drag-reordering inside its frame). To take an auto layout child out of flow entirely, use absolute positioning (the pin button). Self-containment is also blocked: an element cannot be dropped into its own descendant.

### Snap Guides

While dragging, snap guides show alignment, spacing (gap matching), equidistant centering, and (during create/resize) sizing. Snapping operates within the **primary parent's** coordinate space; elements never snap across frame boundaries. The master snap toggle is in the right toolbar and persists per session.

### Pixel Grid Snap

Default ON. Rounds landed positions to whole-pixel boundaries, including element-snap landings: with the grid on, aligning or centering against fractional geometry lands at the nearest whole pixel and the snap guides draw at that landed pixel (like Figma), so what you see is exactly where the element sits. With the grid off, snapping is exact: flush to a fractional edge means exactly flush. Applies to drag move, arrow-key nudge, paste, corner resize, and creation. Edge resize and rotation are exempt. Toggle with **Shift+Cmd+'** (apostrophe). This is independent from the visual pixel-grid overlay toggled with **Cmd+'**.

### Precise Positioning

The right toolbar shows X and Y fields. Type exact values, drag on the field to adjust, or use math expressions and natural language (e.g., `+ 50`, `half`, `round 8`). See `reference/ui` for the full list.
