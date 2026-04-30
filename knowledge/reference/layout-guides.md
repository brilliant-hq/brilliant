---
name: "knowledge-layout-guides"
description: "Column, row, and grid layout guides for alignment and snap targets in frames."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Layout Guides

Layout guides (a.k.a. layout grids, stored in `ParentData.layoutGrids`) are visual overlays on frames that double as **snap targets** for elements moved or resized inside the frame. Only frames (not other element types) carry layout guides.

## Types

| Type | Description | Use Case |
|------|-------------|----------|
| **Grid** | Uniform pixel grid (graph paper) | Pixel-level alignment. Default size 10 |
| **Columns** | Vertical sections with optional gutter | Multi-column layouts |
| **Rows** | Horizontal sections with optional gutter | Multi-row layouts |

A frame can hold any number of guides in any combination of types.

## Adding Layout Guides

1. Select a frame
2. Right toolbar → **Layout Guides** section
3. Click the **+** (Add Layout Grid) button → adds a guide of type **Grid**
4. To switch type, change the **Type dropdown** in the new guide's header row to Grid / Columns / Rows
5. Click the **slider icon** (expand button) on the right of the header to expand property fields

There is **no separate type-picker** at add time. The default type is always Grid; switch via the row's Type dropdown afterwards. There is no default keyboard shortcut for adding a guide. The visibility toggle keybinding is **Shift+G** (global).

## Header Row Controls

Every guide displays a compact header row. Layout (left to right):

| Control | Description |
|---------|-------------|
| **Drag handle** | Visible only when 2+ guides exist. Drag to reorder. |
| **Type dropdown** | Grid / Columns / Rows. The dropdown's prefix is a color swatch (tap to open the color picker). |
| **Opacity field (%)** | Color opacity, 0 to 100. Supports tokens. |
| **Expand button** (slider icon) | Show/hide the guide's property fields and eye toggle. |
| **Remove button** (-) | Delete the guide. |

## Per-Guide Properties (Expanded)

Field layout depends on the guide type. The **eye toggle** lives in the expanded fields, NOT the header row.

### Grid Type

| Field | Description |
|-------|-------------|
| Size | Cell size in pixels. Default **10** |
| Eye toggle | Hide/show this guide individually |

A 10px grid draws lines at 10, 20, 30, ... (skipping the frame edges).

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
| Count | All modes | Number of sections, min 1 | **5** |
| Gutter | All modes | Pixels between sections | **20** |
| Margin | Stretch only | Inset from frame edges | **0** |
| Section Size | Left, Right, Top, Bottom, Center | Fixed section width/height | **100** |
| Offset | Left, Right, Top, Bottom (NOT Center) | Starting offset from edge | **0** |

### Gutter = 0 Behavior

When Gutter is set to **0**, columns/rows render as **crisp thin divider lines** instead of filled sections. Useful as alignment references without visual clutter; matches Figma.

- Lines drawn at `1.0 / zoomScale` (constant screen-pixel width regardless of zoom)
- Anti-aliasing disabled for pixel-perfect crispness
- Both edges of every section are drawn (left and right for columns, top and bottom for rows)

## Reordering Guides

When 2+ guides exist:

1. Drag a guide row in the Layout Guides section
2. Drop it at a new position

The UI displays guides in **reverse array order** (last array element at the top). Reorder is undo/redo friendly via `_registerPerParentUndo`.

Topmost in the displayed list = drawn last = appears on top visually.

## Visibility (Two Levels)

Layout guide visibility has two independent toggles. Both must be on for a guide to render and to act as a snap target.

| Level | Control | Scope |
|-------|---------|-------|
| **Global** | **Shift+G** (`toggle_layout_grids`) | Hides/shows ALL layout guides on ALL frames |
| **Per-guide** | Eye toggle in the expanded fields | Hides/shows one guide |

## Snapping to Guides

Elements inside a frame snap to that frame's visible guides:

- **Columns:** left and right edges of each column
- **Rows:** top and bottom edges of each row
- **Grid:** both horizontal and vertical lines (snaps per-axis)

Snapping works on **rotated frames**: guide positions are transformed via the frame's local basis to world coordinates.

## Color and Opacity

- **Color** is RGBA. Default `0x1AFF0000` (semi-transparent red)
- **Opacity** is a 0–100% field; supports design system tokens via `opacityTokenRef`
- Click the color swatch (prefix icon on the Type dropdown) to open the standard color picker (uses `ChangeColorContext.layoutGrid`)

## Tips

- **Gutter = 0** for crisp dividers instead of filled bars
- **Multiple guides per frame** (e.g., 8px Grid + 12-column Columns) compose freely
- **Per-frame**: each frame has its own guide list (`ParentData.layoutGrids`)
- **Nested frames** can have different guides than parents
- Guides are stored on the frame element and follow the frame across canvases when moved

## Quick Reference

| Task | How |
|------|-----|
| Add a guide | Layout Guides + button → Grid (default) |
| Change type | Row's Type dropdown → Grid / Columns / Rows |
| Toggle global visibility | Shift+G |
| Toggle one guide | Eye icon in the expanded section |
| Edit color | Tap color swatch (Type dropdown prefix) |
| Edit opacity | `%` field in the header row |
| Reorder | Drag the row (when 2+ exist) |
| Remove | `-` button on the right of the header |

## Related

- [frames.md](./frames.md): Parent types and auto layout
- [shortcuts.md](./shortcuts.md): Keyboard shortcuts
