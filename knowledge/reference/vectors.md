---
name: "knowledge-vectors"
description: "Pen tool, pencil tool, vector path creation, node/handle editing, point types, vector snapping, boolean operations, flatten, and outline text in Brilliant's interface."
---

# Vectors

This file covers how a user works with vector paths by hand: the drawing tools, vector edit mode, node and handle editing, point types, snapping, booleans, flatten, and outline text. For authoring vectors programmatically (path syntax, per-region fills, arrows via the DSL), see the blueprint knowledge files.

## How to Access Vector Tools

### Pen Tool (Create New Paths)

Press **P** to activate the Pen tool. Also accessible via:
- **Bottom toolbar:** open the drawing-tools dropdown and select "Pen".
- **Command Palette:** open it (Cmd+Shift+P) and search "Pen".

The Pen tool stays active after a path is finished so you can immediately start another. Press **Escape** to finish/exit back to the Move tool.

### Pencil Tool (Freehand)

Press **Shift+P** to activate the Pencil tool, or pick "Pencil" from the bottom toolbar's drawing-tools dropdown / command palette.

### Vector Edit Mode (Edit Existing Paths)

To edit an existing vector element's nodes:
1. Select the vector element.
2. Press **Enter** (or double-click the element) to enter vector edit mode.
3. Edit nodes, handles, and edges (see sections below).
4. Press **Escape** to exit. The first press clears any node/handle selection; the second press exits vector edit mode.

Vector edit mode auto-converts shapes (rectangles with corner radii, circles/ellipses, lines) into editable Bezier vectors on entry, and reverts to the original shape type on exit if the geometry is unchanged. Paths that drop below 2 nodes are deleted entirely (undo restores).

Pencil-drawn elements are already vectors and need no conversion. Text cannot enter vector edit mode directly: use **Outline Text** (Cmd+Ctrl+O) or **Flatten Text** (command palette; no default shortcut) first to convert it to vector geometry (see "Outline Text and Flatten Text" below).

---

## Pen Tool

The Pen tool creates vector paths by placing nodes one at a time with optional Bezier curve control.

### Basic Usage

1. Activate the Pen tool.
2. **Click** to place a corner node (straight edges to/from the previous node).
3. **Click and drag** to place a node with mirrored Bezier handles (smooth curve).
4. Continue clicking/dragging to add more nodes.
5. **Click the first node** of an open path to close it into a shape.
6. Press **Escape** to finish.

### Straight Lines vs Curves

- **Click** (no drag): the new node is a **Straight** corner (no handles).
- **Click and drag**: pulls out symmetric Bezier handles. Drag direction sets curve direction, drag distance sets curve intensity. The new node's point type is **Mirrored**.
- **Alt/Option + drag** while placing a node creates only the outgoing handle (the incoming handle stays at the node); the node's point type is set to **Disconnected**.
- Alternate freely between clicks and drags to mix sharp corners and smooth curves.

### Constraints While Drawing

- Hold **Shift** while clicking the next point to constrain the new edge angle to 15-degree increments from the previous node.
- Hold **Shift** while dragging out handles to snap the handle angle to 15-degree increments.
- Snap guides also fire if vector snapping is enabled (see "Snap Guides in Vector Mode").

### Tips

- Closed paths can have fills and strokes; open paths render strokes only.
- After creation, refine in vector edit mode (select the path, press **Enter**).
- With the Pen tool active, clicking on an existing edge inserts a node into that path rather than starting a new disconnected segment.

## Pencil Tool

The Pencil tool creates freehand vector paths by drawing with the mouse.

1. Activate the Pencil tool (**Shift+P**).
2. Click and drag on the canvas to draw.
3. Release to finish the stroke.

The captured points are smoothed into a cubic Bezier path with mirrored handles. The result is a standard vector element editable in vector edit mode. The Pencil produces **open paths with strokes** (no fill); it never auto-closes. Hold **Shift** during the drag to constrain segments to 45-degree directions. Very short taps (fewer than 2 sample points) are discarded.

## Node Editing

Enter vector edit mode by selecting a vector element and pressing **Enter** (or double-clicking it).

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
- With 2+ nodes selected, dragging anywhere inside the selection box moves all selected nodes together, and a sub-selection box with resize/rotate handles appears (see "Node Sub-Selection Transform").
- Arrow keys nudge selected nodes (Shift+Arrow nudges faster).

### Moving Disconnected Regions

Vectors with multiple separate connected components (for example a multi-part icon or a Venn diagram) support dragging each component independently:

- **Click** on a disconnected region (fill area or stroke) to select all its nodes at once.
- **Drag** a disconnected region to move it (click-and-drag in one gesture).
- **Shift+Click** another region to add its nodes, then drag to move several regions together.

### Adding Nodes on an Edge

Hover over an existing edge: a blue circle with `+` previews where a new node will land. Click to insert. The new node splits the edge into two segments and preserves the original curvature.

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

If a normal drag breaks symmetry on a Mirrored node, the point type auto-transitions to **Disconnected** at drag end. Holding **Alt/Option** while dragging a handle moves only that handle and permanently sets the node to **Disconnected**. Hold **Shift** during a handle drag for extra geometric snaps (see "Snap Guides in Vector Mode"). Dragging a handle within a few pixels of its node retracts it to zero (collapses to no handle on that side).

### Point Types

Each node has a **point type** controlling how its Bezier handles behave. Select a node (or one of its handles) in vector edit mode to see the point type row in the **right toolbar's Element section**.

