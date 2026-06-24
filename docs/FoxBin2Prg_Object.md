# FoxBin2Prg - Usage in object style
Documentation of FoxBin2Prg - A Binary to Text converter for MS Visual Foxpro 9

## Purpose of this document
FoxBin2Prg might be used as an EXE either from Windows or VFP, or as as prg from inside VFP in a [command line](./FoxBin2Prg_Run.md) way.  
This document deals with the integration as an VFP Object using VFP based objects.

For settings, API and other realted stuff see [Internals](./FoxBin2Prg_Internals.md).

The original document was created by [Fernando D. Bozzo](https://github.com/fdbozzo) whom I like to thank for the great project.   
Pictures are taken from the original project.  
As far as possible these are the original documents. Changes are added where functionality is changed.

----
## Table of contents
- [Usage](#usage)
   - [Instantiating](#instantiating)
   - [Execute](#execute)
- [Return values](#return-values)

----
## Usage
### Instantiating
Basically, the instantiating of FoxBinPrg is straight forward:
```
*-- Instancing directly from the EXE (fastest way, only EXE needed)
LOCAL loCnv AS c_foxbin2prg OF "FOXBIN2PRG.PRG"
SET PROCEDURE TO "<Path>\FOXBIN2PRG.EXE"
loCnv = CREATEOBJECT("c_foxbin2prg")
loCnv.execute( <params> )
```
-or this way also-
```
*-- Instancing from the PRG (you also need various files, like the 27 props*.txt)
LOCAL loCnv AS c_foxbin2prg OF "FOXBIN2PRG.PRG"
loCnv = NEWOBJECT("c_foxbin2prg", "<Path>\FOXBIN2PRG.PRG")
loCnv.execute( <params> )
```

### Execute

> **2026:** `execute` accepts four parameters. Legacy CLI string overrides (`cDontShowProgress`, `cDebug`, …) and `evaluateConfiguration()` were removed. Pass a CFG object as `toCfg`, or call `applyConfig(loCfg)` before `execute`.

```foxpro
lnErr = loCnv.execute( tc_InputFile [, tcType [, toCfg [, toEx]]] )
```

| Parameter | Default | Description |
| ----- | ----- | ----- |
| `tc_InputFile` | *(empty)* | Full path of file or directory to convert. Empty → configuration reference form (`frm_main`) |
| `tcType` | *(empty)* | Optional: `*`, `*-`, `Bin3Prg`, `Prg3Bin`, `-BIN2PRG`, `-PRG2BIN` (internal/API) |
| `toCfg` | *(none)* | Optional CFG object from `newConfig()` (or duck-typed via `configFromObject`) |
| `toEx` | *(none)* | Exception object passed by reference for error details |

**Configuration before `execute`:**

```foxpro
loCfg = loCnv.newConfig()
loCfg.l_NoTimestamps = .T.
loCfg.n_ExtraBackupLevels = 4
loCnv.applyConfig( loCfg )
lnErr = loCnv.execute( 'd:\proj\file.vcx' )
```

Or pass `loCfg` directly:

```foxpro
lnErr = loCnv.execute( 'd:\proj\file.vcx', '', loCfg )
```

Session-only properties (not on the CFG object): `cOutputFolder`, `cInputRoot`, `c_Recompile`, `n_DebugP`.

Legacy `-c` / `-C` / `-t` template generation and SCCAPI multi-parameter `execute` signatures are **no longer supported**. See [Internals — Configuration](./FoxBin2Prg_Internals.md#configuration-file) for the keyword → property mapping table.

## Return values
Return value is 0=OK, 1=Error.

----
![VFPX logo](https://vfpx.github.io/images/vfpxbanner_small.gif)   
This project is part of [VFPX](https://vfpx.github.io/).   

----
Last changed: _2023/11/26_ ![Picture](./pictures/vfpxpoweredby_alternative.gif)