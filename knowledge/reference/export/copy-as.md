---
name: "knowledge-export-copy-as"
description: "The Copy as commands and what each puts on the clipboard."
assumes: reference/export
---

# Copy to clipboard (Copy as)

Copy the selection to the clipboard in several representations. Useful for pasting into code editors, docs, other design tools, or chat. Reach these from the palette or the right-click `Copy as` submenu.

| Command | What it copies |
|---------|----------------|
| Copy as PNG | PNG image at screen resolution (device pixel ratio) |
| Copy as WebP | WebP image, lossy q=90 (macOS and Windows; Linux falls back to PNG). Narrow app support, prefer PNG |
| Copy as SVG | SVG markup text |
| Copy as HTML | HTML/CSS snippet (auto-layout frames absolute-positioned) |
| Copy as HTML (document) | Self-contained HTML document with Google Fonts link for detected web fonts |
| Copy as HTML (flex) | HTML where auto-layout frames emit `display:flex` + gap + padding |
| Copy as React | React JSX snippet (camelCase style object and SVG attrs, flexbox for auto layout, CSS variables for token colours) |
| Copy as CSS | CSS properties (size, position, colors, border, radius, rotation, text) |
| Copy as Blueprint | Brilliant's native element format, lossless with full hierarchy; pasteable back into Brilliant or shared with AI tools |

The right-click `Copy as` submenu contains: PNG, PNG @2x, PNG @4x, WebP, SVG, HTML, React, CSS, Blueprint. The @2x / @4x entries multiply the PNG scale for higher-resolution clipboard output.

Clipboard notes:
- **PNG** copies at device pixel ratio so what you see on screen matches what you paste (WYSIWYG). @2x / @4x multiply that.
- **WebP** is written under the `org.webmproject.webp` UTI on macOS, or as a `.webp` file to the clipboard on Windows (Linux falls back to PNG). Most apps prefer PNG when both are offered, so use `Copy as PNG` for general pasting. Always lossy q=90 on this path.
- **CSS** emits the first solid fill and first solid stroke only; corner radius only for frames (not rectangle elements); only `linear-gradient` (any gradient fill, including radial, is emitted as a linear-gradient, so radial gradients render incorrectly rather than being omitted); no opacity, effects, or image fills.
