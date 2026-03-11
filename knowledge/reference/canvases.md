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
| Next file (canvas or image) | Alt+→ |
| Previous file (canvas or image) | Alt+← |
| Previously active file | Ctrl+Alt+← |
| Focus active canvas in explorer | Cmd+Shift+K |
| Search and select canvas | Cmd+P |

**Undo behavior:** Each canvas has its own independent undo history. Switching canvases is not undoable — Cmd+Z on the new canvas undoes that canvas's last action, not the switch. When the file explorer is focused, Cmd+Z undoes canvas/folder operations (rename, create, delete, reorder) separately from canvas operations.

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
| `import_figma` | Import a Figma file by URL — supports full file, specific pages, or selection (opens browser sign-in if needed) |
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

**Using canvasId:** `init()` returns `canvasId` in the session context — this path IS the canvasId. Use it in ALL element operations:

```
# Canvas path from context: "Projects/Dashboard"
create_modify_elements canvasId="Projects/Dashboard" elements=[{type: "rectangle", x: 100, y: 100, width: 200, height: 100}]
execute_commands canvasId="Projects/Dashboard" commands=[{commandId: "set_width", elementIds: ["xyz"], params: {value: 200}}]
```

**Why this matters:** The user may switch canvases at any time. If you pass `canvasId`, your operations continue on the correct canvas without disrupting the user's view. If you omit `canvasId`, operations target whatever canvas the user is currently viewing (which may have changed).

**Per-canvas undo:** Each canvas maintains its own undo history. Cross-canvas operations register undo on the target canvas.

**All operations work cross-canvas** — every element tool (create, modify, delete, group, align, move, distribute, reorder, reparent, auto layout, duplicate, export) accepts `canvasId`. No `switch_canvas` needed for any element operation.

**See also:** The Delegation section in CLAUDE.md covers multi-canvas workflows and `create_structure`.

### Folders

| Action | Shortcut |
|--------|----------|
| Create folder | Cmd+Shift+N |
| Expand/collapse all folders | Cmd+Shift+C |

Folder operations (via right-click in file explorer):
- Rename, Delete, Duplicate
- Cut, Copy, Paste
- New Canvas, New Folder (within the folder)
- Expand / Collapse, Expand All / Collapse All
- Reveal in Finder, Copy Relative Path, Copy Absolute Path
- Move canvases between folders (drag and drop)
- Nest folders inside other folders

### File Explorer

In the left toolbar (Cmd+Shift+E). Shows all canvases, folders, and Assets directories in a tree view.

**Features:**
- Multi-selection (Shift/Cmd click) for canvases and folders
- Right-click context menu on canvases, folders, and assets
- Keyboard navigation (arrow keys, j/k/h/l)
- Enter to rename, Cmd+Delete to delete
- Double-tap to rename (canvases, folders, and assets)
- Next/previous file (Alt+Arrow) navigates through canvases AND images

**Asset management** (image files in Assets folders):
- Right-click context menu: Rename, Delete, Reveal in Finder, Copy Filename
- Renaming an asset automatically updates all references in `.design` files
- Deleting checks for references first — warns if the image is used by canvases
- Assets folders are shown even when empty (as long as the directory exists on disk)
- **Clean Up Unused Assets** command (via Command Palette) removes images not referenced by any canvas

### Image Preview

Clicking an image in the file explorer (or navigating to it with Alt+Arrow) enters **image preview mode**: the canvas shows the image full-size. The file explorer highlights the active image row the same way it highlights active canvases.

To return to a canvas, click any canvas in the file explorer or use Alt+Arrow to navigate.

## Import & Export

### Importing Images

| Action | Shortcut |
|--------|----------|
| Import from file | Cmd+K |
| Paste from clipboard | Cmd+V |
| Drag and drop | Drag image files onto canvas |

**Supported formats:** PNG, JPG, JPEG, GIF, BMP, WebP, SVG

Images become rectangle elements with an image fill.

### Importing from Figma

