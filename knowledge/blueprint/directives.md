---
assumes: blueprint/core
dsl: [parent, before, after, clone, replace, ungroup]
---
# Blueprint Directives

## `parent(targetId)` — create/move inside a specific parent (overrides indentation)
```
t("Title",Inter,20,b) parent(#card) f[(#0F172A)] "Title"        ← create inside #card
#body parent(#other_card)                                         ← reparent existing element
```
Children indented below a `parent()` line still nest under it. Use for batch-creating children across multiple parents without deep nesting.

## `clone(sourceId)` — independent deep copy, no link to original
```
clone(abc123) p(400,0) "Card — Dark"
  def456 f[(#1E293B)]                      ← override child by ID
  override(#title) f[(#F8FAFC)]            ← override child by ref
```

## `replace(elementId)` — delete old, insert new at same position
```
replace(abc123) al(v,g($spacing.3),pad($spacing.4)) s(fill,hug) f[(#FFF)] rd($radius.md) "New Card"
```

## `delete(elementId)` — remove an element and its children
```
delete(abc123)                               ← delete by ID
delete(#card)                                ← delete by session ref
```
Can be mixed with create/modify lines in the same call.

## `ungroup(elementId)` — dissolve a group/frame, reparent children up
```
ungroup(abc123)                              ← ungroup by ID
ungroup(#card)                               ← ungroup by session ref
```
Children move to the group's parent, coordinates transform to parent space, z-order preserved. Can be mixed with other lines.

## `before(siblingId)` — position before a sibling (reorder or reparent + position)
Elements render in z-order: earlier = behind, later = in front. `before()` inserts or moves an element before a sibling — i.e. behind it visually.
```
abc123 before(def456)                       ← move existing element before sibling

# Insert a backdrop BEHIND an existing widget (new element renders first = behind):
fr p(96,96) s(368,412) f[(#07111F)] rd($radius.xl) clip before(#widget) "Backdrop"
```
**Common pattern — background behind existing element:** Put `before(#ref)` on the new element's line, NOT on the existing element. The new element is created before (behind) the referenced sibling.

## Reparent with `parent()`

Use `parent()` to move elements. Never indent modify lines — indentation changes the parent.
```
#badge parent(#glass_card)
#title parent(#glass_card)
#cta_row parent(#glass_card)
```

## Flat modify rule

Modify lines are **always flat** — one line per element, no indentation. Indenting a modify line under another element reparents it, which breaks layout.
```
WRONG (reparents children out of their nested containers):
#card f[(#FF0000)]
  #avatar_icon f[(#FFF)]
  #name f[(#FFF)]

RIGHT (modifies each element independently):
#card f[(#FF0000)]
#avatar_icon f[(#FFF)]
#name f[(#FFF)]
```

A line **without** an ID/ref is always a **create** — indenting it under a parent adds a new child, never replaces an existing one.
```
WRONG (creates a DUPLICATE icon — no ID/ref so it's a create):
#statsRow
  svg(icon:wind) s(16,16) f[(#7DD3FC)]

RIGHT (modifies the existing icon by ref):
#windIcon f[(#7DD3FC)]
```
Never delete+recreate to move — reparenting preserves IDs and undo.
