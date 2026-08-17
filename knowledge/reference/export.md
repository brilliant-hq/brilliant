---
name: "knowledge-export"
description: "Exporting designs in Brilliant by hand: the right-toolbar Export panel, export/copy-as commands and shortcuts, supported formats (PNG, JPEG, WebP, SVG, PDF, HTML, React, MP4, MOV, Replay), and importing SVG/Sketch/Figma/images."
---

# Export & Import

Brilliant exports the current selection (never the whole canvas automatically) to many formats, and copies elements to the clipboard in several representations. It imports SVG files, Sketch files, Figma designs (via URL), images, and pastes from the clipboard.

Selecting a frame includes all of its children in the export. To export everything on a canvas, select all (`Cmd+A`) first.

## Where export lives in the UI

There are three by-hand entry points:

1. **Export panel (right toolbar)**: the main hub. Appears at the bottom of the right toolbar when one or more elements are selected. Choose format, resolution, fit, background, video options, PDF page mode, and run multiple export configs in one click. This is the only place plain video (MP4/MOV) and PDF multi-page are available.
2. **Commands / shortcuts**: `Cmd+E` exports PNG with a save dialog. All other format commands are reached through the command palette.
3. **Right-click context menu**: `Export as` submenu (quick file export), `Copy as` submenu (clipboard), and `Send to` submenu (Figma).

`Cmd+E` (PNG) is the only export keyboard shortcut. Every other format is reached via the command palette, the right-click submenus, or the Export panel.

## Export formats

| Format | Type | Notes |
|--------|------|-------|
| **PNG** | Raster | Transparency supported. Default for `Cmd+E` |
| **JPEG** | Raster | No alpha. Transparent background auto-substitutes the canvas color. Quality 90 in the UI |
| **WebP** | Raster | Transparency supported. Native libwebp on macOS and Windows; Linux falls back to PNG bytes. UI exports lossy q=90 (see "WebP quality" below) |
| **SVG** | Vector | Native filters for drop shadow, outer glow, layer blur. Shader fills, inner shadow/glow, background blur, color-adjust, and image-filter fills are embedded as rasterized PNG. Angular (sweep) gradients are approximated as linear |
| **PDF** | Vector | Embedded fonts (Google Fonts cache + system, Helvetica fallback). Any element with an enabled effect is rasterized whole. Supports single-page or multi-page |
| **HTML** | Markup | HTML + inline CSS. Three variants: snippet, full document (with Google Fonts link), and flex (auto-layout frames become `display:flex`). Shader fills on rectangles, full circles, and frames export as LIVE animated WebGL `<canvas>` elements (one appended `<script>` carries the runtime + shader sources; `reactiveGrid` stays mouse-interactive). Shader fills on vectors, text, or strokes are embedded as rasterized PNG. Command palette / Copy as only |
| **React (JSX)** | Markup | Same DOM as HTML, JSX style objects, camelCase attrs. Pasteable into a `.tsx` file. Shader fills are embedded as rasterized PNG (a bare JSX snippet has no script slot). Command palette / Copy as only |
| **MP4** | Video | No alpha. macOS: H.264 or HEVC (VideoToolbox). Windows: H.264 only (Media Foundation). Not available on Linux. Export panel only |
| **MOV** | Video | HEVC (with alpha) or ProRes 4444. macOS only (Windows has no QuickTime writer; Linux has no video export), supports transparent background. Export panel only |
| **Replay** | Video | Animated reveal: elements fade in one after another with a shimmer pass. Defaults to MP4 (macOS and Windows); MOV is selectable on macOS (required for a transparent background). Has a command and a context-menu entry |

MP4 export runs on macOS (VideoToolbox, H.264/HEVC) and Windows (Media Foundation, H.264 only). MOV and its alpha-capable codecs are macOS only. Linux has no video export. Replay follows the same rules as its chosen container (MP4 on macOS and Windows; MOV on macOS).

### WebP quality

The Export panel and the `Copy as WebP` command both produce lossy WebP at quality 90. For UI mockups (cards, panels, gradients, rounded corners), lossy q=90 leaves visible gray banding on rounded edges and color ramps. For pixel-clean UI mockups, prefer **PNG**. Lossless WebP is not exposed in the by-hand UI in this build (it is only reachable programmatically via the MCP `export` tool with `webpLossless: true`).

