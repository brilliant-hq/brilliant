---
name: "knowledge-components"
description: "Component system in Brilliant: masters, instances, overrides, syncing, and detaching."
---

> **Parent skill:** [knowledge/SKILL.md](./SKILL.md)

# Components

Components let you create reusable design elements. A **master component** defines the source of truth, and **instances** are linked copies that stay in sync with the master while allowing per-instance overrides.

## Concepts

| Term | Description |
|------|-------------|
| **Master component** | The original frame that defines the component. Changes to the master propagate to all instances. |
| **Instance** | A linked copy of a master. Inherits all properties from the master unless overridden. |
| **Override** | A property change on an instance that differs from the master. Overrides are preserved during sync. |
| **Slot** | A child inside an instance whose subtree is fully owned by the instance (sync skips it). |

## Creating a Component

1. Select one or more elements on the canvas
2. Press **Cmd+Alt+K** (or use the **Create Component** command via command palette, or right-click and choose **Component → Create Component**)
3. The selection becomes a master component

There is no dedicated component button in the right toolbar inspector and no separate components page or panel in the left toolbar. Components are created from selection on the regular canvas; masters and instances are normal frames distinguished by their diamond icon, purple label, and component data.

**What happens:**
- The frame gains a `ComponentData` marker (no `elementRef` means it is the master)
- All descendant elements get `ChildComponentData` linking them back to the master's children
- The frame label and selection chrome use a purple component color
- In the layers panel, a filled diamond icon marks the master

