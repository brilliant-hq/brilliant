---
name: "knowledge-shortcuts-contexts"
description: "Activation contexts, executing commands from the shortcuts view, and programmatic keybinding customization."
assumes: reference/shortcuts
---

# Shortcuts: Activation Contexts and Programmatic Keybindings

### Activation Contexts ("Active When")

Each command has an activation context that controls when it responds to its shortcut. Hover the **info** button (ⓘ) on any command row to see its "Active when" condition.

Two commands can share the same shortcut if their contexts don't overlap. For example, `Cmd+B` can mean "Bold" during text editing and something else on the canvas.

Activation contexts you may see in a command's "Active when" info (read-only; these are the app's own labels):

| Context | Meaning |
|---------|---------|
| Canvas | Active on canvas, not during text input or palette |
| Always | Active everywhere, no restrictions |
| Has Selection | Requires at least one element selected |
| Multiple Selected | Requires 2+ elements selected |
| Auto Layout Selected | Requires an auto layout frame selected |
| Frame Selected | Requires a frame/group selected |
| Component Instance Selected | Requires a component instance selected |
| Editing Text | Active only while editing text |
| AI Input | Active only while the AI input is focused |
| Vector Edit Mode | Active only in vector editing mode with nodes selected |
| Code Editor | Active only while the code editor is focused |

After you switch canvas by clicking a row in the Files panel, keyboard shortcuts (Cmd+Z included) act on the canvas you opened. Clicking the row of the canvas already open, or opening a row with Space or Enter, keeps the keyboard on the Files panel.

### Executing Commands from the Shortcuts View

Click any command name in the shortcuts view to execute it immediately: useful for testing commands or triggering commands that don't have shortcuts assigned.

## Programmatic Keybinding Customization

Keybindings can be queried and batch-updated via commands:

- **`list_keybindings`**: returns all commands with current/default keybinding, `isCustom` flag, and command groups. Optional `group` param to filter by command group, optional `search` param for case-insensitive regex matching against id/name/description (e.g. `"align|distribute"`).
- **`set_keybinding`**: batch set keybindings. Params: `{ "bindings": [{ "commandId": "...", "key": "L", "modifiers": ["shift"] }] }`. Omit key/modifiers to clear. Returns conflicts if any.

Modifier names: `command` (Cmd/Ctrl), `shift`, `alt` (Option), `control`, `fn`. Changes persist to `~/.config/brilliant/keybindings.json`, and when signed in they sync across devices (desktop and web) through the account; the most recent change wins.
