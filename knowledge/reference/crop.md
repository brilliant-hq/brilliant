---
name: "knowledge-crop"
description: "Image crop mode in Brilliant: scale modes, interactive crop editing, image strokes, container compensation."
---

# Image Crop Mode

Brilliant supports four image scale modes and an interactive crop editor for precise positioning of images within elements. Crop applies to both **image fills** and **image strokes**.

## Image Scale Modes

Every image fill or image stroke has a scale mode:

| Mode | Behavior | Interactive editing |
|------|----------|---------------------|
| **Fill** (default) | Image covers element, excess clipped. Aspect preserved | No |
| **Fit** | Image fits inside element, letterboxed/pillarboxed. Aspect preserved | No |
| **Crop** | Image positioned freely. Free pan/resize/rotate | Yes |
| **Repeat** | Image tiles at natural pixel size relative to element. NO crop compensation | No |

Set the mode in the right toolbar's **image fill** or **image stroke** section via the **Scale Mode** dropdown (image's expanded config). Switching to a non-Crop mode automatically clears any stored crop data.

## Entering Crop Mode

| Method | Behavior |
|--------|----------|
| **Double-click** an element with an image fill | Enters crop on the topmost image fill (or the focused fill, if one is currently focused in the right toolbar). For childless parent frames with image fills, double-click also enters crop. Requires the Move tool (V) active. |
| **Enter** key on a selected non-parent element with an image fill | Enters crop on the focused fill, or the topmost image fill. **Does NOT enter crop on parent frames** (Enter never enters crop on frames). For childless image-fill frames, use double-click instead. |
| **Scale Mode dropdown -> Crop** | Auto-enters crop on that fill or stroke when exactly one element is selected |

When entering crop mode:
- The element is selected
- If the current scale mode is not already Crop, it is auto-converted to Crop. The crop is initialized to cover the element (visual stays the same)
- The crop overlay appears (ghost image + container brackets at corners and edge midpoints)
- An undo entry is registered. Undoing it reverts the element to its pre-entry state and exits crop mode

**Element type rules (double-click):**
- Rectangle / circle with an image fill (or image stroke) enters crop
- **Childless parent frame** with an image fill enters crop (used as a clipped image container)
- Text element enters text editing mode (NOT crop) even if it has an image fill
- Vector enters vector editing mode (NOT crop) even if it has an image fill
- **Frame with children** drills into its children (NOT crop). Only **childless** frames with an image fill enter crop

**Element type rules (Enter key):**
- Same as double-click EXCEPT parent frames are skipped entirely (no crop entry, no children drill-down)

## Exiting Crop Mode

| Action | Result |
|--------|--------|
| **Enter** | Exit (each crop operation registered its own undo, so individual steps can still be undone afterward) |
| **Escape** | Exit (only while in crop mode and the command palette is closed) |
| **Click outside the element** (mouseup, no drag) | Exit |
| **Double-click anywhere** | Exit |
| **Change scale mode** to Fill / Fit / Repeat | Exit (then mode change applied) |
| Canvas switch, repo switch, studio/overlay switch | Auto-exit (state cleared) |
| Delete the cropped element | Auto-exit before deletion |
| Undo/redo that invalidates crop state (element deleted, fill removed, scale mode changed) | Auto-exit |

## Crop Interactions

Crop mode handle hit-testing and image pan require the **Move tool (V)** to be active. With the pen, hand, or other tools selected, crop handles are bypassed entirely.

Crop mode provides two layers of handles: **container handles** (visible blue L-brackets at the corners + short edge mid-line marks) and **image handles** (invisible hit zones overlaid on the image area).

### Pan Image

Drag anywhere on the image area to reposition the image within the container. You can move the image freely; it is only prevented from leaving the visible area entirely.

### Resize Image

Drag any of the 8 image resize zones (4 corners + 4 full-edge zones) to scale the image. The whole edge is interactive, not just the midpoint.

| Modifier | Behavior |
|----------|----------|
| None | Free resize (aspect unlocked) |
| **Shift** or **Ctrl** | Proportional resize (aspect locked) |

Crop image resize is not affected by the lock-aspect-ratio setting; hold Shift (or Ctrl) to keep the image aspect ratio.

### Rotate Image

Drag any of the 4 image rotation handles (outside image corners) to rotate the image within the container. Image rotation works correctly even on non-square elements (no skew).

### Resize Container

