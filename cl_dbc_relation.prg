#INCLUDE foxbin2prg.h

Define Class CL_DBC_RELATION As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #If .F.
      Local This As CL_DBC_RELATION Of 'cl_dbc_relation.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_childtable" display="_ChildTable"/>] ;
      + [<memberdata name="_parenttable" display="_ParentTable"/>] ;
      + [<memberdata name="_childindex" display="_ChildIndex"/>] ;
      + [<memberdata name="_parentindex" display="_ParentIndex"/>] ;
      + [<memberdata name="_refintegrity" display="_RefIntegrity"/>] ;
      + [</VFPData>]


   *-- Info
   _ChildTable     = ''
   _ParentTable    = ''
   _ChildIndex     = ''
   _ParentIndex    = ''
   _RefIntegrity   = ''



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
         Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_RELATION_I)) == C_RELATION_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_RELATION Of 'cl_dbc_relation.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_RELATION_F $ tcLine  && Fin
                     Exit

                  Otherwise   && Propiedad de RELATION
                     *-- Estructura a reconocer:
                     *   <name>NOMBRE</name>
                     lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                     lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                     .add_Property( '_' + lcPropName, lcValue )
                  Endcase
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx
         If loEx.ErrorNo = 1470  && Incorrect property name.
            loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine) + ', PropName=[' + Transform(lcPropName) + '], Value=[' + Transform(lcValue) + ']'
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taRelations               (!@ IN    ) Array de relaciones
      * X                         (!@ IN    ) Número de relación evaluado
      *---------------------------------------------------------------------------------------------------
      Lparameters taRelations, X

      External Array taRelations

      Try
         With This As CL_DBC_RELATION Of 'cl_dbc_relation.prg'
            Local lcText, loEx As Exception
            lcText  = ''
            .read_BinDataToProperties(@taRelations, m.X)

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<chr(9)+chr(9)+chr(9)+chr(9)>><RELATION>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Name><<._Name>></Name>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><ChildTable><<._ChildTable>></ChildTable>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><ParentTable><<._ParentTable>></ParentTable>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><ChildIndex><<._ChildIndex>></ChildIndex>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><ParentIndex><<._ParentIndex>></ParentIndex>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><RefIntegrity><<._RefIntegrity>></RefIntegrity>
                    <<chr(9)+chr(9)+chr(9)+chr(9)>></RELATION>
            ENDTEXT

            ._ToText    = lcText
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcText
   Endproc


   Procedure getReferentialIntegrityInfo
      Return This._RefIntegrity
   Endproc


   Procedure getBinMemoFromProperties
      Local lcBinData
      lcBinData   = ''

      With This As CL_DBC_RELATION Of 'cl_dbc_relation.prg'
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ChildIndex, .getDBCPropertyIDByName( 'ChildTag', .T. ) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ParentTable, .getDBCPropertyIDByName( 'ParentTable', .T. ) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ParentIndex, .getDBCPropertyIDByName( 'ParentTag', .T. ) )
         *_ChildTable is used to link the name of the related table.
      Endwith && THIS

      Return lcBinData
   Endproc


   Procedure read_BinDataToProperties
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taRelations               (!@ IN    ) Array de relaciones
      * I                         (!@ IN    ) Número de relación evaluado
      *---------------------------------------------------------------------------------------------------
      Lparameters taRelations, I

      External Array taRelations

      With This As CL_DBC_RELATION Of 'cl_dbc_relation.prg'
         If Not ._Saved Then
            ._Name                  = 'Relation ' + Transform(m.I)
            ._ChildTable            = Alltrim(taRelations(m.I,1))
            ._ParentTable           = Alltrim(taRelations(m.I,2))
            ._ChildIndex            = Alltrim(taRelations(m.I,3))
            ._ParentIndex           = Alltrim(taRelations(m.I,4))
            ._RefIntegrity          = Alltrim(taRelations(m.I,5))
            *--
            ._Saved     = .T.
         Endif
      Endwith
   Endproc


Enddefine
