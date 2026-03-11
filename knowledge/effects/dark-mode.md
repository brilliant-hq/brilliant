---
assumes: blueprint/effects, design/colors
---
# Effect: Dark Mode

Assumes: `blueprint/effects`

Dark backgrounds are where Brilliant's effects truly shine. Inner glows, colored shadows, and shaders that look garish on white become elegant on dark.

## Effect Tuning Table

| Effect | Light bg | Dark bg |
|---|---|---|
| Inner shadow | Higher opacity (0.15-0.25) | Lower opacity (0.08-0.15), larger blur |
| Inner glow | Skip or subtle (0.08-0.12) | **Superpower** — full vibrancy (0.3-0.8) |
| Drop shadow | Black/gray, low opacity | **Colored shadows** — double as ambient glow |
| Outer glow | Rarely useful | Great for floating/neon |
| Background blur | Lower blur (8-12), light tint | Higher blur (12-20), darker tint |
| Shaders | Lower opacity, muted | Full vibrancy — natural home |

## Surface Hierarchy

Use fill brightness, not shadows, for visual hierarchy:

```
Base:       f[(#09090B)]       ← deepest
Surface 1:  f[(#18181B)]       ← cards, panels
Surface 2:  f[(#27272A)]       ← elevated, active
Surface 3:  f[(#3F3F46)]       ← popovers, tooltips
```

## Dark Cards

```
al(v,g(16),pad(24)) s(340,hug) f[(#18181B)] rd(16) shadow(#000,o(0.30)) shadow(#000,o(0.20),y(12),blur(32))
  t("Dark Card",Inter,18,sb) f[(#F8FAFC)] "Title"
  t("Shadow creates depth on dark surfaces",Inter,14) s(fill,hug) f[(#A1A1AA)] "Body"
```

## Dark Glass

Lower tint opacity — dark bg does contrast work:
```
f[(solid(#FFF,o(0.06))),(f2,blur(16))] st[(solid(#FFF,o(0.08)),w(1))]
```

Inner glow replaces border on dark:
```
f[(solid(#FFF,o(0.06))),(f2,blur(16)),(f3,glow(#FFF,o(0.08),blur(8)))]
  st[(solid(#FFF,o(0.06)),w(1))]
```
