---
name: "building-image-generation"
description: "AI image generation via Nano Banana 2 (Gemini Image): when to use it, prompt engineering, quality settings, use-case templates, and integration patterns."
---

> **Parent skill:** [building/SKILL.md](./SKILL.md)

# AI Image Generation

Generate photorealistic images, illustrations, textures, and product visuals using `generate_image` (Nano Banana 2 / Gemini 3.1 Flash Image). Generated images are saved to Assets and placed on the canvas automatically.

**Load this skill when the design needs real imagery** — hero photos, product shots, team portraits, food photography, texture backgrounds, illustrations, or any visual that a placeholder rectangle can't replace.

---

## When to Use generate_image

| Scenario | Use generate_image | Use placeholder instead |
|----------|-------------------|------------------------|
| Hero background photo | Yes — generates the exact mood/scene | Only if user explicitly wants a placeholder |
| Product mockup image | Yes — realistic product shots | If the user will supply their own photo |
| Team/avatar photos | Yes — realistic portraits | If actual team photos will be provided |
| Food/lifestyle photography | Yes — styled food and scene photos | Never — these are the strongest use case |
| Texture or pattern fill | Yes — organic textures, marble, wood, fabric | Simple geometric patterns (use gradients) |
| Icon or logo | No — use `svg(icon:name)` or SVG import | Always prefer vector for icons/logos |
| Abstract geometric art | No — build with shapes and gradients | DSL shapes are sharper and scalable |
| Screenshots / UI mockups | No — build real UI with elements | Always prefer constructed UI |

**Ask first.** Before generating, use `AskUserQuestion` to confirm quality preference:
- "Quick draft" — `imageSize: "1K"` (~5s, good for iteration)
- "High quality" — `imageSize: "2K"` (~15-20s, hero images, final assets)
- "Maximum quality" — `imageSize: "4K"` (slowest, large prints/backgrounds)

---

## Core Prompt Structure

Nano Banana 2 responds dramatically better to **natural language paragraphs** than keyword lists. Structure every prompt as:

**Subject + Medium/Style + Composition + Lighting + Quality**

```
BAD:  "coffee cup, minimalist, white background"
GOOD: "A minimalist product photo of a matte black ceramic coffee mug on a
       light oak table, shot from a 45-degree angle with soft diffused natural
       light from the left, shallow depth of field, clean white background,
       editorial photography style"
```

### The Five Components

| Component | What to specify | Example |
|-----------|----------------|---------|
| **Subject** | Be hyper-specific — age, material, color, texture, expression, pose | "a 25-year-old woman with cropped auburn hair wearing a charcoal linen blazer" |
| **Medium/Style** | Photography style, art medium, or reference aesthetic | "editorial fashion photography", "watercolor illustration", "3D render" |
| **Composition** | Camera angle, framing, focal length, depth of field | "shot from below at 24mm, centered composition, shallow depth of field" |
| **Lighting** | Light source, direction, quality, color temperature | "golden hour side lighting, soft diffused, warm tones" |
| **Quality** | Resolution cues, rendering quality | "highly detailed", "crisp focus", "professional studio quality" |

### Specificity Wins

The single biggest quality lever is **specificity**. Every vague word is a coin flip.

| Vague (bad) | Specific (good) |
|-------------|----------------|
| "a woman" | "a 30-year-old East Asian woman with shoulder-length black hair" |
| "a building" | "a 4-story Art Deco apartment building with terracotta facade" |
| "food" | "a bowl of tonkotsu ramen with chashu pork, soft-boiled egg, and green onions" |
| "nature" | "morning fog over a still alpine lake reflecting snow-capped peaks" |
| "professional" | "corporate headshot with a charcoal grey seamless backdrop, Rembrandt lighting" |

---

## Use-Case Prompt Templates

### Hero / Banner Photography

Best aspect ratios: `16:9`, `21:9`. Use `imageSize: "2K"` or `"4K"`.

```
"An aerial view of a modern coastal city at golden hour, warm sunlight
reflecting off glass skyscrapers, turquoise ocean in the background,
shot with a tilt-shift lens creating selective focus on the downtown
core, cinematic color grading with warm amber highlights and cool
blue shadows, professional architectural photography"
```

### Product Shots

Best aspect ratios: `1:1`, `4:3`, `3:2`. Use `imageSize: "2K"`.

```
"A matte black wireless earbud case sitting on a slab of raw concrete,
one earbud resting beside it at a casual angle, soft directional studio
lighting from the upper left creating a gentle gradient shadow, minimal
clean background in warm off-white, shallow depth of field at f/2.8,
product photography style with crisp detail on the textured matte finish"
```

### Portrait / Avatar

Best aspect ratio: `1:1`. Use `imageSize: "1K"` for avatars, `"2K"` for hero portraits.

