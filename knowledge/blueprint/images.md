---
assumes: blueprint/paint
---
# Blueprint Images & SVGs

Assumes: `blueprint/core`, `blueprint/paint`

## Image Fills

| Source | Syntax |
|--------|--------|
| Photos | `f[(img(https://picsum.photos/id/{n}/800/400))]` |
| Avatars | `f[(img(https://i.pravatar.cc/150?img={n}))]` |
| Letter avatars | `f[(img(https://ui-avatars.com/api/?name=John+Smith&size=150&background=3B82F6&color=fff))]` |
| Generated | `f[(img(assetPath))]` — after `generate_image` |

Place images on rectangles: `r s(400,300) f[(img(path))] rd(8) clip "Hero"`

## SVG Import

`svg(icon:house)` bundled Phosphor · `svg(https://...)` URL (fetched at import) · `svg(/tmp/file.svg)` local · `svg(<svg>...</svg>)` inline

Inline SVGs must be collapsed to a single line (no newlines inside the `svg()` token). Use for custom shapes or icons not available in Phosphor.

Fills/strokes on SVG lines override imported fills — all fill types work:
- `svg(icon:house) f[(#F97316)]`
- `svg(https://...) f[(metal())]`

**SVG fills are creation-only.** To recolor after creation, use `recolor_children` command.

Place SVGs inside icon box frames: `svg(icon:gear) s(20,20) st[(#EF4444,w(2))]`

## Bundled Phosphor Icons

All **Phosphor regular-weight** icons bundled. Use `svg(icon:name)` with kebab-case names. Only regular weight — **no `-fill`, `-bold`, `-light`, `-thin`, `-duotone` suffixes**. Use `play` not `play-fill`, `heart` not `heart-fill`, `skip-forward` not `skip-forward-fill`.

## Other Icon Libraries (via URL)

- Phosphor CDN: `svg(https://unpkg.com/@phosphor-icons/core/assets/regular/{name}.svg)`
- Lucide: `svg(https://unpkg.com/lucide-static@latest/icons/{name}.svg)`
- Simple Icons (brands): `svg(https://unpkg.com/simple-icons@latest/icons/{slug}.svg)`
- Wikimedia (logos, flags): `svg(https://commons.wikimedia.org/wiki/Special:Redirect/file/{Filename}.svg)`

## SVG Avatar

`svg(https://api.dicebear.com/9.x/notionists/svg?seed={name})`

## AI Image Generation

Use `generate_image` for photos, product shots, textures. Returns `assetPath` for `f[(img(assetPath))]`. See `images/prompts` for prompt engineering.

**ALL ICONS = SVGs.** Never create `vector` elements for icons. Never use emoji as icons.
