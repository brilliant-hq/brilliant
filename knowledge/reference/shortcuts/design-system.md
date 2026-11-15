---
name: "knowledge-shortcuts-design-system"
description: "Combo preset, design system, and provider API key commands."
assumes: reference/shortcuts
---

# Shortcuts: Combos, Design System, Provider Keys

## Combo Presets

| Action | Shortcut |
|--------|----------|
| Yellow highlighter | Ctrl+Shift+Y |
| Red highlighter | Ctrl+Shift+R |
| Green highlighter | Ctrl+Shift+G |
| Blue highlighter | Ctrl+Shift+B |

## Design System

| Action | Shortcut |
|--------|----------|
| Switch design mode (e.g. light / dark) | (no default, id `set_design_system_mode`) |
| Apply dark theme / Apply light theme | (no defaults, ids `apply_dark_theme`, `apply_light_theme`. Note: Ctrl+D and Ctrl+L are bound to the "Gradient (dark)" / "Gradient (light)" color commands, NOT to these theme commands) |
| Apply typography / shadow token to selection | (no defaults, ids `apply_typography_token`, `apply_shadow_token`) |
| Set design token on selected element property | (no default, id `set_design_token`) |
| Unbind design tokens from selection | (no default, id `unbind_tokens`) |
| Regenerate / reset / open design system file | (no defaults, ids `regenerate_design_system`, `reset_design_system`, `open_design_system_file`) |
| Create a design system viewer canvas | (no default, id `create_design_system_viewer`) |
| Switch active design system | (no default, id `set_design_system`) |

Note: seeds (color, mode) and base scales (spacing, radius, font size, font weight, line height) are not set via individual commands. They are authored in the design system source, which `open_design_system_file` opens in the code editor. For the authoring syntax, see the design-systems knowledge files.

## Provider / API Keys

| Action | Shortcut |
|--------|----------|
| Set Anthropic / OpenAI / Google / OpenRouter / Quiver API key | (no defaults, ids `set_anthropic_api_key`, `set_openai_api_key`, `set_google_api_key`, `set_openrouter_api_key`, `set_quiver_api_key`) |
