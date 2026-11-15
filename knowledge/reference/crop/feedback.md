---
name: "knowledge-crop-feedback"
description: "Crop handle hit-test priority, the crop overlay visual feedback, and which elements support crop."
assumes: reference/crop
---

# Image Crop Mode: Handles, Feedback, Supported Elements

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

## Supported Elements

- **Rectangle, circle**: image fills enter crop on double-click or Enter. Image strokes enter crop via the stroke section's Scale Mode dropdown (double-click with no focused fill picks the topmost image **fill** only)
- **Vector**: image fills / strokes render, but vectors **never** enter crop on Enter / double-click (they always go to vector editing). Enter crop via the Scale Mode dropdown
- **Text**: image fills render, but Enter / double-click always goes to text editing. Enter crop via the Scale Mode dropdown
- **Childless parent frames** with image fills: double-click enters crop (used as clipped image containers). Enter does NOT enter crop on frames
- **Parent frames with children**: Enter selects their children, a double-click goes one level deeper toward the cursor; cannot enter crop directly
