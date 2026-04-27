---
name: "knowledge-ui"
description: "All UI panels in Brilliant: top toolbar, left toolbar, right toolbar, bottom toolbar, command palette, color picker, code editor, Claude Code chat, combos, and context menus."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# UI Panels

## Top Toolbar

Centered at the top of the screen. Displays workspace breadcrumbs showing the navigation path: **Workspace > Folder > Canvas**.

- **Double-click** the canvas name (last breadcrumb) to **rename** it inline. Press **Enter** to confirm, **Escape** to cancel.
- **Hover** the toolbar to reveal a **copy path** button. Click it to copy the full filesystem path of the current canvas's `.design` file to the clipboard. Tooltip flips to "Copied!" for one second after click.
- Color-suffixed folders/canvases display their assigned color in the breadcrumb text. The suffix (e.g. `.blue`) is preserved during inline rename.
- The last breadcrumb is bold; earlier breadcrumbs are slightly dimmer.

There is no save chip and no notification indicator in the top toolbar. Auto-save runs in the background via `AutoSaveManager` with a 500 ms debounce; there is no top-toolbar UI for it.

## Window Modes

Brilliant runs in two window modes, switched on a single window:

- **Studio** (default): a regular desktop window with title bar, shadow, resizable. Visible in the Dock. Launched on startup.
- **Overlay:** a borderless, always-on-top, transparent fullscreen layer above other apps. Hidden from the Dock. Summoned and dismissed via a global hotkey that works even when Brilliant is unfocused.

| Action | Shortcut |
|--------|----------|
| Toggle overlay mode (global) | Ctrl+F |
| Toggle passthrough (overlay only) | Ctrl+A |
| Toggle desktop icons (overlay only) | Ctrl+I |

In passthrough mode (overlay only), mouse clicks pass through Brilliant to the apps below. Studio window state (position, size, fullscreen, maximized) is saved before entering overlay and restored on exit.

In overlay mode a small status dot appears at the top-left of the screen.

## Left Toolbar

Contains the **File Explorer** (top) and **Layers Explorer** (bottom) displayed simultaneously in a vertically split layout. Drag the divider between them to resize each panel's share of the toolbar height.

The header is right-aligned and shows: reset position, toggle (collapse) button, optional team chip (visible when the user belongs to a team; tappable for admins to open the team settings page), and account avatar (opens an account dropdown).

| Action | Shortcut |
|--------|----------|
| Toggle left toolbar | Cmd+Shift+← |
| Focus file explorer | Cmd+Shift+E |
| Focus layers explorer | Cmd+Shift+R |

### File Explorer

Tree hierarchy of all canvases and folders. Features: folder expand/collapse, multi-selection (Cmd/Shift+Click), right-click context menu, drag and drop, inline renaming (double-click or Enter), keyboard navigation, search/filter.

**Canvas search** (Cmd+P) opens a searchable canvas list (global search filtered to files).

### Layers Explorer

All elements on the current canvas in a hierarchical tree.

Features:
- Element type icons
- Indentation shows parent-child relationships
- Multi-selection (click to select on canvas)
- Drag to reorder (z-order)
- Inline renaming (double-click a layer row or Cmd+R)

**Layer search** (Cmd+L) opens a searchable layer list (global search filtered to layers).

**Layer order:** Top of list = front (highest z-order). Drag to reorder.

## Right Toolbar (Property Inspector)

Shows properties for selected elements. Sections appear dynamically.

| Action | Shortcut |
|--------|----------|
| Toggle right toolbar | Cmd+Shift+→ |
| Expand or collapse all sections | Cmd+/ |

### Sections (in order from top to bottom)

**Header** — Reset position, close (toggle right toolbar), and toggle-sections (expand/collapse all) buttons on the left. Zoom percentage (drag to adjust, or click for a preset dropdown) on the right.

**Canvas Section** — Canvas background color swatch and toggle. Visible only when nothing is selected and the Move tool is active.

**Current Stroke / Current Fill Sections** — Default stroke and fill color used for newly created elements. Always visible. When elements are selected, these sections also apply changes to the selected elements' strokes and fills (subtitle shows "+ selected").

**Element Section** — Rows in order: X/Y position, W/H with constrain proportions toggle, sizing behavior (hug/fill/fixed for auto layout children), rotation and opacity, corner radius (expand for per-corner or top/bottom pairs) and flex (for auto layout children), circle arc properties (start angle, sweep, inner ratio) for circle elements. In vector edit mode with nodes or handles selected: shows node/handle position and point type instead of the W/H/rotation/opacity rows. The "More" expandable area exposes blend mode, scale, align buttons, arrange buttons, and boolean operations (union, subtract, intersect, exclude) when 2+ elements are selected.

