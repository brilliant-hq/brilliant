---
name: "knowledge-canvases"
description: "Canvas and folder management, the file explorer, workspaces, import/export, auto-save, and version control in Brilliant, operated by hand."
---

# Canvases

A Brilliant workspace is a folder on disk. Each canvas is a single `.bl` file inside it; folders are real directories. There is no separate project index. The directory tree is the project tree.

## Managing Canvases

### Creating and deleting

| Action | Shortcut |
|--------|----------|
| New canvas | Cmd+N |
| Duplicate current canvas | Cmd+Ctrl+N |
| New folder | Cmd+Shift+N |
| Delete active canvas | Cmd+Shift+Del (the forward-delete key / Fn+Delete on Mac keyboards without a dedicated Del; Cmd+Shift+Backspace does not trigger it) |
| Rename active canvas | Alt+Enter |

Cmd+N inside the file explorer creates the canvas inside the focused folder; otherwise it goes to the workspace root. Same for Cmd+Shift+N (new folder).

### Switching between files

| Action | Shortcut |
|--------|----------|
| Next file (canvas, image, or text) | Alt+Right (Cmd+Alt+Right while the text editor is focused; plain Alt+arrow is word motion there) |
| Previous file | Alt+Left (Cmd+Alt+Left in the text editor) |
| Previously active canvas | Ctrl+Alt+Left |
| Reveal/focus active canvas in explorer | Cmd+Shift+K |
| Search and switch canvas | Cmd+P |
| Global search (canvases, images, text files) | Cmd+K |
| Search layers in active canvas | Cmd+L |
| Search chats | Cmd+Shift+I |
| Command palette | Cmd+Shift+P |

Switching canvases is instant and not undoable. Each canvas keeps its own independent undo history; Cmd+Z on a canvas undoes that canvas's last action. When the file explorer is focused, Cmd+Z routes to a separate explorer undo stack covering rename, create, delete, move, and reorder of canvases and folders.

Switching announces itself when the new canvas is still loading: if content does not appear almost immediately (a heavy canvas, a slow first paint), the canvas area briefly dims with a subtle shimmer rather than leaving the old canvas showing, and clears the instant the new content is on screen. Fast switches (the normal case) never flash it.

Per-canvas state saved into the `.bl` file: element data, hierarchy, fills/strokes/effects, components, design-system bindings, background settings, ruler guides, zoom, and pan position. Selection and undo history live only for the session.

### Folders

| Action | Shortcut |
|--------|----------|
| Create folder | Cmd+Shift+N |
| Toggle expand/collapse all folders | Cmd+Shift+C |

Right-click a folder in the file explorer for: Rename, Delete, Duplicate, Cut, Copy, Paste, New Canvas, New Folder (inside this folder), Expand/Collapse/Expand All/Collapse All, Reveal in Finder, Copy Relative Path, Copy Absolute Path. Folders can be nested, and canvases can be dragged between them (multi-select supported).

### Copy and paste between projects

The explorer clipboard travels across projects: copy (or cut) canvases, folders, or asset files in one project, switch to another project's tab, and paste.

- **Canvases** arrive with their content. Image assets they use are copied into the destination (renamed on a name clash, never overwriting a destination file). Referenced brand `.ds` files come along on pastes between local projects; if the destination already defines a brand with that name, the destination's definition wins. When a cloud project is on either side, the brand file cannot travel yet: the canvas arrives with default styles and a note says so.
- **Folders** travel as a whole tree: canvases, subfolders, assets, and other files keep their layout, and references inside the copied tree keep working. Anything the tree referenced from outside it (say a root-level asset) is copied in too.
- **Cut** moves: once the paste lands, the originals go to the source project's trash (recoverable, like any delete).
- Name clashes always keep both; the pasted copy gets a numbered name.
- **Pasting several items at once** shows a small progress note (the item being copied and how far along, like "3 of 8"). When it finishes cleanly the note is replaced by a short confirmation naming where the items landed: "Pasted N items to {project}" (or "Moved N items to {project}" for a cut). If some items could not be pasted, you get an honest note about what did not land instead of a false success.
- **Pasting into a project you can only view** is refused up front with a short view-only note, and nothing is written (no half-finished paste).
- Works between local and cloud projects in any direction (local to cloud, cloud to local, cloud to cloud). Anything that can't travel is named in an honest note instead of failing silently.

