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
- **Composite tokens** bundle element property values under one name: typography tokens (`typography.h1`, `typography.body.md`) carry font family, size, weight, line height and letter spacing, shadow tokens (`shadow.md`) carry one or more shadow layers, and any name can carry any mix (`card.elevated` with fills, effects, radius). A field that references another token follows it across modes and brands.

## Where the System Lives

A project's design system is stored as files in a `Styles/` folder at the repo root (`Styles/default.ds` is the baseline, plus optional brand files like `Styles/corporate-blue.ds`). The user does not need to touch these to *use* tokens; they only matter when authoring or editing the system. Sub-folders can carry their own `Styles/default.ds` that overrides the parent for canvases in that folder.

Clicking a `.ds` file in Files (or opening it from the palette, a link or recent files) opens the design system editor for that file in the main area, the same pages as the Project tab's **Design system** page, showing and editing that file's tokens. Its **View as file** (on every page header and in its rail) opens the `.ds` text in the built-in code editor, and **View as editor** at the top right of the text goes back to the editor (so does clicking the file in Files again). The **Open Design System File** command (palette) opens the nearest `.ds` file's text in the code editor directly. A `.ds` that belongs to a library opens read-only, with the same library line and **Edit a copy** as the Project tab's page. In a cloud project without a local folder, a `.ds` opens as text.

**Searching a design system page.** Each page of the design system editor has its own search field at the top right, before **View as file** ("Search colours" on Colours, "Search text styles" on Type, "Search <page>" elsewhere). Type a token name or a value (for example `primary` or `#FF3377`): only the matching tokens stay, a section with no match folds away, matching rows are highlighted, and the count reads like "3 of 26 colours". When nothing matches, the page says "Nothing on this page matches “<your text>”." Esc clears the search, switching to another page starts it empty, and Cmd+F (Ctrl+F on Windows) puts the cursor in it while the design system editor is in front. The search in the editor's left rail is separate: it finds which pages hold a match.

- `reference/design-systems/inspector`: the Design system section, scope, switching brand and modes, reset and viewer
- `reference/design-systems/binding`: binding tokens to properties, composite tokens, unbinding
- `reference/design-systems/figma-import`: importing a design system from Figma, what Brilliant can and cannot do
- `reference/design-systems/commands`: the design system commands

## Related Knowledge

- Authoring or editing the system's tokens (the `.ds` DSL, brands, modes, composites): `design-systems/core`, `design-systems/authoring`, `design-systems/authoring-modes`.
- Referencing tokens in blueprint markup: `blueprint/core` and the other `blueprint/*` files.
- Colors, fills, strokes, opacity, corner radius in the UI: `reference/styling`.
- Effects (shadows, glows, blurs): `reference/effects`.
- Components and instances: `reference/components`.
- Library design systems and library instances (which default to the library's own tokens): `reference/libraries`.
- Importing from Figma (connecting Figma, plugin vs URL, what else comes across): `reference/canvases`.
