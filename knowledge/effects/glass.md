---
assumes: blueprint/paint
---
# Effect: Liquid Glass

Assumes: `blueprint/paint`

**Liquid glass is a real refractive fill (`glass`), not a blur+shadow stack.**
The native engine refracts the backdrop through a physically-modeled glass
slab, rim magnification, chromatic fringing, specular highlights. Bare
`glass` is the tuned Apple-like clear look; add params to taste. It reads
only over a **rich backdrop** (shader, gradient, mesh, image), over a flat
fill it collapses to a near-invisible pane. Use on one or two elevated
elements, never every panel.

Works on **rectangles, circles, vectors, frames, and text** (glyph
refraction). Engine-rendered: it appears in raster and video exports, and
embeds (pre-rasterized) in SVG / PDF. HTML / React export renders it as a
**live glass pane**: a frosted backdrop-blur tier that upgrades to an SVG
displacement filter (real refraction) in browsers that support it, so the pane
stays live instead of baked to an image.

**The lens auto-fits the shape.** `thickness`/`bevel` resolve against the
element's size the way corner radius does: on a small control (a button, a
chip) the lens scales down to fit, so bare `glass` is safe at any size, no
need to hand-shrink params for small elements.

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
presets). Only non-default params are listed; bare `glass` = Clear (the
creation default).

```
f[(glass)]                                                    Clear, max-depth clear slab, strong refraction
f[(glass(frost(24),thickness(64),bevel(80),ior(2),chroma(0.35),glow(0.05),edge(0.05),sat(1.1),tint(#FFFFFF,o(0.05))))]   Frosted, heavy frost, whisper of white
f[(glass(frost(4),thickness(64),bevel(120),ior(2),chroma(0.4),glow(0.01),edge(0.01)))]   Deep, full pull into the widest bevel
f[(glass(thickness(64),bevel(120),ior(3),chroma(0.5),glow(0.02),edge(0.01),sat(2)))]   Chromatic, max dispersion, vivid backdrop
f[(glass(frost(10),thickness(48),bevel(120),ior(2),chroma(0.25),glow(0.01),edge(0.01),sat(0.9),tint(#000000,o(0.5))))]   Smoke, dark smoked glass
```

Tint takes a `$token` (resolved at create time) or `#hex`, with opacity as a
`$visibility.*` token, its alpha is the tint strength (clear by default):

```
f[(glass(tint($color.surface,o($visibility.soft)),frost(12)))]   light frosted tint
```

## Params

`glass(frost(N),thickness(N),bevel(N),ior(N),chroma(N),glow(N),edge(N),angle(DEG),sat(N),tint(color[,o(N)]))`

| Param | Default | Range | Effect |
|---|---|---|---|
| `frost` | 0 | ≥0 | backdrop blur sigma (0 = crisp pane) |
| `thickness` | 64 | 0..64 | slab depth; how far light bends (0 = plain blur, no refraction) |
| `bevel` | 60 | 0..120 | rim band width where the lens rises |
| `ior` | 3 | 1..3 | index of refraction; higher bends more |
| `chroma` | 0.8 | 0..3 | chromatic fringe at the rim (1 = strong; >1 = extreme dispersion) |
| `glow` | 0 | 0..1 | luminous rim glow |
| `edge` | 0 | 0..1 | specular rim highlight |
| `angle` | 135 | degrees | light direction (135 = top-left) |
| `sat` | 1.05 | 0..2 | backdrop saturation remix (vibrancy) |
| `tint` | clear | - | `$token`/`#hex` + `o($visibility.*)` |

Out-of-range values clamp with a diagnostic; unknown params are dropped and
surfaced. Glass is fill-only, `glass` in `st[...]` is an error.

## Scene

Glass card over a shader backdrop. The card carries the `glass` fill and a
faint bright edge; text lives in children with their own solid fills (never
draw text directly onto the refraction).

```
fr s(640,400) clip f[(metaballs($violet.mid,$pink.mid,$amber.mid,$primary.mid))] rd($radius.lg) "Hero"
  al(v,y(c),x(c),g($spacing.sm),pad($spacing.lg)) p(c,c) s(360,hug) f[(glass(frost(8),chroma(0.4)))] st[(solid($color.glow,o($visibility.subtle)),w($stroke.width.subtle))] rd($radius.lg) "Card"
    t("Liquid Glass",$font.family,$font.size.xl,sb) f[($color.glow)] "Title"
    t("Refracts the backdrop through a real glass slab.",$font.family,$font.size.sm,r) s(fill,hug) f[(solid($color.glow,o($visibility.firm)))] "Sub"
```

## Notes

- **Backdrop matters.** More texture and contrast under the glass = more
  visible refraction. Add `shadow(...)` under the card to float it.
- **Glass wants a backdrop.** Over a transparent or empty canvas there is
  nothing to refract, so the pane renders near-invisible (correct physics,
  surprising if you expected a visible slab): put it over a filled parent,
  shader, gradient, or image.
- **Dark scenes:** use `$color.glow` (mode-immune near-white) for the edge
  stroke and text; a low-opacity dark `tint` deepens the smoke look.
- **Clear vs frosted:** `frost(0)` keeps the backdrop sharp through the lens;
  raise `frost` for the diffused frosted-glass read.
