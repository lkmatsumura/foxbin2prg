#INCLUDE foxbin2prg.h

Define Class CL_DBC_FIELD_VW As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #If .F.
      Local This As CL_DBC_FIELD_VW Of 'cl_dbc_field_vw.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_caption" display="_Caption"/>] ;
      + [<memberdata name="_comment" display="_Comment"/>] ;
      + [<memberdata name="_datatype" display="_DataType"/>] ;
      + [<memberdata name="_defaultvalue" display="_DefaultValue"/>] ;
      + [<memberdata name="_displayclass" display="_DisplayClass"/>] ;
      + [<memberdata name="_displayclasslibrary" display="_DisplayClassLibrary"/>] ;
      + [<memberdata name="_format" display="_Format"/>] ;
      + [<memberdata name="_inputmask" display="_InputMask"/>] ;
      + [<memberdata name="_keyfield" display="_KeyField"/>] ;
      + [<memberdata name="_ruleexpression" display="_RuleExpression"/>] ;
      + [<memberdata name="_ruletext" display="_RuleText"/>] ;
      + [<memberdata name="_updatable" display="_Updatable"/>] ;
      + [<memberdata name="_updatename" display="_UpdateName"/>] ;
      + [</VFPData>]


   *-- Info
   _Name                   = ''
   _Caption                = ''
   _Comment                = ''
   _DataType               = ''
   _DefaultValue           = ''
   _DisplayClass           = ''
   _DisplayClassLibrary    = ''
   _Format                 = ''
   _InputMask              = ''
   _KeyField               = .F.
   _RuleExpression         = ''
   _RuleText               = ''
   _Updatable              = .F.
   _UpdateName             = ''


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

            With This As CL_DBC_FIELD_VW Of 'cl_dbc_field_vw.prg'
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
      * tcView                    (v! IN    ) Nombre de la Vista
      * tcField                   (v! IN    ) Nombre del campo
      *---------------------------------------------------------------------------------------------------
      Lparameters tcView, tcField

      Try
         With This As CL_DBC_FIELD_VW Of 'cl_dbc_field_vw.prg'
            Local lcText, loEx As Exception
            lcText  = ''

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<chr(9)+chr(9)+chr(9)+chr(9)>><FIELD>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Name><<._Name>></Name>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Caption><<._Caption>></Caption>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Comment><<._Comment>></Comment>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><DataType><<._DataType>></DataType>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><DefaultValue><<._DefaultValue>></DefaultValue>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><DisplayClass><<._DisplayClass>></DisplayClass>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><DisplayClassLibrary><<._DisplayClassLibrary>></DisplayClassLibrary>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Format><<._Format>></Format>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><InputMask><<._InputMask>></InputMask>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><KeyField><<._KeyField>></KeyField>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><RuleExpression><<._RuleExpression>></RuleExpression>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><RuleText><<._RuleText>></RuleText>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Updatable><<._Updatable>></Updatable>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><UpdateName><<._UpdateName>></UpdateName>
                    <<chr(9)+chr(9)+chr(9)+chr(9)>></FIELD>
            ENDTEXT

            ._ToText    = lcText
         Endwith

      Catch To loEx
         loEx.UserValue  = loEx.UserValue + CR_LF + "tcView.tcField = " + Transform(tcView) + '.' + Transform(tcField)

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

      With This As CL_DBC_FIELD_VW Of 'cl_dbc_field_vw.prg'
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DataType, .getDBCPropertyIDByName('DataType', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._KeyField, .getDBCPropertyIDByName('KeyField', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Updatable, .getDBCPropertyIDByName('UpdatableField', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UpdateName, .getDBCPropertyIDByName('UpdateName', .T.) )
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
      Lparameters tcView, tcField

      With This As CL_DBC_FIELD_VW Of 'cl_dbc_field_vw.prg'
         If Not ._Saved Then
            ._Name                  = Alltrim(tcField)
            ._Caption               = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","Caption")
            ._Comment               = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","Comment")
            ._DataType              = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","DataType")
            ._DefaultValue          = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","DefaultValue")
            ._DisplayClass          = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","DisplayClass")
            ._DisplayClassLibrary   = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","DisplayClassLibrary")
            ._Format                = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","Format")
            ._InputMask             = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","InputMask")
            ._KeyField              = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","KeyField")
            ._RuleExpression        = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","RuleExpression")
            ._RuleText              = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","RuleText")
            ._Updatable             = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","Updatable")
            ._UpdateName            = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","UpdateName")
            *--
            ._Saved     = .T.
         Endif
      Endwith
   Endproc


Enddefine
