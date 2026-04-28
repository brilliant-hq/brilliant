---
name: "knowledge-crop"
description: "Image crop mode in Brilliant: scale modes, interactive crop editing, image strokes, container compensation."
---

# Image Crop Mode

Brilliant supports four image scale modes and an interactive crop editor for precise positioning of images within elements. Crop applies to both **image fills** and **image strokes**.

## Image Scale Modes

Every image fill or image stroke has a scale mode (`ImageScaleMode`):

| Mode | Behavior | Interactive editing |
|------|----------|---------------------|
| **Fill** (default) | Image covers element, excess clipped. Aspect preserved | No |
| **Fit** | Image fits inside element, letterboxed/pillarboxed. Aspect preserved | No |
| **Crop** | Image positioned by `ImageCropData` (4 corners in unit square). Free pan/resize/rotate | Yes |
| **Repeat** | Image tiles at natural pixel size relative to element. NO crop compensation | No |

Set the mode in the right toolbar's **image fill** or **image stroke** section via the **Scale Mode** dropdown (image's expanded config). Switching to a non-Crop mode automatically clears any stored crop data.

## Entering Crop Mode

| Method | Behavior |
|--------|----------|
| **Double-click** an element with an image fill | Enters crop on the topmost image fill (or the focused fill if one is currently focused in the right toolbar). For childless parent frames with image fills, double-click also enters crop |
| **Enter** key on a selected element with an image fill | Same as double-click; uses the focused fill if any. Routes through `EnterCommand` |
| **Scale Mode dropdown** → Crop | Enters crop on that fill or stroke |

When entering crop mode:
- The element is selected
- If the current scale mode is not already Crop, it is auto-converted to Crop, and crop data is initialized to **cover-mode corners** computed from element / image aspect ratios (so the visual stays the same)
- The crop overlay appears (ghost image + container brackets)
- An undo entry is registered. When undone, the element reverts to its pre-entry state

**Element type rules:**
- Rectangle / circle / **childless parent frame** with an image fill (or image stroke) → enters crop
- Text element → enters text editing mode (NOT crop) even if it has an image fill
- Vector → enters vector editing mode (NOT crop) even if it has an image fill
- **Frame with children** → drills into children (NOT crop). Only **childless** frames with an image fill enter crop

## Exiting Crop Mode

| Action | Result |
|--------|--------|
| **Enter** | Exit (each operation registered its own undo, so individual steps can still be undone afterward) |
| **Escape** | Exit |
| **Click outside** | Exit |
| **Double-click anywhere** | Exit |
| **Change scale mode** to Fill / Fit / Repeat | Exit |
| Canvas switch, repo switch, mode (studio↔overlay) switch | Auto-exit (state cleared) |
| Delete the cropped element | Auto-exit before deletion |

## Crop Interactions

Crop mode interactions require the **Move tool (V)**. With the pen or other tools active, crop handles and pan do not respond.

Crop mode provides two layers of handles: **container handles** (visible blue L-brackets and edge mid-lines) and **image handles** (invisible hit zones).

### Pan Image

Drag anywhere on the image area to reposition the image within the container. The image is permitted to move freely; clamping prevents only the case where the image leaves the viewport entirely (permissive overlap check on the unit-square AABB).

### Resize Image

Drag any of the 8 image resize zones (4 corners + 4 full-edge zones) to scale the image. The whole edge is interactive, not just the midpoint.

| Modifier | Behavior |
|----------|----------|
| None | Free resize (aspect unlocked) |
| **Shift** or **Ctrl** | Proportional resize (aspect locked) |

Crop image resize ignores the element's `constrainProportions` flag.

### Rotate Image

Drag any of the 4 image rotation handles (outside image corners) to rotate the image within the container. Implementation rotates corners in world space and maps back to the unit square: naturally isotropic, so non-square elements rotate correctly without skew.

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

Bracket arms scale inversely with zoom (`14.0 / zoomScale`), edge lines `12.0 / zoomScale`, stroke width `5.0 / zoomScale`. Image-resize, image-rotation, and container-rotation handles are **invisible hit-test zones** with no rendering.

For nested elements (image inside a frame), the overlay applies the parent's world transform so handles render at correct world-space positions.

## Crop Compensation

Crop compensation adjusts crop corners so the image's world-space position stays fixed when the element changes geometry. It uses point-based remapping: each crop corner goes from old element unit-square → parent-local → new element unit-square.

| Trigger | What happens | Modifier needed |
|---------|--------------|-----------------|
| Resize / rotate **container** while in crop mode | Crop data of the actively edited fill/stroke compensates automatically | (none: automatic) |
| Resize element **outside crop mode** | Crop data of all image fills compensates so each image stays fixed in world space | **Cmd held** |
| Rotate element **outside crop mode** | NO compensation (image rotates with the element) | n/a |
| Repeat scale mode | NEVER compensated; tiling is resolution-based | n/a |

**Outside-crop-mode behavior with Cmd held:**
- Works for **fill, fit, and crop** modes (not repeat)
- For fill / fit, the image is auto-converted to crop mode with equivalent corners (`coverMode` for fill, `fitMode` for fit) before compensation
- Outside crop mode, only **image fills** are compensated; image strokes are not
- Inside crop mode, the actively edited fill or stroke (per `_cropEditingIsStroke`) is compensated; other crop fills on the same element are not

Without Cmd held, resizing outside crop mode scales the image with the container (Figma default).

## Supported Elements

- Rectangle, circle, vector: image fills supported. Vectors **never** enter crop on Enter / double-click (they go to vector editing). Image strokes supported on all of them
- Text: image fills supported, but Enter/double-click goes to text editing
- Childless parent frames: image fills supported; double-click and Enter enter crop. Used as clipped image containers
- Parent frames with children: drill into children on Enter / double-click; cannot enter crop directly

## Undo

Crop mode operations register granular undo entries:

- Entering crop mode registers one undo (reverts to pre-entry state)
- Each pan / image resize / image rotate registers its own undo
- Container resize / rotate during crop mode use the regular resize/rotate undo system (not crop's). After such operations, `updateCropOriginalElement()` advances the crop original so subsequent crop edits see the new baseline

`Cmd+Z` undoes one operation at a time. To revert all in-progress crop edits, undo until the "Enter Crop Mode" entry is consumed (which exits crop mode and restores the element).

## Tips

- Start with **Fill** mode for cover-style imagery; switch to **Crop** only for fine positioning
- Use **Fit** for logos and icons that must be fully visible
- Hold **Shift** (or Ctrl) while dragging an image resize handle to keep aspect ratio
- **Cmd+resize** outside crop mode preserves the image's world-space position (auto-converts fill/fit to crop with equivalent crop data)
- Image strokes accept the same scale modes and crop interactions as image fills

---

## Related

- [styling.md](./styling.md): Image fills, strokes, and other styling
- [editing.md](./editing.md): Selection and navigation
- [tools.md](./tools.md): Drawing tools
- [frames.md](./frames.md): Parents and clip-content
