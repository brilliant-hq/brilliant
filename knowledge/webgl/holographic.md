---
assumes: webgl/setup
---
# Holographic — WebGL

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Shape | uShape | 0-2 | 0 | 0=Element, 1=Metaballs, 2=None |
| Intensity | uIntensity | 0-1 | 0.7 | Iridescence strength |
| Spread | uSpread | 0-1 | 0.5 | Fold density |
| Angle | uAngle | 0-360 | 45.0 | Fold direction (degrees) |
| Noise | uNoise | 0-1 | 0.5 | Fold complexity |
| Metallic | uMetallic | 0-1 | 0.5 | Reflectivity/shininess |
| Speed | uSpeed | 0-3 | 1.0 | Animation speed |
| Metaball Count | uMetaballCount | 2-15 | 8 | Number of metaballs (shape=1) |
| Metaball Size | uMetaballSize | 0.1-3.0 | 1.0 | Metaball size multiplier (shape=1) |

## Colors

3 colors:
- **uColor0** — Primary tint (e.g. pink/magenta)
- **uColor1** — Secondary tint (e.g. teal/cyan)
- **uColor2** — Accent/shadow (e.g. gold or dark)

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

// ─── Colors: 3 colors (vec4 RGBA each) ───
uniform vec4 uColor0;
uniform vec4 uColor1;
uniform vec4 uColor2;

uniform float uColorCount;

// ─── Shader-specific params ───
uniform float uShape;
uniform float uIntensity;
uniform float uSpread;
uniform float uAngle;
uniform float uNoise;
uniform float uMetallic;
uniform float uSpeed;
uniform float uMetaballCount;
uniform float uMetaballSize;

out vec4 fragColor;

// ═══════════════════════════════════════════════════════════════════
// Simplex Noise
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

// ─── Deterministic hash for per-ball constants ───
float hash11(float p) {
    p = fract(p * 0.1031);
    p *= p + 33.33;
    p *= p + p;
    return fract(p);
}

// ─── Element-aware SDF ───

float sdRoundedBox(vec2 p, vec2 b, vec4 r) {
    float cr = mix(mix(r.x, r.y, step(0.0, p.x)),
                   mix(r.z, r.w, step(0.0, p.x)),
                   step(0.0, p.y));
    vec2 q = abs(p) - b + cr;
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - cr;
}

float elementSDF(vec2 uv) {
    float aspect = uResolutionX / max(uResolutionY, 1.0);
    vec2 p = (uv - 0.5) * vec2(aspect, 1.0);
    vec2 halfSize = vec2(aspect * 0.5, 0.5);
    if (uShapeType < 0.5) {
        vec4 radii = vec4(uCornerTL, uCornerTR, uCornerBL, uCornerBR) * min(halfSize.x, halfSize.y);
        return sdRoundedBox(p, halfSize, radii);
    } else if (uShapeType < 1.5) {
        return length(p / halfSize) - 1.0;
    }
    return length(p / halfSize) - 1.0;
}

// ═══════════════════════════════════════════════════════════════════
// Shape SDF System
// ═══════════════════════════════════════════════════════════════════

float sdMetaballs(vec2 p, float t) {
    int count = int(clamp(uMetaballCount, 2.0, 30.0));
    float size = clamp(uMetaballSize, 0.1, 3.0);
    float sum = 0.0;
    for (int i = 0; i < 30; i++) {
        if (i >= count) break;
        float fi = float(i);
        float phase1  = hash11(fi * 73.156) * 6.28318;
        float phase2  = hash11(fi * 91.213) * 6.28318;
        float rate1   = 0.3 + hash11(fi * 47.834) * 0.7;
        float rate2   = 0.25 + hash11(fi * 123.456) * 0.75;
        float radiusX = 0.15 + hash11(fi * 37.891) * 0.3;
        float radiusY = 0.15 + hash11(fi * 59.347) * 0.3;
        float secondary = 0.05 * sin(t * rate1 * 1.7 + phase2 * 2.0);
        vec2 center = vec2(
            radiusX * sin(t * rate1 + phase1) + secondary,
            radiusY * cos(t * rate2 + phase2) + secondary * 0.7
        );
        float variation = 0.6 + hash11(fi * 17.53) * 0.8;
        float r = 0.08 * variation * size;
        float d = length(p - center);
        sum += r * r / (d * d + 0.001);
    }
    return 1.0 - sum;
}

