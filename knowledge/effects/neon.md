---
assumes: blueprint/effects
---
# Effect: Neon & Glow

Assumes: `blueprint/effects`

**Real neon has three light layers:** inner glow (tube glows from within) + fill (surface catches light) + outer shadow (color bleeds onto wall). Only works on dark backgrounds.

## Neon Badge

```
al(h,x(c),y(c),g($spacing.none),pad($spacing.xs,$spacing.md)) s(hug,hug) f[($indigo.intense),(f2,glow($indigo.soft,o($visibility.bold),blur(6)))] st[(solid($indigo.soft,o($visibility.soft)),w($stroke.width.subtle))] rd($radius.full) shadow($indigo.soft,y(0),blur(12)) #neon_badge
  t("Live",Inter,12,sb) f[($indigo.subtle)] #neon_label
```

## Status Glow Dot

```
c s(10,10) f[($green.mid)] shadow($green.mid,o($visibility.soft),y(0),blur(2)) shadow($green.mid,o($visibility.bold),y(0),blur(16))
```

Two outer shadows at different spreads create halo.

## Accent Glow Card Border

Colored shadow replaces stroke — much more alive than `st[($emerald.mid,w($stroke.width.subtle))]`:

```
al(v,g($spacing.md),pad($spacing.lg)) ds(, theme(dark)) s(340,hug) f[($color.surface)] rd($radius.md) shadow($brand.mid,o($visibility.subtle),y(0),blur(1),sp(1)) shadow($brand.mid,o($visibility.subtle),y(0),blur(16)) #glow_card
  t("Glow Border",Inter,18,sb) f[($color.text.primary)] "Title" #glow_title
  t("Colored shadow replaces stroke",Inter,14) s(fill,hug) f[($color.text.secondary)] "Body" #glow_body
```

Tight shadow with 1px spread = glowing border. Soft shadow = ambient glow.
