#INCLUDE foxbin2prg.h

Define Class CL_DBC_FIELD_DB As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #If .F.
      Local This As CL_DBC_FIELD_DB Of 'cl_dbc_field_db.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_caption" display="_Caption"/>] ;
      + [<memberdata name="_comment" display="_Comment"/>] ;
      + [<memberdata name="_defaultvalue" display="_DefaultValue"/>] ;
      + [<memberdata name="_displayclass" display="_DisplayClass"/>] ;
      + [<memberdata name="_displayclasslibrary" display="_DisplayClassLibrary"/>] ;
      + [<memberdata name="_format" display="_Format"/>] ;
      + [<memberdata name="_inputmask" display="_InputMask"/>] ;
      + [<memberdata name="_ruleexpression" display="_RuleExpression"/>] ;
      + [<memberdata name="_ruletext" display="_RuleText"/>] ;
      + [</VFPData>]


   *-- Info
   _Name                   = ''
   _Caption                = ''
   _Comment                = ''
   _DefaultValue           = ''
   _DisplayClass           = ''
   _DisplayClassLibrary    = ''
   _Format                 = ''
   _InputMask              = ''
   _RuleExpression         = ''
   _RuleText               = ''


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

         If Left(tcLine, Len(C_FIELD_I)) == C_FIELD_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_FIELD_DB Of 'cl_dbc_field_db.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_FIELD_F $ tcLine && Fin
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
      * tcTable                   (v! IN    ) Nombre de la Tabla
      * tcField                   (v! IN    ) Nombre del campo
      *---------------------------------------------------------------------------------------------------
      Lparameters tcTable, tcField

      Try
         Local lcText, loEx As Exception
         lcText  = ''

         With This As CL_DBC_FIELD_DB Of 'cl_dbc_field_db.prg'
            .read_BinDataToProperties(tcTable, tcField)

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)>><FIELD>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Name><<._Name>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Caption><<._Caption>></Caption>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><DefaultValue><<._DefaultValue>></DefaultValue>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><DisplayClass><<._DisplayClass>></DisplayClass>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><DisplayClassLibrary><<._DisplayClassLibrary>></DisplayClassLibrary>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Format><<._Format>></Format>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><InputMask><<._InputMask>></InputMask>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><RuleExpression><<._RuleExpression>></RuleExpression>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><RuleText><<._RuleText>></RuleText>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)>></FIELD>
            ENDTEXT

            ._ToText    = lcText
         Endwith


      Catch To loEx
         loEx.UserValue  = loEx.UserValue + CR_LF + "tcTable = " + Rtrim(Transform(tcTable)) + ", tcField = " + Rtrim(Transform(tcField))

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

      With This As CL_DBC_FIELD_DB Of 'cl_dbc_field_db.prg'
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DefaultValue, .getDBCPropertyIDByName('DefaultValue', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DisplayClass, .getDBCPropertyIDByName('DisplayClass', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DisplayClassLibrary, .getDBCPropertyIDByName('DisplayClassLibrary', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Caption, .getDBCPropertyIDByName('Caption', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Format, .getDBCPropertyIDByName('Format', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._InputMask, .getDBCPropertyIDByName('InputMask', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleExpression, .getDBCPropertyIDByName('RuleExpression', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleText, .getDBCPropertyIDByName('RuleText', .T.) )
      Endwith && THIS

      Return lcBinData
   Endproc


   Procedure read_BinDataToProperties
      Lparameters tcTable, tcField
      Local lcFullFieldName

      With This As CL_DBC_FIELD_DB Of 'cl_dbc_field_db.prg'
         If Not ._Saved Then
            ._Name                  = Alltrim(tcField)
            lcFullFieldName         = Rtrim(tcTable) + '.' + Rtrim(tcField)
            ._Caption               = DBGetProp( lcFullFieldName,"FIELD","Caption")
            ._Comment               = DBGetProp( lcFullFieldName,"FIELD","Comment")
            ._DefaultValue          = DBGetProp( lcFullFieldName,"FIELD","DefaultValue")
            ._DisplayClass          = DBGetProp( lcFullFieldName,"FIELD","DisplayClass")
            ._DisplayClassLibrary   = DBGetProp( lcFullFieldName,"FIELD","DisplayClassLibrary")
            ._Format                = DBGetProp( lcFullFieldName,"FIELD","Format")
            ._InputMask             = DBGetProp( lcFullFieldName,"FIELD","InputMask")
            ._RuleExpression        = DBGetProp( lcFullFieldName,"FIELD","RuleExpression")
            ._RuleText              = DBGetProp( lcFullFieldName,"FIELD","RuleText")
            *--
            ._Saved     = .T.
         Endif
      Endwith
   Endproc


Enddefine
