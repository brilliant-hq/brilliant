---
name: "knowledge-effects"
description: "Element visual effects in Brilliant: shadows, glows, and blurs."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Effects

Visual effects that enhance elements with shadows, glows, and blurs.

## Two Systems

Two parallel systems with different storage and different UI homes:

### Effects (Effects Section, `element.effects`)

`EffectType` enum: `dropShadow`, `outerGlow`, `layerBlur` (UI label "Element Blur"). Stored in a dedicated `List<Effect>` on the element. Managed in the Effects section of the right toolbar.

| Type | UI Label | Description |
|------|----------|-------------|
| `dropShadow` | Drop Shadow | Shadow behind the element |
| `outerGlow` | Outer Glow | Luminous glow around the element |
| `layerBlur` | Element Blur | Blurs the element itself |

### Inner Shadow, Inner Glow, Background Blur (Fills Section, `PaintStyleType`)

These are fill types (`PaintStyleType.innerShadow`, `PaintStyleType.innerGlow`, `PaintStyleType.backgroundBlur`). They live in the element's `fills` list (and can also appear in `strokes`), participating in z-order alongside solid/gradient/image/shader/filter fills.

| Type | Description |
|------|-------------|
| `innerShadow` | Shadow inside element edges. Renders via clip + saveLayer + dstOut compositing on canvas |
| `innerGlow` | Luminous glow inside edges. Same compositing approach |
| `backgroundBlur` | Blurs content behind the element. Renders at the widget level via `BackdropFilter` + `ClipPath`, not on canvas |

Interleave them with other fills, for example place an inner shadow between two solid fills.

## Adding Effects

### Effects (Drop Shadow, Outer Glow, Element Blur)

Click the **+** button on the Effects section header in the right toolbar. The first add inserts a drop shadow with default settings. To switch types, use the type dropdown on the effect row (Drop Shadow, Outer Glow, Element Blur).

### Inner Shadow, Inner Glow, Background Blur

These are fill types: add them as fills (they also work as strokes):
1. Click "+" in the Fills section (or Strokes section)
2. Use the type dropdown to switch to an inner effect type (under the "Static" category)

### Via Commands

Use the command palette (Cmd+Shift+P) to add effects by name:

| Command | ID | Description |
|---------|-----|-------------|
| Add Drop Shadow | `add_drop_shadow` | Adds drop shadow with defaults |
| Add Outer Glow | `add_outer_glow` | Adds outer glow with defaults |
| Add Element Blur | `add_layer_blur` | Adds element blur with defaults |
| Add Inner Shadow | `add_inner_shadow_fill` | Adds inner shadow fill with defaults |
| Add Inner Glow | `add_inner_glow_fill` | Adds inner glow fill with defaults |
| Add Background Blur | `add_background_blur_fill` | Adds background blur fill with defaults |
| Add Color Adjust | `add_color_adjust_fill` | Adds color adjust filter fill with defaults |

Additional management commands (target a specific effect via `targetEffectId` context):

| Command | ID | Notes |
|---------|-----|-------|
| Remove Effect | `remove_effect` | Removes effect by id |
| Toggle Effect Visibility | `toggle_effect_visibility` | Toggles `enabled` flag |
| Reorder Effect | `reorder_effect` | Drag handle reorder (later effects render on top) |
| Change Effect Type | `change_effect_type` | DropdownValueCommand<EffectType>, resets to type defaults |
| Toggle Show Behind Transparent | `toggle_effect_show_behind_transparent` | Drop shadow knockout flag |
| Set Effect Blend Mode | `set_effect_blend_mode` | DropdownValueCommand<BlendMode> |
| Draggable Update Effect Property | `draggable_update_effect_property` | offsetX/offsetY/blur/spread/radius/opacity drag |
| Draggable Update Effect Fill Property | `draggable_update_effect_fill_property` | innerShadow/innerGlow/backgroundBlur fields |
| Change Shader Effect Type | `change_shader_effect_type` | DropdownValueCommand<PaintStyleType> for swapping fill type |

### Via Compact Format

Inner effects are specified as fills using the compact blueprint syntax:

| Type | Syntax | Example |
|------|--------|---------|
| Inner shadow | `f[(id,inner(<color>,o(N),x(N),y(N),blur(N),sp(N),blend(mode)))]` | `f[(inner($color.shadow,o($visibility.mid),y(2),blur(4)))]` |
| Inner glow | `f[(id,glow(<color>,o(N),blur(N),sp(N),blend(mode)))]` | `f[(glow($color.glow,o($visibility.mid),blur(4)))]` |
| Background blur | `f[(id,blur(radius))]` | `f[(blur(12))]` |

