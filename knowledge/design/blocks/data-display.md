---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Data Display

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Vertical Lanes

Repeated rows (lists, tables, nav items) must form consistent vertical columns. Give icons, indicators, and trailing actions a fixed width — even when a slot is empty in some rows — so columns align across rows with varying content.

## Card
V-stack `g(12-16) pad(20-24) s(W,hug)` white fill + 1px stroke + `rd(12)` + shadow. Title(18-20,sb) + description(14, muted, `s(fill,hug)`) + optional actions. **Image-top:** add `clip`, image `s(fill,160-200)` first child. **Parent gap:** cards need `g(12-16)` on wrapper — card padding is internal.

## List Item
H-row `a(s,c) g(12) pad(12,16) s(fill,hug)`. Leading (icon/avatar) + center V-stack `s(fill,hug)`: title(14,m) + subtitle(13, muted) + trailing (badge, chevron). 1px divider between items.

## Table
V-stack `g(0)`. Header: cells `s(fill,hug) pad(8,12)` tinted bg, text(13,sb, muted). Body: cells `pad(8,12)` text(14). Right-align numbers. Same cell count per row.

## Avatar
Centered frame `s(32-48,32-48) rd(9999)` accent fill. Initials text(13-16,sb) white. Use frame + `rd(9999)` + `a(c,c)`.

## Avatar Stack
`al(h,g(-8))` — negative gap creates overlap. White 2px stroke separates. Last: "+N" counter muted fill.

## Badge / Status Pill
`al(h,a(c,c),pad(2-4,8-12)) s(hug,hug) rd(9999)`. Text(12,m). Tinted bg + saturated text:
Success: bg #ECFDF5, text #10B981 · Warning: bg #FFFBEB, text #D97706 · Error: bg #FEF2F2, text #EF4444 · Info: bg #EFF6FF, text #3B82F6 · Neutral: bg #F1F5F9, text #64748B.

## Stat / Metric Card
V-stack `g(4-8) pad(16-20) s(fill,hug)`. Label text(12-13,m, muted) + value text(24-32,sb) + delta row: arrow icon(12x12, green/red) + percentage. Use `comp` + `inst()` for 3-4 stat tiles.

## Rating
H-row `g(2)`. Filled stars: `st[(#F59E0B,w(2))]`. Empty: `st[(#E2E8F0,w(2))]`. Left = filled, right = empty.

## Quote
V-stack `g(12-16) pad(20-24)`. Open-quote `t("\u201C",serif,48-64)` muted. Quote text(16-18). Attribution: avatar + name + role.
