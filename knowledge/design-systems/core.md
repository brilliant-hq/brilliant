---
dsl: [ds, designSystem, brand, mode]
---
# Design Systems

Every color, font, and scale value in a blueprint is a token (`$name`),
resolved through the active design system. Init context shows that DS
verbatim as a `.styles` catalog: read it for real token names and values.

Stops follow two vocabularies:
- **Presence ramp** (brand/palette stops, `$font.weight`, `$stroke.width`,
  `$visibility`): `hint faint subtle soft mid firm bold strong intense`.
  Bare `$primary` = `.mid`. (`$stroke.width` also has `thick/thicker/thickest`.)
- **T-shirt scale** (`$spacing`, `$radius`, `$font.size`):
  `xs sm md lg xl 2xl…Nxl`, plus `none`.

Explicit mode halts on bare values in tokenizable slots: `g() pad() rd() o() w() lh() ls()`, `t()` size positional, and any color (`f[]`, `st[]`, gradient stops, shader colors, effect colors). Use a `$token`. `s()` sizing accepts bare numerics. Bare color seeds (`$primary` → `.mid`) are the one numeric-scale exception; primitive stops like `$primary.500` or `$spacing.4` halt, use role names. None mode inverts this: no design system, so use bare values and never `$token` (tokens halt).

A card, dark-themed, annotated:

```
al(v,g($spacing.md),pad($spacing.lg)) ds(, theme(dark)) s(280,hug) f[($color.surface)] rd($radius.lg) shadow($color.shadow,o($visibility.subtle),y(8),blur(24)) "Card"
  // ds(, theme(dark)) is the only thing making this card dark. Tokens below
  // are the light-mode ones; the mode re-resolves each ($color.surface →
  // dark surface, text → light ink). $color.shadow is absolute, never flips.
  al(h,y(c),g($spacing.none),pad($spacing.xs,$spacing.sm)) s(hug,hug) f[($emerald.subtle)] rd($radius.full) "Badge"
    t("10× faster",$font.family,$font.size.xs,sb) f[($emerald.bold)]
    // accent: a Tailwind palette, not chrome. subtle = quiet wash,
    // bold = loud ink; the presence pair holds in both modes.
  t("Real-time sync",$font.family,$font.size.lg,b) f[($color.text.primary)]
```

`hint…intense` is a presence scale: loudness against the surface, not
brightness, so it inverts per mode, `$neutral.intense` is near-black in
light mode but near-*white* in dark, so it is never a dark background; reach
for `$color.surface` for chrome. Don't fake dark mode with `firm…intense`
stops in `theme(light)`; switch to `theme(dark)` and the same low stops
(`hint…soft`, `$color.*` aliases) resolve dark on their own. Build chrome
from `$color.*` aliases and identity from brand slots; Tailwind palettes are
accents only, never chrome.

## `ds()` picks brand and mode

A top-level frame auto-stamps the active DS; children inherit.

```
ds(editorial)              // switch brand
ds(, theme(dark))          // keep brand, go dark
ds(editorial, theme(dark)) // both
```

See `design-systems/authoring` to author or extend a DS.
