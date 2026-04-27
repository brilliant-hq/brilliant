---
name: "knowledge-vectors"
description: "Pen tool, vector path creation, node editing, bezier handles, and vector operations in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Vectors

## How to Access Vector Tools

### Pen Tool (Create New Paths)

Press **P** to activate the Pen tool. Also accessible via:
- **Bottom toolbar:** Click the Drawing Tools dropdown (Pencil icon with chevron) and select "Pen"
- **Command Palette:** Press **Cmd+Shift+P**, search for "Pen", select "Change Tool to Pen"

The Pen tool is **persistent** — after finishing a path, the tool stays active so you can immediately start another.

### Vector Edit Mode (Edit Existing Paths)

To edit an existing vector element's nodes:
1. Select the vector element
2. **Double-click** it, or press **Enter**, to enter vector edit mode
3. Edit nodes, handles, and edges (see sections below)
4. Press **Escape** to exit (first press clears any node/handle selection, second press exits vector edit mode)

Vector edit mode also auto-converts shapes (rectangles with corner radii, circles, lines) into editable bezier vectors on entry, and reverts to the original shape type on exit if the geometry hasn't changed. Paths that drop below 2 nodes are deleted entirely (full undo restores).

---

## Pen Tool

The pen tool creates vector paths by placing nodes one at a time with optional bezier curve control.

### Basic Usage

1. Activate the pen tool (see "How to Access" above)
2. **Click** to place a node (straight edge to previous)
3. **Click and drag** to place a node with bezier handles (smooth curve)
4. Continue clicking to add more nodes
5. **Click the first node** to close the path into a shape
6. Press **Escape** to finish an open path (first press clears node selection, second press exits vector edit mode and switches to Move)

### Creating Straight Lines

Click without dragging at each point.

### Creating Curves

Click and drag to pull out bezier handles:
- Drag direction determines curve direction
- Drag distance determines curve intensity
- Both handles move symmetrically (mirrored)

### Mixing Straights and Curves

- Click (no drag) for sharp corners
- Click and drag for smooth curves
- Alternate freely between the two
- **Alt/Option + drag** while placing a node creates an asymmetric handle (only the outgoing handle moves) and locks the node's point type to Disconnected

### Closing a Path

Click on the first node to create a closed shape.

### Tips

- Hold **Shift** while dragging out handles to snap to 15-degree increments
- Closed paths can have fills and strokes
- After creation, refine in vector edit mode (select path, press **Enter**)
- Pen tool stays active after a path is finished — keep clicking to start another

## Pencil Tool

Press **Shift+P** to activate the Pencil tool. Also accessible via:
- **Bottom toolbar:** Click the Drawing Tools dropdown and select "Pencil"
- **Command Palette:** Press **Cmd+Shift+P**, search for "Pencil"

The Pencil tool creates freehand vector paths by drawing with the mouse. It automatically smooths the stroke into cubic Bezier curves using Catmull-Rom interpolation. The result is a standard vector element that can be edited in vector edit mode.

### Basic Usage

1. Activate the pencil tool
2. Click and drag on the canvas to draw a freehand path
3. Release to finish the stroke
4. The path is automatically smoothed into curves

The pencil tool produces open paths with strokes (no fill). After drawing, you can refine the path in vector edit mode.

## Node Editing

Enter vector edit mode by selecting a vector element and pressing **Enter** (or double-clicking it).

### Selecting Nodes

| Action | How |
|--------|-----|
| Select a node | Click on it |
| Add to selection | Shift+Click |
| Toggle selection | Shift+Click selected node |
| Select multiple | Drag rectangle over nodes |
| Select all | Cmd+A (in vector edit mode) |

### Moving Nodes

Select nodes and drag. Snap guides work.

- Hold **Shift** while dragging a node to constrain movement to the horizontal or vertical axis (whichever has the larger delta)
- Hold **Alt/Option** at the start of a drag to **duplicate** the selected nodes — the drag operates on the copies while the originals stay in place
- When 2+ nodes are selected, you can drag anywhere inside the selection bounding box to move all selected nodes together
- When 2+ nodes are selected, a sub-selection bounding box appears with resize and rotation handles (see "Node Sub-Selection Transform" below)

