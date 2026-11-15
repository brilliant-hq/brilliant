---
name: "knowledge-components"
description: "Component system in Brilliant: masters, instances, overrides, syncing, and detaching."
---

# Components

Components let you create reusable design elements. A **master component** defines the source of truth, and **instances** are linked copies that stay in sync with the master while allowing per-instance overrides.

- `reference/components/concepts`: masters, instances, overrides, slots, sets; creating a component
- `reference/components/instances`: creating an instance, duplicate and paste, canvas and layers indicators
- `reference/components/sets`: component sets, variants and properties, the Component inspector section
- `reference/components/overrides`: what an override is, what syncs and what doesn't, resetting overrides
- `reference/components/syncing`: how master edits reach instances, what you cannot do on an instance
- `reference/components/detach`: detaching, ungrouping a component, going to the master
- `reference/components/cross-canvas`: masters on another canvas, and the caveats
- `reference/components/shortcuts`: shortcuts, Push Overrides to Master, tips, authoring via blueprint
- `reference/components/limits`: what's not supported, troubleshooting

Resizing an instance: an icon-like instance (only vectors, no text, auto layout, nested instance, slot or image) scales its glyph with the box, stretching it on a non-uniform resize, stroke weight kept; an instance with text or auto layout keeps its children's sizes and moves them by their pins (see `reference/frames/constraints`).

> **See also:** `reference/frames` for parent types, auto layout, and nesting
> **See also:** `reference/editing` for selection and navigation within component hierarchies
> **See also:** `reference/libraries` for consuming components from other projects (libraries), and the Assets view
