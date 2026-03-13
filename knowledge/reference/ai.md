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

Brilliant integrates a full chat system supporting multiple AI providers. Chat sessions appear in the bottom toolbar alongside the AI command input.

### Providers

| Provider | Models | Authentication |
|----------|--------|----------------|
| **Claude CLI** | Models discovered dynamically from local Claude CLI installation | Uses local Claude CLI installation |
| **Anthropic HTTP** | Sonnet 4.6, Opus 4.6, Sonnet 4.5, Haiku 4.5 | API key |
| **OpenAI HTTP** | GPT-5.4, GPT-5.4 Pro, GPT-5.2, GPT-5.2 Pro, GPT-5 Mini, GPT-5 Nano, o3, o3 Pro, o3 Mini, o4 Mini, GPT-5.2 Codex, GPT-4.1, GPT-4.1 Mini, GPT-4.1 Nano | API key |
| **Google HTTP** | Gemini 3.1 Pro, Gemini 3 Pro, Gemini 3 Flash, Gemini 2.5 Pro, Gemini 2.5 Flash, Gemini 2.5 Flash Lite | API key or OAuth |
| **OpenRouter HTTP** | Routes to Anthropic, OpenAI, Google, DeepSeek, Meta models | API key |

### Setting Up API Keys (BYOK)

1. Click the model picker dropdown in a chat session
2. Select **"Manage providers..."**
3. Enter your API key for each provider
4. Keys are validated against the provider's API before saving
5. Keys are stored securely in platform-native credential storage (macOS Keychain)

### Starting a Chat Session

Chat sessions appear in the bottom toolbar. Each session is an independent conversation with its own provider, model, and history.

### Thinking / Reasoning Levels

Some models support configurable thinking levels that control how much internal reasoning the model performs:

| Level | Description |
|-------|-------------|
| **Off** | No extended thinking (fastest) |
| **Low** | Minimal reasoning |
| **Medium** | Moderate reasoning |
| **High** | Maximum reasoning (slowest, most capable) |

Available levels depend on the provider and model. Claude models support all levels including Off. Gemini and OpenAI reasoning models (GPT-5.4, GPT-5.4 Pro, GPT-5.2, GPT-5.2 Pro, o3, o3 Pro, o3 Mini, o4 Mini, Codex) always reason and do not offer an Off level. Non-reasoning OpenAI models (GPT-5 Mini, GPT-5 Nano, GPT-4.1 family) do not support thinking levels.

### Attachments

Add context to chat messages:

| Type | Description |
|------|-------------|
| **Elements** | Attaches selected canvas element summaries |
| **Images** | Paste from clipboard or pick a file |
| **Files** | Attach any file for reference |

### Slash Commands

Type these in the chat input:

| Command | Description |
|---------|-------------|
| `/continue` | Nudge the model to continue |
| `/stop` | Stop the current response |
| `/context` | Show context window usage (token stats) |
| `/cost` | Show session cost breakdown |
| `/compact` | Compact conversation history (LLM-driven summarization) |
| `/feedback` | File feedback or report an issue |
| `/close` | Close the chat session |
| `/minimize` | Minimize the chat panel |
| `/delete` | Mark chat for deletion |
| `/undelete` | Restore a deleted chat |

### Stopping a Response

- Type `/stop` in the chat input
- The response stops immediately, aborting any in-progress HTTP request
- If the model is in a tool-use loop, further tool execution is prevented

### Chat Session Shortcuts

| Action | Shortcut |
|--------|----------|
| Focus chat session 1–9 | Cmd+1 through Cmd+9 |
| Focus chat session 10 | Cmd+0 |
| Focus next chat session | Cmd+Shift+] |
| Focus previous chat session | Cmd+Shift+[ |
| Close focused chat session | Cmd+W |

These shortcuts focus and expand (if minimized) the AI chat session assigned to that number. Session number assignments are shown in the session indicators in the bottom toolbar.

### Chat Panel Controls

- **Expand/minimize** — Click session indicator in bottom toolbar
- **Rename** — Double-click the topic name in the chat header
- **Resize width** — Drag between sessions or at panel edges (160–640px)
- **Resize height** — Drag top edge of panel
- **Queue follow-up** — Send a message while the model is processing; it executes when ready

---

## AI Image Generation

Brilliant can generate images using Google's Nano Banana 2 (Gemini Image) model. Generated images are saved to the project Assets folder and can be placed on the canvas.

### Requirements

A Google API key or OAuth authentication must be configured (see "Setting Up API Keys" above).

### How It Works

1. The AI agent calls the `generate_image` tool with a text prompt
2. The image is generated and saved to the project's Assets folder
3. The returned asset path is used with `img(assetPath)` in element fills

### Quality Settings

| Setting | Image Size | Speed | Best For |
|---------|-----------|-------|----------|
| Fast draft | 512px | Fastest | Quick iterations, throwaway tests |
| Default | 1K | ~5s | Placeholders, good balance |
| High quality | 2K | ~15-20s | Hero images, product photos |
| Maximum quality | 4K | Slowest | Final marketing assets |

### Prompt Tips

- Write descriptive paragraphs, not keyword lists
- Be specific about subjects, lighting, composition, and style
- Use photography terminology (focal length, depth of field, lighting)
- For text in images, state exactly what the text should read
- When editing with reference images, change one thing at a time

### Supported Aspect Ratios

1:1, 3:2, 2:3, 3:4, 4:3, 4:5, 5:4, 9:16, 16:9, 21:9, 1:4, 4:1, 1:8, 8:1

