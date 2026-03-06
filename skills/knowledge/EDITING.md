---
name: "knowledge-editing"
description: "Selection, movement, resize, rotation, alignment, distribution, z-order, and clipboard operations in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Editing

## Selection

### Click Selection

| Action | Result |
|--------|--------|
| Click on an element | Selects only that element |
| Click on empty space | Deselects everything |
| Click on a frame label | Selects the frame |

**Note:** Top-level frame bodies are not clickable — click the frame label. Nested frames are fully clickable.

### Multi-Selection

| Action | Result |
|--------|--------|
| Shift+Click | Toggle element in/out of selection |
| Cmd+A | Select all elements |

### Drag-Select (Marquee)

Click and drag on empty space to create a selection rectangle. Top-level frames must be fully contained; other elements need only intersect. Hold **Shift** to add to selection.

### Navigating the Hierarchy

| Action | Result |
|--------|--------|
| Enter | Enter the frame (select children) |
| Shift+Enter | Select parent frame |
| Escape | Deselect / cancel current action |
| Tab | Select previous sibling |
| Shift+Tab | Select next sibling |

### Per-Parent Selection

When elements are selected across multiple frames, separate selection rectangles appear per parent. Operations execute independently within each parent's coordinate space.

### Visual Feedback

| Visual | Meaning |
|--------|---------|
| Blue outline | Selected |
| Thin blue outline on hover | Hovered |
| Resize handles (squares) | Can be resized |
| Rotation handles (circles at corners) | Can be rotated |
| Dashed lines with pixel labels (Alt+hover) | Distance measurements (see [CANVAS.md](./CANVAS.md#measurement-overlays)) |

## Movement

### Drag to Move

Select and drag. Snap guides appear automatically.

### Nudge with Arrow Keys

| Action | Shortcut |
|--------|----------|
| Move 1px | Arrow keys |
| Move 10px | Shift+Arrow keys |

### Duplicate While Moving

Hold **Alt/Option** while dragging to create a duplicate.

### Auto-Reparenting

Dragging elements over a frame or auto layout frame automatically reparents them. **Groups are NOT reparent targets** — dragging over a group will not reparent into it. Children inside a group **cannot be dragged out** — they stay in the group. Hold **Space** to prevent reparenting.

### Precise Positioning

Right toolbar shows X and Y fields. Type exact values or drag to adjust.

## Resizing

### Resize Handles

8 handles appear when selected: 4 corner (both directions) and 4 edge (one direction).

### Resize Modifiers

| Modifier | Effect |
|----------|--------|
| **Shift** | Maintain aspect ratio |
| **Ctrl** | Scale mode: proportional resize + scales font sizes, strokes, corner radii, and descendant elements |
| **Cmd** | Preserve crop position (image stays in place during resize) |

### Resize in Auto Layout

Resizing a child in auto layout converts it to **fixed** sizing. The parent recalculates layout.

### Precise Dimensions

Right toolbar shows W and H fields with an aspect ratio lock icon.

## Rotation

### Rotation Handles

Rotation handles appear outside the corner resize handles. Drag to rotate.

| Modifier | Effect |
|----------|--------|
| **Shift** | Snap to 15-degree increments |

### Keyboard Rotation

Rotation levels use a **clock position** metaphor. Each level corresponds to a position on a clock face, in 30-degree increments:

| Level | Clock Position | Angle |
|-------|---------------|-------|
| 0 | 12 o'clock | 0° |
| 1 | 1 o'clock | 30° |
| 2 | 2 o'clock | 60° |
| 3 | 3 o'clock | 90° |
| 4 | 4 o'clock | 120° |
| 5 | 5 o'clock | 150° |
| 6 | 6 o'clock | 180° |
| 7 | 7 o'clock | 210° |
| 8 | 8 o'clock | 240° |
| 9 | 9 o'clock | 270° |

| Action | Shortcut |
|--------|----------|
| Rotation level 0-9 (clock positions) | Cmd+Ctrl+0 through Cmd+Ctrl+9 |
| Increase rotation | Cmd+Ctrl+Shift+= |
| Decrease rotation | Cmd+Ctrl+- |

## Flipping

| Action | Shortcut |
|--------|----------|
| Flip horizontally | Shift+H |
| Flip vertically | Shift+V |

## Scaling

Scaling uniformly resizes elements including text font sizes.

| Action | Shortcut |
|--------|----------|
| Scale level 0-9 | Alt+0 through Alt+9 |
| Scale up | Alt+Shift+= |
| Scale down | Alt+- |

### Scale to Target Dimensions

You can scale an element to a specific target width or height via `execute_commands` with `scale_elements_to_width` or `scale_elements_to_height` commands. This performs uniform scaling — the aspect ratio is preserved, and text font sizes, stroke thickness, and corner radii all scale proportionally.

This is different from setting `width`/`height`, which independently resizes the bounding box without affecting font sizes or strokes.

| Parameter | Effect |
|-----------|--------|
| `scaleToWidth` | Scale uniformly so element width matches target |
| `scaleToHeight` | Scale uniformly so element height matches target |
| `width` / `height` | Resize bounding box independently (no font scaling) |

## Skewing

Skew shears elements into parallelograms — useful for diagonal hero sections, isometric layouts, and dynamic visual effects.

### Via Commands

Use `execute_commands` with `skew_elements`:

| Parameter | Effect |
|-----------|--------|
| `skewX` | Horizontal shear in degrees (positive = lean right) |
| `skewY` | Vertical shear in degrees (positive = lean down) |

### Via Blueprint

Use `skew(x,y)` property:

```
a1b2c3d4 r p(0,0) s(1280,400) skew(-8,0) f[(f1,#3B82F6)] "Hero BG"
```

### Common Values

| Value | Effect |
|-------|--------|
| `-8` to `-12` | Modern SaaS diagonal sections (Stripe-style) |
| `5` to `8` | Subtle dynamic card tilts |
| `15` to `20` | Bold editorial effect |
| `30` | Isometric projection |

## Alignment

| Action | Shortcut |
|--------|----------|
| Align left | Alt+Shift+L |
| Align right | Alt+Shift+R |
| Align top | Alt+Shift+T |
| Align bottom | Alt+Shift+B |
| Center horizontally | Alt+H |
| Center vertically | Alt+V |
| Align horizontally | Alt+Shift+H |
| Align vertically | Alt+Shift+V |
| Fit to parent | Ctrl+Alt+F |

Alignment requires 2+ elements (centering works with a single element — it centers within the parent). When elements span multiple frames, alignment happens independently per parent.

## Distribution

| Action | Shortcut |
|--------|----------|
| Distribute horizontally | Ctrl+Alt+H |
| Distribute vertically | Ctrl+Alt+V |

Requires 3+ elements. Calculates equal gaps between elements.

## Z-Order

| Action | Shortcut |
|--------|----------|
| Bring to front | ] |
| Send to back | [ |
| Bring forward | Cmd+] |
| Send backward | Cmd+[ |

Z-order operates within each parent frame independently. The Layers explorer shows the visual stacking order.

## Boolean Operations

| Action | Shortcut |
|--------|----------|
| Boolean Union | Alt+Shift+U |
| Boolean Subtract | Alt+Shift+S |
| Boolean Intersect | Alt+Shift+I |
| Boolean Exclude | Alt+Shift+E |

Select 2+ elements and apply a boolean operation. The result is a boolean parent that combines the shapes. Also available via right-click context menu.

## Clipboard

| Action | Shortcut |
|--------|----------|
| Copy | Cmd+C |
| Cut | Cmd+X |
| Paste | Cmd+V |
| Duplicate | Cmd+D |
| Delete | Backspace |
| Clear all | C |

### Copy

Copies the selected elements to an internal clipboard. The selection is also exported as a PNG to the system clipboard so it can be pasted into other apps.

**What gets copied:**
- Selected elements and their full hierarchy (frames include all children and nested frames)
- Styling (fills, strokes, corner radius, opacity, layout behavior)
- A single image element with no modifications copies the raw image data to the system clipboard

### Cut

Same as Copy, but also removes the selected elements from the canvas. Undoable.

### Paste

- **Internal paste**: If you previously copied elements with Cmd+C, paste recreates them at the cursor position with new unique IDs. The full hierarchy is preserved — frames paste with all children and nested frames.
- **Paste into frames**: If all currently selected elements are frames, pasting places the copied elements *inside* each selected frame (centered). Each target frame receives its own independent copy. Circular references are prevented (can't paste a frame into itself or its descendants).
- **External paste**: If the system clipboard changed (e.g., copied from another app), paste reads from the system clipboard. Supported formats:
  - **Images** — Creates a rectangle element with the image as a fill
  - **SVG text** — Imports as native vector elements
  - **Plain text** — Creates a text element

### Duplicate

**Cmd+D** creates a copy of the selection:
- Top-level elements are placed to the right of the original, finding the first non-overlapping position
- Children within parents are duplicated at the same position within the parent
- Frame children and nested frames are recursively duplicated
- The duplicates are automatically selected

**Alt/Option+drag** duplicates while moving:
- The original stays at its starting position
- The duplicate moves with the cursor
- Release Alt to cancel duplication (transfers position back to original)
- Works with all element types including frames with children

### Vector Node Copy/Paste

In pen tool edit mode (double-click a vector element or use the pen tool):
- **Cmd+C** copies selected vector nodes and the edges connecting them
- **Cmd+V** pastes nodes at the cursor position
  - If in edit mode: nodes paste into the current vector element
  - If not in edit mode: a new vector element is created with the pasted nodes

### Delete

Deleting from a group causes it to resize. Deleting from auto layout causes siblings to reflow. All deletes are undoable.

## Undo & Redo

| Action | Shortcut |
|--------|----------|
| Undo | Cmd+Z |
| Redo | Cmd+Shift+Z |

### Per-Canvas Undo History

Each canvas has its own independent undo/redo history. Switching canvases does not affect undo stacks — when you return to a canvas, its full undo history is still available.

Canvas switching itself is **not** an undoable action. Pressing Cmd+Z after switching canvases undoes the last action on the *current* canvas, not the canvas switch.

**Undo does not persist across sessions.** Closing and reopening the app clears all undo history. For persistent history, use Git version control (see [CANVASES.md](./CANVASES.md#collaboration--sharing)).

### File Explorer Undo

When the **file explorer** is focused (left toolbar, Cmd+Shift+E), undo/redo applies to **file and folder operations** instead of canvas operations:

- Renaming a canvas or folder
- Creating a canvas or folder
- Deleting a canvas or folder
- Reordering canvases/folders

This is a separate undo stack from the canvas. Pressing Cmd+Z with the file explorer focused will not undo canvas element changes, and vice versa.

### What Is Undoable

All element operations are undoable:
- Creating, deleting, and duplicating elements
- Moving, resizing, rotating, and flipping
- Changing colors, fills, strokes, and opacity
- Text edits
- Alignment and distribution
- Grouping, ungrouping, and reparenting
- Auto layout changes
- Z-order changes
