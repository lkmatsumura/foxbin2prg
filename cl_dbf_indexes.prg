#INCLUDE foxbin2prg.h

Define Class CL_DBF_INDEXES As CL_COL_BASE Of 'cl_col_base.prg'
   #If .F.
      Local This As CL_DBF_INDEXES Of 'cl_dbf_indexes.prg'
   #Endif

   * LScheffler
   Procedure analyzeIndexFilesBlock
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      Try
         Local llBloqueEncontrado, loEx As Exception

         If Left(tcLine, Len(C_CDXIDX_I)) == C_CDXIDX_I
            llBloqueEncontrado  = .T.

            With This As CL_DBF_INDEXES Of 'cl_dbf_indexes.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_CDXIDX_F $ tcLine    && Fin
                     Exit

                  Case C_CDX_I $ tcLine
                     .analyzeIndexFileBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Otherwise   && Otro valor
                     *-- No hay otros valores
                  Endcase
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally

      Endtry

      Return llBloqueEncontrado
   Endproc &&analyzeIndexFilesBlock


   Procedure analyzeIndexFileBlock
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      Try
         Local llBloqueEncontrado, loEx As Exception
         Local lcFile As String, llStandAlone As Boolean

         If Left(tcLine, Len(C_CDX_I)) == C_CDX_I
            llBloqueEncontrado  = .T.

            lcFile       = Strextract(m.tcLine,C_CDX_File_,'"',1)
            llStandAlone = Strextract(m.tcLine,C_CDX_Type_,'"',1) == C_CDX_Type_IDX
            With This As CL_DBF_INDEXES Of 'cl_dbf_indexes.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_CDX_F $ tcLine   && Fin
                     Exit

                  Case C_INDEXES_I $ tcLine
                     .analyzeCodeBlock( @tcLine, @taCodeLines, @I, m.tnCodeLines, m.lcFile, m.llStandAlone )

                  Otherwise   && Otro valor
                     *-- No hay otros valores
                  Endcase
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally

      Endtry

      Return llBloqueEncontrado
   Endproc &&analyzeIndexFileBlock
   * /LScheffler

   Procedure analyzeCodeBlock
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines, tcIndexFile, tlStandAlone
      External Array taCodeLines

      Try
         Local llBloqueEncontrado, loEx As Exception ;
            , loIndex As CL_DBF_INDEX Of 'cl_dbf_index.prg'
         Store .Null. To loIndex

         If Left(tcLine, Len(C_INDEXES_I)) == C_INDEXES_I
            llBloqueEncontrado  = .T.

            With This As CL_DBF_INDEXES Of 'cl_dbf_indexes.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_INDEXES_F $ tcLine   && Fin
                     Exit

                  Case C_INDEX_I $ tcLine
                     loIndex = .Null.
                     loIndex = NewObject('CL_DBF_INDEX', 'cl_dbf_index.prg')
                     loIndex.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, tcIndexFile, tlStandAlone )
                     .Add( loIndex, loIndex._TagName )

                  Otherwise   && Otro valor
                     *-- No hay otros valores
                  Endcase
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loIndex
         Release loIndex

      Endtry

      Return llBloqueEncontrado
   Endproc


   * LScheffler proc wrapping index
   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taTagInfo                 (@?    OUT) Array de información de indices
      * tnTagInfo_Count           (@?    OUT) Cantidad de índices
      * tc_InputFile              (v! IN    ) Archivo de entrada (el DBF)
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      * tc_DBF_IndexList          (?  IN    ) comm a delimited list of non structuiral index files
      *---------------------------------------------------------------------------------------------------
      Lparameters taTagInfo, tnTagInfo_Count, tc_InputFile, toFoxBin2Prg, tc_DBF_IndexList

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      External Array taTagInfo

      Try
         Local I, lcText, loEx As Exception ;
            , loIndex As CL_DBF_INDEX Of 'cl_dbf_index.prg' ;
            loLang As CL_LANG Of 'cl_lang.prg'
         Store .Null. To loIndex
         lcText  = ''
         Dimension taTagInfo(1,6)

         Local;
            lcText As String,;
            loIndex As "CL_DBF_INDEX"

         Local Array;
            taTagInfo (1,6)
         Local;
            lcIndexFile As String,;
            lcIndexType As String

         loLang          = _Screen.o_FoxBin2Prg_Lang
         toFoxBin2Prg.writeLog( Replicate('+', 100) )
         toFoxBin2Prg.writeLog( loLang.C_INDEX2TXT_PROCESSING_LOC )


         *!* Changed by: LScheffler 18.3.2021
         *!* <pdm>
         *!* <change date="{^2021-03-18,10:34:00}">Changed by: LScheffler<br />
         *!* Standalone index <em>tc_InputFile.IDX</em> will be included if <em>DBF_Conversion_Order</em> is activated
         *!* use only tags of structural compound index file
         *!* </change>
         *!* </pdm>
         lcIndexFile = Juststem( Dbf() ) + '.CDX'

         *               If Tagcount() > 0
         If Tagcount( m.lcIndexFile ) > 0
            lcIndexType = C_CDX_Type_Struct
            toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )
            toFoxBin2Prg.writeLog( '  ' + m.lcIndexType )
            TEXT To m.lcText Additive Textmerge Noshow Flags 1+2 Pretext 1+2
                    <<>>
                    <<chr(9)+chr(9)>><<C_CDX_I>> <<C_CDX_Type_>><<m.lcIndexType>>" >
                    <<>>
                    <<chr(9)+chr(9)+chr(9)>><<C_INDEXES_I>>
            ENDTEXT

            *                   tnTagInfo_Count = Ataginfo( taTagInfo )
            tnTagInfo_Count = Ataginfo( taTagInfo, m.lcIndexFile )

            *!* /Changed by: LScheffler 18.3.2021
            Asort( m.taTagInfo, 1, -1, 0, 1 )
            loIndex         = NewObject('CL_DBF_INDEX', 'cl_dbf_index.prg')

            For I = 1 To m.tnTagInfo_Count
               lcText  = m.lcText + m.loIndex.toText( @taTagInfo, m.I )
            Endfor

            TEXT To m.lcText Additive Textmerge Noshow Flags 1+2 Pretext 1+2
                    <<chr(9)+chr(9)+chr(9)>><<C_INDEXES_F>>
                    <<chr(9)+chr(9)>><<C_CDX_F>>
                    <<>>
            ENDTEXT
         Endif

         If ! Empty( m.tc_DBF_IndexList ) And Vartype( m.tc_DBF_IndexList ) = 'C' Then
            Local Array;
               laIndexFiles( 1 )

            toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )
            toFoxBin2Prg.writeLog( loLang.C_INDEX2TXT_EXTRAFILES_LOC )
            toFoxBin2Prg.writeLog( ' ' + Replicate('- ', 49) )

            *Additional index files
            Alines( laIndexFiles, m.tc_DBF_IndexList ,5 , ',' )
            For Each lcIndexFile In laIndexFiles
               Try
                  lcIndexFile = Sys(2014, ''+m.lcIndexFile, Addbs(Justpath(tc_InputFile) ) )
                  lcIndexType = Substr(Filetostr(m.lcIndexFile),5,4)
                  lcIndexType = Iif( m.lcIndexType = 0hFFFFFFFF, C_CDX_Type_IDX, C_CDX_Type_Compound )
                  toFoxBin2Prg.writeLog( '   '+m.lcIndexType + ' ' + m.lcIndexFile )
                  Set Index To ( m.lcIndexFile )
                  If Tagcount( m.lcIndexFile ) > 0 Then
                     lnTagInfo_Count = Ataginfo( taTagInfo , m.lcIndexFile )
                     TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                                    <<>>
                                    <<+chr(9)+chr(9)>><<C_CDX_I>> <<C_CDX_Type_>><<m.lcIndexType+'"'>> <<C_CDX_File_>><<m.lcIndexFile+'"'>> >
                                    <<>>
                                    <<+chr(9)+chr(9)+chr(9)>><<C_INDEXES_I>>
                     ENDTEXT

                     lnTagInfo_Count = Ataginfo( laTagInfo , m.lcIndexFile)
                     Asort( laTagInfo, 1, -1, 0, 1 )
                     loIndex         = NewObject('CL_DBF_INDEX', 'cl_dbf_index.prg')

                     For I = 1 To lnTagInfo_Count
                        lcText  = lcText + loIndex.toText( @laTagInfo, m.I )
                     Endfor

                     TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                                    <<+chr(9)+chr(9)+chr(9)>><<C_INDEXES_F>>
                                    <<+chr(9)+chr(9)>><<C_CDX_F>>
                                    <<>>
                     ENDTEXT
                  Endif &&TAGCOUNT( m.lcIndexFile ) > 0

               Catch To m.loEx When m.loEx.ErrorNo = 1
                  *File Not found
                  toFoxBin2Prg.writeLog( loLang.C_INDEX2TXT_NOFILE_LOC + m.lcIndexFile)

               Catch To m.loEx When m.loEx.ErrorNo=114
                  *INDEX does not match
                  toFoxBin2Prg.writeLog( loLang.C_INDEX2TXT_NOTTHISTABLE_LOC + m.lcIndexFile)

               Catch To m.loEx
                  If This.n_Debug > 0 And _vfp.StartMode = 0
                     Set Step On
                  Endif

                  Throw

               Finally
                  Store .Null. To m.loIndex
                  Release I, m.loIndex

               Endtry
            Endfor &&lcIndexFile
         Endif &&! EMPTY(toFoxBin2Prg.a_InputFiles)

         If !Empty(m.lcText) Then
            TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)>><<C_CDXIDX_I>><<m.lcText>>
                    <<Chr(9)>><<C_CDXIDX_F>>
            ENDTEXT
         Endif &&!EMPTY(m.lcText)

         toFoxBin2Prg.writeLog( Replicate('+', 100)+CR_LF )
         * /LScheffler

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loIndex
         Release I, loIndex

      Endtry

      Return lcText
   Endproc

Enddefine
