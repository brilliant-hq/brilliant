---
name: "knowledge-ai-setup-own-ai"
description: "Setting up your own AI from Settings or the upgrade wall, and what to do when a key is rejected."
assumes: reference/ai-setup
---

# Setting up your own AI (Brilliant AI is the default first send)

The first-run **"How do you want to use AI with Brilliant?"** chooser is retired.
Sending a free-form prompt no longer opens a setup conversation: the message
enrolls in Brilliant AI and sends on your included usage. Your own AI is a **Settings** choice
(the Your own AI pane above) and the **secondary action on the upgrade wall** shown
when Brilliant AI usage runs out (your own AI itself is never walled by usage).
The wall page and the in-editor checkout that flips the plan live and resumes the
held message are `reference/ai/limits`'s (the one home). On a live paid subscription, choosing a bigger plan from any upgrade
door (the wall, Settings > Models, or the header) opens the plan sheet and switches your rung in place,
with no second checkout: the change takes effect right away and you pay only the difference.

Choosing to set up your own AI opens the Your own AI pane, where a pasted key never
appears in the transcript or prompt history. A model of your own set as the default
is what every new chat opens on, a local endpoint that needs no key included. In the **web editor**, Anthropic,
OpenAI, Google, and OpenRouter keys all work; Claude Code, Codex, Cursor, and connecting a
coding agent over MCP need the desktop app (the closest working browser path is an
Anthropic or OpenRouter key). To drive Brilliant from an external tool such as
Claude Code, Cursor, or Codex over MCP instead of chatting inside it, see
`reference/mcp-connections`.

## When a key is rejected

Keys are validated on save, so a bad key fails immediately with an inline error
rather than later mid-chat. When adding a key, a rejected key offers **paste
again** or **try something else**. For a custom endpoint the retry keeps the base
URL so only the key is re-entered. Common causes: the key was copied with
surrounding whitespace, it lacks credit/billing on the provider side, or (custom)
the base URL or model id is wrong.

See `reference/ai` for the chat UI, models, and what the AI can do once a
provider is connected.
