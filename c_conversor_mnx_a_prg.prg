
#INCLUDE foxbin2prg.h

Define Class c_conversor_mnx_a_prg As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   #If .F.
      Local This As c_conversor_mnx_a_prg Of 'c_conversor_mnx_a_prg.prg'
   #Endif
   c_Type = 'MNX'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * totoMenu                  (!@    OUT) Objeto generado de clase CL_MENU con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toMenu, toEx As Exception, toFoxBin2Prg
      DoDefault( @toMenu, @toEx, @toFoxBin2Prg )

      #If .F.
         Local toMenu As CL_MENU Of 'cl_menu.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
      #Endif

      Try
         With This As c_conversor_mnx_a_prg Of 'c_conversor_mnx_a_prg.prg'
            If toFoxBin2Prg.l_ProcessFiles Then
               Local lnCodError, lnLen ;
                  , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

               loLang          = _Screen.o_FoxBin2Prg_Lang
               Store 0 To lnCodError

               Use (.c_InputFile) Shared Again Noupdate Alias _TABLAORIG

               toFoxBin2Prg.i_CPID = Cpdbf("_TABLAORIG")
               Set NoCPTrans To Name,Prompt,Command,Message,Procedure,Setup,CLEANUP,KEYNAME,KEYLABEL,SkipFor


               Select * From _TABLAORIG Into Cursor TABLABIN
               Use In (Select("_TABLAORIG"))
               .updateProgressbar( 'Analyzing MNX...', 1, 2, 1 )

               *-- Verificación de menú VFP 9
               If Fcount() < 25 Or Empty(Field("RESNAME")) Or Empty(Field("SYSRES"))
                  *ERROR 'Menu [' + (.c_InputFile) + '] is NOT VFP 9 Format! - Please convert to VFP 9 with MODIFY MENU ' + JUSTFNAME((.c_InputFile))
                  Error (Textmerge(loLang.C_MENU_NOT_IN_VFP9_FORMAT_LOC))
               Endif

               *-- Header
               C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

               toMenu          = NewObject('CL_MENU' , 'cl_menu.prg')
               toMenu.get_DataFromTablabin()
               C_FB2PRG_CODE   = C_FB2PRG_CODE + toMenu.toText()
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


            *-- Genero el MN2
            If toFoxBin2Prg.l_ProcessFiles Then
               .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_MN2 + '...', 2, 2, 1 )
            Endif

            If .l_Test
               toMenu  = C_FB2PRG_CODE
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
         Use In (Select("TABLABIN"))
         Use In (Select("_TABLAORIG"))
         Release toMenu, toEx, toFoxBin2Prg, lnCodError, lnLen

      Endtry

      Return
   Endproc
Enddefine
