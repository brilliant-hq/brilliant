---
name: "knowledge-editing-resizing"
description: "Resize handles, corner radius handles, resize modifiers, resizing in auto layout, child pins, and W/H fields."
assumes: reference/editing
---

# Editing: Resizing

### Resize Handles

A selection shows an 8px square at each corner (drag to resize both axes); each **edge** resizes one axis anywhere along its length, within about 5px of the line on either side. The corner grab area is a 16px square, so a corner is easy to hit. For a single rotated element, handles align to the element's oriented bounding box (with an extra square at each edge midpoint) and its edges resize along their full rotated length. Multi-element selections always show axis-aligned handles, one rectangle per parent.

Small selections stay easy to work with: their handles sit just outside the object, so dragging the middle of a small object moves it rather than resizing it. When the selection's smaller side is under 8px on screen (a thin divider, say) the squares are hidden, but the corners and edges still resize.

### Corner Radius Handles

A selected rectangle or frame (including auto layout frames, components and instances) shows a small round handle inside each corner when you hover it; a frame also shows them while you hover anything inside it. Groups, masks and boolean shapes have no corner radius handles. The handle sits at the center of the corner's curve, so the same radius puts it at the same spot on any rectangle; at radius 0 it sits about 12px in from the corner. Drag it toward the center to round the corners and back to sharpen them; the handle follows the curve under your cursor. Hold **Shift** to snap to 5px steps, **Option/Alt** to change only that corner. Dragging an instance's corner radius records it as an override on that instance.

### Resize Modifiers

| Modifier | Effect |
|----------|--------|
| **Shift** | Maintain aspect ratio |
| **Alt/Option** | Symmetric resize from center (both sides/corners move equally from the geometric center) |
| **Ctrl** | Scale mode: proportional resize that also scales font sizes, stroke thicknesses, corner radii, effects, and descendants |
| **Cmd** | Crop-compensate image/shader fills (visible image content stays in place rather than stretching) |

Dragging past an anchor flips the element; the resize continues smoothly past zero. Lines and 2-point arrows have a dedicated endpoint resize: only the two diagonal corner handles are active (start and end points). Shift on a line constrains the endpoint to 45-degree angles.

**Scale mode toggle (K):** Instead of holding Ctrl during every resize, press **K** to enable persistent scale mode. The Move tool stays active but every resize scales content proportionally and the cursor switches to the rescale icon. Press K again, switch tools, or press Escape to exit.

### Resize in Auto Layout

Resizing a child in auto layout converts that axis to **fixed** sizing with the new dimension. The parent recalculates layout immediately. Hug/fill ancestors propagate the size change up the tree.

### Container Resize (Child Pins)

Resizing a Frame, Component, Instance, or non-hug Group moves and stretches its children according to each child's **pin constraints** (set in the Element section's pin row; see `reference/frames`). Per axis, independently:

- **Left / Top** (the default): the child keeps its parent-local position. This is identical to the behavior before pins existed, so a design that never sets a non-default pin resizes exactly as it used to.
- **Right / Bottom**: the child keeps its offset from the container's trailing edge and rides the right/bottom edge.
- **Center**: the child keeps its center's offset from the container center.
- **Left and right / Top and bottom** (stretch): the child keeps both edge offsets, growing and shrinking with the container.
- **Scale**: both edges move proportionally, scaling the child with the container.

Resizing a **hug Group** converts it to a fixed-size group and activates its children's pins (dormant while the group hugs). Auto layout flow children are positioned by the flow, not by pins; an absolute-positioned auto layout child pins within its frame.

### Precise Dimensions

The right toolbar shows W and H fields with an aspect-ratio lock icon. All numeric fields support math expressions and natural language (e.g., `* 2/3`, `double`, `50%`, `round 8`). See `reference/ui`.
