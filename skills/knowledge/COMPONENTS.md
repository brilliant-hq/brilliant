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

1. Select a frame on the canvas
2. Use the **Create Component** command (via command palette)
3. The frame becomes a master component

**What happens:**
- The frame gains a `ComponentData` marker (no `elementRef` means it is the master)
- All descendant elements get `ChildComponentData` linking them back to the master's children
- The frame label turns **purple** on the canvas
- In the layers panel, a **diamond outline** icon appears

**Auto-wrapping:** If the selected element is not already a parent, it will be automatically wrapped in a frame before becoming a component. Multiple selected elements are also wrapped together. You don't need to manually group first.

## Creating an Instance

1. Select a master component
2. Use the **Create Instance** command (via command palette)
3. A linked copy appears offset 50px from the master

**What happens:**
- A deep copy of the master's subtree is created with new element IDs
- The instance root has `ComponentData` with `elementRef` pointing to the master
- Each child has `ChildComponentData` linking to the corresponding master child
- The instance is automatically selected

You can also create instances at a specific position programmatically.

## Visual Indicators

### Canvas

| Visual | Meaning |
|--------|---------|
| **Purple label text** | Element is a component master or instance root |
| **Purple selection outline** | Element is part of a component (master or instance) |
| **Diamond prefix** on label | Master component (filled diamond on canvas) |

### Layers Panel

| Icon | Meaning |
|------|---------|
| **Diamond outline** | Master component |
| **Filled diamond** | Component instance |

Both diamond icons use a purple color (`#9B59B6`).

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

**Unsynced properties:** `shadowTokenRef` and `cropData` are not included in the component sync engine — changes to these on the master do not propagate to instances.

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

## Resetting Overrides

To restore an instance to match its master:

1. Select an instance (or a child within an instance)
2. Use the **Reset Overrides** command (via command palette)

**What happens:**
- All `overriddenProperties` are cleared
- The instance re-syncs from the master, pulling fresh values for all properties
- If you reset on the instance root, the entire subtree is reset
- If you reset on an individual child, only that child is reset

## Detaching an Instance

To break the link between an instance and its master:

1. Select a component instance
2. Use the **Detach Instance** command (via command palette — no default shortcut)

**What happens:**
- `ComponentData` is removed from the instance root
- `ChildComponentData` is removed from all descendant elements
- The frame becomes a regular frame with no component links
- Future changes to the master will not affect this frame
- The frame's content is preserved as-is

## Navigating to the Master

When you have an instance selected:

1. Use the **Go to Master Component** command (via command palette)
2. The master component is selected on the canvas

This works when the master is on the same canvas. The selection jumps to the master element.

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Create Component | Command palette |
| Create Instance | Command palette |
| Detach Instance | Command palette |
| Reset Component Instance Overrides | Command palette |
| Go to Master Component | Command palette |
| Push Overrides to Master | Command palette |

**Push Overrides to Master** — When you've made overrides on an instance that should become the new default, use this command to apply the instance's overrides back to the master component. All other instances will then sync to the updated master values.

## Tips

- **Edit the master to update all instances.** Change colors, text, or layout on the master and all linked instances update automatically (respecting overrides).
- **Override strategically.** Only override what needs to differ per instance (e.g., text content, fill color). This keeps instances in sync for structural changes.
- **Use Reset Overrides to start fresh.** If an instance has drifted too far from the master, reset and re-apply only the overrides you need.
- **Detach before diverging completely.** If an instance needs to become fully independent, detach it first to avoid unexpected syncs.

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| Instance not updating when master changes | Property was overridden on the instance | Reset overrides, then re-apply only needed changes |
| Cannot create component | No element selected, or element is inside a component instance | Select an element outside component instances (or detach the instance first). Non-parents are auto-wrapped in a frame |
| Detached parent still looks like a component | Visual only — labels may not refresh immediately | The parent is a regular parent; verify `componentData` is gone |
| Instance child not syncing | Child is marked as a slot | Slots are owned by the instance; edit directly |

## Creating Components via Blueprint

Components and instances can be created in blueprint syntax using the `component`, `instance of:Name`, and `slot` keywords.

### Component Master

Add the `comp` bare flag to create a component master:

```
a1b2c3d4 al(h,g(8),pad(12,16)) s(hug,48) f[(#3B82F6)] rd(8) comp "Button"
  b1b2c3d4 fr s(24,24) slot "Icon"
  c1b2c3d4 t("Button",Inter,14,sb) s(fill,hug) f[(#FFFFFF)] "Label"
```

**What happens:**
- The frame is created with all its children
- `createComponentFromFrame()` is called to establish it as a master
- Children marked with `slot` get `isSlot: true` on their `ChildComponentData`

### Component Instance

Use `inst(masterRef)` to create an instance of an existing component master:

```
d1b2c3d4 inst(a1b2c3d4) p(300,100) "Submit"
```

**What happens:**
- The system finds the component master by ID (or name)
- A linked instance is created at the specified position
- Indented children are treated as overrides:
  - Named children match against the instance's existing children by name
  - Property changes are applied as overrides
  - Slot children can have new content injected

### Slots

Mark a child with the `slot` bare flag to designate it as instance-owned content:

```
e1b2c3d4 al(v,g(16),pad(24)) s(320,hug) f[(#FFFFFF)] rd(12) comp "Card"
  f1b2c3d4 t("Card Title",Inter,20,b) s(fill,hug) f[(#0F172A)] "Header"
  a2b2c3d4 fr s(fill,hug) slot "Content"
```

Slot children are skipped during sync — instances fully own their slot content. This allows each instance to have completely different content in the slot area while keeping the rest of the component in sync with the master.

> **See also:** [knowledge/FRAMES.md](./FRAMES.md) for parent types, auto layout, and nesting
> **See also:** [knowledge/EDITING.md](./EDITING.md) for selection and navigation within component hierarchies
