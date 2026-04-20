---
assumes: blueprint/shaders/overview
dsl: [metal, chrome, softness, repetition, aberration]
---
# Shader: Liquid Metal

Assumes: `blueprint/shaders/overview`

Chrome or brushed aluminum with chromatic aberration. The material has weight — catches and bends light.

## Parameters

`softness(N)` edge smoothness · `repetition(N)` stripe count (more = brushed texture) · `contour(N)` ridge visibility · `angle(N)` light direction · `shiftRed(N)`/`shiftBlue(N)` chromatic aberration · Custom colors as positional args

## Recommended Palettes

- `f[(metal())]` — default silver chrome (Mercury)
- `f[(metal(#C9911A,#FFF1C1))]` — Molten Gold
- `f[(metal(#B27068,#FFE4E0))]` — Rose Chrome
- `f[(metal(#B87333,#FFE0C0))]` — Copper
- `f[(metal(#2A2D35,#8090A0))]` — Obsidian (dark)
- `f[(metal(#1A1A3E,#7090C0))]` — Midnight (cool blue)

## Examples

**Glass card over metal background (inner shadow glass variant):**
```
fr s(480,280) f[(#000),(f2,metal(#B0B3B8,#FFFFFF,softness(0.05),repetition(2.50),shiftRed(0.15),shiftBlue(0.20),contour(0.50),angle(60),speed(0.80)))] rd($radius.lg) clip "Hero" #metal_hero
  al(v,a(c,c),g($spacing.3),pad($spacing.8)) s(320,hug) f[(solid(#FFF,o(0.08))),(f2,blur(12)),(f3,inner(#000,o(0.08),y(1),blur(3)))] st[(linear(135,solid(#FFF,o(0.20)),solid(#FFF,o(0.05))),w(1))] rd($radius.md) shadow(#000,o(0.12),y(8),blur(24)) abs p(80,71) "Glass" #metal_glass
    t("Liquid Metal",Inter,28,sb,align(c)) f[(#FAFAFA)] "Title" #metal_title
    t("Chrome surface catches light",Inter,14,align(c)) s(fill,hug) f[(solid(#FAFAFA,o(0.65)))] "Sub" #metal_sub
```

**Metallic accent divider (3px, massive visual impact):**
```
r s(200,3) f[(metal(#FFD700,#FFF8DC,softness(0.5),speed(0.2)))] rd($radius.full) "Divider" #metal_divider
```

## Best Uses

Metal fills are extremely busy — use on strokes, accents, or dividers. For buttons: `f[(#18181B)] st[(metal(),w(2))]` — text sits on solid fill, metal catches light on the edge. Use `scale(2-4)` on button strokes for more detail.
