---
assumes: blueprint/effects
---
# Effect: Claymorphism

Assumes: `blueprint/effects`

2025-2026 evolution of neumorphism — saturated pastels, high corner radius, dual inner shadows, outer drop shadows. Soft, molded-clay objects that feel touchable.

## Clay Card

```
$clay_dark=inner(#000,o(0.08),x(3),y(3),blur(6))
$clay_light=inner(#FFF,o(0.6),x(-2),y(-2),blur(4))
$clay_shadow=shadow(#000,o(0.06),y(2),blur(4)) shadow(#000,o(0.10),y(8),blur(24))
al(v,g($spacing.4),pad($spacing.6)) s(300,hug) f[(#DBEAFE),(f2,$clay_dark),(f3,$clay_light)] rd($radius.lg) $clay_shadow #clay_card
  t("Clay Card",Inter,18,sb) f[(#1E3A5F)] "Title" #clay_title
  t("Dual inner shadows create a soft molded look",Inter,14) s(fill,hug) f[(#1E40AF)] "Body" #clay_body
```

Dark inner shadow (bottom-right) + white inner shadow (top-left) = molded 3D look.

## Key Principles

- Fill MUST be saturated pastel — `#DBEAFE` (blue), `#BBF7D0` (green), `#C4B5FD` (violet), `#FECACA` (rose), `#FDE68A` (amber)
- Corner radius 16-24px — higher than normal
- Always TWO inner shadows: dark bottom-right + white top-left
- Always outer drop shadow for lift
- Text dark, high-contrast against pastel
- Works best on light tinted backgrounds — not pure white

## Smaller Elements

Same technique at smaller scale for buttons/icon boxes — reduce inner shadow offsets to 1-2px:

```
$clay_dark_sm=inner(#000,o(0.06),x(1),y(1),blur(3))
$clay_light_sm=inner(#FFF,o(0.5),x(-1),y(-1),blur(2))
$clay_shadow_sm=shadow(#000,o(0.04),y(1),blur(3))
al(h,x(c),y(c),g($spacing.none),pad($spacing.3,$spacing.4)) s(hug,hug) f[(#BBF7D0),(f2,$clay_dark_sm),(f3,$clay_light_sm)] rd($radius.md) $clay_shadow_sm #clay_btn
  t("Clay Button",Inter,14,sb) f[(#166534)] "Label" #clay_btn_label
```
