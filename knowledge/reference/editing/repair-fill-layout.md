---
name: "knowledge-editing-repair-fill-layout"
description: "The repair_fill_layout command: re-running auto layout on fill-sized children and unfreezing instance children, as one undo step."
assumes: reference/editing
---

# Editing: Repair Fill Layout

`repair_fill_layout` (palette or `execute_commands`) re-runs auto
layout on every frame that has a fill-sized child and heals any stale
geometry, on either axis, as ONE undoable step. Use it when fill children
render at the wrong size after opening an older file (for example, a divider
that should span its row). If everything is already laid out correctly, it
makes no changes and adds nothing to undo; the number it reports counts the
elements it repaired, so a clean file reports zero. Saving also flags
lingering fill problems in the background: that save-time check only looks at
cross-axis sizes and never blocks saving.

It also unfreezes component instance children whose fill/hug geometry was
mistakenly frozen against their master: a frozen mark is released only on
positive proof that the geometry is a pure layout result, and any genuinely
placed override (a move, resize, rotation, or flip, however small) keeps its
mark, as does an overridden text, which is never touched. Instances whose
master lives on ANOTHER canvas are included: the master canvas is looked up and
read, and an instance whose master cannot be reached (its canvas is missing, or
it comes from a library that is not available here) is skipped and reported as
skipped, never guessed at. All of it is folded into the same single undo step,
and the `execute_commands` response reports how many marks were released, how
many of those were on cross-canvas instances, and how many instances were
skipped.
