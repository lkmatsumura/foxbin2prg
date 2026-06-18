#INCLUDE foxbin2prg.h

Define Class CL_DBC As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #If .F.
      Local This As CL_DBC Of 'cl_dbc.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzecodeblock_sp" display="analyzeCodeBlock_SP"/>] ;
      + [<memberdata name="_comment" display="_Comment"/>] ;
      + [<memberdata name="_version" display="_Version"/>] ;
      + [<memberdata name="_dbcevents" display="_DBCEvents"/>] ;
      + [<memberdata name="_dbceventfilename" display="_DBCEventFilename"/>] ;
      + [<memberdata name="_connections" display="_Connections"/>] ;
      + [<memberdata name="_tables" display="_Tables"/>] ;
      + [<memberdata name="_views" display="_Views"/>] ;
      + [<memberdata name="_relations" display="_Relations"/>] ;
      + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
      + [<memberdata name="_cpid" display="_CPID"/>] ;
      + [<memberdata name="_storedprocedures" display="_StoredProcedures"/>] ;
      + [<memberdata name="_version" display="_Version"/>] ;
      + [<memberdata name="_externalclasses" display="_ExternalClasses"/>] ;
      + [<memberdata name="_externalclasses_count" display="_ExternalClasses_Count"/>] ;
      + [<memberdata name="_members" display="_Members"/>] ;
      + [<memberdata name="_members_count" display="_Members_Count"/>] ;
      + [<memberdata name="add_dbcmember" display="add_DBCMember"/>] ;
      + [</VFPData>]


   *-- Modulo
   Dimension _ExternalClasses(1,2), _Members(1,2)
   _ExternalClasses_Count  = 0
   _Members_Count          = 0
   _Version                = 0
   _SourceFile             = ''
   *LScheffler 20.08.2023
   *issue #96, [KestasL] keep CodePage relavant information for binary sources
   _cpid =      Cpcurrent()


   *-- Database Info
   _Name                   = ''
   _Comment                = ''
   _Version                = 0
   _DBCEvents              = .F.
   _DBCEventFilename       = ''
   _StoredProcedures       = ''


   Procedure Init
      DoDefault()
      *--
      With This As CL_DBC Of 'cl_dbc.prg'
         .NewObject("_Connections", "CL_DBC_CONNECTIONS", "cl_dbc_connections.prg")
         .NewObject("_Tables", "CL_DBC_TABLES", "cl_dbc_tables.prg")
         .NewObject("_Views", "CL_DBC_VIEWS", "cl_dbc_views.prg")
      Endwith && THIS
   Endproc


   Procedure analyzeCodeBlock
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines, toFoxBin2Prg

      External Array taCodeLines

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local loConnections As CL_DBC_CONNECTIONS Of 'cl_dbc_connections.prg' ;
            , loConnection As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg' ;
            , loTables As CL_DBC_TABLES Of 'cl_dbc_tables.prg' ;
            , loTable As CL_DBC_TABLE Of 'cl_dbc_table.prg' ;
            , loViews As CL_DBC_VIEWS Of 'cl_dbc_views.prg' ;
            , loView As CL_DBC_VIEW Of 'cl_dbc_view.prg' ;
            , llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
         Store '' To lcPropName, lcValue
         Store .Null. To loConnections, loTables, loViews, loConnection, loTable, loView

         If Left(tcLine, Len(C_DATABASE_I)) == C_DATABASE_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC Of 'cl_dbc.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_DATABASE_F $ tcLine  && Fin
                     Exit

                  Case C_CONNECTIONS_I $ tcLine
                     loConnections   = ._Connections
                     loConnections.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                     loConnections.KeySort=2
                     For Each loConnection In loConnections &&FOXOBJECT
                        .add_DBCMember('connection.' + loConnection._Name)
                     Endfor

                  Case C_TABLES_I $ tcLine
                     loTables    = ._Tables
                     loTables.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                     loTables.KeySort=2
                     For Each loTable In loTables &&FOXOBJECT
                        .add_DBCMember('table.' + loTable._Name)
                     Endfor

                  Case C_VIEWS_I $ tcLine
                     loViews = ._Views
                     loViews.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                     loViews.KeySort=2
                     For Each loView In loViews &&FOXOBJECT
                        .add_DBCMember('view.' + loView._Name)
                     Endfor

                  Case C_STORED_PROC_I $ tcLine
                     .analyzeCodeBlock_SP( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     .add_DBCMember('database.storedproceduressource')

                  Case '<Comment>' $ tcLine
                     .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Otherwise   && Otro valor
                     *-- Estructura a reconocer:
                     *   <tagname>ID<tagname>
                     lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                     lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                     .add_Property( '_' + lcPropName, lcValue )
                  Endcase
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx
         If loEx.ErrorNo = 1470  && Incorrect property name.
            loEx.UserValue  = 'I=' + Transform(m.I) + ', PropName=[' + Transform(lcPropName) + '], Value=[' + Transform(lcValue) + ']'
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loConnections, loTables, loViews, loConnection, loTable, loView
         Release loConnections, loTables, loViews, loConnection, loTable, loView
      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_SP
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      If Left(tcLine, Len(C_STORED_PROC_I)) == C_STORED_PROC_I
         Local lcValue
         lcValue = ''

         With This As CL_DBC Of 'cl_dbc.prg'
            For I = m.I + 1 To tnCodeLines
               .set_Line( @tcLine, @taCodeLines, m.I )

               Do Case
               Case C_STORED_PROC_F $ tcLine   && Fin
                  Exit

               Otherwise   && Línea de Stored Procedure
                  lcValue = lcValue + CR_LF + taCodeLines(m.I)
               Endcase
            Endfor

            .AddProperty( '_StoredProcedures', Substr(lcValue,3) )
         Endwith && THIS
      Endif
   Endproc


   Procedure updateDBC
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_OutputFile             (v! IN    ) Nombre del archivo de salida
      * tnLastID                  (!@ IN    ) Último número de ID usado
      * tnParentID                (v! IN    ) ID del objeto Padre
      *---------------------------------------------------------------------------------------------------
      Lparameters tc_OutputFile, tnLastID, tnParentID

      Try
         Local loTables As CL_DBC_TABLES Of 'cl_dbc_tables.prg' ;
            , loConnections As CL_DBC_CONNECTIONS Of 'cl_dbc_connections.prg' ;
            , loViews As CL_DBC_VIEWS Of 'cl_dbc_views.prg'
         Local lcStoredProcedures
         Store .Null. To loTables, loConnections, loViews

         With This As CL_DBC Of 'cl_dbc.prg'
            loTables            = ._Tables
            loConnections       = ._Connections
            loViews             = ._Views
            lcStoredProcedures  = ._StoredProcedures

            Erase (tc_OutputFile)
            Erase (Forceext(tc_OutputFile,'DCX'))
            Erase (Forceext(tc_OutputFile,'DCT'))
            Create Database (tc_OutputFile)

            Close Databases
            Open Database (tc_OutputFile) Shared
            Use (tc_OutputFile) Shared Again Alias TABLABIN
            tnLastID    = 5
            .setNextID(0)
            tnParentID  = .__ObjectID

            lcMemoWithProperties    = .getBinMemoFromProperties()
            Update TABLABIN ;
               SET Property = lcMemoWithProperties ;
               WHERE Str(ParentId) + ObjectType + Lower(OBJECTNAME) = Str(1) + Padr('Database',10) + Padr(Lower('Database'),128)

            If Not Empty(lcStoredProcedures)
               Update TABLABIN ;
                  SET Code = lcStoredProcedures ;
                  WHERE Str(ParentId) + ObjectType + Lower(OBJECTNAME) = Str(1) + Padr('Database',10) + Padr(Lower('StoredProceduresSource'),128)
            Endif

            loTables.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
            loViews.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
            loConnections.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
         Endwith && THIS


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Close Databases
         Use In (Select("TABLABIN"))
         Store .Null. To loTables, loConnections, loViews
         Release loTables, loConnections, loViews

      Endtry

      Return
   Endproc



   Procedure toText
      Lparameters toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, lcText, lcDBC, laCode(1,1), lcConnections, lcTables, lcViews, loEx As Exception ;
            , loConnections As CL_DBC_CONNECTIONS Of 'cl_dbc_connections.prg' ;
            , loTables As CL_DBC_TABLES Of 'cl_dbc_tables.prg' ;
            , loViews As CL_DBC_VIEWS Of 'cl_dbc_views.prg' ;
            , loRelations As CL_DBC_RELATIONS Of 'cl_dbc_relations.prg'
         Store .Null. To loRelations, loViews, loTables, loTables

         With This As CL_DBC Of 'cl_dbc.prg'
            Store '' To lcText, lcConnections, lcTables, lcViews
            lcDBC   = Juststem(Dbc())

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<>>
                    <DATABASE>
                    <<Chr(9)>><Name><<lcDBC>></Name>
                    <<Chr(9)>><Comment><<DBGETPROP(lcDBC,"DATABASE","Comment")>></Comment>
                    <<Chr(9)>><Version><<DBGETPROP(lcDBC,"DATABASE","Version")>></Version>
                    <<Chr(9)>><DBCEvents><<DBGETPROP(lcDBC,"DATABASE","DBCEvents")>></DBCEvents>
                    <<Chr(9)>><DBCEventFilename><<DBGETPROP(lcDBC,"DATABASE","DBCEventFilename")>></DBCEventFilename>
            ENDTEXT

            *-- Connections
            loConnections   = ._Connections
            lcConnections   = loConnections.toText( @toFoxBin2Prg )

            *-- Tables
            loTables        = ._Tables
            lcTables        = loTables.toText( @toFoxBin2Prg )

            *-- Views
            loViews         = ._Views
            lcViews         = loViews.toText( @toFoxBin2Prg )

            Select Code ;
               FROM TABLABIN ;
               WHERE Str(ParentId) + ObjectType + Lower(OBJECTNAME) = Str(1) + Padr('Database',10) + Padr(Lower('StoredProceduresSource'),128) ;
               INTO Array laCode
            TEXT TO ._StoredProcedures TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)>><<C_STORED_PROC_I>>
                    <<laCode(1,1)>>
                    <<Chr(9)>><<C_STORED_PROC_F>>
            ENDTEXT

            If Not toFoxBin2Prg.getCfgValue('n_UseFilesPerDBC') > 0 Then
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<lcConnections>>
                        <<lcTables>>
                        <<lcViews>>
                        <<>>
                        <<._StoredProcedures>>
               ENDTEXT
            Endif

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    </DATABASE>
            ENDTEXT
         Endwith && THIS


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loRelations, loViews, loTables, loTables
         Release I, lcDBC, laCode, loConnections, loTables, loViews, loRelations

      Endtry

      Return lcText
   Endproc


   Procedure getBinMemoFromProperties
      Local lcBinData
      lcBinData   = ''

      With This As CL_DBC Of 'cl_dbc.prg'
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Version, .getDBCPropertyIDByName('Version', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DBCEvents, .getDBCPropertyIDByName('DBCEvents', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DBCEventFilename, .getDBCPropertyIDByName('DBCEventFilename', .T.) )
      Endwith && THIS

      Return lcBinData
   Endproc


   Procedure add_DBCMember
      Lparameters tcMemberName

      With This As CL_DBC Of 'cl_dbc.prg'
         ._Members_Count = ._Members_Count + 1
         Dimension ._Members( ._Members_Count, 2 )
         ._Members( ._Members_Count, 1 ) = Lower(tcMemberName)
      Endwith && THIS
   Endproc


Enddefine
