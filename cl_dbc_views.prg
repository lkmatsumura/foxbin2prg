#INCLUDE foxbin2prg.h

Define Class CL_DBC_VIEWS As CL_DBC_COL_BASE Of 'cl_dbc_col_base.prg'
   #If .F.
      Local This As CL_DBC_VIEWS Of 'cl_dbc_views.prg'
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
            , loView As CL_DBC_VIEW Of 'cl_dbc_view.prg'
         Store .Null. To loView
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_VIEWS_I)) == C_VIEWS_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_VIEWS Of 'cl_dbc_views.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_VIEWS_F $ tcLine && Fin
                     Exit

                  Case C_VIEW_I $ tcLine
                     loView = .Null.
                     loView = NewObject('CL_DBC_VIEW', 'cl_dbc_view.prg')
                     loView.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                     .Add( loView, Padr(Lower(loView._Name),128) )

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
         Store .Null. To loView
         Release lcPropName, lcValue, loView

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
         Local lcText, lcDBC, loEx As Exception ;
            , loView As CL_DBC_VIEW Of 'cl_dbc_view.prg'

         With This As CL_DBC_VIEWS Of 'cl_dbc_views.prg'
            Store .Null. To loView
            lcText  = ''
            .read_BinDataToProperties()

            If .Count > 0 Then
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><VIEWS>
               ENDTEXT

               .KeySort    = 2
               For Each loView In This &&FOXOBJECT
                  lcText  = lcText + loView.toText( loView._Name )
               Endfor

               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>></VIEWS>
                        <<>>
               ENDTEXT
            Endif

            ._Saved     = .T.
         Endwith


      Catch To loEx
         If Vartype(loView) = "O" Then
            loEx.UserValue  = loEx.UserValue + CR_LF + "loView._Name = " + Rtrim(loView._Name)
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loView
         Release loView

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
         With This As CL_DBC_VIEWS Of 'cl_dbc_views.prg'
            Local I, lnView_Count, laViews(1), loEx As Exception ;
               , loTable As CL_DBC_TABLE Of 'cl_dbc_table.prg'
            Store .Null. To loTable
            Store 0 To I, tnTable_Count

            If ._Saved Then
               lnView_Count    = .Count
               Exit
            Endif

            *LG lnView_Count    = ADBOBJECTS( laViews, "VIEW" )
            Select Cast(Alltrim(OBJECTNAME) As Varchar(128)) ;
               FROM TABLABIN ;
               WHERE Upper(ObjectType) = 'VIEW' ;
               ORDER By 1 ;
               INTO Array laViews
            lnView_Count    = _Tally

            If lnView_Count > 0
               For I = 1 To lnView_Count
                  loView = NewObject('CL_DBC_VIEW', 'cl_dbc_view.prg')
                  loView.read_BinDataToProperties( laViews(m.I) )
                  *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                  .Add( loView, Padr(Lower(loView._Name),128) )
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
         loView  = .Null.
         Release I, loView

      Endtry

      Return lnView_Count
   Endproc


Enddefine
