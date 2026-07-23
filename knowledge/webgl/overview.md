---
assumes: webgl/setup
---
# WebGL Shader Export Overview

When exporting Brilliant designs to HTML, elements with shader fills or image filters need WebGL to render live (animated, interactive). Without WebGL, shaders export as static PNG snapshots.

## When to Use WebGL Export

- Element has a **shader fill**: `metaballs`, `liquidMetal`, `holographic`, `liquidStainlessSteel`, `dithering`, `reactiveGrid`
- Element has an **image filter**: `noiseGrain`, `halftone`, `pixelate`, `duotone`, `posterize`, `dither`, `colorAdjust`
- The design calls for **animation** or **interactivity** in the web output

## Which Knowledge to Load

| Blueprint fill syntax | Load knowledge | Type |
|-----------------------|----------------|------|
| `metaballs(...)` | `webgl/metaballs` | Procedural |
| `metal(...)` / `liquidMetal(...)` | `webgl/liquid-metal` | Procedural |
| `irid(...)` / `holographic(...)` | `webgl/holographic` | Procedural |
| `steel(...)` / `liquidStainlessSteel(...)` | `webgl/liquid-stainless-steel` | Procedural |
| `dithering(...)` | `webgl/dithering` | Procedural |
| `reactiveGrid(...)` | `webgl/reactive-grid` | Procedural + Interactive |
| Image filter: `noiseGrain` | `webgl/noise-grain` | Filter |
| Image filter: `halftone` | `webgl/halftone` | Filter |
| Image filter: `pixelate` | `webgl/pixelate` | Filter |
| Image filter: `duotone` | `webgl/duotone` | Filter |
| Image filter: `posterize` | `webgl/posterize` | Filter |
| Image filter: `dither` | `webgl/dither` | Filter |
| Image filter: `colorAdjust` | `webgl/color-adjust` | Filter |

Always load `webgl/setup` first (auto-loaded via `assumes`).

## Export Pattern: Procedural Shaders

```html
<div style="width:360px;height:220px;border-radius:16px;overflow:hidden;position:relative;">
  <canvas id="hero" style="width:100%;height:100%;display:block;"></canvas>
  <!-- Content on top of shader (e.g. text with overlay) -->
  <div style="position:absolute;inset:0;background:rgba(0,0,0,0.3);display:flex;align-items:center;justify-content:center;">
    <h1 style="color:white;">Title</h1>
  </div>
</div>
<script>
/* paste runtime from webgl/setup */
/* paste FRAG source from webgl/[shader] */
brilliantShader('hero', FRAG, {
  colors: ['#0D1B3E', '#1A3A5C', '#FF6B35'],
  params: { uCount: 15, uSize: 0.3, uSpeed: 1.0 },
  shape: 'rect',
  cornerRadius: [0.12, 0.12, 0.12, 0.12]
});
</script>
```

## Export Pattern: Image Filters

```html
<div style="width:360px;height:220px;position:relative;">
  <img id="photo" src="photo.jpg" crossorigin style="width:100%;height:100%;object-fit:cover;opacity:0;">
  <canvas id="filtered" style="position:absolute;inset:0;width:100%;height:100%;"></canvas>
</div>
<script>
/* paste runtime from webgl/setup */
/* paste FRAG source from webgl/[filter] */
brilliantFilter('filtered', 'photo', FRAG, {
  params: { uContrast: 0.2, uIntensity: 1.0 }
});
</script>
```

## Mapping Blueprint Values to WebGL Config

**Colors:** Blueprint tokens resolve to hex at render time. `metaballs($red.mid,$emerald.mid)` → `colors: ['<resolved red.500 hex>', '<resolved emerald.500 hex>']`. The WebGL config carries the resolved hex values; the blueprint side stays token-bound.

**Params:** Blueprint `size(0.3),count(15),speed(1.0)` → `params: { uSize: 0.3, uCount: 15, uSpeed: 1.0 }`

**UV Transform:** Blueprint `scale(2),uvrot(45)` → `scale: 2, rotation: 45`

**Shape:** Blueprint `shape(element)` → `shape: 'rect'` (with corner radius from the frame). Blueprint `shape(none)` → shape doesn't matter, set `shape: 'rect', cornerRadius: [0,0,0,0]`.

**Corner radius:** Normalize to 0-1 range: `cornerRadius / min(width, height) * 2`. For example, `rd(16)` on a 200x100 element → `16 / 100 * 2 = 0.32` → `cornerRadius: [0.32, 0.32, 0.32, 0.32]`.

**Frozen:** Blueprint `frozen` → `animate: false`

**Interactive:** Only for `reactiveGrid` → `interactive: true`
