---
name: "knowledge-canvases-export"
description: "Exporting canvases and selections by hand, exporting to Sketch, and Save As for a portable .bl package."
assumes: reference/canvases
---

# Exporting

Export selected elements, or a focused canvas/folder, via the right-toolbar Export section, the palette, or Cmd+E (PNG).

Steps:
1. Select target elements (or focus a canvas / folder in the explorer)
2. Cmd+E for a quick PNG, or open the palette and search "Export to..."
3. Or expand the Export section in the right toolbar to configure format, resolution, fit mode, and background

| Format | Shortcut | Notes |
|--------|----------|-------|
| PNG | Cmd+E | Lossless, alpha supported |
| JPEG | Palette / right toolbar | Lossy, no alpha; quality 90 default |
| WebP | Palette / right toolbar | Lossy default (q=90); a lossless option exists for clean rounded corners on UI mockups |
| SVG | Palette / right toolbar | Vector: paths, shapes, text |
| PDF | Palette / right toolbar | Vector document |
| MP4 / MOV | Palette / right toolbar | Animated; codec H.264 / HEVC / ProRes 4444 |
| Replay | Palette / right toolbar | Animated element-by-element reveal; container MP4 or MOV |

Right-toolbar export options: Format, Resolution (Original, 720p–8K, plus social/device presets and Custom), Fit mode (Fit, Fill, Stretch, Repeat), Background (Transparent or Canvas, when the format supports alpha), Constrain proportions, and video/replay options (duration, FPS, codec, quality, per-element pace, intro text). Multiple export configs can be attached to one element to export several scales or formats in one action.

Notes:
- PNG and WebP support alpha; JPEG fills transparent areas with the canvas background
- HEVC and ProRes 4444 video codecs support alpha; H.264 does not
- SVG and PDF stay sharp at any scale

Full export reference: `reference/export`.

## Exporting to Sketch

Export the focused canvas or folder as a `.sketch` file via the palette ("Save as Sketch File"). Exports elements, fills, strokes, gradients, text, and images; components and effects may flatten.

## Save As / sharing a `.bl` package

| Action | Shortcut | What it does |
|--------|----------|--------------|
| Save | Cmd+S | Save the current canvas right away (changes also save automatically) |
| Save As... | Cmd+Shift+S | Export the focused canvas or folder as a portable `.bl` package |
| Open folder | Cmd+O | Open a folder as a workspace |

Save As writes the native `.bl` file plus a sibling `Assets/` folder with all referenced images; image paths are rewritten to relative `Assets/filename` references so the package is portable. When a folder is focused, Save As exports the entire folder hierarchy. Save As writes the document as it is on screen, unsaved edits included, even when saving to the project has been failing, so it is a true copy of the current work. This is for sharing/archiving and does not replace auto-save.
