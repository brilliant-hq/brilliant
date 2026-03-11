---
name: "knowledge-effects"
description: "Element visual effects in Brilliant: shadows, glows, and blurs."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Effects

Visual effects that enhance elements with shadows, glows, and blurs.

## Two Systems

Brilliant has two separate effect systems:

### Effects (Effects Section)

Effects apply to the entire element. Managed in the **Effects** section of the right toolbar:

| Type | Description |
|------|-------------|
| **Drop Shadow** | Shadow behind the element |
| **Outer Glow** | Luminous glow around the element |
| **Element Blur** | Blurs the element itself |

### Inner Shadow, Inner Glow, Background Blur (Fills Section)

These are fill types that appear in the **Fills** section, giving full z-order control:

| Type | Description |
|------|-------------|
| **Inner Shadow** | Shadow inside the element edges |
| **Inner Glow** | Luminous glow inside the element edges |
| **Background Blur** | Blurs content behind the element (frosted glass) |

They share the fills list with solid, gradient, image, and shader fills. You can interleave them — for example, place an inner shadow between two solid fills.

## Adding Effects

### Effects (Drop Shadow, Outer Glow, Element Blur)

Click the **+** button in the Effects section of the right toolbar.

### Inner Shadow, Inner Glow, Background Blur

These are fill types — add them as fills:
1. Click "+" in the Fills section
2. Use the type dropdown to switch to an inner effect type
3. Or use the color picker's library view to browse all effect and shader types

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

### Via Compact Format

Inner effects are specified as fills using the compact blueprint syntax:

| Type | Syntax | Example |
|------|--------|---------|
| Inner shadow | `f[(id,inner(#color,o(N),x(N),y(N),blur(N),sp(N)))]` | `f[(inner(#000000,o(0.5),y(2),blur(4)))]` |
| Inner glow | `f[(id,glow(#color,o(N),blur(N),sp(N)))]` | `f[(glow(#FFFFFF,o(0.6),blur(4)))]` |
| Background blur | `f[(id,blur(radius))]` | `f[(blur(12))]` |
| Metaballs shader | `f[(id,metaballs(#colors...,params...))]` | `f[(metaballs(#FF3377,#0080FF,count(15)))]` |

All `inner()` params are named and optional with defaults: color=#000000, opacity=0.5, offsetX=0, offsetY=2, blurRadius=4, spread=0, blendMode=srcOver. Only non-default params needed. Examples: `f[(inner())]` all defaults · `f[(inner(#FF0000))]` red · `f[(inner(#000,o(0.3),y(4),blur(8),sp(2)))]` with spread.

All `glow()` params are named and optional with defaults: color=#FFFFFF, opacity=0.6, blurRadius=4, spread=0, blendMode=screen. Only non-default params needed. Examples: `f[(glow())]` all defaults · `f[(glow(#3B82F6))]` blue · `f[(glow(#3B82F6,o(0.8),blur(12),sp(4)))]` with spread.

`blur(radius)` has one optional param, default 8. Pair with a low-opacity fill for frosted glass: `f[(solid(#FFF,o(0.1))),(f2,blur(12))]`.

`metaballs(#colors...,key(value)...)` — bare `#hex` values are colors, `key(value)` are named params. All optional. Params: `count` (1-20, default 10), `size` (0.05-1.0, default 0.83), `speed` (0-3, default 1.0). Default colors: #000000, #FF3377, #FF9900, #FFDD00, #0080FF. Examples: `f[(metaballs())]` all defaults · `f[(metaballs(#3B82F6,#EF4444))]` custom colors · `f[(metaballs(count(8),speed(2)))]` custom params.

Outer effects (drop shadow, outer glow, element blur) also have compact blueprint syntax as standalone tokens (not inside `f[...]`):

| Type | Syntax | Example |
|------|--------|---------|
| Drop shadow | `shadow(#color,o(opacity),x(n),y(n),blur(n),sp(n))` | `shadow(#000000,o(0.25),y(4),blur(8))` |
| Outer glow | `outerglow(#color,o(opacity),blur(n),sp(n))` | `outerglow(#FFFFFF,o(0.6),blur(8))` |
| Element blur | `eblur(radius)` | `eblur(4)` |

All params are named and optional with defaults matching the effect defaults above. `shadow()`, `outerglow()`, and `eblur()` with empty parens use all defaults. Or add via commands: `add_drop_shadow`, `add_outer_glow`, `add_layer_blur`.

## Effect Properties

### Drop Shadow

| Property | Range | Default |
|----------|-------|---------|
| X offset | -200 to 200 | 0 |
| Y offset | -200 to 200 | 4 |
| Blur | 0 to 200 | 8 |
| Spread | -100 to 100 | 0 |
| Color | Any | Black |
| Opacity | 0 to 1 | 0.25 |
| Blend Mode | Any | srcOver |

**Show behind transparent areas** — When enabled, the shadow shows through transparent fills. When disabled (default), the element shape is "knocked out" from the shadow.

### Outer Glow

