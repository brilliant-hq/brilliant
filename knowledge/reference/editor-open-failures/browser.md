---
name: "knowledge-editor-open-failures-browser"
description: "Browser failure cards about the renderer and the graphics device, and what to try for each."
assumes: reference/editor-open-failures
---

# In the browser (brilliant.design)

**"This browser can’t run Brilliant"**
The browser has no WebGPU. This is not a bug and retrying does not change it. Open the same link in
Chrome, Edge, Safari 26 or later, or Samsung Internet. On the website itself, browsers without WebGPU
are offered the desktop download instead of the in-browser editor, and live previews show "Live view
needs a newer browser".

**"The canvas can’t start on this device"**
The browser supports WebGPU, but it could not reach the computer's graphics adapter. The browser is
fine, so a different browser rarely helps. Try, in order:

1. Turn on hardware acceleration in the browser settings (Chrome and Edge: Settings, System, "Use
   graphics acceleration when available"), then restart the browser.
2. Update the graphics drivers.
3. On Linux, Chrome needs Vulkan for WebGPU: turn on "Vulkan" in `chrome://flags`.
4. In a virtual machine or over remote desktop there is often no real GPU. Use a device with direct
   GPU access.

Then press **Retry**.

**"The canvas can’t start on this graphics setup"**
The browser only offers WebGPU in its reduced compatibility mode here, and that adapter cannot provide
what the canvas needs. Update the graphics drivers or try a different browser, then retry. On Linux,
turning on Vulkan in Chrome (`chrome://flags`, "Vulkan") usually gives Chrome a full adapter.

**"The canvas failed to start"**
Something went wrong while starting the renderer, or it started but never drew a frame. **Retry**
usually fixes it. If it keeps happening, reload the page.

**"The canvas lost its graphics device"**
The canvas was working, then the browser's connection to the graphics adapter dropped (a GPU reset, a
driver update, or the tab being suspended). Press **Retry** to restart the canvas.

**"The canvas hit a graphics error"**
The renderer ran into an unexpected graphics error and stopped drawing. Press **Retry**. If it keeps
happening, update the graphics drivers or try a different browser.

**"The editor lost its graphics context"**
The browser took back the tab's GPU context (usually a driver reset or GPU pressure). **Reload editor**
brings the user straight back to the same document.
