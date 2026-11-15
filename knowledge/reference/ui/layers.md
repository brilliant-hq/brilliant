---
name: "knowledge-ui-layers"
description: "The Layers Explorer: the element tree of the active canvas, its icons, boolean slots, reorder, rename, and layer search."
assumes: reference/ui
---

# Layers Explorer

All elements on the active canvas in a hierarchical tree.

Features:
- Element type icons per type, including component master / instance markers
- A **switch icon** marks a **boolean slot**: the on/off wrapper a Figma boolean property imports as (a tiny two-state component instance around the shown/hidden child). The icon is filled when the slot is on, an outline when off, so you can read the state at a glance instead of seeing what looks like a duplicate layer. Hovering it names it a switch. It behaves like any other layer (click to select, rename, reorder).
- Indentation lines show parent-child relationships
- Click to select on canvas; Cmd/Shift+Click for multi-select
- Drag to reorder (changes z-order) or reparent into a frame
- Inline rename (double-click a row, Enter on the focused row, or Cmd+R)
- Type-to-filter via the layer-search palette

The magnifier on the Layers header turns the header into a search field that filters the tree in place (a match keeps its parent frames; Esc puts the header back). **Cmd+L** is **Search Files** (the same in-place search on the Files header). Layer search in the palette has no default shortcut; it is in the Edit menu, the palette, and Cmd+K's Layers filter.

**Layer order:** Top of list = front (highest z-order). Drag a row from anywhere on it (not just the name) to reorder; a click without moving selects it.
