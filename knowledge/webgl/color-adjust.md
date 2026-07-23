---
assumes: webgl/setup
---
# Color Adjust: WebGL

Comprehensive image adjustment filter: exposure, contrast, saturation, temperature, tint, highlights, shadows, brilliance, hue rotation, vibrance, inversion, sepia, whites, blacks, clarity, sharpness, and vignette.

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Exposure | `uExposure` | -1 .. 1 | 0 | EV-style multiplicative brightness |
| Contrast | `uContrast` | -1 .. 1 | 0 | S-curve around midpoint |
| Saturation | `uSaturation` | -1 .. 1 | 0 | Linear mix with luminance |
| Temperature | `uTemperature` | -1 .. 1 | 0 | White balance: neg=cool, pos=warm |
| Tint | `uTint` | -1 .. 1 | 0 | White balance: neg=green, pos=magenta |
| Highlights | `uHighlights` | -1 .. 1 | 0 | Adjust bright tones |
| Shadows | `uShadows` | -1 .. 1 | 0 | Adjust dark tones |
| Brilliance | `uBrilliance` | -1 .. 1 | 0 | Adaptive tone mapping |
| Hue Rotation | `uHueRotation` | radians | 0 | RGB hue rotation matrix |
| Vibrance | `uVibrance` | -1 .. 1 | 0 | Smart saturation (boosts unsaturated more) |
| Inversion | `uInversion` | 0 .. 1 | 0 | 0=normal, 1=inverted |
| Sepia | `uSepia` | 0 .. 1 | 0 | 0=none, 1=full sepia |
| Whites | `uWhites` | -1 .. 1 | 0 | Adjust very bright tones |
| Blacks | `uBlacks` | -1 .. 1 | 0 | Adjust very dark tones |
| Clarity | `uClarity` | -1 .. 1 | 0 | Midtone local contrast |
| Sharpness | `uSharpness` | -1 .. 1 | 0 | Edge enhancement |
| Vignette | `uVignette` | -1 .. 1 | 0 | Radial darkening (pos) or lightening (neg) |

## Fragment Shader

