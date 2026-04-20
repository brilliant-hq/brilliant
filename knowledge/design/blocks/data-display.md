---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Data Display

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Vertical Lanes

Repeated rows (lists, tables, nav items) must form consistent vertical columns. Give icons, indicators, and trailing actions a fixed width — even when a slot is empty in some rows — so columns align across rows with varying content.

## Card
V-stack `g($spacing.3) pad($spacing.6) s(W,hug)` white fill + 1px stroke + `rd($radius.md)` + shadow. Title(18-20,sb) + description(14, muted, `s(fill,hug)`) + optional actions. **Image-top:** add `clip`, image `s(fill,160-200)` first child. **Parent gap:** cards need `g($spacing.3)` on wrapper — card padding is internal.

## List Item
H-row `a(s,c) g($spacing.3) pad($spacing.3,$spacing.4) s(fill,hug)`. Leading (icon/avatar) + center V-stack `s(fill,hug)`: title(14,m) + subtitle(13, muted) + trailing (badge, chevron). 1px divider between items.

## Table
V-stack `g(0)`. Header: cells `s(fill,hug) pad($spacing.2,$spacing.3)` tinted bg, text(13,sb, muted). Body: cells `pad($spacing.2,$spacing.3)` text(14). Right-align numbers. Same cell count per row.

## Avatar
Centered frame `s(32-48,32-48) rd($radius.full)` accent fill. Initials text(13-16,sb) white. Use frame + `rd($radius.full)` + `a(c,c)`.

## Avatar Stack
`al(h,g(-8))` — negative gap creates overlap. White 2px stroke separates. Last: "+N" counter muted fill.

## Badge / Status Pill
`al(h,a(c,c),pad(2-4,$spacing.2)) s(hug,hug) rd($radius.full)`. Text(12,m). Tinted bg + saturated text:
Success: bg #ECFDF5, text #10B981 · Warning: bg #FFFBEB, text #D97706 · Error: bg #FEF2F2, text #EF4444 · Info: bg #EFF6FF, text #3B82F6 · Neutral: bg #F1F5F9, text #64748B.

Positioned badge (top-right of card): use `abs` to float outside flow:
```
al(v,g($spacing.3),pad($spacing.4)) s(240,hug) f[(#FFF)] rd($radius.md) st[($neutral.20,w(1))] "Card"
  t("Card Title",Inter,14,sb) f[($neutral.90)]
  t("Description",Inter,13) s(fill,hug) f[($neutral.50)]
  al(h,a(c,c),g($spacing.none),pad($spacing.1,$spacing.2)) abs p(204,-10) s(hug,hug) f[(#10B981)] rd($radius.full) "Badge"
    t("New",Inter,11,sb) f[(#FFF)]
```

## Stat / Metric Card
V-stack `g($spacing.1) pad($spacing.4) s(fill,hug)`. Label text(12-13,m, muted) + value text(24-32,sb) + delta row: arrow icon(12x12, green/red) + percentage. Use `comp` + `inst()` for 3-4 stat tiles.

## Progress Ring / Activity Meter
Dashboards, health overviews, and fitness/usage stats frequently need partial circles. Load `blueprint/arcs` for correct syntax — `arc(start,sweep)` + `ratio(N)` on a `c` element, with stroke + `cap(r,r)`. Do **not** try to fake rings with rotated rectangles, conic gradients, or made-up props like `progress()` or `rd(50%)` with partial fill.

## Rating
H-row `g(2)`. Filled stars: `st[(#F59E0B,w(2))]`. Empty: `st[(#E2E8F0,w(2))]`. Left = filled, right = empty.

## Quote
V-stack `g($spacing.3) pad($spacing.6)`. Open-quote `t("\u201C",serif,48-64)` muted. Quote text(16-18). Attribution: avatar + name + role.
