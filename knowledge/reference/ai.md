---
name: "knowledge-ai"
description: "Brilliant's integrated AI: the chat that designs on the canvas, Brilliant AI (the zero-setup default) with its monthly usage included on Free, your own AI (keys and coding agents), the chat panel and session tabs, model and thinking selection, attachments and consent, AI image and vector generation, background removal and the cutout outline, and chat slash commands and shortcuts."
---

# AI Features

Brilliant has one integrated AI system: a multi-provider chat that drives a model (Brilliant AI by default, or one on your own key: Claude, GPT, Gemini, a local Claude CLI, OpenAI Codex, or Cursor) to design directly on the canvas. The entry point is the AI input in the bottom toolbar. Type a prompt, press Enter, and a chat session starts. Anything the AI produces lands on the canvas and stays fully editable by hand.

Brilliant chat has two power sources. **Brilliant AI** is the default: the first message just works, no setup, through a Brilliant-provided model (Gemini 4 Argon by default once Brilliant serves it, with Gemini 3.8 Flash as a pick). Free includes Brilliant AI every month: usage that resets monthly with no rollover. Part of it can be used before you sign in; sign in to keep going, free, and signing in starts a full month. Paid plans, monthly only (Personal $20, Pro $50, Max $100, Max 20x $200), raise your usage in multiples of the base (5x, 10x, 20x); usage shows as an opaque meter (a percent used and a reset date) in Settings > Models (type `/usage` in the chat for the same on demand) and on the account usage page, never credits, tokens, or dollars. Once you have used 80% or more, the chat header shows a quiet pill with what is left and the next step ("20% of your trial left · sign in for more" signed out, "20% left · resets 13 October" on a plan); tapping it opens the sign-in page when you are signed out, or the upgrade page on a plan. On Brilliant AI the request goes through Brilliant's servers to Google. **Your own AI** is the alternative: bring your own provider API key (Anthropic, OpenAI, Google, OpenRouter, Meta), a local `claude` CLI install, Codex, Cursor, or a custom/self-hosted OpenAI-compatible endpoint. This chat's text goes straight to the chosen provider; a key you bring never routes through Brilliant servers, and you pay your provider directly. Your own AI is free forever, unlimited over MCP (except an image your agent generates on Brilliant AI, which draws on your Brilliant AI usage unless you add your own Google key), with a 10-messages-a-day cap on the Free plan for the built-in chat on your own key; any paid plan removes it. A separate Quiver key powers AI vector generation and image vectorization (not chat).

With no provider of your own connected the chat still works: the default is Brilliant AI, so your first message sends on your included Brilliant AI usage. An empty chat offers pills: Replays of recorded sessions when only Brilliant AI is connected, prompt suggestions when you have an AI of your own (`reference/ai-setup/replays`). For all of setup, custom endpoints, and key troubleshooting, see `reference/ai-setup`. To drive Brilliant from your own coding tool (Cursor, Claude Code, etc.) instead of chatting inside it, see `reference/mcp-connections`.

- `reference/ai/input-bar`: the AI input bar, sending a prompt, input helpers, and the inline prompt on a selection
- `reference/ai/limits`: signing in, subscribing in the editor, the Free plan limits, and the message held at a wall
- `reference/ai/errors`: what the chat shows when a provider refuses, a request goes wrong, history cannot save, a canvas is missing, or Brilliant stops the model
- `reference/ai/chat-panel`: the chat panel, sessions and tabs, reading the conversation, panel controls
- `reference/ai/providers`: providers and models, switching, extra models, thinking levels (keys and setup: `reference/ai-setup`)
- `reference/ai/context`: context and attachments (explicit consent), and what the AI can do on the canvas
- `reference/ai/images`: AI image generation, Remove Background, Add Outline
- `reference/ai/vectors`: AI vector generation and vectorize (Quiver), choosing image vs vector
- `reference/ai/slash-commands`: the chat slash commands
- `reference/ai/sessions`: stopping and cancellation, chat session shortcuts
