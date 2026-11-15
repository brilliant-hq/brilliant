---
name: "knowledge-components-limits"
description: "What the component system does not support, and component troubleshooting."
assumes: reference/components
---

# Component Limits and Troubleshooting

## What's Not Supported

Brilliant components are a master/instance system with property overrides, slots, component sets (variants), and cross-canvas references. The following Figma-style concepts are NOT currently in Brilliant:

- **Swap Instance.** There is no swap-instance UI or command. To switch an instance to a different master, detach it and create a fresh instance of the other master. (Within a component set, you don't swap -- you flip the instance's property dropdowns to pick a variant.) The one exception is **Re-point Missing Masters** (below): it re-points instances whose master MOVED to another canvas, keeping the instance and its overrides; it never picks a different master.
- **Components panel / page.** There is no left-toolbar Components panel and no separate "Components" canvas type. Masters live as regular frames on a canvas; you can keep them on a dedicated canvas by convention and reference them across canvases. (A contextual Component section does appear in the right inspector when a component, set, variant, or instance is selected.)
- **Per-property override badges.** There is no chip or label that flags which individual property is overridden on an instance. The Component section shows property dropdowns for sets and instances, but it does not mark which properties you've overridden; the visible component chrome is the purple frame label and the diamond icon (filled = master, outline = instance).
- **Component descriptions or metadata** (no description field, no documentation popovers)
- **A separate component file format.** Masters live on canvases inside a project. Sharing components ACROSS projects is done by publishing the whole project as a **library** and depending on it at a released version; see `reference/libraries`.
- **Component diff view** (no side-by-side master vs instance comparison UI)
- **Nested overrides exposed as instance properties** (overriding a nested instance child works, but there is no "exposed property" surface on the parent instance)

## Troubleshooting

| Symptom | Likely Cause | Fix |
|---------|--------------|-----|
| Instance not updating when master changes | Property was overridden on the instance | Reset overrides, then re-apply only needed changes |
| Blend mode change on master not reaching instances | Blend mode stays independent per instance by design | Set blend mode on each instance individually, or detach if you need it managed separately |
| Cannot create component | No element selected, or the element is part of someone else's instance | Select elements outside any component instance, or select the instance root itself (it CAN be wrapped). Non-frames are auto-wrapped. |
| Instances say their master is missing after the master was moved to another canvas (the instance still names the old canvas) | Some instances kept the old canvas when the master moved (for example, a sync wrote older rows back) | Run **Re-point Missing Masters** from the palette (agents: `execute_commands` with `repoint_missing_masters`, `{"dryRun": true}` first for the per-canvas report). Each instance whose master is gone from the canvas it names, and lives by that name on exactly ONE other canvas, is re-pointed in place: same layer, same overrides, one undo for the whole act. A name that is a master on two or more canvases is left as is and reported with every candidate canvas; rename one so the name is unique, or pass `"target": "<master id>"`, then run it again. `"canvas": "<path>"` (the rows on that canvas or naming it) or `"masterId": "<id>"` scopes the act; an instance whose `mid()` or children name one master is re-pointed to it even when another canvas has a master of that name. Opening or reloading a canvas never does this on its own. |
| Cross-canvas instance lost its component link after reopening | The instance's canvas was opened before its master's canvas in this session | Open the master's canvas first, then the canvas that uses it |
| Push Overrides to Master does nothing | Master is on a different canvas than the instance | Switch to the master's canvas before invoking the command (Go to Master switches canvases for you) |
| Instance child not syncing | Child is a slot | Slots are owned by the instance; edit them directly |
| Cannot drop element into component instance | Instances can't take new children | Drop into a slot, or detach the instance first |
