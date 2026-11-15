---
name: "knowledge-libraries-help"
description: "Helping a user with a library problem: where the facts are (the manifest, the downloaded copy, the canvas rows, the inspector sentence, the app log), the acts an agent can run, which page holds the remedy per class, and what only the user can do in the app."
assumes: reference/libraries
---

# Helping with a library problem

When a user says a library is not doing what they expect, the facts are in five places, and you can read three of them yourself:

1. **The manifest**, `libraries.yaml` at the project root (`reference/libraries/adding`): which libraries the project uses and the version each is pinned to. In a project saved in a folder, read it with your own file tools at the `repoRoot` that `init` gave you. A cloud project open in the desktop app and the web editor keep it in the cloud, so there the pin is read off the Assets view's rail (the user's eyes) or off a library act's answer.
2. **The downloaded copy**, desktop folder projects only: `.brilliant/libraries/@handle/project/.meta.json` says which release the copy IS (`version`, `fetchedAt`, `displayName`, `projectId`). No file, or a `version` below the pin, means the library is still on its way or could not be fetched. Never edit anything under `.brilliant/libraries/`; it is derived and the next fetch overwrites it.
3. **The canvas rows**: `read` the canvas with `format: "blueprint"`. A live library component reads `inst(Button, lib(acme/design-kit), canvas(Atoms/Buttons))`; a placeholder that could not resolve keeps that same row; a copy is a master row (`comp`) in the project itself (usually on a "Components" canvas) with plain `inst(Button)` rows pointing at it. That one read tells copies, live instances and placeholders apart.
4. **The inspector's Component section**, which only the user sees: the source row ("Acme Design System 1.2.0", "1.4.0 available") or, for a component whose source is missing, one plain sentence naming the reason, with the act that helps (`reference/libraries/unavailable`). Ask the user to select the component and read you that sentence when the rows alone do not explain it.
5. **The app log**, desktop only: `~/.config/brilliant/logs/brilliant.log`. Every library event is one line starting `library "<key>"`: vendored at a version, fetch deferred with its reason, a missing copy, a canvas that cannot be read, the closure notes. Read it with your own file tools; the web editor keeps no log file.

The acts you can run are the library commands of `execute_commands` (no `canvasId`, no `ids`; the exact arguments and every answer sentence are in `blueprint/commands`): `add_library`, `update_library`, `remove_library`, `add_local_library` on the consumer side; `mark_project_as_library`, `unmark_project_as_library`, `create_library_release` on the producer side, `library_releases` to read any library's release history (or the open project's own), and `set_project_settings` for the library's visibility, description, display name, topics, license and attribution (`reference/canvases`). The producer acts act on the project open on screen, so to release a library the user opens the library project first ("Open the library project" on the refusal notice, or "Go to library project" on its rail row; there is no command for that). Every answer is `{success, commandId, message | error}` with the precise sentence. Two sentences mean the same thing on every act: "Your session expired. Sign in again to continue." (the user signs in; nothing you run fixes it) "Could not reach the server." (offline, or the server answered an error; try again later), and "The server asked Brilliant to slow down. Try again in a moment." (the server is rate limiting this connection: it is reachable, nothing is wrong with the library; the answer comes within seconds and nothing was changed, so wait a few minutes and run the act again).

## The remedy per class

- "My library is not updating" and "My component is not linked": `reference/libraries/help-linking`.
- "I cannot publish" or "I cannot release", and "The star or the Private chip is wrong": `reference/libraries/help-publishing`.

## What only the user can do

Press **Try again**, **Update**, **Update all**, **Go back to**, **Add it back**, **Reset overrides** and **Remove** in the Assets view or the inspector; answer the stop-sharing and the make-private confirms; sign in, connect Figma, publish the project from Settings; pick a library on a Figma import's Libraries step; star a library; choose the folder for a folder library. Everything else above has a command, and its answer is the sentence to read back to them.
