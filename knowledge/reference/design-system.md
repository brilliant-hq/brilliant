---
name: "knowledge-design-system"
description: "Design tokens and design system usage in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Design System

Brilliant supports design tokens through `.styles` files. Tokens let you define colors, spacing, typography, and more once, then reference them throughout your designs. Changes to tokens automatically update all elements using them.

## What Are Design Tokens?

Design tokens are named values that represent design decisions. Instead of hardcoding `#6264A7`, you use `brand.50`. Benefits:

- **Consistency** — One source of truth for your design system
- **Maintainability** — Change the token, update everywhere
- **Semantic naming** — `brand.50` is more meaningful than a hex code
- **Scale generation** — Define one brand color, get a full 5–90 scale

## Using Tokens in the Color Picker

1. Open the color picker (click any color swatch or press **Ctrl+C**)
2. Scroll to the **Design Tokens** section
3. Tokens are grouped by category (brand, neutral, success, accent, etc.)
4. Click a token swatch to apply it

Token-bound color swatches show a subtle blue-purple border to indicate they're linked to a token.

## Using Tokens in Blueprints

Reference tokens with the `$` prefix in blueprint syntax. Tokens work in fills, strokes, gap, padding, and corner radius:

```
# Color tokens in fills and strokes
Card frame auto-v w:320 h:hug fill:$brand.50 stroke:$neutral.30/1 r:12 gap:16 pad:24
  Title text "Card Title" font:Inter/20/bold fill:$brand.90 w:fill h:hug

# Spacing tokens in gap and padding
Section frame auto-v w:fill h:hug gap:$spacing.4 pad:$spacing.6
  Heading text "Features" font:Inter/24/bold fill:$brand.80 w:fill h:hug

# Radius tokens
Button frame auto-h w:hug h:48 fill:$brand.50 r:$radius.md pad:12,16
  Label text "Get Started" font:Inter/14/semibold fill:#FFFFFF

# Font family from design system (omit family name to use DS default)
Body text "Description" font:/14 fill:$neutral.50 w:fill h:hug
```

Token references resolve at creation time using the active design system. If a token doesn't exist, the property is skipped and the default value is used.

## Token Types

| Type | Key Pattern | Examples | Description |
|------|-------------|----------|-------------|
| **Color** | `{name}.{step}` | `brand.50`, `neutral.30`, `accent.10` | Full color scales from any color seed |
| **Spacing** | `spacing.{n}` | `spacing.none`, `spacing.1`, `spacing.4`, `spacing.8` | Base × multiplier spacing values (none = 0) |
| **Radius** | `radius.{step}` | `radius.sm`, `radius.md`, `radius.lg` | Corner radius presets |
| **Font Size** | `font.size.{step}` | `font.size.sm`, `font.size.lg`, `font.size.2xl` | Typography scale |
| **Font Family** | `font.family` | `font.family` | Defined font family |
| **Font Weight** | `font.weight.{step}` | `font.weight.bold`, `font.weight.semibold` | Weight scale from thin (100) to black (900) |
| **Line Height** | `font.lineHeight.{step}` | `font.lineHeight.tight`, `font.lineHeight.normal` | Line height multipliers |
| **Opacity** | `opacity.{step}` | `opacity.0`, `opacity.50`, `opacity.100` | Opacity values (0.0–1.0), full 0–100 scale |
| **Typography** | `typography.{name}` | `typography.h1`, `typography.body.md` | Composite: font size + weight + line height + family |
| **Stroke Width** | `stroke.width.{step}` | `stroke.width.sm`, `stroke.width.lg` | Stroke thickness presets |
| **Shadow** | `shadow.{step}` | `shadow.sm`, `shadow.md`, `shadow.lg` | Composite: one or more shadow layers |
| **Boolean** | (custom) | (custom keys) | True/false values for custom tokens |

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

**Dark mode inversion:** In dark mode, color steps are mirrored — `.5` (lightest) uses the light mode `.90` value, `.10` uses `.80`, etc. The bare seed alias (e.g., `brand` without a step number) resolves to the `.40` step from the light scale in dark mode, not the original seed color. This ensures light backgrounds become dark and vice versa while maintaining the same semantic usage of token names.

**Custom color seeds:** Any name works. Add `accent: "#FF6347"` to get `accent.5` through `accent.90`.