**Color tags:** append a color suffix to a folder or canvas name to color its icon and breadcrumb. Supported suffixes: `.red`, `.green`, `.yellow`, `.orange`, `.purple`, `.pink`, `.gray` (or `.grey`). Without a suffix the icon is blue. Example: naming a folder `Components.purple` shows a purple icon. The suffix is hidden from the displayed name and preserved through renames.

### Canvas identity and the "belongs to another project" refusal

Every canvas has an identity that the platform mints for the project it lives in. A canvas's name (and its path) is just a label on that identity: renaming or moving a canvas keeps the same identity. This is what lets the app tell your canvas apart from a look-alike in another project.

Copying a canvas **through an app door** (the cross-project paste above, or Duplicate) mints a fresh identity for the copy automatically, with a pointer back to the original. You never have to think about it.

Copying a `.bl` file **outside the app** is the one case to know about. If you copy a `.bl` from one project's folder into another (in Finder, with `git`, or any external editor), the file still carries the source project's identity, so the app refuses to sync it with a short "this canvas belongs to another project" note rather than silently filing your content in the wrong place. The fix is one click: **Adopt into this project**, which keeps a copy here with a fresh identity. A fresh file an external editor writes (one that never belonged to another project) is accepted normally, no note.

**For agents:** the refusal code is `file_foreign_identity` (a 422 on save). The self-serve remedy is the declared-copy flag (`duplicate: true` on a `/save`, `dup` on the live wire), surfaced to people as "Adopt into this project", which mints a new identity with provenance to the source. A separate code, `identity_required`, means a live edit was sent without its canvas identity; that is an app bug, not something a user or agent action fixes.

## File Explorer

