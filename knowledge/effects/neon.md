---
assumes: blueprint/effects
---
# Effect: Neon & Glow

Assumes: `blueprint/effects`

**Real neon has three light layers:** inner glow (tube glows from within) + fill (surface catches light) + outer shadow (color bleeds onto wall). Only works on dark backgrounds.

## Neon Badge

```
$neon=#818CF8
al(h,x(c),y(c),g($spacing.none),pad($spacing.1,$spacing.3)) s(hug,hug) f[(#1E1B4B),(f2,glow($neon,o(0.7),blur(6)))] st[(solid($neon,o(0.4)),w(1))] rd($radius.full) shadow($neon,y(0),blur(12)) #neon_badge
  t("Live",Inter,12,sb) f[(#C7D2FE)] #neon_label
```

## Status Glow Dot

```
$glow=#22C55E
c s(10,10) f[($glow)] shadow($glow,o(0.40),y(0),blur(2)) shadow($glow,o(0.70),y(0),blur(16))
```

Two outer shadows at different spreads create halo.

## Accent Glow Card Border

Colored shadow replaces stroke — much more alive than `st[(#10B981,w(1))]`:

```
$brand=#10B981
$neutral=#64748B
al(v,g($spacing.4),pad($spacing.6)) s(340,hug) f[($neutral.80)] rd($radius.md) shadow($brand.50,o(0.15),y(0),blur(1),sp(1)) shadow($brand.50,o(0.12),y(0),blur(16)) #glow_card
  t("Glow Border",Inter,18,sb) f[($neutral.5)] "Title" #glow_title
  t("Colored shadow replaces stroke",Inter,14) s(fill,hug) f[($neutral.40)] "Body" #glow_body
```

Tight shadow with 1px spread = glowing border. Soft shadow = ambient glow.
