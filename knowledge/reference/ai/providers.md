---
name: "knowledge-ai-providers"
description: "The chat model selector: Brilliant AI and your own providers, switching models, enabling extra models, and thinking levels."
assumes: reference/ai
---

# Providers and Models

**Brilliant AI** leads the model selector and is selected by default in a new session: Brilliant-provided models served through Brilliant's servers, included with your plan (no key to set up). Below it sit your own providers, unchanged: **Claude CLI** (local `claude` binary), **Codex** (local `codex` CLI, signed in with a ChatGPT subscription rather than an API key), **Cursor** (local `cursor-agent` CLI, signed in with a Cursor account rather than an API key), **Anthropic**, **OpenAI**, **Google (Gemini)**, **OpenRouter**, and **Meta** (the Muse models, with a Meta Model API key from https://dev.meta.ai). Any **custom or self-hosted OpenAI-compatible** endpoint can be added too (see `reference/ai-setup/custom-providers`); its models then appear under its own name. The model selector lists Brilliant AI plus every model of your own whose provider currently has a valid key (or, for Claude CLI / Codex / Cursor, a detected and signed-in install). Each model shows a short quality/speed subtitle (for example "Best", "Excellent", "Good + Fast", or "Auto"). The collapsed model button shows the name of the model in use (for Brilliant AI, the Gemini model name); "Brilliant AI" is the heading its entries sit under.

Brilliant AI offers up to two models: **Gemini 4 Argon** (subtitle "Best"), Google's flagship reasoning model and the default for new sessions while Brilliant serves it (its row appears in the picker once served), and **Gemini 3.8 Flash** (subtitle "Included"), the default when Argon is not served and always a pick; a model you chose yourself is never replaced. Argon uses your Brilliant AI usage faster than Flash: about two and a half times as much per message at Google's launch price, which runs through 30 November 2026; from 1 December 2026 Google doubles Argon's price, so the same message uses about twice as much again. Pick Argon for the hardest work and switch back to Flash to make your usage last; the usage meter and its limits are the same for both.

- The exact model lineup changes between releases. Read the live list in the model selector rather than assuming specific model names.
- Context-window size varies per model, and the readout reflects the real per-model window. The session shows how much of the context window is LEFT as a bare percentage that starts at 100% and counts down. It rides beside the turn's stopwatch: while the agent is running it sits just left of the elapsed timer and updates live as the answer grows, and once the answer lands it sits just left of the time that answer took, on the last AI message. Hover it for the full breakdown: percent used, tokens used, capacity, and room left until the context is compacted.
- Some OpenRouter-only models are text-only (no image/vision support); attaching an image to those will not work.
- If a provider serves a response from a different model than the one selected (for example a usage-limit fallback), a card announces the switch and the context-usage indicator follows the model actually used. The selector still shows your choice.

### Switching models

- Click the **model selector** in the chat input bar to change the model for the current session. The chosen model becomes the default for new sessions.
- Type `/model` for an interactive provider-then-model picker (concrete models only, the current one marked; there is no "Default" row).

### Enabling extra models

The selector normally lists a curated set of models per provider. To use a model that is not shipped (an older, newer, or niche one the key can reach), enable it manually:

1. Open **Settings** (Cmd+,) and go to **Your own AI**.
2. On a connected provider row (Anthropic, OpenAI, Google, OpenRouter, or Meta), click the **Choose models** button (sliders icon).
3. The panel fetches that provider's full model list live. Shipped models sit at the top, locked on. Every other model is a toggle. A search field at the top filters the list.
4. Toggle on the models to add. They appear in the chat model selector immediately (under the same provider), no restart.

Capabilities for a manually enabled model (context window, thinking support) are inferred from its id, so a niche model may show a conservative context window or no thinking selector. Claude CLI has no picker: it lists whatever the installed binary reports.

### Thinking / reasoning levels

A thinking-level selector sits next to the model selector when the model supports it. Its readout names the level: **Thinking: Off / Low / Medium / High**.

- **Brilliant AI** defaults to thinking **off** (the readout reads **Thinking: Off**, thoughts are not shown); pick **Low**, **Medium**, or **High** for deeper reasoning.
- On your own **Claude** keys the levels are **off, low, medium, high** (flagship models add **xhigh**; only Claude can be turned off), and each model keeps its own default (Claude defaults to off).
- On your own **OpenAI** and **Google (Gemini)** keys the reasoning models always reason and offer **low, medium, high** (so they default to **Low**, never off; Gemini 4 Argon and Gemini 4 Carbon start at **Medium**, Google's documented default); some OpenAI reasoning models add **xhigh**.
- On your own **Meta** key the Muse models always reason (no off) and offer **minimal, low, medium, high, xhigh, max** (Muse Spark 1.2 and older stop at **xhigh**); they default to **Low**. Muse keeps its reasoning private, so no thoughts are shown while it thinks.
- Text-only models show no selector.

## Your own AI: setting up API keys

Sending a prompt with no key connected still just works: it runs on Brilliant AI. The short in-chat setup conversation opens only when you choose to bring your own AI (from Settings, or from the door at a wall). Full setup detail (keys and where they are stored, all paths, custom endpoints, the Replays pills, key-rejected troubleshooting) lives in `reference/ai-setup`.
