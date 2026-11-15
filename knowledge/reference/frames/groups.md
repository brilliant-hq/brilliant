---
name: "knowledge-frames-groups"
description: "Groups: creating with Cmd+G, always-Hug sizing, ungrouping, editing inside, and group properties."
assumes: reference/frames
---

# Groups

## Creating a Group

1. Select 2+ elements
2. Press **Cmd+G**
3. A Group parent wraps the selection (one group per source parent: per-parent grouping). However many parents the selection spans, the whole act is **one undo step**: one Cmd+Z removes every group it made.

**Group properties at creation:**
- Hug on both axes (forced)
- Clip content off, no fill, no stroke
- Z-order: inserted at the backmost selected element's position

## Sizing

Groups are **always Hug on both axes** (auto-resize to fit children). **Changing sizing from Hug on either axis auto-converts the group to a Frame.**

**A group is a transparent wrapper.** Grouping keeps each child's own sizing and absolute position: a child that was **Fill** inside an auto layout frame stays Fill, and an **absolute** child stays absolute. Inside the group both are dormant (the child keeps the box it had and the group simply hugs it). **Ungroup** inside an auto layout frame puts the children back with Fill and absolute position as they were, so group then ungroup changes nothing there. Ungrouping into a plain frame or onto the canvas keeps every child's size: Fill becomes Fixed at its current size and absolute position is cleared (they only mean something in auto layout). Converting the group to a Frame (or another container type) applies that container's rules: a Fill child becomes Fixed at its current size and absolute position is cleared.

## Ungrouping (Cmd+Shift+G)

| Action | Effect |
|--------|--------|
| Cmd+Shift+G, right-click → Ungroup, or palette | Reparent children to group's parent, transform coordinates, delete group, preserve z-order |

If the group is a component master, its component relationship is cleaned up first. If it's an instance, it is detached first. If the group's parent is auto layout, the parent re-layouts.

## Editing Inside a Group

1. Click the group's label to select it
2. Press **Enter** to drill in (selects first child)
3. Click children individually
4. Press **Shift+Enter** to select the parent (go up)

## Group Properties

- **Fill** (Shift+F), **Stroke** (Shift+S), **Corner radius**, **Effects**
- **Clip content** off by default
- **Sizing**: always Hug (changing it converts the group to a Frame)
- **Rename**: Cmd+R, or double-click the group label on canvas
