#INCLUDE foxbin2prg.h

Define Class c_conversor_dbf_a_prg As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   #If .F.
      Local This As c_conversor_dbf_a_prg Of 'c_conversor_dbf_a_prg.prg'
   #Endif
   c_Type                  = 'DBF'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@    OUT) Contenido del texto generado
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

      *!* Changed by: LScheffler 11.2.2021
      *!* change date="{^2021-02-11,08:50:00}"
      * If toFoxBin2Prg.l_ProcessFiles is not true
      * and the try block was exited
      * the stuff below was never instatiated

      *so the whole try / catch block should not run

      If Not toFoxBin2Prg.l_ProcessFiles Then
         This.write_OutputFile( '', This.c_OutputFile, @toFoxBin2Prg )
      Else  &&NOT toFoxBin2Prg.l_ProcessFiles
         *!* /Changed by: LScheffler 11.2.2021

         Try
            With This As c_conversor_dbf_a_prg Of 'c_conversor_dbf_a_prg.prg'
               *!* Changed by: LScheffler 11.2.2021
               *!* change date="{^2021-02-11,08:50:00}"
               *moved up:
               *               IF NOT toFoxBin2Prg.l_ProcessFiles THEN
               *                   .write_OutputFile( '', .c_OutputFile, @toFoxBin2Prg )
               *                   EXIT    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
               *               ENDIF
               *!* /Changed by: LScheffler 11.2.2021

               Local lnCodError, laDatabases(1), lnDatabases_Count, laDatabases2(1) ;
                  , lnLen, lc_FileTypeDesc, laLines(1), lcOutputFile ;
                  , ln_HexFileType, ll_FileHasCDX, ll_FileHasMemo, ll_FileIsDBC ;
                  , lc_DBC_Name, lnDataSessionID, lnSelect, laDirInfo(1,5) ;
                  , llDBCEventsEnabled ;
                  , loTable As CL_DBF_TABLE Of 'cl_dbf_table.prg' ;
                  , loDBFUtils As CL_DBF_UTILS Of 'cl_dbf_utils.prg' ;
                  , loLang As CL_LANG Of 'cl_lang.prg' ;
                  , loFSO As Scripting.FileSystemObject ;
                  , loTextStream As Scripting.TextStream ;
                  , loDBC As CL_DBC Of 'cl_dbc.prg'

               loLang          = _Screen.o_FoxBin2Prg_Lang
               loFSO           = toFoxBin2Prg.o_FSO
               Store .Null. To loTable, loDBFUtils
               Store 0 To lnCodError
               loDBFUtils          = NewObject('CL_DBF_UTILS', 'cl_dbf_utils.prg')
               loDBC               = NewObject('CL_DBC', 'cl_dbc.prg')

               *-- EVALUAR OPCIONES ESPECÍFICAS DE DBF
               .updateProgressbar( 'Scanning DBF Structure...', 1, 3, 1 )

               *-- Include
               If Not Empty(toFoxBin2Prg.getCfgValue('c_DBF_Conversion_Included')) And Not toFoxBin2Prg.getCfgValue('c_DBF_Conversion_Included') == '*' ;
                     AND Not toFoxBin2Prg.filenameFoundInFilter( Justfname(.c_InputFile), toFoxBin2Prg.getCfgValue('c_DBF_Conversion_Included') )
                  toFoxBin2Prg.writeLog('  ' + Justfname(.c_InputFile) + ' no está en el filtro DBF_Conversion_Included (' + toFoxBin2Prg.getCfgValue('c_DBF_Conversion_Included') + ')' )
                  Exit
               Endif

               *-- Exclude
               If Not Empty(toFoxBin2Prg.getCfgValue('c_DBF_Conversion_Excluded')) ;
                     AND toFoxBin2Prg.filenameFoundInFilter( Justfname(.c_InputFile), toFoxBin2Prg.getCfgValue('c_DBF_Conversion_Excluded') )
                  toFoxBin2Prg.writeLog('  ' + Justfname(.c_InputFile) + ' está en el filtro DBF_Conversion_Excluded (' + toFoxBin2Prg.getCfgValue('c_DBF_Conversion_Excluded') + ')' )
                  Exit
               Endif

               loDBFUtils.getDBFmetadata( .c_InputFile, @ln_HexFileType, @ll_FileHasCDX, @ll_FileHasMemo, @ll_FileIsDBC, @lc_DBC_Name )
               lc_FileTypeDesc     = loDBFUtils.fileTypeDescription(ln_HexFileType)
               lnDatabases_Count   = Adatabases(laDatabases)

               * Si la tabla pertenece a un DBC, desactivar temporalmente los eventos
               If Not Empty(lc_DBC_Name) And Adir(laDirInfo, Fullpath(lc_DBC_Name, .c_InputFile)) = 1
                  loDBC._DBC          = Fullpath(lc_DBC_Name, .c_InputFile)
                  llDBCEventsEnabled  = loDBC.DBGetProp(lc_DBC_Name,"DATABASE","DBCEvents")

                  * llDBCEventsEnabled no siempre devuelve .T./.F., a veces devuelve ""
                  If Empty(llDBCEventsEnabled)
                     llDBCEventsEnabled  = .F.
                  Endif

                  If llDBCEventsEnabled
                     If Not loDBC.DBSetProp(lc_DBC_Name,"DATABASE","DBCEvents",.F.)
                        llDBCEventsEnabled  = .F.
                     Endif
                  Endif
               Endif
               * LScheffler
               Use (.c_InputFile) Shared Again Noupdate Alias TABLABIN
               *LScheffler 20.08.2023
               *issue #96, including issue #95, [KestasL] keep CodePage relavant information for binary sources
               toFoxBin2Prg.i_CPID = Cpdbf("TABLABIN")

               lnDataSessionID = toFoxBin2Prg.DataSessionId
               .RestoreDBCEvents(loDBC, @llDBCEventsEnabled)

               C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

               *-- Header
               loTable         = NewObject('CL_DBF_TABLE', 'cl_dbf_table.prg')

               *-- Exportación de estructura y datos (para Diff solamente)
               Erase (.c_OutputFile + '.TMP' )
               loTextStream    = loFSO.CreateTextFile(.c_OutputFile + '.TMP' )     && Replace VFP low-level file funcs.because the 8-16KB limit.
               toFoxBin2Prg.o_TextStream = loTextStream

               If toFoxBin2Prg.n_FileHandle = -1 Then
                  Error 102, (.c_OutputFile)
               Endif

               loTextStream.WriteLine( C_FB2PRG_CODE )     && Replace VFP low-level file funcs.because the 8-16KB limit.
               * LScheffler, Analyse, call table
               loTable.toText( ln_HexFileType, ll_FileHasCDX, ll_FileHasMemo, ll_FileIsDBC, lc_DBC_Name, .c_InputFile, lc_FileTypeDesc, @toFoxBin2Prg )

               loTextStream.Close()

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

               toFoxBin2Prg.updateProcessedFile()


               *-- Genero el DB2, renombrando el TMP
               .updateProgressbar( 'Writing ' + toFoxBin2Prg.getCfgValue('c_DB2') + '...', 3, 3, 1 )
               If .l_Test
                  toModulo    = C_FB2PRG_CODE
               Else
                  Do Case
                  Case Adir(laDirInfo, .c_OutputFile) > 0 And toFoxBin2Prg.comparedTextExportFilesEqual( .c_OutputFile + '.TMP', .c_OutputFile )
                     Erase (.c_OutputFile + '.TMP')
                     *.writeLog( 'El archivo de salida [' + .c_OutputFile + '] no se sobreescribe por ser igual al generado.' )
                     lcOutputFile    = .c_OutputFile
                     .writeLog( C_TAB + C_TAB + '* ' + Textmerge(loLang.C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC) )
                  Case toFoxBin2Prg.doBackup( .F., .T., '', '', '' ) ;
                        AND toFoxBin2Prg.changeFileAttribute( .c_OutputFile + '.TMP', '-R' ) > 0 ;
                        AND toFoxBin2Prg.finalizeTextExportFile( .c_OutputFile + '.TMP' ) ;
                        AND Not toFoxBin2Prg.renameTmpFile2Tx2File( .c_OutputFile )
                     *ERROR 'No se puede generar el archivo [' + .c_OutputFile + '] porque es ReadOnly'
                     Error (Textmerge(loLang.C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC))
                  Endcase
               Endif


               *-- Hook para permitir ejecución externa (por ejemplo, para exportar datos)
               If Not Empty(toFoxBin2Prg.run_AfterCreate_DB2)
                  lnSelect    = Select()
                  Do (toFoxBin2Prg.run_AfterCreate_DB2) With (lnDataSessionID), (.c_OutputFile), (loTable)
                  Set DataSession To (lnDataSessionID)    && Por las dudas externamente se cambie
                  Select (lnSelect)
               Endif

            Endwith && THIS


         Catch To toEx
            This.set_UserValue(@toEx)

            Do Case
            Case toEx.ErrorNo = 13 && Alias not found
               toEx.UserValue = toEx.UserValue + Textmerge(loLang.C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC)

               *!* CASE toEx.ErrorNo = 1976 && Cannot resolve backlink
               *!*     toEx.UserValue = 'WARNING!!' + CR_LF ;
               *!*         + "MAY BE DATABASE FIELDS DOESN'T" ;
               *!*         + UPPER(JUSTSTEM(THIS.c_InputFile)) + '.field tag keyname)' + CR_LF + CR_LF ;
               *!*         + '¡¡ATENCIÓN!!' + CR_LF ;
               *!*         + 'ASEGÚRESE DE QUE NO ESTÁ USANDO UN ALIAS DE TABLA EN LAS EXPRESIONES DE LOS ÍNDICES!! (ej: index on ' ;
               *!*         + UPPER(JUSTSTEM(THIS.c_InputFile)) + '.campo tag nombreclave)'

            Endcase
            If This.n_Debug > 0 And _vfp.StartMode = 0
               Set Step On
            Endif

            Throw

         Finally
            Use In (Select("TABLABIN"))
            This.RestoreDBCEvents(loDBC, @llDBCEventsEnabled)

            If Vartype(loTextStream) = "O" Then
               loTextStream.Close()
            Endif

            *-- Cierro DBC
            For I = 1 To Adatabases(laDatabases2)
               If Ascan( laDatabases, laDatabases2(m.I), 1, 0, 0, 1+2+4 ) = 0
                  Set Database To (laDatabases2(m.I))
                  Close Databases
                  Exit
               Endif
            Endfor

            Store .Null. To loTable, loDBFUtils, loTextStream, toFoxBin2Prg.o_TextStream
            *!* Changed by: LScheffler 11.2.2021
            *!* change date="{^2021-02-11,08:50:00}"
            * Release different, parts moved outsidef IF .. ENDIF
            Release loTextStream ;
               , lnCodError, laDatabases, lnDatabases_Count, laDatabases2, lnLen, lc_FileTypeDesc ;
               , ln_HexFileType, ll_FileHasCDX, ll_FileHasMemo, ll_FileIsDBC, lc_DBC_Name, lnDataSessionID, lnSelect ;
               , loTable, loDBFUtils
         Endtry
         *!* Changed by: LScheffler 11.2.2021
         *!* change date="{^2021-02-11,08:50:00}"
         * so the whole try / catch block should not run if in simulation

      Endif  &&NOT toFoxBin2Prg.l_ProcessFiles

      * Release  from above
      Release toModulo, toEx, toFoxBin2Prg, loTextStream ;
      *!* /Changed by: LScheffler 11.2.2021

      Return
   Endproc


   Procedure RestoreDBCEvents(toDBC, tlDBCEventsEnabled)
      #If .F.
         Local toDBC As CL_DBC Of 'cl_dbc.prg'
      #Endif
      If tlDBCEventsEnabled And Vartype(toDBC)="O"
         toDBC.DBSetProp('',"DATABASE","DBCEvents",.T.)
         tlDBCEventsEnabled  = .F.
      Endif
   Endproc

Enddefine
