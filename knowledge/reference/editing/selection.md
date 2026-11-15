---
name: "knowledge-editing-selection"
description: "Click selection (outermost layer, staying at depth, Cmd+click), Select layer, multi-selection, and the marquee."
assumes: reference/editing
---

# Editing: Selection

### Click Selection

Clicking works like Figma: a click selects the **outermost** layer under the cursor, just below the top-level frame, and you go deeper by double-clicking, pressing Enter, or holding Cmd.

| Action | Result |
|--------|--------|
| Click a layer directly inside a top-level frame | Selects that layer |
| Click a layer nested deeper (inside a group, a nested frame, an instance) | Selects the outermost container below the top-level frame (for example the card, not the icon inside it) |
| Click a layer inside a top-level group | Selects the group (only top-level frames, auto-layout frames and components let a click through to their children) |
| Click a top-level element (shape, text, empty frame) | Selects it |
| Click the empty body of a top-level frame with children | Deselects everything (click its label to select the frame) |
| Click the empty area inside a group, between its children | Selects nothing there: a group has no background of its own |
| Click on empty space | Deselects everything |
| Click on a frame label | Selects the frame |
| Cmd+click | Selects the layer under the cursor itself, at any depth; on the empty body of a top-level frame it selects the frame |

**You stay at the depth you reached.** Once something is selected, a click on one of its siblings, or on a sibling of any of its containers, selects that layer directly, at the same depth. A click on a layer inside the selected container keeps the container selected (a single click never goes deeper). A click elsewhere on the canvas starts again from the outermost layer.

**The topmost layer wins, even over the selection.** A click on a layer that sits on top of the selected one selects that layer, and pressing on it and dragging selects it and moves it. A drag that starts on the selected layer itself, or on an empty spot (or a layer underneath) inside its bounds, moves the selection.

**The hover outline shows what a click would select**, and switches to the layer under the cursor while Cmd is held.

**While you edit a text, hovering another text** shows the text cursor and a dashed outline on that text's bounds (blue, or purple inside a component): one click there moves editing into it, even when it sits inside a group.

**Frame selection rule (Figma-style mutual exclusion):** A frame and its descendants cannot be selected at the same time. Selecting a frame deselects all descendants; selecting any element deselects all of its ancestors. Marquee-selecting both a frame and its children keeps only the frame.

**Select layer (pick any layer under the cursor):** right-click on the canvas and hover **Select layer** to see every layer underneath the cursor, top-level frame included, listed topmost first the way the layers panel lists them, with nested layers indented under their parents. Choosing one selects exactly that layer, however deep it sits, and the layers panel opens to show it. With nothing under the cursor the row is not in the menu.

### Multi-Selection

| Action | Result |
|--------|--------|
| Shift+Click | Toggle the layer a click would select in/out of selection (extends or removes) |
| Shift+drag on a layer outside the selection, or drawn above it | Adds it to the selection and drags it with the rest |
| Cmd+A | Select all top-level elements (in vector edit mode: select all nodes and handles) |

### Drag-Select (Marquee)

Click and drag on empty space (or on a top-level frame's empty background) to create a selection rectangle. It selects what a click would select: top-level layers it touches (a top-level group, boolean, mask or component instance is selected whole), and inside a top-level frame the frame's direct children it touches, each as one layer (a group or frame inside is selected whole, never opened). A top-level frame with children is selected only when the rectangle fully encloses it. Hold **Shift** to add to the existing selection. Hold **Cmd** (Ctrl on Windows/Linux) while dragging for the deep marquee: it selects the deepest layers it touches at any depth (shapes, text, images, and empty frames or groups), never their containers. Cmd+drag always draws a marquee, even when it starts on a layer; it never moves anything.

**Cmd+click reaches a region:** on a flattened multi-region vector (or an imported/boolean result), a plain click selects the whole shape while a **Cmd+click** selects just the region under the cursor (its fill fills the inspector, and a recolor or Delete then applies to that region only); Escape steps a region selection back to the whole shape before it clears.
