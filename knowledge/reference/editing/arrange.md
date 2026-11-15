---
name: "knowledge-editing-arrange"
description: "Alignment, centering, fit to parent, distribution, and z-order."
assumes: reference/editing
---

# Editing: Alignment, Distribution, Z-Order

## Alignment

| Action | Shortcut | What it does |
|--------|----------|--------------|
| Align left | Alt+Shift+L | Line up left edges to the selection's left edge |
| Align right | Alt+Shift+R | Line up right edges |
| Align top | Alt+Shift+T | Line up top edges |
| Align bottom | Alt+Shift+B | Line up bottom edges |
| Align horizontally | Alt+Shift+H | Line up Y-centers on the same horizontal axis (vertical movement) |
| Align vertically | Alt+Shift+V | Line up X-centers on the same vertical axis (horizontal movement) |
| Center horizontally in parent | Alt+H | Center the selection horizontally within its parent (frame bounds, or viewport for root) |
| Center vertically in parent | Alt+V | Center the selection vertically within its parent |
| Fit to parent | Ctrl+Alt+F | Resize the selection to fill its parent |

Alignment (the first six rows) operates against the **per-parent selection bounds** and needs 2+ elements per parent to do anything visible. Centering (Alt+H, Alt+V) operates against the **parent container bounds** (frame bounds; viewport for root-level selections) and works with a single element. When elements span multiple frames, every alignment, distribution, and centering operation happens independently within each parent's coordinate space.

In **vector edit mode** with 2+ nodes selected, the same alignment / distribution / center commands operate on the selected vector nodes instead of elements.

These commands are also available as buttons in the right toolbar's alignment section.

## Distribution

| Action | Shortcut |
|--------|----------|
| Distribute horizontally | Ctrl+Alt+H |
| Distribute vertically | Ctrl+Alt+V (macOS; on Windows and Linux Ctrl+Alt+V is Paste properties, so use the align row or the palette) |

Requires 3+ elements per parent. Sorts elements by leading edge, keeps the first and last as anchors, then sets equal gaps between the middle elements. If there is not enough space (the gap would be negative), the operation does nothing. Operates per-parent.

## Z-Order

| Action | Shortcut |
|--------|----------|
| Bring to front | ] |
| Send to back | [ |
| Bring forward | Cmd+] |
| Send backward | Cmd+[ |

Z-order operates within each parent frame independently. The Layers explorer (left toolbar) shows the visual stacking order, and you can drag layers there to reorder them.
