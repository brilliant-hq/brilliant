---
name: "knowledge-ui"
description: "All UI panels in Brilliant: top toolbar, left toolbar, right toolbar, bottom toolbar, command palette, color picker, code editor, Claude Code chat, combos, and context menus."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# UI Panels

## Top Toolbar

Centered at the top of the screen. Displays workspace breadcrumbs in the form `Workspace / Folder / Canvas` (segments separated by a thin `/`). When the workspace is the special "Scratch" sandbox, the workspace segment is hidden.

- **Double-click** the canvas name (last breadcrumb) to rename it inline. Press **Enter** to confirm, **Escape** to cancel. Color suffixes (e.g. `.blue`) are preserved across rename.
- **Hover** the toolbar to reveal a copy-path button on the left and (if any notifications exist) a clear-notifications button on the right. Copy-path writes the full filesystem path of the current canvas's `.design` file (or the current asset path) to the clipboard. The tooltip flips to "Copied!" for one second.
- A small unread-notifications dot appears at the top-right corner of the toolbar when notifications exist and the toolbar is not hovered.
- When viewing a non-canvas asset (image preview), breadcrumb segments are the asset id split by `/`; the last segment is editable and includes the file extension.
- Color-suffixed folders/canvases display their assigned color in the breadcrumb text. The last breadcrumb is bold; earlier ones are dimmer (50% opacity). Dirty state dims the last crumb to 60% until saved.
- Drag the toolbar background to move the OS window (disabled in fullscreen / maximized; cursor turns grab/grabbing).
- When editing a text file with vim mode enabled and the code editor is focused, a small vim mode indicator (NORMAL / INSERT / VISUAL) is shown to the left of the breadcrumbs.

There is no save chip in the top toolbar: auto-save runs in the background via `AutoSaveManager` with a 500 ms debounce. The last breadcrumb's opacity is the only save-state cue.

## Window Modes

Brilliant runs in two window modes, switched on a single window:

- **Studio** (default): a regular desktop window with title bar, shadow, resizable. Visible in the Dock. Launched on startup.
- **Overlay:** a borderless, always-on-top, transparent fullscreen layer above other apps. Hidden from the Dock. Summoned and dismissed via a global hotkey that works even when Brilliant is unfocused.

| Action | Shortcut |
|--------|----------|
| Toggle overlay mode (global) | Ctrl+F |
| Toggle passthrough (overlay only) | Ctrl+A |
| Toggle desktop icons (overlay only) | Ctrl+I |

In passthrough mode (overlay only), mouse clicks pass through Brilliant to the apps below. Studio window state (position, size, fullscreen, maximized) is saved before entering overlay and restored on exit. The bottom toolbar uses an `_overlayBottomEdgeInset` of 80 px while in overlay mode (vs the standard `toolbarVerticalInset` in studio).

The overlay-mode toggle and passthrough-mode toggle are registered as global hotkeys via `KeybindingsManager`, so they work even when Brilliant is not the focused application. Reassigning these keybindings re-registers the global hotkey.

## Left Toolbar

Contains the **File Explorer** (top) and **Layers Explorer** (bottom) in a vertically split layout. Drag the divider between them to resize each panel's share of the toolbar height. Drag the right edge to resize the toolbar width. Collapses to a 20 px rail when toggled off; hovering the rail re-expands it.

The header is right-aligned. Order, left to right: reset-position button, toggle-toolbar button, then either a team chip (when user belongs to a team; admins can click to open `https://brilliant.design/team/<slug>`) or a "free" plan chip when applicable, then the account avatar (hover opens a menu with email, plan, "Switch Account", "Open Settings -> Account").

| Action | Shortcut |
|--------|----------|
| Toggle left toolbar | Cmd+Shift+← |
| Focus file explorer | Cmd+Shift+E |
| Focus layers explorer | Cmd+Shift+R |

### File Explorer

Tree of all canvases, folders, and asset files in the workspace. Features: folder expand/collapse, multi-selection (Cmd/Shift+Click), right-click context menu, drag/drop reorder and reparent, inline renaming (double-click or Cmd+R), keyboard navigation, type-to-filter. Hidden files (`.foo`) are gated by the `toggle_hidden_files` command.

