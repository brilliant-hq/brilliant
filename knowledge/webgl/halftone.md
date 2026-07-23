---
assumes: webgl/setup
---
# Halftone: WebGL

Halftone dot pattern filter with standard (luminance-based) and CMYK modes. Supports circle, diamond, and line dot shapes on square or hex grids. Colors are specified as individual R/G/B float uniforms; alpha values are packed into a single float.

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Mode | `uMode` | 0 or 1 | 0 | 0=standard, 1=CMYK |
| Dot Size | `uDotSize` | 1 .. 50 | 8 | Dot size in logical pixels |
| Angle | `uAngle` | 0 .. 360 | 45 | Pattern rotation (degrees, standard mode) |
| Shape | `uShape` | 0, 1, 2 | 0 | 0=circle, 1=diamond, 2=line |
| Grid | `uGrid` | 0 or 1 | 0 | 0=square, 1=hex |
| Contrast | `uContrast` | 0 .. 1 | 0.5 | Luminance contrast |
| Inverted | `uInverted` | 0 .. 1 | 0 | Continuous inversion amount |
| Original Colors | `uOriginalColors` | 0 or 1 | 0 | 0=custom colors, 1=source image colors |
| Softness | `uSoftness` | 0 .. 1 | 0 | Dot edge softness |
| Gain | `uGain` | 0 .. 2 | 1 | Dot radius multiplier (>1 = overflow) |
| Min Dot | `uMinDot` | 0 .. 0.5 | 0 | Minimum dot size in light areas |
| Packed Alphas | `uAlphas` | float | - | Packed alpha encoding (see below) |
| BG Color R | `uColorBackR` | 0 .. 1 | 1 | Background red |
| BG Color G | `uColorBackG` | 0 .. 1 | 1 | Background green |
| BG Color B | `uColorBackB` | 0 .. 1 | 1 | Background blue |
| FG Color R | `uColorFrontR` | 0 .. 1 | 0 | Foreground red |
| FG Color G | `uColorFrontG` | 0 .. 1 | 0 | Foreground green |
| FG Color B | `uColorFrontB` | 0 .. 1 | 0 | Foreground blue |
| Cyan R | `uCyanR` | 0 .. 1 | 0 | Cyan ink red (CMYK mode) |
| Cyan G | `uCyanG` | 0 .. 1 | 1 | Cyan ink green |
| Cyan B | `uCyanB` | 0 .. 1 | 1 | Cyan ink blue |
| Magenta R | `uMagentaR` | 0 .. 1 | 1 | Magenta ink red |
| Magenta G | `uMagentaG` | 0 .. 1 | 0 | Magenta ink green |
| Magenta B | `uMagentaB` | 0 .. 1 | 1 | Magenta ink blue |
| Yellow R | `uYellowR` | 0 .. 1 | 1 | Yellow ink red |
| Yellow G | `uYellowG` | 0 .. 1 | 1 | Yellow ink green |
| Yellow B | `uYellowB` | 0 .. 1 | 0 | Yellow ink blue |
| Black Lum | `uBlackLum` | 0 .. 1 | 0 | Black ink luminance |

### Alpha Packing

- **Standard mode:** `floor(bgAlpha * 100) * 101 + floor(fgAlpha * 100)`, 1% precision for 2 alphas
- **CMYK mode:** `round(cA*31)*32768 + round(mA*31)*1024 + round(yA*31)*32 + round(kA*31)`, ~3% precision for 4 alphas

## Fragment Shader

