---
assumes: webgl/setup
---
# Posterize: WebGL

Reduces color levels per channel to create flat, poster-like images. Three modes: RGB (quantize each channel independently), Luminosity (quantize brightness while preserving hue), and HSL (quantize hue, saturation, lightness independently).

## Parameters

| Param | Uniform | Range | Default | Description |
|-------|---------|-------|---------|-------------|
| Levels | `uLevels` | 2 .. 32 | 4 | Color levels per channel |
| Mode | `uMode` | 0, 1, 2 | 0 | 0=RGB, 1=Luminosity, 2=HSL |
| Smoothing | `uSmoothing` | 0 .. 1 | 0 | Smooth transitions between levels |
| Intensity | `uIntensity` | 0 .. 1 | 1 | Blend with original (1=full posterize) |
| Gamma | `uGamma` | 0.2 .. 5 | 1 | Gamma correction before quantization |

## Fragment Shader

```glsl
#version 300 es
precision highp float;

uniform float uResolutionX;
uniform float uResolutionY;
uniform float uScale;

uniform float uLevels;
uniform float uMode;
uniform float uSmoothing;
uniform float uIntensity;
uniform float uGamma;

out vec4 fragColor;
uniform sampler2D uInputImage;

const vec3 LUM = vec3(0.2126, 0.7152, 0.0722);

vec3 rgb2hsl(vec3 c) {
    float maxC = max(max(c.r, c.g), c.b);
    float minC = min(min(c.r, c.g), c.b);
    float l = (maxC + minC) * 0.5;
    float d = maxC - minC;

    float s = 0.0;
    float h = 0.0;

    if (d > 0.001) {
        s = l > 0.5 ? d / (2.0 - maxC - minC) : d / (maxC + minC);

        if (c.r >= c.g && c.r >= c.b) {
            h = (c.g - c.b) / d + step(c.g, c.b) * 6.0;
        } else if (c.g >= c.b) {
            h = (c.b - c.r) / d + 2.0;
        } else {
            h = (c.r - c.g) / d + 4.0;
        }
        h /= 6.0;
    }

    return vec3(h, s, l);
}

float hue2rgb(float p, float q, float t) {
    float tt = fract(t);
    if (tt < 1.0 / 6.0) return p + (q - p) * 6.0 * tt;
    if (tt < 0.5) return q;
    if (tt < 2.0 / 3.0) return p + (q - p) * (2.0 / 3.0 - tt) * 6.0;
    return p;
}

vec3 hsl2rgb(vec3 hsl) {
    float h = hsl.x;
    float s = hsl.y;
    float l = hsl.z;

    if (s < 0.001) return vec3(l);

    float q = l < 0.5 ? l * (1.0 + s) : l + s - l * s;
    float p = 2.0 * l - q;

    return vec3(
        hue2rgb(p, q, h + 1.0 / 3.0),
        hue2rgb(p, q, h),
        hue2rgb(p, q, h - 1.0 / 3.0)
    );
}

float quantize(float v, float factor, float smoothing) {
    float quantized = floor(v * factor + 0.5) / factor;

    if (smoothing > 0.001) {
        float halfStep = 0.5 / factor;
        float smoothWidth = halfStep * smoothing;
        float base = floor(v * factor) / factor;
        float next = base + 1.0 / factor;
        float t = smoothstep(base + halfStep - smoothWidth,
                             base + halfStep + smoothWidth, v);
        quantized = mix(base, next, t);
    }

    return clamp(quantized, 0.0, 1.0);
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
    vec3 original = rgb;

    float gamma = max(uGamma, 0.2);
    bool hasGamma = abs(gamma - 1.0) > 0.001;
    if (hasGamma) {
        float invGamma = 1.0 / gamma;
        rgb = vec3(pow(rgb.r, invGamma), pow(rgb.g, invGamma), pow(rgb.b, invGamma));
    }

    float levels = max(uLevels, 2.0);
    float factor = levels - 1.0;

    vec3 quantized;

    if (uMode < 0.5) {
        // RGB mode
        quantized = vec3(
            quantize(rgb.r, factor, uSmoothing),
            quantize(rgb.g, factor, uSmoothing),
            quantize(rgb.b, factor, uSmoothing)
        );
    } else if (uMode < 1.5) {
        // Luminosity mode
        float lum = dot(rgb, LUM);
        float qLum = quantize(lum, factor, uSmoothing);
        float lumSafe = max(lum, 0.001);
        quantized = rgb * (qLum / lumSafe);
        quantized = clamp(quantized, 0.0, 1.0);
    } else {
        // HSL mode
        vec3 hsl = rgb2hsl(rgb);
        hsl.x = quantize(hsl.x, factor, uSmoothing);
        hsl.y = quantize(hsl.y, factor, uSmoothing);
        hsl.z = quantize(hsl.z, factor, uSmoothing);
        quantized = hsl2rgb(hsl);
    }

    if (hasGamma) {
        quantized = vec3(pow(quantized.r, gamma), pow(quantized.g, gamma), pow(quantized.b, gamma));
    }

    vec3 result = mix(original, quantized, uIntensity);

    fragColor = vec4(result * color.a, color.a);
}
```

## Usage

```html
<img id="photo" src="photo.jpg" style="display:none">
<canvas id="posterized" style="width:600px;height:400px"></canvas>
<script>
const FRAG = `... shader source above ...`;

const filter = brilliantFilter('posterized', 'photo', FRAG, {
  params: {
    uLevels: 6.0,
    uMode: 0.0,        // RGB
    uSmoothing: 0.0,
    uIntensity: 1.0,
    uGamma: 1.0
  }
});

// Luminosity mode with smooth transitions
filter.setParam('uMode', 1.0);
filter.setParam('uSmoothing', 0.3);
filter.setParam('uLevels', 4.0);
filter.update();
</script>
```
