---
name: "knowledge-libraries"
description: "Libraries in Brilliant: depending on another project's components and design systems at a pinned version, the Assets view, updates, and publishing your own library."
---

# Libraries

A **library** is a published Brilliant project that other projects depend on. Add one to your project and its components become insertable like your own, and its design systems become selectable brands. A team design system, an icon set, a UI kit, or a tokens-only brand pack are all just libraries.

The essentials:

- A library is an ordinary project whose author marked it "Use as library" and cut **releases**: plain versions like `1.2.0`, each with release notes. Consumers only ever see released versions; work in progress inside the library is invisible until the author releases it.
- A library is named everywhere by its **handle**: `@handle/project` (the owner's handle plus the project name), for example `@acme/design-kit`. That exact form appears in the manifest, in Blueprint references, and in design-system brand names, so a file always says exactly which library it depends on.
- Access is the ordinary sharing model: anyone can use a public library; a private one is usable by the people and teams who can already see that project.
- You depend on a library at a **pinned version**. Nothing changes under you until you (or your agent) update the pin.

## The Assets view

The Assets view is the home of component browsing and library management. Open it with **Cmd+Shift+A**, the **Toggle Assets** command in the palette, or its button in the bottom toolbar. (While the AI chat is open, Cmd+Shift+A toggles the Chat Explorer instead; use the palette or the button then.) Esc or clicking away closes it.

- **Left rail**: "This project" first, then one row per library (name, pinned version, an update dot when a newer release exists, a "local" marker for folder libraries, a warning glyph when the library cannot be reached), with "Add library" pinned at the bottom. Pressing a row shows that source's components. Each source row also carries a small chevron on its left, the same disclosure the file explorer's folders use: click it to expand that source's canvases in place as indented sub-rows, so you can narrow to a single canvas. Any number of sources can be expanded at once, your open sections are remembered while the app runs, and the chevron only expands or collapses (it never changes what the main area shows). Libraries a library itself depends on appear as quiet indented sub-rows in the same expanded section, version shown, with no update controls of their own (their version is the parent library's choice).
- **Main area**: a searchable grid of component cards (thumbnail, name, variant count), always grouped by canvas. Click a card to place it: the view dismisses and the component rides the cursor at its real canvas size; click to drop it (Esc cancels). Dragging a card out of the window onto the canvas places it at the drop point too. Either way the insert is one undo step, and the placed element is a normal component instance: reconfigure its variant, override its children, and so on in the inspector.
- A **pin** toggle sits at the top right, beside the search field. It keeps the view open while you place (clicking a card still inserts; the view just stops dismissing). Hover the pin to reveal the other window options, laid out like the AI chat's header: a toggle between two card sizes, then the dock buttons (full screen, bottom, left, or right, exactly like the AI chat panel). They hide again when you move away.
- Hovering a component card tints it with the same quiet wash the rail rows use; nothing moves or lifts.
- Each library row's "…" menu offers **Update**, **Remove**, and **Go to library project** (opens the library as its own tab). Removing a library never edits your canvases: any instances of its components stay and simply report the library as missing (see below).

## Adding a library

The rail's "Add library" row opens the add screen, three sections top to bottom. The search field at the top of the window is context-aware: on the component grid it searches components ("Search components…"), and while the add screen is open the same field searches libraries instead ("Search libraries…"), filtering "Your libraries" and querying Browse together, in place. Typing never takes you back to the component grid; clearing the field returns both sections to their defaults.

- **Your libraries**: projects you can access that are marked as libraries, each with its cover, name, handle, and latest release. Press Add to depend on it at the latest release. Past five libraries the list becomes a fixed window five rows tall that scrolls by itself - scrolling inside it never moves the rest of the screen; the top search field filters the whole list by name or handle.
- **Browse**: public libraries, with a row of category pills (All, UI kits, icons, design systems, illustrations, templates, wireframes); the selected pill is filled, the rest are quiet, and the top search field narrows within the picked category. Cards show the cover as of the latest release, the name and handle, a one-line description, a star count, and the latest version. Featured libraries appear first, then the most-starred. The section is a fixed window two card rows tall (however many cards fit across, at your window width) that scrolls by itself - scrolling inside it never moves the rest of the screen, and further results load automatically as you near its bottom. Searching or picking a category always starts the section back at its top with the new matches.
- **Add by handle**: type a library's handle directly (`@team/library`).

