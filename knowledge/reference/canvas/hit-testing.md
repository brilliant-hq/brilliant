---
name: "knowledge-canvas-hit-testing"
description: "How clicks resolve to elements per element type, selection rectangles, and the marquee."
assumes: reference/canvas
---

# Canvas: Hit Testing and Selection Rectangles

How clicks resolve to elements, and how the result is shown.

### Hit test rules per element type

| Element kind | Hit test |
|--------------|----------|
| Filled shape (rectangle, circle, vector region) | Inside the rendered fill path (respects corner radii, arcs, rings) |
| Outlined shape with no fill | Within 4 screen pixels of the stroke |
| Vector path (line, curve) | Within 4 screen pixels of the path; closed paths additionally hit on filled regions |
| Text | Inside the text bounding box |
| Top-level frame, auto-layout frame or component (root) | The frame label above the top-left corner selects the frame; clicking the frame body passes through to children (an empty one selects by body). Cmd+click on the body selects the frame. Frames are always hit-testable on their fill area even without an explicit fill. |
| Nested frame, or a top-level instance | Anywhere on the frame's fill or stroke |
| Group with children | Only its children: the empty area between them selects nothing (an empty group selects by its area) |
| Boolean / mask parent | Uses the resulting visible shape, not the rectangular bounding box |
| Circle arc / ring | Hit test follows the arc fill path or ring band, not the full ellipse |

Tolerance is 4 screen pixels at any zoom level. Stacking order is topmost-first: the last-drawn element wins.

What a click then SELECTS from the layer under the cursor (the outermost layer below the top-level frame, the depth you reached, Cmd for any depth) is described in `reference/editing/selection`.

### Selection rectangles

Selection is per-parent. With 2 elements selected in Frame A and 3 in Frame B, two selection rectangles render, one per parent. Each has its own resize and rotate handles, and align/distribute/resize commands operate within each parent's coordinate space independently.

The selection rectangle (and the hover highlight) hugs the shape geometry itself, not the stroke: a thick outside stroke or a per-side border never inflates the rectangle, like Figma. Hit testing still includes the stroke band, so you can click a stroke to select its element even though the rectangle sits on the shape edge.

Selection handles auto-hide when they would dwarf a small selection; multi-parent selections always show handles, and two-point paths (lines) always show handles.

### Marquee (drag-to-select)

Drag on empty canvas (or on a top-level frame's empty background) to draw a selection rectangle. It selects what a click would select, the same as Figma. Rules:
- Top-level layers are selected as soon as the marquee touches them; a top-level group, boolean, mask or component instance is selected as one layer, never its children
- Top-level frames **with children** are selected only when fully contained by the marquee; otherwise the marquee selects the frame's direct children that it touches, each as one layer (a group or frame inside is selected whole, never opened). A childless top-level frame is selected on contact, like any layer
- Shift+drag adds to the current selection
- Cmd+drag (Ctrl on Windows/Linux) is the deep marquee: it selects the deepest layers it touches at any depth (shapes, text, images, empty frames or groups), never their containers. Cmd+drag always draws a marquee, even when it starts on a layer
