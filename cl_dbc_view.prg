#INCLUDE foxbin2prg.h

Define Class CL_DBC_VIEW As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #If .F.
      Local This As CL_DBC_VIEW Of 'cl_dbc_view.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_comment" display="_Comment"/>] ;
      + [<memberdata name="_tables" display="_Tables"/>] ;
      + [<memberdata name="_sql" display="_SQL"/>] ;
      + [<memberdata name="_allowsimultaneousfetch" display="_AllowSimultaneousFetch"/>] ;
      + [<memberdata name="_batchupdatecount" display="_BatchUpdateCount"/>] ;
      + [<memberdata name="_comparememo" display="_CompareMemo"/>] ;
      + [<memberdata name="_connectname" display="_ConnectName"/>] ;
      + [<memberdata name="_fetchasneeded" display="_FetchAsNeeded"/>] ;
      + [<memberdata name="_fetchmemo" display="_FetchMemo"/>] ;
      + [<memberdata name="_fetchsize" display="_FetchSize"/>] ;
      + [<memberdata name="_maxrecords" display="_MaxRecords"/>] ;
      + [<memberdata name="_offline" display="_Offline"/>] ;
      + [<memberdata name="_recordcount" display="_RecordCount"/>] ;
      + [<memberdata name="_path" display="_Path"/>] ;
      + [<memberdata name="_parameterlist" display="_ParameterList"/>] ;
      + [<memberdata name="_prepared" display="_Prepared"/>] ;
      + [<memberdata name="_ruleexpression" display="_RuleExpression"/>] ;
      + [<memberdata name="_ruletext" display="_RuleText"/>] ;
      + [<memberdata name="_sendupdates" display="_SendUpdates"/>] ;
      + [<memberdata name="_shareconnection" display="_ShareConnection"/>] ;
      + [<memberdata name="_sourcetype" display="_SourceType"/>] ;
      + [<memberdata name="_updatetype" display="_UpdateType"/>] ;
      + [<memberdata name="_usememosize" display="_UseMemoSize"/>] ;
      + [<memberdata name="_wheretype" display="_WhereType"/>] ;
      + [<memberdata name="_fields" display="_Fields"/>] ;
      + [<memberdata name="_indexes" display="_Indexes"/>] ;
      + [</VFPData>]


   *-- Info
   _Name                   = ''
   _Comment                = ''
   _Tables                 = ''
   _Sql                    = ''
   _AllowSimultaneousFetch = .F.
   _BatchUpdateCount       = 0
   _CompareMemo            = .F.
   _ConnectName            = ''
   _FetchAsNeeded          = .F.
   _FetchMemo              = .F.
   _FetchSize              = 0
   _MaxRecords             = 0
   _Offline                = .F.
   _RecordCount            = 0
   _Path                   = ''
   _ParameterList          = ''
   _Prepared               = .F.
   _RuleExpression         = ''
   _RuleText               = ''
   _SendUpdates            = .F.
   _ShareConnection        = .F.
   _SourceType             = 0
   _UpdateType             = 0
   _UseMemoSize            = 0
   _WhereType              = 0

   *-- Sub-objects
   *_Fields                = .Null.
   *_Indexes               = .Null.
   *_Relations             = .Null.


   Procedure Init
      DoDefault()
      *--
      With This As CL_DBC_VIEW Of 'cl_dbc_view.prg'
         .NewObject("_Fields", "CL_DBC_FIELDS_VW", "cl_dbc_fields_vw.prg")
         .NewObject("_Indexes", "CL_DBC_INDEXES_VW", "cl_dbc_indexes_vw.prg")
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
            , loFields As CL_DBC_FIELDS_VW Of 'cl_dbc_fields_vw.prg' ;
            , loIndexes As CL_DBC_INDEXES_VW Of 'cl_dbc_indexes_vw.prg' ;
            , loRelations As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'
         Store .Null. To loRelations, loIndexes, loFields
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_VIEW_I)) == C_VIEW_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_VIEW Of 'cl_dbc_view.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_VIEW_F $ tcLine  && Fin
                     Exit

                  Case C_FIELD_ORDER_I $ tcLine
                     loFields = ._Fields
                     loFields.analyzeOrderCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Case C_FIELDS_I $ tcLine
                     loFields    = .Null.
                     loFields    = ._Fields
                     loFields.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Case C_INDEXES_I $ tcLine
                     loIndexes   = .Null.
                     loIndexes   = ._Indexes
                     loIndexes.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Case C_RELATIONS_I $ tcLine
                     loRelations = .Null.
                     loRelations = ._Relations
                     loRelations.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Case '<Comment>' $ tcLine
                     .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Otherwise   && Propiedad de VIEW
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
         Local lcPropName, lcValue, loFields, loIndexes, loRelations

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcView                    (v! IN    ) Vista en evaluación
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tcView, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcText, lcFields, lcIndexes, lcRelations, lcDBC, loEx As Exception ;
            , loFields As CL_DBC_FIELDS_VW Of 'cl_dbc_fields_vw.prg' ;
            , loIndexes As CL_DBC_INDEXES_VW Of 'cl_dbc_indexes_vw.prg' ;
            , loRelations As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'
         Store .Null. To loRelations, loIndexes, loFields
         Store '' To lcText, lcFields, lcIndexes, lcRelations

         With This As CL_DBC_VIEW Of 'cl_dbc_view.prg'
            .read_BinDataToProperties(tcView)

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<>>
                    <<Chr(9)+Chr(9)>><VIEW>
                    <<Chr(9)+Chr(9)+Chr(9)>><Name><<tcView>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)>><Tables><<._Tables>></Tables>
                    <<Chr(9)+Chr(9)+Chr(9)>><SQL><<._SQL>></SQL>
                    <<Chr(9)+Chr(9)+Chr(9)>><AllowSimultaneousFetch><<._AllowSimultaneousFetch>></AllowSimultaneousFetch>
                    <<Chr(9)+Chr(9)+Chr(9)>><BatchUpdateCount><<._BatchUpdateCount>></BatchUpdateCount>
                    <<Chr(9)+Chr(9)+Chr(9)>><CompareMemo><<._CompareMemo>></CompareMemo>
                    <<Chr(9)+Chr(9)+Chr(9)>><ConnectName><<._ConnectName>></ConnectName>
                    <<Chr(9)+Chr(9)+Chr(9)>><FetchAsNeeded><<._FetchAsNeeded>></FetchAsNeeded>
                    <<Chr(9)+Chr(9)+Chr(9)>><FetchMemo><<._FetchMemo>></FetchMemo>
                    <<Chr(9)+Chr(9)+Chr(9)>><FetchSize><<._FetchSize>></FetchSize>
                    <<Chr(9)+Chr(9)+Chr(9)>><MaxRecords><<._MaxRecords>></MaxRecords>
                    <<Chr(9)+Chr(9)+Chr(9)>><Offline><<._Offline>></Offline>
                    <<Chr(9)+Chr(9)+Chr(9)>><ParameterList><<._ParameterList>></ParameterList>
                    <<Chr(9)+Chr(9)+Chr(9)>><Prepared><<._Prepared>></Prepared>
                    <<Chr(9)+Chr(9)+Chr(9)>><RuleExpression><<._RuleExpression>></RuleExpression>
                    <<Chr(9)+Chr(9)+Chr(9)>><RuleText><<._RuleText>></RuleText>
                    <<Chr(9)+Chr(9)+Chr(9)>><SendUpdates><<._SendUpdates>></SendUpdates>
                    <<Chr(9)+Chr(9)+Chr(9)>><ShareConnection><<._ShareConnection>></ShareConnection>
                    <<Chr(9)+Chr(9)+Chr(9)>><SourceType><<._SourceType>></SourceType>
                    <<Chr(9)+Chr(9)+Chr(9)>><UpdateType><<._UpdateType>></UpdateType>
                    <<Chr(9)+Chr(9)+Chr(9)>><UseMemoSize><<._UseMemoSize>></UseMemoSize>
                    <<Chr(9)+Chr(9)+Chr(9)>><WhereType><<._WhereType>></WhereType>
            ENDTEXT

            *-- ALGUNOS VALORES QUE EL DBGETPROP OFICIAL NO DEVUELVE
            *--     Path
            *--     OfflineRecordCount
            If ._Offline Then
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>><Path><<._Path>></Path>
                        <<Chr(9)+Chr(9)+Chr(9)>><RecordCount><<._RecordCount>></RecordCount>
               ENDTEXT
            Endif
            *--

            loFields    = ._Fields
            lcFields    = loFields.toText( tcView )

            loIndexes   = ._Indexes
            lcIndexes   = loIndexes.toText( tcView )

            loRelations = ._Relations
            lcRelations = loRelations.toText( tcView )

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<lcFields>>
                    <<lcIndexes>>
                    <<lcRelations>>
                    <<Chr(9)+Chr(9)>></VIEW>
            ENDTEXT

            ._ToText    = lcText
         Endwith && THIS


      Catch To loEx
         loEx.UserValue  = loEx.UserValue + CR_LF + "tcView = " + Rtrim(Transform(tcView))

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loRelations, loIndexes, loFields
         Release loFields, loIndexes, loRelations

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

      With This As CL_DBC_VIEW Of 'cl_dbc_view.prg'
         tnParentID  = .__ObjectID
         ._Fields.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
         ._Indexes.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
         ._Relations.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
      Endwith && THIS
   Endproc


   Procedure getBinMemoFromProperties
      Local lcBinData
      lcBinData   = ''

      With This As CL_DBC_VIEW Of 'cl_dbc_view.prg'
         If ._SourceType = 1
            lcBinData   = lcBinData + .getBinPropertyDataRecord( 6, .getDBCPropertyIDByName('Class', .T.) )
         Else
            lcBinData   = lcBinData + .getBinPropertyDataRecord( 7, .getDBCPropertyIDByName('Class', .T.) )
         Endif
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UpdateType, .getDBCPropertyIDByName('UpdateType', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._WhereType, .getDBCPropertyIDByName('WhereType', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._FetchMemo, .getDBCPropertyIDByName('FetchMemo', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ShareConnection, .getDBCPropertyIDByName('ShareConnection', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._AllowSimultaneousFetch, .getDBCPropertyIDByName('AllowSimultaneousFetch', .T.) ) && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._SendUpdates, .getDBCPropertyIDByName('SendUpdates', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Prepared, .getDBCPropertyIDByName('Prepared', .T.) ) && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._CompareMemo, .getDBCPropertyIDByName('CompareMemo', .T.) )   && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._FetchAsNeeded, .getDBCPropertyIDByName('FetchAsNeeded', .T.) )   && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._FetchSize, .getDBCPropertyIDByName('FetchSize', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._MaxRecords, .getDBCPropertyIDByName('MaxRecords', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Tables, .getDBCPropertyIDByName('Tables', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Sql, .getDBCPropertyIDByName('SQL', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._SourceType, .getDBCPropertyIDByName('SourceType', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._BatchUpdateCount, .getDBCPropertyIDByName('BatchUpdateCount', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleExpression, .getDBCPropertyIDByName('RuleExpression', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleText, .getDBCPropertyIDByName('RuleText', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ParameterList, .getDBCPropertyIDByName('ParameterList', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ConnectName, .getDBCPropertyIDByName('ConnectName', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UseMemoSize, .getDBCPropertyIDByName('UseMemoSize', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Offline, .getDBCPropertyIDByName('Offline', .T.) )   && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RecordCount, .getDBCPropertyIDByName('RecordCount', .T.) )   && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Path, .getDBCPropertyIDByName('Path', .T.) ) && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( 0, .getDBCPropertyIDByName('undocumented_view_prop_85', .T.) ) && Undocumented
      Endwith && THIS

      Return lcBinData
   Endproc


   Procedure read_BinDataToProperties
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcView                    (v! IN    ) Vista en evaluación
      *---------------------------------------------------------------------------------------------------
      Lparameters tcView

      With This As CL_DBC_VIEW Of 'cl_dbc_view.prg'
         If Not ._Saved Then
            ._Name                      = Alltrim(tcView)
            ._Comment                   = DBGetProp(tcView,"VIEW","Comment")
            ._Tables                    = DBGetProp(tcView,"VIEW","Tables")
            ._Sql                       = DBGetProp(tcView,"VIEW","SQL")
            ._AllowSimultaneousFetch    = DBGetProp(tcView,"VIEW","AllowSimultaneousFetch")
            ._BatchUpdateCount          = DBGetProp(tcView,"VIEW","BatchUpdateCount")
            ._CompareMemo               = DBGetProp(tcView,"VIEW","CompareMemo")
            ._ConnectName               = DBGetProp(tcView,"VIEW","ConnectName")
            ._FetchAsNeeded             = DBGetProp(tcView,"VIEW","FetchAsNeeded")
            ._FetchMemo                 = DBGetProp(tcView,"VIEW","FetchMemo")
            ._FetchSize                 = DBGetProp(tcView,"VIEW","FetchSize")
            ._MaxRecords                = DBGetProp(tcView,"VIEW","MaxRecords")
            ._Offline                   = DBGetProp(tcView,"VIEW","Offline")
            ._ParameterList             = DBGetProp(tcView,"VIEW","ParameterList")
            ._Prepared                  = DBGetProp(tcView,"VIEW","Prepared")
            ._RuleExpression            = DBGetProp(tcView,"VIEW","RuleExpression")
            ._RuleText                  = DBGetProp(tcView,"VIEW","RuleText")
            ._SendUpdates               = DBGetProp(tcView,"VIEW","SendUpdates")
            ._ShareConnection           = DBGetProp(tcView,"VIEW","ShareConnection")
            ._SourceType                = DBGetProp(tcView,"VIEW","SourceType")
            ._UpdateType                = DBGetProp(tcView,"VIEW","UpdateType")
            ._UseMemoSize               = DBGetProp(tcView,"VIEW","UseMemoSize")
            ._WhereType                 = DBGetProp(tcView,"VIEW","WhereType")
            *--
            ._Path                      = .DBGetProp(tcView,"VIEW","Path")          && Para las Vistas el DBGETPROP oficial no funciona con Path
            ._RecordCount               = .DBGetProp(tcView,"VIEW","RecordCount")   && Para las Vistas el DBGETPROP oficial no funciona con RecordCount
            *--
            ._Saved     = .T.
         Endif
      Endwith
   Endproc


Enddefine
