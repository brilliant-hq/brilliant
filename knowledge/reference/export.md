---
name: "knowledge-export"
description: "Export and import in Brilliant: PNG, JPEG, WebP, SVG, PDF, MP4, MOV export, Copy As clipboard commands, and SVG/Sketch/image import."
---

# Export & Import

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Brilliant supports exporting designs to multiple formats and copying to clipboard in various representations. It also supports importing SVG files, Sketch files, Figma designs (via URL), and images.

## Export Formats

| Format | Extension | Type | Notes |
|--------|-----------|------|-------|
| **PNG** | .png | Raster | Transparency supported |
| **JPEG** | .jpg | Raster | No transparency (transparent areas filled with canvas background color) |
| **WebP** | .webp | Raster | Transparency supported (internally PNG-encoded with .webp extension; native WebP encoding pending) |
| **SVG** | .svg | Vector | Effects via SVG filters; shader fills and some fill types rasterized as embedded images |
| **PDF** | .pdf | Vector | Embedded fonts, effects rasterized for fidelity |
| **MP4** | .mp4 | Video | H.264 or HEVC codec. Native hardware-accelerated encoding (macOS) |
| **MOV** | .mov | Video | HEVC (with alpha) or ProRes 4444. Supports transparent background (macOS) |

## Export to File

### Commands

| Command | Shortcut | Description |
|---------|----------|-------------|
| Export to PNG | **Cmd+E** | Export selected elements as PNG |
| Export to JPEG | Command palette | Export selected elements as JPEG |
| Export to WebP | Command palette | Export selected elements as WebP |
| Export to SVG | Command palette | Export selected elements as SVG |
| Export to PDF | Command palette | Export selected elements as PDF |

