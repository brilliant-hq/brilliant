---
assumes: blueprint/effects
---
# Effect: Claymorphism

Assumes: `blueprint/effects`

2025-2026 evolution of neumorphism — saturated pastels, high corner radius, dual inner shadows, outer drop shadows. Soft, molded-clay objects that feel touchable.

## Clay Card

```
al(v,g($spacing.md),pad($spacing.lg)) s(300,hug) f[($blue.faint),(f2,inner($neutral.intense,o($visibility.faint),x(3),y(3),blur(6))),(f3,inner($neutral.hint,o($visibility.mid),x(-2),y(-2),blur(4)))] rd($radius.lg) shadow($neutral.intense,o($visibility.faint),y(2),blur(4)) shadow($neutral.intense,o($visibility.faint),y(8),blur(24)) #clay_card
  t("Clay Card",$font.family,$font.size.lg,sb) f[($blue.intense)] "Title" #clay_title
  t("Dual inner shadows create a soft molded look",$font.family,$font.size.sm) s(fill,hug) f[($blue.strong)] "Body" #clay_body
```

Dark inner shadow (bottom-right) + white inner shadow (top-left) = molded 3D look.

## Key Principles

- Fill MUST be saturated pastel — `$blue.faint`, `$green.faint`, `$violet.soft`, `$red.subtle`, `$amber.subtle` (or any catalog `<color>.{100..200}` stop)
- Corner radius 16-24px — higher than normal
- Always TWO inner shadows: dark bottom-right + white top-left
- Always outer drop shadow for lift
- Text dark, high-contrast against pastel
- Works best on light tinted backgrounds — not pure white

## Smaller Elements

Same technique at smaller scale for buttons/icon boxes — reduce inner shadow offsets to 1-2px:

```
al(h,x(c),y(c),g($spacing.none),pad($spacing.md,$spacing.md)) s(hug,hug) f[($green.faint),(f2,inner($neutral.intense,o($visibility.faint),x(1),y(1),blur(3))),(f3,inner($neutral.hint,o($visibility.mid),x(-1),y(-1),blur(2)))] rd($radius.md) shadow($neutral.intense,o($visibility.faint),y(1),blur(3)) #clay_btn
  t("Clay Button",$font.family,$font.size.sm,sb) f[($green.strong)] "Label" #clay_btn_label
```