## Spacing Token Scale

Spacing tokens use a configurable base (default 4px) with multipliers:

| Token | Default Value | Usage |
|-------|---------------|-------|
| `spacing.none` | 0px | No spacing |
| `spacing.1` | 4px | Tight spacing |
| `spacing.2` | 8px | Small gaps |
| `spacing.3` | 12px | Default spacing |
| `spacing.4` | 16px | Section spacing |
| `spacing.6` | 24px | Large gaps |
| `spacing.8` | 32px | Section breaks |
| `spacing.12` | 48px | Major sections |
| `spacing.16` | 64px | Hero spacing |

## Radius Token Scale

| Token | Default Value | Usage |
|-------|---------------|-------|
| `radius.none` | 0px | Sharp corners |
| `radius.sm` | 4px | Subtle rounding |
| `radius.md` | 8px | Default (cards, buttons) |
| `radius.lg` | 16px | Prominent rounding |
| `radius.xl` | 24px | Large containers |
| `radius.full` | 9999px | Fully rounded (pills, circles) |

## Stroke Width Token Scale

| Token | Default Value | Usage |
|-------|---------------|-------|
| `stroke.width.none` | 0px | No stroke |
| `stroke.width.hairline` | 0.5px | Hairline stroke |
| `stroke.width.sm` | 1px | Thin stroke |
| `stroke.width.md` | 2px | Default stroke |
| `stroke.width.lg` | 4px | Thick stroke |
| `stroke.width.xl` | 8px | Heavy stroke |

## Font Size Token Scale

| Token | Default Value | Usage |
|-------|---------------|-------|
| `font.size.xs` | 12px | Fine print, captions |
| `font.size.sm` | 14px | Secondary text |
| `font.size.md` | 16px | Body text |
| `font.size.lg` | 20px | Subheadings |
| `font.size.xl` | 24px | Headings |
| `font.size.2xl` | 32px | Display text |

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

Brilliant ships with built-in defaults that apply when no `.styles` file exists:

| Seed | Value | Description |
|------|-------|-------------|
| `brand` | "#6264A7" | Primary brand color (indigo) |
| `neutral` | "#64748B" | Tinted gray (cool slate) — generates near-white to near-black scale |
| `success` | "#22C55E" | Success/positive actions (green) |
| `error` | "#EF4444" | Error/destructive actions (red) |
| `warning` | "#F59E0B" | Warning/caution (amber) |
| `info` | "#3B82F6" | Informational (blue) |
| `spacing` | 4 | 4px base |
| `radius` | 4 | 4px base |
| `font.family` | Inter | Default font |
| `font.size` | 16 | 16px base |
| `font.weight` | 400 | Regular weight |
| `font.lineHeight` | 1.5 | Normal line height |
| `stroke.width` | 1 | 1px base |
| `opacity` | 1 | Default opacity |

All 6 color seeds generate full 5–90 scales out of the box. Override any seed in your `.styles` file to customize.

## Creating a Design System

Brilliant automatically creates a root `.styles` file with default seeds when you open a repository that doesn't have one. You can also create or edit `.styles` files manually. The format is valid YAML — hex colors must be quoted:

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

**Mode-specific color seeds** use list syntax — the first value is the base (light mode) seed, and subsequent entries are mode-keyed overrides:

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
# GENERATED — DO NOT EDIT
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

The `.styles.gen` file is automatically added to `.gitignore` — it is a derived artifact and should not be committed.

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

1. **Root `.styles`** applies to entire repository
2. **Subfolder `.styles`** overrides parent values for that folder
3. **Built-in defaults** apply when no file exists

This lets you have different color schemes per project folder while sharing common tokens.

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

`.styles` and `.styles.gen` files appear in the command palette file search and open with YAML syntax highlighting in the code editor.

You can also modify the design system programmatically using commands (via command palette, keybindings, MCP, or AI natural language).

## Design System Commands

### Color Seed Commands

| Command | Description | Example |
|---------|-------------|---------|
| **Set Color Seed** | Add or update a color seed | Set `brand` to `#3B82F6` |
| **Remove Color Seed** | Remove a color seed and its mode variants | Remove the `accent` seed |
| **Add Mode Seed** | Add a mode-specific variant for a color seed | Add `tint` mode for `brand` with `#8866CC` |
| **Remove Mode Seed** | Remove a specific mode variant | Remove `tint` mode from `brand` |

