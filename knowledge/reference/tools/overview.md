---
name: "knowledge-tools-overview"
description: "The tool table with shortcuts, the bottom toolbar layout, switching tools, and what Escape does per context."
assumes: reference/tools
---

# Tools: Overview and Switching

## Tool Overview

| Tool | Shortcut | What it creates |
|------|----------|-----------------|
| Move | V | Selection and direct manipulation of elements |
| Scale (Move + flag) | K | Toggles Scale mode on Move (resize scales content proportionally, like holding Ctrl) |
| Hand | H | Pans the canvas without selecting |
| Pen | P | Vector paths node by node with bezier handles |
| Pencil | Shift+P | Freehand vector paths from a sampled mouse trail |
| Line | L | Straight lines |
| Arrow | Shift+L | Lines with an end-cap arrowhead (configurable in right toolbar) |
| Rectangle (Fill) | R | Filled rectangle |
| Rectangle (Stroke) | Shift+R | Stroke-only rectangle |
| Circle (Fill) | O | Filled circle/ellipse |
| Circle (Stroke) | Shift+O | Stroke-only circle/ellipse |
| Frame | F | Parent container; auto-captures fully-contained siblings |
| Text | T | Text element with inline editing |
| Snip | S | Screen-region capture stored as an image-fill rectangle |

Bottom toolbar layout (left to right): Move/Scale/Hand dropdown, Shape dropdown (Rectangle, Line, Arrow, Circle), Pen/Pencil dropdown, Frame, Text. The Snip tool is invoked by S or "Change Tool to Snip" in the palette; it has no dedicated bottom-toolbar button.

## Switching Tools

- Pressing the shortcut switches instantly
- After creating an element, the tool returns to Move (as in Figma): Rectangle, Circle, Line, Arrow, Frame, Text and Snip all hand you back Move once the element exists, so the next press selects or moves what you drew. Press the tool's shortcut again to draw another
- Pencil is the exception: it stays active after each stroke so you can keep drawing
- Pen stays active while a path is open (each click adds a node); finishing the path returns to Move
- A click or drag too small to create anything keeps the current tool
- V returns to Move from any tool
- Switching canvases returns a drawing tool (Pen, Pencil, a shape, Frame, Text, Snip) to Move, so the first click on the other canvas selects instead of drawing; the Hand tool stays
- Switching tools clears Scale mode automatically (this includes selecting the Move tool with V, and Escape; only K turns Scale mode on)
- Escape cancels the current contextual action, chosen based on context:
  - Vector edit mode: Escape exits vector edit and returns to Move; if nodes or handles are selected, the first Escape clears them and the next exits. Escape while you are still dragging a point cancels that drag (the point goes back) and exits
  - Pen tool active but not in vector edit mode: Escape switches to Move
  - Any other tool (Rectangle, Circle, Frame, Line, Arrow, Pencil, Text, Snip, or the Hand picked with H or the toolbar) or Scale mode on: Escape returns to Move and keeps your selection, so a second Escape clears it. Holding Space to pan is not affected: releasing Space already brings your tool back
  - Crop mode, mask edit, boolean edit, frame label rename, color pick mode, AI chat input: Escape exits each
  - Otherwise (Move tool): Escape clears selection or closes the palette

Only one of these contexts applies at a time, so there is no order between them. For every context Escape handles, see Escape Behavior in `reference/shortcuts/selection`.
