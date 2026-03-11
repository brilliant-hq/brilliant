---
assumes: blueprint/layout, blueprint/text, blueprint/effects
---
# Blocks: Inputs

Assumes: `blueprint/core`, `blueprint/layout`, `blueprint/paint`

## Text Input
V-stack `g(6) s(fill,hug)`. Label text(14,m) + input frame: H-row `a(s,c) g(10) pad(0,14) s(fill,44)` white fill + `inner(#000,o(0.06),y(1),blur(2))` + 1px stroke `rd(8)`. Optional leading icon(16x16, #94A3B8). Placeholder text(15, #94A3B8).

## Textarea
V-stack `g(6)`. Label row: spaceBetween(name + counter "0/500"). Input: V-stack `a(s,s) pad(12,14) s(fill,120-200)` stroke `rd(8)`. Placeholder `s(fill,hug)`.

## Search Input
H-row `a(s,c) g(8) pad(0,14) s(fill,44)` stroke `rd(9999 or 8)`. magnifying-glass icon + placeholder. Optional trailing x clear.

## Select / Dropdown
Like Text Input with caret-down icon trailing instead of editable text.

## Checkbox
H-row `a(s,c) g(10)`. Box: centered frame `s(20,20) rd(4)`. Checked: accent fill + `t("\u2713",Inter,12,b)` white. Unchecked: 1.5px stroke.

## Radio Button
H-row `a(s,c) g(10)`. Circle: `s(20,20) rd(9999)`. Selected: accent 2px stroke + inner dot `c s(10,10)`. Unselected: 1.5px stroke.

## Slider
Group `s(W,16)`. Track: rect `s(W,4) rd(9999)` muted. Filled: rect `s(FILL_W,4) rd(9999)` accent. Thumb: circle `s(16,16) rd(9999)` white + shadow.

## File Upload
V-stack `a(c,c) g(8) pad(24,32) s(fill,hug)`. Dashed-look 2px muted stroke `rd(12)`. upload icon + instruction + "Browse" accent text.
