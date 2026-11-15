---
name: "knowledge-vectors-handle-snaps"
description: "Snap types while dragging Bezier handles and the six vector-edit snap toggles."
assumes: reference/vectors
---

# Vectors: Handle Snapping and Toggles

### Handle Snapping

While dragging a Bezier handle, handle-specific snaps and the alignment snap compete; the closest wins:

| Snap Type | Description |
|-----------|-------------|
| **Collinear** | Handle is opposite another handle on the same node (straight line through the node). |
| **Symmetric** | Collinear + same length as the opposite handle. |
| **H/V mirror** | Handle is the horizontal/vertical mirror of another handle on the same node. |
| **Perpendicular** | Handle is at 90 degrees from another handle on the same node. |
| **Angle matching** | Handle angle matches a handle on another node. |
| **Edge tangent / perpendicular** | Handle is parallel to, or 90 degrees from, an adjacent straight edge. |
| **15-degree increments** | Handle angle snaps to the nearest 15-degree multiple. |
| **Curve extrema** | Handle length makes the curve's H/V extremum land on a horizontal/vertical line. |
| **Golden ratio / one-third** | Handle length is approximately 0.55 or 0.33 of the chord length (pleasant cubic-Bezier defaults). |
| **Length matching** | Handle length matches any other handle (any angle). |

### Snap Toggles

Six toggles control vector-edit snapping. None have default keybindings; reach them via the palette or assign keys via **Shift+?**:

- **Vector snapping enabled** (master gate, default ON): disables all vector snaps when off.
- **Snap to self** (default ON): snap to nodes/handles on the editing vector.
- **Snap to others** (default ON): snap to sibling vector elements.
- **Snap to geometry** (default ON): snap to non-vector sibling element corners and centers.
- **Snap to grids** (default ON): snap to pixel grid, parent frame edges, and layout guides.
- **Snap to path curves** (default ON): snap to on-curve points and path intersections.

Pixel-grid snapping is a separate toggle (**Shift+Cmd+'**) shared with element editing.
