---
name: "knowledge-canvases"
description: "Canvas management, folders, import/export, file operations, and auto-save in Brilliant."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Canvases

## Managing Canvases

### Creating and Deleting

| Action | Shortcut |
|--------|----------|
| New canvas | Cmd+N |
| Duplicate current canvas | Cmd+Ctrl+N |
| Delete active canvas | Cmd+Shift+Delete |
| Rename active canvas | Alt+Enter |

### Switching Between Files

| Action | Shortcut |
|--------|----------|
| Next file (canvas, image, text) | Alt+Right |
| Previous file (canvas, image, text) | Alt+Left |
| Previously active canvas | Ctrl+Alt+Left |
| Focus active canvas in explorer | Cmd+Shift+K |
| Search and select canvas | Cmd+P |
| Global search (canvases, images, text files) | Cmd+K |
| Search layers in active canvas | Cmd+L |
| Search chats | Cmd+Shift+I |
| Open command palette | Cmd+Shift+P |

Undo is per-canvas. Each canvas has its own independent undo history. Switching canvases is not undoable: Cmd+Z on the new canvas undoes that canvas's last action. When the file explorer is focused, Cmd+Z routes to a separate explorer undo stack covering rename, create, delete, move, and reorder of canvases and folders.

Per-canvas state that persists across canvas switches (saved into the `.design` file or `SharedPreferences`):
- Element data, hierarchy, fills/strokes/effects, components, design system bindings (in the `.design` file)
- Per-canvas background settings, ruler guides
- Zoom and pan position (per `ZoomManager._canvasZoomStates`)

Per-canvas state that persists only within a session:
- Selection
- Undo history

### MCP Canvas Tools

Claude Code can manage canvases programmatically:

| Tool | Purpose |
|------|---------|
| `create_canvas` | Create a new canvas at a path (e.g., `"Projects/Dashboard"`) |
| `create_folder` | Create a folder. Parent folders are auto-created if needed |
| `create_structure` | Batch create entire folder/canvas hierarchies in one call |
| `get_canvases` | List all canvases and folders with their IDs and paths |
| `rename_canvas` | Rename a canvas |
| `rename_folder` | Rename a folder (updates all nested canvas paths) |
| `move_canvas` | Move a canvas to a different folder |
| `move_folder` | Move a folder to a different parent |
| `duplicate_canvas` | Copy a canvas with all elements and images |
| `delete_canvas` | Delete a canvas (undoable) |
| `delete_folder` | Delete a folder and ALL contents (undoable) |
| `import_figma` | Import a Figma file by URL: supports full file, specific pages, or a selection subtree (opens browser sign-in when needed) |
| `list_figma_pages` | List pages in a Figma file (lightweight metadata fetch, no canvasId needed) |

**Batch structure creation:** Use `create_structure` to scaffold entire projects:

```
create_structure path="" children=[
  {"type": "folder", "name": "App", "children": [
    {"type": "canvas", "name": "Home"},
    {"type": "canvas", "name": "Settings"}
  ]}
]
```

**Using canvasId:** `init()` returns `canvasId` in the session context. The path IS the canvasId. Use it in ALL element operations:

```
# Canvas path from context: "Projects/Dashboard"
create_modify_elements canvasId="Projects/Dashboard" elements=[{type: "rectangle", x: 100, y: 100, width: 200, height: 100}]
execute_commands canvasId="Projects/Dashboard" commands=[{commandId: "set_width", elementIds: ["xyz"], params: {value: 200}}]
```

**Why this matters:** The user may switch canvases at any time. If you pass `canvasId`, your operations continue on the correct canvas without disrupting the user's view. If you omit `canvasId`, operations target whatever canvas the user is currently viewing (which may have changed).

**Per-canvas undo:** Each canvas maintains its own undo history. Cross-canvas operations register undo on the target canvas.

**All operations work cross-canvas:** every element tool (create, modify, delete, group, align, move, distribute, reorder, reparent, auto layout, duplicate, export) accepts `canvasId`. No `switch_canvas` is required for element operations.

**See also:** The Delegation section in CLAUDE.md covers multi-canvas workflows and `create_structure`.

### Folders

| Action | Shortcut |
|--------|----------|
| Create folder | Cmd+Shift+N |
| Toggle expand/collapse all folders | Cmd+Shift+C |

