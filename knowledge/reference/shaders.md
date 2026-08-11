---
name: "knowledge-shaders"
description: "Shader fills and strokes: animated, GPU-rendered procedural effects (metaballs, liquid metal, iridescent, dithering, reactive grid) applied to elements in Brilliant."
---

# Shader Fills & Strokes

Shaders are animated, GPU-rendered procedural effects applied to any element as a **fill or stroke**. They produce looks like organic blob merging, liquid metal, holographic iridescence, brushed steel, retro dithering, and an interactive grid that reacts to the cursor.

Shaders live in the same "type" slot as solid colors, gradients, and image fills: any fill or stroke row can be switched to a shader type. Multiple shaders can run independently on different elements.

Text elements support shader fills (the pattern renders through the glyphs, like a gradient fill). Text *ranges* (individual character runs) are restricted to solid colors only, so switching a range to a shader is not offered.

## Adding a Shader

Both fills and strokes are configured in the right toolbar (property inspector) when an element is selected.

**As a fill:**
1. Select an element.
2. In the Fills section, click "+" to add a fill (or select an existing fill row).
3. Open the fill's type dropdown and pick a shader from the **Animated** or **Interactive** category.

**As a stroke:**
1. Select an element.
2. In the Strokes section, click "+" to add a stroke (or select an existing stroke row).
3. Open the stroke's type dropdown and pick a shader. The stroke renders the shader pattern along its path.

You can switch any fill or stroke between types freely (solid, gradient, image, shader, filter) without deleting the row.

## Shader Types

| Shader | Category | Colors | What it looks like |
|--------|----------|--------|--------------------|
| **Metaballs** | Animated | up to 5 (default 5) | Organic blobs that merge and split |
| **Liquid Metal** | Animated | up to 2 | Metallic reflections with chromatic aberration and bump-modulated stripes |
| **Iridescent** | Animated | up to 3 | Folded, oil-slick iridescence with a metallic finish |
| **Liquid Stainless Steel** | Animated | up to 2 | Flowing chrome with specular highlights and environment reflections |
| **Dithering** | Animated | up to 2 | Procedural noise rendered as retro two-tone dithered output |
| **Reactive Grid** | Interactive | up to 5 (default 3) | A grid that distorts around the cursor with click ripples |

## Shader Parameters

Each shader exposes its own set of sliders in the expanded fill/stroke view (click the fill row to expand it). All shaders share a **Speed** slider (0 = frozen). Below are the per-shader controls as shown in the UI.

**Metaballs:** Count (number of blobs), Size, Speed.

**Liquid Metal:** Shape (Element / Metaballs / None), Softness, Repetition, Shift Red, Shift Blue, Distortion, Contour, Angle (light angle), Speed. When Shape is Metaballs, two extra controls appear: Ball Count and Ball Size.

**Iridescent:** Shape (Element / Metaballs / None), Intensity, Folds, Angle (hue rotation), Complexity, Metallic, Speed. When Shape is Metaballs: Ball Count and Ball Size.

**Liquid Stainless Steel:** Shape (Element / Metaballs / None), Flow, Roughness, Distortion, Depth, Angle (light angle), Speed. When Shape is Metaballs: Ball Count and Ball Size.

**Dithering:** Shape (the noise pattern: Simplex, Warp, Dots, Wave, Ripple, Swirl, Sphere), Dither (the dither algorithm: Random, 2x2, 4x4, 8x8), Size (dither pixel grid size), Speed.

**Reactive Grid:** Density, Distortion (cursor-driven), Radius (cursor interaction radius), Speed.

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
| **Reactive Grid** | Neon Circuit, Sunset Mesh, Blueprint, Laser Grid, Emerald Web, Retro Arcade, Frost, Lava Flow |
| **Dithering** | Electric Sphere, Ember, Sine Tide, Phosphor, Amber CRT, Pocket Green, Voyage, Newsprint, Riso Pink, Deep Current, Violet Drift, Acid Swirl, White Noise, Ghost Grain |

