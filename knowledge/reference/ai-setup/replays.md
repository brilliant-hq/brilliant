---
name: "knowledge-ai-setup-replays"
description: "The pills on an empty chat: Replays of recorded sessions when only Brilliant AI is connected, prompt suggestions when you have an AI of your own."
assumes: reference/ai-setup
---

# Replays and prompt suggestions (the pills)

Every empty chat shows the same pills (Retro console hero, Eclipse trip hero,
Festival poster, Music player app, Bakery post, Jazz poster, Birthday invite, Send money
screen, Sneaker sale story, Ramen menu). On every surface (the desktop app, the web
editor, and the `/playground` page) they sit on one row that scrolls sideways (trackpad
swipe or mouse wheel); a faded edge means more pills lie that way. Hovering a pill
previews its full prompt. Clicking a pill acts at once, on every surface. What a
pill does depends on whether you have an AI of your own connected:

**Preview cards.** The pills are preview cards: each shows a picture of the finished
design over its title, all ten on one row that scrolls sideways (trackpad swipe, mouse
wheel, or Shift plus the wheel). Every card is the same width at any chat width, so the
last visible card is cut at the edge and the row reads as scrollable. A thin scrollbar
shows under the cards only while the row is scrolling, and fades once it stops. The row is
titled **Replays** with only Brilliant AI, and **Try** with an AI of your own. Hovering a
card outlines it, shows a play badge (Replays) or an arrow badge (Try), and previews its
full prompt above the row; hovering the row shows its X.

1. **Only Brilliant AI** (no key, CLI, or custom endpoint of your own): the row is titled
   **Replays**. Clicking a pill replays a recorded session of an agent building that design,
   right there in the chat, as real, editable elements on the canvas you are on. A replay
   spends nothing and does not move your view.
2. **An AI of your own connected** (an API key, the Claude Code, Codex, or Cursor CLI, or a
   custom endpoint): the pills are prompt suggestions. Clicking one sends its full prompt
   right away, as if you had typed it and pressed Enter.

Connecting or removing your own AI switches the row between the two right away. A prompt
you type yourself always runs live (on Brilliant AI, or your own AI if you chose one), on
the canvas you are on, never as a replay. A follow-up typed after a replay opens a fresh
chat that runs it live, on the same canvas. Hover the row and click its X to hide the pills
(the `Show Suggested Prompts` command brings them back).
