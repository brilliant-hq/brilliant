---
name: "knowledge-design-systems"
description: "Design tokens and design system implementation in Brilliant."
---

# Design Systems

Brilliant manages design tokens through `.styles` files written in a custom DSL. Tokens let you define colors, spacing, typography, shadows, and more once, then reference them throughout your designs. Edit a token, every element using it updates automatically.

For day-to-day blueprint usage, see `design-systems/core`. For authoring or modifying a system, see `design-systems/authoring`. This file is the implementation reference.

## What Are Design Tokens?

Design tokens are named values that represent design decisions. Instead of hardcoding `#0080FF`, you reference `primary.mid`. Benefits:

- **Consistency**: One source of truth for the project's design.
- **Maintainability**: Change the token, every reference updates.
- **Semantic naming**: `color.text.error` is more meaningful than a hex.
- **Scale generation**: One brand seed produces a full 11-step OKLCH ramp plus a mapped 9-stop boldness role vocabulary.

## File Layout

Each repo's design system lives in a `Styles/` folder:

```
my-project/
├── Styles/
│   ├── default.styles               ← project baseline (DSL)
│   ├── corporate-blue.styles        ← optional brand overlay
│   ├── fintech-warm.styles          ← optional brand overlay
│   └── .gen/                        ← generated, never hand-edited
│       ├── default.gen.yaml
│       └── corporate-blue.gen.yaml
└── Canvas.design
```

