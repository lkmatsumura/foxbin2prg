#DEFINE DN_FB2PRG_VERSION           4.00
#DEFINE DC_FB2PRG_VERSION_REAL      '4.00.00'

*-- Configuration object marker (CREATEOBJECT('Empty') + ADDPROPERTY via c_foxbin2prg.newConfig)
#DEFINE CFG_TYPE_MARKER             'FoxBin2Prg_CFG'

*-- NO modificar! / Do NOT change!
#DEFINE C_CMT_I                     '*--'
#DEFINE C_CMT_F                     '--*'
#DEFINE C_CLASSCOMMENTS_I           '*<ClassComment>'
#DEFINE C_CLASSCOMMENTS_F           '*</ClassComment>'
#DEFINE C_LEN_CLASSCOMMENTS_I       Len(C_CLASSCOMMENTS_I)
#DEFINE C_LEN_CLASSCOMMENTS_F       Len(C_CLASSCOMMENTS_F)
#DEFINE C_CLASSDATA_I               '*< CLASSDATA:'
#DEFINE C_CLASSDATA_F               '/>'
#DEFINE C_LEN_CLASSDATA_I           Len(C_CLASSDATA_I)
#DEFINE C_EXTERNAL_CLASS_I          '*< EXTERNAL_CLASS:'
#DEFINE C_EXTERNAL_CLASS_F          '/>'
#DEFINE C_LEN_EXTERNAL_CLASS_I      Len(C_EXTERNAL_CLASS_I)
#DEFINE C_EXTERNAL_MEMBER_I         '*< EXTERNAL_MEMBER:'
#DEFINE C_EXTERNAL_MEMBER_F         '/>'
#DEFINE C_LEN_EXTERNAL_MEMBER_I     Len(C_EXTERNAL_MEMBER_I)
#DEFINE C_OBJECTDATA_I              '*< OBJECTDATA:'
#DEFINE C_OBJECTDATA_F              '/>'
#DEFINE C_LEN_OBJECTDATA_I          Len(C_OBJECTDATA_I)
#DEFINE C_OLE_I                     '*< OLE:'
#DEFINE C_OLE_F                     '/>'
#DEFINE C_LEN_OLE_I                 Len(C_OLE_I)
#DEFINE C_DEFINED_PAM_I             '*<DefinedPropArrayMethod>'
#DEFINE C_DEFINED_PAM_F             '*</DefinedPropArrayMethod>'
#DEFINE C_LEN_DEFINED_PAM_I         Len(C_DEFINED_PAM_I)
#DEFINE C_LEN_DEFINED_PAM_F         Len(C_DEFINED_PAM_F)

*mark property value section in classes, objects and forms
#DEFINE C_DEFINED_PROPVAL_I         '*<PropValue>'
#DEFINE C_DEFINED_PROPVAL_F         '*</PropValue>'
#DEFINE C_LEN_DEFINED_PROPVAL_I     Len(C_DEFINED_PROPVAL_I)
#DEFINE C_LEN_DEFINED_PROPVAL_F     Len(C_DEFINED_PROPVAL_F)

