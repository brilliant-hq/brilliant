---
name: "knowledge-design-systems"
description: "Design tokens in Brilliant: what they are, how to bind, switch brands/modes, and operate the design-system inspector by hand."
---

# Design Systems

Brilliant projects carry a design system: a named set of tokens (colors, spacing, radius, typography, shadows, stroke widths, opacity, font settings) that elements reference instead of hardcoding values. Change a token and every element bound to it updates. Switch a brand or a mode and the whole canvas re-resolves.

This file is the product reference: what the feature does, where the controls live, and how a user operates it by hand. The token authoring grammar (the `.ds` DSL) is not covered here. For authoring or editing a design system's tokens, see the `design-systems/*` knowledge files. For referencing tokens in blueprint markup, see the `blueprint/*` knowledge files.

## Core Concepts

- **Tokens** are named design values. An element stores a token *reference* (e.g. `color.primary`), never the resolved value. The renderer resolves the reference at paint time, so editing the system or switching modes ripples through every binding.
- **Brands** are named variants of the system (e.g. `corporate-blue`, `fintech-warm`) that override the project baseline. The baseline is always called `default`.
- **Modes** are axes the system declares (commonly `theme` with `light`/`dark`, `density` with `comfortable`/`compact`, `accessibility` with `standard`/`high-contrast`/`large-text`). The first value of each axis is the default. Switching a mode re-resolves mode-aware tokens.
- **Composite tokens** bundle multiple values: typography tokens (`typography.h1`, `typography.body.md`) carry font size + weight + line height + family; shadow tokens (`shadow.md`) carry one or more shadow layers.

## Where the System Lives

A project's design system is stored as files in a `Styles/` folder at the repo root (`Styles/default.ds` is the baseline, plus optional brand files like `Styles/corporate-blue.ds`). The user does not need to touch these to *use* tokens; they only matter when authoring or editing the system. Sub-folders can carry their own `Styles/default.ds` that overrides the parent for canvases in that folder.

To open the source file for editing, run the **Open Design System File** command (command palette). It opens the nearest `.ds` file in the built-in code editor.

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

If the project depends on any **libraries**, their design systems appear in the same dropdown named by the library's handle: `@acme/design-kit` is that library's default look, `@acme/design-kit/marketing` one of its named brands. A library brand always resolves against the library's own tokens, so a library update re-themes everywhere it is used. See `reference/libraries`.

### Switching modes

Each axis the active system declares gets its own dropdown (theme, density, accessibility, or any custom axis the system author defined). Options are **Inherit** plus that axis's declared values. Hover previews, click commits, Cmd+Z undoes. There is no default keyboard shortcut for switching modes, and no command-palette entry: the inspector axis dropdowns are the only way to change a mode.

#### Pinned-brand modes on a selection

When you select elements that carry a design system pinned on the element itself (typically from a Figma import: a brand plus per-node mode overrides that never became the folder's active brand), that brand can declare mode axes the folder does not. Those axes now appear as an extra block below the normal axis rows, labeled with the brand's name and "pinned modes", with one dropdown per axis. Each shows the selection's current pinned value (or "Mixed" when the selected elements differ), and picking a value writes it as the pin on the selected elements while keeping their pinned brand. This is the only place those pinned modes are visible and switchable by hand; it appears only with an element selection, not when editing the whole canvas.

### Reset and Viewer buttons

- **Reset design system**: clears every brand/mode override at the current scope (canvas-level if nothing is selected, or on each selected element). It only appears when there is something to reset, and disappears after the click. Undoable.
- **Create Design System Viewer**: inserts an 800x600 viewer element on the canvas that visualizes the active system's color seeds, scales, and typography composites. Useful as a living swatch sheet.

## Binding Tokens to Properties

Most numeric and color properties in the inspector accept a token binding. When a property is bound, its field shows the token name instead of a raw value. Manually typing a value into a bound field clears the binding for that property.

To bind a numeric or font field (radius, opacity, gap/padding, stroke width, font size/weight/line height/family), open the field's dropdown (the chevron next to the value): the menu lists the matching token type alongside the plain preset values, and picking a token replaces the literal with the token name. Bound fields are marked with a purple chevron and diamond indicator (mirroring the color picker's "Design tokens" swatches for color fields).

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