`<color>` accepts any token reference. Bare `inner()` / `glow()` (no args) bind to `$color.shadow` / `$color.glow` automatically.

`inner()` defaults: opacity=0.5, offsetY=2, blurRadius=4, blendMode=srcOver. Only non-default params needed. Examples: `f[(inner())]` defaults · `f[(inner($red.mid))]` accent · `f[(inner($color.shadow,o(0.3),y(4),blur(8),sp(2)))]` with spread.

`glow()` defaults: opacity=0.6, blurRadius=4, blendMode=screen. Examples: `f[(glow())]` defaults · `f[(glow($emerald.mid))]` green · `f[(glow($emerald.mid,o(0.8),blur(12),sp(4)))]` with spread.

`blur(radius)` has one optional param, default 8. Pair with a low-opacity fill for frosted glass: `f[(solid($neutral.hint,o($visibility.subtle))),(f2,blur(12))]`.

Image filter fills (noise/grain, halftone, pixelate, duotone, posterize, dither) and color adjust have NO compact blueprint syntax. Add them via commands (`add_noise_grain_fill`, `add_halftone_fill`, etc.) or by setting fill type via the UI dropdown. See [image-filters.md](./image-filters.md) for parameters.

Shader fills (metaballs, liquidMetal, holographic, liquidStainlessSteel, reactiveGrid, dithering) DO have compact blueprint syntax. See shader knowledge for details.

Outer effects (drop shadow, outer glow, element blur) have compact blueprint syntax as standalone tokens (not inside `f[...]`):

| Type | Syntax | Example |
|------|--------|---------|
| Drop shadow | `shadow(<color>,o(opacity),x(n),y(n),blur(n),sp(n),blend(mode))` | `shadow($color.shadow,o(0.25),y(4),blur(8))` |
| Outer glow | `outerglow(<color>,o(opacity),blur(n),sp(n),blend(mode))` | `outerglow($color.glow,o(0.6),blur(8))` |
| Element blur | `eblur(radius)` | `eblur(4)` |

Bare `shadow()` / `outerglow()` (no args) bind to `$color.shadow` / `$color.glow` from the active DS automatically.

All params are named and optional with defaults matching the effect defaults above. `shadow()`, `outerglow()`, and `eblur()` with empty parens use all defaults.

## Effect Properties

### Drop Shadow (`Effect`, EffectType.dropShadow)

| Property | Range | Default |
|----------|-------|---------|
| X offset | -200 to 200 | 0 |
| Y offset | -200 to 200 | 4 |
| Blur | 0 to 200 | 8 |
| Spread | -100 to 100 | 0 |
| Color | Any | `#000000` |
| Opacity | 0 to 1 (UI shows 0-100%) | 0.25 |
| Blend Mode | Any of 16 designBlendModes | `srcOver` (Normal) |
| Show Behind Transparent Areas | bool | false |

**Show Behind Transparent Areas:** When enabled, the shadow shows through transparent fills. When disabled (default), the element shape is knocked out from the shadow. The toggle is only exposed in the UI for drop shadow (the `showBehindTransparentAreas` field exists on outer glow data too but its UI toggle is hidden).

### Outer Glow (`Effect`, EffectType.outerGlow)

| Property | Range | Default |
|----------|-------|---------|
| Blur | 0 to 200 | 8 |
| Spread | -100 to 100 | 0 |
| Color | Any | `#FFFFFF` |
| Opacity | 0 to 1 | 0.6 |
| Blend Mode | Any | `screen` |
| Show Behind Transparent Areas | bool, data only | false |

Outer glow is symmetric: the inspector does not expose X/Y offset fields (the `offsetX`/`offsetY` fields exist on the Effect class but stay at 0). The `showBehindTransparentAreas` field is supported on the Effect class for outer glow but the UI toggle is also hidden (drop shadow only). Outer glow uses 3-pass `MaskFilter.blur` rendering.

### Element Blur (`Effect`, EffectType.layerBlur)

| Property | Range | Default |
|----------|-------|---------|
| Radius | 0 to 200 | 4 |

