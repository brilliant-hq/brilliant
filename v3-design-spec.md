# DS DSL v3 Implementation Spec

Builds on v2 (already shipped — primitive/semantic split, tonal/scale, two-section .gen.yaml). This v3 generalizes to a 5-generator model and unifies vocabularies.

## Five generators

**Primitive generators:**
```
color(seed)                            // OKLCH lightness ramp → 11 stops named .50..950
number(seed, count, ramp)              // generative from a seed value
number(range(min, max), count, ramp)   // generative within bounds
number([stops...])                     // explicit list, count + ramp omitted; stops named .1..N
```

Ramps available: `linear()`, `linear(step: S)`, `geometric()`, `geometric(ratio: R)`.

**Semantic generators (produce 1:N mappings, mode-keyed):**
```
boldness(scale)                        // 9 stops: hint, faint, subtle, soft, mid, firm, bold, strong, intense
tshirt(scale, [min: {name: val}], [max: {name: val}])
                                       // variable stops (xs, sm, md, lg, xl, 2xl..NxL)
                                       // plus optional named boundary stops
looseness(scale)                       // 6 stops: none, tight, snug, normal, relaxed, loose
```

## Replaces v2 generators

- v2 `tonal(seed)` becomes longhand: `boldness(color(seed))`. Catalog can keep `tonal` as a shorthand if useful, but default.styles uses longhand.
- v2 had `intensity` and `weight` as separate generators; v3 unifies into `boldness` with one 9-stop vocabulary.
- v2 didn't have `looseness`; new for v3.

## Vocabulary contracts (uniform across all domains)

**boldness — 9 stops:**
```
hint, faint, subtle, soft, mid, firm, bold, strong, intense
```
Same names used for color tones, font.weight, stroke.width, visibility. Catalog maps role→stop per domain (e.g., for font.weight: `bold → 700` matches CSS canon; for color: `bold → .700` matches OKLCH convention).

**looseness — 6 stops:**
```
none, tight, snug, normal, relaxed, loose
```
Used for font.lineHeight and font.letterSpacing.

**tshirt — variable count by convention:**
```
xs, sm, md, lg, xl, 2xl, 3xl, 4xl, 5xl, 6xl, 7xl, 8xl, 9xl
```
Extends as needed. `min` / `max` params add named boundary stops.

## Override semantics (unchanged from v2)

- Bare value on a mode-aware path = error.
- Block at a path = full replace.
- Dotted-path mode segment = additive override (`color.primary.bold.dark: X`).
- Block with only `$default` = mode-immune lock.

## Bare alias convention

`$primary` resolves to `$primary.mid`. Applies to `boldness()`-generated palettes ONLY (so the agent can write `$primary` for "the canonical primary"). Does NOT apply to `tshirt()` scales — `$spacing` / `$radius` / `$font.size` are never used bare; agent always picks a stop (`$spacing.md`, `$radius.lg`, etc.). Chrome aliases (`$color.surface`, etc.) keep their full name (they ARE the names).

## Domain coverage (canonical default.styles shape)

```
// Colors
primary:    boldness(color(#0080FF))
secondary:  boldness(color(#FF3377))
tertiary:   boldness(color(#FF9900))
quaternary: boldness(color(#FFDD00))
neutral:    boldness(color(oklch(55.6%, 0, 0)))
red:        boldness(color(oklch(63.7%, 0.237, 25.331)))
// ...22 Tailwind palettes total

// Geometry & motion
spacing:      tshirt(number(4, 32, linear()))
radius:       tshirt(number([4, 8, 16, 24, 32, 48]),
                     min: { none: 0 }, max: { full: 9999 })
stroke.width: boldness(number([0.25, 0.5, 0.75, 1, 1.5, 2, 3, 5, 8]))
visibility:   boldness(number([0.02, 0.05, 0.10, 0.20, 0.40, 0.60, 0.80, 0.95, 1.0]))

// Typography
font.family:        Manrope
font.family.serif:  "Noto Serif"
font.family.mono:   monospace
font.size:          tshirt(number([12, 14, 16, 20, 24, 32, 36, 40, 48, 64, 80, 96, 128]))
font.weight:        boldness(number([100, 200, 300, 400, 500, 600, 700, 800, 900]))
font.lineHeight:    looseness(number([1.0, 1.25, 1.375, 1.5, 1.625, 2.0]))
font.letterSpacing: looseness(number([-0.05, -0.025, -0.0125, 0, 0.025, 0.1]))

// Chrome aliases (semantic role names pointing at resolver outputs)
color.surface:                neutral.faint
color.surface.container:      neutral.subtle
color.surface.container.high: neutral.soft
color.on-surface:             neutral.bold
color.outline:                neutral.soft
color.outline.variant:        neutral.subtle
color.text.primary:           neutral.bold
color.text.secondary:         neutral.firm
color.text.disabled:          neutral.soft
color.text.display:           primary.intense
color.text.display.alt:       secondary.intense
color.primary:                primary.mid
color.on-primary:             neutral.50      // primitive ref → mode-immune
color.primary.container:      primary.subtle
// (mirror for secondary, tertiary, success, error, warning, info)
color.shadow:                 neutral.950
color.glow:                   neutral.50
```