// Edge proximity field: 0 = deep inside, 1 = at boundary
float getEdgeField(vec2 uv, float elemD, int shape, float t) {
    if (shape == 2) return 0.0;

    float elemEdge = 1.0 - smoothstep(0.0, 0.2, abs(elemD));

    if (shape == 0) {
        float warpN = snoise(uv * 5.0 + vec2(t * 0.3, -t * 0.2));
        float warpedD = elemD + warpN * 0.04;

        float narrowEdge = 1.0 - smoothstep(0.0, 0.12, abs(warpedD));
        float wideGlow = exp(-abs(warpedD) * 5.0) * 0.65;

        return max(narrowEdge, wideGlow);
    }

    // shape == 1: Metaballs
    vec2 p = uv - 0.5;
    float d = sdMetaballs(p, t);

    float shapeEdge = 1.0 - smoothstep(0.0, 0.15, abs(d));

    return max(shapeEdge, elemEdge);
}

// Shape opacity mask: 1 inside, 0 outside
float getShapeMask(vec2 uv, vec2 rawUV, int shape, float t) {
    if (shape == 0 || shape == 2) return 1.0;

    float elemD = elementSDF(rawUV);
    float elemMask = 1.0 - smoothstep(-0.01, 0.01, elemD);

    // shape == 1: Metaballs
    vec2 p = uv - 0.5;
    float d = sdMetaballs(p, t);

    float shapeMask = 1.0 - smoothstep(-0.01, 0.01, d);

    return min(shapeMask, elemMask);
}

// ═══════════════════════════════════════════════════════════════════
// Fabric Height Field
// ═══════════════════════════════════════════════════════════════════

float fabricHeight(vec2 p, float t, float ca, float sa, float foldDensity, float complexity) {
    vec2 rp = vec2(p.x * ca + p.y * sa, -p.x * sa + p.y * ca);

    float w1 = snoise(p * 1.2 + vec2(t * 0.25, t * 0.18));
    float w2 = snoise(p * 1.2 + vec2(t * 0.15 + 50.0, -t * 0.2 + 30.0));
    vec2 warp = vec2(w1, w2) * (0.2 + complexity * 0.5);

    vec2 warped = rp + warp;

    float h = sin(warped.x * foldDensity + w1 * 2.5) * 0.35;
    h += sin(warped.y * foldDensity * 0.6 + w2 * 2.0) * 0.12;

    float detail = snoise((warped + warp * 0.5) * foldDensity * 0.8 + vec2(t * 0.1));
    h += detail * 0.18 * (0.5 + complexity * 0.5);

    float fine = snoise(warped * foldDensity * 2.0 + vec2(-t * 0.08, t * 0.05));
    h += fine * 0.06 * complexity;

    return h;
}

// ═══════════════════════════════════════════════════════════════════
// Iridescent Spectrum
// ═══════════════════════════════════════════════════════════════════

vec3 iridescentColor(float normalAngle, float curvature, vec3 col0, vec3 col1, vec3 col2, float spread) {
    float phase = normalAngle * (1.5 + spread * 3.0);

    float r = 0.5 + 0.5 * cos(phase * 6.28318);
    float g = 0.5 + 0.5 * cos(phase * 6.28318 - 2.094);
    float b = 0.5 + 0.5 * cos(phase * 6.28318 - 4.189);
    vec3 spectrum = vec3(r, g, b);

    float total = r + g + b + 0.001;
    vec3 tinted = col0 * (r / total) + col1 * (g / total) + col2 * (b / total);

    vec3 result = mix(tinted, spectrum, 0.25);

    float lum = dot(result, vec3(0.299, 0.587, 0.114));
    result = mix(vec3(lum), result, 1.2 + curvature * 0.6);

    return clamp(result, 0.0, 1.0);
}

