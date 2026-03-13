---
assumes: blueprint/core
---
# Blueprint Commands

Assumes: `blueprint/core`

Use `execute_commands` only for operations the DSL **cannot** express — alignment, distribution, selection, canvas management. Element creation, deletion (`delete()`), and property changes are all Blueprint DSL operations — never `execute_commands`.

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

**Import:** `import_figma` (`{ "figmaUrl": "https://www.figma.com/design/..." }`)

**Canvas:** `create_canvas` (`{ "fullPath": "Projects/Name" }`), `get_canvases`, `rename_canvas`, `delete_canvas`, `duplicate_canvas`, `create_folder`, `delete_folder`, `create_structure`

**Background:** `set_background_color` (`{ "value": "#hex" }`) — auto-enables visibility.

**Provider Keys:** `set_anthropic_api_key`, `set_openai_api_key`, `set_google_api_key`, `set_openrouter_api_key`

**Keybindings:** `list_keybindings` (`{ "group": "...", "search": "..." }`), `set_keybinding` (`{ "bindings": [{ "commandId": "...", "key": "P", "modifiers": ["shift"] }] }`)
