---
assumes: blueprint/paint
---
# Effect: Liquid Glass

**Liquid glass is a real refractive fill (`glass`), not a blur+shadow stack.**
The native engine refracts the backdrop through a physically-modeled glass
slab, rim magnification, chromatic fringing, specular highlights. Bare
`glass` is the tuned Apple-like clear look, add params to taste. A clear
pane shows its backdrop through it: over a flat fill, dark included, you
see that fill plus the thin rim, so the refraction only reads where the
backdrop has something to bend (a shader, gradient, mesh or image), and a
light placed behind the pane still reads best. Use on one or two elevated
elements, never every panel.

Works on **rectangles, circles, vectors, frames, and text** (glyph
refraction). Engine-rendered: it appears in raster and video exports, and
embeds (pre-rasterized) in SVG / PDF. HTML / React export renders it as a
**live glass pane**: a frosted backdrop-blur tier that upgrades to an SVG
displacement filter (real refraction) in browsers that support it, so the pane
stays live instead of baked to an image.

**The lens auto-fits the shape.** `thickness`/`bevel` resolve against the
element's size the way corner radius does: on a small control (a button, a
chip) the lens scales down to fit, so bare `glass` is safe at any size.

**Glass text wants display sizes.** Glyph refraction is all rim, thin stems
have no interior, so glass text reads beautifully at hero sizes (≥ ~64px)
and fades to near-invisible below ~28px. For small text on glass, put a
solid-fill text child on a glass container instead.

**`blend()` on a glass element blends the whole pane.** `blend(multiply)`
composites the refracted pane against the backdrop with that mode, the
result reads as a solid tinted slab, not clearer glass. For a darker pane,
prefer a dark `tint(...)` inside the glass fill.

## Recipes

Copyable `glass(...)` fills (the five built-in looks, matching the app's
presets). Only non-default params are listed.

```
f[(glass)]                                                    Clear, max-depth clear slab, strong refraction
f[(glass(frost(24),thickness(64),bevel(80),ior(2),chroma(0.35),glow(0.05),edge(0.05),sat(1.1),tint(#FFFFFF,o(0.05))))]   Frosted, heavy frost, whisper of white
f[(glass(frost(4),thickness(64),bevel(120),ior(2),chroma(0.4),glow(0.01),edge(0.01)))]   Deep, full pull into the widest bevel
f[(glass(thickness(64),bevel(120),ior(3),chroma(0.5),glow(0.02),edge(0.01),sat(2)))]   Chromatic, max dispersion, vivid backdrop
f[(glass(frost(10),thickness(48),bevel(120),ior(2),chroma(0.25),glow(0.01),edge(0.01),sat(0.9),tint(#000000,o(0.5))))]   Smoke, dark smoked glass
```

Every param with its default and range, a full scene, and notes: `effects/glass-params`.