### Text ranges: hyperlinks and gradients

Two per-range text features carry unevenly across formats:

- **A hyperlink on a text range** exports as a real anchor in **HTML** (`<a href>`) and **SVG** (`<a xlink:href>`). **PDF** and the raster formats (**PNG/JPEG/WebP**) cannot carry a clickable link, so linked text exports as ordinary styled text.
- **A gradient on a text range** renders in the raster formats (**PNG/JPEG/WebP**, which read back the live canvas) exactly as on screen. The vector and markup lanes (**SVG**, **PDF**, **HTML/React**) do not carry a per-range gradient: that range falls back to its base text color.

So for a design that leans on gradient-filled or linked text, PNG keeps the gradients and HTML/SVG keep the links; no single non-canvas format carries both.

## Export commands

| Command | Shortcut |
|---------|----------|
| Export to PNG | **Cmd+E** |
| Export to JPEG | command palette |
| Export to WebP | command palette |
| Export to SVG | command palette |
| Export to PDF | command palette |
| Export to HTML | command palette |
| Export to React (JSX) | command palette |
| Export to Replay | command palette / context menu (both render at 2x scale) |
| Send to Figma | command palette / `Send to → Figma` (only enabled when the Brilliant Figma plugin is paired; otherwise falls back to clipboard) |

Plain MP4/MOV have no command or shortcut. They are reachable only from the Export panel. Replay is the one video format with a command because it has a sensible one-click default.

### File export flow (by hand)

1. Select elements on the canvas. Selecting a frame includes its children.
2. Run the export command (`Cmd+E`, command palette, or right-click `Export as`), or configure and click `Export` in the Export panel.
3. A save dialog opens with a timestamped default filename.
4. Choose location and save.

## Export panel options (right toolbar)

The Export panel appears when elements are selected.

| Option | Values | Default |
|--------|--------|---------|
| **Format** | PNG, JPEG, WebP, SVG, PDF, HTML, React (JSX), MP4, MOV, Replay. Choosing HTML reveals a **Variant** dropdown (`Page`, `Snippet`, `Flexbox`) | PNG |
| **Resolution** | `Original (1x/2x/3x/4x)`, `720p`, `1080p`, `1440p`, `4K`, `8K`, `Portrait Post · IG, FB` (1080x1350), `Square Post · IG, X` (1080x1080), `Story / Reel · IG, TikTok` (1080x1920), `iPhone 16 Pro` (1206x2622), `MacBook Pro 14"` (3024x1964), `Custom`. Hidden for vector formats (SVG, PDF) | `Original (1x)` |
| **Width / Height** | Target pixel size for raster/video. Set one to scale proportionally, or both with a fit mode for exact size | none |
| **Fit mode** | `Fit` (letterbox), `Fill` (crop), `Stretch` (non-uniform), `Repeat` (1:1 tiled). Only used when both width and height are set | `Fit` |
| **Background** | `Transparent`, `Canvas` (canvas background color) | `Transparent` |

Notes:
- JPEG and MP4 have no alpha: a Transparent request falls back to Canvas. PNG and MOV (HEVC-with-alpha or ProRes 4444) keep alpha.
- The UI ships JPEG at quality 90 with no slider, and WebP as lossy q=90 with no lossless toggle.
- For SVG and PDF the Resolution row is hidden (vector output is resolution-independent).

### Batch export (multiple configs)

The `+` button in the Export panel header (`Add export config`) appends another export row. Each row has its own format, resolution, fit mode, and background. The `Export` button runs every row from a single click. Use this to ship, for example, PNG @1x, PNG @2x, and SVG together.

## Video export (MP4 / MOV)

Video export renders animated shader fills frame by frame into a hardware-accelerated file (macOS via VideoToolbox, Windows via Media Foundation; not on Linux). It is available **only from the Export panel** (no command, no shortcut, no context menu). Replay is the exception.

Flow: select elements, choose MP4 or MOV in the format dropdown, configure the inline video options, click `Export`, then save. A progress bar shows "Frame X / Y" and can be cancelled.

