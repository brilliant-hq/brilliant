---
name: "knowledge-ai"
description: "Brilliant's integrated AI: the multi-provider chat that designs on the canvas, BYOK key setup, the chat panel and session tabs, model and thinking selection, attachments and consent, AI image and vector generation, and chat slash commands and shortcuts."
---

# AI Features

Brilliant has one integrated AI system: a multi-provider chat that drives a model (Claude, GPT, Gemini, or a local Claude CLI) to design directly on the canvas. The entry point is the AI input in the bottom toolbar. Type a prompt, press Enter, and a chat session starts. Anything the AI produces lands on the canvas and stays fully editable by hand.

Brilliant chat is **bring-your-own-key (BYOK) only**. Every call uses the user's own provider API key (Anthropic, OpenAI, Google, OpenRouter) or a local `claude` CLI install. Chat traffic goes straight to the chosen provider; nothing routes through Brilliant servers. A separate Quiver key powers AI vector generation and image vectorization (not chat). The user pays their provider directly.

If no provider is connected, the chat opens in a limited "replay" demo mode instead of a live session. Connecting a key unlocks real chat.

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
- **Edit and resend:** click the edit icon on one of your messages to revise and resend it.
- **Copy chat:** the header copy button exports the whole conversation as Markdown (with metadata: model, date, project, canvas, tokens, turns).
- **Chat explorer:** toggle with **Cmd+Shift+A** to browse, search, and manage all sessions; drag its divider to resize or collapse it.

---

## Providers and Models

Five chat providers: **Claude CLI** (local `claude` binary), **Anthropic**, **OpenAI**, **Google (Gemini)**, and **OpenRouter**. The model selector only lists models whose provider currently has a valid key (or, for Claude CLI, a detected install). Each model shows a short quality/speed subtitle (for example "Best", "Excellent", "Good + Fast").

- The exact model lineup changes between releases. Read the live list in the model selector rather than assuming specific model names.
- Context-window size varies per model. The session's context-usage indicator reflects the real per-model window.
- Some OpenRouter-only models are text-only (no image/vision support); attaching an image to those will not work.

### Switching models

- Click the **model selector** in the chat input bar to change the model for the current session. The chosen model becomes the default for new sessions.
- Type `/model` for an interactive provider-then-model picker.

### Thinking / reasoning levels

A thinking-level selector sits next to the model selector when the model supports it.

- **Claude** models support **off, low, medium, high** (only Claude can be turned off).
- **OpenAI** and **Gemini** reasoning models always reason; they offer **low, medium, high** (no off). Some OpenAI reasoning models add an **xhigh** level.
- Text-only models that do not reason show no thinking selector.

---

## BYOK: Setting Up API Keys

Keys are stored locally in the OS credential store (macOS Keychain, Windows Credential Manager) and sent only to the provider's own API endpoint. Brilliant also reads provider environment variables as a fallback (`ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `GOOGLE_API_KEY`, `OPENROUTER_API_KEY`).

To connect a provider:

1. Open the chat panel (click the connection indicator in the bottom toolbar, or run **Toggle AI Chat**). With no providers connected, an onboarding view offers a button per provider.
2. Hover the **connection indicator** to see all providers (green dot = connected, dim = not).
3. Click an unconnected provider. The chat input turns into a key-entry field ("Enter to set key", "Esc to close").
4. Paste the key and press **Enter**. Brilliant validates it against the provider and stores it on success.
5. To remove a key, hover the connection indicator and click a connected provider row.

Notes:

- **Google** also accepts OAuth sign-in (localhost redirect) instead of a raw key.
- **Claude CLI** has no key field: install the `claude` CLI and Brilliant detects it on launch. Sign in to the CLI from chat with `/login`.
- **Quiver** (for AI vector generation / vectorization) is a separate key set the same way; it is not a chat provider.
- A **Configure provider…** shortcut also lives in the AI Providers section of Settings (Cmd+,).

---

## Context and Attachments (Explicit Consent)

Outbound chat traffic is **explicit-consent only**. Brilliant does not auto-attach screenshots of the screen, system info, app version, recent files, telemetry, or other ambient context. The default is to send nothing extra beyond your prompt.

Two layers of context can travel with a message:

1. **Canvas context (first message of a session):** when the first message is sent, Brilliant includes a snapshot of the canvas and an overview screenshot so the model can see the work in progress. Later messages send only changed state. To send a prompt with no canvas context, start the chat in an empty workspace.
2. **Per-message attachments (opt-in):** each shows as a chip above the input with an X to remove before sending. Nothing attaches unless you add it.

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
- **Read and write files / run shell commands / search the web:** when working in a real project workspace (these are most capable in the Claude CLI path).
- **Generate images and vectors:** see the sections below.
- **Spawn sub-agents:** for large tasks, the main session can launch parallel helper agents that each return a summary, shown as collapsible cards.

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
