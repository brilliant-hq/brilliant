---
name: "knowledge-editor-open-failures-desktop-startup"
description: "Desktop cards about a known-bad graphics driver, repeated crashes, a slow startup, and fonts that failed to load."
assumes: reference/editor-open-failures
---

# In the desktop app: driver, startup and font cards

**"Brilliant may not run on this graphics driver"** and **"Brilliant keeps crashing on this computer"**
Brilliant found a graphics driver known to crash its renderer, or the renderer crashed several times in
a row, so it did not start the renderer automatically. The card names the driver and how to update it.
**Try anyway** starts the renderer for this session only.

**"Still getting the window ready"**
A step of starting up is taking longer than expected. The window is usable and the step keeps working
in the background. **Retry** runs the stalled step again. **Open without last canvas** starts on the
home screen instead of the canvas that was open last, useful when that one canvas is the problem.

**"Couldn't open <project>"**
Opening the project at startup failed, and Retry opened Scratch instead so you can keep working. The
project folder was left exactly as it was. Once the cause (a disconnected drive, missing permissions) is
fixed, press **Try again** on the notification, or open the project again from Home.

**"Some of Brilliant's fonts failed to load"** (Windows and Linux)
Menus, panels or icons may look wrong, usually because an antivirus quarantined files in the Brilliant
install. Add Brilliant to the antivirus exclusions and reinstall. When the app shows "Brilliant
restored its fonts from a built-in copy" instead, everything already looks right.
