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

Each part of crop mode has its own key:

- `reference/crop/enter-exit`: entering crop (double-click, Enter, Scale Mode) and every way out
- `reference/crop/interactions`: pan, resize and rotate the image; resize and rotate the container
- `reference/crop/feedback`: handle hit-test priority, the overlay's visual feedback, which elements support crop
- `reference/crop/compensation`: crop compensation, undo, and tips

## Related

- `reference/styling`: Image fills, strokes, and other styling
- `reference/editing`: Selection and navigation
- `reference/tools`: Drawing tools
- `reference/frames`: Parents and clip-content
