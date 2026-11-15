---
name: "knowledge-tools-move"
description: "The Move tool (V), Scale mode (K), and the Hand tool (H)."
assumes: reference/tools
---

# Tools: Move, Scale, Hand

## Move Tool (V)

The default tool. Used for selecting, transforming, and direct-manipulation editing.

- Click to select the outermost layer under the cursor below the top-level frame (Figma's click); once something is selected, a click on its siblings (or a sibling of any of its containers) selects at that depth; Cmd+click selects the layer under the cursor at any depth; Shift+click toggles the layer a click would select in/out of selection
- Drag to move selected elements
- Alt+drag duplicates the selection and drags the copies; releasing Alt mid-drag cancels duplication and the original takes the dragged position
- Alt+hover (no drag) shows measurement overlays:
  - Selection vs peer element: gap distances on whichever axis has a gap; edge-to-edge offsets when bounding boxes overlap on both axes
  - Selection contains the hovered element (selection is a frame ancestor): 4-side padding from the hovered child to the frame edges
  - Hovered element is the parent frame of the selection: 4-side padding from selection to the frame edges
  Measurements use upright (axis-aligned) bounding boxes, so rotated elements still measure horizontally/vertically, matching Figma
- 8 selection handles per parent (4 corners, 4 edges); drag to resize
- Rotation handles appear just outside the corner handles when hovered
- Drag on empty canvas to draw a marquee. It selects what a click would: top-level layers it touches (a top-level group is one layer) and a top-level frame's direct children it touches; a top-level frame with children is selected only when fully enclosed. Shift adds. Cmd+drag (Ctrl on Windows/Linux) is the deep marquee: the deepest layers it touches, at any depth; it never moves anything
- Cmd while drag-reparenting drops into the parent of the deepest matching frame (skip one level)
- Double-click goes one level deeper (Figma behavior): when a click selects a container (a group, a nested frame, a card), a double-click on a layer inside it selects the next layer down toward the cursor, and nothing else. Repeat to go deeper
- Double-click edits only once you reach the layer itself: text starts editing (all text selected), a shape enters vector edit mode, a shape with an image fill (or an empty frame with an image fill) enters crop mode. Double-clicking into a boolean or mask selects the shape under the cursor and opens the boolean or mask edit mode. Double-clicking an empty frame or empty group does nothing; double-clicking a frame label renames it
- Alt+double-click an element with a gradient fill shows gradient handles
- Shift+Enter selects the parent of the current selection
- Tab and Shift+Tab cycle siblings within the current parent (Tab selects the sibling below in the layers panel, Shift+Tab the one above)

## Scale Mode (K)

Scale is a flag layered on the Move tool, not a separate tool. K switches to Move (if needed) and enables forced proportional content scaling. While Scale mode is on, every resize behaves as if Ctrl were held: proportions are locked AND font sizes, stroke thicknesses, corner radii, effects, and descendant element geometry scale together.

- K from any tool: switches to Move and enables Scale mode
- K while in Move with Scale off: enables Scale mode
- K while Scale mode is on: disables it (returns to regular Move)
- Switching to any tool clears Scale mode (including Move via V); only K re-enables it
- Escape turns Scale mode off and keeps your selection; a second Escape clears the selection

The Move/Hand bottom-toolbar dropdown lists Move, Scale, and Hand.

## Hand Tool (H)

Pans the canvas. Does not select or move elements. Holding Space in any tool temporarily activates Hand-tool pan; releasing returns to the previous tool.
