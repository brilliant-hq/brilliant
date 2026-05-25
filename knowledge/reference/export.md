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
| **PNG** | .png | Raster | Transparency supported. Default for `Cmd+E` |
| **JPEG** | .jpg | Raster | No transparency. When `background: clear` is requested with JPEG, it auto-substitutes to `window` (canvas color). `jpegQuality` defaults to 90; valid range 0-100 |
| **WebP** | .webp | Raster | Transparency supported. Native libwebp encoding on macOS via FFI (`native/libwebp/macos/libwebp.dylib` + `libsharpyuv`). Windows and Linux currently emit PNG bytes with a `.webp` extension and a warning log. Lossy q=90 by default; pass `webpLossless: true` for UI mockups (see "WebP Quality" below) |
| **SVG** | .svg | Vector | Native filters for `dropShadow`, `outerGlow`, `layerBlur`. Pre-rasterized to embedded base64 PNG `<image>`: shader fills, inner shadow, inner glow, background blur, color adjust, image filter fills (and shader/colorAdjust strokes when not pre-rasterized are silently dropped). Angular (sweep) gradients are approximated as linear gradients |
| **PDF** | .pdf | Vector | Embedded fonts via Google Fonts cache + system fonts, Helvetica fallback. Any element with at least one enabled effect is rasterized whole. Outside strokes fall back to centered. `colorAdjust` fills are silently dropped (no detection path). Vector rendering for native shapes |
| **HTML** | .html | Text/Markup | HTML + inline CSS snippet. Three variants: `html` (default snippet), `htmlDoc` (self-contained `<!DOCTYPE html>` with Google Fonts `<link>` for detected web fonts), `htmlFlex` (auto-layout frames emit `display:flex` + gap + padding instead of absolute positioning). Available via commands and Copy-As only, NOT exposed through the MCP `export` tool |
| **React (JSX)** | .tsx | Text/Markup | Same DOM as HTML, but `style="..."` becomes `style={{ ... }}` with camelCase keys; SVG hyphen-attrs convert to camelCase. Pasteable directly into a `.tsx` file. Commands/Copy-As only, NOT exposed through the MCP `export` tool |
| **MP4** | .mp4 | Video | H.264 or HEVC. macOS only (VideoToolbox/AVAssetWriter). Includes a silent AAC audio track for broad compatibility (WhatsApp etc.). No alpha channel. Right-toolbar Export panel only (no command, no MCP) |
| **MOV** | .mov | Video | HEVC (with alpha) or ProRes 4444. macOS only. Supports transparent background. Right-toolbar Export panel only (no command, no MCP) |
| **Replay** | .mp4 (always) | Video | Animated reveal: elements fade in sequentially with a shimmer pass. Routed through `SessionVideoRecorder.recordElements` (different code path from MP4/MOV exports). The chosen `replayContainer` (MP4/MOV) and `replayCodec` control encoding. Total duration auto-derived from `replayMsPerElement × element count`. Not available via the MCP `export` tool |

### WebP Quality

WebP defaults to lossy at quality 90. **For UI mockups (cards, buttons, panels with rounded corners and gradients) lossy WebP at q=90 leaves visible gray artifacts on rounded edges and color ramps.** Use lossless WebP for UI mockups, or pick PNG.

The right-toolbar Export panel does not expose a lossless toggle in this build. To get lossless WebP:
- Call the MCP `export` tool with `format: "webp"` and `webpLossless: true` (recommended for UI mockups)
- Or export as PNG (lossless and broadly compatible)

The `Copy as WebP` clipboard command produces lossy WebP under the `org.webmproject.webp` UTI on macOS only; most apps prefer PNG when both are available, so use `Copy as PNG` for general-purpose pasting.

## Export to File

### Commands

| Command | ID | Shortcut | Description |
|---------|-----|----------|-------------|
| Export to PNG | `export_to_png` | **Cmd+E** | Export selected elements as PNG |
| Export to JPEG | `export_to_jpeg` | Command palette | Export selected elements as JPEG |
| Export to WebP | `export_to_webp` | Command palette | Export selected elements as WebP |
| Export to SVG | `export_to_svg` | Command palette | Export selected elements as SVG |
| Export to PDF | `export_to_pdf` | Command palette | Export selected elements as PDF |
| Export to HTML | `export_to_html` | Command palette | Export selected elements as an HTML/CSS snippet (`.html`) |
| Export to React (JSX) | `export_to_react` | Command palette | Export selected elements as a React JSX snippet (`.tsx`) |
| Export to Replay | `export_to_replay` | Command palette / context menu | Export selected elements as an animated reveal MP4 (context-menu default is 2× scale) |
| Send to Figma | `copy_to_figma` | Command palette / context menu (`Send to → Figma`) | Send selected elements to the Brilliant Figma plugin over the live socket. Gated on the plugin being paired; falls back to clipboard otherwise |

