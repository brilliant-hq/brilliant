---
assumes: design-systems/authoring
dsl: [transforms, mirror, outward, shift, none]
---
# Design System: Mode Transforms

Bare semantic generators bake in mode behavior. Use `transforms:` only to override or opt out.

```
// Bare form = defaults apply per generator:
primary:         boldness(color(#0080FF))            // theme.dark: mirror, accessibility.high-contrast: outward(1)
font.weight:     boldness(number([100,200,300,400,500,600,700,800,900]))  // accessibility.high-contrast: shift(+1)
spacing:         tshirt(number([4,8,16,24,32]), min: { none: 0 })          // density.compact: shift(-1), accessibility.large-text: shift(+1)
font.lineHeight: looseness(number([1,1.25,1.5]))     // accessibility.large-text: shift(+1)

// Override REPLACES defaults, list every entry you want kept. Keys
// axis-qualified (`theme.dark`, never bare `dark`).
font.size: tshirt(number([12,14,16,20,24,32,40,48,64]),
                  transforms: { accessibility.large-text: shift(+1) })   // skip default compact

// Custom axis = relist the defaults you want kept.
modes { brand-variant: [refined, playful] }
accent: boldness(color(#FF6B00),
                 transforms: {
                   theme.dark:                  mirror,
                   accessibility.high-contrast: outward(1),
                   brand-variant.playful:       shift(+2),
                 })

// Opt out: mode-immune (brand-stable knobs).
radius: tshirt(number([4,8,12,16,24]), transforms: none)
```

## Ops

Every op transforms the role's stop index, works on any generator. Out-of-range clamps.

- `shift(N)`: offset; **sums** across active modes
- `mirror`: reflect around the middle stop
- `outward(N)`: push N away from middle toward nearer terminal
