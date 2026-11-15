---
name: "knowledge-editing-hierarchy"
description: "Navigating the hierarchy (Enter, double-click, Escape, Tab), implicit and per-parent selection, and selection visual feedback."
assumes: reference/editing
---

# Editing: Hierarchy and Selection Feedback

### Navigating the Hierarchy

| Action | Result |
|--------|--------|
| Enter | Context-sensitive: selects the children of the selected containers, enters text editing for text elements, enters crop mode for cropped images, enters vector edit mode for shapes, narrows a multi-selection to the innermost element, or finalizes the active edit mode if one is open |
| Double-click | Goes one level deeper: selects the next layer down toward the cursor inside the container a click selects (repeat to go deeper). On the layer itself it edits: text editing, vector edit mode, crop for an image fill. Double-clicking into a boolean or mask opens its edit mode with the shape under the cursor selected. A text two levels down takes two double-clicks to reach and a third to edit. Both clicks must land on the same layer; two quick clicks on two different shapes are just two clicks, so a fast double-click across two shapes in a group, even 15 px apart, leaves the group selected |
| Shift+Enter | Select the parent of the selection |
| Escape | Cancel the current action / exit the current edit mode (frame label, crop, vector edit, vector handle selection, boolean edit, mask edit, pen tool, AI chat). With any other tool or Scale mode active, returns to Move and keeps the selection. With nothing else active, clears selection. |
| Tab | Select the sibling below in the layers panel (wraps around) |
| Shift+Tab | Select the sibling above in the layers panel (wraps around) |

Every selection made on the canvas is revealed in the layers panel: its containers expand and its row scrolls into view.

### Implicit Selection (Full Selection)

When a frame is selected, its descendants are **implicitly selected** for typography operations only (font family, font size, line height, bold/italic/underline, text alignment). This lets you restyle text on every text node inside a frame by selecting the frame alone. Structural changes (add/remove fill or stroke) and geometric operations still target only the explicitly selected elements.

The right toolbar shows a **Selection Colors** section when implicit selection adds extra elements; clicking a color there bulk-changes every element using that color across the full selection hierarchy.

### Per-Parent Selection

Selection is grouped **per parent**, not as one flat set. Select 2 elements in Frame A and 3 in Frame B and you get **two selection rectangles**, one around each parent's group, each with its own set of resize handles. This surprises Figma users, who expect a single bounding box around the whole selection.

Every geometric operation runs **once per parent, in that parent's own coordinate space**: Align Left aligns the 2 elements in Frame A among themselves and separately aligns the 3 in Frame B, resize scales each group against its own box, distribute distributes within each parent. Nothing snaps or aligns across a frame boundary. A selection whose elements all share one parent (including top-level elements, whose parent is the canvas root) shows a single rectangle and behaves as expected.

### Visual Feedback

| Visual | Meaning |
|--------|---------|
| Blue outline | Selected |
| Thin blue outline on hover | Hovered: only the element under the cursor, nothing around it (Settings, Appearance, "Detailed hover highlight" also outlines its children and parent and marks the fill or stroke under the cursor) |
| Resize handles (squares at the corners; every edge resizes along its length) | Can be resized |
| Rotation cursor (diagonally outside a corner) | Hover diagonally outside a corner handle to rotate |
| Solid line with pixel label (Alt+hover) | Distance measurements (see `reference/editing/measurement`) |
