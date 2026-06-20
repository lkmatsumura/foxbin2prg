*---------------------------------------------------------------------------------------------------
* Module.........: create_mirrored.prg
* Purpose........: FoxBin2Prg usage example: export a complete project (.PJX/.PJ2) to a mirrored
*                  folder tree and import it back, configuring the converter programmatically (no
*                  FoxBin2Prg.cfg file on disk required).
*
* Covers.........: 1) Reusable CFG object configuration (newConfig / configFromObject / applyConfig)
*                   2) Project export with replicated folder structure (exportProjectTree)
*                   3) Project import from mirrored tree (importProjectTree)
*                   4) Equivalent low-level usage (cOutputFolder + cInputRoot + execute)
*
* Mirror CFG.....: See docs/EXPORT_IMPORT_MIRROR.md (ExcludedSubdirs, CopyNonConvertible,
*                   CopyExcludedPjxFiles).
*
* CFG note.......: Configuration values live in CFG objects (Empty with createCfgShell schema).
*                   Assign properties directly on loCfg (e.g. loCfg.l_NoTimestamps = .T.).
*                   The c_foxbin2prg instance does not expose those properties on the class; at
*                   runtime use getCfgValue('prop') and setCfgValue('prop', value).
*
* Usage:
*     DO create_mirrored.prg WITH "d:\src\app\app.pjx", "d:\export\app"
*     DO create_mirrored.prg WITH "d:\src\app\app.pjx", "d:\export\app", "d:\src\app"
*
* Parameters:
*     tcProjectFile  - Source .PJX to export (default: d:\src\app\app.pjx)
*     tcOutputRoot   - Mirrored text tree destination (default: d:\export\app)
*     tcImportDest   - (Optional) Binary destination for importProjectTree round-trip demo
*
* If no parameters are passed, the sample values below are used (adjust them to your environment).
*---------------------------------------------------------------------------------------------------
Lparameters tcProjectFile, tcOutputRoot, tcImportDest

#Include foxbin2prg.h

Local lcProjectFile, lcOutputRoot, lcImportDest, lcMirrorPj2, lnResp
Local loFb2p   As c_foxbin2prg Of 'c_foxbin2prg.prg' ;
    , loCfg

*-- Default sample paths (replace with your project paths)
lcProjectFile = Evl( tcProjectFile, 'd:\src\app\app.pjx' )
lcOutputRoot  = Evl( tcOutputRoot , 'd:\export\app' )
lcImportDest  = Evl( tcImportDest , Justpath( Fullpath( lcProjectFile ) ) )
lcMirrorPj2   = Addbs( lcOutputRoot ) + Justfname( Forceext( lcProjectFile, 'PJ2' ) )


*===================================================================================================
* EXAMPLE 1 (recommended): exportProjectTree with object-based configuration
*===================================================================================================
* exportProjectTree( tcProjectFile, tcOutputRoot [, toCfg] [, tcInputRoot] )
*   - Exports the .PJX/.PJ2 and ALL its components to tcOutputRoot.
*   - Replicates the subfolder structure each component has relative to the project folder
*     (forms\, classes\, data\, ...).
*   - toCfg is optional; accepts a CFG object (newConfig / isCfg) or any object with matching
*     property names (configFromObject / duck-typing).
*---------------------------------------------------------------------------------------------------

loFb2p = Newobject( 'c_foxbin2prg', 'c_foxbin2prg.prg' )

*-- 1) CFG object cloned from factory defaults (createCfgShell / o_FactoryCFG).
*--    Override only the properties needed for this export.
loCfg = loFb2p.newConfig()



loCfg.l_Recompile        = .F.        && default .T.; do not recompile when regenerating binaries
loCfg.l_NoTimestamps     = .T.        && strip timestamps (better for version control / merge)
loCfg.n_UseClassPerFile  = 0          && 0 = one VC2 per VCX, 1 = one VC2 per class
loCfg.n_ShowProgressbar  = 0          && default 1 Allway show; 0 = no progress bar (batch / unattended mode)
loCfg.l_ShowErrors       = .F.        && default .T.; do not show error MESSAGEBOXes

