---
name: "knowledge-effects-tokens-order"
description: "Design token binding on effects, composite shadow tokens, the rendering order, and export support."
assumes: reference/effects
---

# Effect Tokens, Rendering Order and Export

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

For export workflow and formats, see `reference/export`.
