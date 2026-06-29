# Mirrored export and import (`exportProjectTree` / `importProjectTree`)

These APIs export or import an **entire** project (`.PJX` / `.PJ2` and all members), replicating the project's subfolder tree in the destination folder. They are the recommended flow for mirroring a VFP project as text (SCM) and rebuilding binaries afterward.

```foxpro
lnResp = loFb2p.exportProjectTree( tcProjectFile, tcOutputRoot [, toCfg] [, tcInputRoot] )
lnResp = loFb2p.importProjectTree( tcMirrorProjectFile, tcOutputRoot [, toCfg] [, tcInputRoot] )
```

The optional `toCfg` parameter accepts:

- a CFG object returned by `newConfig()` or validated by `isCfg()`;
- any object with compatible properties (duck-typing via `configFromObject`).

Full example: [`create_mirrored.prg`](../create_mirrored.prg) and [`mirror.prg`](../mirror.prg). Technical overview: [arquitetura.md — Mirrored tree](arquitetura.md#mirrored-tree).

Path mapping (`get_MirroredPath`, `isExcludedSubdir`, `copyUnconvertedFile`, …) is implemented in `cl_fb2prg_mirror.prg` and invoked via `c_foxbin2prg.o_Mirror`. Project batch conversion runs through `execute()` → `cl_fb2prg_execute.run()` → `evaluate_Full_PJX` / `evaluate_Full_PJ2`.

### Command line (`main.prg`)

Single-file conversion only (direction inferred from extension). For mirrored projects use the API above or `mirror.prg`:

```foxpro
DO main.prg WITH "<path>\file.vcx"
DO main.prg WITH "<path>\file.vc2"
DO main.prg WITH "<path>\file.vcx", "", loCfg
DO main.prg                              && configuration reference form (frm_main)
```

`execute()` also accepts internal batch types `-BIN2PRG` / `-PRG2BIN` (folder conversion) and `BIN3PRG` / `PRG3BIN` (mirror export/import aliases that require `cOutputFolder` or `tcTextName`).

---

## When the options below apply

The mirror-specific options documented below **only affect batch project processing** when the session is in **mirrored tree** mode — that is, when `exportProjectTree` or `importProjectTree` set `cOutputFolder` (and `cInputRoot`) via `o_Mirror.setProjectRoots`.

| Situation | Option effect |
|----------|-------------------|
| `exportProjectTree` / `importProjectTree` with `toCfg` | **Yes** — apply to each PJX/PJ2 member |
| `execute` on a single `.vcx` / `.scx` | **No** — no project mirrored folder |
| Folder conversion with `BIN2PRG` / `PRG2BIN` on the CLI | **No** — does not use the same project-member flow |

Use the **same `toCfg` object** on export and import for round-trip consistency.

---

## Options summary

| Programmatic property | Default | Function |
|--------------------------|--------|--------|
| `c_ExcludedSubdirs` | *(empty)* | Ignores subfolders (neither converts nor copies) |
| `l_CopyNonConvertible` | `.F.` | Copies files FoxBin2Prg does not convert |
| `l_CopyExcludedPjxFiles` | `.F.` | Includes members marked **Exclude** in PJX/PJ2 |
| `l_ExportUTF8` | `.F.` | Writes text exports (VC2, SC2, PJ2, …) and copied `.prg`/`.txt`/`.h` files as UTF-8; decodes on import |
| `l_CopyLowercaseNames` | `.F.` | Lowercase destination names when copying non-convertible files |

---

## `c_ExcludedSubdirs`

List of subpaths **relative to the project root** (`cInputRoot`) that must be **ignored** during export and import.

- **Format:** text with entries separated by `;` or `,` (surrounding spaces are ignored).
- **Comparison:** each entry is a path segment. A file is excluded if the relative path contains `\entry\` at any level.
- **Effect:** the member is **not converted** and **not copied** to the mirrored tree.
- **Log:** `* Excluded (subdir): <file>`

### Examples

```foxpro
loCfg.c_ExcludedSubdirs = 'tmp;backup'
loCfg.c_ExcludedSubdirs = 'forms\old;deps\vendor'
```

With project at `d:\src\app\` and `c_ExcludedSubdirs = 'tmp;backup'`:

| Project file | Result |
|--------------------|-----------|
| `d:\src\app\forms\main.scx` | Processed normally |
| `d:\src\app\tmp\scratch.prg` | Ignored |
| `d:\src\app\backup\old.vcx` | Ignored |
| `d:\src\app\forms\old\legacy.scx` | Ignored if `forms\old` is in the list |

### Programmatic property (CFG object)

```foxpro
loCfg.c_ExcludedSubdirs = 'tmp;backup;forms\old'
```

Legacy disk `foxbin2prg.cfg` files are **not** supported. Use `newConfig()` and assign properties on the CFG object (see `getConfigPropertyCatalog()` in `cl_fb2prg_cfg.prg`).

---

## `l_CopyNonConvertible`

When a project member is **not supported** for conversion by FoxBin2Prg (for example `.bmp`, `.ico`, `.dll`, `.prg` without conversion support, etc.), the default behavior is to **generate nothing** in the mirrored tree.

With `l_CopyNonConvertible = .T.`:

- The file is **copied byte for byte** to the mirrored destination, preserving subfolders relative to the project.
- When `l_ExportUTF8 = .T.`, recognized **text files** (`.prg`, `.txt`, `.h`, `.cfg`, etc.) are converted to UTF-8 on export and back to the current ANSI code page on import; binary files remain a byte-for-byte copy.
- Copies only if the file exists on disk and is **inside `cInputRoot`**.
- The destination name respects `l_CopyLowercaseNames` when active.
- **Log:** `- Copied (not convertible): <mirrored path>`

### When to use

- Export a **complete** project tree to SCM, including resources that do not become VC2/SC2.
- Round-trip where import must recreate the same auxiliary file tree at the destination.

### Example

```foxpro
loCfg.l_CopyNonConvertible = .T.
loFb2p.exportProjectTree( 'd:\src\app\app.pjx', 'd:\export\app', loCfg )
```

---

## `l_CopyExcludedPjxFiles`

In Visual FoxPro, project members can be marked **Exclude** (not part of the build, but still listed in the `.pjx`).

| Value | Mirrored tree behavior |
|-------|-----------------------------------|
| `0` (default) | Excluded members are **omitted** — neither converted nor copied |
| `1` | Excluded members are **processed** like others (converted if supported; copied if `l_CopyNonConvertible` and not convertible) |

- **Export (`evaluate_Full_PJX`):** reads the `EXCLUDE` column from the `.pjx` table.
- **Import (`evaluate_Full_PJ2`):** reads the `<ExcludedFiles>` block from the `.pj2`.
- **Log (when omitted):** `* Excluded (PJX): <file>`

### When to use

- **Default `0`:** lean mirror — only what goes into the build or code SCM.
- **`1`:** faithful mirror of the full `.pjx`, including utilities, documentation, or tools marked Exclude.

### Example

```foxpro
loCfg.l_CopyExcludedPjxFiles = .T.
loCfg.l_CopyNonConvertible   = .T.   && useful for Exclude members that are .prg, .bmp, etc.
loFb2p.exportProjectTree( 'd:\src\app\app.pjx', 'd:\export\app', loCfg )
```

---

## `l_ExportUTF8`

When enabled (`loCfg.l_ExportUTF8 = .T.`):

- **Converted text files** (VC2, SC2, PJ2, DC2, DB2, …) are written as UTF-8 via `writeTextFile()` / `encodeTextForExport()`.
- **Imported text files** are read as UTF-8 when the flag is on (`readTextFile()` / `decodeTextFromImport()`).
- **Non-convertible text copies** (with `l_CopyNonConvertible`) also use UTF-8 on export and decode on import (`cl_fb2prg_mirror.copyUnconvertedFile`).
- **Binary artifacts** (`.bmp`, `.dll`, VCX, etc.) are unaffected.

Typical SCM setup (see [`mirror.prg`](../mirror.prg)):

```foxpro
loCfg.l_ExportUTF8       = .T.   && export scm text as UTF-8
loCfg.l_CopyNonConvertible = .T.
loFb2p.exportProjectTree( lcPjx, lcDest, loCfg )

* On import of FoxBin2Prg sources, turn off UTF-8 for legacy ANSI .prg trees:
loCfg.l_ExportUTF8 = .F.
loFb2p.importProjectTree( lcPj2, lcDest, loCfg )
```

---

## Recommended programmatic configuration

```foxpro
loFb2p = NewObject( 'c_foxbin2prg', 'c_foxbin2prg.prg' )
loCfg  = loFb2p.newConfig()

loCfg.l_NoTimestamps         = .T.
loCfg.l_CopyNonConvertible   = .T.
loCfg.l_ExportUTF8           = .T.   && optional: UTF-8 text in mirror
loCfg.l_CopyExcludedPjxFiles = .F.   && default: omit Exclude
loCfg.c_ExcludedSubdirs      = 'tmp;backup;forms\old'

* Export binary -> mirrored text
loFb2p.exportProjectTree( 'd:\src\app\app.pjx', 'd:\export\app', loCfg )

* ... edit text files in SCM ...

* Import text -> binary (same loCfg)
loFb2p.importProjectTree( 'd:\export\app\app.pj2', 'd:\src\app', loCfg )
```

You can pass any object with compatible property names via `configFromObject` — see `getConfigPropertyCatalog()` in `cl_fb2prg_cfg.prg` or run `DO main.prg` with no file for the in-app reference. Property names match the **Programmatic property** column in the table above.

---

## Evaluation order per project member

For each file listed in the PJX/PJ2, in mirrored tree mode:

1. In a subfolder of `c_ExcludedSubdirs`? -> skip
2. Marked Exclude and `l_CopyExcludedPjxFiles` is false? -> skip
3. Outside `cInputRoot`? -> skip (or error if `n_CheckFileInPath` is set on the CFG)
4. Convertible? -> convert to mirrored path
5. Not convertible and `l_CopyNonConvertible`? -> copy
6. Otherwise -> no output in the tree

---

## Debugging

Enable logging with `loCfg.n_Debug = 1` (or `loCnv.setCfgValue('n_Debug', 1)` after `applyConfig`). The project `.LOG` file lists each member with one of the messages above.

At the end of configuration evaluation, the dump includes:

```
CopyNonConvertible:         ...
CopyExcludedPjxFiles:       ...
ExcludedSubdirs:            ...
ExportUTF8:                 ...
```
