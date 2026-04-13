---
assumes: webgl/setup
---
# Pixelate — WebGL

Pixelation filter with 5 cell shapes: square, hexagonal, diamond, circle (pointillism), and triangle. Supports rotation, horizontal stretch, edge smoothing, and cell outlines.

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Cell Size | `uCellSize` | 2 .. 300 | 16 | Cell size in logical pixels |
| Shape | `uShape` | 0..4 | 0 | 0=square, 1=hex, 2=diamond, 3=circle, 4=triangle |
| Angle | `uAngle` | 0 .. 360 | 0 | Grid rotation (degrees) |
| Stretch | `uStretch` | 0.5 .. 2.0 | 1 | Horizontal cell stretch |
| Outline | `uOutline` | 0 .. 1 | 0 | Cell grid outline intensity |
| Smoothing | `uSmoothing` | 0 .. 1 | 0 | Edge smoothing between cells |

## Fragment Shader

```glsl
#version 300 es
precision highp float;

uniform float uResolutionX;
uniform float uResolutionY;
uniform float uScale;

uniform float uCellSize;
uniform float uShape;
uniform float uAngle;
uniform float uStretch;
uniform float uOutline;
uniform float uSmoothing;

out vec4 fragColor;
uniform sampler2D uInputImage;

void main() {
    vec2 fragCoord = vec2(gl_FragCoord.x, uResolutionY - gl_FragCoord.y);
    vec2 resolution = vec2(uResolutionX, uResolutionY);

    vec2 logicalCoord = fragCoord / uScale;
    float cellSize = max(uCellSize, 2.0);
    float stretch = max(uStretch, 0.01);

    vec2 transformed = logicalCoord;
    transformed.x /= stretch;

    float rad = uAngle * 3.14159265 / 180.0;
    float cosA = cos(rad);
    float sinA = sin(rad);
    vec2 center = resolution * 0.5 / uScale;
    center.x /= stretch;

    if (abs(uAngle) > 0.001) {
        vec2 p = transformed - center;
        transformed = vec2(p.x * cosA - p.y * sinA, p.x * sinA + p.y * cosA) + center;
    }

    vec2 cellCenterT;
    float edgeDist = 1.0;

    if (uShape < 0.5) {
        // Square
        vec2 cell = floor(transformed / cellSize);
        cellCenterT = (cell + 0.5) * cellSize;

        vec2 cellFrac = fract(transformed / cellSize);
        vec2 edgeFrac = min(cellFrac, vec2(1.0) - cellFrac);
        edgeDist = min(edgeFrac.x, edgeFrac.y) * cellSize;

    } else if (uShape < 1.5) {
        // Hexagonal
        float h = cellSize;
        float w = h * 1.7320508;

        vec2 gridA = vec2(floor(transformed.x / w), floor(transformed.y / h));
        vec2 gridB = gridA + 0.5;

        vec2 centerA = vec2(gridA.x * w, gridA.y * h);
        vec2 centerB = vec2(gridB.x * w, gridB.y * h);

        float distA = length(transformed - centerA);
        float distB = length(transformed - centerB);

        cellCenterT = distA < distB ? centerA : centerB;
        edgeDist = abs(distA - distB) * 0.5;

    } else if (uShape < 2.5) {
        // Diamond
        float diagSize = cellSize * 0.7071068;
        vec2 rotCoord = vec2(
            transformed.x + transformed.y,
            transformed.y - transformed.x
        ) * 0.7071068;

        vec2 cell = floor(rotCoord / diagSize);
        vec2 cellCenterRot = (cell + 0.5) * diagSize;

        cellCenterT = vec2(
            cellCenterRot.x - cellCenterRot.y,
            cellCenterRot.x + cellCenterRot.y
        ) * 0.7071068;

        vec2 cellFrac = fract(rotCoord / diagSize);
        vec2 edgeFrac = min(cellFrac, vec2(1.0) - cellFrac);
        edgeDist = min(edgeFrac.x, edgeFrac.y) * diagSize;

    } else if (uShape < 3.5) {
        // Circle (pointillism)
        vec2 cell = floor(transformed / cellSize);
        cellCenterT = (cell + 0.5) * cellSize;

        float dist = length(transformed - cellCenterT);
        float radius = cellSize * 0.5;
        edgeDist = radius - dist;

    } else {
        // Triangle
        float cellW = cellSize;
        float cellH = cellSize * 0.866025;

        float col = floor(transformed.x / cellW);
        float row = floor(transformed.y / cellH);

        float fx = fract(transformed.x / cellW);
        float fy = fract(transformed.y / cellH);

        float checker = mod(col + row, 2.0);
        float isUpper;
        if (checker < 0.5) {
            isUpper = step(fx, fy);
        } else {
            isUpper = step(1.0 - fx, fy);
        }

        vec2 triCenter;
        if (checker < 0.5) {
            triCenter = mix(vec2(0.667, 0.333), vec2(0.333, 0.667), isUpper);
        } else {
            triCenter = mix(vec2(0.333, 0.333), vec2(0.667, 0.667), isUpper);
        }

        cellCenterT = vec2((col + triCenter.x) * cellW, (row + triCenter.y) * cellH);

        float diagDist;
        if (checker < 0.5) {
            diagDist = abs(fy - fx) * cellW * 0.7071068;
        } else {
            diagDist = abs(fy - (1.0 - fx)) * cellW * 0.7071068;
        }
        vec2 edgeFrac = min(vec2(fx, fy), vec2(1.0) - vec2(fx, fy));
        float rectEdge = min(edgeFrac.x * cellW, edgeFrac.y * cellH);
        edgeDist = min(diagDist, rectEdge);
    }

    // Inverse-transform cell center back to logical space
    vec2 cellCenterLogical = cellCenterT;
    if (abs(uAngle) > 0.001) {
        vec2 p = cellCenterLogical - center;
        cellCenterLogical = vec2(p.x * cosA + p.y * sinA, -p.x * sinA + p.y * cosA) + center;
    }
    cellCenterLogical.x *= stretch;

    vec2 sampleUV = clamp((cellCenterLogical * uScale) / resolution, 0.0, 1.0);
    vec4 cellColor = texture(uInputImage, sampleUV);

    // Circle shape: clip outside dot radius
    if (uShape > 2.5 && uShape < 3.5 && edgeDist < 0.0) {
        fragColor = vec4(0.0);
        return;
    }

    // Smoothing
    if (uSmoothing > 0.001) {
        vec2 origUV = fragCoord / resolution;
        vec4 origColor = texture(uInputImage, origUV);
        float smoothEdge = smoothstep(0.0, cellSize * 0.3 * uSmoothing, edgeDist);
        cellColor = mix(origColor, cellColor, smoothEdge);
    }

    // Outline
    if (uOutline > 0.001) {
        float outlineWidth = 1.0 + uOutline;
        float outlineMask = smoothstep(0.0, outlineWidth, edgeDist);
        vec3 outlineColor = cellColor.a > 0.001 ? cellColor.rgb / cellColor.a * outlineMask : vec3(0.0);
        cellColor = vec4(outlineColor * cellColor.a, cellColor.a);
    }

    fragColor = cellColor;
}
```

## Usage

```html
<img id="photo" src="photo.jpg" style="display:none">
<canvas id="pixelated" style="width:600px;height:400px"></canvas>
<script>
const FRAG = `... shader source above ...`;

const filter = brilliantFilter('pixelated', 'photo', FRAG, {
  params: {
    uCellSize: 16.0,
    uShape: 0.0,       // square
    uAngle: 0.0,
    uStretch: 1.0,
    uOutline: 0.0,
    uSmoothing: 0.0
  }
});

// Switch to hexagonal
filter.setParam('uShape', 1.0);
filter.setParam('uCellSize', 24.0);
filter.update();

// Pointillism (circle)
filter.setParam('uShape', 3.0);
filter.setParam('uCellSize', 12.0);
filter.update();
</script>
```
