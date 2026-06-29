---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Actions

## Button
Inline row `x(c),y(c) pad($spacing.md,$spacing.md) s(hug,hug) rd($radius.sm)`. Primary: solid `$color.primary` fill + `$color.on-primary` text(14,sb) + layered shadow. Secondary: no fill, 1px stroke + `$color.text.primary`. Icon variant: add `g($spacing.sm)`, svg icon(16x16). **CTA buttons are solid — never gradient.**

## Button Group
H-row `g(0-2)`. Without gap: first `rd($radius.sm,0,0,$radius.sm)`, middle `rd(0)`, last `rd(0,$radius.sm,$radius.sm,0)`. Active: filled. Inactive: stroke or tinted.

## Segmented Control

Declare the segment as a `comp` master with the active styling baked in (Daily is active here), then stamp the inactive segments as `inst()` blocks that clear the active fill/shadow on the frame and revert the label to the muted treatment. **Even with only one active state, the iteration is still right** — don't drop to hand-coded copies:
```
al(h,pad($spacing.xs),g($spacing.none)) s(hug,hug) f[($color.surface.container)] rd($radius.sm) "Segmented" #segmented
  al(h,x(c),y(c),pad($spacing.sm,$spacing.md)) comp s(hug,hug) f[($color.surface)] shadow($neutral.intense,o($visibility.faint),y(1),blur(2)) rd($radius.sm) "Daily" #seg
    t("Daily",$font.family,$font.size.sm,sb) f[($color.text.primary)] #seg_label
  inst(#seg) f[(unstyled)] shadow(unstyled) "Weekly"
    override(#seg_label) t("Weekly",$font.family,$font.size.sm,m) f[($color.text.secondary)]
  inst(#seg) f[(unstyled)] shadow(unstyled) "Monthly"
    override(#seg_label) t("Monthly",$font.family,$font.size.sm,m) f[($color.text.secondary)]
```
Properties on the `inst()` line apply to that instance frame: `f[(unstyled)] shadow(unstyled)` clears the active styling so the inactive segments visually subordinate. For the flip-in-the-inspector set form, see `blueprint/components`.

## Toggle Switch
Knob via alignment — `x(e),y(c)` for on, `x(s),y(c)` for off:
```
al(h,x(e),y(c),g($spacing.none),pad($spacing.xs)) s(44,26) f[($color.primary)] rd($radius.full) comp #on "On"
  al(h,x(c),y(c),g($spacing.none),pad($spacing.none)) s(20,20) f[($color.on-primary)] rd($radius.full) shadow($neutral.intense,o($visibility.soft),y(1),blur(2)) "Knob"
inst(#on) al(h,x(s),y(c),g($spacing.none),pad($spacing.xs)) f[($color.outline.variant)] "Off"
```
For the flip-in-the-inspector set form, see `blueprint/components`.

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
**Default:** medium shadow, solid fill. **Hover:** enhanced shadow (lifts), brighter fill. **Pressed:** inner shadow replaces outer. **Disabled:** no shadow, `$color.text.disabled`, reduced text opacity.
