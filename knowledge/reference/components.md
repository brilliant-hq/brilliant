---
name: "knowledge-components"
description: "Component system in Brilliant: masters, instances, overrides, syncing, and detaching."
---

# Components

Components let you create reusable design elements. A **master component** defines the source of truth, and **instances** are linked copies that stay in sync with the master while allowing per-instance overrides.

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
2. Press **Cmd+Alt+K** (or use the **Create Component** command via command palette, or right-click and choose **Component → Create Component**)
3. The selection becomes a master component

There is no separate Components panel or page in the left toolbar, and components are created from selection on the regular canvas: masters and instances are normal frames distinguished by their diamond icon and purple label. The right inspector does, however, show a contextual **Component** section when a component, set, variant, or instance is selected (see [Component Sets, Variants & Properties](#component-sets-variants--properties)).

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

## Creating an Instance

1. Select a master component
2. Use the **Create Instance** command (via command palette, or right-click and choose **Component → Create Instance**)
3. A linked copy appears offset 50px down and to the right of the master

**What happens:**
- A full copy of the master's contents is created
- The copy is linked back to the master (root to master, each child to its matching master child)
- The instance is automatically selected

You can also create instances at a specific position programmatically.

**Duplicate and copy-paste behavior:** Duplicating a component master (Cmd+D) creates an **instance**, not a second independent master. The same applies to copy-pasting a master -- the pasted result is an instance linked to the original master. Duplicating or pasting a component instance creates another instance linked to the same master.

## Component Sets, Variants & Properties

A **component set** is the Figma-style "variants" feature. Instead of one master, a set groups several **variants** of the same component (e.g. a button's default / hover / pressed looks) and organizes them along named **properties** (axes). Each property has a list of values, and every property-value combination maps to one variant. An **instance** of a set carries a **configuration** (one value per property) and displays the matching variant. To switch an instance's look, you flip its property dropdowns rather than swapping in a different element.

### Creating a set

1. Select two or more frames on the canvas (each becomes one variant)
2. Right-click and choose **Create Component Set** (also available in the command palette)
3. The frames are combined into a new set, one variant each

You can also grow a single component into a set later with **Add Variant** (see below).

### The Component inspector section

When a set, variant, or instance is selected, a **Component** section appears in the right inspector. It has three modes depending on what you have selected:

**Set selected.** The section header shows two buttons:
- **+ Add Property** -- adds a new property (axis). Name it in the row that appears; suggestions are Size, State, Type, and Variant.
- **+ Add Variant** -- adds another variant frame to the set.

Below the header, each property shows a row with its editable name and a **−** button to remove that property.

**Variant selected.** One dropdown per property lets you set THAT variant's value -- its coordinate within the set (e.g. State = on, Size = lg). If two variants end up with the same combination of values, a **"⚠ Multiple variants share the same property values"** warning appears so you can disambiguate them.

**Instance selected.** One dropdown per property lets you PICK the configuration -- i.e. flip the instance to a different variant (e.g. set State to on). The instance immediately re-renders as the matching variant. If the instance contains nested instances, their dropdowns are surfaced too, indented beneath the parent's.

### Using a set

1. Create an instance of the set (Create Instance, or duplicate / copy-paste an existing instance)
2. Select the instance
3. In the Component section, flip the property dropdowns to choose its variant

This is the "flip a switch to a state" workflow: one instance, reconfigured by picking values, with no need to detach or swap elements.

## Visual Indicators

### Canvas

| Visual | Meaning |
|--------|---------|
| Purple frame label | Element is a component master or instance root (labels of plain frames inside a component stay gray) |
| Purple selection chrome | Element is part of a component (master or instance) |
| `◆` prefix on the frame label | Component master only. Instances get the purple label color but NO diamond prefix on canvas; the master/instance distinction is shown in the layers panel icon, not the canvas label. |

### Layers Panel

| Icon | Meaning |
|------|---------|
| Filled diamond | Master component |
| Diamond outline | Component instance |

## Overrides

When you change a property on an instance or one of its children, that change is automatically tracked as an **override**. From then on, edits to the master no longer touch that property on this instance: your override wins and is preserved through future syncs. Override tracking is automatic; there is nothing to mark or confirm.

### What syncs, what doesn't

When you edit a master, those edits flow down to every instance **except where you've overridden**. Almost everything participates: fills, strokes, text content and styling, rotation, flips, shape geometry, corner radii, frame/layout properties, sizing mode, effects, opacity, circle arc/ring settings, aspect-ratio lock, and element-level design-system bindings.

A few things stay independent and do NOT flow from master to instances:
- **Blend mode** -- set it per instance if you need it to differ. (Changing blend mode on an instance is also not treated as an override.)
- **Shadow token reference, crop, and element-level opacity token** -- managed per element.
- **The instance's name** and a few root-only details -- renaming the master frame does not rename instances, though renaming a master's *child* does propagate to the matching child in each instance.

## Syncing

When you edit a master component, all instances update automatically:

- Non-overridden properties are copied from the master onto each instance child
- Overridden properties are left untouched on the instance
- Children you add to the master appear in every instance
- Children you remove from the master are removed from every instance
- Child ordering (z-order) is kept in step with the master

**Slot content** is the exception: a child designated as a slot is owned by the instance, so syncing never overwrites it.

### What You Cannot Do on an Instance

The structure of an instance is owned by its master, and Brilliant prevents instances from drifting structurally:

- You cannot drag elements into an instance to add new children -- the drop is rejected
- You cannot drag elements out of an instance to reparent them elsewhere
- Adding, removing, or reordering children must be done on the master, and it propagates to every instance
- The one exception is **slot content**: anything nested inside a slot is a normal drop target, because the instance owns it

If you need an instance to fully diverge from its master, **detach** it first.

## Resetting Overrides

To restore an instance to match its master:

1. Select a component instance
2. Use the **Reset Component Instance Overrides** command (via command palette, or right-click and choose **Component → Reset Overrides**)

**What happens:**
- All overrides on the instance are cleared
- The instance re-syncs from the master, pulling fresh values for every property
- The entire instance, including its children, is refreshed to match the master

## Detaching an Instance

To break the link between an instance and its master:

1. Select a component instance
2. Press **Cmd+Alt+B** (or use the **Detach Instance** command via command palette, or right-click and choose **Component → Detach Instance**)

**What happens:**
- The link to the master is removed from the frame and all its contents
- The frame becomes a regular frame with no component links
- Future changes to the master will not affect this frame
- The frame's content is preserved as-is

## Ungrouping a Component

When you ungroup a component frame, the component links are automatically cleaned up first:

- **Ungrouping a master component** detaches all instances of that master (making them regular frames), then removes the component status from the master, then ungroups the frame normally.
- **Ungrouping a component instance** detaches the instance first (breaking the link to the master), then ungroups the frame normally.

## Navigating to the Master

When you have an instance selected:

1. Use the **Go to Master Component** command (via command palette, or right-click and choose **Component → Go to Master**)
2. The master component is selected and the camera moves to center it

If the master lives on a different canvas, Brilliant switches to that canvas first, then selects and centers the master. The camera stays put when the master is already comfortably in view (so it won't jump when the master sits right next to the instance), and it never zooms in past 100% just to fill the screen with a small master (a large master zooms out enough to fit).

## Cross-Canvas Components

A master component can live on a different canvas than its instance. This lets you keep masters on a dedicated "components" canvas and use instances throughout the rest of your project.

How it works:

- An instance remembers which canvas its master lives on
- When you open the instance's canvas, Brilliant finds the master and syncs the instance to the latest master values
- Editing a master updates instances on every canvas you currently have open; instances on canvases you haven't opened pick up the latest values the next time you open them
- **Go to Master Component** works across canvases: it switches to the master's canvas when needed, then selects and centers the master. **Push Overrides to Master** only works when the master is on the canvas you're currently viewing, so switch to the master's canvas first to push to it.
- Pasting a master into a different canvas creates an instance that points back to the original master (the master is not duplicated)

**Caveats:**
- Deleting a master does not immediately detach instances on canvases you don't have open. Those instances are cleaned up the next time you open their canvas.
- If a canvas full of cross-canvas instances is the first thing you open in a session, those instances may not find their master yet. To be safe, open the master's canvas first, then the canvas that uses it.

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Create Component | **Cmd+Alt+K** |
| Detach Instance | **Cmd+Alt+B** |
| Create Component Set | Command palette / right-click (no default keybinding) |
| Create Instance | Command palette only (no default keybinding) |
| Reset Component Instance Overrides | Command palette only (no default keybinding) |
| Go to Master Component | Command palette only (no default keybinding) |
| Push Overrides to Master | Command palette only (no default keybinding) |

**Push Overrides to Master**: When you've made overrides on an instance that should become the new default, use this command (via command palette, or right-click and choose **Component → Push Overrides to Master**) to apply the instance's overrides back to the master component. All other instances will then sync to the updated master values. This command only works when the master is on the same canvas as the instance.

## What's Not Supported

Brilliant components are a master/instance system with property overrides, slots, component sets (variants), and cross-canvas references. The following Figma-style concepts are NOT currently in Brilliant:

- **Swap Instance.** There is no swap-instance UI or command. To switch an instance to a different master, detach it and create a fresh instance of the other master. (Within a component set, you don't swap -- you flip the instance's property dropdowns to pick a variant.)
- **Components panel / page.** There is no left-toolbar Components panel and no separate "Components" canvas type. Masters live as regular frames on a canvas; you can keep them on a dedicated canvas by convention and reference them across canvases. (A contextual Component section does appear in the right inspector when a component, set, variant, or instance is selected.)
- **Per-property override badges.** There is no chip or label that flags which individual property is overridden on an instance. The Component section shows property dropdowns for sets and instances, but it does not mark which properties you've overridden; the visible component chrome is the purple frame label and the diamond icon (filled = master, outline = instance).
- **Component descriptions or metadata** (no description field, no documentation popovers)
- **Component publishing / library export** (no separate library file format; masters live on canvases inside your project)
- **Component diff view** (no side-by-side master vs instance comparison UI)
- **Nested overrides exposed as instance properties** (overriding a nested instance child works, but there is no "exposed property" surface on the parent instance)

## Tips

- **Edit the master to update all instances.** Change colors, text, or layout on the master and all linked instances update automatically (respecting overrides).
- **Override strategically.** Only override what needs to differ per instance (e.g., text content, fill color). This keeps instances in sync for structural changes.
- **Use Reset Overrides to start fresh.** If an instance has drifted too far from the master, reset and re-apply only the overrides you need.
- **Detach before diverging completely.** If an instance needs to become fully independent, detach it first to avoid unexpected syncs.

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| Instance not updating when master changes | Property was overridden on the instance | Reset overrides, then re-apply only needed changes |
| Blend mode change on master not reaching instances | Blend mode stays independent per instance by design | Set blend mode on each instance individually, or detach if you need it managed separately |
| Cannot create component | No element selected, or the element is part of someone else's instance | Select elements outside any component instance, or select the instance root itself (it CAN be wrapped). Non-frames are auto-wrapped. |
| Cross-canvas instance lost its component link after reopening | The instance's canvas was opened before its master's canvas in this session | Open the master's canvas first, then the canvas that uses it |
| Push Overrides to Master does nothing | Master is on a different canvas than the instance | Switch to the master's canvas before invoking the command (Go to Master switches canvases for you) |
| Instance child not syncing | Child is a slot | Slots are owned by the instance; edit them directly |
| Cannot drop element into component instance | Instances can't take new children | Drop into a slot, or detach the instance first |

## Authoring Components via Blueprint

Components, instances, sets, variants, slots, and per-instance overrides can also be authored programmatically (the AI's blueprint path) rather than by hand on the canvas. The hand-driven flows above and the blueprint flows produce the same data: a master created in blueprint can be instanced and overridden by hand, and vice versa. For the blueprint authoring syntax (the component, instance, variant, slot, and override keywords and cross-canvas referencing), see the blueprint knowledge files. Do not author that syntax from this reference.

> **See also:** [frames.md](./frames.md) for parent types, auto layout, and nesting
> **See also:** [editing.md](./editing.md) for selection and navigation within component hierarchies
