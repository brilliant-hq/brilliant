---
name: "knowledge-components-detach"
description: "Detaching an instance, ungrouping a component, and navigating to the master."
assumes: reference/components
---

# Detach, Ungroup and Go to Master

## Detaching an Instance

To break the link between an instance and its master:

1. Select a component instance
2. Press **Cmd+Alt+B** (or use the **Detach Instance** command via palette, or right-click and choose **Component → Detach Instance**)

**What happens:**
- The link to the master is removed from the frame and all its contents
- The frame becomes a regular frame with no component links
- Future changes to the master will not affect this frame
- The frame's content is preserved as-is
- Instances of other components inside it stay instances of their own components: they keep following their own masters (a master change, such as a deleted or added child, still reaches them)

Moving a part out of an instance (a layers drag, a drag on the canvas, or `parent()` on one of its children) is refused, and Brilliant says "Detach the instance to move its parts."; detach first, then move it. Reordering parts inside the instance stays allowed.

## Ungrouping a Component

When you ungroup a component frame, the component links are automatically cleaned up first:

- **Ungrouping a master component** detaches all instances of that master (making them regular frames), then removes the component status from the master, then ungroups the frame normally.
- **Ungrouping a component instance** detaches the instance first (breaking the link to the master), then ungroups the frame normally.

## Selecting the Instance Around a Layer

When a layer inside an instance is selected (a text or shape in a placed button, say), the **Select Instance** command (palette, or right-click and choose **Component → Select Instance**) selects the nearest instance that contains it. Run it again to keep walking outward: an instance placed inside another instance selects the outer one next. With several layers selected, each one's nearest instance is selected. It is offered only when every selected layer sits inside an instance, and it changes the selection only (nothing to undo). **Select Parent** (Shift+Enter) still selects the direct parent, which may be a plain frame inside the instance.

## Navigating to the Master

When you have an instance selected:

1. Use the **Go to Master Component** command (via palette, or right-click and choose **Component → Go to Master**)
2. The master component is selected and the camera moves to center it

If the master lives on a different canvas, Brilliant switches to that canvas first, then selects and centers the master. The camera stays put when the master is already comfortably in view (so it won't jump when the master sits right next to the instance), and it never zooms in past 100% just to fill the screen with a small master (a large master zooms out enough to fit).
