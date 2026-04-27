---
name: "knowledge-layout-guides"
description: "Column, row, and grid layout guides for precise alignment and spacing in frames."
---

# Layout Guides

> **Parent skill:** [reference/layout-guides.md](./layout-guides.md)

Layout guides (also called layout grids) are visual overlay lines on frames that help with alignment, spacing, and content organization. They also serve as **snap targets** for elements moved or resized inside the frame.

## Types

| Type | Description | Use Case |
|------|-------------|----------|
| **Grid** | Uniform pixel grid (like graph paper) | Precise pixel-level alignment |
| **Columns** | Vertical sections with gutters | Multi-column layouts (sidebar + content) |
| **Rows** | Horizontal sections with gutters | Multi-row layouts (header + body + footer) |

A frame can have multiple layout guides of any combination of types.

## Adding Layout Guides

1. Select a frame
2. Right toolbar → **Layout Guides** section
3. Click the **+** button to add a guide (default type: Grid)
4. Change the type using the dropdown in the guide row header (Grid, Columns, or Rows)
5. Click the **expand button** (slider icon) in the header row to expand additional properties (alignment, size, count, gutter, margin, offset, eye toggle)

**Keyboard shortcut:** **Shift+G** toggles the *global* layout-guide visibility (see Visibility below). There is no default keyboard shortcut for adding a guide; use the **+** button or run "Add Layout Grid" from the command palette.

## Header Row Controls

Every guide has a compact header row with these controls (left to right):

| Control | Description |
|---------|-------------|
| **Drag handle** | Visible when 2+ guides exist; drag to reorder |
| **Type dropdown** | Choose Grid / Columns / Rows |
| **Color swatch** | Tap the prefix icon on the type dropdown to open the color picker |
| **Opacity %** | Color opacity in 0–100% (next to the expand button) |
| **Expand button** (slider icon) | Show/hide property fields and the eye toggle |
| **Remove button** (minus) | Delete the guide |

## Per-Guide Properties (Expanded)

When expanded, the property fields and the **eye toggle** become visible. Field layout depends on the guide type.

### Grid Type

| Field | Description |
|-------|-------------|
| **Size** | Distance between grid lines in pixels (default: 10) |
| **Eye toggle** | Hide/show this individual guide |

**Example:** A 10px grid creates lines at 0, 10, 20, 30... pixels.

### Columns / Rows

| Row | Fields |
|-----|--------|
| 1 | Alignment dropdown + Eye toggle |
| 2 | Count + Gutter |
| 3 | Conditional (depends on alignment): Margin (Stretch), Section Size only (Center), or Section Size + Offset (Left/Right/Top/Bottom) |

**Alignment Modes:**

| Mode | Columns Behavior | Rows Behavior |
|------|------------------|---------------|
| **Stretch** (default) | Divide frame width evenly with margins and gutters | Divide frame height evenly |
| **Left** / **Top** | Fixed-size sections from left/top edge | — |
| **Right** / **Bottom** | Fixed-size sections from right/bottom edge | — |
| **Center** | Fixed-size sections centered in frame | — |

**Properties:**

| Property | Applies To | Description |
|----------|-----------|-------------|
| **Count** | All modes | Number of columns/rows (default: 5, min 1) |
| **Gutter** | All modes | Gap between sections in pixels (default: 20) |
| **Margin** | Stretch only | Space from frame edges (default: 0) |
| **Section Size** | Left / Right / Top / Bottom / Center | Width/height of each fixed section (default: 100) |
| **Offset** | Left / Right / Top / Bottom | Starting offset from edge (default: 0). Not shown for Center |

### Gutter = 0 Behavior

When gutter is set to **0**, columns and rows render as **crisp thin divider lines** instead of filled sections. This is useful for alignment references without visual clutter, and matches Figma's behavior.

- Lines are drawn at constant screen-pixel width regardless of zoom
- Anti-aliasing is disabled for pixel-perfect crispness
- Both edges of every section are drawn (left and right for columns, top and bottom for rows)

## Reordering Guides

When a frame has 2+ guides:

1. Select the frame
2. In Right toolbar → Layout Guides section
3. Drag the grip handle on the left of a guide
4. Drop to reorder

The topmost guide in the list renders on top of the others.

## Visibility (Two Levels)

Layout guide visibility has two independent levels:

| Level | Control | Scope |
|-------|---------|-------|
| **Global** | **Shift+G** | Hides/shows ALL layout guides on ALL frames at once |
| **Per-guide** | Eye icon (in the expanded section) | Hides/shows an individual guide |

A guide is only visible (and only acts as a snap target) when **both** levels are on.

## Snapping to Guides

Elements inside a frame snap to that frame's visible layout guides:

- **Column/Row edges** — Left and right boundaries of each column, top and bottom of each row
- **Grid lines** — Both horizontal and vertical grid lines (snapping works per axis)

Snapping requires both visibility levels to be on (Shift+G global toggle AND the per-guide eye icon). Turning off either disables snapping for that guide.

Snapping works even with rotated frames, guide positions are transformed to world coordinates for accurate snapping.

## Color and Opacity

- **Color**: Click the color swatch (prefix on the type dropdown) to open the standard color picker. Default color is a semi-transparent red
- **Opacity**: Edit directly in the % field in the header row (range 0–100%)
- **Tokens**: Opacity supports design system token references

## Tips

- **Use gutter = 0** for crisp alignment lines instead of filled sections
- **Multiple guides** — Combine grids with columns for different purposes (e.g., 8px grid + 12-column layout)
- **Per-frame guides** — Each frame has its own independent guides
- **Nested frames** — Child frames can have different guides than parents
- **Color coding** — Use different colors to distinguish guide purposes
- **Cross-canvas** — Guides are stored per-frame and follow the frame across canvases when moved

## Related

- [frames.md](./frames.md) — Parent types and auto layout
- [shortcuts.md](./shortcuts.md) — Keyboard shortcuts
