# FoxBin2Prg — mirrored-tree edition (`mirrortree` branch)

**Binary/text conversion for Microsoft Visual FoxPro 9** — modular source tree derived from the original [FoxBin2Prg](https://github.com/fdbozzo/foxbin2prg) project.

> **Branch:** `mirrortree`  
> This branch is a **slim, purpose-built variant** of the [refactor](https://github.com/lkmatsumura/foxbin2prg/tree/refactor) fork. It keeps only what is needed for the **mirrored-tree** SCM workflow and removes the rest of the upstream surface area so the tool is simpler to operate and lighter to maintain.

---

## What is FoxBin2Prg?

FoxBin2Prg converts Visual FoxPro binary artifacts (VCX, SCX, PJX, DBC, DBF, FRX, MNX, and others) into PRG-style text files (VC2, SC2, PJ2, DC2, DB2, FR2, MN2, …) suitable for source control, diff, and merge. The text format is not compilable code, but it can be edited and compared like a PRG, and the original binaries can be regenerated from it.

On this branch, that capability exists **only to serve mirrored-tree export/import**: one VFP project folder (binaries) mirrored into a separate text tree (Git), driven by `.PJX` / `.PJ2` membership. It is **not** a drop-in replacement for the full upstream FoxBin2Prg distribution (Thor, VFPX, interactive batch modes, disk-based configuration inheritance, and related tooling).

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

## About this branch

The upstream FoxBin2Prg shipped as a single `foxbin2prg.prg` with more than **35,000 lines** of code. The **refactor** branch split that monolith into modular `.prg` files for readability and added a mirrored-tree API (`exportProjectTree` / `importProjectTree`).

The **`mirrortree` branch goes further**: it trims everything that is not required for mirrored-tree operation. The conversion engine remains (it is what produces the text files), but configuration, CLI entry points, and auxiliary modules that exist mainly for the full upstream product were removed or simplified.

| | `refactor` branch | `mirrortree` branch (this) |
|--|-------------------|----------------------------|
| Goal | Readable full FoxBin2Prg fork | Mirrored-tree SCM workflow only |
| Configuration | Programmatic CFG + legacy disk CFG support | **Programmatic only** (`newConfig()` objects) |
| Primary driver | `mirror.prg`, API, or full `main.prg` modes | **`mirror.prg`** and `exportProjectTree` / `importProjectTree` |
| CLI | Full upstream-style modes (`BIN2PRG`, `PRG2BIN`, folders, …) | **Minimal** `main.prg` (single file + config reference) |
| Distribution | Optional monolith via `unify.prg` | Same; no Thor / VFPX release path |

Use **`refactor`** or **`master`** if you need parity with the broader FoxBin2Prg feature set. Use **`mirrortree`** when your workflow is exclusively: binaries in one tree, text in Git, sync via project mirror.

Please show your support for the original project's repository. This fork was created to meet my specific needs, but if you find it useful, feel free to use it and suggest improvements.

---

## What was removed or simplified

These changes keep the codebase focused on mirrored-tree use:

| Removed / simplified | Why |
|----------------------|-----|
| `foxbin2prg.cfg` on disk, per-directory inheritance | Settings are passed as CFG objects (`loCfg = loFb2p.newConfig()`) — see [mirror.prg](mirror.prg) |
| `cl_cfg.prg`, `cl_dbf_cfg.prg` | Disk CFG and per-DBF CFG loaders |
| `foxbin2prg.cfg.txt`, `foxbin2prg.dbf.cfg.txt` | Sample disk configuration files |
| `frm_interactive.prg` | Interactive batch driver not needed for mirror workflow |
| Full `main.prg` CLI surface | Replaced by a minimal entry point; project work goes through the mirror API |
| Large parts of `cl_fb2prg_cfg.prg` and `c_foxbin2prg.prg` | Factory/session CFG only; orchestration trimmed and delegated to `cl_fb2prg_*` helpers (see [docs/arquitetura.md](docs/arquitetura.md)) |

**Still included:** all `c_conversor_*` modules (conversion is required), orchestrator helpers (`cl_fb2prg_execute`, `cl_fb2prg_split_paths`, `cl_fb2prg_conversion_factory`, `cl_fb2prg_logger`, `cl_fb2prg_cfg`, `cl_fb2prg_mirror`), [mirror.prg](mirror.prg), [create_mirrored.prg](create_mirrored.prg), optional [unify.prg](unify.prg) to rebuild `foxbin2prg.prg`, and [ReCreate_FoxBin2Prg.prg](ReCreate_FoxBin2Prg.prg) to build the EXE from this tree.

---

## Architecture (mirrored-tree focus)

```mermaid
flowchart LR
    monolith["foxbin2prg.prg\n35k+ lines (upstream)"]
    split["refactor: modular .prg"]
    mirror["mirrortree: mirror-only trim"]
    api["exportProjectTree\nimportProjectTree"]
    driver["mirror.prg"]

    monolith --> split --> mirror --> api --> driver
```

| Module | File | Purpose |
|--------|------|---------|
| Orchestrator (slimmed) | [c_foxbin2prg.prg](c_foxbin2prg.prg) (~3,000 lines) | Coordinates conversion; `exportProjectTree` / `importProjectTree`; delegates to helper objects |
| Execute pipeline | [cl_fb2prg_execute.prg](cl_fb2prg_execute.prg) | `execute()` / `run()` dispatch and batch handlers |
| Config manager | [cl_fb2prg_cfg.prg](cl_fb2prg_cfg.prg) | `createCfgShell`, `newConfig()`, programmatic `loCfg` only |
| Conversion factory | [cl_fb2prg_conversion_factory.prg](cl_fb2prg_conversion_factory.prg) | Instantiates bin↔text converters |
| Split paths | [cl_fb2prg_split_paths.prg](cl_fb2prg_split_paths.prg) | Class/form per-file path mapping |
| Logger | [cl_fb2prg_logger.prg](cl_fb2prg_logger.prg) | Progress and diagnostic output |
| Special props (singleton) | [cl_fb2prg_special_props.prg](cl_fb2prg_special_props.prg) | Loads `a_SpecialProps*` once for all converters |
| File helpers | [cl_file_utils.prg](cl_file_utils.prg) | File I/O separation |
| Mirror tree API | [cl_fb2prg_mirror.prg](cl_fb2prg_mirror.prg) | Path mapping for mirrored export/import |
| Converters | [c_conversor_*.prg](c_conversor_base.prg) | All derive from `c_conversor_base` |
| Mirror driver | [mirror.prg](mirror.prg) | Interactive import/export for this repository's layout |

Further reading: [docs/arquitetura.md](docs/arquitetura.md) (full diagram and helper-class detail), [docs/export_import_mirror.md](docs/export_import_mirror.md).

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

**Minimal CLI** — single-file conversion only (for ad-hoc tests, not full-project mirror):

```foxpro
DO main.prg WITH "<path>\file.vcx"
DO main.prg WITH "<path>\file.vc2"
DO main.prg WITH "-VERNO"                && version string
DO main.prg                              && configuration reference form
```

---

## Fork-specific settings

These settings are central to the mirrored-tree workflow. Set them on a CFG object (`loCfg.l_UseClassPerDir = .T.`) — there is **no** `foxbin2prg.cfg` file on this branch.

| Property | Purpose |
|----------|---------|
| `l_UseClassPerDir` | When `UseClassPerFile` > 0, create a subdirectory named after the class library for per-class files |
| `l_UseFormPerDir` | Same concept for forms |
| `l_CopyExcludedPjxFiles` | Export/import PJX members marked **Exclude** |
| `l_CopyNonConvertible` | Copy non-convertible files (PJX, VCX, SCX, etc.) into the mirrored tree |
| `l_CopyLowercaseNames` | Copy non-converted files with lowercase names |
| `c_ExcludedSubdirs` | Skip listed subpaths (`;` or `,` separated, relative to project root) |
| `l_ExportUtf8` | Write converted text as UTF-8; text files matched by `isTextFileForEncoding()` use `strconv(str, 9)` on export and `strconv(str, 11)` on import |

> **Note:** Some of these behaviors overlap with upstream options. This branch uses only the programmatic settings above for mirrored-tree mode and does not aim to support every upstream CFG keyword.

---

## Encoding, Git, and naming conventions

**Source PRGs in this repository** are saved as **Windows-1252 (CP1252)** for Visual FoxPro compatibility. Editors and AI tools that default to UTF-8 caused accent and encoding problems during development.

**Converted output** can be written as UTF-8 when `l_ExportUtf8` is enabled, which plays better with Git and modern editors.

**Lowercase names** — this fork forces lowercase file names and extensions on export (e.g. `projeto.pj2` instead of `projeto.PJ2`) and lowercase directory names. That is a personal preference for SCM consistency.

**Git history** — many commits reflect line-ending or code-page normalization rather than functional code changes. See [.gitattributes](.gitattributes) for encoding and line-ending rules applied in this repo.

---

## Rebuilding the monolithic `foxbin2prg.prg` (optional)

Normal development uses the modular [main.prg](main.prg) entry point. To produce a single-file distribution, run [unify.prg](unify.prg):

- Reads the module list in [unify.txt](unify.txt).
- Concatenates them into `foxbin2prg.prg`.
- Inlines `foxbin2prg.h` and rewrites `NewObject` / `AddObject` references for monolithic use.

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
2. Clone this repository into `foxbin2prg\scm` (check out the **`mirrortree`** branch).
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

After a `git pull` that changes text sources, re-run `mirror.prg` (import) and then `ReCreate_FoxBin2Prg.prg`. If you change binary sources, export the changes to `scm` with `mirror.prg`.

---

## Further documentation

| Document | Relevance on `mirrortree` |
|----------|---------------------------|
| [docs/readme.md](docs/readme.md) | Documentation index |
| [docs/export_import_mirror.md](docs/export_import_mirror.md) | **Primary** — mirrored export/import guide |
| [docs/arquitetura.md](docs/arquitetura.md) | Architecture; helper classes, mirror, and CFG sections apply |
| [docs/c_foxbin2prg_ClassAnalysis.md](docs/c_foxbin2prg_ClassAnalysis.md) | Orchestrator deep-dive (Portuguese) |
| [docs/FoxBin2Prg_Object.md](docs/FoxBin2Prg_Object.md) | Object-style API (`execute`, `newConfig`, mirror methods) |
| [docs/FoxBin2Prg_Internals.md](docs/FoxBin2Prg_Internals.md) | CFG properties and internals; disk CFG topics mostly N/A here |
| [docs/FoxBin2Prg.md](docs/FoxBin2Prg.md) | Upstream-oriented; many CLI/CFG topics do not apply here |
| [docs/FoxBin2Prg_Run.md](docs/FoxBin2Prg_Run.md) | Upstream run modes; only single-file `main.prg` usage applies |
| [docs/FoxBin2Prg_SCM.md](docs/FoxBin2Prg_SCM.md) | Upstream SCM notes; mirrored-tree workflow is in export_import_mirror |
| [docs/ChangeLog.md](docs/ChangeLog.md) | Change history |
| [.github/CONTRIBUTING.md](.github/CONTRIBUTING.md) | Contribution guidelines |

---

Last updated: _2026/06/29_ ![Picture](./docs/pictures/vfpxpoweredby_alternative.gif)
