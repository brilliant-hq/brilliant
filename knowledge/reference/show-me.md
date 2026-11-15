---
name: "knowledge-show-me"
description: "Show the user where something is in Brilliant's own UI, live: list_ui_targets finds the control, show_ui lights it step by step with a card, and one outcome tells you whether they did it."
---

# Show me (list_ui_targets, show_ui)

When the user asks how to do something in Brilliant ("how do I invert zoom?", "where are the project's libraries?"), SHOW them: the app opens the right page, dims the rest, lights the control and puts your words on a card beside it ("Step 1 of 2"). The user acts on the real control; you hear how it went. Both are `execute_commands` commands with no `canvasId` and no `ids`.

## Find the target: `list_ui_targets {surface?, query?}`

Answers `{count, targets: [{id, label, surface, kind, reach, mounted, doIt?, aliases?}]}`. `surface` is `settings`, `project`, `inspector`, `toolbar`, `rail`, `topbar`, `chat`, `canvas`, `menu` or `palette`; `query` matches the id, label and aliases (`"zoom"`). `kind` is `toggle`, `choice`, `field`, `button`, `section` or `row`; `reach` is what the app opens to get there; `mounted` is whether it is on screen now. `menu` and `palette` targets list only for that `surface` or a `query`. Ids are stable and read like the UI (`settings.input.invertZoom`, `project.libraries`, `inspector.currentFill`, `toolbar.frame`, `rail.assets`, `topbar.share`, `menu.toggle_pixel_grid`). Never guess an id: list first.

## Show it: `show_ui {steps}`

```json
{ "commandId": "show_ui", "params": { "steps": [
  { "target": "settings.input.invertZoom", "text": "This flips which way the mouse wheel zooms. Click it to turn it on." },
  { "target": "settings.input.zoomSpeed", "text": "And this sets how fast zooming goes.", "advance": "next" } ] } }
```

- Each step: `target`, `text` (one or two short sentences for the card), optional `title` (defaults to the label), `advance`, `doIt`.
- `advance: "change"` (the default for toggles, choices and fields) ends the step when that setting changes, however the user changes it; `"next"` (the default otherwise) when they press Next (Done on the last step).
- `doIt`: a command id; the card offers "Do it for me", which runs it as your own write and moves on.
- The answer comes at once: `{runId, steps, resolved: [{target, reachable, how}], outcome}`. Say in one line what you are showing, then stop.

## The outcome

One per run: `{runId, outcome, stepReached, steps, changed: [{setting, from, to}]}`. In the in-app chat it arrives as your next message (`show_ui outcome: {...}`), or inside the user's next message if they wrote first. Over MCP, call `show_ui_outcome {runId, waitMs?}` (up to 120000 ms); before the end it answers `outcome: "running"`.

- `done`: every step went through; confirm in one line from `changed`.
- `did_it`: they pressed Do it for me; confirm what was done.
- `skipped`: Next on a toggle or choice without changing it; nothing changed.
- `closed`: they closed the card (X, Esc) at `stepReached`; nothing was undone, do not repeat it.
- `target_missing`: the control did not show within 3 s (an inspector section that needs a selection); say so and offer to open its page (a `show_ui` of the page).
- `interrupted`: a new `show_ui` replaced it, or the user wrote; their message is the new request.

## When it cannot light

- An unknown id is refused before anything moves, with the nearest ids.
- A menu item (`menu.*`) or palette command (`palette.*`) answers `reachable: false` and is not shown: say where it is (the `how` text, "View > Guides & Grids > Toggle Pixel Grid") and offer to run its command once the user says yes.
- While the first-run walkthrough is on screen, `show_ui` is refused `busy: onboarding`.
- A click elsewhere pauses the run ("Paused · Resume" in the chat); a change made while paused still counts.
- The walkthrough never moves, snaps or minimizes the chat. If the chat covers the lit control, the user moves it; you may say so.

Related: `reference/ui-walkthroughs` (a still picture of a UI state, `render_ui`), `reference/ui`.
