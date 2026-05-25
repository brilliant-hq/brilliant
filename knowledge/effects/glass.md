---
assumes: blueprint/effects
---
# Effect: Glass

**Glass = tint + backdrop blur + edge, all on one element.** `blur()` is a true backdrop filter, so glass only reads over a **textured backdrop** (shader, gradient, radial mesh, image) — over a flat fill it collapses to a tinted rectangle. Use on one or two elevated elements, never every panel.

**Tint depends on the scene, not the theme:** light backdrop → `$color.surface`; dark backdrop / shader → `$color.glow` (mode-immune near-white). Never `$color.surface` on dark — it resolves near-black and the glass vanishes. (`$color.glow`/`$color.shadow` are the always-light/always-dark anchors.)

## Glass — light scene

Pastel metaballs make a great light backdrop — `$color.surface` as the first
color dilutes the blobs toward white, and `.soft` stops keep them gentle.

```
fr s(900,360) clip f[(metaballs($color.surface,$violet.soft,$pink.soft,$quaternary.soft,$primary.soft,count(19),size(0.25),speed(0.3),scale(3)))] rd($radius.lg) "Scene"
  al(v,y(c),x(c),g($spacing.sm),pad($spacing.lg)) p(c,c) s(420,hug) f[(solid($color.surface,o($visibility.subtle))),(f2,blur(16)),(f3,inner($color.shadow,o($visibility.hint),y(1),blur(3)))] st[(solid($color.surface,o($visibility.soft)),w($stroke.width.subtle))] rd($radius.lg) shadow($color.shadow,o($visibility.faint),y(2),blur(4)) shadow($color.shadow,o($visibility.faint),y(8),blur(24)) "Glass"
    t("Glass over metaballs",$font.family,$font.size.lg,sb) f[($color.text.primary)]
    t("Soft solid edge, inner shadow, two drop shadows to float.",$font.family,$font.size.sm,r) s(fill,hug) f[($color.text.secondary)]
```

## Glass — dark scene

`$color.glow` tint, inner `glow()` edge, `subtle` tint + `blur(20)`. Flowing
`steel()` is a calm, premium dark backdrop that needs no dim overlay (a bright
shader like `irid()` would — stack `solid($color.shadow,o($visibility.soft))`).

```
fr s(900,360) ds(, theme(dark)) clip f[(steel($primary.faint,$secondary.faint,flow(0.5),roughness(0.3),distortion(1),depth(1),angle(45),speed(0.4),scale(2)))] rd($radius.lg) "Scene"
  al(v,y(c),x(c),g($spacing.sm),pad($spacing.lg)) p(c,c) s(420,hug) f[(solid($color.glow,o($visibility.subtle))),(f2,blur(20)),(f3,glow($color.glow,o($visibility.subtle),blur(6)))] st[(solid($color.glow,o($visibility.subtle)),w($stroke.width.subtle))] rd($radius.lg) shadow($color.shadow,o($visibility.firm),y(8),blur(24)) "Glass"
    t("Glass over steel",$font.family,$font.size.lg,sb) f[($color.text.primary)]
    t("Flowing liquid-steel backdrop, subtle tint keeps text crisp.",$font.family,$font.size.sm,r) s(fill,hug) f[($color.text.secondary)]
```

## Notes

- **Tint opacity:** `faint` = airy frost (start here), `subtle` = more body / busy backdrops, `soft`+ = opaque panel (not glass). Pair higher tint with more blur.
- **Radial-mesh backdrop:** stack radials, but each OUTER stop must be transparent — `solid($color.shadow,o($visibility.invisible))`. An opaque outer stop occludes the layers beneath, so only the last shows.
- **Text never sits on the blur** — put it in a child with its own solid fill.
