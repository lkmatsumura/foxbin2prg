#INCLUDE foxbin2prg.h

Define Class CL_DBC_INDEX_DB As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #If .F.
      Local This As CL_DBC_INDEX_DB Of 'cl_dbc_index_db.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_isunique" display="_IsUnique"/>] ;
      + [<memberdata name="_comment" display="_Comment"/>] ;
      + [</VFPData>]


   *-- Info
   _Name                   = ''
   _IsUnique               = .F.
   _Comment                = ''


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

         If Left(tcLine, Len(C_INDEX_I)) == C_INDEX_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_INDEX_DB Of 'cl_dbc_index_db.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_INDEX_F $ tcLine && Fin
                     Exit

                  Case '<Comment>' $ tcLine
                     .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Otherwise   && Propiedad de FIELD
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
      * tcIndex                   (v! IN    ) Nombre del índice en la forma "tabla.indice"
      *---------------------------------------------------------------------------------------------------
      Lparameters tcIndex

      Try
         Local lcText, loEx As Exception
         lcText  = ''

         With This As CL_DBC_INDEX_DB Of 'cl_dbc_index_db.prg'
            .read_BinDataToProperties(tcIndex)

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)>><<C_INDEX_I>>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Name><<._Name>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><IsUnique><<._IsUnique>></IsUnique>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)>><<C_INDEX_F>>
            ENDTEXT

            ._ToText    = lcText
         Endwith && THIS

      Catch To loEx
         loEx.UserValue  = loEx.UserValue + CR_LF + "tcIndex = " + Rtrim(Transform(tcIndex))

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcText
   Endproc


   Procedure getBinMemoFromProperties
      Local lcBinData
      lcBinData   = ''

      With This As CL_DBC_INDEX_DB Of 'cl_dbc_index_db.prg'
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._IsUnique, .getDBCPropertyIDByName('IsUnique', .T.) )
      Endwith && THIS

      Return lcBinData
   Endproc


   Procedure read_BinDataToProperties
      Lparameters tcIndex

      With This As CL_DBC_INDEX_DB Of 'cl_dbc_index_db.prg'
         If Not ._Saved Then
            ._Name                  = Alltrim(Justext(tcIndex))
            ._Comment               = Rtrim( .DBGetProp(tcIndex,'Index','Comment') )
            ._IsUnique              = .DBGetProp(tcIndex,'Index','IsUnique')
            *--
            ._Saved     = .T.
         Endif
      Endwith
   Endproc


Enddefine
