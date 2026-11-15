---
name: "knowledge-ai-chat-panel"
description: "The AI chat panel: sessions, the chat explorer, reading the conversation, and the panel controls."
assumes: reference/ai
---

# The Chat Panel

The chat panel floats above the bottom toolbar. It holds the active session and an optional **chat explorer** sidebar (session list).

### Sessions

Start a new session by submitting from the bottom-toolbar input, clicking **+** in the chat panel header, or pressing **Cmd+N** while the AI input is focused. Each session keeps its own provider, model, thinking level, conversation history, and context. Multiple sessions can run concurrently. Sessions persist between launches.

### The session list

Sessions are not tabs in the bottom toolbar: the toolbar shows one small bar per agent running in the active project, and every session is a row in the **chat explorer** sidebar. Click a row to open it, double-click its name to rename it, and X archives it (`reference/ui` chat panel).

### Reading the conversation

A message you send starts near the top of the panel, with the end of the previous reply just above it, and the answer streams into the space below it. The chat follows new content only while you are at the bottom: scroll up, or start selecting text, and what you are reading stays still while the reply keeps arriving below. Reopening a chat, or switching back to it, lands on your last message (or on the exact spot you had scrolled to, if you switched away mid-read).

When you scroll up, a round **Jump to latest** button appears above the message field; it carries a small colored bar while a reply is still streaming, and clicking it takes you back to the bottom, where the chat follows again. PageUp and PageDown scroll the conversation, from the message field too; after clicking into the conversation, the arrow keys, Home and End scroll it as well (End returns to the bottom), and typing goes to the message field.

Element and canvas chips in the conversation (what the AI looked at, created or changed, and the names it links in its replies) take you there when clicked. A chip for something in another project opens that project's tab and goes to the canvas, selecting the element; if that project is closed, a card asks to open it first. A chip for something in another project than the one you are looking at starts with that project's name, as in `pitch-deck › Slides`, and the chips of a chat always name what is in the chat's own project, whichever project tab is active. If you cannot open that project right now (you no longer have access, or it is a cloud project and you are offline), the chip looks the same and clicking it tells you why. A chip turns red only when what it names was deleted; clicking it says so instead of going anywhere.

**Pictures and videos in a reply.** When the AI shows you something it rendered or exported, it appears as a card at the width of the conversation, with its name and size below it. Click a picture (or its expand button) to open it large, where you can zoom and pan; the arrow keys step through the pictures of a before/after pair. A video shows its first frame with a play button: it plays right in the conversation, with play and pause, a scrubber to jump, full screen (the video fills the window; Escape or a click returns), and the folder button, which shows the file in your project's file list. Two cards the AI sends together show side by side as Before and After over one bar. Only files inside the project show: a card says so when its file was moved or deleted (an older chat still shows the picture it had), when the path is outside the project, or when the file is over the limit (pictures 50 MB, videos 500 MB on desktop and 200 MB on the web). A picture from the web never loads by itself: its card names the site and waits for you to click Load, once per site per chat. On the web, jumping inside a video needs the server's support for partial downloads; where that is missing the video plays from the start.

### Panel controls

- **Open / close:** click the sparkle button in the bottom toolbar (shown when the AI input is collapsed; highlighted while the chat is open), or focus the AI input, or run **Toggle AI Chat**.
- **Rename:** double-click the chat name in the header, in Focus mode pick **Rename** in the menu the chat name opens, or use `/rename`.
- **Resize:** drag the panel edges (width and height) or the divider between sessions.
- **Message it while it works:** a message sent while the model is working waits above the input under "QUEUED FOR AFTER THE NEXT TOOL CALL" (edit or cancel it there), and the model reads it right after its current tool call, inside the same reply. A message with an image waits for the reply to finish.
  In the new interface the input's placeholder while the model works reads "Add to this run", and once you type, the Send arrow sits beside the Stop button (Stop takes Redo's place): Send queues your message exactly like Enter.
- **Answer a question:** when the AI (or the in-chat provider setup) asks a multiple-choice question, click an option or type its number; both send the number through the same lane. Free-text answers work too.
- **Edit and resend:** click the edit icon on one of your messages to revise and resend it. Editing rewinds the conversation to that message losslessly: later messages are dropped, everything up to it is kept. On a local Claude CLI, Codex, or Cursor session, which cannot rewind its own transcript, the session instead rebuilds context and replays the prior conversation, marked by a "context rebuilt" card.
- **Copy chat:** the header copy button exports the whole conversation as Markdown (with metadata: model, date, project, canvas, tokens, turns).
- **Chat explorer:** toggle with **Cmd+Shift+A** to browse, search, and manage all sessions; drag its divider to resize or collapse it.
