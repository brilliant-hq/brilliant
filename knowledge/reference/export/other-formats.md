---
name: "knowledge-export-other-formats"
description: "Sketch, Figma, Illustrator and Photoshop files: what imports and exports, and how faithfully Send to Figma round-trips a design."
assumes: reference/export
---

# Other application formats

| Format | Import | Export | Notes |
|--------|--------|--------|-------|
| **.sketch** (Sketch) | No | Yes | Export via "Save as Sketch File" (palette) |
| **.fig / Figma** | Via the Brilliant Figma plugin (the import screen, Send selection, Copy selection and paste) | Via "Send to Figma" (live plugin) | "Import from Figma" opens the "+" New project page's link field; the plugin's Import to Brilliant opens the import screen (`reference/canvases/figma-import`). Does not import `.fig` files directly. "Send to Figma" pushes the selection to the paired Brilliant Figma plugin. See "Send to Figma fidelity" below |
| **.ai** (Illustrator) | No | No | Bridge through SVG: export from Illustrator as SVG, then import |
| **.psd** (Photoshop) | No | No | Export Photoshop layers as PNG, then import as images |

## Send to Figma fidelity

Sending the selection to the paired Brilliant Figma plugin round-trips most of a design as native, editable Figma objects, not a flat image:

- Design-system tokens become Figma variable collections (per brand and mode) with colors, spacing, and numerics bound onto the nodes; typography and shadow tokens become Figma text and effect styles.
- Components and instances rebuild as Figma components, with instance overrides reapplied (fills, strokes, effects, opacity, corner radii, and text).
- Auto layout (including wrap and its cross-axis gap), per-side borders, dashes, masks, boolean shapes, tiled and cropped images, text case, strikethrough, vertical alignment, and liquid glass all map to their Figma equivalents.
- Hidden elements ship as hidden. Variant names with reserved characters are sanitized automatically.

Fills that Figma can't express (shader fills and image-filter fills) are pre-rasterized to an image so they still look right, and are no longer editable as parameters on the Figma side.
