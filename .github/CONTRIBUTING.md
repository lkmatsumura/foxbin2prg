# Contributing to this fork

This repository is a **readability refactor** of [FoxBin2Prg](https://github.com/fdbozzo/foxbin2prg), maintained upstream by **Lutz Scheffler**. The development workflow here **differs from upstream** in several important ways. Read [README.md](../README.md) before making changes.

## How this fork differs from upstream

| Topic | Upstream | This fork |
|-------|----------|-----------|
| Source layout | Primarily one `foxbin2prg.prg` | Many modular `.prg` files under `scm/` |
| Primary goal | Full FoxBin2Prg distribution (EXE, Thor, VFPX) | Readable source, mirrored-tree SCM workflow |
| After clone | `DO ReCreate_FoxBin2Prg.prg` in the project root | `DO mirror.prg` (import) then `DO ReCreate_FoxBin2Prg.prg` — see README |
| Config focus | `FoxBin2Prg.cfg` file inheritance | Programmatic CFG objects plus fork-specific mirrored-tree settings |
| Source encoding | VFP defaults | PRG sources in **Windows-1252 (CP1252)**; converted output may use UTF-8 via `l_ExportUtf8` |
| Release process | Thor / VFPXDeployment, version bumps in monolith | No Thor release from this repo; optional `unify.prg` to rebuild a monolithic `foxbin2prg.prg` |

Do **not** assume upstream CONTRIBUTING steps (Thor updater, `Create_FoxBin2Prg.prg` text export of a monolith only, VFPX zip packaging) apply here without checking the README and project layout first.

## Suggested workflow for contributors

1. Fork and clone [github.com/lkmatsumura/foxbin2prg](https://github.com/lkmatsumura/foxbin2prg).
2. Set up the binary + `scm` layout described in [README.md — Regenerate after download](../README.md#regenerate-after-download--clone--pull).
3. Edit the modular `.prg` sources in `scm/` (not a stale generated `foxbin2prg.prg` unless you intentionally use `unify.prg`).
4. Test in VFP: import with `mirror.prg` if needed, then `DO ReCreate_FoxBin2Prg.prg`.
5. Open a pull request against this repository with a clear description of the problem and solution.

For mirrored-tree behaviour and fork-specific settings, see [docs/export_import_mirror.md](../docs/export_import_mirror.md) and [create_mirrored.prg](../create_mirrored.prg).

## Bug reports and pull requests

- Open issues and PRs on **this** repository: [github.com/lkmatsumura/foxbin2prg](https://github.com/lkmatsumura/foxbin2prg).
- Bugs that belong to upstream FoxBin2Prg itself should be reported to the [upstream project](https://github.com/fdbozzo/foxbin2prg) separately.

When reporting a bug, include VFP version, relevant CFG settings, and steps to reproduce. Attach a minimal sample project when possible.

## Coding conventions

Match the style already used in the modular sources:

- Keywords in mixed case; spaces around operators and after commas in lists.
- Tabs for indentation (width 1).
- Edit the `.prg` file that owns the class or routine you are changing.
- Preserve **CP1252** encoding in source PRGs; avoid saving files as UTF-8 unless you are deliberately working on UTF-8 export/import paths.
- Add brief comments only where the change is not obvious.

## Version and changelog

If your change affects released behaviour or text file format:

- Update version defines in [foxbin2prg.h](../foxbin2prg.h) when appropriate.
- Add an entry to [docs/ChangeLog.md](../docs/ChangeLog.md).
- Update the README footer date if you touch README.md.

## Contributing back to upstream

Improvements that are not fork-specific (bug fixes, general FoxBin2Prg features) may be welcome in Lutz Scheffler's upstream tree. Coordinate separately; this fork does not automatically sync with upstream.

---

## Upstream contributing guide (reference only)

The original FoxBin2Prg project documents Thor, VFPXDeployment, monolithic version bumps, and EXE packaging in the upstream repository. That process is **not** the default workflow for this fork. For upstream conventions, see the [fdbozzo/foxbin2prg contributing guide](https://github.com/fdbozzo/foxbin2prg/blob/master/.github/CONTRIBUTING.md).

---

Last updated: _2026/06/22_