## Colors

- Each shader takes a set of colors (2 to 5 depending on the type), shown as swatches in a Colors section of the expanded view.
- Click a swatch to edit it in the color picker.
- Add or remove colors with the +/- controls, up to the shader's maximum and down to a minimum of 1.
- A shader color can be bound to a design system color token, so it follows mode/brand changes. See [design-systems](./design-systems.md).

## Transform (UV Mapping)

Every shader fill or stroke has a **Transform** section that adjusts how the pattern maps inside the element, independent of the element's own position, size, and rotation. The element boundary stays put; only the procedural texture inside it moves.

| Control | Range | Default | Effect |
|---------|-------|---------|--------|
| **Scale** | 0.01–4.0 | 1.0 | Zoom the pattern in/out |
| **Offset X** | -1.0–1.0 | 0.0 | Pan the pattern horizontally |
| **Offset Y** | -1.0–1.0 | 0.0 | Pan the pattern vertically |
| **Rotation** | 0–360° | 0° | Rotate the pattern |

**Where Rotation appears:** every shader has Scale, Offset, and Rotation. Rotation lives in the Transform section, except for the shape-bearing shaders (Liquid Metal, Iridescent, Liquid Stainless Steel, and Dithering, all of which carry a Shape parameter), where it appears among the parameter sliders instead.

**Cmd-resize / Ctrl-resize compensation:** when you resize an element while holding Command (macOS) or Ctrl (Windows), the shader pattern stays fixed in world space. The element boundary reveals more or less of the pattern instead of stretching it, mirroring image crop compensation. During a normal resize the pattern distorts with the element.

## Animation

- Shader fills animate by default.
- Toggle animation for a single fill with the play/pause button in its expanded view (this is the per-element "Toggle Shader Animation" command).
- The **Speed** slider controls the rate (0 = frozen in place, not reset).
- To globally pause or resume *all* shader animations across the canvas, run **"Toggle Shader Animations"** from the command palette. Neither toggle has a default keyboard shortcut.

## Interactive Shaders (Reactive Grid)

Reactive Grid is grouped under **Interactive** in the type dropdown, but on the canvas it renders its **ambient animated layer only**: the grid animates but does not track or react to the cursor on placed elements.

There is one narrow exception: a shader-filled **text element reacts to the cursor while it is actively being edited**. Outside that text-editing case, cursor interaction does not render.

Practical guidance: treat Reactive Grid as an animated grid pattern. Do not promise live cursor-following, click ripples, or proximity glow on ordinary canvas elements.

## Combining with Other Fills

Shader fills stack with other fill types (solid, gradient, image, inner shadow, inner glow, background blur, color adjust, and image filters) on the same element. Fills render bottom-to-top in list order, so a semi-transparent shader over a solid fill produces layered effects. You can freely interleave shaders with effect and filter fills. See [styling](./styling.md), [effects](./effects.md), and [image-filters](./image-filters.md).

## Export Behavior

| Format | Shader output |
|--------|---------------|
| **PNG / JPEG / WebP** | Rendered at full quality, capturing the current animation frame. |
| **PDF** | Rasterized faithfully (the shaded element is embedded as a raster image), capturing the current frame. |
| **SVG** | **Pre-rasterized.** SVG cannot express fragment shaders, so an element carrying a shader fill or stroke is rasterized and embedded as a base64 image capturing the current frame. Only if rasterization data is unavailable does the export fall back to a flat solid fill (the shader's first color). Export to PNG if you need the procedural look at higher fidelity. |
| **MP4 / MOV** | Shader animation is captured frame by frame across the video. |

For export details across all formats see [export](./export.md).

## Authoring shaders programmatically

This file covers operating shaders by hand in the inspector. For Blueprint DSL syntax to create or modify shader fills programmatically, see the blueprint shader knowledge files (`blueprint/shaders/*`). Do not author shader syntax from this reference.
