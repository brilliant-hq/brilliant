---
name: "knowledge-shortcuts-customizing"
description: "The Keyboard Shortcuts panel: viewing, reassigning, removing or resetting a shortcut, and conflict detection."
assumes: reference/shortcuts
---

# Shortcuts: Customizing

Open **Shift+?** to view the Keyboard Shortcuts panel. All shortcuts are fully customizable.

### Viewing Shortcuts

Commands are organized in groups (Drawing Tools, Selection & Editing, Canvas Management, etc.) in a two-column scrollable layout. Use the search bar at the top to filter by command name, group, or keybinding.

### Reassigning a Shortcut

1. **Hover** over any command row to reveal action buttons on the right
2. Click the **record** button (circle icon): the keybinding area shows "Recording..."
3. **Press** your desired key combination (modifiers + key)
4. The new shortcut is saved immediately
5. Press **Escape** to cancel recording without changes

### Removing or Resetting a Shortcut

While hovering a command row:
- **Trash** button: removes the shortcut entirely (command becomes palette-only)
- **Reset** button (appears only if modified): restores the default shortcut

### Conflict Detection

If your new shortcut conflicts with an existing command:
- A **warning triangle** appears next to the keybinding
- The row's **activation context** is shown read-only via its info (i) button (see "Activation Contexts" below): it tells you which command should win, but there is no control to re-scope a command's activation from the UI
- The **"Show conflicts"** filter button (warning triangle in the search bar) highlights all conflicting commands so you can resolve them

Hover the warning triangle to see which commands conflict.
