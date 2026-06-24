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

   Procedure Init
      Lparameters tcLanguage

      Try
         With This As CL_LANG Of 'cl_lang.prg'
            *-- El lenguaje pasado por par?metro prevalece sobre el existente.
            tcLanguage  = Evl(tcLanguage,'')

            If Empty(tcLanguage)
               .n_LanguageSelectedMethod   = 0 && 0=Automatic by version(3)
            Else
               .n_LanguageSelectedMethod   = 1 && 1=Assigned by Parameter
            Endif

            tcLanguage  = Upper( Evl(tcLanguage, Version(3)) )

            Do Case
            Case Inlist(tcLanguage, '33', 'FR') && French (Franc?s)
               .Lang_Apply_FR()
            Case Inlist(tcLanguage, '34', 'ES') && Spanish (Espa?ol)
               .Lang_Apply_ES()
            Case Inlist(tcLanguage, '49', 'DE') && German (Alem?n)
               .Lang_Apply_DE()
            Otherwise   && English (Ingl?s) ? fallback; most up-to-date translations
               .Lang_Apply_EN()
            Endcase
         Endwith && THIS AS CL_LANG OF 'cl_lang.prg'
      Endtry
   Endproc

   Procedure Lang_Apply_EN
      With This As CL_LANG Of 'cl_lang.prg'
         .C_ALLOWED_VALUES_ARE_LOC                                       = "Allowed values are"
         .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "* and ? extensions are not allowed because it's dangerous (binaries can be overwritten with xx2 empty files)"
         .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Could not update backlink"
         .C_BACKLINK_OF_TABLE_LOC                                        = "of table"
         .C_BACKUP_OF_LOC                                                = "Doing Backup of: "
         .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Cannot generate file [<<THIS.c_OutputFile>>] because it is ReadOnly"
         .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimization: Base File [<<JUSTFNAME(.c_InputFile)>>] already processed, skipping processing of file [<<tc_InputFile>>]"
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
         .C_ERRORS_FOUND_IN_FILE_LOC                                     = "ERRORS FOUND IN FILE"
         .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "External class was not found"
         .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "External member name was not found"
         .C_EXTERNAL_PARAMETERS_LOC                                      = "EXTERNAL PARAMETERS"
         .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Field [<<laProps(m.I)>>] not found in structure of file <<DBF('TABLABIN')>>"
         .C_FILE_DOESNT_EXIST_LOC                                        = "File does not exist:"
         .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "File [<<.c_InputFile>>] is not supported"
         .C_FILE_NOT_FOUND_LOC                                           = "File not found"
         .C_FILENAME_LOC                                                 = "File"
         .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERROR"
         .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "CONFIGURATION REFERENCE"
         .C_CFG_REF_TITLE_LOC                                            = "Configuration reference"
         .C_CFG_REF_INTRO_LOC                                            = "Programmatic configuration for FoxBin2Prg (no .cfg files on disk)."
         TEXT TO .C_CFG_REF_USAGE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>>loCfg = loF2b.newConfig()  && clone factory defaults
            <<>>loCfg.l_NoTimestamps = .T. && override properties
            <<>>loF2b.exportProjectTree( lcPjx, lcDest, loCfg )
            <<>>loF2b.importProjectTree( lcPj2, lcDest, loCfg )
            <<>>DO main.prg WITH lcFile, '', loCfg"
         ENDTEXT
         .C_CFG_REF_SEC_GENERAL_LOC                                      = "General"
         .C_CFG_REF_SEC_TIMESTAMPS_LOC                                   = "Timestamps / metadata"
         .C_CFG_REF_SEC_CLASSFORM_LOC                                    = "Classes / Forms"
         .C_CFG_REF_SEC_MIRROR_LOC                                       = "Mirrored tree (exportProjectTree)"
         .C_CFG_REF_SEC_DBF_LOC                                          = "DBF / DBC / conversion support"
         .C_CFG_REF_SEC_EXTENSIONS_LOC                                   = "Text file extensions"
         .C_ClassTwice_Header_LOC                                        = CR_LF+"Class defined twice."+CR_LF
         .C_ClassTwice_Lib_LOC                                           = CR_LF+"Library: "
         .C_ClassTwice_Class_LOC                                         = CR_LF+"Class: "

         .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG is only for Visual FoxPro 9.0!"
         .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "WARNING!"
         .C_GENERATING_BINARY_LOC                                        = "Generating Binary"
         .C_INCLUDING_CLASS_LOC                                          = "Including class"
         .C_INCLUDING_MEMBER_LOC                                         = "Including member"
         .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Incorrect VFP 9 version - Missing SP1! Expected: 3504 or later, actual: " + VERSION(4)
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
         .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Report [<<THIS.c_InputFile>>] is NOT in VFP 9 Format! - Please convert to VFP 9 with MODIFY REPORT '<<THIS.c_InputFile>>'"
         .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Requesting capitalization of file [<<tcFileName>>]"
         .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Scanning file and directory information for"
         .C_SOURCEFILE_LOC                                               = "Source file: "
         .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Nesting structure error. ENDPROC expected but found ENDDEFINE on class <<toClase._Nombre>> (<<loProcedure._Nombre>>), line <<TRANSFORM(m.I)>> of file <<THIS.c_InputFile>>"
         .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Nesting structure error. ENDPROC expected but found ENDDEFINE on class <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), line <<TRANSFORM(m.I)>> of file <<THIS.c_InputFile>>"
         .C_UNKNOWN_CLASS_NAME_LOC                                       = "Unknown class [<<THIS.CLASS>>]"
         .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Use file timestamp Optimization"
         .C_WARNING_LOC                                                  = "WARNING!"
         .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "WARNING!" + CR_LF+ "MAKE SURE YOU ARE NOT USING A TABLE ALIAS ON INDEX KEY EXPRESSIONS!! (ex: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
         .C_WITH_ERRORS_LOC                                              = "with errors"

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

      Endwith
   Endproc

   Procedure Lang_Apply_FR
      With This As CL_LANG Of 'cl_lang.prg'
         .C_ALLOWED_VALUES_ARE_LOC                                       = "Les valeurs autoris?es sont"
         .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "* Et ? extensions ne sont pas autoris?es car il est dangereux (binaires peuvent ?tre remplac?s par des fichiers vides de XX2)"
         .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Impossible de mettre ? jour backlink"
         .C_BACKLINK_OF_TABLE_LOC                                        = "de la table"
         .C_BACKUP_OF_LOC                                                = "Faire de sauvegarde des: "
         .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Vous ne pouvez pas g?n?rer un fichier [<<THIS.c_OutputFile>>] car il est en lecture seule"
         .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimisation: Fichier de base [<<JUSTFNAME(.c_InputFile)>>] D?j? trait?e, en sautant traitement de fichier [<<tc_InputFile>>]"
         .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Conversion Annul? par l'utilisateur"
         .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "Convertir tous les fichiers dans un Projet"
         .C_CONVERT_FOLDER_LOC                                           = "Convertir un Dossier"
         .C_BINARY_TO_TEXT_LOC                                           = "Binaire en Texte"
         .C_TEXT_TO_BINARY_LOC                                           = "Texte ? Binaire"
         .C_CONVERT_FOLDER_NONE_LOC                                      = "Aucun"
         .C_CONVERT_FOLDER_QUESTION_LOC                                  = "Que la conversion doit ?tre effectu?e sur les fichiers de ce dossier?"
         .C_CONVERTER_UNLOAD_LOC                                         = "Convertisseur d?chargement"
         .C_CONVERTING_FILE_LOC                                          = "Conversion de fichiers"
         .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Erreur de donn?es: ne peut pas analyser en raison de guillemets non appari?s en ligne <<lcMetadatos>>"
         .C_DUPLICATED_FILE_LOC                                          = "fichier dupliqu?"
         .C_DUPLICATED_OBJECT_LOC                                        = "Object dupliqu?"
         .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "Vous ne trouvez pas marqueur de fin [ENDDEFINE] de la ligne <<TRANSFORM(toClase._Inicio)>> ID [<<toClase._Nombre>>]"
         .C_END_MARKER_NOT_FOUND_LOC                                     = "Vous ne trouvez pas fin marqueur [<<ta_ID_Bloques(lnPrimerID, 2)>>] qui ferme marqueur de d?but [<<ta_ID_Bloques(lnPrimerID, 1) >>] en ligne <<TRANSFORM(taBloquesExclusion (tnBloquesExclusion, 1))>>"
         .C_END_OF_PROCESS_LOC                                           = "Fin du processus"
         .C_ERRORS_FOUND_IN_FILE_LOC                                     = "ERREURS TROUV? DANS LE FICHIER"
         .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "Aucune classe externe est trouv?"
         .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "Nom de membre externe n'a pas ?t? trouv?"
         .C_EXTERNAL_PARAMETERS_LOC                                      = "PARAM?TRES EXTERNES"
         .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Champ [<< laProps (m.I) >>] ne trouve pas dans la structure du fichier DBF <<('TABLABIN')>>"
         .C_FILE_DOESNT_EXIST_LOC                                        = "Fichier ne existe pas:"
         .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "File [<<.c_InputFile>>] ne est pas support?"
         .C_FILE_NOT_FOUND_LOC                                           = "Fichier introuvable"
         .C_FILENAME_LOC                                                 = "Fichier"
         .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERREUR"
         .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "R?F?RENCE DE CONFIGURATION"
         .C_CFG_REF_TITLE_LOC                                            = "R?f?rence de configuration"
         .C_CFG_REF_INTRO_LOC                                            = "Configuration programmatique pour FoxBin2Prg (pas de fichiers .cfg sur disque)."
         TEXT TO .C_CFG_REF_USAGE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>>loCfg = loF2b.newConfig()  && cloner les valeurs d'usine
            <<>>loCfg.l_NoTimestamps = .T. && remplacer les propri?t?s
            <<>>loF2b.exportProjectTree( lcPjx, lcDest, loCfg )
            <<>>loF2b.importProjectTree( lcPj2, lcDest, loCfg )
            <<>>DO main.prg WITH lcFile, '', loCfg"
         ENDTEXT
         .C_CFG_REF_SEC_GENERAL_LOC                                      = "G?n?ral"
         .C_CFG_REF_SEC_TIMESTAMPS_LOC                                   = "Horodatages / m?tadonn?es"
         .C_CFG_REF_SEC_CLASSFORM_LOC                                    = "Classes / Formulaires"
         .C_CFG_REF_SEC_MIRROR_LOC                                       = "Arbre miroir (exportProjectTree)"
         .C_CFG_REF_SEC_DBF_LOC                                          = "DBF / DBC / prise en charge conversion"
         .C_CFG_REF_SEC_EXTENSIONS_LOC                                   = "Extensions de fichiers texte"
         .C_ClassTwice_Header_LOC                                        = CR_LF+"Classe d?finie deux fois."+CR_LF
         .C_ClassTwice_Lib_LOC                                           = CR_LF+"Biblioth?que: "
         .C_ClassTwice_Class_LOC                                         = CR_LF+"Classe: "
         .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG est seulement pour Visual FoxPro 9.0!"
         .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "AVERTISSEMENT!"
         .C_GENERATING_BINARY_LOC                                        = "G?n?ration Binaire"
         .C_INCLUDING_CLASS_LOC                                          = "classe, y compris"
         .C_INCLUDING_MEMBER_LOC                                         = "membres, y compris"
         .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Version VFP 9 incorrecte - SP1 manquant! Attendu: 3504 ou plus tard, actuel: " + Version(4)
         .C_INVALID_PARAMETER_LOC                                        = "Param?tre non valide"
         .C_IS_A_FILE_LOC                                                = "est un FICHIER"
         .C_IS_A_DIRECTORY_LOC                                           = "est un R?PERTOIRE"
         .C_IS_UNSUPPORTED_LOC                                           = "ne est pas support?"
         .C_LANGUAGE_LOC                                                 = "FR"
         .C_MAIN_EXECUTION_LOC                                           = "EX?CUTION PRINCIPALE"
         .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "Menu [<<THIS.c_InputFile>>] ne est pas dans VFP 9 Format! - Se il vous pla?t se convertir ? VFP 9 avec MODIFY MENU '<<THIS.c_InputFile>>'"
         .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Programme des noms de capitalisation [<<lcEXE_CAPS>>] trouv?"
         .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* Programme des noms de capitalisation [<<lcEXE_CAPS>>] introuvables"
         .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Object [<<toObj.CLASS>>] ne contient pas l'objet oReg (niveau <<TRANSFORM(tnNivel)>>)"
         .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Op?ration non reconnu. Seulement SETNAME et GETNAME permis."
         .C_OPTION_LOC                                                   = "Option"
         .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "La classe externe ne correspond pas ? la classe interne"
         .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "L'?l?ment ext?rieur ne correspond pas aux ?l?ments int?rieur"
         .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimisation: fichier de sortie [<<lcOutputFile>>] ne ?tait pas ?cras? parce que ce est la m?me que celle g?n?r?e."
         .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimisation: le fichier de sortie [<<THIS.c_OutputFile>>] pas r?g?n?r? en ayant le m?me horodatage que l'entr?e."
         .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimisation: le fichier de sortie [<<THIS.c_OutputFile>>] n'a pas ?t? r?g?n?r? car il est plus r?cent que le fichier d'entr?e."
         .C_PRESS_ESC_TO_CANCEL                                          = "Appuyez sur Esc pour Annuler"
         .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Proc?dure pas ferm?. Derni?re ligne de code doit ?tre ENDPROC. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
         .C_PROCESSING_LOC                                               = "Traitement du fichier"
         .C_PROCESS_PROGRESS_LOC                                         = "Processus Progr?s:"
         .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Propri?t? [<<TRANSFORM(tnPropertyID)>>] ne est pas reconnu."
         .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Rapport [<<THIS.c_InputFile>>] ne est pas dans VFP 9 Format! - Se il vous pla?t se convertir ? VFP 9 avec MODIFY REPORT '<<THIS.c_InputFile>>'"
         .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Demande de capitalisation de fichier [<<tcFileName>>]"
         .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Fichier de num?risation et de l'information de r?pertoire pour"
         .C_SOURCEFILE_LOC                                               = "Fichier source: "
         .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Nesting erreur de structure. ENDPROC pr?vu, mais a trouv? ENDDEFINE sur la classe <<toClase._Nombre>> (<<loProcedure._Nombre>>), ligne <<TRANSFORM(m.I)>> du fichier <<THIS.c_InputFile>>"
         .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Nesting erreur de structure. ENDPROC attendue, mais ENDDEFINE sur la classe <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), ligne <<TRANSFORM(m.I)>> du fichier <<THIS.c_InputFile>>"
         .C_UNKNOWN_CLASS_NAME_LOC                                       = "Classe inconnue[<<THIS.CLASS>>]"
         .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Utilisez le fichier Optimisation d'horodatage"
         .C_WARNING_LOC                                                  = "AVERTISSEMENT!"
         .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "AVERTISSEMENT!" + CR_LF+ "ASSUREZ VOUS NE UTILISEZ PAS UN ALIAS DE TABLE SUR LES EXPRESSIONS INDEX CL?S!! (exemple: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
         .C_WITH_ERRORS_LOC                                              = "avec des erreurs"

         .C_INDEX2TXT_PROCESSING_LOC                                     = " Traitement de l'index"
         .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Fichiers d'index suppl?mentaires"
         .C_INDEX2TXT_NOFILE_LOC                                         = "     Pas un fichier "
         .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   L'index ne correspond pas ? la table "
         .C_INDEX2BIN_PROCESSING_LOC                                     = " Cr?ation de l'index"
         .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs pour l'index structurel"
         .C_INDEX2BIN_STANDALONE_LOC                                     = "  Index autonome "
         .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs pour l'index compos? "
         .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Fichier principal "'
         .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Fichier ic?ne du projet "'
         .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'Fichier ""'
         .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'absent de la structure de dossiers PJX, "'
         .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + [voir l''option "CheckFileInPath".] + CR_LF+CR_LF

      Endwith
   Endproc

   Procedure Lang_Apply_ES
      With This As CL_LANG Of 'cl_lang.prg'
         .C_ALLOWED_VALUES_ARE_LOC                                       = "Los valores permitidos son"
         .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "No se admiten extensiones * o ? porque es peligroso (se pueden pisar binarios con archivo xx2 vac?os)."
         .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "No se pudo actualizar el backlink"
         .C_BACKLINK_OF_TABLE_LOC                                        = "de la tabla"
         .C_BACKUP_OF_LOC                                                = "Haciendo Backup de: "
         .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "No se puede generar el archivo [<<THIS.c_OutputFile>>] porque es ReadOnly"
         .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimizaci?n: El archivo Base [<<JUSTFNAME(.c_InputFile)>>] ya fue procesado, ignorando el procesamiento del archivo [<<tc_InputFile>>]"
         .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Conversi?n Cancelada por el usuario"
         .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "Convertir todos los archivos de un Proyecto"
         .C_CONVERT_FOLDER_LOC                                           = "Convertir Carpeta"
         .C_BINARY_TO_TEXT_LOC                                           = "Binario a Texto"
         .C_TEXT_TO_BINARY_LOC                                           = "Texto a Binario"
         .C_CONVERT_FOLDER_NONE_LOC                                      = "Ninguna"
         .C_CONVERT_FOLDER_QUESTION_LOC                                  = "?Qu? tipo de conversi?n se debe hacer en esta carpeta?"
         .C_CONVERTER_UNLOAD_LOC                                         = "Descarga del conversor"
         .C_CONVERTING_FILE_LOC                                          = "Convirtiendo archivo"
         .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Error de datos: No se puede parsear porque las comillas no son pares en la l?nea <<lcMetadatos>>"
         .C_DUPLICATED_FILE_LOC                                          = "Archivo duplicado"
         .C_DUPLICATED_OBJECT_LOC                                        = "Objeto Duplicado"
         .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "No se ha encontrado el marcador de fin [ENDDEFINE] de la l?nea <<TRANSFORM( toClase._Inicio )>> para el identificador [<<toClase._Nombre>>]"
         .C_END_MARKER_NOT_FOUND_LOC                                     = "No se ha encontrado el marcador de fin [<<ta_ID_Bloques(lnPrimerID,2)>>] que cierra al marcador de inicio [<<ta_ID_Bloques(lnPrimerID,1)>>] de la l?nea <<TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))>>"
         .C_END_OF_PROCESS_LOC                                           = "Fin del Proceso"
         .C_ERRORS_FOUND_IN_FILE_LOC                                     = "SE HAN ENCONTRADOS ERRORES EN EL ARCHIVO"
         .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "No se encontr? la clase externa"
         .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "No se encontr? el miembro externo"
         .C_EXTERNAL_PARAMETERS_LOC                                      = "PAR?METROS EXTERNOS"
         .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "No se encontr? el campo [<<laProps(m.I)>>] en la estructura del archivo <<DBF('TABLABIN')>>"
         .C_FILE_DOESNT_EXIST_LOC                                        = "El archivo no existe:"
         .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "El archivo [<<.c_InputFile>>] no est? soportado"
         .C_FILE_NOT_FOUND_LOC                                           = "No se encontr? el archivo"
         .C_FILENAME_LOC                                                 = "Archivo"
         .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERROR"
         .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "REFERENCIA DE CONFIGURACI?N"
         .C_CFG_REF_TITLE_LOC                                            = "Referencia de configuraci?n"
         .C_CFG_REF_INTRO_LOC                                            = "Configuraci?n program?tica para FoxBin2Prg (sin archivos .cfg en disco)."
         TEXT TO .C_CFG_REF_USAGE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>>loCfg = loF2b.newConfig()  && clonar valores de f?brica
            <<>>loCfg.l_NoTimestamps = .T. && sobrescribir propiedades
            <<>>loF2b.exportProjectTree( lcPjx, lcDest, loCfg )
            <<>>loF2b.importProjectTree( lcPj2, lcDest, loCfg )
            <<>>DO main.prg WITH lcFile, '', loCfg"
         ENDTEXT
         .C_CFG_REF_SEC_GENERAL_LOC                                      = "General"
         .C_CFG_REF_SEC_TIMESTAMPS_LOC                                   = "Marcas de tiempo / metadatos"
         .C_CFG_REF_SEC_CLASSFORM_LOC                                    = "Clases / Formularios"
         .C_CFG_REF_SEC_MIRROR_LOC                                       = "?rbol espejo (exportProjectTree)"
         .C_CFG_REF_SEC_DBF_LOC                                          = "DBF / DBC / soporte de conversi?n"
         .C_CFG_REF_SEC_EXTENSIONS_LOC                                   = "Extensiones de archivos de texto"
         .C_ClassTwice_Header_LOC                                        = CR_LF+"Clase definida dos veces."+CR_LF
         .C_ClassTwice_Lib_LOC                                           = CR_LF+"Biblioteca: "
         .C_ClassTwice_Class_LOC                                         = CR_LF+"Clase: "

         .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "?FOXBIN2PRG es solo para Visual FoxPro 9.0!"
         .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "?ATENCI?N!"
         .C_GENERATING_BINARY_LOC                                        = "Generando Binario"
         .C_INCLUDING_CLASS_LOC                                          = "Incluyendo clase"
         .C_INCLUDING_MEMBER_LOC                                         = "Incluyendo miembro"
         .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Versi?n Incorrecta de VFP 9 - Falta el SP1! Esperado: 3504 o posterior, actual: " + Version(4)
         .C_INVALID_PARAMETER_LOC                                        = "Par?metro inv?lido"
         .C_IS_A_FILE_LOC                                                = "es un ARCHIVO"
         .C_IS_A_DIRECTORY_LOC                                           = "es un DIRECTORIO"
         .C_IS_UNSUPPORTED_LOC                                           = "no est? soportado"
         .C_LANGUAGE_LOC                                                 = "ES"
         .C_MAIN_EXECUTION_LOC                                           = "EJECUCI?N PRINCIPAL"
         .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "El Men? [<<THIS.c_InputFile>>] NO est? en formato VFP 9! - Por favor convertirlo a VFP 9 con MODIFY MENU '<<THIS.c_InputFile>>'"
         .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Se ha encontrado el programa de capitalizaci?n de nombres [<<lcEXE_CAPS>>]"
         .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* No se ha encontrado el programa de capitalizaci?n de nombres [<<lcEXE_CAPS>>]"
         .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Objeto [<<toObj.CLASS>>] no contiene el objeto oReg (nivel <<TRANSFORM(tnNivel)>>)"
         .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Operaci?n no reconocida. Solo re reconoce SETNAME y GETNAME."
         .C_OPTION_LOC                                                   = "Opci?n"
         .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "La clase externa no coincide con las clases internas"
         .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "El miembro externo no coincide con los miembros internos"
         .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimizaci?n: el archivo de salida [<<lcOutputFile>>] no se sobreescribe por ser igual al ya existente."
         .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimizaci?n: el archivo de salida [<<THIS.c_OutputFile>>] no se regenera por tener el mismo timestamp que el de entrada."
         .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimizaci?n: el archivo de salida [<<THIS.c_OutputFile>>] no se regenera por tener un timestamp m?s nuevo que el de entrada."
         .C_PRESS_ESC_TO_CANCEL                                          = "Pulse Esc para Cancelar"
         .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Procedimiento sin cerrar. La ?ltima l?nea de c?digo debe ser ENDPROC. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
         .C_PROCESSING_LOC                                               = "Procesando archivo"
         .C_PROCESS_PROGRESS_LOC                                         = "Avance del proceso:"
         .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Propiedad [<<TRANSFORM(tnPropertyID)>>] no reconocida."
         .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "El Reporte [<<THIS.c_InputFile>>] NO est? en formato VFP 9! - Por favor convertirlo a VFP 9 con MODIFY REPORT '<<THIS.c_InputFile>>'"
         .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Solicitado capitalizar el archivo [<<tcFileName>>]"
         .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Escaneando archivos e informaci?n de directorio para"
         .C_SOURCEFILE_LOC                                               = "Archivo origen: "
         .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Error de anidamiento de estructuras. Se esperaba ENDPROC pero se encontr? ENDDEFINE en la clase <<toClase._Nombre>> (<<loProcedure._Nombre>>), l?nea <<TRANSFORM(m.I)>> del archivo <<THIS.c_InputFile>>"
         .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Error de anidamiento de estructuras. Se esperaba ENDPROC pero se encontr? ENDDEFINE en la clase <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), l?nea <<TRANSFORM(m.I)>> del archivo <<THIS.c_InputFile>>"
         .C_UNKNOWN_CLASS_NAME_LOC                                       = "Clase [<<THIS.CLASS>>] desconocida"
         .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Usar Optimizaci?n de filestamp de archivo"
         .C_WARNING_LOC                                                  = "?ATENCI?N!"
         .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "?ATENCI?N!" + CR_LF+ "ASEG?RESE DE QUE NO EST? USANDO UN ALIAS DE TABLA EN LAS EXPRESIONES DE LOS ?NDICES!! (ej: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag nombreclave)"
         .C_WITH_ERRORS_LOC                                              = "con errores"

         .C_INDEX2TXT_PROCESSING_LOC                                     = " Procesando ?ndice"
         .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Archivos de ?ndice adicionales"
         .C_INDEX2TXT_NOFILE_LOC                                         = "     No es un archivo "
         .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   El ?ndice no coincide con la tabla "
         .C_INDEX2BIN_PROCESSING_LOC                                     = " Creando ?ndice"
         .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs para ?ndice estructural"
         .C_INDEX2BIN_STANDALONE_LOC                                     = "  ?ndice independiente "
         .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs para ?ndice compuesto "
         .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Archivo principal "'
         .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Archivo de icono del proyecto "'
         .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'Archivo ""'
         .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'no est? en la estructura de carpetas PJX, "'
         .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'revise la opci?n "CheckFileInPath".' + CR_LF+CR_LF

      Endwith
   Endproc

   Procedure Lang_Apply_DE
      With This As CL_LANG Of 'cl_lang.prg'
         .C_ALLOWED_VALUES_ARE_LOC                                       = "Erlaubte Werte sind"
         .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "Die Erweiterungen * und ? sind nicht erlaubt, da sie gef?hrlich sind (Binaries k?nnten mit xx2 leeren Dateien ?berschrieben werden)"
         .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Backlink kann nicht aktualisiert werden"
         .C_BACKLINK_OF_TABLE_LOC                                        = "von Tabelle"
         .C_BACKUP_OF_LOC                                                = "Erzeuge Backup von: "
         .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Kann Datei [<<THIS.c_OutputFile>>] nicht generieren, da sie schreibgesch?tzt ist"
         .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimierung: Grund Datei [<<JUSTFNAME(.c_InputFile)>>] Schon verarbeitet, das ?berspringen Verarbeitung der Datei [<<tc_InputFile>>]"
         .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Konvertierung durch den Benutzer abgebrochen"
         .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "alle Dateien in einem Projekt zu konvertieren"
         .C_CONVERT_FOLDER_LOC                                           = "Konvertieren Verzeichnis"
         .C_BINARY_TO_TEXT_LOC                                           = "Bin?r zu Text"
         .C_TEXT_TO_BINARY_LOC                                           = "Text zu Bin?r"
         .C_CONVERT_FOLDER_NONE_LOC                                      = "Nichts"
         .C_CONVERT_FOLDER_QUESTION_LOC                                  = "Welche Umwandlung sollte sich auf die Dateien dieses Verzeichnis durchgef?hrt werden?"
         .C_CONVERTER_UNLOAD_LOC                                         = "Konverter wird entladen"
         .C_CONVERTING_FILE_LOC                                          = "Konvertiere Datei"
         .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Datenfehler: Keine Analyse m?glich, da ungepaarte Anf?hrungszeichen in Zeile <<lcMetadatos>> sind."
         .C_DUPLICATED_FILE_LOC                                          = "Doppelte Datei"
         .C_DUPLICATED_OBJECT_LOC                                        = "Doppelte Objekt"
         .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "Kann keinen Ende Marker [ENDDEFINE] in Zeile <<TRANSFORM( toClase._Inicio )>> f?r die ID [<<toClase._Nombre>>] finden"
         .C_END_MARKER_NOT_FOUND_LOC                                     = "Kann keinen Ende Marker [<<ta_ID_Bloques(lnPrimerID,2)>>] welcher den Start Marker [<<ta_ID_Bloques(lnPrimerID,1)>>] in Zeile <<TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))>> schlie?t"
         .C_END_OF_PROCESS_LOC                                           = "Ende des Prozesses"
         .C_ERRORS_FOUND_IN_FILE_LOC                                     = "FEHLER IN FILE GEFUNDEN"
         .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "Keine externe Klasse gefunden"
         .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "Externe Mitglied wurde nicht gefunden"
         .C_EXTERNAL_PARAMETERS_LOC                                      = "EXTERNE PARAMETER"
         .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Feld [<<laProps(m.I)>>] nicht in der Struktur von Datei <<DBF('TABLABIN')>> gefunden"
         .C_FILE_DOESNT_EXIST_LOC                                        = "Datei existiert nicht:"
         .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "Datei [<<.c_InputFile>>] wird nicht unterst?tzt"
         .C_FILE_NOT_FOUND_LOC                                           = "Datei nicht gefunden"
         .C_FILENAME_LOC                                                 = "Datei"
         .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "FEHLER"
         .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "KONFIGURATIONSREFERENZ"
         .C_CFG_REF_TITLE_LOC                                            = "Konfigurationsreferenz"
         .C_CFG_REF_INTRO_LOC                                            = "Programmatische Konfiguration f?r FoxBin2Prg (keine .cfg-Dateien auf der Festplatte)."
         TEXT TO .C_CFG_REF_USAGE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>>loCfg = loF2b.newConfig()  && Werkseinstellungen klonen
            <<>>loCfg.l_NoTimestamps = .T. && Eigenschaften ?berschreiben
            <<>>loF2b.exportProjectTree( lcPjx, lcDest, loCfg )
            <<>>loF2b.importProjectTree( lcPj2, lcDest, loCfg )
            <<>>DO main.prg WITH lcFile, '', loCfg"
         ENDTEXT
         .C_CFG_REF_SEC_GENERAL_LOC                                      = "Allgemein"
         .C_CFG_REF_SEC_TIMESTAMPS_LOC                                   = "Zeitstempel / Metadaten"
         .C_CFG_REF_SEC_CLASSFORM_LOC                                    = "Klassen / Formulare"
         .C_CFG_REF_SEC_MIRROR_LOC                                       = "Gespiegelter Baum (exportProjectTree)"
         .C_CFG_REF_SEC_DBF_LOC                                          = "DBF / DBC / Konvertierungsunterst?tzung"
         .C_CFG_REF_SEC_EXTENSIONS_LOC                                   = "Textdatei-Erweiterungen"
         .C_ClassTwice_Header_LOC                                        = CR_LF+"Klasse doppelt deklariert."+CR_LF
         .C_ClassTwice_Lib_LOC                                           = CR_LF+"Bibliothek: "
         .C_ClassTwice_Class_LOC                                         = CR_LF+"Klasse: "

         .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG arbeitet nur f?r Visual FoxPro 9.0!"
         .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "WARNUNG!"
         .C_GENERATING_BINARY_LOC                                        = "Gene Binary"
         .C_INCLUDING_CLASS_LOC                                          = "einschlie?lich Klasse"
         .C_INCLUDING_MEMBER_LOC                                         = "inklusive Mitglied"
         .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Falsche VFP 9 Version - SP1 fehlt! Erwartet: 3504 oder h?her, aktuell: " + Version(4)
         .C_INVALID_PARAMETER_LOC                                        = "Ung?ltige Parameter"
         .C_IS_A_FILE_LOC                                                = "ist eine DATEI"
         .C_IS_A_DIRECTORY_LOC                                           = "ist ein VERZEICHNIS"
         .C_IS_UNSUPPORTED_LOC                                           = "wird nicht unterst?tzt"
         .C_LANGUAGE_LOC                                                 = "DE"
         .C_MAIN_EXECUTION_LOC                                           = "HAUPTAUSF?HRUNG"
         .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "Men? [<<THIS.c_InputFile>>] ist NICHT im VFP 9 Format! - Bitte zuerst mit MODIFY MENU '<<THIS.c_InputFile>>' nach VFP 9 konvertieren."
         .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Programm f?r Gro?schreibungssetzung [<<lcEXE_CAPS>>] gefunden"
         .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* Programm f?r Gro?schreibungssetzung [<<lcEXE_CAPS>>] nicht gefunden"
         .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Objekt [<<toObj.CLASS>>] enth?lt nicht das oReg Objekt (level <<TRANSFORM(tnNivel)>>)"
         .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Befehl nicht erkannt. Nur SETNAME und GETNAME erlaubt."
         .C_OPTION_LOC                                                   = "Option"
         .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "Die ?u?ere Klasse zeigt nicht die die innere Klassifizierung an"
         .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "Das ?u?ere Element entspricht nicht den inneren Elementen"
         .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimierung: Ausgabedatei [<<lcOutputFile>>] wurde nicht ?berschrieben, da sie dieselbe ist wie die neu generierte."
         .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimierung: Ausgabedatei [<<THIS.c_OutputFile>>] wurde nicht verl?ngert, weil ihre Zeitmarke die gleiche der Quelldatei ist."
         .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimierung: Ausgabedatei [<<THIS.c_OutputFile>>] wurde nicht erneuert, da sie neuer als die Ursprungsdatei ist."
         .C_PRESS_ESC_TO_CANCEL                                          = "Dr?cken Sie Esc zum Abbrechen"
         .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Prozedur nicht geschlossen. Letzte Zeile des Codes muss ENDPROC sein. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
         .C_PROCESSING_LOC                                               = "Bearbeite Datei"
         .C_PROCESS_PROGRESS_LOC                                         = "Bearbeitungsfortschritt:"
         .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Eigenschaft [<<TRANSFORM(tnPropertyID)>>] nicht erkannt."
         .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Report [<<THIS.c_InputFile>>] ist NICHT in VFP 9 Format! - Bitte zuerst nach VFP 9 konvertieren mit MODIFY REPORT '<<THIS.c_InputFile>>'"
         .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Fordere Gro?schreibung f?r Datei [<<tcFileName>>] an"
         .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Scanne Datei- und Verzeichnisinformationen f?r"
         .C_SOURCEFILE_LOC                                               = "Quell Datei: "
         .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Fehler in Verschachtelungsstruktur. ENDPROC erwartet, aber es wurde ENDDEFINE in Klasse <<toClase._Nombre>> (<<loProcedure._Nombre>>), Zeile <<TRANSFORM(m.I)>> der Datei <<THIS.c_InputFile>> gefunden"
         .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Fehler in Verschachtelungsstruktur. ENDPROC wurde erwartet, aber es wurde ENDDEFINE in Klasse <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), Zeile <<TRANSFORM(m.I)>> der Datei <<THIS.c_InputFile>> gefunden"
         .C_UNKNOWN_CLASS_NAME_LOC                                       = "Unbekannte Klasse [<<THIS.CLASS>>]"
         .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Verwenden Sie die Datei-Zeitstempel-Optimierung"
         .C_WARNING_LOC                                                  = "WARNUNG!"
         .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "WARNUNG!" + CR_LF+ "STELLEN SIE SICHER, DAS KEIN TABELLENALIAS IM INDEXAUSDRUCK BENUTZT WIRD!! (z.B.: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
         .C_WITH_ERRORS_LOC                                              = "mit Fehlern"

         .C_INDEX2TXT_PROCESSING_LOC                                     = " Ermittle Index"
         .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Zus?tzliche Index Dateien"
         .C_INDEX2TXT_NOFILE_LOC                                         = "     Keine Datei "
         .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index passt nicht zur Tabelle "
         .C_INDEX2BIN_PROCESSING_LOC                                     = " Erstelle Index"
         .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs f?r den strukturellen Index"
         .C_INDEX2BIN_STANDALONE_LOC                                     = "  Eigenst?ndige Indexdatei: "
         .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs f?r verbundene Indexdatei: "
         .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Hauptdatei "'
         .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Projekt-Icon Datei "'
         .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'Datei ""'
         .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'ist nicht in der PJX Ordner Struktur, "'
         .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'siehe Option "CheckFileInPath".' + CR_LF+CR_LF

      Endwith
   Endproc
Enddefine
