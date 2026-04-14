---
assumes: webgl/setup
---
# Liquid Stainless Steel — WebGL

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Shape | uShape | 0-2 | 0 | 0=Element, 1=Metaballs, 2=None |
| Flow | uFlow | 0-1 | 0.5 | Wave intensity |
| Roughness | uRoughness | 0-1 | 0.3 | Surface roughness |
| Distortion | uDistortion | 0-1 | 0.3 | Organic warp |
| Depth | uDepth | 0-1 | 0.5 | Valley/peak contrast |
| Angle | uAngle | 0-360 | 45.0 | Flow direction (degrees) |
| Speed | uSpeed | 0-3 | 1.0 | Animation speed |
| Metaball Count | uMetaballCount | 2-30 | 8 | Number of metaballs (shape=1) |
| Metaball Size | uMetaballSize | 0.1-3.0 | 1.0 | Metaball size multiplier (shape=1) |

## Colors

2 colors:
- **uColor0** — Base metal tint
- **uColor1** — Highlight color

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
uniform vec4 uColor0;
uniform vec4 uColor1;

uniform float uColorCount;

// ─── Shader-specific params ───
uniform float uShape;
uniform float uFlow;
uniform float uRoughness;
uniform float uDistortion;
uniform float uDepth;
uniform float uAngle;
uniform float uSpeed;
uniform float uMetaballCount;
uniform float uMetaballSize;

out vec4 fragColor;

// ═══════════════════════════════════════════════════════════════════
// Simplex Noise
// ═══════════════════════════════════════════════════════════════════

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289v2(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x * 34.0) + 10.0) * x); }

