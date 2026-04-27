---
name: "knowledge-export"
description: "Export and import in Brilliant: PNG, JPEG, WebP, SVG, PDF, MP4, MOV, Replay export, Copy As clipboard commands, and SVG/Sketch/image import."
---

# Export & Import

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Brilliant supports exporting designs to multiple formats and copying to clipboard in various representations. It also supports importing SVG files, Sketch files, Figma designs (via URL), and images.

## Export Formats

| Format | Extension | Type | Notes |
|--------|-----------|------|-------|
| **PNG** | .png | Raster | Transparency supported |
| **JPEG** | .jpg | Raster | No transparency (transparent areas filled with canvas background color). Quality fixed at 90 in the UI; configurable via MCP `export` tool |
| **WebP** | .webp | Raster | Transparency supported. Native libwebp encoding on macOS (real WebP bytes); other platforms currently fall back to PNG bytes. Lossy (q=90) by default; see WebP Quality below |
| **SVG** | .svg | Vector | Effects via SVG filters; shader fills, inner shadow, inner glow, background blur, color adjust, and image filter fills are rasterized as embedded PNG images |
| **PDF** | .pdf | Vector | Embedded fonts (Google Fonts cache + system fonts, Helvetica fallback); elements with effects are rasterized for fidelity |
| **MP4** | .mp4 | Video | H.264 or HEVC codec. Native hardware-accelerated encoding (macOS). Includes a silent audio track for broad compatibility (e.g., WhatsApp) |
| **MOV** | .mov | Video | HEVC (with alpha) or ProRes 4444. Supports transparent background (macOS) |
| **Replay** | .mp4 | Video | Animated reveal of the selection: elements appear one after another with a shimmer. Always written as MP4 on disk; the chosen container (MP4/MOV) and codec control the encoding |

### WebP Quality

WebP exports are lossy by default at quality 90. **For UI mockups (cards, buttons, panels with rounded corners) lossy WebP at q=90 leaves visible gray artifacts on rounded edges and gradients.** Use lossless WebP for UI mockups instead.

The right-toolbar Export panel does not currently expose a lossless toggle, so to get lossless WebP either:
- Use the MCP `export` tool with `format: "webp"` and `webpLossless: true`
- Or export as PNG (also lossless, broader compatibility)

## Export to File

### Commands

| Command | Shortcut | Description |
|---------|----------|-------------|
| Export to PNG | **Cmd+E** | Export selected elements as PNG |
| Export to JPEG | Command palette | Export selected elements as JPEG |
| Export to WebP | Command palette | Export selected elements as WebP |
| Export to SVG | Command palette | Export selected elements as SVG |
| Export to PDF | Command palette | Export selected elements as PDF |
| Export to Replay | Command palette / context menu | Export selected elements as an animated reveal MP4 (context-menu default is 2× scale) |

