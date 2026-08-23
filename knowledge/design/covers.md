---
assumes: design/foundations
dsl: [set_project_cover]
---

# Project covers

A cover is the image on a project's tile and cards: a designed artifact you build as a
normal frame and then set with `set_project_cover`.

## The flow

1. Work on a canvas named **Cover** at the project root. If it does not exist, create it
   deliberately first (`execute_commands` with `{commandId: "create_canvas", params:
   {fullPath: "Cover"}}`), then target it — element tools refuse a canvas that does not
   exist. If canvas creation is unavailable, build on the current canvas. Reuse the Cover
   canvas on later runs so cover frames never scatter across working canvases.
2. One frame, **1920×1080**. Cards crop from the center: keep everything that matters away
   from the edges, and let the background run to the borders so any crop still composes.
3. Do not ask questions first — read the project and design. When the frame is done, set it
   as the cover immediately (no permission ask; changing it back is one click), then offer
   to iterate.

## The project is the art direction

Before designing, study the actual canvases: their palette, type, backgrounds, spacing,
mood. The cover should read as a frame FROM this project, never as generic cover art laid
over it. Pull the background and colors from what the project already does — a light, airy
project gets a light, airy cover. THE TEST: if your cover would look roughly the same for a
different project, you have defaulted to a house style; start over from the project's own
look. There is no standard layout — a centered wordmark, a cropped hero screen, a diagonal
strip of components, a full-bleed pattern of the project's own shapes are all valid when the
project suggests them.

## Two jobs

**Project cover** — recognition among the owner's tiles: the name plus one strong identity
device taken from the project (its hero screen, its brand color, its signature graphic).

**Library cover** — a storefront for a project others will depend on (component libraries,
UI kits, design systems): show a few real components at real fidelity, so a stranger sees
what is inside and its visual register at a glance. Decide which job applies from the flag
and the contents (marked as a library, or clearly a kit: mostly masters and variants, few
app screens) — never ask up front. If it is clearly a library but not marked as one,
mention at the END that you can mark it (`mark_project_as_library`): an offer beside the
finished work, not a question that blocks it.

## Fundamentals

- The name dominates, and must survive a tile a couple hundred pixels wide; everything else
  is subordinate.
- Scan, not read: no paragraphs, no fine print; at most a chip or two of metadata.
- Edited density: two to four components shown large beat a specimen dump — claim breadth in
  words, show depth with a few real pieces.
- Honest by construction: real frames, real components, nothing the project does not
  contain.
