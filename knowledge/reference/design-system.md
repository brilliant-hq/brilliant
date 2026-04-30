---
name: "knowledge-design-system"
description: "Design tokens and design system usage in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Design System

Brilliant supports design tokens through `.styles` files. Tokens let you define colors, spacing, typography, and more once, then reference them throughout your designs. Changes to tokens automatically update all elements using them.

## What Are Design Tokens?

Design tokens are named values that represent design decisions. Instead of hardcoding `#6264A7`, you use `brand.50`. Benefits:

- **Consistency**: One source of truth for your design system
- **Maintainability**: Change the token, update everywhere
- **Semantic naming**: `brand.50` is more meaningful than a hex code
- **Scale generation**: Define one brand color, get a full 5–90 scale

## Using Tokens in the Color Picker

1. Open the color picker (click any color swatch in the right toolbar)
2. Scroll to the **Design Tokens** section
3. Tokens are grouped by seed name (brand, neutral, success, error, warning, info, plus any custom seeds)
4. Click a token swatch to apply it

Token-bound color swatches show a subtle blue-purple border to indicate they're linked to a token.

## Binding Other Properties to Tokens

Several inspector fields in the right toolbar accept token bindings via dropdowns or inline menus:

| Property | Where | Tokens accepted |
|----------|-------|-----------------|
| Fill / stroke color | Color picker (any swatch) | Color tokens |
| Fill / stroke opacity | Color picker opacity field | Opacity tokens |
| Corner radius (per corner) | Frame / rectangle section | Radius tokens |
| Element opacity | Layer section (top of inspector) | Opacity tokens |
| Font size, weight, line height | Typography section | Corresponding `font.*` tokens |
| Auto layout gap and padding (uniform or per-side) | Auto layout section | Spacing tokens |

When a property is bound to a token, the field shows the token name. Manually editing the value clears the binding for that property. Composite tokens (typography and shadow) are applied via the **Apply Typography Token** and **Apply Shadow Token** commands and clear individual bindings on the same property group.

**No inspector UI for these token types:**
- **Stroke width tokens** cannot be bound from the inspector. Use blueprint syntax (`st[(#000,w($stroke.width.md))]`) or programmatic invocation. Bound stroke widths also do NOT re-resolve on mode change (known runtime gap).
- **Font family tokens** (the single `font.family` token) cannot be bound from the typography font picker. The font selector sets `fontFamily` directly. Use a typography composite via **Apply Typography Token** (which can carry a `fontFamily`) or blueprint syntax to bind to `font.family`.
- **Shadow tokens** are applied through the **Apply Shadow Token** command (palette) or the AI/MCP path, not from the effects panel. The effects panel only edits raw shadow values.
- **Typography composite tokens** are applied through the **Apply Typography Token** command (palette) or AI/MCP path. There is no in-inspector "pick a typography token" dropdown.

**No general token-creation UI.** Tokens, seeds, modes, and mode seeds are created and edited by editing the `.styles` file in the code editor (open via the **Open Design System File** command) or by AI/MCP commands. There is no variables panel, no in-app token editor, and no UI button to add a new color seed or custom token.

## Using Tokens in Blueprints

Reference tokens with the `$` prefix in blueprint syntax. Tokens work in fills, strokes, gap, padding, and corner radius:

```
# Color tokens in fills and strokes
al(v,g($spacing.4),pad($spacing.6)) s(320,hug) f[($brand.50)] st[($neutral.30,w(1))] rd(12) "Card"
  t("Card Title",Inter,20,b) f[($brand.90)]

# Spacing tokens in gap and padding
al(v,g($spacing.4),pad($spacing.6)) s(fill,hug) "Section"
  t("Features",Inter,24,b) f[($brand.80)]

# Radius tokens
al(h,x(c),y(c),g($spacing.none),pad($spacing.3,$spacing.4)) s(hug,48) f[($brand.50)] rd($radius.md) "Button"
  t("Get Started",Inter,14,sb) f[(#FFFFFF)]
```

Token references resolve at creation time using the active design system. If a token doesn't exist, the property is skipped and the default value is used.

## Token Types

