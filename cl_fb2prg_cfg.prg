#INCLUDE foxbin2prg.h

*---------------------------------------------------------------------------------------------------
* Configuration manager for FoxBin2Prg (used via c_foxbin2prg.o_Cfg).
*
* CFG stores (never confuse these):
*   o_FactoryCFG    Immutable factory defaults (createCfgShell). Never mutate at runtime.
*   o_MasterCFG     Session root effective CFG: disk root cfg, factory reset, and Mode C (loCfg object).
*   o_Configuration Collection cache keyed by foxbin2prg.cfg path; per-folder disk inheritance only.
*
* Entry modes:
*   A - main.prg / execute without CFG object: disk inheritance -> o_Configuration(n_CFG_Actual).
*   B - tcCFG_File string parameter: reset o_MasterCFG from factory, then disk per InhibitInheritance.
*   C - execute/exportProjectTree/applyConfig with loCfg object: copy into o_MasterCFG, lock (ignore disk).
*
* n_CFG_EvaluateFromParam: 0=normal disk; 1=Mode C lock (getActiveCfg -> o_MasterCFG); >1=legacy collection index.
* Rule: programmatic/API values go to o_MasterCFG; per-folder overlays use o_Configuration only in modes A/B.
*---------------------------------------------------------------------------------------------------

