---
name: "knowledge-editing-measurement"
description: "Alt+hover measurement overlays between the selection and a hovered element."
assumes: reference/editing
---

# Editing: Measurement Overlays (Alt+Hover)

Hold **Alt/Option** and hover a **non-selected** element (a selection must already exist, and you must not be dragging) to show Figma-style distance guides between the selection and the hovered target. Pure read-only: it never moves or changes elements and has no undo footprint.

Three cases, by what you hover:

- **Element to element:** the gap between the two boxes; if they also overlap on the other axis, the edge-to-edge alignment offset for that axis is shown too.
- **Frame padding:** hover a frame that contains selected children to see the four paddings from the children's union box to the frame edges.
- **Child-to-frame padding:** with a frame selected, hover one of its children to see that child's four paddings to the frame edges.

Distances use geometric bounds (no stroke inflation), so they never jump with stroke width. The measurement line is **solid** with a numeric pixel label; extension connectors (drawn when the line misses the target's extent) are dashed. Guides recompute after every command, so nudging the selection with arrow keys while Alt is held keeps the numbers live against the same hovered target. Alt detection is cross-platform (Option on macOS, Alt on Windows/Linux).
