# FoxBin2Prg - Usage in command line style
Documentation of FoxBin2Prg - A Binary to Text converter for MS Visual Foxpro 9

## Purpose of this document
This document shows how to run FoxBin2Prg from MS Windows Commandline, VFP's Command window or as SendTo. 

The original document was created by [Fernando D. Bozzo](https://github.com/fdbozzo) whom I like to thank for the great project.   
Pictures are taken from the original project.  
As far as possible these are the original documents. Changes are added where functionality is changed.

----
## Table of contents
- [Run FoxBin2Prg](#run-foxbin2prg)
- [Differences on excecution](#differences-on-excecution)
- [EXE](#exe)
- [PRG](#prg)
- [Parameters](#parameters)
- [Usage](#usage)
- [Return values](#return-values)
- [Examples](#Examples)
- [Explorer SendTo](#explorer-sendto)

----
## Run FoxBin2Prg

The CLI entry point is [`main.prg`](../main.prg) (prepended to `foxbin2prg.prg` by `unify.prg`). The EXE uses the same three parameters from the Windows command line.

FoxBin2Prg may be used as an EXE from Windows or VFP, or as PRG via `DO main.prg WITH …`. For object-style integration see [Object version](./FoxBin2Prg_Object.md).

For settings, architecture, and related topics see [Internals](./FoxBin2Prg_Internals.md) and [arquitetura.md](./arquitetura.md).

## Differences on excecution
### EXE
The exe contains the unified program (`foxbin2prg.prg` built via `unify.prg`) and control structures.
Alongside _FoxBin2Prg.exe_ must be _FileName_Caps.exe_ (or equivalent).
Configuration is passed programmatically (`newConfig()` / `applyConfig()`); legacy disk `foxbin2prg.cfg` is **not** read (2026).

Remember, the Exe needs to be created first (see [FoxBin2Prg.md — Download for development](./FoxBin2Prg.md#download-for-development)).

### PRG
Development uses **modular** `.prg` sources listed in `unify.txt`. Run `unify.prg` to regenerate the monolithic `foxbin2prg.prg`, or load `main.prg` / `c_foxbin2prg.prg` directly when working on the modular tree.

Required alongside the program:
- `props/*.txt` (property sort order)
- `FileName_Caps` support
- Helper modules: `cl_fb2prg_*.prg`, `cl_file_utils.prg`, `c_conversor_*.prg`, `cl_*.prg` (see [arquitetura.md](./arquitetura.md))

#### Note
All mentioned files need to be reachable from the FoxBin2Prg folder (same layout as the repository). You can't use just one PRG without the rest of the modular sources or the unified build.

## Parameters

Entry point: [`main.prg`](../main.prg) (first module in `unify.txt`; same header in generated `foxbin2prg.prg` / EXE).

```foxpro
DO main.prg WITH tc_InputFile [, tcType [, toCfg]]
```

| Parameter | Type | Default | Description |
| ----- | ----- | ----- | ----- |
| `tc_InputFile` | Character | `''` | Path to convert (file, directory, or wildcard spec), `-VERNO`, or empty |
| `tcType` | Character | `''` | Operation mode (see [Usage](#usage)); passed to `c_foxbin2prg.execute()` |
| `toCfg` | Object | *(none)* | Optional CFG from `loCnv.newConfig()` (or duck-typed via `configFromObject`) |

**Not passed on the CLI anymore (2026):** legacy parameters such as `cDebug`, `cDontShowProgress`, `cRecompile`, `cCFG_File`, `cOutputFolder`, SCCAPI `lGenText`, etc. Use a CFG object (`toCfg`) and/or session properties on the `c_foxbin2prg` instance before calling `execute` (see [FoxBin2Prg_Object.md](./FoxBin2Prg_Object.md)).

#### Special value: `-VERNO`

When `tc_InputFile` contains `-VERNO` (e.g. `DO main.prg WITH "-VERNO"`), `main.prg` returns the real version string (`DC_FB2PRG_VERSION_REAL`) and does not run a conversion.

#### Empty input

When `tc_InputFile` is empty **and** `tcType` is not `Bin3Prg` / `Prg3Bin`, `main.prg` opens the configuration reference form (`frm_main`) instead of calling `execute`.

#### Important note

When processing a directory, it is used as the base for binary recompilation. Do not process more than one directory in the same process if recompile is enabled; use separate processes per directory or project.

## Usage

`main.prg` forwards to `loCnv.execute( tc_InputFile, tcType, toCfg, @loEx )`. Direction for a **single file** is inferred from the extension when `tcType` is empty (e.g. `.vcx` → text, `.vc2` → binary).

### `tc_InputFile`

| Value | Behaviour |
| ----- | ----- |
| *(empty)* | Configuration reference form (`frm_main`), unless `tcType` is `Bin3Prg` / `Prg3Bin` |
| Full path to a **file** | Convert that file (direction from extension or `tcType`) |
| Full path to a **directory** | Batch only when `tcType` contains `-BIN2PRG` or `-PRG2BIN` |
| Wildcard in **stem** (e.g. `d:\proj\*.vcx`) | Batch matching files in that folder |
| `path\file.vcx::ClassName` | Single class/form export or import (per-file CFG options) |
| `path\file.vcx::ClassName::I` or `::E` | Same, with explicit Import / Export operation |
| `-VERNO` | Return version string (no conversion) |

### `tcType`

Validated values (invalid strings containing `\` raise an error). Case-insensitive after normalization.

| Value | When | Effect |
| ----- | ----- | ----- |
| *(empty)* | Single file | Direction from extension (bin→text or text→bin) |
| `*` | `.PJX` project | Convert all project members **including** the project file |
| `*-` | `.PJX` / `.PJ2` | Convert all members **excluding** the project header file |
| `-BIN2PRG` or `-BIN2TEXT` | Directory | Recursively convert supported binaries under `tc_InputFile` to text |
| `-PRG2BIN` or `-TEXT2BIN` | Directory | Recursively convert supported text files under `tc_InputFile` to binary |
| `Bin3Prg` | `.PJX` | Mirror export (requires `loCnv.cOutputFolder` or mirror API — see [export_import_mirror.md](./export_import_mirror.md)) |
| `Prg3Bin` | `.PJ2` | Mirror import (same session roots) |
| `-SHOWMSG` | Any (suffix) | Append to another type, e.g. `-BIN2PRG-SHOWMSG` — show completion message box |

**Examples of combined `tcType`:** `-BIN2PRG-SHOWMSG`, `PRG2BIN-SHOWMSG` (direction flags are matched as substrings after a leading `-` is prepended internally).

**Removed (legacy):** `INTERACTIVE`, SCCAPI probe letters (`d`, `D`, `K`, …), `BIN2PRG`/`PRG2BIN` as the only parameter without a file (parameter swap with `tc_InputFile`), and multi-argument `execute` overloads.

### `toCfg`

Optional configuration object. When passed, settings are merged into the session before conversion (`mergeExecuteConfig`).

```foxpro
loCnv = NewObject('c_foxbin2prg', 'c_foxbin2prg.prg')
loCfg = loCnv.newConfig()
loCfg.n_Debug = 1
loCfg.l_NoTimestamps = .T.
DO main.prg WITH 'd:\proj\file.vcx', '', loCfg
```

Session-only properties (not CLI parameters): set on `loCnv` before `DO main.prg`, e.g. `loCnv.cOutputFolder`, `loCnv.cInputRoot`, `loCnv.n_DebugP`, `loCnv.l_ProcessFiles`.

### Mirror / project tree (not via `main.prg` alone)

Full mirrored export/import uses methods on `c_foxbin2prg`:

```foxpro
loCnv.exportProjectTree( 'd:\src\app.pjx', 'd:\mirror\app', loCfg )
loCnv.importProjectTree( 'd:\mirror\app\app.pj2', 'd:\src\app', loCfg )
```

See [export_import_mirror.md](./export_import_mirror.md).

### Legacy CLI (removed)

> **2026:** Generating `foxbin2prg.cfg` via `-c` / `-C` / `-t`, SCCAPI multi-parameter `execute`, and disk `.cfg` inheritance are **no longer supported**. Use `DO main.prg` with no file for the reference form, or `newConfig()` / `applyConfig()`. See [FoxBin2Prg_Internals — Configuration file](./FoxBin2Prg_Internals.md#configuration-file).

## Return values

`main.prg` returns a numeric code (`lnResp`). On success, `0`. On failure, the VFP error number (e.g. `1098` when errors were logged). The same value is stored in `_SCREEN.ExitCode` before exit.

When called as an EXE from the command line, the process exit code reflects this return value.

## Examples

Call syntax is the same for EXE and PRG (`DO main.prg WITH …` or `DO foxbin2prg.prg WITH …` after unify).

| Command | Description |
| ----- | ----- |
| `DO main.prg` | Configuration reference form |
| `DO main.prg WITH "-VERNO"` | Return version string (e.g. `4.00.00`) |
| `DO main.prg WITH "d:\proj\file.scx"` | Binary → text (`.sc2`) |
| `DO main.prg WITH "d:\proj\file.sc2"` | Text → binary (`.scx`) |
| `DO main.prg WITH "d:\proj\proj.pjx", "*"` | Full project export (all members + PJX → PJ2) |
| `DO main.prg WITH "d:\proj\proj.pj2", "*"` | Full project import (PJ2 → PJX + binaries) |
| `DO main.prg WITH "d:\proj\proj.pjx", "*-"` | Project members only (exclude PJX/PJ2 header) |
| `DO main.prg WITH "d:\proj\*.vcx"` | All matching VCX in folder (extension sets direction) |
| `DO main.prg WITH "d:\proj\forms", "-BIN2PRG"` | Recursive bin→text for supported files under folder |
| `DO main.prg WITH "d:\proj\text", "-PRG2BIN"` | Recursive text→bin under folder |
| `DO main.prg WITH "d:\proj\file.vcx::cus_client"` | Single class to text (UseClassPerFile) |
| `DO main.prg WITH "d:\proj\file.vcx", "", loCfg` | Single file with programmatic CFG object |

EXE equivalents (Windows command line):

| Command | Description |
| ----- | ----- |
| `FOXBIN2PRG.EXE "d:\proj\file.scx"` | Binary → text |
| `FOXBIN2PRG.EXE "d:\proj\proj.pjx" "*"` | Full project export |
| `FOXBIN2PRG.EXE "d:\proj\forms" "-BIN2PRG"` | Directory batch export |

## Explorer SendTo

To use FoxBin2Prg from File Explorer, create shortcuts to `foxbin2prg.exe` in the SendTo folder (`shell:sendto` in the address bar). Windows passes the selected file as the **first** argument (`%1`).

```
Name------------------------  Target (Properties)
FoxBin2Prg.lnk                "<path>\foxbin2prg.exe" "%1"
FoxBin2Prg - Bin2Text.lnk     "<path>\foxbin2prg.exe" "%1" "-BIN2PRG-SHOWMSG"
FoxBin2Prg - Text2Bin.lnk     "<path>\foxbin2prg.exe" "%1" "-PRG2BIN-SHOWMSG"
```

For a single file, direction is usually inferred from the extension; the `-BIN2PRG` / `-PRG2BIN` suffix forces batch direction when needed (e.g. ambiguous cases). `-SHOWMSG` displays a completion message box.

----
![VFPX logo](https://vfpx.github.io/images/vfpxbanner_small.gif)   
This project is part of [VFPX](https://vfpx.github.io/).   

----
Last changed: _2026/06/29_ ![Picture](./pictures/vfpxpoweredby_alternative.gif)
