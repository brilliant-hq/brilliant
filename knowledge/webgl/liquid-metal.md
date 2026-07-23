---
assumes: webgl/setup
---
# Liquid Metal: WebGL

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Shape | uShape | 0-2 | 0 | 0=Element, 1=Metaballs, 2=None |
| Softness | uSoftness | 0-1 | 0.1 | Stripe transition softness |
| Repetition | uRepetition | 1-10 | 2.0 | Stripe density |
| Shift Red | uShiftRed | -1 to 1 | 0.3 | Red channel chromatic shift |
| Shift Blue | uShiftBlue | -1 to 1 | 0.3 | Blue channel chromatic shift |
| Distortion | uDistortion | 0-1 | 0.07 | Organic warp intensity |
| Contour | uContour | 0-1 | 0.4 | Edge contour compression |
| Angle | uAngle | 0-360 | 70.0 | Stripe direction (degrees) |
| Speed | uSpeed | 0-3 | 1.0 | Animation speed |
| Metaball Count | uMetaballCount | 2-15 | 8 | Number of metaballs (shape=1) |
| Metaball Size | uMetaballSize | 0.1-3.0 | 1.0 | Metaball size multiplier (shape=1) |

## Colors

2 colors:
- **uColor0**: Tint color (color-burned onto metallic base)
- **uColor1**: Highlight/accent color

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
uniform float uSoftness;
uniform float uRepetition;
uniform float uShiftRed;
uniform float uShiftBlue;
uniform float uDistortion;
uniform float uContour;
uniform float uAngle;
uniform float uSpeed;
uniform float uMetaballCount;
uniform float uMetaballSize;

out vec4 fragColor;

// ═══════════════════════════════════════════════════════════════════
// 2D Simplex Noise
// ═══════════════════════════════════════════════════════════════════

vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x * 34.0) + 10.0) * x); }

float snoise(vec2 v) {
    const vec4 C = vec4(0.211324865405187, 0.366025403784439,
                       -0.577350269189626, 0.024390243902439);
    vec2 i  = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);
    vec2 i1 = (x0.x > x0.y) ? vec2(1.0, 0.0) : vec2(0.0, 1.0);
    vec2 x1 = x0 - i1 + C.xx;
    vec2 x2 = x0 + C.zz;
    i = mod289(i);
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

// ─── Per-ball hash for unique orbital parameters ───
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
// SDF Shape System, generates edge field for each shape
// Returns 0 inside shape, 1 at boundary, >1 outside
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

// Compute edge field from shape SDF. Returns 0-1 where 0=deep interior, 1=boundary
// Shapes: 0=Element, 1=Metaballs, 2=None
float getEdgeField(vec2 uv, float elemD, int shape, float t, float softEdge) {
    if (shape == 2) return 0.0;

    float edgeWidth = 0.03 + softEdge * 0.1;

    // Element boundary field
    float elemEdge = 1.0 - smoothstep(-edgeWidth, edgeWidth, -elemD);
    float elemProx = 1.0 - smoothstep(0.0, 0.15, abs(elemD));
    float elemField = mix(elemEdge, elemProx, 0.5);

    if (shape == 0) {
        float warpN = snoise(uv * 5.0 + vec2(t * 0.3, -t * 0.2));
        float warpedD = elemD + warpN * 0.04;

        float narrowEdge = 1.0 - smoothstep(-edgeWidth, edgeWidth, -warpedD);
        float wideGlow = exp(-abs(warpedD) * 5.0) * 0.65;

        return max(narrowEdge, wideGlow);
    }

    // shape == 1: Metaballs
    vec2 p = uv - 0.5;
    float d = sdMetaballs(p, t);

    float edge = 1.0 - smoothstep(-edgeWidth, edgeWidth, -d);
    float proximity = 1.0 - smoothstep(0.0, 0.15, abs(d));
    float shapeField = mix(edge, proximity, 0.5);

    return max(shapeField, elemField);
}

