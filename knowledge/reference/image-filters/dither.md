---
name: "knowledge-image-filters-dither"
description: "The Dither filter: parameters, color swatches, and presets."
assumes: reference/image-filters
---

# Dither

Ordered dithering patterns for retro/print effects.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Levels** | 2–16 | 4 | Output color levels |
| **Matrix** | 2x2 / 4x4 / 8x8 | 4x4 | Bayer matrix size |
| **Pattern** | Bayer / Noise / Blue Noise | Bayer | Dither algorithm |
| **Pixel Size** | 1–50 | 1 | Upscaling factor for pattern (4 = 4x4 pixel groups) |
| **Contrast** | 0–1 | 0.5 | Dither threshold intensity |
| **Brightness** | -100 to 100 | 0 | Luminance offset before dithering |
| **Colors** | Custom / Original | Original | Two-color mode or preserve original colors |

**Color swatches:** two, shown only when the **Colors** parameter is set to Custom (hidden when set to Original).

| Role | Default |
|------|---------|
| Background / dark color | #1A1A2E |
| Foreground / light color | #E8E8E8 |

When **Colors** is set to Custom, the filter maps luminance to the two selected colors. When set to Original (the default), the dither pattern is applied to the source colors directly and no swatches are shown.

## Presets

| Preset | Group |
|--------|-------|
| 1-bit Classic | Retro |
| Retro Game | Retro |
| Newsprint | Style |
| Fine Grain | Style |
| Hi-Res Dither | Style |
| Noise Dither | Noise |
| Blue Noise | Noise |
| Chunky Pixels | Retro |