Within the file explorer, undo/redo (Cmd+Z / Cmd+Shift+Z) operates on canvas/folder lifecycle (create, delete, rename, move) via a separate explorer-scoped UndoManager. Outside the file explorer, undo/redo applies to the active canvas.

**Canvas search** (Cmd+P) opens the global search palette pre-filtered to files (canvases + assets).

### Layers Explorer

All elements on the active canvas in a hierarchical tree.

Features:
- Element type icons (`LayerIcon`) per type, including component master / instance markers
- Indentation lines show parent-child relationships
- Click to select on canvas; Cmd/Shift+Click for multi-select
- Drag to reorder (changes z-order) or reparent into a frame
- Inline rename (double-click a row or Cmd+R)
- Type-to-filter via the layer-search palette

**Layer search** (Cmd+L) opens global search pre-filtered to layers.

**Layer order:** Top of list = front (highest z-order). Drag to reorder.

## Right Toolbar (Property Inspector)

Right-anchored, expandable to 240 px and collapsible to a 20 px rail. Sections appear dynamically based on the current selection and tool. Drag the toolbar to reposition; "Reset position" returns it to the right edge.

While dragging a selection rectangle that touches many elements, sections auto-collapse via the `SectionJankGuardMixin` (5-frame window, collapses if 2+ frames exceed 30 ms). They re-expand when the drag ends.

| Action | Shortcut |
|--------|----------|
| Toggle right toolbar | Cmd+Shift+→ |
| Expand or collapse all sections | Cmd+/ |

### Sections (in order from top to bottom)

The render order in code (`right_toolbar_view.dart` `_buildContentView`) is: Canvas, Current Stroke, Current Fill, Element, Parent, Typography, Selection Strokes, Selection Fills, Selection Colors, Effects (`SelectionEffectsSection`), Layout Grid, Export, Figma Import. Each section decides its own visibility internally; this list reflects the order in which visible sections appear.

**Header** (above the section stack): Reset position, toggle-toolbar (close/expand), and toggle-sections (expand or collapse all) buttons on the left. Zoom percentage on the right: drag to adjust, click to open a preset dropdown (2, 25, 50, 75, 100, 125, 150, 200, 300, 400, 600, 800, 1000, 2000, 3000, 5000).

**Canvas Section**: Canvas background color swatch and toggle. Visible only when nothing is selected and the Move tool is active.

**Current Stroke / Current Fill Sections**: Default stroke and fill used for newly created elements. Always visible. When elements are selected the subtitle reads "+ selected" and edits also apply to the selection's strokes and fills.

**Element Section**: X/Y position, W/H with a constrain-proportions toggle, sizing behavior (hug/fill/fixed per axis for auto layout children), rotation, opacity, corner radius (expand for per-corner or top/bottom pairs), flex (for auto layout fill children), and circle arc properties (start angle, sweep, inner ratio) for circle elements. In vector edit mode with nodes or handles selected: shows node/handle position and point type instead of W/H/rotation/opacity. A "More" expandable area exposes blend mode, absolute scale, alignment, arrange, and boolean operations (union, subtract, intersect, exclude) when 2+ elements are selected.

**Parent Section**: Parent Type dropdown (Frame, Group, Auto Layout; Mask and Boolean parent types are created via separate commands and shown but not chosen here), Clip Content toggle, and, when every selected frame is auto layout: direction, wrap toggle, 3x3 main + cross alignment grid, item spacing, and padding (progressive disclosure: unified -> H/V pair -> four sides). Layout guides for non-auto-layout frames live in the Layout Grid section.

**Typography Section**: Font family (click opens font selector), font size, text direction toggle; line height + letter spacing; font weight dropdown + text sizing mode (Auto Size / Auto Height / Auto Width / Fixed); text alignment (left/center/right) + italic + underline. Visible when the effective selection contains a text element or when the Text tool is active with nothing selected.

**Selection Strokes Section**: Per-stroke color swatch, thickness, and position (inside / center / outside) for the selected elements. Stroke caps (start/end caps for open paths and arcs; unified cap dropdown for complex vectors). Add / remove buttons.

