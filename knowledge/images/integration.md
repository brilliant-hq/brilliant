---
assumes: images/prompts, blueprint/paint
---
# Image Generation: Integration

Assumes: `images/prompts`

## Parameters

`imageSize`: `"512px"` | `"1K"` (default) | `"2K"` | `"4K"`. There is no
`aspectRatio` parameter: the generated image lands as a fill on your
target element, so its proportions follow the element you created.

| Scenario | imageSize |
|----------|-----------|
| Draft / iteration | `"512px"` or `"1K"` |
| Card thumbnail | `"1K"` |
| Avatar | `"1K"` |
| Hero background | `"2K"` |
| Product hero | `"2K"` |
| Final marketing | `"4K"` |

## Workflow

Create the **target element first** (an `<objects>` block, or
`create_modify_elements` for sub-agents / external clients), then call
`generate_image` with that element's id or `#ref`. The image lands as a
**fill** on that element; `generate_image` does NOT auto-place a new
element (it only falls back to creating one if the target can't be
resolved). It returns the element id + asset path.

## Image in Layout

```
fr s(fill,400) f[(img(Assets/hero.png))] clip rd($radius.md) "Hero Image" #hero_img
```

## Text Over Image

Always add overlay for readability:
```
fr s(fill,500) f[(img(Assets/hero.png)),(f2,solid($neutral.intense,o($visibility.mid)))] clip "Hero" #hero
  al(v,y(c),x(c),g($spacing.md),pad($spacing.3xl)) s(fill,fill) #hero_content
    t("Headline",$font.family,$font.size.5xl,sb,align(c)) f[($neutral.hint)] #hero_title
```

## Parallel Generation

Call `generate_image` for ALL images in the same turn, tool executor runs concurrently. 10 parallel = same time as 1 sequential.

## Reference Images

Pass `referenceElementIds` to maintain style across generations.
