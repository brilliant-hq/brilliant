---
name: "knowledge-effects-liquid-glass"
description: "The Liquid Glass fill: how it renders and exports, its parameters with defaults, the tint, and its presets."
assumes: reference/effects
---

# Liquid Glass

| Fill type | Description |
|-----------|-------------|
| Liquid Glass | Refracts the content behind the element like a glass lens (rim magnification, chromatic fringing, specular highlights, glow) |

**Liquid Glass** is engine-rendered: the native canvas refracts the backdrop through a physically-modeled glass slab. It appears in raster (PNG/JPEG/WebP) and video exports, and embeds as a rasterized image in SVG/PDF. HTML/React export omits it (no CSS equivalent). It applies to rectangles, circles, vectors, frames, and text (glyph refraction). Parameters (with defaults): **Thickness** 64 (glass slab thickness, 0–64px, how far the refracted ray travels; 0 = plain backdrop blur), **Bevel** 60 (rim band width where the surface rises), **IOR** 3.0 (index of refraction, 1.0–3.0; higher bends light more), **Chroma** 0.8 (chromatic dispersion, 0–3; >1 = extreme fringing), **Glow** 0 (additive rim glow, 0–1), **Edge** 0 (specular rim highlight, 0–1), **Angle** 2.3561945 rad / 135° (light direction, top-left), **Saturation** 1.05 (backdrop saturation remix, 0–2), **Blur** 0 (backdrop blur sigma). Two more parameters exist in the Blueprint DSL only (no inspector sliders): **Gathering** 1.0 (0–1, how much exterior content the rim lens pulls in; 0 = interior-only refraction, which is how Figma-imported glass arrives) and **Magnification** 1.0 (0–2, multiplies the rim's lateral displacement). All values are plain numbers (not token-bindable).

The color row for a glass fill is the material **Tint** (labeled "Tint" in the inspector), not an opaque fill, its alpha is the tint strength (0 alpha = clear glass). The glass section opens with a **Presets** dropdown that applies a full parameter bundle in one undoable step (a reset button restores defaults). Five presets ship (rim glow and specular rim are held at or below 0.1 on every preset): **Clear** (max-depth clear slab, maximum thickness and refraction, no glow), **Frosted** (heavy frost over a thick slab with a whisper of white tint), **Deep** (full thickness pulled into the widest bevel, near-zero rim), **Chromatic** (maximum refraction and dispersion with a vivid, double-saturated backdrop), **Smoke** (half-strength black tint, blurred desaturated backdrop). Editing any slider or the tint after applying a preset is fine, presets are just starting-point bundles, not a locked mode.
