---
name: "knowledge-canvases"
description: "Canvas and folder management, the file explorer, workspaces, import/export, auto-save, and version control in Brilliant, operated by hand."
---

# Canvases

A Brilliant workspace is a folder on disk. Each canvas is a single `.design` file inside it; folders are real directories. There is no separate project index. The directory tree is the project tree.

## Managing Canvases

### Creating and deleting

| Action | Shortcut |
|--------|----------|
| New canvas | Cmd+N |
| Duplicate current canvas | Cmd+Ctrl+N |
| New folder | Cmd+Shift+N |
| Delete active canvas | Cmd+Shift+Delete |
| Rename active canvas | Alt+Enter |

Cmd+N inside the file explorer creates the canvas inside the focused folder; otherwise it goes to the workspace root. Same for Cmd+Shift+N (new folder).

### Switching between files

| Action | Shortcut |
|--------|----------|
| Next file (canvas, image, or text) | Alt+Right |
| Previous file | Alt+Left |
| Previously active canvas | Ctrl+Alt+Left |
| Reveal/focus active canvas in explorer | Cmd+Shift+K |
| Search and switch canvas | Cmd+P |
| Global search (canvases, images, text files) | Cmd+K |
| Search layers in active canvas | Cmd+L |
| Search chats | Cmd+Shift+I |
| Command palette | Cmd+Shift+P |

Switching canvases is instant and not undoable. Each canvas keeps its own independent undo history; Cmd+Z on a canvas undoes that canvas's last action. When the file explorer is focused, Cmd+Z routes to a separate explorer undo stack covering rename, create, delete, move, and reorder of canvases and folders.

Per-canvas state saved into the `.design` file: element data, hierarchy, fills/strokes/effects, components, design-system bindings, background settings, ruler guides, zoom, and pan position. Selection and undo history live only for the session.

### Folders

| Action | Shortcut |
|--------|----------|
| Create folder | Cmd+Shift+N |
| Toggle expand/collapse all folders | Cmd+Shift+C |

Right-click a folder in the file explorer for: Rename, Delete, Duplicate, Cut, Copy, Paste, New Canvas, New Folder (inside this folder), Expand/Collapse/Expand All/Collapse All, Reveal in Finder, Copy Relative Path, Copy Absolute Path. Folders can be nested, and canvases can be dragged between them (multi-select supported).

**Color tags:** append a color suffix to a folder or canvas name to color its icon and breadcrumb. Supported suffixes: `.red`, `.green`, `.yellow`, `.orange`, `.purple`, `.pink`, `.gray` (or `.grey`). Without a suffix the icon is blue. Example: naming a folder `Components.purple` shows a purple icon. The suffix is hidden from the displayed name and preserved through renames.

## File Explorer

