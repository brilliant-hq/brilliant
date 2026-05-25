---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Composition Patterns

Compositions the primitives don't make obvious. Each builds on the
assumed skills above.

## Inline element in a headline
Make the headline an `al(h)` row of fragments: a `t()` per word-run, with
the icon or box as a sibling between them. One inline element per headline.
```
al(h,x(c),y(c),g($spacing.md),pad($spacing.none)) s(hug,hug)
  t("We take your",$font.family,$font.size.4xl,b) f[($color.text.primary)]
  al(h,x(c),y(c),g($spacing.none),pad($spacing.none)) s(44,44) f[($color.primary.container)] rd($radius.md)
    svg(icon:envelope-simple) s(24,24) f[($color.primary)]
  t("email",$font.family,$font.size.4xl,b) f[($color.text.display)]
```

## Bento grid
Fixed-height rows; inside each, cells sized `fill:N` give asymmetric
widths with no pixel math. Vary cell colors; make one cell dominant.
```
al(v,g($spacing.md),pad($spacing.none)) s(520,hug) "Bento"
  al(h,g($spacing.md),pad($spacing.none)) s(fill,200)
    al(v,g($spacing.sm),pad($spacing.lg)) s(fill:3,fill) f[($color.surface)] rd($radius.md)            -- 3/5 wide
    al(v,g($spacing.sm),pad($spacing.lg)) s(fill:2,fill) f[($color.primary.container)] rd($radius.md)  -- 2/5 narrow
  al(v,g($spacing.sm),pad($spacing.lg)) s(fill,100) f[($color.primary.container)] rd($radius.md)       -- full-width band
```

## Accent bar
A thin `r s(fill,4)` as the first child draws the eye to a card. The card
needs `clip`, or the bar's square corners escape its radius.
```
al(v,g($spacing.none),pad($spacing.none)) clip s(340,hug) f[($color.surface)] rd($radius.md) "Card"
  r s(fill,4) f[(linear(90,$color.primary,$color.secondary))] "Accent"
  al(v,g($spacing.sm),pad($spacing.md)) s(fill,hug) "Content"
```

## Quick tricks
- **Stacked / tilted cards**: `comp` the card, then `inst()` each copy
  with its own `rot()`, `p()`, and shadow weight (heaviest in front).
- **Watermark**: oversized text (`$font.size.9xl`, `bl`) at
  `$visibility.faint`, placed `abs` so it ignores layout flow.
- **Chat bubble**: asymmetric radius marks the speaker. Sent
  `rd(16,16,4,16)`, received `rd(16,16,16,4)`; ~60-70% of parent width.
- **Notification dot**: a small `c` placed `abs` on a corner;
  `$color.secondary` for unread, `$color.error` for failure, ringed in
  `$color.surface`.
