---
name: "brilliant-user-guide"
description: "Master entry point for Brilliant end-user documentation. Load this first when answering any question about how to use Brilliant."
---

# Brilliant - User Guide

Brilliant is a cross-platform design tool for macOS, Windows, and Linux with two modes: **Studio** (default, regular desktop window like Figma) and **Overlay** (transparent layer above other apps, summoned via global hotkey). Draw, annotate, and design in either mode.

## How to Use This Documentation

When a user asks a question, **read** the relevant sub-skill file from the table below using the `Read` tool (these are markdown files in this directory, not registered skills).

## Sub-Skills

| File | Covers | Read When Asked About |
|------|--------|----------------------|
| `TOOLS.md` | All 12 drawing and shape tools | Drawing, creating shapes, switching tools |
| `EDITING.md` | Selection, move, resize, rotate, align, clipboard | Moving, resizing, rotating, aligning, z-order, copy/paste |
| `STYLING.md` | Colors, fills, strokes, opacity, corner radius | Colors, gradients, opacity, corner radius |
| `FRAMES.md` | Parent types, groups, and auto layout | Parents, grouping, auto layout, nesting |
| `COMPONENTS.md` | Component masters, instances, overrides, syncing | Components, instances, overrides, detaching, master |
| `LAYOUT_GUIDES.md` | Column, row, and grid layout guides | Layout guides, layout grids, columns, rows, gutters |
| `TEXT.md` | Text editing and typography | Text, fonts, bold/italic, line height |
| `VECTORS.md` | Pen tool, vector path editing | Pen tool, nodes, bezier curves |
| `CANVAS.md` | Zoom, pan, snap, background | Zoom, navigation, snap guides, backgrounds |
| `CANVASES.md` | Canvas and file management | Canvases, folders, import/export, saving |
| `UI.md` | UI panels and overlays | Toolbars, command palette, color picker |
| `SHORTCUTS.md` | Complete keyboard shortcut reference | Any keyboard shortcut question |
| `AI.md` | AI commands, multi-provider chat, BYOK | AI commands, chat providers, API keys, attachments |
| `EFFECTS.md` | Element effects: shadows, glows, blurs | Shadows, glows, blurs, effects commands |
| `DESIGN_SYSTEM.md` | Design tokens, .styles files, color scales | Tokens, design system, .styles, theming |
| `CROP.md` | Image crop mode, scale modes, interactive editing | Crop, image positioning, Fill/Fit/Crop modes |
| `EXPORT.md` | Export formats, video export, Copy As clipboard, SVG/image import | Export, PNG, SVG, PDF, MP4, MOV, video, Copy As, import |
| `SHADERS.md` | Shader fills and strokes: animated procedural GPU effects | Shader fills, shader strokes, animated patterns, metaballs, liquid metal, holographic |

## Routing Guide

| If the user asks about... | Read |
|--------------------------|------|
| "What can't Brilliant do?" | This file (SKILL.md → "What Brilliant Doesn't Have") |
| "I'm coming from the old Brilliant" | This file (SKILL.md → "Coming From Legacy Brilliant") |
| "Where are my boards/annotations?" | This file (SKILL.md → "Coming From Legacy Brilliant") |
| "What's the difference between a canvas and a frame?" | This file (SKILL.md → "Key Concepts") |
| "Does it work offline?" | This file (SKILL.md → "Platforms & Offline Use") |
| "Can I use it with Figma shortcuts?" | SHORTCUTS.md (→ "Coming From Figma?") |
| "How do I collaborate with my team?" | CANVASES.md (→ "Collaboration & Sharing") |
| "Can I use version control?" | CANVASES.md (→ "Version Control with Git") |
| "Coming from Illustrator" | FRAMES.md (→ "Coming From Adobe Illustrator") |
| "Where is pathfinder/boolean?" | EDITING.md or SHORTCUTS.md (→ Boolean operations) |
| "How do I draw a rectangle?" | TOOLS.md |
| "How do I change the color?" | STYLING.md |
| "How do I group elements?" | FRAMES.md |
| "How do I create a component?" | COMPONENTS.md |
| "How do instances work?" | COMPONENTS.md |
| "How do I detach an instance?" | COMPONENTS.md |
| "How do I add layout guides?" | LAYOUT_GUIDES.md |
| "How do I move/resize/rotate?" | EDITING.md |
| "How do I edit text?" | TEXT.md |
| "How do I edit vector nodes?" | VECTORS.md |
| "How do I measure distances?" | CANVAS.md |
| "How do I zoom in?" | CANVAS.md |
| "How do I create a new canvas?" | CANVASES.md |
| "Where is the layers panel?" | UI.md |
| "What's the shortcut for...?" | SHORTCUTS.md |
| "How do I customize shortcuts?" | SHORTCUTS.md |
| "How do I resolve shortcut conflicts?" | SHORTCUTS.md |
| "What does 'Active when' mean?" | SHORTCUTS.md |
| "Can I use natural language?" | AI.md |
| "How do I set up an API key?" | AI.md |
| "What AI providers are supported?" | AI.md |
| "How do I add attachments to chat?" | AI.md |
| "How do I add a shadow?" | EFFECTS.md |
| "How do I add noise/grain?" | SHADERS.md |
| "How do I blur an element?" | EFFECTS.md |
| "How do I crop an image?" | CROP.md |
| "What are Fill/Fit/Crop modes?" | CROP.md |
| "How do I export as PNG/SVG/PDF?" | EXPORT.md |
| "How do I export a video?" | EXPORT.md (→ "Video Export") |
| "What fonts are available?" | TEXT.md (→ "Font Selector" and "Available Fonts") |
| "How do I change the font?" | TEXT.md (→ "Font Family") |
| "How do I copy as CSS/SVG?" | EXPORT.md |
| "How do I import an SVG?" | EXPORT.md |
| "How do I import from Figma?" | CANVASES.md (→ "Importing from Figma") — use `import_figma` command |
| "What is a workspace?" | CANVASES.md |
| "Where are my files saved?" | CANVASES.md |
| "How do I add a shader fill?" | SHADERS.md |
| "How do I use animated fills?" | SHADERS.md |
| "How does undo work?" | EDITING.md |
| "Is undo per-canvas?" | EDITING.md |
| "Build me a card/navbar/form" | `building/SKILL.md` → sub-skills |
| "What layout patterns exist?" | `building/SKILL.md` → sub-skills |
| "Recreate this website" | `recreation/WEBSITE.md` + `building/SKILL.md` → sub-skills |
| "Build a pixel-perfect copy" | `recreation/IMAGE.md` + `building/SKILL.md` → sub-skills |
| "Recreate this screenshot" | `recreation/IMAGE.md` + `building/SKILL.md` → sub-skills |
| "Build this from the image" | `recreation/IMAGE.md` + `building/SKILL.md` → sub-skills |
| "Copy this design" + image | `recreation/IMAGE.md` + `building/SKILL.md` → sub-skills |
| "Recreate this URL" | `recreation/WEBSITE.md` + `building/SKILL.md` → sub-skills |

