---
name: "knowledge-ai"
description: "AI features in Brilliant: multi-provider chat, Claude Code integration, BYOK setup, attachments, MCP tools, image generation, and slash commands."
---

# AI Features

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Brilliant has a single integrated AI system: a **multi-provider chat panel** that drives Claude Code (or another model) to design directly on the canvas. The bottom toolbar input is the entry point: type a prompt, press Enter, and a chat session is created. Brilliant is **bring-your-own-key (BYOK) only**: every chat call uses the user's own API key (Anthropic, OpenAI, Google, OpenRouter) or a local Claude CLI install. There is no hosted Brilliant inference at the moment.

> **Note:** an older "natural language command parser" (the `NaturalLanguageCommandLegacy` class, served by a local Qwen endpoint) is still in the source tree but is not wired into the live UI. The active path always routes to Claude Code via a chat session. Phrases like "width 300" or "rotate 45" are sent to the chat model as natural language, not parsed by a deterministic command bar.

---

## AI Input Bar (Bottom Toolbar)

### Accessing AI Input

| Action | Shortcut |
|--------|----------|
| Focus AI input in bottom toolbar | / (slash) |

The input lives at the right end of the bottom toolbar. Click the field, press **/**, or use the **Focus AI Chat** command from the command palette.

### How It Works

1. Optionally select one or more elements on the canvas, or attach context manually (see Attachments below).
2. Focus the AI input.
3. Type a prompt.
4. Press **Enter** to send.

Pressing Enter creates a new chat session (topic auto-derived from the first 60 characters of the prompt) and sends the message to the currently selected model. The chat panel opens above the bottom toolbar so the response can stream in.

### Hint Cycle

The input field cycles through ~60 example prompts as placeholder text (rotating every 5 seconds, shuffled per session). Categories include showcase designs, common UI patterns, canvas-aware prompts that reference the current selection ("convert this to dark mode"), creative prompts, bulk-generation, sub-agent prompts, and prompts with `#hashtag` modifiers.

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

| Provider | Backend | Models |
|----------|---------|--------|
| **Claude CLI** | Local `claude` binary subprocess | Models discovered from the installed Claude CLI (allowlisted: Opus 4.7, Opus 4.6, Sonnet 4.6, Sonnet 4.5, Haiku 4.5) |
| **Anthropic HTTP** | Direct Anthropic API | Opus 4.7, Opus 4.6, Sonnet 4.6, Sonnet 4.5, Haiku 4.5 |
| **OpenAI HTTP** | Direct OpenAI API | GPT-5.5, GPT-5.5 Pro, GPT-5.4, GPT-5.4 Pro, GPT-5.3 Codex |
| **Google HTTP** | Direct Gemini API | Gemini 3.1 Pro, Gemini 3 Pro, Gemini 3 Flash |
| **OpenRouter HTTP** | OpenRouter gateway | Curated set spanning Anthropic, OpenAI, Google, DeepSeek V3.2, Moonshot Kimi K2.5 |

> Model lists are static in the build and may change between releases. The model selector only shows models whose provider has valid credentials.

### BYOK: Setting Up API Keys

Brilliant chat is BYOK only. Keys are stored locally in the macOS Keychain (service `com.brilliant.credentials`) and are never sent to Brilliant servers.

1. Open the chat panel (click the connection indicator in the bottom toolbar, or run **Toggle AI Chat**)
2. If no providers are connected, an onboarding view appears with buttons for each provider. Otherwise, hover the **connection indicator** in the bottom toolbar to see a popup of all providers (green dot = connected, dim = not connected)
3. Click an unconnected provider row. The chat input converts into an API key entry field with "Esc to close" and "Enter to set key" hints
4. Paste the key and press **Enter**. Brilliant validates the key against the provider's `models` endpoint and stores it on success
5. To remove a key: hover the connection indicator and click a connected provider row

**Environment variable fallback** (read at startup if Keychain is empty): `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `GOOGLE_API_KEY`, `OPENROUTER_API_KEY`.

**Google OAuth:** the Google provider also accepts OAuth tokens (localhost redirect flow) instead of an API key.

**Claude CLI** has no key entry: install the `claude` CLI locally and Brilliant detects it on launch.

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

Some models support configurable reasoning depth:

| Level | Notes |
|-------|-------|
| Off | No extended thinking. Claude only |
| Low | Minimal reasoning |
| Medium | Moderate reasoning |
| High | Maximum reasoning |
| Xhigh | Extra-high reasoning. GPT-5.3 Codex only |

Claude models support all four base levels including Off. Gemini and OpenAI reasoning models always reason and do not offer Off. GPT-5.3 Codex adds Xhigh.

---

## Context and Attachments (Explicit Consent)

Brilliant **never auto-attaches** screenshots, file contents, app version, or other ambient context to chat messages. Every piece of context is opt-in per message; the default is none.

The two layers of context that can flow with a message:

1. **Canvas context (initial message only):** when the first user message of a session is sent, Brilliant builds an MCP context payload containing the canvas snapshot in blueprint form and a canvas overview screenshot (PNG). This is necessary for the model to "see" the work-in-progress. Subsequent messages send a lighter follow-up context with only changed state. To send a prompt without canvas context, start a chat in an empty workspace or remove all elements first.
2. **Per-message attachments (opt-in):** elements, images, files. Nothing is attached unless the user explicitly attaches it.

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

Available to every HTTP provider:

| Tool | Purpose |
|------|---------|
| `bash` | Run a shell command (default 120s timeout, configurable) |
| `read` | Read a file with offset/limit |
| `write` | Write a file (creates parents) |
| `edit` | Replace `old_string` with `new_string` (uniqueness-checked unless `replace_all`) |
| `glob` | File-name glob via `fd` (fallback `find`), respects .gitignore |
| `grep` | Content search via `rg` |
| `web_fetch` | HTTP GET with HTML to markdown conversion, 15-min cache, summarized via a lightweight model when configured |
| `AskUserQuestion` | Pause the run and ask the user a multiple-choice or free-text question (rendered as numbered options in the chat) |
| `web_search` | Provider-native web search where available (Anthropic, Google when no other tools are present, OpenAI Responses) |

The Claude CLI provider has its own tool implementations and ignores the list above.

### MCP Brilliant tools (canvas)

These let the model design directly on the canvas:

| Tool | Purpose |
|------|---------|
| `init` | Bootstrap session context (canvas IDs, design system, repo info) |
| `get_knowledge` | Load `.claude-prod/knowledge/*.md` files (blueprint reference, design heuristics, etc.) |
| `get_selection` | Read the user's current selection as blueprint |
| `lookup` | Find or read elements. `scope` (canvas paths, element IDs, `#refs`) constrains where to look; filters (`query`, `textContent`, `type`, `fillColor`, `componentName`) narrow within scope. `format` is `"summary"` (default, compact metadata) or `"blueprint"` (full trees with optional `depth`). |
| `create_html` | Convert HTML + inline CSS to elements (default for new designs) |
| `create_modify_elements` | Create or modify elements via Brilliant's blueprint DSL |
| `execute_commands` | Dispatch any Brilliant canvas command (align, resize, group, set fill, etc.) — see "AI-Invocable Commands" below |
| `export` | Render elements to PNG / JPEG / WebP / SVG / PDF (returns base64 image so the model can self-review) |
| `generate_image` | Generate or edit an image with Google's "Nano Banana" image model and apply it as a fill |

The Brilliant MCP server is auto-loaded by the user's local Claude Code instance when the workspace is opened from Brilliant (no manual setup). External MCP servers can also be configured; their tools are loaded lazily via the `load_mcp_server` tool when needed.

### AI-Invocable Commands

`execute_commands` lets the AI dispatch any command that implements the `AIInvocableCommand` interface. This includes selection ops (align, distribute, flip), property setters (corner radius, opacity, blend mode), tool changes, frame and component operations, and more — over 100 commands in total. The AI provides element IDs and parameters; the command runs through the same code path as a keyboard or button press, with full undo support.

### Sub-Agents

For large tasks, the main session can spawn parallel sub-agents via the `plan_agents` then `spawn_agent` tools. Each sub-agent runs in its own ChatOrchestrator (same provider, same API key) with a 5-minute timeout, returns a summary, and renders in the parent session as a collapsible card.

---

## AI Image Generation

Image generation uses Google's "Nano Banana" image model (`gemini-3.1-flash-image-preview` via the Gemini API). Generated images are saved to the project's `Assets/` folder and applied as image fills on target elements.

### Requirements

A Google API key or Google OAuth credentials. Image generation is only available when the Google provider is connected, regardless of which chat model is active.

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

Pass element IDs in `referenceElementIds` to use existing canvas elements as visual references for style or structure. Up to 14 references (10 objects + 4 characters) are supported. This is how you "edit" a generated image: pass the original as a reference and prompt the change.

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
| Focus chat session 1 to 9 | Cmd+1 through Cmd+9 |
| Focus chat session 10 | Cmd+0 |
| Focus next chat session | Cmd+Shift+] |
| Focus previous chat session | Cmd+Shift+[ |
| Close / archive focused chat session | Cmd+W (when AI input is focused) |
| Toggle chat explorer | Cmd+Shift+A |
| New chat | Cmd+N (when AI input is focused) |
| Chat search | Cmd+Shift+I |
| Toggle AI chat panel | Toggle AI Chat command (no default keybinding; assignable in shortcuts view) |

These shortcuts focus the chat session assigned to that number, opening the chat panel if it is hidden. Session number assignments show as keybinding badges in the chat panel header and chat explorer sidebar.

---

## Chat Panel Controls

- **Open / close:** click the connection indicator in the bottom toolbar, or run **Toggle AI Chat**
- **Rename:** double-click the topic name in the chat header, or use `/rename`
- **Resize width:** drag the panel edges (300 to 1200 px)
- **Resize height:** drag the top edge (min 200 px)
- **Queue follow-up:** sending a message while the model is processing queues it; it sends automatically when the current response finishes
- **Edit and resend:** click the edit icon on a user message to revise and resend
- **Copy chat:** the header has a copy button that exports the full conversation as markdown with YAML frontmatter (model, date, project, canvas, tokens, turns)
- **Chat explorer:** toggle with **Cmd+Shift+A** to browse, search, and manage all sessions; drag the divider to resize or collapse it

---

## Streaming Element Creation

When the AI emits `<objects canvasId="...">` blocks (or calls `create_modify_elements`), elements are created on the canvas line by line as they stream. The chat shows a small preview chip per object batch with element count, a scale indicator, and warnings or errors from the blueprint compiler if any lines failed validation.
