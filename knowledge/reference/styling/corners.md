---
name: "knowledge-styling-corners"
description: "Corner radius (uniform, per-corner, parent, smoothing) and circle arc, start and ratio."
assumes: reference/styling
---

# Corner Radius and Circle Arcs

## Corner Radius

### Uniform Radius

| Action | Shortcut |
|--------|----------|
| Radius level 0–9 | Cmd+Alt+0 through Cmd+Alt+9 |
| Increase radius | Cmd+Alt+Shift+= |
| Decrease radius | Cmd+Alt+- |

### Per-Corner Radius

The corner radius row has two toggle buttons for expanding into per-corner editing:

1. **Top/Bottom mode** (first button): Two fields: one for top corners (TL + TR), one for bottom corners (BL + BR).
2. **Individual mode** (second button): Four fields in a 2x2 grid: top-left, top-right, bottom-left, bottom-right.

### Parent Corner Radius

All parent types support corner radius. With the **Clip content** toggle enabled (off by default for all parent types), children are clipped to the rounded bounds.

### Corner Smoothing (Squircle)

A **Smoothing** field (0–100%) rounds corners with a continuous curve instead of a plain circular arc, the squircle look of iOS app icons. It is behind a toggle button (app-icon glyph) that appears in the corner radius row, left of the top/bottom corners button, only when the radius is nonzero; toggling it reveals the smoothing field on its own row. The preset dropdown offers 0%, 30%, 50%, **iOS · 60%**, 80%, 100%. It applies to rectangles and frames, is a single value for all four corners, and has no effect at radius 0. Drag or type a percent to set it.

## Circle Arc & Ratio

Circle elements have additional properties for creating arcs, pie sectors, and donut/ring shapes. Edit them in the right toolbar or use the interactive drag handles (see `reference/tools`).

| Property | Range | Description |
|----------|-------|-------------|
| **Sweep** | 0–100% | How much of the circle to fill. 100% = full circle |
| **Start** | 0–360° | Where the arc begins. 0° = 3 o'clock (right), counter-clockwise (90° = top) |
| **Ratio** | 0–1 | Inner radius fraction. 0 = solid, >0 = donut/ring |

**Stroke caps on arcs:** When sweep < 100% (any arc, including ring sectors), start/end cap controls appear in the stroke section. Use round caps for progress rings, arrow caps for directional arcs.

**Common shapes by hand:**
- **Progress ring:** stroke-only circle, set Ratio to 1, set Sweep to the completion percentage, set Start to 90° (top), round caps.
- **Pie sector:** filled circle, set Sweep to the wedge percentage, Start at 90° for a wedge starting at top.
- **Donut chart segment:** filled circle, set Sweep to the segment percentage, set Ratio to ~0.5 for a thick ring.
- **Full donut:** filled circle, set Ratio above 0 (e.g. 0.6), leave Sweep at 100%.
