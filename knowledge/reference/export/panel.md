---
name: "knowledge-export-panel"
description: "The right toolbar Export panel: format, resolution, size, fit, background, batch export, and PDF multi-page."
assumes: reference/export
---

# Export Panel Options (right toolbar)

The Export panel appears when elements are selected. With nothing selected it also shows, last in the panel, and exports the whole canvas as one image: its configs belong to the canvas, `+` adds PNG 1x, and MP4, MOV and Replay are not offered (`reference/ui/inspector-sections`).

| Option | Values | Default |
|--------|--------|---------|
| **Format** | PNG, JPEG, WebP, SVG, PDF, HTML, React (JSX), MP4, MOV, Replay. Choosing HTML reveals a **Variant** dropdown (`Page`, `Snippet`, `Flexbox`) | PNG |
| **Resolution** | `Original (1x/2x/3x/4x)`, `720p`, `1080p`, `1440p`, `4K`, `8K`, `Portrait Post · IG, FB` (1080x1350), `Square Post · IG, X` (1080x1080), `Story / Reel · IG, TikTok` (1080x1920), `iPhone 16 Pro` (1206x2622), `MacBook Pro 14"` (3024x1964), `Custom`. Hidden for vector formats (SVG, PDF) | `Original (1x)` |
| **Width / Height** | Target pixel size for raster/video. Set one to scale proportionally, or both with a fit mode for exact size | none |
| **Fit mode** | `Fit` (letterbox), `Fill` (crop), `Stretch` (non-uniform), `Repeat` (1:1 tiled). Only used when both width and height are set | `Fit` |
| **Background** | `Transparent`, `Canvas` (canvas background color) | `Transparent` |

Notes:
- **`Original` snaps to whole pixels.** The export region is aligned outward to the output pixel grid, so a selection whose bounds are fractional (a text box measured from font metrics, a drop shadow's soft edge, a shape nudged off a whole coordinate) exports one pixel wider or taller rather than being rendered at a slightly-off scale. That is what keeps pixel-aligned geometry crisp at 1x instead of anti-aliased; the extra row/column is export background. The `Width`/`Height` fields show the size you will actually get.
- **Small text always renders in raster exports.** A whole-document export at a small scale draws every text, even text only a pixel or two tall, where the zoomed-out canvas may skip it for speed.
- JPEG and MP4 have no alpha: a Transparent request falls back to Canvas. PNG and MOV (HEVC-with-alpha or ProRes 4444) keep alpha.
- The UI ships JPEG at quality 90 with no slider, and WebP as lossy q=90 with no lossless toggle.
- For SVG and PDF the Resolution row is hidden (vector output is resolution-independent).

## Batch export (multiple configs)

The `+` button in the Export panel header (`Add export config`) appends another export row. Each row has its own format, resolution, fit mode, and background. The `Export` button runs every row from a single click. Use this to ship, for example, PNG @1x, PNG @2x, and SVG together.

## PDF multi-page

PDF is the one format with a multi-page mode. In the Export panel, use the inline **Pages** dropdown next to the PDF format pill to switch single-page vs multi-page.

- **Single-page (default):** the whole selection on one page sized to its bounding box.
- **Multi-page:** one page per top-level frame in the selection. If the selection has frames, loose top-level elements are ignored; if there are zero frames, each loose top-level element becomes a page.
- **Page order:** defaults to canvas reading order (top to bottom, left to right). The settings panel (gear button) shows the page list; drag rows to reorder.
- **Per-page include toggle:** the settings panel has a checkbox per page to exclude individual frames without deselecting them.

Multi-page is a per-config-row setting, so a single batch click can ship a single-page and a multi-page PDF together.

Agents: `export` with `pages` (element ids, #refs or canvas paths, on any canvas) writes one PDF with one page per item, in order (`canvasId` is optional there, since each item names its canvas); every PDF export answers its page count, and several ids without `pages` share one page.
