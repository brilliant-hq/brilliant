---
name: "knowledge-frames-troubleshooting"
description: "Auto layout troubleshooting: symptoms, causes and fixes."
assumes: reference/frames
---

# Troubleshooting Auto Layout

| Symptom | Cause | Fix |
|---------|-------|-----|
| Element not stretching to fill width | Sizing is Fixed or Hug | Change to Fill in W Sizing dropdown (Element section) |
| Element stopped stretching after resize | Resize converts to Fixed | Change back to Fill |
| Fill child has 0 width (invisible) | Fixed/hug siblings consume all space | Make parent larger or reduce siblings |
| Fill not working on main axis | Parent is hug (circular dependency) | Use Fixed parent, or accept hug behavior |
| Children overlapping | Parent is Group, not Auto Layout; or absolute-positioned children | Convert to Auto Layout (Shift+A), or toggle off the pin button |
| Children overflow horizontally | Wrap not enabled, too many hug children | Enable wrap; or shrink children; or grow container |
| Wrap toggle has no effect | Frame hugs on main axis | Set main-axis sizing to Fixed or Fill |
| Auto spacing not pushing items to edges | Only one child | Auto centers a single child; add children or use Fixed alignment |
| Auto spacing packs items at the spacing value | Frame hugs on main axis (a hug frame is exactly its content, so there is no space to distribute) | Set main-axis sizing to Fixed or Fill |
| Text wrapping when it should not | Text has Fill width | Change W Sizing to Hug |
| Text not wrapping when it should | Text has Hug width in a horizontal layout | Set W Sizing to Fill, H Sizing to Hug |
| Siblings not equal height in a row | Cross-axis (height) is Hug | Set H Sizing to Fill; cross-axis Fill stretches to match the tallest sibling |
| Nested parent not stretching | Auto layout default is hug | Set Fill on the nested parent explicitly |
| Children inside Group/Mask/Boolean cannot be dragged out | Intentional, those types are not reparent targets | Use the layers explorer, or convert to Frame |
| Layout looks wrong after undo | Normal | Re-apply changes if needed |
