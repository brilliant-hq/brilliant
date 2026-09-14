---
name: "knowledge-ai-setup"
description: "Brilliant AI is the zero-setup default; this page is the other lane: Connecting an AI provider to Brilliant's integrated chat: your own API keys (Anthropic, OpenAI, Google, OpenRouter), the Claude Code CLI, the OpenAI Codex CLI (ChatGPT-subscription auth), the Cursor CLI (cursor-agent, Cursor-account auth), custom and self-hosted OpenAI-compatible endpoints (LM Studio, Ollama, vLLM, GLM, DeepSeek, and more), choosing or adding extra models, where keys are stored, the demo (playground) mode, setting up your own AI from Settings or the upgrade wall, and what to do when a key is rejected. Setup and how-it-works, not the chat UI (see ai.md) or driving Brilliant from another tool (see mcp-connections.md)."
---

# Connecting an AI provider (Your own AI setup)

**Brilliant AI** is the default: the first AI chat message just works, no setup,
through a Brilliant-provided model (Gemini 3.8 Flash). Free includes Brilliant AI
every month, and part of it can be used before you sign in; sign in to keep going,
free, and signing in starts a full month. Paid
plans, monthly only (Personal $20, Pro $50, Max $100, Max
20x $200), raise your usage in multiples of the base (5x, 10x, 20x), shown as an
opaque meter (a percent used and a reset date) in Settings > Usage (type
`/usage` in the chat for the same on demand) and on the account usage page. On
Brilliant AI the request goes through Brilliant's servers to Google.

If you picked a specific model earlier but its key is not on this device (a new
browser, or one whose stored keys were cleared), new chats open on Brilliant AI in
the meantime. Your earlier choice is remembered exactly as you left it: the moment
you add that key back (right there in the session, no restart) it becomes your
default again, and it is never replaced by some other model of that provider.

This page covers **Your own AI**: bringing your own key or local CLI. Every such
request goes straight from the app to the chosen provider using the user's own
key or local CLI; a key you bring never routes through Brilliant servers, and the
user pays their provider directly. Your own AI is free forever: unlimited over MCP,
with a 10-messages-a-day cap on the Free plan for the built-in chat on your own key.