// Shape opacity mask, 1 inside shape, 0 outside
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
// 3-Band Stripe, bump-modulated color banding
// ═══════════════════════════════════════════════════════════════════

float getColorChanges(float x, float softness, float bump) {
    float f = fract(x);

    float strip1 = 0.12 * (1.0 - 0.4 * bump);
    float strip2 = strip1 + 0.07 * (1.0 + 0.4 * bump);

    float edgeWidth = mix(0.002, 0.12, softness);

    float ramp0 = smoothstep(strip1 - edgeWidth, strip1 + edgeWidth, f);
    float ramp1 = smoothstep(strip2 - edgeWidth, strip2 + edgeWidth, f);
    float wrapDown = smoothstep(1.0 - edgeWidth * 2.0, 1.0, f);

    float bright = ramp0 * (1.0 - ramp1 * 0.5);
    float gradientPhase = clamp((f - strip2) / max(1.0 - strip2, 0.001), 0.0, 1.0);
    float gradientValue = 0.55 - 0.35 * gradientPhase;

    float result = mix(bright, gradientValue, ramp1 * (1.0 - wrapDown));
    result = mix(result, 0.0, wrapDown);

    return result;
}

// ═══════════════════════════════════════════════════════════════════
// Per-Channel Color Burn
// ═══════════════════════════════════════════════════════════════════

