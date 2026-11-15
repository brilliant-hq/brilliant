---
name: "knowledge-components-concepts"
description: "Component concepts (master, instance, override, slot, set, property, variant, configuration) and creating a component."
assumes: reference/components
---

# Component Concepts

## Concepts

| Term | Description |
|------|-------------|
| **Master component** | The original frame that defines the component. Changes to the master propagate to all instances. |
| **Instance** | A linked copy of a master. Inherits all properties from the master unless overridden. |
| **Override** | A property change on an instance that differs from the master. Overrides are preserved during sync. |
| **Slot** | A child inside a component whose subtree is fully owned by each instance (sync skips it). Slots can only be designated through blueprint authoring; there is no by-hand UI to mark an element as a slot. |
| **Component set** | A component that holds multiple **variants** organized by named **properties**. Figma-style "variants." An instance of a set shows whichever variant matches its current configuration. |
| **Property** | A named axis of a set (e.g. "State", "Size"), each with a list of possible **values** (e.g. on/off, sm/lg). |
| **Variant** | One member frame of a set, tagged with a value for each property (e.g. State=on, Size=lg). Each property-value combination maps to one variant. |
| **Configuration** | The set of chosen values (one per property) carried by an instance. The configuration selects which variant the instance displays. |

## Creating a Component

1. Select one or more elements on the canvas
2. Press **Cmd+Alt+K** (or use the **Create Component** command via palette, or right-click and choose **Component → Create Component**)
3. The selection becomes a master component

There is no separate Components panel or page in the left toolbar, and components are created from selection on the regular canvas: masters and instances are normal frames distinguished by their diamond icon and purple label. The right inspector does, however, show a contextual **Component** section when a component, set, variant, or instance is selected (see `reference/components/sets`).

**What happens:**
- The frame becomes the master (the source of truth for its instances)
- Every element inside it is linked to the matching child in future instances
- The frame label and selection chrome turn purple
- In the layers panel, a filled diamond icon marks the master

**Validation:** Selection is rejected if any selected element is a non-instance descendant of a component instance (you cannot wrap a child of someone else's instance into a new component). Existing component masters and component instance roots CAN be wrapped into a new outer component.

**Auto-wrapping behavior:**
- One non-frame element selected, or multiple elements selected: a wrapping frame is created at the combined bounds, the selection is reparented into it, and the frame is converted to a component master. The frame's name defaults to a unique `Component`/`Component 2`/etc.
- One plain frame selected: in-place conversion (no extra wrapper). The frame is marked as the master and its existing children become master children.
- The wrap path runs per-parent: selecting elements across multiple parents creates one component per parent group.
