---
name: "knowledge-image-filters-duotone"
description: "The Duotone filter: parameters, color swatches, tritone mode, and presets."
assumes: reference/image-filters
---

# Duotone

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

## Presets

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