**Note:** Video export (MP4/MOV) does not have commands or shortcuts. It is only available from the **Export panel** in the right toolbar — see [Video Export](#video-export-mp4--mov) below.

### Workflow

1. **Select elements** on the canvas (selecting a frame includes all its children)
2. Run the export command (shortcut, command palette, or right-click context menu)
3. A save dialog appears with a default filename (timestamped)
4. Choose location and save

### Export Options

| Option | Values | Default |
|--------|--------|---------|
| **Scale** | 0.25x, 0.5x, 0.75x, 1x, 1.5x, 2x, 3x, 4x, 5x, 6x, 8x, 10x (or any value 0.1–10x via drag) | 1x |

**Notes:**
- Exports use transparent background by default (JPEG substitutes the canvas background color since it has no transparency support)
- JPEG quality is fixed at 90
- Configure export settings in the **Export panel** in the right toolbar (appears when elements are selected)

**Note:** JPEG does not support transparency. If "transparent" background is selected, it automatically uses the canvas background color instead.

### Context Menu

Right-click selected elements to access:
- **Export As** submenu: PNG, PNG @2x, PNG @4x, SVG

---

## Copy to Clipboard

Copy design elements to clipboard in various formats — useful for pasting into code editors, documentation, other design tools, or chat.

### Commands

| Command | Description |
|---------|-------------|
| Copy as PNG | Copy as PNG image (at screen resolution) |
| Copy as SVG | Copy as SVG markup text |
| Copy as CSS | Copy as CSS properties (position, size, colors, borders, gradients, rotation) |
| Copy as YAML | Copy as YAML serialization (full element data) |
| Copy as Blueprint | Copy as Brilliant's blueprint format string |

### Context Menu

Right-click selected elements to access:
- **Copy As** submenu: PNG, PNG @2x, PNG @4x, SVG, CSS, YAML, Blueprint

### Clipboard Formats

- **PNG**: Image data copied to system clipboard. Default scale matches device pixel ratio for WYSIWYG (what you see on screen matches what you paste). @2x and @4x options multiply the scale for higher-resolution output.
- **SVG**: Plain SVG markup text. Paste into code editors or SVG-capable tools.
- **CSS**: CSS class with `width`, `height`, `position`, `left`, `top`, `border-radius`, `background-color`, `border`, `transform` (rotation), gradients, and text properties (`font-size`, `font-family`, `font-weight`, `font-style`, `text-decoration`, `line-height`, `color`). Note: `border-radius` is only exported for frames — corner radii on rectangle elements are not included.
- **YAML**: Full element properties including hierarchy. Useful for debugging or programmatic access.
- **Blueprint**: Brilliant's internal element blueprint format. Can be pasted back into Brilliant or shared with AI tools.

---

## Video Export (MP4 / MOV)

Video export renders animated shader fills frame-by-frame into a hardware-accelerated video file (macOS). Video export is **only available from the Export panel** in the right toolbar — there are no commands, shortcuts, or context menu entries for it.

### Workflow

1. **Select elements** on the canvas
2. In the **Export panel** (right toolbar), choose **MP4** or **MOV** format from the format dropdown
3. Click the **settings toggle** (slider icon) to reveal video options
4. Configure duration, FPS, codec, quality, and background
5. Click **Export** — a progress bar shows frame-by-frame encoding
6. Save dialog appears with a timestamped filename

### Video Options

| Option | Values | Default |
|--------|--------|---------|
| **Duration** | 0.5–60 seconds (presets: 1, 2, 3, 5, 10, 30, 60) | 3s |
| **FPS** | 15, 24, 30, 60 | 30 |
| **Quality** | Low, Medium, High | Medium |
| **Scale** | 0.1x–10x (same presets as image export) | 1x |

### Codecs

| Codec | Formats | Alpha | Notes |
|-------|---------|-------|-------|
| **H.264** | MP4 | No | Universal compatibility |
| **HEVC (H.265)** | MP4, MOV | MOV only | More efficient compression |
| **ProRes 4444** | MOV only | Yes | Professional quality, largest files |

Codec selection is constrained by format — MP4 only offers H.264 and HEVC; MOV offers HEVC and ProRes 4444. The UI automatically adjusts if you switch formats.

### Transparent Background

Only **MOV** with **HEVC** or **ProRes 4444** supports transparent background. MP4 always has an opaque background (falls back to canvas color).

### Animation

Shader fills (metaballs, liquid metal, holographic, etc.) animate across the video duration using synthetic time values. Static elements render identically in every frame. Total frames = `ceil(duration × fps)`.

### Progress & Cancellation

A progress bar with "Frame X / Y" updates in real time during encoding. Cancel at any time via the cancel button.

---

## SVG Export Details

SVG export produces standards-compliant SVG with:
- Proper `viewBox` and dimensions
- Gradients, clip paths, and masks in `<defs>`
- Effects rendered as SVG filter chains (drop shadow, outer glow, layer blur)
- Elements with shader fills, inner shadow, inner glow, or background blur pre-rasterized as embedded PNG images
- Arrow markers for line endpoints
- Styled text with `<tspan>` for rich text ranges
- Stroke position handling (inside strokes use clipping, outside strokes use masking)

## PDF Export Details

PDF export produces vector output with:
- Embedded fonts (resolved from Google Fonts cache)
- Effects rasterized as embedded images for maximum fidelity
- Proper gradient rendering via PDF shading patterns
- Ancestor clipping for nested frame hierarchies

---

## Other Formats

| Format | Import | Export | Notes |
|--------|--------|--------|-------|
| **.ai** (Illustrator) | No | No | Use SVG as a bridge format — export from Illustrator as SVG, then import into Brilliant |
| **.sketch** (Sketch) | **Yes** | **Yes** | Import via "Import Sketch File" (command palette), with page selection UI in the right toolbar. Export via "Save as Sketch File" (command palette) |
| **.fig** (Figma) | Via Figma URL (API) | No | "Import from Figma" (command palette) opens the import section in the right toolbar, where you paste a Figma URL (OAuth). Does not import `.fig` files directly |
| **.psd** (Photoshop) | No | No | Export layers as PNG from Photoshop, then import as images |

## Import

### Image Import

| Action | How |
|--------|-----|
| **Import image file** | **Cmd+K** or command palette "Import Image" |
| **Paste from clipboard** | **Cmd+V** with an image on the clipboard |
| **Drag and drop** | Drag image files onto the canvas |
| **Import from Figma** | Command palette "Import from Figma" — opens the import section in the right toolbar, where you paste a Figma URL (OAuth-authenticated API import) |

Supported image formats: **PNG, JPEG, GIF, BMP, WebP**

Imported images become rectangle elements with an image fill, placed at the canvas center.

### SVG Import

| Action | How |
|--------|-----|
| **Import SVG file** | Command palette "Import SVG" |

SVG import parses the file and creates native Brilliant elements:
- SVG rectangles become rectangle elements
- SVG circles/ellipses become circle elements
- SVG paths become vector elements
- SVG groups become frame parents with children
- SVG text becomes text elements
- Styles (fills, strokes, transforms) are preserved

Imported elements are placed at the canvas center and selected automatically.

### Sketch Import

| Action | How |
|--------|-----|
| **Import Sketch file** | Command palette "Import Sketch File" |

"Import Sketch File" opens the Sketch import section in the right toolbar, where you can browse for a `.sketch` file. After parsing, a page selection UI lets you choose which pages to import. Each page is imported as a separate canvas with its elements converted to native Brilliant elements.

### Paste

**Cmd+V** detects clipboard content and handles these types (checked in order):
- **Brilliant elements** — Pastes with full hierarchy and properties (same or cross-canvas)
- **Image data** — Creates a rectangle with image fill
- **SVG markup** — Detected automatically; imported as native Brilliant elements
- **Figma JSON** — Detected automatically; converted to native elements
- **Design YAML** — Brilliant's YAML serialization format; reconstructs elements
- **Blueprint format** — Brilliant's blueprint format; reconstructs elements
- **Plain text** — Creates a text element (fallback)

---

## Tips

- **Cmd+E** is the fastest way to export — selects PNG format with a save dialog
- **Copy as PNG** is great for quick sharing — it copies at screen resolution so what you see is what you paste
- **Use @2x or @4x** from the context menu when you need higher-resolution clipboard exports
- **Copy as SVG** is useful for pasting vector art into web projects or other design tools
- **Copy as CSS** generates production-ready CSS properties from your design
- **Selecting a frame** automatically includes all its children in the export
- **SVG import** works well for icons and simple illustrations; complex SVGs may need cleanup

---

## Related

- [CANVASES.md](./CANVASES.md) — Canvas management and file operations
- [STYLING.md](./STYLING.md) — Fills, strokes, and visual properties
- [CROP.md](./CROP.md) — Image crop mode
