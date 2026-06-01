
#INCLUDE 'foxbin2prg.h'

DEFINE CLASS c_foxbin2prg AS SESSION
   _MEMBERDATA = [<VFPData>] ;
      + [<memberdata name="updateprogressbar" display="updateProgressbar"/>] ;
      + [<memberdata name="a_processedfiles" display="a_ProcessedFiles"/>] ;
      + [<memberdata name="clearprocessedfiles" display="clearProcessedFiles"/>] ;
      + [<memberdata name="convert" display="convert"/>] ;
      + [<memberdata name="c_fb2prg_exe_version" display="c_FB2PRG_EXE_Version"/>] ;
      + [<memberdata name="c_curdir" display="c_CurDir"/>] ;
      + [<memberdata name="c_texterr" display="c_TextErr"/>] ;
      + [<memberdata name="c_foxbin2prg_fullpath" display="c_Foxbin2prg_FullPath"/>] ;
      + [<memberdata name="c_foxbin2prg_configfile" display="c_Foxbin2prg_ConfigFile"/>] ;
      + [<memberdata name="c_inputfile" display="c_InputFile"/>] ;
      + [<memberdata name="c_language" display="c_Language"/>] ;
      + [<memberdata name="c_originalfilename" display="c_OriginalFileName"/>] ;
      + [<memberdata name="c_outputfile" display="c_OutputFile"/>] ;
      + [<memberdata name="c_type" display="c_Type"/>] ;
      + [<memberdata name="c_errorlogfile" display="c_ErrorLogFile"/>] ;
      + [<memberdata name="c_logfile" display="c_LogFile"/>] ;
      + [<memberdata name="c_recompile" display="c_Recompile"/>] ;
      + [<memberdata name="c_textlog" display="c_TextLog"/>] ;
      + [<memberdata name="c_db2" display="c_DB2"/>] ;
      + [<memberdata name="c_dc2" display="c_DC2"/>] ;
      + [<memberdata name="c_fr2" display="c_FR2"/>] ;
      + [<memberdata name="c_lb2" display="c_LB2"/>] ;
      + [<memberdata name="c_mn2" display="c_MN2"/>] ;
      + [<memberdata name="c_pj2" display="c_PJ2"/>] ;
      + [<memberdata name="c_sc2" display="c_SC2"/>] ;
      + [<memberdata name="c_vc2" display="c_VC2"/>] ;
      + [<memberdata name="c_fk2" display="c_FK2"/>] ;
      + [<memberdata name="c_me2" display="c_ME2"/>] ;
      + [<memberdata name="changefileattribute" display="changeFileAttribute"/>] ;
      + [<memberdata name="changefiletime" display="changeFileTime"/>] ;
      + [<memberdata name="compilefoxprobinary" display="compileFoxProBinary"/>] ;
      + [<memberdata name="dobackup" display="doBackup"/>] ;
      + [<memberdata name="execute" display="execute"/>] ;
      + [<memberdata name="evaluate_full_pjx" display="evaluate_Full_PJX"/>] ;
      + [<memberdata name="evaluate_full_pj2" display="evaluate_Full_PJ2"/>] ;
      + [<memberdata name="dowriteerrorlog" display="doWriteErrorLog"/>] ;
      + [<memberdata name="evaluateconfiguration" display="evaluateConfiguration"/>] ;
      + [<memberdata name="exception2str" display="exception2Str"/>] ;
      + [<memberdata name="filenamefoundinfilter" display="filenameFoundInFilter"/>] ;
      + [<memberdata name="comparedfilesareequal" display="comparedFilesAreEqual"/>] ;
      + [<memberdata name="changelanguage" display="changeLanguage"/>] ;
      + [<memberdata name="get_dirsettings" display="get_DirSettings"/>] ;
      + [<memberdata name="get_l_cfg_cachedaccess" display="get_l_CFG_CachedAccess"/>] ;
      + [<memberdata name="get_l_configevaluated" display="get_l_ConfigEvaluated"/>] ;
      + [<memberdata name="get_textfilenames" display="get_TextFileNames"/>] ;
      + [<memberdata name="get_ext2fromext" display="get_Ext2FromExt"/>] ;
      + [<memberdata name="get_program_header" display="get_PROGRAM_HEADER"/>] ;
      + [<memberdata name="get_separatedlineandcomment" display="get_SeparatedLineAndComment"/>] ;
      + [<memberdata name="get_processed" display="get_Processed"/>] ;
      + [<memberdata name="loadprogressbarform" display="loadProgressbarForm"/>] ;
      + [<memberdata name="unloadprogressbarform" display="unloadProgressbarForm"/>] ;
      + [<memberdata name="run_aftercreatetable" display="run_AfterCreateTable"/>] ;
      + [<memberdata name="run_aftercreate_db2" display="run_AfterCreate_DB2"/>] ;
      + [<memberdata name="l_autoclearprocessedfiles" display="l_AutoClearProcessedFiles"/>] ;
      + [<memberdata name="l_cancelwithesckey" display="l_CancelWithEscKey"/>] ;
      + [<memberdata name="l_cfg_cachedaccess" display="l_CFG_CachedAccess"/>] ;
      + [<memberdata name="l_classperfilecheck" display="l_ClassPerFileCheck"/>] ;
      + [<memberdata name="l_clearuniqueid" display="l_ClearUniqueID"/>] ;
      + [<memberdata name="l_cleardbflastupdate" display="l_ClearDBFLastUpdate"/>] ;
      + [<memberdata name="n_debug" display="n_Debug"/>] ;
      + [<memberdata name="l_removenullcharsfromcode" display="l_RemoveNullCharsFromCode"/>] ;
      + [<memberdata name="l_removezordersetfromprops" display="l_RemoveZOrderSetFromProps"/>] ;
      + [<memberdata name="l_error" display="l_Error"/>] ;
      + [<memberdata name="l_errors" display="l_Errors"/>] ;
      + [<memberdata name="l_main_cfg_loaded" display="l_Main_CFG_Loaded"/>] ;
      + [<memberdata name="l_methodsort_enabled" display="l_MethodSort_Enabled"/>] ;
      + [<memberdata name="c_backgroundimage" display="c_BackgroundImage"/>] ;
      + [<memberdata name="n_optimizebyfilestamp" display="n_OptimizeByFilestamp"/>] ;
      + [<memberdata name="l_processfiles" display="l_ProcessFiles"/>] ;
      + [<memberdata name="l_propsort_enabled" display="l_PropSort_Enabled"/>] ;
      + [<memberdata name="l_recompile" display="l_Recompile"/>] ;
      + [<memberdata name="l_redirectclassperfiletomain" display="l_RedirectClassPerFileToMain"/>] ;
      + [<memberdata name="l_reportsort_enabled" display="l_ReportSort_Enabled"/>] ;
      + [<memberdata name="l_showerrors" display="l_ShowErrors"/>] ;
      + [<memberdata name="n_showprogressbar" display="n_ShowProgressbar"/>] ;
      + [<memberdata name="l_stdouthabilitado" display="l_StdOutHabilitado"/>] ;
      + [<memberdata name="l_test" display="l_Test"/>] ;
      + [<memberdata name="n_useclassperfile" display="n_UseClassPerFile"/>] ;
      + [<memberdata name="n_cfg_actual" display="n_CFG_Actual"/>] ;
      + [<memberdata name="n_existecapitalizacion" display="n_ExisteCapitalizacion"/>] ;
      + [<memberdata name="n_fb2prg_version" display="n_FB2PRG_Version"/>] ;
      + [<memberdata name="n_filehandle" display="n_FileHandle"/>] ;
      + [<memberdata name="n_forcewriteifreadonly" display="n_ForceWriteIfReadOnly"/>] ;
      + [<memberdata name="n_order_view_fields" display="n_Order_View_Fields"/>] ;
      + [<memberdata name="n_processedfiles" display="n_ProcessedFiles"/>] ;
      + [<memberdata name="n_processedfilescount" display="n_ProcessedFilesCount"/>] ;
      + [<memberdata name="normalizefilecapitalization" display="normalizeFileCapitalization"/>] ;
      + [<memberdata name="o_conversor" display="o_Conversor"/>] ;
      + [<memberdata name="o_frm_avance" display="o_Frm_Avance"/>] ;
      + [<memberdata name="o_fso" display="o_FSO"/>] ;
      + [<memberdata name="o_wsh" display="o_WSH"/>] ;
      + [<memberdata name="o_configuration" display="o_Configuration"/>] ;
      + [<memberdata name="n_pjx_conversion_support" display="n_PJX_Conversion_Support"/>] ;
      + [<memberdata name="n_vcx_conversion_support" display="n_VCX_Conversion_Support"/>] ;
      + [<memberdata name="n_scx_conversion_support" display="n_SCX_Conversion_Support"/>] ;
      + [<memberdata name="n_frx_conversion_support" display="n_FRX_Conversion_Support"/>] ;
      + [<memberdata name="n_lbx_conversion_support" display="n_LBX_Conversion_Support"/>] ;
      + [<memberdata name="n_mnx_conversion_support" display="n_MNX_Conversion_Support"/>] ;
      + [<memberdata name="n_dbc_conversion_support" display="n_DBC_Conversion_Support"/>] ;
      + [<memberdata name="n_dbf_conversion_support" display="n_DBF_Conversion_Support"/>] ;
      + [<memberdata name="c_dbf_conversion_included" display="c_DBF_Conversion_Included"/>] ;
      + [<memberdata name="c_dbf_conversion_excluded" display="c_DBF_Conversion_Excluded"/>] ;
      + [<memberdata name="get_filesfromdirectory" display="get_FilesFromDirectory"/>] ;
      + [<memberdata name="readinputvfpparams" display="readInputVFPParams"/>] ;
      + [<memberdata name="renamefile" display="renameFile"/>] ;
      + [<memberdata name="renametmpfile2tx2file" display="renameTmpFile2Tx2File"/>] ;
      + [<memberdata name="set_line" display="set_Line"/>] ;
      + [<memberdata name="errout" display="errOut"/>] ;
      + [<memberdata name="stdout" display="stdOut"/>] ;
      + [<memberdata name="hassupport_bin2prg" display="hasSupport_Bin2Prg"/>] ;
      + [<memberdata name="hassupport_prg2bin" display="hasSupport_Prg2Bin"/>] ;
      + [<memberdata name="t_inputfile_timestamp" display="t_InputFile_TimeStamp"/>] ;
      + [<memberdata name="t_outputfile_timestamp" display="t_OutputFile_TimeStamp"/>] ;
      + [<memberdata name="updateprocessedfile" display="updateProcessedFile"/>] ;
      + [<memberdata name="writeerrorlog" display="writeErrorLog"/>] ;
      + [<memberdata name="writeerrorlog_flush" display="writeErrorLog_Flush"/>] ;
      + [<memberdata name="writelog" display="writeLog"/>] ;
      + [</VFPData>]
   *!* ;&& SF -> String to long
   *!*         + [<memberdata name="a_processedfiles" display="a_ProcessedFiles"/>] ;
   *!*         + [<memberdata name="l_oldfilesperdbc" display="l_OldFilesPerDBC"/>] ;
   *!*         + [<memberdata name="n_usefilesperdbc" display="n_UseFilesPerDBC"/>] ;
   *!*         + [<memberdata name="l_redirectfileperdbctomain" display="l_RedirectFilePerDBCToMain"/>] ;
   *!*         + [<memberdata name="l_itemperdbccheck" display="l_ItemPerDBCCheck"/>] ;
   *!*         + [<memberdata name="l_dbf_binchar_base64" display="l_DBF_BinChar_Base64"/>] ;
   *!*         + [<memberdata name="l_dbf_includedeleted" display="l_DBF_IncludeDeleted"/>] ;
   *!*         + [<memberdata name="c_language_in" display="c_Language_In"/>] ;
   *!*         + [<memberdata name="writelog_flush" display="writeLog_Flush"/>] ;
   *!*         + [<memberdata name="n_checkfileinpath" display="n_CheckFileInPath"/>] ;
   *!*         + [<memberdata name="n_inhibitinheritance" display="n_AllowInheritance"/>] ;
   *!*         + [<memberdata name="l_singleconfig" display="l_SingleConfig"/>] ;
   *!*         + [<memberdata name="c_singleconfig_folder" display="c_SingleConfig_Folder"/>] ;
   *!*         + [<memberdata name="n_debugp" display="n_DebugP"/>] ;
   *!*         + [<memberdata name="l_useformsettings" display="l_UseFormSettings"/>] ;
   *!*         + [<memberdata name="n_useformperfile" display="n_UseFormPerFile"/>] ;
   *!*         + [<memberdata name="l_redirectformperfiletomain" display="l_RedirectFormPerFileToMain"/>] ;
   *!*         + [<memberdata name="n_redirectformtype" display="n_RedirectFormType"/>] ;
   *!*         + [<memberdata name="l_formperfilecheck" display="l_FormPerFileCheck"/>] ;

   DIMENSION a_ProcessedFiles(1, 6)
   PROTECTED n_CFG_Actual, l_Main_CFG_Loaded, o_Configuration, l_CFG_CachedAccess
   *--
   n_FB2PRG_Version                = DN_FB2PRG_VERSION
   c_FB2PRG_Version_Real           = DC_FB2PRG_VERSION_REAL
   *--
   c_Language                      = ''            && EN, FR, ES, DE
   c_Language_In                   = '(auto)'
   c_SimulateError                 = ''            && SIMERR_I0, SIMERR_I1, SIMERR_O1
   c_loc_processing_file           = ''
   c_loc_process_progress          = ''
   c_FB2PRG_EXE_Version            = ''
   c_Foxbin2prg_FullPath           = ''
   c_Foxbin2prg_ConfigFile         = ''
   c_CurDir                        = ''
   c_TempDir                       = SYS(2023)
   c_InputFile                     = ''
   c_ClassToConvert                = ''            && Guarda el nombre de la clase a convertir, indicada en tcInputFile como "archivo.vcx::clase"
   c_ClassOperationType            = ''            && (I)mport o (E)xport. Se usa solo para manejar clases individuales.
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
   l_CFG_CachedAccess              = .F.
   n_CFG_EvaluateFromParam         = 0
   n_Debug                         = 0
   n_DebugP                        = .NULL.
   n_BodyDevInfo                   = 0             && Indica si se debe incluir el campo DevInfo en el cuerpo de los pjx/pj2
   l_Error                         = .F.           && Indicador de errores del proceso actual
   l_Errors                        = .F.           && Indicador de error de la sesión actual, acumulativo de todos los procesos
   c_TextErr                       = ''
   l_Test                          = .F.
   l_SingleConfig                  = .F.           && There is only one single configuration file in use
   l_ShowErrors                    = .T.
   n_ShowProgressbar               = 1
   n_ForceWriteIfReadOnly          = 0
   l_AutoClearProcessedFiles       = .T.           && Por defecto limpia archivos procesados entre ejecución y ejecución
   l_ProcessFiles                  = .T.           && Por defecto procesa los archivos. En .F. sirve para obtener sus nombres sin reescribirlos.
   l_CancelWithEscKey              = .T.
   l_RemoveNullCharsFromCode       = .T.
   l_RemoveZOrderSetFromProps      = .F.
   l_Recompile                     = .T.
   n_PRG_Compat_Level              = 0             && 0=COMPATIBLE WITH FoxBin2Prg v1.19.49 and earlier, 1=Include HELPSTRING
   n_ExcludeDBFAutoincNextval      = 0

   * additional options controlling
   * - splitt of DBC separated from VCX/SCX
   * - new operations of DBF
   l_OldFilesPerDBC                = .T.
   n_UseFilesPerDBC                = 0
   l_RedirectFilePerDBCToMain      = .F.
   l_ItemPerDBCCheck               = .F.
   l_DBF_BinChar_Base64            = .T.
   l_DBF_IncludeDeleted            = .F.

   * additional options controlling
   * files in non subpath of the PJX
   n_CheckFileInPath               = 0
   n_PRG_Compat_Level              = 0             && 0=COMPATIBLE WITH FoxBin2Prg v1.19.49 and earlier, 1=Include HELPSTRING
   n_ExcludeDBFAutoincNextval      = 0

   n_InhibitInheritance            = 0
   n_UseClassPerFile               = 0
   l_RedirectClassPerFileToMain    = .F.
   n_RedirectClassType             = 0             && 0=Redireccionar Todas las clases, 1=Redireccionar solo la clase indicada
   l_ClassPerFileCheck             = .F.
   l_UseFormSettings               = .F.
   n_UseFormPerFile                = 0
   l_RedirectFormPerFileToMain     = .F.
   n_RedirectFormType              = 0
   l_FormPerFileCheck              = .F.
   l_NoTimestamps                  = .T.
   c_BackgroundImage               = ''
   l_ClearUniqueID                 = .T.
   l_ClearDBFLastUpdate            = .T.
   n_OptimizeByFilestamp           = 0
   l_MethodSort_Enabled            = .T.           && Para Unit Testing se puede cambiar a .F. para buscar diferencias
   l_PropSort_Enabled              = .T.           && Para Unit Testing se puede cambiar a .F. para buscar diferencias
   l_ReportSort_Enabled            = .F.           && Para Unit Testing. 11/09/2015 - Cambiad a .F. porque cambia el ZOrder de los objetos (Ryan Harris)
   l_StdOutHabilitado              = .T.
   l_Main_CFG_Loaded               = .F.
   n_ExtraBackupLevels             = 1
   n_ClassTimeStamp                = 1130668032    && 2013/11/04 20:00:00
   n_CFG_Actual                    = 0
   n_ID                            = 0
   n_FileHandle                    = 0
   n_Order_View_Fields             = 1
   n_ProcessedFiles                = 0             && Contador usado para los archivos file.class.ext
   n_ProcessedFilesCount           = 0             && Contador genérico de procesados
   o_Conversor                     = .NULL.
   o_Frm_Avance                    = .NULL.
   o_WSH                           = .NULL.
   o_FSO                           = .NULL.            && Scripting.FileSystemObject
   o_TextStream                    = .NULL.            && Scripting.TextStream
   o_FNC                           = .NULL.            && Filename_caps object
   o_Configuration                 = .NULL.
   run_AfterCreateTable            = ''
   run_AfterCreate_DB2             = ''
   c_PJ2                           = 'PJ2'         && PJX
   c_VC2                           = 'VC2'         && VCX
   c_SC2                           = 'SC2'         && SCX
   c_FR2                           = 'FR2'         && FRX
   c_LB2                           = 'LB2'         && LBX
   c_MN2                           = 'MN2'         && MNX
   c_DB2                           = 'DB2'         && DBF
   c_DC2                           = 'DC2'         && DBC
   c_FK2                           = 'FK2'         && FKY
   c_ME2                           = 'ME2'         && MEM
   n_PJX_Conversion_Support        = 2
   n_VCX_Conversion_Support        = 2
   n_SCX_Conversion_Support        = 2
   n_FRX_Conversion_Support        = 2
   n_LBX_Conversion_Support        = 2
   n_MNX_Conversion_Support        = 2
   n_DBC_Conversion_Support        = 2
   n_DBF_Conversion_Support        = 1
   n_FKY_Conversion_Support        = 1
   n_MEM_Conversion_Support        = 1
   c_DBF_Conversion_Included       = ''
   c_DBF_Conversion_Excluded       = ''

   cOutputFolder                   = ''            && the folder to write files to (blank = same folder as source file)
   n_HomeDir                       = 1             && 0 = don't save HomeDir in PJ2, 1 = save HomeDir in PJ2

   *keep CodePage relavant information for binary sources
   i_CPID                          = 0 &&CPCURRENT(1)

   *!* more sophisticated control of inheritance for para file
   c_SingleConfig_Folder           = ''
   o_CFG                           = .NULL.
   l_AllowFolder                   = .T.

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

      This.declareDLL()

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

      && Directorio actual, que no necesariamente es donde está FoxBin2Prg
      This.c_CurDir                   = SYS(5) + CURDIR()

      This.c_Foxbin2prg_FullPath      = SUBSTR( lcSys16, lnPosProg )
      This.c_Foxbin2prg_ConfigFile    = EVL( tcCFG_File, FORCEEXT( This.c_Foxbin2prg_FullPath, 'CFG' ) )
      This.c_BackgroundImage          = This.get_AbsolutePath( ADDBS(JUSTPATH(This.c_Foxbin2prg_FullPath)) + 'foxbin2prg.jpg' )
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
      This.o_Configuration = CREATEOBJECT("COLLECTION")

      This.o_CFG           = CREATEOBJECT('CL_CFG')
      This.o_CFG.CopyFrom(THIS)
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
         This.o_Configuration    = .NULL.
         This.o_WSH              = .NULL.
         This.o_FSO              = .NULL.
         IF VARTYPE(_SCREEN.o_FoxBin2Prg_Lang) = "O" THEN
            _SCREEN.o_FoxBin2Prg_Lang = .NULL.
         ENDIF
      CATCH

      FINALLY
         This.o_FSO  = .NULL.
         This.o_WSH  = .NULL.
         This.o_FNC  = .NULL.
         *-- Funciones para changeFileAttributes
         CLEAR DLLS fb2p_SetFileAttributes, fb2p_GetFileAttributes
         *-- Funciones para escribir en StdOut
         CLEAR DLLS fb2p_GetStdHandle, fb2p_WriteFile
         *-- Funciones para changeFileTime
         CLEAR DLLS fb2p_SetFileTime, fb2p_GetFileAttributesEx, fb2p_LocalFileTimeToFileTime ;
            , fb2p_FileTimeToSystemTime, fb2p_SystemTimeToFileTime, fb2p_lopen, fb2p_lclose

      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE addProcessedFile
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFile                    (v? IN    ) Path del archivo (ej: 'C:\DESA\pruebas varias\lib.vcx')
      * tcInOutType               (v? IN    ) Archivo de entrada o de salida ("I"=Input file, "O"=Output file)
      * tcProcessed               (v? IN    ) Procesado ("P0"=Not Processed, "P1"=Processed)
      * tcHasErrors               (v? IN    ) Tuvo Errores ("E0"=No Errors, "E1"=Has Errors)
      * tcSupported               (v? IN    ) Archivo soportado ("S0"=Unsupported, "S1"=Supported)
      * tcExpanded                (v? IN    ) Tipo de archivo ("X0"=Normal file, "X1"=Expanded multipart file)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded

      LOCAL llAdded

      IF NOT EMPTY(tcFile) THEN
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            *-- Buscar si fue procesado antes
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
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFileMask                (v! IN    ) Fullpath del archivo del que se desea saber si se procesó
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
         *-- Si o_Frm_Avance se habilitó de forma externa, n_ShowProgressbar podría ser 0 para controlarlo desde fuera.
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            IF VARTYPE(.o_Frm_Avance) = "O" THEN
               *-- Cuando esta rutina se invoca desde el script, este método es el #1 y no puede cancelarse todavía
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
      _SCREEN.ADDPROPERTY( "o_FoxBin2Prg_Lang", CREATEOBJECT("CL_LANG", tcLanguageId) )
      *-- Localized properties
      This.c_Language                 = _SCREEN.o_FoxBin2Prg_Lang.C_LANGUAGE_LOC
      This.c_loc_processing_file      = _SCREEN.o_FoxBin2Prg_Lang.C_PROCESSING_LOC
      This.c_loc_process_progress     = _SCREEN.o_FoxBin2Prg_Lang.C_PROCESS_PROGRESS_LOC
   ENDPROC


   PROCEDURE clearProcessedFiles
      *-- Limpia las estadísticas de archivos procesados que se usan para optimizar
      *-- el procesamiento y evitar el reproceso de los mismos archivos, por ejemplo,
      *-- de un mismo VCX compartido por 2 ó más proyectos.
      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         .n_ProcessedFilesCount  = 0
         .n_ProcessedFiles       = 0
         DIMENSION .a_ProcessedFiles(1, 6)
         .a_ProcessedFiles       = ''
         *-- Los errores previos también se limpian.
         .l_Error                = .F.
         .l_Errors               = .F.
      ENDWITH
   ENDPROC


   PROCEDURE declareDLL

      *-- Funciones para escribir en StdOut
      DECLARE INTEGER 'GetStdHandle' IN WIN32API AS fb2p_GetStdHandle INTEGER nHandleType
      DECLARE INTEGER 'WriteFile'    IN WIN32API AS fb2p_WriteFile INTEGER hFile, STRING @ cBuffer, INTEGER nBytes, INTEGER @ nBytes2, INTEGER @ nBytes3
      *-- Funciones para changeFileTime
      DECLARE INTEGER 'SetFileTime'             IN WIN32API AS fb2p_SetFileTime INTEGER hFile, STRING  lpCreationTime, STRING  lpLastAccessTime, STRING  lpLastWriteTime
      DECLARE INTEGER 'GetFileAttributesEx'     IN Win32API AS fb2p_GetFileAttributesEx STRING  lpFileName, INTEGER fInfoLevelId, STRING  @ lpFileInformation
      DECLARE INTEGER 'SystemTimeToFileTime'    IN Win32API AS fb2p_SystemTimeToFileTime STRING  lpSYSTEMTIME, STRING  @ FILETIME
      DECLARE INTEGER 'FileTimeToSystemTime'    IN Win32API AS fb2p_FileTimeToSystemTime STRING FILETIME, STRING @ SYSTEMTIME
      DECLARE INTEGER 'LocalFileTimeToFileTime' IN Win32API AS fb2p_LocalFileTimeToFileTime STRING LOCALFILETIME, STRING @ FILETIME
      DECLARE INTEGER '_lopen'  IN Win32API AS fb2p_lopen STRING lpFileName, INTEGER iReadWrite
      DECLARE INTEGER '_lclose' IN Win32API AS fb2p_lclose INTEGER hFile
      *-- Funciones para changeFileAttributes
      DECLARE SHORT   'SetFileAttributes' IN Win32API AS fb2p_SetFileAttributes STRING tcFileName, INTEGER dwFileAttributes
      DECLARE INTEGER 'GetFileAttributes' IN Win32API AS fb2p_GetFileAttributes STRING tcFileName

   ENDPROC


   PROCEDURE get_AbsolutePath
      LPARAMETERS tc_InputFile, tc_FullPath

      *-- Ajusto la ruta si no es absoluta
      tc_InputFile    = EVL(tc_InputFile,'')
      tc_FullPath     = EVL(tc_FullPath, This.c_Foxbin2prg_FullPath)

      IF NOT EMPTY( JUSTEXT(tc_FullPath) ) THEN
         *-- Se indicó PATH+archivo.ext
         tc_FullPath = JUSTPATH(tc_FullPath)
      ENDIF

      tc_FullPath = ADDBS( tc_FullPath )

      IF     LEN(tc_InputFile) > 1 ;
            AND LEFT(LTRIM(tc_InputFile),2) <> '\\' ;
            AND SUBSTR(LTRIM(tc_InputFile),2,1) <> ':' THEN

         tc_InputFile    = FULLPATH(tc_InputFile, tc_FullPath)
      ENDIF

      RETURN tc_InputFile
   ENDPROC


   FUNCTION get_l_ConfigEvaluated
      RETURN This.l_Main_CFG_Loaded
   ENDFUNC


   FUNCTION get_l_CFG_CachedAccess
      RETURN This.l_CFG_CachedAccess
   ENDFUNC


   FUNCTION get_Processed
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taProcessed               (@!    OUT) Array donde se devolverá la información de los archivos de la máscara indicada
      * tcFileMask                (v? IN    ) Máscara de archivo a buscar (nombre, "*", "?")
      *---------------------------------------------------------------------------------------------------
      * ESTRUCTURA DEL ARRAY DEVUELTO:
      * col(1)    tcFile      - Path del archivo (ej: 'C:\DESA\pruebas varias\lib.vcx')
      * col(2)    tcInOutType - Archivo de entrada o de salida ("I"=Input file, "O"=Output file)
      * col(3)    tcProcessed - Procesado ("P0"=Not Processed, "P1"=Processed)
      * col(4)    tcHasErrors - Tuvo Errores ("E0"=No Errors, "E1"=Has Errors)
      * col(5)    tcSupported - Archivo soportado ("S0"=Unsupported, "S1"=Supported)
      * col(6)    tcExpanded  - Tipo de archivo ("X0"=Normal file, "X1"=Expanded multipart file)
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
      * Using Win32 Functions in Visual FoxPro
      * example=103
      * Changing file attributes
      LPARAMETERS  tcFileName, tcAttrib
      tcAttrib    = UPPER(tcAttrib)

      #DEFINE FILE_ATTRIBUTE_READONLY     1
      #DEFINE FILE_ATTRIBUTE_HIDDEN       2
      #DEFINE FILE_ATTRIBUTE_SYSTEM       4
      #DEFINE FILE_ATTRIBUTE_DIRECTORY    16
      #DEFINE FILE_ATTRIBUTE_ARCHIVE      32
      #DEFINE FILE_ATTRIBUTE_NORMAL       128
      #DEFINE FILE_ATTRIBUTE_TEMPORARY    512
      #DEFINE FILE_ATTRIBUTE_COMPRESSED   2048

      TRY
         LOCAL loEx AS EXCEPTION, dwFileAttributes, dwFileAttributes_Orig, lnRet
         lnRet   = 0

         * read current attributes for this file
         dwFileAttributes        = fb2p_GetFileAttributes(tcFileName)
         dwFileAttributes_Orig   = dwFileAttributes

         IF dwFileAttributes = -1
            * the file does not exist
            EXIT
         ENDIF

         IF dwFileAttributes > 0
            IF '+R' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_READONLY)
            ENDIF
            IF '+A' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_ARCHIVE)
            ENDIF
            IF '+S' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_SYSTEM)
            ENDIF
            IF '+H' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_HIDDEN)
            ENDIF
            IF '+D' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_DIRECTORY)
            ENDIF
            IF '+N' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_NORMAL)
            ENDIF
            IF '+T' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_TEMPORARY)
            ENDIF
            IF '+C' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_COMPRESSED)
            ENDIF

            IF '-R' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_READONLY) = FILE_ATTRIBUTE_READONLY
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_READONLY
            ENDIF
            IF '-A' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_ARCHIVE) = FILE_ATTRIBUTE_ARCHIVE
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_ARCHIVE
            ENDIF
            IF '-S' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_SYSTEM) = FILE_ATTRIBUTE_SYSTEM
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_SYSTEM
            ENDIF
            IF '-H' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_HIDDEN) = FILE_ATTRIBUTE_HIDDEN
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_HIDDEN
            ENDIF
            IF '-D' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_DIRECTORY) = FILE_ATTRIBUTE_DIRECTORY
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_DIRECTORY
            ENDIF
            IF '-N' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_NORMAL) = FILE_ATTRIBUTE_NORMAL
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_NORMAL
            ENDIF
            IF '-T' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_TEMPORARY) = FILE_ATTRIBUTE_TEMPORARY
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_TEMPORARY
            ENDIF
            IF '-C' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_COMPRESSED) = FILE_ATTRIBUTE_COMPRESSED
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_COMPRESSED
            ENDIF

            * setting selected attributes
            lnRet   = fb2p_SetFileAttributes(tcFileName, dwFileAttributes)
         ENDIF

      CATCH TO loEx
         THROW

      FINALLY
         This.writeLog( C_TAB + LOWER(PROGRAM()) + ' >> [' + tcFileName + '] lnRet = ' + TRANSFORM(lnRet) + ', dwFileAttributes_Orig = ' + TRANSFORM(dwFileAttributes_Orig) )
         RELEASE tcFileName, tcAttrib, dwFileAttributes
      ENDTRY

      RETURN lnRet
   ENDPROC


   PROCEDURE changeFileTime
      *---------------------------------------------------------------------------------------------------
      * CAMBIAR LA FECHA/HORA DE UN ARCHIVO
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFileName                (v! IN    ) Nombre del archivo
      * tcTimeType                (v? IN    ) C=Creation time, W=Last Write, A=Last Access
      * tnYear                    (v? IN    ) Año (>=1800)
      * tnMonth                   (v? IN    ) Mes (1-12)
      * tnDay                     (v? IN    ) Día (1-31)
      * tnHour                    (v? IN    ) Hora (0-23)
      * tnMinute                  (v? IN    ) Minuto (0-59)
      * tnSec                     (v? IN    ) Segundo (0-59)
      * tnThou                    (v? IN    ) ¿? (0-999)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS m.tcFileName, m.tcTimeType, m.tnYear, m.tnMonth, m.tnDay, m.tnHour, m.tnMinute, m.tnSec, m.tnThou

      #DEFINE OF_READWRITE     2

      LOCAL m.lpFileInformation, m.cS, m.nPar, m.fh, M.lpFileInformation, m.lpSysTime, m.cCreation ;
         , M.cLastAccess, m.cLastWrite, m.cBuffTime, m.cBuffTime1, M.cTT,m.nYear1, m.nMonth1, m.nDay1, m.nHour1 ;
         , M.nMinute1, m.nSec1, m.nThou1, llRetorno

      TRY
         m.nPar      = PCOUNT()

         IF m.nPar < 1
            EXIT
         ENDIF

         m.cTT       = IIF( m.nPar >= 2 AND VARTYPE(m.tcTimeType) = "C" AND NOT EMPTY(m.tcTimeType), LOWER(SUBSTR(m.tcTimeType,1,1)), "c" )
         m.nYear1    = IIF( m.nPar >= 3 AND VARTYPE(m.tnYear) $ "FIN" AND m.tnYear >= 1800, ROUND(m.tnYear,0), -1 )
         m.nMonth1   = IIF( m.nPar >= 4 AND VARTYPE(m.tnMonth) $ "FIN" AND BETWEEN(m.tnMonth,1,12), ROUND(m.tnMonth,0), -1 )
         m.nDay1     = IIF( m.nPar >= 5 AND VARTYPE(m.tnDay) $ "FIN" AND BETWEEN(m.tnDay,1,31), ROUND(m.tnDay,0), -1 )
         m.nHour1    = IIF( m.nPar >= 6 AND VARTYPE(m.tnHour) $ "FIN" AND BETWEEN(m.tnHour,0,23), ROUND(m.tnHour,0), -1 )
         m.nMinute1  = IIF( m.nPar >= 7 AND VARTYPE(m.tnMinute) $ "FIN" AND BETWEEN(m.tnMinute,0,59), ROUND(m.tnMinute,0), -1 )
         m.nSec1     = IIF( m.nPar >= 8 AND VARTYPE(m.tnSec) $ "FIN" AND BETWEEN(m.tnSec,0,59), ROUND(m.tnSec,0), -1 )
         m.nThou1    = IIF( m.nPar >= 9 AND VARTYPE(m.tnThou) $ "FIN" AND BETWEEN(m.tnThou,0,999), ROUND(m.tnThou,0), -1 )
         m.lpFileInformation = REPLICATE( CHR(0), 53 )   && just a buffer
         m.lpSysTime = REPLICATE( CHR(0), 16 )           && just a buffer

         IF fb2p_GetFileAttributesEx(m.tcFileName, 0, @lpFileInformation) = 0
            EXIT
         ENDIF

         m.cCreation   = SUBSTR(m.lpFileInformation,5,8)
         m.cLastAccess = SUBSTR(m.lpFileInformation,13,8)
         m.cLastWrite  = SUBSTR(m.lpFileInformation,21,8)
         m.cBuffTime   = IIF(m.cTT="w",m.cLastWrite, IIF(m.cTT="a",m.cLastAccess,m.cCreation))

         fb2p_FileTimeToSystemTime(m.cBuffTime, @lpSysTime)

         m.lpSysTime = ;
            IIF( m.nYear1 >= 0, BINTOC(m.nYear1,"2RS"), SUBSTR(m.lpSysTime,1,2) ) ;
            + IIF( m.nMonth1 >= 0, BINTOC(m.nMonth1,"2RS"), SUBSTR(m.lpSysTime,3,2) ) ;
            + SUBSTR(m.lpSysTime,5,2) ;
            + IIF( m.nDay1 >= 0, BINTOC(m.nDay1,"2RS"), SUBSTR(m.lpSysTime,7,2) ) ;
            + IIF( m.nHour1 >= 0, BINTOC(m.nHour1,"2RS"), SUBSTR(m.lpSysTime,9,2) ) ;
            + IIF( m.nMinute1 >= 0, BINTOC(m.nMinute1,"2RS"), SUBSTR(m.lpSysTime,11,2) ) ;
            + IIF( m.nSec1 >= 0, BINTOC(m.nSec1,"2RS"), SUBSTR(m.lpSysTime,13,2) ) ;
            + IIF( m.nThou1 >= 0, BINTOC(m.nThou1,"2RS"), SUBSTR(m.lpSysTime,15,2) )

         fb2p_SystemTimeToFileTime(m.lpSysTime,@cBuffTime)
         m.cBuffTime1    = m.cBuffTime
         fb2p_LocalFileTimeToFileTime(m.cBuffTime1,@cBuffTime)

         DO CASE
         CASE m.cTT = "w"
            m.cLastWrite=m.cBuffTime
         CASE m.cTT = "a"
            m.cLastAccess=m.cBuffTime
         OTHERWISE && "c"
            m.cCreation=m.cBuffTime
         ENDCASE

         m.fh = fb2p_lopen (m.tcFileName, OF_READWRITE)

         IF m.fh < 0
            EXIT
         ENDIF

         fb2p_SetFileTime (m.fh,m.cCreation, m.cLastAccess, m.cLastWrite)
         fb2p_lclose(m.fh)
         llRetorno = .T.
      ENDTRY

      RETURN llRetorno
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
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toEx                      (@? IN    ) Objeto Exception con información del error
      * tlRelanzarError           (v? IN    ) Indica si se debe relanzar el error
      * tcBakFile_1               (@?    OUT) Nombre del archivo backup 1 (vcx,scx,pjx,frx,lbx,dbf,dbc,mnx,vc2,sc2,pj2,etc)
      * tcBakFile_2               (@?    OUT) Nombre del archivo backup 2 (vct,sct,pjt,frt,lbt,fpt,dct,mnt,etc)
      * tcBakFile_3               (@?    OUT) Nombre del archivo backup 3 (cdx,dcx,etc)
      * tcOutputFile              (v? IN    ) Nombre del archivo de salida. Si no se indica se asume .c_OutputFile
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toEx, tlRelanzarError, tcBakFile_1, tcBakFile_2, tcBakFile_3, tcOutputFile

      #IF .F.
         LOCAL toFoxBin2Prg AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
      #ENDIF

      TRY
         LOCAL lcNext_Bak, lcExt_1, lcExt_2, lcExt_3, tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3, laDir(1,5) ;
            , loLang AS CL_LANG OF 'FOXBIN2PRG.PRG'
         STORE '' TO tcBakFile_1, tcBakFile_2, tcBakFile_3, lcExt_1, lcExt_2, lcExt_3 ;
            , tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3

         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            IF .n_ExtraBackupLevels > 0 THEN
               loLang          = _SCREEN.o_FoxBin2Prg_Lang
               tcOutputFile    = EVL( tcOutputFile, .c_OutputFile )
               lcNext_Bak      = .getNext_BAK( tcOutputFile )
               lcExt_1         = JUSTEXT( tcOutputFile )
               tcBakFile_1     = FORCEEXT(tcOutputFile, lcExt_1 + lcNext_Bak)

               DO CASE
               CASE INLIST( lcExt_1, .c_PJ2, .c_VC2, .c_SC2, .c_FR2, .c_LB2, .c_DB2, .c_DC2, .c_MN2, .c_FK2, .c_ME2, 'PJM' )
                  *-- Extensiones TEXTO

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

                     *-- COPIA BACKUP
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
         IF This.n_Debug > 0 AND _VFP.STARTMODE = 0
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
      IF (tlForceUnload OR This.n_ShowProgressbar <> 0) AND VARTYPE(This.o_Frm_Avance) = "O" THEN
         This.o_Frm_Avance.HIDE()
         This.o_Frm_Avance.RELEASE()
         This.o_Frm_Avance = .NULL.
      ENDIF
   ENDPROC


   PROCEDURE evaluateConfiguration
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcDontShowProgress        (v? IN    ) '1' para inhabilitar la barra de progreso
      * tcDontShowErrors          (v? IN    ) '1' para no mostrar mensajes de error (MESSAGEBOX)
      * tcNoTimestamps            (v? IN    ) Indica si se debe anular el timestamp ('1') o no ('0' ó vacío)
      * tcDebug                   (v? IN    ) '1' para habilitar modo debug (SOLO DESARROLLO)
      * tcRecompile               (v? IN    ) Indica recompilar ('1') el binario una vez regenerado. [Cambio de funcionamiento por defecto]
      *                                       Este cambio es para ganar tiempo, velocidad y seguridad. Además la recompilación que hace FoxBin2Prg
      *                                       se hace desde el directorio del archivo, con lo que las referencias relativas pueden
      *                                       generar errores de compilación, típicamente los #include.
      *                                       NOTA: Si en vez de '1' se indica un Path (p.ej, el del proyecto, se usará como base para recompilar
      * tcExtraBackupLevels       (v? IN    ) Indica la cantidad de niveles de backup a realizar (por defecto '1')
      * tcClearUniqueID           (v? IN    ) Indica si se debe limpiar el UniqueID ('1') o no ('0' ó vacío)
      * tcOptimizeByFilestamp     (v? IN    ) Indica si se debe optimizar por filestamp mayor o igual ('1'), solo igual ('2') o no optimizar ('0' ó vacío)
      * tc_InputFile              (v! IN    ) Nombre completo (fullpath) del archivo a convertir o nombre del directorio a procesar
      * tc_InputFile_Type         (@? IN    ) Tipo de archivo de entrada: (D)irectory, (F)ile, (Q)uerySupport
      * toParentCFG               (@? IN    ) (Uso interno) Si se pasa un valor, el nuevo CFG copiará primero sus valores de aquí para heredarlos
      * tl_ForceLog               (v? IN    ) Force logging of settings. used on cfg setting as object
      * tcCFG_File                (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
      *                                       Normal inheritance may or may not run, see setting InhibitInheritance
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tcDontShowProgress  , tcDontShowErrors, tcNoTimestamps       , tcDebug     , tcRecompile      ;
                , tcExtraBackupLevels , tcClearUniqueID , tcOptimizeByFilestamp, tc_InputFile, tcInputFile_Type ;
                , toParentCFG         , tl_ForceLog     , tcCFG_File

      #IF .F.
         LOCAL toParentCFG AS CL_CFG OF 'FOXBIN2PRG.PRG'
      #ENDIF

      LOCAL lcConfigFile, lcLockFile, llExiste_CFG_EnDisco, llLockFileExists, llFirstRead, I, lcConfData, lcExt, lcValue, lc_CFG_Path, lcConfigLine
      LOCAL lnDirs, llMasterEval, lcProp, llSetSingleConfig, lc_Foxbin2prg_ConfigFile, lc_InputPath
      LOCAL laConfig(1), laDirInfo(1,5), laDirs(1)

      LOCAL lo_CFG           AS CL_CFG OF 'FOXBIN2PRG.PRG' ;
          , loCFG_Manual     AS CL_CFG OF 'FOXBIN2PRG.PRG' ;
          , lo_Configuration AS COLLECTION ;
          , loLang           AS CL_LANG OF 'FOXBIN2PRG.PRG' ;
          , loEx             AS EXCEPTION

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'

            IF INLIST( TRANSFORM(tcDebug), '0', '1', '2' )
               .writeLog( C_TAB + ' > Parameter tcDebug: ' + tcDebug +;
                          IIF(ISNULL(This.n_DebugP), "", ", will be ignored, second use of parameter. Using: " + TRANSFORM(This.n_DebugP) )+CR_LF )

               IF ISNULL(This.n_DebugP)
                  This.n_Debug    = INT(VAL(tcDebug))
                  This.n_DebugP   = This.n_Debug
               ENDIF
            ENDIF

            STORE 0 TO lnKey
            llSetSingleConfig = .NULL.

            loLang           = _SCREEN.o_FoxBin2Prg_Lang
            tcRecompile      = EVL(tcRecompile, .c_Recompile)
            lo_Configuration = .o_Configuration

            *!* is a config file given by programm parameter
            IF Vartype(tcCFG_File)='C' AND !Empty(tcCFG_File)

               IF Empty(lo_Configuration.GetKey(tcCFG_File))

                  This.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC6+tcCFG_File )

                  .l_Main_CFG_Loaded  = .F.
                  *restore default
                  .o_CFG.CopyFrom(.o_CFG,THIS)

                  lc_Foxbin2prg_ConfigFile = .c_Foxbin2prg_ConfigFile
                  .c_Foxbin2prg_ConfigFile = tcCFG_File

                  .o_Configuration.REMOVE(-1)
                  .n_CFG_EvaluateFromParam = 0

                  .l_SingleConfig   = .F.
                  llSetSingleConfig = .T.

                  .writeLog( '> ' + UPPER(loLang.C_USING_THIS_SETTINGS_LOC) + ': ' + .c_Foxbin2prg_ConfigFile + ;
                     loLang.C_USING_THIS_SETTINGS_LOC1 )

               ELSE

                  This.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC6+tcCFG_File + loLang.C_USING_THIS_SETTINGS_LOC7+;
                                 ICase( This.n_InhibitInheritance=0, loLang.C_USING_THIS_SETTINGS_LOC2 ;
                                      , This.n_InhibitInheritance=1, loLang.C_USING_THIS_SETTINGS_LOC3 ;
                                      , This.n_InhibitInheritance=2, loLang.C_USING_THIS_SETTINGS_LOC4 ;
                                      , This.n_InhibitInheritance=3, loLang.C_USING_THIS_SETTINGS_LOC5 ;
                                      , " Failure."+CR_LF) )

               ENDIF
            ENDIF

            lcConfigFile        = .c_Foxbin2prg_ConfigFile
            tc_InputFile        = EVL(tc_InputFile, .c_InputFile)
            tcInputFile_Type    = EVL(tcInputFile_Type,'')

            IF VARTYPE(lcConfigFile) = "O"
               loCFG_Manual    = lcConfigFile  && lcConfigFile is an object CFG generated by get_DirSettings()
               toParentCFG     = loCFG_Manual
               lcConfigFile    = FULLPATH('Personalized-CFG-Object', tc_InputFile)
               loCFG_Manual.c_Foxbin2prg_ConfigFile    = 'Personalized-CFG-Object'
            ELSE
               loCFG_Manual    = .NULL.
            ENDIF

            IF VARTYPE(toParentCFG) <> 'O' OR llSetSingleConfig THEN
               toParentCFG         = .NULL.
            ENDIF

            IF ISNULL(toParentCFG) THEN
               .c_InputFile        = tc_InputFile
            ENDIF

            *-- Determino el tipo de InputFile (Archivo o Directorio)
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

               ELSE  &&Empty(tc_InputFile)
                  DO CASE
                  CASE tcInputFile_Type==C_FILETYPE_QUERYSUPPORT
                     lc_InputPath        = ""

                  CASE tcInputFile_Type==C_FILETYPE_DIRECTORY
                     lc_InputPath        = tc_InputFile

                  OTHERWISE
                     *                               tcInputFile_Type    = C_FILETYPE_FILE
                     lc_InputPath        = JUSTPATH(tc_InputFile)

                  ENDCASE
               ENDIF &&Empty(tc_InputFile)
            ENDIF

            *!* just the single config from programm parameter, or sub dirs of the config file given by the parameter
            *!* more sophisticated control of inheritance for para file
            lc_InputPath = UPPER(lc_InputPath)
            DO CASE
            CASE !.l_SingleConfig
               * just go ahead

            CASE .n_InhibitInheritance=0
               * read all

            CASE EMPTY(lc_InputPath)
               * whatever, just go ahead

            CASE .n_InhibitInheritance=3
               * read nothing
               EXIT

            CASE INLIST(.n_InhibitInheritance,1,2) AND lc_InputPath=.c_SingleConfig_Folder
               * just in the directory or subdirectory of the config file set by the parameter

            CASE .n_InhibitInheritance=1 AND .c_SingleConfig_Folder=lc_InputPath
               * just above the config file set by the parameter

            OTHERWISE
               EXIT

            ENDCASE


            IF .l_Main_CFG_Loaded AND NOT EMPTY(tc_InputFile) AND NOT tcInputFile_Type == C_FILETYPE_QUERYSUPPORT THEN
               IF .n_CFG_EvaluateFromParam = 1
                  * Si se indicó por parámetro (modo objeto), usarlo como Maestro
                  * Se saltea solo esta evaluación, y luego se usa la variable para determinar el Nº de CFG a usar.
                  .n_CFG_EvaluateFromParam = -1 && Luego se cambia por el Nº de CFG que corresponda.
               ELSE
                  IF tcInputFile_Type == C_FILETYPE_DIRECTORY THEN
                     * INDICÓ DIRECTORIO
                     IF ISNULL(loCFG_Manual)
                        *lcConfigFile   = FULLPATH( 'foxbin2prg.cfg', ADDBS(tc_InputFile) )
                        lcConfigFile = FULLPATH( JUSTFNAME(lcConfigFile), ADDBS(tc_InputFile) )
                     ENDIF
                  ELSE
                     * INDICÓ ARCHIVO
                     IF ISNULL(loCFG_Manual)
                        *lcConfigFile   = FULLPATH( 'foxbin2prg.cfg', tc_InputFile )
                        lcConfigFile = FULLPATH( JUSTFNAME(lcConfigFile), tc_InputFile )
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF

            lo_Configuration    = .o_Configuration
            .n_CFG_Actual       = 0
            .l_CFG_CachedAccess = .F.
            lc_CFG_Path         = UPPER( JUSTPATH( lcConfigFile ) )
            lcLockFile          = FORCEPATH(".FoxBin2Prg_Ignore",lc_CFG_Path)
            lo_CFG              = THIS

            *-- Búsqueda del CFG del PATH indicado en la caché
            IF .l_Main_CFG_Loaded

               IF lo_Configuration.COUNT > 0 THEN
                  IF .n_CFG_EvaluateFromParam > 1
                     * Especial: Si hay una configuración de bloqueo (CFG Manual), se usa
                     .n_CFG_Actual = .n_CFG_EvaluateFromParam
                  ELSE
                     * Normalmente se buscará el CFG del directorio analizado
                     .n_CFG_Actual       = lo_Configuration.GETKEY( lcConfigFile )   && 0 = No hay CFG cacheada, >0 = Hay CFG cacheada
                  ENDIF

                  IF .n_CFG_Actual > 0 THEN
                     lo_CFG          = lo_Configuration.ITEM(.n_CFG_Actual)
                     .l_CFG_CachedAccess = .T.

                     IF NOT ISNULL(loCFG_Manual)
                        * Si le paso un objeto CFG, prevalece sobre el guardado
                        lo_CFG.CopyFrom(@loCFG_Manual)
                     ENDIF
                  ENDIF
               ENDIF

               *-- Si no se pasó un CFG padre y no hay CFGs o no encuentra el del PATH indicado, analizo la jararquía
               *!* LScheffler 30.08.2023 only read path if no config by parameter
               IF ISNULL(llSetSingleConfig);
                     AND ISNULL(toParentCFG);
                     AND (lo_Configuration.COUNT = 0 OR .n_CFG_Actual = 0);
                     AND !This.c_Foxbin2prg_ConfigFile==tc_InputFile THEN
                  llMasterEval    = .T.
                  toParentCFG     = THIS

                  IF LEFT( lc_CFG_Path, 2 ) == '\\' THEN
                     *lnDirs = OCCURS( '\', lc_CFG_Path ) - 3
                     lnDirs  = OCCURS( '\', lc_CFG_Path ) - 2
                  ELSE
                     lnDirs  = OCCURS( '\', lc_CFG_Path )
                  ENDIF

                  IF lnDirs > 0 THEN
                     DIMENSION laDirs(lnDirs)

                     *-- Creo el array con los PATH intermedios
                     FOR I = lnDirs TO 1 STEP -1
                        IF m.I = lnDirs THEN
                           laDirs(m.I) = JUSTPATH(lc_CFG_Path)
                        ELSE
                           laDirs(m.I) = JUSTPATH(laDirs(m.I+1))
                        ENDIF
                     ENDFOR

                     IF lnDirs = 1 AND laDirs(1) = lc_CFG_Path
                        *-- Cuando no hay PATH intermedios, salteo esta parte para que más abajo lo agregue. 04/02/2016. FDBOZZO
                        *-- Ejemplo: Puede pasar cuando se convierte un archivo en C:\ u otro disco RAIZ.
                     ELSE
                        *-- Ahora evalúo las configuraciones de los PATH intermedios desde la raíz en adelante
                        *-- y mantengo la última configuración CFG Padre en toParentCFG para usarla como base.
                        FOR I = 1 TO lnDirs
                           .evaluateConfiguration( '', '', '', '', '', '', '', '', laDirs(m.I), C_FILETYPE_DIRECTORY, @toParentCFG)
                        ENDFOR
                     ENDIF

                     .l_CFG_CachedAccess = .F.
                     .n_CFG_Actual       = 0
                  ENDIF
               ENDIF
            ENDIF

            DO CASE
            CASE .n_CFG_Actual = 0
               *-- Si no se encontró un CFG cacheado, se busca si existe un archivo CFG en disco
               llExiste_CFG_EnDisco    = ( ADIR( laDirInfo, lcConfigFile ) = 1 )
               llLockFileExists        = ( ADIR( laDirInfo, lcLockFile ) = 1 )

               IF NOT llExiste_CFG_EnDisco
                  .l_CFG_CachedAccess = .T.   && Es cacheado porque sin archivo CFG usa config.interna
               ENDIF

            CASE ISNULL( .o_Configuration( .n_CFG_Actual ) )
               *-- Si existe una configuración y es NULL, es la predeterminada.
               *-- Este es el primer objeto CFG en cargarse cuando se inicializa FoxBin2Prg,
               *-- y corresponde a la ruta de instalación del EXE (ej: c:\desa\foxbin2prg\foxbin2prg.cfg)
               lo_CFG          = THIS

            ENDCASE

            IF .l_Main_CFG_Loaded
               IF .l_CFG_CachedAccess AND .n_CFG_Actual > 0 THEN
                  toParentCFG = lo_CFG
                  .writeLog( '> ' + UPPER(loLang.C_USING_THIS_SETTINGS_LOC) + ': ' + lo_CFG.c_Foxbin2prg_ConfigFile + '  => ' + tc_InputFile + ;
                     ' CFG_Actual:' + TRANSFORM(.n_CFG_Actual) + ICASE(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]')  )
               ELSE
                  lo_CFG  = CREATEOBJECT('CL_CFG')
                  lo_Configuration.ADD( lo_CFG, lcConfigFile )
                  .n_CFG_Actual   = lo_Configuration.COUNT

                  .writeLog( '> ' + UPPER(loLang.C_CACHING_CONFIG_FOR_DIRECTORY_LOC) + ': ' + lcConfigFile + ;
                     ' CFG_Actual:' + TRANSFORM(.n_CFG_Actual) + ICASE(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]')  )

                  IF NOT ISNULL(toParentCFG)
                     lo_CFG.CopyFrom(@toParentCFG)
                     toParentCFG = lo_CFG
                     *                               .writeLog( C_TAB + '- ' + loLang.C_INHERITING_FROM_LOC + ': ' + lo_CFG.c_Foxbin2prg_ConfigFile )
                     .writeLog( C_TAB + '- ' + loLang.C_INHERITING_FROM_LOC + ': ' + lo_Configuration.GETKEY(lo_Configuration.COUNT-1) )
                  ENDIF
                  llFirstRead = .T.
               ENDIF

            ELSE
               lo_Configuration.ADD( .NULL., lcConfigFile )    && La .Null. se carga solo cuando no hay Main_CFG_loaded todavía.
               .n_CFG_Actual   = lo_Configuration.COUNT
            ENDIF

            *check for lockfile
            IF .l_Main_CFG_Loaded AND llFirstRead AND llLockFileExists THEN
               lo_CFG.l_AllowFolder = .F.
               .writeLog( C_TAB + JUSTFNAME(lcLockFile) + loLang.C_LOCKINGFOLDER_LOC )
            ENDIF &&.l_Main_CFG_Loaded And llFirstRead AND llLockFileExists

            *-- NOTA: SOLO LOS QUE NO VENGAN DE PARÁMETROS EXTERNOS DEBEN ASIGNARSE A lo_CFG AQUÍ.
            IF llExiste_CFG_EnDisco AND NOT .l_CFG_CachedAccess AND lo_CFG.l_AllowFolder THEN
               .writeLog()
               .writeLog( '> ' + loLang.C_READING_CFG_VALUES_FROM_DISK_LOC + ':' )
               .writeLog( C_TAB + loLang.C_CONFIGFILE_LOC + ' ' + lcConfigFile )

               lo_CFG.c_Foxbin2prg_ConfigFile      = lcConfigFile

               FOR I = 1 TO ALINES( laConfig, FILETOSTR( lcConfigFile ), 1+4 )
                  .set_Line( @lcConfigLine, @laConfig, m.I )
                  .get_SeparatedLineAndComment( @lcConfigLine )
                  laConfig(m.I)       = LOWER( lcConfigLine )

                  DO CASE
                  CASE EMPTY( laConfig(m.I) ) OR INLIST( LEFT( laConfig(m.I), 1 ), '*', '#', '/', "'" )
                     LOOP

                     *settings for internal work, not processing
                     * Depricated:
                  CASE LEFT( laConfig(m.I), 17 ) == LOWER('DontShowProgress:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 18 ) )
                     IF NOT INLIST( TRANSFORM(tcDontShowProgress), '0', '1', '2' ) AND INLIST( lcValue, '0', '1', '2' ) THEN
                        tcDontShowProgress  = lcValue
                        lo_CFG.n_ShowProgressbar    = ICASE(lcValue=='0',1, lcValue=='1',0, 2)
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > tcDontShowProgress:         ' + TRANSFORM(tcDontShowProgress) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 9 ) == LOWER('Language:')
                     *-- CASO ESPECIAL: El lenguaje no se guarda en lo_CFG, porque es un seteo Global.
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 10 , IIF('&'+'&'$laConfig(m.I), AT('&'+'&', laConfig(m.I)) - 10, LEN(laConfig(m.I) ) ) ) )
                     .changeLanguage(lcValue)
                     lo_CFG.c_Language_In = m.lcValue
                     .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > Language:                   ' + TRANSFORM(lcValue) + ' (' + .c_Language + ')' )

                  CASE LEFT( laConfig(m.I), 16 ) == LOWER('ShowProgressbar:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 17 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_ShowProgressbar    = INT( VAL(lcValue) )
                        tcDontShowProgress  = ''
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > ShowProgressbar:            ' + lcValue )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 15 ) == LOWER('DontShowErrors:')
                     *-- Priorizo si tcDontShowErrors NO viene con "0" como parámetro, ya que los scripts vbs
                     *-- los utilizan para sobreescribir la configuración por defecto de foxbin2prg.cfg
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 16 ) )
                     IF NOT INLIST( TRANSFORM(tcDontShowErrors), '0', '1' ) AND INLIST( lcValue, '0', '1' ) THEN
                        tcDontShowErrors    = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > tcDontShowErrors:           ' + TRANSFORM(tcDontShowErrors) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 18 ) == LOWER('ExtraBackupLevels:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 19 ) )
                     IF NOT ISDIGIT( TRANSFORM(tcExtraBackupLevels) ) AND ISDIGIT( lcValue ) THEN
                        tcExtraBackupLevels = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > tcExtraBackupLevels:        ' + TRANSFORM(tcExtraBackupLevels) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 16 ) == LOWER('BackgroundImage:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 17 ) )
                     DO CASE
                     CASE EMPTY(lcValue)
                        lo_CFG.c_BackgroundImage    = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > BackgroundImage:            (Empty)' )

                     CASE ADIR( laDirInfo, lcValue ) > 0
                        lo_CFG.c_BackgroundImage    = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > BackgroundImage:            ' + TRANSFORM(lo_CFG.c_BackgroundImage) )

                     OTHERWISE
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > BackgroundImage:            File not found:  ' + TRANSFORM(lo_CFG.c_BackgroundImage) )

                     ENDCASE
                  CASE LEFT( laConfig(m.I), 6 ) == LOWER('Debug:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 7 ) )
                     IF NOT INLIST( TRANSFORM(tcDebug), '0', '1' ) AND INLIST( lcValue, '0', '1' ) THEN
                        IF ISNULL(This.n_DebugP) THEN
                           lo_CFG.n_Debug = INT(VAL(lcValue))
                        ENDIF &&ISNULL(This.n_DebugP)
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > Debug:                      ' + lcValue +;
                           IIF(ISNULL(This.n_DebugP), "", ", will be ignored, debug set via parameter. Using: " + TRANSFORM(This.n_DebugP) ) )
                     ENDIF

                     *** DH 2021-03-04: handle n_HomeDir configuration setting
                  CASE LEFT( laConfig(m.I), 8 ) == LOWER('HomeDir:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 9 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.n_HomeDir    = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > HomeDir:                    ' + TRANSFORM(lo_CFG.n_HomeDir) )
                     ENDIF
                     *** DH 2021-03-04: end of new code
                     **************
                     *Conversion operation by type
                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('PJX_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_PJX_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > PJX_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_PJX_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('VCX_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_VCX_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > VCX_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_VCX_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('SCX_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_SCX_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > SCX_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_SCX_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('FRX_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_FRX_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > FRX_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_FRX_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('LBX_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_LBX_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > LBX_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_LBX_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('MNX_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_MNX_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > MNX_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_MNX_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('DBF_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1', '2', '4', '8' ) THEN
                        lo_CFG.n_DBF_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > DBF_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_DBF_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('DBC_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_DBC_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > DBC_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_DBC_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('FKY_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.n_FKY_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > FKY_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_FKY_Conversion_Support) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 23 ) == LOWER('MEM_Conversion_Support:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 24 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.n_MEM_Conversion_Support = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > MEM_Conversion_Support:     ' + TRANSFORM(lo_CFG.n_MEM_Conversion_Support) )
                     ENDIF


                     *-------- setting for container files (not pjx) --------
                     *Classes and forms ( vcx / scx)

                     *!* Changed by: LScheffler 19.03.2023
                     * additional options controlling
                     * files in non subpath of the PJX
                  CASE LEFT( laConfig(m.I), 16 ) == LOWER('CheckFileInPath:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 17 ) )
                     IF INLIST( lcValue, '0', '1', '2', '3' ) THEN
                        lo_CFG.n_CheckFileInPath    = INT( VAL(lcValue) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > CheckFileInPath:            ' + TRANSFORM(lcValue) )
                     ENDIF
                     *!* /Changed by: LScheffler 19.03.2023

                     *!* Changed by: LScheffler 21.02.2021
                     *!* change date="{^2021-02-21,10:57:00}"
                     * additional options controlling
                     * - splitt of DBC separated from VCX/SCX
                     * - new operations of DBF
                     *VCX
                  CASE LEFT( laConfig(m.I), 16 ) == LOWER('UseClassPerFile:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 17 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_UseClassPerFile    = INT( VAL(lcValue) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > UseClassPerFile:            ' + TRANSFORM(lcValue) )
                        IF !lo_CFG.l_OldFilesPerDBC THEN
                           lo_CFG.n_UseFilesPerDBC             = lo_CFG.n_UseClassPerFile
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + '  => UseFilesPerDBC:           ' + TRANSFORM(lcValue) )
                        ENDIF
                        IF !lo_CFG.l_UseFormSettings THEN
                           lo_CFG.n_UseFormPerFile             = lo_CFG.n_UseClassPerFile
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + '  => UseFormPerFile:           ' + TRANSFORM(lcValue) )
                        ENDIF
                     ENDIF

                  CASE LEFT( laConfig(m.I), 27 ) == LOWER('RedirectClassPerFileToMain:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 28 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_RedirectClassPerFileToMain = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > RedirectClassPerFileToMain: ' + TRANSFORM(lcValue) )
                        IF !lo_CFG.l_OldFilesPerDBC THEN
                           lo_CFG.l_RedirectFilePerDBCToMain   = lo_CFG.l_RedirectClassPerFileToMain
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + '  => RedirectFilePerDBCToMain: ' + TRANSFORM(lcValue) )
                        ENDIF
                        IF !lo_CFG.l_UseFormSettings THEN
                           lo_CFG.l_RedirectFormPerFileToMain  = lo_CFG.l_RedirectClassPerFileToMain
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + '  => RedirectFormPerFileToMain ' + TRANSFORM(lcValue) )
                        ENDIF
                     ENDIF

                     *!* Changed by: LScheffler 04.3.2021
                     *!* change date="{^2021-03-04,13:12:00}"
                     * new value 2, just add one class
                  CASE LEFT( laConfig(m.I), 18 ) == LOWER('RedirectClassType:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 19 ) )
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_RedirectClassType  = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > RedirectClassType:          ' + TRANSFORM(lcValue) )
                        IF !lo_CFG.l_UseFormSettings THEN
                           lo_CFG.n_RedirectFormType           = lo_CFG.n_RedirectClassType
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + '  => RedirectFormType          ' + TRANSFORM(lcValue) )
                        ENDIF
                     ENDIF
                     *!* /Changed by: LScheffler 04.3.2021

                  CASE LEFT( laConfig(m.I), 18 ) == LOWER('ClassPerFileCheck:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 19 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_ClassPerFileCheck  = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > ClassPerFileCheck:          ' + TRANSFORM(lcValue) )
                        IF !lo_CFG.l_OldFilesPerDBC THEN
                           lo_CFG.l_ItemPerDBCCheck            = lo_CFG.l_ClassPerFileCheck
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + '  => ItemPerDBCCheck:          ' + TRANSFORM(lcValue) )
                        ENDIF
                        IF !lo_CFG.l_UseFormSettings THEN
                           lo_CFG.l_FormPerFileCheck           = lo_CFG.l_ClassPerFileCheck
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + '  => FormPerFileCheck          ' + TRANSFORM(lcValue) )
                        ENDIF
                     ENDIF
                     *!* /Changed by: LScheffler 21.02.2021
                     */VCX

                     *Forms
                  CASE LEFT( laConfig(m.I), 16 ) == LOWER('UseFormSettings:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 17 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_UseFormSettings    = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > UseFormSettings:            ' + TRANSFORM(lcValue) )
                        IF !lo_CFG.l_UseFormSettings THEN
                           lo_CFG.n_UseFormPerFile             = lo_CFG.n_UseClassPerFile
                           lo_CFG.l_RedirectFormPerFileToMain  = lo_CFG.l_RedirectClassPerFileToMain
                           lo_CFG.n_RedirectFormType           = lo_CFG.n_RedirectClassType
                           lo_CFG.l_FormPerFileCheck           = lo_CFG.l_ClassPerFileCheck
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' ==> UseFormPerFile:            ' + TRANSFORM(lo_CFG.n_UseFormPerFile) )
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' ==> RedirectFormPerFileToMain: ' + TRANSFORM(lo_CFG.l_RedirectFormPerFileToMain) )
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' ==> n_RedirectFormType:        ' + TRANSFORM(lo_CFG.n_RedirectFormType) )
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' ==> FormPerFileCheck:          ' + TRANSFORM(lo_CFG.l_FormPerFileCheck) )
                        ENDIF
                     ENDIF

                  CASE LEFT( laConfig(m.I), 15 ) == LOWER('UseFormPerFile:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 16 ) )
                     IF lo_CFG.l_UseFormSettings AND INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_UseFormPerFile = INT( VAL(lcValue) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > UseFormPerFile:             ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 26 ) == LOWER('RedirectFormPerFileToMain:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 27 ) )
                     IF lo_CFG.l_UseFormSettings AND INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_RedirectFormPerFileToMain  = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > RedirectFormPerFileToMain:  ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 17 ) == LOWER('RedirectFormType:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 18 ) )
                     IF lo_CFG.l_UseFormSettings AND INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_RedirectFormType   = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > RedirectFormType:           ' + TRANSFORM(lcValue) )
                     ENDIF
                     *!* /Changed by: LScheffler 04.3.2021

                  CASE LEFT( laConfig(m.I), 17 ) == LOWER('FormPerFileCheck:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 18 ) )
                     IF lo_CFG.l_UseFormSettings AND INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_FormPerFileCheck   = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > FormPerFileCheck:           ' + TRANSFORM(lcValue) )
                     ENDIF
                     */Forms

                     *Databases
                  CASE LEFT( laConfig(m.I), 15 ) == LOWER('OldFilesPerDBC:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 16 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_OldFilesPerDBC = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > OldFilesPerDBC:             ' + TRANSFORM(lcValue) )
                        IF !lo_CFG.l_OldFilesPerDBC THEN
                           lo_CFG.n_UseFilesPerDBC             = lo_CFG.n_UseClassPerFile
                           lo_CFG.l_RedirectFilePerDBCToMain   = lo_CFG.l_RedirectClassPerFileToMain
                           lo_CFG.l_ItemPerDBCCheck            = lo_CFG.l_ClassPerFileCheck
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' ==> UseFilesPerDBC:           ' + TRANSFORM(lo_CFG.n_UseFilesPerDBC) )
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' ==> RedirectFilePerDBCToMain: ' + TRANSFORM(lo_CFG.l_RedirectFilePerDBCToMain) )
                           .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' ==> ItemPerDBCCheck:          ' + TRANSFORM(lo_CFG.l_ItemPerDBCCheck) )
                        ENDIF
                     ENDIF

                  CASE LEFT( laConfig(m.I), 15 ) == LOWER('UseFilesPerDBC:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 16 ) )
                     IF lo_CFG.l_OldFilesPerDBC AND INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.n_UseFilesPerDBC = INT( VAL(lcValue) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > UseFilesPerDBC:             ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 25 ) == LOWER('RedirectFilePerDBCToMain:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 26 ) )
                     IF lo_CFG.l_OldFilesPerDBC AND INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_RedirectFilePerDBCToMain   = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > RedirectFilePerDBCToMain:   ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 16 ) == LOWER('ItemPerDBCCheck:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 17 ) )
                     IF lo_CFG.l_OldFilesPerDBC AND INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_ItemPerDBCCheck    = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > ItemPerDBCCheck:            ' + TRANSFORM(lcValue) )
                     ENDIF
                     */Databases
                     */-------- setting for container files (not pjx) --------

                     *!* LScheffler 30.08.2023
                  CASE LEFT( laConfig(m.I), 19 ) == LOWER('InhibitInheritance:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 20 ) )
                     IF INLIST( lcValue, '0', '1' , '2' , '3' ) THEN
                        IF llSetSingleConfig THEN
                           lo_CFG.n_InhibitInheritance    =  INT( VAL( lcValue ) )
                        ENDIF &&llSetSingleConfig

                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > InhibitInheritance:         ' + TRANSFORM(lcValue) +;
                           IIF(m.llSetSingleConfig, "", ", will be ignored, standard configuration file." ) )
                     ENDIF

                     *general files
                  CASE LEFT( laConfig(m.I), 13 ) == LOWER('NoTimestamps:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 14 ) )
                     IF NOT INLIST( TRANSFORM(tcNoTimestamps), '0', '1' ) AND INLIST( lcValue, '0', '1' ) THEN
                        tcNoTimestamps  = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > tcNoTimestamps:             ' + TRANSFORM(tcNoTimestamps) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 14 ) == LOWER('ClearUniqueID:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 15 ) )
                     IF NOT INLIST( TRANSFORM(tcClearUniqueID), '0', '1' ) AND INLIST( lcValue, '0', '1' ) THEN
                        tcClearUniqueID = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > ClearUniqueID:              ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 20 ) == LOWER('OptimizeByFilestamp:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 21 ) )
                     IF NOT INLIST( TRANSFORM(tcOptimizeByFilestamp), '0', '1', '2' ) AND INLIST( lcValue, '0', '1', '2' ) THEN
                        tcOptimizeByFilestamp   = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > OptimizeByFilestamp:        ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 24 ) == LOWER('RemoveNullCharsFromCode:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 25 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_RemoveNullCharsFromCode    = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > RemoveNullCharsFromCode:    ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 25 ) == LOWER('RemoveZOrderSetFromProps:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 26 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_RemoveZOrderSetFromProps   = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > RemoveZOrderSetFromProps:   ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(I), 17 ) == LOWER('PRG_Compat_Level:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(I), 18 ) )
                     lo_CFG.n_PRG_Compat_Level   = INT( VAL( lcValue ) )
                     .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > PRG_Compat_Level:           ' + TRANSFORM(lo_CFG.n_PRG_Compat_Level) )

                     *pjx special
                  CASE LEFT( laConfig(m.I), 12 ) == LOWER('BodyDevInfo:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 13 ) )
                     *** DH 2024-08-26: support 2 as a value
                     *                                   If Inlist( lcValue, '0', '1' ) Then
                     IF INLIST( lcValue, '0', '1', '2' ) THEN
                        lo_CFG.n_BodyDevInfo    = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > BodyDevInfo:                ' + TRANSFORM(lo_CFG.n_BodyDevInfo) )
                     ENDIF



                     *dbf special
                  CASE LEFT( laConfig(m.I), 19 ) == LOWER('ClearDBFLastUpdate:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 20 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_ClearDBFLastUpdate = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > ClearDBFLastUpdate:         ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 25 ) == LOWER('ExcludeDBFAutoincNextval:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 26 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.n_ExcludeDBFAutoincNextval   = INT( VAL( lcValue ) )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > ExcludeDBFAutoincNextval:   ' + TRANSFORM(lo_CFG.n_ExcludeDBFAutoincNextval) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 24 ) == LOWER('DBF_Conversion_Included:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 25 , IIF('&'+'&'$laConfig(m.I), AT('&'+'&', laConfig(m.I)) - 25, LEN(laConfig(m.I) ) ) ) )
                     IF NOT EMPTY(lcValue) THEN
                        lo_CFG.c_DBF_Conversion_Included    = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > DBF_Conversion_Included:    ' + TRANSFORM(lo_CFG.c_DBF_Conversion_Included) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 24 ) == LOWER('DBF_Conversion_Excluded:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 25 , IIF('&'+'&'$laConfig(m.I), AT('&'+'&', laConfig(m.I)) - 25, LEN(laConfig(m.I) ) ) ) )
                     IF NOT EMPTY(lcValue) THEN
                        lo_CFG.c_DBF_Conversion_Excluded    = lcValue
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > DBF_Conversion_Excluded:    ' + TRANSFORM(lo_CFG.c_DBF_Conversion_Excluded) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 19 ) == LOWER('DBF_BinChar_Base64:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 20 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_DBF_BinChar_Base64 = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > DBF_BinChar_Base64:         ' + TRANSFORM(lcValue) )
                     ENDIF

                  CASE LEFT( laConfig(m.I), 19 ) == LOWER('DBF_IncludeDeleted:')
                     lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 20 ) )
                     IF INLIST( lcValue, '0', '1' ) THEN
                        lo_CFG.l_DBF_IncludeDeleted = ( TRANSFORM(lcValue) == '1' )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > DBF_IncludeDeleted:         ' + TRANSFORM(lcValue) )
                     ENDIF

                     *Text file extensions
                  CASE LEFT( laConfig(m.I), 10 ) == LOWER('Extension:')
                     lcConfData  = ALLTRIM( SUBSTR( laConfig(m.I), 11 ) )
                     lcExt       = ALLTRIM( GETWORDNUM( lcConfData, 1, '=' ) )
                     lcProp      = 'c_' + lcExt
                     IF PEMSTATUS( lo_CFG, lcProp, 5 )
                        lcValue = UPPER( ALLTRIM( GETWORDNUM( lcConfData, 2, '=' ) ) )
                        lo_CFG.ADDPROPERTY( lcProp, lcValue )
                        *.writeLog( 'Reconfiguración de extensión:' + ' ' + lcExt + ' a ' + lcValue )
                        .writeLog( C_TAB + JUSTFNAME(lcConfigFile) + ' > ' + loLang.C_EXTENSION_RECONFIGURATION_LOC + ' ' + lcExt + ' -> ' + lcValue )
                     ENDIF


                  ENDCASE
               ENDFOR

               .writeLog( )

            ENDIF

            *-- ESTOS SE EVALÚAN FUERA DEL IF PORQUE NO DEPENDEN DEL CFG
            *-- Y PUEDEN VENIR TAMBIÉN DE PARÁMETROS EXTERNOS.
            IF INLIST( TRANSFORM(tcDontShowProgress), '0', '1', '2' ) THEN
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

            tcExtraBackupLevels = EVL( tcExtraBackupLevels, Transform( .n_ExtraBackupLevels ) )

            IF IsDigit(tcExtraBackupLevels)
               lo_CFG.n_ExtraBackupLevels = Int( Val( Transform(tcExtraBackupLevels) ) )
            ENDIF

            IF InList( Transform(tcOptimizeByFilestamp), '0', '1', '2' ) THEN
               lo_CFG.n_OptimizeByFilestamp = Int(Val(tcOptimizeByFilestamp))
            ENDIF

            .l_Main_CFG_Loaded  = .T.

            IF llMasterEval
               * Si se inidicó un archivo CFG por parámetro (modo objeto), aqui se bloquea
               * al Nº de configuración correspondiente.
               IF .n_CFG_EvaluateFromParam = -1
                  .n_CFG_EvaluateFromParam = .n_CFG_Actual
               ENDIF
            ELSE
               *-- Si no es llMasterEval, es porque esta llamada es cíclica desde este mismo método,
               *-- y no hay parámetros para evaluar, ya que se mandan todos vacíos desde el inicial.
               IF NOT tl_ForceLog THEN
                  EXIT
               ENDIF &&NOT tl_ForceLog
            ENDIF

            IF lo_CFG.l_AllowFolder THEN
               .writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC + ':' )
               * internal info, just what is read to this moment
               .writeLog( C_TAB + 'CFG_Actual:                 ' + TRANSFORM(.n_CFG_Actual) + ICASE(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]') )
               .writeLog( C_TAB + 'CFG_CachedAccess:           ' + TRANSFORM(.l_CFG_CachedAccess) )
               .writeLog( C_TAB + 'tc_InputFile:               ' + TRANSFORM(EVL(tc_InputFile,'') ) )
               .writeLog( C_TAB + 'Foxbin2prg_ConfigFile:      ' + TRANSFORM(EVL(lo_CFG.c_Foxbin2prg_ConfigFile, '(Internal defaults)') ) )

               * settings for internal work, not processing
               .writeLog( C_TAB + 'Language:                   ' + TRANSFORM(.c_Language) + ' (' + .c_Language_In + ')' )
               .writeLog( C_TAB + 'ShowProgressbar:            ' + TRANSFORM(.n_ShowProgressbar) )
               .writeLog( C_TAB + 'ShowErrors:                 ' + TRANSFORM(.l_ShowErrors) )
               .writeLog( C_TAB + 'ExtraBackupLevels:          ' + TRANSFORM(.n_ExtraBackupLevels) )

               DO CASE
               CASE EMPTY ( .c_BackgroundImage )
                  .writeLog( C_TAB + 'BackgroundImage:            ' + '(Empty)' )

               CASE LOWER( JUSTFNAME ( .c_BackgroundImage ) ) == 'foxbin2prg.jpg'
                  .writeLog( C_TAB + 'BackgroundImage:            ' + TRANSFORM(.c_BackgroundImage) +  '(Internal default)' )

               OTHERWISE
                  .writeLog( C_TAB + 'BackgroundImage:            ' + TRANSFORM(.c_BackgroundImage) )

               ENDCASE

               .writeLog( C_TAB + 'Debug:                      ' + TRANSFORM(.n_Debug) )

               * LScheffler, 2021/030/06: added DH HomeDir option
               .writeLog( C_TAB + 'HomeDir:                    ' + TRANSFORM(.n_HomeDir) )

               *Conversion operation by type
               .writeLog( C_TAB + 'PJX_Conversion_Support      ' + TRANSFORM(.n_PJX_Conversion_Support) )
               .writeLog( C_TAB + 'VCX_Conversion_Support      ' + TRANSFORM(.n_VCX_Conversion_Support) )
               .writeLog( C_TAB + 'SCX_Conversion_Support      ' + TRANSFORM(.n_SCX_Conversion_Support) )
               .writeLog( C_TAB + 'FRX_Conversion_Support      ' + TRANSFORM(.n_FRX_Conversion_Support) )
               .writeLog( C_TAB + 'LBX_Conversion_Support      ' + TRANSFORM(.n_LBX_Conversion_Support) )
               .writeLog( C_TAB + 'MNX_Conversion_Support      ' + TRANSFORM(.n_MNX_Conversion_Support) )
               .writeLog( C_TAB + 'DBF_Conversion_Support      ' + TRANSFORM(.n_DBF_Conversion_Support) )
               .writeLog( C_TAB + 'DBC_Conversion_Support      ' + TRANSFORM(.n_DBC_Conversion_Support) )
               .writeLog( C_TAB + 'FKY_Conversion_Support      ' + TRANSFORM(.n_FKY_Conversion_Support) )
               .writeLog( C_TAB + 'MEM_Conversion_Support      ' + TRANSFORM(.n_MEM_Conversion_Support) )

               *!* Changed by: LScheffler 19.03.2023
               * additional options controlling
               * files in non subpath of the PJX
               *setting for PJX files
               .writeLog( C_TAB + 'CheckFileInPath:            ' + TRANSFORM(.n_CheckFileInPath) )
               *!* /Changed by: LScheffler 19.03.2023

               *setting for container files (not pjx)
               *Classes ( vcx )
               .writeLog( C_TAB + 'UseClassPerFile:            ' + TRANSFORM(.n_UseClassPerFile) )
               .writeLog( C_TAB + 'ClassPerFileCheck:          ' + TRANSFORM(.l_ClassPerFileCheck) )
               .writeLog( C_TAB + 'RedirectClassPerFileToMain: ' + TRANSFORM(.l_RedirectClassPerFileToMain) )
               .writeLog( C_TAB + 'RedirectClassType:          ' + TRANSFORM(.n_RedirectClassType) )

               *Forms ( scx)
               .writeLog( C_TAB + 'UseFormSettings:            ' + TRANSFORM(.l_UseFormSettings) )
               .writeLog( C_TAB + 'UseFormPerFile:             ' + TRANSFORM(.n_UseFormPerFile) )
               .writeLog( C_TAB + 'FormPerFileCheck:           ' + TRANSFORM(.l_FormPerFileCheck) )
               .writeLog( C_TAB + 'RedirectFormPerFileToMain:  ' + TRANSFORM(.l_RedirectFormPerFileToMain) )
               .writeLog( C_TAB + 'RedirectFormType:           ' + TRANSFORM(.n_RedirectFormType) )

               *Databases
               *!* Changed by: LScheffler 21.02.2021
               *!* change date="{^2021-02-21,10:57:00}"
               * additional options controlling
               * - split of DBC separated from VCX/SCX
               * - new operations of DBF
               .writeLog( C_TAB + 'OldFilesPerDBC:             ' + TRANSFORM(.l_OldFilesPerDBC) )
               .writeLog( C_TAB + 'UseFilesPerDBC:             ' + TRANSFORM(.n_UseFilesPerDBC) )
               .writeLog( C_TAB + 'RedirectFilePerDBCToMain:   ' + TRANSFORM(.l_RedirectFilePerDBCToMain) )
               .writeLog( C_TAB + 'ItemPerDBCCheck:            ' + TRANSFORM(.l_ItemPerDBCCheck) )
               .writeLog( C_TAB + 'DBF_BinChar_Base64:         ' + TRANSFORM(.l_DBF_BinChar_Base64) )
               .writeLog( C_TAB + 'DBF_IncludeDeleted:         ' + TRANSFORM(.l_DBF_IncludeDeleted) )
               *!* /Changed by: LScheffler 21.02.2021

               *general files
               .writeLog( C_TAB + 'NoTimestamps:               ' + TRANSFORM(.l_NoTimestamps) )
               .writeLog( C_TAB + 'ClearUniqueID:              ' + TRANSFORM(.l_ClearUniqueID) )
               .writeLog( C_TAB + 'OptimizeByFilestamp:        ' + TRANSFORM(.n_OptimizeByFilestamp) )
               .writeLog( C_TAB + 'RemoveNullCharsFromCode:    ' + TRANSFORM(.l_RemoveNullCharsFromCode) )
               .writeLog( C_TAB + 'RemoveZOrderSetFromProps:   ' + TRANSFORM(.l_RemoveZOrderSetFromProps) )
               .writeLog( C_TAB + 'PRG_Compat_Level:           ' + TRANSFORM(.n_PRG_Compat_Level) )

               *Parameter only:
               .writeLog( C_TAB + 'Recompile:                  ' + TRANSFORM(.l_Recompile) + ' (' + tcRecompile + ')' )

               *pjx special
               .writeLog( C_TAB + 'BodyDevInfo:                ' + TRANSFORM(.n_BodyDevInfo) )

               *dbf special
               .writeLog( C_TAB + 'ClearDBFLastUpdate:         ' + TRANSFORM(.l_ClearDBFLastUpdate) )
               .writeLog( C_TAB + 'ExcludeDBFAutoincNextval:   ' + TRANSFORM(.n_ExcludeDBFAutoincNextval) )
               .writeLog( C_TAB + 'DBF_Conversion_Included     ' + TRANSFORM(.c_DBF_Conversion_Included) )
               .writeLog( C_TAB + 'DBF_Conversion_Excluded     ' + TRANSFORM(.c_DBF_Conversion_Excluded) )
               .writeLog( C_TAB + 'DBF_BinChar_Base64:         ' + TRANSFORM(.l_DBF_BinChar_Base64) )
               .writeLog( C_TAB + 'DBF_IncludeDeleted:         ' + TRANSFORM(.l_DBF_IncludeDeleted) )

               *Text file extensions
               .writeLog( C_TAB + 'extension: VC2              ' + TRANSFORM(.c_VC2) )
               .writeLog( C_TAB + 'extension: SC2              ' + TRANSFORM(.c_SC2) )
               .writeLog( C_TAB + 'extension: FR2              ' + TRANSFORM(.c_FR2) )
               .writeLog( C_TAB + 'extension: LB2              ' + TRANSFORM(.c_LB2) )
               .writeLog( C_TAB + 'extension: MN2              ' + TRANSFORM(.c_MN2) )
               .writeLog( C_TAB + 'extension: DB2              ' + TRANSFORM(.c_DB2) )
               .writeLog( C_TAB + 'extension: DC2              ' + TRANSFORM(.c_DC2) )
               .writeLog( C_TAB + 'extension: FK2              ' + TRANSFORM(.c_FK2) )
               .writeLog( C_TAB + 'extension: ME2              ' + TRANSFORM(.c_ME2) )
            ENDIF &&lo_CFG.l_AllowFolder

            .writeLog( )

         ENDWITH

      CATCH TO loEx
         loEx.USERVALUE  = loEx.USERVALUE + 'lcConfigFile = [' + TRANSFORM(lcConfigFile) + ']' + CR_LF
         loEx.USERVALUE  = loEx.USERVALUE + 'lc_CFG_Path = [' + TRANSFORM(lc_CFG_Path) + ']' + CR_LF
         loEx.USERVALUE  = loEx.USERVALUE + 'lcValue = [' + TRANSFORM(lcValue) + ']' + CR_LF

         IF This.n_Debug > 0 AND _VFP.STARTMODE = 0
            SET STEP ON
         ENDIF

         THROW

      FINALLY
         This.l_SingleConfig        = NVL(llSetSingleConfig,This.l_SingleConfig)
         *!* LScheffler 31.08.2023 more sophisticated control of inheritance for para file

         IF llSetSingleConfig THEN
            This.c_SingleConfig_Folder   = UPPER(JUSTPATH(tcCFG_File))
            This.c_Foxbin2prg_ConfigFile = lc_Foxbin2prg_ConfigFile
            DO CASE
            CASE This.n_InhibitInheritance=0
               This.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC2 )
            CASE This.n_InhibitInheritance=1
               This.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC3 )
            CASE This.n_InhibitInheritance=2
               This.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC4 )
            CASE This.n_InhibitInheritance=3
               This.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC5 )
            ENDCASE

            IF This.n_InhibitInheritance=0 THEN
               This.evaluateConfiguration( '', '', '', '', '', '', '', '', This.c_Foxbin2prg_ConfigFile, C_FILETYPE_FILE, lo_CFG)
               *In case we run FoxBin2Prg against FoxBin2Prg folder. do not reread
               This.n_InhibitInheritance = 1

            ENDIF &&This.n_InhibitInheritance=0
         ENDIF &&llSetSingleConfig

         STORE .NULL. TO lo_Configuration, lo_CFG, loEx
         RELEASE tcDontShowProgress, tcDontShowErrors, tcNoTimestamps, tcDebug, tcRecompile, tcExtraBackupLevels ;
            , tcClearUniqueID, tcOptimizeByFilestamp, tc_InputFile ;
            , lcConfigFile, llExiste_CFG_EnDisco, laConfig, I, lcConfData, lcExt, lcValue, lc_CFG_Path ;
            , lo_CFG, lo_Configuration, loEx

      ENDTRY

      RETURN
   ENDPROC


   FUNCTION comparedFilesAreEqual
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFilename1               (v! IN    ) Nombre del archivo1 a comparar
      * tcFilename2               (v! IN    ) Nombre del archivo2 a comparar
      * tcStrFileName2            (v! IN    ) ***NO IMPLEMENTADO*** Contenido del archivo2 a comparar
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFilename1, tcFilename2, tcStrFileName2

      LOCAL lnComparacion, lnLen1, lnLen2, lnHandle1, lnHandle2, lnTipoComp, lnChunkSize ;
         , loEx AS EXCEPTION

      TRY
         STORE -1 TO lnComparacion, lnHandle1, lnHandle2
         lnTipoComp      = 0
         lnChunkSize     = 65535

         DO CASE
         CASE NOT EMPTY(tcFilename1) AND NOT EMPTY(tcFilename2)
            lnTipoComp  = 1
            lnHandle1   = FOPEN( tcFilename1 )

            IF lnHandle1 = -1
               EXIT
            ENDIF

            lnHandle2   = FOPEN( tcFilename2 )

            IF lnHandle2 = -1
               EXIT
            ENDIF

            lnLen1      = FSEEK( lnHandle1, 0, 2 )
            lnLen2      = FSEEK( lnHandle2, 0, 2 )

            *-- Comparación de tamaño
            IF lnLen1 <> lnLen2 THEN
               lnComparacion   = 0 && Son distintos
               EXIT
            ENDIF

            *-- Comparación de contenido
            FSEEK( lnHandle1, 0, 0 )
            FSEEK( lnHandle2, 0, 0 )

            DO WHILE NOT ( FEOF(lnHandle1) OR FEOF(lnHandle2) )
               *IF NOT SYS( 2007, FREAD( lnHandle1, lnChunkSize ), -1, 1 ) == SYS( 2007, FREAD( lnHandle2, lnChunkSize ), -1, 1 ) THEN
               IF NOT FREAD( lnHandle1, lnChunkSize ) == FREAD( lnHandle2, lnChunkSize ) THEN
                  lnComparacion   = 0 && Son distintos
                  EXIT
               ENDIF
            ENDDO

            IF lnComparacion = 0 THEN
               EXIT
            ENDIF

            lnComparacion   = 1 && Son iguales

         ENDCASE

      CATCH TO loEx
         lnComparacion   = -1    && Error
         THROW

      FINALLY
         DO CASE
         CASE lnTipoComp = 1
            FCLOSE( lnHandle1 )
            FCLOSE( lnHandle2 )

         ENDCASE

      ENDTRY

      RETURN lnComparacion
   ENDFUNC


   FUNCTION filenameFoundInFilter
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFilename                (v! IN    ) Nombre del archivo a evaluar
      * tcFilters                 (v! IN    ) Filtros a evaluar (*,??E.*,R*.*)
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


   PROCEDURE get_DBF_Configuration(tc_InputFile AS STRING, to_out_DBF_CFG AS OBJECT, tlGenerateLog AS Boolean) AS INTEGER
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_InputFile              (@! IN    ) Ruta al archivo con Extensión para comprobar si tiene soporte de conversión
      * to_out_DBF_CFG            (@?    OUT) Objeto CFG del DBF indicado, con las propiedades que contenga el CFG y sus valores
      * RETORNO                   (v?    OUT) Devuelve 0 si no existe el archivo CFG y 1 si lo encuentra
      *---------------------------------------------------------------------------------------------------
      #IF .F.
         LOCAL to_out_DBF_CFG AS CL_DBF_CFG OF 'FOXBIN2PRG.PRG'
      #ENDIF

      LOCAL lcTableCFG, lnFileCount, laDirFile(1,5), I, lcConfigItem, lcValue
      lcTableCFG  = tc_InputFile + '.CFG'
      lnFileCount = ADIR(laDirFile, lcTableCFG)
      to_out_DBF_CFG  = .NULL.

      IF lnFileCount = 1

         to_out_DBF_CFG  = CREATEOBJECT("CL_DBF_CFG")

         IF tlGenerateLog THEN
            This.writeLog()
            This.writeLog(' > Found DBF configuration file: ' + lcTableCFG)
         ENDIF

         FOR I = 1 TO ALINES( laConfig, FILETOSTR( lcTableCFG ), 1+4 )
            lcConfigItem    = LOWER( laConfig(m.I) )

            DO CASE
            CASE INLIST( LEFT( lcConfigItem, 1 ), '*', '#', '/', "'" )
               LOOP

            CASE LEFT( lcConfigItem, 23 ) == LOWER('DBF_Conversion_Support:')
               to_out_DBF_CFG.n_DBF_Conversion_Support = INT( VAL( SUBSTR( laConfig(m.I), 24 ) ) )
               IF tlGenerateLog THEN
                  This.writeLog('     ' + JUSTFNAME(lcTableCFG) + ' > DBF_Conversion_Support: ' + TRANSFORM(to_out_DBF_CFG.n_DBF_Conversion_Support) )
               ENDIF

            CASE LEFT( lcConfigItem, 21 ) == LOWER('DBF_Conversion_Order:')
               to_out_DBF_CFG.DBF_Conversion_Order     = ALLTRIM( SUBSTR( laConfig(m.I), 22 , AT('&'+'&',laConfig(m.I)) - 22 ) )
               IF tlGenerateLog THEN
                  This.writeLog('     ' + JUSTFNAME(lcTableCFG) + ' > DBF_Conversion_Order: ' + to_out_DBF_CFG.DBF_Conversion_Order )
               ENDIF

            CASE LEFT( lcConfigItem, 25 ) == LOWER('DBF_Conversion_Condition:')
               to_out_DBF_CFG.DBF_Conversion_Condition = ALLTRIM( SUBSTR( laConfig(m.I), 26 , AT('&'+'&',laConfig(m.I)) - 26 ) )
               IF tlGenerateLog THEN
                  This.writeLog('     ' + JUSTFNAME(lcTableCFG) + ' > DBF_Conversion_Condition: ' + to_out_DBF_CFG.DBF_Conversion_Condition )
               ENDIF

               *!* Changed by: LScheffler 18.03.2021
               *!* change date="{^2021-03-18,10:57:00}"
               * additional options controlling
               * - new operations of DBF, additional list of non structural index files
            CASE LEFT( lcConfigItem, 14 ) == LOWER('DBF_IndexList:')
               to_out_DBF_CFG.DBF_IndexList    = SUBSTR( laConfig(m.I), 15 , AT('&'+'&',laConfig(m.I)) - 15 )
               IF tlGenerateLog THEN
                  This.writeLog('     ' + JUSTFNAME(lcTableCFG) + ' >DBF_IndexList:           ' + TRANSFORM(to_out_DBF_CFG.DBF_IndexList) )
               ENDIF
               *!* /Changed by: LScheffler 18.03.2021

               *!* Changed by: LScheffler 21.02.2021
               *!* change date="{^2021-02-21,10:57:00}"
               * additional options controlling
               * - new operations of DBF
               *!* /Changed by: LScheffler 21.02.2021
            CASE LEFT( lcConfigItem, 19 ) == LOWER('DBF_BinChar_Base64:')
               lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 20 ) )
               IF INLIST( m.lcValue, '0', '1' ) THEN
                  to_out_DBF_CFG.l_DBF_BinChar_Base64     = ( TRANSFORM(m.lcValue ) == '1' )
                  IF tlGenerateLog THEN
                     This.writeLog('     ' + JUSTFNAME(lcTableCFG) + ' > DBF_BinChar_Base64:     ' + TRANSFORM(to_out_DBF_CFG.l_DBF_BinChar_Base64) )
                  ENDIF
               ENDIF

            CASE LEFT( lcConfigItem, 19 ) == LOWER('DBF_IncludeDeleted:')
               lcValue = ALLTRIM( SUBSTR( laConfig(m.I), 20 ) )
               IF INLIST( m.lcValue, '0', '1' ) THEN
                  to_out_DBF_CFG.l_DBF_IncludeDeleted     = ( TRANSFORM( m.lcValue ) == '1' )
                  IF tlGenerateLog THEN
                     This.writeLog('     ' + JUSTFNAME(lcTableCFG) + ' > DBF_IncludeDeleted:     ' + TRANSFORM(to_out_DBF_CFG.l_DBF_IncludeDeleted) )
                  ENDIF
               ENDIF
               *!* /Changed by: LScheffler 21.02.2021

            ENDCASE
         ENDFOR

         IF tlGenerateLog THEN
            This.writeLog()
         ENDIF

      ENDIF

      RETURN lnFileCount
   ENDPROC


   PROCEDURE get_Ext2FromExt
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcExt                     (@! IN    ) Extensión para comprobar si tiene soporte de conversión
      * tcDir                     (@? IN    ) Directorio del que devolver su configuración
      * RETORNO                   (v?    OUT) .T. si tiene soporte de conversión, .F. si no lo tiene
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcExt, tcDir

      LOCAL lcExt2
      tcExt   = UPPER(tcExt)

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         IF NOT EMPTY(tcDir)
            .evaluateConfiguration( '', '', '', '', '', '', '', '', tcDir, 'D' )
         ENDIF

         lcExt2  = ICASE( tcExt == 'PJX', .c_PJ2 ;
            , tcExt == 'VCX', .c_VC2 ;
            , tcExt == 'SCX', .c_SC2 ;
            , tcExt == 'FRX', .c_FR2 ;
            , tcExt == 'LBX', .c_LB2 ;
            , tcExt == 'MNX', .c_MN2 ;
            , tcExt == 'DBF', .c_DB2 ;
            , tcExt == 'DBC', .c_DC2 ;
            , tcExt )
      ENDWITH && THIS

      RELEASE tcExt
      RETURN lcExt2
   ENDPROC


   PROCEDURE hasSupport_Bin2Prg(tcFileName AS STRING, tcDir AS STRING) AS Boolean
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFilename                (@! IN    ) Extensión para comprobar si el archivo tiene soporte de conversión
      * tcDir                     (@? IN    ) Directorio del que devolver su configuración
      * RETORNO                   (v?    OUT) .T. si tiene soporte de conversión, .F. si no lo tiene
      *---------------------------------------------------------------------------------------------------
      LOCAL llhasSupport, lcExt, lcDir ;
         , loDBF_CFG AS CL_DBF_CFG OF 'FOXBIN2PRG.PRG'

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

         llhasSupport    = .l_AllowFolder AND ICASE( lcExt == 'PJX', .n_PJX_Conversion_Support > 0 ;
            , lcExt == 'VCX', .n_VCX_Conversion_Support > 0 ;
            , lcExt == 'SCX', .n_SCX_Conversion_Support > 0 ;
            , lcExt == 'FRX', .n_FRX_Conversion_Support > 0 ;
            , lcExt == 'LBX', .n_LBX_Conversion_Support > 0 ;
            , lcExt == 'MNX', .n_MNX_Conversion_Support > 0 ;
            , lcExt == 'DBC', .n_DBC_Conversion_Support > 0 ;
            , lcExt == 'DBF', IIF(ISNULL(loDBF_CFG), .n_DBF_Conversion_Support > 0, loDBF_CFG.n_DBF_Conversion_Support > 0 ) ;
            , lcExt == 'FKY', .n_FKY_Conversion_Support > 0 ;
            , lcExt == 'MEM', .n_MEM_Conversion_Support > 0 ;
            , .F. )
      ENDWITH && THIS

      RETURN llhasSupport
   ENDPROC


   PROCEDURE hasSupport_Prg2Bin(tcFileName AS STRING, tcDir AS STRING) AS Boolean
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFilename                (@! IN    ) Extensión para comprobar si el archivo tiene soporte de conversión
      * tcDir                     (@? IN    ) Directorio del que devolver su configuración
      * RETORNO                   (v?    OUT) .T. si tiene soporte de conversión, .F. si no lo tiene
      *---------------------------------------------------------------------------------------------------
      LOCAL llhasSupport, lcExt, lcDir ;
         , loDBF_CFG AS CL_DBF_CFG OF 'FOXBIN2PRG.PRG'

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         loDBF_CFG   = .NULL.
         lcExt       = UPPER(JUSTEXT('.' + tcFileName))

         DO CASE
         CASE '\' $ tcFileName AND lcExt == .c_DB2
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

         llhasSupport    = .l_AllowFolder AND ICASE( lcExt == .c_PJ2, .n_PJX_Conversion_Support = 2 ;
            , lcExt == .c_VC2, .n_VCX_Conversion_Support = 2 ;
            , lcExt == .c_SC2, .n_SCX_Conversion_Support = 2 ;
            , lcExt == .c_FR2, .n_FRX_Conversion_Support = 2 ;
            , lcExt == .c_LB2, .n_LBX_Conversion_Support = 2 ;
            , lcExt == .c_MN2, .n_MNX_Conversion_Support = 2 ;
            , lcExt == .c_FK2, .n_FKY_Conversion_Support = 2 ;
            , lcExt == .c_ME2, .n_MEM_Conversion_Support = 2 ;
            , lcExt == .c_DB2, IIF(ISNULL(loDBF_CFG), INLIST(.n_DBF_Conversion_Support, 2, 8), INLIST(loDBF_CFG.n_DBF_Conversion_Support, 2, 8) ) ;
            , lcExt == .c_DC2, .n_DBC_Conversion_Support = 2 ;
            , .F. )
      ENDWITH && THIS

      RETURN llhasSupport
   ENDPROC


   PROCEDURE conversionSupportType(tcFileName AS STRING, tlGenerarLog AS Boolean) AS INTEGER
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFilename                (@! IN    ) Extensión para comprobar si el archivo tiene soporte de conversión
      * RETORNO                   (v?    OUT) Devuelve el código de soporte
      *---------------------------------------------------------------------------------------------------
      LOCAL lnSupportType, lcExt, lcDir, lcFilename ;
         , loDBF_CFG AS CL_DBF_CFG OF 'FOXBIN2PRG.PRG'

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            loDBF_CFG   = .NULL.
            lcExt       = UPPER(JUSTEXT('.' + tcFileName))

            IF '\' $ tcFileName AND INLIST(lcExt, .c_DB2, 'DBF') THEN
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
               INLIST(lcExt, .c_PJ2, 'PJX'), .n_PJX_Conversion_Support ;
               , INLIST(lcExt, .c_VC2, 'VCX'), .n_VCX_Conversion_Support ;
               , INLIST(lcExt, .c_SC2, 'SCX'), .n_SCX_Conversion_Support ;
               , INLIST(lcExt, .c_FR2, 'FRX'), .n_FRX_Conversion_Support ;
               , INLIST(lcExt, .c_LB2, 'LBX'), .n_LBX_Conversion_Support ;
               , INLIST(lcExt, .c_MN2, 'MNX'), .n_MNX_Conversion_Support ;
               , INLIST(lcExt, .c_FK2, 'FKY'), .n_FKY_Conversion_Support ;
               , INLIST(lcExt, .c_ME2, 'MEM'), .n_MEM_Conversion_Support ;
               , INLIST(lcExt, .c_DB2, 'DBF'), IIF(ISNULL(loDBF_CFG), .n_DBF_Conversion_Support, loDBF_CFG.n_DBF_Conversion_Support ) ;
               , INLIST(lcExt, .c_DC2, 'DBC'), .n_DBC_Conversion_Support ;
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
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Nombre completo (fullpath) del archivo a convertir o nombre del directorio a procesar
      *                                       - En modo compatibilidad con Visual SourceSafe, se usa para preguntar el tipo de soporte de conversión para el tipo de archivo indicado
      * tcType                    (v? IN    ) Tipo de archivo de entrada. Compatibilidad con SCCTEXT.PRG
      *                                       - Si se indica "*" y tc_InputFile es un PJX, se procesan todos los archivos del proyecto y el PJX/2
      *                                       - Si se indica "*-" y tc_InputFile es un PJX, se procesan todos los archivos del proyecto sin el PJX/2
      *                                       - Si se indica "BIN2PRG", se procesa el directorio indicado en tc_InputFile para generar los TX2
      *                                       - Si se indica "PRG2BIN", se procesa el directorio indicado en tc_InputFile para generar los BIN
      *                                       - En modo compatibilidad con Visual SourceSafe, indica el tipo de archivo a convertir
      * tcTextName                (v? IN    ) Nombre del archivo texto. (Solo para compatibilidad con Visual SourceSafe)
      * tlGenText                 (v? IN    ) .T.=Genera Texto, .F.=Genera Binario. (Solo para compatibilidad con Visual SourceSafe)
      * tcDontShowErrors          (v? IN    ) '1' para no mostrar mensajes de error (MESSAGEBOX)
      * tcDebug                   (v? IN    ) '1' para habilitar modo debug (SOLO DESARROLLO)
      * tcDontShowProgress        (v? IN    ) '1' para inhabilitar la barra de progreso
      * toModulo                  (@?    OUT) Referencia de objeto del módulo generado (para Unit Testing)
      * toEx                      (@?    OUT) Objeto con información del error
      * tlRelanzarError           (v? IN    ) Indica si el error debe relanzarse o no
      * tcOriginalFileName        (v? IN    ) Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar
      *                                       el nombre correcto dentro de la versión texto (por ej: en los PJ2 y las cabeceras)
      * tcRecompile               (v? IN    ) Indica recompilar ('1') el binario una vez regenerado. [Cambio de funcionamiento por defecto]
      *                                       Este cambio es para ganar tiempo, velocidad y seguridad. Además la recompilación que hace FoxBin2Prg
      *                                       se hace desde el directorio del archivo, con lo que las referencias relativas pueden
      *                                       generar errores de compilación, típicamente los #include.
      *                                       NOTA: Si en vez de '1' se indica un Path (p.ej, el del proyecto, se usará como base para recompilar
      * tcNoTimestamps            (v? IN    ) Indica si se debe anular el timestamp ('1') o no ('0' ó vacío)
      * tcBackupLevels            (v? IN    ) Indica la cantidad de niveles de backup a realizar (por defecto '1')
      * tcClearUniqueID           (v? IN    ) Indica si se debe limpiar el UniqueID ('1') o no ('0' ó vacío)
      * tcOptimizeByFilestamp     (v? IN    ) Indica si se debe optimizar por filestamp mayor o igual ('1'), solo igual ('2') o no optimizar ('0' ó vacío)
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
               , lcOldSetEscape, lcOldOnEscape, llEscKeyRestored, lcType

         LOCAL laFiles(1,5)   ;
             , laDirInfo(1,5) ;
             , laParams(1)

         LOCAL lnVFPVersion, lcCFG_File

         LOCAL loEx   AS EXCEPTION ;
             , loFSO  AS Scripting.FileSystemObject ;
             , loWSH  AS WScript.SHELL

         LOCAL loCFG             AS CL_CFG          OF 'FOXBIN2PRG.PRG' ;
             , loLang            AS CL_LANG         OF 'FOXBIN2PRG.PRG' ;
             , loDBF_CFG         AS CL_DBF_CFG      OF 'FOXBIN2PRG.PRG' ;
             , loFrm_Interactive AS frm_interactive OF 'FOXBIN2PRG.PRG' ;
             , loFrm_Main        AS frm_main        OF 'FOXBIN2PRG.PRG'

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
                      + '*, *-, -BIN2PRG, -PRG2BIN, -BIN2TEXT, -TEXT2BIN, -SHOWMSG, -SIMERR_I0, -SIMERR_I1, -SIMERR_O1'

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
               && Para evitar acumular procesos anteriores
               .clearProcessedFiles()
            ENDIF


            *-- Reconocimiento de la clase indicada
            *-- Ej: [c:\desa\test\library.vcx::classname]
            IF '::' $ tc_InputFile THEN
               tc_InputFile          = STRTRAN(tc_InputFile, '::', '|')

               .c_ClassOperationType = Evl( Upper( Left( Alltrim( GetWordNum( tc_InputFile, 3, '|' ) ), 1) ), 'E')
               .c_ClassToConvert     = Lower( Alltrim( GetWordNum( tc_InputFile, 2, '|' ) ) )

               * CUIDADO!, evaluar esta última, que si no las anteriores no evalúan.
               tc_InputFile = Lower( Alltrim( GetWordNum( tc_InputFile, 1, '|' ) ) )
            ELSE
               .c_ClassOperationType   = ''
            ENDIF

            IF Vartype(tcCFG_File) = "O"
               * Validar el objeto
               loCFG   = tcCFG_File
               IF NOT (loCFG.CLASS == Proper('CL_CFG'))
                  ERROR 'CFG object: Invalid class. Please, generate it with get_DirSettings()'
               ENDIF

               .c_Foxbin2prg_ConfigFile = loCFG
               .n_CFG_EvaluateFromParam = 1

            ELSE

               lcCFG_File = Iif(Vartype(tcCFG_File)='C' AND !Empty(tcCFG_File),tcCFG_File,.F.)
            ENDIF

            *-- Ajusto la ruta si no es absoluta
            tc_InputFile    = .get_AbsolutePath( tc_InputFile, .c_CurDir )

            *-- Determino el tipo de InputFile (Archivo o Directorio)
            IF Empty(lcInputFile_Type) AND NOT Empty(tc_InputFile)
               DO CASE
               CASE LEN(tc_InputFile) = 1
                  lcInputFile_Type    = C_FILETYPE_QUERYSUPPORT

               CASE ADir(laDirInfo, JustPath(tc_InputFile), "D") = 1 AND Substr( laDirInfo(1,5), 5, 1 ) = "D"
                  *-- Ejemplo: "c:\desa\"
                  lcInputFile_Type    = C_FILETYPE_DIRECTORY


               OTHERWISE
                  *-- Ejemplo: "c:\desa\*.scx", "c:\desa\file.ext", (lista de archivos)
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
               .writeLog( C_TAB + 'tcDebug:                      ' + TRANSFORM( EVL(tcDebug, '(empty)  -> Will use Default [' + TRANSFORM(.n_Debug) + ']' ) ) )
            ELSE
               .writeLog( C_TAB + 'tc_InputFile:                 ' + TRANSFORM( EVL(tc_InputFile, '(empty)  -> Will use Default [' + .c_InputFile + ']' ) ) )
               .writeLog( C_TAB + 'tcType:                       ' + TRANSFORM( EVL(lcType, '(empty)' ) ) )
               .writeLog( C_TAB + 'tcTextName:                   ' + TRANSFORM( EVL(tcTextName, '(empty)' ) ) )
               .writeLog( C_TAB + 'tlGenText:                    ' + TRANSFORM( EVL(tlGenText, '(empty)' ) ) )
               .writeLog( C_TAB + 'tcDontShowErrors:             ' + TRANSFORM( EVL(tcDontShowErrors, '(empty)  -> Will use Default [' + TRANSFORM(.l_ShowErrors) + ']' ) ) )
               .writeLog( C_TAB + 'tcDebug:                      ' + TRANSFORM( EVL(tcDebug, '(empty)  -> Will use Default [' + TRANSFORM(.n_Debug) + ']' ) ) )
               .writeLog( C_TAB + 'tcDontShowProgress:           ' + TRANSFORM( EVL(tcDontShowProgress, '(empty)  -> Will use Default [' + TRANSFORM(.n_ShowProgressbar) + ']' ) ) )
               .writeLog( C_TAB + 'tlRelanzarError:              ' + TRANSFORM( EVL(tlRelanzarError, '(empty)' ) ) )
               .writeLog( C_TAB + 'tcOriginalFileName:           ' + TRANSFORM( EVL(tcOriginalFileName, '(empty)  -> Will use Default [' + .c_OriginalFileName + ']' ) ) )
               .writeLog( C_TAB + 'tcRecompile:                  ' + TRANSFORM( EVL(tcRecompile, '(empty)  -> Will use Default [' + .c_Recompile + ']' ) ) )
               .writeLog( C_TAB + 'tcNoTimestamps:               ' + TRANSFORM( EVL(tcNoTimestamps, '(empty)  -> Will use Default [' + TRANSFORM(.l_NoTimestamps) + ']' ) ) )
               .writeLog( C_TAB + 'tcBackupLevels:               ' + TRANSFORM( EVL(tcBackupLevels, '(empty)  -> Will use Default [' + TRANSFORM(.n_ExtraBackupLevels) + ']' ) ) )
               .writeLog( C_TAB + 'tcClearUniqueID:              ' + TRANSFORM( EVL(tcClearUniqueID, '(empty)  -> Will use Default [' + TRANSFORM(.l_ClearUniqueID) + ']' ) ) )
               .writeLog( C_TAB + 'tcOptimizeByFilestamp:        ' + TRANSFORM( EVL(tcOptimizeByFilestamp, '(empty)  -> Will use Default [' + TRANSFORM(.n_OptimizeByFilestamp) + ']' ) ) )
               .writeLog( C_TAB + 'tcCFG_File                    ' + TRANSFORM( IIF(VARTYPE(tcCFG_File)='O' AND !ISNULL(tcCFG_File),'(object)',EVL(tcCFG_File, '(empty)' ) ) ) )
            ENDIF
            .writeLog( )

            *-- ARCHIVO DE CONFIGURACIÓN PRINCIPAL
            * log settings for tcCFG_File - cfg as object
            .evaluateConfiguration( @tcDontShowProgress, @tcDontShowErrors        , @tcNoTimestamps       , @tcDebug     , @tcRecompile      ;
                                  , @tcBackupLevels    , @tcClearUniqueID         , @tcOptimizeByFilestamp, @tc_InputFile, @lcInputFile_Type ;
                                  ,                    , Vartype(tcCFG_File) = "O", lcCFG_File            )

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

            CASE lcExt==This.c_VC2 OR lcExt=="VCX"
               *ClassLib
               DO CASE
               CASE .n_RedirectClassType # 2
                  * not handled

               CASE !EMPTY(.c_ClassToConvert)
                  * not otherwise

               CASE .n_UseClassPerFile = 0
                  * not handled

               CASE OCCURS('.',m.tc_InputFile) > .n_UseClassPerFile
                  * we must have more dots then UseClassPerFile, because there is an extension

                  *class
                  .c_ClassToConvert = LOWER( JUSTEXT( JUSTSTEM( m.tc_InputFile ) ) )
                  *remove class
                  tc_InputFile = LOWER( JUSTPATH( m.tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( m.tc_InputFile ) ) + '.' + JUSTEXT( m.tc_InputFile ) )
                  *remove baseclass
                  IF .n_UseClassPerFile = 2
                     *remove baseclass
                     tc_InputFile = LOWER( JUSTPATH( m.tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( m.tc_InputFile ) ) + '.' + JUSTEXT( m.tc_InputFile ) )
                  ENDIF
                  * count anything then -BIN2PRG as import
                  .c_ClassOperationType = IIF( ATC('-BIN2PRG','-'+tcType) > 0 OR ATC('-BIN2TEXT','-'+tcType) > 0, 'E', 'I')

               OTHERWISE
                  * not handled

               ENDCASE

            CASE lcExt==This.c_SC2 OR lcExt=="SCX"
               *Form
               DO CASE
               CASE .n_RedirectFormType # 2
                  * not handled
               CASE !EMPTY(.c_ClassToConvert)
                  * not otherwise
               CASE .n_UseFormPerFile = 0
                  * not handled
               CASE OCCURS('.',m.tc_InputFile) > .n_UseFormPerFile
                  * we must have more dots then UseClassPerFile, because there is an extension

                  *Form name
                  .c_ClassToConvert = LOWER( JUSTEXT( JUSTSTEM( m.tc_InputFile ) ) )
                  *remove obkject
                  tc_InputFile = LOWER( JUSTPATH( m.tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( m.tc_InputFile ) ) + '.' + JUSTEXT( m.tc_InputFile ) )
                  *remove baseclass
                  IF .n_UseFormPerFile = 2
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

            * Redefinir nombre archivo de entrada según el tipo de conversión (IMPORT/EXPORT)
            IF .c_ClassOperationType = 'I'
               * En el caso de importar, debo cambiar la sintaxis de tc_InputFile para poder usar
               * la conversión existente de clase vc2.
               * Esto deja un archivo con sintaxis "classlib.vcx::classname::import" en "classlib.classname.vc2"
               *                       IF .ATC(lcExt,c_VC2,"VCX")
               IF INLIST(lcExt,.c_VC2,"VCX")
                  IF .n_UseClassPerFile = 2
                     tc_InputFile        = FORCEEXT(tc_InputFile, '') + '.*.' + .c_ClassToConvert + '.' + .c_VC2

                     IF ADIR(laFiles, tc_InputFile) = 1
                        tc_InputFile    = FULLPATH( laFiles(1,1), tc_InputFile )
                     ENDIF

                  ELSE && Asumo .n_UseClassPerFile = 1
                     tc_InputFile        = FORCEEXT(tc_InputFile, '') + '.' + .c_ClassToConvert + '.' + .c_VC2

                  ENDIF
               ENDIF

               *                       IF .ATC(lcExt,c_SC2,"SCX")
               IF INLIST(lcExt,.c_SC2,"SCX")
                  IF .n_UseFormPerFile = 2
                     tc_InputFile        = FORCEEXT(tc_InputFile, '') + '.*.' + .c_ClassToConvert + '.' + .c_VC2

                     IF ADIR(laFiles, tc_InputFile) = 1
                        tc_InputFile    = FULLPATH( laFiles(1,1), tc_InputFile )
                     ENDIF

                  ELSE && Asumo .n_UseFormPerFile = 1
                     tc_InputFile        = FORCEEXT(tc_InputFile, '') + '.' + .c_ClassToConvert + '.' + .c_VC2

                  ENDIF
               ENDIF
            ENDIF
            *!* /Changed By LScheffler 3.1.2024

            loLang          = _SCREEN.o_FoxBin2Prg_Lang

            DO CASE
            CASE VERSION(5) < 900
               *-- '¡FOXBIN2PRG es solo para Visual FoxPro 9.0!'
               MESSAGEBOX( loLang.C_FOXBIN2PRG_JUST_VFP_9_LOC, 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_WARN_CAPTION_LOC + ' (' + .c_Language + ')', 60000 )
               lnCodError  = 1

               *!* Changed by: LScheffler 15.2.2021
               *!* change date="{^2021-02-15,18:44:00}"
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
               *!* /Changed by: LScheffler 15.2.2021

               *!* Changed by: LScheffler 07.3.2021
               *!* change date="{^2021-03-07,18:44:00}"
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

               lnOptions = 55

               LOCAL ARRAY;
                  laLines(1),;
                  laOptions(m.lnOptions,3)

               tc_InputFile = IIF( VARTYPE( m.tc_InputFile )='C' AND !EMPTY( m.tc_InputFile ), m.tc_InputFile, 'FoxBin2Prg._cfg' )
               loLang       = _SCREEN.o_FoxBin2Prg_Lang
               lcText       = STRTRAN( '*' + STRTRAN( m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg, CR_LF, CR_LF + '*'), CR_LF + '*' + CR_LF, CR_LF+CR_LF)
               lnLines      = ALINES(laLines,m.lcText)

               *now for each option
               laOptions(01,1) = "*ShowProgressbar:"                   && 0=Don't show, 1=Allways show, 2= Show only for multi-file processing
               laOptions(01,2) = ".n_ShowProgressbar"
               laOptions(01,3) = 0
               laOptions(02,1) = "*DontShowErrors:"                    && 0,1 Show message errors by default
               laOptions(02,2) = ".l_ShowErrors"
               laOptions(02,3) = 3
               laOptions(03,1) = "*NoTimestamps:"                      && 0,1 Clear timestamps by default for minimize differences
               laOptions(03,2) = ".l_NoTimestamps"
               laOptions(03,3) = 1
               laOptions(04,1) = "*Debug:"                             && 0,1 Don't Activate individual <file>.Log by default
               laOptions(04,2) = ".n_Debug"
               laOptions(04,3) = 0
               *** DH 2024-08-26: added text for option 2
               laOptions(05,1) = "*BodyDevInfo:"                       && 0,1 [0=Don't keep DevInfo for body pjx records], 1=Keep DevInfo, 2 = Don't keep DevInfo or ObjRev
               laOptions(05,2) = ".n_BodyDevInfo"
               laOptions(05,3) = 0
               laOptions(06,1) = "*ExtraBackupLevels:"                 && n By default 1 BAK is created. With this you can make more .N.BAK, or none
               laOptions(06,2) = ".n_ExtraBackupLevels"
               laOptions(06,3) = 0
               laOptions(07,1) = "*ClearUniqueID:"                     && 0,1 0=Keep UniqueID in text files, 1=Clear Unique ID. Useful for Diff and Merge
               laOptions(07,2) = ".l_ClearUniqueID"
               laOptions(07,3) = 1
               laOptions(08,1) = "*ClearDBFLastUpdate:"                && 0,1 0=Keep DBF LastUpdate, 1=Clear DBF LastUpdate. Useful for Diff.
               laOptions(08,2) = ".l_ClearDBFLastUpdate"
               laOptions(08,3) = 1
               laOptions(09,1) = "*OptimizeByFilestamp:"               && 0,1,2 1=Optimize file regeneration depending on file timestamp. Dangerous while working with branches!
               laOptions(09,2) = ".n_OptimizeByFilestamp"
               laOptions(09,3) = 0
               laOptions(10,1) = "*RemoveNullCharsFromCode:"           && 0,1 1=.t. 1=Drop .Null. chars from source code
               laOptions(10,2) = ".l_RemoveNullCharsFromCode"
               laOptions(10,3) = 1
               laOptions(11,1) = "*RemoveZOrderSetFromProps:"          && 0,1 1=.t. 0=Do not remove ZOrderSet property from object, 1=Remove ZOrderSet property from object
               laOptions(11,2) = ".l_RemoveZOrderSetFromProps"
               laOptions(11,3) = 1
               laOptions(12,1) = "*Language:"                          && Language of shown messages and LOGs. EN=English, FR=French, ES=Español, DE=German, Not defined = AUTOMATIC [DEFAULT]
               laOptions(12,2) = ".c_Language_In"
               laOptions(12,3) = 0
               laOptions(13,1) = "*ExcludeDBFAutoincNextval:"          && 0,1 [0=Do not exclude this value from db2], 1=Exclude this value from db2
               laOptions(13,2) = ".n_ExcludeDBFAutoincNextval"
               laOptions(13,3) = 0
               laOptions(14,1) = "*PRG_Compat_Level:"                  && n [0=Legacy], 1=Use HELPSTRING as Class Procedure comment
               laOptions(14,2) = ".n_PRG_Compat_Level"
               laOptions(14,3) = 0
               laOptions(15,1) = "*HomeDir:"                           && 0,1 0 = don't save HomeDir in PJ2, [1 = save HomeDir in PJ2]
               laOptions(15,2) = ".n_HomeDir"
               laOptions(15,3) = 0
               laOptions(16,1) = "*PJX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(16,2) = ".n_PJX_Conversion_Support"
               laOptions(16,3) = 0
               laOptions(17,1) = "*VCX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(17,2) = ".n_VCX_Conversion_Support"
               laOptions(17,3) = 0
               laOptions(18,1) = "*SCX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(18,2) = ".n_SCX_Conversion_Support"
               laOptions(18,3) = 0
               laOptions(19,1) = "*FRX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(19,2) = ".n_FRX_Conversion_Support"
               laOptions(19,3) = 0
               laOptions(20,1) = "*LBX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(20,2) = ".n_LBX_Conversion_Support"
               laOptions(20,3) = 0
               laOptions(21,1) = "*DBC_Conversion_Support:"            && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(21,2) = ".n_DBC_Conversion_Support"
               laOptions(21,3) = 0
               laOptions(22,1) = "*DBF_Conversion_Support:"            && n 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
               laOptions(22,2) = ".n_DBF_Conversion_Support"
               laOptions(22,3) = 0
               laOptions(23,1) = "*MNX_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
               laOptions(23,2) = ".n_MNX_Conversion_Support"
               laOptions(23,3) = 0
               laOptions(24,1) = "*FKY_Conversion_Support:"            && n 0=No support, 1=Generate TXT only (Diff)
               laOptions(24,2) = ".n_FKY_Conversion_Support"
               laOptions(24,3) = 0
               laOptions(25,1) = "*MEM_Conversion_Support:"            && 0=No support, 1=Generate TXT only (Diff)
               laOptions(25,2) = ".n_MEM_Conversion_Support"
               laOptions(25,3) = 0
               laOptions(26,1) = "*DBF_Conversion_Included:"           && n If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
               laOptions(26,2) = ".c_DBF_Conversion_Included"
               laOptions(26,3) = 6
               laOptions(27,1) = "*DBF_Conversion_Excluded:"           && n If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
               laOptions(27,2) = ".c_DBF_Conversion_Excluded"
               laOptions(27,3) = 5
               laOptions(28,1) = "*OldFilesPerDBC:"                    && 0,1 1=.t. 1=Turns the File per DBC options on, 0 uses the old UseClassPerFile etc settings.
               laOptions(28,2) = ".l_OldFilesPerDBC"
               laOptions(28,3) = 1
               laOptions(29,1) = "*UseFilesPerDBC:"                    && 0,1 0=One database dc2 file, 1=Multiple file.*.*.dc2 files
               laOptions(29,2) = ".n_UseFilesPerDBC"
               laOptions(29,3) = 0
               laOptions(30,1) = "*RedirectFilePerDBCToMain:"          && 0,1 1=.t. 0=Don't redirect to file.dc2, 1=Redirect to file.tx2 when selecting file.item.*.dc2
               laOptions(30,2) = ".l_RedirectFilePerDBCToMain"
               laOptions(30,3) = 1
               laOptions(31,1) = "*ItemPerDBCCheck:"                   && 0,1 1=.t. 0=Don't check file.item.*.dc2 inclusion, 1=Check file.item.*.dc2 inclusion
               laOptions(31,2) = ".l_ItemPerDBCCheck"
               laOptions(31,3) = 1
               laOptions(32,1) = "*DBF_BinChar_Base64:"                && 0,1 1=.t. 0=For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform (default)
               laOptions(32,2) = ".l_DBF_BinChar_Base64"
               laOptions(32,3) = 1
               laOptions(33,1) = "*DBF_IncludeDeleted:"                && 0,1 1=.t. 0=Do not include deleted records (default), 1=Include deleted records
               laOptions(33,2) = ".l_DBF_IncludeDeleted"
               laOptions(33,3) = 1
               laOptions(34,1) = "*CheckFileInPath:"                   && n 0=Default,no check. Determines 2Txt deals with files not in the subfolders of the PJX
               laOptions(34,2) = ".n_CheckFileInPath"
               laOptions(34,3) = 0
               laOptions(35,1) = "*UseClassPerFile:"                   && n 0=One library tx2 file, 1=Multiple file.class.tx2 files, 2=Multiple file.baseclass.class.tx2 files
               laOptions(35,2) = ".n_UseClassPerFile"
               laOptions(35,3) = 0
               laOptions(36,1) = "*RedirectClassPerFileToMain:"        && 0,1 1=.t. 0=Don't redirect to file.tx2, 1=Redirect to file.tx2 when selecting file.class.tx2
               laOptions(36,2) = ".l_RedirectClassPerFileToMain"
               laOptions(36,3) = 1
               laOptions(37,1) = "*RedirectClassType:"                 && 0,1,2 For classes created with UseClassPerFile>0 in the form file[.baseclass].class.tx2
               laOptions(37,2) = ".n_RedirectClassType"
               laOptions(37,3) = 0
               laOptions(38,1) = "*ClassPerFileCheck:"                 && 0,1 1=.t. 0=Don't check file.class.tx2 inclusion, 1=Check file.class.tx2 inclusion
               laOptions(38,2) = ".l_ClassPerFileCheck"
               laOptions(38,3) = 1
               laOptions(39,1) = "*extension: pj2="                    && ext Text file to PJX
               laOptions(39,2) = ".c_pj2"
               laOptions(39,3) = 2
               laOptions(40,1) = "*extension: vc2="                    && ext Text file to VCX
               laOptions(40,2) = ".c_vc2"
               laOptions(40,3) = 2
               laOptions(41,1) = "*extension: sc2="                    && ext Text file to SCX
               laOptions(41,2) = ".c_sc2"
               laOptions(41,3) = 2
               laOptions(42,1) = "*extension: fr2="                    && ext Text file to FRX
               laOptions(42,2) = ".c_fr2"
               laOptions(42,3) = 2
               laOptions(43,1) = "*extension: lb2="                    && ext Text file to LBX
               laOptions(43,2) = ".c_lb2"
               laOptions(43,3) = 2
               laOptions(44,1) = "*extension: mn2="                    && ext Text file to MNX
               laOptions(44,2) = ".c_mn2"
               laOptions(44,3) = 2
               laOptions(45,1) = "*extension: db2="                    && ext Text file to DBF
               laOptions(45,2) = ".c_db2"
               laOptions(45,3) = 2
               laOptions(46,1) = "*extension: dc2="                    && ext Text file to DBC
               laOptions(46,2) = ".c_dc2"
               laOptions(46,3) = 2
               laOptions(47,1) = "*extension: fk2="                    && ext Text file to FKY
               laOptions(47,2) = ".c_fk2"
               laOptions(47,3) = 2
               laOptions(48,1) = "*extension: me2="                    && ext Text file to MEM
               laOptions(48,2) = ".c_me2"
               laOptions(48,3) = 2
               laOptions(49,1) = "*BackgroundImage:"                   && Background image
               laOptions(49,2) = ".c_BackgroundImage"
               laOptions(49,3) = 7
               laOptions(50,1) = "*InhibitInheritance:"                && Inheritance out of config via parameter
               laOptions(50,2) = ".n_InhibitInheritance"
               laOptions(50,3) = 4
               laOptions(51,1) = "*UseFormSettings:"                   && 0,1 1=.t. 1=Turns the File per SCX options on, 0 uses the old UseClassPerFile etc settings.
               laOptions(51,2) = ".l_UseFormSettings"
               laOptions(51,3) = 1
               laOptions(52,1) = "*UseFormPerFile:"                    && n 0=One library sc2 file, 1=Multiple Form.Obj.sc2 files, 2=Multiple Form.baseclass.Obj.sc2 files
               laOptions(52,2) = ".n_UseFormPerFile"
               laOptions(52,3) = 0
               laOptions(53,1) = "*RedirectFormPerFileToMain:"         && 0,1 1=.t. 0=Don't redirect to Form.sc2, 1=Redirect to file.sc2 when selecting Form.Obj.sc2
               laOptions(53,2) = ".l_RedirectFormPerFileToMain"
               laOptions(53,3) = 1
               laOptions(54,1) = "*RedirectFormType:"                  && 0,1,2 For Formes created with UseFormPerFile>0 in the form Form[.baseclass].Obj.sc2
               laOptions(54,2) = ".n_RedirectFormType"
               laOptions(54,3) = 0
               laOptions(55,1) = "*FormPerFileCheck:"                  && 0,1 1=.t. 0=Don't check Form.Obj.sc2 inclusion, 1=Check Form.Obj.sc2 inclusion
               laOptions(55,2) = ".l_FormPerFileCheck"
               laOptions(55,3) = 1

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
               *-- (Ejemplo de sintaxis y uso)
               *MESSAGEBOX( loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC, 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_SYNTAX_INFO_LOC + ' (' + .c_Language + ')', 60000 )
               loFrm_Main  = CREATEOBJECT('frm_main', THIS)
               loFrm_Main.SHOW()
               READ EVENTS
               lnCodError  = 0

            OTHERWISE
               *-- EJECUCIÓN NORMAL


               IF (ATC('-INTERACTIVE', ('-' + tcType)) > 0 OR ATC('-?', ('-' + tcType)) > 0 );
                     AND ATC('-BIN2PRG', ('-' + tcType)) = 0 AND ATC('-PRG2BIN', ('-' + tcType)) = 0 ;
                     AND ATC('-BIN2TEXT','-'+tcType) = 0 AND ATC('-TEXT2BIN','-'+tcType) = 0 ;
                     AND lcInputFile_Type == C_FILETYPE_DIRECTORY THEN
                  *-- Se seleccionó un directorio y se puede elegir: Bin2Txt, Txt2Bin y Nada
                  .writeLog( loLang.C_INTERACTIVE_DIRECTORY_SELECTION_LOC )
                  loFrm_Interactive   = CREATEOBJECT('frm_interactive', THIS)
                  loFrm_Interactive.SHOW()
                  READ EVENTS
                  lnConversionOption  = loFrm_Interactive.n_ConversionType

                  IF loFrm_Interactive.l_FileTimeStampOptimization
                     IF .n_OptimizeByFilestamp = 0 THEN
                        .n_OptimizeByFilestamp = 2
                     ENDIF
                  ELSE
                     .n_OptimizeByFilestamp = 0
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

               *-- Evaluación de FileSpec de entrada
               DO CASE
               CASE ATC('-BIN2PRG', ('-' + tcType)) = 0 AND ATC('-PRG2BIN', ('-' + tcType)) = 0 ;
                     AND ATC('-BIN2TEXT','-'+tcType) = 0 AND ATC('-TEXT2BIN','-'+tcType) = 0 ;
                     AND lcInputFile_Type == C_FILETYPE_FILE ;
                     AND ( '*' $ JUSTEXT( tc_InputFile ) OR '?' $ JUSTEXT( tc_InputFile ) )

                  IF .l_ShowErrors
                     *MESSAGEBOX( 'No se admiten extensiones * o ? porque es peligroso (se pueden pisar binarios con archivo xx2 vacíos).', 0+48+4096, 'FOXBIN2PRG: ERROR!!', 60000 )
                     MESSAGEBOX( loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC, 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_ERROR_CAPTION_LOC, 60000 )
                     EXIT
                  ELSE
                     ERROR loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC
                  ENDIF


               CASE lcInputFile_Type == C_FILETYPE_FILE AND ( '*' $ JUSTSTEM( tc_InputFile ) OR '?' $ JUSTSTEM( tc_InputFile ) )
                  *-- SE QUIEREN TODOS LOS ARCHIVOS DE UNA EXTENSIÓN
                  lcFileSpec  = FULLPATH( tc_InputFile )
                  .c_LogFile  = ADDBS( JUSTPATH( lcFileSpec ) ) + STRTRAN( JUSTFNAME( lcFileSpec ), '*', '_ALL' ) + '.LOG'

                  IF .n_Debug > 0 THEN
                     ERASE ( .c_LogFile )
                  ENDIF

                  IF EVL(tcType,'0') <> '*' THEN
                     IF .n_ShowProgressbar <> 0 AND .l_ProcessFiles THEN
                        .loadProgressbarForm()
                     ENDIF

                     DO CASE
                     CASE .l_Recompile AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
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
                        *-- SE QUIEREN CONVERTIR A TEXTO TODOS LOS ARCHIVOS DE UNO O MÁS PROYECTOS PJX
                        *-- Filespec: "*.PJX", "*"
                        .evaluate_Full_PJX(lcFile, tcRecompile, @toModulo, @toEx, tcOriginalFileName, .c_LogFile, tcType)

                     CASE UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == .c_PJ2 AND LEFT(EVL(tcType,'0'),1) == '*'
                        *-- SE QUIEREN CONVERTIR A BINARIO TODOS LOS ARCHIVOS DE UNO O MÁS PROYECTOS PJ2
                        *-- Filespec: "*.PJ2", "*"
                        .evaluate_Full_PJ2(lcFile, tcRecompile, @toModulo, @toEx, tcOriginalFileName, .c_LogFile, tcType)

                     CASE ATC('-BIN2PRG', ('-' + tcType)) > 0;
                           OR ATC('-BIN2TEXT','-'+tcType) > 0
                        *-- SE QUIEREN CONVERTIR A TEXTO TODOS LOS ARCHIVOS DE UN DIRECTORIO
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
                        *-- SE QUIEREN CONVERTIR A BINARIO TODOS LOS ARCHIVOS DE UN DIRECTORIO
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
                        *-- NO SE INDICÓ NINGUNA EXTENSIÓN
                        ERROR loLang.C_INVALID_PARAMETER_LOC + ': cInputFile = "' + tc_InputFile + '"'

                     OTHERWISE
                        *-- DEMÁS ARCHIVOS
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

                  IF .n_ShowProgressbar <> 0 AND .l_ProcessFiles THEN
                     .loadProgressbarForm()
                     .o_Frm_Avance.CAPTION = STRTRAN( .o_Frm_Avance.CAPTION, '> -', '(Bin>Txt) -' )
                  ENDIF

                  DO CASE
                  CASE lcInputFile_Type == C_FILETYPE_DIRECTORY
                     *-- CONVERSION BIN2PRG DE UN DIRECTORIO Y SUBDIRECTORIOS
                     .writeLog( '> InputFile ' + loLang.C_IS_A_DIRECTORY_LOC )
                     .writeLog()

                     DO CASE
                     CASE .l_Recompile AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
                        CD (tcRecompile)
                     CASE .l_Recompile
                        CD (tc_InputFile)
                     ENDCASE

                     .c_LogFile  = ADDBS(tc_InputFile) + tcType + '.LOG'

                     IF .n_Debug > 0 THEN
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

                  IF .n_ShowProgressbar <> 0 AND .l_ProcessFiles THEN
                     .loadProgressbarForm()
                     .o_Frm_Avance.CAPTION = STRTRAN( .o_Frm_Avance.CAPTION, '> -', '(Txt>Bin) -' )
                  ENDIF

                  DO CASE
                  CASE lcInputFile_Type == C_FILETYPE_DIRECTORY
                     *-- CONVERSION PRG2BIN DE UN DIRECTORIO Y SUBDIRECTORIOS
                     .writeLog( '> InputFile ' + loLang.C_IS_A_DIRECTORY_LOC )
                     .writeLog()

                     DO CASE
                     CASE .l_Recompile AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
                        CD (tcRecompile)
                     CASE .l_Recompile
                        CD (tc_InputFile)
                     ENDCASE

                     .c_LogFile  = ADDBS(tc_InputFile) + tcType + '.LOG'

                     IF .n_Debug > 0 THEN
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

               *-- UN ARCHIVO INDIVIDUAL O CONSULTA DE SOPORTE DE ARCHIVO
               IF lcInputFile_Type = C_FILETYPE_QUERYSUPPORT
                  *-- Consulta de soporte de conversión (compatibilidad con SourceSafe)
                  *-- SourceSafe consulta el tipo de soporte de cada archivo antes del Checkin/Checkout
                  *-- para saber si se puede hacer Diff y Merge.
                  *-- Para los códigos de tipo de archivo ver ayuda de "Type Property"
                  DO CASE
                  CASE tc_InputFile $ FILETYPE_PROJECT    && PJX (J no exite en FoxPro, es un valor inventado para evitar conflicto con los tipos existentes)
                     lnCodError  = .n_PJX_Conversion_Support

                  CASE tc_InputFile == FILETYPE_CLASSLIB
                     lnCodError  = .n_X_Conversion_Support

                  CASE tc_InputFile == FILETYPE_FORM
                     lnCodError  = .n_SCX_Conversion_Support

                  CASE tc_InputFile == FILETYPE_REPORT
                     lnCodError  = .n_FRX_Conversion_Support

                  CASE tc_InputFile == FILETYPE_LABEL
                     lnCodError  = .n_LBX_Conversion_Support

                  CASE tc_InputFile == FILETYPE_MENU
                     lnCodError  = .n_MNX_Conversion_Support

                  CASE tc_InputFile == FILETYPE_DATABASE
                     lnCodError  = .n_DBC_Conversion_Support

                  CASE tc_InputFile == FILETYPE_FREETABLE
                     lnCodError  = .n_DBF_Conversion_Support

                  OTHERWISE
                     lnCodError  = -1    && No support.
                  ENDCASE

               ELSE

                  DO CASE
                  CASE UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == 'PJX' AND LEFT(EVL(tcType,'0'),1) == '*'
                     *-- SE QUIEREN CONVERTIR A TEXTO TODOS LOS ARCHIVOS DE UN PROYECTO PJX
                     .evaluate_Full_PJX(tc_InputFile, tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', tcType)
                     EXIT

                  CASE UPPER( JUSTEXT( EVL(tc_InputFile,'') ) ) == .c_PJ2 AND LEFT(EVL(tcType,'0'),1) == '*'
                     *-- SE QUIEREN CONVERTIR A BINARIO TODOS LOS ARCHIVOS DE UN PROYECTO PJ2
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
                     *-- COMPATIBILIDAD CON SOURCESAFE. 30/01/2014
                     IF tlGenText
                        .writeLog( '> ' + loLang.C_SOURCESAFE_COMPATIBILITY_MODE_LOC + ': ' + loLang.C_BINARY_TO_TEXT_LOC )
                     ELSE
                        *-- Create BINARIO desde versión TEXTO
                        *-- Como el archivo de entrada siempre es el binario cuando se usa SCCAPI,
                        *-- para regenerar el binario (tlGenText=.F.) se debe usar como
                        *-- archivo de entrada tcTextName en su lugar. Aquí los intercambio.
                        tc_InputFile        = tcTextName
                        .l_Recompile    = .T.
                        .writeLog( '> ' + loLang.C_SOURCESAFE_COMPATIBILITY_MODE_LOC + ': ' + loLang.C_TEXT_TO_BINARY_LOC )
                     ENDIF
                  ENDCASE

                  IF ADIR(laDirInfo, tc_InputFile) > 0
                     IF .n_ShowProgressbar <> 0 AND .l_ProcessFiles THEN
                        .loadProgressbarForm()
                     ENDIF

                     .writeLog( '> InputFile ' + loLang.C_IS_A_FILE_LOC )
                     .writeLog()
                     tc_InputFile    = LOCFILE(tc_InputFile)

                     DO CASE
                     CASE .l_Recompile AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
                        CD (tcRecompile)
                     CASE tcRecompile == '1'
                        CD (JUSTPATH(tc_InputFile))
                     ENDCASE

                     .c_LogFile  = tc_InputFile + '.LOG'

                     IF .n_Debug > 0 THEN
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
            loLang      = CREATEOBJECT("CL_LANG","EN")
         ENDIF

         IF lnCodError <> 1799 THEN  && Conversion Cancelled
            toEx.USERVALUE  = toEx.USERVALUE + 'FoxBin2Prg: [' + This.c_Foxbin2prg_FullPath + '] (EXE Version: ' + This.c_FB2PRG_EXE_Version + ')' + CR_LF
            lnErrorIcon     = 16
         ENDIF

         IF ATC('-SHOWMSG', ('-' + tcType)) > 0 THEN
            IF lnCodError <> 1799 THEN  && Conversion Cancelled
               toEx.USERVALUE = toEx.USERVALUE + 'lcInputFile_Type  = [' + TRANSFORM(lcInputFile_Type) + ']' + CR_LF
            ENDIF
            This.l_ShowErrors   = .F.   && La opción "SHOWMSG" muestra su propio mensaje
         ENDIF

         IF lnCodError <> 1799 THEN  && Conversion Cancelled
            toEx.USERVALUE = toEx.USERVALUE + 'tc_InputFile = [' + TRANSFORM(tc_InputFile) + ']' + CR_LF
         ENDIF

         This.doWriteErrorLog( @toEx, @lcErrorInfo )

         IF This.n_Debug > 0 THEN
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
            loLang      = CREATEOBJECT("CL_LANG","EN")
         ENDIF

         USE IN (SELECT("TABLABIN"))
         This.writeLog_Flush()
         This.unloadProgressbarForm()
         CD (JUSTPATH(This.c_CurDir))

         DO CASE
         CASE EVL( lcInputFile_Type, C_FILETYPE_QUERYSUPPORT ) <> C_FILETYPE_QUERYSUPPORT ;
               AND ATC('-SHOWMSG', ('-' + tcType)) > 0 ;
               OR This.l_ShowErrors AND lnCodError > 0 AND NOT ISNULL(toEx)
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
      * SE QUIEREN CONVERTIR A TEXTO TODOS LOS ARCHIVOS DE UN PROYECTO PJX
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Nombre del archivo de entrada
      * tcRecompile               (v? IN    ) Indica recompilar ('1') el binario una vez regenerado. [Cambio de funcionamiento por defecto]
      *                                       Este cambio es para ganar tiempo, velocidad y seguridad. Además la recompilación que hace FoxBin2Prg
      *                                       se hace desde el directorio del archivo, con lo que las referencias relativas pueden
      *                                       generar errores de compilación, típicamente los #include.
      *                                       NOTA: Si en vez de '1' se indica un Path (p.ej, el del proyecto, se usará como base para recompilar
      * toModulo                  (@?    OUT) Referencia de objeto del módulo generado (para Unit Testing)
      * toEx                      (@?    OUT) Objeto con información del error
      * tcOriginalFileName        (v? IN    ) Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar
      *                                       el nombre correcto dentro de la versión texto (por ej: en los PJ2 y las cabeceras)
      * tcLogFile                 (v? IN    ) Nombre del log a usar
      * tcType                    (v? IN    ) Tipo de archivo de entrada. Compatibilidad con SCCTEXT.PRG
      *                                       - Si se indica "*" y tc_InputFile es un PJX, se procesan todos los archivos del proyecto y el PJX/2
      *                                       - Si se indica "*-" y tc_InputFile es un PJX, se procesan todos los archivos del proyecto sin el PJX/2
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, tcRecompile, toModulo, toEx, tcOriginalFileName, tcLogFile, tcType

      LOCAL lcFileSpec, lnFileCount, laFiles(1,1), lcFile, lnCodError, I, lnFileCount, llError, laDirInfo(1,5) ;
         , loLang AS CL_LANG OF 'FOXBIN2PRG.PRG' ;
         , loEx AS EXCEPTION

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            loLang      = _SCREEN.o_FoxBin2Prg_Lang
            lcFileSpec  = FULLPATH( tc_InputFile )

            IF .n_ShowProgressbar <> 0 AND .l_ProcessFiles THEN
               .loadProgressbarForm()
               .o_Frm_Avance.CAPTION = STRTRAN( .o_Frm_Avance.CAPTION, '> -', '(Bin>Txt) -' )
            ENDIF

            IF EMPTY(tcLogFile)
               .c_LogFile  = ADDBS( JUSTPATH( lcFileSpec ) ) + STRTRAN( JUSTFNAME( lcFileSpec ), '*', '_ALL' ) + '.LOG'

               IF .n_Debug > 0 THEN
                  ERASE ( .c_LogFile )
               ENDIF
            ENDIF

            .writeLog( '> ' + loLang.C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC + ': ' + loLang.C_BINARY_TO_TEXT_LOC )

            DO CASE
            CASE .l_Recompile AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
               CD (tcRecompile)
            CASE tcRecompile == '1'
               CD (JUSTPATH(lcFileSpec))
            ENDCASE

            SELECT 0
            USE (tc_InputFile) SHARED AGAIN NOUPDATE ALIAS TABLABIN
            lnFileCount = 0

            SCAN FOR NOT DELETED() AND TYPE <> 'H'
               lnFileCount = lnFileCount + 1
               DIMENSION laFiles(lnFileCount,1)
               laFiles(lnFileCount,1)  = .get_AbsolutePath( ALLTRIM( NAME, 0, ' ', CHR(0) ), ADDBS( JUSTPATH( lcFileSpec ) ) )
            ENDSCAN

            USE IN (SELECT("TABLABIN"))

            *-- Convierto primero el proyecto
            IF tcType <> '*-' THEN
               lcFile      = tc_InputFile
               lnCodError  = .convert( lcFile, toModulo, @toEx, .T., tcOriginalFileName )
               .writeLog_Flush()
            ENDIF

            *-- Luego convierto los archivos incluidos
            FOR I = 1 TO lnFileCount
               lcFile      = laFiles(m.I,1)
               .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )

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
         STORE .NULL. TO loLang
         RELEASE loLang
      ENDTRY
   ENDPROC


   PROCEDURE evaluate_Full_PJ2
      *--------------------------------------------------------------------------------------------------------------
      * SE QUIEREN CONVERTIR A BINARIO TODOS LOS ARCHIVOS DE UN PROYECTO PJ2
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Nombre del archivo de entrada
      * tcRecompile               (v? IN    ) Indica recompilar ('1') el binario una vez regenerado. [Cambio de funcionamiento por defecto]
      *                                       Este cambio es para ganar tiempo, velocidad y seguridad. Además la recompilación que hace FoxBin2Prg
      *                                       se hace desde el directorio del archivo, con lo que las referencias relativas pueden
      *                                       generar errores de compilación, típicamente los #include.
      *                                       NOTA: Si en vez de '1' se indica un Path (p.ej, el del proyecto, se usará como base para recompilar
      * toModulo                  (@?    OUT) Referencia de objeto del módulo generado (para Unit Testing)
      * toEx                      (@?    OUT) Objeto con información del error
      * tcOriginalFileName        (v? IN    ) Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar
      *                                       el nombre correcto dentro de la versión texto (por ej: en los PJ2 y las cabeceras)
      * tcLogFile                 (v? IN    ) Nombre del log a usar
      * tcType                    (v? IN    ) Tipo de archivo de entrada. Compatibilidad con SCCTEXT.PRG
      *                                       - Si se indica "*" y tc_InputFile es un PJX, se procesan todos los archivos del proyecto y el PJX/2
      *                                       - Si se indica "*-" y tc_InputFile es un PJX, se procesan todos los archivos del proyecto sin el PJX/2
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, tcRecompile, toModulo, toEx, tcOriginalFileName, tcLogFile, tcType

      LOCAL lcFileSpec, lnFileCount, laFiles(1,1), lcFile, lnCodError, I, lnFileCount, llError, laDirInfo(1,5) ;
         , loLang AS CL_LANG OF 'FOXBIN2PRG.PRG' ;
         , loEx AS EXCEPTION

      TRY
         WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
            loLang      = _SCREEN.o_FoxBin2Prg_Lang
            lcFileSpec  = FULLPATH( tc_InputFile )

            IF .n_ShowProgressbar <> 0 AND .l_ProcessFiles THEN
               .loadProgressbarForm()
               .o_Frm_Avance.CAPTION = STRTRAN( .o_Frm_Avance.CAPTION, '> -', '(Txt>Bin) -' )
            ENDIF

            IF EMPTY(tcLogFile)
               .c_LogFile  = ADDBS( JUSTPATH( lcFileSpec ) ) + STRTRAN( JUSTFNAME( lcFileSpec ), '*', '_ALL' ) + '.LOG'

               IF .n_Debug > 0 THEN
                  ERASE ( .c_LogFile )
               ENDIF
            ENDIF

            .writeLog( '> ' + loLang.C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC + ': ' + loLang.C_TEXT_TO_BINARY_LOC )

            DO CASE
            CASE .l_Recompile AND LEN(tcRecompile) > 3 AND DIRECTORY(tcRecompile)
               CD (tcRecompile)
            CASE tcRecompile == '1'
               CD (JUSTPATH(lcFileSpec))
            ENDCASE

            lnFileCount = ALINES( laFiles, STREXTRACT( FILETOSTR(tc_InputFile), C_BUILDPROJ_I, C_BUILDPROJ_F ), 1+4 )

            FOR I = lnFileCount TO 1 STEP -1
               IF '.ADD(' $ laFiles(m.I)
                  lcFile      = .get_AbsolutePath( STREXTRACT( laFiles(m.I), ".ADD('", "')" ), ADDBS( JUSTPATH( lcFileSpec ) ) )
                  laFiles(m.I)    = FORCEEXT( lcFile, .get_Ext2FromExt( UPPER(JUSTEXT(lcFile)) ) )
               ELSE
                  lnFileCount = lnFileCount - 1
                  ADEL( laFiles, m.I )
                  DIMENSION laFiles(lnFileCount)
               ENDIF
            ENDFOR

            *-- Convierto primero el proyecto
            IF tcType <> '*-' THEN
               lcFile  = tc_InputFile
               lnCodError = .convert( lcFile, toModulo, @toEx, .T., tcOriginalFileName )
               .writeLog_Flush()
            ENDIF

            *-- Luego convierto los archivos incluidos
            FOR I = 1 TO lnFileCount
               lcFile  = laFiles(m.I)
               .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )

               IF .hasSupport_Prg2Bin( UPPER(JUSTEXT(lcFile)) ) AND ADIR( laDirInfo, lcFile ) > 0 THEN
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
         STORE .NULL. TO loLang
         RELEASE loLang
      ENDTRY
   ENDPROC


   HIDDEN PROCEDURE doWriteErrorLog
      LPARAMETERS toEx AS EXCEPTION, tcErrorInfo

      LOCAL loLang AS CL_LANG OF 'FOXBIN2PRG.PRG'
      loLang          = _SCREEN.o_FoxBin2Prg_Lang

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         IF toEx.ERRORNO = 1799 THEN     && Conversion Cancelled
            tcErrorInfo     = loLang.C_CONVERSION_CANCELLED_BY_USER_LOC
         ELSE
            tcErrorInfo     = .exception2Str(@toEx) + CR_LF + loLang.C_SOURCEFILE_LOC + TRANSFORM(.c_InputFile) + CR_LF
         ENDIF

         ADDPROPERTY(_SCREEN, 'ExitCode', toEx.ERRORNO)

         *-- Escribo la información de error en la variable log de errores
         .writeErrorLog( REPLICATE('-', 100), 1 )
         .writeLog( tcErrorInfo )
         .writeErrorLog( tcErrorInfo )
         .writeErrorLog( )

         *-- Escribo la información de error en el archivo log de errores
         TRY
            STRTOFILE( tcErrorInfo, EVL( .c_InputFile, 'foxbin2prg_errorlog' ) + '.ERR' )
         CATCH
         ENDTRY
      ENDWITH

      RETURN
   ENDPROC


   PROTECTED PROCEDURE convert
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Nombre del archivo de entrada
      * toModulo                  (@?    OUT) Referencia de objeto del módulo generado (para Unit Testing)
      * toEx                      (@?    OUT) Objeto con información del error
      * tlRelanzarError           (v? IN    ) Indica si el error debe relanzarse o no
      * tcOriginalFileName        (v? IN    ) Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar
      *                                       el nombre correcto dentro de la versión texto (por ej: en los PJ2 y las cabeceras)
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, toModulo, toEx AS EXCEPTION, tlRelanzarError, tcOriginalFileName

      TRY
         LOCAL lnCodError, lcErrorInfo, laDirFile(1,5), lcExtension, lnFileCount, laFiles(1,1), I ;
            , ltFilestamp, lcExtA, lcExtB, laEvents(1,1), lcForceAttribs, lnIDInputFile ;
            , loLang AS CL_LANG OF 'FOXBIN2PRG.PRG' ;
            , loConversor AS c_conversor_base OF 'FOXBIN2PRG.PRG' ;
            , loFSO AS Scripting.FileSystemObject ;
            , loDBF_CFG AS CL_DBF_CFG OF 'FOXBIN2PRG.PRG'
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
               *ERROR 'No se encontró el archivo [' + .c_InputFile + ']'
               ERROR loLang.C_FILE_NOT_FOUND_LOC + ' [' + .c_InputFile + ']'
            ENDIF

            .c_InputFile    = loFSO.GetAbsolutePathName( FORCEPATH( laDirFile(1,1), JUSTPATH(.c_InputFile) ) )

            *-- VERIFICO SI HAY ARCHIVO DE CONFIGURACIÓN SECUNDARIO
            .evaluateConfiguration()

            IF .n_ForceWriteIfReadOnly = 1 THEN
               lcForceAttribs  = lcForceAttribs + '-R'
            ENDIF

            *!* Changed by: LScheffler 03.03.2021
            *!* change date="{^2021-03-03,11:38:00}"
            * Added option for DBC split

            *-- OPTIMIZACIÓN VC2/SC2: VERIFICO SI EL ARCHIVO BASE FUE PROCESADO PARA DESCARTAR REPROCESOS
            IF INLIST(lcExtension,"VCX",.c_VC2);
                  AND (.n_UseClassPerFile > 0 AND .l_RedirectClassPerFileToMain ;
                  OR NOT EMPTY(.c_ClassToConvert))

               DO CASE

               CASE .n_RedirectClassType = 1 OR NOT EMPTY(.c_ClassToConvert) && Redireccionar solo esta clase
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(.c_InputFile) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

               CASE .n_UseClassPerFile = 1 AND INLIST(lcExtension,.c_VC2)
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(.c_InputFile) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  *-- Verifico si se debe forzar la redirección al archivo principal
                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF
                  ** LScheffler, Problem, Fehler: DC2 hier nicht, das muss anders mit UseFilesPerDBC
               CASE .n_UseClassPerFile = 2 AND INLIST(lcExtension,.c_VC2)
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  *-- Verifico si se debe forzar la redirección al archivo principal
                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF

               ENDCASE
            ENDIF

            IF INLIST(lcExtension,"SCX",.c_SC2);
                  AND (.n_UseFormPerFile > 0 AND .l_RedirectFormPerFileToMain ;
                  OR NOT EMPTY(.c_ClassToConvert))

               DO CASE

               CASE .n_RedirectFormType = 1 OR NOT EMPTY(.c_ClassToConvert) && Redireccionar solo esta clase
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(.c_InputFile) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

               CASE .n_UseFormPerFile = 1 AND INLIST(lcExtension,.c_SC2)
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(.c_InputFile) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  *-- Verifico si se debe forzar la redirección al archivo principal
                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF
                  ** LScheffler, Problem, Fehler: DC2 hier nicht, das muss anders mit UseFilesPerDBC
               CASE .n_UseFormPerFile = 2 AND INLIST(lcExtension,.c_SC2)
                  IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                     lc_BaseFile = .c_InputFile
                  ELSE
                     lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
                  ENDIF

                  *-- Verifico si se debe forzar la redirección al archivo principal
                  IF '.' $ JUSTSTEM(.c_InputFile)
                     .c_InputFile    = lc_BaseFile
                  ENDIF

               ENDCASE
            ENDIF
            *****************************

            *-- OPTIMIZACIÓN DC2: VERIFICO SI EL ARCHIVO BASE FUE PROCESADO PARA DESCARTAR REPROCESOS
            IF INLIST(lcExtension,"DBC",.c_DC2);
                  AND .n_UseFilesPerDBC > 0 AND .l_RedirectFilePerDBCToMain;
                  AND .n_UseFilesPerDBC = 1

               IF OCCURS('.', JUSTSTEM(.c_InputFile)) = 0 THEN
                  lc_BaseFile = .c_InputFile
               ELSE
                  lc_BaseFile = FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(.c_InputFile) ) ), JUSTEXT(.c_InputFile)) , JUSTPATH(.c_InputFile) )
               ENDIF

               *-- Verifico si se debe forzar la redirección al archivo principal
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

            IF UPPER( JUSTEXT(.c_OriginalFileName) ) = 'PJM' AND .c_PJ2 <> 'PJM'
               .c_OriginalFileName = FORCEEXT(.c_OriginalFileName,'pjx')
            ENDIF

            *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
            IF NOT .addProcessedFile( .c_InputFile, 'I', 'P1', 'E0', 'S1', 'X0' ) THEN
               *.writeLog( 'OPTIMIZACIÓN: El archivo Base [' + JUSTFNAME(lc_BaseFile) + '] ya fue procesado, por lo que no se procesará [' + JUSTFNAME(.c_InputFile) + ']' )
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
               IF NOT INLIST(.n_VCX_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_VC2 )
               loConversor     = CREATEOBJECT( 'c_conversor_vcx_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_VC2 ), lcForceAttribs )

            CASE lcExtension = 'SCX'
               IF NOT INLIST(.n_SCX_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_SC2 )
               loConversor     = CREATEOBJECT( 'c_conversor_scx_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_SC2 ), lcForceAttribs )

            CASE lcExtension = 'PJX'
               IF NOT INLIST(.n_PJX_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_PJ2 )
               loConversor     = CREATEOBJECT( 'c_conversor_pjx_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_PJ2 ), lcForceAttribs )

            CASE lcExtension = 'PJM' AND .c_PJ2 <> 'PJM'
               IF NOT INLIST(.n_PJX_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_PJ2 )
               loConversor     = CREATEOBJECT( 'c_conversor_pjm_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_PJ2 ), lcForceAttribs )

            CASE lcExtension = 'FRX'
               IF NOT INLIST(.n_FRX_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_FR2 )
               loConversor     = CREATEOBJECT( 'c_conversor_frx_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_FR2 ), lcForceAttribs )

            CASE lcExtension = 'LBX'
               IF NOT INLIST(.n_LBX_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_LB2 )
               loConversor     = CREATEOBJECT( 'c_conversor_frx_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_LB2 ), lcForceAttribs )

            CASE lcExtension = 'DBF'
               lnFileCount = .get_DBF_Configuration( FORCEEXT(.c_InputFile, 'DBF'), @loDBF_CFG )
               IF !IIF(ISNULL(loDBF_CFG), INLIST(.n_DBF_Conversion_Support, 1, 2, 4, 8), INLIST(loDBF_CFG.n_DBF_Conversion_Support, 1, 2, 4, 8) )
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_DB2 )
               loConversor     = CREATEOBJECT( 'c_conversor_dbf_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_DB2 ), lcForceAttribs )

            CASE lcExtension = 'DBC'
               IF NOT INLIST(.n_DBC_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_DC2 )
               loConversor     = CREATEOBJECT( 'c_conversor_dbc_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_DC2 ), lcForceAttribs )

            CASE lcExtension = 'MNX'
               IF NOT INLIST(.n_MNX_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_MN2 )
               loConversor     = CREATEOBJECT( 'c_conversor_mnx_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_MN2 ), lcForceAttribs )

            CASE lcExtension = 'FKY'
               IF NOT INLIST(.n_FKY_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_FK2 )
               loConversor     = CREATEOBJECT( 'c_conversor_fky_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_FK2 ), lcForceAttribs )

            CASE lcExtension = 'MEM'
               IF NOT INLIST(.n_MEM_Conversion_Support, 1, 2)
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, .c_ME2 )
               loConversor     = CREATEOBJECT( 'c_conversor_mem_a_prg' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, .c_ME2 ), lcForceAttribs )

            CASE lcExtension = .c_VC2
               IF .n_VCX_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               IF EMPTY(.c_ClassToConvert)
                  .c_OutputFile   = FORCEEXT( .c_InputFile, 'VCX' )
               ELSE
                  * Si se usó la sintaxis "classlib.vcx::clase::import", se define el OutputFile
                  * con la Base "classlib.vcx" y no con el archivo entero.
                  .c_OutputFile   = FORCEEXT( lc_BaseFile, 'VCX' )
               ENDIF
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_vcx' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'VCX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'VCT' ), lcForceAttribs )

            CASE lcExtension = .c_SC2
               IF .n_SCX_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'SCX' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_scx' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'SCX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'SCT' ), lcForceAttribs )

            CASE lcExtension = .c_PJ2
               IF .n_PJX_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'PJX' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_pjx' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'PJX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'PJT' ), lcForceAttribs )

            CASE lcExtension = .c_FR2
               IF .n_FRX_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'FRX' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_frx' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FRX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FRT' ), lcForceAttribs )

            CASE lcExtension = .c_LB2
               IF .n_LBX_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'LBX' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_frx' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'LBX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'LBT' ), lcForceAttribs )

            CASE lcExtension = .c_DB2
               lnFileCount = .get_DBF_Configuration( FORCEEXT(.c_InputFile, 'DBF'), @loDBF_CFG )
               IF !IIF(ISNULL(loDBF_CFG), INLIST(.n_DBF_Conversion_Support, 2, 8), INLIST(loDBF_CFG.n_DBF_Conversion_Support, 2, 8) )
                  *-- Soporte txt-2-bin habilitado
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'DBF' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_dbf' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'DBF' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FPT' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'CDX' ), lcForceAttribs )

            CASE lcExtension = .c_DC2
               IF .n_DBC_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'DBC' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_dbc' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'DBC' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'DCX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'DCT' ), lcForceAttribs )

            CASE lcExtension = .c_MN2
               IF .n_MNX_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'MNX' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_mnx' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'MNX' ), lcForceAttribs )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'MNT' ), lcForceAttribs )

            CASE lcExtension = .c_FK2
               IF .n_FKY_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'FKY' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_fky' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'FKY' ), lcForceAttribs )

            CASE lcExtension = .c_ME2
               IF .n_MEM_Conversion_Support <> 2
                  ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               ENDIF
               .c_OutputFile   = FORCEEXT( .c_InputFile, 'MEM' )
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_mem' )
               .changeFileAttribute( FORCEEXT( .c_InputFile, 'MEM' ), lcForceAttribs )

            OTHERWISE
               *ERROR 'El archivo [' + .c_InputFile + '] no está soportado'
               ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))

            ENDCASE

            *** DH 2021-03-04: handle cOutputFolder
            loConversor.cOutputFolder = This.cOutputFolder

            *-- Optimización: Comparación de los timestamps de InputFile y OutputFile para saber
            *-- si el OutputFile se debe regenerar o no.
            lnFileCount = ADIR( laFiles, FORCEEXT( .c_InputFile, '*' ), '', 1 )
            STORE {//::} TO .t_InputFile_TimeStamp, .t_OutputFile_TimeStamp, ltFilestamp

            IF lnFileCount > 0 THEN
               *-- Busca el archivo de entrada original
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

                  *-- Tomo el máximo timestamp de los archivos de salida (??X/??T)
                  .t_OutputFile_TimeStamp =   MAX( .t_OutputFile_TimeStamp, ltFilestamp )
               ENDIF
            ENDIF

            DO CASE
            CASE INLIST(lcExtension,"VCX",.c_VC2) AND .n_UseClassPerFile = 0 AND .n_OptimizeByFilestamp = 1 AND .t_InputFile_TimeStamp < .t_OutputFile_TimeStamp
               *-- Optimizado: El Origen es anterior al Destino - No hace falta regenerar
               *.writeLog( '> El archivo de salida [<<This.c_OutputFile>>] no se regenera porque su timestamp es más nuevo que el de entrada.' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )

            CASE INLIST(lcExtension,"VCX",.c_VC2) AND .n_UseClassPerFile = 0 AND .n_OptimizeByFilestamp = 2 AND .t_InputFile_TimeStamp = .t_OutputFile_TimeStamp
               *-- Optimizado: El Origen es igual al Destino - No hace falta regenerar
               *.writeLog( '> El archivo de salida [<<This.c_OutputFile>>] no se regenera porque su timestamp es igual que el de entrada.' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )

            CASE INLIST(lcExtension,"SCX",.c_SC2) AND .n_UseFormPerFile = 0 AND .n_OptimizeByFilestamp = 1 AND .t_InputFile_TimeStamp < .t_OutputFile_TimeStamp
               *-- Optimizado: El Origen es anterior al Destino - No hace falta regenerar
               *.writeLog( '> El archivo de salida [<<This.c_OutputFile>>] no se regenera porque su timestamp es más nuevo que el de entrada.' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )

            CASE INLIST(lcExtension,"SCX",.c_SC2) AND .n_UseFormPerFile = 0 AND .n_OptimizeByFilestamp = 2 AND .t_InputFile_TimeStamp = .t_OutputFile_TimeStamp
               *-- Optimizado: El Origen es igual al Destino - No hace falta regenerar
               *.writeLog( '> El archivo de salida [<<This.c_OutputFile>>] no se regenera porque su timestamp es igual que el de entrada.' )
               .writeLog( C_TAB + C_TAB + '* ' + TEXTMERGE(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )

            OTHERWISE
               .c_Type                             = UPPER(JUSTEXT(.c_OutputFile))
               loConversor.c_InputFile             = .c_InputFile
               loConversor.c_OutputFile            = .c_OutputFile
               loConversor.c_LogFile               = .c_LogFile
               loConversor.n_Debug                 = .n_Debug
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

               *-- Logueo los errores
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

         IF This.n_Debug > 0 THEN
            IF _VFP.STARTMODE = 0
               SET STEP ON
            ENDIF
         ENDIF
         IF tlRelanzarError  && Usado en Unit Testing
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
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:       (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcDir             (@? IN    ) Directorio del que devolver su configuración
      * tcDebug           (v? IN    ) '1' write debug log (posiibly to GETENV("TEMP") )
      * tcCFG_File        (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
      *                                       Normal inheritance may or may not run, see setting InhibitInheritance
      * RETORNO           (@?    OUT) Objeto CFG
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
         loCFG   = CREATEOBJECT('CL_CFG')
         loCFG.CopyFrom(THIS)
      ENDIF

      RETURN loCFG
   ENDPROC


   PROCEDURE get_PROGRAM_HEADER
      LOCAL lcText
      lcText  = ''

      *-- Cabecera del PRG e inicio de DEF_CLASS
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
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_OutputFilename         (v! IN    ) Nombre del archivo de salida a crear el backup
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tcOutputFileName
      LOCAL lcNext_Bak, I, laDirInfo(1,5)
      lcNext_Bak  = '.BAK'

      FOR I = 1 TO This.n_ExtraBackupLevels
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
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Línea a separar del comentario
      * tcComment                 (@?    OUT) Comentario
      * tlDeepCommentAnalysis     (v? IN    ) Indica realizar un análisis profundo de comentarios (para detectar casos complejos de código con '&&' embebido)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcLine AS STRING, tcComment AS STRING, tlDeepCommentAnalysis AS Boolean
      LOCAL ln_AT_Cmt
      tcComment   = ''
      ln_AT_Cmt   = AT( '&'+'&', tcLine)

      IF ln_AT_Cmt > 0
         IF tlDeepCommentAnalysis THEN
            LOCAL laSeparador(3,3), lcSeparadoresIzq, lcSeparadoresDer, lcStr, lnAT_Amp, lnAT1, lnAT2, lnLen, I, X

            lcStr   = tcLine    &&EVL(tcStr, [DEFINE BAR 2 OF OpciónAsub PROMPT "Opción A&]+[&2" &]+[& Comentario Opción A-2])
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

            *-- Anular subcadenas para luego encontrar comentarios '&&' (y analizar solo si existe al menos un '&&')
            X       = 1
            lnAT1   = AT(laSeparador(m.X,1), lcStr)

            *-- Funcionamiento:
            *-- La anulación de subcadenas se hace comenzando desde la primer comilla doble ["], y luego se va
            *-- cancelando hasta la siguiente. A partir de ahi, se busca carácter a carácter el siguiente separador
            *-- izquierdo de cadena ( '"[ ), se busca su pareja derecha y se cancela el texto entre ambos.
            *-- La anulación de subcadenas es temporal, solo para determinar la verdadera posición del comentario,
            *-- por ejemplo, esto:
            *-- DEFINE BAR 2 OF OpciónAsub PROMPT ""+var+'aa'+["bb]+"Opción A&&2" && Comentario Opción A-2
            *-- se convierte temporalmente en esto:
            *-- DEFINE BAR 2 OF OpciónAsub PROMPT XX+var+XXXX+XXXXX+XXXXXXXXXXXXX && Comentario Opción A-2
            *-- lo que facilita encontrar el comentario '&&' real.
            *-- Si se encuentra algún separador de cadena que no cierre, se genera un error 10 (Syntax Error).
            IF lnAT1 > 0 THEN
               FOR I = lnAT1+1 TO lnLen
                  IF m.X > 0 THEN
                     lnAT2   = AT(laSeparador(m.X,2), lcStr, laSeparador(m.X,3))

                     IF lnAT2 > 0 THEN
                        lcStr   = STUFF(lcStr, lnAT1, lnAT2-lnAT1+1, REPLICATE('X',lnAT2-lnAT1+1))
                     ELSE
                        ln_AT_Cmt   = AT( '&'+'&', lcStr)

                        IF ln_AT_Cmt = 0 OR ln_AT_Cmt < lnAT1
                           *-- No tiene comentario '&&' real, o sí lo tiene y además contiene un delimitador de cadena como parte del comentario
                           EXIT
                        ELSE
                           ERROR 'Closing string delimiter <' + laSeparador(m.X,2) + '> not found: ' + tcLine
                        ENDIF
                     ENDIF
                  ENDIF

                  *-- Verifico si el carácter es un separador de cadenas: '"[
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
            , loLang AS CL_LANG OF 'FOXBIN2PRG.PRG' ;
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
               *-- La primera vez vale -1, hace la verificación por única vez y cachea la respuesta
               IF FILE(lcEXE_CAPS)
                  *.writeLog( '* Se ha encontrado el programa de capitalización de nombres [' + lcEXE_CAPS + ']' )
                  .writeLog( C_TAB + TEXTMERGE(loLang.C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC) )
                  SET PROCEDURE TO (lcEXE_CAPS) ADDITIVE
                  .o_FNC  = CREATEOBJECT( 'cl_FileName_Caps' )
                  RELEASE PROCEDURE (lcEXE_CAPS)

                  .n_ExisteCapitalizacion = 1
               ELSE
                  *-- No existe el programa de capitalización, así que no se capitalizan los nombres.
                  *.writeLog( '* No se ha encontrado el programa de capitalización de nombres [' + lcEXE_CAPS + ']' )
                  .writeLog( C_TAB + TEXTMERGE(loLang.C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC) )
                  .n_ExisteCapitalizacion = 0
                  EXIT
               ENDIF

            CASE .n_ExisteCapitalizacion = 0
               *-- Segunda pasada en adelante: No hay programa de capitalización
               EXIT

            OTHERWISE
               *-- Segunda pasada en adelante: Hay programa de capitalización

            ENDCASE

            *-- Normalizar archivo(s) de entrada. El primero siempre se normaliza (??2, ??X, DBF, DBC)
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
         , loLang AS CL_LANG OF 'FOXBIN2PRG.PRG'

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

            *-- Busco los archivos
            FOR I = 1 TO lnFiles
               IF SUBSTR( laFiles(m.I,5), 5, 1 ) == 'D'
                  LOOP
               ENDIF

               tnFileCount = tnFileCount + 1
               DIMENSION taFiles(tnFileCount)
               taFiles(tnFileCount)    = tcDir + laFiles(m.I,1)
            ENDFOR

            *-- Busco los subdirectorios
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
      * CARGA EL MÓDULO INDICADO EN tc_InputFile Y DEVUELVE SU REFERENCIA DE OBJETO EN toModulo
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Nombre del archivo de entrada
      * toModulo                  (@?    OUT) Referencia de objeto del módulo generado (para Unit Testing)
      * toEx                      (@?    OUT) Objeto con información del error
      * tlRelanzarError           (v? IN    ) Indica si el error debe relanzarse o no
      * tcOriginalFileName        (v? IN    ) Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar
      *                                       el nombre correcto dentro de la versión texto (por ej: en los PJ2 y las cabeceras)
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, toModulo, toEx AS EXCEPTION, tlRelanzarError, tcOriginalFileName

      TRY
         LOCAL lnCodError, lcErrorInfo, laDirFile(1,5), lcExtension, lnFileCount, laFiles(1,1), I ;
            , ltFilestamp, lcExtA, lcExtB, laEvents(1,1), lnIDInputFile ;
            , loLang AS CL_LANG OF 'FOXBIN2PRG.PRG' ;
            , loConversor AS c_conversor_base OF 'FOXBIN2PRG.PRG' ;
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
               *ERROR 'No se encontró el archivo [' + .c_InputFile + ']'
               ERROR loLang.C_FILE_NOT_FOUND_LOC + ' [' + .c_InputFile + ']'
            ENDIF

            .c_InputFile    = loFSO.GetAbsolutePathName( FORCEPATH( laDirFile(1,1), JUSTPATH(.c_InputFile) ) )

            *-- VERIFICO SI HAY ARCHIVO DE CONFIGURACIÓN SECUNDARIO
            .evaluateConfiguration()


            IF NOT EMPTY(tcOriginalFileName)
               tcOriginalFileName  = loFSO.GetAbsolutePathName( tcOriginalFileName )
            ENDIF

            .c_OriginalFileName = EVL( tcOriginalFileName, .c_InputFile )

            IF UPPER( JUSTEXT(.c_OriginalFileName) ) = 'PJM' AND .c_PJ2 <> 'PJM'
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
               loConversor     = CREATEOBJECT( 'c_conversor_vcx_a_prg' )

            CASE lcExtension = 'SCX'
               loConversor     = CREATEOBJECT( 'c_conversor_scx_a_prg' )

            CASE lcExtension = 'PJX'
               loConversor     = CREATEOBJECT( 'c_conversor_pjx_a_prg' )

            CASE lcExtension = 'PJM' AND .c_PJ2 <> 'PJM'
               loConversor     = CREATEOBJECT( 'c_conversor_pjm_a_prg' )

            CASE lcExtension = 'FRX'
               loConversor     = CREATEOBJECT( 'c_conversor_frx_a_prg' )

            CASE lcExtension = 'LBX'
               loConversor     = CREATEOBJECT( 'c_conversor_frx_a_prg' )

            CASE lcExtension = 'DBF'
               loConversor     = CREATEOBJECT( 'c_conversor_dbf_a_prg' )

            CASE lcExtension = 'DBC'
               loConversor     = CREATEOBJECT( 'c_conversor_dbc_a_prg' )

            CASE lcExtension = 'MNX'
               loConversor     = CREATEOBJECT( 'c_conversor_mnx_a_prg' )

            CASE lcExtension = .c_VC2
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_vcx' )

            CASE lcExtension = .c_SC2
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_scx' )

            CASE lcExtension = .c_PJ2
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_pjx' )

            CASE lcExtension = .c_FR2
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_frx' )

            CASE lcExtension = .c_LB2
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_frx' )

            CASE lcExtension = .c_DB2
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_dbf' )

            CASE lcExtension = .c_DC2
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_dbc' )

            CASE lcExtension = .c_MN2
               loConversor     = CREATEOBJECT( 'c_conversor_prg_a_mnx' )

            OTHERWISE
               *ERROR 'El archivo [' + .c_InputFile + '] no está soportado'
               ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))

            ENDCASE

            .c_Type                             = UPPER(JUSTEXT(.c_OutputFile))
            loConversor.c_InputFile             = .c_InputFile
            loConversor.c_OutputFile            = .c_OutputFile
            loConversor.c_LogFile               = .c_LogFile
            loConversor.n_Debug                 = .n_Debug
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

            *-- Logueo los errores
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

         IF This.n_Debug > 0 THEN
            IF _VFP.STARTMODE = 0
               SET STEP ON
            ENDIF
         ENDIF
         IF tlRelanzarError  && Usado en Unit Testing
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
      * Obtengo la linea completa de comandos
      * Adaptado de http://www.news2news.com/vfp/?example=51&function=78
      * Facilitado por Mario Lopez en el foro FoxPro de Google Español - 23/12/2013
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
         , loLang AS CL_LANG OF 'FOXBIN2PRG.PRG'
      loLang          = _SCREEN.o_FoxBin2Prg_Lang

      WITH THIS AS c_foxbin2prg OF 'C_FOXBIN2PRG.PRG'
         lcLog   = ''
         .o_FNC.Capitalize( tcFileName, '', 'F', @lcLog, tlRelanzarError, '1' )

         IF .n_Debug >= 2 THEN
            lcLog   = SUBSTR(lcLog,3)
            .writeLog()
            .writeLog( C_TAB + TEXTMERGE(loLang.C_REQUESTING_CAPITALIZATION_OF_FILE_LOC) )
            .writeLog( lcLog )
         ENDIF
      ENDWITH
   ENDPROC



   PROCEDURE renameTmpFile2Tx2File
      LPARAMETERS tcFileName

      LOCAL lcTmpFile, loFSO AS Scripting.FileSystemObject, loEx AS EXCEPTION

      TRY
         *loFSO      = This.o_FSO
         lcTmpFile   = tcFileName + '.TMP'
         This.changeFileAttribute( tcFileName, '+N' )
         ERASE (tcFileName)
         RENAME (lcTmpFile) TO (tcFileName)

      CATCH TO loEx
         THROW

      FINALLY
         *loFSO  = .Null.
      ENDTRY

      RETURN
   ENDPROC



   PROCEDURE set_Line
      LPARAMETERS tcLine, taCodeLines, I
      EXTERNAL ARRAY taCodeLines

      tcLine  = LTRIM( taCodeLines(m.I), 0, CHR(9), ' ' )
   ENDPROC


   PROCEDURE errOut
      *-- DEVOLUCIÓN DE SALIDA A ERROUT (-12)
      LPARAMETERS tcTexto

      TRY
         IF This.l_StdOutHabilitado
            LOCAL loException AS EXCEPTION, lcOutput, lnOutHandle, lnBytesWritten, lnOverlappedIO
            lcOutput        = EVL(tcTexto,'') + CR_LF
            lnOutHandle     = fb2p_GetStdHandle(-12)    && CAPTURAR ERROR DESDE CONSOLA: FOXBIN2PRG.EXE PARAMS 2>&1 | FIND /V ""
            lnBytesWritten  = 0
            lnOverlappedIO  = 0
            fb2p_WriteFile(lnOutHandle, @lcOutput, LEN(lcOutput), @lnBytesWritten, @lnOverlappedIO)
         ENDIF

      CATCH TO loException
         This.l_StdOutHabilitado = .F.

      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE stdOut
      *-- DEVOLUCIÓN DE SALIDA A STDOUT (-11)
      LPARAMETERS tcTexto

      TRY
         IF This.l_StdOutHabilitado
            LOCAL loException AS EXCEPTION, lcOutput, lnOutHandle, lnBytesWritten, lnOverlappedIO
            lcOutput        = EVL(tcTexto,'') + CR_LF
            lnOutHandle     = fb2p_GetStdHandle(-11)    && CAPTURAR STDOUT DESDE CONSOLA: FOXBIN2PRG.EXE PARAMS | FIND /V ""
            lnBytesWritten  = 0
            lnOverlappedIO  = 0
            fb2p_WriteFile(lnOutHandle, @lcOutput, LEN(lcOutput), @lnBytesWritten, @lnOverlappedIO)
         ENDIF

      CATCH TO loException
         This.l_StdOutHabilitado = .F.

      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE updateProcessedFile
      *---------------------------------------------------------------------------------------------------
      * ACTUALIZA ALGUNOS DATOS DEL ARCHIVO PROCESADO ACTUAL
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tnID                      (v? IN    ) ID del archivo a actualizar. Si no se indica se asume el actual.
      * tcInOutType               (v? IN    ) Archivo de entrada o de salida ("I"=Input file, "O"=Output file)
      * tcProcessed               (v? IN    ) Procesado ("P0"=Not Processed, "P1"=Processed)
      * tcHasErrors               (v? IN    ) Tuvo Errores ("E0"=No Errors, "E1"=Has Errors)
      * tcSupported               (v? IN    ) Archivo soportado ("S0"=Unsupported, "S1"=Supported)
      * tcExpanded                (v? IN    ) Tipo de archivo ("X0"=Normal file, "X1"=Expanded multipart file)
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
         IF This.n_Debug > 0 THEN
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
            *-- Según el valor de nTimestamp:
            *-- 0 = Sin timestamp
            *-- 1 = Timestamp por delante
            *-- 2 = Timestamp por detrás
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
            *-- Según el valor de nTimestamp:
            *-- 0 = Sin timestamp
            *-- 1 = Timestamp por delante
            *-- 2 = Timestamp por detrás
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
         IF .n_Debug > 0 AND NOT EMPTY(.c_TextLog)
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
      * Modificación basada en la rutina RunExitCode.prg de William GC Steinford (nov 2002)
      * pero compatible con el método Run de WScript.Shell para su reemplazo cuando no es posible usarlo.
      * http://fox.wikis.com/wc.dll?Wiki~ProcessExitCode
      *-----------------------------------------------------------------------------------------------
      * 'Run' Parameter Documentation at: https://msdn.microsoft.com/en-us/library/d5fk67ky%28v=vs.84%29.aspx
      *-----------------------------------------------------------------------------------------------
      LPARAMETERS tcCmdLine, tnWindowStyle, tbWaitOnReturn, tlDebug
      * ? WScriptShell_Run("c:\windows\system32\cmd.exe /c dir c:\*.* > \temp\dir.txt")

      LOCAL lnWfSO, ln_dwFlags, ln_wShowWindow, lcStartInfo, lcProcessInfo, ln_hProcess, ln_hThread ;
         , lnExitCode, ln_dwProcessId, ln_dwThreadId, tcProgFile, laDirFile(1,5)

      TRY
         DECLARE SHORT CreateProcess IN WIN32API ;
            STRING lpszModuleName, ;
            STRING @lpszCommandLine, ;
            STRING lpSecurityAttributesProcess, ;
            STRING lpSecurityAttributesThread, ;
            SHORT bInheritHandles, ;
            INTEGER dwCreateFlags, ;
            STRING lpvEnvironment, ;
            STRING lpszStartupDir, ;
            STRING @lpStartInfo, ;
            STRING @lpProcessInfo

         DECLARE LONG WaitForSingleObject IN WIN32API INTEGER hHandle, LONG dwMilliseconds
         DECLARE INTEGER GetExitCodeProcess IN WIN32API INTEGER ln_hProcess, INTEGER @ lnExitCode
         DECLARE INTEGER CloseHandle IN kernel32.DLL INTEGER hObject
         *DECLARE INTEGER ShellExecuteEx IN Shell32 STRING @lpExecInfo
         DECLARE LONG ShellExecuteEx IN shell32.DLL STRING @
         DECLARE LONG HeapAlloc IN WIN32API LONG, LONG, LONG
         DECLARE LONG HeapFree IN WIN32API LONG, LONG, LONG
         DECLARE LONG GetProcessHeap IN WIN32API
         *DECLARE LONG WaitForSingleObject IN WIN32API LONG, LONG
         DECLARE LONG TerminateProcess IN WIN32API LONG, LONG

         * NOTA: Las constantes para VFP se pueden consultar en http://www.news2news.com/vfp/w32constants.php

         #DEFINE SEE_MASK_NOCLOSEPROCESS  0x00000040
         #DEFINE WAIT_MILLISECOND 3000

         #DEFINE SW_SHOW         5
         #DEFINE STILL_ACTIVE    0x103
         #DEFINE cnINFINITE      0xFFFFFFFF
         #DEFINE cnHalfASecond   500 && milliseconds
         #DEFINE cnTimedOut      0x0102

         *-- Constantes para WaitForSingleObject
         #DEFINE WAIT_ABANDONED  0x00000080
         #DEFINE WAIT_OBJECT_0   0x00000000
         #DEFINE WAIT_TIMEOUT    0x00000102
         #DEFINE WAIT_FAILED     0xFFFFFFFF

         tcProgFile      = EVL(tcProgFile, .NULL.)
         tcCmdLine       = EVL(tcCmdLine, .NULL.)

         DO CASE
         CASE VARTYPE(tbWaitOnReturn) = "L"
         CASE VARTYPE(tbWaitOnReturn) = "N"
            tbWaitOnReturn  = (tbWaitOnReturn=1)
         OTHERWISE
            ERROR 'Invalid value for tbWaitOnReturn parameter'
         ENDCASE

         IF VARTYPE(tnWindowStyle) # "N" OR NOT BETWEEN(tnWindowStyle, 0, 10) THEN
            tnWindowStyle   = 10
         ENDIF

         ln_dwFlags      = 1
         ln_wShowWindow  = tnWindowStyle

         * DOCUMENTACIÓN estructura _STARTUPINFO:
         * creates the STARTUP structure to specify main window
         * properties if a new window is created for a new process

         *| typedef struct _STARTUPINFO {
         *|     DWORD   cb;                4
         *|     LPTSTR  lpReserved;        4
         *|     LPTSTR  lpDesktop;         4
         *|     LPTSTR  lpTitle;           4
         *|     DWORD   dwX;               4
         *|     DWORD   dwY;               4
         *|     DWORD   dwXSize;           4
         *|     DWORD   dwYSize;           4
         *|     DWORD   dwXCountChars;     4
         *|     DWORD   dwYCountChars;     4
         *|     DWORD   dwFillAttribute;   4
         *|     DWORD   dwFlags;           4
         *|     WORD    wShowWindow;       2
         *|     WORD    cbReserved2;       2
         *|     LPBYTE  lpReserved2;       4
         *|     HANDLE  hStdInput;         4
         *|     HANDLE  hStdOutput;        4
         *|     HANDLE  hStdError;         4
         *| } STARTUPINFO, *LPSTARTUPINFO; total: 68 bytes
         lcStartInfo = BINTOC(68,'4RS') ;
            + BINTOC(0,'4RS') + BINTOC(0,'4RS') + BINTOC(0,'4RS') ;
            + BINTOC(0,'4RS') + BINTOC(0,'4RS') + BINTOC(0,'4RS') + BINTOC(0,'4RS') ;
            + BINTOC(0,'4RS') + BINTOC(0,'4RS') + BINTOC(0,'4RS') ;
            + BINTOC(ln_dwFlags,'4RS') ;
            + BINTOC(ln_wShowWindow,'2RS') ;
            + BINTOC(0,'2RS') + BINTOC(0,'4RS') ;
            + BINTOC(0,'4RS') + BINTOC(0,'4RS') + BINTOC(0,'4RS')

         lcProcessInfo = REPLICATE( CHR(0), 16 )

         * DOCUMENTACIÓN estructura _PROCESS_INFORMATION:
         * https://msdn.microsoft.com/en-us/library/windows/desktop/ms684873%28v=vs.85%29.aspx
         *    typedef struct _PROCESS_INFORMATION {
         *        HANDLE hProcess;
         *        HANDLE hThread;
         *        DWORD dwProcessId;
         *        DWORD dwThreadId;
         *    } PROCESS_INFORMATION;
         *

         IF CreateProcess( tcProgFile, tcCmdLine,0,0,0,0,0,0, lcStartInfo, @lcProcessInfo ) = 0

            *-- Segundo intento: Si se definió un archivo (ej: un TXT,LOG,etc) intento lanzarlo
            *-- con la aplicación predeterminada
            IF ADIR(laDirFile, tcCmdLine) = 1 THEN
               LOCAL lcInfo, lnHeap, lnLen, lnPtr

               *-- Ejemplo adaptado de: http://www.foxite.com/archives/0000316611.htm
               lnLen   = LEN(tcCmdLine) + 1
               lnHeap  = GetProcessHeap()
               lnPtr   = HeapAlloc(lnHeap, 0x8, 5 + lnLen)
               SYS(2600, lnPtr, 5, [open] + CHR(0))
               SYS(2600, lnPtr+5, lnLen, tcCmdLine + CHR(0))

               * DOCUMENTACIÓN estructura _SHELLEXECUTEINFO:
               * https://msdn.microsoft.com/en-us/library/windows/desktop/bb759784%28v=vs.85%29.aspx
               *typedef struct _SHELLEXECUTEINFO {
               *    DWORD     cbSize;            4
               *    ULONG     fMask;             4
               *    HWND      hwnd;              4
               *    LPCTSTR   lpVerb;            4
               *    LPCTSTR   lpFile;            4
               *    LPCTSTR   lpParameters;      4
               *    LPCTSTR   lpDirectory;       4
               *    int       nShow;             4
               *    HINSTANCE hInstApp;          4
               *    LPVOID    lpIDList;          4
               *    LPCTSTR   lpClass;           4
               *    HKEY      hkeyClass;         4
               *    DWORD     dwHotKey;          4
               *    union {
               *        HANDLE hIcon;
               *        HANDLE hMonitor;
               *    } DUMMYUNIONNAME;            4
               *    HANDLE    hProcess;          4
               *} SHELLEXECUTEINFO, *LPSHELLEXECUTEINFO;
               *

               lcInfo = ;
                  BINTOC(60, [4RS]) + ;
                  BINTOC(SEE_MASK_NOCLOSEPROCESS, [4RS]) + ;
                  BINTOC(0, [4RS]) + ;
                  BINTOC(lnPtr, [4RS]) + ;
                  BINTOC(lnPtr+5, [4RS]) + ;
                  BINTOC(0, [4RS]) + ;
                  BINTOC(0, [4RS]) + ;
                  BINTOC(1, [4RS]) + ;
                  REPLICATE(CHR(0), 28)

               IF ShellExecuteEx(@lcInfo) = 0
                  IF tlDebug
                     ? "Could not call process"
                  ENDIF
                  lnExitCode  = -1
                  EXIT
               ELSE
                  HeapFree(lnHeap, 0, lnPtr)
                  ln_hProcess = CTOBIN(RIGHT(lcInfo, 4), [4RS])
                  ln_hThread  = 0

                  IF tlDebug
                     ? "Process handle    = "+TRANSFORM(ln_hProcess)
                     ? "Thread handle     = "+TRANSFORM(ln_hThread)
                  ENDIF

                  *IF lnProcess != 0
                  *   WaitForSingleObject(ln_hProcess, WAIT_MILLISECOND)
                  *   IF tlDebug
                  *       ? "Terminating process!"
                  *   ENDIF
                  *   TerminateProcess(ln_hProcess, 0)
                  *ENDIF
               ENDIF

            ELSE
               IF tlDebug
                  ? "Could not create process"
               ENDIF
               lnExitCode  = -1
               EXIT
            ENDIF
         ELSE

            * Process and thread handles returned in ProcInfo structure
            ln_hProcess     = CTOBIN( LEFT( lcProcessInfo, 4 ), '4RS' )
            ln_hThread      = CTOBIN( SUBSTR( lcProcessInfo, 5, 4 ), '4RS' )
            ln_dwProcessId  = CTOBIN( SUBSTR( lcProcessInfo, 9, 4 ), '4RS' )
            ln_dwThreadId   = CTOBIN( SUBSTR( lcProcessInfo, 13, 4 ), '4RS' )

            IF tlDebug
               ? "Process handle    = "+TRANSFORM(ln_hProcess)
               ? "Thread handle     = "+TRANSFORM(ln_hThread)
               ? "Process handle id = "+TRANSFORM(ln_dwProcessId)
               ? "Thread handle id  = "+TRANSFORM(ln_dwThreadId)
            ENDIF
         ENDIF

         IF tbWaitOnReturn THEN
            * // Give the process time to execute and finish
            lnExitCode = STILL_ACTIVE

            DO WHILE lnExitCode = STILL_ACTIVE
               *lnWfSO = WaitForSingleObject(ln_hProcess, cnHalfASecond)
               lnWfSO  = WaitForSingleObject(ln_hProcess, cnINFINITE)

               IF tlDebug
                  ? 'lnWfSO = ' + TRANSFORM(lnWfSO)
               ENDIF

               IF GetExitCodeProcess(ln_hProcess, @lnExitCode) <> 0
                  DO CASE
                  CASE lnExitCode = STILL_ACTIVE
                     IF tlDebug
                        ? "Process is still active"
                     ENDIF
                  OTHERWISE
                     IF tlDebug
                        ? "Exit code = "+ TRANSFORM( lnExitCode )
                     ENDIF
                  ENDCASE
               ELSE
                  IF tlDebug
                     ? "GetExitCodeProcess() failed"
                  ENDIF
                  lnExitCode  = -2
               ENDIF

               DOEVENTS
            ENDDO
         ELSE
            lnExitCode  = 0
         ENDIF

         *-- DOCUMENTACIÓN sobre cierre procesos/threads:
         *-- https://msdn.microsoft.com/en-us/library/windows/desktop/ms682512%28v=vs.85%29.aspx
         =CloseHandle(ln_hProcess)
         =CloseHandle(ln_hThread)

         IF tlDebug
            ? '> FUNCTION RETURN VALUE = '
         ENDIF
      ENDTRY

      RETURN lnExitCode
   ENDFUNC


   FUNCTION FERROR_Message(tcFileName AS STRING)
      LOCAL lcMsg, lnError
      tcFileName  = EVL(tcFileName,'')
      lnError     = FERROR()

      DO CASE
      CASE lnError = 2
         lcMsg   = 'File not found'
      CASE lnError = 4
         lcMsg   = 'Too many files open (out of file handles)'
      CASE lnError = 5
         lcMsg   = 'Access denied'
      CASE lnError = 6
         lcMsg   = 'Invalid file handle given'
      CASE lnError = 8
         lcMsg   = 'Out of memory'
      CASE lnError = 25
         lcMsg   = [Seek error (can't seek before the start of a file)]
      CASE lnError = 29
         lcMsg   = 'Disk full'
      CASE lnError = 31
         lcMsg   = 'Error opening file'
      OTHERWISE
         lcMsg   = 'Unrecognized error trying to open the file ' + tcFileName
      ENDCASE

      RETURN lcMsg
   ENDFUNC


   FUNCTION getLocaleInfo
      LPARAMETERS tnSetting, tcLocale
      #DEFINE C_NULL CHR(0)
      LOCAL lcLocale, lnLen, lcBuffer, lnReturn, lcReturn

      IF VARTYPE(tcLocale) = 'C' AND NOT EMPTY(tcLocale)
         lcLocale = STRCONV(tcLocale, 5) + C_NULL
      ELSE
         lcLocale = .NULL.
      ENDIF

      DECLARE INTEGER GetLocaleInfoEx IN Win32API ;
         STRING locale, LONG TYPE, STRING @BUFFER, INTEGER LEN
      lnLen    = 255
      lcBuffer = SPACE(lnLen)
      lnReturn = GetLocaleInfoEx(lcLocale, tnSetting, @lcBuffer, lnLen)
      lcReturn = STRCONV(LEFT(lcBuffer, 2 * (lnReturn - 1)), 6)
      RETURN lcReturn
   ENDFUNC

   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   *
   *                       Properties Access Methods
   *
   * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   PROCEDURE n_Debug_ACCESS
      IF ISNULL(This.n_DebugP) THEN
         IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
            RETURN This.n_Debug
         ELSE
            RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_Debug, This.n_Debug )
         ENDIF
      ELSE
         RETURN This.n_DebugP
      ENDIF
   ENDPROC


   PROCEDURE n_BodyDevInfo_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_BodyDevInfo
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_BodyDevInfo, This.n_BodyDevInfo )
      ENDIF
   ENDPROC


   PROCEDURE l_ShowErrors_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_ShowErrors
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_ShowErrors, This.l_ShowErrors )
      ENDIF
   ENDPROC


   PROCEDURE n_ShowProgressbar_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_ShowProgressbar
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_ShowProgressbar, This.n_ShowProgressbar )
      ENDIF
   ENDPROC


   PROCEDURE l_NoTimestamps_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_NoTimestamps
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_NoTimestamps, This.l_NoTimestamps )
      ENDIF
   ENDPROC


   * additional options controlling
   * files in non subpath of the PJX
   PROCEDURE n_CheckFileInPath_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_CheckFileInPath
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_CheckFileInPath, This.n_CheckFileInPath )
      ENDIF
   ENDPROC

   * additional options controlling
   * - splitt of DBC separated from VCX/SCX
   * - new operations of DBF
   PROCEDURE l_OldFilesPerDBC_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_OldFilesPerDBC
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_OldFilesPerDBC, This.l_OldFilesPerDBC )
      ENDIF
   ENDPROC


   PROCEDURE n_UseFilesPerDBC_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_UseFilesPerDBC
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_UseFilesPerDBC, This.n_UseFilesPerDBC )
      ENDIF
   ENDPROC


   PROCEDURE l_RedirectFilePerDBCToMain_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_RedirectFilePerDBCToMain
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_RedirectFilePerDBCToMain, This.l_RedirectFilePerDBCToMain )
      ENDIF
   ENDPROC


   PROCEDURE l_ItemPerDBCCheck_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_ItemPerDBCCheck
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_ItemPerDBCCheck, This.l_ItemPerDBCCheck )
      ENDIF
   ENDPROC


   PROCEDURE l_DBF_BinChar_Base64_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_DBF_BinChar_Base64
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_DBF_BinChar_Base64, This.l_DBF_BinChar_Base64 )
      ENDIF
   ENDPROC


   PROCEDURE l_DBF_IncludeDeleted_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_DBF_IncludeDeleted
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_DBF_IncludeDeleted, This.l_DBF_IncludeDeleted )
      ENDIF
   ENDPROC


   PROCEDURE c_Language_In_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_Language_In
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_Language_In, This.c_Language_In )
      ENDIF
   ENDPROC


   PROCEDURE n_UseClassPerFile_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_UseClassPerFile
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_UseClassPerFile, This.n_UseClassPerFile )
      ENDIF
   ENDPROC


   PROCEDURE l_RedirectClassPerFileToMain_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_RedirectClassPerFileToMain
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_RedirectClassPerFileToMain, This.l_RedirectClassPerFileToMain )
      ENDIF
   ENDPROC


   PROCEDURE n_RedirectClassType_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_RedirectClassType
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_RedirectClassType, This.n_RedirectClassType )
      ENDIF
   ENDPROC


   PROCEDURE l_ClassPerFileCheck_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_ClassPerFileCheck
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_ClassPerFileCheck, This.l_ClassPerFileCheck )
      ENDIF
   ENDPROC


   PROCEDURE l_UseFormSettings_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_UseFormSettings
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_UseFormSettings, This.l_UseFormSettings )
      ENDIF
   ENDPROC


   PROCEDURE n_UseFormPerFile_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_UseFormPerFile
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_UseFormPerFile, This.n_UseFormPerFile )
      ENDIF
   ENDPROC


   PROCEDURE l_RedirectFormPerFileToMain_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_RedirectFormPerFileToMain
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_RedirectFormPerFileToMain, This.l_RedirectFormPerFileToMain )
      ENDIF
   ENDPROC


   PROCEDURE n_RedirectFormType_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_RedirectFormType
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_RedirectFormType, This.n_RedirectFormType )
      ENDIF
   ENDPROC


   PROCEDURE l_FormPerFileCheck_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_FormPerFileCheck
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_FormPerFileCheck, This.l_FormPerFileCheck )
      ENDIF
   ENDPROC



   PROCEDURE l_RemoveNullCharsFromCode_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_RemoveNullCharsFromCode
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_RemoveNullCharsFromCode, This.l_RemoveNullCharsFromCode )
      ENDIF
   ENDPROC


   PROCEDURE l_RemoveZOrderSetFromProps_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_RemoveZOrderSetFromProps
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_RemoveZOrderSetFromProps, This.l_RemoveZOrderSetFromProps )
      ENDIF
   ENDPROC

   PROCEDURE n_InhibitInheritance_ACCESS
      * only from base config (and only if this is from parameter)
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( 1 ) )
         RETURN This.n_InhibitInheritance
      ELSE
         RETURN NVL( This.o_Configuration( 1 ).n_InhibitInheritance, This.n_InhibitInheritance )
      ENDIF
   ENDPROC

   PROCEDURE l_ClearUniqueID_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_ClearUniqueID
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_ClearUniqueID, This.l_ClearUniqueID )
      ENDIF
   ENDPROC


   PROCEDURE l_ClearDBFLastUpdate_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_ClearDBFLastUpdate
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_ClearDBFLastUpdate, This.l_ClearDBFLastUpdate )
      ENDIF
   ENDPROC


   PROCEDURE n_OptimizeByFilestamp_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_OptimizeByFilestamp
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_OptimizeByFilestamp, This.n_OptimizeByFilestamp )
      ENDIF
   ENDPROC


   PROCEDURE n_ExtraBackupLevels_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_ExtraBackupLevels
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_ExtraBackupLevels, This.n_ExtraBackupLevels )
      ENDIF
   ENDPROC


   PROCEDURE c_VC2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_VC2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_VC2, This.c_VC2 )
      ENDIF
   ENDPROC


   PROCEDURE c_SC2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_SC2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_SC2, This.c_SC2 )
      ENDIF
   ENDPROC


   PROCEDURE c_PJ2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_PJ2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_PJ2, This.c_PJ2 )
      ENDIF
   ENDPROC


   PROCEDURE c_FR2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_FR2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_FR2, This.c_FR2 )
      ENDIF
   ENDPROC


   PROCEDURE c_LB2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_LB2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_LB2, This.c_LB2 )
      ENDIF
   ENDPROC


   PROCEDURE c_DB2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_DB2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_DB2, This.c_DB2 )
      ENDIF
   ENDPROC


   PROCEDURE c_DC2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_DC2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_DC2, This.c_DC2 )
      ENDIF
   ENDPROC


   PROCEDURE c_MN2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_MN2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_MN2, This.c_MN2 )
      ENDIF
   ENDPROC


   PROCEDURE c_FK2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_FK2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_FK2, This.c_FK2 )
      ENDIF
   ENDPROC


   PROCEDURE c_ME2_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_ME2
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_ME2, This.c_ME2 )
      ENDIF
   ENDPROC


   PROCEDURE n_PJX_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_PJX_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_PJX_Conversion_Support, This.n_PJX_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_VCX_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_VCX_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_VCX_Conversion_Support, This.n_VCX_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_SCX_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_SCX_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_SCX_Conversion_Support, This.n_SCX_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_FRX_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_FRX_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_FRX_Conversion_Support, This.n_FRX_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_LBX_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_LBX_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_LBX_Conversion_Support, This.n_LBX_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_DBC_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_DBC_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_DBC_Conversion_Support, This.n_DBC_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_DBF_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_DBF_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_DBF_Conversion_Support, This.n_DBF_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_MNX_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_MNX_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_MNX_Conversion_Support, This.n_MNX_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_FKY_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_FKY_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_FKY_Conversion_Support, This.n_FKY_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE n_MEM_Conversion_Support_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_MEM_Conversion_Support
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_MEM_Conversion_Support, This.n_MEM_Conversion_Support )
      ENDIF
   ENDPROC


   PROCEDURE c_DBF_Conversion_Included_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_DBF_Conversion_Included
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_DBF_Conversion_Included, This.c_DBF_Conversion_Included )
      ENDIF
   ENDPROC


   PROCEDURE c_DBF_Conversion_Excluded_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_DBF_Conversion_Excluded
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_DBF_Conversion_Excluded, This.c_DBF_Conversion_Excluded )
      ENDIF
   ENDPROC


   PROCEDURE c_BackgroundImage_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.c_BackgroundImage
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).c_BackgroundImage, This.c_BackgroundImage )
      ENDIF
   ENDPROC


   PROCEDURE n_ExcludeDBFAutoincNextval_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_ExcludeDBFAutoincNextval
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_ExcludeDBFAutoincNextval, This.n_ExcludeDBFAutoincNextval )
      ENDIF
   ENDPROC


   PROCEDURE n_PRG_Compat_Level_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_PRG_Compat_Level
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_PRG_Compat_Level, This.n_PRG_Compat_Level )
      ENDIF
   ENDPROC


   PROCEDURE n_HomeDir_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.n_HomeDir
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).n_HomeDir, This.n_HomeDir )
      ENDIF
   ENDPROC

   PROCEDURE l_AllowFolder_ACCESS
      IF This.n_CFG_Actual = 0 OR ISNULL( This.o_Configuration( This.n_CFG_Actual ) )
         RETURN This.l_AllowFolder
      ELSE
         RETURN NVL( This.o_Configuration( This.n_CFG_Actual ).l_AllowFolder, This.l_AllowFolder )
      ENDIF
   ENDPROC


ENDDEFINE
