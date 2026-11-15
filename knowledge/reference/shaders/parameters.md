---
name: "knowledge-shaders-parameters"
description: "Per-shader parameters, element-aware shapes, and shader presets."
assumes: reference/shaders
---

# Shader Parameters and Presets

## Shader Parameters

Each shader exposes its own set of sliders in the expanded fill/stroke view (click the fill row to expand it). All shaders share a **Speed** slider (0 = frozen). Below are the per-shader controls as shown in the UI.

**Metaballs:** Count (number of blobs), Size, Speed.

**Liquid Metal:** Shape (Element / Metaballs / None), Softness, Repetition, Shift Red, Shift Blue, Distortion, Contour, Angle (light angle), Speed, Tint (how strongly the first color tints the metal), Highlight (strength of the second color's highlight bands). When Shape is Metaballs, two extra controls appear: Ball Count and Ball Size.

**Iridescent:** Shape (Element / Metaballs / None), Intensity, Folds, Angle (hue rotation), Complexity, Metallic, Speed. When Shape is Metaballs: Ball Count and Ball Size.

**Liquid Stainless Steel:** Shape (Element / Metaballs / None), Flow, Roughness, Distortion, Depth, Angle (light angle), Speed. When Shape is Metaballs: Ball Count and Ball Size.

**Dithering:** Shape (the noise pattern: Simplex, Warp, Dots, Wave, Ripple, Swirl, Sphere), Dither (the dither algorithm: Random, 2x2, 4x4, 8x8), Size (dither pixel grid size), Speed.

Sliders are dragged or typed into directly, like other property fields in the inspector.

### Element-Aware Shapes

Liquid Metal, Iridescent, and Liquid Stainless Steel have a **Shape** dropdown:

| Shape | Effect |
|-------|--------|
| **Element** | The pattern's contours follow the element's rectangle boundary (including corner radii) or its circle/arc boundary. Shader fills render on rectangle and circle elements only, so the Element shape does not trace arbitrary vector outlines. |
| **Metaballs** | The pattern is masked by an internal metaball shape (Ball Count and Ball Size sliders appear). |
| **None** | No shape masking; the pattern fills the bounds flat. |

## Presets

Most shaders include named presets in a **Presets** dropdown at the top of the expanded view. Selecting a preset applies a curated combination of parameter values and colors, which you can then customize further. A reset button (circular arrow) next to the dropdown restores the shader's default parameters and colors.

| Shader | Presets |
|--------|---------|
| **Metaballs** | Lava Lamp, Deep Ocean, Neon Plasma, Sunset Clouds, Mint Cream, Fireflies, Bubblegum, Galaxy, Blood Moon, Citrus |
| **Liquid Metal** | Mercury, Molten Gold, Rose Chrome, Obsidian, Prism, Copper, Platinum, Emerald, Midnight, Molten Lava |
| **Iridescent** | Rainbow Foil, Soft Opal, Oil Slick, Aurora, Prismatic, Candy, Ice Crystal, Nebula, Pearl, Tropical |
| **Liquid Stainless Steel** | Mirror Polish, Brushed Steel, Dark Chrome, Rose Gold, Turbulent, Satin, Copper, Blue Steel, Titanium, Liquid Silver |
| **Dithering** | Electric Sphere, Ember, Sine Tide, Phosphor, Amber CRT, Pocket Green, Voyage, Newsprint, Riso Pink, Deep Current, Violet Drift, Acid Swirl, White Noise, Ghost Grain |
