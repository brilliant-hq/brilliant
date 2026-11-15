---
name: "knowledge-ai-setup-model-overrides"
description: "Setting the context window and image support for extra models on a built-in provider with an overrides block."
assumes: reference/ai-setup
---

# Extra models on a built-in provider

**Extra models on a built-in provider.** A model you turn on from a provider
row's model picker (Anthropic, OpenAI, Google, OpenRouter, Meta) takes its context
window and image support from that provider's model list, which OpenRouter and
Google state. To set them yourself on desktop, for example for a model the list
does not describe, add an `overrides` block to
`~/.config/brilliant/custom_providers.json` and restart Brilliant:

```json
{
  "providers": [],
  "overrides": {
    "openrouter": {
      "~deepseek/deepseek-flash-latest": {"contextWindow": 1048576, "supportsVision": false}
    }
  }
}
```

Keys are the provider (`anthropic`, `openai`, `google`, `openrouter`, `meta`), then the
model id. An override wins over the provider's list, a field you leave out keeps
the listed value, and with nothing stated a model gets a 128000-token window
with images on. Overrides apply to models you turned on, not to the ones
Brilliant ships, and Brilliant keeps the block when it saves the file.
