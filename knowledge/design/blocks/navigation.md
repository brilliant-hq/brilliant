---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Navigation

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Horizontal Navbar
spaceBetween row `pad(12,32) s(SCREEN_W,hug)` white fill. Three groups: Logo (H-row: icon + brand text(18,b)), Nav (H-row `g(4)`: links `pad(8,16)` text(14,m)), Right (H-row: text link + CTA). 1px bottom stroke or shadow.

## Sidebar
V-stack `a(sb,c) pad(12,0) s(64-240,fill)` dark fill. Top(logo + divider + nav V-stack `g(2-4)`) + Bottom(settings/profile). Nav item: H-row `a(s/c,c) g(8) pad(8-12) s(fill,hug) rd(8)`. Active: tinted fill + accent icon. Inactive: no fill + muted. **Sidebar MUST have fixed height for spaceBetween.**

## Tabs (Underline)
```
al(h,a(s,e),pad(0,16)) s(hug,hug) "Tab Bar"
  al(v,a(c,e),pad(12,16,0,16)) s(hug,hug) comp #tab
    t("Overview",Inter,13,sb) f[(#3B82F6)] "Lbl"
    r s(fill,2) f[(#3B82F6)] "Indicator"
  inst(#tab)
    "Lbl" t("Activity") f[(#64748B)] weight(m)
    "Indicator" f[(parent-bg-color)]
```
`a(s,e)` pushes indicators to bottom. Inactive indicator uses parent bg color.

## Bottom Tab Bar (Mobile)
Floating pill: H-row `a(c,c) g(4) pad(6) s(hug,hug)` dark fill `rd(9999)` high shadow. Active: H-row `g(6) pad(8,16)` accent fill `rd(9999)` icon + label. Inactive: icon only.

## Breadcrumbs
H-row `g(4-8) a(s,c)`. Interleave: item → caret-right → item. Last item: sb, dark. Earlier: muted.

## Pagination
H-row `a(c,c) g(4)`. Page numbers: centered frames `s(32-36,32-36) rd(8)`. Active: accent fill + white text. Ellipsis for gaps.

## Stepper
Use `comp` for step circles + connectors. Completed: accent fill + checkmark. Current: accent + number. Future: stroke-only + muted.
