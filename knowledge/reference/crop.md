---
name: "knowledge-crop"
description: "Image crop mode in Brilliant: scale modes, interactive editing, visual feedback, and crop compensation."
---

# Image Crop Mode

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Brilliant supports four image scale modes and an interactive crop editor for precise image positioning within elements.

## Image Scale Modes

Every image fill has a scale mode that controls how the image fits within the element bounds:

| Mode | Behavior | Interactive Editing? |
|------|----------|---------------------|
| **Fill** (default) | Image covers the entire element, excess clipped. Aspect ratio preserved. | No |
| **Fit** | Image fits entirely within the element, letterboxed if needed. Aspect ratio preserved. | No |
| **Crop** | Image positioned by custom crop data. Full interactive control. | Yes |
| **Repeat** | Image tiles at natural pixel size relative to the element. | No |

Change the scale mode in the right toolbar under the image fill section (dropdown).

## Entering Crop Mode

| Method | How |
|--------|-----|
| **Double-click** | Double-click an element with an image fill |
| **Enter key** | Select an image element and press **Enter** |
| **Scale mode dropdown** | Change the scale mode to **Crop** in the right toolbar |

When entering crop mode:
- The element is automatically selected
- If the current scale mode is Fill or Fit, it's converted to Crop with equivalent positioning
- The crop editor overlay appears

## Exiting Crop Mode

| Action | Result |
|--------|--------|
| **Enter** | Save crop and exit |
| **Escape** | Save crop and exit |
| **Click outside** | Save crop and exit |
| **Double-click anywhere** | Save crop and exit |
| **Change scale mode** | Selecting Fill or Fit exits crop mode |

## Crop Interactions

Crop mode provides two layers of handles: **container handles** (blue L-brackets for the element boundary) and **image handles** (invisible hit zones for the image within).

### Pan Image

Click and drag anywhere on the image area to reposition the image within the container. The image cannot be dragged entirely outside the container bounds.

### Resize Image

Drag any of the 8 image resize handles (4 corners + 4 edge midpoints) to scale the image.

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

When you resize an element **outside crop mode** while holding the **Command key**, the crop data adjusts automatically so the image's world-space position is preserved (the image stays fixed while the container changes around it). Rotation outside crop mode does not trigger compensation.

Without Command held, resizing outside crop mode does NOT compensate — the image scales with the container normally.

## Supported Elements

Element types that support crop:
- Rectangle and circle elements with image fills
- Text elements enter text editing mode instead (not crop)
- Frames and vector shapes do not support crop mode

## Undo

All crop operations (pan, resize image, rotate image) are individually undoable with **Cmd+Z**. Entering crop mode registers a single undo point that reverts the element to its pre-crop state.

## Tips

- **Start with Fill mode** for images that should cover the element completely, then switch to Crop only when you need precise positioning
- **Use Fit mode** for images that must be fully visible (logos, icons)
- **Proportional image resize** (Shift or Ctrl while dragging) keeps the image from distorting
- **Cmd+Z to revert** if you've made crop changes you don't want to keep (Escape saves and exits)

---

## Related

- [STYLING.md](./STYLING.md) — Image fills and other styling
- [EDITING.md](./EDITING.md) — Selection and navigation
- [TOOLS.md](./TOOLS.md) — Drawing tools
