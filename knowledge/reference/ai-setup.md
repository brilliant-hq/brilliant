---
name: "knowledge-ai-setup"
description: "Brilliant AI is the zero-setup default; this page is the other lane: Connecting an AI provider to Brilliant's integrated chat: your own API keys (Anthropic, OpenAI, Google, OpenRouter, Meta), the Claude Code CLI, the OpenAI Codex CLI (ChatGPT-subscription auth), the Cursor CLI (cursor-agent, Cursor-account auth), Muse Code (`muse`, Meta-account auth, the only way to Muse Wonder Full), custom and self-hosted OpenAI-compatible endpoints (LM Studio, Ollama, vLLM, GLM, DeepSeek, and more), choosing or adding extra models, where keys are stored, the Replays pills, setting up your own AI from Settings or the upgrade wall, and what to do when a key is rejected. Setup and how-it-works, not the chat UI (see ai.md) or driving Brilliant from another tool (see mcp-connections.md)."
---

# Connecting an AI provider (Your own AI setup)

**Brilliant AI** is the default: the first AI chat message just works, no setup,
through a Brilliant-provided model (Gemini 4 Argon while Brilliant serves it, else Gemini 3.8 Flash). Free includes Brilliant AI
every month, and part of it can be used before you sign in; sign in to keep going,
free, and signing in starts a full month. Paid
plans, monthly only (Personal $20, Pro $50, Max $100, Max
20x $200), raise your usage in multiples of the base (5x, 10x, 20x), shown as an
opaque meter (a percent used and a reset date) in Settings > Models (type
`/usage` in the chat for the same on demand) and on the account usage page. On
Brilliant AI the request goes through Brilliant's servers to Google.

If you picked a specific model earlier that you cannot use on this device (its key
is not here, on a new browser or after stored keys were cleared, or a Claude Code /
Codex / Cursor default in the web app, where there is no CLI to run, or on a computer
where that CLI is not installed), new chats open on Brilliant AI in the meantime.
Your earlier choice is remembered exactly as you left it: the moment it is usable
again (you add that key back, or that CLI is installed, right there in the session,
no restart) it becomes your default again, and it is never replaced by some other
model of that provider.

This page covers **Your own AI**: bringing your own key or local CLI. Every such
request goes straight from the app to the chosen provider using the user's own
key or local CLI; a key you bring never routes through Brilliant servers, and the
user pays their provider directly. Your own AI is free forever: unlimited over MCP
(except an image your agent generates on Brilliant AI, which draws on your
Brilliant AI usage unless you add your own Google key), with a 10-messages-a-day
cap on the Free plan for the built-in chat on your own key.

On your own Google key Gemini 4 Argon, Google's fast Gemini 4 reasoning model (also on OpenRouter as `google/gemini-4-argon`), is now the default and leads the list; right under it sits Gemini 4 Carbon, Google's strongest reasoning model (on OpenRouter as `google/gemini-4-carbon`), then Gemini 3.8 Flash. Both Gemini 4 models start at Medium thinking. Argon needs a paid-tier Gemini API key: Google does not serve it on the free tier or on the Google AI Pro plan.

- `reference/ai-setup/adding-key`: Settings > Models > Your own AI, where keys are stored, the web editor, the API-key rows, Google sign-in, Quiver, and the thinking-off tip
- `reference/ai-setup/claude-code`: the Claude Code CLI row: detection, sign-in, plan eligibility, a failed status check, the minimum CLI version
- `reference/ai-setup/codex-cursor`: the Codex, Cursor and Muse Code rows: install, sign-in, detection paths, failure causes
- `reference/ai-setup/custom-providers`: custom and self-hosted OpenAI-compatible endpoints and their presets
- `reference/ai-setup/model-overrides`: context window and image support for extra models on a built-in provider
- `reference/ai-setup/replays`: the pills on an empty chat: Replays with only Brilliant AI, prompt suggestions with your own AI
- `reference/ai-setup/own-ai`: setting up your own AI from Settings or the upgrade wall, and when a key is rejected
