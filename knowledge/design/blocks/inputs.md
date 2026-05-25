---
assumes: blueprint/layout, blueprint/text, blueprint/effects
---
# Blocks: Inputs

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Text Input
V-stack `g($spacing.sm) s(fill,hug)`. Label text(`$font.size.sm`,m,`$color.text.primary`) + input frame: H-row `x(s),y(c) g($spacing.sm) pad(0,$spacing.md) s(fill,44)` with `f[($color.surface),(f2,inner($neutral.intense,o($visibility.faint),y(1),blur(2)))]` + `st[($color.outline.variant,w($stroke.width.subtle))]` 1px stroke `rd($radius.sm)`. Optional leading icon(16x16, `$color.text.disabled`). Placeholder text(`$font.size.md`, `$color.text.disabled`).

## Textarea
V-stack `g($spacing.sm)`. Label row: spaceBetween(name + counter "0/500"). Input: V-stack `y(s),x(s) pad($spacing.md,$spacing.md) s(fill,120-200)` stroke `rd($radius.sm)`. Placeholder `s(fill,hug)`.

## Search Input
H-row `x(s),y(c) g($spacing.sm) pad(0,$spacing.md) s(fill,44)` stroke `rd($radius.full or $radius.sm)`. magnifying-glass icon + placeholder. Optional trailing x clear.

## Select / Dropdown
Like Text Input with caret-down icon trailing instead of editable text.

## Checkbox
H-row `x(s),y(c) g($spacing.sm)`. Box: centered frame `s(20,20) rd($radius.sm)`. Checked: `$color.primary` fill + `t("\u2713",$font.family,12,b)` `$color.on-primary`. Unchecked: 1.5px stroke.

## Radio Button
H-row `x(s),y(c) g($spacing.sm)`. Circle: `s(20,20) rd($radius.full)`. Selected: `$color.primary` 2px stroke + inner dot `c s(10,10)` `$color.primary` fill. Unselected: 1.5px stroke.

## Slider
Group `s(W,16)`. Track: rect `s(W,4) rd($radius.full)` `$color.outline.variant`. Filled: rect `s(FILL_W,4) rd($radius.full)` `$color.primary`. Thumb: circle `s(16,16) rd($radius.full)` `$color.on-primary` + shadow.

## File Upload
V-stack `y(c),x(c) g($spacing.sm) pad($spacing.lg,$spacing.xl) s(fill,hug)`. Dashed-look 2px `$color.outline.variant` stroke `rd($radius.sm)`. upload icon + instruction + "Browse" in `$color.primary` text.
