---
assumes: blueprint/shaders/overview
dsl: [metaballs, count, density, speed]
---
# Shader: Metaballs

Assumes: `blueprint/shaders/overview`

Organic fluid simulation — blobs merge and separate with surface tension. Like a lava lamp or oil-in-water.

## Parameters

`count(N)` blob count (fewer = cleaner) · `size(N)` blob scale (larger = calmer) · `speed(N)` energy level · Custom colors as positional args

## Density Presets (size × count)

Size and count are coupled — pick a density, then adjust speed:
- **Detailed:** `size(0.2),count(15),speed(0.4)` — complex, textured
- **Balanced:** `size(0.5),count(7),speed(0.5)` — default go-to
- **Organic:** `size(0.7),count(5),speed(0.35)` — calm, natural
- **Ambient:** `size(0.85),count(4),speed(0.3)` — meditative, background

## Recommended Palettes

- `f[(metaballs(#09090B,#F97316,#8B5CF6,#06B6D4))]` — vibrant blue/purple
- `f[(metaballs(#F59E0B,#EF4444,#EC4899))]` — warm sunset
- `f[(metaballs(#FFFEFE,#00FFA7,#C40CFF,#0031FF,#FF9D00))]` — rainbow burst
- `f[(metaballs(#F5F5F4,#D6D3D1,#A8A29E,#E7E5E4))]` — warm stone (light)
- `f[(metaballs(#FFFBEB,#FEF3C7,#FCD34D,#F59E0B))]` — honey gold (light)

## Examples

**Shader window — content over metaballs with dim overlay:**
```
fr s(480,280) clip rd($radius.lg) f[(metaballs(#FFFEFE,#00FFA7,#C40CFF,#0031FF,#FF9D00,speed(0.40),count(11),size(0.40),scale(1.50))),(f2,solid(#0B0B09,o(0.50)))] "Section" #mb_section
  al(v,y(c),x(c),g($spacing.3),pad($spacing.8)) s(fill,fill) "Content" #mb_content
    t("Organic Motion",Inter,28,sb,align(c)) f[(#FAFAFA)] "Title" #mb_title
    t("Fluid blobs merge and separate",Inter,14,align(c)) s(fill,hug) f[(solid(#FAFAFA,o(0.70)))] "Sub" #mb_sub
```

**Decorative accent bar:**
```
r s(4,48) f[(metaballs(#F59E0B,#EF4444,#EC4899))] rd(2) "Bar" #mb_bar
```

## Color Tips

Dark muted → atmospheric depth. Warm golds → luxury. Vibrant brand → energy. Desaturated pastels → subtle sophistication. Default palette is safe; custom colors make it yours.
