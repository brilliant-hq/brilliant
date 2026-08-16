---
name: "knowledge-ai-setup"
description: "Connecting an AI provider to Brilliant's integrated chat: BYOK API keys (Anthropic, OpenAI, Google, OpenRouter), the Claude Code CLI, the OpenAI Codex CLI (ChatGPT-subscription auth), custom and self-hosted OpenAI-compatible endpoints (LM Studio, Ollama, vLLM, GLM, DeepSeek, and more), choosing or adding extra models, where keys are stored, the demo (playground) mode and its two exits, the in-chat setup conversation, and what to do when a key is rejected. Setup and how-it-works, not the chat UI (see ai.md) or driving Brilliant from another tool (see mcp-connections.md)."
---

# Connecting an AI provider (BYOK setup)

Brilliant chat is **bring-your-own-key (BYOK) only**. Every request goes straight
from the app to the chosen provider using the user's own key or local CLI.
Nothing routes through Brilliant servers, and there is no hosted/managed Brilliant
AI to offer. The user pays their provider directly.

Keys are stored locally in the OS credential store (macOS Keychain, Windows
Credential Manager; in the web editor, that browser's local storage) and sent
only to that provider's own API endpoint. Brilliant also reads provider
environment variables as a fallback: `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`,
`GOOGLE_API_KEY`, `OPENROUTER_API_KEY`.

In the **web editor** (brilliant.design), Anthropic, Google, and OpenRouter
work; direct OpenAI is refused honestly (its API blocks browser requests —
OpenAI models run there via OpenRouter), and Claude Code / Codex / MCP
connections need the desktop app.

## Adding a key (Settings → AI Providers)

This is the primary setup surface. Open it via **Settings (Cmd+,) → AI
Providers**, or by clicking the **connection indicator** in the bottom toolbar
(the check/x circle beside the AI input) which jumps straight to that pane.
Hovering the indicator shows a read-only status popup of every provider; it does
not manage keys.

On the AI Providers list:

- **Anthropic, OpenAI, Google, OpenRouter, Quiver** each have a row with an
  inline key field. Paste the key and it is validated against the provider before
  it saves. A saved row shows a green dot, the masked key, a pencil (update) and
  an x (remove).
- **Google** can alternatively sign in with Google (a localhost OAuth flow)
  instead of a raw key.
- **Claude Code** leads the list and has no key field: install the `claude` CLI
  and Brilliant detects it automatically — on launch, when the AI Providers pane
  opens, and on the in-chat setup's "check again" — with no app restart needed
  after installing. If the CLI is not signed in, run `claude auth login` in a
  terminal. If the row reads "Installed · login unverified, chat still works",
  only the sign-in check was inconclusive: the CLI is detected and chat runs
  normally. The circular-arrow button re-checks.
- **Codex** follows Claude Code and likewise has no key field: it signs in with
  a ChatGPT subscription, not an API key. Install with `npm install -g
  @openai/codex`, run `codex login` once, and Brilliant detects it on launch. Its
  GPT-5.6-family and GPT-5.5 models then appear in the model selector. Detection
  searches the usual install locations (Homebrew, npm, pnpm, Volta, Bun, and the
  nvm/fnm/asdf/mise node-version dirs). If your codex lives somewhere unusual, or
  a slow shell startup outruns detection, set the `BRILLIANT_CODEX_PATH`
  environment variable to the codex binary and Brilliant will use it directly.
- **Quiver** powers AI vector generation and vectorization, not chat. It is set
  the same way but is not a chat provider.

**Model-setting tip:** design iteration in Brilliant tends to reward fast
feedback over deep deliberation. Running models with extended thinking OFF
usually costs nothing in result quality here and gets more iterations out of
the same tokens and time, since each round-trip is shorter. This works because
mistakes cannot pass silently: a wrong tool call halts with clear diagnostics,
and the canvas feedback flags clipping elements, unreadable text, and similar
issues visually, so the model corrects on the fly instead of needing to reason
everything out up front. Worth trying as the default; switch thinking on for
genuinely gnarly one-shot asks.

## Custom and self-hosted providers

Any OpenAI-compatible endpoint can be added under **Settings → AI Providers →
Custom Providers**. Each entry is a base URL plus an optional key; the models it
exposes then appear in the chat model selector under that provider's name.

Add one with the **base-URL field + key field + checkmark**. The base-URL field
has a dropdown of built-in presets that pre-fill the URL:

| Preset | Kind | Key |
|--------|------|-----|
| LM Studio, Ollama, vLLM | local (localhost) | none needed |
| GLM (Z.ai), Moonshot (Kimi), DeepSeek, Xiaomi MiMo | hosted | required |
| Custom OpenAI-compatible | anything else | optional |

On save Brilliant tests the connection first, then populates the model list:
curated defaults for the preset plus whatever the endpoint's model-listing API
returns. Local presets ship no curated models, so their list is whatever the
runtime currently serves (use the row's refresh button after pulling a new
model). The key is optional: local runtimes usually need none, so leave the field
blank. A bad key or unreachable URL surfaces an inline error instead of saving.

## No provider yet: demo mode

With no provider connected, chat opens in **demo mode** (called "playground" in
settings): the session replays bundled recordings instead of calling a live
model, so the user can see what the AI does before committing a key. The
connection indicator still reads as connected while a demo is the active path.

Two ways to leave demo mode:

1. **Connect a provider** anywhere (Settings, the connection indicator, or the
   in-chat setup below). The open demo chat converts in place to a real session,
   carrying any draft prompt.
2. **Once a provider exists**, just send a real prompt; the demo session is
   swapped for a live one and the prompt fires as the first real turn.

A **Playground** toggle in Settings → AI Providers puts a user who already has
a provider back into demo mode. With no provider it reads on and disabled,
since there is nothing else to chat with.

The **web editor** works the same way in any project the user can edit: no
provider means demo mode, and replays land real, undoable elements on the open
project canvas and save normally. View-only visitors never get demo mode. The
`/playground` page is the separate guided demo for visitors.

## Setting up from inside chat

Sending a free-form prompt with no provider connected starts a short in-chat
setup conversation (the typed prompt is stashed and sent for real once a provider
is live). It offers to **set it up here** or **open Settings**, then a provider
picker: Anthropic / OpenAI / Google / OpenRouter (paste a key), a **custom
OpenAI-compatible** path (pick a preset, optionally paste a key, pick a model),
**Claude Code** (install steps), **Drive Brilliant via MCP** (connect an external
tool such as Cursor, Claude Code, Codex, or Antigravity, see
[mcp-connections.md](./mcp-connections.md)), and an **"I don't know"** option that
recommends a path in plain language. A pasted key never appears in the transcript
or prompt history. Question options are clickable — clicking one sends its
number, same as typing it.

In the web editor the same conversation stays honest about the browser: OpenAI,
Claude Code, Codex, and MCP are still listed, but picking one explains why it
needs the desktop app and reroutes to the closest working path (OpenAI/Codex →
an OpenRouter key; Claude Code → an Anthropic key).

## When a key is rejected

Keys are validated on save, so a bad key fails immediately with an inline error
rather than later mid-chat. In the in-chat setup, a rejected key offers **paste
again** or **try something else**. For a custom endpoint the retry keeps the base
URL so only the key is re-entered. Common causes: the key was copied with
surrounding whitespace, it lacks credit/billing on the provider side, or (custom)
the base URL or model id is wrong.

See [ai.md](./ai.md) for the chat UI, models, and what the AI can do once a
provider is connected.
