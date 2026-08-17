---
name: "knowledge-ui"
description: "All UI panels in Brilliant: top toolbar, left toolbar, right toolbar, bottom toolbar, command palette, color picker, code editor, Claude Code chat, combos, and context menus."
---

# UI Panels

The floating panels (left/right/bottom toolbars, command palette) are draggable. A dropped panel anchors to its nearest window edge per axis (or the center, for centered-ish drops), so it keeps its edge-relative position through any window resize and always stays fully onscreen.

## Top Toolbar

One frosted island floating at the top center of the screen: a **home button**, one **tab per open project** in your saved order, a separator, then the workspace breadcrumbs in the form `Workspace / Folder / Canvas` (segments separated by a thin `/`). When the workspace is the special "Scratch" sandbox, the workspace segment is hidden. The active project's name can appear twice (in its tab and in the breadcrumb), which is intended. The island is centered at every tab count and never grows under the macOS traffic lights, so there is always empty title-bar strip on both sides of it.

- **Tabs**: click one to switch projects, middle-click (or its hover ✕) to close, drag to reorder. Each tab reads `project / canvas` and shows the project's current canvas; a dot marks finished agent work you haven't looked at, and a shimmer marks an agent working there now. The home button opens the project home screen; the breadcrumb half hides there, so the island becomes just home + tabs.
- **A badge on the left of each tab says where the project lives and how public it is:** nothing = local only; a cloud icon = a public cloud project; a sync icon = a project that lives on both your computer and the cloud; a lock is added whenever the project is private. A cloud tab for a project that is **not your account's** (someone else's project you opened, or any cloud project while you are signed out) shows a **dashed cloud** in place of the plain one, so a project you do not own reads differently at a glance; signing in as the owner flips it back to the solid cloud. While a checkpoint is saving, a sticky "Saving checkpoint…" notification (with a loading spinner) shows the progress; the tab badge stays put.
- **A project you can only view shows an eye badge** after its other badges. It means you can open and read the project but not edit it (a cloud or synced project your current account has no edit rights on; local-only projects are always editable and never show it). The eye is separate from the lock: a private project you cannot edit shows both. It appears and disappears live as your access changes (signing in or out, switching account). What view-only means, and the ways forward, are under "Opening a project you cannot edit" in [canvases.md](./canvases.md).
- **Home is always leftmost**, then your open projects in the order you opened or dragged them into. Switching projects does **not** reorder the strip; the active tab is simply highlighted where it sits. On the home screen no tab is highlighted.
- Every project tab can be dragged to reorder; only the home button stays put.
- **Ctrl+Tab** / **Ctrl+Shift+Tab** cycle the strip, and **Cmd+Ctrl+0** jumps home while **Cmd+Ctrl+1..9** jump to a project. They address your **tab order** (the order tabs were opened or dragged into), which is also the left-to-right screen order, so a given number always means the same project. On macOS Cmd+Ctrl+1..9 only fire when nothing is selected; with a selection the same chord sets rotation. On Windows the jumps are **Ctrl+1..9 / Ctrl+0** and fire with or without a selection (rotation lives on Alt+Shift+digit there).
- When the island runs out of room, labels shorten first, then the older inactive tabs fold into a "…" menu that sits just after the home button (always in the same place, whichever tab is active); the project you're in and the canvas you're on are the last things to shrink.
- Switching to an already-open project is instant and says nothing. A switch that takes longer than a moment (a cold project, a cloud one over the network) raises a "Switching to {project}…" notification that clears itself the instant the project lands; if it cannot be opened, that notification is replaced by the failure warning.
- **Double-click** the canvas name (last breadcrumb) to rename it inline. Press **Enter** to confirm, **Escape** to cancel. Color suffixes (e.g. `.blue`) are preserved across rename.
- **Hover the island** to reveal, on its left, a copy-path button then a checkpoint button (bookmark icon), and (if any notifications exist) a clear-notifications button on the right. Copy-path writes the full filesystem path of the current canvas's `.bl` file (or the current asset path) to the clipboard. The tooltip flips to "Copied!" for one second. The left pair and the vim indicator belong to the project on screen, so they are absent on the home screen (and while a switch started from home is still landing); clear-notifications belongs to the app and stays.
- **Checkpoint** (bookmark icon) saves a named version of the project. It appears only where the project you are looking at has a cloud copy to checkpoint: a cloud project you can edit, or a desktop folder you have published. A local-only folder and the scratch sandbox show no checkpoint button, and viewers never see it. Publishing a folder makes the button appear right away. Pressing it raises a small toast with a **name field prefilled with the auto-name** (`Automatic checkpoint` on cloud projects, `Checkpoint #N` on a local desktop repository): type a name and press Enter (or Save) to checkpoint under that name, confirm untouched (or clear the field) for the auto-name, Escape/Cancel to walk away. Also runnable from the command palette as **Create Checkpoint**.
- A small notifications dot appears at the island's top-right corner when notifications exist and the breadcrumb is not hovered. It is **red whenever an unresolved failure or warning is live** (a failed sync among them); otherwise it is the ordinary blue accent. A sync failure's notification cannot be dismissed, so while sync is broken the red dot is always there. No red dot means nothing is failing.
- Notifications appear under the toolbar. Confirmations and successes ("Link copied") fade after a few seconds; **failures and warnings stay until dismissed**, so a verdict is never lost by looking away. Close one with its x, a click on its body, or Escape; or clear all from the toolbar's clear-notifications button.
- A notification carrying buttons (a confirm, a conflict, an invitation) is a **CTA notification**. It waits for its answer and **never expires on its own**, whatever its severity: it leaves only when one of its buttons is pressed, or via its x or Escape. Clicking its body does nothing. Whether it holds the panel open depends on who raised it. A dialog you opened yourself (naming a checkpoint, a publish or unpublish confirm, reviewing a file conflict) stays in view until you answer or close it, the way a dialog should. An offer or notice the app raised on its own tucks away when the panel collapses, leaving the dot lit, and hovering brings it back so it can be answered later.
- **Paid features knock, they don't block.** Hitting a paid wall (a short handle, making a project private, publishing a private drop, a second guest editor, a team whose Team plan lapsed) raises one CTA notification with the reason and an Upgrade button ("See Team plans" or "Create a team" for team features); "Not now" or the x puts it away. Locked paid toggles show a quiet "Available on Personal" chip, and tapping one raises the same notification: the toggle itself never flips until the plan does. A checkpoint refused because the team plan lapsed carries a "See Team plans" button straight to the team's billing page.
- A held failure is never taken away behind the user's back. A later result reusing the same notification (a checkpoint that failed, then succeeded) updates the wording but keeps the notification on screen until it is closed, and the `dismiss_notifications` command clears only the transient toasts, leaving failures and pending confirms in place. Clearing failure notifications is the user's call, made from "Clear all".
- One class cannot be closed at all: **while sync is failing, its notification has no x and "Clear all" leaves it in place** (it would be reporting a problem that is still happening). It goes away by itself when sync recovers. The panel still closes normally: move the pointer away and the notifications collapse, leaving the red dot as the reminder.
- When viewing a non-canvas asset (image preview), breadcrumb segments are the asset id split by `/`; the last segment is editable and includes the file extension.
- Color-suffixed folders/canvases display their assigned color in the breadcrumb text. The last breadcrumb is bold; earlier ones are dimmer (50% opacity). Dirty state dims the last crumb to 60% until saved.
- Drag anywhere on the island or the empty strip beside it to move the OS window (disabled in fullscreen / maximized; cursor turns grab/grabbing). Double-click empty strip or island space for the macOS title-bar action (zoom/minimize, per your System Settings); double-clicking the canvas name still renames it.
- When editing a text file with vim mode enabled and the code editor is focused, a small vim mode indicator (NORMAL / INSERT / VISUAL) is shown to the left of the breadcrumbs.

There is no save chip in the top toolbar: auto-save runs in the background with a ~500 ms debounce. The last breadcrumb's opacity is the only save-state cue (it also reflects cloud sync in a web/cloud project: dimmed while saving/syncing, full opacity once synced).

