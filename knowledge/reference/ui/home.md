---
name: "knowledge-ui-home"
description: "The home screen: the left panel, its places, pinned projects, signed out or offline, which projects are listed, teams, the account footer and search. The project area (the header, the grids and the list, the keyboard, badges, the tile menu, empty states) is reference/ui/home-projects."
assumes: reference/ui
---

# Home Screen

The home screen is the project browser you land on at startup and reach any time from the home button. It keeps the editor's chrome: the left panel becomes a project switcher and the main area lists your projects, over the same backdrop as a canvas. Opening a project from here is the same as switching to its tab.

**Left panel.** Top to bottom: a **search** field, then the **places** that choose which projects the main area shows:

- **All projects** (the default): everything.
- **Shared with you**: the projects other people have shared with you (a role granted on their project).

Then your **Pinned** projects under a small "Pinned" header, a thin line, and your **spaces**: **Personal** (your own projects) and one row per **team** you hold a seat on, led by the team's square avatar. When you have more than three spaces, the rest fold behind a "Show N more" row. Your choice of place is remembered. New project lives in the main area's header (`reference/ui/home-projects`); your account is the footer at the bottom of the panel.

**Pinned projects.** Choose **Pin to top** from a project's "…" menu and it appears in the left panel's Pinned rows (every project you pinned, in your order, whichever place is selected and whatever you search for) and in a **Pinned** grid at the top of the main area (which follows the selected place and the search). A pinned row is just its picture and name at rest; its "…" appears at the right end on hover. While a project downloads to this computer, a spinner sits in that spot (hovering swaps in the "…"). Drag a pinned row in the left panel to reorder: a blue line shows where it will land, before or after the row under the pointer depending on which half you are over. Drag any project from the main area onto a pinned row to pin it at that spot. **Unpin** removes it. Pins follow your account: when you are signed in, the projects you pin (and their order) show on your other computers and in Brilliant on the web too, and unpinning anywhere unpins everywhere. A cloud or synced project is matched by its cloud copy, so it shows pinned wherever you open home; a project that lives only in a folder on one computer stays pinned on that computer alone. Each account keeps its own pins: switching to another account shows that account's pins, and while you are signed out no account's pins show, so someone else using this computer never sees yours (they come back when you sign in again). The first time you sign in after updating, the pins you had on this computer join that account. A pinned project that disappears from home (a folder moved away, access removed) comes back to its pinned spot if it returns.

**Signed out or offline.** When you are signed out, a line above the project area reads "Signed out: cloud projects are hidden" with a **Sign in** link; your local projects stay listed. When the cloud cannot be reached, the line shows an **Offline** pill instead: cloud projects show their last synced state, and cloud-only tiles and rows are dimmed (they may still open from what this computer last saw).

**Which projects are listed.** Home shows everything: every project folder inside your `~/Brilliant` projects folder (where New project and Figma imports land), every folder you have opened from anywhere else on your computer, and every cloud project you own or hold a role on. Nothing ages out: a project you have not touched in months is still listed, just further down. A folder inside `~/Brilliant` counts as a project when it holds a `.brilliant` folder or a `.bl` canvas file at its top level; other folders you keep there are ignored.

**Teams.** Each team you hold a seat on has its own space in the left panel (with the team's square avatar) that shows only that team's projects, whether cloud-only or downloaded to your computer. Team projects behave like any other project (open, search, make available offline); a team project you can see is a team project you can work in.

**Search** narrows the main area within the selected place (the left panel's pinned rows always show every pin). Press **Cmd+F** (Ctrl+F on Windows) on home to jump into the search field. While there is a query, an **x** at the right of the field clears it; **Escape** clears the query first, and a second Escape leaves the field. It matches a project's name, its folder path, or **any of its canvas names**; the results list the matching projects, then the matching canvases (`reference/ui/home-projects`). When nothing matches, the field says "No matches".

The project area itself (the header and New project, the Pinned and recent grids, the Projects list and its sort, the search results, selecting and the keyboard, badges, the "…" menu and what an empty home says): `reference/ui/home-projects`.
