---
name: "knowledge-vectors-nodes"
description: "Selecting nodes, moving nodes, moving disconnected regions, and adding nodes on an edge in vector edit mode."
assumes: reference/vectors
---

# Vectors: Nodes

## Node Editing

Enter vector edit mode by selecting a vector element and pressing **Enter** (or double-clicking it; a vector inside a container takes one double-click per level to reach first).

### Selecting Nodes

| Action | How |
|--------|-----|
| Select a node | Click on it |
| Add to selection | Shift+Click |
| Toggle selection | Shift+Click a selected node |
| Select multiple | Drag a rectangle over nodes (rubber-band) |
| Select all nodes in path | Cmd+A while in vector edit mode |

Clicking on a region or stroke (not a node) clears the node selection and selects that part for fill/stroke editing instead. Shift+click on a region adds it to the part selection.

### Moving Nodes

Select nodes and drag.

- Hold **Shift** while dragging to snap the displacement angle (relative to the drag-start position) to 15-degree increments.
- Hold **Alt/Option** at the start of a drag to **duplicate** the selected nodes. The drag operates on the copies; originals stay put. Only edges where both endpoints are in the selection are duplicated.
- With 2+ nodes selected, dragging anywhere inside the selection box moves all selected nodes together, and a sub-selection box with resize/rotate handles appears (see `reference/vectors/transform`).
- Arrow keys nudge selected nodes (Shift+Arrow nudges faster).

### Moving Disconnected Regions

Vectors with multiple separate connected components (for example a multi-part icon or a Venn diagram) support dragging each component independently:

- **Click** on a disconnected region (fill area or stroke) to select all its nodes at once.
- **Drag** a disconnected region to move it (click-and-drag in one gesture).
- **Shift+Click** another region to add its nodes, then drag to move several regions together.

### Adding Nodes on an Edge

Hover over an existing edge: a blue circle with `+` previews where a new node will land. Click to insert. The new node splits the edge into two segments and preserves the original curvature.
