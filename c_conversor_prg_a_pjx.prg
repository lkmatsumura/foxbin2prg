#INCLUDE foxbin2prg.h

Define Class c_conversor_prg_a_pjx As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
   #If .F.
      Local This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
   #Endif
   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzecodeblock_buildproj" display="analyzeCodeBlock_BuildProj"/>] ;
      + [<memberdata name="analyzecodeblock_devinfo" display="analyzeCodeBlock_DevInfo"/>] ;
      + [<memberdata name="analyzecodeblock_excludedfiles" display="analyzeCodeBlock_ExcludedFiles"/>] ;
      + [<memberdata name="analyzecodeblock_filecomments" display="analyzeCodeBlock_FileComments"/>] ;
      + [<memberdata name="analyzecodeblock_serverhead" display="analyzeCodeBlock_ServerHead"/>] ;
      + [<memberdata name="analyzecodeblock_serverdata" display="analyzeCodeBlock_ServerData"/>] ;
      + [<memberdata name="analyzecodeblock_textfiles" display="analyzeCodeBlock_TextFiles"/>] ;
      + [<memberdata name="analyzecodeblock_projectproperties" display="analyzeCodeBlock_ProjectProperties"/>] ;
      + [</VFPData>]

   c_Type = 'PJ2'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toProject                 (!@    OUT) Objeto generado de clase CL_PROJECT con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toProject, toEx As Exception, toFoxBin2Prg
      DoDefault( @toProject, @toEx, @toFoxBin2Prg )

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local laCodeLines(1), lnCodeLines, laLineasExclusion(1), lnBloquesExclusion, I, lnIDInputFile

         With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
            Store 0 To lnCodeLines
            Store .Null. To toModulo
            lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

            If Not toFoxBin2Prg.l_ProcessFiles Then
               *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
               If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                  toFoxBin2Prg.updateProcessedFile()
               Endif

               Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
            Endif

            C_FB2PRG_CODE       = toFoxBin2Prg.readTextFile( .c_InputFile )
            lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

            *-- Identifico los TEXT/ENDTEXT, #IF .F./#ENDIF
            *.identifyExclusionBlocks( @laCodeLines, .F., @laLineasExclusion, @lnBloquesExclusion )

            *-- Identifico el inicio/fin de bloque, definición, cabecera y cuerpo de cada clase
            .updateProgressbar( 'Identifying Code Blocks...', 1, 2, 1 )
            .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toProject, @toFoxBin2Prg )

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
            .createProject(toProject)
            .writeBinaryFile( @toProject, @toFoxBin2Prg )
         Endwith && THIS


      Catch To toEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Release laCodeLines, lnCodeLines, laLineasExclusion, lnBloquesExclusion, I

      Endtry

      Return
   Endproc



   Procedure writeBinaryFile
      Lparameters toProject, toFoxBin2Prg
      *-- -----------------------------------------------------------------------------------------------------------
      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lnCodError, lcMainProg, loEx As Exception ;
            , loServerHead As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg' ;
            , loFile As CL_PROJ_FILE Of 'cl_proj_file.prg'

         With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
            Store .Null. To loFile, loServerHead
            toProject._HomeDir  = Chrtran( toProject._HomeDir, ['], [] )
            toProject._SccData  = Chr(3) + Chr(0) + Chr(1) + Replicate( Chr(0), 651 )

            *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
            toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

            Do Case
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
               Error 'OutputFile Error Simulation'
            Endcase

            *-- Creo solo el registro de cabecera del proyecto
            .createProject_RecordHeader( toProject )

            lcMainProg  = ''

            If Not Empty(toProject._MainProg)
               lcMainProg  = Lower( Sys(2014, toProject._MainProg, Addbs(toProject._HomeDir) ) )
            Endif

            If Empty(toProject._TimeStamp)
               toProject._TimeStamp    = .rowTimeStamp( {^2013/11/04 20:00:00} )
            Endif
            If Empty(toProject._ID)
               toProject._ID   = toFoxBin2Prg.unique_ID('N')
            Endif

            *-- Si hay ProjectHook de proyecto, lo inserto
            If Not Empty(toProject._ProjectHookLibrary)
               Insert Into TABLABIN ;
                  ( Name ;
                  , Type ;
                  , EXCLUDE ;
                  , Key ;
                  , RESERVED1 ) ;
                  VALUES ;
                  ( toProject._ProjectHookLibrary + Chr(0) ;
                  , 'W' ;
                  , .T. ;
                  , Upper(Juststem(toProject._ProjectHookLibrary)) ;
                  , toProject._ProjectHookClass + Chr(0) )
            Endif

            *-- Si hay ICONO de proyecto, lo inserto
            If Not Empty(toProject._Icon)
               Insert Into TABLABIN ;
                  ( Name ;
                  , Type ;
                  , Local ;
                  , Key ) ;
                  VALUES ;
                  ( Sys(2014, toProject._Icon, Addbs(Justpath(Addbs(toProject._HomeDir)))) + Chr(0) ;
                  , 'i' ;
                  , .T. ;
                  , Upper(Juststem(toProject._Icon)) )
            Endif

            *-- Agrego los ARCHIVOS
            For Each loFile In toProject FoxObject

               If Empty(loFile._TimeStamp)
                  loFile._TimeStamp   = .rowTimeStamp( {^2013/11/04 20:00:00} )
               Endif
               If Empty(loFile._ID)
                  loFile._ID  = toFoxBin2Prg.unique_ID('N')
               Endif

               Insert Into TABLABIN ;
                  ( Name ;
                  , Type ;
                  , EXCLUDE ;
                  , MAINPROG ;
                  , COMMENTS ;
                  , Local ;
                  , CPID ;
                  , Id ;
                  , Timestamp ;
                  , OBJREV ;
                  , User ;
                  , DEVINFO ;
                  , Key ) ;
                  VALUES ;
                  ( loFile._Name + Chr(0) ;
                  , .fileTypeCode(Justext(loFile._Name), loFile._Type) ;
                  , loFile._Exclude ;
                  , (loFile._Name == lcMainProg) ;
                  , loFile._Comments ;
                  , .T. ;
                  , loFile._CPID ;
                  , loFile._ID ;
                  , loFile._TimeStamp ;
                  , loFile._ObjRev ;
                  , Strconv(loFile._User,14) ;
                  , Strconv(loFile._DevInfo,14) ;
                  , Upper(Juststem(loFile._Name)) )
            Endfor

            Use In (Select("TABLABIN"))
            toFoxBin2Prg.updateProcessedFile()
         Endwith && THIS


      Catch To loEx
         lnCodError  = loEx.ErrorNo
         toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Store .Null. To loFile, loServerHead
         Release loFile, loServerHead

      Endtry

      Return lnCodError
   Endproc

   Procedure createProject_RecordHeader
      Lparameters toProject

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
      #Endif

      Insert Into TABLABIN ;
         ( Name ;
         , Type ;
         , Timestamp ;
         , OUTFILE ;
         , HomeDir ;
         , SAVECODE ;
         , Debug ;
         , Encrypt ;
         , NOLOGO ;
         , CMNTSTYLE ;
         , OBJREV ;
         , DEVINFO ;
         , Object ;
         , RESERVED1 ;
         , RESERVED2 ;
         , SCCDATA ;
         , Local ;
         , User ;
         , Key ) ;
         VALUES ;
         ( Upper(JustFname(This.c_OutputFile)) + chr(0) ;
         , 'H' ;
         , 0 ;
         , '<Source>' + Chr(0) ;
         , Lower(Justpath(This.c_OutputFile)) + Chr(0) ;
         , toProject._SaveCode ;
         , toProject._Debug ;
         , toProject._Encrypted ;
         , toProject._NoLogo ;
         , toProject._CmntStyle ;
         , 260 ;
         , toProject.getRowDevInfo() ;
         , Lower(Justpath(This.c_OutputFile)) + Chr(0) ;
         , Upper(JustFname(This.c_OutputFile)) + chr(0);
         , toProject._ServerHead.getRowServerInfo() ;
         , toProject._SccData ;
         , .T. ;
         , Strconv(toProject._User,14) ;
         , Upper( Juststem( This.c_OutputFile) ) )

   Endproc


   Procedure identifyCodeBlocks
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toProject, toFoxBin2Prg
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (@! IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (@! IN    ) Cantidad de líneas de código
      * taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@! IN    ) Cantidad de bloques de exclusión
      * toProject                 (@?    OUT) Objeto con toda la información del proyecto analizado
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *
      * NOTA:
      * Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
      *--------------------------------------------------------------------------------------------------------------
      External Array taCodeLines, taLineasExclusion

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, lc_Comentario, lcLine
         LOCAL llBuildProj_Completed    , llDevInfo_Completed     , llHomedir_Completed ;
             , llServerHead_Completed   , llFileComments_Completed, llFoxBin2Prg_Completed ;
             , llExcludedFiles_Completed, llTextFiles_Completed, llProjectProperties_Completed

         With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
            Store 0 To I
            .c_Type = Upper(Justext(.c_OutputFile))

            If tnCodeLines > 1
               toProject           = NewObject('CL_PROJECT', 'cl_project.prg')
               *toProject._HomeDir = ADDBS(JUSTPATH(.c_OutputFile))

               For I = 1 To tnCodeLines
                  .set_Line( @lcLine, @taCodeLines, m.I )

                  Do Case
                   Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario )
                        && Vacía o solo Comentarios
                        Loop

                   Case Not llFoxBin2Prg_Completed ;
                        And .analyzeCodeBlock_FoxBin2Prg( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                        llFoxBin2Prg_Completed  = .T.

                   Case Not llDevInfo_Completed ;
                        And .analyzeCodeBlock_DevInfo( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines, @toFoxBin2Prg )
                        llDevInfo_Completed = .T.

                   Case NOT llServerHead_Completed ;
                        AND .analyzeCodeBlock_ServerData( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                        * Puede haber varios servidores, por eso se siguen valuando
                        DO WHILE .T.
                           DO CASE
                            CASE .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario )
                                 LOOP

                            CASE .analyzeCodeBlock_ServerData( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines )

                            OTHERWISE
                                 EXIT

                           ENDCASE
                        ENDDO
                        llServerHead_Completed  = .T.
                        llDevInfo_Completed = .T.  && No DevInfo expected after ServerHead

                   Case Not llHomedir_Completed ;
                        And .analyzeCodeBlock_Homedir( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                        llHomedir_Completed = .T.
                        llDevInfo_Completed = .T.  && No DevInfo expected after HomeDir
                        llServerHead_Completed  = .T. && No ServerHead expected after HomeDir

                   Case Not llBuildProj_Completed ;
                        And .analyzeCodeBlock_BuildProj( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines, @toFoxBin2Prg )
                        llBuildProj_Completed   = .T.
                        llHomedir_Completed = .T. && No HomeDir expected after BuildProj
                        llDevInfo_Completed = .T.  && No DevInfo expected after BuildProj
                        llServerHead_Completed  = .T. && No ServerHead expected after BuildProj

                   Case Not llFileComments_Completed ;
                        And .analyzeCodeBlock_FileComments( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                        llFileComments_Completed    = .T.

                   Case Not llExcludedFiles_Completed ;
                        And .analyzeCodeBlock_ExcludedFiles( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                        llExcludedFiles_Completed   = .T.

                   Case Not llTextFiles_Completed ;
                        And .analyzeCodeBlock_TextFiles( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                        llTextFiles_Completed   = .T.

                   Case Not llProjectProperties_Completed ;
                        And .analyzeCodeBlock_ProjectProperties( toProject, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                        llProjectProperties_Completed   = .T.

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
         Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toProject ;
            , I, lc_Comentario, lcLine, llBuildProj_Completed, llDevInfo_Completed ;
            , llServerHead_Completed, llFileComments_Completed, llFoxBin2Prg_Completed ;
            , llExcludedFiles_Completed, llTextFiles_Completed, llProjectProperties_Completed
      Endtry

      Return
   Endproc


   Procedure analyzeCodeBlock_Homedir
      *--------------------------------------------------------------------------------------------------------------
      * Analiza el bloque <HomeDir>
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toProject                 (@?    OUT) Objeto con toda la información del proyecto analizado
      * tcLine                    (@! IN    ) Línea de datos en evaluación
      * taCodeLines               (@! IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (@! IN    ) Cantidad de líneas de código
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
      #Endif

      Try
         Local llBloqueEncontrado

         If Upper( Left( tcLine, 10 ) ) == Upper( '*<.HomeDir' )
            toProject._HomeDir  = Strextract( tcLine, "'", "'" )

            llBloqueEncontrado  = .T.
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return llBloqueEncontrado
   Endproc



   Procedure analyzeCodeBlock_BuildProj
      *--------------------------------------------------------------------------------------------------------------
      * Analiza el bloque <BuildProj>
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toProject                 (@?    OUT) Objeto con toda la información del proyecto analizado
      * tcLine                    (@! IN    ) Línea de datos en evaluación
      * taCodeLines               (@! IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (@! IN    ) Cantidad de líneas de código
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines, toFoxBin2Prg
      External Array taCodeLines

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcComment, lcMetadatos, luValor ;
            , laPropsAndValues(1,2), lnPropsAndValues_Count ;
            , loFile As CL_PROJ_FILE Of 'cl_proj_file.prg'

         If Left( tcLine, Len(C_BUILDPROJ_I) ) == C_BUILDPROJ_I
            llBloqueEncontrado  = .T.

            With This
               For I = m.I + 1 To tnCodeLines
                  lcComment   = ''
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                   Case Left( tcLine, Len(C_BUILDPROJ_F) ) == C_BUILDPROJ_F
                        I = m.I + 1
                        Exit

                   Case .lineIsOnlyCommentAndNoMetadata( @tcLine, @lcComment )
                        Loop    && Saltear comentarios

                   Case Upper( Left( tcLine, 5 ) ) == '.ADD('
                        * loFile: NAME,TYPE,EXCLUDE,COMMENTS
                        tcLine          = Chrtran( tcLine, ["] + '[]', "'''" )  && Convierto "[] en '
                        Store .Null. To loFile
                        loFile          = NewObject('CL_PROJ_FILE', 'cl_proj_file.prg')
                        loFile._Name    = Alltrim( Strextract( tcLine, ['], ['] ) )

                        *-- Obtengo metadatos de los comentarios de FileMetadata:
                        *< FileMetadata: Type="V" Cpid="1252" Timestamp="1131901580" ID="1129207528" ObjRev="544" />
                        .get_ListNamesWithValuesFrom_InLine_MetadataTag( @lcComment, @laPropsAndValues ;
                           , @lnPropsAndValues_Count, C_FILE_META_I, C_FILE_META_F )

                        loFile._Type        = .get_ValueByName_FromListNamesWithValues( 'Type'     , 'C', @laPropsAndValues )
                        loFile._CPID        = .get_ValueByName_FromListNamesWithValues( 'CPID'     , 'I', @laPropsAndValues )
                        loFile._TimeStamp   = .get_ValueByName_FromListNamesWithValues( 'Timestamp', 'I', @laPropsAndValues )
                        loFile._ID          = .get_ValueByName_FromListNamesWithValues( 'ID'       , 'I', @laPropsAndValues )
                        loFile._ObjRev      = .get_ValueByName_FromListNamesWithValues( 'ObjRev'   , 'I', @laPropsAndValues )
                        loFile._User        = .get_ValueByName_FromListNamesWithValues( 'User'     , 'C', @laPropsAndValues )

                        If toFoxBin2Prg.getCfgValue('n_BodyDevInfo') = 1
                           loFile._DevInfo  = .get_ValueByName_FromListNamesWithValues( 'DevInfo'  , 'C', @laPropsAndValues )
                        Endif

                        toProject.Add( loFile, loFile._Name )

                  Endcase
               Endfor
            Endwith && THIS

            I = m.I - 1
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loFile
         Release toProject, tcLine, taCodeLines, I, tnCodeLines ;
            , lcComment, lcMetadatos, luValor, laPropsAndValues, lnPropsAndValues_Count, loFile
      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_DevInfo
      *------------------------------------------------------
      *-- Analiza el bloque <DevInfo>
      *------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines, toFoxBin2Prg
      External Array taCodeLines

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local llBloqueEncontrado, llKeepDevInfo

         If Left( tcLine, Len(C_DEVINFO_I) ) == C_DEVINFO_I
            llBloqueEncontrado  = .T.
            llKeepDevInfo       = ( toFoxBin2Prg.getCfgValue('n_ProjectDevInfo') = 1 )

            With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Left( tcLine, Len(C_DEVINFO_F) ) == C_DEVINFO_F
                     I = m.I + 1
                     Exit

                  Case .lineIsOnlyCommentAndNoMetadata( @tcLine )
                     Loop    && Saltear comentarios

                  Otherwise
                     If llKeepDevInfo
                        toProject.setParsedProjInfoLine( @tcLine )
                     Endif
                  Endcase
               Endfor
            Endwith && THIS

            I = m.I - 1
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_ServerHead
      *------------------------------------------------------
      *-- Analiza el bloque <ServerHead>
      *------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
      #Endif

      Try
         Local llBloqueEncontrado ;
            , loServerHead As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg'

         If Left( tcLine, Len(C_SRV_HEAD_I) ) == C_SRV_HEAD_I
            llBloqueEncontrado  = .T.

            Store .Null. To loServerHead
            loServerHead    = toProject._ServerHead

            With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @tcLine )
                     Loop    && Saltear comentarios

                  Case Left( tcLine, Len(C_SRV_HEAD_F) ) == C_SRV_HEAD_F
                     I = m.I + 1
                     Exit

                  Otherwise
                     loServerHead.setParsedHeadInfoLine( @tcLine )
                  Endcase
               Endfor
            Endwith && THIS

            I = m.I - 1
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loServerHead
         Release loServerHead

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_ServerData
      *------------------------------------------------------
      *-- Analiza el bloque <ServerData>
      *------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
      #Endif

      Try
         Local llBloqueEncontrado ;
            , loServerHead As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg' ;
            , loServerData As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg'

         If Left( tcLine, Len(C_SRV_DATA_I) ) == C_SRV_DATA_I
            llBloqueEncontrado  = .T.

            Store .Null. To loServerData, loServerHead
            loServerHead    = toProject._ServerHead
            loServerData    = loServerHead.getServerDataObject()

            With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @tcLine )
                     Loop    && Saltear comentarios

                  Case Left( tcLine, Len(C_SRV_DATA_F) ) == C_SRV_DATA_F
                     I = m.I + 1
                     Exit

                  Otherwise
                     loServerHead.setParsedInfoLine( loServerData, @tcLine )
                  Endcase
               Endfor
            Endwith && THIS

            loServerHead.add_Server( loServerData )
            I = m.I - 1
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loServerData, loServerHead
         Release loServerHead, loServerData

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_FileComments
      *------------------------------------------------------
      *-- Analiza el bloque <FileComments>
      *------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      External Array toProject

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcFile, lcComment ;
            , loFile As CL_PROJ_FILE Of 'cl_proj_file.prg'

         If Left( tcLine, Len(C_FILE_CMTS_I) ) == C_FILE_CMTS_I
            llBloqueEncontrado  = .T.
            loFile  = .Null.

            With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @tcLine )
                     Loop    && Saltear comentarios

                  Case Left( tcLine, Len(C_FILE_CMTS_F) ) == C_FILE_CMTS_F
                     I = m.I + 1
                     Exit

                  Otherwise
                     lcFile              = Lower( Alltrim( Strtran( Chrtran( Normalize( Strextract( tcLine, ".ITEM(", ").Description", 1, 1 ) ), ["], [] ), 'lcCurDir+', '', 1, 1, 1) ) )
                     lcComment           = Alltrim( Chrtran( Strextract( tcLine, "=", "", 1, 2 ), ['], [] ) )
                     loFile              = toProject( lcFile )
                     loFile._Comments    = lcComment
                     loFile              = .Null.
                  Endcase
               Endfor
            Endwith && THIS

            I = m.I - 1
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         loFile  = .Null.
         Release lcFile, lcComment, loFile

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_ExcludedFiles
      *------------------------------------------------------
      *-- Analiza el bloque <ExcludedFiles>
      *------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      External Array toProject

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcFile, llExclude ;
            , loFile As CL_PROJ_FILE Of 'cl_proj_file.prg'

         If Left( tcLine, Len(C_FILE_EXCL_I) ) == C_FILE_EXCL_I
            llBloqueEncontrado  = .T.
            loFile  = .Null.

            With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @tcLine )
                     Loop    && Saltear comentarios

                  Case Left( tcLine, Len(C_FILE_EXCL_F) ) == C_FILE_EXCL_F
                     I = m.I + 1
                     Exit

                  Otherwise
                     lcFile          = Lower( Alltrim( Strtran( Chrtran( Normalize( Strextract( tcLine, ".ITEM(", ").Exclude", 1, 1 ) ), ["], [] ), 'lcCurDir+', '', 1, 1, 1) ) )
                     llExclude       = Evaluate( Alltrim( Chrtran( Strextract( tcLine, "=", "", 1, 2 ), ['], [] ) ) )
                     loFile          = toProject( lcFile )
                     loFile._Exclude = llExclude
                     loFile          = .Null.
                  Endcase
               Endfor
            Endwith && THIS

            I = m.I - 1
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         loFile  = .Null.
         Release lcFile, llExclude, loFile

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_TextFiles
      *------------------------------------------------------
      *-- Analiza el bloque <TextFiles>
      *------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      External Array toProject

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcFile, lcType ;
            , loFile As CL_PROJ_FILE Of 'cl_proj_file.prg'

         If Left( tcLine, Len(C_FILE_TXT_I) ) == C_FILE_TXT_I
            llBloqueEncontrado  = .T.
            loFile          = .Null.

            With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @tcLine )
                     Loop    && Saltear comentarios

                  Case Left( tcLine, Len(C_FILE_TXT_F) ) == C_FILE_TXT_F
                     I = m.I + 1
                     Exit

                  Otherwise
                     lcFile          = Lower( Alltrim( Strtran( Chrtran( Normalize( Strextract( tcLine, ".ITEM(", ").Type", 1, 1 ) ), ["], [] ), 'lcCurDir+', '', 1, 1, 1) ) )
                     lcType          = Alltrim( Chrtran( Strextract( tcLine, "=", "", 1, 2 ), ['], [] ) )
                     loFile          = toProject( lcFile )
                     loFile._Type    = lcType
                     loFile          = .Null.
                  Endcase
               Endfor
            Endwith && THIS

            I = m.I - 1
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         loFile  = .Null.
         Release lcFile, lcType, loFile

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_ProjectProperties
      *------------------------------------------------------
      *-- Analiza el bloque <ProjectProperties>
      *------------------------------------------------------
      Lparameters toProject, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      #If .F.
         Local toProject As CL_PROJECT Of 'cl_project.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcLine

         If Left( tcLine, Len(C_PROJPROPS_I) ) == C_PROJPROPS_I
            llBloqueEncontrado  = .T.

            With This As c_conversor_prg_a_pjx Of 'c_conversor_prg_a_pjx.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @tcLine )
                     Loop    && Saltear comentarios

                  Case Left( tcLine, Len(C_PROJPROPS_F) ) == C_PROJPROPS_F
                     I = m.I + 1
                     Exit

                  Case Left( tcLine ,2 ) == '*<'
                     *--- Se asigna con EVALUATE() tal cual está en el PJ2, pero quitando el marcador *< />
                     lcLine      = Stuff( Alltrim( Strextract( tcLine, '*<', '/>' ) ), 2, 0, '_' )
                     toProject.setParsedProjInfoLine( lcLine )

                  Case Upper( Left( tcLine, 9 ) ) == '.SETMAIN('
                     *-- Cambio "SetMain()" por "_MainProg ="
                     lcLine      = '._MainProg = ' + Lower( Strextract( Alltrim( tcLine), '.SetMain(', ')', 1, 1 ) )
                     toProject.setParsedProjInfoLine( lcLine )

                  Otherwise
                     *--- Se asigna con EVALUATE() tal cual está en el PJ2
                     lcLine      = Stuff( Alltrim( tcLine), 2, 0, '_' )
                     toProject.setParsedProjInfoLine( lcLine )
                  Endcase
               Endfor
            Endwith && THIS

            I = m.I - 1
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return llBloqueEncontrado
   Endproc

Enddefine