```glsl
#version 300 es
precision highp float;

uniform float uResolutionX;
uniform float uResolutionY;

uniform float uExposure;
uniform float uContrast;
uniform float uSaturation;
uniform float uTemperature;
uniform float uTint;
uniform float uHighlights;
uniform float uShadows;
uniform float uBrilliance;
uniform float uHueRotation;
uniform float uVibrance;
uniform float uInversion;
uniform float uSepia;
uniform float uWhites;
uniform float uBlacks;
uniform float uClarity;
uniform float uSharpness;
uniform float uVignette;

out vec4 fragColor;
uniform sampler2D uInputImage;

const vec3 LUM = vec3(0.2126, 0.7152, 0.0722);

void main() {
    vec2 fragCoord = vec2(gl_FragCoord.x, uResolutionY - gl_FragCoord.y);
    vec2 uv = fragCoord / vec2(uResolutionX, uResolutionY);

    vec4 texel = texture(uInputImage, uv);

    float a = texel.a;
    if (a < 0.001) {
        fragColor = vec4(0.0);
        return;
    }

    vec3 color = texel.rgb / a;

    // 1. Exposure
    color *= pow(2.0, uExposure);

    // 2. Temperature + Tint
    color.r += uTemperature * 0.15;
    color.b -= uTemperature * 0.15;
    color.g -= uTint * 0.1;
    color.r += uTint * 0.05;
    color.b += uTint * 0.05;

    // 3. Highlights
    float lum = dot(color, LUM);
    float highlightMask = smoothstep(0.35, 0.85, lum);
    color += uHighlights * highlightMask * 0.35;

    // 4. Shadows
    float shadowMask = 1.0 - smoothstep(0.15, 0.65, lum);
    color += uShadows * shadowMask * 0.35;

    // 4b. Whites
    float whitesMask = smoothstep(0.65, 1.0, lum);
    color += uWhites * whitesMask * 0.4;

    // 4c. Blacks
    float blacksMask = 1.0 - smoothstep(0.0, 0.35, lum);
    color += uBlacks * blacksMask * 0.4;

    // 5. Brilliance
    if (abs(uBrilliance) > 0.001) {
        float brillLum = clamp(dot(color, LUM), 0.0, 1.0);
        float gamma = 1.0 / (1.0 + uBrilliance * 0.6);
        float curved = pow(max(brillLum, 0.0001), gamma);

        float protection;
        if (uBrilliance > 0.0) {
            protection = smoothstep(0.5, 1.0, brillLum) * uBrilliance * 0.7;
        } else {
            protection = smoothstep(0.5, 0.0, brillLum) * (-uBrilliance) * 0.4;
        }
        float newLum = mix(curved, brillLum, protection);

        if (brillLum > 0.001) {
            color *= newLum / brillLum;
        } else {
            color += newLum - brillLum;
        }
    }

    // 6. Contrast
    float contrastFactor = 1.0 + uContrast;
    color = (color - 0.5) * contrastFactor + 0.5;

    // 7. Saturation
    float satLum = dot(color, LUM);
    color = mix(vec3(satLum), color, 1.0 + uSaturation);

    // 8. Vibrance
    float maxC = max(color.r, max(color.g, color.b));
    float minC = min(color.r, min(color.g, color.b));
    float currentSat = (maxC > 0.001) ? (maxC - minC) / maxC : 0.0;
    float vibBoost = (1.0 - currentSat) * uVibrance;
    float vibLum = dot(color, LUM);
    color = mix(vec3(vibLum), color, 1.0 + vibBoost);

    // 8b. Clarity & Sharpness
    if (abs(uClarity) > 0.001 || abs(uSharpness) > 0.001) {
        vec2 texelSize = 1.0 / vec2(uResolutionX, uResolutionY);

        vec4 tN = texture(uInputImage, uv + vec2(0.0, -texelSize.y));
        vec4 tS = texture(uInputImage, uv + vec2(0.0,  texelSize.y));
        vec4 tW = texture(uInputImage, uv + vec2(-texelSize.x, 0.0));
        vec4 tE = texture(uInputImage, uv + vec2( texelSize.x, 0.0));

        vec3 cN = tN.a > 0.001 ? tN.rgb / tN.a : vec3(0.0);
        vec3 cS = tS.a > 0.001 ? tS.rgb / tS.a : vec3(0.0);
        vec3 cW = tW.a > 0.001 ? tW.rgb / tW.a : vec3(0.0);
        vec3 cE = tE.a > 0.001 ? tE.rgb / tE.a : vec3(0.0);

        if (abs(uClarity) > 0.001) {
            float localAvgLum = dot((cN + cS + cW + cE) * 0.25, LUM);
            float centerLum = dot(color, LUM);
            float midtoneMask = smoothstep(0.0, 0.3, centerLum) * smoothstep(1.0, 0.7, centerLum);
            float detail = (centerLum - localAvgLum) * uClarity * 0.6 * midtoneMask;
            color += detail;
        }

        if (abs(uSharpness) > 0.001) {
            vec3 laplacian = 4.0 * color - (cN + cS + cW + cE);
            color += laplacian * uSharpness * 0.3;
        }
    }

    // 9. Hue rotation
    if (abs(uHueRotation) > 0.001) {
        float cosH = cos(uHueRotation);
        float sinH = sin(uHueRotation);
        mat3 hueMatrix = mat3(
            0.213 + cosH * 0.787 - sinH * 0.213,
            0.213 - cosH * 0.213 + sinH * 0.143,
            0.213 - cosH * 0.213 - sinH * 0.787,
            0.715 - cosH * 0.715 - sinH * 0.715,
            0.715 + cosH * 0.285 + sinH * 0.140,
            0.715 - cosH * 0.715 + sinH * 0.715,
            0.072 - cosH * 0.072 + sinH * 0.928,
            0.072 - cosH * 0.072 - sinH * 0.283,
            0.072 + cosH * 0.928 + sinH * 0.072
        );
        color = hueMatrix * color;
    }

    // 10. Sepia
    if (uSepia > 0.001) {
        vec3 sepiaColor = vec3(
            dot(color, vec3(0.393, 0.769, 0.189)),
            dot(color, vec3(0.349, 0.686, 0.168)),
            dot(color, vec3(0.272, 0.534, 0.131))
        );
        color = mix(color, sepiaColor, uSepia);
    }

    // 11. Inversion
    color = mix(color, 1.0 - color, uInversion);

    // 12. Vignette
    if (abs(uVignette) > 0.001) {
        vec2 centered = uv - 0.5;
        float dist = length(centered) * 1.414;
        float vignetteMask = smoothstep(0.2, 1.0, dist);
        if (uVignette > 0.0) {
            color *= 1.0 - uVignette * vignetteMask * 0.6;
        } else {
            color = mix(color, vec3(1.0), (-uVignette) * vignetteMask * 0.6);
        }
    }

    color = clamp(color, 0.0, 1.0);
    fragColor = vec4(color * a, a);
}
```

## Usage

```html
<img id="photo" src="photo.jpg" style="display:none">
<canvas id="adjusted" style="width:600px;height:400px"></canvas>
<script>
const FRAG = `... shader source above ...`;

const filter = brilliantFilter('adjusted', 'photo', FRAG, {
  params: {
    uExposure: 0.3,
    uContrast: 0.15,
    uSaturation: -0.2,
    uTemperature: 0.1,
    uTint: 0.0,
    uHighlights: -0.1,
    uShadows: 0.2,
    uBrilliance: 0.0,
    uHueRotation: 0.0,
    uVibrance: 0.3,
    uInversion: 0.0,
    uSepia: 0.0,
    uWhites: 0.0,
    uBlacks: 0.0,
    uClarity: 0.2,
    uSharpness: 0.1,
    uVignette: 0.3
  }
});

// Update individual params
filter.setParam('uExposure', -0.5);
filter.update();
</script>
```
