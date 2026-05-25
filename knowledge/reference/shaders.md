---
name: "knowledge-shaders"
description: "Shader fills and strokes: animated procedural effects for elements in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Shader Fills & Strokes

Shaders are animated, GPU-rendered procedural effects that can be applied to any element as a **fill or stroke**. They produce effects like liquid metal, holographic iridescence, and organic blob merging.

> **Note:** Text elements support shader fills. Shader patterns render through the text glyphs, the same way gradient fills do. Text *ranges* (individual character runs) are restricted to solid colors only.

## Adding a Shader

### As a Fill

1. Select an element
2. In the Fills section of the right toolbar, click "+" to add a fill
3. Use the type dropdown to switch to a shader type (under "Animated" or "Interactive" categories)

### As a Stroke

1. Select an element
2. In the Strokes section, click "+" to add a stroke (or select an existing stroke)
3. Use the type dropdown on the stroke to switch to a shader type
4. The stroke renders with the shader pattern along its path

## Shader Types

Each shader is a `PaintStyleType` value. The internal name and the UI label can differ: `holographic` is the internal name for the "Iridescent" shader.

### Animated (`category: 'Animated'`)

| UI Label | `PaintStyleType` | Max Colors | Default Color Count |
|----------|------------------|------------|---------------------|
| Metaballs | `metaballs` | 5 | 5 |
| Liquid Metal | `liquidMetal` | 2 | 2 |
| Iridescent | `holographic` | 3 | 3 |
| Liquid Stainless Steel | `liquidStainlessSteel` | 2 | 2 |
| Dithering | `dithering` | 2 | 2 |

- **Metaballs**: Organic blob merging.
- **Liquid Metal**: Metallic reflections with chromatic aberration, shape-aware rendering (Element, Metaballs, None), bump-modulated stripes.
- **Iridescent**: Iridescent metallic effect with folded noise and element-aware shape rendering.
- **Liquid Stainless Steel**: Flowing chrome-like surface with multi-source lighting, specular highlights, environment reflections.
- **Dithering**: Procedural pattern rendered as retro two-tone dithered output. 7 pattern shapes (Simplex, Warp, Dots, Wave, Ripple, Swirl, Sphere) and 4 dither algorithms (Random, 2x2, 4x4, 8x8).

### Interactive (`category: 'Interactive'`)

Interactive shaders react to the cursor in real time while idle hovering (Move/Hand tool, no selection, not editing). They keep animating regardless.

| UI Label | `PaintStyleType` | Max Colors | Default Color Count |
|----------|------------------|------------|---------------------|
| Reactive Grid | `reactiveGrid` | 5 | 3 |

- **Reactive Grid**: Grid that distorts around the cursor with proximity-based color blending and click ripples. Params: Density, Distortion, Radius, Speed.

## Shader Parameters

Each shader type has its own set of adjustable parameters. Parameters shared across shaders:

| Parameter | Description | Shaders |
|-----------|-------------|---------|
| **Speed** | Animation speed (0 = frozen) | All 6 |
| **Shape** | Element-aware shape mode (Element, Metaballs, None) | Liquid Metal, Iridescent, Liquid Stainless Steel |
| **Shape** | Pattern shape (Simplex, Warp, Dots, Wave, Ripple, Swirl, Sphere) | Dithering |
| **Dither** | Dither algorithm (Random, 2x2, 4x4, 8x8) | Dithering |
| **Size** | Dither pixel grid size (1–20) | Dithering |

### Per-Shader Parameters

#### Metaballs (`metaballs`)

| Parameter | Param Key | Range | Default | Description |
|-----------|-----------|-------|---------|-------------|
| **Count** | `count` | 1-30 | 10 | Number of metaballs |
| **Size** | `size` | 0.05-1.0 | 0.3 | Size of each metaball |
| **Speed** | `speed` | 0-3 | 1.0 | Animation speed |

