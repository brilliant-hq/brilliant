---
name: "knowledge-canvases-recovery"
description: "Where deleted canvases, folders and assets go, explorer undo, Show in Finder, and the recency lists."
assumes: reference/canvases
---

# Deletion, Recovery and Recents

## Deletion and recovery

Deletes are never destructive: Brilliant moves the file to `.brilliant/trash/` and registers an undo entry that restores it.

| What you delete | Where it goes |
|-----------------|---------------|
| Canvas | `.brilliant/trash/` |
| Folder (with all contents) | `.brilliant/trash/` |
| Asset (image) | `.brilliant/trash/` |
| The last canvas in the workspace | A new empty "Canvas" is created automatically; the original goes to trash |

To undo a file-tree operation, focus the explorer (Cmd+Shift+E) and press Cmd+Z. The explorer has its own undo stack, separate from each canvas's per-canvas history. Trash is not auto-cleared; delete `.brilliant/trash/` from Finder to reclaim space.

## A canvas that empties on its own is never saved empty

If a canvas that holds a design is suddenly empty and nothing you or an agent did emptied it (no delete, no Clear All Elements, no undo), Brilliant refuses to save the empty canvas: the design file on disk keeps the whole design and a copy goes to the project's recovery folder, so the design is not lost. Emptying a canvas on purpose (select all and delete, Clear All Elements from the canvas right-click menu or the palette, an undo, or an agent's delete) saves normally. Clear All Elements has no keyboard shortcut, so a stray key can never empty a canvas.

## A design-system edit is never saved over a cloud copy it did not start from

In a cloud project, an edit to a design-system file (from the design-system editor or an agent's `ds` fence) is saved over the cloud copy only when Brilliant knows the edit was made on that copy, or when it merges cleanly with what changed there. When it cannot be sure (someone changed the same lines, or the cloud copy could not be read), the edit is not saved: the cloud file is left as it is, your edit stays on screen, the agent's fence answers that the save was refused, and in the desktop app a copy goes to the recovery folder. Further edits to that file stay on screen and are not saved either. The latest version is copied to the recovery folder again when you close the project tab or quit.

## Where recovery copies live

When sync keeps another version over one of your edits, or a canvas file on disk was cut short, your version is saved as a recovery copy in `<config home>/recovery/<project hash>/` (the config home is `~/.config/brilliant` by default). The folder is outside the project folder, so nothing that wipes the project can take the copy with it, and you will not find it by browsing the project. In the desktop app, a sync notification that says a copy was saved in "the recovery folder" carries **Show in Finder** (**Show in Explorer** on Windows), which opens that folder, and **Copy path** beside it, which copies the folder's full path. The card for a canvas file that was cut short carries the same buttons when it kept your open canvas and saved a copy. In the browser there is no local folder, so these notifications have neither button.

When the folder grows past its budget, older copies of a canvas are packed into `<config home>/recovery/<project hash>.archive/`, where each is kept byte for byte. A notification's **Show in Finder** and **Copy path** put the copy it names back in the folder first. To reach any other copy, ask an agent: `restore_recovery_copy` lists every copy of the project, packed or not, and puts the one you name back in the folder (`blueprint/commands`).

## Show in Finder

Right-click a canvas or folder in the explorer and choose "Show in Finder" ("Show in Explorer" on Windows) to locate the actual file on disk (useful for sharing, version control, or backup). Available in repository mode.

Every notification that names a file or folder on this computer (an export, a project made local, a scratch copy, a project made available offline, a folder that is in the way) carries **Copy path** beside its **Show in Finder** button. Copy path puts the full path on the clipboard, the button reads "Copied" for a moment, and the notification stays up. A notification about something that only lives in the cloud has neither button.

## Recents

Within a workspace, Brilliant keeps two recency lists, both persisted across restarts:
- Recent canvases: boost Cmd+P canvas search
- Recent files: a unified list across canvases, images, and text files; drives Cmd+K global search and Alt+Right / Alt+Left order. Ctrl+Alt+Left jumps to the previously active canvas.