Renders via Canvas `saveLayer` + `ImageFilter.blur` wrapping the entire element subtree (fills, strokes, drop shadows, outer glows). Sits inside the element opacity layer.

### Inner Shadow (Fill, `PaintStyleType.innerShadow`, `InnerShadowData`)

| Property | Range | Default |
|----------|-------|---------|
| X offset | -200 to 200 | 0 |
| Y offset | -200 to 200 | 2 |
| Blur | 0 to 200 | 4 |
| Spread | -100 to 100 | 0 |
| Color | Any | `#000000` |
| Opacity | 0 to 1 | 0.5 |
| Blend Mode | Any | `srcOver` |

### Inner Glow (Fill, `PaintStyleType.innerGlow`, `InnerGlowData`)

| Property | Range | Default |
|----------|-------|---------|
| Blur | 0 to 200 | 4 |
| Spread | -100 to 100 | 0 |
| Color | Any | `#FFFFFF` |
| Opacity | 0 to 1 | 0.6 |
| Blend Mode | Any | `screen` |

Inner glow has no offset fields (unlike inner shadow). Use spread for size, blur for softness.

### Background Blur (Fill, `PaintStyleType.backgroundBlur`, `BackgroundBlurData`)

| Property | Range | Default |
|----------|-------|---------|
| Radius | 0 to 200 | 8 |

Background blur has no color, no opacity, no blend mode in the data class. The fill row in the inspector shows the radius inline on the collapsed row (no expand toggle). Pair with a low-alpha solid fill above it for the standard frosted-glass look.

### Design System Token Binding

Effect opacity (`opacityTokenRef`) and effect color (`colorTokenRef`) can each be bound to design system tokens independently. When bound, the painter resolves through the active design system at render time and the stored numeric/color value is the offline fallback. Manually editing opacity via the drag command clears the opacity token binding (color follows the standard fill color-picker token-clear flow).

`InnerShadowData` and `InnerGlowData` carry the same `colorTokenRef` / `opacityTokenRef` fields. `BackgroundBlurData` has no color or opacity so no token bindings. Image filter duotone color stops are token-bindable via `ImageFilterData.colorTokenRefs` / `colorOpacityTokenRefs`.

### Composite Shadow Tokens

The design system supports composite shadow tokens that bundle multiple drop shadow layers (color, offset, blur, spread, opacity per layer) into a single named token. Applying a shadow token replaces all existing drop shadows on the element while leaving outer glow and element blur effects alone. Manually editing any drop shadow on a token-bound element clears the binding.

## Managing Effects

### Effects (Effects Section)

| Action | How |
|--------|-----|
| Add effect | Click "+" on the section header (adds a drop shadow by default), then change type with the dropdown. Or use command palette: "Add Drop Shadow", "Add Outer Glow", "Add Element Blur" |
| Remove effect | Click the delete button on the effect row |
| Toggle visibility | Expand the effect, then click the eye icon in the expanded view |
| Expand properties | Click the sliders icon on the effect row to expand/collapse the property fields |
| Change type | Use the type dropdown on the collapsed row (Drop Shadow, Outer Glow, Element Blur) |
| Set blend mode | Use the blend mode dropdown in the expanded view (any of the standard design blend modes) |
| Reorder | Drag the handle on the row to change render order (later effects render on top) |

### Inner Shadow / Inner Glow / Background Blur (Fills Section)

| Action | How |
|--------|-----|
| Add effect fill | Click "+" in Fills section, then switch type via the dropdown |
| Remove | Click delete button on the fill row |
| Edit color | Click color swatch on the type dropdown (inner shadow and inner glow only; background blur has no color) |
| Edit parameters | Expand the fill row with the sliders icon, then adjust fields (inner shadow and inner glow only; background blur shows its radius inline on the collapsed row with no expand toggle) |
| Change type | Use the type dropdown (shared with shaders and image filters) |
| Reorder | Drag to change z-order relative to other fills |

## Rendering Order

Per-element canvas layer stack (inside `element_renderer_mixins.dart`):

```
1. Opacity saveLayer (if element.opacity < 1.0 OR blend mode != srcOver)
2.   Element-blur saveLayer (if any layerBlur effect enabled, uses ImageFilter.blur)
3.     Drop shadows + outer glows (in element.effects list order, BEFORE fills)
4.     Fills in z-order: solid, gradient, image, shaders, innerShadow, innerGlow, image filters, color adjust
5.     Strokes (same supported PaintStyleType set as fills)
6.   Restore element-blur layer
7. Restore opacity layer
```