*-- Mirrored tree behavior:
loCfg.l_CopyNonConvertible = .T.      && copy non-convertible files into the mirrored tree
*loCfg.l_CopyExcludedPjxFiles = .T.  && default .F.; include PJX members marked Exclude in the mirror
loCfg.l_CopyLowercaseNames = .T.      && when copying, use lowercase file names
loCfg.c_ExcludedSubdirs    = 'tmp;backup;forms\old'  && subdirs to skip (not copied or converted)

*-- (Optional) custom extensions without editing any .cfg file on disk:
*loCfg.c_VC2 = 'VCA'
*loCfg.c_SC2 = 'SCA'
*loCfg.c_PJ2 = 'PJA'

*-- 2) Export the full project to the mirrored tree, passing configuration as an object.
lnResp = loFb2p.exportProjectTree( lcProjectFile, lcOutputRoot, loCfg )

? 'Example 1 - exportProjectTree, return code: ', lnResp

*===================================================================================================
* EXAMPLE 1c (recommended): importProjectTree - round-trip from mirrored PJ2 back to binaries
*===================================================================================================
* importProjectTree( tcMirrorProjectFile, tcOutputRoot [, toCfg] [, tcInputRoot] )
*   - Imports the .PJ2 and ALL its components from the mirrored text tree.
*   - Regenerates binaries under tcOutputRoot, replicating the subfolder structure
*     (forms\, classes\, data\, ...).
*   - Reuses the same loCfg object from export (l_Recompile, l_CopyNonConvertible, etc.).
*   - Typical workflow: export -> edit text in SCM -> import back into the VFP project folder.
*---------------------------------------------------------------------------------------------------

lnResp = loFb2p.importProjectTree( lcMirrorPj2, lcImportDest, loCfg )

? 'Example 1c - importProjectTree, return code: ', lnResp

*===================================================================================================
* EXAMPLE 1b (recommended): exportProjectTree with object-based configuration using foxbin2prg.exe
*===================================================================================================
LOCAL loFb2p1b, loCfg1b

Do GetObj_F2b IN Foxbin2prg.exe WITH loF2b1b

loCfg1b = loFb2p1b.newConfig()

loCfg1b.l_Recompile        = .F.        && default .T.; do not recompile when regenerating binaries
loCfg1b.l_NoTimestamps     = .T.        && strip timestamps (better for version control / merge)
loCfg1b.n_UseClassPerFile  = 0          && 0 = one VC2 per VCX, 1 = one VC2 per class
loCfg1b.n_ShowProgressbar  = 1          && default 1 Allway show; 0 = no progress bar (batch / unattended mode)

*-- Mirrored tree behavior:
loCfg.l_CopyNonConvertible = .T.      && copy non-convertible files into the mirrored tree
loCfg.l_CopyLowercaseNames = .T.      && when copying, use lowercase file names
loCfg.c_ExcludedSubdirs    = 'deps'   && subdirs to skip (not copied or converted)

lnResp = loFb2p1b.exportProjectTree( lcProjectFile, lcOutputRoot, loCfg1b )



*===================================================================================================
* EXAMPLE 2: reuse the SAME configuration object on another converter instance
*===================================================================================================
* The configuration object is portable: once built, it can be passed to multiple instances or calls.
*---------------------------------------------------------------------------------------------------

Local loFb2p2 As c_foxbin2prg Of 'c_foxbin2prg.prg'

loFb2p2 = Newobject( 'c_foxbin2prg', 'c_foxbin2prg.prg' )

*-- Reuse loCfg as-is and export another project to a different destination folder.
*lnResp = loFb2p2.exportProjectTree( 'd:\src\lib\lib.pjx', 'd:\export\lib', loCfg )


*===================================================================================================
* EXAMPLE 3: configure from any object (duck-typing) with configFromObject
*===================================================================================================
* No need to call newConfig(): any object with matching property names is enough;
* configFromObject copies matching properties onto a new CFG object
* (factory defaults + values from the source object).
*---------------------------------------------------------------------------------------------------