| Type | Key Pattern | Examples | Description |
|------|-------------|----------|-------------|
| **Color** | `{name}.{step}` | `brand.50`, `neutral.30`, `accent.10` | Generated 5–90 scales (10 steps) from any color seed |
| **Spacing** | `spacing.{n}` | `spacing.none`, `spacing.1` … `spacing.32` | `none` = 0, integers 1–32 = `base × n` (continuous scale, no `sm`/`md`/`lg` keys) |
| **Radius** | `radius.{step}` | `radius.none`, `radius.sm`, `radius.md`, `radius.lg`, `radius.xl`, `radius.full` | Multipliers of base radius; `full` = 9999 |
| **Font Size** | `font.size.{step}` | `font.size.xs` … `font.size.2xl` | 6 steps (xs, sm, md, lg, xl, 2xl): multipliers of `font.size` base |
| **Font Family** | `font.family` | `font.family` | Single token (no scale): the seed family name |
| **Font Weight** | `font.weight.{step}` | `font.weight.bold`, `font.weight.semibold` | 9 steps from `thin` (100) to `black` (900) |
| **Line Height** | `font.lineHeight.{step}` | `font.lineHeight.tight`, `font.lineHeight.normal` | 6 steps: `none` (1.0), `tight` (1.25), `snug` (1.375), `normal` (1.5), `relaxed` (1.625), `loose` (2.0) |
| **Opacity** | `opacity.{step}` | `opacity.0`, `opacity.50`, `opacity.100` | 12 fixed steps: 0, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 |
| **Typography** | `typography.{name}` | `typography.h1`, `typography.body.md` | Composite: font family + size + weight + line height + letter spacing |
| **Stroke Width** | `stroke.width.{step}` | `stroke.width.sm`, `stroke.width.lg` | 6 steps: `none`, `hairline`, `sm`, `md`, `lg`, `xl` (multipliers of `stroke.width` base) |
| **Shadow** | `shadow.{step}` | `shadow.sm`, `shadow.md`, `shadow.lg`, `shadow.xl` | Composite: one or more shadow layers (x, y, blur, spread, color) |
| **Boolean** | (custom) | `feature.flag: true` | True/false values, useful for AI agents and feature switches in custom workflows |

**Blueprint extension:** `$spacing.N` resolves dynamically for any positive integer in blueprint syntax even if the materialized scale only goes up to `spacing.32`. The token picker UI only surfaces `spacing.none` and `spacing.1` through `spacing.32` as persisted tokens.

## Color Token Scale

Color tokens are generated from a seed color using OKLCH color space for perceptual uniformity. Any color seed (not just the defaults) generates a full scale:

| Token | Lightness | Usage |
|-------|-----------|-------|
| `{name}.5` | 97% | Subtle backgrounds |
| `{name}.10` | 94% | Light backgrounds |
| `{name}.20` | 87% | Hover states |
| `{name}.30` | 76% | Borders |
| `{name}.40` | 64% | Muted elements |
| `{name}.50` | 50% | **Primary color** |
| `{name}.60` | 40% | Hover on primary |
| `{name}.70` | 32% | Active states |
| `{name}.80` | 25% | Dark accents |
| `{name}.90` | 18% | Very dark |

Lower numbers = lighter. Higher numbers = darker. The seed alias (e.g., `brand`) maps to the original seed color value in light mode. The `.50` step is generated from the OKLCH scale at 50% lightness, which is close but not identical to the seed.

**Dark mode inversion:** Color steps are mirrored using the `_darkModeStepMap` table: `.5` ↔ `.90`, `.10` ↔ `.80`, `.20` ↔ `.70`, `.30` ↔ `.60`, `.40` ↔ `.50`. So in dark mode, `brand.5` uses the light-mode `brand.90` color, etc. The bare seed alias (e.g., `brand` without a step number) resolves to the `.40` step from the light scale in dark mode, not the original seed color. This ensures light backgrounds become dark and vice versa while keeping the same semantic usage of token names.

**Custom color seeds:** Any name works. Add `accent: "#FF6347"` to get `accent.5` through `accent.90`.

## Spacing Token Scale

Spacing tokens use a configurable base (default 4) with integer multipliers from 1 to 32. The scale is **continuous**: every integer key resolves to `base × n`. There are no `sm`/`md`/`lg` step names for spacing.