**Parent Section** — Parent Type dropdown (Frame, Group, Auto Layout), Clip Content toggle, auto layout controls (direction, 3x3 main + cross alignment grid, gap spacing, padding with progressive disclosure: unified, H/V pair, or all four sides). Auto layout controls are only shown when every selected frame is auto layout. Boolean parent types (Union, Subtract, Intersect, Exclude) and Mask are created by separate commands rather than via this dropdown.

**Typography Section** — Rows in order: font family (click to open font selector) + font size + text direction toggle, line height + letter spacing, font weight dropdown + text sizing mode (Auto Size / Auto Height / Auto Width / Fixed), text alignment (left/center/right) + italic toggle + underline toggle. Visible when the effective selection contains a text element or when the text tool is active with nothing selected.

**Selection Strokes Section** — Per-stroke color swatch, thickness, and position for the selected elements. Stroke caps (start/end for open paths and arcs; unified cap for complex vectors). Add/delete buttons.

**Selection Fills Section** — Per-fill color swatch for the selected elements. Add/delete buttons. For vector elements with regions, shows per-region fill controls. Clicking an image fill swatch opens the color picker in image mode (file picker, drag-and-drop, or Cmd+V paste to replace).

**Selection Colors Section** — Unified editor of all unique colors used across fills and strokes of the current selection (only shown when frame descendants are part of the selection).

**Effects Section** — Drop shadow, outer glow, element blur. Add and remove effects, toggle per-effect visibility, configure properties. Inner shadow, inner glow, and background blur are fill types and live in the Fills section instead.

**Layout Guides Section** — Layout grid editor for frames. Three grid types: Grid (uniform cells), Columns (vertical), Rows (horizontal). Each grid has visibility toggle, color swatch (opens color picker), expand toggle for properties, and remove button.

**Export Section** — Multi-config export panel. Each config row has: format dropdown (PNG, JPEG, WebP, SVG, PDF, MP4, MOV), resolution preset (Original, 2x, 3x, 4x, 1080p, 4K, Custom), expand for advanced options (width/height with constrain-proportions, background, video codec for MP4/MOV), and a remove button. Add multiple configs with the + button to export several formats in one click.

**Figma Import Section** — Figma file import. Visible only when nothing is selected and the Move tool is active (same condition as Canvas Section).

There is no dedicated "Design System" section in the right toolbar. Design tokens are integrated into the color picker (token swatches at the bottom of the Color Picker) and into property fields like font size, line height, and font weight (which can be bound to tokens). Token management lives in the design system file itself; see `design-system.md`.

The Sketch Import flow is implemented in code but is not currently wired into the right toolbar. Sketch import lands via the global Import command instead.

### Interactive Fields

Most numeric fields support: typing exact values, dragging left/right, arrow keys (Shift for larger steps, Alt for smaller).

**Math expressions:** Type any arithmetic expression and press Enter to evaluate:

| Input | Field had `200` | Result |
|-------|----------------|--------|
| `200 * 2/3` | — | 133.33 |
| `(100 + 200) / 3` | — | 100 |
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
| `200 + 10%` | — | 220 |

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

All buttons are in a single horizontal row. From left to right:

Reset position, Toggle toolbar | Global Search (Cmd+K), Keyboard Shortcuts (Shift+?) | Selection Tools dropdown (Move, Scale, Hand), Shape Tools dropdown (Rectangle, Line, Arrow, Circle), Drawing Tools dropdown (Pen, Pencil), Frame (F), Text (T) | AI input field or connection indicator.

Groups are separated by vertical dividers. The first group contains toolbar management buttons, the second group contains quick-access command palette buttons, the third group contains drawing tool buttons, and the fourth group contains the AI input area.

Snip (S) is accessible via keyboard shortcut only.

### AI Input

The AI input field appears inline after the tool buttons (separated by a divider). Press **/** to focus it, type a prompt, press **Enter** to send. **Escape** unfocuses. A collapse/expand chevron toggle hides the AI input to save horizontal space; when collapsed, only the connection indicator and expand chevron remain.

When the AI chat panel is expanded for an active session, the bottom toolbar shows a minimal connection indicator instead of the full input field (the chat input moves to the panel above).

When an AI agent is running, small activity indicator bars appear next to the toolbar for each processing session, and a stop button is available to cancel. See `ai.md` for the full AI feature reference.

## Command Palette

| Mode | Shortcut |
|------|----------|
| Global search (all) | Cmd+K |
| Command search | Cmd+Shift+P |
| Canvas search | Cmd+P |
| Layer search | Cmd+L |
| Chat search | Cmd+Shift+I |
| Font selector | Cmd+Shift+F |
| Color selector | Ctrl+C |
| Settings | Cmd+, |
| Keyboard shortcuts | Shift+? |
| Combos | Cmd+Shift+M |
| Updates | Cmd+Shift+U |

Note: **/** opens the AI chat panel (not the command palette). See AI Input section above.

