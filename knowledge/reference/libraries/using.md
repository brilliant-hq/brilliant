---
name: "knowledge-libraries-using"
description: "Placing and referencing library components, unresolved references, fonts, the library design system on an instance, and what component actions do."
assumes: reference/libraries
---

# Using library components

Insert from the Assets view (`reference/libraries/assets`), or reference a library component in Blueprint:

```
inst(Button, lib(acme/design-kit), canvas(Atoms/Buttons))
```

`lib()` names the library by its `handle/project` (no `@`), and `canvas()` is the path of the canvas **inside the library** where the master lives, written as the library lists it: no extension, no quotes needed even with a space (`canvas(2 Android)`); `canvas("2 Android")` and `canvas(2 Android.bl)` are read as the same path. For a local folder library, `lib()` wraps the manifest key in `local()` instead (`lib(local(my-kit))`, `lib(local(Material 3 Kit))` - the key is the library's name in `libraries.yaml`, the folder's name when you added it from a folder). Older files written as `lib(@acme/design-kit)` or with a bare local key still read fine and are rewritten to the current form on the next save of that canvas. Everything else about instances is unchanged: `at()` picks a variant, `override()` and slots work as usual, and overrides survive library updates. Full instance syntax: `blueprint/components`.

**When a reference does not resolve.** A row whose library reference cannot be resolved is still written: it lands as an empty placeholder that keeps the reference, and the `edit` answer says which part is wrong and what to do, one note per row:

- "Library "@acme/design-kit" is not in this project": add it first with `add_library`; the placeholder then fills in by itself.
- "Canvas "Atoms/Buttonz" is not in @acme/design-kit 1.2.0", followed by the canvases that release does have.
- "Component "Buton" is not on canvas "Atoms/Buttons" of @acme/design-kit 1.2.0", followed by the names of the components that canvas has (up to six, then "and N more"). A name that several components share is answered with their ids; write the row again with the id you mean.
- "... is not downloaded yet" only when the library is in the project and still on its way: the placeholder fills in by itself once it lands, and reading the canvas again confirms it.
- "Canvas "Atoms/Buttons" of @acme/design-kit 1.2.0 could not be read right now": the copy on this computer is damaged. It is downloaded again, and the placeholder fills in by itself once the canvas can be read.

For the two middle cases, write the row again with a real canvas or component, or delete the placeholder.

Rows written under a library instance in the same edit (a slot fill, an `override()`) land with it: the edit reads the library first. When the instance could not be resolved, its note also says that those rows could not be applied and asks you to send them again once the instance has filled in.

**Fonts.** A library's text uses the library's fonts. When a library this project uses needs fonts this computer does not have, one notification names them ("Acme Design System needs 2 fonts you don't have", then the font names) as soon as you place one of its components or look at them in Assets; each missing font is named once per library while the project is open, and a component that needs another missing font brings one more notice. Nothing is blocked: the components place and update as usual, and their text shows in a fallback font until you install the fonts. Fonts do not travel with a library.

A library instance renders with the **library's own design system** by default, so it looks the way its author designed it even inside a project with a different brand. Select a placed component and the inspector's Component section says **where it comes from**: the library's name and version with an "Open in library" link (it opens the library's own project), or "<name>, Live" for a folder library. When a newer release exists the row adds "1.4.0 available" and an **Update** button that opens the library's update screen in the Assets view (for a library the project lists itself; one that came along with another library offers no Update of its own). While the selected component is missing, the reason sentence takes the row's place (`reference/libraries/unavailable`). A component from the project itself reads "This project, <canvas>" with "Go to main component". A selection spanning two sources shows no source row.

To re-theme it with your project's tokens instead, select the instance and flip the **Design system** dropdown in the inspector's Component section from the library's name to "This project" (in Blueprint, the `projds` flag on the instance line does the same, and `no-projds` switches it back). Your project's active modes (theme, density) still apply either way; where the library does not define a mode, its default is used.

What the usual component actions do on a library component:
- **Variants** work like any component's: the inspector's Component section shows the library component's variant dropdowns, and in Blueprint `<id> at(kind(fancy))` switches a placed one. The choices are the library's, even when your project has a component of the same name. A component nested inside a placed library component switches the same way (select it, or address its id with `at(...)`): your choice is kept when the library updates, and if a new release no longer offers it, the update says so ("Variant choice on Chip") and the nested component shows the library's own choice.
- **Export** to SVG, PDF, HTML or React carries the library component's pictures, the same as the canvas shows them.
- **Detach Instance** turns it into a regular frame that looks exactly the same. The frame keeps the library's design system (unless you had switched it to This project), pictures the library has already delivered are copied into your project's assets, and any component nested inside it that also comes from the library stays a library component. Undo brings the instance back.
- **Push Overrides to Master** is not available: "This component comes from the library Acme Design System, so its changes cannot be pushed from here. Open the library project to change it."
- **Reset Overrides** brings back the library's values. If the library cannot be reached at that moment, nothing changes and a notice says so: "Couldn't reset to Acme Design System" with "The library can't be reached right now. Check your connection and reset again."
- **Go to Master Component** answers "This component comes from the library Acme Design System, so it cannot be opened from here. Open the library project to change it."; use "Open in library" in the inspector to open the library's project.
- **Duplicate** and **copy/paste** inside the project give you another instance of the same library component, overrides included. Pasted into a project that does not use the library, it looks exactly as it did where it was copied (the library's colors and type, its pictures), and the inspector says "This component's library, Acme Design System, was removed from this project." with **Add it back**; one press adds the library at the version this project last used, or, if it never used the library, the version it was copied at, and makes the component live again. Pasted into a project that already uses the library, it is simply another live instance.
