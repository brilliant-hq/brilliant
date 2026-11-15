---
name: "knowledge-styling-shader-filter-fills"
description: "Shader fills, image filter fills, and color adjust fills in the Fills list."
assumes: reference/styling
---

# Shader, Filter and Color Adjust Fills

## Shader Fills

Animated, GPU-rendered procedural patterns. 5 shader types total:

- **Animated group** (5): Metaballs, Liquid Metal, Iridescent, Liquid Stainless Steel, Dithering

See `reference/shaders` for full parameter reference.

## Image Filter Fills

GPU-powered post-processing filters applied to all fills below them in the z-order. Available in the **Filters** category of the fill type dropdown:

| Filter | Description |
|--------|-------------|
| **Noise / Grain** | Film-like grain overlay (monochrome/color, uniform/gaussian distribution, roughness and midtone bias) |
| **Halftone** | Classic print halftone dots (standard + CMYK mode, circle/diamond/line shapes, square/hex grid, softness control) |
| **Pixelate** | Mosaic pixelation (square/hexagonal/diamond/circle/triangle shapes) |
| **Duotone** | Two-tone or tri-tone color mapping with gamma/midpoint control |
| **Posterize** | Reduce color levels for poster-style banding (RGB/luminosity/HSL modes) |
| **Dither** | Ordered dithering patterns (Bayer/noise/blue noise, 2x2/4x4/8x8 matrix sizes) |

Each filter has adjustable parameters, optional color inputs, and built-in presets. Filters work on fills, strokes, text, and vector regions. See `reference/image-filters` for detailed per-filter parameter reference.

## Color Adjust Fills

Non-destructive photo-style adjustments (exposure, contrast, saturation, whites, blacks, clarity, sharpness, vignette, hue, temperature, tint, vibrance, brilliance, highlights, shadows, sepia, inversion). Processes all fills below it in the z-order. Includes built-in presets (Vivid, Cinematic, Vintage, B&W, etc.). Available in the **Filters** category alongside image filters. The inspector shows each adjustment as a percentage. Hue-rotate and saturate adjustments live here, not as element-level CSS-style filters. See `reference/effects/color-adjust` for the full parameter table.
