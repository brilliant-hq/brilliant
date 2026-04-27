---
name: "knowledge-tools"
description: "All 11 drawing, shape, and utility tools in Brilliant (with fill/stroke variants), plus Scale mode: shortcuts, creation styles, modifiers, and detailed usage."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Tools

Brilliant has 11 tools for creating and manipulating elements on the canvas (Rectangle and Circle each have fill and stroke variants, selectable via Shift), plus a Scale mode toggle.

## Tool Overview

| Tool | Shortcut | What It Creates |
|------|----------|-----------------|
| Move | V | Selects and moves elements |
| Scale (toggle) | K | Toggles a Scale-mode flag on the Move tool (resize scales content proportionally) |
| Hand | H | Pans the canvas without selecting |
| Pen | P | Node-by-node vector paths with curves |
| Pencil | Shift+P | Freehand vector paths |
| Line | L | Straight lines |
| Arrow | Shift+L | Lines with an arrowhead on the end point |
| Rectangle | R | Rectangles (filled by default) |
| Rectangle (stroke) | Shift+R | Rectangles (stroke only) |
| Circle | O | Circles/ovals (filled by default) |
| Circle (stroke) | Shift+O | Circles/ovals (stroke only) |
| Frame | F | Parent containers for grouping elements |
| Text | T | Text elements |
| Snip | S | Screen capture (screenshot region) |

**Bottom toolbar layout:** Tools appear in the bottom toolbar in this order: Move/Scale/Hand dropdown, Shape dropdown (Rectangle, Line, Arrow, Circle), Pen/Pencil dropdown, Frame, Text. The Snip tool is keyboard-only (S) and via the command palette; it has no bottom-toolbar button.

## Switching Tools

- Press the shortcut key to switch instantly
- After creating an element, the tool stays active (except Snip and Text, which auto-revert to Move after creation)
- Press **V** to return to the Move tool
- Switching to any tool other than Move clears Scale mode automatically
- Press **Escape** to cancel the current action. In vector edit mode: first Escape clears node/handle selection, second exits vector edit mode and returns to Move. If Pen tool is active but not in vector edit mode, Escape switches to Move. Escape also exits crop mode, mask edit mode, boolean edit mode, frame label editing, color pick mode, and AI chat input

## Drawing Modifiers

| Modifier | Effect |
|----------|--------|
| **Shift** (while dragging) | Constrains proportions: perfect square (Rectangle, Frame), perfect circle (Circle), 45° angle (Line, Arrow, Pencil), 15° angle (Pen) |
| **Space** (while dragging) | Moves the entire element without resizing it (reposition during draw) |
| **Snap to pixel grid** | Default ON. Start and end points round to nearest integer pixel on axes where element-to-element snap did not win. Toggle with **Shift+Cmd+'** |

## Move Tool (V)

The default tool for selecting and manipulating elements:
- Click to select elements
- Drag to move selected elements
- Hold **Alt/Option** while starting a drag to **duplicate** the selected elements and drag the copies. Releasing Alt mid-drag cancels duplication and the original takes the dragged position
- Hold **Alt/Option** while hovering (without dragging) to show **measurement overlays**: distance guides between the selected element and the hovered element, or 4-side padding when hovering a parent frame of the selection (or vice versa)
- Drag selection handles to resize (8 handles: 4 corners, 4 edges)
- Drag rotation handles to rotate (handles appear just outside corner handles)
- Drag on empty space to create a selection rectangle (marquee). Top-level frames must be fully contained; other elements need only intersect

## Scale Mode (K)

Scale mode is not a separate tool: it is a toggle on top of the Move tool. Pressing **K** switches to the Move tool (if not already active) and enables forced proportional content scaling. When Scale mode is on, all resize operations behave as if **Ctrl** is held: resizing forces proportional resize AND scales font sizes, stroke thicknesses, corner radii, effects, and descendant elements proportionally.

- Press **K** while in another tool to switch to Move and enable Scale mode
- Press **K** while in Move mode to enable Scale mode
- Press **K** while Scale mode is already on to disable it (returns to regular Move)
- Switching to any other tool automatically clears Scale mode

Scale mode appears as the "Scale" option in the Move/Hand dropdown of the bottom toolbar (the dropdown contains Move, Scale, and Hand).

## Hand Tool (H)

Pans the canvas without selecting or moving elements. Hold **Space** temporarily while in any tool to switch to the hand tool.

## Pen Tool (P)

Creates vector paths node by node with optional bezier curves. The Pen tool is **persistent**: after finishing a path, the tool stays active so you can draw another path immediately. The Pen tool keeps you in vector edit mode after each path so you can keep adding nodes; double-click on canvas, press Escape twice, or switch tools to exit.