#DEFINE C_END_OBJECT_I              '*< END OBJECT:'
#DEFINE C_END_OBJECT_F              '/>'
#DEFINE C_LEN_END_OBJECT_I          Len(C_END_OBJECT_I)
#DEFINE C_FB2PRG_META_I             '*< FOXBIN2PRG:'
#DEFINE C_FB2PRG_META_F             '/>'
#DEFINE C_LIBCOMMENT_I              '*< LIBCOMMENT:'
#DEFINE C_LIBCOMMENT_F              '/>'
#DEFINE C_DEFINE_CLASS              'DEFINE CLASS'
#DEFINE C_ENDDEFINE                 'ENDDEFINE'
#DEFINE C_TEXT                      'TEXT'
#DEFINE C_ENDTEXT                   'ENDTEXT'
#DEFINE C_PROCEDURE                 'PROCEDURE'
#DEFINE C_ENDPROC                   'ENDPROC'
#DEFINE C_WITH                      'WITH'
#DEFINE C_ENDWITH                   'ENDWITH'
#DEFINE C_SRV_HEAD_I                '*<ServerHead>'
#DEFINE C_SRV_HEAD_F                '*</ServerHead>'
#DEFINE C_SRV_DATA_I                '*<ServerData>'
#DEFINE C_SRV_DATA_F                '*</ServerData>'
#DEFINE C_DEVINFO_I                 '*<DevInfo>'
#DEFINE C_DEVINFO_F                 '*</DevInfo>'
#DEFINE C_BUILDPROJ_I               '*<BuildProj>'
#DEFINE C_BUILDPROJ_F               '*</BuildProj>'
#DEFINE C_PROJPROPS_I               '*<ProjectProperties>'
#DEFINE C_PROJPROPS_F               '*</ProjectProperties>'
#DEFINE C_FILE_META_I               '*< FileMetadata:'
#DEFINE C_FILE_META_F               '/>'
#DEFINE C_FILE_CMTS_I               '*<FileComments>'
#DEFINE C_FILE_CMTS_F               '*</FileComments>'
#DEFINE C_FILE_EXCL_I               '*<ExcludedFiles>'
#DEFINE C_FILE_EXCL_F               '*</ExcludedFiles>'
#DEFINE C_FILE_TXT_I                '*<TextFiles>'
#DEFINE C_FILE_TXT_F                '*</TextFiles>'
#DEFINE C_FB2P_VALUE_I              '<fb2p_value>'
#DEFINE C_FB2P_VALUE_F              '</fb2p_value>'
#DEFINE C_LEN_FB2P_VALUE_I          Len(C_FB2P_VALUE_I)
#DEFINE C_LEN_FB2P_VALUE_F          Len(C_FB2P_VALUE_F)
#DEFINE C_VFPDATA_I                 '<VFPData>'
#DEFINE C_VFPDATA_F                 '</VFPData>'
#DEFINE C_MEMBERDATA_I              C_VFPDATA_I
#DEFINE C_MEMBERDATA_F              C_VFPDATA_F
#DEFINE C_LEN_MEMBERDATA_I          Len(C_MEMBERDATA_I)
#DEFINE C_LEN_MEMBERDATA_F          Len(C_MEMBERDATA_F)
#DEFINE C_DATA_I                    '<![CDATA['
#DEFINE C_DATA_F                    ']]>'
#DEFINE C_TAG_REPORTE               'Reportes'
#DEFINE C_TAG_REPORTE_I             '<' + C_TAG_REPORTE + '>'
#DEFINE C_TAG_REPORTE_F             '</' + C_TAG_REPORTE + '>'
#DEFINE C_DBF_HEAD_I                '<DBF'
#DEFINE C_DBF_HEAD_F                '/>'
#DEFINE C_LEN_DBF_HEAD_I            Len(C_DBF_HEAD_I)
#DEFINE C_LEN_DBF_HEAD_F            Len(C_DBF_HEAD_F)
#DEFINE C_CDXIDX_I                  '<IndexFiles>'      && SF written, but not  read
#DEFINE C_CDXIDX_F                  '</IndexFiles>'     && SF written, but not  read
#DEFINE C_CDX_I                     '<IndexFile'        && SF written, but not  read
#DEFINE C_CDX_F                     '</IndexFile>'      && SF written, but not  read
#DEFINE C_CDX_Type_                 'Type="'
#DEFINE C_CDX_Type_Struct           'Structural'
#DEFINE C_CDX_Type_Compound         'Compound'
#DEFINE C_CDX_Type_IDX              'Standalone'
#DEFINE C_CDX_File_                 'File="'
#DEFINE C_INDEXES_I                 '<INDEXES>'         && SF Read / write, no len, used w/o #DEFINE too, len
#DEFINE C_INDEXES_F                 '</INDEXES>'        && SF Read / write, no len, used w/o #DEFINE too, len
#DEFINE C_INDEX_I                   '<INDEX>'           && SF used for read, not write?
#DEFINE C_INDEX_F                   '</INDEX>'          && SF used for read, not write?
#DEFINE C_DATABASE_I                '<DATABASE>'
#DEFINE C_DATABASE_F                '</DATABASE>'
#DEFINE C_STORED_PROC_I             '<STOREDPROCEDURES><![CDATA['
#DEFINE C_STORED_PROC_F             ']]></STOREDPROCEDURES>'
#DEFINE C_TABLE_I                   '<TABLE>'
#DEFINE C_TABLE_F                   '</TABLE>'
#DEFINE C_TABLES_I                  '<TABLES>'
#DEFINE C_TABLES_F                  '</TABLES>'
#DEFINE C_VIEW_I                    '<VIEW>'
#DEFINE C_VIEW_F                    '</VIEW>'
#DEFINE C_VIEWS_I                   '<VIEWS>'
#DEFINE C_VIEWS_F                   '</VIEWS>'
#DEFINE C_FIELD_ORDER_I             '<FIELD_ORDER>'
#DEFINE C_FIELD_ORDER_F             '</FIELD_ORDER>'
#DEFINE C_FIELD_I                   '<FIELD>'
#DEFINE C_FIELD_F                   '</FIELD>'
#DEFINE C_FIELDS_I                  '<FIELDS>'
#DEFINE C_FIELDS_F                  '</FIELDS>'
#DEFINE C_CONNECTION_I              '<CONNECTION>'
#DEFINE C_CONNECTION_F              '</CONNECTION>'
#DEFINE C_CONNECTIONS_I             '<CONNECTIONS>'
#DEFINE C_CONNECTIONS_F             '</CONNECTIONS>'
#DEFINE C_RELATION_I                '<RELATION>'
#DEFINE C_RELATION_F                '</RELATION>'
#DEFINE C_RELATIONS_I               '<RELATIONS>'
#DEFINE C_RELATIONS_F               '</RELATIONS>'
#DEFINE C_PROC_CODE_I               '*<Procedures>'
#DEFINE C_PROC_CODE_F               '*</Procedures>'
#DEFINE C_SETUPCODE_I               '*<SetupCode>'
#DEFINE C_SETUPCODE_F               '*</SetupCode>'
#DEFINE C_CLEANUPCODE_I             '*<CleanupCode>'
#DEFINE C_CLEANUPCODE_F             '*</CleanupCode>'
#DEFINE C_MENUCODE_I                '*<MenuCode>'
#DEFINE C_MENUCODE_F                '*</MenuCode>'
#DEFINE C_MENUTYPE_I                '*<MenuType>'
#DEFINE C_MENUTYPE_F                '</MenuType>'
#DEFINE C_MENULOCATION_I            '*<MenuLocation>'
#DEFINE C_MENULOCATION_F            '</MenuLocation>'
*--
#DEFINE C_TAB                       Chr(9)
#DEFINE C_CR                        Chr(13)
#DEFINE C_LF                        Chr(10)
#DEFINE C_NULL_CHAR                 Chr(0)
#DEFINE CR_LF                       C_CR + C_LF
#DEFINE C_MPROPHEADER               Replicate( Chr(1), 517 )

