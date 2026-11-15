---
name: "knowledge-components-syncing"
description: "How master edits sync to instances, slot content, and what you cannot do on an instance."
assumes: reference/components
---

# Syncing

When you edit a master component, all instances update automatically:

- Non-overridden properties are copied from the master onto each instance child
- Overridden properties are left untouched on the instance
- Children you add to the master appear in every instance
- Children you remove from the master are removed from every instance
- Child ordering (z-order) is kept in step with the master

**Slot content** follows its master until the instance changes it: an edit of the content in a master's slot (a glyph replaced, an item added) reaches every instance whose slot still shows the master's content, and a slot whose content the instance replaced, removed or reordered keeps its own, so syncing never overwrites it.

## What You Cannot Do on an Instance

The structure of an instance is owned by its master, and Brilliant prevents instances from drifting structurally:

- You cannot drag elements into an instance to add new children -- the drop is rejected
- You cannot drag elements out of an instance to reparent them elsewhere
- Adding, removing, or reordering children must be done on the master, and it propagates to every instance
- The one exception is **slot content**, but only for CREATION: new content can land inside a slot subtree, while an EXISTING element cannot be reparented into a slot or anywhere else in an instance interior. A drag drop is rejected, and an AI modify halts at that line and deletes nothing. To put content into a slot, create it there or detach the instance first

If you need an instance to fully diverge from its master, **detach** it first.
