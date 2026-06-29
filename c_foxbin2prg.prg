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
   o_Cfg                           = .NULL.        && cl_fb2prg_cfg (configuration manager)
   o_ConversionFactory             = .NULL.        && cl_fb2prg_conversion_factory (converter routing)
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


   PROCEDURE clearConfigurationCache
      *---------------------------------------------------------------------------------------------------
      * Drops per-directory CFG cache on o_Cfg (factory/master CFG are kept).
      *---------------------------------------------------------------------------------------------------
      IF VARTYPE(This.o_Cfg) = 'O' AND !ISNULL(This.o_Cfg)
         This.o_Cfg.clearConfigurationCache()
      ENDIF
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

   PROCEDURE ensureConversionFactory
      IF VARTYPE(This.o_ConversionFactory) <> 'O' OR ISNULL(This.o_ConversionFactory)
         This.o_ConversionFactory = NewObject('cl_fb2prg_conversion_factory', 'cl_fb2prg_conversion_factory.prg', NULL, This)
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


   PROCEDURE writeLogDbfCfgSettings
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
      LPARAMETERS tcType
      RETURN ATC('-BIN2PRG', ('-' + tcType)) > 0 ;
         OR ATC('-BIN2TEXT', ('-' + tcType)) > 0
   ENDFUNC

   PROTECTED FUNCTION isTextToBinMode
      LPARAMETERS tcType
      RETURN ATC('-PRG2BIN', ('-' + tcType)) > 0 ;
         OR ATC('-TEXT2BIN', ('-' + tcType)) > 0
   ENDFUNC

   PROTECTED PROCEDURE restoreEscapeKey
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
      LPARAMETERS tc_InputFile, tcType, lcExt
      LOCAL laFiles(1,5), lnRedirect, lnUsePerFile, lcTextExt, lcUsePerDir, llIsClass, llIsForm
      IF INLIST(LOWER(EVL(tcType,'')), '-c', 'c', '-t', 't')
         RETURN tc_InputFile
      ENDIF
      llIsClass = INLIST(lcExt, This.getCfgValue('c_VC2'), "VCX")
      llIsForm  = INLIST(lcExt, This.getCfgValue('c_SC2'), "SCX")
      IF llIsClass
         lnRedirect   = This.getCfgValue('n_RedirectClassType')
         lnUsePerFile = This.getCfgValue('n_UseClassPerFile')
         lcTextExt    = This.getCfgValue('c_VC2')
         lcUsePerDir  = 'l_UseClassPerDir'
      ELSE
         IF llIsForm
            lnRedirect   = This.getCfgValue('n_RedirectFormType')
            lnUsePerFile = This.getCfgValue('n_UseFormPerFile')
            lcTextExt    = This.getCfgValue('c_SC2')
            lcUsePerDir  = 'l_UseFormPerDir'
         ELSE
            RETURN tc_InputFile
         ENDIF
      ENDIF
      IF lnRedirect = 2 AND EMPTY(This.c_ClassToConvert) AND lnUsePerFile > 0 ;
            AND '.' $ JUSTSTEM(JUSTFNAME(tc_InputFile))
         This.c_ClassToConvert = LOWER( JUSTEXT( JUSTSTEM( tc_InputFile ) ) )
         tc_InputFile = LOWER( JUSTPATH( tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( tc_InputFile ) ) + '.' + JUSTEXT( tc_InputFile ) )
         IF lnUsePerFile = 2
            tc_InputFile = LOWER( JUSTPATH( tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( tc_InputFile ) ) + '.' + JUSTEXT( tc_InputFile ) )
         ENDIF
         This.c_ClassOperationType = IIF( This.isBinToTextMode(tcType), 'E', 'I')
      ENDIF
      IF This.c_ClassOperationType = 'I'
         IF llIsClass AND INLIST(lcExt, This.getCfgValue('c_VC2'), "VCX")
            IF lnUsePerFile = 2
               tc_InputFile = ADDBS( This.getPerFileDir( tc_InputFile, lcTextExt, This.getCfgFlag(lcUsePerDir), lnUsePerFile ) ) ;
                  + JUSTSTEM(tc_InputFile) + '.*.' + This.c_ClassToConvert + '.' + lcTextExt
               IF ADIR(laFiles, tc_InputFile) = 1
                  tc_InputFile = FULLPATH( laFiles(1,1), tc_InputFile )
               ENDIF
            ELSE
               tc_InputFile = This.getPerFileOutputPath( tc_InputFile, This.c_ClassToConvert, lcTextExt, ;
                  This.getCfgFlag(lcUsePerDir), lnUsePerFile )
            ENDIF
         ENDIF
         IF llIsForm AND INLIST(lcExt, This.getCfgValue('c_SC2'), "SCX")
            IF lnUsePerFile = 2
               tc_InputFile = ADDBS( This.getPerFileDir( tc_InputFile, lcTextExt, This.getCfgFlag(lcUsePerDir), lnUsePerFile ) ) ;
                  + JUSTSTEM(tc_InputFile) + '.*.' + This.c_ClassToConvert + '.' + lcTextExt
               IF ADIR(laFiles, tc_InputFile) = 1
                  tc_InputFile = FULLPATH( laFiles(1,1), tc_InputFile )
               ENDIF
            ELSE
               tc_InputFile = This.getPerFileOutputPath( tc_InputFile, This.c_ClassToConvert, lcTextExt, ;
                  This.getCfgFlag(lcUsePerDir), lnUsePerFile )
            ENDIF
         ENDIF
      ENDIF
      RETURN tc_InputFile
   ENDFUNC

   PROTECTED FUNCTION buildExecuteContext
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
      LPARAMETERS tcLogPath
      This.c_LogFile = tcLogPath
      IF This.getCfgValue('n_Debug') > 0 THEN
         ERASE ( This.c_LogFile )
      ENDIF
   ENDPROC

   PROTECTED PROCEDURE setRecompileDirectory
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
      LOCAL loFrm_Main AS frm_main OF 'frm_main.PRG'
      loFrm_Main = NewObject( 'frm_main', 'frm_main.prg' , null, This)
      loFrm_Main.SHOW()
      READ EVENTS
      RETURN 0
   ENDFUNC

   PROTECTED FUNCTION executeBin3Prg
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
      LPARAMETERS lnCodError, tcType, toEx, loSession, loLang, laDirInfo
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
      * tc_InputFile  Full path of file/directory to convert (empty = show configuration reference form)
      * tcType        Optional: *, *-, Bin3Prg, Prg3Bin, -BIN2PRG, -PRG2BIN (internal/API use)
      * toCfg         Optional configuration object from newConfig()
      * toEx          Error object (by reference)
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
      * tcMode                    (v? IN    ) 'FULL' (default) | 'LOAD_ONLY'
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, toModulo, toEx AS EXCEPTION, tlRelanzarError, tcOriginalFileName, tcMode

      TRY
         LOCAL lnCodError, lcErrorInfo, laDirFile(1,5), lcExtension, lnFileCount, laFiles(1,1), I ;
            , ltFilestamp, lcExtA, lcExtB, laEvents(1,1), lcForceAttribs, lnIDInputFile, llLoadOnly, lc_OldSetNotify, lc_BaseFile ;
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

                     IF '.' $ JUSTSTEM(.c_InputFile)
                        .c_InputFile    = lc_BaseFile
                     ENDIF

                  CASE .getCfgValue('n_UseClassPerFile') = 2 AND INLIST(lcExtension,.getCfgValue('c_VC2'))
                     IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                        lc_BaseFile = .c_InputFile
                     ELSE
                        lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                     ENDIF

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

                     IF '.' $ JUSTSTEM(.c_InputFile)
                        .c_InputFile    = lc_BaseFile
                     ENDIF

                  CASE .getCfgValue('n_UseFormPerFile') = 2 AND INLIST(lcExtension,.getCfgValue('c_SC2'))
                     IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                        lc_BaseFile = .c_InputFile
                     ELSE
                        lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                     ENDIF

                     IF '.' $ JUSTSTEM(.c_InputFile)
                        .c_InputFile    = lc_BaseFile
                     ENDIF

                  ENDCASE
               ENDIF

               *-- DC2 OPTIMIZATION: CHECK WHETHER BASE FILE WAS PROCESSED TO SKIP REPROCESSING
               IF INLIST(lcExtension,"DBC",.getCfgValue('c_DC2'));
                     AND .getCfgValue('n_UseFilesPerDBC') > 0 AND .getCfgValue('l_RedirectFilePerDBCToMain');
                     AND .getCfgValue('n_UseFilesPerDBC') = 1

                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF

               ENDIF

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

               lnFileCount = ADIR( laFiles, FORCEEXT( .c_InputFile, '*' ), '', 1 )
               STORE {//::} TO .t_InputFile_TimeStamp, .t_OutputFile_TimeStamp, ltFilestamp

               IF lnFileCount > 0 THEN
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

                     .t_OutputFile_TimeStamp =   MAX( .t_OutputFile_TimeStamp, ltFilestamp )
                  ENDIF
               ENDIF

               DO CASE
               CASE INLIST(lcExtension,"VCX",.getCfgValue('c_VC2')) AND .getCfgValue('n_UseClassPerFile') = 0 AND .getCfgValue('n_OptimizeByFilestamp') = 1 AND .t_InputFile_TimeStamp < .t_OutputFile_TimeStamp
                  .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )

               CASE INLIST(lcExtension,"VCX",.getCfgValue('c_VC2')) AND .getCfgValue('n_UseClassPerFile') = 0 AND .getCfgValue('n_OptimizeByFilestamp') = 2 AND .t_InputFile_TimeStamp = .t_OutputFile_TimeStamp
                  .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )

               CASE INLIST(lcExtension,"SCX",.getCfgValue('c_SC2')) AND .getCfgValue('n_UseFormPerFile') = 0 AND .getCfgValue('n_OptimizeByFilestamp') = 1 AND .t_InputFile_TimeStamp < .t_OutputFile_TimeStamp
                  .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )

               CASE INLIST(lcExtension,"SCX",.getCfgValue('c_SC2')) AND .getCfgValue('n_UseFormPerFile') = 0 AND .getCfgValue('n_OptimizeByFilestamp') = 2 AND .t_InputFile_TimeStamp = .t_OutputFile_TimeStamp
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
                  .writeLog(loConversor.c_TextLog)

                  IF NOT EMPTY(loConversor.c_TextErr) THEN
                     .writeErrorLog( REPLICATE( '-', 100 ), 1 )
                     .writeErrorLog( loLang.C_ERRORS_FOUND_IN_FILE_LOC + ' [' + .c_InputFile + '] ' )
                     .writeErrorLog( loConversor.c_TextErr )
                     .writeErrorLog( )
                  ENDIF
               ENDCASE

               .normalizeFileCapitalization()
            ELSE
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

               loConversor.loadModule( @toModulo, .F., THIS )

               IF loConversor.l_Error THEN
                  .l_Error = .T.
               ENDIF

               .writeLog()
               .writeLog(loConversor.c_TextLog)

               IF NOT EMPTY(loConversor.c_TextErr) THEN
                  .writeErrorLog( REPLICATE( '-', 100 ), 1 )
                  .writeErrorLog( loLang.C_ERRORS_FOUND_IN_FILE_LOC + ' [' + .c_InputFile + '] ' )
                  .writeErrorLog( loConversor.c_TextErr )
                  .writeErrorLog( )
               ENDIF
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


   PROCEDURE formatConfigReferenceText
      This.ensureCfg()
      RETURN This.o_Cfg.formatConfigReferenceText()
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

      RETURN This.convert( tc_InputFile, @toModulo, @toEx, tlRelanzarError, tcOriginalFileName, 'LOAD_ONLY' )
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
