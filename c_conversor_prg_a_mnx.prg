#INCLUDE foxbin2prg.h

Define Class c_conversor_prg_a_mnx As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
   #If .F.
      Local This As c_conversor_prg_a_mnx Of 'c_conversor_prg_a_mnx.prg'
   #Endif
   _MemberData = [<VFPData>] ;
      + [<memberdata name="c_menulocation" display="c_MenuLocation"/>] ;
      + [<memberdata name="n_menutype" display="n_MenuType"/>] ;
      + [</VFPData>]

   c_Type                  = 'MN2'
   n_MenuType              = 0
   c_MenuLocation          = ''


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toMenu                    (!@    OUT) Objeto generado de clase CL_DBC con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toMenu, toEx As Exception, toFoxBin2Prg
      DoDefault( @toMenu, @toEx, @toFoxBin2Prg )

      #If .F.
         Local toMenu As CL_MENU Of 'cl_menu.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lnCodError, loEx As Exception, loReg, lcLine, laCodeLines(1), lnCodeLines ;
            , laLineasExclusion(1), lnBloquesExclusion, lnIDInputFile
         Store 0 To lnCodError, lnCodeLines
         Store '' To lcLine
         Store .Null. To toMenu

         With This As c_conversor_prg_a_mnx Of 'c_conversor_prg_a_mnx.prg'
            lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

            If Not toFoxBin2Prg.l_ProcessFiles Then
               *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
               If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                  toFoxBin2Prg.updateProcessedFile()
               Endif

               Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
            Endif

            C_FB2PRG_CODE       = Filetostr( .c_InputFile )
            lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

            .createMenu('CURSOR',toMenu )

            *-- Identifico el inicio/fin de bloque, definición, cabecera y cuerpo del reporte
            .updateProgressbar( 'Identifying Code Blocks...', 1, 2, 1 )
            .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toMenu )
            Use In (Select('TABLABIN'))

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

            toFoxBin2Prg.updateProcessedFile( lnIDInputFile )
            .updateProgressbar( 'Generating Binary...', 1, 2, 1 )
            toFoxBin2Prg.doBackup( .F., .T., '', '', '' )
            .createMenu(.F.,toMenu )
            .writeBinaryFile( @toMenu, @toFoxBin2Prg )
         Endwith && THIS


      Catch To loEx
         lnCodError  = loEx.ErrorNo

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
      Endtry

      Return lnCodError
   Endproc


   Procedure identifyCodeBlocks
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (!@ IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (!@ IN    ) Cantidad de líneas de código
      * taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@? IN    ) Sin uso
      * toMenu                    (@?    OUT) Objeto con toda la información del menú analizado
      *
      * NOTA:
      * Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
      *--------------------------------------------------------------------------------------------------------------
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toMenu

      External Array taCodeLines, taLineasExclusion

      #If .F.
         Local toMenu As CL_MENU Of 'cl_menu.prg'
      #Endif

      Try
         Local I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueMenu_Completed
         Store 0 To I

         With This As c_conversor_prg_a_mnx Of 'c_conversor_prg_a_mnx.prg'
            .c_Type = Upper(Justext(.c_OutputFile))

            If tnCodeLines > 1
               toMenu      = .Null.
               toMenu      = NewObject('CL_MENU', 'cl_menu.prg')

               For I = 1 To tnCodeLines
                  .set_Line( @lcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Vacía o solo Comentarios
                     Loop

                  Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( toMenu, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     llFoxBin2Prg_Completed  = .T.

                  Case Not llBloqueMenu_Completed And toMenu.analyzeCodeBlock( @lcLine, @taCodeLines, @m.I, tnCodeLines, This )
                     llBloqueMenu_Completed  = .T.

                  Endcase
               Endfor
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toMenu ;
            , I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueMenu_Completed
      Endtry

      Return
   Endproc


   Procedure writeBinaryFile
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toMenu                    (!@    OUT) Objeto generado de clase CL_DBC con la información leida del texto
      *---------------------------------------------------------------------------------------------------
      Lparameters toMenu, toFoxBin2Prg

      #If .F.
         Local toMenu As CL_MENU Of 'cl_menu.prg'
      #Endif

      Try
         Local lnCodError
         lnCodError  = 0

         *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
         toFoxBin2Prg.addProcessedFile( This.c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

         Do Case
         Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
            Error 'OutputFile Error Simulation'
         Endcase

         toMenu.updateMENU( This )

         toFoxBin2Prg.updateProcessedFile()


      Catch To loEx
         lnCodError  = loEx.ErrorNo
         toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select(Juststem(This.c_OutputFile)))

      Endtry

      Return lnCodError
   Endproc


Enddefine
