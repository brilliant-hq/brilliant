---
name: "knowledge-shortcuts-panels"
description: "Project tab, home, and UI panel shortcuts."
assumes: reference/shortcuts
---

# Shortcuts: Tabs, Home, Panels

## Tabs & Home

| Action | Shortcut |
|--------|----------|
| Next project tab | Ctrl+Tab (id `next_tab`) |
| Previous project tab | Ctrl+Shift+Tab (id `previous_tab`) |
| Jump to home | Cmd+Ctrl+0 (id `jump_to_tab_0`) |
| Jump to project tab 1 to 9 | Cmd+Ctrl+1 to Cmd+Ctrl+9 (ids `jump_to_tab_1` to `jump_to_tab_9`) |
| Go home | (no default, id `go_home`) |
| Activate a tab by name | (no default, id `activate_tab`, takes `{"value": "<session key, display name, or home>"}`) |
| Toggle project search | (no default, id `toggle_project_search`) |

The Cmd+Ctrl+0-9 jumps share their chord with the rotation levels via WhenClause: the jumps fire when nothing is selected, rotation when a selection is present.

## UI Panels

| Action | Shortcut |
|--------|----------|
| Palette (commands only) | Cmd+Shift+P |
| Global search (all categories) | Cmd+K |
| Canvas search (files filter) | Cmd+P |
| Search Files (the Files header's in-place search) | Cmd+L |
| Chat search | Cmd+Shift+I |
| Font selector | Cmd+Shift+F |
| Color selector / picker | Ctrl+C |
| Settings | Cmd+, |
| Shortcuts reference | Shift+? |
| Combos | Cmd+Shift+M |
| Toggle left toolbar | Cmd+Shift+← |
| Toggle right toolbar | Cmd+Shift+→ |
| Toggle bottom toolbar | Cmd+Shift+↓ |

While you are typing (any text field, or editing text on the canvas), these three chords belong to the **text**: Ctrl+Shift+←/→ extends the selection by word on Windows/Linux (Cmd+Shift+←/→ selects to the line boundary on macOS). The toolbar toggles apply whenever you are not typing.

**Cmd+L** is **Search Files** (id `focus_file_search`): it focuses the Files header's in-place search. Layer search (`toggle_layer_search`) has no default shortcut; reach it from the Edit menu, the palette, or Cmd+K.

| Focus file (canvas) explorer | Cmd+Shift+E (id `focus_canvas_explorer`) |
| Focus layers explorer | Cmd+Shift+J (id `focus_layers_explorer`; Cmd+Shift+R is Paste to replace, as in Figma) |
| Toggle layers section in left toolbar | (no default, id `toggle_layers`) |
| Focus AI chat input in bottom toolbar | . (period) any time, or / (slash) when nothing is selected |
| Check for updates | Cmd+Shift+U |
| Toggle Vim mode (code editor) | (no default, id `toggle_vim_mode`) |
