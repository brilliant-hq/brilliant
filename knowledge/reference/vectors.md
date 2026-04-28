---
name: "knowledge-vectors"
description: "Pen tool, vector path creation, node editing, bezier handles, and vector operations in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Vectors

## How to Access Vector Tools

### Pen Tool (Create New Paths)

Press **P** to activate the Pen tool. Also accessible via:
- **Bottom toolbar:** Click the Drawing Tools dropdown and select "Pen"
- **Command Palette:** Press **Cmd+Shift+P**, search for "Pen"

The Pen tool is persistent: after finishing a path, the tool stays active so you can immediately start another. Press **Escape** to exit pen tool back to Move.

### Vector Edit Mode (Edit Existing Paths)

To edit an existing vector element's nodes:
1. Select the vector element
2. **Double-click** it, or press **Enter**, to enter vector edit mode
3. Edit nodes, handles, and edges (see sections below)
4. Press **Escape** to exit. First press clears any node/handle selection, second press exits vector edit mode.

Vector edit mode auto-converts shapes (rectangles with corner radii, circles, lines) into editable Bezier vectors on entry, and reverts to the original shape type on exit if the geometry is unchanged. Paths that drop below 2 nodes are deleted entirely (full undo restores).

---

## Pen Tool

The pen tool creates vector paths by placing nodes one at a time with optional bezier curve control.

### Basic Usage

1. Activate the pen tool (see "How to Access" above).
2. **Click** to place a node (straight edge to previous).
3. **Click and drag** to place a node with Bezier handles (smooth curve).
4. Continue clicking to add more nodes.
5. **Click the first node** to close the path into a shape.
6. Press **Escape** to exit. First press clears node selection, second press exits vector edit mode and switches to the Move tool.

### Creating Straight Lines

Click without dragging at each point. Default point type is **Straight** (no handles).

### Creating Curves

Click and drag to pull out Bezier handles:
- Drag direction determines curve direction
- Drag distance determines curve intensity
- Both handles move symmetrically; the new node's point type is **Mirrored**

### Mixing Straights and Curves

- Click (no drag) for sharp corners
- Click and drag for smooth curves
- Alternate freely between the two
- **Alt/Option + drag** while placing a node creates only the outgoing handle (no incoming handle); the node's point type is set to **Disconnected**

### Closing a Path

Click on the first node to create a closed shape.

### Tips

- Hold **Shift** while dragging handles to snap the handle angle to 15-degree increments.
- Closed paths can have fills and strokes; open paths render strokes only.
- After creation, refine in vector edit mode (select path, press **Enter**).
- Pen tool stays active after a path is finished. Click again to start another.

## Pencil Tool

Press **Shift+P** to activate the Pencil tool. Also accessible via:
- **Bottom toolbar:** Drawing Tools dropdown → "Pencil"
- **Command Palette:** Cmd+Shift+P, search "Pencil"

The Pencil tool creates freehand vector paths by drawing with the mouse. The stroke is smoothed into cubic Bezier curves with mirrored handles. The result is a standard vector element that can be edited in vector edit mode.

### Basic Usage

1. Activate the pencil tool
2. Click and drag on the canvas to draw a freehand path
3. Release to finish the stroke

The pencil tool produces open paths with strokes (no fill). It auto-finalizes once you have at least 2 points; very short strokes are discarded. Refine the path in vector edit mode after drawing.

## Node Editing

Enter vector edit mode by selecting a vector element and pressing **Enter** (or double-clicking it).

### Selecting Nodes

| Action | How |
|--------|-----|
| Select a node | Click on it |
| Add to selection | Shift+Click |
| Toggle selection | Shift+Click selected node |
| Select multiple | Drag rectangle over nodes |
| Select all nodes in path | Cmd+A while in vector edit mode |

When clicking a region or stroke (not a node), the **vector node selection is cleared** and the part is selected for fill/stroke editing instead. Shift+click on a region adds it to the part selection.

### Moving Nodes

Select nodes and drag. Snap guides work (see "Snap Guides in Vector Mode" below).

