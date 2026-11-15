---
name: "knowledge-layout-guides-visibility"
description: "Reordering layout guides, the two visibility levels, snapping to guides, color and opacity, and tips."
assumes: reference/layout-guides
---

# Layout Guides: Visibility and Snapping

## Reordering Guides

When 2+ guides exist, drag a guide's row by its drag handle and drop it at a new position. Reordering is undoable. Order is a list-management convenience and does not move any guide on the canvas.

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

Guides carry a color (defaults to a semi-transparent red) and a separate 0 to 100% opacity field, editable from the header row (tap the Type dropdown's swatch prefix for the color picker). Both can be bound to design system tokens. These are the color and opacity the guide draws with on the canvas, so changing them changes how the guide looks whenever it is shown. For design-system authoring syntax, see the design-systems knowledge files.

## Tips

- **Multiple guides per frame** (e.g., 8px Grid + 12-column Columns) compose freely
- **Per-frame**: each frame has its own guide list
- **Nested frames** can have different guides than their parents
- Guides live on the frame and travel with it (including across canvases)
