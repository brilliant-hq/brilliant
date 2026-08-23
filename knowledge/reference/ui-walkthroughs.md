---
name: "knowledge-ui-walkthroughs"
description: "Visually walk the user through Brilliant's own UI in chat: render an exact-state UI component to an image with render_ui, weave in the user's own data, and show it inline. Covers list_stagers discovery, state composition, highlights, and displaying the image in the chat."
---

# Visual UI walkthroughs (render_ui)

Use this to SHOW the user a piece of Brilliant's real UI in an exact state, mid-conversation, with their own data in the picture: "here is the Fills section with your three brand colors", "here is the chat panel with your recent chats and this transcript". The image is a capture of the REAL production widget, not a mock.

Two tools power this. If they are not in your available tools, this feature is not enabled for your session; describe the UI in words instead, or reference a saved file path.

- `list_stagers` (no arguments): returns the renderable components, each as `{component, defaultSize: [w, h], stateSchema}`. The `stateSchema` is the source of truth for what `state` each component accepts.
- `render_ui`: renders one component into an exact declarative state and writes an image file offscreen, without touching the live app. It is app-level, so do NOT pass a canvasId. Desktop app only: in the web editor there is no local filesystem to write the image to, so the tool refuses there.

## The pattern

1. Call `list_stagers` first to discover the component ids and read each `stateSchema`. Never guess the schema.
2. Compose the `state` for the component you want, weaving in the user's own context from the conversation: their chat titles, their fill colors, the exact message text they are asking about. That is what makes the walkthrough THEIRS.
3. Call `render_ui` with an absolute `outputPath` in a writable temp directory. On macOS/Linux `/tmp/brilliant-walkthrough-1.webp` works; on Windows `/tmp` does not exist and the write is refused, so use a real Windows temp path (for example one under `%TEMP%`) or another absolute path inside your writable working area. Then show the image inline (see "Showing the image" below).
4. One concept per image. If you are explaining three things, render three focused images rather than one busy one.

## render_ui arguments

- `component` (required): a stager id from `list_stagers`.
- `state` (required): the declarative state matching that component's `stateSchema`.
- `outputPath` (required): an absolute file path. Writes lossless WebP by default; pass `format: "png"` if you need PNG.
- `highlights` (optional): boxes drawn over the render to point at the part you are explaining. Each is `{target: "<a ui-stage.* id>"}` or `{rect: [x, y, w, h]}` in captured-image logical pixels. Use a highlight whenever you are calling out a specific control.
- `pixelRatio` (optional, default 2): keep it at 2 for crisp retina output.
- `width` / `height` (optional): override the stage size; defaults to the component's `defaultSize`.

## Showing the image

To make the rendered image visible to the user in the Brilliant chat, embed it as a markdown image in your reply text, using the absolute path render_ui returned:

`![Fills section with your brand colors](file:///tmp/brilliant-walkthrough-1.webp)`

A bare absolute path also works: `![...](/tmp/brilliant-walkthrough-1.webp)`. The chat renders local file paths and `file://` URIs inline. A wrong or missing path renders as nothing (no broken-image icon), so use the exact `outputPath` from the render_ui result and render before you reference it.

## Worked example

The user asks how their chat history looks with a couple of recent chats and an active transcript. After `list_stagers` shows an `ai-chat-panel` component, render it with their real data:

```
render_ui({
  component: "ai-chat-panel",
  state: {
    recentChats: ["Pricing page", "Onboarding flow"],
    activeChat: {
      title: "Dashboard redesign",
      turns: [
        {role: "user", text: "Make the sidebar narrower"},
        {role: "ai", text: "Done. Reduced it to 240px."}
      ]
    }
  },
  outputPath: "/tmp/brilliant-chat-walkthrough.webp"
})
```

Then in your reply: `![Your chat panel](file:///tmp/brilliant-chat-walkthrough.webp)` with a sentence explaining what to look at.

## Related

- [ui.md](./ui.md): what each Brilliant UI panel is and does
- [export.md](./export.md): exporting canvas elements (a different thing: render_ui captures Brilliant's own UI, export captures your design)
