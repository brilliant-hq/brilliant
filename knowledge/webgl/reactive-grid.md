---
assumes: webgl/setup
---
# Reactive Grid: WebGL

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Density | uDensity | 2–20 | 8 | Grid line frequency |
| Distortion | uDistortion | 0–1 | 0.5 | Mouse influence strength |
| Radius | uRadius | 0.05–1.0 | 0.3 | Mouse influence radius |
| Speed | uSpeed | 0–3 | 1.0 | Animation speed multiplier |

## Colors
- Color count: 5
- Color 0 = background color
- Colors 1–4 = grid line colors (cycled over time)

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

// ─── Reference aspect ratio ───
uniform float uRefAspect;

// ─── Colors: 5 colors (vec4 RGBA each) ───
uniform vec4 uColor0;  // background color
uniform vec4 uColor1;  // grid color 1
uniform vec4 uColor2;  // grid color 2
uniform vec4 uColor3;  // grid color 3
uniform vec4 uColor4;  // grid color 4

uniform float uColorCount;

// ─── Shader-specific params ───
uniform float uDensity;      // 2-20: grid line frequency
uniform float uDistortion;   // 0-1: mouse influence strength
uniform float uRadius;       // 0.05-1.0: mouse influence radius
uniform float uSpeed;        // 0-3: animation speed

// ─── Interactive mouse uniforms ───
uniform float uMouseActive;  // 0.0 = cursor far away, 1.0 = nearby
uniform float uMouseX;       // element-local UV [0,1]
uniform float uMouseY;       // element-local UV [0,1]
uniform float uMouseDown;    // 0.0 or 1.0

out vec4 fragColor;

// ═══════════════════════════════════════════════════════════════════
// Element-aware SDF helpers (rect + circle only)
// ═══════════════════════════════════════════════════════════════════

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
// Grid pattern helpers
// ═══════════════════════════════════════════════════════════════════

vec2 rotate2D(vec2 p, float angle) {
    float s = sin(angle);
    float c = cos(angle);
    return vec2(c * p.x - s * p.y, s * p.x + c * p.y);
}

// Anti-aliased grid lines using fwidth (available in WebGL 2, not in SkSL)
float gridPattern(vec2 p) {
    vec2 grid = abs(fract(p - 0.5) - 0.5);
    vec2 fw = fwidth(p);
    return min(grid.x / max(fw.x, 0.001), grid.y / max(fw.y, 0.001));
}

float isoGrid(vec2 p, float density) {
    p = rotate2D(p, 3.14159 / 4.0);
    vec2 grid1 = p;
    vec2 grid2 = rotate2D(p, 3.14159 / 3.0);
    return min(gridPattern(grid1 * density), gridPattern(grid2 * density));
}

// ═══════════════════════════════════════════════════════════════════
// Color lookup
// ═══════════════════════════════════════════════════════════════════

vec4 getColor(int idx) {
    if (idx == 0) return uColor0;
    if (idx == 1) return uColor1;
    if (idx == 2) return uColor2;
    if (idx == 3) return uColor3;
    return uColor4;
}

// ═══════════════════════════════════════════════════════════════════
// Simplex noise (for ambient animation)
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
// Main
// ═══════════════════════════════════════════════════════════════════

