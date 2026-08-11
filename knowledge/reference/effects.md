---
name: "knowledge-effects"
description: "Element visual effects in Brilliant: drop shadow, outer glow, element blur, inner shadow, inner glow, background blur, and color adjust: where they live in the UI, their properties, and limits."
---

# Effects

Visual effects that enhance elements with shadows, glows, and blurs. Effects are non-destructive: they wrap or layer over the element's geometry and can be toggled, reordered, or removed without altering the underlying shape.

## Two Systems (Two UI Homes)

Effects are split across two storage models with two different panels in the right toolbar. Which home an effect lives in determines its z-order behavior.

### Effects section

Three effect types, managed in the **Effects section** of the right toolbar:

| Type | UI Label | Description | Z-order |
|------|----------|-------------|---------|
| Drop Shadow | Drop Shadow | Shadow cast behind the element | Always paints behind the element body |
| Outer Glow | Outer Glow | Luminous glow around the element | Always paints behind the element body |
| Element Blur | Element Blur | Blurs the element itself (fills, strokes, shadows, glows) | Wraps the whole element |

Drop shadows and outer glows always render behind the element, regardless of where they sit in the effects list. Stacking multiple shadows or glows is supported; later entries in the list paint on top of earlier ones.

### Fills / Strokes section

Inner shadow, inner glow, and background blur are **fill types**, not entries in the Effects section. They live in the element's Fills list (and can also be applied as strokes) and participate in full z-order alongside solid, gradient, image, shader, and filter fills.

| Type | Description |
|------|-------------|
| Inner Shadow | Shadow inside the element's edges (inset look) |
| Inner Glow | Luminous glow inside the element's edges |
| Background Blur | Blurs the canvas content showing through the element (frosted glass) |

Because these are fills, you can interleave them with other fills, for example placing an inner shadow between two solid fills for a custom depth effect.

**Color Adjust** is also a fill type (photo-style adjustments applied to everything beneath it). See the Color Adjust section below. Image filters (noise/grain, halftone, pixelate, duotone, posterize, dither) are likewise fill types; see [image-filters.md](./image-filters.md).

**Liquid Glass** is also a fill (and stroke) type: a real refractive glass pane rendered by the engine (not a blur + shadow stack). It lives in the fill/stroke type dropdown under **Static** (labeled "Glass"), with its own preset chooser (Clear, Frosted, Deep, Chromatic, Smoke) and a Tint control. For the full recipe and params, see the `effects/glass` knowledge file.

## Adding Effects

### Drop Shadow, Outer Glow, Element Blur

Click the **+** button on the Effects section header in the right toolbar. The first add inserts a **drop shadow** with default settings (the + button is not a type chooser). To change the type, use the type dropdown on the effect row (Drop Shadow / Outer Glow / Element Blur). Switching type resets the effect to that type's defaults.

### Inner Shadow, Inner Glow, Background Blur

These are fill types, so add them through the Fills section (they also work as strokes):

1. Click **+** in the Fills section (or Strokes section) to add a fill.
2. Open the fill row's type dropdown and select the effect type. Inner Shadow, Inner Glow, and Background Blur are grouped under "Static" in the dropdown.

### Via command palette

Open the command palette (Cmd+Shift+P) and run any of these by name:

| Command |
|---------|
| Add Drop Shadow |
| Add Outer Glow |
| Add Element Blur |
| Add Inner Shadow |
| Add Inner Glow |
| Add Background Blur |
| Add Color Adjust |

> For Blueprint DSL authoring of effects (the compact syntax used by `create_modify_elements`), see the blueprint knowledge files. Do not author DSL from this reference.

## Managing Effects

### Effects section (Drop Shadow / Outer Glow / Element Blur)

The effect row's controls, left to right: a color swatch (drop shadow and outer glow only; tap to open the color picker) or blur icon, an inline opacity % field, an expand toggle, and a remove (minus) button.

