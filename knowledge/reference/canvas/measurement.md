---
name: "knowledge-canvas-measurement"
description: "Alt+hover measurement overlays on the canvas: scenarios, visual style, and behavior."
assumes: reference/canvas
---

# Canvas: Measurement Overlays

Hold **Alt** and hover over an element to see distance measurements between your selection and the hovered target. Works like Figma's measurement overlay.

### How It Works

1. **Select** one or more elements
2. **Hold Alt/Option** and hover over another element
3. Distance guides appear showing pixel values

### Three Scenarios

| Scenario | What You See |
|----------|--------------|
| **Element to element** | Horizontal and/or vertical gap distances between the two AABBs |
| **Child to parent frame** | Padding distances from selection to all 4 frame edges |
| **Frame to child** | Padding distances from hovered child to all 4 selected frame edges |

### Visual Style

Measurement guides appear as **solid lines with pixel labels**. When elements are positioned diagonally (no perpendicular overlap), thin dashed extension lines connect the measurement to each element's nearest edge.

### Behavior

| Condition | Result |
|-----------|--------|
| Hover a non-selected element with Alt held | Show distance measurements |
| Hover a parent frame with children selected | Show padding to frame edges |
| Select a frame, hover a child inside it | Show padding from child to frame edges |
| Elements touch (gap < 1px) | No measurement shown on that axis |
| Elements have a gap on one axis, overlap on the other | Gap measurement on the non-overlapping axis, plus edge offset measurements on the overlapping axis |
| Elements fully overlap on both axes | Edge offset measurements on both axes |
| Start dragging | Measurements disappear |
| Release Alt | Measurements disappear |
