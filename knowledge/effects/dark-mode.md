---
assumes: blueprint/effects, design/colors
---
# Effect: Dark Mode

Assumes: `blueprint/effects`

Dark backgrounds are where Brilliant's effects truly shine. Inner glows, colored shadows, and shaders that look garish on white become elegant on dark.

## Effect Tuning Table

| Effect | Light bg | Dark bg |
|---|---|---|
| Inner shadow | Higher opacity (0.15-0.25) | Lower opacity (0.08-0.15), larger blur |
| Inner glow | Skip or subtle (0.08-0.12) | **Superpower** — full vibrancy (0.3-0.8) |
| Drop shadow | Black/gray, low opacity | **Colored shadows** — double as ambient glow |
| Outer glow | Rarely useful | Great for floating/neon |
| Background blur | Lower blur (8-12), light tint | Higher blur (12-20), darker tint |
| Shaders | Lower opacity, muted | Full vibrancy — natural home |

## Surface Hierarchy

Use fill brightness, not shadows, for visual hierarchy:

```text
$neutral=#64748B
```
Base `$neutral.90` deepest · Surface 1 `$neutral.80` cards, panels · Surface 2 `$neutral.70` elevated, active · Surface 3 `$neutral.60` popovers, tooltips.

## Dark Cards

```
$neutral=#64748B
$dark_shadow=shadow(#000,o(0.30)) shadow(#000,o(0.20),y(12),blur(32))
al(v,g($spacing.4),pad($spacing.6)) s(340,hug) f[($neutral.80)] rd($radius.md) $dark_shadow #dark_card
  t("Dark Card",Inter,18,sb) f[($neutral.5)] "Title" #dark_title
  t("Shadow creates depth on dark surfaces",Inter,14) s(fill,hug) f[($neutral.40)] "Body" #dark_body
```

## Dark Glass

Lower tint opacity — dark bg does contrast work:
```text
$tint=solid(#FFF,o(0.06))
$edge=solid(#FFF,o(0.08))
f[($tint),(f2,blur(16))] st[($edge,w(1))]
```

Inner glow replaces border on dark:
```text
$tint=solid(#FFF,o(0.06))
$edge=solid(#FFF,o(0.06))
f[($tint),(f2,blur(16)),(f3,glow(#FFF,o(0.08),blur(8)))]
  st[($edge,w(1))]
```
