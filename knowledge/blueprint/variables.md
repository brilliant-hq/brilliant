---
dsl: [$, $var, seed]
---
# Blueprint Variables & Seeds

Define design building blocks at the top of an `<objects>` block. Persist across blocks in the same session.

## Seeds — define one value, get a full scale

Seeds auto-generate a range of values you can reference throughout your design. Define them once, use the generated steps everywhere.

### Color seeds — hex → 10-step lightness scale

Any `$var` with a hex value generates an OKLCH color scale from `$name.5` (near-white) to `$name.90` (near-black):
```
$brand=#3B82F6
$neutral=#64748B
```
Steps: 5 (97% lightness, subtle bg), 10 (94%, light bg), 20 (87%, borders), 30 (76%, muted), 40 (64%, secondary text), 50 (50%, primary), 60 (40%, hover), 70 (32%, dark accents), 80 (25%, headings), 90 (18%, body text). Lower = lighter.

Always define `$brand` + `$neutral`. Add `$success`, `$error`, `$warning`, `$accent` as needed.

### Spacing seed — base × multiplier (continuous)

`$spacing=4` generates `$spacing.none` (0) plus `$spacing.N` for any positive integer N, resolving to `base × N`. So `$spacing.5` = 20, `$spacing.7` = 28, `$spacing.10` = 40, etc. Same model as Tailwind.

Use anywhere you need spacing: `g($spacing.4)`, `pad($spacing.6)`, `pad($spacing.3,$spacing.6)`. Prefer multiples of the base you'd actually find on a 4px grid — common picks: 1, 2, 3, 4, 6, 8, 12, 16.

### Radius seed — base × multiplier

`$radius=8` generates: `$radius.none` (0), `$radius.sm` (8), `$radius.md` (16), `$radius.lg` (32), `$radius.xl` (48), `$radius.full` (9999).

Use in corner radius: `rd($radius.md)`, `rd($radius.full)`.

### Font size seed — base × multiplier

`$font_size=16` generates: `$font_size.xs` (12), `.sm` (14), `.md` (16), `.lg` (20), `.xl` (24), `.2xl` (32).

### Font weight seed — fixed steps

`$font_weight=400` generates: `$font_weight.thin` (100), `.extralight` (200), `.light` (300), `.regular` (400), `.medium` (500), `.semibold` (600), `.bold` (700), `.extrabold` (800), `.black` (900).

### Line height seed — fixed steps

`$line_height=1.5` generates: `$line_height.none` (1.0), `.tight` (1.25), `.snug` (1.375), `.normal` (1.5), `.relaxed` (1.625), `.loose` (2.0).

### Stroke width seed — base × multiplier

`$stroke_width=1` generates: `$stroke_width.none` (0), `.hairline` (0.5), `.sm` (1), `.md` (2), `.lg` (4), `.xl` (8).

### Opacity seed — fixed steps

`$opacity=1` generates: `$opacity.0` (0), `.5` (0.05), `.10` (0.1), `.20` (0.2), `.30` (0.3), `.40` (0.4), `.50` (0.5), `.60` (0.6), `.70` (0.7), `.80` (0.8), `.90` (0.9), `.100` (1.0).

## Example — card using seeds

```
$brand=#F97316
$neutral=#64748B
$spacing=4
$radius=8
$font=Inter
al(v,g($spacing.4),pad($spacing.6)) s(360,hug) f[($neutral.5)] st[($neutral.20,w(1))] rd($radius.md) shadow(#000,o(0.06),y(2),blur(8)) "Card"
  t("Dashboard",$font,20,sb) f[($brand.90)]
  t("Welcome back",$font,14) s(fill,hug) f[($neutral.50)]
  al(h,a(c,c),g($spacing.none),pad($spacing.3,$spacing.4)) s(fill,hug) f[($brand.50)] rd($radius.sm) "Button"
    t("Open",$font,14,sb) f[(#FFF)]
```

## Example — color seed palette

One `$brand` hex generates a 10-step lightness scale (.90 near-black → .5 near-white):

```
$brand=#645DFC
al(v,g($spacing.none),pad($spacing.none)) s(360,hug) f[($brand.20)] rd($radius.lg) clip "Palette"
  al(v,g($spacing.none),pad($spacing.6,$spacing.6,$spacing.5,$spacing.6)) s(fill,120) f[($brand.50)]
    al(h,a(sb,c),g($spacing.none),pad($spacing.none)) s(fill,hug)
      t("Primary",Inter,20,sb) f[(#FFF)]
      t("#645DFC",Inter,16,m) f[(solid(#FFF,o(0.7)))]
  al(h,g($spacing.none),pad($spacing.none)) s(fill,48) "Scale"
    r s(fill,fill) f[($brand.90)]
    r s(fill,fill) f[($brand.80)]
    r s(fill,fill) f[($brand.70)]
    r s(fill,fill) f[($brand.60)]
    r s(fill,fill) f[($brand.50)]
    r s(fill,fill) f[($brand.40)]
    r s(fill,fill) f[($brand.30)]
    r s(fill,fill) f[($brand.20)]
    r s(fill,fill) f[($brand.10)]
    r s(fill,fill) f[($brand.5)]
```

## Non-seed vars — plain text substitution

Fonts, shadows, and compound patterns are simple text replacement:
```
$font=Playfair Display
$card_shadow=shadow(#000,o(0.06),y(2),blur(8))
$glass_tint=solid(#FFF,o(0.10))
```

Variables can reference earlier variables: `$accent_bg=f[($brand.10)]`.

## Escape — literal `$` in text

Use `\$` to prevent substitution: `t("\$99.99",$font,14)` renders literal "$99.99".
