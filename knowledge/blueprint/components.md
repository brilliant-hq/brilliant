---
assumes: blueprint/core, blueprint/layout
---
# Blueprint Components & Instances

**Default to `comp` + `inst()` whenever you'd write similar elements more than once.** This is a DRY rule, not a design-system rule — instances cut token cost roughly in half and render faster. Cards in a grid, rows in a table, tabs, chart columns, stat tiles, nav items — if it doesn't actively hurt to share structure, use components. Consistency and linked updates are free side effects.

## Create Master

Add `comp` bare flag to a frame. **CRITICAL: assign `#ref` to EVERY child you plan to override in instances.** The `override(#ref)` syntax requires the exact same `#ref` that was assigned on the master child — element names alone don't work as override refs.
```
al(v,g(16),pad(24)) s(300,hug) f[(#FFF)] st[(#E2E8F0,w(1))] rd(16) shadow(#000,o(0.06),y(2),blur(8)) "Card" comp #card
  t("Title",Inter,18,b) f[(#0F172A)] "Title" #title
  t("Description",Inter,14) s(fill,hug) f[(#64748B)] "Description" #desc
```

## Create Instances

`inst(#ref)` referencing master. Use `override(#ref)` to modify specific children — the `#ref` MUST match a `#ref` assigned on the master child:
```
inst(#card) p(320,0) f[(#1E293B)] st[(#334155,w(1))] "Pro Card" #pro
  override(#title) t("Pro Plan") f[(#F8FAFC)]
  override(#desc) t("For growing teams") f[(#94A3B8)]
```

Only specified properties change — everything else syncs to master.

**Common mistake:** Using an element's name as the override ref without assigning a matching `#ref`. If the master child is `"Title"` but has no `#title` ref, then `override(#title)` won't match. Always assign `#ref` on the master child first.

## Slots

Mark children with `slot` to let instances own that subtree:
```
al(v,g(8)) s(fill,hug) "Features" slot
  t("3 projects",Inter,14) f[(#475569)]
```

When you override a slot with indented children, existing children are **replaced** — the instance owns the slot content entirely.

## Variables (`$var`) — text substitution before parsing
```
$bg=#F8FAFC
$brand=#3B82F6
$card_fill=f[($bg)] st[($brand,w(1))] rd(12)
al(v,pad(24)) s(400,hug) $card_fill "Card"
  t("Styled with variables",Inter,14) f[(#334155)]
```
Variables can reference earlier variables: `$gradient=linear(135,$brand,$accent)`.

## SVG Icon Overrides

SVG icons inside components can be overridden with different icons:
```
al(h,a(c,c),g(8),pad(10,16)) s(hug,hug) f[(#3B82F6)] rd(8) "NavItem" comp #navitem
  svg(icon:house) s(16,16) f[(#FFF)] "Icon" #icon
  t("Home",Inter,14,m) f[(#FFF)] "Label" #label
inst(#navitem) p(200,0) f[(#8B5CF6)]
  override(#icon) svg(icon:gear) f[(#FFF)]
  override(#label) t("Settings")
```

The replacement SVG inherits the original's size automatically. Fill/stroke overrides on the same line are applied to the new SVG.

## `inst()` vs `clone()`

`inst()` = linked to master, stays synced. `clone()` = independent copy, no link. Both use `override(#ref)` for child overrides.
