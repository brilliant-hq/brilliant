---
name: "knowledge-ai"
description: "Brilliant's integrated AI: the multi-provider chat that designs on the canvas, BYOK key setup, the chat panel and session tabs, model and thinking selection, attachments and consent, AI image and vector generation, and chat slash commands and shortcuts."
---

# AI Features

Brilliant has one integrated AI system: a multi-provider chat that drives a model (Claude, GPT, Gemini, a local Claude CLI, or OpenAI Codex) to design directly on the canvas. The entry point is the AI input in the bottom toolbar. Type a prompt, press Enter, and a chat session starts. Anything the AI produces lands on the canvas and stays fully editable by hand.

Brilliant chat is **bring-your-own-key (BYOK) only**. Every call uses the user's own provider API key (Anthropic, OpenAI, Google, OpenRouter), a local `claude` CLI install, or a custom/self-hosted OpenAI-compatible endpoint. Chat traffic goes straight to the chosen provider; nothing routes through Brilliant servers, and there is no hosted Brilliant AI. A separate Quiver key powers AI vector generation and image vectorization (not chat). The user pays their provider directly.

If no provider is connected, the chat opens in a "demo" (playground) replay mode instead of a live session. Connecting a provider unlocks real chat. For all of setup, custom endpoints, demo mode, and key troubleshooting, see [ai-setup.md](./ai-setup.md). To drive Brilliant from your own coding tool (Cursor, Claude Code, etc.) instead of chatting inside it, see [mcp-connections.md](./mcp-connections.md).

---

## AI Input Bar (Bottom Toolbar)

The input lives in the bottom toolbar, to the right of the drawing-tool buttons.