**Selection Fills Section**: Per-fill swatch (color, gradient, image, shader, or image-filter fill types: inner shadow, inner glow, background blur, color adjust, noise/grain, halftone, pixelate, duotone, posterize, dither). Add / remove buttons. For vector elements with regions, shows per-region fill controls. Clicking an image fill swatch opens the color picker in image mode (file picker, drag-and-drop, Cmd+V paste).

**Selection Colors Section**: Unified editor for the unique colors used across fills and strokes of the current selection. Shown when the selection includes frame descendants.

**Effects Section**: Drop shadow, outer glow, element (layer) blur. Add and remove effects, toggle per-effect visibility, configure properties. Inner shadow, inner glow, and background blur are fill types (in the Fills section), not effects.

**Layout Grid Section**: Layout grid editor for frames. Three grid types: Grid (uniform cells), Columns, Rows. Per-grid: visibility toggle, color swatch, expand toggle for properties (count, gutter, margin, alignment, span), and remove button.

**Export Section**: Multi-config export panel. Each config row: format dropdown (PNG, JPEG, WebP, SVG, PDF, plus a Replay row for video: the replay container is a separate dropdown that selects MP4 or MOV), resolution preset (Original, 2x, 3x, 4x, 1080p, 4K, Custom), expand for advanced (width/height with constrain proportions, background, video duration / FPS / codec / quality for replay), and remove. Add multiple configs with `+` to export several formats in one click.

**Figma Import Section**: Figma file URL import. Visible only when nothing is selected and the Move tool is active (same condition as Canvas Section).

There is no dedicated Design System section in the right toolbar. Design tokens surface in the color picker (token swatches at the bottom) and in numeric property fields that accept tokens (font size, line height, font weight, corner radius, padding). Token management is in the design system file itself; see `design-system.md`.

A `SketchImportSection` widget exists in the codebase but is not mounted in `_buildContentView`. Sketch files import through the global Import command (Cmd+Shift+O) instead.

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
| Toggle all UI | Cmd+\\ |
| Presentation mode | Alt+P |
| Focus AI input | / (slash) |

### Buttons

Single horizontal row, grouped left to right with vertical dividers:

1. **Toolbar management:** Reset position, Toggle bottom toolbar.
2. **Quick palette access:** Global Search (Cmd+K), Keyboard Shortcuts (Shift+?).
3. **Tools (canvas tools dropdown buttons):** Selection Tools dropdown (Move V, Scale K, Hand H), Shape Tools dropdown (Rectangle R, Line L, Arrow Shift+L, Circle O), Drawing Tools dropdown (Pen P, Pencil Shift+P), Frame (F), Text (T).
4. **AI input area:** input field, processing/success/failure indicators, collapse chevron, connection indicator, running-agent activity bars.

Each dropdown stores the most-recently-used variant as the head icon. Stroke-only variants of Rectangle (Shift+R) and Circle (Shift+O) are accessible only by keyboard. The Snip tool (S) is accessible only via the keyboard shortcut. Scale mode (K) is presented as a sub-option of the Selection Tools dropdown rather than as its own tool: selecting it puts the Move tool into persistent scale mode (`isForceScaleOn`).

### AI Input

Inline after the tool buttons (separated by a divider). Width is 320 px. Press **/** to focus it, type a prompt, press **Enter** to send. **Escape** unfocuses (priority 9 in the Escape stack: see Escape Behavior in `shortcuts.md`). Focusing the input opens the AI chat panel and unfocuses the input (so input continues in the chat panel).

A collapse/expand chevron toggles the input. When collapsed, only the connection indicator and the expand chevron remain. When the AI chat panel is open with an active session, the bottom toolbar shows the connection indicator instead of the full input (the chat input lives in the panel above).

The connection indicator opens a hover-menu listing providers (Claude Code, Anthropic, OpenAI, Google, OpenRouter, Brilliant) with green dot for "credentialed" or dim "+" for "set API key". Clicking a row inline-prompts for the API key in the AI input field; Esc cancels.

While agents are running, one small `AgentActivityIndicator` bar per processing session appears at the right end of the toolbar. The submit button switches to a stop button while the user's request is processing; if the AI returns a "command not recognized" response a brief `?` indicator is shown instead. See `ai.md` for the full AI feature reference.

## Command Palette

A single floating, draggable, search-driven palette with multiple content modes (`CommandPaletteContent`): `globalSearch`, `commands`, `canvasSelection`, `fontFamily`, `layerSearch`, `colorSelector`, `settings`, `updates`, `keyboardShortcuts`, `combos`. Modes that share `globalSearchList` (the searchable list view) all use the same search field with a left-side filter dropdown.

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
| Updates | Cmd+Shift+U (also via `check_for_updates`) |

Note: **/** focuses the AI input in the bottom toolbar (then opens the chat panel), it does not open the command palette.

