---
name: "knowledge-frames-nesting"
description: "Nesting parents, reparenting by drag, and converting between parent types."
assumes: reference/frames
---

# Nesting, Reparenting and Converting

## Nesting

Parents nest in any combination:
- **Enter** to drill into a parent
- **Shift+Enter** to select the parent
- Layers explorer (Cmd+Shift+J) shows hierarchy

## Reparenting

Drag elements over a parent to auto-reparent:
- **Frame** and **Auto Layout** parents are reparent targets. Auto Layout shows an insertion indicator
- **Group**, **Mask**, **Boolean** parents are NOT reparent targets
- Children inside Group/Mask/Boolean cannot be dragged out (use the layers explorer or convert to Frame first)
- Coordinates auto-transform to target's local space
- Hold **Space** during drag to prevent reparenting
- **Moving many layers into a small frame asks first.** When the layers come from 2 or more frames and together are bigger than the target frame (wider or taller), dropping them asks "Move N layers into <frame>?". **Move** (Enter) lands them as one undo step; **Cancel** leaves everything exactly where it was. The same question appears when dragging such a selection onto a frame row in the layers panel, pasting a cut there, and pasting copied layers from several frames into a selected smaller frame (on the canvas or in the layers panel). Only the layers that would move in count: one already inside the frame is not counted. One layer, layers from one frame, or a frame big enough never asks

## Converting Between Types

The inspector has no parent type menu. The doors in the app: **Convert to Frame** (right-click menu after Ungroup, or the command palette) turns a group into a frame; Shift+A or the Layout section's switch adds auto layout, and its None turns auto layout back into a frame; **Use as mask** in the Element section un-masks a mask. There is no door from a frame to a group (group the children with Cmd+G instead) and no switch between boolean operations (create the other operation instead). The table below is what each conversion does wherever it happens.

Common conversions:

| From → To | Effect |
|-----------|--------|
| Frame → Group | Forces Hug on both axes, clears auto layout settings |
| Frame → Auto Layout | Infers direction, spacing, alignment, padding from current child positions; sorts children spatially along the main axis |
| Frame → Boolean | Forces Hug, clears auto layout settings, **clears fills/strokes** (only when the source is not already a Boolean or Mask), renames |
| Frame → Mask | Forces Hug, clears auto layout settings, clears fills/strokes (only when the source is not already a Boolean or Mask), renames to "Mask" |
| Group → Frame | Unlocks sizing |
| Group → Auto Layout | Infers layout, unlocks sizing |
| Auto Layout → Frame | Clears auto layout settings, children keep current positions |
| Auto Layout → Group | Clears auto layout settings, forces Hug on both axes |
| Boolean ↔ Boolean | Preserves fills/strokes, renames |
| Boolean ↔ Mask | Preserves fills/strokes |
| Mask → non-mask non-boolean | Standard conversion, keeps fills/strokes |

**Auto-conversion:** Changing a Group's sizing from Hug on either axis automatically converts it to a Frame.

**Side effect:** Converting an auto layout parent to any non-auto-layout type **removes the absolute-position flag** from all children.
