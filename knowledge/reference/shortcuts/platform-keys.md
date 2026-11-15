---
name: "knowledge-shortcuts-platform-keys"
description: "How Cmd, Ctrl, Alt, and Shift map per platform, and the Windows-disabled and Windows-remapped defaults."
assumes: reference/shortcuts
---

# Shortcuts: Platform Keys

| This Guide Says | macOS | Windows / Linux |
|----------------|-------|------------------|
| Cmd | Command (⌘) | Ctrl |
| Ctrl | Control (⌃) | Ctrl |
| Alt | Option (⌥) | Alt |
| Shift | Shift (⇧) | Shift |

### Windows-disabled defaults

On Windows several macOS defaults are unbound, because their Cmd-based chords collapse onto an essential Ctrl shortcut (e.g. a quick-color Ctrl chord would collide with Bold/Group/Rename) or because the feature is macOS-only. Users can reassign any of these in the Shortcuts panel; the actions also stay reachable via the menu, palette, or inspector.

| Command | Reason |
|---------|--------|
| `toggle_overlay_mode` (default Ctrl+F on macOS) | Ctrl+F is the universal "Find" shortcut on Windows. Also unregisters the global hotkey. |
| `toggle_pass_through` (default Ctrl+A on macOS) | Ctrl+A is the universal "Select All" shortcut on Windows. |
| Snip tool (`change_tool_snip`, default S) | Screen capture is macOS-only. |
| `toggle_desktop_icons` (default Ctrl+I) | macOS-only no-op; frees Ctrl+I for Italic. |
| Outline Text (`Cmd+Ctrl+O`) | Collapses to Ctrl+O and collides; use the menu/palette instead. |
| Center on selection (`Cmd+Ctrl+C`) | Collapses onto Copy (Ctrl+C); Alt+C is used by the color selector on Windows. Use Zoom to selection (Alt+Z) or the palette. |
| All quick colors (Ctrl+R/G/B/Y/O/P/W/K) and gradient colors (Ctrl+D/L) | Collide with Cmd→Ctrl editing commands (Bold, Group, Rename, etc.); set color via the inspector or palette. |
| Blue / green / red highlighter combos (Ctrl+Shift+B/G/R) | Collide with Blackboard / Ungroup / Paste to replace. The yellow highlighter combo stays bound. |
| Distribute vertically (Ctrl+Alt+V) | Paste properties (Cmd+Alt+V) lands on Ctrl+Alt+V on Windows, Figma's Windows chord for it. Use the align row in the inspector or the palette. |
| Scale levels 0–9 (Alt+0–9) | Alt+digit is the chat-session switcher on Windows, and every alternative digit chord is taken (Ctrl+Shift+digit is transparency, Alt+Shift+digit is rotation, Ctrl+digit jumps tabs, Ctrl+Alt+digit is AltGr). Use Scale up/down (Alt+Shift+= / Alt+-), scale mode (K), or the palette. |

### Windows-remapped defaults

On Windows some macOS defaults are moved to free chords (their macOS chord collapses onto, or was authored on, a chord owned by an essential command). A Windows user should expect these instead of the macOS chords listed elsewhere in this guide:

| Command | macOS | Windows |
|---------|-------|---------|
| Fit all content | Cmd+Ctrl+A | Alt+A |
| Color selector | Ctrl+C | Alt+C |
| Color pick mode (eyedropper) | Ctrl+Shift+C | Alt+Shift+C |
| Zoom to selection | Cmd+Ctrl+F | Alt+Z |
| Disable zoom out | Cmd+Ctrl+D | Alt+D |
| Duplicate canvas | Cmd+Ctrl+N | Alt+N |
| Increase size | Shift+= | = (bare) |
| Increase / decrease rotation | Cmd+Ctrl+Shift+= / Cmd+Ctrl+- | Shift+= / Shift+- |
| Rotation levels 0–9 | Cmd+Ctrl+0–9 | Alt+Shift+0–9 |
| Focus chat session 1–9 / 10 | Cmd+1–9 / Cmd+0 | Alt+1–9 / Alt+0 |