- Focus it with **/** (slash), by clicking the field, or via the **Focus AI Chat** command in the command palette.
- A chevron toggle beside the field collapses it down to just the connection indicator and expands it again.

### How to send a prompt

1. Optionally select one or more elements, or attach context manually (see Attachments).
2. Focus the input.
3. Type a prompt.
4. Press **Enter**.

Sending creates a new chat session (topic auto-derived from the prompt) and routes it to the currently selected model. The chat panel opens above the bottom toolbar so the response streams in. While a session is processing, the input shows a spinner and a stop button; clicking stop cancels the active run.

**Sign in to chat.** Sending a real message to a model requires signing in to Brilliant. The first send while signed out opens a sign-in panel (Google or an emailed code); once signed in, your message goes through, and if you dismiss the panel your prompt is kept in the input so nothing is lost. The demo (playground) that plays when no provider is connected, and driving Brilliant from an external tool over MCP, both need no account.

**Free plan message cap.** On the Free plan the built-in chat allows 10 messages a day. This counts each message you send, even when your own API key pays for the tokens (BYOK stays true: no chat token routes through Brilliant, so this is a limit on the app feature, not "10 free AI messages"). The count is tracked on Brilliant's servers and resets at the start of the next UTC day, shown in your local time. At the wall you can **Upgrade** or **Continue via MCP**; a message blocked at the cap is held and auto-sends the instant the plan flips to paid. Any paid plan removes the cap. Playground replays and external MCP agents never count against it, and external agents stay unlimited on every plan.

### Input helpers

- **Placeholder hints:** the field cycles through starter-prompt suggestions and, while a session runs, rotates keyboard and feature tips.
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

- **Open / close:** click the connection indicator in the bottom toolbar, or run **Toggle AI Chat**.
- **Rename:** double-click the topic name in the header, or use `/rename`.
- **Resize:** drag the panel edges (width and height) or the divider between sessions.
- **Queue a follow-up:** sending while the model is still working queues the message; it sends automatically when the current response finishes.
- **Answer a question:** when the AI (or the in-chat provider setup) asks a multiple-choice question, click an option or type its number; both send the number through the same lane. Free-text answers work too.
- **Edit and resend:** click the edit icon on one of your messages to revise and resend it. Editing rewinds the conversation to that message losslessly: later messages are dropped, everything up to it is kept. On a local Claude CLI or Codex session, which cannot rewind its own transcript, the session instead rebuilds context and replays the prior conversation, marked by a "context rebuilt" card.
- **Copy chat:** the header copy button exports the whole conversation as Markdown (with metadata: model, date, project, canvas, tokens, turns).
- **Chat explorer:** toggle with **Cmd+Shift+A** to browse, search, and manage all sessions; drag its divider to resize or collapse it.

---

## Providers and Models

Built-in chat providers: **Claude CLI** (local `claude` binary), **Codex** (local `codex` CLI, signed in with a ChatGPT subscription rather than an API key), **Anthropic**, **OpenAI**, **Google (Gemini)**, and **OpenRouter**. Any **custom or self-hosted OpenAI-compatible** endpoint can be added too (see [ai-setup.md](./ai-setup.md)); its models then appear under its own name. The model selector only lists models whose provider currently has a valid key (or, for Claude CLI, a detected install). Each model shows a short quality/speed subtitle (for example "Best", "Excellent", "Good + Fast").

- The exact model lineup changes between releases. Read the live list in the model selector rather than assuming specific model names.
- Context-window size varies per model. The session's context-usage indicator reflects the real per-model window.
- Some OpenRouter-only models are text-only (no image/vision support); attaching an image to those will not work.
- If a provider serves a response from a different model than the one selected (for example a usage-limit fallback), a card announces the switch and the context-usage indicator follows the model actually used. The selector still shows your choice.

### Switching models

- Click the **model selector** in the chat input bar to change the model for the current session. The chosen model becomes the default for new sessions.
- Type `/model` for an interactive provider-then-model picker.

### Enabling extra models

The selector normally lists a curated set of models per provider. To use a model that is not shipped (an older, newer, or niche one the key can reach), enable it manually:

1. Open **Settings** (Cmd+,) and go to **AI Providers**.
2. On a connected provider row (Anthropic, OpenAI, Google, or OpenRouter), click the **Choose models** button (sliders icon).
3. The panel fetches that provider's full model list live. Shipped models sit at the top, locked on. Every other model is a toggle. A search field at the top filters the list.
4. Toggle on the models to add. They appear in the chat model selector immediately (under the same provider), no restart.

Capabilities for a manually enabled model (context window, thinking support) are inferred from its id, so a niche model may show a conservative context window or no thinking selector. Claude CLI has no picker: it lists whatever the installed binary reports.

### Thinking / reasoning levels

A thinking-level selector sits next to the model selector when the model supports it.

- **Claude** models support **off, low, medium, high**, and flagship models add **xhigh** (only Claude can be turned off).
- **OpenAI** and **Gemini** reasoning models always reason; they offer **low, medium, high** (no off). Some OpenAI reasoning models also add an **xhigh** level.
- Text-only models that do not reason show no thinking selector.

---

## BYOK: Setting Up API Keys

Keys live in the OS credential store (macOS Keychain, Windows Credential Manager) and are sent only to the provider's own API endpoint. Brilliant also reads provider environment variables as a fallback (`ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `GOOGLE_API_KEY`, `OPENROUTER_API_KEY`).

Keys are managed in **Settings (Cmd+,) → AI Providers**. Reach it fast by clicking the **connection indicator** in the bottom toolbar (the check/x circle beside the AI input); hovering it shows a read-only provider-status popup. On the AI Providers list, paste a key into a provider's inline field (validated on save), or use the pencil/x buttons on a saved row to update or remove it. **Google** can sign in with Google (localhost OAuth) instead of a key; **Claude Code** needs no key (install the CLI, sign in with `/login`); **Codex** needs no key either (install `@openai/codex`, sign in with `codex login`; it uses a ChatGPT subscription); **Quiver** (vector generation) is set the same way but is not a chat provider. **Custom / self-hosted OpenAI-compatible** endpoints (LM Studio, Ollama, vLLM, GLM, DeepSeek, and more) are added under **Custom Providers** on the same pane.

Sending a prompt with no provider connected instead starts a short in-chat setup conversation. Full setup detail (all paths, custom endpoints, demo mode, key-rejected troubleshooting) lives in [ai-setup.md](./ai-setup.md).

---

## Context and Attachments (Explicit Consent)

Outbound chat traffic is **explicit-consent only**. Brilliant does not auto-attach screenshots of the screen, system info, app version, recent files, telemetry, or other ambient context. The default is to send nothing extra beyond your prompt.

Context that can travel with a message:

1. **Canvas context (a text outline):** the message carries a *text* snapshot of the canvas: a depth-limited Blueprint of the element structure (a large canvas collapses to a short summary table, not the full tree), the design-system token catalog, the component catalog, and the element count. For API-key providers (Anthropic, OpenAI, Google, OpenRouter) this rides with *every* message, refreshed each send; for the local Claude CLI and Codex it goes with the first message only (later messages add just a one-line note when the user switches canvases). This is text, not an image; no screenshot of the canvas or screen is captured for this context. Your current *selection* is not included here; send it explicitly with an `@` element attachment or via the `get_selection` tool. To send a prompt with no canvas context, start the chat in an empty workspace.
2. **Per-message attachments (opt-in):** each shows as a chip above the input with an X to remove before sending. Nothing attaches unless you add it. An **element** attachment (via `@` or paste) sends that element's Blueprint plus a PNG render of just that element; **image / file** attachments send what you added.
3. **Automatic self-review screenshot (after edits):** once the AI applies a block of changes, Brilliant renders a screenshot of *those changed elements* and sends it back to the model so it can check its own work (spacing, contrast, alignment, clipping). It is a render of the design content only, never the screen or other apps. Text-only models never receive it, and it is suppressed for the rest of a session once an endpoint rejects image input.

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
- **Export:** render selected elements to PNG, JPEG, WebP, SVG, PDF, or HTML/React markup.
- **Read and write files / run shell commands / search the web:** when working in a real project workspace (these are most capable in the Claude CLI path). In the web app (browser) there are no shell or file tools and no external MCP servers; `web_fetch` and every canvas tool work normally, and exports return images inline.
- **Generate images and vectors:** see the sections below.
- **Spawn sub-agents:** for large tasks, the main session can launch parallel helper agents that each return a summary, shown as collapsible cards.

On a **view-only project** (a cloud project opened without edit access, or one being viewed while signed out), the canvas-changing tools are refused with a message to sign in; reading, searching, inspecting the selection, and exporting keep working. Signing in with an account that can edit, or downloading a copy to work on locally, makes the tools available again.

The full canvas-authoring grammar (Blueprint DSL) and the command/tool catalog are documented for the AI in the blueprint and mcp-tools knowledge files; users do not author that syntax by hand.

---

## AI Image Generation

The AI generates raster images with Google's Gemini image model ("Nano Banana") and applies them as image fills on target elements. Generated images are saved to the project's `Assets/` folder.

- **Requires** a connected Google provider (API key or OAuth), regardless of which chat model is active.
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
| `/usage` | Show account usage |
| `/cost` | Show cost and usage for this session (Claude CLI and Anthropic only) |
| `/compact` | Compact (summarize) conversation history |
| `/feedback` | File feedback or report an issue |
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
| Focus chat session 1-9 | Cmd+1 - Cmd+9 |
| Focus chat session 10 | Cmd+0 |
| Focus next chat session | Cmd+Shift+] |
| Focus previous chat session | Cmd+Shift+[ |
| New chat (when AI input focused) | Cmd+N |
| Close focused chat session | Cmd+W |
| Toggle chat explorer | Cmd+Shift+A |
| Chat search | Cmd+Shift+I |
| Escape AI chat | Esc |
| Toggle AI chat panel | (no default shortcut; assignable in the shortcuts view) |

Focusing a session by number opens the chat panel if it is hidden. Number assignments appear as badges in the chat header and explorer. To customize any of these, see [shortcuts.md](./shortcuts.md).
