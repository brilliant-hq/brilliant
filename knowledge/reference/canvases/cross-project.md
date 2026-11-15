---
name: "knowledge-canvases-cross-project"
description: "Copying canvases, folders and assets between projects, color tags, and the canvas identity behind the "belongs to another project" refusal."
assumes: reference/canvases
---

# Copy, Paste and Canvas Identity

## Copy and paste between projects

The explorer clipboard travels across projects: copy (or cut) canvases, folders, or asset files in one project, switch to another project's tab, and paste.

- **Canvases** arrive with their content. Image assets they use are copied into the destination (renamed on a name clash, never overwriting a destination file). Referenced brand `.ds` files come along on pastes between local projects; if the destination already defines a brand with that name, the destination's definition wins. When a cloud project is on either side, the brand file cannot travel yet: the canvas arrives with default styles and a note says so.
- **Folders** travel as a whole tree: canvases, subfolders, assets, and other files keep their layout, and references inside the copied tree keep working. Anything the tree referenced from outside it (say a root-level asset) is copied in too.
- **Cut** moves: once the paste lands, the originals go to the source project's trash (recoverable, like any delete).
- Name clashes always keep both; the pasted copy gets a numbered name.
- **Pasting several items at once** shows a small progress note (the item being copied and how far along, like "3 of 8"). When it finishes cleanly the note is replaced by a short confirmation naming where the items landed: "Pasted N items to {project}" (or "Moved N items to {project}" for a cut). If some items could not be pasted, you get an honest note about what did not land instead of a false success.
- **Pasting into a project you can only view**: in the desktop app (a view-only cloud project tab) the paste is refused up front with a short view-only note, and nothing is written (no half-finished paste). On the web, someone else's public project turns into your own copy on your first change (`reference/ui/web-platform`), so the paste lands in that copy.
- Works between local and cloud projects in any direction (local to cloud, cloud to local, cloud to cloud). Anything that can't travel is named in an honest note instead of failing silently.

**Color tags:** append a color suffix to a folder or canvas name to color its icon. Supported suffixes: `.red`, `.green`, `.yellow`, `.orange`, `.purple`, `.pink`, `.gray` (or `.grey`). Without a suffix the icon is blue. Example: naming a folder `Components.purple` shows a purple icon. The suffix is hidden from the displayed name and preserved through renames.

## Canvas identity and the "belongs to another project" refusal

Every canvas has an identity that the platform mints for the project it lives in. A canvas's name (and its path) is just a label on that identity: renaming or moving a canvas keeps the same identity. This is what lets the app tell your canvas apart from a look-alike in another project.

Copying a canvas **through an app door** (the cross-project paste above, or Duplicate) mints a fresh identity for the copy automatically, with a pointer back to the original. You never have to think about it.

Copying a `.bl` file **outside the app** is the one case to know about. If you copy a `.bl` from one project's folder into another (in Finder, with `git`, or any external editor), the file still carries the source project's identity, so the app refuses to sync it with a short "this canvas belongs to another project" note rather than silently filing your content in the wrong place. In a cloud project the note (and the "isn't syncing" notice of a canvas the live session could not sync for this reason) carries one button, **Adopt into this project**: it keeps the canvas as you see it now under a fresh identity of this project. If the project has no canvas at that path, it is adopted right there; if the project already has its own canvas at that path, that canvas is never touched and the copy lands beside it as "<name> (adopted)". Adopting is not undoable with Cmd+Z; delete the canvas to reverse it. In a synced folder, duplicate the canvas instead (Duplicate Canvas): the copy gets a fresh identity. A fresh file an external editor writes (one that never belonged to another project) is accepted normally, no note.

**For agents:** the refusal code is `file_foreign_identity` (a 422 on save). The self-serve remedy is the declared-copy flag (`duplicate: true` on a `/save`, `dup` on the live wire), surfaced to people as "Adopt into this project", which mints a new identity for the copy with a pointer back to the source. Agents run the same act with `execute_commands` `adopt_into_project` (`params.path`, default the target canvas); the answer names where the canvas landed. A separate code, `identity_required`, means a live edit was sent without its canvas identity; that is an app bug, not something a user or agent action fixes.
