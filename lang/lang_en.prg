#INCLUDE foxbin2prg.h

*---------------------------------------------------------------------------------------------------
*- English strings for CL_LANG (fallback)
*---------------------------------------------------------------------------------------------------

PROCEDURE Lang_Apply_EN
   LPARAMETERS toLang

   WITH toLang
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

      .n_LanguageSelectedMethod   = 0 && 0=Automatic with VERSION(3)
   ENDWITH

ENDPROC
