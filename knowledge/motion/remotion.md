---
assumes: motion/core
dsl: [data-brilliant, Glass, Shader, VectorText, Tokens, useTokens, token]
---
# Motion: Remotion

A composition written for Remotion (React, `useCurrentFrame`, `interpolate`, `spring`, `Sequence`) becomes a Brilliant film without a browser: its poses land on a canvas as styleframes you edit by hand, its `interpolate`, `spring` and `interpolateColors` values become tracks the engine evaluates at Remotion's exact numbers, and the same file still renders under plain Remotion from its CSS. The import tools live in the Brilliant source at `client/brilliant/tool/remotion`, outside the app bundle, beside the source of the motion runner the app ships as `motionRunner` (`reference/motion`). Run them with node from `client/brilliant`, against the `mcp` url from `init`.

```
node tool/remotion/compose.mjs Scene.tsx --mcp <url> --out film [--composition id] [--canvas name]   // the import: styleframes on the canvas, film/motion.mjs beside them
node tool/motion/render.mjs --mcp <url> --program film/motion.mjs --out film                           // the mp4, the same runner as a .bm
node tool/remotion/pull.mjs Scene.tsx --mcp <url> --canvas <id> --frame 48 [--from a --to b] [--dry]  // the round trip: a pose edited on the canvas becomes an override beside the code, never a rewrite of the TSX
```

**The pass-through.** Any element may carry `data-brilliant="<blueprint fragment>"`: its own line's attribute syntax, a fill, a stroke, an effect, a `ds()` switch, a `$token` inside any of them (`blueprint/paint`, `blueprint/effects`, `blueprint/shaders/overview`, `design-systems/core`). The fragment's `f[]` and `st[]` replace the CSS fill and stroke of that element, effects stack with the CSS shadow, and a browser ignores the attribute. A fragment the blueprint cannot read is refused by name in the compose notes and the element renders from its CSS alone.

```tsx
import { AbsoluteFill, interpolate, spring, useCurrentFrame, useVideoConfig } from 'remotion'
import { Glass, Shader, VectorText, useTokens, token } from '@brilliant/remotion'

export const Scene: React.FC = () => {
  const frame = useCurrentFrame()
  const { fps } = useVideoConfig()
  const t = useTokens()
  const x = interpolate(spring({ frame, fps }), [0, 1], [-700, 200])
  return (
    <AbsoluteFill style={{ backgroundColor: t.color.surface }}>
      <Shader name="metaballs" colors={[token('color.surface'), token('color.primary')]} speed={0.35} style={{ position: 'absolute', inset: 0 }} />
      <VectorText stroke={[token('color.primary'), '#FF3366']} strokeWidth={4} glow="#FF3366" glowBlur={24} fill="none" style={{ position: 'absolute', left: 160, top: 120, fontSize: 160, fontWeight: 800 }}>Superset</VectorText>
      <Glass thickness={interpolate(frame, [0, 48], [4, 18], { extrapolateRight: 'clamp' })} ior={1.45} tint={token('color.primary')} style={{ position: 'absolute', left: x, top: 380, width: 640, height: 400, borderRadius: 32 }} />
    </AbsoluteFill>
  )
}
```

**The components** (`@brilliant/remotion`, the same folder, installed under that name in a Remotion project) each render a `div` with the fragment and a CSS fallback, and take `style`, `children` and every div prop. `<Glass thickness ior bevel frost chroma glow edge angle sat tint tintOpacity rim>` is liquid glass refracting what is behind it, every param optional, the fallback a backdrop blur with the tint. `<Shader name colors params speed scale frozen>` is a registry shader fill (`metaballs`, `metal`, `irid`, `steel`, `dithering`, `holo`) that the engine advances with the film's frame at `speed`, the fallback a gradient of the colors turning with the frame. `<VectorText stroke strokeWidth strokeAngle glow glowBlur glowOpacity fill effects>` is engine vector type, a list of colors a gradient stroke, `fill="none"` outline-only, the fallback a solid text stroke and a text shadow. A prop that changes with the frame animates.

**The tokens.** `useTokens()` is the project's design system for styles (`t.color.primary` the hex, `t.get('spacing.md')` the number, `useTokens('dark')` another mode), and `token('color.primary')` is the ref a fragment or a component prop carries, so the element follows a brand or mode switch on the canvas. A mode switch mid film is a Sequence boundary whose root carries `data-brilliant="ds(, theme(dark))"`. The import writes the tokens beside the composition as `tokens.json`, and a Remotion render of the same file wraps its root in `<Tokens tokens={tokens}>` for the same colors.
