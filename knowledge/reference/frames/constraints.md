---
name: "knowledge-frames-constraints"
description: "Min/max size constraints on auto layout frames and children, and pin constraints for children of resized containers."
assumes: reference/frames
---

# Size and Pin Constraints

## Min / Max Size Constraints

Auto layout frames and their direct children can carry minimum and maximum width/height constraints (Figma parity). A ruler-icon toggle at the right end of the Element section's W/H sizing row (shown whenever the selection is an auto layout frame or a direct child of one) reveals two rows: Min W + Min H, then Max W + Max H. Unset shows "None". To clear a constraint, pick "None" from the field's dropdown, or type 0, or drag below 0.

How they behave:

| Sizing | Effect |
|--------|--------|
| Hug | The hugged result clamps: the frame stops growing at its max (content overflows, clipped if Clip Content is on) and never shrinks below its min |
| Fill | The child fills up to its max / at least its min. Excess space freed by a capped child goes to the other Fill siblings; a floored child forces siblings smaller |
| Fixed | The size clamps to the min/max range. Manually resizing a constrained element snaps to the bound live during the drag |

If min is set above max, min wins. Constraints survive manual resize and rotation (only the sizing mode converts to Fixed, as usual). Blueprint: `min(w,h)` and `max(w,h)` after `s()`, empty slot skips an axis. Constraints round-trip through Figma import and Send to Figma.

## Pin Constraints

A child of a container whose box does not follow its children (a Frame, Component, Instance, or non-hug Group) holds its place when that container is resized according to its **pin constraints** (Figma parity). The **pin row** in the right toolbar's Element section (below the W/H sizing row) pairs Figma's nine-nub widget on the left (click a nub to pin that edge, opposite nubs to stretch, the center nub to center) with two dropdowns on the right: horizontal (Left, Right, Center, Left and right, Scale) and vertical (Top, Bottom, Center, Top and bottom, Scale). The default is Left / Top (inside an icon-like component's content the default reads as Scale; see below).

Per axis, five kinds:

| Kind | On container resize |
|------|---------------------|
| Left / Top (default) | Keep the leading offset (distance from the left/top edge). This is the pre-constraint behavior: parent-local position is preserved. Exception: inside an icon-like instance it scales |
| Right / Bottom | Keep the trailing offset (distance from the right/bottom edge), so the child rides that edge |
| Center | Keep the child center's offset from the container center |
| Left and right / Top and bottom | Keep both edge offsets, so the child grows and shrinks with the container |
| Scale | Interpolate both edges proportionally to the size change |

A resize is any change of the container's size: dragging it, typing W/H, an `s()` on its row, and, for an auto layout frame, its content growing or shrinking a Hug axis or its parent resizing a Fill axis. A right-pinned absolute badge rides the right edge of a hug toolbar as the toolbar grows. Resizing a component instance moves its children by their pins too (a child pinned Scale scales, its path included), and no child override is recorded. In an icon-like instance (vector content only: no text, auto layout, nested instance, slot or image) a Left / Top child scales like Scale, stroke weight kept; any other pin opts out.

**Where the row shows:** children of Frames, Components, Instances, and non-hug Groups. It is **hidden** wherever pins are dormant, with no gray-out state. An auto layout flow child shows sizing / flex instead; toggle **Absolute Position** to restore its pins, which then hold it within the auto layout frame. A hug Group's children hide the row entirely (their pins wake only once the group is resized to a fixed size). Top-level elements have no pins.

Blueprint: `pin(H,V)`, H in `l/r/c/lr/scale`, V in `t/b/c/tb/scale`, absent = `pin(l,t)` (for example `r p(260,12) s(20,20) pin(r,t)` pins a close button to the top-right corner). Constraints import verbatim from Figma (LEFT_RIGHT to stretch, SCALE to scale, CENTER to center, RIGHT / BOTTOM to max) and round-trip through Send to Figma.
