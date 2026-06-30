#INCLUDE foxbin2prg.h

*---------------------------------------------------------------------------------------------------
* execute() pipeline for FoxBin2Prg (used via c_foxbin2prg.o_Execute).
* Session setup, mode dispatch, batch handlers, teardown — host state via o_Host.
*---------------------------------------------------------------------------------------------------

DEFINE CLASS cl_fb2prg_execute AS Custom
   o_Host = .NULL.

   PROCEDURE Init
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toHost                    (v! IN    ) c_foxbin2prg session that owns this pipeline
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toHost
      This.o_Host = toHost
   ENDPROC


   PROCEDURE Destroy
      This.o_Host = .NULL.
   ENDPROC

   FUNCTION isBinToTextMode
      *---------------------------------------------------------------------------------------------------
      * True when tcType requests binary-to-text conversion (-BIN2PRG / -BIN2TEXT).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcType                     (v? IN    ) execute() type string
      * RETURN                    (v?    OUT) .T. for Bin?Txt mode
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcType
      RETURN ATC('-BIN2PRG', ('-' + tcType)) > 0 ;
         OR ATC('-BIN2TEXT', ('-' + tcType)) > 0
   ENDFUNC


   FUNCTION isTextToBinMode
      *---------------------------------------------------------------------------------------------------
      * True when tcType requests text-to-binary conversion (-PRG2BIN / -TEXT2BIN).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcType                     (v? IN    ) execute() type string
      * RETURN                    (v?    OUT) .T. for Txt?Bin mode
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcType
      RETURN ATC('-PRG2BIN', ('-' + tcType)) > 0 ;
         OR ATC('-TEXT2BIN', ('-' + tcType)) > 0
   ENDFUNC


   PROCEDURE restoreEscapeKey
      *---------------------------------------------------------------------------------------------------
      * Restores ON ESCAPE / SET ESCAPE after execute() when ESC cancel was enabled.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * llEscKeyRestored           (v! IN    ) .T. if ESC was never overridden
      * lcOldSetEscape             (v? IN    ) Previous SET('Escape') value
      * lcOldOnEscape              (v? IN    ) Previous ON ESCAPE expression
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS llEscKeyRestored, lcOldSetEscape, lcOldOnEscape
      LOCAL loHost
      loHost = This.o_Host
      IF NOT llEscKeyRestored AND loHost.l_CancelWithEscKey THEN
         IF EMPTY(lcOldOnEscape)
            ON ESCAPE
         ELSE
            ON ESCAPE &lcOldOnEscape
         ENDIF
         IF EMPTY(lcOldSetEscape)
            SET ESCAPE OFF
         ELSE
            SET ESCAPE &lcOldSetEscape
         ENDIF
      ENDIF
   ENDPROC


   FUNCTION mergeExecuteConfig
      *---------------------------------------------------------------------------------------------------
      * Applies optional toCfg to session CFG via o_Cfg.lockMasterFromObject.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toCfg                      (v? IN    ) CFG object (newConfig) or duck-typed source
      * RETURN                    (v?    OUT) Effective CFG object passed to execute(), or .NULL.
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS toCfg
      LOCAL loHost, loCFG
      loHost = This.o_Host
      loCFG = .NULL.
      loHost.ensureCfg()
      IF VARTYPE(toCfg) = "O" AND !ISNULL(toCfg)
         IF loHost.isCfg( toCfg )
            loCFG = toCfg
         ELSE
            loCFG = loHost.configFromObject( toCfg )
         ENDIF
         loHost.o_Cfg.lockMasterFromObject( loCFG )
      ENDIF
      RETURN loCFG
   ENDFUNC


   PROCEDURE beginExecuteSession
      *---------------------------------------------------------------------------------------------------
      * execute() setup: NOTIFY OFF, DLL declare, ESC handler, clear processed files.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loSession                  (@! IN/OUT) Empty object; fields filled for finalizeExecuteSession
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loSession
      LOCAL loHost
      loHost = This.o_Host
      WITH loHost
         loSession.lc_OldSetNotify  = SET("Notify")
         SET NOTIFY OFF
         .declareDLL()
         loSession.llEscKeyRestored = .T.
         loSession.lcOldSetEscape   = ''
         loSession.lcOldOnEscape    = ''
         IF .l_CancelWithEscKey THEN
            loSession.lcOldSetEscape = SET("Escape")
            loSession.lcOldOnEscape  = ON("Escape")
            ON ESCAPE ERROR 1799
            SET ESCAPE ON
            loSession.llEscKeyRestored = .F.
         ENDIF
         IF .l_AutoClearProcessedFiles THEN
            .clearProcessedFiles()
         ENDIF
         .l_Error = .F.
      ENDWITH
   ENDPROC


   PROCEDURE validateExecuteEnvironment
      *---------------------------------------------------------------------------------------------------
      * Raises ERROR if VFP version or tcType is invalid for execute().
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lnVFPVersion               (v! IN    ) Val(Version(5))
      * tcType                     (v? IN    ) execute() type parameter
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS lnVFPVersion, tcType
      LOCAL loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      DO CASE
      CASE lnVFPVersion = 900 AND Int( Val( Substr( Version(4), Rat('.', Version(4)) + 1 ) ) ) < 3504
         ERROR loLang.C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC
      CASE lnVFPVersion < 900
         ERROR loLang.C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC
      CASE '\' $ tcType
         ERROR loLang.C_INVALID_PARAMETER_LOC + ':' + CR_LF ;
            + 'tcType = "' + tcType + '"' + CR_LF ;
            + CR_LF ;
            + loLang.C_ALLOWED_VALUES_ARE_LOC + ': ' + CR_LF ;
            + '*, *-, Bin3Prg, Prg3Bin, -BIN2PRG, -PRG2BIN'
      ENDCASE
   ENDPROC


   FUNCTION parseClassOperationSyntax
      *---------------------------------------------------------------------------------------------------
      * Parses file.vcx::class|I/E syntax; sets c_ClassToConvert and c_ClassOperationType.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (@! IN/OUT) Input path; normalized on return
      * RETURN                    (v?    OUT) Normalized tc_InputFile
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tc_InputFile
      LOCAL loHost
      loHost = This.o_Host
      IF '::' $ tc_InputFile THEN
         tc_InputFile = STRTRAN(tc_InputFile, '::', '|')
         loHost.c_ClassOperationType = Evl( Upper( Left( Alltrim( GetWordNum( tc_InputFile, 3, '|' ) ), 1) ), 'E')
         loHost.c_ClassToConvert     = Lower( Alltrim( GetWordNum( tc_InputFile, 2, '|' ) ) )
         tc_InputFile = Lower( Alltrim( GetWordNum( tc_InputFile, 1, '|' ) ) )
      ELSE
         loHost.c_ClassOperationType = ''
      ENDIF
      RETURN tc_InputFile
   ENDFUNC


   FUNCTION detectInputFileType
      *---------------------------------------------------------------------------------------------------
      * Returns C_FILETYPE_DIRECTORY or C_FILETYPE_FILE for execute() routing.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (v? IN    ) Input path
      * RETURN                    (v?    OUT) C_FILETYPE_* constant or empty
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tc_InputFile
      LOCAL laDirInfo(1,5), lcInputFile_Type
      lcInputFile_Type = ''
      IF NOT EMPTY(tc_InputFile)
         IF ADIR(laDirInfo, JustPath(tc_InputFile), "D") = 1 AND Substr( laDirInfo(1,5), 5, 1 ) = "D"
            lcInputFile_Type = C_FILETYPE_DIRECTORY
         ELSE
            lcInputFile_Type = C_FILETYPE_FILE
         ENDIF
      ENDIF
      RETURN lcInputFile_Type
   ENDFUNC


   FUNCTION resolveRecompileTarget
      *---------------------------------------------------------------------------------------------------
      * Derives tcRecompile and loHost.c_Recompile from input type and CFG l_Recompile.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (v? IN    ) Input path
      * lcInputFile_Type           (v? IN    ) C_FILETYPE_* from detectInputFileType
      * tcRecompile                (v? IN/OUT) Recompile flag or directory
      * RETURN                    (v?    OUT) Effective tcRecompile string
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tc_InputFile, lcInputFile_Type, tcRecompile
      LOCAL loHost
      loHost = This.o_Host
      IF EMPTY(tcRecompile) AND NOT EMPTY(lcInputFile_Type)
         IF lcInputFile_Type == C_FILETYPE_DIRECTORY
            tcRecompile = tc_InputFile
         ELSE
            tcRecompile = JUSTPATH( tc_InputFile )
         ENDIF
      ENDIF
      IF loHost.getCfgFlag('l_Recompile', .T.)
         tcRecompile = EVL(tcRecompile, '1')
      ELSE
         tcRecompile = '0'
      ENDIF
      loHost.c_Recompile = tcRecompile
      RETURN tcRecompile
   ENDFUNC


   PROCEDURE logExecuteParameters
      *---------------------------------------------------------------------------------------------------
      * Writes execute() external parameters block to session debug log.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (v? IN    ) Input file/directory
      * lcType                     (v? IN    ) Normalized tcType
      * toCfg                      (v? IN    ) Optional CFG object
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tc_InputFile, lcType, toCfg
      LOCAL loHost, loLang AS CL_LANG OF 'cl_lang.prg'
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      WITH loHost
         .writeLog( REPLICATE( '*', 100 ) )
         .writeLog( loLang.C_MAIN_EXECUTION_LOC, 2 )
         .writeLog( REPLICATE( '*', 100 ) )
         .writeLog( '> ' + loLang.C_EXTERNAL_PARAMETERS_LOC + ':' )
         .writeLog( C_TAB + 'tc_InputFile:                 ' + TRANSFORM( EVL(tc_InputFile, '(empty)' ) ) )
         .writeLog( C_TAB + 'tcType:                       ' + TRANSFORM( EVL(lcType, '(empty)' ) ) )
         .writeLog( C_TAB + 'toCfg:                        ' + TRANSFORM( IIF(VARTYPE(toCfg)='O' AND !ISNULL(toCfg), '(object)', '(empty)' ) ) )
         .writeLog( )
      ENDWITH
   ENDPROC

   FUNCTION buildExecuteContext
      *---------------------------------------------------------------------------------------------------
      * Builds loCtx empty object with normalized execute() state for dispatch handlers.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (v? IN    ) Input path
      * tcType                     (v? IN    ) Type string
      * lcType                     (v? IN    ) Upper/normalized type
      * loCFG                      (v? IN    ) Effective CFG object
      * tcRecompile                (v? IN    ) Recompile target
      * lcInputFile_Type           (v? IN    ) C_FILETYPE_*
      * tcOriginalFileName         (v? IN    ) Original name for headers
      * tcTextName                 (v? IN    ) Mirror/text output folder alias
      * RETURN                    (v?    OUT) loCtx object
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tc_InputFile, tcType, lcType, loCFG, tcRecompile, lcInputFile_Type, tcOriginalFileName, tcTextName
      LOCAL loCtx
      loCtx = CREATEOBJECT('Empty')
      ADDPROPERTY(loCtx, 'tc_InputFile',       tc_InputFile)
      ADDPROPERTY(loCtx, 'tcType',             tcType)
      ADDPROPERTY(loCtx, 'lcType',             lcType)
      ADDPROPERTY(loCtx, 'loCFG',              loCFG)
      ADDPROPERTY(loCtx, 'tcRecompile',        tcRecompile)
      ADDPROPERTY(loCtx, 'lcInputFile_Type',   lcInputFile_Type)
      ADDPROPERTY(loCtx, 'tcOriginalFileName', tcOriginalFileName)
      ADDPROPERTY(loCtx, 'tcTextName',         tcTextName)
      ADDPROPERTY(loCtx, 'lBinToText',         This.isBinToTextMode(tcType))
      ADDPROPERTY(loCtx, 'lTextToBin',         This.isTextToBinMode(tcType))
      RETURN loCtx
   ENDFUNC


   FUNCTION resolveExecuteMode
      *---------------------------------------------------------------------------------------------------
      * Maps input path, type and support flags to C_EXEC_* dispatch constant.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcType                     (v? IN    ) execute() type
      * tc_InputFile               (v? IN    ) Input path
      * lcInputFile_Type           (v? IN    ) C_FILETYPE_*
      * RETURN                    (v?    OUT) C_EXEC_* mode constant
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcType, tc_InputFile, lcInputFile_Type
      LOCAL loHost, laDirInfo(1,5)
      loHost = This.o_Host
      IF VERSION(5) < 900
         RETURN C_EXEC_VFP8_WARN
      ENDIF
      IF tcType == 'BIN3PRG'
         RETURN C_EXEC_BIN3PRG
      ENDIF
      IF tcType == 'PRG3BIN'
         RETURN C_EXEC_PRG3BIN
      ENDIF
      IF EMPTY(tc_InputFile)
         RETURN C_EXEC_EMPTY_UI
      ENDIF
      IF NOT This.isBinToTextMode(tcType) AND NOT This.isTextToBinMode(tcType) ;
            AND lcInputFile_Type == C_FILETYPE_FILE ;
            AND ( '*' $ JUSTEXT( tc_InputFile ) OR '?' $ JUSTEXT( tc_InputFile ) )
         RETURN C_EXEC_WILDCARD_ERROR
      ENDIF
      IF lcInputFile_Type == C_FILETYPE_FILE ;
            AND ( '*' $ JUSTSTEM( tc_InputFile ) OR '?' $ JUSTSTEM( tc_InputFile ) )
         RETURN C_EXEC_WILDCARD
      ENDIF
      IF This.isBinToTextMode(tcType) AND lcInputFile_Type == C_FILETYPE_DIRECTORY
         RETURN C_EXEC_DIR_BIN2PRG
      ENDIF
      IF This.isTextToBinMode(tcType) AND lcInputFile_Type == C_FILETYPE_DIRECTORY
         RETURN C_EXEC_DIR_PRG2BIN
      ENDIF
      IF UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == 'PJX' AND LEFT(EVL(tcType,'0'),1) == '*'
         RETURN C_EXEC_PROJECT_PJX
      ENDIF
      IF UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == loHost.getCfgValue('c_PJ2') AND LEFT(EVL(tcType,'0'),1) == '*'
         RETURN C_EXEC_PROJECT_PJ2
      ENDIF
      IF This.isBinToTextMode(tcType) ;
            AND ( NOT loHost.hasSupport_Bin2Prg( tc_InputFile ) OR NOT ADIR(laDirInfo, tc_InputFile) > 0 )
         RETURN C_EXEC_UNSUPPORTED_BIN2PRG
      ENDIF
      IF This.isTextToBinMode(tcType) ;
            AND ( NOT loHost.hasSupport_Prg2Bin( tc_InputFile ) OR NOT ADIR(laDirInfo, tc_InputFile) > 0 )
         RETURN C_EXEC_UNSUPPORTED_PRG2BIN
      ENDIF
      RETURN C_EXEC_SINGLE_FILE
   ENDFUNC


   PROCEDURE prepareBatchLog
      *---------------------------------------------------------------------------------------------------
      * Sets loHost.c_LogFile for directory/wildcard batch and optionally erases prior log.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcLogPath                  (v! IN    ) Full path of batch .LOG file
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcLogPath
      LOCAL loHost
      loHost = This.o_Host
      loHost.c_LogFile = tcLogPath
      IF loHost.getCfgValue('n_Debug') > 0 THEN
         ERASE ( loHost.c_LogFile )
      ENDIF
   ENDPROC


   PROCEDURE setRecompileDirectory
      *---------------------------------------------------------------------------------------------------
      * CD to recompile base directory according to tcRecompile and CFG l_Recompile.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcRecompile                (v? IN    ) '1', directory path, or '0'
      * tcDefaultPath              (v! IN    ) Default directory when tcRecompile = '1'
      * tlUseRecompileCfg          (v? IN    ) .T. for directory batch (honor CFG path rules)
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcRecompile, tcDefaultPath, tlUseRecompileCfg
      LOCAL loHost
      loHost = This.o_Host
      DO CASE
      CASE loHost.getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
         CD (tcRecompile)
      CASE tlUseRecompileCfg AND loHost.getCfgValue('l_Recompile')
         CD (tcDefaultPath)
      CASE tcRecompile == '1'
         CD (tcDefaultPath)
      ENDCASE
   ENDPROC


   FUNCTION handleConvertResult
      *---------------------------------------------------------------------------------------------------
      * Central convert() error handling for batch modes; may accumulate errors without abort.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lnCodError                 (v! IN    ) convert() return code
      * toEx                       (@? IN    ) Exception object
      * tlAccumulateError          (v? IN    ) .T. = set batch error flag instead of aborting
      * RETURN                    (v?    OUT) .T. when batch should mark l_Error
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS lnCodError, toEx, tlAccumulateError
      LOCAL loHost, llBatchError
      loHost = This.o_Host
      llBatchError = .F.
      DO CASE
      CASE lnCodError = 1799
         ERROR 1799
      CASE lnCodError > 0
         loHost.ensureLogger()
         loHost.o_Logger.doWriteErrorLog( @toEx )
         IF tlAccumulateError
            llBatchError = .T.
            loHost.l_Error = .F.
         ENDIF
      ENDCASE
      RETURN llBatchError
   ENDFUNC


   FUNCTION runConvertWithProgress
      *---------------------------------------------------------------------------------------------------
      * Updates progress bar, calls convert(), optionally flushes log.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lcFile                     (v! IN    ) File being converted
      * tnIndex                    (v! IN    ) Current index in batch
      * tnTotal                    (v! IN    ) Total files in batch
      * tlRelanzarError            (v? IN    ) Passed to convert()
      * tcOriginalFileName         (v? IN    ) Original name for headers
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * tlFlushLog                 (v? IN    ) .T. = writeLog_Flush after convert
      * RETURN                    (v?    OUT) convert() error code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS lcFile, tnIndex, tnTotal, tlRelanzarError, tcOriginalFileName, toModulo, toEx, tlFlushLog
      LOCAL loHost, lnCodError, loLang AS CL_LANG OF 'cl_lang.prg'
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      loHost.updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', tnIndex, tnTotal, 0 )
      lnCodError = loHost.convert( lcFile, @toModulo, @toEx, tlRelanzarError, tcOriginalFileName )
      IF tlFlushLog
         loHost.writeLog_Flush()
      ENDIF
      RETURN lnCodError
   ENDFUNC


   PROCEDURE setupDirectionProgressUI
      *---------------------------------------------------------------------------------------------------
      * Logs BIN2PRG/PRG2BIN option and loads progress form with direction caption.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tlBinToText                (v! IN    ) .T. = Bin?Txt batch
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tlBinToText
      LOCAL loHost, loLang AS CL_LANG OF 'cl_lang.prg'
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      IF tlBinToText
         loHost.writeLog( '> ' + loLang.C_OPTION_LOC + ': BIN2PRG' )
      ELSE
         loHost.writeLog( '> ' + loLang.C_OPTION_LOC + ': PRG2BIN' )
      ENDIF
      IF loHost.getCfgValue('n_ShowProgressbar') <> 0 AND loHost.l_ProcessFiles THEN
         loHost.loadProgressbarForm()
         IF tlBinToText
            loHost.o_Frm_Avance.CAPTION = STRTRAN( loHost.o_Frm_Avance.CAPTION, '> -', '(Bin>Txt) -' )
         ELSE
            loHost.o_Frm_Avance.CAPTION = STRTRAN( loHost.o_Frm_Avance.CAPTION, '> -', '(Txt>Bin) -' )
         ENDIF
      ENDIF
   ENDPROC


   FUNCTION executeEmptyUI
      *---------------------------------------------------------------------------------------------------
      * Shows frm_main configuration reference when execute() receives empty input.
      * RETURN                    (v?    OUT) 0
      *---------------------------------------------------------------------------------------------------

      LOCAL loHost, loFrm_Main AS frm_main OF 'frm_main.PRG'
      loHost = This.o_Host
      loFrm_Main = NewObject( 'frm_main', 'frm_main.prg' , null, loHost)
      loFrm_Main.SHOW()
      READ EVENTS
      RETURN 0
   ENDFUNC


   FUNCTION executeBin3Prg
      *---------------------------------------------------------------------------------------------------
      * Bin3Prg handler: validates PJX + mirror root, delegates to exportProjectTree.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Context from buildExecuteContext
      * RETURN                    (v?    OUT) execute() return code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx
      LOCAL loHost, lcMirrorRoot, loLang AS CL_LANG OF 'cl_lang.prg', loCfgPass
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lcMirrorRoot = EVL(loHost.cOutputFolder, loCtx.tcTextName)
      IF NOT EMPTY(lcMirrorRoot)
         lcMirrorRoot = loHost.get_AbsolutePath(lcMirrorRoot, loHost.c_CurDir)
      ENDIF
      IF EMPTY(lcMirrorRoot)
         ERROR loLang.C_INVALID_PARAMETER_LOC + ': Bin3Prg requires tcTextName or tcOutputFolder'
      ENDIF
      IF UPPER(JUSTEXT(loCtx.tc_InputFile)) <> 'PJX'
         ERROR loLang.C_INVALID_PARAMETER_LOC + ': Bin3Prg requires a .PJX project file'
      ENDIF
      loCfgPass = IIF(VARTYPE(loCtx.loCFG) = 'O' AND !ISNULL(loCtx.loCFG), loCtx.loCFG, .NULL.)
      RETURN loHost.exportProjectTree(loCtx.tc_InputFile, lcMirrorRoot, loCfgPass)
   ENDFUNC


   FUNCTION executePrg3Bin
      *---------------------------------------------------------------------------------------------------
      * Prg3Bin handler: validates PJ2 + mirror root, delegates to importProjectTree.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Context from buildExecuteContext
      * RETURN                    (v?    OUT) execute() return code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx
      LOCAL loHost, lcMirrorRoot, loLang AS CL_LANG OF 'cl_lang.prg', loCfgPass
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lcMirrorRoot = EVL(loHost.cOutputFolder, loCtx.tcTextName)
      IF NOT EMPTY(lcMirrorRoot)
         lcMirrorRoot = loHost.get_AbsolutePath(lcMirrorRoot, loHost.c_CurDir)
      ENDIF
      IF EMPTY(lcMirrorRoot)
         ERROR loLang.C_INVALID_PARAMETER_LOC + ': Prg3Bin requires tcTextName or tcOutputFolder'
      ENDIF
      IF UPPER(JUSTEXT(loCtx.tc_InputFile)) <> UPPER(loHost.getCfgValue('c_PJ2'))
         ERROR loLang.C_INVALID_PARAMETER_LOC + ': Prg3Bin requires a .' + loHost.getCfgValue('c_PJ2') + ' project file'
      ENDIF
      loCfgPass = IIF(VARTYPE(loCtx.loCFG) = 'O' AND !ISNULL(loCtx.loCFG), loCtx.loCFG, .NULL.)
      RETURN loHost.importProjectTree(loCtx.tc_InputFile, lcMirrorRoot, loCfgPass)
   ENDFUNC


   FUNCTION executeWildcardBatch
      *---------------------------------------------------------------------------------------------------
      * Processes a wildcard file specification (ADIR loop) including optional full PJX/PJ2.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Execute context
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * RETURN                    (v?    OUT) Last convert() error code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx, toEx, toModulo
      LOCAL loHost, I, lcFileSpec, lcFile, lnFileCount, lnCodError, llError, laFiles(1,5), loLang AS CL_LANG OF 'cl_lang.prg'
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lnCodError = 0
      llError = .F.
      lcFileSpec = FULLPATH( loCtx.tc_InputFile )
      This.prepareBatchLog( ADDBS( JUSTPATH( lcFileSpec ) ) + STRTRAN( JUSTFNAME( lcFileSpec ), '*', '_ALL' ) + '.LOG' )
      IF EVL(loCtx.tcType,'0') <> '*' THEN
         IF loHost.getCfgValue('n_ShowProgressbar') <> 0 AND loHost.l_ProcessFiles THEN
            loHost.loadProgressbarForm()
         ENDIF
         This.setRecompileDirectory( loCtx.tcRecompile, JUSTPATH(lcFileSpec), .F. )
      ENDIF
      lnFileCount = ADIR( laFiles, lcFileSpec, '', 1 )
      FOR I = 1 TO lnFileCount
         toModulo = .NULL.
         lcFile = FORCEPATH( laFiles(m.I,1), JUSTPATH( lcFileSpec ) )
         DO CASE
         CASE UPPER( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) ) == 'PJX' AND LEFT(EVL(loCtx.tcType,'0'),1) == '*'
            loHost.evaluate_Full_PJX(lcFile, loCtx.tcRecompile, @toModulo, @toEx, loCtx.tcOriginalFileName, loHost.c_LogFile, loCtx.tcType)
         CASE UPPER( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) ) == loHost.getCfgValue('c_PJ2') AND LEFT(EVL(loCtx.tcType,'0'),1) == '*'
            loHost.evaluate_Full_PJ2(lcFile, loCtx.tcRecompile, @toModulo, @toEx, loCtx.tcOriginalFileName, loHost.c_LogFile, loCtx.tcType)
         CASE loCtx.lBinToText
            IF loHost.hasSupport_Bin2Prg(lcFile) THEN
               lnCodError = This.runConvertWithProgress( lcFile, m.I, lnFileCount, .F., loCtx.tcOriginalFileName, @toModulo, @toEx, .T. )
               llError = llError OR This.handleConvertResult( lnCodError, @toEx, .T. )
            ENDIF
         CASE loCtx.lTextToBin
            IF loHost.hasSupport_Prg2Bin(lcFile) THEN
               lnCodError = This.runConvertWithProgress( lcFile, m.I, lnFileCount, .F., loCtx.tcOriginalFileName, @toModulo, @toEx, .T. )
               llError = llError OR This.handleConvertResult( lnCodError, @toEx, .T. )
            ENDIF
         CASE EMPTY( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) )
            ERROR loLang.C_INVALID_PARAMETER_LOC + ': cInputFile = "' + loCtx.tc_InputFile + '"'
         OTHERWISE
            lnCodError = This.runConvertWithProgress( lcFile, m.I, lnFileCount, .T., loCtx.tcOriginalFileName, @toModulo, @toEx, .T. )
            This.handleConvertResult( lnCodError, @toEx, .F. )
         ENDCASE
      ENDFOR
      IF llError
         loHost.l_Error = .T.
      ENDIF
      RETURN lnCodError
   ENDFUNC


   FUNCTION executeDirectoryBatch
      *---------------------------------------------------------------------------------------------------
      * Recursively converts all supported files under a directory.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Execute context
      * tlBinToText                (v! IN    ) Batch direction
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * RETURN                    (v?    OUT) Last convert() error code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx, tlBinToText, toEx, toModulo
      LOCAL loHost, I, lcFile, lnFileCount, lnCodError, laFiles(1,5), laDirInfo(1,5), loLang AS CL_LANG OF 'cl_lang.prg'
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lnCodError = 0
      This.setupDirectionProgressUI( tlBinToText )
      loHost.writeLog( '> InputFile ' + loLang.C_IS_A_DIRECTORY_LOC )
      loHost.writeLog()
      This.setRecompileDirectory( loCtx.tcRecompile, loCtx.tc_InputFile, .T. )
      This.prepareBatchLog( ADDBS(loCtx.tc_InputFile) + loCtx.tcType + '.LOG' )
      loHost.get_FilesFromDirectory( loCtx.tc_InputFile, @laFiles, @lnFileCount )
      FOR I = 1 TO lnFileCount
         toModulo = .NULL.
         lcFile = laFiles(m.I)
         IF tlBinToText
            IF NOT loHost.hasSupport_Bin2Prg( lcFile ) OR NOT ADIR(laDirInfo, lcFile) > 0
               LOOP
            ENDIF
         ELSE
            IF NOT loHost.hasSupport_Prg2Bin( lcFile ) OR NOT ADIR(laDirInfo, lcFile) > 0
               LOOP
            ENDIF
         ENDIF
         lnCodError = This.runConvertWithProgress( lcFile, m.I, lnFileCount, .F., loCtx.tcOriginalFileName, @toModulo, @toEx, .F. )
         This.handleConvertResult( lnCodError, @toEx, .F. )
      ENDFOR
      loHost.writeLog_Flush()
      loHost.updateProgressbar( loLang.C_END_OF_PROCESS_LOC, lnFileCount, lnFileCount, 0 )
      RETURN lnCodError
   ENDFUNC


   FUNCTION executeSingleProject
      *---------------------------------------------------------------------------------------------------
      * Converts full PJX or PJ2 project via evaluate_Full_PJX / evaluate_Full_PJ2.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Execute context
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * RETURN                    (v?    OUT) 0
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx, toEx, toModulo
      LOCAL loHost, tcOriginalFileName
      loHost = This.o_Host
      tcOriginalFileName = loCtx.tcOriginalFileName
      IF UPPER( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) ) == 'PJX' AND LEFT(EVL(loCtx.tcType,'0'),1) == '*'
         loHost.evaluate_Full_PJX(loCtx.tc_InputFile, loCtx.tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', loCtx.tcType)
         loCtx.tcOriginalFileName = tcOriginalFileName
         RETURN 0
      ENDIF
      IF UPPER( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) ) == loHost.getCfgValue('c_PJ2') AND LEFT(EVL(loCtx.tcType,'0'),1) == '*'
         loHost.evaluate_Full_PJ2(loCtx.tc_InputFile, loCtx.tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', loCtx.tcType)
         loCtx.tcOriginalFileName = tcOriginalFileName
         RETURN 0
      ENDIF
      RETURN 0
   ENDFUNC


   FUNCTION executeSingleFile
      *---------------------------------------------------------------------------------------------------
      * Converts one supported file through convert().
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Execute context
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * RETURN                    (v?    OUT) convert() error code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx, toEx, toModulo
      LOCAL loHost, laDirInfo(1,5), lnCodError, loLang AS CL_LANG OF 'cl_lang.prg'
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lnCodError = 0
      IF loCtx.lBinToText OR loCtx.lTextToBin
         This.setupDirectionProgressUI( loCtx.lBinToText )
      ENDIF
      IF ADIR(laDirInfo, loCtx.tc_InputFile) > 0
         IF loHost.getCfgValue('n_ShowProgressbar') <> 0 AND loHost.l_ProcessFiles THEN
            loHost.loadProgressbarForm()
         ENDIF
         loHost.writeLog( '> InputFile ' + loLang.C_IS_A_FILE_LOC )
         loHost.writeLog()
         loCtx.tc_InputFile = LOCFILE(loCtx.tc_InputFile)
         This.setRecompileDirectory( loCtx.tcRecompile, JUSTPATH(loCtx.tc_InputFile), .F. )
         This.prepareBatchLog( loCtx.tc_InputFile + '.LOG' )
         lnCodError = loHost.convert( loCtx.tc_InputFile, @toModulo, @toEx, .T., loCtx.tcOriginalFileName )
      ENDIF
      RETURN lnCodError
   ENDFUNC


   FUNCTION executeUnsupportedInput
      *---------------------------------------------------------------------------------------------------
      * Logs unsupported input type for explicit Bin2Prg/Prg2Bin directory-less requests.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tlBinToText                (v! IN    ) .T. = unsupported Bin?Txt
      * RETURN                    (v?    OUT) 0
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tlBinToText
      LOCAL loHost, loLang AS CL_LANG OF 'cl_lang.prg'
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      IF tlBinToText
         This.setupDirectionProgressUI( .T. )
      ELSE
         This.setupDirectionProgressUI( .F. )
      ENDIF
      loHost.writeLog( '> InputFile ' + loLang.C_IS_A_UNSUPPORTED_LOC )
      loHost.writeLog()
      RETURN 0
   ENDFUNC


   FUNCTION dispatchExecuteMode
      *---------------------------------------------------------------------------------------------------
      * Central DO CASE router for execute(); delegates to mode-specific handlers.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lnMode                     (v! IN    ) C_EXEC_* constant from resolveExecuteMode
      * loCtx                      (v! IN    ) Execute context
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * RETURN                    (v?    OUT) Handler return / error code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS lnMode, loCtx, toEx, toModulo
      LOCAL loHost, loLang AS CL_LANG OF 'cl_lang.prg'
      loHost = This.o_Host
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      DO CASE
      CASE lnMode = C_EXEC_VFP8_WARN
         MESSAGEBOX( loLang.C_FOXBIN2PRG_JUST_VFP_9_LOC, 0+64+4096, ;
            'FoxBin2Prg ' + loHost.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_WARN_CAPTION_LOC + ' (' + loHost.c_Language + ')', 60000 )
         RETURN 1
      CASE lnMode = C_EXEC_BIN3PRG
         RETURN This.executeBin3Prg( loCtx )
      CASE lnMode = C_EXEC_PRG3BIN
         RETURN This.executePrg3Bin( loCtx )
      CASE lnMode = C_EXEC_EMPTY_UI
         RETURN This.executeEmptyUI()
      CASE lnMode = C_EXEC_WILDCARD_ERROR
         IF loHost.getCfgValue('l_ShowErrors')
            MESSAGEBOX( loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC, 0+48+4096, ;
               'FoxBin2Prg ' + loHost.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_ERROR_CAPTION_LOC, 60000 )
            RETURN 0
         ELSE
            ERROR loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC
         ENDIF
      CASE lnMode = C_EXEC_WILDCARD
         RETURN This.executeWildcardBatch( loCtx, @toEx, @toModulo )
      CASE lnMode = C_EXEC_DIR_BIN2PRG
         RETURN This.executeDirectoryBatch( loCtx, .T., @toEx, @toModulo )
      CASE lnMode = C_EXEC_DIR_PRG2BIN
         RETURN This.executeDirectoryBatch( loCtx, .F., @toEx, @toModulo )
      CASE lnMode = C_EXEC_PROJECT_PJX OR lnMode = C_EXEC_PROJECT_PJ2
         RETURN This.executeSingleProject( loCtx, @toEx, @toModulo )
      CASE lnMode = C_EXEC_UNSUPPORTED_BIN2PRG
         RETURN This.executeUnsupportedInput( .T. )
      CASE lnMode = C_EXEC_UNSUPPORTED_PRG2BIN
         RETURN This.executeUnsupportedInput( .F. )
      CASE lnMode = C_EXEC_SINGLE_FILE
         RETURN This.executeSingleFile( loCtx, @toEx, @toModulo )
      ENDCASE
      RETURN 0
   ENDFUNC


   PROCEDURE enrichExecuteException
      *---------------------------------------------------------------------------------------------------
      * Appends FoxBin2Prg context lines to Exception.USERVALUE before error display.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toEx                       (@! IN/OUT) Exception object
      * tcType                     (v? IN    ) execute() type
      * tc_InputFile               (v? IN    ) Input path
      * lcInputFile_Type           (v? IN    ) C_FILETYPE_*
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS toEx, tcType, tc_InputFile, lcInputFile_Type
      LOCAL loHost
      loHost = This.o_Host

      IF toEx.ERRORNO <> 1799
         toEx.USERVALUE = toEx.USERVALUE + 'FoxBin2Prg: [' + loHost.c_Foxbin2prg_FullPath + '] (EXE Version: ' + loHost.c_FB2PRG_EXE_Version + ')' + CR_LF
      ENDIF

      IF ATC('-SHOWMSG', ('-' + tcType)) > 0
         IF toEx.ERRORNO <> 1799
            toEx.USERVALUE = toEx.USERVALUE + 'lcInputFile_Type  = [' + TRANSFORM(lcInputFile_Type) + ']' + CR_LF
         ENDIF
         loHost.setCfgValue( 'l_ShowErrors', .F. )
      ENDIF

      IF toEx.ERRORNO <> 1799
         toEx.USERVALUE = toEx.USERVALUE + 'tc_InputFile = [' + TRANSFORM(tc_InputFile) + ']' + CR_LF
      ENDIF
   ENDPROC



   FUNCTION finalizeExecuteSession
      *---------------------------------------------------------------------------------------------------
      * execute() teardown: restore ESC/NOTIFY, flush logs, message boxes, clear CFG cache.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lnCodError                 (v? IN/OUT) Error code; may be adjusted
      * tcType                     (v? IN    ) execute() type
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * loSession                  (v! IN    ) Session state from beginExecuteSession
      * loLang                     (v? IN    ) CL_LANG instance
      * laDirInfo                  (@? IN/OUT) ADIR scratch for error log file check (pass @)
      * RETURN                    (v?    OUT) Final lnCodError
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS lnCodError, tcType, toEx, loSession, loLang, laDirInfo
      LOCAL loHost
      loHost = This.o_Host

      EXTERNAL ARRAY laDirInfo

      LOCAL loLangLocal AS CL_LANG OF 'cl_lang.prg'
      LOCAL lcOldNotify

      IF VARTYPE(loLang) <> 'O'
         loLangLocal = NewObject("CL_LANG", "cl_lang.prg", null, "EN")
      ELSE
         loLangLocal = loLang
      ENDIF

      This.restoreEscapeKey( loSession.llEscKeyRestored, loSession.lcOldSetEscape, loSession.lcOldOnEscape )

      USE IN (SELECT("TABLABIN"))

      loHost.writeLog_Flush()
      loHost.unloadProgressbarForm()

      CD (JUSTPATH(loHost.c_CurDir))

      * Soft conversor errors (e.g. duplicate objects) set l_Errors but leave lnCodError = 0.
      IF loHost.l_Errors
         loHost.writeErrorLog_Flush()
      ENDIF

      IF      ATC('-SHOWMSG', ('-' + tcType)) > 0 ;
         OR loHost.getCfgValue('l_ShowErrors') AND ( ;
            (lnCodError > 0 AND NOT ISNULL(toEx)) ;
            OR (EMPTY(lnCodError) AND loHost.l_Errors) ;
         )

         DO CASE
         CASE lnCodError = 1098
            MESSAGEBOX( toEx.MESSAGE, 0+64+4096, 'FoxBin2Prg ' + loHost.c_FB2PRG_EXE_Version, 60000 )
            loHost.wscriptshell_run( loHost.c_ErrorLogFile, 3 )

         CASE lnCodError = 1799
            MESSAGEBOX( loLangLocal.C_CONVERSION_CANCELLED_BY_USER_LOC + '!', 0+64+4096, 'FoxBin2Prg ' + loHost.c_FB2PRG_EXE_Version, 60000 )

         CASE loHost.l_Errors
            IF ADIR(laDirInfo, loHost.c_ErrorLogFile) > 0 THEN
               MESSAGEBOX( loLangLocal.C_END_OF_PROCESS_LOC + '! (' + loLangLocal.C_WITH_ERRORS_LOC + ')', 0+48+4096, 'FoxBin2Prg ' + loHost.c_FB2PRG_EXE_Version, 60000 )
               loHost.wscriptshell_run( loHost.c_ErrorLogFile, 3 )
            ELSE
               MESSAGEBOX( loLangLocal.C_END_OF_PROCESS_LOC + '! (' + loLangLocal.C_WITH_ERRORS_LOC + ')' + CR_LF + "[Warning: Can't show Error LOG file because does not exist!]", 0+48+4096, 'FoxBin2Prg ' + loHost.c_FB2PRG_EXE_Version, 60000 )
            ENDIF

         OTHERWISE
            MESSAGEBOX( loLangLocal.C_END_OF_PROCESS_LOC + '', 0+64+4096, 'FoxBin2Prg ' + loHost.c_FB2PRG_EXE_Version, 60000 )

         ENDCASE
      ENDIF

      IF EMPTY(lnCodError) AND loHost.l_Errors
         lnCodError = 1098
      ENDIF

      loHost.clearConfigurationCache()
      IF VARTYPE(loHost.c_Foxbin2prg_ConfigFile) = 'O'
         loHost.c_Foxbin2prg_ConfigFile = FORCEEXT(loHost.c_Foxbin2prg_FullPath, 'CFG')
      ENDIF

      lcOldNotify = loSession.lc_OldSetNotify

      SET NOTIFY &lcOldNotify

      RETURN lnCodError
   ENDFUNC
   PROCEDURE run
      *--------------------------------------------------------------------------------------------------------------
      * Main execute() pipeline: session setup, context, dispatch, teardown (called from c_foxbin2prg.execute).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile              (v? IN    ) Full path to convert; empty shows configuration reference form
      * tcType                    (v? IN    ) *, *-, Bin3Prg, Prg3Bin, -BIN2PRG, -PRG2BIN (internal/API use)
      * toCfg                     (v? IN    ) Optional configuration object from newConfig()
      * toEx                      (@?    OUT) Exception object when conversion fails
      * RETURN                    (v?    OUT) 0 on success; VFP error code otherwise (1098 when l_Errors)
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, tcType, toCfg, toEx AS EXCEPTION

      LOCAL tcTextName, tcOriginalFileName, tcRecompile
      LOCAL toModulo, tlRelanzarError
      LOCAL lnCodError, lcType, lcInputFile_Type, lcExt, lnMode
      LOCAL lcErrorInfo, lnVFPVersion
      LOCAL loLang AS CL_LANG OF 'cl_lang.prg'
      LOCAL loSession, loCtx, loCFG
      LOCAL laDirInfo(1,5)
      LOCAL loHost

      loHost = This.o_Host

      STORE '' TO tcTextName, tcOriginalFileName, tcRecompile
      toModulo        = .NULL.
      tlRelanzarError = .F.
      lnCodError      = 0

      loSession = CREATEOBJECT('Empty')
      ADDPROPERTY(loSession, 'lc_OldSetNotify', '')
      ADDPROPERTY(loSession, 'lcOldSetEscape', '')
      ADDPROPERTY(loSession, 'lcOldOnEscape', '')
      ADDPROPERTY(loSession, 'llEscKeyRestored', .T.)

      TRY
         lcType           = EVL(tcType,'')
         tcType           = UPPER( lcType )
         lnVFPVersion     = VERSION(5)
         loLang           = _SCREEN.o_FoxBin2Prg_Lang

         This.beginExecuteSession( loSession )
         This.validateExecuteEnvironment( lnVFPVersion, tcType )

         tc_InputFile = This.parseClassOperationSyntax( tc_InputFile )
         loCFG = This.mergeExecuteConfig( toCfg )

         tc_InputFile     = loHost.get_AbsolutePath( tc_InputFile, loHost.c_CurDir )
         lcInputFile_Type = This.detectInputFileType( tc_InputFile )
         tcRecompile      = This.resolveRecompileTarget( tc_InputFile, lcInputFile_Type, tcRecompile )

         This.logExecuteParameters( tc_InputFile, lcType, toCfg )

         lcExt = JustExt( tc_InputFile )
         tc_InputFile = loHost.rewritePerObjectInputPath( tc_InputFile, tcType, lcExt )

         loLang = _SCREEN.o_FoxBin2Prg_Lang
         loCtx  = This.buildExecuteContext( tc_InputFile, tcType, lcType, loCFG, tcRecompile, ;
            lcInputFile_Type, tcOriginalFileName, tcTextName )

         lnMode     = This.resolveExecuteMode( tcType, tc_InputFile, lcInputFile_Type )
         lnCodError = This.dispatchExecuteMode( lnMode, loCtx, @toEx, @toModulo )

         * sync back mutable context fields used by error reporting
         tc_InputFile = loCtx.tc_InputFile


      CATCH TO toEx
         This.restoreEscapeKey( loSession.llEscKeyRestored, loSession.lcOldSetEscape, loSession.lcOldOnEscape )
         loSession.llEscKeyRestored = .T.

         lnCodError = toEx.ERRORNO

         IF VARTYPE(loLang) <> 'O'
            loLang = NewObject("CL_LANG", "cl_lang.prg", null, "EN")
         ENDIF

         This.enrichExecuteException( @toEx, tcType, tc_InputFile, lcInputFile_Type )
         loHost.ensureLogger()
         loHost.o_Logger.doWriteErrorLog( @toEx, @lcErrorInfo )

         IF loHost.getCfgValue('n_Debug') > 0 AND _VFP.STARTMODE = 0
            SET STEP ON
         ENDIF

         IF tlRelanzarError
            THROW
         ENDIF

      FINALLY
         lnCodError = This.finalizeExecuteSession( lnCodError, tcType, @toEx, loSession, loLang, @laDirInfo )
         STORE .NULL. TO loSession, loCtx

      ENDTRY

      RETURN lnCodError
   ENDPROC

ENDDEFINE
