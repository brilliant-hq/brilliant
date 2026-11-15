---
name: "knowledge-components-instances"
description: "Creating an instance, duplicate and copy-paste behavior, and the canvas and layers indicators of masters and instances."
assumes: reference/components
---

# Instances and Indicators

## Creating an Instance

1. Select a master component
2. Use the **Create Instance** command (via palette, or right-click and choose **Component → Create Instance**)
3. A linked copy appears offset 50px down and to the right of the master

**What happens:**
- A full copy of the master's contents is created
- The copy is linked back to the master (root to master, each child to its matching master child)
- The instance is automatically selected

An instance is selected whole when you click it from outside; reach a layer inside it by double-clicking or by Cmd+clicking it.

You can also create instances at a specific position programmatically.

**Duplicate and copy-paste behavior:** Duplicating a component master (Cmd+D) creates an **instance**, not a second independent master. The same applies to copy-pasting a master -- the pasted result is an instance linked to the original master. Duplicating or pasting a component instance creates another instance linked to the same master, with its overrides kept. The same holds for Blueprint `clone()` of an instance.

**When a master is not there at open:** an instance whose master is not loaded yet (a library canvas still fetching, a component on an unopened canvas) keeps every row it stored. Rows the app cannot place yet sit under the instance as a hidden layer named `Held stored row` and are written back as they were; the next open that finds the master applies them. Nothing stored is dropped, and a stored `at()` value the master does not know is kept too.

## Visual Indicators

### Canvas

| Visual | Meaning |
|--------|---------|
| Purple frame label | Element is a component master, a variant or an instance root (labels of plain frames inside a component stay gray) |
| Purple selection chrome | Element is part of a component (master or instance) |
| Diamond glyph before the frame label | Four small diamonds: a component master (or a component set). One outline diamond: an instance. The glyph is the same one the layers panel shows. |

### Layers Panel

| Icon | Meaning |
|------|---------|
| Filled diamond | Master component |
| Diamond outline | Component instance |
| Switch (filled / outline) | An instance of a two-state **on/off component set** (a set whose single property has the two values `on` and `off`), drawn as a switch so it reads as a toggle instead of two near-duplicate variant layers. Filled = on, outline = off; hovering names it a switch. This is a display convention over an ordinary component instance, not a distinct property type and not a kind of slot (slots are the per-instance-owned children above). It is what a Figma boolean property imports as, and the same switch shows for any such on/off set however it was built, a Toggle with content in both states included. Only an on/off set whose off variant is empty or missing (the Figma boolean shape) leaves its auto layout flow when switched off and takes no space (the show/hide behavior `blueprint/components.md` describes); a Toggle stays in the flow. There is no separate "boolean property" in Brilliant today. |