All search modes support: type to search, Up/Down to navigate, Enter to execute, Escape to close, draggable title bar.

**Unified Global Search** (Cmd+K): Shows commands + files + layers + fonts + chats in one list, each section capped by the layout. The filter dropdown switches to a single category. The category-specific shortcuts (Cmd+Shift+P, Cmd+P, Cmd+L, Cmd+Shift+F, Cmd+Shift+I) open the same palette pre-filtered. In "all" mode, layers only run when the query is 2+ characters (otherwise the first 5 elements show as a stub) and fonts are skipped (too many entries).

### Keyboard Shortcuts View (Shift+?)

A floating palette mode (`KeyboardShortcutsView`) for viewing and customizing every command's keybinding.

- **Search**: filter by command name, group, or keybinding text.
- **Two-column scrollable layout**: commands grouped by category (Drawing Tools, Selection & Editing, Canvas, Color, Effects, Auto Layout, etc.).
- **Per-row actions on hover:** record (reassign), trash (clear), reset (restore default: only shown when modified).
- **Click a command name** to execute it immediately. Useful for unbound commands.
- **Info button (i)**: hover to see the command's description and `WhenClause` "Active when" activation context.
- **Conflict detection**: warning triangle on conflicting shortcuts with a filter button (also a triangle) in the search bar to show only conflicts.
- **Context picker**: when a row has a conflict, a dropdown appears letting you scope its activation (`Canvas`, `Always`, `Has Selection`, `Multiple Selected`, `Auto Layout Selected`, `Parent Selected`, `Component Instance`, `Text Editing`, `AI Input`, `Vector Mode`, `Code Editor`).

See `shortcuts.md` -> "Customizing Shortcuts" for activation-context details and conflict resolution.

## Color Picker

Open by clicking any color swatch or pressing **Ctrl+C**.

### Layout (top to bottom)

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

Toggles `toggle_color_pick_mode`. Cursor follows the pointer with a magnified pixel-grid loupe; click anywhere on the screen to sample that pixel's color into the active swatch. Esc cancels (priority 2 in the Escape stack: see `shortcuts.md`).

## Code Editor

When opening a non-design file (`.md`, `.dart`, `.json`, `.txt`, etc.) from the file explorer, a CodeMirror 6 text editor replaces the canvas. The breadcrumb's last segment is the editable file name.

- Syntax highlighting for common languages.
- Vim mode is toggleable (`toggle_vim_mode`, no default keybinding) and reads vimrc-style mappings from disk; the active vim mode (NORMAL / INSERT / VISUAL) shows in the top toolbar.
- Find / replace uses standard CodeMirror keybindings.
- Dirty state shows by dimming the last breadcrumb (60% opacity); auto-save persists to disk; `textFileNeedsSave` drives the indicator.
- HTML preview mode is available for `.html` files.
- File switching is via the file explorer or canvas/file navigation shortcuts.

When the code editor is focused, undo/redo is captured by CodeMirror, not by Brilliant's UndoManagerRouter.

## AI Chat Panel

The chat panel surfaces AI design sessions above the bottom toolbar. Multi-provider: Claude Code (local CLI), Anthropic, OpenAI, Google, OpenRouter, and (disabled by default) Brilliant proxy all run through the same UI. BYOK only: no hosted credits. See `ai.md` for providers, models, slash commands, attachments, and tool execution.

### Session Tabs

