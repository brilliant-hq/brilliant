---
assumes: webgl/setup
---
# Dither: WebGL

Ordered and noise dithering filter with Bayer matrix (2x2, 4x4, 8x8), white noise, and blue noise (Interleaved Gradient Noise) patterns. Supports two-color mode with custom palette or original image color preservation.

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Levels | `uLevels` | 2 .. 16 | 4 | Output color levels |
| Pattern Size | `uPatternSize` | 2, 4, 8 | 4 | Bayer matrix size (ignored for noise patterns) |
| Pattern | `uPattern` | 0, 1, 2 | 0 | 0=Bayer, 1=White Noise, 2=Blue Noise (IGN) |
| Pixel Size | `uPixelSize` | 1 .. 50 | 1 | Upscale dither dots |
| Contrast | `uContrast` | 0 .. 1 | 0.5 | Threshold contrast strength |
| Brightness | `uBrightness` | -1 .. 1 | 0 | Luminance offset |
| Original Colors | `uOriginalColors` | 0 or 1 | 1 | 0=custom 2-color, 1=dither original colors |
| BG Color R | `uColorBackR` | 0 .. 1 | 0 | Background color red |
| BG Color G | `uColorBackG` | 0 .. 1 | 0 | Background color green |
| BG Color B | `uColorBackB` | 0 .. 1 | 0 | Background color blue |
| BG Color A | `uColorBackA` | 0 .. 1 | 1 | Background color tint strength |
| FG Color R | `uColorFrontR` | 0 .. 1 | 1 | Foreground color red |
| FG Color G | `uColorFrontG` | 0 .. 1 | 1 | Foreground color green |
| FG Color B | `uColorFrontB` | 0 .. 1 | 1 | Foreground color blue |
| FG Color A | `uColorFrontA` | 0 .. 1 | 1 | Foreground color tint strength |

## Fragment Shader

```glsl
#version 300 es
precision highp float;

uniform float uResolutionX;
uniform float uResolutionY;
uniform float uScale;

uniform float uLevels;
uniform float uPatternSize;
uniform float uPattern;
uniform float uPixelSize;
uniform float uContrast;
uniform float uBrightness;
uniform float uOriginalColors;

uniform float uColorBackR;
uniform float uColorBackG;
uniform float uColorBackB;
uniform float uColorBackA;
uniform float uColorFrontR;
uniform float uColorFrontG;
uniform float uColorFrontB;
uniform float uColorFrontA;

out vec4 fragColor;
uniform sampler2D uInputImage;

const vec3 LUM = vec3(0.2126, 0.7152, 0.0722);

float hash(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

float interleavedGradientNoise(vec2 pos) {
    return fract(52.9829189 * fract(0.06711056 * pos.x + 0.00583715 * pos.y));
}

float bayer2(vec2 pos) {
    vec2 p = floor(pos);
    float px = mod(p.x, 2.0);
    float py = mod(p.y, 2.0);
    if (px < 0.5 && py < 0.5) return 0.0 / 4.0;
    if (px >= 0.5 && py < 0.5) return 2.0 / 4.0;
    if (px < 0.5 && py >= 0.5) return 3.0 / 4.0;
    return 1.0 / 4.0;
}

float bayer4(vec2 pos) {
    vec2 p = floor(pos);
    float px = mod(p.x, 4.0);
    float py = mod(p.y, 4.0);
    float coarse = bayer2(vec2(px / 2.0, py / 2.0));
    float fine = bayer2(vec2(px, py));
    return coarse + fine / 4.0;
}

float bayer8(vec2 pos) {
    vec2 p = floor(pos);
    float px = mod(p.x, 8.0);
    float py = mod(p.y, 8.0);
    float coarse = bayer4(vec2(px / 2.0, py / 2.0));
    float fine = bayer2(vec2(px, py));
    return coarse + fine / 16.0;
}

void main() {
    vec2 fragCoord = vec2(gl_FragCoord.x, uResolutionY - gl_FragCoord.y);
    vec2 uv = fragCoord / vec2(uResolutionX, uResolutionY);

    vec4 color = texture(uInputImage, uv);

    if (color.a < 0.001) {
        fragColor = color;
        return;
    }

    vec3 rgb = color.rgb / color.a;

    vec2 logicalCoord = fragCoord / uScale;

    float pixSize = max(uPixelSize, 1.0);
    vec2 patternCoord = floor(logicalCoord / pixSize);

    float threshold;
    if (uPattern < 0.5) {
        if (uPatternSize < 3.0) {
            threshold = bayer2(patternCoord);
        } else if (uPatternSize < 6.0) {
            threshold = bayer4(patternCoord);
        } else {
            threshold = bayer8(patternCoord);
        }
    } else if (uPattern < 1.5) {
        threshold = hash(patternCoord);
    } else {
        threshold = interleavedGradientNoise(patternCoord);
    }

    float contrastScale = mix(0.2, 1.0, uContrast);
    threshold = (threshold - 0.5) * contrastScale;

    float brightnessOffset = uBrightness;

    if (uOriginalColors > 0.5) {
        float levels = max(uLevels, 2.0);
        float factor = levels - 1.0;
        vec3 adjusted = clamp(rgb + vec3(brightnessOffset), 0.0, 1.0);
        vec3 dithered = floor(adjusted * factor + threshold + 0.5) / factor;
        dithered = clamp(dithered, 0.0, 1.0);

        fragColor = vec4(dithered * color.a, color.a);
    } else {
        float lum = dot(rgb, LUM);
        lum = clamp(lum + brightnessOffset, 0.0, 1.0);
        float levels = max(uLevels, 2.0);
        float factor = levels - 1.0;
        float ditheredLum = floor(lum * factor + threshold + 0.5) / factor;
        ditheredLum = clamp(ditheredLum, 0.0, 1.0);

        vec4 bgColor = vec4(uColorBackR, uColorBackG, uColorBackB, uColorBackA);
        vec4 fgColor = vec4(uColorFrontR, uColorFrontG, uColorFrontB, uColorFrontA);
        vec3 ditheredColor = mix(bgColor.rgb, fgColor.rgb, ditheredLum);
        float colorStrength = mix(bgColor.a, fgColor.a, ditheredLum);
        vec3 result = mix(rgb, ditheredColor, colorStrength);

        fragColor = vec4(result * color.a, color.a);
    }
}
```

## Usage

```html
<img id="photo" src="photo.jpg" style="display:none">
<canvas id="dithered" style="width:600px;height:400px"></canvas>
<script>
const FRAG = `... shader source above ...`;

// Classic 1-bit Bayer dither: black and white
const filter = brilliantFilter('dithered', 'photo', FRAG, {
  params: {
    uLevels: 2.0,
    uPatternSize: 4.0,
    uPattern: 0.0,       // Bayer
    uPixelSize: 1.0,
    uContrast: 0.5,
    uBrightness: 0.0,
    uOriginalColors: 0.0,
    uColorBackR: 0.0, uColorBackG: 0.0, uColorBackB: 0.0, uColorBackA: 1.0,
    uColorFrontR: 1.0, uColorFrontG: 1.0, uColorFrontB: 1.0, uColorFrontA: 1.0
  }
});

// Blue noise dither with original colors
filter.setParam('uPattern', 2.0);
filter.setParam('uOriginalColors', 1.0);
filter.setParam('uLevels', 4.0);
filter.update();
</script>
```
