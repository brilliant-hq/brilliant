---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Actions

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Button
Inline row `a(c,c) pad(10,20) s(hug,hug) rd(8)`. Primary: solid dark fill + white text(14,sb) + layered shadow. Secondary: no fill, 1px stroke + dark text. Icon variant: add `g(8)`, svg icon(16x16). **CTA buttons are solid — never gradient.**

## Button Group
H-row `g(0-2)`. Without gap: first `rd(8,0,0,8)`, middle `rd(0)`, last `rd(0,8,8,0)`. Active: filled. Inactive: stroke or tinted.

## Segmented Control
```
al(h,pad(3),g(2)) s(hug,hug) f[(#F1F5F9)] rd(10) "Segmented"
  al(h,a(c,c),pad(6,14)) s(hug,hug) rd(8) comp #seg
    t("Daily",Inter,13,m) f[(#64748B)] "Label"
  inst(#seg) f[(#FFF)] shadow(#000,o(0.06),y(1),blur(2))
    "Label" t("Daily") f[(#0F172A)] weight(sb)
  inst(#seg)
    "Label" t("Weekly")
```

## Toggle Switch
Knob via alignment — `a(e,c)` for on, `a(s,c)` for off:
```
al(h,a(e,c),pad(3)) s(44,26) f[(#8B5CF6)] rd(9999) comp #on "On"
  al(h,a(c,c)) s(20,20) f[(#FFF)] rd(9999) shadow(#000,o(0.15),y(1),blur(2)) "Knob"
inst(#on) a(s,c) f[(#E4E4E7)] "Off"
```

## FAB
Centered frame `s(56,56) rd(9999)` accent fill + high shadow. Icon `s(24,24)` white.

## Button States
**Default:** medium shadow, solid fill. **Hover:** enhanced shadow (lifts), brighter fill. **Pressed:** inner shadow replaces outer. **Disabled:** no shadow, muted `#94A3B8`, reduced text opacity.
