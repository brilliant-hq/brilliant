---
name: "knowledge-layout-guides"
description: "Column, row, and grid layout guides: per-frame snap targets and inspector configuration for aligning elements inside a frame."
---

# Layout Guides

Layout guides (also called layout grids) are a per-parent configuration that provides **snap targets** for elements moved or resized inside the parent. Only parent elements (frames, groups, auto layout, masks, booleans) carry layout guides. The **Layout Guides** section in the right toolbar appears whenever any parent is selected. Each parent keeps its own list of guides, and a parent can hold any number of guides in any mix of types.

**They draw and they snap.** Layout guides are both guide lines and snap targets. Whenever layout grids are shown (Shift+G) and a guide's eye is on, that guide draws on the canvas as lines over the frame's content, kept inside the frame and inside any clipping parent, and guides far outside the view are not drawn. Guides are view chrome, not document content, so they never appear in exports (PNG, JPEG, WebP, SVG, PDF) or in copied output, and they follow the frame through rotation and nesting. The color and opacity fields below set each drawn guide's color and opacity, and the eye toggle hides that one guide.

## Types

| Type | Description | Use Case |
|------|-------------|----------|
| **Grid** | Uniform pixel grid (graph paper) | Pixel-level alignment. Default cell size 10 |
| **Columns** | Vertical sections with optional gutter | Multi-column layouts |
| **Rows** | Horizontal sections with optional gutter | Multi-row layouts |

Each part has its own key:

- `reference/layout-guides/setup`: adding a guide, the header row controls, the Grid type fields
- `reference/layout-guides/columns`: Columns and Rows fields, alignment modes, defaults, gutter 0, switching between Columns and Rows (the section size shrinks to fit)
- `reference/layout-guides/visibility`: reordering, the two visibility levels, snapping to guides, color and opacity, tips

## Quick Reference

| Task | How |
|------|-----|
| Add a guide | Layout Guides + button -> Grid (default) |
| Change type | Row's Type dropdown -> Grid / Columns / Rows |
| Toggle global snapping | Shift+G |
| Toggle one guide | Eye icon in the expanded section |
| Edit color | Tap color swatch (Type dropdown prefix) |
| Edit opacity | `%` field in the header row |
| Reorder | Drag the row (when 2+ exist) |
| Remove | `-` button on the right of the header |

## Related

- `reference/frames`: Parent types and auto layout
- `reference/shortcuts`: Keyboard shortcuts
- `reference/design-systems`: Binding guide color/opacity to tokens
