---
name: "knowledge-libraries-figma-projects"
description: "The library projects a Figma import makes or links: what the result looks like, importing the library file itself, Make this a library, foreign masters, figma-components.json, and the library cards of an older plugin."
assumes: reference/libraries
---

# Library projects from a Figma import

What happens around the library projects that the Libraries step of a Figma import connects or makes (`reference/libraries/figma`).

## What the result looks like

The library project is an ordinary library (`reference/libraries/adding`): in the desktop app a local folder under your Brilliant projects directory, listed in your imported project's `libraries.yaml` with a `path:` entry, browsable in the Assets view and private to your machine until you publish it; in the browser a cloud library project of your account (on the Free plan a public one: "On the Free plan a library you set up is a public project, because private projects are a paid feature."). Brilliant never opens it for you; the completion note carries a **Go to library** button (and **See report** when the import wrote a Migration report). Canvases in the library project are named after the Figma pages the components live on when that is known, and a "Components" canvas otherwise. When the library also supplies design variables or color, text and effect styles to the file, they arrive as the library project's design system, and library components keep resolving against it; your own project keeps its copy of those tokens too, so the layers that used them stay bound.

## Importing the library file itself

When you later import the Figma file the library came from, Brilliant knows it by its own component keys, even though the file was never imported as such: the Project step preselects **Update <library project>** (the library **Make it a library** created), and the pages converge onto the canvases Brilliant made, so everything that uses the library updates in place and your overrides are kept. **Import as a new project** keeps it separate instead. When Brilliant recognizes the file only by name and content, the step asks which you want instead of preselecting. (With an older plugin the same question is a card, "Is this the library you set up as <name>?", with **Converge** and **Keep separate**; a Keep separate answer is remembered.)

## Make this a library

Components imported as copies are not a dead end. When an import lands a library's components as copies in a project you own (or manage) on your account, the end of the import carries a quiet note, "These components can be a library", with one button, **Make this a library**. It marks the project as a library and releases version 1.0.0 (notes "Imported from Figma") in one press, so other projects can link these components instead of copying them, and a later import of the same Figma file recognizes the library by its component keys. When the project is public (always on the Free plan) the note says so first ("This library will be public. Anyone will be able to see it and use it.") and names the license it will be shared under; the press is the consent. The note appears only on a project that is published to your account and that you can admin; a desktop import stays local until you publish it, so publish first and then use **Use as library** in Settings. The project's Settings keep the usual **Use as library** toggle and **Release new version** for everything else, and turning **Use as library** on there does the same thing for the copies: a project whose every imported component is a copy from somewhere else adopts them as its own at that moment, so its first release carries them as components other projects can browse, link and match. A project that already has components of its own keeps the distinction below.

## Foreign masters

A kit imported from Figma also lands the components it merely USES from other Figma libraries (an icon library, avatars) as local copies on its "Components" canvas. When such a project is a library, those foreign masters are not its components: a consumer's Assets view of the library, the library's page, its component count and its release summary leave them out, and a Figma import never matches a file to that library because of them. Every instance placed from them keeps resolving, and the author still sees them on the library project's own Components canvas.

**The match travels with the project.** What a Figma import learned about each component (its published key and a structural fingerprint) is kept in a small file at the project root, `figma-components.json`, beside `libraries.yaml`. It rides along wherever the project goes: a publish to the cloud, a synced folder on another machine, "Make available offline", a fork, a transfer to a team, a copy of the folder. So a library released from any of those places still matches the Figma files that use it. The explorer hides the file like it hides `libraries.yaml`; leave it in place when you copy a project by hand. Renaming a canvas, moving it into a folder, or moving a component to another canvas keeps the match too.

## With an older plugin

A plugin that does not know the import screen asks the same questions on cards during the import, one decision per run, and the card always appears before Brilliant contacts Figma about the library (nothing is looked up until you say yes): "Set up the library behind N components?" with **Set up library** and **Import as copies** for a library not in Brilliant; "Link library "Name"?" with **Link library** and **Import as copies** when you already have the library project (adding the components it does not hold yet with the same press); "Add N new library components?" with **Add components** when a linked library brings more. After a yes the card counts the components looked up so far (Figma limits how fast, so a file with many library components can take a few minutes); components Figma was too busy to answer for stay copies and are picked up on the next import of the file, without asking again. **Import as copies** is remembered for that Figma file.
