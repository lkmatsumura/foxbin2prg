#INCLUDE foxbin2prg.h

DEFINE CLASS cl_file_utils AS Custom
   o_Host = .NULL.

   PROCEDURE INIT
      LPARAMETERS toHost
      This.o_Host = toHost
   ENDPROC


   PROCEDURE DESTROY
      This.o_Host = .NULL.
   ENDPROC


   PROCEDURE declareDLL
      *-- Functions for writing to StdOut
      DECLARE INTEGER 'GetStdHandle' IN WIN32API AS fb2p_GetStdHandle INTEGER nHandleType
      DECLARE INTEGER 'WriteFile'    IN WIN32API AS fb2p_WriteFile INTEGER hFile, STRING @ cBuffer, INTEGER nBytes, INTEGER @ nBytes2, INTEGER @ nBytes3
      *-- Functions for changeFileTime
      DECLARE INTEGER 'SetFileTime'             IN WIN32API AS fb2p_SetFileTime INTEGER hFile, STRING  lpCreationTime, STRING  lpLastAccessTime, STRING  lpLastWriteTime
      DECLARE INTEGER 'GetFileAttributesEx'     IN Win32API AS fb2p_GetFileAttributesEx STRING  lpFileName, INTEGER fInfoLevelId, STRING  @ lpFileInformation
      DECLARE INTEGER 'SystemTimeToFileTime'    IN Win32API AS fb2p_SystemTimeToFileTime STRING  lpSYSTEMTIME, STRING  @ FILETIME
      DECLARE INTEGER 'FileTimeToSystemTime'    IN Win32API AS fb2p_FileTimeToSystemTime STRING FILETIME, STRING @ SYSTEMTIME
      DECLARE INTEGER 'LocalFileTimeToFileTime' IN Win32API AS fb2p_LocalFileTimeToFileTime STRING LOCALFILETIME, STRING @ FILETIME
      DECLARE INTEGER '_lopen'  IN WIN32API AS fb2p_lopen STRING lpFileName, INTEGER iReadWrite
      DECLARE INTEGER '_lclose' IN WIN32API AS fb2p_lclose INTEGER hFile
      *-- Functions for changeFileAttributes
      DECLARE SHORT   'SetFileAttributes' IN Win32API AS fb2p_SetFileAttributes STRING tcFileName, INTEGER dwFileAttributes
      DECLARE INTEGER 'GetFileAttributes' IN Win32API AS fb2p_GetFileAttributes STRING tcFileName
   ENDPROC


   PROCEDURE clearDll
      CLEAR DLLS fb2p_SetFileAttributes, fb2p_GetFileAttributes
      CLEAR DLLS fb2p_GetStdHandle, fb2p_WriteFile
      CLEAR DLLS fb2p_SetFileTime, fb2p_GetFileAttributesEx, fb2p_LocalFileTimeToFileTime ;
         , fb2p_FileTimeToSystemTime, fb2p_SystemTimeToFileTime, fb2p_lopen, fb2p_lclose
   ENDPROC


   PROCEDURE hostWriteLog
      LPARAMETERS tcText, tnTimeStamp
      IF VARTYPE(This.o_Host) = 'O' AND PEMSTATUS(This.o_Host, 'writeLog', 5)
         This.o_Host.writeLog(tcText, tnTimeStamp)
      ENDIF
   ENDPROC


   PROCEDURE get_AbsolutePath
      LPARAMETERS tc_InputFile, tc_FullPath

      tc_InputFile = EVL(tc_InputFile, '')
      IF VARTYPE(This.o_Host) = 'O' AND PEMSTATUS(This.o_Host, 'c_Foxbin2prg_FullPath', 5)
         tc_FullPath = EVL(tc_FullPath, This.o_Host.c_Foxbin2prg_FullPath)
      ELSE
         tc_FullPath = EVL(tc_FullPath, '')
      ENDIF

      IF NOT EMPTY(JUSTEXT(tc_FullPath))
         tc_FullPath = JUSTPATH(tc_FullPath)
      ENDIF

      tc_FullPath = ADDBS(tc_FullPath)

      IF     LEN(tc_InputFile) > 1 ;
            AND LEFT(LTRIM(tc_InputFile), 2) <> '\\' ;
            AND SUBSTR(LTRIM(tc_InputFile), 2, 1) <> ':' THEN
         tc_InputFile = FULLPATH(tc_InputFile, tc_FullPath)
      ENDIF

      RETURN tc_InputFile
   ENDPROC


   PROCEDURE changeFileAttribute
      LPARAMETERS tcFileName, tcAttrib
      tcAttrib = UPPER(tcAttrib)

      #DEFINE FILE_ATTRIBUTE_READONLY     1
      #DEFINE FILE_ATTRIBUTE_HIDDEN       2
      #DEFINE FILE_ATTRIBUTE_SYSTEM       4
      #DEFINE FILE_ATTRIBUTE_DIRECTORY    16
      #DEFINE FILE_ATTRIBUTE_ARCHIVE      32
      #DEFINE FILE_ATTRIBUTE_NORMAL       128
      #DEFINE FILE_ATTRIBUTE_TEMPORARY    512
      #DEFINE FILE_ATTRIBUTE_COMPRESSED   2048

      TRY
         LOCAL loEx AS EXCEPTION, dwFileAttributes, dwFileAttributes_Orig, lnRet
         lnRet = 0

         dwFileAttributes      = fb2p_GetFileAttributes(tcFileName)
         dwFileAttributes_Orig = dwFileAttributes

         IF dwFileAttributes = -1
            EXIT
         ENDIF

         IF dwFileAttributes > 0
            IF '+R' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_READONLY)
            ENDIF
            IF '+A' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_ARCHIVE)
            ENDIF
            IF '+S' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_SYSTEM)
            ENDIF
            IF '+H' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_HIDDEN)
            ENDIF
            IF '+D' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_DIRECTORY)
            ENDIF
            IF '+N' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_NORMAL)
            ENDIF
            IF '+T' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_TEMPORARY)
            ENDIF
            IF '+C' $ tcAttrib
               dwFileAttributes = BITOR(dwFileAttributes, FILE_ATTRIBUTE_COMPRESSED)
            ENDIF

            IF '-R' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_READONLY) = FILE_ATTRIBUTE_READONLY
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_READONLY
            ENDIF
            IF '-A' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_ARCHIVE) = FILE_ATTRIBUTE_ARCHIVE
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_ARCHIVE
            ENDIF
            IF '-S' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_SYSTEM) = FILE_ATTRIBUTE_SYSTEM
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_SYSTEM
            ENDIF
            IF '-H' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_HIDDEN) = FILE_ATTRIBUTE_HIDDEN
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_HIDDEN
            ENDIF
            IF '-D' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_DIRECTORY) = FILE_ATTRIBUTE_DIRECTORY
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_DIRECTORY
            ENDIF
            IF '-N' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_NORMAL) = FILE_ATTRIBUTE_NORMAL
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_NORMAL
            ENDIF
            IF '-T' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_TEMPORARY) = FILE_ATTRIBUTE_TEMPORARY
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_TEMPORARY
            ENDIF
            IF '-C' $ tcAttrib AND BITAND(dwFileAttributes, FILE_ATTRIBUTE_COMPRESSED) = FILE_ATTRIBUTE_COMPRESSED
               dwFileAttributes = dwFileAttributes - FILE_ATTRIBUTE_COMPRESSED
            ENDIF

            lnRet = fb2p_SetFileAttributes(tcFileName, dwFileAttributes)
         ENDIF

      CATCH TO loEx
         THROW

      FINALLY
         This.hostWriteLog( C_TAB + 'changefileattribute >> [' + tcFileName + '] lnRet = ' + TRANSFORM(lnRet) + ', dwFileAttributes_Orig = ' + TRANSFORM(dwFileAttributes_Orig) )
         RELEASE tcFileName, tcAttrib, dwFileAttributes
      ENDTRY

      RETURN lnRet
   ENDPROC


   PROCEDURE changeFileTime
      *---------------------------------------------------------------------------------------------------
      * CHANGE A FILE DATE/TIME
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS m.tcFileName, m.tcTimeType, m.tnYear, m.tnMonth, m.tnDay, m.tnHour, m.tnMinute, m.tnSec, m.tnThou

      #DEFINE OF_READWRITE 2

      LOCAL m.lpFileInformation, m.cS, m.nPar, m.fh, M.lpFileInformation, m.lpSysTime, m.cCreation ;
         , M.cLastAccess, m.cLastWrite, m.cBuffTime, m.cBuffTime1, M.cTT, m.nYear1, m.nMonth1, m.nDay1, m.nHour1 ;
         , M.nMinute1, m.nSec1, m.nThou1, llRetorno

      TRY
         m.nPar = PCOUNT()

         IF m.nPar < 1
            EXIT
         ENDIF

         m.cTT    = IIF(m.nPar >= 2 AND VARTYPE(m.tcTimeType) = "C" AND NOT EMPTY(m.tcTimeType), LOWER(SUBSTR(m.tcTimeType, 1, 1)), "c")
         m.nYear1 = IIF(m.nPar >= 3 AND VARTYPE(m.tnYear) $ "FIN" AND m.tnYear >= 1800, ROUND(m.tnYear, 0), -1)
         m.nMonth1 = IIF(m.nPar >= 4 AND VARTYPE(m.tnMonth) $ "FIN" AND BETWEEN(m.tnMonth, 1, 12), ROUND(m.tnMonth, 0), -1)
         m.nDay1 = IIF(m.nPar >= 5 AND VARTYPE(m.tnDay) $ "FIN" AND BETWEEN(m.tnDay, 1, 31), ROUND(m.tnDay, 0), -1)
         m.nHour1 = IIF(m.nPar >= 6 AND VARTYPE(m.tnHour) $ "FIN" AND BETWEEN(m.tnHour, 0, 23), ROUND(m.tnHour, 0), -1)
         m.nMinute1 = IIF(m.nPar >= 7 AND VARTYPE(m.tnMinute) $ "FIN" AND BETWEEN(m.tnMinute, 0, 59), ROUND(m.tnMinute, 0), -1)
         m.nSec1 = IIF(m.nPar >= 8 AND VARTYPE(m.tnSec) $ "FIN" AND BETWEEN(m.tnSec, 0, 59), ROUND(m.tnSec, 0), -1)
         m.nThou1 = IIF(m.nPar >= 9 AND VARTYPE(m.tnThou) $ "FIN" AND BETWEEN(m.tnThou, 0, 999), ROUND(m.tnThou, 0), -1)
         m.lpFileInformation = REPLICATE(CHR(0), 53)
         m.lpSysTime = REPLICATE(CHR(0), 16)

         IF fb2p_GetFileAttributesEx(m.tcFileName, 0, @lpFileInformation) = 0
            EXIT
         ENDIF

         m.cCreation   = SUBSTR(m.lpFileInformation, 5, 8)
         m.cLastAccess = SUBSTR(m.lpFileInformation, 13, 8)
         m.cLastWrite  = SUBSTR(m.lpFileInformation, 21, 8)
         m.cBuffTime   = IIF(m.cTT = "w", m.cLastWrite, IIF(m.cTT = "a", m.cLastAccess, m.cCreation))

         fb2p_FileTimeToSystemTime(m.cBuffTime, @lpSysTime)

         m.lpSysTime = ;
            IIF(m.nYear1 >= 0, BINTOC(m.nYear1, "2RS"), SUBSTR(m.lpSysTime, 1, 2)) ;
            + IIF(m.nMonth1 >= 0, BINTOC(m.nMonth1, "2RS"), SUBSTR(m.lpSysTime, 3, 2)) ;
            + SUBSTR(m.lpSysTime, 5, 2) ;
            + IIF(m.nDay1 >= 0, BINTOC(m.nDay1, "2RS"), SUBSTR(m.lpSysTime, 7, 2)) ;
            + IIF(m.nHour1 >= 0, BINTOC(m.nHour1, "2RS"), SUBSTR(m.lpSysTime, 9, 2)) ;
            + IIF(m.nMinute1 >= 0, BINTOC(m.nMinute1, "2RS"), SUBSTR(m.lpSysTime, 11, 2)) ;
            + IIF(m.nSec1 >= 0, BINTOC(m.nSec1, "2RS"), SUBSTR(m.lpSysTime, 13, 2)) ;
            + IIF(m.nThou1 >= 0, BINTOC(m.nThou1, "2RS"), SUBSTR(m.lpSysTime, 15, 2))

         fb2p_SystemTimeToFileTime(m.lpSysTime, @cBuffTime)
         m.cBuffTime1 = m.cBuffTime
         fb2p_LocalFileTimeToFileTime(m.cBuffTime1, @cBuffTime)

         DO CASE
         CASE m.cTT = "w"
            m.cLastWrite = m.cBuffTime
         CASE m.cTT = "a"
            m.cLastAccess = m.cBuffTime
         OTHERWISE
            m.cCreation = m.cBuffTime
         ENDCASE

         m.fh = fb2p_lopen(m.tcFileName, OF_READWRITE)

         IF m.fh < 0
            EXIT
         ENDIF

         fb2p_SetFileTime(m.fh, m.cCreation, m.cLastAccess, m.cLastWrite)
         fb2p_lclose(m.fh)
         llRetorno = .T.
      ENDTRY

      RETURN llRetorno
   ENDPROC


   FUNCTION comparedFilesAreEqual
      LPARAMETERS tcFilename1, tcFilename2, tcStrFileName2

      LOCAL lnComparacion, lnLen1, lnLen2, lnHandle1, lnHandle2, lnTipoComp, lnChunkSize ;
         , loEx AS EXCEPTION

      TRY
         STORE -1 TO lnComparacion, lnHandle1, lnHandle2
         lnTipoComp  = 0
         lnChunkSize = 65535

         DO CASE
         CASE NOT EMPTY(tcFilename1) AND NOT EMPTY(tcFilename2)
            lnTipoComp = 1
            lnHandle1  = FOPEN(tcFilename1)

            IF lnHandle1 = -1
               EXIT
            ENDIF

            lnHandle2 = FOPEN(tcFilename2)

            IF lnHandle2 = -1
               EXIT
            ENDIF

            lnLen1 = FSEEK(lnHandle1, 0, 2)
            lnLen2 = FSEEK(lnHandle2, 0, 2)

            IF lnLen1 <> lnLen2
               lnComparacion = 0
               EXIT
            ENDIF

            FSEEK(lnHandle1, 0, 0)
            FSEEK(lnHandle2, 0, 0)

            DO WHILE NOT (FEOF(lnHandle1) OR FEOF(lnHandle2))
               IF NOT FREAD(lnHandle1, lnChunkSize) == FREAD(lnHandle2, lnChunkSize)
                  lnComparacion = 0
                  EXIT
               ENDIF
            ENDDO

            IF lnComparacion = 0
               EXIT
            ENDIF

            lnComparacion = 1
         ENDCASE

      CATCH TO loEx
         lnComparacion = -1
         THROW

      FINALLY
         DO CASE
         CASE lnTipoComp = 1
            FCLOSE(lnHandle1)
            FCLOSE(lnHandle2)
         ENDCASE
      ENDTRY

      RETURN lnComparacion
   ENDFUNC


   PROCEDURE renameTmpFile2Tx2File
      LPARAMETERS tcFileName

      LOCAL lcTmpFile, loEx AS EXCEPTION

      TRY
         lcTmpFile = tcFileName + '.TMP'
         This.changeFileAttribute(tcFileName, '+N')
         ERASE (tcFileName)
         RENAME (lcTmpFile) TO (tcFileName)

      CATCH TO loEx
         THROW
      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE errOut
      LPARAMETERS tcTexto

      TRY
         IF VARTYPE(This.o_Host) = 'O' AND PEMSTATUS(This.o_Host, 'l_StdOutHabilitado', 5) AND This.o_Host.l_StdOutHabilitado
            LOCAL loException AS EXCEPTION, lcOutput, lnOutHandle, lnBytesWritten, lnOverlappedIO
            lcOutput       = EVL(tcTexto, '') + CR_LF
            lnOutHandle    = fb2p_GetStdHandle(-12)
            lnBytesWritten = 0
            lnOverlappedIO = 0
            fb2p_WriteFile(lnOutHandle, @lcOutput, LEN(lcOutput), @lnBytesWritten, @lnOverlappedIO)
         ENDIF

      CATCH TO loException
         IF VARTYPE(This.o_Host) = 'O' AND PEMSTATUS(This.o_Host, 'l_StdOutHabilitado', 5)
            This.o_Host.l_StdOutHabilitado = .F.
         ENDIF
      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE stdOut
      LPARAMETERS tcTexto

      TRY
         IF VARTYPE(This.o_Host) = 'O' AND PEMSTATUS(This.o_Host, 'l_StdOutHabilitado', 5) AND This.o_Host.l_StdOutHabilitado
            LOCAL loException AS EXCEPTION, lcOutput, lnOutHandle, lnBytesWritten, lnOverlappedIO
            lcOutput       = EVL(tcTexto, '') + CR_LF
            lnOutHandle    = fb2p_GetStdHandle(-11)
            lnBytesWritten = 0
            lnOverlappedIO = 0
            fb2p_WriteFile(lnOutHandle, @lcOutput, LEN(lcOutput), @lnBytesWritten, @lnOverlappedIO)
         ENDIF

      CATCH TO loException
         IF VARTYPE(This.o_Host) = 'O' AND PEMSTATUS(This.o_Host, 'l_StdOutHabilitado', 5)
            This.o_Host.l_StdOutHabilitado = .F.
         ENDIF
      ENDTRY

      RETURN
   ENDPROC


   FUNCTION wscriptshell_run
      LPARAMETERS tcCmdLine, tnWindowStyle, tbWaitOnReturn, tlDebug

      LOCAL lnWfSO, ln_dwFlags, ln_wShowWindow, lcStartInfo, lcProcessInfo, ln_hProcess, ln_hThread ;
         , lnExitCode, ln_dwProcessId, ln_dwThreadId, tcProgFile, laDirFile(1, 5)

      TRY
         DECLARE SHORT CreateProcess IN WIN32API ;
            STRING lpszModuleName, ;
            STRING @lpszCommandLine, ;
            STRING lpSecurityAttributesProcess, ;
            STRING lpSecurityAttributesThread, ;
            SHORT bInheritHandles, ;
            INTEGER dwCreateFlags, ;
            STRING lpvEnvironment, ;
            STRING lpszStartupDir, ;
            STRING @lpStartInfo, ;
            STRING @lpProcessInfo

         DECLARE LONG WaitForSingleObject IN WIN32API INTEGER hHandle, LONG dwMilliseconds
         DECLARE INTEGER GetExitCodeProcess IN WIN32API INTEGER ln_hProcess, INTEGER @ lnExitCode
         DECLARE INTEGER CloseHandle IN kernel32.DLL INTEGER hObject
         DECLARE LONG ShellExecuteEx IN shell32.DLL STRING @
         DECLARE LONG HeapAlloc IN WIN32API LONG, LONG, LONG
         DECLARE LONG HeapFree IN WIN32API LONG, LONG, LONG
         DECLARE LONG GetProcessHeap IN WIN32API
         DECLARE LONG TerminateProcess IN WIN32API LONG, LONG

         #DEFINE SEE_MASK_NOCLOSEPROCESS  0x00000040
         #DEFINE WAIT_MILLISECOND 3000
         #DEFINE SW_SHOW         5
         #DEFINE STILL_ACTIVE    0x103
         #DEFINE cnINFINITE      0xFFFFFFFF
         #DEFINE cnHalfASecond   500
         #DEFINE cnTimedOut      0x0102
         #DEFINE WAIT_ABANDONED  0x00000080
         #DEFINE WAIT_OBJECT_0   0x00000000
         #DEFINE WAIT_TIMEOUT    0x00000102
         #DEFINE WAIT_FAILED     0xFFFFFFFF

         tcProgFile = EVL(tcProgFile, .NULL.)
         tcCmdLine  = EVL(tcCmdLine, .NULL.)

         DO CASE
         CASE VARTYPE(tbWaitOnReturn) = "L"
         CASE VARTYPE(tbWaitOnReturn) = "N"
            tbWaitOnReturn = (tbWaitOnReturn = 1)
         OTHERWISE
            ERROR 'Invalid value for tbWaitOnReturn parameter'
         ENDCASE

         IF VARTYPE(tnWindowStyle) # "N" OR NOT BETWEEN(tnWindowStyle, 0, 10)
            tnWindowStyle = 10
         ENDIF

         ln_dwFlags     = 1
         ln_wShowWindow = tnWindowStyle

         lcStartInfo = BINTOC(68, '4RS') ;
            + BINTOC(0, '4RS') + BINTOC(0, '4RS') + BINTOC(0, '4RS') ;
            + BINTOC(0, '4RS') + BINTOC(0, '4RS') + BINTOC(0, '4RS') + BINTOC(0, '4RS') ;
            + BINTOC(0, '4RS') + BINTOC(0, '4RS') + BINTOC(0, '4RS') ;
            + BINTOC(ln_dwFlags, '4RS') ;
            + BINTOC(ln_wShowWindow, '2RS') ;
            + BINTOC(0, '2RS') + BINTOC(0, '4RS') ;
            + BINTOC(0, '4RS') + BINTOC(0, '4RS') + BINTOC(0, '4RS')

         lcProcessInfo = REPLICATE(CHR(0), 16)

         IF CreateProcess(tcProgFile, tcCmdLine, 0, 0, 0, 0, 0, 0, lcStartInfo, @lcProcessInfo) = 0
            IF ADIR(laDirFile, tcCmdLine) = 1
               LOCAL lcInfo, lnHeap, lnLen, lnPtr

               lnLen  = LEN(tcCmdLine) + 1
               lnHeap = GetProcessHeap()
               lnPtr  = HeapAlloc(lnHeap, 0x8, 5 + lnLen)
               SYS(2600, lnPtr, 5, [open] + CHR(0))
               SYS(2600, lnPtr + 5, lnLen, tcCmdLine + CHR(0))

               lcInfo = ;
                  BINTOC(60, [4RS]) + ;
                  BINTOC(SEE_MASK_NOCLOSEPROCESS, [4RS]) + ;
                  BINTOC(0, [4RS]) + ;
                  BINTOC(lnPtr, [4RS]) + ;
                  BINTOC(lnPtr + 5, [4RS]) + ;
                  BINTOC(0, [4RS]) + ;
                  BINTOC(0, [4RS]) + ;
                  BINTOC(1, [4RS]) + ;
                  REPLICATE(CHR(0), 28)

               IF ShellExecuteEx(@lcInfo) = 0
                  IF tlDebug
                     ? "Could not call process"
                  ENDIF
                  lnExitCode = -1
                  EXIT
               ELSE
                  HeapFree(lnHeap, 0, lnPtr)
                  ln_hProcess = CTOBIN(RIGHT(lcInfo, 4), [4RS])
                  ln_hThread  = 0

                  IF tlDebug
                     ? "Process handle    = " + TRANSFORM(ln_hProcess)
                     ? "Thread handle     = " + TRANSFORM(ln_hThread)
                  ENDIF
               ENDIF
            ELSE
               IF tlDebug
                  ? "Could not create process"
               ENDIF
               lnExitCode = -1
               EXIT
            ENDIF
         ELSE
            ln_hProcess    = CTOBIN(LEFT(lcProcessInfo, 4), '4RS')
            ln_hThread     = CTOBIN(SUBSTR(lcProcessInfo, 5, 4), '4RS')
            ln_dwProcessId = CTOBIN(SUBSTR(lcProcessInfo, 9, 4), '4RS')
            ln_dwThreadId  = CTOBIN(SUBSTR(lcProcessInfo, 13, 4), '4RS')

            IF tlDebug
               ? "Process handle    = " + TRANSFORM(ln_hProcess)
               ? "Thread handle     = " + TRANSFORM(ln_hThread)
               ? "Process handle id = " + TRANSFORM(ln_dwProcessId)
               ? "Thread handle id  = " + TRANSFORM(ln_dwThreadId)
            ENDIF
         ENDIF

         IF tbWaitOnReturn
            lnExitCode = STILL_ACTIVE

            DO WHILE lnExitCode = STILL_ACTIVE
               lnWfSO = WaitForSingleObject(ln_hProcess, cnINFINITE)

               IF tlDebug
                  ? 'lnWfSO = ' + TRANSFORM(lnWfSO)
               ENDIF

               IF GetExitCodeProcess(ln_hProcess, @lnExitCode) <> 0
                  DO CASE
                  CASE lnExitCode = STILL_ACTIVE
                     IF tlDebug
                        ? "Process is still active"
                     ENDIF
                  OTHERWISE
                     IF tlDebug
                        ? "Exit code = " + TRANSFORM(lnExitCode)
                     ENDIF
                  ENDCASE
               ELSE
                  IF tlDebug
                     ? "GetExitCodeProcess() failed"
                  ENDIF
                  lnExitCode = -2
               ENDIF

               DOEVENTS
            ENDDO
         ELSE
            lnExitCode = 0
         ENDIF

         = CloseHandle(ln_hProcess)
         = CloseHandle(ln_hThread)

         IF tlDebug
            ? '> FUNCTION RETURN VALUE = '
         ENDIF
      ENDTRY

      RETURN lnExitCode
   ENDFUNC


   FUNCTION FERROR_Message
      LPARAMETERS tcFileName AS STRING
      LOCAL lcMsg, lnError
      tcFileName = EVL(tcFileName, '')
      lnError    = FERROR()

      DO CASE
      CASE lnError = 2
         lcMsg = 'File not found'
      CASE lnError = 4
         lcMsg = 'Too many files open (out of file handles)'
      CASE lnError = 5
         lcMsg = 'Access denied'
      CASE lnError = 6
         lcMsg = 'Invalid file handle given'
      CASE lnError = 8
         lcMsg = 'Out of memory'
      CASE lnError = 25
         lcMsg = [Seek error (can't seek before the start of a file)]
      CASE lnError = 29
         lcMsg = 'Disk full'
      CASE lnError = 31
         lcMsg = 'Error opening file'
      OTHERWISE
         lcMsg = 'Unrecognized error trying to open the file ' + tcFileName
      ENDCASE

      RETURN lcMsg
   ENDFUNC


   FUNCTION getLocaleInfo
      LPARAMETERS tnSetting, tcLocale
      #DEFINE C_NULL CHR(0)
      LOCAL lcLocale, lnLen, lcBuffer, lnReturn, lcReturn

      IF VARTYPE(tcLocale) = 'C' AND NOT EMPTY(tcLocale)
         lcLocale = STRCONV(tcLocale, 5) + C_NULL
      ELSE
         lcLocale = .NULL.
      ENDIF

      DECLARE INTEGER GetLocaleInfoEx IN Win32API ;
         STRING locale, LONG TYPE, STRING @BUFFER, INTEGER LEN
      lnLen    = 255
      lcBuffer = SPACE(lnLen)
      lnReturn = GetLocaleInfoEx(lcLocale, tnSetting, @lcBuffer, lnLen)
      lcReturn = STRCONV(LEFT(lcBuffer, 2 * (lnReturn - 1)), 6)
      RETURN lcReturn
   ENDFUNC


   FUNCTION getNext_BAK
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcOutputFileName          (v! IN    ) Output file name for which to create a backup suffix
      *---------------------------------------------------------------------------------------------------
      * RETURN: Next available backup extension (.BAK, .01.BAK, ...) per n_ExtraBackupLevels on host CFG.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcOutputFileName
      LOCAL lcNext_Bak, I, laDirInfo(1,5), loHost

      loHost = This.o_Host
      IF VARTYPE(loHost) <> 'O'
         RETURN '.BAK'
      ENDIF

      lcNext_Bak = '.BAK'

      FOR I = 1 TO loHost.getCfgValue('n_ExtraBackupLevels')
         IF m.I = 1
            IF NOT ADIR( laDirInfo, tcOutputFileName + '.BAK' ) > 0 THEN
               lcNext_Bak = '.BAK'
               EXIT
            ENDIF
         ELSE
            IF NOT ADIR( laDirInfo, tcOutputFileName + '.' + PADL(m.I-1,1,'0') + '.BAK' ) > 0 THEN
               lcNext_Bak = '.' + PADL(m.I-1,1,'0') + '.BAK'
               EXIT
            ENDIF
         ENDIF
      ENDFOR

      RETURN lcNext_Bak
   ENDFUNC


   PROCEDURE doBackup
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toEx                      (@? IN    ) Exception object with error information
      * tlRelanzarError           (v? IN    ) Whether the error should be re-thrown
      * tcBakFile_1               (@?    OUT) Backup file 1 name (vcx,scx,pjx,frx,lbx,dbf,dbc,mnx,vc2,sc2,pj2,etc)
      * tcBakFile_2               (@?    OUT) Backup file 2 name (vct,sct,pjt,frt,lbt,fpt,dct,mnt,etc)
      * tcBakFile_3               (@?    OUT) Backup file 3 name (cdx,dcx,etc)
      * tcOutputFile              (v? IN    ) Output file name. If omitted, o_Host.c_OutputFile is assumed
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toEx, tlRelanzarError, tcBakFile_1, tcBakFile_2, tcBakFile_3, tcOutputFile

      TRY
         LOCAL lcNext_Bak, lcExt_1, lcExt_2, lcExt_3, tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3, laDir(1,5) ;
            , loLang AS CL_LANG OF 'cl_lang.prg', loHost
         STORE '' TO tcBakFile_1, tcBakFile_2, tcBakFile_3, lcExt_1, lcExt_2, lcExt_3 ;
            , tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3

         loHost = This.o_Host
         IF VARTYPE(loHost) <> 'O'
            RETURN
         ENDIF

         IF loHost.getCfgValue('n_ExtraBackupLevels') > 0 THEN
            loLang       = _SCREEN.o_FoxBin2Prg_Lang
            tcOutputFile = EVL( tcOutputFile, loHost.c_OutputFile )
            lcNext_Bak   = This.getNext_BAK( tcOutputFile )
            lcExt_1      = JUSTEXT( tcOutputFile )
            tcBakFile_1  = FORCEEXT(tcOutputFile, lcExt_1 + lcNext_Bak)

            DO CASE
            CASE INLIST( lcExt_1, loHost.getCfgValue('c_PJ2'), loHost.getCfgValue('c_VC2'), loHost.getCfgValue('c_SC2'), loHost.getCfgValue('c_FR2') ;
                                , loHost.getCfgValue('c_FR2D'), loHost.getCfgValue('c_LB2'), loHost.getCfgValue('c_LB2D'), loHost.getCfgValue('c_DB2');
                                , loHost.getCfgValue('c_DC2'), loHost.getCfgValue('c_MN2'), loHost.getCfgValue('c_FK2'), loHost.getCfgValue('c_ME2'), 'PJM' )
               *-- TEXT extensions

            CASE lcExt_1 == 'DBF'
               lcExt_2     = 'FPT'
               lcExt_3     = 'CDX'
               tcBakFile_2 = FORCEEXT(tcOutputFile, lcExt_2 + lcNext_Bak)
               tcBakFile_3 = FORCEEXT(tcOutputFile, lcExt_3 + lcNext_Bak)

            CASE lcExt_1 == 'DBC'
               lcExt_2     = 'DCT'
               lcExt_3     = 'DCX'
               tcBakFile_2 = FORCEEXT(tcOutputFile, lcExt_2 + lcNext_Bak)
               tcBakFile_3 = FORCEEXT(tcOutputFile, lcExt_3 + lcNext_Bak)

            CASE INLIST( lcExt_1, 'PJX', 'VCX', 'SCX', 'FRX', 'LBX', 'MNX' )
               lcExt_2     = LEFT(lcExt_1,2) + 'T'
               tcBakFile_2 = FORCEEXT(tcOutputFile, lcExt_2 + lcNext_Bak)

            OTHERWISE
               *-- PKY, MEM

            ENDCASE

            IF NOT EMPTY(lcExt_1)
               tcOutputFile_Ext1 = FORCEEXT(tcOutputFile, lcExt_1)

               IF ADIR( laDir, tcOutputFile_Ext1 ) > 0 THEN
                  DO CASE
                  CASE EMPTY(lcExt_2)
                     This.hostWriteLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 )
                  CASE EMPTY(lcExt_3)
                     This.hostWriteLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 + '/' + lcExt_2 )
                  OTHERWISE
                     This.hostWriteLog( C_TAB + loLang.C_BACKUP_OF_LOC + tcOutputFile_Ext1 + '/' + lcExt_2 + '/' + lcExt_3 )
                  ENDCASE

                  COPY FILE ( tcOutputFile_Ext1 ) TO ( tcBakFile_1 )

                  IF NOT EMPTY(lcExt_2)
                     tcOutputFile_Ext2 = FORCEEXT(tcOutputFile, lcExt_2)

                     IF ADIR( laDir, tcOutputFile_Ext2 ) > 0 THEN
                        COPY FILE ( tcOutputFile_Ext2 ) TO ( tcBakFile_2 )
                     ENDIF
                  ENDIF

                  IF NOT EMPTY(lcExt_3)
                     tcOutputFile_Ext3 = FORCEEXT(tcOutputFile, lcExt_3)

                     IF ADIR( laDir, tcOutputFile_Ext3 ) > 0 THEN
                        COPY FILE ( tcOutputFile_Ext3 ) TO ( tcBakFile_3 )
                     ENDIF
                  ENDIF
               ENDIF
            ENDIF
         ENDIF

      CATCH TO toEx
         IF VARTYPE(This.o_Host) = 'O' AND This.o_Host.getCfgValue('n_Debug') > 0 AND _VFP.STARTMODE = 0
            SET STEP ON
         ENDIF

         IF tlRelanzarError
            THROW
         ENDIF

      FINALLY
         RELEASE toEx, tlRelanzarError, tcBakFile_1, tcBakFile_2, tcBakFile_3 ;
            , lcNext_Bak, lcExt_1, lcExt_2, lcExt_3, tcOutputFile_Ext1, tcOutputFile_Ext2, tcOutputFile_Ext3 ;
            , tcOutputFile
      ENDTRY

      RETURN
   ENDPROC

ENDDEFINE
