#INCLUDE foxbin2prg.h

*---------------------------------------------------------------------------------------------------
*- French strings for CL_LANG
*---------------------------------------------------------------------------------------------------

PROCEDURE Lang_Apply_FR
   LPARAMETERS toLang

   WITH toLang
      .C_ALLOWED_VALUES_ARE_LOC                                       = "Les valeurs autorisées sont"
      .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "* Et ? extensions ne sont pas autorisées car il est dangereux (binaires peuvent être remplacés par des fichiers vides de XX2)"
      .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Impossible de mettre à jour backlink"
      .C_BACKLINK_OF_TABLE_LOC                                        = "de la table"
      .C_BACKUP_OF_LOC                                                = "Faire de sauvegarde des: "
      .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Vous ne pouvez pas générer un fichier [<<THIS.c_OutputFile>>] car il est en lecture seule"
      .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimisation: Fichier de base [<<JUSTFNAME(.c_InputFile)>>] Déjà traitée, en sautant traitement de fichier [<<tc_InputFile>>]"
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
      .C_ERRORS_FOUND_IN_FILE_LOC                                     = "ERREURS TROUVÉ DANS LE FICHIER"
      .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "Aucune classe externe est trouvé"
      .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "Nom de membre externe n'a pas été trouvé"
      .C_EXTERNAL_PARAMETERS_LOC                                      = "PARAMÈTRES EXTERNES"
      .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Champ [<< laProps (m.I) >>] ne trouve pas dans la structure du fichier DBF <<('TABLABIN')>>"
      .C_FILE_DOESNT_EXIST_LOC                                        = "Fichier ne existe pas:"
      .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "File [<<.c_InputFile>>] ne est pas supporté"
      .C_FILE_NOT_FOUND_LOC                                           = "Fichier introuvable"
      .C_FILENAME_LOC                                                 = "Fichier"
      .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERREUR"
      .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "RÉFÉRENCE DE CONFIGURATION"
      .C_CFG_REF_TITLE_LOC                                            = "Référence de configuration"
      .C_CFG_REF_INTRO_LOC                                            = "Configuration programmatique pour FoxBin2Prg (pas de fichiers .cfg sur disque)."
      TEXT TO .C_CFG_REF_USAGE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
         <<>>loCfg = loF2b.newConfig()  && cloner les valeurs d'usine
         <<>>loCfg.l_NoTimestamps = .T. && remplacer les propriétés
         <<>>loF2b.exportProjectTree( lcPjx, lcDest, loCfg )
         <<>>loF2b.importProjectTree( lcPj2, lcDest, loCfg )
         <<>>DO main.prg WITH lcFile, '', loCfg"
      ENDTEXT
      .C_CFG_REF_SEC_GENERAL_LOC                                      = "Général"
      .C_CFG_REF_SEC_TIMESTAMPS_LOC                                   = "Horodatages / métadonnées"
      .C_CFG_REF_SEC_CLASSFORM_LOC                                    = "Classes / Formulaires"
      .C_CFG_REF_SEC_MIRROR_LOC                                       = "Arbre miroir (exportProjectTree)"
      .C_CFG_REF_SEC_DBF_LOC                                          = "DBF / DBC / prise en charge conversion"
      .C_CFG_REF_SEC_EXTENSIONS_LOC                                   = "Extensions de fichiers texte"
      .C_ClassTwice_Header_LOC                                        = CR_LF+"Classe définie deux fois."+CR_LF
      .C_ClassTwice_Lib_LOC                                           = CR_LF+"Bibliothèque: "
      .C_ClassTwice_Class_LOC                                         = CR_LF+"Classe: "
      .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG est seulement pour Visual FoxPro 9.0!"
      .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "AVERTISSEMENT!"
      .C_GENERATING_BINARY_LOC                                        = "Génération Binaire"
      .C_INCLUDING_CLASS_LOC                                          = "classe, y compris"
      .C_INCLUDING_MEMBER_LOC                                         = "membres, y compris"
      .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Version VFP 9 incorrecte - SP1 manquant! Attendu: 3504 ou plus tard, actuel: " + Version(4)
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
      .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Rapport [<<THIS.c_InputFile>>] ne est pas dans VFP 9 Format! - Se il vous plaît se convertir à VFP 9 avec MODIFY REPORT '<<THIS.c_InputFile>>'"
      .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Demande de capitalisation de fichier [<<tcFileName>>]"
      .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Fichier de numérisation et de l'information de répertoire pour"
      .C_SOURCEFILE_LOC                                               = "Fichier source: "
      .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Nesting erreur de structure. ENDPROC prévu, mais a trouvé ENDDEFINE sur la classe <<toClase._Nombre>> (<<loProcedure._Nombre>>), ligne <<TRANSFORM(m.I)>> du fichier <<THIS.c_InputFile>>"
      .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Nesting erreur de structure. ENDPROC attendue, mais ENDDEFINE sur la classe <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), ligne <<TRANSFORM(m.I)>> du fichier <<THIS.c_InputFile>>"
      .C_UNKNOWN_CLASS_NAME_LOC                                       = "Classe inconnue[<<THIS.CLASS>>]"
      .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Utilisez le fichier Optimisation d'horodatage"
      .C_WARNING_LOC                                                  = "AVERTISSEMENT!"
      .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "AVERTISSEMENT!" + CR_LF+ "ASSUREZ VOUS NE UTILISEZ PAS UN ALIAS DE TABLE SUR LES EXPRESSIONS INDEX CLÉS!! (exemple: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
      .C_WITH_ERRORS_LOC                                              = "avec des erreurs"

      .C_INDEX2TXT_PROCESSING_LOC                                     = " Traitement de l'index"
      .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Fichiers d'index supplémentaires"
      .C_INDEX2TXT_NOFILE_LOC                                         = "     Pas un fichier "
      .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   L'index ne correspond pas à la table "
      .C_INDEX2BIN_PROCESSING_LOC                                     = " Création de l'index"
      .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs pour l'index structurel"
      .C_INDEX2BIN_STANDALONE_LOC                                     = "  Index autonome "
      .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs pour l'index composé "
      .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Fichier principal "'
      .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Fichier icône du projet "'
      .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'Fichier ""'
      .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'absent de la structure de dossiers PJX, "'
      .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + [voir l''option "CheckFileInPath".] + CR_LF+CR_LF

      .n_LanguageSelectedMethod   = 0 && 0=Automatic with VERSION(3)
   ENDWITH

ENDPROC
