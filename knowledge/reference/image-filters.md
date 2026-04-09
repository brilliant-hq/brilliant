---
name: "knowledge-image-filters"
description: "GPU image filter fills — noise/grain, halftone, pixelate, duotone, posterize, dither — with full parameter reference."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Image Filters

GPU-powered post-processing filters applied as fill or stroke types. Each filter processes all fills below it in the z-order, producing effects like film grain, halftone printing, pixelation, and color reduction.

**Adding a filter:** Click "+" in the Fills or Strokes section, then use the type dropdown to select a filter from the **Filters** category.

**Z-order processing:** A filter captures everything below it in the fill/stroke list, applies the GPU shader, and renders the result. Fills above the filter render on top of the processed output. Multiple filters can be stacked — each processes everything below it.

**Presets:** Every filter type has a preset dropdown in the expanded fill view. Selecting a preset applies a curated combination of parameter values (and colors where applicable). You can further customize after applying a preset. A reset button next to the dropdown restores the filter's defaults.

---

## Noise / Grain

Film-like grain overlay. The grain is internally composited using overlay blend mode within the shader. A separate fill-level blend mode dropdown controls how the filter output blends with content below.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Amount** | 0–1 | 0.3 | Noise intensity (0 = none, 1 = maximum grain) |
| **Size** | 0.5–8 | 1.5 | Grain particle size in logical pixels |
| **Monochrome** | Color / Mono | Mono | Color noise (RGB) vs grayscale noise |
| **Distribution** | Uniform / Gaussian | Uniform | Random distribution shape |
| **Roughness** | 0–1 | 0 | 0 = structured/quantized grain, 1 = per-pixel organic film grain |
| **Midtone Bias** | 0–1 | 0 | Concentrate noise in midtones (0 = uniform, 1 = peaks at 50% gray) |

Colors: none.

### Presets

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

---

## Halftone

Classic print halftone dots with standard and CMYK modes.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Mode** | Standard / CMYK | Standard | Standard uses 2 colors; CMYK uses 4 ink channels + paper |
| **Dot Size** | 1–50 | 8 | Halftone dot size in logical pixels |
| **Angle** | 0–360° | 45° | Grid rotation angle |
| **Shape** | Circle / Diamond / Line | Circle | Dot shape within each cell |
| **Grid** | Square / Hex | Square | Cell arrangement pattern |
| **Contrast** | 0–1 | 0.5 | Luminance contrast applied before dot sizing |
| **Inverted** | 0–1 | 0 | Invert luminance (0 = normal, 1 = inverted, continuous blend) |
| **Colors** | Custom / Original | Custom | Use custom colors or original image colors |
| **Softness** | 0–1 | 0 | Dot edge softness (0 = hard, 1 = blurred) |
| **Gain** | 0–2 | 1.0 | Dot radius multiplier (>1 = dots overflow cells, creating overlap patterns) |
| **Min Dot** | 0–0.5 | 0.15 | Minimum dot size in highlights (prevents white gaps) |

**Colors:** 6 in the data model. The UI shows a subset depending on mode and settings:

- **Standard + Custom colors:** Background (0) + Foreground (1) = 2 swatches
- **Standard + Original colors:** Background (0) only = 1 swatch
- **CMYK:** Paper (0) + Cyan (2) + Magenta (3) + Yellow (4) + Black (5) = 5 swatches

| Index | Standard | CMYK | Default |
|-------|----------|------|---------|
| 0 | Background | Paper | #F2F1E8 (cream) |
| 1 | Foreground | (hidden) | #2B2B2B (dark gray) |
| 2 | -- | Cyan | #1ABAED |
| 3 | -- | Magenta | #E8558A |
| 4 | -- | Yellow | #F5D623 |
| 5 | -- | Black | #2A2725 |

**CMYK mode** renders 4 rotated dot layers (C=15deg, M=75deg, Y=0deg, K=45deg) with subtractive color mixing, mimicking real print output.

### Presets

| Preset | Group |
|--------|-------|
| Newspaper | Standard |
| Comic Book | Standard |
| Fine Print | Standard |
| Diamond Grid | Standard |
| Scanlines | Standard |
| Hex Pattern | Standard |
| Soft Dots | Standard |
| Inverted | Standard |
| CMYK Classic | CMYK |
| CMYK Large | CMYK |
| CMYK Fine | CMYK |
| CMYK High Contrast | CMYK |

---

## Pixelate

Mosaic pixelation with multiple cell shapes.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Cell Size** | 2–300 | 10 | Pixel cell size in logical pixels |
| **Shape** | Square / Hexagonal / Diamond / Circle / Triangle | Square | Cell shape |
| **Angle** | 0–360° | 0° | Grid rotation |
| **Stretch** | 0.5–2 | 1.0 | Horizontal cell stretch (0.5 = tall, 2 = wide) |
| **Outline** | 0–1 | 0 | Cell grid outline intensity (0 = invisible, 1 = strong edges) |
| **Smoothing** | 0–1 | 0 | Edge smoothing between cells (0 = hard, 1 = blurred) |

Colors: none.

### Presets