Folder context menu (right-click in file explorer):
- Rename, Delete, Duplicate
- Cut, Copy, Paste
- New Canvas, New Folder (inside this folder)
- Expand, Collapse, Expand All, Collapse All
- Reveal in Finder, Copy Relative Path, Copy Absolute Path
- Move canvases between folders (drag and drop, multi-select supported)
- Nest folders inside other folders

Per-folder color tags: appending a color suffix to a folder or canvas name colors its icon and breadcrumb. Supported suffixes: `.red`, `.green`, `.yellow`, `.orange`, `.purple`, `.pink`, `.gray`. Without a suffix the default is blue. For example, naming a folder `Components.purple` displays a purple icon. The suffix is hidden from the displayed name and is preserved through renames.

### File Explorer

The file explorer lives in the **left toolbar**. Focus it with **Cmd+Shift+E** (command id `focus_canvas_explorer`). The Layers explorer (canvas's element tree) sits below it; focus it with **Cmd+Shift+R**. Toggle the whole left toolbar visibility with **Cmd+Shift+Left Arrow**. The file explorer shows all canvases, folders, asset (image) files, and other text/code files in the workspace as a tree.

**Layout (top to bottom):**
1. "Files" header with toolbar buttons (right-aligned): Toggle All Folders (expand/collapse all), New Folder (Cmd+Shift+N), New Canvas (Cmd+N), Toggle Canvas Search (Cmd+P)
2. Workspace tree: folders (with disclosure triangle), canvases (`.design`), images, text files
3. Below the file explorer: the Layers explorer (focus with Cmd+Shift+R) shows the element tree of the active canvas

**Selection:**
- Click an item to select it (and switch to it if it's a canvas or previewable file)
- **Cmd+click** to add or remove an item from the selection
- **Shift+click** to select a range from the anchor to the clicked item; previously Cmd-selected items are pinned and stay selected
- Selection works across canvases, folders, and assets simultaneously (used for batch move and bulk delete)

**Keyboard navigation (when explorer is focused):**

| Key | Action |
|-----|--------|
| Arrow Up / Down, J / K | Move navigation focus |
| Arrow Left / Right, H / L | Collapse / expand folder |
| Space, O | Open / switch to the focused item (canvas, image, or text file) |
| Enter | Start inline rename on the focused item |
| Escape | Clear navigation focus or cancel a rename / cut-paste |
| Cmd+A | Select all visible items in the explorer |
| Tab | Move focus from the file explorer to the layers explorer |
| gg | Jump to the top of the list (press G twice within 500ms; vim-style) |
| Shift+G | Jump to the bottom of the list |
| Cmd+Backspace, Cmd+Delete | Delete the selected canvas/folder/asset |
| Cmd+N | New canvas inside the focused folder |
| Cmd+Shift+N | New folder inside the focused folder |
| Cmd+C / Cmd+X / Cmd+V | Copy / cut / paste canvases or folders |
| Ctrl+N / Ctrl+P | Move navigation focus down / up (vim/emacs style) |

**Renaming:**
- **Double-click** the item name to rename inline
- Press **Alt+Enter** while a canvas is focused (works in or out of the explorer) to rename it
- Press **Escape** to cancel a rename

**Drag-and-drop:**
- Drag a canvas or folder onto another folder to move it
- Multi-select then drag to move several items at once (single undo entry covers the batch)
- Drag image files from Finder onto the explorer to import them as assets

**Toggle Hidden Files:** show/hide dotfiles and dotfolders (e.g. `.git`, `.env`) via the command palette ("Toggle Hidden Files"). Hidden by default. State persists across app restarts.

**Git integration:** in a Git repository, files matching `.gitignore` are dimmed in the explorer and can be excluded from search.

### Top Toolbar (Workspace + Save Status)

Centered in the window, the top toolbar shows the active file's location as breadcrumbs:

```
Workspace / Folder / Subfolder / CanvasName
```

- The canvas-name segment supports double-click to rename inline
- Hovering the breadcrumb reveals a "Copy Path" button that copies the absolute path of the active `.design` file (or asset/text file) to the clipboard
- Save status indicator: while a canvas has unsaved changes (or a save is in flight), its name in the breadcrumb renders at 0.6 opacity; once auto-save completes it returns to 0.9 opacity. There is no separate save chip or progress spinner.
- The breadcrumb itself is the window-drag area: click and drag to move the window when not maximized or fullscreen

### Asset Management

Image files live in `Assets/` folders next to canvases. Each folder level can have its own `Assets/` directory.

**Asset operations** (right-click in file explorer):
- Rename: automatically updates all references to the asset across every `.design` file in the workspace
- Delete: checks for references first; warns if the image is used by any canvas, then moves it to `.brilliant/trash/` (recoverable via undo)
- **Reveal in Finder**
- **Copy Filename**

**Other asset behavior:**
- `Assets/` folders are shown in the explorer even when empty (as long as the directory exists on disk)
- **Clean Up Unused Assets** command (Command Palette) removes images not referenced by any canvas; the cleanup is undoable
- File watcher detects external changes (drop a new image into `Assets/` from Finder and it appears in the explorer)

### Previews

Clicking a non-canvas file in the file explorer (or navigating to it with Alt+Arrow) enters a **preview mode** that replaces the canvas view:

| File type | Preview |
|-----------|---------|
| Image (PNG, JPG, JPEG, GIF, BMP, WebP; on macOS also TIFF/TIF, HEIC, HEIF, AVIF) | Full-size image preview, centered |
| Text/code (JS, TS, JSX, TSX, Python, Dart, HTML, CSS, JSON, YAML, Markdown, Rust, C/C++, Go, Swift, SQL, Shell/Bash/Zsh, XML, TOML, INI, plain text, `.styles`, **`.svg`**) | Built-in code editor (CodeMirror 6) with syntax highlighting and optional vim mode |
| Unknown file types | Sniffed: text content shows in the code editor, binary shows an unsupported placeholder |

**Note:** `.svg` opens in the code editor (as XML text), not as an image preview. To use an SVG as a design element, import it via Cmd+Shift+O or paste it on the canvas - both convert SVG into native editable vector elements.

The file explorer highlights the active preview row the same way it highlights active canvases. To return to a canvas, click it in the explorer or use Alt+Arrow to navigate. Text files larger than 5 MB are loaded as read-only.

## Import & Export

### Importing Files

| Action | Shortcut |
|--------|----------|
| Import from file | Cmd+Shift+O |
| Paste from clipboard | Cmd+V |
| Drag and drop | Drag image files onto canvas |

**Cmd+Shift+O** opens a file picker that accepts images, SVG files, and `.design` files. The import behavior depends on file type:
- **Images** (PNG, JPG, JPEG, GIF, BMP, WebP; on macOS also TIFF, HEIC, HEIF, AVIF) become rectangle elements with an image fill
- **SVG** files are imported as native editable vector elements
- **`.design` files** are imported into an `Imports/` folder (auto-detects native YAML vs. legacy compressed JSON format)

### Importing from Figma

Brilliant can import designs directly from Figma files via the Figma API, with support for importing entire files, specific pages, or individual selections.

| Method | How |
|--------|-----|
| Command palette | Search "Import from Figma" |
| Right toolbar | Paste URL in Figma Import section |
| MCP / agent | `execute_commands` with `commandId: "import_figma"` or `"list_figma_pages"` |

**Manual (UI):** The right toolbar Figma Import section lets you:
1. Paste a Figma URL
2. If the URL contains a node selection (`?node-id=...`), a "Selection only" checkbox appears (checked by default): imports only that subtree
3. Click the config button (gear icon) to fetch and display available pages, then select which pages to import
4. Selecting a page unchecks "Selection only"; re-checking "Selection only" clears page selections

**Programmatic (agent):** use `execute_commands`. No `canvasId` is needed:

```json
{
  "commands": [{
    "commandId": "import_figma",
    "params": { "figmaUrl": "https://www.figma.com/design/FILE_KEY/File-Name" }
  }]
}
```

`figmaUrl` accepts a full Figma URL or just a file key. Returns `fileName`, `canvasIds` (the created canvas paths), and `warnings`.

**Filtering options** (optional `params`):

| Param | Type | Description |
|-------|------|-------------|
| `nodeId` | string | Import only the subtree under this node (auto-extracted from URL's `?node-id=` if present) |
| `pageIds` | array of strings | Import only pages matching these IDs |
| `pageNames` | array of strings | Import only pages matching these names |

**Listing pages before import:** Use `list_figma_pages` to discover available pages:

```json
{
  "commands": [{
    "commandId": "list_figma_pages",
    "params": { "figmaUrl": "https://www.figma.com/design/FILE_KEY/File-Name" }
  }]
}
```

Returns `{ "pages": [{ "id": "0:1", "name": "Page 1" }, ...] }`. Use the returned IDs/names with `import_figma`'s `pageIds`/`pageNames` to import a subset.

**Multi-page files** create a folder named after the Figma file, with one canvas per Figma page. Single-page files import onto the current canvas (if empty) or create a new top-level canvas.

**Authentication:** if the user has not signed in to Figma, the command automatically opens a browser for Figma OAuth sign-in. The agent should mention that a sign-in page is opening. If the user cancels or closes the browser, the command returns an error; retry the command.

### Importing SVG Files

SVG files import as native editable vector elements:

| Method | How |
|--------|-----|
| Command palette | Search "Import SVG" |
| Paste | Copy SVG text, paste with Cmd+V |
| File import | Cmd+Shift+O, select .svg file |

**Supported SVG elements:** rect, circle, ellipse, line, path, polygon, polyline, text, g (groups)

**Preserved properties:** fills, strokes, gradients, transforms, hierarchy. Groups become frames.

### Exporting Elements

Export selected elements (or whole canvases) via the command palette, the right-toolbar Export section, or the `mcp__brilliant__export` MCP tool.

How to export:
1. Select target elements (or focus a canvas / folder)
2. Cmd+E for PNG, or open the command palette (Cmd+Shift+P) and search "Export to..."
3. Or expand the Export section in the right toolbar inspector to configure format, resolution, fit mode, and background

| Format | Shortcut | Notes |
|--------|----------|-------|
| PNG | Cmd+E | Lossless, alpha supported |
| JPEG | Command palette | Lossy, no alpha; default quality 90 |
| WebP | Command palette | Lossy default (q=90). Pass `webpLossless: true` (MCP) for clean rounded corners on UI mockups |
| SVG | Command palette | Vector: paths, shapes, text |
| PDF | Command palette | Vector document format |
| MP4 / MOV | Command palette | Animated export with selectable codec (H.264, HEVC, ProRes 4444) and quality |
| Replay | Command palette | Animated reveal of the selection element-by-element; output container is MP4 or MOV |

Right-toolbar export options:

| Option | Description |
|--------|-------------|
| Format | PNG, JPEG, WebP, SVG, PDF, MP4, MOV, Replay |
| Resolution | Original, 720p, 1080p, 1440p, 4K, 8K, Instagram Post, Instagram Story, iPhone 16 Pro, MacBook Pro 14", Custom |
| Fit mode | Fit, Fill, Stretch, Repeat |
| Background | Transparent or Canvas (when format supports alpha) |
| Constrain proportions | Lock aspect ratio when entering custom dimensions |
| Video options | Duration, FPS, codec, quality (video/replay formats only) |
| Replay options | Per-element pace (ms/element), intro text, output container (MP4/MOV) |

Multiple export configs can be added to a single element to export at multiple scales or formats in one action.

Notes:
- PNG and WebP support alpha; JPEG fills transparent areas with the canvas background color
- HEVC and ProRes 4444 video codecs support alpha; H.264 does not
- SVG and PDF preserve vector paths and stay sharp at any scale

### Importing from Sketch

`.sketch` files import as native canvases.

| Method | How |
|--------|-----|
| Command palette | "Import Sketch File" (`import_sketch`) |

### Exporting to Sketch

Export the focused canvas or folder as a `.sketch` file:

| Action | How |
|--------|-----|
| Save as Sketch | Command palette: "Save as Sketch File" (`save_as_sketch`) |

Exports elements, fills, strokes, gradients, text, and images. Components and effects may simplify to flattened equivalents.

### Design Files

Brilliant uses `.design` files for saving and sharing.

| Action | Shortcut | Description |
|--------|----------|-------------|
| Save As... | Cmd+Shift+S | Save current canvas or focused item as a `.design` file + Assets folder |
| Open folder | Cmd+O | Open a folder as a design workspace |
| Copy canvas path | Hover top toolbar, click copy icon | Copies the full `.design` file path to clipboard |

**In repository mode**, `.design` files contain element properties, hierarchy, and canvas metadata. Images are stored separately in `Assets/` directories and referenced by path.

**Save As `.design` files** (created via Cmd+Shift+S) save the native YAML `.design` file along with an `Assets/` folder containing all referenced images. Image paths in the YAML are rewritten to relative `Assets/filename` references, making the package portable for sharing.

### File Organization

- Single canvas: Save As (Cmd+Shift+S) exports the `.design` YAML file plus an `Assets/` folder with referenced images
- Folder with canvases: Save As (Cmd+Shift+S) when a folder is focused exports the entire folder hierarchy (all `.design` files, subfolders, and referenced images) to a chosen directory

### Reveal in Finder

When working with a design repository (folder-based workspace), you can reveal the actual `.design` files on disk:

| Action | How to Access |
|--------|---------------|
| Reveal canvas file | Right-click canvas in explorer, select "Reveal in Finder" |
| Reveal folder | Right-click folder in explorer, select "Reveal in Finder" |

This opens Finder and selects the `.design` file or folder, useful for:
- Sharing specific canvas files
- Version control operations
- Backup and archival

**Note:** Only available in repository mode (when you've opened a folder as a workspace).

### Auto-Save

Brilliant auto-saves continuously. There is no Cmd+S; you do not need to save manually for normal use.

- **Repository mode** (folder workspace): `.design` files are saved directly into the repository folder, mirroring the explorer hierarchy on disk
- **Scratch mode**: work is auto-saved to `~/.config/brilliant/scratch/`

**Behavior:**
- Each change starts a 500 ms debounce timer; if no further edits arrive in that window, the active canvas is written to disk in a background isolate (so saves never block interaction)
- The save captures element state, hierarchy, fills/strokes/effects, components, design system bindings, ruler guides, zoom, pan, and per-canvas background settings
- The dirty indicator is the **canvas name's opacity** in the top toolbar breadcrumb: dimmed while there are unsaved changes (or a save is in flight), full opacity once the canvas is up to date on disk
- On app quit (and on workspace switch) all dirty canvases are flushed before the app exits/reopens
- If a `.design` file fails to load (corrupt YAML, schema mismatch), Brilliant blocks saves on that canvas to avoid overwriting good data with empty/partial state

**Save As (Cmd+Shift+S):**

Cmd+Shift+S exports the focused canvas or folder as a portable `.design` package: the YAML file plus a sibling `Assets/` folder containing all referenced images. Image paths in the YAML are rewritten to relative `Assets/filename` references. This is for sharing or archiving and does not replace auto-save, which always runs in the background.

---

## Workspaces

A **workspace** is a folder on disk that Brilliant uses as a design repository. It contains `.design` files (canvases), subfolders, and assets.

### Workspace Structure

```
my-workspace/
├── .brilliant/             # Workspace settings and trash
│   ├── settings.json       # Per-workspace configuration
│   └── trash/              # Undo recovery for deleted canvases/folders
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

### Workspace Modes

| Mode | Description |
|------|-------------|
| **Repository mode** | You've opened a named folder (Cmd+O). Files live in that folder on disk. |
| **Scratch mode** | Default when no folder is open. Work is stored in `~/.config/brilliant/scratch/`. |

**Switching modes:**
- **Cmd+O** opens a folder as a workspace (enters repository mode)
- Brilliant remembers your last workspace and reopens it on startup

### .design Files

Each canvas is stored as a `.design` file: a YAML-based format (currently `version: 3`) containing:
- A leading comment header in compact "blueprint" form: gives an AI a fast read of IDs, types, fills, strokes, sizing, and hierarchy without parsing the YAML body
- All element properties and hierarchy
- Canvas metadata (zoom, pan position, background, ruler guides)
- Embedded image references (pointing to `Assets/` directories)

Files are written deterministically (stable key order, inline coordinate arrays, hex color strings) for clean version control diffs. Older `.design` files are migrated transparently on load (short IDs, circle start angles).

### Assets

Images are stored in `Assets/` directories at each folder level:
- Root images: `workspace/Assets/`
- Folder images: `workspace/Components/Assets/`
- Nested: `workspace/Components/Buttons/Assets/`

When you import an image (Cmd+Shift+O), it's saved to the appropriate Assets directory. Renaming an asset automatically updates all references in `.design` files.

### .brilliant/ Folder

The `.brilliant/` directory at the workspace root contains:
- `settings.json`: per-workspace configuration
- `trash/`: recovery directory for deleted canvases, folders, and assets (supports undo)

### Deletion and Recovery

Deletes are **never destructive**: Brilliant moves the file to `.brilliant/trash/` instead of erasing it, and registers an undo entry that puts it back.

| What you delete | Where it goes |
|-----------------|---------------|
| Canvas | `.brilliant/trash/<path-with-underscores>.design` |
| Folder (with all contents) | `.brilliant/trash/<path-with-underscores>/` |
| Asset (image) | `.brilliant/trash/` with a unique filename |
| Last canvas in the workspace | A new empty "Canvas" is created automatically; the original goes to trash and undo restores both |

**Undo from the file explorer:** Focus the file explorer (Cmd+Shift+E) and press **Cmd+Z** to undo the last canvas/folder/asset operation (delete, rename, create, move, batch-move). The explorer has its **own** undo stack, separate from each canvas's per-canvas undo history.

**Permanent cleanup:** Trash is not auto-cleared. To free space, delete `.brilliant/trash/` from Finder when you're confident you no longer need to recover anything.

### Recent Workspaces

Brilliant tracks recently opened workspaces (up to 20). On startup, it reopens the most recently used named workspace (scratch is excluded from this list).

### Recent Canvases & Files

Within a workspace, Brilliant keeps two recency lists:
- Recent canvases: surfaces in `Cmd+P` canvas search (recent canvases score higher)
- Recent files: unified list across canvases, images, and text files; surfaces in `Cmd+K` global search and drives `Alt+Right` / `Alt+Left` navigation order. `Ctrl+Alt+Left` jumps back to the previously active canvas (canvases only).

Both lists persist across app restarts (stored in `SharedPreferences`).

### Code Editor

Clicking a text file in the file explorer opens it in Brilliant's built-in **code editor** (powered by CodeMirror 6). The editor replaces the canvas view while a text file is active.

**Supported file types:** JavaScript, TypeScript, JSX/TSX, Python, HTML, CSS, JSON, YAML, Markdown, Rust, C/C++, Java, Kotlin, Dart, Go, Swift, SQL, Shell/Bash, XML/SVG, TOML/INI/conf, and plain text. Design-system source files under `Styles/` (`*.styles`) open with DSL highlighting; the generated artifacts under `Styles/.gen/` (`*.gen.yaml`) open with YAML highlighting.

**Features:**
- **Syntax highlighting** with VS Code Dark+/Light+ themes (auto-matches Brilliant's brightness)
- Vim mode: full vim keybinding support via `@replit/codemirror-vim`. Auto-loads config from `~/.config/nvim/init.vim`, `~/.config/nvim/init.lua`, or `~/.vimrc` (custom key mappings; settings like `relativenumber`, `expandtab`, `tabstop`)
- Search and Replace: Cmd+F opens the search panel
- Diff viewing: side-by-side merge view for comparing changes
- File navigation: Alt+Right/Left switches between files; Ctrl+Alt+Left jumps to the previously active file
- Vim mode indicator: shows the current vim mode (Normal/Insert/Visual) in the top toolbar when active

The code editor is particularly useful for editing the design system DSL (`.styles` files under `Styles/` folders) directly. The `.gen.yaml` files under `Styles/.gen/` open with YAML highlighting; treat them as read-only since they regenerate from the DSL source.

### .styles File Watching

Brilliant watches for changes to `.styles` files (design system tokens) in your workspace. If you edit a `.styles` file externally (e.g., in a code editor), Brilliant automatically regenerates the sibling `.gen.yaml`. This makes it easy to keep design tokens in sync with code.

---

## Collaboration & Sharing

Brilliant is a single-user desktop application. There is no real-time multiplayer editing, share links, or cloud sync.

### Sharing with Others

| Goal | How |
|------|-----|
| **Share for viewing** | Export as PNG/SVG/PDF (see [EXPORT.md](./EXPORT.md)) and send the file |
| **Share editable designs** | Share the `.design` file. The recipient needs Brilliant to open it |
| **Share a full workspace** | Share the workspace folder (all `.design` files, Assets, `.styles`) |
| **Developer handoff** | Right-click → Copy As → CSS/SVG/PNG, or use Alt+hover for measurements |

### Version Control with Git

`.design` files are YAML-based and written deterministically, producing clean diffs. Recommended Git workflow:

1. Open a folder as workspace (Cmd+O); this is the Git repository root
2. Each canvas is a separate `.design` file (changes are per-file)
3. Images in `Assets/` directories are referenced by canvases
4. Right-click then "Reveal in Finder" locates any canvas or folder on disk
5. Commit, branch, and merge as with any code project

The `.brilliant/` folder at the workspace root contains settings and trash. Include it in version control for consistency.

### No Version History Panel

Undo is per-canvas and within-session only: undo history does not persist across app launches. For persistent version history, use Git or an OS backup solution (Time Machine on macOS).

## Related

- [EXPORT.md](./EXPORT.md): export and import details
- [CROP.md](./CROP.md): image crop mode
- [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md): design tokens and `.styles` files
