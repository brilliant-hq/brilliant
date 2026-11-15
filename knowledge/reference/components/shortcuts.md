---
name: "knowledge-components-shortcuts"
description: "Component shortcuts, Push Overrides to Master, tips, and authoring components via blueprint."
assumes: reference/components
---

# Component Shortcuts, Tips and Authoring

## Keyboard Shortcuts

| Action | Shortcut |
|--------|----------|
| Create Component | **Cmd+Alt+K** |
| Detach Instance | **Cmd+Alt+B** |
| Create Component Set | Palette / right-click (no default keybinding) |
| Create Instance | Palette only (no default keybinding) |
| Reset Component Instance Overrides | Palette only (no default keybinding) |
| Go to Master Component | Palette only (no default keybinding) |
| Select Instance | Palette / right-click (no default keybinding) |
| Push Overrides to Master | Palette only (no default keybinding) |

**Push Overrides to Master**: When you've made overrides on an instance that should become the new default, use this command (via palette, or right-click and choose **Component → Push Overrides to Master**) to apply the instance's overrides back to the master component. All other instances will then sync to the updated master values. This command only works when the master is on the same canvas as the instance.

## Tips

- **Edit the master to update all instances.** Change colors, text, or layout on the master and all linked instances update automatically (respecting overrides).
- **Override strategically.** Only override what needs to differ per instance (e.g., text content, fill color). This keeps instances in sync for structural changes.
- **Use Reset Overrides to start fresh.** If an instance has drifted too far from the master, reset and re-apply only the overrides you need.
- **Detach before diverging completely.** If an instance needs to become fully independent, detach it first to avoid unexpected syncs.

## Authoring Components via Blueprint

Components, instances, sets, variants, slots, and per-instance overrides can also be authored programmatically (the AI's blueprint path) rather than by hand on the canvas. The hand-driven flows above and the blueprint flows produce the same data: a master created in blueprint can be instanced and overridden by hand, and vice versa. For the blueprint authoring syntax (the component, instance, variant, slot, and override keywords and cross-canvas referencing), see the blueprint knowledge files. Do not author that syntax from this reference.
