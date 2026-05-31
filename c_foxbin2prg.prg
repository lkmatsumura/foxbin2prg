
#INCLUDE 'foxbin2prg.h'

Define Class c_foxbin2prg As Session
    _MemberData = [<VFPData>] ;
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

    Dimension a_ProcessedFiles(1, 6)
    Protected n_CFG_Actual, l_Main_CFG_Loaded, o_Configuration, l_CFG_CachedAccess
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
    c_TempDir                       = Sys(2023)
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
    o_Conversor                     = .Null.
    o_Frm_Avance                    = .Null.
    o_WSH                           = .Null.
    o_FSO                           = .Null.            && Scripting.FileSystemObject
    o_TextStream                    = .Null.            && Scripting.TextStream
    o_FNC                           = .Null.            && Filename_caps object
    o_Configuration                 = .Null.
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

    Procedure Init
        LPARAMETERS tcCFG_File, tcCancelWithEscKey

        #If .F.
            Local This As c_foxbin2prg Of 'c_foxbin2prg.PRG'
        #Endif

        Local lcSys16, lnPosProg, lc_Foxbin2prg_EXE, laValues(1,5), lcPicturePath, laDir(1,5) ;
            , lcLang

        Set Deleted On
        Set Date YMD
        Set Hours To 24
        Set Century On
        Set Safety Off
        Set Multilocks On
        Set TablePrompt Off
        Set Point To '.'
        Set Separator To ','

        tcCancelWithEscKey  = Evl(tcCancelWithEscKey, '')

        If Not Empty(tcCancelWithEscKey)
            This.l_CancelWithEscKey = ( tcCancelWithEscKey == '1' )
        Endif

        This.declareDLL()

        If Atc("\PROGRAM FILES", This.c_TempDir) > 0 Or Atc("\ARCHIVOS DE PROGRAMA", This.c_TempDir) > 0
            This.c_TempDir  = Getenv("TEMP")
        Endif

        This.c_LogFile      = Addbs( This.c_TempDir ) + 'FoxBin2Prg_Debug.LOG'
        This.c_ErrorLogFile = Addbs( This.c_TempDir ) + 'FoxBin2Prg_Error.LOG'

        If Adir(laDir, This.c_ErrorLogFile) > 0 Then
            If Adir(laDir, This.c_ErrorLogFile + '.BAK') > 0 Then
                This.changeFileAttribute( This.c_ErrorLogFile + '.BAK', '-R-S-H' )
                Erase (This.c_ErrorLogFile + '.BAK')
            Endif

            This.changeFileAttribute( This.c_ErrorLogFile, '-R-S-H' )
            Rename (This.c_ErrorLogFile) To (This.c_ErrorLogFile + '.BAK')
        Endif

        If Adir(laDir, This.c_LogFile) > 0 Then
            Erase (This.c_LogFile + '.BAK')
            Rename (This.c_LogFile) To (This.c_LogFile + '.BAK')
        Endif

        lcSys16 = Sys(16)
        If Left(lcSys16,10) == 'PROCEDURE '
            lnPosProg   = At(" ", lcSys16, 2) + 1
        Else
            lnPosProg   = 1
        Endif

        && Directorio actual, que no necesariamente es donde está FoxBin2Prg
        This.c_CurDir                   = Sys(5) + Curdir()

        This.c_Foxbin2prg_FullPath      = Substr( lcSys16, lnPosProg )
        This.c_Foxbin2prg_ConfigFile    = Evl( tcCFG_File, Forceext( This.c_Foxbin2prg_FullPath, 'CFG' ) )
        This.c_BackgroundImage          = This.get_AbsolutePath( Addbs(Justpath(This.c_Foxbin2prg_FullPath)) + 'foxbin2prg.jpg' )
        lc_Foxbin2prg_EXE               = Forceext( This.c_Foxbin2prg_FullPath, 'EXE' )

        This.c_FB2PRG_EXE_Version       = 'v' + Transform(This.c_FB2PRG_Version_Real)

        AddProperty(_Screen, 'c_FB2PRG_EXE_Version', This.c_FB2PRG_EXE_Version)
        AddProperty(_Screen, 'ExitCode', 0)

        This.writeLog( Replicate( '*', 100 ) )
        This.writeLog( 'FoxBin2Prg INIT  -', 2 )
        This.writeLog( Replicate( '*', 100 ) )
        This.writeLog( 'FoxBin2Prg: [' + This.c_Foxbin2prg_FullPath + '] (EXE Version: ' + This.c_FB2PRG_EXE_Version + ', FoxPro Version: ' + Version(4) + ')' )
        This.writeLog( Textmerge( '- Internal CFG: <<SYS(2019,2)>> / External CFG: <<SYS(2019,1)>> / CodePage Used: <<CPCURRENT()>>)' ) )

        * Get default language info
        * ISO 639-2 Language Codes: https://www.loc.gov/standards/iso639-2/php/code_list.php
        lcLang  = This.getLocaleInfo(0x00000067) && ie: spa

        Do Case
            Case lcLang = 'spa'
                lcLang = 'ES'

            Case Inlist(lcLang, 'den', 'deu', 'ger', 'gmh', 'goh', 'gsw', 'nds')
                lcLang = 'DE'

            Case Inlist(lcLang, 'cpf', 'fra', 'fre', 'frm', 'fro')
                lcLang = 'FR'

            Otherwise && Default: EN
                lcLang = 'EN'
        Endcase

        This.changeLanguage(lcLang)

        This.o_FSO           = Createobject("Scripting.FileSystemObject")
        This.o_Configuration = Createobject("COLLECTION")

        This.o_CFG           = Createobject('CL_CFG')
        This.o_CFG.CopyFrom(This)
        This.evaluateConfiguration()
        Release lcSys16, lnPosProg, lc_Foxbin2prg_EXE, laValues
        Return
    Endproc


    Procedure Destroy
        Try
                Local lcFileCDX
                lcFileCDX   = Forcepath( "TABLABIN.CDX", Justpath(This.c_InputFile) )

                Erase ( lcFileCDX )

                This.writeLog( 'FoxBin2Prg UNLOAD  -', 2 )
                This.writeLog( Replicate( '*', 100 ) )
                This.writeLog( )
                This.writeLog_Flush()
                This.unloadProgressbarForm()
                This.o_Configuration    = .Null.
                This.o_WSH              = .Null.
                This.o_FSO              = .Null.
                If Vartype(_Screen.o_FoxBin2Prg_Lang) = "O" Then
                    _Screen.o_FoxBin2Prg_Lang = .Null.
                Endif
            Catch

            Finally
                This.o_FSO  = .Null.
                This.o_WSH  = .Null.
                This.o_FNC  = .Null.
                *-- Funciones para changeFileAttributes
                Clear Dlls fb2p_SetFileAttributes, fb2p_GetFileAttributes
                *-- Funciones para escribir en StdOut
                Clear Dlls fb2p_GetStdHandle, fb2p_WriteFile
                *-- Funciones para changeFileTime
                Clear Dlls fb2p_SetFileTime, fb2p_GetFileAttributesEx, fb2p_LocalFileTimeToFileTime ;
                    , fb2p_FileTimeToSystemTime, fb2p_SystemTimeToFileTime, fb2p_lopen, fb2p_lclose

        Endtry

        Return
    Endproc


    Procedure addProcessedFile
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcFile                    (v? IN    ) Path del archivo (ej: 'C:\DESA\pruebas varias\lib.vcx')
* tcInOutType               (v? IN    ) Archivo de entrada o de salida ("I"=Input file, "O"=Output file)
* tcProcessed               (v? IN    ) Procesado ("P0"=Not Processed, "P1"=Processed)
* tcHasErrors               (v? IN    ) Tuvo Errores ("E0"=No Errors, "E1"=Has Errors)
* tcSupported               (v? IN    ) Archivo soportado ("S0"=Unsupported, "S1"=Supported)
* tcExpanded                (v? IN    ) Tipo de archivo ("X0"=Normal file, "X1"=Expanded multipart file)
*---------------------------------------------------------------------------------------------------
        Lparameters tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded

        Local llAdded

        If Not Empty(tcFile) Then
            With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                *-- Buscar si fue procesado antes
                If Not .wasProcessed(tcFile) Then
                    .n_ProcessedFiles   = .n_ProcessedFiles + 1
                    Dimension .a_ProcessedFiles(.n_ProcessedFiles, 6)
                    .a_ProcessedFiles(.n_ProcessedFiles, 1) = tcFile
                    .a_ProcessedFiles(.n_ProcessedFiles, 2) = Evl(tcInOutType, '')
                    .a_ProcessedFiles(.n_ProcessedFiles, 3) = Evl(tcProcessed, '')
                    .a_ProcessedFiles(.n_ProcessedFiles, 4) = Evl(tcHasErrors, '')
                    .a_ProcessedFiles(.n_ProcessedFiles, 5) = Evl(tcSupported, '')
                    .a_ProcessedFiles(.n_ProcessedFiles, 6) = Evl(tcExpanded, '')
                    llAdded = .T.
                Endif
            Endwith
        Endif

        Return llAdded
    Endproc


    Procedure wasProcessed
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcFileMask                (v! IN    ) Fullpath del archivo del que se desea saber si se procesó
*---------------------------------------------------------------------------------------------------
        Lparameters tcFile, tnID

        tnID = 0

        If This.n_ProcessedFiles = 0
            Return .F.
        Endif

        tnID = Ascan( This.a_ProcessedFiles, tcFile, 1, 0, 1, 1+2+4 )

        Return (tnID > 0)
    Endproc


    Procedure updateProgressbar
        Lparameters tcTexto, tnValor, tnTotal, tnTipo

        Try
*-- Si o_Frm_Avance se habilitó de forma externa, n_ShowProgressbar podría ser 0 para controlarlo desde fuera.
                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    If Vartype(.o_Frm_Avance) = "O" Then
*-- Cuando esta rutina se invoca desde el script, este método es el #1 y no puede cancelarse todavía
                        If .o_Frm_Avance.l_Cancelled And Program(-1) > 1 Then
                            Error 1799
                        Endif
                        .o_Frm_Avance.updateProgressbar( tcTexto, tnValor, tnTotal, tnTipo )
                    Endif
                Endwith

            Catch
                Throw
        Endtry
    Endproc


    Procedure changeLanguage
        Lparameters tcLanguageId
        _Screen.AddProperty( "o_FoxBin2Prg_Lang", Createobject("CL_LANG", tcLanguageId) )
        *-- Localized properties
        This.c_Language                 = _Screen.o_FoxBin2Prg_Lang.C_LANGUAGE_LOC
        This.c_loc_processing_file      = _Screen.o_FoxBin2Prg_Lang.C_PROCESSING_LOC
        This.c_loc_process_progress     = _Screen.o_FoxBin2Prg_Lang.C_PROCESS_PROGRESS_LOC
    Endproc


    Procedure clearProcessedFiles
    *-- Limpia las estadísticas de archivos procesados que se usan para optimizar
    *-- el procesamiento y evitar el reproceso de los mismos archivos, por ejemplo,
    *-- de un mismo VCX compartido por 2 ó más proyectos.
        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            .n_ProcessedFilesCount  = 0
            .n_ProcessedFiles       = 0
            Dimension .a_ProcessedFiles(1, 6)
            .a_ProcessedFiles       = ''
            *-- Los errores previos también se limpian.
            .l_Error                = .F.
            .l_Errors               = .F.
        Endwith
    Endproc


    Procedure declareDLL

        *-- Funciones para escribir en StdOut
        Declare Integer 'GetStdHandle' In WIN32API As fb2p_GetStdHandle Integer nHandleType
        Declare Integer 'WriteFile'    In WIN32API As fb2p_WriteFile Integer hFile, String @ cBuffer, Integer nBytes, Integer @ nBytes2, Integer @ nBytes3
        *-- Funciones para changeFileTime
        Declare Integer 'SetFileTime'             In WIN32API As fb2p_SetFileTime Integer hFile, String  lpCreationTime, String  lpLastAccessTime, String  lpLastWriteTime
        Declare Integer 'GetFileAttributesEx'     In Win32API As fb2p_GetFileAttributesEx String  lpFileName, Integer fInfoLevelId, String  @ lpFileInformation
        Declare Integer 'SystemTimeToFileTime'    In Win32API As fb2p_SystemTimeToFileTime String  lpSYSTEMTIME, String  @ FILETIME
        Declare Integer 'FileTimeToSystemTime'    In Win32API As fb2p_FileTimeToSystemTime String FILETIME, String @ SYSTEMTIME
        Declare Integer 'LocalFileTimeToFileTime' In Win32API As fb2p_LocalFileTimeToFileTime String LOCALFILETIME, String @ FILETIME
        Declare Integer '_lopen'  In Win32API As fb2p_lopen String lpFileName, Integer iReadWrite
        Declare Integer '_lclose' In Win32API As fb2p_lclose Integer hFile
        *-- Funciones para changeFileAttributes
        Declare SHORT   'SetFileAttributes' In Win32API As fb2p_SetFileAttributes String tcFileName, Integer dwFileAttributes
        Declare Integer 'GetFileAttributes' In Win32API As fb2p_GetFileAttributes String tcFileName

    Endproc


    Procedure get_AbsolutePath
        Lparameters tc_InputFile, tc_FullPath

        *-- Ajusto la ruta si no es absoluta
        tc_InputFile    = Evl(tc_InputFile,'')
        tc_FullPath     = Evl(tc_FullPath, This.c_Foxbin2prg_FullPath)

        If Not Empty( Justext(tc_FullPath) ) Then
            *-- Se indicó PATH+archivo.ext
            tc_FullPath = Justpath(tc_FullPath)
        Endif

        tc_FullPath = Addbs( tc_FullPath )

        If     Len(tc_InputFile) > 1 ;
           AND Left(Ltrim(tc_InputFile),2) <> '\\' ;
           AND Substr(Ltrim(tc_InputFile),2,1) <> ':' Then

            tc_InputFile    = Fullpath(tc_InputFile, tc_FullPath)
        Endif

        Return tc_InputFile
    Endproc


    Function get_l_ConfigEvaluated
        Return This.l_Main_CFG_Loaded
    Endfunc


    Function get_l_CFG_CachedAccess
        Return This.l_CFG_CachedAccess
    Endfunc


    Function get_Processed
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
        Lparameters taProcessed, tcFileMask

        External Array taProcessed

        Local lnCount, I
        lnCount = 0

        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            tcFileMask  = Evl(tcFileMask, '*')

            For I = 1 To .n_ProcessedFiles
                If Like( tcFileMask, Justfname(.a_ProcessedFiles(m.I,1)) ) Then
                    lnCount = lnCount + 1
                    Dimension taProcessed(lnCount,6)
                    taProcessed(lnCount,1)  = .a_ProcessedFiles(m.I,1)
                    taProcessed(lnCount,2)  = .a_ProcessedFiles(m.I,2)
                    taProcessed(lnCount,3)  = .a_ProcessedFiles(m.I,3)
                    taProcessed(lnCount,4)  = .a_ProcessedFiles(m.I,4)
                    taProcessed(lnCount,5)  = .a_ProcessedFiles(m.I,5)
                    taProcessed(lnCount,6)  = .a_ProcessedFiles(m.I,6)
                Endif
            Endfor
        Endwith

        Return lnCount
    Endfunc

    Procedure changeFileAttribute
        * Using Win32 Functions in Visual FoxPro
        * example=103
        * Changing file attributes
        Lparameters  tcFileName, tcAttrib
        tcAttrib    = Upper(tcAttrib)

        #Define FILE_ATTRIBUTE_READONLY     1
        #Define FILE_ATTRIBUTE_HIDDEN       2
        #Define FILE_ATTRIBUTE_SYSTEM       4
        #Define FILE_ATTRIBUTE_DIRECTORY    16
        #Define FILE_ATTRIBUTE_ARCHIVE      32
        #Define FILE_ATTRIBUTE_NORMAL       128
        #Define FILE_ATTRIBUTE_TEMPORARY    512
        #Define FILE_ATTRIBUTE_COMPRESSED   2048

        Try
                Local loEx As Exception, dwFileAttributes, dwFileAttributes_Orig, lnRet
                lnRet   = 0

                * read current attributes for this file
                dwFileAttributes        = fb2p_GetFileAttributes(tcFileName)
                dwFileAttributes_Orig   = dwFileAttributes

                If dwFileAttributes = -1
                   * the file does not exist
                    Exit
                Endif

                If dwFileAttributes > 0
                    If '+R' $ tcAttrib
                        dwFileAttributes = Bitor(dwFileAttributes, FILE_ATTRIBUTE_READONLY)
                    Endif
                    If '+A' $ tcAttrib
                        dwFileAttributes = Bitor(dwFileAttributes, FILE_ATTRIBUTE_ARCHIVE)
                    Endif
                    If '+S' $ tcAttrib
                        dwFileAttributes = Bitor(dwFileAttributes, FILE_ATTRIBUTE_SYSTEM)
                    Endif
                    If '+H' $ tcAttrib
                        dwFileAttributes = Bitor(dwFileAttributes, FILE_ATTRIBUTE_HIDDEN)
                    Endif
                    If '+D' $ tcAttrib
                        dwFileAttributes = Bitor(dwFileAttributes, FILE_ATTRIBUTE_DIRECTORY)
                    Endif
                    If '+N' $ tcAttrib
                        dwFileAttributes = Bitor(dwFileAttributes, FILE_ATTRIBUTE_NORMAL)
                    Endif
                    If '+T' $ tcAttrib
                        dwFileAttributes = Bitor(dwFileAttributes, FILE_ATTRIBUTE_TEMPORARY)
                    Endif
                    If '+C' $ tcAttrib
                        dwFileAttributes = Bitor(dwFileAttributes, FILE_ATTRIBUTE_COMPRESSED)
                    Endif

                    If '-R' $ tcAttrib And Bitand(dwFileAttributes, FILE_ATTRIBUTE_READONLY) = FILE_ATTRIBUTE_READONLY
                        dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_READONLY
                    Endif
                    If '-A' $ tcAttrib And Bitand(dwFileAttributes, FILE_ATTRIBUTE_ARCHIVE) = FILE_ATTRIBUTE_ARCHIVE
                        dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_ARCHIVE
                    Endif
                    If '-S' $ tcAttrib And Bitand(dwFileAttributes, FILE_ATTRIBUTE_SYSTEM) = FILE_ATTRIBUTE_SYSTEM
                        dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_SYSTEM
                    Endif
                    If '-H' $ tcAttrib And Bitand(dwFileAttributes, FILE_ATTRIBUTE_HIDDEN) = FILE_ATTRIBUTE_HIDDEN
                        dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_HIDDEN
                    Endif
                    If '-D' $ tcAttrib And Bitand(dwFileAttributes, FILE_ATTRIBUTE_DIRECTORY) = FILE_ATTRIBUTE_DIRECTORY
                        dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_DIRECTORY
                    Endif
                    If '-N' $ tcAttrib And Bitand(dwFileAttributes, FILE_ATTRIBUTE_NORMAL) = FILE_ATTRIBUTE_NORMAL
                        dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_NORMAL
                    Endif
                    If '-T' $ tcAttrib And Bitand(dwFileAttributes, FILE_ATTRIBUTE_TEMPORARY) = FILE_ATTRIBUTE_TEMPORARY
                        dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_TEMPORARY
                    Endif
                    If '-C' $ tcAttrib And Bitand(dwFileAttributes, FILE_ATTRIBUTE_COMPRESSED) = FILE_ATTRIBUTE_COMPRESSED
                        dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_COMPRESSED
                    Endif

                    * setting selected attributes
                    lnRet   = fb2p_SetFileAttributes(tcFileName, dwFileAttributes)
                Endif

            Catch To loEx
                Throw

            Finally
                This.writeLog( C_TAB + Lower(Program()) + ' >> [' + tcFileName + '] lnRet = ' + Transform(lnRet) + ', dwFileAttributes_Orig = ' + Transform(dwFileAttributes_Orig) )
                Release tcFileName, tcAttrib, dwFileAttributes
        Endtry

        Return lnRet
    Endproc


    Procedure changeFileTime
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
        Lparameters m.tcFileName, m.tcTimeType, m.tnYear, m.tnMonth, m.tnDay, m.tnHour, m.tnMinute, m.tnSec, m.tnThou

        #Define OF_READWRITE     2

        Local m.lpFileInformation, m.cS, m.nPar, m.fh, M.lpFileInformation, m.lpSysTime, m.cCreation ;
            , M.cLastAccess, m.cLastWrite, m.cBuffTime, m.cBuffTime1, M.cTT,m.nYear1, m.nMonth1, m.nDay1, m.nHour1 ;
            , M.nMinute1, m.nSec1, m.nThou1, llRetorno

        Try
                m.nPar      = Pcount()

                If m.nPar < 1
                    Exit
                Endif

                m.cTT       = Iif( m.nPar >= 2 And Vartype(m.tcTimeType) = "C" And Not Empty(m.tcTimeType), Lower(Substr(m.tcTimeType,1,1)), "c" )
                m.nYear1    = Iif( m.nPar >= 3 And Vartype(m.tnYear) $ "FIN" And m.tnYear >= 1800, Round(m.tnYear,0), -1 )
                m.nMonth1   = Iif( m.nPar >= 4 And Vartype(m.tnMonth) $ "FIN" And Between(m.tnMonth,1,12), Round(m.tnMonth,0), -1 )
                m.nDay1     = Iif( m.nPar >= 5 And Vartype(m.tnDay) $ "FIN" And Between(m.tnDay,1,31), Round(m.tnDay,0), -1 )
                m.nHour1    = Iif( m.nPar >= 6 And Vartype(m.tnHour) $ "FIN" And Between(m.tnHour,0,23), Round(m.tnHour,0), -1 )
                m.nMinute1  = Iif( m.nPar >= 7 And Vartype(m.tnMinute) $ "FIN" And Between(m.tnMinute,0,59), Round(m.tnMinute,0), -1 )
                m.nSec1     = Iif( m.nPar >= 8 And Vartype(m.tnSec) $ "FIN" And Between(m.tnSec,0,59), Round(m.tnSec,0), -1 )
                m.nThou1    = Iif( m.nPar >= 9 And Vartype(m.tnThou) $ "FIN" And Between(m.tnThou,0,999), Round(m.tnThou,0), -1 )
                m.lpFileInformation = Replicate( Chr(0), 53 )   && just a buffer
                m.lpSysTime = Replicate( Chr(0), 16 )           && just a buffer

                If fb2p_GetFileAttributesEx(m.tcFileName, 0, @lpFileInformation) = 0
                    Exit
                Endif

                m.cCreation   = Substr(m.lpFileInformation,5,8)
                m.cLastAccess = Substr(m.lpFileInformation,13,8)
                m.cLastWrite  = Substr(m.lpFileInformation,21,8)
                m.cBuffTime   = Iif(m.cTT="w",m.cLastWrite, Iif(m.cTT="a",m.cLastAccess,m.cCreation))

                fb2p_FileTimeToSystemTime(m.cBuffTime, @lpSysTime)

                m.lpSysTime = ;
                    IIF( m.nYear1 >= 0, BinToC(m.nYear1,"2RS"), Substr(m.lpSysTime,1,2) ) ;
                    + Iif( m.nMonth1 >= 0, BinToC(m.nMonth1,"2RS"), Substr(m.lpSysTime,3,2) ) ;
                    + Substr(m.lpSysTime,5,2) ;
                    + Iif( m.nDay1 >= 0, BinToC(m.nDay1,"2RS"), Substr(m.lpSysTime,7,2) ) ;
                    + Iif( m.nHour1 >= 0, BinToC(m.nHour1,"2RS"), Substr(m.lpSysTime,9,2) ) ;
                    + Iif( m.nMinute1 >= 0, BinToC(m.nMinute1,"2RS"), Substr(m.lpSysTime,11,2) ) ;
                    + Iif( m.nSec1 >= 0, BinToC(m.nSec1,"2RS"), Substr(m.lpSysTime,13,2) ) ;
                    + Iif( m.nThou1 >= 0, BinToC(m.nThou1,"2RS"), Substr(m.lpSysTime,15,2) )

                fb2p_SystemTimeToFileTime(m.lpSysTime,@cBuffTime)
                m.cBuffTime1    = m.cBuffTime
                fb2p_LocalFileTimeToFileTime(m.cBuffTime1,@cBuffTime)

                Do Case
                    Case m.cTT = "w"
                        m.cLastWrite=m.cBuffTime
                    Case m.cTT = "a"
                        m.cLastAccess=m.cBuffTime
                    Otherwise && "c"
                        m.cCreation=m.cBuffTime
                Endcase

                m.fh = fb2p_lopen (m.tcFileName, OF_READWRITE)

                If m.fh < 0
                    Exit
                Endif

                fb2p_SetFileTime (m.fh,m.cCreation, m.cLastAccess, m.cLastWrite)
                fb2p_lclose(m.fh)
                llRetorno = .T.
        Endtry

        Return llRetorno
    Endproc


    Procedure compileFoxProBinary
        Lparameters tcFileName
        Local lcType

        tcFileName  = Evl(tcFileName, This.c_OutputFile)
        lcType      = Upper(Justext(tcFileName))

        Do Case
            Case lcType = 'VCX'
                Compile Classlib (tcFileName)

            Case lcType = 'SCX'
                Compile Form (tcFileName)

            Case lcType = 'FRX'
                Compile Report (tcFileName)

            Case lcType = 'LBX'
                Compile Label (tcFileName)

            Case lcType = 'DBC'
                Compile Database (tcFileName)

        Endcase

        Release tcFileName, lcType
        Return
    Endproc


    Procedure doBackup
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toEx                      (@? IN    ) Objeto Exception con información del error
* tlRelanzarError           (v? IN    ) Indica si se debe relanzar el error
* tcBakFile_1               (@?    OUT) Nombre del archivo backup 1 (vcx,scx,pjx,frx,lbx,dbf,dbc,mnx,vc2,sc2,pj2,etc)
* tcBakFile_2               (@?    OUT) Nombre del archivo backup 2 (vct,sct,pjt,frt,lbt,fpt,dct,mnt,etc)
* tcBakFile_3               (@?    OUT) Nombre del archivo backup 3 (cdx,dcx,etc)
* tcOutputFile              (v? IN    ) Nombre del archivo de salida. Si no se indica se asume .c_OutputFile
*---------------------------------------------------------------------------------------------------
        Lparameters toEx, tlRelanzarError, tcBakFile_1, tcBakFile_2, tcBakFile_3, tcOutputFile

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcNext_Bak, lcExt_1, lcExt_2, lcExt_3, tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3, laDir(1,5) ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
                Store '' To tcBakFile_1, tcBakFile_2, tcBakFile_3, lcExt_1, lcExt_2, lcExt_3 ;
                    , tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3

                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    If .n_ExtraBackupLevels > 0 Then
                        loLang          = _Screen.o_FoxBin2Prg_Lang
                        tcOutputFile    = Evl( tcOutputFile, .c_OutputFile )
                        lcNext_Bak      = .getNext_BAK( tcOutputFile )
                        lcExt_1         = Justext( tcOutputFile )
                        tcBakFile_1     = Forceext(tcOutputFile, lcExt_1 + lcNext_Bak)

                        Do Case
                            Case Inlist( lcExt_1, .c_PJ2, .c_VC2, .c_SC2, .c_FR2, .c_LB2, .c_DB2, .c_DC2, .c_MN2, .c_FK2, .c_ME2, 'PJM' )
