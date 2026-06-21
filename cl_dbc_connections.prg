#INCLUDE foxbin2prg.h

Define Class CL_DBC_CONNECTIONS As CL_DBC_COL_BASE Of 'cl_dbc_col_base.prg'
   #If .F.
      Local This As CL_DBC_CONNECTIONS Of 'cl_dbc_connections.prg'
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
            , loConnection As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg'
         Store .Null. To loConnection
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_CONNECTIONS_I)) == C_CONNECTIONS_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_CONNECTIONS Of 'cl_dbc_connections.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_CONNECTIONS_F $ tcLine   && Fin
                     Exit

                  Case C_CONNECTION_I $ tcLine
                     loConnection = NewObject('CL_DBC_CONNECTION', 'cl_dbc_connection.prg')
                     loConnection.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                     .Add( loConnection, Padr(loConnection._Name,128) )

                  Case '<Comment>' $ tcLine
                     .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

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
         Store .Null. To loConnection
         Release lcPropName, lcValue, loConnection

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
            , loConnection As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg'

         With This As CL_DBC_CONNECTIONS Of 'cl_dbc_connections.prg'
            loConnection        = .Null.
            lcText              = ''
            .read_BinDataToProperties()

            If .Count > 0 Then

               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><CONNECTIONS>
               ENDTEXT

               .KeySort = 2
               For Each loConnection In This &&FOXOBJECT
                  lcText          = lcText + loConnection.toText( loConnection._Name )
               Endfor

               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>></CONNECTIONS>
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
         loConnection    = .Null.
         Release loConnection

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
         With This As CL_DBC_CONNECTIONS Of 'cl_dbc_connections.prg'
            Local I, lnConnection_Count, laConnections(1), loEx As Exception ;
               , loConnection As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg'

            If ._Saved Then
               lnConnection_Count  = .Count
               Exit
            Endif

            loConnection        = .Null.
            lnConnection_Count  = Adbobjects( laConnections,"CONNECTION" )

            If lnConnection_Count > 0
               For I = 1 To lnConnection_Count
                  loConnection    = NewObject('CL_DBC_CONNECTION', 'cl_dbc_connection.prg')
                  loConnection.read_BinDataToProperties( laConnections(m.I) )
                  *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                  .Add( loConnection, Padr(Lower(loConnection._Name),128) )
               Endfor
            Endif
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         loConnection    = .Null.
         Release I, loConnection

      Endtry

      Return lnConnection_Count
   Endproc


Enddefine
