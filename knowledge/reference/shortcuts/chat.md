---
name: "knowledge-shortcuts-chat"
description: "AI chat session shortcuts."
assumes: reference/shortcuts
---

# Shortcuts: Chat Sessions

| Action | Shortcut |
|--------|----------|
| Focus chat session 1–9 | Cmd+1 through Cmd+9 |
| Focus chat session 10 | Cmd+0 |

**Windows exception to the Cmd→Ctrl mapping:** chat sessions are **Alt+1..9 / Alt+0** on Windows. Ctrl+digit belongs to Jump-to-tab there (the platform tab standard, as in Chrome and VS Code), and Ctrl+Alt+digit is AltGr on European layouts, so the switcher uses plain Alt. The scale-level chords (Alt+digit on macOS/Linux) are unbound on Windows so the switcher owns the chord outright.
| Focus next chat | Cmd+Shift+] |
| Focus previous chat | Cmd+Shift+[ |
| Close AI chat | Cmd+W (while the chat is open or its input is focused) |
| Toggle chat explorer | Cmd+Shift+A (when AI chat is open) |
| New chat | Cmd+N (when AI chat is open) |
| AI chat layout: full screen / bottom half / right half / left half | (no defaults, ids `ai_chat_full_screen`, `ai_chat_bottom_half`, `ai_chat_right_half`, `ai_chat_left_half`) |
| Toggle AI chat panel | (no default, command id `toggle_ai_chat`) |
| Toggle suggested prompts | (no default, command id `toggle_suggested_prompts`) |
| Toggle AI input collapse | (no default, command id `toggle_ai_input_collapse`) |
| Clear AI input | (no default, command id `clear_ai_input`) |
| Delete all archived chats | (no default, command id `delete_all_archived_chats`) |

These shortcuts focus (and expand if minimized) the AI chat session assigned to that number. Cmd+N and Cmd+Shift+A are conditional: they only act on the chat when the AI chat surface is open or focused. When the AI chat surface is not open, Cmd+N creates a new canvas. Cmd+W closes the chat while the chat is open or its input is focused; otherwise, over a project, it closes the active project tab (and on the home screen it does nothing).
