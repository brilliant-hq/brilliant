---
name: "knowledge-styling-image-fills"
description: "Image fills: importing, image mode in the color picker, supported formats, resolution, and scale modes."
assumes: reference/styling
---

# Image Fills

Import an image via Cmd+Shift+O (Import), drag-and-drop from the OS file manager, or paste from clipboard. The image becomes a rectangle with an image fill.

**Image mode:** Click an image fill's color swatch in the right toolbar to open the color picker in image mode. The picker shows the image itself, drawn the way the fill draws it (Fill, Fit, Crop or Tile), with a **Replace** button over its bottom-right corner. From there you can:
- **Replace** the image with a file from disk (the Replace button)
- **Drop** an image file from the OS file manager onto the image
- **Paste** an image or image URL with Cmd+V (works with screenshots, browser copies, Finder-copied files, and pasted URLs)
- Pick how the image fits the shape from the **Fit** menu (Fill, Fit, Crop, Tile). Hovering an option previews it on the canvas; clicking applies it as one undo step.
- Set the image's **opacity** in the percent field beside the Fit menu (type `50` or `50%`, or drag).
- Click one of the **Recent** images under it to use that image instead.

Replacing the image (Replace, drop, paste, or a Recent image) swaps only the picture: the fill keeps its Fit mode, tile scale, opacity and blend mode, so a tiled pattern at 50% stays a 50% tile. A cropped image keeps its center and rotation and takes the new picture's proportions, so it never stretches, and it grows when needed so the shape is always fully covered. One undo brings the old picture back with the same settings.

An image fill with no image yet shows a dashed drop area: "Drop an image", "or paste · Choose file". Click anywhere in it (or on Choose file) to pick a file. The Fit menu and the opacity field show there too. A replace button is also available in the expanded image fill config row.

**Supported formats:** PNG, JPG / JPEG, GIF, BMP, WebP on all platforms. TIFF / TIF, HEIC / HEIF, and AVIF are additionally supported on macOS (converted to PNG via native NSImage decoding) and on Windows (converted via WIC; TIFF works out of the box, HEIC/HEIF and AVIF need the free Microsoft Store codec packs ("HEIF Image Extensions" / "AV1 Video Extension"), and a missing pack surfaces an install card instead of failing silently). On Linux those formats are excluded from file pickers and drop targets.

**Resolution:** large, high-resolution source images (well beyond typical screen dimensions) render fine and stay clean at any zoom, the app downsamples them smoothly when zoomed out, so detailed images don't shimmer or alias.

**Image Scale Modes:**

| Mode | Description |
|------|-------------|
| **Fill** (default) | Image covers the entire element, excess clipped. Aspect ratio preserved |
| **Fit** | Image fits entirely within the element, letterboxed if needed. Aspect ratio preserved |
| **Crop** | Custom positioning with interactive crop editor (see `reference/crop`) |
| **Repeat** | Image tiles relative to the element. Tile size defaults to the image's natural pixel size |

Change the scale mode in the right toolbar under the image fill section. When Repeat is selected, a **Tile Scale** field appears beside the scale mode dropdown: percent of the image's natural size (1%–800%, default 100%), with 25 / 50 / 100 / 200 / 400 presets.
