---
name: "knowledge-ui"
description: "All UI panels in Brilliant: left toolbar, right toolbar, bottom toolbar, command palette, color picker, and context menus."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# UI Panels

## Top Toolbar

Centered at the top of the screen. Displays workspace breadcrumbs showing the navigation path: **Workspace > Folder > Canvas**.

- **Double-click** the canvas name (last breadcrumb) to **rename** it inline. Press **Enter** to confirm, **Escape** to cancel.
- **Hover** the toolbar to reveal a **copy path** button (left side). Click it to copy the full filesystem path of the current canvas's `.design` file to the clipboard.
- In scratch workspace, a **Save...** chip appears to save the workspace to a named location.
- Color-suffixed folders/canvases display their assigned color in the breadcrumb text.

## Left Toolbar

Contains the **File Explorer** and **Layers Explorer**. Toggle between them using tab buttons.

| Action | Shortcut |
|--------|----------|
| Toggle left toolbar | Cmd+Shift+← |
| Focus file explorer | Cmd+Shift+E |
| Focus layers explorer | Cmd+Shift+R |

### File Explorer

Tree hierarchy of all canvases and folders. Features: folder expand/collapse, multi-selection (Cmd/Shift+Click), right-click context menu, drag and drop, inline renaming (double-click or Alt+Enter), keyboard navigation, search/filter.

**Canvas search** (Cmd+P) opens a dedicated searchable canvas list.

### Layers Explorer

All elements on the current canvas in a hierarchical tree.

Features:
- Element type icons
- Indentation shows parent-child relationships
- Multi-selection (click to select on canvas)
- Drag to reorder (z-order)
- Inline renaming (double-click a layer row or Cmd+R)

**Layer search** (Cmd+L) opens a searchable layer list.

**Layer order:** Top of list = front (highest z-order). Drag to reorder.

## Right Toolbar (Property Inspector)

Shows properties for selected elements. Sections appear dynamically.

| Action | Shortcut |
|--------|----------|
| Toggle right toolbar | Cmd+Shift+→ |
| Expand/collapse all | Cmd+/ |

### Sections

**Header** — Pin, reset position, close, and toggle sections (expand/collapse all) buttons on the left. Zoom percentage (drag to adjust, or click for preset dropdown) on the right.

**Canvas Section** — Canvas-level properties (visible when a canvas is active).

**Current Stroke / Current Fill Sections** — Default stroke and fill color controls, shown when nothing is selected. Set the default colors used by newly created elements.

**Element Section** — X, Y, W, H, sizing behavior (hug/fill/fixed), rotation, corner radius (expand for per-corner). More: scale, align buttons, arrange buttons.

**Parent Section** — Parent Type dropdown (Frame/Group/Auto Layout), Clip Content toggle, auto layout controls (direction, main/cross alignment, spacing, padding sliders).

**Typography Section** — Font family, size, weight, italic, line height, text alignment, underline toggle, text sizing mode (auto size, auto height, auto width, fixed).

**Strokes Section** — Color swatch, thickness, position per stroke. Add/delete buttons.

**Fills Section** — Color swatch per fill. Add/delete buttons.

**Colors Section** — Unified color editing for selected elements (combines fill and stroke color controls).

**Effects Section** — Drop shadow, outer glow, element blur. Add/remove effects, toggle visibility, configure properties per effect. Inner shadow, inner glow, and background blur are fill types in the Fills section.

**Layout Grid Section** — Layout grid editing for frames (columns, rows, grid).

**Export Section** — Export options for the current selection.

**Figma Import Section** — Figma file import controls.

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

### Tool Buttons (Left Side)

Selection Tools dropdown (Move, Hand), Shape Tools dropdown (Rectangle, Line, Arrow, Circle), Drawing Tools dropdown (Pen, Pencil), Frame (F), Text (T). Snip (S) and Eraser (E) are accessible via keyboard shortcuts only.

### AI Input (Center)

Type natural language commands. Press **/** to focus, type command, press **Enter** to execute, **Escape** to unfocus. **Ctrl+C** clears the input when focused. Command history is preserved.

Access AI input by pressing **/** or clicking the text field in the bottom toolbar.

## Command Palette

| Mode | Shortcut |
|------|----------|
| Command search | Cmd+Shift+P |
| Canvas search | Cmd+P |
| Layer search | Cmd+L |
| Font selector | Cmd+Shift+F |
| Color selector | Ctrl+C |
| Settings | Cmd+, |
| Keyboard shortcuts | Shift+? |
| Combos | Cmd+Shift+M |
| Updates | Cmd+Shift+U |
| AI input | / |

All modes support: type to search, arrow keys to navigate, Enter to execute, Escape to close, draggable title bar.

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

### Components

- **Color rectangle** — X = saturation, Y = brightness
- **Hue slider** — 360-degree spectrum
- **Opacity slider** — 0%–100%
- **Format inputs** — Hex, RGB, HSB, CSS with copy buttons
- **Gradient editor** — Gradient bar with color stops (add, remove, move, direction controls)

### Eyedropper (Ctrl+Shift+C)

Magnified 21x21 pixel grid. Click anywhere to sample color.

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

Right-click on elements for: Select This Item, Add to Selection, Cut, Copy, Copy as (PNG, PNG @2x, PNG @4x, SVG, CSS, YAML, Blueprint), Paste, Duplicate, Delete, Rename, Group/Ungroup/Add Auto Layout, Operations (Union, Subtract, Intersect, Exclude), Component actions (Create Component, Create Instance, Detach Instance, Go to Master, Push Overrides, Reset Overrides) when applicable, Arrange (Bring to Front, Bring Forward, Send Backward, Send to Back), Align & Transform (for multi-selection: Align Left/Right/Top/Bottom, Align Horizontally/Vertically, Distribute Horizontally/Vertically; always: Flip Horizontally/Vertically, Scale Up/Down, Fit to Parent), Select Parent (for nested elements), Toggle Clip Content (for frames), Export as (PNG, PNG @2x, PNG @4x, SVG), Text formatting (for text elements), View (Zoom to Elements, Center on Elements).

Right-click on empty canvas: Paste, Select All, Create submenu (Text, Rectangle, Circle, Line, Arrow, Pencil, Frame), Canvas submenu (Toggle Background, Whiteboard, Blackboard, Toggle Alignment Guides, Clear All Elements), Import Image, Export as (PNG, PNG @2x, PNG @4x, SVG).

File explorer right-click on files: Open, Rename, Cut, Copy, Paste, Duplicate, Delete, Reveal in Finder, Copy Filename, Copy Relative Path, Copy Absolute Path.

File explorer right-click on folders: Expand/Collapse, Rename, New Canvas, New Folder, Cut, Copy, Paste, Duplicate, Expand All, Collapse All, Delete, Reveal in Finder, Copy Relative Path, Copy Absolute Path.
