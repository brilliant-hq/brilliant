---
name: "knowledge-design-systems-commands"
description: "The design system commands, by hand and through execute_commands."
assumes: reference/design-systems
---

# Design System Commands

Most are in the palette under the design-system group. The two exceptions are **Set Design System** and **Set Design System Mode**: these do not appear in the palette, and by hand are driven only by the inspector dropdowns. An AI agent sets the same brand and mode through the Blueprint `ds(name, axis(value))` form (the preferred path, e.g. `ds(, theme(dark))`), or by calling `set_design_system` / `set_design_system_mode` through `execute_commands`: the brand command takes `{value: <brand>}`, the mode command takes `{axis: <axis>, value: <mode>}` (an unknown axis or value is refused by name). Through `execute_commands` both apply to the canvas, whatever is selected, and take no element ids; for one element write `#ref ds(,theme(dark))` (or `#ref ds(<brand>)`) in an edit block. Brand/mode/reset operations are undoable via the per-canvas undo stack (Cmd+Z).

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
