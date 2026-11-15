---
name: "knowledge-frames-from-other-tools"
description: "Figma, Sketch and Illustrator concepts mapped to Brilliant parents, and canvas vs frame."
assumes: reference/frames
---

# Coming From Other Tools

## Figma / Sketch

| Figma / Sketch | Brilliant | Notes |
|----------------|-----------|-------|
| **Frame** | Parent (Frame) | Free-positioning container with fixed sizing by default |
| **Group** (Cmd+G) | Parent (Group) | Always Hug on both axes. NOT a drop target |
| **Auto Layout Frame** (Shift+A) | Parent (Auto Layout) | Flow layout, supports wrap |
| Component | Component | Masters and instances. See `reference/components` |
| Artboard | Canvas (separate page) or Frame (bounded area) | |
| **Mask** (Cmd+Option+M) | Mask (**Ctrl+Cmd+M**) | macOS reserves Cmd+Option+M for "Minimize All Windows" |
| Constraints (pin to edges) | Constraints (pin row in the Element section) | Map 1:1. Imported verbatim from Figma; see `reference/frames/constraints` |
| Absolute position | Pin button in the Element section position row | Same concept |
| Boolean ops | Boolean parents | Each op produces a re-editable parent (double-click into it to edit) |

**Frames, Groups, Masks, and Booleans are all parent elements** distinguished by their type. The app's conversion doors are listed in `reference/frames/nesting` (Convert to Frame for a group, Shift+A for auto layout, Use as mask to un-mask).

## Adobe Illustrator

| Illustrator | Brilliant |
|-------------|-----------|
| Artboard | Canvas or Frame |
| Group (Cmd+G) | Parent (Group) |
| Clipping Mask | Mask (Ctrl+Cmd+M); or Frame + clip-content for rectangular clipping |
| Appearance panel (multiple fills) | Fills section in right toolbar |
| Symbols | Components |
| Pen tool (P) | Pen tool (P) |
| Direct Selection (white arrow) | Vector Edit Mode (Enter on selected element) |
| Pathfinder | Boolean ops: Union (Alt+Shift+U), Subtract (Alt+Shift+S), Intersect (Alt+Shift+I), Exclude (Alt+Shift+E) |
| Image Trace | Not available (vectorize externally, then import SVG) |
| Mesh Gradient | Not available (use linear/radial/angular gradients) |

**Canvas vs Frame:** A canvas is a separate page in the workspace. A frame is an element on a canvas that contains other elements. Many frames per canvas, many canvases per workspace.
