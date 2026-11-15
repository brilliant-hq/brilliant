---
name: "knowledge-vectors-handles"
description: "Deleting nodes and edges, and adding, removing, and dragging Bezier handles in vector edit mode."
assumes: reference/vectors
---

# Vectors: Deleting and Bezier Handles

### Deleting Nodes and Edges

- Select nodes and press **Delete** or **Backspace**. A deleted node with exactly 2 edges is dissolved by reconnecting its neighbors with one edge that preserves the surrounding handles. Other cases remove the node and its edges. Paths that drop below 2 nodes delete the whole element (undo restores).
- Selecting **handles** (not nodes) and pressing Delete sets those handles to null (collapses to a straight segment) without removing nodes.
- **Shift+Click an edge** to delete it (a red highlight previews on hover). If removing an edge leaves a node with no edges, that node is removed too.

### Bezier Handles

- **Toggle handles on a node:** Cmd+Click a node to add or remove handles. Adding handles sets point type to **Mirrored**; removing them sets it to **Straight**.
- **Remove a single handle:** Cmd+Click one handle endpoint. If the node ends up with no handles, its point type becomes **Straight**.
- **Drag a handle:** the opposite handle's behavior depends on the node's point type at drag start:

| Point type at drag start | Normal drag | Alt/Option+drag |
|--------------------------|-------------|-----------------|
| Mirrored | Opposite handle mirrors direction + length | Only the dragged handle moves |
| Asymmetric | Opposite handle rotates to stay co-linear, length preserved | Only the dragged handle moves |
| Disconnected | Only the dragged handle moves | Only the dragged handle moves |
| Straight | Only the dragged handle moves | Only the dragged handle moves |

If a normal drag breaks symmetry on a Mirrored node, the point type auto-transitions to **Disconnected** at drag end. Holding **Alt/Option** while dragging a handle moves only that handle and permanently sets the node to **Disconnected**. Hold **Shift** during a handle drag for extra geometric snaps (see `reference/vectors/handle-snaps`). Dragging a handle within a few pixels of its node retracts it to zero (collapses to no handle on that side).