All modes support: type to search, arrow keys to navigate, Enter to execute, Escape to close, draggable title bar.

**Unified Global Search** (Cmd+K) — A unified search that can filter across commands, files, layers, fonts, and chats. Individual mode shortcuts (Cmd+Shift+P for commands, Cmd+P for files, Cmd+L for layers, Cmd+Shift+F for fonts, Cmd+Shift+I for chats) open global search pre-filtered to that category.

### Keyboard Shortcuts View (Shift+?)

A full-screen panel for viewing and customizing all keyboard shortcuts. Features:

- **Search** — filter commands by name, group, or keybinding
- **Two-column layout** — commands grouped by category (Drawing Tools, Selection & Editing, Canvas, etc.)
- **Hover a row** to reveal: record (reassign), trash (remove), and reset (restore default) buttons
- **Click a command name** to execute it immediately
- **Info button (ⓘ)** — hover to see the command's description and "Active when" activation context
- **Conflict detection** — warning triangles on conflicting shortcuts, with a filter button to show only conflicts
- **Context picker** — when conflicts exist, a dropdown lets you assign activation contexts (Canvas, Has Selection, Text Editing, etc.) so the same shortcut can mean different things in different modes

See `SHORTCUTS.md` → "Customizing Shortcuts" for full details on activation contexts and conflict resolution.

## Color Picker

Open by clicking any color swatch or pressing **Ctrl+C**.

### Layout (top to bottom)

- **Color rectangle** — X = saturation, Y = brightness (drag to pick color)
- **Eyedropper + Hue slider row** — Eyedropper toggle button (Ctrl+Shift+C) + hue slider (360-degree spectrum)
- **Opacity slider row** — Opacity slider (0%--100%)
- **Gradient bar** — Gradient stops editor with add/remove/move controls (only shown in gradient mode)
- **Format inputs** — Format selector dropdown (Hex, RGB, HSB, CSS) + color value fields + copy button
- **Image mode** — When an image fill swatch is clicked, the color picker switches to image mode with file selection, drag-and-drop, and Cmd+V paste support

### Bottom Section (always shown)

- **Design tokens** — Color tokens from the active design system (if any)
- **Canvas colors** — Unique colors currently used on the canvas
- **Recent colors** — Recently used colors (separated by a divider)

### Eyedropper (Ctrl+Shift+C)

Magnified 21x21 pixel grid. Click anywhere to sample color.

## Code Editor

When opening a non-design file (e.g., `.md`, `.dart`, `.json`, `.txt`) from the file explorer, a full CodeMirror 6 text editor appears in place of the canvas. Features:

- **Syntax highlighting** for common languages
- **Vim mode** (toggleable) with vimrc config support
- **Search/replace** (standard CodeMirror keybindings)
- **Auto-save** with unsaved indicator in the breadcrumbs
- **File switching** between text files

## AI Chat Panel

The chat panel surfaces AI design sessions above the bottom toolbar. It is multi-provider: Claude Code (local CLI), Anthropic, OpenAI, Google, and OpenRouter all run through the same UI. See `ai.md` for full coverage of providers, models, BYOK setup, slash commands, attachments, and tool execution.

### Session Tabs

Tabs sit to the right of the AI input field:
- Click a tab to expand or collapse the chat panel for that session
- Drag tabs to reorder
- Double-click a tab to rename
- X button to close

### Expanded Panel

Expanded sessions show:
- **Header:** topic, canvas link, copy-as-markdown button, minimize and close buttons
- **Skill badges:** loaded skill categories, when applicable
- **Conversation:** messages stream in with newest at the bottom; text is selectable
- **Input bar:** attach button, model selector, thinking-level selector, context-usage indicator, undo/redo, send/stop

### Resize

- **Width** — drag between sessions or at panel edges (160-640px range)
- **Height** — drag top edge of panel (200px minimum, fills available screen space)

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

- **Quick annotation modes** — Switch tool + color + size in one keystroke
- **Workflow shortcuts** — Chain frequent action sequences
- **Presentation presets** — Set up specific tools for presenting

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
