---
assumes: design/foundations
dsl: [set_project_cover]
---

# Project covers

A cover is the image that represents a project on its tile and cards. It is a designed
artifact, not a screenshot. You design it as a normal frame and then set it as the cover.

## The flow

1. Work on a canvas named **Cover** at the project root. Create it if it does not exist —
   creation is a deliberate act, not a side effect: call `execute_commands` with
   `{commandId: "create_canvas", params: {fullPath: "Cover"}}` first, then target the new
   canvas (element-creation tools refuse a canvas that does not exist). If canvas creation
   is refused or unavailable, build the cover frame on the current canvas instead of
   stopping. Reuse the Cover canvas on later runs (edit the existing cover frame or build a
   new variant beside it so the user can compare). Never scatter cover frames across the
   user's working canvases.
2. Build the cover as a single frame, **1920×1080**. Surfaces crop covers from the center to
   fit their cards, so keep everything that matters well away from the edges: compose
   center-safe, and let backgrounds extend to the borders so any crop still looks composed.
3. Use the project's real content and real tokens: its components, its design system colors
   and type. The cover should look like it belongs to this project, because it does.
4. When the cover frame is done, set it with the `set_project_cover` command directly — do
   not ask for permission first; the user asked for a cover, and changing it back is one
   click. Then offer to iterate ("Want me to adjust anything?").
5. Ask clarifying questions up front only when the project is genuinely ambiguous. Usually
   the name and contents tell you enough; just design.

## Two registers

Decide which kind of cover this project needs:

**Project cover** — for the owner and their team. Its job is recognition: "which project is
this" at a glance among many tiles. Feature the project's identity: the name as the dominant
element, plus one strong identity device — a brand color, a cropped hero screen from the
actual design, a distinctive graphic. Keep metadata minimal.

**Library cover** — for a project that is (or will be) published as a library others depend
on. Its job is a storefront: a stranger deciding at a glance what is inside and whether it is
good. Feature the goods: the name as a lockup on one side, and a small number of the
library's real components at real fidelity — shown, not described. The components carry two
messages at once: what the kit contains and what its visual style is.

Which register applies:
- If the project is already marked as a library, use the library register. Do not ask.
- If it is not marked but the contents clearly look like a library (mostly component masters
  and variants, canvases organized like Atoms/Components/Buttons, a rich design system, few
  full app screens), ask ONE question: whether to design it as a library cover — and in the
  same question offer to mark the project as a library (`mark_project_as_library`). Respect
  the answer; the two halves are separable.
- Otherwise use the project register silently. Never ask when there is no signal.

## Fundamentals (both registers)

- **One dominant text element.** The project name, big enough to survive a tile a couple of
  hundred pixels wide. Everything else is subordinate to it.
- **Scan, not read.** Covers are recognized before they are read. No paragraphs, no fine
  print — small text disappears at tile scale. If you need metadata (a version, a category
  word), make it one or two short chips, not prose.
- **Edited density.** For a library cover, two to four components shown large beat a dump of
  the whole sticker sheet — a specimen dump shrinks everything below recognition. Claim
  breadth with words ("120+ components"), show depth with a few real pieces.
- **Honest by construction.** The cover must represent what is actually in the project. Show
  real frames and real components; never invent content the project does not have.
- **One background decision.** A solid brand color, a quiet gradient, or a light neutral —
  chosen deliberately and covering the whole frame. Legibility of the title over it is
  non-negotiable.

These are fundamentals, not a template. Within them, design freely in the project's own
style — a playful project earns a playful cover, a sober design system earns restraint.
