---
name: "knowledge-editing"
description: "Selection, movement, resize, rotation, alignment, distribution, z-order, grouping, boolean, mask, flatten, and clipboard operations in Brilliant."
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
| Enter | Context-sensitive: exits edit mode (text/crop/vector) if active, drills into frames, narrows multi-selection to innermost, or enters edit mode (text editing, crop for images, vector editing for shapes) |
| Shift+Enter | Select parent frame |
| Escape | Deselect / cancel current action (also exits crop, vector, mask, boolean edit, and frame label modes) |
| Tab | Select previous sibling |
| Shift+Tab | Select next sibling |

### Per-Parent Selection

When elements are selected across multiple frames, separate selection rectangles appear per parent. Operations execute independently within each parent's coordinate space.

### Visual Feedback

| Visual | Meaning |
|--------|---------|
| Blue outline | Selected |
| Thin blue outline on hover | Hovered |
| Resize handles (squares at corners and edges) | Can be resized |
| Rotation cursor (outside corners) | Can be rotated (hover outside corner handles to see rotation cursor) |
| Dashed lines with pixel labels (Alt+hover) | Distance measurements (see [CANVAS.md](./CANVAS.md#measurement-overlays)) |

## Movement

### Drag to Move

Select and drag. Snap guides appear automatically. Hold **Shift** while dragging to constrain movement to the X or Y axis (whichever has the larger delta).

**Reparenting during drag:** Leaving a frame reparents to root immediately. Entering a frame is **deferred until drop** (the target frame is highlighted while you hover; reparenting happens on release).

### Nudge with Arrow Keys

| Action | Shortcut |
|--------|----------|
| Move 1px | Arrow keys |
| Move 10px | Shift+Arrow keys |

Rapid arrow-key presses are debounced into a single undo operation (1 second of inactivity finalizes the undo entry). Inside an auto layout frame, arrow keys **reorder** children along the layout axis instead of nudging spatially.

### Duplicate While Moving

Hold **Alt/Option** while dragging to create a duplicate. Releasing Alt mid-drag cancels duplication and the original element takes the dragged position. The full hierarchy duplicates (frames + children).

### Auto-Reparenting

Dragging elements over a frame or auto layout frame automatically reparents them. **Groups, boolean parents, masks, and component instances are NOT reparent targets**: dragging over them will not reparent into them. Children inside a group, boolean parent, or mask **cannot be dragged out**: they stay in their parent. Children of an auto layout frame can be temporarily moved out of the layout flow with **Space** held (prevents reparenting). Self-containment is also blocked: an element cannot be dropped into its own descendant.

### Snap Guides

While dragging, snap guides show alignment, spacing (gap matching), equidistant centering, and (during create/resize) sizing. Snapping operates within the **primary parent's** coordinate space only: elements never snap across frame boundaries. Toggle all element snapping with the right-toolbar setting; it persists per session.

### Pixel Grid Snap

Default ON. Rounds positions to whole-pixel boundaries on axes where element-snap did not win. Applies to drag move, arrow-key nudge, paste, corner resize, and creation. Edge resize and rotation are exempt. Toggle with **Shift+Cmd+'** (apostrophe). Independent from the visual pixel-grid overlay (Cmd+').

### Precise Positioning

Right toolbar shows X and Y fields. Type exact values, drag to adjust, or use math expressions and natural language (e.g., `+ 50`, `half`, `round 8`). See [UI.md](./UI.md#interactive-fields) for the full list.

## Resizing

### Resize Handles

8 handles appear when selected: 4 corner (resize both axes) and 4 edge (resize one axis). For rotated single elements, handles align to the element's OBB (rotated bounding box). Multi-selection handles are always axis-aligned (AABB) and operate per-parent.

### Resize Modifiers

| Modifier | Effect |
|----------|--------|
| **Shift** | Maintain aspect ratio |
| **Alt/Option** | Symmetric resize from center (both sides/corners move equally) |
| **Ctrl** | Scale mode: proportional resize + scales font sizes, stroke thicknesses, corner radii, effects, and descendants |
| **Cmd** | Compensate image/crop/shader fills for the aspect ratio change (the visible image content stays in place instead of stretching). Without Cmd, image/pattern fills scale with the element |

Dragging past an anchor flips the element (sets `isFlippedH`/`isFlippedV`). Single rotated elements use OBB-based parallelogram-basis decomposition; axis-aligned elements (rotation % 90 == 0) use AABB resize. Lines/arrows have their own 2-endpoint resize.

**Scale mode toggle (K):** Instead of holding Ctrl during every resize, press **K** to enable persistent scale mode. All resizes will scale content proportionally until you press K again or switch tools. See [tools.md](./tools.md#scale-mode-k).

### Resize in Auto Layout

Resizing a child in auto layout converts it to **fixed** sizing. The parent recalculates layout.

### Precise Dimensions

Right toolbar shows W and H fields with an aspect ratio lock icon. All numeric fields support math expressions and natural language (e.g., `* 2/3`, `double`, `50%`, `round 8`). See [UI.md](./UI.md#interactive-fields).

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

### Via Blueprint

Use `sw(W)` or `sh(H)` tokens on modify lines: `#card sw(600)` (scale to 600px width), `#card sh(400)` (scale to 400px height).

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
a1b2c3d4 r p(0,0) s(1280,400) skew(-8,0) f[(#F59E0B)] "Hero BG"
```

### Common Values

| Value | Effect |
|-------|--------|
| `-8` to `-12` | Modern SaaS diagonal sections (Stripe-style) |
| `5` to `8` | Subtle dynamic card tilts |
| `15` to `20` | Bold editorial effect |
| `30` | Isometric projection |

## Alignment

| Action | Shortcut | What It Does |
|--------|----------|--------------|
| Align left | Alt+Shift+L | Line up left edges within the selection bounds |
| Align right | Alt+Shift+R | Line up right edges |
| Align top | Alt+Shift+T | Line up top edges |
| Align bottom | Alt+Shift+B | Line up bottom edges |
| Align horizontally | Alt+Shift+H | Line up Y-centers (same horizontal centerline) |
| Align vertically | Alt+Shift+V | Line up X-centers (same vertical centerline) |
| Center horizontally | Alt+H | Center the selection horizontally **within its parent** |
| Center vertically | Alt+V | Center the selection vertically **within its parent** |
| Fit to parent | Ctrl+Alt+F | Resize the selection to fill its parent |

Alignment (the first six rows) operates against the **selection bounds** and needs 2+ elements to do anything visible. Centering (Alt+H, Alt+V) operates against the **parent bounds** and works with a single element. When elements span multiple frames, every alignment/distribution operation happens **independently within each parent's coordinate space**: each parent gets its own selection bounds and its own centering reference.

## Distribution

| Action | Shortcut |
|--------|----------|
| Distribute horizontally | Ctrl+Alt+H |
| Distribute vertically | Ctrl+Alt+V |

Requires 3+ elements. Calculates equal gaps between elements while preserving the outer two as anchors. Operates per-parent: elements in different frames distribute independently.

## Z-Order

| Action | Shortcut |
|--------|----------|
| Bring to front | ] |
| Send to back | [ |
| Bring forward | Cmd+] |
| Send backward | Cmd+[ |

Z-order operates within each parent frame independently. The Layers explorer shows the visual stacking order.

### Via Blueprint

Use `front`, `front(N)`, `back`, `back(N)` tokens on modify lines: `#card front` (bring to front), `#card back(2)` (send backward 2 steps).

## Boolean Operations

| Action | Shortcut |
|--------|----------|
| Boolean Union | Alt+Shift+U |
| Boolean Subtract | Alt+Shift+S |
| Boolean Intersect | Alt+Shift+I |
| Boolean Exclude | Alt+Shift+E |

Select 2+ elements and apply a boolean operation. The result is a boolean parent that combines the shapes. Also available via right-click context menu. Applying a boolean operation to an existing boolean or mask parent switches its type (e.g., union to subtract, or mask to intersect).

## Grouping and Framing

| Action | Shortcut |
|--------|----------|
| Group | Cmd+G |
| Frame Selection | Cmd+F |
| Ungroup | Cmd+Shift+G |
| Add Auto Layout | Shift+A |

**Group** wraps selected elements into a group with hug sizing on both axes. Groups are structural containers that keep elements together but cannot be used as reparent targets (dragging over a group won't reparent into it). If the selection spans multiple parents, one group is created per parent.

**Frame Selection** wraps selected elements in a frame container.

**Ungroup** removes the frame wrapper and moves children up to the frame's parent.

**Add Auto Layout** wraps selected elements in an auto layout frame with automatic spacing.

## Mask

| Action | Shortcut |
|--------|----------|
| Mask | Ctrl+Cmd+M |

Select 2+ elements. The topmost element becomes the clip shape and the elements below are clipped to it. The result is a mask parent. Applying a boolean operation to an existing mask switches it to that boolean type, and applying mask to an existing boolean parent switches it to a mask. Children of a mask cannot be dragged out (they stay clipped).

## Flatten

| Action | Shortcut |
|--------|----------|
| Flatten | Cmd+Enter |

Converts the selection into a single vector element. Behavior depends on what's selected:

- **Single primitive** (rectangle, circle, line): converts to vector (lossless)
- **Single vector**: no-op
- **Boolean union parent or group/frame**: concatenates children's vector paths (lossless, per-child fills preserved as regions)
- **Boolean subtract/intersect/exclude or mask parent**: combines paths with adaptive sampling
- **Multiple selected elements**: concatenates all as vector paths
- **Text mixed with other types**: text is auto-outlined first (macOS), then everything is concatenated

## Outline Text

| Action | Shortcut |
|--------|----------|
| Outline Text | Ctrl+Cmd+O |
| Flatten Text | (no default shortcut, available via command palette) |

**Outline Text** converts text elements to a group of per-character vector outlines. Each character becomes a separate vector element inside a group. **macOS only.**

**Flatten Text** converts text elements to a single compound vector element. All characters are merged into one vector with per-character regions preserved. **macOS only.** This is the same operation as **Flatten** (Cmd+Enter) when applied to text.

## Rename Layer

| Action | Shortcut |
|--------|----------|
| Rename Layer | Cmd+R |

Renames the selected element's layer name.

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

Same as Copy, but also removes the selected elements from the canvas. In vector edit mode, Cut copies and deletes the selected vector nodes (not the whole element). Undoable.

### Paste

- **Internal paste**: If you previously copied elements with Cmd+C, paste recreates them at the cursor position with new unique IDs. The full hierarchy is preserved — frames paste with all children and nested frames.
- **Paste into frames**: If all currently selected elements are frames, pasting places the copied elements *inside* each selected frame (centered). Each target frame receives its own independent copy. Circular references are prevented (can't paste a frame into itself or its descendants).
- **External paste**: If the system clipboard changed (e.g., copied from another app), paste reads from the system clipboard. Supported formats:
  - **Images** — Creates a rectangle element with the image as a fill
  - **SVG markup** — Imports as native vector elements
  - **Figma JSON** — Imports Figma-formatted element data
  - **Design YAML** — Imports Brilliant's native `.design` format
  - **Blueprint text** — Imports Brilliant's blueprint format
  - **HTML** — Imports HTML with inline CSS (e.g., from the Brilliant Capture browser extension)
  - **Plain text** — Creates a text element

### Duplicate

**Cmd+D** creates a copy of the selection:
- Top-level elements are placed to the right of the original, finding the first non-overlapping position
- Children within parents are duplicated at the same position within the parent
- Frame children and nested frames are recursively duplicated
- The duplicates are automatically selected

**Alt/Option+drag** duplicates while moving:
- The original is restored to its starting position
- The duplicate moves with the cursor
- Release Alt mid-drag to cancel duplication (the duplicate is removed and the original takes the dragged position instead)
- Works with all element types including frames with children

### Vector Node Copy/Paste

In pen tool edit mode (double-click a vector element or use the pen tool):
- **Cmd+C** copies selected vector nodes and the edges connecting them
- **Cmd+V** pastes nodes at the cursor position
  - If in edit mode: nodes paste into the current vector element
  - If not in edit mode: a new vector element is created with the pasted nodes

### Delete

In vector edit mode, Delete removes the selected vector nodes and their connecting edges (not the whole element). Outside edit mode, deleting from a group causes it to resize, and deleting from auto layout causes siblings to reflow. All deletes are undoable.

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
- Crop operations (pan, resize, rotate image within element)
- Boolean operations
- Mask operations
- Flatten and outline text
- Skewing and scaling