- **Apply Typography Token**: applies a `typography.*` composite to the selected text element(s).
- **Apply Shadow Token**: applies a `shadow.*` composite to the selected element(s).

## Unbinding Tokens

The **Unbind Tokens** command takes the current selection (and its descendants), replaces every token binding with the literal value it currently renders as, and drops the per-element design-system assignment. The result looks identical but no longer tracks the design system. Use it to "freeze" a subtree. Undoable.

## Importing a Design System from Figma

Bringing a Figma file into Brilliant with the Brilliant Figma plugin (copy in Figma with the plugin, then paste into Brilliant with Cmd+V) carries the file's design system across as a real Brilliant system, not as flattened literal values. For the import mechanics (connecting Figma, plugin vs URL), see `reference/canvases`. What you get on the design-system side:

- **Every variable keeps its Figma name.** A variable named `brand/500` arrives as a token named `brand.500`; nothing is renamed away, so a search for the name you already know still finds it.
- **Each multi-mode collection becomes its own mode axis.** A collection with modes like Day and Night becomes an axis you can switch in the inspector, independently of every other collection. A collection whose modes are Light and Dark instead drives Brilliant's built-in theme toggle, so the light/dark switch just works on it. Single-mode collections come in as plain tokens.
- **Brilliant's role names are added on top, as aliases.** Where a Figma token clearly plays a standard role (a primary brand color, a surface, body text, an h1 type style), Brilliant adds its own role name (`color.primary`, `color.surface`, `typography.h1`, and friends) pointing at your token. Both names resolve, and because the role points at your token, switching brands or editing that token re-themes through the role.
- **Per-node mode overrides become per-element pins.** A node pinned to a specific collection mode in Figma (a dark strip inside a light page) imports pinned to that mode and stays that way across brand switches.
- **Gradient style stop colors become tokens.** A shared gradient paint style brings each of its stop colors across as its own color token, rebound to the matching gradient stops on the elements that used the style.

The import boundaries (what stays literal or on the element rather than becoming a token) are listed under Cannot below, and each such loss is named in the import warnings so nothing drops silently.

## What Brilliant Can and Cannot Do

Can:
- Resolve color, spacing, radius, typography, shadow, stroke-width, opacity, and font tokens at paint time, so one source edit updates every binding.
- Define multiple brands and switch between them at canvas or element scope with live hover preview.
- Define multiple mode axes (theme, density, accessibility, plus arbitrary custom axes) and switch each independently.
- Bind tokens in every color slot and in numeric properties (radius, opacity, gap, padding, stroke width, font size/weight/line height/family).
- Apply composite typography and shadow tokens via commands.
- Visualize the system with the Design System Viewer element.
- Import a Figma file's design system (via the Brilliant Figma plugin) as a real Brilliant system: variables keep their names, each multi-mode collection becomes a mode axis, a light/dark collection drives the theme toggle, standard roles are added as aliases, per-node mode overrides become per-element pins, and gradient-style stop colors become tokens (see "Importing a Design System from Figma" above).
- Generate, on save, a `Styles/.gen/<name>.gen.yaml` artifact of fully resolved values for external tools (Style Dictionary, Tokens Studio, custom build scripts). These `.gen` files are git-ignored and must never be hand-edited.
- Survive a `.ds` file with a syntax error: the design keeps rendering against the last version of that file that parsed, and a notification names the file and the first error (it stays until dismissed, and clears itself when the file parses again). While a file is broken, brand and mode switches on it are declined rather than rewriting the file over your unfinished edit. A deleted `.ds` is not an error, it simply stops contributing.

