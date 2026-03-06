---
name: "knowledge-tools"
description: "All 12 drawing, shape, and utility tools in Brilliant: shortcuts, creation styles, modifiers, and detailed usage."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Tools

Brilliant has 12 tools for creating and manipulating elements on the canvas.

## Tool Overview

| Tool | Shortcut | What It Creates |
|------|----------|-----------------|
| Move | V | Selects and moves elements |
| Hand | H | Pans the canvas without selecting |
| Pen | P | Node-by-node vector paths with curves |
| Pencil | Shift+P | Freehand vector paths |
| Line | L | Straight lines |
| Arrow | Shift+L | Lines with arrowhead endpoints |
| Rectangle | R | Rectangles (filled by default) |
| Rectangle (stroke) | Shift+R | Rectangles (stroke only) |
| Circle | O | Circles/ovals (filled by default) |
| Circle (stroke) | Shift+O | Circles/ovals (stroke only) |
| Frame | F | Parent containers for grouping elements |
| Text | T | Text elements |
| Snip | S | Screen capture (screenshot region) |
| Eraser | E | Removes elements by clicking/dragging over them |

## Switching Tools

- Press the shortcut key to switch instantly
- After creating an element, the tool stays active (except Snip and Text, which auto-revert to Move after creation)
- Press **V** to return to the Move tool
- Press **Escape** to cancel the current action (in Pen tool, exits to Move)

## Drawing Modifiers

| Modifier | Effect |
|----------|--------|
| **Shift** (while dragging) | Constrains proportions (square, circle, 45-degree angles) |

## Move Tool (V)

The default tool for selecting and manipulating elements:
- Click to select elements
- Drag to move selected elements
- Drag selection handles to resize
- Drag rotation handles to rotate
- Drag on empty space to create a selection rectangle

## Hand Tool (H)

Pans the canvas without selecting or moving elements. Hold **Space** temporarily while in any tool to switch to the hand tool.

## Pen Tool (P)

Creates vector paths node by node with optional bezier curves. The Pen tool is **persistent** — after finishing a path, the tool stays active so you can draw another path immediately.

**Modifiers while dragging bezier handles:**

| Modifier | Effect |
|----------|--------|
| **Alt/Option** | Creates disconnected handles (independent control of each side) instead of mirrored |
| **Shift** | Snaps handle angle to 15-degree increments |

## Pencil Tool (Shift+P)

Creates freehand vector paths by tracking your mouse movement. Click and drag to draw, release to finish. The resulting path is a vector element with editable nodes.

## Line Tool (L)

Creates straight lines between two points. Hold **Shift** to snap to 45-degree angles.

## Arrow Tool (Shift+L)

Creates lines with arrowhead endpoints. Configurable start and end caps: None, Round, Square, Arrow.

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
- **Start** (0–360°) — Where the arc begins. 0° = 12 o'clock, clockwise.
- **Ratio** (0–1) — Inner radius as a fraction of the outer radius. 0 = solid, >0 = donut/ring shape.

### Arc Drag Handles

When a circle is selected and you hover over it, interactive handles appear:

- **Sweep handle** — On the arc-end radial line. Drag to grow/shrink the arc. For a full circle, the handle is at 3 o'clock; drag it to open a gap.
- **Start handle** — On the start radial line (visible when sweep < 100%). Drag to spin the entire arc around the center.
- **Ratio handle** — On the inner edge at the arc midpoint (visible when sweep < 100%). Drag outward to create or enlarge the inner hole.

**Shift-snap:** Hold Shift while dragging for stepped increments — sweep snaps to 5%, start to 15°, ratio to 10%.

A cursor companion tooltip shows the handle name and live value while hovering or dragging.

## Frame Tool (F)

Creates parent containers. Newly created parents automatically capture elements that fall fully inside their bounds. Parents can have fill, stroke, and corner radius.

## Text Tool (T)

Creates text elements:
1. Press **T** to activate
2. Click on the canvas to place text
3. Start typing (inline editing mode)
4. Click outside or press **Escape** to finish

## Snip Tool (S)

Captures a screen region as an image element. Click and drag to define the capture area. The image is stored locally and embedded in the canvas.

## Eraser Tool (E)

Removes elements by clicking or dragging over them.

## Creation Style

The right toolbar shows checkboxes (in the fill and stroke section headers) controlling whether new shapes include fill, stroke, or both. These checkboxes appear when a shape tool (Rectangle or Circle) is active. The settings persist until changed.
