---
name: "knowledge-ai-slash-commands"
description: "The chat slash commands typed in the AI chat input."
assumes: reference/ai
---

# Chat Slash Commands

Type these in the chat input. Some are provider-specific and only appear when relevant.

| Command | Description |
|---------|-------------|
| `/stop` | Stop the current response |
| `/continue` | Nudge the model to continue |
| `/context` | Show context-window usage |
| `/usage` | Show the usage card: on Brilliant AI, `Brilliant AI: N% used` with the rung (Personal / Pro / Max / Max 20x) or `Free`, and `Resets on <date>`; plus the your-own-AI line (`N of 10 messages today on your own AI` on Free, `Unlimited on your own AI` on paid). Signed out, the card shows the sign-in sentence above the meter (`Sign in for more every month, free.`, or `Sign in to keep going, free.` at the limit) and no rung or reset date |
| `/cost` | Show cost and usage for this session (Claude CLI and Anthropic only) |
| `/compact` | Compact (summarize) conversation history |
| `/feedback` | Classify the feedback (bug, feature request, question, or praise) on a quick card, then the agent routes it to the Brilliant team (it loads the playbook and picks the best channel) |
| `/archive` | Archive the current chat |
| `/new` (`/clear`) | Start a new chat |
| `/model` | Change the model (provider-then-model picker) |
| `/rename` | Rename the current chat (e.g. `/rename My Chat`) |
| `/copy` | Copy the last assistant message |
| `/help` | Show available commands |
| `/login` | Sign in to Claude (Claude CLI only) |

Exporting a session as a video replay is not a slash command: it is an action on a finished session (a replay export button surfaces on the session). For export formats in general, see `reference/export`.