**Validation:** Selection is rejected if any selected element is a non-instance descendant of a component instance (you cannot wrap a child of someone else's instance into a new component). Existing component masters and component instance roots CAN be wrapped into a new outer component.

**Auto-wrapping behavior:**
- One non-frame element selected, or multiple elements selected: a wrapping frame is created at the combined bounds, the selection is reparented into it, and the frame is converted to a component master. The frame's name defaults to a unique `Component`/`Component 2`/etc.
- One plain frame selected: in-place conversion (no extra wrapper). The frame is marked as the master and its existing children become master children.
- The wrap path runs per-parent: selecting elements across multiple parents creates one component per parent group.

## Creating an Instance

1. Select a master component
2. Use the **Create Instance** command (via command palette, or right-click and choose **Component → Create Instance**)
3. A linked copy appears offset 50px down and right from the master

**What happens:**
- A deep copy of the master's subtree is created with new element IDs
- The instance root has `ComponentData` with `elementRef` pointing to the master
- Each child has `ChildComponentData` linking to the corresponding master child
- The instance is automatically selected

You can also create instances at a specific position programmatically.

**Duplicate and copy-paste behavior:** Duplicating a component master (Cmd+D) creates an **instance**, not a second independent master. The same applies to copy-pasting a master -- the pasted result is an instance linked to the original master. Duplicating or pasting a component instance creates another instance linked to the same master.

## Visual Indicators

### Canvas

| Visual | Meaning |
|--------|---------|
| Purple frame label | Element is a component master or instance root |
| Purple selection chrome | Element is part of a component (master or instance) |
| Diamond glyph in frame label | Master vs instance distinguished by fill (filled = master, outlined = instance) |

### Layers Panel

| Icon | Meaning |
|------|---------|
| Filled diamond | Master component |
| Diamond outline | Component instance |

## Overrides

When you modify a property on an instance or its children, that property is automatically tracked as an **override**. Overrides are preserved when the master changes -- the sync engine skips overridden properties.

### Tracked Property Categories

| Category | What It Covers |
|----------|---------------|
| `fills` | Fill colors, gradients, images |
| `strokes` | Stroke colors, widths, positions |
| `textData` | Text content, font, size, weight |
| `rotation` | Element rotation angle |
| `isFlippedH` | Horizontal flip state |
| `isFlippedV` | Vertical flip state |
| `vectorPath` | Shape geometry (nodes, edges, handles) |
| `rectangleData` | Rectangle-specific properties (corner radii) |
| `parentData` | Frame properties (layout direction, spacing, padding) |
| `layoutBehavior` | Sizing mode (hug/fill/fixed) |
| `name` | Element name |
| `effects` | Drop shadow, outer glow, element blur |
| `opacity` | Element opacity |
| `circleData` | Circle arc/ring properties |
| `constrainProportions` | Aspect ratio lock |

**Root vs child sync:** The sync engine treats instance roots differently from instance children. Instance **children** sync all 15 categories listed above plus the element `type` (structural, always copied). Instance **roots** sync a smaller subset: `name`, `textData`, `rectangleData`, `vectorPath`, and `type` are NOT synced for the root frame. Renaming a master frame does not propagate the name to instance roots, but renaming a master's child does propagate to instance children. All other categories (fills, strokes, parentData, layoutBehavior, rotation, flips, effects, opacity, circleData, constrainProportions) sync for both roots and children.

**Unsynced properties:** `blendMode`, `opacityTokenRef` (element-level), `shadowTokenRef`, and `cropData` are not part of the component sync engine. Changes to these on the master do not propagate to instances. `blendMode` is also not tracked for override detection, so changing it on an instance does not register as an override. (Per-fill/per-stroke `opacityTokenRef` IS synced indirectly via the `fills` and `strokes` categories.)

### How Override Detection Works

Override detection is automatic. When you update an element that is part of an instance:
- The system compares the old and new values
- Changed property categories are added to the element's `overriddenProperties` set
- During sync, these categories are skipped

Override detection is suppressed during undo/redo restores and during sync itself to avoid false positives.

## Syncing

When you edit a master component, all instances automatically sync:

1. The sync engine walks the master's subtree
2. For each master child, it finds the corresponding instance child via `elementRef`
3. Non-overridden properties are copied from master to instance
4. Overridden properties are preserved on the instance
5. New children added to the master are deep-copied into instances
6. Children removed from the master are removed from instances
7. Z-order (child ordering) is synced to match the master

**Slot children** (marked with `isSlot: true`) are skipped entirely during sync -- the instance fully owns their content.

### What You Cannot Do on an Instance

The structure of an instance is owned by its master. Brilliant prevents structural drift on instances:

- You cannot drag elements into a component instance to add new children. The drop target is rejected during drag
- You cannot drag elements out of an instance to reparent them somewhere else
- New structural changes (add/remove children, reorder) must happen on the master and propagate via sync
- The one exception is **slot subtrees**: any element nested at any depth inside a `slot`-marked child IS a normal target for adds and reparents. Slot content is owned by the instance

If you need to fully diverge from the master, **detach** the instance first.

## Resetting Overrides

To restore an instance to match its master:

1. Select a component instance root (the command's WhenClause activates only on instance roots)
2. Use the **Reset Component Instance Overrides** command (via command palette)

**What happens:**
- All `overriddenProperties` are cleared on the targeted elements
- The instance re-syncs from the master, pulling fresh values for all properties
- If you reset on the instance root, the entire subtree's overrides are cleared and re-synced
- If you target an individual instance child (via MCP / programmatic invocation that includes both root and child), that child's overrides are cleared and the full instance re-syncs from the master. The whole instance subtree is refreshed, not just the reset child.

**Keyboard vs MCP gap:** The command's WhenClause is `componentInstanceWhen` (instance roots only), so the keyboard/palette path requires an instance root to be selected. The execute body, however, accepts both instance roots and instance children, which is why MCP invocations can target individual children.

## Detaching an Instance

To break the link between an instance and its master:

1. Select a component instance
2. Press **Cmd+Alt+B** (or use the **Detach Instance** command via command palette, or right-click and choose **Component → Detach Instance**)

**What happens:**
- `ComponentData` is removed from the instance root
- `ChildComponentData` is removed from all descendant elements
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
2. The master component is selected on the canvas

This works when the master is on the same canvas. The selection jumps to the master element.

## Cross-Canvas Components

A master component can live on a different canvas than its instance. This lets you keep masters on a dedicated "components" canvas and use instances throughout the rest of your project.

How it works:

- An instance stores a `canvasPath` (relative path to the master's `.design` file) on its `componentData` when the master lives elsewhere
- When the instance's canvas is loaded, Brilliant resolves the cross-canvas master and syncs the instance with the latest master values
- Editing a master propagates to instances on every currently loaded canvas; instances on canvases not in the cache pick up the latest master values the next time their canvas loads
- **Push Overrides to Master** and **Go to Master Component** only work when the master is resolvable on the current canvas's `CanvasElements` (same-canvas only). Switch to the master's canvas first to push or jump to it.
- Pasting a component master into a different canvas creates an instance whose `canvasPath` points back to the source canvas (the master is not duplicated)

**Caveats:**
- When you delete a master, instances on other canvases that are not currently loaded are NOT detached immediately. They are cleaned up the next time that canvas loads.
- Cross-canvas instances can be incorrectly stripped of their component link by a bug in orphan cleanup that ignores `canvasPath`. If a canvas containing instances opens before the master's canvas has been loaded into the cache, those instances may get detached. Workaround: open the master's canvas first to populate the cache.

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Create Component | **Cmd+Alt+K** |
| Detach Instance | **Cmd+Alt+B** |
| Create Instance | Command palette only (no default keybinding) |
| Reset Component Instance Overrides | Command palette only (no default keybinding) |
| Go to Master Component | Command palette only (no default keybinding) |
| Push Overrides to Master | Command palette only (no default keybinding) |

**Push Overrides to Master**: When you've made overrides on an instance that should become the new default, use this command to apply the instance's overrides back to the master component. All other instances will then sync to the updated master values. This command only works when the master is on the same canvas as the instance.

## What's Not Supported

Brilliant components are a master/instance system with property overrides, slots, and cross-canvas references. The following Figma-style concepts are NOT currently in Brilliant:

- **Swap Instance.** There is no swap-instance UI or command. To switch an instance to a different master, detach and recreate, or edit the blueprint to change `inst(#ref)`.
- **Components panel / page.** There is no left-toolbar Components panel and no separate "Components" canvas type. Masters live as regular frames on a canvas; you can keep them on a dedicated canvas by convention and reference them across canvases.
- **Per-property override badges in the inspector.** There is no inspector chip or label that flags which individual property is overridden. Overrides are tracked internally and used by sync, but the only visible component chrome is the purple frame label and the diamond icon (filled = master, outline = instance).
- **Component variants / props** (no boolean props, enum variants, or variant matrices). Instead, create separate master components or rely on overrides
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
| `blendMode` change on master not reaching instances | `blendMode` is unsynced by design | Set blend mode on each instance individually, or detach if you need divergent blend behavior managed manually |
| Cannot create component | No element selected, or element is a non-instance descendant of a component instance | Select elements outside any component instance, or select the instance root itself (it CAN be wrapped). Non-parents are auto-wrapped. |
| Cross-canvas instance lost its component link after canvas reload | Orphan cleanup bug strips component data when master's canvas is not cached | Open the master's canvas first, then the instance canvas |
| Push Overrides / Go to Master grayed out | Master is on a different canvas than the instance | Switch to the master's canvas before invoking the command |
| Instance child not syncing | Child is marked as a slot | Slots are owned by the instance; edit directly |
| Cannot drop element into component instance | Reparent guard rejects the drop | Drop into a `slot`-marked subtree, or detach the instance first |

## Creating Components via Blueprint

Components and instances can be created in blueprint syntax using the `comp`, `inst(#ref)`, and `slot` keywords.

### Component Master

Add the `comp` bare flag to create a component master:

```
al(h,x(c),y(c),g($spacing.2),pad($spacing.3,$spacing.6)) s(hug,hug) f[(#F1F5F9),(f2,inner(#000,o(0.06),x(2),y(2),blur(4))),(f3,inner(#FFF,o(0.5),x(-1),y(-1),blur(2)))] rd(10) shadow(#000,o(0.04),y(1),blur(2)) shadow(#000,o(0.08),y(4),blur(12)) comp #btn "Button"
  svg(icon:sparkle) s(16,16) f[(#374151)] "Icon" #btn_icon
  t("Get Started",Inter,14,sb) f[(#1E293B)] "Label" #btn_label
```

**What happens:**
- The frame is created with all its children
- `createComponentFromFrame()` is called to establish it as a master
- Children marked with `slot` get `isSlot: true` on their `ChildComponentData`

### Component Instance

Use `inst(#ref)` to create an instance of an existing component master. Override children by `#ref`:

```
inst(#btn) p(300,100) f[(#E0E7FF),(f2,inner(#000,o(0.06),x(2),y(2),blur(4))),(f3,inner(#FFF,o(0.5),x(-1),y(-1),blur(2)))]
  override(#btn_icon) svg(icon:rocket) f[(#4338CA)]
  override(#btn_label) t("Launch") f[(#312E81)]
```

**What happens:**
- The system finds the component master by ID (or name)
- A linked instance is created at the specified position
- Indented children are treated as overrides:
  - Named children match against the instance's existing children by name
  - Property changes are applied as overrides
  - Slot children can have new content injected

### Cross-Canvas Instances in Blueprint

To create an instance of a master that lives on a different canvas, pass the canvas path as a second argument with `canvas(...)`:

```
inst(#btn, canvas(components.design)) p(300,100)
  override(#btn_label) t("Launch")
```

The path is relative to the current canvas's location in the project.

### Slots

Mark a child with the `slot` bare flag to designate it as instance-owned content:

```
al(v,g($spacing.4),pad($spacing.6)) s(320,hug) f[(#FFFFFF)] rd($radius.md) comp #card "Card"
  t("Card Title",Inter,20,b) s(fill,hug) f[(#0F172A)] "Header"
  fr s(fill,hug) slot "Content"
```

Slot children are skipped during sync: instances fully own their slot content. This allows each instance to have completely different content in the slot area while keeping the rest of the component in sync with the master.

> **See also:** [knowledge/FRAMES.md](./FRAMES.md) for parent types, auto layout, and nesting
> **See also:** [knowledge/EDITING.md](./EDITING.md) for selection and navigation within component hierarchies