Keys are stored locally in the OS credential store (macOS Keychain, Windows
Credential Manager; in the web editor, that browser's local storage) and sent
only to that provider's own API endpoint. Brilliant also reads provider
environment variables as a fallback: `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`,
`GOOGLE_API_KEY`, `OPENROUTER_API_KEY`.

In the **web editor** (brilliant.design), Anthropic, OpenAI, Google, and
OpenRouter all work with a pasted API key (the key lives in that browser's
local storage and requests go straight to the provider). Claude Code / Codex /
MCP connections need the desktop app.

## Adding a key (Settings → Your own AI)

This is the primary setup surface. Open it via **Settings (Cmd+,) → Your own AI**.
It lists every provider and its connection status; keys are managed there, not on
the bottom toolbar.

On the Your own AI list:

- **Anthropic, OpenAI, Google, OpenRouter, Quiver** each have a row with an
  inline key field. Paste the key and it is validated against the provider before
  it saves. A saved row shows a green dot, the masked key, a pencil (update) and
  an x (remove).
- **Google** can alternatively sign in with Google (a localhost OAuth flow)
  instead of a raw key.
- **Claude Code** leads the list and has no key field: install the `claude` CLI
  and Brilliant detects it automatically (on launch, when the Your own AI pane
  opens, and on a manual re-check) with no app restart needed
  after installing. If the CLI is not signed in, run `claude auth login` in a
  terminal. If the row reads "Installed · login unverified, chat still works",
  only the sign-in check was inconclusive: the CLI is detected and chat runs
  normally. The circular-arrow button re-checks. Claude Code needs a paid Claude
  plan (Pro, Max, Team, or Enterprise); if the CLI is signed in on a plan that
  cannot run it, the row reads "Signed in · plan not eligible" (or "Signed in ·
  plan unverified" when no plan could be read) rather than "Not connected",
  since detection and sign-in both worked and only the plan disqualifies it.
  If Claude Code is your only provider and its status check outright fails (for
  example behind a corporate proxy or a custom certificate authority, where a
  `claude` that works in your terminal can still fail when the app launches it),
  the chat panel says so instead of sitting empty: it names the likely cause
  (network or proxy, certificate, permission, sign-in, or an out-of-date
  version) and shows a **Retry** button that re-checks. Brilliant runs that
  check under your login shell's environment (the same PATH, proxy, and CA
  settings your terminal uses), and re-checks once on its own the first time you
  click into the chat box, so a fix you make in your terminal is picked up
  without restarting the app.
- **Codex** follows Claude Code and likewise has no key field: it signs in with
  a ChatGPT subscription, not an API key. Install with `npm install -g
  @openai/codex`, run `codex login` once, and Brilliant detects it on launch. Its
  GPT-5.6-family and GPT-5.5 models then appear in the model selector. Detection
  searches the usual install locations (Homebrew, npm, pnpm, Volta, Bun, and the
  nvm/fnm/asdf/mise node-version dirs). If your codex lives somewhere unusual, or
  a slow shell startup outruns detection, set the `BRILLIANT_CODEX_PATH`
  environment variable to the codex binary and Brilliant will use it directly.
- **Cursor** also has no key field: it signs in with your Cursor account, not an
  API key. The `cursor-agent` CLI is a **separate install from the Cursor desktop
  app** (a common surprise: having the app does not give you the CLI). Install the
  Cursor CLI (`cursor-agent`), run `cursor-agent login` once
  (or set a `CURSOR_API_KEY`), and Brilliant detects it on launch. A single
  **Cursor Agent** model then appears in the selector; it auto-routes to the best
  model for the task, the way `cursor-agent` does on its own. The settings row
  reads "Not connected" when the CLI itself was not found (install it), and
  "Not signed in" when the CLI is found but not logged in yet; run
  `cursor-agent login` in your terminal, then the circular-arrow button
  re-checks. If your `cursor-agent` lives somewhere unusual, set the
  `BRILLIANT_CURSOR_AGENT_PATH` environment variable to its path. If a chat fails
  to start, the error names the actual cause rather than always pointing at
  login: a sign-in problem still says to run `cursor-agent login`, but a process
  that could not launch, a request cursor-agent rejected (a version mismatch),
  or a no-response timeout each say so plainly, so you fix the right thing.
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
genuinely gnarly one-shot asks. Brilliant AI already runs at its lightest
thinking level unless you pick a higher one.

## Custom and self-hosted providers

Any OpenAI-compatible endpoint can be added under **Settings → Your own AI →
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

## Demo mode (playground)

Brilliant AI is the default, so with no provider of your own connected the chat is not a
demo: your first message enrolls in Brilliant AI and sends on your included usage. Demo
mode (called "playground" in settings) is now an explicit choice, not the
no-provider fallback: the session replays bundled recordings instead of calling a
live model, so you can see what the AI does before spending Brilliant AI usage or
committing a key.

Enter and leave demo mode:

1. A **Playground** toggle at the bottom of the Settings → Your own AI pane turns demo mode on and off.
2. **Leave the demo** with the *Exit the demo* button on the card, or by turning the
   Playground toggle back off. A typed prompt that matches no recording is NOT sent to a
   model: it shows that Exit-the-demo card. A suggested prompt pill replays in place.
   Leaving opens a live chat (Brilliant AI by default, or a connected provider of your own).
3. **Connect a provider of your own** from a demo chat and it converts in place to a real
   session on that provider, carrying any draft prompt.

The onboarding step is the only other way into a replay: it plays one recorded
session when you tap a prompt pill. That is the way to watch the demo, not the
only way out of the onboarding window: opening a new chat ("+", Cmd+N, or
/new-chat) also leaves it and lands a real Brilliant AI chat straight away.
Because Brilliant AI is the always-available default, the Playground toggle is a
deliberate choice rather than the no-provider fallback it used to be.

The **web editor** works the same way in any project the user can edit, and demo
replays land real, undoable elements on the open project canvas and save normally.
View-only visitors never get demo mode. The `/playground` page is the separate
guided demo for visitors.

## Setting up your own AI (Brilliant AI is the default first send)

The first-run **"How do you want to use AI with Brilliant?"** chooser is retired.
Sending a free-form prompt no longer opens a setup conversation: the message
enrolls in Brilliant AI and sends on your included usage. Your own AI is a **Settings** choice
(the Your own AI pane above) and the **secondary action on the upgrade wall** shown
when Brilliant AI usage runs out (that wall is a page on the command-palette shell,
the same overlay as sign in, that offers the paid rungs; your own AI is never
walled by usage). Paying happens in the editor too: a Personal purchase, or a
bigger plan bought from a free or gifted account, opens a checkout page on the
same overlay (it names the plan and its monthly price), the plan flips live, and
the held message continues. On a paid subscription, picking a bigger plan on
that wall switches you in place instead.

Choosing to set up your own AI opens the Your own AI pane, where a pasted key never
appears in the transcript or prompt history. In the **web editor**, Anthropic,
OpenAI, Google, and OpenRouter keys all work; Claude Code, Codex, and connecting a
coding agent over MCP need the desktop app (the closest working browser path is an
Anthropic or OpenRouter key). To drive Brilliant from an external tool such as
Claude Code, Cursor, or Codex over MCP instead of chatting inside it, see
[mcp-connections.md](./mcp-connections.md).

## When a key is rejected

Keys are validated on save, so a bad key fails immediately with an inline error
rather than later mid-chat. When adding a key, a rejected key offers **paste
again** or **try something else**. For a custom endpoint the retry keeps the base
URL so only the key is re-entered. Common causes: the key was copied with
surrounding whitespace, it lacks credit/billing on the provider side, or (custom)
the base URL or model id is wrong.

See [ai.md](./ai.md) for the chat UI, models, and what the AI can do once a
provider is connected.
