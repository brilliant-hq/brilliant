---
name: "knowledge-shortcuts-window"
description: "Window, background, chrome, and app shortcuts."
assumes: reference/shortcuts
---

# Shortcuts: Window and Background

| Action | Shortcut |
|--------|----------|
| Toggle overlay mode | Ctrl+F on macOS, an OS-level global hotkey that fires even when Brilliant is unfocused; switches between studio and overlay. Requires overlay mode enabled in settings. Unbound by default on Windows. |
| Toggle passthrough (overlay only) | Ctrl+A on macOS (global hotkey while in overlay; makes the window click-through to apps below). Unbound by default on Windows. |
| Show/hide UI | Cmd+\\ (hides ALL app chrome: the left, right, and bottom toolbars AND the top strip (the top bar with home and the tabs). Summoned surfaces stay reachable (palette, tooltips, notifications); press Cmd+\\ again to restore, in AI focus or the full UI as you left it. Both window modes.) |
| AI focus / full UI | Cmd+Shift+\\ (switches between AI focus, which keeps the top bar, the bottom toolbar and the chat and hides the side panels, and the full UI; the Focus / Full switch in the top bar does the same; remembered across launches) |
| Expand/collapse all right-toolbar sections | Cmd+/ (id `toggle_sections`) |
| Toggle blackboard | Cmd+Shift+B |
| Toggle whiteboard | Cmd+Shift+W |
| Toggle canvas background | Cmd+Shift+D (id `toggle_background`) |
| Toggle desktop icons (overlay) | Ctrl+I |
| Presentation mode | Alt+P |
| Clear all elements on canvas | (no default key, command id `clear_elements`: the canvas right-click menu's Canvas submenu or the palette) |
| Toggle render profiler | Cmd+Shift+Alt+P (id `toggle_render_profiler`) |
| Toggle search profiler | (no default, id `toggle_search_profiler`) |
| Toggle top-left indicator | (no default, id `toggle_indicator`) |
| Quit application | Cmd+Q (id `quit_app`; on macOS the system menu provides it). On Windows, Ctrl+Q / menu Quit run the same clean close as the window's ✕, auto-save flush and unsaved-work guard included. |
| Hide application | Cmd+H (id `hide_app`; on macOS the system menu provides it). On Windows, Ctrl+H **minimizes** the window, the platform's hide convention. |
| Hide others | (no default, id `hide_others`; macOS provides Cmd+Alt+H. macOS-only concept.) |
