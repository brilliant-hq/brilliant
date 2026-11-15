---
name: "knowledge-ui-bottom-toolbar"
description: "The bottom toolbar: its shortcuts, buttons and tool dropdowns, the AI input and Settings pages it points to, and the inline AI input beside a selection."
assumes: reference/ui
---

# Bottom Toolbar

| Action | Shortcut |
|--------|----------|
| Toggle bottom toolbar (no on-screen button) | Cmd+Shift+↓ |
| Hide/show ALL chrome (left, right, bottom toolbars AND the top strip; palette + tooltips stay; press again to restore) | Cmd+\\ |
| Presentation mode | Alt+P |
| Focus AI input (or open the inline AI input, when something is selected) | / (slash) |

## Buttons

Single horizontal row, grouped left to right with vertical dividers:

1. **Quick palette access:** Global Search (Cmd+K). The keyboard shortcuts sheet opens with Shift+? or from the palette. Assets is not here: it is a tab on the nav rail at the window's far left (Cmd+Shift+A; see "Assets View" in `reference/ui`).
2. **Tools (canvas tools dropdown buttons):** Selection Tools dropdown (Move V, Scale K, Hand H), Shape Tools dropdown (Rectangle R, Line L, Arrow Shift+L, Circle O), Drawing Tools dropdown (Pen P, Pencil Shift+P), Frame (F), Text (T).
3. **AI input area:** input field, processing/success/failure indicators, collapse chevron, the collapsed-state sparkle chat toggle and its re-expand chevron, running-agent activity bars.

Each dropdown stores the most-recently-used variant as the head icon. Stroke-only variants of Rectangle (Shift+R) and Circle (Shift+O) are accessible only by keyboard. The Snip tool (S) is accessible only via the keyboard shortcut. Scale mode (K) is presented as a sub-option of the Selection Tools dropdown rather than as its own tool: selecting it puts the Move tool into persistent scale mode, and Escape turns it off again.

## AI Input

Inline after the tool buttons (separated by a divider). Width is 320 px. At rest the empty field reads **Ask Brilliant to design anything** with a **.** keycap at its trailing end. Press **.** (period) to focus it, with or without a selection; **/** also focuses it when nothing is selected (with something selected, **/** opens the inline AI input beside the selection instead, see Inline AI Input above), type a prompt, press **Enter** to send. **Escape** unfocuses (see Escape Behavior in `reference/shortcuts/selection` for what Escape does elsewhere). Focusing the input opens the AI chat panel and unfocuses the input (so input continues in the chat panel).

A collapse chevron collapses the input. When collapsed, a **sparkle button** replaces the field, with a right-facing chevron beside it: the sparkle opens or closes the AI chat (it stays highlighted while the chat is open), and the chevron re-expands the input field. When the AI chat panel is open, the bottom toolbar shows that same highlighted sparkle (click it to close the chat); while the input is still collapsed a chevron sits beside it that, in one press, closes the chat and brings the inline field back (with the input already expanded there is no chevron: closing the chat via the sparkle returns the field on its own); the chat input lives in the panel above.

On the Settings tab and on the Project and Assets pages the bar carries only this AI input (or the sparkle and chevron when collapsed): no search, no tools. It opens the same chat panel as on the canvas (see `reference/ui/chat-panel`).

On a project you can only view (or a cloud project whose live sync has stopped and locked the tab read-only), the chat transcript stays fully readable: you can scroll it, select text, and use **Copy chat**. Only sending a new prompt is disabled; clicking the input explains why and offers the ways forward.

There is no connection dot on the bar anymore. When the AI input is collapsed, the sparkle toggle described above opens or closes the AI chat (not Settings), and the chevron beside it re-expands the input. Provider status and API keys live only in Settings -> Models (Cmd+, then the Models page, Your own AI), where each provider (Claude Code, Codex, Cursor, Anthropic, OpenAI, Google, OpenRouter, Meta chat providers; Quiver for SVG generation) shows whether it is connected. Settings carries **Account**, **Usage** (both lanes: your Brilliant AI percent used and reset date, plus the your-own-AI card) and **Your own AI** (the tab previously called AI Providers). The Usage page updates itself (it refetches when you open it and again after each Brilliant AI message) and carries a **Refresh** button on the Brilliant AI card to pull the latest numbers on demand; on a successful refresh it briefly turns into a green checkmark so you can see it updated, and if a refresh cannot reach the server it leaves one quiet line under the meter ("Could not refresh. Check your connection and try again.") until the next successful refresh.

While agents are running, one small activity bar per processing session appears at the right end of the toolbar (chats in Brilliant on this project only; an external agent connected over MCP shows on the project tab, the Files rows and its cursor instead, see `reference/ui/left-toolbar`). The submit button switches to a stop button while the user's request is processing; if the AI returns a "command not recognized" response a brief `?` indicator is shown instead. See `reference/ai` for the full AI feature reference.

## Inline AI Input (the selection sparkle)

Whenever you have something selected, a small round **sparkle** button (a blue sparkle on a light circle) sits just to the right of the selection box's top-right corner, its top edge level with the top of the selection. If that corner sits under the right toolbar, the sparkle mirrors to the selection's left side so it stays visible. There is one sparkle per selection box, so if you have elements selected in two different frames you see two sparkles. Hovering it shows the **Toggle Inline AI Input** command and its shortcut.

Click the sparkle to open a small prompt box beside the selection. It is the same input as the AI chat, with your selected elements already attached. The box takes the sparkle's place (the sparkle hides while the box is open) and stays attached to the selection: pan, zoom, move or resize and it follows. It always stays inside the visible canvas, never covering the toolbars: if the selection sits near a toolbar it shifts in to clear it, and if that would put it on top of the selection it flips to the selection's left instead. Type a prompt and press **Enter** (or click send): the box closes and the AI starts working on your selection, opening the AI chat panel on that session so the reply streams in view. See `reference/ai` for what the prompt does and how to share it as a link.

You can also open it from the keyboard: with something selected, press **/** (slash). Press **/** again within two seconds and the box closes and the main AI chat gets the focus instead, for the times you meant the chat. After two seconds a **/** in the box is just a typed character. With nothing selected, **/** focuses the bottom-toolbar AI chat directly. At the top right of the box, in the row with the attached-element chips, is **Open in chat**: it moves the prompt (with its attachments) into the full AI chat panel without sending it, in case you want the bigger view first.

Close the box with **Escape**, by clicking the canvas, or by pressing the sparkle again. Picking a color with the eyedropper or picking a position on the canvas from inside the box does not close it. A closed box keeps what you typed, so reopening it on the same selection restores your draft.

To hide the sparkle, open Settings (Cmd+,) → General → **Inline AI input** and turn it off. Pressing **/** with a selection still opens the box when the sparkle is hidden.
