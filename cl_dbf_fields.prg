#INCLUDE foxbin2prg.h

Define Class CL_DBF_FIELDS As CL_COL_BASE Of 'cl_col_base.prg'
   #If .F.
      Local This As CL_DBF_FIELDS Of 'cl_dbf_fields.prg'
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
            , loField As CL_DBF_FIELD Of 'cl_dbf_field.prg' ;
            , loIndex As CL_DBF_INDEX Of 'cl_dbf_index.prg'
         Store .Null. To loIndex, loField
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_FIELDS_I)) == C_FIELDS_I
            llBloqueEncontrado  = .T.

            With This As CL_DBF_FIELDS Of 'cl_dbf_fields.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_FIELDS_F $ tcLine    && Fin
                     Exit

                  Case C_FIELD_I $ tcLine
                     loField = .Null.
                     loField = NewObject('CL_DBF_FIELD', 'cl_dbf_field.prg')
                     loField.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     .Add( loField, loField._Name )

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
         Store .Null. To loIndex, loField
         Release lcPropName, lcValue, loField, loIndex

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taFields                  (@?    OUT) Array de información de campos
      * tnField_Count             (@?    OUT) Cantidad de campos
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters taFields, tnField_Count, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      External Array taFields

      Try
         Local I, lcText, loEx As Exception ;
            , loField As CL_DBF_FIELD Of 'cl_dbf_field.prg'
         Store .Null. To loField
         lcText  = ''
         Dimension taFields(1,18)

         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<>>
                <<Chr(9)>><<C_FIELDS_I>>
         ENDTEXT

         tnField_Count   = Afields(taFields)
         loField         = NewObject('CL_DBF_FIELD', 'cl_dbf_field.prg')

         For I = 1 To tnField_Count
            If taFields(m.I,17) > 0 And toFoxBin2Prg.getCfgValue('n_ExcludeDBFAutoincNextval') = 1
               *-- If AutoIncNextVal is excluded from text, then assign 1 for allowing regeneration
               *-- of DBF with this field.
               taFields(m.I,17)    = 1
            Endif

            lcText  = lcText + loField.toText( @taFields, m.I )
         Endfor

         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>><<C_FIELDS_F>>
                <<>>
         ENDTEXT


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loField
         Release I, loField

      Endtry

      Return lcText
   Endproc


Enddefine
