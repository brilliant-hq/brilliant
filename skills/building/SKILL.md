---
name: "building-patterns"
description: "Design building toolkit: 55+ component recipes, layout rules & decisions, visual techniques, and routing to sub-skills."
---

# Building Patterns

Structural recipes for building designs. These are **ingredients** — not templates to copy verbatim.

> **Every design you build should be a brand new, tailored composition.** The recipes below use Inter + Slate as a neutral baseline so the structure is clear. Your job is to reinvent everything else: swap the font pairing, choose a color palette that matches the request, rearrange the layout, combine ideas from different examples. If two designs look the same because they both copied a recipe unchanged, that's a failure. The structure is the lesson — the personality is yours to create.

> **ALL ICONS = SVGs. Never create `vector` elements for icons. Never use emoji as icons.** Use `svg(icon:name)` for 1,500+ bundled Phosphor icons (no download needed). For brand logos: **Wikimedia Commons first** (WebSearch `"{brand} logo site:commons.wikimedia.org filetype:svg"` for exact filename, then `svg(https://commons.wikimedia.org/wiki/Special:Redirect/file/{Filename}.svg)`). For monochrome brand glyphs: Simple Icons (`svg(https://unpkg.com/simple-icons@latest/icons/{slug}.svg)`). For flags: `svg(https://commons.wikimedia.org/wiki/Special:Redirect/file/Flag_of_{Country}.svg)`. Place SVGs inside icon box frames: `{id} svg(icon:gear) s(20,20) st[(s1,#3B82F6,2)] "Icon"`. The `vector` type is ONLY for sparklines and charts. If a specific icon isn't available, use a simple geometric text character (`"+"`, `"x"`, `"->"`, `"*"`) as a temporary stand-in — never emoji.

### Bundled Icons — Full Phosphor Library (1,500+ icons)

All **Phosphor regular-weight** icons are bundled. Use `svg(icon:name)` with kebab-case names (e.g., `cloud-rain`, `arrow-clockwise`, `shield-check`). Browse the full catalog at [phosphoricons.com](https://phosphoricons.com). Never invent icon names — if it's not a real Phosphor icon, it won't render.