| Token | Default Value | Usage |
|-------|---------------|-------|
| `spacing.none` | 0 | No spacing |
| `spacing.1` | 4 | Tight inline spacing |
| `spacing.2` | 8 | Small gaps |
| `spacing.3` | 12 | Default spacing |
| `spacing.4` | 16 | Section spacing |
| `spacing.6` | 24 | Large gaps |
| `spacing.8` | 32 | Section breaks |
| `spacing.12` | 48 | Major sections |
| `spacing.16` | 64 | Hero spacing |
| `spacing.24` | 96 | Page sections |
| `spacing.32` | 128 | Maximum materialized step |

`$spacing.N` works for any positive integer in blueprint syntax even beyond 32: the scale just stops materializing tokens at that ceiling.

## Radius Token Scale

Default base = 4. Multipliers: `none` (0), `sm` (1×), `md` (2×), `lg` (4×), `xl` (6×). `full` is a fixed value (9999), not a multiplier.

| Token | Multiplier | Default Value | Usage |
|-------|-----------|--------------|-------|
| `radius.none` | 0 | 0 | Sharp corners |
| `radius.sm` | 1 | 4 | Subtle rounding |
| `radius.md` | 2 | 8 | Default (cards, buttons) |
| `radius.lg` | 4 | 16 | Prominent rounding |
| `radius.xl` | 6 | 24 | Large containers |
| `radius.full` | (fixed) | 9999 | Fully rounded (pills, circles) |

## Stroke Width Token Scale

Default base = 1. Multipliers (except `none` which is fixed 0): `hairline` (0.5×), `sm` (1×), `md` (2×), `lg` (4×), `xl` (8×).

| Token | Multiplier | Default Value |
|-------|-----------|--------------|
| `stroke.width.none` | (fixed) | 0 |
| `stroke.width.hairline` | 0.5 | 0.5 |
| `stroke.width.sm` | 1 | 1 |
| `stroke.width.md` | 2 | 2 |
| `stroke.width.lg` | 4 | 4 |
| `stroke.width.xl` | 8 | 8 |

**Known limitations:**
- The right toolbar has no token-binding dropdown for stroke width. Bindings can only be authored via blueprint syntax (`st[(#000,w($stroke.width.md))]`) or programmatically.
- Stroke widths bound to a token do not re-resolve at runtime. The stroke keeps the value captured when the binding was created. Color, spacing, radius, font size, line height, and opacity tokens DO re-resolve on mode switch.

## Font Size Token Scale

Default base = 16. Multipliers: `xs` (0.75×), `sm` (0.875×), `md` (1×), `lg` (1.25×), `xl` (1.5×), `2xl` (2×).

| Token | Multiplier | Default Value | Usage |
|-------|-----------|--------------|-------|
| `font.size.xs` | 0.75 | 12 | Fine print, captions |
| `font.size.sm` | 0.875 | 14 | Secondary text |
| `font.size.md` | 1.0 | 16 | Body text |
| `font.size.lg` | 1.25 | 20 | Subheadings |
| `font.size.xl` | 1.5 | 24 | Headings |
| `font.size.2xl` | 2.0 | 32 | Display text |

## Font Weight Token Scale

| Token | Value | CSS Equivalent |
|-------|-------|----------------|
| `font.weight.thin` | 100 | Thin |
| `font.weight.extralight` | 200 | Extra Light |
| `font.weight.light` | 300 | Light |
| `font.weight.regular` | 400 | Regular |
| `font.weight.medium` | 500 | Medium |
| `font.weight.semibold` | 600 | Semi Bold |
| `font.weight.bold` | 700 | Bold |
| `font.weight.extrabold` | 800 | Extra Bold |
| `font.weight.black` | 900 | Black |

## Line Height Token Scale

| Token | Value | Usage |
|-------|-------|-------|
| `font.lineHeight.none` | 1.0 | Single line, icons |
| `font.lineHeight.tight` | 1.25 | Headings |
| `font.lineHeight.snug` | 1.375 | Compact body |
| `font.lineHeight.normal` | 1.5 | Body text |
| `font.lineHeight.relaxed` | 1.625 | Comfortable reading |
| `font.lineHeight.loose` | 2.0 | Double-spaced |

## Default Design System

Brilliant ships with built-in defaults (`defaultDesignSystemSeeds` in `lib/models/design_system.dart`) that apply when no `.styles` file exists or when seeds are not specified:

