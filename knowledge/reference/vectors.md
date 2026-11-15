---
name: "knowledge-vectors"
description: "Pen tool, pencil tool, vector path creation, node/handle editing, point types, vector snapping, boolean operations, flatten, and outline text in Brilliant's interface."
---

# Vectors

This file covers how a user works with vector paths by hand: the drawing tools, vector edit mode, node and handle editing, point types, snapping, booleans, flatten, and outline text. For authoring vectors programmatically (path syntax, per-region fills, arrows via the DSL), see the blueprint knowledge files.

Each part has its own key:

- `reference/vectors/access`: reaching the Pen, the Pencil, and vector edit mode
- `reference/vectors/pen`: drawing with the Pen tool and the Pencil tool
- `reference/vectors/nodes`: selecting, moving, and adding nodes, moving disconnected regions
- `reference/vectors/handles`: deleting nodes and edges, Bezier handles
- `reference/vectors/point-types`: Straight, Mirrored, Asymmetric, Disconnected, and when they change
- `reference/vectors/transform`: the node sub-selection box, numeric fields, copy/cut/paste nodes, the companion
- `reference/vectors/node-snaps`: snapping while dragging nodes, and why the grid wins
- `reference/vectors/handle-snaps`: snapping while dragging handles, the six snap toggles
- `reference/vectors/caps`: per-node stroke caps, and when to use vectors vs other elements

Booleans live in `reference/editing/booleans`, Flatten in `reference/editing/flatten`, Outline Text and Flatten Text in `reference/editing/outline-text`.
