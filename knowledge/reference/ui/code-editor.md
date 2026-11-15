---
name: "knowledge-ui-code-editor"
description: "The built-in code editor for non-design files: highlighting, vim, find, line editing, multi-cursor, design-system problems, and the Markdown preview."
assumes: reference/ui
---

# Code Editor

When opening a non-design file (`.md`, `.dart`, `.json`, `.txt`, etc.) from the file explorer, a CodeMirror 6 text editor replaces the canvas. Rename the file from its row in the Files tree.

The editor fills the whole canvas area: from the left panel to the window edge (the inspector does not show for text files) and from the top bar to the bottom of the window, with line numbers inset from the left edge. A status bar across the bottom shows the vim mode, the cursor's line and column (`Ln 12, Col 4`), a `.ds` file's error and warning counts (click them to show or hide the problems list), the language and, for Markdown, the Preview toggle. The bottom toolbar floats just above the status bar, centred on the window, and the code scrolls far enough that its last line rests above the toolbar. Hiding the left panel, or the whole UI, gives the editor all the room. A file over 5 MB opens read-only, and a "Showing first 5 MB · read-only" line at the top of the editor says so.

- Syntax highlighting for common languages, including SCSS/Sass, Less, Vue, Svelte, and PHP. `.ds` design-system files highlight with a dedicated DSL grammar (comments, tokens, `$refs`, generator calls). `.bm` films (`Motion/<film>.bm`, beside `Styles/`) open with syntax highlighting too (comments, the header, state names, refs, calls, durations). Extensionless Makefile, Dockerfile, LICENSE, and README open as text with a sensible mapping.
- Vim mode (no default shortcut) is toggleable and reads vimrc-style mappings from disk; the active vim mode (NORMAL / INSERT / VISUAL) shows in the top toolbar.
- Find / replace uses standard CodeMirror keybindings (Cmd+F inside the editor); the "Find in File" palette command focuses the editor and opens the search panel. Read-only files (over 5 MB, view-only) show find without replace.
- Code shows in JetBrains Mono, the monospace face bundled with Brilliant, so it looks the same on every machine without installing anything.
- Font size: Cmd+= / Cmd+- / Cmd+0 inside the editor grow / shrink / reset (range 9 to 32, persisted). While the editor is focused, Cmd+0 is font reset rather than the chat-session shortcut.
- Line wrap: on by default; the "Toggle Line Wrap" palette command turns wrapping off/on (persisted).
- Line editing: move line up/down (Alt+Up/Down), copy line up/down (Shift+Alt+Up/Down), delete line (Cmd+Shift+K), insert line below/above (Cmd+Enter / Cmd+Shift+Enter), toggle comment (Cmd+/, language aware: `//` in `.ds`, `/* */` in CSS). All are real commands: rebindable in the shortcuts UI, runnable from the palette while a text file is open.
- Multi-cursor: select next occurrence (Cmd+D), select all occurrences (Cmd+Shift+L), add cursor above/below (Cmd+Alt+Up/Down), Option+Click adds a cursor, Option+drag makes a column selection.
- Occurrence highlights: selecting a word subtly highlights its other occurrences in the file.
- Color swatches: in `.ds` and CSS/SCSS/Sass/Less files, a small color chip renders before each hex color (`#rgb`, `#rrggbb`, `#rrggbbaa`).
- `.ds` problems: while you type, every error in the open design-system file is underlined in red (a warning in orange) with a gutter marker; hovering it shows the message, and the fix when there is one. A list at the top of the editor counts them and shows one row per problem (`line N` and the message); clicking a row jumps to that line. A problem with an automatic fix (such as tokens written inside braces that hold mode values only) offers it as a button, on its row and in the hover, and Cmd+Z undoes it. The list disappears once the file is clean.
- Auto-save persists to disk.

## Markdown preview (split view)

