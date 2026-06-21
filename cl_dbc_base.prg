#INCLUDE foxbin2prg.h

Define Class CL_DBC_BASE As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="add_property" display="Add_Property"/>] ;
      + [<memberdata name="analyzecodeblock_comment" display="analyzeCodeBlock_Comment"/>] ;
      + [<memberdata name="_dbc" display="_DBC"/>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_saved" display="_Saved"/>] ;
      + [<memberdata name="_totext" display="_ToText"/>] ;
      + [<memberdata name="__objectid" display="__ObjectID"/>] ;
      + [<memberdata name="dbgetprop" display="DBGETPROP"/>] ;
      + [<memberdata name="dbsetprop" display="DBSETPROP"/>] ;
      + [<memberdata name="getallpropertiesfromobjectname" display="getAllPropertiesFromObjectname"/>] ;
      + [<memberdata name="getbinpropertydatarecord" display="getBinPropertyDataRecord"/>] ;
      + [<memberdata name="getcodememo" display="getCodeMemo"/>] ;
      + [<memberdata name="getdbcpropertyidbyname" display="getDBCPropertyIDByName"/>] ;
      + [<memberdata name="getdbcpropertynamebyid" display="getDBCPropertyNameByID"/>] ;
      + [<memberdata name="getdbcpropertyvaluetypebypropertyid" display="getDBCPropertyValueTypeByPropertyID"/>] ;
      + [<memberdata name="getid" display="getID"/>] ;
      + [<memberdata name="getobjecttype" display="getObjectType"/>] ;
      + [<memberdata name="read_bindatatoproperties" display="read_BinDataToProperties"/>] ;
      + [<memberdata name="getbinmemofromproperties" display="getBinMemoFromProperties"/>] ;
      + [<memberdata name="getreferentialintegrityinfo" display="getReferentialIntegrityInfo"/>] ;
      + [<memberdata name="getusermemo" display="getUserMemo"/>] ;
      + [<memberdata name="read_dbc_header" display="read_DBC_Header"/>] ;
      + [<memberdata name="readnext_dbc_headerdatarecord" display="readNext_DBC_HeaderDataRecord"/>] ;
      + [<memberdata name="setnextid" display="setNextID"/>] ;
      + [<memberdata name="updatedbc" display="updateDBC"/>] ;
      + [</VFPData>]


   __ObjectID      = 0
   _DBC            = ''
   _Name           = ''
   _Saved          = .F.       && Indica si la información fue leida y guardada en las propiedades.
   _ToText         = ''        && Propiedades pasadas a Texto para guardar en archivo externo xx2


   Function add_Property
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcPropertyName            (v! IN    ) Nombre de la propiedad a agregar o modificar
      * teValue                   (v! IN    ) Valor de la propiedad
      *---------------------------------------------------------------------------------------------------
      Lparameters tcPropertyName, teValue

      Local lnPropertyID, tcDataType, leValue, llRetorno, lnDataLen

      With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
         lnPropertyID    = .getDBCPropertyIDByName( Substr(tcPropertyName,2) )

         If lnPropertyID = -1
            If Pcount()=1
               llRetorno   = .AddProperty( tcPropertyName )
            Else
               llRetorno   = .AddProperty( tcPropertyName, teValue )
            Endif
         Else
            tcDataType  = .getDBCPropertyValueTypeByPropertyID( lnPropertyID )
            lnDataLen   = Len(teValue)

            Do Case
            Case tcDataType = 'L'
               If lnDataLen = 0
                  leValue     = .F.
               Else
                  leValue     = Cast( teValue As (tcDataType) )
               Endif

            Case Inlist(tcDataType, 'N', 'B')
               If lnDataLen = 0
                  leValue     = 0
               Else
                  leValue     = Cast( teValue As (tcDataType) (lnDataLen) )
               Endif

            Otherwise   && Asumo 'C'
               If lnDataLen = 0
                  leValue     = ''
               Else
                  leValue     = teValue
               Endif

            Endcase

            llRetorno   = .AddProperty( tcPropertyName, leValue )
         Endif
      Endwith && THIS

      Return llRetorno
   Endfunc


   Procedure analyzeCodeBlock_Comment
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      If Left(tcLine, Len('<Comment>')) == '<Comment>'
         Local lcValue
         llBloqueEncontrado  = .T.
         lcValue = Strextract( taCodeLines(m.I), '<Comment>', '</Comment>', 1, 2 )

         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            If Not '</Comment>' $ tcLine Then
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case '</Comment>' $ tcLine  && Fin
                     lcValue = lcValue + CR_LF + Left( taCodeLines(m.I), At( '</Comment>', taCodeLines(m.I) ) - 1 )
                     Exit

                  Otherwise   && Línea de Stored Procedure
                     lcValue = lcValue + CR_LF + taCodeLines(m.I)
                  Endcase
               Endfor
            Endif

            .AddProperty( '_Comment', lcValue )
         Endwith && THIS
      Endif
   Endproc


   Procedure getAllPropertiesFromObjectname
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcName                    (v! IN    ) Nombre del objeto
      * tcType                    (v! IN    ) Tipo de objeto (Table, Index, Field, View, Relation)
      * taProperties              (!@    OUT) Array con las propiedades encontradas y sus valores
      * tnProperty_Count          (!@    OUT) Cantidad de propiedades encontradas
      *---------------------------------------------------------------------------------------------------
      Lparameters tcName, tcType, taProperties, tnProperty_Count

      External Array taProperties && STRUCTURE: PropName,RecordLen,DataIDLen,DataID,DataType,Data

      Try
         Local lcValue, leValue, lnSelect, laProperty(1,1), lnRecordLen, lcBinRecord, lnPropertyID ;
            , lnLastPos, lnLenCCode, lcDataType, lcPropName, lcDBF, lnLenData, lnLenHeader

         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            tnProperty_Count    = 0
            lnSelect    = Select()
            leValue     = ''
            tcName      = Proper(Rtrim(tcName))
            tcType      = Proper(Rtrim(tcType))
            tcProperty  = Proper(Rtrim(tcProperty))
            lcDBF       = Dbf()

            Select 0
            Use (lcDBF) Shared Again Noupdate Alias C_TABLABIN2

            If Inlist( tcType, 'Index', 'Field' )
               Select TB.Property From C_TABLABIN2 TB ;
                  INNER Join C_TABLABIN2 TB2 On Str(TB.ParentId)+TB.ObjectType+Lower(TB.OBJECTNAME) = Str(TB2.ObjectID)+Padr(tcType,10)+Padr(Lower(Justext(tcName)),128) ;
                  AND TB2.OBJECTNAME = Padr(Lower(Juststem(tcName)),128) ;
                  INTO Array laProperty

            Else
               Select TB.Property From C_TABLABIN2 TB ;
                  INNER Join C_TABLABIN2 TB2 On Str(TB.ParentId)+TB.ObjectType+Lower(TB.OBJECTNAME) = Str(TB2.ObjectID)+Padr(tcType,10)+Padr(Lower(tcName),128) ;
                  INTO Array laProperty

            Endif

            If _Tally > 0
               If Empty(laProperty(1,1))
                  Exit
               Endif

               lnLastPos       = 1

               Do While lnLastPos < Len(laProperty(1,1))
                  tnProperty_Count    = tnProperty_Count + 1
                  Dimension taProperties( tnProperty_Count,6 )

                  lnRecordLen     = CToBin( Substr(laProperty(1,1), lnLastPos, 4), "4RS" )
                  lcBinRecord     = Substr(laProperty(1,1), lnLastPos, lnRecordLen)
                  lnLenCCode      = CToBin( Substr(lcBinRecord, 4+1, 2), "2RS" )
                  lnPropertyID    = Asc( Substr(lcBinRecord, 4+2+1, lnLenCCode) )
                  lcPropName      = .getDBCPropertyNameByID( lnPropertyID )
                  lcDataType      = .getDBCPropertyValueTypeByPropertyID( lnPropertyID )
                  lnLenHeader     = 4 + 2 + lnLenCCode
                  lcValue         = Substr(lcBinRecord, lnLenHeader + 1)

                  Do Case
                  Case lcDataType = 'B'
                     If lnLenHeader = lnRecordLen
                        leValue     = 0
                     Else
                        leValue     = Asc( lcValue )
                     Endif

                  Case lcDataType = 'L'
                     If lnLenHeader = lnRecordLen
                        leValue     = .F.
                     Else
                        leValue     = ( CToBin( lcValue, "1S" ) = 1 )
                     Endif

                  Case lcDataType = 'N'
                     If lnLenHeader = lnRecordLen
                        leValue     = 0
                     Else
                        leValue     = CToBin( lcValue, "4S" )
                     Endif

                  Otherwise && Asume 'C'
                     If lnLenHeader = lnRecordLen
                        leValue     = ''
                     Else
                        leValue     = Left( lcValue, At( Chr(0), lcValue ) - 1 )
                     Endif
                  Endcase

                  taProperties( tnProperty_Count,1 )  = lcPropName
                  taProperties( tnProperty_Count,2 )  = lnRecordLen
                  taProperties( tnProperty_Count,3 )  = lnLenCCode
                  taProperties( tnProperty_Count,4 )  = lnPropertyID
                  taProperties( tnProperty_Count,5 )  = lcDataType
                  taProperties( tnProperty_Count,6 )  = leValue

                  lnLastPos   = lnLastPos + lnRecordLen
               Enddo
            Else
               Error 1562, (tcName)
            Endif
         Endwith && THIS


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("C_TABLABIN2"))
         Select (lnSelect)
      Endtry

      Return leValue
   Endproc


   Procedure getDBCPropertyIDByName
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcPropertyName            (v! IN    ) Nombre de la propiedad
      * tlRethrowError            (v? IN    ) Indica si se debe relanzar el error o solo devolver -1
      *---------------------------------------------------------------------------------------------------
      Lparameters tcPropertyName, tlRethrowError
      Local lnPropertyID
      tcPropertyName  = Lower(Rtrim(tcPropertyName))

      Do Case
      Case tcPropertyName == 'null'
         lnPropertyID    = 0
      Case tcPropertyName == 'path'
         lnPropertyID    = 1
      Case tcPropertyName == 'class'
         lnPropertyID    = 2
      Case tcPropertyName == 'comment'
         lnPropertyID    = 7
      Case tcPropertyName == 'ruleexpression'
         lnPropertyID    = 9
      Case tcPropertyName == 'ruletext'
         lnPropertyID    = 10
      Case tcPropertyName == 'defaultvalue'
         lnPropertyID    = 11
      Case tcPropertyName == 'parameterlist'
         lnPropertyID    = 12
      Case tcPropertyName == 'childtag'
         lnPropertyID    = 13
      Case tcPropertyName == 'inserttrigger'
         lnPropertyID    = 14
      Case tcPropertyName == 'updatetrigger'
         lnPropertyID    = 15
      Case tcPropertyName == 'deletetrigger'
         lnPropertyID    = 16
      Case tcPropertyName == 'isunique'
         lnPropertyID    = 17
      Case tcPropertyName == 'parenttable'
         lnPropertyID    = 18
      Case tcPropertyName == 'parenttag'
         lnPropertyID    = 19
      Case tcPropertyName == 'primarykey'
         lnPropertyID    = 20
      Case tcPropertyName == 'version'
         lnPropertyID    = 24
      Case tcPropertyName == 'batchupdatecount'
         lnPropertyID    = 28
      Case tcPropertyName == 'datasource'
         lnPropertyID    = 29
      Case tcPropertyName == 'connectname'
         lnPropertyID    = 32
      Case tcPropertyName == 'updatename'
         lnPropertyID    = 35
      Case tcPropertyName == 'fetchmemo'
         lnPropertyID    = 36
      Case tcPropertyName == 'fetchsize'
         lnPropertyID    = 37
      Case tcPropertyName == 'keyfield'
         lnPropertyID    = 38
      Case tcPropertyName == 'maxrecords'
         lnPropertyID    = 39
      Case tcPropertyName == 'shareconnection'
         lnPropertyID    = 40
      Case tcPropertyName == 'sourcetype'
         lnPropertyID    = 41
      Case tcPropertyName == 'sql'
         lnPropertyID    = 42
      Case tcPropertyName == 'tables'
         lnPropertyID    = 43
      Case tcPropertyName == 'sendupdates'
         lnPropertyID    = 44
      Case tcPropertyName == 'updatablefield' Or tcPropertyName == 'updatable'
         lnPropertyID    = 45
      Case tcPropertyName == 'updatetype'
         lnPropertyID    = 46
      Case tcPropertyName == 'usememosize'
         lnPropertyID    = 47
      Case tcPropertyName == 'wheretype'
         lnPropertyID    = 48
      Case tcPropertyName == 'displayclass'   && Undocumented
         lnPropertyID    = 50
      Case tcPropertyName == 'displayclasslibrary'    && Undocumented
         lnPropertyID    = 51
      Case tcPropertyName == 'inputmask'  && Undocumented
         lnPropertyID    = 54
      Case tcPropertyName == 'format' && Undocumented
         lnPropertyID    = 55
      Case tcPropertyName == 'caption'
         lnPropertyID    = 56
      Case tcPropertyName == 'asynchronous'
         lnPropertyID    = 64
      Case tcPropertyName == 'batchmode'
         lnPropertyID    = 65
      Case tcPropertyName == 'connectstring'
         lnPropertyID    = 66
      Case tcPropertyName == 'connecttimeout'
         lnPropertyID    = 67
      Case tcPropertyName == 'displogin'
         lnPropertyID    = 68
      Case tcPropertyName == 'dispwarnings'
         lnPropertyID    = 69
      Case tcPropertyName == 'idletimeout'
         lnPropertyID    = 70
      Case tcPropertyName == 'querytimeout'
         lnPropertyID    = 71
      Case tcPropertyName == 'password'
         lnPropertyID    = 72
      Case tcPropertyName == 'transactions'
         lnPropertyID    = 73
      Case tcPropertyName == 'userid'
         lnPropertyID    = 74
      Case tcPropertyName == 'waittime'
         lnPropertyID    = 75
      Case tcPropertyName == 'timestamp'
         lnPropertyID    = 76
      Case tcPropertyName == 'datatype'
         lnPropertyID    = 77
      Case tcPropertyName == 'packetsize' && Undocumented
         lnPropertyID    = 78
      Case tcPropertyName == 'database'   && Undocumented
         lnPropertyID    = 79
      Case tcPropertyName == 'prepared'   && Undocumented
         lnPropertyID    = 80
      Case tcPropertyName == 'comparememo'    && Undocumented
         lnPropertyID    = 81
      Case tcPropertyName == 'fetchasneeded'  && Undocumented
         lnPropertyID    = 82
      Case tcPropertyName == 'offline'    && Undocumented
         lnPropertyID    = 83
      Case tcPropertyName == 'recordcount'    && Undocumented
         lnPropertyID    = 84
      Case tcPropertyName == 'undocumented_view_prop_85'  && Undocumented
         lnPropertyID    = 85
      Case tcPropertyName == 'dbcevents'  && Undocumented
         lnPropertyID    = 86
      Case tcPropertyName == 'dbceventfilename'   && Undocumented
         lnPropertyID    = 87
      Case tcPropertyName == 'allowsimultaneousfetch' && Undocumented
         lnPropertyID    = 88
      Case tcPropertyName == 'disconnectrollback' && Undocumented
         lnPropertyID    = 89
      Otherwise
         If tlRethrowError
            Error 1559, (tcPropertyName)
         Else
            lnPropertyID    = -1
         Endif
      Endcase

      Return lnPropertyID
   Endproc


   Procedure getDBCPropertyNameByID
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcPropertyID              (v! IN    ) Nombre de la propiedad
      * tlRethrowError            (v? IN    ) Indica si se debe relanzar el error o solo devolver -1
      *---------------------------------------------------------------------------------------------------
      Lparameters tnPropertyID, tlRethrowError
      Local lcPropertyName

      Do Case
      Case tnPropertyID   = 0
         lcPropertyName = 'null'
      Case tnPropertyID   = 1
         lcPropertyName = 'path'
      Case tnPropertyID   = 2
         lcPropertyName = 'class'
      Case tnPropertyID   = 7
         lcPropertyName = 'comment'
      Case tnPropertyID   = 9
         lcPropertyName = 'ruleexpression'
      Case tnPropertyID   = 10
         lcPropertyName = 'ruletext'
      Case tnPropertyID   = 11
         lcPropertyName = 'defaultvalue'
      Case tnPropertyID   = 12
         lcPropertyName = 'parameterlist'
      Case tnPropertyID   = 13
         lcPropertyName = 'childtag'
      Case tnPropertyID   = 14
         lcPropertyName = 'inserttrigger'
      Case tnPropertyID   = 15
         lcPropertyName = 'updatetrigger'
      Case tnPropertyID   = 16
         lcPropertyName = 'deletetrigger'
      Case tnPropertyID   = 17
         lcPropertyName = 'isunique'
      Case tnPropertyID   = 18
         lcPropertyName = 'parenttable'
      Case tnPropertyID   = 19
         lcPropertyName = 'parenttag'
      Case tnPropertyID   = 20
         lcPropertyName = 'primarykey'
      Case tnPropertyID   = 24
         lcPropertyName = 'version'
      Case tnPropertyID   = 28
         lcPropertyName = 'batchupdatecount'
      Case tnPropertyID   = 29
         lcPropertyName = 'datasource'
      Case tnPropertyID   = 32
         lcPropertyName = 'connectname'
      Case tnPropertyID   = 35
         lcPropertyName = 'updatename'
      Case tnPropertyID   = 36
         lcPropertyName = 'fetchmemo'
      Case tnPropertyID   = 37
         lcPropertyName = 'fetchsize'
      Case tnPropertyID   = 38
         lcPropertyName = 'keyfield'
      Case tnPropertyID   = 39
         lcPropertyName = 'maxrecords'
      Case tnPropertyID   = 40
         lcPropertyName = 'shareconnection'
      Case tnPropertyID   = 41
         lcPropertyName = 'sourcetype'
      Case tnPropertyID   = 42
         lcPropertyName = 'sql'
      Case tnPropertyID   = 43
         lcPropertyName = 'tables'
      Case tnPropertyID   = 44
         lcPropertyName = 'sendupdates'
      Case tnPropertyID   = 45
         lcPropertyName = 'updatablefield'
      Case tnPropertyID   = 46
         lcPropertyName = 'updatetype'
      Case tnPropertyID   = 47
         lcPropertyName = 'usememosize'
      Case tnPropertyID   = 48
         lcPropertyName = 'wheretype'
      Case tnPropertyID   = 50
         lcPropertyName = 'displayclass' && Undocumented
      Case tnPropertyID   = 51
         lcPropertyName = 'displayclasslibrary'  && Undocumented
      Case tnPropertyID   = 54
         lcPropertyName = 'inputmask'    && Undocumented
      Case tnPropertyID   = 55
         lcPropertyName = 'format'   && Undocumented
      Case tnPropertyID   = 56
         lcPropertyName = 'caption'
      Case tnPropertyID   = 64
         lcPropertyName = 'asynchronous'
      Case tnPropertyID   = 65
         lcPropertyName = 'batchmode'
      Case tnPropertyID   = 66
         lcPropertyName = 'connectstring'
      Case tnPropertyID   = 67
         lcPropertyName = 'connecttimeout'
      Case tnPropertyID   = 68
         lcPropertyName = 'displogin'
      Case tnPropertyID   = 69
         lcPropertyName = 'dispwarnings'
      Case tnPropertyID   = 70
         lcPropertyName = 'idletimeout'
      Case tnPropertyID   = 71
         lcPropertyName = 'querytimeout'
      Case tnPropertyID   = 72
         lcPropertyName = 'password'
      Case tnPropertyID   = 73
         lcPropertyName = 'transactions'
      Case tnPropertyID   = 74
         lcPropertyName = 'userid'
      Case tnPropertyID   = 75
         lcPropertyName = 'waittime'
      Case tnPropertyID   = 76
         lcPropertyName = 'timestamp'
      Case tnPropertyID   = 77
         lcPropertyName = 'datatype'
      Case tnPropertyID   = 78
         lcPropertyName = 'packetsize'   && Undocumented
      Case tnPropertyID   = 79
         lcPropertyName = 'database' && Undocumented
      Case tnPropertyID   = 80
         lcPropertyName = 'prepared' && Undocumented
      Case tnPropertyID   = 81
         lcPropertyName = 'comparememo'  && Undocumented
      Case tnPropertyID   = 82
         lcPropertyName = 'fetchasneeded'    && Undocumented
      Case tnPropertyID   = 83
         lcPropertyName = 'offline'  && Undocumented
      Case tnPropertyID   = 84
         lcPropertyName = 'recordcount'  && Undocumented
      Case tnPropertyID   = 85
         lcPropertyName = 'undocumented_view_prop_85'    && Undocumented
      Case tnPropertyID   = 86
         lcPropertyName = 'dbcevents'    && Undocumented
      Case tnPropertyID   = 87
         lcPropertyName = 'dbceventfilename' && Undocumented
      Case tnPropertyID   = 88
         lcPropertyName = 'allowsimultaneousfetch'   && Undocumented
      Case tnPropertyID   = 89
         lcPropertyName = 'disconnectrollback'   && Undocumented
      Otherwise
         If tlRethrowError
            Error 1559, (Transform(tnPropertyID))
         Else
            lcPropertyName  = ''
         Endif
      Endcase

      Return lcPropertyName
   Endproc


   Procedure getDBCPropertyValueTypeByPropertyID
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tnPropertyID              (v! IN    ) ID de la Propiedad
      *---------------------------------------------------------------------------------------------------
      Lparameters tnPropertyID
      Local lcValueType ;
         , loLang As CL_LANG Of 'cl_lang.prg'

      loLang          = _Screen.o_FoxBin2Prg_Lang
      lcValueType = ''

      Do Case
      Case Inlist(tnPropertyID,2,41,46,48,68,73)
         lcValueType = 'B'   && Byte

      Case Inlist(tnPropertyID,17,36,38,40,44,45,64,65,69,80,81,82,83,86,88,89)
         lcValueType = 'L'

      Case Inlist(tnPropertyID,24,28,37,39,47,67,70,71,75,76,78,84,85)
         lcValueType = 'N'

      Case Inlist(tnPropertyID,0,1,7,9,10,11,12,13,14,15,16,18,19,20,29,30,32,35) ;
            OR Inlist(tnPropertyID,42,43,49,50,51,54,55,56,66,67,72,74,77,79,87)
         lcValueType = 'C'

      Otherwise
         *ERROR 'Propiedad [' + TRANSFORM(tnPropertyID) + '] no reconocida.'
         Error (Textmerge(loLang.C_PROPERTY_NAME_NOT_RECOGNIZED_LOC))
      Endcase

      Return lcValueType
   Endproc


   Procedure DBGetProp
      *---------------------------------------------------------------------------------------------------
      * Emula el comando DBGETPROP interno de VFP
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcName                    (v! IN    ) Nombre del objeto
      * tcType                    (v! IN    ) Tipo de objeto (Table, Index, Field, View, Relation)
      * tcProperty                (v! IN    ) Nombre de la propiedad
      *---------------------------------------------------------------------------------------------------
      Lparameters tcName, tcType, tcProperty

      Try
         Local lcValue, lxValue, lnSelect, lcInfo, lnRecno, lnRecordLen, lcBinRecord, lnPropertyID ;
            , lnLastPos, lnLenCCode, lcDataType, lnSerchedDataCC, lcDBF, lnLenData, lnLenHeader ;
            , lcInfo, lnRecno ;
            , loEx As Exception

         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            lnSelect    = Select()
            lxValue     = ''

            If .DBPROP_INFO_RECNO(tcName, tcType, tcProperty, @lcInfo, @lnRecno) > 0
               If Empty(lcInfo)
                  Exit
               Endif

               If .DBGETPROP_POS_AND_LEN(tcProperty, @lcInfo, @lnLastPos, @lnRecordLen ;
                     , @lcBinRecord, @lnLenCCode, @lnPropertyID)

                  lcDataType      = .getDBCPropertyValueTypeByPropertyID( lnPropertyID )
                  lnLenHeader     = 4 + 2 + lnLenCCode
                  lcValue         = Substr(lcBinRecord, lnLenHeader + 1)

                  Do Case
                  Case lcDataType = 'B'
                     If lnLenHeader = lnRecordLen
                        lxValue     = 0
                     Else
                        lxValue     = Asc( lcValue )
                     Endif

                  Case lcDataType = 'L'
                     If lnLenHeader = lnRecordLen
                        lxValue     = .F.
                     Else
                        lxValue     = ( CToBin( lcValue, "1S" ) = 1 )
                     Endif

                  Case lcDataType = 'N'
                     If lnLenHeader = lnRecordLen
                        lxValue     = 0
                     Else
                        lxValue     = CToBin( lcValue, "4S" )
                     Endif

                  Otherwise && Asume 'C'
                     If lnLenHeader = lnRecordLen
                        lxValue     = ''
                     Else
                        lxValue     = Left( lcValue, At( Chr(0), lcValue ) - 1 )
                     Endif
                  Endcase

               Endif

            Else
               Error 1562, (tcName)
            Endif
         Endwith && THIS


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("C_TABLABIN2"))
         Select (lnSelect)
      Endtry

      Return lxValue
   Endproc


   Procedure DBSetProp
      *---------------------------------------------------------------------------------------------------
      * Emula el comando DBSETPROP interno de VFP
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcName                    (v! IN    ) Nombre del objeto
      * tcType                    (v! IN    ) Tipo de objeto (Table, Index, Field, View, Relation)
      * tcProperty                (v! IN    ) Nombre de la propiedad
      * txPropertyValue           (v! IN    ) Valor de la propiedad
      *---------------------------------------------------------------------------------------------------
      Lparameters tcName, tcType, tcProperty, txPropertyValue

      Try
         Local lnSelect, laProperty(1,1), lnRecordLen, lcBinRecord, lnPropertyID ;
            , lnLastPos, lnLenCCode, lcDataType, lnSerchedDataCC, lnLenData, lnLenHeader ;
            , lcInfo, lnRecno, llSet ;
            , loEx As Exception

         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            lnSelect    = Select()
            lcInfo      = ''

            If .DBPROP_INFO_RECNO(tcName, tcType, tcProperty, @lcInfo, @lnRecno) > 0
               If Empty(lcInfo)
                  Exit
               Endif

               If .DBGETPROP_POS_AND_LEN(tcProperty, @lcInfo, @lnLastPos, @lnRecordLen ;
                     , @lcBinRecord, @lnLenCCode, @lnPropertyID)

                  lcDataType      = .getDBCPropertyValueTypeByPropertyID( lnPropertyID )
                  lcBinRecord     = .getBinPropertyDataRecord( @txPropertyValue, lnPropertyID )

                  If Empty(lcInfo)
                     lcInfo  = lcBinRecord
                  Else
                     lcInfo  = Stuff(lcInfo, lnLastPos, lnRecordLen, lcBinRecord)
                  Endif

                  Goto Record (lnRecno)
                  Replace Property With lcInfo
               Endif

               llSet   = .T.

            Else
               Error 1562, (tcName)
            Endif
         Endwith && THIS


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("C_TABLABIN2"))
         Select (lnSelect)
      Endtry

      Return llSet
   Endproc


   Hidden Procedure DBPROP_INFO_RECNO
      *---------------------------------------------------------------------------------------------------
      * Devuelve el campo property y el número de registro donde lo encontró
      * para ser usado por DBGETPROP y DBSETPROP
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcName                    (v! IN    ) Nombre del objeto
      * tcType                    (v! IN    ) Tipo de objeto (Table, Index, Field, View, Relation)
      * tcProperty                (v! IN    ) Nombre de la propiedad
      * tcInfo                    (@!    OUT) Información del campo memo "Property" que contiene el dato indicado
      * tnRecno                   (@!    OUT) Número de registro del campo encontrado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcName, tcType, tcProperty, tcInfo, tnRecno

      Try
         Local laProperty(1,1), lcDBF, lnTally ;
            , loEx As Exception

         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            tcType      = Proper(Rtrim(tcType))
            tcName      = Iif(tcType = 'Database', 'Database', Proper(Rtrim(tcName)) )
            tcProperty  = Proper(Rtrim(tcProperty))
            lcDBF       = Iif(tcType = 'Database', Evl(._DBC, tcName), Dbf())
            tcInfo      = ''
            tnRecno     = 0
            lnTally     = 0

            Select 0
            Use (lcDBF) Shared Again Alias C_TABLABIN2

            If Inlist( tcType, 'Index', 'Field' )
               Select TB.Property, Recno() From C_TABLABIN2 TB ;
                  INNER Join C_TABLABIN2 TB2 On Str(TB.ParentId)+TB.ObjectType+Lower(TB.OBJECTNAME) = Str(TB2.ObjectID)+Padr(tcType,10)+Padr(Lower(Justext(tcName)),128) ;
                  AND TB2.OBJECTNAME = Padr(Lower(Juststem(tcName)),128) ;
                  INTO Array laProperty

            Else
               Select TB.Property, Recno() From C_TABLABIN2 TB ;
                  INNER Join C_TABLABIN2 TB2 On Str(TB.ParentId)+TB.ObjectType+Lower(TB.OBJECTNAME) = Str(TB2.ObjectID)+Padr(tcType,10)+Padr(Lower(tcName),128) ;
                  INTO Array laProperty

            Endif

            If _Tally > 0
               lnTally = _Tally
               tcInfo  = laProperty(1,1)
               tnRecno = laProperty(1,2)
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lnTally
   Endproc


   Hidden Procedure DBGETPROP_POS_AND_LEN
      *---------------------------------------------------------------------------------------------------
      * Devuelve la posición y longitud del dato asociado a la propiedad indicada
      * para ser usado por DBGETPROP y DBSETPROP
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcProperty                (v! IN    ) Nombre de la propiedad
      * tcInfo                    (@! IN    ) Información del campo memo "Property" que contiene el dato indicado
      * tnLastPos                 (@!    OUT) Posición del campo Property donde se encontró el dato
      * tnRecordLen               (@!    OUT) Longitud del registro del dato
      * tcBinRecord               (@!    OUT) Registro de datos de la propiedad indicada
      * tnLenCCode                (@!    OUT) Longitud del valor de la propiedad indicada
      * tnPropertyID              (@!    OUT) ID de la propiedad indicada
      *---------------------------------------------------------------------------------------------------
      Lparameters tcProperty, tcInfo, tnLastPos, tnRecordLen, tcBinRecord, tnLenCCode, tnPropertyID

      Try
         Local lnSerchedDataCC, llFound ;
            , loEx As Exception

         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            tnLastPos       = 1
            lnSerchedDataCC = .getDBCPropertyIDByName( tcProperty, .T. )

            Do While tnLastPos < Len(tcInfo)
               * Estructura de tcBinRecord
               * ----------------------
               * |RLen|LC|ID|Value    |
               * ----------------------

               tnRecordLen     = CToBin( Substr(tcInfo, tnLastPos, 4), "4RS" )
               tcBinRecord     = Substr(tcInfo, tnLastPos, tnRecordLen)
               tnLenCCode      = CToBin( Substr(tcBinRecord, 4+1, 2), "2RS" )
               tnPropertyID    = Asc( Substr(tcBinRecord, 4+2+1, tnLenCCode) )

               If tnPropertyID = lnSerchedDataCC
                  llFound = .T.
                  Exit
               Endif

               tnLastPos   = tnLastPos + tnRecordLen
            Enddo
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return llFound
   Endproc


   Procedure getBinPropertyDataRecord
      Lparameters teData, tnPropertyID
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * teData                    (v! IN    ) Dato a codificar
      * tnPropertyID              (v! IN    ) ID de la propiedad a la que pertenece
      *---------------------------------------------------------------------------------------------------

      Try
         Local lcBinRecord, lnLen, lcDataType

         * Estructura de tcBinRecord
         * ----------------------
         * |RLen|LC|ID|Value    |
         * ----------------------

         lcBinRecord = ''
         lcDataType  = This.getDBCPropertyValueTypeByPropertyID( tnPropertyID )

         Do Case
         Case lcDataType = 'B'
            teData          = Chr(teData)
            lnLen           = 4 + 2 + 1 + 1
            lcBinRecord     = BinToC( lnLen, "4RS" ) + BinToC( 1, "2RS" ) + Chr(tnPropertyID) + teData

         Case lcDataType = 'L'
            teData          = BinToC( Iif(teData,1,0), "1S" )
            lnLen           = 4 + 2 + 1 + 1
            lcBinRecord     = BinToC( lnLen, "4RS" ) + BinToC( 1, "2RS" ) + Chr(tnPropertyID) + teData

         Case lcDataType = 'N'
            teData          = BinToC( teData, "4S" )
            lnLen           = 4 + 2 + 1 + 4
            lcBinRecord     = BinToC( lnLen, "4RS" ) + BinToC( 1, "2RS" ) + Chr(tnPropertyID) + teData

         Otherwise   && Asume 'C'
            If Empty(teData)
               Exit
            Endif
            lnLen           = 4 + 2 + 1 + Len(teData) + 1
            lcBinRecord     = BinToC( lnLen, "4RS" ) + BinToC( 1, "2RS" ) + Chr(tnPropertyID) + teData + Chr(0)

         Endcase


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcBinRecord
   Endproc


   Procedure getID
      Return This.__ObjectID
   Endproc


   Procedure getCodeMemo
      Return ''
   Endproc


   Procedure getUserMemo
      Return ''
   Endproc


   Procedure getBinMemoFromProperties
      Return ''
   Endproc


   Procedure getReferentialIntegrityInfo
      Return ''
   Endproc


   Procedure getObjectType
      Local lcType

      With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
         Do Case
         Case .Class == 'Cl_dbc'
            lcType  = 'Database'

         Case .Class == 'Cl_dbc_connection'
            lcType  = 'Connection'

         Case .Class == 'Cl_dbc_table'
            lcType  = 'Table'

         Case .Class == 'Cl_dbc_view'
            lcType  = 'View'

         Case .Class == 'Cl_dbc_index_db' Or .Class == 'Cl_dbc_index_vw'
            lcType  = 'Index'

         Case .Class == 'Cl_dbc_relation'
            lcType  = 'Relation'

         Case .Class == 'Cl_dbc_field_db' Or .Class == 'Cl_dbc_field_vw'
            lcType  = 'Field'

         Otherwise
            *ERROR 'Clase [' + .CLASS + '] desconocida'
            Error (Textmerge(C_UNKNOWN_CLASS_NAME_LOC))

         Endcase
      Endwith && THIS

      Return lcType
   Endproc


   Procedure readNext_DBC_HeaderDataRecord
      Lparameters tcHeader, tnPos, tnLen, tnID, tcDataType, tcPropName, teData

      Local lnOffset, llRetorno

      Try
         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            tnPos       = Evl(tnPos,1)

            If tnPos >= Len(tcHeader) Then
               Exit
            Endif

            tnLen       = CToBin( Substr(tcHeader, tnPos, 4), '4RS' )
            tnID        = Asc( Substr(tcHeader, tnPos + 4 + 2, 1) )
            tcDataType  = .getDBCPropertyValueTypeByPropertyID(tnID)
            lnOffset    = Iif(tcDataType = 'C', 1, 0)
            tcPropName  = .getDBCPropertyNameByID(tnID, .T.)
            teData      = Substr(tcHeader, tnPos + 4 + 2 + 1, tnLen - 4 - 2 - 1 - lnOffset)

            Do Case
            Case tcDataType = 'B'
               teData          = Asc(teData)

            Case tcDataType = 'L'
               teData          = ( CToBin( teData, "1S" ) = 1 )

            Case tcDataType = 'N'
               teData          = CToBin( teData, "4S" )

            Endcase

            tnPos       = tnPos + tnLen
            llRetorno   = .T.
         Endwith
      Endtry

      Return llRetorno
   Endproc


   Procedure read_DBC_Header
      Local lnLen, lnID, leData, lcHeader, lnPos, lcPropName, lcDataType, lnOffset

      Try
         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            Go Top In TABLABIN
            lcHeader    = TABLABIN.Property
            ._Name  = Upper( Justfname( Dbf("TABLABIN") ) )

            Do While .readNext_DBC_HeaderDataRecord( @lcHeader, @lnPos, @lnLen, @lnID, @lcDataType, @lcPropName, @leData )
               .AddProperty( '_' + lcPropName, leData )
            Enddo

         Endwith
      Endtry
   Endproc


   Procedure setNextID
      Lparameters tnLastID
      tnLastID    = tnLastID + 1
      This.__ObjectID = tnLastID
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
         Local lcMemoWithProperties, lcCodeMemo, lcObjectType, lcRI_Info, lcUserMemo, lcID

         With This As CL_DBC_BASE Of 'cl_dbc_base.prg'
            .setNextID( @tnLastID )
            lcMemoWithProperties    = .getBinMemoFromProperties()
            lcCodeMemo              = .getCodeMemo()
            lcObjectType            = .getObjectType()
            lcRI_Info               = .getReferentialIntegrityInfo()
            lcUserMemo              = .getUserMemo()
            lcID                    = .getID()

            Insert Into TABLABIN ;
               ( ObjectID ;
               , ParentId ;
               , ObjectType ;
               , OBJECTNAME ;
               , Property ;
               , Code ;
               , RIInfo ;
               , User ) ;
               VALUES ;
               ( lcID ;
               , tnParentID ;
               , lcObjectType ;
               , Iif(lcObjectType == 'View', ._Name, Lower(._Name)) ;
               , lcMemoWithProperties ;
               , lcCodeMemo ;
               , lcRI_Info ;
               , lcUserMemo )
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return
   Endproc

Enddefine
