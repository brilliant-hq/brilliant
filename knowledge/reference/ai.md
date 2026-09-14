---
name: "knowledge-ai"
description: "Brilliant's integrated AI: the chat that designs on the canvas, Brilliant AI (the zero-setup default) with its monthly usage included on Free, your own AI (keys and coding agents), the chat panel and session tabs, model and thinking selection, attachments and consent, AI image and vector generation, and chat slash commands and shortcuts."
---

# AI Features

Brilliant has one integrated AI system: a multi-provider chat that drives a model (Brilliant AI by default, or one on your own key: Claude, GPT, Gemini, a local Claude CLI, OpenAI Codex, or Cursor) to design directly on the canvas. The entry point is the AI input in the bottom toolbar. Type a prompt, press Enter, and a chat session starts. Anything the AI produces lands on the canvas and stays fully editable by hand.

Brilliant chat has two power sources. **Brilliant AI** is the default: the first message just works, no setup, through a Brilliant-provided model (Gemini 3.8 Flash). Free includes Brilliant AI every month: usage that resets monthly with no rollover. Part of it can be used before you sign in; sign in to keep going, free, and signing in starts a full month. Paid plans, monthly only (Personal $20, Pro $50, Max $100, Max 20x $200), raise your usage in multiples of the base (5x, 10x, 20x); usage shows as an opaque meter (a percent used and a reset date) in Settings > Usage (type `/usage` in the chat for the same on demand) and on the account usage page, never credits, tokens, or dollars. Once you have used 80% or more, the chat header shows a quiet pill with what is left and the next step ("20% of your trial left · sign in for more" signed out, "20% left · resets 13 October" on a plan); tapping it opens the sign-in page when you are signed out, or the upgrade page on a plan. On Brilliant AI the request goes through Brilliant's servers to Google. **Your own AI** is the alternative: bring your own provider API key (Anthropic, OpenAI, Google, OpenRouter), a local `claude` CLI install, Codex, Cursor, or a custom/self-hosted OpenAI-compatible endpoint. This chat goes straight to the chosen provider; a key you bring never routes through Brilliant servers, and you pay your provider directly. Your own AI is free forever, unlimited over MCP, with a 10-messages-a-day cap on the Free plan for the built-in chat on your own key; any paid plan removes it. A separate Quiver key powers AI vector generation and image vectorization (not chat).

With no provider of your own connected the chat still works: the default is Brilliant AI, so your first message sends on your included Brilliant AI usage rather than opening a demo. Demo (playground) replay mode is available as an explicit choice, a Playground toggle in Settings and the `/playground` visitor page, not the no-provider fallback it used to be. For all of setup, custom endpoints, demo mode, and key troubleshooting, see [ai-setup.md](./ai-setup.md). To drive Brilliant from your own coding tool (Cursor, Claude Code, etc.) instead of chatting inside it, see [mcp-connections.md](./mcp-connections.md).

---

## AI Input Bar (Bottom Toolbar)

The input lives in the bottom toolbar, to the right of the drawing-tool buttons.