Brilliant can import designs directly from Figma files via the Figma API, with support for importing entire files, specific pages, or individual selections.

| Method | How |
|--------|-----|
| Command palette | Search "Import from Figma" |
| Right toolbar | Paste URL in Figma Import section |
| MCP / agent | `execute_commands` with `commandId: "import_figma"` or `"list_figma_pages"` |

**Manual (UI):** The right toolbar Figma Import section lets you:
1. Paste a Figma URL
2. If the URL contains a node selection (`?node-id=...`), a "Selection only" checkbox appears (checked by default) — import just that subtree
3. Click the config button (gear icon) to fetch and display available pages — select which pages to import
4. Selecting a page unchecks "Selection only"; re-checking "Selection only" clears page selections

**Programmatic (agent):** Use `execute_commands` — no `canvasId` needed:

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

**Authentication:** If the user hasn't signed in to Figma yet, the command automatically opens a browser for Figma OAuth sign-in. Let the user know a sign-in page will open. If they cancel or close the browser, the command returns an error — just try again.

### Importing SVG Files

SVG files import as native editable vector elements:

| Method | How |
|--------|-----|
| Command palette | Search "Import SVG" |
| Paste | Copy SVG text, paste with Cmd+V |
| File import | Cmd+K, select .svg file |

**Supported SVG elements:** rect, circle, ellipse, line, path, polygon, polyline, text, g (groups)

**Preserved properties:** fills, strokes, gradients, transforms, hierarchy. Groups become frames.

### Exporting Elements

Export selected elements to various formats. Select elements first, then export.

**How to export:**
1. Select the elements you want to export
2. Use the command palette (Cmd+Shift+P) and search for "Export to..."
3. Or use the Export section in the right toolbar inspector

| Format | Shortcut | Notes |
|--------|----------|-------|
| PNG | Cmd+E | Lossless with transparency support |
| JPEG | Command palette | Lossy compression (90% quality default) |
| WebP | Command palette | Modern format, smaller file sizes |
| SVG | Command palette | Vector format for paths, shapes, text |
| PDF | Command palette | Document format, preserves vectors |

**Export options (in right toolbar):**

| Option | Description |
|--------|-------------|
| Scale | 1x, 2x, 3x, etc. Higher scales = larger file, more detail |
| Format | PNG, JPEG, WebP, SVG, PDF |

**Background options:**
- **Clear** - Transparent background (PNG/WebP only)
- **Window** - Uses the window/canvas background color
- **Desktop** - Uses desktop background

**Tips:**
- PNG supports transparency; JPEG does not (transparent areas become white)
- Use 2x scale for retina/high-DPI displays
- SVG/PDF preserve vector paths and are infinitely scalable
- Multiple export configs can be added to export at different scales simultaneously

### Importing from Sketch

Brilliant can import `.sketch` files:

| Method | How |
|--------|-----|
| Command palette | Search "Import Sketch File" |
| Right toolbar | Sketch Import section (expand to browse for file) |

### Exporting to Sketch

Export canvases or folders as `.sketch` files for use in Sketch app:

| Action | How to Access |
|--------|---------------|
| Export canvas or folder | Command palette: "Save as Sketch File" (exports the focused canvas or folder) |

Exports elements, fills, strokes, gradients, text, and images.

### Design Files

Brilliant uses `.design` files for saving and sharing.

| Action | Shortcut | Description |
|--------|----------|-------------|
| Save as | Cmd+Shift+S | Save current canvas |
| Save workspace as | Cmd+Ctrl+S | Save all canvases and folders |
| Open folder | Cmd+O | Open a folder as a design workspace |
| Copy canvas path | Hover top toolbar, click copy icon | Copies the full `.design` file path to clipboard |

**In repository mode**, `.design` files contain element properties, hierarchy, and canvas metadata. Images are stored separately in `Assets/` directories and referenced by path.

**Portable `.design` files** (created via Save As or Save Workspace As) additionally embed all referenced images inline (deduplicated and compressed), making them self-contained for sharing.

