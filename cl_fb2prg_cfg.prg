#INCLUDE foxbin2prg.h

*---------------------------------------------------------------------------------------------------
* Configuration manager for FoxBin2Prg (used via c_foxbin2prg.o_Cfg).
*
* CFG stores:
*   o_Host    Back-reference to c_foxbin2prg (session state: n_DebugP, etc.).
*   o_CFG     Single session CFG object (factory defaults or copy from applyConfig).
*
* Configuration is object-only: use newConfig(), assign properties, pass to execute / exportProjectTree.
* No foxbin2prg.cfg on disk and no per-directory inheritance.
* Factory defaults come from createCfgShell() on demand (newConfig / reset).
*---------------------------------------------------------------------------------------------------

DEFINE CLASS cl_fb2prg_cfg AS Custom
   o_Host = .NULL.

   o_CFG                           = .NULL.

   PROCEDURE INIT
      LPARAMETERS toHost
      This.o_Host = toHost
   ENDPROC


   PROCEDURE setup
      *---------------------------------------------------------------------------------------------------
      * Initialize session CFG (called from host INIT).
      *---------------------------------------------------------------------------------------------------
      This.o_CFG = This.createCfgShell()
   ENDPROC


   PROCEDURE DESTROY
      This.o_CFG     = .NULL.
      This.o_Host    = .NULL.
   ENDPROC


   PROCEDURE clearConfigurationCache
      *---------------------------------------------------------------------------------------------------
      * Resets session CFG to factory defaults.
      *---------------------------------------------------------------------------------------------------
      This.o_CFG = This.createCfgShell()
   ENDPROC


   PROCEDURE get_DirSettings
      *---------------------------------------------------------------------------------------------------
      * Returns a factory-default CFG clone (no disk lookup).
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcDir, tcDebug, tcCFG_File

      IF INLIST( TRANSFORM(tcDebug), '0', '1', '2' )
         IF ISNULL(This.o_Host.n_DebugP)
            This.o_Host.n_DebugP = INT(VAL(tcDebug))
         ENDIF
      ENDIF

      RETURN This.newConfig()
   ENDPROC


   PROCEDURE createCfgShell
      *---------------------------------------------------------------------------------------------------
      * CFG schema and factory defaults (canonical source for o_CFG / newConfig).
      *---------------------------------------------------------------------------------------------------
      LOCAL loCfg

      loCfg = CREATEOBJECT('Empty')

      AddProperty(loCfg, '_CFG_Type', CFG_TYPE_MARKER)

      *-- Path / identity
      AddProperty(loCfg, 'c_Foxbin2prg_FullPath', '')
      AddProperty(loCfg, 'c_Foxbin2prg_ConfigFile', '')
      AddProperty(loCfg, 'c_CurDir', '')

      AddProperty(loCfg, 'c_Language_In', '(auto)')
      AddProperty(loCfg, 'n_Debug', 0)
      AddProperty(loCfg, 'n_BodyDevInfo', 0)
      AddProperty(loCfg, 'l_ShowErrors', .T.)
      AddProperty(loCfg, 'n_ShowProgressbar', 1)
      AddProperty(loCfg, 'n_OptimizeByFilestamp', 0)
      AddProperty(loCfg, 'n_ExcludeDBFAutoincNextval', 0)

      AddProperty(loCfg, 'l_Recompile', .T.)
      AddProperty(loCfg, 'l_NoTimestamps', .T.)
      AddProperty(loCfg, 'l_ClearUniqueID', .T.)
      AddProperty(loCfg, 'l_ClearDBFLastUpdate', .T.)

      AddProperty(loCfg, 'l_RemoveNullCharsFromCode', .T.)
      AddProperty(loCfg, 'l_RemoveZOrderSetFromProps', .F.)
      AddProperty(loCfg, 'n_UseClassPerFile', 0)

      AddProperty(loCfg, 'l_RedirectClassPerFileToMain', .F.)
      AddProperty(loCfg, 'n_RedirectClassType', 0)
      AddProperty(loCfg, 'l_ClassPerFileCheck', .F.)
      AddProperty(loCfg, 'l_UseClassPerDir', .F.)
      AddProperty(loCfg, 'l_UseFormSettings', .F.)
      AddProperty(loCfg, 'n_UseFormPerFile', 0)
      AddProperty(loCfg, 'l_RedirectFormPerFileToMain', .F.)
      AddProperty(loCfg, 'n_RedirectFormType', 0)
      AddProperty(loCfg, 'l_FormPerFileCheck', .F.)
      AddProperty(loCfg, 'l_UseFormPerDir', .F.)
      AddProperty(loCfg, 'n_CheckFileInPath', 0)
      AddProperty(loCfg, 'l_OldFilesPerDBC', .T.)
      AddProperty(loCfg, 'n_UseFilesPerDBC', 0)
      AddProperty(loCfg, 'l_RedirectFilePerDBCToMain', .F.)
      AddProperty(loCfg, 'l_ItemPerDBCCheck', .F.)
      AddProperty(loCfg, 'l_DBF_BinChar_Base64', .T.)
      AddProperty(loCfg, 'l_DBF_IncludeDeleted', .F.)
      AddProperty(loCfg, 'l_ExportUTF8', .F.)
      AddProperty(loCfg, 'n_ExtraBackupLevels', 1)

      AddProperty(loCfg, 'c_VC2', 'VC2')
      AddProperty(loCfg, 'c_SC2', 'SC2')
      AddProperty(loCfg, 'c_PJ2', 'PJ2')
      AddProperty(loCfg, 'c_FR2', 'FR2')
      AddProperty(loCfg, 'c_FR2D', 'FR2D')
      AddProperty(loCfg, 'c_LB2', 'LB2')
      AddProperty(loCfg, 'c_LB2D', 'LB2D')
      AddProperty(loCfg, 'c_DB2', 'DB2')
      AddProperty(loCfg, 'c_DC2', 'DC2')
      AddProperty(loCfg, 'c_MN2', 'MN2')
      AddProperty(loCfg, 'c_FK2', 'FK2')
      AddProperty(loCfg, 'c_ME2', 'ME2')

      AddProperty(loCfg, 'n_PJX_Conversion_Support', 2)
      AddProperty(loCfg, 'n_VCX_Conversion_Support', 2)
      AddProperty(loCfg, 'n_SCX_Conversion_Support', 2)
      AddProperty(loCfg, 'n_FRX_Conversion_Support', 2)
      AddProperty(loCfg, 'n_LBX_Conversion_Support', 2)
      AddProperty(loCfg, 'n_MNX_Conversion_Support', 2)
      AddProperty(loCfg, 'n_DBC_Conversion_Support', 2)
      AddProperty(loCfg, 'n_DBF_Conversion_Support', 1)
      AddProperty(loCfg, 'n_FKY_Conversion_Support', 1)
      AddProperty(loCfg, 'n_MEM_Conversion_Support', 1)

      AddProperty(loCfg, 'c_DBF_Conversion_Included', '')
      AddProperty(loCfg, 'c_DBF_Conversion_Excluded', '')
      AddProperty(loCfg, 'c_DBF_Conversion_Order', '')
      AddProperty(loCfg, 'c_DBF_Conversion_Condition', '')
      AddProperty(loCfg, 'c_DBF_IndexList', '')
      AddProperty(loCfg, 'l_CopyNonConvertible', .F.)
      AddProperty(loCfg, 'l_CopyExcludedPjxFiles', .F.)
      AddProperty(loCfg, 'l_CopyLowercaseNames', .F.)
      AddProperty(loCfg, 'c_ExcludedSubdirs', '')
      AddProperty(loCfg, 'c_BackgroundImage', '')
      AddProperty(loCfg, 'n_PRG_Compat_Level', 0)
      AddProperty(loCfg, 'n_HomeDir', 0)
      AddProperty(loCfg, 'l_AllowFolder', .T.)

      RETURN loCfg
   ENDPROC


   PROCEDURE appendCfgCatalogRow
      *---------------------------------------------------------------------------------------------------
      * Appends one row to the configuration catalog array (VFP: one statement per line).
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS taCat, tcSec, tcProp, tcType, tcValues
      External Array taCat
      Local lnLn
      lnLn = Alen(taCat,1)
      DIMENSION taCat(lnLn + 1, 5)

      taCat(lnLn, 1) = tcSec
      taCat(lnLn, 2) = tcProp
      taCat(lnLn, 3) = tcType
      taCat(lnLn, 4) = tcValues

      RETURN lnLn
   ENDPROC


   PROCEDURE getConfigPropertyCatalog
      *---------------------------------------------------------------------------------------------------
      * Metadata for frm_main configuration reference (section, property, type, values).
      * RETURN: array of rows (1=section, 2=prop, 3=type, 4=values)
      *---------------------------------------------------------------------------------------------------
      LOCAL laCat(1, 5), ln

      ln = 0
      DIMENSION laCat(50, 5)

      *-- 1 General
      This.appendCfgCatalogRow(@laCat, '1', 'n_Debug',                 'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '1', 'l_ShowErrors',            'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '1', 'n_ShowProgressbar',       'N', '0|1')
      This.appendCfgCatalogRow(@laCat, '1', 'l_Recompile',             'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '1', 'n_ExtraBackupLevels',     'N', '0+')
      This.appendCfgCatalogRow(@laCat, '1', 'n_OptimizeByFilestamp',   'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '1', 'l_ExportUTF8',            'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '1', 'n_HomeDir',               'N', '0|1')

      *-- 2 Timestamps / metadata
      This.appendCfgCatalogRow(@laCat, '2', 'l_NoTimestamps',          'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '2', 'l_ClearUniqueID',         'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '2', 'l_ClearDBFLastUpdate',    'L', '.T.|.F.')

      *-- 3 Classes / forms
      This.appendCfgCatalogRow(@laCat, '3', 'n_UseClassPerFile',             'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '3', 'l_UseClassPerDir',              'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '3', 'l_RedirectClassPerFileToMain',  'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '3', 'n_RedirectClassType',           'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '3', 'l_ClassPerFileCheck',           'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '3', 'l_UseFormSettings',             'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '3', 'n_UseFormPerFile',              'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '3', 'l_UseFormPerDir',               'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '3', 'l_RedirectFormPerFileToMain',   'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '3', 'n_RedirectFormType',            'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '3', 'l_FormPerFileCheck',            'L', '.T.|.F.')

      *-- 4 Mirror
      This.appendCfgCatalogRow(@laCat, '4', 'l_CopyNonConvertible',    'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '4', 'l_CopyExcludedPjxFiles',  'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '4', 'l_CopyLowercaseNames',    'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '4', 'c_ExcludedSubdirs',       'C', 'list;sep')

      *-- 5 DBF / DBC / conversion support
      This.appendCfgCatalogRow(@laCat, '5', 'n_DBF_Conversion_Support',  'N', '0|1|2|4|8')
      This.appendCfgCatalogRow(@laCat, '5', 'n_DBC_Conversion_Support',  'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '5', 'l_DBF_BinChar_Base64',      'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '5', 'l_DBF_IncludeDeleted',      'L', '.T.|.F.')
      This.appendCfgCatalogRow(@laCat, '5', 'n_UseFilesPerDBC',          'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '5', 'c_DBF_Conversion_Included', 'C', 'masks')
      This.appendCfgCatalogRow(@laCat, '5', 'c_DBF_Conversion_Excluded', 'C', 'masks')
      This.appendCfgCatalogRow(@laCat, '5', 'c_DBF_Conversion_Order',     'C', 'index expr')
      This.appendCfgCatalogRow(@laCat, '5', 'c_DBF_Conversion_Condition', 'C', 'logical expr')
      This.appendCfgCatalogRow(@laCat, '5', 'c_DBF_IndexList',            'C', 'idx,cdx list')
      This.appendCfgCatalogRow(@laCat, '5', 'n_VCX_Conversion_Support',  'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '5', 'n_SCX_Conversion_Support',  'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '5', 'n_PJX_Conversion_Support',  'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '5', 'n_FRX_Conversion_Support',  'N', '0|1|2')
      This.appendCfgCatalogRow(@laCat, '5', 'n_MNX_Conversion_Support',  'N', '0|1|2')

      *-- 6 Extensions
      This.appendCfgCatalogRow(@laCat, '6', 'c_VC2', 'C', 'ext')
      This.appendCfgCatalogRow(@laCat, '6', 'c_SC2', 'C', 'ext')
      This.appendCfgCatalogRow(@laCat, '6', 'c_PJ2', 'C', 'ext')
      This.appendCfgCatalogRow(@laCat, '6', 'c_FR2', 'C', 'ext')
      This.appendCfgCatalogRow(@laCat, '6', 'c_LB2', 'C', 'ext')
      This.appendCfgCatalogRow(@laCat, '6', 'c_DB2', 'C', 'ext')
      This.appendCfgCatalogRow(@laCat, '6', 'c_DC2', 'C', 'ext')
      This.appendCfgCatalogRow(@laCat, '6', 'c_MN2', 'C', 'ext')

      DIMENSION laCat(ln, 5)
      RETURN laCat
   ENDPROC


   PROCEDURE getCfgPropEffect
      LPARAMETERS tcProp
      DO CASE
      CASE tcProp == 'n_Debug'
         RETURN 'Write per-file .LOG when > 0; 2 keeps ObjRev in PJ2 body.'
      CASE tcProp == 'l_ShowErrors'
         RETURN 'Show MESSAGEBOX on conversion errors.'
      CASE tcProp == 'n_ShowProgressbar'
         RETURN '0=hide progress bar, 1=always show.'
      CASE tcProp == 'l_Recompile'
         RETURN 'Recompile regenerated binaries after Prg2Bin.'
      CASE tcProp == 'n_ExtraBackupLevels'
         RETURN 'Number of .BAK levels before overwrite (0=none).'
      CASE tcProp == 'n_OptimizeByFilestamp'
         RETURN 'Skip reconversion when timestamps unchanged (risky with branches).'
      CASE tcProp == 'l_ExportUTF8'
         RETURN 'UTF-8 encode copied text files in mirrored tree.'
      CASE tcProp == 'n_HomeDir'
         RETURN '0=omit HomeDir from PJ2, 1=include.'
      CASE tcProp == 'l_NoTimestamps'
         RETURN 'Clear binary timestamps in output (better for SCM diff).'
      CASE tcProp == 'l_ClearUniqueID'
         RETURN 'Clear UniqueID in text output.'
      CASE tcProp == 'l_ClearDBFLastUpdate'
         RETURN 'Clear DBF LastUpdate in DB2 export.'
      CASE tcProp == 'n_UseClassPerFile'
         RETURN '0=one VC2 per VCX; 1=per class; 2=per baseclass.class.'
      CASE tcProp == 'l_UseClassPerDir'
         RETURN 'Place per-class VC2 under library.vc2\ subfolder.'
      CASE tcProp == 'l_RedirectClassPerFileToMain'
         RETURN 'Open library.vc2 when selecting library.class.vc2.'
      CASE tcProp == 'n_RedirectClassType'
         RETURN 'Import single class into VCX (2) vs full library.'
      CASE tcProp == 'l_ClassPerFileCheck'
         RETURN 'Validate class VC2 membership in project.'
      CASE tcProp == 'l_UseFormSettings'
         RETURN 'Enable per-form SC2 options (like UseClassPerFile for forms).'
      CASE tcProp == 'n_UseFormPerFile'
         RETURN '0=one SC2 per SCX; 1=per object; 2=per baseclass.object.'
      CASE tcProp == 'l_UseFormPerDir'
         RETURN 'Per-form SC2 in form.sc2\ subfolder.'
      CASE tcProp == 'l_RedirectFormPerFileToMain'
         RETURN 'Redirect form.object.sc2 to form.sc2.'
      CASE tcProp == 'n_RedirectFormType'
         RETURN 'Import single form object into SCX when 2.'
      CASE tcProp == 'l_FormPerFileCheck'
         RETURN 'Validate per-form SC2 membership.'
      CASE tcProp == 'l_CopyNonConvertible'
         RETURN 'Copy non-convertible PJX members into mirror tree.'
      CASE tcProp == 'l_CopyExcludedPjxFiles'
         RETURN 'Include PJX members marked Exclude in mirror.'
      CASE tcProp == 'l_CopyLowercaseNames'
         RETURN 'Lowercase names when copying files to mirror.'
      CASE tcProp == 'c_ExcludedSubdirs'
         RETURN 'Semicolon-separated subdirs to skip in mirror (e.g. deps).'
      CASE tcProp == 'n_DBF_Conversion_Support'
         RETURN '0=none; 1=table header only; 2=structure+indexes; 4=export records to DB2; 8=round-trip data (DB2<->DBF).'
      CASE tcProp == 'n_DBC_Conversion_Support'
         RETURN '0=none, 1=diff text, 2=text+bin merge.'
      CASE tcProp == 'l_DBF_BinChar_Base64'
         RETURN 'Base64-encode binary character fields in DB2 export; decoded on DB2->DBF import (support 4/8).'
      CASE tcProp == 'l_DBF_IncludeDeleted'
         RETURN 'Include deleted DBF records when exporting data to DB2 (support 4/8).'
      CASE tcProp == 'n_UseFilesPerDBC'
         RETURN 'Split DBC into per-item DC2 files.'
      CASE tcProp == 'c_DBF_Conversion_Included'
         RETURN 'Wildcard masks of DBF names allowed for data export; empty or * = all (support 4/8).'
      CASE tcProp == 'c_DBF_Conversion_Excluded'
         RETURN 'Wildcard masks of DBF names skipped for data export (support 4/8; Included wins).'
      CASE tcProp == 'c_DBF_Conversion_Order'
         RETURN 'VFP INDEX ON expression before exporting records (support 4/8; session loCfg, all DBFs).'
      CASE tcProp == 'c_DBF_Conversion_Condition'
         RETURN 'VFP logical expression used as SCAN FOR when exporting records (support 4/8; session loCfg).'
      CASE tcProp == 'c_DBF_IndexList'
         RETURN 'Comma-separated extra .IDX/.CDX files merged into DB2 export (non-structural; session loCfg).'
      CASE tcProp == 'c_VC2'
         RETURN 'Text extension for VCX (default VC2).'
      CASE tcProp == 'c_SC2'
         RETURN 'Text extension for SCX (default SC2).'
      CASE tcProp == 'c_PJ2'
         RETURN 'Text extension for PJX (default PJ2).'
      CASE tcProp == 'c_FR2'
         RETURN 'Text extension for FRX.'
      CASE tcProp == 'c_LB2'
         RETURN 'Text extension for LBX.'
      CASE tcProp == 'c_DB2'
         RETURN 'Text extension for DBF.'
      CASE tcProp == 'c_DC2'
         RETURN 'Text extension for DBC.'
      CASE tcProp == 'c_MN2'
         RETURN 'Text extension for MNX.'
      CASE tcProp == 'n_VCX_Conversion_Support'
         RETURN 'VCX support: 0=none, 1=diff, 2=merge.'
      CASE tcProp == 'n_SCX_Conversion_Support'
         RETURN 'SCX support: 0=none, 1=diff, 2=merge.'
      CASE tcProp == 'n_PJX_Conversion_Support'
         RETURN 'PJX support: 0=none, 1=diff, 2=merge.'
      CASE tcProp == 'n_FRX_Conversion_Support'
         RETURN 'FRX support: 0=none, 1=diff, 2=merge.'
      CASE tcProp == 'n_MNX_Conversion_Support'
         RETURN 'MNX support: 0=none, 1=diff, 2=merge.'
      OTHERWISE
         RETURN ''
      ENDCASE
   ENDPROC


   PROCEDURE formatConfigReferenceText
      *---------------------------------------------------------------------------------------------------
      * Builds help text for frm_main from catalog + factory defaults.
      *---------------------------------------------------------------------------------------------------
      LOCAL laCat(1,5), loDefaults, loLang, lcText, ln, lcProp, lcVal, lcEffect, lcSection, lcSecTitle

      laCat      = This.getConfigPropertyCatalog()
      loDefaults = This.newConfig()
      loLang     = _SCREEN.o_FoxBin2Prg_Lang
      lcText     = ''

      IF VARTYPE(loLang) = 'O' AND !EMPTY(loLang.C_CFG_REF_INTRO_LOC)
         lcText = loLang.C_CFG_REF_INTRO_LOC + CR_LF + REPLICATE('-', 80) + CR_LF + CR_LF
         lcText = lcText + loLang.C_CFG_REF_USAGE_LOC + CR_LF + CR_LF
      ELSE
         lcText = 'FoxBin2Prg configuration reference (programmatic newConfig object).' + CR_LF
         lcText = lcText + REPLICATE('-', 80) + CR_LF + CR_LF
         lcText = lcText + 'Usage: loCfg = loF2b.newConfig() then assign properties; pass loCfg to exportProjectTree / importProjectTree / execute.' + CR_LF + CR_LF
      ENDIF

      lcSection = ''
      FOR ln = 1 TO ALEN(laCat, 1)
         IF laCat(ln, 1) <> lcSection
            lcSection = laCat(ln, 1)
            DO CASE
            CASE lcSection = '1'
               lcSecTitle = IIF(VARTYPE(loLang)='O', loLang.C_CFG_REF_SEC_GENERAL_LOC, 'General')
            CASE lcSection = '2'
               lcSecTitle = IIF(VARTYPE(loLang)='O', loLang.C_CFG_REF_SEC_TIMESTAMPS_LOC, 'Timestamps')
            CASE lcSection = '3'
               lcSecTitle = IIF(VARTYPE(loLang)='O', loLang.C_CFG_REF_SEC_CLASSFORM_LOC, 'Classes / Forms')
            CASE lcSection = '4'
               lcSecTitle = IIF(VARTYPE(loLang)='O', loLang.C_CFG_REF_SEC_MIRROR_LOC, 'Mirrored tree')
            CASE lcSection = '5'
               lcSecTitle = IIF(VARTYPE(loLang)='O', loLang.C_CFG_REF_SEC_DBF_LOC, 'DBF / DBC / support')
            CASE lcSection = '6'
               lcSecTitle = IIF(VARTYPE(loLang)='O', loLang.C_CFG_REF_SEC_EXTENSIONS_LOC, 'Extensions')
            OTHERWISE
               lcSecTitle = lcSection
            ENDCASE
            lcText = lcText + CR_LF + '=== ' + lcSecTitle + ' ===' + CR_LF + CR_LF
         ENDIF

         lcProp = laCat(ln, 2)
         IF PEMSTATUS(loDefaults, lcProp, 5)
            lcVal = TRANSFORM(EVALUATE('loDefaults.' + lcProp))
         ELSE
            lcVal = '?'
         ENDIF

         lcEffect = This.getCfgPropEffect(lcProp)

         lcText = lcText + lcProp + CR_LF
         lcText = lcText + '  Type:   ' + laCat(ln, 3) + '   Values: ' + laCat(ln, 4) + CR_LF
         lcText = lcText + '  Default: ' + lcVal + CR_LF
         IF !EMPTY(lcEffect)
            lcText = lcText + '  Effect:  ' + lcEffect + CR_LF
         ENDIF
         lcText = lcText + CR_LF
      ENDFOR

      RETURN lcText
   ENDPROC


   PROCEDURE getActiveCfg
      IF VARTYPE(This.o_CFG) = 'O' AND !ISNULL(This.o_CFG)
         RETURN This.o_CFG
      ENDIF
      RETURN This.createCfgShell()
   ENDPROC


   PROCEDURE getCfgValue
      LPARAMETERS tcProp
      LOCAL loCfg

      tcProp = ALLTRIM(tcProp)

      IF UPPER(tcProp) == 'N_DEBUG'
         IF !ISNULL(This.o_Host.n_DebugP)
            RETURN This.o_Host.n_DebugP
         ENDIF
      ENDIF

      loCfg = This.getActiveCfg()
      IF VARTYPE(loCfg) = 'O' AND PEMSTATUS(loCfg, tcProp, 5)
         RETURN EVALUATE('loCfg.' + tcProp)
      ENDIF

      RETURN .NULL.
   ENDPROC


   PROCEDURE getCfgFlag
      LPARAMETERS tcProp, tlDefault
      LOCAL lv

      lv = This.getCfgValue(tcProp)
      IF VARTYPE(lv) = 'L'
         RETURN lv
      ENDIF
      IF ISNULL(lv)
         RETURN EVL(tlDefault, .F.)
      ENDIF
      IF VARTYPE(lv) = 'N'
         RETURN (lv # 0)
      ENDIF
      RETURN (UPPER(ALLTRIM(TRANSFORM(lv))) $ '1.T.')
   ENDPROC


   PROCEDURE getCfgInt
      LPARAMETERS tcProp, lnDefault
      LOCAL lv

      lv = This.getCfgValue(tcProp)
      IF VARTYPE(lv) = 'N'
         RETURN lv
      ENDIF
      IF ISNULL(lv)
         RETURN EVL(lnDefault, 0)
      ENDIF
      RETURN INT(VAL(TRANSFORM(lv)))
   ENDPROC


   PROCEDURE getCfgObjectForWrite
      RETURN This.o_CFG
   ENDPROC


   PROCEDURE setCfgValue
      LPARAMETERS tcProp, txVal
      LOCAL loCfg

      loCfg = This.getCfgObjectForWrite()
      IF VARTYPE(loCfg) = 'O' AND PEMSTATUS(loCfg, tcProp, 5)
         STORE txVal TO ( 'loCfg.' + tcProp )
      ENDIF
   ENDPROC


   PROCEDURE isCfg
      LPARAMETERS toObj

      RETURN VARTYPE(toObj) = 'O' ;
         AND TYPE('toObj._CFG_Type') = 'C' ;
         AND toObj._CFG_Type == CFG_TYPE_MARKER
   ENDPROC


   PROCEDURE cfgCopyFrom
      LPARAMETERS toParentCFG, toSourceCFG
      LOCAL laProps(1), lnCount, I, lcProp, lxVal

      IF VARTYPE(toParentCFG) <> 'O' OR VARTYPE(toSourceCFG) <> 'O'
         RETURN
      ENDIF

      lnCount = AMEMBERS(laProps, toParentCFG, 0)

      FOR I = 1 TO lnCount
         lcProp = laProps(m.I)
         IF lcProp == '_CFG_Type'
            LOOP
         ENDIF
         IF !PEMSTATUS(toParentCFG, lcProp, 5)
            LOOP
         ENDIF
         lxVal = EVALUATE('toParentCFG.' + lcProp)
         IF PEMSTATUS(toSourceCFG, lcProp, 5)
            STORE lxVal TO ('toSourceCFG.' + lcProp)
         ELSE
            AddProperty(toSourceCFG, lcProp, lxVal)
         ENDIF
      ENDFOR

      RELEASE laProps, lnCount, I, lcProp, lxVal
   ENDPROC


   PROCEDURE newConfig
      RETURN This.createCfgShell()
   ENDPROC


   PROCEDURE configFromObject
      LPARAMETERS toSource, toDestCfg

      IF VARTYPE(toDestCfg) <> 'O' OR NOT This.isCfg(toDestCfg)
         toDestCfg = This.newConfig()
      ENDIF

      IF VARTYPE(toSource) <> 'O'
         RETURN toDestCfg
      ENDIF

      This.cfgCopyFrom( toSource, toDestCfg )

      RETURN toDestCfg
   ENDPROC


   PROCEDURE lockMasterFromObject
      LPARAMETERS toCfg

      IF VARTYPE(toCfg) <> 'O' OR ISNULL(toCfg) OR NOT This.isCfg(toCfg)
         RETURN .F.
      ENDIF

      This.cfgCopyFrom( toCfg, This.o_CFG )
      This.o_Host.c_Foxbin2prg_ConfigFile = toCfg
      RETURN .T.
   ENDPROC


   PROCEDURE applyConfig
      LPARAMETERS toCfg
      LOCAL loCfg

      IF VARTYPE(toCfg) <> 'O'
         RETURN .F.
      ENDIF

      IF This.isCfg( toCfg )
         loCfg = toCfg
      ELSE
         loCfg = This.configFromObject(toCfg)
      ENDIF

      This.o_Host.c_Foxbin2prg_ConfigFile = loCfg
      This.lockMasterFromObject( loCfg )
      RELEASE loCfg
      RETURN .T.
   ENDPROC

ENDDEFINE