### Moving Disconnected Regions

Vectors with multiple separate shapes (e.g., a Venn diagram with 3 circles, or a multi-part icon) support dragging each shape independently:

- **Click** on a disconnected region (fill area or stroke) to select all its nodes at once
- **Drag** a disconnected region to move it — click-and-drag works in one gesture
- **Shift+Click** another region to add its nodes to the selection, then drag to move multiple regions together

### Adding Nodes

Hover over an existing edge and click. A new node splits the edge into two.

### Deleting Nodes

Select nodes, press **Delete** or **Backspace**. Adjacent edges merge.

### Bezier Handles

#### Toggling Handles

**Cmd+Click** a node to show/hide handles. Control points extend from the node — one per connected edge (so a 2-edge node shows two handles, a leaf node shows one). Adding handles via Cmd+Click sets the point type to Mirrored; removing them sets the point type to Straight.

#### Removing a Single Handle

**Cmd+Click** a single handle endpoint to remove that handle (collapses to a straight segment on that side). If both handles end up null, the node's point type becomes Straight automatically.

#### Dragging Handles

Drag a handle endpoint. Handle behavior depends on the node's **point type** (see Point Types below).

#### Detaching Handles

Hold **Alt/Option** while dragging a handle to move only the dragged handle independently (disconnected behavior). This permanently changes the node's point type to Disconnected.

### Adding Nodes on an Edge

Hover over an existing edge — a blue circle with `+` previews where a new node will land. Click to insert. The new node splits the edge into two segments and preserves the original curvature.

### Deleting Edges

**Shift+Click** an edge to delete it (a red highlight previews the deletion on hover). This disconnects the nodes on either side. If removing an edge leaves a node with no remaining edges, that node is also removed.

### Point Types

Each node has a **point type** that controls how its bezier handles behave. Select a node (or its handles) in vector edit mode to see the point type row in the right toolbar.

| Type | Icon | Behavior |
|------|------|----------|
| **Straight** | V-shaped corner | No handles — sharp corner with straight edges |
| **Mirrored** | Symmetric arms | Handles mirror each other (same direction + same length) |
| **Asymmetric** | Unequal arms | Handles stay co-linear (same angle) but can have different lengths |
| **Disconnected** | Angled arms | Each handle moves independently |

#### Changing Point Type

Click the point type button in the right toolbar. The point type row appears when a node or handle is selected in vector edit mode. Each of the four point-type commands (`set_point_type_straight`, `set_point_type_mirrored`, `set_point_type_asymmetric`, `set_point_type_disconnected`) is also available in the command palette and Shortcuts panel — none have a default keybinding, but you can assign one via **Shift+?**.

#### Automatic Point Type Changes

| Action | Result |
|--------|--------|
| **Alt/Option+drag** a handle | Permanently changes to Disconnected, moves only the dragged handle |
| **Cmd+Click** to add handles | Sets to Mirrored |
| **Cmd+Click** to remove handles | Sets to Straight |
| Click and drag while creating with pen tool | Sets to Mirrored |
| Alt/Option+drag while creating with pen tool | Sets to Disconnected |

#### Nodes with 3+ Edges

