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
2. Press **Enter** to enter vector edit mode
3. Edit nodes, handles, and edges (see sections below)
4. Press **Escape** to exit vector edit mode

---

## Pen Tool

The pen tool creates vector paths by placing nodes one at a time with optional bezier curve control.

### Basic Usage

1. Activate the pen tool (see "How to Access" above)
2. **Click** to place a node (straight edge to previous)
3. **Click and drag** to place a node with bezier handles (smooth curve)
4. Continue clicking to add more nodes
5. **Click the first node** to close the path into a shape
6. Press **Escape** to finish an open path

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

### Closing a Path

Click on the first node to create a closed shape.

### Tips

- Hold **Shift** to constrain angles to 15-degree increments
- Closed paths can have fills and strokes
- After creation, refine in vector edit mode (select path, press **Enter**)

## Node Editing

Enter vector edit mode by selecting a vector element and pressing **Enter**.

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

### Adding Nodes

Hover over an existing edge and click. A new node splits the edge into two.

### Deleting Nodes

Select nodes, press **Delete** or **Backspace**. Adjacent edges merge.

### Bezier Handles

#### Toggling Handles

**Cmd+Click** a node to show/hide handles. Two control points extend from the node.

#### Dragging Handles

Drag a handle endpoint. Handle behavior depends on the node's **point type** (see Point Types below).

#### Detaching Handles

Hold **Alt/Option** while dragging a handle to move only the dragged handle independently (disconnected behavior). This permanently changes the node's point type to Disconnected.

### Deleting Edges

**Shift+Click** an edge to delete it. This disconnects the nodes on either side. If removing an edge leaves a node with no remaining edges, that node is also removed.

### Point Types

Each node has a **point type** that controls how its bezier handles behave. Select a node (or its handles) in vector edit mode to see the point type row in the right toolbar.

| Type | Icon | Behavior |
|------|------|----------|
| **Straight** | V-shaped corner | No handles — sharp corner with straight edges |
| **Mirrored** | Symmetric arms | Handles mirror each other (same direction + same length) |
| **Asymmetric** | Unequal arms | Handles stay co-linear (same angle) but can have different lengths |
| **Disconnected** | Angled arms | Each handle moves independently |

#### Changing Point Type

Click the point type button in the right toolbar. The point type row appears when a node or handle is selected in vector edit mode.

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

Toggle snap guides on/off via the command palette ("Toggle snap guides") or via **Shift+Cmd+'** for pixel grid snap.

---

## Creating Vectors Programmatically

When creating vectors via `create_modify_elements` (not the pen tool), you define paths using SVG path syntax. This is essential for sparklines, area charts, waveforms, and decorative curves.

### How Vector Positioning Works

A vector element's bounding box is defined by `WxH` in the element declaration. Path coordinates render **within** that box:

- `M0,0` = top-left corner of the element
- `M{W},{H}` = bottom-right corner
- `p(X,Y)` positions the element within its parent (just like rects and frames)

```
# A 60x24 sparkline positioned at (10,5) inside a group
Sparkline v 60x24 p(10,5) st[(s1,#3B82F6,1.5)] s(fixed,fixed) path:d(M0,20 C10,16 20,12 30,8 C40,6 50,4 60,2)
```

