#INCLUDE foxbin2prg.h

Define Class CL_DBF_FIELD As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_DBF_FIELD Of 'cl_dbf_field.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_type" display="_Type"/>] ;
      + [<memberdata name="_width" display="_Width"/>] ;
      + [<memberdata name="_decimals" display="_Decimals"/>] ;
      + [<memberdata name="_null" display="_Null"/>] ;
      + [<memberdata name="_nocptran" display="_NoCPTran"/>] ;
      + [<memberdata name="_field_valid_exp" display="_Field_Valid_Exp"/>] ;
      + [<memberdata name="_field_valid_text" display="_Field_Valid_Text"/>] ;
      + [<memberdata name="_field_default_value" display="_Field_Default_Value"/>] ;
      + [<memberdata name="_table_valid_exp" display="_Table_Valid_Exp"/>] ;
      + [<memberdata name="_table_valid_text" display="_Table_Valid_Text"/>] ;
      + [<memberdata name="_longtablename" display="_LongTableName"/>] ;
      + [<memberdata name="_ins_trig_exp" display="_Ins_Trig_Exp"/>] ;
      + [<memberdata name="_upd_trig_exp" display="_Upd_Trig_Exp"/>] ;
      + [<memberdata name="_del_trig_exp" display="_Del_Trig_Exp"/>] ;
      + [<memberdata name="_tablecomment" display="_TableComment"/>] ;
      + [<memberdata name="_autoinc_nextval" display="_AutoInc_NextVal"/>] ;
      + [<memberdata name="_autoinc_step" display="_AutoInc_Step"/>] ;
      + [</VFPData>]


   *-- Field Info
   _Name                   = ''    &&  1
   _Type                   = ''    &&  2
   _Width                  = 0     &&  3
   _Decimals               = 0     &&  4
   _Null                   = .F.   &&  5
   _NoCPTran               = .F.   &&  6
   _Field_Valid_Exp        = ''    &&  7   - DBC
   _Field_Valid_Text       = ''    &&  8   - DBC
   _Field_Default_Value    = ''    &&  9   - DBC
   _Table_Valid_Exp        = ''    && 10   - DBC
   _Table_Valid_Text       = ''    && 11   - DBC
   _LongTableName          = ''    && 12   - DBC
   _Ins_Trig_Exp           = ''    && 13   - DBC
   _Upd_Trig_Exp           = ''    && 14   - DBC
   _Del_Trig_Exp           = ''    && 15   - DBC
   _TableComment           = ''    && 16   - DBC
   _AutoInc_NextVal        = 0     && 17
   _AutoInc_Step           = 0     && 18



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

            With This As CL_DBF_FIELD Of 'cl_dbf_field.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_FIELD_F $ tcLine && Fin
                     Exit

                  Otherwise   && Propiedad de FIELD
                     *-- Estructura a reconocer:
                     *   <name>NOMBRE</name>
                     lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                     lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                     .AddProperty( '_' + lcPropName, lcValue )
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
      * taFields                  (!@ IN    ) Array de información de campos
      * I                         (!@ IN    ) Campo en evaluación
      *---------------------------------------------------------------------------------------------------
      Lparameters taFields, I

      External Array taFields

      Try
         Local lcText, loEx As Exception
         lcText  = ''

         TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<chr(9)+chr(9)>><<C_FIELD_I>>
                <<chr(9)+chr(9)+chr(9)>><Name><<taFields(m.I,1)>></Name>
                <<chr(9)+chr(9)+chr(9)>><Type><<taFields(m.I,2)>></Type>
                <<chr(9)+chr(9)+chr(9)>><Width><<taFields(m.I,3)>></Width>
                <<chr(9)+chr(9)+chr(9)>><Decimals><<taFields(m.I,4)>></Decimals>
                <<chr(9)+chr(9)+chr(9)>><Null><<taFields(m.I,5)>></Null>
                <<chr(9)+chr(9)+chr(9)>><NoCPTran><<taFields(m.I,6)>></NoCPTran>
                <<chr(9)+chr(9)+chr(9)>><Field_Valid_Exp><<taFields(m.I,7)>></Field_Valid_Exp>
                <<chr(9)+chr(9)+chr(9)>><Field_Valid_Text><<taFields(m.I,8)>></Field_Valid_Text>
                <<chr(9)+chr(9)+chr(9)>><Field_Default_Value><<taFields(m.I,9)>></Field_Default_Value>
                <<chr(9)+chr(9)+chr(9)>><Table_Valid_Exp><<taFields(m.I,10)>></Table_Valid_Exp>
                <<chr(9)+chr(9)+chr(9)>><Table_Valid_Text><<taFields(m.I,11)>></Table_Valid_Text>
                <<chr(9)+chr(9)+chr(9)>><LongTableName><<taFields(m.I,12)>></LongTableName>
                <<chr(9)+chr(9)+chr(9)>><Ins_Trig_Exp><<taFields(m.I,13)>></Ins_Trig_Exp>
                <<chr(9)+chr(9)+chr(9)>><Upd_Trig_Exp><<taFields(m.I,14)>></Upd_Trig_Exp>
                <<chr(9)+chr(9)+chr(9)>><Del_Trig_Exp><<taFields(m.I,15)>></Del_Trig_Exp>
                <<chr(9)+chr(9)+chr(9)>><TableComment><<taFields(m.I,16)>></TableComment>
                <<chr(9)+chr(9)+chr(9)>><Autoinc_Nextval><<taFields(m.I,17)>></Autoinc_Nextval>
                <<chr(9)+chr(9)+chr(9)>><Autoinc_Step><<taFields(m.I,18)>></Autoinc_Step>
                <<chr(9)+chr(9)>><<C_FIELD_F>>
         ENDTEXT


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcText
   Endproc


Enddefine