void main() {
    vec2 fragCoord = vec2(gl_FragCoord.x, uResolutionY - gl_FragCoord.y);

    // rawUV = untransformed UV (for SDF, element boundary is fixed in screen space)
    vec2 rawUV = (fragCoord - vec2(uOffsetX, uOffsetY)) / vec2(uResolutionX, uResolutionY);

    // uv = transformed UV (for pattern generation)
    vec2 uv = rawUV - 0.5;
    float cosR = cos(uRotation);
    float sinR = sin(uRotation);
    uv = vec2(uv.x * cosR - uv.y * sinR, uv.x * sinR + uv.y * cosR);
    uv /= max(uScale, 0.01);
    uv += vec2(uUVOffsetX, uUVOffsetY);
    uv += 0.5;

    // Aspect correction for pattern coordinates
    float aspect = uResolutionX / max(uResolutionY, 1.0);
    vec2 uvAspect = (uv - 0.5) * vec2(aspect, 1.0) + 0.5;

    // Time with speed control
    float time = uTime * uSpeed;

    // ─── Mouse distortion (gated by uMouseActive) ───
    vec2 distortedUV = uvAspect;
    float mouseGlow = 0.0;

    if (uMouseActive > 0.5) {
        vec2 mouseUV = vec2(uMouseX, uMouseY);
        mouseUV = (mouseUV - 0.5) * vec2(aspect, 1.0) + 0.5;

        vec2 mouseInfluence = mouseUV - uvAspect;
        float mouseDist = length(mouseInfluence);

        // Smooth distortion toward cursor
        float distortionAmount = smoothstep(uRadius, 0.0, mouseDist) * uDistortion * 0.4;
        float safeLen = max(mouseDist, 0.001);
        distortedUV = uvAspect + (mouseInfluence / safeLen) * distortionAmount;

        // Glow near cursor
        mouseGlow = smoothstep(uRadius * 0.8, 0.0, mouseDist) * 0.3;

        // Click: stronger distortion + extra glow
        if (uMouseDown > 0.5) {
            float clickPull = smoothstep(uRadius * 1.5, 0.0, mouseDist) * uDistortion * 0.3;
            distortedUV += (mouseInfluence / safeLen) * clickPull;
            mouseGlow += smoothstep(uRadius, 0.0, mouseDist) * 0.2;
        }
    }

    // ─── Grid pattern ───
    float grid = isoGrid(distortedUV + time * 0.1, uDensity);

    // ─── Ambient noise for subtle grid modulation ───
    float noise = snoise(uvAspect * 3.0 + time * 0.05) * 0.15;

    // ─── Color composition ───
    vec3 bgColor = uColor0.rgb;
    float bgAlpha = uColor0.a;
    int colorCount = int(clamp(uColorCount, 2.0, 5.0));
    int fgColorCount = colorCount - 1;

    // Cycle through foreground colors over time
    float colorPhase = time * 0.3;
    float colorIdx = mod(colorPhase, float(fgColorCount));
    int idx0 = int(floor(colorIdx));
    int idx1 = int(mod(float(idx0 + 1), float(fgColorCount)));
    float frac = fract(colorIdx);
    vec3 gridColor = mix(getColor(idx0 + 1).rgb, getColor(idx1 + 1).rgb, frac);
    float gridAlpha = mix(getColor(idx0 + 1).a, getColor(idx1 + 1).a, frac);

    float gridLines = smoothstep(0.8 + noise, 0.2, grid);
    vec3 col = mix(bgColor, gridColor, gridLines);
    float alpha = mix(bgAlpha, gridAlpha, gridLines);

    // Mouse glow brightens grid lines near cursor
    col += mouseGlow * gridColor * gridLines;

    // ─── Edge glow at element boundary ───
    float sdf = elementSDF(rawUV);
    float edgeDist = abs(sdf);
    float edgeGlow = exp(-edgeDist * 12.0) * 0.15 * gridLines;
    col += edgeGlow * gridColor;

    // Premultiplied alpha output
    fragColor = vec4(col * alpha, alpha);
}
```

## Usage

```html
<canvas id="rg" style="width:400px;height:300px"></canvas>
<script>
const FRAG = document.querySelector('#rg-frag').textContent; // or inline the shader string
brilliantShader('rg', FRAG, {
  colors: ['#0a0a1a', '#00d4ff', '#7b2ff7', '#ff6b35', '#00ff88'],
  params: { uDensity: 8, uDistortion: 0.5, uRadius: 0.3, uSpeed: 1.0 },
  interactive: true
});
</script>
```
