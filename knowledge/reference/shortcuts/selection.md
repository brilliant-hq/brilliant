---
name: "knowledge-shortcuts-selection"
description: "Selection and navigation shortcuts and the context-aware Escape behavior."
assumes: reference/shortcuts
---

# Shortcuts: Selection and Navigation

| Action | Shortcut |
|--------|----------|
| Select all | Cmd+A, also Edit > Select All. Acts on whatever is focused: the canvas selects all elements; in vector edit mode, all nodes and handles; with the file explorer focused, all explorer rows; in a text file, the whole document. |
| Select previous sibling | Tab (id `select_previous_element`) |
| Select next sibling | Shift+Tab (id `select_next_element`) |
| Enter frame / edit element / enter vector edit mode | Enter |
| Exit / cancel (context-aware: clears selection, exits vector mode, exits crop, etc.) | Escape |
| Select parent frame | Shift+Enter |
| Rename selected layer | Cmd+R |
| Delete selected | Backspace or Del, including numpad Del with NumLock off (one action, three keys: ids `delete_command` / `delete_command_forward` / `delete_command_numpad_decimal`; Del is Fn+Delete on macOS; numpad '.' with NumLock on still types) |
| Hide / show selection | Cmd+Shift+H (id `toggle_visibility`; Figma parity. Plain Shift+H is flip-horizontally) |

### Escape Behavior (Context-Aware)

A single Escape press acts on the one context you are in. These contexts are mutually exclusive (only one applies at a time), so the list has no priority order:

- Close the palette
- Close an open dropdown or token menu (id `escape_close_menus`)
- Exit color pick / eyedropper mode
- Cancel a pending position pick: the AI chat's position picker or placing an asset from the Assets view (id `escape_position_pick`)
- Cancel frame label editing
- Exit image crop mode
- Clear the current vector handle/node selection (first press in vector mode)
- Exit vector edit mode (second press) or pen tool
- Exit boolean group edit mode
- Exit mask edit mode
- Finish editing text on the canvas (the text stays, the element stays selected)
- Exit file preview mode (return to the canvas)
- Blur the AI input
- Return to the Move tool when a drawing tool (rectangle, circle, frame, line, arrow, pencil, text, snip) or the Hand tool (picked with H or the toolbar) is active, or turn Scale mode (K) off; the selection stays, so the next Escape clears it. Holding Space to pan is not affected: releasing Space already brings your tool back
- Clear the canvas selection

While you are typing in a property panel field (a hex code, a number such as opacity or size), Escape belongs to the field: it cancels the edit and leaves the field, and nothing else happens on that press (the AI chat stays open, the selection stays). The next Escape acts on the context above.