The file explorer lives in the **left toolbar**. Focus it with **Cmd+Shift+E**. The Layers explorer (the active canvas's element tree) sits below it; focus it with **Cmd+Shift+R**. Toggle the whole left toolbar with **Cmd+Shift+Left**. The explorer shows all canvases (`.design`), folders, image assets, and other text/code files in the workspace as a tree.

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
| Enter | Start inline rename |
| Escape | Clear focus, or cancel a rename / cut-paste |
| Cmd+A | Select all visible items |
| Tab | Move focus to the layers explorer |
| gg | Jump to top (press G twice within 500ms) |
| Shift+G | Jump to bottom |
| Cmd+Backspace / Cmd+Delete | Delete selected canvas/folder/asset |
| Cmd+N / Cmd+Shift+N | New canvas / folder inside the focused folder |
| Cmd+C / Cmd+X / Cmd+V | Copy / cut / paste canvases or folders |
| Ctrl+N / Ctrl+P | Move focus down / up (vim/emacs style) |

**Renaming:** double-click the name to rename inline, or press Alt+Enter while a canvas is focused (works in or out of the explorer). Escape cancels.

**Drag-and-drop:** drag a canvas or folder onto another folder to move it; multi-select then drag to move several at once (one undo entry). Drag image files from Finder onto the explorer to import them as assets.

**Toggle Hidden Files:** show/hide dotfiles and dotfolders (e.g. `.git`, `.env`) via the command palette ("Toggle Hidden Files"). Hidden by default; the choice persists across restarts.

**Git decoration:** in a Git repository, files matching `.gitignore` are dimmed in the explorer.

## Top Toolbar (Workspace + Save Status)

Centered in the window, the top toolbar shows the active file's location as breadcrumbs: `Workspace / Folder / Subfolder / CanvasName`.

- Double-click the canvas-name segment to rename inline
- Hover the breadcrumb to reveal a Copy Path button that copies the absolute path of the active file
- Save status is shown by the canvas name's brightness: dimmed while there are unsaved changes or a save is in flight, brighter once saved. There is no separate save chip or spinner.
- The breadcrumb area is the window-drag handle (when not maximized/fullscreen)

## Previews and the Code Editor

Clicking a non-canvas file in the explorer (or navigating to it with Alt+Arrow) replaces the canvas view with a preview:

| File type | Preview |
|-----------|---------|
| Image (PNG, JPG, JPEG, GIF, BMP, WebP; on macOS also TIFF/TIF, HEIC, HEIF, AVIF) | Centered image at natural size (large images scale down to fit) on an opaque viewer surface |
| Text/code (JS, TS, JSX, TSX, Python, Dart, HTML, CSS, JSON, YAML, Markdown, Rust, C/C++, Java, Kotlin, Go, Swift, SQL, Shell/Bash/Zsh, XML, TOML, INI, plain text, `.styles`, `.gen.yaml`, `.svg`) | Built-in code editor |
| Unknown types | Sniffed: text shows in the editor, binary shows an unsupported placeholder |

File previews fully replace the canvas view and never disturb it: the canvas viewport (zoom and pan) is exactly where you left it when you switch back.

`.svg` opens in the code editor as XML text, not as an image. To use an SVG as a design element, import it (Cmd+Shift+O) or paste it on the canvas; both convert it into native editable vector elements.

The code editor replaces the canvas while a text file is active. Features:
- Syntax highlighting (dark/light theme auto-matched to Brilliant's brightness)
- Vim mode; auto-loads config from `~/.config/nvim/init.vim`, `~/.config/nvim/init.lua`, or `~/.vimrc`. A mode indicator (Normal/Insert/Visual) appears in the top toolbar when active.
- Cmd+F search and replace; side-by-side diff/merge view
- Alt+Right/Left switches files; Ctrl+Alt+Left jumps to the previously active file

Text files larger than 5 MB load read-only. Design-system source files (`*.styles` under `Styles/`) open with DSL highlighting; generated `*.gen.yaml` under `Styles/.gen/` open with YAML highlighting and should be treated as read-only (they regenerate from the source). For editing design tokens, see [design-systems.md](./design-systems.md).

## Asset Management

Image files live in `Assets/` folders next to canvases. Each folder level can have its own `Assets/` directory.

Right-click an asset in the explorer for:
- **Rename**: automatically updates every reference to the asset across all `.design` files
- **Delete**: warns first if the image is used by any canvas, then moves it to `.brilliant/trash/` (recoverable via undo)
- **Reveal in Finder**
- **Copy Filename**

Other behavior:
- `Assets/` folders show in the explorer even when empty (if the directory exists on disk)
- **Clean Up Unused Assets** (command palette) removes images not referenced by any canvas; undoable
- A file watcher detects external changes: drop a new image into `Assets/` from Finder and it appears in the explorer

## Import & Export

### Importing files

| Action | Shortcut |
|--------|----------|
| Import from file | Cmd+Shift+O |
| Paste from clipboard | Cmd+V |
| Drag and drop | Drag image files onto the canvas |

Cmd+Shift+O opens a picker that accepts images, SVG files, and `.design` files:
- **Images** (PNG, JPG, JPEG, GIF, BMP, WebP; on macOS also TIFF, HEIC, HEIF, AVIF) become rectangle elements with an image fill
- **SVG** imports as native editable vector elements
- **`.design`** files are imported into an `Imports/` folder

### Importing from Figma

Brilliant imports from Figma files via the Figma API, supporting whole files, specific pages, or a single selection subtree.

**By hand (right toolbar Figma Import section):**
1. Paste a Figma URL
2. If the URL contains a node selection (`?node-id=...`), a selection-only toggle (icon button, tooltip "Import selected elements only") appears unchecked; click it to import just that subtree instead of the whole file
3. Click the config (gear) button to fetch and list the file's pages, then choose which pages to import
4. Selecting a page clears the selection-only toggle; enabling it clears page selections

Or run "Import from Figma" from the command palette.

Multi-page files create a folder named after the Figma file with one canvas per page. Single-page files import onto the current canvas (if empty) or a new top-level canvas. If you are not signed in to Figma, the import opens a browser for OAuth sign-in; cancelling returns an error, so retry after signing in.

**What comes across:** frames, groups, and auto layout (including wrap and its cross-axis row gap); components and instances; vectors and shapes; text with case, decoration (underline, strikethrough), and vertical alignment; fills and strokes including per-side widths, dashes, join, and miter; masks and boolean shapes; tiled and cropped images with their color adjustments. Missing fonts warn and fall back to a bundled font, so the text still lands.

**Known gaps for URL import (REST API):** design-system tokens and liquid-glass parameters do not come across. Colors and spacing import as literal values rather than links to tokens, and glass is not exposed over Figma's REST API. To bring design-system variables and glass across, use the Brilliant Figma plugin instead: copy in Figma with the plugin, then paste (Cmd+V) into Brilliant.

### Importing SVG files

SVG imports as native editable vector elements. Methods: command palette ("Import SVG"), paste SVG text with Cmd+V, or Cmd+Shift+O then pick a `.svg` file.
- Supported elements: rect, circle, ellipse, line, path, polygon, polyline, text, g (groups become frames)
- Preserved: fills, strokes, gradients, transforms, hierarchy

### Importing from Sketch

`.sketch` files import as native canvases via the command palette ("Import Sketch File").

### Exporting

Export selected elements, or a focused canvas/folder, via the right-toolbar Export section, the command palette, or Cmd+E (PNG).

Steps:
1. Select target elements (or focus a canvas / folder in the explorer)
2. Cmd+E for a quick PNG, or open the command palette and search "Export to..."
3. Or expand the Export section in the right toolbar to configure format, resolution, fit mode, and background

| Format | Shortcut | Notes |
|--------|----------|-------|
| PNG | Cmd+E | Lossless, alpha supported |
| JPEG | Command palette / right toolbar | Lossy, no alpha; quality 90 default |
| WebP | Command palette / right toolbar | Lossy default (q=90); a lossless option exists for clean rounded corners on UI mockups |
| SVG | Command palette / right toolbar | Vector: paths, shapes, text |
| PDF | Command palette / right toolbar | Vector document |
| MP4 / MOV | Command palette / right toolbar | Animated; codec H.264 / HEVC / ProRes 4444 |
| Replay | Command palette / right toolbar | Animated element-by-element reveal; container MP4 or MOV |

Right-toolbar export options: Format, Resolution (Original, 720p–8K, plus social/device presets and Custom), Fit mode (Fit, Fill, Stretch, Repeat), Background (Transparent or Canvas, when the format supports alpha), Constrain proportions, and video/replay options (duration, FPS, codec, quality, per-element pace, intro text). Multiple export configs can be attached to one element to export several scales or formats in one action.

Notes:
- PNG and WebP support alpha; JPEG fills transparent areas with the canvas background
- HEVC and ProRes 4444 video codecs support alpha; H.264 does not
- SVG and PDF stay sharp at any scale

Full export reference: [export.md](./export.md).

### Exporting to Sketch

Export the focused canvas or folder as a `.sketch` file via the command palette ("Save as Sketch File"). Exports elements, fills, strokes, gradients, text, and images; components and effects may flatten.

### Save As / sharing a `.design` package

| Action | Shortcut | What it does |
|--------|----------|--------------|
| Save As... | Cmd+Shift+S | Export the focused canvas or folder as a portable `.design` package |
| Open folder | Cmd+O | Open a folder as a workspace |

Save As writes the native YAML `.design` file plus a sibling `Assets/` folder with all referenced images; image paths are rewritten to relative `Assets/filename` references so the package is portable. When a folder is focused, Save As exports the entire folder hierarchy. This is for sharing/archiving and does not replace auto-save.

## Auto-Save

Brilliant auto-saves continuously. There is no Cmd+S and you never need to save manually for normal use.

- **Repository mode** (a folder opened with Cmd+O): `.design` files are written directly into the workspace folder, mirroring the explorer hierarchy on disk
- **Scratch mode** (no folder open): work is auto-saved to `~/.config/brilliant/scratch/`

Behavior:
- Shortly after you stop editing, the active canvas is written in the background so saves never block interaction
- The save captures element state, hierarchy, fills/strokes/effects, components, design-system bindings, ruler guides, zoom, pan, and background settings
- The dirty indicator is the canvas name's opacity in the top toolbar breadcrumb
- On quit and on workspace switch, all dirty canvases are flushed first
- If a `.design` file fails to load (corrupt YAML, schema mismatch), saves on that canvas are blocked so good data is never overwritten with empty state

## Workspaces

A workspace is a folder on disk Brilliant uses as a design repository: `.design` files (canvases), subfolders, and assets.

```
my-workspace/
├── .brilliant/             # Workspace settings and trash
│   ├── settings.json       # Per-workspace configuration
│   └── trash/              # Undo recovery for deleted canvases/folders/assets
├── Assets/                 # Root-level images
├── Homepage.design         # Canvas files (YAML)
├── Components/
│   ├── Assets/             # Folder-level images
│   ├── Button.design
│   └── Card.design
└── Pages/
    ├── Dashboard.design
    └── Settings.design
```

| Mode | Description |
|------|-------------|
| Repository mode | A named folder is open (Cmd+O); files live there on disk |
| Scratch mode | Default with no folder open; stored in `~/.config/brilliant/scratch/` |

Cmd+O opens a folder as a workspace. Brilliant remembers the last workspace and reopens it on startup. It tracks up to 20 recent workspaces (scratch excluded).

### `.design` files

Each canvas is a YAML-based `.design` file. A canvas's identity is its path within the workspace (without `.design`), so renaming or moving a canvas changes its identity, and references update accordingly. Files are written deterministically (stable key order, inline coordinate arrays, hex colors) for clean version-control diffs. Older files migrate transparently on load.

### Assets

Images live in `Assets/` directories at each folder level (root, per-folder, nested). Importing an image (Cmd+Shift+O) saves it to the appropriate `Assets/`. Renaming an asset updates all references automatically.

### Deletion and recovery

Deletes are never destructive: Brilliant moves the file to `.brilliant/trash/` and registers an undo entry that restores it.

| What you delete | Where it goes |
|-----------------|---------------|
| Canvas | `.brilliant/trash/` |
| Folder (with all contents) | `.brilliant/trash/` |
| Asset (image) | `.brilliant/trash/` |
| The last canvas in the workspace | A new empty "Canvas" is created automatically; the original goes to trash |

To undo a file-tree operation, focus the explorer (Cmd+Shift+E) and press Cmd+Z. The explorer has its own undo stack, separate from each canvas's per-canvas history. Trash is not auto-cleared; delete `.brilliant/trash/` from Finder to reclaim space.

### Reveal in Finder

Right-click a canvas or folder in the explorer and choose "Reveal in Finder" to locate the actual file on disk (useful for sharing, version control, or backup). Available in repository mode.

### Recents

Within a workspace, Brilliant keeps two recency lists, both persisted across restarts:
- Recent canvases: boost Cmd+P canvas search
- Recent files: a unified list across canvases, images, and text files; drives Cmd+K global search and Alt+Right / Alt+Left order. Ctrl+Alt+Left jumps to the previously active canvas.

## Collaboration & Sharing

Brilliant is a single-user desktop app. There is no real-time multiplayer, share links, or cloud sync.

| Goal | How |
|------|-----|
| Share for viewing | Export PNG/SVG/PDF and send the file ([export.md](./export.md)) |
| Share an editable design | Send the `.design` file; the recipient needs Brilliant |
| Share a full workspace | Share the workspace folder (canvases, Assets, `Styles/`) |
| Developer handoff | Right-click → Copy As → CSS/SVG/PNG, or Alt+hover for measurements |

### Version control with Git

`.design` files are deterministic YAML, producing clean diffs. Open the folder as a workspace (Cmd+O); each canvas is a separate file, and `Assets/` images are referenced by canvases. Commit, branch, and merge as with any code project. Include `.brilliant/` for consistent settings.

There is no version-history panel: undo is per-canvas and within-session only. For persistent history use Git or an OS backup (Time Machine).

## Related

- [export.md](./export.md): export and import details
- [crop.md](./crop.md): image crop mode
- [design-systems.md](./design-systems.md): design tokens and `Styles/` files
- [ui.md](./ui.md): toolbars, panels, command palette