## Quick Start

1. **Draw a shape** — Press `R` for rectangle, click and drag on the canvas
2. **Change its color** — Press `Ctrl+R` for red, or open the color picker with `Ctrl+C`
3. **Add text** — Press `T`, click on the canvas, and type
4. **Move elements** — Click to select, then drag or use arrow keys
5. **Export your work** — Press `Cmd+E` for PNG export
6. **Toggle overlay mode** — Use the global hotkey `Ctrl+F` to summon/dismiss the transparent overlay

## Key Concepts

| Concept | What It Is |
|---------|-----------|
| **Canvas** | An infinite drawing surface — like a page. Each canvas is a separate `.design` file. You can have many canvases in a workspace. |
| **Element** | Anything you draw on a canvas — rectangles, circles, text, lines, frames. |
| **Frame** | A special element that acts as a container for other elements. Used for grouping, layout, and clipping. |
| **Workspace** | A folder on disk that contains your canvases, subfolders, and assets. |

**Canvas vs Frame:** A canvas is the page you draw on. A frame is an element on that page that holds other elements inside it — like a box within the page.

## Platforms & Offline Use

Brilliant runs on **macOS, Windows, and Linux**. Core design features work fully offline. AI chat features (multi-provider chat, natural language commands via Claude Code) require internet access when using API-based providers.

## What Brilliant Doesn't Have

If you're coming from Figma, Sketch, or Illustrator, these features are **not available** in Brilliant:

| Feature | Status | Alternative |
|---------|--------|-------------|
| Prototyping / interactions | Not available | Export frames as images for prototype tools |
| Real-time multiplayer editing | Not available | Share via Git (`.design` files are YAML with clean diffs) |
| Plugin / extension system | Not available | AI chat + MCP integration for automation |
| Version history panel | Not available | Use Git for version control |
| Constraints (pin to edges) | Not available | Use auto layout with hug/fill/fixed sizing |
| Image trace / vectorization | Not available | Vectorize in another tool, then import as SVG |
| Component variants | Not available | Use separate masters for each variant |
| Multi-key chord shortcuts | Not available | Use Combos (macros) for multi-action sequences |

## Coming From Legacy Brilliant (Bananoate)?

The new Flutter-based Brilliant replaces the older Swift overlay app. Key changes:

| Old (Swift) | New (Flutter) |
|-------------|---------------|
| Overlay-only mode | Dual mode: **Studio** (default window) + **Overlay** (Ctrl+F to toggle) |
| Global hotkey: `Ctrl+Shift+W` | Global hotkey: **`Ctrl+F`** |
| "Boards" | Now called **"Canvases"** |
| "Annotations" | Now called **"Elements"** |
| Basic shapes only | Frames, Auto Layout, Components, Design System, Shaders, Effects |

**Want overlay-only like before?** Minimize the Studio window, then use `Ctrl+F` to toggle overlay mode. The minimized window stays out of your way. In overlay mode, press `Cmd+\` to hide all UI for a clean transparent surface, and `Ctrl+A` for passthrough (clicks go through to apps below).

**Don't need the new features?** Frames, auto layout, components, and design tokens are all optional. You can draw shapes, lines, text, and annotate exactly like before.

## Platform Notes

Throughout this documentation:
- **Cmd** refers to the Command key on macOS, or the Ctrl key on Windows/Linux
- **Ctrl** refers to the Control key on all platforms
- **Alt** refers to the Option key on macOS, or the Alt key on Windows/Linux
