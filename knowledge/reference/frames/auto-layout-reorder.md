---
name: "knowledge-frames-auto-layout-reorder"
description: "Reordering auto layout children by drag and arrow keys, and what common operations do to an auto layout frame."
assumes: reference/frames
---

# Auto Layout Reorder

## Reordering Children Inside Auto Layout

Inside auto layout, children are reordered rather than freely positioned (for non-absolute children only).

**Drag reorder:**
1. Select and drag a flow child
2. An insertion indicator (line perpendicular to main axis) shows placement
3. Release to drop, siblings reflow

In wrapped layouts, the insertion index is computed in 2D (find the row/column first, then position within it). Hold **Space** to prevent reparenting during drag (works across all parent types).

**Keyboard reorder** (arrow keys with auto layout child selected):
- Horizontal layout: ← move earlier, → move later
- Vertical layout: ↑ move earlier, ↓ move later
- Cross-axis arrow keys are ignored
- Absolute children get nudged like normal elements (no reorder)

## What Happens On Operations

| Operation | Effect on auto layout frame |
|-----------|----------------------------|
| Resize a child | Converts to Fixed sizing, re-layouts |
| Rotate a child | Converts to Fixed sizing, re-layouts |
| Delete a child | Siblings reflow |
| Add a child | Re-layouts automatically |
| Arrow keys | Reorders flow children along main axis (absolute children nudge normally) |
| Drag within frame | Drag-reorder for flow children, free move for absolute children |
| Drag to different frame | Reparents both, both re-layout |
| Toggle absolute position | Removes from / re-inserts into flow |