| Action | How |
|--------|-----|
| Remove | Click the minus button on the row |
| Toggle visibility | Expand the row, then click the eye icon in the expanded body |
| Expand properties | Click the expand (sliders) toggle on the row to show/hide the property fields |
| Change type | Use the type dropdown on the row (Drop Shadow / Outer Glow / Element Blur) |
| Edit color | Tap the color swatch on the row, or use the hex/token field in the expanded body (drop shadow and outer glow only) |
| Set blend mode | Use the inline blend-mode dropdown in the expanded body (drop shadow and outer glow only) |
| Reorder | When 2+ effects exist, drag a row to reorder. The list is shown topmost-first; the top row is the highest in render order |

With 2 or more effects, the rows become drag-reorderable; a single effect has no drag handle. When multiple elements are selected, the Effects section displays the **first selected element's** effects, but edits apply across the whole selection.

### Fills section (Inner Shadow / Inner Glow / Background Blur)

| Action | How |
|--------|-----|
| Remove | Click the delete button on the fill row |
| Edit color | Tap the color swatch on the row, or use the hex/token field in the expanded body (inner shadow and inner glow only; background blur has no color) |
| Edit parameters | Expand the fill row, then adjust the numeric fields. Background blur shows only a radius field |
| Set blend mode | Inline blend-mode field beside the color in the expanded body (inner shadow and inner glow only) |
| Change type | Use the fill type dropdown (shared with solid/gradient/image/shader/filter types) |
| Reorder | Drag the fill row to change z-order relative to other fills |

## Effect Properties

Numeric fields can be typed directly or scrubbed by dragging the field. Opacity displays as 0-100% in the UI.

### Drop Shadow

| Property | Range | Default |
|----------|-------|---------|
| X offset | -200 to 200 | 0 |
| Y offset | -200 to 200 | 4 |
| Blur | 0 to 200 | 8 |
| Spread | -100 to 100 | 0 |
| Color | Any | Black |
| Opacity | 0 to 100% | 25% |
| Blend Mode | Any of the standard blend modes | Normal |
| Show Behind Transparent Areas | toggle | off |

**Show Behind Transparent Areas:** when off (default), the element's shape is knocked out of the shadow (Figma-style). When on, the shadow shows through transparent fills. This toggle is exposed in the UI for drop shadow only.

### Outer Glow

| Property | Range | Default |
|----------|-------|---------|
| Blur | 0 to 200 | 8 |
| Spread | -100 to 100 | 0 |
| Color | Any | White |
| Opacity | 0 to 100% | 60% |
| Blend Mode | Any | Screen |

Outer glow is symmetric: there are no X/Y offset fields in the inspector (it always emanates evenly).

### Element Blur

| Property | Range | Default |
|----------|-------|---------|
| Radius | 0 to 200 | 4 |

Element Blur has no color or blend mode. The effect row still shows the inline opacity % field (shared by all effect rows), but opacity has no rendering effect for a blur. Element Blur blurs the entire element (fills, strokes, drop shadows, and outer glows) as one unit, inside the element's opacity layer.

### Inner Shadow (fill)

| Property | Range | Default |
|----------|-------|---------|
| X offset | -200 to 200 | 0 |
| Y offset | -200 to 200 | 2 |
| Blur | 0 to 200 | 4 |
| Spread | -100 to 100 | 0 |
| Color | Any | Black |
| Opacity | 0 to 100% | 50% |
| Blend Mode | Any | Normal |

### Inner Glow (fill)

| Property | Range | Default |
|----------|-------|---------|
| Blur | 0 to 200 | 4 |
| Spread | -100 to 100 | 0 |
| Color | Any | White |
| Opacity | 0 to 100% | 60% |
| Blend Mode | Any | Screen |

Inner glow has no offset fields (unlike inner shadow). Use spread for size and blur for softness.

### Background Blur (fill)

| Property | Range | Default |
|----------|-------|---------|
| Radius | 0 to 200 | 8 |

Background blur has no color, no opacity, and no blend mode. The radius field is the only control. Pair it with a low-alpha solid fill above it for the standard frosted-glass look.

## Design System Token Binding

Effect color and opacity can each be bound to design system tokens, independently. When bound, the color/opacity resolves through the element's active design system (canvas/folder mode, ancestor overrides) at display time, and the stored literal value acts as the offline fallback. Inner shadow and inner glow support the same color and opacity token binding. Background blur has no color or opacity, so no bindings.

Manually editing a token-bound value clears that binding (the value becomes a fixed literal again).

For design-system authoring (defining tokens, modes, brands), see the design-systems knowledge files.

