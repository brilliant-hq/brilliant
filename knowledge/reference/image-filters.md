---
name: "knowledge-image-filters"
description: "GPU image-filter fills (noise/grain, halftone, pixelate, duotone, posterize, dither): how to add and tune them in the UI, with full parameter and preset reference."
---

# Image Filters

GPU post-processing filters that live in the Fills (or Strokes) list of an element. Each filter reprocesses everything painted below it in that list, producing effects like film grain, halftone printing, pixelation, and color reduction. They work on any fills (solid, gradient, image, shader), not just photos.

The six image filters are: **Noise / Grain**, **Halftone**, **Pixelate**, **Duotone**, **Posterize**, **Dither**.

## Adding a filter (UI)

1. Select an element.
2. In the right toolbar's **Fills** section (or **Strokes** section), click the **+** button to add a fill/stroke.
3. Click the fill's type dropdown (the leftmost control on the fill row). Scroll to the **Filters** group and pick a filter.

The new fill row now represents the filter. Click the row to expand it and reveal the filter's parameters, color swatches (for filters that use colors), preset dropdown, and blend mode.

## Z-order processing

A filter captures everything below it in the same fills/strokes list, applies the GPU shader, and outputs the result in that fill's slot. Fills above the filter paint on top of the processed output. To make a filter affect the whole element, place it at the top of the fills list. Multiple filters can be stacked: each processes everything below it. Reorder fills by dragging rows in the Fills section.

## Presets

When a filter fill is expanded, a preset dropdown appears at the top of its config. Hovering a preset previews it live; selecting one applies a curated combination of parameter values (and colors, for Duotone). You can keep tuning parameters after applying a preset. A reset control restores the filter's default parameters.

## Color Adjust

**Color Adjust** also appears in the Filters group of the type dropdown, but it is a photo-style adjustment layer (exposure, contrast, saturation, white balance, vignette, sepia, etc.), not a pattern filter. It is documented separately in [effects.md](./effects.md#color-adjust-fill).

---

## Noise / Grain

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
| **Inverted** | 0–100 | 0 | Invert luminance (0 = normal, 100 = inverted, continuous blend) |
| **Colors** | Custom / Original | Custom | Use custom colors or original image colors |
| **Softness** | 0–1 | 0 | Dot edge softness (0 = hard, 1 = blurred) |
| **Gain** | 0–2 | 1.0 | Dot radius multiplier (>1 = dots overflow cells, creating overlap patterns) |
| **Min Dot** | 0–0.5 | 0.15 | Minimum dot size in highlights (prevents white gaps) |

**Color swatches:** which swatches appear depends on Mode and the Colors setting:

- **Standard + Custom colors:** Background + Foreground (2 swatches)
- **Standard + Original colors:** Background only (1 swatch)
- **CMYK:** Paper + Cyan + Magenta + Yellow + Black (5 swatches)

| Role | Default |
|------|---------|
| Background / Paper | #F2F1E8 (cream) |
| Foreground (Standard only) | #2B2B2B (dark gray) |
| Cyan (CMYK) | #1ABAED |
| Magenta (CMYK) | #E8558A |
| Yellow (CMYK) | #F5D623 |
| Black (CMYK) | #2A2725 |

**CMYK mode** renders four rotated dot layers (Cyan 15deg, Magenta 75deg, Yellow 0deg, Black 45deg) with subtractive color mixing, mimicking real print output.

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
| **Contrast** | -100 to 100 | 0 | Luminance contrast before tone mapping |
| **Brightness** | -100 to 100 | 0 | Luminance brightness shift |
| **Intensity** | 0–100 | 100 | Effect strength (0 = original image, 100 = full duotone) |
| **Midpoint** | 0.1–3 | 1.0 | Midpoint curve (<1 = highlight bias, >1 = shadow bias) |
| **Saturation** | 0–100 | 0 | Preserve original color saturation in the output |
| **Tri Midpoint** | 0.1–0.9 | 0.5 | Tritone midpoint position (where midtone color sits) |

**Color swatches:** two required, plus an optional third for tritone. Use the **+** button on the filter row to add the third swatch.

| Role | Default |
|------|---------|
| Shadow / dark color | #1A1A2E (dark blue) |
| Highlight / light color | #E94560 (coral) |
| Midtone (tritone) | not present until added |

**Tritone mode** activates once a third (midtone) color is added with non-zero opacity. Luminance below the midpoint interpolates dark-to-mid; above it interpolates mid-to-light.

Each swatch's opacity controls how strongly it tints the result versus showing the original image.

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
| **Intensity** | 0–100 | 100 | Blend posterized result with original |
| **Gamma** | 0.2–5 | 1.0 | Gamma curve before quantization |

Colors: none.

**Modes:**
- **RGB**: Quantize each R, G, B channel independently
- **Luminosity**: Quantize luminance only, preserve original hue/saturation
- **HSL**: Quantize hue, saturation, and lightness independently

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
| **Brightness** | -100 to 100 | 0 | Luminance offset before dithering |
| **Colors** | Custom / Original | Original | Two-color mode or preserve original colors |

**Color swatches:** two, shown only when the **Colors** parameter is set to Custom (hidden when set to Original).

| Role | Default |
|------|---------|
| Background / dark color | #1A1A2E |
| Foreground / light color | #E8E8E8 |

When **Colors** is set to Custom, the filter maps luminance to the two selected colors. When set to Original (the default), the dither pattern is applied to the source colors directly and no swatches are shown.

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

## Adding filters via the command palette

Open the command palette with Cmd+Shift+P and search for the filter name. Each command adds that filter as a new fill (with defaults) on the selected element:

| Command name |
|--------------|
| Add Noise / Grain |
| Add Halftone |
| Add Pixelate |
| Add Duotone |
| Add Posterize |
| Add Dither |
| Add Color Adjust (see [effects.md](./effects.md#color-adjust-fill)) |

---

## General notes

- **Strokes too**: Every filter works identically when added to the Strokes list. It then reprocesses the stroke's rendered area instead of the fill area.
- **Stacking**: Multiple filters can coexist on one element, each processing everything below it in fill order, see [Z-order processing](#z-order-processing).
- **Blend mode**: Each filter row has a blend mode dropdown in its expanded config, controlling how the filter's output composites with the content below it.
- **Stable across zoom**: Pattern sizes (grain, dots, cells) are measured in logical pixels, so they stay visually consistent as you zoom in and out.
- **Per-color tint strength**: For filters with color swatches (Halftone, Duotone, Dither), each swatch's alpha controls how strongly that color tints the result versus showing the original image, not the output's transparency.
- **Design token colors**: Filter color swatches can be bound to design system color tokens (so Duotone or Halftone colors follow the active brand/mode), the same way any fill color can. For token-authoring syntax, see the design-systems knowledge files.
- **Authoring**: Image filters and Color Adjust have no compact authoring syntax in the Blueprint DSL. Add them through the UI type dropdown or the command palette commands above, then tune parameters by dragging the sliders or editing fields in the property inspector. For Blueprint authoring syntax in general, see the blueprint knowledge files.
- **Export**: PNG, JPEG, and WebP capture filters at full quality. SVG and PDF export pre-rasterizes any element using a filter (fill or stroke) as an embedded raster image, since these effects cannot be expressed as vector primitives.
