---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Feedback

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Alert / Banner
H-row `a(s,s) g(12) pad(12,16) s(fill,hug) rd(8)`. Status icon(20x20) + V-stack `s(fill,hug)`: title(14,m) + message(14) + optional dismiss x icon. Use `comp` + `inst()` for multiple variants.
Alert colors — Success: bg #ECFDF5, border #A7F3D0, icon #10B981, title #065F46, body #047857 · Error: bg #FEF2F2, border #FECACA, icon #EF4444, text #991B1B · Warning: bg #FFFBEB, border #FDE68A, icon #F59E0B, text #92400E · Info: bg #EFF6FF, border #BFDBFE, icon #3B82F6, text #1E40AF.

## Toast
H-row `a(s,c) g(12) pad(12,16) s(320-400,hug) rd(10)` + shadow. Icon + V-stack: title(14,m) + body(13) + trailing x close. Same colors as Alert. Position: top-right or bottom-center.

## Modal / Dialog
Scrim: rect filling parent `solid(#000,o(0.5))`. Dialog: V-stack `pad(24) s(480-560,hug)` white `rd(16)` high shadow, centered. Header: spaceBetween(title(18,sb) + x). Footer: H-row `a(e,c) g(8)`.

## Drawer
V-stack `s(360-480,fill)` white + high shadow. Header: spaceBetween `pad(16,20)` title + x. Content V-stack `g(16) pad(0,20)`.

## Bottom Sheet
```
al(v) s(SCREEN_W,hug) f[(#FFF)] rd(20,20,0,0) shadow(#000,o(0.12),y(-4),blur(16)) st[(#E2E8F0,w(1))]
  al(h,a(c),pad(12,0)) s(fill,hug)
    r s(36,4) f[(#D1D5DB)] rd(9999) "Handle"
  al(v,g(12),pad(16,24)) s(fill,hug)
    t("Share",Inter,16,sb) f[(#0F172A)]
    t("Choose how to share this file",Inter,14) f[(#64748B)]
```
Top-only radius. Upward shadow `y(-4)`.

## Dropdown Menu
V-stack `pad(4-8) s(200-280,hug)` white `rd(8)` + high shadow + 1px stroke. Items: H-row `a(s,c) g(8) pad(8,12) s(fill,hug) rd(4)`. Destructive: red text.

## Tooltip
`pad(6-8,12) s(hug,hug)` dark fill (#1E293B) `rd(6)`. White text(12-13). Single line.

## Progress Bar (Flex)
```
al(h) s(200,6) f[(#E2E8F0)] rd(9999) clip
  r s(fill:3,fill) f[(#3B82F6)] "Fill"
  r s(fill:1,fill) "Empty"
```
75% filled. `fill:4`+`fill:1` = 80%.

## Skeleton
Rects mimicking loading layout. `rd(4-8) f[(#E2E8F0)]`. Match spacing of real content.

## Empty State
V-stack `a(c,c) g(12-16) pad(40-60)`. Large icon(48-64, muted) + title(18,sb, centered) + description + optional CTA.
