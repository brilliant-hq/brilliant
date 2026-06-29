---
name: "knowledge-editing"
description: "Selection, movement, resize, rotation, alignment, distribution, z-order, grouping, boolean, mask, flatten, and clipboard operations in Brilliant, performed by hand."
---

# Editing

How a user manipulates elements directly on the canvas: selecting, moving, resizing, rotating, aligning, grouping, and so on. All actions below are performed by hand (mouse, handles, keyboard shortcuts, or the right-toolbar property fields). Shortcuts shown are macOS defaults; on Windows, Cmd maps to Ctrl.

## Selection

### Click Selection

| Action | Result |
|--------|--------|
| Click on an element | Selects only that element |
| Click on empty space | Deselects everything |
| Click on a frame label | Selects the frame |

**Note:** A top-level frame **with children** has its body and strokes non-clickable; click its label to select it. Empty top-level frames and all nested frames are fully clickable on the body.

**Frame selection rule (Figma-style mutual exclusion):** A frame and its descendants cannot be selected at the same time. Selecting a frame deselects all descendants; selecting any element deselects all of its ancestors. Marquee-selecting both a frame and its children keeps only the frame.

### Multi-Selection

| Action | Result |
|--------|--------|
| Shift+Click | Toggle element in/out of selection (extends or removes) |
| Cmd+A | Select all top-level elements (in vector edit mode: select all nodes and handles) |

### Drag-Select (Marquee)

Click and drag on empty space to create a selection rectangle. Top-level frames with children must be fully contained; nested frames, empty top-level frames, and non-frame elements only need to intersect (or for filled rectangles/frames, the rectangle must overlap the fill). Hold **Shift** to add to the existing selection. Hold **Cmd** to select through fills (deep-select: ignores element fills when computing hits).

### Navigating the Hierarchy

| Action | Result |
|--------|--------|
| Enter | Context-sensitive: drills into frames, enters text editing for text elements, enters crop mode for cropped images, enters vector edit mode for shapes, narrows a multi-selection to the innermost element, or finalizes the active edit mode if one is open |
| Shift+Enter | Select parent frame |
| Escape | Cancel the current action / exit the current edit mode (frame label, crop, vector edit, vector handle selection, boolean edit, mask edit, pen tool, AI chat). With nothing else active, clears selection. |
| Tab | Select previous sibling |
| Shift+Tab | Select next sibling |

### Implicit Selection (Full Selection)

When a frame is selected, its descendants are **implicitly selected** for typography operations only (font family, font size, line height, bold/italic/underline, text alignment). This lets you restyle text on every text node inside a frame by selecting the frame alone. Structural changes (add/remove fill or stroke) and geometric operations still target only the explicitly selected elements.

The right toolbar shows a **Selection Colors** section when implicit selection adds extra elements; clicking a color there bulk-changes every element using that color across the full selection hierarchy.

### Per-Parent Selection

When elements are selected across multiple frames, separate selection rectangles appear, one per parent. Operations execute independently within each parent's coordinate space.

### Visual Feedback

