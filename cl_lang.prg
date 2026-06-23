#INCLUDE foxbin2prg.h

Define Class CL_LANG As Custom
   _MemberData = [<VFPData>] ;
      + [<memberdata name="n_languageselectedmethod" display="n_LanguageSelectedMethod"/>] ;
      + [</VFPData>]

   #If .F.
      Local This As CL_LANG Of 'cl_lang.prg'
   #Endif

   n_LanguageSelectedMethod    = 0 && 0=Automatic by version(3)

   C_ALLOWED_VALUES_ARE_LOC                                        = ""
   C_ASTERISK_EXT_NOT_ALLOWED_LOC                                  = ""
   C_BACKLINK_CANT_UPDATE_BL_LOC                                   = ""
   C_BACKLINK_OF_TABLE_LOC                                         = ""
   C_BACKUP_OF_LOC                                                 = ""
   C_CACHING_CONFIG_FOR_DIRECTORY_LOC                              = ""
   C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                 = ""
   C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC          = ""
   C_CONFIGFILE_LOC                                                = ""
   C_CONVERSION_CANCELLED_BY_USER_LOC                              = ""
   C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                            = ""
   C_CONVERT_FOLDER_LOC                                            = ""
   C_BINARY_TO_TEXT_LOC                                            = ""
   C_TEXT_TO_BINARY_LOC                                            = ""
   C_CONVERT_FOLDER_NONE_LOC                                       = ""
   C_CONVERT_FOLDER_QUESTION_LOC                                   = ""
   C_CONVERTER_UNLOAD_LOC                                          = ""
   C_CONVERTING_FILE_LOC                                           = ""
   C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC             = ""
   C_DUPLICATED_FILE_LOC                                           = ""
   C_DUPLICATED_OBJECT_LOC                                         = ""
   C_ENDDEFINE_MARKER_NOT_FOUND_LOC                                = ""
   C_END_MARKER_NOT_FOUND_LOC                                      = ""
   C_END_OF_PROCESS_LOC                                            = ""
   C_ERROR_LOC                                                     = ""
   C_ERRORS_FOUND_IN_FILE_LOC                                      = ""
   C_EXTENSION_RECONFIGURATION_LOC                                 = ""
   C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC         = ""
   C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                         = ""
   C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                        = ""
   C_EXTERNAL_PARAMETERS_LOC                                       = ""
   C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                         = ""
   C_FILE_DOESNT_EXIST_LOC                                         = ""
   C_FILE_NAME_IS_NOT_SUPPORTED_LOC                                = ""
   C_FILE_NOT_FOUND_LOC                                            = ""
   C_FILENAME_LOC                                                  = ""
   C_FOXBIN2PRG_ERROR_CAPTION_LOC                                  = ""
   C_FOXBIN2PRG_SYNTAX_INFO_LOC                                    = ""
   C_ClassTwice_Header_LOC                                         = ""
   C_ClassTwice_Lib_LOC                                            = ""
   C_ClassTwice_Class_LOC                                          = ""
   C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC                            = ""
   C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4                    = ""
   C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg                        = ""
   C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg                    = ""
   C_FOXBIN2PRG_JUST_VFP_9_LOC                                     = ""
   C_FOXBIN2PRG_WARN_CAPTION_LOC                                   = ""
   C_GENERATED_FILE_SIZE_LOC                                       = ""
   C_GENERATING_BINARY_LOC                                         = ""
   C_INCLUDING_CLASS_LOC                                           = ""
   C_INCLUDING_MEMBER_LOC                                          = ""
   C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                       = ""
   C_INHERITING_FROM_LOC                                           = ""
   C_INTERACTIVE_DIRECTORY_SELECTION_LOC                           = ""
   C_INVALID_PARAMETER_LOC                                         = ""
   C_IS_A_FILE_LOC                                                 = ""
   C_IS_A_DIRECTORY_LOC                                            = ""
   C_IS_UNSUPPORTED_LOC                                            = ""
   C_LANGUAGE_LOC                                                  = ""
   C_MAIN_EXECUTION_LOC                                            = ""
   C_MENU_NOT_IN_VFP9_FORMAT_LOC                                   = ""
   C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                        = ""
   C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                    = ""
   C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                           = ""
   C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                       = ""
   C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC              = ""
   C_OPTION_LOC                                                    = ""
   C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                  = ""
   C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                 = ""
   C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                             = ""
   C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC       = ""
   C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC       = ""
   C_PRESS_ESC_TO_CANCEL                                           = ""
   C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                              = ""
   C_PROCESSING_LOC                                                = ""
   C_PROCESS_PROGRESS_LOC                                          = ""
   C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                              = ""
   C_READING_CFG_VALUES_FROM_DISK_LOC                              = ""
   C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                 = ""
   C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                         = ""
   C_SCANNING_FILE_AND_DIR_INFO_LOC                                = ""
   C_SOURCEFILE_LOC                                                = ""
   C_SOURCESAFE_COMPATIBILITY_MODE_LOC                             = ""
   C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                  = ""
   C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC                = ""
   C_UNKNOWN_CLASS_NAME_LOC                                        = ""
   C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                           = ""
   C_USING_THIS_SETTINGS_LOC                                       = ""
   C_USING_THIS_SETTINGS_LOC1                                      = ""
   C_USING_THIS_SETTINGS_LOC2                                      = ""
   C_USING_THIS_SETTINGS_LOC3                                      = ""
   C_USING_THIS_SETTINGS_LOC4                                      = ""
   C_USING_THIS_SETTINGS_LOC5                                      = ""
   C_USING_THIS_SETTINGS_LOC6                                      = ""
   C_USING_THIS_SETTINGS_LOC7                                      = ""
   C_WARNING_LOC                                                   = ""
   C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                      = ""
   C_WITH_ERRORS_LOC                                               = ""
   C_LOCKINGFOLDER_LOC                                             = ""

   C_INDEX2TXT_PROCESSING_LOC                                      = ""
   C_INDEX2TXT_EXTRAFILES_LOC                                      = ""
   C_INDEX2TXT_NOFILE_LOC                                          = ""
   C_INDEX2TXT_NOTTHISTABLE_LOC                                    = ""
   C_INDEX2BIN_PROCESSING_LOC                                      = ""
   C_INDEX2BIN_STRUCTURAL_LOC                                      = ""
   C_INDEX2BIN_STANDALONE_LOC                                      = ""
   C_INDEX2BIN_COMPOUND_LOC                                        = ""

   C_PJXPATH_ERR_LOC1                                              = ""
   C_PJXPATH_ERR_LOC2                                              = ""
   C_PJXPATH_ERR_LOC3                                              = ""
   C_PJXPATH_ERR_LOC4                                              = ""
   C_PJXPATH_ERR_LOC5                                              = ""

   Procedure Init
      Lparameters tcLanguage

      Try
         Local lcSys16, lnPosProg, laDirInfo(1,5), lcLangStr ;
            , loEx As Exception

         With This As CL_LANG Of 'cl_lang.prg'
            *-- El lenguaje pasado por parámetro prevalece sobre el existente.
            tcLanguage  = Evl(tcLanguage,'')

            If Empty(tcLanguage)
               .n_LanguageSelectedMethod   = 0 && 0=Automatic by version(3)
            Else
               .n_LanguageSelectedMethod   = 1 && 1=Assigned by Parameter
            Endif

            tcLanguage  = Upper( Evl(tcLanguage, Version(3)) )

            Do Case
            Case Inlist(tcLanguage, '33', 'FR') && French (Francés)
               *-------------------------------------------------------------------------------------------------------------------------------------------
               *-- NOTE: MUST USE DOUBLE QUOTES, OR SYNTAX ERRORS HAPPEN WHEN COMPILING. STRANGE :(
               *-------------------------------------------------------------------------------------------------------------------------------------------
               .C_ALLOWED_VALUES_ARE_LOC                                       = "Les valeurs autorisées sont"
               .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "* Et ? extensions ne sont pas autorisées car il est dangereux (binaires peuvent être remplacés par des fichiers vides de XX2)"
               .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Impossible de mettre à jour backlink"
               .C_BACKLINK_OF_TABLE_LOC                                        = "de la table"
               .C_BACKUP_OF_LOC                                                = "Faire de sauvegarde des: "
               .C_CACHING_CONFIG_FOR_DIRECTORY_LOC                             = "La mise en cache pour le répertoire config"
               .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Vous ne pouvez pas générer un fichier [<<THIS.c_OutputFile>>] car il est en lecture seule"
               .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimisation: Fichier de base [<<JUSTFNAME(.c_InputFile)>>] Déjà traitée, en sautant traitement de fichier [<<tc_InputFile>>]"
               .C_CONFIGFILE_LOC                                               = "Utilisation du fichier de configuration:"
               .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Conversion Annulé par l'utilisateur"
               .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "Convertir tous les fichiers dans un Projet"
               .C_CONVERT_FOLDER_LOC                                           = "Convertir un Dossier"
               .C_BINARY_TO_TEXT_LOC                                           = "Binaire en Texte"
               .C_TEXT_TO_BINARY_LOC                                           = "Texte à Binaire"
               .C_CONVERT_FOLDER_NONE_LOC                                      = "Aucun"
               .C_CONVERT_FOLDER_QUESTION_LOC                                  = "Que la conversion doit être effectuée sur les fichiers de ce dossier?"
               .C_CONVERTER_UNLOAD_LOC                                         = "Convertisseur déchargement"
               .C_CONVERTING_FILE_LOC                                          = "Conversion de fichiers"
               .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Erreur de données: ne peut pas analyser en raison de guillemets non appariés en ligne <<lcMetadatos>>"
               .C_DUPLICATED_FILE_LOC                                          = "fichier dupliqué"
               .C_DUPLICATED_OBJECT_LOC                                        = "Object dupliqué"
               .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "Vous ne trouvez pas marqueur de fin [ENDDEFINE] de la ligne <<TRANSFORM(toClase._Inicio)>> ID [<<toClase._Nombre>>]"
               .C_END_MARKER_NOT_FOUND_LOC                                     = "Vous ne trouvez pas fin marqueur [<<ta_ID_Bloques(lnPrimerID, 2)>>] qui ferme marqueur de début [<<ta_ID_Bloques(lnPrimerID, 1) >>] en ligne <<TRANSFORM(taBloquesExclusion (tnBloquesExclusion, 1))>>"
               .C_END_OF_PROCESS_LOC                                           = "Fin du processus"
               .C_ERROR_LOC                                                    = "ERREUR"
               .C_ERRORS_FOUND_IN_FILE_LOC                                     = "ERREURS TROUVÉ DANS LE FICHIER"
               .C_EXTENSION_RECONFIGURATION_LOC                                = "Extension Reconfiguration:"
               .C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC        = "Nombre de classe externe (<<toModulo._ExternalClasses_Count>>) ne correspond pas classes trouvées (<<toModulo._Clases_Count>>) pour le fichier [<<toFoxBin2Prg.c_InputFile>>]"
               .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "Aucune classe externe est trouvé"
               .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "Nom de membre externe n'a pas été trouvé"
               .C_EXTERNAL_PARAMETERS_LOC                                      = "PARAMÈTRES EXTERNES"
               .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Champ [<< laProps (m.I) >>] ne trouve pas dans la structure du fichier DBF <<('TABLABIN')>>"
               .C_FILE_DOESNT_EXIST_LOC                                        = "Fichier ne existe pas:"
               .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "File [<<.c_InputFile>>] ne est pas supporté"
               .C_FILE_NOT_FOUND_LOC                                           = "Fichier introuvable"
               .C_FILENAME_LOC                                                 = "Fichier"
               .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERREUR"
               .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "SYNTAX AND PARAMETERS INFO"
               .C_ClassTwice_Header_LOC                                        = CR_LF+"Class defined twice."+0h0D0A
               .C_ClassTwice_Lib_LOC                                           = CR_LF+"Library: "
               .C_ClassTwice_Class_LOC                                         = CR_LF+"Class: "
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FoxBin2Prg Home Page and download: https://github.com/fdbozzo/foxbin2prg/wiki  -  Fernando D. Bozzo (2013.11.25)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>FOXBIN2PRG.EXE <cFileSpec.Ext> [cType [cTextName [cGenText [cDontShowErrors [cDebug [cDontShowProgress [cOriginalFileName [cRecompile [cNoTimestamps [cCFG_File [cOutputFolder] ] ] ] ] ] ] ] ] ] ]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>cFileSpec.Ext:     ? | interactive This help
                        <<>>                   Full name (fullpath) of the file to convert or directory name to process
                        <<>>                     - If 'BIN2PRG' is specified, the directory specified in tcType is processed for generating TX2
                        <<>>                     - If 'PRG2BIN' is specified, the directory specified in tcType is processed for regenerating BIN
                        <<>>                     - In SCCAPI (VSS) compatibility mode, it is used to query the conversion support for the file type specified
                        <<>>                       VSS Types: d=DBC, D=DBF, K=Form, B=Label, M=Menu, R=Report, V=Class
                        <<>>cType:             In SCCAPI (VSS) compatibility mode indicates the input file type.
                        <<>>                        - If specified '*' or '*-' and tc_InputFile is a PJX, all project files are processed
                        <<>>cTextName          = Text filename. Only for SCCAPI (VSS) compatibility mode.
                        <<>>lGenText:          .T.=Generates Text, .F.=Regenerates Binary. Only for SCCAPI (VSS) compatibility mode.
                        <<>>cDontShowErrors:   '1' for NOT showing errors
                        <<>>cDebug:            '1' for generating process LOGs, stop on errors
                        <<>>cDontShowProgress: '1' for NOT showing the process window
                        <<>>cOriginalFileName: used in those cases in which inputFile is a temporary filename and you want to generate the correct filename on the header of the text version
                        <<>>cRecompile:        Indicates recompile ('1') the binary once regenerated. You can specify a Path too (ie, the project one)
                        <<>>cNoTimestamps:     Indicates if timestamp of several file types must be cleared ('1' or empty) or not ('0')
                        <<>>cCFG_File:         Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cOutputFolder:     The output folder to write to. If it isn't specified, the same folder as the source is used.
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE c|C|t [OutFileName [ cCFG_File[ cDebug]]]
                        <<>>DO FOXBIN2PRG.EXE WITH -c|-C|-t [, OutFileName [, cCFG_File[, cDebug]]]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>No parameter: Calls this info screen
                        <<>>-c (c)        Creates a template config-file <OutFileName> (like FOXBIN2PRG.CFG)
                        <<>>-C (C)        Creates a config-file <OutFileName> (like FOXBIN2PRG.CFG) with current options of folder of <OutFileName>
                        <<>>              If OutFileName is not given a FoxBin2Prg._cfg config file will be created at default folder
                        <<>>-t (t)        Creates a template table-config-file <OutFileName> (like <Tablename>.dbf.cfg)
                        <<>>              If OutFileName is not given, and a table is open a <Tablename>.dbf._cfg config file will be created at table folder.
                        <<>>cCFG_File:    Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cDebug:       '1' for generating process LOGs, stop on errors
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE VERNO
                        <<>>DO FOXBIN2PRG.EXE WITH "VERNO"|cPara
                        <<>>
                        <<>>-- Parameter details:
                        <<>>-VERNO (VERNO) Return version number of FoxBin2Prg
                        <<>>cPara          A parameter with the Value "VERNO", the version number is returned to this parameter
                        <<>>
                        <<>>
               ENDTEXT
               *** DH 2021-03-04: added HomeDir to text
               *** DH 2024-08-26: added text for option 2 for BodyDevInfo
               .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 = "*Options for folder <<.c_Recompile>>, read as of <<DATETIME()>>"
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FOXBIN2PRG.CFG configuration options: (If no values given, these are the DEFAULTS)
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>> Note, configuration files will follow an inheritance.
                        <<>> 1.  Default values
                        <<>> 2., optional FOXBIN2PRG.CFG in folder of FOXBIN2PRG.EXE
                        <<>>  or, if defined, a config file given by a parameter calling FOXBIN2PRG
                        <<>>      if used, the InhibitInheritance setting controls if other config files will be evaluated (default)
                        <<>> 3., optional FOXBIN2PRG.CFG in root of working directory
                        <<>> 4., optional FOXBIN2PRG.CFG in every folder up to the working directory
                        <<>> 5., optional Special settings per single DBF's Syntax: <TableName>.dbf.cfg in tables folder)
                        <<>>
                        <<>> Some Parameter calling FOXBIN2PRG.EXE overturn this settings (except Defaults)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>-- Settings for internal work, not processing
                        <<>>Language: (auto)               && Language of shown messages and LOGs. EN=English, FR=French, ES=Español, DE=German, Not defined = AUTOMATIC [DEFAULT]
                        <<>>ShowProgressbar: 1             && 0=Don't show, 1=Allways show, 2=Show only for multi-file processing
                        <<>>DontShowErrors: 0              && Show message errors by default
                        <<>>ExtraBackupLevels: 1           && By default 1 BAK is created. With this you can make more .N.BAK, or none
                        <<>>Debug: 0                       && 0=Don't Activate individual <file>.Log by default
                        <<>>                               && 1=Activate individual <file>.Log by default
                        <<>>                               && 2=???
                        <<>>                               && Only valid if not controlled by parameter
                        <<>>BackgroundImage: <cFile>       && Backgroundimage for process form. Empty for empty Background. File not found uses default.
                        <<>>HomeDir: 1                     && Home directory in PJX
                        <<>>                               && 0 don't save HomeDir in PJ2
                        <<>>                               && 1 save HomeDir in PJ2
                        <<>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        <<>>-- Settings for config file via parameter only
                        <<>>InhibitInheritance: 0          && 0=Allow scanning "regular" config files (file via parameter is just additional default)
                        <<>>                               && 1=Only read directory branch from root to parent of folder and below, not FoxBin2Prg default
                        <<>>                               && 2=Only read folder and subfolder of the file given by parameter
                        <<>>                               && 3=Read no other file
                        <<>>                               && This is like
                        <<>>                               && 0 Default | Parameter file | Default near FoxBin2Prg | all other config files
                        <<>>                               && 1 Default | Parameter file | Inheritance from root to parent of folder | folder and subdirs
                        <<>>                               && 2 Default | Parameter file | folder and subdirs
                        <<>>                               && 3 Default | Parameter file
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Conversion operation by type
                        <<>>PJX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>VCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>SCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>FRX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>LBX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>MNX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBC_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBF_Conversion_Support: 1      && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>FKY_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>MEM_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for pjx files
                        <<>>CheckFileInPath: 0             && Determines 2Txt deals with files not in the subfolders of the PJX. No handler for UNC paths.
                        <<>>                               && 0 Ignore. Default
                        <<>>                               && 1 Check and error out if file is not on same structure (for source control)
                        <<>>                               && 2 Create absolute path if file is on different drive.
                        <<>>                               && 3 Create absolute path if file is not in structure
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for container files (not pjx)
                        <<>>-- CLASS (, FORM and DBC) options (tx2 is to read as vc2 or sc2, VCX might be SCX)
                        <<>>-- FORM and DBC options default to this settings, id not set otherwise. See below.
                        <<>>- Class per file options (UseClassPerFile: 1)
                        <<>>UseClassPerFile: 0             && Determines how a library (or form) will handle included class (or, for forms, objects)
                        <<>>                               && 0 One library.tx2 file
                        <<>>                               && 1 Multiple file.class.tx2 files
                        <<>>                               && 2 Multiple file.baseclass.class.tx2 files
                        <<>>RedirectClassPerFileToMain: 0  && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to file.vcx/scx
                        <<>>                               && 1 Redirect to file.vcx/scx when selecting file[.baseclass].class.tx2
                        <<>>                               &&   RedirectClassType: 1 has precedence
                        <<>>RedirectClassType: 0           && For classes created with UseClassPerFile>0 in the form file[.baseclass].class.tx2
                        <<>>                               && Those files could be imported like file.tx2::Class::import or like file[.baseclass].class.tx2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect file[.baseclass].class.tx2 to file.VCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect file[.baseclass].class.tx2 to file[.baseclass].class.VCX and do not touch file.VCX
                        <<>>                               && 2 Redirect file[.baseclass].class.tx2 to file.VCX and do not touch other classes of file.VCX
                        <<>>ClassPerFileCheck: 0           && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check file[.baseclass].class.tx2 inclusion
                        <<>>                               &&   Only used if import file is in file[.baseclass].class.tx2 syntax
                        <<>>                               &&   Ignored for RedirectClassType: 2
                        <<>>UseClassPerDir: 0              && 0=flat file.class.ext layout (default)
                        <<>>                               && 1=store under file.ext/ subdirectory (requires UseClassPerFile>0)
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- FORM options
                        <<>>- Form per file options (UseFormSettings: 1)
                        <<>>UseFormSettings: 0             && 1=Turns the File per SCX options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if UseFormSettings is set 1 before!
                        <<>>                               &&   If UseFormSettings is set 0 later, all setting will be lost
                        <<>>UseFormPerFile: 0              && Determines how a form will handle included objects
                        <<>>                               && 0 One Form.sc2 file
                        <<>>                               && 1 Multiple Form.Obj.sc2 files
                        <<>>                               && 2 Multiple Form.baseclass.Obj.sc2 files
                        <<>>RedirectFormPerFileToMain: 0   && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to Form.scx
                        <<>>                               && 1 Redirect to Form.scx when selecting Form[.baseclass].Obj.sc2
                        <<>>                               &&   RedirectFormType: 1 has precedence
                        <<>>RedirectFormType: 0            && For classes created with UseFormPerFile>0 in the form Form[.baseclass].Obj.sc2
                        <<>>                               && Those files could be imported like Form.sc2::Class::import or like Form[.baseclass].Obj.sc2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect Form[.baseclass].Obj.sc2 to Form[.baseclass].Obj.SCX and do not touch Form.SCX
                        <<>>                               && 2 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and do not touch other classes of Form.SCX
                        <<>>FormPerFileCheck: 0            && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check Form[.baseclass].Obj.sc2 inclusion
                        <<>>                               &&   Only used if import file is in Form[.baseclass].Obj.sc2 syntax
                        <<>>                               &&   Ignored for RedirectFormType: 2
                        <<>>UseFormPerDir: 0              && 0=flat Form.Obj.ext layout (default)
                        <<>>                               && 1=store under Form.ext/ subdirectory (requires UseFormPerFile>0)
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- DBC options
                        <<>>- File per DBC options (UseFilesPerDBC: 1)
                        <<>>OldFilesPerDBC: 0              && 1=Turns the File per DBC options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if OldFilesPerDBC is set 1 before!
                        <<>>                               &&   If OldFilesPerDBC is set 0 later, all setting will be lost
                        <<>>UseFilesPerDBC: 0              && 0=One database dc2 file, 1=Multiple file.*.*.dc2 files
                        <<>>                               && 0 creates only a file.dc2 with all DBC (file) data
                        <<>>                               && 1 creates a file.dc2 with DBC properties
                        <<>>                               &&   and additional DBC files per DBC item (stored-proc, table, ..)
                        <<>>                               &&   Note: recration only if RedirectFilePerDBCToMain is 1
                        <<>>RedirectFilePerDBCToMain: 0    && 0=Don't redirect to file.dc2, 1=Redirect to file.dc2 when selecting file.item.*.dc2
                        <<>>ItemPerDBCCheck: 0             && 0=Don't check file.item.*.dc2 inclusion, 1=Check file.item.*.dc2 inclusion
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- General files
                        <<>>NoTimestamps: 1                && Clear timestamps of several file types by default for minimize text-file differences
                        <<>>ClearUniqueID: 1               && 0=Keep UniqueID in text files, 1=Clear Unique ID. Useful for Diff and Merge
                        <<>>OptimizeByFilestamp: 0         && 1=Optimize file regeneration depending on file timestamp. Dangerous while working with branches!
                        <<>>RemoveNullCharsFromCode: 1     && 1=Drop .Null. chars from source code
                        <<>>ExportUTF8: 0                  && 0=Export text files in ANSI (current code page), 1=Export text files in UTF-8 (StrConv 9)
                        <<>>RemoveZOrderSetFromProps: 0    && 0=Do not remove ZOrderSet property from object, 1=Remove ZOrderSet property from object
                        <<>>PRG_Compat_Level: 0            && 0=Legacy, 1=Use HELPSTRING as Class Procedure comment
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- PJX special
                        <<>>BodyDevInfo: 0                 && 0=Don't keep DevInfo for body pjx records, 1=Keep DevInfo, 2 = Don't keep DevInfo or ObjRev
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Mirrored tree (exportProjectTree / importProjectTree only)
                        <<>>CopyNonConvertible: 0          && 0=Skip non-convertible PJX/PJ2 members, 1=Copy them into the mirrored tree as-is
                        <<>>CopyExcludedPjxFiles: 0        && 0=Skip PJX/PJ2 members marked Exclude (default), 1=Include them in export/import
                        <<>>ExcludedSubdirs:               && Semicolon-separated subpaths under project root to skip (not converted or copied)
                        <<>>                               && Example: tmp;backup;forms\old
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- DBF special
                        <<>>ClearDBFLastUpdate: 1          && 0=Keep DBF LastUpdate, 1=Clear DBF LastUpdate. Useful for Diff.
                        <<>>ExcludeDBFAutoincNextval: 0    && 0=Do not exclude this value from db2, 1=Exclude this value from db2
                        <<>>DBF_Conversion_Included: *     && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_Conversion_Excluded:       && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_BinChar_Base64: 1          && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform (default)
                        <<>>DBF_IncludeDeleted: 0          && 0=Do not include deleted records (default), 1=Include deleted records
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Text file extensions
                        <<>>extension: tx2=newext          && Specify extensions to use. Default FoxBin2Prg extensions ends in '2' (see at the bottom)
                        <<>>-- Example configuration for SourceSafe compatibility:
                        <<>>extension: pj2=pja             && Text file to PJX
                        <<>>extension: vc2=vca             && Text file to VCX
                        <<>>extension: sc2=sca             && Text file to SCX
                        <<>>extension: fr2=fra             && Text file to FRX
                        <<>>extension: lb2=lba             && Text file to LBX
                        <<>>extension: mn2=mna             && Text file to MNX
                        <<>>extension: db2=dba             && Text file to DBF
                        <<>>extension: dc2=dca             && Text file to DBC
                        <<>>-- Additional extensions
                        <<>>extension: fk2=fkx             && Text file to FKY
                        <<>>extension: me2=fkx             && Text file to MEM
                        <<>>
               ENDTEXT
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>-- Individual DBF configuration file (syntax: filename.dbf.cfg) Defaults see FoxBin2prg.cfg
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>DBF_Conversion_Support: <1,2,4,8>           && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>DBF_Conversion_Order: <c_Expression>        && Field expresion. ie: name+str(age,3)
                        <<>>DBF_Conversion_Condition: <c_Expression>    && Logical expression. ie: age > 10 AND NOT DELETED()
                        <<>>DBF_IndexList: <cFile_List>                 && comma delimited list of additonal non structural index files, cdx or idx
                        <<>>DBF_BinChar_Base64: <0,1>                   && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform
                        <<>>DBF_IncludeDeleted: <0,1>                   && 0=Do not include deleted records, 1=Include deleted records
                        <<>>
               ENDTEXT
               .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG est seulement pour Visual FoxPro 9.0!"
               .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "AVERTISSEMENT!"
               .C_GENERATED_FILE_SIZE_LOC                                      = "Taille du fichier généré"
               .C_GENERATING_BINARY_LOC                                        = "Génération Binaire"
               .C_INCLUDING_CLASS_LOC                                          = "classe, y compris"
               .C_INCLUDING_MEMBER_LOC                                         = "membres, y compris"
               .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "SourceSafe Compatibilité ModeIncorrect VFP 9 Version - SP1 manquant! Prévue: 3504 ou plus tard, réelle: " + Version(4)
               .C_INHERITING_FROM_LOC                                          = "Héritant de"
               .C_INTERACTIVE_DIRECTORY_SELECTION_LOC                          = "Sélection répertoire interactive"
               .C_INVALID_PARAMETER_LOC                                        = "Paramètre non valide"
               .C_IS_A_FILE_LOC                                                = "est un FICHIER"
               .C_IS_A_DIRECTORY_LOC                                           = "est un RÉPERTOIRE"
               .C_IS_UNSUPPORTED_LOC                                           = "ne est pas supporté"
               .C_LANGUAGE_LOC                                                 = "FR"
               .C_MAIN_EXECUTION_LOC                                           = "EXÉCUTION PRINCIPALE"
               .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "Menu [<<THIS.c_InputFile>>] ne est pas dans VFP 9 Format! - Se il vous plaît se convertir à VFP 9 avec MODIFY MENU '<<THIS.c_InputFile>>'"
               .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Programme des noms de capitalisation [<<lcEXE_CAPS>>] trouvé"
               .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* Programme des noms de capitalisation [<<lcEXE_CAPS>>] introuvables"
               .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Object [<<toObj.CLASS>>] ne contient pas l'objet oReg (niveau <<TRANSFORM(tnNivel)>>)"
               .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Opération non reconnu. Seulement SETNAME et GETNAME permis."
               .C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC             = "Optimisation: sauter fichier déjà traité [<<(lcFile)>>]"
               .C_OPTION_LOC                                                   = "Option"
               .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "La classe externe ne correspond pas à la classe interne"
               .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "L'élément extérieur ne correspond pas aux éléments intérieur"
               .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimisation: fichier de sortie [<<lcOutputFile>>] ne était pas écrasé parce que ce est la même que celle générée."
               .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimisation: le fichier de sortie [<<THIS.c_OutputFile>>] pas régénéré en ayant le même horodatage que l'entrée."
               .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimisation: le fichier de sortie [<<THIS.c_OutputFile>>] n'a pas été régénéré car il est plus récent que le fichier d'entrée."
               .C_PRESS_ESC_TO_CANCEL                                          = "Appuyez sur Esc pour Annuler"
               .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Procédure pas fermé. Dernière ligne de code doit être ENDPROC. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
               .C_PROCESSING_LOC                                               = "Traitement du fichier"
               .C_PROCESS_PROGRESS_LOC                                         = "Processus Progrès:"
               .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Propriété [<<TRANSFORM(tnPropertyID)>>] ne est pas reconnu."
               .C_READING_CFG_VALUES_FROM_DISK_LOC                             = "VALEURS LECTURE CFG À PARTIR DU DISQUE"
               .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Rapport [<<THIS.c_InputFile>>] ne est pas dans VFP 9 Format! - Se il vous plaît se convertir à VFP 9 avec MODIFY REPORT '<<THIS.c_InputFile>>'"
               .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Demande de capitalisation de fichier [<<tcFileName>>]"
               .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Fichier de numérisation et de l'information de répertoire pour"
               .C_SOURCEFILE_LOC                                               = "Fichier source: "
               .C_SOURCESAFE_COMPATIBILITY_MODE_LOC                            = "Mode de compatibilité SourceSafe"
               .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Nesting erreur de structure. ENDPROC prévu, mais a trouvé ENDDEFINE sur la classe <<toClase._Nombre>> (<<loProcedure._Nombre>>), ligne <<TRANSFORM(m.I)>> du fichier <<THIS.c_InputFile>>"
               .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Nesting erreur de structure. ENDPROC attendue, mais ENDDEFINE sur la classe <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), ligne <<TRANSFORM(m.I)>> du fichier <<THIS.c_InputFile>>"
               .C_UNKNOWN_CLASS_NAME_LOC                                       = "Classe inconnue[<<THIS.CLASS>>]"
               .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Utilisez le fichier Optimisation d'horodatage"
               .C_USING_THIS_SETTINGS_LOC                                      = "Utilisation de ce paramètre"
               .C_USING_THIS_SETTINGS_LOC1                                     = " BY PARAMETER, skipping all previous config!"
               .C_USING_THIS_SETTINGS_LOC2                                     = " Parsing of full configuration allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC3                                     = " Parsing configuration in parent~ and subdirectories allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC4                                     = " Parsing configuration in subdirectories allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC5                                     = " Parsing of other configuration not allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC6                                     = "External configuration file set: "
               .C_USING_THIS_SETTINGS_LOC7                                     = ", using cached config."
               .C_WARNING_LOC                                                  = "AVERTISSEMENT!"
               .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "AVERTISSEMENT!" + CR_LF+ "ASSUREZ VOUS NE UTILISEZ PAS UN ALIAS DE TABLE SUR LES EXPRESSIONS INDEX CLÉS!! (exemple: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
               .C_WITH_ERRORS_LOC                                              = "avec des erreurs"

               .C_LOCKINGFOLDER_LOC                                            = " found, proccessing directory and subdirectories inhibited."
               .C_INDEX2TXT_PROCESSING_LOC                                     = " Processing index"
               .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Additional index files"
               .C_INDEX2TXT_NOFILE_LOC                                         = "     Not a File "
               .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index does not match table "
               .C_INDEX2BIN_PROCESSING_LOC                                     = " Creating index"
               .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs for structural index"
               .C_INDEX2BIN_STANDALONE_LOC                                     = "  Standalone index "
               .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs for compound index "
               .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Main file "'
               .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Project icon file "'
               .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'File ""'
               .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'not in PJX folder structure, "'
               .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'check option "CheckFileInPath".' + CR_LF+CR_LF

            Case Inlist(tcLanguage, '34', 'ES') && Spanish (Español)
               *-------------------------------------------------------------------------------------------------------------------------------------------
               *-- NOTA: SE DEBEN USAR COMILLAS DOBLES, O ERRORES DE SINTAXIS OCURREN AL COMPILAR. EXTRAÑO :(
               *-------------------------------------------------------------------------------------------------------------------------------------------
               .C_ALLOWED_VALUES_ARE_LOC                                       = "Los valores permitidos son"
               .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "No se admiten extensiones * o ? porque es peligroso (se pueden pisar binarios con archivo xx2 vacíos)."
               .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "No se pudo actualizar el backlink"
               .C_BACKLINK_OF_TABLE_LOC                                        = "de la tabla"
               .C_BACKUP_OF_LOC                                                = "Haciendo Backup de: "
               .C_CACHING_CONFIG_FOR_DIRECTORY_LOC                             = "Cacheando configuración para directorio"
               .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "No se puede generar el archivo [<<THIS.c_OutputFile>>] porque es ReadOnly"
               .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimización: El archivo Base [<<JUSTFNAME(.c_InputFile)>>] ya fue procesado, ignorando el procesamiento del archivo [<<tc_InputFile>>]"
               .C_CONFIGFILE_LOC                                               = "Usando archivo de configuración:"
               .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Conversión Cancelada por el usuario"
               .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "Convertir todos los archivos de un Proyecto"
               .C_CONVERT_FOLDER_LOC                                           = "Convertir Carpeta"
               .C_BINARY_TO_TEXT_LOC                                           = "Binario a Texto"
               .C_TEXT_TO_BINARY_LOC                                           = "Texto a Binario"
               .C_CONVERT_FOLDER_NONE_LOC                                      = "Ninguna"
               .C_CONVERT_FOLDER_QUESTION_LOC                                  = "¿Qué tipo de conversión se debe hacer en esta carpeta?"
               .C_CONVERTER_UNLOAD_LOC                                         = "Descarga del conversor"
               .C_CONVERTING_FILE_LOC                                          = "Convirtiendo archivo"
               .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Error de datos: No se puede parsear porque las comillas no son pares en la línea <<lcMetadatos>>"
               .C_DUPLICATED_FILE_LOC                                          = "Archivo duplicado"
               .C_DUPLICATED_OBJECT_LOC                                        = "Objeto Duplicado"
               .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "No se ha encontrado el marcador de fin [ENDDEFINE] de la línea <<TRANSFORM( toClase._Inicio )>> para el identificador [<<toClase._Nombre>>]"
               .C_END_MARKER_NOT_FOUND_LOC                                     = "No se ha encontrado el marcador de fin [<<ta_ID_Bloques(lnPrimerID,2)>>] que cierra al marcador de inicio [<<ta_ID_Bloques(lnPrimerID,1)>>] de la línea <<TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))>>"
               .C_END_OF_PROCESS_LOC                                           = "Fin del Proceso"
               .C_ERROR_LOC                                                    = "ERROR"
               .C_ERRORS_FOUND_IN_FILE_LOC                                     = "SE HAN ENCONTRADOS ERRORES EN EL ARCHIVO"
               .C_EXTENSION_RECONFIGURATION_LOC                                = "Reconfiguración de extensión:"
               .C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC        = "El conteo de clases externas (<<toModulo._ExternalClasses_Count>>) no coincide con la cantidad encontrada (<<toModulo._Clases_Count>>) para el archivo [<<toFoxBin2Prg.c_InputFile>>]"
               .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "No se encontró la clase externa"
               .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "No se encontró el miembro externo"
               .C_EXTERNAL_PARAMETERS_LOC                                      = "PARÁMETROS EXTERNOS"
               .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "No se encontró el campo [<<laProps(m.I)>>] en la estructura del archivo <<DBF('TABLABIN')>>"
               .C_FILE_DOESNT_EXIST_LOC                                        = "El archivo no existe:"
               .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "El archivo [<<.c_InputFile>>] no está soportado"
               .C_FILE_NOT_FOUND_LOC                                           = "No se encontró el archivo"
               .C_FILENAME_LOC                                                 = "Archivo"
               .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERROR"
               .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "INFORMACIÓN DE SINTAXIS Y PARÁMETROS"
               .C_ClassTwice_Header_LOC                                        = CR_LF+"Class defined twice."+CR_LF
               .C_ClassTwice_Lib_LOC                                           = CR_LF+"Library: "
               .C_ClassTwice_Class_LOC                                         = CR_LF+"Class: "
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>Página principal y descarga de FoxBin2Prg: https://github.com/fdbozzo/foxbin2prg/wiki  -  Fernando D. Bozzo (2013.11.25)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>FOXBIN2PRG.EXE <cFileSpec.Ext> [cType [cTextName [cGenText [cDontShowErrors [cDebug [cDontShowProgress [cOriginalFileName [cRecompile [cNoTimestamps [cCFG_File [cOutputFolder] ] ] ] ] ] ] ] ] ] ]
                        <<>>
                        <<>>-- Detalle de parámetros:
                        <<>>cFileSpec.Ext:     ? | interactive This help
                        <<>>                   Nombre completo (fullpath) del archivo a convertir o del directorio a procesar
                        <<>>                   - Si indica 'BIN2PRG', se procesa el directorio indicado en tcType para generar los TX2
                        <<>>                   - Si indica 'PRG2BIN', se procesa el directorio indicado en tcType para generar los BIN
                        <<>>                   - En modo compatibilidad con SCCAPI (VSS), se usa para preguntar el tipo de soporte de conversión para el tipo de archivo indicado
                        <<>>                     VSS Types: d=DBC, D=DBF, K=Form, B=Label, M=Menu, R=Report, V=Class
                        <<>>cType:             En modo compatibilidad con SCCAPI (VSS) es el Tipo de archivo de entrada.
                        <<>>                    - i indica '*' o '*-' y tc_InputFile es un PJX, se procesa todo el proyecto
                        <<>>cTextName          = Nombre del archivo texto. (Solo para compatibilidad con Visual SourceSafe)
                        <<>>lGenText:          .T.=Genera Texto, .F.=Genera Binario. Solo para compatibilidad con SCCAPI (VSS)
                        <<>>cDontShowErrors:   '1' para NO mostrar errores
                        <<>>cDebug:            '1' para generar LOGs del proceso, stop on errors
                        <<>>cDontShowProgress: '1' para NO mostrar la ventana de progreso
                        <<>>cOriginalFileName: Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar el nombre correcto en la cabecera de la versión texto
                        <<>>cRecompile:        Indica recompilar ('1') el binario una vez regenerado. También se puede indicar un Path (p.ej, el del proyecto)
                        <<>>cNoTimestamps:     Indica si se debe anular el timestamp ('1' o vacío) o no ('0')
                        <<>>cCFG_File:         Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cOutputFolder:     The output folder to write to. If it isn't specified, the same folder as the source is used.
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE c|C|t [OutFileName [ cCFG_File[ cDebug]]]
                        <<>>DO FOXBIN2PRG.EXE WITH -c|-C|-t [, OutFileName [, cCFG_File[, cDebug]]]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>No parameter: Calls this info screen
                        <<>>-c (c)        Creates a template config-file <OutFileName> (like FOXBIN2PRG.CFG)
                        <<>>-C (C)        Creates a config-file <OutFileName> (like FOXBIN2PRG.CFG) with current options of folder of <OutFileName>
                        <<>>              If OutFileName is not given a FoxBin2Prg._cfg config file will be created at default folder
                        <<>>-t (t)        Creates a template table-config-file <OutFileName> (like <Tablename>.dbf.cfg)
                        <<>>              If OutFileName is not given, and a table is open a <Tablename>.dbf._cfg config file will be created at table folder.
                        <<>>cCFG_File:    Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cDebug:       '1' for generating process LOGs, stop on errors ()
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE VERNO
                        <<>>DO FOXBIN2PRG.EXE WITH "VERNO"|cPara
                        <<>>
                        <<>>-- Parameter details:
                        <<>>-VERNO (VERNO) Return version number of FoxBin2Prg
                        <<>>cPara          A parameter with the Value "VERNO", the version number is returned to this parameter
                        <<>>
                        <<>>
               ENDTEXT
               *** DH 2021-03-04: added HomeDir to text
               *** DH 2024-08-26: added text for option 2 for BodyDevInfo
               .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 = "*Options for folder <<.c_Recompile>>, read as of <<DATETIME()>>"
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FOXBIN2PRG.CFG configuration options: (If no values given, these are the DEFAULTS)
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>> Note, configuration files will follow an inheritance.
                        <<>> 1.  Default values
                        <<>> 2., optional FOXBIN2PRG.CFG in folder of FOXBIN2PRG.EXE
                        <<>>  or, if defined, a config file given by a parameter calling FOXBIN2PRG
                        <<>>      if used, the InhibitInheritance setting controls if other config files will be evaluated (default)
                        <<>> 3., optional FOXBIN2PRG.CFG in root of working directory
                        <<>> 4., optional FOXBIN2PRG.CFG in every folder up to the working directory
                        <<>> 5., optional Special settings per single DBF's Syntax: <TableName>.dbf.cfg in tables folder)
                        <<>>
                        <<>> Some Parameter calling FOXBIN2PRG.EXE overturn this settings (except Defaults)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>-- Settings for internal work, not processing
                        <<>>Language: (auto)               && Language of shown messages and LOGs. EN=English, FR=French, ES=Español, DE=German, Not defined = AUTOMATIC [DEFAULT]
                        <<>>ShowProgressbar: 1             && 0=Don't show, 1=Allways show, 2=Show only for multi-file processing
                        <<>>DontShowErrors: 0              && Show message errors by default
                        <<>>ExtraBackupLevels: 1           && By default 1 BAK is created. With this you can make more .N.BAK, or none
                        <<>>Debug: 0                       && 0=Don't Activate individual <file>.Log by default
                        <<>>                               && 1=Activate individual <file>.Log by default
                        <<>>                               && 2=???
                        <<>>                               && Only valid if not controlled by parameter
                        <<>>BackgroundImage: <cFile>       && Backgroundimage for process form. Empty for empty Background. File not found uses default.
                        <<>>HomeDir: 1                     && Home directory in PJX
                        <<>>                               && 0 don't save HomeDir in PJ2
                        <<>>                               && 1 save HomeDir in PJ2
                        <<>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        <<>>-- Settings for config file via parameter only
                        <<>>InhibitInheritance: 0          && 0=Allow scanning "regular" config files (file via parameter is just additional default)
                        <<>>                               && 1=Only read directory branch from root to parent of folder and below, not FoxBin2Prg default
                        <<>>                               && 2=Only read folder and subfolder of the file given by parameter
                        <<>>                               && 3=Read no other file
                        <<>>                               && This is like
                        <<>>                               && 0 Default | Parameter file | Default near FoxBin2Prg | all other config files
                        <<>>                               && 1 Default | Parameter file | Inheritance from root to parent of folder | folder and subdirs
                        <<>>                               && 2 Default | Parameter file | folder and subdirs
                        <<>>                               && 3 Default | Parameter file
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Conversion operation by type
                        <<>>PJX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>VCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>SCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>FRX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>LBX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>MNX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBC_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBF_Conversion_Support: 1      && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>FKY_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>MEM_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for pjx files
                        <<>>CheckFileInPath: 0             && Determines 2Txt deals with files not in the subfolders of the PJX. No handler for UNC paths.
                        <<>>                               && 0 Ignore. Default
                        <<>>                               && 1 Check and error out if file is not on same structure (for source control)
                        <<>>                               && 2 Create absolute path if file is on different drive.
                        <<>>                               && 3 Create absolute path if file is not in structure
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for container files (not pjx)
                        <<>>-- CLASS (, FORM and DBC) options (tx2 is to read as vc2 or sc2, VCX might be SCX)
                        <<>>-- FORM and DBC options default to this settings, if not set otherwise. See below.
                        <<>>- Class per file options (UseClassPerFile: 1)
                        <<>>UseClassPerFile: 0             && Determines how a library (or form) will handle included class (or, for forms, objects)
                        <<>>                               && 0 One library.tx2 file
                        <<>>                               && 1 Multiple file.class.tx2 files
                        <<>>                               && 2 Multiple file.baseclass.class.tx2 files
                        <<>>RedirectClassPerFileToMain: 0  && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to file.vcx/scx
                        <<>>                               && 1 Redirect to file.vcx/scx when selecting file[.baseclass].class.tx2
                        <<>>                               &&   RedirectClassType: 1 has precedence
                        <<>>RedirectClassType: 0           && For classes created with UseClassPerFile>0 in the form file[.baseclass].class.tx2
                        <<>>                               && Those files could be imported like file.tx2::Class::import or like file[.baseclass].class.tx2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect file[.baseclass].class.tx2 to file.VCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect file[.baseclass].class.tx2 to file[.baseclass].class.VCX and do not touch file.VCX
                        <<>>                               && 2 Redirect file[.baseclass].class.tx2 to file.VCX and do not touch other classes of file.VCX
                        <<>>ClassPerFileCheck: 0           && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check file[.baseclass].class.tx2 inclusion
                        <<>>                               &&   Only used if import file is in file[.baseclass].class.tx2 syntax
                        <<>>                               &&   Ignored for RedirectClassType: 2
                        <<>>UseClassPerDir: 0              && 0=flat file.class.ext layout (default)
                        <<>>                               && 1=store under file.ext/ subdirectory (requires UseClassPerFile>0)
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- FORM options
                        <<>>- Form per file options (UseFormSettings 1)
                        <<>>UseFormSettings: 0             && 1=Turns the File per SCX options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if UseFormSettings is set 1 before!
                        <<>>                               &&   If UseFormSettings is set 0 later, all setting will be lost
                        <<>>UseFormPerFile: 0              && Determines how a form will handle included objects
                        <<>>                               && 0 One Form.sc2 file
                        <<>>                               && 1 Multiple Form.Obj.sc2 files
                        <<>>                               && 2 Multiple Form.baseclass.Obj.sc2 files
                        <<>>RedirectFormPerFileToMain: 0   && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to Form.scx
                        <<>>                               && 1 Redirect to Form.scx when selecting Form[.baseclass].Obj.sc2
                        <<>>                               &&   RedirectFormType: 1 has precedence
                        <<>>RedirectFormType: 0            && For classes created with UseFormPerFile>0 in the form Form[.baseclass].Obj.sc2
                        <<>>                               && Those files could be imported like Form.sc2::Class::import or like Form[.baseclass].Obj.sc2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect Form[.baseclass].Obj.sc2 to Form[.baseclass].Obj.SCX and do not touch Form.SCX
                        <<>>                               && 2 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and do not touch other classes of Form.SCX
                        <<>>FormPerFileCheck: 0            && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check Form[.baseclass].Obj.sc2 inclusion
                        <<>>                               &&   Only used if import file is in Form[.baseclass].Obj.sc2 syntax
                        <<>>                               &&   Ignored for RedirectFormType: 2
                        <<>>UseFormPerDir: 0              && 0=flat Form.Obj.ext layout (default)
                        <<>>                               && 1=store under Form.ext/ subdirectory (requires UseFormPerFile>0)
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- DBC options
                        <<>>- File per DBC options (UseFilesPerDBC: 1)
                        <<>>OldFilesPerDBC: 0              && 1=Turns the File per DBC options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if OldFilesPerDBC is set 1 before!
                        <<>>                               &&   If OldFilesPerDBC is set 0 later, all setting will be lost
                        <<>>UseFilesPerDBC: 0              && 0=One database dc2 file, 1=Multiple file.*.*.dc2 files
                        <<>>                               && 0 creates only a file.dc2 with all DBC (file) data
                        <<>>                               && 1 creates a file.dc2 with DBC properties
                        <<>>                               &&   and additional DBC files per DBC item (stored-proc, table, ..)
                        <<>>                               &&   Note: recration only if RedirectFilePerDBCToMain is 1
                        <<>>RedirectFilePerDBCToMain: 0    && 0=Don't redirect to file.dc2, 1=Redirect to file.tx2 when selecting file.item.*.dc2
                        <<>>ItemPerDBCCheck: 0             && 0=Don't check file.item.*.dc2 inclusion, 1=Check file.item.*.dc2 inclusion
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- General files
                        <<>>NoTimestamps: 1                && Clear timestamps of several file types by default for minimize text-file differences
                        <<>>ClearUniqueID: 1               && 0=Keep UniqueID in text files, 1=Clear Unique ID. Useful for Diff and Merge
                        <<>>OptimizeByFilestamp: 0         && 1=Optimize file regeneration depending on file timestamp. Dangerous while working with branches!
                        <<>>RemoveNullCharsFromCode: 1     && 1=Drop .Null. chars from source code
                        <<>>ExportUTF8: 0                  && 0=Export text files in ANSI (current code page), 1=Export text files in UTF-8 (StrConv 9)
                        <<>>RemoveZOrderSetFromProps: 0    && 0=Do not remove ZOrderSet property from object, 1=Remove ZOrderSet property from object
                        <<>>PRG_Compat_Level: 0            && 0=Legacy, 1=Use HELPSTRING as Class Procedure comment
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- PJX special
                        <<>>BodyDevInfo: 0                 && 0=Don't keep DevInfo for body pjx records, 1=Keep DevInfo, 2 = Don't keep DevInfo or ObjRev
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Mirrored tree (exportProjectTree / importProjectTree only)
                        <<>>CopyNonConvertible: 0          && 0=Skip non-convertible PJX/PJ2 members, 1=Copy them into the mirrored tree as-is
                        <<>>CopyExcludedPjxFiles: 0        && 0=Skip PJX/PJ2 members marked Exclude (default), 1=Include them in export/import
                        <<>>ExcludedSubdirs:               && Semicolon-separated subpaths under project root to skip (not converted or copied)
                        <<>>                               && Example: tmp;backup;forms\old
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- DBF special
                        <<>>ClearDBFLastUpdate: 1          && 0=Keep DBF LastUpdate, 1=Clear DBF LastUpdate. Useful for Diff.
                        <<>>ExcludeDBFAutoincNextval: 0    && 0=Do not exclude this value from db2, 1=Exclude this value from db2
                        <<>>DBF_Conversion_Included: *     && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_Conversion_Excluded:       && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_BinChar_Base64: 1          && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform (default)
                        <<>>DBF_IncludeDeleted: 0          && 0=Do not include deleted records (default), 1=Include deleted records
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Text file extensions
                        <<>>extension: tx2=newext          && Specify extensions to use. Default FoxBin2Prg extensions ends in '2' (see at the bottom)
                        <<>>-- Example configuration for SourceSafe compatibility:
                        <<>>extension: pj2=pja             && Text file to PJX
                        <<>>extension: vc2=vca             && Text file to VCX
                        <<>>extension: sc2=sca             && Text file to SCX
                        <<>>extension: fr2=fra             && Text file to FRX
                        <<>>extension: lb2=lba             && Text file to LBX
                        <<>>extension: mn2=mna             && Text file to MNX
                        <<>>extension: db2=dba             && Text file to DBF
                        <<>>extension: dc2=dca             && Text file to DBC
                        <<>>-- Additional extensions
                        <<>>extension: fk2=fkx             && Text file to FKY
                        <<>>extension: me2=fkx             && Text file to MEM
                        <<>>
               ENDTEXT
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>-- Archivo de configuración individual para DBF (sintaxis: archivo.dbf.cfg) Defaults see FoxBin2prg.cfg
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>DBF_Conversion_Support: <1,2,4,8>           && Ver esta misma configuración más arriba
                        <<>>DBF_Conversion_Order: <c_Expression>        && Expresión de campo. ej: nombre+str(edad,3)
                        <<>>DBF_Conversion_Condition: <c_Expression>    && Expresión lógica. ej: edad > 10 AND NOT DELETED()
                        <<>>DBF_IndexList: <cFile_List>                 && comma delimited list of additonal non structural index files, cdx or idx
                        <<>>DBF_BinChar_Base64: <0,1>                   && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform
                        <<>>DBF_IncludeDeleted: <0,1>                   && 0=Do not include deleted records, 1=Include deleted records
                        <<>>
               ENDTEXT
               .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "¡FOXBIN2PRG es solo para Visual FoxPro 9.0!"
               .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "¡ATENCIÓN!"
               .C_GENERATED_FILE_SIZE_LOC                                      = "Tamaño del archivo generado"
               .C_GENERATING_BINARY_LOC                                        = "Generando Binario"
               .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "El Menú [<<THIS.c_InputFile>>] NO está en formato VFP 9! - Por favor convertirlo a VFP 9 con MODIFY MENU '<<THIS.c_InputFile>>'"
               .C_INCLUDING_CLASS_LOC                                          = "Incluyendo clase"
               .C_INCLUDING_MEMBER_LOC                                         = "Incluyendo miembro"
               .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Versión Incorrecta de VFP 9 - Falta el SP1! Esperado: 3504 o posterior, actual: " + Version(4)
               .C_INHERITING_FROM_LOC                                          = "Heredando desde"
               .C_INTERACTIVE_DIRECTORY_SELECTION_LOC                          = "Selección Interactiva de Directorio"
               .C_INVALID_PARAMETER_LOC                                        = "Parámetro inválido"
               .C_IS_A_FILE_LOC                                                = "es un ARCHIVO"
               .C_IS_A_DIRECTORY_LOC                                           = "es un DIRECTORIO"
               .C_IS_UNSUPPORTED_LOC                                           = "no está soportado"
               .C_LANGUAGE_LOC                                                 = "ES"
               .C_MAIN_EXECUTION_LOC                                           = "EJECUCIÓN PRINCIPAL"
               .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Se ha encontrado el programa de capitalización de nombres [<<lcEXE_CAPS>>]"
               .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* No se ha encontrado el programa de capitalización de nombres [<<lcEXE_CAPS>>]"
               .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Objeto [<<toObj.CLASS>>] no contiene el objeto oReg (nivel <<TRANSFORM(tnNivel)>>)"
               .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Operación no reconocida. Solo re reconoce SETNAME y GETNAME."
               .C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC             = "Optimización: saltando el archivo ya procesado [<<(lcFile)>>]"
               .C_OPTION_LOC                                                   = "Opción"
               .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "La clase externa no coincide con las clases internas"
               .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "El miembro externo no coincide con los miembros internos"
               .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimización: el archivo de salida [<<lcOutputFile>>] no se sobreescribe por ser igual al ya existente."
               .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimización: el archivo de salida [<<THIS.c_OutputFile>>] no se regenera por tener el mismo timestamp que el de entrada."
               .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimización: el archivo de salida [<<THIS.c_OutputFile>>] no se regenera por tener un timestamp más nuevo que el de entrada."
               .C_PRESS_ESC_TO_CANCEL                                          = "Pulse Esc para Cancelar"
               .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Procedimiento sin cerrar. La última línea de código debe ser ENDPROC. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
               .C_PROCESSING_LOC                                               = "Procesando archivo"
               .C_PROCESS_PROGRESS_LOC                                         = "Avance del proceso:"
               .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Propiedad [<<TRANSFORM(tnPropertyID)>>] no reconocida."
               .C_READING_CFG_VALUES_FROM_DISK_LOC                             = "LEYENDO VALORES DEL ARCHIVO CFG DEL DISCO"
               .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "El Reporte [<<THIS.c_InputFile>>] NO está en formato VFP 9! - Por favor convertirlo a VFP 9 con MODIFY REPORT '<<THIS.c_InputFile>>'"
               .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Solicitado capitalizar el archivo [<<tcFileName>>]"
               .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Escaneando archivos e información de directorio para"
               .C_SOURCEFILE_LOC                                               = "Archivo origen: "
               .C_SOURCESAFE_COMPATIBILITY_MODE_LOC                            = "Modo de Compatibilidad SourceSafe"
               .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Error de anidamiento de estructuras. Se esperaba ENDPROC pero se encontró ENDDEFINE en la clase <<toClase._Nombre>> (<<loProcedure._Nombre>>), línea <<TRANSFORM(m.I)>> del archivo <<THIS.c_InputFile>>"
               .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Error de anidamiento de estructuras. Se esperaba ENDPROC pero se encontró ENDDEFINE en la clase <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), línea <<TRANSFORM(m.I)>> del archivo <<THIS.c_InputFile>>"
               .C_UNKNOWN_CLASS_NAME_LOC                                       = "Clase [<<THIS.CLASS>>] desconocida"
               .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Usar Optimización de filestamp de archivo"
               .C_USING_THIS_SETTINGS_LOC                                      = "Usando esta configuración"
               .C_USING_THIS_SETTINGS_LOC1                                     = " BY PARAMETER, skipping all previous config!"
               .C_USING_THIS_SETTINGS_LOC2                                     = " Parsing of full configuration allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC3                                     = " Parsing configuration in parent~ and subdirectories allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC4                                     = " Parsing configuration in subdirectories allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC5                                     = " Parsing of other configuration not allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC6                                     = "External configuration file set: "
               .C_USING_THIS_SETTINGS_LOC7                                     = ", using cached config."
               .C_WARNING_LOC                                                  = "¡ATENCIÓN!"
               .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "¡ATENCIÓN!" + CR_LF+ "ASEGÚRESE DE QUE NO ESTÁ USANDO UN ALIAS DE TABLA EN LAS EXPRESIONES DE LOS ÍNDICES!! (ej: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag nombreclave)"
               .C_WITH_ERRORS_LOC                                              = "con errores"
               .C_LOCKINGFOLDER_LOC                                            = " found, proccessing directory and subdirectories inhibited."

               .C_INDEX2TXT_PROCESSING_LOC                                     = " Processing index"
               .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Additional index files"
               .C_INDEX2TXT_NOFILE_LOC                                         = "     Not a File "
               .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index does not match table "
               .C_INDEX2BIN_PROCESSING_LOC                                     = " Creating index"
               .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs for structural index"
               .C_INDEX2BIN_STANDALONE_LOC                                     = "  Standalone index "
               .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs for compound index "
               .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Main file "'
               .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Project icon file "'
               .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'File ""'
               .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'not in PJX folder structure, "'
               .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'check option "CheckFileInPath".' + CR_LF+CR_LF

            Case Inlist(tcLanguage, '49', 'DE') && German (Alemán)
               *-------------------------------------------------------------------------------------------------------------------------------------------
               *-- NOTE: ES MÜSSEN ANFÜHRUNGSZEICHEN BENUTZT WERDEN, ODER SYNTAX ERRORS PASSIEREN BEIM COMPILE. SELTSAM :(
               *-------------------------------------------------------------------------------------------------------------------------------------------
               .C_ALLOWED_VALUES_ARE_LOC                                       = "Erlaubte Werte sind"
               .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "Die Erweiterungen * und ? sind nicht erlaubt, da sie gefährlich sind (Binaries könnten mit xx2 leeren Dateien überschrieben werden)"
               .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Backlink kann nicht aktualisiert werden"
               .C_BACKLINK_OF_TABLE_LOC                                        = "von Tabelle"
               .C_BACKUP_OF_LOC                                                = "Erzeuge Backup von: "
               .C_CACHING_CONFIG_FOR_DIRECTORY_LOC                             = "Caching Konfiguration für Verzeichnis"
               .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Kann Datei [<<THIS.c_OutputFile>>] nicht generieren, da sie schreibgeschützt ist"
               .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimierung: Grund Datei [<<JUSTFNAME(.c_InputFile)>>] Schon verarbeitet, das Überspringen Verarbeitung der Datei [<<tc_InputFile>>]"
               .C_CONFIGFILE_LOC                                               = "Benutzte Konfigurationsdatei:"
               .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Konvertierung durch den Benutzer abgebrochen"
               .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "alle Dateien in einem Projekt zu konvertieren"
               .C_CONVERT_FOLDER_LOC                                           = "Konvertieren Verzeichnis"
               .C_BINARY_TO_TEXT_LOC                                           = "Binär zu Text"
               .C_TEXT_TO_BINARY_LOC                                           = "Text zu Binär"
               .C_CONVERT_FOLDER_NONE_LOC                                      = "Nichts"
               .C_CONVERT_FOLDER_QUESTION_LOC                                  = "Welche Umwandlung sollte sich auf die Dateien dieses Verzeichnis durchgeführt werden?"
               .C_CONVERTER_UNLOAD_LOC                                         = "Konverter wird entladen"
               .C_CONVERTING_FILE_LOC                                          = "Konvertiere Datei"
               .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Datenfehler: Keine Analyse möglich, da ungepaarte Anführungszeichen in Zeile <<lcMetadatos>> sind."
               .C_DUPLICATED_FILE_LOC                                          = "Doppelte Datei"
               .C_DUPLICATED_OBJECT_LOC                                        = "Doppelte Objekt"
               .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "Kann keinen Ende Marker [ENDDEFINE] in Zeile <<TRANSFORM( toClase._Inicio )>> für die ID [<<toClase._Nombre>>] finden"
               .C_END_MARKER_NOT_FOUND_LOC                                     = "Kann keinen Ende Marker [<<ta_ID_Bloques(lnPrimerID,2)>>] welcher den Start Marker [<<ta_ID_Bloques(lnPrimerID,1)>>] in Zeile <<TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))>> schließt"
               .C_END_OF_PROCESS_LOC                                           = "Ende des Prozesses"
               .C_ERROR_LOC                                                    = "FEHLER"
               .C_ERRORS_FOUND_IN_FILE_LOC                                     = "FEHLER IN FILE GEFUNDEN"
               .C_EXTENSION_RECONFIGURATION_LOC                                = "Neukonfiguration der Erweiterungen:"     &&wir wollen es mal nicht übertreiben, mit den zusammengesetzten Substantiven
               .C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC        = "Die Anzahl externee Klassen (<< toModulo._ExternalClasses_Count >>) entspricht nicht der der gefunden Klassen (<< toModulo._Clases_Count >>), Datei: [<< toFoxBin2Prg.c_InputFile >>]"
               .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "Keine externe Klasse gefunden"
               .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "Externe Mitglied wurde nicht gefunden"
               .C_EXTERNAL_PARAMETERS_LOC                                      = "EXTERNE PARAMETER"
               .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Feld [<<laProps(m.I)>>] nicht in der Struktur von Datei <<DBF('TABLABIN')>> gefunden"
               .C_FILE_DOESNT_EXIST_LOC                                        = "Datei existiert nicht:"
               .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "Datei [<<.c_InputFile>>] wird nicht unterstützt"
               .C_FILE_NOT_FOUND_LOC                                           = "Datei nicht gefunden"
               .C_FILENAME_LOC                                                 = "Datei"
               .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "FEHLER"
               .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "SYNTAX UND PARAMETER INFORMATION"
               .C_ClassTwice_Header_LOC                                        = CR_LF+"Klasse doppelt deklariert."+CR_LF
               .C_ClassTwice_Lib_LOC                                           = CR_LF+"Bibliothek: "
               .C_ClassTwice_Class_LOC                                         = CR_LF+"Klasse: "
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FoxBin2Prg Home Page and download: https://github.com/fdbozzo/foxbin2prg/wiki  -  Fernando D. Bozzo (2013.11.25)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>FOXBIN2PRG.EXE <cFileSpec.Ext> [cType [cTextName [cGenText [cDontShowErrors [cDebug [cDontShowProgress [cOriginalFileName [cRecompile [cNoTimestamps [cCFG_File [cOutputFolder] ] ] ] ] ] ] ] ] ] ]
                        <<>>
                        <<>>-- Parameter:
                        <<>>cFileSpec.Ext:     ? | interactive Diese Hilfe
                        <<>>                   Vollständiger Name der Datei (mit Pfad) zum Konvertieren, oder das Verzeichnis zum Konvertieren
                        <<>>                    - wenn 'BIN2PRG' spezifiziert ist, wird das Verzeichnis in cType (!!) zum Erstellen der Textdateien genutzt
                        <<>>                    - wenn 'PRG2BIN' spezifiziert ist, wird das Verzeichnis in cType (!!) zum Erstellen der Binärdateien genutzt
                        <<>>                    - Im SCCAPI (VSS) Kompatibilitätsmodus, wird dies zur Abfrage der Unterstützung der Umwandlung für den genannten Dateityp genutzt
                        <<>>                      VSS Types: d=DBC, D=DBF, K=Form, B=Label, M=Menu, R=Report, V=Class
                        <<>>cType:             Im SCCAPI (VSS) Kompatibilitätsmodus wird hier der Dateityp der Input-Datei festgelegt
                        <<>>                    - Wird hier '*' oder '*-' angegeben, und tc_InputFile ist ein PJX, werden alle Dateien im PJX konvertiert
                        <<>>cTextName:         Text Dateiname. Nur im SCCAPI (VSS) Kompatibilitätsmodus.
                        <<>>lGenText:          .T.=Erzeuge Text, .F.=Erzeuge Binary. Nur im SCCAPI (VSS) Kompatibilitätsmodus.
                        <<>>cDontShowErrors:   '1' Unterdrückt die Anzeige von Fehlern
                        <<>>cDebug:            '1' Erzeugt LOG Dateien, hält bei Fehlern an
                        <<>>cDontShowProgress: '1' Zeige kein Fortschrittsfenster
                        <<>>cOriginalFileName: Falls als Inputdatei eine temporäre Datei genutzt wird, kann hier für den Kopf der Textdatei der richtige Name angegeben werden.
                        <<>>cRecompile:        '1' Die erzeugten Binädateien werden nach dem Erzeugen kompiliert. Eine Pfadangabe (d.h., die des Projektes) ist möglich.
                        <<>>cNoTimestamps:     Legt fest ob der Zeitstempel einiger Dateiarten gelöscht werden soll ('1' oder leer) oder nicht ('0')
                        <<>>cCFG_File:         Legt eine alternative Konfigurationsdatei (CFG) fest, die als Standard statt der im foxbin2prg Verzeichnis genutzt werden soll.
                        <<>>cOutputFolder:     Der Ordner in die die Ausgabedatei geschrieben werden soll. Wenn nicht angegeben, das Verzeichnis der Quelle.
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE c|C|t [OutFileName [ cCFG_File[ cDebug]]]
                        <<>>DO FOXBIN2PRG.EXE WITH -c|-C|-t [, OutFileName [, cCFG_File[, cDebug]]]
                        <<>>
                        <<>>-- Parameter:
                        <<>>Keine Parameter:   Startet dieses Formular
                        <<>>-c (c)             Erzeugt eine Vorlage <OutFileName> für eine Config-Datei (wie FOXBIN2PRG.CFG)
                        <<>>-C (C)             Erzeugt eine  Config-Datei <OutFileName>  (wie FOXBIN2PRG.CFG) mit den aktuellen Optionen des Pfades von <OutFileName>
                        <<>>                   Wird OutFileName nicht angegeben, so wird eine Konfigurationsdatei FoxBin2Prg._cfg angelegt.
                        <<>>-t (t)             Erzeugt eine Vorlage <OutFileName> für eine Tabellen-Config-Datei (wie <Tabellenname>.dbf.cfg)
                        <<>>                   Wird OutFileName nicht angegeben und ist eine Tabelle offen,
                        <<>>                   so wird eine Konfigurationsdatei <Tabellenname>.dbf._cfg im Verzeichnis der Tabelle angelegt.
                        <<>>cCFG_File:         Legt eine alternative Konfigurationsdatei (CFG) fest, die als Standard statt der im foxbin2prg Verzeichnis genutzt werden soll.
                        <<>>cDebug:            '1' Erzeugt LOG Dateien, hält bei Fehlern an
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE VERNO
                        <<>>DO FOXBIN2PRG.EXE WITH "VERNO"|cPara
                        <<>>
                        <<>>-- Parameter:
                        <<>>-VERNO (VERNO) Return version number of FoxBin2Prg
                        <<>>cPara          A Ein Parameter mit dem Wert "VERNO", der Rückgabewert des Parameters die Versionsnummer
                        <<>>
                        <<>>
               ENDTEXT
               *** DH 2021-03-04: added HomeDir to text
               .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 = "*Optionen für Verzeichnis <<.c_Recompile>>, gelesen am <<DATETIME() gelesen.>>"
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FOXBIN2PRG.CFG Konfigurations-Optionen: (Wird die Option nicht aufgeführt, ist der Wert im Beispiel der Default)
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>> Achtung, die Konfigurationsdateien werden vererbt.
                        <<>> 1.  Defaultwerte
                        <<>> 2., optional FOXBIN2PRG.CFG im Vereichnis aus dem FOXBIN2PRG.EXE startet
                        <<>>   Oder, wenn definiert, eine Konfigurationsdatei die per Parameter an FOXBIN2PRG übergeben wurde.
                        <<>>       Wird diese genutzt, steuert die Einstellung InhibitInheritance, ob folgende Konfigurationsdateien ausgewertet werden.  (default)
                        <<>> 3., optional FOXBIN2PRG.CFG in der Wurzel des Arbeitsverzeichnises
                        <<>> 4., optional FOXBIN2PRG.CFG in jedem Verzeichnis bis zum Arbeitsverzeichnis
                        <<>> 5., optional Es können spezielle Einstellungen für einzelne DBF's erzeugt werden (Syntax: <TableName>.dbf.cfg im Verzeichnis der Tabelle)
                        <<>>
                        <<>> Einige Parameter im Aufruf von FOXBIN2PRG.EXE übersteueren diese Vorgaben (bis auf die Defaults)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>Interne Einstellungen
                        <<>>Language: (auto)               && Sprache für Anzeigen und Logs. EN=English, FR=Français, ES=Español, DE=Deutsch, Nicht definiert = Automatisch [DEFAULT]
                        <<>>ShowProgressbar: 1             && 0=Zeige Fortschrittsfenster, 1=Zeige es nicht, 2=Zeige Fortschrittsfenster nur, wenn mehrere Dateien konvertiert werden.
                        <<>>DontShowErrors: 0              && 0=Zeige Fehler an, 1=Zeige keine Fehler an
                        <<>>ExtraBackupLevels: 1           && Anzahl der Backup-Ebenen der Binärdateien 0=kein Backup, 1=<Datei>.BAK, n>1= n-Backup-Ebenen, <Datei>.n.BAK
                        <<>>Debug: 0                       && 0=Individuelles Logging ist aus
                        <<>>                               && 1=Individuelles Log per Datei <Datei>.Log
                        <<>>                               && 2=???
                        <<>>                               && Nur gültig, wenn nicht durch einen Parameter übersteuert
                        <<>>BackgroundImage: <cFile>       && Hintergrundbild für das Formular zur Fortschrittsanzeige.
                        <<>>                               && Leer erzeugt kein Hintergrundbild. Wird die Datei nicht gefunden, wird der Standardhintergrund verwendet.
                        <<>>HomeDir: 1                     && Speichern der HomeDir Eigenschaft in die PJX
                        <<>>                               && 0 Die Eigenschaft HomeDir wird nicht in die PJ2 gespeichert
                        <<>>                               && 1 Die Eigenschaft wird gespeichert
                        <<>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        <<>>-- Settings for config file via parameter only
                        <<>>InhibitInheritance: 0          && 0=Alle Konfiguration wird gelesen (Die Datei aus dem Parameter ist nur ein zusätzlicher default)
                        <<>>                               && 1=Nur die Vererbung in den Verezeichnissen , Im Verzeichnis der Konfiguration und Unterverzeichnisse werden gelesen
                        <<>>                               && 2=Nur die Konfiguration des Veruzeichnisses der Parameterdatei und Unterverzeichnisse werden gelesen
                        <<>>                               && 3=Keine weiter Konfiguration wird gelesen
                        <<>>                               && This is like
                        <<>>                               && 0 Default | Parameter Datei | Konfiguration im Programmverzeichnis von FoxBin2Prg | Alle anderen Konfigurationen
                        <<>>                               && 1 Default | Parameter Datei | Vererbung bis zum Verzeichnis der Parameter Datei | Das Verzeichnis und Unterverzeichnise der Parameter Datei
                        <<>>                               && 2 Default | Parameter Datei | Das Verzeichnis und Unterverzeichnise der Parameter Datei
                        <<>>                               && 3 Default | Parameter Datei

                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Konvertierungs Optionen:
                        <<>>PJX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>VCX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>SCX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>FRX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>LBX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>MNX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>DBC_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>DBF_Conversion_Support: 1      && 0=Aus
                        <<>>                               && 1=Erzeuge Textdatei nur für Struktur (Diff)
                        <<>>                               && 2=Erzeuge Text- und Binärdatei nur für Struktur (Merge)
                        <<>>                               && 4=Erzeuge Textdatei nur für Struktur und Daten (Diff)
                        <<>>                               && 8=Erzeuge Text- und Binärdatei nur für Struktur und Daten (Merge)
                        <<>>FKY_Conversion_Support: 1      && 0=Aus, 1=Erzeuge nur Textdatei (Diff)
                        <<>>MEM_Conversion_Support: 1      && 0=Aus, 1=Erzeuge nur Textdatei (Diff)
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for pjx files
                        <<>>CheckFileInPath: 0             && Bestimmt, ob bein Erstellen von pj2 Dateien Dateien in der ordnerstruktur des PJX sein müssen.
                        <<>>                               && Keine Behandlung für UNC Pfade.
                        <<>>                               && 0 Ignorieren. Default
                        <<>>                               && 1 Teste, und breche ab wenn die Datei nicht in der Struktur ist (für Quellcodeverwaltung)
                        <<>>                               && 2 Erstelle absoluten Pfad für Dateien auf einem anderen Laufwerk.
                        <<>>                               && 3 Erstelle absoluten Pfad für Dateien die nicht in der Ordnerstruktur sind.
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>> ------Einstellungen für Container-Dateien (nicht pjx)
                        <<>>-- Optionen für CLASS und FORM
                        <<>>-- CLASS (, FORM und DBC) Einstellungen (tx2 versteht sich als vc2 oder sc2, VCX kann auch SCX meinen)
                        <<>>-- FORM und DBC Einstellungen nutzen die folgenden Werte, solange nicht anders definiert. Siehe unten.
                        <<>>- Optionen für Datei per Klasse ( 1) (für VCX: vc2, für SCX: sc2)
                        <<>>UseClassPerFile: 0             && Bestimmt wie die Klassen einer Bibliothek oder die Objekte eines Formulars behandelt werden
                        <<>>                               && 0 Eine Textdatei pro VCX/SCX
                        <<>>                               && 1 Mehrere Dateien <Dateiname>.KlassenName.vc2
                        <<>>                               && 2 Mehrere Dateien <Dateiname>.Basisklasse.KlassenName.vc2
                        <<>>                               &&   Für 1, 2 wird jeweils auch ein Headerdatei <Dateiname>.vc2 erzeugt
                        <<>>RedirectClassPerFileToMain: 0  && Bestimmt beim Erzeugen von Binardateien für Klassenbibliotheken und Formulare die Zieldatei
                        <<>>                               && 0 Keine Umlenkung
                        <<>>                               && 1 Klassen (und Objekte) werden in die VCX/SCX geschrieben wenn eine Datei <Dateiname>[.Basisklasse].KlassenName.tx2 gewählt wurde
                        <<>>                               &&   RedirectClassType: 1 hat Vorrang
                        <<>>RedirectClassType: 0           && Für Textdateien die mit UseClassPerFile>0 in der Form <Dateiname>[.Basisklasse].KlassenName.tx2 erstellt wurden.
                        <<>>                               && diese Dateien können als Dateiname.tx2::KlassenName::import oder als <Dateiname>[.Basisklasse].KlassenName.tx2 importiert werden.
                        <<>>                               && Für die zweite Form gilt (jeweils VCX oder SCX ):
                        <<>>                               && 0 Aus <Dateiname>[.Basisklasse].KlassenName.tx2 wird <Dateiname>.VCX und alle Klassen dieser Bibliothek werden neu gelesen
                        <<>>                               && 1 Aus <Dateiname>[.Basisklasse].KlassenName.tx2 wird <Dateiname>[.Basisklasse].KlassenName.VCX, die Bibliothek file.VCX wird ignoriert
                        <<>>                               && 2 Aus <Dateiname>[.Basisklasse].KlassenName.tx2 wird <Dateiname>.VCX aber alle anderen Klassen bleiben unverändert
                        <<>>ClassPerFileCheck: 0           && Test, ob Dateien die in der Basisdatei definert wurden, einbezogen wurden.
                        <<>>                               && 0 Kein Test
                        <<>>                               && 1 Teste, ob die Datei <Dateiname>[.Basisklasse].KlassenName.tx2 einbezogen wurde
                        <<>>                               &&   Nur für die <Dateiname>[.Basisklasse].KlassenName.tx2 Syntax
                        <<>>                               &&   Wird für RedirectClassType: 2 ignoriert
                        <<>>UseClassPerDir: 0              && 0=flaches file.class.ext Layout (Standard)
                        <<>>                               && 1=unter file.ext/ Unterverzeichnis speichern (erfordert UseClassPerFile>0)
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- Optionen für FORM
                        <<>>- Optionen für Datei per Form (UseFormPerFile: 1)
                        <<>>UseFormSettings: 0             && 1=Die unten stehenden Form Optionen werden aktiviert, 0=Die UseClassPerFile Einstellungen werden genutzt.
                        <<>>                               &&   Die unten stehenden Optionen werden nur gelesen, wenn UseFormSettings vorher 1 ist!
                        <<>>                               &&   Wird UseFormSettings wieder auf 0 gesetzt, gehen diese Einstellungen verloren.
                        <<>>UseFormPerFile: 0              && Bestimmt wie die Objekte eines Formulars behandelt werden
                        <<>>                               && 0 Eine Textdatei Form.sc2  pro SCX
                        <<>>                               && 1 Mehrere Dateien Form.Obj.sc2 pro SCX
                        <<>>                               && 2 Mehrere Dateien Form.baseclass.Obj.sc2 pro SCX
                        <<>>                               && Für 1, 2 wird jeweils auch ein Headerdatei <Form>.sc2 erzeugt
                        <<>>RedirectFormPerFileToMain: 0   && Bestimmt beim Erzeugen von Binardateien für Formulare die Zieldatei
                        <<>>                               && 0 Keine Umlenkung
                        <<>>                               && 1 Objekte werden in die SCX geschrieben wenn eine Datei Form.sc2 when selecting Form[.baseclass].Obj.sc2 gewählt wurde
                        <<>>                               &&   RedirectFormType: 1 1 hat Vorrang
                        <<>>RedirectFormType: 0            && Für Textdateien die mit UseFormPerFile>0 in der Form Form[.baseclass].Obj.sc2 erstellt wurden.
                        <<>>                               && diese Dateien können als Form.sc2::Class::import oder als Form[.baseclass].Obj.sc2 importiert werden.
                        <<>>                               && Für die zweite Form gilt (jeweils VCX oder SCX ):
                        <<>>                               && 0 Aus Form[.baseclass].Obj.sc2 wird Form.SCX und alle Klassen dieser Bibliothek werden neu gelesen
                        <<>>                               && 1 Aus Form[.baseclass].Obj.sc2 wird Form[.baseclass].Obj.SCX, die Bibliothek file.VCX wird ignoriert
                        <<>>                               && 2 Aus Form[.baseclass].Obj.sc2 wird Form.SCX aber alle anderen Klassen bleiben unverändert
                        <<>>FormPerFileCheck: 0            && Test, ob Dateien die in der Basisdatei definert wurden, einbezogen wurden.
                        <<>>                               && 0 Kein Test
                        <<>>                               && 1 Teste, ob die Datei Form[.baseclass].Obj.sc2 einbezogen wurde
                        <<>>                               &&   Nur für die  Form[.baseclass].Obj.sc2 Syntax
                        <<>>                               &&   Wird für RedirectFormType: 2 ignoriert
                        <<>>UseFormPerDir: 0              && 0=flaches Form.Obj.ext Layout (Standard)
                        <<>>                               && 1=unter Form.ext/ Unterverzeichnis speichern (erfordert UseFormPerFile>0)
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- Optionen für DBC
                        <<>>- Optionen für Datei per DBC (UseFilesPerDBC: 1)
                        <<>>OldFilesPerDBC: 0              && 1=Die unten stehenden DBC Optionen werden aktiviert, 0=Die UseClassPerFile Einstellungen werden genutzt.
                        <<>>                               &&   Die unten stehenden Optionen werden nur gelesen, wenn OldFilesPerDBC vorher 1 ist!
                        <<>>                               &&   Wird OldFilesPerDBC wieder auf 0 gesetzt, gehen diese Einstellungen verloren.
                        <<>>UseFilesPerDBC: 0              && 0=Erzeuge eine dc2 Datei, 1=Erzeuge mehrfache Dateien.*.*.dc2
                        <<>>                               && 0 Erzeugt eine Datei <Datenbank>.db2 mit allem Inhalt der DBC
                        <<>>                               && 1 Erzeugt eine Datei <Datenbank>.dc2 mit den Eigenschaften der Datenbank
                        <<>>                               &&   und zusätzlich eine Datei für jedes Item der Datenbank (Gespeicherte Prozeduren, Tabellen, Views, ..)
                        <<>>                               &&   Achtung! Diese Dateien werden nur dann in die Binädatei einbezogen, wenn RedirectFilePerDBCToMain 1 ist
                        <<>>RedirectFilePerDBCToMain: 0    && Originale Dokumentation: 0=Keine Umlenkung, 1=Erzeuge <Datenbank>.dbc, wenn <Datenbank>.item.*.dc2 gewählt wurde
                        <<>>                               &&   Die Binär-Datenbank wird nur dann automatisch zusammen gefügt, wenn diese Option 1 ist!
                        <<>>ItemPerDBCCheck: 0             && 0=Aus, 1=Teste, ob <Datenbank>.item.*.dc2 einbezogen wird.
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Allgemeine Dateien
                        <<>>NoTimestamps: 1                && 0=Zeitstempel einiger Dateiarten werden nicht gelöscht 1=Zeitstempel werden zum Minimieren der Text-Datei-Unterschiede gelöscht
                        <<>>ClearUniqueID: 1               && 0=Erhalte die Unique ID in den Text-Dateien, 1=Lösche Unique ID. Nützlich für Diff und Merge
                        <<>>OptimizeByFilestamp: 0         && 0=Aus, 1=Optimierte Erzeugung der Binärdateien in Abhängigkeit vom Zeitstempel. Gefährlich beim Arbeiten mit Zweigen!
                        <<>>RemoveNullCharsFromCode: 1     && 0=Aus 1=Lösche .Null. (CHR(0)) Zeichen aus dem Quellcode
                        <<>>ExportUTF8: 0                  && 0=Textdateien in ANSI (aktuelle Codepage), 1=Textdateien in UTF-8 exportieren (StrConv 9)
                        <<>>RemoveZOrderSetFromProps: 0    && 0=Aus, 1=Entferne ZOrderSet Eigenschaft von Objekten
                        <<>>PRG_Compat_Level: 0            && 0=Legacy, 1=Nutze HELPSTRING als Class Procedure Kommentar
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- speziell PJX
                        <<>>BodyDevInfo: 0                 && 0=DevInfo im body-pjx-Datensatz wird nicht erhalten], 1=DevInfo wird erhalten
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Gespiegelter Baum (nur exportProjectTree / importProjectTree)
                        <<>>CopyNonConvertible: 0          && 0=Nicht konvertierbare PJX/PJ2-Mitglieder überspringen, 1=Unverändert in den Spiegel kopieren
                        <<>>CopyExcludedPjxFiles: 0        && 0=PJX/PJ2-Mitglieder mit Exclude überspringen (Standard), 1=In Export/Import einbeziehen
                        <<>>ExcludedSubdirs:               && Unterpfade unter der Projektwurzel, getrennt durch ; — weder konvertieren noch kopieren
                        <<>>                               && Beispiel: tmp;backup;forms\old
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- speziell DBF
                        <<>>ClearDBFLastUpdate: 1          && 0=Erhalte DBF LastUpdate, 1=Lösche DBF LastUpdate. Nützlich für Diff und Merge
                        <<>>ExcludeDBFAutoincNextval: 0    && 0=Aus, 1=Entferne diesen Wert aus der Textdate der Datenbank (db2)
                        <<>>DBF_Conversion_Included: *     && Für DBF_Conversion_Support: 4 kann eine mehrfache Dateimaske zum Einbeziehen angegeben werden, z.B.: www,fb2p_free.dbf
                        <<>>                               && *=Alle, Die Maske darf Wildcards (*,?) enthalten
                        <<>>                               &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>DBF_Conversion_Excluded:       && Für DBF_Conversion_Support: 4 kann eine mehrfache Dateimaske zum Ausschließen angegeben werden, z.B.: www,fb2p_free.dbf
                        <<>>                               && Leer=Keine Datei auschließen
                        <<>>DBF_BinChar_Base64: 1          && Für Felder mit Zeichen Typ (C,V,M), wenn NoCPTrans, dann 0=nicht transform,ieren, 1=Führe Base64 Transformation aus (default)
                        <<>>                               &&   Dies entspricht dem Flag 4096 in CursorToXML()
                        <<>>                               &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>DBF_IncludeDeleted: 0          && 0=Ohne gelöschte Datensätze (default), 1=Mit gelöschten Datensätzen
                        <<>>                               &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Text-Datei Endungen
                        <<>>extension: tx2=newext          && Umdefinition der Dateiendung der Textdateien. Die vordefinierten Endungen enden mit '2' (Beispiel siehe Ende dieser Datei)
                        <<>>-- Beispiel für geänderte Textdatei Endungen, hier für SourceSafe Kompatibiltät:
                        <<>>extension: pj2=pja             && Text Datei für PJX
                        <<>>extension: vc2=vca             && Text Datei für VCX
                        <<>>extension: sc2=sca             && Text Datei für SCX
                        <<>>extension: fr2=fra             && Text Datei für FRX
                        <<>>extension: lb2=lba             && Text Datei für LBX
                        <<>>extension: mn2=mna             && Text Datei für MNX
                        <<>>extension: db2=dba             && Text Datei für DBF
                        <<>>extension: dc2=dca             && Text Datei für DBC
                        <<>>-- Zusätzliche Endungen
                        <<>>extension: fk2=fkx             && Text Datei für FKY
                        <<>>extension: me2=fkx             && Text Datei für MEM
                        <<>>
               ENDTEXT
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>-- Individuelle DBF Konfigurations-Datei (Syntax: <Tabellenname>.dbf.cfg im Verzeichnis der Tabelle) Defaults siehe FoxBin2prg.cfg
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>DBF_Conversion_Support: <1,2,4,8>           && 0=Aus
                        <<>>                                            && 1=Erzeuge Textdatei nur für Struktur (Diff)
                        <<>>                                            && 2=Erzeuge Text- und Binärdatei nur für Struktur (Merge)
                        <<>>                                            && 4=Erzeuge Textdatei nur für Struktur und Daten (Diff)
                        <<>>                                            && 8=Erzeuge Text- und Binärdatei nur für Struktur und Daten (Merge)
                        <<>>DBF_Conversion_Order: <c_Expression>        && Optional, Reihenfolge der Datensätze. Ausdruck für INDEX ON. ie: name+str(age,3)
                        <<>>                                            && leer: normale Reihenfolge
                        <<>>DBF_Conversion_Condition: <c_Expression>    && Optional, Ausdruck für SELECT FOR. ie: age > 10 AND NOT DELETED()
                        <<>>                                            && leer: Alle, außer DBF_IncludeDeleted
                        <<>>DBF_IndexList: <cFile_List>                 && Kommagetrennte Liste von Dateien. Zusätzliche Index - Dateien. CDX oder IDX. Nicht der Strukturelle Index
                        <<>>DBF_BinChar_Base64: <0,1>                   && Für Felder mit Zeichen Typ (C,V,M), wenn NoCPTrans, dann 0=nicht transform,ieren, 1=Führe Base64 Transformation aus
                        <<>>                                            &&   Dies entspricht dem Flag 4096 in CursorToXML()
                        <<>>                                            &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>DBF_IncludeDeleted: <0,1>                   && 0=Ohne gelöschte Datensätze, 1=Mit gelöschten Datensätzen
                        <<>>                                            &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>
               ENDTEXT
               .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG arbeitet nur für Visual FoxPro 9.0!"
               .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "WARNUNG!"
               .C_GENERATED_FILE_SIZE_LOC                                      = "Generierte Dateigröße"
               .C_GENERATING_BINARY_LOC                                        = "Gene Binary"
               .C_INCLUDING_CLASS_LOC                                          = "einschließlich Klasse"
               .C_INCLUDING_MEMBER_LOC                                         = "inklusive Mitglied"
               .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Quell-Kompatibilitäts-Mode Incorrect VFP 9 Version - Fehlende SP1! Erwartet: 3504 oder größer, aktuell:" + Version(4)
               .C_INHERITING_FROM_LOC                                          = "Ererbt von"
               .C_INTERACTIVE_DIRECTORY_SELECTION_LOC                          = "Interaktives Auswählen des Verzeichnises"
               .C_INVALID_PARAMETER_LOC                                        = "Ungültige Parameter"
               .C_IS_A_FILE_LOC                                                = "ist eine DATEI"
               .C_IS_A_DIRECTORY_LOC                                           = "ist ein VERZEICHNIS"
               .C_IS_UNSUPPORTED_LOC                                           = "wird nicht unterstützt"
               .C_LANGUAGE_LOC                                                 = "DE"
               .C_MAIN_EXECUTION_LOC                                           = "HAUPTAUSFÜHRUNG"
               .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "Menü [<<THIS.c_InputFile>>] ist NICHT im VFP 9 Format! - Bitte zuerst mit MODIFY MENU '<<THIS.c_InputFile>>' nach VFP 9 konvertieren."
               .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Programm für Großschreibungssetzung [<<lcEXE_CAPS>>] gefunden"
               .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* Programm für Großschreibungssetzung [<<lcEXE_CAPS>>] nicht gefunden"
               .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Objekt [<<toObj.CLASS>>] enthält nicht das oReg Objekt (level <<TRANSFORM(tnNivel)>>)"
               .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Befehl nicht erkannt. Nur SETNAME und GETNAME erlaubt."
               .C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC             = "Optimierung: Überspringen von bereits bearbeiteten Datei [<<(lcFile)>>]"
               .C_OPTION_LOC                                                   = "Option"
               .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "Die äußere Klasse zeigt nicht die die innere Klassifizierung an"
               .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "Das äußere Element entspricht nicht den inneren Elementen"
               .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimierung: Ausgabedatei [<<lcOutputFile>>] wurde nicht überschrieben, da sie dieselbe ist wie die neu generierte."
               .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimierung: Ausgabedatei [<<THIS.c_OutputFile>>] wurde nicht verlängert, weil ihre Zeitmarke die gleiche der Quelldatei ist."
               .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimierung: Ausgabedatei [<<THIS.c_OutputFile>>] wurde nicht erneuert, da sie neuer als die Ursprungsdatei ist."
               .C_PRESS_ESC_TO_CANCEL                                          = "Drücken Sie Esc zum Abbrechen"
               .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Prozedur nicht geschlossen. Letzte Zeile des Codes muss ENDPROC sein. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
               .C_PROCESSING_LOC                                               = "Bearbeite Datei"
               .C_PROCESS_PROGRESS_LOC                                         = "Bearbeitungsfortschritt:"
               .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Eigenschaft [<<TRANSFORM(tnPropertyID)>>] nicht erkannt."
               .C_READING_CFG_VALUES_FROM_DISK_LOC                             = "Von der Festplatte gelesene Werte der CFG-DATEI"
               .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Report [<<THIS.c_InputFile>>] ist NICHT in VFP 9 Format! - Bitte zuerst nach VFP 9 konvertieren mit MODIFY REPORT '<<THIS.c_InputFile>>'"
               .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Fordere Großschreibung für Datei [<<tcFileName>>] an"
               .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Scanne Datei- und Verzeichnisinformationen für"
               .C_SOURCEFILE_LOC                                               = "Quell Datei: "
               .C_SOURCESAFE_COMPATIBILITY_MODE_LOC                            = "Sourcesafe-Kompatibilitätsmodus"
               .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Fehler in Verschachtelungsstruktur. ENDPROC erwartet, aber es wurde ENDDEFINE in Klasse <<toClase._Nombre>> (<<loProcedure._Nombre>>), Zeile <<TRANSFORM(m.I)>> der Datei <<THIS.c_InputFile>> gefunden"
               .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Fehler in Verschachtelungsstruktur. ENDPROC wurde erwartet, aber es wurde ENDDEFINE in Klasse <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), Zeile <<TRANSFORM(m.I)>> der Datei <<THIS.c_InputFile>> gefunden"
               .C_UNKNOWN_CLASS_NAME_LOC                                       = "Unbekannte Klasse [<<THIS.CLASS>>]"
               .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Verwenden Sie die Datei-Zeitstempel-Optimierung"
               .C_USING_THIS_SETTINGS_LOC                                      = "Mit dieser Einstellung"
               .C_USING_THIS_SETTINGS_LOC1                                     = " BY PARAMETER, alle vorherigen Einstellungen werden zurückgesetzt!"
               .C_USING_THIS_SETTINGS_LOC2                                     = " Komplette Auswertung der Konfiguration gestattet."+CR_LF
               .C_USING_THIS_SETTINGS_LOC3                                     = " Konfigurationsdateien von Unterverzeichnissen und ererbete Konfigurationen aus dem Baum werden ausgewertet."+CR_LF
               .C_USING_THIS_SETTINGS_LOC4                                     = " Konfigurationsdateien von Unterverzeichnissen werden ausgewertet."+CR_LF
               .C_USING_THIS_SETTINGS_LOC5                                     = " Es werden keine anderen Konfigurationsdateien gelesen."+CR_LF
               .C_USING_THIS_SETTINGS_LOC6                                     = "Externe Konfigurationsdatei übergeben: "
               .C_USING_THIS_SETTINGS_LOC7                                     = ", nutze gespeicherte Konfiguration."
               .C_WARNING_LOC                                                  = "WARNUNG!"
               .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "WARNUNG!" + CR_LF+ "STELLEN SIE SICHER, DAS KEIN TABELLENALIAS IM INDEXAUSDRUCK BENUTZT WIRD!! (z.B.: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
               .C_WITH_ERRORS_LOC                                              = "mit Fehlern"
               .C_LOCKINGFOLDER_LOC                                            = " gefunden, das Verzeichnis und Unterverzeichnisse werden ignoriert."

               .C_INDEX2TXT_PROCESSING_LOC                                     = " Ermittle Index"
               .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Zusätzliche Index Dateien"
               .C_INDEX2TXT_NOFILE_LOC                                         = "     Keine Datei "
               .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index passt nicht zur Tabelle "
               .C_INDEX2BIN_PROCESSING_LOC                                     = " Erstelle Index"
               .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs für den strukturellen Index"
               .C_INDEX2BIN_STANDALONE_LOC                                     = "  Eigenständige Indexdatei: "
               .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs für verbundene Indexdatei: "
               .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Hauptdatei "'
               .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Projekt-Icon Datei "'
               .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'Datei ""'
               .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'ist nicht in der PJX Ordner Struktur, "'
               .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'siehe Option "CheckFileInPath".' + CR_LF+CR_LF


            Otherwise   && English (Inglés)
               *-------------------------------------------------------------------------------------------------------------------------------------------
               *-- NOTE: MUST USE DOUBLE QUOTES, OR SYNTAX ERRORS HAPPEN WHEN COMPILING. STRANGE :(
               *-------------------------------------------------------------------------------------------------------------------------------------------
               .C_ALLOWED_VALUES_ARE_LOC                                       = "Allowed values are"
               .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "* and ? extensions are not allowed because it's dangerous (binaries can be overwritten with xx2 empty files)"
               .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Could not update backlink"
               .C_BACKLINK_OF_TABLE_LOC                                        = "of table"
               .C_BACKUP_OF_LOC                                                = "Doing Backup of: "
               .C_CACHING_CONFIG_FOR_DIRECTORY_LOC                             = "Caching config for directory"
               .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Cannot generate file [<<THIS.c_OutputFile>>] because it is ReadOnly"
               .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimization: Base File [<<JUSTFNAME(.c_InputFile)>>] already processed, skipping processing of file [<<tc_InputFile>>]"
               .C_CONFIGFILE_LOC                                               = "Using configuration file:"
               .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Conversion Cancelled by the user"
               .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "Convert all files in a Project"
               .C_CONVERT_FOLDER_LOC                                           = "Convert Folder"
               .C_BINARY_TO_TEXT_LOC                                           = "Binary to Text"
               .C_TEXT_TO_BINARY_LOC                                           = "Text to Binary"
               .C_CONVERT_FOLDER_NONE_LOC                                      = "None"
               .C_CONVERT_FOLDER_QUESTION_LOC                                  = "What conversion should be performed on the files of this folder?"
               .C_CONVERTER_UNLOAD_LOC                                         = "Converter unload"
               .C_CONVERTING_FILE_LOC                                          = "Converting file"
               .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Data Error: Can't parse because of unpaired double-quotes on line <<lcMetadatos>>"
               .C_DUPLICATED_FILE_LOC                                          = "Duplicated file"
               .C_DUPLICATED_OBJECT_LOC                                        = "Duplicated Object"
               .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "Cannot find end marker [ENDDEFINE] of line <<TRANSFORM( toClase._Inicio )>> for ID [<<toClase._Nombre>>]"
               .C_END_MARKER_NOT_FOUND_LOC                                     = "Cannot find end marker [<<ta_ID_Bloques(lnPrimerID,2)>>] that closes start marker [<<ta_ID_Bloques(lnPrimerID,1)>>] on line <<TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))>>"
               .C_END_OF_PROCESS_LOC                                           = "End of Process"
               .C_ERROR_LOC                                                    = "ERROR"
               .C_ERRORS_FOUND_IN_FILE_LOC                                     = "ERRORS FOUND IN FILE"
               .C_EXTENSION_RECONFIGURATION_LOC                                = "Extension Reconfiguration:"
               .C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC        = "External class count (<<toModulo._ExternalClasses_Count>>) does not match found classes (<<toModulo._Clases_Count>>) for file [<<toFoxBin2Prg.c_InputFile>>]"
               .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "External class was not found"
               .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "External member name was not found"
               .C_EXTERNAL_PARAMETERS_LOC                                      = "EXTERNAL PARAMETERS"
               .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Field [<<laProps(m.I)>>] not found in structure of file <<DBF('TABLABIN')>>"
               .C_FILE_DOESNT_EXIST_LOC                                        = "File does not exist:"
               .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "File [<<.c_InputFile>>] is not supported"
               .C_FILE_NOT_FOUND_LOC                                           = "File not found"
               .C_FILENAME_LOC                                                 = "File"
               .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERROR"
               .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "SYNTAX AND PARAMETERS INFO"
               .C_ClassTwice_Header_LOC                                        = CR_LF+"Class defined twice."+CR_LF
               .C_ClassTwice_Lib_LOC                                           = CR_LF+"Library: "
               .C_ClassTwice_Class_LOC                                         = CR_LF+"Class: "
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FoxBin2Prg Home Page and download: https://github.com/fdbozzo/foxbin2prg/wiki  -  Fernando D. Bozzo (2013.11.25)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>FOXBIN2PRG.EXE <cFileSpec.Ext> [cType [cTextName [cGenText [cDontShowErrors [cDebug [cDontShowProgress [cOriginalFileName [cRecompile [cNoTimestamps [cCFG_File [cOutputFolder] ] ] ] ] ] ] ] ] ] ]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>cFileSpec.Ext:     ? | interactive This help
                        <<>>                   Full name (fullpath) of the file to convert or directory name to process
                        <<>>                     - If 'BIN2PRG' is specified, the directory specified in tcType is processed for generating TX2
                        <<>>                     - If 'PRG2BIN' is specified, the directory specified in tcType is processed for regenerating BIN
                        <<>>                     - In SCCAPI (VSS) compatibility mode, it is used to query the conversion support for the file type specified
                        <<>>                       VSS Types: d=DBC, D=DBF, K=Form, B=Label, M=Menu, R=Report, V=Class
                        <<>>cType:             In SCCAPI (VSS) compatibility mode indicates the input file type.
                        <<>>                        - If specified '*' or '*-' and tc_InputFile is a PJX, all project files are processed
                        <<>>cTextName          = Text filename. Only for SCCAPI (VSS) compatibility mode.
                        <<>>lGenText:          .T.=Generates Text, .F.=Regenerates Binary. Only for SCCAPI (VSS) compatibility mode.
                        <<>>cDontShowErrors:   '1' for NOT showing errors
                        <<>>cDebug:            '1' for generating process LOGs, stop on errors
                        <<>>cDontShowProgress: '1' for NOT showing the process window
                        <<>>cOriginalFileName: used in those cases in which inputFile is a temporary filename and you want to generate the correct filename on the header of the text version
                        <<>>cRecompile:        Indicates recompile ('1') the binary once regenerated. You can specify a Path too (ie, the project one)
                        <<>>cNoTimestamps:     Indicates if timestamp of several file types must be cleared ('1' or empty) or not ('0')
                        <<>>cCFG_File:         Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cOutputFolder:     The output folder to write to. If it isn't specified, the same folder as the source is used.
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE c|C|t [OutFileName [ cCFG_File[ cDebug]]]
                        <<>>DO FOXBIN2PRG.EXE WITH -c|-C|-t [, OutFileName [, cCFG_File[, cDebug]]]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>No parameter: Calls this info screen
                        <<>>-c (c)        Creates a template config-file <OutFileName> (like FOXBIN2PRG.CFG)
                        <<>>-C (C)        Creates a config-file <OutFileName> (like FOXBIN2PRG.CFG) with current options of folder of <OutFileName>
                        <<>>              If OutFileName is not given a FoxBin2Prg._cfg config file will be created at default folder
                        <<>>-t (t)        Creates a template table-config-file <OutFileName> (like <Tablename>.dbf.cfg)
                        <<>>              If OutFileName is not given, and a table is open a <Tablename>.dbf._cfg config file will be created at table folder.
                        <<>>cCFG_File:    Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cDebug:       '1' for generating process LOGs, stop on errors
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE VERNO
                        <<>>DO FOXBIN2PRG.EXE WITH "VERNO"|cPara
                        <<>>
                        <<>>-- Parameter details:
                        <<>>-VERNO (VERNO) Return version number of FoxBin2Prg
                        <<>>cPara          A parameter with the Value "VERNO", the version number is returned to this parameter
                        <<>>
                        <<>>
               ENDTEXT
               *** DH 2021-03-04: added HomeDir to text
               *** DH 2024-08-26: added text for option 2 for BodyDevInfo
               .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 = "*Options for folder <<.c_Recompile>>, read as of <<DATETIME()>>"
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FOXBIN2PRG.CFG configuration options: (If no values given, these are the DEFAULTS)
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>> Note, configuration files will follow an inheritance.
                        <<>> 1.  Default values
                        <<>> 2., optional FOXBIN2PRG.CFG in folder of FOXBIN2PRG.EXE
                        <<>>  or, if defined, a config file given by a parameter calling FOXBIN2PRG
                        <<>>      if used, the InhibitInheritance setting controls if other config files will be evaluated (default). See below.
                        <<>> 3., optional FOXBIN2PRG.CFG in root of working directory
                        <<>> 4., optional FOXBIN2PRG.CFG in every folder up to the working directory
                        <<>> 5., optional Special settings per single DBF's Syntax: <TableName>.dbf.cfg in tables folder)
                        <<>>
                        <<>> Some Parameter calling FOXBIN2PRG.EXE overturn this settings (except Defaults)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>-- Settings for internal work, not processing
                        <<>>Language: (auto)               && Language of shown messages and LOGs. EN=English, FR=French, ES=Español, DE=German, Not defined = AUTOMATIC [DEFAULT]
                        <<>>ShowProgressbar: 1             && 0=Don't show, 1=Allways show, 2=Show only for multi-file processing
                        <<>>DontShowErrors: 0              && Show message errors by default
                        <<>>ExtraBackupLevels: 1           && By default 1 BAK is created. With this you can make more .N.BAK, or none
                        <<>>Debug: 0                       && 0=Don't Activate individual <file>.Log by default
                        <<>>                               && 1=Activate individual <file>.Log by default
                        <<>>                               && 2=???
                        <<>>                               && Only valid if not controlled by parameter
                        <<>>BackgroundImage: <cFile>       && Backgroundimage for process form. Empty for empty Background. File not found uses default.
                        <<>>HomeDir: 1                     && Home directory in PJX
                        <<>>                               && 0 don't save HomeDir in PJ2
                        <<>>                               && 1 save HomeDir in PJ2
                        <<>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        <<>>-- Settings for config file via parameter only
                        <<>>InhibitInheritance: 0          && 0=Allow scanning "regular" config files (file via parameter is just additional default)
                        <<>>                               && 1=Only read tree from root of the file given by parameter, not FoxBin2Prg default
                        <<>>                               && 2=Only read folder and subfolder of the file given by parameter
                        <<>>                               && 3=Read no other file
                        <<>>                               && This is like
                        <<>>                               && 0 Default | Parameter file | Default near FoxBin2Prg | all other config files
                        <<>>                               && 1 Default | Parameter file | Inheritance from root to parent of folder | folder and subdirs
                        <<>>                               && 2 Default | Parameter file | folder and subdirs
                        <<>>                               && 3 Default | Parameter file
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Conversion operation by type
                        <<>>PJX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>VCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>SCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>FRX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>LBX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>MNX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBC_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBF_Conversion_Support: 1      && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>FKY_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>MEM_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for pjx files
                        <<>>CheckFileInPath: 0             && Determines 2Txt deals with files not in the subfolders of the PJX. No handler for UNC paths.
                        <<>>                               && 0 Ignore. Default
                        <<>>                               && 1 Check and error out if file is not on same structure (for source control)
                        <<>>                               && 2 Create absolute path if file is on different drive.
                        <<>>                               && 3 Create absolute path if file is not in structure
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for container files (not pjx)
                        <<>>-- CLASS (, FORM and DBC) options (tx2 is to read as vc2 or sc2, VCX might be SCX)
                        <<>>-- FORM and DBC options default to this settings, if not set otherwise. See below.
                        <<>>- Class per file options (UseClassPerFile: 1)
                        <<>>UseClassPerFile: 0             && Determines how a library (or form) will handle included class (or, for forms, objects)
                        <<>>                               && 0 One library.tx2 file
                        <<>>                               && 1 Multiple file.class.tx2 files
                        <<>>                               && 2 Multiple file.baseclass.class.tx2 files
                        <<>>RedirectClassPerFileToMain: 0  && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to file.vcx/scx
                        <<>>                               && 1 Redirect to file.vcx/scx when selecting file[.baseclass].class.tx2
                        <<>>                               &&   RedirectClassType: 1 has precedence
                        <<>>RedirectClassType: 0           && For classes created with UseClassPerFile>0 in the form file[.baseclass].class.tx2
                        <<>>                               && Those files could be imported like file.tx2::Class::import or like file[.baseclass].class.tx2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect file[.baseclass].class.tx2 to file.VCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect file[.baseclass].class.tx2 to file[.baseclass].class.VCX and do not touch file.VCX
                        <<>>                               && 2 Redirect file[.baseclass].class.tx2 to file.VCX and do not touch other classes of file.VCX
                        <<>>ClassPerFileCheck: 0           && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check file[.baseclass].class.tx2 inclusion
                        <<>>                               &&   Only used if import file is in file[.baseclass].class.tx2 syntax
                        <<>>                               &&   Ignored for RedirectClassType: 2
                        <<>>UseClassPerDir: 0              && 0=flat file.class.ext layout (default)
                        <<>>                               && 1=store under file.ext/ subdirectory (requires UseClassPerFile>0)
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- FORM options
                        <<>>- Form per file options (UseFormSettings: 1)
                        <<>>UseFormSettings: 0             && 1=Turns the File per SCX options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if UseFormSettings is set 1 before!
                        <<>>                               &&   If UseFormSettings is set 0 later, all setting will be lost
                        <<>>UseFormPerFile: 0              && Determines how a form will handle included objects
                        <<>>                               && 0 One Form.sc2 file
                        <<>>                               && 1 Multiple Form.Obj.sc2 files
                        <<>>                               && 2 Multiple Form.baseclass.Obj.sc2 files
                        <<>>RedirectFormPerFileToMain: 0   && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to Form.scx
                        <<>>                               && 1 Redirect to Form.scx when selecting Form[.baseclass].Obj.sc2
                        <<>>                               &&   RedirectFormType: 1 has precedence
                        <<>>RedirectFormType: 0            && For classes created with UseFormPerFile>0 in the form Form[.baseclass].Obj.sc2
                        <<>>                               && Those files could be imported like Form.sc2::Class::import or like Form[.baseclass].Obj.sc2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect Form[.baseclass].Obj.sc2 to Form[.baseclass].Obj.SCX and do not touch Form.SCX
                        <<>>                               && 2 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and do not touch other classes of Form.SCX
                        <<>>FormPerFileCheck: 0            && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check Form[.baseclass].Obj.sc2 inclusion
                        <<>>                               &&   Only used if import file is in Form[.baseclass].Obj.sc2 syntax
                        <<>>                               &&   Ignored for RedirectFormType: 2
                        <<>>UseFormPerDir: 0              && 0=flat Form.Obj.ext layout (default)
                        <<>>                               && 1=store under Form.ext/ subdirectory (requires UseFormPerFile>0)
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- DBC options
                        <<>>- File per DBC options (UseFilesPerDBC: 1)
                        <<>>OldFilesPerDBC: 0              && 1=Turns the File per DBC options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if OldFilesPerDBC is set 1 before!
                        <<>>                               &&   If OldFilesPerDBC is set 0 later, all setting will be lost
                        <<>>UseFilesPerDBC: 0              && 0=One database dc2 file, 1=Multiple file.*.*.dc2 files
                        <<>>                               && 0 creates only a file.dc2 with all DBC (file) data
                        <<>>                               && 1 creates a file.dc2 with DBC properties
                        <<>>                               &&   and additional DBC files per DBC item (stored-proc, table, ..)
                        <<>>                               &&   Note: recration only if RedirectFilePerDBCToMain is 1
                        <<>>RedirectFilePerDBCToMain: 0    && 0=Don't redirect to file.dc2, 1=Redirect to file.tx2 when selecting file.item.*.dc2
                        <<>>ItemPerDBCCheck: 0             && 0=Don't check file.item.*.dc2 inclusion, 1=Check file.item.*.dc2 inclusion
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- General files
                        <<>>NoTimestamps: 1                && Clear timestamps of several file types by default for minimize text-file differences
                        <<>>ClearUniqueID: 1               && 0=Keep UniqueID in text files, 1=Clear Unique ID. Useful for Diff and Merge
                        <<>>OptimizeByFilestamp: 0         && 1=Optimize file regeneration depending on file timestamp. Dangerous while working with branches!
                        <<>>RemoveNullCharsFromCode: 1     && 1=Drop .Null. chars from source code
                        <<>>ExportUTF8: 0                  && 0=Export text files in ANSI (current code page), 1=Export text files in UTF-8 (StrConv 9)
                        <<>>RemoveZOrderSetFromProps: 0    && 0=Do not remove ZOrderSet property from object, 1=Remove ZOrderSet property from object
                        <<>>PRG_Compat_Level: 0            && 0=Legacy, 1=Use HELPSTRING as Class Procedure comment
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- PJX special
                        <<>>BodyDevInfo: 0                 && 0=Don't keep DevInfo for body pjx records, 1=Keep DevInfo, 2 = Don't keep DevInfo or ObjRev
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Mirrored tree (exportProjectTree / importProjectTree only)
                        <<>>CopyNonConvertible: 0          && 0=Skip non-convertible PJX/PJ2 members, 1=Copy them into the mirrored tree as-is
                        <<>>CopyExcludedPjxFiles: 0        && 0=Skip PJX/PJ2 members marked Exclude (default), 1=Include them in export/import
                        <<>>ExcludedSubdirs:               && Semicolon-separated subpaths under project root to skip (not converted or copied)
                        <<>>                               && Example: tmp;backup;forms\old
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- DBF special
                        <<>>ClearDBFLastUpdate: 1          && 0=Keep DBF LastUpdate, 1=Clear DBF LastUpdate. Useful for Diff.
                        <<>>ExcludeDBFAutoincNextval: 0    && 0=Do not exclude this value from db2, 1=Exclude this value from db2
                        <<>>DBF_Conversion_Included: *     && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_Conversion_Excluded:       && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_BinChar_Base64: 1          && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform (default)
                        <<>>DBF_IncludeDeleted: 0          && 0=Do not include deleted records (default), 1=Include deleted records
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Text file extensions
                        <<>>extension: tx2=newext          && Specify extensions to use. Default FoxBin2Prg extensions ends in '2' (see at the bottom)
                        <<>>-- Example configuration for SourceSafe compatibility:
                        <<>>extension: pj2=pja             && Text file to PJX
                        <<>>extension: vc2=vca             && Text file to VCX
                        <<>>extension: sc2=sca             && Text file to SCX
                        <<>>extension: fr2=fra             && Text file to FRX
                        <<>>extension: lb2=lba             && Text file to LBX
                        <<>>extension: mn2=mna             && Text file to MNX
                        <<>>extension: db2=dba             && Text file to DBF
                        <<>>extension: dc2=dca             && Text file to DBC
                        <<>>-- Additional extensions
                        <<>>extension: fk2=fkx             && Text file to FKY
                        <<>>extension: me2=fkx             && Text file to MEM
                        <<>>
               ENDTEXT
               TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>-- Individual DBF configuration file (syntax: filename.dbf.cfg) Defaults see FoxBin2prg.cfg
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>DBF_Conversion_Support: <0,1,2,4,8>         && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>DBF_Conversion_Order: <c_Expression>        && Field expresion. ie: name+str(age,3)
                        <<>>DBF_Conversion_Condition: <c_Expression>    && Logical expression. ie: age > 10 AND NOT DELETED()
                        <<>>DBF_IndexList: <cFile_List>                 && comma delimited list of additonal non structural index files, cdx or idx
                        <<>>DBF_BinChar_Base64: <0,1>                   && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform
                        <<>>DBF_IncludeDeleted: <0,1>                   && 0=Do not include deleted records, 1=Include deleted records
                        <<>>
               ENDTEXT
               .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG is only for Visual FoxPro 9.0!"
               .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "WARNING!"
               .C_GENERATED_FILE_SIZE_LOC                                      = "Generated file size"
               .C_GENERATING_BINARY_LOC                                        = "Generating Binary"
               .C_INCLUDING_CLASS_LOC                                          = "Including class"
               .C_INCLUDING_MEMBER_LOC                                         = "Including member"
               .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Incorrect VFP 9 version - Missing SP1! Expected: 3504 or later, actual: " + Version(4)
               .C_INHERITING_FROM_LOC                                          = "Inheriting from"
               .C_INTERACTIVE_DIRECTORY_SELECTION_LOC                          = "Interactive Directory Selection"
               .C_INVALID_PARAMETER_LOC                                        = "Invalid parameter"
               .C_IS_A_FILE_LOC                                                = "is a FILE"
               .C_IS_A_DIRECTORY_LOC                                           = "is a DIRECTORY"
               .C_IS_UNSUPPORTED_LOC                                           = "is unsupported"
               .C_LANGUAGE_LOC                                                 = "EN"
               .C_MAIN_EXECUTION_LOC                                           = "MAIN EXECUTION"
               .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "Menu [<<THIS.c_InputFile>>] is NOT in VFP 9 Format! - Please convert to VFP 9 with MODIFY MENU '<<THIS.c_InputFile>>'"
               .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Names capitalization program [<<lcEXE_CAPS>>] found"
               .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* Names capitalization program [<<lcEXE_CAPS>>] not found"
               .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Object [<<toObj.CLASS>>] does not contain oReg object (level <<TRANSFORM(tnNivel)>>)"
               .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Operation not recognized. Only SETNAME and GETNAME allowed."
               .C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC             = "Optimization: skipping already processed file [<<(lcFile)>>]"
               .C_OPTION_LOC                                                   = "Option"
               .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "The outer class does not match the inner classes"
               .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "The outer member does not match the inner members"
               .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimization: output file [<<lcOutputFile>>] was not overwritten because it is the same as the existing one."
               .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimization: output file [<<THIS.c_OutputFile>>] was not regenerated because it's filestamp is equal than the inputfile."
               .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimization: output file [<<THIS.c_OutputFile>>] was not regenerated because it's filestamp is newer than the inputfile."
               .C_PRESS_ESC_TO_CANCEL                                          = "Press Esc to Cancel"
               .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Procedure not closed. Last line of code must be ENDPROC. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
               .C_PROCESSING_LOC                                               = "Processing file"
               .C_PROCESS_PROGRESS_LOC                                         = "Process Progress:"
               .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Property [<<TRANSFORM(tnPropertyID)>>] is not recognized."
               .C_READING_CFG_VALUES_FROM_DISK_LOC                             = "READING CFG VALUES FROM DISK"
               .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Report [<<THIS.c_InputFile>>] is NOT in VFP 9 Format! - Please convert to VFP 9 with MODIFY REPORT '<<THIS.c_InputFile>>'"
               .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Requesting capitalization of file [<<tcFileName>>]"
               .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Scanning file and directory information for"
               .C_SOURCEFILE_LOC                                               = "Source file: "
               .C_SOURCESAFE_COMPATIBILITY_MODE_LOC                            = "SourceSafe Compatibility Mode"
               .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Nesting structure error. ENDPROC expected but found ENDDEFINE on class <<toClase._Nombre>> (<<loProcedure._Nombre>>), line <<TRANSFORM(m.I)>> of file <<THIS.c_InputFile>>"
               .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Nesting structure error. ENDPROC expected but found ENDDEFINE on class <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), line <<TRANSFORM(m.I)>> of file <<THIS.c_InputFile>>"
               .C_UNKNOWN_CLASS_NAME_LOC                                       = "Unknown class [<<THIS.CLASS>>]"
               .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Use file timestamp Optimization"
               .C_USING_THIS_SETTINGS_LOC                                      = "Using this settings"
               .C_USING_THIS_SETTINGS_LOC1                                     = " BY PARAMETER, skipping all previous config!"
               .C_USING_THIS_SETTINGS_LOC2                                     = " Parsing of full configuration allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC3                                     = " Parsing configuration in parent~ and subdirectories allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC4                                     = " Parsing configuration in subdirectories allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC5                                     = " Parsing of other configuration not allowed."+CR_LF
               .C_USING_THIS_SETTINGS_LOC6                                     = "External configuration file set: "
               .C_USING_THIS_SETTINGS_LOC7                                     = ", using cached config."
               .C_WARNING_LOC                                                  = "WARNING!"
               .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "WARNING!" + CR_LF+ "MAKE SURE YOU ARE NOT USING A TABLE ALIAS ON INDEX KEY EXPRESSIONS!! (ex: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
               .C_WITH_ERRORS_LOC                                              = "with errors"
               .C_LOCKINGFOLDER_LOC                                            = " found, proccessing directory and subdirectories inhibited."

               .C_INDEX2TXT_PROCESSING_LOC                                     = " Processing index"
               .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Additional index files"
               .C_INDEX2TXT_NOFILE_LOC                                         = "     Not a File "
               .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index does not match table "
               .C_INDEX2BIN_PROCESSING_LOC                                     = " Creating index"
               .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs for structural index"
               .C_INDEX2BIN_STANDALONE_LOC                                     = "  Standalone index "
               .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs for compound index "
               .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Main file "'
               .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Project icon file "'
               .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'File ""'
               .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'not in PJX folder structure, "'
               .C_PJXPATH_ERR_LOC5                                             = '",' + 0h0D0A + 'check option "CheckFileInPath".' + CR_LF+CR_LF

               .n_LanguageSelectedMethod   = 0 && 0=Automatic with VERSION(3)

            Endcase
         Endwith && THIS AS CL_LANG OF 'cl_lang.prg'
      Endtry
   Endproc

Enddefine
