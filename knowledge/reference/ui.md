---
name: "knowledge-ui"
description: "All UI panels in Brilliant: the nav rail, top toolbar, left toolbar, right toolbar, bottom toolbar, palette, color picker, code editor, Claude Code chat, combos, and context menus."
---

# UI Panels

The left and right panels are fixed, the way Figma's are: each sits flush against its window edge and spans the full window height, with no gap and no rounded corners, and a thin line divides it from the canvas. They cannot be dragged anywhere else. On macOS the window's traffic-light buttons sit over the top of the left panel, and both panels start their content just below them. The bottom toolbar and the top island are centered on the window and cannot be dragged either; hiding or showing a side panel never moves them (when space between the panels is tight, the top island folds tabs into its "…" menu instead of sliding under a panel). Zoom to Fit still frames the canvas area between the panels. Hide and show the panels with their shortcuts (Cmd+Shift+← for the left toolbar, Cmd+Shift+→ for the right toolbar, Cmd+Shift+↓ for the bottom toolbar) or the palette; there are no on-screen toggle buttons. Resizing the left panel's width works as before, and the right panel (the inspector) can be made wider by dragging its left edge (280 px by default, up to 400 px; the width is remembered). The AI chat panel can still be dragged to a new spot. Every palette (the command palette, the color picker, the font picker, Type settings, Stroke settings, Style properties, Design system settings, Settings and the other palette pages) moves by its header: hover the top of the header to see the grip, then drag from any empty spot in the header (the header's buttons and tabs keep their own clicks). A press lower in the palette never moves it. A palette opened beside the inspector or a swatch stays where you drop it while it is open and opens fresh beside its button the next time; a palette opened in the middle of the window (the command palette, Settings) keeps the spot you dropped it until Brilliant restarts. A palette can be dragged up to the window edge, never past it. The inline AI box and the New project menu stay attached to what opened them and cannot be dragged.

**The nav rail.** A narrow rail runs down the window's far left edge, beside the left panel, with four tabs: **Files** (the folder icon: the file tree and the layers), **Assets** (the box icon: components from this project and its libraries), **Checkpoints** (the clock icon: the project's saved versions) and **Project** (the gear icon: project settings). Click a tab to show it in the left panel; click the tab that is already showing (its tooltip reads "Hide panel") to hide the panel, leaving only the rail, and click any tab to bring it back. Toggle Left Toolbar (Cmd+Shift+←) hides and shows the panel the same way. Your account avatar sits at the foot of the rail; click it for the account menu (switch account, each account listed by name alone, then Appearance, Settings, Sign out; your email, handle and team role live in Settings > Account, where the Handle row's **View profile ↗** opens your public profile). The browser editor has the same rail. Every tab is described in `reference/ui/left-toolbar`.

**Screen readers.** Narrator, NVDA and JAWS on Windows (and VoiceOver on macOS) can read the app: its controls, and named regions to navigate by, "Nav rail", "Left panel", "Inspector", "Bottom toolbar" and "Design canvas".

**Video and motion fills.** Hovering a shape filled with a video or a motion film shows a small mark in its bottom-left corner: the video (or film) icon and the clip's length, such as 0:12. Nothing marks it at rest. In the Layers list, a layer whose top fill is a video or a film shows a video or film icon instead of the grey image icon.

**Playing a video or motion fill on the canvas.** Select a layer with a video or motion fill and a small player bar appears inside it, near its bottom edge: play or pause, drag the scrubber to see any frame, and read the time. When the layer is too small on screen for the bar, a play button shows in its middle instead; zoom in for the scrubber. Clicking the bar never moves or deselects the layer (drag the rest of the layer to move it). Playing, pausing and scrubbing here never change the file.

When the editor or the canvas does not open, every failure card (browser and desktop), what it means and what to try is in `reference/editor-open-failures`.

## Sub-keys

- `reference/ui/top-toolbar`: the top island, project tabs and badges, rename from a tab, checkpoints, notifications, updates, sync health
- `reference/ui/home`: the home screen, project switcher, pinned projects, teams, account menu, search
- `reference/ui/home-projects`: the home project area: the header and New project, the Pinned and recent grids, the Projects list, search results, the keyboard, badges, the "…" menu, empty states
- `reference/ui/window-modes`: studio and overlay modes, window size, pan and zoom speed, hover highlight, small screens, UI density, settings sync
- `reference/ui/left-toolbar`: the left toolbar: the File Explorer, and the nav rail's tabs (Files, Assets, Checkpoints, Project)
- `reference/ui/layers`: the Layers Explorer
- `reference/ui/right-toolbar`: the property inspector, its header row, fields and color rows
- `reference/ui/inspector-sections`: every inspector section, top to bottom
- `reference/ui/field-expressions`: math, words, percentages and rounding in numeric fields
- `reference/ui/bottom-toolbar`: the bottom toolbar, the AI input, the inline AI input (the selection sparkle)
- `reference/ui/command-palette`: palette modes and shortcuts, global search, the Keyboard Shortcuts view
- `reference/ui/project-settings`: the Account and Project tabs of Settings, publishing a folder, drops
- `reference/ui/web-platform`: brilliant.design, project pages, share links, the playground, onboarding
- `reference/ui/color-picker`: the color picker, contrast line, Library tab, eyedropper
- `reference/ui/code-editor`: the code editor and the Markdown preview
- `reference/ui/chat-panel`: the AI chat panel, session tabs, resizing
- `reference/ui/feedback`: the feedback card
- `reference/ui/combos`: combos (saved command sequences)
- `reference/ui/spell-check`: spell check
- `reference/ui/context-menus`: right-click menus

## Missing and loading media on the canvas

A video, image or motion fill whose file is gone, or that cannot play on this computer, shows a small chip inside its box at the bottom-left: a warning triangle and "clip.mp4 is missing" (or "can't play here"). The box keeps the last picture it had when there was one. Click the chip to **Locate** the file: pick it in the file dialog and Brilliant brings it into the project (beside where the old file was, or in Assets/ or Motion/) and points the fill at it, every other fill setting kept; Cmd+Z undoes it. While an image or video is still opening, the same chip shows a spinner and "Loading clip.mp4". A box too small on screen shows no chip; zoom in to see it. A file added to the project from outside Brilliant (a copy in Finder, a download, an agent's command) is picked up on its own: the fill draws as soon as the file lands, with no reload or project switch.

## Assets View

Assets is a tab of the left panel. Open it with **Cmd+Shift+A**, the **Toggle Assets** palette command, or the rail's **Assets** button; its search is focused, and the same press on the open tab hides the panel. (While the AI chat is open, Cmd+Shift+A toggles the Chat Explorer instead; use the rail or the palette then.) The panel lists **All components**, **This project** with one row per canvas that holds components, and one row per library, with **Add library** pinned at the bottom. Pick a row to open the **components sheet**, a second panel attached to the left panel's right edge over the canvas: click a card to arm it and click the canvas to place it, or drag the card onto the canvas. Esc, the sheet's **×** or a click on the canvas closes the sheet. There is no separate Assets window and no Assets button in the bottom toolbar. From Home or the Settings tab, Cmd+Shift+A (and every other way into Assets) switches to the project tab you were last in and opens its Assets tab; with no project open, the most recent project opens first. The full walkthrough, including adding, updating, and publishing libraries, is in `reference/libraries/assets` and `reference/libraries`.