// ═══════════════════════════════════════════════════════════════════
// Dithering
// ═══════════════════════════════════════════════════════════════════

vec3 dither(vec3 color, vec2 fc) {
    float n = fract(sin(dot(fc, vec2(12.9898, 78.233))) * 43758.5453);
    return color + (n - 0.5) / 128.0;
}

// ═══════════════════════════════════════════════════════════════════
// Main
// ═══════════════════════════════════════════════════════════════════

void main() {
    vec2 fragCoord = vec2(gl_FragCoord.x, uResolutionY - gl_FragCoord.y);

    // ─── UV computation ───
    vec2 resolution = vec2(uResolutionX, uResolutionY);
    vec2 rawUV = (fragCoord - vec2(uOffsetX, uOffsetY)) / resolution;
    vec2 uv = rawUV - 0.5;
    float cosR = cos(uRotation);
    float sinR = sin(uRotation);
    uv = vec2(uv.x * cosR - uv.y * sinR, uv.x * sinR + uv.y * cosR);
    uv /= max(uScale * 4.0, 0.01);
    uv += vec2(uUVOffsetX, uUVOffsetY);
    uv += 0.5;

    vec2 uvAspect = uv;
    uvAspect.x *= uRefAspect;

    // User colors
    vec3 color0     = uColor0.rgb;
    float baseAlpha = uColor0.a;
    vec3 color1     = uColor1.rgb;
    vec3 color2     = uColor2.rgb;

    // ─── Parameters ───
    int shape       = int(clamp(uShape, 0.0, 2.0));
    float intensity = clamp(uIntensity, 0.0, 1.0);
    float spread    = clamp(uSpread, 0.0, 1.0);
    float angle     = radians(uAngle);
    float complexity = clamp(uNoise, 0.0, 1.0);
    float metallic  = clamp(uMetallic, 0.0, 1.0);
    float t = uTime * 0.1;

    float ca = cos(angle);
    float sa = sin(angle);

    float foldDensity = 4.0 + spread * 10.0;

    // ═══════════════════════════════════════════════════════
    // 1. SHAPE SYSTEM — mask and edge field
    // ═══════════════════════════════════════════════════════

    float shapeMask = getShapeMask(uv, rawUV, shape, t * 6.0);
    float edgeField;
    if (shape == 2) {
        edgeField = 0.0;
    } else {
        float elemD = elementSDF(rawUV);
        edgeField = getEdgeField(uv, elemD, shape, t * 6.0);
    }

    // ═══════════════════════════════════════════════════════
    // 2. HEIGHT FIELD & SURFACE NORMALS
    // ═══════════════════════════════════════════════════════

    vec2 centerPt = vec2(uRefAspect * 0.5, 0.5);
    vec2 toCenter = centerPt - uvAspect;
    float toCenterLen = length(toCenter);
    vec2 warpDir = (toCenterLen > 0.001) ? toCenter / toCenterLen : vec2(0.0);
    vec2 warpedUV = uvAspect + warpDir * edgeField * edgeField * 0.04;

    float eps = 0.004;
    float h0 = fabricHeight(warpedUV, t, ca, sa, foldDensity, complexity);
    float hx = fabricHeight(warpedUV + vec2(eps, 0.0), t, ca, sa, foldDensity, complexity);
    float hy = fabricHeight(warpedUV + vec2(0.0, eps), t, ca, sa, foldDensity, complexity);

    float edgeCompression = edgeField * 0.4;
    h0 += sin(h0 * 12.0) * edgeCompression * 0.12;
    hx += sin(hx * 12.0) * edgeCompression * 0.12;
    hy += sin(hy * 12.0) * edgeCompression * 0.12;

    vec2 grad = vec2(h0 - hx, h0 - hy) / eps;
    float gradLen = length(grad);

    float normalAngle = atan(grad.y, grad.x) / 6.28318 + 0.5;
    float curvature = clamp(gradLen * 0.3, 0.0, 1.0);

    // ═══════════════════════════════════════════════════════
    // 3. LIGHTING
    // ═══════════════════════════════════════════════════════

    vec2 lightDir = normalize(vec2(0.5, -0.6));

    vec2 normalDir = (gradLen > 0.001) ? grad / gradLen : vec2(0.0, -1.0);
    float diffuse = dot(normalDir, lightDir) * 0.5 + 0.5;
    diffuse = clamp(diffuse, 0.0, 1.0);
    diffuse = smoothstep(0.0, 1.0, diffuse);
    diffuse = mix(0.08, 1.0, diffuse);

    vec2 halfVec = normalize(lightDir + vec2(0.0, -1.0));
    float specDot = dot(normalDir, halfVec) * 0.5 + 0.5;
    float specPower = 16.0 + metallic * 48.0;
    float spec = pow(clamp(specDot, 0.0, 1.0), specPower);

    vec2 lightDir2 = normalize(vec2(-0.4, 0.5));
    float diffuse2 = dot(normalDir, lightDir2) * 0.5 + 0.5;
    diffuse2 = smoothstep(0.0, 1.0, diffuse2) * 0.25;

    float totalDiffuse = clamp(diffuse + diffuse2, 0.0, 1.0);

    // ═══════════════════════════════════════════════════════
    // 4. IRIDESCENT COLOR from surface normals
    // ═══════════════════════════════════════════════════════

    float iriPhase = normalAngle + t * 0.05;
    vec3 iriColor = iridescentColor(iriPhase, curvature, color0, color1, color2, spread);

    float iriPhase2 = normalAngle * 1.7 + t * 0.03 + 0.33;
    vec3 iriColor2 = iridescentColor(iriPhase2, curvature, color1, color2, color0, spread * 0.7);
    iriColor = mix(iriColor, iriColor2, 0.3);

    // ═══════════════════════════════════════════════════════
    // 5. COMPOSE FINAL COLOR
    // ═══════════════════════════════════════════════════════

    vec3 metalBase = mix(color2 * 0.3, mix(color0, color1, 0.5), totalDiffuse);
    metalBase *= 0.6 + metallic * 0.4;

    vec3 col = mix(metalBase, iriColor * totalDiffuse, intensity);

    vec3 specColor = mix(vec3(1.0), mix(color0, color1, 0.5), 0.15);
    col += specColor * spec * (0.5 + metallic * 0.8);

    float heightNorm = h0 * 0.5 + 0.5;
    float ao = smoothstep(-0.2, 0.4, heightNorm);
    ao = mix(0.3, 1.0, ao);
    col *= ao;

    float ridge = smoothstep(0.3, 0.7, heightNorm);
    col += iriColor * ridge * curvature * intensity * 0.3;

    col += iriColor * edgeField * edgeField * intensity * 0.25;

    col += specColor * edgeField * edgeField * spec * 0.2;

    // ─── Dither ───
    col = dither(col, fragCoord);
    col = clamp(col, 0.0, 1.0);

    // ─── Alpha with shape mask ───
    float alpha = baseAlpha * shapeMask;

    // ─── Premultiplied alpha output ───
    fragColor = vec4(col * alpha, alpha);
}
```

## Usage

```html
<!DOCTYPE html>
<html><head><style>
  body { margin: 0; background: #111; display: flex; justify-content: center; align-items: center; height: 100vh; }
  canvas { width: 480px; height: 320px; border-radius: 16px; }
</style></head><body>
<canvas id="c"></canvas>
<script>
/* paste brilliantShader runtime from setup.md */
</script>
<script>
const FRAG = `... paste fragment shader above ...`;

brilliantShader('c', FRAG, {
  colors: ['#e91e8c', '#1ecbe9', '#d4a017'],
  params: {
    uShape: 0,
    uIntensity: 0.7,
    uSpread: 0.5,
    uAngle: 45.0,
    uNoise: 0.5,
    uMetallic: 0.5,
    uSpeed: 1.0,
    uMetaballCount: 8.0,
    uMetaballSize: 1.0
  },
  cornerRadius: [0.05, 0.05, 0.05, 0.05]
});
</script>
</body></html>
```
