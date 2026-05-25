---
name: "knowledge-ai"
description: "AI features in Brilliant: multi-provider chat, Claude Code integration, BYOK setup, attachments, MCP tools, image and vector generation, vectorization, and slash commands."
---

# AI Features

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Brilliant has a single integrated AI system: a **multi-provider chat panel** that drives Claude Code (or another model) to design directly on the canvas. The bottom toolbar input is the entry point: type a prompt, press Enter, and a chat session is created.

Brilliant chat is **bring-your-own-key (BYOK) only**. Every chat call uses the user's own API key (Anthropic, OpenAI, Google, OpenRouter) or a local Claude CLI install. Quiver is a separate BYOK provider used only for vector generation and vectorization. The user pays their own provider directly.

---

## AI Input Bar (Bottom Toolbar)

### Accessing AI Input

| Action | Shortcut |
|--------|----------|
| Focus AI input in bottom toolbar | / (slash) |

The input lives in the bottom toolbar, to the right of the drawing tool buttons. Click the field, press **/**, or use the **Focus AI Chat** command from the command palette. A chevron toggle next to the field collapses it to just the connection indicator (**Collapse AI Input** / **Expand AI Input** command).

### How It Works

1. Optionally select one or more elements on the canvas, or attach context manually (see Attachments below).
2. Focus the AI input.
3. Type a prompt.
4. Press **Enter** to send.

Pressing Enter creates a new chat session (topic auto-derived from the first 60 characters of the prompt) and sends the message to the currently selected model. The chat panel opens above the bottom toolbar so the response can stream in.

### Hint Cycle

The input field cycles through a shuffled pool of starter prompts as placeholder text (currently 17 entries in `AIInputFieldConfig.starterPrompts`: short product-design ideas like "Meditation app onboarding", "Stripe-style pricing", "Kanban board"). While a session is processing, the inline hint area rotates through keyboard tips, slash command summaries, and modifier hints (`@` to mention elements, `#` for hashtag style hints, `"this"` / `"these"` to reference the current selection).

### Submission Behavior

Every submission creates a fresh Claude Code chat session. The input clears on success and shows a brief success or failure indicator. While processing, the input shows a spinner and a stop button; clicking stop cancels the active session.

### Prompt History

- **Up / Down arrow** keys navigate previously sent prompts (newest first)
- **Ctrl+P** / **Ctrl+N** also navigate history (vim-style)
- **Ctrl+R** activates reverse search; type to filter history; press **Ctrl+R** again to cycle to the next match
- History is deduplicated and persisted to disk in `~/.config/brilliant/`

### Hashtag Autocomplete

Typing `#` in the input opens a dropdown of style/context modifiers (e.g. `#dark`, `#mobile`, `#minimal`). Selecting one inserts the hashtag into the prompt.

### Slash Command Dropdown

Typing `/` in the input opens a dropdown showing slash commands (see "Slash Commands" below) and recent chat sessions for quick resume.

### Element Mentions

Typing `@` inside the AI chat panel input (the multi-line follow-up area, not the bottom toolbar bar) opens an autocomplete dropdown listing canvas elements by name. Selecting one attaches that element as context.

---

## Multi-Provider Chat Panel

The chat panel is a floating panel that opens above the bottom toolbar. It contains an optional **chat explorer** (session list sidebar) and the active chat session.

### Providers

Five chat providers (`ProviderId.claudeCli`, `anthropicHttp`, `openaiHttp`, `googleHttp`, `openRouterHttp`) defined statically in `lib/providers/provider_registry.dart` (no remote model sync). Quiver is a sixth credential slot (`hasQuiverCredentials`) used for vector generation and vectorization only; it is not a chat provider.

| Provider | Backend | Models |
|----------|---------|--------|
| **Claude CLI** | Local `claude` binary subprocess | Discovered from the CLI at launch, intersected with an allowlist (`_cliModelSpec`): `claude-opus-4-7` ("Best"), `claude-opus-4-6` ("Excellent"), `claude-sonnet-4-6` ("Excellent"), `claude-sonnet-4-5` ("Excellent"), `claude-haiku-4-5` ("Good + Fast"). Opus (or any `[1m]`-tagged ID) gets 1M context; others 200K |
| **Anthropic HTTP** | `api.anthropic.com/v1/messages` | `claude-opus-4-7` ("Best"), `claude-opus-4-6` ("Excellent"), `claude-sonnet-4-6` ("Excellent"), `claude-sonnet-4-5-20250929` ("Excellent"), `claude-haiku-4-5-20251001` ("Good + Fast"). All 200K context |
| **OpenAI HTTP** | `api.openai.com` Chat Completions or Responses API | `gpt-5.5` ("Excellent", Chat Completions), `gpt-5.5-pro` ("Excellent", Responses API), `gpt-5.4` ("Excellent + Fast", Chat Completions), `gpt-5.4-pro` ("Excellent", Responses API), `gpt-5.3-codex` ("Excellent", Responses API). Models flagged `usesResponsesApi: true` (the two Pro models plus Codex) route through `OpenAIResponsesProvider` (`/v1/responses`); the rest use `/v1/chat/completions`. Codex has 400K context, others 1.05M |
| **Google HTTP** | `generativelanguage.googleapis.com/v1beta` | `gemini-3.1-pro-preview` ("Excellent"), `gemini-3-pro-preview` ("Good"), `gemini-3-flash-preview` ("Good + Fast"). All 1M context (1,048,576 tokens) |
| **OpenRouter HTTP** | `openrouter.ai/api/v1/chat/completions` | Curated 14-model set: `anthropic/claude-opus-4.7` ("Best"), `anthropic/claude-opus-4.6` ("Excellent"), `anthropic/claude-sonnet-4.6` ("Excellent"), `anthropic/claude-sonnet-4.5` ("Excellent"), `anthropic/claude-haiku-4.5` ("Good + Fast"), `openai/gpt-5.5` ("Excellent"), `openai/gpt-5.4` ("Excellent + Fast"), `openai/gpt-5.4-pro` ("Excellent"), `openai/gpt-5.3-codex` ("Excellent"), `google/gemini-3.1-pro-preview` ("Excellent"), `google/gemini-3-pro-preview` ("Good"), `google/gemini-3-flash-preview` ("Good + Fast"), `deepseek/deepseek-v3.2` (text-only, no vision, 163K, "Good"), `moonshotai/kimi-k2.5` (262K, "Good"). OpenRouter does NOT carry `openai/gpt-5.5-pro` |

**Default model per provider** (`ProviderRegistry.defaultModels`): Anthropic `claude-sonnet-4-6`; OpenAI `gpt-5.5`; Google `gemini-3.1-pro-preview`; OpenRouter `anthropic/claude-sonnet-4.6`. CLI has no default (populated at runtime).

The model selector only shows models whose provider currently has valid credentials. Subtitles ("Best", "Excellent", "Good + Fast", etc.) are the exact strings hardcoded on each `ModelInfo`.

### BYOK: Setting Up API Keys

Keys are stored locally in the macOS Keychain (service `com.brilliant.credentials`, accounts `apikey.{provider}` and `oauth.{provider}`, written with `-A` so any signed Brilliant build can read them without re-prompting) or, on Windows, in `~/.config/brilliant/credentials.json`. Keys are sent only to the provider's own API endpoints; no chat traffic flows through Brilliant servers.

1. Open the chat panel (click the connection indicator in the bottom toolbar, or run **Toggle AI Chat**)
2. If no providers are connected, an onboarding view appears with buttons for each provider. Otherwise, hover the **connection indicator** in the bottom toolbar to see a popup of all providers (green dot = connected, dim = not connected)
3. Click an unconnected provider row. The chat input converts into an API key entry field with "Esc to close" and "Enter to set key" hints
4. Paste the key and press **Enter**. Brilliant validates the key against the provider's `models` endpoint and stores it on success
5. To remove a key: hover the connection indicator and click a connected provider row

**Environment variable fallback** (read on-demand when storage has no key for that provider): `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `GOOGLE_API_KEY`, `OPENROUTER_API_KEY`. Quiver currently only honors a Keychain/credentials.json entry (the error message references `QUIVER_API_KEY` but no env fallback is wired up in the credential store).

**Google OAuth:** the Google provider also accepts OAuth tokens (localhost redirect flow) instead of an API key.

**Claude CLI** has no key entry: install the `claude` CLI locally and Brilliant detects it on launch. `claude-haiku-4-5` requires the CLI to expose it; older CLI builds will simply show fewer models.

### Starting a Session

A new chat session is created in three ways:

1. Submit a prompt from the bottom toolbar input
2. Click the **+** button in the chat panel header
3. Press **Cmd+N** while the AI input is focused

Each session has its own provider, model, thinking level, conversation history, and per-session context tracking. Sessions persist to disk under `~/.config/brilliant/chat_sessions/`.

### Session Tabs

Each active session shows as a small tab to the right of the AI input field in the bottom toolbar:

- **Minimized** (default width 150px): topic label, processing spinner, context-usage percentage. Click to expand. Double-click to rename.
- **Expanded** (default width 400px, resizable 160-640px): full chat panel above the toolbar with messages, attachments, and follow-up input.

Sessions can be reordered by dragging tabs. Multiple sessions run concurrently. The bottom toolbar scrolls horizontally if tabs exceed available width.

### Switching Models

The input bar at the bottom of the chat panel contains, left to right: attach button, **model selector**, **thinking level selector**, **context usage indicator**, keyboard hint, undo/redo buttons, and send/stop button.

- Click the model selector to switch the model for the current session. The new model becomes the default for subsequent sessions
- Type `/model` in the chat input for an interactive provider then model picker
- Subtitles like "Best", "Excellent", "Good + Fast" hint at relative quality and speed

### Thinking / Reasoning Levels

Configured per-model in `ProviderRegistry`:

| Model family | Levels (`thinkingLevels`) |
|--------------|---------------------------|
| Claude (CLI, Anthropic HTTP, OpenRouter Anthropic) | `off`, `low`, `medium`, `high` |
| OpenAI GPT-5.5 / 5.5 Pro / 5.4 / 5.4 Pro | `low`, `medium`, `high` (no off) |
| OpenAI GPT-5.3 Codex | `low`, `medium`, `high`, `xhigh` |
| Google Gemini 3.x | `low`, `medium`, `high` (no off) |
| DeepSeek V3.2, Kimi K2.5 | none (empty `thinkingLevels`, no thinking selector shown) |

Only Claude can be turned off. Gemini and OpenAI reasoning models always reason at the chosen level. `xhigh` is exclusive to GPT-5.3 Codex.

---

## Context and Attachments (Explicit Consent)

Outbound chat traffic is **explicit-consent only**. Brilliant does not auto-attach screenshots of the rest of the screen, system info, app version, recent files, telemetry, or other ambient context. Each item is opt-in per message; the default is none.

The two layers of context that can flow with a message:

1. **Canvas context (initial message only):** when the first user message of a session is sent, Brilliant builds an MCP context payload containing a Blueprint snapshot of the canvas and a canvas overview PNG screenshot. This is needed for the model to "see" the work-in-progress. Subsequent messages send a lighter follow-up context with only changed state. To send a prompt without canvas context, start a chat in an empty workspace or remove all elements first
2. **Per-message attachments (opt-in):** elements (`@mention`), images (paste/drag/paperclip), files. Nothing attaches unless the user explicitly attaches it. Each attachment shows as a chip with an X to remove before sending

When suggesting outbound workflows (sending logs, sharing repro steps, filing feedback, etc.), the AI should: never auto-attach screenshots/version/file contents; ask per-item; default to "none".

### Adding Attachments

| Type | How |
|------|-----|
| Element | Type **@** in the chat panel input and pick a canvas element by name. The element's blueprint and a PNG render are attached |
| Image | Paste from clipboard (Cmd+V), drag-and-drop a file, or click the paperclip icon |
| File | Drag-and-drop into the input, or click the paperclip icon |

Attachments appear as chips above the input. Remove a chip with its X button before sending.

---

## Tool Execution (What the AI Can Call)

Once a chat is running, Claude Code (or the chosen HTTP model) can call tools to read files, edit them, run shell commands, search the web, and modify the canvas.

### Built-in tools

Available to every HTTP provider via `ToolExecutor` (`lib/providers/tool_executor.dart`):

| Tool | Purpose |
|------|---------|
| `bash` | Run a shell command (default 120s timeout, configurable) |
| `read` | Read a file with offset/limit |
| `write` | Write a file (creates parents) |
| `edit` | Replace `old_string` with `new_string` (uniqueness-checked unless `replace_all`) |
| `glob` | File-name glob via `fd` (falls back to `find`), respects `.gitignore` |
| `grep` | Content search via `rg` |
| `web_fetch` | HTTP GET, HTML to markdown, 15-min raw-fetch cache (re-summarized per call). Summarization model picked per provider family (`claude-haiku-4-5-20251001` for Anthropic, `gpt-4.1-nano` for OpenAI, `gemini-2.5-flash-lite` for Google, `anthropic/claude-haiku-4.5` for OpenRouter; the Claude CLI provider returns raw markdown without a separate summarization pass) |
| `AskUserQuestion` | Listed in `builtInToolDefinitions` but intercepted by the orchestrator: pauses the run and presents the user 1-4 questions, each with 2-4 predefined options (and an optional `multiSelect` flag). Free-text input is not part of the schema; resumes when the user picks |

**Provider-native web search** (added when `enableWebSearch: true`):

- Anthropic: `web_search_20250305` tool (`max_uses: 5`)
- OpenAI Responses API: `web_search_preview` tool
- Google Gemini: `google_search` tool, but ONLY when there are zero function-calling tools (Gemini API rejects the combination, so when canvas tools are present Google web search is silently skipped)
- OpenAI Chat Completions and OpenRouter: not supported (ignored)

Main sessions ship with `enableWebSearch: true`; sub-agents ship without it. The Claude CLI provider has its own internal tool implementations and ignores the list above.

### MCP Brilliant tools (canvas)

Two surfaces expose canvas tools:

1. **External MCP server** (when Claude Code or another MCP client connects to Brilliant): the full `mcp__brilliant__*` set, registered in `lib/managers/mcp_tools/`. Tools exposed: `init` (CLI-only bootstrap; required first call), `create_html`, `create_modify_elements`, `lookup`, `get_selection`, `get_knowledge`, `execute_commands`, `export`, `generate_image`, `generate_svg`, `vectorize_image`.
2. **In-app HTTP providers** (`NativeTools.getToolDefinitions()` in `lib/providers/native_tools.dart`): the integrated Anthropic / OpenAI / Google / OpenRouter sessions always get `get_knowledge`, `get_selection`, `export`, `execute_commands`, `lookup`. They additionally get: `generate_image`, `generate_svg`, and `vectorize_image` when a `CredentialStore` is wired; `plan_agents` and `spawn_agent` when `spawnHttpAgent` is wired (sub-agent capable sessions); `load_mcp_server` when `loadMcpServer` is wired. **`create_html` and `create_modify_elements` are NOT in `getToolDefinitions()` for HTTP providers**; in-app HTTP sessions emit elements via streaming `<objects canvasId="...">` blocks (see "Streaming Element Creation" below). A `create_html` handler is still wired in `handleCanvasTool()` for backward compatibility, and both creation tools are exposed to external MCP clients.

| Tool | Purpose |
|------|---------|
| `init` | (External MCP only.) Bootstrap session context: returns `canvasId`, `repoRoot`, `canvasFile`, element counts, MCP mode header, shared CLAUDE.md reference. CLI clients must call this first |
| `get_knowledge` | Load `.claude-prod/knowledge/*.md` files by key (e.g. `blueprint/core`, `design/colors`, `effects/glass`). Required before using the Blueprint DSL |
| `get_selection` | Returns the IDs and full blueprint of the elements selected on the given `canvasId` |
| `lookup` | Find or read elements. `scope` (canvas paths, 16-hex element IDs, `#refs`) constrains where to look; filters (`query`, `textContent`, `type`, `fillColor`, `componentName`) narrow within scope. `type` accepts `vector`, `circle`, `rectangle`, `text`, `parent` (`line` is also accepted by the schema for compatibility but maps to vector). `format` is `"summary"` (default) or `"blueprint"` with optional `depth`. `limit` defaults to 50 |
| `create_html` | (External MCP only as a tool definition; in-app HTTP sessions reach the same converter via streamed `<objects>` tags.) Convert HTML + inline CSS into auto layout frames, text, and shapes. No `get_knowledge` required |
| `create_modify_elements` | (External MCP only as a tool definition; in-app HTTP sessions stream blueprint via `<objects>` instead.) Create or modify elements via the Blueprint DSL. Requires `get_knowledge(["blueprint/core", ...])` first |
| `execute_commands` | Dispatch one or more Brilliant commands by ID against a single `canvasId`. Each entry is `{commandId, elementIds?, params?}`. Runs sequentially, stops on first error. See "AI-Invocable Commands" below |
| `export` | Render elements to PNG/JPEG/WebP/SVG/PDF. Required: `canvasId`, `ids`. Optional: `format` (default `png`), `scale` (default 2.0, raster only, mutually exclusive with `width`/`height`), `width`, `height`, `fitMode` (`fit`/`fill`/`stretch`), `jpegQuality` (default 90), `webpQuality` (default 90), `webpLossless` (default false), `background` (`clear` default, or `window`), `outputPath` (writes to file instead of returning bytes inline). For UI mockups in WebP, set `webpLossless: true`; the lossy default leaves visible gray banding on rounded corners and gradients |
| `generate_image` | Generate a raster image and apply it as a fill on `targetElementId`. Single or batch (`targets` array). Optional `referenceElementIds` (up to 14 references, used for "edit this image" workflows). `imageSize`: `"512px"`, `"1K"` (default), `"2K"`, `"4K"`. Use for photos, realistic scenes, complex textures. Requires Google API key or Google OAuth |
| `generate_svg` | Generate an editable vector graphic (SVG) and place it on the canvas as native editable shapes. Single, parallel variations (`n: 1–4`), or distinct prompts in batch (`targets`). Optional `referenceElementIds` (up to 4) export to PNG and steer style. Use for icons, logos, illustrations, diagrams: anything that should stay crisp and remain editable. Requires Quiver API key |
| `vectorize_image` | Convert a raster element on the canvas into editable vector paths. Required: `canvasId`, `sourceElementId`. Optional: `autoCrop` (default true). The original raster is left intact; the vector elements are placed on the canvas. Requires Quiver API key |
| `plan_agents` / `spawn_agent` | (HTTP providers with sub-agent support.) Announce a plan, then launch sub-agents. Each sub-agent runs in its own `ChatOrchestrator` with the parent's API key; 5-minute timeout |
| `load_mcp_server` | (HTTP providers when configured.) Load tools from a registered external MCP server by name on the next turn |

The Brilliant MCP server is auto-loaded by the user's local Claude Code instance when the workspace is opened from Brilliant (no manual setup). When a stale `canvasId` is passed (e.g., the canvas was renamed mid-session), `handleCanvasTool()` resolves it via `elementManager.resolveCanvasId()` before dispatch.

### AI-Invocable Commands

`execute_commands` lets the AI dispatch any command that implements the `AIInvocableCommand` interface. This includes selection ops (align, distribute, flip), property setters (corner radius, opacity, blend mode), tool changes, frame and component operations, and more: over 100 commands in total. The AI provides element IDs and parameters; the command runs through the same code path as a keyboard or button press, with full undo support.

### Sub-Agents

For large tasks, the main session can spawn parallel sub-agents via the `plan_agents` then `spawn_agent` tools. Each sub-agent runs in its own ChatOrchestrator (same provider, same API key) with a 5-minute timeout, returns a summary, and renders in the parent session as a collapsible card.

---

## AI Image Generation

Image generation uses Google's "Nano Banana" image model (`gemini-3.1-flash-image-preview` via the Gemini API). Generated images are saved to the project's `Assets/` folder and applied as image fills on target elements.

### Requirements

A Google API key or Google OAuth credentials. Image generation is only available when the Google provider is connected, regardless of which chat model is active.

## AI Vector Graphics Generation

Vector generation uses Quiver's Arrow model (`arrow-1.1`). Generated SVGs are placed on the canvas as native editable vector elements via `importSvgElements`, so users can immediately move, resize, recolor, and reshape them like any hand-drawn vector. Vectorization (`vectorize_image`) takes a raster element on the canvas and returns an editable SVG of the same content.

### Requirements

A Quiver API key. SVG generation and vectorization are only available when the Quiver provider is connected, regardless of which chat model is active. See `svg/prompts` and `svg/integration` knowledge files for prompt patterns and decision rules.

### Tool Selection Rules

- Photo, realistic image, complex texture → `generate_image` (Google)
- Icon, logo, illustration, diagram, anything that should stay crisp at any zoom → `generate_svg` (Quiver)
- User has a raster they want to edit as vectors → `vectorize_image` (Quiver)

### How It Works

1. The AI calls the `generate_image` tool with a prompt and a `targetElementId`
2. Brilliant generates the image, saves the PNG to `Assets/`, and applies it as an image fill on the target via `MCPToolsGenerate.fillElementWithImage()`
3. The asset path can be reused in blueprint with `img(assetPath)`

### Image Sizes

The `imageSize` parameter accepts:

| Value | Notes |
|-------|-------|
| `512px` | Fast, useful for tiny placeholders |
| `1K` | Default. Good speed / quality tradeoff |
| `2K` | Hero images |
| `4K` | Highest detail, slowest |

### Reference Images

Pass element IDs in `referenceElementIds` to use existing canvas elements as visual references for style or structure. Up to 14 references per call. This is how you "edit" a generated image: pass the original as a reference and prompt the change.

### Parallel Generation

For multiple images at once, the AI emits several `generate_image` calls in a single turn (parallel tool execution) or uses the batch `targets` parameter on a single call. Both run concurrently; the batch form keeps things in one tool call.

### Prompt Tips (general guidance the AI follows)

- Descriptive paragraphs work better than keyword lists
- Be specific about subject, lighting, composition, style
- Use photographic terminology (focal length, depth of field) where it helps
- For text in images, state exactly what the text should read
- When editing with a reference image, change one thing at a time

### Aspect Ratios

The Gemini image API accepts arbitrary ratios. Common ones are 1:1, 3:4, 4:3, 9:16, 16:9. Brilliant derives the target ratio from the target element's bounds.

---

## Slash Commands

Type these in the chat input:

| Command | Description |
|---------|-------------|
| `/stop` | Stop the current response |
| `/continue` | Nudge the model to continue |
| `/context` | Show context window usage |
| `/usage` | Show account usage |
| `/compact` | Compact conversation history (LLM-driven summarization) |
| `/feedback` | File feedback or report an issue |
| `/archive` | Archive the current chat |
| `/new` | Start a new chat |
| `/clear` | Start a new chat (alias for /new) |
| `/model` | Change the AI model (interactive provider then model picker) |
| `/rename` | Rename the current chat (e.g. `/rename My Chat`) |
| `/copy` | Copy the last assistant message |
| `/export-replay` | Export the session as a 1:1 MP4 replay |
| `/help` | Show available commands |
| `/login` | Sign in to Claude (Claude CLI only) |

---

## Stopping and Cancellation

- Click the stop button in the chat input bar, or type `/stop`
- The active HTTP request aborts immediately
- If the model is mid tool-use loop, no further tools are dispatched
- Sub-agents inherit cancellation from the parent session

---

## Chat Session Shortcuts

| Action | Shortcut |
|--------|----------|
| Focus AI input in bottom toolbar | / (slash) |
| Focus chat session 1 to 9 | Cmd+1 through Cmd+9 |
| Focus chat session 10 | Cmd+0 |
| Focus next chat session | Cmd+Shift+] |
| Focus previous chat session | Cmd+Shift+[ |
| Close focused chat session | Cmd+W (close_ai_chat; gated by AI input focus / chat open WhenClause) |
| Toggle chat explorer | Cmd+Shift+A |
| New chat | Cmd+N (when AI input is focused) |
| Chat search | Cmd+Shift+I (toggle_chat_search) |
| Escape AI chat | Esc (EscapeAIChatCommand) |
| Toggle AI chat panel | Toggle AI Chat command (no default keybinding; assignable in shortcuts view) |

These shortcuts focus the chat session assigned to that number, opening the chat panel if it is hidden. Session number assignments show as keybinding badges in the chat panel header and chat explorer sidebar.

---

## Chat Panel Controls

- **Open / close:** click the connection indicator in the bottom toolbar, or run **Toggle AI Chat**
- **Rename:** double-click the topic name in the chat header, or use `/rename`
- **Resize width:** drag panel edges or the divider between sessions (clamped 160-640 px per session, default 400 px; minimized tab is 150 px)
- **Resize height:** drag the top edge of the panel
- **Queue follow-up:** sending a message while the model is processing queues it; it sends automatically when the current response finishes
- **Edit and resend:** click the edit icon on a user message to revise and resend
- **Copy chat:** the header has a copy button that exports the full conversation as markdown with YAML frontmatter (model, date, project, canvas, tokens, turns)
- **Chat explorer:** toggle with **Cmd+Shift+A** to browse, search, and manage all sessions; drag the divider to resize or collapse it

---

## Streaming Element Creation

In-app HTTP providers (Anthropic / OpenAI / Google / OpenRouter) do not have `create_html` or `create_modify_elements` tools. They emit elements via streamed `<objects canvasId="...">` blocks in the assistant message: each object line is parsed and applied to the canvas as it streams. The chat shows a per-batch preview chip with element count, a scale indicator, and any blueprint compiler warnings or errors. External MCP clients (Claude Code, etc.) reach the same pipeline through the `create_html` and `create_modify_elements` MCP tools.