| Property | Range | Default |
|----------|-------|---------|
| Blur | 0 to 200 | 8 |
| Spread | -100 to 100 | 0 |
| Color | Any | White |
| Opacity | 0 to 1 | 0.6 |
| Blend Mode | Any | Screen |

**Show behind transparent areas** — Supported at the data model level but not exposed in the UI for outer glow (only available for drop shadow via the UI toggle).

### Element Blur

| Property | Range | Default |
|----------|-------|---------|
| Radius | 0 to 200 | 4 |

### Inner Shadow (Fill)

| Property | Range | Default |
|----------|-------|---------|
| X offset | -200 to 200 | 0 |
| Y offset | -200 to 200 | 2 |
| Blur | 0 to 200 | 4 |
| Spread | -100 to 100 | 0 |
| Color | Any | Black |
| Opacity | 0 to 1 | 0.5 |
| Blend Mode | Any | srcOver |

### Inner Glow (Fill)

| Property | Range | Default |
|----------|-------|---------|
| Blur | 0 to 200 | 4 |
| Spread | -100 to 100 | 0 |
| Color | Any | White |
| Opacity | 0 to 1 | 0.6 |
| Blend Mode | Any | Screen |

### Background Blur (Fill)

| Property | Range | Default |
|----------|-------|---------|
| Radius | 0 to 200 | 8 |

### Design System Token Binding

Effect opacity can be bound to a design system token. When bound, the opacity resolves from the token value rather than the stored numeric value, and the token name appears in the opacity field. Manually editing the opacity clears the token binding.

## Managing Effects

### Effects (Effects Section)

| Action | How |
|--------|-----|
| Add effect | Click "+" in Effects section, or command palette: "Add Drop Shadow", "Add Outer Glow", etc. |
| Remove effect | Click "-" on the effect row, or command palette: "Remove Effect" |
| Toggle visibility | Click the eye icon, or command palette: "Toggle Effect Visibility" |
| Expand properties | Click the slider icon |
| Change type | Use the type dropdown (Drop Shadow, Outer Glow, Element Blur) |
| Reorder | Drag handle (when multiple effects) |

### Inner Shadow / Inner Glow / Background Blur (Fills Section)

| Action | How |
|--------|-----|
| Add effect fill | Click "+" in Fills section, then switch type |
| Remove | Click delete button on the fill row |
| Edit color | Click color swatch in expanded view |
| Change type | Use the type dropdown (shared with shaders) |
| Reorder | Drag to change z-order relative to other fills |

## Rendering Order

```
1. Opacity layer (if element.opacity < 1.0)
2.   Element blur layer (if element blur enabled)
3.     Effects (drop shadows + outer glows)
4.     Fills (solid, gradient, image, shaders, inner shadow, inner glow — ALL in z-order)
5.     Strokes
6.   Restore element blur
7. Restore opacity
```

Background blur is handled separately at the widget level using a backdrop filter.

## Export Support

| Format | Effects Support |
|--------|----------------|
| PNG/JPEG/WebP | Full support (rasterized) |
| SVG | Drop shadow, outer glow, and layer blur via SVG filter primitives. Inner shadow, inner glow, and background blur are pre-rasterized as embedded PNG images |
| PDF | Full support. All effects rasterized with transparency via soft masks; background blur rasterizes preceding content |

## Color Adjust (Fill)

A special fill type that applies non-destructive photo-style adjustments to all fills below it. Add via the type dropdown in the Fills section or the command palette ("Add Color Adjust").

### Parameters

Organized into 4 sections in the right toolbar:

| Section | Parameters |
|---------|-----------|
| **Light** | Exposure, Contrast, Highlights, Shadows, Whites, Blacks, Brilliance |
| **Color** | Saturation, Vibrance, Temperature, Tint, Hue |
| **Detail** | Clarity, Sharpness |
| **Effects** | Vignette, Sepia, Inversion |

All parameters are displayed as percentages in the UI, ranging from -100 to 100, except Inversion and Sepia (0 to 100) and Hue (0 to 360 degrees). Default is 0.

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

- **Z-order aware** — Processes all fills below it. Place it as the top fill to adjust everything.
- **Opacity** — Has its own opacity slider (separate from adjustments).
- **Non-destructive** — Original fills are preserved; remove the Color Adjust fill to restore them.
- **Vignette** — Positive values darken edges; negative values lighten edges toward white.
- **Clarity** — Enhances midtone local contrast for a "punchier" look.
- **Sharpness** — Enhances edges for crisper details.
- **Whites/Blacks** — Finer control than Highlights/Shadows, targeting only the very brightest/darkest tones.

## Tips

- **Subtle shadows** — Use `y:2/blur:4` with low opacity (0.1-0.2) for modern UI shadows
- **Elevation hierarchy** — Stack multiple drop shadows with increasing offset/blur for material depth
- **Frosted glass** — Combine background blur fill with a semi-transparent solid fill (white at 0.3-0.5 opacity)
- **Neon glow** — Outer glow with a bright color, high blur (12+), screen blend mode
- **Inset/pressed** — Inner shadow fill with y:2 and low opacity for a pressed button look
- **Z-order control** — Place an inner shadow between two solid fills for a custom depth effect
