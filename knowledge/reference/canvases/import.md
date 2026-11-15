---
name: "knowledge-canvases-import"
description: "Importing images, SVG, and design files by hand."
assumes: reference/canvases
---

# Importing Files

| Action | Shortcut |
|--------|----------|
| Import from file | Cmd+Shift+O |
| Paste from clipboard | Cmd+V |
| Drag and drop | Drag image files onto the canvas |

Cmd+Shift+O opens a picker that accepts images, SVG files, and design files (`.bl`, plus legacy `.design`):
- **Images** (PNG, JPG, JPEG, GIF, BMP, WebP; on macOS and Windows also TIFF, HEIC, HEIF, AVIF) become rectangle elements with an image fill. On Windows, HEIC/HEIF and AVIF need the free Microsoft Store codec packs ("HEIF Image Extensions" / "AV1 Video Extension"); without them the import shows a card naming the missing pack, with a **Get codec** button that opens its Microsoft Store page
- **SVG** imports as native editable vector elements
- **Design files** (`.bl`, legacy `.design`) are imported into an `Imports/` folder

## Importing SVG files

SVG imports as native editable vector elements. Methods: palette ("Import SVG"), paste SVG text with Cmd+V, or Cmd+Shift+O then pick a `.svg` file.
- Supported elements: rect, circle, ellipse, line, path, polygon, polyline, text, g (groups become frames)
- Preserved: fills, strokes, gradients, transforms, hierarchy