float snoise(vec2 v) {
    const vec4 C = vec4(0.211324865405187, 0.366025403784439,
                       -0.577350269189626, 0.024390243902439);
    vec2 i  = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec2 x1 = x0 - i1 + C.xx;
    vec2 x2 = x0 + C.zz;
    i = mod289v2(i);
    vec3 p = permute(permute(i.y + vec3(0.0, i1.y, 1.0))
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
// Shapes: 0=Element, 1=Metaballs, 2=None
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
        return elemEdge;
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
// Flowing height field — thick undulating chrome waves
// ═══════════════════════════════════════════════════════════════════

float metalHeight(vec2 p, float t, float ca, float sa, float flow, float distort) {
    vec2 rp = vec2(p.x * ca + p.y * sa, -p.x * sa + p.y * ca);

    float m1 = snoise(rp * 0.3 + vec2(t * 0.2, t * 0.08));
    float m2 = snoise(rp * 0.25 + vec2(t * 0.15, t * 0.1) + vec2(40.0, 20.0));
    vec2 warped = rp + vec2(m1, m2) * (0.3 + distort * 0.5);

    float direction = warped.x + warped.y * 0.3 - t;

    float h = sin(direction * (1.0 + flow * 1.5)) * 0.6;
    h += sin(direction * (1.7 + flow * 0.8) + warped.y * 0.4) * 0.2;
    h += sin(direction * (0.4 + flow * 0.3) - warped.y * 0.2) * 0.15;

    return h;
}

// ═══════════════════════════════════════════════════════════════════
// Dithering
// ═══════════════════════════════════════════════════════════════════

vec3 dither(vec3 color, vec2 fc) {
    float noise = fract(sin(dot(fc, vec2(12.9898, 78.233))) * 43758.5453);
    return color + (noise - 0.5) / 128.0;
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
    uv /= max(uScale * 0.4, 0.01);
    uv += vec2(uUVOffsetX, uUVOffsetY);
    uv += 0.5;

    vec2 uvAspect = uv;
    uvAspect.x *= uRefAspect;

    // ─── Parameters ───
    int shape       = int(clamp(uShape, 0.0, 2.0));
    float flow      = clamp(uFlow, 0.0, 1.0);
    float roughness = clamp(uRoughness, 0.0, 1.0);
    float distort   = clamp(uDistortion, 0.0, 1.0);
    float depth     = clamp(uDepth, 0.0, 1.0);
    float angle     = radians(uAngle);
    float t = uTime * uSpeed * 0.12;

    float ca = cos(angle);
    float sa = sin(angle);

    // ─── User colors ───
    vec3 baseColor      = uColor0.rgb;
    float baseAlpha     = uColor0.a;
    vec3 highlightColor = uColor1.rgb;

    // ═══════════════════════════════════════════════════════
    // SHAPE SYSTEM — edge field & mask
    // ═══════════════════════════════════════════════════════

    float edgeField;
    if (shape == 2) {
        edgeField = 0.0;
    } else {
        float elemD = elementSDF(rawUV);
        edgeField = getEdgeField(uv, elemD, shape, t * 6.0);
    }
    float shapeMask = getShapeMask(uv, rawUV, shape, t * 6.0);

    // ═══════════════════════════════════════════════════════
    // 1. HEIGHT FIELD — flowing metallic surface
    // ═══════════════════════════════════════════════════════

    vec2 centerPt = vec2(uRefAspect * 0.5, 0.5);
    vec2 toCenter = centerPt - uvAspect;
    float toCenterLen = length(toCenter);
    vec2 warpDir = (toCenterLen > 0.001) ? toCenter / toCenterLen : vec2(0.0);
    vec2 warpedUV = uvAspect + warpDir * edgeField * edgeField * 0.15;

    float eps = 0.003;
    float h0 = metalHeight(warpedUV, t, ca, sa, flow, distort);
    float hx = metalHeight(warpedUV + vec2(eps, 0.0), t, ca, sa, flow, distort);
    float hy = metalHeight(warpedUV + vec2(0.0, eps), t, ca, sa, flow, distort);

    float edgeCompression = edgeField * 0.3;
    h0 += sin(h0 * 10.0) * edgeCompression * 0.12;
    hx += sin(hx * 10.0) * edgeCompression * 0.12;
    hy += sin(hy * 10.0) * edgeCompression * 0.12;

    vec2 grad = vec2(h0 - hx, h0 - hy) / eps;
    float gradLen = length(grad);

    // ═══════════════════════════════════════════════════════
    // 2. LIGHTING — multi-source for rich chrome reflections
    // ═══════════════════════════════════════════════════════

    vec2 normalDir = (gradLen > 0.001) ? grad / gradLen : vec2(0.0, -1.0);

    // Primary light — top-left
    vec2 lightDir1 = normalize(vec2(0.5, -0.7));
    float diff1 = dot(normalDir, lightDir1) * 0.5 + 0.5;
    diff1 = smoothstep(0.0, 1.0, diff1);

    // Secondary light — bottom-right (fill)
    vec2 lightDir2 = normalize(vec2(-0.4, 0.6));
    float diff2 = dot(normalDir, lightDir2) * 0.5 + 0.5;
    diff2 = smoothstep(0.0, 1.0, diff2) * 0.3;

    // Third light — side (rim)
    vec2 lightDir3 = normalize(vec2(0.8, 0.1));
    float diff3 = dot(normalDir, lightDir3) * 0.5 + 0.5;
    diff3 = smoothstep(0.0, 1.0, diff3) * 0.15;

    float totalDiffuse = clamp(diff1 + diff2 + diff3, 0.0, 1.0);

    // ─── Specular highlights ───
    vec2 halfVec1 = normalize(lightDir1 + vec2(0.0, -1.0));
    float specDot1 = dot(normalDir, halfVec1) * 0.5 + 0.5;
    float specPower = 24.0 + (1.0 - roughness) * 80.0;
    float spec1 = pow(clamp(specDot1, 0.0, 1.0), specPower);

    vec2 halfVec2 = normalize(lightDir2 + vec2(0.0, -1.0));
    float specDot2 = dot(normalDir, halfVec2) * 0.5 + 0.5;
    float specPower2 = 8.0 + (1.0 - roughness) * 24.0;
    float spec2 = pow(clamp(specDot2, 0.0, 1.0), specPower2) * 0.4;

    float totalSpec = spec1 + spec2;

    // ═══════════════════════════════════════════════════════
    // 3. ENVIRONMENT REFLECTION — chrome-like
    // ═══════════════════════════════════════════════════════

    vec2 reflectUV = normalDir * 0.3 + uvAspect * 0.1;
    float envNoise1 = snoise(reflectUV * 2.0 + vec2(t * 0.05)) * 0.5 + 0.5;
    float envNoise2 = snoise(reflectUV * 4.0 + vec2(-t * 0.03, t * 0.04)) * 0.5 + 0.5;
    float envReflect = mix(envNoise1, envNoise2, 0.4);

    float fresnel = clamp(gradLen * 0.6, 0.0, 1.0);
    fresnel = fresnel * fresnel;
    float reflectivity = 0.3 + (1.0 - roughness) * 0.5 + fresnel * 0.2;

    // ═══════════════════════════════════════════════════════
    // 4. COMPOSE METALLIC COLOR
    // ═══════════════════════════════════════════════════════

    float heightNorm = h0 * 0.5 + 0.5;
    float valleyDark = smoothstep(0.0, 0.5, heightNorm);
    valleyDark = mix(0.02, 1.0, valleyDark);

    float depthMask = mix(1.0, valleyDark, depth);

    vec3 darkMetal  = baseColor * 0.05;
    vec3 midMetal   = baseColor * 0.55;
    vec3 brightMetal = mix(baseColor, highlightColor, 0.3) * 0.95;

    vec3 metalBase = mix(darkMetal, midMetal, smoothstep(0.0, 0.4, totalDiffuse));
    metalBase = mix(metalBase, brightMetal, smoothstep(0.4, 1.0, totalDiffuse));

    metalBase *= depthMask;

    vec3 envColor = mix(midMetal, brightMetal, envReflect);
    vec3 col = mix(metalBase, envColor, reflectivity * 0.5);

    // ─── Specular highlights ───
    vec3 specColor = mix(highlightColor, vec3(1.0), 0.6);
    col += specColor * totalSpec * (0.6 + (1.0 - roughness) * 0.8);

    // ─── Ambient occlusion in creases ───
    float ao = smoothstep(-0.3, 0.3, heightNorm);
    ao = mix(0.15, 1.0, ao);
    col *= mix(1.0, ao, depth * 0.8);

    // ─── Ridge brightening ───
    float ridge = smoothstep(0.55, 0.75, heightNorm);
    col += highlightColor * ridge * totalSpec * 0.3;

    // ─── Curvature-based edge highlight (chrome catch-lights) ───
    float curvature = clamp(gradLen * 0.4, 0.0, 1.0);
    col += specColor * curvature * curvature * 0.15 * (1.0 - roughness);

    // ─── Shape edge glow: specular rim along shape boundary ───
    col += specColor * edgeField * edgeField * 0.25 * (1.0 - roughness);
    col += highlightColor * edgeField * edgeField * totalSpec * 0.3;

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
  colors: ['#b0b0b0', '#ffffff'],
  params: {
    uShape: 0,
    uFlow: 0.5,
    uRoughness: 0.3,
    uDistortion: 0.3,
    uDepth: 0.5,
    uAngle: 45.0,
    uSpeed: 1.0,
    uMetaballCount: 8.0,
    uMetaballSize: 1.0
  },
  cornerRadius: [0.05, 0.05, 0.05, 0.05]
});
</script>
</body></html>
```
