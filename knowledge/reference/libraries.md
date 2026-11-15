---
name: "knowledge-libraries"
description: "Libraries in Brilliant: depending on another project's components and design systems at a pinned version, the Assets view, updates, and publishing your own library."
---

# Libraries

A **library** is a published Brilliant project that other projects depend on. Add one to your project and its components become insertable like your own, and its design systems become selectable brands. A team design system, an icon set, a UI kit, or a tokens-only brand pack are all just libraries.

The essentials:

- A library is an ordinary project whose author marked it "Use as library" and cut **releases**: plain versions like `1.2.0`, each with release notes. Consumers only ever see released versions; work in progress inside the library is invisible until the author releases it.
- A library is named everywhere by its **handle**: `@handle/project` (the owner's handle plus the project name), for example `@acme/design-kit`. That exact form appears in the manifest and in design-system brand names, and Blueprint's `lib()` writes it without the `@` (`lib(acme/design-kit)`), so a file always says exactly which library it depends on.
- Access is the ordinary sharing model: anyone can use a public library; a private one is usable by the people and teams who can already see that project.
- You depend on a library at a **pinned version**. Nothing changes under you until you (or your agent) update the pin.
- Libraries are found and added inside the app, in the **Assets view** (Cmd+Shift+A): its Add page lists yours and the public catalogue. A public library may carry a **Verified** seal: a library on Brilliant's verified list (Brilliant's own kits; the seal is granted by Brilliant, not requested). A few libraries Brilliant picks are also marked Featured on the Public tab. On brilliant.design, your profile (and a team's) gets a **Libraries** tab, with "Your libraries" and "Team libraries" rows in the account menu, once the account has at least one library; an account with none shows no tab. The website has no page per library: the Public tab in the app is where libraries are discovered.

## Sub-keys

- `reference/libraries/assets`: the Assets view
- `reference/libraries/adding`: adding a library, a library page, the `libraries.yaml` manifest, local folder libraries
- `reference/libraries/using`: placing and referencing library components, unresolved references, component actions
- `reference/libraries/updating`: library design systems, updating and reverting
- `reference/libraries/unavailable`: where library files live, read-only content, unavailable libraries and components
- `reference/libraries/figma`: libraries from a Figma file (the import screen's Libraries step, one library per screen, and what each of its cards does; Exact match, Same family, Verified; a file that is a copy of a library; what the end of the run says)
- `reference/libraries/figma-projects`: the library projects a Figma import makes or links (what the result looks like, importing the library file itself, Make this a library, foreign masters, the older plugin's library cards)
- `reference/libraries/help`: helping a user with a library problem: where the facts are (the manifest, the downloaded copy, the canvas rows, the inspector sentence, the app log), the acts an agent can run, and what only the user can do
- `reference/libraries/help-linking`: the remedy per class with its command for a library that is not updating and a component that is not linked
- `reference/libraries/help-publishing`: the remedy per refusal when publishing or releasing a library, and a star or Private chip that looks wrong
- `reference/libraries/publishing`: publishing your own library (Use as library, topics, releases, previews, licenses, Verified, what a release counts as its components), libraries that use libraries, publishing a project that uses libraries

> **See also:** `blueprint/components` for the full `inst()` and `lib()` syntax; `blueprint/commands` for the library commands; `reference/components` for how instances, overrides, and syncing behave; `reference/design-systems` for brands and modes.
