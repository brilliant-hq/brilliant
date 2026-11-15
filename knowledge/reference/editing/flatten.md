---
name: "knowledge-editing-flatten"
description: "Flatten (Cmd+Enter): baking a selection into one vector, the result per input, and platform limits."
assumes: reference/editing
---

# Editing: Flatten

| Action | Shortcut |
|--------|----------|
| Flatten | Cmd+Enter |

Converts the selection into a single vector element. Behavior depends on what is selected:

| Input | Result |
|-------|--------|
| Single primitive (rectangle, circle, line) | Convert to vector (lossless) |
| Single vector | No-op |
| Single text element | Outline to a single compound vector with per-character regions |
| Boolean union parent | Concatenate children's vector paths (lossless, per-child fills preserved as regions) |
| Group / frame | Concatenate children's vector paths (lossless, per-child fills) |
| Boolean subtract / intersect / exclude, or mask parent | Combine paths into the final shape only (fills not preserved per-child) |
| Multiple selected elements | Concatenate all as vector paths into one element |
| Text mixed with non-text in the selection | Texts auto-outline to vectors first, then everything is concatenated |

Flattening that involves **text outlining** requires native glyph extraction (CoreText on macOS, DirectWrite on Windows), so it is available on macOS and Windows but **not on Linux**. Flattening non-text selections works on all platforms.

Use Flatten to commit a boolean result, convert a primitive into editable vector geometry, or merge a frame's children into one path.