*-- Extensiones TEXTO

                            Case lcExt_1 = 'DBF'
*-- DBF
                                lcExt_2     = 'FPT'
                                lcExt_3     = 'CDX'
                                tcBakFile_2 = Forceext(tcOutputFile, lcExt_2 + lcNext_Bak)
                                tcBakFile_3 = Forceext(tcOutputFile, lcExt_3 + lcNext_Bak)

                            Case lcExt_1 = 'DBC'
*-- DBC
                                lcExt_2     = 'DCT'
                                lcExt_3     = 'DCX'
                                tcBakFile_2 = Forceext(tcOutputFile, lcExt_2 + lcNext_Bak)
                                tcBakFile_3 = Forceext(tcOutputFile, lcExt_3 + lcNext_Bak)

                            Case Inlist( lcExt_1, 'PJX', 'VCX', 'SCX', 'FRX', 'LBX', 'MNX' )
*-- PJX, VCX, SCX, FRX, LBX, MNX
                                lcExt_2     = Left(lcExt_1,2) + 'T'
                                tcBakFile_2 = Forceext(tcOutputFile, lcExt_2 + lcNext_Bak)

                            Otherwise
*-- PKY, MEM

                        Endcase

                        If Not Empty(lcExt_1)
                            tcOutputFile_Ext1   = Forceext(tcOutputFile, lcExt_1)

                            If Adir( laDir, tcOutputFile_Ext1 ) > 0 Then
*-- LOG
                                Do Case
                                    Case Empty(lcExt_2)
                                        .writeLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 )
                                    Case Empty(lcExt_3)
                                        .writeLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 + '/' + lcExt_2 )
                                    Otherwise
                                        .writeLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 + '/' + lcExt_2 + '/' + lcExt_3 )
                                Endcase

*-- COPIA BACKUP
                                Copy File ( tcOutputFile_Ext1 ) To ( tcBakFile_1 )

                                If Not Empty(lcExt_2)
                                    tcOutputFile_Ext2   = Forceext(tcOutputFile, lcExt_2)

                                    If Adir( laDir, tcOutputFile_Ext2 ) > 0 Then
                                        Copy File ( tcOutputFile_Ext2 ) To ( tcBakFile_2 )
                                    Endif
                                Endif

                                If Not Empty(lcExt_3)
                                    tcOutputFile_Ext3   = Forceext(tcOutputFile, lcExt_3)

                                    If Adir( laDir, tcOutputFile_Ext3 ) > 0 Then
                                        Copy File ( tcOutputFile_Ext3 ) To ( tcBakFile_3 )
                                    Endif
                                Endif
                            Endif
                        Endif
                    Endif
                Endwith && THIS

            Catch To toEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                If tlRelanzarError
                    Throw
                Endif

            Finally
                Release toEx, tlRelanzarError, tcBakFile_1, tcBakFile_2, tcBakFile_3 ;
                    , lcNext_Bak, lcExt_1, lcExt_2, lcExt_3, tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3 ;
                    , tcOutputFile
        Endtry

        Return
    Endproc


    Procedure loadProgressbarForm
        If Vartype(This.o_Frm_Avance) <> "O" Then
            This.o_Frm_Avance   = Createobject("frm_avance", This)
            This.o_Frm_Avance.Show()
        Endif
    Endproc


    Procedure unloadProgressbarForm
        Lparameters tlForceUnload
        If (tlForceUnload Or This.n_ShowProgressbar <> 0) And Vartype(This.o_Frm_Avance) = "O" Then
            This.o_Frm_Avance.Hide()
            This.o_Frm_Avance.Release()
            This.o_Frm_Avance = .Null.
        Endif
    Endproc


    Procedure evaluateConfiguration
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
        Lparameters tcDontShowProgress, tcDontShowErrors, tcNoTimestamps, tcDebug, tcRecompile, tcExtraBackupLevels ;
            , tcClearUniqueID, tcOptimizeByFilestamp, tc_InputFile, tcInputFile_Type, toParentCFG, tl_ForceLog, tcCFG_File

        #If .F.
            Local toParentCFG As CL_CFG Of 'FOXBIN2PRG.PRG'
        #Endif

        Local lcConfigFile, lcLockFile, llExiste_CFG_EnDisco, llLockFileExists, llFirstRead, laConfig(1), I, lcConfData, lcExt, lcValue, lc_CFG_Path, lcConfigLine, laDirInfo(1,5) ;
            , lnDirs, laDirs(1), llMasterEval, lcProp ;
            , lo_CFG As CL_CFG Of 'FOXBIN2PRG.PRG' ;
            , loCFG_Manual As CL_CFG Of 'FOXBIN2PRG.PRG' ;
            , lo_Configuration As Collection ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
            , loEx As Exception, llSetSingleConfig, lc_Foxbin2prg_ConfigFile, lc_InputPath

        Try
                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'

                    If Inlist( Transform(tcDebug), '0', '1', '2' ) Then
                     .writeLog( C_TAB + ' > Parameter tcDebug: ' + tcDebug +;
                      IIF(ISNULL(This.n_DebugP), "", ", will be ignored, second use of parameter. Using: " + TRANSFORM(This.n_DebugP) )+CR_LF )
                     IF ISNULL(This.n_DebugP) THEN
                        This.n_Debug    = Int(Val(tcDebug))
                        This.n_DebugP   = This.n_Debug
                     ENDIF &&ISNULL(This.n_DebugP)
                    Endif

                    Store 0 To lnKey
                    llSetSingleConfig = .Null.

                    loLang              = _Screen.o_FoxBin2Prg_Lang
                    tcRecompile         = Evl(tcRecompile, .c_Recompile)
                    lo_Configuration    = .o_Configuration

                    *!* is a config file given by programm parameter
                    IF VARTYPE(tcCFG_File)='C' AND !EMPTY(tcCFG_File) THEN
                        IF EMPTY(lo_Configuration.GetKey(tcCFG_File)) THEN
                            This.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC6+tcCFG_File )


                            .l_Main_CFG_Loaded         = .F.
                            *restore default
                            .o_CFG.CopyFrom(.o_CFG,This)

                            lc_Foxbin2prg_ConfigFile   = .c_Foxbin2prg_ConfigFile
                            .c_Foxbin2prg_ConfigFile  = tcCFG_File

                            .o_Configuration.Remove(-1)
                            .n_CFG_EvaluateFromParam  = 0
                            .l_SingleConfig            = .F.

                            llSetSingleConfig         = .T.
                            .writeLog( '> ' + Upper(loLang.C_USING_THIS_SETTINGS_LOC) + ': ' + .c_Foxbin2prg_ConfigFile + ;
                             loLang.C_USING_THIS_SETTINGS_LOC1 )

                        Else &&EMPTY(lo_Configuration.GetKey(tcCFG_File))
                             This.writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC6+tcCFG_File + loLang.C_USING_THIS_SETTINGS_LOC7+;
                                             ICASE(This.n_InhibitInheritance=0, loLang.C_USING_THIS_SETTINGS_LOC2,;
                                                   This.n_InhibitInheritance=1, loLang.C_USING_THIS_SETTINGS_LOC3,;
                                                   This.n_InhibitInheritance=2, loLang.C_USING_THIS_SETTINGS_LOC4,;
                                                   This.n_InhibitInheritance=3, loLang.C_USING_THIS_SETTINGS_LOC5," Failure."+CR_LF))

                        ENDIF &&EMPTY(lo_Configuration.GetKey(tcCFG_File))
                    ENDIF &&VARTYPE(tcCFG_File)='C' AND !EMPTY(tcCFG_File)


                    lcConfigFile        = .c_Foxbin2prg_ConfigFile
                    tc_InputFile        = Evl(tc_InputFile, .c_InputFile)
                    tcInputFile_Type    = Evl(tcInputFile_Type,'')

                    If Vartype(lcConfigFile) = "O"
                        loCFG_Manual    = lcConfigFile  && lcConfigFile is an object CFG generated by get_DirSettings()
                        toParentCFG     = loCFG_Manual
                        lcConfigFile    = Fullpath('Personalized-CFG-Object', tc_InputFile)
                        loCFG_Manual.c_Foxbin2prg_ConfigFile    = 'Personalized-CFG-Object'
                    Else
                        loCFG_Manual    = .Null.
                    Endif

                    If Vartype(toParentCFG) <> 'O' OR llSetSingleConfig Then
                        toParentCFG         = .Null.
                    Endif

                    If Isnull(toParentCFG) Then
                        .c_InputFile        = tc_InputFile
                    Endif

*-- Determino el tipo de InputFile (Archivo o Directorio)
                    If Empty(tcInputFile_Type) And Not Empty(tc_InputFile)
                        Do Case
                            Case Len(tc_InputFile) = 1
                                tcInputFile_Type    = C_FILETYPE_QUERYSUPPORT
                                lc_InputPath        = ""

                            Case Adir(laDirInfo, tc_InputFile, "D") = 1 And Substr( laDirInfo(1,5), 5, 1 ) = "D"
                                tcInputFile_Type    = C_FILETYPE_DIRECTORY
                                lc_InputPath        = tc_InputFile

                            Otherwise
                                tcInputFile_Type    = C_FILETYPE_FILE
                                lc_InputPath        = JUSTPATH(tc_InputFile)

                        Endcase
                    Else
                        If Empty(tc_InputFile) THEN
                                lc_InputPath        = ""

                        ELSE  &&Empty(tc_InputFile)
                            Do Case
                                Case tcInputFile_Type==C_FILETYPE_QUERYSUPPORT
                                    lc_InputPath        = ""

                                Case tcInputFile_Type==C_FILETYPE_DIRECTORY
                                    lc_InputPath        = tc_InputFile

                                Otherwise
*                               tcInputFile_Type    = C_FILETYPE_FILE
                                    lc_InputPath        = JUSTPATH(tc_InputFile)

                            Endcase
                        ENDIF &&Empty(tc_InputFile)
                    Endif

                    *!* just the single config from programm parameter, or sub dirs of the config file given by the parameter
                    *!* more sophisticated control of inheritance for para file
                    lc_InputPath = UPPER(lc_InputPath)
                    DO CASE
                     CASE !.l_SingleConfig
                          * just go ahead

                     CASE .n_InhibitInheritance=0
                           * read all

                     CASE Empty(lc_InputPath)
                           * whatever, just go ahead

                     CASE .n_InhibitInheritance=3
                           * read nothing
                           EXIT

                     CASE INLIST(.n_InhibitInheritance,1,2) AND lc_InputPath=.c_SingleConfig_Folder
                          * just in the directory or subdirectory of the config file set by the parameter

                     CASE .n_InhibitInheritance=1 AND .c_SingleConfig_Folder=lc_InputPath
                          * just above the config file set by the parameter

                     Otherwise
                          EXIT

                    ENDCASE


                    If .l_Main_CFG_Loaded And Not Empty(tc_InputFile) And Not tcInputFile_Type == C_FILETYPE_QUERYSUPPORT Then
                        If .n_CFG_EvaluateFromParam = 1
* Si se indicó por parámetro (modo objeto), usarlo como Maestro
* Se saltea solo esta evaluación, y luego se usa la variable para determinar el Nº de CFG a usar.
                            .n_CFG_EvaluateFromParam = -1 && Luego se cambia por el Nº de CFG que corresponda.
                        Else
                            If tcInputFile_Type == C_FILETYPE_DIRECTORY Then
* INDICÓ DIRECTORIO
                                If Isnull(loCFG_Manual)
*lcConfigFile   = FULLPATH( 'foxbin2prg.cfg', ADDBS(tc_InputFile) )
                                    lcConfigFile = Fullpath( Justfname(lcConfigFile), Addbs(tc_InputFile) )
                                Endif
                            Else
* INDICÓ ARCHIVO
                                If Isnull(loCFG_Manual)
*lcConfigFile   = FULLPATH( 'foxbin2prg.cfg', tc_InputFile )
                                    lcConfigFile = Fullpath( Justfname(lcConfigFile), tc_InputFile )
                                Endif
                            Endif
                        Endif
                    Endif

                    lo_Configuration    = .o_Configuration
                    .n_CFG_Actual       = 0
                    .l_CFG_CachedAccess = .F.
                    lc_CFG_Path         = Upper( Justpath( lcConfigFile ) )
                    lcLockFile          = FORCEPATH(".FoxBin2Prg_Ignore",lc_CFG_Path)
                    lo_CFG              = This

*-- Búsqueda del CFG del PATH indicado en la caché
                    If .l_Main_CFG_Loaded

                        If lo_Configuration.Count > 0 Then
                            If .n_CFG_EvaluateFromParam > 1
* Especial: Si hay una configuración de bloqueo (CFG Manual), se usa
                                .n_CFG_Actual = .n_CFG_EvaluateFromParam
                            Else
* Normalmente se buscará el CFG del directorio analizado
                                .n_CFG_Actual       = lo_Configuration.GetKey( lcConfigFile )   && 0 = No hay CFG cacheada, >0 = Hay CFG cacheada
                            Endif

                            If .n_CFG_Actual > 0 Then
                                lo_CFG          = lo_Configuration.Item(.n_CFG_Actual)
                                .l_CFG_CachedAccess = .T.

                                If Not Isnull(loCFG_Manual)
* Si le paso un objeto CFG, prevalece sobre el guardado
                                    lo_CFG.CopyFrom(@loCFG_Manual)
                                Endif
                            Endif
                        Endif

*-- Si no se pasó un CFG padre y no hay CFGs o no encuentra el del PATH indicado, analizo la jararquía
*!* LScheffler 30.08.2023 only read path if no config by parameter
                        If Isnull(llSetSingleConfig);
                                AND Isnull(toParentCFG);
                                And (lo_Configuration.Count = 0 Or .n_CFG_Actual = 0);
                                AND !This.c_Foxbin2prg_ConfigFile==tc_InputFile Then
                            llMasterEval    = .T.
                            toParentCFG     = This

                            If Left( lc_CFG_Path, 2 ) == '\\' Then
