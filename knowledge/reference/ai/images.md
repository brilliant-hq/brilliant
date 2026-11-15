---
name: "knowledge-ai-images"
description: "AI image generation (Google), Remove Background with Restore Background, and Add Outline on a cutout."
assumes: reference/ai
---

# AI Image Generation

The AI generates raster images with Google's Gemini image model (Nano Banana 2.1) and applies them as image fills on target elements. Generated images are saved to the project's `Assets/` folder.

- Images draw on your Brilliant AI usage unless you add your own Google key (Settings > Models > Your own AI > Google), in the built-in chat whichever AI it runs on and from your own agent over MCP alike. Before you sign in, only a chat on Brilliant AI makes images (on the part of the usage you can use signed out); a chat on your own AI and your own agent need you signed in, or a Google key.
- **Sizes:** 1K (default), 2K, and 4K. Larger is slower and more detailed.
- **Reference images:** the AI can pass existing canvas elements as visual references to steer style or to "edit" a prior generation by changing one thing at a time.
- **Batch / parallel:** several images can be requested in one turn. On the free plan, and before you sign in, up to three images run every five minutes, shared by the built-in chat, its sub-agents and your own agent over MCP: on this install while you are signed out, on your account once you sign in. The rest are named in the reply with when that window resets, so you can ask for more.
- **Use for:** photos, realistic scenes, complex textures.

## Remove Background

Right-click a photo on the canvas and pick **Remove Background** (or use the button next to Replace Image in the image fill, or type "cutout" in the palette). The same photo stands on transparency a moment later: the same pixels, the same face, the same size and place, only the background gone. It works on every image in the selection at once. **Restore Background** (same places) puts the original back at any time, in any later session, not only through undo; undo also steps it back.

- **Usage:** each cutout counts against your Brilliant AI usage, on every plan including Free, and it rides Brilliant AI even when your chat runs on your own AI keys. A photo with no subject is not charged.
- **No retention:** the photo is processed in memory to cut it out and is never stored, logged or used for training.
- **The agent can do it too:** ask the AI to cut out a photo and it uses the `remove_background` tool, which keeps the real pixels, instead of generating a new picture. Before you sign in, the built-in chat's agent (the playground's included) cuts out on the same free allowance as the brilliant.design/remove-background page: up to 20 cutouts a day without an account, shared with that page; past it, the agent says so and offers sign-in, which is free: signed in, the page is unlimited and the agent's cutouts count against your Brilliant AI usage like any other. Your own agent over MCP needs you signed in.
- **What you may see:**
  - "Removing background from Portrait" while a request takes longer than a few seconds.
  - "No subject found in Texture." when the photo has nothing to keep (nothing changed).
  - "Background removal for Portrait was not applied: the image changed." when the image was replaced or deleted while the request ran.
  - "2 hidden or locked layers skipped." when a selected frame, group or instance holds hidden or locked photos: those are left alone (select one directly to cut it).
  - "You're offline. Background removal needs a connection."
  - "Background removal is unavailable right now. Try again in a minute."
  - "Portrait: the image file is missing." when the image file is gone from the project.
  - When your Brilliant AI usage is used up, the upgrade page opens, and the cutout runs on its own once your plan allows it.

### Add Outline

On a photo whose background was removed, **Add Outline** (right-click the photo, the button next to Restore Background in the image fill, or type "outline" or "sticker" in the palette) draws a sticker outline around the subject: a new vector layer named "Cutout outline", placed right above the photo, following the photo's crop, rotation, flip and size. It is an ordinary layer: change its color or width in the stroke section, move it, or delete it; it does not follow later changes to the photo. The default look is a white outside stroke, whatever your design system, at 2 percent of the photo's shorter side, with round corners. One Cmd+Z removes it. It runs on your machine: no Brilliant AI usage.

- On a photo whose background is still there, the right-click row reads "Add Outline (remove the background first)".
- **The agent can do it too:** the `add_cutout_outline` tool (optional `color` and `width`).
- **What you may see:** "No outline for Portrait: nothing visible to trace." when the visible part of the cutout is empty; "No outline for Pattern: the image is tiled." on a tiled (repeat) image fill; "No outline for Badge photo: it is inside a component instance." on an image inside an instance (an instance takes no new layer: detach it, or outline the main component's image).
