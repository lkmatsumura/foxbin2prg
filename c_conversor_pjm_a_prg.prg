#INCLUDE foxbin2prg.h

Define Class c_conversor_pjm_a_prg As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   _MemberData = [<VFPData>] ;
      + [<memberdata name="strextract_cr" display="strExtract_CR"/>] ;
      + [</VFPData>]

   #If .F.
      Local This As c_conversor_pjm_a_prg Of 'c_conversor_pjm_a_prg.prg'
   #Endif
   c_Type                  = 'PJM'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@    OUT) Objeto generado de clase CL_PROJECT con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

      Try
         If toFoxBin2Prg.l_ProcessFiles Then
            Local lnCodError, lcStr, lnPos, lnLen, lnServerCount, loReg, lnLen ;
               , lcStrPJM, lcPjxName ;
               , laLines(1), laProps(1) ;
               , loEx As Exception ;
               , loProject As CL_PROJECT Of 'cl_project.prg' ;
               , loServerHead As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg' ;
               , loServerData As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg' ;
               , loLang As CL_LANG Of 'cl_lang.prg'

            loLang          = _Screen.o_FoxBin2Prg_Lang
            Store .Null. To loProject, loReg, loServerHead, loServerData
            lcStrPJM        = Filetostr( This.c_InputFile )
            This.updateProgressbar( 'Scanning PJM...', 1, 2, 1 )


            *-- Obtengo los archivos del proyecto
            loProject       = NewObject('CL_PROJECT', 'cl_project.prg')
            loServerHead    = loProject._ServerHead

            With loProject As CL_PROJECT Of 'cl_project.prg'
               *-- Proj.Info
               ._CmntStyle             = Strextract( lcStrPJM, 'CommentStyle=', CR_LF )
               ._Debug                 = Strextract( lcStrPJM, 'Debug=', CR_LF )
               ._Encrypted             = Strextract( lcStrPJM, 'Encrypt=', CR_LF )
               ._HomeDir               = ['] + Lower( Justpath( Sys(5)+Curdir() ) ) + [']
               ._ID                    = ''
               ._NoLogo                = Strextract( lcStrPJM, 'NoLogo=', CR_LF )
               ._ObjRev                = 0
               ._ProjectHookClass      = ''
               ._ProjectHookLibrary    = ''
               ._SaveCode              = Strextract( lcStrPJM, 'SaveCode=', CR_LF )
               ._ServerHead            = .Null.
               ._ServerInfo            = 'ServerData'
               ._SourceFile            = ''
               ._TimeStamp             = 0
               ._Version               = Strextract( lcStrPJM, 'Version=', CR_LF )

               *-- Dev.info
               ._Author                = Strextract( lcStrPJM, 'Author=', CR_LF )
               ._Company               = Strextract( lcStrPJM, 'Company=', CR_LF )
               ._Address               = Strextract( lcStrPJM, 'Address=', CR_LF )
               ._City                  = Strextract( lcStrPJM, 'City=', CR_LF )
               ._State                 = Strextract( lcStrPJM, 'State=', CR_LF )
               ._PostalCode            = Strextract( lcStrPJM, 'Zip=', CR_LF )
               ._Country               = Strextract( lcStrPJM, 'Country=', CR_LF )

               ._Comments              = Strextract( lcStrPJM, 'Comments=', CR_LF )
               ._CompanyName           = Strextract( lcStrPJM, 'CompanyName=', CR_LF )
               ._FileDescription       = Strextract( lcStrPJM, 'FileDescription=', CR_LF )
               ._LegalCopyright        = Strextract( lcStrPJM, 'LegalCopyright=', CR_LF )
               ._LegalTrademark        = Strextract( lcStrPJM, 'LegalTrademarks=', CR_LF )
               ._ProductName           = Strextract( lcStrPJM, 'ProductName=', CR_LF )
               ._MajorVer              = Strextract( lcStrPJM, 'Major=', CR_LF )
               ._MinorVer              = Strextract( lcStrPJM, 'Minor=', CR_LF )
               ._Revision              = Strextract( lcStrPJM, 'Revision=', CR_LF )
               ._AutoIncrement         = Iif( Strextract( lcStrPJM, 'AutoIncrement=', CR_LF ) = '.T.', '1', '0' )
            Endwith

            For I = 1 To Alines( laLines, Strextract( lcStrPJM, '[OLEServers]', '[OLEServersEnd]' ), 4 )
               Alines( laProps, laLines(m.I), 1, ',' )

               If m.I = 1
                  With loServerHead As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg'
                     ._LibraryName   = laProps(1)
                     ._InternalName  = laProps(2)
                     ._ProjectName   = laProps(3)
                     ._TypeLibDesc   = laProps(4)
                     ._ServerType    = Padl(laProps(5),4)
                     ._TypeLib       = laProps(6)
                  Endwith

               Else
                  loServerData = loServerHead.getServerDataObject()

                  With loServerData As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg'
                     ._HelpContextID = laProps(4)
                     ._ServerName    = laProps(3)
                     ._Description   = laProps(5)
                     ._HelpFile      = laProps(6)
                     ._ServerClass   = laProps(1)
                     ._ClassLibrary  = laProps(2)
                     ._Instancing    = laProps(7)
                     ._CLSID         = laProps(8)
                     ._Interface     = laProps(9)
                  Endwith

                  loServerHead.add_Server( loServerData )
                  loServerData    = .Null.
               Endif
            Endfor



            *-- Escaneo el proyecto
            For I = 1 To Alines( laLines, Strextract( lcStrPJM, '[ProjectFiles]', '[EOF]' ), 4 )
               Alines( laProps, laLines(m.I) + ',', 1, ',' )
               loReg   = .Null.
               loReg   = Createobject("EMPTY")
               AddProperty( loReg, 'ID', Iif( toFoxBin2Prg.getCfgValue('l_ClearUniqueID'), 0, Val( laProps(1) ) ) )
               AddProperty( loReg, 'TYPE', laProps(2) )
               AddProperty( loReg, 'NAME', laProps(3) )
               AddProperty( loReg, 'EXCLUDE', Evaluate( laProps(4) ) )
               AddProperty( loReg, 'MAINPROG', laProps(5) )
               AddProperty( loReg, 'CPID', Val( laProps(6) ) )
               AddProperty( loReg, 'COMMENTS', laProps(9) )
               AddProperty( loReg, 'TIMESTAMP', 0 )
               AddProperty( loReg, 'OBJREV', 0 )

               *-- TIP: Si el "Name" del objeto está vacío, lo salteo
               If Empty(loReg.Name)
                  Loop
               Endif

               Try
                  Do Case
                  Case loReg.MAINPROG = '.T.'
                     loProject._MainProg = loReg.Name
                     loProject.Add( loReg, loReg.Name )
                  Case loReg.Type == 'W'
                     *
                  Case loReg.Type == 'i'
                     loProject._Icon = loReg.Name
                  Otherwise
                     loProject.Add( loReg, loReg.Name )
                  Endcase

               Catch To loEx When loEx.ErrorNo = 2062  && The specified key already exists ==> loProject.ADD( loReg, loReg.NAME )
                  *-- Saltear y no agregar el archivo duplicado / Bypass and not add the duplicated file
               Finally
                  loReg   = .Null.
               Endtry
            Endfor


            C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()


            *-- Directorio de inicio
            TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    LPARAMETERS tcDir
                    <<>>
                    lcCurdir = SYS(5)+CURDIR()
                    CD ( EVL( tcDir, JUSTPATH( SYS(16) ) ) )
                    <<>>
            ENDTEXT


            *-- Información del programa (project header DevInfo)
            If toFoxBin2Prg.getCfgValue('n_ProjectDevInfo') = 1
               C_FB2PRG_CODE   = C_FB2PRG_CODE + loProject.getFormattedDevinfoText() + CR_LF
            Endif


            *-- Información de los Servidores definidos
            If Not Empty(loProject._ServerInfo)
               C_FB2PRG_CODE   = C_FB2PRG_CODE + loServerHead.getFormattedServerText() + CR_LF
               loServerHead    = .Null.
            Endif

            With This As c_conversor_pjm_a_prg Of 'c_conversor_pjm_a_prg.prg'

               lcPjxName = LOWER( JUSTFNAME( EVL( .c_OriginalFileName, .c_InputFile ) ) )

               *-- Generación del proyecto
               *** DH 2021-03-04: only output HomeDir if we're supposed to
               If toFoxBin2Prg.getCfgValue('n_HomeDir') = 1
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<C_BUILDPROJ_I>>
                            <<>>*<.HomeDir = <<loProject._HomeDir>> />
                  ENDTEXT
               Else
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<C_BUILDPROJ_I>>
                  ENDTEXT
               Endif toFoxBin2Prg.getCfgValue('n_HomeDir') = 1
               *** DH 2021-03-04: end of updated code
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<>>
                        FOR EACH loProject IN _VFP.Projects FOXOBJECT
                        <<Chr(9)>>loProject.Close()
                        ENDFOR
                        <<>>
                        STRTOFILE( '', '__newproject.f2b' )
                        BUILD PROJECT <<lcPjxName>> FROM '__newproject.f2b'
               ENDTEXT


               *-- Abro el proyecto
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        FOR EACH loProject IN _VFP.Projects FOXOBJECT
                        <<Chr(9)>>loProject.Close()
                        ENDFOR
                        <<>>
                        MODIFY PROJECT '<<lcPjxName>>' NOWAIT NOSHOW NOPROJECTHOOK
                        <<>>
                        loProject = _VFP.Projects('<<lcPjxName>>')
                        <<>>
                        WITH loProject.FILES
               ENDTEXT


               *-- Definir archivos del proyecto y metadata: CPID, Timestamp, ID, etc.
               loProject.KeySort = 2

               Messagebox('convert')
               For Each loReg In loProject &&FOXOBJECT
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<Chr(9)>>.ADD('<<loReg.NAME>>')
                  ENDTEXT
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
                            <<Chr(9)+Chr(9)>><<'&'>><<'&'>> <<C_FILE_META_I>>
                            Type="<<loReg.TYPE>>"
                            Cpid="<<INT( loReg.CPID )>>"
                            Timestamp="<<INT( loReg.TIMESTAMP )>>"
                            ID="<<INT( loReg.ID )>>"
                            ObjRev="<<INT( loReg.OBJREV )>>"
                            User=""
                            <<C_FILE_META_F>>
                  ENDTEXT
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
                     C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(lcCurdir + '" + loReg.Name + "').Description = '" + loReg.COMMENTS + "'"
                  Endif
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
                     C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(lcCurdir + '" + loReg.Name + "').Exclude = .T."
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
                     C_FB2PRG_CODE = C_FB2PRG_CODE + Chr(13) + Chr(10) + Chr(9) + ".ITEM(lcCurdir + '" + loReg.Name + "').Type = 'T'"
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
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<Chr(9)>>.SetMain(lcCurdir + '<<loProject._MainProg>>')
                  ENDTEXT
               Endif

               If Not Empty(loProject._Icon)
                  TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<Chr(9)>>.Icon = lcCurdir + '<<loProject._Icon>>'
                  ENDTEXT
               Endif

               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>>.Debug = <<loProject._Debug>>
                        <<Chr(9)>>.Encrypted = <<loProject._Encrypted>>
                        <<Chr(9)>>*<.CmntStyle = <<loProject._CmntStyle>> />
                        <<Chr(9)>>*<.NoLogo = <<loProject._NoLogo>> />
                        <<Chr(9)>>*<.SaveCode = <<loProject._SaveCode>> />
                        <<Chr(9)>>*<.User = '<<loProject._User>>' />
                        <<Chr(9)>>.ProjectHookLibrary = '<<loProject._ProjectHookLibrary>>'
                        <<Chr(9)>>.ProjectHookClass = '<<loProject._ProjectHookClass>>'
                        <<Chr(9)>><<C_PROJPROPS_F>>
                        <<C_ENDWITH>>
                        <<>>
               ENDTEXT


               *-- Build y cierre
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<>>
                        _VFP.Projects('<<lcPjxName>>').Close()
               ENDTEXT

               *-- Restauro Directorio de inicio
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        *ERASE '__newproject.f2b'
                        CD (lcCurdir)
                        RETURN
               ENDTEXT

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

            Endwith && THIS
         Endif

         toFoxBin2Prg.updateProcessedFile()


         *-- Genero el PJ2
         This.updateProgressbar( 'Writing ' + toFoxBin2Prg.getCfgValue('c_PJ2') + '...', 2, 2, 1 )

         If This.l_Test
            toModulo    = C_FB2PRG_CODE
         Else
            This.write_OutputFile( (C_FB2PRG_CODE), This.c_OutputFile, @toFoxBin2Prg )
         Endif


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
         *USE IN (SELECT("TABLABIN"))
         Store .Null. To loProject, loReg, loServerHead, loServerData
         Release toModulo, toEx, toFoxBin2Prg ;
            , lnCodError, lcStr, lnPos, lnLen, lnServerCount, loReg, lnLen ;
            , lcStrPJM, laLines, laProps, loProject, loServerHead, loServerData

      Endtry

      Return
   Endproc


   Procedure strExtract_CR
      Lparameters tcText
      tcText  = This.decode_SpecialCodes_CR_LF( Strextract( tcText, 'Comments=', CR_LF ) )
      Return tcText
   Endproc

Enddefine