- Hold **Shift** while dragging a node to snap the displacement angle from its starting position to 15-degree increments (relative to the primary node's drag-start position).
- Hold **Alt/Option** at the start of a drag to **duplicate** the selected nodes. The drag operates on the copies and originals stay put.
- With 2+ nodes selected, dragging anywhere inside the selection bounding box moves all selected nodes together.
- With 2+ nodes selected, a sub-selection bounding box with resize and rotation handles appears around them (see "Node Sub-Selection Transform" below).

### Moving Disconnected Regions

Vectors with multiple separate connected components (e.g., a Venn diagram with 3 circles, or a multi-part icon) support dragging each component independently:

- **Click** on a disconnected region (fill area or stroke) to select all its nodes at once.
- **Drag** a disconnected region to move it: click-and-drag works in one gesture.
- **Shift+Click** another region to add its nodes to the selection, then drag to move multiple regions together.

### Adding Nodes on an Edge

Hover over an existing edge: a blue circle with `+` previews where a new node will land. Click to insert. The new node splits the edge into two segments and preserves the original curvature.

If the **pen tool** is active, clicking on an edge (instead of in empty space) inserts the node into the existing path rather than starting a new disconnected segment.

### Deleting Nodes

Select nodes and press **Delete** or **Backspace**. If a deleted node has exactly 2 edges, the neighbors are reconnected with a single edge that preserves the surrounding handles. If the deleted node has more or fewer edges, its edges are removed too. Paths that drop below 2 nodes are deleted entirely (the element is removed; full undo restores it).

Selecting handles instead of nodes and pressing Delete sets those handles to null (collapses to a straight segment) without removing the underlying nodes.

### Bezier Handles

#### Toggling Handles on a Node

**Cmd+Click** a node to add or remove handles. Handles extend from the node, one per connected edge (a 2-edge node shows two handles, a leaf node shows one). Adding handles sets point type to **Mirrored**; removing them sets point type to **Straight**.

#### Removing a Single Handle

**Cmd+Click** a single handle endpoint to remove just that handle (collapses to a straight segment on that side). If the node ends up with all handles null, its point type auto-transitions to **Straight**.

#### Dragging Handles

Drag a handle endpoint. The behavior of the **opposite** handle depends on the node's **point type** at drag start (see Point Types below):

| Point type at drag start | Normal drag | Alt/Option+drag |
|--------------------------|-------------|-----------------|
| Mirrored | Opposite handle mirrors direction + length | Only the dragged handle moves |
| Asymmetric | Opposite handle rotates to stay co-linear, length preserved | Only the dragged handle moves |
| Disconnected | Only the dragged handle moves | Only the dragged handle moves |
| Straight | Only the dragged handle moves | Only the dragged handle moves |

If a normal drag breaks symmetry on a Mirrored node, the point type auto-transitions to **Disconnected** at drag end.

Hold **Shift** during a handle drag to combine the existing snap behavior with extra geometric snaps (collinear, perpendicular, 15-degree increments, etc.). See "Snap Guides in Vector Mode" below.

#### Detaching Handles

Hold **Alt/Option** while dragging a handle to move only that handle independently. This permanently changes the node's point type to **Disconnected**.

### Deleting Edges

**Shift+Click** an edge to delete it (a red highlight previews the deletion on hover). This disconnects the nodes on either side. If removing an edge leaves a node with no remaining edges, that node is also removed.

### Point Types

Each node has a **point type** that controls how its Bezier handles behave. Select a node (or one of its handles) in vector edit mode to see the point type row in the right toolbar.

| Type | Behavior |
|------|----------|
| **Straight** | No handles. Sharp corner with straight edges on both sides. |
| **Mirrored** | Handles mirror each other (same direction, same length). Drag one and the opposite handle moves symmetrically. |
| **Asymmetric** | Handles stay co-linear (same angle through the node) but lengths are independent. Drag one and the opposite handle rotates to stay aligned, keeping its own length. |
| **Disconnected** | Each handle is fully independent. |

#### Changing Point Type

Click the point type button in the right toolbar. The point type row appears when a node or handle is selected. The four commands (`set_point_type_straight`, `set_point_type_mirrored`, `set_point_type_asymmetric`, `set_point_type_disconnected`) are also available in the command palette and Shortcuts panel. None have default keybindings; assign one via **Shift+?** if needed.

#### Automatic Point Type Changes

| Trigger | Resulting point type |
|---------|---------------------|
| Click + drag while placing a node with the pen tool | Mirrored |
| Alt/Option + drag while placing a node with the pen tool | Disconnected |
| Cmd+Click a node to add handles | Mirrored |
| Cmd+Click to remove handles (or Cmd+Click a single handle that empties both) | Straight |
| Alt/Option drag a handle | Disconnected |
| Normal drag breaks symmetry of a Mirrored node | Disconnected (auto-transition at drag end) |
| Shape converted to vector (curved segment) | Mirrored |
| Shape converted to vector (straight segment) | Straight |

#### Nodes with 3+ Edges

For nodes connected to 3 or more edges, the point type row is grayed out. Mirrored/Asymmetric constraints only apply to 2-edge nodes where there is a single "opposite" handle.

### Node Sub-Selection Transform

When **2 or more nodes** are selected, a bounding box with resize and rotation handles appears around them, scoped to the node selection (not the whole element):

- Drag a corner or edge handle to scale the selected nodes within the box. Edge handles scale a single axis; corner handles scale both. Collinear node selections (zero extent on one axis) disable resize on that axis to avoid divide-by-zero.
- Drag a rotation handle (just outside the corners) to rotate the selected nodes around the box center.
- Hold **Shift** while rotating to snap to 15-degree increments.

The sub-selection box does NOT appear for single-node selections.

### Copy / Cut / Paste Nodes

In vector edit mode:

- **Cmd+C** copies the selected nodes plus the edges where **both endpoints** are selected.
- **Cmd+X** copies and deletes the same set (does NOT remove the whole element).
- **Cmd+V** pastes:
  - If still in vector edit mode: nodes paste into the current element with new IDs and become the selection.
  - If not in vector edit mode: a new vector element is created from the pasted nodes and vector edit mode is entered.

### Select All in Vector Mode

**Cmd+A** in vector edit mode selects all nodes in the current path (rather than selecting all elements on the canvas).

### Companion Display

While editing vectors, a cursor companion tooltip shows contextual information:
- Handle angle (degrees) when dragging a handle
- Node distance (pixels) when previewing pen tool placement
- Action hint when Cmd+hovering over a node, handle, or edge

---

## Snap Guides in Vector Mode

When snap guides are enabled, precision snapping works during vector editing for both node dragging and handle dragging.

### Node Snapping

When dragging a node, the following snap types compete cooperatively (per-axis snaps lock individual axes; constrained 2D snaps fill in the free axes):

| Snap Type | Description |
|-----------|-------------|
| **Alignment** | Node aligns with other nodes (same vector or sibling vectors), with non-vector element corners/centers, with parent frame inner edges, and with layout grids. |
| **Edge length matching** | A straight edge incident to the dragged node matches the length of another straight edge. |
| **Edge angle matching** | A straight edge incident to the dragged node becomes parallel, anti-parallel, or perpendicular to a reference edge on the same vector. |
| **Path geometry** | Node snaps to the closest point on any Bezier curve in a reference vector. |
| **Path intersection** | Node snaps to where two path edges cross. |
| **Spacing / equidistant** | Equal gap between nodes, or node centered between two references. |

Hold **Shift** while dragging a node to snap the displacement angle from drag start to 15-degree increments (this overrides the snap pipeline).

Ghost dots appear on other vectors at the reference points that triggered the snap. Same-element nodes do not get ghost dots (they're already visible in the editor).

### Handle Snapping

When dragging a Bezier handle, all 10 handle-specific snap types and the alignment snap compete on Euclidean distance; the closest wins. After the winner is picked, all active geometric relationships at the final position are shown simultaneously (position truth):

| Snap Type | Description |
|-----------|-------------|
| **Collinear** | Handle angle is opposite to another handle on the same node (straight line through the node). |
| **Symmetric** | Collinear + same length as the opposite handle (only fires when handles are not coupled). |
| **H/V mirror** | Handle is the horizontal or vertical mirror of another handle on the same node. |
| **Perpendicular** | Handle is at 90 degrees from another handle on the same node. |
| **Angle matching** | Handle angle matches a handle on another node. |
| **Edge tangent / perpendicular** | Handle is parallel to, or 90 degrees from, an adjacent straight edge. |
| **15-degree increments** | Handle angle snaps to the nearest 15-degree multiple. |
| **Curve extrema** | Handle length makes the curve's H/V extremum land exactly on a horizontal or vertical line. |
| **Golden ratio / one-third** | Handle length is approximately 0.5523 or 0.333 times the chord length (visually pleasant defaults for cubic Beziers). |
| **Length matching** | Handle length matches any other handle (any angle). Combinable with angle snaps. |

If a handle is dragged within ~5 px (screen) of the node, it retracts to zero (collapses to no handle on that side).

### Snap Toggles

Six toggles control vector-edit snapping. None have default keybindings; reach them via the command palette or assign keys via **Shift+?**:

- **Vector snapping enabled** (master gate, default ON): disables all vector snaps.
- **Snap to self** (default ON): snap to nodes and handles on the editing vector.
- **Snap to others** (default ON): snap to sibling vector elements.
- **Snap to geometry** (default ON): snap to non-vector sibling element corners and centers.
- **Snap to grids** (default ON): snap to pixel grid, parent frame edges, and layout guides.
- **Snap to path curves** (default ON): snap to on-curve points and path intersections.

Pixel-grid snapping is a separate toggle (**Shift+Cmd+'**) shared with element editing.

---

## Boolean Operations and Flatten

Boolean operations (Union, Subtract, Intersect, Exclude) wrap 2+ selected shapes into a boolean parent whose children remain editable. Double-click a boolean parent to edit its children; **Escape** exits boolean edit mode.

**Flatten** (Cmd+Enter) bakes any selection into a single vector element. Use it to commit a boolean result, convert a primitive (rect/circle/line) into editable vector geometry, or merge a frame's children into one path.

See `editing.md` for shortcuts, full input/output behavior of Flatten, and the related Outline Text and Mask operations.

---

## Creating Vectors Programmatically

When creating vectors via `create_modify_elements` (not the pen tool), you define paths using SVG path syntax. This is essential for sparklines, area charts, waveforms, and decorative curves.

### How Vector Positioning Works

A vector element's bounding box is defined by `s(W,H)` in the element declaration. Path coordinates render **within** that box:

- `M0,0` = top-left corner of the element
- `M{W},{H}` = bottom-right corner
- `p(X,Y)` positions the element within its parent (just like rects and frames)

```
# A 60x24 vector positioned at (10,5) inside a group
v() s(60,24) p(10,5) st[(#F97316,w(1.5))] path:d(M0,20 C10,16 20,12 30,8 C40,6 50,4 60,2) "Curve"
```

**The path fills the `s(W,H)` box.** If your path coordinates exceed the declared size, the overflow is clipped. If they're smaller, the element has dead space. Design paths to match your declared size.

### Path Syntax (SVG d attribute)

| Command | Meaning | Example |
|---------|---------|---------|
| `M x,y` | Move to (start point) | `M0,20` |
| `L x,y` | Line to | `L60,24` |
| `C x1,y1 x2,y2 x,y` | Cubic bezier (2 control points + endpoint) | `C5,18 10,22 15,16` |
| `Z` | Close path (line back to last M) | `Z` |

### Open vs Closed Paths

- **Open path** (no `Z`): Only strokes render. Use for sparklines, waveforms.
- **Closed path** (ends with `Z`): Both fills AND strokes render. Use for area charts, shapes.

### Sparkline (Stroke Only)

```
v() s(60,24) st[(#F97316,w(1.5))] path:d(M0,22 C6,21 12,20 18,17 C22,16 26,18 30,15 C36,12 42,10 48,8 C52,7 56,5 60,4) "Spark"
```

**Always use `C` (cubic bezier) for smooth curves.** `L`-only paths look jagged. See `charts/sparklines` for metric-specific path shapes (revenue, latency, error rate, etc.).

### Area Fill (Closed Path)

To fill the area under a curve, **close the path at the bottom** and wrap in a **clip frame with outside stroke and top padding**. Use ONE closed vector with both stroke and fill. The closing edges create ugly strokes at the bottom and sides; outside stroke pushes them beyond the vector's bounds, and the clip frame crops them away. Top padding gives the curve's outside stroke room so it isn't clipped:

```
al(v,g($spacing.none),pad(2,$spacing.none,$spacing.none,$spacing.none)) s(fill,26) clip "Spark"
  v() s(fill,fill) f[(linear(180,stop(#F97316,0,o(0.15)),stop(#F97316,1,o(0.0))))] st[(#F97316,w(1.5),cap(n,n),pos(o))] path:d(M0,20 C5,18 10,22 15,16 C20,10 25,14 30,8 C35,12 40,4 45,8 C50,6 55,10 60,6 L60,24 L0,24 Z) "Line"
```

The `L60,24 L0,24 Z` closes the path along the bottom edge. With `s(fill,fill)` on the vector, the path scales into whatever bounds the frame provides — closing edges always land exactly at the clip boundary. The `pad(2,0,0,0)` adds 2px top padding (≥ stroke width) so the curve stroke isn't clipped, while 0 padding on the other sides keeps closing-edge strokes cropped. The gradient (`180` = top-to-bottom) creates the modern area chart look; `f[(solid(#F97316,o(0.12)))]` also works.

**Crucial invariant — the clip frame's interior (size minus padding) must equal the vector's bounds.** Two safe configurations:

| Frame | Vector | Notes |
|---|---|---|
| `s(fill, FIXED)` or `s(FIXED, FIXED)` | `s(fill, fill)` | **Recommended.** Vector stretches to the frame; chart size lives in one place. |
| `s(hug, hug)` | `s(W, H)` (fixed) | Use when the chart should size to its data extent, not its container. |

What breaks it: a fixed-size frame plus a vector with a *different* fixed dimension on the same axis. Example: frame `s(620,198)` + vector `s(fill,180)` leaves the L0,180 closing edge at frame y=182 (after the 2px top pad) while the clip boundary is at y=198 — 16px of unclipped bottom-edge stroke shows. Either drop the vector to `s(fill,fill)` or shrink the frame's height to match `vector_h + top_pad`.

### Common Mistakes

| Wrong | Correct |
|-------|---------|
| Two separate vectors in a group (one stroke, one fill) for sparkline + area | ONE closed vector with both `fill` and `stroke` in a clip frame |
| Placing a colored `rect` behind a sparkline stroke to simulate area fill | Use a **closed vector path** with `f[(solid(#hex,opacity))]`. The rect can't follow the curve |
| Using centered stroke on closed sparkline paths | Use `st[(#hex,w(1.5),cap(n,n),pos(o))]` (outside stroke) + clip frame to hide closing-edge strokes |
| Fixed-size frame `s(W,H)` + fixed-size vector `s(W,H')` with `H' ≠ H − topPad` (closing edge visible at bottom) | Vector `s(fill,fill)` inside `s(fill,H)` or `s(W,H)` frame — vector's bounds always match the frame's interior |
| Using `L` segments for smooth sparklines | Use `C` cubic beziers. `L` creates jagged zigzags |
| Creating vectors without size | Always declare size: `v() s(60,24)` (the path renders within this box) |
| Fighting vector positioning with repeated @X,Y adjustments | Design path coordinates relative to `0,0`, set size with `s(W,H)` to match path bounds, position with `p(X,Y)` |
| Creating separate triangle `vector` elements for arrowheads | Use `cap(n,ar)` on a `line(N)`, `connect(...)`, or `vector`. The arrow cap renders automatically at the endpoint |
| Hand-routing dependency arrows with `v()` paths between elements | Use `connect(#A, #B, route(elbow))` to auto-route from A to B at end of block (no math required) |

### Vector Regions

Vectors with multiple closed regions (e.g. imported SVG logos) expose per-region sub-paths via `vr()` continuation lines in `lookup` output (when `format: "blueprint"`):

```
abc123 v() s(200,200) "Logo"
  vr(r1, M0,0 C50,-20 100,0 100,100 Z) f[(#FF6611)]
  vr(r2, M30,30 L70,30 L70,70 L30,70 Z) f[(#00FF00)]
  vr(r3, M40,40 L60,40 L60,60 L40,60 Z) hole
```

- **`r1`** = largest region, **`r2`** = next, etc. (ordered by area, descending)
- **`hole`** = cutout (transparent) region
- Each region's SVG path data shows its exact boundary; read the coordinates to understand shape and position
- **All fill types work per-region**: solid, gradient, shader, `inner()`, `glow()`, `blur()`, `img()`

**Modify per-region fills** by region ID, no path data needed:
```
abc123
  vr(r1) f[(solid(#F97316,o(0.15))),(f2,blur(12)),(f3,inner(#000,o(0.2),y(2),blur(4)))]
  vr(r2) f[(solid(#8B5CF6,o(0.1))),(f2,blur(8))]
```

Only listed regions are modified; others keep their current fills. Flat `f[...]` on the element line still applies uniformly to all regions.

**Single-region vectors** (or vectors with no regions) show the standard flat format with no `vr()` lines.

### Stroke Caps (Per-Node)

Vector path endpoints (leaf nodes with degree 1) can have individual stroke caps. Select a vector with a stroke, then configure caps in the right toolbar:

| Cap Type | Description |
|----------|-------------|
| **None** | Butt cap -- no extension past the endpoint |
| **Round** | Semicircle cap (default) |
| **Square** | Extends by half stroke thickness past the endpoint |
| **Arrow** | Arrow head pointing outward along the path tangent |

**For two-endpoint open paths** (lines, simple curves) **and circle arcs** (sweep < 100%): Separate start cap and end cap dropdowns appear side by side, allowing independent control of each endpoint.

**For multi-endpoint vectors** (paths with 3+ leaf nodes): A unified dropdown sets all endpoints to the same cap.

Arrow caps scale with stroke width automatically. Use `cap(n,ar)` in blueprint syntax for arrow endpoints (e.g., `st[(#374151,w(1.5),cap(n,ar))]`). See the Arrows section below for examples.

### When to Use Vectors vs Other Elements

| Visual Element | Use |
|----------------|-----|
| Icons | `svg` (NEVER `vector`) |
| Sparklines, trend lines | `vector` with stroke, `C` curves |
| Area charts (filled region under curve) | `vector` with closed path + fill (one element, both stroke and fill) |
| Arrows (straight) | `line(N)` with `cap(n,ar)` and `st[(#hex,w(width))]` |
| Arrows connecting two existing elements | `connect(#A, #B)` with `cap(n,ar)` (auto-routes between refs) |
| Arrows (curved, freeform) | `vector` with `st[(#hex,w(width),cap(n,ar))]` arrow cap and `C` curves |
| Simple colored rectangles | `rect` |
| Circles, dots | `circle` |
| Decorative wavy dividers | `vector` with `C` curves |
| Progress rings | Track = `circle` with stroke; progress arc = `circle` with `arc(start,sweep)`. Example: `c s(80,80) st[(#F97316,w(4),cap(r,r))] arc(90,75) ratio(1)` for 75% starting at top (90°=top, 0°=right) |

### Arrows

Use `cap(n,ar)` to add an arrowhead at the endpoint (`ar` = arrow endCap). Cap can go inline in the stroke or as a top-level token. Works on `line(N)`, `connect()`, and `vector` elements; no separate triangle elements needed.

**Straight arrow** uses `line(N)`:
```
line(200) cap(n,ar) st[(#374151,w(1.5))] "Arrow"
```

**Diagonal arrow** uses `line(N)` with `rot()`:
```
line(200) p(40,40) rot(45) cap(n,ar) st[(#374151,w(1.5))] "Diagonal arrow"
```
`rot()` pivots around `p()` (the line's start), so the line extends from `p` along the rotated direction.

**Connecting two existing elements** uses `connect()`, which auto-routes with smart defaults (elbow shape + obstacle avoidance):
```
connect(#card1, #card2) cap(n,ar) st[(#888,w(1.5))]                      # smart defaults
connect(#card1, #card2, intent(dependency))                              # preset bundles route + avoid + cap + stroke
connect(#card1, #card2, route(straight), avoid(none))                    # opt out: literal straight line
connect(#card1, #card2, from(r, 0.25), to(l, 0.75))                      # fractional anchors along edges
connect(#card1, #card2, from(#card1_port), to(#card2_port))              # anchor on nested elements
```
**Defaults** (no params): `route(elbow)` + `avoid(all)`, picking an orthogonal shape and routing around any other elements between the endpoints. **Intents** (`dependency`/`flow`/`annotation`) seed defaults; explicit tokens always win. **Routes**: `elbow` (default; single right-angle bend, auto-promoted to 2-bend when needed), `elbow2` (always 2 bends), `straight`, `bezier`. **Avoid**: `all` (default), `endpoints` (only source/target), `none`. **Anchors**: bare side (`tl t tr l c r bl b br`), `(side, fraction)` for a position along an edge, or `(#ref)` to anchor on a nested element. Omit `from`/`to` to auto-pick the closest sides. Path resolves at end of block once both refs exist.

**Curved freeform arrow** uses a `vector` with bezier:
```
v() s(200,100) st[(#374151,w(1.5),cap(n,ar))] path:d(M0,50 C60,50 140,0 200,0) "Arrow"
```

The arrow cap renders at the last node, oriented along the path tangent. It scales with stroke width automatically.

> **Cross-reference:** See `charts/sparklines`, `charts/bar-charts`, and `charts/line-charts` for complete chart patterns.
