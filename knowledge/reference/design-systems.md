---
name: "knowledge-design-systems"
description: "Design tokens in Brilliant: what they are, how to bind, switch brands/modes, and operate the design-system inspector by hand."
---

# Design Systems

Brilliant projects carry a design system: a named set of tokens (colors, spacing, radius, typography, shadows, stroke widths, opacity, font settings) that elements reference instead of hardcoding values. Change a token and every element bound to it updates. Switch a brand or a mode and the whole canvas re-resolves.

This file is the product reference: what the feature does, where the controls live, and how a user operates it by hand. The token authoring grammar (the `.styles` DSL) is not covered here. For authoring or editing a design system's tokens, see the `design-systems/*` knowledge files. For referencing tokens in blueprint markup, see the `blueprint/*` knowledge files.

## Core Concepts

- **Tokens** are named design values. An element stores a token *reference* (e.g. `color.primary`), never the resolved value. The renderer resolves the reference at paint time, so editing the system or switching modes ripples through every binding.
- **Brands** are named variants of the system (e.g. `corporate-blue`, `fintech-warm`) that override the project baseline. The baseline is always called `default`.
- **Modes** are axes the system declares (commonly `theme` with `light`/`dark`, `density` with `comfortable`/`compact`, `accessibility` with `standard`/`high-contrast`/`large-text`). The first value of each axis is the default. Switching a mode re-resolves mode-aware tokens.
- **Composite tokens** bundle multiple values: typography tokens (`typography.h1`, `typography.body.md`) carry font size + weight + line height + family; shadow tokens (`shadow.md`) carry one or more shadow layers.

## Where the System Lives

A project's design system is stored as files in a `Styles/` folder at the repo root (`Styles/default.styles` is the baseline, plus optional brand files like `Styles/corporate-blue.styles`). The user does not need to touch these to *use* tokens; they only matter when authoring or editing the system. Sub-folders can carry their own `Styles/default.styles` that overrides the parent for canvases in that folder.

To open the source file for editing, run the **Open Design System File** command (command palette). It opens the nearest `.styles` file in the built-in code editor.

## The Design System Inspector Section

The **right toolbar** has a **Design system** section pinned at its top (always visible when a canvas is loaded). It reports and controls the active brand and modes for the current scope.

Layout: the brand dropdown and the first mode axis sit on the first row; remaining axes wrap two per row. To the right of the row are two icon buttons. When there is anything to reset at the current scope, **Reset design system** (counter-clockwise arrow icon) appears first, followed by **Create Design System Viewer** (paint-palette icon) as the trailing button.

### Scope

The section's subtitle tells you what scope you are editing:

- **Nothing selected** ("this canvas"): the dropdowns set a **canvas-level** override stored on the canvas. It applies only to the current canvas; other canvases in the same folder are unaffected. When no canvas override exists, the canvas inherits the folder's default brand/modes.
- **One element selected** ("1 selected"): the dropdowns set the brand/modes **on that element**. The element's subtree re-resolves against it. Inherited values are shown dimmed with an "Inherited from..." tooltip.
- **Multiple selected**: shows the shared value if all agree, or a "Mixed" placeholder otherwise.

A dimmed field with an "Inherited from..." tooltip means the value is not pinned at this scope: it comes from a parent frame, the canvas, the folder default, or the system default. Picking a value pins it; picking **Inherit** clears the pin and lets the cascade resolve from above.

### Switching brand

