---
name: "knowledge-text-navigation"
description: "Keyboard navigation and selection while editing text, and the right-click menu in the editor."
assumes: reference/text
---

# Text Navigation While Editing

| Shortcut | Action |
|----------|--------|
| Enter | New line |
| Shift+Enter | Line break (a new line) |
| Escape or Cmd+Enter (Ctrl+Enter on Windows) | Finish editing |
| Double-click | Select word |
| Triple-click | Select line |
| Quadruple-click | Select all |
| Cmd+A | Select all |
| Shift+Arrow | Extend selection |
| Cmd+Shift+Left/Right | Select to line start/end |
| Alt+Shift+Left/Right | Select word by word |
| Cmd+Left/Right | Jump to line start/end |
| Alt+Left/Right | Move by word |
| Cmd+Up/Down | Jump to document start/end |
| Cmd+Backspace | Delete to line start |
| Alt+Backspace | Delete previous word |

Holding Backspace, Delete, an arrow key, Home, End, Enter or Shift+Enter repeats it, the same as in any text field.

**Right-click the text you are editing** for a menu that acts on the selection: Cut, Copy, Paste, Select All, then Bold, Italic, Underline and Strikethrough (checked when the selection has them), Font (Font..., Weight, Bigger, Smaller), Text Color... (the color picker for the selected text), Link... (a small field under the selection, prefilled with its link: Enter applies, Escape cancels, an empty field removes the link), Transformations (Upper Case, Lower Case, Title Case rewrite the selected characters themselves as one undo step, unlike the Case dropdown, which only changes how the whole text displays), Align and List. Each row shows its shortcut, and the edit stays open with your selection. On macOS it is the native system menu. See `reference/ui` for the menu's platform behavior.
