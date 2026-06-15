
#INCLUDE foxbin2prg.h

Define Class c_conversor_pjx_a_prg As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   _MemberData = [<VFPData>] ;
               + [<memberdata name="loadfile" display="loadFile"/>] ;
               + [</VFPData>]

   #If .F.
      Local This As c_conversor_pjx_a_prg Of 'c_conversor_pjx_a_prg.prg'
   #Endif
   c_Type = 'PJX'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (@!    OUT) Objeto generado de clase CL_PROJECT con la información leida del texto
      * toEx                      (@!    OUT) Objeto con información del error
      * toFoxBin2Prg              (@! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
         Local toModulo As CL_PROJECT Of 'cl_project.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

      Try
         Local lnCodError, lcStr, lnPos, lnLen, lnServerCount, loReg, lnLen
         LOCAL loEx As Exception ;
             , loProject    As CL_PROJECT       Of 'cl_project.prg' ;
             , loServerHead As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg' ;
             , loLang       As CL_LANG          Of 'cl_lang.prg'

         loLang = _Screen.o_FoxBin2Prg_Lang

         STORE .Null. TO loProject, loReg, loServerHead

         With This As c_conversor_pjx_a_prg Of 'c_conversor_pjx_a_prg.prg'
            If toFoxBin2Prg.l_ProcessFiles Then
               If Vartype(toModulo) = "O" And toModulo.Class == 'Cl_project' Then
                  *-- Ya esta cargado el objeto del Proyecto y se pasó por referencia
               Else
                  .loadModule( @toModulo, @toEx, @toFoxBin2Prg )
               Endif

               .updateProgressbar( 'Processing Project info...', 2, 3, 1 )
               loProject       = toModulo
               loServerHead    = loProject._ServerHead

               C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

               *!* <pdm>
               *!* <change date="{^2023-03-19,17:16:00}">Changed by: LScheffler<br />
               *!* Text2Bin on PJX errors out for projects with an attach icon that has a drive letter on its path. Issue 93<br />
               *!* Text2Bin creates a construct for relative paths that will fail if a file is on a different drive.<br />
               *!* Solution, we create a new option <em>CheckFileInPath<em/> to control the transformation
               *!* Determines 2Txt deals with files not in the subfolders of the PJX. No handler for UNC paths.<br />
               *!* 0 Ignore. Default<br />
               *!* 1 Check and error out if file is not on same structure (for source control)<br />
               *!* 2 Create absolute path if file is on different drive.<br />
               *!* 3 Create absolute path if file is not in structure<br />
               *!* </change>
               *!* </pdm>

               toFoxBin2Prg.setCfgValue('n_CheckFileInPath', 2)

               lcStr = Addbs( Chrtran( loProject._HomeDir, ['], [] ))
               If toFoxBin2Prg.getCfgValue('n_CheckFileInPath')=1 Then
                  * let's scan all files against pjx home dir
                  If !Empty(loProject._MainProg) And !Empty( Justdrive( Sys( 2014, loProject._MainProg, m.lcStr))) Then
                     lcStr = loLang.C_PJXPATH_ERR_LOC1 + loProject._MainProg + loLang.C_PJXPATH_ERR_LOC4 + m.lcStr + loLang.C_PJXPATH_ERR_LOC5
                     Error 1941
                  Endif

                  If !Empty(loProject._Icon) And !Empty( Justdrive( Sys( 2014, loProject._Icon, m.lcStr))) Then
                     lcStr = loLang.C_PJXPATH_ERR_LOC2 + loProject._Icon + loLang.C_PJXPATH_ERR_LOC4 + m.lcStr + loLang.C_PJXPATH_ERR_LOC5
                     Error 1941
                  Endif

                  For Each loReg In loProject &&FOXOBJECT
                     If !Empty( Justdrive( Sys( 2014, loReg.Name,m.lcStr))) Then
                        lcStr = loLang.C_PJXPATH_ERR_LOC3 + loReg.Name + loLang.C_PJXPATH_ERR_LOC4 + m.lcStr + loLang.C_PJXPATH_ERR_LOC5
                        Error 1941
                     Endif
                  Endfor
               Endif


               *-- Directorio de inicio
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        LPARAMETERS tcDir
                        <<>>
                        lcCurdir = SYS(5)+CURDIR()
                        CD ( EVL( tcDir, JUSTPATH( SYS(16) ) ) )
                        <<>>
               ENDTEXT

               *-- Información del programa
               C_FB2PRG_CODE   = C_FB2PRG_CODE + loProject.getFormattedDeviceInfoText() + CR_LF

               *-- Información de los Servidores definidos
               If Not Empty(loProject._ServerInfo)
                  C_FB2PRG_CODE   = C_FB2PRG_CODE + loServerHead.getFormattedServerText() + CR_LF
               Endif


               *-- Generación del proyecto
               If toFoxBin2Prg.getCfgValue('n_HomeDir') = 1
                  * only output HomeDir if we're supposed to
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<C_BUILDPROJ_I>>
                            <<>>*<.HomeDir = <<loProject._HomeDir>> />
                  ENDTEXT
               Else
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<C_BUILDPROJ_I>>
                  ENDTEXT
               Endif toFoxBin2Prg.getCfgValue('n_HomeDir') = 1

               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<>>
                        FOR EACH loProject IN _VFP.Projects FOXOBJECT
                        <<Chr(9)>>loProject.Close()
                        ENDFOR
                        <<>>
                        STRTOFILE( '', '__newproject.f2b' )
                        BUILD PROJECT <<JUSTFNAME( EVL( .c_OriginalFileName, .c_InputFile ) )>> FROM '__newproject.f2b'
               ENDTEXT


               *-- Abro el proyecto
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        FOR EACH loProject IN _VFP.Projects FOXOBJECT
                        <<Chr(9)>>loProject.Close()
                        ENDFOR
                        <<>>
                        MODIFY PROJECT '<<JUSTFNAME( EVL( .c_OriginalFileName, .c_InputFile ) )>>' NOWAIT NOSHOW NOPROJECTHOOK
                        <<>>
                        loProject = _VFP.Projects('<<JUSTFNAME( EVL( .c_OriginalFileName, .c_InputFile ) )>>')
                        <<>>
                        WITH loProject.FILES
               ENDTEXT


               *-- Definir archivos del proyecto y metadata: CPID, Timestamp, ID, etc.
               loProject.KeySort = 2

               For Each loReg In loProject &&FOXOBJECT
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<Chr(9)>>.ADD('<<loReg.NAME>>')
                  ENDTEXT

                  Do Case
                  Case toFoxBin2Prg.getCfgValue('n_BodyDevInfo')=1
                     * Generates an extra DevInfo tag for each body PJX record
                     TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
                                    <<Chr(9)+Chr(9)>><<'&'>><<'&'>> <<C_FILE_META_I>>
                                    Type="<<loReg.TYPE>>"
                                    Cpid="<<INT( loReg.CPID )>>"
                                    Timestamp="<<INT( loReg.TIMESTAMP )>>"
                                    ID="<<INT( loReg.ID )>>"
                                    ObjRev="<<INT( loReg.OBJREV )>>"
                                    User="<<STRCONV(loReg.USER,13)>>"
                                    DevInfo="<<STRCONV(loReg.DEVINFO,13)>>"
                                    <<C_FILE_META_F>>
                     ENDTEXT

                  Case toFoxBin2Prg.getCfgValue('n_BodyDevInfo')=2
                     * BodyDevInfo = 2 omit DEVINFO and OBJREV
                     TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
                                    <<Chr(9)+Chr(9)>><<'&'>><<'&'>> <<C_FILE_META_I>>
                                    Type="<<loReg.TYPE>>"
                                    Cpid="<<INT( loReg.CPID )>>"
                                    Timestamp="<<INT( loReg.TIMESTAMP )>>"
                                    ID="<<INT( loReg.ID )>>"
                                    User="<<STRCONV(loReg.USER,13)>>"
                                    <<C_FILE_META_F>>
                     ENDTEXT

                  Otherwise
                     TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
                                    <<Chr(9)+Chr(9)>><<'&'>><<'&'>> <<C_FILE_META_I>>
                                    Type="<<loReg.TYPE>>"
                                    Cpid="<<INT( loReg.CPID )>>"
                                    Timestamp="<<INT( loReg.TIMESTAMP )>>"
                                    ID="<<INT( loReg.ID )>>"
                                    ObjRev="<<INT( loReg.OBJREV )>>"
                                    User="<<STRCONV(loReg.USER,13)>>"
                                    <<C_FILE_META_F>>
                     ENDTEXT
                  Endcase

                  loReg   = .Null.
               Endfor

               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><<C_BUILDPROJ_F>>
                        <<>>
                        <<Chr(9)>>.ITEM('__newproject.f2b').Remove()
                        <<>>
               ENDTEXT


               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><<C_FILE_CMTS_I>>
               ENDTEXT


               *-- Agrego los comentarios
               loProject.KeySort = 2

               For Each loReg In loProject &&FOXOBJECT
                  If Not Empty(loReg.COMMENTS)
                     *                               C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(lcCurdir + '" + loReg.Name + "').Description = '" + loReg.COMMENTS + "'"
                     C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(" +;
                        THIS.GetPathFromHome(m.loReg.Name, m.lcStr, "lcCurdir + '", "'", toFoxBin2Prg) +;
                        ").Description = '" + loReg.COMMENTS + "'"
                  Endif
                  loReg   = .Null.
               Endfor


               *-- Exclusiones
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><<C_FILE_CMTS_F>>
                        <<>>
                        <<Chr(9)>><<C_FILE_EXCL_I>>
               ENDTEXT

               loProject.KeySort = 2

               For Each loReg In loProject &&FOXOBJECT
                  If loReg.EXCLUDE
                     *                               C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(lcCurdir + '" + loReg.Name + "').Exclude = .T."
                     C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(" +;
                        THIS.GetPathFromHome(m.loReg.Name, m.lcStr, "lcCurdir + '", "'", toFoxBin2Prg) +;
                        ").Exclude = .T."
                  Endif
                  loReg   = .Null.
               Endfor


               *-- Tipos de archivos especiales
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><<C_FILE_EXCL_F>>
                        <<>>
                        <<Chr(9)>><<C_FILE_TXT_I>>
               ENDTEXT

               loProject.KeySort = 2

               For Each loReg In loProject &&FOXOBJECT
                  If Inlist( Upper( Justext( loReg.Name ) ), 'H','FPW' )
                     *                               C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(lcCurdir + '" + loReg.Name + "').Type = 'T'"
                     C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(" +;
                        THIS.GetPathFromHome(m.loReg.Name, m.lcStr, "lcCurdir + '", "'", toFoxBin2Prg) +;
                        ").Type = 'T'"
                  Endif
                  loReg   = .Null.
               Endfor


               *-- ProjectHook, Debug, Encrypt, Build y cierre
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><<C_FILE_TXT_F>>
                        <<C_ENDWITH>>
                        <<>>
                        <<C_WITH>> loProject
                        <<Chr(9)>><<C_PROJPROPS_I>>
               ENDTEXT

               If Not Empty(loProject._MainProg)
                  *                           <<>>    .SetMain(lcCurdir + '<<loProject._MainProg>>')
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<Chr(9)>>.SetMain(<<THIS.GetPathFromHome(m.loProject._MainProg, m.lcStr, "lcCurdir + '", "'", m.toFoxBin2Prg)>>)

                  ENDTEXT
               Endif

               If Not Empty(loProject._Icon)
                  *                           <<>>    .Icon = lcCurdir + '<<loProject._Icon>>'
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<Chr(9)>>.Icon = <<THIS.GetPathFromHome(m.loProject._Icon, m.lcStr, "lcCurdir + '", "'", toFoxBin2Prg)>>
                  ENDTEXT
               Endif

               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>>.Debug = <<loProject._Debug>>
                        <<Chr(9)>>.Encrypted = <<loProject._Encrypted>>
                        <<Chr(9)>>*<.CmntStyle = <<loProject._CmntStyle>> />
                        <<Chr(9)>>*<.NoLogo = <<loProject._NoLogo>> />
                        <<Chr(9)>>*<.SaveCode = <<loProject._SaveCode>> />
                        <<Chr(9)>>*<.User = '<<STRCONV(loProject._User,13)>>' />
                        <<Chr(9)>>.ProjectHookLibrary = '<<loProject._ProjectHookLibrary>>'
                        <<Chr(9)>>.ProjectHookClass = '<<loProject._ProjectHookClass>>'
                        <<Chr(9)>><<C_PROJPROPS_F>>
                        <<C_ENDWITH>>
                        <<>>
               ENDTEXT

               *-- Build y cierre
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<>>
                        _VFP.Projects('<<JUSTFNAME( EVL( .c_OriginalFileName, .c_InputFile ) )>>').Close()
               ENDTEXT

               *-- Restauro Directorio de inicio
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        *ERASE '__newproject.f2b'
                        CD (lcCurdir)
                        RETURN
               ENDTEXT

            Endif

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


            *-- Genero el PJ2
            .updateProgressbar( 'Writing ' + toFoxBin2Prg.getCfgValue('c_PJ2') + '...', 3, 3, 1 )

            If .l_Test
               toModulo    = C_FB2PRG_CODE
            Else
               .write_OutputFile( (C_FB2PRG_CODE), .c_OutputFile, @toFoxBin2Prg )
            Endif
         Endwith && THIS


      Catch To toEx
         This.set_UserValue(@toEx)

         lnCodError  = toEx.ErrorNo

         Do Case
         Case lnCodError = 2062  && The specified key already exists ==> loProject.ADD( loReg, loReg.NAME )
            toEx.UserValue  = toEx.UserValue + loLang.C_DUPLICATED_FILE_LOC + ': ' + loReg.Name
         Case lnCodError = 1941
            toEx.UserValue  = m.lcStr

         Endcase

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Store .Null. To loProject, loReg, loServerHead
         Release toModulo, toEx, toFoxBin2Prg ;
            , lnCodError, lcStr, lnPos, lnLen, lnServerCount, loReg, lnLen ;
            , loProject, loServerHead

      Endtry

      Return
   Endproc


   Procedure loadModule
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (@!    OUT) Objeto generado de clase CL_PROJECT con la información leida del texto
      * toEx                      (@!    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
         Local toModulo As CL_PROJECT Of 'cl_project.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

      Try
         Local lnCodError, lcStr, lnPos, lnLen, lnServerCount, loReg, lnLen ;
            , loEx As Exception ;
            , loProject As CL_PROJECT Of 'cl_project.prg' ;
            , loServerHead As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg' ;
            , loServerData As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg' ;
            , loLang As CL_LANG Of 'cl_lang.prg'

         loLang          = _Screen.o_FoxBin2Prg_Lang
         Store .Null. To loProject, loReg, loServerHead, loServerData

         With This As c_conversor_pjx_a_prg Of 'c_conversor_pjx_a_prg.prg'
            Use (.c_InputFile) Shared Again Noupdate Alias _TABLAORIG

            *!* LScheffler 20.08.2023
            *issue #96, including issue #95, [KestasL] keep CodePage relavant information for binary sources
            toFoxBin2Prg.i_CPID = Cpdbf("_TABLAORIG")
            Set NoCPTrans To Name,OUTFILE,HomeDir,DEVINFO,SYMBOLS,Object,COMMENTS,RESERVED1,RESERVED2,SCCDATA,User
            */LScheffler 20.08.2023

            Select * From _TABLAORIG Into Cursor TABLABIN
            Use In (Select("_TABLAORIG"))

            .updateProgressbar( 'Loading Project info...', 1, 3, 1 )


            *-- Obtengo los archivos del proyecto
            loProject       = NewObject('CL_PROJECT', 'cl_project.prg')
            toModulo        = loProject
            loServerHead    = loProject._ServerHead

            loProject.c_InputFile   = .c_InputFile
            Scatter Memo Name loReg

            If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
               loReg.Timestamp = 0
            Endif
            If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
               loReg.Id    = 0
            Endif

            loProject._HomeDir      = ['] + Alltrim( .get_ValueFromNullTerminatedValue( loReg.HomeDir ) ) + [']
            loProject._ServerInfo   = loReg.RESERVED2
            loProject._Debug        = loReg.Debug
            loProject._Encrypted    = loReg.Encrypt
            loProject._User         = loReg.User
            loProject.parseDeviceInfo( loReg.DEVINFO )

            *-- Información de los Servidores definidos
            If Not Empty(loProject._ServerInfo)
               loServerHead.parseServerInfo( loProject._ServerInfo )
               loServerHead    = .Null.
            Endif


            *--- Ubico el programa principal
            Locate For MAINPROG

            If Found()
               loProject._MainProg = Lower( Alltrim( .get_ValueFromNullTerminatedValue( Name ) ) )
            Endif


            *-- Ubico el Project Hook
            Locate For Type == 'W'

            If Found()
               loProject._ProjectHookLibrary   = Lower( Alltrim( .get_ValueFromNullTerminatedValue( Name ) ) )
               loProject._ProjectHookClass = Lower( Alltrim( .get_ValueFromNullTerminatedValue( RESERVED1 ) ) )
            Endif


            *-- Ubico el icono del proyecto
            Locate For Type == 'i'

            If Found()
               loProject._Icon = Lower( Alltrim( .get_ValueFromNullTerminatedValue( Name ) ) )
            Endif


            *-- Escaneo el proyecto
            Scan All For Not Inlist(Type, 'H','W','i' )
               loReg   = .Null.
               Scatter Fields Name,Type,EXCLUDE,COMMENTS,CPID,Timestamp,Id,OBJREV,User,DEVINFO Memo Name loReg

               If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
                  loReg.Timestamp = 0
               Endif
               If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
                  loReg.Id    = 0
               Endif

               loReg.Name      = Lower( Alltrim( .get_ValueFromNullTerminatedValue( loReg.Name ) ) )
               loReg.COMMENTS  = Alltrim( .get_ValueFromNullTerminatedValue( loReg.COMMENTS ) )

               *-- TIP: Si el "Name" del objeto está vacío, lo salteo
               If Empty(loReg.Name)
                  Loop
               Endif

               Try
                  loProject.Add( loReg, loReg.Name )
               Catch To loEx When loEx.ErrorNo = 2062  && The specified key already exists ==> loProject.ADD( loReg, loReg.NAME )
                  *-- Saltear y no agregar el archivo duplicado / Bypass and not add the duplicated file
               Endtry
            Endscan
         Endwith && THIS


      Catch To toEx
         This.set_UserValue(@toEx)

         lnCodError  = toEx.ErrorNo

         Do Case
         Case lnCodError = 2062  && The specified key already exists ==> loProject.ADD( loReg, loReg.NAME )
            *toEx.USERVALUE = 'Archivo duplicado: ' + loReg.NAME
            toEx.UserValue  = toEx.UserValue + loLang.C_DUPLICATED_FILE_LOC + ': ' + loReg.Name
         Endcase

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Use In (Select("_TABLAORIG"))
         Store .Null. To loProject, loReg, loServerHead, loServerData
         Release toModulo, toEx, toFoxBin2Prg ;
            , lnCodError, lcStr, lnPos, lnLen, lnServerCount, loReg, lnLen ;
            , loProject, loServerHead, loServerData

      Endtry

      Return
   Endproc

   *!* Changed by: LScheffler 20.3.2023
   *!* <pdm>
   *!* <change date="{^2023-03-20,06:21:00}">Changed by: LScheffler<br />
   *!* Text2Bin on PJX errors out for projects with an attach icon that has a drive letter on its path. Issue 93<br />
   *!* Text2Bin creates a construct for relative paths that will fail if a file is on a different drive.<br />
   *!* Solution, we create a new option <em>CheckFileInPath<em/> to control the transformation
   *!* Determines 2Txt deals with files not in the subfolders of the PJX. No handler for UNC paths.<br />
   *!* 0 Ignore. Default<br />
   *!* 1 Check and error out if file is not on same structure (for source control)<br />
   *!* 2 Create absolute path if file is on different drive.<br />
   *!* 3 Create absolute path if file is not in structure<br />
   *!* </change>
   *!* </pdm>
   Procedure GetPathFromHome
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcFilePath                (v! IN    ) String of a file with path
      * tcProjPath                (v! IN    ) Home directory of a project
      * tcPrefix                  (v! IN    ) Prefix for return
      * tcSufix                   (v! IN    ) Sufix for return
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *
      * Return                    String to File in text file
      *---------------------------------------------------------------------------------------------------
      Lparameters tcFilePath, tcProjPath, tcPrefix, tcSufix, toFoxBin2Prg

      Local;
         lcReturn As String

      lcReturn = Sys( 2014, m.tcFilePath, m.tcProjPath)
      Do Case
      Case m.toFoxBin2Prg.getCfgValue('n_CheckFileInPath')=2 And !Empty( Justdrive( m.lcReturn))
         *!* 2 Create absolute path if file is on different drive.<br />
         lcReturn = '"' + m.tcFilePath + '"'

      Case m.toFoxBin2Prg.getCfgValue('n_CheckFileInPath')=3 And (!Empty( Justdrive( m.lcReturn)) Or Left(m.lcReturn, 2) = "..")
         *!* 3 Create absolute path if file is not in structure<br />
         lcReturn = '"' + m.tcFilePath + '"'

      Otherwise
         *!* just normal relative path
         lcReturn = m.tcPrefix + m.tcFilePath + m.tcSufix

      Endcase

      Return m.lcReturn
   Endproc &&GetPathFromHome
   *!* /Changed by: LScheffler 20.3.2023

Enddefine
