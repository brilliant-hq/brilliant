---
name: "knowledge-shaders-animation-export"
description: "Shader animation, combining shaders with other fills, and how shaders export."
assumes: reference/shaders
---

# Shader Animation and Export

## Animation

- Shader fills animate by default.
- Toggle animation for a single fill with the play/pause button in its expanded view (this is the per-element "Toggle Shader Animation" command).
- The **Speed** slider controls the rate (0 = frozen in place, not reset).
- To globally pause or resume *all* shader animations across the canvas, run **"Toggle Shader Animations"** from the palette. Neither toggle has a default keyboard shortcut.
- On a busy canvas (many shaders, or heavy zooming) Brilliant may automatically pause shader animations to keep the app fast. The first time this happens in a session a brief notice says *"Shader animations paused"* (*"Paused to keep the canvas fast. They come back on their own once it keeps up."*) with a **Resume animations** button; it clears itself after a few seconds and never parks on top of your canvas. The pause stays listed (in the new interface, under **Needs you** in the notifications panel, every time it happens, even when the notice stays quiet) until you resume. While the pause is in effect the **Toggle Shader Animations** control reads as off; running it, or pressing **Resume animations**, asks the engine to resume playing (it is not the same as your own manual pause) and clears the listing. Left alone, Brilliant also retries on its own; if the machine still can't keep up it pauses again.

## Combining with Other Fills

Shader fills stack with other fill types (solid, gradient, image, inner shadow, inner glow, background blur, color adjust, and image filters) on the same element. Fills render bottom-to-top in list order, so a semi-transparent shader over a solid fill produces layered effects. You can freely interleave shaders with effect and filter fills. See `reference/styling`, `reference/effects`, and `reference/image-filters`.

## Export Behavior

| Format | Shader output |
|--------|---------------|
| **PNG / JPEG / WebP** | Rendered at full quality, capturing the current animation frame. |
| **PDF** | Rasterized faithfully (the shaded element is embedded as a raster image), capturing the current frame. |
| **SVG** | **Pre-rasterized.** SVG cannot express fragment shaders, so an element carrying a shader fill or stroke is rasterized and embedded as a base64 image capturing the current frame. Only if rasterization data is unavailable does the export fall back to a flat solid fill (the shader's first color). Export to PNG if you need the procedural look at higher fidelity. |
| **MP4 / MOV** | Shader animation is captured frame by frame across the video. |

For export details across all formats see `reference/export`.