Colors: maxColors 5, defaultColors `[#000000, #FF3377, #FF9900, #FFDD00, #0080FF]`. Note: this `size` is different from the `metaballSize` param on Liquid Metal/Iridescent/Liquid Stainless Steel (0.1-3.0 there).

#### Liquid Metal (`liquidMetal`)

| Parameter | Param Key | Range | Default | Description |
|-----------|-----------|-------|---------|-------------|
| **Shape** | `shape` | Element (0) / Metaballs (1) / None (2) | Element | Shape source |
| **Softness** | `softness` | 0-1 | 0.1 | Edge softness |
| **Repetition** | `repetition` | 1-10 | 2 | Wave repetition count |
| **Shift Red** | `shiftRed` | -1 to 1 | 0.3 | Red channel chromatic aberration |
| **Shift Blue** | `shiftBlue` | -1 to 1 | 0.3 | Blue channel chromatic aberration |
| **Distortion** | `distortion` | 0-1 | 0.07 | Surface distortion |
| **Contour** | `contour` | 0-3 | 0.4 | Contour/edge definition |
| **Angle** | `angle` | 0-360° | 70° | Light angle |
| **Speed** | `speed` | 0-3 | 1.0 | Animation speed |
| **Ball Count** | `metaballCount` | 2-30 | 5 | Only used when `shape = 1` (Metaballs) |
| **Ball Size** | `metaballSize` | 0.1-3 | 1.0 | Only used when `shape = 1` (Metaballs) |

Colors: maxColors 2, defaultColors `[#AAAAAC, #FFFFFF]`.

#### Iridescent (`holographic`)

| Parameter | Param Key | Range | Default | Description |
|-----------|-----------|-------|---------|-------------|
| **Shape** | `shape` | Element / Metaballs / None | Element | Shape source |
| **Intensity** | `intensity` | 0-1 | 0.7 | Iridescence brightness |
| **Folds** | `spread` | 0-1 | 0.7 | Fold/ripple spread (key is `spread`, label is "Folds") |
| **Angle** | `angle` | 0-360° | 10° | Hue rotation angle |
| **Complexity** | `noise` | 0-1 | 0.75 | Pattern complexity (key is `noise`) |
| **Metallic** | `metallic` | 0-1 | 0.9 | Metallic finish amount |
| **Speed** | `speed` | 0-3 | 0.2 | Animation speed |
| **Ball Count** | `metaballCount` | 2-30 | 5 | Only used when `shape = 1` |
| **Ball Size** | `metaballSize` | 0.1-3 | 1.0 | Only used when `shape = 1` |

Colors: maxColors 3, defaultColors `[#1B0A3C, #0D9488, #7C3AED]`. The internal `PaintStyleType` is `holographic`, the displayName is "Iridescent". Param keys `spread` and `noise` are intentional internal names that the UI labels as "Folds" and "Complexity".

#### Liquid Stainless Steel (`liquidStainlessSteel`)

| Parameter | Param Key | Range | Default | Description |
|-----------|-----------|-------|---------|-------------|
| **Shape** | `shape` | Element / Metaballs / None | Element | Shape source |
| **Flow** | `flow` | 0-1 | 0.5 | Flow direction/strength |
| **Roughness** | `roughness` | 0-1 | 0.3 | Surface roughness |
| **Distortion** | `distortion` | 0-1 | 1.0 | Surface distortion |
| **Depth** | `depth` | 0-1 | 1.0 | 3D depth effect |
| **Angle** | `angle` | 0-360° | 45° | Light angle |
| **Speed** | `speed` | 0-3 | 2.0 | Animation speed |
| **Ball Count** | `metaballCount` | 2-30 | 5 | Only when `shape = 1` |
| **Ball Size** | `metaballSize` | 0.1-3 | 1.0 | Only when `shape = 1` |

Colors: maxColors 2, defaultColors `[#B0B0B4, #FFFFFF]`.

