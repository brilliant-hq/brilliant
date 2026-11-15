---
name: "knowledge-canvases-workspaces"
description: "Workspaces: the folder layout, repository and scratch modes, .bl files, and Assets folders."
assumes: reference/canvases
---

# Workspaces

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

From a terminal, `open -a Brilliant <folder>` does the same as Cmd+O, whether or not Brilliant is running: the folder opens as a workspace and joins your recents. It takes a folder holding `.bl` files, or an empty folder to start a new project; any other folder (or a system folder) is not opened, and a note says why. An agent connected over MCP can open a folder the same way by passing its absolute path as `project` (the folder opens in the background, so it never takes over your screen).

The home screen always offers a **Scratch** row for that sandbox. If you do not want it there, its "…" menu's **Remove from list** puts it away: the scratch files stay on disk untouched, and the row returns if Brilliant opens the scratch workspace again (it does when there is no other project to open).

## `.bl` files

Each canvas is a `.bl` file: a Blueprint (`bp:v1`) document with a small YAML header for canvas settings (background, ruler guides, design-system binding). A canvas's identity is its path within the workspace (without `.bl`), so renaming or moving a canvas changes its identity, and references update accordingly. Files are written deterministically for clean version-control diffs. Legacy files still open: YAML-format content migrates to Blueprint on its next save, and legacy `.design` / `.styles` extensions are renamed to `.bl` / `.ds` when the workspace opens (originals preserved under `.archive/`).

## Assets

Images live in `Assets/` directories at each folder level (root, per-folder, nested). Importing an image (Cmd+Shift+O) saves it to the appropriate `Assets/`. Renaming an asset updates all references automatically.
