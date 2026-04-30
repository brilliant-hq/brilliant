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
| Cmd+Click during drag-reparent | Drop into the parent of the deepest hit frame instead of the deepest frame itself |

**Note:** Top-level frame bodies are not clickable. Click the frame label to select a top-level frame. Nested frames are fully clickable.

**Frame selection rule (Figma-style mutual exclusion):** A frame and its descendants cannot be selected at the same time. Selecting a frame deselects all descendants; selecting any element deselects all of its ancestors. Marquee selecting both a frame and its children keeps only the frame.

### Multi-Selection

| Action | Result |
|--------|--------|
| Shift+Click | Toggle element in/out of selection (extends or removes) |
| Cmd+A | Select all top-level elements (in vector edit mode: select all nodes and handles) |

### Drag-Select (Marquee)

Click and drag on empty space to create a selection rectangle. Top-level frames with children must be fully contained; nested frames, empty top-level frames, and non-frame elements only need to intersect (or for filled rectangles/parents, the rectangle must overlap the fill). Hold **Shift** to add to the existing selection. Hold **Cmd** to select through fills (deep-select: ignores element fills when computing hits).

### Navigating the Hierarchy

| Action | Result |
|--------|--------|
| Enter | Context-sensitive: drills into frames, enters text editing for text elements, enters crop mode for cropped images, enters vector edit mode for shapes, narrows multi-selection to innermost, or finalizes the active edit mode if one is open |
| Shift+Enter | Select parent frame |
| Escape | Cancel current action / exit current edit mode (frame label, crop, vector edit, vector handle selection, boolean edit, mask edit, pen tool, AI chat). With nothing else active, clears selection. |
| Tab | Select previous sibling |
| Shift+Tab | Select next sibling |

### Implicit Selection (Full Selection)

When a frame is selected, its descendants are **implicitly selected** for typography operations only (font family, font size, line height, bold/italic/underline, text alignment). This lets you change text styling on every text node inside a frame by selecting the frame. Structural changes (add/remove fill or stroke) and geometric operations only target the explicitly selected elements.

The right toolbar shows a **Selection Colors** section when implicit selection adds extra elements; clicking a color there bulk-changes every element using that color across the full selection hierarchy.

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

Select and drag. Snap guides appear automatically. Hold **Shift** while dragging to constrain movement to the X or Y axis (whichever has the larger delta from the drag-start position).

**Reparenting during drag:** Leaving a frame reparents to root immediately. Entering a frame is **deferred until drop**: the target frame is highlighted while you hover, reparenting happens on release. Holding **Cmd** during the drag drops into the parent of the deepest matching frame (useful for nested layouts).

### Nudge with Arrow Keys

| Action | Shortcut |
|--------|----------|
| Move 1px | Arrow keys |
| Move 10px | Shift+Arrow keys |

Rapid arrow-key presses are debounced into a single undo entry (1 second of inactivity finalizes it). When **all** selected elements share the same auto layout parent, arrow keys **reorder** children within that frame along the layout axis instead of nudging spatially. Mixed selections (some auto layout, some not, or different parents) fall back to spatial nudge.

### Duplicate While Moving

Hold **Alt/Option** while dragging to create a duplicate at the cursor while the original returns to its starting position. Releasing Alt mid-drag cancels the duplication: the duplicate is removed and the original takes the dragged position. The full hierarchy duplicates (frames with all children).

### Auto-Reparenting

Dragging elements over a frame or auto layout frame automatically reparents them on drop. The following are **not** reparent targets, so dragging over them won't reparent into them:

- Groups (`ParentType.group`)
- Boolean parents
- Masks
- Component instances (and any element nested inside a component instance)

Children of a group, boolean parent, or mask cannot be dragged out: they stay clipped/grouped. Children of an auto layout frame can be temporarily moved out of the layout flow by holding **Space** during the drag (prevents auto-layout snap). Self-containment is also blocked: an element cannot be dropped into its own descendant.

