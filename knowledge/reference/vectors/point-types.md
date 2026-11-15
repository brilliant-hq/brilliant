---
name: "knowledge-vectors-point-types"
description: "Node point types (Straight, Mirrored, Asymmetric, Disconnected) and what changes them automatically."
assumes: reference/vectors
---

# Vectors: Point Types

### Point Types

Each node has a **point type** controlling how its Bezier handles behave. Select a node (or one of its handles) in vector edit mode to see the point type row in the **right toolbar's Element section**.

| Type | Behavior |
|------|----------|
| **Straight** | No handles. Sharp corner with straight edges on both sides. |
| **Mirrored** | Handles mirror each other (same direction, same length). |
| **Asymmetric** | Handles stay co-linear (same angle through the node) but lengths are independent. |
| **Disconnected** | Each handle is fully independent. |

Click the point type button in the right toolbar to change it. The four commands (**Set Point Type to Straight**, **Set Point Type to Mirrored**, **Set Point Type to Asymmetric**, **Set Point Type to Disconnected**) are also in the palette and Shortcuts panel. None have default keybindings; assign one via **Shift+?** if needed.

**Nodes with 3+ edges:** the point type row is grayed out. Mirrored/Asymmetric constraints only apply to 2-edge nodes (where there is a single "opposite" handle).

**Automatic point type changes:**

| Trigger | Resulting point type |
|---------|---------------------|
| Click + drag while placing a node (Pen) | Mirrored |
| Alt/Option + drag while placing a node (Pen) | Disconnected |
| Cmd+Click a node to add handles | Mirrored |
| Cmd+Click to remove handles | Straight |
| Alt/Option drag a handle | Disconnected |
| Normal drag breaks symmetry of a Mirrored node | Disconnected |
| Shape converted to vector (curved segment) | Mirrored |
| Shape converted to vector (straight segment) | Straight |
