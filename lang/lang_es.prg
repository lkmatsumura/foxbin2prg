#INCLUDE foxbin2prg.h

*---------------------------------------------------------------------------------------------------
*- Spanish strings for CL_LANG
*---------------------------------------------------------------------------------------------------

PROCEDURE Lang_Apply_ES
   LPARAMETERS toLang

   WITH toLang
      .C_ALLOWED_VALUES_ARE_LOC                                       = "Los valores permitidos son"
      .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "No se admiten extensiones * o ? porque es peligroso (se pueden pisar binarios con archivo xx2 vacíos)."
      .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "No se pudo actualizar el backlink"
      .C_BACKLINK_OF_TABLE_LOC                                        = "de la tabla"
      .C_BACKUP_OF_LOC                                                = "Haciendo Backup de: "
      .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "No se puede generar el archivo [<<THIS.c_OutputFile>>] porque es ReadOnly"
      .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimización: El archivo Base [<<JUSTFNAME(.c_InputFile)>>] ya fue procesado, ignorando el procesamiento del archivo [<<tc_InputFile>>]"
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
      .C_ERRORS_FOUND_IN_FILE_LOC                                     = "SE HAN ENCONTRADOS ERRORES EN EL ARCHIVO"
      .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "No se encontró la clase externa"
      .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "No se encontró el miembro externo"
      .C_EXTERNAL_PARAMETERS_LOC                                      = "PARÁMETROS EXTERNOS"
      .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "No se encontró el campo [<<laProps(m.I)>>] en la estructura del archivo <<DBF('TABLABIN')>>"
      .C_FILE_DOESNT_EXIST_LOC                                        = "El archivo no existe:"
      .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "El archivo [<<.c_InputFile>>] no está soportado"
      .C_FILE_NOT_FOUND_LOC                                           = "No se encontró el archivo"
      .C_FILENAME_LOC                                                 = "Archivo"
      .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERROR"
      .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "REFERENCIA DE CONFIGURACIÓN"
      .C_CFG_REF_TITLE_LOC                                            = "Referencia de configuración"
      .C_CFG_REF_INTRO_LOC                                            = "Configuración programática para FoxBin2Prg (sin archivos .cfg en disco)."
      TEXT TO .C_CFG_REF_USAGE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
         <<>>loCfg = loF2b.newConfig()  && clonar valores de fábrica
         <<>>loCfg.l_NoTimestamps = .T. && sobrescribir propiedades
         <<>>loF2b.exportProjectTree( lcPjx, lcDest, loCfg )
         <<>>loF2b.importProjectTree( lcPj2, lcDest, loCfg )
         <<>>DO main.prg WITH lcFile, '', loCfg"
      ENDTEXT
      .C_CFG_REF_SEC_GENERAL_LOC                                      = "General"
      .C_CFG_REF_SEC_TIMESTAMPS_LOC                                   = "Marcas de tiempo / metadatos"
      .C_CFG_REF_SEC_CLASSFORM_LOC                                    = "Clases / Formularios"
      .C_CFG_REF_SEC_MIRROR_LOC                                       = "Árbol espejo (exportProjectTree)"
      .C_CFG_REF_SEC_DBF_LOC                                          = "DBF / DBC / soporte de conversión"
      .C_CFG_REF_SEC_EXTENSIONS_LOC                                   = "Extensiones de archivos de texto"
      .C_ClassTwice_Header_LOC                                        = CR_LF+"Clase definida dos veces."+CR_LF
      .C_ClassTwice_Lib_LOC                                           = CR_LF+"Biblioteca: "
      .C_ClassTwice_Class_LOC                                         = CR_LF+"Clase: "

      .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "¡FOXBIN2PRG es solo para Visual FoxPro 9.0!"
      .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "¡ATENCIÓN!"
      .C_GENERATING_BINARY_LOC                                        = "Generando Binario"
      .C_INCLUDING_CLASS_LOC                                          = "Incluyendo clase"
      .C_INCLUDING_MEMBER_LOC                                         = "Incluyendo miembro"
      .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Versión Incorrecta de VFP 9 - Falta el SP1! Esperado: 3504 o posterior, actual: " + Version(4)
      .C_INVALID_PARAMETER_LOC                                        = "Parámetro inválido"
      .C_IS_A_FILE_LOC                                                = "es un ARCHIVO"
      .C_IS_A_DIRECTORY_LOC                                           = "es un DIRECTORIO"
      .C_IS_UNSUPPORTED_LOC                                           = "no está soportado"
      .C_LANGUAGE_LOC                                                 = "ES"
      .C_MAIN_EXECUTION_LOC                                           = "EJECUCIÓN PRINCIPAL"
      .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "El Menú [<<THIS.c_InputFile>>] NO está en formato VFP 9! - Por favor convertirlo a VFP 9 con MODIFY MENU '<<THIS.c_InputFile>>'"
      .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Se ha encontrado el programa de capitalización de nombres [<<lcEXE_CAPS>>]"
      .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* No se ha encontrado el programa de capitalización de nombres [<<lcEXE_CAPS>>]"
      .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Objeto [<<toObj.CLASS>>] no contiene el objeto oReg (nivel <<TRANSFORM(tnNivel)>>)"
      .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Operación no reconocida. Solo re reconoce SETNAME y GETNAME."
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
      .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "El Reporte [<<THIS.c_InputFile>>] NO está en formato VFP 9! - Por favor convertirlo a VFP 9 con MODIFY REPORT '<<THIS.c_InputFile>>'"
      .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Solicitado capitalizar el archivo [<<tcFileName>>]"
      .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Escaneando archivos e información de directorio para"
      .C_SOURCEFILE_LOC                                               = "Archivo origen: "
      .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Error de anidamiento de estructuras. Se esperaba ENDPROC pero se encontró ENDDEFINE en la clase <<toClase._Nombre>> (<<loProcedure._Nombre>>), línea <<TRANSFORM(m.I)>> del archivo <<THIS.c_InputFile>>"
      .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Error de anidamiento de estructuras. Se esperaba ENDPROC pero se encontró ENDDEFINE en la clase <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), línea <<TRANSFORM(m.I)>> del archivo <<THIS.c_InputFile>>"
      .C_UNKNOWN_CLASS_NAME_LOC                                       = "Clase [<<THIS.CLASS>>] desconocida"
      .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Usar Optimización de filestamp de archivo"
      .C_WARNING_LOC                                                  = "¡ATENCIÓN!"
      .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "¡ATENCIÓN!" + CR_LF+ "ASEGÚRESE DE QUE NO ESTÁ USANDO UN ALIAS DE TABLA EN LAS EXPRESIONES DE LOS ÍNDICES!! (ej: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag nombreclave)"
      .C_WITH_ERRORS_LOC                                              = "con errores"

      .C_INDEX2TXT_PROCESSING_LOC                                     = " Procesando índice"
      .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Archivos de índice adicionales"
      .C_INDEX2TXT_NOFILE_LOC                                         = "     No es un archivo "
      .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   El índice no coincide con la tabla "
      .C_INDEX2BIN_PROCESSING_LOC                                     = " Creando índice"
      .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs para índice estructural"
      .C_INDEX2BIN_STANDALONE_LOC                                     = "  Índice independiente "
      .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs para índice compuesto "
      .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Archivo principal "'
      .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Archivo de icono del proyecto "'
      .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'Archivo ""'
      .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'no está en la estructura de carpetas PJX, "'
      .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'revise la opción "CheckFileInPath".' + CR_LF+CR_LF

      .n_LanguageSelectedMethod   = 0 && 0=Automatic with VERSION(3)
   ENDWITH

ENDPROC
