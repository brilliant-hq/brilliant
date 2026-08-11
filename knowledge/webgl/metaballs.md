---
assumes: webgl/setup
---
# Metaballs: WebGL

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Count | uCount | 1–30 | 10 | Number of metaballs |
| Size | uSize | 0.05–1.0 | 0.3 | Base radius of each ball |
| Speed | uSpeed | 0–3 | 1.0 | Animation speed multiplier |

## Colors
- Color count: 5
- Color 0 = background fill
- Colors 1–4 = ball colors (cycled across balls)

## Fragment Shader

```glsl
#version 300 es
precision highp float;

// ─── Standard uniforms ───
uniform float uResolutionX;
uniform float uResolutionY;
uniform float uTime;
uniform float uOffsetX;
uniform float uOffsetY;

// ─── UV transform uniforms ───
uniform float uScale;
uniform float uUVOffsetX;
uniform float uUVOffsetY;
uniform float uRotation;

// ─── Element SDF geometry ───
uniform float uShapeType;
uniform float uCornerTL;
uniform float uCornerTR;
uniform float uCornerBL;
uniform float uCornerBR;

// Reference aspect ratio
uniform float uRefAspect;

// ─── Colors: 5 colors (vec4 RGBA each) ───
uniform vec4 uColor0;
uniform vec4 uColor1;
uniform vec4 uColor2;
uniform vec4 uColor3;
uniform vec4 uColor4;

uniform float uColorCount;

// ─── Shader-specific params ───
uniform float uCount;   // 1-30, default 10.0
uniform float uSize;    // 0.05-1.0, default 0.3
uniform float uSpeed;   // 0-3, default 1.0

uniform float uPixelRatio;

out vec4 fragColor;

const float TWO_PI = 6.28318530718;

// ═══════════════════════════════════════════════════════════════════
// Deterministic hash for per-ball constants
// ═══════════════════════════════════════════════════════════════════

float hash11(float p) {
    p = fract(p * 0.1031);
    p *= p + 33.33;
    p *= p + p;
    return fract(p);
}

// ═══════════════════════════════════════════════════════════════════
// Dithering to prevent color banding
// ═══════════════════════════════════════════════════════════════════

vec3 dither(vec3 color, vec2 fragCoord) {
    float noise = fract(sin(dot(fragCoord, vec2(12.9898, 78.233))) * 43758.5453);
    return color + (noise - 0.5) / 128.0;
}

// ═══════════════════════════════════════════════════════════════════
// Get color by index
// ═══════════════════════════════════════════════════════════════════

vec4 getColor(int idx) {
    if (idx == 0) return uColor0;
    if (idx == 1) return uColor1;
    if (idx == 2) return uColor2;
    if (idx == 3) return uColor3;
    return uColor4;
}

// ═══════════════════════════════════════════════════════════════════
// Compute animated ball position with smooth Lissajous trajectories
// ═══════════════════════════════════════════════════════════════════

vec2 ballPosition(int idx, float time) {
    float fi = float(idx);

    float phase1  = hash11(fi * 73.156) * TWO_PI;
    float phase2  = hash11(fi * 91.213) * TWO_PI;
    float rate1   = 0.3 + hash11(fi * 47.834) * 0.7;
    float rate2   = 0.25 + hash11(fi * 123.456) * 0.75;
    float radiusX = 0.15 + hash11(fi * 37.891) * 0.3;
    float radiusY = 0.15 + hash11(fi * 59.347) * 0.3;

    float secondary = 0.05 * sin(time * rate1 * 1.7 + phase2 * 2.0);

    return vec2(
        0.5 + radiusX * sin(time * rate1 + phase1) + secondary,
        0.5 + radiusY * cos(time * rate2 + phase2) + secondary * 0.7
    );
}

// ═══════════════════════════════════════════════════════════════════
// Per-ball radius variation
// ═══════════════════════════════════════════════════════════════════

float ballRadius(int idx, float baseSize) {
    float fi = float(idx);
    float variation = 0.6 + hash11(fi * 17.53) * 0.8;
    return baseSize * 0.25 * variation;
}

// ═══════════════════════════════════════════════════════════════════
// Main
// ═══════════════════════════════════════════════════════════════════

void main() {
    // gl_FragCoord is in physical (backing-store) pixels; the pattern is
    // defined in logical element pixels (engine parity). Legacy runtimes
    // that never set uPixelRatio leave it 0 -> treated as 1.
    float pxRatio = max(uPixelRatio, 1.0);
    vec2 fragCoord = vec2(gl_FragCoord.x / pxRatio, uResolutionY - gl_FragCoord.y / pxRatio);
    vec2 rawUV = (fragCoord - vec2(uOffsetX, uOffsetY)) / vec2(uResolutionX, uResolutionY);
    vec2 uv = rawUV - 0.5;
    float cosR = cos(uRotation);
    float sinR = sin(uRotation);
    uv = vec2(uv.x * cosR - uv.y * sinR, uv.x * sinR + uv.y * cosR);
    uv /= max(uScale, 0.01);
    uv += vec2(uUVOffsetX, uUVOffsetY);
    uv += 0.5;

    // Assemble background color
    vec4 bgColor = getColor(0);

    int colorCount = int(clamp(uColorCount, 2.0, 5.0));
    int ballCount = int(clamp(uCount, 2.0, 30.0));
    float ballSize = clamp(uSize, 0.05, 1.0);
    float t = uTime * uSpeed * 0.5;

    // Pixel size for anti-aliasing
    float pixelSize = 1.0 / min(uResolutionX, uResolutionY);

    // Aspect-correct UV so balls are circular
    vec2 aspectUV = vec2(uv.x * uRefAspect, uv.y);

    // Number of non-background colors available for balls
    int fgColorCount = int(max(float(colorCount - 1), 1.0));

    // ─── Accumulate metaball field and per-ball color contributions ───
    float totalInfluence = 0.0;
    vec3 weightedColor = vec3(0.0);
    float weightedAlpha = 0.0;
    float totalWeight = 0.0;

    // Power exponent for influence falloff (controls gooeyness)
    float power = 2.7;

    for (int i = 0; i < 30; i++) {
        if (i >= ballCount) break;

        // Ball position in aspect-corrected space
        vec2 bPos = ballPosition(i, t);
        vec2 bPosAspect = vec2(bPos.x * uRefAspect, bPos.y);

        // Ball radius
        float radius = ballRadius(i, ballSize);

        // Distance from this pixel to ball center
        float dist = length(aspectUV - bPosAspect);

        // Metaball influence: power falloff
        float safeDist = max(dist, 0.001);
        float influence = pow(radius / safeDist, power);

        totalInfluence += influence;

        // Per-ball color: cycle through available non-background colors
        int colorIdx = int(mod(float(i), float(fgColorCount))) + 1;
        vec4 bColor = getColor(colorIdx);

        // Weight this ball's color contribution by its influence
        weightedColor += bColor.rgb * influence;
        weightedAlpha += bColor.a * influence;
        totalWeight += influence;
    }

    // ─── Threshold the accumulated field ───
    float aaWidth = pixelSize * 8.0;
    float threshold = 1.0;
    float mask = smoothstep(threshold - aaWidth, threshold + aaWidth, totalInfluence);

    // ─── Normalize weighted color ───
    vec3 blobColor = (totalWeight > 0.001) ? weightedColor / totalWeight : vec3(0.5);
    float blobAlpha = (totalWeight > 0.001) ? weightedAlpha / totalWeight : 1.0;

    // ─── Interior shading for depth ───
    float interiorGlow = smoothstep(threshold, threshold * 4.0, totalInfluence);
    blobColor = mix(blobColor, blobColor * 1.15, interiorGlow * 0.3);

    // ─── Edge highlight: subtle bright rim at blob boundaries ───
    float edgeDist = abs(totalInfluence - threshold);
    float edgeHighlight = exp(-edgeDist * 15.0) * 0.12;
    blobColor += edgeHighlight;

    // ─── Composite: background outside blobs, blob color inside ───
    vec4 result;
    result.rgb = mix(bgColor.rgb, blobColor, mask);
    result.a = mix(bgColor.a, blobAlpha, mask);

    // ─── Dither to prevent banding ───
    result.rgb = dither(result.rgb, fragCoord);

    // Clamp to valid range
    result = clamp(result, 0.0, 1.0);

    // Premultiplied alpha output
    fragColor = vec4(result.rgb * result.a, result.a);
}
```

## Usage

```html
<canvas id="mb" style="width:400px;height:300px"></canvas>
<script>
const FRAG = document.querySelector('#mb-frag').textContent; // or inline the shader string
brilliantShader('mb', FRAG, {
  colors: ['#1a1a2e', '#e94560', '#0f3460', '#16213e', '#533483'],
  params: { uCount: 15, uSize: 0.3, uSpeed: 1.0 }
});
</script>
```