| Seed | Value | Description |
|------|-------|-------------|
| `brand` | `#6264A7` | Primary brand color (indigo) |
| `neutral` | `#64748B` | Cool slate gray; generates near-white to near-black scale |
| `success` | `#22C55E` | Success/positive actions (green) |
| `error` | `#EF4444` | Error/destructive actions (red) |
| `warning` | `#F59E0B` | Warning/caution (amber) |
| `info` | `#3B82F6` | Informational (blue) |
| `spacing` | `4` | Base spacing unit |
| `radius` | `4` | Base corner radius |
| `font.family` | `Inter` | Default font |
| `font.size` | `16` | Base font size |
| `font.weight` | `400` | Regular weight |
| `font.lineHeight` | `1.5` | Normal line height |
| `stroke.width` | `1` | Base stroke width |
| `opacity` | `1` | Base opacity (the seed; the materialized scale is 0.0–1.0) |

All 6 color seeds generate full 5–90 scales out of the box. Override any seed in your `.styles` file to customize.

## Creating a Design System

Brilliant automatically creates an empty root `.styles` file when you open a repository that doesn't have one. The built-in defaults (brand, neutral, success, etc.) are applied automatically during token resolution even without explicit seeds in the file -- you only need to add seeds when you want to customize them. You can also create or edit `.styles` files manually. The format is valid YAML -- hex colors must be quoted:

```yaml
# Seeds - generate full scales
brand: "#3B82F6"
neutral: "#64748B"
success: "#22C55E"
error: "#EF4444"
accent: "#8B5CF6"

# Spacing and radius base
spacing: 4
radius: 8

# Typography
font.family: "SF Pro Display"
font.size: 16
font.weight: 400
font.lineHeight: 1.5

# Claims - override specific generated values
brand.30: "#93C5FD"
font.size.md: 15
font.weight.bold: 800

# Custom tokens - semantic aliases
sidebar.bg: "#1E293B"
text.primary: brand.70
cta.color: accent.50
```

### Custom Modes and Mode Seeds

Brilliant provides `light` and `dark` modes by default. You can declare additional custom modes and define mode-specific color seeds directly in the `.styles` file.

**Declaring custom modes** with the `$modes` key:

```yaml
$modes: [tint, dim]
```

**Mode-specific color seeds** use list syntax: the first value is the base (light mode) seed, and subsequent entries are mode-keyed overrides:

```yaml
# Base seed + mode variants in one declaration
brand: ["#3B82F6", tint: "#8866CC", dim: "#444466"]
accent: ["#8B5CF6", tint: "#FF6347"]
```

This generates separate color scales for each mode. When you switch to the `tint` mode, `brand.50` resolves using the `#8866CC` seed instead of `#3B82F6`.

You can also add mode seeds via the **Add Mode Seed** command without editing the file directly.

### Seeds, Claims, and Custom Tokens

| Category | Purpose | Examples |
|----------|---------|----------|
| **Seeds** | Input values that generate entire scales | `brand: "#3B82F6"`, `spacing: 4` |
| **Claims** | Override a specific generated value | `brand.30: "#93C5FD"`, `font.weight.bold: 800` |
| **Custom** | Define new tokens (literal or reference) | `sidebar.bg: "#1E293B"`, `text.primary: brand.70` |

### Generated Output (.gen file)

Running generation creates a `.styles.gen` file with all resolved tokens, annotated by source:

```yaml
# GENERATED: DO NOT EDIT
# Regenerate: $ brilliant generate

# Brand colors
brand: "#3B82F6"  # seed
brand.5: "#EFF6FF"
brand.10: "#DBEAFE"
brand.30: "#93C5FD"  # claimed
brand.50: "#3B82F6"

# Accent colors
accent: "#8B5CF6"  # seed
accent.5: "#F5F3FF"
accent.50: "#8B5CF6"

# Typography
font.weight: 400  # seed
font.weight.bold: 800  # claimed
font.weight.regular: 400
font.lineHeight: 1.5  # seed
font.lineHeight.normal: 1.5
font.lineHeight.tight: 1.25

# Custom
sidebar.bg: "#1E293B"  # custom
text.primary: "{brand.70}"  # ref
cta.color: "{accent.50}"  # ref
```

Reference tokens use `{tokenName}` syntax (e.g., `"{brand.70}"`) to indicate they resolve to another token's value. Bare references (without braces) are also supported for backward compatibility.

The `.styles.gen` file is automatically added to `.gitignore`: it is a derived artifact and should not be committed.

