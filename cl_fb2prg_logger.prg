#INCLUDE foxbin2prg.h

*---------------------------------------------------------------------------------------------------
* Session logging for FoxBin2Prg (used via c_foxbin2prg.o_Logger).
*
* Buffers debug text in o_Host.c_TextLog / c_TextErr; flush writes to c_LogFile / c_ErrorLogFile.
* Error output to console uses o_Host.o_FileUtils.errOut (stdout already in cl_file_utils).
*---------------------------------------------------------------------------------------------------

DEFINE CLASS cl_fb2prg_logger AS Custom
   * o_Host  Back-reference to c_foxbin2prg (c_TextLog, c_LogFile, c_InputFile, l_Error, etc.)
   o_Host = .NULL.

   PROCEDURE Init
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toHost                    (v! IN    ) c_foxbin2prg session that owns this logger
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toHost
      This.o_Host = toHost
   ENDPROC


   PROCEDURE Destroy
      This.o_Host = .NULL.
   ENDPROC


   PROCEDURE writeLog
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                    (v? IN    ) Line to append to the in-memory debug log (c_TextLog)
      * tnTimeStamp               (v? IN    ) 0 = none, 1 = prefix, 2 = suffix (TTOC datetime)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcText, tnTimeStamp
      LOCAL loHost

      TRY
         loHost = This.o_Host
         IF VARTYPE(loHost) <> 'O'
            RETURN
         ENDIF

         loHost.c_TextLog = loHost.c_TextLog ;
            + IIF( EVL(tnTimeStamp,0) = 1, TTOC(DATETIME(),3) + '  ', '' ) ;
            + EVL(tcText,'') ;
            + IIF( EVL(tnTimeStamp,0) = 2, '  ' + TTOC(DATETIME(),3), '' ) ;
            + CR_LF
      CATCH
      ENDTRY
   ENDPROC


   PROCEDURE writeLog_Flush
      LOCAL loHost

      loHost = This.o_Host
      IF VARTYPE(loHost) <> 'O'
         RETURN
      ENDIF

      IF loHost.getCfgValue('n_Debug') > 0 AND NOT EMPTY(loHost.c_TextLog)
         STRTOFILE( loHost.c_TextLog + CR_LF, loHost.c_LogFile, 1 )
      ENDIF
      loHost.c_TextLog = ''
   ENDPROC


   PROCEDURE writeErrorLog
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                    (v? IN    ) Line to append to c_TextErr and emit via errOut
      * tnTimeStamp               (v? IN    ) 0 = none, 1 = prefix, 2 = suffix (TTOC datetime)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcText, tnTimeStamp
      LOCAL loHost

      TRY
         loHost = This.o_Host
         IF VARTYPE(loHost) <> 'O'
            RETURN
         ENDIF

         loHost.c_TextErr = loHost.c_TextErr ;
            + IIF( EVL(tnTimeStamp,0) = 1, TTOC(DATETIME(),3) + '  ', '' ) ;
            + EVL(tcText,'') ;
            + IIF( EVL(tnTimeStamp,0) = 2, '  ' + TTOC(DATETIME(),3), '' ) ;
            + CR_LF

         loHost.ensureFileUtils()
         loHost.o_FileUtils.errOut(tcText)
         loHost.l_Error  = .T.
         loHost.l_Errors = .T.
      CATCH
      ENDTRY
   ENDPROC


   PROCEDURE writeErrorLog_Flush
      LOCAL loHost

      loHost = This.o_Host
      IF VARTYPE(loHost) <> 'O'
         RETURN
      ENDIF

      IF NOT EMPTY(loHost.c_TextErr)
         STRTOFILE( loHost.c_TextErr + CR_LF, loHost.c_ErrorLogFile, 1 )
      ENDIF
      loHost.c_TextErr = ''
   ENDPROC


   FUNCTION exception2Str
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toEx                      (@! IN    ) Exception object to serialize
      *---------------------------------------------------------------------------------------------------
      * RETURN: Multi-line error description (number, message, procedure/line, line contents, uservalue).
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toEx AS EXCEPTION
      LOCAL lcError

      lcError = 'Error ' + TRANSFORM(toEx.ERRORNO) + ', ' + toEx.MESSAGE + CR_LF ;
         + toEx.PROCEDURE + ', ' + TRANSFORM(toEx.LINENO) + CR_LF

      IF NOT EMPTY(toEx.LINECONTENTS) AND toEx.ERRORNO <> 1098
         lcError = lcError + toEx.LINECONTENTS + CR_LF
      ENDIF

      IF NOT EMPTY(toEx.USERVALUE)
         lcError = lcError + EVL(toEx.USERVALUE,'')
      ENDIF

      RETURN lcError
   ENDFUNC


   PROCEDURE doWriteErrorLog
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toEx                      (@! IN    ) Exception from the failed conversion/execute path
      * tcErrorInfo               (@? IN/OUT) Optional preformatted text; filled when empty or on cancel (1799)
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toEx AS EXCEPTION, tcErrorInfo
      LOCAL loHost, loLang AS CL_LANG OF 'cl_lang.prg'

      loHost = This.o_Host
      IF VARTYPE(loHost) <> 'O'
         RETURN
      ENDIF

      loLang = _SCREEN.o_FoxBin2Prg_Lang

      IF toEx.ERRORNO = 1799
         tcErrorInfo = loLang.C_CONVERSION_CANCELLED_BY_USER_LOC
      ELSE
         tcErrorInfo = This.exception2Str(@toEx) + CR_LF + loLang.C_SOURCEFILE_LOC + TRANSFORM(loHost.c_InputFile) + CR_LF
      ENDIF

      ADDPROPERTY(_SCREEN, 'ExitCode', toEx.ERRORNO)

      This.writeErrorLog( REPLICATE('-', 100), 1 )
      This.writeLog( tcErrorInfo )
      This.writeErrorLog( tcErrorInfo )
      This.writeErrorLog( )

      TRY
         STRTOFILE( tcErrorInfo, EVL( loHost.c_InputFile, 'foxbin2prg_errorlog' ) + '.ERR' )
      CATCH
      ENDTRY

      RETURN
   ENDPROC

ENDDEFINE
