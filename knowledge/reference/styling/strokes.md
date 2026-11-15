---
name: "knowledge-styling-strokes"
description: "Adding and removing strokes, and stroke properties: position, thickness, per-side widths, dash, caps, join."
assumes: reference/styling
---

# Strokes

## Adding and Removing Strokes

| Action | How |
|--------|-----|
| Add a stroke | Shift+S or click "+" in Strokes section |
| Remove a stroke | Alt+S or click delete button |
| Swap fill and stroke | Shift+X |

## Stroke Properties

**Position** (default Center):

| Position | Description |
|----------|-------------|
| Inside | Drawn inside the element edge |
| Center | Centered on the element edge (default) |
| Outside | Drawn outside the element edge |

**Thickness:** Adjust via right toolbar, or use the number keys 0-9 to set the size level (Shift+= to increase, `-` to decrease). These size shortcuts are context-dependent: they set stroke width for shapes, but font size for text elements (or when the text tool is active).

**Per-side widths** (rectangles and frames): the width field sits at the bottom of the stroke configuration (below dash style and corner join) and shows the value shape: "4" when all sides match, "4, 8" when top/bottom and right/left pair up (first number is top/bottom, second is right/left), "1, 2, 3, 4" when all four differ (top, right, bottom, left). Type any of those shapes directly into the field: "6" sets all sides, "4, 8" sets the pairs, "1, 2, 3, 4" sets each side. The two buttons at the right of the row only change which editors are shown, never the stroke itself: the first opens a pairs editor (top/bottom + right/left), the second opens four per-side fields (T, R, B, L), each with the same preset dropdown as the main width field: pick a stroke-width token there to bind that side (or pair) to it, exactly like the uniform width. A side set to 0 draws no border on that side, so a single bottom border is 0, 0, 1, 0. Making all sides equal (in any editor) returns the stroke to a plain uniform width; if the equal sides share one token, the uniform width keeps that binding. On rounded corners each side's border continues through the whole corner arc, ending where the neighboring side's straight edge begins (adjacent sides share the corner arc), like Figma. Per-side borders have no corner-join concept, so the join control disappears while a stroke is per-side.

**Dash pattern:** solid / dashed / dotted presets with dash length, gap length, and dash cap fields in the expanded stroke row.

**Caps** are not a stroke property: they belong to the geometry, so they appear only for open shapes:
- **Vector paths:** each open endpoint (a path that does not close on itself) gets a cap. Options: None (butt), Round (default), Square, Arrow, Circle (filled dot marker). Set per endpoint.
- **Circles:** start cap and end cap (default Round). These controls appear in the stroke section only when the circle's arc sweep is less than 100% (any arc, including ring sectors).
- **Rectangles** and other closed shapes have no caps.

**Join:** miter / round (default) / bevel, set in the expanded stroke row.

**What a stroke holds:** thickness (supports design tokens), optional per-side weights (rect/frame), a paint style (its fill type), position (inside/center/outside), join, dash pattern + dash cap, and a blend mode. Endpoint caps do not live on the stroke (they belong to the geometry, below).
