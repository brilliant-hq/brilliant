---
name: "knowledge-canvases-explorer"
description: "The file explorer: layout, selection, keyboard navigation, renaming, drag-and-drop, hidden files, and git decoration."
assumes: reference/canvases
---

# File Explorer

The file explorer lives in the **left toolbar**. Focus it with **Cmd+Shift+E**. The Layers explorer (the active canvas's element tree) sits below it; focus it with **Cmd+Shift+J**. Toggle the whole left toolbar with **Cmd+Shift+Left**. The explorer shows all canvases (`.bl`), folders, image assets, and other text/code files in the workspace as a tree. Canvas (`.bl`) and design-system (`.ds`) names display without their extension.

**Layout (top to bottom):**
1. "Files" header with right-aligned buttons: Toggle All Folders (expand/collapse all), New Folder, New Canvas, Toggle Canvas Search
2. Workspace tree: folders, canvases, images, text files
3. Below it, the Layers explorer for the active canvas

**Selection:**
- Click an item to select it (and switch to it if it's a canvas or previewable file)
- Cmd+click to add/remove an item from the selection
- Shift+click to select a range from the anchor to the clicked item
- Selection spans canvases, folders, and assets at once (for batch move or bulk delete)

**Keyboard navigation (explorer focused):**

| Key | Action |
|-----|--------|
| Up/Down, J/K | Move navigation focus |
| Left/Right, H/L | Collapse / expand folder |
| Space, O | Open / switch to the focused item |
| Enter, F2 | Start inline rename |
| Escape | Clear focus, or cancel a rename / cut-paste |
| Cmd+A | Select all visible items |
| Tab | Move focus to the layers explorer |
| gg | Jump to top (press G twice within 500ms) |
| Shift+G | Jump to bottom |
| Backspace / Del (Cmd+Backspace / Cmd+Delete also work) | Delete selected canvas/folder/asset (multi-select deletes are one undo entry) |
| Cmd+N / Cmd+Shift+N | New canvas / folder inside the focused folder (outside the explorer Cmd+Shift+N is New Project) |
| Cmd+C / Cmd+X / Cmd+V | Copy / cut / paste canvases or folders |
| Ctrl+N / Ctrl+P | Move focus down / up (vim/emacs style) |

**Renaming:** double-click the name to rename inline, or press Alt+Enter while a canvas is focused (works in or out of the explorer). Escape cancels.

**Drag-and-drop:** drag a canvas or folder onto another folder to move it; multi-select then drag to move several at once (one undo entry). Drag image files from Finder onto the explorer to import them as assets.

**Toggle Hidden Files:** show/hide dotfiles and dotfolders (e.g. `.git`, `.env`) via the palette ("Toggle Hidden Files"). Hidden by default; the choice persists across restarts.

**Git decoration:** in a Git repository, files matching `.gitignore` are dimmed in the explorer.