float colorBurnChannel(float ch, float tint, float tintAlpha) {
    float burned = 1.0 - min(1.0, (1.0 - ch) / max(tint, 0.0001));
    return mix(ch, burned, tintAlpha);
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
    uv /= max(uScale * 3.0, 0.01);
    uv += vec2(uUVOffsetX, uUVOffsetY);
    uv += 0.5;

    vec2 uvAspect = uv;
    uvAspect.x *= uRefAspect;

    // Assemble user colors
    vec4 color0 = uColor0;
    vec4 color1 = uColor1;

    // ─── Parameters ───
    int shape       = int(clamp(uShape, 0.0, 2.0));
    float softness  = clamp(uSoftness, 0.0, 1.0);
    float repetition = clamp(uRepetition, 1.0, 10.0);
    float shiftRed  = uShiftRed;
    float shiftBlue = uShiftBlue;
    float distortion = clamp(uDistortion, 0.0, 1.0);
    float contour   = clamp(uContour, 0.0, 3.0);
    float angle     = radians(uAngle);
    float t = uTime * uSpeed * 0.15;

    // ─── Shape system: edge field & mask ───
    float edge;
    if (shape == 2) {
        edge = 0.0;
    } else {
        float elemD = elementSDF(rawUV);
        edge = getEdgeField(uv, elemD, shape, t * 6.0, softness);
    }
    float shapeMask = getShapeMask(uv, rawUV, shape, t * 6.0);

    // ─── Bump / specular field ───
    vec2 bumpCenter = vec2(0.35 * uRefAspect, 0.35);
    float bumpDist = length(uvAspect - bumpCenter) / (0.5 * uRefAspect);
    float bump = 1.0 - clamp(bumpDist, 0.0, 1.0);
    bump = bump * bump;

    // ─── Rotate UV by angle for directional stripes ───
    vec2 center = vec2(uRefAspect * 0.5, 0.5);
    vec2 centered = uvAspect - center;
    float ca = cos(angle);
    float sa = sin(angle);
    mat2 rotMat = mat2(ca, -sa, sa, ca);
    vec2 rotUV = rotMat * centered + center;

    // ─── Direction field ───
    float direction = rotUV.x * repetition;
    direction += (rotUV.x + rotUV.y) * 0.3 * repetition;
    direction += t;

    float turbNoise = snoise(uvAspect * 3.5 + vec2(t * 0.3, -t * 0.2));
    float edgeTurb = turbNoise * 0.4 * (0.3 + edge * 0.7);
    direction += edgeTurb;

    float contourWarp = snoise(uvAspect * 4.0 + vec2(-t * 0.2, t * 0.15));
    direction += contour * edge * (contourWarp * 0.6 + 0.3);

    direction += bump * 0.15;

    // ─── Distortion: organic warp ───
    float warpNX = snoise(uvAspect * 2.5 + vec2(t * 0.4, t * 0.17));
    float warpNY = snoise(uvAspect * 2.5 + vec2(t * 0.23 + 5.0, t * 0.31 + 8.0));
    direction += (warpNX + warpNY) * distortion * 0.5;

    // ─── Chromatic aberration ───
    float dispersionBase = 0.08;
    float spatialDispersion = mix(1.0, 0.3, bump) * (0.5 + edge * 0.5);
    float noiseDispersion = abs(turbNoise) * 0.3;
    float dispersionR = shiftRed * (dispersionBase + noiseDispersion) * spatialDispersion;
    float dispersionB = shiftBlue * (dispersionBase + noiseDispersion) * spatialDispersion;

    float stripeR = fract(direction + dispersionR);
    float stripeG = fract(direction);
    float stripeB = fract(direction - dispersionB);

    // ─── 3-band pattern per channel with bump modulation ───
    float bandR = getColorChanges(stripeR, softness, bump);
    float bandG = getColorChanges(stripeG, softness, bump);
    float bandB = getColorChanges(stripeB, softness, bump);

    // ─── Metallic base ───
    vec3 darkMetal  = vec3(0.04, 0.04, 0.06);
    vec3 brightMetal = vec3(0.95, 0.95, 0.97);

    vec3 metallic = vec3(
        mix(darkMetal.r, brightMetal.r, bandR),
        mix(darkMetal.g, brightMetal.g, bandG),
        mix(darkMetal.b, brightMetal.b, bandB)
    );

    // ─── Per-channel color burn with tint ───
    vec3 tintColor = color0.rgb;
    vec3 boostedTint = mix(tintColor, vec3(1.0), 0.15);
    float tintAlpha = color0.a;

    vec3 col = vec3(
        colorBurnChannel(metallic.r, boostedTint.r, tintAlpha),
        colorBurnChannel(metallic.g, boostedTint.g, tintAlpha),
        colorBurnChannel(metallic.b, boostedTint.b, tintAlpha)
    );

    // ─── Highlight / accent ───
    float highlightMask = bandG * bandG;
    highlightMask = highlightMask * highlightMask;
    col += color1.rgb * highlightMask * color1.a * 0.25;

    // ─── Specular at bump peak ───
    float specular = bump * bump * bump * 0.35;
    col += vec3(1.0) * specular;

    // ─── Environment reflection ───
    float envNoise = snoise(uvAspect * 1.2 + vec2(-t * 0.12, t * 0.08));
    float envReflection = smoothstep(0.2, 0.7, envNoise * 0.5 + 0.5);
    col = mix(col, col * 1.15, envReflection * 0.15);

    // ─── Depth shadow in dark valleys ───
    float avgBand = (bandR + bandG + bandB) / 3.0;
    float shadow = smoothstep(0.3, 0.0, avgBand);
    col *= 1.0 - shadow * 0.15;

    // ─── Dither ───
    col = dither(col, fragCoord);
    col = clamp(col, 0.0, 1.0);

    // ─── Alpha with shape mask ───
    float alpha = mix(color0.a, color1.a, avgBand);
    alpha *= shapeMask;
    alpha = clamp(alpha, 0.0, 1.0);

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
  colors: ['#c0392b', '#f1c40f'],
  params: {
    uShape: 0,
    uSoftness: 0.1,
    uRepetition: 2.0,
    uShiftRed: 0.3,
    uShiftBlue: 0.3,
    uDistortion: 0.07,
    uContour: 0.4,
    uAngle: 70.0,
    uSpeed: 1.0,
    uMetaballCount: 8.0,
    uMetaballSize: 1.0
  },
  cornerRadius: [0.05, 0.05, 0.05, 0.05]
});
</script>
</body></html>
```
