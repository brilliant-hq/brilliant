---
name: "knowledge-canvases-managing"
description: "Creating, deleting, switching, and foldering canvases by hand, with their shortcuts."
assumes: reference/canvases
---

# Managing Canvases

## Creating and deleting

| Action | Shortcut |
|--------|----------|
| New canvas | Cmd+N |
| Duplicate current canvas | Cmd+Ctrl+N |
| New folder | Cmd+Shift+N (file explorer focused) |
| Delete active canvas | Cmd+Shift+Del (the forward-delete key / Fn+Delete on Mac keyboards without a dedicated Del; Cmd+Shift+Backspace does not trigger it) |
| Rename active canvas | Alt+Enter |

Cmd+N inside the file explorer creates the canvas inside the focused folder; otherwise it goes to the workspace root. Cmd+Shift+N creates a folder inside the focused folder while the file explorer has focus; elsewhere it opens New Project (use the explorer's new-folder button or File > New Folder for a root folder).

## Switching between files

| Action | Shortcut |
|--------|----------|
| Next file (canvas, image, or text) | Alt+Right (Cmd+Alt+Right while the text editor is focused; plain Alt+arrow is word motion there) |
| Previous file | Alt+Left (Cmd+Alt+Left in the text editor) |
| Previously active canvas | Ctrl+Alt+Left |
| Reveal/focus active canvas in explorer | Cmd+Shift+K |
| Search and switch canvas | Cmd+P |
| Global search (canvases, images, text files) | Cmd+K |
| Search files in place (the Files header) | Cmd+L |
| Search chats | Cmd+Shift+I |
| Palette | Cmd+Shift+P |

Switching canvases is instant and not undoable. Each canvas keeps its own independent undo history; Cmd+Z on a canvas undoes that canvas's last action. When the file explorer is focused, Cmd+Z routes to a separate explorer undo stack covering rename, create, delete, move, and reorder of canvases and folders.

Switching announces itself when the new canvas is still loading: if content does not appear almost immediately (a heavy canvas, a slow first paint), the canvas area briefly dims with a subtle shimmer rather than leaving the old canvas showing, and clears the instant the new content is on screen. Fast switches (the normal case) never flash it.

Per-canvas state saved into the `.bl` file: element data, hierarchy, fills/strokes/effects, components, design-system bindings, background settings, ruler guides, zoom, and pan position. Selection and undo history live only for the session.

## Folders

| Action | Shortcut |
|--------|----------|
| Create folder | Cmd+Shift+N (file explorer focused) |
| Toggle expand/collapse all folders | Cmd+Shift+C |

Right-click a folder in the file explorer for: Rename, Delete, Duplicate, Cut, Copy, Paste, New Canvas, New Folder (inside this folder), Expand/Collapse/Expand All/Collapse All, Show in Finder, Copy Relative Path, Copy Absolute Path. Folders can be nested, and canvases can be dragged between them (multi-select supported).

Pasting a cut or copied canvas, folder or file where one with that name already exists asks before replacing it, from the keyboard and from the right-click menus alike. Declining keeps both where they were.
