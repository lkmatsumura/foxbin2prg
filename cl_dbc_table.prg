#INCLUDE foxbin2prg.h

Define Class CL_DBC_TABLE As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #If .F.
      Local This As CL_DBC_TABLE Of 'cl_dbc_table.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_comment" display="_Comment"/>] ;
      + [<memberdata name="_path" display="_Path"/>] ;
      + [<memberdata name="_deletetrigger" display="_DeleteTrigger"/>] ;
      + [<memberdata name="_inserttrigger" display="_InsertTrigger"/>] ;
      + [<memberdata name="_updatetrigger" display="_UpdateTrigger"/>] ;
      + [<memberdata name="_primarykey" display="_PrimaryKey"/>] ;
      + [<memberdata name="_ruleexpression" display="_RuleExpression"/>] ;
      + [<memberdata name="_ruletext" display="_RuleText"/>] ;
      + [<memberdata name="_fields" display="_Fields"/>] ;
      + [<memberdata name="_indexes" display="_Indexes"/>] ;
      + [</VFPData>]


   *-- Info
   _Name                   = ''
   _Comment                = ''
   _Path                   = ''
   _DeleteTrigger          = ''
   _InsertTrigger          = ''
   _UpdateTrigger          = ''
   _PrimaryKey             = ''
   _RuleExpression         = ''
   _RuleText               = ''


   Procedure Init
      DoDefault()
      *--
      With This As CL_DBC_TABLE Of 'cl_dbc_table.prg'
         .NewObject("_Fields", "CL_DBC_FIELDS_DB", "cl_dbc_fields_db.prg")
         .NewObject("_Indexes", "CL_DBC_INDEXES_DB", "cl_dbc_indexes_db.prg")
         .NewObject("_Relations", "CL_DBC_RELATIONS", "cl_dbc_relations.prg")
      Endwith && THIS
   Endproc


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
            , loFields As CL_DBC_FIELDS_DB Of 'cl_dbc_fields_db.prg' ;
            , loIndexes As CL_DBC_INDEXES_DB Of 'cl_dbc_indexes_db.prg' ;
            , loRelations As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'
         Store .Null. To loRelations, loIndexes, loFields
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_TABLE_I)) == C_TABLE_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_TABLE Of 'cl_dbc_table.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_TABLE_F $ tcLine && Fin
                     Exit

                  Case C_FIELD_ORDER_I $ tcLine
                     loFields = ._Fields
                     loFields.analyzeOrderCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Case C_FIELDS_I $ tcLine
                     loFields = ._Fields
                     loFields.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Case C_INDEXES_I $ tcLine
                     loIndexes = ._Indexes
                     loIndexes.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Case C_RELATIONS_I $ tcLine
                     loRelations = ._Relations
                     loRelations.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Case '<Comment>' $ tcLine
                     .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Otherwise   && Propiedad de TABLE
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

      Finally
         Store .Null. To loRelations, loIndexes, loFields
         Release lcPropName, lcValue, loFields, loIndexes, loRelations

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcTable                   (v! IN    ) Nombre de la Tabla
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tcTable, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcText, lcFields, lcIndexes, lcRelations, loEx As Exception ;
            , loIndexes As CL_DBC_INDEXES_DB Of 'cl_dbc_indexes_db.prg' ;
            , loFields As CL_DBC_FIELDS_DB Of 'cl_dbc_fields_db.prg' ;
            , loRelations As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'

         With This As CL_DBC_TABLE Of 'cl_dbc_table.prg'
            Store .Null. To loRelations, loFields, loIndexes
            Store '' To lcText, lcFields, lcIndexes, lcRelations
            .read_BinDataToProperties(tcTable)

            loFields    = NewObject('CL_DBC_FIELDS_DB', 'cl_dbc_fields_db.prg')
            lcFields    = loFields.toText( tcTable, @toFoxBin2Prg )

            loIndexes   = NewObject('CL_DBC_INDEXES_DB', 'cl_dbc_indexes_db.prg')
            lcIndexes   = loIndexes.toText( tcTable, @toFoxBin2Prg )

            loRelations = NewObject('CL_DBC_RELATIONS', 'cl_dbc_relations.prg')
            lcRelations = loRelations.toText( tcTable, @toFoxBin2Prg )

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<>>
                    <<Chr(9)+Chr(9)>><TABLE>
                    <<Chr(9)+Chr(9)+Chr(9)>><Name><<._Name>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)>><Path><<._Path>></Path>
                    <<Chr(9)+Chr(9)+Chr(9)>><DeleteTrigger><<._DeleteTrigger>></DeleteTrigger>
                    <<Chr(9)+Chr(9)+Chr(9)>><InsertTrigger><<._InsertTrigger>></InsertTrigger>
                    <<Chr(9)+Chr(9)+Chr(9)>><UpdateTrigger><<._UpdateTrigger>></UpdateTrigger>
                    <<Chr(9)+Chr(9)+Chr(9)>><PrimaryKey><<._PrimaryKey>></PrimaryKey>
                    <<Chr(9)+Chr(9)+Chr(9)>><RuleExpression><<._RuleExpression>></RuleExpression>
                    <<Chr(9)+Chr(9)+Chr(9)>><RuleText><<._RuleText>></RuleText>
                    <<lcFields>>
                    <<lcIndexes>>
                    <<lcRelations>>
                    <<Chr(9)+Chr(9)>></TABLE>
            ENDTEXT

            ._ToText    = lcText
         Endwith


      Catch To loEx
         loEx.UserValue  = loEx.UserValue + CR_LF + "tcTable = " + Rtrim(Transform(tcTable))

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loRelations, loFields, loIndexes
         Release loIndexes, loFields, loRelations

      Endtry

      Return lcText
   Endproc


   Procedure updateDBC
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_OutputFile             (v! IN    ) Nombre del archivo de salida
      * tnLastID                  (!@ IN    ) Último número de ID usado
      * tnParentID                (v! IN    ) ID del objeto Padre
      *---------------------------------------------------------------------------------------------------
      Lparameters tc_OutputFile, tnLastID, tnParentID

      DoDefault( tc_OutputFile, @tnLastID, tnParentID)

      With This As CL_DBC_TABLE Of 'cl_dbc_table.prg'
         tnParentID  = .__ObjectID
         ._Fields.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
         ._Indexes.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
         ._Relations.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
      Endwith && THIS
   Endproc


   Procedure getBinMemoFromProperties
      Local lcBinData
      lcBinData   = ''

      With This As CL_DBC_TABLE Of 'cl_dbc_table.prg'
         lcBinData   = lcBinData + .getBinPropertyDataRecord( 1, .getDBCPropertyIDByName('Class', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Path, .getDBCPropertyIDByName('Path', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._PrimaryKey, .getDBCPropertyIDByName('PrimaryKey', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleExpression, .getDBCPropertyIDByName('RuleExpression', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleText, .getDBCPropertyIDByName('RuleText', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._InsertTrigger, .getDBCPropertyIDByName('InsertTrigger', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UpdateTrigger, .getDBCPropertyIDByName('UpdateTrigger', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DeleteTrigger, .getDBCPropertyIDByName('DeleteTrigger', .T.) )
      Endwith && THIS

      Return lcBinData
   Endproc


   Procedure read_BinDataToProperties
      Lparameters tcTable

      With This As CL_DBC_TABLE Of 'cl_dbc_table.prg'
         If Not ._Saved Then
            ._Name                  = Alltrim(tcTable)
            ._Comment               = DBGetProp(tcTable,"TABLE","Comment")
            ._Path                  = DBGetProp(tcTable,"TABLE","Path")
            ._DeleteTrigger         = DBGetProp(tcTable,"TABLE","DeleteTrigger")
            ._InsertTrigger         = DBGetProp(tcTable,"TABLE","InsertTrigger")
            ._UpdateTrigger         = DBGetProp(tcTable,"TABLE","UpdateTrigger")
            ._PrimaryKey            = DBGetProp(tcTable,"TABLE","PrimaryKey")
            ._RuleExpression        = DBGetProp(tcTable,"TABLE","RuleExpression")
            ._RuleText              = DBGetProp(tcTable,"TABLE","RuleText")
            *--
            ._Saved     = .T.
         Endif
      Endwith
   Endproc


Enddefine