`EffectType` has exactly 3 values: `dropShadow`, `outerGlow`, `layerBlur`. Drop shadow and outer glow are "outer effects" (`Effect.isOuterEffect`). Outer glow uses multi-pass `MaskFilter.blur` or `saveLayer + ImageFilter.blur` depending on path complexity.

**Background blur** is NOT in this canvas stack. It renders at the widget level via `BackdropFilter` + `_ElementShapeClipper` in `canvas_render_view.dart`. This is why background blur is the only inner effect with no color, opacity, or blend mode.

**Image filters and color adjust** are fills that capture and reprocess everything below them in the fill/stroke list via GLSL shaders. Place them at the top of the fills list to affect all fills below.

**Vector regions:** Vector elements with detected enclosed regions can carry per-region fills, including `innerShadow`/`innerGlow` (rendered per region) and per-region strokes with effect paint styles.

## Export Support

| Format | Effects Support |
|--------|----------------|
| PNG/JPEG/WebP | Full support (rasterized) |
| SVG | Drop shadow, outer glow, and layer blur via SVG filter primitives. Inner shadow, inner glow, background blur, shaders, image filters, and color adjust are pre-rasterized as embedded PNG images |
| PDF | Full support. All effects rasterized with transparency via soft masks; background blur rasterizes preceding content |

## Color Adjust (Fill)

A special fill type that applies non-destructive photo-style adjustments to all fills below it. Add via the type dropdown in the Fills section or the command palette ("Add Color Adjust").

### Parameters

Organized into 4 sections in the right toolbar (`ColorAdjustData`):

| Section | Parameters |
|---------|-----------|
| **Light** | Exposure, Contrast, Highlights, Shadows, Whites, Blacks, Brilliance |
| **Color** | Saturation, Vibrance, Temperature, Tint, Hue |
| **Detail** | Clarity, Sharpness |
| **Effects** | Vignette, Sepia, Inversion |

`ColorAdjustData` has 17 adjustment params plus `opacity`. Sliders also expose a separate Opacity row.

**Storage vs display:** Most parameters are stored as -1.0 to 1.0 floats and displayed as -100% to 100% in the inspector (`displayScale = 100`). Exceptions: Inversion and Sepia store 0.0 to 1.0 (UI 0-100%); Hue stores 0.0 to 360.0 degrees (no scaling). All defaults are 0 except `opacity` (default 1.0). When you set values in blueprints or via MCP, use the stored range, not the percentage. The data class `isDefault` getter returns true when all 17 adjustment params are 0 (regardless of opacity).

### Presets

A built-in preset dropdown offers quick starting points, organized into 4 categories:

| Category | Presets |
|----------|--------|
| **Basic** | Vivid, Warm, Cool, Dramatic, B&W |
| **Cinematic** | Noir, Vintage, Cinematic, Golden, Moody, Portrait |
| **Creative** | Lark, Clarendon, Dreamy, Fade, Chrome, Food, Landscape, Sepia, Punch |
| **Enhancement** | Sharp & Clear, Vintage Film |

The dropdown shows the active preset name when parameters match, and reverts to "Presets" when you manually adjust any slider.

### Key Behaviors

- **Z-order aware**: Processes all fills below it. Place it as the top fill to adjust everything.
- **Opacity**: Has its own opacity slider (separate from adjustments).
- **Non-destructive**: Original fills are preserved; remove the Color Adjust fill to restore them.
- **Vignette**: Positive values darken edges; negative values lighten edges toward white.
- **Clarity**: Enhances midtone local contrast for a "punchier" look.
- **Sharpness**: Enhances edges for crisper details.
- **Whites/Blacks**: Finer control than Highlights/Shadows, targeting only the very brightest/darkest tones.

## Tips

- **Subtle shadows**: Use `y:2/blur:4` with low opacity (0.1-0.2) for modern UI shadows
- **Elevation hierarchy**: Stack multiple drop shadows with increasing offset/blur for material depth
- **Frosted glass**: Combine background blur fill with a semi-transparent solid fill (white at 0.3-0.5 opacity)
- **Neon glow**: Outer glow with a bright color, high blur (12+), screen blend mode
- **Inset/pressed**: Inner shadow fill with y:2 and low opacity for a pressed button look
- **Z-order control**: Place an inner shadow between two solid fills for a custom depth effect
