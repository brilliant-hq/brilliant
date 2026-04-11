---
name: "knowledge-ai"
description: "AI features in Brilliant: natural language commands, multi-provider chat, attachments, and Claude Code integration."
---

# AI Features

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

Brilliant has two AI systems: a **natural language command bar** for quick design operations, and a **multi-provider chat** system for conversational AI-assisted design.

---

## AI Natural Language Commands

### Accessing AI Input

| Action | Shortcut |
|--------|----------|
| Focus AI input in bottom toolbar | / |

### How It Works

1. Select one or more elements on the canvas
2. Focus the AI input (press **/** or click the text field in the bottom toolbar)
3. Type a natural language command
4. Press **Enter** to execute

### Operation Types

| Type | Example | Description |
|------|---------|-------------|
| Absolute | "width 300" | Set to exact value |
| Add | "add 50 to width" | Add to current value |
| Subtract | "subtract 20 from height" | Subtract from current |
| Multiply | "3x width" | Multiply current value |
| Percent | "50% opacity" | Set as percentage |
| Increase | "bigger", "wider" | Increase by a step |
| Decrease | "smaller", "thinner" | Decrease by a step |

### Color Commands

| Command | What It Does |
|---------|-------------|
| "red" / "green" / "blue" / etc. | Apply named color |
| "#FF5733" | Apply hex color |
| "coral" / "navy" / "mint" / etc. | Apply named color |
| "convert to gradient" | Convert solid to gradient |
| "convert to solid" | Convert gradient to solid |
| "darker" / "lighter" | Adjust brightness |

**42 supported named colors:** red, green, blue, yellow, orange, purple, pink, cyan, magenta, white, black, gray, grey, navy, teal, maroon, olive, lime, aqua, coral, salmon, turquoise, indigo, violet, gold, silver, brown, beige, tan, crimson, lavender, plum, orchid, khaki, azure, ivory, mint, peach, rose, charcoal, slate, transparent

### Opacity Commands

| Command | What It Does |
|---------|-------------|
| "50% opacity" | Set opacity to 50% |
| "transparent" | Set to 0% |
| "opaque" | Set to 100% |
| "half opacity" | Set to 50% |

### Position Commands

| Command | What It Does |
|---------|-------------|
| "x 100" / "y 200" | Set position |
| "position 100, 200" / "move to 100, 200" | Set both |

### Size Commands

| Command | What It Does |
|---------|-------------|
| "width 300" / "w 300" | Set width |
| "height 150" / "h 150" | Set height |
| "w 200, h 100" / "size 200, 100" | Set both |
| "make it wider/taller/smaller/bigger" | Adjust size |

### Scale Commands

| Command | What It Does |
|---------|-------------|
| "scale 2x" / "3x bigger" | Multiply size |
| "scale 50%" | Half the size |
| "scale to width 300" / "scale to height 200" | Uniform scale |

### Rotation Commands

| Command | What It Does |
|---------|-------------|
| "rotate 45" / "rotate 90" / "rotate 180" | Set rotation |
| "no rotation" | Reset to 0 degrees |

### Corner Radius Commands

| Command | What It Does |
|---------|-------------|
| "corner radius 16" / "radius 16" | Set all corners |
| "top left radius 16" | Set one corner |
| "top corners 8" / "bottom corners 12" | Set two corners |
| "sharper corners" / "rounder corners" | Adjust radius |
| "no radius" | Set to 0 |

### Text Commands

| Command | What It Does |
|---------|-------------|
| "font size 24" / "text size 24" | Set font size |
| "bigger text" / "smaller text" | Adjust size |
| "bold" / "italic" / "underline" | Toggle style |
| "align text left/center/right" | Set alignment |
| "line height 1.5" | Set line height |
| "auto size text" / "auto height text" / "auto width text" / "fixed size text" | Sizing mode |
| "set font [name]" | Apply font |

### Alignment Commands

| Command | What It Does |
|---------|-------------|
| "align left/right/top/bottom" | Align selection |
| "center horizontally/vertically" | Center |
| "distribute horizontally/vertically" | Equal spacing |
| "fit to parent" | Fill parent bounds |

### Transform Commands

| Command | What It Does |
|---------|-------------|
| "flip horizontally" / "flip vertically" | Mirror |

### Stroke Commands

| Command | What It Does |
|---------|-------------|
| "stroke inside/center/outside" | Set position |
| "3x stroke thickness" / "thicker" / "thinner" | Adjust thickness |
| "round cap" / "square cap" | Set cap style |

### Fill/Stroke Toggle Commands

| Command | What It Does |
|---------|-------------|
| "add fill" / "remove fill" | Toggle fill |
| "add stroke" / "remove stroke" | Toggle stroke |
| "dark theme" / "light theme" | Apply theme |

### Layout Commands

| Command | What It Does |
|---------|-------------|
| "set direction horizontal/vertical" | Auto layout direction |
| "select all" / "duplicate" | Element operations |
| "rename [name]" | Rename layer |

### Other Commands

| Command | What It Does |
|---------|-------------|
| "switch tool" | Switch to different tool |
| "enter" | Enter edit mode |
| "zoom 200%" / "zoom to fit" | Zoom control |

### Command History

- **Up/Down arrow keys** in the AI input to navigate previously sent commands (newest first)
- **Ctrl+R** activates reverse search mode — type to search through history (case-insensitive)
- Press **Ctrl+R** again to cycle to the next search result
- History is deduplicated and persists across sessions

### Tips

- Commands are case-insensitive
- Combine related properties: "w 200, h 100"
- Use fuzzy language: "make it bigger", "sharper", "bolder"

---

## Multi-Provider AI Chat

Brilliant integrates a full chat system supporting multiple AI providers. The AI chat panel is a floating panel that appears above the bottom toolbar, containing a chat explorer sidebar and the active chat session.

### Providers

| Provider | Models | Authentication |
|----------|--------|----------------|
| **Claude CLI** | Models discovered dynamically from local Claude CLI installation | Uses local Claude CLI installation |
| **Anthropic HTTP** | Opus 4.6, Sonnet 4.6, Sonnet 4.5, Haiku 4.5 | API key |
| **OpenAI HTTP** | GPT-5.4, GPT-5.4 Pro, GPT-5.3 Codex | API key |
| **Google HTTP** | Gemini 3.1 Pro, Gemini 3 Pro, Gemini 3 Flash | API key or OAuth |
| **OpenRouter HTTP** | Routes to Anthropic, OpenAI, Google, DeepSeek, Moonshot models | API key |

### Setting Up API Keys (BYOK)

When no providers are configured, the chat panel shows a **Get Started** onboarding view with buttons to add API keys for each provider, instructions for installing Claude Code CLI, and info about MCP client connections.

To manage provider connections at any time:

1. Hover the **connection indicator** (checkmark/X icon) in the bottom toolbar — a provider status popup appears showing all providers with green (connected) or dim (not connected) dots
2. Click an unconnected provider row — the chat input field converts into an API key entry field (with "esc to close" and "Enter to set key" hints)
3. Enter your API key and press Enter — the key is validated against the provider's API
4. Keys are stored securely in platform-native credential storage (macOS Keychain)
5. To remove a key, hover the connection indicator and click a connected provider row

### Starting a Chat Session

Chat sessions live in the AI chat panel, a floating panel above the bottom toolbar. Open it by clicking the connection indicator in the bottom toolbar or using the Toggle AI Chat command. Each session is an independent conversation with its own provider, model, and history. Use Cmd+N (when focused) to create a new session, or use the chat explorer sidebar to browse and select sessions.

### Switching Models

The input bar row (at the bottom of the chat panel) contains, from left to right: an attach button, the **model selector**, the **thinking level selector**, a **context usage indicator**, a keyboard hint, undo/redo buttons, and a send/stop button. Click the model selector to switch the model for the current session. You can also type `/model` in the chat input to change models. Changing the model also sets it as the default for future sessions.

### Thinking / Reasoning Levels

Some models support configurable thinking levels that control how much internal reasoning the model performs:

| Level | Description |
|-------|-------------|
| **Off** | No extended thinking (fastest) |
| **Low** | Minimal reasoning |
| **Medium** | Moderate reasoning |
| **High** | Maximum reasoning (slowest, most capable) |
| **Xhigh** | Extra-high reasoning (GPT-5.3 Codex only) |

Available levels depend on the provider and model. Claude models support all levels including Off. Gemini models always reason and do not offer an Off level. OpenAI models (GPT-5.4, GPT-5.4 Pro) support Low/Medium/High reasoning levels without an Off option. GPT-5.3 Codex supports an additional Xhigh level (Low/Medium/High/Xhigh).

### Attachments

Add context to chat messages:

| Type | How to attach | Description |
|------|---------------|-------------|
| **Elements** | Type **@** in the input to mention canvas elements by name | Attaches element summaries and screenshots as context |
| **Images** | Paste from clipboard, drag-and-drop, or use the attach button (paperclip icon) | Sends image data to the model for vision-capable providers |
| **Files** | Use the attach button (paperclip icon) or drag-and-drop into the input area | Attaches file contents for reference |

### Slash Commands

Type these in the chat input:

| Command | Description |
|---------|-------------|
| `/stop` | Stop the current response |
| `/continue` | Nudge the model to continue |
| `/context` | Show context window usage (token stats) |
| `/usage` | Show account usage |
| `/compact` | Compact conversation history (LLM-driven summarization) |
| `/feedback` | File feedback or report an issue |
| `/archive` | Archive the current chat |
| `/new` | Start a new chat |
| `/clear` | Start a new chat (alias for /new) |
| `/model` | Change the AI model |
| `/rename` | Rename the current chat (e.g. `/rename My Chat`) |
| `/copy` | Copy last assistant message |
| `/help` | Show available commands |

### Stopping a Response

- Type `/stop` in the chat input, or click the stop button
- The response stops immediately, aborting any in-progress HTTP request
- If the model is in a tool-use loop, further tool execution is prevented

### Chat Session Shortcuts

| Action | Shortcut |
|--------|----------|
| Focus chat session 1–9 | Cmd+1 through Cmd+9 |
| Focus chat session 10 | Cmd+0 |
| Focus next chat session | Cmd+Shift+] |
| Focus previous chat session | Cmd+Shift+[ |
| Close/archive focused chat session | Cmd+W (when AI input is focused) |
| Toggle chat explorer | Cmd+Shift+A |
| New chat | Cmd+N (when AI input is focused) |
| Chat search | Cmd+Shift+I |

These shortcuts focus the AI chat session assigned to that number, opening the chat panel if it is not already visible. Session number assignments are shown as keybinding badges in the chat panel header and the chat explorer sidebar.

### Chat Panel Controls

- **Open/close** — Click the connection indicator (checkmark/X icon) in the bottom toolbar, or use the Toggle AI Chat command
- **Rename** — Double-click the topic name in the chat header
- **Resize width** — Drag panel left/right edges (300–1200px)
- **Resize height** — Drag top edge of panel (min 200px)
- **Queue follow-up** — Send a message while the model is processing; it queues and executes when the current response completes
- **Chat explorer** — Toggle with Cmd+Shift+A; browse, search, and manage all chat sessions; drag the divider to resize or collapse it

---

## AI Image Generation

Brilliant can generate images using Google's Nano Banana 2 (gemini-3.1-flash-image-preview) model. Generated images are saved to the project Assets folder and applied as image fills on target elements.

### Requirements

A Google API key or OAuth authentication must be configured (see "Setting Up API Keys" above).

### How It Works

1. The AI agent calls the `generate_image` tool with a text prompt
2. The image is generated and saved to the project's Assets folder
3. The returned asset path is used with `img(assetPath)` in element fills

### Quality Settings

| Setting | Image Size | Speed | Best For |
|---------|-----------|-------|----------|
| Quick draft | 1K | ~5s | Placeholders, good balance |
| High quality | 2K | ~15-20s | Hero images, product photos |
| Maximum quality | 4K | Slowest | Final marketing assets |

### Prompt Tips

- Write descriptive paragraphs, not keyword lists
- Be specific about subjects, lighting, composition, and style
- Use photography terminology (focal length, depth of field, lighting)
- For text in images, state exactly what the text should read
- When editing with reference images, change one thing at a time

### Supported Aspect Ratios

Aspect ratios are passed directly to the Google Gemini Image API. Commonly used ratios include: 1:1, 3:4, 4:3, 9:16, 16:9. Other ratios may also work depending on the API.

