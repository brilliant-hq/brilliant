---
assumes: webgl/setup
---
# Dithering: WebGL

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Shape | uShape | 0–6 | 0 | Pattern type: 0=simplex, 1=warp, 2=dots, 3=wave, 4=ripple, 5=swirl, 6=sphere |
| Dither Type | uDitherType | 0–3 | 2 | Dither algorithm: 0=random, 1=bayer 2x2, 2=bayer 4x4, 3=bayer 8x8 |
| Size | uSize | 1–20 | 4 | Dither grid cell size in pixels |
| Speed | uSpeed | 0–3 | 1.0 | Animation speed multiplier |

## Colors
- Color count: 2
- Color 0 = background color
- Color 1 = foreground (dither dot) color

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

// UV transform uniforms
uniform float uScale;
uniform float uUVOffsetX;
uniform float uUVOffsetY;
uniform float uRotation;

// Element SDF geometry
uniform float uShapeType;
uniform float uCornerTL;
uniform float uCornerTR;
uniform float uCornerBL;
uniform float uCornerBR;

// Reference aspect ratio
uniform float uRefAspect;

// ─── Colors: 2 colors (vec4 RGBA each) ───
uniform vec4 uColor0;  // background
uniform vec4 uColor1;  // foreground

uniform float uColorCount;

// ─── Shader-specific params ───
uniform float uShape;      // 0-6: pattern shape
uniform float uDitherType; // 0-3: dither algorithm
uniform float uSize;       // 1-20: dither grid size
uniform float uSpeed;      // 0-3: animation speed

uniform float uPixelRatio;

out vec4 fragColor;

// ═══════════════════════════════════════════════════════════════════
// Simplex Noise (standard 2D simplex, Gustavson algorithm)
// ═══════════════════════════════════════════════════════════════════

