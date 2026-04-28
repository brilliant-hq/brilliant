---
name: "knowledge-tools"
description: "Drawing, shape, and utility tools in Brilliant: Move/Scale/Hand, Pen, Pencil, Line, Arrow, Rectangle (fill/stroke), Circle (fill/stroke), Frame, Text, Snip. Shortcuts, modifiers, creation styles, and edit modes."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Tools

The `Tool` enum has 11 values: `move`, `hand`, `pen`, `pencil`, `line`, `arrow`, `rectangle`, `circle`, `frame`, `text`, `snip`. Rectangle and Circle each have a Fill variant and a Stroke variant (separate command IDs, same `Tool` value plus a `CreationStyle`). Scale mode is a flag layered on the Move tool, not a separate `Tool`.

## Tool Overview

| Tool | Shortcut | What it creates |
|------|----------|-----------------|
| Move | V | Selection and direct manipulation of elements |
| Scale (Move + flag) | K | Toggles Scale mode on Move (resize scales content proportionally, like holding Ctrl) |
| Hand | H | Pans the canvas without selecting |
| Pen | P | Vector paths node by node with bezier handles |
| Pencil | Shift+P | Freehand vector paths from a sampled mouse trail |
| Line | L | Straight lines |
| Arrow | Shift+L | Lines with an end-cap arrowhead (configurable in right toolbar) |
| Rectangle (Fill) | R | Filled rectangle |
| Rectangle (Stroke) | Shift+R | Stroke-only rectangle |
| Circle (Fill) | O | Filled circle/ellipse |
| Circle (Stroke) | Shift+O | Stroke-only circle/ellipse |
| Frame | F | Parent container (`ParentType.frame`); auto-captures fully-contained siblings |
| Text | T | Text element with inline editing |
| Snip | S | Screen-region capture stored as an image-fill rectangle |

Bottom toolbar layout (left to right): Move/Scale/Hand dropdown, Shape dropdown (Rectangle, Line, Arrow, Circle), Pen/Pencil dropdown, Frame, Text. The Snip tool is invoked by S or "Change Tool to Snip" in the command palette; it has no dedicated bottom-toolbar button.

## Switching Tools

- Pressing the shortcut switches instantly
- After creating an element, the active tool persists (Pen, Pencil, shape tools, Frame all stay sticky)
- Snip and Text auto-revert to Move after creation
- V returns to Move from any tool
- Switching to any tool other than Move clears Scale mode automatically
- Escape cancels the current contextual action. The dispatcher chooses one based on context:
  - Vector edit mode: first Escape clears node/handle selection, second exits vector edit and returns to Move
  - Pen tool active but not in vector edit mode: Escape switches to Move
  - Crop mode, mask edit, boolean edit, frame label rename, color pick mode, AI chat input: Escape exits each
  - Otherwise: Escape clears selection or closes the command palette

## Drawing Modifiers

| Modifier | Effect |
|----------|--------|
| Shift (while dragging) | Constrains proportions: perfect square (Rectangle, Frame, Snip), perfect circle (Circle), 45 degree angle (Line, Arrow, Pencil), 15 degree angle (Pen node placement and handle drag) |
| Space (while dragging) | Repositions the in-progress element without resizing it |
| Alt (Pen handle drag) | Creates disconnected handles (each side independent) instead of mirrored |
| Pixel-grid snap | Default on. Start and end points round to integer pixels on axes where element-to-element snap did not win. Toggled with Shift+Cmd+' |

## Move Tool (V)

The default tool. Used for selecting, transforming, and direct-manipulation editing.

- Click to select; Shift+click extends selection; Cmd+click toggles individual elements
- Drag to move selected elements
- Alt+drag duplicates the selection and drags the copies; releasing Alt mid-drag cancels duplication and the original takes the dragged position
- Alt+hover (no drag) shows measurement overlays: gap distances between selection and the hovered element, or 4-side padding when the hover target is a parent frame of the selection (or the selection is a frame containing the hover target)
- 8 selection handles per parent (4 corners, 4 edges); drag to resize
- Rotation handles appear just outside the corner handles when hovered
- Drag on empty canvas to draw a marquee. Top-level frames require full containment; other elements require intersection. Cmd during marquee ignores frame containment
- Double-click a vector element to enter vector edit mode; double-click text to edit; double-click a boolean parent to enter boolean edit mode; double-click a mask parent to enter mask edit mode; Alt+double-click an element with a gradient fill shows gradient handles
- Frames pass double-clicks through to their children (Figma behavior). Childless frames with an image fill are an exception and consume double-click for crop entry
- Shift+Enter selects the parent of the current selection
- Tab and Shift+Tab cycle siblings within the current parent

