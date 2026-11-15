---
name: "knowledge-ui-chat-panel"
description: "The AI chat panel: its two lanes, sessions and the chat explorer, the expanded panel, and resizing."
assumes: reference/ui
---

# AI Chat Panel

The chat panel surfaces AI design sessions above the bottom toolbar. Two lanes through the same UI: **Brilliant AI** (the default, Brilliant-provided models included in every plan, selected by default in a new session) and, below it, your own providers, unchanged: Claude Code (local CLI), Codex (local CLI, ChatGPT subscription), Cursor (local CLI, Cursor account), Anthropic HTTP, OpenAI HTTP (Chat Completions + Responses API), Google Gemini, OpenRouter, and Meta (Muse). Free includes Brilliant AI every month (usage that resets monthly, shown as a percent used with a reset date in Settings > Models, and part of it can be used before you sign in), and a key you bring never routes through Brilliant. On the Free plan the built-in chat on your own key is capped at 10 messages a day (a message counts once the model starts answering), and at the cap the next send opens the upgrade page ("Keep the conversation going": Upgrade to Personal removes the limit, "Not now" dismisses it, and a note that agents over MCP keep going: their canvas work stays unlimited, images draw on your Brilliant AI usage and are capped like the chat's), while external agents over MCP are unaffected by the daily cap; an image they generate on Brilliant AI draws on your Brilliant AI usage (on Free, up to three every five minutes), and everything else they do stays unlimited. The usage wall itself (the upgrade page it opens, the held message, the in-editor checkout) is `reference/ai`'s. See `reference/ai` for providers, models, slash commands, attachments, the usage meter, the daily cap, and tool execution.

## Sessions

The bottom toolbar carries no session tabs. After the tool buttons it holds the AI input (or, when the input is collapsed or the chat is open, the sparkle button that opens and closes the chat) and one small bar per agent running in the active project. Sessions are listed in the **chat explorer**, the sidebar inside the chat panel:
- Click a row to open that session
- Double-click a row's name to rename it (Esc to cancel)
- X on a row archives it; archived chats are listed under **Archived**, where X deletes one
- The explorer header has New Chat, Search Chats, Archive All, and Collapse. Collapsing hides the list completely and the chat takes the whole panel; **Show chats** (Cmd+Shift+A) then sits at the start of the chat header, followed by a small bar for each other chat that is running in this project
- Cmd+1..9, Cmd+0 (Windows: Alt+1..9, Alt+0) jump to and expand session 1..10
- Cmd+Shift+] / Cmd+Shift+[ cycle between sessions
- Cmd+W closes the focused chat (while the chat is open; with it closed, Cmd+W closes the project tab instead)
- Cmd+Shift+A toggles the Chat Explorer (when AI chat is open)

## Expanded Panel

- **Header:** in the **Full** editor mode the header reads `project / chat` (double-click the chat name to rename it), the canvas links, **Copy chat** (on hover), **Layout** and minimize, with the chat list on the left. In **Focus** mode the chat has no list on the left and the header is one row: the chat's name with a small chevron, **Copy chat** (on hover), **New Chat** (+), **Layout**, and minimize. Click the chat's name to switch chats: the menu has **Rename**, your five most recent chats (a check on the open one), **New Chat** (Cmd+N) and **Show all chats** (Cmd+Shift+A, which switches to Full with the chat list shown). Double-click the name to rename it in place. In Focus, a chat that belongs to another project shows that project's name first, as in `Marketing site / Hero spacing`, in the header and in the menu.
- **Conversation:** messages stream in with newest at the bottom; text is selectable; supports inline mentions / attachments. A long chat opens on its latest turns; scroll to the top and the earlier messages load in above (a "Loading earlier messages" row shows while they do), and **Copy chat** always copies the whole chat. Nothing is ever dropped from the saved history. Clicking a message does not copy it: select text and copy it, or use **Copy chat** in the header, a code block's copy button, or a message's copy action.
- **What the agent did:** canvas work reads as element chips (**Looked at**, **Changed**). Work that touches no element (running commands, reading or editing files, searching, fetching pages, other tools) reads as one quiet line per run, such as "Read 1 file, fetched 1 page, ran 1 command"; click it to see one row per call, click again to fold it. A call that failed always shows as its own row.
- **Input bar:** the paperclip (**Add to message**) opens a menu: Attach files, Take photo (where the platform has a camera), Pick color, Pick position. Then the design system swatch, the model selector (per session; its menu also holds a **Thinking** group, Off / Low / Medium / High where the model supports it, Off by default on Brilliant AI), the context left ("62% left"; hover for the details; an older chat shows it again after its next reply), the chat's undo / redo, and send / stop. While the agent works, typing shows Stop beside Send: Send adds your message to the run (the agent reads it at its next step), and Esc with an empty field stops the run; the next Esc minimizes the chat. A menu open over the chat takes an Esc first.
- **Long pastes attach:** pasting a long text (100 lines or more, or about 8,000 characters) into the chat input adds it as one **Pasted text** chip instead of filling the input; click the chip to preview it, x to remove it. The AI reads the whole pasted text exactly as pasted, and the sent message shows the chip.

**Chat layouts.** The **Layout** button (beside Minimize, always shown) opens a menu: **Docked**, **Left half**, **Right half**, **Full screen**, with a check on the current one; a pick applies at once and is remembered. View > Layout lists the same layouts plus **Bottom Half**. The header's empty area shows an open hand: drag it (or the **Chats** band at the top of the chat list) to move the panel, and double-click it to toggle full screen and docked. Dragging to the window's left, right or top edge previews the left half, right half or full screen, and dropping there snaps it; a drag that starts at the left or right edge snaps there only after the pointer leaves that edge and comes back.

**Chat on Settings and project pages.** On the Settings tab and on the Project and Assets pages the bottom bar shows only the AI input and its collapse chevron (no tools), and it opens the same chat panel, with every layout, the Layout button, dragging and snapping. The chat is the window's: open or closed, its layout, size and selected chat stay as you left them when you move between the canvas, Settings and those pages. Hide UI (Cmd+\) hides it with the rest of the chrome, and home has no chat.

**Narrow panel.** In Full mode, under 480 px wide the chat list folds itself and **Show chats** (Cmd+Shift+A) appears at the start of the header, as when you collapse the list; your own collapse choice is untouched and returns when the panel widens. A list you open there stays open while the chat keeps 200 px beside it. When the header gets tight, the project name and slash drop first so the chat title stays whole, then the title shortens.

## Resize

- **Position:** drag the floating panel by its header to move it anywhere in the window (the bottom toolbar stays where it is); it always stays fully on screen. View > Layout > Docked puts it back above the bottom toolbar.
- **Width:** drag the side edge to resize the chat panel; width is clamped to 300–1200 px. The minimum width can rise temporarily for some sessions (e.g., during Claude Code setup onboarding).
- **Height:** drag the top edge of the panel. It stops at the height the panel's own chrome needs (header, badges, composer), which grows with the UI density setting. As the panel gets shorter the transcript gives up space first, then the composer input shrinks toward one line; it scrolls, so nothing typed is lost.
