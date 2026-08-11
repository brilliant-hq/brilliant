---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Data Display

## Containers

- **Card**: v-stack `g($spacing.md)` `pad($spacing.lg)`, `$color.surface`
  fill + `$stroke.width.subtle` stroke + `rd($radius.md)` + soft shadow.
  Title (`$font.size.lg`, sb) over description (`$font.size.sm`,
  `$color.text.secondary`, `s(fill,hug)`). Image-top: `clip` the card,
  image `s(fill,180)` first. The wrapper needs its own `g()`.
- **List item**: h-row `x(s),y(c)` `g($spacing.md)` `pad($spacing.md)`
  `s(fill,hug)`: leading icon/avatar, a `s(fill,hug)` v-stack of title +
  subtitle, trailing badge or chevron. Thin divider between rows. Fixed
  width on icon and trailing slots keeps columns aligned across rows.
- **Table**: v-stack `g($spacing.none)`. Header cells on
  `$color.surface.container`, sb `$color.text.secondary`; body cells
  `$font.size.sm`. Right-align numbers, equal cell count per row.

## People

- **Avatar**: a frame `s(40,40)` `rd($radius.full)` `$color.primary`
  fill, centered initials in `$color.on-primary`.
- **Avatar stack**: `al(h)` with a negative `g($spacing.overlap.md)` to
  overlap; a `$color.surface` ring on each separates them; end with a
  "+N" counter chip.

## Status

- **Badge / pill**: `al(h,x(c),y(c),pad($spacing.xs,$spacing.sm))`
  `s(hug,hug)` `rd($radius.full)`, text `$font.size.xs`. Pair a
  `.container` fill with its solid role text (`$color.success.container` +
  `$color.success`; same for warning / error / info). A floating
  "New" badge sits `abs` on a card corner in `$color.secondary`.
- **Three-state pipeline**: for three peer states (Todo / Doing / Done),
  use the brand triplet, not success/warning/error: each state a pill in
  `$color.primary.container` + `$color.primary` text, then secondary,
  then tertiary. Stop at three; a fourth wants palette stops.

## Tiles & misc

- **Stat tile**: v-stack of label (`$font.size.xs`, m, secondary), value
  (`$font.size.2xl`, b), delta row (arrow + %, `$color.success` or
  `$color.error`). Stamp 3-4 as a `comp`/`inst` row.
- **Progress ring**: `arc()` + `ratio()` on a `c`; see `blueprint/arcs`.
- **Rating**: `al(h)` of star `svg`s, filled `$color.warning`, empty
  `$color.outline.variant`.
- **Quote**: v-stack of an oversized serif open-quote glyph, the quote
  text, then an avatar + name attribution row.
