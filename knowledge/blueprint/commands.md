---
assumes: blueprint/core
dsl: [execute_commands, select_elements, use_mask, detach_component, push_overrides, import_figma, create_canvas, boolean]
---
# Blueprint Commands

Assumes: `blueprint/core`

Use `execute_commands` only for operations the DSL **cannot** express — alignment, distribution, selection, canvas management, view toggles, undo/redo. Element creation, deletion (`delete()`), property changes, z-order (`front`/`back`), flip, group/ungroup, and reparenting are all Blueprint DSL operations — never `execute_commands`.

## execute_commands

```json
{ "canvasId": "...", "commands": [{ "commandId": "...", "elementIds": [...], "params": {...} }], "previewIds": [...], "previewScale": 2 }
```

Multiple commands execute sequentially in one call.

## Command Reference (execute_commands only)

**Selection:** `select_elements`, `deselect_all`

**Align (2+):** `align_left`, `align_right`, `align_top`, `align_bottom`, `align_horizontally`, `align_vertically`

**Center on canvas:** `center_horizontally`, `center_vertically`

**Distribute (3+):** `distribute_horizontally`, `distribute_vertically`

**Boolean ops:** `boolean_union`, `boolean_subtract`, `boolean_intersect`, `boolean_exclude`

**Mask:** `use_mask` — create a clipping mask from selected elements

**Components:** `detach_component`, `reset_component_instance_overrides`, `push_overrides_to_master`, `go_to_master_component`

**Import:** `import_figma` (`{ "figmaUrl": "https://www.figma.com/design/..." }`)

**Canvas:** `create_canvas` (`{ "fullPath": "Projects/Name" }`), `get_canvases`, `rename_canvas`, `delete_canvas`, `duplicate_canvas`, `create_folder`, `delete_folder`, `create_structure`

**Background:** `set_background_color` (`{ "value": "#hex" }`) — auto-enables visibility. `toggle_background`, `toggle_whiteboard`, `toggle_blackboard`

**Provider Keys:** `set_anthropic_api_key`, `set_openai_api_key`, `set_google_api_key`, `set_openrouter_api_key`

**Keybindings:** `list_keybindings` (`{ "group": "...", "search": "..." }`), `set_keybinding` (`{ "bindings": [{ "commandId": "...", "key": "P", "modifiers": ["shift"] }] }`)

**Undo/Redo:** `undo`, `redo` — each AI session has its own undo stack, separate from the user's. Calling `undo` reverts only your own last action, never the user's work. The user's Cmd+Z likewise never undoes agent actions. If the user asks you to undo something you did, use this. If they ask about undoing their own work, tell them to press Cmd+Z (per-canvas, does not persist across app restarts).

**Canvas display toggles** — no `elementIds` needed:

| Command | What it toggles |
|---------|----------------|
| `toggle_pixel_grid` | Pixel grid overlay (visible at 400%+ zoom) |
| `toggle_snap_to_pixel_grid` | Snap positions/sizes to whole pixels |
| `toggle_rulers` | Ruler bars along canvas edges |
| `toggle_layout_grids` | Layout grid overlays on frames |
| `toggle_snap_guides` | Alignment/spacing snap guides |
| `toggle_dimension_labels` | Width/height labels during create/resize |
| `toggle_presentation_mode` | Clean fullscreen view, all UI hidden |
| `toggle_ui` | Show/hide all UI panels |

**Element property toggles** — require `elementIds`:

| Command | What it toggles |
|---------|----------------|
| `toggle_constrain_proportions` | Lock aspect ratio during resize |
