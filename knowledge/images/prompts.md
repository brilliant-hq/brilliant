# Image Generation: Prompts

## When to Use generate_image

| Scenario | Generate | Placeholder instead |
|----------|---------|---------------------|
| Hero photo, product shot, portrait, food | Yes | Only if user explicitly wants placeholder |
| Texture, pattern fill | Yes | Simple geometric → use gradients |
| Icon or logo | No — use `svg(icon:name)` | Always vector |
| Abstract geometric | No — build with shapes | Blueprint shapes are sharper |

## Core Structure

Natural language paragraphs, NOT keywords:

**Subject + Medium/Style + Composition + Lighting + Quality**

```
BAD:  "coffee cup, minimalist, white"
GOOD: "A minimalist product photo of a matte black ceramic coffee mug
       on light oak, shot from 45 degrees with soft diffused natural
       light, shallow depth of field, editorial photography style"
```

## Five Components

| Component | Specify |
|-----------|---------|
| **Subject** | Age, material, color, texture, expression, pose |
| **Medium** | Photography style, art medium, reference aesthetic |
| **Composition** | Camera angle, framing, focal length, depth of field |
| **Lighting** | Source, direction, quality, color temperature |
| **Quality** | Resolution cues, rendering quality |

## Specificity Wins

| Vague | Specific |
|-------|---------|
| "a woman" | "a 30-year-old East Asian woman with shoulder-length black hair" |
| "a building" | "a 4-story Art Deco apartment building with terracotta facade" |
| "food" | "a bowl of tonkotsu ramen with chashu, soft-boiled egg, green onions" |

## Pitfalls

- Keyword prompts → generic results. Write paragraphs.
- Don't generate what you can build (icons, UI, shapes)
- Text in images unreliable — overlay as blueprint text element
- One change per reference edit