## Composite Shadow Tokens

A design system can define composite shadow tokens that bundle multiple drop-shadow layers (each with its own color, offset, blur, spread, opacity) under one named token, for consistent elevation. Applying a shadow token replaces all existing drop shadows on the element while leaving outer glow and element blur untouched. Manually editing any drop shadow on a token-bound element clears the binding. See the design-systems knowledge files for defining these tokens.

## Rendering Order

The per-element layer stack, top to bottom:

1. Element opacity / blend-mode layer (if element opacity < 100% or blend mode is not Normal)
2. Element Blur wrap (if an Element Blur effect is enabled)
3. Drop shadows and outer glows (behind the body, in Effects section order)
4. Fills in z-order: solid, gradient, image, shaders, liquid glass, inner shadow, inner glow, image filters, color adjust
5. Strokes (same supported types as fills)

**Background blur** is not part of this canvas stack: it samples and blurs the canvas content showing through the element. This is why it has no color, opacity, or blend mode.

**Color adjust and image filters** capture and reprocess everything below them in the fill/stroke list. Place them at the top of the Fills list to affect all fills beneath.

**Vector regions:** vector elements with detected enclosed regions can carry per-region fills, including inner shadow and inner glow rendered per region.

## Export Support

| Format | Effects support |
|--------|----------------|
| PNG / JPEG / WebP | Full (rasterized) |
| SVG | Drop shadow, outer glow, and element blur export as SVG filter primitives. Inner shadow, inner glow, background blur, shaders, image filters, and color adjust are pre-rasterized as embedded PNG images |
| PDF | Full. Effects rasterized with transparency; background blur rasterizes the content behind the element |

For export workflow and formats, see [export.md](./export.md).

## Color Adjust (fill)

A special fill type that applies non-destructive, photo-style adjustments to all fills below it. Add it via the fill type dropdown (under "Filters") or the command palette ("Add Color Adjust").

### Parameters

Organized into 4 groups in the expanded fill row, plus a separate opacity control:

| Group | Parameters |
|-------|-----------|
| Light | Exposure, Contrast, Highlights, Shadows, Whites, Blacks, Brilliance |
| Color | Saturation, Vibrance, Temperature, Tint, Hue |
| Detail | Clarity, Sharpness |
| Effects | Vignette, Sepia, Inversion |

Most sliders display as -100% to 100%; Inversion and Sepia are 0-100%; Hue is 0-360 degrees. All adjustments default to 0 (no change); opacity defaults to 100%.

### Presets

A preset dropdown offers quick starting points in 4 categories:

| Category | Presets |
|----------|--------|
| Basic | Vivid, Warm, Cool, Dramatic, B&W |
| Cinematic | Noir, Vintage, Cinematic, Golden, Moody, Portrait |
| Creative | Lark, Clarendon, Dreamy, Fade, Chrome, Food, Landscape, Sepia, Punch |
| Enhancement | Sharp & Clear, Vintage Film |

The dropdown shows the active preset name when sliders match it, and reverts to "Presets" once you manually adjust any slider.

### Key behaviors

- **Z-order aware:** processes all fills below it. Place it as the top fill to adjust everything.
- **Non-destructive:** original fills are preserved; remove the Color Adjust fill to restore them.
- **Opacity:** has its own opacity control, separate from the adjustments.
- **Vignette:** positive values darken edges; negative values lighten edges toward white.
- **Clarity:** enhances midtone local contrast for a punchier look.
- **Sharpness:** enhances edges for crisper detail.
- **Whites / Blacks:** finer control than Highlights / Shadows, targeting only the very brightest and darkest tones.

## Tips

- **Subtle UI shadows:** small Y offset (2) and small blur (4) with low opacity (10-20%).
- **Elevation hierarchy:** stack multiple drop shadows with increasing offset and blur for material depth.
- **Frosted glass:** a Background Blur fill plus a semi-transparent solid fill above it (white at 30-50%).
- **Neon glow:** Outer Glow with a bright color, high blur (12+), and Screen blend mode.
- **Inset / pressed look:** Inner Shadow with a small Y offset and low opacity.
- **Custom depth:** place an Inner Shadow between two solid fills to control where the inset appears in the stack.