**Modifiers:**

| Modifier | Effect |
|----------|--------|
| **Shift** (while placing nodes) | Constrains next node position to 15-degree angle increments from the last node |
| **Alt/Option** (while dragging bezier handles) | Creates disconnected handles (independent control of each side) instead of mirrored |
| **Shift** (while dragging bezier handles) | Snaps handle angle to 15-degree increments |

**Vector edit mode:** You can also enter vector edit mode by double-clicking an existing vector element with the Move tool. Inside vector edit mode you can drag nodes, drag bezier handles, marquee-select nodes, copy/paste/delete nodes, and align nodes (alignment commands operate on the selected nodes).

## Pencil Tool (Shift+P)

Creates freehand vector paths by tracking your mouse movement. Click and drag to draw, release to finish. The resulting path is a vector element with editable nodes. Hold **Shift** to constrain segments to 45-degree angles.

## Line Tool (L)

Creates straight lines between two points. Hold **Shift** to snap to 45-degree angles.

## Arrow Tool (Shift+L)

Creates lines with an arrowhead on the end point. Hold **Shift** to snap to 45-degree angles. Start and end caps are configurable in the right toolbar: None, Round, Square, Arrow.

## Rectangle Tool (R / Shift+R)

- **R** — Filled rectangle
- **Shift+R** — Stroke-only rectangle
- Hold **Shift** while dragging for a perfect square

## Circle Tool (O / Shift+O)

- **O** — Filled circle
- **Shift+O** — Stroke-only circle
- Hold **Shift** while dragging for a perfect circle

### Circle Arc Properties

Circles support arc and donut properties, editable via the right toolbar or interactive drag handles:

- **Sweep** (0–100%) — How much of the circle to fill. 100% = full circle.
- **Start** (0–360°) — Where the arc begins. 0° = 3 o'clock (right), counter-clockwise.
- **Ratio** (0–1) — Inner radius as a fraction of the outer radius. 0 = solid, >0 = donut/ring shape.

### Arc Drag Handles

When a circle is selected and you hover over it, interactive handles appear at the midpoint of the visible band (between inner radius and outer radius) along the relevant radial line:

- **Sweep handle**: On the arc-end radial line. Drag to grow/shrink the arc. For a full circle, the handle is at 3 o'clock and the system auto-detects drag direction (CW vs CCW) to decide whether to open the gap by moving the start angle or the end angle.
- **Start handle**: On the start radial line. Hidden when the circle is full (sweep >= 100); visible for partial arcs. Drag to spin the entire arc around the center.
- **Ratio handle**: On the inner edge at the arc midpoint. Hidden when the circle is full (sweep >= 100); visible for partial arcs. Drag outward to create or enlarge the inner hole (ring).

Hit testing uses capsule zones along the radial lines, so the handles are discoverable by hovering anywhere along the radial, not just on the dot itself.

**Shift-snap:** Hold Shift while dragging for stepped increments. Sweep snaps to 5%, start to 15°, ratio to 0.1.

A cursor companion tooltip shows the handle name and live value while hovering or dragging.

## Frame Tool (F)

Creates parent containers. New frames automatically capture sibling elements whose AABB is fully contained within the frame bounds, reparenting them with z-order preserved. Frames can have fill, stroke, corner radius, layout grids, and clip-content. Hold **Shift** while dragging for a perfect square.

The Frame tool creates a regular **frame** (ParentType.frame). To convert frames into **groups** (always hug-sized) or **auto layout** containers, use Cmd+G (group), Cmd+F (frame selection), or Shift+A (auto layout). See `editing.md` for grouping operations.

## Text Tool (T)

Creates text elements:
1. Press **T** to activate
2. Click on the canvas to place text
3. Start typing (inline editing mode)
4. Press **Enter**, **Escape**, or click outside to finish (use **Shift+Enter** to insert a new line)

## Snip Tool (S)

Captures a screen region as an image element. Click and drag to define the capture area. Hold **Shift** while dragging for a perfect square region. The preview is cleared before screen capture (so the snip rectangle isn't captured). The image is stored locally in the design's image cache and embedded as an image fill on a rectangle. After capture, the tool auto-reverts to Move.

## Creation Style

The right toolbar shows checkboxes (in the fill and stroke section headers) controlling whether new shapes include fill, stroke, or both. The checkboxes are visible whenever a shape tool (Rectangle or Circle) is active. The setting persists across canvas operations until explicitly changed.

The fill/stroke variant shortcuts (R vs Shift+R, O vs Shift+O) set the creation style directly. To create a shape with **both** fill and stroke, leave both checkboxes ticked: the next shape created will include both. The variant shortcut you press resets the creation style to that single style, so use the checkboxes when you want both.
