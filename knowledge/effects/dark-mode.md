---
assumes: blueprint/effects, design/colors
---
# Effect: Dark Mode

Dark backgrounds are where Brilliant's effects shine: inner glows,
colored shadows, and shaders that look garish on white turn elegant on
dark.

## Tuning effects for dark

- **Inner glow** is the superpower on dark, at full vibrancy
  (`o($visibility.firm)` and up); skip it or keep it faint on light.
- **Drop shadows** can take a brand color on dark, doubling as an ambient
  glow; on light keep them neutral and low-opacity.
- **Shaders** run at full vibrancy on dark, muted on light.
- **Background blur**: more blur and a darker tint on dark.

## Surfaces, not raw stops

Build chrome from `$color.surface`, `$color.surface.container`,
`$color.text.*`, and `$color.outline.*`, never raw `$neutral.X` stops.
The catalog re-resolves every alias through `theme.dark` automatically,
so one blueprint renders correctly in both modes. Use fill brightness,
not shadows, for hierarchy on dark.

```
al(v,g($spacing.md),pad($spacing.lg)) s(340,hug) f[($color.surface.container)] rd($radius.md) shadow($color.shadow,o($visibility.soft),y(12),blur(32)) "Card"
  t("Mode-aware card",$font.family,$font.size.lg,sb) f[($color.text.primary)]
  t("Renders right in light and dark",$font.family,$font.size.sm) s(fill,hug) f[($color.text.secondary)]
```

## Per-element mode override

To render one frame dark while the canvas stays light (a side-by-side
comparison, an inverted feature card), put `ds(, theme(dark))` on the
frame. The empty leading slot keeps the inherited brand; the mode
applies to that frame and its descendants, and the aliases re-resolve
dark just for that subtree.

```
fr s(400,160) ds(, theme(dark)) f[($color.surface)] rd($radius.md) "Dark Preview"
  al(v,g($spacing.sm),pad($spacing.md)) s(fill,hug)
    t("Dark on a light canvas",$font.family,$font.size.sm,sb) f[($color.text.primary)]
    t("Aliases resolve through theme.dark here",$font.family,$font.size.sm) s(fill,hug) f[($color.text.secondary)]
```

Dark glass (a `glass` fill with a low-opacity dark tint): see `effects/glass`.
