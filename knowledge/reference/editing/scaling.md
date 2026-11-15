---
name: "knowledge-editing-scaling"
description: "Scaling the selection with its content (scale levels, scale mode) and skewing."
assumes: reference/editing
---

# Editing: Scaling and Skewing

## Scaling

Scaling uniformly resizes the selection and scales its content (font sizes, stroke thickness, corner radii, effects, descendants). This differs from setting W/H in the right toolbar, which resizes the bounding box on one axis without scaling content.

| Action | Shortcut | Amount |
|--------|----------|--------|
| Scale to height N × 36 px | Alt+1 through Alt+9 | level × 36 px (uniform, keeps aspect ratio) |
| Scale to height 18 px | Alt+0 | 18 px (uniform) |
| Scale up | Alt+Shift+= | +1 step (height-based) |
| Scale down | Alt+- | -1 step |

**Windows:** the scale-level chords (Alt+0..9) are unbound, because Alt+digit switches chat sessions there. Use Scale up / Scale down, scale mode (**K**), or the palette (Set Scale - Level N).

To scale to a precise size by hand, enable scale mode (**K** or hold **Ctrl**) and drag a corner handle, which scales all content proportionally.

## Skewing

Skew shears elements into parallelograms (useful for diagonal hero sections, isometric layouts, and dynamic visual effects). There is no dedicated skew handle on the canvas and no inspector field; skew is applied via the `skew_elements` command (AI / MCP `execute_commands`) or the Blueprint `skew(x,y)` shorthand (in degrees: positive skew X leans right, positive skew Y leans down). Typical values: -8 to -12 for modern diagonal sections, 5 to 8 for subtle card tilts, 15 to 20 for bold editorial, ~30 for isometric projection.
