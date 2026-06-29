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
      + [<memberdata name="clearconfigurationcache" display="clearConfigurationCache"/>] ;
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
   o_SplitPaths                    = .NULL.        && cl_fb2prg_split_paths (split text path layout)
   o_Cfg                           = .NULL.        && cl_fb2prg_cfg (configuration manager)
   o_ConversionFactory             = .NULL.        && cl_fb2prg_conversion_factory (converter routing)
   o_Logger                        = .NULL.        && cl_fb2prg_logger (session debug/error log)
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
      *---------------------------------------------------------------------------------------------------
      * Session startup: VFP environment, log paths, language, o_FSO, o_Cfg, helper objects.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcCFG_File                 (v? IN    ) Optional legacy CFG path; default: same stem as FoxBin2Prg
      * tcCancelWithEscKey         (v? IN    ) '1' enables ESC cancel (This.l_CancelWithEscKey)
      *---------------------------------------------------------------------------------------------------

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
      RELEASE lcSys16, lnPosProg, lc_Foxbin2prg_EXE, laValues
      RETURN
   ENDPROC


   PROCEDURE DESTROY
      *---------------------------------------------------------------------------------------------------
      * Session teardown: flush logs, release forms and helper objects, clear DLL declarations.
      *---------------------------------------------------------------------------------------------------

      TRY
         LOCAL lcFileCDX
         lcFileCDX   = FORCEPATH( "TABLABIN.CDX", JUSTPATH(This.c_InputFile) )

         ERASE ( lcFileCDX )

         DIMENSION This.a_ProcessedFiles(1, 6)
         This.a_ProcessedFiles = .NULL.

         This.writeLog( 'FoxBin2Prg UNLOAD  -', 2 )
         This.writeLog( REPLICATE( '*', 100 ) )
         This.writeLog( )
         This.writeLog_Flush()
         This.unloadProgressbarForm( .T. )

      CATCH

      FINALLY
         IF VARTYPE(This.c_Foxbin2prg_ConfigFile) = 'O'
            This.c_Foxbin2prg_ConfigFile = .NULL.
         ENDIF
         IF VARTYPE(This.o_Cfg) = 'O' AND !ISNULL(This.o_Cfg)
            This.o_Cfg.clearConfigurationCache()
         ENDIF
         This.o_FSO  = .NULL.
         This.o_WSH  = .NULL.
         This.o_FNC  = .NULL.
         This.o_TextStream = .NULL.
         IF VARTYPE(This.o_FileUtils) = 'O' AND !ISNULL(This.o_FileUtils)
            This.o_FileUtils.clearDll()
         ENDIF
         This.o_FileUtils = .NULL.
         This.o_Mirror = .NULL.
         This.o_SplitPaths = .NULL.
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
      *---------------------------------------------------------------------------------------------------
      * Proxy to frm_avance; raises ERROR 1799 when user cancels (unless called from form init).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcTexto                    (v? IN    ) Progress caption text
      * tnValor                    (v? IN    ) Current item index
      * tnTotal                    (v? IN    ) Total items
      * tnTipo                     (v? IN    ) Progress bar mode (frm_avance)
      *---------------------------------------------------------------------------------------------------

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
      *---------------------------------------------------------------------------------------------------
      * Instantiates CL_LANG on _SCREEN and copies localized caption strings to This.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcLanguageId               (v! IN    ) Language id: EN, ES, FR, DE
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcLanguageId
      _SCREEN.ADDPROPERTY( "o_FoxBin2Prg_Lang", NewObject("CL_LANG", "cl_lang.prg", null, tcLanguageId) )
      *-- Localized properties
      This.c_Language                 = _SCREEN.o_FoxBin2Prg_Lang.C_LANGUAGE_LOC
      This.c_loc_processing_file      = _SCREEN.o_FoxBin2Prg_Lang.C_PROCESSING_LOC
      This.c_loc_process_progress     = _SCREEN.o_FoxBin2Prg_Lang.C_PROCESS_PROGRESS_LOC
   ENDPROC


   PROCEDURE clearProcessedFiles
      *---------------------------------------------------------------------------------------------------
      * Resets a_ProcessedFiles and session error flags between execute() runs.
      *---------------------------------------------------------------------------------------------------

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


   PROCEDURE clearConfigurationCache
      *---------------------------------------------------------------------------------------------------
      * Delegates to o_Cfg.clearConfigurationCache(); drops per-directory CFG cache only.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_Cfg) = 'O' AND !ISNULL(This.o_Cfg)
         This.o_Cfg.clearConfigurationCache()
      ENDIF
   ENDPROC


   PROCEDURE ensureFileUtils
      *---------------------------------------------------------------------------------------------------
      * Lazy-init This.o_FileUtils (cl_file_utils) if missing.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_FileUtils) <> 'O' OR ISNULL(This.o_FileUtils)
         This.o_FileUtils = NewObject('cl_file_utils', 'cl_file_utils.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE ensureMirror
      *---------------------------------------------------------------------------------------------------
      * Lazy-init This.o_Mirror (cl_fb2prg_mirror) if missing.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_Mirror) <> 'O' OR ISNULL(This.o_Mirror)
         This.o_Mirror = NewObject('cl_fb2prg_mirror', 'cl_fb2prg_mirror.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE ensureSplitPaths
      *---------------------------------------------------------------------------------------------------
      * Lazy-init This.o_SplitPaths (cl_fb2prg_split_paths) if missing.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_SplitPaths) <> 'O' OR ISNULL(This.o_SplitPaths)
         This.o_SplitPaths = NewObject('cl_fb2prg_split_paths', 'cl_fb2prg_split_paths.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE ensureCfg
      *---------------------------------------------------------------------------------------------------
      * Lazy-init This.o_Cfg (cl_fb2prg_cfg) if missing.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_Cfg) <> 'O' OR ISNULL(This.o_Cfg)
         This.o_Cfg = NewObject('cl_fb2prg_cfg', 'cl_fb2prg_cfg.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE ensureSpecialProps
      *---------------------------------------------------------------------------------------------------
      * Lazy-init This.o_SpecialProps (cl_fb2prg_special_props) if missing.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_SpecialProps) <> 'O' OR ISNULL(This.o_SpecialProps)
         This.o_SpecialProps = NewObject('cl_fb2prg_special_props', 'cl_fb2prg_special_props.prg' , NULL , This.c_Foxbin2prg_FullPath )
      ENDIF
   ENDPROC

   PROCEDURE ensureConversionFactory
      *---------------------------------------------------------------------------------------------------
      * Lazy-init This.o_ConversionFactory (cl_fb2prg_conversion_factory) if missing.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_ConversionFactory) <> 'O' OR ISNULL(This.o_ConversionFactory)
         This.o_ConversionFactory = NewObject('cl_fb2prg_conversion_factory', 'cl_fb2prg_conversion_factory.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE ensureLogger
      *---------------------------------------------------------------------------------------------------
      * Lazy-init This.o_Logger (cl_fb2prg_logger) if missing.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_Logger) <> 'O' OR ISNULL(This.o_Logger)
         This.o_Logger = NewObject('cl_fb2prg_logger', 'cl_fb2prg_logger.prg', NULL, This)
      ENDIF
   ENDPROC

   PROCEDURE declareDLL
      *---------------------------------------------------------------------------------------------------
      * Declares Win32 DLLs used by file operations; delegates to o_FileUtils.
      *---------------------------------------------------------------------------------------------------

      This.ensureFileUtils()
      This.o_FileUtils.declareDLL()
   ENDPROC

   PROCEDURE get_AbsolutePath
      *---------------------------------------------------------------------------------------------------
      * Resolves a relative path against an optional base directory.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (v? IN    ) Path to resolve
      * tc_FullPath                (v? IN    ) Base directory; default from o_FileUtils / c_Foxbin2prg_FullPath
      * RETURN                    (v?    OUT) Absolute path string
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, tc_FullPath
      This.ensureFileUtils()
      RETURN This.o_FileUtils.get_AbsolutePath(tc_InputFile, tc_FullPath)
   ENDPROC


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
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_FileUtils.changeFileAttribute.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFileName                 (v! IN    ) Target file
      * tcAttrib                   (v! IN    ) VFP SET ATTRIBUTES string (e.g. '+R', '-H')
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcFileName, tcAttrib
      This.ensureFileUtils()
      RETURN This.o_FileUtils.changeFileAttribute(tcFileName, tcAttrib)
   ENDPROC


   PROCEDURE changeFileTime
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_FileUtils.changeFileTime.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFileName                 (v! IN    ) Target file
      * tcTimeType                 (v? IN    ) 'C' creation | 'A' access | 'M' modification
      * tnYear … tnThou             (v? IN    ) Timestamp components
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcFileName, tcTimeType, tnYear, tnMonth, tnDay, tnHour, tnMinute, tnSec, tnThou
      This.ensureFileUtils()
      RETURN This.o_FileUtils.changeFileTime(tcFileName, tcTimeType, tnYear, tnMonth, tnDay, tnHour, tnMinute, tnSec, tnThou)
   ENDPROC


   PROCEDURE compileFoxProBinary
      *---------------------------------------------------------------------------------------------------
      * COMPILE CLASSLIB/FORM/REPORT/LABEL/DATABASE for regenerated binary output.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFileName                 (v? IN    ) Binary path; default This.c_OutputFile
      *---------------------------------------------------------------------------------------------------

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
      This.ensureFileUtils()
      This.o_FileUtils.doBackup( @toEx, tlRelanzarError, @tcBakFile_1, @tcBakFile_2, @tcBakFile_3, tcOutputFile )
   ENDPROC


   PROCEDURE loadProgressbarForm
      *---------------------------------------------------------------------------------------------------
      * Creates and shows frm_avance when not already loaded.
      *---------------------------------------------------------------------------------------------------

      IF VARTYPE(This.o_Frm_Avance) <> "O" THEN
         This.o_Frm_Avance   = NewObject( "frm_avance" , "frm_avance.prg" , null , This )
         This.o_Frm_Avance.SHOW()
      ENDIF
   ENDPROC


   PROCEDURE unloadProgressbarForm
      *---------------------------------------------------------------------------------------------------
      * Hides and releases frm_avance when progress bar is enabled or tlForceUnload is .T.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tlForceUnload              (v? IN    ) When .T., unloads even if n_ShowProgressbar = 0
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tlForceUnload
      IF (tlForceUnload OR This.getCfgValue('n_ShowProgressbar') <> 0) AND VARTYPE(This.o_Frm_Avance) = "O" THEN
         This.o_Frm_Avance.HIDE()
         This.o_Frm_Avance.RELEASE()
         This.o_Frm_Avance = .NULL.
      ENDIF
   ENDPROC


   FUNCTION comparedFilesAreEqual
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_FileUtils.comparedFilesAreEqual (binary or string content comparison).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFilename1                (v? IN    ) First file path (or empty when tcStrFileName2 is used)
      * tcFilename2                (v? IN    ) Second file path
      * tcStrFileName2             (v? IN    ) In-memory string to compare against tcFilename1
      * RETURN                    (v?    OUT) .T. when contents are equal
      *---------------------------------------------------------------------------------------------------
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


   PROCEDURE writeLogDbfCfgSettings
      *---------------------------------------------------------------------------------------------------
      * Writes DBF-related CFG properties to the session log when tlGenerateLog is .T.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tlGenerateLog              (v? IN    ) Whether to emit the DBF CFG block
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tlGenerateLog AS Boolean

      LOCAL lcOrder, lcCond, lcIdxList

      IF !tlGenerateLog
         RETURN
      ENDIF

      lcOrder   = EVL( This.getCfgValue('c_DBF_Conversion_Order'), '' )
      lcCond    = EVL( This.getCfgValue('c_DBF_Conversion_Condition'), '' )
      lcIdxList = EVL( This.getCfgValue('c_DBF_IndexList'), '' )

      This.writeLog(' > DBF configuration from session loCfg')
      This.writeLog('     DBF_Conversion_Support: ' + TRANSFORM(This.getCfgValue('n_DBF_Conversion_Support')))

      IF !EMPTY(lcOrder)
         This.writeLog('     DBF_Conversion_Order: ' + lcOrder)
      ENDIF

      IF !EMPTY(lcCond)
         This.writeLog('     DBF_Conversion_Condition: ' + lcCond)
      ENDIF

      IF !EMPTY(lcIdxList)
         This.writeLog('     DBF_IndexList: ' + lcIdxList)
      ENDIF
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
      * Wrapper -> o_SplitPaths.resolvePj2TextMemberPath (PJ2 import text path resolution).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinFile                 (v! IN    ) PJ2 member path (.vcx, .scx, .dbc, ...)
      * RETURN                    (v?    OUT) Text file path to pass to convert()
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinFile
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.resolvePj2TextMemberPath(tcBinFile)
   ENDPROC
   FUNCTION isPj2TextMemberAvailable
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.isPj2TextMemberAvailable.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinFile                 (v! IN    ) PJ2 member path (.vcx, .scx, .dbc, ...)
      * RETURN                    (v?    OUT) .T. when import can proceed
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinFile
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.isPj2TextMemberAvailable(tcBinFile)
   ENDFUNC
   PROCEDURE hasSupport_Bin2Prg(tcFileName AS STRING, tcDir AS STRING) AS Boolean
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFilename                (@! IN    ) Extension to check whether the file has conversion support
      * tcDir                     (@? IN    ) Directory whose configuration should be returned
      * RETURN                    (v?    OUT) .T. if conversion is supported, .F. if not
      *---------------------------------------------------------------------------------------------------
      LOCAL llhasSupport, lcExt

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         lcExt       = UPPER(JUSTEXT('.' + tcFileName))

         llhasSupport    = .getCfgValue('l_AllowFolder') AND ICASE( lcExt == 'PJX', .getCfgValue('n_PJX_Conversion_Support') > 0 ;
            , lcExt == 'VCX', .getCfgValue('n_VCX_Conversion_Support') > 0 ;
            , lcExt == 'SCX', .getCfgValue('n_SCX_Conversion_Support') > 0 ;
            , lcExt == 'FRX', .getCfgValue('n_FRX_Conversion_Support') > 0 ;
            , lcExt == 'LBX', .getCfgValue('n_LBX_Conversion_Support') > 0 ;
            , lcExt == 'MNX', .getCfgValue('n_MNX_Conversion_Support') > 0 ;
            , lcExt == 'DBC', .getCfgValue('n_DBC_Conversion_Support') > 0 ;
            , lcExt == 'DBF', .getCfgValue('n_DBF_Conversion_Support') > 0 ;
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
      LOCAL llhasSupport, lcExt

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         lcExt       = UPPER(JUSTEXT('.' + tcFileName))

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
            , lcExt == .getCfgValue('c_DB2'), INLIST(.getCfgValue('n_DBF_Conversion_Support'), 2, 8) ;
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
      LOCAL lnSupportType, lcExt

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         lcExt       = UPPER(JUSTEXT('.' + tcFileName))

         IF tlGenerarLog AND INLIST(lcExt, .getCfgValue('c_DB2'), 'DBF')
            .writeLogDbfCfgSettings(.T.)
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
            , INLIST(lcExt, .getCfgValue('c_DB2'), 'DBF'), .getCfgValue('n_DBF_Conversion_Support') ;
            , INLIST(lcExt, .getCfgValue('c_DC2'), 'DBC'), .getCfgValue('n_DBC_Conversion_Support') ;
            , 0 )

         lnSupportType   = INT(lnSupportType)
      ENDWITH && THIS

      RETURN lnSupportType
   ENDPROC


   *==============================================================================================================
   * execute() helpers — session, context, dispatch (SRP decomposition)
   *==============================================================================================================

   PROTECTED FUNCTION isBinToTextMode
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

   PROTECTED FUNCTION isTextToBinMode
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

   PROTECTED PROCEDURE restoreEscapeKey
      *---------------------------------------------------------------------------------------------------
      * Restores ON ESCAPE / SET ESCAPE after execute() when ESC cancel was enabled.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * llEscKeyRestored           (v! IN    ) .T. if ESC was never overridden
      * lcOldSetEscape             (v? IN    ) Previous SET('Escape') value
      * lcOldOnEscape              (v? IN    ) Previous ON ESCAPE expression
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS llEscKeyRestored, lcOldSetEscape, lcOldOnEscape
      IF NOT llEscKeyRestored AND This.l_CancelWithEscKey THEN
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

   PROTECTED FUNCTION mergeExecuteConfig
      *---------------------------------------------------------------------------------------------------
      * Applies optional toCfg to session CFG via o_Cfg.lockMasterFromObject.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toCfg                      (v? IN    ) CFG object (newConfig) or duck-typed source
      * RETURN                    (v?    OUT) Effective CFG object passed to execute(), or .NULL.
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS toCfg
      LOCAL loCFG
      loCFG = .NULL.
      This.ensureCfg()
      IF VARTYPE(toCfg) = "O" AND !ISNULL(toCfg)
         IF This.isCfg( toCfg )
            loCFG = toCfg
         ELSE
            loCFG = This.configFromObject( toCfg )
         ENDIF
         This.o_Cfg.lockMasterFromObject( loCFG )
      ENDIF
      RETURN loCFG
   ENDFUNC

   PROTECTED PROCEDURE beginExecuteSession
      *---------------------------------------------------------------------------------------------------
      * execute() setup: NOTIFY OFF, DLL declare, ESC handler, clear processed files.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loSession                  (@! IN/OUT) Empty object; fields filled for finalizeExecuteSession
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loSession
      WITH This
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

   PROTECTED PROCEDURE validateExecuteEnvironment
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

   PROTECTED FUNCTION parseClassOperationSyntax
      *---------------------------------------------------------------------------------------------------
      * Parses file.vcx::class|I/E syntax; sets c_ClassToConvert and c_ClassOperationType.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (@! IN/OUT) Input path; normalized on return
      * RETURN                    (v?    OUT) Normalized tc_InputFile
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tc_InputFile
      IF '::' $ tc_InputFile THEN
         tc_InputFile = STRTRAN(tc_InputFile, '::', '|')
         This.c_ClassOperationType = Evl( Upper( Left( Alltrim( GetWordNum( tc_InputFile, 3, '|' ) ), 1) ), 'E')
         This.c_ClassToConvert     = Lower( Alltrim( GetWordNum( tc_InputFile, 2, '|' ) ) )
         tc_InputFile = Lower( Alltrim( GetWordNum( tc_InputFile, 1, '|' ) ) )
      ELSE
         This.c_ClassOperationType = ''
      ENDIF
      RETURN tc_InputFile
   ENDFUNC

   PROTECTED FUNCTION detectInputFileType
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

   PROTECTED FUNCTION resolveRecompileTarget
      *---------------------------------------------------------------------------------------------------
      * Derives tcRecompile and This.c_Recompile from input type and CFG l_Recompile.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (v? IN    ) Input path
      * lcInputFile_Type           (v? IN    ) C_FILETYPE_* from detectInputFileType
      * tcRecompile                (v? IN/OUT) Recompile flag or directory
      * RETURN                    (v?    OUT) Effective tcRecompile string
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tc_InputFile, lcInputFile_Type, tcRecompile
      IF EMPTY(tcRecompile) AND NOT EMPTY(lcInputFile_Type)
         IF lcInputFile_Type == C_FILETYPE_DIRECTORY
            tcRecompile = tc_InputFile
         ELSE
            tcRecompile = JUSTPATH( tc_InputFile )
         ENDIF
      ENDIF
      IF This.getCfgFlag('l_Recompile', .T.)
         tcRecompile = EVL(tcRecompile, '1')
      ELSE
         tcRecompile = '0'
      ENDIF
      This.c_Recompile = tcRecompile
      RETURN tcRecompile
   ENDFUNC

   PROTECTED PROCEDURE logExecuteParameters
      *---------------------------------------------------------------------------------------------------
      * Writes execute() external parameters block to session debug log.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile               (v? IN    ) Input file/directory
      * lcType                     (v? IN    ) Normalized tcType
      * toCfg                      (v? IN    ) Optional CFG object
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tc_InputFile, lcType, toCfg
      LOCAL loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      WITH This
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
   PROTECTED FUNCTION rewritePerObjectInputPath
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.rewritePerObjectInputPath (Import / RedirectClassType = 2).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Original input path
      * tcType                    (v? IN    ) execute() type
      * lcExt                     (v! IN    ) Upper extension (VCX, SCX, c_VC2, …)
      * RETURN                    (v?    OUT) Resolved input path for convert()
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, tcType, lcExt
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.rewritePerObjectInputPath(tc_InputFile, tcType, lcExt)
   ENDFUNC
   PROTECTED FUNCTION buildExecuteContext
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

   PROTECTED FUNCTION resolveExecuteMode
      *---------------------------------------------------------------------------------------------------
      * Maps input path, type and support flags to C_EXEC_* dispatch constant.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcType                     (v? IN    ) execute() type
      * tc_InputFile               (v? IN    ) Input path
      * lcInputFile_Type           (v? IN    ) C_FILETYPE_*
      * RETURN                    (v?    OUT) C_EXEC_* mode constant
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcType, tc_InputFile, lcInputFile_Type
      LOCAL laDirInfo(1,5)
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
      IF UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == This.getCfgValue('c_PJ2') AND LEFT(EVL(tcType,'0'),1) == '*'
         RETURN C_EXEC_PROJECT_PJ2
      ENDIF
      IF This.isBinToTextMode(tcType) ;
            AND ( NOT This.hasSupport_Bin2Prg( tc_InputFile ) OR NOT ADIR(laDirInfo, tc_InputFile) > 0 )
         RETURN C_EXEC_UNSUPPORTED_BIN2PRG
      ENDIF
      IF This.isTextToBinMode(tcType) ;
            AND ( NOT This.hasSupport_Prg2Bin( tc_InputFile ) OR NOT ADIR(laDirInfo, tc_InputFile) > 0 )
         RETURN C_EXEC_UNSUPPORTED_PRG2BIN
      ENDIF
      RETURN C_EXEC_SINGLE_FILE
   ENDFUNC

   PROTECTED PROCEDURE prepareBatchLog
      *---------------------------------------------------------------------------------------------------
      * Sets This.c_LogFile for directory/wildcard batch and optionally erases prior log.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcLogPath                  (v! IN    ) Full path of batch .LOG file
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcLogPath
      This.c_LogFile = tcLogPath
      IF This.getCfgValue('n_Debug') > 0 THEN
         ERASE ( This.c_LogFile )
      ENDIF
   ENDPROC

   PROTECTED PROCEDURE setRecompileDirectory
      *---------------------------------------------------------------------------------------------------
      * CD to recompile base directory according to tcRecompile and CFG l_Recompile.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcRecompile                (v? IN    ) '1', directory path, or '0'
      * tcDefaultPath              (v! IN    ) Default directory when tcRecompile = '1'
      * tlUseRecompileCfg          (v? IN    ) .T. for directory batch (honor CFG path rules)
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcRecompile, tcDefaultPath, tlUseRecompileCfg
      DO CASE
      CASE This.getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
         CD (tcRecompile)
      CASE tlUseRecompileCfg AND This.getCfgValue('l_Recompile')
         CD (tcDefaultPath)
      CASE tcRecompile == '1'
         CD (tcDefaultPath)
      ENDCASE
   ENDPROC

   PROTECTED FUNCTION handleConvertResult
      *---------------------------------------------------------------------------------------------------
      * Central convert() error handling for batch modes; may accumulate errors without abort.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lnCodError                 (v! IN    ) convert() return code
      * toEx                       (@? IN    ) Exception object
      * tlAccumulateError          (v? IN    ) .T. = set batch error flag instead of aborting
      * RETURN                    (v?    OUT) .T. when batch should mark l_Error
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS lnCodError, toEx, tlAccumulateError
      LOCAL llBatchError
      llBatchError = .F.
      DO CASE
      CASE lnCodError = 1799
         ERROR 1799
      CASE lnCodError > 0
         This.doWriteErrorLog( @toEx )
         IF tlAccumulateError
            llBatchError = .T.
            This.l_Error = .F.
         ENDIF
      ENDCASE
      RETURN llBatchError
   ENDFUNC

   PROTECTED FUNCTION runConvertWithProgress
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
      LOCAL lnCodError, loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      This.updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', tnIndex, tnTotal, 0 )
      lnCodError = This.convert( lcFile, @toModulo, @toEx, tlRelanzarError, tcOriginalFileName )
      IF tlFlushLog
         This.writeLog_Flush()
      ENDIF
      RETURN lnCodError
   ENDFUNC

   PROTECTED PROCEDURE setupDirectionProgressUI
      *---------------------------------------------------------------------------------------------------
      * Logs BIN2PRG/PRG2BIN option and loads progress form with direction caption.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tlBinToText                (v! IN    ) .T. = Bin?Txt batch
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tlBinToText
      LOCAL loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      IF tlBinToText
         This.writeLog( '> ' + loLang.C_OPTION_LOC + ': BIN2PRG' )
      ELSE
         This.writeLog( '> ' + loLang.C_OPTION_LOC + ': PRG2BIN' )
      ENDIF
      IF This.getCfgValue('n_ShowProgressbar') <> 0 AND This.l_ProcessFiles THEN
         This.loadProgressbarForm()
         IF tlBinToText
            This.o_Frm_Avance.CAPTION = STRTRAN( This.o_Frm_Avance.CAPTION, '> -', '(Bin>Txt) -' )
         ELSE
            This.o_Frm_Avance.CAPTION = STRTRAN( This.o_Frm_Avance.CAPTION, '> -', '(Txt>Bin) -' )
         ENDIF
      ENDIF
   ENDPROC

   PROTECTED FUNCTION executeEmptyUI
      *---------------------------------------------------------------------------------------------------
      * Shows frm_main configuration reference when execute() receives empty input.
      * RETURN                    (v?    OUT) 0
      *---------------------------------------------------------------------------------------------------

      LOCAL loFrm_Main AS frm_main OF 'frm_main.PRG'
      loFrm_Main = NewObject( 'frm_main', 'frm_main.prg' , null, This)
      loFrm_Main.SHOW()
      READ EVENTS
      RETURN 0
   ENDFUNC

   PROTECTED FUNCTION executeBin3Prg
      *---------------------------------------------------------------------------------------------------
      * Bin3Prg handler: validates PJX + mirror root, delegates to exportProjectTree.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Context from buildExecuteContext
      * RETURN                    (v?    OUT) execute() return code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx
      LOCAL lcMirrorRoot, loLang AS CL_LANG OF 'cl_lang.prg', loCfgPass
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lcMirrorRoot = EVL(This.cOutputFolder, loCtx.tcTextName)
      IF NOT EMPTY(lcMirrorRoot)
         lcMirrorRoot = This.get_AbsolutePath(lcMirrorRoot, This.c_CurDir)
      ENDIF
      IF EMPTY(lcMirrorRoot)
         ERROR loLang.C_INVALID_PARAMETER_LOC + ': Bin3Prg requires tcTextName or tcOutputFolder'
      ENDIF
      IF UPPER(JUSTEXT(loCtx.tc_InputFile)) <> 'PJX'
         ERROR loLang.C_INVALID_PARAMETER_LOC + ': Bin3Prg requires a .PJX project file'
      ENDIF
      loCfgPass = IIF(VARTYPE(loCtx.loCFG) = 'O' AND !ISNULL(loCtx.loCFG), loCtx.loCFG, .NULL.)
      RETURN This.exportProjectTree(loCtx.tc_InputFile, lcMirrorRoot, loCfgPass)
   ENDFUNC

   PROTECTED FUNCTION executePrg3Bin
      *---------------------------------------------------------------------------------------------------
      * Prg3Bin handler: validates PJ2 + mirror root, delegates to importProjectTree.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Context from buildExecuteContext
      * RETURN                    (v?    OUT) execute() return code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx
      LOCAL lcMirrorRoot, loLang AS CL_LANG OF 'cl_lang.prg', loCfgPass
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lcMirrorRoot = EVL(This.cOutputFolder, loCtx.tcTextName)
      IF NOT EMPTY(lcMirrorRoot)
         lcMirrorRoot = This.get_AbsolutePath(lcMirrorRoot, This.c_CurDir)
      ENDIF
      IF EMPTY(lcMirrorRoot)
         ERROR loLang.C_INVALID_PARAMETER_LOC + ': Prg3Bin requires tcTextName or tcOutputFolder'
      ENDIF
      IF UPPER(JUSTEXT(loCtx.tc_InputFile)) <> UPPER(This.getCfgValue('c_PJ2'))
         ERROR loLang.C_INVALID_PARAMETER_LOC + ': Prg3Bin requires a .' + This.getCfgValue('c_PJ2') + ' project file'
      ENDIF
      loCfgPass = IIF(VARTYPE(loCtx.loCFG) = 'O' AND !ISNULL(loCtx.loCFG), loCtx.loCFG, .NULL.)
      RETURN This.importProjectTree(loCtx.tc_InputFile, lcMirrorRoot, loCfgPass)
   ENDFUNC

   PROTECTED FUNCTION executeWildcardBatch
      *---------------------------------------------------------------------------------------------------
      * Processes a wildcard file specification (ADIR loop) including optional full PJX/PJ2.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Execute context
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * RETURN                    (v?    OUT) Last convert() error code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx, toEx, toModulo
      LOCAL I, lcFileSpec, lcFile, lnFileCount, lnCodError, llError, laFiles(1,5), loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lnCodError = 0
      llError = .F.
      lcFileSpec = FULLPATH( loCtx.tc_InputFile )
      This.prepareBatchLog( ADDBS( JUSTPATH( lcFileSpec ) ) + STRTRAN( JUSTFNAME( lcFileSpec ), '*', '_ALL' ) + '.LOG' )
      IF EVL(loCtx.tcType,'0') <> '*' THEN
         IF This.getCfgValue('n_ShowProgressbar') <> 0 AND This.l_ProcessFiles THEN
            This.loadProgressbarForm()
         ENDIF
         This.setRecompileDirectory( loCtx.tcRecompile, JUSTPATH(lcFileSpec), .F. )
      ENDIF
      lnFileCount = ADIR( laFiles, lcFileSpec, '', 1 )
      FOR I = 1 TO lnFileCount
         toModulo = .NULL.
         lcFile = FORCEPATH( laFiles(m.I,1), JUSTPATH( lcFileSpec ) )
         DO CASE
         CASE UPPER( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) ) == 'PJX' AND LEFT(EVL(loCtx.tcType,'0'),1) == '*'
            This.evaluate_Full_PJX(lcFile, loCtx.tcRecompile, @toModulo, @toEx, loCtx.tcOriginalFileName, This.c_LogFile, loCtx.tcType)
         CASE UPPER( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) ) == This.getCfgValue('c_PJ2') AND LEFT(EVL(loCtx.tcType,'0'),1) == '*'
            This.evaluate_Full_PJ2(lcFile, loCtx.tcRecompile, @toModulo, @toEx, loCtx.tcOriginalFileName, This.c_LogFile, loCtx.tcType)
         CASE loCtx.lBinToText
            IF This.hasSupport_Bin2Prg(lcFile) THEN
               lnCodError = This.runConvertWithProgress( lcFile, m.I, lnFileCount, .F., loCtx.tcOriginalFileName, @toModulo, @toEx, .T. )
               llError = llError OR This.handleConvertResult( lnCodError, @toEx, .T. )
            ENDIF
         CASE loCtx.lTextToBin
            IF This.hasSupport_Prg2Bin(lcFile) THEN
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
         This.l_Error = .T.
      ENDIF
      RETURN lnCodError
   ENDFUNC

   PROTECTED FUNCTION executeDirectoryBatch
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
      LOCAL I, lcFile, lnFileCount, lnCodError, laFiles(1,5), laDirInfo(1,5), loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lnCodError = 0
      This.setupDirectionProgressUI( tlBinToText )
      This.writeLog( '> InputFile ' + loLang.C_IS_A_DIRECTORY_LOC )
      This.writeLog()
      This.setRecompileDirectory( loCtx.tcRecompile, loCtx.tc_InputFile, .T. )
      This.prepareBatchLog( ADDBS(loCtx.tc_InputFile) + loCtx.tcType + '.LOG' )
      This.get_FilesFromDirectory( loCtx.tc_InputFile, @laFiles, @lnFileCount )
      FOR I = 1 TO lnFileCount
         toModulo = .NULL.
         lcFile = laFiles(m.I)
         IF tlBinToText
            IF NOT This.hasSupport_Bin2Prg( lcFile ) OR NOT ADIR(laDirInfo, lcFile) > 0
               LOOP
            ENDIF
         ELSE
            IF NOT This.hasSupport_Prg2Bin( lcFile ) OR NOT ADIR(laDirInfo, lcFile) > 0
               LOOP
            ENDIF
         ENDIF
         lnCodError = This.runConvertWithProgress( lcFile, m.I, lnFileCount, .F., loCtx.tcOriginalFileName, @toModulo, @toEx, .F. )
         This.handleConvertResult( lnCodError, @toEx, .F. )
      ENDFOR
      This.writeLog_Flush()
      This.updateProgressbar( loLang.C_END_OF_PROCESS_LOC, lnFileCount, lnFileCount, 0 )
      RETURN lnCodError
   ENDFUNC

   PROTECTED FUNCTION executeSingleProject
      *---------------------------------------------------------------------------------------------------
      * Converts full PJX or PJ2 project via evaluate_Full_PJX / evaluate_Full_PJ2.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Execute context
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * RETURN                    (v?    OUT) 0
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx, toEx, toModulo
      LOCAL tcOriginalFileName
      tcOriginalFileName = loCtx.tcOriginalFileName
      IF UPPER( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) ) == 'PJX' AND LEFT(EVL(loCtx.tcType,'0'),1) == '*'
         This.evaluate_Full_PJX(loCtx.tc_InputFile, loCtx.tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', loCtx.tcType)
         loCtx.tcOriginalFileName = tcOriginalFileName
         RETURN 0
      ENDIF
      IF UPPER( JUSTEXT( EVL(loCtx.tc_InputFile,'') ) ) == This.getCfgValue('c_PJ2') AND LEFT(EVL(loCtx.tcType,'0'),1) == '*'
         This.evaluate_Full_PJ2(loCtx.tc_InputFile, loCtx.tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', loCtx.tcType)
         loCtx.tcOriginalFileName = tcOriginalFileName
         RETURN 0
      ENDIF
      RETURN 0
   ENDFUNC

   PROTECTED FUNCTION executeSingleFile
      *---------------------------------------------------------------------------------------------------
      * Converts one supported file through convert().
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loCtx                      (v! IN    ) Execute context
      * toEx                       (@? IN/OUT) Exception object (pass @)
      * toModulo                   (@? IN/OUT) Converter module (tests)
      * RETURN                    (v?    OUT) convert() error code
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS loCtx, toEx, toModulo
      LOCAL laDirInfo(1,5), lnCodError, loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      lnCodError = 0
      IF loCtx.lBinToText OR loCtx.lTextToBin
         This.setupDirectionProgressUI( loCtx.lBinToText )
      ENDIF
      IF ADIR(laDirInfo, loCtx.tc_InputFile) > 0
         IF This.getCfgValue('n_ShowProgressbar') <> 0 AND This.l_ProcessFiles THEN
            This.loadProgressbarForm()
         ENDIF
         This.writeLog( '> InputFile ' + loLang.C_IS_A_FILE_LOC )
         This.writeLog()
         loCtx.tc_InputFile = LOCFILE(loCtx.tc_InputFile)
         This.setRecompileDirectory( loCtx.tcRecompile, JUSTPATH(loCtx.tc_InputFile), .F. )
         This.prepareBatchLog( loCtx.tc_InputFile + '.LOG' )
         lnCodError = This.convert( loCtx.tc_InputFile, @toModulo, @toEx, .T., loCtx.tcOriginalFileName )
      ENDIF
      RETURN lnCodError
   ENDFUNC

   PROTECTED FUNCTION executeUnsupportedInput
      *---------------------------------------------------------------------------------------------------
      * Logs unsupported input type for explicit Bin2Prg/Prg2Bin directory-less requests.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tlBinToText                (v! IN    ) .T. = unsupported Bin?Txt
      * RETURN                    (v?    OUT) 0
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tlBinToText
      LOCAL loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      IF tlBinToText
         This.setupDirectionProgressUI( .T. )
      ELSE
         This.setupDirectionProgressUI( .F. )
      ENDIF
      This.writeLog( '> InputFile ' + loLang.C_IS_A_UNSUPPORTED_LOC )
      This.writeLog()
      RETURN 0
   ENDFUNC

   PROTECTED FUNCTION dispatchExecuteMode
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
      LOCAL loLang AS CL_LANG OF 'cl_lang.prg'
      loLang = _SCREEN.o_FoxBin2Prg_Lang
      DO CASE
      CASE lnMode = C_EXEC_VFP8_WARN
         MESSAGEBOX( loLang.C_FOXBIN2PRG_JUST_VFP_9_LOC, 0+64+4096, ;
            'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_WARN_CAPTION_LOC + ' (' + This.c_Language + ')', 60000 )
         RETURN 1
      CASE lnMode = C_EXEC_BIN3PRG
         RETURN This.executeBin3Prg( loCtx )
      CASE lnMode = C_EXEC_PRG3BIN
         RETURN This.executePrg3Bin( loCtx )
      CASE lnMode = C_EXEC_EMPTY_UI
         RETURN This.executeEmptyUI()
      CASE lnMode = C_EXEC_WILDCARD_ERROR
         IF This.getCfgValue('l_ShowErrors')
            MESSAGEBOX( loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC, 0+48+4096, ;
               'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_ERROR_CAPTION_LOC, 60000 )
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

   PROTECTED PROCEDURE enrichExecuteException
      *---------------------------------------------------------------------------------------------------
      * Appends FoxBin2Prg context lines to Exception.USERVALUE before error display.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toEx                       (@! IN/OUT) Exception object
      * tcType                     (v? IN    ) execute() type
      * tc_InputFile               (v? IN    ) Input path
      * lcInputFile_Type           (v? IN    ) C_FILETYPE_*
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS toEx, tcType, tc_InputFile, lcInputFile_Type

      IF toEx.ERRORNO <> 1799
         toEx.USERVALUE = toEx.USERVALUE + 'FoxBin2Prg: [' + This.c_Foxbin2prg_FullPath + '] (EXE Version: ' + This.c_FB2PRG_EXE_Version + ')' + CR_LF
      ENDIF

      IF ATC('-SHOWMSG', ('-' + tcType)) > 0
         IF toEx.ERRORNO <> 1799
            toEx.USERVALUE = toEx.USERVALUE + 'lcInputFile_Type  = [' + TRANSFORM(lcInputFile_Type) + ']' + CR_LF
         ENDIF
         This.setCfgValue( 'l_ShowErrors', .F. )
      ENDIF

      IF toEx.ERRORNO <> 1799
         toEx.USERVALUE = toEx.USERVALUE + 'tc_InputFile = [' + TRANSFORM(tc_InputFile) + ']' + CR_LF
      ENDIF
   ENDPROC


   PROTECTED FUNCTION finalizeExecuteSession
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

      This.writeLog_Flush()
      This.unloadProgressbarForm()

      CD (JUSTPATH(This.c_CurDir))

      IF ATC('-SHOWMSG', ('-' + tcType)) > 0 ;
            OR This.getCfgValue('l_ShowErrors') AND lnCodError > 0 AND NOT ISNULL(toEx)

         This.writeErrorLog_Flush()

         DO CASE
         CASE lnCodError = 1098
            MESSAGEBOX( toEx.MESSAGE, 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
            This.wscriptshell_run( This.c_ErrorLogFile, 3 )

         CASE lnCodError = 1799
            MESSAGEBOX( loLangLocal.C_CONVERSION_CANCELLED_BY_USER_LOC + '!', 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )

         CASE This.l_Errors
            IF ADIR(laDirInfo, This.c_ErrorLogFile) > 0 THEN
               MESSAGEBOX( loLangLocal.C_END_OF_PROCESS_LOC + '! (' + loLangLocal.C_WITH_ERRORS_LOC + ')', 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
               This.wscriptshell_run( This.c_ErrorLogFile, 3 )
            ELSE
               MESSAGEBOX( loLangLocal.C_END_OF_PROCESS_LOC + '! (' + loLangLocal.C_WITH_ERRORS_LOC + ')' + CR_LF + "[Warning: Can't show Error LOG file because does not exist!]", 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
            ENDIF

         OTHERWISE
            MESSAGEBOX( loLangLocal.C_END_OF_PROCESS_LOC + '', 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )

         ENDCASE
      ENDIF

      IF EMPTY(lnCodError) AND This.l_Errors
         SET STEP ON
         lnCodError = 1098
      ENDIF

      This.clearConfigurationCache()
      IF VARTYPE(This.c_Foxbin2prg_ConfigFile) = 'O'
         This.c_Foxbin2prg_ConfigFile = FORCEEXT(This.c_Foxbin2prg_FullPath, 'CFG')
      ENDIF

      lcOldNotify = loSession.lc_OldSetNotify

      SET NOTIFY &lcOldNotify

      RETURN lnCodError
   ENDFUNC


   PROCEDURE execute
      *--------------------------------------------------------------------------------------------------------------
      * Main entry: convert one file/directory, a project batch, or show the configuration reference form.
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

         tc_InputFile     = This.get_AbsolutePath( tc_InputFile, This.c_CurDir )
         lcInputFile_Type = This.detectInputFileType( tc_InputFile )
         tcRecompile      = This.resolveRecompileTarget( tc_InputFile, lcInputFile_Type, tcRecompile )

         This.logExecuteParameters( tc_InputFile, lcType, toCfg )

         lcExt = JustExt( tc_InputFile )
         tc_InputFile = This.rewritePerObjectInputPath( tc_InputFile, tcType, lcExt )

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
         This.doWriteErrorLog( @toEx, @lcErrorInfo )

         IF This.getCfgValue('n_Debug') > 0 AND _VFP.STARTMODE = 0
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


   *==============================================================================================================
   * Project batch (evaluate_Full_PJX / evaluate_Full_PJ2) — shared setup, member loop
   *==============================================================================================================

   PROTECTED PROCEDURE setupProjectBatchEnvironment
      *---------------------------------------------------------------------------------------------------
      * Shared PJX/PJ2 batch setup: mirror root, progress bar, log file, recompile CD, direction log line.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcInputFile               (v! IN    ) Project file path (.PJX or .PJ2)
      * tcLogFile                 (v? IN    ) Log file path; empty = default next to the project
      * tcRecompile               (v? IN    ) Recompile flag or directory (same as evaluate_Full_*)
      * tlBinToText               (v! IN    ) .T. = Bin?Txt (PJX export), .F. = Txt?Bin (PJ2 import)
      * tcFileSpec                (@?    OUT) Full path of tcInputFile (pass with @ at call site)
      * loLang                    (@?    OUT) CL_LANG instance from _SCREEN (pass with @ at call site)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcInputFile, tcLogFile, tcRecompile, tlBinToText, tcFileSpec, loLang
      loLang      = _SCREEN.o_FoxBin2Prg_Lang
      tcFileSpec  = FULLPATH( tcInputFile )

      This.ensureMirror()
      This.o_Mirror.ensureInputRoot( tcFileSpec )

      IF This.getCfgValue('n_ShowProgressbar') <> 0 AND This.l_ProcessFiles THEN
         This.loadProgressbarForm()
         IF tlBinToText
            This.o_Frm_Avance.CAPTION = STRTRAN( This.o_Frm_Avance.CAPTION, '> -', '(Bin>Txt) -' )
         ELSE
            This.o_Frm_Avance.CAPTION = STRTRAN( This.o_Frm_Avance.CAPTION, '> -', '(Txt>Bin) -' )
         ENDIF
      ENDIF

      IF EMPTY(tcLogFile)
         This.c_LogFile = ADDBS( JUSTPATH( tcFileSpec ) ) + STRTRAN( JUSTFNAME( tcFileSpec ), '*', '_ALL' ) + '.LOG'
         IF This.getCfgValue('n_Debug') > 0 THEN
            ERASE ( This.c_LogFile )
         ENDIF
      ENDIF

      This.writeLog( '> ' + loLang.C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC + ': ' ;
         + IIF(tlBinToText, loLang.C_BINARY_TO_TEXT_LOC, loLang.C_TEXT_TO_BINARY_LOC) )

      DO CASE
      CASE This.getCfgValue('l_Recompile') AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
         CD (tcRecompile)
      CASE tcRecompile == '1'
         CD (JUSTPATH(tcFileSpec))
      ENDCASE
   ENDPROC


   PROTECTED PROCEDURE collectPjxMemberList
      *---------------------------------------------------------------------------------------------------
      * Builds the member list from a PJX table (TABLABIN): col 1 = absolute path, col 2 = EXCLUDE flag.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcInputFile               (v! IN    ) PJX file path
      * tcFileSpec                (v! IN    ) Full path of the project (parent for relative NAME fields)
      * taMembers                 (@?    OUT) 2-column array: path, EXCLUDE (pass with @ at call site)
      * tnFileCount               (@?    OUT) Number of rows in taMembers (pass with @ at call site)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcInputFile, tcFileSpec, taMembers, tnFileCount

      EXTERNAL ARRAY taMembers

      tnFileCount = 0
      SELECT 0
      USE (tcInputFile) SHARED AGAIN NOUPDATE ALIAS TABLABIN

      SCAN FOR NOT DELETED() AND TYPE <> 'H'
         tnFileCount = tnFileCount + 1
         DIMENSION taMembers(tnFileCount, 2)
         taMembers(tnFileCount, 1) = This.get_AbsolutePath( ALLTRIM( NAME, 0, ' ', CHR(0) ), ADDBS( JUSTPATH( tcFileSpec ) ) )
         taMembers(tnFileCount, 2) = EXCLUDE
      ENDSCAN

      USE IN (SELECT("TABLABIN"))
   ENDPROC


   PROTECTED PROCEDURE collectPj2MemberList
      *---------------------------------------------------------------------------------------------------
      * Parses BUILD PROJECT from a PJ2, resolves per-file text paths, fills member and exclude lists.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcInputFile               (v! IN    ) PJ2 file path
      * tcFileSpec                (v! IN    ) Full path of the mirrored/text project
      * taMembers                 (@?    OUT) 2-column array: text path, binary path (pass with @)
      * tnFileCount               (@?    OUT) Number of .ADD() members (pass with @)
      * taPjxExcluded             (@?    OUT) Array of PJX-excluded paths from FileExclusions (pass with @)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcInputFile, tcFileSpec, taMembers, tnFileCount, taPjxExcluded
      LOCAL lcBinFile, lcTextFile, lcFlatText, lnRow, laExcludedLocal(1), lnExcl

      EXTERNAL ARRAY taMembers
      EXTERNAL ARRAY taPjxExcluded

      tnFileCount = ALINES( taMembers, STREXTRACT( FILETOSTR(tcInputFile), C_BUILDPROJ_I, C_BUILDPROJ_F ), 1+4 )
      laExcludedLocal = This.o_Mirror.collectPj2ExcludedPaths( tcInputFile, JUSTPATH( tcFileSpec ) )
      lnExcl          = ALEN(laExcludedLocal, 1)
      IF lnExcl < 1
         DIMENSION taPjxExcluded(1)
         taPjxExcluded(1) = ''
      ELSE
         DIMENSION taPjxExcluded(lnExcl)
         = ACOPY(laExcludedLocal, taPjxExcluded)
      ENDIF

      FOR lnRow = tnFileCount TO 1 STEP -1
         IF '.ADD(' $ taMembers(m.lnRow)
            lcBinFile   = This.get_AbsolutePath( STREXTRACT( taMembers(m.lnRow), ".ADD('", "')" ), ADDBS( JUSTPATH( tcFileSpec ) ) )
            lcTextFile  = This.resolvePj2TextMemberPath( lcBinFile )
            lcFlatText  = FORCEEXT( lcBinFile, This.get_TextExtForBinFile( lcBinFile ) )
            IF lcTextFile <> lcFlatText
               This.writeLog( C_TAB + C_TAB + '* Resolved per-dir text: ' + lcTextFile )
            ENDIF
            taMembers(m.lnRow, 1) = lcTextFile
            taMembers(m.lnRow, 2) = lcBinFile
         ELSE
            tnFileCount = tnFileCount - 1
            ADEL( taMembers, m.lnRow )
            DIMENSION taMembers(tnFileCount, 2)
         ENDIF
      ENDFOR
   ENDPROC


   PROTECTED PROCEDURE convertProjectHeaderIfNeeded
      *---------------------------------------------------------------------------------------------------
      * Converts the project file itself (PJX?PJ2 or PJ2?PJX) when tcType is not '*-'.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcInputFile               (v! IN    ) Project file path
      * tcType                    (v? IN    ) Batch type ('*', '*-', …); '*-' skips project conversion
      * tcOriginalFileName        (v? IN    ) Original name for headers / PJ2 metadata
      * toModulo                  (@?    OUT) Converter module object (unit tests)
      * toEx                      (@?    OUT) Exception object (pass with @ at call site)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcInputFile, tcType, tcOriginalFileName, toModulo, toEx AS EXCEPTION
      LOCAL lcFile, lnCodError

      IF tcType <> '*-' THEN
         lcFile     = tcInputFile
         lnCodError = This.convert( lcFile, toModulo, @toEx, .T., tcOriginalFileName )
         This.writeLog_Flush()
      ENDIF
   ENDPROC


   PROTECTED FUNCTION isProjectMemberPjxExcluded
      *---------------------------------------------------------------------------------------------------
      * True when the member is marked excluded in the PJX (export) or in PJ2 FileExclusions (import).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tlBinToText               (v! IN    ) .T. = check EXCLUDE column; .F. = check taPjxExcluded list
      * taMembers                 (@! IN    ) Member array from collectPjxMemberList / collectPj2MemberList (pass with @)
      * tnIndex                   (v! IN    ) Row index in taMembers (1 … tnFileCount)
      * taPjxExcluded             (@! IN    ) Exclude paths from collectPj2MemberList (import only; pass with @)
      * RETURN                    (v?    OUT) .T. if the member should be skipped as PJX-excluded
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tlBinToText AS Boolean, taMembers, tnIndex, taPjxExcluded

      EXTERNAL ARRAY taMembers
      EXTERNAL ARRAY taPjxExcluded

      IF tlBinToText
         RETURN taMembers[tnIndex, 2]
      ENDIF
      RETURN This.o_Mirror.isPjxExcludedFile( taMembers[tnIndex, 1], @taPjxExcluded )
   ENDFUNC


   PROTECTED PROCEDURE registerSkippedProjectMember
      *---------------------------------------------------------------------------------------------------
      * Writes a skip line to the log and registers the file in a_ProcessedFiles (P0/E0/S0/X0).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                    (v! IN    ) Member file path (text path on import)
      * tcReason                  (v! IN    ) Skip reason: 'subdir' | 'pjx' | 'outside'
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile AS STRING, tcReason AS STRING
      LOCAL lcMsg

      DO CASE
      CASE tcReason = 'subdir'
         lcMsg = '* Excluded (subdir): '
      CASE tcReason = 'pjx'
         lcMsg = '* Excluded (PJX): '
      CASE tcReason = 'outside'
         lcMsg = '* Skipped (outside project root): '
      ENDCASE

      This.writeLog( C_TAB + C_TAB + lcMsg + tcFile )
      IF This.addProcessedFile( tcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
         This.updateProcessedFile()
      ENDIF
   ENDPROC


   PROTECTED FUNCTION shouldProcessProjectMemberOutsideRoot
      *---------------------------------------------------------------------------------------------------
      * Validates mirror mode path against cInputRoot. Returns .F. when the member must be skipped.
      * Raises ERROR when n_CheckFileInPath = 1 and the file is outside the project root.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lcFile                    (v! IN    ) Member file path to validate
      * loLang                    (v! IN    ) CL_LANG for error/skip messages
      * RETURN                    (v?    OUT) .T. = continue processing; .F. = skip (already logged)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS lcFile AS STRING, loLang AS CL_LANG OF 'cl_lang.prg'
      LOCAL lcStr

      IF EMPTY(This.cOutputFolder) OR EMPTY(This.cInputRoot) OR This.isUnderInputRoot( lcFile )
         RETURN .T.
      ENDIF

      IF This.getCfgValue('n_CheckFileInPath') = 1
         lcStr = loLang.C_PJXPATH_ERR_LOC3 + lcFile + loLang.C_PJXPATH_ERR_LOC4 ;
            + ADDBS(This.cInputRoot) + loLang.C_PJXPATH_ERR_LOC5
         ERROR (lcStr)
      ENDIF

      This.registerSkippedProjectMember( lcFile, 'outside' )
      RETURN .F.
   ENDFUNC


   PROTECTED FUNCTION isProjectMemberConvertible
      *---------------------------------------------------------------------------------------------------
      * Whether the member should run through convert() for the current batch direction.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lcFile                    (v! IN    ) Member path (binary on export, text on import)
      * lcBinFile                 (v! IN    ) Binary path (same as lcFile on export; col 2 on import)
      * tlBinToText               (v! IN    ) Batch direction (.T. = Bin?Txt)
      * laDirInfo                 (@! IN/OUT) ADIR() scratch array (pass with @ at call site)
      * RETURN                    (v?    OUT) .T. if convert() should be invoked
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS lcFile AS STRING, lcBinFile AS STRING, tlBinToText AS Boolean, laDirInfo

      EXTERNAL ARRAY laDirInfo

      IF tlBinToText
         RETURN This.hasSupport_Bin2Prg( UPPER(JUSTEXT(lcFile)) ) AND ADIR( laDirInfo, lcFile ) > 0
      ENDIF
      RETURN This.hasSupport_Prg2Bin( lcFile ) AND This.isPj2TextMemberAvailable( lcBinFile )
   ENDFUNC


   PROTECTED PROCEDURE copyNonConvertibleProjectMember
      *---------------------------------------------------------------------------------------------------
      * Optionally copies a non-convertible member into the mirrored tree and registers it as processed.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lcFile                    (v! IN    ) Source path passed to copyUnconvertedFile (text on import)
      * lcBinFile                 (v! IN    ) Binary path (used on import to test file existence)
      * tlBinToText               (v! IN    ) Batch direction (.T. = Bin?Txt)
      * laDirInfo                 (@! IN/OUT) ADIR() scratch array (pass with @ at call site)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS lcFile AS STRING, lcBinFile AS STRING, tlBinToText AS Boolean, laDirInfo
      LOCAL llExists

      EXTERNAL ARRAY laDirInfo

      IF NOT This.getCfgValue('l_CopyNonConvertible') OR EMPTY(This.cOutputFolder)
         RETURN
      ENDIF

      llExists = ( ADIR( laDirInfo, lcFile ) > 0 )
      IF NOT tlBinToText
         llExists = llExists OR ( ADIR( laDirInfo, lcBinFile ) > 0 )
      ENDIF

      IF llExists AND This.copyUnconvertedFile( lcFile )
         This.writeLog( C_TAB + C_TAB + '- Copied (not convertible): ' + This.get_MirroredPath(lcFile) ;
            + IIF( This.isExportUTF8() AND This.isTextFileForEncoding(lcFile), ' (UTF-8)', '' ) )
      ENDIF

      IF This.addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
         This.updateProcessedFile()
      ENDIF
   ENDPROC


   PROTECTED FUNCTION convertProjectMember
      *---------------------------------------------------------------------------------------------------
      * Runs convert() for one project member and handles cancel (1799) and batch error accumulation.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lcFile                    (v! IN    ) File to convert (binary path on export, text on import)
      * tcOriginalFileName        (v? IN    ) Original name for headers / PJ2 metadata
      * toModulo                  (@?    OUT) Converter module object (unit tests)
      * toEx                      (@?    OUT) Exception object (pass with @ at call site)
      * llBatchError              (@?    OUT) Set to .T. on conversion error (pass with @ at call site)
      * RETURN                    (v?    OUT) convert() error code (1799 = user cancel)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS lcFile AS STRING, tcOriginalFileName, toModulo, toEx AS EXCEPTION, llBatchError AS Boolean
      LOCAL lnCodError

      lnCodError = This.convert( lcFile, toModulo, @toEx, .F., tcOriginalFileName )
      This.writeLog_Flush()

      DO CASE
      CASE lnCodError = 1799
         ERROR 1799
      CASE lnCodError > 0
         This.doWriteErrorLog( @toEx )
         llBatchError = .T.
         This.l_Error = .F.
      ENDCASE

      RETURN lnCodError
   ENDFUNC


   PROTECTED PROCEDURE processProjectMembersLoop
      *---------------------------------------------------------------------------------------------------
      * Unified loop over project members: exclusions, convert or copy, progress and error flags.
      * taMembers col 1 = file to convert (binary on export, text on import); col 2 = EXCLUDE or binary path.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * taMembers                 (@! IN    ) Member array from collectPjxMemberList / collectPj2MemberList (pass with @)
      * tnFileCount               (v! IN    ) Number of rows in taMembers
      * tcOriginalFileName        (v? IN    ) Original name forwarded to convert()
      * toModulo                  (@?    OUT) Converter module object (unit tests)
      * toEx                      (@?    OUT) Exception object (pass with @ at call site)
      * loLang                    (v! IN    ) CL_LANG for progress messages
      * tlBinToText               (v! IN    ) Batch direction (.T. = Bin?Txt / evaluate_Full_PJX)
      * taPjxExcluded             (@! IN    ) PJ2 exclude list (import only; pass with @; empty array on export)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS taMembers, tnFileCount, tcOriginalFileName, toModulo, toEx AS EXCEPTION, loLang AS CL_LANG OF 'cl_lang.prg', tlBinToText AS Boolean, taPjxExcluded
      LOCAL I, lcFile, lcBinFile, llBatchError, laDirInfo(1,5)

      EXTERNAL ARRAY taMembers
      EXTERNAL ARRAY taPjxExcluded

      llBatchError = .F.

      FOR I = 1 TO tnFileCount
         lcFile    = taMembers(m.I, 1)
         lcBinFile = IIF(tlBinToText, lcFile, taMembers(m.I, 2))
         This.updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, tnFileCount, 0 )

         IF This.isExcludedSubdir( lcFile )
            This.registerSkippedProjectMember( lcFile, 'subdir' )
            LOOP
         ENDIF

         IF NOT This.getCfgValue('l_CopyExcludedPjxFiles') AND NOT EMPTY(This.cOutputFolder) ;
               AND This.isProjectMemberPjxExcluded( tlBinToText, @taMembers, m.I, @taPjxExcluded )
            This.registerSkippedProjectMember( lcFile, 'pjx' )
            LOOP
         ENDIF

         IF NOT This.shouldProcessProjectMemberOutsideRoot( lcFile, loLang )
            LOOP
         ENDIF

         IF This.isProjectMemberConvertible( lcFile, lcBinFile, tlBinToText, @laDirInfo )
            This.convertProjectMember( lcFile, tcOriginalFileName, toModulo, @toEx, @llBatchError )
         ELSE
            This.copyNonConvertibleProjectMember( lcFile, lcBinFile, tlBinToText, @laDirInfo )
         ENDIF

         This.writeLog_Flush()

         IF llBatchError
            This.l_Error = .T.
         ENDIF
      ENDFOR
   ENDPROC


   PROTECTED PROCEDURE finalizeProjectBatch
      *---------------------------------------------------------------------------------------------------
      * Restores l_MirrorExport and releases the batch CL_LANG reference.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * llMirrorExportSave        (v! IN    ) Value to restore into This.l_MirrorExport
      * loLang                    (@? IN/OUT) CL_LANG to release (pass with @ at call site)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS llMirrorExportSave AS Boolean, loLang AS CL_LANG OF 'cl_lang.prg'
      This.l_MirrorExport = llMirrorExportSave
      STORE .NULL. TO loLang
      RELEASE loLang
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

      LOCAL lcFileSpec, lnFileCount, laFiles(1,2), laExcluded(1) ;
         , loLang AS CL_LANG OF 'cl_lang.prg' ;
         , loEx AS EXCEPTION ;
         , llMirrorExportSave AS Boolean

      TRY
         llMirrorExportSave = This.l_MirrorExport
         This.l_MirrorExport = .T.

         This.setupProjectBatchEnvironment( tc_InputFile, tcLogFile, tcRecompile, .T., @lcFileSpec, @loLang )
         This.collectPjxMemberList( tc_InputFile, lcFileSpec, @laFiles, @lnFileCount )
         This.convertProjectHeaderIfNeeded( tc_InputFile, tcType, tcOriginalFileName, toModulo, @toEx )
         This.processProjectMembersLoop( @laFiles, lnFileCount, tcOriginalFileName, toModulo, @toEx, loLang, .T., @laExcluded )

      CATCH TO loEx
         THROW

      FINALLY
         This.finalizeProjectBatch( llMirrorExportSave, @loLang )
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

      LOCAL lcFileSpec, lnFileCount, laFiles(1,2), laExcluded(1) ;
         , loLang AS CL_LANG OF 'cl_lang.prg' ;
         , loEx AS EXCEPTION ;
         , llMirrorExportSave AS Boolean

      TRY
         llMirrorExportSave = This.l_MirrorExport
         This.l_MirrorExport = .F.

         This.setupProjectBatchEnvironment( tc_InputFile, tcLogFile, tcRecompile, .F., @lcFileSpec, @loLang )
         This.collectPj2MemberList( tc_InputFile, lcFileSpec, @laFiles, @lnFileCount, @laExcluded )
         This.convertProjectHeaderIfNeeded( tc_InputFile, tcType, tcOriginalFileName, toModulo, @toEx )
         This.processProjectMembersLoop( @laFiles, lnFileCount, tcOriginalFileName, toModulo, @toEx, loLang, .F., @laExcluded )

      CATCH TO loEx
         THROW

      FINALLY
         This.finalizeProjectBatch( llMirrorExportSave, @loLang )
      ENDTRY
   ENDPROC


   HIDDEN PROCEDURE doWriteErrorLog
      *---------------------------------------------------------------------------------------------------
      * Delegates error logging to o_Logger.doWriteErrorLog (session log file and stderr).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toEx                      (@! IN    ) Exception from the failed conversion/execute path
      * tcErrorInfo               (@? IN/OUT) Optional preformatted text; filled when empty or on cancel (1799)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toEx AS EXCEPTION, tcErrorInfo
      This.ensureLogger()
      This.o_Logger.doWriteErrorLog( @toEx, @tcErrorInfo )
   ENDPROC
   PROTECTED FUNCTION computePerFileBasePath
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.computePerFileBasePath.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcInputFile               (v! IN    ) Current input path (VCX/SCX/DBC or per-object text)
      * tnStemLevels              (v! IN    ) 2 = one dotted segment; 3 = two dotted segments
      * RETURN                    (v?    OUT) Base file path for per-file optimization / prepareConversion
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcInputFile, tnStemLevels
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.computePerFileBasePath(tcInputFile, tnStemLevels)
   ENDFUNC
   PROTECTED FUNCTION resolveInputBaseFile
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.resolveInputBaseFile (may rewrite c_InputFile on host).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lcExtension               (v! IN    ) Upper-case extension of c_InputFile
      * RETURN                    (v?    OUT) Base file path passed to prepareConversion
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS lcExtension
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.resolveInputBaseFile(lcExtension)
   ENDFUNC
   PROTECTED PROCEDURE captureConversionFilestamps
      *---------------------------------------------------------------------------------------------------
      * Populates t_InputFile_TimeStamp and t_OutputFile_TimeStamp from sibling files in the input folder.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * laFiles                   (@! IN/OUT) ADIR array for FORCEEXT(c_InputFile,'*') — pass with @
      * tnFileCount               (@! IN/OUT) Row count returned by ADIR — pass with @
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS laFiles, tnFileCount
      EXTERNAL ARRAY laFiles

      LOCAL I, lcExtA, lcExtB, ltFilestamp, laDirFile(1,5)

      tnFileCount = ADIR( laFiles, FORCEEXT( This.c_InputFile, '*' ), '', 1 )
      STORE {//::} TO This.t_InputFile_TimeStamp, This.t_OutputFile_TimeStamp, ltFilestamp

      IF tnFileCount > 0 THEN
         I = ASCAN( laFiles, JUSTFNAME(This.c_InputFile), 1, 0, 1, 1+2+4+8 )
         IF m.I > 0 THEN
            This.t_InputFile_TimeStamp = DATETIME( YEAR(laFiles(m.I,3)), MONTH(laFiles(m.I,3)), DAY(laFiles(m.I,3)) ;
               , VAL(LEFT(laFiles(m.I,4),2)), VAL(SUBSTR(laFiles(m.I,4),4,2)), VAL(RIGHT(laFiles(m.I,4),2)) )
         ENDIF

         IF ADIR( laDirFile, This.c_OutputFile ) > 0 THEN
            I = ASCAN( laFiles, JUSTFNAME(This.c_OutputFile), 1, 0, 1, 1+2+4+8 )
            IF m.I > 0 THEN
               This.t_OutputFile_TimeStamp = DATETIME( YEAR(laFiles(m.I,3)), MONTH(laFiles(m.I,3)), DAY(laFiles(m.I,3)) ;
                  , VAL(LEFT(laFiles(m.I,4),2)), VAL(SUBSTR(laFiles(m.I,4),4,2)), VAL(RIGHT(laFiles(m.I,4),2)) )
            ENDIF

            lcExtA = UPPER(JUSTEXT(This.c_OutputFile))

            DO CASE
            CASE INLIST(lcExtA, 'SCX', 'VCX', 'MNX', 'FRX', 'LBX')
               lcExtB = ICASE(lcExtA = 'SCX', 'SCT' ;
                  , lcExtA = 'VCX', 'VCT' ;
                  , lcExtA = 'MNX', 'MNT' ;
                  , lcExtA = 'FRX', 'FRT' ;
                  , lcExtA = 'LBX', 'LBT')
               I = ASCAN( laFiles, JUSTFNAME( FORCEEXT(This.c_OutputFile, lcExtB) ), 1, 0, 1, 1+2+4+8 )
               IF m.I > 0 THEN
                  ltFilestamp = DATETIME( YEAR(laFiles(m.I,3)), MONTH(laFiles(m.I,3)), DAY(laFiles(m.I,3)) ;
                     , VAL(LEFT(laFiles(m.I,4),2)), VAL(SUBSTR(laFiles(m.I,4),4,2)), VAL(RIGHT(laFiles(m.I,4),2)) )
               ENDIF
            ENDCASE

            This.t_OutputFile_TimeStamp = MAX( This.t_OutputFile_TimeStamp, ltFilestamp )
         ENDIF
      ENDIF
   ENDPROC


   PROTECTED FUNCTION shouldSkipByFilestamp
      *---------------------------------------------------------------------------------------------------
      * True when n_OptimizeByFilestamp says the output is already up to date (VCX/SCX, per-file off).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lcExtension               (v! IN    ) Upper-case extension of c_InputFile
      * loLang                    (v! IN    ) CL_LANG instance for log messages
      * RETURN                    (v?    OUT) .T. to skip loConversor.convert
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS lcExtension, loLang AS CL_LANG OF 'cl_lang.prg'

      DO CASE
      CASE INLIST(lcExtension, 'VCX', This.getCfgValue('c_VC2')) AND This.getCfgValue('n_UseClassPerFile') = 0 ;
            AND This.getCfgValue('n_OptimizeByFilestamp') = 1 AND This.t_InputFile_TimeStamp < This.t_OutputFile_TimeStamp
         This.writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )
         RETURN .T.

      CASE INLIST(lcExtension, 'VCX', This.getCfgValue('c_VC2')) AND This.getCfgValue('n_UseClassPerFile') = 0 ;
            AND This.getCfgValue('n_OptimizeByFilestamp') = 2 AND This.t_InputFile_TimeStamp = This.t_OutputFile_TimeStamp
         This.writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )
         RETURN .T.

      CASE INLIST(lcExtension, 'SCX', This.getCfgValue('c_SC2')) AND This.getCfgValue('n_UseFormPerFile') = 0 ;
            AND This.getCfgValue('n_OptimizeByFilestamp') = 1 AND This.t_InputFile_TimeStamp < This.t_OutputFile_TimeStamp
         This.writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )
         RETURN .T.

      CASE INLIST(lcExtension, 'SCX', This.getCfgValue('c_SC2')) AND This.getCfgValue('n_UseFormPerFile') = 0 ;
            AND This.getCfgValue('n_OptimizeByFilestamp') = 2 AND This.t_InputFile_TimeStamp = This.t_OutputFile_TimeStamp
         This.writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )
         RETURN .T.

      OTHERWISE
         RETURN .F.
      ENDCASE
   ENDFUNC


   PROTECTED PROCEDURE bindConversorFromHost
      *---------------------------------------------------------------------------------------------------
      * Copies session state onto the conversor before convert() or loadModule().
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loConversor               (v! IN    ) c_conversor_base instance from the factory
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS loConversor AS c_conversor_base OF 'c_conversor_base.prg'

      This.c_Type                           = UPPER(JUSTEXT(This.c_OutputFile))
      loConversor.c_InputFile               = This.c_InputFile
      loConversor.c_OutputFile              = This.c_OutputFile
      loConversor.c_LogFile                 = This.c_LogFile
      loConversor.n_Debug                   = This.getCfgValue('n_Debug')
      loConversor.l_Test                    = This.l_Test
      loConversor.n_FB2PRG_Version          = This.n_FB2PRG_Version
      loConversor.l_MethodSort_Enabled      = This.l_MethodSort_Enabled
      loConversor.l_PropSort_Enabled        = This.l_PropSort_Enabled
      loConversor.l_ReportSort_Enabled      = This.l_ReportSort_Enabled
      loConversor.c_OriginalFileName        = This.c_OriginalFileName
      loConversor.c_Foxbin2prg_FullPath     = This.c_Foxbin2prg_FullPath
   ENDPROC


   PROTECTED PROCEDURE logConversorOutput
      *---------------------------------------------------------------------------------------------------
      * Writes conversor text log and error block; sets l_Error when the conversor reported failure.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loConversor               (v! IN    ) c_conversor_base after convert / loadModule
      * loLang                    (v! IN    ) CL_LANG instance for error captions
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS loConversor AS c_conversor_base OF 'c_conversor_base.prg', loLang AS CL_LANG OF 'cl_lang.prg'

      IF loConversor.l_Error
         This.l_Error = .T.
      ENDIF

      This.writeLog()
      This.writeLog(loConversor.c_TextLog)

      IF NOT EMPTY(loConversor.c_TextErr)
         This.writeErrorLog( REPLICATE( '-', 100 ), 1 )
         This.writeErrorLog( loLang.C_ERRORS_FOUND_IN_FILE_LOC + ' [' + This.c_InputFile + '] ' )
         This.writeErrorLog( loConversor.c_TextErr )
         This.writeErrorLog()
      ENDIF
   ENDPROC


   PROTECTED PROCEDURE executeConversorOperation
      *---------------------------------------------------------------------------------------------------
      * Binds host props, runs convert or loadModule, and logs the conversor output.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * loConversor               (v! IN    ) c_conversor_base from the factory
      * toModulo                  (@?    OUT) Module object for unit tests — pass with @
      * llLoadOnly                (v! IN    ) .T. = loadModule (LOAD_ONLY mode)
      * laEvents                  (@! IN/OUT) BINDEVENT tracker array — pass with @
      * loLang                    (v! IN    ) CL_LANG for progress and error messages
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS loConversor AS c_conversor_base OF 'c_conversor_base.prg', toModulo, llLoadOnly AS Boolean, laEvents, loLang AS CL_LANG OF 'cl_lang.prg'

      EXTERNAL ARRAY laEvents

      This.bindConversorFromHost( loConversor )

      IF llLoadOnly
         loConversor.loadModule( @toModulo, .F., THIS )
      ELSE
         This.updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + This.c_InputFile + '...', 0, 0, 0 )

         IF AEVENTS( laEvents, loConversor ) = 0
            BINDEVENT( loConversor, 'updateProgressbar', THIS, 'updateProgressbar' )
         ENDIF

         loConversor.convert( @toModulo, .F., THIS )
         This.n_ProcessedFilesCount = This.n_ProcessedFilesCount + 1
      ENDIF

      This.logConversorOutput( loConversor, loLang )
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
      * tcMode                    (v? IN    ) 'FULL' (default) | 'LOAD_ONLY'
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, toModulo, toEx AS EXCEPTION, tlRelanzarError, tcOriginalFileName, tcMode

      TRY
         LOCAL lnCodError, lcErrorInfo, laDirFile(1,5), lcExtension, lnFileCount, laFiles(1,1), laEvents(1,1), lcForceAttribs, lnIDInputFile, llLoadOnly, lc_OldSetNotify, lc_BaseFile ;
            , loLang AS CL_LANG OF 'cl_lang.prg' ;
            , loConversor AS c_conversor_base OF 'c_conversor_base.prg' ;
            , loFSO AS Scripting.FileSystemObject
         lnCodError          = 0
         tcMode              = Upper( Evl(tcMode, 'FULL') )
         llLoadOnly          = (tcMode = 'LOAD_ONLY')

         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            IF llLoadOnly
               STORE .NULL. TO toModulo
               lc_OldSetNotify = SET("Notify")
               SET NOTIFY OFF
            ENDIF

            loFSO           = .o_FSO
            loLang          = _SCREEN.o_FoxBin2Prg_Lang
            lcForceAttribs  = '+N'
            .c_InputFile    = FULLPATH( tc_InputFile )
            .l_Error        = .F.
            lcExtension     = UPPER( JUSTEXT(.c_InputFile) )

            .writeLog( REPLICATE( '*', 100 ) )
            .writeLog( IIF(llLoadOnly, 'LOAD MODULE', 'CONVERSION PROCESS'), 2 )
            .writeLog( REPLICATE( '*', 100 ) )

            IF ADIR( laDirFile, .c_InputFile, '', 1 ) = 0
               ERROR loLang.C_FILE_NOT_FOUND_LOC + ' [' + .c_InputFile + ']'
            ENDIF

            .c_InputFile    = loFSO.GetAbsolutePathName( FORCEPATH( laDirFile(1,1), JUSTPATH(.c_InputFile) ) )

            IF NOT llLoadOnly
               IF .n_ForceWriteIfReadOnly = 1 THEN
                  lcForceAttribs  = lcForceAttribs + '-R'
               ENDIF

               lc_BaseFile = .resolveInputBaseFile( lcExtension )
               ERASE ( .c_InputFile + '.ERR' )
            ENDIF

            IF NOT EMPTY(tcOriginalFileName)
               tcOriginalFileName  = loFSO.GetAbsolutePathName( tcOriginalFileName )
            ENDIF

            .c_OriginalFileName = EVL( tcOriginalFileName, .c_InputFile )

            IF NOT llLoadOnly
               IF NOT .addProcessedFile( .c_InputFile, 'I', 'P1', 'E0', 'S1', 'X0' ) THEN
                  .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE( loLang.C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC ) )
                  EXIT
               ENDIF
               lnIDInputFile   = .n_ProcessedFiles
            ELSE
               lnIDInputFile   = .n_ProcessedFiles
            ENDIF

            .writeLog( C_TAB + 'c_OriginalFileName:           ' + .c_OriginalFileName )
            .writeLog( )

            IF NOT ADIR(laDirFile, .c_InputFile) > 0 THEN
               ERROR loLang.C_FILE_DOESNT_EXIST_LOC + ' [' + .c_InputFile + ']'
            ENDIF

            IF NOT llLoadOnly
               .normalizeFileCapitalization( .T. )
            ENDIF

            .ensureConversionFactory()
            loConversor = .o_ConversionFactory.createConversor( lcExtension, .c_InputFile )

            IF NOT llLoadOnly
               .o_ConversionFactory.prepareConversion( lcExtension, .c_InputFile, lc_BaseFile, lcForceAttribs )
            ENDIF

            loConversor.o_SpecialProps = This.o_SpecialProps
            loConversor.cOutputFolder = This.cOutputFolder
            loConversor.cInputRoot    = This.cInputRoot

            IF NOT llLoadOnly
               IF NOT EMPTY(.cOutputFolder) ;
                     AND INLIST( UPPER(JUSTEXT(.c_OutputFile)), 'VCX','SCX','PJX','PJM','FRX','LBX','MNX','DBC','DBF' )
                  .c_OutputFile = loConversor.get_MirroredOutputFile( .c_OutputFile )
               ENDIF

               .captureConversionFilestamps( @laFiles, @lnFileCount )

               IF !.shouldSkipByFilestamp( lcExtension, loLang )
                  .executeConversorOperation( loConversor, @toModulo, llLoadOnly, @laEvents, loLang )
               ENDIF

               .normalizeFileCapitalization()
            ELSE
               .executeConversorOperation( loConversor, @toModulo, llLoadOnly, @laEvents, loLang )
            ENDIF
         ENDWITH

      CATCH TO toEx
         lnCodError  = toEx.ERRORNO

         IF NOT llLoadOnly
            This.updateProcessedFile( lnIDInputFile, '', '', 'E1' )
         ENDIF

         IF This.getCfgValue('n_Debug') > 0 THEN
            IF _VFP.STARTMODE = 0
               SET STEP ON
            ENDIF
         ENDIF
         IF tlRelanzarError
            THROW
         ENDIF

      FINALLY
         IF llLoadOnly
            SET NOTIFY &lc_OldSetNotify.
         ENDIF

         IF NOT llLoadOnly AND AEVENTS( laEvents, loConversor ) > 0 THEN
            UNBINDEVENTS( loConversor )
         ENDIF

         STORE .NULL. TO loConversor, loFSO

         IF NOT llLoadOnly THEN
            IF lnCodError = 0 AND This.l_Error THEN
               This.updateProcessedFile( lnIDInputFile, '', '', 'E1' )
            ENDIF
         ENDIF

         RELEASE lcErrorInfo, laDirFile, lcExtension, lnFileCount, laFiles ;
            , loConversor, loFSO
      ENDTRY

      RETURN lnCodError
   ENDPROC


   PROCEDURE get_DirSettings
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_Cfg.get_DirSettings (factory CFG clone; legacy API).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcDir                      (v? IN    ) Directory key
      * tcDebug                    (v? IN    ) Debug flag string
      * tcCFG_File                 (v? IN    ) Legacy CFG file path
      * RETURN                    (v?    OUT) CFG object
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcDir, tcDebug, tcCFG_File
      This.ensureCfg()
      RETURN This.o_Cfg.get_DirSettings(tcDir, tcDebug, tcCFG_File)
   ENDPROC


   PROCEDURE formatConfigReferenceText
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_Cfg.formatConfigReferenceText for frm_main display.
      * RETURN                    (v?    OUT) Multi-line reference text
      *---------------------------------------------------------------------------------------------------

      This.ensureCfg()
      RETURN This.o_Cfg.formatConfigReferenceText()
   ENDPROC


   PROCEDURE createCfgShell
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_Cfg.createCfgShell (empty marked CFG object).
      * RETURN                    (v?    OUT) Empty CFG shell object
      *---------------------------------------------------------------------------------------------------

      This.ensureCfg()
      RETURN This.o_Cfg.createCfgShell()
   ENDPROC


   PROCEDURE getActiveCfg
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_Cfg.getActiveCfg (current session master CFG).
      * RETURN                    (v?    OUT) Active CFG object
      *---------------------------------------------------------------------------------------------------

      This.ensureCfg()
      RETURN This.o_Cfg.getActiveCfg()
   ENDPROC


   PROCEDURE getCfgValue
      *---------------------------------------------------------------------------------------------------
      * Reads a property from the session CFG object.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcProp                     (v! IN    ) Property name (e.g. 'n_Debug', 'c_VC2')
      * RETURN                    (v?    OUT) Property value
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcProp
      This.ensureCfg()
      RETURN This.o_Cfg.getCfgValue(tcProp)
   ENDPROC


   PROCEDURE getCfgFlag
      *---------------------------------------------------------------------------------------------------
      * Reads a logical CFG property as .T./.F.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcProp                     (v! IN    ) Property name
      * tlDefault                  (v? IN    ) Default when property missing
      * RETURN                    (v?    OUT) Logical flag
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcProp, tlDefault
      This.ensureCfg()
      RETURN This.o_Cfg.getCfgFlag(tcProp, tlDefault)
   ENDPROC


   PROCEDURE getCfgInt
      *---------------------------------------------------------------------------------------------------
      * Reads a numeric CFG property as integer.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcProp                     (v! IN    ) Property name
      * lnDefault                  (v? IN    ) Default when property missing
      * RETURN                    (v?    OUT) Integer value
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcProp, lnDefault
      This.ensureCfg()
      RETURN This.o_Cfg.getCfgInt(tcProp, lnDefault)
   ENDPROC


   PROCEDURE getCfgObjectForWrite
      *---------------------------------------------------------------------------------------------------
      * Returns mutable session CFG reference for programmatic updates.
      * RETURN                    (v?    OUT) CFG object for write
      *---------------------------------------------------------------------------------------------------

      This.ensureCfg()
      RETURN This.o_Cfg.getCfgObjectForWrite()
   ENDPROC


   PROCEDURE setCfgValue
      *---------------------------------------------------------------------------------------------------
      * Writes a property on the session CFG object.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcProp                     (v! IN    ) Property name
      * txVal                      (v! IN    ) New value
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcProp, txVal
      This.ensureCfg()
      This.o_Cfg.setCfgValue(tcProp, txVal)
   ENDPROC


   PROCEDURE isCfg
      *---------------------------------------------------------------------------------------------------
      * True when toObj is a FoxBin2Prg CFG marker object.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toObj                      (v? IN    ) Object to test
      * RETURN                    (v?    OUT) .T. for valid CFG object
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS toObj
      This.ensureCfg()
      RETURN This.o_Cfg.isCfg(toObj)
   ENDPROC


   PROCEDURE cfgCopyFrom
      *---------------------------------------------------------------------------------------------------
      * Copies properties from source CFG into parent CFG.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toParentCFG                (v! IN    ) Destination CFG
      * toSourceCFG                (v! IN    ) Source CFG
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS toParentCFG, toSourceCFG
      This.ensureCfg()
      This.o_Cfg.cfgCopyFrom(toParentCFG, toSourceCFG)
   ENDPROC


   PROCEDURE newConfig
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_Cfg.newConfig (empty marked CFG object for programmatic overrides).
      * RETURN                    (v?    OUT) New CFG shell object
      *---------------------------------------------------------------------------------------------------

      This.ensureCfg()
      RETURN This.o_Cfg.newConfig()
   ENDPROC


   PROCEDURE configFromObject
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_Cfg.configFromObject (copies properties from any duck-typed object into a CFG).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toSource                   (v? IN    ) Source object (CFG or duck-typed with FB2P properties)
      * toDestCfg                  (v? IN    ) Destination CFG; new shell created when omitted or invalid
      * RETURN                    (v?    OUT) Populated CFG object
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toSource, toDestCfg
      This.ensureCfg()
      RETURN This.o_Cfg.configFromObject(toSource, toDestCfg)
   ENDPROC


   PROCEDURE applyConfig
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_Cfg.applyConfig (replaces session master CFG from object or duck-typed source).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toCfg                      (v! IN    ) CFG object or duck-typed configuration source
      * RETURN                    (v?    OUT) .T. when session CFG was updated
      *---------------------------------------------------------------------------------------------------
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
      * toCfg                     (v? IN    ) (Optional) Configuration object (newConfig / duck-typed)
      * tcInputRoot               (v? IN    ) (Optional) Source root. Default: the project folder
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcProjectFile, tcOutputRoot, toCfg, tcInputRoot
      LOCAL loEx AS EXCEPTION, loCfg

      loCfg = This.mergeExecuteConfig( toCfg )

      This.ensureMirror()
      This.o_Mirror.setProjectRoots( tcOutputRoot, EVL( tcInputRoot, ADDBS( JUSTPATH( FULLPATH(tcProjectFile) ) ) ) )

      RETURN This.execute( tcProjectFile, '*', loCfg, @loEx )
   ENDPROC


   PROCEDURE importProjectTree
      *---------------------------------------------------------------------------------------------------
      * Imports a complete mirrored project (.PJ2) into a destination folder, replicating the folder
      * tree that components have relative to the mirrored project root.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcMirrorProjectFile       (v! IN    ) Mirrored project path to import (.PJ2 or c_PJ2 CFG value)
      * tcOutputRoot              (v! IN    ) Destination root folder where binaries are regenerated
      * toCfg                     (v? IN    ) (Optional) Configuration object (newConfig / duck-typed)
      * tcInputRoot               (v? IN    ) (Optional) Mirrored source root. Default: the PJ2 folder
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcMirrorProjectFile, tcOutputRoot, toCfg, tcInputRoot
      LOCAL loEx AS EXCEPTION, loCfg

      loCfg = This.mergeExecuteConfig( toCfg )

      This.ensureMirror()
      This.o_Mirror.setProjectRoots( tcOutputRoot, EVL( tcInputRoot, ADDBS( JUSTPATH( FULLPATH(tcMirrorProjectFile) ) ) ) )

      RETURN This.execute( tcMirrorProjectFile, '*', loCfg, @loEx )
   ENDPROC


   PROCEDURE makeDirTree
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_Mirror.makeDirTree (recursively creates directory tree if missing).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcDir                      (v! IN    ) Root directory path to create
      * RETURN                    (v?    OUT) .T. when tree exists or was created
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcDir
      This.ensureMirror()
      RETURN This.o_Mirror.makeDirTree(tcDir)
   ENDPROC
   PROCEDURE getPerFileDir
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.getPerFileDir.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path (or base path without class suffix)
      * tcTextExt                 (v! IN    ) Text extension (c_VC2 or c_SC2)
      * tlUsePerDir               (v! IN    ) UseClassPerDir or UseFormPerDir flag
      * lnUsePerFile              (v! IN    ) UseClassPerFile or UseFormPerFile value
      * RETURN                    (v?    OUT) Directory for per-file text output/search
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.getPerFileDir(tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile)
   ENDPROC
   PROCEDURE getPerFileOutputPath
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.getPerFileOutputPath.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path
      * tcSuffix                  (v? IN    ) Class/object suffix; empty = header file
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Full output text file path
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcSuffix, tcTextExt, tlUsePerDir, lnUsePerFile
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.getPerFileOutputPath(tcBinaryFile, tcSuffix, tcTextExt, tlUsePerDir, lnUsePerFile)
   ENDPROC
   PROCEDURE getPerFileSearchDir
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.getPerFileSearchDir.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcTextFile                (v! IN    ) Header or per-class text file path
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Directory to search for sibling per-file text parts
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcTextFile, tcTextExt, tlUsePerDir, lnUsePerFile
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.getPerFileSearchDir(tcTextFile, tcTextExt, tlUsePerDir, lnUsePerFile)
   ENDPROC
   PROCEDURE getPerFileBinaryOutputPath
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.getPerFileBinaryOutputPath.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcSourceFile              (v! IN    ) Source text file path (header or per-class part)
      * tcBinExt                  (v! IN    ) Binary extension (VCX, SCX, ...)
      * tcTextExt                 (v! IN    ) Text extension (c_VC2, c_SC2, ...)
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Binary file path for output
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcSourceFile, tcBinExt, tcTextExt, tlUsePerDir, lnUsePerFile
      This.ensureSplitPaths()
      RETURN This.o_SplitPaths.getPerFileBinaryOutputPath(tcSourceFile, tcBinExt, tcTextExt, tlUsePerDir, lnUsePerFile)
   ENDPROC
   PROCEDURE ensurePerFileDir
      *---------------------------------------------------------------------------------------------------
      * Wrapper -> o_SplitPaths.ensurePerFileDir (creates per-dir text folder via makeDirTree).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile
      This.ensureSplitPaths()
      This.o_SplitPaths.ensurePerFileDir(tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile)
   ENDPROC
   PROCEDURE get_MirroredPath
      *---------------------------------------------------------------------------------------------------
      * Maps a source file path to its mirrored destination path.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                     (v! IN    ) Source file path
      * RETURN                    (v?    OUT) Mirrored output path
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcFile
      This.ensureMirror()
      RETURN This.o_Mirror.get_MirroredPath(tcFile)
   ENDPROC


   PROCEDURE isExcludedSubdir
      *---------------------------------------------------------------------------------------------------
      * True when tcFile is under a c_ExcludedSubdirs path segment.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                     (v! IN    ) File path to test
      * RETURN                    (v?    OUT) .T. if excluded by subdir rules
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcFile
      This.ensureMirror()
      RETURN This.o_Mirror.isExcludedSubdir(tcFile)
   ENDPROC


   PROCEDURE isUnderInputRoot
      *---------------------------------------------------------------------------------------------------
      * True when tcFile is under This.cInputRoot (mirror export/import).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                     (v! IN    ) File path to test
      * RETURN                    (v?    OUT) .T. if inside project root
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcFile
      This.ensureMirror()
      RETURN This.o_Mirror.isUnderInputRoot(tcFile)
   ENDPROC


   PROCEDURE copyUnconvertedFile
      *---------------------------------------------------------------------------------------------------
      * Copies a non-convertible member into the mirrored tree; wrapper ? o_Mirror.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                     (v! IN    ) Source file path
      * RETURN                    (v?    OUT) .T. when copy succeeded
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcFile
      This.ensureMirror()
      RETURN This.o_Mirror.copyUnconvertedFile(tcFile)
   ENDPROC


   FUNCTION isTextFileForEncoding
      *---------------------------------------------------------------------------------------------------
      * True for plain-text extensions suitable for UTF-8 mirror copy (no binary NUL bytes).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                     (v! IN    ) File path to sample
      * RETURN                    (v?    OUT) .T. for encodable text files
      *---------------------------------------------------------------------------------------------------

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
      This.ensureFileUtils()
      RETURN This.o_FileUtils.getNext_BAK( tcOutputFileName )
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
      *---------------------------------------------------------------------------------------------------
      * Renames input/output files via filename_caps when available (VCX sidecars, DBF, …).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tl_NormalizeInputFile      (v? IN    ) .T. = normalize input (This.c_InputFile)
      * tcFileName                 (v? IN    ) Override path; default from c_InputFile/c_OutputFile
      *---------------------------------------------------------------------------------------------------

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
      *---------------------------------------------------------------------------------------------------
      * Recursively collects file paths under tcDir into taFiles (skips '.' directories).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcDir                      (v! IN    ) Root directory to scan
      * taFiles                    (@! IN/OUT) Output array of full paths (pass @)
      * tnFileCount                (@! IN/OUT) Element count (pass @)
      *---------------------------------------------------------------------------------------------------

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

      RETURN This.convert( tc_InputFile, @toModulo, @toEx, tlRelanzarError, tcOriginalFileName, 'LOAD_ONLY' )
   ENDPROC


   PROCEDURE readInputVFPParams
      *---------------------------------------------------------------------------------------------------
      * Parses Windows command line into taParams (EXE mode); adapted from kernel32 GetCommandLine.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * taParams                   (@!    OUT) Token array (pass @)
      * tnPCount                   (@?    OUT) Parameter count after stripping EXE name (pass @)
      *---------------------------------------------------------------------------------------------------

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
      *---------------------------------------------------------------------------------------------------
      * Invokes cl_FileName_Caps to normalize file name capitalization on disk.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFileName                 (v! IN    ) File to rename
      * tcEXE_CAPS                 (v! IN    ) Path to filename_caps.exe
      * toFSO                      (v? IN    ) Scripting.FileSystemObject (unused legacy)
      * tlRelanzarError            (v? IN    ) .T. = re-raise capitalization errors
      *---------------------------------------------------------------------------------------------------

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
      *---------------------------------------------------------------------------------------------------
      * Renames temporary export file to final text extension; wrapper ? o_FileUtils.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFileName                 (v! IN    ) Temp file path
      * RETURN                    (v?    OUT) .T. on success
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcFileName
      This.ensureFileUtils()
      RETURN This.o_FileUtils.renameTmpFile2Tx2File(tcFileName)
   ENDPROC


   FUNCTION isExportUTF8
      *---------------------------------------------------------------------------------------------------
      * True when session CFG l_ExportUTF8 is enabled.
      * RETURN                    (v?    OUT) .T. for UTF-8 text export/import
      *---------------------------------------------------------------------------------------------------

      RETURN This.getCfgFlag('l_ExportUTF8')
   ENDFUNC


   FUNCTION encodeTextForExport
      *---------------------------------------------------------------------------------------------------
      * Converts ANSI text (current code page) to UTF-8 bytes when ExportUTF8 is enabled.
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                     (v! IN    ) ANSI text in current code page
      * RETURN                    (v?    OUT)                     UTF-8 or ANSI string per CFG
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                     (v! IN    ) File contents read from disk
      * RETURN                    (v?    OUT)                     ANSI string for VFP processing
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                     (v! IN    ) Text file path
      * RETURN                    (v?    OUT)                     File contents as ANSI string
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile
      RETURN This.decodeTextFromImport(FileToStr(tcFile))
   ENDFUNC


   FUNCTION writeTextFile
      *---------------------------------------------------------------------------------------------------
      * Writes a text representation file honoring ExportUTF8.
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                     (v! IN    ) Text to write
      * tcFile                     (v! IN    ) Destination path
      * RETURN                    (v?    OUT)                     Bytes written (StrToFile)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcText, tcFile
      RETURN StrToFile(This.encodeTextForExport(tcText), tcFile)
   ENDFUNC


   FUNCTION finalizeTextExportFile
      *---------------------------------------------------------------------------------------------------
      * Converts an ANSI text file (e.g. written via Scripting.TextStream) to UTF-8 in place.
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFile                     (v! IN    ) ANSI file to convert in place
      * RETURN                    (v?    OUT)                     .T. when UTF-8 write succeeded or UTF-8 disabled
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcNewAnsiFile              (v! IN    ) New export temp file (ANSI)
      * tcExistingFile             (v! IN    ) Existing file on disk (ANSI or UTF-8)
      * RETURN                    (v?    OUT)                     .T. when normalized contents match
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcNewAnsiFile, tcExistingFile
      RETURN (FileToStr(tcNewAnsiFile) == This.readTextFile(tcExistingFile))
   ENDFUNC



   PROCEDURE set_Line
      *---------------------------------------------------------------------------------------------------
      * Trims leading whitespace/TAB from taCodeLines(I) into tcLine (converter helper).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcLine                     (@! IN/OUT) Output line (pass @)
      * taCodeLines                (@! IN    ) Source line array (pass @)
      * I                          (v! IN    ) Line index
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcLine, taCodeLines, I
      EXTERNAL ARRAY taCodeLines

      tcLine  = LTRIM( taCodeLines(m.I), 0, CHR(9), ' ' )
   ENDPROC


   PROCEDURE errOut
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_FileUtils.errOut (writes text to stderr when l_StdOutHabilitado).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcTexto                    (v? IN    ) Text line to emit (CR/LF appended)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcTexto
      This.ensureFileUtils()
      RETURN This.o_FileUtils.errOut(tcTexto)
   ENDPROC


   PROCEDURE stdOut
      *---------------------------------------------------------------------------------------------------
      * Wrapper ? o_FileUtils.stdOut (writes text to stdout when l_StdOutHabilitado).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcTexto                    (v? IN    ) Text line to emit (CR/LF appended)
      *---------------------------------------------------------------------------------------------------
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
               .a_ProcessedFiles(tnID, 2)  = EVL(tcInOutType, '')
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
      *---------------------------------------------------------------------------------------------------
      * Appends a line to the session error log buffer; wrapper ? o_Logger.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                     (v? IN    ) Text line
      * tnTimeStamp                (v? IN    ) Optional timestamp flag
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcText, tnTimeStamp
      This.ensureLogger()
      This.o_Logger.writeErrorLog( tcText, tnTimeStamp )
   ENDPROC


   PROCEDURE writeErrorLog_Flush
      *---------------------------------------------------------------------------------------------------
      * Flushes error log buffer to c_ErrorLogFile; wrapper ? o_Logger.
      *---------------------------------------------------------------------------------------------------

      This.ensureLogger()
      This.o_Logger.writeErrorLog_Flush()
   ENDPROC


   PROCEDURE writeLog
      *---------------------------------------------------------------------------------------------------
      * Appends a line to the session debug log buffer; wrapper ? o_Logger.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                     (v? IN    ) Text line
      * tnTimeStamp                (v? IN    ) Optional timestamp / header level
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcText, tnTimeStamp
      This.ensureLogger()
      This.o_Logger.writeLog( tcText, tnTimeStamp )
   ENDPROC


   PROCEDURE writeLog_Flush
      *---------------------------------------------------------------------------------------------------
      * Flushes debug log buffer to c_LogFile; wrapper ? o_Logger.
      *---------------------------------------------------------------------------------------------------

      This.ensureLogger()
      This.o_Logger.writeLog_Flush()
   ENDPROC


   HIDDEN PROCEDURE exception2Str
      *---------------------------------------------------------------------------------------------------
      * Serializes an Exception object to text; wrapper ? o_Logger.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toEx                       (@? IN    ) Exception object (pass @)
      * RETURN                    (v?    OUT) Formatted exception string
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS toEx AS EXCEPTION
      This.ensureLogger()
      RETURN This.o_Logger.exception2Str( @toEx )
   ENDPROC


   PROCEDURE unique_ID
      *---------------------------------------------------------------------------------------------------
      * Generates a unique numeric or string id for internal object naming.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcValType                  (v? IN    ) 'N' = numeric | otherwise '_#########' string
      * RETURN                    (v?    OUT) Unique id
      *---------------------------------------------------------------------------------------------------

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
      *---------------------------------------------------------------------------------------------------
      * Runs a shell command; wrapper ? o_FileUtils.wscriptshell_run.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcCmdLine                  (v! IN    ) Command line
      * tnWindowStyle              (v? IN    ) WScript window style
      * tbWaitOnReturn             (v? IN    ) Wait for process
      * tlDebug                    (v? IN    ) Log command when debugging
      * RETURN                    (v?    OUT) Process exit code / WScript result
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcCmdLine, tnWindowStyle, tbWaitOnReturn, tlDebug
      This.ensureFileUtils()
      RETURN This.o_FileUtils.wscriptshell_run(tcCmdLine, tnWindowStyle, tbWaitOnReturn, tlDebug)
   ENDFUNC


   FUNCTION FERROR_Message(tcFileName AS STRING)
      *---------------------------------------------------------------------------------------------------
      * Returns FERROR() diagnostic text for a file; wrapper ? o_FileUtils.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcFileName                 (v? IN    ) File context for message
      * RETURN                    (v?    OUT) Error description string
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tcFileName
      This.ensureFileUtils()
      RETURN This.o_FileUtils.FERROR_Message(tcFileName)
   ENDFUNC


   FUNCTION getLocaleInfo
      *---------------------------------------------------------------------------------------------------
      * Reads Windows locale information; wrapper ? o_FileUtils.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tnSetting                  (v! IN    ) LOCALE_* constant
      * tcLocale                   (v? IN    ) Optional locale name
      * RETURN                    (v?    OUT) Locale string
      *---------------------------------------------------------------------------------------------------

      LPARAMETERS tnSetting, tcLocale
      This.ensureFileUtils()
      RETURN This.o_FileUtils.getLocaleInfo(tnSetting, tcLocale)
   ENDFUNC

ENDDEFINE