```
"Professional headshot of a confident man in his early 40s with short
salt-and-pepper hair and a trimmed beard, wearing a navy crew-neck
sweater, warm neutral expression with slight smile, shot against a
soft gradient backdrop from warm grey to off-white, Rembrandt lighting
with a subtle catch light in the eyes, shallow depth of field, medium
format portrait photography"
```

### Food Photography

Best aspect ratios: `1:1`, `4:3`, `3:2`. Use `imageSize: "2K"`.

```
"A rustic wooden board with freshly baked sourdough bread, one slice
torn off revealing the airy crumb structure, a small ramekin of golden
butter beside it, scattered flour on the dark slate countertop, warm
overhead natural light from a kitchen window, food styling with
intentional crumbs and a linen napkin, editorial food photography
with rich warm tones"
```

### Texture / Background

Best aspect ratio: `1:1` or match the section ratio. Use `imageSize: "2K"`.

```
"Seamless abstract texture of flowing liquid marble in deep navy and
gold veins on a dark background, organic swirling patterns with subtle
metallic highlights, smooth gradients between the dark base and gold
accents, high resolution macro photography of polished stone surface"
```

### Illustration Style

Best aspect ratios: match the placement. Use `imageSize: "1K"` for drafts.

```
"A whimsical flat illustration of a small plant shop storefront,
warm pastel color palette with terracotta, sage green, and cream,
potted plants visible through the window display, hand-painted
watercolor texture, children's book illustration style with clean
simple shapes and gentle shadows"
```

---

## Parameters by Scenario

| Scenario | imageSize | aspectRatio | Notes |
|----------|-----------|-------------|-------|
| Quick iteration / draft | `"1K"` | Match placement | Fast feedback loop |
| Card thumbnail | `"1K"` | `"4:3"` or `"3:2"` | Small display size, 1K is plenty |
| Avatar / profile photo | `"1K"` | `"1:1"` | Small display, save time |
| Hero background | `"2K"` | `"16:9"` or `"21:9"` | Large display, quality matters |
| Product hero image | `"2K"` | `"1:1"` or `"4:3"` | Needs crisp detail |
| Full-bleed background | `"2K"` or `"4K"` | Match section ratio | Large surface, visible quality |
| Final marketing asset | `"4K"` | Varies | Maximum quality for export |

**Supported aspect ratios:** 1:1, 1:4, 1:8, 2:3, 3:2, 3:4, 4:1, 4:3, 4:5, 5:4, 8:1, 9:16, 16:9, 21:9

---

## Integration Patterns

### Basic: Generate and Place

`generate_image` returns the element ID and asset path. The image is auto-placed on canvas — no separate `create_modify_elements` call needed. Reposition or resize afterwards if needed.

### Reference Images for Consistency

Pass `referenceElementIds` to maintain style across multiple generations. Export existing canvas elements as PNG references so subsequent images share the same visual language (color palette, lighting, composition style).

### Image in a Design

After generation, use the asset path in element fills for integration into layouts:

```
fr s(fill,400) f[(img(Assets/hero-coastal-city.png))] clip rd(16) "Hero Image"
```

### Text Over Generated Images

Always add a semi-transparent overlay between image and text for readability:

```
fr s(fill,500) f[(img(Assets/hero.png)),(f2,solid(#09090B,0.55))] clip "Hero"
  al(v,a(c,c),g(20),pad(80)) s(fill,fill) "Content"
    t("Your Headline",Inter,48,sb,c) f[(#FFFFFF)] "Title"
```

---

## Parallel Generation

When generating multiple images, **call `generate_image` for ALL of them in the same turn** — do NOT generate one at a time. The tool executor runs all calls concurrently, so 10 images generated in parallel take the same wall-clock time as 1. Sequential generation is 10x slower for no benefit.

```
BAD:   generate_image("crystal logo") → wait → generate_image("neon logo") → wait → ...
GOOD:  generate_image("crystal logo") + generate_image("neon logo") + ... (all in one turn)
```

---

## Pitfalls

- **Keyword prompts produce generic results.** Always write full descriptive sentences. "coffee shop interior" gives a stock photo. The paragraph version with lighting, materials, angle, and mood gives a stunning image.
- **Don't generate what you can build.** Icons, logos, UI elements, geometric patterns, and abstract shapes are always better constructed with DSL elements — sharper, scalable, and editable.
- **Text in images is unreliable.** If text must appear in the image, state it exactly: `text must read exactly "WELCOME"`. But prefer adding text as a DSL text element overlaid on the image.
- **One change per reference edit.** When using reference images to iterate, change ONE thing per prompt. "Make it warmer and change the angle and add a person" will produce unpredictable results.
- **Don't skip AskUserQuestion.** The difference between 1K (5s) and 4K (30s+) is significant. Users appreciate being asked about quality preference before waiting.
- **Match aspect ratio to placement.** A 1:1 image stretched into a 16:9 hero looks bad. Set `aspectRatio` to match the target frame's proportions.