| Option | Values | UI default |
|--------|--------|------------|
| **Duration** | 0.5 to 60s (draggable + preset dropdown) | 10s |
| **FPS** | 15, 24, 30, 60 | 60 |
| **Quality** | Low, Medium, High | Medium |
| **Resolution** | Same presets as image export | Original (1x) |

Codecs are constrained by format: MP4 offers H.264 and HEVC (no alpha); MOV offers HEVC (alpha) and ProRes 4444 (alpha, largest files). The codec dropdown adjusts automatically when you switch format. Only MOV with HEVC-with-alpha or ProRes 4444 supports a transparent background; MP4 always renders opaque (falls back to canvas color). On Windows only H.264/MP4 is available: no HEVC, no MOV, no alpha (the codec dropdown is fixed at H.264).

Video currently animates shader fills only (metaballs, liquid metal, holographic, etc.). Static elements look identical in every frame. There is no keyframe-timeline animation.

### Replay export

Replay is a one-click animated reveal of the current selection: each element fades in one after another with a shimmer pass. It defaults to MP4, but you can switch the container to MOV (required if you want a transparent background). Run it from the command palette (`Export to Replay`) or the right-click `Export as → Replay` (both render at 2x scale for crisp retina output), or the Export panel (which follows the panel resolution, default 1x).

| Option | Values | Default |
|--------|--------|---------|
| **Container** | MP4, MOV | MP4 |
| **Codec** | H.264, HEVC, ProRes 4444 (filtered by container) | H.264 |
| **Quality** | Low, Medium, High | Medium |
| **Pacing (ms per element)** | 10, 25, 50, 75, 100, 150, 200, 250, 300, 400 (presets) or a custom value | 150ms |
| **Intro text** | Optional short text card shown before the reveal | none |
| **Resolution** | Same presets as image/video export | Original (1x) |
| **Background** | Transparent (MOV + HEVC/ProRes only) or Canvas | Transparent |

Total duration is derived automatically from pacing times element count (there is no separate duration field).

## PDF multi-page

PDF is the one format with a multi-page mode (Export panel only). Use the inline **Pages** dropdown next to the PDF format pill to switch single-page vs multi-page.

- **Single-page (default):** the whole selection on one page sized to its bounding box.
- **Multi-page:** one page per top-level frame in the selection. If the selection has frames, loose top-level elements are ignored; if there are zero frames, each loose top-level element becomes a page.
- **Page order:** defaults to canvas reading order (top to bottom, left to right). The settings panel (gear button) shows the page list; drag rows to reorder.
- **Per-page include toggle:** the settings panel has a checkbox per page to exclude individual frames without deselecting them.

Multi-page is a per-config-row setting, so a single batch click can ship a single-page and a multi-page PDF together.

## Separate files (multi-selection, PNG/JPEG/WebP/SVG)

When you select **two or more frames** (or other top-level elements) and export a raster format (PNG/JPEG/WebP) or SVG, Brilliant exports **one file per selected element by default** rather than merging them into a single image, the same behavior as Figma.

- A **Files** dropdown appears (Separate files / Single file) whenever a raster or SVG export has 2+ export targets. For SVG it sits inline next to the format pill; for raster it's the first row inside the settings panel (gear button). It defaults to **Separate files**.
- Pick **Single file** to go back to the old behavior: the whole selection rendered into one merged image.
- **Desktop:** exporting separate files asks for one destination **folder** (a single pick for the whole batch); each element is written into it. Files with the same name get `-2`, `-3`, … suffixes.
- **Web:** the files are bundled into a single **zip** download.
- Nesting: a selected element inside another selected frame is exported as part of that frame, not as its own file. Only "selection roots" (selected elements with no selected ancestor) become files.
- SVG and PDF are separate concerns: PDF uses its multi-page mode; raster/SVG use this separate-files mode.

## Copy to clipboard (Copy as)

Copy the selection to the clipboard in several representations. Useful for pasting into code editors, docs, other design tools, or chat. Reach these from the command palette or the right-click `Copy as` submenu.