DEFINE CLASS cl_fb2prg_cfg AS Custom
   o_Host = .NULL.

   PROTECTED n_CFG_Actual, l_Main_CFG_Loaded, o_Configuration, l_CFG_CachedAccess

   l_CFG_CachedAccess              = .F.     && .T. when active CFG came from cache / master lock (no disk parse)
   n_CFG_EvaluateFromParam         = 0      && 0=disk; 1=Mode C lock to o_MasterCFG; >1=collection index
   l_SingleConfig                  = .F.     && .T. when tcCFG_File string param reset the cfg chain
   n_CFG_Actual                    = 0      && Index into o_Configuration for getActiveCfg (1=master item)
   l_Main_CFG_Loaded               = .F.     && .T. after first full evaluateConfiguration pass
   c_SingleConfig_Folder           = ''     && Root folder for InhibitInheritance with string cfg param

   o_FactoryCFG                    = .NULL.  && Immutable snapshot of createCfgShell defaults
   o_MasterCFG                     = .NULL.  && Session root effective CFG (Mode C target; disk root in A/B)
   o_Configuration                 = .NULL.  && Per-directory CFG cache (disk inheritance modes A/B only)

   PROCEDURE INIT
      LPARAMETERS toHost
      This.o_Host = toHost
   ENDPROC


   PROCEDURE setup
      *---------------------------------------------------------------------------------------------------
      * Initialize collection, factory snapshot, and master CFG (called from host INIT).
      *---------------------------------------------------------------------------------------------------
      This.o_Configuration = CREATEOBJECT('Collection')
      This.captureFactoryCFG()
      This.o_MasterCFG     = This.newConfig()
   ENDPROC


   PROCEDURE evaluateConfiguration
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcDontShowProgress        (v? IN    ) '1' to disable the progress bar
      * tcDontShowErrors          (v? IN    ) '1' to suppress error messages (MESSAGEBOX)
      * tcNoTimestamps            (v? IN    ) Whether to clear the timestamp ('1') or not ('0' or empty)
      * tcDebug                   (v? IN    ) '1' to enable debug mode (DEVELOPMENT ONLY)
      * tcRecompile               (v? IN    ) Recompile ('1') the binary once regenerated. [Default behavior change]
      *                                       This change saves time, speed, and safety. Also, recompilation by FoxBin2Prg
      *                                       runs from the file directory, so relative references may
      *                                       cause compilation errors, typically #include directives.
      *                                       NOTE: If a Path is given instead of '1' (e.g. the project path), it will be used as the base for recompiling
      * tcExtraBackupLevels       (v? IN    ) Number of backup levels to create (default '1')
      * tcClearUniqueID           (v? IN    ) Whether to clear the UniqueID ('1') or not ('0' or empty)
      * tcOptimizeByFilestamp     (v? IN    ) Whether to optimize by filestamp >= ('1'), equal only ('2'), or not optimize ('0' or empty)
      * tc_InputFile              (v! IN    ) Full path of the file to convert or directory name to process
      * tc_InputFile_Type         (@? IN    ) Input file type: (D)irectory, (F)ile, (Q)uerySupport
      * toParentCFG               (@? IN    ) (Internal use) If a value is passed, the new CFG copies its values from here first to inherit them
      * tl_ForceLog               (v? IN    ) Force logging of settings. used on cfg setting as object
      * tcCFG_File                (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
      *                                       Normal inheritance may or may not run, see setting InhibitInheritance
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tcDontShowProgress  , tcDontShowErrors, tcNoTimestamps       , tcDebug     , tcRecompile      ;
                , tcExtraBackupLevels , tcClearUniqueID , tcOptimizeByFilestamp, tc_InputFile, tcInputFile_Type ;
                , toParentCFG         , tl_ForceLog     , tcCFG_File

      #IF .F.
         LOCAL toParentCFG
      #ENDIF

      LOCAL lcConfigFile, lcLockFile, llExiste_CFG_EnDisco, llLockFileExists, llFirstRead, I, lcConfData, lcExt, lcValue, lc_CFG_Path, lcConfigLine
      LOCAL lnDirs, llMasterEval, lcProp, llSetSingleConfig, lc_Foxbin2prg_ConfigFile, lc_InputPath, llMasterLocked
      LOCAL laConfig(1), laDirInfo(1,5), laDirs(1)

      LOCAL lo_CFG           ;
          , loCFG_Manual     ;
          , lo_Configuration AS COLLECTION ;
          , loLang           AS CL_LANG OF 'cl_lang.prg' ;
          , loEx             AS EXCEPTION

      TRY
         WITH This
            tcDontShowProgress = Transform(tcDontShowProgress)

            IF INLIST( TRANSFORM(tcDebug), '0', '1', '2' )
               This.o_Host.writeLog( C_TAB + ' > Parameter tcDebug: ' + tcDebug +;
                          IIF(ISNULL(This.o_Host.n_DebugP), "", ", will be ignored, second use of parameter. Using: " + TRANSFORM(This.o_Host.n_DebugP) )+CR_LF )

               IF ISNULL(This.o_Host.n_DebugP)
                  This.o_Host.n_DebugP   = INT(VAL(tcDebug))
                  This.setCfgValue( 'n_Debug', This.o_Host.n_DebugP )
               ENDIF
            ENDIF

            STORE 0 TO lnKey
            STORE .F. TO llExiste_CFG_EnDisco, llLockFileExists, llFirstRead, llMasterEval, llMasterLocked
            llSetSingleConfig = .NULL.

            loLang           = _SCREEN.o_FoxBin2Prg_Lang
            tcRecompile      = EVL(tcRecompile, This.o_Host.c_Recompile)
            lo_Configuration = .o_Configuration

            *!* is a config file given by programm parameter
            IF Vartype(tcCFG_File)='C' AND !Empty(tcCFG_File)

               IF Empty(lo_Configuration.GetKey(tcCFG_File))

                  This.o_Host.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC6+tcCFG_File )

                  .l_Main_CFG_Loaded  = .F.
                  *restore default
                  .cfgCopyFrom( .o_FactoryCFG, .o_MasterCFG )

                  lc_Foxbin2prg_ConfigFile = This.o_Host.c_Foxbin2prg_ConfigFile
                  This.o_Host.c_Foxbin2prg_ConfigFile = tcCFG_File

                  .o_Configuration.REMOVE(-1)
                  .n_CFG_EvaluateFromParam = 0

                  .l_SingleConfig   = .F.
                  llSetSingleConfig = .T.

                  This.o_Host.writeLog( '> ' + UPPER(loLang.C_USING_THIS_SETTINGS_LOC) + ': ' + This.o_Host.c_Foxbin2prg_ConfigFile + ;
                     loLang.C_USING_THIS_SETTINGS_LOC1 )

               ELSE

                  This.o_Host.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC6+tcCFG_File + loLang.C_USING_THIS_SETTINGS_LOC7+;
                                 ICase( This.getCfgValue('n_InhibitInheritance')=0, loLang.C_USING_THIS_SETTINGS_LOC2 ;
                                      , This.getCfgValue('n_InhibitInheritance')=1, loLang.C_USING_THIS_SETTINGS_LOC3 ;
                                      , This.getCfgValue('n_InhibitInheritance')=2, loLang.C_USING_THIS_SETTINGS_LOC4 ;
                                      , This.getCfgValue('n_InhibitInheritance')=3, loLang.C_USING_THIS_SETTINGS_LOC5 ;
                                      , " Failure."+CR_LF) )

               ENDIF
            ENDIF

            lcConfigFile        = This.o_Host.c_Foxbin2prg_ConfigFile
            tc_InputFile        = EVL(tc_InputFile, This.o_Host.c_InputFile)
            tcInputFile_Type    = EVL(tcInputFile_Type,'')

            IF VARTYPE(lcConfigFile) = "O"
               loCFG_Manual    = lcConfigFile  && Mode C: CFG object from execute / exportProjectTree / applyConfig
               lcConfigFile    = FULLPATH('Personalized-CFG-Object', tc_InputFile)
               loCFG_Manual.c_Foxbin2prg_ConfigFile    = 'Personalized-CFG-Object'
            ELSE
               loCFG_Manual    = .NULL.
            ENDIF

            IF VARTYPE(toParentCFG) <> 'O' OR llSetSingleConfig
               IF NOT ISNULL(loCFG_Manual)
                  toParentCFG = loCFG_Manual
               ELSE
                  toParentCFG = .NULL.
               ENDIF
            ENDIF

            IF ISNULL(toParentCFG) THEN
               This.o_Host.c_InputFile        = tc_InputFile
            ENDIF

            *-- Determine InputFile type (File or Directory)
            IF EMPTY(tcInputFile_Type) AND NOT EMPTY(tc_InputFile)
               DO CASE
               CASE LEN(tc_InputFile) = 1
                  tcInputFile_Type    = C_FILETYPE_QUERYSUPPORT
                  lc_InputPath        = ""

               CASE ADIR(laDirInfo, tc_InputFile, "D") = 1 AND SUBSTR( laDirInfo(1,5), 5, 1 ) = "D"
                  tcInputFile_Type    = C_FILETYPE_DIRECTORY
                  lc_InputPath        = tc_InputFile

               OTHERWISE
                  tcInputFile_Type    = C_FILETYPE_FILE
                  lc_InputPath        = JUSTPATH(tc_InputFile)

               ENDCASE
            ELSE
               IF EMPTY(tc_InputFile) THEN
                  lc_InputPath        = ""
               ELSE
                  DO CASE
                  CASE tcInputFile_Type==C_FILETYPE_QUERYSUPPORT
                     lc_InputPath        = ""

                  CASE tcInputFile_Type==C_FILETYPE_DIRECTORY
                     lc_InputPath        = tc_InputFile

                  OTHERWISE
                     lc_InputPath        = JUSTPATH(tc_InputFile)

                  ENDCASE
               ENDIF
            ENDIF

            *!* just the single config from programm parameter, or sub dirs of the config file given by the parameter
            *!* more sophisticated control of inheritance for para file
            lc_InputPath = UPPER(lc_InputPath)
            DO CASE
            CASE .n_CFG_EvaluateFromParam = 1
               * Mode C lock: skip InhibitInheritance early exit (no disk cfg chain)

            CASE !.l_SingleConfig
               * just go ahead

            CASE .getCfgValue('n_InhibitInheritance')=0
               * read all

            CASE EMPTY(lc_InputPath)
               * whatever, just go ahead

            CASE .getCfgValue('n_InhibitInheritance')=3
               * read nothing
               EXIT

            CASE INLIST(.getCfgValue('n_InhibitInheritance'),1,2) AND lc_InputPath=.c_SingleConfig_Folder
               * just in the directory or subdirectory of the config file set by the parameter

            CASE .getCfgValue('n_InhibitInheritance')=1 AND .c_SingleConfig_Folder=lc_InputPath
               * just above the config file set by the parameter

            OTHERWISE
               EXIT

            ENDCASE

            *---------------------------------------------------------------------------------------------------
            * Mode C: programmatic loCfg locked to o_MasterCFG (ignore disk cfgs and per-path collection)
            *---------------------------------------------------------------------------------------------------
            IF .n_CFG_EvaluateFromParam = 1
               llMasterLocked = .T.
               IF NOT ISNULL(loCFG_Manual)
                  .cfgCopyFrom( loCFG_Manual, .o_MasterCFG )
               ENDIF
               lo_CFG              = .o_MasterCFG
               .l_CFG_CachedAccess = .T.
               .n_CFG_Actual       = 1
               IF .o_Configuration.COUNT = 0
                  .o_Configuration.ADD( .o_MasterCFG, 'Personalized-CFG-Object' )
               ENDIF
               llMasterEval        = .T.   && allow settings log (convert re-entry)
            ENDIF

            If ! llMasterLocked
               If .l_Main_CFG_Loaded And Not Empty(tc_InputFile) And Not tcInputFile_Type == C_FILETYPE_QUERYSUPPORT Then
                  If tcInputFile_Type == C_FILETYPE_DIRECTORY Then
                     * DIRECTORY SPECIFIED
                     If Isnull(loCFG_Manual)
                        *lcConfigFile   = FULLPATH( 'foxbin2prg.cfg', ADDBS(tc_InputFile) )
                        lcConfigFile = Fullpath( Justfname(lcConfigFile), Addbs(tc_InputFile) )
                     Endif
                  Else
                     * FILE SPECIFIED
                     If Isnull(loCFG_Manual)
                        *lcConfigFile   = FULLPATH( 'foxbin2prg.cfg', tc_InputFile )
                        lcConfigFile = Fullpath( Justfname(lcConfigFile), tc_InputFile )
                     Endif
                  Endif
               Endif
               lo_Configuration    = .o_Configuration
               .n_CFG_Actual       = 0
               .l_CFG_CachedAccess = .F.
               lc_CFG_Path         = Upper( Justpath( lcConfigFile ) )
               lcLockFile          = Forcepath(".FoxBin2Prg_Ignore",lc_CFG_Path)
               lo_CFG              = .o_MasterCFG
               *-- Search for the CFG of the given PATH in the cache
               If .l_Main_CFG_Loaded
                  If lo_Configuration.Count > 0 Then
                     If .n_CFG_EvaluateFromParam > 1
                        * Special: If there is a lock configuration (manual CFG), use it
                        .n_CFG_Actual = .n_CFG_EvaluateFromParam
                     Else
                        * Normally the CFG of the analyzed directory will be searched
                        .n_CFG_Actual       = lo_Configuration.GetKey( lcConfigFile )   && 0 = No cached CFG, >0 = Cached CFG exists
                     Endif
                     If .n_CFG_Actual > 0 Then
                        lo_CFG          = lo_Configuration.Item(.n_CFG_Actual)
                        .l_CFG_CachedAccess = .T.
                        If Not Isnull(loCFG_Manual)
                           * If a CFG object is passed, it overrides the stored one
                           .cfgCopyFrom( loCFG_Manual, lo_CFG )
                        Endif
                     Endif
                  Endif
                  *-- If no parent CFG was passed and there are no CFGs or the one for the given PATH is not found, walk the hierarchy
                  *!* LScheffler 30.08.2023 only read path if no config by parameter
                  If Isnull(llSetSingleConfig);
                        AND Isnull(loCFG_Manual);
                        AND Isnull(toParentCFG);
                        AND (lo_Configuration.Count = 0 Or .n_CFG_Actual = 0);
                        AND !This.o_Host.c_Foxbin2prg_ConfigFile==tc_InputFile Then
                     llMasterEval    = .T.
                     toParentCFG     = .o_MasterCFG
                     If Left( lc_CFG_Path, 2 ) == '\\' Then
                        *lnDirs = OCCURS( '\', lc_CFG_Path ) - 3
                        lnDirs  = Occurs( '\', lc_CFG_Path ) - 2
                     Else
                        lnDirs  = Occurs( '\', lc_CFG_Path )
                     Endif
                     If lnDirs > 0 Then
                        Dimension laDirs(lnDirs)
                        *-- Build the array with intermediate PATHs
                        For I = lnDirs To 1 Step -1
                           If m.I = lnDirs Then
                              laDirs(m.I) = Justpath(lc_CFG_Path)
                           Else
                              laDirs(m.I) = Justpath(laDirs(m.I+1))
                           Endif
                        Endfor
                        If lnDirs = 1 And laDirs(1) = lc_CFG_Path
                           *-- When there are no intermediate PATHs, skip this part so it is added below. 04/02/2016. FDBOZZO
                           *-- Example: Can happen when converting a file on C:\ or another root drive.
                        Else
                           *-- Now evaluate intermediate PATH configurations from the root onward
                           *-- and keep the last parent CFG configuration in toParentCFG to use as the base.
                           For I = 1 To lnDirs
                              .evaluateConfiguration( '', '', '', '', '', '', '', '', laDirs(m.I), C_FILETYPE_DIRECTORY, @toParentCFG)
                           Endfor
                        Endif
                        .l_CFG_CachedAccess = .F.
                        .n_CFG_Actual       = 0
                     Endif
                  Endif
               Endif

               Do Case
               Case .n_CFG_Actual = 0
                  *-- If no cached CFG was found, check whether a CFG file exists on disk
                  llExiste_CFG_EnDisco    = ( Adir( laDirInfo, lcConfigFile ) = 1 )
                  llLockFileExists        = ( Adir( laDirInfo, lcLockFile ) = 1 )

                  If Not llExiste_CFG_EnDisco
                     .l_CFG_CachedAccess = .T.   && Cached because without a CFG file it uses internal config
                  Endif

               Case Isnull( .o_Configuration( .n_CFG_Actual ) )
                  *-- Inherited entry (NULL in cache): use the master CFG
                  lo_CFG          = .o_MasterCFG

               Endcase

               If .l_Main_CFG_Loaded
                  If .l_CFG_CachedAccess And .n_CFG_Actual > 0 Then
                     toParentCFG = lo_CFG
                     This.o_Host.writeLog( '> ' + Upper(loLang.C_USING_THIS_SETTINGS_LOC) + ': ' + lo_CFG.c_Foxbin2prg_ConfigFile + '  => ' + tc_InputFile + ;
                        ' CFG_Actual:' + Transform(.n_CFG_Actual) + Icase(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]')  )
                  Else
                     lo_CFG  = .newConfig()
                     lo_Configuration.Add( lo_CFG, lcConfigFile )
                     .n_CFG_Actual   = lo_Configuration.Count

                     This.o_Host.writeLog( '> ' + Upper(loLang.C_CACHING_CONFIG_FOR_DIRECTORY_LOC) + ': ' + lcConfigFile + ;
                        ' CFG_Actual:' + Transform(.n_CFG_Actual) + Icase(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]')  )

                     If Not Isnull(toParentCFG)
                        .cfgCopyFrom( toParentCFG, lo_CFG )
                        toParentCFG = lo_CFG
                        *                               This.o_Host.writeLog( C_TAB + '- ' + loLang.C_INHERITING_FROM_LOC + ': ' + lo_CFG.c_Foxbin2prg_ConfigFile )
                        This.o_Host.writeLog( C_TAB + '- ' + loLang.C_INHERITING_FROM_LOC + ': ' + lo_Configuration.GetKey(lo_Configuration.Count-1) )
                     Endif
                     llFirstRead = .T.
                  Endif

               Else
                  *-- First evaluation: seed the master CFG from a programmatic object (exportProjectTree, applyConfig, etc.)
                  If Not Isnull(loCFG_Manual)
                     .cfgCopyFrom( loCFG_Manual, .o_MasterCFG )
                     lo_CFG          = .o_MasterCFG
                  Endif
                  lo_Configuration.Add( .o_MasterCFG, lcConfigFile )
                  .n_CFG_Actual   = lo_Configuration.Count
               Endif

               *check for lockfile
               If .l_Main_CFG_Loaded And llFirstRead And llLockFileExists Then
                  lo_CFG.l_AllowFolder = .F.
                  This.o_Host.writeLog( C_TAB + Justfname(lcLockFile) + loLang.C_LOCKINGFOLDER_LOC )
               Endif &&.l_Main_CFG_Loaded And llFirstRead AND llLockFileExists

               *-- NOTE: ONLY VALUES NOT COMING FROM EXTERNAL PARAMETERS SHOULD BE ASSIGNED TO lo_CFG HERE.
               If llExiste_CFG_EnDisco And Not .l_CFG_CachedAccess And lo_CFG.l_AllowFolder Then
                  This.o_Host.writeLog()
                  This.o_Host.writeLog( '> ' + loLang.C_READING_CFG_VALUES_FROM_DISK_LOC + ':' )
                  This.o_Host.writeLog( C_TAB + loLang.C_CONFIGFILE_LOC + ' ' + lcConfigFile )

                  lo_CFG.c_Foxbin2prg_ConfigFile      = lcConfigFile

                  For I = 1 To Alines( laConfig, Filetostr( lcConfigFile ), 1+4 )
                     This.o_Host.set_Line( @lcConfigLine, @laConfig, m.I )
                     This.o_Host.get_SeparatedLineAndComment( @lcConfigLine )
                     laConfig(m.I)       = Lower( lcConfigLine )

                     Do Case
                     Case Empty( laConfig(m.I) ) Or Inlist( Left( laConfig(m.I), 1 ), '*', '#', '/', "'" )
                        Loop

                        * settings for internal work, not processing
                        * Deprecated:
                     Case Left( laConfig(m.I), 17 ) == Lower('DontShowProgress:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 18 ) )
                        If Not Inlist( tcDontShowProgress, '0', '1', '2' ) And Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_ShowProgressbar = Icase(lcValue=='0',1, lcValue=='1',0, 2)
                           tcDontShowProgress = ''
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > tcDontShowProgress:         ' + tcDontShowProgress )
                        Endif

                     Case Left( laConfig(m.I), 16 ) == Lower('ShowProgressbar:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_ShowProgressbar  = Int( Val(lcValue) )
                           tcDontShowProgress = ''
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > ShowProgressbar:            ' + lcValue )
                        Endif
                     Case Left( laConfig(m.I), 9 ) == Lower('Language:')
                        *-- SPECIAL CASE: Language is not stored in lo_CFG because it is a global setting.
                        lcValue = Alltrim( Substr( laConfig(m.I), 10 , Iif('&'+'&'$laConfig(m.I), At('&'+'&', laConfig(m.I)) - 10, Len(laConfig(m.I) ) ) ) )
                        This.o_Host.changeLanguage(lcValue)
                        lo_CFG.c_Language_In = m.lcValue
                        This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > Language:                   ' + Transform(lcValue) + ' (' + This.o_Host.c_Language + ')' )


                     Case Left( laConfig(m.I), 15 ) == Lower('DontShowErrors:')
                        *-- Prefer when tcDontShowErrors is NOT passed as "0", because VBS scripts
                        *-- use it to override the default foxbin2prg.cfg configuration
                        lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                        If Not Inlist( Transform(tcDontShowErrors), '0', '1' ) And Inlist( lcValue, '0', '1' ) Then
                           tcDontShowErrors    = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > tcDontShowErrors:           ' + Transform(tcDontShowErrors) )
                        Endif

                     Case Left( laConfig(m.I), 18 ) == Lower('ExtraBackupLevels:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 19 ) )
                        If Not Isdigit( Transform(tcExtraBackupLevels) ) And Isdigit( lcValue ) Then
                           tcExtraBackupLevels = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > tcExtraBackupLevels:        ' + Transform(tcExtraBackupLevels) )
                        Endif

                     Case Left( laConfig(m.I), 16 ) == Lower('BackgroundImage:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                        Do Case
                        Case Empty(lcValue)
                           lo_CFG.c_BackgroundImage    = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > BackgroundImage:            (Empty)' )

                        Case Adir( laDirInfo, lcValue ) > 0
                           lo_CFG.c_BackgroundImage    = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > BackgroundImage:            ' + Transform(lo_CFG.c_BackgroundImage) )

                        Otherwise
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > BackgroundImage:            File not found:  ' + Transform(lo_CFG.c_BackgroundImage) )

                        Endcase
                     Case Left( laConfig(m.I), 6 ) == Lower('Debug:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 7 ) )
                        If Not Inlist( Transform(tcDebug), '0', '1' ) And Inlist( lcValue, '0', '1' ) Then
                           If Isnull(This.o_Host.n_DebugP) Then
                              lo_CFG.n_Debug = Int(Val(lcValue))
                           Endif
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > Debug:                      ' + lcValue +;
                              IIF(Isnull(This.o_Host.n_DebugP), "", ", will be ignored, debug set via parameter. Using: " + Transform(This.o_Host.n_DebugP) ) )
                        Endif

                        * handle n_HomeDir configuration setting
                     Case Left( laConfig(m.I), 8 ) == Lower('HomeDir:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 9 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.n_HomeDir    = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > HomeDir:                    ' + Transform(lo_CFG.n_HomeDir) )
                        Endif

                        * Conversion operation by type
                     Case Left( laConfig(m.I), 23 ) == Lower('PJX_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_PJX_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > PJX_Conversion_Support:     ' + Transform(lo_CFG.n_PJX_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('VCX_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_VCX_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > VCX_Conversion_Support:     ' + Transform(lo_CFG.n_VCX_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('SCX_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_SCX_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > SCX_Conversion_Support:     ' + Transform(lo_CFG.n_SCX_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('FRX_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_FRX_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > FRX_Conversion_Support:     ' + Transform(lo_CFG.n_FRX_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('LBX_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_LBX_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > LBX_Conversion_Support:     ' + Transform(lo_CFG.n_LBX_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('MNX_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_MNX_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > MNX_Conversion_Support:     ' + Transform(lo_CFG.n_MNX_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('DBF_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1', '2', '4', '8' ) Then
                           lo_CFG.n_DBF_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_Conversion_Support:     ' + Transform(lo_CFG.n_DBF_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('DBC_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_DBC_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBC_Conversion_Support:     ' + Transform(lo_CFG.n_DBC_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('FKY_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.n_FKY_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > FKY_Conversion_Support:     ' + Transform(lo_CFG.n_FKY_Conversion_Support) )
                        Endif

                     Case Left( laConfig(m.I), 23 ) == Lower('MEM_Conversion_Support:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.n_MEM_Conversion_Support = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > MEM_Conversion_Support:     ' + Transform(lo_CFG.n_MEM_Conversion_Support) )
                        Endif


                        *-------- setting for container files (not pjx) --------
                        *Classes and forms ( vcx / scx)
                        * additional options controlling
                        * files in non subpath of the PJX
                     Case Left( laConfig(m.I), 16 ) == Lower('CheckFileInPath:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                        If Inlist( lcValue, '0', '1', '2', '3' ) Then
                           lo_CFG.n_CheckFileInPath    = Int( Val(lcValue) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > CheckFileInPath:            ' + Transform(lcValue) )
                        Endif

                        * additional options controlling
                        * - splitt of DBC separated from VCX/SCX
                        * - new operations of DBF
                        *VCX
                     Case Left( laConfig(m.I), 16 ) == Lower('UseClassPerFile:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_UseClassPerFile    = Int( Val(lcValue) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseClassPerFile:            ' + Transform(lcValue) )
                           If !lo_CFG.l_OldFilesPerDBC Then
                              lo_CFG.n_UseFilesPerDBC             = lo_CFG.n_UseClassPerFile
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + '  => UseFilesPerDBC:           ' + Transform(lcValue) )
                           Endif
                           If !lo_CFG.l_UseFormSettings Then
                              lo_CFG.n_UseFormPerFile             = lo_CFG.n_UseClassPerFile
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + '  => UseFormPerFile:           ' + Transform(lcValue) )
                           Endif
                        Endif

                     Case Left( laConfig(m.I), 27 ) == Lower('RedirectClassPerFileToMain:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 28 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_RedirectClassPerFileToMain = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectClassPerFileToMain: ' + Transform(lcValue) )
                           If !lo_CFG.l_OldFilesPerDBC Then
                              lo_CFG.l_RedirectFilePerDBCToMain   = lo_CFG.l_RedirectClassPerFileToMain
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + '  => RedirectFilePerDBCToMain: ' + Transform(lcValue) )
                           Endif
                           If !lo_CFG.l_UseFormSettings Then
                              lo_CFG.l_RedirectFormPerFileToMain  = lo_CFG.l_RedirectClassPerFileToMain
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + '  => RedirectFormPerFileToMain ' + Transform(lcValue) )
                           Endif
                        Endif

                        * new value 2, just add one class
                     Case Left( laConfig(m.I), 18 ) == Lower('RedirectClassType:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 19 ) )
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_RedirectClassType  = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectClassType:          ' + Transform(lcValue) )
                           If !lo_CFG.l_UseFormSettings Then
                              lo_CFG.n_RedirectFormType           = lo_CFG.n_RedirectClassType
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + '  => RedirectFormType          ' + Transform(lcValue) )
                           Endif
                        Endif

                     Case Left( laConfig(m.I), 18 ) == Lower('ClassPerFileCheck:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 19 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_ClassPerFileCheck  = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > ClassPerFileCheck:          ' + Transform(lcValue) )
                           If !lo_CFG.l_OldFilesPerDBC Then
                              lo_CFG.l_ItemPerDBCCheck            = lo_CFG.l_ClassPerFileCheck
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + '  => ItemPerDBCCheck:          ' + Transform(lcValue) )
                           Endif
                           If !lo_CFG.l_UseFormSettings Then
                              lo_CFG.l_FormPerFileCheck           = lo_CFG.l_ClassPerFileCheck
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + '  => FormPerFileCheck          ' + Transform(lcValue) )
                           Endif
                        Endif

                     Case Left( laConfig(m.I), 15 ) == Lower('UseClassPerDir:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_UseClassPerDir  = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseClassPerDir:             ' + Transform(lcValue) )
                        Endif

                        *Forms
                     Case Left( laConfig(m.I), 16 ) == Lower('UseFormSettings:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_UseFormSettings    = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseFormSettings:            ' + Transform(lcValue) )
                           If !lo_CFG.l_UseFormSettings Then
                              lo_CFG.n_UseFormPerFile             = lo_CFG.n_UseClassPerFile
                              lo_CFG.l_RedirectFormPerFileToMain  = lo_CFG.l_RedirectClassPerFileToMain
                              lo_CFG.n_RedirectFormType           = lo_CFG.n_RedirectClassType
                              lo_CFG.l_FormPerFileCheck           = lo_CFG.l_ClassPerFileCheck
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> UseFormPerFile:            ' + Transform(lo_CFG.n_UseFormPerFile) )
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> RedirectFormPerFileToMain: ' + Transform(lo_CFG.l_RedirectFormPerFileToMain) )
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> n_RedirectFormType:        ' + Transform(lo_CFG.n_RedirectFormType) )
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> FormPerFileCheck:          ' + Transform(lo_CFG.l_FormPerFileCheck) )
                           Endif
                        Endif

                     Case Left( laConfig(m.I), 15 ) == Lower('UseFormPerFile:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                        If lo_CFG.l_UseFormSettings And Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_UseFormPerFile = Int( Val(lcValue) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseFormPerFile:             ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 26 ) == Lower('RedirectFormPerFileToMain:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 27 ) )
                        If lo_CFG.l_UseFormSettings And Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_RedirectFormPerFileToMain  = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectFormPerFileToMain:  ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 17 ) == Lower('RedirectFormType:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 18 ) )
                        If lo_CFG.l_UseFormSettings And Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_RedirectFormType   = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectFormType:           ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 17 ) == Lower('FormPerFileCheck:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 18 ) )
                        If lo_CFG.l_UseFormSettings And Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_FormPerFileCheck   = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > FormPerFileCheck:           ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 15 ) == Lower('UseFormsPerDir:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                        If lo_CFG.l_UseFormSettings And Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_UseFormsPerDir  = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseFormsPerDir:             ' + Transform(lcValue) )
                        Endif
                        */Forms

                        *Databases
                     Case Left( laConfig(m.I), 15 ) == Lower('OldFilesPerDBC:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_OldFilesPerDBC = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > OldFilesPerDBC:             ' + Transform(lcValue) )
                           If !lo_CFG.l_OldFilesPerDBC Then
                              lo_CFG.n_UseFilesPerDBC             = lo_CFG.n_UseClassPerFile
                              lo_CFG.l_RedirectFilePerDBCToMain   = lo_CFG.l_RedirectClassPerFileToMain
                              lo_CFG.l_ItemPerDBCCheck            = lo_CFG.l_ClassPerFileCheck
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> UseFilesPerDBC:           ' + Transform(lo_CFG.n_UseFilesPerDBC) )
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> RedirectFilePerDBCToMain: ' + Transform(lo_CFG.l_RedirectFilePerDBCToMain) )
                              This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> ItemPerDBCCheck:          ' + Transform(lo_CFG.l_ItemPerDBCCheck) )
                           Endif
                        Endif

                     Case Left( laConfig(m.I), 15 ) == Lower('UseFilesPerDBC:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                        If lo_CFG.l_OldFilesPerDBC And Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.n_UseFilesPerDBC = Int( Val(lcValue) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseFilesPerDBC:             ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 25 ) == Lower('RedirectFilePerDBCToMain:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 26 ) )
                        If lo_CFG.l_OldFilesPerDBC And Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_RedirectFilePerDBCToMain   = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectFilePerDBCToMain:   ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 16 ) == Lower('ItemPerDBCCheck:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                        If lo_CFG.l_OldFilesPerDBC And Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_ItemPerDBCCheck    = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > ItemPerDBCCheck:            ' + Transform(lcValue) )
                        Endif
                        */Databases
                        */-------- setting for container files (not pjx) --------

                     Case Left( laConfig(m.I), 19 ) == Lower('InhibitInheritance:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                        If Inlist( lcValue, '0', '1' , '2' , '3' ) Then
                           If llSetSingleConfig Then
                              lo_CFG.n_InhibitInheritance    =  Int( Val( lcValue ) )
                           Endif

                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > InhibitInheritance:         ' + Transform(lcValue) +;
                              IIF(m.llSetSingleConfig, "", ", will be ignored, standard configuration file." ) )
                        Endif

                        *general files
                     Case Left( laConfig(m.I), 13 ) == Lower('NoTimestamps:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 14 ) )
                        If Not Inlist( Transform(tcNoTimestamps), '0', '1' ) And Inlist( lcValue, '0', '1' ) Then
                           tcNoTimestamps  = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > tcNoTimestamps:             ' + Transform(tcNoTimestamps) )
                        Endif

                     Case Left( laConfig(m.I), 14 ) == Lower('ClearUniqueID:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 15 ) )
                        If Not Inlist( Transform(tcClearUniqueID), '0', '1' ) And Inlist( lcValue, '0', '1' ) Then
                           tcClearUniqueID = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > ClearUniqueID:              ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 20 ) == Lower('OptimizeByFilestamp:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 21 ) )
                        If Not Inlist( Transform(tcOptimizeByFilestamp), '0', '1', '2' ) And Inlist( lcValue, '0', '1', '2' ) Then
                           tcOptimizeByFilestamp   = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > OptimizeByFilestamp:        ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 24 ) == Lower('RemoveNullCharsFromCode:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 25 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_RemoveNullCharsFromCode    = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > RemoveNullCharsFromCode:    ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 25 ) == Lower('RemoveZOrderSetFromProps:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 26 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_RemoveZOrderSetFromProps   = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > RemoveZOrderSetFromProps:   ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(I), 17 ) == Lower('PRG_Compat_Level:')
                        lcValue = Alltrim( Substr( laConfig(I), 18 ) )
                        lo_CFG.n_PRG_Compat_Level   = Int( Val( lcValue ) )
                        This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > PRG_Compat_Level:           ' + Transform(lo_CFG.n_PRG_Compat_Level) )

                        *pjx special
                     Case Left( laConfig(m.I), 12 ) == Lower('BodyDevInfo:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 13 ) )
                        * support 2 as a value
                        If Inlist( lcValue, '0', '1', '2' ) Then
                           lo_CFG.n_BodyDevInfo    = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > BodyDevInfo:                ' + Transform(lo_CFG.n_BodyDevInfo) )
                        Endif


                        *dbf special
                     Case Left( laConfig(m.I), 19 ) == Lower('ClearDBFLastUpdate:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_ClearDBFLastUpdate = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > ClearDBFLastUpdate:         ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 25 ) == Lower('ExcludeDBFAutoincNextval:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 26 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.n_ExcludeDBFAutoincNextval   = Int( Val( lcValue ) )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > ExcludeDBFAutoincNextval:   ' + Transform(lo_CFG.n_ExcludeDBFAutoincNextval) )
                        Endif

                     Case Left( laConfig(m.I), 24 ) == Lower('DBF_Conversion_Included:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 25 , Iif('&'+'&'$laConfig(m.I), At('&'+'&', laConfig(m.I)) - 25, Len(laConfig(m.I) ) ) ) )
                        If Not Empty(lcValue) Then
                           lo_CFG.c_DBF_Conversion_Included    = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_Conversion_Included:    ' + Transform(lo_CFG.c_DBF_Conversion_Included) )
                        Endif

                     Case Left( laConfig(m.I), 24 ) == Lower('DBF_Conversion_Excluded:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 25 , Iif('&'+'&'$laConfig(m.I), At('&'+'&', laConfig(m.I)) - 25, Len(laConfig(m.I) ) ) ) )
                        If Not Empty(lcValue) Then
                           lo_CFG.c_DBF_Conversion_Excluded    = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_Conversion_Excluded:    ' + Transform(lo_CFG.c_DBF_Conversion_Excluded) )
                        Endif

                     Case Left( laConfig(m.I), 19 ) == Lower('CopyNonConvertible:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_CopyNonConvertible = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > CopyNonConvertible:         ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 22 ) == Lower('CopyExcludedPjxFiles:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 23 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_CopyExcludedPjxFiles = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > CopyExcludedPjxFiles:       ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 19 ) == Lower('CopyLowercaseNames:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_CopyLowercaseNames = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > CopyLowercaseNames:         ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 16 ) == Lower('ExcludedSubdirs:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 17 , Iif('&'+'&'$laConfig(m.I), At('&'+'&', laConfig(m.I)) - 17, Len(laConfig(m.I) ) ) ) )
                        If Not Empty(lcValue) Then
                           lo_CFG.c_ExcludedSubdirs    = lcValue
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > ExcludedSubdirs:            ' + Transform(lo_CFG.c_ExcludedSubdirs) )
                        Endif

                     Case Left( laConfig(m.I), 19 ) == Lower('DBF_BinChar_Base64:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_DBF_BinChar_Base64 = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_BinChar_Base64:         ' + Transform(lcValue) )
                        Endif

                     Case Left( laConfig(m.I), 19 ) == Lower('DBF_IncludeDeleted:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                        If Inlist( lcValue, '0', '1' ) Then
                           lo_CFG.l_DBF_IncludeDeleted = ( Transform(lcValue) == '1' )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_IncludeDeleted:         ' + Transform(lcValue) )
                        Endif

                        * Text file extensions
                     Case Left( laConfig(m.I), 10 ) == Lower('Extension:')
                        lcConfData  = Alltrim( Substr( laConfig(m.I), 11 ) )
                        lcExt       = Alltrim( Getwordnum( lcConfData, 1, '=' ) )
                        lcProp      = 'c_' + lcExt
                        If Pemstatus( lo_CFG, lcProp, 5 )
                           lcValue = Upper( Alltrim( Getwordnum( lcConfData, 2, '=' ) ) )
                           AddProperty( lo_CFG, lcProp, lcValue )
                           This.o_Host.writeLog( C_TAB + Justfname(lcConfigFile) + ' > ' + loLang.C_EXTENSION_RECONFIGURATION_LOC + ' ' + lcExt + ' -> ' + lcValue )
                        Endif

                     Endcase
                  Endfor

                  This.o_Host.writeLog( )

               Endif   && llExiste_CFG_EnDisco AND NOT .l_CFG_CachedAccess ...

            Endif   && !llMasterLocked (modes A/B disk inheritance)

            *-- THESE ARE EVALUATED OUTSIDE THE IF BECAUSE THEY DO NOT DEPEND ON THE CFG
            *-- AND MAY ALSO COME FROM EXTERNAL PARAMETERS.
            IF INLIST( tcDontShowProgress, '0', '1', '2' ) THEN
               lo_CFG.n_ShowProgressbar = ICase(tcDontShowProgress=='0',1, tcDontShowProgress=='1',0, 2)
            ENDIF

            IF INLIST( TRANSFORM(tcDontShowErrors), '0', '1' ) THEN
               lo_CFG.l_ShowErrors = NOT (Transform(tcDontShowErrors) == '1')
            ENDIF

            lo_CFG.l_Recompile = (Empty(tcRecompile) OR Transform(tcRecompile) == '1' OR Directory(tcRecompile))

            IF InList( Transform(tcNoTimestamps), '0', '1' ) THEN
               lo_CFG.l_NoTimestamps = NOT (TRANSFORM(tcNoTimestamps) == '0')
            ENDIF

            IF InList( Transform(tcClearUniqueID), '0', '1' ) THEN
               lo_CFG.l_ClearUniqueID = NOT (TRANSFORM(tcClearUniqueID) == '0')
            ENDIF

            tcExtraBackupLevels = EVL( tcExtraBackupLevels, Transform( .getCfgValue('n_ExtraBackupLevels') ) )

            IF IsDigit(tcExtraBackupLevels)
               lo_CFG.n_ExtraBackupLevels = Int( Val( Transform(tcExtraBackupLevels) ) )
            ENDIF

            IF InList( Transform(tcOptimizeByFilestamp), '0', '1', '2' ) THEN
               lo_CFG.n_OptimizeByFilestamp = Int(Val(tcOptimizeByFilestamp))
            ENDIF

            .l_Main_CFG_Loaded  = .T.

            IF llMasterEval
               * Legacy: map -1 to collection index (never for Mode C lock where n_CFG_EvaluateFromParam = 1)
               IF .n_CFG_EvaluateFromParam = -1
                  .n_CFG_EvaluateFromParam = .n_CFG_Actual
               ENDIF
            ELSE
               *-- If not llMasterEval, this call is cyclic from this same method,
               *-- and there are no parameters to evaluate, since they are all sent empty from the initial call.
               IF NOT tl_ForceLog THEN
                  EXIT
               ENDIF &&NOT tl_ForceLog
            ENDIF

            IF lo_CFG.l_AllowFolder THEN
               This.o_Host.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC + ':' )
               * internal info, just what is read to this moment
               This.o_Host.writeLog( C_TAB + 'CFG_Actual:                 ' + TRANSFORM(.n_CFG_Actual) + ICASE(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]') )
               This.o_Host.writeLog( C_TAB + 'CFG_CachedAccess:           ' + TRANSFORM(.l_CFG_CachedAccess) )
               This.o_Host.writeLog( C_TAB + 'tc_InputFile:               ' + TRANSFORM(EVL(tc_InputFile,'') ) )
               This.o_Host.writeLog( C_TAB + 'Foxbin2prg_ConfigFile:      ' + TRANSFORM(EVL(lo_CFG.c_Foxbin2prg_ConfigFile, '(Internal defaults)') ) )

               * settings for internal work, not processing
               This.o_Host.writeLog( C_TAB + 'Language:                   ' + TRANSFORM(This.o_Host.c_Language) + ' (' + .getCfgValue('c_Language_In') + ')' )
               This.o_Host.writeLog( C_TAB + 'ShowProgressbar:            ' + TRANSFORM(.getCfgValue('n_ShowProgressbar')) )
               This.o_Host.writeLog( C_TAB + 'ShowErrors:                 ' + TRANSFORM(.getCfgValue('l_ShowErrors')) )
               This.o_Host.writeLog( C_TAB + 'ExtraBackupLevels:          ' + TRANSFORM(.getCfgValue('n_ExtraBackupLevels')) )

               DO CASE
               CASE EMPTY ( .getCfgValue('c_BackgroundImage') )
                  This.o_Host.writeLog( C_TAB + 'BackgroundImage:            ' + '(Empty)' )

               CASE LOWER( JUSTFNAME ( .getCfgValue('c_BackgroundImage') ) ) == 'foxbin2prg.jpg'
                  This.o_Host.writeLog( C_TAB + 'BackgroundImage:            ' + TRANSFORM(.getCfgValue('c_BackgroundImage')) +  '(Internal default)' )

               OTHERWISE
                  This.o_Host.writeLog( C_TAB + 'BackgroundImage:            ' + TRANSFORM(.getCfgValue('c_BackgroundImage')) )

               ENDCASE

               This.o_Host.writeLog( C_TAB + 'Debug:                      ' + TRANSFORM(.getCfgValue('n_Debug')) )

               * HomeDir option
               This.o_Host.writeLog( C_TAB + 'HomeDir:                    ' + TRANSFORM(.getCfgValue('n_HomeDir')) )

               * Conversion operation by type
               This.o_Host.writeLog( C_TAB + 'PJX_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_PJX_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'VCX_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_VCX_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'SCX_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_SCX_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'FRX_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_FRX_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'LBX_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_LBX_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'MNX_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_MNX_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'DBF_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_DBF_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'DBC_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_DBC_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'FKY_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_FKY_Conversion_Support')) )
               This.o_Host.writeLog( C_TAB + 'MEM_Conversion_Support      ' + TRANSFORM(.getCfgValue('n_MEM_Conversion_Support')) )

               * additional options controlling
               * files in non subpath of the PJX
               * setting for PJX files
               This.o_Host.writeLog( C_TAB + 'CheckFileInPath:            ' + TRANSFORM(.getCfgValue('n_CheckFileInPath')) )

               * setting for container files (not pjx)
               * Classes ( vcx )
               This.o_Host.writeLog( C_TAB + 'UseClassPerFile:            ' + TRANSFORM(.getCfgValue('n_UseClassPerFile')) )
               This.o_Host.writeLog( C_TAB + 'ClassPerFileCheck:          ' + TRANSFORM(.getCfgValue('l_ClassPerFileCheck')) )
               This.o_Host.writeLog( C_TAB + 'RedirectClassPerFileToMain: ' + TRANSFORM(.getCfgValue('l_RedirectClassPerFileToMain')) )
               This.o_Host.writeLog( C_TAB + 'RedirectClassType:          ' + TRANSFORM(.getCfgValue('n_RedirectClassType')) )
               This.o_Host.writeLog( C_TAB + 'UseClassPerDir:             ' + TRANSFORM(IIF(.getCfgFlag('l_UseClassPerDir'), 1, 0)) )

               *Forms ( scx)
               This.o_Host.writeLog( C_TAB + 'UseFormSettings:            ' + TRANSFORM(.getCfgValue('l_UseFormSettings')) )
               This.o_Host.writeLog( C_TAB + 'UseFormPerFile:             ' + TRANSFORM(.getCfgValue('n_UseFormPerFile')) )
               This.o_Host.writeLog( C_TAB + 'FormPerFileCheck:           ' + TRANSFORM(.getCfgValue('l_FormPerFileCheck')) )
               This.o_Host.writeLog( C_TAB + 'RedirectFormPerFileToMain:  ' + TRANSFORM(.getCfgValue('l_RedirectFormPerFileToMain')) )
               This.o_Host.writeLog( C_TAB + 'RedirectFormType:           ' + TRANSFORM(.getCfgValue('n_RedirectFormType')) )
               This.o_Host.writeLog( C_TAB + 'UseFormsPerDir:             ' + TRANSFORM(IIF(.getCfgFlag('l_UseFormsPerDir'), 1, 0)) )

               *Databases
               * additional options controlling
               * - split of DBC separated from VCX/SCX
               * - new operations of DBF
               This.o_Host.writeLog( C_TAB + 'OldFilesPerDBC:             ' + TRANSFORM(.getCfgValue('l_OldFilesPerDBC')) )
               This.o_Host.writeLog( C_TAB + 'UseFilesPerDBC:             ' + TRANSFORM(.getCfgValue('n_UseFilesPerDBC')) )
               This.o_Host.writeLog( C_TAB + 'RedirectFilePerDBCToMain:   ' + TRANSFORM(.getCfgValue('l_RedirectFilePerDBCToMain')) )
               This.o_Host.writeLog( C_TAB + 'ItemPerDBCCheck:            ' + TRANSFORM(.getCfgValue('l_ItemPerDBCCheck')) )
               This.o_Host.writeLog( C_TAB + 'DBF_BinChar_Base64:         ' + TRANSFORM(.getCfgValue('l_DBF_BinChar_Base64')) )
               This.o_Host.writeLog( C_TAB + 'DBF_IncludeDeleted:         ' + TRANSFORM(.getCfgValue('l_DBF_IncludeDeleted')) )

               *general files
               This.o_Host.writeLog( C_TAB + 'NoTimestamps:               ' + TRANSFORM(.getCfgValue('l_NoTimestamps')) )
               This.o_Host.writeLog( C_TAB + 'ClearUniqueID:              ' + TRANSFORM(.getCfgValue('l_ClearUniqueID')) )
               This.o_Host.writeLog( C_TAB + 'OptimizeByFilestamp:        ' + TRANSFORM(.getCfgValue('n_OptimizeByFilestamp')) )
               This.o_Host.writeLog( C_TAB + 'RemoveNullCharsFromCode:    ' + TRANSFORM(.getCfgValue('l_RemoveNullCharsFromCode')) )
               This.o_Host.writeLog( C_TAB + 'RemoveZOrderSetFromProps:   ' + TRANSFORM(.getCfgValue('l_RemoveZOrderSetFromProps')) )
               This.o_Host.writeLog( C_TAB + 'PRG_Compat_Level:           ' + TRANSFORM(.getCfgValue('n_PRG_Compat_Level')) )

               *Parameter only:
               This.o_Host.writeLog( C_TAB + 'Recompile:                  ' + TRANSFORM(.getCfgValue('l_Recompile')) + ' (' + tcRecompile + ')' )

               *pjx special
               This.o_Host.writeLog( C_TAB + 'BodyDevInfo:                ' + TRANSFORM(.getCfgValue('n_BodyDevInfo')) )

               *dbf special
               This.o_Host.writeLog( C_TAB + 'ClearDBFLastUpdate:         ' + TRANSFORM(.getCfgValue('l_ClearDBFLastUpdate')) )
               This.o_Host.writeLog( C_TAB + 'ExcludeDBFAutoincNextval:   ' + TRANSFORM(.getCfgValue('n_ExcludeDBFAutoincNextval')) )
               This.o_Host.writeLog( C_TAB + 'DBF_Conversion_Included     ' + TRANSFORM(.getCfgValue('c_DBF_Conversion_Included')) )
               This.o_Host.writeLog( C_TAB + 'DBF_Conversion_Excluded     ' + TRANSFORM(.getCfgValue('c_DBF_Conversion_Excluded')) )
               This.o_Host.writeLog( C_TAB + 'CopyNonConvertible:         ' + TRANSFORM(.getCfgValue('l_CopyNonConvertible')) )
               This.o_Host.writeLog( C_TAB + 'CopyExcludedPjxFiles:       ' + TRANSFORM(.getCfgValue('l_CopyExcludedPjxFiles')) )
               This.o_Host.writeLog( C_TAB + 'CopyLowercaseNames:         ' + TRANSFORM(.getCfgValue('l_CopyLowercaseNames')) )
               This.o_Host.writeLog( C_TAB + 'ExcludedSubdirs:            ' + TRANSFORM(.getCfgValue('c_ExcludedSubdirs')) )
               This.o_Host.writeLog( C_TAB + 'DBF_BinChar_Base64:         ' + TRANSFORM(.getCfgValue('l_DBF_BinChar_Base64')) )
               This.o_Host.writeLog( C_TAB + 'DBF_IncludeDeleted:         ' + TRANSFORM(.getCfgValue('l_DBF_IncludeDeleted')) )

               *Text file extensions
               This.o_Host.writeLog( C_TAB + 'extension: VC2              ' + TRANSFORM(.getCfgValue('c_VC2')) )
               This.o_Host.writeLog( C_TAB + 'extension: SC2              ' + TRANSFORM(.getCfgValue('c_SC2')) )
               This.o_Host.writeLog( C_TAB + 'extension: FR2              ' + TRANSFORM(.getCfgValue('c_FR2')) )
               This.o_Host.writeLog( C_TAB + 'extension: FR2D             ' + TRANSFORM(.getCfgValue('c_FR2D')) )
               This.o_Host.writeLog( C_TAB + 'extension: LB2              ' + TRANSFORM(.getCfgValue('c_LB2')) )
               This.o_Host.writeLog( C_TAB + 'extension: LB2D             ' + TRANSFORM(.getCfgValue('c_LB2D')) )
               This.o_Host.writeLog( C_TAB + 'extension: MN2              ' + TRANSFORM(.getCfgValue('c_MN2')) )
               This.o_Host.writeLog( C_TAB + 'extension: DB2              ' + TRANSFORM(.getCfgValue('c_DB2')) )
               This.o_Host.writeLog( C_TAB + 'extension: DC2              ' + TRANSFORM(.getCfgValue('c_DC2')) )
               This.o_Host.writeLog( C_TAB + 'extension: FK2              ' + TRANSFORM(.getCfgValue('c_FK2')) )
               This.o_Host.writeLog( C_TAB + 'extension: ME2              ' + TRANSFORM(.getCfgValue('c_ME2')) )
            ENDIF &&lo_CFG.l_AllowFolder

            This.o_Host.writeLog( )

         ENDWITH

      CATCH TO loEx
         loEx.USERVALUE  = loEx.USERVALUE + 'lcConfigFile = [' + TRANSFORM(lcConfigFile) + ']' + CR_LF
         loEx.USERVALUE  = loEx.USERVALUE + 'lc_CFG_Path = [' + TRANSFORM(lc_CFG_Path) + ']' + CR_LF
         loEx.USERVALUE  = loEx.USERVALUE + 'lcValue = [' + TRANSFORM(lcValue) + ']' + CR_LF

         IF This.getCfgValue('n_Debug') > 0 AND _VFP.STARTMODE = 0
            SET STEP ON
         ENDIF

         THROW

      FINALLY
         This.l_SingleConfig        = NVL(llSetSingleConfig,This.l_SingleConfig)
         *!* LScheffler 31.08.2023 more sophisticated control of inheritance for para file

         IF llSetSingleConfig THEN
            This.c_SingleConfig_Folder   = UPPER(JUSTPATH(tcCFG_File))
            This.o_Host.c_Foxbin2prg_ConfigFile = lc_Foxbin2prg_ConfigFile
            DO CASE
            CASE This.getCfgValue('n_InhibitInheritance')=0
               This.o_Host.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC2 )
            CASE This.getCfgValue('n_InhibitInheritance')=1
               This.o_Host.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC3 )
            CASE This.getCfgValue('n_InhibitInheritance')=2
               This.o_Host.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC4 )
            CASE This.getCfgValue('n_InhibitInheritance')=3
               This.o_Host.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC5 )
            ENDCASE

            IF This.getCfgValue('n_InhibitInheritance')=0 THEN
               This.evaluateConfiguration( '', '', '', '', '', '', '', '', This.o_Host.c_Foxbin2prg_ConfigFile, C_FILETYPE_FILE, lo_CFG)
               *In case we run FoxBin2Prg against FoxBin2Prg folder. do not reread
               This.setCfgValue( 'n_InhibitInheritance', 1 )

            ENDIF &&This.getCfgValue('n_InhibitInheritance')=0
         ENDIF &&llSetSingleConfig

         STORE .NULL. TO lo_Configuration, lo_CFG, loEx
         RELEASE tcDontShowProgress, tcDontShowErrors, tcNoTimestamps, tcDebug, tcRecompile, tcExtraBackupLevels ;
            , tcClearUniqueID, tcOptimizeByFilestamp, tc_InputFile ;
            , lcConfigFile, llExiste_CFG_EnDisco, laConfig, I, lcConfData, lcExt, lcValue, lc_CFG_Path ;
            , lo_CFG, lo_Configuration, loEx

      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE get_DirSettings
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:       (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcDir             (@? IN    ) Directory whose configuration should be returned
      * tcDebug           (v? IN    ) '1' write debug log (posiibly to GETENV("TEMP") )
      * tcCFG_File        (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
      *                                       Normal inheritance may or may not run, see setting InhibitInheritance
      * RETURN            (@?    OUT) CFG object
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcDir, tcDebug, tcCFG_File

      IF NOT EMPTY(tcDir)
         This.evaluateConfiguration( '', '', '', tcDebug, '', '', '', '', tcDir, 'D', , , tcCFG_File )
      ENDIF

      IF This.n_CFG_Actual = 0 THEN
         loCFG = .NULL.
      ELSE
         loCFG = This.o_Configuration(This.n_CFG_Actual)
      ENDIF

      IF ISNULL(loCFG) THEN
         loCFG   = This.newConfig()
      ENDIF

      RETURN loCFG
   ENDPROC


   PROCEDURE captureFactoryCFG
      *---------------------------------------------------------------------------------------------------
      * Factory CFG template (immutable). Defaults are defined in createCfgShell().
      *---------------------------------------------------------------------------------------------------
      This.o_FactoryCFG = This.createCfgShell()
   ENDPROC


   PROCEDURE createCfgShell
      *---------------------------------------------------------------------------------------------------
      * CFG schema and factory defaults (canonical source for o_FactoryCFG / newConfig).
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
      AddProperty(loCfg, 'l_UseFormsPerDir', .F.)
      AddProperty(loCfg, 'n_CheckFileInPath', 0)
      AddProperty(loCfg, 'l_OldFilesPerDBC', .T.)
      AddProperty(loCfg, 'n_UseFilesPerDBC', 0)
      AddProperty(loCfg, 'l_RedirectFilePerDBCToMain', .F.)
      AddProperty(loCfg, 'l_ItemPerDBCCheck', .F.)
      AddProperty(loCfg, 'l_DBF_BinChar_Base64', .T.)
      AddProperty(loCfg, 'l_DBF_IncludeDeleted', .F.)
      AddProperty(loCfg, 'n_InhibitInheritance', 0)
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
      AddProperty(loCfg, 'l_CopyNonConvertible', .F.)
      AddProperty(loCfg, 'l_CopyExcludedPjxFiles', .F.)
      AddProperty(loCfg, 'l_CopyLowercaseNames', .F.)
      AddProperty(loCfg, 'c_ExcludedSubdirs', '')
      AddProperty(loCfg, 'c_BackgroundImage', '')
      AddProperty(loCfg, 'n_PRG_Compat_Level', 0)
      AddProperty(loCfg, 'n_HomeDir', 1)
      AddProperty(loCfg, 'l_AllowFolder', .T.)

      RETURN loCfg
   ENDPROC


   PROCEDURE getActiveCfg
      *---------------------------------------------------------------------------------------------------
      * Returns the effective CFG object: Mode C lock -> o_MasterCFG; else collection item;
      * else o_MasterCFG; else o_FactoryCFG.
      *---------------------------------------------------------------------------------------------------
      LOCAL loCfg

      IF This.n_CFG_EvaluateFromParam = 1
         IF VARTYPE(This.o_MasterCFG) = 'O' AND !ISNULL(This.o_MasterCFG)
            RETURN This.o_MasterCFG
         ENDIF
      ENDIF

      IF This.n_CFG_Actual > 0 AND This.o_Configuration.Count >= This.n_CFG_Actual
         loCfg = This.o_Configuration( This.n_CFG_Actual )
         IF VARTYPE(loCfg) = 'O' AND !ISNULL(loCfg)
            RETURN loCfg
         ENDIF
      ENDIF

      IF VARTYPE(This.o_MasterCFG) = 'O' AND !ISNULL(This.o_MasterCFG)
         RETURN This.o_MasterCFG
      ENDIF

      RETURN This.o_FactoryCFG
   ENDPROC


   PROCEDURE getCfgValue
      *---------------------------------------------------------------------------------------------------
      * Resolves a configuration property: active CFG -> o_MasterCFG -> o_FactoryCFG.
      * n_InhibitInheritance always reads collection item 1 when present.
      * n_Debug honors runtime override via n_DebugP (command-line parameter).
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcProp
      LOCAL loCfg

      tcProp = ALLTRIM(tcProp)

      IF UPPER(tcProp) == 'N_DEBUG'
         IF !ISNULL(This.o_Host.n_DebugP)
            RETURN This.o_Host.n_DebugP
         ENDIF
      ENDIF

      IF UPPER(tcProp) == 'N_INHIBITINHERITANCE'
         IF This.o_Configuration.Count > 0
            loCfg = This.o_Configuration(1)
            IF VARTYPE(loCfg) = 'O' AND !ISNULL(loCfg) AND PEMSTATUS(loCfg, tcProp, 5)
               RETURN EVALUATE('loCfg.' + tcProp)
            ENDIF
         ENDIF
         IF VARTYPE(This.o_MasterCFG) = 'O' AND PEMSTATUS(This.o_MasterCFG, tcProp, 5)
            RETURN EVALUATE('This.o_MasterCFG.' + tcProp)
         ENDIF
         IF VARTYPE(This.o_FactoryCFG) = 'O' AND PEMSTATUS(This.o_FactoryCFG, tcProp, 5)
            RETURN EVALUATE('This.o_FactoryCFG.' + tcProp)
         ENDIF
         RETURN .NULL.
      ENDIF

      loCfg = This.getActiveCfg()
      IF VARTYPE(loCfg) = 'O' AND PEMSTATUS(loCfg, tcProp, 5)
         RETURN EVALUATE('loCfg.' + tcProp)
      ENDIF

      RETURN .NULL.
   ENDPROC


   PROCEDURE getCfgFlag
      *---------------------------------------------------------------------------------------------------
      * Coerces a configuration property to logical (.T./.F.).
      * Accepts logical, numeric (0/1), and character values from CFG objects or programmatic assignment.
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * Coerces a configuration property to numeric.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcProp, lnDefault
      LOCAL lv

      lv = This.getCfgValue(tcProp)
      IF VARTYPE(lv) = 'N'
         RETURN lv
      ENDIF
      IF VARTYPE(lv) = 'L'
         RETURN IIF(lv, 1, 0)
      ENDIF
      IF ISNULL(lv)
         RETURN EVL(lnDefault, 0)
      ENDIF
      RETURN INT(VAL(TRANSFORM(lv)))
   ENDPROC


   PROCEDURE getCfgObjectForWrite
      *---------------------------------------------------------------------------------------------------
      * CFG object that should receive runtime configuration writes.
      *---------------------------------------------------------------------------------------------------
      LOCAL loCfg

      IF This.n_CFG_EvaluateFromParam = 1
         RETURN This.o_MasterCFG
      ENDIF

      IF This.n_CFG_Actual > 0 AND This.o_Configuration.Count >= This.n_CFG_Actual
         loCfg = This.o_Configuration( This.n_CFG_Actual )
         IF VARTYPE(loCfg) = 'O' AND !ISNULL(loCfg)
            RETURN loCfg
         ENDIF
      ENDIF

      RETURN This.o_MasterCFG
   ENDPROC


   PROCEDURE setCfgValue
      *---------------------------------------------------------------------------------------------------
      * Writes a configuration property to the active CFG (collection item or o_MasterCFG).
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcProp, txVal
      LOCAL loCfg

      loCfg = This.getCfgObjectForWrite()
      IF VARTYPE(loCfg) = 'O' AND PEMSTATUS(loCfg, tcProp, 5)
         STORE txVal TO ( 'loCfg.' + tcProp )
      ENDIF
   ENDPROC


   PROCEDURE isCfg
      *---------------------------------------------------------------------------------------------------
      * Returns .T. when toObj is a configuration object created by newConfig().
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toObj

      RETURN VARTYPE(toObj) = 'O' ;
         AND TYPE('toObj._CFG_Type') = 'C' ;
         AND toObj._CFG_Type == CFG_TYPE_MARKER
   ENDPROC


   PROCEDURE cfgCopyFrom
      *---------------------------------------------------------------------------------------------------
      * Copies configuration properties from toParentCFG into toSourceCFG.
      * Iterates the parent so programmatic/dynamic properties (e.g. l_UseClassPerDir on loCfg)
      * are not dropped when the destination schema is older or missing a key.
      *---------------------------------------------------------------------------------------------------
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
         IF PEMSTATUS(toParentCFG, 'getCfgValue', 5)
            lxVal = toParentCFG.getCfgValue(lcProp)
         ELSE
            IF !PEMSTATUS(toParentCFG, lcProp, 5)
               LOOP
            ENDIF
            lxVal = EVALUATE('toParentCFG.' + lcProp)
         ENDIF
         IF PEMSTATUS(toSourceCFG, lcProp, 5)
            STORE lxVal TO ('toSourceCFG.' + lcProp)
         ELSE
            AddProperty(toSourceCFG, lcProp, lxVal)
         ENDIF
      ENDFOR

      RELEASE laProps, lnCount, I, lcProp, lxVal
   ENDPROC
   PROCEDURE newConfig
      *---------------------------------------------------------------------------------------------------
      * Returns a configuration object cloned from o_FactoryCFG (createCfgShell defaults).
      *---------------------------------------------------------------------------------------------------
      LOCAL loCfg

      loCfg = This.createCfgShell()
      IF VARTYPE(This.o_FactoryCFG) = 'O' AND !ISNULL(This.o_FactoryCFG)
         This.cfgCopyFrom( This.o_FactoryCFG, loCfg )
      ENDIF

      RETURN loCfg
   ENDPROC
   PROCEDURE configFromObject
      *---------------------------------------------------------------------------------------------------
      * Builds a configuration object by copying matching properties by name from any object.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toSource                  (v! IN    ) Object with configuration properties (e.g. l_Recompile, c_VC2, ...)
      * toDestCfg                 (v? IN    ) (Optional) Destination CFG object; default: new blank config
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * Mode C: copy loCfg into o_MasterCFG, discard disk-inherited collection items, and lock
      * resolution to o_MasterCFG (foxbin2prg.cfg next to EXE / project / subfolders are ignored).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toCfg                     (v! IN    ) CFG object (isCfg) with desired settings
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toCfg
      LOCAL I

      IF VARTYPE(toCfg) <> 'O' OR ISNULL(toCfg) OR NOT This.isCfg(toCfg)
         RETURN .F.
      ENDIF

      This.cfgCopyFrom( toCfg, This.o_MasterCFG )
      This.n_CFG_EvaluateFromParam = 1

      *-- Drop disk cfg cache from INIT / prior runs (EXE folder cfg, project tree, etc.)
      FOR I = This.o_Configuration.COUNT TO 1 STEP -1
         This.o_Configuration.REMOVE(I)
      ENDFOR
      This.o_Configuration.ADD( This.o_MasterCFG, 'Personalized-CFG-Object' )
      This.n_CFG_Actual       = 1
      This.l_CFG_CachedAccess = .T.

      This.o_Host.c_Foxbin2prg_ConfigFile = toCfg
      RETURN .T.
   ENDPROC


   PROCEDURE applyConfig
      *---------------------------------------------------------------------------------------------------
      * Applies a configuration object without a .cfg file on disk.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toCfg
      LOCAL loCfg

      IF VARTYPE(toCfg) <> 'O'
         RETURN .F.
      ENDIF

      IF This.isCfg( toCfg )
         loCfg   = toCfg
      ELSE
         loCfg   = This.configFromObject(toCfg)
      ENDIF

      This.o_Host.c_Foxbin2prg_ConfigFile = loCfg
      .lockMasterFromObject( loCfg )
      This.evaluateConfiguration()

      RELEASE loCfg
      RETURN .T.
   ENDPROC
ENDDEFINE
