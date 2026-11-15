---
name: "knowledge-ui-walkthroughs"
description: "Visually walk the user through Brilliant's own UI in chat: render an exact-state UI component to an image with render_ui, weave in the user's own data, and show it inline in the reply with a <media> tag. Covers list_stagers discovery, state composition, highlights, and showing the image in the chat."
---

# Visual UI walkthroughs (render_ui)

Use this to SHOW the user a piece of Brilliant's real UI in an exact state, mid-conversation, with their own data in the picture: "here is the Fills section with your three brand colors", "here is the chat panel with your recent chats and this transcript". The image is a capture of the REAL production widget, not a mock.

Two tools power this. If they are not in your available tools, this feature is not enabled for your session; describe the UI in words instead, or reference a saved file path.

- `list_stagers` (no arguments): returns the renderable components, each as `{component, defaultSize: [w, h], stateSchema}`. The `stateSchema` is the source of truth for what `state` each component accepts.
- `render_ui`: renders one component into an exact declarative state and writes an image file offscreen, without touching the live app. It is app-level, so do NOT pass a canvasId. Desktop app only: in the web editor there is no local filesystem to write the image to, so the tool refuses there.

## The pattern

1. Call `list_stagers` first to discover the component ids and read each `stateSchema`. Never guess the schema.
2. Compose the `state` for the component you want, weaving in the user's own context from the conversation: their chat titles, their fill colors, the exact message text they are asking about. That is what makes the walkthrough THEIRS.
3. Call `render_ui` with an absolute `outputPath` in a writable temp directory. On macOS/Linux `/tmp/brilliant-walkthrough-1.webp` works; on Windows `/tmp` does not exist and the write is refused, so use a real Windows temp path (for example one under `%TEMP%`) or another absolute path inside your writable working area. Then show the image inline with a `<media>` tag (see "Showing the image" below).
4. One concept per image. If you are explaining three things, render three focused images rather than one busy one.

## render_ui arguments

- `component` (required): a stager id from `list_stagers`.
- `state` (required): the declarative state matching that component's `stateSchema`.
- `outputPath` (required): an absolute file path. Writes lossless WebP by default; pass `format: "png"` if you need PNG.
- `highlights` (optional): boxes drawn over the render to point at the part you are explaining. Each is `{target: "<a ui-stage.* id>"}` or `{rect: [x, y, w, h]}` in captured-image logical pixels. Use a highlight whenever you are calling out a specific control.
- `pixelRatio` (optional, default 2): keep it at 2 for crisp retina output.
- `width` / `height` (optional): override the stage size; defaults to the component's `defaultSize`.

## Showing the image

Show the render inline in the Brilliant chat with a media tag on the exact `outputPath` render_ui returned (its result also carries the ready line as `media`):

`<media src="/tmp/brilliant-walkthrough-1.webp">The Fills section with your brand colors</media>`

The chat shows an absolute path only when Brilliant itself wrote that file in this run (render_ui does), never any other path, so render first and then reference it. The picture is kept with the chat, so it still shows after the temp file is gone. A markdown image on that path (`![caption](/tmp/brilliant-walkthrough-1.webp)`) draws the same card. Write a caption that says what the image shows.

## Worked example

`reference/ui-walkthroughs/example` renders the chat panel with the user's own chats and links it in the reply.

## Related

- `reference/show-me`: light the real control on the user's screen instead (`show_ui`), when they should act on it now
- `reference/ui`: what each Brilliant UI panel is and does
- `reference/export`: exporting canvas elements (a different thing: render_ui captures Brilliant's own UI, export captures your design)
