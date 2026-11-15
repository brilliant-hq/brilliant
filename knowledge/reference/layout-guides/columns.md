---
name: "knowledge-layout-guides-columns"
description: "Columns and Rows layout guide fields: alignment modes, count, gutter, margin, section size, offset, gutter 0, and what a Columns/Rows switch does to the section size."
assumes: reference/layout-guides
---

# Layout Guides: Columns and Rows

Three rows of fields:

| Row | Fields |
|-----|--------|
| 1 | Alignment dropdown · Eye toggle |
| 2 | Count · Gutter |
| 3 | Conditional: Margin (Stretch only), Section Size (Center), or Section Size + Offset (Left/Right/Top/Bottom) |

#### Alignment Modes

| Mode | Columns | Rows |
|------|---------|------|
| **Stretch** (default) | Divide frame width with margin + gutters | Divide frame height with margin + gutters |
| **Left** | Fixed-size columns from left edge |  |
| **Right** | Fixed-size columns from right edge |  |
| **Center** | Fixed-size columns centered horizontally | Fixed-size rows centered vertically |
| **Top** |  | Fixed-size rows from top |
| **Bottom** |  | Fixed-size rows from bottom |

#### Properties

| Property | Applies To | Description | Default |
|----------|------------|-------------|---------|
| Count | All Columns/Rows modes | Number of sections, min 1 | **5** |
| Gutter | All Columns/Rows modes | Pixels between sections | **20** |
| Margin | Stretch only | Inset from frame edges | **0** |
| Section Size | Left, Right, Top, Bottom, Center | Fixed section width/height | **100** |
| Offset | Left, Right, Top, Bottom (NOT Center) | Starting offset from edge | **0** |

### Switching between Columns and Rows

Changing a guide's type between Columns and Rows keeps its alignment (Left reads Top, Right reads Bottom, and back), count and gutter. A Left, Right, Top, Bottom or Center guide whose section size no longer fits the new direction shrinks its section size so every section stays inside the frame (an 800 x 600 frame with Center columns of 144 becomes Center rows of 104). If the gutters alone are too wide, section size and gutter shrink together. Stretch guides already fit and are unchanged. One undo restores both the type and the section size.

### Gutter = 0 Behavior

When Gutter is set to **0**, each section collapses to a single divider position instead of a filled band, so both edges of every section (left and right for columns, top and bottom for rows) coincide as one snap line. Useful for lightweight alignment references (matches Figma's gutter-0 behavior). This changes both the computed snap positions and what is drawn: each section shows a single divider line rather than a filled band.
