#INCLUDE foxbin2prg.h

Define Class CL_LANG_FR As CL_LANG Of 'cl_lang.prg'
   Procedure Init
     NODEFAULT
   Endproc

   Procedure Lang_Apply
   Lparameters toLang As CL_LANG
      IF ! Vartype(toLang) == 'O'
         toLang = This
      ENDIF

      With toLang
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
            <<>>DO main.prg WITH lcFile, '', loCfg
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
