#INCLUDE foxbin2prg.h

Define Class CL_DBC_RELATIONS As CL_DBC_COL_BASE Of 'cl_dbc_col_base.prg'
   #If .F.
      Local This As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'
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
            , loRelation As CL_DBC_RELATION Of 'cl_dbc_relation.prg'
         Store .Null. To loRelation
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_RELATIONS_I)) == C_RELATIONS_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_RELATIONS_F $ tcLine && Fin
                     Exit

                  Case C_RELATION_I $ tcLine
                     loRelation = .Null.
                     loRelation = NewObject('CL_DBC_RELATION', 'cl_dbc_relation.prg')
                     loRelation.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                     Try
                        *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                        .Add( loRelation, Padr(Lower(loRelation._Name),128) )
                     Catch To loEx When loEx.ErrorNo = 2062  && The specified Key already exists.
                        *-- Saltear este error, porque implica que la relación está duplicada
                     Endtry

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
         Store .Null. To loRelation
         Release lcPropName, lcValue, loRelation

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcTable                   (v! IN    ) Tabla de la que obtener las relaciones
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tcTable, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         With This As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'
            Local lcText, loEx As Exception ;
               , loRelation As CL_DBC_RELATION Of 'cl_dbc_relation.prg'
            Store .Null. To loRelation
            lcText  = ''
            .read_BinDataToProperties(tcTable, @toFoxBin2Prg)

            If .Count > 0 Then
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>><RELATIONS>
               ENDTEXT

               .KeySort=2  && Comentar para forzar modo LEGACY
               For Each loRelation In This &&FOXOBJECT
                  lcText  = lcText + loRelation.toText()
               Endfor

               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>></RELATIONS>
                        <<>>
               ENDTEXT
            Endif
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loRelation
         Release I, X, loRelation

      Endtry

      Return lcText
   Endproc


   Procedure read_BinDataToProperties
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcTable                   (v! IN    ) Tabla de la que obtener las relaciones
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tcTable, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         With This As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'
            Local I, lnRelation_Count, laRelations(1,5), lcText, loEx As Exception ;
               , loRelation As CL_DBC_RELATION Of 'cl_dbc_relation.prg'

            Store .Null. To loRelation
            lcText  = ''
            I       = 0

            lnRelation_Count    = Adbobjects( laRelations, "RELATION" )

            If lnRelation_Count > 0
               *-- Ordenamiento: Comentar los ASORT para el orden original
               Asort( laRelations, 3, -1, 0, 1 )
               Asort( laRelations, 1, -1, 0, 1 )
               Asort( laRelations, 4, -1, 0, 1 )
               Asort( laRelations, 2, -1, 0, 1 )

               For I = 1 To lnRelation_Count
                  If laRelations(m.I,1) == Upper( Rtrim( tcTable ) )
                     loRelation  = NewObject('CL_DBC_RELATION', 'cl_dbc_relation.prg')
                     loRelation.read_BinDataToProperties( @laRelations, m.I )
                     Try
                        .Add( loRelation, Padr(Lower(loRelation._Name),128) )
                     Catch To loEx When loEx.ErrorNo = 2062  && The specified Key already exists.
                        *-- Saltear este error, porque implica que la relación está duplicada
                     Endtry
                  Endif
               Endfor

            Endif

         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loRelation
         Release loRelation

      Endtry

      Return lcText
   Endproc


Enddefine