| Preset | Group |
|--------|-------|
| 8-bit Retro | Square |
| Mosaic | Square |
| Soft Pixels | Square |
| Hex Grid | Pattern |
| Stained Glass | Pattern |
| Diamond Tiles | Pattern |
| Pointillism | Circle |
| Rotated Grid | Square |
| Wide Bars | Square |

---

## Duotone

Two-tone or tri-tone color mapping based on luminance.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Contrast** | -1 to 1 | 0 | Luminance contrast before tone mapping |
| **Brightness** | -1 to 1 | 0 | Luminance brightness shift |
| **Intensity** | 0–1 | 1.0 | Effect strength (0 = original image, 1 = full duotone) |
| **Midpoint** | 0.1–3 | 1.0 | Midpoint curve (<1 = highlight bias, >1 = shadow bias) |
| **Saturation** | 0–1 | 0 | Preserve original color saturation in the output |
| **Tri Midpoint** | 0.1–0.9 | 0.5 | Tritone midpoint position (where midtone color sits) |

**Colors:** 3 (2 required + 1 optional tritone).

| Index | Purpose | Default |
|-------|---------|---------|
| 0 | Shadow/dark color | #1A1A2E (dark blue) |
| 1 | Highlight/light color | #E94560 (coral) |
| 2 | Midtone (tritone) | Transparent (disabled) |

**Tritone mode** activates when the third color (index 2) has alpha > 0. Luminance below the midpoint interpolates dark-to-mid; above interpolates mid-to-light.

Per-color alpha controls tint strength (how much that color contributes vs the original image).

### Presets

| Preset | Group |
|--------|-------|
| Midnight & Rose | Warm |
| Sepia Tone | Warm |
| Sunset Glow | Warm |
| Cyberpunk | Cool |
| Ocean Depths | Cool |
| Vintage Film | Style |
| Tritone Warm | Tritone |
| Tritone Cool | Tritone |

---

## Posterize

Reduce color levels for poster-style banding.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Levels** | 2–32 | 4 | Discrete color levels per channel (2 = B&W, 4 = 64 colors in RGB mode) |
| **Mode** | RGB / Luminosity / HSL | RGB | Quantization method |
| **Smoothing** | 0–1 | 0 | Transition smoothness between levels (0 = hard steps) |
| **Intensity** | 0–1 | 1.0 | Blend posterized result with original |
| **Gamma** | 0.2–5 | 1.0 | Gamma curve before quantization |

Colors: none.

**Modes:**
- **RGB** -- Quantize each R, G, B channel independently
- **Luminosity** -- Quantize luminance only, preserve original hue/saturation
- **HSL** -- Quantize hue, saturation, and lightness independently

### Presets

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

---

## Dither

Ordered dithering patterns for retro/print effects.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Levels** | 2–16 | 4 | Output color levels |
| **Matrix** | 2x2 / 4x4 / 8x8 | 4x4 | Bayer matrix size |
| **Pattern** | Bayer / Noise / Blue Noise | Bayer | Dither algorithm |
| **Pixel Size** | 1–50 | 1 | Upscaling factor for pattern (4 = 4x4 pixel groups) |
| **Contrast** | 0–1 | 0.5 | Dither threshold intensity |
| **Brightness** | -1 to 1 | 0 | Luminance offset before dithering |
| **Colors** | Custom / Original | Original | Two-color mode or preserve original colors |

**Colors:** 2 (only visible in the UI when Colors is set to Custom; hidden when set to Original).

| Index | Purpose | Default |
|-------|---------|---------|
| 0 | Background/dark color | #1A1A2E |
| 1 | Foreground/light color | #E8E8E8 |

When **Colors** is set to Custom, the filter maps luminance to the two selected colors. When set to Original (default), the dither pattern is applied to the source image colors directly and no color swatches are shown.

### Presets

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

---

## Adding Filters via Commands

Use the command palette (Cmd+Shift+P) to add filters by name:

| Command | ID | Description |
|---------|-----|-------------|
| Add Noise / Grain | `add_noise_grain_fill` | Adds noise/grain filter fill with defaults |
| Add Halftone | `add_halftone_fill` | Adds halftone filter fill with defaults |
| Add Pixelate | `add_pixelate_fill` | Adds pixelate filter fill with defaults |
| Add Duotone | `add_duotone_fill` | Adds duotone filter fill with defaults |
| Add Posterize | `add_posterize_fill` | Adds posterize filter fill with defaults |
| Add Dither | `add_dither_fill` | Adds dither filter fill with defaults |

---

## General Notes

- **Stable across zoom** -- Filter patterns use logical coordinates, so grain/dot/cell sizes remain consistent as you zoom in and out
- **Export** -- PNG/JPEG/WebP capture the filter at full quality. SVG and PDF pre-rasterize filters as embedded PNG images
- **Stacking** -- Multiple filters can be stacked on one element; each processes all fills below it
- **Strokes** -- All filters work identically on strokes (applied to the stroke's rendered area)
- **Per-color alpha** -- For filters with color inputs, each color's alpha controls its tint strength (contribution vs original), not output transparency
- **Blend mode** -- Every image filter has a fill-level blend mode dropdown in the expanded view, controlling how the filter output composites with content below
