---
name: "knowledge-ui"
description: "All UI panels in Brilliant: top toolbar, left toolbar, right toolbar, bottom toolbar, command palette, color picker, code editor, Claude Code chat, combos, and context menus."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# UI Panels

## Top Toolbar

Centered at the top of the screen. Displays workspace breadcrumbs showing the navigation path: **Workspace > Folder > Canvas**.

- **Double-click** the canvas name (last breadcrumb) to **rename** it inline. Press **Enter** to confirm, **Escape** to cancel.
- **Hover** the toolbar to reveal a **copy path** button (left side). Click it to copy the full filesystem path of the current canvas's `.design` file to the clipboard.
- **Notification indicator** — a small blue dot appears on the top-right corner when there are pending notifications. Hover the toolbar to show a **clear notifications** button (right side).
- **Unsaved changes** are indicated by dimmed breadcrumb text (60% opacity); saved state shows at full brightness (90% opacity).
- Color-suffixed folders/canvases display their assigned color in the breadcrumb text.
- **Vim mode indicator** — when editing a text file with vim mode enabled, the current vim mode (NORMAL, INSERT, etc.) is shown before the breadcrumbs.

## Left Toolbar

Contains the **File Explorer** (top) and **Layers Explorer** (bottom) displayed simultaneously in a vertically split layout. Drag the divider between them to resize each panel's share of the toolbar height.

The header (top-right) has: reset position, close (toggle left toolbar), and account avatar buttons.

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
| Expand/collapse all | Cmd+/ |

### Sections

**Header** — Reset position, close (toggle right toolbar), and toggle sections (expand/collapse all) buttons on the left. Zoom percentage (drag to adjust, or click for preset dropdown) on the right.

**Canvas Section** — Background color swatch and toggle (visible when Move tool is active and nothing is selected).

**Current Stroke / Current Fill Sections** — Default stroke and fill color controls for newly created elements. Always visible. When elements are selected, these sections also apply changes to the selected elements' strokes/fills (subtitle shows "+ selected").

**Element Section** — Rows in order: X/Y position, W/H with constrain proportions toggle, sizing behavior (hug/fill/fixed, shown for elements inside auto layout frames or parent elements), rotation and opacity, corner radius (expand for per-corner or top/bottom pairs) and flex (for auto layout children), circle arc properties (start angle, sweep, inner ratio for circle elements). In vector edit mode with nodes/handles selected: shows node/handle position and point type instead of W/H/rotation/opacity. More (expandable): blend mode, scale, align buttons, arrange buttons, boolean operations (union, subtract, intersect, exclude — shown when 2+ elements selected).

**Parent Section** — Parent Type dropdown (Frame, Group, Auto Layout, Union, Subtract, Intersect, Exclude, Mask), Clip Content toggle, auto layout controls (direction, main/cross alignment, gap spacing, padding — shown when type is Auto Layout).

**Typography Section** — Rows in order: font family (click to open font selector) + font size + text direction toggle, line height + letter spacing, font weight dropdown + text sizing mode (Auto Size, Auto Height, Auto Width, Fixed), text alignment (left/center/right) + italic toggle + underline toggle.

**Strokes Section** — Color swatch, thickness, position per stroke. Stroke caps (start/end for open paths and arcs, unified cap for complex vectors). Add/delete buttons.

**Fills Section** — Color swatch per fill. Add/delete buttons. For vector elements with regions, shows per-region fill controls. Clicking an image fill swatch opens the color picker in **image mode** (select file, drag-and-drop, or Cmd+V paste to replace).

**Selection Colors Section** — Unified color editing showing all unique colors from fills and strokes across the selection, with color swatches for each.

**Effects Section** — Drop shadow, outer glow, element blur. Add/remove effects, toggle visibility, configure properties per effect. Inner shadow, inner glow, and background blur are fill types in the Fills section.

**Layout Guides Section** — Layout guide editing for frames (columns, rows, grid).

**Export Section** — Export options for the current selection.

**Import Section** — Figma file import controls (section title is "Import").

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

### Buttons

All buttons are in a single horizontal row. From left to right:

Reset position, Toggle toolbar | Global Search (Cmd+K), Keyboard Shortcuts (Shift+?) | Selection Tools dropdown (Move, Scale, Hand), Shape Tools dropdown (Rectangle, Line, Arrow, Circle), Drawing Tools dropdown (Pen, Pencil), Frame (F), Text (T) | AI input field or connection indicator.

Groups are separated by vertical dividers. The first group contains toolbar management buttons, the second group contains quick-access command palette buttons, the third group contains drawing tool buttons, and the fourth group contains the AI input area.

Snip (S) is accessible via keyboard shortcut only.

### AI Input

The AI input field appears inline after the tool buttons (separated by a divider). Press **/** to open AI chat, type a message, press **Enter** to send. **Escape** unfocuses. A collapse/expand chevron toggle allows hiding the AI input to save horizontal space. When collapsed, only the connection indicator and expand chevron are shown.

When AI chat is open, the bottom toolbar shows a connection indicator instead of the full input field (chat input moves to the chat panel above).

When an AI agent is running, small colored activity indicator bars appear next to the toolbar for each processing session. A "Claude is designing..." status text appears during complex queries, with a stop button to cancel.

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

## Claude Code Chat

The bottom toolbar integrates with Claude Code for AI-assisted design tasks.

### Session Management

Session indicators appear to the right of the AI input:
- Click to expand/minimize the chat panel
- Drag to reorder sessions
- X button to close

### Chat Panels

Expanded sessions show:
- **Conversation history** — Messages scroll with newest at bottom
- **Input field** — Type messages, attach context
- **Header** — Topic name (double-click to rename), minimize/close buttons

### Attachments

Add context to messages using the attachment buttons:
- **Elements** — Attaches selected element summaries
- **Images** — Paste from clipboard or pick a file
- **Files** — Attach any file for reference

### Keyboard

| Action | How |
|--------|-----|
| Stop processing | Type `/stop` in input, or click the stop button |
| Queue follow-up | Send while processing — executes when ready |
| Unfocus input | ESC |
| Close active session | Cmd+W |
| Focus session 1-9 | Cmd+1 through Cmd+9 |
| Focus session 10 | Cmd+0 |
| Next session | Cmd+Shift+] |
| Previous session | Cmd+Shift+[ |
| Toggle chat explorer | Cmd+Shift+A |
| New chat | Cmd+N (when chat is focused) |
| Chat search | Cmd+Shift+I |

### Resize

- **Width** — Drag between sessions or at panel edges (160-640px range)
- **Height** — Drag top edge of panel (120px minimum, max fills available screen space)

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