| Visual | Meaning |
|--------|---------|
| Blue outline | Selected |
| Thin blue outline on hover | Hovered |
| Resize handles (squares at corners and edges) | Can be resized |
| Rotation cursor (just outside corners) | Hover outside a corner handle to rotate |
| Dashed lines with pixel labels (Alt+hover) | Distance measurements (see [canvas.md](./canvas.md#measurement-overlays)) |

## Movement

### Drag to Move

Select and drag. Snap guides appear automatically. Hold **Shift** while dragging to constrain movement to the X or Y axis (whichever has the larger delta from the drag-start position).

**Reparenting during drag:** Leaving a frame reparents to root immediately. Entering a frame is **deferred until drop**: the target frame highlights while you hover, and reparenting happens on release. Holding **Cmd** during the drag drops into the parent of the deepest matching frame (useful for nested layouts).

### Nudge with Arrow Keys

| Action | Shortcut |
|--------|----------|
| Move 1px | Arrow keys |
| Move 10px | Shift+Arrow keys |

Rapid arrow-key presses are combined into a single undo entry (1 second of inactivity finalizes it). When **all** selected elements share the same auto layout parent, arrow keys **reorder** the children within that frame along the layout axis instead of nudging spatially. Mixed selections (some in auto layout, some not, or in different parents) fall back to spatial nudge.

### Duplicate While Moving

Hold **Alt/Option** while dragging to create a duplicate at the cursor while the original returns to its starting position. Releasing Alt mid-drag cancels the duplication (the duplicate is removed and the original takes the dragged position). The full hierarchy duplicates (frames with all children).

### Auto-Reparenting

Dragging elements over a frame or auto layout frame automatically reparents them on drop. The following are **not** reparent targets, so dragging over them won't reparent into them:

- Groups
- Boolean parents
- Masks
- Component instances (and anything nested inside a component instance)

Children of a group, boolean parent, or mask cannot be dragged out: they stay clipped/grouped. Children of an auto layout frame can be temporarily moved out of the layout flow by holding **Space** during the drag (prevents auto-layout snap). Self-containment is also blocked: an element cannot be dropped into its own descendant.

### Snap Guides

While dragging, snap guides show alignment, spacing (gap matching), equidistant centering, and (during create/resize) sizing. Snapping operates within the **primary parent's** coordinate space; elements never snap across frame boundaries. The master snap toggle is in the right toolbar and persists per session.

### Pixel Grid Snap

Default ON. Rounds positions to whole-pixel boundaries on axes where element-snap did not win. Applies to drag move, arrow-key nudge, paste, corner resize, and creation. Edge resize and rotation are exempt. Toggle with **Shift+Cmd+'** (apostrophe). This is independent from the visual pixel-grid overlay toggled with **Cmd+'**.

### Precise Positioning

The right toolbar shows X and Y fields. Type exact values, drag on the field to adjust, or use math expressions and natural language (e.g., `+ 50`, `half`, `round 8`). See [ui.md](./ui.md#interactive-fields) for the full list.

## Resizing

### Resize Handles

8 handles appear when an element is selected: 4 corner (resize both axes) and 4 edge (resize one axis). For a single rotated element, handles align to the element's oriented bounding box. Multi-element selections always show axis-aligned handles, one rectangle per parent.

### Resize Modifiers

| Modifier | Effect |
|----------|--------|
| **Shift** | Maintain aspect ratio |
| **Alt/Option** | Symmetric resize from center (both sides/corners move equally from the geometric center) |
| **Ctrl** | Scale mode: proportional resize that also scales font sizes, stroke thicknesses, corner radii, effects, and descendants |
| **Cmd** | Crop-compensate image/shader fills (visible image content stays in place rather than stretching) |

Dragging past an anchor flips the element; the resize continues smoothly past zero. Lines and 2-point arrows have a dedicated endpoint resize: only the two diagonal corner handles are active (start and end points). Shift on a line constrains the endpoint to 45-degree angles.

**Scale mode toggle (K):** Instead of holding Ctrl during every resize, press **K** to enable persistent scale mode. The Move tool stays active but every resize scales content proportionally and the cursor switches to the rescale icon. Press K again, or switch tools, to exit.

### Resize in Auto Layout

Resizing a child in auto layout converts that axis to **fixed** sizing with the new dimension. The parent recalculates layout immediately. Hug/fill ancestors propagate the size change up the tree.

### Precise Dimensions

The right toolbar shows W and H fields with an aspect-ratio lock icon. All numeric fields support math expressions and natural language (e.g., `* 2/3`, `double`, `50%`, `round 8`). See [ui.md](./ui.md#interactive-fields).

## Rotation

### Rotation Handles

Rotation handles appear just outside the corner resize handles. Drag to rotate around the selection center. Hold **Shift** to snap to 15-degree increments.

### Keyboard Rotation

Keyboard rotation uses a clock-position metaphor. Each level sets an absolute rotation in 30-degree increments: level 0 is 0 degrees (12 o'clock); levels 1-9 are N times 30 degrees.

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

You can also type an exact angle in the rotation field in the right toolbar.

## Flipping

| Action | Shortcut | What it does |
|--------|----------|------|
| Flip horizontally | Shift+H | Mirrors across the vertical axis |
| Flip vertically | Shift+V | Mirrors across the horizontal axis |

Flipping is a per-element property toggle, not a geometry rebuild. Children of flipped frames render flipped via the rendering transform.

## Hide / Show

| Action | Shortcut | What it does |
|--------|----------|------|
| Hide / Show | Cmd+Shift+H | Toggles visibility of the selected elements |

Hidden elements disappear from the canvas but stay in the document. Each layer in the Layers explorer (left toolbar) also has an eye toggle you can click to hide or show that element.

## Scaling

Scaling uniformly resizes the selection and scales its content (font sizes, stroke thickness, corner radii, effects, descendants). This differs from setting W/H in the right toolbar, which resizes the bounding box on one axis without scaling content.

| Action | Shortcut | Amount |
|--------|----------|--------|
| Scale to height N × 36 px | Alt+1 through Alt+9 | level × 36 px (uniform, keeps aspect ratio) |
| Scale to height 18 px | Alt+0 | 18 px (uniform) |
| Scale up | Alt+Shift+= | +1 step (height-based) |
| Scale down | Alt+- | -1 step |

To scale to a precise size by hand, enable scale mode (**K** or hold **Ctrl**) and drag a corner handle, which scales all content proportionally.

## Skewing

Skew shears elements into parallelograms (useful for diagonal hero sections, isometric layouts, and dynamic visual effects). There is no dedicated skew handle on the canvas; skew is set via the skew X / skew Y fields in the right toolbar's transform section (in degrees: positive skew X leans right, positive skew Y leans down). Typical values: -8 to -12 for modern diagonal sections, 5 to 8 for subtle card tilts, 15 to 20 for bold editorial, ~30 for isometric projection.

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

These commands are also available as buttons in the right toolbar's alignment section.

## Distribution

| Action | Shortcut |
|--------|----------|
| Distribute horizontally | Ctrl+Alt+H |
| Distribute vertically | Ctrl+Alt+V |

Requires 3+ elements per parent. Sorts elements by leading edge, keeps the first and last as anchors, then sets equal gaps between the middle elements. If there is not enough space (the gap would be negative), the operation does nothing. Operates per-parent.

## Z-Order

| Action | Shortcut |
|--------|----------|
| Bring to front | ] |
| Send to back | [ |
| Bring forward | Cmd+] |
| Send backward | Cmd+[ |

Z-order operates within each parent frame independently. The Layers explorer (left toolbar) shows the visual stacking order, and you can drag layers there to reorder them.

## Boolean Operations

| Action | Shortcut |
|--------|----------|
| Boolean Union | Alt+Shift+U |
| Boolean Subtract | Alt+Shift+S |
| Boolean Intersect | Alt+Shift+I |
| Boolean Exclude | Alt+Shift+E |

Select 2+ elements and apply a boolean operation. The result is a boolean parent that combines the children into one shape. Children remain editable: double-click the boolean parent to enter boolean edit mode and modify the individual shapes; **Escape** exits.

If a single boolean **or** mask parent is already selected when you run a boolean command, its type switches (e.g., union → subtract, mask → intersect) instead of wrapping it in another parent.

To bake a boolean parent into a single uneditable vector, use **Flatten** (Cmd+Enter).

## Grouping and Framing

| Action | Shortcut | What it does |
|--------|----------|------|
| Group | Cmd+G | Wraps the selection in a group (hug sizing on both axes). Groups are structural only: not a reparent target, children cannot be dragged out. If the selection spans multiple parents, one group is created per parent. |
| Frame Selection | Cmd+F | Wraps the selection in a frame container (hug-sized initially, a valid reparent target). Sizing can be switched to fixed/fill afterward in the right toolbar. |
| Ungroup | Cmd+Shift+G | Removes the wrapping group/frame and moves children up to the parent |
| Add Auto Layout | Shift+A | Wraps the selection in an auto-layout frame, inferring direction and spacing from existing positions |

## Mask

| Action | Shortcut |
|--------|----------|
| Mask | Ctrl+Cmd+M |

Select 2+ elements. The topmost element becomes the clip shape, and the elements below are clipped to it. The result is a mask parent. Applying a boolean command to a mask parent switches its type to that boolean (e.g., mask → intersect); applying Mask to a boolean parent switches it back to a mask. Children of a mask cannot be dragged out: they stay clipped.

Mask parents support three mask types, selectable in the right toolbar: vector (default geometric clip), alpha, and luminance.

## Flatten

| Action | Shortcut |
|--------|----------|
| Flatten | Cmd+Enter |

Converts the selection into a single vector element. Behavior depends on what is selected:

| Input | Result |
|-------|--------|
| Single primitive (rectangle, circle, line) | Convert to vector (lossless) |
| Single vector | No-op |
| Single text element | Outline to a single compound vector with per-character regions |
| Boolean union parent | Concatenate children's vector paths (lossless, per-child fills preserved as regions) |
| Group / frame | Concatenate children's vector paths (lossless, per-child fills) |
| Boolean subtract / intersect / exclude, or mask parent | Combine paths into the final shape only (fills not preserved per-child) |
| Multiple selected elements | Concatenate all as vector paths into one element |
| Text mixed with non-text in the selection | Texts auto-outline to vectors first, then everything is concatenated |

Flattening that involves **text outlining** requires native glyph extraction (CoreText on macOS, DirectWrite on Windows), so it is available on macOS and Windows but **not on Linux**. Flattening non-text selections works on all platforms.

## Outline Text

| Action | Shortcut |
|--------|----------|
| Outline Text | Ctrl+Cmd+O |
| Flatten Text | no default shortcut (command palette or context menu) |

Both commands convert text into vector paths and are available on macOS and Windows (native glyph extraction), not on Linux. On Windows, Outline Text has no default keyboard shortcut because its chord collides with another command; reach it via the command palette, menu, or context menu.

| Command | Output |
|---------|--------|
| Outline Text | A group of per-character vector elements (each glyph is a separate vector inside a group) |
| Flatten Text | A single compound vector element with per-character regions (the same operation as Flatten applied to a text element) |

## Rename Layer

| Action | Shortcut |
|--------|----------|
| Rename Layer | Cmd+R |

Renames the selected element's layer name. You can also double-click a layer name in the Layers explorer.

## Clipboard

| Action | Shortcut |
|--------|----------|
| Copy | Cmd+C |
| Cut | Cmd+X |
| Paste | Cmd+V |
| Duplicate | Cmd+D |
| Delete | Backspace (or Delete) |
| Clear canvas | C (the C key, when the canvas has focus) |

### Copy

Copies the selected elements to an **internal clipboard** (in-memory) and writes a PNG render of the selection to the **system clipboard** so it can be pasted into other apps. Frame children are captured at copy time so cross-canvas paste works even after switching canvases.

**What gets copied:**
- The selected elements and their full hierarchy (frames include all children and nested frames)
- Styling (fills, strokes, corner radius, opacity, layout behavior, effects, component data)
- When the selection is exactly one image element with no strokes, zero corner radius, full opacity, and no active crop, the raw image bytes are written to the system clipboard instead of a re-rendered PNG (preserves original quality)

### Cut

Same as Copy plus removes the selected elements from the canvas. In vector edit mode, Cut copies and deletes the selected vector nodes only (not the whole element). Undoable.

### Paste

If the system clipboard is unchanged since the last copy, paste uses the faster internal clipboard; if it changed (you copied something in another app), paste reads from the system clipboard.

**Internal paste:**

- **At cursor (default):** Recreates the copied elements at the cursor position with fresh IDs, preserving the full hierarchy. Component masters become instances linked to the master; existing instances keep their master link.
- **Into selected frames:** If every currently selected element is a frame, pasting places an independent copy inside **each** selected frame, centered. Circular references are prevented (you can't paste a frame into itself or its descendants); failed validation falls back to paste-at-cursor.

**External paste** (when the system clipboard changed):

| Source | Behavior |
|--------|----------|
| Image (PNG, JPEG, etc.) | Creates a rectangle element with the image as a fill |
| SVG markup | Imports as native vector elements (auto-wraps fragments) |
| Figma data | Imports Figma-formatted element data |
| HTML | Imports HTML with inline CSS (e.g., from the Brilliant Capture browser extension) |
| Plain text | Creates a text element |

Brilliant's native design data and blueprint text also paste back in as elements with remapped IDs.

### Duplicate

**Cmd+D** creates a copy of the selection:

- Top-level elements are placed to the right of the original, scanning rightward with a 40 px gap to find the first non-overlapping slot.
- Children inside frames are duplicated at the same relative position inside the same parent.
- Frame children and nested frames are recursively duplicated.
- Component masters are duplicated as proper instances (not raw copies); component instances preserve their link to the master.
- Duplicates are automatically selected.

**Alt/Option+drag duplicates while moving:**

- The original returns to its starting position; the duplicate moves with the cursor.
- Releasing Alt **mid-drag** removes the duplicate and the original takes the dragged position.
- Releasing Alt **at drag end** keeps the duplicate. The whole drag registers as a single undo step.
- Works with frames-with-children, components (master → instance), and across reparent boundaries.

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
| Element(s) selected | Removes the elements and their descendants. Component masters detach all their instances first. |
| Vector edit mode, nodes selected | Deletes nodes and their connected edges. Nodes with two edges reconnect their neighbors automatically. If the path drops below 2 nodes, the element is removed. |
| Vector edit mode, only handles selected | Handles set to null (collapse to a straight segment). |
| Element with a focused fill / stroke / region | Removes only the focused part (topmost when several are selected). Repeat Delete to peel them off one by one. |
| Gradient stop focused | Removes the gradient stop. |
| Crop mode active on the deleted element | Crop mode exits first. |

All deletes are undoable. Deleting from a hug-sized parent triggers a parent resize; deleting from auto layout reflows siblings.

## Undo & Redo

| Action | Shortcut |
|--------|----------|
| Undo | Cmd+Z |
| Redo | Cmd+Shift+Z |

### Per-Canvas Undo History

Each canvas has its own independent undo/redo history. Switching canvases does not affect undo stacks: when you return to a canvas, its full history is still available. Canvas switching itself is **not** undoable. AI operations get their own separate undo stack so they don't pollute your manual undo history.

**Undo does not persist across sessions.** Closing and reopening the app clears all undo history. For persistent history, use Git version control (see [canvases.md](./canvases.md#version-control-with-git)).

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

Rapid arrow-key nudges are combined into a single undo entry after 1 second of inactivity.