**Sync health is reported by exception only.** A project that is syncing shows nothing at all: there is no standing sync indicator anywhere. If a cloud save or live sync hits trouble, one notification is raised for that project (working offline, sync failed, or sign-in required, with the reason in words) and the notification dot goes red. Losing **write access** to a shared or team project is its own honest state, not a sign-in problem: the notification says sync stopped, that your changes are safe on this device, and that the fix is having your access restored (it never asks you to sign in again, and it never spins a retry that cannot succeed). Once access is restored, the held changes push by themselves. A **team project whose team plan has lapsed** reads the same way, naming the Team plan as the fix. That notification **cannot be dismissed while the trouble lasts** (no x, and "Clear all" spares it) so the red dot is guaranteed to be there for exactly as long as sync is broken; the notification panel itself still collapses normally. Repeated failures update that one notification instead of stacking new ones. When sync recovers, the same notification flips to "Back in sync" and fades on its own. If you switch away from a project while its sync is still failing, the notification stays (now naming that project, and now closable, since nothing is retrying it until you open it again). So: no red dot means your work is reaching the cloud.

## Home Screen

The home screen is the project browser you land on at startup and reach any time from the home button in the top island. It keeps the editor's chrome (the same top island and side panels): the left panel becomes a project switcher and the main area becomes a grid of project tiles, over the same backdrop as a canvas. Opening a project from here is the same as switching to its tab.

**Left panel.** Top to bottom: your **account avatar**, a **search** field, a quiet **"+ New"** row (New project, which creates and opens an empty project folder, or Open folder…), then your projects as compact switcher rows grouped into four sections:

- **Recent**: your most recently opened projects, any kind.
- **Local**: files that live on your computer only.
- **Synced**: files that live on your computer and sync to the cloud.
- **Cloud**: files that live in the cloud only.

A project can appear in more than one section (a recent local project shows in both Recent and Local). Each section header carries a small icon and a hover tooltip explaining what it holds. Click a row to open that project.

