#INCLUDE foxbin2prg.h

Define Class CL_DBC_INDEXES_DB As CL_DBC_COL_BASE Of 'cl_dbc_col_base.prg'
   #If .F.
      Local This As CL_DBC_INDEXES_DB Of 'cl_dbc_indexes_db.prg'
   #Endif


   *-- Info
   _Name                   = ''

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
            , loIndex As CL_DBC_INDEX_DB Of 'cl_dbc_index_db.prg'
         Store .Null. To loIndex
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_INDEXES_I)) == C_INDEXES_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_INDEXES_DB Of 'cl_dbc_indexes_db.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_INDEXES_F $ tcLine   && Fin
                     Exit

                  Case C_INDEX_I $ tcLine
                     loIndex = .Null.
                     loIndex = NewObject('CL_DBC_INDEX_DB', 'cl_dbc_index_db.prg')
                     loIndex.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                     .Add( loIndex, Padr(Lower(loIndex._Name),128) )

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
         Store .Null. To loIndex
         Release lcPropName, lcValue, loIndex

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcTable                   (v! IN    ) Nombre de la Tabla
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tcTable, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcText, loEx As Exception ;
            , loIndex As CL_DBC_INDEX_DB Of 'cl_dbc_index_db.prg'

         With This As CL_DBC_INDEXES_DB Of 'cl_dbc_indexes_db.prg'
            Store .Null. To loIndex
            lcText  = ''
            .read_BinDataToProperties(tcTable, @toFoxBin2Prg)

            If .Count > 0 Then
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>><<C_INDEXES_I>>
               ENDTEXT

               .KeySort = 2    && Comentar para forzar modo LEGACY
               For Each loIndex In This &&FOXOBJECT
                  lcText  = lcText + loIndex.toText( tcTable + '.' + loIndex._Name )
               Endfor

               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>><<C_INDEXES_F>>
               ENDTEXT
            Endif

         Endwith

      Catch To loEx
         If Vartype(loIndex) = "O" Then
            loEx.UserValue  = loEx.UserValue + CR_LF + "loIndex._Name = " + Rtrim(loIndex._Name)
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loIndex
         Release loIndex

      Endtry

      Return lcText
   Endproc


   Procedure read_BinDataToProperties
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcTable                   (v! IN    ) Nombre de la Tabla
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tcTable, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         With This As CL_DBC_FIELDS_DB Of 'cl_dbc_fields_db.prg'
            Local I, lnIndex_Count, laIndexes(1), loEx As Exception ;
               , loIndex As CL_DBC_INDEX_DB Of 'cl_dbc_index_db.prg'

            If ._Saved Then
               lnIndex_Count   = .Count
               Exit
            Endif

            Store .Null. To loIndex
            Store 0 To I, lnIndex_Count
            _Tally  = 0
            Select Lower(TB.OBJECTNAME) From TABLABIN TB ;
               INNER Join TABLABIN TB2 On Str(TB.ParentId)+TB.ObjectType = Str(TB2.ObjectID)+Padr('Index',10) ;
               AND Lower(TB2.OBJECTNAME) = Padr(Lower(tcTable),128) ;
               INTO Array laIndexes
            lnIndex_Count   = _Tally

            If lnIndex_Count > 0
               For I = 1 To lnIndex_Count
                  loIndex = NewObject('CL_DBC_INDEX_DB', 'cl_dbc_index_db.prg')
                  loIndex.read_BinDataToProperties( tcTable + '.' + laIndexes(m.I) )
                  *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                  .Add( loIndex, Padr(Lower(loIndex._Name),128) )
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
         Use In (Select("TB"))
         Use In (Select("TB2"))
         loIndex = .Null.
         Release I, loIndex

      Endtry

      Return lnIndex_Count
   Endproc


Enddefine
