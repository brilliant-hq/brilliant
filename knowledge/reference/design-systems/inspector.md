---
name: "knowledge-design-systems-inspector"
description: "The Design system inspector section: scope, switching brand and modes, pinned-brand modes, and the reset and viewer buttons."
assumes: reference/design-systems
---

# The Design System Inspector Section

The **right toolbar** has a **Design system** section pinned at its top (always visible when a canvas is loaded). It reports and controls the active brand and modes for the current scope.

Layout: the brand dropdown and the first mode axis sit on the first row; remaining axes wrap two per row. To the right of the row are two icon buttons. When there is anything to reset at the current scope, **Reset design system** (counter-clockwise arrow icon) appears first, followed by **Create Design System Viewer** (paint-palette icon) as the trailing button.

## Scope

The section's subtitle tells you what scope you are editing:

- **Nothing selected** ("this canvas"): the dropdowns set a **canvas-level** override stored on the canvas. It applies only to the current canvas; other canvases in the same folder are unaffected. When no canvas override exists, the canvas inherits the folder's default brand/modes.
- **One element selected** ("1 selected"): the dropdowns set the brand/modes **on that element**. The element's subtree re-resolves against it. Inherited values are shown dimmed with an "Inherited from..." tooltip.
- **Multiple selected**: shows the shared value if all agree, or a "Mixed" placeholder otherwise.

A dimmed field with an "Inherited from..." tooltip means the value is not pinned at this scope: it comes from a parent frame, the canvas, the folder default, or the system default. Picking a value pins it; picking **Inherit** clears the pin and lets the cascade resolve from above.

## Switching brand

The brand dropdown lists **Inherit** (clears the scope's override), **default** (pins to the project baseline), then each brand file found in `Styles/`. Hovering an option previews it live on the canvas without committing; clicking commits. The change is undoable (Cmd+Z).

If the project depends on any **libraries**, their design systems appear in the same dropdown named by the library's handle: `@acme/design-kit` is that library's default look, `@acme/design-kit/marketing` one of its named brands. A library brand always resolves against the library's own tokens, so a library update re-themes everywhere it is used. See `reference/libraries/updating`.

## Switching modes

Each axis the active system declares gets its own dropdown (theme, density, accessibility, or any custom axis the system author defined). Options are **Inherit** plus that axis's declared values. Hover previews, click commits, Cmd+Z undoes. There is no default keyboard shortcut for switching modes, and no palette entry: a mode changes three ways, from the inspector axis dropdowns, from an agent calling `set_design_system_mode` through `execute_commands`, or from an `active { modes: { ... } }` row in a `ds` fence.

### Pinned-brand modes on a selection

When you select elements that carry a design system pinned on the element itself (typically from a Figma import: a brand plus per-node mode overrides that never became the folder's active brand), that brand can declare mode axes the folder does not. Those axes now appear as an extra block below the normal axis rows, labeled with the brand's name and "pinned modes", with one dropdown per axis. Each shows the selection's current pinned value (or "Mixed" when the selected elements differ), and picking a value writes it as the pin on the selected elements while keeping their pinned brand. This is the only place those pinned modes are visible and switchable by hand; it appears only with an element selection, not when editing the whole canvas.

## Reset and Viewer buttons

- **Reset design system**: clears every brand/mode override at the current scope (canvas-level if nothing is selected, or on each selected element). It only appears when there is something to reset, and disappears after the click. Undoable.
- **Create Design System Viewer**: inserts an 800x600 viewer element on the canvas that visualizes the active system's color seeds, scales, and typography composites. Useful as a living swatch sheet.
