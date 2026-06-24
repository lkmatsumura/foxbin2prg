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
   C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                 = ""
   C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC          = ""
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
   C_ERRORS_FOUND_IN_FILE_LOC                                      = ""
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
   C_CFG_REF_TITLE_LOC                                             = ""
   C_CFG_REF_INTRO_LOC                                             = ""
   C_CFG_REF_USAGE_LOC                                             = ""
   C_CFG_REF_SEC_GENERAL_LOC                                       = ""
   C_CFG_REF_SEC_TIMESTAMPS_LOC                                    = ""
   C_CFG_REF_SEC_CLASSFORM_LOC                                     = ""
   C_CFG_REF_SEC_MIRROR_LOC                                        = ""
   C_CFG_REF_SEC_DBF_LOC                                           = ""
   C_CFG_REF_SEC_EXTENSIONS_LOC                                    = ""
   C_FOXBIN2PRG_JUST_VFP_9_LOC                                     = ""
   C_FOXBIN2PRG_WARN_CAPTION_LOC                                   = ""
   C_GENERATING_BINARY_LOC                                         = ""
   C_INCLUDING_CLASS_LOC                                           = ""
   C_INCLUDING_MEMBER_LOC                                          = ""
   C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                       = ""
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
   C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                 = ""
   C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                         = ""
   C_SCANNING_FILE_AND_DIR_INFO_LOC                                = ""
   C_SOURCEFILE_LOC                                                = ""
   C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                  = ""
   C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC                = ""
   C_UNKNOWN_CLASS_NAME_LOC                                        = ""
   C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                           = ""
   C_WARNING_LOC                                                   = ""
   C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                      = ""
   C_WITH_ERRORS_LOC                                               = ""

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

   Procedure ensureLangProcedures
      *---------------------------------------------------------------------------------------------------
      * When running modular sources (not the unified foxbin2prg.prg), load lang/*.prg procedures.
      *---------------------------------------------------------------------------------------------------
      IF TYPE('Lang_Apply_EN') = 'U'
         LOCAL lcLangDir
         lcLangDir = ADDBS(JUSTPATH(LOCFILE('cl_lang.prg'))) + 'lang\'
         SET PROCEDURE TO (lcLangDir + 'lang_en.prg') ADDITIVE
         SET PROCEDURE TO (lcLangDir + 'lang_fr.prg') ADDITIVE
         SET PROCEDURE TO (lcLangDir + 'lang_es.prg') ADDITIVE
         SET PROCEDURE TO (lcLangDir + 'lang_de.prg') ADDITIVE
      ENDIF
   Endproc


   Procedure Init
      Lparameters tcLanguage

      Try
         This.ensureLangProcedures()

         With This As CL_LANG Of 'cl_lang.prg'
            *-- El lenguaje pasado por parámetro prevalece sobre el existente.
            tcLanguage  = Evl(tcLanguage,'')

            If Empty(tcLanguage)
               .n_LanguageSelectedMethod   = 0 && 0=Automatic by version(3)
            Else
               .n_LanguageSelectedMethod   = 1 && 1=Assigned by Parameter
            Endif

            tcLanguage  = Upper( Evl(tcLanguage, Version(3)) )

            *-- Strings per language: lang/lang_*.prg (Lang_Apply_* procedures)
            Do Case
            Case Inlist(tcLanguage, '33', 'FR') && French (Francés)
               Lang_Apply_FR(This)
            Case Inlist(tcLanguage, '34', 'ES') && Spanish (Español)
               Lang_Apply_ES(This)
            Case Inlist(tcLanguage, '49', 'DE') && German (Alemán)
               Lang_Apply_DE(This)
            Otherwise   && English (Inglés) — fallback; most up-to-date translations
               Lang_Apply_EN(This)
            Endcase
         Endwith && THIS AS CL_LANG OF 'cl_lang.prg'
      Endtry
   Endproc

Enddefine