**Note:** Plain video export (MP4/MOV) does not have commands or keyboard shortcuts. It is only available from the **Export panel** in the right toolbar (see [Video Export](#video-export-mp4--mov) below). Replay is the one video format that does have a command, because it has a sensible one-click default.

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
| **Format** | PNG, JPEG, WebP, SVG, PDF, HTML, HTML (document), HTML (flex), React (JSX), MP4, MOV, Replay | PNG |
| **Resolution** | `Original (1x)`, `Original (2x)`, `Original (3x)`, `Original (4x)`, `720p` (1280x720), `1080p` (1920x1080), `1440p` (2560x1440), `4K` (3840x2160), `8K` (7680x4320), `Instagram Post` (1080x1080), `Instagram Story` (1080x1920), `iPhone 16 Pro` (1206x2622), `MacBook Pro 14"` (3024x1964), `Custom`. Vector formats (SVG, PDF) hide the resolution row. | `Original (1x)` |
| **Width / Height** | Target pixel dimensions when format is raster or video. Mutually exclusive with `scale`. Provide one to scale proportionally, or both with a `fitMode` for exact size | none |
| **Fit mode** | `Fit` (letterbox), `Fill` (crop), `Stretch` (non-uniform), `Repeat` (1:1 tiled). Only consulted when both target dimensions are set | `Fit` |
| **Background** | `Transparent`, `Canvas` (canvas background color, used as fallback when format does not support alpha) | `Transparent` |

**Notes:**

- JPEG and MP4 have no alpha channel: when `Transparent` is requested the runtime auto-substitutes `Canvas`. Lossless WebP and PNG keep alpha. MOV preserves alpha only with HEVC-with-alpha or ProRes 4444
- The right-toolbar UI ships JPEG at quality 90 and does NOT expose a quality slider. For 0-100 control, call the MCP `export` tool with `jpegQuality`
- The right-toolbar UI ships WebP as lossy q=90 with no UI toggle. For lossless, call the MCP `export` tool with `webpLossless: true`. Strongly preferred for UI mockups
- For SVG and PDF, the Resolution dropdown is hidden (vector output is resolution-independent)
- **Batch export:** the `+` button in the Export panel header (`Add export config`) appends an additional export row. Each row has independent format, resolution, fit mode, and background. The `Export` button runs every configured row from a single click. Use for shipping (PNG @1x, PNG @2x, SVG) together

### Context Menu

Right-click selected elements to access (from `lib/views/unified_context_menu.dart`):
- **Export As** submenu: PNG, PNG @2x, PNG @4x, SVG, Replay
- **Copy As** submenu (separate): PNG, PNG @2x, PNG @4x, WebP, SVG, HTML, React, CSS, YAML, Blueprint. See [Copy to Clipboard](#copy-to-clipboard) below
- **Send to** submenu: Figma (disabled when the Brilliant Figma plugin isn't paired)

---

## MCP `export` Tool (programmatic export)

Schema (from `lib/providers/native_tools.dart`):

| Param | Type | Default | Notes |
|-------|------|---------|-------|
| `canvasId` | string | required | Target canvas |
| `ids` | string[] | required | Element IDs (or session refs) to export. Selecting a frame includes all descendants |
| `format` | enum | `png` | `png`, `jpeg`, `webp`, `svg`, `pdf`. HTML, React, MP4, MOV, and Replay are NOT exposed via MCP (commands/UI only) |
| `scale` | number | `2.0` | Raster only. Mutually exclusive with `width`/`height`. Ignored for SVG/PDF |
| `width` | int | none | Target pixel width. With only `width`, `height` is computed proportionally |
| `height` | int | none | Target pixel height. With only `height`, `width` is computed proportionally |
| `fitMode` | enum | `fit` | `fit`, `fill`, `stretch`. Only consulted when both `width` and `height` are set |
| `jpegQuality` | int | `90` | 0-100, JPEG only |
| `webpQuality` | int | `90` | 0-100, WebP lossy only (ignored when `webpLossless: true`) |
| `webpLossless` | bool | `false` | **Set true for UI mockups** to avoid q=90 banding on rounded corners |
| `background` | enum | `clear` | `clear`, `window`. Ignored for SVG/PDF. JPEG auto-falls back to `window` |
| `outputPath` | string | none | When set, writes to disk and returns a confirmation rather than inline bytes |

Return shape:
- Raster (png/jpeg/webp): inline image content part
- SVG: raw SVG markup as text
- PDF: base64-encoded data as text
- With `outputPath`: short text confirmation

The tool resolves `#refs` and stale canvas IDs (from in-flight sessions started before a rename) automatically. Default `scale: 2.0` matches typical Retina output, not 1.0.

---

## Copy to Clipboard

Copy design elements to clipboard in various formats: useful for pasting into code editors, documentation, other design tools, or chat.

### Commands

| Command | ID | Description |
|---------|-----|-------------|
| Copy as PNG | `copy_as_png` | Copy as PNG image (at screen resolution / device pixel ratio) |
| Copy as WebP | `copy_as_webp` | Copy as WebP image (macOS only; narrow app compatibility: use PNG for broad paste support) |
| Copy as SVG | `copy_as_svg` | Copy as SVG markup text |
| Copy as HTML | `copy_as_html` | Copy as an HTML/CSS snippet (auto-layout frames absolute-positioned) |
| Copy as HTML (document) | `copy_as_html_document` | Copy as a self-contained `<!DOCTYPE html>` document with Google Fonts `<link>` for any detected web fonts |
| Copy as HTML (flex) | `copy_as_html_flex` | Copy as HTML where auto-layout frames emit `display:flex` + gap + padding instead of absolute positioning |
| Copy as React | `copy_as_react` | Copy as a React JSX snippet (camelCase `style={{}}` object, camelCase SVG attrs) |
| Copy as CSS | `copy_as_css` | Copy as CSS properties (position, size, colors, borders, gradients, rotation) |
| Copy as YAML | `copy_as_yaml` | Copy as YAML serialization (full element data) |
| Copy as Blueprint | `copy_as_blueprint` | Copy as Brilliant's blueprint format string |

### Context Menu

Right-click selected elements to access:
- **Copy As** submenu: PNG, PNG @2x, PNG @4x, WebP, SVG, HTML, React, CSS, YAML, Blueprint

### Clipboard Formats

- **PNG**: Image data copied to system clipboard. Default scale matches device pixel ratio for WYSIWYG (what you see on screen matches what you paste). @2x and @4x options multiply the scale for higher-resolution output.
- **WebP**: WebP bytes under the `org.webmproject.webp` UTI (macOS only). Most apps prefer PNG when both are available, so use `Copy as PNG` for general-purpose pasting. Always lossy q=90; no lossless option on the clipboard path.
- **SVG**: Plain SVG markup text. Paste into code editors or SVG-capable tools.
- **HTML**: HTML/CSS snippet with inline `style="..."`. Auto-layout frames are flattened to absolute positioning. Useful for pasting into a regular `.html` file.
- **HTML (document)**: A complete `<!DOCTYPE html>` document with `<head>` + Google Fonts `<link>` injected for any detected web font families used in the selection.
- **HTML (flex)**: Same as HTML but auto-layout frames emit `display:flex` + `flex-direction` + `gap` + `padding` instead of absolute-positioned children. Picks natural CSS layout over pixel-perfect wrap fidelity.
- **React (JSX)**: JSX snippet pasteable into a `.tsx` file. `style="..."` becomes `style={{ ... }}` with camelCase keys; SVG hyphen-attrs (`stroke-width`, `clip-path`) convert to camelCase (`strokeWidth`, `clipPath`).
- **CSS**: CSS class with `width`, `height`, `position`, `left`, `top`, `border-radius`, `background-color`, `border`, `transform` (rotation), gradients, and text properties (`font-size`, `font-family`, `font-weight`, `font-style`, `text-decoration`, `line-height`, `color`). Note: `border-radius` is only exported for frames: corner radii on rectangle elements are not included. Only the first solid fill and first solid stroke are emitted. Only `linear-gradient` is emitted (radial gradients are dropped).
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

UI defaults (right-toolbar Export panel) differ from the underlying `VideoExportOptions` defaults: the panel ships with `duration = 10s`, `fps = 60`, `quality = Medium`, while `VideoExportOptions` itself defaults to `duration: 3.0, fps: 30, quality: medium`. The UI values win for human-driven video export.

| Option | Values | UI Default |
|--------|--------|------------|
| **Duration** | 0.5-60s (draggable; preset dropdown) | 10s |
| **FPS** | 15, 24, 30, 60 | 60 |
| **Quality** | Low (smaller file), Medium (balanced), High (best quality) | Medium |
| **Resolution** | Same presets as image export | `Original (1x)` |

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

Replay export is a one-click animated reveal of the current selection: each element fades in one after another with a shimmer pass. It is always written as MP4 on disk (the chosen container picks `.mp4` vs `.mov` extension and the encoder path).

| Option | Values | Default |
|--------|--------|---------|
| **Container** | MP4, MOV | MP4 |
| **Codec** | H.264, HEVC, ProRes 4444 (filtered by container) | H.264 |
| **Quality** | Low, Medium, High | High (`ExportOptions.replayQuality`) |
| **Pacing (ms per element)** | 10, 25, 50, 75, 100, 150, 200, 250, 300, 400 (presets) or any custom value | 150ms |
| **Intro text** | Optional short text card shown before the reveal |  |
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

### Multi-Page PDF

PDF is the one format with a multi-page mode (right-toolbar Export panel only; not exposed via MCP). Toggle the inline **Pages** dropdown next to the PDF format pill to switch between single-page and multi-page.

- **Single-page (default):** entire selection rendered onto one page sized to the selection's bounding box.
- **Multi-page:** one page per top-level frame in the selection. Loose top-level elements are ignored when at least one frame is present; when there are zero frames, each loose top-level element becomes a page instead.
- **Page order:** defaults to canvas reading order (top-to-bottom, left-to-right). Open the gear-button settings panel to see the page list, then drag rows to reorder.
- **Per-page include toggle:** the same panel exposes a checkbox per page so you can exclude individual frames from the export without removing them from the selection.

Multi-page state is per export-config row, so a single click can ship a single-page PDF and a multi-page PDF together via the `+` batch button.

**Limitations:**
- Outside strokes fall back to centered strokes (true outside-stroke clipping is complex in PDF)
- `colorAdjust` fills are silently dropped (no PDF equivalent and not in the rasterization detection path)

---

## Other Formats

| Format | Import | Export | Notes |
|--------|--------|--------|-------|
| **.ai** (Illustrator) | No | No | Use SVG as a bridge format: export from Illustrator as SVG, then import into Brilliant |
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
| **Import from Figma** | Command palette "Import from Figma": opens the import section in the right toolbar, where you paste a Figma URL (OAuth-authenticated API import) |

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
- **Brilliant elements**: Pastes with full hierarchy and properties (same or cross-canvas). Uses internal clipboard if unchanged since last copy.
- **Image data**: Creates a rectangle with image fill
- **SVG markup**: Detected automatically; imported as native Brilliant elements
- **Figma JSON**: Detected automatically (from Brilliant Figma plugin); converted to native elements
- **Design YAML**: Brilliant's YAML serialization format; reconstructs elements
- **Blueprint format**: Brilliant's blueprint format; reconstructs elements
- **HTML**: Detected automatically; converted to native elements via the HTML-to-element pipeline
- **Plain text**: Creates a text element (fallback)

---

## Tips

- `Cmd+E` runs PNG export with a save dialog (the only export keybinding)
- `Copy as PNG` copies at device pixel ratio for WYSIWYG paste
- Right-click then `Copy As` then `PNG @2x`/`@4x` for higher-resolution clipboard exports
- `Copy as SVG` is useful for pasting vector art into web projects or other design tools
- `Copy as CSS` produces position+size+colors+rotation+text props. Borders only emit for the first solid stroke; gradients only emit `linear-gradient`; corner radius only emits for frames (not rectangles)
- Selecting a frame includes all its descendants in the export
- **UI mockups in WebP: always pass `webpLossless: true` via the MCP `export` tool.** The right-toolbar UI exports lossy q=90 WebP, which leaves visible gray banding on rounded corners and gradients. The `Copy as WebP` clipboard command and the right-toolbar Export panel both ship lossy WebP with no UI toggle. Either pass `webpLossless: true` via the MCP `export` tool, or pick PNG
- The `+` button in the Export panel batches multiple rows (PNG @1x, PNG @2x, SVG) into one click
- Right-click then `Export As` then `Replay` runs at 2x scale by default, which reads cleanly on retina
- SVG import handles icons and simple illustrations well; complex SVGs may need cleanup

---

## Related

- [CANVASES.md](./CANVASES.md): Canvas management and file operations
- [STYLING.md](./STYLING.md): Fills, strokes, and visual properties
- [CROP.md](./CROP.md): Image crop mode