## Catalog role-to-stop mappings (canonical defaults)

**`boldness(color(...))` — 9 boldness names × 11 OKLCH stops:**
```
hint    → .50
faint   → .100
subtle  → .200
soft    → .300
mid     → .500
firm    → .600
bold    → .700
strong  → .800
intense → .900
```
(Stops .400, .950 unused by default; available to power users as primitives.)

**`boldness(number([list of 9]))` — direct positional mapping:**
```
hint    → list[0]
faint   → list[1]
...
intense → list[8]
```

**`tshirt(number([list]))` — positional, list[0] → xs, list[1] → sm, etc.**
With `min`/`max` boundaries, those come at the very start / very end with custom names.

**`tshirt(number(seed, count, linear))` — pick by index from generated scale.**
For spacing's 32-stop linear scale, catalog picks: xs→1, sm→2, md→4, lg→6, xl→8, 2xl→12, 3xl→16, 4xl→20, 5xl→24, 6xl→32 (10 stops by default).

**`looseness(number([list of 6]))` — positional:**
```
none → list[0], tight → list[1], snug → list[2], normal → list[3], relaxed → list[4], loose → list[5]
```

## Mode branches per generator

- `boldness(color(...))`: theme.dark inverts low↔high. hint↔intense, faint↔strong, subtle↔bold, soft↔firm, mid stays.
- `boldness(number(...))`: no automatic mode flip by default (numbers don't invert per mode). Mode branches authored explicitly if needed (e.g., stroke.width might thicken in accessibility.high-contrast).
- `tshirt(number(...))`: density.compact shifts mappings down a notch (md → lg's old position, etc.). accessibility.large-text shifts up.
- `looseness(number(...))`: accessibility.large-text shifts toward looser by one step.

These mappings live in catalog code, not user files. The user-authored .styles file just calls `boldness(...)` / `tshirt(...)` / `looseness(...)` and gets the canonical mode-aware behavior.

## Mode axes shipped in default seed

```
modes {
  theme:         [light, dark]
  density:       [comfortable, compact]
  accessibility: [standard, high-contrast, large-text]
}
```

## What needs to change

### Parser / grammar (lib/state/dsl/parser.dart, lib/state/dsl/ast.dart)
- Accept new generator names: `boldness`, `tshirt`, `looseness`
- Keep `color`, `number`, `linear`, `geometric`, `range` as already-supported primitive forms (extend if needed)
- Polymorphic `number()` first arg: value | range | list
- Optional `min` / `max` record params for `tshirt`

### Resolver / generator (lib/state/dsl/resolver.dart, lib/state/design_system_generator.dart, lib/state/dsl/catalog.dart)
- Implement `boldness`, `tshirt`, `looseness` resolvers in catalog
- Each emits primitives + semantic role bindings + mode branches per the mappings above
- Drop `intensity` / `weight` if they existed in v2 (collapse into `boldness`)

### Seed template (lib/state/dsl/seed_template.dart)
- Rewrite using the canonical default.styles shape above
- ~144 lines target

### .gen.yaml writer (lib/state/design_system_format.dart)
- Emit primitives + semantics in two sections as today
- Semantic outputs from boldness/tshirt/looseness land in SEMANTICS section with mode-keyed branches

### Knowledge files (.claude-prod/knowledge/**.md)
- Sweep all DSL examples to use new vocabulary:
  - `$primary.mid` for canonical hue (was `$primary.500` or `$brand.500`)
  - `$primary.bold` etc. for tonal variants
  - `$font.weight.bold` (was likely `b` shorthand)
  - `$stroke.width.bold` for thick lines
  - `$visibility.subtle` for soft opacity (was `o($opacity.10)` over primitive)
  - `$font.lineHeight.normal`, `.relaxed`, etc.
- Update `design-systems/core.md` to teach the v3 model
- Update `design-systems/authoring.md` for new `ds_file()` body syntax

### Website docs (.claude-prod/website-docs or wherever)
- Same sweep as knowledge files for any DSL examples shown on the website
- DSL syntax reference page updated with new generators

### Tests (test/*.dart)
- Update assertions to expect new generator outputs
- Add tests for boldness/tshirt/looseness resolution
- Tests for the polymorphic `number()` (value/range/list)
- Tests for `tshirt()` boundary params (`min`/`max`)

## Acceptance criteria
- `flutter test` green (excluding the 2 pre-existing pre-v3 SVG-related failures)
- Existing element designs (in user repos) either resolve through compat aliases or surface clear unresolved-token diagnostics
- Knowledge file examples in `core.md` render correctly when sent to `create_modify_elements`
