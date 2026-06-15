#INCLUDE foxbin2prg.h

Define Class CL_DBC_FIELDS_VW As CL_DBC_COL_BASE Of 'cl_dbc_col_base.prg'
   #If .F.
      Local This As CL_DBC_FIELDS_VW Of 'cl_dbc_fields_vw.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzeordercodeblock" display="analyzeOrderCodeBlock"/>] ;
      + [<memberdata name="a_campos" display="a_Campos"/>] ;
      + [<memberdata name="n_campos" display="n_Campos"/>] ;
      + [</VFPData>]

   Dimension a_Campos(1,2) && col.1=campo, col.2=definición
   n_Campos        = 0


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
            , loField As CL_DBC_FIELD_VW Of 'cl_dbc_field_vw.prg'
         Store .Null. To loField
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_FIELDS_I)) == C_FIELDS_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_FIELDS_VW Of 'cl_dbc_fields_vw.prg'
               *.n_Campos = 0  && Descomentar para forzar modo LEGACY
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_FIELDS_F $ tcLine    && Fin
                     Exit

                  Case C_FIELD_I $ tcLine
                     loField = .Null.
                     loField = NewObject('CL_DBC_FIELD_VW', 'cl_dbc_field_vw.prg')
                     loField.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                     If .n_Campos = 0 Then
                        *-- MODO LEGACY: Cuando no existe tag de ordenamiento de campos, se agregan en el orden que se leen
                        *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                        .Add( loField, Padr(Lower(loField._Name),128) )
                     Else
                        lnPos   = Ascan( .a_Campos, loField._Name, 1, 0, 1, 1+2+4+8 )
                        .a_Campos( lnPos, 2)    = loField
                     Endif

                  Otherwise   && Otro valor
                     *-- No hay otros valores
                  Endcase
               Endfor

               *-- Restablezco el orden de los campos (Solo si n_Campos > 0, que significa que tiene el nuevo tag especial de orden)
               For lnPos = 1 To .n_Campos
                  *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                  .Add( .a_Campos( lnPos, 2), Padr(Lower(.a_Campos( lnPos, 1)),128) )
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
         Store .Null. To loField
         Release lcPropName, lcValue, loField

      Endtry

      Return llBloqueEncontrado
   Endproc



   Procedure analyzeOrderCodeBlock
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
            , loField As CL_DBC_FIELD_DB Of 'cl_dbc_field_db.prg'
         Store .Null. To loField
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_FIELD_ORDER_I)) == C_FIELD_ORDER_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_FIELDS_VW Of 'cl_dbc_fields_vw.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_FIELD_ORDER_F $ tcLine   && Fin
                     Exit

                  Otherwise   && nombre del campo en el orden original
                     .n_Campos   = .n_Campos + 1
                     Dimension .a_Campos(.n_Campos, 2)
                     .a_Campos(.n_Campos, 1) = tcLine

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
         Store .Null. To loField
         Release lcPropName, lcValue, loField

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcView                    (v! IN    ) Nombre de la Vista
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tcView, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcText, loEx As Exception ;
            , loField As CL_DBC_FIELD_VW Of 'cl_dbc_field_vw.prg'
         Store .Null. To loField
         lcText  = ''

         With This As CL_DBC_FIELDS_VW Of 'cl_dbc_fields_vw.prg'
            .read_BinDataToProperties(tcView, @toFoxBin2Prg)

            If .Count > 0 Then
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>><FIELD_ORDER>
                        <<>>
               ENDTEXT

               Set Textmerge To Memvar lcText Additive Noshow
               Set Textmerge On

               .KeySort = 0
               For Each loField In This &&FOXOBJECT
                        \<<chr(9)+chr(9)+chr(9)+chr(9)>><<loField._Name>>
               Endfor

               Set Textmerge Off
               Set Textmerge To

               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>></FIELD_ORDER>
                        <<>>
                        <<chr(9)+chr(9)+chr(9)>><FIELDS>
               ENDTEXT

               .KeySort = 2    && Comentar para forzar modo LEGACY
               For Each loField In This &&FOXOBJECT
                  lcText  = lcText + loField.toText( tcView, loField._Name )
               Endfor

               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>></FIELDS>
               ENDTEXT
            Endif
         Endwith


      Catch To loEx
         If Vartype(loField) = "O" Then
            loEx.UserValue  = loEx.UserValue + CR_LF + "loField._Name = " + Rtrim(loField._Name)
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loField
         Release loField

      Endtry

      Return lcText
   Endproc


   Procedure read_BinDataToProperties
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcView                    (@! IN    ) Nombre de la vista de la que se obtendrán los campos
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tcView, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, lcText, lnField_Count, laFields(1), loEx As Exception ;
            , loField As CL_DBC_FIELD_VW Of 'cl_dbc_field_vw.prg'
         Store .Null. To loField
         Store 0 To I, lnField_Count
         lcText  = ''

         With This As CL_DBC_FIELDS_VW Of 'cl_dbc_fields_vw.prg'
            If ._Saved Then
               lnField_Count   = .Count
               Exit
            Endif

            _Tally  = 0
            Select Lower(TB.OBJECTNAME) From TABLABIN TB ;
               INNER Join TABLABIN TB2 On Str(TB.ParentId)+TB.ObjectType = Str(TB2.ObjectID)+Padr('Field',10) ;
               AND Lower(TB2.OBJECTNAME) = Padr(Lower(tcView),128) ;
               INTO Array laFields
            lnField_Count   = _Tally

            If lnField_Count > 0
               For I = 1 To lnField_Count
                  loField = NewObject('CL_DBC_FIELD_VW', 'cl_dbc_field_vw.prg')
                  loField.read_BinDataToProperties( tcView, laFields(m.I) )
                  *-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                  .Add( loField, Padr(Lower(loField._Name),128) )
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
         loField = .Null.
         Release loField

      Endtry

      Return lnField_Count
   Endproc


Enddefine