**Note:** Video export (MP4/MOV) does not have commands or keyboard shortcuts. It is only available from the **Export panel** in the right toolbar (see [Video Export](#video-export-mp4--mov) below). Replay is the one video format that does have a command, because it has a sensible one-click default.

Cmd+E is the only export keyboard shortcut. All other formats are reached via the command palette, the right-click "Export As" submenu, or the right-toolbar Export panel.

### Workflow

1. **Select elements** on the canvas (selecting a frame includes all its children). All export operates on the current selection (not the whole canvas)
2. Run the export command (shortcut, command palette, or right-click context menu)
3. A save dialog appears with a default filename (timestamped)
4. Choose location and save

### Export Options

Configure export settings in the **Export panel** in the right toolbar (appears when elements are selected).

| Option | Values | Default |
|--------|--------|---------|
| **Format** | PNG, JPEG, WebP, SVG, PDF, MP4, MOV, Replay | PNG |
| **Resolution** | Original (1x), Original (2x), Original (3x), Original (4x), 720p, 1080p, 1440p, 4K, 8K, Instagram Post (1080×1080), Instagram Story (1080×1920), iPhone 16 Pro (1206×2622), MacBook Pro 14" (3024×1964), Custom | Original (1x) |
| **Width/Height** | Target pixel dimensions (MCP `export` tool: `width`, `height` params). Provide one to scale proportionally, or both for exact size. Mutually exclusive with scale. | — |
| **Fit mode** | Fit, Fill, Stretch, Repeat (only used when both target dimensions are set) | Fit |
| **Background** | Transparent, Canvas (when format supports alpha) | Transparent |

**Notes:**
- Exports use transparent background by default. JPEG does not support transparency, so when "Transparent" background is selected with JPEG it automatically falls back to the canvas background color
- JPEG quality is fixed at 90 in the UI. For other values (0–100), use the MCP `export` tool's `jpegQuality` parameter
- For raster formats, the Resolution dropdown controls output dimensions; for vector formats (SVG, PDF), resolution is not applicable
- **Batch export:** Click the **+ button** in the Export panel header ("Add export config") to add additional export rows. Each row has its own format, resolution, fit mode, and background. The **Export** button writes all configured rows from a single click. Useful for shipping the same selection at PNG @1x, PNG @2x, and SVG together

### Context Menu

Right-click selected elements to access:
- **Export As** submenu: PNG, PNG @2x, PNG @4x, SVG, Replay
- **Copy As** submenu (separate): see [Copy to Clipboard](#copy-to-clipboard) below

---

## Copy to Clipboard

Copy design elements to clipboard in various formats — useful for pasting into code editors, documentation, other design tools, or chat.

### Commands

| Command | Description |
|---------|-------------|
| Copy as PNG | Copy as PNG image (at screen resolution) |
| Copy as WebP | Copy as WebP image (macOS only; narrow app compatibility — use PNG for broad paste support) |
| Copy as SVG | Copy as SVG markup text |
| Copy as CSS | Copy as CSS properties (position, size, colors, borders, gradients, rotation) |
| Copy as YAML | Copy as YAML serialization (full element data) |
| Copy as Blueprint | Copy as Brilliant's blueprint format string |

### Context Menu

Right-click selected elements to access:
- **Copy As** submenu: PNG, PNG @2x, PNG @4x, WebP, SVG, CSS, YAML, Blueprint

### Clipboard Formats

- **PNG**: Image data copied to system clipboard. Default scale matches device pixel ratio for WYSIWYG (what you see on screen matches what you paste). @2x and @4x options multiply the scale for higher-resolution output.
- **SVG**: Plain SVG markup text. Paste into code editors or SVG-capable tools.
- **CSS**: CSS class with `width`, `height`, `position`, `left`, `top`, `border-radius`, `background-color`, `border`, `transform` (rotation), gradients, and text properties (`font-size`, `font-family`, `font-weight`, `font-style`, `text-decoration`, `line-height`, `color`). Note: `border-radius` is only exported for frames — corner radii on rectangle elements are not included.
- **YAML**: Full element properties including hierarchy. Useful for debugging or programmatic access.
- **Blueprint**: Brilliant's internal element blueprint format. Can be pasted back into Brilliant or shared with AI tools.

---

## Video Export (MP4 / MOV)

Video export renders animated shader fills frame-by-frame into a hardware-accelerated video file (macOS, via VideoToolbox / AVAssetWriter). Video export is **only available from the Export panel** in the right toolbar; there are no commands, shortcuts, or context menu entries for plain MP4/MOV. Replay is the exception (see [Replay Export](#replay-export) below).

### Workflow

1. **Select elements** on the canvas
2. In the **Export panel** (right toolbar), choose **MP4** or **MOV** format from the format dropdown
3. The video options (duration, FPS, codec, quality, background) appear inline beneath the format row
4. Configure duration, FPS, codec, quality, resolution, and background
5. Click **Export**: a progress bar shows frame-by-frame encoding
6. Save dialog appears with a timestamped filename

### Video Options

| Option | Values | Default |
|--------|--------|---------|
| **Duration** | 0.5–60 seconds (drag to adjust; presets via dropdown) | 10s |
| **FPS** | 15, 24, 30, 60 | 60 |
| **Quality** | Low (smaller file), Medium (balanced), High (best quality) | Medium |
| **Resolution** | Same presets as image export (Original 1x/2x/3x/4x, named resolutions, Custom) | Original (1x) |

### Codecs

| Codec | Formats | Alpha | Notes |
|-------|---------|-------|-------|
| **H.264** | MP4 | No | Universal compatibility |
| **HEVC (H.265)** | MP4, MOV | MOV only | More efficient compression |
| **ProRes 4444** | MOV only | Yes | Professional quality, largest files |

Codec selection is constrained by format: MP4 only offers H.264 and HEVC; MOV offers HEVC and ProRes 4444. The UI automatically adjusts if you switch formats.

### Transparent Background

Only **MOV** with **HEVC** or **ProRes 4444** supports transparent background. MP4 always has an opaque background (falls back to canvas color when "Transparent" is selected).

### Animation

Shader fills (metaballs, liquid metal, holographic, etc.) animate across the video duration using synthetic time values. Static elements render identically in every frame. Total frames = `ceil(duration × fps)`.

Note: video export currently animates shader fills only. Other animations (e.g., custom keyframe timelines) are not part of the video pipeline.

### Progress & Cancellation

A progress bar with "Frame X / Y" updates in real time during encoding. Cancel at any time via the cancel button.

### Replay Export

Replay export is a one-click animated reveal of the current selection: each element fades in one after another with a shimmer pass. It is always written as MP4 on disk (regardless of the chosen container).

| Option | Values | Default |
|--------|--------|---------|
| **Container** | MP4, MOV | MP4 |
| **Codec** | H.264, HEVC, ProRes 4444 (filtered by container) | H.264 |
| **Quality** | Low, Medium, High | High |
| **Pacing (ms per element)** | 10, 25, 50, 75, 100, 150, 200, 250, 300, 400 (presets) or any custom value | 150ms |
| **Intro text** | Optional short text card shown before the reveal | — |
| **Resolution** | Same presets as image/video export | Original (1x) |
| **Background** | Transparent (MOV + HEVC/ProRes only) or Canvas | Transparent |

Total duration is derived automatically from `pacing × element count` (no separate Duration field). Right-clicking a selection and choosing **Export As → Replay** uses a 2× resolution default for crisp output on retina displays.

---

## SVG Export Details

SVG export produces standards-compliant SVG with:
- Proper `viewBox` and dimensions
- Gradients (linear, radial), clip paths, and masks in `<defs>`
- Element-level opacity and blend modes via wrapper `<g>`; per-fill and per-stroke blend modes inline
- Effects rendered as SVG filter chains: drop shadow, outer glow, layer blur
- Elements with shader fills, inner shadow, inner glow, background blur, color adjust, or image filter fills pre-rasterized as embedded PNG `<image>` elements
- Arrow markers for line endpoints
- Styled text with `<tspan>` for rich text ranges
- Stroke position handling (inside strokes use clipping, outside strokes use masking)
- Vector region fills with even-odd hole subtraction
- `vector-effect="non-scaling-stroke"` on stroked shapes (except text strokes) to prevent stroke distortion when nested in scaled frames

**Limitations:**
- Angular (conic/sweep) gradients are approximated as linear gradients (SVG has no native sweep gradient primitive), so the visual result differs slightly from the canvas
- Shader strokes and color-adjust strokes that miss the rasterization path are silently omitted (rasterization usually catches them)

## PDF Export Details

PDF export produces vector output with:
- Embedded fonts (resolved from Google Fonts cache and system fonts, with Helvetica fallback)
- Vector rendering for native shape types (rectangles, circles, paths, text)
- Elements with any enabled effect rasterized as embedded images for maximum fidelity (more aggressive than SVG, which keeps drop shadow / outer glow / layer blur native)
- Gradient rendering via PDF shading patterns
- Ancestor clipping for nested frame hierarchies
- Image fills with fill / fit / crop scale modes

**Limitations:**
- Outside strokes fall back to centered strokes (true outside-stroke clipping is complex in PDF)
- `colorAdjust` fills are silently dropped (no PDF equivalent and not in the rasterization detection path)

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
| **Import file** | **Cmd+Shift+O** or command palette "Import" (supports images, SVG, and .design files) |
| **Paste from clipboard** | **Cmd+V** with an image on the clipboard |
| **Drag and drop** | Drag image files onto the canvas |
| **Import from Figma** | Command palette "Import from Figma" — opens the import section in the right toolbar, where you paste a Figma URL (OAuth-authenticated API import) |

Supported image formats: **PNG, JPEG, GIF, BMP, WebP**. On macOS, also **TIFF, HEIC, HEIF, AVIF** (via native conversion).

Imported images become rectangle elements with an image fill, placed at the canvas center.

### SVG Import

| Action | How |
|--------|-----|
| **Import SVG file** | **Cmd+Shift+O** (select .svg file) or command palette "Import SVG" |
| **Paste SVG markup** | **Cmd+V** with SVG text on the clipboard |

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

### .design File Import

| Action | How |
|--------|-----|
| **Import .design file** | **Cmd+Shift+O** (select .design file) |

Import automatically detects the `.design` file format:
- **Native YAML** (current format) -- copies the `.design` file and its referenced images into an `Imports/` folder within the current workspace, rewrites asset paths, registers the new canvas, and switches to it
- **Legacy compressed JSON** (older Save As format) -- decompresses and imports via the legacy import pipeline, also registering and switching to the new canvas

Both paths require an open workspace (repository mode).

### Paste

**Cmd+V** detects clipboard content and handles these types (checked in order):
- **Brilliant elements** — Pastes with full hierarchy and properties (same or cross-canvas). Uses internal clipboard if unchanged since last copy.
- **Image data** — Creates a rectangle with image fill
- **SVG markup** — Detected automatically; imported as native Brilliant elements
- **Figma JSON** — Detected automatically (from Brilliant Figma plugin); converted to native elements
- **Design YAML** — Brilliant's YAML serialization format; reconstructs elements
- **Blueprint format** — Brilliant's blueprint format; reconstructs elements
- **HTML** — Detected automatically; converted to native elements via the HTML-to-element pipeline
- **Plain text** — Creates a text element (fallback)

---

## Tips

- **Cmd+E** is the fastest way to export — runs PNG export with a save dialog
- **Copy as PNG** is great for quick sharing — it copies at screen resolution so what you see is what you paste
- **Use @2x or @4x** from the context menu when you need higher-resolution clipboard exports
- **Copy as SVG** is useful for pasting vector art into web projects or other design tools
- **Copy as CSS** generates production-ready CSS properties from your design
- **Selecting a frame** automatically includes all its children in the export
- **For UI mockups, prefer PNG over WebP** (or use lossless WebP via the MCP `export` tool). Default lossy WebP at q=90 leaves visible gray artifacts on rounded corners and gradients
- **Use the + button in the Export panel** to ship multiple resolutions and formats from a single Export click (e.g., PNG @1x, PNG @2x, and SVG)
- **Right-click then Export As then Replay** for a quick animated reveal of the selection (good for showing off layered designs in chat or social posts)
- **SVG import** works well for icons and simple illustrations; complex SVGs may need cleanup

---

## Related

- [CANVASES.md](./CANVASES.md) — Canvas management and file operations
- [STYLING.md](./STYLING.md) — Fills, strokes, and visual properties
- [CROP.md](./CROP.md) — Image crop mode
