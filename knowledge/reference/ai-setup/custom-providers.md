---
name: "knowledge-ai-setup-custom-providers"
description: "Custom and self-hosted OpenAI-compatible endpoints under Settings > Models > Custom providers, with the built-in presets."
assumes: reference/ai-setup
---

# Custom and self-hosted providers

Any OpenAI-compatible endpoint can be added under **Settings → Models →
Custom Providers**. Each entry is a base URL plus an optional key; the models it
exposes then appear in the chat model selector under that provider's name.

Add one with the **base-URL field + key field + checkmark**. The base-URL field
has a dropdown of built-in presets that pre-fill the URL:

| Preset | Kind | Key |
|--------|------|-----|
| LM Studio, Ollama, vLLM | local (localhost) | none needed |
| GLM (Z.ai), Moonshot (Kimi), DeepSeek, Xiaomi MiMo | hosted | required |
| Custom OpenAI-compatible | anything else | optional |

On save Brilliant tests the connection first, then populates the model list:
curated defaults for the preset plus whatever the endpoint's model-listing API
returns. Local presets ship no curated models, so their list is whatever the
runtime currently serves (use the row's refresh button after pulling a new
model). The key is optional: local runtimes usually need none, so leave the field
blank. A bad key or unreachable URL surfaces an inline error instead of saving.