| Type | Behavior |
|------|----------|
| **Straight** | No handles. Sharp corner with straight edges on both sides. |
| **Mirrored** | Handles mirror each other (same direction, same length). |
| **Asymmetric** | Handles stay co-linear (same angle through the node) but lengths are independent. |
| **Disconnected** | Each handle is fully independent. |

Click the point type button in the right toolbar to change it. The four commands (**Set Point Type to Straight**, **Set Point Type to Mirrored**, **Set Point Type to Asymmetric**, **Set Point Type to Disconnected**) are also in the command palette and Shortcuts panel. None have default keybindings; assign one via **Shift+?** if needed.

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

---

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

Six toggles control vector-edit snapping. None have default keybindings; reach them via the command palette or assign keys via **Shift+?**:

- **Vector snapping enabled** (master gate, default ON): disables all vector snaps when off.
- **Snap to self** (default ON): snap to nodes/handles on the editing vector.
- **Snap to others** (default ON): snap to sibling vector elements.
- **Snap to geometry** (default ON): snap to non-vector sibling element corners and centers.
- **Snap to grids** (default ON): snap to pixel grid, parent frame edges, and layout guides.
- **Snap to path curves** (default ON): snap to on-curve points and path intersections.

Pixel-grid snapping is a separate toggle (**Shift+Cmd+'**) shared with element editing.

---

## Boolean Operations

Boolean operations wrap 2+ selected shapes into a boolean parent whose children remain editable. Double-click a boolean parent to drill into it; **Escape** exits boolean edit mode. If the selection is already a single boolean parent, running the same kind of command swaps its operation (for example, toggle a Union into a Subtract without re-creating the wrapper).

| Command | Default Shortcut | Result |
|---------|-----------------|--------|
| Boolean Union | Alt+Shift+U | Combine all shapes' filled areas |
| Boolean Subtract | Alt+Shift+S | Subtract front shapes from the back shape |
| Boolean Intersect | Alt+Shift+I | Keep only the overlapping area |
| Boolean Exclude | Alt+Shift+E | Keep only the non-overlapping areas (XOR) |

## Flatten

**Flatten** (`Cmd+Enter`) bakes a selection into a single vector element:

- Single primitive (rect/circle/line) -> converts to vector.
- Boolean union -> concatenates children losslessly (per-child colors preserved).
- Boolean subtract / intersect / exclude -> bakes the result via path sampling.
- Group/frame -> concatenates children losslessly.
- Multiple selected elements -> concatenates all into one path.
- Single vector -> no-op.

Use Flatten to commit a boolean result, convert a primitive into editable vector geometry, or merge a frame's children into one path.

## Outline Text and Flatten Text

These convert a selected text element into vector geometry (macOS and Windows; on other platforms the commands exist but do nothing):

- **Outline Text** (`Cmd+Ctrl+O`) converts text into a **group of per-character vector outlines**: each glyph becomes its own editable vector inside a group. On Windows the chord collides with another command, so reach it via the menu, command palette, or context menu.
- **Flatten Text** (command palette; no default keyboard shortcut) converts text into a **single compound vector element** (all glyphs merged into one path).

Each converted glyph is a **single clean outline** with its counters (the holes in letters like e, o, a) preserved as holes, so a stroke or effect traces the letter's silhouette with no seams inside it. Curves stay true beziers, so outlined text scales without going polygonal.

Both are one-way conversions: the result is no longer editable as text.

---

## Stroke Caps (Per-Node)

Vector path endpoints (leaf nodes with degree 1) can have individual stroke caps. Select a vector that has a stroke, then configure caps in the **right toolbar's stroke section**:

| Cap Type | Description |
|----------|-------------|
| **None** | Butt cap (no extension past the endpoint) |
| **Round** | Semicircle cap (default) |
| **Square** | Extends by half the stroke thickness past the endpoint |
| **Arrow** | Arrowhead pointing outward along the path tangent |
| **Circle** | Filled dot marker at the endpoint |

- **Two-endpoint open paths** (lines, simple curves) and **circle arcs** (sweep < 100%) show separate start-cap and end-cap dropdowns side by side for independent control.
- **Multi-endpoint vectors** (3+ leaf nodes) show a unified dropdown that sets all endpoints to the same cap.

Arrow caps scale with stroke width automatically. This makes arrows out of a line or curve without any separate triangle element.

## When to Use Vectors vs Other Elements

| Visual Element | Use |
|----------------|-----|
| Icons | Built-in SVG icons (~1,515 names, each in two weights: regular and fill, so ~3,000 SVGs), not hand-drawn vectors |
| Sparklines, trend lines | Vector with a stroke and smooth curves |
| Area charts (filled region under a curve) | A closed vector path with both fill and stroke |
| Straight or diagonal arrows | A line with an arrow stroke cap |
| Arrows connecting two elements | A line whose endpoints anchor to the two elements (auto-routes) |
| Curved / freeform arrows | A vector curve with an arrow stroke cap |
| Simple colored rectangles | Rectangle element |
| Circles, dots | Circle element |
| Progress rings | A circle stroked as a track plus a circle arc for the progress |

To author vectors, arrows, sparklines, area charts, and per-region fills via the DSL (path syntax, connector routing, region IDs), see the blueprint knowledge files. For complete chart patterns, see the chart knowledge files (sparklines, bar charts, line charts).
