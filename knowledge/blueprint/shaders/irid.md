---
assumes: blueprint/shaders/overview
dsl: [irid, spread, intensity, metallic]
---
# Shader: Iridescent

Assumes: `blueprint/shaders/overview`

Iridescent liquid crystal — deep shifting colors with metallic surface tension. The default (Oil Slick) produces a dark, luxurious look. Supports 3 colors.

## Parameters

`intensity(N)` color strength · `spread(N)` fold density · `metallic(N)` metallic vs matte · `noise(N)` surface complexity · `speed(N)` shimmer rate · Custom colors as positional args

## Recommended Palettes

- `f[(irid())]` — Oil Slick (default: deep purple/teal/violet)
- `f[(irid(#0A0A2E,#F97316,#8B5CF6))]` — Deep Sapphire
- `f[(irid(#0D0D0D,#10B981,#06B6D4))]` — Dark Emerald
- `f[(irid(#050510,#6366F1,#A855F7))]` — Void Indigo
- `f[(irid(#EC4899,#A855F7,#6366F1))]` — Pink Nebula
- `f[(irid(#10B981,#06B6D4,#F59E0B))]` — Aqua Prism
- `f[(irid(#FFF5F5,#F0FDFA,#FAF5FF))]` — Pearl (light)

## Examples

**Iridescent badges (shader on stroke, text stays readable):**
```
al(h,x(c),y(c),g(6),pad($spacing.2,$spacing.4)) s(hug,hug) f[(#0F172A)] st[(irid(#EC4899,#A855F7,#6366F1),w(2))] rd($radius.sm) shadow(#A855F7,o(0.20),blur(16)) #badge_premium
  svg(icon:star) s(12,12) f[(#E0E7FF)] #badge_icon
  t("Premium",Inter,12,sb) f[(#E0E7FF)] #badge_label
al(h,x(c),y(c),g(6),pad($spacing.2,$spacing.4)) s(hug,hug) f[(#1C1917)] st[(irid(#F59E0B,#EF4444,#EC4899),w(2))] rd($radius.full) shadow(#EF4444,o(0.15),blur(12)) #badge_hot
  svg(icon:fire) s(12,12) f[(#FDE68A)] #hot_icon
  t("Hot",Inter,12,sb) f[(#FDE68A)] #hot_label
al(h,x(c),y(c),g($spacing.none),pad($spacing.2,$spacing.4)) s(hug,hug) f[(irid(#10B981,#06B6D4,#FBBF24,shape(metaballs),intensity(0.90),spread(0.45),noise(0.50),metallic(0.40),speed(0.70),opacity(0.30)))] st[(solid(#FFF,o(0.15)),w(1))] rd($radius.full) #badge_tropical
  t("Tropical",Inter,12,sb) f[(#FFF)] #tropical_label
```

**Glass card over iridescent background:**
```
fr s(360,220) f[(#000),(f2,irid(#EC4899,#A855F7,#6366F1)),(f3,solid(#000,o(0.40)))] rd($radius.lg) clip "Hero" #hero
  al(v,y(c),x(c),g($spacing.3),pad($spacing.6)) s(280,hug) f[(solid(#FFF,o(0.06))),(f2,blur(2)),(f3,inner(#FFF,o(0.06),y(-1),blur(2))),(f4,glow(#FFF,o(0.20)))] st[(linear(180,solid(#FFF,o(0.15)),solid(#FFF,o(0.03))),w(1))] rd($radius.lg) shadow(#000,o(0.20),y(12),blur(32)) abs p(40,c) "Glass" #glass
    t("Pink Nebula",Inter,24,sb,align(c)) f[(#FAFAFA)] #title
    t("Custom palette",Inter,14,align(c)) f[(solid(#FAFAFA,o(0.65)))] #sub
```

## Best Uses

Dark palettes produce the most striking results. Use on strokes `st[(irid(),w(2))]` for buttons, as a background with dim overlay, or as low-opacity texture under a solid fill `f[(#1C1917),(f2,irid(opacity(0.15)))]`.
