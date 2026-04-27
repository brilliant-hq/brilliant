---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Navigation

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Horizontal Navbar
spaceBetween row `pad($spacing.3,$spacing.8) s(SCREEN_W,hug)` white fill. Three groups: Logo (H-row: icon + brand text(18,b)), Nav (H-row `g($spacing.1)`: links `pad($spacing.2,$spacing.4)` text(14,m)), Right (H-row: text link + CTA). 1px bottom stroke or shadow.

## Sidebar
V-stack `y(sb),x(c) pad($spacing.3,0) s(64-240,fill)` dark fill. Top(logo + divider + nav V-stack `g($spacing.1)`) + Bottom(settings/profile). Nav item: H-row `x(s/c),y(c) g($spacing.2) pad($spacing.2) s(fill,hug) rd($radius.sm)`. Active: tinted fill + accent icon. Inactive: no fill + muted. **Sidebar MUST have fixed height for spaceBetween.**

## Tabs (Underline)

Use `for(...)` for the tab list, then flat-modify the active one:
```
$brand=#EC4899
$neutral=#64748B
$font=Inter
al(h,x(s),y(e),g($spacing.none),pad($spacing.none,$spacing.4)) s(hug,hug) "Tab Bar" #tab_bar
  for($label, in([Overview,Activity,Insights,Settings]))
    al(v,y(c),x(e),pad($spacing.3,$spacing.4,$spacing.none,$spacing.4)) s(hug,hug) "Tab $label" #tab
      t("$label",$font,13,m) f[($neutral.50)] #tab_label
      r s(fill,2) "Indicator" #tab_ind

# Active: Overview
#tab_label_Overview t("Overview",$font,13,sb) f[($brand.50)]
#tab_ind_Overview f[($brand.50)]
```
`x(s),y(e)` pushes indicators to bottom. Inactive indicators stay fill-less
to show parent background; the active override fills the indicator.

## Bottom Tab Bar (Mobile)
Floating pill: H-row `x(c),y(c) g($spacing.1) pad($spacing.2) s(hug,hug)` dark fill `rd($radius.full)` high shadow. Active: H-row `g($spacing.2) pad($spacing.2,$spacing.4)` accent fill `rd($radius.full)` icon + label. Inactive: icon only.

## Breadcrumbs
H-row `g($spacing.1) x(s),y(c)`. Interleave: item → caret-right → item. Last item: sb, dark. Earlier: muted.

## Pagination
H-row `x(c),y(c) g($spacing.1)`. Page numbers: centered frames `s(32-36,32-36) rd($radius.sm)`. Active: accent fill + white text. Ellipsis for gaps.

## Stepper
Use `comp` for step circles + connectors. Completed: accent fill + checkmark. Current: accent + number. Future: stroke-only + muted.
