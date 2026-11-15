---
name: "knowledge-components-cross-canvas"
description: "Cross-canvas components: masters on another canvas, how instances find them, and the caveats."
assumes: reference/components
---

# Cross-Canvas Components

A master component can live on a different canvas than its instance. This lets you keep masters on a dedicated "components" canvas and use instances throughout the rest of your project. (A master can also live in a different **project** entirely: a library your project depends on at a pinned version. Library instances behave like any other instance, with a few extra states of their own; see `reference/libraries`.)

How it works:

- An instance remembers which canvas its master lives on
- When you open the instance's canvas, Brilliant finds the master and syncs the instance to the latest master values
- Editing a master updates instances on every canvas you currently have open; instances on canvases you haven't opened pick up the latest values the next time you open them
- **Go to Master Component** works across canvases: it switches to the master's canvas when needed, then selects and centers the master. **Push Overrides to Master** only works when the master is on the canvas you're currently viewing, so switch to the master's canvas first to push to it. Components that come from a library cannot be pushed to at all; see `reference/libraries`.
- Pasting a master into a different canvas creates an instance that points back to the original master (the master is not duplicated)

**Caveats:**
- Deleting a master does not immediately detach instances on canvases you don't have open. Those instances are cleaned up the next time you open their canvas.
- An agent's delete of a master, or of a frame holding one, names every other canvas holding its copies, with counts. In the web editor or a cloud project, a closed canvas it could not read is named as not read ("This list may be incomplete"): open that canvas to check.
- Deleting the canvas or folder that holds a master never empties its instances on other canvases. Each instance keeps its last content and its overrides, as a component whose master is missing. Undo the delete to link them back to the master.
- If a canvas full of cross-canvas instances is the first thing you open in a session, those instances may not find their master yet. To be safe, open the master's canvas first, then the canvas that uses it.