## Opacity Token Scale

| Token | Value | Usage |
|-------|-------|-------|
| `opacity.0` | 0.0 | Fully transparent |
| `opacity.5` | 0.05 | Barely visible |
| `opacity.10` | 0.1 | Very faint |
| `opacity.20` | 0.2 | Subtle |
| `opacity.30` | 0.3 | Light |
| `opacity.40` | 0.4 | Medium-light |
| `opacity.50` | 0.5 | Half opacity |
| `opacity.60` | 0.6 | Medium |
| `opacity.70` | 0.7 | Moderate |
| `opacity.80` | 0.8 | Strong |
| `opacity.90` | 0.9 | Near opaque |
| `opacity.100` | 1.0 | Fully opaque |

## Cascading Behavior

Design systems cascade like `.editorconfig`:

1. **Built-in defaults** are always available as a base layer (`defaultDesignSystemSeeds` + `defaultDesignSystemTokens`)
2. **Root `.styles`** applies to the entire repository
3. **Subfolder `.styles`** overrides parent values for that folder

For each canvas, Brilliant walks from the canvas's directory up to the repo root, collecting `.styles` files root-first. Each file is generated independently into a `DesignSystem`, then merged with later (deeper) layers overriding earlier ones. Cross-layer token references (e.g., a subfolder token referencing a root token) resolve at runtime after merge with a max reference depth of 10.

If no root `.styles` file exists, an empty one is auto-created on app launch (`ensureRootDesignSystem()`). The `.styles.gen` artifact is always regenerated on launch and added to `.gitignore`.

## Designing with Tokens

When a `.styles` file exists in the repo, use its tokens in your designs for consistency:

### Color Tokens for UI Design

Use the generated color scale for consistent theming:

| UI Role | Token | Why |
|---------|-------|-----|
| Primary button | `brand.50` | Main brand color |
| Button hover | `brand.60` | One step darker |
| Light background | `brand.5` | Barely-there tint |
| Tag/badge fill | `brand.10` | Subtle brand tint |
| Border | `brand.30` | Soft brand-tinted border |
| Dark text on light | `brand.80` or `brand.90` | High contrast |
| Error states | `error.50` | Semantic red |
| Success states | `success.50` | Semantic green |
| Warning states | `warning.50` | Semantic yellow |
| Info states | `info.50` | Semantic blue |
| Neutral backgrounds | `neutral.5` or `neutral.10` | Subtle gray |
| Subtle text | `neutral.50` | Muted but readable |
| Borders/dividers | `neutral.20` | Light separator |

### Custom Color Seeds for Richer Palettes

Define multiple color seeds to create a richer design vocabulary:

```yaml
brand: "#3B82F6"      # Primary actions
accent: "#8B5CF6"     # Secondary highlights, tags
surface: "#F8FAFC"    # Background tints
```

Then use `accent.10` for tag backgrounds, `accent.50` for secondary CTAs, `surface.5` for page backgrounds, etc.

### Typography Tokens

| Use Case | Size Token | Weight Token |
|----------|-----------|--------------|
| Display / hero | `font.size.2xl` | `font.weight.bold` |
| Page heading | `font.size.xl` | `font.weight.semibold` |
| Section heading | `font.size.lg` | `font.weight.semibold` |
| Body text | `font.size.md` | `font.weight.regular` |
| Secondary text | `font.size.sm` | `font.weight.regular` |
| Caption / label | `font.size.xs` | `font.weight.medium` |

### Spacing Tokens

| Use Case | Token |
|----------|-------|
| No spacing | `spacing.none` (0px) |
| Tight inline spacing | `spacing.1` (4px) |
| Between form fields | `spacing.3` or `spacing.4` (12–16px) |
| Card padding | `spacing.4` or `spacing.6` (16–24px) |
| Section gaps | `spacing.8` or `spacing.12` (32–48px) |
| Hero padding | `spacing.16` (64px) |

## Editing .styles Files

Use the **Open Design System File** command (command palette) to open the nearest `.styles` file in the code editor with YAML syntax highlighting. Files starting with `.` (including `.styles`) are hidden in the file explorer and command palette file search by default -- use the Open Design System File command for direct access.

You can also modify the design system programmatically using commands (via command palette, keybindings, MCP, or AI natural language).

## Design System Commands

### Color Seed Commands

