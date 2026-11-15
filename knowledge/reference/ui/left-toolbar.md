---
name: "knowledge-ui-left-toolbar"
description: "The left toolbar: the nav rail tabs (Files, Assets, Checkpoints, Project), the project header, the participants cluster, and the File Explorer with its extensions, conversions, keys, and explorer undo."
assumes: reference/ui
---

# Left Toolbar

The left panel sits beside the **nav rail**, the narrow strip at the window's far left (see "The nav rail" in `reference/ui`), and shows one rail tab at a time:

- **Files**: the **File Explorer** (top) and **Layers Explorer** (bottom) in a vertically split layout. Drag the divider between them to resize each one's share of the panel height.
- **Assets**: the components of this project and its libraries, and the components sheet you place them from. See "Assets View" in `reference/ui` and the full walkthrough in `reference/libraries/assets`.
- **Checkpoints**: the project's saved versions (see "Checkpoints" below).
- **Project**: the project settings pages (General, Access, Libraries, Fonts, Design system, Danger zone), each shown in the main area beside the panel; **App settings** at the foot of the list opens the app's Settings. See `reference/ui/project-settings`.

Drag the panel's inner (right) edge to resize its width. Toggled off (Toggle Left Toolbar, Cmd+Shift+←, the palette, or a click on the rail tab already showing), the panel hides and only the rail stays; the same shortcut, or any rail tab, brings it back.

**The project header** sits at the top of the panel on every tab: the project's name, and under it where the project lives and who can see it ("Private · Personal", or "This Mac · Personal" for a project only on this computer). Click the name to rename the project. The chevron beside the name opens the project menu: Rename, Duplicate as local project, Share… (or Publish… for a project not published yet), Show in Finder (Show in Explorer on Windows), Copy Canvas Path, Copy Canvas URL, Copy Link to Selection, Create Checkpoint and Project settings…, each only where it applies. Click the line under the name to open the Project tab on its Access and publishing page. On a free plan, your name and a **Free** chip sit at the foot of the panel.

The header holds a live-collaboration participants cluster on the left. While your pointer is over the panel, the participants row waits to appear or disappear until the pointer leaves, so rows never move under a click. When neither applies, the header takes no space and the File Explorer starts at the top of the panel. (Your own account avatar and the copy-link button used to sit here too; they now live in the right toolbar's header; see `reference/ui/right-toolbar`. The old team chip is gone; team identity lives in the home avatar's account menu and Settings -> Account.)

There is no sync-status indicator in this header. Sync health surfaces only when it is bad, as a notification plus a red notification dot on the top island (see `reference/ui/top-toolbar`).

- **Participants cluster:** in a live collaboration session, the other people on the project appear as avatars on the left of the header. Each shows the person's photo (or a colored initial) and their name on hover; colors match their live cursors. Click a member to open their profile in a new tab. One avatar per person, even when they have several windows or tabs open. Absent when you are working solo.

| Action | Shortcut |
|--------|----------|
| Toggle left toolbar | Cmd+Shift+← |
| Focus file explorer | Cmd+Shift+E |
| Focus layers explorer | Cmd+Shift+J |

## File Explorer

Tree of all canvases, folders, and asset files in the workspace. Features: folder expand/collapse, multi-selection (Cmd/Shift+Click), right-click context menu, drag/drop reorder and reparent, inline renaming (double-click or Cmd+R), keyboard navigation, type-to-filter. Hidden files (`.foo`) are gated by the Show Hidden Files command. In the browser, where the project lets you manage files, you can drag canvases, folders and files into a folder (or onto empty space for the top level) to move them, one undo step per drag; a move the server refuses says why and moves nothing after it. Cut, Copy and Paste work there too, from the right-click menu or with Cmd+X / Cmd+C / Cmd+V while the file explorer is focused: a cut item moves on Paste the same way a drag moves it, and a copied canvas pastes as a new canvas. In the browser only canvases can be copied: a plain file or a folder offers Cut but no Copy or Duplicate, and a selection holding one offers neither. **Agents at work.** A canvas's row shows a small bar at its right end, in the agent's color, for each agent editing that canvas right now (up to three); a collapsed folder holding such a canvas shows a shorter bar per agent. While any agent edits a canvas of this project, the rail's **Files** tab carries a violet dot. This covers agents in Brilliant's own chat and external agents connected over MCP (Claude Code, Cursor and the like) alike, a canvas you have not opened included. Hover the bars to see who is editing ("Claude is editing · Landing page", "Claude Code (MCP) is editing", "2 agents editing · ..."); click them to open that agent's chat. An external agent has no chat here, so its bars are not clickable. An agent in Brilliant's chat clears the moment it finishes; an external agent never tells Brilliant it is done, so its bars and dot stay for a while after its last call: about a minute and a half after its last edit, about 15 seconds when it only read.

Canvas files (`.bl`) and design-system files (`.ds`) display **without** their extension (e.g. `rip figma`, `default`), the way Finder and Figma hide known design-file extensions. Inline rename, though, shows the **full filename** with just the basename selected, so the extension is visible and you can change it on purpose. Changing a canvas's extension is an honest **conversion**, confirmed Finder-style: rename a `.bl` to `.txt` and it becomes a plain text file that opens in the code editor (the prompt lets you keep `.bl` instead); rename a text file to `.bl` and it becomes a canvas, but only if its contents are a valid Blueprint (otherwise the rename is refused and the file is left untouched). A plain rename never changes the extension by accident. Conversions work in synced projects too: the change travels to the cloud as a rename, so collaborators see the file convert rather than vanish. On a cloud-only project tab (no folder on this machine) the conversion is refused with a note pointing you to Make available offline first. Asset files keep their extension everywhere (`hero.png`, `notes.md`). The real filename on disk always carries the extension; paths and ids are unchanged.