```glsl
#version 300 es
precision highp float;

uniform float uResolutionX;
uniform float uResolutionY;
uniform float uScale;

uniform float uMode;
uniform float uDotSize;
uniform float uAngle;
uniform float uShape;
uniform float uGrid;
uniform float uContrast;
uniform float uInverted;
uniform float uOriginalColors;
uniform float uSoftness;
uniform float uGain;
uniform float uMinDot;

uniform float uAlphas;

uniform float uColorBackR;
uniform float uColorBackG;
uniform float uColorBackB;
uniform float uColorFrontR;
uniform float uColorFrontG;
uniform float uColorFrontB;

uniform float uCyanR;
uniform float uCyanG;
uniform float uCyanB;
uniform float uMagentaR;
uniform float uMagentaG;
uniform float uMagentaB;
uniform float uYellowR;
uniform float uYellowG;
uniform float uYellowB;
uniform float uBlackLum;

out vec4 fragColor;
uniform sampler2D uInputImage;

const vec3 LUM = vec3(0.2126, 0.7152, 0.0722);
const float PI = 3.14159265;

vec2 unpackStdAlphas(float packedVal) {
    float a1 = floor(packedVal / 101.0);
    float a2 = packedVal - a1 * 101.0;
    return clamp(vec2(a1, a2) / 100.0, 0.0, 1.0);
}

vec4 unpackCmykAlphas(float packedVal) {
    float cA = floor(packedVal / 32768.0);
    float rem1 = packedVal - cA * 32768.0;
    float mA = floor(rem1 / 1024.0);
    float rem2 = rem1 - mA * 1024.0;
    float yA = floor(rem2 / 32.0);
    float kA = rem2 - yA * 32.0;
    return clamp(vec4(cA, mA, yA, kA) / 31.0, 0.0, 1.0);
}

vec3 sampleAt(vec2 logicalPos) {
    vec2 resolution = vec2(uResolutionX, uResolutionY);
    vec2 suv = clamp((logicalPos * uScale) / resolution, 0.0, 1.0);
    vec4 sc = texture(uInputImage, suv);
    return sc.a > 0.001 ? sc.rgb / sc.a : vec3(0.0);
}

float cmykExtract(vec3 srgb, int ch) {
    float kVal = 1.0 - max(srgb.r, max(srgb.g, srgb.b));
    if (ch == 3) return kVal;
    float invK = 1.0 - kVal;
    if (invK < 0.001) return 0.0;
    if (ch == 0) return (1.0 - srgb.r - kVal) / invK;
    if (ch == 1) return (1.0 - srgb.g - kVal) / invK;
    return (1.0 - srgb.b - kVal) / invK;
}

float cmykMask(vec2 logicalCoord, float cellSize, float angleRad, int ch) {
    float cosA = cos(angleRad);
    float sinA = sin(angleRad);
    vec2 rotCoord = vec2(
        logicalCoord.x * cosA - logicalCoord.y * sinA,
        logicalCoord.x * sinA + logicalCoord.y * cosA
    );

    float maxMask = 0.0;
    float ew = uSoftness * 0.35;

    if (uGrid < 0.5) {
        vec2 baseCell = floor(rotCoord / cellSize);
        for (int dy = -1; dy <= 1; dy++) {
            for (int dx = -1; dx <= 1; dx++) {
                if (uGain <= 1.001 && (dx != 0 || dy != 0)) continue;

                vec2 ncCenter = (baseCell + vec2(float(dx), float(dy)) + 0.5) * cellSize;
                vec2 lsp = vec2(ncCenter.x * cosA + ncCenter.y * sinA, -ncCenter.x * sinA + ncCenter.y * cosA);
                vec3 srgb = sampleAt(lsp);

                float val = cmykExtract(srgb, ch);
                val = clamp((val - 0.5) * (1.0 + uContrast * 2.0) + 0.5, 0.0, 1.0);
                val = mix(val, 1.0 - val, uInverted);

                float dotRadius = val * 0.5 * uGain;
                if (dx == 0 && dy == 0) dotRadius = max(dotRadius, uMinDot * 0.5);

                vec2 cf = (rotCoord - ncCenter) / cellSize;

                float dist;
                if (uShape < 0.5) dist = length(cf);
                else if (uShape < 1.5) dist = abs(cf.x) + abs(cf.y);
                else dist = abs(cf.y);

                float m;
                if (ew < 0.001) m = step(dist, dotRadius);
                else m = smoothstep(dotRadius + ew, dotRadius - ew, dist);

                maxMask = max(maxMask, m);
            }
        }
    } else {
        float h = cellSize;
        float w = h * 1.7320508;
        float halfW = w * 0.5;
        float halfH = h * 0.5;

        vec2 gridA = vec2(floor(rotCoord.x / w), floor(rotCoord.y / h));
        vec2 centerA = vec2(gridA.x * w, gridA.y * h);
        vec2 centerB = vec2((gridA.x + 0.5) * w, (gridA.y + 0.5) * h);
        float distA = length(rotCoord - centerA);
        float distB = length(rotCoord - centerB);
        vec2 cc = distA < distB ? centerA : centerB;

        for (int n = 0; n < 7; n++) {
            if (uGain <= 1.001 && n > 0) continue;

            vec2 nc;
            if (n == 0) nc = cc;
            else if (n == 1) nc = cc + vec2(halfW, halfH);
            else if (n == 2) nc = cc + vec2(halfW, -halfH);
            else if (n == 3) nc = cc + vec2(-halfW, halfH);
            else if (n == 4) nc = cc + vec2(-halfW, -halfH);
            else if (n == 5) nc = cc + vec2(w, 0.0);
            else nc = cc + vec2(-w, 0.0);

            vec2 lsp = vec2(nc.x * cosA + nc.y * sinA, -nc.x * sinA + nc.y * cosA);
            vec3 srgb = sampleAt(lsp);

            float val = cmykExtract(srgb, ch);
            val = clamp((val - 0.5) * (1.0 + uContrast * 2.0) + 0.5, 0.0, 1.0);
            val = mix(val, 1.0 - val, uInverted);

            float dotRadius = val * 0.5 * uGain;
            if (n == 0) dotRadius = max(dotRadius, uMinDot * 0.5);

            vec2 cf = (rotCoord - nc) / cellSize;

            float dist;
            if (uShape < 0.5) dist = length(cf);
            else if (uShape < 1.5) dist = abs(cf.x) + abs(cf.y);
            else dist = abs(cf.y);

            float m;
            if (ew < 0.001) m = step(dist, dotRadius);
            else m = smoothstep(dotRadius + ew, dotRadius - ew, dist);

            maxMask = max(maxMask, m);
        }
    }

    return maxMask;
}

void main() {
    vec2 fragCoord = vec2(gl_FragCoord.x, uResolutionY - gl_FragCoord.y);
    vec2 resolution = vec2(uResolutionX, uResolutionY);
    vec2 uv = fragCoord / resolution;

    vec4 color = texture(uInputImage, uv);

    if (color.a < 0.001) {
        fragColor = color;
        return;
    }

    vec3 rgb = color.rgb / color.a;

    vec2 logicalCoord = fragCoord / uScale;

    float cellSize = max(uDotSize, 1.0);

    // CMYK Mode
    if (uMode > 0.5) {
        vec4 cmykAlphas = unpackCmykAlphas(uAlphas);

        float angleC = 15.0 * PI / 180.0;
        float angleM = 75.0 * PI / 180.0;
        float angleY = 0.0;
        float angleK = 45.0 * PI / 180.0;

        float maskC = cmykMask(logicalCoord, cellSize, angleC, 0);
        float maskM = cmykMask(logicalCoord, cellSize, angleM, 1);
        float maskY = cmykMask(logicalCoord, cellSize, angleY, 2);
        float maskK = cmykMask(logicalCoord, cellSize, angleK, 3);

        vec3 cyanInk = vec3(uCyanR, uCyanG, uCyanB);
        vec3 magentaInk = vec3(uMagentaR, uMagentaG, uMagentaB);
        vec3 yellowInk = vec3(uYellowR, uYellowG, uYellowB);
        vec3 blackInk = vec3(uBlackLum);

        vec3 halftoneResult = vec3(uColorBackR, uColorBackG, uColorBackB);
        halftoneResult -= maskC * cmykAlphas.x * (vec3(1.0) - cyanInk);
        halftoneResult -= maskM * cmykAlphas.y * (vec3(1.0) - magentaInk);
        halftoneResult -= maskY * cmykAlphas.z * (vec3(1.0) - yellowInk);
        halftoneResult -= maskK * cmykAlphas.w * (vec3(1.0) - blackInk);
        halftoneResult = clamp(halftoneResult, 0.0, 1.0);

        float maxAlpha = max(max(cmykAlphas.x, cmykAlphas.y), max(cmykAlphas.z, cmykAlphas.w));
        vec3 result = mix(rgb, halftoneResult, maxAlpha);

        fragColor = vec4(result * color.a, color.a);
        return;
    }

    // Standard Halftone Mode
    vec2 stdAlphas = unpackStdAlphas(uAlphas);
    float bgAlpha = stdAlphas.x;
    float fgAlpha = stdAlphas.y;

    float angleRad = uAngle * PI / 180.0;
    float cosA = cos(angleRad);
    float sinA = sin(angleRad);
    vec2 rotCoord = vec2(
        logicalCoord.x * cosA - logicalCoord.y * sinA,
        logicalCoord.x * sinA + logicalCoord.y * cosA
    );

    float maxMask = 0.0;
    vec3 bestCellRgb = vec3(0.0);
    float ew = uSoftness * 0.35;

    if (uGrid < 0.5) {
        vec2 baseCell = floor(rotCoord / cellSize);
        for (int dy = -1; dy <= 1; dy++) {
            for (int dx = -1; dx <= 1; dx++) {
                if (uGain <= 1.001 && (dx != 0 || dy != 0)) continue;

                vec2 ncCenter = (baseCell + vec2(float(dx), float(dy)) + 0.5) * cellSize;
                vec2 lsp = vec2(ncCenter.x * cosA + ncCenter.y * sinA, -ncCenter.x * sinA + ncCenter.y * cosA);
                vec3 srgb = sampleAt(lsp);
                float lum = dot(srgb, LUM);

                float adjLum = clamp((lum - 0.5) * (1.0 + uContrast * 2.0) + 0.5, 0.0, 1.0);
                adjLum = mix(adjLum, 1.0 - adjLum, uInverted);

                float dotRadius = (1.0 - adjLum) * 0.5 * uGain;
                if (dx == 0 && dy == 0) dotRadius = max(dotRadius, uMinDot * 0.5);

                vec2 cf = (rotCoord - ncCenter) / cellSize;

                float dist;
                if (uShape < 0.5) dist = length(cf);
                else if (uShape < 1.5) dist = abs(cf.x) + abs(cf.y);
                else dist = abs(cf.y);

                float m;
                if (ew < 0.001) m = step(dist, dotRadius);
                else m = smoothstep(dotRadius + ew, dotRadius - ew, dist);

                if (m > maxMask) {
                    maxMask = m;
                    bestCellRgb = srgb;
                }
            }
        }
    } else {
        float h = cellSize;
        float w = h * 1.7320508;
        float halfW = w * 0.5;
        float halfH = h * 0.5;

        vec2 gridA = vec2(floor(rotCoord.x / w), floor(rotCoord.y / h));
        vec2 centerA = vec2(gridA.x * w, gridA.y * h);
        vec2 centerB = vec2((gridA.x + 0.5) * w, (gridA.y + 0.5) * h);
        float distA = length(rotCoord - centerA);
        float distB = length(rotCoord - centerB);
        vec2 cc = distA < distB ? centerA : centerB;

        for (int n = 0; n < 7; n++) {
            if (uGain <= 1.001 && n > 0) continue;

            vec2 nc;
            if (n == 0) nc = cc;
            else if (n == 1) nc = cc + vec2(halfW, halfH);
            else if (n == 2) nc = cc + vec2(halfW, -halfH);
            else if (n == 3) nc = cc + vec2(-halfW, halfH);
            else if (n == 4) nc = cc + vec2(-halfW, -halfH);
            else if (n == 5) nc = cc + vec2(w, 0.0);
            else nc = cc + vec2(-w, 0.0);

            vec2 lsp = vec2(nc.x * cosA + nc.y * sinA, -nc.x * sinA + nc.y * cosA);
            vec3 srgb = sampleAt(lsp);
            float lum = dot(srgb, LUM);

            float adjLum = clamp((lum - 0.5) * (1.0 + uContrast * 2.0) + 0.5, 0.0, 1.0);
            adjLum = mix(adjLum, 1.0 - adjLum, uInverted);

            float dotRadius = (1.0 - adjLum) * 0.5 * uGain;
            if (n == 0) dotRadius = max(dotRadius, uMinDot * 0.5);

            vec2 cf = (rotCoord - nc) / cellSize;

            float dist;
            if (uShape < 0.5) dist = length(cf);
            else if (uShape < 1.5) dist = abs(cf.x) + abs(cf.y);
            else dist = abs(cf.y);

            float m;
            if (ew < 0.001) m = step(dist, dotRadius);
            else m = smoothstep(dotRadius + ew, dotRadius - ew, dist);

            if (m > maxMask) {
                maxMask = m;
                bestCellRgb = srgb;
            }
        }
    }

    vec3 bgColor = vec3(uColorBackR, uColorBackG, uColorBackB);
    vec3 fgColor = vec3(uColorFrontR, uColorFrontG, uColorFrontB);

    vec3 effectiveBg = mix(rgb, bgColor, bgAlpha);
    vec3 effectiveFg;
    if (uOriginalColors > 0.5) {
        effectiveFg = mix(rgb, bestCellRgb, fgAlpha);
    } else {
        effectiveFg = mix(rgb, fgColor, fgAlpha);
    }

    vec3 result = mix(effectiveBg, effectiveFg, maxMask);

    fragColor = vec4(result * color.a, color.a);
}
```

