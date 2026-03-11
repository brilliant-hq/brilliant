---
assumes: blueprint/shaders/overview
---
# Shader: Liquid Steel

Assumes: `blueprint/shaders/overview`

Liquid mercury or polished stainless steel. Flowing chrome with clean industrial character. Less chromatic than `metal()`, more fluid.

## Parameters

`flow(N)` surface fluidity · `roughness(N)` texture grain (higher = more matte) · `distortion(N)` warping intensity · `depth(N)` reflection intensity · `angle(N)` light direction · Custom colors as positional args

## Param Reference

- `f[(steel())]` — default flowing chrome
- `f[(steel(roughness(0.7),distortion(0.8)))]` — worked-metal look
- `f[(steel(depth(0.9),flow(0.8),speed(2.4)))]` — deep dramatic reflections
- `f[(#1C1917),(f2,steel(opacity(0.12)))]` — subtle texture under solid

## Examples

**Steel stroke button on dark background:**
```
al(h,a(c,c),pad(12,24)) s(hug,hug) f[(#18181B)] st[(steel(#FFD700,#DAA520,speed(2.6)),w(2))] rd(10)
  t("Premium",Inter,14,sb) f[(#FAFAFA)]
```

**Industrial dark panel with steel accent:**
```
al(v,g(16),pad(24)) s(340,hug) f[(#18181B)] rd(16) st[(steel(speed(2.4)),w(1.5))]
  t("Industrial",Inter,20,sb) f[(#FAFAFA)] "Title"
  t("Liquid mercury edge",Inter,14) s(fill,hug) f[(#A1A1AA)] "Sub"
```

## Best Uses

Same as metal — use on strokes or decorative elements, not under text. Steel's flowing quality makes it ideal for borders and accent bars.
