---
name: "knowledge-layout-guides"
description: "Column, row, and grid layout guides: per-frame snap targets and inspector configuration for aligning elements inside a frame."
---

# Layout Guides

Layout guides (also called layout grids) are a per-parent configuration that provides **snap targets** for elements moved or resized inside the parent. Only parent elements (frames, groups, auto layout, masks, booleans) carry layout guides. The **Layout Guides** section in the right toolbar appears whenever any parent is selected. Each parent keeps its own list of guides, and a parent can hold any number of guides in any mix of types.

**They do not render.** Layout guides are snap targets and inspector data only: nothing is drawn on the canvas for them, and they never appear in exports (PNG, JPEG, WebP, SVG, PDF) or in copied output. The color, opacity, and visibility fields below configure each guide's snap behavior and its inspector row; they do not paint anything on the canvas today.

## Types

| Type | Description | Use Case |
|------|-------------|----------|
| **Grid** | Uniform pixel grid (graph paper) | Pixel-level alignment. Default cell size 10 |
| **Columns** | Vertical sections with optional gutter | Multi-column layouts |
| **Rows** | Horizontal sections with optional gutter | Multi-row layouts |

## Adding Layout Guides

1. Select a parent element
2. Right toolbar -> **Layout Guides** section
3. Click the **+** button. The new guide starts as a uniform **Grid**
4. To switch type, change the **Type dropdown** in the new guide's header row to Grid / Columns / Rows
5. Click the **expand button** (slider icon, to the left of the remove button) to reveal the guide's property fields

Adding always inserts a Grid-type guide; switch to Columns or Rows via the row's Type dropdown afterwards. There is **no default keyboard shortcut** for adding a guide. The enable/disable-all keyboard shortcut is **Shift+G**.

## Header Row Controls

Every guide displays a compact header row. Layout (left to right):

| Control | Description |
|---------|-------------|
| **Drag handle** | Always present, but only draggable when 2+ guides exist. Drag to reorder. |
| **Type dropdown** | Grid / Columns / Rows. The dropdown's prefix is a color swatch (tap to open the color picker). |
| **Opacity field (%)** | Color opacity, 0 to 100. |
| **Expand button** (slider icon) | Show/hide the guide's property fields and eye toggle. |
| **Remove button** (minus) | Delete the guide. |

## Per-Guide Properties (Expanded)

Field layout depends on the guide type. The **eye toggle** lives in the expanded fields, NOT the header row.

### Grid Type

| Field | Description |
|-------|-------------|
| Size | Cell size in pixels. Default **10** |
| Eye toggle | Enable/disable this guide as a snap source individually |

A 10px grid places snap lines at 10, 20, 30, ... (skipping the frame edges).

### Columns / Rows

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

### Gutter = 0 Behavior

When Gutter is set to **0**, each section collapses to a single divider position instead of a filled band, so both edges of every section (left and right for columns, top and bottom for rows) coincide as one snap line. Useful for lightweight alignment references (matches Figma's gutter-0 behavior). This changes only the computed snap positions; there is still nothing drawn on the canvas.

## Reordering Guides

When 2+ guides exist, drag a guide's row by its drag handle and drop it at a new position. Reordering is undoable. Order is a list-management convenience only; because guides do not render, it has no visual effect.

## Visibility (Two Levels)

Layout guide visibility has two independent toggles. Both must be on for a guide to act as a snap target.

| Level | Control | Scope |
|-------|---------|-------|
| **Global** | **Shift+G** | Enables/disables ALL layout guides as snap targets, on ALL frames |
| **Per-guide** | Eye toggle in the expanded fields | Enables/disables one guide |

## Snapping to Guides

Elements inside a frame snap to that frame's enabled guides:

- **Columns:** left and right edges of each column
- **Rows:** top and bottom edges of each row
- **Grid:** both horizontal and vertical lines (snaps per-axis)

Snapping works on **rotated and skewed frames**: guide positions follow the frame's orientation. Both the global toggle and the per-guide eye must be on for a guide to act as a snap target; a disabled guide does not snap.

## Color and Opacity

Guides carry a color (defaults to a semi-transparent red) and a separate 0 to 100% opacity field, editable from the header row (tap the Type dropdown's swatch prefix for the color picker). Both can be bound to design system tokens. These fields are stored configuration only: since layout guides do not render, changing them has no on-canvas effect today. For design-system authoring syntax, see the design-systems knowledge files.

## Tips

- **Multiple guides per frame** (e.g., 8px Grid + 12-column Columns) compose freely
- **Per-frame**: each frame has its own guide list
- **Nested frames** can have different guides than their parents
- Guides live on the frame and travel with it (including across canvases)

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

- [frames.md](./frames.md): Parent types and auto layout
- [shortcuts.md](./shortcuts.md): Keyboard shortcuts
- [design-systems.md](./design-systems.md): Binding guide color/opacity to tokens
