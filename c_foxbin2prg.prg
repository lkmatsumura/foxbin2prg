#INCLUDE foxbin2prg.h

DEFINE CLASS c_foxbin2prg AS SESSION
   _MEMBERDATA = [<VFPData>] ;
      + [<memberdata name="a_processedfiles" display="a_ProcessedFiles"/>] ;
      + [<memberdata name="applyconfig" display="applyConfig"/>] ;
      + [<memberdata name="c_errorlogfile" display="c_ErrorLogFile"/>] ;
      + [<memberdata name="c_fb2prg_exe_version" display="c_FB2PRG_EXE_Version"/>] ;
      + [<memberdata name="c_foxbin2prg_configfile" display="c_Foxbin2prg_ConfigFile"/>] ;
      + [<memberdata name="c_foxbin2prg_fullpath" display="c_Foxbin2prg_FullPath"/>] ;
      + [<memberdata name="c_logfile" display="c_LogFile"/>] ;
      + [<memberdata name="c_originalfilename" display="c_OriginalFileName"/>] ;
      + [<memberdata name="c_texterr" display="c_TextErr"/>] ;
      + [<memberdata name="cfgcopyfrom" display="cfgCopyFrom"/>] ;
      + [<memberdata name="changefileattribute" display="changeFileAttribute"/>] ;
      + [<memberdata name="changefiletime" display="changeFileTime"/>] ;
      + [<memberdata name="changelanguage" display="changeLanguage"/>] ;
      + [<memberdata name="cinputroot" display="cInputRoot"/>] ;
      + [<memberdata name="clearprocessedfiles" display="clearProcessedFiles"/>] ;
      + [<memberdata name="comparedfilesareequal" display="comparedFilesAreEqual"/>] ;
      + [<memberdata name="compilefoxprobinary" display="compileFoxProBinary"/>] ;
      + [<memberdata name="configfromobject" display="configFromObject"/>] ;
      + [<memberdata name="copyunconvertedfile" display="copyUnconvertedFile"/>] ;
      + [<memberdata name="dowriteerrorlog" display="doWriteErrorLog"/>] ;
      + [<memberdata name="evaluate_full_pj2" display="evaluate_Full_PJ2"/>] ;
      + [<memberdata name="evaluate_full_pjx" display="evaluate_Full_PJX"/>] ;
      + [<memberdata name="ensurecfg" display="ensureCfg"/>] ;
      + [<memberdata name="ensurespecialprops" display="ensureSpecialProps"/>] ;
      + [<memberdata name="evaluateconfiguration" display="evaluateConfiguration"/>] ;
      + [<memberdata name="exception2str" display="exception2Str"/>] ;
      + [<memberdata name="exportprojecttree" display="exportProjectTree"/>] ;
      + [<memberdata name="importprojecttree" display="importProjectTree"/>] ;
      + [<memberdata name="filenamefoundinfilter" display="filenameFoundInFilter"/>] ;
      + [<memberdata name="get_dirsettings" display="get_DirSettings"/>] ;
      + [<memberdata name="get_ext2fromext" display="get_Ext2FromExt"/>] ;
      + [<memberdata name="get_textextforbinfile" display="get_TextExtForBinFile"/>] ;
      + [<memberdata name="detectfox2xrptlbl" display="detectFox2xRptLbl"/>] ;
      + [<memberdata name="getcfgvalue" display="getCfgValue"/>] ;
      + [<memberdata name="getcfgflag" display="getCfgFlag"/>] ;
      + [<memberdata name="getcfgint" display="getCfgInt"/>] ;
      + [<memberdata name="get_filesfromdirectory" display="get_FilesFromDirectory"/>] ;
      + [<memberdata name="get_l_cfg_cachedaccess" display="get_l_CFG_CachedAccess"/>] ;
      + [<memberdata name="get_l_configevaluated" display="get_l_ConfigEvaluated"/>] ;
      + [<memberdata name="get_mirroredpath" display="get_MirroredPath"/>] ;
      + [<memberdata name="get_processed" display="get_Processed"/>] ;
      + [<memberdata name="get_program_header" display="get_PROGRAM_HEADER"/>] ;
      + [<memberdata name="get_separatedlineandcomment" display="get_SeparatedLineAndComment"/>] ;
      + [<memberdata name="hassupport_bin2prg" display="hasSupport_Bin2Prg"/>] ;
      + [<memberdata name="hassupport_prg2bin" display="hasSupport_Prg2Bin"/>] ;
      + [<memberdata name="iscfg" display="isCfg"/>] ;
      + [<memberdata name="isexcludedsubdir" display="isExcludedSubdir"/>] ;
      + [<memberdata name="isunderinputroot" display="isUnderInputRoot"/>] ;
      + [<memberdata name="l_autoclearprocessedfiles" display="l_AutoClearProcessedFiles"/>] ;
      + [<memberdata name="l_cancelwithesckey" display="l_CancelWithEscKey"/>] ;
      + [<memberdata name="l_error" display="l_Error"/>] ;
      + [<memberdata name="l_errors" display="l_Errors"/>] ;
      + [<memberdata name="l_methodsort_enabled" display="l_MethodSort_Enabled"/>] ;
      + [<memberdata name="l_processfiles" display="l_ProcessFiles"/>] ;
      + [<memberdata name="l_propsort_enabled" display="l_PropSort_Enabled"/>] ;
      + [<memberdata name="l_reportsort_enabled" display="l_ReportSort_Enabled"/>] ;
      + [<memberdata name="l_stdouthabilitado" display="l_StdOutHabilitado"/>] ;
      + [<memberdata name="l_test" display="l_Test"/>] ;
      + [<memberdata name="loadprogressbarform" display="loadProgressbarForm"/>] ;
      + [<memberdata name="makedirtree" display="makeDirTree"/>] ;
      + [<memberdata name="getperfiledir" display="getPerFileDir"/>] ;
      + [<memberdata name="getperfileoutputpath" display="getPerFileOutputPath"/>] ;
      + [<memberdata name="getperfilesearchdir" display="getPerFileSearchDir"/>] ;
      + [<memberdata name="getperfilebinaryoutputpath" display="getPerFileBinaryOutputPath"/>] ;
      + [<memberdata name="resolvepj2textmemberpath" display="resolvePj2TextMemberPath"/>] ;
      + [<memberdata name="ispj2textmemberavailable" display="isPj2TextMemberAvailable"/>] ;
      + [<memberdata name="ensureperfiledir" display="ensurePerFileDir"/>] ;
      + [<memberdata name="n_debugp" display="n_DebugP"/>] ;
      + [<memberdata name="n_existecapitalizacion" display="n_ExisteCapitalizacion"/>] ;
      + [<memberdata name="n_fb2prg_version" display="n_FB2PRG_Version"/>] ;
      + [<memberdata name="n_filehandle" display="n_FileHandle"/>] ;
      + [<memberdata name="n_forcewriteifreadonly" display="n_ForceWriteIfReadOnly"/>] ;
      + [<memberdata name="n_order_view_fields" display="n_Order_View_Fields"/>] ;
      + [<memberdata name="n_processedfiles" display="n_ProcessedFiles"/>] ;
      + [<memberdata name="n_processedfilescount" display="n_ProcessedFilesCount"/>] ;
      + [<memberdata name="normalizefilecapitalization" display="normalizeFileCapitalization"/>] ;
      + [<memberdata name="o_cfg" display="o_Cfg"/>] ;
      + [<memberdata name="o_specialprops" display="o_SpecialProps"/>] ;
      + [<memberdata name="o_frm_avance" display="o_Frm_Avance"/>] ;
      + [<memberdata name="o_fso" display="o_FSO"/>] ;
      + [<memberdata name="o_wsh" display="o_WSH"/>] ;
      + [<memberdata name="readinputvfpparams" display="readInputVFPParams"/>] ;
      + [<memberdata name="renamefile" display="renameFile"/>] ;
      + [<memberdata name="renametmpfile2tx2file" display="renameTmpFile2Tx2File"/>] ;
      + [<memberdata name="run_aftercreate_db2" display="run_AfterCreate_DB2"/>] ;
      + [<memberdata name="run_aftercreatetable" display="run_AfterCreateTable"/>] ;
      + [<memberdata name="set_line" display="set_Line"/>] ;
      + [<memberdata name="setcfgvalue" display="setCfgValue"/>] ;
      + [<memberdata name="t_inputfile_timestamp" display="t_InputFile_TimeStamp"/>] ;
      + [<memberdata name="t_outputfile_timestamp" display="t_OutputFile_TimeStamp"/>] ;
      + [<memberdata name="unloadprogressbarform" display="unloadProgressbarForm"/>] ;
      + [<memberdata name="updateprocessedfile" display="updateProcessedFile"/>] ;
      + [<memberdata name="updateprogressbar" display="updateProgressbar"/>] ;
      + [<memberdata name="writeerrorlog" display="writeErrorLog"/>] ;
      + [<memberdata name="writeerrorlog_flush" display="writeErrorLog_Flush"/>] ;
      + [<memberdata name="writelog_flush" display="writeLog_Flush"/>] ;
      + [</VFPData>]



   DIMENSION a_ProcessedFiles(1, 6)
   *--
   n_FB2PRG_Version                = DN_FB2PRG_VERSION
   c_FB2PRG_Version_Real           = DC_FB2PRG_VERSION_REAL
   *--
   c_Language                      = ''            && EN, FR, ES, DE (resolved UI language; CFG input is c_Language_In via getCfgValue)
   c_SimulateError                 = ''            && SIMERR_I0, SIMERR_I1, SIMERR_O1
   c_loc_processing_file           = ''
   c_loc_process_progress          = ''
   c_FB2PRG_EXE_Version            = ''
   c_Foxbin2prg_FullPath           = ''
   c_Foxbin2prg_ConfigFile         = ''
   c_CurDir                        = ''
   c_TempDir                       = SYS(2023)
   c_InputFile                     = ''
   c_ClassToConvert                = ''            && Stores the class name to convert, specified in tcInputFile as "file.vcx::class"
   c_ClassOperationType            = ''            && (I)mport or (E)xport. Used only to handle individual classes.
   c_OriginalFileName              = ''
   c_LogFile                       = ''
   c_ErrorLogFile                  = ''
   c_TextLog                       = ''
   c_OutputFile                    = ''
   c_Recompile                     = '1'
   c_Type                          = ''
   t_InputFile_TimeStamp           = {//::}
   t_OutputFile_TimeStamp          = {//::}
   lFileMode                       = .F.
   n_ExisteCapitalizacion          = -1
   n_DebugP                        = .NULL.         && CLI debug override; effective n_Debug via getCfgValue()

   l_Error                         = .F.           && Error flag for the current process
   l_Errors                        = .F.           && Session-wide error flag, cumulative across all processes
   c_TextErr                       = ''
   l_Test                          = .F.

   n_ForceWriteIfReadOnly          = 0
   l_AutoClearProcessedFiles       = .T.           && By default clears processed files between runs
   l_ProcessFiles                  = .T.           && By default processes files. When .F., used to collect names without rewriting them.
   l_CancelWithEscKey              = .T.
   l_MethodSort_Enabled            = .T.           && For unit testing, can be set to .F. to find differences
   l_PropSort_Enabled              = .T.           && For unit testing, can be set to .F. to find differences
   l_ReportSort_Enabled            = .F.           && For unit testing. 11/09/2015 - Changed to .F. because it changes object ZOrder (Ryan Harris)
   l_StdOutHabilitado              = .T.
   n_ClassTimeStamp                = 1130668032    && 2013/11/04 20:00:00
   n_ID                            = 0
   n_FileHandle                    = 0
   n_Order_View_Fields             = 1
   n_ProcessedFiles                = 0             && Counter used for file.class.ext files
   n_ProcessedFilesCount           = 0             && Generic processed counter

   o_Frm_Avance                    = .NULL.
   o_WSH                           = .NULL.
   o_FSO                           = .NULL.        && Scripting.FileSystemObject
   o_FileUtils                     = .NULL.        && cl_file_utils (Win32 / path helpers)
   o_Mirror                        = .NULL.        && cl_fb2prg_mirror (mirrored project tree)
   o_Cfg                           = .NULL.        && cl_fb2prg_cfg (configuration manager)
   o_SpecialProps                  = .NULL.        && cl_fb2prg_special_props (property sort order)
   o_TextStream                    = .NULL.        && Scripting.TextStream
   o_FNC                           = .NULL.        && Filename_caps object

   run_AfterCreateTable            = ''
   run_AfterCreate_DB2             = ''

   cOutputFolder                   = ''            && the folder to write files to (blank = same folder as source file)
   cInputRoot                      = ''            && project/source root; if set with cOutputFolder, the folder tree is mirrored
   l_MirrorExport                  = .F.           && .T. during evaluate_Full_PJX (bin->mirror), .F. during evaluate_Full_PJ2

   *keep CodePage relavant information for binary sources
   i_CPID                          = 0 &&CPCURRENT(1)

   *!* more sophisticated control of inheritance for para file

   PROCEDURE INIT
      LPARAMETERS tcCFG_File, tcCancelWithEscKey

      #IF .F.
         LOCAL THIS AS c_foxbin2prg OF 'c_foxbin2prg.PRG'
      #ENDIF

      LOCAL lcSys16, lnPosProg, lc_Foxbin2prg_EXE, laValues(1,5), lcPicturePath, laDir(1,5) ;
         , lcLang

      SET DELETED ON
      SET DATE YMD
      SET HOURS TO 24
      SET CENTURY ON
      SET SAFETY OFF
      SET MULTILOCKS ON
      SET TABLEPROMPT OFF
      SET POINT TO '.'
      SET SEPARATOR TO ','

      tcCancelWithEscKey  = EVL(tcCancelWithEscKey, '')

      IF NOT EMPTY(tcCancelWithEscKey)
         This.l_CancelWithEscKey = ( tcCancelWithEscKey == '1' )
      ENDIF

      This.ensureFileUtils()
      This.o_FileUtils.declareDLL()

      IF ATC("\PROGRAM FILES", This.c_TempDir) > 0 OR ATC("\ARCHIVOS DE PROGRAMA", This.c_TempDir) > 0
         This.c_TempDir  = GETENV("TEMP")
      ENDIF

      This.c_LogFile      = ADDBS( This.c_TempDir ) + 'FoxBin2Prg_Debug.LOG'
      This.c_ErrorLogFile = ADDBS( This.c_TempDir ) + 'FoxBin2Prg_Error.LOG'

      IF ADIR(laDir, This.c_ErrorLogFile) > 0 THEN
         IF ADIR(laDir, This.c_ErrorLogFile + '.BAK') > 0 THEN
            This.changeFileAttribute( This.c_ErrorLogFile + '.BAK', '-R-S-H' )
            ERASE (This.c_ErrorLogFile + '.BAK')
         ENDIF

         This.changeFileAttribute( This.c_ErrorLogFile, '-R-S-H' )
         RENAME (This.c_ErrorLogFile) TO (This.c_ErrorLogFile + '.BAK')
      ENDIF

      IF ADIR(laDir, This.c_LogFile) > 0 THEN
         ERASE (This.c_LogFile + '.BAK')
         RENAME (This.c_LogFile) TO (This.c_LogFile + '.BAK')
      ENDIF

      lcSys16 = SYS(16)
      IF LEFT(lcSys16,10) == 'PROCEDURE '
         lnPosProg   = AT(" ", lcSys16, 2) + 1
      ELSE
         lnPosProg   = 1
      ENDIF

      && Current directory, which is not necessarily where FoxBin2Prg is located
      This.c_CurDir                   = SYS(5) + CURDIR()

      This.c_Foxbin2prg_FullPath      = SUBSTR( lcSys16, lnPosProg )
      This.c_Foxbin2prg_ConfigFile    = EVL( tcCFG_File, FORCEEXT( This.c_Foxbin2prg_FullPath, 'CFG' ) )
      This.setCfgValue( 'c_BackgroundImage', This.get_AbsolutePath( ADDBS(JUSTPATH(This.c_Foxbin2prg_FullPath)) + 'foxbin2prg.jpg' ) )
      lc_Foxbin2prg_EXE               = FORCEEXT( This.c_Foxbin2prg_FullPath, 'EXE' )

      This.c_FB2PRG_EXE_Version       = 'v' + TRANSFORM(This.c_FB2PRG_Version_Real)

      ADDPROPERTY(_SCREEN, 'c_FB2PRG_EXE_Version', This.c_FB2PRG_EXE_Version)
      ADDPROPERTY(_SCREEN, 'ExitCode', 0)

      This.writeLog( REPLICATE( '*', 100 ) )
      This.writeLog( 'FoxBin2Prg INIT  -', 2 )
      This.writeLog( REPLICATE( '*', 100 ) )
      This.writeLog( 'FoxBin2Prg: [' + This.c_Foxbin2prg_FullPath + '] (EXE Version: ' + This.c_FB2PRG_EXE_Version + ', FoxPro Version: ' + VERSION(4) + ')' )
      This.writeLog( TEXTMERGE( '- Internal CFG: <<SYS(2019,2)>> / External CFG: <<SYS(2019,1)>> / CodePage Used: <<CPCURRENT()>>)' ) )

      * Get default language info
      * ISO 639-2 Language Codes: https://www.loc.gov/standards/iso639-2/php/code_list.php
      lcLang  = This.getLocaleInfo(0x00000067) && ie: spa

      DO CASE
      CASE lcLang = 'spa'
         lcLang = 'ES'

      CASE INLIST(lcLang, 'den', 'deu', 'ger', 'gmh', 'goh', 'gsw', 'nds')
         lcLang = 'DE'

      CASE INLIST(lcLang, 'cpf', 'fra', 'fre', 'frm', 'fro')
         lcLang = 'FR'

      OTHERWISE && Default: EN
         lcLang = 'EN'
      ENDCASE

      This.changeLanguage(lcLang)

      This.o_FSO           = CREATEOBJECT("Scripting.FileSystemObject")
      This.ensureCfg()
      This.o_Cfg.setup()
      This.ensureSpecialProps()
      This.evaluateConfiguration()
      RELEASE lcSys16, lnPosProg, lc_Foxbin2prg_EXE, laValues
      RETURN
   ENDPROC


   PROCEDURE DESTROY
      TRY
         LOCAL lcFileCDX
         lcFileCDX   = FORCEPATH( "TABLABIN.CDX", JUSTPATH(This.c_InputFile) )

         ERASE ( lcFileCDX )

         This.writeLog( 'FoxBin2Prg UNLOAD  -', 2 )
         This.writeLog( REPLICATE( '*', 100 ) )
         This.writeLog( )
         This.writeLog_Flush()
         This.unloadProgressbarForm()

      CATCH

      FINALLY
         This.o_FSO  = .NULL.
         This.o_WSH  = .NULL.
         This.o_FNC  = .NULL.
         IF VARTYPE(This.o_FileUtils) = 'O' AND !ISNULL(This.o_FileUtils)
            This.o_FileUtils.clearDll()
         ENDIF
         This.o_FileUtils = .NULL.
         This.o_Mirror = .NULL.
         This.o_SpecialProps = .NULL.
         This.o_Cfg = .NULL.

         IF ! VARTYPE(_SCREEN.o_FoxBin2Prg_Lang) == "U" THEN
            _SCREEN.o_FoxBin2Prg_Lang = .NULL.
            RemoveProperty(_Screen , 'o_FoxBin2Prg_Lang' )
         ENDIF

         IF VARTYPE(_SCREEN.o_FoxBin2Prg_Lang) == "U" THEN
            RemoveProperty(_Screen , 'c_FB2PRG_EXE_Version' )
         ENDIF

      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE addProcessedFile
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                    (v? IN    ) File path (e.g. 'C:\DESA\pruebas varias\lib.vcx')
      * tcInOutType               (v? IN    ) Input or output file ("I"=Input file, "O"=Output file)
      * tcProcessed               (v? IN    ) Processed ("P0"=Not Processed, "P1"=Processed)
      * tcHasErrors               (v? IN    ) Had errors ("E0"=No Errors, "E1"=Has Errors)
      * tcSupported               (v? IN    ) Supported file ("S0"=Unsupported, "S1"=Supported)
      * tcExpanded                (v? IN    ) File type ("X0"=Normal file, "X1"=Expanded multipart file)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded

      LOCAL llAdded

      IF NOT EMPTY(tcFile) THEN
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            *-- Check whether it was processed before
            IF NOT .wasProcessed(tcFile) THEN
               .n_ProcessedFiles   = .n_ProcessedFiles + 1
               DIMENSION .a_ProcessedFiles(.n_ProcessedFiles, 6)
               .a_ProcessedFiles(.n_ProcessedFiles, 1) = tcFile
               .a_ProcessedFiles(.n_ProcessedFiles, 2) = EVL(tcInOutType, '')
               .a_ProcessedFiles(.n_ProcessedFiles, 3) = EVL(tcProcessed, '')
               .a_ProcessedFiles(.n_ProcessedFiles, 4) = EVL(tcHasErrors, '')
               .a_ProcessedFiles(.n_ProcessedFiles, 5) = EVL(tcSupported, '')
               .a_ProcessedFiles(.n_ProcessedFiles, 6) = EVL(tcExpanded, '')
               llAdded = .T.
            ENDIF
         ENDWITH
      ENDIF

      RETURN llAdded
   ENDPROC


   PROCEDURE wasProcessed
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFileMask                (v! IN    ) Full path of the file to check whether it was processed
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile, tnID

      tnID = 0

      IF This.n_ProcessedFiles = 0
         RETURN .F.
      ENDIF

      tnID = ASCAN( This.a_ProcessedFiles, tcFile, 1, 0, 1, 1+2+4 )

      RETURN (tnID > 0)
   ENDPROC


   PROCEDURE updateProgressbar
      LPARAMETERS tcTexto, tnValor, tnTotal, tnTipo

      TRY
         *-- If o_Frm_Avance was enabled externally, n_ShowProgressbar may be 0 to control it from outside.
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            IF VARTYPE(.o_Frm_Avance) = "O" THEN
               *-- When this routine is invoked from the script, this method is #1 and cannot be cancelled yet
               IF .o_Frm_Avance.l_Cancelled AND PROGRAM(-1) > 1 THEN
                  ERROR 1799
               ENDIF
               .o_Frm_Avance.updateProgressbar( tcTexto, tnValor, tnTotal, tnTipo )
            ENDIF
         ENDWITH

      CATCH
         THROW
      ENDTRY
   ENDPROC


   PROCEDURE changeLanguage
      LPARAMETERS tcLanguageId
      _SCREEN.ADDPROPERTY( "o_FoxBin2Prg_Lang", NewObject("CL_LANG", "cl_lang.prg", null, tcLanguageId) )
      *-- Localized properties
      This.c_Language                 = _SCREEN.o_FoxBin2Prg_Lang.C_LANGUAGE_LOC
      This.c_loc_processing_file      = _SCREEN.o_FoxBin2Prg_Lang.C_PROCESSING_LOC
      This.c_loc_process_progress     = _SCREEN.o_FoxBin2Prg_Lang.C_PROCESS_PROGRESS_LOC
   ENDPROC


   PROCEDURE clearProcessedFiles
      *-- Clears processed-file statistics used to optimize
      *-- processing and avoid reprocessing the same files, for example,
      *-- a single VCX shared by 2 or more projects.
      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         .n_ProcessedFilesCount  = 0
         .n_ProcessedFiles       = 0
         DIMENSION .a_ProcessedFiles(1, 6)
         .a_ProcessedFiles       = ''
         *-- Previous errors are cleared too.
         .l_Error                = .F.
         .l_Errors               = .F.
      ENDWITH
   ENDPROC


   PROCEDURE ensureFileUtils
      IF VARTYPE(This.o_FileUtils) <> 'O' OR ISNULL(This.o_FileUtils)
         This.o_FileUtils = NewObject('cl_file_utils', 'cl_file_utils.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE ensureMirror
      IF VARTYPE(This.o_Mirror) <> 'O' OR ISNULL(This.o_Mirror)
         This.o_Mirror = NewObject('cl_fb2prg_mirror', 'cl_fb2prg_mirror.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE ensureCfg
      IF VARTYPE(This.o_Cfg) <> 'O' OR ISNULL(This.o_Cfg)
         This.o_Cfg = NewObject('cl_fb2prg_cfg', 'cl_fb2prg_cfg.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE ensureSpecialProps
      IF VARTYPE(This.o_SpecialProps) <> 'O' OR ISNULL(This.o_SpecialProps)
         This.o_SpecialProps = NewObject('cl_fb2prg_special_props', 'cl_fb2prg_special_props.prg' , NULL , This.c_Foxbin2prg_FullPath )
      ENDIF
   ENDPROC

   PROCEDURE declareDLL
      This.ensureFileUtils()
      This.o_FileUtils.declareDLL()
   ENDPROC

   PROCEDURE get_AbsolutePath
      LPARAMETERS tc_InputFile, tc_FullPath
      This.ensureFileUtils()
      RETURN This.o_FileUtils.get_AbsolutePath(tc_InputFile, tc_FullPath)
   ENDPROC


   FUNCTION get_l_ConfigEvaluated
      This.ensureCfg()
      RETURN This.o_Cfg.l_Main_CFG_Loaded
   ENDFUNC

   FUNCTION get_l_CFG_CachedAccess
      This.ensureCfg()
      RETURN This.o_Cfg.l_CFG_CachedAccess
   ENDFUNC

   FUNCTION get_Processed
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * taProcessed               (@!    OUT) Array where file information for the given mask will be returned
      * tcFileMask                (v? IN    ) File mask to search (name, "*", "?")
      *---------------------------------------------------------------------------------------------------
      * RETURNED ARRAY STRUCTURE:
      * col(1)    tcFile      - File path (e.g. 'C:\DESA\pruebas varias\lib.vcx')
      * col(2)    tcInOutType - Input or output file ("I"=Input file, "O"=Output file)
      * col(3)    tcProcessed - Processed ("P0"=Not Processed, "P1"=Processed)
      * col(4)    tcHasErrors - Had errors ("E0"=No Errors, "E1"=Has Errors)
      * col(5)    tcSupported - Supported file ("S0"=Unsupported, "S1"=Supported)
      * col(6)    tcExpanded  - File type ("X0"=Normal file, "X1"=Expanded multipart file)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS taProcessed, tcFileMask

      EXTERNAL ARRAY taProcessed

      LOCAL lnCount, I
      lnCount = 0

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         tcFileMask  = EVL(tcFileMask, '*')

         FOR I = 1 TO .n_ProcessedFiles
            IF LIKE( tcFileMask, JUSTFNAME(.a_ProcessedFiles(m.I,1)) ) THEN
               lnCount = lnCount + 1
               DIMENSION taProcessed(lnCount,6)
               taProcessed(lnCount,1)  = .a_ProcessedFiles(m.I,1)
               taProcessed(lnCount,2)  = .a_ProcessedFiles(m.I,2)
               taProcessed(lnCount,3)  = .a_ProcessedFiles(m.I,3)
               taProcessed(lnCount,4)  = .a_ProcessedFiles(m.I,4)
               taProcessed(lnCount,5)  = .a_ProcessedFiles(m.I,5)
               taProcessed(lnCount,6)  = .a_ProcessedFiles(m.I,6)
            ENDIF
         ENDFOR
      ENDWITH

      RETURN lnCount
   ENDFUNC

   PROCEDURE changeFileAttribute
      LPARAMETERS tcFileName, tcAttrib
      This.ensureFileUtils()
      RETURN This.o_FileUtils.changeFileAttribute(tcFileName, tcAttrib)
   ENDPROC


   PROCEDURE changeFileTime
      LPARAMETERS tcFileName, tcTimeType, tnYear, tnMonth, tnDay, tnHour, tnMinute, tnSec, tnThou
      This.ensureFileUtils()
      RETURN This.o_FileUtils.changeFileTime(tcFileName, tcTimeType, tnYear, tnMonth, tnDay, tnHour, tnMinute, tnSec, tnThou)
   ENDPROC


   PROCEDURE compileFoxProBinary
      LPARAMETERS tcFileName
      LOCAL lcType

      tcFileName  = EVL(tcFileName, This.c_OutputFile)
      lcType      = UPPER(JUSTEXT(tcFileName))

      DO CASE
      CASE lcType = 'VCX'
         COMPILE CLASSLIB (tcFileName)

      CASE lcType = 'SCX'
         COMPILE FORM (tcFileName)

      CASE lcType = 'FRX'
         COMPILE REPORT (tcFileName)

      CASE lcType = 'LBX'
         COMPILE LABEL (tcFileName)

      CASE lcType = 'DBC'
         COMPILE DATABASE (tcFileName)

      ENDCASE

      RELEASE tcFileName, lcType
      RETURN
   ENDPROC


   PROCEDURE doBackup
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toEx                      (@? IN    ) Exception object with error information
      * tlRelanzarError           (v? IN    ) Whether the error should be re-thrown
      * tcBakFile_1               (@?    OUT) Backup file 1 name (vcx,scx,pjx,frx,lbx,dbf,dbc,mnx,vc2,sc2,pj2,etc)
      * tcBakFile_2               (@?    OUT) Backup file 2 name (vct,sct,pjt,frt,lbt,fpt,dct,mnt,etc)
      * tcBakFile_3               (@?    OUT) Backup file 3 name (cdx,dcx,etc)
      * tcOutputFile              (v? IN    ) Output file name. If omitted, .c_OutputFile is assumed
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toEx, tlRelanzarError, tcBakFile_1, tcBakFile_2, tcBakFile_3, tcOutputFile

      #IF .F.
         LOCAL toFoxBin2Prg AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
      #ENDIF

      TRY
         LOCAL lcNext_Bak, lcExt_1, lcExt_2, lcExt_3, tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3, laDir(1,5) ;
            , loLang AS CL_LANG OF 'cl_lang.prg'
         STORE '' TO tcBakFile_1, tcBakFile_2, tcBakFile_3, lcExt_1, lcExt_2, lcExt_3 ;
            , tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3

         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            IF .getCfgValue('n_ExtraBackupLevels') > 0 THEN
               loLang          = _SCREEN.o_FoxBin2Prg_Lang
               tcOutputFile    = EVL( tcOutputFile, .c_OutputFile )
               lcNext_Bak      = .getNext_BAK( tcOutputFile )
               lcExt_1         = JUSTEXT( tcOutputFile )
               tcBakFile_1     = FORCEEXT(tcOutputFile, lcExt_1 + lcNext_Bak)

               DO CASE
               CASE INLIST( lcExt_1, .getCfgValue('c_PJ2'), .getCfgValue('c_VC2'), .getCfgValue('c_SC2'), .getCfgValue('c_FR2') ;
                                   , .getCfgValue('c_FR2D'), .getCfgValue('c_LB2'), .getCfgValue('c_LB2D'), .getCfgValue('c_DB2');
                                   , .getCfgValue('c_DC2'), .getCfgValue('c_MN2'), .getCfgValue('c_FK2'), .getCfgValue('c_ME2'), 'PJM' )
                  *-- TEXT extensions

               CASE lcExt_1 = 'DBF'
                  *-- DBF
                  lcExt_2     = 'FPT'
                  lcExt_3     = 'CDX'
                  tcBakFile_2 = FORCEEXT(tcOutputFile, lcExt_2 + lcNext_Bak)
                  tcBakFile_3 = FORCEEXT(tcOutputFile, lcExt_3 + lcNext_Bak)

               CASE lcExt_1 = 'DBC'
                  *-- DBC
                  lcExt_2     = 'DCT'
                  lcExt_3     = 'DCX'
                  tcBakFile_2 = FORCEEXT(tcOutputFile, lcExt_2 + lcNext_Bak)
                  tcBakFile_3 = FORCEEXT(tcOutputFile, lcExt_3 + lcNext_Bak)

               CASE INLIST( lcExt_1, 'PJX', 'VCX', 'SCX', 'FRX', 'LBX', 'MNX' )
                  *-- PJX, VCX, SCX, FRX, LBX, MNX
                  lcExt_2     = LEFT(lcExt_1,2) + 'T'
                  tcBakFile_2 = FORCEEXT(tcOutputFile, lcExt_2 + lcNext_Bak)

               OTHERWISE
                  *-- PKY, MEM

               ENDCASE

               IF NOT EMPTY(lcExt_1)
                  tcOutputFile_Ext1   = FORCEEXT(tcOutputFile, lcExt_1)

                  IF ADIR( laDir, tcOutputFile_Ext1 ) > 0 THEN
                     *-- LOG
                     DO CASE
                     CASE EMPTY(lcExt_2)
                        .writeLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 )
                     CASE EMPTY(lcExt_3)
                        .writeLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 + '/' + lcExt_2 )
                     OTHERWISE
                        .writeLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 + '/' + lcExt_2 + '/' + lcExt_3 )
                     ENDCASE

                     *-- BACKUP COPY
                     COPY FILE ( tcOutputFile_Ext1 ) TO ( tcBakFile_1 )

                     IF NOT EMPTY(lcExt_2)
                        tcOutputFile_Ext2   = FORCEEXT(tcOutputFile, lcExt_2)

                        IF ADIR( laDir, tcOutputFile_Ext2 ) > 0 THEN
                           COPY FILE ( tcOutputFile_Ext2 ) TO ( tcBakFile_2 )
                        ENDIF
                     ENDIF

                     IF NOT EMPTY(lcExt_3)
                        tcOutputFile_Ext3   = FORCEEXT(tcOutputFile, lcExt_3)

                        IF ADIR( laDir, tcOutputFile_Ext3 ) > 0 THEN
                           COPY FILE ( tcOutputFile_Ext3 ) TO ( tcBakFile_3 )
                        ENDIF
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF
         ENDWITH && THIS

      CATCH TO toEx
         IF This.getCfgValue('n_Debug') > 0 AND _VFP.STARTMODE = 0
            SET STEP ON
         ENDIF

         IF tlRelanzarError
            THROW
         ENDIF

      FINALLY
         RELEASE toEx, tlRelanzarError, tcBakFile_1, tcBakFile_2, tcBakFile_3 ;
            , lcNext_Bak, lcExt_1, lcExt_2, lcExt_3, tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3 ;
            , tcOutputFile
      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE loadProgressbarForm
      IF VARTYPE(This.o_Frm_Avance) <> "O" THEN
         This.o_Frm_Avance   = NewObject( "frm_avance" , "frm_avance.prg" , null , This )
         This.o_Frm_Avance.SHOW()
      ENDIF
   ENDPROC


   PROCEDURE unloadProgressbarForm
      LPARAMETERS tlForceUnload
      IF (tlForceUnload OR This.getCfgValue('n_ShowProgressbar') <> 0) AND VARTYPE(This.o_Frm_Avance) = "O" THEN
         This.o_Frm_Avance.HIDE()
         This.o_Frm_Avance.RELEASE()
         This.o_Frm_Avance = .NULL.
      ENDIF
   ENDPROC


   PROCEDURE evaluateConfiguration
      LPARAMETERS tcDontShowProgress  , tcDontShowErrors, tcNoTimestamps       , tcDebug     , tcRecompile      ;
                , tcExtraBackupLevels , tcClearUniqueID , tcOptimizeByFilestamp, tc_InputFile, tcInputFile_Type ;
                , toParentCFG         , tl_ForceLog     , tcCFG_File
      This.ensureCfg()
      This.o_Cfg.evaluateConfiguration(tcDontShowProgress, tcDontShowErrors, tcNoTimestamps, tcDebug, tcRecompile ;
         , tcExtraBackupLevels, tcClearUniqueID, tcOptimizeByFilestamp, tc_InputFile, tcInputFile_Type ;
         , toParentCFG, tl_ForceLog, tcCFG_File)
   ENDPROC




   FUNCTION comparedFilesAreEqual
      LPARAMETERS tcFilename1, tcFilename2, tcStrFileName2
      This.ensureFileUtils()
      RETURN This.o_FileUtils.comparedFilesAreEqual(tcFilename1, tcFilename2, tcStrFileName2)
   ENDFUNC


   FUNCTION filenameFoundInFilter
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFilename                (v! IN    ) File name to evaluate
      * tcFilters                 (v! IN    ) Filters to evaluate (*,??E.*,R*.*)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFileName, tcFilters

      LOCAL llFound, laFiltros(1)
      tcFileName  = UPPER(tcFileName)

      FOR I = 1 TO ALINES( laFiltros, tcFilters + ',', 1+4, ',' )
         IF LIKE( UPPER(laFiltros(m.I)), tcFileName )
            llFound = .T.
            EXIT
         ENDIF
      ENDFOR

      RELEASE tcFileName, tcFilters, laFiltros
      RETURN llFound
   ENDFUNC


   PROCEDURE get_DBF_Configuration
      LPARAMETERS tc_InputFile AS STRING, to_out_DBF_CFG AS OBJECT, tlGenerateLog AS Boolean

      to_out_DBF_CFG = NewObject('CL_DBF_CFG', 'cl_dbf_cfg.prg')

      to_out_DBF_CFG = to_out_DBF_CFG.FromFile(tc_InputFile, tlGenerateLog, This)

      RETURN IIF(VARTYPE(to_out_DBF_CFG) = 'O' AND !ISNULL(to_out_DBF_CFG), 1, 0)
   ENDPROC


   PROCEDURE get_Ext2FromExt
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcExt                     (@! IN    ) Extension to check conversion support
      * tcDir                     (@? IN    ) Directory whose configuration should be returned
      * RETURN                    (v?    OUT) .T. if conversion is supported, .F. if not
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcExt, tcDir

      LOCAL lcExt2
      tcExt   = UPPER(tcExt)

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         IF NOT EMPTY(tcDir)
            .evaluateConfiguration( '', '', '', '', '', '', '', '', tcDir, 'D' )
         ENDIF

         lcExt2  = ICASE( tcExt == 'PJX', .getCfgValue('c_PJ2') ;
            , tcExt == 'VCX', .getCfgValue('c_VC2') ;
            , tcExt == 'SCX', .getCfgValue('c_SC2') ;
            , tcExt == 'FRX', .getCfgValue('c_FR2') ;
            , tcExt == 'LBX', .getCfgValue('c_LB2') ;
            , tcExt == 'MNX', .getCfgValue('c_MN2') ;
            , tcExt == 'DBF', .getCfgValue('c_DB2') ;
            , tcExt == 'DBC', .getCfgValue('c_DC2') ;
            , tcExt )
      ENDWITH && THIS

      RELEASE tcExt
      RETURN lcExt2
   ENDPROC


   PROCEDURE detectFox2xRptLbl(tcFile AS STRING) AS Boolean
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                    (v! IN    ) FRX or LBX file to inspect
      * RETURN                    (v?    OUT) .T. if Fox 2.x format (74 fields, no USER column)
      *---------------------------------------------------------------------------------------------------
      LOCAL llFox2x, lnSelect

      llFox2x = .F.
      lnSelect = SELECT()

      SELECT 0
      USE (tcFile) SHARED AGAIN NOUPDATE
      llFox2x = (FCOUNT() = 74 AND EMPTY(FIELD("USER")))
      USE

      SELECT (lnSelect)

      RETURN llFox2x
   ENDPROC


   PROCEDURE get_TextExtForBinFile(tcBinFile AS STRING) AS String
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinFile                 (v! IN    ) Full path to binary file (e.g. report.frx)
      * RETURN                    (v?    OUT) Text extension for PRG2BIN (FR2/FR2D, LB2/LB2D, etc.)
      *---------------------------------------------------------------------------------------------------
      LOCAL lcExt, lcTextExt

      lcExt = UPPER(JUSTEXT(tcBinFile))

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         DO CASE
         CASE lcExt == 'FRX'
            IF FILE(FORCEEXT(tcBinFile, .getCfgValue('c_FR2D')))
               lcTextExt = .getCfgValue('c_FR2D')
            ELSE
               IF FILE(tcBinFile) AND .detectFox2xRptLbl(tcBinFile)
                  lcTextExt = .getCfgValue('c_FR2D')
               ELSE
                  lcTextExt = .getCfgValue('c_FR2')
               ENDIF
            ENDIF

         CASE lcExt == 'LBX'
            IF FILE(FORCEEXT(tcBinFile, .getCfgValue('c_LB2D')))
               lcTextExt = .getCfgValue('c_LB2D')
            ELSE
               IF FILE(tcBinFile) AND .detectFox2xRptLbl(tcBinFile)
                  lcTextExt = .getCfgValue('c_LB2D')
               ELSE
                  lcTextExt = .getCfgValue('c_LB2')
               ENDIF
            ENDIF

         OTHERWISE
            lcTextExt = .get_Ext2FromExt(lcExt)
         ENDCASE
      ENDWITH && THIS

      RETURN lcTextExt
   ENDPROC


   PROCEDURE resolvePj2TextMemberPath
      *---------------------------------------------------------------------------------------------------
      * Resolves the best text-file path for a PJ2 binary member (Prg2Bin / importProjectTree).
      * With UseClassPerFile + UseClassPerDir the header lives under library.vc2\library.vc2, not library.vc2.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinFile                 (v! IN    ) PJ2 member path (.vcx, .scx, .dbc, ...)
      * RETURN                    (v?    OUT) Text file path to pass to convert()
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinFile
      LOCAL lcExt, lcFlat, lcHeader, lcStem, lnPerFile, llPerDir, lcTextExt, laDir(1)

      lcExt       = UPPER(JUSTEXT(tcBinFile))
      lcFlat      = FORCEEXT(tcBinFile, This.get_TextExtForBinFile(tcBinFile))

      DO CASE
      CASE INLIST(lcExt, 'VCX', UPPER(This.getCfgValue('c_VC2')))
         lnPerFile   = This.getCfgInt('n_UseClassPerFile')
         llPerDir    = This.getCfgFlag('l_UseClassPerDir')
         lcTextExt   = This.getCfgValue('c_VC2')
         IF lnPerFile > 0
            lcHeader = This.getPerFileOutputPath(tcBinFile, '', lcTextExt, llPerDir, lnPerFile)
            IF FILE(lcHeader)
               RETURN lcHeader
            ENDIF
            lcStem   = JUSTSTEM(tcBinFile)
            IF llPerDir
               IF ADIR(laDir, ADDBS(This.getPerFileDir(tcBinFile, lcTextExt, llPerDir, lnPerFile)) ;
                     + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
                  RETURN lcHeader
               ENDIF
            ELSE
               IF ADIR(laDir, ADDBS(JUSTPATH(tcBinFile)) + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
                  RETURN lcHeader
               ENDIF
            ENDIF
         ENDIF

      CASE INLIST(lcExt, 'SCX', UPPER(This.getCfgValue('c_SC2')))
         lnPerFile   = This.getCfgInt('n_UseFormPerFile')
         llPerDir    = This.getCfgFlag('l_UseFormPerDir')
         lcTextExt   = This.getCfgValue('c_SC2')
         IF lnPerFile > 0
            lcHeader = This.getPerFileOutputPath(tcBinFile, '', lcTextExt, llPerDir, lnPerFile)
            IF FILE(lcHeader)
               RETURN lcHeader
            ENDIF
            lcStem   = JUSTSTEM(tcBinFile)
            IF llPerDir
               IF ADIR(laDir, ADDBS(This.getPerFileDir(tcBinFile, lcTextExt, llPerDir, lnPerFile)) ;
                     + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
                  RETURN lcHeader
               ENDIF
            ELSE
               IF ADIR(laDir, ADDBS(JUSTPATH(tcBinFile)) + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
                  RETURN lcHeader
               ENDIF
            ENDIF
         ENDIF

      CASE INLIST(lcExt, 'DBC', UPPER(This.getCfgValue('c_DC2')))
         lnPerFile   = This.getCfgInt('n_UseFilesPerDBC')
         lcTextExt   = This.getCfgValue('c_DC2')
         IF lnPerFile > 0
            lcHeader = FORCEEXT(tcBinFile, lcTextExt)
            IF FILE(lcHeader)
               RETURN lcHeader
            ENDIF
            lcStem   = JUSTSTEM(tcBinFile)
            IF ADIR(laDir, ADDBS(JUSTPATH(tcBinFile)) + lcStem + '.*.*.' + lcTextExt) > 0
               RETURN lcHeader
            ENDIF
         ENDIF

      ENDCASE

      RETURN lcFlat
   ENDPROC


   FUNCTION isPj2TextMemberAvailable
      *---------------------------------------------------------------------------------------------------
      * Returns .T. when text source exists for a PJ2 binary member (flat file, per-dir folder, or split parts).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinFile                 (v! IN    ) PJ2 member path (.vcx, .scx, .dbc, ...)
      * RETURN                    (v?    OUT) .T. when import can proceed
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinFile
      LOCAL lcExt, lcFlat, lcResolved, lnPerFile, llPerDir, lcTextExt, lcStem, laDir(1)

      lcResolved  = This.resolvePj2TextMemberPath(tcBinFile)
      IF FILE(lcResolved)
         RETURN .T.
      ENDIF

      lcExt       = UPPER(JUSTEXT(tcBinFile))
      lcFlat      = FORCEEXT(tcBinFile, This.get_TextExtForBinFile(tcBinFile))
      IF FILE(lcFlat)
         RETURN .T.
      ENDIF

      lnPerFile   = 0
      llPerDir    = .F.
      lcTextExt   = ''

      DO CASE
      CASE INLIST(lcExt, 'VCX', UPPER(This.getCfgValue('c_VC2')))
         lnPerFile   = This.getCfgInt('n_UseClassPerFile')
         llPerDir    = This.getCfgFlag('l_UseClassPerDir')
         lcTextExt   = This.getCfgValue('c_VC2')

      CASE INLIST(lcExt, 'SCX', UPPER(This.getCfgValue('c_SC2')))
         lnPerFile   = This.getCfgInt('n_UseFormPerFile')
         llPerDir    = This.getCfgFlag('l_UseFormPerDir')
         lcTextExt   = This.getCfgValue('c_SC2')

      CASE INLIST(lcExt, 'DBC', UPPER(This.getCfgValue('c_DC2')))
         lnPerFile   = This.getCfgInt('n_UseFilesPerDBC')
         lcTextExt   = This.getCfgValue('c_DC2')

      OTHERWISE
         RETURN .F.

      ENDCASE

      IF lnPerFile > 0
         lcStem   = JUSTSTEM(tcBinFile)
         IF llPerDir
            RETURN ADIR(laDir, ADDBS(This.getPerFileDir(tcBinFile, lcTextExt, llPerDir, lnPerFile)) ;
                  + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
         ELSE
            RETURN ADIR(laDir, ADDBS(JUSTPATH(tcBinFile)) + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
         ENDIF
      ENDIF

      RETURN .F.
   ENDFUNC


   PROCEDURE hasSupport_Bin2Prg(tcFileName AS STRING, tcDir AS STRING) AS Boolean
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFilename                (@! IN    ) Extension to check whether the file has conversion support
      * tcDir                     (@? IN    ) Directory whose configuration should be returned
      * RETURN                    (v?    OUT) .T. if conversion is supported, .F. if not
      *---------------------------------------------------------------------------------------------------
      LOCAL llhasSupport, lcExt, lcDir ;
         , loDBF_CFG AS CL_DBF_CFG OF 'CL_DBF_CFG.prg'

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         loDBF_CFG   = .NULL.
         lcExt       = UPPER(JUSTEXT('.' + tcFileName))

         *!* Changed by: LScheffler 13.6.2022
         *!* <pdm>
         *!* <change date="{^2022-06-13,20:17:00}">Changed by: LScheffler<br />
         *!* https://github.com/fdbozzo/foxbin2prg/issues/56 / Configfile is ignored if foldername has "." v1.19.74
         *!* On operation per folder, change of folder must change configuration
         *!* this method does not recieve tcDir in such case
         *!* </change>
         *!* </pdm>

         *!*             If '\' $ tcFileName And lcExt == 'DBF' Then
         *!*                 lcDir       = Justpath(tcFileName)
         *!*                 .get_DBF_Configuration(tcFileName, @loDBF_CFG)
         *!*             Else
         *!*                 lcDir       = tcDir
         *!*             ENDIF

         DO CASE
         CASE '\' $ tcFileName AND lcExt == 'DBF'
            lcDir       = JUSTPATH(tcFileName)
            .get_DBF_Configuration(tcFileName, @loDBF_CFG)
         CASE NOT EMPTY(tcDir)
            lcDir       = tcDir
         CASE VARTYPE( tcFileName ) = "C"
            lcDir = JUSTPATH( tcFileName )
         ENDCASE

         *!* /Changed by: LScheffler 13.6.2022

         IF NOT EMPTY(lcDir)
            .evaluateConfiguration( '', '', '', '', '', '', '', '', lcDir, 'D' )
         ENDIF

         llhasSupport    = .getCfgValue('l_AllowFolder') AND ICASE( lcExt == 'PJX', .getCfgValue('n_PJX_Conversion_Support') > 0 ;
            , lcExt == 'VCX', .getCfgValue('n_VCX_Conversion_Support') > 0 ;
            , lcExt == 'SCX', .getCfgValue('n_SCX_Conversion_Support') > 0 ;
            , lcExt == 'FRX', .getCfgValue('n_FRX_Conversion_Support') > 0 ;
            , lcExt == 'LBX', .getCfgValue('n_LBX_Conversion_Support') > 0 ;
            , lcExt == 'MNX', .getCfgValue('n_MNX_Conversion_Support') > 0 ;
            , lcExt == 'DBC', .getCfgValue('n_DBC_Conversion_Support') > 0 ;
            , lcExt == 'DBF', IIF(ISNULL(loDBF_CFG), .getCfgValue('n_DBF_Conversion_Support') > 0, loDBF_CFG.n_DBF_Conversion_Support > 0 ) ;
            , lcExt == 'FKY', .getCfgValue('n_FKY_Conversion_Support') > 0 ;
            , lcExt == 'MEM', .getCfgValue('n_MEM_Conversion_Support') > 0 ;
            , .F. )
      ENDWITH && THIS

      RETURN llhasSupport
   ENDPROC


   PROCEDURE hasSupport_Prg2Bin(tcFileName AS STRING, tcDir AS STRING) AS Boolean
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFilename                (@! IN    ) Extension to check whether the file has conversion support
      * tcDir                     (@? IN    ) Directory whose configuration should be returned
      * RETURN                    (v?    OUT) .T. if conversion is supported, .F. if not
      *---------------------------------------------------------------------------------------------------
      LOCAL llhasSupport, lcExt, lcDir ;
         , loDBF_CFG AS CL_DBF_CFG OF 'CL_DBF_CFG.prg'

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         loDBF_CFG   = .NULL.
         lcExt       = UPPER(JUSTEXT('.' + tcFileName))

         DO CASE
         CASE '\' $ tcFileName AND lcExt == .getCfgValue('c_DB2')
            lcDir       = JUSTPATH(tcFileName)
            .get_DBF_Configuration(tcFileName, @loDBF_CFG)
         CASE NOT EMPTY(tcDir)
            lcDir       = tcDir
         CASE VARTYPE( tcFileName ) = "C"
            lcDir = JUSTPATH( tcFileName )
         ENDCASE

         IF NOT EMPTY(lcDir)
            .evaluateConfiguration( '', '', '', '', '', '', '', '', lcDir, 'D' )
         ENDIF

         llhasSupport    = .getCfgValue('l_AllowFolder') AND ICASE( lcExt == .getCfgValue('c_PJ2'), .getCfgValue('n_PJX_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_VC2'), .getCfgValue('n_VCX_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_SC2'), .getCfgValue('n_SCX_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_FR2'), .getCfgValue('n_FRX_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_FR2D'), .getCfgValue('n_FRX_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_LB2'), .getCfgValue('n_LBX_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_LB2D'), .getCfgValue('n_LBX_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_MN2'), .getCfgValue('n_MNX_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_FK2'), .getCfgValue('n_FKY_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_ME2'), .getCfgValue('n_MEM_Conversion_Support') = 2 ;
            , lcExt == .getCfgValue('c_DB2'), IIF(ISNULL(loDBF_CFG), INLIST(.getCfgValue('n_DBF_Conversion_Support'), 2, 8), INLIST(loDBF_CFG.n_DBF_Conversion_Support, 2, 8) ) ;
            , lcExt == .getCfgValue('c_DC2'), .getCfgValue('n_DBC_Conversion_Support') = 2 ;
            , .F. )
      ENDWITH && THIS

      RETURN llhasSupport
   ENDPROC


   PROCEDURE conversionSupportType(tcFileName AS STRING, tlGenerarLog AS Boolean) AS INTEGER
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFilename                (@! IN    ) Extension to check whether the file has conversion support
      * RETURN                    (v?    OUT) Returns the support code
      *---------------------------------------------------------------------------------------------------
      LOCAL lnSupportType, lcExt, lcDir, lcFilename ;
         , loDBF_CFG AS CL_DBF_CFG OF 'CL_DBF_CFG.prg'

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            loDBF_CFG   = .NULL.
            lcExt       = UPPER(JUSTEXT('.' + tcFileName))

            IF '\' $ tcFileName AND INLIST(lcExt, .getCfgValue('c_DB2'), 'DBF') THEN
               lcFilename  = FORCEEXT(tcFileName, 'DBF')
               lcDir       = JUSTPATH(lcFilename)
               .get_DBF_Configuration(lcFilename, @loDBF_CFG, tlGenerarLog)
            ELSE
               lcDir       = SYS(5) + CURDIR()
            ENDIF

            IF NOT EMPTY(lcDir)
               .evaluateConfiguration( '', '', '', '', '', '', '', '', lcDir, 'D' )
            ENDIF

            lnSupportType   = ICASE( ;
               INLIST(lcExt, .getCfgValue('c_PJ2'), 'PJX'), .getCfgValue('n_PJX_Conversion_Support') ;
               , INLIST(lcExt, .getCfgValue('c_VC2'), 'VCX'), .getCfgValue('n_VCX_Conversion_Support') ;
               , INLIST(lcExt, .getCfgValue('c_SC2'), 'SCX'), .getCfgValue('n_SCX_Conversion_Support') ;
               , INLIST(lcExt, .getCfgValue('c_FR2'), .getCfgValue('c_FR2D'), 'FRX'), .getCfgValue('n_FRX_Conversion_Support') ;
               , INLIST(lcExt, .getCfgValue('c_LB2'), .getCfgValue('c_LB2D'), 'LBX'), .getCfgValue('n_LBX_Conversion_Support') ;
               , INLIST(lcExt, .getCfgValue('c_MN2'), 'MNX'), .getCfgValue('n_MNX_Conversion_Support') ;
               , INLIST(lcExt, .getCfgValue('c_FK2'), 'FKY'), .getCfgValue('n_FKY_Conversion_Support') ;
               , INLIST(lcExt, .getCfgValue('c_ME2'), 'MEM'), .getCfgValue('n_MEM_Conversion_Support') ;
               , INLIST(lcExt, .getCfgValue('c_DB2'), 'DBF'), IIF(ISNULL(loDBF_CFG), .getCfgValue('n_DBF_Conversion_Support'), loDBF_CFG.n_DBF_Conversion_Support ) ;
               , INLIST(lcExt, .getCfgValue('c_DC2'), 'DBC'), .getCfgValue('n_DBC_Conversion_Support') ;
               , 0 )

            lnSupportType   = INT(lnSupportType)
         ENDWITH && THIS

      FINALLY
         STORE .NULL. TO loDBF_CFG
         RELEASE loDBF_CFG
      ENDTRY

      RETURN lnSupportType
   ENDPROC


   PROCEDURE execute
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Full path of the file to convert or directory name to process
      *                                       - In Visual SourceSafe compatibility mode, used to query conversion support for the given file type
      * tcType                    (v? IN    ) Input file type. SCCTEXT.PRG compatibility
      *                                       - If "*" is given and tc_InputFile is a PJX, all project files and the PJX/2 are processed
      *                                       - If "*-" is given and tc_InputFile is a PJX, all project files are processed without the PJX/2
      *                                       - If "BIN2PRG" is given, the directory in tc_InputFile is processed to generate TX2 files
      *                                       - If "PRG2BIN" is given, the directory in tc_InputFile is processed to generate BIN files
      *                                       - If "Bin3Prg" is given and tc_InputFile is a PJX, exports the project to a mirrored tree
      *                                         (requires tcTextName or host cOutputFolder as the destination folder)
      *                                       - If "Prg3Bin" is given and tc_InputFile is a PJ2, imports the project from a mirrored tree
      *                                         (requires tcTextName or host cOutputFolder as the destination folder)
      *                                       - In Visual SourceSafe compatibility mode, indicates the file type to convert
      * tcTextName                (v? IN    ) Text file name. (Visual SourceSafe compatibility only)
      *                                       - With "Bin3Prg" or "Prg3Bin": mirrored destination root folder
      * tlGenText                 (v? IN    ) .T.=Generate text, .F.=Generate binary. (Visual SourceSafe compatibility only)
      * tcDontShowErrors          (v? IN    ) '1' to suppress error messages (MESSAGEBOX)
      * tcDebug                   (v? IN    ) '1' to enable debug mode (DEVELOPMENT ONLY)
      * tcDontShowProgress        (v? IN    ) '1' to disable the progress bar
      * toModulo                  (@?    OUT) Object reference of the generated module (for unit testing)
      * toEx                      (@?    OUT) Object with error information
      * tlRelanzarError           (v? IN    ) Whether the error should be re-thrown
      * tcOriginalFileName        (v? IN    ) For cases where inputFile is a temporary name and the correct name should be generated
      *                                       the correct name within the text version (e.g. in PJ2 and headers)
      * tcRecompile               (v? IN    ) Recompile ('1') the binary once regenerated. [Default behavior change]
      *                                       This change saves time, speed, and safety. Also, recompilation by FoxBin2Prg
      *                                       runs from the file directory, so relative references may
      *                                       cause compilation errors, typically #include directives.
      *                                       NOTE: If a Path is given instead of '1' (e.g. the project path), it will be used as the base for recompiling
      * tcNoTimestamps            (v? IN    ) Whether to clear the timestamp ('1') or not ('0' or empty)
      * tcBackupLevels            (v? IN    ) Number of backup levels to create (default '1')
      * tcClearUniqueID           (v? IN    ) Whether to clear the UniqueID ('1') or not ('0' or empty)
      * tcOptimizeByFilestamp     (v? IN    ) Whether to optimize by filestamp >= ('1'), equal only ('2'), or not optimize ('0' or empty)
      * tcCFG_File                (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
      *                                       Normal inheritance may or may not run, see setting InhibitInheritance
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile         , tcType             , tcTextName      , tlGenText         , tcDontShowErrors ;
                , tcDebug              , tcDontShowProgress , toModulo        , toEx AS EXCEPTION , tlRelanzarError  ;
                , tcOriginalFileName   , tcRecompile        , tcNoTimestamps  , tcBackupLevels    , tcClearUniqueID  ;
                , tcOptimizeByFilestamp, tcCFG_File

      TRY
         LOCAL I, lcPath, lnCodError, lcFileSpec, lcFile, lcInputFile_Type, lc_OldSetNotify ;
               , lnFileCount, lcErrorInfo, lcErrorFile, lnPCount, lnConversionOption, lnErrorIcon, llError ;
               , lcOldSetEscape, lcOldOnEscape, llEscKeyRestored, lcType, lcMirrorRoot, loCfgPass

         LOCAL laFiles(1,5)   ;
             , laDirInfo(1,5) ;
             , laParams(1)

         LOCAL lnVFPVersion, lcCFG_File

         LOCAL loEx   AS EXCEPTION ;
             , loFSO  AS Scripting.FileSystemObject ;
             , loWSH  AS WScript.SHELL ;
             , loCfgW

         LOCAL loCFG             ;
             , loLang            AS CL_LANG         OF 'cl_lang.prg' ;
             , loDBF_CFG         AS CL_DBF_CFG      OF 'CL_DBF_CFG.prg' ;
             , loFrm_Interactive AS frm_interactive OF 'frm_interactive.PRG' ;
             , loFrm_Main        AS frm_main        OF 'frm_main.PRG'


         WITH This AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'

            lc_OldSetNotify  = SET("Notify")
            SET NOTIFY OFF

            lnCodError       = 0
            loLang           = _SCREEN.o_FoxBin2Prg_Lang
            loFSO            = .o_FSO
            loWSH            = .o_WSH
            loCFG            = .NULL.
            lnPCount         = 0
            lcInputFile_Type = ''
            .l_Error         = .F.
            lcType           = EVL(tcType,'')
            tcType           = UPPER( lcType )
            llEscKeyRestored = .T.
            lnVFPVersion     = VERSION(5)

            .declareDLL()

            IF This.l_CancelWithEscKey THEN
               lcOldSetEscape  = SET("Escape")
               lcOldOnEscape   = ON("Escape")
               ON ESCAPE ERROR 1799
               SET ESCAPE ON
               llEscKeyRestored    = .F.
            ENDIF

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
                      + '*, *-, Bin3Prg, Prg3Bin, -BIN2PRG, -PRG2BIN, -BIN2TEXT, -TEXT2BIN, -SHOWMSG, -SIMERR_I0, -SIMERR_I1, -SIMERR_O1'

            OTHERWISE
                  * OK all versions from 900(3504) and up. For VFPA Guys :)

            ENDCASE

            DO CASE
            CASE ATC('-SIMERR_I0','-'+tcType) > 0
               .c_SimulateError = 'SIMERR_I0'

            CASE ATC('-SIMERR_I1','-'+tcType) > 0
               .c_SimulateError = 'SIMERR_I1'

            CASE ATC('-SIMERR_O1','-'+tcType) > 0
               .c_SimulateError = 'SIMERR_O1'
            ENDCASE

            IF .l_AutoClearProcessedFiles THEN
               && To avoid accumulating previous processes
               .clearProcessedFiles()
            ENDIF


            *-- Recognition of the specified class
            *-- Ej: [c:\desa\test\library.vcx::classname]
            IF '::' $ tc_InputFile THEN
               tc_InputFile          = STRTRAN(tc_InputFile, '::', '|')

               .c_ClassOperationType = Evl( Upper( Left( Alltrim( GetWordNum( tc_InputFile, 3, '|' ) ), 1) ), 'E')
               .c_ClassToConvert     = Lower( Alltrim( GetWordNum( tc_InputFile, 2, '|' ) ) )

               * CAUTION: evaluate this last one, otherwise the previous ones do not evaluate.
               tc_InputFile = Lower( Alltrim( GetWordNum( tc_InputFile, 1, '|' ) ) )
            ELSE
               .c_ClassOperationType   = ''
            ENDIF

            IF VARTYPE(tcCFG_File) = "O" AND !ISNULL(tcCFG_File)
               * Validate the object
               loCFG   = tcCFG_File
               IF NOT .isCfg( loCFG )
                  ERROR 'CFG object: Invalid object. Please, generate it with get_DirSettings() or newConfig()'
               ENDIF

               This.ensureCfg()
               This.o_Cfg.lockMasterFromObject( loCFG )

            ELSE

               lcCFG_File = Iif(Vartype(tcCFG_File)='C' AND !Empty(tcCFG_File),tcCFG_File,.F.)
               This.ensureCfg()
               This.o_Cfg.n_CFG_EvaluateFromParam = 0
            ENDIF

            *-- Adjust the path if it is not absolute
            tc_InputFile    = .get_AbsolutePath( tc_InputFile, .c_CurDir )

            *-- Determine InputFile type (File or Directory)
            IF Empty(lcInputFile_Type) AND NOT Empty(tc_InputFile)
               DO CASE
               CASE LEN(tc_InputFile) = 1
                  lcInputFile_Type    = C_FILETYPE_QUERYSUPPORT

               CASE ADir(laDirInfo, JustPath(tc_InputFile), "D") = 1 AND Substr( laDirInfo(1,5), 5, 1 ) = "D"
                  *-- Example: "c:\desa\"
                  lcInputFile_Type    = C_FILETYPE_DIRECTORY


               OTHERWISE
                  *-- Example: "c:\desa\*.scx", "c:\desa\file.ext", (file list)
                  lcInputFile_Type    = C_FILETYPE_FILE
               ENDCASE
            ENDIF

            IF Empty(tcRecompile) AND NOT Empty(lcInputFile_Type) AND NOT lcInputFile_Type == C_FILETYPE_QUERYSUPPORT THEN
               IF lcInputFile_Type == C_FILETYPE_DIRECTORY THEN
                  tcRecompile = tc_InputFile
               ELSE
                  tcRecompile = JUSTPATH( tc_InputFile )
               ENDIF
            ENDIF

            tcRecompile     = EVL(tcRecompile,'1')
            .c_Recompile    = tcRecompile

            .writeLog( REPLICATE( '*', 100 ) )
            .writeLog( loLang.C_MAIN_EXECUTION_LOC, 2 )
            .writeLog( REPLICATE( '*', 100 ) )
            .writeLog( '> ' + loLang.C_EXTERNAL_PARAMETERS_LOC + ':' )

            IF    UPPER(tcType)=='-C' OR tcType=='-t' ;
                  OR UPPER(tcType)=='C'  OR tcType=='t' THEN

               .writeLog( C_TAB + 'tcType:                       ' + TRANSFORM( EVL(lcType, '(empty)' ) ) )
               .writeLog( C_TAB + 'tc_OutputFile:                ' + TRANSFORM( EVL(tc_InputFile, '(empty)  -> Will use Default [' + .c_InputFile + ']' ) ) )
               .writeLog( C_TAB + 'tcCFG_File                    ' + TRANSFORM( EVL(tcCFG_File, '(empty)' ) ) )
               .writeLog( C_TAB + 'tcDebug:                      ' + TRANSFORM( EVL(tcDebug, '(empty)  -> Will use Default [' + TRANSFORM(.getCfgValue('n_Debug')) + ']' ) ) )
            ELSE
               .writeLog( C_TAB + 'tc_InputFile:                 ' + TRANSFORM( EVL(tc_InputFile, '(empty)  -> Will use Default [' + .c_InputFile + ']' ) ) )
               .writeLog( C_TAB + 'tcType:                       ' + TRANSFORM( EVL(lcType, '(empty)' ) ) )
               .writeLog( C_TAB + 'tcTextName:                   ' + TRANSFORM( EVL(tcTextName, '(empty)' ) ) )
               .writeLog( C_TAB + 'tlGenText:                    ' + TRANSFORM( EVL(tlGenText, '(empty)' ) ) )
               .writeLog( C_TAB + 'tcDontShowErrors:             ' + TRANSFORM( EVL(tcDontShowErrors, '(empty)  -> Will use Default [' + TRANSFORM(.getCfgValue('l_ShowErrors')) + ']' ) ) )
               .writeLog( C_TAB + 'tcDebug:                      ' + TRANSFORM( EVL(tcDebug, '(empty)  -> Will use Default [' + TRANSFORM(.getCfgValue('n_Debug')) + ']' ) ) )
               .writeLog( C_TAB + 'tcDontShowProgress:           ' + TRANSFORM( EVL(tcDontShowProgress, '(empty)  -> Will use Default [' + TRANSFORM(.getCfgValue('n_ShowProgressbar')) + ']' ) ) )
               .writeLog( C_TAB + 'tlRelanzarError:              ' + TRANSFORM( EVL(tlRelanzarError, '(empty)' ) ) )
               .writeLog( C_TAB + 'tcOriginalFileName:           ' + TRANSFORM( EVL(tcOriginalFileName, '(empty)  -> Will use Default [' + .c_OriginalFileName + ']' ) ) )
               .writeLog( C_TAB + 'tcRecompile:                  ' + TRANSFORM( EVL(tcRecompile, '(empty)  -> Will use Default [' + .c_Recompile + ']' ) ) )
               .writeLog( C_TAB + 'tcNoTimestamps:               ' + TRANSFORM( EVL(tcNoTimestamps, '(empty)  -> Will use Default [' + TRANSFORM(.getCfgValue('l_NoTimestamps')) + ']' ) ) )
               .writeLog( C_TAB + 'tcBackupLevels:               ' + TRANSFORM( EVL(tcBackupLevels, '(empty)  -> Will use Default [' + TRANSFORM(.getCfgValue('n_ExtraBackupLevels')) + ']' ) ) )
               .writeLog( C_TAB + 'tcClearUniqueID:              ' + TRANSFORM( EVL(tcClearUniqueID, '(empty)  -> Will use Default [' + TRANSFORM(.getCfgValue('l_ClearUniqueID')) + ']' ) ) )
               .writeLog( C_TAB + 'tcOptimizeByFilestamp:        ' + TRANSFORM( EVL(tcOptimizeByFilestamp, '(empty)  -> Will use Default [' + TRANSFORM(.getCfgValue('n_OptimizeByFilestamp')) + ']' ) ) )
               .writeLog( C_TAB + 'tcCFG_File                    ' + TRANSFORM( IIF(VARTYPE(tcCFG_File)='O' AND !ISNULL(tcCFG_File),'(object)',EVL(tcCFG_File, '(empty)' ) ) ) )
            ENDIF
            .writeLog( )

            *-- MAIN CONFIGURATION FILE
            * log settings for tcCFG_File - cfg as object
            .evaluateConfiguration( @tcDontShowProgress, @tcDontShowErrors        , @tcNoTimestamps       , @tcDebug     , @tcRecompile      ;
                                  , @tcBackupLevels    , @tcClearUniqueID         , @tcOptimizeByFilestamp, @tc_InputFile, @lcInputFile_Type ;
                                  ,                    , Vartype(tcCFG_File) = "O", IIF(VARTYPE(tcCFG_File)='O' AND !ISNULL(tcCFG_File), tcCFG_File, lcCFG_File) )

            * for Input file in the form file[.baseclass].class.vc2 (normaly sc2 too, but no support in old code)
            * allow to import only the class to file.VCX with n_RedirectClassType = 2
            * n_RedirectClassType = 0 will import all classes of file.VCX (as just handing file.vc2)
            * n_RedirectClassType = 1 will import the class to single lib file[.baseclass].class.VCX
            lcExt = JustExt( m.tc_InputFile )

            DO CASE
            CASE ( LOWER(m.lcType)=='-c' OR LOWER(m.lcType)=='c' )
               * not handled

            CASE ( m.lcType=='-t' OR m.lcType=='t' )
               * not handled

            CASE lcExt==This.getCfgValue('c_VC2') OR lcExt=="VCX"
               *ClassLib
               DO CASE
               CASE .getCfgValue('n_RedirectClassType') # 2
                  * not handled

               CASE !EMPTY(.c_ClassToConvert)
                  * not otherwise

               CASE .getCfgValue('n_UseClassPerFile') = 0
                  * not handled

               CASE '.' $ JUSTSTEM(JUSTFNAME(m.tc_InputFile))
                  * class file (stem contains library.classname)

                  *class
                  .c_ClassToConvert = LOWER( JUSTEXT( JUSTSTEM( m.tc_InputFile ) ) )
                  *remove class
                  tc_InputFile = LOWER( JUSTPATH( m.tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( m.tc_InputFile ) ) + '.' + JUSTEXT( m.tc_InputFile ) )
                  *remove baseclass
                  IF .getCfgValue('n_UseClassPerFile') = 2
                     *remove baseclass
                     tc_InputFile = LOWER( JUSTPATH( m.tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( m.tc_InputFile ) ) + '.' + JUSTEXT( m.tc_InputFile ) )
                  ENDIF
                  * count anything then -BIN2PRG as import
                  .c_ClassOperationType = IIF( ATC('-BIN2PRG','-'+tcType) > 0 OR ATC('-BIN2TEXT','-'+tcType) > 0, 'E', 'I')

               OTHERWISE
                  * not handled

               ENDCASE

            CASE lcExt==This.getCfgValue('c_SC2') OR lcExt=="SCX"
               *Form
               DO CASE
               CASE .getCfgValue('n_RedirectFormType') # 2
                  * not handled
               CASE !EMPTY(.c_ClassToConvert)
                  * not otherwise
               CASE .getCfgValue('n_UseFormPerFile') = 0
                  * not handled
               CASE '.' $ JUSTSTEM(JUSTFNAME(m.tc_InputFile))
                  * object file (stem contains form.objname)

                  *Form name
                  .c_ClassToConvert = LOWER( JUSTEXT( JUSTSTEM( m.tc_InputFile ) ) )
                  *remove obkject
                  tc_InputFile = LOWER( JUSTPATH( m.tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( m.tc_InputFile ) ) + '.' + JUSTEXT( m.tc_InputFile ) )
                  *remove baseclass
                  IF .getCfgValue('n_UseFormPerFile') = 2
                     *remove baseclass
                     tc_InputFile = LOWER( JUSTPATH( m.tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( m.tc_InputFile ) ) + '.' + JUSTEXT( m.tc_InputFile ) )
                  ENDIF
                  * count anything then -BIN2PRG as import
                  .c_ClassOperationType = IIF( ATC('-BIN2PRG','-'+tcType) > 0 OR ATC('-BIN2TEXT','-'+tcType) > 0, 'E', 'I')

               OTHERWISE
                  * not handled
               ENDCASE

            OTHERWISE
               * not handled
            ENDCASE
            *!* /Changed by: LScheffler 04.3.2021

            *!* Changed By LScheffler 3.1.2024
            *!* <pdm>
            *!* <change date="{^2024-01-03,08:27:00}">Changed By LScheffler<br />
            *!* Problem recreating ingle classes
            *!* </change>
            *!* </pdm>

            * Redefine input file name according to conversion type (IMPORT/EXPORT)
            IF .c_ClassOperationType = 'I'
               * When importing, change tc_InputFile syntax to use
               * the existing vc2 class conversion.
               * This turns a file with syntax "classlib.vcx::classname::import" into "classlib.classname.vc2"
               *                       IF .ATC(lcExt,c_VC2,"VCX")
               IF INLIST(lcExt,.getCfgValue('c_VC2'),"VCX")
                  IF .getCfgValue('n_UseClassPerFile') = 2
                     tc_InputFile        = ADDBS( .getPerFileDir( tc_InputFile, .getCfgValue('c_VC2'), .getCfgFlag('l_UseClassPerDir'), .getCfgInt('n_UseClassPerFile') ) ) ;
                        + JUSTSTEM(tc_InputFile) + '.*.' + .c_ClassToConvert + '.' + .getCfgValue('c_VC2')

                     IF ADIR(laFiles, tc_InputFile) = 1
                        tc_InputFile    = FULLPATH( laFiles(1,1), tc_InputFile )
                     ENDIF

                  ELSE && Asumo .getCfgValue('n_UseClassPerFile') = 1
                     tc_InputFile        = .getPerFileOutputPath( tc_InputFile, .c_ClassToConvert, .getCfgValue('c_VC2'), ;
                        .getCfgFlag('l_UseClassPerDir'), .getCfgInt('n_UseClassPerFile') )

                  ENDIF
               ENDIF

               *                       IF .ATC(lcExt,c_SC2,"SCX")
               IF INLIST(lcExt,.getCfgValue('c_SC2'),"SCX")
                  IF .getCfgValue('n_UseFormPerFile') = 2
                     tc_InputFile        = ADDBS( .getPerFileDir( tc_InputFile, .getCfgValue('c_SC2'), .getCfgFlag('l_UseFormPerDir'), .getCfgInt('n_UseFormPerFile') ) ) ;
                        + JUSTSTEM(tc_InputFile) + '.*.' + .c_ClassToConvert + '.' + .getCfgValue('c_SC2')

                     IF ADIR(laFiles, tc_InputFile) = 1
                        tc_InputFile    = FULLPATH( laFiles(1,1), tc_InputFile )
                     ENDIF

                  ELSE && Asumo .getCfgValue('n_UseFormPerFile') = 1
                     tc_InputFile        = .getPerFileOutputPath( tc_InputFile, .c_ClassToConvert, .getCfgValue('c_SC2'), ;
                        .getCfgFlag('l_UseFormPerDir'), .getCfgInt('n_UseFormPerFile') )

                  ENDIF
               ENDIF
            ENDIF
            *!* /Changed By LScheffler 3.1.2024

            loLang          = _SCREEN.o_FoxBin2Prg_Lang

            DO CASE
               CASE VERSION(5) < 900
               *-- 'FOXBIN2PRG is for Visual FoxPro 9.0 only!'
               MESSAGEBOX( loLang.C_FOXBIN2PRG_JUST_VFP_9_LOC, 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_WARN_CAPTION_LOC + ' (' + .c_Language + ')', 60000 )
               lnCodError  = 1

               CASE tcType == 'BIN3PRG'
               *-- Export a complete PJX project to a mirrored text tree (CLI: MAIN.PRG Bin3Prg)
               lcMirrorRoot = EVL(.cOutputFolder, tcTextName)
               IF NOT EMPTY(lcMirrorRoot)
                  lcMirrorRoot = .get_AbsolutePath(lcMirrorRoot, .c_CurDir)
               ENDIF
               IF EMPTY(lcMirrorRoot)
                  ERROR loLang.C_INVALID_PARAMETER_LOC + ': Bin3Prg requires tcTextName or tcOutputFolder'
               ENDIF
               IF UPPER(JUSTEXT(tc_InputFile)) <> 'PJX'
                  ERROR loLang.C_INVALID_PARAMETER_LOC + ': Bin3Prg requires a .PJX project file'
               ENDIF
               loCfgPass  = .NULL.
               IF VARTYPE(loCFG) = 'O' AND !ISNULL(loCFG)
                  loCfgPass = loCFG
               ELSE
                  IF VARTYPE(tcCFG_File) = 'C' AND !EMPTY(tcCFG_File)
                     loCfgPass = tcCFG_File
                  ENDIF
               ENDIF
               lnCodError = .exportProjectTree(tc_InputFile, lcMirrorRoot, loCfgPass)

            CASE tcType == 'PRG3BIN'
               *-- Import a complete PJ2 project from a mirrored text tree (CLI: MAIN.PRG Prg3Bin)
               lcMirrorRoot = EVL(.cOutputFolder, tcTextName)
               IF NOT EMPTY(lcMirrorRoot)
                  lcMirrorRoot = .get_AbsolutePath(lcMirrorRoot, .c_CurDir)
               ENDIF
               IF EMPTY(lcMirrorRoot)
                  ERROR loLang.C_INVALID_PARAMETER_LOC + ': Prg3Bin requires tcTextName or tcOutputFolder'
               ENDIF
               IF UPPER(JUSTEXT(tc_InputFile)) <> UPPER(.getCfgValue('c_PJ2'))
                  ERROR loLang.C_INVALID_PARAMETER_LOC + ': Prg3Bin requires a .' + .getCfgValue('c_PJ2') + ' project file'
               ENDIF
               loCfgPass  = .NULL.
               IF VARTYPE(loCFG) = 'O' AND !ISNULL(loCFG)
                  loCfgPass = loCFG
               ELSE
                  IF VARTYPE(tcCFG_File) = 'C' AND !EMPTY(tcCFG_File)
                     loCfgPass = tcCFG_File
                  ENDIF
               ENDIF
               lnCodError = .importProjectTree(tc_InputFile, lcMirrorRoot, loCfgPass)

               * added option to create config files
            CASE ( m.lcType=='-t' OR m.lcType=='t' ) AND ( VARTYPE( m.tc_InputFile )='C' AND !EMPTY( m.tc_InputFile ) )
               loLang       = _SCREEN.o_FoxBin2Prg_Lang
               STRTOFILE( STRTRAN( STRTRAN( '*' + m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg, CR_LF, CR_LF + '*'), CR_LF + '*' + CR_LF, CR_LF+CR_LF), m.tc_InputFile )
               .writeLog_Flush()

            CASE ( m.lcType=='-c' OR m.lcType=='c' )
               tc_InputFile = IIF( VARTYPE( m.tc_InputFile )='C' AND !EMPTY( m.tc_InputFile ), m.tc_InputFile, 'FoxBin2Prg._cfg' )
               loLang       = _SCREEN.o_FoxBin2Prg_Lang
               STRTOFILE( STRTRAN( '*' + STRTRAN( m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg, CR_LF, CR_LF + '*'), CR_LF + '*' + CR_LF, CR_LF+CR_LF), m.tc_InputFile )
               .writeLog_Flush()

               * added option to create config files with values
            CASE ( m.lcType=='-C' OR m.lcType=='C' )
               LOCAL;
                  lcText    AS STRING,;
                  lcValue   AS STRING,;
                  lcReturn  AS STRING,;
                  lnLines   AS NUMBER,;
                  lnLine    AS NUMBER,;
                  lnOptions AS NUMBER,;
                  lnOption  AS NUMBER

               lnOptions = 59

               LOCAL ARRAY;
                  laLines(1),;
                  laOptions(m.lnOptions,3)

               tc_InputFile = IIF( VARTYPE( m.tc_InputFile )='C' AND !EMPTY( m.tc_InputFile ), m.tc_InputFile, 'FoxBin2Prg._cfg' )
               loLang       = _SCREEN.o_FoxBin2Prg_Lang
               lcText       = STRTRAN( '*' + STRTRAN( m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg, CR_LF, CR_LF + '*'), CR_LF + '*' + CR_LF, CR_LF+CR_LF)
               lnLines      = ALINES(laLines,m.lcText)

               *now for each option
               laOptions(01,1) = "*ShowProgressbar:"                   && 0=Don't show, 1=Allways show, 2= Show only for multi-file processing
               laOptions(01,2) = ".getCfgValue('n_ShowProgressbar')"
               laOptions(01,3) = 0
               laOptions(02,1) = "*DontShowErrors:"                    && 0,1 Show message errors by default
               laOptions(02,2) = ".getCfgValue('l_ShowErrors')"
               laOptions(02,3) = 3
               laOptions(03,1) = "*NoTimestamps:"                      && 0,1 Clear timestamps by default for minimize differences
               laOptions(03,2) = ".getCfgValue('l_NoTimestamps')"
               laOptions(03,3) = 1
               laOptions(04,1) = "*Debug:"                             && 0,1 Don't Activate individual <file>.Log by default
               laOptions(04,2) = ".getCfgValue('n_Debug')"
               laOptions(04,3) = 0
               *** DH 2024-08-26: added text for option 2
               laOptions(05,1) = "*BodyDevInfo:"                       && 0,1 [0=Don't keep DevInfo for body pjx records], 1=Keep DevInfo, 2 = Don't keep DevInfo or ObjRev
               laOptions(05,2) = ".getCfgValue('n_BodyDevInfo')"
               laOptions(05,3) = 0
               laOptions(06,1) = "*ExtraBackupLevels:"                 && n By default 1 BAK is created. With this you can make more .N.BAK, or none
               laOptions(06,2) = ".getCfgValue('n_ExtraBackupLevels')"
               laOptions(06,3) = 0
               laOptions(07,1) = "*ClearUniqueID:"                     && 0,1 0=Keep UniqueID in text files, 1=Clear Unique ID. Useful for Diff and Merge
               laOptions(07,2) = ".getCfgValue('l_ClearUniqueID')"
               laOptions(07,3) = 1
               laOptions(08,1) = "*ClearDBFLastUpdate:"                && 0,1 0=Keep DBF LastUpdate, 1=Clear DBF LastUpdate. Useful for Diff.
               laOptions(08,2) = ".getCfgValue('l_ClearDBFLastUpdate')"
               laOptions(08,3) = 1
               laOptions(09,1) = "*OptimizeByFilestamp:"               && 0,1,2 1=Optimize file regeneration depending on file timestamp. Dangerous while working with branches!
               laOptions(09,2) = ".getCfgValue('n_OptimizeByFilestamp')"
               laOptions(09,3) = 0
               laOptions(10,1) = "*RemoveNullCharsFromCode:"           && 0,1 1=.t. 1=Drop .Null. chars from source code
               laOptions(10,2) = ".getCfgValue('l_RemoveNullCharsFromCode')"
               laOptions(10,3) = 1
               laOptions(11,1) = "*RemoveZOrderSetFromProps:"          && 0,1 1=.t. 0=Do not remove ZOrderSet property from object, 1=Remove ZOrderSet property from object
               laOptions(11,2) = ".getCfgValue('l_RemoveZOrderSetFromProps')"
               laOptions(11,3) = 1
               laOptions(12,1) = "*Language:"                          && Language of shown messages and LOGs. EN=English, FR=French, ES=Spanish, DE=German, Not defined = AUTOMATIC [DEFAULT]
               laOptions(12,2) = ".getCfgValue('c_Language_In')"
               laOptions(12,3) = 0
               laOptions(13,1) = "*ExcludeDBFAutoincNextval:"          && 0,1 [0=Do not exclude this value from db2], 1=Exclude this value from db2
               laOptions(13,2) = ".getCfgValue('n_ExcludeDBFAutoincNextval')"
               laOptions(13,3) = 0
               laOptions(14,1) = "*PRG_Compat_Level:"                  && n [0=Legacy], 1=Use HELPSTRING as Class Procedure comment
               laOptions(14,2) = ".getCfgValue('n_PRG_Compat_Level')"
               laOptions(14,3) = 0
               laOptions(15,1) = "*HomeDir:"                           && 0,1 0 = don't save HomeDir in PJ2, [1 = save HomeDir in PJ2]
               laOptions(15,2) = ".getCfgValue('n_HomeDir')"
               laOptions(15,3) = 0
               laOptions(16,1) = "*PJX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(16,2) = ".getCfgValue('n_PJX_Conversion_Support')"
               laOptions(16,3) = 0
               laOptions(17,1) = "*VCX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(17,2) = ".getCfgValue('n_VCX_Conversion_Support')"
               laOptions(17,3) = 0
               laOptions(18,1) = "*SCX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(18,2) = ".getCfgValue('n_SCX_Conversion_Support')"
               laOptions(18,3) = 0
               laOptions(19,1) = "*FRX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(19,2) = ".getCfgValue('n_FRX_Conversion_Support')"
               laOptions(19,3) = 0
               laOptions(20,1) = "*LBX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(20,2) = ".getCfgValue('n_LBX_Conversion_Support')"
               laOptions(20,3) = 0
               laOptions(21,1) = "*DBC_Conversion_Support:"            && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(21,2) = ".getCfgValue('n_DBC_Conversion_Support')"
               laOptions(21,3) = 0
               laOptions(22,1) = "*DBF_Conversion_Support:"            && n 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
               laOptions(22,2) = ".getCfgValue('n_DBF_Conversion_Support')"
               laOptions(22,3) = 0
               laOptions(23,1) = "*MNX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(23,2) = ".getCfgValue('n_MNX_Conversion_Support')"
               laOptions(23,3) = 0
               laOptions(24,1) = "*FKY_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff)
               laOptions(24,2) = ".getCfgValue('n_FKY_Conversion_Support')"
               laOptions(24,3) = 0
               laOptions(25,1) = "*MEM_Conversion_Support:"            && 0=No support, 1=Generate TXT only (Diff)
               laOptions(25,2) = ".getCfgValue('n_MEM_Conversion_Support')"
               laOptions(25,3) = 0
               laOptions(26,1) = "*DBF_Conversion_Included:"           && n If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
               laOptions(26,2) = ".getCfgValue('c_DBF_Conversion_Included')"
               laOptions(26,3) = 6
               laOptions(27,1) = "*DBF_Conversion_Excluded:"           && n If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
               laOptions(27,2) = ".getCfgValue('c_DBF_Conversion_Excluded')"
               laOptions(27,3) = 5
               laOptions(28,1) = "*OldFilesPerDBC:"                    && 0,1 1=.t. 1=Turns the File per DBC options on, 0 uses the old UseClassPerFile etc settings.
               laOptions(28,2) = ".getCfgValue('l_OldFilesPerDBC')"
               laOptions(28,3) = 1
               laOptions(29,1) = "*UseFilesPerDBC:"                    && 0,1 0=One database dc2 file, 1=Multiple file.*.*.dc2 files
               laOptions(29,2) = ".getCfgValue('n_UseFilesPerDBC')"
               laOptions(29,3) = 0
               laOptions(30,1) = "*RedirectFilePerDBCToMain:"          && 0,1 1=.t. 0=Don't redirect to file.dc2, 1=Redirect to file.tx2 when selecting file.item.*.dc2
               laOptions(30,2) = ".getCfgValue('l_RedirectFilePerDBCToMain')"
               laOptions(30,3) = 1
               laOptions(31,1) = "*ItemPerDBCCheck:"                   && 0,1 1=.t. 0=Don't check file.item.*.dc2 inclusion, 1=Check file.item.*.dc2 inclusion
               laOptions(31,2) = ".getCfgValue('l_ItemPerDBCCheck')"
               laOptions(31,3) = 1
               laOptions(32,1) = "*DBF_BinChar_Base64:"                && 0,1 1=.t. 0=For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform (default)
               laOptions(32,2) = ".getCfgValue('l_DBF_BinChar_Base64')"
               laOptions(32,3) = 1
               laOptions(33,1) = "*DBF_IncludeDeleted:"                && 0,1 1=.t. 0=Do not include deleted records (default), 1=Include deleted records
               laOptions(33,2) = ".getCfgValue('l_DBF_IncludeDeleted')"
               laOptions(33,3) = 1
               laOptions(34,1) = "*CheckFileInPath:"                   && n 0=Default,no check. Determines 2Txt deals with files not in the subfolders of the PJX
               laOptions(34,2) = ".getCfgValue('n_CheckFileInPath')"
               laOptions(34,3) = 0
               laOptions(35,1) = "*UseClassPerFile:"                   && n 0=One library tx2 file, 1=Multiple file.class.tx2 files, 2=Multiple file.baseclass.class.tx2 files
               laOptions(35,2) = ".getCfgValue('n_UseClassPerFile')"
               laOptions(35,3) = 0
               laOptions(36,1) = "*RedirectClassPerFileToMain:"        && 0,1 1=.t. 0=Don't redirect to file.tx2, 1=Redirect to file.tx2 when selecting file.class.tx2
               laOptions(36,2) = ".getCfgValue('l_RedirectClassPerFileToMain')"
               laOptions(36,3) = 1
               laOptions(37,1) = "*RedirectClassType:"                 && 0,1,2 For classes created with UseClassPerFile>0 in the form file[.baseclass].class.tx2
               laOptions(37,2) = ".getCfgValue('n_RedirectClassType')"
               laOptions(37,3) = 0
               laOptions(38,1) = "*ClassPerFileCheck:"                 && 0,1 1=.t. 0=Don't check file.class.tx2 inclusion, 1=Check file.class.tx2 inclusion
               laOptions(38,2) = ".getCfgValue('l_ClassPerFileCheck')"
               laOptions(38,3) = 1
               laOptions(39,1) = "*UseClassPerDir:"                    && 0,1 0=flat layout, 1=subdir layout (requires UseClassPerFile>0)
               laOptions(39,2) = ".getCfgValue('l_UseClassPerDir')"
               laOptions(39,3) = 1
               laOptions(40,1) = "*extension: pj2="                    && ext Text file to PJX
               laOptions(40,2) = ".getCfgValue('c_PJ2')"
               laOptions(40,3) = 2
               laOptions(41,1) = "*extension: vc2="                    && ext Text file to VCX
               laOptions(41,2) = ".getCfgValue('c_VC2')"
               laOptions(41,3) = 2
               laOptions(42,1) = "*extension: sc2="                    && ext Text file to SCX
               laOptions(42,2) = ".getCfgValue('c_SC2')"
               laOptions(42,3) = 2
               laOptions(43,1) = "*extension: fr2="                    && ext Text file to FRX
               laOptions(43,2) = ".getCfgValue('c_FR2')"
               laOptions(43,3) = 2
               laOptions(44,1) = "*extension: lb2="                    && ext Text file to LBX
               laOptions(44,2) = ".getCfgValue('c_LB2')"
               laOptions(44,3) = 2
               laOptions(45,1) = "*extension: mn2="                    && ext Text file to MNX
               laOptions(45,2) = ".getCfgValue('c_MN2')"
               laOptions(45,3) = 2
               laOptions(46,1) = "*extension: db2="                    && ext Text file to DBF
               laOptions(46,2) = ".getCfgValue('c_DB2')"
               laOptions(46,3) = 2
               laOptions(47,1) = "*extension: dc2="                    && ext Text file to DBC
               laOptions(47,2) = ".getCfgValue('c_DC2')"
               laOptions(47,3) = 2
               laOptions(48,1) = "*extension: fk2="                    && ext Text file to FKY
               laOptions(48,2) = ".getCfgValue('c_FK2')"
               laOptions(48,3) = 2
               laOptions(49,1) = "*extension: me2="                    && ext Text file to MEM
               laOptions(49,2) = ".getCfgValue('c_ME2')"
               laOptions(49,3) = 2
               laOptions(50,1) = "*BackgroundImage:"                   && Background image
               laOptions(50,2) = ".getCfgValue('c_BackgroundImage')"
               laOptions(50,3) = 7
               laOptions(51,1) = "*InhibitInheritance:"                && Inheritance out of config via parameter
               laOptions(51,2) = ".getCfgValue('n_InhibitInheritance')"
               laOptions(51,3) = 4
               laOptions(52,1) = "*UseFormSettings:"                   && 0,1 1=.t. 1=Turns the File per SCX options on, 0 uses the old UseClassPerFile etc settings.
               laOptions(52,2) = ".getCfgValue('l_UseFormSettings')"
               laOptions(52,3) = 1
               laOptions(53,1) = "*UseFormPerFile:"                    && n 0=One library sc2 file, 1=Multiple Form.Obj.sc2 files, 2=Multiple Form.baseclass.Obj.sc2 files
               laOptions(53,2) = ".getCfgValue('n_UseFormPerFile')"
               laOptions(53,3) = 0
               laOptions(54,1) = "*RedirectFormPerFileToMain:"         && 0,1 1=.t. 0=Don't redirect to Form.sc2, 1=Redirect to file.sc2 when selecting Form.Obj.sc2
               laOptions(54,2) = ".getCfgValue('l_RedirectFormPerFileToMain')"
               laOptions(54,3) = 1
               laOptions(55,1) = "*RedirectFormType:"                  && 0,1,2 For Formes created with UseFormPerFile>0 in the form Form[.baseclass].Obj.sc2
               laOptions(55,2) = ".getCfgValue('n_RedirectFormType')"
               laOptions(55,3) = 0
               laOptions(56,1) = "*FormPerFileCheck:"                  && 0,1 1=.t. 0=Don't check Form.Obj.sc2 inclusion, 1=Check Form.Obj.sc2 inclusion
               laOptions(56,2) = ".getCfgValue('l_FormPerFileCheck')"
               laOptions(56,3) = 1
               laOptions(57,1) = "*UseFormPerDir:"                    && 0,1 0=flat layout, 1=subdir layout (requires UseFormPerFile>0)
               laOptions(57,2) = ".getCfgValue('l_UseFormPerDir')"
               laOptions(57,3) = 1
               laOptions(58,1) = "*extension: fr2d="                   && ext Text file to Fox 2.x FRX
               laOptions(58,2) = ".getCfgValue('c_FR2D')"
               laOptions(58,3) = 2
               laOptions(59,1) = "*extension: lb2d="                   && ext Text file to Fox 2.x LBX
               laOptions(59,2) = ".getCfgValue('c_LB2D')"
               laOptions(59,3) = 2

               FOR lnOption = 1 TO m.lnOptions
                  lnLine = ASCAN( m.laLines , m.laOptions( m.lnOption, 1 ), 1, -1, 1, 4)
                  IF m.lnLine >0 THEN
                     lcText  = m.laLines( m.lnLine )
                     lcValue = STREXTRACT( m.lcText , m.laOptions( m.lnOption, 1 ), '&'+'&' ,1 , 3)
                     DO CASE
                     CASE m.laOptions( m.lnOption, 3 ) = 0 OR m.laOptions( m.lnOption, 3 ) = 4
                        *numeric to numeric
                        lcReturn = PADR(' ' + TRANSFORM( EVALUATE( m.laOptions( m.lnOption, 2 ) ) ), LEN(m.lcValue) + 1 )

                     CASE m.laOptions( m.lnOption, 3 ) = 1
                        *logic to numeric
                        lcReturn = PADR(' ' + IIF ( EVALUATE( m.laOptions( m.lnOption, 2 )), '1', '0' ), LEN(m.lcValue) + 1 )

                     CASE m.laOptions( m.lnOption, 3 ) = 2
                        *extension to text
                        lcReturn = PADR(EVALUATE( m.laOptions( m.lnOption, 2 )), LEN(m.lcValue) + 1 )

                     CASE m.laOptions( m.lnOption, 3 ) = 3
                        *logic to numeric, inverted
                        lcReturn = PADR(' ' + IIF ( EVALUATE( m.laOptions( m.lnOption, 2 )), '0', '1' ), LEN(m.lcValue) + 1 )

                     CASE m.laOptions( m.lnOption, 3 ) = 5
                        *special, Conversion Exclude for DBF
                        lcReturn = ' ' + TRANSFORM( EVALUATE( m.laOptions( m.lnOption, 2 ) ) )
                        lcReturn = PADR( m.lcReturn , MAX( LEN ( m.lcReturn )+1, LEN( m.lcValue ) + 1 ) )

                     CASE m.laOptions( m.lnOption, 3 ) = 6
                        *special, Conversion Include for DBF (empty => *)
                        IF EMPTY( EVALUATE( m.laOptions( m.lnOption, 2 ) ) )
                           lcReturn = ' *'

                        ELSE  &&Empty( Evaluate( m.laOptions( m.lnOption, 2 ) ) )
                           lcReturn = ' ' + TRANSFORM( EVALUATE( m.laOptions( m.lnOption, 2 ) ) )

                        ENDIF &&Empty( Evaluate( m.laOptions( m.lnOption, 2 ) ) )
                        lcReturn = PADR( m.lcReturn , MAX( LEN ( m.lcReturn )+1, LEN( m.lcValue ) + 1 ) )

                     CASE m.laOptions( m.lnOption, 3 ) = 7
                        *special, Background Image (foxbin2prg.jpg => empty)
                        IF LOWER( JUSTFNAME ( EVALUATE( m.laOptions( m.lnOption, 2 ) ) ) ) == 'foxbin2prg.jpg' THEN
                           lcReturn = ''

                        ELSE &&LOWER( JUSTFNAME ( Evaluate( m.laOptions( m.lnOption, 2 ) ) ) ) == 'foxbin2prg.jpg'
                           lcReturn = ' ' + TRANSFORM( EVALUATE( m.laOptions( m.lnOption, 2 ) ) )

                        ENDIF &&LOWER( JUSTFNAME ( Evaluate( m.laOptions( m.lnOption, 2 ) ) ) ) == 'foxbin2prg.jpg'
                        lcReturn = PADR( m.lcReturn , MAX( LEN ( m.lcReturn )+1, LEN( m.lcValue ) + 1 ) )

                     OTHERWISE
                        * not defined. loop
                        LOOP

                     ENDCASE
                     IF m.laOptions( m.lnOption, 3 ) = 4 THEN
                        *numeric to numeric, keep comment
                        laLines( m.lnLine ) = STRTRAN(m.laLines( m.lnLine ) , m.lcValue, m.lcReturn)

                     ELSE  &&m.laOptions( m.lnOption, 3 ) = 4
                        laLines( m.lnLine ) = SUBSTR(STRTRAN(m.laLines( m.lnLine ) , m.lcValue, m.lcReturn), 2 )

                     ENDIF &&m.laOptions( m.lnOption, 3 ) = 4

                  ENDIF &&lnLine >0

               ENDFOR &&lnOption

               lcText  = ''

               lnLines = m.lnLines+1
               DIMENSION;
                  M.laLines( m.lnLines )

               AINS(m.laLines,4)
               laLines( 4 ) = TEXTMERGE( m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 )
               FOR lnLine = 1 TO m.lnLines
                  lcText = m.lcText+ m.laLines( m.lnLine )+CR_LF
               ENDFOR &&lnLine

               STRTOFILE(  m.lcText, m.tc_InputFile )

               .writeLog_Flush()

               *!* /Changed by: LScheffler 07.3.2021

            CASE EMPTY(tc_InputFile)
               *-- (Syntax and usage example)
               loFrm_Main  = NewObject( 'frm_main', 'frm_main.prg' , null, This)
               loFrm_Main.SHOW()
               READ EVENTS
               lnCodError  = 0

            OTHERWISE
               *-- NORMAL EXECUTION


               IF      (    ATC('-INTERACTIVE', ('-' + tcType)) > 0 ;
                         OR ATC('-?', ('-' + tcType)) > 0 );
                     AND ATC('-BIN2PRG', ('-' + tcType)) = 0 ;
                     AND ATC('-PRG2BIN', ('-' + tcType)) = 0 ;
                     AND ATC('-BIN2TEXT','-'+tcType) = 0 ;
                     AND ATC('-TEXT2BIN','-'+tcType) = 0 ;
                     AND lcInputFile_Type == C_FILETYPE_DIRECTORY

                  *-- A directory was selected and you can choose: Bin2Txt, Txt2Bin, or None
                  .writeLog( loLang.C_INTERACTIVE_DIRECTORY_SELECTION_LOC )

                  loFrm_Interactive = NewObject('frm_interactive', 'frm_interactive.prg' , null , This)
                  loFrm_Interactive.Show()

                  READ EVENTS
                  lnConversionOption  = loFrm_Interactive.n_ConversionType

                  IF loFrm_Interactive.l_FileTimeStampOptimization
                     IF .getCfgValue('n_OptimizeByFilestamp') = 0 THEN
                        .setCfgValue( 'n_OptimizeByFilestamp', 2 )
                     ENDIF
                  ELSE
                     .setCfgValue( 'n_OptimizeByFilestamp', 0 )
                  ENDIF

                  loFrm_Interactive.RELEASE()
                  loFrm_Interactive = .NULL.

                  DO CASE
                  CASE lnConversionOption = 1     && Bin2Txt
                     tcType  = tcType + '-BIN2PRG'

                  CASE lnConversionOption = 2     && Txt2Bin
                     tcType  = tcType + '-PRG2BIN'

                  OTHERWISE   && None
                     ERROR 1799  && Conversion Cancelled
                  ENDCASE
               ENDIF

               *-- Evaluation of input FileSpec
               DO CASE
               CASE ATC('-BIN2PRG', ('-' + tcType)) = 0 AND ATC('-PRG2BIN', ('-' + tcType)) = 0 ;
                     AND ATC('-BIN2TEXT','-'+tcType) = 0 AND ATC('-TEXT2BIN','-'+tcType) = 0 ;
                     AND lcInputFile_Type == C_FILETYPE_FILE ;
                     AND ( '*' $ JUSTEXT( tc_InputFile ) OR '?' $ JUSTEXT( tc_InputFile ) )

                  IF .getCfgValue('l_ShowErrors')
                     *MESSAGEBOX( 'Extensions * or ? are not allowed because it is dangerous (binaries can be overwritten with empty xx2 files).', 0+48+4096, 'FOXBIN2PRG: ERROR!!', 60000 )
                     MESSAGEBOX( loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC, 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_ERROR_CAPTION_LOC, 60000 )
                     EXIT
                  ELSE
                     ERROR loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC
                  ENDIF


               CASE lcInputFile_Type == C_FILETYPE_FILE AND ( '*' $ JUSTSTEM( tc_InputFile ) OR '?' $ JUSTSTEM( tc_InputFile ) )
                  *-- ALL FILES OF ONE EXTENSION ARE REQUESTED
                  lcFileSpec  = FULLPATH( tc_InputFile )
                  .c_LogFile  = ADDBS( JUSTPATH( lcFileSpec ) ) + STRTRAN( JUSTFNAME( lcFileSpec ), '*', '_ALL' ) + '.LOG'

                  IF .getCfgValue('n_Debug') > 0 THEN
                     ERASE ( .c_LogFile )
                  ENDIF

                  IF EVL(tcType,'0') <> '*' THEN
                     IF .getCfgValue('n_ShowProgressbar') <> 0 AND .l_ProcessFiles THEN
                        .loadProgressbarForm()
                     ENDIF

                     DO CASE
                     CASE .getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
                        CD (tcRecompile)
                     CASE tcRecompile == '1'
                        CD (JUSTPATH(lcFileSpec))
                     ENDCASE
                  ENDIF

                  lnFileCount = ADIR( laFiles, lcFileSpec, '', 1 )

                  FOR I = 1 TO lnFileCount
                     toModulo    = .NULL.
                     lcFile      = FORCEPATH( laFiles(m.I,1), JUSTPATH( lcFileSpec ) )

                     DO CASE
                     CASE UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == 'PJX' AND LEFT(EVL(tcType,'0'),1) == '*'
                        *-- CONVERT ALL FILES OF ONE OR MORE PJX PROJECTS TO TEXT
                        *-- Filespec: "*.PJX", "*"
                        .evaluate_Full_PJX(lcFile, tcRecompile, @toModulo, @toEx, tcOriginalFileName, .c_LogFile, tcType)

                     CASE UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == .getCfgValue('c_PJ2') AND LEFT(EVL(tcType,'0'),1) == '*'
                        *-- CONVERT ALL FILES OF ONE OR MORE PJ2 PROJECTS TO BINARY
                        *-- Filespec: "*.PJ2", "*"
                        .evaluate_Full_PJ2(lcFile, tcRecompile, @toModulo, @toEx, tcOriginalFileName, .c_LogFile, tcType)

                     CASE ATC('-BIN2PRG', ('-' + tcType)) > 0;
                           OR ATC('-BIN2TEXT','-'+tcType) > 0
                        *-- CONVERT ALL FILES IN A DIRECTORY TO TEXT
                        *-- Filespec: "*.*"
                        IF .hasSupport_Bin2Prg(lcFile) THEN
                           .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                           lnCodError = .convert( lcFile, @toModulo, @toEx, .F., tcOriginalFileName )
                           .writeLog_Flush()

                           DO CASE
                           CASE lnCodError = 1799  && Conversion Cancelled
                              ERROR 1799

                           CASE lnCodError > 0
                              .doWriteErrorLog( @toEx )
                              llError     = .T.
                              .l_Error    = .F.
                           ENDCASE
                        ENDIF

                     CASE ATC('-PRG2BIN', ('-' + tcType)) > 0;
                           OR ATC('-TEXT2BIN','-'+tcType) > 0
                        *-- CONVERT ALL FILES IN A DIRECTORY TO BINARY
                        *-- Filespec: "*.*"
                        IF .hasSupport_Prg2Bin(lcFile) THEN
                           .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                           lnCodError = .convert( lcFile, @toModulo, @toEx, .F., tcOriginalFileName )
                           .writeLog_Flush()

                           DO CASE
                           CASE lnCodError = 1799  && Conversion Cancelled
                              ERROR 1799

                           CASE lnCodError > 0
                              .doWriteErrorLog( @toEx )
                              llError     = .T.
                              .l_Error    = .F.
                           ENDCASE
                        ENDIF

                     CASE EMPTY( JUSTEXT( EVL(tc_InputFile,'') ) )
                        *-- NO EXTENSION WAS SPECIFIED
                        ERROR loLang.C_INVALID_PARAMETER_LOC + ': cInputFile = "' + tc_InputFile + '"'

                     OTHERWISE
                        *-- OTHER FILES
                        *-- Filespec: "*.EXT"
                        .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                        lnCodError = .convert( lcFile, @toModulo, @toEx, .T., tcOriginalFileName )
                        .writeLog_Flush()

                        DO CASE
                        CASE lnCodError = 1799  && Conversion Cancelled
                           ERROR 1799

                        CASE lnCodError > 0
                           .doWriteErrorLog( @toEx )
                        ENDCASE
                     ENDCASE
                  ENDFOR && I = 1 TO lnFileCount

                  IF llError
                     .l_Error = .T.
                  ENDIF

                  EXIT


               CASE ATC('-BIN2PRG', ('-' + tcType)) > 0;
                     OR ATC('-BIN2TEXT','-'+tcType) > 0
                  .writeLog( '> ' + loLang.C_OPTION_LOC + ': BIN2PRG' )

                  IF .getCfgValue('n_ShowProgressbar') <> 0 AND .l_ProcessFiles THEN
                     .loadProgressbarForm()
                     .o_Frm_Avance.CAPTION = STRTRAN( .o_Frm_Avance.CAPTION, '> -', '(Bin>Txt) -' )
                  ENDIF

                  DO CASE
                  CASE lcInputFile_Type == C_FILETYPE_DIRECTORY
                     *-- BIN2PRG CONVERSION OF A DIRECTORY AND SUBDIRECTORIES
                     .writeLog( '> InputFile ' + loLang.C_IS_A_DIRECTORY_LOC )
                     .writeLog()

                     DO CASE
                     CASE .getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
                        CD (tcRecompile)
                     CASE .getCfgValue('l_Recompile')
                        CD (tc_InputFile)
                     ENDCASE

                     .c_LogFile  = ADDBS(tc_InputFile) + tcType + '.LOG'

                     IF .getCfgValue('n_Debug') > 0 THEN
                        ERASE ( .c_LogFile )
                     ENDIF

                     .get_FilesFromDirectory( tc_InputFile, @laFiles, @lnFileCount )

                     FOR I = 1 TO lnFileCount
                        toModulo    = .NULL.
                        lcFile      = laFiles(m.I)

                        IF NOT .hasSupport_Bin2Prg( lcFile ) OR NOT ADIR(laDirInfo, lcFile) > 0 THEN
                           LOOP
                        ENDIF

                        .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                        lnCodError = .convert( lcFile, @toModulo, @toEx, .F., tcOriginalFileName )
                        *!* Changed by: LScheffler 15.2.2021
                        *!* change date="{^2021-02-15,06:57:00}"
                        * flushing the log after each file let us only see last file
                        * why ever, it should be appended, but we simply move
                        * .writeLog_Flush() after ENDFOR

                        *                               .writeLog_Flush()

                        DO CASE
                        CASE lnCodError = 1799  && Conversion Cancelled
                           ERROR 1799

                        CASE lnCodError > 0
                           .doWriteErrorLog( @toEx )
                        ENDCASE
                     ENDFOR && I = 1 TO lnFileCount
                     .writeLog_Flush()
                     *!* /Changed by: LScheffler 15.2.2021

                     .updateProgressbar( loLang.C_END_OF_PROCESS_LOC, lnFileCount, lnFileCount, 0 )
                     EXIT

                  CASE NOT .hasSupport_Bin2Prg( tc_InputFile ) OR NOT ADIR(laDirInfo, tc_InputFile) > 0
                     .writeLog( '> InputFile ' + loLang.C_IS_UNSUPPORTED_LOC )
                     .writeLog()
                     EXIT

                  ENDCASE


               CASE ATC('-PRG2BIN', ('-' + tcType)) > 0;
                     OR ATC('-TEXT2BIN','-'+tcType) > 0
                  .writeLog( '> ' + loLang.C_OPTION_LOC + ': PRG2BIN' )

                  IF .getCfgValue('n_ShowProgressbar') <> 0 AND .l_ProcessFiles THEN
                     .loadProgressbarForm()
                     .o_Frm_Avance.CAPTION = STRTRAN( .o_Frm_Avance.CAPTION, '> -', '(Txt>Bin) -' )
                  ENDIF

                  DO CASE
                  CASE lcInputFile_Type == C_FILETYPE_DIRECTORY
                     *-- PRG2BIN CONVERSION OF A DIRECTORY AND SUBDIRECTORIES
                     .writeLog( '> InputFile ' + loLang.C_IS_A_DIRECTORY_LOC )
                     .writeLog()

                     DO CASE
                     CASE .getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
                        CD (tcRecompile)
                     CASE .getCfgValue('l_Recompile')
                        CD (tc_InputFile)
                     ENDCASE

                     .c_LogFile  = ADDBS(tc_InputFile) + tcType + '.LOG'

                     IF .getCfgValue('n_Debug') > 0 THEN
                        ERASE ( .c_LogFile )
                     ENDIF

                     .get_FilesFromDirectory( tc_InputFile, @laFiles, @lnFileCount )


                     FOR I = 1 TO lnFileCount
                        toModulo    = .NULL.
                        lcFile      = laFiles(m.I)

                        IF NOT .hasSupport_Prg2Bin( lcFile ) OR NOT ADIR(laDirInfo, lcFile) > 0 THEN
                           LOOP
                        ENDIF

                        .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                        lnCodError = .convert( lcFile, @toModulo, @toEx, .F., tcOriginalFileName )
                        *!* Changed by: LScheffler 15.2.2021
                        *!* change date="{^2021-02-15,06:57:00}"
                        * flushing the log after each file let us only see last file
                        * why ever, it should be appended, but we simply move
                        * .writeLog_Flush() after ENDFOR

                        *                               .writeLog_Flush()

                        DO CASE
                        CASE lnCodError = 1799  && Conversion Cancelled
                           ERROR 1799

                        CASE lnCodError > 0
                           .doWriteErrorLog( @toEx )
                        ENDCASE
                     ENDFOR && I = 1 TO lnFileCount
                     .writeLog_Flush()
                     *!* /Changed by: LScheffler 15.2.2021

                     .updateProgressbar( loLang.C_END_OF_PROCESS_LOC, lnFileCount, lnFileCount, 0 )
                     EXIT

                  CASE NOT .hasSupport_Prg2Bin( tc_InputFile ) OR NOT ADIR(laDirInfo, tc_InputFile) > 0
                     .writeLog( '> InputFile ' + loLang.C_IS_UNSUPPORTED_LOC )
                     .writeLog()
                     EXIT

                  ENDCASE


               ENDCASE

               *-- A SINGLE FILE OR FILE SUPPORT QUERY
               IF lcInputFile_Type = C_FILETYPE_QUERYSUPPORT
                  *-- Conversion support query (SourceSafe compatibility)
                  *-- SourceSafe queries each file support type before Checkin/Checkout
                  *-- to know whether Diff and Merge are possible.
                  *-- For file type codes see "Type Property" help
                  DO CASE
                  CASE tc_InputFile $ FILETYPE_PROJECT    && PJX (J does not exist in FoxPro; invented value to avoid conflict with existing types)
                     lnCodError  = .getCfgValue('n_PJX_Conversion_Support')

                  CASE tc_InputFile == FILETYPE_CLASSLIB
                     lnCodError  = .n_X_Conversion_Support

                  CASE tc_InputFile == FILETYPE_FORM
                     lnCodError  = .getCfgValue('n_SCX_Conversion_Support')

                  CASE tc_InputFile == FILETYPE_REPORT
                     lnCodError  = .getCfgValue('n_FRX_Conversion_Support')

                  CASE tc_InputFile == FILETYPE_LABEL
                     lnCodError  = .getCfgValue('n_LBX_Conversion_Support')

                  CASE tc_InputFile == FILETYPE_MENU
                     lnCodError  = .getCfgValue('n_MNX_Conversion_Support')

                  CASE tc_InputFile == FILETYPE_DATABASE
                     lnCodError  = .getCfgValue('n_DBC_Conversion_Support')

                  CASE tc_InputFile == FILETYPE_FREETABLE
                     lnCodError  = .getCfgValue('n_DBF_Conversion_Support')

                  OTHERWISE
                     lnCodError  = -1    && No support.
                  ENDCASE

               ELSE

                  DO CASE
                  CASE UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == 'PJX' AND LEFT(EVL(tcType,'0'),1) == '*'
                     *-- CONVERT ALL FILES OF A PJX PROJECT TO TEXT
                     .evaluate_Full_PJX(tc_InputFile, tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', tcType)
                     EXIT

                  CASE UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == .getCfgValue('c_PJ2') AND LEFT(EVL(tcType,'0'),1) == '*'
                     *-- CONVERT ALL FILES OF A PJ2 PROJECT TO BINARY
                     .evaluate_Full_PJ2(tc_InputFile, tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', tcType)
                     EXIT

                  CASE INLIST( EVL(tcType,'0') ;
                        , FILETYPE_DATABASE ;
                        , FILETYPE_FREETABLE ;
                        , FILETYPE_QUERY ;
                        , FILETYPE_FORM ;
                        , FILETYPE_REPORT ;
                        , FILETYPE_LABEL ;
                        , FILETYPE_CLASSLIB ;
                        , FILETYPE_PROGRAM ;
                        , FILETYPE_PROJECT ;
                        , FILETYPE_APILIB ;
                        , FILETYPE_APPLICATION ;
                        , FILETYPE_MENU ;
                        , FILETYPE_TEXT ;
                        , FILETYPE_OTHER ) ;
                        AND EVL(tcTextName,'0') <> '0'
                     *-- SOURCESAFE COMPATIBILITY. 30/01/2014
                     IF tlGenText
                        .writeLog( '> ' + loLang.C_SOURCESAFE_COMPATIBILITY_MODE_LOC + ': ' + loLang.C_BINARY_TO_TEXT_LOC )
                     ELSE
                        *-- Create BINARY from TEXT version
                        *-- Because the input file is always the binary when using SCCAPI,
                        *-- to regenerate the binary (tlGenText=.F.) use
                        *-- tcTextName as the input file instead. Swap them here.
                        tc_InputFile        = tcTextName
                        loCfgW = .getCfgObjectForWrite()
                        IF VARTYPE(loCfgW) = 'O'
                           loCfgW.l_Recompile = .T.
                        ENDIF
                        .writeLog( '> ' + loLang.C_SOURCESAFE_COMPATIBILITY_MODE_LOC + ': ' + loLang.C_TEXT_TO_BINARY_LOC )
                     ENDIF
                  ENDCASE

                  IF ADIR(laDirInfo, tc_InputFile) > 0
                     IF .getCfgValue('n_ShowProgressbar') <> 0 AND .l_ProcessFiles THEN
                        .loadProgressbarForm()
                     ENDIF

                     .writeLog( '> InputFile ' + loLang.C_IS_A_FILE_LOC )
                     .writeLog()
                     tc_InputFile    = LOCFILE(tc_InputFile)

                     DO CASE
                     CASE .getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
                        CD (tcRecompile)
                     CASE tcRecompile == '1'
                        CD (JUSTPATH(tc_InputFile))
                     ENDCASE

                     .c_LogFile  = tc_InputFile + '.LOG'

                     IF .getCfgValue('n_Debug') > 0 THEN
                        ERASE ( .c_LogFile )
                     ENDIF

                     lnCodError = .convert( tc_InputFile, @toModulo, @toEx, .T., tcOriginalFileName )
                     *.updateProgressbar( loLang.C_END_OF_PROCESS_LOC, 1, 1, 0 )
                  ENDIF
               ENDIF

            ENDCASE
         ENDWITH && THIS

      CATCH TO toEx
         IF NOT llEscKeyRestored AND This.l_CancelWithEscKey THEN
            IF EMPTY(lcOldOnEscape)
               ON ESCAPE
            ELSE
               ON ESCAPE &lcOldOnEscape.
            ENDIF

            IF EMPTY(lcOldSetEscape)
               SET ESCAPE OFF
            ELSE
               SET ESCAPE &lcOldSetEscape.
            ENDIF
            llEscKeyRestored = .T.
         ENDIF

         lnCodError      = toEx.ERRORNO
         lnErrorIcon     = 64

         IF VARTYPE(loLang) <> 'O' THEN
            loLang      = NewObject("CL_LANG", "cl_lang.prg", null, "EN")
         ENDIF

         IF lnCodError <> 1799 THEN  && Conversion Cancelled
            toEx.USERVALUE  = toEx.USERVALUE + 'FoxBin2Prg: [' + This.c_Foxbin2prg_FullPath + '] (EXE Version: ' + This.c_FB2PRG_EXE_Version + ')' + CR_LF
            lnErrorIcon     = 16
         ENDIF

         IF ATC('-SHOWMSG', ('-' + tcType)) > 0 THEN
            IF lnCodError <> 1799 THEN  && Conversion Cancelled
               toEx.USERVALUE = toEx.USERVALUE + 'lcInputFile_Type  = [' + TRANSFORM(lcInputFile_Type) + ']' + CR_LF
            ENDIF
            This.setCfgValue( 'l_ShowErrors', .F. )   && The "SHOWMSG" option shows its own message
         ENDIF

         IF lnCodError <> 1799 THEN  && Conversion Cancelled
            toEx.USERVALUE = toEx.USERVALUE + 'tc_InputFile = [' + TRANSFORM(tc_InputFile) + ']' + CR_LF
         ENDIF

         This.doWriteErrorLog( @toEx, @lcErrorInfo )

         IF This.getCfgValue('n_Debug') > 0 THEN
            IF _VFP.STARTMODE = 0
               SET STEP ON
            ENDIF
         ENDIF

         IF tlRelanzarError
            THROW
         ENDIF

      FINALLY
         IF NOT llEscKeyRestored AND This.l_CancelWithEscKey THEN
            IF EMPTY(lcOldOnEscape)
               ON ESCAPE
            ELSE
               ON ESCAPE &lcOldOnEscape.
            ENDIF

            IF EMPTY(lcOldSetEscape)
               SET ESCAPE OFF
            ELSE
               SET ESCAPE &lcOldSetEscape.
            ENDIF
            llEscKeyRestored = .T.
         ENDIF

         IF VARTYPE(loLang) <> 'O' THEN
            loLang      = NewObject("CL_LANG", "cl_lang.prg", null, "EN")
         ENDIF

         USE IN (SELECT("TABLABIN"))
         This.writeLog_Flush()
         This.unloadProgressbarForm()
         CD (JUSTPATH(This.c_CurDir))

         DO CASE
         CASE EVL( lcInputFile_Type, C_FILETYPE_QUERYSUPPORT ) <> C_FILETYPE_QUERYSUPPORT ;
               AND ATC('-SHOWMSG', ('-' + tcType)) > 0 ;
               OR This.getCfgValue('l_ShowErrors') AND lnCodError > 0 AND NOT ISNULL(toEx)
            This.writeErrorLog_Flush()

            DO CASE
            CASE lnCodError = 1098  && User Error
               MESSAGEBOX( toEx.MESSAGE, 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
               *loWSH.Run( This.c_ErrorLogFile, 3 )
               This.wscriptshell_run( This.c_ErrorLogFile, 3 )

            CASE lnCodError = 1799  && Conversion Cancelled
               MESSAGEBOX( loLang.C_CONVERSION_CANCELLED_BY_USER_LOC + '!', 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )

            CASE This.l_Errors
               IF ADIR(laDirInfo, This.c_ErrorLogFile) > 0 THEN
                  MESSAGEBOX( loLang.C_END_OF_PROCESS_LOC + '! (' + loLang.C_WITH_ERRORS_LOC + ')', 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
                  *loWSH.Run( This.c_ErrorLogFile, 3 )
                  This.wscriptshell_run( This.c_ErrorLogFile, 3 )
               ELSE
                  MESSAGEBOX( loLang.C_END_OF_PROCESS_LOC + '! (' + loLang.C_WITH_ERRORS_LOC + ')' + CR_LF + "[Warning: Can't show Error LOG file because does not exist!]", 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
               ENDIF

            OTHERWISE
               MESSAGEBOX( loLang.C_END_OF_PROCESS_LOC + '', 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )

            ENDCASE

         ENDCASE

         IF EMPTY(lnCodError) AND This.l_Errors
            SET STEP ON
            lnCodError = 1098
         ENDIF

         SET NOTIFY &lc_OldSetNotify.
         STORE .NULL. TO loFSO, loWSH, loDBF_CFG
         RELEASE I, lcPath, lcFileSpec, lcFile, laFiles, lnFileCount, lcErrorInfo, lcErrorFile, loEx, loFSO
      ENDTRY

      RETURN lnCodError
   ENDPROC


   PROCEDURE evaluate_Full_PJX
      *--------------------------------------------------------------------------------------------------------------
      * CONVERT ALL FILES OF A PJX PROJECT TO TEXT
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Input file name
      * tcRecompile               (v? IN    ) Recompile ('1') the binary once regenerated. [Default behavior change]
      *                                       This change saves time, speed, and safety. Also, recompilation by FoxBin2Prg
      *                                       runs from the file directory, so relative references may
      *                                       cause compilation errors, typically #include directives.
      *                                       NOTE: If a Path is given instead of '1' (e.g. the project path), it will be used as the base for recompiling
      * toModulo                  (@?    OUT) Object reference of the generated module (for unit testing)
      * toEx                      (@?    OUT) Object with error information
      * tcOriginalFileName        (v? IN    ) For cases where inputFile is a temporary name and the correct name should be generated
      *                                       the correct name within the text version (e.g. in PJ2 and headers)
      * tcLogFile                 (v? IN    ) Log file name to use
      * tcType                    (v? IN    ) Input file type. SCCTEXT.PRG compatibility
      *                                       - If "*" is given and tc_InputFile is a PJX, all project files and the PJX/2 are processed
      *                                       - If "*-" is given and tc_InputFile is a PJX, all project files are processed without the PJX/2
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, tcRecompile, toModulo, toEx, tcOriginalFileName, tcLogFile, tcType

      LOCAL lcFileSpec, lnFileCount, laFiles(1,2), lcFile, lnCodError, I, lnFileCount, llError, laDirInfo(1,5), lcStr ;
         , loLang AS CL_LANG OF 'cl_lang.prg' ;
         , loEx AS EXCEPTION ;
         , llMirrorExportSave AS Boolean

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            llMirrorExportSave = .l_MirrorExport
            .l_MirrorExport     = .T.
            loLang      = _SCREEN.o_FoxBin2Prg_Lang
            lcFileSpec  = FULLPATH( tc_InputFile )

            *-- Mirrored tree: if there is an output folder and no root was set, use the project folder
            .ensureMirror()
            .o_Mirror.ensureInputRoot( lcFileSpec )

            IF .getCfgValue('n_ShowProgressbar') <> 0 AND .l_ProcessFiles THEN
               .loadProgressbarForm()
               .o_Frm_Avance.CAPTION = STRTRAN( .o_Frm_Avance.CAPTION, '> -', '(Bin>Txt) -' )
            ENDIF

            IF EMPTY(tcLogFile)
               .c_LogFile  = ADDBS( JUSTPATH( lcFileSpec ) ) + STRTRAN( JUSTFNAME( lcFileSpec ), '*', '_ALL' ) + '.LOG'

               IF .getCfgValue('n_Debug') > 0 THEN
                  ERASE ( .c_LogFile )
               ENDIF
            ENDIF

            .writeLog( '> ' + loLang.C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC + ': ' + loLang.C_BINARY_TO_TEXT_LOC )

            DO CASE
            CASE .getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
               CD (tcRecompile)
            CASE tcRecompile == '1'
               CD (JUSTPATH(lcFileSpec))
            ENDCASE

            SELECT 0
            USE (tc_InputFile) SHARED AGAIN NOUPDATE ALIAS TABLABIN
            lnFileCount = 0

            SCAN FOR NOT DELETED() AND TYPE <> 'H'
               lnFileCount = lnFileCount + 1
               DIMENSION laFiles(lnFileCount, 2)
               laFiles(lnFileCount, 1)  = .get_AbsolutePath( ALLTRIM( NAME, 0, ' ', CHR(0) ), ADDBS( JUSTPATH( lcFileSpec ) ) )
               laFiles(lnFileCount, 2)  = EXCLUDE
            ENDSCAN

            USE IN (SELECT("TABLABIN"))

            *-- Convert the project first
            IF tcType <> '*-' THEN
               lcFile      = tc_InputFile
               lnCodError  = .convert( lcFile, toModulo, @toEx, .T., tcOriginalFileName )
               .writeLog_Flush()
            ENDIF

            *-- Then convert the included files
            FOR I = 1 TO lnFileCount
               lcFile      = laFiles(m.I, 1)
               .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )

               *-- Excluded subdirectory: not converted or copied to the mirrored tree
               IF .isExcludedSubdir( lcFile )
                  .writeLog( C_TAB + C_TAB + '* Excluded (subdir): ' + lcFile )
                  IF .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                     .updateProcessedFile()
                  ENDIF
                  LOOP
               ENDIF

               *-- PJX Exclude flag: not converted or copied to the mirrored tree (unless opted in)
               IF NOT .getCfgValue('l_CopyExcludedPjxFiles') AND NOT EMPTY(.cOutputFolder) AND laFiles(m.I, 2)
                  .writeLog( C_TAB + C_TAB + '* Excluded (PJX): ' + lcFile )
                  IF .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                     .updateProcessedFile()
                  ENDIF
                  LOOP
               ENDIF

               *-- Outside project root: not converted or copied to the mirrored tree
               IF NOT EMPTY(.cOutputFolder) AND NOT EMPTY(.cInputRoot) AND NOT .isUnderInputRoot( lcFile )
                  IF .getCfgValue('n_CheckFileInPath') = 1
                     lcStr = loLang.C_PJXPATH_ERR_LOC3 + lcFile + loLang.C_PJXPATH_ERR_LOC4 ;
                        + ADDBS(.cInputRoot) + loLang.C_PJXPATH_ERR_LOC5
                     ERROR (lcStr)
                  ELSE
                     .writeLog( C_TAB + C_TAB + '* Skipped (outside project root): ' + lcFile )
                     IF .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                        .updateProcessedFile()
                     ENDIF
                     LOOP
                  ENDIF
               ENDIF

               IF .hasSupport_Bin2Prg( UPPER(JUSTEXT(lcFile)) ) AND ADIR( laDirInfo, lcFile ) > 0 THEN
                  lnCodError  = .convert( lcFile, toModulo, @toEx, .F., tcOriginalFileName )
                  .writeLog_Flush()

                  DO CASE
                  CASE lnCodError = 1799  && Conversion Cancelled
                     ERROR 1799

                  CASE lnCodError > 0
                     .doWriteErrorLog( @toEx )
                     llError     = .T.
                     .l_Error    = .F.
                  ENDCASE
               ELSE
                  *-- Non-convertible: optionally copied to the mirrored tree
                  IF .getCfgValue('l_CopyNonConvertible') AND NOT EMPTY(.cOutputFolder) AND ADIR( laDirInfo, lcFile ) > 0
                     IF .copyUnconvertedFile( lcFile )
                        .writeLog( C_TAB + C_TAB + '- Copied (not convertible): ' + .get_MirroredPath(lcFile) ;
                           + IIF( .isExportUTF8() AND .isTextFileForEncoding(lcFile), ' (UTF-8)', '' ) )
                     ENDIF
                  ENDIF

                  *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                  IF .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                     .updateProcessedFile()
                  ENDIF
               ENDIF

               .writeLog_Flush()

               IF llError
                  .l_Error = .T.
               ENDIF
            ENDFOR
         ENDWITH

      CATCH TO loEx
         THROW

      FINALLY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            .l_MirrorExport = llMirrorExportSave
         ENDWITH
         STORE .NULL. TO loLang
         RELEASE loLang
      ENDTRY
   ENDPROC


   PROCEDURE evaluate_Full_PJ2
      *--------------------------------------------------------------------------------------------------------------
      * CONVERT ALL FILES OF A PJ2 PROJECT TO BINARY
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Input file name
      * tcRecompile               (v? IN    ) Recompile ('1') the binary once regenerated. [Default behavior change]
      *                                       This change saves time, speed, and safety. Also, recompilation by FoxBin2Prg
      *                                       runs from the file directory, so relative references may
      *                                       cause compilation errors, typically #include directives.
      *                                       NOTE: If a Path is given instead of '1' (e.g. the project path), it will be used as the base for recompiling
      * toModulo                  (@?    OUT) Object reference of the generated module (for unit testing)
      * toEx                      (@?    OUT) Object with error information
      * tcOriginalFileName        (v? IN    ) For cases where inputFile is a temporary name and the correct name should be generated
      *                                       the correct name within the text version (e.g. in PJ2 and headers)
      * tcLogFile                 (v? IN    ) Log file name to use
      * tcType                    (v? IN    ) Input file type. SCCTEXT.PRG compatibility
      *                                       - If "*" is given and tc_InputFile is a PJX, all project files and the PJX/2 are processed
      *                                       - If "*-" is given and tc_InputFile is a PJX, all project files are processed without the PJX/2
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, tcRecompile, toModulo, toEx, tcOriginalFileName, tcLogFile, tcType

      LOCAL lcFileSpec, lnFileCount, laFiles(1,2), laExcluded(1), lcFile, lcBinFile, lcTextFile, lcFlatText, lnCodError, I, lnFileCount, llError, laDirInfo(1,5), lcStr ;
         , loLang AS CL_LANG OF 'cl_lang.prg' ;
         , loEx AS EXCEPTION ;
         , llMirrorExportSave AS Boolean

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            llMirrorExportSave = .l_MirrorExport
            .l_MirrorExport     = .F.
            loLang      = _SCREEN.o_FoxBin2Prg_Lang
            lcFileSpec  = FULLPATH( tc_InputFile )

            *-- Mirrored tree: if there is an output folder and no root was set, use the project folder
            .ensureMirror()
            .o_Mirror.ensureInputRoot( lcFileSpec )

            IF .getCfgValue('n_ShowProgressbar') <> 0 AND .l_ProcessFiles THEN
               .loadProgressbarForm()
               .o_Frm_Avance.CAPTION = STRTRAN( .o_Frm_Avance.CAPTION, '> -', '(Txt>Bin) -' )
            ENDIF

            IF EMPTY(tcLogFile)
               .c_LogFile  = ADDBS( JUSTPATH( lcFileSpec ) ) + STRTRAN( JUSTFNAME( lcFileSpec ), '*', '_ALL' ) + '.LOG'

               IF .getCfgValue('n_Debug') > 0 THEN
                  ERASE ( .c_LogFile )
               ENDIF
            ENDIF

            .writeLog( '> ' + loLang.C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC + ': ' + loLang.C_TEXT_TO_BINARY_LOC )

            DO CASE
            CASE .getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
               CD (tcRecompile)
            CASE tcRecompile == '1'
               CD (JUSTPATH(lcFileSpec))
            ENDCASE

            lnFileCount = ALINES( laFiles, STREXTRACT( FILETOSTR(tc_InputFile), C_BUILDPROJ_I, C_BUILDPROJ_F ), 1+4 )
            laExcluded  = .o_Mirror.collectPj2ExcludedPaths( tc_InputFile, JUSTPATH( lcFileSpec ) )

            FOR I = lnFileCount TO 1 STEP -1
               IF '.ADD(' $ laFiles(m.I)
                  lcBinFile   = .get_AbsolutePath( STREXTRACT( laFiles(m.I), ".ADD('", "')" ), ADDBS( JUSTPATH( lcFileSpec ) ) )
                  lcTextFile  = .resolvePj2TextMemberPath( lcBinFile )
                  lcFlatText  = FORCEEXT( lcBinFile, .get_TextExtForBinFile( lcBinFile ) )
                  IF lcTextFile <> lcFlatText
                     .writeLog( C_TAB + C_TAB + '* Resolved per-dir text: ' + lcTextFile )
                  ENDIF
                  laFiles(m.I, 1) = lcTextFile
                  laFiles(m.I, 2) = lcBinFile
               ELSE
                  lnFileCount = lnFileCount - 1
                  ADEL( laFiles, m.I )
                  DIMENSION laFiles(lnFileCount, 2)
               ENDIF
            ENDFOR

            *-- Convert the project first
            IF tcType <> '*-' THEN
               lcFile  = tc_InputFile
               lnCodError = .convert( lcFile, toModulo, @toEx, .T., tcOriginalFileName )
               .writeLog_Flush()
            ENDIF

            *-- Then convert the included files
            FOR I = 1 TO lnFileCount
               lcFile      = laFiles(m.I, 1)
               lcBinFile   = laFiles(m.I, 2)
               .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )

               *-- Excluded subdirectory: not converted or copied to the mirrored tree
               IF .isExcludedSubdir( lcFile )
                  .writeLog( C_TAB + C_TAB + '* Excluded (subdir): ' + lcFile )
                  IF .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                     .updateProcessedFile()
                  ENDIF
                  LOOP
               ENDIF

               *-- PJX Exclude flag: not converted or copied to the mirrored tree (unless opted in)
               IF NOT .getCfgValue('l_CopyExcludedPjxFiles') AND NOT EMPTY(.cOutputFolder) ;
                     AND .o_Mirror.isPjxExcludedFile( lcFile, laExcluded )
                  .writeLog( C_TAB + C_TAB + '* Excluded (PJX): ' + lcFile )
                  IF .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                     .updateProcessedFile()
                  ENDIF
                  LOOP
               ENDIF

               *-- Outside project root: not converted or copied to the mirrored tree
               IF NOT EMPTY(.cOutputFolder) AND NOT EMPTY(.cInputRoot) AND NOT .isUnderInputRoot( lcFile )
                  IF .getCfgValue('n_CheckFileInPath') = 1
                     lcStr = loLang.C_PJXPATH_ERR_LOC3 + lcFile + loLang.C_PJXPATH_ERR_LOC4 ;
                        + ADDBS(.cInputRoot) + loLang.C_PJXPATH_ERR_LOC5
                     ERROR (lcStr)
                  ELSE
                     .writeLog( C_TAB + C_TAB + '* Skipped (outside project root): ' + lcFile )
                     IF .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                        .updateProcessedFile()
                     ENDIF
                     LOOP
                  ENDIF
               ENDIF

               IF .hasSupport_Prg2Bin( lcFile ) AND .isPj2TextMemberAvailable( lcBinFile ) THEN
                  lnCodError = .convert( lcFile, toModulo, @toEx, .F., tcOriginalFileName )
                  .writeLog_Flush()

                  DO CASE
                  CASE lnCodError = 1799  && Conversion Cancelled
                     ERROR 1799

                  CASE lnCodError > 0
                     .doWriteErrorLog( @toEx )
                     llError     = .T.
                     .l_Error    = .F.
                  ENDCASE
               ELSE
                  *-- Non-convertible: optionally copied to the mirrored tree
                  IF .getCfgValue('l_CopyNonConvertible') AND NOT EMPTY(.cOutputFolder) ;
                        AND ( ADIR( laDirInfo, lcFile ) > 0 OR ADIR( laDirInfo, lcBinFile ) > 0 )
                     IF .copyUnconvertedFile( lcFile )
                        .writeLog( C_TAB + C_TAB + '- Copied (not convertible): ' + .get_MirroredPath(lcFile) ;
                           + IIF( .isExportUTF8() AND .isTextFileForEncoding(lcFile), ' (UTF-8)', '' ) )
                     ENDIF
                  ENDIF

                  *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                  IF .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                     .updateProcessedFile()
                  ENDIF
               ENDIF

               .writeLog_Flush()

               IF llError
                  .l_Error = .T.
               ENDIF
            ENDFOR
         ENDWITH

      CATCH TO loEx
         THROW

      FINALLY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            .l_MirrorExport = llMirrorExportSave
         ENDWITH
         STORE .NULL. TO loLang
         RELEASE loLang
      ENDTRY
   ENDPROC


   HIDDEN PROCEDURE doWriteErrorLog
      LPARAMETERS toEx AS EXCEPTION, tcErrorInfo

      LOCAL loLang AS CL_LANG OF 'cl_lang.prg'
      loLang          = _SCREEN.o_FoxBin2Prg_Lang

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         IF toEx.ERRORNO = 1799 THEN     && Conversion Cancelled
            tcErrorInfo     = loLang.C_CONVERSION_CANCELLED_BY_USER_LOC
         ELSE
            tcErrorInfo     = .exception2Str(@toEx) + CR_LF + loLang.C_SOURCEFILE_LOC + TRANSFORM(.c_InputFile) + CR_LF
         ENDIF

         ADDPROPERTY(_SCREEN, 'ExitCode', toEx.ERRORNO)

         *-- Write error information to the error log variable
         .writeErrorLog( REPLICATE('-', 100), 1 )
         .writeLog( tcErrorInfo )
         .writeErrorLog( tcErrorInfo )
         .writeErrorLog( )

         *-- Write error information to the error log file
         TRY
            STRTOFILE( tcErrorInfo, EVL( .c_InputFile, 'foxbin2prg_errorlog' ) + '.ERR' )
         CATCH
         ENDTRY
      ENDWITH

      RETURN
   ENDPROC


   PROTECTED PROCEDURE convert
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Input file name
      * toModulo                  (@?    OUT) Object reference of the generated module (for unit testing)
      * toEx                      (@?    OUT) Object with error information
      * tlRelanzarError           (v? IN    ) Whether the error should be re-thrown
      * tcOriginalFileName        (v? IN    ) For cases where inputFile is a temporary name and the correct name should be generated
      *                                       the correct name within the text version (e.g. in PJ2 and headers)
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, toModulo, toEx AS EXCEPTION, tlRelanzarError, tcOriginalFileName

      TRY
         LOCAL lnCodError, lcErrorInfo, laDirFile(1,5), lcExtension, lnFileCount, laFiles(1,1), I ;
            , ltFilestamp, lcExtA, lcExtB, laEvents(1,1), lcForceAttribs, lnIDInputFile, llFox2x ;
            , loLang AS CL_LANG OF 'cl_lang.prg' ;
            , loConversor AS c_conversor_base OF 'c_conversor_base.prg' ;
            , loFSO AS Scripting.FileSystemObject ;
            , loDBF_CFG AS CL_DBF_CFG OF 'CL_DBF_CFG.prg'
         lnCodError          = 0

         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            loFSO           = .o_FSO
            loLang          = _SCREEN.o_FoxBin2Prg_Lang
            lcForceAttribs  = '+N'
            .c_InputFile    = FULLPATH( tc_InputFile )
            .l_Error        = .F.
            lcExtension     = UPPER( JUSTEXT(.c_InputFile) )

            .writeLog( REPLICATE( '*', 100 ) )
            .writeLog( 'CONVERSION PROCESS', 2 )
            .writeLog( REPLICATE( '*', 100 ) )

            IF ADIR( laDirFile, .c_InputFile, '', 1 ) = 0
               *ERROR 'File not found [' + .c_InputFile + ']'
               ERROR loLang.C_FILE_NOT_FOUND_LOC + ' [' + .c_InputFile + ']'
            ENDIF

            .c_InputFile    = loFSO.GetAbsolutePathName( FORCEPATH( laDirFile(1,1), JUSTPATH(.c_InputFile) ) )

            *-- CHECK FOR SECONDARY CONFIGURATION FILE
            .evaluateConfiguration()

            IF .n_ForceWriteIfReadOnly = 1 THEN
               lcForceAttribs  = lcForceAttribs + '-R'
            ENDIF

            *!* Changed by: LScheffler 03.03.2021
            *!* change date="{^2021-03-03,11:38:00}"
            * Added option for DBC split

            *-- VC2/SC2 OPTIMIZATION: CHECK WHETHER BASE FILE WAS PROCESSED TO SKIP REPROCESSING
            IF INLIST(lcExtension,"VCX",.getCfgValue('c_VC2'));
                  AND (.getCfgValue('n_UseClassPerFile') > 0 AND .getCfgValue('l_RedirectClassPerFileToMain') ;
                  OR NOT EMPTY(.c_ClassToConvert))

               DO CASE

               CASE .getCfgValue('n_RedirectClassType') = 1 OR NOT EMPTY(.c_ClassToConvert) && Redirect only this class
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(.c_InputFile) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

               CASE .getCfgValue('n_UseClassPerFile') = 1 AND INLIST(lcExtension,.getCfgValue('c_VC2'))
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(.c_InputFile) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  *-- Check whether redirection to the main file should be forced
                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF
                  ** LScheffler, Problem, Fehler: DC2 hier nicht, das muss anders mit UseFilesPerDBC
               CASE .getCfgValue('n_UseClassPerFile') = 2 AND INLIST(lcExtension,.getCfgValue('c_VC2'))
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  *-- Check whether redirection to the main file should be forced
                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF

               ENDCASE
            ENDIF

            IF INLIST(lcExtension,"SCX",.getCfgValue('c_SC2'));
                  AND (.getCfgValue('n_UseFormPerFile') > 0 AND .getCfgValue('l_RedirectFormPerFileToMain') ;
                  OR NOT EMPTY(.c_ClassToConvert))

               DO CASE

               CASE .getCfgValue('n_RedirectFormType') = 1 OR NOT EMPTY(.c_ClassToConvert) && Redirect only this class
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(.c_InputFile) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

               CASE .getCfgValue('n_UseFormPerFile') = 1 AND INLIST(lcExtension,.getCfgValue('c_SC2'))
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(.c_InputFile) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  *-- Check whether redirection to the main file should be forced
                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF
                  ** LScheffler, Problem, Fehler: DC2 hier nicht, das muss anders mit UseFilesPerDBC
               CASE .getCfgValue('n_UseFormPerFile') = 2 AND INLIST(lcExtension,.getCfgValue('c_SC2'))
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  *-- Check whether redirection to the main file should be forced
                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF

               ENDCASE
            ENDIF
            *****************************

            *-- DC2 OPTIMIZATION: CHECK WHETHER BASE FILE WAS PROCESSED TO SKIP REPROCESSING
            IF INLIST(lcExtension,"DBC",.getCfgValue('c_DC2'));
                  AND .getCfgValue('n_UseFilesPerDBC') > 0 AND .getCfgValue('l_RedirectFilePerDBCToMain');
                  AND .getCfgValue('n_UseFilesPerDBC') = 1

               IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                  lc_BaseFile = .c_InputFile
               ELSE
                  lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
               ENDIF

               *-- Check whether redirection to the main file should be forced
               IF '.' $ JUSTSTEM(.c_InputFile)
                  .c_InputFile    = lc_BaseFile
               ENDIF

            ENDIF

            *!* /Changed by: LScheffler 03.03.2021

            ERASE ( .c_InputFile + '.ERR' )

            IF NOT EMPTY(tcOriginalFileName)
               tcOriginalFileName  = loFSO.GetAbsolutePathName( tcOriginalFileName )
            ENDIF

            .c_OriginalFileName = EVL( tcOriginalFileName, .c_InputFile )

            IF UPPER( JUSTEXT(.c_OriginalFileName) ) = 'PJM' AND .getCfgValue('c_PJ2') <> 'PJM'
               .c_OriginalFileName = FORCEEXT(.c_OriginalFileName,'pjx')
            ENDIF

            *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
            IF NOT .addProcessedFile( .c_InputFile, 'I', 'P1', 'E0', 'S1', 'X0' ) THEN
               *.writeLog( 'OPTIMIZATION: Base file [' + JUSTFNAME(lc_BaseFile) + '] was already processed, so [' + JUSTFNAME(.c_InputFile) + '] will not be processed' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE( loLang.C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC ) )
               EXIT
            ENDIF

            *.updateProcessedFile()
            lnIDInputFile   = .n_ProcessedFiles

            .writeLog( C_TAB + 'c_OriginalFileName:           ' + .c_OriginalFileName )
            .writeLog( )

            IF NOT ADIR(laDirFile, .c_InputFile) > 0 THEN
               ERROR loLang.C_FILE_DOESNT_EXIST_LOC + ' [' + .c_InputFile + ']'
            ENDIF

            .normalizeFileCapitalization( .T. )

            DO CASE
            CASE lcExtension = 'VCX'
               IF NOT INLIST(.getCfgValue('n_VCX_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_VC2') )
               loConversor     = NewObject( 'c_conversor_vcx_a_prg' , 'c_conversor_vcx_a_prg.prg' )
               IF .getCfgInt('n_UseClassPerFile') > 0 AND .getCfgFlag('l_UseClassPerDir')
                  .changeFileAttribute( .getPerFileOutputPath( .c_InputFile, '', .getCfgValue('c_VC2'), .T., .getCfgInt('n_UseClassPerFile') ), lcForceAttribs )
               ELSE
                  .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_VC2') ), lcForceAttribs )
               ENDIF

            CASE lcExtension = 'SCX'
               IF NOT INLIST(.getCfgValue('n_SCX_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_SC2') )
               loConversor     = NewObject( 'c_conversor_scx_a_prg' , 'c_conversor_scx_a_prg.prg' )
               IF .getCfgInt('n_UseFormPerFile') > 0 AND .getCfgFlag('l_UseFormPerDir')
                  .changeFileAttribute( .getPerFileOutputPath( .c_InputFile, '', .getCfgValue('c_SC2'), .T., .getCfgInt('n_UseFormPerFile') ), lcForceAttribs )
               ELSE
                  .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_SC2') ), lcForceAttribs )
               ENDIF

            CASE lcExtension = 'PJX'
               IF NOT INLIST(.getCfgValue('n_PJX_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_PJ2') )
               loConversor     = NewObject( 'c_conversor_pjx_a_prg' , 'c_conversor_pjx_a_prg.prg' )

               .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_PJ2') ), lcForceAttribs )

            CASE lcExtension = 'PJM' AND .getCfgValue('c_PJ2') <> 'PJM'
               IF NOT INLIST(.getCfgValue('n_PJX_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_PJ2') )
               loConversor     = NewObject( 'c_conversor_pjm_a_prg', 'c_conversor_pjm_a_prg.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_PJ2') ), lcForceAttribs )

            CASE lcExtension = 'FRX'
               IF NOT INLIST(.getCfgValue('n_FRX_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               llFox2x = .detectFox2xRptLbl(.c_InputFile)
               IF llFox2x
                  .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_FR2D') )
                  .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_FR2D') ), lcForceAttribs )
               ELSE
                  .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_FR2') )
                  .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_FR2') ), lcForceAttribs )
               ENDIF
               loConversor     = NewObject( 'c_conversor_frx_a_prg' , 'c_conversor_frx_a_prg.prg' )
               loConversor.l_Fox2x = llFox2x

            CASE lcExtension = 'LBX'
               IF NOT INLIST(.getCfgValue('n_LBX_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               llFox2x = .detectFox2xRptLbl(.c_InputFile)
               IF llFox2x
                  .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_LB2D') )
                  .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_LB2D') ), lcForceAttribs )
               ELSE
                  .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_LB2') )
                  .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_LB2') ), lcForceAttribs )
               ENDIF
               loConversor     = NewObject( 'c_conversor_frx_a_prg' , 'c_conversor_frx_a_prg.prg' )
               loConversor.l_Fox2x = llFox2x

            CASE lcExtension = 'DBF'
               lnFileCount = .get_DBF_Configuration( FORCEEXT(.c_InputFile, 'DBF'), @loDBF_CFG )
               IF !IIF(ISNULL(loDBF_CFG), INLIST(.getCfgValue('n_DBF_Conversion_Support'), 1, 2, 4, 8), INLIST(loDBF_CFG.n_DBF_Conversion_Support, 1, 2, 4, 8) )
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_DB2') )
               loConversor     = NewObject( 'c_conversor_dbf_a_prg', 'c_conversor_dbf_a_prg.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_DB2') ), lcForceAttribs )

            CASE lcExtension = 'DBC'
               IF NOT INLIST(.getCfgValue('n_DBC_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_DC2') )
               loConversor     = NewObject( 'c_conversor_dbc_a_prg', 'c_conversor_dbc_a_prg.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_DC2') ), lcForceAttribs )

            CASE lcExtension = 'MNX'
               IF NOT INLIST(.getCfgValue('n_MNX_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_MN2') )
               loConversor     = NewObject( 'c_conversor_mnx_a_prg' , 'c_conversor_mnx_a_prg.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_MN2') ), lcForceAttribs )

            CASE lcExtension = 'FKY'
               IF NOT INLIST(.getCfgValue('n_FKY_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_FK2') )
               loConversor     = NewObject( 'c_conversor_fky_a_prg', 'c_conversor_fky_a_prg.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_FK2') ), lcForceAttribs )

            CASE lcExtension = 'MEM'
               IF NOT INLIST(.getCfgValue('n_MEM_Conversion_Support'), 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .getCfgValue('c_ME2') )
               loConversor     = NewObject( 'c_conversor_mem_a_prg', 'c_conversor_mem_a_prg.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .getCfgValue('c_ME2') ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_VC2')
               IF .getCfgValue('n_VCX_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               IF EMPTY(.c_ClassToConvert)
                  .c_OutputFile   = .getPerFileBinaryOutputPath( .c_InputFile, 'VCX', .getCfgValue('c_VC2'), ;
                     .getCfgFlag('l_UseClassPerDir'), .getCfgInt('n_UseClassPerFile') )
               ELSE
                  * If syntax "classlib.vcx::class::import" was used, OutputFile is defined
                  * with base "classlib.vcx" and not the whole file.
                  .c_OutputFile   = .getPerFileBinaryOutputPath( FORCEEXT( lc_BaseFile, 'VCX' ), 'VCX', .getCfgValue('c_VC2'), ;
                     .getCfgFlag('l_UseClassPerDir'), .getCfgInt('n_UseClassPerFile') )
               ENDIF
               loConversor     = NewObject( 'c_conversor_prg_a_vcx', 'c_conversor_prg_a_vcx.prg' )
               .changeFileAttribute( .c_OutputFile, lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_OutputFile, 'VCT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_SC2')
               IF .getCfgValue('n_SCX_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = .getPerFileBinaryOutputPath( .c_InputFile, 'SCX', .getCfgValue('c_SC2'), ;
                  .getCfgFlag('l_UseFormPerDir'), .getCfgInt('n_UseFormPerFile') )
               loConversor     = NewObject( 'c_conversor_prg_a_scx', 'c_conversor_prg_a_scx.prg' )
               .changeFileAttribute( .c_OutputFile, lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_OutputFile, 'SCT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_PJ2')
               IF .getCfgValue('n_PJX_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'PJX' )
               loConversor     = NewObject( 'c_conversor_prg_a_pjx' , 'c_conversor_prg_a_pjx.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'PJX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'PJT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_FR2')
               IF .getCfgValue('n_FRX_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'FRX' )
               loConversor     = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FRX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FRT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_FR2D')
               IF .getCfgValue('n_FRX_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'FRX' )
               loConversor     = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )
               loConversor.l_Fox2x = .T.
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FRX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FRT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_LB2')
               IF .getCfgValue('n_LBX_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'LBX' )
               loConversor     = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'LBX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'LBT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_LB2D')
               IF .getCfgValue('n_LBX_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'LBX' )
               loConversor     = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )
               loConversor.l_Fox2x = .T.
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'LBX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'LBT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_DB2')
               lnFileCount = .get_DBF_Configuration( FORCEEXT(.c_InputFile, 'DBF'), @loDBF_CFG )
               IF !IIF(ISNULL(loDBF_CFG), INLIST(.getCfgValue('n_DBF_Conversion_Support'), 2, 8), INLIST(loDBF_CFG.n_DBF_Conversion_Support, 2, 8) )
                  *-- txt-2-bin support enabled
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'DBF' )
               loConversor     = NewObject( 'c_conversor_prg_a_dbf', 'c_conversor_prg_a_dbf.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'DBF' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FPT' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'CDX' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_DC2')
               IF .getCfgValue('n_DBC_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'DBC' )
               loConversor     = NewObject( 'c_conversor_prg_a_dbc', 'c_conversor_prg_a_dbc.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'DBC' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'DCX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'DCT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_MN2')
               IF .getCfgValue('n_MNX_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'MNX' )
               loConversor     = NewObject( 'c_conversor_prg_a_mnx', 'c_conversor_prg_a_mnx.prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'MNX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'MNT' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_FK2')
               IF .getCfgValue('n_FKY_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               * Not implemented
*!*                  .c_OutputFile   = FORCEEXT( .c_InputFile, 'FKY' )
*!*                  loConversor     = NewObject( 'c_conversor_prg_a_fky', 'c_conversor_prg_a_fky.prg' )
*!*                  .changeFileAttribute( FORCEEXT( .c_InputFile, 'FKY' ), lcForceAttribs )

            CASE lcExtension = .getCfgValue('c_ME2')
               IF .getCfgValue('n_MEM_Conversion_Support') <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               * Not implemented
*!*                  .c_OutputFile   = FORCEEXT( .c_InputFile, 'MEM' )
*!*                  loConversor     = NewObject( 'c_conversor_prg_a_mem', 'c_conversor_prg_a_mem.prg' )
*!*                  .changeFileAttribute( FORCEEXT( .c_InputFile, 'MEM' ), lcForceAttribs )

            OTHERWISE
               *ERROR 'File [' + .c_InputFile + '] is not supported'
               ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))

            ENDCASE

            loConversor.o_SpecialProps = This.o_SpecialProps

            *** DH 2021-03-04: handle cOutputFolder
            loConversor.cOutputFolder = This.cOutputFolder
            *** + mirrored tree: pass the project/source root so the converter can replicate the folder structure
            loConversor.cInputRoot    = This.cInputRoot

            *** + mirrored tree (reverse direction, text->binary):
            *** prg_a_* converters write directly to c_OutputFile (binary),
            *** so here I remap the destination path and create the folder tree.
            *** The forward direction (binary->text) is remapped per file inside write_OutputFile.
            IF NOT EMPTY(.cOutputFolder) ;
                  AND INLIST( UPPER(JUSTEXT(.c_OutputFile)), 'VCX','SCX','PJX','PJM','FRX','LBX','MNX','DBC','DBF' )
               .c_OutputFile = loConversor.get_MirroredOutputFile( .c_OutputFile )
            ENDIF

            *-- Optimization: Compare InputFile and OutputFile timestamps to determine
            *-- whether OutputFile should be regenerated.
            lnFileCount = ADIR( laFiles, FORCEEXT( .c_InputFile, '*' ), '', 1 )
            STORE {//::} TO .t_InputFile_TimeStamp, .t_OutputFile_TimeStamp, ltFilestamp

            IF lnFileCount > 0 THEN
               *-- Find the original input file
               I   = ASCAN( laFiles, JUSTFNAME(.c_InputFile), 1, 0, 1, 1+2+4+8 )
               IF m.I > 0 THEN
                  .t_InputFile_TimeStamp  =   DATETIME( YEAR(laFiles(m.I,3)), MONTH(laFiles(m.I,3)), DAY(laFiles(m.I,3)) ;
                     , VAL(LEFT(laFiles(m.I,4),2)), VAL(SUBSTR(laFiles(m.I,4),4,2)), VAL(RIGHT(laFiles(m.I,4),2)) )
               ENDIF

               IF ADIR( laDirFile, .c_OutputFile ) > 0 THEN
                  I   = ASCAN( laFiles, JUSTFNAME(.c_OutputFile), 1, 0, 1, 1+2+4+8 )
                  IF m.I > 0 THEN
                     .t_OutputFile_TimeStamp =   DATETIME( YEAR(laFiles(m.I,3)), MONTH(laFiles(m.I,3)), DAY(laFiles(m.I,3)) ;
                        , VAL(LEFT(laFiles(m.I,4),2)), VAL(SUBSTR(laFiles(m.I,4),4,2)), VAL(RIGHT(laFiles(m.I,4),2)) )
                  ENDIF

                  lcExtA  = UPPER(JUSTEXT(.c_OutputFile))

                  DO CASE
                  CASE INLIST(lcExtA, 'SCX', 'VCX', 'MNX', 'FRX', 'LBX')
                     lcExtB  = ICASE(lcExtA = 'SCX', 'SCT' ;
                        , lcExtA = 'VCX', 'VCT' ;
                        , lcExtA = 'MNX', 'MNT' ;
                        , lcExtA = 'FRX', 'FRT' ;
                        , lcExtA = 'LBX', 'LBT')
                     I   = ASCAN( laFiles, JUSTFNAME( FORCEEXT(.c_OutputFile, lcExtB) ), 1, 0, 1, 1+2+4+8 )
                     IF m.I > 0 THEN
                        ltFilestamp = DATETIME( YEAR(laFiles(m.I,3)), MONTH(laFiles(m.I,3)), DAY(laFiles(m.I,3)) ;
                           , VAL(LEFT(laFiles(m.I,4),2)), VAL(SUBSTR(laFiles(m.I,4),4,2)), VAL(RIGHT(laFiles(m.I,4),2)) )
                     ENDIF

                  ENDCASE

                  *-- Take the maximum timestamp of output files (??X/??T)
                  .t_OutputFile_TimeStamp =   MAX( .t_OutputFile_TimeStamp, ltFilestamp )
               ENDIF
            ENDIF

            DO CASE
            CASE INLIST(lcExtension,"VCX",.getCfgValue('c_VC2')) AND .getCfgValue('n_UseClassPerFile') = 0 AND .getCfgValue('n_OptimizeByFilestamp') = 1 AND .t_InputFile_TimeStamp < .t_OutputFile_TimeStamp
               *-- Optimized: source is older than destination - no need to regenerate
               *.writeLog( '> Output file [<<This.c_OutputFile>>] is not regenerated because its timestamp is newer than the input.' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )

            CASE INLIST(lcExtension,"VCX",.getCfgValue('c_VC2')) AND .getCfgValue('n_UseClassPerFile') = 0 AND .getCfgValue('n_OptimizeByFilestamp') = 2 AND .t_InputFile_TimeStamp = .t_OutputFile_TimeStamp
               *-- Optimized: source equals destination - no need to regenerate
               *.writeLog( '> Output file [<<This.c_OutputFile>>] is not regenerated because its timestamp is equal to the input.' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )

            CASE INLIST(lcExtension,"SCX",.getCfgValue('c_SC2')) AND .getCfgValue('n_UseFormPerFile') = 0 AND .getCfgValue('n_OptimizeByFilestamp') = 1 AND .t_InputFile_TimeStamp < .t_OutputFile_TimeStamp
               *-- Optimized: source is older than destination - no need to regenerate
               *.writeLog( '> Output file [<<This.c_OutputFile>>] is not regenerated because its timestamp is newer than the input.' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )

            CASE INLIST(lcExtension,"SCX",.getCfgValue('c_SC2')) AND .getCfgValue('n_UseFormPerFile') = 0 AND .getCfgValue('n_OptimizeByFilestamp') = 2 AND .t_InputFile_TimeStamp = .t_OutputFile_TimeStamp
               *-- Optimized: source equals destination - no need to regenerate
               *.writeLog( '> Output file [<<This.c_OutputFile>>] is not regenerated because its timestamp is equal to the input.' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )

            OTHERWISE
               .c_Type                             = UPPER(JUSTEXT(.c_OutputFile))
               loConversor.c_InputFile             = .c_InputFile
               loConversor.c_OutputFile            = .c_OutputFile
               loConversor.c_LogFile               = .c_LogFile
               loConversor.n_Debug                 = .getCfgValue('n_Debug')
               loConversor.l_Test                  = .l_Test
               loConversor.n_FB2PRG_Version        = .n_FB2PRG_Version
               loConversor.l_MethodSort_Enabled    = .l_MethodSort_Enabled
               loConversor.l_PropSort_Enabled      = .l_PropSort_Enabled
               loConversor.l_ReportSort_Enabled    = .l_ReportSort_Enabled
               loConversor.c_OriginalFileName      = .c_OriginalFileName
               loConversor.c_Foxbin2prg_FullPath   = .c_Foxbin2prg_FullPath
               *--
               .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + .c_InputFile + '...', 0, 0, 0 )

               IF AEVENTS( laEvents, loConversor ) = 0 THEN
                  BINDEVENT( loConversor, 'updateProgressbar', THIS, 'updateProgressbar' )
               ENDIF

               loConversor.convert( @toModulo, .F., THIS )

               IF loConversor.l_Error THEN
                  .l_Error = .T.
               ENDIF

               .n_ProcessedFilesCount  = .n_ProcessedFilesCount + 1
               .writeLog()
               .writeLog(loConversor.c_TextLog)    && Recojo el LOG que haya generado el conversor

               *-- Log the errors
               IF NOT EMPTY(loConversor.c_TextErr) THEN
                  .writeErrorLog( REPLICATE( '-', 100 ), 1 )
                  .writeErrorLog( loLang.C_ERRORS_FOUND_IN_FILE_LOC + ' [' + .c_InputFile + '] ' )
                  .writeErrorLog( loConversor.c_TextErr )
                  .writeErrorLog( )
               ENDIF
            ENDCASE

            .normalizeFileCapitalization()
         ENDWITH &&  THIS AS c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'

      CATCH TO toEx
         lnCodError  = toEx.ERRORNO
         *lcErrorInfo    = This.exception2Str(toEx) + CR_LF + CR_LF + loLang.C_SOURCEFILE_LOC + This.c_InputFile

         *-- updateProcessedFile( tcProcessed, tcHasErrors, tcSupported, tcReserved )
         This.updateProcessedFile( lnIDInputFile, '', '', 'E1' )

         IF This.getCfgValue('n_Debug') > 0 THEN
            IF _VFP.STARTMODE = 0
               SET STEP ON
            ENDIF
         ENDIF
         IF tlRelanzarError  && Used in unit testing
            THROW
         ENDIF

      FINALLY
         IF AEVENTS( laEvents, loConversor ) > 0 THEN
            UNBINDEVENTS( loConversor )
         ENDIF

         STORE .NULL. TO loConversor, loFSO

         IF lnCodError = 0 AND This.l_Error THEN
            This.updateProcessedFile( lnIDInputFile, '', '', 'E1' )
         ELSE
            *This.updateProcessedFile( lnIDInputFile )
         ENDIF

         RELEASE lcErrorInfo, laDirFile, lcExtension, lnFileCount, laFiles, I ;
            , ltFilestamp, lcExtA, lcExtB ;
            , loConversor, loFSO
      ENDTRY

      RETURN lnCodError
   ENDPROC


   PROCEDURE get_DirSettings
      LPARAMETERS tcDir, tcDebug, tcCFG_File
      This.ensureCfg()
      RETURN This.o_Cfg.get_DirSettings(tcDir, tcDebug, tcCFG_File)
   ENDPROC


   PROCEDURE captureFactoryCFG
      This.ensureCfg()
      This.o_Cfg.captureFactoryCFG()
   ENDPROC


   PROCEDURE createCfgShell
      This.ensureCfg()
      RETURN This.o_Cfg.createCfgShell()
   ENDPROC


   PROCEDURE getActiveCfg
      This.ensureCfg()
      RETURN This.o_Cfg.getActiveCfg()
   ENDPROC


   PROCEDURE getCfgValue
      LPARAMETERS tcProp
      This.ensureCfg()
      RETURN This.o_Cfg.getCfgValue(tcProp)
   ENDPROC


   PROCEDURE getCfgFlag
      LPARAMETERS tcProp, tlDefault
      This.ensureCfg()
      RETURN This.o_Cfg.getCfgFlag(tcProp, tlDefault)
   ENDPROC


   PROCEDURE getCfgInt
      LPARAMETERS tcProp, lnDefault
      This.ensureCfg()
      RETURN This.o_Cfg.getCfgInt(tcProp, lnDefault)
   ENDPROC


   PROCEDURE getCfgObjectForWrite
      This.ensureCfg()
      RETURN This.o_Cfg.getCfgObjectForWrite()
   ENDPROC


   PROCEDURE setCfgValue
      LPARAMETERS tcProp, txVal
      This.ensureCfg()
      This.o_Cfg.setCfgValue(tcProp, txVal)
   ENDPROC


   PROCEDURE isCfg
      LPARAMETERS toObj
      This.ensureCfg()
      RETURN This.o_Cfg.isCfg(toObj)
   ENDPROC


   PROCEDURE cfgCopyFrom
      LPARAMETERS toParentCFG, toSourceCFG
      This.ensureCfg()
      This.o_Cfg.cfgCopyFrom(toParentCFG, toSourceCFG)
   ENDPROC


   PROCEDURE newConfig
      This.ensureCfg()
      RETURN This.o_Cfg.newConfig()
   ENDPROC


   PROCEDURE configFromObject
      LPARAMETERS toSource, toDestCfg
      This.ensureCfg()
      RETURN This.o_Cfg.configFromObject(toSource, toDestCfg)
   ENDPROC


   PROCEDURE applyConfig
      LPARAMETERS toCfg
      This.ensureCfg()
      RETURN This.o_Cfg.applyConfig(toCfg)
   ENDPROC


   PROCEDURE exportProjectTree
      *---------------------------------------------------------------------------------------------------
      * Exports a complete project (.PJX) to a destination folder, replicating the folder tree
      * that components have relative to the project folder.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcProjectFile             (v! IN    ) Project path to export (.PJX or .PJ2)
      * tcOutputRoot              (v! IN    ) Destination root folder where the tree is replicated
      * toCfg                     (v? IN    ) (Optional) Configuration object or .cfg file path to apply before exporting
      * tcInputRoot               (v? IN    ) (Optional) Source root. Default: the project folder
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcProjectFile, tcOutputRoot, toCfg, tcInputRoot
      LOCAL loEx AS EXCEPTION, loCfg

      *-- Normalize configuration: CFG object, duck-typed object, or .cfg file path string
      IF VARTYPE(toCfg) = 'O' AND !ISNULL(toCfg)
         IF This.isCfg( toCfg )
            loCfg = toCfg
         ELSE
            loCfg = This.configFromObject(toCfg)
         ENDIF
      ELSE
         IF VARTYPE(toCfg) = 'C' AND !EMPTY(toCfg)
            loCfg = toCfg
         ENDIF
      ENDIF

      This.ensureMirror()
      This.o_Mirror.setProjectRoots( tcOutputRoot, EVL( tcInputRoot, ADDBS( JUSTPATH( FULLPATH(tcProjectFile) ) ) ) )

      *-- '*' => processes the complete project (including the PJX/PJ2 itself)
      *-- CFG is passed through the official channel (execute tcCFG_File parameter: object or path)
      RETURN This.execute( tcProjectFile, '*'  , .F. , .F. , ''   ;
                         , ''           , ''   , .NULL., @loEx, .F.  ;
                         , ''           , ''   , ''  , .F. , .F.  ;
                         , .F.          , loCfg )
   ENDPROC


   PROCEDURE importProjectTree
      *---------------------------------------------------------------------------------------------------
      * Imports a complete mirrored project (.PJ2) into a destination folder, replicating the folder
      * tree that components have relative to the mirrored project root.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcMirrorProjectFile       (v! IN    ) Mirrored project path to import (.PJ2 or c_PJ2 CFG value)
      * tcOutputRoot              (v! IN    ) Destination root folder where binaries are regenerated
      * toCfg                     (v? IN    ) (Optional) Configuration object or .cfg file path to apply before importing
      * tcInputRoot               (v? IN    ) (Optional) Mirrored source root. Default: the PJ2 folder
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcMirrorProjectFile, tcOutputRoot, toCfg, tcInputRoot
      LOCAL loEx AS EXCEPTION, loCfg

      *-- Normalize configuration: CFG object, duck-typed object, or .cfg file path string
      loCfg        = .NULL.
      IF VARTYPE(toCfg) = 'O' AND !ISNULL(toCfg)
         IF This.isCfg( toCfg )
            loCfg = toCfg
         ELSE
            loCfg = This.configFromObject(toCfg)
         ENDIF
      ELSE
         IF VARTYPE(toCfg) = 'C' AND !EMPTY(toCfg)
            loCfg = toCfg
         ENDIF
      ENDIF

      This.ensureMirror()
      This.o_Mirror.setProjectRoots( tcOutputRoot, EVL( tcInputRoot, ADDBS( JUSTPATH( FULLPATH(tcMirrorProjectFile) ) ) ) )

      *-- '*' => processes the complete project (including the PJ2/PJX itself)
      *-- CFG is passed through the official channel (execute tcCFG_File parameter: object or path)
      RETURN This.execute( tcMirrorProjectFile, '*', .F. , .F. , '' ;
                         , ''  , ''    , .NULL., @loEx, .F.  ;
                         , ''  , ''    , ''    , .F.  , .F.  ;
                         , .F. , loCfg )
   ENDPROC


   PROCEDURE makeDirTree
      LPARAMETERS tcDir
      This.ensureMirror()
      RETURN This.o_Mirror.makeDirTree(tcDir)
   ENDPROC


   PROCEDURE getPerFileDir
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path (or base path without class suffix)
      * tcTextExt                 (v! IN    ) Text extension (c_VC2 or c_SC2)
      * tlUsePerDir               (v! IN    ) UseClassPerDir or UseFormPerDir flag
      * lnUsePerFile              (v! IN    ) UseClassPerFile or UseFormPerFile value
      * RETURN                    (v?    OUT) Directory for per-file text output/search
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcStem, lcDir

      lcStem  = JUSTSTEM(tcBinaryFile)
      IF VARTYPE(tlUsePerDir) = 'N'
         tlUsePerDir = (tlUsePerDir # 0)
      ENDIF
      IF ISNULL(tlUsePerDir)
         tlUsePerDir = .F.
      ENDIF
      IF VARTYPE(lnUsePerFile) = 'L'
         lnUsePerFile = IIF(lnUsePerFile, 1, 0)
      ENDIF
      lnUsePerFile = EVL(lnUsePerFile, 0)
      IF lnUsePerFile > 0 AND tlUsePerDir
         lcDir   = ADDBS(JUSTPATH(tcBinaryFile)) + lcStem + '.' + tcTextExt
      ELSE
         lcDir   = JUSTPATH(tcBinaryFile)
      ENDIF

      RETURN lcDir
   ENDPROC


   PROCEDURE getPerFileOutputPath
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path
      * tcSuffix                  (v? IN    ) Class/object suffix; empty = header file
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Full output text file path
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcSuffix, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcStem, lcBase, lcPath

      IF VARTYPE(tlUsePerDir) = 'N'
         tlUsePerDir = (tlUsePerDir # 0)
      ENDIF
      IF ISNULL(tlUsePerDir)
         tlUsePerDir = .F.
      ENDIF
      IF VARTYPE(lnUsePerFile) = 'L'
         lnUsePerFile = IIF(lnUsePerFile, 1, 0)
      ENDIF
      lnUsePerFile = EVL(lnUsePerFile, 0)

      lcStem  = JUSTSTEM(tcBinaryFile)
      lcBase  = This.getPerFileDir(tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile)

      IF lnUsePerFile > 0 AND tlUsePerDir
         IF EMPTY(tcSuffix)
            lcPath  = ADDBS(lcBase) + lcStem + '.' + tcTextExt
         ELSE
            lcPath  = ADDBS(lcBase) + lcStem + '.' + tcSuffix + '.' + tcTextExt
         ENDIF
      ELSE
         IF EMPTY(tcSuffix)
            lcPath  = FORCEEXT(tcBinaryFile, tcTextExt)
         ELSE
            lcPath  = ADDBS(JUSTPATH(tcBinaryFile)) + lcStem + '.' + tcSuffix + '.' + tcTextExt
         ENDIF
      ENDIF

      RETURN lcPath
   ENDPROC


   PROCEDURE getPerFileSearchDir
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcTextFile                (v! IN    ) Header or per-class text file path
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Directory to search for sibling per-file text parts
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcTextFile, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcParent, lcStem, lcSearchDir, lcExt

      IF VARTYPE(tlUsePerDir) = 'N'
         tlUsePerDir = (tlUsePerDir # 0)
      ENDIF
      IF ISNULL(tlUsePerDir)
         tlUsePerDir = .F.
      ENDIF
      IF VARTYPE(lnUsePerFile) = 'L'
         lnUsePerFile = IIF(lnUsePerFile, 1, 0)
      ENDIF
      lnUsePerFile = EVL(lnUsePerFile, 0)
      IF lnUsePerFile = 0 OR !tlUsePerDir
         RETURN JUSTPATH(tcTextFile)
      ENDIF

      lcParent    = JUSTPATH(tcTextFile)
      lcExt       = '.' + LOWER(tcTextExt)
      IF RIGHT(LOWER(lcParent), LEN(lcExt)) == lcExt
         RETURN lcParent
      ENDIF

      lcStem      = JUSTSTEM(tcTextFile)
      lcSearchDir = ADDBS(lcParent) + lcStem + '.' + tcTextExt
      RETURN lcSearchDir
   ENDPROC


   PROCEDURE getPerFileBinaryOutputPath
      *---------------------------------------------------------------------------------------------------
      * Binary output path for Prg2Bin when text lives under a per-dir folder (library.vc2\).
      * E.g. classes\controls.vc2\controls.vc2 -> classes\controls.vcx (not classes\controls.vc2\controls.vcx).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcSourceFile              (v! IN    ) Source text file path (header or per-class part)
      * tcBinExt                  (v! IN    ) Binary extension (VCX, SCX, ...)
      * tcTextExt                 (v! IN    ) Text extension (c_VC2, c_SC2, ...)
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Binary file path for output
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcSourceFile, tcBinExt, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcParent, lcTextExtLower, lcContainerStem

      IF VARTYPE(tlUsePerDir) = 'N'
         tlUsePerDir = (tlUsePerDir # 0)
      ENDIF
      IF ISNULL(tlUsePerDir)
         tlUsePerDir = .F.
      ENDIF
      IF VARTYPE(lnUsePerFile) = 'L'
         lnUsePerFile = IIF(lnUsePerFile, 1, 0)
      ENDIF
      lnUsePerFile = EVL(lnUsePerFile, 0)

      IF lnUsePerFile > 0 AND tlUsePerDir
         lcParent         = JUSTPATH(tcSourceFile)
         lcTextExtLower   = '.' + LOWER(EVL(tcTextExt, ''))
         IF LEN(lcTextExtLower) > 1 AND RIGHT(LOWER(lcParent), LEN(lcTextExtLower)) == lcTextExtLower
            lcContainerStem = JUSTSTEM(FORCEEXT(lcParent, tcTextExt))
            RETURN ADDBS(JUSTPATH(lcParent)) + lcContainerStem + '.' + tcBinExt
         ENDIF
      ENDIF

      RETURN FORCEEXT(tcSourceFile, tcBinExt)
   ENDPROC


   PROCEDURE ensurePerFileDir
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcDir

      IF VARTYPE(tlUsePerDir) = 'N'
         tlUsePerDir = (tlUsePerDir # 0)
      ENDIF
      IF ISNULL(tlUsePerDir)
         tlUsePerDir = .F.
      ENDIF
      IF VARTYPE(lnUsePerFile) = 'L'
         lnUsePerFile = IIF(lnUsePerFile, 1, 0)
      ENDIF
      lnUsePerFile = EVL(lnUsePerFile, 0)
      IF lnUsePerFile = 0 OR !tlUsePerDir
         RETURN
      ENDIF

      lcDir   = This.getPerFileDir(tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile)
      IF FILE(lcDir)
         ERASE (lcDir)
      ENDIF
      This.makeDirTree(lcDir)
   ENDPROC


   PROCEDURE get_MirroredPath
      LPARAMETERS tcFile
      This.ensureMirror()
      RETURN This.o_Mirror.get_MirroredPath(tcFile)
   ENDPROC


   PROCEDURE isExcludedSubdir
      LPARAMETERS tcFile
      This.ensureMirror()
      RETURN This.o_Mirror.isExcludedSubdir(tcFile)
   ENDPROC


   PROCEDURE isUnderInputRoot
      LPARAMETERS tcFile
      This.ensureMirror()
      RETURN This.o_Mirror.isUnderInputRoot(tcFile)
   ENDPROC


   PROCEDURE copyUnconvertedFile
      LPARAMETERS tcFile
      This.ensureMirror()
      RETURN This.o_Mirror.copyUnconvertedFile(tcFile)
   ENDPROC


   FUNCTION isTextFileForEncoding
      *---------------------------------------------------------------------------------------------------
      * True for plain-text project files that may be UTF-8 encoded when copied in mirrored tree mode.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile
      LOCAL lcExt, lcSample, lnHandle

      lcExt = UPPER(JUSTEXT(tcFile))

      IF NOT INLIST(lcExt, 'PRG', 'TXT', 'H', 'FPW', 'MPR', 'SPR', 'CFG', 'INI', 'SQL' ;
                         , 'MD', 'BAT', 'LOG', 'CSV', 'XML', 'HTM', 'HTML', 'JSON')
         RETURN .F.
      ENDIF

      IF NOT FILE(tcFile)
         RETURN .F.
      ENDIF

      lnHandle = FOPEN(tcFile, 0)

      IF lnHandle < 0
         RETURN .F.
      ENDIF

      lcSample = FREAD(lnHandle, 8192)
      = FCLOSE(lnHandle)

      IF OCCURS(CHR(0), lcSample) > 0
         RETURN .F.
      ENDIF

      RETURN .T.
   ENDFUNC


   PROCEDURE get_PROGRAM_HEADER
      LOCAL lcText
      lcText  = ''

      *-- PRG header and start of DEF_CLASS
      *!* LScheffler 22.08.2023
      *issue #96, [KestasL] keep CodePage relavant information for binary sources, added CPID value
      TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            *--------------------------------------------------------------------------------------------------------------------------------------------------------
            * (EN) AUTOGENERATED - ATTENTION!! - NOT INTENDED FOR EXECUTION!! USE ONLY FOR MERGING CHANGES AND STORING WITH SCM TOOLS!!
            *--------------------------------------------------------------------------------------------------------------------------------------------------------
            <<C_FB2PRG_META_I>> Version="<<TRANSFORM(This.n_FB2PRG_Version)>>" SourceFile="<<LOWER( JUSTFNAME( EVL( This.c_OriginalFileName, This.c_InputFile ) ) )>>" CPID="<<This.i_CPID>>" <<C_FB2PRG_META_F>> (Solo para binarios VFP 9 / Only for VFP 9 binaries)
            *
      ENDTEXT

      RETURN lcText
   ENDPROC


   PROCEDURE getNext_BAK
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_OutputFilename         (v! IN    ) Output file name for which to create a backup
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tcOutputFileName
      LOCAL lcNext_Bak, I, laDirInfo(1,5)
      lcNext_Bak  = '.BAK'

      FOR I = 1 TO This.getCfgValue('n_ExtraBackupLevels')
         IF m.I = 1
            IF NOT ADIR( laDirInfo, tcOutputFileName + '.BAK' ) > 0 THEN
               lcNext_Bak  = '.BAK'
               EXIT
            ENDIF
         ELSE
            IF NOT ADIR( laDirInfo, tcOutputFileName + '.' + PADL(m.I-1,1,'0') + '.BAK' ) > 0 THEN
               lcNext_Bak  = '.' + PADL(m.I-1,1,'0') + '.BAK'
               EXIT
            ENDIF
         ENDIF
      ENDFOR

      RETURN lcNext_Bak
   ENDPROC


   PROCEDURE get_SeparatedLineAndComment
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Line to separate from the comment
      * tcComment                 (@?    OUT) Comment
      * tlDeepCommentAnalysis     (v? IN    ) Perform deep comment analysis (to detect complex code cases with embedded '&&')
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcLine AS STRING, tcComment AS STRING, tlDeepCommentAnalysis AS Boolean
      LOCAL ln_AT_Cmt
      tcComment   = ''
      ln_AT_Cmt   = AT( '&'+'&', tcLine)

      IF ln_AT_Cmt > 0
         IF tlDeepCommentAnalysis THEN
            LOCAL laSeparador(3,3), lcSeparadoresIzq, lcSeparadoresDer, lcStr, lnAT_Amp, lnAT1, lnAT2, lnLen, I, X

            lcStr   = tcLine    &&EVL(tcStr, [DEFINE BAR 2 OF OptionAsub PROMPT "Option A&]+[&2" &]+[& Comment Option A-2])
            laSeparador(1,1)    = '"'
            laSeparador(1,2)    = '"'
            laSeparador(1,3)    = 2
            laSeparador(2,1)    = "'"
            laSeparador(2,2)    = "'"
            laSeparador(2,3)    = 2
            laSeparador(3,1)    = '['
            laSeparador(3,2)    = ']'
            laSeparador(3,3)    = 1
            lcSeparadoresIzq    = laSeparador(1,1) + laSeparador(2,1) + laSeparador(3,1)
            lcSeparadoresDer    = laSeparador(1,2) + laSeparador(2,2) + laSeparador(3,2)
            lnLen               = LEN(lcStr)

            *-- Nullify substrings to find '&&' comments (and analyze only if at least one '&&' exists)
            X       = 1
            lnAT1   = AT(laSeparador(m.X,1), lcStr)

            *-- Operation:
            *-- Substring nullification starts from the first double quote ["], then
            *-- cancels until the next one. From there, search character by character for the next separator
            *-- left string delimiter ( '"[ ), find its right pair and cancel the text between them.
            *-- Substring nullification is temporary, only to determine the true comment position,
            *-- for example, this:
            *-- DEFINE BAR 2 OF OptionAsub PROMPT ""+var+'aa'+["bb]+"Option A&&2" && Comment Option A-2
            *-- is temporarily converted to this:
            *-- DEFINE BAR 2 OF OptionAsub PROMPT XX+var+XXXX+XXXXX+XXXXXXXXXXXXX && Comment Option A-2
            *-- which makes it easier to find the real '&&' comment.
            *-- If an unclosed string delimiter is found, error 10 (Syntax Error) is raised.
            IF lnAT1 > 0 THEN
               FOR I = lnAT1+1 TO lnLen
                  IF m.X > 0 THEN
                     lnAT2   = AT(laSeparador(m.X,2), lcStr, laSeparador(m.X,3))

                     IF lnAT2 > 0 THEN
                        lcStr   = STUFF(lcStr, lnAT1, lnAT2-lnAT1+1, REPLICATE('X',lnAT2-lnAT1+1))
                     ELSE
                        ln_AT_Cmt   = AT( '&'+'&', lcStr)

                        IF ln_AT_Cmt = 0 OR ln_AT_Cmt < lnAT1
                           *-- Has no real '&&' comment, or has one that also contains a string delimiter as part of the comment
                           EXIT
                        ELSE
                           ERROR 'Closing string delimiter <' + laSeparador(m.X,2) + '> not found: ' + tcLine
                        ENDIF
                     ENDIF
                  ENDIF

                  *-- Check whether the character is a string delimiter: '"[
                  X   = AT( SUBSTR(lcStr, m.I, 1), lcSeparadoresIzq)

                  IF m.X > 0 THEN
                     lnAT1   = AT(laSeparador(m.X,1), lcStr)
                  ENDIF
               ENDFOR
            ENDIF

            ln_AT_Cmt   = AT( '&'+'&', lcStr)
         ENDIF && tlDeepCommentAnalysis

         IF ln_AT_Cmt > 0
            tcComment   = LTRIM( SUBSTR( tcLine, ln_AT_Cmt + 2 ) )
            tcLine      = RTRIM( LEFT( tcLine, ln_AT_Cmt - 1 ), 0, CHR(9), ' ' )    && Quito TABS y espacios
         ENDIF

      ENDIF

      RETURN (ln_AT_Cmt > 0)
   ENDPROC


   PROCEDURE normalizeFileCapitalization
      LPARAMETERS tl_NormalizeInputFile, tcFileName

      TRY
         LOCAL lcPath, lcEXE_CAPS, lcOutputFile, llRelanzarError, lcType, laDirInfo(1,5) ;
            , loEx AS EXCEPTION ;
            , loLang AS CL_LANG OF 'cl_lang.prg' ;
            , loFSO AS Scripting.FileSystemObject

         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            IF NOT .l_ProcessFiles
               EXIT
            ENDIF

            loLang          = _SCREEN.o_FoxBin2Prg_Lang
            lcPath          = JUSTPATH(.c_Foxbin2prg_FullPath)
            lcEXE_CAPS      = FORCEPATH( 'filename_caps.exe', lcPath )
            loFSO           = .o_FSO
            llRelanzarError = NOT tl_NormalizeInputFile

            IF tl_NormalizeInputFile
               tcFileName  = EVL( tcFileName, .c_InputFile )
               lcType      = UPPER( JUSTEXT( tcFileName ) )
            ELSE
               tcFileName  = EVL( tcFileName, .c_OutputFile )
               lcType      = .c_Type
            ENDIF

            DO CASE
            CASE .n_ExisteCapitalizacion = -1
               *-- First time is -1, performs the check once and caches the answer
               IF FILE(lcEXE_CAPS)
                  *.writeLog( '* Name capitalization program found [' + lcEXE_CAPS + ']' )
                  .writeLog( C_TAB + TEXTMERGE(loLang.C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC) )
                  SET PROCEDURE TO (lcEXE_CAPS) ADDITIVE
                  .o_FNC  = CREATEOBJECT( 'cl_FileName_Caps' )
                  RELEASE PROCEDURE (lcEXE_CAPS)

                  .n_ExisteCapitalizacion = 1
               ELSE
                  *-- Capitalization program does not exist, so names are not capitalized.
                  *.writeLog( '* Name capitalization program not found [' + lcEXE_CAPS + ']' )
                  .writeLog( C_TAB + TEXTMERGE(loLang.C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC) )
                  .n_ExisteCapitalizacion = 0
                  EXIT
               ENDIF

            CASE .n_ExisteCapitalizacion = 0
               *-- Second pass onward: No capitalization program
               EXIT

            OTHERWISE
               *-- Second pass onward: Capitalization program available

            ENDCASE

            *-- Normalize input file(s). The first is always normalized (??2, ??X, DBF, DBC)
            .renameFile( tcFileName, lcEXE_CAPS, loFSO, llRelanzarError )

            DO CASE
            CASE lcType = 'PJX'
               .renameFile( FORCEEXT(tcFileName,'PJT'), lcEXE_CAPS, loFSO, llRelanzarError )

            CASE lcType = 'VCX'
               .renameFile( FORCEEXT(tcFileName,'VCT'), lcEXE_CAPS, loFSO, llRelanzarError )

            CASE lcType = 'SCX'
               .renameFile( FORCEEXT(tcFileName,'SCT'), lcEXE_CAPS, loFSO, llRelanzarError )

            CASE lcType = 'FRX'
               .renameFile( FORCEEXT(tcFileName,'FRT'), lcEXE_CAPS, loFSO, llRelanzarError )

            CASE lcType = 'LBX'
               .renameFile( FORCEEXT(tcFileName,'LBT'), lcEXE_CAPS, loFSO, llRelanzarError )

            CASE lcType = 'DBF'
               IF ADIR( laDirInfo, FORCEEXT(tcFileName,'FPT') ) > 0 THEN
                  .renameFile( FORCEEXT(tcFileName,'FPT'), lcEXE_CAPS, loFSO, llRelanzarError )
               ENDIF
               IF ADIR( laDirInfo, FORCEEXT(tcFileName,'CDX') ) > 0 THEN
                  .renameFile( FORCEEXT(tcFileName,'CDX'), lcEXE_CAPS, loFSO, llRelanzarError )
               ENDIF

            CASE lcType = 'DBC'
               .renameFile( FORCEEXT(tcFileName,'DCX'), lcEXE_CAPS, loFSO, llRelanzarError )
               .renameFile( FORCEEXT(tcFileName,'DCT'), lcEXE_CAPS, loFSO, llRelanzarError )

            CASE lcType = 'MNX'
               .renameFile( FORCEEXT(tcFileName,'MNT'), lcEXE_CAPS, loFSO, llRelanzarError )

            ENDCASE

         ENDWITH && THIS

      CATCH TO loEx
         THROW

      FINALLY
         loFSO   = .NULL.
         RELEASE lcPath, lcEXE_CAPS, lcOutputFile, llRelanzarError, lcType, loFSO

      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE get_FilesFromDirectory
      LPARAMETERS tcDir, taFiles, tnFileCount
      EXTERNAL ARRAY taFiles

      LOCAL laFiles(1), I, lnFiles ;
         , loLang AS CL_LANG OF 'cl_lang.prg'

      IF TYPE("ALEN(laFiles)") # "N" OR EMPTY(tnFileCount)
         tnFileCount = 0
         DIMENSION taFiles(1)
      ENDIF

      tcDir   = ADDBS(tcDir)

      IF DIRECTORY(tcDir)
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            loLang          = _SCREEN.o_FoxBin2Prg_Lang
            .updateProgressbar( loLang.C_SCANNING_FILE_AND_DIR_INFO_LOC + ' ' + tcDir + '...', 0, 0, 0 )
            lnFiles = ADIR( laFiles, tcDir + '*.*', 'D', 1)

            *-- Find the files
            FOR I = 1 TO lnFiles
               IF SUBSTR( laFiles(m.I,5), 5, 1 ) == 'D'
                  LOOP
               ENDIF

               tnFileCount = tnFileCount + 1
               DIMENSION taFiles(tnFileCount)
               taFiles(tnFileCount)    = tcDir + laFiles(m.I,1)
            ENDFOR

            *-- Find the subdirectories
            FOR I = 1 TO lnFiles
               IF NOT SUBSTR( laFiles(m.I,5), 5, 1 ) == 'D' OR LEFT(laFiles(m.I,1), 1) == '.'
                  LOOP
               ENDIF
               .get_FilesFromDirectory( tcDir + laFiles(m.I,1), @taFiles, @tnFileCount )
            ENDFOR
         ENDWITH
      ENDIF
   ENDPROC


   PROCEDURE loadModule
      *--------------------------------------------------------------------------------------------------------------
      * LOADS THE MODULE IN tc_InputFile AND RETURNS ITS OBJECT REFERENCE IN toModulo
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Input file name
      * toModulo                  (@?    OUT) Object reference of the generated module (for unit testing)
      * toEx                      (@?    OUT) Object with error information
      * tlRelanzarError           (v? IN    ) Whether the error should be re-thrown
      * tcOriginalFileName        (v? IN    ) For cases where inputFile is a temporary name and the correct name should be generated
      *                                       the correct name within the text version (e.g. in PJ2 and headers)
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, toModulo, toEx AS EXCEPTION, tlRelanzarError, tcOriginalFileName

      TRY
         LOCAL lnCodError, lcErrorInfo, laDirFile(1,5), lcExtension, lnFileCount, laFiles(1,1), I ;
            , ltFilestamp, lcExtA, lcExtB, laEvents(1,1), lnIDInputFile ;
            , loLang AS CL_LANG OF 'cl_lang.prg' ;
            , loConversor AS c_conversor_base OF 'c_conversor_base.prg' ;
            , loFSO AS Scripting.FileSystemObject
         lnCodError          = 0

         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            STORE .NULL. TO toModulo
            lc_OldSetNotify = SET("Notify")
            SET NOTIFY OFF
            loFSO           = .o_FSO
            loLang          = _SCREEN.o_FoxBin2Prg_Lang
            .c_InputFile    = FULLPATH( tc_InputFile )
            .l_Error        = .F.
            lcExtension     = UPPER( JUSTEXT(.c_InputFile) )

            .writeLog( REPLICATE( '*', 100 ) )
            .writeLog( 'LOAD MODULE', 2 )
            .writeLog( REPLICATE( '*', 100 ) )

            IF ADIR( laDirFile, .c_InputFile, '', 1 ) = 0
               *ERROR 'File not found [' + .c_InputFile + ']'
               ERROR loLang.C_FILE_NOT_FOUND_LOC + ' [' + .c_InputFile + ']'
            ENDIF

            .c_InputFile    = loFSO.GetAbsolutePathName( FORCEPATH( laDirFile(1,1), JUSTPATH(.c_InputFile) ) )

            *-- CHECK FOR SECONDARY CONFIGURATION FILE
            .evaluateConfiguration()


            IF NOT EMPTY(tcOriginalFileName)
               tcOriginalFileName  = loFSO.GetAbsolutePathName( tcOriginalFileName )
            ENDIF

            .c_OriginalFileName = EVL( tcOriginalFileName, .c_InputFile )

            IF UPPER( JUSTEXT(.c_OriginalFileName) ) = 'PJM' AND .getCfgValue('c_PJ2') <> 'PJM'
               .c_OriginalFileName = FORCEEXT(.c_OriginalFileName,'pjx')
            ENDIF

            lnIDInputFile   = .n_ProcessedFiles

            .writeLog( C_TAB + 'c_OriginalFileName:           ' + .c_OriginalFileName )
            .writeLog( )

            IF NOT ADIR(laDirFile, .c_InputFile) > 0 THEN
               ERROR loLang.C_FILE_DOESNT_EXIST_LOC + ' [' + .c_InputFile + ']'
            ENDIF

            DO CASE
            CASE lcExtension = 'VCX'
               loConversor     = NewObject( 'c_conversor_vcx_a_prg' , 'c_conversor_vcx_a_prg.prg' )

            CASE lcExtension = 'SCX'
               loConversor     = NewObject( 'c_conversor_scx_a_prg' , 'c_conversor_scx_a_prg.prg' )

            CASE lcExtension = 'PJX'
               loConversor     = NewObject( 'c_conversor_pjx_a_prg' , 'c_conversor_pjx_a_prg.prg' )

            CASE lcExtension = 'PJM' AND .getCfgValue('c_PJ2') <> 'PJM'
               loConversor     = NewObject( 'c_conversor_pjm_a_prg', 'c_conversor_pjm_a_prg.prg' )

            CASE lcExtension = 'FRX'
               loConversor     = NewObject( 'c_conversor_frx_a_prg' , 'c_conversor_frx_a_prg.prg' )
               loConversor.l_Fox2x = .detectFox2xRptLbl(.c_InputFile)

            CASE lcExtension = 'LBX'
               loConversor     = NewObject( 'c_conversor_frx_a_prg' , 'c_conversor_frx_a_prg.prg' )
               loConversor.l_Fox2x = .detectFox2xRptLbl(.c_InputFile)

            CASE lcExtension = 'DBF'
               loConversor     = NewObject( 'c_conversor_dbf_a_prg', 'c_conversor_dbf_a_prg.prg' )

            CASE lcExtension = 'DBC'
               loConversor     = NewObject( 'c_conversor_dbc_a_prg', 'c_conversor_dbc_a_prg.prg' )

            CASE lcExtension = 'MNX'
               loConversor     = NewObject( 'c_conversor_mnx_a_prg' , 'c_conversor_mnx_a_prg.prg' )

            CASE lcExtension = .getCfgValue('c_VC2')
               loConversor     = NewObject( 'c_conversor_prg_a_vcx', 'c_conversor_prg_a_vcx.prg' )

            CASE lcExtension = .getCfgValue('c_SC2')
               loConversor     = NewObject( 'c_conversor_prg_a_scx', 'c_conversor_prg_a_scx.prg' )

            CASE lcExtension = .getCfgValue('c_PJ2')
               loConversor     = NewObject( 'c_conversor_prg_a_pjx' , 'c_conversor_prg_a_pjx.prg' )

            CASE lcExtension = .getCfgValue('c_FR2')
               loConversor     = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )

            CASE lcExtension = .getCfgValue('c_FR2D')
               loConversor     = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )
               loConversor.l_Fox2x = .T.

            CASE lcExtension = .getCfgValue('c_LB2')
               loConversor     = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )

            CASE lcExtension = .getCfgValue('c_LB2D')
               loConversor     = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )
               loConversor.l_Fox2x = .T.

            CASE lcExtension = .getCfgValue('c_DB2')
               loConversor     = NewObject( 'c_conversor_prg_a_dbf', 'c_conversor_prg_a_dbf.prg' )

            CASE lcExtension = .getCfgValue('c_DC2')
               loConversor     = NewObject( 'c_conversor_prg_a_dbc', 'c_conversor_prg_a_dbc.prg' )

            CASE lcExtension = .getCfgValue('c_MN2')
               loConversor     = NewObject( 'c_conversor_prg_a_mnx', 'c_conversor_prg_a_mnx.prg' )

            OTHERWISE
               *ERROR 'File [' + .c_InputFile + '] is not supported'
               ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))

            ENDCASE

            loConversor.o_SpecialProps = This.o_SpecialProps

            .c_Type                             = UPPER(JUSTEXT(.c_OutputFile))
            loConversor.c_InputFile             = .c_InputFile
            loConversor.c_OutputFile            = .c_OutputFile
            loConversor.c_LogFile               = .c_LogFile
            loConversor.n_Debug                 = .getCfgValue('n_Debug')
            loConversor.l_Test                  = .l_Test
            loConversor.n_FB2PRG_Version        = .n_FB2PRG_Version
            loConversor.l_MethodSort_Enabled    = .l_MethodSort_Enabled
            loConversor.l_PropSort_Enabled      = .l_PropSort_Enabled
            loConversor.l_ReportSort_Enabled    = .l_ReportSort_Enabled
            loConversor.c_OriginalFileName      = .c_OriginalFileName
            loConversor.c_Foxbin2prg_FullPath   = .c_Foxbin2prg_FullPath
            *--
            *.updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + .c_InputFile + '...', 0, 0, 0 )

            *IF AEVENTS( laEvents, loConversor ) = 0 THEN
            *   BINDEVENT( loConversor, 'updateProgressbar', THIS, 'updateProgressbar' )
            *ENDIF

            loConversor.loadModule( @toModulo, .F., THIS )

            IF loConversor.l_Error THEN
               .l_Error = .T.
            ENDIF

            *.n_ProcessedFilesCount = .n_ProcessedFilesCount + 1
            .writeLog()
            .writeLog(loConversor.c_TextLog)    && Recojo el LOG que haya generado el conversor

            *-- Log the errors
            IF NOT EMPTY(loConversor.c_TextErr) THEN
               .writeErrorLog( REPLICATE( '-', 100 ), 1 )
               .writeErrorLog( loLang.C_ERRORS_FOUND_IN_FILE_LOC + ' [' + .c_InputFile + '] ' )
               .writeErrorLog( loConversor.c_TextErr )
               .writeErrorLog( )
            ENDIF

         ENDWITH &&  THIS AS c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'

      CATCH TO toEx
         lnCodError  = toEx.ERRORNO
         *lcErrorInfo    = This.exception2Str(toEx) + CR_LF + CR_LF + loLang.C_SOURCEFILE_LOC + This.c_InputFile

         *-- updateProcessedFile( tcProcessed, tcHasErrors, tcSupported, tcReserved )
         *This.updateProcessedFile( lnIDInputFile, '', '', 'E1' )

         IF This.getCfgValue('n_Debug') > 0 THEN
            IF _VFP.STARTMODE = 0
               SET STEP ON
            ENDIF
         ENDIF
         IF tlRelanzarError  && Used in unit testing
            THROW
         ENDIF

      FINALLY
         SET NOTIFY &lc_OldSetNotify.

         *IF AEVENTS( laEvents, loConversor ) > 0 THEN
         *   UNBINDEVENTS( loConversor )
         *ENDIF

         STORE .NULL. TO loConversor, loFSO

         *IF lnCodError = 0 AND This.l_Error THEN
         *   This.updateProcessedFile( lnIDInputFile, '', '', 'E1' )
         *ELSE
         *   *This.updateProcessedFile( lnIDInputFile )
         *ENDIF

         RELEASE lcErrorInfo, laDirFile, lcExtension, lnFileCount, laFiles, I ;
            , ltFilestamp, lcExtA, lcExtB ;
            , loConversor, loFSO
      ENDTRY

      RETURN lnCodError
   ENDPROC


   PROCEDURE readInputVFPParams
      LPARAMETERS taParams, tnPCount
      EXTERNAL ARRAY taParams
      *-----------------------------------------------------------------------------
      * Get the full command line
      * Adapted from http://www.news2news.com/vfp/?example=51&function=78
      * Contributed by Mario Lopez on the Google FoxPro Spanish forum - 23/12/2013
      * https://groups.google.com/d/msg/publicesvfoxpro/llS-kTNrG9M/LA4D3fd152IJ
      *-----------------------------------------------------------------------------
      DECLARE INTEGER GetCommandLine IN kernel32
      DECLARE INTEGER GlobalSize IN kernel32 INTEGER HMEM
      DECLARE RtlMoveMemory IN kernel32 AS CopyMemory STRING @Destination, INTEGER SOURCE, INTEGER nLength

      LOCAL lnAddress, lnBufsize, lsBuffer
      lnAddress = GetCommandLine()  && returns an address in memory
      lnBufsize = GlobalSize(lnAddress)

      * allocating and filling a buffer
      IF lnBufsize <> 0
         lsBuffer = REPLICATE(CHR(0), lnBufsize)
         = CopyMemory(@lsBuffer, lnAddress, lnBufsize)
      ENDIF

      lsBuffer    = STRTRAN(lsBuffer, '"'+CHR(0), '"'+CHR(13)+CHR(10))
      lsBuffer    = STRTRAN(lsBuffer, '" ', '"'+CHR(13)+CHR(10), 1, 1)
      lsBuffer    = STRTRAN(lsBuffer, CHR(0), ' ')
      tnPCount    = ALINES( taParams, lsBuffer, 4 )

      IF tnPCount > 1 THEN
         ADEL( taParams, 1 )
         tnPCount = tnPCount - 1
         DIMENSION taParams(tnPCount)
      ENDIF

      RETURN
   ENDPROC



   PROCEDURE renameFile
      LPARAMETERS tcFileName, tcEXE_CAPS, toFSO AS Scripting.FileSystemObject, tlRelanzarError

      LOCAL lcLog, laFile(1,5) ;
          , loLang AS CL_LANG OF 'cl_lang.prg'

      loLang  = _SCREEN.o_FoxBin2Prg_Lang

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         lcLog   = ''
         .o_FNC.Capitalize( tcFileName, '', 'F', @lcLog, tlRelanzarError, '1' )

         IF .getCfgValue('n_Debug') >= 2 THEN
            lcLog   = SUBSTR(lcLog,3)
            .writeLog()
            .writeLog( C_TAB + TEXTMERGE(loLang.C_REQUESTING_CAPITALIZATION_OF_FILE_LOC) )
            .writeLog( lcLog )
         ENDIF
      ENDWITH
   ENDPROC



   PROCEDURE renameTmpFile2Tx2File
      LPARAMETERS tcFileName
      This.ensureFileUtils()
      RETURN This.o_FileUtils.renameTmpFile2Tx2File(tcFileName)
   ENDPROC


   FUNCTION isExportUTF8
      RETURN This.getCfgFlag('l_ExportUTF8')
   ENDFUNC


   FUNCTION encodeTextForExport
      *---------------------------------------------------------------------------------------------------
      * Converts ANSI text (current code page) to UTF-8 bytes when ExportUTF8 is enabled.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcText
      IF This.isExportUTF8()
         RETURN StrConv(tcText, 9)
      ENDIF
      RETURN tcText
   ENDFUNC


   FUNCTION decodeTextFromImport
      *---------------------------------------------------------------------------------------------------
      * Converts UTF-8 file bytes to ANSI (current code page) when ExportUTF8 is enabled.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcText
      IF This.isExportUTF8()
         RETURN StrConv(tcText, 11)
      ENDIF
      RETURN tcText
   ENDFUNC


   FUNCTION readTextFile
      *---------------------------------------------------------------------------------------------------
      * Reads a text representation file (VC2, SC2, PJ2, DB2, etc.) honoring ExportUTF8.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile
      RETURN This.decodeTextFromImport(FileToStr(tcFile))
   ENDFUNC


   FUNCTION writeTextFile
      *---------------------------------------------------------------------------------------------------
      * Writes a text representation file honoring ExportUTF8.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcText, tcFile
      RETURN StrToFile(This.encodeTextForExport(tcText), tcFile)
   ENDFUNC


   FUNCTION finalizeTextExportFile
      *---------------------------------------------------------------------------------------------------
      * Converts an ANSI text file (e.g. written via Scripting.TextStream) to UTF-8 in place.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile
      LOCAL lcText, lnBytes
      IF NOT This.isExportUTF8()
         RETURN .T.
      ENDIF
      lcText  = FileToStr(tcFile)
      lnBytes = StrToFile(StrConv(lcText, 9), tcFile)
      RETURN (lnBytes > 0)
   ENDFUNC


   FUNCTION comparedTextExportFilesEqual
      *---------------------------------------------------------------------------------------------------
      * Compares a new ANSI temp file with an existing export file (ANSI or UTF-8).
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcNewAnsiFile, tcExistingFile
      RETURN (FileToStr(tcNewAnsiFile) == This.readTextFile(tcExistingFile))
   ENDFUNC



   PROCEDURE set_Line
      LPARAMETERS tcLine, taCodeLines, I
      EXTERNAL ARRAY taCodeLines

      tcLine  = LTRIM( taCodeLines(m.I), 0, CHR(9), ' ' )
   ENDPROC


   PROCEDURE errOut
      LPARAMETERS tcTexto
      This.ensureFileUtils()
      RETURN This.o_FileUtils.errOut(tcTexto)
   ENDPROC


   PROCEDURE stdOut
      LPARAMETERS tcTexto
      This.ensureFileUtils()
      RETURN This.o_FileUtils.stdOut(tcTexto)
   ENDPROC


   PROCEDURE updateProcessedFile
      *---------------------------------------------------------------------------------------------------
      * UPDATES SOME DATA OF THE CURRENT PROCESSED FILE
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tnID                      (v? IN    ) ID of the file to update. If omitted, the current one is assumed.
      * tcInOutType               (v? IN    ) Input or output file ("I"=Input file, "O"=Output file)
      * tcProcessed               (v? IN    ) Processed ("P0"=Not Processed, "P1"=Processed)
      * tcHasErrors               (v? IN    ) Had errors ("E0"=No Errors, "E1"=Has Errors)
      * tcSupported               (v? IN    ) Supported file ("S0"=Unsupported, "S1"=Supported)
      * tcExpanded                (v? IN    ) File type ("X0"=Normal file, "X1"=Expanded multipart file)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tnID, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded

      TRY
         LOCAL loEx AS EXCEPTION

         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            IF .n_ProcessedFiles = 0 THEN
               EXIT
            ENDIF
            tnID    = EVL(tnID, .n_ProcessedFiles)
            IF NOT EMPTY(tcInOutType)
               .a_ProcessedFiles(tnID, 2)  = EVL(tcProcessed, '')
            ENDIF
            IF NOT EMPTY(tcProcessed)
               .a_ProcessedFiles(tnID, 3)  = EVL(tcProcessed, '')
            ENDIF
            IF NOT EMPTY(tcHasErrors)
               .a_ProcessedFiles(tnID, 4)  = EVL(tcHasErrors, '')
            ENDIF
            IF NOT EMPTY(tcSupported)
               .a_ProcessedFiles(tnID, 5)  = EVL(tcSupported, '')
            ENDIF
            .stdOut( .a_ProcessedFiles(tnID,2) ;
               + ',' + .a_ProcessedFiles(tnID,3) ;
               + ',' + .a_ProcessedFiles(tnID,4) ;
               + ',' + .a_ProcessedFiles(tnID,5) ;
               + ',' + .a_ProcessedFiles(tnID,6) ;
               + ',' + LOWER(.a_ProcessedFiles(tnID,1)) )
         ENDWITH

      CATCH TO loEx
         IF This.getCfgValue('n_Debug') > 0 THEN
            IF _VFP.STARTMODE = 0
               SET STEP ON
            ENDIF
         ENDIF
         THROW

      ENDTRY
   ENDPROC


   PROCEDURE writeErrorLog
      LPARAMETERS tcText, tnTimeStamp

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            *-- According to nTimestamp value:
            *-- 0 = No timestamp
            *-- 1 = Timestamp prefix
            *-- 2 = Timestamp suffix
            .c_TextErr  = .c_TextErr ;
               + IIF( EVL(tnTimeStamp,0) = 1, TTOC(DATETIME(),3) + '  ', '' ) ;
               + EVL(tcText,'') ;
               + IIF( EVL(tnTimeStamp,0) = 2, '  ' + TTOC(DATETIME(),3), '' ) ;
               + CR_LF

            .errOut(tcText)
            .l_Error    = .T.
            .l_Errors   = .T.
         ENDWITH
      CATCH
      ENDTRY
   ENDPROC


   PROCEDURE writeErrorLog_Flush
      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         IF NOT EMPTY(.c_TextErr)
            STRTOFILE( .c_TextErr + CR_LF, .c_ErrorLogFile, 1 )
         ENDIF
         .c_TextErr  = ''
      ENDWITH
   ENDPROC



   PROCEDURE writeLog
      LPARAMETERS tcText, tnTimeStamp

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            *-- According to nTimestamp value:
            *-- 0 = No timestamp
            *-- 1 = Timestamp prefix
            *-- 2 = Timestamp suffix
            .c_TextLog  = .c_TextLog ;
               + IIF( EVL(tnTimeStamp,0) = 1, TTOC(DATETIME(),3) + '  ', '' ) ;
               + EVL(tcText,'') ;
               + IIF( EVL(tnTimeStamp,0) = 2, '  ' + TTOC(DATETIME(),3), '' ) ;
               + CR_LF
         ENDWITH
      CATCH
      ENDTRY
   ENDPROC


   PROCEDURE writeLog_Flush
      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         IF .getCfgValue('n_Debug') > 0 AND NOT EMPTY(.c_TextLog)
            STRTOFILE( .c_TextLog + CR_LF, .c_LogFile, 1 )
         ENDIF
         .c_TextLog  = ''
      ENDWITH
   ENDPROC



   HIDDEN PROCEDURE exception2Str
      LPARAMETERS toEx AS EXCEPTION
      LOCAL lcError
      lcError     = 'Error ' + TRANSFORM(toEx.ERRORNO) + ', ' + toEx.MESSAGE + CR_LF ;
         + toEx.PROCEDURE + ', ' + TRANSFORM(toEx.LINENO) + CR_LF

      IF NOT EMPTY(toEx.LINECONTENTS) AND toEx.ERRORNO <> 1098
         lcError = lcError + toEx.LINECONTENTS + CR_LF
      ENDIF

      IF NOT EMPTY(toEx.USERVALUE)
         lcError = lcError + EVL(toEx.USERVALUE,'')
      ENDIF

      RETURN lcError
   ENDPROC


   PROCEDURE unique_ID
      LPARAMETERS tcValType

      tcValType   = EVL(tcValType,'C')
      This.n_ID   = INT( This.n_ID + 1 )

      IF tcValType = 'N'
         RETURN This.n_ID
      ELSE
         RETURN '_' + TRANSFORM( This.n_ID, '@L #########' )
      ENDIF
   ENDPROC


   FUNCTION wscriptshell_run
      LPARAMETERS tcCmdLine, tnWindowStyle, tbWaitOnReturn, tlDebug
      This.ensureFileUtils()
      RETURN This.o_FileUtils.wscriptshell_run(tcCmdLine, tnWindowStyle, tbWaitOnReturn, tlDebug)
   ENDFUNC


   FUNCTION FERROR_Message(tcFileName AS STRING)
      LPARAMETERS tcFileName
      This.ensureFileUtils()
      RETURN This.o_FileUtils.FERROR_Message(tcFileName)
   ENDFUNC


   FUNCTION getLocaleInfo
      LPARAMETERS tnSetting, tcLocale
      This.ensureFileUtils()
      RETURN This.o_FileUtils.getLocaleInfo(tnSetting, tcLocale)
   ENDFUNC

ENDDEFINE
