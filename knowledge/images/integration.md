---
assumes: images/prompts, blueprint/paint
---
# Image Generation: Integration

Assumes: `images/prompts`

## Parameters

`imageSize`: `"1K"` (default) | `"2K"` | `"4K"`. There is no
`aspectRatio` parameter: the generated image lands as a fill on your
target element, so its proportions follow the element you created.

| Scenario | imageSize |
|----------|-----------|
| Draft / iteration | `"1K"` |
| Card thumbnail | `"1K"` |
| Avatar | `"1K"` |
| Hero background | `"2K"` |
| Product hero | `"2K"` |
| Final marketing | `"4K"` |

## Workflow

Create the **target element first** (a `bl` fence, in an `<edit>` block or
through `edit`), then call `generate_image` with that element's id or `#ref`.
The image lands as a **fill** on that element; `generate_image` does NOT
auto-place a new element (it creates one only if the target can't be resolved).
On an element that already has an image fill, only the picture changes: that
fill keeps its scale mode, tile scale, opacity and blend, and the element's
other fills (an overlay, a tint) stay. Otherwise the element's fills become the
one image fill. It returns the element id + asset path. A requested generated
asset is never replaced with canvas shapes without asking the user first.

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

## Subject In Front Of Type

A cutout subject may overlap a headline (a poster move), but every letter must still read: the subject's opaque pixels may tuck behind part of a letter, never hide one whole. The edit result names any letter an image above the text covers (`The I in "MILK" (#headline) is covered by #bottle`); move the subject or the type until the note is gone.

Parallel generation, reference images, and cutting out a real photo: `images/references`.