### File Organization

- **Single canvas** — Save as `.design` with Cmd+Shift+S
- **Folder with canvases** — Save entire folder hierarchy as one file
- **Full workspace** — Save everything with Cmd+Ctrl+S

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

Brilliant auto-saves continuously:
- **Repository mode** (folder workspace): `.design` files are saved directly to the repository folder
- **Scratch workspace**: Work is auto-saved to `~/.config/brilliant/scratch/`

**Save behavior:**
- Changes are saved automatically as you work
- No manual saving needed for normal use
- Captures all element state, zoom, pan, and canvas metadata
- Save status indicator appears in the top toolbar next to the canvas name

**Manual save options:**
- **Cmd+S** - Save workspace to a folder (in scratch mode, opens a folder picker to create a repository)
- **Cmd+Shift+S** - Save current canvas as a portable `.design` file
- **Cmd+Ctrl+S** - Save entire workspace as a single `.design` file

These "Save As" options create portable files you can share or archive, separate from the auto-saved working copies.

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
- **Cmd+S** in scratch mode opens a folder picker to save the workspace to a named location (converts to repository mode)
- Brilliant remembers your last workspace and reopens it on startup

### .design Files

Each canvas is stored as a `.design` file — a YAML-based format containing:
- All element properties and hierarchy
- Canvas metadata (zoom, pan position)
- Embedded image references (pointing to Assets/ directories)

Files are written deterministically for clean version control diffs.

### Assets

Images are stored in `Assets/` directories at each folder level:
- Root images: `workspace/Assets/`
- Folder images: `workspace/Components/Assets/`
- Nested: `workspace/Components/Buttons/Assets/`

When you import an image (Cmd+K), it's saved to the appropriate Assets directory. Renaming an asset automatically updates all references in `.design` files.

### .brilliant/ Folder

The `.brilliant/` directory at the workspace root contains:
- **settings.json** — Per-workspace configuration
- **trash/** — Recovery directory for deleted canvases and folders (supports undo)

### Recent Workspaces

Brilliant tracks recently opened workspaces (up to 20). On startup, it reopens the most recently used named workspace (scratch is excluded from this list).

### .styles File Watching

Brilliant watches for changes to `.styles` files (design system tokens) in your workspace. If you edit a `.styles` file externally (e.g., in a code editor), Brilliant automatically regenerates the design system. This makes it easy to keep design tokens in sync with code.

---

## Collaboration & Sharing

Brilliant is a single-user desktop application — there is no real-time multiplayer editing, share links, or cloud sync.

### Sharing with Others

| Goal | How |
|------|-----|
| **Share for viewing** | Export as PNG/SVG/PDF (see [EXPORT.md](./EXPORT.md)) and send the file |
| **Share editable designs** | Share the `.design` file — the recipient needs Brilliant to open it |
| **Share a full workspace** | Share the workspace folder (all `.design` files, Assets, `.styles`) |
| **Developer handoff** | Right-click → Copy As → CSS/SVG/PNG, or use Alt+hover for measurements |

### Version Control with Git

`.design` files are YAML-based and written deterministically, producing clean diffs. Recommended Git workflow:

1. **Open a folder as workspace** (Cmd+O) — this is your Git repository
2. Each canvas is a separate `.design` file — changes are per-file
3. Images in `Assets/` directories are referenced by canvases
4. **Right-click → Reveal in Finder** to locate any canvas or folder on disk
5. Commit, branch, and merge like any code project

The `.brilliant/` folder at the workspace root contains settings and trash — include it in version control for consistency.

### No Version History Panel

Undo is per-canvas and within-session only — undo history does not persist when you close the app. For persistent version history, use Git or your OS backup solution (e.g., Time Machine on macOS).

## Related

- [EXPORT.md](./EXPORT.md) — Detailed export and import documentation
- [CROP.md](./CROP.md) — Image crop mode
- [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md) — Design tokens and .styles files
