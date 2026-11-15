---
name: "knowledge-ui-walkthroughs-example"
description: "A worked render_ui example: the chat panel rendered with the user's own chats and shown in the reply."
assumes: reference/ui-walkthroughs
---

# Visual UI walkthroughs: worked example

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

Then in your reply: `<media src="/tmp/brilliant-chat-walkthrough.webp">Your chat panel</media>` with a sentence explaining what to look at; the picture shows right in the chat.
