---
name: "knowledge-ai-input-bar"
description: "The AI input bar in the bottom toolbar: focusing it, sending a prompt, its input helpers, and the inline prompt on a selection."
assumes: reference/ai
---

# AI Input Bar (Bottom Toolbar)

The input lives in the bottom toolbar, to the right of the drawing-tool buttons.

- Focus it with **.** (period) any time (with or without a selection), or with **/** (slash) when nothing is selected (with a selection, **/** opens the inline AI input instead, see Inline prompt below), by clicking the field, or via the **Focus AI Chat** command in the palette.
- A chevron toggle beside the field collapses it down to a sparkle button plus a right-facing chevron: the sparkle opens or closes the AI chat (it stays highlighted while the chat is open), and the chevron brings the input field back.

### How to send a prompt

1. Optionally select one or more elements, or attach context manually (see `reference/ai/context`).
2. Focus the input.
3. Type a prompt.
4. Press **Enter**.

Sending creates a new chat session (topic auto-derived from the prompt) and routes it to the currently selected model. The chat panel opens above the bottom toolbar so the response streams in. While a session is processing, the input shows a spinner and a stop button; clicking stop cancels the active run.

### Input helpers

- **Placeholder:** at rest the empty field reads **Ask Brilliant to design anything**, with a **.** keycap at its trailing end (the key that focuses it); once the field has focus the placeholder reads **⇧⏎ New line**. The chat panel's own composer keeps its keyboard hint: **/ to focus** with nothing selected, **. to focus** with a selection.
- **Right-to-left text:** typing Hebrew or Arabic lays the field out from the right (a message that opens with an @mention, a #hashtag or a link still follows its own language), and the arrow keys follow the screen: **Left** moves the caret left and **Right** moves it right, and **Shift+Left / Shift+Right** (with Option or Cmd on a Mac, Ctrl on Windows, for a word or the line edge) grow or shrink the selection toward the arrow. The same holds in the desktop app and in the browser.
- **Prompt history:** with the field empty, **Up** recalls previously sent prompts (newest first) and **Down** walks back toward the newest. Inside a multi-line prompt, typed or recalled, Up and Down move the caret between its lines; recall continues only from the first or last line of a recalled prompt you have not touched. **Ctrl+P / Ctrl+N** step through history from any line. **Ctrl+R** searches your sent prompts: a search line opens at the top of the input (a magnifier, the search text, a count such as "2 of 9", and the keys: ⌃R older, ↵ use, esc draft) and the input itself shows the highlighted prompt whole, every line of it. Typing searches by the typed text only (your draft is set aside, never mixed in): prompts that contain it, ignoring case, newest first. **Ctrl+R** or **Up** moves to the next older match, **Down** back toward the newest. A list above shows the matches around the highlighted one (three older above it, up to two newer below, the highlighted row in blue, a multi-line prompt as its first line with its line count). Pointing at a row only tints it; clicking a row puts that prompt in the input. **Enter** (or Tab) puts the highlighted prompt in the input to edit, never sends it; **Esc**, or clicking away, gives your draft back exactly. With no match the count reads "No match" and the input says how back; with no sent prompts yet Ctrl+R still opens the line, reading "0 prompts". The @, # and / lists inside the chat input use the same app menu look (blue highlight for the keyboard row, grey for the pointer). History is deduplicated and persisted between launches (in the browser, per signed-in account; signed out it lasts only for the tab). Editing a sent message never recalls history: its text stays yours while you edit.
- **Spell check:** misspelled English words in the input get a red wavy underline; right-click one for corrections, Ignore, or Add to dictionary. @mentions, links, code in backticks and a leading slash command are never marked. Turn it off in Settings → Input → Spell check (see `reference/ui`, Spell Check).
- **`#` hashtags:** typing `#` opens a dropdown of style/context modifiers (for example dark, mobile, minimal) that get inserted into the prompt.
- **`/` slash menu:** typing `/` opens a dropdown of chat slash commands plus recent sessions for quick resume.
- **`@` mentions:** typing `@` in the AI input (both the bottom-toolbar field and the chat panel's follow-up input) opens an autocomplete of canvas elements by name; picking one attaches that element as context (see `reference/ai/context`).

## Inline prompt (ask about a selection)

With something selected, click the **sparkle** at the top-right of the selection (see `reference/ui`), or press **/** (slash), to open an inline prompt box right there. It is the same composer as the chat, and your selected elements are already attached.

- **Send opens the AI chat.** Sending is exactly like attaching the selection in the chat and sending: the box closes, a new chat session begins with those elements attached, and the AI chat panel opens on that session so the reply streams in view while the AI edits the canvas.
- **The design system follows the selection.** If every selected element uses tokens from a single design system, the new session uses that design system. If the selection mixes design systems or uses none, the session starts with no design system. You can still change it in the composer.
- **Open in chat.** At the top right of the box, in the row with the attached-element chips, is **Open in chat**: it moves the prompt (with its attachments and picks) into the full AI chat panel without sending it, for when you want the bigger view first.
- **Setup continues in the main chat.** Choosing **Bring your own AI** from the model picker, or opening Settings from the box, first moves your prompt into the full AI chat panel and continues there, so the short setup conversation shows where you can see it.
- **Dismissing keeps a draft.** Closing the box without sending keeps your text and the attached selection as a draft chat, listed in the chat history by its name (its first words, or **New chat** when empty), with no Draft label. Reopening the inline box on the same selection restores that draft, prefilling the composer from it. Each selection keeps its own draft, and an empty draft (no text, no attachments) is cleaned up when you open another chat, unless you renamed it.
- **Share it as a link.** With the inline prompt open and a prompt typed, copying the canvas link (the copy button on the top toolbar, **Share** on the right toolbar, or the browser address bar on the web) carries both the selection and the prompt. Whoever opens that link lands on the canvas with those elements selected and the prompt already filled in, so a single **Send** gives them the same result. A very long prompt or a very large selection is too big to share this way, so the plain canvas link is copied instead.
