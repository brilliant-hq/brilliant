---
name: "knowledge-shaders"
description: "Shader fills and strokes: animated, GPU-rendered procedural effects (metaballs, liquid metal, iridescent, dithering) applied to elements in Brilliant."
---

# Shader Fills & Strokes

Shaders are animated, GPU-rendered procedural effects applied to any element as a **fill or stroke**. They produce looks like organic blob merging, liquid metal, holographic iridescence, brushed steel, and retro dithering.

Shaders live in the same "type" slot as solid colors, gradients, and image fills: any fill or stroke row can be switched to a shader type. Multiple shaders can run independently on different elements.

Text elements support shader fills (the pattern renders through the glyphs, like a gradient fill). Text *ranges* (individual character runs) are restricted to solid colors only, so switching a range to a shader is not offered.

- `reference/shaders/adding`: adding a shader as a fill or stroke, the five shader types
- `reference/shaders/parameters`: per-shader parameters, element-aware shapes, presets
- `reference/shaders/colors-transform`: shader colors, the Transform section, Cmd-resize compensation
- `reference/shaders/animation-export`: animation, combining with other fills, export behavior

## Authoring shaders programmatically

This file covers operating shaders by hand in the inspector. For Blueprint DSL syntax to create or modify shader fills programmatically, see the blueprint shader knowledge files (`blueprint/shaders/*`). Do not author shader syntax from this reference.
