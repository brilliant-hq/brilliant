---
name: "knowledge-export-import"
description: "Importing images, SVG and .bl design files, and what Cmd+V pastes."
assumes: reference/export
---

# Import

## Images

| Action | How |
|--------|-----|
| Import file | **Cmd+Shift+O** or palette "Import" (images, SVG, and `.bl` design files) |
| Paste from clipboard | **Cmd+V** with an image on the clipboard |
| Drag and drop | Drag image files onto the canvas |
| Import from Figma | Palette "Import from Figma" (opens the "+" New project page's Figma link field; the import itself runs through the Brilliant Figma plugin and the import screen, `reference/canvases/figma-import`) |

Supported image formats: PNG, JPEG, GIF, BMP, WebP. On macOS and Windows also TIFF, HEIC, HEIF, AVIF (converted natively: NSImage on macOS, WIC on Windows; Windows HEIC/AVIF need the free Microsoft Store codec packs, and a missing pack is announced with an install card). Imported images become rectangle elements with an image fill, placed at the canvas center.

## SVG

| Action | How |
|--------|-----|
| Import SVG file | **Cmd+Shift+O** (select a `.svg` file) or palette "Import SVG" |
| Paste SVG markup | **Cmd+V** with SVG text on the clipboard |

SVG import creates native Brilliant elements: rectangles become rectangles, circles/ellipses become circles, paths become vectors, groups become frame parents with children, text becomes text. Fills, strokes, and transforms are preserved. Imported elements are centered and selected. Icons and simple illustrations import cleanly; complex SVGs may need cleanup.

## Design files (`.bl`)

**Cmd+Shift+O** and selecting a `.bl` file (or legacy `.design`) imports it. Native design files are copied (with their referenced images) into an `Imports/` folder in the current workspace, registered as a new canvas, and switched to. Legacy compressed-JSON Save As files are decompressed and imported the same way. Both require an open workspace.

## Paste behavior

**Cmd+V** detects clipboard content and handles, in order: Brilliant elements (full hierarchy, same or cross-canvas), image data (becomes a rectangle with image fill), SVG markup, Figma JSON (from the Brilliant Figma plugin), Brilliant YAML, Brilliant Blueprint, HTML (converted to native elements), and finally plain text (becomes a text element).
