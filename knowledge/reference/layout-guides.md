---
name: "knowledge-layout-guides"
description: "Column, row, and grid layout guides for precise alignment and spacing in frames."
---

# Layout Guides

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Layout guides (also called layout grids) are visual overlay lines on frames that help with alignment, spacing, and content organization.

## Types

| Type | Description | Use Case |
|------|-------------|----------|
| **Grid** | Uniform pixel grid (like graph paper) | Precise pixel-level alignment |
| **Columns** | Vertical sections with gutters | Multi-column layouts (sidebar + content) |
| **Rows** | Horizontal sections with gutters | Multi-row layouts (header + body + footer) |

## Adding Layout Guides

1. Select a frame
2. Right toolbar → "Layout Guides" section
3. Click the **+** button to add a guide (default type: Grid)
4. Change the type using the dropdown in the guide row header (Grid, Columns, or Rows)

**Keyboard shortcuts:** **Ctrl+Shift+G** adds a layout grid. **Shift+G** toggles global guide visibility (see below).

## Common Properties

All guide types share these controls:

| Control | Description |
|---------|-------------|
| **Color swatch** | Click to change guide color (in header row) |
| **Opacity %** | Guide color opacity (in header row, 0–100%) |
| **Eye icon** | Toggle individual guide visibility (in expanded settings) |
| **"−" button** | Delete the guide |

---

## Grid Guides

Create a uniform grid of equally-spaced lines.

**Properties:**
- **Size** — Distance between grid lines in pixels (default: 10)

**Example:** A 10px grid creates lines at 0, 10, 20, 30... pixels.

---

## Column Guides

Create vertical sections for multi-column layouts.

### Alignment Modes

| Mode | Behavior |
|------|----------|
| **Stretch** | Divide frame width evenly, with margins and gutters |
| **Left** | Fixed-width sections from left edge |
| **Right** | Fixed-width sections from right edge |
| **Center** | Fixed-width sections centered in frame |

### Properties

| Property | Applies To | Description |
|----------|-----------|-------------|
| **Count** | All modes | Number of columns (default: 5) |
| **Gutter** | All modes | Gap between columns in pixels (default: 20) |
| **Margin** | Stretch only | Space from frame edges |
| **Section Size** | Left/Right/Center | Width of each column |
| **Offset** | Left/Right only | Starting offset from edge |

### Gutter = 0 Behavior

When gutter is set to **0**, columns render as **crisp divider lines** instead of filled sections. This is useful for alignment references without visual clutter.

---

## Row Guides

Create horizontal sections for multi-row layouts.

### Alignment Modes

| Mode | Behavior |
|------|----------|
| **Stretch** | Divide frame height evenly, with margins and gutters |
| **Top** | Fixed-height sections from top edge |
| **Bottom** | Fixed-height sections from bottom edge |
| **Center** | Fixed-height sections centered in frame |

### Properties

| Property | Applies To | Description |
|----------|-----------|-------------|
| **Count** | All modes | Number of rows (default: 5) |
| **Gutter** | All modes | Gap between rows in pixels (default: 20) |
| **Margin** | Stretch only | Space from frame edges |
| **Section Size** | Top/Bottom/Center | Height of each row |
| **Offset** | Top/Bottom only | Starting offset from edge |

### Gutter = 0 Behavior

Gutter = 0 renders as crisp horizontal divider lines, same as columns.

---

## Reordering Guides

When a frame has multiple guides, you can reorder them:

1. Select a frame with 2+ guides
2. In Right toolbar → Layout Guides section
3. Drag the grip handle on the left of a guide
4. Drop to reorder

The topmost guide in the list renders on top visually.

---

## Visibility (Two Levels)

Layout guide visibility has two independent levels:

| Level | Control | Scope |
|-------|---------|-------|
| **Global** | **Shift+G** | Hides/shows ALL layout guides on ALL frames at once |
| **Per-guide** | Eye icon (expanded settings) | Hides/shows an individual guide |

A guide is only visible (and rendered) when **both** the global toggle is on AND the individual guide's visibility is on.

## Snapping to Guides

Elements inside frames with visible layout guides snap to:
- **Column/Row edges** — Left, right, top, bottom boundaries of each section
- **Grid lines** — Horizontal and vertical grid lines

Snapping requires both visibility levels to be on — the global toggle (Shift+G) must be enabled AND the individual guide must be visible (eye icon). Turning off either disables snapping for that guide.

---

## Tips

- **Use gutter = 0** for crisp alignment lines instead of filled sections
- **Multiple guides** — Combine grids with columns for different purposes
- **Per-frame guides** — Each frame can have its own independent guides
- **Nested frames** — Child frames can have different guides than parents
- **Color coding** — Use different colors to distinguish guide purposes

---

## Related

- [FRAMES.md](./FRAMES.md) — Parent types and auto layout
- [SHORTCUTS.md](./SHORTCUTS.md) — Keyboard shortcuts
