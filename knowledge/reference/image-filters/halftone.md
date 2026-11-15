---
name: "knowledge-image-filters-halftone"
description: "The Halftone filter: parameters and color swatches."
assumes: reference/image-filters
---

# Halftone

Classic print halftone dots with standard and CMYK modes.

| Parameter | Range | Default | Description |
|-----------|-------|---------|-------------|
| **Mode** | Standard / CMYK | Standard | Standard uses 2 colors; CMYK uses 4 ink channels + paper |
| **Dot Size** | 1–50 | 8 | Halftone dot size in logical pixels |
| **Angle** | 0–360° | 45° | Grid rotation angle |
| **Shape** | Circle / Diamond / Line | Circle | Dot shape within each cell |
| **Grid** | Square / Hex | Square | Cell arrangement pattern |
| **Contrast** | 0–1 | 0.5 | Luminance contrast applied before dot sizing |
| **Inverted** | 0–100 | 0 | Invert luminance (0 = normal, 100 = inverted, continuous blend) |
| **Colors** | Custom / Original | Custom | Use custom colors or original image colors |
| **Softness** | 0–1 | 0 | Dot edge softness (0 = hard, 1 = blurred) |
| **Gain** | 0–2 | 1.0 | Dot radius multiplier (>1 = dots overflow cells, creating overlap patterns) |
| **Min Dot** | 0–0.5 | 0.15 | Minimum dot size in highlights (prevents white gaps) |

**Color swatches:** which swatches appear depends on Mode and the Colors setting:

- **Standard + Custom colors:** Background + Foreground (2 swatches)
- **Standard + Original colors:** Background only (1 swatch)
- **CMYK:** Paper + Cyan + Magenta + Yellow + Black (5 swatches)

| Role | Default |
|------|---------|
| Background / Paper | #F2F1E8 (cream) |
| Foreground (Standard only) | #2B2B2B (dark gray) |
| Cyan (CMYK) | #1ABAED |
| Magenta (CMYK) | #E8558A |
| Yellow (CMYK) | #F5D623 |
| Black (CMYK) | #2A2725 |
