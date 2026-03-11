---
assumes: blueprint/shaders/overview
---
# Shader: Metaballs

Assumes: `blueprint/shaders/overview`

Organic fluid simulation — blobs merge and separate with surface tension. Like a lava lamp or oil-in-water.

## Parameters

`count(N)` blob count (fewer = cleaner) · `size(N)` blob scale (larger = calmer) · `speed(N)` energy level · Custom colors as positional args

## Param Reference

- `f[(metaballs(#09090B,#3B82F6,#8B5CF6,#06B6D4))]` — vibrant brand palette
- `f[(metaballs(#F59E0B,#EF4444,count(6),size(0.9)))]` — warm amber-red
- `f[(metaballs(#0A0A0A,#064E3B,#065F46,speed(0.3)))]` — atmospheric dark forest

## Examples

**Shader window — content over metaballs with dim overlay:**
```
fr s(480,280) clip rd(20) "Section"
  r s(fill,fill) f[(metaballs(#FFFEFE,#00FFA7,#C40CFF,#0031FF,#FF9D00,speed(0.40),count(11),size(0.40),scale(1.50)))] "BG"
  r s(fill,fill) f[(solid(#0B0B09,o(0.50)))] "Dim"
  al(v,a(c,c),g(12),pad(40)) s(fill,fill) "Content"
    t("Organic Motion",Inter,28,sb,c) f[(#FAFAFA)] "Title"
    t("Fluid blobs merge and separate",Inter,14,c) s(fill,hug) f[(solid(#FAFAFA,o(0.70)))] "Sub"
```

**Decorative accent bar:**
```
r s(4,48) f[(metaballs(#F59E0B,#EF4444,#EC4899))] rd(2) "Bar"
```

## Color Tips

Dark muted → atmospheric depth. Warm golds → luxury. Vibrant brand → energy. Desaturated pastels → subtle sophistication. Default palette is safe; custom colors make it yours.
