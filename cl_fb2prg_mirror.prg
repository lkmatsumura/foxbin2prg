#INCLUDE foxbin2prg.h

DEFINE CLASS cl_fb2prg_mirror AS Custom
   o_Host = .NULL.

   PROCEDURE INIT
      LPARAMETERS toHost
      This.o_Host = toHost
   ENDPROC


   FUNCTION isActive
      RETURN VARTYPE(This.o_Host) = 'O' AND !EMPTY(This.o_Host.cOutputFolder)
   ENDFUNC


   PROCEDURE ensureInputRoot
      *---------------------------------------------------------------------------------------------------
      * When mirroring is active and cInputRoot is empty, default it to the project folder.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcProjectFile
      LOCAL lcRoot

      IF VARTYPE(This.o_Host) <> 'O'
         RETURN .F.
      ENDIF

      WITH This.o_Host
         IF NOT EMPTY(.cOutputFolder) AND EMPTY(.cInputRoot)
            lcRoot = ADDBS(JUSTPATH(FULLPATH(tcProjectFile)))
            .cInputRoot = lcRoot
            RETURN .T.
         ENDIF
      ENDWITH

      RETURN .F.
   ENDPROC


   PROCEDURE setProjectRoots
      *---------------------------------------------------------------------------------------------------
      * Assign mirrored-tree source/destination roots on the host session.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcOutputRoot, tcInputRoot

      IF VARTYPE(This.o_Host) <> 'O'
         RETURN .F.
      ENDIF

      WITH This.o_Host
         .cOutputFolder = tcOutputRoot
         .cInputRoot = tcInputRoot
      ENDWITH

      RETURN .T.
   ENDPROC


   PROCEDURE makeDirTree
      *---------------------------------------------------------------------------------------------------
      * Recursively creates the indicated directory tree (if it does not exist).
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcDir
      LOCAL lcDir, lnLevels, I, lcPartial, laParts(1), loFSO

      lcDir = RTRIM(EVL(tcDir, ''), 0, ' ', '\', '/')

      IF EMPTY(lcDir)
         RETURN .F.
      ENDIF

      IF VARTYPE(This.o_Host) = 'O'
         loFSO = This.o_Host.o_FSO
      ENDIF

      IF DIRECTORY(lcDir) OR (VARTYPE(loFSO) = 'O' AND loFSO.FolderExists(lcDir))
         RETURN .T.
      ENDIF

      lnLevels = ALINES(laParts, CHRTRAN(lcDir, '/', '\'), 1, '\')
      lcPartial = ''

      FOR I = 1 TO lnLevels
         IF I = 1
            lcPartial = laParts(1)
         ELSE
            lcPartial = lcPartial + '\' + laParts(m.I)
         ENDIF

         IF RIGHT(lcPartial, 1) == ':' OR EMPTY(laParts(m.I))
            LOOP
         ENDIF

         IF NOT DIRECTORY(lcPartial)
            *-- A flat file with the same name blocks MD/CreateFolder (e.g. library.vc2 vs library.vc2\)
            IF FILE(lcPartial)
               ERASE (lcPartial)
            ENDIF
            TRY
               IF VARTYPE(loFSO) = 'O' AND NOT loFSO.FolderExists(lcPartial)
                  loFSO.CreateFolder( Lower(lcPartial) )
               ELSE
                  MD (Lower(lcPartial))
               ENDIF
            CATCH
            ENDTRY
         ENDIF
      ENDFOR

      RETURN DIRECTORY(RTRIM(lcDir, 0, ' ', '\', '/'))
   ENDPROC


   FUNCTION isUnderInputRoot
      *---------------------------------------------------------------------------------------------------
      * True when tcFile lies under cInputRoot (project/mirror source root).
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile
      LOCAL lcRoot, lcDir, lcInput

      IF VARTYPE(This.o_Host) <> 'O'
         RETURN .F.
      ENDIF

      lcInput = This.o_Host.cInputRoot

      IF EMPTY(lcInput)
         RETURN .T.
      ENDIF

      lcRoot = ADDBS(UPPER(FULLPATH(lcInput)))
      lcDir = ADDBS(UPPER(FULLPATH(JUSTPATH(tcFile))))

      RETURN LEFT(lcDir, LEN(lcRoot)) == lcRoot
   ENDFUNC


   FUNCTION get_MirroredPath
      *---------------------------------------------------------------------------------------------------
      * Returns destination path replicating subfolders relative to cInputRoot under cOutputFolder.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile
      LOCAL lcResult, lcRoot, lcRel, lcOutput, lcInput

      lcResult = tcFile

      IF VARTYPE(This.o_Host) <> 'O'
         RETURN lcResult
      ENDIF

      lcOutput = This.o_Host.cOutputFolder
      lcInput = This.o_Host.cInputRoot

      IF EMPTY(lcOutput)
         RETURN lcResult
      ENDIF

      IF NOT EMPTY(lcInput) AND This.isUnderInputRoot(tcFile)
         lcRoot = ADDBS(FULLPATH(lcInput))
         lcRel = SUBSTR(ADDBS(FULLPATH(JUSTPATH(tcFile))), LEN(lcRoot))
         lcResult = ADDBS(lcOutput) + IIF(EMPTY(lcRel), '', ADDBS(lcRel)) + JUSTFNAME(tcFile)
      ELSE
         IF EMPTY(lcInput)
            lcResult = FORCEPATH(tcFile, lcOutput)
         ENDIF
      ENDIF

      RETURN lcResult
   ENDFUNC


   FUNCTION isExcludedSubdir
      *---------------------------------------------------------------------------------------------------
      * True when tcFile lies under a path segment listed in c_ExcludedSubdirs CFG value.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile
      LOCAL lcExcl, lcRoot, lcDir, lcRel, laTokens(1), lnCount, I, lcToken, llExcl, lcInput

      IF VARTYPE(This.o_Host) <> 'O'
         RETURN .F.
      ENDIF

      lcExcl = ALLTRIM(EVL(This.o_Host.getCfgValue('c_ExcludedSubdirs'), ''))

      IF EMPTY(lcExcl)
         RETURN .F.
      ENDIF

      lcInput = This.o_Host.cInputRoot
      lcRoot = ADDBS(UPPER(FULLPATH(EVL(lcInput, ''))))
      lcDir = ADDBS(UPPER(JUSTPATH(tcFile)))

      IF NOT EMPTY(lcInput) AND LEFT(lcDir, LEN(lcRoot)) == lcRoot
         lcRel = SUBSTR(lcDir, LEN(lcRoot))
      ELSE
         lcRel = lcDir
      ENDIF

      lcRel = CHRTRAN(lcRel, '/', '\')
      llExcl = .F.
      lnCount = ALINES(laTokens, lcExcl, 1, ';', ',')

      FOR I = 1 TO lnCount
         lcToken = RTRIM(UPPER(CHRTRAN(ALLTRIM(laTokens(m.I)), '/', '\')), 0, '\')

         IF EMPTY(lcToken)
            LOOP
         ENDIF

         IF '\' + lcToken + '\' $ '\' + lcRel
            llExcl = .T.
            EXIT
         ENDIF
      ENDFOR

      RETURN llExcl
   ENDFUNC


   FUNCTION collectPj2ExcludedPaths
      *---------------------------------------------------------------------------------------------------
      * Returns absolute paths of PJ2 members marked Exclude in the <ExcludedFiles> block.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcPj2File, tcProjectDir
      LOCAL lcBlock, laLines(1), lnCount, I, lcLine, lcItem, lcFile, llExclude ;
         , laExcluded(1), lnExcl

      lnExcl = 0
      DIMENSION laExcluded(1)
      laExcluded(1) = ''

      IF VARTYPE(This.o_Host) <> 'O' OR EMPTY(tcPj2File) OR NOT FILE(tcPj2File)
         RETURN laExcluded
      ENDIF

      lcBlock = STREXTRACT(This.o_Host.readTextFile(tcPj2File), C_FILE_EXCL_I, C_FILE_EXCL_F)

      IF EMPTY(lcBlock)
         RETURN laExcluded
      ENDIF

      lnCount = ALINES(laLines, lcBlock, 1+4)

      FOR I = 1 TO lnCount
         lcLine = ALLTRIM(laLines(m.I))

         IF '.ITEM(' $ UPPER(lcLine) AND '.EXCLUDE' $ UPPER(lcLine)
            lcItem = STREXTRACT(lcLine, ".ITEM(", ").Exclude", 1, 1)
            lcItem = STRTRAN(CHRTRAN(lcItem, ["'], []), 'lcCurdir + ', '', 1, 1, 1)
            lcItem = STRTRAN(lcItem, 'lcCurDir + ', '', 1, 1, 1)
            llExclude = EVALUATE(ALLTRIM(CHRTRAN(STREXTRACT(lcLine, "=", "", 1, 2), ['], [])))

            IF llExclude
               lcFile = UPPER(FULLPATH(This.o_Host.get_AbsolutePath(ALLTRIM(lcItem), ADDBS(tcProjectDir))))
               lnExcl = lnExcl + 1
               DIMENSION laExcluded(lnExcl)
               laExcluded(lnExcl) = lcFile
            ENDIF
         ENDIF
      ENDFOR

      RETURN laExcluded
   ENDFUNC


   FUNCTION isPjxExcludedFile
      *---------------------------------------------------------------------------------------------------
      * True when tcFile matches a path collected from the PJ2 <ExcludedFiles> block.
      * Compares full path and stem (path + name without extension) so text/binary extensions match.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile, taExcludedPaths
      EXTERNAL ARRAY taExcludedPaths
      LOCAL lnCount, I, lcPath, lcStem, lcExclStem

      IF VARTYPE(taExcludedPaths) <> 'A'
         RETURN .F.
      ENDIF

      lcPath = UPPER(FULLPATH(tcFile))
      lcStem = UPPER(ADDBS(JUSTPATH(lcPath)) + JUSTSTEM(lcPath))
      lnCount = ALEN(taExcludedPaths, 1)

      FOR I = 1 TO lnCount
         IF NOT EMPTY(taExcludedPaths(m.I))
            IF taExcludedPaths(m.I) == lcPath
               RETURN .T.
            ENDIF

            lcExclStem = UPPER(ADDBS(JUSTPATH(taExcludedPaths(m.I))) + JUSTSTEM(taExcludedPaths(m.I)))

            IF lcExclStem == lcStem
               RETURN .T.
            ENDIF
         ENDIF
      ENDFOR

      RETURN .F.
   ENDFUNC


   FUNCTION copyUnconvertedFile
      *---------------------------------------------------------------------------------------------------
      * Copy a non-convertible file into the mirrored tree.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcFile
      LOCAL lcDest, lcDir, lcName, llOK

      llOK = .F.

      IF VARTYPE(This.o_Host) <> 'O' OR EMPTY(This.o_Host.cOutputFolder)
         RETURN .F.
      ENDIF

      IF NOT EMPTY(This.o_Host.cInputRoot) AND NOT This.isUnderInputRoot(tcFile)
         RETURN .F.
      ENDIF

      lcDest = This.get_MirroredPath(tcFile)
      lcDir = JUSTPATH(lcDest)
      lcName = JUSTFNAME(lcDest)

      IF This.o_Host.getCfgValue('l_CopyLowercaseNames')
         lcName = LOWER(lcName)
      ENDIF

      lcDest = ADDBS(lcDir) + lcName
      This.makeDirTree(lcDir)

      TRY
         IF NOT (UPPER(FULLPATH(lcDest)) == UPPER(FULLPATH(tcFile)))
            IF FILE(lcDest)
               This.o_Host.changeFileAttribute(lcDest, '-R')
            ENDIF
            COPY FILE (tcFile) TO (lcDest)
            llOK = .T.
         ENDIF
      CATCH
         llOK = .F.
      ENDTRY

      RETURN llOK
   ENDFUNC

ENDDEFINE