#### Dithering (`dithering`)

| Parameter | Param Key | Range | Default | Description |
|-----------|-----------|-------|---------|-------------|
| **Shape** | `shape` | Simplex (0) / Warp (1) / Dots (2) / Wave (3) / Ripple (4) / Swirl (5) / Sphere (6) | Simplex | Noise pattern type |
| **Dither** | `ditherType` | Random (0) / 2x2 (1) / 4x4 (2) / 8x8 (3) | 4x4 | Dither matrix algorithm |
| **Size** | `size` | 1-20 | 4 | Dither pixel grid size |
| **Speed** | `speed` | 0-3 | 1.0 | Animation speed |

Colors: maxColors 2, defaultColors `[#000000, #00B3FF]`. No named presets.

#### Reactive Grid (`reactiveGrid`, Interactive)

| Parameter | Param Key | Range | Default | Description |
|-----------|-----------|-------|---------|-------------|
| **Density** | `density` | 2-20 | 8 | Grid cell density |
| **Distortion** | `distortion` | 0-1 | 0.5 | Mouse-driven distortion amount |
| **Radius** | `radius` | 0.05-1 | 0.3 | Mouse interaction radius |
| **Speed** | `speed` | 0-3 | 1.0 | Animation speed |

Colors: maxColors 5, default 3 colors `[#1A1A33, #3366CC, #E64D80]`.

## Presets

Most shader types include named presets accessible via a dropdown in the expanded fill view. Selecting a preset applies a curated combination of parameter values and colors. You can further customize after applying a preset.

| Shader | Presets |
|--------|---------|
| **Metaballs** | Lava Lamp, Deep Ocean, Neon Plasma, Sunset Clouds, Mint Cream, Fireflies, Bubblegum, Galaxy, Blood Moon, Citrus |
| **Liquid Metal** | Mercury, Molten Gold, Rose Chrome, Obsidian, Prism, Copper, Platinum, Emerald, Midnight, Molten Lava |
| **Iridescent** | Rainbow Foil, Soft Opal, Oil Slick, Aurora, Prismatic, Candy, Ice Crystal, Nebula, Pearl, Tropical |
| **Liquid Stainless Steel** | Mirror Polish, Brushed Steel, Dark Chrome, Rose Gold, Turbulent, Satin, Copper, Blue Steel, Titanium, Liquid Silver |
| **Dithering** | (no named presets) |
| **Reactive Grid** | Neon Circuit, Sunset Mesh, Blueprint, Laser Grid, Emerald Web, Retro Arcade, Frost, Lava Flow |

## UV Transform

Every shader fill has a Transform section (in the expanded view) with 4 controls that adjust how the pattern is mapped within the element:

| Control | Range | Default | Description |
|---------|-------|---------|-------------|
| **Scale** | 0.01–4.0 | 1.0 | Zoom the pattern in/out within the element |
| **Offset X** | -1.0–1.0 | 0.0 | Pan the pattern horizontally |
| **Offset Y** | -1.0–1.0 | 0.0 | Pan the pattern vertically |
| **Rotation** | 0–360° | 0° | Rotate the pattern within the element |

These controls transform the pattern independently of the element's own position, size, and rotation. The element boundary stays the same: only the procedural texture inside it changes.

**Cmd+Resize compensation:** When resizing an element while holding Command (macOS) or Ctrl (Windows), shader UV transforms are automatically compensated so the pattern stays fixed in world space: the element boundary reveals more or less of the pattern instead of stretching it. This matches the behavior of image crop compensation during resize.

**Aspect ratio lock:** Shader fills also store an internal aspect ratio reference. During normal resize, the pattern distorts with the element. During Cmd+resize, the pattern keeps its original aspect ratio, so the boundary just reveals more or less of the same fixed pattern.

## Element-Aware Shapes

Liquid Metal, Iridescent, and Liquid Stainless Steel have a **Shape** dropdown with three options:

| Shape | Description |
|-------|-------------|
| **Element** | Pattern follows the actual element shape (corner radii, circular shapes, etc.) |
| **Metaballs** | Pattern uses a metaball-based shape |
| **None** | No shape masking |

Shaders with the Shape dropdown:
- **Liquid Metal**: Metallic contours follow the element boundary
- **Iridescent**: Iridescent contours follow the element boundary
- **Liquid Stainless Steel**: Chrome contours follow the element boundary

## Animation

- Shader fills animate by default (the pattern moves over time)
- Toggle animation on/off with the animate button in the expanded fill view
- Speed parameter controls animation rate (0 = frozen)
- Multiple animated shaders can run independently on different elements
- Use "Toggle Shader Animations" from the command palette to globally pause/resume all shader animations

## Colors

- Each shader accepts a set of colors (2–5 depending on the shader type)
- Click a color swatch in the expanded fill view to edit it in the color picker
- Add/remove colors with the +/- buttons (up to the shader's maximum)
- Minimum 1 color per shader
- Each shader color slot can bind to a design system color token (via `colorTokenRefs`) and an opacity token (via `colorOpacityTokenRefs`). Token bindings resolve through the active design system / mode at paint time; the literal color is the fallback if the token is missing.

## Combining with Other Fills

Shader fills can be stacked with other fill types (solid, gradient, image, inner shadow, inner glow, background blur, color adjust) on the same element. All fills render bottom-to-top in list order, so a semi-transparent shader over a solid fill creates layered effects. You can freely interleave shader fills with effect paint styles.

## Unified Type Dropdown

Every fill and stroke uses one type dropdown grouped by category. Internal type names in `lib/models/element.dart` PaintStyleType enum:

| Category | Types (UI label / `PaintStyleType`) |
|----------|-------|
| **Colors** | Solid (`solid`), Linear (`linearGradient`), Radial (`radialGradient`), Angular (`angularGradient`) |
| **Static** | Image (`image`), Inner Shadow (`innerShadow`), Inner Glow (`innerGlow`), Background Blur (`backgroundBlur`) |
| **Animated** | Metaballs (`metaballs`), Liquid Metal (`liquidMetal`), Iridescent (`holographic`), Liquid Stainless Steel (`liquidStainlessSteel`), Dithering (`dithering`) |
| **Interactive** | Reactive Grid (`reactiveGrid`) |
| **Filters** | Color Adjust (`colorAdjust`), Noise/Grain (`noiseGrain`), Halftone (`halftone`), Pixelate (`pixelate`), Duotone (`duotone`), Posterize (`posterize`), Dither (`dither`) |

You can switch any fill between types freely. The Filters category applies GPU post-processing to all fills below it in the z-order; the underlying paint switches type but the fill row stays in place.

Text ranges (per-character runs) are restricted to `solid` only: only the Solid option appears in the dropdown when editing a text range.

## Interactive Shader Behavior

Interactive shaders (like Reactive Grid) have special behavior:

- **Mouse tracking activates in idle hover mode only:** Move/Hand tool active, no elements selected, not editing anything
- **Ambient animation continues always:** Even when your cursor is far away, the shader's background animation keeps running
- **Mouse effects are proximity-based:** The cursor glow/refraction only activates when your cursor is near the element
- **Click effects:** Clicking while hovering creates additional visual effects (ripples, pulses)

## Export Behavior

- **PNG/JPEG/WebP:** Shader renders at full quality (current animation frame). Interactive effects are captured at their current state
- **PDF:** Shader renders at full quality (current animation frame) via rasterization, same as PNG/JPEG/WebP
- **SVG:** Shader renders at full quality via pre-rasterization: the element is rendered as an embedded PNG image within the SVG. Animation is captured at the current frame. SVG cannot express fragment shaders natively, so rasterization preserves visual fidelity
