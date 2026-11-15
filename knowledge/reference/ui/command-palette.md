---
name: "knowledge-ui-command-palette"
description: "The palette: its modes and shortcuts, unified global search, and the Keyboard Shortcuts view."
assumes: reference/ui
---

# Palette

A single floating, draggable, search-driven palette with multiple content modes: global search, commands, canvas (file) selection, font family, layer search, color selector, settings, updates, keyboard shortcuts, and combos. The list-based modes all use the same search field with a left-side filter dropdown. The category-specific shortcuts (command search, canvas search, font selector, layer search) open the same global-search palette pre-filtered to that category; chat search is just a `chats` filter on the same palette (no dedicated mode).

| Mode | Shortcut |
|------|----------|
| Global search (all categories) | Cmd+K |
| Command search | Cmd+Shift+P |
| Canvas (file) search | Cmd+P |
| Layer search | none (Edit menu, palette, Cmd+K's Layers filter) |
| Chat search | Cmd+Shift+I |
| Font selector | Cmd+Shift+F |
| Color selector | Ctrl+C |
| Settings | Cmd+, |
| Keyboard shortcuts | Shift+? |
| Combos | Cmd+Shift+M |
| Updates | Cmd+Shift+U (also via the Check for Updates command) |

Note: with nothing selected, **/** focuses the AI input in the bottom toolbar (then opens the chat panel). With something selected it opens the inline AI input beside the selection (a second **/** within two seconds closes it and focuses the chat instead). Either way it does not open the palette.

All search modes support: type to search, Up/Down to navigate, Enter to execute, Escape to close, draggable title bar.

A click on the AI chat panel (the chat box, the messages, or the chat list) closes the palette, whatever it shows (search or a page such as Settings), and the click still does what it would: a click in the chat box puts the cursor there.

Running a command from the palette normally closes it and gets out of the way. Two exceptions: a command with a checkbox (a setting you might flip twice) keeps the palette open so you can see the checkmark change, and a command whose whole job is to open a palette surface (Settings, Project, Keyboard Shortcuts, Updates, Combos, the color selector, or any of the search scopes) leaves you on the surface it just opened rather than closing it under you.

**Unified Global Search** (Cmd+K): Shows commands + files + layers + fonts + chats in one list, each section capped by the layout. The filter dropdown switches to a single category (All, Commands, Files, Layers, Fonts, Chats). The category-specific shortcuts (Cmd+Shift+P, Cmd+P, Cmd+L, Cmd+Shift+F, Cmd+Shift+I) open the same palette pre-filtered. In "all" mode, layers only run when the query is 2+ characters (otherwise the first 5 elements show as a stub) and fonts are skipped (too many entries).

## Keyboard Shortcuts View (Shift+?)

A floating palette mode for viewing and customizing every command's keybinding.

In the new interface, Keyboard Shortcuts (Shift+?) and Combos (Cmd+Shift+M) open Settings on its Shortcuts & combos page (the Shortcuts tab, or the Combos tab) instead of a palette view.

- **Search**: filter by command name, group, or keybinding text.
- **Two-column scrollable layout**: commands grouped by category (Drawing Tools, Selection & Editing, Canvas, Color, Effects, Auto Layout, etc.).
- **Per-row actions on hover:** record (reassign), trash (clear), reset (restore default: only shown when modified).
- **Click a command name** to execute it immediately. Useful for unbound commands.
- **Info button (i)**: hover to see the command's description and its "Active when" activation context.
- **Conflict detection**: warning triangle on conflicting shortcuts with a filter button (also a triangle) in the search bar to show only conflicts.
- **Activation context (read-only)**: the info (i) button on a row reveals the command's description and its activation condition ("Always active", or "Active when ..." with names like `Has Selection`, `Multiple Selected`, `Auto Layout Selected`, `Frame Selected`, `Component Instance Selected`, `Editing Text`, `AI Input`, `Vector Edit Mode`, `Code Editor`). This is display-only: it tells you which command wins a shared shortcut, but there is no UI control to re-scope a command's activation. Resolve conflicts by rebinding, not by changing the context.

See `reference/shortcuts/customizing` for activation-context details and conflict resolution.
