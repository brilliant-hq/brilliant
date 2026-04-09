---
assumes: blueprint/layout, blueprint/text
---
# Blocks: Layout Components

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Separator / Divider
Horizontal: `r s(fill,1) f[(#E2E8F0)]`. Vertical: `r s(1,fill)`. With label: H-row `a(c,c) g($spacing.3)` — divider + text(12, muted) + divider.

## Header
spaceBetween row `pad($spacing.4,$spacing.6) s(fill,hug)`. Logo left + optional nav center + actions right. Bottom: 1px stroke or shadow.

## Footer
V-stack `pad($spacing.12,$spacing.8) s(fill,hug)` tinted or dark. Top: H-row `g($spacing.8)` link column groups (V-stack `g($spacing.2)`: heading(13,sb) + links(14, muted)). Bottom: spaceBetween — copyright(13, muted) + social icons.

## Hero
V-stack `a(c,c) g($spacing.6) pad(80-120,$spacing.16) s(fill,hug)`. Optional eyebrow. Title(40-56, sb/b, centered) + subtitle(16-18, muted, `s(500-700,hug)`) + CTA row (H-row `g($spacing.3)`).

## Accordion
V-stack `g(0) s(fill,hug)`. Items separated by 1px dividers. Header: spaceBetween row `pad($spacing.3,$spacing.4)` — title(14,m) + caret-down(16x16). Expanded: sb title, `rot(180)` chevron, content panel. Collapsed: omit panel.

## Carousel
Clip frame with slides. Dot indicators: H-row `a(c,c) g($spacing.2)` — active `c s(8,8)` accent, inactive muted.

## Form
V-stack `g($spacing.4) pad($spacing.6) s(fill or 400-500, hug)`. Sequential fields (Text Input, Select, etc.). Error text(13, #EF4444) below invalid. Submit button at bottom.
