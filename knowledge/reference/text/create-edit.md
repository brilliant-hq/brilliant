---
name: "knowledge-text-create-edit"
description: "Creating text with the Text tool, and entering, working in, and exiting text edit mode."
assumes: reference/text
---

# Creating and Editing Text

## Creating Text

| Action | How |
|--------|-----|
| Activate Text tool | Press **T**, or pick the Text tool in the bottom toolbar |
| Place a text element | With the Text tool active, click on the canvas; the caret lands and editing starts immediately |

New text starts empty with the current font family (default Inter) and current font size (default 24px). These defaults carry forward from the last text you styled. A fresh text element hugs its content in both axes (Auto Size), so it grows as you type until you resize it or change its sizing mode.

The Text tool is click-to-place only. Dragging does not create a fixed-width box; to get a fixed width, resize the element after creating it (which switches it to a fixed sizing mode).

## Editing Text

### Entering edit mode

| Action | How |
|--------|-----|
| Edit an existing text element | Double-click it, or select it and press **Enter** (a text inside a group or nested frame: each double-click first goes one level deeper until the text is selected) |
| With the Text tool active | Click an existing text element to edit it directly |

However you enter, whether you double-click it or select it and press **Enter**, the whole text starts selected, so your next keystroke replaces it (matching Figma). Once you are already editing, a **double-click** selects just the word under the cursor (see `reference/text/navigation`).

### While editing

- Type to insert at the caret.
- Typing over a selection keeps the style of the text you replace (its color, font, size and weight) instead of snapping back to the default, even when you replace the whole text. Typing at a caret continues the style of the character before it (at the very start, the first character's), matching Figma.
- Standard editing shortcuts work: Cmd+A, Cmd+C, Cmd+X, Cmd+V, Cmd+Z, Cmd+Shift+Z.
- The element re-measures and reflows live as you type.
- Misspelled English words get a red wavy underline while you edit; right-click one for corrections, Ignore, or Add to dictionary. The marks are never saved or exported. Details and the Settings toggle: `reference/ui`, Spell Check.

### Exiting edit mode

- **Escape** or **Cmd+Enter** (Ctrl+Enter on Windows) finishes editing and exits, committing what you typed (there is no revert-on-escape). To undo the edit, use Cmd+Z after exiting.
- Click outside the element to commit and exit.
- Clicking into a text field in the inspector or the layers panel (a hex color, a layer name) does NOT exit. The edit pauses while you type there and picks up again, with your selection where it was, when you press Enter or Escape in that field or click away from it. So with a range selected, typing a hex recolors just that range. Escape inside the field leaves the field, a second Escape finishes the edit.
- **Enter** starts a new line and keeps editing, as in Figma. **Shift+Enter** inserts a line break the same way.

If a text element is left empty when you exit, it is deleted automatically.

A text layer's name follows its text while you have not renamed it (a new text is named after what you type, and keeps following edits). Once you rename the layer, typing or a Transformations rewrite never changes that name.
