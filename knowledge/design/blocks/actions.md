---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Actions

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Button
Inline row `a(c,c) pad($spacing.3,$spacing.4) s(hug,hug) rd($radius.sm)`. Primary: solid dark fill + white text(14,sb) + layered shadow. Secondary: no fill, 1px stroke + dark text. Icon variant: add `g($spacing.2)`, svg icon(16x16). **CTA buttons are solid — never gradient.**

## Button Group
H-row `g(0-2)`. Without gap: first `rd($radius.sm,0,0,$radius.sm)`, middle `rd(0)`, last `rd(0,$radius.sm,$radius.sm,0)`. Active: filled. Inactive: stroke or tinted.

## Segmented Control
```
$neutral=#64748B
$spacing=4
$font=Inter
al(h,pad($spacing.1),g(2)) s(hug,hug) f[($neutral.10)] rd($radius.sm) "Segmented" #segmented
  al(h,a(c,c),g($spacing.none),pad($spacing.2,$spacing.4)) s(hug,hug) rd($radius.sm) comp #seg
    t("Daily",$font,13,m) f[($neutral.50)] "Label" #seg_label
  inst(#seg) f[(#FFF)] shadow(#000,o(0.06),y(1),blur(2))
    override(#seg_label) t("Daily",_,_,sb) f[($neutral.90)]
  inst(#seg)
    override(#seg_label) t("Weekly")
```

## Toggle Switch
Knob via alignment — `a(e,c)` for on, `a(s,c)` for off:
```
$brand=#8B5CF6
$neutral=#64748B
al(h,a(e,c),g($spacing.none),pad($spacing.1)) s(44,26) f[($brand.50)] rd($radius.full) comp #on "On"
  al(h,a(c,c),g($spacing.none),pad($spacing.none)) s(20,20) f[(#FFF)] rd($radius.full) shadow(#000,o(0.15),y(1),blur(2)) "Knob"
inst(#on) al(h,a(s,c),g($spacing.none),pad($spacing.1)) f[($neutral.20)] "Off"
```

## FAB
Centered frame `s(56,56) rd($radius.full)` accent fill + high shadow. Icon `s(24,24)` white.

## Action Hierarchy

One **primary** action per screen or section — filled, accent color, prominent. Secondary actions visually reduced — ghost, outline, or muted. Destructive actions distinct — red or separated by space. Rare actions in overflow or behind a menu. Never give equal emphasis to all actions.

| Role | Style |
|------|-------|
| Primary | Solid accent fill, white text, shadow |
| Secondary | No fill, stroke or muted text |
| Destructive | Red outline or red text, no fill |
| Rare | Overflow menu or icon-only |

## Button States
**Default:** medium shadow, solid fill. **Hover:** enhanced shadow (lifts), brighter fill. **Pressed:** inner shadow replaces outer. **Disabled:** no shadow, muted `#94A3B8`, reduced text opacity.