| Command | Description | Example |
|---------|-------------|---------|
| **Set Color Seed** | Add or update a color seed | Set `brand` to `#3B82F6` |
| **Remove Color Seed** | Remove a color seed and its mode variants (programmatic only) | Remove the `accent` seed |
| **Add Mode Seed** | Add a mode-specific variant for a color seed (programmatic only) | Add `tint` mode for `brand` with `#8866CC` |
| **Remove Mode Seed** | Remove a specific mode variant (programmatic only) | Remove `tint` mode from `brand` |

### Numeric Seed Commands

| Command | Description | Supported Operations |
|---------|-------------|---------------------|
| **Set Spacing Base** | Change base spacing value | Set, add, subtract, multiply |
| **Set Radius Base** | Change base corner radius | Set, add, subtract, multiply |
| **Set Font Size Base** | Change base font size | Set, add, subtract, multiply |
| **Set Font Weight Base** | Change base font weight | Set, add, subtract, multiply |
| **Set Line Height Base** | Change base line height | Set, add, subtract, multiply |

Numeric seeds support relative operations: "add 2 to spacing" increases the base by 2, "multiply font size by 1.5" scales it up.

**Note:** Stroke width base and opacity base do not have dedicated set commands. To change these seeds, edit the `.styles` file directly (e.g., `stroke.width: 2` or `opacity: 0.5`), or use the AI to call **Set Token Value** with the seed key.

### Other Seed Commands

| Command | Description |
|---------|-------------|
| **Set Font Family** | Change the default font family (e.g., `Inter`, `SF Pro Display`) |

### Token Commands

These commands are programmatic only (not visible in the command palette). They are used by AI agents and MCP tools to modify tokens.

| Command | Description |
|---------|-------------|
| **Set Token Value** | Add or update a custom token (e.g., `sidebar.bg: "#1E293B"`) |
| **Remove Token** | Remove a custom token |
| **Set Mode Token** | Set a mode-specific value for a token (e.g., `sidebar.bg` dark mode value) |

### Utility Commands

| Command | Description |
|---------|-------------|
| **Switch Design Mode** | Dropdown command in the command palette. Hover a mode to preview it on the canvas; click to commit. Closing the dropdown cancels the preview and restores the previous mode. Available modes are `light`, `dark`, plus any custom modes declared in `.styles`. There is no default keybinding. |
| **Regenerate Design System** | Rebuild all `.styles.gen` files from source |
| **Reset Design System** | Reset to built-in defaults (rewrites the `.styles` file to defaults; undoable) |
| **Open Design System File** | Open the nearest `.styles` file in the code editor (YAML syntax highlighting) |

### Composite Token Commands

| Command | Description | Example |
|---------|-------------|---------|
| **Apply Typography Token** | Apply a typography composite to selected text elements | Apply `typography.h1` to set font size, weight, line height, family at once |
| **Apply Shadow Token** | Apply a shadow composite to selected elements | Apply `shadow.md` to add drop shadow effects |

**Typography token application:**
- Sets `fontSize`, `fontWeight`, `fontFamily`, `lineHeight`, `letterSpacing` according to the resolved composite (any field unset on the token leaves the existing value alone, except `lineHeight` which is cleared if the token does not specify it).
- Stores the token key in `textData.typographyTokenRef`.
- Clears all individual font token refs (`fontSizeTokenRef`, `fontWeightTokenRef`, `lineHeightTokenRef`, `fontFamilyTokenRef`) so the composite is the single source of truth.
- Changing the font family via the font selector clears `typographyTokenRef`. Other manual edits in the inspector may not auto-clear it; check the inspector for the active token chip.

**Shadow token application:**
- Replaces only the element's existing **drop shadow** effects with the token's shadow layers. Inner shadows, glows, and blur effects are preserved.
- Stores the token key in `element.shadowTokenRef`.

All mutation commands (set/remove/add/apply) support undo/redo: press **Cmd+Z** to revert any change.

## Built-in Typography Tokens

These typography composites are available by default (defined as `builtin` source in `defaultDesignSystemTokens`). The fontFamily field is unset (null) for all tokens except `typography.code`, so they inherit the active `font.family` seed when applied.