## Scale Mode (K)

Scale is a flag layered on the Move tool, not a separate tool. K switches to Move (if needed) and enables forced proportional content scaling. While Scale mode is on, every resize behaves as if Ctrl were held: proportions are locked AND font sizes, stroke thicknesses, corner radii, effects, and descendant element geometry scale together.

- K from any tool: switches to Move and enables Scale mode
- K while in Move with Scale off: enables Scale mode
- K while Scale mode is on: disables it (returns to regular Move)
- Switching to any other tool clears Scale mode

The Move/Hand bottom-toolbar dropdown lists Move, Scale, and Hand.

## Hand Tool (H)

Pans the canvas. Does not select or move elements. Holding Space in any tool temporarily activates Hand-tool pan; releasing returns to the previous tool.

## Pen Tool (P)

Creates vector paths node by node with optional bezier handles. The Pen tool is sticky: after finishing a path, the tool stays active. After each path, the editor stays in vector edit mode so additional nodes can be added; double-clicking on empty canvas, pressing Escape twice, or switching tools exits.

| Modifier | Effect |
|----------|--------|
| Shift (placing nodes) | Constrains next node position to 15 degree increments from the last node |
| Alt (dragging bezier handles) | Creates disconnected handles (each side independent) instead of mirrored |
| Shift (dragging bezier handles) | Snaps handle angle to 15 degree increments |

Vector edit mode is also entered by double-clicking an existing vector element with the Move tool. Inside vector edit mode: drag nodes, drag bezier handles, marquee-select nodes, copy/cut/paste/delete nodes, and align nodes (alignment commands operate on selected nodes). Boolean edit mode is similar but operates on a boolean parent's children.

## Pencil Tool (Shift+P)

Freehand vector paths from a sampled mouse trail. Drag to draw; release to finish. The resulting element is a vector with editable nodes. Shift constrains segments to 45 degree increments while drawing.

## Line Tool (L)

Straight lines between two points. Shift snaps to 45 degree increments.

## Arrow Tool (Shift+L)

A line with an end-cap arrowhead. Shift snaps to 45 degree increments. Start and end caps are independently configurable in the right toolbar: None, Round, Square, Arrow.

## Rectangle Tool (R, Shift+R)

- R: filled rectangle
- Shift+R: stroke-only rectangle
- Shift while dragging: perfect square
- Corner radii are configurable per-corner in the right toolbar; Cmd+Alt+`=`/`-` increment/decrement, Cmd+Alt+0..9 set radius levels
- Drag handles inside the corners to set radius interactively

## Circle Tool (O, Shift+O)

- O: filled circle/ellipse
- Shift+O: stroke-only circle/ellipse
- Shift while dragging: perfect circle

### Circle Arc Properties

Circles support arc and donut properties, editable via the right toolbar or interactive drag handles:

- Sweep (0 to 100%): how much of the circle to fill. 100% is a full circle.
- Start (0 to 360 degrees): where the arc begins. 0 degrees is 3 o'clock (right); rotation is counter-clockwise.
- Ratio (0 to 1): inner radius as a fraction of the outer radius. 0 is solid; > 0 produces a donut/ring shape.

### Arc Drag Handles

When a circle is selected and you hover over it, interactive handles appear at the midpoint of the visible band (between inner radius and outer radius) along the relevant radial line:

- **Sweep handle**: On the arc-end radial line. Drag to grow/shrink the arc. For a full circle, the handle is at 3 o'clock and the system auto-detects drag direction (CW vs CCW) to decide whether to open the gap by moving the start angle or the end angle.
- **Start handle**: On the start radial line. Hidden when the circle is full (sweep >= 100); visible for partial arcs. Drag to spin the entire arc around the center.
- **Ratio handle**: On the inner edge at the arc midpoint. Hidden when the circle is full (sweep >= 100); visible for partial arcs. Drag outward to create or enlarge the inner hole (ring).

Hit testing uses capsule zones along the radial lines, so the handles are discoverable by hovering anywhere along the radial, not just on the dot itself.

**Shift-snap:** Hold Shift while dragging for stepped increments. Sweep snaps to 5%, start to 15°, ratio to 0.1.

A cursor companion tooltip shows the handle name and live value while hovering or dragging.

## Frame Tool (F)

Creates parent containers (`ParentType.frame`). New frames auto-capture sibling elements whose AABB is fully contained within the frame bounds, reparenting them with z-order preserved. Frames support fills, strokes, per-corner radius, layout grids, and `clipContent`. Shift while dragging produces a perfect square.

Frame conversions:

| Action | Shortcut | Result |
|--------|----------|--------|
| Group selection | Cmd+G | Wraps selection in a group (`ParentType.group`, always hug-sized) |
| Ungroup | Cmd+Shift+G | Removes the group, promoting children to its parent |
| Frame selection | Cmd+F | Wraps selection in a frame (`ParentType.frame`) |
| Add auto layout | Shift+A | Wraps selection in an auto-layout frame (or converts a selected frame) |

## Text Tool (T)

Creates text elements with inline editing.

1. T activates the tool
2. Click on the canvas to place an insertion point
3. Type to enter text
4. Enter, Escape, or clicking outside finishes editing (Shift+Enter inserts a newline)

After commit, the tool auto-reverts to Move. Re-enter editing on an existing text element by double-clicking with Move.

Text styling lives in the right toolbar: family, weight, size, line height, letter spacing, paragraph spacing, alignment, decoration, list style, OpenType features. Cmd+B / Cmd+I / Cmd+U toggle bold/italic/underline. Cmd+Alt+L/T/R align text left/center/right.

## Snip Tool (S)

Captures a screen region as an image element. Drag to define the capture rectangle; Shift constrains to a square. The Brilliant overlay is hidden during the capture so the snip rectangle is not part of the screenshot. The captured image is stored in the per-canvas image cache and embedded as a `PaintStyle.image` fill on a new rectangle element. After capture, the tool auto-reverts to Move.

## Creation Style

Whenever a shape tool (Rectangle or Circle) is active, checkboxes in the right-toolbar fill and stroke section headers control whether new shapes include fill, stroke, or both. The setting persists across canvas operations until changed.

The fill/stroke variant shortcuts (R vs Shift+R, O vs Shift+O) set the active creation style to that single style. To create shapes with both fill and stroke, leave both checkboxes ticked: the next created shape will include both. Pressing R or O after Shift+R or Shift+O resets the creation style to fill-only (or stroke-only respectively).

## Boolean Operations

Combine selected vector/shape elements into a single boolean parent. Operations are non-destructive: the boolean parent stores the operands and re-renders on every change. Double-click a boolean element to enter boolean edit mode; Escape exits.

| Operation | Shortcut | Effect |
|-----------|----------|--------|
| Union | Alt+Shift+U | Sum of all shapes |
| Subtract | Alt+Shift+S | First shape minus the rest |
| Intersect | Alt+Shift+I | Region common to all shapes |
| Exclude | Alt+Shift+E | Symmetric difference (XOR) |
| Flatten | Cmd+Enter | Bake the boolean (or any group) into a single editable vector path |

## Masks

Use a vector or shape as a mask for sibling elements. The mask becomes the parent's first child and clips its siblings.

| Action | Shortcut | Effect |
|--------|----------|--------|
| Use as mask | Cmd+Ctrl+M | Wraps selection so the bottom-most element clips the others |
| Mask edit mode | Double-click mask | Edit the mask shape; Escape exits |

Mask types are configurable per-mask in the right toolbar: vector (default), alpha, luminance.

## Outline Text

Cmd+Ctrl+O converts selected text elements into editable vector outlines. The result is one vector element per text element; the original text is replaced.