- Focus it with **/** (slash), by clicking the field, or via the **Focus AI Chat** command in the command palette.
- A chevron toggle beside the field collapses it down to a sparkle button plus a right-facing chevron: the sparkle opens or closes the AI chat (it stays highlighted while the chat is open), and the chevron brings the input field back.

### How to send a prompt

1. Optionally select one or more elements, or attach context manually (see Attachments).
2. Focus the input.
3. Type a prompt.
4. Press **Enter**.

Sending creates a new chat session (topic auto-derived from the prompt) and routes it to the currently selected model. The chat panel opens above the bottom toolbar so the response streams in. While a session is processing, the input shows a spinner and a stop button; clicking stop cancels the active run.

**Signing in.** Brilliant AI is included on Free every month, and part of it can be used before you sign in, so your first messages send without an account. When that part is used up, a **Sign in to keep going, free** prompt lets you continue (Google or an emailed code), and signing in starts a full month; dismiss it and your prompt is kept in the input so nothing is lost. Subscribing happens inside the editor too, on the web as well as the desktop app: a Personal purchase opens a full-page checkout on the same overlay (you upgrade without leaving the editor), with your account email already filled in, the plan flips live, and the message you were holding continues by itself. The demo (playground), and driving Brilliant from an external tool over MCP, both need no account.

**Free plan limits.** Free gets two things. First, **Brilliant AI** every month (the default lane): included usage that resets monthly with no rollover, shown as a percent used and a reset date in Settings > Usage (type `/usage` in the chat for the same on demand) and on the account usage page; part of it can be used before you sign in, and signing in starts a full month. Second, a cap of **10 messages a day** on the built-in chat on **your own AI**: this counts each message you send, even when your own API key pays for the tokens (this stays true, no chat token routes through Brilliant, so it is a limit on the app feature, not a Brilliant AI allowance). The count resets at the start of the next UTC day, shown in your local time; at the cap the next send opens the upgrade page, which reads "You've used today's 10 messages on your own AI. Personal removes the daily limit." with an Upgrade to Personal button and a note that agents over MCP keep going, unlimited. A message blocked at any wall is held and continues by itself the instant the wall clears (you sign in, upgrade, or add your own AI), while dismissing the page (press Escape, or click outside it) returns the message to the composer as an editable draft, so the message is never lost either way. Upgrading happens without leaving the app, and the held message continues once the plan is active. Any paid plan removes the cap and raises your Brilliant AI usage. Playground replays and external MCP agents never count against either, and external agents stay unlimited on every plan. When the month's Brilliant AI usage is used up, the turn already in flight always finishes first, then the next send opens the upgrade page, a page on the command-palette shell (the same overlay as sign in, with the canvas dimmed behind it) that names when your usage resets and offers the paid rungs and a door to bring your own AI. The one exception: if your usage runs out mid-answer, the answer stops there and the sign-in or upgrade page opens right away, with your message held as usual. Your own AI is never blocked by usage.

### Input helpers

- **Placeholder hints:** the field cycles through starter-prompt suggestions and, while a session runs, rotates keyboard and feature tips. When the field is empty and a suggested prompt is showing, pressing **Enter** or the **Right arrow** fills that suggestion into the field (caret at the end, nothing sent); with text already typed, Enter sends and the Right arrow moves the caret.
- **Prompt history:** **Up/Down** arrows step through previously sent prompts (newest first). **Ctrl+P / Ctrl+N** do the same. **Ctrl+R** starts reverse-search; type to filter, press **Ctrl+R** again to cycle matches. History is deduplicated and persisted between launches.
- **`#` hashtags:** typing `#` opens a dropdown of style/context modifiers (for example dark, mobile, minimal) that get inserted into the prompt.
- **`/` slash menu:** typing `/` opens a dropdown of chat slash commands plus recent sessions for quick resume.
- **`@` mentions:** typing `@` in the AI input (both the bottom-toolbar field and the chat panel's follow-up input) opens an autocomplete of canvas elements by name; picking one attaches that element as context (see Attachments).

---

## The Chat Panel

The chat panel floats above the bottom toolbar. It holds the active session and an optional **chat explorer** sidebar (session list).

### Sessions

Start a new session by submitting from the bottom-toolbar input, clicking **+** in the chat panel header, or pressing **Cmd+N** while the AI input is focused. Each session keeps its own provider, model, thinking level, conversation history, and context. Multiple sessions can run concurrently. Sessions persist between launches.

### Session tabs

Each active session appears as a tab to the right of the AI input in the bottom toolbar.

- **Minimized:** topic label, processing spinner, and context-usage percentage. Click to expand, double-click to rename.
- **Expanded:** the full chat panel with messages, attachments, and a follow-up input.

Tabs can be dragged to reorder. The toolbar scrolls horizontally when tabs overflow.

### Panel controls

- **Open / close:** click the sparkle button in the bottom toolbar (shown when the AI input is collapsed; highlighted while the chat is open), or focus the AI input, or run **Toggle AI Chat**.
- **Rename:** double-click the topic name in the header, or use `/rename`.
- **Resize:** drag the panel edges (width and height) or the divider between sessions.
- **Queue a follow-up:** sending while the model is still working queues the message; it sends automatically when the current response finishes.
- **Answer a question:** when the AI (or the in-chat provider setup) asks a multiple-choice question, click an option or type its number; both send the number through the same lane. Free-text answers work too.
- **Edit and resend:** click the edit icon on one of your messages to revise and resend it. Editing rewinds the conversation to that message losslessly: later messages are dropped, everything up to it is kept. On a local Claude CLI, Codex, or Cursor session, which cannot rewind its own transcript, the session instead rebuilds context and replays the prior conversation, marked by a "context rebuilt" card.
- **Copy chat:** the header copy button exports the whole conversation as Markdown (with metadata: model, date, project, canvas, tokens, turns).
- **Chat explorer:** toggle with **Cmd+Shift+A** to browse, search, and manage all sessions; drag its divider to resize or collapse it.

---

## Providers and Models

**Brilliant AI** leads the model selector and is selected by default in a new session: Brilliant-provided models served through Brilliant's servers, included with your plan (no key to set up). Below it sit your own providers, unchanged: **Claude CLI** (local `claude` binary), **Codex** (local `codex` CLI, signed in with a ChatGPT subscription rather than an API key), **Cursor** (local `cursor-agent` CLI, signed in with a Cursor account rather than an API key), **Anthropic**, **OpenAI**, **Google (Gemini)**, and **OpenRouter**. Any **custom or self-hosted OpenAI-compatible** endpoint can be added too (see [ai-setup.md](./ai-setup.md)); its models then appear under its own name. The model selector lists Brilliant AI plus every model of your own whose provider currently has a valid key (or, for Claude CLI / Codex / Cursor, a detected and signed-in install). Each model shows a short quality/speed subtitle (for example "Best", "Excellent", "Good + Fast", or "Auto").

- The exact model lineup changes between releases. Read the live list in the model selector rather than assuming specific model names.
- Context-window size varies per model. The session's context-usage indicator reflects the real per-model window.
- Some OpenRouter-only models are text-only (no image/vision support); attaching an image to those will not work.
- If a provider serves a response from a different model than the one selected (for example a usage-limit fallback), a card announces the switch and the context-usage indicator follows the model actually used. The selector still shows your choice.

### Switching models

- Click the **model selector** in the chat input bar to change the model for the current session. The chosen model becomes the default for new sessions.
- Type `/model` for an interactive provider-then-model picker (concrete models only, the current one marked; there is no "Default" row).

### Enabling extra models

The selector normally lists a curated set of models per provider. To use a model that is not shipped (an older, newer, or niche one the key can reach), enable it manually:

1. Open **Settings** (Cmd+,) and go to **Your own AI**.
2. On a connected provider row (Anthropic, OpenAI, Google, or OpenRouter), click the **Choose models** button (sliders icon).
3. The panel fetches that provider's full model list live. Shipped models sit at the top, locked on. Every other model is a toggle. A search field at the top filters the list.
4. Toggle on the models to add. They appear in the chat model selector immediately (under the same provider), no restart.

Capabilities for a manually enabled model (context window, thinking support) are inferred from its id, so a niche model may show a conservative context window or no thinking selector. Claude CLI has no picker: it lists whatever the installed binary reports.

### Thinking / reasoning levels

A thinking-level selector sits next to the model selector when the model supports it. Its readout names the level: **Thinking: Off / Low / Medium / High**.

- **Brilliant AI** defaults to thinking **off** (the readout reads **Thinking: Off**, thoughts are not shown); pick **Low**, **Medium**, or **High** for deeper reasoning.
- On your own **Claude** keys the levels are **off, low, medium, high** (flagship models add **xhigh**; only Claude can be turned off), and each model keeps its own default (Claude defaults to off).
- On your own **OpenAI** and **Google (Gemini)** keys the reasoning models always reason and offer **low, medium, high** (so they default to **Low**, never off); some OpenAI reasoning models add **xhigh**.
- Text-only models show no selector.

---

## Your own AI: setting up API keys

Keys live in the OS credential store (macOS Keychain, Windows Credential Manager) and are sent only to the provider's own API endpoint. Brilliant also reads provider environment variables as a fallback (`ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `GOOGLE_API_KEY`, `OPENROUTER_API_KEY`).

Keys are managed in **Settings (Cmd+,) → Your own AI**. That pane lists every provider and its connection status; the bottom toolbar carries no status indicator. On the Your own AI list, paste a key into a provider's inline field (validated on save), or use the pencil/x buttons on a saved row to update or remove it. **Google** can sign in with Google (localhost OAuth) instead of a key; **Claude Code** needs no key (install the CLI, sign in with `/login`); **Codex** needs no key either (install `@openai/codex`, sign in with `codex login`; it uses a ChatGPT subscription); **Cursor** needs no key either (install the `cursor-agent` CLI, sign in with `cursor-agent login`; it uses your Cursor account); **Quiver** (vector generation) is set the same way but is not a chat provider. **Custom / self-hosted OpenAI-compatible** endpoints (LM Studio, Ollama, vLLM, GLM, DeepSeek, and more) are added under **Custom Providers** on the same pane.

Sending a prompt with no key connected still just works: it runs on Brilliant AI. The short in-chat setup conversation opens only when you choose to bring your own AI (from Settings, or from the door at a wall). Full setup detail (all paths, custom endpoints, demo mode, key-rejected troubleshooting) lives in [ai-setup.md](./ai-setup.md).

---

## Context and Attachments (Explicit Consent)

Outbound chat traffic is **explicit-consent only**. Brilliant does not auto-attach screenshots of the screen, system info, app version, recent files, telemetry, or other ambient context. The default is to send nothing extra beyond your prompt.

Context that can travel with a message:

1. **Canvas context (a text outline):** the message carries a *text* snapshot of the canvas: a depth-limited Blueprint of the element structure (a large canvas collapses to a short summary table, not the full tree), the design-system token catalog, the component catalog, and the element count. For API-key providers (Anthropic, OpenAI, Google, OpenRouter) this rides with *every* message, refreshed each send; for the local Claude CLI, Codex, and Cursor it goes with the first message only (later messages add just a one-line note when the user switches canvases). This is text, not an image; no screenshot of the canvas or screen is captured for this context. Your current *selection* is not included here; send it explicitly with an `@` element attachment or via the `get_selection` tool. To send a prompt with no canvas context, start the chat in an empty workspace.
2. **Per-message attachments (opt-in):** each shows as a chip above the input with an X to remove before sending. Nothing attaches unless you add it. An **element** attachment (via `@` or paste) sends that element's Blueprint plus a PNG render of just that element; **image / file** attachments send what you added.
3. **Automatic self-review screenshot (after edits):** after each block of changes, the AI asks Brilliant for its result and a screenshot of *those changed elements*, then continues and checks its own work (spacing, contrast, alignment, clipping). It is a render of the design content only, never the screen or other apps. Text-only models never receive it, and it is suppressed for the rest of a session once an endpoint rejects image input.

| Attachment | How to add |
|------------|------------|
| Element | Type **@** in the chat input and pick an element by name (its structure and a render are attached) |
| Image | Paste (Cmd+V), drag-and-drop a file, or click the paperclip |
| File | Drag-and-drop into the input, or click the paperclip |

When suggesting outbound workflows (sending logs, repro steps, feedback), follow the same rule: never auto-attach screenshots/version/files; ask per item; default to none.

---

## What the AI Can Do on the Canvas

Once a session is running, the model can create and modify designs and call tools.

- **Create designs:** build full UI, pages, dashboards, illustrations, diagrams, and wireframes that appear on the canvas as native, editable elements.
- **Edit existing work:** inspect the current design, change properties, reparent, rename, delete, and reorder elements.
- **Run app commands:** the AI can invoke Brilliant commands (align, distribute, flip, corner radius, opacity, blend mode, tool changes, frame and component operations, and more, over 100 in all). Each runs through the same path as a button or shortcut, with full undo.
- **Use selection and search:** read the current selection and look up elements by name, text, type, color, or component.
- **Export:** render selected elements to raster (PNG, JPEG, WebP), vector (SVG, PDF), HTML/React markup, or video (MP4, MOV). Raster comes back as an inline image, SVG/HTML/React as text, and PDF as base64; video (and any `outputPath`) writes a file and returns its path. In the web editor there is no local filesystem, so `outputPath` is refused (omit it and the data returns inline) and video export is unavailable. Replay is the one export the tool cannot do (it needs an interactive recording session), so it is UI-only.
- **Read and write files / run shell commands / search the web:** when working in a real project workspace (these are most capable in the Claude CLI path). In the web app (browser) there are no shell or file tools and no external MCP servers; `web_fetch` and every canvas tool work normally, and exports come back inline (raster as an image, SVG/HTML/React/PDF as text); video export is unavailable in the browser (it needs the native desktop encoder).
- **Generate images and vectors:** see the sections below.
- **Spawn sub-agents:** for large tasks, the main session can launch parallel helper agents that each return a summary, shown as collapsible cards. Sub-agents are not available on the Codex backend.

On a **view-only project** (a cloud project opened without edit access, or one being viewed while signed out), the canvas-changing tools are refused with a message to sign in; reading, searching, inspecting the selection, and exporting keep working. Signing in with an account that can edit, or downloading a copy to work on locally, makes the tools available again.

The full canvas-authoring grammar (Blueprint DSL) and the command/tool catalog are documented for the AI in the blueprint knowledge files (`blueprint/*`, including `blueprint/commands` for the command catalog); users do not author that syntax by hand.

---

## AI Image Generation

The AI generates raster images with Google's Gemini image model ("Nano Banana") and applies them as image fills on target elements. Generated images are saved to the project's `Assets/` folder.

- On Brilliant AI, image generation needs no key of your own. On your own AI it requires a connected Google provider (API key or OAuth), whichever chat model is active.
- **Sizes:** roughly 512px, 1K (default), 2K, and 4K. Larger is slower and more detailed.
- **Reference images:** the AI can pass existing canvas elements as visual references to steer style or to "edit" a prior generation by changing one thing at a time.
- **Batch / parallel:** several images can be requested in one turn.
- **Use for:** photos, realistic scenes, complex textures.

## AI Vector Graphics Generation

The AI generates editable vector graphics with Quiver's model and places them on the canvas as native vector elements, so the user can immediately move, resize, recolor, and reshape them like any hand-drawn vector. It can also **vectorize** an existing raster element on the canvas into editable vector paths (the original raster is left intact).

- **Requires** a connected Quiver provider, regardless of which chat model is active.
- **Use for:** icons, logos, illustrations, diagrams, anything that should stay crisp at any zoom and remain editable.

### Choosing image vs vector

- Photo / realistic / complex texture -> AI image generation (Google).
- Icon / logo / illustration / diagram / crisp-at-any-zoom -> AI vector generation (Quiver).
- User has a raster they want as editable vectors -> vectorize (Quiver).

For prompt patterns and decision rules, see the `svg/prompts` and `svg/integration` knowledge files.

---

## Chat Slash Commands

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

Exporting a session as a video replay is not a slash command: it is an action on a finished session (a replay export button surfaces on the session). For export formats in general, see [export.md](./export.md).

---

## Stopping and Cancellation

- Click the stop button in the chat input bar, or type `/stop`.
- The active request aborts immediately and no further tools are dispatched.
- Anything the AI already created before you stopped stays on the canvas. The stopped turn's card has a **Revert** control that undoes everything that turn changed in one step (and a Redo to bring it back); you can also undo normally.
- Sub-agents inherit cancellation from their parent session.

---

## Chat Session Shortcuts

| Action | Shortcut |
|--------|----------|
| Focus AI input in bottom toolbar | / |
| Focus chat session 1-9 | Cmd+1 - Cmd+9 (Windows: Alt+1 - Alt+9) |
| Focus chat session 10 | Cmd+0 (Windows: Alt+0) |
| Focus next chat session | Cmd+Shift+] |
| Focus previous chat session | Cmd+Shift+[ |
| New chat (when AI input focused) | Cmd+N |
| Close focused chat session | Cmd+W |
| Toggle chat explorer | Cmd+Shift+A |
| Chat search | Cmd+Shift+I |
| Escape AI chat | Esc |
| Toggle AI chat panel | (no default shortcut; assignable in the shortcuts view) |

Focusing a session by number opens the chat panel if it is hidden. Number assignments appear as badges in the chat header and explorer. To customize any of these, see [shortcuts.md](./shortcuts.md).
