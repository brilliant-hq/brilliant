---
name: "knowledge-canvases-previews"
description: "Previewing images and text files in place of the canvas, the code editor, and managing image assets."
assumes: reference/canvases
---

# Previews and the Code Editor

Clicking a non-canvas file in the explorer (or navigating to it with Alt+Arrow) replaces the canvas view with a preview:

| File type | Preview |
|-----------|---------|
| Image (PNG, JPG, JPEG, GIF, BMP, WebP; on macOS and Windows also TIFF/TIF, HEIC, HEIF, AVIF) | Centered image at natural size (large images scale down to fit) on an opaque viewer surface |
| Text/code (JS, TS, JSX, TSX, Python, Dart, HTML, CSS, JSON, YAML, Markdown, Rust, C/C++, Java, Kotlin, Go, Swift, SQL, Shell/Bash/Zsh, XML, TOML, INI, plain text, `.ds`, `.bm`, `.gen.yaml`, `.svg`) | Built-in code editor |
| Unknown types | Sniffed: text shows in the editor, binary shows an unsupported placeholder |

File previews fully replace the canvas view and never disturb it: the canvas viewport (zoom and pan) is exactly where you left it when you switch back. While a preview is open, the right toolbar (property inspector) and the drawing-tool cluster hide, leaving the AI input available.

`.svg` opens in the code editor as XML text, not as an image. To use an SVG as a design element, import it (Cmd+Shift+O) or paste it on the canvas; both convert it into native editable vector elements.

The code editor replaces the canvas while a text file is active. Features:
- Syntax highlighting (dark/light theme auto-matched to Brilliant's brightness)
- Vim mode; auto-loads config from `~/.config/nvim/init.vim`, `~/.config/nvim/init.lua`, or `~/.vimrc`. A mode indicator (Normal/Insert/Visual) appears in the top toolbar when active.
- Cmd+F search and replace; side-by-side diff/merge view
- Alt+Right/Left switches files (Cmd+Alt+Right/Left from inside the focused text editor, where plain Alt+arrow is word motion); Ctrl+Alt+Left jumps to the previously active file

Text files larger than 5 MB open read-only, showing the first 5 MB behind a banner. If a file open in the editor changes on disk (for example an agent rewrites it), Brilliant reconciles it rather than losing work: with no unsaved edits it reloads and shows a passive notice; with unsaved edits it holds every save and raises an actionable notice (Reload / Keep mine), so neither your edits nor the outside change is silently overwritten, however soon after your last save it lands.

Design-system source files (`*.ds` under `Styles/`) open with DSL highlighting and show their errors inline as you type, with a clickable problems list above the text; generated `*.gen.yaml` under `Styles/.gen/` open with YAML highlighting and should be treated as read-only (they regenerate from the source). For editing design tokens, see `reference/design-systems`. Films (`Motion/<film>.bm` in a canvas's folder or at the project root, beside `Styles/`, rendered by `export` with `motion: "<film>"`) open in the code editor with motion highlighting.

## Asset Management

Image files live in `Assets/` folders next to canvases. Each folder level can have its own `Assets/` directory.

Right-click an asset in the explorer for:
- **Rename**: automatically updates every reference to the asset across all `.bl` files
- **Delete**: warns first if the image is used by any canvas, then moves it to `.brilliant/trash/` (recoverable via undo)
- **Show in Finder**
- **Copy Filename**

Other behavior:
- `Assets/` folders show in the explorer even when empty (if the directory exists on disk)
- **Clean Up Unused Assets** (palette) removes images not referenced by any canvas; undoable
- A file watcher keeps the explorer live against external changes: an agent or git creating, deleting, renaming, or moving `.bl` files, folders, or assets on disk shows up within about a second, no repo reopen needed. Bursts (a `git checkout` touching many files) apply as one batch. Regaining app focus also runs a quick rescan as a safety net.
- If the OPEN canvas's `.bl` file changes on disk, it reconciles like the text editor: with no unsaved edits the canvas reloads (selection and camera preserved) and shows a passive notice; with unsaved edits auto-save pauses for that canvas and an actionable notice offers Reload / Keep mine, so neither side is silently overwritten. Switching to another canvas does not answer the notice, and neither does closing it with its x: it stays in the notifications list, where Reload and Keep mine still work, until you choose. Reload keeps a copy of your unsaved work in the recovery folder before it loads the disk version. If a canvas in a synced project is rewritten on disk (for example by an agent) and loses much of its content, Brilliant keeps the disk version on screen and asks whether to keep it or restore the synced one (Keep disk version / Restore synced version), and restoring saves the replaced version to the recovery folder first. If the open canvas's file is deleted externally, Brilliant lands on a surviving canvas.
