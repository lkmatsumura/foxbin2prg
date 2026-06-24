#INCLUDE foxbin2prg.h

Define Class c_conversor_prg_a_dbc As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
   #If .F.
      Local This As c_conversor_prg_a_dbc Of 'c_conversor_prg_a_dbc.prg'
   #Endif
   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzecodeblock_tables" display="analyzeCodeBlock_TABLES"/>] ;
      + [<memberdata name="analyzecodeblock_views" display="analyzeCodeBlock_VIEWS"/>] ;
      + [<memberdata name="analyzecodeblock_tablefields" display="analyzeCodeBlock_TABLEFIELDS"/>] ;
      + [<memberdata name="analyzecodeblock_viewfields" display="analyzeCodeBlock_VIEWFIELDS"/>] ;
      + [<memberdata name="analyzecodeblock_relations" display="analyzeCodeBlock_RELATIONS"/>] ;
      + [<memberdata name="analyzecodeblock_connections" display="analyzeCodeBlock_CONNECTIONS"/>] ;
      + [<memberdata name="analyzecodeblock_database" display="analyzeCodeBlock_DATABASE"/>] ;
      + [<memberdata name="verify_external_members" display="verify_EXTERNAL_MEMBERS"/>] ;
      + [</VFPData>]
   c_Type                  = 'DC2'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toDatabase                (!@    OUT) Objeto generado de clase CL_DBC con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toDatabase, toEx As Exception, toFoxBin2Prg
      DoDefault( @toDatabase, @toEx, @toFoxBin2Prg )

      #If .F.
         Local toDatabase As CL_DBC Of 'cl_dbc.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lnCodError, loEx As Exception, loReg, lcLine, laCodeLines(1), lnCodeLines, lcBaseFilename, lcInputFile ;
            , lcMemberType, lcMemberName, lcLastMemberType, lnIDInputFile ;
            , laLineasExclusion(1), lnBloquesExclusion, I, X, Y, laFiles(1,5), lnFileCount, lcTempTxt, laLines(1) ;
            , loLang As CL_LANG Of 'cl_lang.prg'
         Store 0 To lnCodError, lnCodeLines, lnFileCount
         Store '' To lcLine, laLines, laCodeLines, lcBaseFilename, lcMemberType, lcLastMemberType, lcMemberName, lcInputFile
         Store .Null. To loReg, toDatabase

         With This As c_conversor_prg_a_dbc Of 'c_conversor_prg_a_dbc.prg'
            loLang              = _Screen.o_FoxBin2Prg_Lang
            toDatabase          = NewObject('CL_DBC', 'cl_dbc.prg')
            lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

            If toFoxBin2Prg.getCfgValue('n_UseFilesPerDBC') > 0 And toFoxBin2Prg.getCfgValue('l_RedirectFilePerDBCToMain')
               C_FB2PRG_CODE       = toFoxBin2Prg.readTextFile( .c_InputFile )
               lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )
               C_FB2PRG_CODE       = ''

               *-- Quito la última parte del cierre de </DATABASE> para anexar lo intermedio
               For X = 1 To lnCodeLines
                  If C_DATABASE_F $ laCodeLines(m.X) Then
                     Exit
                  Endif
                  C_FB2PRG_CODE   = C_FB2PRG_CODE + laCodeLines(m.X) + CR_LF
               Endfor

               .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
               .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toDatabase, @toFoxBin2Prg )

               .updateProgressbar( 'Loading Code...', 2, lnCodeLines, 1 )

               *-- Esto crea la máscara de búsqueda "<path>Database.*.*.ext" para encontrar las partes
               *-- con la sintaxis "<path>Database.MemberType.MemberName.ext"
               lcBaseFilename      = Juststem( Juststem( Juststem(.c_InputFile) ) )
               lcInputFile         = Addbs( Justpath(.c_InputFile) ) + lcBaseFilename + '.*.*.' + Justext(.c_InputFile)
               lnFileCount         = Adir( laFiles, lcInputFile, "", 1 )

               *-- Busco "storedprocedures" y le pongo "z" al inicio
               For I = 1 To lnFileCount
                  If Lower( laFiles(m.I,1)) == lcBaseFilename + '.database.storedproceduressource.' + Justext(.c_InputFile) Then
                     laFiles(m.I,1)  = lcBaseFilename + '.zdatabase.storedproceduressource.' + Justext(.c_InputFile)
                     Exit
                  Endif
               Endfor

               Asort( laFiles, 1, -1, 0, 1)    && "zstoredprocedures" quedará al final

               *-- Busco "zstoredprocedures" y le quito la "z" del inicio
               For I = 1 To lnFileCount
                  If Lower( laFiles(m.I,1)) == lcBaseFilename + '.zdatabase.storedproceduressource.' + Justext(.c_InputFile) Then
                     laFiles(m.I,1)  = lcBaseFilename + '.database.storedproceduressource.' + Justext(.c_InputFile)
                     Exit
                  Endif
               Endfor

               For I = 1 To lnFileCount
                  lcInputFile_Class   = Forcepath( Juststem( laFiles(m.I,1) ), Justpath( .c_InputFile ) ) + '.' + Justext( .c_InputFile )
                  lcMemberType        = Lower( Getwordnum( Justfname( lcInputFile_Class ), 2, '.' ) )
                  lcMemberName        = Lower( Getwordnum( Justfname( lcInputFile_Class ), 3, '.' ) )

                  If toFoxBin2Prg.l_ProcessFiles Then
                     If Not lcMemberType == lcLastMemberType Then
                        If Not Empty(lcLastMemberType) Then
                           *-- Cambio de tipo de miembro, fin del anterior (connection, table, view, storedprocedures)
                           Do Case
                           Case lcLastMemberType == 'connection'
                              C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_CONNECTIONS_F + CR_LF
                           Case lcLastMemberType == 'table'
                              C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_TABLES_F + CR_LF
                           Case lcLastMemberType == 'view'
                              C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_VIEWS_F + CR_LF
                           Case lcLastMemberType == 'database'
                              *C_FB2PRG_CODE  = C_FB2PRG_CODE + CR_LF + CR_LF
                           Endcase

                           lcLastMemberType    = ''
                        Endif

                        *-- Cambio de tipo de miembro, inicio del actual (connection, table, view, storedprocedures)
                        Do Case
                        Case lcMemberType == 'connection'
                           C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + CR_LF + C_TAB + C_CONNECTIONS_I + CR_LF
                        Case lcMemberType == 'table'
                           C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + CR_LF + C_TAB + C_TABLES_I + CR_LF
                        Case lcMemberType == 'view'
                           C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + CR_LF + C_TAB + C_VIEWS_I + CR_LF
                        Case lcMemberType == 'database'
                           C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + CR_LF
                        Endcase
                     Endif
                  Endif

                  *-- Verificación de los Miembros, si son Externos y se indicó chequearlos
                  If toFoxBin2Prg.getCfgValue('l_ItemPerDBCCheck') And Empty(toFoxBin2Prg.c_ClassOperationType) ;
                        AND Ascan( toDatabase._ExternalClasses, lcMemberType + '.' + lcMemberName, 1, 0, 1, 1+2+4 ) = 0
                     .writeLog( C_TAB + '- ' + loLang.C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC + ' [' + lcInputFile_Class + ']' )
                     .writeErrorLog( C_TAB + '- ' + loLang.C_WARNING_LOC + ' ' + loLang.C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC + ' [' + lcInputFile_Class + ']' )
                     Loop    && Salteo este miembro porque no concuerda con los anotados
                  Endif

                  .writeLog( C_TAB + C_TAB + '+ ' + loLang.C_INCLUDING_MEMBER_LOC + ' ' + Justfname( lcInputFile_Class ) )

                  *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                  If toFoxBin2Prg.addProcessedFile( lcInputFile_Class, 'I', 'P1', 'E0', 'S1', 'X1' ) Then
                     toFoxBin2Prg.updateProcessedFile()
                  Endif

                  If toFoxBin2Prg.l_ProcessFiles Then
                     toFoxBin2Prg.normalizeFileCapitalization( .T., lcInputFile_Class )
                     lcTempTxt       = toFoxBin2Prg.readTextFile( lcInputFile_Class )

                     *!* Changed by: SF 19.11.2023
                     *!* <pdm>
                     *!* <change date="{^2023-11-19,14:12:00}">Changed by: SF<br />
                     *!* Problem with removed Spanish comment, the fixed start at line 7 failes
                     *!* </change>
                     *!* </pdm>

                     *                               For Y = 7 To Alines( laLines, lcTempTxt )
                     Local;
                        lnHeaderEnd As Number
                     * we just asume, Header is not longer then 9 lines
                     lnHeaderEnd = 10
                     For Y = 1 To Alines( laLines, lcTempTxt )
                        If m.Y < lnHeaderEnd Then
                           If Left( laLines( m.Y), 23 ) = '*< FOXBIN2PRG: Version=' Then
                              *Header ends two lines below
                              lnHeaderEnd = m.Y + 2
                           Endif &&LEFT( laLines( m.Y), 23 )  = '*< FOXBIN2PRG: Version='
                           Loop
                        Endif &&m.Y < lnHeaderEnd

                        *!* /Changed by: SF 19.11.2023
                        C_FB2PRG_CODE   = C_FB2PRG_CODE + laLines(m.Y) + CR_LF
                     Endfor

                     lcLastMemberType    = lcMemberType
                  Endif
               Endfor

               If Not toFoxBin2Prg.l_ProcessFiles Then
                  *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                  If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                     toFoxBin2Prg.updateProcessedFile()
                  Endif

                  Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
               Endif

               If Not Empty(lcLastMemberType) Then
                  *-- Cambio de tipo de miembro, fin del anterior (connection, table, view, storedprocedures)
                  Do Case
                  Case lcLastMemberType == 'connection'
                     C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_CONNECTIONS_F + CR_LF
                  Case lcLastMemberType == 'table'
                     C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_TABLES_F + CR_LF
                  Case lcLastMemberType == 'view'
                     C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_VIEWS_F + CR_LF
                  Case lcLastMemberType == 'database'
                     *C_FB2PRG_CODE  = C_FB2PRG_CODE + CR_LF + CR_LF
                  Endcase
               Endif

               *-- Agrego la última parte con el cierre de </DATABASE>
               For X = m.X To lnCodeLines
                  C_FB2PRG_CODE   = C_FB2PRG_CODE + laCodeLines(m.X) + CR_LF
               Endfor

               lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )
            Else
               *-- No es clase por archivo, o no se quiere redireccionar a Main.
               If Not toFoxBin2Prg.l_ProcessFiles Then
                  *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                  If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                     toFoxBin2Prg.updateProcessedFile()
                  Endif

                  Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
               Endif

               C_FB2PRG_CODE       = toFoxBin2Prg.readTextFile( .c_InputFile )

               lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

               .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
               .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toDatabase, @toFoxBin2Prg )

            Endif

            *-- Identifico el inicio/fin de bloque, definición, cabecera y cuerpo del reporte
            .updateProgressbar( 'Identifying Code Blocks...', 1, 2, 1 )
            .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toDatabase, @toFoxBin2Prg )

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
            .updateProgressbar( 'Generating Binary...', 2, 2, 1 )
            toFoxBin2Prg.doBackup( .F., .T., '', '', '' )
            *.createTable()
            .writeBinaryFile( @toDatabase, @toFoxBin2Prg )
         Endwith && THIS


      Catch To loEx
         lnCodError  = loEx.ErrorNo

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
      Endtry

      Return lnCodError
   Endproc



   Procedure writeBinaryFile
      Lparameters toDatabase, toFoxBin2Prg
      *-- -----------------------------------------------------------------------------------------------------------
      #If .F.
         Local toDatabase As CL_DBC Of 'cl_dbc.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lnCodError, lcEventsFile
         lnCodError  = 0

         *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
         toFoxBin2Prg.addProcessedFile( This.c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

         Do Case
         Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
            Error 'OutputFile Error Simulation'
         Endcase

         If Not Empty(toDatabase._DBCEventFilename)
            If Left(toDatabase._DBCEventFilename,1) = '.' Then
               lcEventsFile    = Addbs( Justpath(.c_InputFile) ) + toDatabase._DBCEventFilename
            Else
               lcEventsFile    = toDatabase._DBCEventFilename
            Endif
            If File(lcEventsFile) Then
               lcEventsFile    = ''
            Else
               Strtofile( '', lcEventsFile )
            Endif

            *-- Si no recompilo el EventFilename.prg, el EXE dará un error (aunque el PRG no)
            Compile ( Addbs( Justpath( This.c_OutputFile ) ) + toDatabase._DBCEventFilename )
         Endif

         toDatabase.updateDBC( This.c_OutputFile )

         If toFoxBin2Prg.getCfgValue('l_Recompile')
            toFoxBin2Prg.compileFoxProBinary(This.c_OutputFile)
         Endif

         toFoxBin2Prg.updateProcessedFile()


      Catch To loEx
         lnCodError  = loEx.ErrorNo
         toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         If Not Empty(lcEventsFile) Then
            Erase (lcEventsFile)
            Erase (Forceext(lcEventsFile,'FXP'))
         Endif

      Endtry

      Return lnCodError
   Endproc



   Procedure identifyHeaderBlocks
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (@! IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (@! IN    ) Cantidad de líneas de código
      * taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@! IN    ) Cantidad de bloques de exclusión
      * toDatabase                    (@?    OUT) Objeto con toda la información del módulo analizado
      * toFoxBin2Prg              (@? IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      * NOTA:
      * Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
      *--------------------------------------------------------------------------------------------------------------
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toDatabase, toFoxBin2Prg

      External Array taCodeLines, taLineasExclusion

      #If .F.
         Local toDatabase As CL_DBC Of 'cl_dbc.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, loEx As Exception ;
            , llFoxBin2Prg_Completed, llOLE_DEF_Completed, llINCLUDE_SCX_Completed, llLIBCOMMENT_Completed, llEXTERNAL_MEMBER_Completed ;
            , lc_Comentario, lcProcedureAbierto, lcLine ;
            , loClase As CL_CLASE Of 'cl_clase.prg'

         With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
            Store '' To lcProcedureAbierto

            .c_Type = Upper(Justext(.c_OutputFile))

            If tnCodeLines > 1

               If toFoxBin2Prg.getCfgValue('n_UseFilesPerDBC') > 0 And toFoxBin2Prg.getCfgValue('l_RedirectFilePerDBCToMain')
               Else
                  llEXTERNAL_MEMBER_Completed = .T.
               Endif

               *-- Búsqueda del ID de inicio de bloque (DEFINE CLASS / PROCEDURE)
               For I = 1 To tnCodeLines
                  Store '' To lc_Comentario
                  .set_Line( @lcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Excluida, vacía o solo Comentarios
                     Loop

                  Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( @toDatabase, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     llFoxBin2Prg_Completed  = .T.

                  Case Not llEXTERNAL_MEMBER_Completed And .analyzeCodeBlock_EXTERNAL_MEMBER( @toDatabase, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     *-- Puede haber varias clases externas

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
         Store .Null. To loClase
         Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toDatabase, loClase, I ;
            , llFoxBin2Prg_Completed, llOLE_DEF_Completed, llINCLUDE_SCX_Completed, llLIBCOMMENT_Completed ;
            , lc_Comentario, lcProcedureAbierto, lcLine
      Endtry

      Return
   Endproc



   Procedure identifyCodeBlocks
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (!@ IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (!@ IN    ) Cantidad de líneas de código
      * taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@? IN    ) Sin uso
      * toDatabase                (@! IN    ) Objeto con toda la información de la base de datos analizada
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      * NOTA:
      * Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
      *--------------------------------------------------------------------------------------------------------------
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toDatabase, toFoxBin2Prg

      External Array taCodeLines, taLineasExclusion

      #If .F.
         Local toDatabase As CL_DBC Of 'cl_dbc.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueDatabase_Completed
         Store 0 To I

         With This As c_conversor_prg_a_dbc Of 'c_conversor_prg_a_dbc.prg'
            .c_Type = Upper(Justext(.c_OutputFile))

            If tnCodeLines > 1

               For I = 1 To tnCodeLines
                  .set_Line( @lcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Vacía o solo Comentarios
                     Loop

                  Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( toDatabase, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     llFoxBin2Prg_Completed  = .T.

                  Case Not llBloqueDatabase_Completed And toDatabase.analyzeCodeBlock( @lcLine, @taCodeLines, @m.I, tnCodeLines, @toFoxBin2Prg )
                     llBloqueDatabase_Completed  = .T.

                  Endcase
               Endfor

               .verify_EXTERNAL_MEMBERS( @toDatabase, @toFoxBin2Prg )
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toDatabase ;
            , I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueDatabase_Completed
      Endtry

      Return
   Endproc


   Procedure verify_EXTERNAL_MEMBERS
      *--------------------------------------------------------------------------------
      * Compara los miembros definidos en la cabecera con los miembros encontrados luego
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toDatabase                (@! IN    ) Objeto con toda la información del módulo analizado
      * toFoxBin2Prg              (@! IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toDatabase, toFoxBin2Prg

      #If .F.
         Local toDatabase As CL_DBC Of 'cl_dbc.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Local lnItem, I, X, lcClaseExterna ;
         , loLang As CL_LANG Of 'cl_lang.prg'

      loLang          = _Screen.o_FoxBin2Prg_Lang

      *-- Verificación de los Miembros, si son Externos y se indicó chequearlos
      If toFoxBin2Prg.getCfgValue('n_UseFilesPerDBC') > 0 And toFoxBin2Prg.getCfgValue('l_ItemPerDBCCheck') And Empty(toFoxBin2Prg.c_ClassOperationType)
         For I = 1 To toDatabase._ExternalClasses_Count
            lnItem  = 0

            For X = 1 To toDatabase._Members_Count
               If Lower( toDatabase._Members(m.X,1) ) == Lower( toDatabase._ExternalClasses(m.I,1) )
                  lnItem  = m.X
                  Exit
               Endif
            Endfor

            If lnItem = 0 Then
               lcClaseExterna  = Forcepath( Juststem(toFoxBin2Prg.c_InputFile) + '.' + toDatabase._ExternalClasses(m.I,1) + '.' + Justext(toFoxBin2Prg.c_InputFile), Justpath(toFoxBin2Prg.c_InputFile) )
               *ERROR 'No se ha encontrado la clase externa [' + toDatabase._ExternalClasses(m.I,1) + '] en el archivo [' + toFoxBin2Prg.c_InputFile + ']'
               Error ( loLang.C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC + ' [' + lcClaseExterna + ']' )
            Endif

            toDatabase._Members(lnItem,2) = .T. && Checked
         Endfor
      Endif
   Endproc

Enddefine