Opening a `.md` file shows the source in the code editor on the left and a live rendered preview on the right, separated by a draggable divider. The "Toggle Markdown Preview" palette command, or Cmd+Shift+V while the editor text is not focused, shows/hides the preview pane.

- The preview renders the same Brilliant Markdown dialect as brilliant.design (project READMEs, profile pages), and it supports essentially everything markdown supports: CommonMark plus GitHub Flavored Markdown (tables, task lists, strikethrough, and autolinks including bare `www.`/URL links), GitHub footnotes (`text[^1]` with a `[^1]: …` definition, collected into a linked section at the end), and GitHub alerts (`> [!NOTE]`, `[!TIP]`, `[!IMPORTANT]`, `[!WARNING]`, `[!CAUTION]` render as coloured callouts). HTML entities decode (`&copy;` → ©), link and image titles show on hover, loose lists (blank lines between items) breathe more than tight ones, and nested ordered lists cascade their markers (1. → a. → i.). Raw HTML never executes: a `<script>` or any tag is shown as inert text, and only http/https/mailto/tel links and https images are kept. What you see in the preview is what a reader sees on the web.
- Fenced ` ```blueprint ` blocks render as live design viewports, sized to the design's own proportions. Lines copied straight out of a canvas document work as fence content. A block that cannot render says why (for example an unrecognized token) instead of showing a blank box.
- Fenced code blocks are syntax-highlighted (JavaScript/TypeScript, Python, JSON, YAML, HTML, CSS, SQL, Rust, C++, Java, PHP, Go, Dart, shell, and more) in both light and dark themes; unknown languages render as plain code. Each block carries a copy button.
- The preview updates live as you type, follows the app theme, and works fully offline.
- Text in the rendered preview is selectable, and Cmd+C (macOS) / Ctrl+C (Windows) copies the selection. If the editor pane also has a selection, the editor's wins; copying with nothing selected never overwrites what's already on the clipboard. The preview is read-only, so cut does nothing there.
- HTML preview mode is available for `.html` files.
- File switching is via the file explorer or canvas/file navigation shortcuts. While the editor is focused, plain Alt+Left/Right is word motion; Cmd+Alt+Left/Right switches files.
- Copy / cut / paste (Cmd+C/X/V), select all (Cmd+A, also Edit > Select All), Tab indent, and Cmd+K global search all work inside the editor. Standard macOS text chords work too: Cmd+arrows (line/document boundaries, Shift extends), Option+Delete (word delete), Cmd+Delete (delete to line start), double-click word / triple-click line selection.
- Right-click opens a context menu: Cut / Copy / Paste / Select All plus Find in File and Go to Line. Items follow editor state (no selection disables Copy/Cut; read-only files disable Cut/Paste).
- Go to line: Ctrl+G inside the editor (or the "Go to Line" palette command) opens the line-jump panel.
- Escape defocuses the editor back to the file (in vim mode only from NORMAL mode; INSERT/VISUAL keep Esc for the mode exit).
- With the palette open, Escape or a click anywhere on the editor closes the palette and returns typing focus to the editor (same as clicking the canvas closes the palette).
- While a text or image file is open, the left toolbar shows only the file explorer (the layers panel returns when a canvas is active).

When the code editor is focused, undo/redo (keyboard and Edit menu) is captured by the editor, not by the canvas undo history. Each file keeps its own undo history, caret position, and scroll offset across file switches.

If the open file changes on disk while you have unsaved edits, a conflict notice ("<file> changed on disk", "Your unsaved edits are held until you choose.") offers Reload (take disk), Keep mine, or Review changes. Review opens a side-by-side diff (disk on the left, your edits on the right, editable for manual merging) with Accept disk / Keep mine on the pinned notice. Until you choose, nothing is saved over the other version: typing, saving, switching files or quitting keeps the disk version on disk and your edits in the editor (and in Brilliant's recovery folder), and coming back to the file shows your edits with the notice still standing. Whichever side you do not keep is also copied to the recovery folder.
