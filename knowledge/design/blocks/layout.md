---
assumes: blueprint/layout, blueprint/text
---
# Blocks: Layout Components

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Separator / Divider
Horizontal: `r s(fill,1) f[($color.outline.variant)]`. Vertical: `r s(1,fill)`. With label: H-row `x(c),y(c) g($spacing.md)`, divider + text(`$font.size.xs`, `$color.text.secondary`) + divider.

## Header
spaceBetween row `pad($spacing.md,$spacing.lg) s(fill,hug)`. Logo left + optional nav center + actions right. Bottom: 1px stroke or shadow.

## Footer
V-stack `pad($spacing.2xl,$spacing.xl) s(fill,hug)`, `$color.surface.container` for tinted; for a dark footer over a light page, wrap in a frame with `ds(, theme(dark))` rather than hand-painting dark. Top: H-row `g($spacing.xl)` link column groups (V-stack `g($spacing.sm)`: heading(13,sb) + links(14, `$color.text.secondary`)). Bottom: spaceBetween, copyright(13, `$color.text.secondary`) + social icons.

## Hero
V-stack `y(c),x(c) g($spacing.lg) pad(80-120,$spacing.3xl) s(fill,hug)`. Optional eyebrow. Title(40-56, sb/b, centered) + subtitle(16-18, `$color.text.secondary`, `s(500-700,hug)`) + CTA row (H-row `g($spacing.md)`).

## Accordion
V-stack `g(0) s(fill,hug)`. Items separated by 1px dividers. Header: spaceBetween row `pad($spacing.md,$spacing.md)`, title(14,m) + caret-down(16x16). Expanded: sb title, `rot(180)` chevron, content panel. Collapsed: omit panel.

## Carousel
Clip frame with slides. Dot indicators: H-row `x(c),y(c) g($spacing.sm)`, active `c s(8,8)` `$color.primary`, inactive `$color.outline.variant`.

## Form
V-stack `g($spacing.md) pad($spacing.lg) s(fill or 400-500, hug)`. Sequential fields (Text Input, Select, etc.). Error text(`$font.size.sm`, `$color.text.error`) below invalid. Submit button at bottom.
