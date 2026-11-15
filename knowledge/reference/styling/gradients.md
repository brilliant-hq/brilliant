---
name: "knowledge-styling-gradients"
description: "Gradient fills: linear, radial, angular and diamond, their canvas handles, and the gradient stop bar."
assumes: reference/styling
---

# Gradient Fills

1. Press **Ctrl+D** (dark gradient) or **Ctrl+L** (light gradient) for quick gradients
2. Or change the fill type to Linear / Radial / Angular / Diamond via the type dropdown on the fill row in the right toolbar, or the type menu beside the stop bar in the color picker
3. Click color stops to edit, add stops by clicking the stop bar in the color picker, drag to reposition, drag a stop off the bar to remove it

Four gradient types are supported: **Linear**, **Radial** (elliptical), **Angular** (sweep / conic), and **Diamond** (a four-point rhombus). Mesh and multi-axis conic gradients are NOT available. Select the gradient type from the fill type dropdown in the right toolbar's "Colors" group.

Gradient handles render on the canvas while the color picker is open for that element's fill or stroke.

**Linear gradients** are defined by start/end points plus a width (shear) handle: drag the start and end handles to set direction, drag the width handle to shear the color bands off perpendicular (leave it where it sits for a plain perpendicular gradient), or click the gradient line to add a color stop.

**Radial gradients** are defined by center, radius, and width handles: drag the center to reposition, drag the radius handle to resize and rotate, drag the width handle to make the gradient elliptical.

**Angular gradients** (sweep/conic) rotate color stops around a center point: drag the center to reposition, drag the angle handle to rotate the gradient start direction. The angular sweep covers a full 360 degrees with wrap-around interpolation across the seam.

**Diamond gradients** radiate along a four-point rhombus and use the same center, radius, and width handles as radial: drag the center to reposition, drag the radius handle to resize and rotate, drag the width handle to stretch or skew the rhombus (both axes stay adjustable).

**Gradient stop bar**: the bar shows the gradient with a square per stop above it, a line from each square across the bar, and each stop's position under it; the selected stop has a blue ring and a blue line, and the color controls edit it. Above the bar, the **angle** field shows the gradient's direction in degrees (0° up, 90° left to right, 180° down; for radial, angular and diamond, the direction of the radius handle): type a value or drag on it (dragging past 0° or 360° keeps turning) to turn the gradient around its middle (its center for radial, angular and diamond), its length kept. **Flip** reverses the stops (positions mirror, each stop keeps its own token binding); **Rotate** turns the gradient 90° clockwise. Each is one undo step. Hovering a stop outlines it (a stop can be dragged). Hover the bar to see where a new stop would go; click the bar to add a stop there (it takes the gradient's color at that point and becomes selected); drag a stop along the bar to move it; drag a stop down or up off the bar and release to remove it (removing one of the last two stops turns the fill into a solid color of the other, the same as Delete). Delete or Backspace removes the selected stop. The selected stop's position shows as a percentage at the left of the value row; drag it, pick from its menu, or type a number (`25` or `25%`). Stops can also be added by clicking the canvas gradient line. Hovering a stop shows the position percentage and color hex, dragging shows just the percentage.

Each gradient stop has its own row in the right toolbar with a hex field, opacity field, and position field. The hex field accepts both hex literals and design token names (e.g. `brand.50`); typing a token name binds that token to the stop only. A purple diamond badge on the hex or opacity field indicates a token binding on that stop.
