---
name: "knowledge-vectors-node-snaps"
description: "Snap guides while dragging vector nodes, holding Cmd to place freely, and why the pixel grid wins."
assumes: reference/vectors
---

# Vectors: Node Snapping

## Snap Guides in Vector Mode

When snap guides are enabled, precision snapping works during vector editing for both node dragging and handle dragging.

### Node Snapping

While dragging a node, these snap types compete cooperatively:

| Snap Type | Description |
|-----------|-------------|
| **Alignment** | Node aligns with other nodes (same or sibling vectors), with non-vector element corners/centers, with parent frame inner edges, and with layout grids. |
| **Edge length matching** | A straight edge incident to the dragged node matches the length of another straight edge. |
| **Edge angle matching** | A straight edge becomes parallel, anti-parallel, or perpendicular to a reference edge on the same vector. |
| **Path geometry** | Node snaps to the closest point on any Bezier curve in a reference vector. |
| **Path intersection** | Node snaps to where two path edges cross. |
| **Spacing / equidistant** | Equal gap between nodes, or node centered between two references. |

Hold **Shift** while dragging a node to snap the displacement angle to 15-degree increments (overrides the snap pipeline). Ghost dots appear on other vectors at the reference points that triggered the snap.

Hold **Cmd** (Ctrl on Windows/Linux) while dragging a node or a handle and snapping stops entirely for as long as you hold it: no guides, no capture, no pixel rounding. Let go and it comes straight back.

**The grid is the truth.** While **Snap to grids** is on (the default), a node always lands on a whole pixel. Targets that do not sit on a whole pixel are not offered at all, and curve, edge-length and edge-angle snaps land on the nearest whole pixel to their answer. This is what keeps node dragging steady: without it a node could be pinned to an off-grid neighbour on one axis while the grid rounded the other, and small hand movements made it jump back and forth. The trade is that a neighbour at a fractional coordinate (common after importing or scaling artwork) offers no target while the grid is on. Turn **Snap to grids** off to align to it, or hold Cmd for that one node.
