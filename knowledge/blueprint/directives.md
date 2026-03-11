---
assumes: blueprint/core
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
replace(abc123) al(v,g(12),pad(20)) s(fill,hug) f[(#FFF)] rd(12) "New Card"
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
fr p(96,96) s(368,412) f[(#07111F)] rd(24) clip before(#widget) "Backdrop"
```
**Common pattern — background behind existing element:** Put `before(#ref)` on the new element's line, NOT on the existing element. The new element is created before (behind) the referenced sibling.

## Flat modify rule
```
WRONG (accidentally reparents #10 into #4):
#4 s(800,hug)
  #10 f[(#FF0000)]

RIGHT (modifies both independently):
#4 s(800,hug)
#10 f[(#FF0000)]
```
Only indent modify lines when you intentionally want to reparent. Never delete+recreate to move — reparenting preserves IDs and undo.
