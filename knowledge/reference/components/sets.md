---
name: "knowledge-components-sets"
description: "Component sets: variants, properties, the Component inspector section, and using a set."
assumes: reference/components
---

# Component Sets, Variants & Properties

A **component set** is the Figma-style "variants" feature. Instead of one master, a set groups several **variants** of the same component (e.g. a button's default / hover / pressed looks) and organizes them along named **properties** (axes). Each property has a list of values, and every property-value combination maps to one variant. An **instance** of a set carries a **configuration** (one value per property) and displays the matching variant. To switch an instance's look, you flip its property dropdowns rather than swapping in a different element.

## Creating a set

1. Select two or more frames on the canvas (each becomes one variant)
2. Right-click and choose **Create Component Set** (also available in the palette)
3. The frames are combined into a new set, one variant each

You can also grow a single component into a set later with **Add Variant** or **Add Property** (see below): the component becomes the set's first variant (named like `Property 1=Default`), keeps its name on the set, and every instance keeps showing it.

## The Component inspector section

When a set, variant, or instance is selected, a **Component** section appears in the right inspector. It has three modes depending on what you have selected:

**Set selected.** The section header shows two buttons:
- **+ Add Property** -- adds a new property (axis). Name it in the row that appears; suggestions are Size, State, Type, and Variant.
- **+ Add Variant** -- adds another variant frame to the set.

Below the header, each property shows a row with its editable name and a **−** button to remove that property.

**Variant selected.** One dropdown per property lets you set THAT variant's value -- its coordinate within the set (e.g. State = on, Size = lg). If two variants end up with the same combination of values, a **"⚠ Multiple variants share the same property values"** warning appears so you can disambiguate them.

**Instance selected.** One dropdown per property lets you PICK the configuration -- i.e. flip the instance to a different variant (e.g. set State to on). The instance immediately re-renders as the matching variant. If the instance contains nested instances, their dropdowns are surfaced too, indented beneath the parent's.

## Using a set

1. Create an instance of the set (Create Instance, or duplicate / copy-paste an existing instance)
2. Select the instance
3. In the Component section, flip the property dropdowns to choose its variant

This is the "flip a switch to a state" workflow: one instance, reconfigured by picking values, with no need to detach or swap elements.