### Numeric Seed Commands

| Command | Description | Supported Operations |
|---------|-------------|---------------------|
| **Set Spacing Base** | Change base spacing value | Set, add, subtract, multiply |
| **Set Radius Base** | Change base corner radius | Set, add, subtract, multiply |
| **Set Font Size Base** | Change base font size | Set, add, subtract, multiply |
| **Set Font Weight Base** | Change base font weight | Set, add, subtract, multiply |
| **Set Line Height Base** | Change base line height | Set, add, subtract, multiply |

Numeric seeds support relative operations: "add 2 to spacing" increases the base by 2, "multiply font size by 1.5" scales it up.

### Other Seed Commands

| Command | Description |
|---------|-------------|
| **Set Font Family** | Change the default font family (e.g., `Inter`, `SF Pro Display`) |

### Token Commands

| Command | Description |
|---------|-------------|
| **Set Token Value** | Add or update a custom token (e.g., `sidebar.bg: "#1E293B"`) |
| **Remove Token** | Remove a custom token |
| **Set Mode Token** | Set a mode-specific value for a token (e.g., `sidebar.bg` dark mode value) |

### Utility Commands

| Command | Description |
|---------|-------------|
| **Switch Design Mode** | Switch between light, dark, and custom modes |
| **Regenerate Design System** | Rebuild all `.styles.gen` files from source |
| **Reset Design System** | Reset to built-in defaults (removes all custom seeds and tokens) |
| **Open Design System File** | Open the nearest `.styles` file in the code editor |

### Composite Token Commands

| Command | Description | Example |
|---------|-------------|---------|
| **Apply Typography Token** | Apply a typography composite to selected text elements | Apply `typography.h1` to set font size, weight, line height at once |
| **Apply Shadow Token** | Apply a shadow composite to selected elements | Apply `shadow.md` to add drop shadow effects |

Typography tokens set font size, weight, family, line height, and optionally letter spacing in one operation. Manually changing any individual property (e.g., font size) clears the typography token link.

Shadow tokens replace existing drop shadows with the token's shadow layers. Manually adding or modifying effects clears the shadow token link.

All mutation commands (set/remove/add/apply) support undo/redo — press **Cmd+Z** to revert any change.

## Built-in Typography Tokens

These typography composites are available by default (no `.styles` file needed):

| Token | Weight | Size | Line Height | Font |
|-------|--------|------|-------------|------|
| `typography.h1` | Bold (700) | 36px | 1.2 | Default |
| `typography.h2` | Bold (700) | 30px | 1.25 | Default |
| `typography.h3` | SemiBold (600) | 24px | 1.3 | Default |
| `typography.h4` | SemiBold (600) | 20px | 1.35 | Default |
| `typography.h5` | SemiBold (600) | 18px | 1.4 | Default |
| `typography.h6` | SemiBold (600) | 16px | 1.4 | Default |
| `typography.body.sm` | Regular (400) | 14px | 1.5 | Default |
| `typography.body.md` | Regular (400) | 16px | 1.5 | Default |
| `typography.body.lg` | Regular (400) | 18px | 1.5 | Default |
| `typography.caption` | Regular (400) | 12px | 1.4 | Default |
| `typography.label` | Medium (500) | 14px | 1.4 | Default |
| `typography.code` | Regular (400) | 14px | 1.5 | Monospace |

## Built-in Shadow Tokens

| Token | Description |
|-------|-------------|
| `shadow.sm` | Subtle shadow (y:1, blur:2) |
| `shadow.md` | Medium shadow (two layers: y:2+y:4) |
| `shadow.lg` | Large shadow (two layers: y:4+y:10) |
| `shadow.xl` | Extra large shadow (two layers: y:10+y:20) |

## Built-in Semantic Color Aliases

| Token | Resolves To | Usage |
|-------|------------|-------|
| `color.surface` | `neutral.5` | Page backgrounds |
| `color.on-surface` | `neutral.90` | Text on surfaces |
| `color.surface.container` | `neutral.10` | Card/container backgrounds |
| `color.outline` | `neutral.50` | Primary borders |
| `color.outline.variant` | `neutral.30` | Subtle borders |
