---
name: "knowledge-image-filters-noise"
description: "The Noise / Grain filter: parameters and presets."
assumes: reference/image-filters
---

# Noise / Grain

Film-like grain overlay. The grain composites onto the content below it; the filter row's blend mode dropdown controls how the whole filter output blends with content below.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Amount** | 0–1 | 0.3 | Noise intensity (0 = none, 1 = maximum grain) |
| **Size** | 0.5–8 | 1.5 | Grain particle size in logical pixels |
| **Monochrome** | Color / Mono | Mono | Color noise (RGB) vs grayscale noise |
| **Distribution** | Uniform / Gaussian | Uniform | Random distribution shape |
| **Roughness** | 0–1 | 0 | 0 = structured/quantized grain, 1 = per-pixel organic film grain |
| **Midtone Bias** | 0–100 | 0 | Concentrate noise in midtones (0 = uniform, 100 = peaks at 50% gray) |

Colors: none.

## Presets

| Preset | Group |
|--------|-------|
| Film Grain | Classic |
| Heavy Grain | Classic |
| Subtle Texture | Classic |
| Color Noise | Color |
| VHS Static | Color |
| Gritty | Style |
| Gaussian Film | Style |
| Midtone Grain | Style |
