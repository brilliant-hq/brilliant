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

## Switching Tools

- Press the shortcut key to switch instantly
- After creating an element, the tool stays active (except Snip and Text, which auto-revert to Move after creation)
- Press **V** to return to the Move tool
- Press **Escape** to cancel the current action. In Pen tool while drawing: first Escape clears node/handle selection, second exits vector edit mode and returns to Move. If Pen tool is active but not drawing, Escape switches directly to Move

## Drawing Modifiers

| Modifier | Effect |
|----------|--------|
| **Shift** (while dragging) | Constrains proportions (square, circle, angle snapping — 45° for shapes/lines/pencil, 15° for pen tool) |
| **Space** (while dragging) | Moves the entire element without changing its size |

## Move Tool (V)

The default tool for selecting and manipulating elements:
- Click to select elements
- Drag to move selected elements
- Hold **Alt/Option** while starting a drag to **duplicate** the selected elements and drag the copies
- Hold **Alt/Option** while hovering (without dragging) to show **measurement overlays** — distance guides between the selected element and the element under the cursor
- Drag selection handles to resize
- Drag rotation handles to rotate
- Drag on empty space to create a selection rectangle

## Scale Mode (K)

Scale mode is not a separate tool — it is a toggle on top of the Move tool. Pressing **K** switches to the Move tool (if not already active) and enables forced proportional content scaling. When Scale mode is on, all resize operations behave as if **Ctrl** is held: resizing scales font sizes, stroke widths, corner radii, effects, and descendant elements proportionally.

- Press **K** to enable Scale mode (switches to Move tool if needed)
- Press **K** again to disable Scale mode (returns to regular Move)
- Switching to any other tool automatically clears Scale mode

Scale mode is indicated visually in the bottom toolbar alongside the Move tool.

## Hand Tool (H)

Pans the canvas without selecting or moving elements. Hold **Space** temporarily while in any tool to switch to the hand tool.

## Pen Tool (P)

Creates vector paths node by node with optional bezier curves. The Pen tool is **persistent** — after finishing a path, the tool stays active so you can draw another path immediately.

**Modifiers:**

| Modifier | Effect |
|----------|--------|
| **Shift** (while placing nodes) | Constrains next node position to 15-degree angle increments from the last node |
| **Alt/Option** (while dragging bezier handles) | Creates disconnected handles (independent control of each side) instead of mirrored |
| **Shift** (while dragging bezier handles) | Snaps handle angle to 15-degree increments |

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

When a circle is selected and you hover over it, interactive handles appear:

- **Sweep handle** — On the arc-end radial line. Drag to grow/shrink the arc. For a full circle, the handle is at 3 o'clock; drag it to open a gap.
- **Start handle** — On the start radial line (visible when sweep < 100%). Drag to spin the entire arc around the center.
- **Ratio handle** — On the inner edge at the arc midpoint (visible when sweep < 100%). Drag outward to create or enlarge the inner hole.

**Shift-snap:** Hold Shift while dragging for stepped increments — sweep snaps to 5%, start to 15°, ratio to 10%.

A cursor companion tooltip shows the handle name and live value while hovering or dragging.

## Frame Tool (F)

Creates parent containers. Newly created parents automatically capture elements that fall fully inside their bounds. Parents can have fill, stroke, and corner radius. Hold **Shift** while dragging for a perfect square.

## Text Tool (T)

Creates text elements:
1. Press **T** to activate
2. Click on the canvas to place text
3. Start typing (inline editing mode)
4. Press **Enter**, **Escape**, or click outside to finish (use **Shift+Enter** to insert a new line)

## Snip Tool (S)

Captures a screen region as an image element. Click and drag to define the capture area. Hold **Shift** while dragging for a perfect square region. The image is stored locally and embedded in the canvas.

## Creation Style

The right toolbar shows checkboxes (in the fill and stroke section headers) controlling whether new shapes include fill, stroke, or both. These checkboxes appear when a shape tool (Rectangle or Circle) is active. The settings persist until changed.

The fill/stroke variant shortcuts (R vs Shift+R, O vs Shift+O) set the creation style directly, but you can also toggle fill and stroke independently via the checkboxes to get both fill and stroke on new shapes.