*** DH 06/02/2014: added additional constants
#DEFINE C_RECORDS_I                 '<RECORDS>'
#DEFINE C_RECORDS_F                 '</RECORDS>'
#DEFINE C_RECORD_I                  '<RECORD>'  && *** FDBOZZO 2016/06/06: Quitado el REGNUM para evitar diferencias innecesarias
#DEFINE C_RECORD_F                  '</RECORD>'
#DEFINE C_DEL_RECORD_I              '<DELRECORD>'   && *** LScheffler 2021/02/20: Deleted Record, just mark like this, no fuzz with field name
#DEFINE C_DEL_RECORD_F              '</DELRECORD>'
#DEFINE C_RECNO_I                   '<RECNO>'
#DEFINE C_RECNO_F                   '</RECNO>'

*-- From FOXPRO.H
*-- File Object Type Property
#DEFINE FILETYPE_DATABASE           "d"  && Database (.DBC)
#DEFINE FILETYPE_FREETABLE          "D"  && Free table (.DBF)
#DEFINE FILETYPE_QUERY              "Q"  && Query (.QPR)
#DEFINE FILETYPE_FORM               "K"  && Form (.SCX)
#DEFINE FILETYPE_REPORT             "R"  && Report (.FRX)
#DEFINE FILETYPE_LABEL              "B"  && Label (.LBX)
#DEFINE FILETYPE_CLASSLIB           "V"  && Class Library (.VCX)
#DEFINE FILETYPE_PROGRAM            "P"  && Program (.PRG)
#DEFINE FILETYPE_PROJECT            "J"  && Project (.PJX) [NON STANDARD!]
#DEFINE FILETYPE_APILIB             "L"  && API Library (.FLL)
#DEFINE FILETYPE_APPLICATION        "Z"  && Application (.APP)
#DEFINE FILETYPE_MENU               "M"  && Menu (.MNX)
#DEFINE FILETYPE_TEXT               "T"  && Text (.TXT, .H., etc.)
#DEFINE FILETYPE_OTHER              "x"  && Other file types not enumerated above

