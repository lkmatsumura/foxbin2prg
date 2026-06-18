#INCLUDE foxbin2prg.h

Define Class CL_DBF_CFG As Custom
   _MemberData = [<VFPData>] ;
      + [<memberdata name="dbf_conversion_support" display="DBF_Conversion_Support"/>] ;
      + [<memberdata name="dbf_conversion_order" display="DBF_Conversion_Order"/>] ;
      + [<memberdata name="dbf_conversion_condition" display="DBF_Conversion_Condition"/>] ;
      + [<memberdata name="dbf_indexlist" display="DBF_IndexList"/>] ;
      + [<memberdata name="l_dbf_binchar_base64" display="l_DBF_BinChar_Base64"/>] ;
      + [<memberdata name="l_dbf_includedeleted" display="l_DBF_IncludeDeleted"/>] ;
      + [</VFPData>]

   #If .F.
      Local This As CL_DBF_CFG Of 'cl_dbf_cfg.prg'
   #Endif

   *-- Configuration class. By default assumes master value, except when overriding one.
   n_DBF_Conversion_Support    = .Null.
   DBF_Conversion_Order        = ''
   DBF_Conversion_Condition    = ''
   DBF_IndexList               = ''
   l_DBF_BinChar_Base64        = .Null.
   l_DBF_IncludeDeleted        = .Null.

   *---------------------------------------------------------------------------------------------------
   * Factory: load per-table DBF.CFG from disk. Returns configured object or .NULL. if missing.
   * tc_InputFile  - DBF path (table.CFG is resolved as tc_InputFile + '.CFG')
   * tlGenerateLog - when .T., write parse details via toLogger.writeLog (if available)
   * toLogger      - optional host (e.g. c_foxbin2prg) for logging
   *---------------------------------------------------------------------------------------------------
   FUNCTION FromFile
      LPARAMETERS tc_InputFile, tlGenerateLog, toLogger
      LOCAL lcTableCFG, lnFileCount, laDirFile(1, 5), loCfg

      lcTableCFG  = tc_InputFile + '.CFG'
      lnFileCount = ADIR(laDirFile, lcTableCFG)

      IF lnFileCount <> 1
         RETURN .NULL.
      ENDIF

      loCfg = NewObject('CL_DBF_CFG', 'cl_dbf_cfg.prg')
      loCfg.loadFromFile(lcTableCFG, tlGenerateLog, toLogger)
      RETURN loCfg
   ENDFUNC

   *---------------------------------------------------------------------------------------------------
   * Populate this instance from an existing DBF.CFG file path.
   *---------------------------------------------------------------------------------------------------
   PROCEDURE loadFromFile
      LPARAMETERS tcCfgFile, tlGenerateLog, toLogger
      LOCAL laConfig(1), I, lcConfigItem, lcValue

      IF tlGenerateLog AND VARTYPE(toLogger) = 'O' AND PEMSTATUS(toLogger, 'writeLog', 5)
         toLogger.writeLog()
         toLogger.writeLog(' > Found DBF configuration file: ' + tcCfgFile)
      ENDIF

      FOR I = 1 TO ALINES(laConfig, FILETOSTR(tcCfgFile), 1 + 4)
         lcConfigItem = LOWER(laConfig(m.I))

         DO CASE
         CASE INLIST(LEFT(lcConfigItem, 1), '*', '#', '/', "'")
            LOOP

         CASE LEFT(lcConfigItem, 23) == LOWER('DBF_Conversion_Support:')
            This.n_DBF_Conversion_Support = INT(VAL(SUBSTR(laConfig(m.I), 24)))
            IF tlGenerateLog AND VARTYPE(toLogger) = 'O' AND PEMSTATUS(toLogger, 'writeLog', 5)
               toLogger.writeLog('     ' + JUSTFNAME(tcCfgFile) + ' > DBF_Conversion_Support: ' + TRANSFORM(This.n_DBF_Conversion_Support))
            ENDIF

         CASE LEFT(lcConfigItem, 21) == LOWER('DBF_Conversion_Order:')
            This.DBF_Conversion_Order = ALLTRIM(SUBSTR(laConfig(m.I), 22, AT('&' + '&', laConfig(m.I)) - 22))
            IF tlGenerateLog AND VARTYPE(toLogger) = 'O' AND PEMSTATUS(toLogger, 'writeLog', 5)
               toLogger.writeLog('     ' + JUSTFNAME(tcCfgFile) + ' > DBF_Conversion_Order: ' + This.DBF_Conversion_Order)
            ENDIF

         CASE LEFT(lcConfigItem, 25) == LOWER('DBF_Conversion_Condition:')
            This.DBF_Conversion_Condition = ALLTRIM(SUBSTR(laConfig(m.I), 26, AT('&' + '&', laConfig(m.I)) - 26))
            IF tlGenerateLog AND VARTYPE(toLogger) = 'O' AND PEMSTATUS(toLogger, 'writeLog', 5)
               toLogger.writeLog('     ' + JUSTFNAME(tcCfgFile) + ' > DBF_Conversion_Condition: ' + This.DBF_Conversion_Condition)
            ENDIF

         CASE LEFT(lcConfigItem, 14) == LOWER('DBF_IndexList:')
            This.DBF_IndexList = SUBSTR(laConfig(m.I), 15, AT('&' + '&', laConfig(m.I)) - 15)
            IF tlGenerateLog AND VARTYPE(toLogger) = 'O' AND PEMSTATUS(toLogger, 'writeLog', 5)
               toLogger.writeLog('     ' + JUSTFNAME(tcCfgFile) + ' >DBF_IndexList:           ' + TRANSFORM(This.DBF_IndexList))
            ENDIF

         CASE LEFT(lcConfigItem, 19) == LOWER('DBF_BinChar_Base64:')
            lcValue = ALLTRIM(SUBSTR(laConfig(m.I), 20))
            IF INLIST(m.lcValue, '0', '1')
               This.l_DBF_BinChar_Base64 = (TRANSFORM(m.lcValue) == '1')
               IF tlGenerateLog AND VARTYPE(toLogger) = 'O' AND PEMSTATUS(toLogger, 'writeLog', 5)
                  toLogger.writeLog('     ' + JUSTFNAME(tcCfgFile) + ' > DBF_BinChar_Base64:     ' + TRANSFORM(This.l_DBF_BinChar_Base64))
               ENDIF
            ENDIF

         CASE LEFT(lcConfigItem, 19) == LOWER('DBF_IncludeDeleted:')
            lcValue = ALLTRIM(SUBSTR(laConfig(m.I), 20))
            IF INLIST(m.lcValue, '0', '1')
               This.l_DBF_IncludeDeleted = (TRANSFORM(m.lcValue) == '1')
               IF tlGenerateLog AND VARTYPE(toLogger) = 'O' AND PEMSTATUS(toLogger, 'writeLog', 5)
                  toLogger.writeLog('     ' + JUSTFNAME(tcCfgFile) + ' > DBF_IncludeDeleted:     ' + TRANSFORM(This.l_DBF_IncludeDeleted))
               ENDIF
            ENDIF
         ENDCASE
      ENDFOR

      IF tlGenerateLog AND VARTYPE(toLogger) = 'O' AND PEMSTATUS(toLogger, 'writeLog', 5)
         toLogger.writeLog()
      ENDIF

      RETURN 1
   ENDPROC

Enddefine
