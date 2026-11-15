---
name: "knowledge-shortcuts-edit"
description: "Clipboard, undo/redo, and alignment shortcuts."
assumes: reference/shortcuts
---

# Shortcuts: Clipboard, Undo, Alignment

## Clipboard

| Action | Shortcut |
|--------|----------|
| Copy | Cmd+C |
| Cut | Cmd+X |
| Paste | Cmd+V |
| Paste to replace (replace each selected element with the copied elements, in its slot) | Cmd+Shift+R |
| Copy properties (fills, strokes, effects, opacity, radius, text style of ONE element; auto layout settings between auto layout frames) | Cmd+Alt+C |
| Paste properties (onto every selected element) | Cmd+Alt+V |
| Duplicate | Cmd+D |
| Delete | Backspace or Del |

In vector edit mode, Cmd+C / Cmd+V copy and paste the selected nodes (and their connecting edges) inside the same vector path.

## Undo / Redo

| Action | Shortcut |
|--------|----------|
| Undo | Cmd+Z |
| Redo | Cmd+Shift+Z |

While you type in a text field (the zoom field, a rename, a search, an inspector value), Undo and Redo apply to that field's text, never to the canvas; on Windows and Linux Ctrl+Y also redoes the field. Undo history is per-canvas: each canvas has its own undo stack. When the file explorer is focused, undo/redo applies to canvas and folder operations instead.

## Alignment

| Action | Shortcut |
|--------|----------|
| Align left | Alt+Shift+L |
| Align right | Alt+Shift+R |
| Align top | Alt+Shift+T |
| Align bottom | Alt+Shift+B |
| Center horizontally | Alt+H |
| Center vertically | Alt+V |
| Align horizontally | Alt+Shift+H |
| Align vertically | Alt+Shift+V |
| Distribute horizontally | Ctrl+Alt+H |
| Distribute vertically | Ctrl+Alt+V (macOS only, see the Windows-disabled defaults in `reference/shortcuts/platform-keys`) |
| Fit to parent | Ctrl+Alt+F |
