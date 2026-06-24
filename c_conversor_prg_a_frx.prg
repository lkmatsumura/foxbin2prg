#INCLUDE foxbin2prg.h

Define Class c_conversor_prg_a_frx As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
   #If .F.
      Local This As c_conversor_prg_a_frx Of 'c_conversor_prg_a_frx.prg'
   #Endif
   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzecodeblock_cdata_inline" display="analyzeCodeBlock_CDATA_inline"/>] ;
      + [<memberdata name="analyzecodeblock_platform" display="analyzeCodeBlock_platform"/>] ;
      + [<memberdata name="analyzecodeblock_reportes" display="analyzeCodeBlock_Reportes"/>] ;
      + [</VFPData>]
   c_Type                  = 'FR2'
   l_Fox2x                 = .F.


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toReport                  (!@    OUT) Objeto generado de clase CL_REPORT con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toReport, toEx As Exception, toFoxBin2Prg
      DoDefault( @toReport, @toEx, @toFoxBin2Prg )

      #If .F.
         Local toReport As CL_REPORT Of 'cl_report.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lnCodError, loEx As Exception, laCodeLines(1), lnCodeLines ;
            , laLineasExclusion(1), lnBloquesExclusion, I, lnIDInputFile

         With This As c_conversor_prg_a_frx Of 'c_conversor_prg_a_frx.prg'
            Store 0 To lnCodError, lnCodeLines
            Store .Null. To toReport
            lnIDInputFile = toFoxBin2Prg.n_ProcessedFiles

            If Not toFoxBin2Prg.l_ProcessFiles Then
               *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
               If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                  toFoxBin2Prg.updateProcessedFile()
               Endif

               Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
            Endif

            C_FB2PRG_CODE = toFoxBin2Prg.readTextFile( .c_InputFile )
            lnCodeLines   = Alines( laCodeLines, C_FB2PRG_CODE )

            .l_Fox2x = Inlist( Upper(Justext(.c_InputFile)) ;
               , Upper(toFoxBin2Prg.getCfgValue('c_FR2D')) ;
               , Upper(toFoxBin2Prg.getCfgValue('c_LB2D')) )

            .createReport('CURSOR',toReport,.l_Fox2x)

            *-- Identifico el inicio/fin de bloque, definición, cabecera y cuerpo del reporte
            .updateProgressbar( 'Identifying Code Blocks...', 1, 2, 1 )
            .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toReport )
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
            .updateProgressbar( 'Generating Binary...', 2, 2, 1 )
            toFoxBin2Prg.doBackup( .F., .T., '', '', '' )
            .createReport(.F.,toReport,.l_Fox2x)
            .writeBinaryFile( @toReport, @toFoxBin2Prg )
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



   Procedure writeBinaryFile
      Lparameters toReport, toFoxBin2Prg
      *-- -----------------------------------------------------------------------------------------------------------
      #If .F.
         Local toReport As CL_REPORT Of 'cl_report.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local loReg, I, lcFieldType, lnFieldLen, lnFieldDec, lnNumCampo, laFieldTypes(1,18) ;
            , luValor, lnCodError, loEx As Exception ;
            , loLang As CL_LANG Of 'cl_lang.prg'

         loLang          = _Screen.o_FoxBin2Prg_Lang
         Select TABLABIN
         Afields( laFieldTypes )
         loReg   = .Null.

         *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
         toFoxBin2Prg.addProcessedFile( This.c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

         Do Case
         Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
            Error 'OutputFile Error Simulation'
         Endcase

         *-- Agrego los registros
         For Each loReg In toReport FoxObject

            *IF toFoxBin2Prg.getCfgValue('l_NoTimestamps')
            *   loReg.TIMESTAMP = 0
            *ENDIF
            *IF toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
            *   loReg.UNIQUEID  = ''
            *ENDIF
            If Empty(loReg.Timestamp)
               loReg.Timestamp = .rowTimeStamp( {^2013/11/04 20:00:00} )
            Endif
            If Empty(loReg.UNIQUEID) Or Alltrim(loReg.UNIQUEID) = '0'
               loReg.UNIQUEID  = toFoxBin2Prg.unique_ID()
            Endif

            *-- Ajuste de los tipos de dato
            For I = 1 To Amembers(laProps, loReg, 0)
               lnNumCampo  = Ascan( laFieldTypes, laProps(m.I), 1, -1, 1, 1+2+4+8 )

               If lnNumCampo = 0
                  *ERROR 'No se encontró el campo [' + laProps(m.I) + '] en la estructura del archivo ' + DBF("TABLABIN")
                  Error (Textmerge(loLang.C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC))
               Endif

               lcFieldType = laFieldTypes(lnNumCampo,2)
               lnFieldLen  = laFieldTypes(lnNumCampo,3)
               lnFieldDec  = laFieldTypes(lnNumCampo,4)
               luValor     = Evaluate('loReg.' + laProps(m.I))

               Do Case
               Case Inlist(lcFieldType, 'B')   && Double
                  AddProperty( loReg, laProps(m.I), Cast( luValor As &lcFieldType. (lnFieldPrec) ) )

               Case Inlist(lcFieldType, 'F', 'N', 'Y') && Float, Numeric, Currency
                  AddProperty( loReg, laProps(m.I), Cast( luValor As &lcFieldType. (lnFieldLen, lnFieldDec) ) )

               Case Inlist(lcFieldType, 'W', 'G', 'M', 'Q', 'V', 'C')  && Blob, General, Memo, Varbinary, Varchar, Character
                  AddProperty( loReg, laProps(m.I), luValor )

               Otherwise   && Demás tipos
                  AddProperty( loReg, laProps(m.I), Cast( luValor As &lcFieldType. (lnFieldLen) ) )

               Endcase

            Endfor

            Insert Into TABLABIN From Name loReg
            loReg   = .Null.
         Endfor

         If This.l_Fox2x
            SELECT TABLABIN
            Copy To (This.c_OutputFile) Fox2x
         Endif

         Use In (Select("TABLABIN"))

         If toFoxBin2Prg.getCfgValue('l_Recompile')
            toFoxBin2Prg.compileFoxProBinary(This.c_OutputFile)
         Endif

         toFoxBin2Prg.updateProcessedFile()


      Catch To loEx
         lnCodError  = loEx.ErrorNo
         toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         loReg   = .Null.
         Release loReg, I, lcFieldType, lnFieldLen, lnFieldDec, lnNumCampo, laFieldTypes, luValor

      Endtry

      Return lnCodError
   Endproc



   Procedure identifyCodeBlocks
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toReport
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (!@ IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (!@ IN    ) Cantidad de líneas de código
      * taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@? IN    ) Cantidad de bloques de exclusion
      * toReport                  (@?    OUT) Objeto con toda la información del reporte analizado
      *
      * NOTA:
      * Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
      *--------------------------------------------------------------------------------------------------------------
      External Array taCodeLines, taLineasExclusion

      #If .F.
         Local toReport As CL_REPORT Of 'cl_report.prg'
      #Endif

      Try
         Local I, lc_Comentario, lcLine, llFoxBin2Prg_Completed
         Store 0 To I

         With This As c_conversor_prg_a_frx Of 'c_conversor_prg_a_frx.prg'
            .c_Type = Upper(Justext(.c_OutputFile))

            If tnCodeLines > 1
               toReport            = .Null.
               toReport            = NewObject('CL_REPORT', 'cl_report.prg')

               For I = 1 To tnCodeLines
                  .set_Line( @lcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Vacía o solo Comentarios
                     Loop

                  Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( toReport, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     llFoxBin2Prg_Completed  = .T.

                  Case .analyzeCodeBlock_Reportes( toReport, @lcLine, @taCodeLines, @m.I, tnCodeLines )

                  Endcase
               Endfor
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return
   Endproc



   Procedure analyzeCodeBlock_CDATA_inline
      *------------------------------------------------------
      *-- Analiza el bloque <picture>
      *------------------------------------------------------
      Lparameters toReport, tcLine, taCodeLines, I, tnCodeLines, toReg, tcPropName
      External Array taCodeLines

      #If .F.
         Local toReport As CL_REPORT Of 'cl_report.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcValue, loEx As Exception

         If Left(tcLine, 1 + Len(tcPropName) + 1 + 9) == '<' + tcPropName + '>' + C_DATA_I
            llBloqueEncontrado  = .T.

            If C_DATA_F $ tcLine
               lcValue = Strextract( tcLine, C_DATA_I, C_DATA_F )
               AddProperty( toReg, tcPropName, lcValue )
               Exit
            Endif

            *-- Tomo la primera parte del valor
            lcValue = Strextract( tcLine, C_DATA_I )

            *-- Recorro las fracciones del valor
            For I = m.I + 1 To tnCodeLines
               tcLine  = taCodeLines(m.I)

               If C_DATA_F $ tcLine    && Fin del valor
                  lcValue = lcValue + CR_LF + Strextract( tcLine, '', C_DATA_F )

                  *-- Ajustes: En los labels, no se usa CR+LF, sino que se usa solo CR
                  If toReg.ObjType = "5" Then
                     lcValue = Strtran(lcValue, CR_LF, C_CR)
                  Endif

                  AddProperty( toReg, tcPropName, lcValue )
                  Exit

               Else    && Otra fracción del valor
                  lcValue = lcValue + CR_LF + tcLine
               Endif
            Endfor

         Endif

      Catch To loEx
         If loEx.ErrorNo = 1470  && Incorrect property name.
            loEx.UserValue  = 'PropName=[' + Transform(tcPropName) + '], Value=[' + Transform(lcValue) + ']'
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toReport, tcLine, taCodeLines, I, tnCodeLines, toReg, tcPropName ;
            , lcValue, loEx
      Endtry

      Return llBloqueEncontrado
   Endproc



   Procedure analyzeCodeBlock_platform
      *------------------------------------------------------
      *-- Analiza el bloque <platform=>
      *------------------------------------------------------
      Lparameters toReport, tcLine, taCodeLines, I, tnCodeLines, toReg
      External Array taCodeLines

      #If .F.
         Local toReport As CL_REPORT Of 'cl_report.prg'
      #Endif

      Try
         Local llBloqueEncontrado, X, lnPos, lnPos2, lcValue, lnLenPropName, laProps(1)

         If Lower( Left(tcLine, 10) ) == 'platform="'
            llBloqueEncontrado  = .T.
            lnLastPos           = 1
            tcLine              = ' ' + tcLine

            For X = 1 To Amembers( laProps, toReg, 0 )
               laProps(m.X)    = ' ' + laProps(m.X)
               lnPos       = At( Lower(laProps(m.X)) + '="', tcLine )

               If lnPos > 0
                  lnLenPropName   = Len(laProps(m.X))
                  lnPos2          = At( '"', Substr( tcLine, lnPos + lnLenPropName + 2 ) )
                  lcValue         = Substr( tcLine, lnPos + lnLenPropName + 2, lnPos2 - 1 )

                  If laProps(m.X) == ' NAME' And Not Empty(lcValue)
                     lcValue = This.denormalizeXMLValue(lcValue)
                  Endif

                  AddProperty( toReg, laProps(m.X), lcValue )
               Endif
            Endfor

         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toReport, tcLine, taCodeLines, I, tnCodeLines, toReg ;
            , X, lnPos, lnPos2, lcValue, lnLenPropName, laProps
      Endtry

      Return llBloqueEncontrado
   Endproc



   Procedure analyzeCodeBlock_Reportes
      *------------------------------------------------------
      *-- Analiza el bloque <reportes>
      *------------------------------------------------------
      Lparameters toReport, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      #If .F.
         Local toReport As CL_REPORT Of 'cl_report.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcComment, lcMetadatos, luValor ;
            , laPropsAndValues(1,2), lnPropsAndValues_Count ;
            , loReg

         If Left( tcLine, Len(C_TAG_REPORTE) + 1 ) == '<' + C_TAG_REPORTE + ''
            llBloqueEncontrado  = .T.
            loReg   = .Null.

            With This As c_conversor_prg_a_frx Of 'c_conversor_prg_a_frx.prg'
               Scatter Memo Blank Name loReg

               For I = m.I + 1 To tnCodeLines
                  lcComment   = ''
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Left( tcLine, Len(C_TAG_REPORTE_F) ) == C_TAG_REPORTE_F
                     I = m.I + 1
                     Exit

                  Case .analyzeCodeBlock_platform( toReport, @tcLine, @taCodeLines, @m.I, @tnCodeLines, @loReg )

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'picture' )

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'tag' )
                     *-- ARREGLO ALGUNOS VALORES CAMBIADOS AL TEXTUALIZAR
                     Do Case
                     Case loReg.ObjType == "1"
                        loReg.Tag   = .decode_SpecialCodes_1_31( loReg.Tag )
                     Case Inlist(loReg.ObjType, "25", "26")  && Dataenvironment, cursors and relations
                        loReg.Tag   = Iif( Empty( Chrtran( loReg.Tag, CR_LF+C_TAB, '') ), '', Substr(loReg.Tag,3) ) && Quito el ENTER agregado antes
                     Otherwise
                        loReg.Tag   = .decode_SpecialCodes_1_31( loReg.Tag )
                     Endcase

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'tag2' )
                     *-- ARREGLO ALGUNOS VALORES CAMBIADOS AL TEXTUALIZAR
                     If Not Inlist(loReg.ObjType,"5","6","8")
                        loReg.TAG2  = Strconv( loReg.TAG2,14 )
                     Endif

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'penred' )

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'style' )

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'expr' )

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'supexpr' )

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'comment' )

                  Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'user' )

                  Endcase

               Endfor
            Endwith && THIS

            I = m.I - 1
            toReport.Add( loReg )
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         loReg   = .Null.
         Release lcComment, lcMetadatos, luValor, laPropsAndValues, lnPropsAndValues_Count, loReg

      Endtry

      Return llBloqueEncontrado
   Endproc


Enddefine
