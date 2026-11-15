---
name: "knowledge-image-filters-posterize"
description: "The Posterize filter: parameters, modes, and presets."
assumes: reference/image-filters
---

# Posterize

Reduce color levels for poster-style banding.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Levels** | 2–32 | 4 | Discrete color levels per channel (2 = B&W, 4 = 64 colors in RGB mode) |
| **Mode** | RGB / Luminosity / HSL | RGB | Quantization method |
| **Smoothing** | 0–1 | 0 | Transition smoothness between levels (0 = hard steps) |
| **Intensity** | 0–100 | 100 | Blend posterized result with original |
| **Gamma** | 0.2–5 | 1.0 | Gamma curve before quantization |

Colors: none.

**Modes:**
- **RGB**: Quantize each R, G, B channel independently
- **Luminosity**: Quantize luminance only, preserve original hue/saturation
- **HSL**: Quantize hue, saturation, and lightness independently

## Presets

| Preset | Group |
|--------|-------|
| Pop Art | Style |
| Silhouette | Style |
| Smooth Poster | Style |
| High Contrast | Tone |
| Washed Out | Tone |
| Subtle | Tone |
| Luminosity | Mode |
| HSL Poster | Mode |