For nodes connected to 3 or more edges, the point type row is grayed out. Mirrored/asymmetric constraints only apply to 2-edge nodes (where there's a clear "opposite" handle).

### Node Sub-Selection Transform

When **2 or more nodes** are selected in vector edit mode, a bounding box with resize and rotation handles appears around them. This lets you scale or rotate the selected nodes as a group:

- **Drag a resize handle** to scale the selected nodes proportionally
- **Drag a rotation handle** (corners, outside the box) to rotate the selected nodes around their center
- Hold **Shift** while rotating to snap to 15-degree increments

### Copy/Paste Nodes

In vector edit mode, you can copy and paste nodes:

- **Cmd+C** copies the selected nodes (and their connecting edges)
- **Cmd+V** pastes them — if still in vector edit mode, nodes are pasted into the current element; otherwise, a new vector element is created from the pasted nodes

### Select All in Vector Mode

**Cmd+A** in vector edit mode selects all nodes and handles in the current path (instead of selecting all elements on the canvas).

### Companion Display

While editing vectors, a cursor companion tooltip shows contextual information:
- **Handle angle** (degrees) when dragging a handle
- **Node distance** (pixels) when previewing pen tool placement
- **Action hint** when Cmd+hovering over a node or edge

---

## Snap Guides in Vector Mode

When snap guides are enabled, precision snapping works during vector editing — both node dragging and handle dragging.

### Node Snapping

When dragging a node, snap guides activate for:

| Snap Type | Description |
|-----------|-------------|
| **Alignment** | Node aligns with other nodes (same vector or other vectors), element corners/centers |
| **Edge length matching** | Straight edge matches the length of another straight edge |
| **Edge angle matching** | Straight edge becomes parallel or perpendicular to a reference edge |
| **Path geometry** | Node snaps to the closest point on a Bezier curve |
| **Path intersection** | Node snaps to where two path edges cross |
| **Spacing** | Equal gap between nodes (same as element spacing) |
| **Equidistant** | Node centered between two references |

These snap types **cooperate** — alignment can lock one axis while edge length matching adjusts the other, giving you precision on both axes simultaneously.

Ghost dots appear on other vectors showing the reference points that triggered the snap.

### Handle Snapping

When dragging a bezier handle, geometric snaps have priority:

| Snap Type | Description |
|-----------|-------------|
| **Collinear** | Handle aligns opposite another handle (straight through node) |
| **Symmetric** | Collinear + same length as opposite handle |
| **Mirror** | Handle mirrors another horizontally or vertically |
| **Perpendicular** | Handle is 90° from another handle |
| **Angle matching** | Handle angle matches any handle on other nodes |
| **Edge tangent/perpendicular** | Handle aligns with adjacent straight edge |
| **15° increments** | Handle snaps to nearest 15° multiple |
| **Length matching** | Handle length matches another handle |

If no geometric snap fires, handles fall back to alignment snapping (matching position with reference points).

### Disabling Snaps

Several toggles control snapping behavior. None of the vector-specific snap toggles have default keybindings — find them in the command palette or assign keys via **Shift+?**.

- **Snap guides** (alignment, spacing, equidistant): Toggle via the command palette — search "Toggle Snap Guides". No default keybinding.
- **Snap to pixel grid** (rounds positions to whole pixels): Toggle via **Shift+Cmd+'**, or search "Snap to Pixel Grid" in the command palette.
- **Vector snapping enabled**: master toggle for all vector-edit-mode snapping.
- **Vector snap to geometry / self / others / grids / path curves**: fine-grained toggles for each vector snap source.

---

## Boolean Operations

Boolean operations combine two or more selected shapes into a boolean group. The children remain editable inside the group: you can double-click a boolean group to edit individual shapes, and press **Escape** to exit boolean edit mode.

| Operation | Shortcut | Description |
|-----------|----------|-------------|
| **Union** | **Alt+Shift+U** | Combines all shapes into one merged outline |
| **Subtract** | **Alt+Shift+S** | Subtracts front shapes from the back shape |
| **Intersect** | **Alt+Shift+I** | Keeps only the overlapping area |
| **Exclude** | **Alt+Shift+E** | Keeps only the non-overlapping areas (XOR) |

Also accessible via the command palette (search "Boolean Union", etc.).

Requires 2+ elements selected. If a single boolean or mask group is already selected, the command changes its boolean type instead of creating a new group.

To bake a boolean group into a final single vector, use **Flatten** (see below).

## Flatten

The Flatten command converts any selection into a single vector element:

| Input | Result |
|-------|--------|
| Single primitive (rect/circle/line) | Converts to vector |
| Boolean group (union) | Concatenates children into one vector (lossless, per-child colors) |
| Boolean group (subtract/intersect/exclude) | Bakes the computed result into a vector via path sampling |
| Group/frame | Concatenates children into one vector |
| Multiple selected elements | Concatenates all into one vector |
| Single vector | No conversion needed — enters vector edit mode |

**Shortcut:** **Cmd+Enter** (or search "Flatten" in the command palette).

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

To fill the area under a curve, **close the path at the bottom** and wrap in a **clip frame with outside stroke and top padding**. Use ONE closed vector with both stroke and fill. The closing edges create ugly strokes at the bottom and sides — outside stroke pushes them beyond the vector's bounds, and the clip frame crops them away. Top padding gives the curve's outside stroke room so it isn't clipped:

```
al(v,g($spacing.none),pad(2,$spacing.none,$spacing.none,$spacing.none)) s(fill,hug) clip "Spark"
  v() s(fill,24) f[(linear(180,stop(#F97316,0,o(0.15)),stop(#F97316,1,o(0.0))))] st[(#F97316,w(1.5),cap(n,n),pos(o))] path:d(M0,20 C5,18 10,22 15,16 C20,10 25,14 30,8 C35,12 40,4 45,8 C50,6 55,10 60,6 L60,24 L0,24 Z) "Line"
```

The `L60,24 L0,24 Z` closes the path along the bottom edge. The path scales to fill the clip frame, so closing edges always land at the clipped boundary. The `pad(2,0,0,0)` adds 2px top padding (≥ stroke width) so the curve stroke isn't clipped, while 0 padding on bottom/left/right keeps closing-edge strokes cropped. **The vector must be `s(fill,H)`** — a fixed-width vector smaller than its clip frame leaves the right closing edge visible. The gradient (`180` = top-to-bottom) creates the modern area chart look. For simplicity, `f[(solid(#F97316,o(0.12)))]` (solid at low opacity) also works.

### Common Mistakes

| Wrong | Correct |
|-------|---------|
| Two separate vectors in a group (one stroke, one fill) for sparkline + area | ONE closed vector with both `fill` and `stroke` in a clip frame |
| Placing a colored `rect` behind a sparkline stroke to simulate area fill | Use a **closed vector path** with `f[(solid(#hex,opacity))]` — the rect can't follow the curve |
| Using centered stroke on closed sparkline paths | Use `st[(#hex,w(1.5),cap(n,n),pos(o))]` (outside stroke) + clip frame to hide closing-edge strokes |
| Fixed-width vector `s(60,24)` inside area fill clip frame | Use `s(fill,24)` — path scales to fill the clip frame, keeping closing edges at the clipped boundary |
| Using `L` segments for smooth sparklines | Use `C` cubic beziers — `L` creates jagged zigzags |
| Creating vectors without size | Always declare size: `v() s(60,24)` — the path renders within this box |
| Fighting vector positioning with repeated @X,Y adjustments | Design path coordinates relative to `0,0`, set size with `s(W,H)` to match path bounds, position with `p(X,Y)` |
| Creating separate triangle `vector` elements for arrowheads | Use `cap(n,ar)` on a `line(N)`, `connect(...)`, or `vector` — the arrow cap renders automatically at the endpoint |
| Hand-routing dependency arrows with `v()` paths between elements | Use `connect(#A, #B, route(elbow))` — auto-routes from A to B at end of block, no math required |

### Vector Regions

Vectors with multiple closed regions (e.g. imported SVG logos) expose per-region sub-paths via `vr()` continuation lines in `lookup` output (when `format: "blueprint"`):

```
abc123 v() s(200,200) "Logo"
  vr(r1, M0,0 C50,-20 100,0 100,100 Z) f[(#FF6611)]
  vr(r2, M30,30 L70,30 L70,70 L30,70 Z) f[(#00FF00)]
  vr(r3, M40,40 L60,40 L60,60 L40,60 Z) hole
```

- **`r1`** = largest region, **`r2`** = next, etc. — ordered by area descending
- **`hole`** = cutout (transparent) region
- Each region's SVG path data shows its exact boundary — read the coordinates to understand shape and position
- **All fill types work per-region**: solid, gradient, shader, `inner()`, `glow()`, `blur()`, `img()`

**Modify per-region fills** — reference by region ID, no path data needed:
```
abc123
  vr(r1) f[(solid(#F97316,o(0.15))),(f2,blur(12)),(f3,inner(#000,o(0.2),y(2),blur(4)))]
  vr(r2) f[(solid(#8B5CF6,o(0.1))),(f2,blur(8))]
```

Only listed regions are modified — others keep their current fills. Flat `f[...]` on the element line still applies uniformly to all regions.

**Single-region vectors** (or vectors with no regions) show the standard flat format — no `vr()` lines.

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
| Icons | `svg` — NEVER `vector` |
| Sparklines, trend lines | `vector` with stroke, `C` curves |
| Area charts (filled region under curve) | `vector` with closed path + fill (one element, both stroke and fill) |
| Arrows (straight) | `line(N)` with `cap(n,ar)` and `st[(#hex,w(width))]` |
| Arrows connecting two existing elements | `connect(#A, #B)` with `cap(n,ar)` — auto-routes between refs |
| Arrows (curved, freeform) | `vector` with `st[(#hex,w(width),cap(n,ar))]` arrow cap and `C` curves |
| Simple colored rectangles | `rect` |
| Circles, dots | `circle` |
| Decorative wavy dividers | `vector` with `C` curves |
| Progress rings | Track = `circle` with stroke; progress arc = `circle` with `arc(start,sweep)` — e.g. `c s(80,80) st[(#F97316,w(4),cap(r,r))] arc(90,75) ratio(1)` for 75% starting at top (90°=top, 0°=right) |

### Arrows

Use `cap(n,ar)` to add an arrowhead at the endpoint (`ar` = arrow endCap). Cap can go inline in the stroke or as a top-level token. Works on `line(N)`, `connect()`, and `vector` elements — no separate triangle elements needed.

**Straight arrow** — `line(N)` is the shortest path:
```
line(200) cap(n,ar) st[(#374151,w(1.5))] "Arrow"
```

**Diagonal arrow** — `line(N)` with `rot()`:
```
line(200) p(40,40) rot(45) cap(n,ar) st[(#374151,w(1.5))] "Diagonal arrow"
```
`rot()` pivots around `p()` (the line's start), so the line extends from `p` along the rotated direction.

**Connecting two existing elements** — `connect()` auto-routes with smart defaults (elbow shape + obstacle avoidance):
```
connect(#card1, #card2) cap(n,ar) st[(#888,w(1.5))]                      # smart defaults
connect(#card1, #card2, intent(dependency))                              # preset bundles route + avoid + cap + stroke
connect(#card1, #card2, route(straight), avoid(none))                    # opt out: literal straight line
connect(#card1, #card2, from(r, 0.25), to(l, 0.75))                      # fractional anchors along edges
connect(#card1, #card2, from(#card1_port), to(#card2_port))              # anchor on nested elements
```
**Defaults** (no params): `route(elbow)` + `avoid(all)` — picks an orthogonal shape and routes around any other elements between the endpoints. **Intents** (`dependency`/`flow`/`annotation`) seed defaults; explicit tokens always win. **Routes**: `elbow` (default — single right-angle bend, auto-promoted to 2-bend when needed), `elbow2` (always 2 bends), `straight`, `bezier`. **Avoid**: `all` (default), `endpoints` (only source/target), `none`. **Anchors**: bare side (`tl t tr l c r bl b br`), `(side, fraction)` for a position along an edge, or `(#ref)` to anchor on a nested element. Omit `from`/`to` to auto-pick the closest sides. Path resolves at end of block once both refs exist.

**Curved freeform arrow** — `vector` with bezier:
```
v() s(200,100) st[(#374151,w(1.5),cap(n,ar))] path:d(M0,50 C60,50 140,0 200,0) "Arrow"
```

The arrow cap renders at the last node, oriented along the path tangent. It scales with stroke width automatically.

> **Cross-reference:** See `charts/sparklines`, `charts/bar-charts`, and `charts/line-charts` for complete chart patterns.
