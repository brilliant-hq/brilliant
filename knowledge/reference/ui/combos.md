---
name: "knowledge-ui-combos"
description: "Combos: saved command sequences, the built-in highlighter presets, and creating and managing your own."
assumes: reference/ui
---

# Combos

Combos are saved command sequences (macros) that execute multiple actions with a single trigger. Open the Combos panel with **Cmd+Shift+M**.

## Built-in Highlighter Presets

Brilliant includes four highlighter presets that switch to pen tool with semi-transparent color at a specific size:

| Combo | Shortcut |
|-------|----------|
| Yellow highlighter | Ctrl+Shift+Y |
| Red highlighter | Ctrl+Shift+R |
| Green highlighter | Ctrl+Shift+G |
| Blue highlighter | Ctrl+Shift+B |

## Creating Custom Combos

1. Open **Cmd+Shift+M** to open the Combos panel
2. Enter an **icon name** (SF Symbols name, defaults to "star")
3. Enter a **combo name**
4. Click **Add Command** and search for commands to add
5. Reorder commands with up/down arrows, edit or remove as needed
6. Click **Create** to save

Combos chain commands in sequence with a small delay between each. You can include any command: tool changes, color changes, size adjustments, even other combos.

## Managing Combos

In the "Existing combos" section:
- **Hover** a combo to reveal edit (pencil) and delete (trash) icons
- **Click the keybinding area** to assign a custom shortcut
- **Edit** to modify name, icon, or command sequence

## Example Use Cases

- **Quick annotation modes**: Switch tool + color + size in one keystroke
- **Workflow shortcuts**: Chain frequent action sequences
- **Presentation presets**: Set up specific tools for presenting

Combos persist across sessions (stored in `~/.config/brilliant/combos.json`).
