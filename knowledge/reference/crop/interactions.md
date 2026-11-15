---
name: "knowledge-crop-interactions"
description: "Crop mode interactions: pan, resize and rotate the image, resize and rotate the container."
assumes: reference/crop
---

# Image Crop Mode: Interactions

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

Drag the visible **blue L-brackets** at the element's corners or the short **edge mid-lines** to resize the element. The whole edge is interactive, not just the midpoint marks. The image position is automatically compensated to stay fixed in world space (see `reference/crop/compensation`).

### Rotate Container

Use the regular rotation handles outside the element to rotate it. Crop data is automatically compensated.
