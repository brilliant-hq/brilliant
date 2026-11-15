---
name: "knowledge-shortcuts-files"
description: "Canvas management and file operation shortcuts."
assumes: reference/shortcuts
---

# Shortcuts: Canvases and Files

## Canvas Management

| Action | Shortcut |
|--------|----------|
| New canvas | Cmd+N (creates a new canvas; when AI chat is open instead routes to `new_chat`) |
| Duplicate canvas | Cmd+Ctrl+N |
| New folder | Cmd+Shift+N while the file explorer has focus (elsewhere Cmd+Shift+N is New Project) |
| Rename canvas | Alt+Enter |
| Delete canvas | Cmd+Shift+Del (the forward-delete key / Fn+Delete; Cmd+Shift+Backspace does not trigger it) |
| Switch to next canvas | Alt+→ (Cmd+Alt+→ while the text editor is focused, where plain Alt+arrow is word motion) |
| Switch to previous canvas | Alt+← (Cmd+Alt+← in the text editor) |
| Switch to previously active canvas | Ctrl+Alt+← |
| Focus active canvas in explorer | Cmd+Shift+K |
| Delete selected rows (file explorer focused) | Backspace or Del, also Cmd+Backspace / Cmd+Del and Edit > Delete |
| Duplicate selected rows (file explorer focused) | Cmd+D, also Edit > Duplicate (desktop only) |
| Toggle expand/collapse all folders | Cmd+Shift+C |
| Toggle hidden files | (no default) |

## File Operations

| Action | Shortcut |
|--------|----------|
| New project | Cmd+Shift+N (id `new_project_menu`; inside a focused file explorer the chord is New folder) |
| Open project folder (File > Open Project Folder...) | Cmd+O (id `open_design_folder`) |
| Close the active project tab | Cmd+W while the AI chat is closed (id `close_tab`; with the chat open Cmd+W closes the chat) |
| Import (images, SVGs, `.bl` design files) | Cmd+Shift+O (id `import`) |
| Save as | Cmd+Shift+S |
| Export to PNG (the selection, or the whole canvas when nothing is selected) | Cmd+E (id `export_to_png`) |
| Export to JPEG / WebP / SVG / PDF / HTML / React (JSX) / Replay (mp4/mov) | (no defaults, ids `export_to_jpeg`, `export_to_webp`, `export_to_svg`, `export_to_pdf`, `export_to_html`, `export_to_react`, `export_to_replay`) |
| Copy as PNG / WebP / SVG / CSS / HTML / HTML Document / HTML Flex / React / Blueprint | (no defaults, ids `copy_as_png`, `copy_as_webp`, `copy_as_svg`, `copy_as_css`, `copy_as_html`, `copy_as_html_document`, `copy_as_html_flex`, `copy_as_react`, `copy_as_blueprint`) |
| Insert image / Import image | (no defaults, ids `insert_image`, `import_image`) |
| Clean up unused assets | (no default, id `clean_up_unused_assets`) |

**Option+Cmd+S** (Ctrl+Alt+S on Windows) is **Create Checkpoint** (id `create_checkpoint`), also **File > Create Checkpoint** in the menu bar, right after Save As. The row is disabled while the project has no checkpoints or a checkpoint is being saved.
