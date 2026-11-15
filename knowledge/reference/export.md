---
name: "knowledge-export"
description: "Exporting designs in Brilliant by hand: the right-toolbar Export panel, export/copy-as commands and shortcuts, supported formats (PNG, JPEG, WebP, SVG, PDF, HTML, React, MP4, MOV, Replay), and importing SVG/Figma/images."
---

# Export & Import

Brilliant exports the current selection (with nothing selected, the whole canvas as one file) to many formats, and copies elements to the clipboard in several representations. It imports SVG files, Figma designs (via URL), images, and pastes from the clipboard.

Selecting a frame includes all of its children in the export. To export everything on a canvas as one image, export with nothing selected (`Cmd+E`, the palette, or the Export panel); to get one file per top-level element instead, select all (`Cmd+A`) first.

## Where export lives in the UI

There are three by-hand entry points:

1. **Export panel (right toolbar)**: the main hub. Appears at the bottom of the right toolbar when one or more elements are selected, and also with nothing selected, where it exports the whole canvas (`reference/ui/inspector-sections`). Choose format, resolution, fit, background, video options, PDF page mode, and run multiple export configs in one click. This is the only UI place for plain video (MP4/MOV) and PDF multi-page; agents reach both through the `export` tool.
2. **Commands / shortcuts**: `Cmd+E` exports PNG with a save dialog. All other format commands are reached through the palette.
3. **Right-click context menu**: `Export as` submenu (quick file export), `Copy as` submenu (clipboard), and `Send to` submenu (Figma).

`Cmd+E` (PNG) is the only export keyboard shortcut. Every other format is reached via the palette, the right-click submenus, or the Export panel.

## Sub-keys

- `reference/export/formats`: every format, WebP quality, text ranges with links and gradients
- `reference/export/commands`: export commands, the file export flow, tips
- `reference/export/panel`: Export panel options, batch export, PDF multi-page
- `reference/export/video`: MP4 and MOV, codecs, limits, Replay
- `reference/export/files`: separate files for a multi-selection, hidden elements
- `reference/export/copy-as`: Copy as (clipboard)
- `reference/export/export-tool`: the MCP `export` tool, where files land, when rendering has stopped
- `reference/export/other-formats`: Sketch, Figma, Illustrator, Photoshop, Send to Figma fidelity
- `reference/export/import`: importing images, SVG, `.bl`, and paste behavior

## Related

- `reference/canvases`: Canvas management and file operations
- `reference/styling`: Fills, strokes, and visual properties
- `reference/crop`: Image crop mode
- `reference/effects`: Shadows, glows, blurs, and color-adjust
- `reference/shaders`: Animated shader fills (the only thing video export animates)
