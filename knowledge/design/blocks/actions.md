---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Actions

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Button
Inline row `x(c),y(c) pad($spacing.3,$spacing.4) s(hug,hug) rd($radius.sm)`. Primary: solid dark fill + white text(14,sb) + layered shadow. Secondary: no fill, 1px stroke + dark text. Icon variant: add `g($spacing.2)`, svg icon(16x16). **CTA buttons are solid — never gradient.**

## Button Group
H-row `g(0-2)`. Without gap: first `rd($radius.sm,0,0,$radius.sm)`, middle `rd(0)`, last `rd(0,$radius.sm,$radius.sm,0)`. Active: filled. Inactive: stroke or tinted.

## Segmented Control

Use `for(...)` for the segment list, then flat-modify the active one.
**Even with one active state, the loop is still right** — don't drop to
hand-coded copies:
```
$neutral=#64748B
$font=Inter
al(h,pad($spacing.1),g(2)) s(hug,hug) f[($neutral.10)] rd($radius.sm) "Segmented" #segmented
  for($label, in([Daily,Weekly,Monthly]))
    al(h,x(c),y(c),pad($spacing.2,$spacing.4)) s(hug,hug) rd($radius.sm) "Seg $label" #seg
      t("$label",$font,13,m) f[($neutral.50)] #seg_label

# Active: Daily — two flat-modify lines, not a second loop
#seg_Daily f[(#FFF)] shadow(#000,o(0.06),y(1),blur(2))
#seg_label_Daily t("Daily",$font,13,sb) f[($neutral.90)]
```
After expansion, `#seg_Weekly`, `#seg_label_Monthly` etc. each address one segment.

## Toggle Switch
Knob via alignment — `x(e),y(c)` for on, `x(s),y(c)` for off:
```
$brand=#8B5CF6
$neutral=#64748B
al(h,x(e),y(c),g($spacing.none),pad($spacing.1)) s(44,26) f[($brand.50)] rd($radius.full) comp #on "On"
  al(h,x(c),y(c),g($spacing.none),pad($spacing.none)) s(20,20) f[(#FFF)] rd($radius.full) shadow(#000,o(0.15),y(1),blur(2)) "Knob"
inst(#on) al(h,x(s),y(c),g($spacing.none),pad($spacing.1)) f[($neutral.20)] "Off"
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
