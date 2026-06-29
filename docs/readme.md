# FoxBin2Prg

Project to generate text representations of VFP binary sources for source control.

## Documentation (GitHub)

This folder contains the documentation for the modular FoxBin2Prg sources. Spanish documents were removed; these docs track the current development state.

| Document | Description |
|----------|-------------|
| [FoxBin2Prg.md](./FoxBin2Prg.md) | Introduction and overview |
| [arquitetura.md](./arquitetura.md) | **Architecture**: modular layout, helper classes, conversion flows |
| [c_foxbin2prg_ClassAnalysis.md](./c_foxbin2prg_ClassAnalysis.md) | Orchestrator deep-dive (Portuguese) |
| [export_import_mirror.md](./export_import_mirror.md) | Mirrored project export/import |
| [FoxBin2Prg_Internals.md](./FoxBin2Prg_Internals.md) | Configuration and internals |
| [FoxBin2Prg_Object.md](./FoxBin2Prg_Object.md) | Object-style API |
| [FoxBin2Prg_Run.md](./FoxBin2Prg_Run.md) | CLI / EXE usage |
| [FoxBin2Prg_SCM.md](./FoxBin2Prg_SCM.md) | SCM integration |
| [ChangeLog.md](./ChangeLog.md) | Change history |

**Build:** edit modular `.prg` files listed in `unify.txt`, then run `unify.prg` to regenerate `foxbin2prg.prg`. Do not edit the generated monolith directly.

----
Last changed: _2026/06/29_ ![Picture](./pictures/vfpxpoweredby_alternative.gif)
