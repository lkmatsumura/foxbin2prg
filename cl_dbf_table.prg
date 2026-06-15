#INCLUDE foxbin2prg.h

Define Class CL_DBF_TABLE As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_DBF_TABLE Of 'cl_dbf_table.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_codepage" display="_CodePage"/>] ;
      + [<memberdata name="_cpid" display="_CPID"/>] ;
      + [<memberdata name="_database" display="_Database"/>] ;
      + [<memberdata name="_filetype" display="_FileType"/>] ;
      + [<memberdata name="_filetype_descrip" display="_FileType_Descrip"/>] ;
      + [<memberdata name="_indexfile" display="_IndexFile"/>] ;
      + [<memberdata name="_memofile" display="_MemoFile"/>] ;
      + [<memberdata name="_lastupdate" display="_LastUpdate"/>] ;
      + [<memberdata name="_fields" display="_Fields"/>] ;
      + [<memberdata name="_indexes" display="_Indexes"/>] ;
      + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
      + [<memberdata name="_version" display="_Version"/>] ;
      + [<memberdata name="_fields" display="_Fields"/>] ;
      + [<memberdata name="_indexes" display="_Indexes"/>] ;
      + [<memberdata name="_i" display="_I"/>] ;
      + [<memberdata name="_tablename" display="_TableName"/>] ;
      + [</VFPData>]


   *-- Modulo
   _Version            = 0
   _SourceFile         = ''
   *LScheffler 20.08.2023
   *issue #96, [KestasL] keep CodePage relavant information for binary sources
   _cpid               = Cpcurrent()
   _I                  = 0

   *-- Table Info
   _TableName          = ''
   _CodePage           = 0
   _Database           = ''
   _FileType           = ''
   _FileType_Descrip   = ''
   _IndexFile          = ''
   _MemoFile           = ''
   _LastUpdate         = {}

   *-- Fields and Indexes
   *_Fields                = .Null.
   *_Indexes           = .Null.


   Procedure Init
      DoDefault()
      *--
      This.AddObject("_Fields", "CL_DBF_FIELDS")
      This.AddObject("_Indexes", "CL_DBF_INDEXES")
      *** DH 06/02/2014: added _Records
      This.AddObject("_Records", "CL_DBF_RECORDS")
   Endproc


   Procedure analyzeCodeBlock
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      * tl_DBF_BinChar_Base64     out of settings (folder or per-file) Transform NocPTrans fields base64
      * tl_DBF_IncludeDeleted     out of settings (folder or per-file) Include deleted records
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines, toFoxBin2Prg, tl_DBF_BinChar_Base64, tl_DBF_IncludeDeleted
      External Array taCodeLines

      Try
         Local llBloqueEncontrado, lcPropName, lcValue, llFieldsEvaluated, llIndexesEvaluated ;
            , loEx As Exception ;
            , loFields As CL_DBF_FIELDS Of 'cl_dbf_fields.prg' ;
            , loIndexes As CL_DBF_INDEXES Of 'cl_dbf_indexes.prg' ;
            , loRecords As CL_DBF_RECORDS Of 'cl_dbf_records.prg'
         Store .Null. To loIndexes, loFields, loRecords
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_TABLE_I)) == C_TABLE_I
            llBloqueEncontrado  = .T.

            With This As CL_DBF_TABLE Of 'cl_dbf_table.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_TABLE_F $ tcLine && Fin
                     Exit

                  Case C_CDX_F $ tcLine   && End of index file, temporary ignore
                     Loop

                  Case Not llFieldsEvaluated And C_FIELDS_I $ tcLine
                     loFields    = ._Fields
                     loFields.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     llFieldsEvaluated   = .T.

                     * new style, multiple index files
                  Case Not llIndexesEvaluated And C_CDXIDX_I $ tcLine
                     loIndexes   = ._Indexes
                     loIndexes.analyzeIndexFilesBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     llIndexesEvaluated  = .T.

                  Case Not llIndexesEvaluated And C_INDEXES_I $ tcLine
                     loIndexes   = ._Indexes
                     loIndexes.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                     llIndexesEvaluated  = .T.

                  Case C_RECORDS_I $ tcLine
                     If llFieldsEvaluated
                        * Pensado para poder llamar a este método 2 veces:
                        * > La 1ra.para evaluar Campos e Indices, y poder crear la estructura de la tabla
                        *   al finalizar este paso.
                        * > La 2da.para cargar los registros, luego de que se haya creado la tabla,
                        *   así se van volcando directamente y no se guardan en memoria.
                        Exit
                     Endif

                     loRecords   = ._Records
                     *!* Changed by: LScheffler 21.02.2021
                     *!* change date="{^2021-02-21,10:57:00}"
                     * additional options controlling
                     * - new operations of DBF
                     loRecords.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, ._Fields, @toFoxBin2Prg,;
                        tl_DBF_BinChar_Base64, tl_DBF_IncludeDeleted )
                     *!* /Changed by: LScheffler 21.02.2021
                  Otherwise   && Otro valor
                     *-- Estructura a reconocer:
                     *   <tagname>ID<tagname>
                     lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                     lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                     .AddProperty( '_' + lcPropName, lcValue )
                  Endcase
               Endfor

               ._I = m.I
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
         Store .Null. To loIndexes, loFields, loRecords
         Release lcPropName, lcValue, loFields, loIndexes, loRecords

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_FileTypeDesc           (v! IN    ) Tipo de archivo (en Hex)
      * tl_FileHasCDX             (v! IN    ) Indica si el archivo tiene CDX asociado
      * tl_FileHasMemo            (v! IN    ) Indica si el archivo tiene MEMO (FPT) asociado
      * tl_FileIsDBC              (v! IN    ) Indica si el archivo es un DBC
      * tc_DBC_Name               (v! IN    ) Nombre del DBC (si tiene)
      * tc_InputFile              (v! IN    ) Nombre del archivo de salida
      * tc_FileTypeDesc           (v! IN    ) Descripción del Tipo de archivo
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      *---------------------------------------------------------------------------------------------------
      Lparameters tn_HexFileType, tl_FileHasCDX, tl_FileHasMemo, tl_FileIsDBC, tc_DBC_Name, tc_InputFile, tc_FileTypeDesc, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcText, lcIndexKey, lcIndexFile, laConfig(1), lcValue, lcConfigItem ;
            , lc_DBF_Conversion_Order, lc_DBF_Conversion_Condition, lc_DBF_IndexList, llExportData, laDirFile(1,5), lnFileCount ;
            , loEx As Exception ;
            , loFSO As Scripting.FileSystemObject ;
            , loTextStream As Scripting.TextStream ;
            , loDBF_CFG As CL_DBF_CFG Of 'cl_dbf_cfg.prg' ;
            , loRecords As CL_DBF_RECORDS Of 'cl_dbf_records.prg' ;
            , loFields As CL_DBF_FIELDS Of 'cl_dbf_fields.prg' ;
            , loIndexes As CL_DBF_INDEXES Of 'cl_dbf_indexes.prg', ln_DBF_Conversion_Support

         *** DH 06/02/2014: created variables
         Local laFields[1], lnFieldCount
         loFSO           = toFoxBin2Prg.o_FSO
         loTextStream    = toFoxBin2Prg.o_TextStream
         Store .Null. To loIndexes, loFields, loRecords
         Store 0 To lnFileCount
         lcText  = ''

         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<>>
                <<C_TABLE_I>>
                <<chr(9)>><MemoFile><<IIF( tl_FileHasMemo, FORCEEXT(tc_InputFile, 'FPT'), '' )>></MemoFile>
                <<chr(9)>><CodePage><<Cpdbf('TABLABIN')>></CodePage>
                <<chr(9)>><LastUpdate><<IIF( toFoxBin2Prg.getCfgValue('l_ClearDBFLastUpdate'), '', LUPDATE('TABLABIN') )>></LastUpdate>
                <<chr(9)>><Database><<tc_DBC_Name>></Database>
                <<chr(9)>><FileType><<TRANSFORM(tn_HexFileType, '@0')>></FileType>
                <<chr(9)>><FileType_Descrip><<tc_FileTypeDesc>></FileType_Descrip>
         ENDTEXT

         *-- Fields
         loFields    = This._Fields

         *** DH 06/02/2014: passed variables to toText
         lcText      = lcText + loFields.toText(@laFields, @lnFieldCount, @toFoxBin2Prg)

         *-- If table CFG exists, use it for DBF-specific configuration. FDBOZZO. 2014/06/15
         loDBF_CFG   = NewObject('CL_DBF_CFG', 'cl_dbf_cfg.prg')
         loDBF_CFG   = loDBF_CFG.FromFile( Forceext(tc_InputFile, 'DBF'), .T., toFoxBin2Prg )
         lnFileCount = IIF(VARTYPE(loDBF_CFG) = 'O' AND !ISNULL(loDBF_CFG), 1, 0)

         ln_DBF_Conversion_Support = Iif(Isnull(loDBF_CFG), toFoxBin2Prg.getCfgValue('n_DBF_Conversion_Support'), loDBF_CFG.n_DBF_Conversion_Support )

         Do Case
         Case Inlist(ln_DBF_Conversion_Support, 4, 8)
            *-- Si hay un archivo DBF.CFG, manda sobre la configuración general
            llExportData        = .T.

         Case ln_DBF_Conversion_Support > 0
            *-- Si hay un archivo DBF.CFG, manda sobre la configuración general
            * Asume llExportData=.F.

            *!*                     Case Inlist(toFoxBin2Prg.getCfgValue('n_DBF_Conversion_Support'), 4, 8)    && BIN2TXT (DATA EXPORT FOR DIFF)
            *!*                         llExportData        = .T.

         Otherwise
            * Asume llExportData=.F.

         Endcase

         * LScheffler 18.03.2021 added handling DBF_IndexList:
         If lnFileCount = 1
            lc_DBF_IndexList = loDBF_CFG.DBF_IndexList
            If Not Empty(lc_DBF_IndexList)
               toFoxBin2Prg.writeLog('  > Using non structural index files: ' + lc_DBF_IndexList)
            Endif

         Endif

         * LScheffler 18.03.2021 moved index to get Settings per DBF
         *-- Indexes
         loIndexes   = This._Indexes
         lcText      = lcText + loIndexes.toText( '', '', tc_InputFile, @toFoxBin2Prg, lc_DBF_IndexList)
         * /LScheffler 18.03.2021

         * setting temporary order
         If llExportData Then
            If lnFileCount = 1
               lc_DBF_Conversion_Order     = loDBF_CFG.DBF_Conversion_Order

               If Not Empty(lc_DBF_Conversion_Order)
                  lcIndexFile = Forceext(tc_InputFile,'IDX')
                  Index On &lc_DBF_Conversion_Order. To (lcIndexFile) Compact
                  toFoxBin2Prg.writeLog('  > Using Index order key:            ' + lc_DBF_Conversion_Order)
               Endif
               * LScheffler 18.03.2021 added handling DBF_Conversion_Condition:
               lc_DBF_Conversion_Condition = loDBF_CFG.DBF_Conversion_Condition
               If Not Empty(lc_DBF_Conversion_Condition)
                  toFoxBin2Prg.writeLog('  > Using Conversion Condition:       ' + lc_DBF_Conversion_Condition)
               Endif
               * /LScheffler 18.03.2021

            Endif
         Endif
         * /setting temporary order

         *** DH 06/02/2014: added _Records
         If llExportData
            loRecords   = This._Records
            *FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
            loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
            *!* Changed by: LScheffler 21.02.2021
            *!* change date="{^2021-02-21,10:57:00}"
            * additional options controlling
            * - new operations of DBF
            loRecords.toText(@laFields, lnFieldCount, lc_DBF_Conversion_Condition, @toFoxBin2Prg,;
               IIF( m.lnFileCount = 1, Nvl( m.loDBF_CFG.l_DBF_BinChar_Base64, m.toFoxBin2Prg.getCfgValue('l_DBF_BinChar_Base64') ), m.toFoxBin2Prg.getCfgValue('l_DBF_BinChar_Base64') ),;
               IIF( m.lnFileCount = 1, Nvl( m.loDBF_CFG.l_DBF_IncludeDeleted, m.toFoxBin2Prg.getCfgValue('l_DBF_IncludeDeleted') ), m.toFoxBin2Prg.getCfgValue('l_DBF_IncludeDeleted') ))
            *!* /Changed by: LScheffler 21.02.2021
            lcText  = ''
         Endif

         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<C_TABLE_F>>
                <<>>
         ENDTEXT

         *FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
         loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
         lcText  = ''


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         * remove temporary order
         If Not Empty(lcIndexFile) And File(lcIndexFile)
            Set Index To
            Erase (lcIndexFile)
         Endif
         * /remove temporary order

         Store .Null. To loIndexes, loFields, loRecords, loDBF_CFG, loTextStream
         Release loFields, loIndexes, loRecords, loDBF_CFG, loTextStream
      Endtry

      Return lcText
   Endproc


Enddefine
