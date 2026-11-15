---
name: "knowledge-export-formats"
description: "Every export format with its type and notes, WebP quality, and how text ranges with links and gradients export."
assumes: reference/export
---

# Export Formats

| Format | Type | Notes |
|--------|------|-------|
| **PNG** | Raster | Transparency supported. Default for `Cmd+E` |
| **JPEG** | Raster | No alpha. Transparent background auto-substitutes the canvas color. Quality 90 in the UI |
| **WebP** | Raster | Transparency supported. Native libwebp on macOS and Windows; Linux falls back to PNG bytes. UI exports lossy q=90 (see "WebP quality" below) |
| **SVG** | Vector | Fonts travel with the file: the faces your text uses embed as `@font-face` (self-contained, works offline and in `<img>`); a face that cannot embed falls to a Google Fonts `@import` and is named in the export warnings. Native filters for drop shadow, outer glow, layer blur. Shader fills, inner shadow/glow, background blur, color-adjust, and image-filter fills are embedded as rasterized PNG. Angular (sweep) gradients are approximated as linear |
| **PDF** | Vector | Embedded fonts (Google Fonts cache + system, Helvetica fallback; a Helvetica substitution names the family in the export warnings, never silent). Any element with an enabled effect is rasterized whole. Supports single-page or multi-page |
| **HTML** | Markup | HTML + inline CSS. Three variants: snippet, full document (with Google Fonts link), and flex (auto-layout frames become `display:flex`). Shader fills on rectangles, full circles, and frames export as LIVE animated WebGL `<canvas>` elements (one appended `<script>` carries the runtime + shader sources; `reactiveGrid` stays mouse-interactive). Shader fills on vectors, text, or strokes are embedded as rasterized PNG. Pictures (image fills) are resampled to the size they are drawn at, at 1x and 2x (an image-set the browser picks from), and a picture used several times is written once. Copy as HTML embeds them as data URIs; the agent `export` tool with an `outputPath` writes them as files under `images/` beside the page (pass `htmlImages: "inline"` to embed instead). Hidden layers and layers at 0% opacity are left out (`htmlKeepInvisible: true` keeps a 0% layer at opacity 0, for markup you animate); dashed strokes stay dashed; a text clamped to N lines ends in an ellipsis. Apple system fonts (SF Pro, SF Compact, SF Mono, New York) carry a web fallback (`system-ui, -apple-system, Inter`); the full document asks Google Fonts only for families Google serves, plus Inter as the SF Pro stand-in. Palette / Copy as only |
| **React (JSX)** | Markup | Same DOM as the HTML flex variant, JSX style objects, camelCase attrs. Pasteable into a `.tsx` file. Auto-layout frames become `display:flex` + gap + padding. Colours bound to a design-system token become CSS variables (`var(--color-primary)`), declared by a `<style>` element inside the component: `:root` holds the values for the design's brand and mode, and each other mode used in the selection gets a `[data-bl-mode="..."]` block with the matching attribute on its elements. To switch a subtree to another mode, set that `data-bl-mode` value on it, or define the same variables in your own stylesheet. Unbound colours stay hex. Shader fills are embedded as rasterized PNG (a bare JSX snippet has no script slot). Palette / Copy as only |
| **MP4** | Video | No alpha. macOS: H.264 or HEVC (VideoToolbox). Windows: H.264 only (Media Foundation). Not available on Linux. By hand from the Export panel; agents on the desktop app export it with the `export` tool |
| **MOV** | Video | HEVC (with alpha) or ProRes 4444. macOS only (Windows has no QuickTime writer; Linux has no video export), supports transparent background. By hand from the Export panel; agents on the desktop app export it with the `export` tool |
| **Replay** | Video | Animated reveal: elements fade in one after another with a shimmer pass. Defaults to MP4 (macOS and Windows); MOV is selectable on macOS (required for a transparent background). Has a command and a context-menu entry |

MP4 export runs on macOS (VideoToolbox, H.264/HEVC) and Windows (Media Foundation, H.264 only). MOV and its alpha-capable codecs are macOS only. Linux and the web editor have no video export. Replay follows the same rules as its chosen container (MP4 on macOS and Windows; MOV on macOS).

## WebP quality

The Export panel and the `Copy as WebP` command both produce lossy WebP at quality 90. For UI mockups (cards, panels, gradients, rounded corners), lossy q=90 leaves visible gray banding on rounded edges and color ramps. For pixel-clean UI mockups, prefer **PNG**. Lossless WebP is not exposed in the by-hand UI in this build (it is only reachable programmatically via the MCP `export` tool with `webpLossless: true`).

## Text ranges: hyperlinks and gradients

**Text stays text everywhere possible.** Non-gradient text ranges export as real text in every lane.

- **A gradient on a text range** now carries in every format.
  - **PNG/JPEG/WebP** read back the live canvas exactly as on screen.
  - **SVG** and **PDF** on desktop outline just the gradient-filled glyphs to vector paths filled with the gradient (Figma's own move), keeping every other character as real text.
  - **SVG** and **PDF** in the web app keep the gradient range as real text filled with the gradient (a gradient-filled `<tspan>` in SVG, a gradient text fill in PDF), so the glyphs stay selectable and searchable.
  - **HTML/React** paint the span with `background-clip:text` (a real, selectable text span; exact and resolution-independent).
  There is no silent fall to the base text color or to a single gradient color in any lane.
- **A hyperlink on a text range** exports as a real anchor in **HTML** (`<a href>`) and **SVG** (`<a xlink:href>`). **PDF** and the raster formats (**PNG/JPEG/WebP**) do not carry a clickable link (the PDF exporter draws glyphs, not link annotations), so linked text exports as ordinary styled text (a named, reported boundary).

So gradient-filled text now survives every export lane; HTML and SVG additionally keep the links.

## Right-to-left text

**Right-to-left text (Hebrew, Arabic) exports in reading order.** **PDF** draws each line in its visual order, with brackets mirrored the way the canvas shows them, so the text reads correctly in every PDF viewer; **SVG** marks RTL text `direction="rtl"` so the viewer orders it, and an imported SVG keeps the direction and alignment. Every wrapped line survives in both, bulleted and numbered list markers carry in SVG and PDF at every alignment (on the right for RTL), and invisible direction marks never draw as boxes.