- **`Styles/default.styles`**: the project baseline. Always exists; auto-created on first run by writing `seedTemplateDsl` verbatim. Contains 22 Tailwind v4 palettes (incl. `neutral`), four brand slots (`primary`, `secondary`, `tertiary`, `quaternary`; Brilliant's defaults are blue / pink / orange / yellow), `boldness`/`tshirt`/`looseness` generators for radius / stroke width / font size / font weight / line height / letter spacing / visibility, `Manrope` + `Noto Serif` font families, semantic surface / text / status aliases, `shadow` / `glow` effect-color roles, typography + shadow composites, and `dark:` branches inline on every mode-aware semantic. Three mode axes are declared by default: `theme: [light, dark]`, `density: [comfortable, compact]`, and `accessibility: [standard, high-contrast, large-text]`.
- **`Styles/<brand>.styles`**: optional brand overlays. Sparse, typically only the deltas vs. `default.styles`.
- **`Styles/.gen/<name>.gen.yaml`**: resolved values for external tools (Style Dictionary, Tokens Studio plugins, custom build scripts). Auto-generated on save. **Never edit `.gen` files**, they're overwritten.

The `.styles` file is the **single source of truth**. Empty file = empty system. Whatever you delete is gone unless an ancestor folder's `default.styles` provides it via the cascade.

Sub-folders can have their own `Styles/default.styles` to override per-folder. The cascade walks parent folders root to leaf, with later layers winning per-field (same model as `.editorconfig`).

## DSL Grammar

Five generators (two primitive, three semantic), plus composites:

```
// PRIMITIVE GENERATORS — exact values, mode-independent.
color(seed)                            // OKLCH lightness ramp → 11 stops .50..950
number(seed, count, ramp)              // generative from a seed value
number(range(min, max), count, ramp)   // generative within bounds
number([stops...])                     // explicit list, stops named .1..N
// Ramps: linear(), linear(step: S), geometric(), geometric(ratio: R)

// SEMANTIC GENERATORS — wrap a primitive, produce mode-aware roles.
boldness(scale)                        // 9 stops: hint, faint, subtle, soft, mid, firm, bold, strong, intense
tshirt(scale, [min: {...}], [max: {...}])
                                       // variable stops: xs, sm, md, lg, xl, 2xl..NxL
looseness(scale)                       // 6 stops: none, tight, snug, normal, relaxed, loose

// Canonical primitives
primary:  color(#0080FF)                             // → primary.50..950 (OKLCH ramp)
red:      color(oklch(63.7%, 0.237, 25.331))         // OKLCH literal seed → ramp
font.family: Manrope                                 // single-value primitive

// Canonical semantics (wrap a primitive in a semantic generator)
primary:      boldness(color(#0080FF))               // tones → hint..intense
spacing:      tshirt(number(4, 32, linear()))        // tshirt scale from a 32-stop ramp
radius:       tshirt(number([4, 8, 16, 24, 32, 48]),
                     min: { none: 0 }, max: { full: 9999 })
stroke.width: boldness(number([0.25, 0.5, 0.75, 1, 1.5, 2, 3, 5, 8]))
visibility:   boldness(number([0.02, 0.05, 0.10, 0.20, 0.40, 0.60, 0.80, 0.95, 1.0]))
font.size:    tshirt(number([12, 14, 16, 20, 24, 32, 36, 40, 48, 64, 80, 96, 128]))
font.weight:  boldness(number([100, 200, 300, 400, 500, 600, 700, 800, 900]))
font.lineHeight:    looseness(number([1.0, 1.25, 1.375, 1.5, 1.625, 2.0]))
font.letterSpacing: looseness(number([-0.05, -0.025, -0.0125, 0, 0.025, 0.1]))

// SEMANTICS (chrome): mode-aware resolvers. Per-mode branches inline.
color.primary {
  $default: primary.mid
  dark:     primary.soft
}
color.surface { $default: neutral.hint, dark: neutral.intense }   // single-line form
color.shadow: neutral.intense                                      // shorthand

// COMPOSITES: structured tokens. Same shape as primitives; value is
// a record (typography) or list (shadow).
typography.h1: { fontSize: font.size.3xl, fontWeight: font.weight.bold, lineHeight: 1.2 }
shadow.md: [
  drop(y: 2, blur: 4, spread: -1, color: rgba(0, 0, 0, 0.06)),
  drop(y: 4, blur: 6, spread: -1, color: rgba(0, 0, 0, 0.10)),
]
```

### Per-stop overrides

Declare an explicit primitive for the stop you want to pin:

```
primary:     boldness(color(#0080FF))   // generates primary.50..950 + role mapping
primary.300: #66B2FF                    // explicit primitive wins over generated
```

### Top-level metadata

```
modes {
  theme:         [light, dark]                  // declare mode axes
  density:       [comfortable, compact]
  accessibility: [standard, high-contrast, large-text]
}

active {
  brand: corporate-blue                       // default brand for this folder + descendants
  modes: { theme: dark }                      // active mode set
}
```

### Cascade flags

```
root: true            // stop the parent-folder walk at this file
inherits: none        // (in a brand file) opt out of merging with sibling default.styles
```

`root: true` truncates the cascade. Files in ancestor folders are not merged. Default `false`.

`inherits: none` makes a brand file standalone instead of layering on top of the sibling `default.styles`. **Default behavior is sparse-overlay inheritance** (`inherits: default`): brand files declare only what differs and the rest comes from `default.styles` automatically — all 22 Tailwind palettes, the brand slots not overridden, neutral, every chrome alias (`color.surface`, `color.text.*`, `color.error` and friends, each with their `.on-X` and `.container` pairs), and every scale (`spacing`, `radius`, `font.*`, `stroke.width`, `visibility`). A complete custom DS is often 1–3 lines. The runtime resolver honors the flag via `DesignSystemManager.loadEffectiveSourceFor` (short-circuits when `ownSource.inheritsBase == false`); the `.gen.yaml` writer too.

### Removing tokens

`unset { ... }` drops entries from the merged file:

```
ds_file("corporate-blue")
  primary: boldness(color(#1976D2))
  unset {
    color.primary                    // drop the entire semantic
    primary.300                      // drop a specific stop override
    color.surface.dark               // drop just the dark branch of a semantic
    *.dark                           // drop the dark branch across ALL semantics
    typography.h1.fontSize           // drop a composite field
    typography.h2                    // drop the entire composite
  }
```

The wildcard form `*.<key>` strips that branch across every mode-keyed
semantic in one go. Top-level only. Nested `unset` is not supported.

## Token Types

| Type | Key Pattern | Generator | Examples |
|------|-------------|-----------|----------|
| **Color (primitive)** | `<name>.<step>` | `color(seed)` — OKLCH ramp from a hex/oklch seed | `primary.500`, `red.100`, `acme_blue.700` |
| **Color (roles)** | `<name>.<role>` | `boldness(color(...))` — 9-stop tonal vocabulary | `primary.mid`, `red.bold`, `neutral.subtle` |
| **Spacing** | `spacing.<step>` | `tshirt(number(4, 32, linear()))` | `spacing.md`, `spacing.2xl` |
| **Radius** | `radius.<step>` | `tshirt(number([...]), min: { none: 0 }, max: { full: 9999 })` | `radius.md`, `radius.full` |
| **Stroke width** | `stroke.width.<step>` | `boldness(number([...]))` | `stroke.width.soft`, `stroke.width.bold` |
| **Visibility (opacity)** | `visibility.<step>` | `boldness(number([0.02..1.0]))` | `visibility.subtle`, `visibility.mid` |
| **Font size** | `font.size.<step>` | `tshirt(number([12..128]))` | `font.size.xs` … `font.size.9xl` |
| **Font weight** | `font.weight.<step>` | `boldness(number([100..900]))` | `font.weight.bold`, `font.weight.mid` |
| **Line height** | `font.lineHeight.<step>` | `looseness(number([1.0..2.0]))` | `font.lineHeight.tight`, `font.lineHeight.relaxed` |
| **Letter spacing** | `font.letterSpacing.<step>` | `looseness(number([-0.05..0.1]))` | `font.letterSpacing.tight`, `font.letterSpacing.loose` |
| **Font family** | `font.family` | Single value | resolves to a string |
| **Typography** | `typography.<name>` | Composite (record with `fontSize`, `fontWeight`, `lineHeight`, optional `fontFamily`) | `typography.h1`, `typography.body.md` |
| **Shadow** | `shadow.<name>` | Composite (list of `drop(...)` layers) | `shadow.md`, `shadow.inner` |

## Color Seeds

A color seed declared with `color(...)` generates an 11-step OKLCH ramp:
`<name>.{50, 100, 200, 300, 400, 500, 600, 700, 800, 900, 950}`. The seed
value IS the `.500` stop. Without `color(...)`, the value is a single-
color primitive (no ramp).

Wrap a `color(...)` seed in `boldness(...)` to also emit the 9-stop role
vocabulary (`primary.hint..primary.intense`) plus mode branches that
invert low↔high under `theme.dark`.

**Two literal forms** for color seeds:
- **sRGB hex**: `primary: color(#0080FF)`
- **OKLCH literal**: `primary: color(oklch(63.7%, 0.237, 25.331))`. `L` on a 0 to 1 scale (or `%`), `C` raw chroma, `H` hue in degrees. The resolver converts to sRGB at parse time.

The seed template ships Tailwind v4's 22 palettes (`red, orange, amber, yellow, lime, green, emerald, teal, cyan, sky, blue, indigo, violet, purple, fuchsia, pink, rose, slate, gray, zinc, neutral, stone`) declared as OKLCH literals for bit-exact parity with Tailwind. Plus four brand slots that ship with Brilliant's logo palette as defaults: `primary` (`#0080FF`), `secondary` (`#FF3377`), `tertiary` (`#FF9900`), `quaternary` (`#FFDD00`). `neutral` is one of the Tailwind palettes (oklch 55.6%/0/0), not a separate hex default.

**Custom palettes:** any name works. `acme_blue: boldness(color(oklch(60%, 0.21, 230)))` immediately produces `acme_blue.50`..`acme_blue.950` plus `acme_blue.hint..acme_blue.intense`.

### Lightness scale + boldness role mapping

From `kLightnessTargets` in `lib/state/dsl/catalog.dart` and the catalog's role mappings:

| Stop | Lightness | Boldness role | Typical use |
|------|-----------|---------------|-------------|
| `.50` | 0.97 | `hint` | Subtle backgrounds |
| `.100` | 0.94 | `faint` | Light backgrounds |
| `.200` | 0.87 | `subtle` | Hover states / soft washes |
| `.300` | 0.80 | `soft` | Borders |
| `.400` | 0.71 | (unused) | Muted elements |
| `.500` | 0.62 | `mid` | **Primary** (the seed value, aligned with Tailwind v4's .500 median) |
| `.600` | 0.50 | `firm` | Hover on primary |
| `.700` | 0.42 | `bold` | Active states |
| `.800` | 0.36 | `strong` | Dark accents |
| `.900` | 0.29 | `intense` | Very dark |
| `.950` | 0.23 | (unused) | Darkest accents |

Stops `.400` and `.950` are unused by the default boldness mapping but available to power users as primitives.

### Dark theme

`boldness(color(...))` automatically inverts low↔high under `theme.dark`
(`hint↔intense`, `faint↔strong`, `subtle↔bold`, `soft↔firm`, `mid` stays).
Every mode-aware semantic in `default.styles` has a `dark:` branch
inline. Surfaces flip to `neutral.intense` / `neutral.strong`, role
bolds lift one stop (`color.primary: { $default: primary.mid, dark:
primary.soft }`), status text lightens (`color.text.success: { $default:
green.bold, dark: green.soft }`). Edit any semantic freely.

## Modes

Declare axes once at the top of the file. Semantic blocks carry per-mode
branches keyed by axis values:

```
modes {
  theme:         [light, dark]
  density:       [comfortable, compact]
  accessibility: [standard, high-contrast, large-text]
}

color.text.primary {
  $default:                       neutral.intense
  dark:                           neutral.hint     // single value, theme axis
  density.compact:                neutral.strong   // qualified path
  theme.dark, density.compact:    neutral.faint    // combo: both active
}
```

Primitives are mode-INDEPENDENT and cannot be mode-keyed. To make a
seed differ across modes, declare two primitives and pick between them
via a semantic that does the routing. Semantic generators (`boldness`,
`tshirt`, `looseness`) emit mode-aware branches automatically per the
catalog defaults:

- `boldness(color(...))`: `theme.dark` inverts low↔high.
- `boldness(number(...))`: no automatic mode flip by default.
- `tshirt(number(...))`: `density.compact` shifts down a notch;
  `accessibility.large-text` shifts up.
- `looseness(number(...))`: `accessibility.large-text` shifts toward
  looser by one step.

The first value in each axis is the default. Top-level declarations
without a semantic block apply across all modes; semantic blocks layer
per-mode overrides at the semantic level.

## Brand Variants

Brands live as siblings in `Styles/`:

```
Styles/
├── default.styles           ← shared baseline (auto-created with seed template)
├── corporate-blue.styles    ← brand A overlay (sparse: only the differences)
└── fintech-warm.styles      ← brand B overlay
```

The folder-level active brand comes from the `active { brand: ... }` declaration in `default.styles`. The chat picker in the AI panel selects a brand for the current chat session, which auto-stamps top-level frames the agent creates.

A brand can opt out of base inheritance with `inherits: none` for fully custom systems. The runtime resolver honors this flag and stops merging with the sibling `default.styles`.

## The .gen.yaml Artifact

Every `.styles` file produces a sibling `.gen/<name>.gen.yaml` containing fully-resolved values. The .gen file:

- Is regenerated automatically on save and on app start.
- Includes inheritance: a brand `.gen.yaml` reflects the merged base + brand state, not just the brand's own declarations.
- Is for external tools (Style Dictionary, Tokens Studio, custom build scripts).
- Is git-ignored (`Styles/.gen/` added to `.gitignore` automatically) and never hand-edited.
- Has two sections: PRIMITIVES (raw stops from `color()` / `number()`) and SEMANTICS (mode-keyed branches from `boldness()` / `tshirt()` / `looseness()`).

## Using Tokens

### In the inspector

The right toolbar has a **Design system section** at the top showing:
- The active brand for the current scope (folder when nothing selected, per-element when selection exists).
- A dropdown per mode axis declared by the active system (e.g. `theme`, `density`, `accessibility`).

Changing a dropdown rewrites the folder's `active { ... }` block, or, with a selection, sets `Element.designSystem` on each selected element. Hover preview is wired through both paths.

Most other properties accept token bindings:

| Property | Token type accepted |
|----------|---------------------|
| Fill / stroke color | Color tokens |
| Fill / stroke opacity | Visibility tokens |
| Corner radius (per corner) | Radius tokens |
| Element opacity | Visibility tokens |
| Font size, weight, line height | Corresponding `font.*` tokens |
| Auto layout gap and padding | Spacing tokens |

When a property is bound, the field shows the token name. Manually editing the value clears the binding for that property. Composite tokens (typography and shadow) are applied via the **Apply Typography Token** and **Apply Shadow Token** commands.

Token-bound colors work in **every color slot**: solid fills, gradient stops, shader colors, effect colors (inner shadow/glow, drop shadow, outer glow), image filter colors (duotone, halftone), layout grid colors, text-range colors. Gradient/shader stops use parallel `colorTokenRefs`/`colorOpacityTokenRefs` arrays alongside `colors[]`; see `blueprint_token_normalizer.dart`.

**No inspector binding for these**. Bind via blueprint or programmatically:
- `stroke.width` tokens (data model supports `Stroke.thickness` as `TokenizedDouble`; no inspector UI to bind)
- `font.family` token (data model supports `TextData.fontFamilyTokenRef`; the font picker sets `fontFamily` literally)
- `shadow` tokens (use **Apply Shadow Token** command, stores `Element.shadowTokenRef`)
- `typography` composites (use **Apply Typography Token** command, stores `TextData.typographyTokenRef`)

### In blueprints

Reference tokens with the `$` prefix. Works in fills, strokes, gap, padding, corner radius, font size, and every color slot:

```
al(v, g($spacing.md), pad($spacing.lg)) s(320, hug) f[($color.surface)] st[($color.outline.variant, w($stroke.width.subtle))] rd($radius.md) "Card"
  t("Card Title", Inter, $font.size.xl, b) f[($color.text.primary)]

al(h, x(c), y(c), pad($spacing.sm, $spacing.md)) s(hug, 48) f[($color.primary)] rd($radius.md) "Button"
  t("Get Started", Inter, $font.size.sm, sb) f[($color.on-primary)]
```

References resolve at creation using the active design system. If a token doesn't exist, the property is skipped and the default is used.

**Numeric stops are author-only.** `$spacing.N` (and `$radius.N`, `$font.size.N`, any numeric-suffix stop) is a *primitive* — usable when authoring a `.styles` file, but **rejected in element rows in explicit mode** (the call halts). Element rows must use the semantic **role** names: `xs/sm/md/lg/xl/2xl…` for spacing/radius/font-size, `hint/faint/subtle/soft/mid/firm/bold/strong/intense` for stroke-width/visibility/font-weight, `none/tight/snug/normal/relaxed/loose` for line-height/letter-spacing. The renderer *can* resolve a numeric stop (even past `spacing.32`), but resolvable ≠ permitted — the explicit-mode interpreter blocks it before render. In None mode, numeric stops and bare values are both fine.

## Editing the Design System

### Open the file

The **Open Design System File** command opens the nearest `.styles` file in the code editor with DSL syntax highlighting.

### Commands

In v2 the seed and token mutation commands were retired in favor of direct DSL authoring (open the `.styles` file, or use the inline `ds_file("name")` directive from a blueprint). Only eight design-system commands remain, all of which write the DSL file and regenerate the sibling `.gen.yaml` automatically. All support undo (Cmd+Z) via per-canvas `UndoManagerRouter`.

| Command (display name) | Command ID | Purpose |
|---|---|---|
| Regenerate Design System | `regenerate_design_system` | Rebuild all `.gen.yaml` files from the current `.styles` sources |
| Reset Design System | `reset_design_system` | Reset to seed template (rewrites `Styles/default.styles`; undoable) |
| Open Design System File | `open_design_system_file` | Open the nearest `.styles` source in the code editor |
| Apply Typography Token | `apply_typography_token` | Apply a `typography.*` composite to the selected text element(s); stores `TextData.typographyTokenRef` |
| Apply Shadow Token | `apply_shadow_token` | Apply a `shadow.*` composite to selected element(s); stores `Element.shadowTokenRef` |
| Create Design System Viewer | `create_design_system_viewer` | Insert an 800x600 viewer element visualizing the active system's color seeds and typography composites |
| Set Design System | `set_design_system` | Brand setter (dropdown, hover preview, selection-aware) |
| Set Design System Mode | `set_design_system_mode` | Mode setter per axis (dropdown, hover preview, selection-aware) |

For agents: brand / mode switching and the two composite-apply commands run through `execute_commands`. **All token authoring (new seeds, new aliases, scale tweaks, mode overrides, removals) is done by editing the `.styles` file directly**, either by opening it via `Open Design System File` or by emitting an inline `ds_file("name")` directive from a blueprint (see `design-systems/authoring`).

## Built-in Semantic Aliases (Seed Template)

Surface, outline, and text roles:

| Token | Default reference | Usage |
|-------|------------------|-------|
| `color.surface` | `neutral.hint` | Page backgrounds (lightest tier) |
| `color.surface.container` | `neutral.faint` | Card / panel backgrounds (one step elevated) |
| `color.surface.container.high` | `neutral.subtle` | Modal / popover / lightbox backgrounds (deepest elevation) |
| `color.surface.hover` | `neutral.faint` | Interactive item being hovered (calibrated for items on `color.surface`) |
| `color.surface.pressed` | `neutral.subtle` | Interactive item being clicked / held down |
| `color.surface.selected` | `primary.subtle` | Current row in a nav / menu / list — brand-tinted |
| `color.on-surface` | `neutral.bold` | Text on surfaces |
| `color.on-surface.selected` | `primary.bold` | Icon + bold label on a `color.surface.selected` row |
| `color.outline` | `neutral.soft` | Prominent borders — card frames, focused inputs, outlined buttons |
| `color.outline.variant` | `neutral.subtle` | Subtle inline dividers — list rows, table cells, in-card separators |
| `color.text.primary` | `neutral.bold` | Body text |
| `color.text.secondary` | `neutral.firm` | Secondary text |
| `color.text.disabled` | `neutral.soft` | Disabled text |
| `color.text.success` | `green.bold` | Success copy |
| `color.text.error` | `red.bold` | Error copy |
| `color.text.warning` | `orange.bold` | Warning copy |
| `color.text.display` | `primary.intense` | Hero / title color |
| `color.text.display.alt` | `secondary.intense` | Hero callout variant |

Three-role brand hierarchy (M3-style), each with a paired `on-X` foreground and `X.container` soft tint:

| Token | Default reference |
|-------|------------------|
| `color.primary` / `on-primary` / `primary.container` | `primary.mid` / `neutral.50` / `primary.subtle` |
| `color.secondary` / `on-secondary` / `secondary.container` | `secondary.mid` / `neutral.50` / `secondary.subtle` |
| `color.tertiary` / `on-tertiary` / `tertiary.container` | `tertiary.mid` / `neutral.intense` / `tertiary.subtle` |

Status roles (`success`, `error`, `warning`, `info`), each with `color.<role>` / `color.on-<role>` / `color.<role>.container`:

| Role | Mid | Container |
|------|------|-----------|
| `success` | `green.mid` | `green.subtle` |
| `error` | `red.mid` | `red.subtle` |
| `warning` | `orange.mid` | `orange.subtle` |
| `info` | `blue.mid` | `blue.subtle` |

Effect-color roles consumed by the blueprint parser as defaults when `shadow()` / `outerglow()` are written without an explicit color:

| Token | Default reference |
|-------|------------------|
| `color.shadow` | `neutral.950` |
| `color.glow` | `neutral.50` |

(These point at primitive stops rather than role names so the cast color stays mode-immune; mode flipping happens at the semantic alias layer.)

Each semantic in `default.styles` carries a `dark:` branch inline that
re-points to inverted role stops (surfaces flip to `neutral.intense` /
`neutral.strong`; role bolds lift one stop, e.g.
`color.primary.dark → primary.soft`,
`color.text.success.dark → green.soft`).

## Built-in Composites (Seed Template)

**Typography** (`typography.<name>`):
- Display: `display.lg`, `display.md`, `display.sm`
- Editorial (serif): `editorial.lg`, `editorial.md`, `editorial.sm` (bound to `font.family.serif`, Noto Serif)
- Headings: `h1`, `h2`, `h3`, `h4`
- Body: `body.lg`, `body.md`, `body.sm`
- UI: `button`, `input`, `label`, `caption`
- Code: `code` (uses monospace `fontFamily`)

**Shadow** (`shadow.<name>`): `shadow.2xs`, `shadow.xs`, `shadow.sm`, `shadow.md`, `shadow.lg`, `shadow.xl`, `shadow.2xl`, `shadow.inner`.

All built-in composites are declared in `Styles/default.styles` of every project. Visible, editable, removable.

## Limitations / Known Gaps

- **No standalone variables panel / token editor UI.** Token bindings are surfaced inline in the inspector (color picker swatches at the bottom, font/spacing/radius dropdowns). All authoring (new seeds, new tokens, scale tweaks, mode overrides, removals) happens in the `.styles` file: open it via **Open Design System File**, or emit an inline `ds_file("name")` directive from a blueprint.
- **No token export to CSS variables / Tailwind config.** External tools consume the `.gen.yaml` artifact.
- **No keyboard shortcut to switch modes** by default. Use the **Design system** section in the right toolbar (top), or invoke `set_design_system_mode` via `execute_commands`.
- **No `stroke.width` inspector binding** (data model supports it; UI does not).
- **No `font.family` inspector binding** (data model supports `fontFamilyTokenRef`; the font picker writes the literal). Bind via a typography composite or programmatically.
- **No in-app rename / delete buttons for tokens.** Edit the `.styles` file directly.
- **Color picker token swatches render in `currentMode = ''`** (mode-themed swatches show the base, not the active-mode value).
- **Chat-session brand picker is in-memory only.** Selection is lost on app restart.
