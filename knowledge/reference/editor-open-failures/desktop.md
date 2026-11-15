---
name: "knowledge-editor-open-failures-desktop"
description: "Desktop failure cards about the renderer and the graphics hardware, and what to try for each."
assumes: reference/editor-open-failures
---

# In the desktop app

**"Rendering can't start"**
The app could not load its renderer. The line under the title says why. When it reads "The rendering
engine could not be found or opened":

- On a Mac with a new macOS version, an older Brilliant build may not load its renderer. Update
  Brilliant to the latest version (download it again from brilliant.design if the app cannot update
  itself).
- On a work computer managed by an IT department, a security policy (Windows Application Control or
  AppLocker) may be blocking the renderer file. The IT team can allow Brilliant.
- Otherwise reinstall Brilliant.

Then press **Retry**.

**"A security policy on this computer blocked the canvas"**
On Windows, an Application Control policy (WDAC, AppLocker or Smart App Control) stopped the renderer
from loading; your work is safe, and your IT administrator can allow Brilliant's files (signed by
Brilliant Design LTD), after which **Retry** brings the canvas back.

**"Brilliant can't render on this graphics hardware"**
The renderer started but this computer's graphics device cannot create the canvas: the device may not
be supported, or its driver is out of date. Update the graphics driver. Restarting does not help until
then.

**"Something went wrong rendering the canvas"**
The renderer stopped and could not recover on its own. When the card mentions a graphics driver reset,
that is a routine system event (a driver update, sleep and wake, a display change), not a problem with
the design. Press **Restart rendering**, after the driver has settled when it was a reset.
If the graphics driver keeps resetting (three times, each within half an hour of the last), Brilliant stops restarting the
renderer for the rest of the session, and the next launch on that same driver opens this same card,
where **Restart rendering** starts the renderer; updating the graphics driver clears it, and so does an hour of use without a reset, or a week
after the renderer was last stopped this way.

**"Your graphics driver keeps resetting"**
The graphics driver reset six times in a day on the same graphics card, so Brilliant paused the canvas
instead of restarting it again. The card names the graphics card and the driver version. Updating the
graphics driver usually fixes this: the card links the NVIDIA, AMD or Intel driver page for that card.
**Try again** starts the canvas again for the rest of the session, and later resets that session
recover on their own as before. The design is never affected.

**"Restoring the canvas…"**
Not an error: the renderer is recovering by itself and the last frame stays on screen. It clears on its
own.