Adding works **signed out** for public libraries: browsing, adding by handle, and fetching all work without an account (a private handle answers that it was not found or is not public). "Your libraries" naturally needs a signed-in account.

Agents add libraries by writing the manifest directly, or through the library commands (`add_library`, `update_library`, `remove_library`, `add_local_library`; see `blueprint/commands`).

## The manifest: libraries.yaml

Dependencies live in **`libraries.yaml` at the project root**, one entry per library. It is plain YAML, safe to hand-edit or agent-edit, and it travels with the project when published, so anyone who opens the project gets the same libraries.

```yaml
"@acme/design-kit": "1.2.0"   # a published library, pinned to a release
my-kit:                        # a local folder library (no versions; see below)
  path: ../shared/kit
```

Editing the file is live: saving a manifest change fetches what is missing and re-syncs affected instances. The version is an exact release; there are no version ranges.

## Using library components

Insert from the Assets view (above), or reference a library component in Blueprint:

```
inst(Button, lib(acme/design-kit), canvas(Atoms/Buttons))
```

`lib()` names the library by its `handle/project` (no `@`), and `canvas()` is the path of the canvas **inside the library** where the master lives. For a local folder library, `lib()` wraps the manifest key in `local()` instead (`lib(local(my-kit))`, `lib(local(Material 3 Kit))` - the key is the folder's plain name). Older files written as `lib(@acme/design-kit)` or with a bare local key still read fine and are rewritten to the current form on the next save. Everything else about instances is unchanged: `at()` picks a variant, `override()` and slots work as usual, and overrides survive library updates. Full instance syntax: `blueprint/components`.

A library instance renders with the **library's own design system** by default, so it looks the way its author designed it even inside a project with a different brand. To re-theme it with your project's tokens instead, select the instance and flip the **Design system** dropdown in the inspector's Component section from the library's name to "This project" (in Blueprint, the `projds` token on the instance line does the same). Your project's active modes (theme, density) still apply either way; where the library does not define a mode, its default is used.

## Library design systems

A library's brands surface alongside your own, named by the library's handle:

- `@acme/design-kit` is the library's default look; `@acme/design-kit/marketing` is its `marketing` brand.
- They appear in the inspector's brand dropdown and work in Blueprint `ds()` refs, for example `ds(@acme/design-kit, theme(dark))`.

A library brand always resolves against the library's own tokens, never a copy merged into your project, so a library update updates the look everywhere it is used.

## Updating and reverting

An update dot on a library's rail row means a newer release exists. Clicking the row's dot (or "…" then Update) opens the library's screen: the current pin, the target version, and the release history with dates and the author's release notes. Pick a version and press **Update**; picking a version older than your pin turns the button into **Revert**. Either way:

- The pin in `libraries.yaml` changes, the new version is fetched, and every instance re-syncs.
- **Your overrides are preserved.** An update never silently discards an override; where the new master's structure genuinely conflicts, the conflict is surfaced rather than reset.
- One notification summarizes what changed, and an open Assets view refreshes itself immediately.

The same screen is where a library's **license and attribution** are shown (collapsed rows; expand to read).

## Where library files live, and why they are read-only

For a project folder on disk, a library's files are downloaded into **`.brilliant/libraries/`** inside your project. That folder is derived and re-fetchable: it is never included when you publish, and hand-edits to it do not stick (the next update overwrites them). Projects opened straight from the cloud keep the copy in the app's own cache instead; nothing changes in how libraries behave.

Library content is **read-only from the consumer side**. Opening a library canvas from a consumer project is view-only, and every edit path refuses: an edit there would be silently lost on the next update. To change a library, edit the library project itself (the row's "Go to library project" opens it) and, for published libraries, release a new version; consumers then pick it up by updating.

## When a library or component is unavailable

Missing state is never destructive and never silent:

- If a library is unreachable (offline, access revoked, deleted) but was fetched before, its components **keep rendering** from the copy you have; updates stop, and the library's rail row wears a warning glyph. The row does not offer Update while degraded (the fetch cannot succeed); it surfaces its state and offers Remove.
- An instance whose master cannot be found renders quietly, with no corner glyph on the canvas. **Select it** and the inspector's Component section leads with the specific reason in one sentence (the library is not in the manifest, the library is unavailable, the master is gone from the pinned release, the master's canvas was deleted, and so on), plus the practical next step where one exists: an Update button, or a link to the library's settings.
- Removing a library, or a master removed from a release, leaves instances in place with their last-known look; nothing is ever stripped from your canvases.

## Local folder libraries

A plain folder on your machine can be a library, published or not, via a `path:` manifest entry (see above). The manifest key can be the folder's real name, spaces and parentheses included: quote it in the YAML (`"Material 3 Design Kit (Community)":`) and use the same name inside `local()` in `lib()` refs (`lib(local(Material 3 Design Kit (Community)))`); keys cannot contain `/` or start with `@` or `.`. Local libraries are **live**: there are no versions; the folder's current state is what you get, and saving a change in that folder re-syncs your instances immediately. This is the solo workflow and the author loop (iterate on a kit inside a real consumer project before releasing it). They work in projects that live on disk; the read-only rule still applies from the consumer side. Local rows in the Assets view show a "local" marker and no version or update controls (there is nothing to update to).

## Publishing your own library

Any project you can admin becomes a library from **Settings, Project tab, Library section** (the section reads the same whether the project is published yet or not):

- **Use as library** marks the project as a library.
- **Topics** appear once marked: pick up to five from the canonical pills (`ui-kit`, `icons`, `design-system`, `illustrations`, `templates`, `wireframes`) or type your own. Applied topics show as filled pills with an X to remove; suggestions are quiet pills, the same look as the Browse filter. The canonical topics power Browse's filter; free-form ones remain searchable.
- **Release new version…** opens the release pane: a computed summary of what changed since the last release (components and variants added, removed, or changed; token changes per brand), a suggested version you can override (a removal suggests a major bump, additions a minor, content-only changes a patch), and a notes field that starts empty and is entirely yours; the notes become the changelog consumers read when updating. The first release defaults to `1.0.0`. If your folder has not finished syncing to the cloud, the release refuses with a clear message and asks you to retry, so a release always snapshots exactly what you approved.
- On a project that is **not published yet**, the pane says plainly that releasing will first publish the project to your account: one press publishes, marks the project as a library, and cuts the release in a single act.
- The **release history** lives in the same section, collapsed by default.
- A collapsed **License** section in the release pane holds the license dropdown (CC BY 4.0, MIT, Apache 2.0, OFL 1.1, All rights reserved, Custom) and an attribution text box. Untouched, public libraries are shared under **CC BY 4.0** (a quiet line in the pane discloses this), and private ones stay all rights reserved. Consumers read license and attribution on the library's screen in the Assets view; no badge is added anywhere else.

A library's Browse card shows the project's **cover** as it looked at the release (see `design/covers` for designing one), and a library-marked project wears a small stacked-layers badge on its home tile. Producer actions need a signed-in account that can admin the project; they work for synced folders and for projects opened from the cloud alike. Agents can drive the producer side with `mark_project_as_library` and `create_library_release` (see `blueprint/commands`).

## Libraries that use libraries

If a library depends on other libraries, those come along automatically at the versions the library pinned; you never list them in your own manifest. If you also depend on one of them directly, **your pin wins** everywhere, and one note names the version difference. Chains resolve up to three levels deep, and circular dependencies are refused with a message naming the chain. A transitive library that cannot be reached degrades exactly like a direct one: last-fetched content keeps rendering, loudly.

## Publishing a project that uses libraries

Publishing warns, it never blocks:

- All dependencies public: a quiet dependencies line, nothing to act on.
- A **private** library inside a public project: a loud warning that viewers will see last-saved values with no updates, with the choice to make the library public or publish anyway.
- A **local folder** library: the loudest warning, with a one-click fix that publishes that folder as a library, gives it version `1.0.0`, and rewrites your manifest entry to its `@handle/project` form.

Declining any warning proceeds with the named consequence.

> **See also:** `blueprint/components` for the full `inst()` and `lib()` syntax; `blueprint/commands` for the library commands; `reference/components` for how instances, overrides, and syncing behave; `reference/design-systems` for brands and modes; `blueprint/libraries` for organizing masters across canvases within one project.