Local loSettings, loCfg3

loSettings = Createobject( 'Empty' )
AddProperty( loSettings, 'l_NoTimestamps'      , .T. )
AddProperty( loSettings, 'n_ShowProgressbar'   , 0  )
AddProperty( loSettings, 'l_CopyNonConvertible', .T. )
AddProperty( loSettings, 'l_CopyLowercaseNames', .T. )
AddProperty( loSettings, 'c_ExcludedSubdirs'   , 'tmp;backup' )

loCfg3 = loFb2p.configFromObject( loSettings )    && returns an equivalent CFG object
*lnResp = loFb2p.exportProjectTree( lcProjectFile, lcOutputRoot, loCfg3 )


*===================================================================================================
* EXAMPLE 4: low-level usage (manual equivalent to exportProjectTree)
*===================================================================================================
* Useful when you need finer control or to plug into an existing workflow.
*   - cInputRoot    = source root (project folder). If empty, it is inferred automatically.
*   - cOutputFolder = destination root where the tree is replicated.
*   - execute(...) with tcType = '*' processes the entire project (including the PJX/PJ2 itself).
*---------------------------------------------------------------------------------------------------

Local loFb2p4 As c_foxbin2prg Of 'c_foxbin2prg.prg' ;
    , loEx     As Exception
loFb2p4 = Newobject( 'c_foxbin2prg', 'c_foxbin2prg.prg' )

*-- Apply the CFG object to the instance (evaluateConfiguration; active for execute).
loFb2p4.applyConfig( loCfg )

*-- Session paths (not CFG): mirrored tree source/destination roots.
loFb2p4.cInputRoot    = Addbs( Justpath( Fullpath( lcProjectFile ) ) )
loFb2p4.cOutputFolder = lcOutputRoot

*-- (Optional) tweak a single option on the already-configured instance:
*loFb2p4.setCfgValue( 'n_ShowProgressbar', 0 )
*-- Run full project export (Binary -> Text).
*lnResp = loFb2p4.execute( lcProjectFile, '*', .F., .F., '', '', '', .Null., @loEx )


*===================================================================================================
* EXAMPLE 5: low-level usage (manual equivalent to importProjectTree)
*===================================================================================================
* Useful when you need finer control or to plug into an existing workflow.
*   - cInputRoot    = mirrored text tree root (source). If empty, it is inferred from the PJ2 path.
*   - cOutputFolder = destination root where binaries are regenerated.
*   - execute(...) with tcType = '*' processes the entire project (including the PJ2/PJX itself).
*---------------------------------------------------------------------------------------------------

Local loFb2p5 As c_foxbin2prg Of 'c_foxbin2prg.prg' ;
    , loEx5    As Exception
loFb2p5 = Newobject( 'c_foxbin2prg', 'c_foxbin2prg.prg' )

*-- Apply the CFG object to the instance (evaluateConfiguration; active for execute).
loFb2p5.applyConfig( loCfg )

*-- Session paths (not CFG): mirrored source root and binary destination.
loFb2p5.cInputRoot    = Addbs( Justpath( Fullpath( lcMirrorPj2 ) ) )
loFb2p5.cOutputFolder = lcImportDest

*-- (Optional) tweak a single option on the already-configured instance:
*loFb2p5.setCfgValue( 'l_Recompile', .T. )
*-- Run full project import (Text -> Binary).
*lnResp = loFb2p5.execute( lcMirrorPj2, '*', .F., .F., '', '', '', .Null., @loEx5 )


*===================================================================================================
* EQUIVALENT VIA .cfg FILE (FoxBin2Prg.cfg)
*===================================================================================================
* To configure via file instead of objects, add these lines to your .cfg:
*
*     CopyNonConvertible:1
*     CopyExcludedPjxFiles:0
*     CopyLowercaseNames:1
*     ExcludedSubdirs: tmp;backup;forms\old
*
* (Other options work too: NoTimestamps:1, UseClassPerFile:0, extension: vc2=VCA, etc.)
*---------------------------------------------------------------------------------------------------


Return lnResp
