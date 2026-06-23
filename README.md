# FoxBin2Prg (refactored SCM fork)

**Binary/text conversion for Microsoft Visual FoxPro 9** — modular source tree derived from the original [FoxBin2Prg](https://github.com/fdbozzo/foxbin2prg) project.

---

## What is FoxBin2Prg?

FoxBin2Prg converts Visual FoxPro binary artifacts (VCX, SCX, PJX, DBC, DBF, FRX, MNX, and others) into PRG-style text files (VC2, SC2, PJ2, DC2, DB2, FR2, MN2, …) suitable for source control, diff, and merge. The text format is not compilable code, but it can be edited and compared like a PRG, and the original binaries can be regenerated from it.

It is intended for use with SCM/DVCS tools (Git, SVN, Mercurial, etc.) or as a standalone diff/merge helper, and can substitute for tools such as SccText/X and TwoFox.

---

## Credits and lineage

This repository is a **fork** of [FoxBin2Prg](https://github.com/fdbozzo/foxbin2prg) by [Fernando D. Bozzo](https://github.com/fdbozzo). The original project is perpetuated and maintained upstream by **Lutz Scheffler**.

| Role | Who |
|------|-----|
| Original author | [Fernando D. Bozzo](https://github.com/fdbozzo/foxbin2prg) |
| Upstream maintainer | **Lutz Scheffler** |
| This fork | **Luiz Matsumura** — [github.com/lkmatsumura/foxbin2prg](https://github.com/lkmatsumura/foxbin2prg) |

Thank you to Fernando for creating FoxBin2Prg and to Lutz for continuing its maintenance.

### Licence

This work is licensed under the MIT License.

---

## About this fork

The upstream FoxBin2Prg shipped as a single `foxbin2prg.prg` with more than **35,000 lines** of code. That made it hard to explore the structure, understand how configuration propagated through the routines, or reuse parts of the tool in simpler, project-specific workflows.

This fork is a **readability refactor**: the monolith was split into many `.prg` files so each class and concern lives in its own module. The goal is to make the codebase easier to navigate, adapt, or mine for pieces that fit custom tooling.

During the refactor, the main use case that emerged was **mirrored-tree export**: keeping VFP binary sources in one folder while maintaining a separate text tree in Git, driven by `.PJX` project membership rather than only single-file conversion.

Please show your support for the original project's repository.
This fork was created to meet my specific needs, but if you find it useful, feel free to use it and suggest improvements.

---

## Refactoring overview

The work proceeded in stages:

1. **One class per file** — every class definition was moved to its own `.prg`, which alone improved navigation.
2. **Configuration extraction** — `c_foxbin2prg` was overloaded with settings; relevant properties were collected in `cl_cfg`, and `cl_fb2prg_cfg` was added to manage per-directory configuration inheritance.
3. **Special properties singleton** — `cl_fb2prg_special_props` loads the `a_SpecialProps*` arrays once and shares them across all `c_conversor_*` instances (previously reloaded on every converter instantiation).
4. **File utilities** — `cl_file_utils` separates file I/O from the orchestrator.
5. **Mirrored tree** — `cl_fb2prg_mirror` plus `exportProjectTree` / `importProjectTree` support full-project export/import with replicated subfolder structure.

```mermaid
flowchart LR
    monolith["foxbin2prg.prg\n35k+ lines"]
    split["One class per .prg"]
    cfg["cl_cfg + cl_fb2prg_cfg"]
    props["cl_fb2prg_special_props"]
    files["cl_file_utils"]
    mirror["cl_fb2prg_mirror\n+ create_mirrored.prg"]

    monolith --> split --> cfg --> props --> files --> mirror
```

| Module | File | Purpose |
|--------|------|---------|
| Orchestrator (slimmed) | [c_foxbin2prg.prg](c_foxbin2prg.prg) (~3,800 lines) | Coordinates conversion; delegates configuration |
| Config schema | [cl_cfg.prg](cl_cfg.prg) | Property definitions and `_MemberData`; keeps `c_foxbin2prg` memberdata manageable |
| Config manager | [cl_fb2prg_cfg.prg](cl_fb2prg_cfg.prg) | Per-directory CFG inheritance, `newConfig()`, file parsing |
| Special props (singleton) | [cl_fb2prg_special_props.prg](cl_fb2prg_special_props.prg) | Loads `a_SpecialProps*` once for all converters |
| File helpers | [cl_file_utils.prg](cl_file_utils.prg) | File I/O separation |
| Mirror tree API | [cl_fb2prg_mirror.prg](cl_fb2prg_mirror.prg) | Used by `exportProjectTree` / `importProjectTree` in c_foxbin2prg |
| Converters | [c_conversor_*.prg](c_conversor_base.prg) | All derive from `c_conversor_base` |

Further reading: [docs/arquitetura.md](docs/arquitetura.md), [docs/export_import_mirror.md](docs/export_import_mirror.md).

---

## Mirrored tree usage

The mirrored-tree workflow exports an entire VFP project (`.PJX` and all members) into a destination folder, replicating the project's subfolder layout. The same configuration can import the text tree back into binaries.

**Programmatic API** (see [create_mirrored.prg](create_mirrored.prg) for full examples):

```foxpro
loFb2p = NewObject('c_foxbin2prg', 'c_foxbin2prg.prg')
loCfg  = loFb2p.newConfig()
*-- configure loCfg properties (see below)
loFb2p.exportProjectTree('d:\src\app\app.pjx', 'd:\export\app', loCfg)
loFb2p.importProjectTree('d:\export\app\app.pj2', 'd:\src\app', loCfg)
```

**Interactive driver for this repository** — [mirror.prg](mirror.prg) batch-processes the projects bundled here (`foxbin2prg`, `Others`, `Fb2P_Diff`, `FileName_Caps`, `dont_convert`) between the `scm` text tree and the parent binary folder.

---

## Fork-specific settings

These settings were added or are central to the mirrored-tree workflow in this fork. They can be set on a CFG object (`loCfg.l_UseClassPerDir = .T.`) or in a `.cfg` file (keys shown in the first column).

| `.cfg` key / property | Purpose |
|-----------------------|---------|
| `UseClassPerDir` / `l_UseClassPerDir` | When `UseClassPerFile` > 0, create a subdirectory named after the class library for per-class files |
| `UseFormPerDir` / `l_UseFormPerDir` | Same concept for forms |
| `CopyExcludedPjxFiles` / `l_CopyExcludedPjxFiles` | Export/import PJX members marked **Exclude** |
| `CopyNonConvertible` / `l_CopyNonConvertible` | Copy non-convertible files (PJX, VCX, SCX, etc.) into the mirrored tree |
| `CopyLowercaseNames` / `l_CopyLowercaseNames` | Copy non-converted files with lowercase names |
| `ExcludedSubdirs` / `c_ExcludedSubdirs` | Skip listed subpaths (`;` or `,` separated, relative to project root) |
| `ExportUtf8` / `l_ExportUtf8` | Write converted text as UTF-8; text files matched by `isTextFileForEncoding()` use `strconv(str, 9)` on export and `strconv(str, 11)` on import |

> **Note:** Lutz Scheffler pointed out that some of these behaviors overlap with existing upstream options. This fork currently relies on the settings above for the mirrored-tree mode and does not aim to use every upstream CFG feature.

---

## Encoding, Git, and naming conventions

**Source PRGs in this repository** are saved as **Windows-1252 (CP1252)** for Visual FoxPro compatibility. Editors and AI tools that default to UTF-8 caused accent and encoding problems during development; it is unclear whether the original FoxBin2Prg would accept PRG sources in another code page.

**Converted output** can be written as UTF-8 when `l_ExportUtf8` is enabled, which plays better with Git and modern editors.

**Lowercase names** — this fork forces lowercase file names and extensions on export (e.g. `projeto.pj2` instead of `projeto.PJ2`) and lowercase directory names. That is a personal preference for SCM consistency.

**Git history** — many commits reflect line-ending or code-page normalization rather than functional code changes. See [.gitattributes](.gitattributes) for encoding and line-ending rules applied in this repo.

---

## Rebuilding the monolithic `foxbin2prg.prg` (optional)

Normal development uses the modular [main.prg](main.prg) entry point. To produce a single-file distribution, run [unify.prg](unify.prg):

- Reads the module list in [unify.txt](unify.txt) (79 files).
- Concatenates them into `foxbin2prg.prg`.
- Inlines `foxbin2prg.h` and rewrites `NewObject` / `AddObject` references for monolithic use.

`cl_cfg.prg` is not listed in `unify.txt` because it serves mainly as a schema/reference class; add it to `unify.txt` only if the monolith must be fully self-contained.

---

## Regenerate after download / clone / pull

After cloning or pulling this repository, you must rebuild the binary artifacts and executables from the text sources.

**Note: Do not run a stale `FoxBin2Prg.prg` directly before regeneration.**

### Directory layout

```
foxbin2prg/          ← binary (VFP) working tree
  scm/               ← this repository (text PRGs)
```

### Steps

1. Create the binary working folder, for example:
   ```
   mkdir foxbin2prg
   ```
2. Clone this repository into `foxbin2prg\scm`.
3. In Visual FoxPro, `CD` to the `scm` folder and run:
   ```foxpro
   DO mirror.prg
   ```
4. Verify the paths displayed:
   - **Source (scm)** — the `scm` folder (text PRGs)
   - **Binary** — the parent `foxbin2prg` folder

   If the paths are wrong, adjust the logic at the top of [mirror.prg](mirror.prg) and/or your folder layout.

   On **first setup**, answer **Yes** to *Import from scm (Convert PRG → BIN)* and **No** to *Export to scm (Convert BIN → PRG)*.

5. `CD ..` back to the binary root (`foxbin2prg`).
6. Regenerate executables from `scm`:
   ```foxpro
   CD scm
   DO ReCreate_FoxBin2Prg.prg
   ```

   Equivalent commands from [ReCreate_FoxBin2Prg.prg](ReCreate_FoxBin2Prg.prg): `DO Main.PRG ... Prg2Bin` followed by `BUILD EXE`.

After a `git pull` that changes text sources, re-run `mirror.prg` (import) and then `ReCreate_FoxBin2Prg.prg`.
If you change binary source export the changes to the scm with `mirror.prg`

---


### Further documentation

- [docs/FoxBin2Prg.md](docs/FoxBin2Prg.md) — full usage
- [docs/FoxBin2Prg_Run.md](docs/FoxBin2Prg_Run.md) — run modes and parameters
- [docs/ChangeLog.md](docs/ChangeLog.md) — change history
- [.github/CONTRIBUTING.md](.github/CONTRIBUTING.md) — contribution guidelines

---

Last updated: _2026/06/22_ ![Picture](./docs/pictures/vfpxpoweredby_alternative.gif)
