---
name: "knowledge-shortcuts-code-editor"
description: "Editing commands for the built-in code editor."
assumes: reference/shortcuts
---

# Shortcuts: Code Editor

Editing commands for the text editor (open any non-design file). Active only while the editor is focused; each is a real command: rebindable in the shortcuts UI and runnable from the palette. Rebinding applies inside the editor immediately.

| Action | Shortcut |
|--------|----------|
| Move line up / down | Alt+Up / Alt+Down |
| Copy line up / down | Shift+Alt+Up / Shift+Alt+Down |
| Delete line | Cmd+Shift+K |
| Insert line below / above | Cmd+Enter / Cmd+Shift+Enter |
| Toggle comment | Cmd+/ (language aware, including `//` in `.ds`) |
| Select next occurrence | Cmd+D |
| Select all occurrences | Cmd+Shift+L |
| Add cursor above / below | Cmd+Alt+Up / Cmd+Alt+Down |
| Add cursor at click | Option+Click |
| Find in file | Cmd+F inside the editor (palette id `find_in_file`) |
| Go to line | Ctrl+G inside the editor (palette id `go_to_line`) |
| Toggle line wrap | (no default, id `toggle_line_wrap`) |
| Toggle markdown preview | Cmd+Shift+V (id `toggle_markdown_preview`; while a text/markdown file is open) |

Outside the editor, the shared chords keep their app meaning: Cmd+Enter flattens the selection, Cmd+D duplicates, Cmd+/ toggles inspector sections, Cmd+Shift+K focuses the active file.