*-- FileTypes for ADIR()
#DEFINE C_FILETYPE_DIRECTORY        "D"
#DEFINE C_FILETYPE_FILE             "F"
#DEFINE C_FILETYPE_QUERYSUPPORT     "Q"
#DEFINE C_FILETYPE_CONFIG           "C"

*-- execute() dispatch modes (resolveExecuteMode)
#DEFINE C_EXEC_VFP8_WARN            0
#DEFINE C_EXEC_EMPTY_UI             1
#DEFINE C_EXEC_BIN3PRG              2
#DEFINE C_EXEC_PRG3BIN              3
#DEFINE C_EXEC_WILDCARD             4
#DEFINE C_EXEC_DIR_BIN2PRG          5
#DEFINE C_EXEC_DIR_PRG2BIN          6
#DEFINE C_EXEC_PROJECT_PJX          7
#DEFINE C_EXEC_PROJECT_PJ2          8
#DEFINE C_EXEC_SINGLE_FILE          9
#DEFINE C_EXEC_WILDCARD_ERROR      10
#DEFINE C_EXEC_UNSUPPORTED_BIN2PRG 11
#DEFINE C_EXEC_UNSUPPORTED_PRG2BIN 12

*-- Menu OBJTYPE constants
#DEFINE C_OBJTYPE_MENUTYPE_DEFAULT          1
#DEFINE C_OBJTYPE_MENUTYPE_BARorPOPUP       2
#DEFINE C_OBJTYPE_MENUTYPE_OPTION           3
#DEFINE C_OBJTYPE_MENUTYPE_SHORTCUT         4
#DEFINE C_OBJTYPE_MENUTYPE_MENUBARONTOP     5

*-- Menu OBJCODE constants
#DEFINE C_OBJCODE_MENUBARPOPUP_MENUPAD      0
#DEFINE C_OBJCODE_MENUBARPOPUP_MENUBAR      1
#DEFINE C_OBJCODE_MENUDEFAULT_DEFAULT       22
#DEFINE C_OBJCODE_MENUOPTION_COMMAND        67
#DEFINE C_OBJCODE_MENUOPTION_SUBMENU        77
#DEFINE C_OBJCODE_MENUOPTION_BARNUM         78
#DEFINE C_OBJCODE_MENUOPTION_PROCEDURE      80

*-- Menu Location constants
#DEFINE C_MENULOCATION_REPLACE              0
#DEFINE C_MENULOCATION_APPEND               1
#DEFINE C_MENULOCATION_BEFORE               2
#DEFINE C_MENULOCATION_AFTER                3

*-- Server Object Instancing Property
#DEFINE SERVERINSTANCE_SINGLEUSE            1  && Single use server
#DEFINE SERVERINSTANCE_NOTCREATABLE         2  && Instances creatable only inside Visual FoxPro
#DEFINE SERVERINSTANCE_MULTIUSE             3  && Multi-use server
