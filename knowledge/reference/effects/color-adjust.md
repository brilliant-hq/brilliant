---
name: "knowledge-effects-color-adjust"
description: "The Color Adjust fill: parameters, presets, and key behaviors."
assumes: reference/effects
---

# Color Adjust (fill)

A special fill type that applies non-destructive, photo-style adjustments to all fills below it. Add it via the fill type dropdown (under "Filters") or the palette ("Add Color Adjust").

## Parameters

Organized into 4 groups in the expanded fill row, plus a separate opacity control:

| Group | Parameters |
|-------|-----------|
| Light | Exposure, Contrast, Highlights, Shadows, Whites, Blacks, Brilliance |
| Color | Saturation, Vibrance, Temperature, Tint, Hue |
| Detail | Clarity, Sharpness |
| Effects | Vignette, Sepia, Inversion |

Most sliders display as -100% to 100%; Inversion and Sepia are 0-100%; Hue is 0-360 degrees. All adjustments default to 0 (no change); opacity defaults to 100%.

## Presets

A preset dropdown offers quick starting points in 4 categories:

| Category | Presets |
|----------|--------|
| Basic | Vivid, Warm, Cool, Dramatic, B&W |
| Cinematic | Noir, Vintage, Cinematic, Golden, Moody, Portrait |
| Creative | Lark, Clarendon, Dreamy, Fade, Chrome, Food, Landscape, Sepia, Punch |
| Enhancement | Sharp & Clear, Vintage Film |

The dropdown shows the active preset name when sliders match it, and reverts to "Presets" once you manually adjust any slider.

## Key behaviors

- **Z-order aware:** processes all fills below it. Place it as the top fill to adjust everything.
- **Non-destructive:** original fills are preserved; remove the Color Adjust fill to restore them.
- **Opacity:** has its own opacity control, separate from the adjustments.
- **Vignette:** positive values darken edges; negative values lighten edges toward white.
- **Clarity:** enhances midtone local contrast for a punchier look.
- **Sharpness:** enhances edges for crisper detail.
- **Whites / Blacks:** finer control than Highlights / Shadows, targeting only the very brightest and darkest tones.
