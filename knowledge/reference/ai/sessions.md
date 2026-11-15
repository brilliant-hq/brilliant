---
name: "knowledge-ai-sessions"
description: "Stopping a chat turn (and what a stop keeps and charges), undoing what a chat changed, and the chat session shortcuts."
assumes: reference/ai
---

# Stopping and Chat Session Shortcuts

## Stopping and Cancellation

- Click the stop button in the chat input bar, or type `/stop`.
- In the new interface, **Esc** also stops the run when the chat input is focused and empty (the Stop button's tooltip then shows Esc); the next Esc, with the run over, minimizes the chat as before. With text in the input, Esc never stops the run.
- While the AI works and you type in the input, the Stop button moves into Redo's place and the Send arrow comes back, so you can add to the run (Send queues your message, the same as Enter) or stop it; no button moves.
- The active request aborts immediately and no further tools are dispatched.
- Anything the AI already created before you stopped stays on the canvas. The stopped turn's card has a **Revert** control that undoes everything that turn changed in one step (and a Redo to bring it back); you can also undo normally.
- On Brilliant AI, a turn you stop is charged for what was counted or reported before you stopped (the prompt, and the answer generated so far); thinking that was never reported is not charged.
- Sub-agents inherit cancellation from their parent session.

## Undoing the AI's Changes

Every change a chat makes to the canvas, whether written in its reply or made through a tool call, belongs to that chat. The chat's **Undo** button, **Cmd+Z** while the chat input is focused, and a turn's **Revert** step back exactly that chat's changes, never another chat's or another app's. Cmd+Z on the canvas steps your own edits only.

## Chat Session Shortcuts

| Action | Shortcut |
|--------|----------|
| Focus AI input in bottom toolbar (opens the inline AI input when something is selected) | / |
| Focus AI input in bottom toolbar, with or without a selection (never the inline input) | . |
| Focus chat session 1-9 | Cmd+1 - Cmd+9 (Windows: Alt+1 - Alt+9) |
| Focus chat session 10 | Cmd+0 (Windows: Alt+0) |
| Focus next chat session | Cmd+Shift+] |
| Focus previous chat session | Cmd+Shift+[ |
| New chat (when AI input focused) | Cmd+N |
| Close focused chat session | Cmd+W (while the chat is open; otherwise it closes the project tab) |
| Toggle chat explorer | Cmd+Shift+A |
| Chat search | Cmd+Shift+I |
| Escape AI chat | Esc |
| Toggle AI chat panel | (no default shortcut; assignable in the shortcuts view) |

In the new interface, Esc in an empty, focused chat input while the AI works stops the run instead (see Stopping above).

Focusing a session by number opens the chat panel if it is hidden. Number assignments appear as badges in the chat explorer. To customize any of these, see `reference/shortcuts`.