**File type changes in the browser.** In the browser editor the conversion works too, with the same Keep / Use choice: the new file is saved and checked first and the original is removed only after that, so a failure never loses content; a collaborator's last edit made just before the change is carried into the new file. While the live connection is reconnecting the change is refused ("Can't change the file type while reconnecting. Try again in a moment."), and Undo converts the file back the same way.

**Canvas preview on hover.** Rest the pointer on a canvas row for half a second and a card opens beside the panel: the canvas's thumbnail, its name, "folder · canvas · 6 frames", its first four top-level frames, and "2 more frames" when there are more (a canvas with no top-level frame shows its element count instead, such as "3 elements"). Click a frame in the card to open the canvas zoomed to that frame. You can move the pointer into the card; it stays open while you are over it. Moving to another canvas row swaps the card after a short pause; folders and other files show no card, and a click, a scroll or a drag closes it. A canvas whose thumbnail has not been made yet (or one in a cloud-only project tab) says "No preview yet": the card never opens or renders a canvas to make one, so sweeping the pointer down a long list costs nothing.

With the file explorer focused, its keys act on the selected rows (the whole selection when the focused row is part of a multi-selection), the same keys its right-click menu shows:

| Action (file explorer focused) | Shortcut |
|--------|----------|
| Delete selected files and folders | Backspace or Del (Cmd+Backspace and Cmd+Del also work). The menu shows Backspace on macOS and Delete on Windows. A multi-selection deletes as one step, so one Cmd+Z restores it all. |
| Duplicate selected files and folders | Cmd+D (Ctrl+D on Windows). In the browser, canvases only. |
| Select all rows | Cmd+A |

**Edit > Delete** and **Edit > Duplicate** in the menu bar follow the same rule: with the file explorer focused they act on its rows, otherwise on the canvas. Edit > Delete shows no shortcut in the macOS menu bar (a single-key shortcut there would take Backspace away from every text field), but Backspace still deletes. In the browser, Delete works when the project lets you manage files. Duplicate works there on canvases (the right-click menu offers it on canvas rows only). While you rename a row, Backspace edits the name.

Within the file explorer, undo/redo (Cmd+Z / Cmd+Shift+Z) operates on canvas/folder lifecycle (create, delete, rename, move) via a separate explorer-scoped undo history. Outside the file explorer, undo/redo applies to the active canvas.

**Canvas search** (Cmd+P) opens the global search palette pre-filtered to files (canvases + assets).

**Search Files, in place (new interface).** The magnifier on the Files header, or **Cmd+L** from anywhere, turns the header row into a search field ("Search files"); a collapsed Files pane opens first when you press Cmd+L. In Safari, which keeps Cmd+L for its address bar, click the magnifier (or use Search files in the palette) instead; its tooltip shows no shortcut there. Typing filters the file tree as you type: every file or folder whose name contains the text stays, with the folders above it opened for the search only (your own expanded folders are left as they were). The matching part of each name shows in bold. When nothing matches, the tree shows one line, **No results**. **Esc**, the clear button, or leaving the empty field puts the header and the whole tree back. Cmd+P still opens the palette's file search.

## Checkpoints

The rail's **Checkpoints** tab (the clock icon) lists the project's saved versions, newest first, under quiet day labels (Today, Yesterday, This week, Earlier). The first row, **Now**, shows how many canvases changed since the last checkpoint. Each row reads the checkpoint's name and its time; a run of automatic checkpoints in one day folds into one "N automatic" row (click it, or its chevron, to open it). The **+** in the header creates a checkpoint (the same as **Create Checkpoint**, Option+Cmd+S, Ctrl+Alt+S on Windows), and the magnifier searches the list. The **Visitors see** row at the top says what people who open your published project see: the owner picks **Live** or **Last checkpoint** there.

- **Rest the pointer on a row** (or move to it with the arrow keys) for a card beside the panel: the name, the date, who made it, the canvases it changed, and **Restore** and **Open a copy**. On hover the row itself shows the same two buttons in place of its time.
- **The chevron** at the start of a row lists the canvases that checkpoint changed. Hover one for **Restore this canvas**, which restores that canvas alone; click it to open that canvas as it was.
- **Click a row** (or press Enter) to look at the project as it was, in place and read only: a bar at the top of the canvas reads "Viewing" with the checkpoint's name, its date and author, a **Show changes** switch that marks what differs from now, **Back to live**, and **Restore** (or **Open a copy** when you cannot restore). Edits are refused while you look ("Go back to live to edit"). Leave with **Back to live**, **Esc**, the **Now** row, or a restore.
- **Restore** happens at once: what you had is first saved as a checkpoint named "Before restore", then the project goes back, and a "Restored to <name>" message offers **Undo**, which puts back exactly what was replaced. Restoring needs owner rights (or team admin on a team project); anyone who can open the project can **Open a copy**, a new project starting from that checkpoint.
- A project that lives only on this computer shows "Checkpoints come with publishing" with a **Publish…** button: checkpoints are kept for published projects.
