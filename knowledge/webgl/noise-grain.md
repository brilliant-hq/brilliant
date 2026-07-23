---
assumes: webgl/setup
---
# Noise Grain: WebGL

Film grain overlay effect with configurable grain size, distribution, roughness, and midtone bias. Supports monochrome and color noise with uniform or Gaussian distribution.

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Amount | `uAmount` | 0 .. 1 | 0.3 | Noise intensity |
| Size | `uSize` | 0.5 .. 8 | 1.5 | Grain size in logical pixels |
| Monochrome | `uMonochrome` | 0 or 1 | 1 | 0=color noise, 1=mono noise |
| Distribution | `uDistribution` | 0 or 1 | 0 | 0=uniform, 1=gaussian |
| Roughness | `uRoughness` | 0 .. 1 | 0.5 | 0=structured, 1=organic film-like |
| Midtone Bias | `uMidtoneBias` | 0 .. 1 | 0 | Concentrate noise in midtones |

## Fragment Shader

```glsl
#version 300 es
precision highp float;

uniform float uResolutionX;
uniform float uResolutionY;
uniform float uScale;

uniform float uAmount;
uniform float uSize;
uniform float uMonochrome;
uniform float uDistribution;
uniform float uRoughness;
uniform float uMidtoneBias;

out vec4 fragColor;
uniform sampler2D uInputImage;

float hash(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * 0.1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

vec3 hash3(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * vec3(0.1031, 0.1030, 0.0973));
    p3 += dot(p3, p3.yxz + 33.33);
    return fract((p3.xxy + p3.yzz) * p3.zyx);
}

float toGaussian(float u1, float u2) {
    float safe = max(u1, 0.001);
    float r = sqrt(-2.0 * log(safe));
    float theta = 6.2831853 * u2;
    return r * cos(theta) * 0.3;
}

vec3 blendOverlay(vec3 base, vec3 noise) {
    vec3 blend = vec3(0.5) + noise * 0.5;
    vec3 darkResult = 2.0 * base * blend;
    vec3 lightResult = vec3(1.0) - 2.0 * (vec3(1.0) - base) * (vec3(1.0) - blend);
    vec3 selector = step(vec3(0.5), base);
    return mix(darkResult, lightResult, selector);
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
    float grainSize = max(uSize, 0.5);

    vec2 quantizedCoord = floor(logicalCoord / grainSize);
    vec2 pixelCoord = logicalCoord / grainSize;
    vec2 grainCoord = mix(quantizedCoord, pixelCoord, uRoughness);

    vec3 noise;
    if (uMonochrome > 0.5) {
        if (uDistribution > 0.5) {
            float u1 = hash(grainCoord);
            float u2 = hash(grainCoord + vec2(127.1, 311.7));
            float n = toGaussian(u1, u2);
            noise = vec3(n);
        } else {
            float n = hash(grainCoord) * 2.0 - 1.0;
            noise = vec3(n);
        }
    } else {
        if (uDistribution > 0.5) {
            vec3 h1 = hash3(grainCoord);
            vec3 h2 = hash3(grainCoord + vec2(127.1, 311.7));
            noise = vec3(
                toGaussian(h1.x, h2.x),
                toGaussian(h1.y, h2.y),
                toGaussian(h1.z, h2.z)
            );
        } else {
            noise = hash3(grainCoord) * 2.0 - 1.0;
        }
    }

    float amount = uAmount;
    if (uMidtoneBias > 0.001) {
        float lum = dot(rgb, vec3(0.2126, 0.7152, 0.0722));
        float midtoneWeight = 4.0 * lum * (1.0 - lum);
        amount *= mix(1.0, midtoneWeight, uMidtoneBias);
    }

    vec3 result = blendOverlay(rgb, noise);
    result = mix(rgb, result, amount);

    fragColor = vec4(result * color.a, color.a);
}
```

## Usage

```html
<img id="photo" src="photo.jpg" style="display:none">
<canvas id="grainy" style="width:600px;height:400px"></canvas>
<script>
const FRAG = `... shader source above ...`;

const filter = brilliantFilter('grainy', 'photo', FRAG, {
  params: {
    uAmount: 0.35,
    uSize: 1.5,
    uMonochrome: 1.0,
    uDistribution: 0.0,
    uRoughness: 0.5,
    uMidtoneBias: 0.0
  }
});

// Adjust grain intensity
filter.setParam('uAmount', 0.6);
filter.update();
</script>
```
