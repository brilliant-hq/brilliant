---
name: "knowledge-ui-spell-check"
description: "Spell check in text layers and the AI chat input: corrections, ignore, the personal dictionary, and turning it off."
assumes: reference/ui
---

# Spell Check

While you edit a text layer, and in the AI chat input (the bottom toolbar field, the chat panel's input, and a sent message you are editing), a misspelled word gets a red wavy underline. It works the same in the desktop app and in the browser.

- **Right-click a marked word** for up to five corrections, best first (or "No suggestions"), then **Ignore** and **Add to dictionary**, then the menu's usual rows. The bottom toolbar field shows the marks only; the menu is in the chat panel's input and in a sent message you are editing. Picking a correction replaces the word; in a text layer that is one undo step and the new word keeps the old word's style.
- **Ignore** stops marking that word everywhere until you restart Brilliant. **Add to dictionary** stops marking it for good on this device (in the browser: in this browser). The personal dictionary does not sync between devices.
- **English only for now.** American and British spellings are both accepted ("color" and "colour" both pass), so a text that mixes the two is not marked.
- **Never marked:** the word you are still typing (the mark appears once the caret leaves it), words in other scripts (Hebrew, Arabic, Cyrillic, Chinese, Japanese, Korean and so on), words with a digit, ALL CAPS words such as acronyms, @mentions, links and email addresses, hex colors, text between backticks, and a slash command at the start of a prompt.
- Only the text layer you are editing is checked. Marks never appear on text you are not editing, in exports, in thumbnails, or in the file.
- **Turn it off:** Settings (Cmd+,) → General → Input → **Spell check** (on by default). Off removes every mark and the spelling rows from the right-click menu at once; on brings them back. The choice is remembered on this device.

Not available: other languages, a language picker, grammar checking, autocorrect, and spell check in other fields (layer names, the palette, property fields, the code editor).
