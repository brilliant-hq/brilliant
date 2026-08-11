---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Feedback

## Inline messages

- **Alert / banner**: h-row, a status icon plus a title/message v-stack,
  optional dismiss `x`. Pair a `.container` fill with its solid role text:
  `$color.success.container` + `$color.success`, and likewise
  warning / error / info. Stamp all four as a `comp`/`inst` set.
- **Toast**: the same row at a fixed `s(320-400,hug)` plus a shadow,
  pinned top-right or bottom-center.

## Overlays

- **Modal**: a full-parent scrim `solid($color.shadow,o($visibility.mid))`
  (a frozen dark layer), then a centered `$color.surface` v-stack with a
  high shadow, a space-between header (title + `x`), and an `x(e)` footer.
- **Drawer**: a `$color.surface` v-stack `s(360-480,fill)` with a high
  shadow, pinned to one edge; space-between header.
- **Bottom sheet**: a `$color.surface` v-stack with top-only radius and
  an upward shadow (`y(-4)`); a small centered grab handle on top.
- **Dropdown menu**: a `$color.surface` v-stack, `pad($spacing.xs)`, high
  shadow + stroke; items are `rd($radius.sm)` h-rows, destructive ones in
  `$color.error`.
- **Tooltip**: a compact one-line dark chip, `$color.shadow` fill with
  light text.

## Status & states

- **Progress bar**: an `al(h)` track frame, `clip`, holding `fill:N` /
  `fill:M` segments (`fill:3` + `fill:1` = 75%).
- **Skeleton**: rects in `$color.outline.variant` matching the real
  content's layout and spacing.
- **Empty state**: a centered v-stack of a large muted icon, a title, a
  description, and an optional CTA.

```
al(h,g($spacing.none),pad($spacing.none)) s(200,6) f[($color.surface.container)] rd($radius.full) clip "Progress"
  r s(fill:3,fill) f[($color.primary)] "Fill"
  r s(fill:1,fill) "Empty"
```
