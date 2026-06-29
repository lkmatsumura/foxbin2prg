#INCLUDE foxbin2prg.h

DEFINE CLASS cl_fb2prg_split_paths AS Custom
   o_Host = .NULL.

   PROCEDURE INIT
      LPARAMETERS toHost
      This.o_Host = toHost
   ENDPROC


   PROCEDURE DESTROY
      This.o_Host = .NULL.
   ENDPROC


   PROCEDURE normalizePerFileParams
      *---------------------------------------------------------------------------------------------------
      * Coerces Use*PerDir / Use*PerFile arguments from CFG numeric, logical, or null.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tlUsePerDir               (@? IN/OUT) Per-dir flag — pass with @ when mutating caller locals
      * lnUsePerFile              (@? IN/OUT) Per-file mode (0, 1, 2) — pass with @
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tlUsePerDir, lnUsePerFile

      IF VARTYPE(tlUsePerDir) = 'N'
         tlUsePerDir = (tlUsePerDir # 0)
      ENDIF
      IF ISNULL(tlUsePerDir)
         tlUsePerDir = .F.
      ENDIF
      IF VARTYPE(lnUsePerFile) = 'L'
         lnUsePerFile = IIF(lnUsePerFile, 1, 0)
      ENDIF
      lnUsePerFile = EVL(lnUsePerFile, 0)
   ENDPROC


   FUNCTION computePerFileBasePath
      *---------------------------------------------------------------------------------------------------
      * Strips dotted stem suffixes from a per-file text path to obtain the container base file path.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcInputFile               (v! IN    ) Current input path (VCX/SCX/DBC or per-object text)
      * tnStemLevels              (v! IN    ) 2 = one dotted segment; 3 = two dotted segments
      * RETURN                    (v?    OUT) Base file path for per-file optimization / prepareConversion
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcInputFile, tnStemLevels

      IF OCCURS('.', JUSTSTEM(tcInputFile)) = 0 OR tnStemLevels < 2
         RETURN tcInputFile
      ENDIF
      IF tnStemLevels = 2
         RETURN FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM(tcInputFile) ), JUSTEXT(tcInputFile) ), JUSTPATH(tcInputFile) )
      ENDIF
      RETURN FORCEPATH( FORCEEXT( JUSTSTEM( JUSTSTEM( JUSTSTEM(tcInputFile) ) ), JUSTEXT(tcInputFile) ), JUSTPATH(tcInputFile) )
   ENDFUNC


   FUNCTION resolveInputBaseFile
      *---------------------------------------------------------------------------------------------------
      * Resolves the container base file for VCX/SCX/DBC per-file optimization; may rewrite o_Host.c_InputFile.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * lcExtension               (v! IN    ) Upper-case extension of c_InputFile
      * RETURN                    (v?    OUT) Base file path passed to prepareConversion
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS lcExtension
      LOCAL lcBaseFile, lcStem, lcTextExt, loHost

      loHost     = This.o_Host
      lcBaseFile = loHost.c_InputFile
      lcStem     = JUSTSTEM(loHost.c_InputFile)

      IF INLIST(lcExtension, 'VCX', loHost.getCfgValue('c_VC2')) ;
            AND (loHost.getCfgValue('n_UseClassPerFile') > 0 AND loHost.getCfgValue('l_RedirectClassPerFileToMain') ;
            OR NOT EMPTY(loHost.c_ClassToConvert))

         lcTextExt = loHost.getCfgValue('c_VC2')
         DO CASE
         CASE loHost.getCfgValue('n_RedirectClassType') = 1 OR NOT EMPTY(loHost.c_ClassToConvert)
            lcBaseFile = This.computePerFileBasePath( loHost.c_InputFile, 2 )
         CASE loHost.getCfgValue('n_UseClassPerFile') = 1 AND INLIST(lcExtension, lcTextExt)
            lcBaseFile = This.computePerFileBasePath( loHost.c_InputFile, 2 )
            IF '.' $ lcStem
               loHost.c_InputFile = lcBaseFile
            ENDIF
         CASE loHost.getCfgValue('n_UseClassPerFile') = 2 AND INLIST(lcExtension, lcTextExt)
            lcBaseFile = This.computePerFileBasePath( loHost.c_InputFile, 3 )
            IF '.' $ lcStem
               loHost.c_InputFile = lcBaseFile
            ENDIF
         ENDCASE
      ENDIF

      IF INLIST(lcExtension, 'SCX', loHost.getCfgValue('c_SC2')) ;
            AND (loHost.getCfgValue('n_UseFormPerFile') > 0 AND loHost.getCfgValue('l_RedirectFormPerFileToMain') ;
            OR NOT EMPTY(loHost.c_ClassToConvert))

         lcTextExt = loHost.getCfgValue('c_SC2')
         DO CASE
         CASE loHost.getCfgValue('n_RedirectFormType') = 1 OR NOT EMPTY(loHost.c_ClassToConvert)
            lcBaseFile = This.computePerFileBasePath( loHost.c_InputFile, 2 )
         CASE loHost.getCfgValue('n_UseFormPerFile') = 1 AND INLIST(lcExtension, lcTextExt)
            lcBaseFile = This.computePerFileBasePath( loHost.c_InputFile, 2 )
            IF '.' $ lcStem
               loHost.c_InputFile = lcBaseFile
            ENDIF
         CASE loHost.getCfgValue('n_UseFormPerFile') = 2 AND INLIST(lcExtension, lcTextExt)
            lcBaseFile = This.computePerFileBasePath( loHost.c_InputFile, 3 )
            IF '.' $ lcStem
               loHost.c_InputFile = lcBaseFile
            ENDIF
         ENDCASE
      ENDIF

      IF INLIST(lcExtension, 'DBC', loHost.getCfgValue('c_DC2')) ;
            AND loHost.getCfgValue('n_UseFilesPerDBC') > 0 AND loHost.getCfgValue('l_RedirectFilePerDBCToMain') ;
            AND loHost.getCfgValue('n_UseFilesPerDBC') = 1
         lcBaseFile = This.computePerFileBasePath( loHost.c_InputFile, 3 )
         IF '.' $ lcStem
            loHost.c_InputFile = lcBaseFile
         ENDIF
      ENDIF

      RETURN lcBaseFile
   ENDFUNC


   PROCEDURE getPerFileDir
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path (or base path without class suffix)
      * tcTextExt                 (v! IN    ) Text extension (c_VC2 or c_SC2)
      * tlUsePerDir               (v! IN    ) UseClassPerDir or UseFormPerDir flag
      * lnUsePerFile              (v! IN    ) UseClassPerFile or UseFormPerFile value
      * RETURN                    (v?    OUT) Directory for per-file text output/search
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcStem, lcDir

      This.normalizePerFileParams( @tlUsePerDir, @lnUsePerFile )
      lcStem  = JUSTSTEM(tcBinaryFile)
      IF lnUsePerFile > 0 AND tlUsePerDir
         lcDir   = ADDBS(JUSTPATH(tcBinaryFile)) + lcStem + '.' + tcTextExt
      ELSE
         lcDir   = JUSTPATH(tcBinaryFile)
      ENDIF

      RETURN lcDir
   ENDPROC


   PROCEDURE getPerFileOutputPath
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path
      * tcSuffix                  (v? IN    ) Class/object suffix; empty = header file
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Full output text file path
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcSuffix, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcStem, lcBase, lcPath

      This.normalizePerFileParams( @tlUsePerDir, @lnUsePerFile )
      lcStem  = JUSTSTEM(tcBinaryFile)
      lcBase  = This.getPerFileDir(tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile)

      IF lnUsePerFile > 0 AND tlUsePerDir
         IF EMPTY(tcSuffix)
            lcPath  = ADDBS(lcBase) + lcStem + '.' + tcTextExt
         ELSE
            lcPath  = ADDBS(lcBase) + lcStem + '.' + tcSuffix + '.' + tcTextExt
         ENDIF
      ELSE
         IF EMPTY(tcSuffix)
            lcPath  = FORCEEXT(tcBinaryFile, tcTextExt)
         ELSE
            lcPath  = ADDBS(JUSTPATH(tcBinaryFile)) + lcStem + '.' + tcSuffix + '.' + tcTextExt
         ENDIF
      ENDIF

      RETURN lcPath
   ENDPROC


   PROCEDURE getPerFileSearchDir
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcTextFile                (v! IN    ) Header or per-class text file path
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Directory to search for sibling per-file text parts
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcTextFile, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcParent, lcStem, lcSearchDir, lcExt

      This.normalizePerFileParams( @tlUsePerDir, @lnUsePerFile )
      IF lnUsePerFile = 0 OR !tlUsePerDir
         RETURN JUSTPATH(tcTextFile)
      ENDIF

      lcParent    = JUSTPATH(tcTextFile)
      lcExt       = '.' + LOWER(tcTextExt)
      IF RIGHT(LOWER(lcParent), LEN(lcExt)) == lcExt
         RETURN lcParent
      ENDIF

      lcStem      = JUSTSTEM(tcTextFile)
      lcSearchDir = ADDBS(lcParent) + lcStem + '.' + tcTextExt
      RETURN lcSearchDir
   ENDPROC


   PROCEDURE getPerFileBinaryOutputPath
      *---------------------------------------------------------------------------------------------------
      * Binary output path for Prg2Bin when text lives under a per-dir folder (library.vc2\).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcSourceFile              (v! IN    ) Source text file path (header or per-class part)
      * tcBinExt                  (v! IN    ) Binary extension (VCX, SCX, ...)
      * tcTextExt                 (v! IN    ) Text extension (c_VC2, c_SC2, ...)
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      * RETURN                    (v?    OUT) Binary file path for output
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcSourceFile, tcBinExt, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcParent, lcTextExtLower, lcContainerStem

      This.normalizePerFileParams( @tlUsePerDir, @lnUsePerFile )

      IF lnUsePerFile > 0 AND tlUsePerDir
         lcParent         = JUSTPATH(tcSourceFile)
         lcTextExtLower   = '.' + LOWER(EVL(tcTextExt, ''))
         IF LEN(lcTextExtLower) > 1 AND RIGHT(LOWER(lcParent), LEN(lcTextExtLower)) == lcTextExtLower
            lcContainerStem = JUSTSTEM(FORCEEXT(lcParent, tcTextExt))
            RETURN ADDBS(JUSTPATH(lcParent)) + lcContainerStem + '.' + tcBinExt
         ENDIF
      ENDIF

      RETURN FORCEEXT(tcSourceFile, tcBinExt)
   ENDPROC


   PROCEDURE ensurePerFileDir
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinaryFile              (v! IN    ) VCX/SCX path
      * tcTextExt                 (v! IN    ) Text extension
      * tlUsePerDir               (v! IN    ) Per-dir flag for this container type
      * lnUsePerFile              (v! IN    ) Per-file mode for this container type
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile
      LOCAL lcDir

      This.normalizePerFileParams( @tlUsePerDir, @lnUsePerFile )
      IF lnUsePerFile = 0 OR !tlUsePerDir
         RETURN
      ENDIF

      lcDir   = This.getPerFileDir(tcBinaryFile, tcTextExt, tlUsePerDir, lnUsePerFile)
      IF FILE(lcDir)
         ERASE (lcDir)
      ENDIF
      This.o_Host.makeDirTree(lcDir)
   ENDPROC


   PROCEDURE resolvePj2TextMemberPath
      *---------------------------------------------------------------------------------------------------
      * Resolves the best text-file path for a PJ2 binary member (Prg2Bin / importProjectTree).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinFile                 (v! IN    ) PJ2 member path (.vcx, .scx, .dbc, ...)
      * RETURN                    (v?    OUT) Text file path to pass to convert()
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinFile
      LOCAL lcExt, lcFlat, lcHeader, lcStem, lnPerFile, llPerDir, lcTextExt, laDir(1), loHost

      loHost      = This.o_Host
      lcExt       = UPPER(JUSTEXT(tcBinFile))
      lcFlat      = FORCEEXT(tcBinFile, loHost.get_TextExtForBinFile(tcBinFile))

      DO CASE
      CASE INLIST(lcExt, 'VCX', UPPER(loHost.getCfgValue('c_VC2')))
         lnPerFile   = loHost.getCfgInt('n_UseClassPerFile')
         llPerDir    = loHost.getCfgFlag('l_UseClassPerDir')
         lcTextExt   = loHost.getCfgValue('c_VC2')
         IF lnPerFile > 0
            lcHeader = This.getPerFileOutputPath(tcBinFile, '', lcTextExt, llPerDir, lnPerFile)
            IF FILE(lcHeader)
               RETURN lcHeader
            ENDIF
            lcStem   = JUSTSTEM(tcBinFile)
            IF llPerDir
               IF ADIR(laDir, ADDBS(This.getPerFileDir(tcBinFile, lcTextExt, llPerDir, lnPerFile)) ;
                     + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
                  RETURN lcHeader
               ENDIF
            ELSE
               IF ADIR(laDir, ADDBS(JUSTPATH(tcBinFile)) + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
                  RETURN lcHeader
               ENDIF
            ENDIF
         ENDIF

      CASE INLIST(lcExt, 'SCX', UPPER(loHost.getCfgValue('c_SC2')))
         lnPerFile   = loHost.getCfgInt('n_UseFormPerFile')
         llPerDir    = loHost.getCfgFlag('l_UseFormPerDir')
         lcTextExt   = loHost.getCfgValue('c_SC2')
         IF lnPerFile > 0
            lcHeader = This.getPerFileOutputPath(tcBinFile, '', lcTextExt, llPerDir, lnPerFile)
            IF FILE(lcHeader)
               RETURN lcHeader
            ENDIF
            lcStem   = JUSTSTEM(tcBinFile)
            IF llPerDir
               IF ADIR(laDir, ADDBS(This.getPerFileDir(tcBinFile, lcTextExt, llPerDir, lnPerFile)) ;
                     + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
                  RETURN lcHeader
               ENDIF
            ELSE
               IF ADIR(laDir, ADDBS(JUSTPATH(tcBinFile)) + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
                  RETURN lcHeader
               ENDIF
            ENDIF
         ENDIF

      CASE INLIST(lcExt, 'DBC', UPPER(loHost.getCfgValue('c_DC2')))
         lnPerFile   = loHost.getCfgInt('n_UseFilesPerDBC')
         lcTextExt   = loHost.getCfgValue('c_DC2')
         IF lnPerFile > 0
            lcHeader = FORCEEXT(tcBinFile, lcTextExt)
            IF FILE(lcHeader)
               RETURN lcHeader
            ENDIF
            lcStem   = JUSTSTEM(tcBinFile)
            IF ADIR(laDir, ADDBS(JUSTPATH(tcBinFile)) + lcStem + '.*.*.' + lcTextExt) > 0
               RETURN lcHeader
            ENDIF
         ENDIF

      ENDCASE

      RETURN lcFlat
   ENDPROC


   FUNCTION isPj2TextMemberAvailable
      *---------------------------------------------------------------------------------------------------
      * Returns .T. when text source exists for a PJ2 binary member (flat file, per-dir folder, or split parts).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcBinFile                 (v! IN    ) PJ2 member path (.vcx, .scx, .dbc, ...)
      * RETURN                    (v?    OUT) .T. when import can proceed
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcBinFile
      LOCAL lcExt, lcFlat, lcResolved, lnPerFile, llPerDir, lcTextExt, lcStem, laDir(1), loHost

      loHost      = This.o_Host
      lcResolved  = This.resolvePj2TextMemberPath(tcBinFile)
      IF FILE(lcResolved)
         RETURN .T.
      ENDIF

      lcExt       = UPPER(JUSTEXT(tcBinFile))
      lcFlat      = FORCEEXT(tcBinFile, loHost.get_TextExtForBinFile(tcBinFile))
      IF FILE(lcFlat)
         RETURN .T.
      ENDIF

      lnPerFile   = 0
      llPerDir    = .F.
      lcTextExt   = ''

      DO CASE
      CASE INLIST(lcExt, 'VCX', UPPER(loHost.getCfgValue('c_VC2')))
         lnPerFile   = loHost.getCfgInt('n_UseClassPerFile')
         llPerDir    = loHost.getCfgFlag('l_UseClassPerDir')
         lcTextExt   = loHost.getCfgValue('c_VC2')

      CASE INLIST(lcExt, 'SCX', UPPER(loHost.getCfgValue('c_SC2')))
         lnPerFile   = loHost.getCfgInt('n_UseFormPerFile')
         llPerDir    = loHost.getCfgFlag('l_UseFormPerDir')
         lcTextExt   = loHost.getCfgValue('c_SC2')

      CASE INLIST(lcExt, 'DBC', UPPER(loHost.getCfgValue('c_DC2')))
         lnPerFile   = loHost.getCfgInt('n_UseFilesPerDBC')
         lcTextExt   = loHost.getCfgValue('c_DC2')

      OTHERWISE
         RETURN .F.

      ENDCASE

      IF lnPerFile > 0
         lcStem   = JUSTSTEM(tcBinFile)
         IF llPerDir
            RETURN ADIR(laDir, ADDBS(This.getPerFileDir(tcBinFile, lcTextExt, llPerDir, lnPerFile)) ;
                  + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
         ELSE
            RETURN ADIR(laDir, ADDBS(JUSTPATH(tcBinFile)) + lcStem + IIF(lnPerFile = 1, '.*.', '.*.*.') + lcTextExt) > 0
         ENDIF
      ENDIF

      RETURN .F.
   ENDFUNC


   FUNCTION rewritePerObjectInputPath
      *---------------------------------------------------------------------------------------------------
      * Rewrites single-class/form per-file paths for Import (I) and RedirectClassType = 2.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tc_InputFile              (v! IN    ) Original input path
      * tcType                    (v? IN    ) execute() type
      * lcExt                     (v! IN    ) Upper extension (VCX, SCX, c_VC2, …)
      * RETURN                    (v?    OUT) Resolved input path for convert()
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tc_InputFile, tcType, lcExt
      LOCAL laFiles(1,5), lnRedirect, lnUsePerFile, lcTextExt, lcUsePerDir, llIsClass, llIsForm, loHost

      loHost = This.o_Host
      IF INLIST(LOWER(EVL(tcType,'')), '-c', 'c', '-t', 't')
         RETURN tc_InputFile
      ENDIF
      llIsClass = INLIST(lcExt, loHost.getCfgValue('c_VC2'), "VCX")
      llIsForm  = INLIST(lcExt, loHost.getCfgValue('c_SC2'), "SCX")
      IF llIsClass
         lnRedirect   = loHost.getCfgValue('n_RedirectClassType')
         lnUsePerFile = loHost.getCfgValue('n_UseClassPerFile')
         lcTextExt    = loHost.getCfgValue('c_VC2')
         lcUsePerDir  = 'l_UseClassPerDir'
      ELSE
         IF llIsForm
            lnRedirect   = loHost.getCfgValue('n_RedirectFormType')
            lnUsePerFile = loHost.getCfgValue('n_UseFormPerFile')
            lcTextExt    = loHost.getCfgValue('c_SC2')
            lcUsePerDir  = 'l_UseFormPerDir'
         ELSE
            RETURN tc_InputFile
         ENDIF
      ENDIF
      IF lnRedirect = 2 AND EMPTY(loHost.c_ClassToConvert) AND lnUsePerFile > 0 ;
            AND '.' $ JUSTSTEM(JUSTFNAME(tc_InputFile))
         loHost.c_ClassToConvert = LOWER( JUSTEXT( JUSTSTEM( tc_InputFile ) ) )
         tc_InputFile = LOWER( JUSTPATH( tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( tc_InputFile ) ) + '.' + JUSTEXT( tc_InputFile ) )
         IF lnUsePerFile = 2
            tc_InputFile = LOWER( JUSTPATH( tc_InputFile ) + '\' + JUSTSTEM( JUSTSTEM( tc_InputFile ) ) + '.' + JUSTEXT( tc_InputFile ) )
         ENDIF
         loHost.c_ClassOperationType = IIF( loHost.isBinToTextMode(tcType), 'E', 'I')
      ENDIF
      IF loHost.c_ClassOperationType = 'I'
         IF llIsClass AND INLIST(lcExt, loHost.getCfgValue('c_VC2'), "VCX")
            IF lnUsePerFile = 2
               tc_InputFile = ADDBS( This.getPerFileDir( tc_InputFile, lcTextExt, loHost.getCfgFlag(lcUsePerDir), lnUsePerFile ) ) ;
                  + JUSTSTEM(tc_InputFile) + '.*.' + loHost.c_ClassToConvert + '.' + lcTextExt
               IF ADIR(laFiles, tc_InputFile) = 1
                  tc_InputFile = FULLPATH( laFiles(1,1), tc_InputFile )
               ENDIF
            ELSE
               tc_InputFile = This.getPerFileOutputPath( tc_InputFile, loHost.c_ClassToConvert, lcTextExt, ;
                  loHost.getCfgFlag(lcUsePerDir), lnUsePerFile )
            ENDIF
         ENDIF
         IF llIsForm AND INLIST(lcExt, loHost.getCfgValue('c_SC2'), "SCX")
            IF lnUsePerFile = 2
               tc_InputFile = ADDBS( This.getPerFileDir( tc_InputFile, lcTextExt, loHost.getCfgFlag(lcUsePerDir), lnUsePerFile ) ) ;
                  + JUSTSTEM(tc_InputFile) + '.*.' + loHost.c_ClassToConvert + '.' + lcTextExt
               IF ADIR(laFiles, tc_InputFile) = 1
                  tc_InputFile = FULLPATH( laFiles(1,1), tc_InputFile )
               ENDIF
            ELSE
               tc_InputFile = This.getPerFileOutputPath( tc_InputFile, loHost.c_ClassToConvert, lcTextExt, ;
                  loHost.getCfgFlag(lcUsePerDir), lnUsePerFile )
            ENDIF
         ENDIF
      ENDIF
      RETURN tc_InputFile
   ENDFUNC

ENDDEFINE