**The path fills the WxH box.** If your path coordinates exceed `WxH`, the overflow is clipped. If they're smaller, the element has dead space. Design paths to match your declared size.

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
Spark v 60x24 st[(s1,#3B82F6,1.5)] s(fixed,fixed) path:d(M0,22 C6,21 12,20 18,17 C22,16 26,18 30,15 C36,12 42,10 48,8 C52,7 56,5 60,4)
```

**Always use `C` (cubic bezier) for smooth curves.** `L`-only paths look jagged. See `building/DATA.md` → "Realistic Path Shapes" for metric-specific paths (revenue, latency, error rate, etc.) — each metric type has a distinct visual signature.

### Area Fill (Closed Path)

To fill the area under a curve, **close the path at the bottom** and wrap in a **clip frame with outside stroke and top padding**. The closing edges create ugly strokes at the bottom and sides — outside stroke pushes them beyond the vector's bounds, and the clip frame crops them away. Top padding gives the curve's outside stroke room so it isn't clipped:

```
# Your curve:           M0,20 C5,18 ... C50,6 55,10 60,6
# Close at bottom:      L60,24 L0,24 Z
# Full closed path in clip frame:
Spark al(v) s(hug,hug) clip pad(2,0,0,0)
  Area v 60x24 f[(f1,solid(#3B82F6,0.12))] st[(s1,#3B82F6,1.5,n,n,o)] s(fixed,fixed) path:d(M0,20 C5,18 10,22 15,16 C20,10 25,14 30,8 C35,12 40,4 45,8 C50,6 55,10 60,6 L60,24 L0,24 Z)
```

The `L60,24 L0,24 Z` closes the path along the bottom edge, creating a filled region. The `pad(2,0,0,0)` adds 2px top padding (≥ stroke width) so the curve stroke isn't clipped, while 0 padding on bottom/left/right keeps closing-edge strokes cropped. Use `f[(f1,solid(#hex,0.12))]` (12% opacity) for a simple translucent area, or a gradient for a polished fade effect.

### Sparkline + Area Fill (Combined)

Use ONE closed vector with both stroke and fill, wrapped in a clip frame. For a polished look, use a gradient fill that fades from visible near the curve to transparent at the bottom:

```
Spark al(v) s(hug,hug) clip pad(2,0,0,0)
  Line v 60x24 f[(f1,linear(180,stop(#3B82F6,0,0.15),stop(#3B82F6,1,0.0)))] st[(s1,#3B82F6,1.5,n,n,o)] s(fixed,fixed) path:d(M0,20 C5,18 10,22 15,16 C20,10 25,14 30,8 C35,12 40,4 45,8 C50,6 55,10 60,6 L60,24 L0,24 Z)
```

The clip frame + outside stroke combination ensures only the top curve stroke is visible. Top padding prevents the curve stroke from being clipped. The gradient (`180` = top-to-bottom) creates the modern area chart look. For simplicity, `f[(f1,solid(#3B82F6,0.12))]` (solid at low opacity) also works.

### Common Mistakes

| Wrong | Correct |
|-------|---------|
| Two separate vectors in a group (one stroke, one fill) for sparkline + area | ONE closed vector with both `fill` and `stroke` in a clip frame |
| Placing a colored `rect` behind a sparkline stroke to simulate area fill | Use a **closed vector path** with `f[(f1,solid(#hex,opacity))]` — the rect can't follow the curve |
| Using centered stroke on closed sparkline paths | Use `st[(s1,#hex,1.5,n,n,o)]` (outside stroke) + clip frame to hide closing-edge strokes |
| Using `L` segments for smooth sparklines | Use `C` cubic beziers — `L` creates jagged zigzags |
| Creating vectors without `WxH` | Always declare size: `v 60x24` — the path renders within this box |
| Fighting vector positioning with repeated @X,Y adjustments | Design path coordinates relative to `0,0`, set `WxH` to match path bounds, position with `p(X,Y)` |
| Creating separate triangle `vector` elements for arrowheads | Use `st[(s1,#hex,width,n,ar)]` on a `line` or `vector` — the arrow cap renders automatically at the endpoint |

### Vector Regions

Vectors with multiple closed regions (e.g. imported SVG logos) expose per-region sub-paths via `vr()` continuation lines in `get_blueprint` output:

```
abc123 v() s(200,200) "Logo"
  vr(r1, M0,0 C50,-20 100,0 100,100 Z) f[(f1,#FF6611)]
  vr(r2, M30,30 L70,30 L70,70 L30,70 Z) f[(f2,#00FF00)]
  vr(r3, M40,40 L60,40 L60,60 L40,60 Z) hole
```

- **`r1`** = largest region, **`r2`** = next, etc. — ordered by area descending
- **`hole`** = cutout (transparent) region
- Each region's SVG path data shows its exact boundary — read the coordinates to understand shape and position
- **All fill types work per-region**: solid, gradient, shader, `inner()`, `glow()`, `blur()`, `img()`

**Modify per-region fills** — reference by region ID, no path data needed:
```
abc123
  vr(r1) f[(f1,solid(#3B82F6,0.15)),(f2,blur(12)),(f3,inner(#000,0.2,0,2,4))]
  vr(r2) f[(f1,solid(#8B5CF6,0.1)),(f2,blur(8))]
```

Only listed regions are modified — others keep their current fills. Flat `f[...]` on the element line still applies uniformly to all regions.

**Single-region vectors** (or vectors with no regions) show the standard flat format — no `vr()` lines.

### When to Use Vectors vs Other Elements

| Visual Element | Use |
|----------------|-----|
| Icons | `svg` — NEVER `vector` |
| Sparklines, trend lines | `vector` with stroke, `C` curves |
| Area charts (filled region under curve) | `vector` with closed path + fill (one element, both stroke and fill) |
| Arrows (straight) | `line` with `st[(s1,#hex,width,n,ar)]` arrow cap |
| Arrows (curved) | `vector` with `st[(s1,#hex,width,n,ar)]` arrow cap and `C` curves |
| Simple colored rectangles | `rect` |
| Circles, dots | `circle` |
| Decorative wavy dividers | `vector` with `C` curves |
| Progress rings | Track = `circle` with stroke; progress arc = `circle` with `arc(start,sweep)` — e.g. `c s(80,80) st[(s1,#3B82F6,4,r,r)] arc(0,75) ratio(1)` for 75% (see `building/DATA.md` "Circular Progress Ring") |

### Arrows

Use `st[(s1,#hex,width,n,ar)]` to add an arrowhead at the endpoint (`ar` = arrow endCap). Works on both `line` and `vector` elements — no separate triangle elements needed.

**Straight arrow:**
```
Arrow l p(50,100) s(200,100) st[(s1,#374151,1.5,n,ar)]
```

**Curved arrow:**
```
Arrow v 200x100 st[(s1,#374151,1.5,n,ar)] s(fixed,fixed) path:d(M0,50 C60,50 140,0 200,0)
```

The arrow cap renders at the last node, oriented along the path tangent. It scales with stroke width automatically.

> **Cross-reference:** See `building/DATA.md` for complete sparkline, bar chart, and stacked bar patterns with exact coordinates.
