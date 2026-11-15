---
name: "knowledge-image-filters"
description: "GPU image-filter fills (noise/grain, halftone, pixelate, duotone, posterize, dither): how to add and tune them in the UI, with full parameter and preset reference."
---

# Image Filters

GPU post-processing filters that live in the Fills (or Strokes) list of an element. Each filter reprocesses the fills painted below it in its segment of that list (see Z-order processing), producing effects like film grain, halftone printing, pixelation, and color reduction. They are designed to work over any fills (solid, gradient, image, shader), not just photos.

The six image filters are: **Noise / Grain**, **Halftone**, **Pixelate**, **Duotone**, **Posterize**, **Dither**.

- `reference/image-filters/adding`: adding a filter, z-order processing, presets, Color Adjust, general notes
- `reference/image-filters/noise`: Noise / Grain parameters and presets
- `reference/image-filters/halftone`: Halftone parameters and color swatches
- `reference/image-filters/halftone-presets`: Halftone CMYK mode and presets
- `reference/image-filters/pixelate`: Pixelate parameters and presets
- `reference/image-filters/duotone`: Duotone parameters, tritone, swatches and presets
- `reference/image-filters/posterize`: Posterize parameters, modes and presets
- `reference/image-filters/dither`: Dither parameters, swatches and presets

## Adding filters via the palette

Open the palette with Cmd+Shift+P and search for the filter name. Each command adds that filter as a new fill (with defaults) on the selected element:

| Command name |
|--------------|
| Add Noise / Grain |
| Add Halftone |
| Add Pixelate |
| Add Duotone |
| Add Posterize |
| Add Dither |
| Add Color Adjust (see `reference/effects/color-adjust`) |