Drag the visible **blue L-brackets** at the element's corners or the short **edge mid-lines** to resize the element. The whole edge is interactive, not just the midpoint marks. The image position is automatically compensated to stay fixed in world space (see Compensation below).

### Rotate Container

Use the regular rotation handles outside the element to rotate it. Crop data is automatically compensated.

### Handle Hit-Test Priority

When zones overlap, the priority order is:

1. Container resize handles
2. Container rotation handles
3. Image resize handles
4. Image rotation handles
5. Image pan (drag on image area)

## Visual Feedback

| Item | Description |
|------|-------------|
| **Ghost image** | Full image rendered at 30% opacity (shows the un-cropped area) |
| **Blue L-brackets** | At element corners, marking the container boundary |
| **Blue edge mid-lines** | Short lines at edge midpoints (visual hint; full edge is interactive) |

Bracket arms and edge marks keep a constant on-screen size at any zoom. Image-resize, image-rotation, and container-rotation handles are **invisible hit-test zones** with no rendered marker.

For nested elements (image inside a frame), the overlay follows the parent's transform so handles render at the correct world-space positions.

## Crop Compensation

Crop compensation keeps the image's world-space position fixed when the element changes geometry, instead of stretching the image with the container.

| Trigger | What happens | Modifier needed |
|---------|--------------|-----------------|
| Resize / rotate the **element (container)** while in crop mode | The image being cropped stays fixed in world space automatically | (none: automatic) |
| Resize an element **outside crop mode** | Every image fill stays fixed in world space | **Cmd held** (Ctrl on Windows/Linux) |
| Rotate an element **outside crop mode** | NO compensation (the image rotates with the element) | n/a |
| Repeat scale mode | NEVER compensated; tiling is resolution-based | n/a |

**Outside-crop-mode behavior with Cmd held (Ctrl on Windows/Linux):**
- Works for **Fill, Fit, and Crop** modes (not Repeat)
- For Fill / Fit images, the mode is auto-converted to Crop with equivalent framing before compensation
- Only **image fills** are compensated outside crop mode; image strokes are not

Without that modifier held, resizing outside crop mode scales the image with the container (the Figma default).

> Note: the command modifier is **Cmd on macOS, Ctrl on Windows/Linux**. On Windows/Linux this is the same key used for proportional image resize (Shift/Ctrl), so resizing the element with Ctrl held compensates the image fill rather than resizing the image inside crop mode.

## Supported Elements

- **Rectangle, circle**: image fills enter crop on double-click or Enter. Image strokes enter crop via the stroke section's Scale Mode dropdown (double-click with no focused fill picks the topmost image **fill** only)
- **Vector**: image fills / strokes render, but vectors **never** enter crop on Enter / double-click (they always go to vector editing). Enter crop via the Scale Mode dropdown
- **Text**: image fills render, but Enter / double-click always goes to text editing. Enter crop via the Scale Mode dropdown
- **Childless parent frames** with image fills: double-click enters crop (used as clipped image containers). Enter does NOT enter crop on frames
- **Parent frames with children**: drill into children on Enter / double-click; cannot enter crop directly

## Undo

Crop mode registers granular undo entries:

- Entering crop mode registers one undo (reverts to the pre-entry state AND exits crop mode). Redo re-applies the post-entry state but does NOT re-enter crop mode
- Each pan / image resize / image rotate registers its own undo ("Pan Crop Image", "Resize Crop Image", "Rotate Crop Image")
- Container resize / rotate during crop mode use the regular resize/rotate undo, so each becomes its own undo step

Undo (`Cmd+Z`, or `Ctrl+Z` on Windows/Linux) undoes one operation at a time. To revert all in-progress crop edits, undo until the "Enter Crop Mode" entry is consumed (which exits crop mode and restores the element).

## Tips

- Start with **Fill** mode for cover-style imagery; switch to **Crop** only for fine positioning
- Use **Fit** for logos and icons that must be fully visible
- Hold **Shift** (or Ctrl) while dragging an image resize handle to keep aspect ratio
- **Cmd+resize** (Ctrl+resize on Windows/Linux) outside crop mode preserves the image's world-space position (auto-converts fill/fit to crop with equivalent crop data)
- Image strokes accept the same scale modes and crop interactions as image fills

---

## Related

- [styling.md](./styling.md): Image fills, strokes, and other styling
- [editing.md](./editing.md): Selection and navigation
- [tools.md](./tools.md): Drawing tools
- [frames.md](./frames.md): Parents and clip-content
