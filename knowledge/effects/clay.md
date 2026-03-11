---
assumes: blueprint/effects
---
# Effect: Claymorphism

Assumes: `blueprint/effects`

2025-2026 evolution of neumorphism — saturated pastels, high corner radius, dual inner shadows, outer drop shadows. Soft, molded-clay objects that feel touchable.

## Clay Card

```
al(v,g(16),pad(24)) s(300,hug) f[(#DBEAFE),(f2,inner(#000,o(0.08),x(3),y(3),blur(6))),(f3,inner(#FFF,o(0.6),x(-2),y(-2),blur(4)))] rd(20) shadow(#000,o(0.06),y(2),blur(4)) shadow(#000,o(0.10),y(8),blur(24))
  t("Clay Card",Inter,18,sb) f[(#1E3A5F)] "Title"
  t("Dual inner shadows create a soft molded look",Inter,14) s(fill,hug) f[(#1E40AF)] "Body"
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
al(h,a(c,c),pad(10,20)) s(hug,hug) f[(#BBF7D0),(f2,inner(#000,o(0.06),x(1),y(1),blur(3))),(f3,inner(#FFF,o(0.5),x(-1),y(-1),blur(2)))] rd(12) shadow(#000,o(0.04),y(1),blur(3))
  t("Clay Button",Inter,14,sb) f[(#166534)] "Label"
```
