---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Navigation

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Horizontal Navbar
spaceBetween row `pad($spacing.3,$spacing.8) s(SCREEN_W,hug)` white fill. Three groups: Logo (H-row: icon + brand text(18,b)), Nav (H-row `g($spacing.1)`: links `pad($spacing.2,$spacing.4)` text(14,m)), Right (H-row: text link + CTA). 1px bottom stroke or shadow.

## Sidebar
V-stack `a(sb,c) pad($spacing.3,0) s(64-240,fill)` dark fill. Top(logo + divider + nav V-stack `g($spacing.1)`) + Bottom(settings/profile). Nav item: H-row `a(s/c,c) g($spacing.2) pad($spacing.2) s(fill,hug) rd($radius.sm)`. Active: tinted fill + accent icon. Inactive: no fill + muted. **Sidebar MUST have fixed height for spaceBetween.**

## Tabs (Underline)
```
$brand=#EC4899
$neutral=#64748B
$spacing=4
$font=Inter
al(h,a(s,e),g($spacing.none),pad($spacing.none,$spacing.4)) s(hug,hug) "Tab Bar" #tab_bar
  al(v,a(c,e),g($spacing.none),pad($spacing.3,$spacing.4,$spacing.none,$spacing.4)) s(hug,hug) comp #tab
    t("Overview",$font,13,sb) f[($brand.50)] "Lbl" #tab_label
    r s(fill,2) f[($brand.50)] "Indicator" #tab_ind
  inst(#tab)
    override(#tab_label) t("Activity",_,_,m) f[($neutral.50)]
    override(#tab_ind) f[]
```
`a(s,e)` pushes indicators to bottom. Inactive indicator clears fill to show parent background.

## Bottom Tab Bar (Mobile)
Floating pill: H-row `a(c,c) g($spacing.1) pad($spacing.2) s(hug,hug)` dark fill `rd($radius.full)` high shadow. Active: H-row `g($spacing.2) pad($spacing.2,$spacing.4)` accent fill `rd($radius.full)` icon + label. Inactive: icon only.

## Breadcrumbs
H-row `g($spacing.1) a(s,c)`. Interleave: item → caret-right → item. Last item: sb, dark. Earlier: muted.

## Pagination
H-row `a(c,c) g($spacing.1)`. Page numbers: centered frames `s(32-36,32-36) rd($radius.sm)`. Active: accent fill + white text. Ellipsis for gaps.

## Stepper
Use `comp` for step circles + connectors. Completed: accent fill + checkmark. Current: accent + number. Future: stroke-only + muted.