## Usage

```html
<img id="photo" src="photo.jpg" style="display:none">
<canvas id="halftoned" style="width:600px;height:400px"></canvas>
<script>
const FRAG = `... shader source above ...`;

// Standard mode: black dots on white
const filter = brilliantFilter('halftoned', 'photo', FRAG, {
  params: {
    uMode: 0.0,
    uDotSize: 8.0,
    uAngle: 45.0,
    uShape: 0.0,
    uGrid: 0.0,
    uContrast: 0.5,
    uInverted: 0.0,
    uOriginalColors: 0.0,
    uSoftness: 0.1,
    uGain: 1.0,
    uMinDot: 0.0,
    uAlphas: 100.0 * 101.0 + 100.0,  // bgAlpha=1.0, fgAlpha=1.0
    uColorBackR: 1.0, uColorBackG: 1.0, uColorBackB: 1.0,
    uColorFrontR: 0.0, uColorFrontG: 0.0, uColorFrontB: 0.0,
    uCyanR: 0.0, uCyanG: 1.0, uCyanB: 1.0,
    uMagentaR: 1.0, uMagentaG: 0.0, uMagentaB: 1.0,
    uYellowR: 1.0, uYellowG: 1.0, uYellowB: 0.0,
    uBlackLum: 0.0
  }
});

// CMYK mode example:
// Pack 4 alphas: all at 1.0 => round(1.0*31)*32768 + round(1.0*31)*1024 + round(1.0*31)*32 + round(1.0*31)
// = 31*32768 + 31*1024 + 31*32 + 31 = 1015808 + 31744 + 992 + 31 = 1048575
// filter.setParam('uMode', 1.0);
// filter.setParam('uAlphas', 1048575.0);
// filter.update();
</script>
```
