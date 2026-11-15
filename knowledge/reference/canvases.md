---
name: "knowledge-canvases"
description: "Canvas and folder management, the file explorer, workspaces, import/export, auto-save, and version control in Brilliant, operated by hand."
---

# Canvases

A Brilliant workspace is a folder on disk. Each canvas is a single `.bl` file inside it; folders are real directories. There is no separate project index. The directory tree is the project tree.

## Sub-keys

- `reference/canvases/managing`: create, delete, switch, and folder canvases, with shortcuts
- `reference/canvases/cross-project`: copy and paste between projects, color tags, canvas identity
- `reference/canvases/explorer`: the file explorer by hand
- The top bar, the save-state dot on a tab, and where the canvas copy rows live: see `reference/ui/top-toolbar`.
- `reference/canvases/previews`: image and text previews, the code editor, asset management
- `reference/canvases/import`: importing images, SVG, and design files
- `reference/canvases/figma-import`: importing a Figma file with the Brilliant plugin and the import screen (project, pages, libraries), where the new project lives
- `reference/canvases/figma-import-run`: a Figma import while it runs and after (progress, Hide and Cancel import, the end page and Retry, the Migration report, missing fonts, importing again and page numbering, slow or stuck imports)
- `reference/canvases/figma-import-help`: helping a user whose Figma import has issues: reading the Migration report from an agent, the remedy per issue class (substituted fonts, components kept as copies, library linking, component references, pages that did not land, an interrupted run, an older app) and which acts are the user's in Figma
- `reference/canvases/figma-import-report`: the Migration report section by section (pages and warnings, missing fonts, component references, the library sections, every kept-as-copies reason with its remedy, Library setup)
- `reference/canvases/figma-plugin`: the Brilliant Figma plugin (how it connects, Figma in a browser vs the desktop app, Send selection and Copy selection, the page background, components, the design system)
- `reference/canvases/export`: exporting, Save as Sketch, Save As a `.bl` package
- `reference/canvases/auto-save`: auto-save and recovered files
- `reference/canvases/workspaces`: workspace layout, modes, `.bl` files, assets
- `reference/canvases/recovery`: deletion and recovery, Show in Finder, recents
- `reference/canvases/collaboration`: cloud and synced projects, view-only projects, sharing, cloud sync, Git

**Divider pages become folders.** Figma files are often organised with divider pages (an empty page named `---`, or `--- Mobile ---`), and design-system files often put a section's name in an empty page right under the line (`-----`, then an empty page named `🧱 FOUNDATIONS`). An import lands the pages as a flat numbered list unless you ask for folders. In the plugin, Pages and folders shows the pages of the file, and the switch "Group into folders by divider pages" turns the sections into folders: each one becomes a numbered folder, named by its divider or by the empty page under it (emoji and capitals kept), and the pages after it land inside as canvases. The divider pages and the empty name pages are not imported. With folders on you can drag a page into another folder, double-click a name to rename it, right-click for more, or remove the numbering; "Reset to default" returns to the folders the file proposes. A folder that would collide with one of Brilliant's own (Styles, Assets, Imports) is named with (Figma) after it. When you arrange the import inside Brilliant (the Pages step of the import screen), the list reads the way the project will: folders sit above pages at every level, each in name order, and typing one of those three names for a folder is refused with a note that the name is reserved. Re-importing matches each page by its Figma identity, so canvases you renamed or moved in Brilliant stay where you put them and are refreshed in place, and the plugin remembers the choice you imported with.


**Handing the user a project from an agent.** To turn what you built into a new project the user can share, call `execute_commands` with `publish_as_project` and the `canvasId` (the whole canvas becomes the project), or with `ids` on the command (just those elements, as one canvas). Optional params: `name` (any text; its dashed form becomes the address), `visibility` (`public` or `private`, a paid feature; absent: private for paid accounts, public otherwise) and `audience` (`live`, the default, or `checkpoints`, a paid feature: visitors see published checkpoints only). One call creates the project AND publishes it, with no card for the user to press: it answers once the publish has landed, with the project's `name`, `handle`, `visibility`, `audience` and `url` (`brilliant.design/{handle}/{project}`). The user stays where they are, and the new project appears in their projects (on desktop it is also a published folder on their device). A public project's address works for anyone with the link; a private one's only for people with access to it. Because publishing puts work on the web, first tell the user in the conversation what it means (for a public project: anyone with the link can see it) and call once they agree. It needs the user signed in to Brilliant; signed out, the call is refused and asks for that sign-in. A paid setting on a free plan is refused with the reason and the upgrade door (`open_checkout`); on desktop the project then stays on the device, unpublished.

**Changing a project's settings from an agent.** `set_project_settings` changes the Project tab settings of the project open on screen, on the user's word: `published` (`true` publishes a desktop folder that is not published yet, at the `visibility` you pass, or with none the account's default: private for paid accounts, public otherwise; `false` makes the project local-only: it stays on this computer, downloaded first if needed and every file checked against the server, and only then is removed from Brilliant's servers, so collaborators and shared links lose access; if anything stops it before that, nothing is unpublished), `visibility`, `audience` and `name` (a rename changes the address; old links redirect), and the presentation fields the project's Libraries page and profile card show: `description` (up to 280 characters), `displayName` (shown instead of the address), `topics` (up to five), `license` and `attribution` (the exact rules are in `blueprint/commands`). Pass any subset; it answers the project's state after the call (`published`, `visibility`, `audience`, `name`, `handle`, `url`, `role`), read fresh from the server; a field it could not confirm is listed in `unverified`. A refusal's `error` is one plain sentence, with the state beside it. Before each change, confirm with the user in the conversation what it means, then call. `published: false` also takes `confirm`, set to the exact project name (what the user types in the Danger zone) once the user has said yes; without it, or with a different name, the call is refused and nothing changes. It runs only in the desktop app (the web has no local copy to keep). After a rename, `list_projects` shows the new name and address. Only the project's owner can change these; anyone else is refused, with their role named. Who has access (members, invites, roles) is the user's to change in the Project tab, never through a command. `list_projects` shows each project's `published`, `url`, `visibility` and your `role` where known, and the `audience` of the project open on screen.

## Related

- `reference/export`: export and import details
- `reference/crop`: image crop mode
- `reference/design-systems`: design tokens and `Styles/` files
- `reference/ui`: toolbars, panels, palette
