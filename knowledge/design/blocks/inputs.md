---
assumes: blueprint/layout, blueprint/text, blueprint/effects
---
# Blocks: Inputs

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Text Input
V-stack `g($spacing.2) s(fill,hug)`. Label text(14,m) + input frame: H-row `a(s,c) g($spacing.2) pad(0,$spacing.4) s(fill,44)` with `f[(#FFF),(f2,inner(#000,o(0.06),y(1),blur(2)))]` + 1px stroke `rd($radius.sm)`. Optional leading icon(16x16, #94A3B8). Placeholder text(15, #94A3B8).

## Textarea
V-stack `g($spacing.2)`. Label row: spaceBetween(name + counter "0/500"). Input: V-stack `a(s,s) pad($spacing.3,$spacing.4) s(fill,120-200)` stroke `rd($radius.sm)`. Placeholder `s(fill,hug)`.

## Search Input
H-row `a(s,c) g($spacing.2) pad(0,$spacing.4) s(fill,44)` stroke `rd($radius.full or $radius.sm)`. magnifying-glass icon + placeholder. Optional trailing x clear.

## Select / Dropdown
Like Text Input with caret-down icon trailing instead of editable text.

## Checkbox
H-row `a(s,c) g($spacing.2)`. Box: centered frame `s(20,20) rd($radius.sm)`. Checked: accent fill + `t("\u2713",Inter,12,b)` white. Unchecked: 1.5px stroke.

## Radio Button
H-row `a(s,c) g($spacing.2)`. Circle: `s(20,20) rd($radius.full)`. Selected: accent 2px stroke + inner dot `c s(10,10)`. Unselected: 1.5px stroke.

## Slider
Group `s(W,16)`. Track: rect `s(W,4) rd($radius.full)` muted. Filled: rect `s(FILL_W,4) rd($radius.full)` accent. Thumb: circle `s(16,16) rd($radius.full)` white + shadow.

## File Upload
V-stack `a(c,c) g($spacing.2) pad($spacing.6,$spacing.8) s(fill,hug)`. Dashed-look 2px muted stroke `rd($radius.sm)`. upload icon + instruction + "Browse" accent text.
