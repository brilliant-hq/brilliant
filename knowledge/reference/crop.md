---
name: "knowledge-crop"
description: "Image crop mode in Brilliant: scale modes, interactive editing, visual feedback, and crop compensation."
---

# Image Crop Mode

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Brilliant supports four image scale modes and an interactive crop editor for precise image positioning within elements.

## Image Scale Modes

Every image fill or image stroke has a scale mode that controls how the image fits within the element bounds:

| Mode | Behavior | Interactive Editing? |
|------|----------|---------------------|
| **Fill** (default) | Image covers the entire element, excess clipped. Aspect ratio preserved. | No |
| **Fit** | Image fits entirely within the element, letterboxed if needed. Aspect ratio preserved. | No |
| **Crop** | Image positioned by custom crop data. Full interactive control. | Yes |
| **Repeat** | Image tiles at natural pixel size relative to the element. No crop compensation during resize. | No |

Change the scale mode in the right toolbar under the image fill or stroke section (dropdown).

## Entering Crop Mode

| Method | How |
|--------|-----|
| **Double-click** | Double-click an element with an image fill |
| **Enter key** | Select an image element and press **Enter** |
| **Scale mode dropdown** | Change the scale mode to **Crop** in the right toolbar (works for both image fills and image strokes) |

When entering crop mode:
- The element is automatically selected
- If the current scale mode is not already Crop, it is automatically converted to Crop with equivalent positioning
- The crop editor overlay appears
- If a specific image fill is focused in the selection (via the right toolbar), crop mode targets that fill

## Exiting Crop Mode

| Action | Result |
|--------|--------|
| **Enter** | Save crop and exit |
| **Escape** | Save crop and exit |
| **Click outside** | Save crop and exit |
| **Double-click anywhere** | Save crop and exit |
| **Change scale mode** | Selecting any non-Crop scale mode (Fill, Fit, or Repeat) exits crop mode |

## Crop Interactions

Crop mode interactions require the **Move tool** (V) to be active. If another tool (e.g., Pen) is selected, crop handles and pan will not respond.

Crop mode provides two layers of handles: **container handles** (blue L-brackets for the element boundary) and **image handles** (invisible hit zones for the image within).

### Pan Image

Click and drag anywhere on the image area to reposition the image within the container. The image cannot be dragged entirely outside the container bounds.

### Resize Image

Drag any of the 8 image resize zones (4 corners + 4 edges) to scale the image. The entire edge is interactive, not just the midpoint.

| Modifier | Effect |
|----------|--------|
| No modifier | Free resize (aspect ratio unlocked) |
| **Shift** or **Ctrl** | Proportional resize (locks aspect ratio) |

### Rotate Image

Drag any of the 4 image rotation handles (outside the image corners) to rotate the image within the container.

### Resize Container

Drag the blue L-bracket handles at the element's corners or anywhere along the edges to resize the element boundary. The visible midpoint marks are visual indicators, but the full edge is interactive. The image position adjusts automatically (see Crop Compensation below).

### Rotate Container

Use the rotation handles outside the element to rotate the entire element. The crop data compensates automatically.

### Handle Priority

When handles overlap, the hit-test priority is:
1. Container resize handles
2. Container rotation handles
3. Image resize handles
4. Image rotation handles
5. Image pan (drag anywhere)

## Visual Feedback

| Visual | Description |
|--------|-------------|
| **Ghost image** | Full image shown at 30% opacity, showing the uncropped area |
| **Blue L-brackets** | Corner brackets marking the container boundary (4 corners) |
| **Blue edge lines** | Short lines at edge midpoints for container resize |

Handle sizes scale inversely with zoom to remain consistently visible.

## Crop Compensation

When you resize an element **outside crop mode** while holding the **Command key**, the crop data adjusts automatically so the image's world-space position is preserved (the image stays fixed while the container changes around it). This works for fill, fit, and crop scale modes. For fill/fit modes, the image is automatically converted to crop mode with equivalent positioning. **Repeat mode is not compensated** -- repeat images always tile relative to the element and scale normally with it.

Rotation outside crop mode does not trigger compensation.

Without Command held, resizing outside crop mode does NOT compensate -- the image scales with the container normally.

When resizing or rotating the container **during crop mode**, compensation happens automatically (no Command key needed) to keep the cropped image in place.

## Supported Elements

Element types that support crop:
- Rectangle and circle elements with image fills or image strokes
- Childless frames with image fills (used as clipped image containers)
- Text elements enter text editing mode instead (not crop) — even when they have an image fill
- Vector shapes enter vector editing mode instead (not crop) — even when they have an image fill
- Frames with children drill into children instead (not crop) — only childless frames can be cropped

## Undo

All crop operations (pan, resize image, rotate image) are individually undoable with **Cmd+Z**. Entering crop mode registers an undo point that reverts the element to its pre-crop state. Each subsequent operation (pan, resize, rotate) registers its own separate undo entry.

## Tips

- **Start with Fill mode** for images that should cover the element completely, then switch to Crop only when you need precise positioning
- **Use Fit mode** for images that must be fully visible (logos, icons)
- **Proportional image resize** (Shift or Ctrl while dragging) keeps the image from distorting
- **Cmd+Z to revert** if you have made crop changes you do not want to keep (Escape saves and exits)
- **Image strokes** support the same scale modes and crop interactions as image fills

---

## Related

- [STYLING.md](./STYLING.md) — Image fills and other styling
- [EDITING.md](./EDITING.md) — Selection and navigation
- [TOOLS.md](./TOOLS.md) — Drawing tools
