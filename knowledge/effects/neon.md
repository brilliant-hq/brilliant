---
assumes: blueprint/effects
---
# Effect: Neon & Glow

Assumes: `blueprint/effects`

**Real neon has three light layers:** inner glow (tube glows from within) + fill (surface catches light) + outer shadow (color bleeds onto wall). Only works on dark backgrounds.

## Neon Badge

```
al(h,a(c,c),pad(4,12)) s(hug,hug) f[(#1E1B4B),(f2,glow(#818CF8,o(0.7),blur(6)))] st[(solid(#818CF8,o(0.4)),w(1))] rd(9999) shadow(#818CF8,y(0),blur(12))
  t("Live",Inter,12,sb) f[(#C7D2FE)]
```

## Status Glow Dot

```
c s(10,10) f[(#22C55E)] shadow(#22C55E,o(0.40),y(0)) shadow(#22C55E,o(0.15),y(0),blur(16))
```

Two outer shadows at different spreads create halo.

## Accent Glow Card Border

Colored shadow replaces stroke — much more alive than `st[(#3B82F6,w(1))]`:

```
al(v,g(16),pad(24)) s(340,hug) f[(#18181B)] rd(16) shadow(#3B82F6,o(0.15),y(0),blur(1),sp(1)) shadow(#3B82F6,o(0.12),y(0),blur(16))
  t("Glow Border",Inter,18,sb) f[(#F8FAFC)] "Title"
  t("Colored shadow replaces stroke",Inter,14) s(fill,hug) f[(#A1A1AA)] "Body"
```

Tight shadow with 1px spread = glowing border. Soft shadow = ambient glow.
