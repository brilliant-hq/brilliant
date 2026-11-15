---
name: "knowledge-export-commands"
description: "The export commands and their shortcuts, the by-hand file export flow, and export tips."
assumes: reference/export
---

# Export Commands

| Command | Shortcut |
|---------|----------|
| Export to PNG | **Cmd+E** |
| Export to JPEG | palette |
| Export to WebP | palette |
| Export to SVG | palette |
| Export to PDF | palette |
| Export to HTML | palette |
| Export to React (JSX) | palette |
| Export to Replay | palette / context menu (both render at 2x scale) |
| Send to Figma | palette / `Send to → Figma` (only enabled when the Brilliant Figma plugin is paired; otherwise falls back to clipboard) |

Plain MP4/MOV have no command or shortcut: by hand they come from the Export panel, and agents on the desktop app export them with the `export` tool. Replay is the one video format with a command because it has a sensible one-click default.

## File export flow (by hand)

1. Select elements on the canvas. Selecting a frame includes its children.
2. Run the export command (`Cmd+E`, palette, or right-click `Export as`), or configure and click `Export` in the Export panel.
3. A save dialog opens with a timestamped default filename.
4. Choose location and save.

The empty-canvas case: with nothing selected on a canvas that has no visible content, an export command shows the notice "Nothing to export: this canvas is empty." and saves nothing.

**Export with nothing selected.** With nothing selected, the export commands (Export to PNG, SVG, PDF and the other file formats) export the WHOLE canvas as ONE file: everything visible on the canvas, framed by the union of its top-level layers, named after the canvas (e.g. `Home.png`). Hidden top-level layers are left out, and the separate-files option does not apply (it is one image). Replay still needs a selection.

## Tips

- `Cmd+E` runs PNG export with a save dialog (the only export shortcut).
- `Copy as PNG` copies at device pixel ratio for WYSIWYG paste; use `Copy as → PNG @2x / @4x` for higher resolution.
- Copied images contain the design only, never selection handles, guides, labels, or presence cursors. If a copy can't produce the image (e.g. the renderer is momentarily unavailable), a warning says the system clipboard was not updated, so whatever you paste then is your previous clipboard content, not this copy.
- For pixel-clean UI mockups, prefer PNG over WebP: the by-hand UI exports lossy q=90 WebP, which bands on rounded corners and gradients.
- `Copy as SVG` is good for pasting vector art into web projects or other design tools.
- The `+` button in the Export panel batches multiple configs (PNG @1x, PNG @2x, SVG) into one click.
- Right-click `Export as → Replay` runs at 2x by default for crisp retina output.
