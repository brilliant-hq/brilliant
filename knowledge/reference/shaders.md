---
name: "knowledge-shaders"
description: "Shader fills and strokes — animated procedural effects for elements in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Shader Fills & Strokes

Shaders are animated, GPU-rendered procedural effects that can be applied to any element as a **fill or stroke**. They produce effects like liquid metal, holographic iridescence, and organic blob merging.

> **Note:** Text elements do not support shader fills. Shader types are excluded from the type dropdown for text elements. Text elements support solid, gradient, and effect paint styles only.

## Adding a Shader

### As a Fill

1. Select an element
2. In the Fills section of the right toolbar, click "+" to add a fill
3. Use the type dropdown to switch to a shader type (organized by category under "Animated")

### As a Stroke

1. Select an element
2. In the Strokes section, click "+" to add a stroke (or select an existing stroke)
3. Use the type dropdown on the stroke to switch to a shader type
4. The stroke renders with the shader pattern along its path

## Shader Types

### Animated

- **Metaballs** — Organic blob merging (up to 5 colors)
- **Liquid Metal** — Metallic reflections with chromatic aberration, shape-aware rendering (Element, Metaballs, None), bump-modulated stripes (up to 2 colors)
- **Holographic** — Iridescent metallic effect with folded noise and element-aware shape rendering (up to 3 colors)
- **Liquid Stainless Steel** — Flowing chrome-like metallic surface with multi-source lighting, specular highlights, and environment reflections (up to 2 colors)
- **Dithering** — Animated procedural patterns rendered as retro two-tone dithered output (2 colors). Choose from 7 pattern shapes (Simplex, Warp, Dots, Wave, Ripple, Swirl, Sphere) and 4 dither algorithms (Random, 2x2, 4x4, 8x8 Bayer). Adjustable grid size and animation speed

### Interactive

Interactive shaders react to your mouse cursor in real-time while you hover over elements in idle mode (Move/Hand tool, no selection).

- **Magnetic Glow** — A radial glow that follows your cursor, with a click ripple effect and element edge highlighting near the cursor (2 colors). Parameters: Intensity, Radius, Speed. The glow activates when hovering near the element and fades when you move away

## Shader Parameters

Each shader type has its own set of adjustable parameters. Parameters shared across shaders:

| Parameter | Description | Shaders |
|-----------|-------------|---------|
| **Speed** | Animation speed (0 = frozen) | All 6 |
| **Shape** | Element-aware shape mode (Element, Metaballs, None) | Liquid Metal, Holographic, Liquid Stainless Steel |
| **Shape** | Pattern shape (Simplex, Warp, Dots, Wave, Ripple, Swirl, Sphere) | Dithering |
| **Dither** | Dither algorithm (Random, 2x2, 4x4, 8x8 Bayer) | Dithering |
| **Size** | Dither pixel grid size (1–20) | Dithering |

Shader-specific parameters are shown in the expanded fill view when a shader fill is selected.

## UV Transform

Every shader fill has a Transform section (in the expanded view) with 4 controls that adjust how the pattern is mapped within the element:

| Control | Range | Default | Description |
|---------|-------|---------|-------------|
| **Scale** | 0.01–4.0 (presets) | 1.0 | Zoom the pattern in/out within the element |
| **Offset X** | -1.0–1.0 | 0.0 | Pan the pattern horizontally |
| **Offset Y** | -1.0–1.0 | 0.0 | Pan the pattern vertically |
| **Rotation** | 0–360° | 0° | Rotate the pattern within the element |

These controls transform the pattern independently of the element's own position, size, and rotation. The element boundary stays the same — only the procedural texture inside it changes.

**Cmd+Resize compensation:** When resizing an element while holding Command (macOS) or Ctrl (Windows), shader UV transforms are automatically compensated so the pattern stays fixed in world space — the element boundary reveals more or less of the pattern instead of stretching it. This matches the behavior of image crop compensation during resize.

## Element-Aware Shapes

Liquid Metal, Holographic, and Liquid Stainless Steel have a **Shape** dropdown with three options:

| Shape | Description |
|-------|-------------|
| **Element** | Pattern follows the actual element shape (corner radii, circular shapes, etc.) |
| **Metaballs** | Pattern uses a metaball-based shape |
| **None** | No shape masking |

Shaders with the Shape dropdown:
- **Liquid Metal** — Metallic contours follow the element boundary
- **Holographic** — Iridescent contours follow the element boundary
- **Liquid Stainless Steel** — Chrome contours follow the element boundary

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

## Combining with Other Fills

Shader fills can be stacked with other fill types (solid, gradient, image, inner shadow, inner glow, background blur, color adjust) on the same element. All fills render bottom-to-top in list order, so a semi-transparent shader over a solid fill creates layered effects. You can freely interleave shader fills with effect paint styles.

## Unified Type Dropdown

All fill types beyond classic fills (solid, gradient, image) share a single type dropdown, organized by category:

| Category | Types |
|----------|-------|
| **Static** | Inner Shadow, Inner Glow, Background Blur |
| **Animated** | Metaballs, Liquid Metal, Holographic, Liquid Stainless Steel, Dithering |
| **Interactive** | Magnetic Glow |
| **Filters** | Color Adjust, Noise/Grain, Halftone, Pixelate, Duotone, Posterize, Dither |

You can switch any fill between types freely. Image filter types (Filters category) apply GPU post-processing to all fills below them in the z-order.

## Interactive Shader Behavior

Interactive shaders (like Magnetic Glow) have special behavior:

- **Mouse tracking activates in idle hover mode only:** Move/Hand tool active, no elements selected, not editing anything
- **Ambient animation continues always:** Even when your cursor is far away, the shader's background animation keeps running
- **Mouse effects are proximity-based:** The cursor glow/refraction only activates when your cursor is near the element
- **Click effects:** Clicking while hovering creates additional visual effects (ripples, pulses)

## Export Behavior

- **PNG/JPEG/WebP:** Shader renders at full quality (current animation frame). Interactive effects are captured at their current state
- **PDF:** Shader renders at full quality (current animation frame) via rasterization, same as PNG/JPEG/WebP
- **SVG:** Shader renders as a solid color fallback (primary shader color). Animation and pattern are lost — SVG cannot express fragment shaders
