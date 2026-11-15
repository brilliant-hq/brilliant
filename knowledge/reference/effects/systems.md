---
name: "knowledge-effects-systems"
description: "The two homes of effects: the Effects section and the Fills list, and the fill types that are effects."
assumes: reference/effects
---

# Two Systems (Two UI Homes)

Effects are split across two storage models with two different panels in the right toolbar. Which home an effect lives in determines its z-order behavior.

## Effects section

Three effect types, managed in the **Effects section** of the right toolbar:

| Type | UI Label | Description | Z-order |
|------|----------|-------------|---------|
| Drop Shadow | Drop Shadow | Shadow cast behind the element | Always paints behind the element body |
| Outer Glow | Outer Glow | Luminous glow around the element | Always paints behind the element body |
| Element Blur | Element Blur | Blurs the element itself (fills, strokes, shadows, glows) | Wraps the whole element |

Drop shadows and outer glows always render behind the element, regardless of where they sit in the effects list. Stacking multiple shadows or glows is supported; later entries in the list paint on top of earlier ones.

## Fills / Strokes section

Inner shadow, inner glow, and background blur are **fill types**, not entries in the Effects section. They live in the element's Fills list (they are fill-only: strokes offer no Effect or Filter types) and participate in full z-order alongside solid, gradient, image, shader, and filter fills.

| Type | Description |
|------|-------------|
| Inner Shadow | Shadow inside the element's edges (inset look) |
| Inner Glow | Luminous glow inside the element's edges |
| Background Blur | Blurs the canvas content showing through the element (frosted glass) |

Because these are fills, you can interleave them with other fills, for example placing an inner shadow between two solid fills for a custom depth effect.

**Color Adjust** is also a fill type (photo-style adjustments applied to everything beneath it). See the Color Adjust section below. Image filters (noise/grain, halftone, pixelate, duotone, posterize, dither) are likewise fill types; see `reference/image-filters`.

**Liquid Glass** is also a fill-only type (strokes cannot carry it): a real refractive glass pane rendered by the engine (not a blur + shadow stack). It lives in the fill type dropdown under **Effect** (labeled "Liquid Glass", the first entry), with its own preset chooser (Clear, Frosted, Deep, Chromatic, Smoke) and a Tint control. For the full recipe and params, see the `effects/glass` knowledge file.
