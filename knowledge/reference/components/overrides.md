---
name: "knowledge-components-overrides"
description: "Overrides on instances, what syncs from the master and what stays independent, and resetting overrides."
assumes: reference/components
---

# Overrides

## Overrides

When you change a property on an instance or one of its children, that change is automatically tracked as an **override**. From then on, edits to the master no longer touch that property on this instance: your override wins and is preserved through future syncs,
including on a child of a nested instance whose value the enclosing component sets (an icon color inside a button instance keeps your color through master edits, variant switches and reopening). Override tracking is automatic; there is nothing to mark or confirm.

### What syncs, what doesn't

When you edit a master, those edits flow down to every instance **except where you've overridden**. Almost everything participates: size, fills, strokes, text content and styling, rotation, flips, shape geometry, corner radii, frame/layout properties, sizing mode, effects, opacity, circle arc/ring settings, aspect-ratio lock, and element-level design-system bindings. A nested component the master swaps for another is swapped in every instance that still showed the old one.

**Size.** An instance you never resized follows the master's size: make the master narrower and every untouched instance narrows with it, staying where it is. An instance you resized keeps its size (that is a size override, like any other) and its children stay where their pins put them. A hug axis follows its content, and a fill axis inside an auto layout follows the layout, on the master and the instance alike. Hug is an auto layout sizing: an instance of a master that is not auto layout cannot hug (as in Figma, it offers a fixed size only), so `s(W,hug)` on such an instance keeps its box on the hug axis and the answer says so; size it with a number, or give the master `al()`. Reset overrides makes a resized instance follow the master's size again; Push overrides makes the master take the instance's size. A library update follows the same law; the update review names a kept size as "Size override" (`reference/libraries/updating`).

A few things stay independent and do NOT flow from master to instances:
- **Blend mode** -- set it per instance if you need it to differ. (Changing blend mode on an instance is also not treated as an override.)
- **Shadow token reference, crop, and element-level opacity token** -- managed per element.
- **The instance's name** and a few root-only details -- renaming the master frame does not rename instances, though renaming a master's *child* does propagate to the matching child in each instance.

**Deleting a master child drops its overrides.** An override lives on the master child it targets, so deleting that child from the master removes it from every instance, overrides included (as in Figma). An agent's delete names how many copies lost overrides on each canvas; undo the delete to get them back, or re-add the child and override it again.

## Resetting Overrides

To restore an instance to match its master:

1. Select a component instance
2. Use the **Reset Component Instance Overrides** command (via palette, or right-click and choose **Component → Reset Overrides**)

**In the new interface, the inspector shows what you overrode.** Select an instance and the Instance section's header reads its name and how many overrides it holds ("Card · 3 overrides"; just "Card" when it has none; a library instance reads "UI Kit 1.2 · 1 override"). Beside the header's **…** button sits **Reset all** (the counter-clockwise arrow): it resets every override on the selected instances and is greyed out while there is nothing to reset. In the **…** menu, **Reset overrides** and **Push overrides to main** are greyed out the same way. A nested instance whose variant you switched (a Size you set to Large where the main component uses Small) shows that arrow at the end of its property row, with the tooltip "Reset Size": press it to put back the main component's value, one undo step. Choosing a variant on an instance you placed yourself is not an override, so those rows never show it. With several instances selected the header reads "2 selected", and **Reset all** works while any of them holds an override.

**What happens:**
- All overrides on the instance are cleared
- The instance re-syncs from the master, pulling fresh values for every property
- The entire instance, including its children, is refreshed to match the master