The file explorer lives in the **left toolbar**. Focus it with **Cmd+Shift+E**. The Layers explorer (the active canvas's element tree) sits below it; focus it with **Cmd+Shift+R**. Toggle the whole left toolbar with **Cmd+Shift+Left**. The explorer shows all canvases (`.bl`), folders, image assets, and other text/code files in the workspace as a tree. Canvas (`.bl`) and design-system (`.ds`) names display without their extension.

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
| Cmd+Backspace / Cmd+Delete | Delete selected canvas/folder/asset (multi-select deletes are one undo entry) |
| Cmd+N / Cmd+Shift+N | New canvas / folder inside the focused folder |
| Cmd+C / Cmd+X / Cmd+V | Copy / cut / paste canvases or folders |
| Ctrl+N / Ctrl+P | Move focus down / up (vim/emacs style) |

**Renaming:** double-click the name to rename inline, or press Alt+Enter while a canvas is focused (works in or out of the explorer). Escape cancels.

**Drag-and-drop:** drag a canvas or folder onto another folder to move it; multi-select then drag to move several at once (one undo entry). Drag image files from Finder onto the explorer to import them as assets.

**Toggle Hidden Files:** show/hide dotfiles and dotfolders (e.g. `.git`, `.env`) via the command palette ("Toggle Hidden Files"). Hidden by default; the choice persists across restarts.

**Git decoration:** in a Git repository, files matching `.gitignore` are dimmed in the explorer.

## Top Toolbar (Workspace + Save Status)

Centered in the window, the top toolbar shows the active file's location as breadcrumbs: `Workspace / Folder / Subfolder / CanvasName`.

The top strip (the "island") also carries a **home** slot and one **tab** per open project to the left of the breadcrumb; the breadcrumb here belongs to the active project's tab. See `ui.md` for the home surface and project tabs.

- Double-click the canvas-name segment to rename inline
- Hover the breadcrumb to reveal a Copy Path button that copies the absolute path of the active file
- Save status is shown by the canvas name's brightness: dimmed while there are unsaved changes or a save is in flight, brighter once saved. There is no separate save chip or spinner.
- The breadcrumb area is the window-drag handle (when not maximized/fullscreen)

## Previews and the Code Editor

Clicking a non-canvas file in the explorer (or navigating to it with Alt+Arrow) replaces the canvas view with a preview:

| File type | Preview |
|-----------|---------|
| Image (PNG, JPG, JPEG, GIF, BMP, WebP; on macOS and Windows also TIFF/TIF, HEIC, HEIF, AVIF) | Centered image at natural size (large images scale down to fit) on an opaque viewer surface |
| Text/code (JS, TS, JSX, TSX, Python, Dart, HTML, CSS, JSON, YAML, Markdown, Rust, C/C++, Java, Kotlin, Go, Swift, SQL, Shell/Bash/Zsh, XML, TOML, INI, plain text, `.ds`, `.gen.yaml`, `.svg`) | Built-in code editor |
| Unknown types | Sniffed: text shows in the editor, binary shows an unsupported placeholder |

File previews fully replace the canvas view and never disturb it: the canvas viewport (zoom and pan) is exactly where you left it when you switch back. While a preview is open, the right toolbar (property inspector) and the drawing-tool cluster hide, leaving the AI input available.

`.svg` opens in the code editor as XML text, not as an image. To use an SVG as a design element, import it (Cmd+Shift+O) or paste it on the canvas; both convert it into native editable vector elements.

The code editor replaces the canvas while a text file is active. Features:
- Syntax highlighting (dark/light theme auto-matched to Brilliant's brightness)
- Vim mode; auto-loads config from `~/.config/nvim/init.vim`, `~/.config/nvim/init.lua`, or `~/.vimrc`. A mode indicator (Normal/Insert/Visual) appears in the top toolbar when active.
- Cmd+F search and replace; side-by-side diff/merge view
- Alt+Right/Left switches files (Cmd+Alt+Right/Left from inside the focused text editor, where plain Alt+arrow is word motion); Ctrl+Alt+Left jumps to the previously active file

Text files larger than 5 MB open read-only, showing the first 5 MB behind a banner. If a file open in the editor changes on disk (for example an agent rewrites it), Brilliant reconciles it rather than losing work: with no unsaved edits it reloads and shows a passive notice; with unsaved edits it cancels the pending autosave and raises an actionable notice (Reload / Keep mine) so your edits are never silently overwritten.

Design-system source files (`*.ds` under `Styles/`) open with DSL highlighting; generated `*.gen.yaml` under `Styles/.gen/` open with YAML highlighting and should be treated as read-only (they regenerate from the source). For editing design tokens, see [design-systems.md](./design-systems.md).

## Asset Management

Image files live in `Assets/` folders next to canvases. Each folder level can have its own `Assets/` directory.

Right-click an asset in the explorer for:
- **Rename**: automatically updates every reference to the asset across all `.bl` files
- **Delete**: warns first if the image is used by any canvas, then moves it to `.brilliant/trash/` (recoverable via undo)
- **Reveal in Finder**
- **Copy Filename**

Other behavior:
- `Assets/` folders show in the explorer even when empty (if the directory exists on disk)
- **Clean Up Unused Assets** (command palette) removes images not referenced by any canvas; undoable
- A file watcher keeps the explorer live against external changes: an agent or git creating, deleting, renaming, or moving `.bl` files, folders, or assets on disk shows up within about a second, no repo reopen needed. Bursts (a `git checkout` touching many files) apply as one batch. Regaining app focus also runs a quick rescan as a safety net.
- If the OPEN canvas's `.bl` file changes on disk, it reconciles like the text editor: with no unsaved edits the canvas reloads (selection and camera preserved) and shows a passive notice; with unsaved edits auto-save pauses for that canvas and an actionable notice offers Reload / Keep mine, so neither side is silently overwritten. If the open canvas's file is deleted externally, Brilliant lands on a surviving canvas.

## Import & Export

### Importing files

| Action | Shortcut |
|--------|----------|
| Import from file | Cmd+Shift+O |
| Paste from clipboard | Cmd+V |
| Drag and drop | Drag image files onto the canvas |

Cmd+Shift+O opens a picker that accepts images, SVG files, and design files (`.bl`, plus legacy `.design`):
- **Images** (PNG, JPG, JPEG, GIF, BMP, WebP; on macOS and Windows also TIFF, HEIC, HEIF, AVIF) become rectangle elements with an image fill. On Windows, HEIC/HEIF and AVIF need the free Microsoft Store codec packs ("HEIF Image Extensions" / "AV1 Video Extension"); without them the import shows a card naming the missing pack
- **SVG** imports as native editable vector elements
- **Design files** (`.bl`, legacy `.design`) are imported into an `Imports/` folder

### Importing from Figma

Brilliant imports from Figma files via the Figma API, supporting whole files, specific pages, or a single selection subtree.

**By hand (right toolbar Figma Import section):**
1. Paste a Figma URL
2. If the URL contains a node selection (`?node-id=...`), a selection-only toggle (icon button, tooltip "Import selected elements only") appears unchecked; click it to import just that subtree instead of the whole file
3. Click the config (gear) button to fetch and list the file's pages, then choose which pages to import
4. Selecting a page clears the selection-only toggle; enabling it clears page selections

Or run "Import from Figma" from the command palette.

Multi-page files create a folder named after the Figma file with one canvas per page. Single-page files import onto the current canvas (if empty) or a new top-level canvas.

The section works the same in the desktop app and in the browser editor on any project you can edit. Connecting Figma differs only in where sign-in happens: the desktop app opens a browser and continues the import when you return; the browser editor shows a Connect Figma button that signs you in and brings you back to the same project with the pasted link still there. Cancelling leaves the canvas untouched, so you can retry any time.

**What comes across:** frames, groups, and auto layout (including wrap and its cross-axis row gap); components and instances (a component's slot property becomes a native Brilliant slot, and each instance's slot content lands as content the instance owns); vectors and shapes; text with case, decoration (underline, strikethrough), and vertical alignment; fills and strokes including per-side widths, dashes, join, and miter; masks and boolean shapes; tiled and cropped images with their color adjustments. Missing fonts warn and fall back to a bundled font, so the text still lands.

**Known gaps for URL import (REST API):** design-system tokens and liquid-glass parameters do not come across. Colors and spacing import as literal values rather than links to tokens, and glass is not exposed over Figma's REST API. To bring design-system variables and glass across, use the Brilliant Figma plugin instead: copy in Figma with the plugin, then paste (Cmd+V) into Brilliant.

**Brilliant checks the file first.** When you start a URL import, Brilliant runs one quick look at the file before the full download. If it finds features the URL path would lose (library components from a shared team library, liquid glass, or fonts it cannot serve), it stops and shows a card naming what this file would lose, with counts where it knows them ("3 library components will flatten to plain frames", "glass effects will use default parameters", a named font "will render on a fallback font"). From that card you can jump to the fuller Figma plugin or import anyway. A file with none of those markers imports straight through as before, and if the quick look cannot run (no connection yet, an unreadable link), the import simply proceeds; the check never blocks it.

**Migrating a whole file (plugin path):** the plugin's "Import file to Brilliant" streams every page of a Figma file into a NEW Brilliant project named after the file, one canvas per page, in page order. In the desktop app the new project is **local-only** (a folder under your Brilliant projects directory), whether or not you are signed in: an import lands on your machine and stays yours, and publishing it to the cloud is a separate, deliberate choice you make later. In the browser editor, where there is no local disk, the new project is a cloud project. Empty pages mint no canvas and are skipped; Brilliant's import card counts only the pages that carry content and says so when it finishes ("32 pages imported, 16 empty pages skipped"), so a short tally is never a gap. Two things always come with it:

- **A "Migration report" canvas**, written into the same project and sitting last in the canvas list. It says what arrived (pages, elements), what degraded (each page's import warnings, with counts), and what needs attention. It is always written, warnings or not, and re-importing the file rewrites that one canvas in place rather than adding another.
- **A note about components from other Figma files.** Components you pull from a team library import as local copies in the new project (Brilliant never reaches into the library file for you). The report names each library component and how many instances use it, so you can import that library file too and relink, or relink by hand.

**The file's design system becomes the project's design system.** The variables and styles the file carries land as the new project's `default` design system: the one every canvas resolves through with nothing to select. A project created by importing a Figma file therefore has exactly one design system, the imported one: no starter system sitting beside it, no design-system tag on the imported frames restating which one they use, and anything you create in that project speaks the same tokens by default. Re-importing the file updates that same design system in place. A project that already has a design system of its own is never overwritten: there the imported system lands beside it, the way a page or selection import always does.

**You can keep working while a file imports.** Pages you are not looking at are built and written without ever entering the editor, so the app stays yours: click, use shortcuts, pan and zoom the canvas, switch canvases and projects. The whole run reports itself on one import card in the notification rail, which names the file, the pages landed out of the pages coming, and what is happening right now ("landing Homepage", or "receiving the next page (6.0 MB)") so you can tell a slow page from a stuck one. It appears when the first page lands and stays until the run finishes, naming any page that failed with a Retry. That covers a page that never got as far as landing, too: if the import stumbles reaching the project itself, the page it was holding is named on the card with its own Retry and stays named even after the rest of the run recovers, so a run that lost one page can never read as a clean import. If nothing arrives for a few minutes the card says so and tells you the import may still be running in the background. If saving falls behind while the import runs, that has its own tile on the same rail.

The one thing that does change on screen: if the import refreshes the canvas you are currently looking at, that canvas dims for the seconds the new page takes to land, the same way a slow canvas switch does. It clears by itself.

**You can import just the pages you want.** The plugin's panel lists every page in the file with a checkbox, all checked, so one click still imports the whole file. Uncheck what you do not need and the button follows you ("Import 12 of 48 pages"); a file with more than a dozen pages also gets a filter box, and the checkbox above the list selects or clears whatever the filter is showing. Filtering only changes what you see, never what you picked. Your picks are remembered per file, so reopening the panel on a file you have narrowed before comes back narrowed, with any page added since checked.

A partial import is not a partial file. Each page keeps its place in the original page order, so the canvas it lands on is exactly the canvas a full import would have made: importing 3 pages now and the other 45 later gives the same project as importing all 48 at once, and re-importing a handful of pages refreshes only those canvases and leaves every other one alone. All the counting follows the pages you picked, so a 3-page import finishes at 3 of 3.

**You can choose where the pages land.** By default each page becomes its own canvas in the project. Above the page list the panel also offers "Combine all pages onto one canvas": every page you picked lands on a single canvas named after the file, each page as its own labeled frame (named after the page) tiled left to right in page order, with its contents parented inside so nothing overlaps ambiguously. Your choice is remembered per file. It works the same whether Brilliant is the desktop app or the browser editor, and whether the plugin reached it over the local connection or the cloud.

Re-importing behaves differently in the two places, and the panel says which you are getting when the run finishes. On the **desktop app**, re-importing converges the same way per-page canvases do, one frame at a time: a page you import again replaces just its own frame in place, and a page you leave out keeps its frame untouched. In the **browser editor** there is no project folder on disk to remember which frame came from which page, so a re-import adds the pages beside the ones already there rather than refreshing them, and the completion line tells you so. Nothing is ever overwritten or lost either way, and a frame you made by hand is never touched by an import.

This control appears only when the connected Brilliant understands it: an older app imports one canvas per page as before. If you had asked to combine and the connection changes to one that cannot, the plugin stops and says so instead of quietly importing separate canvases; import again to land each page as its own canvas.

**A single selection can land on the current canvas.** Alongside "Send to Brilliant" the plugin offers "Send to current canvas": the selection lands on the canvas you are looking at (aggregating with what is already there) instead of routing to a new canvas, which is the default. Like the whole-file control, it appears only when the connected Brilliant understands it.

**The panel tells you how it ended.** While the run streams it counts pages; when it closes it waits a moment for Brilliant to confirm the last landings, then says one of two things. Either every page arrived ("All 32 pages imported", with an "Open in Brilliant" button that brings the project forward), or it names what did not: "31 of 32 imported, 1 page did not arrive: Cover", keeping that page's row on screen with a Retry that re-sends just that page. The header above it always reconciles: "48 of 48 pages selected, 16 empty pages skipped". A late arrival still counts, so a run that ended partial can turn into a complete one while you watch.

**To stop an import, use the Figma plugin panel.** Its "Cancel import" button stops the run at the next page boundary, keeping every page already sent. Brilliant deliberately shows no Cancel of its own: there is no way for it to tell the plugin to stop, so a button here would do nothing.

**Components import once.** A component lands on the canvas for the Figma page it lives on, and instances on every other page reference that one master across canvases, exactly as in Figma: edit the master and every page follows. Re-importing the file keeps that one master rather than growing a second copy. The one exception is a component set too large for the plugin to ship whole (over 200 variants, an icon library): each page then carries the variants it uses, and the import says so.

**The design system comes with it (plugin path):** a plugin paste brings the file's design system across as a real Brilliant system, not flattened literals. Variables keep their Figma names, each multi-mode collection becomes a mode axis (a light/dark collection drives the theme toggle), and shared styles become tokens; bound nodes come in referencing those tokens instead of baked values, and any losses are named in the import warnings. See `reference/design-systems` ("Importing a Design System from Figma") for the full story.

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

### Save As / sharing a `.bl` package

| Action | Shortcut | What it does |
|--------|----------|--------------|
| Save As... | Cmd+Shift+S | Export the focused canvas or folder as a portable `.bl` package |
| Open folder | Cmd+O | Open a folder as a workspace |

Save As writes the native `.bl` file plus a sibling `Assets/` folder with all referenced images; image paths are rewritten to relative `Assets/filename` references so the package is portable. When a folder is focused, Save As exports the entire folder hierarchy. This is for sharing/archiving and does not replace auto-save.

## Auto-Save

Brilliant auto-saves continuously. There is no Cmd+S and you never need to save manually for normal use.

- **Repository mode** (a folder opened with Cmd+O): `.bl` files are written directly into the workspace folder, mirroring the explorer hierarchy on disk
- **Scratch mode** (no folder open): work is auto-saved to `~/.config/brilliant/scratch/`

Behavior:
- Shortly after you stop editing, the active canvas is written in the background so saves never block interaction
- The save captures element state, hierarchy, fills/strokes/effects, components, design-system bindings, ruler guides, zoom, pan, and background settings
- The dirty indicator is the canvas name's opacity in the top toolbar breadcrumb
- If a save fails (permissions, a full disk, a cloud project offline), the canvas stays queued and Brilliant keeps retrying on a widening interval, the dirty indicator stays on, and a held notice says the edits have not reached disk yet. Work is never dropped or shown as saved when it is not
- On quit and on workspace switch, all dirty canvases are flushed first, including any whose earlier save failed
- If a `.bl` file fails to load (corrupt content, schema mismatch), saves on that canvas are blocked so good data is never overwritten with empty state

### Recovered files (a few damaged lines)

If a `.bl` file has a small number of damaged lines (for example, an incomplete write or an edit that left one row unreadable), Brilliant now opens the rest of the file instead of failing the whole canvas. The damaged lines, and anything nested under them, are left out, and a banner tells you how many lines could not be read and which ones. A related case opens even more completely: a file written by a NEWER version of Brilliant can carry properties this version does not know yet. Every element stays visible with the properties this version understands, nothing is left out at any count, and the unknown bits stay safely in the file: the same recovered state applies, so nothing rewrites them behind your back, and saving a repaired copy strips them only if you ask.

While a file is in this recovered state:

- **Auto-save is paused for it.** The original file on disk is never changed, so nothing is lost while you decide what to do.
- The banner offers two choices:
  - **Save repaired copy**: writes a new file next to the original ("Name (repaired)") containing everything that loaded, without the damaged lines, and switches you to it. The original file is left exactly as it was.
  - **Dismiss**: keeps the file open in the recovered state (auto-save stays paused). You can still copy work out of it manually.

If a file is damaged beyond a few lines (most of it is unreadable), Brilliant treats it as it does any unreadable file: it blocks saves so the original is preserved, rather than opening a mostly-empty canvas.

## Workspaces

A workspace is a folder on disk Brilliant uses as a design repository: `.bl` files (canvases), subfolders, and assets.

```
my-workspace/
├── .brilliant/             # Workspace settings and trash
│   ├── settings.json       # Per-workspace configuration
│   └── trash/              # Undo recovery for deleted canvases/folders/assets
├── Assets/                 # Root-level images
├── Homepage.bl             # Canvas files (Blueprint)
├── Components/
│   ├── Assets/             # Folder-level images
│   ├── Button.bl
│   └── Card.bl
└── Pages/
    ├── Dashboard.bl
    └── Settings.bl
```

| Mode | Description |
|------|-------------|
| Repository mode | A named folder is open (Cmd+O); files live there on disk |
| Scratch mode | Default with no folder open; stored in `~/.config/brilliant/scratch/` |

Cmd+O opens a folder as a workspace. Brilliant remembers the last workspace and reopens it on startup. It tracks up to 20 recent workspaces (scratch excluded).

The home screen always offers a **Scratch** row for that sandbox. If you do not want it there, its "…" menu's **Remove from list** puts it away: the scratch files stay on disk untouched, and the row returns if Brilliant opens the scratch workspace again (it does when there is no other project to open).

### `.bl` files

Each canvas is a `.bl` file: a Blueprint (`bp:v1`) document with a small YAML header for canvas settings (background, ruler guides, design-system binding). A canvas's identity is its path within the workspace (without `.bl`), so renaming or moving a canvas changes its identity, and references update accordingly. Files are written deterministically for clean version-control diffs. Legacy files still open: YAML-format content migrates to Blueprint on its next save, and legacy `.design` / `.styles` extensions are renamed to `.bl` / `.ds` when the workspace opens (originals preserved under `.archive/`).

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

A workspace is local by default. Once **published** (a project bound to the cloud, marked by `.brilliant/cloud.json`), the folder stays continuously synced with its cloud project.

A project can also be **cloud-only**: it lives entirely on the server with no folder on this machine. Opening one you can edit gives an ordinary project tab that edits and saves exactly like a local workspace, except nothing is written to disk (no `.bl` files, no assets). Because there is no folder, the disk-coupled affordances are absent: reveal-in-Finder, drag-and-drop moves, and opening the folder in git. Everything else (canvases, explorer, editing, checkpoints, sharing) behaves the same.

A cloud-only tab is **live**: it joins the project's realtime session like the browser editor does. Collaborators' edits, cursors, and selections appear as they happen, canvases created, renamed, or deleted elsewhere show up in the explorer, and if the canvas you are on is deleted remotely the tab lands on another canvas with a notice. When the connection drops, editing continues and saves go directly to the cloud; live sync resumes on its own. If the project is deleted or your access ends, the tab says so plainly and stops syncing; close it when you are done reading.

A **synced folder** whose cloud project goes away (deleted, or your access revoked) is never stranded: the folder simply becomes a local project again. A notice says the project was removed from the cloud and that your local copy is kept; if the folder had turned view-only, editing unlocks immediately, right where you are, with no restart and nothing to close. From then on it behaves like any local project, and you can publish it again whenever you like.

**Live cursors in a busy room.** A single project shows up to 25 people's cursors live at once. If you join past that, you still have full edit rights and you still see everyone, but your own cursor is hidden for the others for now, and a small notice tells you so ("This room is at its presence limit, so your cursor is hidden for now. You can still edit and you still see everyone."). As soon as a slot frees, your cursor comes back on its own. This applies wherever you are live, a cloud-only tab or a published folder open on your machine.

Pasting or importing an **image** into a cloud project uploads it in the background, treated as a first-class save: a large upload shows an "Uploading images" progress notification, the save indicator stays dim until every image reaches the cloud, and a failed upload surfaces as a sync error naming the file (never silently dropped or shown as synced). On desktop, an image still uploading when you quit finishes on the next open; on the web, closing the tab warns you while an upload is in progress (a tab has no local copy to resume from).

**Opening a project you cannot edit.** Whether you can edit a cloud or synced project follows one rule: your current account must have edit permission on it (local-only projects are always editable). A project you can only view opens **view-only**: the canvas opens normally and you can pan, zoom, select, inspect, copy, and export everything, but nothing can be changed, and its tab and home tile carry a view-only eye badge (see [ui.md](./ui.md)). An edit attempt is refused honestly, never a silent dead drag. On a cloud project, the first edit attempt raises a **View-only** notice with the ways forward: when you are signed in, **Fork it** (make a copy you own, opened right where you are and carrying any changes you had started) or **Open in playground** (try changes on a throwaway copy); when you are signed out, **Log in** (in case you already have edit access on another account) or **Open in playground**. Right after you open a project shared with you, your access can take a moment to confirm, and until it does your role is not yet known. If the canvas is already up and you try to edit in that instant, the attempt reads as **Checking your access…** (a brief spinner, no Fork offer) rather than a view-only verdict; where the editor is still finishing loading, it simply opens once your access has settled, so you are never shown a confidently-wrong view-only verdict before your role is known. It settles on its own the moment access resolves: the tab unlocks if you can edit, or shows the ways forward above if you cannot. If Brilliant cannot reach the server to confirm, it says so and stays view-only until it can. Signing in, or switching to an account that can edit, turns the same tab editable in place, right where you are, with nothing reloaded. Signing out does the reverse: your open cloud and synced projects become view-only where they stand, with no tab closed and no work lost (the eye appears), and signing back in re-derives your access. To keep an independent, editable local copy of a cloud project instead, use **Duplicate as local project** on its home "…" menu.

| Goal | How |
|------|-----|
| Share for viewing | Export PNG/SVG/PDF and send the file ([export.md](./export.md)) |
| Share an editable design | Send the `.bl` file; the recipient needs Brilliant |
| Share a full workspace | Share the workspace folder (canvases, Assets, `Styles/`) |
| Share a live link | Publish the project, then copy its link |
| Developer handoff | Right-click → Copy As → CSS/SVG/PNG, or Alt+hover for measurements |

### Published-folder cloud sync

In a published folder the design projection (`.bl` + `.ds` + referenced assets) syncs both ways automatically: edits made in the app OR by an agent editing the files on disk push to the cloud (debounced), and changes made elsewhere are fetched and applied. It never stomps an unsaved local file. When both sides changed the same canvas, the app merges element by element so both sides' work is kept (the previous cloud version is preserved as a checkpoint and a notification reports the merge); when a merge is not possible it keeps your local version live and checkpoints the server version, with a notification. This sync is separate from git: **the app folder never runs git**, so an agent may use git in the folder normally (the git/GitHub lane is independent).

**When both sides are you.** A conflict notice and a preserved checkpoint mean someone else's work was in the mix. If both sides are your own account (your second machine, or the desktop app and the web editor signed in as you), the two surfaces converge quietly: your work is combined with no conflict warning and no extra checkpoint. The findable checkpoint and the notice are reserved for when another person's content is involved, so a solo person working across two of their own surfaces no longer sees conflict noise or a pile of automatic checkpoints.

### Version control with Git

`.bl` files are deterministic text, producing clean diffs. Open the folder as a workspace (Cmd+O); each canvas is a separate file, and `Assets/` images are referenced by canvases. Commit, branch, and merge as with any code project. Include `.brilliant/settings.json` for consistent settings (but not `.brilliant/trash/` or `.brilliant/sync-state.json`, which are local-only).

A **published** project has a version-history panel on the web: its **History** page (`brilliant.design/{handle}/{project}/history`) lists every checkpoint (named and automatic) and lets the owner restore any of them, whole-project or a single canvas. A **local, unpublished** folder has no such panel: undo there is per-canvas and within-session only, so use Git or an OS backup (Time Machine) for persistent local history.

**A restore wins at engage.** Restoring a checkpoint is a deliberate rewind, so it takes precedence over unsynced local edits. If you restore a project on the web and then open (or already have open) that project's synced folder on your machine with local work that never reached the cloud, the restore takes over on disk and your local version is kept safely in the folder's sync trash (`.brilliant/trash/sync/`). A notice says exactly what happened, for example "A cloud restore replaced Home.bl. Your local version was kept in this folder's sync trash." Nothing is silently discarded: the restore wins the tie, and your earlier local bytes stay on that machine if you want them back.

## Related

- [export.md](./export.md): export and import details
- [crop.md](./crop.md): image crop mode
- [design-systems.md](./design-systems.md): design tokens and `Styles/` files
- [ui.md](./ui.md): toolbars, panels, command palette
