---
assumes: blueprint/paint
---
# Design Colors

For color syntax, see `blueprint/paint`. For DS architecture and the
"design system IS the design" principle, see `design-systems/core`.

## 60-30-10 Rule

60% dominant (backgrounds `$color.surface` / `$color.surface.container`) · 30% secondary (text `$color.text.{primary,secondary}`, borders `$color.outline.variant`) · 10% accent (CTAs `$color.primary`, callouts `$color.secondary`). Most common mistake: accent on 30%+ of surface. One accent CTA is confident — accent on navbar, headers, AND badges is noisy.

## Neutrals

Slate (cool, blue-tinted) · Stone (warm, yellow-tinted) · Zinc (true neutral) · Gray is the lifeless default — skip it. **Body text should never be pure black (#000) or pure gray (#333/#666)** — tint it to match your neutral family.

## Dark Mode

**Switch the DS — don't hand-roll.** The fastest, most cohesive path to dark is `ds(, theme(dark))` (or `ds(name, theme(dark))` for both brand + mode) on the top-level frame, then build with semantic aliases. `$color.surface`, `$color.text.{primary,secondary}`, `$color.outline.variant`, `$color.primary`, `$color.secondary` all auto-flip via the `theme.dark` block in the active DS — the same blueprint renders both modes without per-element rewrites.

Role tokens (`$neutral.hint`, `$neutral.intense`, `$primary.soft`, etc.) are also mode-aware: under `theme.dark`, low↔high flip automatically (`hint↔intense`, `faint↔strong`, `subtle↔bold`, `soft↔firm`; `mid` stays). So `$neutral.hint` is a near-white wash in light and a near-black wash in dark. For chrome (surfaces, body text, borders), prefer semantic aliases (`$color.surface`, `$color.text.primary`, `$color.outline.variant`) because they carry intent; reach for role tokens (`$primary.soft`, `$emerald.bold`) for accents that need a specific presence level. Raw numeric stops (`$neutral.500`, `$primary.700`) halt in explicit mode — reach for chrome aliases (`$color.shadow`, `$color.glow`) for mode-immune values or role names for mode-aware ones. To dark-theme a single frame inside a light app, wrap it: `ds(, theme(dark)) f[($color.surface)] ...` — the nested cascade re-resolves both semantics and role tokens for that subtree. Never #000 bg (void), never #FFF text (eye strain). Reduce accent saturation on dark. Shadows invisible — surface color does the work.

## Interactive states

Items that respond to a cursor — sidebar rows, menu items, list rows, selectable cards — pick from these surface tokens instead of hand-picking neutral stops. They assume the item sits on `$color.surface`; for items on a deeper container, step one boldness role darker.

- `$color.surface.hover` (neutral.faint) — "cursor is here" feedback.
- `$color.surface.pressed` (neutral.subtle) — the moment of click, slightly deeper.
- `$color.surface.selected` (primary.subtle) + `$color.on-surface.selected` (primary.bold) — the current row in a nav/menu/list. Brand-tinted bg plus brand-tinted icon and bold label.
- Disabled — leave the surface at rest and mute the label + icon with `$color.text.disabled`. No dedicated surface token; the muted foreground does the work.

For primary/secondary buttons, hover and pressed are usually expressed through shadow + brand-fill shifts rather than surface tokens — see `design/blocks/actions`.

## Data Viz Colors

**Semantic status:** `$color.success` = good, `$color.error` = bad, `$color.warning` = warning, `$color.info` = neutral. These auto-flip with mode — reach for them whenever the chart's color carries semantic meaning.

**Chart series (max 6):** `$blue.mid` `$emerald.mid` `$amber.mid` `$violet.mid` `$rose.mid` `$cyan.mid` (palette stops picked for distinguishability — categorical data viz wants distinct hues, not roles).

## Contrast (WCAG AA)

Normal text (<18px): 4.5:1 · Large text (18px+ bold): 3:1 · `#10B981` (`$emerald.mid`) on white fails for small text — use `#059669` (`$emerald.firm`). Reduced opacity is useful for hierarchy but text must remain readable at a glance.