*lnDirs = OCCURS( '\', lc_CFG_Path ) - 3
                                lnDirs  = Occurs( '\', lc_CFG_Path ) - 2
                            Else
                                lnDirs  = Occurs( '\', lc_CFG_Path )
                            Endif

                            If lnDirs > 0 Then
                                Dimension laDirs(lnDirs)

*-- Creo el array con los PATH intermedios
                                For I = lnDirs To 1 Step -1
                                    If m.I = lnDirs Then
                                        laDirs(m.I) = Justpath(lc_CFG_Path)
                                    Else
                                        laDirs(m.I) = Justpath(laDirs(m.I+1))
                                    Endif
                                Endfor

                                If lnDirs = 1 And laDirs(1) = lc_CFG_Path
*-- Cuando no hay PATH intermedios, salteo esta parte para que más abajo lo agregue. 04/02/2016. FDBOZZO
*-- Ejemplo: Puede pasar cuando se convierte un archivo en C:\ u otro disco RAIZ.
                                Else
*-- Ahora evalúo las configuraciones de los PATH intermedios desde la raíz en adelante
*-- y mantengo la última configuración CFG Padre en toParentCFG para usarla como base.
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
*-- Si no se encontró un CFG cacheado, se busca si existe un archivo CFG en disco
                            llExiste_CFG_EnDisco    = ( Adir( laDirInfo, lcConfigFile ) = 1 )
                            llLockFileExists        = ( Adir( laDirInfo, lcLockFile ) = 1 )

                            If Not llExiste_CFG_EnDisco
                                .l_CFG_CachedAccess = .T.   && Es cacheado porque sin archivo CFG usa config.interna
                            Endif

                        Case Isnull( .o_Configuration( .n_CFG_Actual ) )
*-- Si existe una configuración y es NULL, es la predeterminada.
*-- Este es el primer objeto CFG en cargarse cuando se inicializa FoxBin2Prg,
*-- y corresponde a la ruta de instalación del EXE (ej: c:\desa\foxbin2prg\foxbin2prg.cfg)
                            lo_CFG          = This

                    Endcase

                    If .l_Main_CFG_Loaded
                        If .l_CFG_CachedAccess And .n_CFG_Actual > 0 Then
                            toParentCFG = lo_CFG
                            .writeLog( '> ' + Upper(loLang.C_USING_THIS_SETTINGS_LOC) + ': ' + lo_CFG.c_Foxbin2prg_ConfigFile + '  => ' + tc_InputFile + ;
                                ' CFG_Actual:' + Transform(.n_CFG_Actual) + Icase(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]')  )
                        Else
                            lo_CFG  = Createobject('CL_CFG')
                            lo_Configuration.Add( lo_CFG, lcConfigFile )
                            .n_CFG_Actual   = lo_Configuration.Count

                            .writeLog( '> ' + Upper(loLang.C_CACHING_CONFIG_FOR_DIRECTORY_LOC) + ': ' + lcConfigFile + ;
                                ' CFG_Actual:' + Transform(.n_CFG_Actual) + Icase(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]')  )

                            If Not Isnull(toParentCFG)
                                lo_CFG.CopyFrom(@toParentCFG)
                                toParentCFG = lo_CFG
*                               .writeLog( C_TAB + '- ' + loLang.C_INHERITING_FROM_LOC + ': ' + lo_CFG.c_Foxbin2prg_ConfigFile )
                                .writeLog( C_TAB + '- ' + loLang.C_INHERITING_FROM_LOC + ': ' + lo_Configuration.GetKey(lo_Configuration.Count-1) )
                            ENDIF
                            llFirstRead = .T.
                        Endif

                    Else
                        lo_Configuration.Add( .Null., lcConfigFile )    && La .Null. se carga solo cuando no hay Main_CFG_loaded todavía.
                        .n_CFG_Actual   = lo_Configuration.Count
                    Endif

*check for lockfile
                    If .l_Main_CFG_Loaded And llFirstRead AND llLockFileExists THEN
                     lo_CFG.l_AllowFolder = .F.
                     .writeLog( C_TAB + Justfname(lcLockFile) + loLang.C_LOCKINGFOLDER_LOC )
                    ENDIF &&.l_Main_CFG_Loaded And llFirstRead AND llLockFileExists

*-- NOTA: SOLO LOS QUE NO VENGAN DE PARÁMETROS EXTERNOS DEBEN ASIGNARSE A lo_CFG AQUÍ.
                    If llExiste_CFG_EnDisco And Not .l_CFG_CachedAccess AND lo_CFG.l_AllowFolder Then
                        .writeLog()
                        .writeLog( '> ' + loLang.C_READING_CFG_VALUES_FROM_DISK_LOC + ':' )
                        .writeLog( C_TAB + loLang.C_CONFIGFILE_LOC + ' ' + lcConfigFile )

                        lo_CFG.c_Foxbin2prg_ConfigFile      = lcConfigFile

                        For I = 1 To Alines( laConfig, Filetostr( lcConfigFile ), 1+4 )
                            .set_Line( @lcConfigLine, @laConfig, m.I )
                            .get_SeparatedLineAndComment( @lcConfigLine )
                            laConfig(m.I)       = Lower( lcConfigLine )

                            Do Case
                                Case Empty( laConfig(m.I) ) Or Inlist( Left( laConfig(m.I), 1 ), '*', '#', '/', "'" )
                                    Loop

*settings for internal work, not processing
* Depricated:
                                Case Left( laConfig(m.I), 17 ) == Lower('DontShowProgress:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 18 ) )
                                    If Not Inlist( Transform(tcDontShowProgress), '0', '1', '2' ) And Inlist( lcValue, '0', '1', '2' ) Then
                                        tcDontShowProgress  = lcValue
                                        lo_CFG.n_ShowProgressbar    = Icase(lcValue=='0',1, lcValue=='1',0, 2)
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > tcDontShowProgress:         ' + Transform(tcDontShowProgress) )
                                    Endif

                                Case Left( laConfig(m.I), 9 ) == Lower('Language:')
*-- CASO ESPECIAL: El lenguaje no se guarda en lo_CFG, porque es un seteo Global.
                                    lcValue = Alltrim( Substr( laConfig(m.I), 10 , IIF('&'+'&'$laConfig(m.I), At('&'+'&', laConfig(m.I)) - 10, LEN(laConfig(m.I) ) ) ) )
                                    .changeLanguage(lcValue)
                                    lo_CFG.c_Language_In = m.lcValue
                                    .writeLog( C_TAB + Justfname(lcConfigFile) + ' > Language:                   ' + Transform(lcValue) + ' (' + .c_Language + ')' )

                                Case Left( laConfig(m.I), 16 ) == Lower('ShowProgressbar:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_ShowProgressbar    = Int( Val(lcValue) )
                                        tcDontShowProgress  = ''
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > ShowProgressbar:            ' + lcValue )
                                    Endif

                                Case Left( laConfig(m.I), 15 ) == Lower('DontShowErrors:')
*-- Priorizo si tcDontShowErrors NO viene con "0" como parámetro, ya que los scripts vbs
*-- los utilizan para sobreescribir la configuración por defecto de foxbin2prg.cfg
                                    lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                                    If Not Inlist( Transform(tcDontShowErrors), '0', '1' ) And Inlist( lcValue, '0', '1' ) Then
                                        tcDontShowErrors    = lcValue
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > tcDontShowErrors:           ' + Transform(tcDontShowErrors) )
                                    Endif

                                Case Left( laConfig(m.I), 18 ) == Lower('ExtraBackupLevels:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 19 ) )
                                    If Not Isdigit( Transform(tcExtraBackupLevels) ) And Isdigit( lcValue ) Then
                                        tcExtraBackupLevels = lcValue
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > tcExtraBackupLevels:        ' + Transform(tcExtraBackupLevels) )
                                    Endif

                                Case Left( laConfig(m.I), 16 ) == Lower('BackgroundImage:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                                    Do Case
                                        Case Empty(lcValue)
                                            lo_CFG.c_BackgroundImage    = lcValue
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' > BackgroundImage:            (Empty)' )

                                        Case Adir( laDirInfo, lcValue ) > 0
                                            lo_CFG.c_BackgroundImage    = lcValue
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' > BackgroundImage:            ' + Transform(lo_CFG.c_BackgroundImage) )

                                        Otherwise
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' > BackgroundImage:            File not found:  ' + Transform(lo_CFG.c_BackgroundImage) )

                                    Endcase
                                Case Left( laConfig(m.I), 6 ) == Lower('Debug:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 7 ) )
                                    If Not Inlist( Transform(tcDebug), '0', '1' ) And Inlist( lcValue, '0', '1' ) Then
                                        IF ISNULL(This.n_DebugP) THEN
                                         lo_CFG.n_Debug = Int(Val(lcValue))
                                        ENDIF &&ISNULL(This.n_DebugP)
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > Debug:                      ' + lcValue +;
                                         IIF(ISNULL(This.n_DebugP), "", ", will be ignored, debug set via parameter. Using: " + TRANSFORM(This.n_DebugP) ) )
                                    Endif

*** DH 2021-03-04: handle n_HomeDir configuration setting
                                Case Left( laConfig(m.I), 8 ) == Lower('HomeDir:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 9 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.n_HomeDir    = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > HomeDir:                    ' + Transform(lo_CFG.n_HomeDir) )
                                    Endif
*** DH 2021-03-04: end of new code
**************
*Conversion operation by type
                                Case Left( laConfig(m.I), 23 ) == Lower('PJX_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_PJX_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > PJX_Conversion_Support:     ' + Transform(lo_CFG.n_PJX_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('VCX_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_VCX_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > VCX_Conversion_Support:     ' + Transform(lo_CFG.n_VCX_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('SCX_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_SCX_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > SCX_Conversion_Support:     ' + Transform(lo_CFG.n_SCX_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('FRX_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_FRX_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > FRX_Conversion_Support:     ' + Transform(lo_CFG.n_FRX_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('LBX_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_LBX_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > LBX_Conversion_Support:     ' + Transform(lo_CFG.n_LBX_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('MNX_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_MNX_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > MNX_Conversion_Support:     ' + Transform(lo_CFG.n_MNX_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('DBF_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1', '2', '4', '8' ) Then
                                        lo_CFG.n_DBF_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_Conversion_Support:     ' + Transform(lo_CFG.n_DBF_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('DBC_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_DBC_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBC_Conversion_Support:     ' + Transform(lo_CFG.n_DBC_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('FKY_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.n_FKY_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > FKY_Conversion_Support:     ' + Transform(lo_CFG.n_FKY_Conversion_Support) )
                                    Endif

                                Case Left( laConfig(m.I), 23 ) == Lower('MEM_Conversion_Support:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 24 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.n_MEM_Conversion_Support = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > MEM_Conversion_Support:     ' + Transform(lo_CFG.n_MEM_Conversion_Support) )
                                    Endif


*-------- setting for container files (not pjx) --------
*Classes and forms ( vcx / scx)

*!* Changed by: LScheffler 19.03.2023
* additional options controlling
* files in non subpath of the PJX
                                Case Left( laConfig(m.I), 16 ) == Lower('CheckFileInPath:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                                    If Inlist( lcValue, '0', '1', '2', '3' ) Then
                                        lo_CFG.n_CheckFileInPath    = Int( Val(lcValue) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > CheckFileInPath:            ' + Transform(lcValue) )
                                    Endif
*!* /Changed by: LScheffler 19.03.2023

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - splitt of DBC separated from VCX/SCX
* - new operations of DBF
*VCX
                                Case Left( laConfig(m.I), 16 ) == Lower('UseClassPerFile:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_UseClassPerFile    = Int( Val(lcValue) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseClassPerFile:            ' + Transform(lcValue) )
                                        If !lo_CFG.l_OldFilesPerDBC Then
                                            lo_CFG.n_UseFilesPerDBC             = lo_CFG.n_UseClassPerFile
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + '  => UseFilesPerDBC:           ' + Transform(lcValue) )
                                        Endif
                                        If !lo_CFG.l_UseFormSettings Then
                                            lo_CFG.n_UseFormPerFile             = lo_CFG.n_UseClassPerFile
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + '  => UseFormPerFile:           ' + Transform(lcValue) )
                                        Endif
                                    Endif

                                Case Left( laConfig(m.I), 27 ) == Lower('RedirectClassPerFileToMain:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 28 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_RedirectClassPerFileToMain = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectClassPerFileToMain: ' + Transform(lcValue) )
                                        If !lo_CFG.l_OldFilesPerDBC Then
                                            lo_CFG.l_RedirectFilePerDBCToMain   = lo_CFG.l_RedirectClassPerFileToMain
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + '  => RedirectFilePerDBCToMain: ' + Transform(lcValue) )
                                        Endif
                                        If !lo_CFG.l_UseFormSettings Then
                                            lo_CFG.l_RedirectFormPerFileToMain  = lo_CFG.l_RedirectClassPerFileToMain
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + '  => RedirectFormPerFileToMain ' + Transform(lcValue) )
                                        Endif
                                    Endif

*!* Changed by: LScheffler 04.3.2021
*!* change date="{^2021-03-04,13:12:00}"
* new value 2, just add one class
                                Case Left( laConfig(m.I), 18 ) == Lower('RedirectClassType:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 19 ) )
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_RedirectClassType  = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectClassType:          ' + Transform(lcValue) )
                                        If !lo_CFG.l_UseFormSettings Then
                                            lo_CFG.n_RedirectFormType           = lo_CFG.n_RedirectClassType
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + '  => RedirectFormType          ' + Transform(lcValue) )
                                        Endif
                                    Endif
*!* /Changed by: LScheffler 04.3.2021

                                Case Left( laConfig(m.I), 18 ) == Lower('ClassPerFileCheck:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 19 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_ClassPerFileCheck  = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > ClassPerFileCheck:          ' + Transform(lcValue) )
                                        If !lo_CFG.l_OldFilesPerDBC Then
                                            lo_CFG.l_ItemPerDBCCheck            = lo_CFG.l_ClassPerFileCheck
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + '  => ItemPerDBCCheck:          ' + Transform(lcValue) )
                                        Endif
                                        If !lo_CFG.l_UseFormSettings Then
                                            lo_CFG.l_FormPerFileCheck           = lo_CFG.l_ClassPerFileCheck
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + '  => FormPerFileCheck          ' + Transform(lcValue) )
                                        Endif
                                    Endif
*!* /Changed by: LScheffler 21.02.2021
*/VCX

*Forms
                                Case Left( laConfig(m.I), 16 ) == Lower('UseFormSettings:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_UseFormSettings    = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseFormSettings:            ' + Transform(lcValue) )
                                        If !lo_CFG.l_UseFormSettings Then
                                            lo_CFG.n_UseFormPerFile             = lo_CFG.n_UseClassPerFile
                                            lo_CFG.l_RedirectFormPerFileToMain  = lo_CFG.l_RedirectClassPerFileToMain
                                            lo_CFG.n_RedirectFormType           = lo_CFG.n_RedirectClassType
                                            lo_CFG.l_FormPerFileCheck           = lo_CFG.l_ClassPerFileCheck
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> UseFormPerFile:            ' + Transform(lo_CFG.n_UseFormPerFile) )
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> RedirectFormPerFileToMain: ' + Transform(lo_CFG.l_RedirectFormPerFileToMain) )
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> n_RedirectFormType:        ' + Transform(lo_CFG.n_RedirectFormType) )
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> FormPerFileCheck:          ' + Transform(lo_CFG.l_FormPerFileCheck) )
                                        Endif
                                    Endif

                                Case Left( laConfig(m.I), 15 ) == Lower('UseFormPerFile:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                                    If lo_CFG.l_UseFormSettings AND Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_UseFormPerFile = Int( Val(lcValue) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseFormPerFile:             ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 26 ) == Lower('RedirectFormPerFileToMain:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 27 ) )
                                    If lo_CFG.l_UseFormSettings AND Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_RedirectFormPerFileToMain  = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectFormPerFileToMain:  ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 17 ) == Lower('RedirectFormType:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 18 ) )
                                    If lo_CFG.l_UseFormSettings AND Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_RedirectFormType   = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectFormType:           ' + Transform(lcValue) )
                                    Endif
*!* /Changed by: LScheffler 04.3.2021

                                Case Left( laConfig(m.I), 17 ) == Lower('FormPerFileCheck:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 18 ) )
                                    If lo_CFG.l_UseFormSettings AND Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_FormPerFileCheck   = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > FormPerFileCheck:           ' + Transform(lcValue) )
                                    Endif
*/Forms

*Databases
                                Case Left( laConfig(m.I), 15 ) == Lower('OldFilesPerDBC:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_OldFilesPerDBC = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > OldFilesPerDBC:             ' + Transform(lcValue) )
                                        If !lo_CFG.l_OldFilesPerDBC Then
                                            lo_CFG.n_UseFilesPerDBC             = lo_CFG.n_UseClassPerFile
                                            lo_CFG.l_RedirectFilePerDBCToMain   = lo_CFG.l_RedirectClassPerFileToMain
                                            lo_CFG.l_ItemPerDBCCheck            = lo_CFG.l_ClassPerFileCheck
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> UseFilesPerDBC:           ' + Transform(lo_CFG.n_UseFilesPerDBC) )
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> RedirectFilePerDBCToMain: ' + Transform(lo_CFG.l_RedirectFilePerDBCToMain) )
                                            .writeLog( C_TAB + Justfname(lcConfigFile) + ' ==> ItemPerDBCCheck:          ' + Transform(lo_CFG.l_ItemPerDBCCheck) )
                                        Endif
                                    Endif

                                Case Left( laConfig(m.I), 15 ) == Lower('UseFilesPerDBC:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 16 ) )
                                    If lo_CFG.l_OldFilesPerDBC And Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.n_UseFilesPerDBC = Int( Val(lcValue) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > UseFilesPerDBC:             ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 25 ) == Lower('RedirectFilePerDBCToMain:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 26 ) )
                                    If lo_CFG.l_OldFilesPerDBC And Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_RedirectFilePerDBCToMain   = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > RedirectFilePerDBCToMain:   ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 16 ) == Lower('ItemPerDBCCheck:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 17 ) )
                                    If lo_CFG.l_OldFilesPerDBC And Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_ItemPerDBCCheck    = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > ItemPerDBCCheck:            ' + Transform(lcValue) )
                                    Endif
*/Databases
*/-------- setting for container files (not pjx) --------

*!* LScheffler 30.08.2023
                                Case Left( laConfig(m.I), 19 ) == Lower('InhibitInheritance:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                                    If Inlist( lcValue, '0', '1' , '2' , '3' ) Then
                                        IF llSetSingleConfig THEN
                                         lo_CFG.n_InhibitInheritance    =  Int( Val( lcValue ) )
                                        ENDIF &&llSetSingleConfig

                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > InhibitInheritance:         ' + Transform(lcValue) +;
                                        IIF(m.llSetSingleConfig, "", ", will be ignored, standard configuration file." ) )
                                    ENDIF

*general files
                                Case Left( laConfig(m.I), 13 ) == Lower('NoTimestamps:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 14 ) )
                                    If Not Inlist( Transform(tcNoTimestamps), '0', '1' ) And Inlist( lcValue, '0', '1' ) Then
                                        tcNoTimestamps  = lcValue
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > tcNoTimestamps:             ' + Transform(tcNoTimestamps) )
                                    Endif

                                Case Left( laConfig(m.I), 14 ) == Lower('ClearUniqueID:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 15 ) )
                                    If Not Inlist( Transform(tcClearUniqueID), '0', '1' ) And Inlist( lcValue, '0', '1' ) Then
                                        tcClearUniqueID = lcValue
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > ClearUniqueID:              ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 20 ) == Lower('OptimizeByFilestamp:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 21 ) )
                                    If Not Inlist( Transform(tcOptimizeByFilestamp), '0', '1', '2' ) And Inlist( lcValue, '0', '1', '2' ) Then
                                        tcOptimizeByFilestamp   = lcValue
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > OptimizeByFilestamp:        ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 24 ) == Lower('RemoveNullCharsFromCode:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 25 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_RemoveNullCharsFromCode    = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > RemoveNullCharsFromCode:    ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 25 ) == Lower('RemoveZOrderSetFromProps:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 26 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_RemoveZOrderSetFromProps   = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > RemoveZOrderSetFromProps:   ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(I), 17 ) == Lower('PRG_Compat_Level:')
                                    lcValue = Alltrim( Substr( laConfig(I), 18 ) )
                                    lo_CFG.n_PRG_Compat_Level   = Int( Val( lcValue ) )
                                    .writeLog( C_TAB + Justfname(lcConfigFile) + ' > PRG_Compat_Level:           ' + Transform(lo_CFG.n_PRG_Compat_Level) )

*pjx special
                                Case Left( laConfig(m.I), 12 ) == Lower('BodyDevInfo:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 13 ) )
*** DH 2024-08-26: support 2 as a value
*                                   If Inlist( lcValue, '0', '1' ) Then
                                    If Inlist( lcValue, '0', '1', '2' ) Then
                                        lo_CFG.n_BodyDevInfo    = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > BodyDevInfo:                ' + Transform(lo_CFG.n_BodyDevInfo) )
                                    Endif



*dbf special
                                Case Left( laConfig(m.I), 19 ) == Lower('ClearDBFLastUpdate:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_ClearDBFLastUpdate = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > ClearDBFLastUpdate:         ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 25 ) == Lower('ExcludeDBFAutoincNextval:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 26 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.n_ExcludeDBFAutoincNextval   = Int( Val( lcValue ) )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > ExcludeDBFAutoincNextval:   ' + Transform(lo_CFG.n_ExcludeDBFAutoincNextval) )
                                    Endif

                                Case Left( laConfig(m.I), 24 ) == Lower('DBF_Conversion_Included:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 25 , IIF('&'+'&'$laConfig(m.I), At('&'+'&', laConfig(m.I)) - 25, LEN(laConfig(m.I) ) ) ) )
                                    If Not Empty(lcValue) Then
                                        lo_CFG.c_DBF_Conversion_Included    = lcValue
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_Conversion_Included:    ' + Transform(lo_CFG.c_DBF_Conversion_Included) )
                                    Endif

                                Case Left( laConfig(m.I), 24 ) == Lower('DBF_Conversion_Excluded:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 25 , IIF('&'+'&'$laConfig(m.I), At('&'+'&', laConfig(m.I)) - 25, LEN(laConfig(m.I) ) ) ) )
                                    If Not Empty(lcValue) Then
                                        lo_CFG.c_DBF_Conversion_Excluded    = lcValue
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_Conversion_Excluded:    ' + Transform(lo_CFG.c_DBF_Conversion_Excluded) )
                                    Endif

                                Case Left( laConfig(m.I), 19 ) == Lower('DBF_BinChar_Base64:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_DBF_BinChar_Base64 = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_BinChar_Base64:         ' + Transform(lcValue) )
                                    Endif

                                Case Left( laConfig(m.I), 19 ) == Lower('DBF_IncludeDeleted:')
                                    lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                                    If Inlist( lcValue, '0', '1' ) Then
                                        lo_CFG.l_DBF_IncludeDeleted = ( Transform(lcValue) == '1' )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > DBF_IncludeDeleted:         ' + Transform(lcValue) )
                                    Endif

*Text file extensions
                                Case Left( laConfig(m.I), 10 ) == Lower('Extension:')
                                    lcConfData  = Alltrim( Substr( laConfig(m.I), 11 ) )
                                    lcExt       = Alltrim( Getwordnum( lcConfData, 1, '=' ) )
                                    lcProp      = 'c_' + lcExt
                                    If Pemstatus( lo_CFG, lcProp, 5 )
                                        lcValue = Upper( Alltrim( Getwordnum( lcConfData, 2, '=' ) ) )
                                        lo_CFG.AddProperty( lcProp, lcValue )
*.writeLog( 'Reconfiguración de extensión:' + ' ' + lcExt + ' a ' + lcValue )
                                        .writeLog( C_TAB + Justfname(lcConfigFile) + ' > ' + loLang.C_EXTENSION_RECONFIGURATION_LOC + ' ' + lcExt + ' -> ' + lcValue )
                                    Endif


                            Endcase
                        Endfor

                        .writeLog( )

                    Endif && llExiste_CFG_EnDisco

*-- ESTOS SE EVALÚAN FUERA DEL IF PORQUE NO DEPENDEN DEL CFG
*-- Y PUEDEN VENIR TAMBIÉN DE PARÁMETROS EXTERNOS.
                    If Inlist( Transform(tcDontShowProgress), '0', '1', '2' ) Then
                        lo_CFG.n_ShowProgressbar        = Icase(tcDontShowProgress=='0',1, tcDontShowProgress=='1',0, 2)
                    Endif
                    If Inlist( Transform(tcDontShowErrors), '0', '1' ) Then
                        lo_CFG.l_ShowErrors             = Not (Transform(tcDontShowErrors) == '1')
                    Endif
*IF NOT .l_Main_CFG_Loaded
                    lo_CFG.l_Recompile              = (Empty(tcRecompile) Or Transform(tcRecompile) == '1' Or Directory(tcRecompile))
*ENDIF
                    If Inlist( Transform(tcNoTimestamps), '0', '1' ) Then
                        lo_CFG.l_NoTimestamps           = Not (Transform(tcNoTimestamps) == '0')
                    Endif

                    If Inlist( Transform(tcClearUniqueID), '0', '1' ) Then
                        lo_CFG.l_ClearUniqueID          = Not (Transform(tcClearUniqueID) == '0')
                    Endif

                    tcExtraBackupLevels     = Evl( tcExtraBackupLevels, Transform( .n_ExtraBackupLevels ) )

                    If Isdigit(tcExtraBackupLevels)
                        lo_CFG.n_ExtraBackupLevels      = Int( Val( Transform(tcExtraBackupLevels) ) )
                    Endif

                    If Inlist( Transform(tcOptimizeByFilestamp), '0', '1', '2' ) Then
                        lo_CFG.n_OptimizeByFilestamp    = Int(Val(tcOptimizeByFilestamp))
                    Endif

                    .l_Main_CFG_Loaded  = .T.

                    If llMasterEval
* Si se inidicó un archivo CFG por parámetro (modo objeto), aqui se bloquea
* al Nº de configuración correspondiente.
                        If .n_CFG_EvaluateFromParam = -1
                            .n_CFG_EvaluateFromParam = .n_CFG_Actual
                        Endif
                    Else
*-- Si no es llMasterEval, es porque esta llamada es cíclica desde este mismo método,
*-- y no hay parámetros para evaluar, ya que se mandan todos vacíos desde el inicial.
                        If Not tl_ForceLog Then
                            Exit
                        Endif &&NOT tl_ForceLog
                    Endif
* SF

                    If lo_CFG.l_AllowFolder THEN
                        .writeLog( '> ' + loLang.C_USING_THIS_SETTINGS_LOC + ':' )
*internal info, just what is read to this moment
                        .writeLog( C_TAB + 'CFG_Actual:                 ' + Transform(.n_CFG_Actual) + Icase(.n_CFG_Actual=1, ' [MASTER]', ' [SECONDARY]') )
                        .writeLog( C_TAB + 'CFG_CachedAccess:           ' + Transform(.l_CFG_CachedAccess) )
                        .writeLog( C_TAB + 'tc_InputFile:               ' + Transform(Evl(tc_InputFile,'') ) )
                        .writeLog( C_TAB + 'Foxbin2prg_ConfigFile:      ' + Transform(Evl(lo_CFG.c_Foxbin2prg_ConfigFile, '(Internal defaults)') ) )

*settings for internal work, not processing
                        .writeLog( C_TAB + 'Language:                   ' + Transform(.c_Language) + ' (' + .c_Language_In + ')' )
                        .writeLog( C_TAB + 'ShowProgressbar:            ' + Transform(.n_ShowProgressbar) )
                        .writeLog( C_TAB + 'ShowErrors:                 ' + Transform(.l_ShowErrors) )
                        .writeLog( C_TAB + 'ExtraBackupLevels:          ' + Transform(.n_ExtraBackupLevels) )
                        Do Case
                            Case Empty ( .c_BackgroundImage )
                                .writeLog( C_TAB + 'BackgroundImage:            ' + '(Empty)' )

                            Case Lower( Justfname ( .c_BackgroundImage ) ) == 'foxbin2prg.jpg'
                                .writeLog( C_TAB + 'BackgroundImage:            ' + Transform(.c_BackgroundImage) +  '(Internal default)' )

                            Otherwise
                                .writeLog( C_TAB + 'BackgroundImage:            ' + Transform(.c_BackgroundImage) )

                        Endcase
                        .writeLog( C_TAB + 'Debug:                      ' + Transform(.n_Debug) )

* LScheffler, 2021/030/06: added DH HomeDir option
                        .writeLog( C_TAB + 'HomeDir:                    ' + Transform(.n_HomeDir) )

*Conversion operation by type
                        .writeLog( C_TAB + 'PJX_Conversion_Support      ' + Transform(.n_PJX_Conversion_Support) )
                        .writeLog( C_TAB + 'VCX_Conversion_Support      ' + Transform(.n_VCX_Conversion_Support) )
                        .writeLog( C_TAB + 'SCX_Conversion_Support      ' + Transform(.n_SCX_Conversion_Support) )
                        .writeLog( C_TAB + 'FRX_Conversion_Support      ' + Transform(.n_FRX_Conversion_Support) )
                        .writeLog( C_TAB + 'LBX_Conversion_Support      ' + Transform(.n_LBX_Conversion_Support) )
                        .writeLog( C_TAB + 'MNX_Conversion_Support      ' + Transform(.n_MNX_Conversion_Support) )
                        .writeLog( C_TAB + 'DBF_Conversion_Support      ' + Transform(.n_DBF_Conversion_Support) )
                        .writeLog( C_TAB + 'DBC_Conversion_Support      ' + Transform(.n_DBC_Conversion_Support) )
                        .writeLog( C_TAB + 'FKY_Conversion_Support      ' + Transform(.n_FKY_Conversion_Support) )
                        .writeLog( C_TAB + 'MEM_Conversion_Support      ' + Transform(.n_MEM_Conversion_Support) )

*!* Changed by: LScheffler 19.03.2023
* additional options controlling
* files in non subpath of the PJX
*setting for PJX files
                        .writeLog( C_TAB + 'CheckFileInPath:            ' + Transform(.n_CheckFileInPath) )
*!* /Changed by: LScheffler 19.03.2023

*setting for container files (not pjx)
*Classes ( vcx )
                        .writeLog( C_TAB + 'UseClassPerFile:            ' + Transform(.n_UseClassPerFile) )
                        .writeLog( C_TAB + 'ClassPerFileCheck:          ' + Transform(.l_ClassPerFileCheck) )
                        .writeLog( C_TAB + 'RedirectClassPerFileToMain: ' + Transform(.l_RedirectClassPerFileToMain) )
                        .writeLog( C_TAB + 'RedirectClassType:          ' + Transform(.n_RedirectClassType) )

*Forms ( scx)
                        .writeLog( C_TAB + 'UseFormSettings:            ' + Transform(.l_UseFormSettings) )
                        .writeLog( C_TAB + 'UseFormPerFile:             ' + Transform(.n_UseFormPerFile) )
                        .writeLog( C_TAB + 'FormPerFileCheck:           ' + Transform(.l_FormPerFileCheck) )
                        .writeLog( C_TAB + 'RedirectFormPerFileToMain:  ' + Transform(.l_RedirectFormPerFileToMain) )
                        .writeLog( C_TAB + 'RedirectFormType:           ' + Transform(.n_RedirectFormType) )

*Databases
*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - split of DBC separated from VCX/SCX
* - new operations of DBF
                        .writeLog( C_TAB + 'OldFilesPerDBC:             ' + Transform(.l_OldFilesPerDBC) )
                        .writeLog( C_TAB + 'UseFilesPerDBC:             ' + Transform(.n_UseFilesPerDBC) )
                        .writeLog( C_TAB + 'RedirectFilePerDBCToMain:   ' + Transform(.l_RedirectFilePerDBCToMain) )
                        .writeLog( C_TAB + 'ItemPerDBCCheck:            ' + Transform(.l_ItemPerDBCCheck) )
                        .writeLog( C_TAB + 'DBF_BinChar_Base64:         ' + Transform(.l_DBF_BinChar_Base64) )
                        .writeLog( C_TAB + 'DBF_IncludeDeleted:         ' + Transform(.l_DBF_IncludeDeleted) )
*!* /Changed by: LScheffler 21.02.2021

*general files
                        .writeLog( C_TAB + 'NoTimestamps:               ' + Transform(.l_NoTimestamps) )
                        .writeLog( C_TAB + 'ClearUniqueID:              ' + Transform(.l_ClearUniqueID) )
                        .writeLog( C_TAB + 'OptimizeByFilestamp:        ' + Transform(.n_OptimizeByFilestamp) )
                        .writeLog( C_TAB + 'RemoveNullCharsFromCode:    ' + Transform(.l_RemoveNullCharsFromCode) )
                        .writeLog( C_TAB + 'RemoveZOrderSetFromProps:   ' + Transform(.l_RemoveZOrderSetFromProps) )
                        .writeLog( C_TAB + 'PRG_Compat_Level:           ' + Transform(.n_PRG_Compat_Level) )

*Parameter only:
                        .writeLog( C_TAB + 'Recompile:                  ' + Transform(.l_Recompile) + ' (' + tcRecompile + ')' )

*pjx special
                        .writeLog( C_TAB + 'BodyDevInfo:                ' + Transform(.n_BodyDevInfo) )

*dbf special
                        .writeLog( C_TAB + 'ClearDBFLastUpdate:         ' + Transform(.l_ClearDBFLastUpdate) )
                        .writeLog( C_TAB + 'ExcludeDBFAutoincNextval:   ' + Transform(.n_ExcludeDBFAutoincNextval) )
                        .writeLog( C_TAB + 'DBF_Conversion_Included     ' + Transform(.c_DBF_Conversion_Included) )
                        .writeLog( C_TAB + 'DBF_Conversion_Excluded     ' + Transform(.c_DBF_Conversion_Excluded) )
                        .writeLog( C_TAB + 'DBF_BinChar_Base64:         ' + Transform(.l_DBF_BinChar_Base64) )
                        .writeLog( C_TAB + 'DBF_IncludeDeleted:         ' + Transform(.l_DBF_IncludeDeleted) )

*Text file extensions
                        .writeLog( C_TAB + 'extension: VC2              ' + Transform(.c_VC2) )
                        .writeLog( C_TAB + 'extension: SC2              ' + Transform(.c_SC2) )
                        .writeLog( C_TAB + 'extension: FR2              ' + Transform(.c_FR2) )
                        .writeLog( C_TAB + 'extension: LB2              ' + Transform(.c_LB2) )
                        .writeLog( C_TAB + 'extension: MN2              ' + Transform(.c_MN2) )
                        .writeLog( C_TAB + 'extension: DB2              ' + Transform(.c_DB2) )
                        .writeLog( C_TAB + 'extension: DC2              ' + Transform(.c_DC2) )
                        .writeLog( C_TAB + 'extension: FK2              ' + Transform(.c_FK2) )
                        .writeLog( C_TAB + 'extension: ME2              ' + Transform(.c_ME2) )
                    ENDIF &&lo_CFG.l_AllowFolder

                    .writeLog( )

                Endwith && THIS

            Catch To loEx
                loEx.UserValue  = loEx.UserValue + 'lcConfigFile = [' + Transform(lcConfigFile) + ']' + CR_LF
                loEx.UserValue  = loEx.UserValue + 'lc_CFG_Path = [' + Transform(lc_CFG_Path) + ']' + CR_LF
                loEx.UserValue  = loEx.UserValue + 'lcValue = [' + Transform(lcValue) + ']' + CR_LF

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
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

                Store .Null. To lo_Configuration, lo_CFG, loEx
                Release tcDontShowProgress, tcDontShowErrors, tcNoTimestamps, tcDebug, tcRecompile, tcExtraBackupLevels ;
                    , tcClearUniqueID, tcOptimizeByFilestamp, tc_InputFile ;
                    , lcConfigFile, llExiste_CFG_EnDisco, laConfig, I, lcConfData, lcExt, lcValue, lc_CFG_Path ;
                    , lo_CFG, lo_Configuration, loEx

        Endtry

        Return
    Endproc


    Function comparedFilesAreEqual
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcFilename1               (v! IN    ) Nombre del archivo1 a comparar
* tcFilename2               (v! IN    ) Nombre del archivo2 a comparar
* tcStrFileName2            (v! IN    ) ***NO IMPLEMENTADO*** Contenido del archivo2 a comparar
*---------------------------------------------------------------------------------------------------
        Lparameters tcFilename1, tcFilename2, tcStrFileName2

        Local lnComparacion, lnLen1, lnLen2, lnHandle1, lnHandle2, lnTipoComp, lnChunkSize ;
            , loEx As Exception

        Try
                Store -1 To lnComparacion, lnHandle1, lnHandle2
                lnTipoComp      = 0
                lnChunkSize     = 65535

                Do Case
                    Case Not Empty(tcFilename1) And Not Empty(tcFilename2)
                        lnTipoComp  = 1
                        lnHandle1   = Fopen( tcFilename1 )

                        If lnHandle1 = -1
                            Exit
                        Endif

                        lnHandle2   = Fopen( tcFilename2 )

                        If lnHandle2 = -1
                            Exit
                        Endif

                        lnLen1      = Fseek( lnHandle1, 0, 2 )
                        lnLen2      = Fseek( lnHandle2, 0, 2 )

*-- Comparación de tamaño
                        If lnLen1 <> lnLen2 Then
                            lnComparacion   = 0 && Son distintos
                            Exit
                        Endif

*-- Comparación de contenido
                        Fseek( lnHandle1, 0, 0 )
                        Fseek( lnHandle2, 0, 0 )

                        Do While Not ( Feof(lnHandle1) Or Feof(lnHandle2) )
*IF NOT SYS( 2007, FREAD( lnHandle1, lnChunkSize ), -1, 1 ) == SYS( 2007, FREAD( lnHandle2, lnChunkSize ), -1, 1 ) THEN
                            If Not Fread( lnHandle1, lnChunkSize ) == Fread( lnHandle2, lnChunkSize ) Then
                                lnComparacion   = 0 && Son distintos
                                Exit
                            Endif
                        Enddo

                        If lnComparacion = 0 Then
                            Exit
                        Endif

                        lnComparacion   = 1 && Son iguales

                Endcase

            Catch To loEx
                lnComparacion   = -1    && Error
                Throw

            Finally
                Do Case
                    Case lnTipoComp = 1
                        Fclose( lnHandle1 )
                        Fclose( lnHandle2 )

                Endcase

        Endtry

        Return lnComparacion
    Endfunc


    Function filenameFoundInFilter
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcFilename                (v! IN    ) Nombre del archivo a evaluar
* tcFilters                 (v! IN    ) Filtros a evaluar (*,??E.*,R*.*)
*---------------------------------------------------------------------------------------------------
        Lparameters tcFileName, tcFilters

        Local llFound, laFiltros(1)
        tcFileName  = Upper(tcFileName)

        For I = 1 To Alines( laFiltros, tcFilters + ',', 1+4, ',' )
            If Like( Upper(laFiltros(m.I)), tcFileName )
                llFound = .T.
                Exit
            Endif
        Endfor

        Release tcFileName, tcFilters, laFiltros
        Return llFound
    Endfunc


    Procedure get_DBF_Configuration(tc_InputFile As String, to_out_DBF_CFG As Object, tlGenerateLog As Boolean) As Integer
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_InputFile              (@! IN    ) Ruta al archivo con Extensión para comprobar si tiene soporte de conversión
* to_out_DBF_CFG            (@?    OUT) Objeto CFG del DBF indicado, con las propiedades que contenga el CFG y sus valores
* RETORNO                   (v?    OUT) Devuelve 0 si no existe el archivo CFG y 1 si lo encuentra
*---------------------------------------------------------------------------------------------------
        #If .F.
            Local to_out_DBF_CFG As CL_DBF_CFG Of 'FOXBIN2PRG.PRG'
        #Endif

        Local lcTableCFG, lnFileCount, laDirFile(1,5), I, lcConfigItem, lcValue
        lcTableCFG  = tc_InputFile + '.CFG'
        lnFileCount = Adir(laDirFile, lcTableCFG)
        to_out_DBF_CFG  = .NULL.

        If lnFileCount = 1

            to_out_DBF_CFG  = Createobject("CL_DBF_CFG")

            If tlGenerateLog Then
                This.writeLog()
                This.writeLog(' > Found DBF configuration file: ' + lcTableCFG)
            Endif

            For I = 1 To Alines( laConfig, Filetostr( lcTableCFG ), 1+4 )
                lcConfigItem    = Lower( laConfig(m.I) )

                Do Case
                    Case Inlist( Left( lcConfigItem, 1 ), '*', '#', '/', "'" )
                        Loop

                    Case Left( lcConfigItem, 23 ) == Lower('DBF_Conversion_Support:')
                        to_out_DBF_CFG.n_DBF_Conversion_Support = Int( Val( Substr( laConfig(m.I), 24 ) ) )
                        If tlGenerateLog Then
                            This.writeLog('     ' + Justfname(lcTableCFG) + ' > DBF_Conversion_Support: ' + Transform(to_out_DBF_CFG.n_DBF_Conversion_Support) )
                        Endif

                    Case Left( lcConfigItem, 21 ) == Lower('DBF_Conversion_Order:')
                        to_out_DBF_CFG.DBF_Conversion_Order     = Alltrim( Substr( laConfig(m.I), 22 , At('&'+'&',laConfig(m.I)) - 22 ) )
                        If tlGenerateLog Then
                            This.writeLog('     ' + Justfname(lcTableCFG) + ' > DBF_Conversion_Order: ' + to_out_DBF_CFG.DBF_Conversion_Order )
                        Endif

                    Case Left( lcConfigItem, 25 ) == Lower('DBF_Conversion_Condition:')
                        to_out_DBF_CFG.DBF_Conversion_Condition = Alltrim( Substr( laConfig(m.I), 26 , At('&'+'&',laConfig(m.I)) - 26 ) )
                        If tlGenerateLog Then
                            This.writeLog('     ' + Justfname(lcTableCFG) + ' > DBF_Conversion_Condition: ' + to_out_DBF_CFG.DBF_Conversion_Condition )
                        Endif

*!* Changed by: LScheffler 18.03.2021
*!* change date="{^2021-03-18,10:57:00}"
* additional options controlling
* - new operations of DBF, additional list of non structural index files
                    Case Left( lcConfigItem, 14 ) == Lower('DBF_IndexList:')
                        to_out_DBF_CFG.DBF_IndexList    = Substr( laConfig(m.I), 15 , At('&'+'&',laConfig(m.I)) - 15 )
                        If tlGenerateLog Then
                            This.writeLog('     ' + Justfname(lcTableCFG) + ' >DBF_IndexList:           ' + Transform(to_out_DBF_CFG.DBF_IndexList) )
                        Endif
*!* /Changed by: LScheffler 18.03.2021

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF
*!* /Changed by: LScheffler 21.02.2021
                    Case Left( lcConfigItem, 19 ) == Lower('DBF_BinChar_Base64:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                        If Inlist( m.lcValue, '0', '1' ) Then
                            to_out_DBF_CFG.l_DBF_BinChar_Base64     = ( Transform(m.lcValue ) == '1' )
                            If tlGenerateLog Then
                                This.writeLog('     ' + Justfname(lcTableCFG) + ' > DBF_BinChar_Base64:     ' + Transform(to_out_DBF_CFG.l_DBF_BinChar_Base64) )
                            Endif
                        Endif

                    Case Left( lcConfigItem, 19 ) == Lower('DBF_IncludeDeleted:')
                        lcValue = Alltrim( Substr( laConfig(m.I), 20 ) )
                        If Inlist( m.lcValue, '0', '1' ) Then
                            to_out_DBF_CFG.l_DBF_IncludeDeleted     = ( Transform( m.lcValue ) == '1' )
                            If tlGenerateLog Then
                                This.writeLog('     ' + Justfname(lcTableCFG) + ' > DBF_IncludeDeleted:     ' + Transform(to_out_DBF_CFG.l_DBF_IncludeDeleted) )
                            Endif
                        Endif
*!* /Changed by: LScheffler 21.02.2021

                Endcase
            Endfor

            If tlGenerateLog Then
                This.writeLog()
            Endif

        Endif

        Return lnFileCount
    Endproc


    Procedure get_Ext2FromExt
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcExt                     (@! IN    ) Extensión para comprobar si tiene soporte de conversión
* tcDir                     (@? IN    ) Directorio del que devolver su configuración
* RETORNO                   (v?    OUT) .T. si tiene soporte de conversión, .F. si no lo tiene
*---------------------------------------------------------------------------------------------------
        Lparameters tcExt, tcDir

        Local lcExt2
        tcExt   = Upper(tcExt)

        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            If Not Empty(tcDir)
                .evaluateConfiguration( '', '', '', '', '', '', '', '', tcDir, 'D' )
            Endif

            lcExt2  = Icase( tcExt == 'PJX', .c_PJ2 ;
                , tcExt == 'VCX', .c_VC2 ;
                , tcExt == 'SCX', .c_SC2 ;
                , tcExt == 'FRX', .c_FR2 ;
                , tcExt == 'LBX', .c_LB2 ;
                , tcExt == 'MNX', .c_MN2 ;
                , tcExt == 'DBF', .c_DB2 ;
                , tcExt == 'DBC', .c_DC2 ;
                , tcExt )
        Endwith && THIS

        Release tcExt
        Return lcExt2
    Endproc


    Procedure hasSupport_Bin2Prg(tcFileName As String, tcDir As String) As Boolean
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcFilename                (@! IN    ) Extensión para comprobar si el archivo tiene soporte de conversión
* tcDir                     (@? IN    ) Directorio del que devolver su configuración
* RETORNO                   (v?    OUT) .T. si tiene soporte de conversión, .F. si no lo tiene
*---------------------------------------------------------------------------------------------------
        Local llhasSupport, lcExt, lcDir ;
            , loDBF_CFG As CL_DBF_CFG Of 'FOXBIN2PRG.PRG'

        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            loDBF_CFG   = .Null.
            lcExt       = Upper(Justext('.' + tcFileName))

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

            Do Case
                Case '\' $ tcFileName And lcExt == 'DBF'
                    lcDir       = Justpath(tcFileName)
                    .get_DBF_Configuration(tcFileName, @loDBF_CFG)
                Case Not Empty(tcDir)
                    lcDir       = tcDir
                Case Vartype( tcFileName ) = "C"
                    lcDir = Justpath( tcFileName )
            Endcase

*!* /Changed by: LScheffler 13.6.2022

            If Not Empty(lcDir)
                .evaluateConfiguration( '', '', '', '', '', '', '', '', lcDir, 'D' )
            Endif

            llhasSupport    = .l_AllowFolder AND Icase( lcExt == 'PJX', .n_PJX_Conversion_Support > 0 ;
                , lcExt == 'VCX', .n_VCX_Conversion_Support > 0 ;
                , lcExt == 'SCX', .n_SCX_Conversion_Support > 0 ;
                , lcExt == 'FRX', .n_FRX_Conversion_Support > 0 ;
                , lcExt == 'LBX', .n_LBX_Conversion_Support > 0 ;
                , lcExt == 'MNX', .n_MNX_Conversion_Support > 0 ;
                , lcExt == 'DBC', .n_DBC_Conversion_Support > 0 ;
                , lcExt == 'DBF', Iif(Isnull(loDBF_CFG), .n_DBF_Conversion_Support > 0, loDBF_CFG.n_DBF_Conversion_Support > 0 ) ;
                , lcExt == 'FKY', .n_FKY_Conversion_Support > 0 ;
                , lcExt == 'MEM', .n_MEM_Conversion_Support > 0 ;
                , .F. )
        Endwith && THIS

        Return llhasSupport
    Endproc


    Procedure hasSupport_Prg2Bin(tcFileName As String, tcDir As String) As Boolean
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcFilename                (@! IN    ) Extensión para comprobar si el archivo tiene soporte de conversión
* tcDir                     (@? IN    ) Directorio del que devolver su configuración
* RETORNO                   (v?    OUT) .T. si tiene soporte de conversión, .F. si no lo tiene
*---------------------------------------------------------------------------------------------------
        Local llhasSupport, lcExt, lcDir ;
            , loDBF_CFG As CL_DBF_CFG Of 'FOXBIN2PRG.PRG'

        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            loDBF_CFG   = .Null.
            lcExt       = Upper(Justext('.' + tcFileName))

            Do Case
                Case '\' $ tcFileName And lcExt == .c_DB2
                    lcDir       = Justpath(tcFileName)
                    .get_DBF_Configuration(tcFileName, @loDBF_CFG)
                Case Not Empty(tcDir)
                    lcDir       = tcDir
                Case Vartype( tcFileName ) = "C"
                    lcDir = Justpath( tcFileName )
            Endcase

            If Not Empty(lcDir)
                .evaluateConfiguration( '', '', '', '', '', '', '', '', lcDir, 'D' )
            Endif

            llhasSupport    = .l_AllowFolder AND Icase( lcExt == .c_PJ2, .n_PJX_Conversion_Support = 2 ;
                , lcExt == .c_VC2, .n_VCX_Conversion_Support = 2 ;
                , lcExt == .c_SC2, .n_SCX_Conversion_Support = 2 ;
                , lcExt == .c_FR2, .n_FRX_Conversion_Support = 2 ;
                , lcExt == .c_LB2, .n_LBX_Conversion_Support = 2 ;
                , lcExt == .c_MN2, .n_MNX_Conversion_Support = 2 ;
                , lcExt == .c_FK2, .n_FKY_Conversion_Support = 2 ;
                , lcExt == .c_ME2, .n_MEM_Conversion_Support = 2 ;
                , lcExt == .c_DB2, Iif(Isnull(loDBF_CFG), Inlist(.n_DBF_Conversion_Support, 2, 8), Inlist(loDBF_CFG.n_DBF_Conversion_Support, 2, 8) ) ;
                , lcExt == .c_DC2, .n_DBC_Conversion_Support = 2 ;
                , .F. )
        Endwith && THIS

        Return llhasSupport
    Endproc


    Procedure conversionSupportType(tcFileName As String, tlGenerarLog As Boolean) As Integer
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcFilename                (@! IN    ) Extensión para comprobar si el archivo tiene soporte de conversión
* RETORNO                   (v?    OUT) Devuelve el código de soporte
*---------------------------------------------------------------------------------------------------
        Local lnSupportType, lcExt, lcDir, lcFilename ;
            , loDBF_CFG As CL_DBF_CFG Of 'FOXBIN2PRG.PRG'

        Try
                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    loDBF_CFG   = .Null.
                    lcExt       = Upper(Justext('.' + tcFileName))

                    If '\' $ tcFileName And Inlist(lcExt, .c_DB2, 'DBF') Then
                        lcFilename  = Forceext(tcFileName, 'DBF')
                        lcDir       = Justpath(lcFilename)
                        .get_DBF_Configuration(lcFilename, @loDBF_CFG, tlGenerarLog)
                    Else
                        lcDir       = Sys(5) + Curdir()
                    Endif

                    If Not Empty(lcDir)
                        .evaluateConfiguration( '', '', '', '', '', '', '', '', lcDir, 'D' )
                    Endif

                    lnSupportType   = Icase( ;
                          InList(lcExt, .c_PJ2, 'PJX'), .n_PJX_Conversion_Support ;
                        , Inlist(lcExt, .c_VC2, 'VCX'), .n_VCX_Conversion_Support ;
                        , Inlist(lcExt, .c_SC2, 'SCX'), .n_SCX_Conversion_Support ;
                        , Inlist(lcExt, .c_FR2, 'FRX'), .n_FRX_Conversion_Support ;
                        , Inlist(lcExt, .c_LB2, 'LBX'), .n_LBX_Conversion_Support ;
                        , Inlist(lcExt, .c_MN2, 'MNX'), .n_MNX_Conversion_Support ;
                        , Inlist(lcExt, .c_FK2, 'FKY'), .n_FKY_Conversion_Support ;
                        , Inlist(lcExt, .c_ME2, 'MEM'), .n_MEM_Conversion_Support ;
                        , Inlist(lcExt, .c_DB2, 'DBF'), Iif(Isnull(loDBF_CFG), .n_DBF_Conversion_Support, loDBF_CFG.n_DBF_Conversion_Support ) ;
                        , Inlist(lcExt, .c_DC2, 'DBC'), .n_DBC_Conversion_Support ;
                        , 0 )

                    lnSupportType   = Int(lnSupportType)
                Endwith && THIS

            Finally
                Store .Null. To loDBF_CFG
                Release loDBF_CFG
        Endtry

        Return lnSupportType
    Endproc


    Procedure execute
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
        Lparameters tc_InputFile, tcType, tcTextName, tlGenText, tcDontShowErrors, tcDebug, tcDontShowProgress ;
                  , toModulo, toEx As Exception, tlRelanzarError, tcOriginalFileName, tcRecompile, tcNoTimestamps ;
                  , tcBackupLevels, tcClearUniqueID, tcOptimizeByFilestamp, tcCFG_File

        Try
                Local I, lcPath, lnCodError, lcFileSpec, lcFile, laFiles(1,5), laDirInfo(1,5), lcInputFile_Type, lc_OldSetNotify ;
                    , lnFileCount, lcErrorInfo, lcErrorFile, lnPCount, laParams(1), lnConversionOption, lnErrorIcon, llError ;
                    , lcOldSetEscape, lcOldOnEscape, llEscKeyRestored, lcType
                LOCAL lnVFPVersion, lcCFG_File

                LOCAL loEx   As Exception ;
                    , loFSO  As Scripting.FileSystemObject ;
                    , loWSH  As WScript.Shell

                LOCAL loCFG             As CL_CFG          Of 'FOXBIN2PRG.PRG' ;
                    , loLang            As CL_LANG         Of 'FOXBIN2PRG.PRG' ;
                    , loDBF_CFG         As CL_DBF_CFG      Of 'FOXBIN2PRG.PRG' ;
                    , loFrm_Interactive As frm_interactive Of 'FOXBIN2PRG.PRG' ;
                    , loFrm_Main        As frm_main        Of 'FOXBIN2PRG.PRG'


                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    lc_OldSetNotify = Set("Notify")
                    Set Notify Off
                    lnCodError          = 0
                    loLang              = _Screen.o_FoxBin2Prg_Lang
                    loFSO               = .o_FSO
                    loWSH               = .o_WSH
                    loCFG               = .Null.
                    lnPCount            = 0
                    lcInputFile_Type    = ''
                    .l_Error            = .F.
                    lcType              = Evl(tcType,'')
                    tcType              = Upper( lcType )
                    llEscKeyRestored    = .T.
                    lnVFPVersion        = Version(5)
                    .declareDLL()

                    If This.l_CancelWithEscKey Then
                        lcOldSetEscape  = Set("Escape")
                        lcOldOnEscape   = On("Escape")
                        On Escape Error 1799
                        Set Escape On
                        llEscKeyRestored    = .F.
                    Endif

                    Do Case
                        Case lnVFPVersion = 900 And Int( Val( Substr( Version(4), Rat('.', Version(4)) + 1 ) ) ) < 3504
                            Error loLang.C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC

                        Case lnVFPVersion < 900
                            Error loLang.C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC

                        Case '\' $ tcType
                            Error loLang.C_INVALID_PARAMETER_LOC + ':' + CR_LF ;
                                + 'tcType = "' + tcType + '"' + CR_LF ;
                                + CR_LF ;
                                + loLang.C_ALLOWED_VALUES_ARE_LOC + ': ' + CR_LF ;
                                + '*, *-, -BIN2PRG, -PRG2BIN, -BIN2TEXT, -TEXT2BIN, -SHOWMSG, -SIMERR_I0, -SIMERR_I1, -SIMERR_O1'

                        Otherwise
                                * OK all versions from 900(3504) and up. For VFPA Guys :)

                    Endcase

                    Do Case
                        Case Atc('-SIMERR_I0','-'+tcType) > 0
                            .c_SimulateError = 'SIMERR_I0'

                        Case Atc('-SIMERR_I1','-'+tcType) > 0
                            .c_SimulateError = 'SIMERR_I1'

                        Case Atc('-SIMERR_O1','-'+tcType) > 0
                            .c_SimulateError = 'SIMERR_O1'
                    Endcase

                    If .l_AutoClearProcessedFiles Then
                        && Para evitar acumular procesos anteriores
                        .clearProcessedFiles()
                    Endif


                    *-- Reconocimiento de la clase indicada
                    *-- Ej: [c:\desa\test\library.vcx::classname]
                    If '::' $ tc_InputFile Then
                        tc_InputFile            = Strtran(tc_InputFile, '::', '|')

                        .c_ClassOperationType   = Evl( Upper( Left( Alltrim( Getwordnum( tc_InputFile, 3, '|' ) ), 1) ), 'E')
                        .c_ClassToConvert       = Lower( Alltrim( Getwordnum( tc_InputFile, 2, '|' ) ) )

                        * CUIDADO!, evaluar esta última, que si no las anteriores no evalúan.
                        tc_InputFile = Lower( Alltrim( Getwordnum( tc_InputFile, 1, '|' ) ) )
                    Else
                        .c_ClassOperationType   = ''
                    Endif

                    If Vartype(tcCFG_File) = "O"
                        * Validar el objeto
                        loCFG   = tcCFG_File
                        If Not (loCFG.Class == Proper('CL_CFG'))
                            Error 'CFG object: Invalid class. Please, generate it with get_DirSettings()'
                        Endif

                        .c_Foxbin2prg_ConfigFile = loCFG
                        .n_CFG_EvaluateFromParam = 1

                    Else

                        lcCFG_File = IIF(VARTYPE(tcCFG_File)='C' AND !EMPTY(tcCFG_File),tcCFG_File,.F.)
                    Endif

                    *-- Ajusto la ruta si no es absoluta
                    tc_InputFile    = .get_AbsolutePath( tc_InputFile, .c_CurDir )

                    *-- Determino el tipo de InputFile (Archivo o Directorio)
                    If Empty(lcInputFile_Type) And Not Empty(tc_InputFile)
                        Do Case
                            Case Len(tc_InputFile) = 1
                                lcInputFile_Type    = C_FILETYPE_QUERYSUPPORT

                            Case Adir(laDirInfo, tc_InputFile, "D") = 1 And Substr( laDirInfo(1,5), 5, 1 ) = "D"
                                *-- Ejemplo: "c:\desa\"
                                lcInputFile_Type    = C_FILETYPE_DIRECTORY


                            Otherwise
                                *-- Ejemplo: "c:\desa\*.scx", "c:\desa\file.ext", (lista de archivos)
                                lcInputFile_Type    = C_FILETYPE_FILE
                        Endcase
                    Endif

                    If Empty(tcRecompile) And Not Empty(lcInputFile_Type) And Not lcInputFile_Type == C_FILETYPE_QUERYSUPPORT Then
                        If lcInputFile_Type == C_FILETYPE_DIRECTORY Then
                            tcRecompile = tc_InputFile
                        Else
                            tcRecompile = Justpath( tc_InputFile )
                        Endif
                    Endif

                    tcRecompile     = Evl(tcRecompile,'1')
                    .c_Recompile    = tcRecompile

                    .writeLog( Replicate( '*', 100 ) )
                    .writeLog( loLang.C_MAIN_EXECUTION_LOC, 2 )
                    .writeLog( Replicate( '*', 100 ) )
                    .writeLog( '> ' + loLang.C_EXTERNAL_PARAMETERS_LOC + ':' )
                    If    Upper(tcType)=='-C' Or tcType=='-t' ;
                       OR Upper(tcType)=='C'  Or tcType=='t' THEN

                        .writeLog( C_TAB + 'tcType:                       ' + Transform( Evl(lcType, '(empty)' ) ) )
                        .writeLog( C_TAB + 'tc_OutputFile:                ' + Transform( Evl(tc_InputFile, '(empty)  -> Will use Default [' + .c_InputFile + ']' ) ) )
                        .writeLog( C_TAB + 'tcCFG_File                    ' + Transform( Evl(tcCFG_File, '(empty)' ) ) )
                        .writeLog( C_TAB + 'tcDebug:                      ' + Transform( Evl(tcDebug, '(empty)  -> Will use Default [' + Transform(.n_Debug) + ']' ) ) )
                    ELSE
                        .writeLog( C_TAB + 'tc_InputFile:                 ' + Transform( Evl(tc_InputFile, '(empty)  -> Will use Default [' + .c_InputFile + ']' ) ) )
                        .writeLog( C_TAB + 'tcType:                       ' + Transform( Evl(lcType, '(empty)' ) ) )
                        .writeLog( C_TAB + 'tcTextName:                   ' + Transform( Evl(tcTextName, '(empty)' ) ) )
                        .writeLog( C_TAB + 'tlGenText:                    ' + Transform( Evl(tlGenText, '(empty)' ) ) )
                        .writeLog( C_TAB + 'tcDontShowErrors:             ' + Transform( Evl(tcDontShowErrors, '(empty)  -> Will use Default [' + Transform(.l_ShowErrors) + ']' ) ) )
                        .writeLog( C_TAB + 'tcDebug:                      ' + Transform( Evl(tcDebug, '(empty)  -> Will use Default [' + Transform(.n_Debug) + ']' ) ) )
                        .writeLog( C_TAB + 'tcDontShowProgress:           ' + Transform( Evl(tcDontShowProgress, '(empty)  -> Will use Default [' + Transform(.n_ShowProgressbar) + ']' ) ) )
                        .writeLog( C_TAB + 'tlRelanzarError:              ' + Transform( Evl(tlRelanzarError, '(empty)' ) ) )
                        .writeLog( C_TAB + 'tcOriginalFileName:           ' + Transform( Evl(tcOriginalFileName, '(empty)  -> Will use Default [' + .c_OriginalFileName + ']' ) ) )
                        .writeLog( C_TAB + 'tcRecompile:                  ' + Transform( Evl(tcRecompile, '(empty)  -> Will use Default [' + .c_Recompile + ']' ) ) )
                        .writeLog( C_TAB + 'tcNoTimestamps:               ' + Transform( Evl(tcNoTimestamps, '(empty)  -> Will use Default [' + Transform(.l_NoTimestamps) + ']' ) ) )
                        .writeLog( C_TAB + 'tcBackupLevels:               ' + Transform( Evl(tcBackupLevels, '(empty)  -> Will use Default [' + Transform(.n_ExtraBackupLevels) + ']' ) ) )
                        .writeLog( C_TAB + 'tcClearUniqueID:              ' + Transform( Evl(tcClearUniqueID, '(empty)  -> Will use Default [' + Transform(.l_ClearUniqueID) + ']' ) ) )
                        .writeLog( C_TAB + 'tcOptimizeByFilestamp:        ' + Transform( Evl(tcOptimizeByFilestamp, '(empty)  -> Will use Default [' + Transform(.n_OptimizeByFilestamp) + ']' ) ) )
                        .writeLog( C_TAB + 'tcCFG_File                    ' + Transform( IIF(VARTYPE(tcCFG_File)='O' AND !ISNULL(tcCFG_File),'(object)',Evl(tcCFG_File, '(empty)' ) ) ) )
                    ENDIF
                    .writeLog( )

*-- ARCHIVO DE CONFIGURACIÓN PRINCIPAL

*!* Changed by: LScheffler 09.3.2021
*!* change date="{^2021-03-09,08:06:00}"
* log settings for tcCFG_File - cfg as object
                    .evaluateConfiguration( @tcDontShowProgress, @tcDontShowErrors, @tcNoTimestamps, @tcDebug, @tcRecompile, @tcBackupLevels ;
                        , @tcClearUniqueID, @tcOptimizeByFilestamp, @tc_InputFile, @lcInputFile_Type, , Vartype(tcCFG_File) = "O", lcCFG_File)
*!* /Changed by: LScheffler 09.3.2021

*!* Changed by: LScheffler 04.3.2021
*!* change date="{^2021-03-04,13:25:00}"
* for Input file in the form file[.baseclass].class.vc2 (normaly sc2 too, but no support in old code)
* allow to import only the class to file.VCX with n_RedirectClassType = 2
* n_RedirectClassType = 0 will import all classes of file.VCX (as just handing file.vc2)
* n_RedirectClassType = 1 will import the class to single lib file[.baseclass].class.VCX
                    lcExt = JUSTEXT( m.tc_InputFile )

                    Do Case
                        Case ( Lower(m.lcType)=='-c' Or Lower(m.lcType)=='c' )
* not handled
                        Case ( m.lcType=='-t' Or m.lcType=='t' )
* not handled
                        CASE lcExt==This.c_VC2 OR lcExt=="VCX"
*ClassLib
                            DO Case
                                Case .n_RedirectClassType # 2
* not handled
                                Case !Empty(.c_ClassToConvert)
* not otherwise
                                Case .n_UseClassPerFile = 0
* not handled
                                Case Occurs('.',m.tc_InputFile) > .n_UseClassPerFile
* we must have more dots then UseClassPerFile, because there is an extension

*class
                                    .c_ClassToConvert = Lower( Justext( Juststem( m.tc_InputFile ) ) )
*remove class
                                    tc_InputFile = Lower( Justpath( m.tc_InputFile ) + '\' + Juststem( Juststem( m.tc_InputFile ) ) + '.' + Justext( m.tc_InputFile ) )
*remove baseclass
                                    If .n_UseClassPerFile = 2
*remove baseclass
                                        tc_InputFile = Lower( Justpath( m.tc_InputFile ) + '\' + Juststem( Juststem( m.tc_InputFile ) ) + '.' + Justext( m.tc_InputFile ) )
                                    Endif
* count anything then -BIN2PRG as import
                                    .c_ClassOperationType = Iif( Atc('-BIN2PRG','-'+tcType) > 0 OR Atc('-BIN2TEXT','-'+tcType) > 0, 'E', 'I')

                                Otherwise
* not handled
                            Endcase

                        CASE lcExt==This.c_SC2 OR lcExt=="SCX"
*Form
                            DO Case
                                Case .n_RedirectFormType # 2
* not handled
                                Case !Empty(.c_ClassToConvert)
* not otherwise
                                Case .n_UseFormPerFile = 0
* not handled
                                Case Occurs('.',m.tc_InputFile) > .n_UseFormPerFile
* we must have more dots then UseClassPerFile, because there is an extension

*Form name
                                    .c_ClassToConvert = Lower( Justext( Juststem( m.tc_InputFile ) ) )
*remove obkject
                                    tc_InputFile = Lower( Justpath( m.tc_InputFile ) + '\' + Juststem( Juststem( m.tc_InputFile ) ) + '.' + Justext( m.tc_InputFile ) )
*remove baseclass
                                    If .n_UseFormPerFile = 2
*remove baseclass
                                        tc_InputFile = Lower( Justpath( m.tc_InputFile ) + '\' + Juststem( Juststem( m.tc_InputFile ) ) + '.' + Justext( m.tc_InputFile ) )
                                    Endif
* count anything then -BIN2PRG as import
                                    .c_ClassOperationType = Iif( Atc('-BIN2PRG','-'+tcType) > 0 OR Atc('-BIN2TEXT','-'+tcType) > 0, 'E', 'I')

                                Otherwise
* not handled
                            Endcase

                        Otherwise
* not handled
                    Endcase
*!* /Changed by: LScheffler 04.3.2021

*!* Changed By LScheffler 3.1.2024
*!* <pdm>
*!* <change date="{^2024-01-03,08:27:00}">Changed By LScheffler<br />
*!* Problem recreating ingle classes
*!* </change>
*!* </pdm>

* Redefinir nombre archivo de entrada según el tipo de conversión (IMPORT/EXPORT)
                    If .c_ClassOperationType = 'I'
* En el caso de importar, debo cambiar la sintaxis de tc_InputFile para poder usar
* la conversión existente de clase vc2.
* Esto deja un archivo con sintaxis "classlib.vcx::classname::import" en "classlib.classname.vc2"
*                       IF .ATC(lcExt,c_VC2,"VCX")
                        IF INLIST(lcExt,.c_VC2,"VCX")
                            If .n_UseClassPerFile = 2
                                tc_InputFile        = Forceext(tc_InputFile, '') + '.*.' + .c_ClassToConvert + '.' + .c_VC2

                                If Adir(laFiles, tc_InputFile) = 1
                                    tc_InputFile    = Fullpath( laFiles(1,1), tc_InputFile )
                                Endif

                            Else && Asumo .n_UseClassPerFile = 1
                                tc_InputFile        = Forceext(tc_InputFile, '') + '.' + .c_ClassToConvert + '.' + .c_VC2

                            Endif
                        Endif

*                       IF .ATC(lcExt,c_SC2,"SCX")
                        IF INLIST(lcExt,.c_SC2,"SCX")
                            If .n_UseFormPerFile = 2
                                tc_InputFile        = Forceext(tc_InputFile, '') + '.*.' + .c_ClassToConvert + '.' + .c_VC2

                                If Adir(laFiles, tc_InputFile) = 1
                                    tc_InputFile    = Fullpath( laFiles(1,1), tc_InputFile )
                                Endif

                            Else && Asumo .n_UseFormPerFile = 1
                                tc_InputFile        = Forceext(tc_InputFile, '') + '.' + .c_ClassToConvert + '.' + .c_VC2

                            Endif
                        Endif
                    Endif
*!* /Changed By LScheffler 3.1.2024

                    loLang          = _Screen.o_FoxBin2Prg_Lang

                    Do Case
                        Case Version(5) < 900
*-- '¡FOXBIN2PRG es solo para Visual FoxPro 9.0!'
                            Messagebox( loLang.C_FOXBIN2PRG_JUST_VFP_9_LOC, 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_WARN_CAPTION_LOC + ' (' + .c_Language + ')', 60000 )
                            lnCodError  = 1

*!* Changed by: LScheffler 15.2.2021
*!* change date="{^2021-02-15,18:44:00}"
* added option to create config files
                        Case ( m.lcType=='-t' Or m.lcType=='t' ) And ( Vartype( m.tc_InputFile )='C' And !Empty( m.tc_InputFile ) )
                            loLang       = _Screen.o_FoxBin2Prg_Lang
                            Strtofile( Strtran( Strtran( '*' + m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg, CR_LF, CR_LF + '*'), CR_LF + '*' + CR_LF, CR_LF+CR_LF), m.tc_InputFile )
                        .writeLog_Flush()

                        Case ( m.lcType=='-c' Or m.lcType=='c' )
                            tc_InputFile = Iif( Vartype( m.tc_InputFile )='C' And !Empty( m.tc_InputFile ), m.tc_InputFile, 'FoxBin2Prg._cfg' )
                            loLang       = _Screen.o_FoxBin2Prg_Lang
                            Strtofile( Strtran( '*' + Strtran( m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg, CR_LF, CR_LF + '*'), CR_LF + '*' + CR_LF, CR_LF+CR_LF), m.tc_InputFile )
                        .writeLog_Flush()
*!* /Changed by: LScheffler 15.2.2021

*!* Changed by: LScheffler 07.3.2021
*!* change date="{^2021-03-07,18:44:00}"
* added option to create config files with values
                        Case ( m.lcType=='-C' Or m.lcType=='C' )
                            Local;
                                lcText    As String,;
                                lcValue   As String,;
                                lcReturn  As String,;
                                lnLines   As Number,;
                                lnLine    As Number,;
                                lnOptions As Number,;
                                lnOption  As Number

                            lnOptions = 55

                            Local Array;
                                laLines(1),;
                                laOptions(m.lnOptions,3)

                            tc_InputFile = Iif( Vartype( m.tc_InputFile )='C' And !Empty( m.tc_InputFile ), m.tc_InputFile, 'FoxBin2Prg._cfg' )
                            loLang       = _Screen.o_FoxBin2Prg_Lang
                            lcText       = Strtran( '*' + Strtran( m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg, CR_LF, CR_LF + '*'), CR_LF + '*' + CR_LF, CR_LF+CR_LF)
                            lnLines      = Alines(laLines,m.lcText)

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

                            For lnOption = 1 To m.lnOptions
                                lnLine = Ascan( m.laLines , m.laOptions( m.lnOption, 1 ), 1, -1, 1, 4)
                                If m.lnLine >0 Then
                                    lcText  = m.laLines( m.lnLine )
                                    lcValue = Strextract( m.lcText , m.laOptions( m.lnOption, 1 ), '&'+'&' ,1 , 3)
                                    Do Case
                                        Case m.laOptions( m.lnOption, 3 ) = 0 OR m.laOptions( m.lnOption, 3 ) = 4
*numeric to numeric
                                            lcReturn = Padr(' ' + Transform( Evaluate( m.laOptions( m.lnOption, 2 ) ) ), Len(m.lcValue) + 1 )

                                        Case m.laOptions( m.lnOption, 3 ) = 1
*logic to numeric
                                            lcReturn = Padr(' ' + Iif ( Evaluate( m.laOptions( m.lnOption, 2 )), '1', '0' ), Len(m.lcValue) + 1 )

                                        Case m.laOptions( m.lnOption, 3 ) = 2
*extension to text
                                            lcReturn = Padr(Evaluate( m.laOptions( m.lnOption, 2 )), Len(m.lcValue) + 1 )

                                        Case m.laOptions( m.lnOption, 3 ) = 3
*logic to numeric, inverted
                                            lcReturn = Padr(' ' + Iif ( Evaluate( m.laOptions( m.lnOption, 2 )), '0', '1' ), Len(m.lcValue) + 1 )

                                        Case m.laOptions( m.lnOption, 3 ) = 5
*special, Conversion Exclude for DBF
                                            lcReturn = ' ' + Transform( Evaluate( m.laOptions( m.lnOption, 2 ) ) )
                                            lcReturn = Padr( m.lcReturn , Max( Len ( m.lcReturn )+1, Len( m.lcValue ) + 1 ) )

                                        Case m.laOptions( m.lnOption, 3 ) = 6
*special, Conversion Include for DBF (empty => *)
                                            If Empty( Evaluate( m.laOptions( m.lnOption, 2 ) ) )
                                                lcReturn = ' *'

                                            Else  &&Empty( Evaluate( m.laOptions( m.lnOption, 2 ) ) )
                                                lcReturn = ' ' + Transform( Evaluate( m.laOptions( m.lnOption, 2 ) ) )

                                            Endif &&Empty( Evaluate( m.laOptions( m.lnOption, 2 ) ) )
                                            lcReturn = Padr( m.lcReturn , Max( Len ( m.lcReturn )+1, Len( m.lcValue ) + 1 ) )

                                        Case m.laOptions( m.lnOption, 3 ) = 7
*special, Background Image (foxbin2prg.jpg => empty)
                                            If Lower( Justfname ( Evaluate( m.laOptions( m.lnOption, 2 ) ) ) ) == 'foxbin2prg.jpg' Then
                                                lcReturn = ''

                                            Else &&LOWER( JUSTFNAME ( Evaluate( m.laOptions( m.lnOption, 2 ) ) ) ) == 'foxbin2prg.jpg'
                                                lcReturn = ' ' + Transform( Evaluate( m.laOptions( m.lnOption, 2 ) ) )

                                            Endif &&LOWER( JUSTFNAME ( Evaluate( m.laOptions( m.lnOption, 2 ) ) ) ) == 'foxbin2prg.jpg'
                                            lcReturn = Padr( m.lcReturn , Max( Len ( m.lcReturn )+1, Len( m.lcValue ) + 1 ) )

                                        Otherwise
* not defined. loop
                                            Loop

                                    Endcase
                                    If m.laOptions( m.lnOption, 3 ) = 4 THEN
*numeric to numeric, keep comment
                                        laLines( m.lnLine ) = Strtran(m.laLines( m.lnLine ) , m.lcValue, m.lcReturn)

                                    ELSE  &&m.laOptions( m.lnOption, 3 ) = 4
                                        laLines( m.lnLine ) = Substr(Strtran(m.laLines( m.lnLine ) , m.lcValue, m.lcReturn), 2 )

                                    ENDIF &&m.laOptions( m.lnOption, 3 ) = 4

                                Endif &&lnLine >0

                            Endfor &&lnOption

                            lcText  = ''

                            lnLines = m.lnLines+1
                            Dimension;
                                M.laLines( m.lnLines )

                            Ains(m.laLines,4)
                            laLines( 4 ) = Textmerge( m.loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 )
                            For lnLine = 1 To m.lnLines
                                lcText = m.lcText+ m.laLines( m.lnLine )+CR_LF
                            Endfor &&lnLine

                            Strtofile(  m.lcText, m.tc_InputFile )

                            .writeLog_Flush()

*!* /Changed by: LScheffler 07.3.2021

                        Case Empty(tc_InputFile)
*-- (Ejemplo de sintaxis y uso)
*MESSAGEBOX( loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC, 0+64+4096, 'FoxBin2Prg ' + THIS.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_SYNTAX_INFO_LOC + ' (' + .c_Language + ')', 60000 )
                            loFrm_Main  = Createobject('frm_main', This)
                            loFrm_Main.Show()
                            Read Events
                            lnCodError  = 0

                        Otherwise
*-- EJECUCIÓN NORMAL


                            If (Atc('-INTERACTIVE', ('-' + tcType)) > 0 Or Atc('-?', ('-' + tcType)) > 0 );
                                    AND Atc('-BIN2PRG', ('-' + tcType)) = 0 And Atc('-PRG2BIN', ('-' + tcType)) = 0 ;
                                    AND Atc('-BIN2TEXT','-'+tcType) = 0 And Atc('-TEXT2BIN','-'+tcType) = 0 ;
                                    AND lcInputFile_Type == C_FILETYPE_DIRECTORY Then
*-- Se seleccionó un directorio y se puede elegir: Bin2Txt, Txt2Bin y Nada
                                .writeLog( loLang.C_INTERACTIVE_DIRECTORY_SELECTION_LOC )
                                loFrm_Interactive   = Createobject('frm_interactive', This)
                                loFrm_Interactive.Show()
                                Read Events
                                lnConversionOption  = loFrm_Interactive.n_ConversionType

                                If loFrm_Interactive.l_FileTimeStampOptimization
                                    If .n_OptimizeByFilestamp = 0 Then
                                        .n_OptimizeByFilestamp = 2
                                    Endif
                                Else
                                    .n_OptimizeByFilestamp = 0
                                Endif

                                loFrm_Interactive.Release()
                                loFrm_Interactive = .Null.

                                Do Case
                                    Case lnConversionOption = 1     && Bin2Txt
                                        tcType  = tcType + '-BIN2PRG'

                                    Case lnConversionOption = 2     && Txt2Bin
                                        tcType  = tcType + '-PRG2BIN'

                                    Otherwise   && None
                                        Error 1799  && Conversion Cancelled
                                Endcase
                            Endif

*-- Evaluación de FileSpec de entrada
                            Do Case
                                Case Atc('-BIN2PRG', ('-' + tcType)) = 0 And Atc('-PRG2BIN', ('-' + tcType)) = 0 ;
                                        AND Atc('-BIN2TEXT','-'+tcType) = 0 And Atc('-TEXT2BIN','-'+tcType) = 0 ;
                                        AND lcInputFile_Type == C_FILETYPE_FILE ;
                                        AND ( '*' $ Justext( tc_InputFile ) Or '?' $ Justext( tc_InputFile ) )

                                    If .l_ShowErrors
*MESSAGEBOX( 'No se admiten extensiones * o ? porque es peligroso (se pueden pisar binarios con archivo xx2 vacíos).', 0+48+4096, 'FOXBIN2PRG: ERROR!!', 60000 )
                                        Messagebox( loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC, 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version + ': ' + loLang.C_FOXBIN2PRG_ERROR_CAPTION_LOC, 60000 )
                                        Exit
                                    Else
                                        Error loLang.C_ASTERISK_EXT_NOT_ALLOWED_LOC
                                    Endif


                                Case lcInputFile_Type == C_FILETYPE_FILE And ( '*' $ Juststem( tc_InputFile ) Or '?' $ Juststem( tc_InputFile ) )
*-- SE QUIEREN TODOS LOS ARCHIVOS DE UNA EXTENSIÓN
                                    lcFileSpec  = Fullpath( tc_InputFile )
                                    .c_LogFile  = Addbs( Justpath( lcFileSpec ) ) + Strtran( Justfname( lcFileSpec ), '*', '_ALL' ) + '.LOG'

                                    If .n_Debug > 0 Then
                                        Erase ( .c_LogFile )
                                    Endif

                                    If Evl(tcType,'0') <> '*' Then
                                        If .n_ShowProgressbar <> 0 And .l_ProcessFiles Then
                                            .loadProgressbarForm()
                                        Endif

                                        Do Case
                                            Case .l_Recompile And Len(tcRecompile) > 3 And Directory(tcRecompile)
                                                Cd (tcRecompile)
                                            Case tcRecompile == '1'
                                                Cd (Justpath(lcFileSpec))
                                        Endcase
                                    Endif

                                    lnFileCount = Adir( laFiles, lcFileSpec, '', 1 )

                                    For I = 1 To lnFileCount
                                        toModulo    = .Null.
                                        lcFile      = Forcepath( laFiles(m.I,1), Justpath( lcFileSpec ) )

                                        Do Case
                                            Case Upper( Justext( Evl(tc_InputFile,'') ) ) == 'PJX' And Left(Evl(tcType,'0'),1) == '*'
*-- SE QUIEREN CONVERTIR A TEXTO TODOS LOS ARCHIVOS DE UNO O MÁS PROYECTOS PJX
*-- Filespec: "*.PJX", "*"
                                                .evaluate_Full_PJX(lcFile, tcRecompile, @toModulo, @toEx, tcOriginalFileName, .c_LogFile, tcType)

                                            Case Upper( Justext( Evl(tc_InputFile,'') ) ) == .c_PJ2 And Left(Evl(tcType,'0'),1) == '*'
*-- SE QUIEREN CONVERTIR A BINARIO TODOS LOS ARCHIVOS DE UNO O MÁS PROYECTOS PJ2
*-- Filespec: "*.PJ2", "*"
                                                .evaluate_Full_PJ2(lcFile, tcRecompile, @toModulo, @toEx, tcOriginalFileName, .c_LogFile, tcType)

                                            Case Atc('-BIN2PRG', ('-' + tcType)) > 0;
                                                    OR Atc('-BIN2TEXT','-'+tcType) > 0
*-- SE QUIEREN CONVERTIR A TEXTO TODOS LOS ARCHIVOS DE UN DIRECTORIO
*-- Filespec: "*.*"
                                                If .hasSupport_Bin2Prg(lcFile) Then
                                                    .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                                                    lnCodError = .convert( lcFile, @toModulo, @toEx, .F., tcOriginalFileName )
                                                    .writeLog_Flush()

                                                    Do Case
                                                        Case lnCodError = 1799  && Conversion Cancelled
                                                            Error 1799

                                                        Case lnCodError > 0
                                                            .doWriteErrorLog( @toEx )
                                                            llError     = .T.
                                                            .l_Error    = .F.
                                                    Endcase
                                                Endif

                                            Case Atc('-PRG2BIN', ('-' + tcType)) > 0;
                                                    Or Atc('-TEXT2BIN','-'+tcType) > 0
*-- SE QUIEREN CONVERTIR A BINARIO TODOS LOS ARCHIVOS DE UN DIRECTORIO
*-- Filespec: "*.*"
                                                If .hasSupport_Prg2Bin(lcFile) Then
                                                    .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                                                    lnCodError = .convert( lcFile, @toModulo, @toEx, .F., tcOriginalFileName )
                                                    .writeLog_Flush()

                                                    Do Case
                                                        Case lnCodError = 1799  && Conversion Cancelled
                                                            Error 1799

                                                        Case lnCodError > 0
                                                            .doWriteErrorLog( @toEx )
                                                            llError     = .T.
                                                            .l_Error    = .F.
                                                    Endcase
                                                Endif

                                            Case Empty( Justext( Evl(tc_InputFile,'') ) )
*-- NO SE INDICÓ NINGUNA EXTENSIÓN
                                                Error loLang.C_INVALID_PARAMETER_LOC + ': cInputFile = "' + tc_InputFile + '"'

                                            Otherwise
*-- DEMÁS ARCHIVOS
*-- Filespec: "*.EXT"
                                                .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                                                lnCodError = .convert( lcFile, @toModulo, @toEx, .T., tcOriginalFileName )
                                                .writeLog_Flush()

                                                Do Case
                                                    Case lnCodError = 1799  && Conversion Cancelled
                                                        Error 1799

                                                    Case lnCodError > 0
                                                        .doWriteErrorLog( @toEx )
                                                Endcase
                                        Endcase
                                    Endfor && I = 1 TO lnFileCount

                                    If llError
                                        .l_Error = .T.
                                    Endif

                                    Exit


                                Case Atc('-BIN2PRG', ('-' + tcType)) > 0;
                                            Or Atc('-BIN2TEXT','-'+tcType) > 0
                                    .writeLog( '> ' + loLang.C_OPTION_LOC + ': BIN2PRG' )

                                    If .n_ShowProgressbar <> 0 And .l_ProcessFiles Then
                                        .loadProgressbarForm()
                                        .o_Frm_Avance.Caption = Strtran( .o_Frm_Avance.Caption, '> -', '(Bin>Txt) -' )
                                    Endif

                                    Do Case
                                        Case lcInputFile_Type == C_FILETYPE_DIRECTORY
*-- CONVERSION BIN2PRG DE UN DIRECTORIO Y SUBDIRECTORIOS
                                            .writeLog( '> InputFile ' + loLang.C_IS_A_DIRECTORY_LOC )
                                            .writeLog()

                                            Do Case
                                                Case .l_Recompile And Len(tcRecompile) > 3 And Directory(tcRecompile)
                                                    Cd (tcRecompile)
                                                Case .l_Recompile
                                                    Cd (tc_InputFile)
                                            Endcase

                                            .c_LogFile  = Addbs(tc_InputFile) + tcType + '.LOG'

                                            If .n_Debug > 0 Then
                                                Erase ( .c_LogFile )
                                            Endif

                                            .get_FilesFromDirectory( tc_InputFile, @laFiles, @lnFileCount )

                                            For I = 1 To lnFileCount
                                                toModulo    = .Null.
                                                lcFile      = laFiles(m.I)

                                                If Not .hasSupport_Bin2Prg( lcFile ) Or Not Adir(laDirInfo, lcFile) > 0 Then
                                                    Loop
                                                Endif

                                                .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                                                lnCodError = .convert( lcFile, @toModulo, @toEx, .F., tcOriginalFileName )
*!* Changed by: LScheffler 15.2.2021
*!* change date="{^2021-02-15,06:57:00}"
* flushing the log after each file let us only see last file
* why ever, it should be appended, but we simply move
* .writeLog_Flush() after ENDFOR

*                               .writeLog_Flush()

                                                Do Case
                                                    Case lnCodError = 1799  && Conversion Cancelled
                                                        Error 1799

                                                    Case lnCodError > 0
                                                        .doWriteErrorLog( @toEx )
                                                Endcase
                                            Endfor && I = 1 TO lnFileCount
                                            .writeLog_Flush()
*!* /Changed by: LScheffler 15.2.2021

                                            .updateProgressbar( loLang.C_END_OF_PROCESS_LOC, lnFileCount, lnFileCount, 0 )
                                            Exit

                                        Case Not .hasSupport_Bin2Prg( tc_InputFile ) Or Not Adir(laDirInfo, tc_InputFile) > 0
                                            .writeLog( '> InputFile ' + loLang.C_IS_UNSUPPORTED_LOC )
                                            .writeLog()
                                            Exit

                                    Endcase


                                Case Atc('-PRG2BIN', ('-' + tcType)) > 0;
                                        Or Atc('-TEXT2BIN','-'+tcType) > 0
                                    .writeLog( '> ' + loLang.C_OPTION_LOC + ': PRG2BIN' )

                                    If .n_ShowProgressbar <> 0 And .l_ProcessFiles Then
                                        .loadProgressbarForm()
                                        .o_Frm_Avance.Caption = Strtran( .o_Frm_Avance.Caption, '> -', '(Txt>Bin) -' )
                                    Endif

                                    Do Case
                                        Case lcInputFile_Type == C_FILETYPE_DIRECTORY
*-- CONVERSION PRG2BIN DE UN DIRECTORIO Y SUBDIRECTORIOS
                                            .writeLog( '> InputFile ' + loLang.C_IS_A_DIRECTORY_LOC )
                                            .writeLog()

                                            Do Case
                                                Case .l_Recompile And Len(tcRecompile) > 3 And Directory(tcRecompile)
                                                    Cd (tcRecompile)
                                                Case .l_Recompile
                                                    Cd (tc_InputFile)
                                            Endcase

                                            .c_LogFile  = Addbs(tc_InputFile) + tcType + '.LOG'

                                            If .n_Debug > 0 Then
                                                Erase ( .c_LogFile )
                                            Endif

                                            .get_FilesFromDirectory( tc_InputFile, @laFiles, @lnFileCount )


                                            For I = 1 To lnFileCount
                                                toModulo    = .Null.
                                                lcFile      = laFiles(m.I)

                                                If Not .hasSupport_Prg2Bin( lcFile ) Or Not Adir(laDirInfo, lcFile) > 0 Then
                                                    Loop
                                                Endif

                                                .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )
                                                lnCodError = .convert( lcFile, @toModulo, @toEx, .F., tcOriginalFileName )
*!* Changed by: LScheffler 15.2.2021
*!* change date="{^2021-02-15,06:57:00}"
* flushing the log after each file let us only see last file
* why ever, it should be appended, but we simply move
* .writeLog_Flush() after ENDFOR

*                               .writeLog_Flush()

                                                Do Case
                                                    Case lnCodError = 1799  && Conversion Cancelled
                                                        Error 1799

                                                    Case lnCodError > 0
                                                        .doWriteErrorLog( @toEx )
                                                Endcase
                                            Endfor && I = 1 TO lnFileCount
                                            .writeLog_Flush()
*!* /Changed by: LScheffler 15.2.2021

                                            .updateProgressbar( loLang.C_END_OF_PROCESS_LOC, lnFileCount, lnFileCount, 0 )
                                            Exit

                                        Case Not .hasSupport_Prg2Bin( tc_InputFile ) Or Not Adir(laDirInfo, tc_InputFile) > 0
                                            .writeLog( '> InputFile ' + loLang.C_IS_UNSUPPORTED_LOC )
                                            .writeLog()
                                            Exit

                                    Endcase


                            Endcase

*-- UN ARCHIVO INDIVIDUAL O CONSULTA DE SOPORTE DE ARCHIVO
                            If lcInputFile_Type = C_FILETYPE_QUERYSUPPORT
*-- Consulta de soporte de conversión (compatibilidad con SourceSafe)
*-- SourceSafe consulta el tipo de soporte de cada archivo antes del Checkin/Checkout
*-- para saber si se puede hacer Diff y Merge.
*-- Para los códigos de tipo de archivo ver ayuda de "Type Property"
                                Do Case
                                    Case tc_InputFile $ FILETYPE_PROJECT    && PJX (J no exite en FoxPro, es un valor inventado para evitar conflicto con los tipos existentes)
                                        lnCodError  = .n_PJX_Conversion_Support

                                    Case tc_InputFile == FILETYPE_CLASSLIB
                                        lnCodError  = .n_X_Conversion_Support

                                    Case tc_InputFile == FILETYPE_FORM
                                        lnCodError  = .n_SCX_Conversion_Support

                                    Case tc_InputFile == FILETYPE_REPORT
                                        lnCodError  = .n_FRX_Conversion_Support

                                    Case tc_InputFile == FILETYPE_LABEL
                                        lnCodError  = .n_LBX_Conversion_Support

                                    Case tc_InputFile == FILETYPE_MENU
                                        lnCodError  = .n_MNX_Conversion_Support

                                    Case tc_InputFile == FILETYPE_DATABASE
                                        lnCodError  = .n_DBC_Conversion_Support

                                    Case tc_InputFile == FILETYPE_FREETABLE
                                        lnCodError  = .n_DBF_Conversion_Support

                                    Otherwise
                                        lnCodError  = -1    && No support.
                                Endcase

                            Else

                                Do Case
                                    Case Upper( Justext( Evl(tc_InputFile,'') ) ) == 'PJX' And Left(Evl(tcType,'0'),1) == '*'
*-- SE QUIEREN CONVERTIR A TEXTO TODOS LOS ARCHIVOS DE UN PROYECTO PJX
                                        .evaluate_Full_PJX(tc_InputFile, tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', tcType)
                                        Exit

                                    Case Upper( Justext( Evl(tc_InputFile,'') ) ) == .c_PJ2 And Left(Evl(tcType,'0'),1) == '*'
*-- SE QUIEREN CONVERTIR A BINARIO TODOS LOS ARCHIVOS DE UN PROYECTO PJ2
                                        .evaluate_Full_PJ2(tc_InputFile, tcRecompile, @toModulo, @toEx, @tcOriginalFileName, '', tcType)
                                        Exit

                                    Case Inlist( Evl(tcType,'0') ;
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
                                            AND Evl(tcTextName,'0') <> '0'
*-- COMPATIBILIDAD CON SOURCESAFE. 30/01/2014
                                        If tlGenText
                                            .writeLog( '> ' + loLang.C_SOURCESAFE_COMPATIBILITY_MODE_LOC + ': ' + loLang.C_BINARY_TO_TEXT_LOC )
                                        Else
*-- Create BINARIO desde versión TEXTO
*-- Como el archivo de entrada siempre es el binario cuando se usa SCCAPI,
*-- para regenerar el binario (tlGenText=.F.) se debe usar como
*-- archivo de entrada tcTextName en su lugar. Aquí los intercambio.
                                            tc_InputFile        = tcTextName
                                            .l_Recompile    = .T.
                                            .writeLog( '> ' + loLang.C_SOURCESAFE_COMPATIBILITY_MODE_LOC + ': ' + loLang.C_TEXT_TO_BINARY_LOC )
                                        Endif
                                Endcase

                                If Adir(laDirInfo, tc_InputFile) > 0
                                    If .n_ShowProgressbar <> 0 And .l_ProcessFiles Then
                                        .loadProgressbarForm()
                                    Endif

                                    .writeLog( '> InputFile ' + loLang.C_IS_A_FILE_LOC )
                                    .writeLog()
                                    tc_InputFile    = Locfile(tc_InputFile)

                                    Do Case
                                        Case .l_Recompile And Len(tcRecompile) > 3 And Directory(tcRecompile)
                                            Cd (tcRecompile)
                                        Case tcRecompile == '1'
                                            Cd (Justpath(tc_InputFile))
                                    Endcase

                                    .c_LogFile  = tc_InputFile + '.LOG'

                                    If .n_Debug > 0 Then
                                        Erase ( .c_LogFile )
                                    Endif

                                    lnCodError = .convert( tc_InputFile, @toModulo, @toEx, .T., tcOriginalFileName )
*.updateProgressbar( loLang.C_END_OF_PROCESS_LOC, 1, 1, 0 )
                                Endif
                            Endif

                    Endcase
                Endwith && THIS

            Catch To toEx
                If Not llEscKeyRestored And This.l_CancelWithEscKey Then
                    If Empty(lcOldOnEscape)
                        On Escape
                    Else
                        On Escape &lcOldOnEscape.
                    Endif

                    If Empty(lcOldSetEscape)
                        Set Escape Off
                    Else
                        Set Escape &lcOldSetEscape.
                    Endif
                    llEscKeyRestored = .T.
                Endif

                lnCodError      = toEx.ErrorNo
                lnErrorIcon     = 64

                If Vartype(loLang) <> 'O' Then
                    loLang      = Createobject("CL_LANG","EN")
                Endif

                If lnCodError <> 1799 Then  && Conversion Cancelled
                    toEx.UserValue  = toEx.UserValue + 'FoxBin2Prg: [' + This.c_Foxbin2prg_FullPath + '] (EXE Version: ' + This.c_FB2PRG_EXE_Version + ')' + CR_LF
                    lnErrorIcon     = 16
                Endif

                If Atc('-SHOWMSG', ('-' + tcType)) > 0 Then
                    If lnCodError <> 1799 Then  && Conversion Cancelled
                        toEx.UserValue = toEx.UserValue + 'lcInputFile_Type  = [' + Transform(lcInputFile_Type) + ']' + CR_LF
                    Endif
                    This.l_ShowErrors   = .F.   && La opción "SHOWMSG" muestra su propio mensaje
                Endif

                If lnCodError <> 1799 Then  && Conversion Cancelled
                    toEx.UserValue = toEx.UserValue + 'tc_InputFile = [' + Transform(tc_InputFile) + ']' + CR_LF
                Endif

                This.doWriteErrorLog( @toEx, @lcErrorInfo )

                If This.n_Debug > 0 Then
                    If _vfp.StartMode = 0
                        Set Step On
                    Endif
                Endif

                If tlRelanzarError
                    Throw
                Endif

            Finally
                If Not llEscKeyRestored And This.l_CancelWithEscKey Then
                    If Empty(lcOldOnEscape)
                        On Escape
                    Else
                        On Escape &lcOldOnEscape.
                    Endif

                    If Empty(lcOldSetEscape)
                        Set Escape Off
                    Else
                        Set Escape &lcOldSetEscape.
                    Endif
                    llEscKeyRestored = .T.
                Endif

                If Vartype(loLang) <> 'O' Then
                    loLang      = Createobject("CL_LANG","EN")
                Endif

                Use In (Select("TABLABIN"))
                This.writeLog_Flush()
                This.unloadProgressbarForm()
                Cd (Justpath(This.c_CurDir))

                Do Case
                    Case Evl( lcInputFile_Type, C_FILETYPE_QUERYSUPPORT ) <> C_FILETYPE_QUERYSUPPORT ;
                            AND Atc('-SHOWMSG', ('-' + tcType)) > 0 ;
                            OR This.l_ShowErrors And lnCodError > 0 And Not Isnull(toEx)
                        This.writeErrorLog_Flush()

                        Do Case
                            Case lnCodError = 1098  && User Error
                                Messagebox( toEx.Message, 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
*loWSH.Run( THIS.c_ErrorLogFile, 3 )
                                This.wscriptshell_run( This.c_ErrorLogFile, 3 )

                            Case lnCodError = 1799  && Conversion Cancelled
                                Messagebox( loLang.C_CONVERSION_CANCELLED_BY_USER_LOC + '!', 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )

                            Case This.l_Errors
                                If Adir(laDirInfo, This.c_ErrorLogFile) > 0 Then
                                    Messagebox( loLang.C_END_OF_PROCESS_LOC + '! (' + loLang.C_WITH_ERRORS_LOC + ')', 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
*loWSH.Run( THIS.c_ErrorLogFile, 3 )
                                    This.wscriptshell_run( This.c_ErrorLogFile, 3 )
                                Else
                                    Messagebox( loLang.C_END_OF_PROCESS_LOC + '! (' + loLang.C_WITH_ERRORS_LOC + ')' + CR_LF + "[Warning: Can't show Error LOG file because does not exist!]", 0+48+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )
                                Endif

                            Otherwise
                                Messagebox( loLang.C_END_OF_PROCESS_LOC + '', 0+64+4096, 'FoxBin2Prg ' + This.c_FB2PRG_EXE_Version, 60000 )

                        Endcase

                Endcase

                If Empty(lnCodError) And This.l_Errors
                    lnCodError = 1098
                Endif

                Set Notify &lc_OldSetNotify.
                Store .Null. To loFSO, loWSH, loDBF_CFG
                Release I, lcPath, lcFileSpec, lcFile, laFiles, lnFileCount, lcErrorInfo, lcErrorFile, loEx, loFSO
        Endtry

        Return lnCodError
    Endproc


    Procedure evaluate_Full_PJX
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
        Lparameters tc_InputFile, tcRecompile, toModulo, toEx, tcOriginalFileName, tcLogFile, tcType

        Local lcFileSpec, lnFileCount, laFiles(1,1), lcFile, lnCodError, I, lnFileCount, llError, laDirInfo(1,5) ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
            , loEx As Exception

        Try
                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    loLang      = _Screen.o_FoxBin2Prg_Lang
                    lcFileSpec  = Fullpath( tc_InputFile )

                    If .n_ShowProgressbar <> 0 And .l_ProcessFiles Then
                        .loadProgressbarForm()
                        .o_Frm_Avance.Caption = Strtran( .o_Frm_Avance.Caption, '> -', '(Bin>Txt) -' )
                    Endif

                    If Empty(tcLogFile)
                        .c_LogFile  = Addbs( Justpath( lcFileSpec ) ) + Strtran( Justfname( lcFileSpec ), '*', '_ALL' ) + '.LOG'

                        If .n_Debug > 0 Then
                            Erase ( .c_LogFile )
                        Endif
                    Endif

                    .writeLog( '> ' + loLang.C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC + ': ' + loLang.C_BINARY_TO_TEXT_LOC )

                    Do Case
                        Case .l_Recompile And Len(tcRecompile) > 3 And Directory(tcRecompile)
                            Cd (tcRecompile)
                        Case tcRecompile == '1'
                            Cd (Justpath(lcFileSpec))
                    Endcase

                    Select 0
                    Use (tc_InputFile) Shared Again Noupdate Alias TABLABIN
                    lnFileCount = 0

                    Scan For Not Deleted() And Type <> 'H'
                        lnFileCount = lnFileCount + 1
                        Dimension laFiles(lnFileCount,1)
                        laFiles(lnFileCount,1)  = .get_AbsolutePath( Alltrim( Name, 0, ' ', Chr(0) ), Addbs( Justpath( lcFileSpec ) ) )
                    Endscan

                    Use In (Select("TABLABIN"))

*-- Convierto primero el proyecto
                    If tcType <> '*-' Then
                        lcFile      = tc_InputFile
                        lnCodError  = .convert( lcFile, toModulo, @toEx, .T., tcOriginalFileName )
                        .writeLog_Flush()
                    Endif

*-- Luego convierto los archivos incluidos
                    For I = 1 To lnFileCount
                        lcFile      = laFiles(m.I,1)
                        .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )

                        If .hasSupport_Bin2Prg( Upper(Justext(lcFile)) ) And Adir( laDirInfo, lcFile ) > 0 Then
                            lnCodError  = .convert( lcFile, toModulo, @toEx, .F., tcOriginalFileName )
                            .writeLog_Flush()

                            Do Case
                                Case lnCodError = 1799  && Conversion Cancelled
                                    Error 1799

                                Case lnCodError > 0
                                    .doWriteErrorLog( @toEx )
                                    llError     = .T.
                                    .l_Error    = .F.
                            Endcase
                        Else
*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                            If .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                                .updateProcessedFile()
                            Endif
                        Endif

                        .writeLog_Flush()

                        If llError
                            .l_Error = .T.
                        Endif
                    Endfor
                Endwith

            Catch To loEx
                Throw

            Finally
                Store .Null. To loLang
                Release loLang
        Endtry
    Endproc


    Procedure evaluate_Full_PJ2
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
        Lparameters tc_InputFile, tcRecompile, toModulo, toEx, tcOriginalFileName, tcLogFile, tcType

        Local lcFileSpec, lnFileCount, laFiles(1,1), lcFile, lnCodError, I, lnFileCount, llError, laDirInfo(1,5) ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
            , loEx As Exception

        Try
                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    loLang      = _Screen.o_FoxBin2Prg_Lang
                    lcFileSpec  = Fullpath( tc_InputFile )

                    If .n_ShowProgressbar <> 0 And .l_ProcessFiles Then
                        .loadProgressbarForm()
                        .o_Frm_Avance.Caption = Strtran( .o_Frm_Avance.Caption, '> -', '(Txt>Bin) -' )
                    Endif

                    If Empty(tcLogFile)
                        .c_LogFile  = Addbs( Justpath( lcFileSpec ) ) + Strtran( Justfname( lcFileSpec ), '*', '_ALL' ) + '.LOG'

                        If .n_Debug > 0 Then
                            Erase ( .c_LogFile )
                        Endif
                    Endif

                    .writeLog( '> ' + loLang.C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC + ': ' + loLang.C_TEXT_TO_BINARY_LOC )

                    Do Case
                        Case .l_Recompile And Len(tcRecompile) > 3 And Directory(tcRecompile)
                            Cd (tcRecompile)
                        Case tcRecompile == '1'
                            Cd (Justpath(lcFileSpec))
                    Endcase

                    lnFileCount = Alines( laFiles, Strextract( Filetostr(tc_InputFile), C_BUILDPROJ_I, C_BUILDPROJ_F ), 1+4 )

                    For I = lnFileCount To 1 Step -1
                        If '.ADD(' $ laFiles(m.I)
                            lcFile      = .get_AbsolutePath( Strextract( laFiles(m.I), ".ADD('", "')" ), Addbs( Justpath( lcFileSpec ) ) )
                            laFiles(m.I)    = Forceext( lcFile, .get_Ext2FromExt( Upper(Justext(lcFile)) ) )
                        Else
                            lnFileCount = lnFileCount - 1
                            Adel( laFiles, m.I )
                            Dimension laFiles(lnFileCount)
                        Endif
                    Endfor

*-- Convierto primero el proyecto
                    If tcType <> '*-' Then
                        lcFile  = tc_InputFile
                        lnCodError = .convert( lcFile, toModulo, @toEx, .T., tcOriginalFileName )
                        .writeLog_Flush()
                    Endif

*-- Luego convierto los archivos incluidos
                    For I = 1 To lnFileCount
                        lcFile  = laFiles(m.I)
                        .updateProgressbar( loLang.C_PROCESSING_LOC + ' ' + lcFile + '...', m.I, lnFileCount, 0 )

                        If .hasSupport_Prg2Bin( Upper(Justext(lcFile)) ) And Adir( laDirInfo, lcFile ) > 0 Then
                            lnCodError = .convert( lcFile, toModulo, @toEx, .F., tcOriginalFileName )
                            .writeLog_Flush()

                            Do Case
                                Case lnCodError = 1799  && Conversion Cancelled
                                    Error 1799

                                Case lnCodError > 0
                                    .doWriteErrorLog( @toEx )
                                    llError     = .T.
                                    .l_Error    = .F.
                            Endcase
                        Else
*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                            If .addProcessedFile( lcFile, 'I', 'P0', 'E0', 'S0', 'X0' )
                                .updateProcessedFile()
                            Endif
                        Endif

                        .writeLog_Flush()

                        If llError
                            .l_Error = .T.
                        Endif
                    Endfor
                Endwith

            Catch To loEx
                Throw

            Finally
                Store .Null. To loLang
                Release loLang
        Endtry
    Endproc


    Hidden Procedure doWriteErrorLog
        Lparameters toEx As Exception, tcErrorInfo

        Local loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
        loLang          = _Screen.o_FoxBin2Prg_Lang

        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            If toEx.ErrorNo = 1799 Then     && Conversion Cancelled
                tcErrorInfo     = loLang.C_CONVERSION_CANCELLED_BY_USER_LOC
            Else
                tcErrorInfo     = .exception2Str(@toEx) + CR_LF + loLang.C_SOURCEFILE_LOC + Transform(.c_InputFile) + CR_LF
            Endif

            AddProperty(_Screen, 'ExitCode', toEx.ErrorNo)

*-- Escribo la información de error en la variable log de errores
            .writeErrorLog( Replicate('-', 100), 1 )
            .writeLog( tcErrorInfo )
            .writeErrorLog( tcErrorInfo )
            .writeErrorLog( )

*-- Escribo la información de error en el archivo log de errores
            Try
                    Strtofile( tcErrorInfo, Evl( .c_InputFile, 'foxbin2prg_errorlog' ) + '.ERR' )
                Catch
            Endtry
        Endwith

        Return
    Endproc


    Protected Procedure convert
*--------------------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_InputFile              (v! IN    ) Nombre del archivo de entrada
* toModulo                  (@?    OUT) Referencia de objeto del módulo generado (para Unit Testing)
* toEx                      (@?    OUT) Objeto con información del error
* tlRelanzarError           (v? IN    ) Indica si el error debe relanzarse o no
* tcOriginalFileName        (v? IN    ) Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar
*                                       el nombre correcto dentro de la versión texto (por ej: en los PJ2 y las cabeceras)
*--------------------------------------------------------------------------------------------------------------
        Lparameters tc_InputFile, toModulo, toEx As Exception, tlRelanzarError, tcOriginalFileName

        Try
                Local lnCodError, lcErrorInfo, laDirFile(1,5), lcExtension, lnFileCount, laFiles(1,1), I ;
                    , ltFilestamp, lcExtA, lcExtB, laEvents(1,1), lcForceAttribs, lnIDInputFile ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
                    , loConversor As c_conversor_base Of 'FOXBIN2PRG.PRG' ;
                    , loFSO As Scripting.FileSystemObject ;
                    , loDBF_CFG As CL_DBF_CFG Of 'FOXBIN2PRG.PRG'
                lnCodError          = 0

                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    loFSO           = .o_FSO
                    loLang          = _Screen.o_FoxBin2Prg_Lang
                    lcForceAttribs  = '+N'
                    .c_InputFile    = Fullpath( tc_InputFile )
                    .l_Error        = .F.
                    lcExtension     = Upper( Justext(.c_InputFile) )

                    .writeLog( Replicate( '*', 100 ) )
                    .writeLog( 'CONVERSION PROCESS', 2 )
                    .writeLog( Replicate( '*', 100 ) )

                    If Adir( laDirFile, .c_InputFile, '', 1 ) = 0
*ERROR 'No se encontró el archivo [' + .c_InputFile + ']'
                        Error loLang.C_FILE_NOT_FOUND_LOC + ' [' + .c_InputFile + ']'
                    Endif

                    .c_InputFile    = loFSO.GetAbsolutePathName( Forcepath( laDirFile(1,1), Justpath(.c_InputFile) ) )

*-- VERIFICO SI HAY ARCHIVO DE CONFIGURACIÓN SECUNDARIO
                    .evaluateConfiguration()

                    If .n_ForceWriteIfReadOnly = 1 Then
                        lcForceAttribs  = lcForceAttribs + '-R'
                    Endif

*!* Changed by: LScheffler 03.03.2021
*!* change date="{^2021-03-03,11:38:00}"
* Added option for DBC split

*-- OPTIMIZACIÓN VC2/SC2: VERIFICO SI EL ARCHIVO BASE FUE PROCESADO PARA DESCARTAR REPROCESOS
                    If Inlist(lcExtension,"VCX",.c_VC2);
                            AND (.n_UseClassPerFile > 0 And .l_RedirectClassPerFileToMain ;
                            OR Not Empty(.c_ClassToConvert))

                        Do Case

                            Case .n_RedirectClassType = 1 Or Not Empty(.c_ClassToConvert) && Redireccionar solo esta clase
                                If Occurs('.', Juststem(.c_InputFile)) = 0 Then
                                    lc_BaseFile = .c_InputFile
                                Else
                                    lc_BaseFile = Forcepath( Forceext( Juststem( Juststem(.c_InputFile) ), Justext(.c_InputFile)) , Justpath(.c_InputFile) )
                                Endif

                            Case .n_UseClassPerFile = 1 And Inlist(lcExtension,.c_VC2)
                                If Occurs('.', Juststem(.c_InputFile)) = 0 Then
                                    lc_BaseFile = .c_InputFile
                                Else
                                    lc_BaseFile = Forcepath( Forceext( Juststem( Juststem(.c_InputFile) ), Justext(.c_InputFile)) , Justpath(.c_InputFile) )
                                Endif

*-- Verifico si se debe forzar la redirección al archivo principal
                                If '.' $ Juststem(.c_InputFile)
                                    .c_InputFile    = lc_BaseFile
                                Endif
** LScheffler, Problem, Fehler: DC2 hier nicht, das muss anders mit UseFilesPerDBC
                            Case .n_UseClassPerFile = 2 And Inlist(lcExtension,.c_VC2)
                                If Occurs('.', Juststem(.c_InputFile)) = 0 Then
                                    lc_BaseFile = .c_InputFile
                                Else
                                    lc_BaseFile = Forcepath( Forceext( Juststem( Juststem( Juststem(.c_InputFile) ) ), Justext(.c_InputFile)) , Justpath(.c_InputFile) )
                                Endif

*-- Verifico si se debe forzar la redirección al archivo principal
                                If '.' $ Juststem(.c_InputFile)
                                    .c_InputFile    = lc_BaseFile
                                Endif

                        Endcase
                    Endif

                    If Inlist(lcExtension,"SCX",.c_SC2);
                            AND (.n_UseFormPerFile > 0 And .l_RedirectFormPerFileToMain ;
                            OR Not Empty(.c_ClassToConvert))

                        Do Case

                            Case .n_RedirectFormType = 1 Or Not Empty(.c_ClassToConvert) && Redireccionar solo esta clase
                                If Occurs('.', Juststem(.c_InputFile)) = 0 Then
                                    lc_BaseFile = .c_InputFile
                                Else
                                    lc_BaseFile = Forcepath( Forceext( Juststem( Juststem(.c_InputFile) ), Justext(.c_InputFile)) , Justpath(.c_InputFile) )
                                Endif

                            Case .n_UseFormPerFile = 1 And Inlist(lcExtension,.c_SC2)
                                If Occurs('.', Juststem(.c_InputFile)) = 0 Then
                                    lc_BaseFile = .c_InputFile
                                Else
                                    lc_BaseFile = Forcepath( Forceext( Juststem( Juststem(.c_InputFile) ), Justext(.c_InputFile)) , Justpath(.c_InputFile) )
                                Endif

*-- Verifico si se debe forzar la redirección al archivo principal
                                If '.' $ Juststem(.c_InputFile)
                                    .c_InputFile    = lc_BaseFile
                                Endif
** LScheffler, Problem, Fehler: DC2 hier nicht, das muss anders mit UseFilesPerDBC
                            Case .n_UseFormPerFile = 2 And Inlist(lcExtension,.c_SC2)
                                If Occurs('.', Juststem(.c_InputFile)) = 0 Then
                                    lc_BaseFile = .c_InputFile
                                Else
                                    lc_BaseFile = Forcepath( Forceext( Juststem( Juststem( Juststem(.c_InputFile) ) ), Justext(.c_InputFile)) , Justpath(.c_InputFile) )
                                Endif

*-- Verifico si se debe forzar la redirección al archivo principal
                                If '.' $ Juststem(.c_InputFile)
                                    .c_InputFile    = lc_BaseFile
                                Endif

                        Endcase
                    Endif
*****************************

*-- OPTIMIZACIÓN DC2: VERIFICO SI EL ARCHIVO BASE FUE PROCESADO PARA DESCARTAR REPROCESOS
                    If Inlist(lcExtension,"DBC",.c_DC2);
                            AND .n_UseFilesPerDBC > 0 And .l_RedirectFilePerDBCToMain;
                            AND .n_UseFilesPerDBC = 1

                        If Occurs('.', Juststem(.c_InputFile)) = 0 Then
                            lc_BaseFile = .c_InputFile
                        Else
                            lc_BaseFile = Forcepath( Forceext( Juststem( Juststem( Juststem(.c_InputFile) ) ), Justext(.c_InputFile)) , Justpath(.c_InputFile) )
                        Endif

*-- Verifico si se debe forzar la redirección al archivo principal
                        If '.' $ Juststem(.c_InputFile)
                            .c_InputFile    = lc_BaseFile
                        Endif

                    Endif

*!* /Changed by: LScheffler 03.03.2021

                    Erase ( .c_InputFile + '.ERR' )

                    If Not Empty(tcOriginalFileName)
                        tcOriginalFileName  = loFSO.GetAbsolutePathName( tcOriginalFileName )
                    Endif

                    .c_OriginalFileName = Evl( tcOriginalFileName, .c_InputFile )

                    If Upper( Justext(.c_OriginalFileName) ) = 'PJM' And .c_PJ2 <> 'PJM'
                        .c_OriginalFileName = Forceext(.c_OriginalFileName,'pjx')
                    Endif

*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                    If Not .addProcessedFile( .c_InputFile, 'I', 'P1', 'E0', 'S1', 'X0' ) Then
*.writeLog( 'OPTIMIZACIÓN: El archivo Base [' + JUSTFNAME(lc_BaseFile) + '] ya fue procesado, por lo que no se procesará [' + JUSTFNAME(.c_InputFile) + ']' )
                        .writeLog( C_TAB + C_TAB + '* ' + Textmerge( loLang.C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC ) )
                        Exit
                    Endif

*.updateProcessedFile()
                    lnIDInputFile   = .n_ProcessedFiles

                    .writeLog( C_TAB + 'c_OriginalFileName:           ' + .c_OriginalFileName )
                    .writeLog( )

                    If Not Adir(laDirFile, .c_InputFile) > 0 Then
                        Error loLang.C_FILE_DOESNT_EXIST_LOC + ' [' + .c_InputFile + ']'
                    Endif

                    .normalizeFileCapitalization( .T. )

                    Do Case
                        Case lcExtension = 'VCX'
                            If Not Inlist(.n_VCX_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_VC2 )
                            loConversor     = Createobject( 'c_conversor_vcx_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_VC2 ), lcForceAttribs )

                        Case lcExtension = 'SCX'
                            If Not Inlist(.n_SCX_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_SC2 )
                            loConversor     = Createobject( 'c_conversor_scx_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_SC2 ), lcForceAttribs )

                        Case lcExtension = 'PJX'
                            If Not Inlist(.n_PJX_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_PJ2 )
                            loConversor     = Createobject( 'c_conversor_pjx_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_PJ2 ), lcForceAttribs )

                        Case lcExtension = 'PJM' And .c_PJ2 <> 'PJM'
                            If Not Inlist(.n_PJX_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_PJ2 )
                            loConversor     = Createobject( 'c_conversor_pjm_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_PJ2 ), lcForceAttribs )

                        Case lcExtension = 'FRX'
                            If Not Inlist(.n_FRX_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_FR2 )
                            loConversor     = Createobject( 'c_conversor_frx_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_FR2 ), lcForceAttribs )

                        Case lcExtension = 'LBX'
                            If Not Inlist(.n_LBX_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_LB2 )
                            loConversor     = Createobject( 'c_conversor_frx_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_LB2 ), lcForceAttribs )

                        Case lcExtension = 'DBF'
                            lnFileCount = .get_DBF_Configuration( Forceext(.c_InputFile, 'DBF'), @loDBF_CFG )
                            If !Iif(Isnull(loDBF_CFG), Inlist(.n_DBF_Conversion_Support, 1, 2, 4, 8), Inlist(loDBF_CFG.n_DBF_Conversion_Support, 1, 2, 4, 8) )
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_DB2 )
                            loConversor     = Createobject( 'c_conversor_dbf_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_DB2 ), lcForceAttribs )

                        Case lcExtension = 'DBC'
                            If Not Inlist(.n_DBC_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_DC2 )
                            loConversor     = Createobject( 'c_conversor_dbc_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_DC2 ), lcForceAttribs )

                        Case lcExtension = 'MNX'
                            If Not Inlist(.n_MNX_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_MN2 )
                            loConversor     = Createobject( 'c_conversor_mnx_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_MN2 ), lcForceAttribs )

                        Case lcExtension = 'FKY'
                            If Not Inlist(.n_FKY_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_FK2 )
                            loConversor     = Createobject( 'c_conversor_fky_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_FK2 ), lcForceAttribs )

                        Case lcExtension = 'MEM'
                            If Not Inlist(.n_MEM_Conversion_Support, 1, 2)
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, .c_ME2 )
                            loConversor     = Createobject( 'c_conversor_mem_a_prg' )
                            .changeFileAttribute( Forceext( .c_InputFile, .c_ME2 ), lcForceAttribs )

                        Case lcExtension = .c_VC2
                            If .n_VCX_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            If Empty(.c_ClassToConvert)
                                .c_OutputFile   = Forceext( .c_InputFile, 'VCX' )
                            Else
* Si se usó la sintaxis "classlib.vcx::clase::import", se define el OutputFile
* con la Base "classlib.vcx" y no con el archivo entero.
                                .c_OutputFile   = Forceext( lc_BaseFile, 'VCX' )
                            Endif
                            loConversor     = Createobject( 'c_conversor_prg_a_vcx' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'VCX' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'VCT' ), lcForceAttribs )

                        Case lcExtension = .c_SC2
                            If .n_SCX_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'SCX' )
                            loConversor     = Createobject( 'c_conversor_prg_a_scx' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'SCX' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'SCT' ), lcForceAttribs )

                        Case lcExtension = .c_PJ2
                            If .n_PJX_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'PJX' )
                            loConversor     = Createobject( 'c_conversor_prg_a_pjx' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'PJX' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'PJT' ), lcForceAttribs )

                        Case lcExtension = .c_FR2
                            If .n_FRX_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'FRX' )
                            loConversor     = Createobject( 'c_conversor_prg_a_frx' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'FRX' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'FRT' ), lcForceAttribs )

                        Case lcExtension = .c_LB2
                            If .n_LBX_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'LBX' )
                            loConversor     = Createobject( 'c_conversor_prg_a_frx' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'LBX' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'LBT' ), lcForceAttribs )

                        Case lcExtension = .c_DB2
                            lnFileCount = .get_DBF_Configuration( Forceext(.c_InputFile, 'DBF'), @loDBF_CFG )
                            If !Iif(Isnull(loDBF_CFG), Inlist(.n_DBF_Conversion_Support, 2, 8), Inlist(loDBF_CFG.n_DBF_Conversion_Support, 2, 8) )
*-- Soporte txt-2-bin habilitado
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'DBF' )
                            loConversor     = Createobject( 'c_conversor_prg_a_dbf' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'DBF' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'FPT' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'CDX' ), lcForceAttribs )

                        Case lcExtension = .c_DC2
                            If .n_DBC_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'DBC' )
                            loConversor     = Createobject( 'c_conversor_prg_a_dbc' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'DBC' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'DCX' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'DCT' ), lcForceAttribs )

                        Case lcExtension = .c_MN2
                            If .n_MNX_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'MNX' )
                            loConversor     = Createobject( 'c_conversor_prg_a_mnx' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'MNX' ), lcForceAttribs )
                            .changeFileAttribute( Forceext( .c_InputFile, 'MNT' ), lcForceAttribs )

                        Case lcExtension = .c_FK2
                            If .n_FKY_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'FKY' )
                            loConversor     = Createobject( 'c_conversor_prg_a_fky' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'FKY' ), lcForceAttribs )

                        Case lcExtension = .c_ME2
                            If .n_MEM_Conversion_Support <> 2
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endif
                            .c_OutputFile   = Forceext( .c_InputFile, 'MEM' )
                            loConversor     = Createobject( 'c_conversor_prg_a_mem' )
                            .changeFileAttribute( Forceext( .c_InputFile, 'MEM' ), lcForceAttribs )

                        Otherwise
*ERROR 'El archivo [' + .c_InputFile + '] no está soportado'
                            Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))

                    Endcase

*** DH 2021-03-04: handle cOutputFolder
                    loConversor.cOutputFolder = This.cOutputFolder

*-- Optimización: Comparación de los timestamps de InputFile y OutputFile para saber
*-- si el OutputFile se debe regenerar o no.
                    lnFileCount = Adir( laFiles, Forceext( .c_InputFile, '*' ), '', 1 )
                    Store {//::} To .t_InputFile_TimeStamp, .t_OutputFile_TimeStamp, ltFilestamp

                    If lnFileCount > 0 Then
*-- Busca el archivo de entrada original
                        I   = Ascan( laFiles, Justfname(.c_InputFile), 1, 0, 1, 1+2+4+8 )
                        If m.I > 0 Then
                            .t_InputFile_TimeStamp  =   Datetime( Year(laFiles(m.I,3)), Month(laFiles(m.I,3)), Day(laFiles(m.I,3)) ;
                                , Val(Left(laFiles(m.I,4),2)), Val(Substr(laFiles(m.I,4),4,2)), Val(Right(laFiles(m.I,4),2)) )
                        Endif

                        If Adir( laDirFile, .c_OutputFile ) > 0 Then
                            I   = Ascan( laFiles, Justfname(.c_OutputFile), 1, 0, 1, 1+2+4+8 )
                            If m.I > 0 Then
                                .t_OutputFile_TimeStamp =   Datetime( Year(laFiles(m.I,3)), Month(laFiles(m.I,3)), Day(laFiles(m.I,3)) ;
                                    , Val(Left(laFiles(m.I,4),2)), Val(Substr(laFiles(m.I,4),4,2)), Val(Right(laFiles(m.I,4),2)) )
                            Endif

                            lcExtA  = Upper(Justext(.c_OutputFile))

                            Do Case
                                Case Inlist(lcExtA, 'SCX', 'VCX', 'MNX', 'FRX', 'LBX')
                                    lcExtB  = Icase(lcExtA = 'SCX', 'SCT' ;
                                        , lcExtA = 'VCX', 'VCT' ;
                                        , lcExtA = 'MNX', 'MNT' ;
                                        , lcExtA = 'FRX', 'FRT' ;
                                        , lcExtA = 'LBX', 'LBT')
                                    I   = Ascan( laFiles, Justfname( Forceext(.c_OutputFile, lcExtB) ), 1, 0, 1, 1+2+4+8 )
                                    If m.I > 0 Then
                                        ltFilestamp = Datetime( Year(laFiles(m.I,3)), Month(laFiles(m.I,3)), Day(laFiles(m.I,3)) ;
                                            , Val(Left(laFiles(m.I,4),2)), Val(Substr(laFiles(m.I,4),4,2)), Val(Right(laFiles(m.I,4),2)) )
                                    Endif

                            Endcase

*-- Tomo el máximo timestamp de los archivos de salida (??X/??T)
                            .t_OutputFile_TimeStamp =   Max( .t_OutputFile_TimeStamp, ltFilestamp )
                        Endif
                    Endif

                    Do Case
                        Case Inlist(lcExtension,"VCX",.c_VC2) AND .n_UseClassPerFile = 0 And .n_OptimizeByFilestamp = 1 And .t_InputFile_TimeStamp < .t_OutputFile_TimeStamp
*-- Optimizado: El Origen es anterior al Destino - No hace falta regenerar
*.writeLog( '> El archivo de salida [<<THIS.c_OutputFile>>] no se regenera porque su timestamp es más nuevo que el de entrada.' )
                            .writeLog( C_TAB + C_TAB + '* ' + Textmerge(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )

                        Case Inlist(lcExtension,"VCX",.c_VC2) AND .n_UseClassPerFile = 0 And .n_OptimizeByFilestamp = 2 And .t_InputFile_TimeStamp = .t_OutputFile_TimeStamp
*-- Optimizado: El Origen es igual al Destino - No hace falta regenerar
*.writeLog( '> El archivo de salida [<<THIS.c_OutputFile>>] no se regenera porque su timestamp es igual que el de entrada.' )
                            .writeLog( C_TAB + C_TAB + '* ' + Textmerge(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )

                        Case Inlist(lcExtension,"SCX",.c_SC2) AND .n_UseFormPerFile = 0 And .n_OptimizeByFilestamp = 1 And .t_InputFile_TimeStamp < .t_OutputFile_TimeStamp
*-- Optimizado: El Origen es anterior al Destino - No hace falta regenerar
*.writeLog( '> El archivo de salida [<<THIS.c_OutputFile>>] no se regenera porque su timestamp es más nuevo que el de entrada.' )
                            .writeLog( C_TAB + C_TAB + '* ' + Textmerge(loLang.C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC) )

                        Case Inlist(lcExtension,"SCX",.c_SC2) AND .n_UseFormPerFile = 0 And .n_OptimizeByFilestamp = 2 And .t_InputFile_TimeStamp = .t_OutputFile_TimeStamp
*-- Optimizado: El Origen es igual al Destino - No hace falta regenerar
*.writeLog( '> El archivo de salida [<<THIS.c_OutputFile>>] no se regenera porque su timestamp es igual que el de entrada.' )
                            .writeLog( C_TAB + C_TAB + '* ' + Textmerge(loLang.C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC) )

                        Otherwise
                            .c_Type                             = Upper(Justext(.c_OutputFile))
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

                            If Aevents( laEvents, loConversor ) = 0 Then
                                Bindevent( loConversor, 'updateProgressbar', This, 'updateProgressbar' )
                            Endif

                            loConversor.convert( @toModulo, .F., This )

                            If loConversor.l_Error Then
                                .l_Error = .T.
                            Endif

                            .n_ProcessedFilesCount  = .n_ProcessedFilesCount + 1
                            .writeLog()
                            .writeLog(loConversor.c_TextLog)    && Recojo el LOG que haya generado el conversor

*-- Logueo los errores
                            If Not Empty(loConversor.c_TextErr) Then
                                .writeErrorLog( Replicate( '-', 100 ), 1 )
                                .writeErrorLog( loLang.C_ERRORS_FOUND_IN_FILE_LOC + ' [' + .c_InputFile + '] ' )
                                .writeErrorLog( loConversor.c_TextErr )
                                .writeErrorLog( )
                            Endif
                    Endcase

                    .normalizeFileCapitalization()
                Endwith &&  THIS AS c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'

            Catch To toEx
                lnCodError  = toEx.ErrorNo
*lcErrorInfo    = THIS.exception2Str(toEx) + CR_LF + CR_LF + loLang.C_SOURCEFILE_LOC + THIS.c_InputFile

*-- updateProcessedFile( tcProcessed, tcHasErrors, tcSupported, tcReserved )
                This.updateProcessedFile( lnIDInputFile, '', '', 'E1' )

                If This.n_Debug > 0 Then
                    If _vfp.StartMode = 0
                        Set Step On
                    Endif
                Endif
                If tlRelanzarError  && Usado en Unit Testing
                    Throw
                Endif

            Finally
                If Aevents( laEvents, loConversor ) > 0 Then
                    Unbindevents( loConversor )
                Endif

                Store .Null. To loConversor, loFSO

                If lnCodError = 0 And This.l_Error Then
                    This.updateProcessedFile( lnIDInputFile, '', '', 'E1' )
                Else
*THIS.updateProcessedFile( lnIDInputFile )
                Endif

                Release lcErrorInfo, laDirFile, lcExtension, lnFileCount, laFiles, I ;
                    , ltFilestamp, lcExtA, lcExtB ;
                    , loConversor, loFSO
        Endtry

        Return lnCodError
    Endproc


    Procedure get_DirSettings
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:       (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcDir             (@? IN    ) Directorio del que devolver su configuración
* tcDebug           (v? IN    ) '1' write debug log (posiibly to GETENV("TEMP") )
* tcCFG_File        (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
*                                       Normal inheritance may or may not run, see setting InhibitInheritance
* RETORNO           (@?    OUT) Objeto CFG
*---------------------------------------------------------------------------------------------------
        Lparameters tcDir, tcDebug, tcCFG_File

        If Not Empty(tcDir)
            This.evaluateConfiguration( '', '', '', tcDebug, '', '', '', '', tcDir, 'D', , , tcCFG_File )
        Endif

        If This.n_CFG_Actual = 0 Then
            loCFG = .Null.
        Else
            loCFG = This.o_Configuration(This.n_CFG_Actual)
        Endif

        If Isnull(loCFG) Then
            loCFG   = Createobject('CL_CFG')
            loCFG.CopyFrom(This)
        Endif

        Return loCFG
    Endproc


    Procedure get_PROGRAM_HEADER
        Local lcText
        lcText  = ''

*-- Cabecera del PRG e inicio de DEF_CLASS
*!* LScheffler 22.08.2023
*issue #96, [KestasL] keep CodePage relavant information for binary sources, added CPID value
        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            *--------------------------------------------------------------------------------------------------------------------------------------------------------
            * (EN) AUTOGENERATED - ATTENTION!! - NOT INTENDED FOR EXECUTION!! USE ONLY FOR MERGING CHANGES AND STORING WITH SCM TOOLS!!
            *--------------------------------------------------------------------------------------------------------------------------------------------------------
            <<C_FB2PRG_META_I>> Version="<<TRANSFORM(THIS.n_FB2PRG_Version)>>" SourceFile="<<LOWER( JUSTFNAME( EVL( THIS.c_OriginalFileName, THIS.c_InputFile ) ) )>>" CPID="<<THIS.i_CPID>>" <<C_FB2PRG_META_F>> (Solo para binarios VFP 9 / Only for VFP 9 binaries)
            *
        ENDTEXT

        Return lcText
    Endproc


    Procedure getNext_BAK
*--------------------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_OutputFilename         (v! IN    ) Nombre del archivo de salida a crear el backup
*--------------------------------------------------------------------------------------------------------------
        Lparameters tcOutputFileName
        Local lcNext_Bak, I, laDirInfo(1,5)
        lcNext_Bak  = '.BAK'

        For I = 1 To This.n_ExtraBackupLevels
            If m.I = 1
                If Not Adir( laDirInfo, tcOutputFileName + '.BAK' ) > 0 Then
                    lcNext_Bak  = '.BAK'
                    Exit
                Endif
            Else
                If Not Adir( laDirInfo, tcOutputFileName + '.' + Padl(m.I-1,1,'0') + '.BAK' ) > 0 Then
                    lcNext_Bak  = '.' + Padl(m.I-1,1,'0') + '.BAK'
                    Exit
                Endif
            Endif
        Endfor

        Return lcNext_Bak
    Endproc


    Procedure get_SeparatedLineAndComment
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Línea a separar del comentario
* tcComment                 (@?    OUT) Comentario
* tlDeepCommentAnalysis     (v? IN    ) Indica realizar un análisis profundo de comentarios (para detectar casos complejos de código con '&&' embebido)
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine As String, tcComment As String, tlDeepCommentAnalysis As Boolean
        Local ln_AT_Cmt
        tcComment   = ''
        ln_AT_Cmt   = At( '&'+'&', tcLine)

        If ln_AT_Cmt > 0
            If tlDeepCommentAnalysis Then
                Local laSeparador(3,3), lcSeparadoresIzq, lcSeparadoresDer, lcStr, lnAT_Amp, lnAT1, lnAT2, lnLen, I, X

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
                lnLen               = Len(lcStr)

*-- Anular subcadenas para luego encontrar comentarios '&&' (y analizar solo si existe al menos un '&&')
                X       = 1
                lnAT1   = At(laSeparador(m.X,1), lcStr)

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
                If lnAT1 > 0 Then
                    For I = lnAT1+1 To lnLen
                        If m.X > 0 Then
                            lnAT2   = At(laSeparador(m.X,2), lcStr, laSeparador(m.X,3))

                            If lnAT2 > 0 Then
                                lcStr   = Stuff(lcStr, lnAT1, lnAT2-lnAT1+1, Replicate('X',lnAT2-lnAT1+1))
                            Else
                                ln_AT_Cmt   = At( '&'+'&', lcStr)

                                If ln_AT_Cmt = 0 Or ln_AT_Cmt < lnAT1
*-- No tiene comentario '&&' real, o sí lo tiene y además contiene un delimitador de cadena como parte del comentario
                                    Exit
                                Else
                                    Error 'Closing string delimiter <' + laSeparador(m.X,2) + '> not found: ' + tcLine
                                Endif
                            Endif
                        Endif

*-- Verifico si el carácter es un separador de cadenas: '"[
                        X   = At( Substr(lcStr, m.I, 1), lcSeparadoresIzq)

                        If m.X > 0 Then
                            lnAT1   = At(laSeparador(m.X,1), lcStr)
                        Endif
                    Endfor
                Endif

                ln_AT_Cmt   = At( '&'+'&', lcStr)
            Endif && tlDeepCommentAnalysis

            If ln_AT_Cmt > 0
                tcComment   = Ltrim( Substr( tcLine, ln_AT_Cmt + 2 ) )
                tcLine      = Rtrim( Left( tcLine, ln_AT_Cmt - 1 ), 0, Chr(9), ' ' )    && Quito TABS y espacios
            Endif

        Endif

        Return (ln_AT_Cmt > 0)
    Endproc


    Procedure normalizeFileCapitalization
        Lparameters tl_NormalizeInputFile, tcFileName

        Try
                Local lcPath, lcEXE_CAPS, lcOutputFile, llRelanzarError, lcType, laDirInfo(1,5) ;
                    , loEx As Exception ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
                    , loFSO As Scripting.FileSystemObject

                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    If Not .l_ProcessFiles
                        Exit
                    Endif

                    loLang          = _Screen.o_FoxBin2Prg_Lang
                    lcPath          = Justpath(.c_Foxbin2prg_FullPath)
                    lcEXE_CAPS      = Forcepath( 'filename_caps.exe', lcPath )
                    loFSO           = .o_FSO
                    llRelanzarError = Not tl_NormalizeInputFile

                    If tl_NormalizeInputFile
                        tcFileName  = Evl( tcFileName, .c_InputFile )
                        lcType      = Upper( Justext( tcFileName ) )
                    Else
                        tcFileName  = Evl( tcFileName, .c_OutputFile )
                        lcType      = .c_Type
                    Endif

                    Do Case
                        Case .n_ExisteCapitalizacion = -1
*-- La primera vez vale -1, hace la verificación por única vez y cachea la respuesta
                            If File(lcEXE_CAPS)
*.writeLog( '* Se ha encontrado el programa de capitalización de nombres [' + lcEXE_CAPS + ']' )
                                .writeLog( C_TAB + Textmerge(loLang.C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC) )
                                Set Procedure To (lcEXE_CAPS) Additive
                                .o_FNC  = Createobject( 'cl_FileName_Caps' )
                                Release Procedure (lcEXE_CAPS)

                                .n_ExisteCapitalizacion = 1
                            Else
*-- No existe el programa de capitalización, así que no se capitalizan los nombres.
*.writeLog( '* No se ha encontrado el programa de capitalización de nombres [' + lcEXE_CAPS + ']' )
                                .writeLog( C_TAB + Textmerge(loLang.C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC) )
                                .n_ExisteCapitalizacion = 0
                                Exit
                            Endif

                        Case .n_ExisteCapitalizacion = 0
*-- Segunda pasada en adelante: No hay programa de capitalización
                            Exit

                        Otherwise
*-- Segunda pasada en adelante: Hay programa de capitalización

                    Endcase

*-- Normalizar archivo(s) de entrada. El primero siempre se normaliza (??2, ??X, DBF, DBC)
                    .renameFile( tcFileName, lcEXE_CAPS, loFSO, llRelanzarError )

                    Do Case
                        Case lcType = 'PJX'
                            .renameFile( Forceext(tcFileName,'PJT'), lcEXE_CAPS, loFSO, llRelanzarError )

                        Case lcType = 'VCX'
                            .renameFile( Forceext(tcFileName,'VCT'), lcEXE_CAPS, loFSO, llRelanzarError )

                        Case lcType = 'SCX'
                            .renameFile( Forceext(tcFileName,'SCT'), lcEXE_CAPS, loFSO, llRelanzarError )

                        Case lcType = 'FRX'
                            .renameFile( Forceext(tcFileName,'FRT'), lcEXE_CAPS, loFSO, llRelanzarError )

                        Case lcType = 'LBX'
                            .renameFile( Forceext(tcFileName,'LBT'), lcEXE_CAPS, loFSO, llRelanzarError )

                        Case lcType = 'DBF'
                            If Adir( laDirInfo, Forceext(tcFileName,'FPT') ) > 0 Then
                                .renameFile( Forceext(tcFileName,'FPT'), lcEXE_CAPS, loFSO, llRelanzarError )
                            Endif
                            If Adir( laDirInfo, Forceext(tcFileName,'CDX') ) > 0 Then
                                .renameFile( Forceext(tcFileName,'CDX'), lcEXE_CAPS, loFSO, llRelanzarError )
                            Endif

                        Case lcType = 'DBC'
                            .renameFile( Forceext(tcFileName,'DCX'), lcEXE_CAPS, loFSO, llRelanzarError )
                            .renameFile( Forceext(tcFileName,'DCT'), lcEXE_CAPS, loFSO, llRelanzarError )

                        Case lcType = 'MNX'
                            .renameFile( Forceext(tcFileName,'MNT'), lcEXE_CAPS, loFSO, llRelanzarError )

                    Endcase

                Endwith && THIS

            Catch To loEx
                Throw

            Finally
                loFSO   = .Null.
                Release lcPath, lcEXE_CAPS, lcOutputFile, llRelanzarError, lcType, loFSO

        Endtry

        Return
    Endproc


    Procedure get_FilesFromDirectory
        Lparameters tcDir, taFiles, tnFileCount
        External Array taFiles

        Local laFiles(1), I, lnFiles ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

        If Type("ALEN(laFiles)") # "N" Or Empty(tnFileCount)
            tnFileCount = 0
            Dimension taFiles(1)
        Endif

        tcDir   = Addbs(tcDir)

        If Directory(tcDir)
            With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                loLang          = _Screen.o_FoxBin2Prg_Lang
                .updateProgressbar( loLang.C_SCANNING_FILE_AND_DIR_INFO_LOC + ' ' + tcDir + '...', 0, 0, 0 )
                lnFiles = Adir( laFiles, tcDir + '*.*', 'D', 1)

*-- Busco los archivos
                For I = 1 To lnFiles
                    If Substr( laFiles(m.I,5), 5, 1 ) == 'D'
                        Loop
                    Endif

                    tnFileCount = tnFileCount + 1
                    Dimension taFiles(tnFileCount)
                    taFiles(tnFileCount)    = tcDir + laFiles(m.I,1)
                Endfor

*-- Busco los subdirectorios
                For I = 1 To lnFiles
                    If Not Substr( laFiles(m.I,5), 5, 1 ) == 'D' Or Left(laFiles(m.I,1), 1) == '.'
                        Loop
                    Endif
                    .get_FilesFromDirectory( tcDir + laFiles(m.I,1), @taFiles, @tnFileCount )
                Endfor
            Endwith
        Endif
    Endproc


    Procedure loadModule
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
        Lparameters tc_InputFile, toModulo, toEx As Exception, tlRelanzarError, tcOriginalFileName

        Try
                Local lnCodError, lcErrorInfo, laDirFile(1,5), lcExtension, lnFileCount, laFiles(1,1), I ;
                    , ltFilestamp, lcExtA, lcExtB, laEvents(1,1), lnIDInputFile ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
                    , loConversor As c_conversor_base Of 'FOXBIN2PRG.PRG' ;
                    , loFSO As Scripting.FileSystemObject
                lnCodError          = 0

                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    Store .Null. To toModulo
                    lc_OldSetNotify = Set("Notify")
                    Set Notify Off
                    loFSO           = .o_FSO
                    loLang          = _Screen.o_FoxBin2Prg_Lang
                    .c_InputFile    = Fullpath( tc_InputFile )
                    .l_Error        = .F.
                    lcExtension     = Upper( Justext(.c_InputFile) )

                    .writeLog( Replicate( '*', 100 ) )
                    .writeLog( 'LOAD MODULE', 2 )
                    .writeLog( Replicate( '*', 100 ) )

                    If Adir( laDirFile, .c_InputFile, '', 1 ) = 0
*ERROR 'No se encontró el archivo [' + .c_InputFile + ']'
                        Error loLang.C_FILE_NOT_FOUND_LOC + ' [' + .c_InputFile + ']'
                    Endif

                    .c_InputFile    = loFSO.GetAbsolutePathName( Forcepath( laDirFile(1,1), Justpath(.c_InputFile) ) )

*-- VERIFICO SI HAY ARCHIVO DE CONFIGURACIÓN SECUNDARIO
                    .evaluateConfiguration()


                    If Not Empty(tcOriginalFileName)
                        tcOriginalFileName  = loFSO.GetAbsolutePathName( tcOriginalFileName )
                    Endif

                    .c_OriginalFileName = Evl( tcOriginalFileName, .c_InputFile )

                    If Upper( Justext(.c_OriginalFileName) ) = 'PJM' And .c_PJ2 <> 'PJM'
                        .c_OriginalFileName = Forceext(.c_OriginalFileName,'pjx')
                    Endif

                    lnIDInputFile   = .n_ProcessedFiles

                    .writeLog( C_TAB + 'c_OriginalFileName:           ' + .c_OriginalFileName )
                    .writeLog( )

                    If Not Adir(laDirFile, .c_InputFile) > 0 Then
                        Error loLang.C_FILE_DOESNT_EXIST_LOC + ' [' + .c_InputFile + ']'
                    Endif

                    Do Case
                        Case lcExtension = 'VCX'
                            loConversor     = Createobject( 'c_conversor_vcx_a_prg' )

                        Case lcExtension = 'SCX'
                            loConversor     = Createobject( 'c_conversor_scx_a_prg' )

                        Case lcExtension = 'PJX'
                            loConversor     = Createobject( 'c_conversor_pjx_a_prg' )

                        Case lcExtension = 'PJM' And .c_PJ2 <> 'PJM'
                            loConversor     = Createobject( 'c_conversor_pjm_a_prg' )

                        Case lcExtension = 'FRX'
                            loConversor     = Createobject( 'c_conversor_frx_a_prg' )

                        Case lcExtension = 'LBX'
                            loConversor     = Createobject( 'c_conversor_frx_a_prg' )

                        Case lcExtension = 'DBF'
                            loConversor     = Createobject( 'c_conversor_dbf_a_prg' )

                        Case lcExtension = 'DBC'
                            loConversor     = Createobject( 'c_conversor_dbc_a_prg' )

                        Case lcExtension = 'MNX'
                            loConversor     = Createobject( 'c_conversor_mnx_a_prg' )

                        Case lcExtension = .c_VC2
                            loConversor     = Createobject( 'c_conversor_prg_a_vcx' )

                        Case lcExtension = .c_SC2
                            loConversor     = Createobject( 'c_conversor_prg_a_scx' )

                        Case lcExtension = .c_PJ2
                            loConversor     = Createobject( 'c_conversor_prg_a_pjx' )

                        Case lcExtension = .c_FR2
                            loConversor     = Createobject( 'c_conversor_prg_a_frx' )

                        Case lcExtension = .c_LB2
                            loConversor     = Createobject( 'c_conversor_prg_a_frx' )

                        Case lcExtension = .c_DB2
                            loConversor     = Createobject( 'c_conversor_prg_a_dbf' )

                        Case lcExtension = .c_DC2
                            loConversor     = Createobject( 'c_conversor_prg_a_dbc' )

                        Case lcExtension = .c_MN2
                            loConversor     = Createobject( 'c_conversor_prg_a_mnx' )

                        Otherwise
*ERROR 'El archivo [' + .c_InputFile + '] no está soportado'
                            Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))

                    Endcase

                    .c_Type                             = Upper(Justext(.c_OutputFile))
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

                    loConversor.loadModule( @toModulo, .F., This )

                    If loConversor.l_Error Then
                        .l_Error = .T.
                    Endif

*.n_ProcessedFilesCount = .n_ProcessedFilesCount + 1
                    .writeLog()
                    .writeLog(loConversor.c_TextLog)    && Recojo el LOG que haya generado el conversor

*-- Logueo los errores
                    If Not Empty(loConversor.c_TextErr) Then
                        .writeErrorLog( Replicate( '-', 100 ), 1 )
                        .writeErrorLog( loLang.C_ERRORS_FOUND_IN_FILE_LOC + ' [' + .c_InputFile + '] ' )
                        .writeErrorLog( loConversor.c_TextErr )
                        .writeErrorLog( )
                    Endif

                Endwith &&  THIS AS c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'

            Catch To toEx
                lnCodError  = toEx.ErrorNo
*lcErrorInfo    = THIS.exception2Str(toEx) + CR_LF + CR_LF + loLang.C_SOURCEFILE_LOC + THIS.c_InputFile

*-- updateProcessedFile( tcProcessed, tcHasErrors, tcSupported, tcReserved )
*THIS.updateProcessedFile( lnIDInputFile, '', '', 'E1' )

                If This.n_Debug > 0 Then
                    If _vfp.StartMode = 0
                        Set Step On
                    Endif
                Endif
                If tlRelanzarError  && Usado en Unit Testing
                    Throw
                Endif

            Finally
                Set Notify &lc_OldSetNotify.

*IF AEVENTS( laEvents, loConversor ) > 0 THEN
*   UNBINDEVENTS( loConversor )
*ENDIF

                Store .Null. To loConversor, loFSO

*IF lnCodError = 0 AND THIS.l_Error THEN
*   THIS.updateProcessedFile( lnIDInputFile, '', '', 'E1' )
*ELSE
*   *THIS.updateProcessedFile( lnIDInputFile )
*ENDIF

                Release lcErrorInfo, laDirFile, lcExtension, lnFileCount, laFiles, I ;
                    , ltFilestamp, lcExtA, lcExtB ;
                    , loConversor, loFSO
        Endtry

        Return lnCodError
    Endproc


    Procedure readInputVFPParams
        Lparameters taParams, tnPCount
        External Array taParams
*-----------------------------------------------------------------------------
* Obtengo la linea completa de comandos
* Adaptado de http://www.news2news.com/vfp/?example=51&function=78
* Facilitado por Mario Lopez en el foro FoxPro de Google Español - 23/12/2013
* https://groups.google.com/d/msg/publicesvfoxpro/llS-kTNrG9M/LA4D3fd152IJ
*-----------------------------------------------------------------------------
        Declare Integer GetCommandLine In kernel32
        Declare Integer GlobalSize In kernel32 Integer Hmem
        Declare RtlMoveMemory In kernel32 As CopyMemory String @Destination, Integer Source, Integer nLength

        Local lnAddress, lnBufsize, lsBuffer
        lnAddress = GetCommandLine()  && returns an address in memory
        lnBufsize = GlobalSize(lnAddress)

* allocating and filling a buffer
        If lnBufsize <> 0
            lsBuffer = Replicate(Chr(0), lnBufsize)
            = CopyMemory(@lsBuffer, lnAddress, lnBufsize)
        Endif

        lsBuffer    = Strtran(lsBuffer, '"'+Chr(0), '"'+Chr(13)+Chr(10))
        lsBuffer    = Strtran(lsBuffer, '" ', '"'+Chr(13)+Chr(10), 1, 1)
        lsBuffer    = Strtran(lsBuffer, Chr(0), ' ')
        tnPCount    = Alines( taParams, lsBuffer, 4 )

        If tnPCount > 1 Then
            Adel( taParams, 1 )
            tnPCount = tnPCount - 1
            Dimension taParams(tnPCount)
        Endif

        Return
    Endproc



    Procedure renameFile
        Lparameters tcFileName, tcEXE_CAPS, toFSO As Scripting.FileSystemObject, tlRelanzarError

        Local lcLog, laFile(1,5) ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
        loLang          = _Screen.o_FoxBin2Prg_Lang

        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            lcLog   = ''
            .o_FNC.Capitalize( tcFileName, '', 'F', @lcLog, tlRelanzarError, '1' )

            If .n_Debug >= 2 Then
                lcLog   = Substr(lcLog,3)
                .writeLog()
                .writeLog( C_TAB + Textmerge(loLang.C_REQUESTING_CAPITALIZATION_OF_FILE_LOC) )
                .writeLog( lcLog )
            Endif
        Endwith
    Endproc



    Procedure renameTmpFile2Tx2File
        Lparameters tcFileName

        Local lcTmpFile, loFSO As Scripting.FileSystemObject, loEx As Exception

        Try
*loFSO      = THIS.o_FSO
                lcTmpFile   = tcFileName + '.TMP'
                This.changeFileAttribute( tcFileName, '+N' )
                Erase (tcFileName)
                Rename (lcTmpFile) To (tcFileName)

            Catch To loEx
                Throw

            Finally
*loFSO  = .Null.
        Endtry

        Return
    Endproc



    Procedure set_Line
        Lparameters tcLine, taCodeLines, I
        EXTERNAL ARRAY taCodeLines
        
        tcLine  = Ltrim( taCodeLines(m.I), 0, Chr(9), ' ' )
    Endproc


    Procedure errOut
*-- DEVOLUCIÓN DE SALIDA A ERROUT (-12)
        Lparameters tcTexto

        Try
                If This.l_StdOutHabilitado
                    Local loException As Exception, lcOutput, lnOutHandle, lnBytesWritten, lnOverlappedIO
                    lcOutput        = Evl(tcTexto,'') + CR_LF
                    lnOutHandle     = fb2p_GetStdHandle(-12)    && CAPTURAR ERROR DESDE CONSOLA: FOXBIN2PRG.EXE PARAMS 2>&1 | FIND /V ""
                    lnBytesWritten  = 0
                    lnOverlappedIO  = 0
                    fb2p_WriteFile(lnOutHandle, @lcOutput, Len(lcOutput), @lnBytesWritten, @lnOverlappedIO)
                Endif

            Catch To loException
                This.l_StdOutHabilitado = .F.

        Endtry

        Return
    Endproc


    Procedure stdOut
*-- DEVOLUCIÓN DE SALIDA A STDOUT (-11)
        Lparameters tcTexto

        Try
                If This.l_StdOutHabilitado
                    Local loException As Exception, lcOutput, lnOutHandle, lnBytesWritten, lnOverlappedIO
                    lcOutput        = Evl(tcTexto,'') + CR_LF
                    lnOutHandle     = fb2p_GetStdHandle(-11)    && CAPTURAR STDOUT DESDE CONSOLA: FOXBIN2PRG.EXE PARAMS | FIND /V ""
                    lnBytesWritten  = 0
                    lnOverlappedIO  = 0
                    fb2p_WriteFile(lnOutHandle, @lcOutput, Len(lcOutput), @lnBytesWritten, @lnOverlappedIO)
                Endif

            Catch To loException
                This.l_StdOutHabilitado = .F.

        Endtry

        Return
    Endproc


    Procedure updateProcessedFile
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
        Lparameters tnID, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded

        Try
                Local loEx As Exception

                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
                    If .n_ProcessedFiles = 0 Then
                        Exit
                    Endif
                    tnID    = Evl(tnID, .n_ProcessedFiles)
                    If Not Empty(tcInOutType)
                        .a_ProcessedFiles(tnID, 2)  = Evl(tcProcessed, '')
                    Endif
                    If Not Empty(tcProcessed)
                        .a_ProcessedFiles(tnID, 3)  = Evl(tcProcessed, '')
                    Endif
                    If Not Empty(tcHasErrors)
                        .a_ProcessedFiles(tnID, 4)  = Evl(tcHasErrors, '')
                    Endif
                    If Not Empty(tcSupported)
                        .a_ProcessedFiles(tnID, 5)  = Evl(tcSupported, '')
                    Endif
                    .stdOut( .a_ProcessedFiles(tnID,2) ;
                        + ',' + .a_ProcessedFiles(tnID,3) ;
                        + ',' + .a_ProcessedFiles(tnID,4) ;
                        + ',' + .a_ProcessedFiles(tnID,5) ;
                        + ',' + .a_ProcessedFiles(tnID,6) ;
                        + ',' + Lower(.a_ProcessedFiles(tnID,1)) )
                Endwith

            Catch To loEx
                If This.n_Debug > 0 Then
                    If _vfp.StartMode = 0
                        Set Step On
                    Endif
                Endif
                Throw

        Endtry
    Endproc


    Procedure writeErrorLog
        Lparameters tcText, tnTimeStamp

        Try
                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
*-- Según el valor de nTimestamp:
*-- 0 = Sin timestamp
*-- 1 = Timestamp por delante
*-- 2 = Timestamp por detrás
                    .c_TextErr  = .c_TextErr ;
                        + Iif( Evl(tnTimeStamp,0) = 1, Ttoc(Datetime(),3) + '  ', '' ) ;
                        + Evl(tcText,'') ;
                        + Iif( Evl(tnTimeStamp,0) = 2, '  ' + Ttoc(Datetime(),3), '' ) ;
                        + CR_LF

                    .errOut(tcText)
                    .l_Error    = .T.
                    .l_Errors   = .T.
                Endwith
            Catch
        Endtry
    Endproc


    Procedure writeErrorLog_Flush
        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            If Not Empty(.c_TextErr)
                Strtofile( .c_TextErr + CR_LF, .c_ErrorLogFile, 1 )
            Endif
            .c_TextErr  = ''
        Endwith
    Endproc



    Procedure writeLog
        Lparameters tcText, tnTimeStamp

        Try
                With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
*-- Según el valor de nTimestamp:
*-- 0 = Sin timestamp
*-- 1 = Timestamp por delante
*-- 2 = Timestamp por detrás
                    .c_TextLog  = .c_TextLog ;
                        + Iif( Evl(tnTimeStamp,0) = 1, Ttoc(Datetime(),3) + '  ', '' ) ;
                        + Evl(tcText,'') ;
                        + Iif( Evl(tnTimeStamp,0) = 2, '  ' + Ttoc(Datetime(),3), '' ) ;
                        + CR_LF
                Endwith
            Catch
        Endtry
    Endproc


    Procedure writeLog_Flush
        With This As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
            If .n_Debug > 0 And Not Empty(.c_TextLog)
                Strtofile( .c_TextLog + CR_LF, .c_LogFile, 1 )
            Endif
            .c_TextLog  = ''
        Endwith
    Endproc



    Hidden Procedure exception2Str
        Lparameters toEx As Exception
        Local lcError
        lcError     = 'Error ' + Transform(toEx.ErrorNo) + ', ' + toEx.Message + CR_LF ;
            + toEx.Procedure + ', ' + Transform(toEx.Lineno) + CR_LF

        If Not Empty(toEx.LineContents) And toEx.ErrorNo <> 1098
            lcError = lcError + toEx.LineContents + CR_LF
        Endif

        If Not Empty(toEx.UserValue)
            lcError = lcError + Evl(toEx.UserValue,'')
        Endif

        Return lcError
    Endproc


    Procedure unique_ID
        Lparameters tcValType

        tcValType   = Evl(tcValType,'C')
        This.n_ID   = Int( This.n_ID + 1 )

        If tcValType = 'N'
            Return This.n_ID
        Else
            Return '_' + Transform( This.n_ID, '@L #########' )
        Endif
    Endproc


    Function wscriptshell_run
* Modificación basada en la rutina RunExitCode.prg de William GC Steinford (nov 2002)
* pero compatible con el método Run de WScript.Shell para su reemplazo cuando no es posible usarlo.
* http://fox.wikis.com/wc.dll?Wiki~ProcessExitCode
*-----------------------------------------------------------------------------------------------
* 'Run' Parameter Documentation at: https://msdn.microsoft.com/en-us/library/d5fk67ky%28v=vs.84%29.aspx
*-----------------------------------------------------------------------------------------------
        Lparameters tcCmdLine, tnWindowStyle, tbWaitOnReturn, tlDebug
* ? WScriptShell_Run("c:\windows\system32\cmd.exe /c dir c:\*.* > \temp\dir.txt")

        Local lnWfSO, ln_dwFlags, ln_wShowWindow, lcStartInfo, lcProcessInfo, ln_hProcess, ln_hThread ;
            , lnExitCode, ln_dwProcessId, ln_dwThreadId, tcProgFile, laDirFile(1,5)

        Try
                Declare SHORT CreateProcess In WIN32API ;
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

                Declare Long WaitForSingleObject In WIN32API Integer hHandle, Long dwMilliseconds
                Declare Integer GetExitCodeProcess In WIN32API Integer ln_hProcess, Integer @ lnExitCode
                Declare Integer CloseHandle In kernel32.Dll Integer hObject
*DECLARE INTEGER ShellExecuteEx IN Shell32 STRING @lpExecInfo
                Declare Long ShellExecuteEx In shell32.Dll String @
                Declare Long HeapAlloc In WIN32API Long, Long, Long
                Declare Long HeapFree In WIN32API Long, Long, Long
                Declare Long GetProcessHeap In WIN32API
*DECLARE LONG WaitForSingleObject IN WIN32API LONG, LONG
                Declare Long TerminateProcess In WIN32API Long, Long

* NOTA: Las constantes para VFP se pueden consultar en http://www.news2news.com/vfp/w32constants.php

                #Define SEE_MASK_NOCLOSEPROCESS  0x00000040
                #Define WAIT_MILLISECOND 3000

                #Define SW_SHOW         5
                #Define STILL_ACTIVE    0x103
                #Define cnINFINITE      0xFFFFFFFF
                #Define cnHalfASecond   500 && milliseconds
                #Define cnTimedOut      0x0102

*-- Constantes para WaitForSingleObject
                #Define WAIT_ABANDONED  0x00000080
                #Define WAIT_OBJECT_0   0x00000000
                #Define WAIT_TIMEOUT    0x00000102
                #Define WAIT_FAILED     0xFFFFFFFF

                tcProgFile      = Evl(tcProgFile, .Null.)
                tcCmdLine       = Evl(tcCmdLine, .Null.)

                Do Case
                    Case Vartype(tbWaitOnReturn) = "L"
                    Case Vartype(tbWaitOnReturn) = "N"
                        tbWaitOnReturn  = (tbWaitOnReturn=1)
                    Otherwise
                        Error 'Invalid value for tbWaitOnReturn parameter'
                Endcase

                If Vartype(tnWindowStyle) # "N" Or Not Between(tnWindowStyle, 0, 10) Then
                    tnWindowStyle   = 10
                Endif

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
                lcStartInfo = BinToC(68,'4RS') ;
                    + BinToC(0,'4RS') + BinToC(0,'4RS') + BinToC(0,'4RS') ;
                    + BinToC(0,'4RS') + BinToC(0,'4RS') + BinToC(0,'4RS') + BinToC(0,'4RS') ;
                    + BinToC(0,'4RS') + BinToC(0,'4RS') + BinToC(0,'4RS') ;
                    + BinToC(ln_dwFlags,'4RS') ;
                    + BinToC(ln_wShowWindow,'2RS') ;
                    + BinToC(0,'2RS') + BinToC(0,'4RS') ;
                    + BinToC(0,'4RS') + BinToC(0,'4RS') + BinToC(0,'4RS')

                lcProcessInfo = Replicate( Chr(0), 16 )

* DOCUMENTACIÓN estructura _PROCESS_INFORMATION:
* https://msdn.microsoft.com/en-us/library/windows/desktop/ms684873%28v=vs.85%29.aspx
*    typedef struct _PROCESS_INFORMATION {
*        HANDLE hProcess;
*        HANDLE hThread;
*        DWORD dwProcessId;
*        DWORD dwThreadId;
*    } PROCESS_INFORMATION;
*

                If CreateProcess( tcProgFile, tcCmdLine,0,0,0,0,0,0, lcStartInfo, @lcProcessInfo ) = 0

*-- Segundo intento: Si se definió un archivo (ej: un TXT,LOG,etc) intento lanzarlo
*-- con la aplicación predeterminada
                    If Adir(laDirFile, tcCmdLine) = 1 Then
                        Local lcInfo, lnHeap, lnLen, lnPtr

*-- Ejemplo adaptado de: http://www.foxite.com/archives/0000316611.htm
                        lnLen   = Len(tcCmdLine) + 1
                        lnHeap  = GetProcessHeap()
                        lnPtr   = HeapAlloc(lnHeap, 0x8, 5 + lnLen)
                        Sys(2600, lnPtr, 5, [open] + Chr(0))
                        Sys(2600, lnPtr+5, lnLen, tcCmdLine + Chr(0))

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
                            REPLICATE(Chr(0), 28)

                        If ShellExecuteEx(@lcInfo) = 0
                            If tlDebug
                                ? "Could not call process"
                            Endif
                            lnExitCode  = -1
                            Exit
                        Else
                            HeapFree(lnHeap, 0, lnPtr)
                            ln_hProcess = CToBin(Right(lcInfo, 4), [4RS])
                            ln_hThread  = 0

                            If tlDebug
                                ? "Process handle    = "+Transform(ln_hProcess)
                                ? "Thread handle     = "+Transform(ln_hThread)
                            Endif

*IF lnProcess != 0
*   WaitForSingleObject(ln_hProcess, WAIT_MILLISECOND)
*   IF tlDebug
*       ? "Terminating process!"
*   ENDIF
*   TerminateProcess(ln_hProcess, 0)
*ENDIF
                        Endif

                    Else
                        If tlDebug
                            ? "Could not create process"
                        Endif
                        lnExitCode  = -1
                        Exit
                    Endif
                Else

* Process and thread handles returned in ProcInfo structure
                    ln_hProcess     = CToBin( Left( lcProcessInfo, 4 ), '4RS' )
                    ln_hThread      = CToBin( Substr( lcProcessInfo, 5, 4 ), '4RS' )
                    ln_dwProcessId  = CToBin( Substr( lcProcessInfo, 9, 4 ), '4RS' )
                    ln_dwThreadId   = CToBin( Substr( lcProcessInfo, 13, 4 ), '4RS' )

                    If tlDebug
                        ? "Process handle    = "+Transform(ln_hProcess)
                        ? "Thread handle     = "+Transform(ln_hThread)
                        ? "Process handle id = "+Transform(ln_dwProcessId)
                        ? "Thread handle id  = "+Transform(ln_dwThreadId)
                    Endif
                Endif

                If tbWaitOnReturn Then
* // Give the process time to execute and finish
                    lnExitCode = STILL_ACTIVE

                    Do While lnExitCode = STILL_ACTIVE
*lnWfSO = WaitForSingleObject(ln_hProcess, cnHalfASecond)
                        lnWfSO  = WaitForSingleObject(ln_hProcess, cnINFINITE)

                        If tlDebug
                            ? 'lnWfSO = ' + Transform(lnWfSO)
                        Endif

                        If GetExitCodeProcess(ln_hProcess, @lnExitCode) <> 0
                            Do Case
                                Case lnExitCode = STILL_ACTIVE
                                    If tlDebug
                                        ? "Process is still active"
                                    Endif
                                Otherwise
                                    If tlDebug
                                        ? "Exit code = "+ Transform( lnExitCode )
                                    Endif
                            Endcase
                        Else
                            If tlDebug
                                ? "GetExitCodeProcess() failed"
                            Endif
                            lnExitCode  = -2
                        Endif

                        DoEvents
                    Enddo
                Else
                    lnExitCode  = 0
                Endif

*-- DOCUMENTACIÓN sobre cierre procesos/threads:
*-- https://msdn.microsoft.com/en-us/library/windows/desktop/ms682512%28v=vs.85%29.aspx
                =CloseHandle(ln_hProcess)
                =CloseHandle(ln_hThread)

                If tlDebug
                    ? '> FUNCTION RETURN VALUE = '
                Endif
        Endtry

        Return lnExitCode
    Endfunc


    Function FERROR_Message(tcFileName As String)
        Local lcMsg, lnError
        tcFileName  = Evl(tcFileName,'')
        lnError     = Ferror()

        Do Case
            Case lnError = 2
                lcMsg   = 'File not found'
            Case lnError = 4
                lcMsg   = 'Too many files open (out of file handles)'
            Case lnError = 5
                lcMsg   = 'Access denied'
            Case lnError = 6
                lcMsg   = 'Invalid file handle given'
            Case lnError = 8
                lcMsg   = 'Out of memory'
            Case lnError = 25
                lcMsg   = [Seek error (can't seek before the start of a file)]
            Case lnError = 29
                lcMsg   = 'Disk full'
            Case lnError = 31
                lcMsg   = 'Error opening file'
            Otherwise
                lcMsg   = 'Unrecognized error trying to open the file ' + tcFileName
        Endcase

        Return lcMsg
    Endfunc


    Function getLocaleInfo
        Lparameters tnSetting, tcLocale
        #Define C_NULL Chr(0)
        Local lcLocale, lnLen, lcBuffer, lnReturn, lcReturn

        If Vartype(tcLocale) = 'C' And Not Empty(tcLocale)
            lcLocale = Strconv(tcLocale, 5) + C_NULL
        Else
            lcLocale = .Null.
        Endif

        Declare Integer GetLocaleInfoEx In Win32API ;
            string locale, Long Type, String @Buffer, Integer Len
        lnLen    = 255
        lcBuffer = Space(lnLen)
        lnReturn = GetLocaleInfoEx(lcLocale, tnSetting, @lcBuffer, lnLen)
        lcReturn = Strconv(Left(lcBuffer, 2 * (lnReturn - 1)), 6)
        Return lcReturn
    Endfunc

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*
*                       Properties Access Methods
*
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
    Procedure n_Debug_ACCESS
        IF ISNULL(This.n_DebugP) THEN
            If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
                Return This.n_Debug
            Else
                Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_Debug, This.n_Debug )
            Endif
        ELSE
            Return This.n_DebugP
        ENDIF
    Endproc


    Procedure n_BodyDevInfo_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_BodyDevInfo
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_BodyDevInfo, This.n_BodyDevInfo )
        Endif
    Endproc


    Procedure l_ShowErrors_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_ShowErrors
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_ShowErrors, This.l_ShowErrors )
        Endif
    Endproc


    Procedure n_ShowProgressbar_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_ShowProgressbar
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_ShowProgressbar, This.n_ShowProgressbar )
        Endif
    Endproc


    Procedure l_NoTimestamps_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_NoTimestamps
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_NoTimestamps, This.l_NoTimestamps )
        Endif
    Endproc


    * additional options controlling
    * files in non subpath of the PJX
    Procedure n_CheckFileInPath_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_CheckFileInPath
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_CheckFileInPath, This.n_CheckFileInPath )
        Endif
    Endproc

    * additional options controlling
    * - splitt of DBC separated from VCX/SCX
    * - new operations of DBF
    Procedure l_OldFilesPerDBC_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_OldFilesPerDBC
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_OldFilesPerDBC, This.l_OldFilesPerDBC )
        Endif
    Endproc


    Procedure n_UseFilesPerDBC_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_UseFilesPerDBC
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_UseFilesPerDBC, This.n_UseFilesPerDBC )
        Endif
    Endproc


    Procedure l_RedirectFilePerDBCToMain_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_RedirectFilePerDBCToMain
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_RedirectFilePerDBCToMain, This.l_RedirectFilePerDBCToMain )
        Endif
    Endproc


    Procedure l_ItemPerDBCCheck_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_ItemPerDBCCheck
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_ItemPerDBCCheck, This.l_ItemPerDBCCheck )
        Endif
    Endproc


    Procedure l_DBF_BinChar_Base64_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_DBF_BinChar_Base64
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_DBF_BinChar_Base64, This.l_DBF_BinChar_Base64 )
        Endif
    Endproc


    Procedure l_DBF_IncludeDeleted_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_DBF_IncludeDeleted
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_DBF_IncludeDeleted, This.l_DBF_IncludeDeleted )
        Endif
    Endproc


    Procedure c_Language_In_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_Language_In
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_Language_In, This.c_Language_In )
        Endif
    Endproc


    Procedure n_UseClassPerFile_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_UseClassPerFile
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_UseClassPerFile, This.n_UseClassPerFile )
        Endif
    Endproc


    Procedure l_RedirectClassPerFileToMain_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_RedirectClassPerFileToMain
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_RedirectClassPerFileToMain, This.l_RedirectClassPerFileToMain )
        Endif
    Endproc


    Procedure n_RedirectClassType_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_RedirectClassType
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_RedirectClassType, This.n_RedirectClassType )
        Endif
    Endproc


    Procedure l_ClassPerFileCheck_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_ClassPerFileCheck
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_ClassPerFileCheck, This.l_ClassPerFileCheck )
        Endif
    Endproc


    Procedure l_UseFormSettings_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_UseFormSettings
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_UseFormSettings, This.l_UseFormSettings )
        Endif
    Endproc


    Procedure n_UseFormPerFile_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_UseFormPerFile
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_UseFormPerFile, This.n_UseFormPerFile )
        Endif
    Endproc


    Procedure l_RedirectFormPerFileToMain_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_RedirectFormPerFileToMain
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_RedirectFormPerFileToMain, This.l_RedirectFormPerFileToMain )
        Endif
    Endproc


    Procedure n_RedirectFormType_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_RedirectFormType
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_RedirectFormType, This.n_RedirectFormType )
        Endif
    Endproc


    Procedure l_FormPerFileCheck_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_FormPerFileCheck
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_FormPerFileCheck, This.l_FormPerFileCheck )
        Endif
    Endproc



    Procedure l_RemoveNullCharsFromCode_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_RemoveNullCharsFromCode
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_RemoveNullCharsFromCode, This.l_RemoveNullCharsFromCode )
        Endif
    Endproc


    Procedure l_RemoveZOrderSetFromProps_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_RemoveZOrderSetFromProps
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_RemoveZOrderSetFromProps, This.l_RemoveZOrderSetFromProps )
        Endif
    Endproc

    Procedure n_InhibitInheritance_ACCESS
        * only from base config (and only if this is from parameter)
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( 1 ) )
            Return This.n_InhibitInheritance
        Else
            Return Nvl( This.o_Configuration( 1 ).n_InhibitInheritance, This.n_InhibitInheritance )
        Endif
    Endproc

    Procedure l_ClearUniqueID_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_ClearUniqueID
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_ClearUniqueID, This.l_ClearUniqueID )
        Endif
    Endproc


    Procedure l_ClearDBFLastUpdate_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_ClearDBFLastUpdate
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_ClearDBFLastUpdate, This.l_ClearDBFLastUpdate )
        Endif
    Endproc


    Procedure n_OptimizeByFilestamp_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_OptimizeByFilestamp
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_OptimizeByFilestamp, This.n_OptimizeByFilestamp )
        Endif
    Endproc


    Procedure n_ExtraBackupLevels_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_ExtraBackupLevels
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_ExtraBackupLevels, This.n_ExtraBackupLevels )
        Endif
    Endproc


    Procedure c_VC2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_VC2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_VC2, This.c_VC2 )
        Endif
    Endproc


    Procedure c_SC2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_SC2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_SC2, This.c_SC2 )
        Endif
    Endproc


    Procedure c_PJ2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_PJ2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_PJ2, This.c_PJ2 )
        Endif
    Endproc


    Procedure c_FR2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_FR2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_FR2, This.c_FR2 )
        Endif
    Endproc


    Procedure c_LB2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_LB2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_LB2, This.c_LB2 )
        Endif
    Endproc


    Procedure c_DB2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_DB2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_DB2, This.c_DB2 )
        Endif
    Endproc


    Procedure c_DC2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_DC2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_DC2, This.c_DC2 )
        Endif
    Endproc


    Procedure c_MN2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_MN2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_MN2, This.c_MN2 )
        Endif
    Endproc


    Procedure c_FK2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_FK2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_FK2, This.c_FK2 )
        Endif
    Endproc


    Procedure c_ME2_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_ME2
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_ME2, This.c_ME2 )
        Endif
    Endproc


    Procedure n_PJX_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_PJX_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_PJX_Conversion_Support, This.n_PJX_Conversion_Support )
        Endif
    Endproc


    Procedure n_VCX_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_VCX_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_VCX_Conversion_Support, This.n_VCX_Conversion_Support )
        Endif
    Endproc


    Procedure n_SCX_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_SCX_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_SCX_Conversion_Support, This.n_SCX_Conversion_Support )
        Endif
    Endproc


    Procedure n_FRX_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_FRX_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_FRX_Conversion_Support, This.n_FRX_Conversion_Support )
        Endif
    Endproc


    Procedure n_LBX_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_LBX_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_LBX_Conversion_Support, This.n_LBX_Conversion_Support )
        Endif
    Endproc


    Procedure n_DBC_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_DBC_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_DBC_Conversion_Support, This.n_DBC_Conversion_Support )
        Endif
    Endproc


    Procedure n_DBF_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_DBF_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_DBF_Conversion_Support, This.n_DBF_Conversion_Support )
        Endif
    Endproc


    Procedure n_MNX_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_MNX_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_MNX_Conversion_Support, This.n_MNX_Conversion_Support )
        Endif
    Endproc


    Procedure n_FKY_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_FKY_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_FKY_Conversion_Support, This.n_FKY_Conversion_Support )
        Endif
    Endproc


    Procedure n_MEM_Conversion_Support_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_MEM_Conversion_Support
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_MEM_Conversion_Support, This.n_MEM_Conversion_Support )
        Endif
    Endproc


    Procedure c_DBF_Conversion_Included_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_DBF_Conversion_Included
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_DBF_Conversion_Included, This.c_DBF_Conversion_Included )
        Endif
    Endproc


    Procedure c_DBF_Conversion_Excluded_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_DBF_Conversion_Excluded
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_DBF_Conversion_Excluded, This.c_DBF_Conversion_Excluded )
        Endif
    Endproc


    Procedure c_BackgroundImage_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.c_BackgroundImage
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).c_BackgroundImage, This.c_BackgroundImage )
        Endif
    Endproc


    Procedure n_ExcludeDBFAutoincNextval_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_ExcludeDBFAutoincNextval
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_ExcludeDBFAutoincNextval, This.n_ExcludeDBFAutoincNextval )
        Endif
    Endproc


    Procedure n_PRG_Compat_Level_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_PRG_Compat_Level
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_PRG_Compat_Level, This.n_PRG_Compat_Level )
        Endif
    Endproc


    Procedure n_HomeDir_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.n_HomeDir
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).n_HomeDir, This.n_HomeDir )
        Endif
    Endproc

    Procedure l_AllowFolder_ACCESS
        If This.n_CFG_Actual = 0 Or Isnull( This.o_Configuration( This.n_CFG_Actual ) )
            Return This.l_AllowFolder
        Else
            Return Nvl( This.o_Configuration( This.n_CFG_Actual ).l_AllowFolder, This.l_AllowFolder )
        Endif
    Endproc


Enddefine
