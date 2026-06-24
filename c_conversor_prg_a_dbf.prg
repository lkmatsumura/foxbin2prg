#INCLUDE foxbin2prg.h

Define Class c_conversor_prg_a_dbf As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
   #If .F.
      Local This As c_conversor_prg_a_dbf Of 'c_conversor_prg_a_dbf.prg'
   #Endif
   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzecodeblock_table" display="analyzeCodeBlock_TABLE"/>] ;
      + [<memberdata name="analyzecodeblock_fields" display="analyzeCodeBlock_FIELDS"/>] ;
      + [<memberdata name="analyzecodeblockC_CDX_I" display="analyzeCodeBlock_INDEXES"/>] ;
      + [<memberdata name="writebinaryfile_structure" display="writeBinaryFile_STRUCTURE"/>] ;
      + [<memberdata name="writebinaryfile_indexes" display="writeBinaryFile_INDEXES"/>] ;
      + [</VFPData>]
   c_Type                  = 'DB2'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toTable                   (!@    OUT) Objeto generado de clase CL_TABLE con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toTable, toEx As Exception, toFoxBin2Prg
      DoDefault( @toTable, @toEx, @toFoxBin2Prg )

      #If .F.
         Local toTable As CL_DBF_TABLE Of 'cl_dbf_table.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lnCodError, loEx As Exception, laCodeLines(1), lnCodeLines, laLineasExclusion(1), lnBloquesExclusion, I ;
            , lnIDInputFile, laConfig(1), lcConfigItem, lc_DBF_Conversion_Support, lcAlterTable ;
            , loLang As CL_LANG Of 'cl_lang.prg' ;
            , lcTempDBC, llImportData ;
            , ln_DBF_Conversion_Support
         Store 0 To lnCodError, lnCodeLines

         With This As c_conversor_prg_a_dbf Of 'c_conversor_prg_a_dbf.prg'
            lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles
            loLang              = _Screen.o_FoxBin2Prg_Lang

            *-- DBF settings from session CFG
            toFoxBin2Prg.writeLogDbfCfgSettings(.T.)
            lcTempDBC   = Forcepath( '_FB2P', Justpath(.c_OutputFile) )

            ln_DBF_Conversion_Support = toFoxBin2Prg.getCfgValue('n_DBF_Conversion_Support')

            Do Case
            Case Not Inlist(ln_DBF_Conversion_Support, 2, 8)
               With toFoxBin2Prg
                  Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               Endwith

               *!*                         Case lnFileCount = 1 And loDBF_CFG.n_DBF_Conversion_Support > 0 && Implica 2 u 8
               *!*                             llImportData    = (loDBF_CFG.n_DBF_Conversion_Support = 8)

               *                       Case toFoxBin2Prg.getCfgValue('n_DBF_Conversion_Support') = 8  && TXT2BIN (DATA IMPORT)
            Case ln_DBF_Conversion_Support = 8  && TXT2BIN (DATA IMPORT)
               llImportData    = .T.

               *!*                         Case toFoxBin2Prg.getCfgValue('n_DBF_Conversion_Support') <> 2
               *!*                             With toFoxBin2Prg
               *!*                                 Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
               *!*                             Endwith

            Otherwise
               * Asume llImportData = .F.

            Endcase

            If Not toFoxBin2Prg.l_ProcessFiles Then
               *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
               If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                  toFoxBin2Prg.updateProcessedFile()
               Endif

               Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
            Endif

            C_FB2PRG_CODE       = toFoxBin2Prg.readTextFile( .c_InputFile )
            lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

            toFoxBin2Prg.doBackup( .F., .T., '', '', '' )

            *-- Identifico el inicio/fin de bloque, campos e índices de la tabla
            .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toTable )

            Do Case
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_I1'
               Error 'InputFile Error Simulation'
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_I0'
               .writeErrorLog( '*** SIMULATED ERROR' )
            Endcase

            If .l_Error
               .writeLog( '*** ERRORS found - Generation Cancelled' )
               Exit
            Endif

            toFoxBin2Prg.updateProcessedFile( lnIDInputFile )
            .writeBinaryFile_STRUCTURE( @toTable, @toFoxBin2Prg, @lcAlterTable )

            If llImportData And lnCodeLines > 1 And toTable._I > 1 Then
               *-- Identifico los registros de la tabla y los agrego
               I = toTable._I - 1

               *!* Changed by: LScheffler 21.02.2021
               *!* change date="{^2021-02-21,10:57:00}"
               * additional options controlling
               * - new operations of DBF
               toTable.analyzeCodeBlock( C_TABLE_I, @laCodeLines, @m.I, lnCodeLines, @toFoxBin2Prg,;
                  toFoxBin2Prg.getCfgValue('l_DBF_BinChar_Base64'),;
                  toFoxBin2Prg.getCfgValue('l_DBF_IncludeDeleted') )
               *!* /Changed by: LScheffler 21.02.2021

            Endif

            If Not Empty(lcAlterTable)
               Execscript(lcAlterTable)
            Endif

            .writeBinaryFile_INDEXES( @toTable, @toFoxBin2Prg )

         Endwith && THIS


      Catch To loEx
         lnCodError  = loEx.ErrorNo

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Use In (Select(Juststem(This.c_OutputFile)))

         If Not Empty(lcTempDBC)
            Close Databases
            Erase (Forceext(lcTempDBC,'DBC'))
            Erase (Forceext(lcTempDBC,'DCT'))
            Erase (Forceext(lcTempDBC,'DCX'))
         Endif

      Endtry

      Return lnCodError
   Endproc



   Procedure writeBinaryFile_STRUCTURE
      Lparameters toTable, toFoxBin2Prg, tcAlterTable
      *-- -----------------------------------------------------------------------------------------------------------
      #If .F.
         Local toTable As CL_DBF_TABLE Of 'cl_dbf_table.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, lnCodError, loEx As Exception ;
            , loField As CL_DBF_FIELD Of 'cl_dbf_field.prg' ;
            , loDBFUtils As CL_DBF_UTILS Of 'cl_dbf_utils.prg' ;
            , lcCreateTable, lcLongDec, lcFieldDef, lcIndex, lcTempDBC, lnDataSessionID, lnSelect

         With This As c_conversor_prg_a_dbf Of 'c_conversor_prg_a_dbf.prg'
            Store .Null. To loField, loIndex, loDBFUtils
            loDBFUtils          = NewObject('CL_DBF_UTILS', 'cl_dbf_utils.prg')

            Store 0 To lnCodError
            Store '' To lcIndex, lcFieldDef, tcAlterTable
            lnDataSessionID = toFoxBin2Prg.DataSessionId

            *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
            toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

            Do Case
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
               Error 'OutputFile Error Simulation'
            Endcase

            Erase (Forceext(.c_OutputFile, 'DBF'))
            Erase (Forceext(.c_OutputFile, 'FPT'))
            Erase (Forceext(.c_OutputFile, 'CDX'))

            If Empty(toTable._Database)
               lcCreateTable   = 'CREATE TABLE "' + .c_OutputFile + '" FREE CodePage=' + toTable._CodePage + ' ;' + CR_LF + ' ('
            Else
               lcTempDBC   = Forcepath( '_FB2P', Justpath(.c_OutputFile) )
               Create Database ( lcTempDBC )
               lcCreateTable   = 'CREATE TABLE "' + .c_OutputFile + '" CodePage=' + toTable._CodePage + ' ;' + CR_LF + ' ('
            Endif

            toTable._TableName  = .c_OutputFile

            *-- Conformo los campos
            For Each loField In toTable._Fields FoxObject
               lcLongDec       = ''

               If Not Empty(lcFieldDef)
                  lcFieldDef  = lcFieldDef + ';' + CR_LF + ', '
               Endif

               *-- Nombre, Tipo
               lcFieldDef  = lcFieldDef + '"' + loField._Name + '" ' + loField._Type

               *-- Longitud
               If Inlist( loField._Type, 'C', 'N', 'F', 'Q', 'V' )
                  lcLongDec   = lcLongDec + '(' + loField._Width
               Endif

               *-- Decimales
               If Inlist( loField._Type, 'N', 'F' ) And loField._Decimals > '0' Or loField._Type = 'B'
                  If Empty(lcLongDec)
                     lcLongDec   = lcLongDec + '('
                  Else
                     lcLongDec   = lcLongDec + ','
                  Endif
                  lcLongDec   = lcLongDec + loField._Decimals
               Endif

               If Not Empty(lcLongDec)
                  lcLongDec   = lcLongDec + ')'
               Endif

               lcFieldDef  = lcFieldDef + lcLongDec

               *-- .Null.
               lcFieldDef  = lcFieldDef + Iif( loField._Null = '.T.', ' Null', ' NOT Null' )

               *-- NoCPTran
               If loField._NoCPTran = '.T.'
                  lcFieldDef  = lcFieldDef + ' NOCPTRANS'
               Endif

               *-- AutoInc
               If loField._AutoInc_NextVal <> '0'
                  If toFoxBin2Prg.getCfgValue('n_ExcludeDBFAutoincNextval') = 1
                     *-- If AutoIncNextVal is excluded from text, then assign 1 for allowing regeneration
                     *-- of DBF with this field.
                     tcAlterTable    = tcAlterTable + ' ;' + CR_LF + ' ALTER ' + loField._Name + ' ' + loField._Type + ' AUTOINC NEXTVAL 1 STEP ' + loField._AutoInc_Step
                  Else
                     tcAlterTable    = tcAlterTable + ' ;' + CR_LF + ' ALTER ' + loField._Name + ' ' + loField._Type + ' AUTOINC NEXTVAL ' + loField._AutoInc_NextVal + ' STEP ' + loField._AutoInc_Step
                  Endif
               Endif

               loField         = .Null.
            Endfor

            lcCreateTable   = lcCreateTable + lcFieldDef + ')'
            Execscript(lcCreateTable)

            If Not Empty(tcAlterTable)
               tcAlterTable    = 'ALTER TABLE "' + .c_OutputFile + '" ' + tcAlterTable
            Endif

            *-- Hook para permitir ejecución externa (por ejemplo, para rellenar la tabla con datos)
            If Not Empty(toFoxBin2Prg.run_AfterCreateTable)
               lnSelect    = Select()
               Do (toFoxBin2Prg.run_AfterCreateTable) With (lnDataSessionID), (.c_OutputFile), (toTable)
               Set DataSession To (lnDataSessionID)    && Por las dudas externamente se cambie
               Select (lnSelect)
            Endif

         Endwith && THIS


      Catch To loEx
         lnCodError      = loEx.ErrorNo
         toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )
         loEx.UserValue  = 'lcFieldDef="' + Transform(lcFieldDef) + '"' + CR_LF ;
            + 'lcCreateTable="' + Transform(lcCreateTable) + '"'

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loField, loDBFUtils
         Release I, loField, loDBFUtils ;
            , lcCreateTable, lcLongDec, lcFieldDef, lcTempDBC, lnDataSessionID, lnSelect

      Endtry

      Return lnCodError
   Endproc


   * LScheffler
   Procedure writeBinaryFile_INDEXES
      Lparameters toTable, toFoxBin2Prg
      *-- -----------------------------------------------------------------------------------------------------------
      #If .F.
         Local toTable As CL_DBF_TABLE Of 'cl_dbf_table.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, lnCodError, loEx As Exception ;
            , loIndex As CL_DBF_INDEX Of 'cl_dbf_index.prg' ;
            , loDBFUtils As CL_DBF_UTILS Of 'cl_dbf_utils.prg' ;
            , loLang As CL_LANG Of 'cl_lang.prg' ;
            , ldLastUpdate ;
            , lcIndexFile

         With This As c_conversor_prg_a_dbf Of 'c_conversor_prg_a_dbf.prg'
            Store .Null. To loIndex
            Store 0 To lnCodError
            Store '' To lcIndex
            Store .Null. To lcIndexFile

            loDBFUtils          = NewObject('CL_DBF_UTILS', 'cl_dbf_utils.prg')

            If toTable._Indexes.Count # 0 Then

               loLang          = _Screen.o_FoxBin2Prg_Lang
               toFoxBin2Prg.writeLog( Replicate('+', 100) )
               toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_PROCESSING_LOC )
               toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )

               *-- Regenero los índices
               For Each loIndex In toTable._Indexes FoxObject
                  Do Case
                  Case Isnull ( m.lcIndexFile ) And Empty (m.loIndex._IndexFile)
                     toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_STRUCTURAL_LOC )
                     toFoxBin2Prg.writeLog( ' ' + Replicate('- ', 49) )

                  Case Isnull ( m.lcIndexFile ) And m.loIndex._StandAlone
                     toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_STANDALONE_LOC + m.loIndex._IndexFile )

                  Case Isnull ( m.lcIndexFile )
                     toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_COMPOUND_LOC + m.loIndex._IndexFile )
                     toFoxBin2Prg.writeLog( ' ' + Replicate('- ', 59) )

                  Case ! m.lcIndexFile == m.loIndex._IndexFile And m.loIndex._StandAlone
                     toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )
                     toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_STANDALONE_LOC + m.loIndex._IndexFile )

                  Case ! m.lcIndexFile == m.loIndex._IndexFile
                     toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )
                     toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_COMPOUND_LOC + m.loIndex._IndexFile )
                     toFoxBin2Prg.writeLog( ' ' + Replicate('- ', 59) )
                  Endcase
                  lcIndexFile = m.loIndex._IndexFile

                  lcIndex = 'INDEX ON ' + loIndex._Key

                  If loIndex._TagType = 'BINARY'
                     lcIndex = lcIndex + ' BINARY'
                  Else
                     lcIndex = lcIndex + ' COLLATE "' + loIndex._Collate + '"'

                     If Not Empty(loIndex._Filter)
                        lcIndex = lcIndex + ' FOR ' + loIndex._Filter
                     Endif

                     lcIndex = lcIndex + ' ' + loIndex._Order

                     If Not Inlist(loIndex._TagType, 'NORMAL', 'REGULAR')
                        *-- Si es PRIMARY lo cambio a CANDIDATE y luego lo recodifico
                        lcIndex = lcIndex + ' ' + Strtran( loIndex._TagType, 'PRIMARY', 'CANDIDATE' )
                     Endif
                  Endif

                  If m.loIndex._StandAlone Then
                     lcIndex = m.lcIndex + ' TO ' +  m.lcIndexFile
                  Else  &&m.loIndex._StandAlone
                     lcIndex = m.lcIndex + ' TAG ' + loIndex._TagName + Iif( Empty( m.lcIndexFile ), '', ' OF ' + m.lcIndexFile )
                     toFoxBin2Prg.writeLog( '   ' + m.loIndex._TagName )
                  Endif &&m.loIndex._StandAlone

                  &lcIndex.
               Endfor

               toFoxBin2Prg.writeLog( Replicate('+', 100) + CR_LF )

            Endif &&toTable._Indexes.COUNT # 0

            Use In (Select(Juststem(.c_OutputFile)))

            *-- La actualización de la fecha sirve para evitar diferencias al regenerar el DBF
            If toFoxBin2Prg.getCfgValue('l_ClearDBFLastUpdate') Then
               ldLastUpdate    = Evaluate( '{^2013/11/04}' )
            Else
               ldLastUpdate    = Evaluate( '{^' + toTable._LastUpdate + '}' )
            Endif

            loDBFUtils.write_DBC_BackLink( .c_OutputFile, toTable._Database, ldLastUpdate )

            toFoxBin2Prg.updateProcessedFile()

            toFoxBin2Prg.writeLog( Replicate('+', 100) )
         Endwith && THIS


      Catch To loEx
         lnCodError      = loEx.ErrorNo
         toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )
         loEx.UserValue  = 'lcIndex="' + Transform(lcIndex) + '"'

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loIndex
         Release I, loIndex, lcIndex, ldLastUpdate

      Endtry

      Return lnCodError
   Endproc



   Procedure identifyCodeBlocks
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (!@ IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (!@ IN    ) Cantidad de líneas de código
      * taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@? IN    ) Sin uso
      * toTable                   (@?    OUT) Objeto con toda la información de la tabla analizada
      *--------------------------------------------------------------------------------------------------------------
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toTable

      External Array taCodeLines, taLineasExclusion

      #If .F.
         Local toTable As CL_DBF_TABLE Of 'cl_dbf_table.prg'
      #Endif

      Try
         Local I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueTable_Completed
         Store 0 To I

         With This As c_conversor_prg_a_dbf Of 'c_conversor_prg_a_dbf.prg'
            .c_Type = Upper(Justext(.c_OutputFile))

            If tnCodeLines > 1
               toTable     = .Null.
               toTable     = NewObject('CL_DBF_TABLE', 'cl_dbf_table.prg')

               For I = 1 To tnCodeLines
                  .set_Line( @lcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Vacía o solo Comentarios
                     Loop

                  Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( toTable, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     llFoxBin2Prg_Completed  = .T.

                  Case Not llBloqueTable_Completed And toTable.analyzeCodeBlock( @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     llBloqueTable_Completed = .T.
                     Exit

                  Endcase
               Endfor
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toTable ;
            , I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueTable_Completed
      Endtry

      Return
   Endproc


Enddefine
