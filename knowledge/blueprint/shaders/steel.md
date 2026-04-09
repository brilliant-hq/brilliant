---
assumes: blueprint/shaders/overview
---
# Shader: Liquid Steel

Assumes: `blueprint/shaders/overview`

Liquid mercury or polished stainless steel. Flowing chrome with clean industrial character. Less chromatic than `metal()`, more fluid.

## Parameters

`flow(N)` surface fluidity · `roughness(N)` texture grain (higher = more matte) · `distortion(N)` warping intensity · `depth(N)` reflection intensity · `angle(N)` light direction · Custom colors as positional args

## Recommended Palettes

- `f[(steel())]` — default chrome
- `f[(steel(#2A2A30,#E0E0E8))]` — Dark Chrome
- `f[(steel(#B76E6E,#FFEEDD))]` — Rose Gold
- `f[(steel(#FFD700,#DAA520))]` — Gold
- `f[(steel(#3A4A5C,#A8C4E0))]` — Blue Steel
- `f[(steel(#B87333,#FFD5A8))]` — Copper
- `f[(steel(#0A0A0A,#404040))]` — Obsidian

Steel looks great at default `scale(1)` for fills. For button strokes, `scale(2-4)` adds more detail. `f[(#1C1917),(f2,steel(opacity(0.12)))]` for subtle texture under solid.

## Examples

**Rose gold stroke button:**
```
al(h,a(c,c),g($spacing.none),pad($spacing.3,$spacing.6)) s(hug,hug) f[(#18181B)] st[(steel(#B76E6E,#FFEEDD,flow(0.60),roughness(0.35),distortion(0.90),depth(0.75),angle(60),speed(2)),w(2))] rd($radius.full) #steel_btn
  t("Subscribe",Inter,14,sb) f[(#FFEAE4)] #steel_btn_label
```

**Industrial dark panel with chrome steel border:**
```
al(v,g($spacing.4),pad($spacing.6)) s(400,hug) f[(#18181B)] rd($radius.md) st[(steel(speed(2.4)),w(1.5))] #steel_panel
  t("Industrial",Inter,20,sb) f[(#FAFAFA)] #steel_title
  t("Liquid mercury edge",Inter,14) s(fill,hug) f[(#A1A1AA)] #steel_sub
```

**Subtle texture — steel under solid fill:**
```
al(v,g($spacing.4),pad($spacing.6)) s(400,hug) f[(#1C1917),(f2,steel(#2A2A30,#E0E0E8,flow(0.50),roughness(0.20),distortion(0.80),depth(1),angle(135),speed(1.50),scale(1.20),opacity(0.20)))] st[(#292524,w(1))] rd($radius.md) #steel_subtle
  t("Subtle Texture",Inter,20,sb) f[(#FAFAFA)] #subtle_title
  t("Steel at 20% opacity under a solid fill",Inter,14) s(fill,hug) f[(#A1A1AA)] #subtle_sub
```

## Best Uses

Same as metal — use on strokes or decorative elements, not under text. Steel's flowing quality makes it ideal for borders and accent bars.
