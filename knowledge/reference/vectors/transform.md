---
name: "knowledge-vectors-transform"
description: "The node sub-selection transform box, numeric node and handle fields, copy/cut/paste nodes, and the companion display."
assumes: reference/vectors
---

# Vectors: Node Transform, Fields, Clipboard

### Node Sub-Selection Transform

When **2 or more nodes** are selected, a bounding box with resize and rotation handles appears around them, scoped to the node selection (not the whole element):

- Drag a corner or edge handle to scale the selected nodes within the box. Edge handles scale one axis; corner handles scale both. A collinear (zero-extent) selection disables resize on that axis.
- Drag a rotation handle (just outside the corners) to rotate the selected nodes around the box center.
- Hold **Shift** while rotating to snap to 15-degree increments.

The sub-selection box does not appear for single-node selections.

### Numeric Node/Handle Fields

When nodes or handles are selected, the right toolbar shows numeric fields: node X/Y position, and handle angle (in degrees) for a selected handle. Type values to set them precisely.

### Copy / Cut / Paste Nodes

In vector edit mode:

- **Cmd+C** copies the selected nodes plus edges where both endpoints are selected.
- **Cmd+X** copies and deletes the same set (does not remove the whole element).
- **Cmd+V** pastes: if still in vector edit mode, nodes paste into the current element with new IDs and become the selection; if not in vector edit mode, a new vector element is created from the pasted nodes and edit mode is entered.

### Companion Display

While editing vectors, a cursor companion tooltip shows contextual info: handle angle when dragging a handle, node distance when previewing pen placement, and an action hint when Cmd+hovering a node, handle, or edge.
