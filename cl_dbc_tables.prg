#INCLUDE foxbin2prg.h

Define Class CL_DBC_TABLES As CL_DBC_COL_BASE Of 'cl_dbc_col_base.prg'
   #If .F.
      Local This As CL_DBC_TABLES Of 'cl_dbc_tables.prg'
   #Endif



   Procedure analyzeCodeBlock
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
         Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
            , loTable As CL_DBC_TABLE Of 'cl_dbc_table.prg'
         Store .Null. To loTable
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_TABLES_I)) == C_TABLES_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_TABLES Of 'cl_dbc_tables.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_TABLES_F $ tcLine    && Fin
                     Exit

                  Case C_TABLE_I $ tcLine
                     loTable = NewObject('CL_DBC_TABLE', 'cl_dbc_table.prg')
                     loTable.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                     .Add( loTable, Padr(Lower(loTable._Name),128) )

                  Otherwise   && Otro valor
                     *-- No hay otros valores
                  Endcase
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx
         If loEx.ErrorNo = 1470  && Incorrect property name.
            loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loTable
         Release lcPropName, lcValue, loTable

      Endtry

      Return llBloqueEncontrado
   Endproc



   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcText, loEx As Exception ;
            , loTable As CL_DBC_TABLE Of 'cl_dbc_table.prg'

         With This As CL_DBC_TABLES Of 'cl_dbc_tables.prg'
            Store .Null. To loTable
            lcText  = ''
            .read_BinDataToProperties()

            If .Count > 0 Then
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><TABLES>
               ENDTEXT

               .KeySort = 2
               For Each loTable In This &&FOXOBJECT
                  lcText  = lcText + loTable.toText( loTable._Name )
               Endfor

               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>></TABLES>
                        <<>>
               ENDTEXT
            Endif


         Endwith


      Catch To loEx
         If Vartype(loTable) = "O" Then
            loEx.UserValue  = loEx.UserValue + CR_LF + "loTable._Name = " + Transform(loTable._Name)
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loTable
         Release loTable

      Endtry

      Return lcText
   Endproc


   Procedure read_BinDataToProperties
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         With This As CL_DBC_TABLES Of 'cl_dbc_tables.prg'
            Local I, lnTable_Count, laTables(1), loEx As Exception ;
               , loTable As CL_DBC_TABLE Of 'cl_dbc_table.prg'

            If ._Saved Then
               lnTable_Count   = .Count
               Exit
            Endif

            Store .Null. To loTable
            Store 0 To I, lnTable_Count
            lnTable_Count   = Adbobjects( laTables,"TABLE" )

            If lnTable_Count > 0
               For I = 1 To lnTable_Count
                  loTable = NewObject('CL_DBC_TABLE', 'cl_dbc_table.prg')
                  loTable.read_BinDataToProperties( laTables(m.I) )
                  *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                  .Add( loTable, Padr(Lower(loTable._Name),128) )
               Endfor
            Endif

            ._Saved     = .T.
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         loTable = .Null.
         Release I, loTable

      Endtry

      Return lnTable_Count
   Endproc


Enddefine
