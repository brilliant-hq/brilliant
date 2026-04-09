---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Feedback

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Alert / Banner
H-row `a(s,s) g($spacing.3) pad($spacing.3,$spacing.4) s(fill,hug) rd($radius.sm)`. Status icon(20x20) + V-stack `s(fill,hug)`: title(14,m) + message(14) + optional dismiss x icon. Use `comp` + `inst()` for multiple variants.
Alert colors — Success: bg #ECFDF5, border #A7F3D0, icon #10B981, title #065F46, body #047857 · Error: bg #FEF2F2, border #FECACA, icon #EF4444, text #991B1B · Warning: bg #FFFBEB, border #FDE68A, icon #F59E0B, text #92400E · Info: bg #EFF6FF, border #BFDBFE, icon #3B82F6, text #1E40AF.

## Toast
H-row `a(s,c) g($spacing.3) pad($spacing.3,$spacing.4) s(320-400,hug) rd($radius.sm)` + shadow. Icon + V-stack: title(14,m) + body(13) + trailing x close. Same colors as Alert. Position: top-right or bottom-center.

## Modal / Dialog
Scrim: rect filling parent `solid(#000,o(0.5))`. Dialog: V-stack `pad($spacing.6) s(480-560,hug)` white `rd($radius.md)` high shadow, centered. Header: spaceBetween(title(18,sb) + x). Footer: H-row `a(e,c) g($spacing.2)`.

## Drawer
V-stack `s(360-480,fill)` white + high shadow. Header: spaceBetween `pad($spacing.4,$spacing.6)` title + x. Content V-stack `g($spacing.4) pad(0,$spacing.6)`.

## Bottom Sheet
```
$neutral=#64748B
$font=Inter
al(v,g($spacing.none),pad($spacing.none)) s(390,hug) f[(#FFF)] rd($radius.lg,$radius.lg,0,0) shadow(#000,o(0.12),y(-4),blur(16)) st[($neutral.20,w(1))] #sheet
  al(h,a(c),g($spacing.none),pad($spacing.3,$spacing.none)) s(fill,hug)
    r s(36,4) f[($neutral.30)] rd($radius.full) "Handle"
  al(v,g($spacing.3),pad($spacing.4,$spacing.6)) s(fill,hug) #sheet_content
    t("Share",$font,16,sb) f[($neutral.90)] #sheet_title
    t("Choose how to share this file",$font,14) f[($neutral.50)] #sheet_desc
```
Top-only radius. Upward shadow `y(-4)`.

## Dropdown Menu
V-stack `pad($spacing.1) s(200-280,hug)` white `rd($radius.sm)` + high shadow + 1px stroke. Items: H-row `a(s,c) g($spacing.2) pad($spacing.2,$spacing.3) s(fill,hug) rd($radius.sm)`. Destructive: red text.

## Tooltip
`pad($spacing.2,$spacing.3) s(hug,hug)` dark fill (#1E293B) `rd($radius.sm)`. White text(12-13). Single line.

## Progress Bar (Flex)
```
$brand=#EF4444
$neutral=#64748B
al(h,g($spacing.none),pad($spacing.none)) s(200,6) f[($neutral.10)] rd($radius.full) clip
  r s(fill:3,fill) f[($brand.50)] "Fill"
  r s(fill:1,fill) "Empty"
```
75% filled. `fill:4`+`fill:1` = 80%.

## Skeleton
Rects mimicking loading layout. `rd($radius.sm) f[(#E2E8F0)]`. Match spacing of real content.

## Empty State
V-stack `a(c,c) g($spacing.3) pad($spacing.12)`. Large icon(48-64, muted) + title(18,sb, centered) + description + optional CTA.