vec3 mod289v3(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289v2(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute3(vec3 x) { return mod289v3(((x * 34.0) + 10.0) * x); }

float snoise(vec2 v) {
    const vec4 C = vec4(0.211324865405187, 0.366025403784439,
                       -0.577350269189626, 0.024390243902439);
    vec2 i  = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec2 x1 = x0 - i1 + C.xx;
    vec2 x2 = x0 + C.zz;
    i = mod289v2(i);
    vec3 p = permute3(permute3(i.y + vec3(0.0, i1.y, 1.0))
                              + i.x + vec3(0.0, i1.x, 1.0));
    vec3 m = max(0.5 - vec3(dot(x0, x0), dot(x1, x1), dot(x2, x2)), 0.0);
    m = m * m;
    m = m * m;
    vec3 x  = 2.0 * fract(p * C.www) - 1.0;
    vec3 h  = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;
    m *= 1.79284291400159 - 0.85373472095314 * (a0 * a0 + h * h);
    vec3 g;
    g.x = a0.x * x0.x + h.x * x0.y;
    g.y = a0.y * x1.x + h.y * x1.y;
    g.z = a0.z * x2.x + h.z * x2.y;
    return 130.0 * dot(m, g);
}

// ═══════════════════════════════════════════════════════════════════
// Hash function for random dithering
// ═══════════════════════════════════════════════════════════════════

float hash21(vec2 p) {
    p = fract(p * vec2(234.34, 435.345));
    p += dot(p, p + 34.23);
    return fract(p.x * p.y);
}

// ═══════════════════════════════════════════════════════════════════
// Bayer Dithering Matrices
// ═══════════════════════════════════════════════════════════════════

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

// Get dither threshold based on type (0=random, 1=2x2, 2=4x4, 3=8x8)
float getDitherThreshold(vec2 pixelPos, int ditherType) {
    if (ditherType == 0) {
        return hash21(pixelPos);
    } else if (ditherType == 1) {
        return bayer2(pixelPos);
    } else if (ditherType == 2) {
        return bayer4(pixelPos);
    }
    return bayer8(pixelPos);
}

// ═══════════════════════════════════════════════════════════════════
// Pattern Functions (all return 0.0 to 1.0)
// ═══════════════════════════════════════════════════════════════════

// 0: Simplex, animated noise field
float patternSimplex(vec2 uv, float t) {
    float n = snoise(uv * 3.0 + vec2(t * 0.3, t * 0.2));
    return n * 0.5 + 0.5;
}

// 1: Warp, domain-warped noise for organic flowing patterns
float patternWarp(vec2 uv, float t) {
    float n1 = snoise(uv * 2.0 + vec2(t * 0.2));
    float n2 = snoise(uv * 2.0 + vec2(n1 * 1.5, t * 0.15 + 10.0));
    float n3 = snoise(uv * 3.0 + vec2(n2 * 1.2 + t * 0.1, n1 * 1.0));
    return n3 * 0.5 + 0.5;
}

// 2: Dots, regular grid with animated radius
float patternDots(vec2 uv, float t) {
    float freq = 6.0;
    vec2 cell = fract(uv * freq) - 0.5;
    float d = length(cell);
    float radius = 0.2 + 0.15 * sin(t * 0.8);
    return smoothstep(radius + 0.05, radius - 0.05, d);
}

// 3: Wave, sinusoidal wave pattern
float patternWave(vec2 uv, float t) {
    float wave = sin(uv.x * 12.0 + t * 1.2) * 0.3;
    wave += sin(uv.y * 8.0 - t * 0.9) * 0.2;
    wave += sin((uv.x + uv.y) * 6.0 + t * 0.7) * 0.15;
    return wave + 0.5;
}

// 4: Ripple, concentric rings expanding from center
float patternRipple(vec2 uv, float t) {
    vec2 centered = uv - 0.5;
    centered.x *= uRefAspect;
    float d = length(centered);
    float ripple = sin(d * 20.0 - t * 2.0) * 0.5 + 0.5;
    return ripple;
}

// 5: Swirl, spiraling pattern
float patternSwirl(vec2 uv, float t) {
    vec2 centered = uv - 0.5;
    centered.x *= uRefAspect;
    float d = length(centered);
    float angle = atan(centered.y, centered.x);
    float twist = 4.0;
    float spiral = sin(angle + d * twist + t * 1.5) * 0.5 + 0.5;
    float n = snoise(uv * 3.0 + vec2(t * 0.15));
    return mix(spiral, n * 0.5 + 0.5, 0.25);
}

// 6: Sphere, 3D sphere with animated lighting
float patternSphere(vec2 uv, float t) {
    vec2 centered = uv - 0.5;
    centered.x *= uRefAspect;
    float d = length(centered);
    float r = 0.45;
    if (d > r) return 0.0;
    float z = sqrt(r * r - d * d);
    vec3 normal = normalize(vec3(centered, z));
    vec3 lightDir = normalize(vec3(cos(t * 0.6), sin(t * 0.4), 1.2));
    float shading = dot(normal, lightDir) * 0.5 + 0.5;
    return shading;
}

// Select pattern by shape index
float getPattern(vec2 uv, float t, int shape) {
    if (shape == 0) return patternSimplex(uv, t);
    if (shape == 1) return patternWarp(uv, t);
    if (shape == 2) return patternDots(uv, t);
    if (shape == 3) return patternWave(uv, t);
    if (shape == 4) return patternRipple(uv, t);
    if (shape == 5) return patternSwirl(uv, t);
    return patternSphere(uv, t);
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

    // ─── UV computation ───
    vec2 resolution = vec2(uResolutionX, uResolutionY);
    vec2 rawUV = (fragCoord - vec2(uOffsetX, uOffsetY)) / resolution;

    // Transformed UV for pattern generation
    vec2 uv = rawUV - 0.5;
    float cosR = cos(uRotation);
    float sinR = sin(uRotation);
    uv = vec2(uv.x * cosR - uv.y * sinR, uv.x * sinR + uv.y * cosR);
    uv /= max(uScale, 0.01);
    uv += vec2(uUVOffsetX, uUVOffsetY);
    uv += 0.5;

    // ─── Parameters ───
    int shape = int(clamp(uShape, 0.0, 6.0));
    int ditherType = int(clamp(uDitherType, 0.0, 3.0));
    float gridSize = clamp(uSize, 1.0, 20.0);
    float t = uTime * uSpeed;

    // ─── Colors ───
    vec3 bgColor = uColor0.rgb;
    vec3 fgColor = uColor1.rgb;
    float baseAlpha = uColor0.a;

    // ─── Generate pattern value (0-1) ───
    float pattern = getPattern(uv, t, shape);
    pattern = clamp(pattern, 0.0, 1.0);

    // ─── Dither: quantize pixel position to grid, get threshold ───
    vec2 pixelPos = fragCoord / gridSize;
    float threshold = getDitherThreshold(pixelPos, ditherType);

    // Center threshold for balanced dithering
    threshold = threshold - 0.5;

    // Apply dithering: compare pattern against threshold
    float dithered = step(0.0, pattern + threshold - 0.5);

    // ─── Mix colors based on dithered result ───
    vec3 col = mix(bgColor, fgColor, dithered);

    // ─── Alpha ───
    float alpha = baseAlpha;

    // ─── Premultiplied alpha output ───
    fragColor = vec4(col * alpha, alpha);
}
```

## Usage

```html
<canvas id="dt" style="width:400px;height:300px"></canvas>
<script>
const FRAG = document.querySelector('#dt-frag').textContent; // or inline the shader string
brilliantShader('dt', FRAG, {
  colors: ['#1a1a2e', '#e94560'],
  params: { uShape: 0, uDitherType: 3, uSize: 5, uSpeed: 1.0 }
});
</script>
```