Cannot:
- There is **no standalone variables / token editor panel**. Token authoring (new tokens, renames, deletes, scale tweaks, mode overrides) is done by editing the `.ds` source, not through inspector buttons. There are no in-app rename or delete buttons for tokens.
- There is **no default keyboard shortcut** for switching brand or mode; use the inspector dropdowns.
- There is **no export to CSS variables or Tailwind config** from the UI; external tools consume the `.gen.yaml` artifact.

Figma import boundaries (each announced in the import warnings, never silent):
- **Gradient geometry is not themable.** A gradient paint style brings its stop *colors* across as tokens, but the gradient's geometry (angle, stop positions) imports as fixed values, not tokens.
- **Image paint styles stay literal.** A photo/image paint style has nothing single-valued to tokenize, so it imports as a literal image fill.
- **Some text-style details stay on the element, not the token.** Italic, text case, text decoration, a pixel line-height unit, and a percent letter-spacing unit are kept on the imported elements but are not carried into the typography tokens (Brilliant's typography tokens do not express them). The expressible parts of the type style still become a token.
- **T-shirt role names are aliases only.** When a large numeric scale imports, Brilliant may add t-shirt role names (`spacing.md` and friends) as aliases, but element bindings stay on your faithfully-named tokens: a numeric binding is never redirected onto a role alias.
- **Your role names are never overwritten.** If a Figma variable already owns a standard role name, Brilliant keeps your token and adds no competing alias; a dark-theme sibling of that variable stays its own separate token rather than folding onto the role.

## Design System Commands

Most are in the command palette under the design-system group. The two exceptions are **Set Design System** and **Set Design System Mode**: these do not appear in the palette, and by hand are driven only by the inspector dropdowns. An AI agent sets the same brand and mode through the Blueprint `ds(name, axis(value))` form (the preferred path, e.g. `ds(, theme(dark))`), or by calling `set_design_system` / `set_design_system_mode` through `execute_commands`: the brand command takes `{value: <brand>}`, the mode command takes `{axis: <axis>, value: <mode>}` (an unknown axis or value is refused by name). Brand/mode/reset operations are undoable via the per-canvas undo stack (Cmd+Z).

| Command (display name) | Purpose |
|---|---|
| Set Design System | Brand setter for the current scope (not in the palette; by hand via the inspector brand dropdown) |
| Set Design System Mode | Per-axis mode setter (not in the palette; by hand via the inspector axis dropdowns) |
| Apply Typography Token | Apply a `typography.*` composite to selected text element(s) |
| Apply Shadow Token | Apply a `shadow.*` composite to selected element(s) |
| Unbind Tokens | Replace all token bindings on the selection with literal values and drop the binding |
| Create Design System Viewer | Insert an 800x600 viewer element visualizing the active system |
| Open Design System File | Open the nearest `.ds` source in the code editor |
| Regenerate Design System | Rebuild all `.gen.yaml` files from their `.ds` sources |
| Reset Design System | Rewrite the design system source with Brilliant's built-in seed template, replacing the current tokens (undoable) |

Note: the **Reset Design System** command rewrites the *source file* with Brilliant's built-in seed template (the same defaults a fresh project starts with), replacing every authored token; Cmd+Z restores what was there before. The **Reset design system** button in the inspector is a different action: it clears brand/mode overrides at the inspected scope without touching the source.

## Related Knowledge

- Authoring or editing the system's tokens (the `.ds` DSL, brands, modes, composites): `design-systems/core`, `design-systems/authoring`, `design-systems/authoring-modes`.
- Referencing tokens in blueprint markup: `blueprint/core` and the other `blueprint/*` files.
- Colors, fills, strokes, opacity, corner radius in the UI: `reference/styling`.
- Effects (shadows, glows, blurs): `reference/effects`.
- Components and instances: `reference/components`.
- Library design systems and library instances (which default to the library's own tokens): `reference/libraries`.
- Importing from Figma (connecting Figma, plugin vs URL, what else comes across): `reference/canvases`.