| Token | Weight | Size | Line Height | Font Family |
|-------|--------|------|-------------|-------------|
| `typography.h1` | Bold (700) | 36 | 1.2 | inherits |
| `typography.h2` | Bold (700) | 30 | 1.25 | inherits |
| `typography.h3` | SemiBold (600) | 24 | 1.3 | inherits |
| `typography.h4` | SemiBold (600) | 20 | 1.35 | inherits |
| `typography.h5` | SemiBold (600) | 18 | 1.4 | inherits |
| `typography.h6` | SemiBold (600) | 16 | 1.4 | inherits |
| `typography.body.sm` | Regular (400) | 14 | 1.5 | inherits |
| `typography.body.md` | Regular (400) | 16 | 1.5 | inherits |
| `typography.body.lg` | Regular (400) | 18 | 1.5 | inherits |
| `typography.caption` | Regular (400) | 12 | 1.4 | inherits |
| `typography.label` | Medium (500) | 14 | 1.4 | inherits |
| `typography.code` | Regular (400) | 14 | 1.5 | `monospace` |

None of the built-in typography tokens set `letterSpacing`. Custom typography tokens defined in `.styles` files can include `letterSpacing`.

## Built-in Shadow Tokens

Shadows are composite tokens; each is a list of `ShadowLayer` (x, y, blur, spread, color).

| Token | Layers |
|-------|--------|
| `shadow.sm` | 1 layer: y:1, blur:2, color:rgba(0,0,0,0.05) |
| `shadow.md` | 2 layers: (y:2, blur:4, spread:-1, rgba(0,0,0,0.06)) + (y:4, blur:6, spread:-1, rgba(0,0,0,0.1)) |
| `shadow.lg` | 2 layers: (y:4, blur:6, spread:-2, rgba(0,0,0,0.05)) + (y:10, blur:15, spread:-3, rgba(0,0,0,0.1)) |
| `shadow.xl` | 2 layers: (y:10, blur:10, spread:-5, rgba(0,0,0,0.04)) + (y:20, blur:25, spread:-5, rgba(0,0,0,0.1)) |

**Application semantics (`Apply Shadow Token`):** Replaces only existing **drop shadow** effects on the element. Other effects (inner shadow, glows, blur) are preserved. The token reference is stored in `element.shadowTokenRef` for tracking. Manually adding or removing a drop shadow effect does NOT auto-clear `shadowTokenRef`.

## Built-in Semantic Color Aliases

| Token | Resolves To | Usage |
|-------|------------|-------|
| `color.surface` | `neutral.5` | Page backgrounds |
| `color.on-surface` | `neutral.90` | Text on surfaces |
| `color.surface.container` | `neutral.10` | Card/container backgrounds |
| `color.outline` | `neutral.50` | Primary borders |
| `color.outline.variant` | `neutral.30` | Subtle borders |

These aliases are themed: in dark mode they automatically resolve to the inverted scale (so `color.surface` becomes a near-black background and `color.on-surface` becomes near-white text).

## What's Not Supported

The following features are NOT currently in Brilliant's design system:

- **Variables panel / token editor UI.** Tokens, seeds, and modes are authored in the `.styles` file (open via **Open Design System File**) or via AI/MCP commands. There is no in-app form to create, rename, or delete a token from the UI.
- **Token export to CSS variables, Tailwind config, or design tokens JSON.** Tokens stay inside the `.styles` / `.styles.gen` pair; there is no built-in exporter.
- **Token search UI / favorites / recents.** The color picker shows all tokens grouped by category; other token dropdowns are flat lists.
- **Numeric tokens with units.** Numbers are stored as plain doubles (no px/rem/em/% unit system).
- **Keyboard shortcut to switch modes.** No design system command has a default keybinding. Use the **Switch Design Mode** command in the command palette.
- **Stroke width inspector binding.** No dropdown UI; bindings can only be authored via blueprint or programmatically.
- **Stroke width re-resolution at runtime.** Bound stroke widths do not update on mode change.
- **Letter spacing as a built-in scale.** There is no `letterSpacing.*` token type. Letter spacing can be set inside a custom `typography.*` composite.
- **Font family inspector binding.** The font picker sets `fontFamily` as a literal; bind via a typography composite or blueprint.
- **In-app rename / delete buttons for tokens.** Edit the `.styles` file directly, or use the (programmatic-only) **Set Token Value** / **Remove Token** commands.
- **Per-token override badges.** Tokens applied to element properties show as token names in the inspector, but there is no separate "is overridden" indicator beyond the token chip itself.
