---
name: "knowledge-crop-compensation"
description: "Crop compensation (image stays fixed in world space), crop undo entries, and crop tips."
assumes: reference/crop
---

# Image Crop Mode: Compensation, Undo, Tips

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
