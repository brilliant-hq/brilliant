---
name: "knowledge-export-video"
description: "Video export: options, codecs, frame-size limits, and Replay export."
assumes: reference/export
---

# Video Export (MP4 / MOV)

Video export renders animated shader fills frame by frame into a hardware-accelerated file (macOS via VideoToolbox, Windows via Media Foundation; not on Linux). By hand it is available **only from the Export panel** (no command, no shortcut, no context menu), and agents on the desktop app export MP4 and MOV with the `export` tool; on the web, video and films export only from the desktop app. Replay is the exception.

Flow: select elements, choose MP4 or MOV in the format dropdown, configure the inline video options, click `Export`, then save. A progress bar shows "Frame X / Y" and can be cancelled.

| Option | Values | UI default |
|--------|--------|------------|
| **Duration** | 0.5 to 60s (draggable + preset dropdown) | 10s |
| **FPS** | 15, 24, 30, 60 | 60 |
| **Quality** | Low, Medium, High | Medium |
| **Resolution** | Same presets as image export | Original (1x) |

Codecs are constrained by format: MP4 offers H.264 and HEVC (no alpha); MOV offers HEVC (alpha) and ProRes 4444 (alpha, largest files). The codec dropdown adjusts automatically when you switch format. Only MOV with HEVC-with-alpha or ProRes 4444 supports a transparent background; MP4 always renders opaque (falls back to canvas color). On Windows only H.264/MP4 is available: no HEVC, no MOV, no alpha (the codec dropdown is fixed at H.264).

Frame-size limits differ by platform. On macOS an MP4 (H.264) frame can be at most about 35 megapixels (roughly 5968 by 5968 pixels, with no side over 16384) and a MOV frame at most 8192 pixels on a side. On Windows the video encoder is tighter: no side above 4096 pixels. A larger frame is refused up front with a clear message (the fix is a smaller resolution), so a video export never quietly finishes an empty, playable-looking file.

Video currently animates shader fills only (metaballs, liquid metal, holographic, etc.). Static elements look identical in every frame. There is no keyframe-timeline animation.

## Replay export

Replay is a one-click animated reveal of the current selection: each element fades in one after another with a shimmer pass. It defaults to MP4, but you can switch the container to MOV (required if you want a transparent background). Run it from the palette (`Export to Replay`) or the right-click `Export as → Replay` (both render at 2x scale for crisp retina output), or the Export panel (which follows the panel resolution, default 1x).

| Option | Values | Default |
|--------|--------|---------|
| **Container** | MP4, MOV | MP4 |
| **Codec** | H.264, HEVC, ProRes 4444 (filtered by container) | H.264 |
| **Quality** | Low, Medium, High | Medium |
| **Pacing (ms per element)** | 10, 25, 50, 75, 100, 150, 200, 250, 300, 400 (presets) or a custom value | 150ms |
| **Intro text** | Optional short text card shown before the reveal | none |
| **Resolution** | Same presets as image/video export | Original (1x) |
| **Background** | Transparent (MOV + HEVC/ProRes only) or Canvas | Transparent |

Total duration is derived automatically from pacing times element count (there is no separate duration field).
