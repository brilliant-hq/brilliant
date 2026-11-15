---
name: "knowledge-image-filters-adding"
description: "Adding an image filter, z-order processing, presets, Color Adjust, and general notes on filters."
assumes: reference/image-filters
---

# Adding and Using Image Filters

## Adding a filter (UI)

1. Select an element.
2. In the right toolbar's **Fills** section (or **Strokes** section), click the **+** button to add a fill/stroke.
3. Click the fill's type dropdown (the leftmost control on the fill row). Scroll to the **Filters** group and pick a filter.

The new fill row now represents the filter. Click the row to expand it and reveal the filter's parameters, color swatches (for filters that use colors), preset dropdown, and blend mode.

## Z-order processing

The fills/strokes list renders bottom-to-top. Every filter (Color Adjust or any image filter) acts as a **segment boundary** and reprocesses only the fills in its own segment: the run from the previous filter boundary up to (but not including) itself. It is NOT "everything below." Consequences: a single filter at the top of the list processes the whole element; stacking two filters does not double-process the bottom run, since each grades only its own segment; fills above the last filter paint normally on top with zero filter overhead. Reorder fills by dragging rows in the Fills section.

**Rendering:** filter fills render on canvas and in exports identically. Coverage includes shape-element fills (rectangles, ellipses), shape-element strokes, vector paths, boolean results, and text at rest (the pattern renders through the glyph ink). Multi-fill segments, stacked filters, per-filter blend mode, and per-filter opacity all render. One residual gap: filters placed in the **Strokes** list of a **vector** element (per-chain vector strokes, distinct from shape-element strokes, which do render) do not render, so avoid promising vector-stroke filter output specifically.

## Presets

When a filter fill is expanded, a preset dropdown appears at the top of its config. Hovering a preset previews it live; selecting one applies a curated combination of parameter values (and colors, for Duotone). You can keep tuning parameters after applying a preset. A reset control restores the filter's default parameters.

## Color Adjust

**Color Adjust** also appears in the Filters group of the type dropdown, but it is a photo-style adjustment layer (exposure, contrast, saturation, white balance, vignette, sepia, etc.), not a pattern filter. It is documented separately in `reference/effects/color-adjust`.

## General notes

- **Strokes too**: Every filter works identically when added to the Strokes list of a shape element. It then reprocesses the stroke's rendered area instead of the fill area. (Filters in the Strokes list of a vector element are the one case that does not yet render, see Z-order processing.)
- **Stacking**: Multiple filters can coexist on one element, each processing only the fills in its own segment (from the previous filter boundary up to itself), not everything below it, see Z-order processing.
- **Blend mode**: Each filter row has a blend mode dropdown in its expanded config, controlling how the filter's output composites with the content below it.
- **The pattern belongs to the element**: Pattern sizes (grain, dots, cells) are measured in the element's own pixels, so the pattern moves with the element when you pan, scales with it when you zoom, and rotates and flips with it.
- **Per-color tint strength**: For filters with color swatches (Halftone, Duotone, Dither), each swatch's alpha controls how strongly that color tints the result versus showing the original image, not the output's transparency.
- **Design token colors**: Filter color swatches can be bound to design system color tokens (so Duotone or Halftone colors follow the active brand/mode), the same way any fill color can. For token-authoring syntax, see the design-systems knowledge files.
- **Authoring**: Color Adjust and the image filters have compact Blueprint syntax as fill entries, `colorAdjust(...)`, `noiseGrain(...)`, `halftone(...)`, `pixelate(...)`, `duotone(...)`, `posterize(...)`, `dither(...)` (`blueprint/paint`), and they tween by parameter in a motion clip (`motion/core`). The UI type dropdown and the palette commands above add them too, tuned by the sliders and fields in the property inspector.
- **Export**: exports are WYSIWYG with the canvas. SVG and PDF export pre-rasterizes any element using a filter (fill or stroke) as an embedded raster image, since these effects cannot be expressed as vector primitives.
