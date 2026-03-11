---
assumes: blueprint/shaders/overview
---
# Shader: Holographic

Assumes: `blueprint/shaders/overview`

Holographic foil — iridescent surface like security stickers and collector cards. Rainbow reflections shift with angle.

## Parameters

`intensity(N)` rainbow strength · `spread(N)` fold density · `metallic(N)` metallic vs matte · `noise(N)` surface complexity · `speed(N)` shimmer rate · Custom colors as positional args

## Param Reference

- `f[(holo())]` — default foil
- `f[(holo(#FF00FF,#00FFFF,#FFFF00))]` — custom brand colors
- `f[(holo(intensity(0.4),metallic(0.9),speed(0.2)))]` — restrained shimmer
- `f[(#1C1917),(f2,holo(opacity(0.15)))]` — low-opacity texture under solid

## Examples

**Holographic badge (shader on stroke, text stays readable):**
```
al(h,a(c,c),pad(4,12)) s(hug,hug) f[(#1E1B4B),(f2,glow(#C7D2FE,o(0.3),blur(6)))] st[(holo(#E879F9,#67E8F9,intensity(0.5),metallic(0.8),speed(0.3)),w(1.5))] rd(9999) shadow(#8B5CF6,o(0.15),blur(12))
  t("Featured",Inter,12,sb) f[(#E0E7FF)]
```

**Glass card over holo background:**
```
fr s(480,280) f[(#000),(f2,holo(#0022FF,#3500FF,intensity(0.90),spread(0.10),metallic(0.70),speed(0.80),scale(0.25))),(f3,solid(#000,o(0.60)))] rd(20) clip "Hero"
  al(v,a(c,c),g(16),pad(32)) s(fill,fill) f[(solid(#FFF,o(0.08)))] st[(solid(#FFF,o(0.10)),w(1))] rd(16) "Glass"
    t("Holographic",Inter,28,sb,c) f[(#FAFAFA)] "Title"
    t("Iridescent foil shimmer",Inter,14,c) s(fill,hug) f[(solid(#FAFAFA,o(0.65)))] "Sub"
```

## Best Uses

Holo fills shift between light and dark — no text color works on them. Use on strokes `st[(holo(),w(2))]` or as low-opacity texture under a solid fill.