| Command | What it copies |
|---------|----------------|
| Copy as PNG | PNG image at screen resolution (device pixel ratio) |
| Copy as WebP | WebP image, lossy q=90 (macOS and Windows; Linux falls back to PNG). Narrow app support, prefer PNG |
| Copy as SVG | SVG markup text |
| Copy as HTML | HTML/CSS snippet (auto-layout frames absolute-positioned) |
| Copy as HTML (document) | Self-contained HTML document with Google Fonts link for detected web fonts |
| Copy as HTML (flex) | HTML where auto-layout frames emit `display:flex` + gap + padding |
| Copy as React | React JSX snippet (camelCase style object and SVG attrs) |
| Copy as CSS | CSS properties (size, position, colors, border, radius, rotation, text) |
| Copy as Blueprint | Brilliant's native element format, lossless with full hierarchy; pasteable back into Brilliant or shared with AI tools |

The right-click `Copy as` submenu contains: PNG, PNG @2x, PNG @4x, WebP, SVG, HTML, React, CSS, Blueprint. The @2x / @4x entries multiply the PNG scale for higher-resolution clipboard output.

Clipboard notes:
- **PNG** copies at device pixel ratio so what you see on screen matches what you paste (WYSIWYG). @2x / @4x multiply that.
- **WebP** is written under the `org.webmproject.webp` UTI on macOS, or as a `.webp` file to the clipboard on Windows (Linux falls back to PNG). Most apps prefer PNG when both are offered, so use `Copy as PNG` for general pasting. Always lossy q=90 on this path.
- **CSS** emits the first solid fill and first solid stroke only; corner radius only for frames (not rectangle elements); only `linear-gradient` (any gradient fill, including radial, is emitted as a linear-gradient, so radial gradients render incorrectly rather than being omitted); no opacity, effects, or image fills.

## MCP export tool (for AI agents)

AI agents can export programmatically via the MCP `export` tool. It handles raster (PNG, JPEG, WebP), vector (SVG, PDF), HTML/React markup, and video (MP4, MOV: use `duration`, up to 30s, and `fps`). Only **Replay** is UI/command only (it needs an interactive recording session, so the tool returns a clear error). For UI mockups exported as WebP, pass `webpLossless: true` to avoid q=90 banding. The full parameter schema is delivered with the tool itself.

## When rendering has stopped

Every export renders through the canvas engine, so if the engine stops for the session (the canvas shows the "Something went wrong rendering the canvas" panel), exports refuse instead of producing files. You get a clear message naming the state, and the fix is the panel's own **Restart rendering** button. Once the canvas is back, export again. This applies to every format, to Copy as PNG/WebP, to video and replay, and to the MCP `export` tool, which answers with the same reason. Retrying the export without restarting rendering will keep refusing, by design: it prevents empty or half-drawn files that look like real output.

On some machines rendering can't start at all because the computer's graphics hardware isn't supported or its graphics driver is out of date. The canvas then shows a distinct panel ("Brilliant can't render on this graphics hardware") rather than the transient one, and **Restart rendering** won't bring it back until the driver is updated (or the file is opened on a machine with a supported GPU). Exports refuse the same way in that state, so there's nothing productive to retry until the underlying graphics issue is resolved. The panel's **Report** button copies a diagnostic signature (the failure detail, the graphics backend, and the OS) to share in a support conversation.

## Other application formats

| Format | Import | Export | Notes |
|--------|--------|--------|-------|
| **.sketch** (Sketch) | Yes | Yes | Import via "Import Sketch File" (command palette), with page selection in the right toolbar. Export via "Save as Sketch File" (command palette) |
| **.fig / Figma** | Via Figma URL (API) or the plugin (paste) | Via "Send to Figma" (live plugin) | "Import from Figma" opens the import section in the right toolbar to paste a Figma URL (OAuth). Does not import `.fig` files directly. "Send to Figma" pushes the selection to the paired Brilliant Figma plugin. See "Send to Figma fidelity" below |

### Send to Figma fidelity

Sending the selection to the paired Brilliant Figma plugin round-trips most of a design as native, editable Figma objects, not a flat image:

- Design-system tokens become Figma variable collections (per brand and mode) with colors, spacing, and numerics bound onto the nodes; typography and shadow tokens become Figma text and effect styles.
- Components and instances rebuild as Figma components, with instance overrides reapplied (fills, strokes, effects, opacity, corner radii, and text).
- Auto layout (including wrap and its cross-axis gap), per-side borders, dashes, masks, boolean shapes, tiled and cropped images, text case, strikethrough, vertical alignment, and liquid glass all map to their Figma equivalents.
- Hidden elements ship as hidden. Variant names with reserved characters are sanitized automatically.

Fills that Figma can't express (shader fills and image-filter fills) are pre-rasterized to an image so they still look right, and are no longer editable as parameters on the Figma side.

Known gap: component boolean, text, and instance-swap properties do not transfer in either direction. Variant properties transfer fully; the other property kinds arrive as their current baked state.
| **.ai** (Illustrator) | No | No | Bridge through SVG: export from Illustrator as SVG, then import |
| **.psd** (Photoshop) | No | No | Export Photoshop layers as PNG, then import as images |

## Import

### Images

| Action | How |
|--------|-----|
| Import file | **Cmd+Shift+O** or command palette "Import" (images, SVG, and `.bl` design files) |
| Paste from clipboard | **Cmd+V** with an image on the clipboard |
| Drag and drop | Drag image files onto the canvas |
| Import from Figma | Command palette "Import from Figma" (opens the import section in the right toolbar; paste a Figma URL) |

Supported image formats: PNG, JPEG, GIF, BMP, WebP. On macOS also TIFF, HEIC, HEIF, AVIF (converted natively). Imported images become rectangle elements with an image fill, placed at the canvas center.

### SVG

| Action | How |
|--------|-----|
| Import SVG file | **Cmd+Shift+O** (select a `.svg` file) or command palette "Import SVG" |
| Paste SVG markup | **Cmd+V** with SVG text on the clipboard |

SVG import creates native Brilliant elements: rectangles become rectangles, circles/ellipses become circles, paths become vectors, groups become frame parents with children, text becomes text. Fills, strokes, and transforms are preserved. Imported elements are centered and selected. Icons and simple illustrations import cleanly; complex SVGs may need cleanup.

### Sketch

Command palette "Import Sketch File" opens the Sketch import section in the right toolbar where you browse for a `.sketch` file. After parsing, a page selection UI lets you pick which pages to import. Each chosen page becomes a separate canvas with its elements converted to native Brilliant elements.

### Design files (`.bl`)

**Cmd+Shift+O** and selecting a `.bl` file (or legacy `.design`) imports it. Native design files are copied (with their referenced images) into an `Imports/` folder in the current workspace, registered as a new canvas, and switched to. Legacy compressed-JSON Save As files are decompressed and imported the same way. Both require an open workspace.

### Paste behavior

**Cmd+V** detects clipboard content and handles, in order: Brilliant elements (full hierarchy, same or cross-canvas), image data (becomes a rectangle with image fill), SVG markup, Figma JSON (from the Brilliant Figma plugin), Brilliant YAML, Brilliant Blueprint, HTML (converted to native elements), and finally plain text (becomes a text element).

## Tips

- `Cmd+E` runs PNG export with a save dialog (the only export shortcut).
- `Copy as PNG` copies at device pixel ratio for WYSIWYG paste; use `Copy as → PNG @2x / @4x` for higher resolution.
- Copied images contain the design only — never selection handles, guides, labels, or presence cursors. If a copy can't produce the image (e.g. the renderer is momentarily unavailable), a warning says the system clipboard was not updated — whatever you paste then is your previous clipboard content, not this copy.
- For pixel-clean UI mockups, prefer PNG over WebP: the by-hand UI exports lossy q=90 WebP, which bands on rounded corners and gradients.
- `Copy as SVG` is good for pasting vector art into web projects or other design tools.
- The `+` button in the Export panel batches multiple configs (PNG @1x, PNG @2x, SVG) into one click.
- Right-click `Export as → Replay` runs at 2x by default for crisp retina output.

## Related

- [canvases.md](./canvases.md): Canvas management and file operations
- [styling.md](./styling.md): Fills, strokes, and visual properties
- [crop.md](./crop.md): Image crop mode
- [effects.md](./effects.md): Shadows, glows, blurs, and color-adjust
- [shaders.md](./shaders.md): Animated shader fills (the only thing video export animates)
