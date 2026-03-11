---
assumes: images/prompts, blueprint/paint
---
# Image Generation: Integration

Assumes: `images/prompts`

## Parameters

| Scenario | imageSize | aspectRatio |
|----------|-----------|-------------|
| Draft / iteration | `"1K"` | Match placement |
| Card thumbnail | `"1K"` | `"4:3"` |
| Avatar | `"1K"` | `"1:1"` |
| Hero background | `"2K"` | `"16:9"` or `"21:9"` |
| Product hero | `"2K"` | `"1:1"` or `"4:3"` |
| Final marketing | `"4K"` | Varies |

**Supported ratios:** 1:1, 1:4, 1:8, 2:3, 3:2, 3:4, 4:1, 4:3, 4:5, 5:4, 8:1, 9:16, 16:9, 21:9

## Workflow

`generate_image` returns element ID + asset path. Image auto-placed on canvas. Reposition after.

## Image in Layout

```
fr s(fill,400) f[(img(Assets/hero.png))] clip rd(16) "Hero Image"
```

## Text Over Image

Always add overlay for readability:
```
fr s(fill,500) f[(img(Assets/hero.png)),(f2,solid(#09090B,o(0.55)))] clip "Hero"
  al(v,a(c,c),g(20),pad(80)) s(fill,fill)
    t("Headline",Inter,48,sb,c) f[(#FFF)]
```

## Parallel Generation

Call `generate_image` for ALL images in the same turn — tool executor runs concurrently. 10 parallel = same time as 1 sequential.

## Reference Images

Pass `referenceElementIds` to maintain style across generations.

## Match Aspect Ratio

A 1:1 image stretched to 16:9 looks bad. Set `aspectRatio` to match target frame proportions.
