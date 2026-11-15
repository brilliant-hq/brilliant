---
name: "knowledge-ai-setup-adding-key"
description: "Adding a key in Settings > Models > Your own AI: where keys are stored, the web editor, the API-key rows, Google sign-in, Quiver, and the thinking-off tip."
assumes: reference/ai-setup
---

# Adding a key (Settings → Models → Your own AI)

This is the primary setup surface. Open it via **Settings (Cmd+,) → Your own AI**.
It lists every provider and its connection status; keys are managed there, not on
the bottom toolbar.

Keys are stored locally in the OS credential store (macOS Keychain, Windows
Credential Manager; in the web editor, that browser's local storage) and sent
only to that provider's own API endpoint. Brilliant also reads provider
environment variables as a fallback: `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`,
`GOOGLE_API_KEY`, `OPENROUTER_API_KEY`, `META_API_KEY` (or Meta's own
name, `MODEL_API_KEY`).

In the **web editor** (brilliant.design), Anthropic, OpenAI, Google and OpenRouter work with a
pasted API key (it lives in that browser's local storage, requests go straight to the provider);
Claude Code / Codex / Cursor / MCP connections need the desktop app.

On the Your own AI list:

- **Anthropic, OpenAI, Google, OpenRouter, Meta, Quiver** each have a row with an
  inline key field. Paste the key and it is validated against the provider before
  it saves. A saved row shows a green dot, the masked key, a pencil (update) and
  an x (remove).
- **Meta** takes a Meta Model API key (create one at https://dev.meta.ai); its
  row adds the Muse models (Muse Wonder 1.0, Muse Spark 1.3, Muse Spark 1.2).
  Choose models lists the other Muse ids the key can reach, including the
  discounted contributor tier (Meta may train on that traffic, so it is never
  on by default).
- **Google** can alternatively sign in with Google (a localhost OAuth flow)
  instead of a raw key.
- **Claude Code**, **Codex** and **Cursor** rows: see `reference/ai-setup/claude-code` and `reference/ai-setup/codex-cursor`.
- **Quiver** powers AI vector generation and vectorization, not chat. It is set
  the same way but is not a chat provider. Create the key in the Quiver API
  Platform at https://platform.quiver.ai/api-keys; usage draws from that
  platform's balance, not Quiver app credits. Older Quiver keys were retired
  by Quiver: if Brilliant says the key was retired, create a new one there and
  paste it on the Quiver row.

**Model-setting tip:** design iteration rewards fast feedback over deep deliberation, so run
models with extended thinking OFF: it usually costs nothing in result quality here and gets more
iterations out of the same tokens and time, because mistakes cannot pass silently (a wrong tool
call halts with clear diagnostics, the canvas feedback flags clipping and unreadable text). Switch
thinking on for genuinely gnarly one-shot asks. Brilliant AI already defaults to OFF unless you pick a higher level (`reference/ai/providers`, the thinking section, is the home).
