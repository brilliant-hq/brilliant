---
assumes: blueprint/shaders/overview
---
# Shader: Liquid Metal

Assumes: `blueprint/shaders/overview`

Chrome or brushed aluminum with chromatic aberration. The material has weight — catches and bends light.

## Parameters

`softness(N)` edge smoothness · `repetition(N)` stripe count (more = brushed texture) · `contour(N)` ridge visibility · `angle(N)` light direction · `shiftRed(N)`/`shiftBlue(N)` chromatic aberration · Custom colors as positional args

## Param Reference

- `f[(metal())]` — default silver chrome
- `f[(metal(#FFD700,#FFF8DC))]` — warm gold tones
- `f[(metal(softness(0.3),repetition(5),contour(0.7)))]` — brushed look
- `f[(metal(shape(circle),scale(1.5),uvrot(30),frozen))]` — shape-aware circular

## Examples

**Glass card over metal background:**
```
fr s(480,280) f[(#000),(f2,metal(#CA00FF,#FFFFFF,shape(circle),softness(0.10),repetition(2),shiftRed(0.30),shiftBlue(0.30),distortion(0.07),contour(0.40),speed(1),scale(3)))] rd(20) clip "Hero"
  al(v,a(c,c),g(16),pad(32)) s(fill,fill) f[(solid(#FFF,o(0.08)))] st[(solid(#FFF,o(0.10)),w(1))] rd(16) "Glass"
    t("Liquid Metal",Inter,28,sb,c) f[(#FAFAFA)] "Title"
    t("Chrome surface catches light",Inter,14,c) s(fill,hug) f[(solid(#FAFAFA,o(0.65)))] "Sub"
```

**Metallic accent divider (3px, massive visual impact):**
```
r s(200,3) f[(metal(#FFD700,#FFF8DC,softness(0.5),speed(0.2)))] rd(9999) "Divider"
```

## Best Uses

Metal fills are extremely busy — use on strokes, accents, or dividers. For buttons: `f[(#18181B)] st[(metal(),w(2))]` — text sits on solid fill, metal catches light on the edge.
