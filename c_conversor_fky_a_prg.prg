#INCLUDE foxbin2prg.h

Define Class c_conversor_fky_a_prg As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   #If .F.
      Local This As c_conversor_fky_a_prg Of 'c_conversor_fky_a_prg.prg'
   #Endif
   c_Type                  = 'FKY'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toMacro                   (!@    OUT) Objeto generado de clase CL_MACRO con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toMacro, toEx As Exception, toFoxBin2Prg
      DoDefault( @toMacro, @toEx, @toFoxBin2Prg )

      #If .F.
         Local toMacro As CL_MACRO Of 'cl_macro.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Local lnCodError, lnLen, lnHandle ;
         , loLang As CL_LANG Of 'cl_lang.prg'

      Try
         With This As c_conversor_fky_a_prg Of 'c_conversor_fky_a_prg.prg'
            lnHandle    = -1

            If toFoxBin2Prg.l_ProcessFiles Then
               loLang          = _Screen.o_FoxBin2Prg_Lang
               Store 0 To lnCodError

               .updateProgressbar( 'Analyzing FKY...', 1, 2, 1 )

               *-- Verificación de archivo de macros válido
               *IF FCOUNT() < 25 OR EMPTY(FIELD("RESNAME")) OR EMPTY(FIELD("SYSRES"))
               *   *ERROR 'Menu [' + (.c_InputFile) + '] is NOT VFP 9 Format! - Please convert to VFP 9 with MODIFY MENU ' + JUSTFNAME((.c_InputFile))
               *   ERROR (TEXTMERGE(loLang.C_MENU_NOT_IN_VFP9_FORMAT_LOC))
               *ENDIF

               *-- Header
               C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

               toMacro         = NewObject('CL_MACRO', 'cl_macro.prg')
               toMacro.get_DataFromMacroFKY(.c_InputFile, @toFoxBin2Prg)
               C_FB2PRG_CODE   = C_FB2PRG_CODE + toMacro.toText()
            Endif

            Do Case
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_I1'
               Error 'InputFile Error Simulation'
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_I0'
               .writeErrorLog( '*** SIMULATED ERROR' )
            Endcase

            If .l_Error
               .writeLog( '*** ERRORS found - Generation Cancelled' )
               Exit
            Endif

            toFoxBin2Prg.updateProcessedFile()


            *-- Genero el FK2
            If toFoxBin2Prg.l_ProcessFiles Then
               .updateProgressbar( 'Writing ' + toFoxBin2Prg.getCfgValue('c_FK2') + '...', 2, 2, 1 )
            Endif

            If .l_Test
               toMacro = C_FB2PRG_CODE
            Else
               .write_OutputFile( (C_FB2PRG_CODE), .c_OutputFile, @toFoxBin2Prg )
            Endif
         Endwith && THIS


      Catch To toEx
         This.set_UserValue(@toEx)

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         *
      Endtry

      Return
   Endproc

Enddefine
