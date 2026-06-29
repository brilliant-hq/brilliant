---
assumes: blueprint/layout, blueprint/text, blueprint/effects, blueprint/components
---
# Blocks: Navigation

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Horizontal Navbar
spaceBetween row `pad($spacing.md,$spacing.xl) s(SCREEN_W,hug)` `$color.surface` fill. Three groups: Logo (H-row: icon + brand text(18,b)), Nav (H-row `g($spacing.xs)`: links `pad($spacing.sm,$spacing.md)` text(14,m)), Right (H-row: text link + CTA). 1px bottom stroke or shadow.

## Sidebar
V-stack `y(sb),x(c) pad($spacing.md,0) s(64-240,fill)`. For a dark sidebar in a light app, wrap in a frame with `ds(, theme(dark))` and use `$color.surface` — don't hand-paint `$neutral.intense` over a light DS. Top(logo + divider + nav V-stack `g($spacing.xs)`) + Bottom(settings/profile). Nav item: H-row `x(s/c),y(c) g($spacing.sm) pad($spacing.sm) s(fill,hug) rd($radius.sm)`. Selected: `$color.surface.selected` fill + `$color.on-surface.selected` for icon and label (bold weight too). Hovered: `$color.surface.hover` fill. Default: no fill + `$color.text.secondary` icon + `$color.text.primary` label. Disabled: muted icon and label via `$color.text.disabled`, no fill. **Sidebar MUST have fixed height for spaceBetween.**

## Tabs (Underline)

Define a `Tab` set to the side with a `state[active,inactive]` axis — the variant
carries the state (active = filled indicator + bold tinted label; inactive = muted
label, no indicator). Compose the bar from instances: pick the variant, override
only the label text. No per-tab style overrides:
```
-- DEFINE off to the side: one Tab set, two states.
comp "Tab" axes[state[active,inactive]] #tab
  al(v,y(c),x(e),g($spacing.none),pad($spacing.md,$spacing.md,$spacing.none,$spacing.md)) variant(state(active)) s(hug,hug)
    t("Tab",$font.family,$font.size.sm,sb) f[($color.primary)] #tab_label
    r s(fill,2) f[($color.primary)] "Indicator"
  al(v,y(c),x(e),g($spacing.none),pad($spacing.md,$spacing.md,$spacing.none,$spacing.md)) variant(state(inactive)) s(hug,hug)
    t("Tab",$font.family,$font.size.sm,m) f[($color.text.secondary)]
    r s(fill,2) "Indicator"
-- USE: compose the bar; pick the variant, set the label.
al(h,x(s),y(e),g($spacing.none),pad($spacing.none,$spacing.md)) s(hug,hug) "Tab Bar" #tab_bar
  inst(#tab) at(state(active))
    override(#tab_label) t("Overview")
  inst(#tab) at(state(inactive))
    override(#tab_label) t("Activity")
  inst(#tab) at(state(inactive))
    override(#tab_label) t("Insights")
```
`x(s),y(e)` bottom-aligns the indicators. Editing a variant updates every tab; reconfigure one with `#tab_2 at(state(active))`.

## Bottom Tab Bar (Mobile)
Floating pill: H-row `x(c),y(c) g($spacing.xs) pad($spacing.sm) s(hug,hug) rd($radius.full)` high shadow. For a dark pill in a light app, wrap in `ds(, theme(dark))` + `$color.surface` rather than hand-painting `$neutral.intense`. Active: H-row `g($spacing.sm) pad($spacing.sm,$spacing.md)` `$color.primary` fill `rd($radius.full)` icon + `$color.on-primary` label. Inactive: icon only in `$color.text.secondary`.

## Breadcrumbs
H-row `g($spacing.xs) x(s),y(c)`. Interleave: item → caret-right → item. Last item: sb, `$color.text.primary`. Earlier: `$color.text.secondary`.

## Pagination
H-row `x(c),y(c) g($spacing.xs)`. Page numbers: centered frames `s(32-36,32-36) rd($radius.sm)`. Active: `$color.primary` fill + `$color.on-primary` text. Ellipsis for gaps.

## Stepper
A step circle's completed/current/future is a discrete-state control, so define one `state[completed,current,future]` set and stamp instances per step (same pattern as Tabs above). Completed: `$color.primary` fill + checkmark in `$color.on-primary`. Current: `$color.primary` + number. Future: stroke-only + `$color.text.secondary`. Connectors stay as plain bars between the instances.