The brand dropdown lists **Inherit** (clears the scope's override), **default** (pins to the project baseline), then each brand file found in `Styles/`. Hovering an option previews it live on the canvas without committing; clicking commits. The change is undoable (Cmd+Z).

### Switching modes

Each axis the active system declares gets its own dropdown (theme, density, accessibility, or any custom axis the system author defined). Options are **Inherit** plus that axis's declared values. Hover previews, click commits, Cmd+Z undoes. There is no default keyboard shortcut for switching modes, and no command-palette entry: the inspector axis dropdowns are the only way to change a mode.

### Reset and Viewer buttons

- **Reset design system**: clears every brand/mode override at the current scope (canvas-level if nothing is selected, or on each selected element). It only appears when there is something to reset, and disappears after the click. Undoable.
- **Create Design System Viewer**: inserts an 800x600 viewer element on the canvas that visualizes the active system's color seeds, scales, and typography composites. Useful as a living swatch sheet.

## Binding Tokens to Properties

Most numeric and color properties in the inspector accept a token binding. When a property is bound, its field shows the token name instead of a raw value. Manually typing a value into a bound field clears the binding for that property.

Where you bind in the UI:

| Property | Where in the inspector | Token type |
|----------|------------------------|------------|
| Fill / stroke color | Color picker, "Design tokens" section in the lower part of the picker | Color tokens |
| Fill / stroke opacity | Color picker token section | Opacity (visibility) tokens |
| Corner radius (per corner) | Right toolbar, radius fields | Radius tokens |
| Element opacity | Right toolbar, opacity field | Opacity tokens |
| Font size, weight, line height | Right toolbar, typography fields | Font tokens |
| Font family | Right toolbar, font picker | Font family token |
| Auto layout gap and padding | Right toolbar, auto layout fields | Spacing tokens |
| Stroke width | Right toolbar, stroke fields | Stroke width tokens |

The color picker's **Design tokens** section (in the lower part of the picker, above the canvas colors and recent colors) shows the system's color tokens as swatches, grouped. The swatches resolve through the canvas's active modes, so themed colors reflect the current theme. Token-bound colors work in every color slot: solid fills, gradient stops, shader colors, effect colors (drop shadow, outer glow, inner shadow, inner glow), image-filter colors (duotone, halftone), layout grid colors, and per-range text colors.

Composite tokens are applied via commands, not inline fields:

- **Apply Typography Token** (`apply_typography_token`): applies a `typography.*` composite to the selected text element(s).
- **Apply Shadow Token** (`apply_shadow_token`): applies a `shadow.*` composite to the selected element(s).

## Unbinding Tokens

The **Unbind Tokens** command (`unbind_tokens`) takes the current selection (and its descendants), replaces every token binding with the literal value it currently renders as, and drops the per-element design-system assignment. The result looks identical but no longer tracks the design system. Use it to "freeze" a subtree. Undoable.

## What Brilliant Can and Cannot Do

Can:
- Resolve color, spacing, radius, typography, shadow, stroke-width, opacity, and font tokens at paint time, so one source edit updates every binding.
- Define multiple brands and switch between them at canvas or element scope with live hover preview.
- Define multiple mode axes (theme, density, accessibility, plus arbitrary custom axes) and switch each independently.
- Bind tokens in every color slot and in numeric properties (radius, opacity, gap, padding, stroke width, font size/weight/line height/family).
- Apply composite typography and shadow tokens via commands.
- Visualize the system with the Design System Viewer element.
- Generate, on save, a `Styles/.gen/<name>.gen.yaml` artifact of fully resolved values for external tools (Style Dictionary, Tokens Studio, custom build scripts). These `.gen` files are git-ignored and must never be hand-edited.

Cannot:
- There is **no standalone variables / token editor panel**. Token authoring (new tokens, renames, deletes, scale tweaks, mode overrides) is done by editing the `.styles` source, not through inspector buttons. There are no in-app rename or delete buttons for tokens.
- There is **no default keyboard shortcut** for switching brand or mode; use the inspector dropdowns.
- There is **no export to CSS variables or Tailwind config** from the UI; external tools consume the `.gen.yaml` artifact.

## Design System Commands

Most are in the command palette under the design-system group. The two exceptions are **Set Design System** and **Set Design System Mode**: these do not appear in the palette and are driven only by the inspector dropdowns. Brand/mode/reset operations are undoable via the per-canvas undo stack (Cmd+Z).

| Command (display name) | Command ID | Purpose |
|---|---|---|
| Set Design System | `set_design_system` | Brand setter for the current scope (not in the palette; driven only by the inspector brand dropdown) |
| Set Design System Mode | `set_design_system_mode` | Per-axis mode setter (not in the palette; driven only by the inspector axis dropdowns) |
| Apply Typography Token | `apply_typography_token` | Apply a `typography.*` composite to selected text element(s) |
| Apply Shadow Token | `apply_shadow_token` | Apply a `shadow.*` composite to selected element(s) |
| Unbind Tokens | `unbind_tokens` | Replace all token bindings on the selection with literal values and drop the binding |
| Create Design System Viewer | `create_design_system_viewer` | Insert an 800x600 viewer element visualizing the active system |
| Open Design System File | `open_design_system_file` | Open the nearest `.styles` source in the code editor |
| Regenerate Design System | `regenerate_design_system` | Rebuild all `.gen.yaml` files from their `.styles` sources |
| Reset Design System | `reset_design_system` | Wipe the design system source to an empty default, discarding all authored tokens (undoable) |

Note: `reset_design_system` wipes the *source file* to an empty default, discarding every authored token (it does not restore Brilliant's seed tokens). The **Reset design system** button in the inspector is a different action: it clears brand/mode overrides at the inspected scope without touching the source.

## Related Knowledge

- Authoring or editing the system's tokens (the `.styles` DSL, brands, modes, composites): `design-systems/core`, `design-systems/authoring`, `design-systems/authoring-modes`.
- Referencing tokens in blueprint markup: `blueprint/core` and the other `blueprint/*` files.
- Colors, fills, strokes, opacity, corner radius in the UI: `reference/styling`.
- Effects (shadows, glows, blurs): `reference/effects`.
- Components and instances: `reference/components`.