**Teams.** If you hold a seat on any teams, each team gets its own section after Cloud (its header shows the team's square avatar and name) holding that team's projects, whether cloud-only or downloaded to your computer; the personal sections keep only your own work. The tile grid mirrors this: your personal tiles first, then one band per team under the same avatar-and-name header. Team projects behave like any other project (open, search, make available offline); a team project you can see is a team project you can work in.

**Account avatar.** The avatar shows who you are acting as: a round photo for your personal account, a rounded square for a team. If you belong to any teams, clicking it opens the **account menu**: your identity at the top, a "Switch account" section listing your personal account and every team (a checkmark marks the active one; click a row to switch), then Settings and Sign out. With no teams, clicking the avatar goes straight to Settings -> Account. The same accounts-with-checkmark switcher appears in Settings -> Account.

**Visibility filter.** The **Recent** header carries a small funnel button on its right with three settings: **All** (default), **Public**, and **Private**. It filters what you see by how public each project is, and it applies to every section and the tile grid at once, not just Recent. **Public** shows only projects that are public on the cloud; **Private** shows everything that is not public, which is your private cloud projects plus your local-only projects (local work is not public). When the filter is set to anything other than All the funnel takes on the accent color so you can tell a filter is on, and the Recent header stays put even if the filter empties every section, so you can always switch back to All.

**Tiles.** Each tile shows up to three canvas thumbnails as a mosaic (with a "+N" badge when the project has more canvases), the project name with its badge, and a meta line: canvas count, when it was last edited, and the folder path. A canvas that has no thumbnail yet shows a plain gray cell (nothing is faked). Click a tile to open the project.

**Badges** mean the same thing here as on the tabs: nothing = local only, a cloud icon = a public cloud project, a sync icon = a project that lives on both your computer and the cloud, and a lock is added when the project is private. A **team-owned** project additionally leads its badge cluster with the team's small square avatar, and that avatar is the whole team marker (no team name is added anywhere): tabs and tiles show it always, Recent rows reveal it on hover with the rest of the cluster, and rows inside a team section skip it since their header already shows it. A team project of yours keeps the plain cloud icon (it is your work, not a foreign project), while a cloud project you have no access to still shows the dashed cloud. A project that is **view-only** for you (you can open it but not edit it) shows an **eye** after its other badges, the same as on its tab.

**Search** filters both the list and the grid at once. It matches a project's name, its folder path, or **any of its canvas names**. When a project shows up only because one of its canvas names matched, the tile's meta line adds that canvas name with the matching part highlighted (and a "(+k)" when several canvases matched), so you can see why it is there.

**The "…" menu** (hover a tile or a row to reveal it) offers, as they apply:

- **Open**: open the project.
- **Open in web**: for published projects, opens the project's public page in your browser.
- **Sharing…**: opens Settings -> Sharing for that project **without leaving home** (no tab switch). For a published project it shows the owner/sharing rows; for an unpublished local folder it opens the publish flow for that folder. On a **team project** this entry appears only for team admins (sharing on a team project is managed by its admins), so members simply do not see it.
- **Make available offline**: for a cloud-only project, downloads a local copy into your `~/Brilliant` projects folder so it becomes a synced project (its badge flips to the sync icon). If a folder of that name already exists there, it tells you and does nothing.
- **Duplicate as local project**: for a cloud-only project, makes an independent local copy on your computer and opens it as a new project. Unlike Make available offline, the copy is **not** synced (it keeps no link back to the cloud project), so it is yours to edit freely. It never clobbers an existing folder (it lands beside one of the same name).
- **Reveal in Finder**: for projects that have a folder on disk.
- **Remove from list**: drops the project from your list. It never deletes anything on disk or in the cloud.

While searching with no matches the grid shows "No projects match."

## Window Modes

Brilliant runs in two window modes, switched on a single window:

- **Studio** (default): a regular desktop window with title bar, shadow, resizable. Visible in the Dock. Launched on startup.
- **Overlay:** a borderless, always-on-top, transparent fullscreen layer above other apps. Hidden from the Dock. Summoned and dismissed via a global hotkey that works even when Brilliant is unfocused.

| Action | Shortcut |
|--------|----------|
| Toggle overlay mode (global, opt-in) | Ctrl+F |
| Toggle passthrough (overlay only) | Ctrl+A |
| Toggle desktop icons (macOS-only; works in either window mode) | Ctrl+I |

**Pan and zoom speed are adjustable.** Settings (Cmd+,) → General → "Trackpad and Mouse" has two fields, "Pan speed" and "Zoom speed" (percent, 100% default, dropdown steps 50 to 200, typed entry 25 to 400). Pan speed scales two-finger scroll panning (and the momentum it throws); zoom speed scales pinch and modifier+scroll zooming. Middle-mouse and space-drag panning stay 1:1 with the cursor, and keyboard zoom steps are unaffected. Applies immediately and persists across launches.

**Overlay mode is macOS-only and opt-in.** The whole feature (transparent window + global hotkey) is gated on `Platform.isMacOS`; the toggle and its actions are not shown on Windows, and `toggle_overlay_mode` / `toggle_pass_through` are in the Windows-disabled keybinding set. The "Overlay Mode" toggle lives in Settings (Cmd+,) → General, off by default. The Ctrl+F global hotkey is only registered while that toggle is on; with it off, Ctrl+F does nothing. Turning it off while in overlay auto-exits to studio. The setting persists across launches (SharedPreferences key `OverlayModeEnabled`). Settings → General also exposes an "Open Accessibility Settings" action: accessibility access is required for the global hotkey to summon Brilliant from other apps.

In passthrough mode (overlay only), mouse clicks pass through Brilliant to the apps below. Studio window state (position, size, fullscreen, maximized) is saved before entering overlay and restored on exit. A restore whose display arrangement changed in the meantime (say a monitor was unplugged mid-overlay) re-centers the window on the active display instead of leaving it stranded off-screen. If the window ever does end up unreachable, the command palette's **Center Window on Screen** re-centers it at its current size; it stays available even while a text or image file is open. The bottom toolbar sits slightly higher off the bottom edge while in overlay mode than in studio.

**Window size and position persist across launches on Windows.** Relaunching restores the previous window frame and maximized state (a frame saved on a since-disconnected monitor is pulled back into the visible work area). The first run opens centered at about 80% of the primary work area (capped at 1400x900 logical), and the window cannot shrink below 800x600. On macOS the studio window opens at its standard centered default each launch.

The overlay-mode toggle is a global hotkey only when the opt-in is on, so it works even when Brilliant is not the focused application. Reassigning the keybinding re-registers the global hotkey. Passthrough is a regular in-app shortcut gated to overlay mode (its WhenClause requires `!isStudioMode`, so the overlay window must be active). Toggle desktop icons is a plain in-app shortcut on `BaseCommand.defaultWhen` (not overlay-gated); it fires in either window mode and is a macOS-only operation (the command hard-returns off macOS).

**UI density.** Settings (Cmd+,) → General → "UI density" under Appearance: Normal (default, roomier text and spacing) or Compact (fits more on screen). Also available as commands in the command palette: "UI Density: Normal", "UI Density: Compact", and "Toggle UI Density" (all unbound by default; assign a shortcut in Keyboard Shortcuts). Applies to all app chrome instantly; canvas content is unaffected. Persists across launches and, when signed in, syncs across devices (see "Settings sync" below). This is app-chrome density, distinct from the design system's density mode axis in the inspector's Design System section.

**Settings sync.** When signed in, portable settings follow the account across desktop and web: keyboard shortcut overrides, tool and UI preferences, theme (light/dark/system), UI density, extra enabled AI models, and onboarding state. Changes sync automatically in the background (a couple of seconds after an edit, and on app focus); the newest change per setting wins. Signed out, everything stays purely local. Provider API keys never leave the machine: they are stored locally (keychain on desktop, browser storage on web) and are never uploaded.

## Left Toolbar

Contains the **File Explorer** (top) and **Layers Explorer** (bottom) in a vertically split layout. Drag the divider between them to resize each panel's share of the toolbar height. Drag the right edge to resize the toolbar width. Collapses to a 20 px rail when toggled off; hovering the rail re-expands it.

The header holds a live-collaboration participants cluster on the left and its controls pinned right: a reset-position button and a toggle-toolbar button, then a "free" plan chip when applicable. The reset/toggle buttons fade in on hover; the participants cluster and the free chip stay visible at all times. (Your own account avatar and the copy-link button used to sit here too; they now live in the right toolbar's header; see "Right Toolbar" below. The old team chip is gone; team identity lives in the home avatar's account menu and Settings -> Account.)

There is no sync-status indicator in this header. Sync health surfaces only when it is bad, as a notification plus a red notification dot on the top island (see "Top Toolbar" above).

- **Participants cluster:** in a live collaboration session, the other people on the project appear as avatars on the left of the header. Each shows the person's photo (or a colored initial) and their name on hover; colors match their live cursors. Click a member to open their profile in a new tab. Absent when you are working solo.

| Action | Shortcut |
|--------|----------|
| Toggle left toolbar | Cmd+Shift+← |
| Focus file explorer | Cmd+Shift+E |
| Focus layers explorer | Cmd+Shift+R |

### File Explorer

Tree of all canvases, folders, and asset files in the workspace. Features: folder expand/collapse, multi-selection (Cmd/Shift+Click), right-click context menu, drag/drop reorder and reparent, inline renaming (double-click or Cmd+R), keyboard navigation, type-to-filter. Hidden files (`.foo`) are gated by the Show Hidden Files command.

Canvas files (`.bl`) and design-system files (`.ds`) display **without** their extension (e.g. `rip figma`, `default`), the way Finder and Figma hide known design-file extensions, and their inline rename edits the name the same way: the extension stays hidden, typed dots are just part of the name (`v2.1` stays a canvas), and the extension is re-applied on save. Asset files keep their extension everywhere (`hero.png`, `notes.md`), including in rename, where changing it changes the file type. The real filename on disk always carries the extension; paths and ids are unchanged.

Within the file explorer, undo/redo (Cmd+Z / Cmd+Shift+Z) operates on canvas/folder lifecycle (create, delete, rename, move) via a separate explorer-scoped undo history. Outside the file explorer, undo/redo applies to the active canvas.

**Canvas search** (Cmd+P) opens the global search palette pre-filtered to files (canvases + assets).

### Layers Explorer

All elements on the active canvas in a hierarchical tree.

Features:
- Element type icons per type, including component master / instance markers
- Indentation lines show parent-child relationships
- Click to select on canvas; Cmd/Shift+Click for multi-select
- Drag to reorder (changes z-order) or reparent into a frame
- Inline rename (double-click a row or Cmd+R)
- Type-to-filter via the layer-search palette

**Layer search** (Cmd+L) opens global search pre-filtered to layers.

**Layer order:** Top of list = front (highest z-order). Drag to reorder.

## Right Toolbar (Property Inspector)

Right-anchored, expandable to 240 px and collapsible to a 20 px rail. Sections appear dynamically based on the current selection and tool. Drag the toolbar to reposition; "Reset position" returns it to the right edge.

The header row reads, left to right, **account avatar, presence toggle, Share button, a hover-revealed "…" options menu, then (on the right) the zoom-level field**. The avatar, presence toggle, and Share stay visible whenever they apply; the "…" menu fades in on hover; the zoom field is always there. Each item shows only when it's relevant:

- **Account avatar:** the account you are acting as: your own photo (or initial) normally, or the team's square avatar when you are acting as a team (the same identity the home avatar shows). Hover opens the account menu (email/identity, plan, "Switch Account" / "Sign out", "Open Settings -> Account", and "Project settings" for a cloud project). When you're signed out of a cloud/web project the avatar and the Share button collapse into a single compact **"Sign in"** button that stands in for both; a purely local project with no account shows no avatar (a quiet header).
- **Presence sharing:** in a live session, toggles whether others see your cursor and viewport.
- **Share** (text button, one word for both states): for a published project it copies a shareable link to the current canvas straight to the clipboard (tooltip "Copy Link", a toast confirms), and if elements are selected the link deep-links to that selection. For a project with no shareable link yet (an unpublished desktop folder) it opens Settings -> Sharing at the publish flow instead (tooltip "Share this project…"); it never publishes by itself. In the web app it's always available; on desktop it shows whenever you're signed in (signed out, it's folded into the "Sign in" button described above). The same copy-link action is also on the top-toolbar breadcrumb and the canvas right-click menu.
- **"…" options menu** (hover-revealed, tooltip "Toolbar options"): the toolbar-management controls, now tucked into one menu rather than shown as separate buttons. It carries **Reset toolbar to default position**, **Toggle Right Toolbar**, and **Toggle All Sections**.

While dragging a selection that touches many elements, sections auto-collapse to stay responsive, then re-expand when the drag ends.

| Action | Shortcut |
|--------|----------|
| Toggle right toolbar | Cmd+Shift+→ |
| Expand or collapse all sections | Cmd+/ |

### Sections (in order from top to bottom)

Top to bottom: Design System, Canvas, Current Stroke, Current Fill, Element, Parent, Typography, Selection Strokes, Selection Fills, Selection Colors, Effects, Layout Grid, Export, Figma Import. Each section decides its own visibility based on the current selection and tool; this list reflects the slot order, not which sections are visible at any moment.

**Header** (above the section stack): the avatar / presence / Share cluster and the hover-revealed "…" options menu described above (Reset toolbar position, Toggle Right Toolbar, Toggle All Sections all live in that menu now, not as separate buttons). Zoom percentage sits on the right: drag to adjust, click to open a preset dropdown (2, 25, 50, 75, 100, 125, 150, 200, 300, 400, 600, 800, 1000, 2000, 3000, 5000).

**Design System Section**: Brand dropdown plus one row per mode axis (theme first, density second, then alphabetical). Visible whenever the active canvas is loaded; lets users switch the design system, theme, density, and any custom mode axes the design system defines. Surfaces here only; token management itself lives in the design system file. See `design-systems/core`.

**Canvas Section**: Canvas background color swatch and toggle. Visible only when nothing is selected and the Move tool is active.

**Current Stroke / Current Fill Sections**: Default stroke and fill used for newly created elements. Always visible. When elements are selected the subtitle reads "+ selected" and edits also apply to the selection's strokes and fills.

**Element Section**: X/Y position (the row also holds the absolute-position pin button when the selection is inside an auto layout frame, and the "..." expander), W/H with a constrain-proportions toggle, sizing behavior (hug/fill/fixed per axis) ending in a ruler-icon toggle that reveals Min/Max W/H rows (auto layout frames and their direct children), a pin-constraints row (Figma's nine-nub widget plus horizontal and vertical pin dropdowns, shown for children of frames, components, instances, and non-hug groups and for absolute-positioned auto layout children, hidden where pins are dormant), rotation, opacity, corner radius (expand for per-corner or top/bottom pairs; an app-glyph toggle appears at nonzero radius and reveals a smoothing percent row for squircle corners), flex (for auto layout fill children; moves to its own row when the smoothing toggle shows), and circle arc properties (start angle, sweep, inner ratio) for circle elements. In vector edit mode with nodes or handles selected: shows node/handle position and point type instead of W/H/rotation/opacity. The "..." expander exposes blend mode (containers get a Pass through default plus Normal and the standard modes), absolute scale, alignment, arrange, and boolean operations (union, subtract, intersect, exclude) when 2+ elements are selected.

**Parent Section**: Parent Type dropdown listing all 8 types (Frame, Group, Auto Layout, Union, Subtract, Intersect, Exclude, Mask; picking one converts the parent), a Resize to Fit button (Option+Shift+Cmd+R; shown for frames/groups/masks/auto-layout with children, left of the clip toggle), Clip Content toggle, and, when every selected frame is auto layout: direction, wrap toggle, 3x3 main + cross alignment grid, item spacing, and padding (progressive disclosure: unified -> H/V pair -> four sides). Layout guides for non-auto-layout frames live in the Layout Grid section.

**Typography Section**: Font family (click opens font selector) + font size + text direction toggle; line height + letter spacing + OpenType features button; font weight dropdown + text sizing mode (Auto Size / Auto Height / Auto Width / Fixed) + Auto Size button; text alignment (left/center/right) + italic + underline + strikethrough + a "..." expander (vertical alignment trio, list toggles, paragraph indent + list spacing, case + truncation, paragraph spacing). Visible when the effective selection contains a text element or when the Text tool is active with nothing selected.

**Selection Strokes Section**: Per-stroke color swatch, thickness, and position (inside / center / outside) for the selected elements. For rectangles and frames the expanded stroke config ends with a per-side width field (accepts "4", "4, 8", or "1, 2, 3, 4") plus pairs / individual editor toggles (see `styling.md`). Stroke caps (start/end caps for open paths and arcs; unified cap dropdown for complex vectors). Add / remove buttons.

**Selection Fills Section**: Per-fill swatch (color, gradient, image, shader, or image-filter fill types: inner shadow, inner glow, background blur, color adjust, noise/grain, halftone, pixelate, duotone, posterize, dither). Add / remove buttons. For vector elements with regions, shows per-region fill controls. Clicking an image fill swatch opens the color picker in image mode (file picker, drag-and-drop, Cmd+V paste).

**Selection Colors Section**: Unified editor for the unique colors used across fills, strokes, and text-range span colors of the current selection. A text span colored with the same design token as another element's fill shares one row. Shown when the selection includes frame descendants.

**Effects Section**: Drop shadow, outer glow, element (layer) blur. Add and remove effects, toggle per-effect visibility, configure properties. Inner shadow, inner glow, and background blur are fill types (in the Fills section), not effects.

**Layout Grid Section**: Layout grid editor for frames. Three grid types: Grid (uniform cells), Columns, Rows. Per-grid: visibility toggle, color swatch, expand toggle for properties (count, gutter, margin, alignment, span), and remove button.

**Export Section**: Multi-config export panel. Each config row: format dropdown (PNG, JPEG, WebP, SVG, PDF, HTML, React, MP4, MOV, Replay; MOV is hidden on Windows). In the browser editor the video formats (MP4, MOV, Replay) are dropped from the dropdown: they need the native encoder, so video export is desktop-only (raster, vector, and markup all export on the web). The HTML entry exposes a second dropdown to pick the variant (Page = standalone document, Snippet, Flexbox). The Replay row shows a separate container dropdown that picks MP4 or MOV. Resolution preset (Original 1x/2x/3x/4x, 720p, 1080p, 1440p, 4K, 8K, Portrait Post · IG, FB, Square Post · IG, X, Story / Reel · IG, TikTok, iPhone 16 Pro, MacBook Pro 14", Custom; vector and markup formats hide the resolution row). Expand for advanced (width/height with constrain proportions, fit mode = Fit/Fill/Stretch/Repeat, background, PDF multi-page toggle, plus video duration / FPS / codec / quality and replay-specific pacing/intro for video and replay rows). Add multiple configs with `+` to export several formats in one click. The right-toolbar UI does NOT expose JPEG-quality, WebP-quality, or WebP-lossless toggles: those are only reachable via the MCP `export` tool.

**Figma Import Section**: Figma file URL import. Visible only when nothing is selected and the Move tool is active (same condition as Canvas Section). Present in the browser editor too, on projects you can edit; view-only projects never show it.

Design tokens also surface in the color picker (token swatches at the bottom) and in numeric property fields that accept tokens (font size, line height, font weight, corner radius, padding). The Design System section at the top of the toolbar handles brand/mode switching only.

Sketch files import through the global Import command (Cmd+Shift+O), not an inspector section.

### Interactive Fields

Most numeric fields support: typing exact values, dragging left/right, arrow keys (Shift for larger steps, Alt for smaller).

**Math expressions:** Type any arithmetic expression and press Enter to evaluate:

| Input | Field had `200` | Result |
|-------|----------------|--------|
| `200 * 2/3` |  | 133.33 |
| `(100 + 200) / 3` |  | 100 |
| `* 2/3` | 200 | 133.33 (operator prefix uses current value) |
| `+ 50` | 200 | 250 |
| `/ 3` | 200 | 66.67 |

**Natural language:** Type words and press Enter:

| Input | Field had `200` | Result |
|-------|----------------|--------|
| `half` | 200 | 100 |
| `double` | 200 | 400 |
| `triple` | 200 | 600 |
| `quarter` | 200 | 50 |
| `third` | 200 | 66.67 |
| `golden` | 200 | 323.61 (golden ratio) |
| `2x` / `3x` / `0.5x` | 200 | 400 / 600 / 100 |

**Percentages:**

| Input | Field had `200` | Result |
|-------|----------------|--------|
| `50%` | 200 | 100 (50% of current) |
| `+ 10%` | 200 | 220 (add 10%) |
| `- 25%` | 200 | 150 (subtract 25%) |
| `200 + 10%` |  | 220 |

**Rounding:**

| Input | Field had `203.7` | Result |
|-------|-------------------|--------|
| `round` | 203.7 | 204 |
| `round 8` | 203.7 | 200 (nearest multiple of 8) |
| `floor` | 203.7 | 203 |
| `ceil` | 203.2 | 204 |

## Bottom Toolbar

| Action | Shortcut |
|--------|----------|
| Toggle bottom toolbar | Cmd+Shift+↓ |
| Hide/show ALL chrome (left, right, bottom toolbars AND the top strip; command palette + tooltips stay; press again to restore) | Cmd+\\ |
| Presentation mode | Alt+P |
| Focus AI input | / (slash) |

### Buttons

Single horizontal row, grouped left to right with vertical dividers:

1. **Toolbar management:** Reset position, Toggle bottom toolbar.
2. **Quick palette access:** Global Search (Cmd+K), Keyboard Shortcuts (Shift+?).
3. **Tools (canvas tools dropdown buttons):** Selection Tools dropdown (Move V, Scale K, Hand H), Shape Tools dropdown (Rectangle R, Line L, Arrow Shift+L, Circle O), Drawing Tools dropdown (Pen P, Pencil Shift+P), Frame (F), Text (T).
4. **AI input area:** input field, processing/success/failure indicators, collapse chevron, connection indicator, running-agent activity bars.

Each dropdown stores the most-recently-used variant as the head icon. Stroke-only variants of Rectangle (Shift+R) and Circle (Shift+O) are accessible only by keyboard. The Snip tool (S) is accessible only via the keyboard shortcut. Scale mode (K) is presented as a sub-option of the Selection Tools dropdown rather than as its own tool: selecting it puts the Move tool into persistent scale mode.

### AI Input

Inline after the tool buttons (separated by a divider). Width is 320 px. Press **/** to focus it, type a prompt, press **Enter** to send. **Escape** unfocuses (priority 9 in the Escape stack: see Escape Behavior in `shortcuts.md`). Focusing the input opens the AI chat panel and unfocuses the input (so input continues in the chat panel).

A collapse/expand chevron toggles the input. When collapsed, only the connection indicator and the expand chevron remain. When the AI chat panel is open with an active session, the bottom toolbar shows the connection indicator instead of the full input (the chat input lives in the panel above).

The connection indicator is a small check-circle (connected) / x-circle (not connected) dot. **Click it** to jump straight to Settings -> AI Providers (Cmd+, then the AI Providers page), which is where all API keys are managed. **Hover** it to see a display-only popup of per-provider status: Claude Code, Codex, Anthropic, OpenAI, Google, OpenRouter, Quiver (plus a "Playground mode" row first when playground replay is the active path). Claude Code / Codex / Anthropic / OpenAI / Google / OpenRouter are chat providers; Quiver is an SVG generation provider (text-to-SVG and raster-to-SVG vectorization). Each row shows a green check when credentialed and a dim icon when not. The popup rows are status-only: they do not accept key input. The dot reads connected (green) if the Claude CLI is installed, any chat provider has credentials, or a replay/playground path is active.

While agents are running, one small activity bar per processing session appears at the right end of the toolbar. The submit button switches to a stop button while the user's request is processing; if the AI returns a "command not recognized" response a brief `?` indicator is shown instead. See `ai.md` for the full AI feature reference.

## Command Palette

A single floating, draggable, search-driven palette with multiple content modes: global search, commands, canvas (file) selection, font family, layer search, color selector, settings, updates, keyboard shortcuts, and combos. The list-based modes all use the same search field with a left-side filter dropdown. The category-specific shortcuts (command search, canvas search, font selector, layer search) open the same global-search palette pre-filtered to that category; chat search is just a `chats` filter on the same palette (no dedicated mode).

| Mode | Shortcut |
|------|----------|
| Global search (all categories) | Cmd+K |
| Command search | Cmd+Shift+P |
| Canvas (file) search | Cmd+P |
| Layer search | Cmd+L |
| Chat search | Cmd+Shift+I |
| Font selector | Cmd+Shift+F |
| Color selector | Ctrl+C |
| Settings | Cmd+, |
| Keyboard shortcuts | Shift+? |
| Combos | Cmd+Shift+M |
| Updates | Cmd+Shift+U (also via the Check for Updates command) |

Note: **/** focuses the AI input in the bottom toolbar (then opens the chat panel), it does not open the command palette.

All search modes support: type to search, Up/Down to navigate, Enter to execute, Escape to close, draggable title bar.

**Unified Global Search** (Cmd+K): Shows commands + files + layers + fonts + chats in one list, each section capped by the layout. The filter dropdown switches to a single category (All, Commands, Files, Layers, Fonts, Chats). The category-specific shortcuts (Cmd+Shift+P, Cmd+P, Cmd+L, Cmd+Shift+F, Cmd+Shift+I) open the same palette pre-filtered. In "all" mode, layers only run when the query is 2+ characters (otherwise the first 5 elements show as a stub) and fonts are skipped (too many entries).

### Account (Settings tab)

The Account pane is the same on desktop and the web app; each section appears only when there is data behind it. It shows the signed-in identity (name, @handle, email) with two buttons on the right of that row: **open your profile** (globe, only when the account has a handle; desktop opens `brilliant.design/{handle}` in the browser, the web app switches to the profile view in place) and **sign out**. Plan, Usage and Subscription appear where entitlements exist, on both desktop and the web app (on the web they live in Settings > Plan & billing, with a signed-in platform session). With a platform identity there is also a **Profile** section with the handle row: `@handle` at rest with a pencil to edit in place. Every account gets an auto-generated word-pair handle (like `@cozy-cactus`) at sign-up, nothing derived from the email is ever published, and it can be changed here any time. While typing, availability is checked live (taken/invalid verdicts inline); handles shorter than 6 characters are a paid tier (shown as a "Paid" chip up front, and as an upgrade hint if the server declines). Paid accounts also carry a blue badge (a blue check) on their public profile; it is derived live from the plan, so it disappears if the plan lapses. Published work lives at `brilliant.design/{handle}` (no `@` in the URL; the `@` is display convention only, and `/@{handle}` merely redirects); after a rename, old profile and project links redirect to the new handle until someone else claims the old name, and the old handle is reserved for you for 30 days.

### Sharing (Settings tab)

The project-scoped sharing surface is the **last tab in Settings, named "Sharing"** (Cmd+, then Sharing). A published project heads the pane with its `@handle/project` path, the thing being shared. It only appears when a project context exists (a published project, or an unpublished desktop folder with a signed-in identity). Opened directly from the **Sharing** command, the account-avatar menu's "Project settings" row, or the copy-link button when the folder isn't published yet. Rows:

- **Published:** a settings row with a checkmark at the end showing whether the project is live on the web. Ticking or un-ticking it is how you publish or unpublish: it never changes anything on the spot, it raises an "are you sure?" confirm on the notification rail that spells out exactly what the change means, and only that confirm's button acts. Unpublishing also asks you to type the project name into the confirm before its button arms. Links stop working immediately; the project is recoverable by support for a grace period before permanent deletion. On desktop, unpublishing leaves your local files untouched, only the cloud copy is removed, so the folder simply returns to unpublished. The checkmark follows the server, so it only clears once the unpublish really landed. Once the project is published, this row also carries two small buttons that anyone can use (not just the owner, since both are read-only): **Copy link** (copies the project's public URL, the icon flips to a check for a moment) and **Open in web** (opens the public page in your browser).
- **Visibility** (project owner only): a toggle between public and private. Flipping it doesn't change anything on the spot: like the Published row, it raises an "are you sure?" confirm on the notification rail first, and only that confirm's button acts. Going private warns that public links stop working immediately (people you've invited keep access); going public warns that anyone with the link can view it and it appears on your public profile. Private is a paid feature: if the account isn't on a paid plan, the server declines and shows a "Paid" badge, and choosing **Upgrade** opens the upgrade flow in place (an overlay modal on the web, an in-app dialog on desktop) rather than sending you to a pricing page. Checkout finishes in your browser and the app updates itself the moment the plan flips, so there is nothing to come back and click. On desktop the wait stays honest about slow payments: if confirmation takes a while it says "taking longer than expected" and keeps checking on its own, with a **Check again** button to nudge it; and if your browser will not open, it shows the checkout link as copyable text (with a retry) so you can still finish. Flipping to private stops any outstanding share links from working (private means private).
- **Audience** (project owner only): a toggle between showing your project live and showing published checkpoints only. Like Visibility, flipping it doesn't change anything on the spot: it raises an "are you sure?" confirm on the notification rail first, and only that confirm's button acts. Switching to checkpoints only warns that visitors see your published checkpoints instead of the live canvas and that anyone viewing live right now is disconnected (links keep working, they show the checkpoint face); switching back to live warns that visitors see your canvas live as you edit. Showing checkpoints only is a paid feature: on a free plan the server declines and shows a "Paid" badge with the same in-place **Upgrade** flow as Visibility.
- **Access** (owner only): who's on the project, laid out exactly like Settings → AI Providers → Custom Providers. Everyone already on it lists first, one compact row each: a green dot, the name, their @handle, the role dropdown and a remove button (the owner's row is read-only). Pending invitations follow in the same shape with a gray dot and their state ("viewer, Pending, expires in 5d"; they last 14 days) plus a re-invite button that replaces the earlier email's link. Last comes the add row: type an email, pick the role beside it (**viewer**, read-only, the default, or **editor**, can change the project), press the checkmark (or Enter) to send, or the x to clear the row. A successful invite says nothing, the new pending row above the field is the confirmation; anything that goes wrong (already a collaborator, a refused address, an invite created whose email couldn't be sent) shows in red under the field. The invitation email carries an accept link: opened signed-out it asks the person to sign in with the invited email first, then access activates on the spot (a brand-new account signing up with that email gets it automatically); the invite only works for the email it was sent to. Rows with extra to say, such as an editor grant currently held at view-only, carry an expand button that reveals it. Change a collaborator's role or remove them any time; changes take effect immediately. Inviting works on any plan, but editing a **private** project needs a paid plan on the invitee's side: a free invitee gets the project read-only with an upgrade hint until they upgrade (no re-invite needed after upgrading).

Viewers and editors see only the Published row, and cannot act on it.

**Publishing a desktop folder.** When a design folder isn't published yet, the Sharing tab shows the same Published row with its checkmark off, and the rest of the flow underneath: (1) name the project (prefilled from the folder name; the `brilliant.design/{handle}/{project}` link previews underneath, and the handle can be changed any time in Settings → Account). A name the server won't take shows a red line under the preview naming what's wrong and what to type instead, such as "Project names are lowercase. Try "my-project"."; (2) choose the visibility it goes live with in the Visibility row: public, or private on paid plans (free plans publish as public and the row says so); (3) review "What gets published", a scrollable list naming exactly what will ship, every design (`.bl`) and design-system (`.ds`) file plus the image assets your canvases actually reference (private-looking files like `.env` are flagged, never blocked). Ticking the Published row is the publish, and it's the only one: there is no separate Publish button. It raises a confirmation toast spelling out what going live means (public: anyone on the internet can see your latest work, live; private: visible only to you), and the publish only starts from that toast's Publish button; the row waits dimmed while the toast is up. A quiet **"Publishing from &lt;folder&gt;"** line at the top of the flow always names the exact folder being published (the scratch sandbox reads "Scratch workspace"), so you can never publish the wrong one by accident. While it runs, a file-by-file progress bar shows under the row **and** a pinned progress notification stays on the rail, so closing and reopening Settings still shows the upload in progress; the same repository can't be published twice at once. Then the first checkpoint is created, the link is copied, and the folder becomes Published. If the name is already taken by a different project of yours, publishing stops with **"You already have a project named "X". Choose a different name."** and writes nothing: it never overwrites an existing project. Only design files and referenced assets ship, never your `.brilliant` folder, git history, or unreferenced files. Visitors of a public project see your latest work live; a Pro option can limit them to checkpoints (the Audience row once published).

**Copying the link when published.** Once published, the copy-link button copies a shareable deep link to the current canvas (selection-aware). If you've edited locally since the last publish, the toast says the link doesn't include your latest changes yet and offers **Publish latest** to push them. On desktop the **Checkpoint** button also pushes the latest work to the public copy (rather than making a local git commit) once the folder is a published project.

**Publishing a drop.** With elements selected, **Publish drop** (command palette; right-click the selection on the canvas; or right-click a layer row in the Layers panel; needs a signed-in account) shares the selection as a standalone drop at `brilliant.design/{handle}/drops/{slug}` (older `/drops/{handle}/{slug}` links redirect there). The confirm toast carries three optional fields you can fill inline before pressing Publish (or Enter): **Title** (prefilled from the selection's name; it also seeds the URL slug), **Subtitle**, and **Tags** (chips: type and press comma or Enter to add, up to 5 lowercase-kebab tags such as `dark-mode`; an invalid tag shows the reason under the field). It also carries a **Private** toggle: drops publish **public by default** (they appear on your profile and anyone with the link can view them); flipping Private on publishes the drop **visible only to you**. Private drops are a paid feature, so on a free plan the toggle is locked to public. The text fields are optional: Publish fires immediately with whatever the fields hold, and you can edit them later from the drop's **Settings** tab (there is no separate edit affordance on the drop's page or its tile), including switching a drop between public and private. On success the drop's link lands on the clipboard. **Import drop from link** pastes a copied drop URL's contents onto the current canvas. Right-clicking from the **Layers** panel is often easier than the canvas when you want a whole parent frame, because on the canvas the click lands on whichever child sits under the cursor, while a layer row targets exactly the layer you clicked.

**Publishing part of a project as its own project.** **Publish as new project** (command palette; or right-click an element selection; or right-click one or more canvases in the file explorer) makes a brand-new project out of just that subset instead of the whole workspace. The route picks the subset: the selected elements, the canvases you right-clicked, or, run with nothing selected, the current canvas. It raises a "Create a new project from this?" confirm with a name field. The name can be anything you like: type it however reads best, spaces and capitals and all. A small preview under the field shows the dashed web address it becomes (so "My Cool Project 2" previews as `my-cool-project-2`); the only names it won't take are an empty one and one made purely of symbols (which leaves no address), and it says so. On confirm the new project is created and opened in its own tab. On desktop it is created on your device first, and publishing it to the cloud (and picking its visibility) is then the usual explicit act on that new project's Sharing tab (if your account connection isn't ready yet, it tells you the project was created locally and points you to finish). This needs a signed-in account, but you don't have to sign in first: running it signed out opens the sign-in door and then continues, so it never dead-ends. It is separate from publishing the whole folder and from a drop, giving a slice of your work a full project of its own.

### Keyboard Shortcuts View (Shift+?)

A floating palette mode for viewing and customizing every command's keybinding.

- **Search**: filter by command name, group, or keybinding text.
- **Two-column scrollable layout**: commands grouped by category (Drawing Tools, Selection & Editing, Canvas, Color, Effects, Auto Layout, etc.).
- **Per-row actions on hover:** record (reassign), trash (clear), reset (restore default: only shown when modified).
- **Click a command name** to execute it immediately. Useful for unbound commands.
- **Info button (i)**: hover to see the command's description and its "Active when" activation context.
- **Conflict detection**: warning triangle on conflicting shortcuts with a filter button (also a triangle) in the search bar to show only conflicts.
- **Activation context (read-only)**: the info (i) button on a row reveals the command's description and its activation condition ("Always active", or "Active when ..." with names like `Has Selection`, `Multiple Selected`, `Auto Layout Selected`, `Frame Selected`, `Component Instance Selected`, `Editing Text`, `AI Input`, `Vector Edit Mode`, `Code Editor`). This is display-only: it tells you which command wins a shared shortcut, but there is no UI control to re-scope a command's activation. Resolve conflicts by rebinding, not by changing the context.

See `shortcuts.md` -> "Customizing Shortcuts" for activation-context details and conflict resolution.

## Web Platform (brilliant.design)

Published projects live at `brilliant.design/{handle}/{project}`. Profiles (`brilliant.design/{handle}`) and the web editor share one persistent GitHub-style shell:

- **Site navbar** (always on top): brand, search (Cmd+K command palette), the New menu, and the account menu. It stays mounted while you browse profiles and open, create, or switch projects.
- **Profile tab bar** under the navbar: the OWNER's Overview / Projects / Drops / Stars tabs. Viewing `/{handle}/{project}` shows `{handle}`'s tabs (no tab highlighted while the editor is open); clicking a tab goes to that owner's profile view. Leaving for a profile tab keeps the editor loaded in the background, so returning to the project is instant.
- **The content area** below shows either the profile view or the editor. Canvas deep links (`/{handle}/{project}/{canvasName}`, plus `?sel=` for a selection) open that canvas directly, and the address bar follows as you switch canvases.
- **Links are resilient.** A link keeps working as the project evolves: if the canvas was moved or renamed since the link was made, it opens at its new location (the address bar updates and a small note says so); if it no longer exists, the project's first canvas opens with a note. Selected element ids in `?sel=` that no longer exist are simply dropped; the still-existing ones are selected, or the canvas just fits to content. A link only fails when the project itself is gone or private.

**Project pages: Canvas, History and Settings.** An open project adds its own tab cluster beside the owner's profile tabs: **Canvas** (the editor), **History**, and, for the owner only, **Settings**. History and Settings are full pages (the editor unmounts while they are open), at `brilliant.design/{handle}/{project}/history` and `.../settings`.

- **History** is a filterable timeline of the project's checkpoints: a live-work row at the top, then the saved checkpoints below. Each checkpoint is either one you **named** or an **automatic** one the app saved as it went, so you can filter by named or automatic, filter by author, or search the checkpoint text; expanding a checkpoint shows which canvases changed in it. **New checkpoint** freezes the current work as a named checkpoint. The owner can **Restore** any checkpoint, either the whole project or a single canvas, behind a confirmation, and a restore first saves your current unsaved work as its own checkpoint so nothing is lost.
- **Settings** (owner only) is where you **rename** the project (the confirm reminds you that links to the old name keep redirecting until you reuse the name; renaming a project that serves as your profile README removes the README), change its visibility and audience, manage collaborators, and create **share links**. A rename follows the project everywhere it is open: desktop tabs and synced folders pick up the new name live with a small notice, and other web editors re-open in place at the new address.

**Share links** are a read-only door to a **private** project: anyone with the link can view it without signing in, and can never edit. They live in the project Settings page and are a **paid** feature to create (a public project offers none, since its address is already viewable). Each link is a short `brilliant.design/s/...` address you copy, it never expires, and it keeps working **until you revoke it**. Flipping the project back to public, or revoking a link, cuts off that access right away.

**The playground** (`brilliant.design/playground`, no account needed): a scratch editor with starter prompt pills in the chat. Picking a prompt replays a real agent session building live on the canvas; everything it makes is a real, editable element. Nothing in the playground persists until you sign in and keep the design as a project; keeping it turns the canvas you are looking at into your project in place (the address becomes `/{handle}/{project}`, nothing reloads, and edits save from then on). The chat transcript itself is not kept.

**The onboarding walkthrough** is one guided step, the same on the desktop app and in the playground. It runs once (per install, or per browser): pick a starter prompt and watch your agent generate real, native elements. The card waits for you to click a prompt; there is no skip button and Esc does not close it. It is a recording, so clicking it spends nothing. When the build finishes, the canvas glides to center the result. `Reset onboarding` (command palette) re-arms it.

**The New menu** (the "+" in the navbar, signed in only) is one panel with two actions:

- **New project**: a single click instantly creates an empty project named `untitled` (then `untitled-2`, `untitled-3`, ... when taken) and opens it in the editor. No name prompt; rename later from project settings.
- **Create from Figma**: paste a Figma file link into the inline field and press the button. It creates a project named after the file and imports the whole file (every page becomes a canvas). If your Figma account isn't connected yet, the same button routes through Figma sign-in first and returns you to the menu with the link preserved.

A profile page's empty-state "Create your first project" card is the same single click: it instantly creates `untitled` and opens the editor (no dialog).

**Account settings** (`brilliant.design/settings`, via the account menu → Settings): the handle editor, and the Danger Zone with **Delete account**. Deletion asks for confirmation twice and requires typing your handle (verified server-side). It removes projects and drops immediately (permanently deleted after a 30-day window, no undo past it), keeps forks other people made of your public work, holds the freed handle for 30 days, and signs you out on every device. An active paid subscription (or being a team's only admin) must be resolved first: the request is refused with a message naming what to cancel or transfer. Returning later means signing up as a brand-new account.

## Color Picker

Open by clicking any color swatch or pressing **Ctrl+C**.

### Layout (top to bottom)

- **Type chips**: A horizontal row of fill-type categories: Solid, Gradient, Static, Animated, Filters. Solid applies directly on click; each other chip opens a dropdown with that category's types (same options, icons, and live hover preview as the fill-type dropdown in the right toolbar). The chip whose category holds the current type shows the type's name and icon. Picking a type whose controls live in the right toolbar (a static effect, an animated shader, or a filter) closes the picker and expands that fill/stroke row's extended options instead; Solid, gradients, and Image keep the picker open. Hidden for solid-only targets (canvas background, layout grids, effect colors, text selections).
- **Color rectangle**: X = saturation, Y = brightness (drag to pick color)
- **Eyedropper + Hue slider row**: Eyedropper toggle button (Ctrl+Shift+C) + hue slider (360-degree spectrum)
- **Opacity slider row**: Opacity slider (0%--100%)
- **Gradient bar**: Gradient stops editor with add/remove/move controls (only shown in gradient mode)
- **Format inputs**: Format selector dropdown (Hex, RGB, HSB, CSS) + color value fields + copy button
- **Image mode**: When an image fill swatch is clicked, the color picker switches to image mode with file selection, drag-and-drop, and Cmd+V paste support

### Bottom Section (always shown)

- **Design tokens**: Color tokens from the active design system (if any)
- **Canvas colors**: Unique colors currently used on the canvas
- **Recent colors**: Recently used colors (separated by a divider)

### Eyedropper (Ctrl+Shift+C)

Toggles the eyedropper / color-pick mode. Cursor follows the pointer with a magnified pixel-grid loupe; click anywhere on the screen to sample that pixel's color into the active swatch. Esc cancels (priority 2 in the Escape stack: see `shortcuts.md`).

## Code Editor

When opening a non-design file (`.md`, `.dart`, `.json`, `.txt`, etc.) from the file explorer, a CodeMirror 6 text editor replaces the canvas. The breadcrumb's last segment is the editable file name.

- Syntax highlighting for common languages, including SCSS/Sass, Less, Vue, Svelte, and PHP. `.ds` design-system files highlight with a dedicated DSL grammar (comments, tokens, `$refs`, generator calls). Extensionless Makefile, Dockerfile, LICENSE, and README open as text with a sensible mapping.
- Vim mode (no default shortcut) is toggleable and reads vimrc-style mappings from disk; the active vim mode (NORMAL / INSERT / VISUAL) shows in the top toolbar.
- Find / replace uses standard CodeMirror keybindings (Cmd+F inside the editor); the "Find in File" palette command focuses the editor and opens the search panel. Read-only files (over 5 MB, view-only) show find without replace.
- Font size: Cmd+= / Cmd+- / Cmd+0 inside the editor grow / shrink / reset (range 9 to 32, persisted). While the editor is focused, Cmd+0 is font reset rather than the chat-session shortcut.
- Line wrap: on by default; the "Toggle Line Wrap" palette command turns wrapping off/on (persisted).
- Line editing: move line up/down (Alt+Up/Down), copy line up/down (Shift+Alt+Up/Down), delete line (Cmd+Shift+K), insert line below/above (Cmd+Enter / Cmd+Shift+Enter), toggle comment (Cmd+/, language aware: `//` in `.ds`, `/* */` in CSS). All are real commands: rebindable in the shortcuts UI, runnable from the palette while a text file is open.
- Multi-cursor: select next occurrence (Cmd+D), select all occurrences (Cmd+Shift+L), add cursor above/below (Cmd+Alt+Up/Down), Option+Click adds a cursor, Option+drag makes a column selection.
- Occurrence highlights: selecting a word subtly highlights its other occurrences in the file.
- Color swatches: in `.ds` and CSS/SCSS/Sass/Less files, a small color chip renders before each hex color (`#rgb`, `#rrggbb`, `#rrggbbaa`).
- Dirty state shows by dimming the last breadcrumb (60% opacity); auto-save persists to disk.

### Markdown preview (split view)

Opening a `.md` file shows the source in the code editor on the left and a live rendered preview on the right, separated by a draggable divider. The "Toggle Markdown Preview" palette command shows/hides the preview pane.

- The preview renders the same Brilliant Markdown dialect as brilliant.design (project READMEs, profile pages), and it supports essentially everything markdown supports: CommonMark plus GitHub Flavored Markdown (tables, task lists, strikethrough, and autolinks including bare `www.`/URL links), GitHub footnotes (`text[^1]` with a `[^1]: …` definition, collected into a linked section at the end), and GitHub alerts (`> [!NOTE]`, `[!TIP]`, `[!IMPORTANT]`, `[!WARNING]`, `[!CAUTION]` render as coloured callouts). HTML entities decode (`&copy;` → ©), link and image titles show on hover, loose lists (blank lines between items) breathe more than tight ones, and nested ordered lists cascade their markers (1. → a. → i.). Raw HTML never executes: a `<script>` or any tag is shown as inert text, and only http/https/mailto/tel links and https images are kept. What you see in the preview is what a reader sees on the web.
- Fenced ` ```blueprint ` blocks render as live design viewports, sized to the design's own proportions. Lines copied straight out of a canvas document work as fence content. A block that cannot render says why (for example an unrecognized token) instead of showing a blank box.
- Fenced code blocks are syntax-highlighted (JavaScript/TypeScript, Python, JSON, YAML, HTML, CSS, SQL, Rust, C++, Java, PHP, Go, Dart, shell, and more) in both light and dark themes; unknown languages render as plain code. Each block carries a copy button.
- The preview updates live as you type, follows the app theme, and works fully offline.
- HTML preview mode is available for `.html` files.
- File switching is via the file explorer or canvas/file navigation shortcuts. While the editor is focused, plain Alt+Left/Right is word motion; Cmd+Alt+Left/Right switches files.
- Copy / cut / paste (Cmd+C/X/V), select all (Cmd+A, also Edit > Select All), Tab indent, and Cmd+K global search all work inside the editor. Standard macOS text chords work too: Cmd+arrows (line/document boundaries, Shift extends), Option+Delete (word delete), Cmd+Delete (delete to line start), double-click word / triple-click line selection.
- Right-click opens a context menu: Cut / Copy / Paste / Select All plus Find in File and Go to Line. Items follow editor state (no selection disables Copy/Cut; read-only files disable Cut/Paste).
- Go to line: Ctrl+G inside the editor (or the "Go to Line" palette command) opens the line-jump panel.
- Escape defocuses the editor back to the file (in vim mode only from NORMAL mode; INSERT/VISUAL keep Esc for the mode exit). Clicking the margin around the editor card does the same.
- With the command palette open, Escape or a click anywhere on the editor closes the palette and returns typing focus to the editor (same as clicking the canvas closes the palette).
- While a text or image file is open, the left toolbar shows only the file explorer (the layers panel returns when a canvas is active).

When the code editor is focused, undo/redo (keyboard and Edit menu) is captured by the editor, not by the canvas undo history. Each file keeps its own undo history, caret position, and scroll offset across file switches.

If the open file changes on disk while you have unsaved edits, a conflict notice offers Reload (take disk), Keep mine, or Review changes. Review opens a side-by-side diff (disk on the left, your edits on the right, editable for manual merging) with Accept disk / Keep mine on the pinned notice; switching files resolves as Keep mine.

## AI Chat Panel

The chat panel surfaces AI design sessions above the bottom toolbar. Multi-provider: Claude Code (local CLI), Codex (local CLI, ChatGPT subscription), Anthropic HTTP, OpenAI HTTP (Chat Completions + Responses API), Google Gemini, and OpenRouter all run through the same UI. BYOK only: every chat call uses the user's own API key (or local Claude CLI). On the Free plan the built-in chat is capped at 10 messages a day (it counts messages you send, even with your own key); at the wall you can Upgrade or Continue via MCP, and external MCP agents stay unlimited on every plan. See `ai.md` for providers, models, slash commands, attachments, the daily cap, and tool execution.

### Session Tabs

Tabs sit inline in the bottom toolbar after the tool buttons (sessions occupy the bottom strip):
- Click a tab to expand or collapse the chat panel for that session
- Drag tabs to reorder; horizontal scrolling kicks in once the row exceeds available width
- Double-click a tab to rename (Esc to cancel)
- X to close
- Minimized session tabs collapse to a compact width; expanding a session opens the resizable chat panel (width clamped 300–1200 px)
- Cmd+1..9, Cmd+0 (Windows: Alt+1..9, Alt+0) jump to and expand session 1..10
- Cmd+Shift+] / Cmd+Shift+[ cycle between sessions
- Cmd+W closes the focused chat
- Cmd+Shift+A toggles the Chat Explorer (when AI chat is open)

### Expanded Panel

- **Header:** topic, canvas link, copy-as-markdown button, layout buttons (full screen / bottom half / right half / left half: no default keybindings), minimize, close.
- **Skill badges:** loaded skill categories when applicable.
- **Conversation:** messages stream in with newest at the bottom; text is selectable; supports inline mentions / attachments.
- **Input bar:** attach button (image, file, screenshot, canvas reference), model selector (per session), thinking-level selector (provider-dependent), context-usage indicator, send / stop button. There is no in-panel undo/redo: undo/redo applies to the active canvas via Cmd+Z / Cmd+Shift+Z.

### Resize

- **Width:** drag the side edge to resize the chat panel; width is clamped to 300–1200 px. The minimum width can rise temporarily for some sessions (e.g., during Claude Code setup onboarding).
- **Height:** drag the top edge of the panel. It stops at the height the panel's own chrome needs (header, badges, composer), which grows with the UI density setting. As the panel gets shorter the transcript gives up space first, then the composer input shrinks toward one line; it scrolls, so nothing typed is lost.

---

## Feedback

Feedback rides a **CTA notification** on the right-side notification rail (not a
floating window): a title, a subtitle, one free-text field, a primary **Send**
(Cmd+Enter / Ctrl+Enter) and a secondary **Cancel**. Because it carries a field
and actions, the rail HOLDS the card until you act. There are no attachment
checkboxes; v1 attaches nothing about your world.

It opens from four doors: the **Send Feedback** command (command palette), an
agent calling the `send_feedback` tool, the one post-error popup, or a remote
targeted prompt the team pushes to you. The remote prompt is **ambient**: it
does not grab the keyboard or steal focus, it just waits on the rail with its
own heading until you answer or dismiss it.

`/feedback` in the AI chat input does NOT open the card. It first asks you to
classify the feedback (bug, feature request, question or issue, or praise) on a
quick card, then submits a routing turn to the agent that carries your class as
context. The agent loads the playbook and picks the best destination (the card,
a GitHub issue, email, or Discord) per the consent gradient.

Nothing is attached or sent until you press Send: the press is the consent. An
agent can pre-fill the text; it cannot press Send.

Full detail: `feedback.md`.

## Combos

Combos are saved command sequences (macros) that execute multiple actions with a single trigger. Open the Combos panel with **Cmd+Shift+M**.

### Built-in Highlighter Presets

Brilliant includes four highlighter presets that switch to pen tool with semi-transparent color at a specific size:

| Combo | Shortcut |
|-------|----------|
| Yellow highlighter | Ctrl+Shift+Y |
| Red highlighter | Ctrl+Shift+R |
| Green highlighter | Ctrl+Shift+G |
| Blue highlighter | Ctrl+Shift+B |

### Creating Custom Combos

1. Open **Cmd+Shift+M** to open the Combos panel
2. Enter an **icon name** (SF Symbols name, defaults to "star")
3. Enter a **combo name**
4. Click **Add Command** and search for commands to add
5. Reorder commands with up/down arrows, edit or remove as needed
6. Click **Create** to save

Combos chain commands in sequence with a small delay between each. You can include any command: tool changes, color changes, size adjustments, even other combos.

### Managing Combos

In the "Existing combos" section:
- **Hover** a combo to reveal edit (pencil) and delete (trash) icons
- **Click the keybinding area** to assign a custom shortcut
- **Edit** to modify name, icon, or command sequence

### Example Use Cases

- **Quick annotation modes**: Switch tool + color + size in one keystroke
- **Workflow shortcuts**: Chain frequent action sequences
- **Presentation presets**: Set up specific tools for presenting

Combos persist across sessions (stored in `~/.config/brilliant/combos.json`).

---

## Context Menus

**Right-click on element** (in order): Select This Item + Add to Selection (if not already selected), Cut, Copy, Copy as (PNG, PNG @2x, PNG @4x, WebP, SVG, HTML, React, CSS, Blueprint), Send to (Figma; enabled only when the Figma plugin is paired), Paste, Duplicate, Delete, Rename, Group/Ungroup/Add Auto Layout + Operations submenu (Union, Subtract, Intersect, Exclude, Mask) when 2+ elements, Component submenu (Create Component, Create Instance, Detach Instance, Go to Master, Reset Overrides, Push Overrides to Master) when applicable, Arrange (Bring to Front, Bring Forward, Send Backward, Send to Back), Align & Transform (for multi-selection: Align Left/Right/Top/Bottom, Align Horizontally/Vertically, Distribute Horizontally/Vertically; always: Flip Horizontally/Vertically, Scale Up/Down, Fit to Parent), Select Parent (for nested elements), Toggle Clip Content (for frames), Export as (PNG, PNG @2x, PNG @4x, SVG, Replay), Text submenu (for text elements: Bold, Italic, Underline, Align Text Left/Center/Right, Size Auto Size/Auto Height/Fixed Size, Switch Font), View (Zoom to Elements, Center on Elements).

**Right-click with selection** (items selected, click on selected element): Shows "[N] items selected" header, then same structure as element menu but operating on the full selection. Includes Canvas submenu (Toggle Background, Whiteboard, Blackboard, Toggle Alignment Guides).

**Right-click on empty canvas**: Paste, Select All, Create submenu (Text, Rectangle, Circle, Line, Arrow, Pencil, Frame), Canvas submenu (Toggle Background, Whiteboard, Blackboard, Toggle Alignment Guides, Clear All Elements), Import..., Export as (PNG, PNG @2x, PNG @4x, SVG, Replay).

**File explorer right-click on files**: Open, Rename, Cut, Copy, Paste, Duplicate, Delete, Reveal in Finder, Copy Filename, Copy Relative Path, Copy Absolute Path.

**File explorer right-click on folders**: Expand/Collapse, Rename, New Canvas, New Folder, Cut, Copy, Paste, Duplicate, Expand All, Collapse All, Delete, Reveal in Finder, Copy Relative Path, Copy Absolute Path.

**File explorer right-click on empty space**: Select All, New Canvas, New Folder, Paste, Expand All, Collapse All.

**Layers explorer right-click on element**: Select (if not selected), Rename, Arrange (Bring to Front, Bring Forward, Send Backward, Send to Back), Align & Transform (Center Horizontally, Center Vertically, Flip Horizontally/Vertically, Scale Up/Down, Fit to Parent), View (Zoom to Elements, Center on Elements), Copy, Cut, Duplicate, Text submenu (for text elements), Shape options (for rectangles), Color submenu, Delete.
