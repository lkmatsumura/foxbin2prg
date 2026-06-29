#INCLUDE foxbin2prg.h

*---------------------------------------------------------------------------------------------------
* Converter factory for FoxBin2Prg (used via c_foxbin2prg.o_ConversionFactory).
*
* Centralizes extension-to-converter routing (c_conversor_*) previously duplicated in
* convert and loadModule. Host session state (CFG, paths, class-per-file) stays on o_Host.
*---------------------------------------------------------------------------------------------------

DEFINE CLASS cl_fb2prg_conversion_factory AS Custom
   * o_Host  Back-reference to c_foxbin2prg (c_InputFile, getCfgValue, changeFileAttribute, etc.)
   o_Host = .NULL.

   PROCEDURE Init
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toHost                    (v! IN    ) c_foxbin2prg session that owns this factory
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS toHost
      This.o_Host = toHost
   ENDPROC


   PROCEDURE Destroy
      This.o_Host = .NULL.
   ENDPROC


   FUNCTION createConversor
      *---------------------------------------------------------------------------------------------------
      * Maps file extension to a c_conversor_* instance. Sets l_Fox2x on FRX/LBX (bin->text)
      * and FR2D/LB2D (text->binary) when applicable.
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcExtension               (v? IN    ) Uppercase file extension (e.g. 'VCX', 'VC2') or text
      *                                       extension from CFG (getCfgValue('c_VC2'), etc.).
      *                                       Defaults to UPPER(JUSTEXT(o_Host.c_InputFile)).
      * tcInputFile               (v? IN    ) Full path of the file being converted; used for
      *                                       detectFox2xRptLbl on FRX/LBX. Defaults to o_Host.c_InputFile.
      *---------------------------------------------------------------------------------------------------
      * RETURN: c_conversor_base instance, .NULL. for not-yet-implemented prg->bin (FK2/ME2),
      *         or ERROR on unsupported extension.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcExtension, tcInputFile
      LOCAL loConversor AS c_conversor_base OF 'c_conversor_base.prg'
      LOCAL loHost, loLang AS CL_LANG OF 'cl_lang.prg', llFox2x

      loHost = This.o_Host
      IF VARTYPE(loHost) <> 'O'
         RETURN .NULL.
      ENDIF

      loLang = _SCREEN.o_FoxBin2Prg_Lang
      tcExtension = UPPER( EVL(tcExtension, '') )
      tcInputFile = EVL(tcInputFile, loHost.c_InputFile)

      DO CASE
      CASE tcExtension == 'VCX'
         loConversor = NewObject( 'c_conversor_vcx_a_prg' , 'c_conversor_vcx_a_prg.prg' )

      CASE tcExtension == 'SCX'
         loConversor = NewObject( 'c_conversor_scx_a_prg' , 'c_conversor_scx_a_prg.prg' )

      CASE tcExtension == 'PJX'
         loConversor = NewObject( 'c_conversor_pjx_a_prg' , 'c_conversor_pjx_a_prg.prg' )

      CASE tcExtension == 'FRX'
         loConversor = NewObject( 'c_conversor_frx_a_prg' , 'c_conversor_frx_a_prg.prg' )
         loConversor.l_Fox2x = loHost.detectFox2xRptLbl(tcInputFile)

      CASE tcExtension == 'LBX'
         loConversor = NewObject( 'c_conversor_frx_a_prg' , 'c_conversor_frx_a_prg.prg' )
         loConversor.l_Fox2x = loHost.detectFox2xRptLbl(tcInputFile)

      CASE tcExtension == 'DBF'
         loConversor = NewObject( 'c_conversor_dbf_a_prg', 'c_conversor_dbf_a_prg.prg' )

      CASE tcExtension == 'DBC'
         loConversor = NewObject( 'c_conversor_dbc_a_prg', 'c_conversor_dbc_a_prg.prg' )

      CASE tcExtension == 'MNX'
         loConversor = NewObject( 'c_conversor_mnx_a_prg' , 'c_conversor_mnx_a_prg.prg' )

      CASE tcExtension == 'FKY'
         loConversor = NewObject( 'c_conversor_fky_a_prg', 'c_conversor_fky_a_prg.prg' )

      CASE tcExtension == 'MEM'
         loConversor = NewObject( 'c_conversor_mem_a_prg', 'c_conversor_mem_a_prg.prg' )

      CASE tcExtension == loHost.getCfgValue('c_VC2')
         loConversor = NewObject( 'c_conversor_prg_a_vcx', 'c_conversor_prg_a_vcx.prg' )

      CASE tcExtension == loHost.getCfgValue('c_SC2')
         loConversor = NewObject( 'c_conversor_prg_a_scx', 'c_conversor_prg_a_scx.prg' )

      CASE tcExtension == loHost.getCfgValue('c_PJ2')
         loConversor = NewObject( 'c_conversor_prg_a_pjx' , 'c_conversor_prg_a_pjx.prg' )

      CASE tcExtension == loHost.getCfgValue('c_FR2')
         loConversor = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )

      CASE tcExtension == loHost.getCfgValue('c_FR2D')
         loConversor = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )
         loConversor.l_Fox2x = .T.

      CASE tcExtension == loHost.getCfgValue('c_LB2')
         loConversor = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )

      CASE tcExtension == loHost.getCfgValue('c_LB2D')
         loConversor = NewObject( 'c_conversor_prg_a_frx', 'c_conversor_prg_a_frx.prg' )
         loConversor.l_Fox2x = .T.

      CASE tcExtension == loHost.getCfgValue('c_DB2')
         loConversor = NewObject( 'c_conversor_prg_a_dbf', 'c_conversor_prg_a_dbf.prg' )

      CASE tcExtension == loHost.getCfgValue('c_DC2')
         loConversor = NewObject( 'c_conversor_prg_a_dbc', 'c_conversor_prg_a_dbc.prg' )

      CASE tcExtension == loHost.getCfgValue('c_MN2')
         loConversor = NewObject( 'c_conversor_prg_a_mnx', 'c_conversor_prg_a_mnx.prg' )

      CASE tcExtension == loHost.getCfgValue('c_FK2')
         * Not implemented (prg->bin)
         loConversor = .NULL.

      CASE tcExtension == loHost.getCfgValue('c_ME2')
         * Not implemented (prg->bin)
         loConversor = .NULL.

      OTHERWISE
         ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))

      ENDCASE

      RETURN loConversor
   ENDFUNC


   PROCEDURE prepareConversion
      *---------------------------------------------------------------------------------------------------
      * FULL conversion mode only: validates n_*_Conversion_Support from session CFG, assigns
      * o_Host.c_OutputFile, and applies changeFileAttribute on output paths (and companion ??T
      * files for prg->bin). Call after createConversor; not used for LOAD_ONLY / loadModule.
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcExtension               (v? IN    ) Same as createConversor (binary or text extension).
      * tcInputFile               (v? IN    ) Full path of the input file. Defaults to o_Host.c_InputFile.
      * tcBaseFile                (v? IN    ) Base library/form path after class-per-file redirect
      *                                       in convert; used for VC2->VCX when c_ClassToConvert
      *                                       is set (syntax classlib.vcx::class::import).
      * tcForceAttribs            (v? IN    ) Attribute flags for changeFileAttribute (e.g. '+N',
      *                                       '+N-R' when n_ForceWriteIfReadOnly = 1). Default '+N'.
      *---------------------------------------------------------------------------------------------------
      * SIDE EFFECTS: Sets o_Host.c_OutputFile; may ERROR with C_FILE_NAME_IS_NOT_SUPPORTED_LOC.
      *---------------------------------------------------------------------------------------------------
      LPARAMETERS tcExtension, tcInputFile, tcBaseFile, tcForceAttribs
      LOCAL loHost, loLang AS CL_LANG OF 'cl_lang.prg', llFox2x

      loHost = This.o_Host
      IF VARTYPE(loHost) <> 'O'
         RETURN
      ENDIF

      loLang = _SCREEN.o_FoxBin2Prg_Lang
      tcExtension = UPPER( EVL(tcExtension, '') )
      tcInputFile = EVL(tcInputFile, loHost.c_InputFile)
      tcForceAttribs = EVL(tcForceAttribs, '+N')

      DO CASE
      CASE tcExtension == 'VCX'
         IF NOT INLIST(loHost.getCfgValue('n_VCX_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_VC2') )
         IF loHost.getCfgInt('n_UseClassPerFile') > 0 AND loHost.getCfgFlag('l_UseClassPerDir')
            loHost.changeFileAttribute( loHost.getPerFileOutputPath( tcInputFile, '', loHost.getCfgValue('c_VC2'), .T., loHost.getCfgInt('n_UseClassPerFile') ), tcForceAttribs )
         ELSE
            loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_VC2') ), tcForceAttribs )
         ENDIF

      CASE tcExtension == 'SCX'
         IF NOT INLIST(loHost.getCfgValue('n_SCX_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_SC2') )
         IF loHost.getCfgInt('n_UseFormPerFile') > 0 AND loHost.getCfgFlag('l_UseFormPerDir')
            loHost.changeFileAttribute( loHost.getPerFileOutputPath( tcInputFile, '', loHost.getCfgValue('c_SC2'), .T., loHost.getCfgInt('n_UseFormPerFile') ), tcForceAttribs )
         ELSE
            loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_SC2') ), tcForceAttribs )
         ENDIF

      CASE tcExtension == 'PJX'
         IF NOT INLIST(loHost.getCfgValue('n_PJX_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_PJ2') )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_PJ2') ), tcForceAttribs )

      CASE tcExtension == 'FRX'
         IF NOT INLIST(loHost.getCfgValue('n_FRX_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         llFox2x = loHost.detectFox2xRptLbl(tcInputFile)
         IF llFox2x
            loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_FR2D') )
            loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_FR2D') ), tcForceAttribs )
         ELSE
            loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_FR2') )
            loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_FR2') ), tcForceAttribs )
         ENDIF

      CASE tcExtension == 'LBX'
         IF NOT INLIST(loHost.getCfgValue('n_LBX_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         llFox2x = loHost.detectFox2xRptLbl(tcInputFile)
         IF llFox2x
            loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_LB2D') )
            loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_LB2D') ), tcForceAttribs )
         ELSE
            loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_LB2') )
            loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_LB2') ), tcForceAttribs )
         ENDIF

      CASE tcExtension == 'DBF'
         IF !INLIST(loHost.getCfgValue('n_DBF_Conversion_Support'), 1, 2, 4, 8)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_DB2') )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_DB2') ), tcForceAttribs )

      CASE tcExtension == 'DBC'
         IF NOT INLIST(loHost.getCfgValue('n_DBC_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_DC2') )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_DC2') ), tcForceAttribs )

      CASE tcExtension == 'MNX'
         IF NOT INLIST(loHost.getCfgValue('n_MNX_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_MN2') )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_MN2') ), tcForceAttribs )

      CASE tcExtension == 'FKY'
         IF NOT INLIST(loHost.getCfgValue('n_FKY_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_FK2') )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_FK2') ), tcForceAttribs )

      CASE tcExtension == 'MEM'
         IF NOT INLIST(loHost.getCfgValue('n_MEM_Conversion_Support'), 1, 2)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, loHost.getCfgValue('c_ME2') )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, loHost.getCfgValue('c_ME2') ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_VC2')
         IF loHost.getCfgValue('n_VCX_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         IF EMPTY(loHost.c_ClassToConvert)
            loHost.c_OutputFile = loHost.getPerFileBinaryOutputPath( tcInputFile, 'VCX', loHost.getCfgValue('c_VC2'), ;
               loHost.getCfgFlag('l_UseClassPerDir'), loHost.getCfgInt('n_UseClassPerFile') )
         ELSE
            loHost.c_OutputFile = loHost.getPerFileBinaryOutputPath( FORCEEXT( tcBaseFile, 'VCX' ), 'VCX', loHost.getCfgValue('c_VC2'), ;
               loHost.getCfgFlag('l_UseClassPerDir'), loHost.getCfgInt('n_UseClassPerFile') )
         ENDIF
         loHost.changeFileAttribute( loHost.c_OutputFile, tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( loHost.c_OutputFile, 'VCT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_SC2')
         IF loHost.getCfgValue('n_SCX_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = loHost.getPerFileBinaryOutputPath( tcInputFile, 'SCX', loHost.getCfgValue('c_SC2'), ;
            loHost.getCfgFlag('l_UseFormPerDir'), loHost.getCfgInt('n_UseFormPerFile') )
         loHost.changeFileAttribute( loHost.c_OutputFile, tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( loHost.c_OutputFile, 'SCT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_PJ2')
         IF loHost.getCfgValue('n_PJX_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, 'PJX' )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'PJX' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'PJT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_FR2')
         IF loHost.getCfgValue('n_FRX_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, 'FRX' )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'FRX' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'FRT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_FR2D')
         IF loHost.getCfgValue('n_FRX_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, 'FRX' )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'FRX' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'FRT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_LB2')
         IF loHost.getCfgValue('n_LBX_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, 'LBX' )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'LBX' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'LBT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_LB2D')
         IF loHost.getCfgValue('n_LBX_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, 'LBX' )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'LBX' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'LBT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_DB2')
         IF !INLIST(loHost.getCfgValue('n_DBF_Conversion_Support'), 2, 8)
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, 'DBF' )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'DBF' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'FPT' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'CDX' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_DC2')
         IF loHost.getCfgValue('n_DBC_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, 'DBC' )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'DBC' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'DCX' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'DCT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_MN2')
         IF loHost.getCfgValue('n_MNX_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         loHost.c_OutputFile = FORCEEXT( tcInputFile, 'MNX' )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'MNX' ), tcForceAttribs )
         loHost.changeFileAttribute( FORCEEXT( tcInputFile, 'MNT' ), tcForceAttribs )

      CASE tcExtension == loHost.getCfgValue('c_FK2')
         IF loHost.getCfgValue('n_FKY_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         * Not implemented

      CASE tcExtension == loHost.getCfgValue('c_ME2')
         IF loHost.getCfgValue('n_MEM_Conversion_Support') <> 2
            ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
         ENDIF
         * Not implemented

      OTHERWISE
         ERROR (TEXTMERGE(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))

      ENDCASE
   ENDPROC

ENDDEFINE