Tabs sit inline in the bottom toolbar after the tool buttons (sessions occupy the bottom strip):
- Click a tab to expand or collapse the chat panel for that session
- Drag tabs to reorder; horizontal scrolling kicks in once the row exceeds available width
- Double-click a tab to rename (Esc to cancel)
- X to close
- Minimized session width 150 px; expanded session width 400 px (clamped 160–640 px)
- Cmd+1..9, Cmd+0 jump to and expand session 1..10
- Cmd+Shift+] / Cmd+Shift+[ cycle between sessions
- Cmd+W closes the focused chat
- Cmd+Shift+A toggles the Chat Explorer (when AI chat is open)

### Expanded Panel

- **Header:** topic, canvas link, copy-as-markdown button, layout buttons (full screen / bottom half / right half / left half: no default keybindings), minimize, close.
- **Skill badges:** loaded skill categories when applicable.
- **Conversation:** messages stream in with newest at the bottom; text is selectable; supports inline mentions / attachments.
- **Input bar:** attach button (image, file, screenshot, canvas reference), model selector (per session), thinking-level selector (provider-dependent), context-usage indicator, send / stop button. There is no in-panel undo/redo: undo/redo applies to the active canvas via Cmd+Z / Cmd+Shift+Z.

### Resize

- **Width:** drag between sessions or at panel edges (clamped 160–640 px per session; chat panel honors a 440 px floor during the Claude Code setup onboarding).
- **Height:** drag the top edge of the panel (min 200 px, fills available screen space).

---

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

**Right-click on element** (in order): Select This Item + Add to Selection (if not already selected), Cut, Copy, Copy as (PNG, PNG @2x, PNG @4x, SVG, CSS, YAML, Blueprint), Paste, Duplicate, Delete, Rename, Group/Ungroup/Add Auto Layout + Operations submenu (Union, Subtract, Intersect, Exclude, Mask) when 2+ elements, Component submenu (Create Component, Create Instance, Detach Instance, Go to Master, Reset Overrides, Push Overrides to Master) when applicable, Arrange (Bring to Front, Bring Forward, Send Backward, Send to Back), Align & Transform (for multi-selection: Align Left/Right/Top/Bottom, Align Horizontally/Vertically, Distribute Horizontally/Vertically; always: Flip Horizontally/Vertically, Scale Up/Down, Fit to Parent), Select Parent (for nested elements), Toggle Clip Content (for frames), Export as (PNG, PNG @2x, PNG @4x, SVG), Text submenu (for text elements: Bold, Italic, Underline, Align Text Left/Center/Right, Size Auto Size/Auto Height/Fixed Size, Switch Font), View (Zoom to Elements, Center on Elements).

**Right-click with selection** (items selected, click on selected element): Shows "[N] items selected" header, then same structure as element menu but operating on the full selection. Includes Canvas submenu (Toggle Background, Whiteboard, Blackboard, Toggle Alignment Guides).

**Right-click on empty canvas**: Paste, Select All, Create submenu (Text, Rectangle, Circle, Line, Arrow, Pencil, Frame), Canvas submenu (Toggle Background, Whiteboard, Blackboard, Toggle Alignment Guides, Clear All Elements), Import..., Export as (PNG, PNG @2x, PNG @4x, SVG).

**File explorer right-click on files**: Open, Rename, Cut, Copy, Paste, Duplicate, Delete, Reveal in Finder, Copy Filename, Copy Relative Path, Copy Absolute Path.

**File explorer right-click on folders**: Expand/Collapse, Rename, New Canvas, New Folder, Cut, Copy, Paste, Duplicate, Expand All, Collapse All, Delete, Reveal in Finder, Copy Relative Path, Copy Absolute Path.

**File explorer right-click on empty space**: Select All, New Canvas, New Folder, Paste, Expand All, Collapse All.

**Layers explorer right-click on element**: Select (if not selected), Rename, Arrange (Bring to Front, Bring Forward, Send Backward, Send to Back), Align & Transform (Center Horizontally, Center Vertically, Flip Horizontally/Vertically, Scale Up/Down, Fit to Parent), View (Zoom to Elements, Center on Elements), Copy, Cut, Duplicate, Text submenu (for text elements), Shape options (for rectangles), Color submenu, Delete.
