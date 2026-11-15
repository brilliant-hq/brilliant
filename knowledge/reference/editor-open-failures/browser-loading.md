---
name: "knowledge-editor-open-failures-browser-loading"
description: "Browser failure cards about loading the editor, the project, or the design, and what to try for each."
assumes: reference/editor-open-failures
---

# In the browser: loading and project cards

**"Loading is taking too long"**
The editor stopped making progress while loading (a stalled download, or a canvas that never drew).
**Retry** usually gets past it. A tab left open for a long time can also hold an out-of-date copy of
the editor: reloading the page fetches the current one.

**"Couldn’t load this project"**
Something went wrong while loading the project. **Retry** usually fixes it.

**"Couldn’t read this design"**
The design file arrived but did not decode on this load. This can happen while a save from another
device is still settling. **Retry** usually fixes it, and the work on other devices is safe.

**"Project not found"** (or the project's `handle/project` name)
The project does not exist, or the signed-in account cannot see it. Check the link and the account.
Retrying does not help. **Go to @handle** opens the owner's profile.

**"Couldn’t load the editor"** (on the playground page)
The editor frame never arrived, usually a temporary network problem or a new version that shipped
while the tab was open. Press **Reload**.
