---
name: "knowledge-frames-auto-layout-in-place"
description: "Shift+A on a single frame converts it to auto layout in place instead of wrapping it."
assumes: reference/frames
---

# Single-Frame In-Place Conversion

**A single selected frame is never wrapped** (this matches Figma). Shift+A applies auto layout to the frame you selected, in place: same element, same id, same fills, strokes, corner radii and clipping, same children in the same order. Nothing new appears in the layers panel, and the HTML export gains no extra wrapper tag.

| Selection | What Shift+A does |
|-----------|-------------------|
| A single Frame or Group | Converts that parent to Auto Layout **in place** |
| A single Mask or Boolean | Wraps it in a new auto layout frame (converting would undo the mask or the boolean result) |
| A single parent that is **already** Auto Layout | **Nothing.** No wrapper frame, no undo step |
| A single non-parent (a lone rectangle, vector, text) | Wraps it in a new auto layout frame |
| Several elements, or several frames | Wraps the selection in a new auto layout frame |

On the in-place conversion, children are sorted by spatial position along the inferred main axis, and padding is computed from the existing frame bounds.

**Auto layout never stacks layers on top of each other.** One auto layout frame is one row or one column. When the layers sit in more than one row or column (a page with a header, a hero, a card grid and a footer, or a background behind content) and one flow would place layers on top of layers they did not overlap before, Shift+A and the type dropdown leave everything exactly as it was, spend no undo step, and say "Auto layout left this layout as it was". Add auto layout to each row or column instead (select a row, Shift+A), then nest. Layers that already overlapped (an avatar stack) and a loose grid that can be tidied into one line without overlap still convert.

Because the already-auto-layout case does nothing, Shift+A is safe to press twice, and safe on frames that arrived with auto layout already set (a Figma import, or a blueprint you built with `al`). To put an existing auto layout frame inside another one, group it first (Cmd+G), then press Shift+A on the group.