### Snap Guides

While dragging, snap guides show alignment, spacing (gap matching), equidistant centering, and (during create/resize) sizing. Snapping operates within the **primary parent's** coordinate space; elements never snap across frame boundaries. The master snap toggle is in the right toolbar and persists per session.

### Pixel Grid Snap

Default ON. Rounds positions to whole-pixel boundaries on axes where element-snap did not win. Applies to drag move, arrow-key nudge, paste, corner resize, and creation. Edge resize and rotation are exempt. Uses directional threshold logic: corner resize and arrow nudge prefer rounding in the drag direction so elements never jump backwards. Toggle with **Shift+Cmd+'** (apostrophe). This is independent from the visual pixel-grid overlay toggled with **Cmd+'**.

### Precise Positioning

Right toolbar shows X and Y fields. Type exact values, drag to adjust, or use math expressions and natural language (e.g., `+ 50`, `half`, `round 8`). See [UI.md](./UI.md#interactive-fields) for the full list.

## Resizing

### Resize Handles

8 handles appear when selected: 4 corner (resize both axes) and 4 edge (resize one axis). For a single rotated element, handles align to the element's OBB (oriented bounding box). Multi-element selections always show axis-aligned (AABB) handles, one rectangle per parent.

### Resize Modifiers

| Modifier | Effect |
|----------|--------|
| **Shift** | Maintain aspect ratio |
| **Alt/Option** | Symmetric resize from center (both sides/corners move equally from the geometric center) |
| **Ctrl** | Scale mode: proportional resize that also scales font sizes, stroke thicknesses, corner radii, effects, and descendants |
| **Cmd** | Crop-compensate image/shader fills (visible image content stays in place rather than stretching) |

Dragging past an anchor flips the element (sets `isFlippedH`/`isFlippedV`); the resize continues smoothly past zero. Single elements at rotations divisible by 90 degrees use AABB resize; otherwise rotated single elements use OBB parallelogram-basis decomposition. Lines and 2-point arrows have a dedicated endpoint resize: only the `topLeft` and `bottomRight` handles are active (start and end points). Shift on a line constrains the endpoint to 45-degree angles.

**Scale mode toggle (K):** Instead of holding Ctrl during every resize, press **K** to enable persistent scale mode. The Move tool stays active but every resize scales content proportionally and the cursor switches to the rescale icon. Press K again, or switch tools, to exit.

### Resize in Auto Layout

Resizing a child in auto layout converts that axis to **fixed** sizing with the new dimension. The parent recalculates layout immediately. Hug/fill ancestors propagate the size change up the tree.

### Precise Dimensions

Right toolbar shows W and H fields with an aspect ratio lock icon (per `constrainProportions`). All numeric fields support math expressions and natural language (e.g., `* 2/3`, `double`, `50%`, `round 8`). See [UI.md](./UI.md#interactive-fields).

## Rotation

### Rotation Handles

Rotation handles appear just outside the corner resize handles. Drag to rotate around the selection center.

| Modifier | Effect |
|----------|--------|
| **Shift** | Snap to 15-degree increments |

### Keyboard Rotation

Levels use a clock-position metaphor. Each level sets an absolute rotation in 30-degree increments. Level 0 maps to 0 degrees (12 o'clock); levels 1-9 map to N times 30 degrees:

| Level | Clock | Angle |
|-------|-------|-------|
| 0 | 12 | 0° |
| 1 | 1 | 30° |
| 2 | 2 | 60° |
| 3 | 3 | 90° |
| 4 | 4 | 120° |
| 5 | 5 | 150° |
| 6 | 6 | 180° |
| 7 | 7 | 210° |
| 8 | 8 | 240° |
| 9 | 9 | 270° |

| Action | Shortcut | Amount |
|--------|----------|--------|
| Set rotation to level 0-9 | Cmd+Ctrl+0 through Cmd+Ctrl+9 | absolute (above) |
| Rotate clockwise | Cmd+Ctrl+Shift+= | +15° (relative) |
| Rotate counter-clockwise | Cmd+Ctrl+- | -15° (relative) |

Programmatic rotation via `execute_commands` uses one command (`set_rotation`) with operations: `absolute`, `add` / `subtract` (relative offset), `multiply` (factor), `increase` / `decrease` (fuzzy).

## Flipping

| Action | Shortcut | What |
|--------|----------|------|
| Flip horizontally | Shift+H | Toggles `isFlippedH` (mirrors across vertical axis) |
| Flip vertically | Shift+V | Toggles `isFlippedV` (mirrors across horizontal axis) |

Flipping is a per-element property toggle, not a geometry rebuild. Children of flipped frames render flipped via the rendering transform.

## Scaling

Scaling uniformly resizes selected elements and scales their content (font sizes, stroke thickness, corner radii, effects, descendants).

| Action | Shortcut | Amount |
|--------|----------|--------|
| Scale to height N x 36 px | Alt+1 through Alt+9 | level x 36 px (uniform, keeps aspect ratio) |
| Scale to height 18 px | Alt+0 | 18 px (uniform) |
| Scale up | Alt+Shift+= | +1 step (height-based) |
| Scale down | Alt+- | -1 step |

### Scale to Target Dimensions

`scale_elements_to_width` / `scale_elements_to_height` (via `execute_commands`) perform uniform scaling: aspect ratio is preserved, and font sizes, stroke thicknesses, and corner radii scale proportionally. This is different from setting `width` / `height`, which only resize the bounding box on one axis without scaling content.

| Parameter | Effect |
|-----------|--------|
| `scaleToWidth` | Scale uniformly so element width matches target |
| `scaleToHeight` | Scale uniformly so element height matches target |
| `width` / `height` | Resize bounding box independently (no content scaling) |

### Via Blueprint

`sw(W)` or `sh(H)` tokens on modify lines: `#card sw(600)` (scale to 600 px width), `#card sh(400)` (scale to 400 px height).

## Skewing

Skew shears elements into parallelograms (useful for diagonal hero sections, isometric layouts, and dynamic visual effects).

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

## Distribution

| Action | Shortcut |
|--------|----------|
| Distribute horizontally | Ctrl+Alt+H |
| Distribute vertically | Ctrl+Alt+V |

Requires 3+ elements per parent. Sorts elements by leading edge, keeps the first and last as anchors, then sets equal gaps between the middle elements: `gap = (totalSpace - sumOfMiddleWidths) / (n - 1)`. If there is not enough space (gap would be negative), the operation no-ops. Operates per-parent.

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

Select 2+ elements and apply a boolean operation. The result is a boolean parent that combines the children into one shape. Children remain editable: double-click the boolean parent to enter boolean edit mode and modify individual shapes; **Escape** exits.

If a single boolean **or** mask parent is already selected when you run a boolean command, its type switches (e.g., union to subtract, mask to intersect) instead of wrapping it in another parent.

To bake a boolean parent into a single uneditable vector, use **Flatten** (Cmd+Enter).

## Grouping and Framing

| Action | Shortcut | What |
|--------|----------|------|
| Group | Cmd+G | Wraps selection in a group (hug sizing on both axes). Groups are structural only: not a reparent target, children cannot be dragged out. If the selection spans multiple parents, one group is created per parent. |
| Frame Selection | Cmd+F | Wraps selection in a frame container (`ParentType.frame`, hug-sized initially, valid reparent target). Sizing can be switched from hug to fixed/fill afterward. |
| Ungroup | Cmd+Shift+G | Removes the wrapping group/frame, moves children up to the parent |
| Add Auto Layout | Shift+A | Wraps the selection in an auto-layout frame, inferring direction and spacing from existing positions |

## Mask

| Action | Shortcut |
|--------|----------|
| Mask | Ctrl+Cmd+M |

Select 2+ elements. The topmost element becomes the clip shape and the elements below are clipped to it. The result is a mask parent. Applying a boolean command to an existing mask parent switches its type to that boolean (e.g., mask → intersect); applying Mask to an existing boolean parent switches it back to a mask. Children of a mask cannot be dragged out: they stay clipped.

Mask parents support three mask types via the right toolbar: vector (default geometric clip), alpha, and luminance.

## Flatten

| Action | Shortcut |
|--------|----------|
| Flatten | Cmd+Enter |

Converts the selection into a single vector element. Behavior depends on what's selected:

| Input | Result |
|-------|--------|
| Single primitive (rectangle, circle, line) | Convert to vector (lossless) |
| Single vector | No-op |
| Single text element (macOS) | Outline to a single compound vector with per-character regions |
| Boolean union parent | Concatenate children's vector paths (lossless, per-child fills preserved as regions) |
| Group / frame | Concatenate children's vector paths (lossless, per-child fills) |
| Boolean subtract / intersect / exclude or mask parent | Combine paths with adaptive sampling (final shape only, fills not preserved per-child) |
| Multiple selected elements | Concatenate all as vector paths into one element |
| Text mixed with non-text in the selection (macOS) | Texts auto-outline to vectors first, then everything is concatenated |

Text outlining requires CoreText, so flattening text is **macOS only**. Flattening non-text selections works on all platforms.

## Outline Text

| Action | Shortcut |
|--------|----------|
| Outline Text | Ctrl+Cmd+O |
| Flatten Text | (no default shortcut, available via command palette) |

Both commands are **macOS only** (require CoreText).

| Command | Output |
|---------|--------|
| Outline Text | Group of per-character vector elements (each glyph is a separate vector inside a group) |
| Flatten Text | Single compound vector element with per-character regions (same operation as `Flatten` applied to a text element) |

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
| Delete | Backspace (or Delete) |
| Clear all | C (the C key, with no element selected) |

### Copy

Copies the selected elements to an **internal clipboard** (in-memory) and writes a PNG render of the selection to the **system clipboard** so it can be pasted into other apps. Frame children are captured at copy time so cross-canvas paste works even after switching canvases.

**What gets copied:**
- Selected elements and their full hierarchy (frames include all children and nested frames)
- Styling (fills, strokes, corner radius, opacity, layout behavior, effects, component data)
- A single unmodified image element (no strokes, no corner radius, full opacity) writes its raw image bytes to the system clipboard instead of re-rendering

### Cut

Same as Copy plus removes the selected elements from the canvas. In vector edit mode, Cut copies and deletes the selected vector nodes only (not the whole element). Undoable.

### Paste

The system compares the OS clipboard's hash against the last copy. If unchanged, paste uses the faster internal clipboard; if changed, it reads from the system clipboard.

**Internal paste:**

- **At cursor (default):** Recreates the copied elements at the cursor position with fresh IDs, preserving the full hierarchy. Component masters become instances linked to the master; existing instances keep their master link.
- **Into selected frames:** If every currently selected element is a frame, pasting places an independent copy inside **each** selected frame, centered. Circular references are prevented (can't paste a frame into itself or its descendants); failed validation falls back to paste-at-cursor.

**External paste** (when the system clipboard changed):

| Source | Behavior |
|--------|----------|
| Image (PNG, JPEG, etc.) | Creates a rectangle element with the image as a fill |
| SVG markup | Imports as native vector elements (auto-wraps fragments) |
| Figma JSON | Imports Figma-formatted element data |
| Design YAML | Imports Brilliant's native `.design` format (IDs remapped) |
| Blueprint text | Imports Brilliant's Blueprint DSL (IDs remapped) |
| HTML | Imports HTML with inline CSS (e.g., from the Brilliant Capture browser extension) |
| Plain text | Creates a text element |

A 200 ms dedup guard ignores rapid duplicate paste calls (macOS fires both a MethodChannel paste and a keyboard event).

### Duplicate

**Cmd+D** creates a copy of the selection:

- Top-level elements are placed to the right of the original, scanning rightward with a 40 px gap to find the first non-overlapping slot.
- Children inside frames are duplicated at the same relative position inside the same parent.
- Frame children and nested frames are recursively duplicated.
- Component masters are duplicated as proper instances (not raw copies); component instances preserve their link to the master.
- Duplicates are automatically selected. Focus on fills/strokes/regions is remapped from originals to duplicates by index.

**Alt/Option+drag duplicates while moving:**

- The original returns to its starting position; the duplicate moves with the cursor.
- Releasing Alt **mid-drag** removes the duplicate and the original takes the dragged position.
- Releasing Alt **at drag end** keeps the duplicate. The whole drag registers as a single undo step.
- Works with frames with children, components (master → instance), and across reparent boundaries.

### Vector Node Copy/Paste

While in vector edit mode (entered via Enter, double-click, or the pen tool):

- **Cmd+C** copies the selected nodes plus edges where **both endpoints** are selected.
- **Cmd+X** copies and deletes the same set.
- **Cmd+V** pastes:
  - In vector edit mode: pastes nodes into the current element with new IDs and selects them.
  - Otherwise: creates a new vector element from the pasted nodes and enters vector edit mode.

### Delete

| Context | Behavior |
|---------|----------|
| Element(s) selected | Removes the elements and their descendants. Z-order is captured for undo restore. Hug-frame parents are snapshotted so they undo cleanly. Component masters detach all their instances first. |
| Vector edit mode, nodes selected | Deletes nodes and their connected edges. 2-edge nodes reconnect their neighbors automatically. Path drops below 2 nodes → element is removed. |
| Vector edit mode, only handles selected | Handles set to null (collapse to straight segment). |
| Element with focused fill / stroke / region | Removes only the focused part (topmost when multiple selected). Repeat Delete to peel them off one by one. |
| Gradient stop focused | Removes the gradient stop. |
| Crop mode active on the deleted element | Crop mode exits first. |

All deletes are undoable. Deleting from a hug-sized parent triggers parent resize; the snapshot keeps undo correct. Deleting from auto layout reflows siblings.

## Undo & Redo

| Action | Shortcut |
|--------|----------|
| Undo | Cmd+Z |
| Redo | Cmd+Shift+Z |

### Per-Canvas Undo History

Each canvas has its own independent undo/redo history (per `UndoManagerRouter`). Switching canvases does not affect undo stacks: when you return to a canvas, its full history is still available. Canvas switching itself is **not** undoable.

AI operations triggered via MCP get their own per-session undo stack so they don't pollute the user's manual undo history.

**Undo does not persist across sessions.** Closing and reopening the app clears all undo history. For persistent history, use Git version control (see [CANVASES.md](./CANVASES.md#collaboration--sharing)).

### File Explorer Undo

When the **canvas explorer** is focused (left toolbar, **Cmd+Shift+E**), undo/redo applies to **file and folder operations** instead of canvas elements:

- Rename a canvas or folder
- Create a canvas or folder
- Delete a canvas or folder
- Reorder canvases / folders

This is a separate undo stack from each canvas. Cmd+Z with the explorer focused will not touch element edits, and vice versa.

### What Is Undoable

All element operations are undoable:

- Create, delete, duplicate, paste
- Move, resize, rotate, flip, scale, skew
- Color, fill, stroke, opacity changes
- Text edits and typography (font, size, line height, weight, italic, underline, alignment)
- Alignment and distribution
- Group, ungroup, reparent (both interactive drag and explorer drag)
- Auto layout changes
- Z-order changes
- Crop operations (image pan, resize, rotate within element)
- Boolean and mask operations (including type changes)
- Flatten and outline text
- Component create / detach / instance / reset / push overrides
- Effects (shadow / glow / blur add / remove / update)
- Vector node, edge, and handle edits
- Add / remove / swap fill or stroke
- Per-canvas: arrow-key nudges debounce into a single undo entry after 1 second of inactivity
