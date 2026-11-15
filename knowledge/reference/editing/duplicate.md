---
name: "knowledge-editing-duplicate"
description: "Duplicate (Cmd+D), Alt+drag duplicate, and Delete in every context."
assumes: reference/editing
---

# Editing: Duplicate and Delete

### Duplicate

**Cmd+D** creates a copy of the selection:

- Top-level elements are placed to the right of the original, scanning rightward with a 40 px gap to find the first non-overlapping slot.
- Children inside frames are duplicated at the same relative position inside the same parent.
- Frame children and nested frames are recursively duplicated.
- Component masters are duplicated as proper instances (not raw copies); component instances preserve their link to the master.
- Duplicates are automatically selected.

**Alt/Option+drag duplicates while moving:**

- The original returns to its starting position; the duplicate moves with the cursor.
- Releasing Alt **mid-drag** removes the duplicate and the original takes the dragged position.
- Releasing Alt **at drag end** keeps the duplicate. The whole drag registers as a single undo step.
- Works with frames-with-children, components (master → instance), and across reparent boundaries.

### Vector Node Copy/Paste

See `reference/vectors/transform`.

### Delete

| Context | Behavior |
|---------|----------|
| Element(s) selected | Removes the elements and their descendants. Component masters detach all their instances first. |
| Vector edit mode, nodes selected | Deletes nodes and their connected edges. Nodes with two edges reconnect their neighbors automatically. If the path drops below 2 nodes, the element is removed. |
| Vector edit mode, only handles selected | Handles set to null (collapse to a straight segment). |
| Element with a focused fill / stroke / region | Removes only the focused part (topmost when several are selected). Repeat Delete to peel them off one by one. |
| Gradient stop focused | Removes the gradient stop. |
| Crop mode active on the deleted element | Crop mode exits first. |

All deletes are undoable. Deleting from a hug-sized parent triggers a parent resize; deleting from auto layout reflows siblings.
