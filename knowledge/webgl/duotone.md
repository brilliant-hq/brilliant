---
assumes: webgl/setup
---
# Duotone: WebGL

Maps image luminance to a 2-color or 3-color gradient. Supports duotone (2 stops: dark/light) and tritone (3 stops: dark/mid/light, activated when color 3 alpha > 0). Per-color alpha controls tint strength, not output transparency.

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Contrast | `uContrast` | -1 .. 1 | 0 | Luminance contrast adjustment |
| Brightness | `uBrightness` | -1 .. 1 | 0 | Luminance brightness shift |
| Intensity | `uIntensity` | 0 .. 1 | 1 | Blend with original (1=full duotone) |
| Gamma | `uGamma` | 0.1 .. 3.0 | 1 | Midpoint curve (<1=highlight bias, >1=shadow bias) |
| Saturation | `uSaturation` | 0 .. 1 | 0 | Preserve original color saturation |
| Midpoint | `uMidpoint` | 0.1 .. 0.9 | 0.5 | Tritone midpoint position |
| Color 1 R | `uColor1R` | 0 .. 1 | 0 | Dark/shadow color red |
| Color 1 G | `uColor1G` | 0 .. 1 | 0 | Dark/shadow color green |
| Color 1 B | `uColor1B` | 0 .. 1 | 0.3 | Dark/shadow color blue |
| Color 1 A | `uColor1A` | 0 .. 1 | 1 | Dark color tint strength |
| Color 2 R | `uColor2R` | 0 .. 1 | 1 | Light/highlight color red |
| Color 2 G | `uColor2G` | 0 .. 1 | 0.8 | Light/highlight color green |
| Color 2 B | `uColor2B` | 0 .. 1 | 0.3 | Light/highlight color blue |
| Color 2 A | `uColor2A` | 0 .. 1 | 1 | Light color tint strength |
| Color 3 R | `uColor3R` | 0 .. 1 | 0 | Midtone color red (tritone) |
| Color 3 G | `uColor3G` | 0 .. 1 | 0 | Midtone color green |
| Color 3 B | `uColor3B` | 0 .. 1 | 0 | Midtone color blue |
| Color 3 A | `uColor3A` | 0 .. 1 | 0 | 0=duotone, >0=tritone enabled |

## Fragment Shader

```glsl
#version 300 es
precision highp float;

uniform float uResolutionX;
uniform float uResolutionY;
uniform float uScale;

uniform float uContrast;
uniform float uBrightness;
uniform float uIntensity;
uniform float uGamma;
uniform float uSaturation;
uniform float uMidpoint;

uniform float uColor1R;
uniform float uColor1G;
uniform float uColor1B;
uniform float uColor1A;
uniform float uColor2R;
uniform float uColor2G;
uniform float uColor2B;
uniform float uColor2A;
uniform float uColor3R;
uniform float uColor3G;
uniform float uColor3B;
uniform float uColor3A;

out vec4 fragColor;
uniform sampler2D uInputImage;

const vec3 LUM = vec3(0.2126, 0.7152, 0.0722);

void main() {
    vec2 fragCoord = vec2(gl_FragCoord.x, uResolutionY - gl_FragCoord.y);
    vec2 uv = fragCoord / vec2(uResolutionX, uResolutionY);

    vec4 color = texture(uInputImage, uv);

    if (color.a < 0.001) {
        fragColor = color;
        return;
    }

    vec3 rgb = color.rgb / color.a;

    float lum = dot(rgb, LUM);

    if (abs(uBrightness) > 0.001) {
        lum = clamp(lum + uBrightness, 0.0, 1.0);
    }

    if (abs(uContrast) > 0.001) {
        float factor = (1.0 + uContrast);
        factor = factor * factor;
        lum = clamp((lum - 0.5) * factor + 0.5, 0.0, 1.0);
    }

    float gamma = max(uGamma, 0.1);
    if (abs(gamma - 1.0) > 0.001) {
        lum = pow(lum, gamma);
    }

    vec4 color1 = vec4(uColor1R, uColor1G, uColor1B, uColor1A);
    vec4 color2 = vec4(uColor2R, uColor2G, uColor2B, uColor2A);
    vec4 color3 = vec4(uColor3R, uColor3G, uColor3B, uColor3A);

    vec3 duotoneRgb;
    float colorStrength;
    if (color3.a > 0.001) {
        // Tritone mode
        float mp = clamp(uMidpoint, 0.01, 0.99);
        if (lum < mp) {
            float t = lum / mp;
            duotoneRgb = mix(color1.rgb, color3.rgb, t);
            colorStrength = mix(color1.a, color3.a, t);
        } else {
            float t = (lum - mp) / (1.0 - mp);
            duotoneRgb = mix(color3.rgb, color2.rgb, t);
            colorStrength = mix(color3.a, color2.a, t);
        }
    } else {
        // Duotone mode
        duotoneRgb = mix(color1.rgb, color2.rgb, lum);
        colorStrength = mix(color1.a, color2.a, lum);
    }

    float effectiveIntensity = uIntensity * colorStrength;
    vec3 result = mix(rgb, duotoneRgb, effectiveIntensity);

    if (uSaturation > 0.001) {
        float origLum = dot(rgb, LUM);
        vec3 chroma = rgb - vec3(origLum);
        result = clamp(result + chroma * uSaturation, 0.0, 1.0);
    }

    float resultAlpha = color.a;
    fragColor = vec4(result * resultAlpha, resultAlpha);
}
```

## Usage

```html
<img id="photo" src="photo.jpg" style="display:none">
<canvas id="duotoned" style="width:600px;height:400px"></canvas>
<script>
const FRAG = `... shader source above ...`;

// Classic duotone: dark blue to warm yellow
const filter = brilliantFilter('duotoned', 'photo', FRAG, {
  params: {
    uContrast: 0.0,
    uBrightness: 0.0,
    uIntensity: 1.0,
    uGamma: 1.0,
    uSaturation: 0.0,
    uMidpoint: 0.5,
    uColor1R: 0.05, uColor1G: 0.05, uColor1B: 0.3, uColor1A: 1.0,
    uColor2R: 1.0,  uColor2G: 0.85, uColor2B: 0.3, uColor2A: 1.0,
    uColor3R: 0.0,  uColor3G: 0.0,  uColor3B: 0.0, uColor3A: 0.0  // disabled
  }
});

// Enable tritone: add a midtone color (set color3 alpha > 0)
filter.setParam('uColor3R', 0.8);
filter.setParam('uColor3G', 0.2);
filter.setParam('uColor3B', 0.4);
filter.setParam('uColor3A', 1.0);
filter.setParam('uMidpoint', 0.45);
filter.update();
</script>
```
