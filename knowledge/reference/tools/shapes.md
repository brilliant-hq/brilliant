---
name: "knowledge-tools-shapes"
description: "The Rectangle and Circle tools, circle arc properties, and arc drag handles."
assumes: reference/tools
---

# Tools: Rectangle and Circle

## Rectangle Tool (R, Shift+R)

- R: filled rectangle
- Shift+R: stroke-only rectangle
- Shift while dragging: perfect square
- Corner radii are configurable per-corner in the right toolbar. Cmd+Alt+0..9 set radius levels; Cmd+Alt+Shift+= increases, Cmd+Alt+- decreases.
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
