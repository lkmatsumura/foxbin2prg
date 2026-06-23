#INCLUDE foxbin2prg.h

Define Class CL_PROJECT As CL_COL_BASE Of 'cl_col_base.prg'
   #If .F.
      Local This As CL_PROJECT Of 'cl_project.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="c_inputfile" display="c_InputFile"/>] ;
      + [<memberdata name="_cmntstyle" display="_CmntStyle"/>] ;
      + [<memberdata name="_debug" display="_Debug"/>] ;
      + [<memberdata name="_encrypted" display="_Encrypted"/>] ;
      + [<memberdata name="_homedir" display="_HomeDir"/>] ;
      + [<memberdata name="_icon" display="_Icon"/>] ;
      + [<memberdata name="_mainprog" display="_MainProg"/>] ;
      + [<memberdata name="_nologo" display="_NoLogo"/>] ;
      + [<memberdata name="_objrev" display="_ObjRev"/>] ;
      + [<memberdata name="_projecthookclass" display="_ProjectHookClass"/>] ;
      + [<memberdata name="_projecthooklibrary" display="_ProjectHookLibrary"/>] ;
      + [<memberdata name="_savecode" display="_SaveCode"/>] ;
      + [<memberdata name="_serverinfo" display="_ServerInfo"/>] ;
      + [<memberdata name="_serverhead" display="_ServerHead"/>] ;
      + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
      + [<memberdata name="_cpid" display="_CPID"/>] ;
      + [<memberdata name="_timestamp" display="_TimeStamp"/>] ;
      + [<memberdata name="_version" display="_Version"/>] ;
      + [<memberdata name="_sccdata" display="_SccData"/>] ;
      + [<memberdata name="_address" display="_Address"/>] ;
      + [<memberdata name="_author" display="_Author"/>] ;
      + [<memberdata name="_company" display="_Company"/>] ;
      + [<memberdata name="_city" display="_City"/>] ;
      + [<memberdata name="_state" display="_State"/>] ;
      + [<memberdata name="_postalcode" display="_PostalCode"/>] ;
      + [<memberdata name="_country" display="_Country"/>] ;
      + [<memberdata name="_comments" display="_Comments"/>] ;
      + [<memberdata name="_companyname" display="_CompanyName"/>] ;
      + [<memberdata name="_filedescription" display="_FileDescription"/>] ;
      + [<memberdata name="_legalcopyright" display="_LegalCopyright"/>] ;
      + [<memberdata name="_legaltrademark" display="_LegalTrademark"/>] ;
      + [<memberdata name="_productname" display="_ProductName"/>] ;
      + [<memberdata name="_majorver" display="_MajorVer"/>] ;
      + [<memberdata name="_minorver" display="_MinorVer"/>] ;
      + [<memberdata name="_revision" display="_Revision"/>] ;
      + [<memberdata name="_languageid" display="_LanguageID"/>] ;
      + [<memberdata name="_autoincrement" display="_AutoIncrement"/>] ;
      + [<memberdata name="_user" display="_User"/>] ;
      + [<memberdata name="decode_specialcodes_cr_lf" display="decode_SpecialCodes_CR_LF"/>] ;
      + [<memberdata name="encode_specialcodes_cr_lf" display="encode_SpecialCodes_CR_LF"/>] ;
      + [<memberdata name="getformatteddevinfotext" display="getFormattedDevInfoText"/>] ;
      + [<memberdata name="getfilesnotfound" display="getFilesNotFound"/>] ;
      + [<memberdata name="parseDevInfo" display="parseDevInfo"/>] ;
      + [<memberdata name="parsenullterminatedvalue" display="parseNullTerminatedValue"/>] ;
      + [<memberdata name="setparsedinfoline" display="setParsedInfoLine"/>] ;
      + [<memberdata name="setparsedprojinfoline" display="setParsedProjInfoLine"/>] ;
      + [<memberdata name="getRowDevInfo" display="getRowDevInfo"/>] ;
      + [</VFPData>]


   c_InputFile         = ''

   *-- Proj.Info
   _CmntStyle          = 1
   _Debug              = .F.
   _Encrypted          = .F.
   _HomeDir            = ''
   _Icon               = ''
   _ID                 = ''
   _MainProg           = ''
   _NoLogo             = .F.
   _ObjRev             = 0
   _ProjectHookClass   = ''
   _ProjectHookLibrary = ''
   _SaveCode           = .T.
   _ServerHead         = .Null.
   _ServerInfo         = ''
   _SourceFile         = ''

   * issue #96, [KestasL] keep CodePage relavant information for binary sources
   _cpid               = Cpcurrent()
   _TimeStamp          = 0
   _Version            = ''
   _SccData            = ''
   _User               = ''

   *-- Dev.info
   _Author             = ''
   _Company            = ''
   _Address            = ''
   _City               = ''
   _State              = ''
   _PostalCode         = ''
   _Country            = ''

   _Comments           = ''
   _CompanyName        = ''
   _FileDescription    = ''
   _LegalCopyright     = ''
   _LegalTrademark     = ''
   _ProductName        = ''
   _MajorVer           = ''
   _MinorVer           = ''
   _Revision           = ''
   _LanguageID         = ''
   _AutoIncrement      = ''



   Procedure Init
      DoDefault()
      This._ServerHead    = NewObject('CL_PROJ_SRV_HEAD', 'cl_proj_srv_head.prg')
   Endproc



   Procedure decode_SpecialCodes_CR_LF
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcText                    (!@ IN    ) Decodifica los caracteres ASCII 10 y 13 de {nCode} a CHR(nCode)
      *---------------------------------------------------------------------------------------------------
      Lparameters tcText
      tcText  = Strtran( Strtran( tcText, '{10}', Chr(10) ), '{13}', Chr(13) )
      Return tcText
   Endproc



   Procedure encode_SpecialCodes_CR_LF
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcText                    (!@ IN    ) Codifica los caracteres ASCII 10 y 13 de CHR(nCode) a {nCode}
      *---------------------------------------------------------------------------------------------------
      Lparameters tcText
      tcText  = Strtran( Strtran( tcText, Chr(10), '{10}' ), Chr(13), '{13}' )
      Return tcText
   Endproc



   Procedure setParsedProjInfoLine
      Lparameters tcProjInfoLine
      This.setParsedInfoLine( This, tcProjInfoLine )
   Endproc



   Procedure setParsedInfoLine
      Lparameters toObject, tcInfoLine

      Local lcAsignacion, lcCurDir, lcValue, loEx As Exception

      Try
         lcCurDir    = Addbs(This._HomeDir)
         If Left(tcInfoLine,1) == '.'
            lcAsignacion = 'toObject' + tcInfoLine
         Else
            lcAsignacion = 'toObject.' + tcInfoLine
         Endif

         lcValue = Getwordnum(lcAsignacion, 2, '=')

         If Type(lcValue) = "C" Then
            lcAsignacion = Getwordnum(lcAsignacion, 1, '=') + '= THIS.encode_SpecialCodes_CR_LF(' + lcValue + ')'
         Endif

         &lcAsignacion.

      Catch To loEx
         loEx.UserValue = loEx.UserValue + 'lcAsignacion = [' + Transform(lcAsignacion) + ']' + CR_LF
         Throw
      Endtry

      Return
   Endproc



   Procedure parseNullTerminatedValue
      Lparameters tcDevInfo, tnPos, tnLen
      Local lcValue, lnNullPos
      
      lcStr     = Substr( tcDevInfo, tnPos, tnLen )
      lnNullPos = At(Chr(0), lcStr )
      
      If lnNullPos = 0
         lcValue = Chrtran( Left( lcStr, tnLen ), ['], ["] )
      Else
         lcValue = Chrtran( Left( lcStr, Min(tnLen, lnNullPos - 1 ) ), ['], ["] )
      Endif
      lcValue = Alltrim( lcValue )
      lcValue = This.encode_SpecialCodes_CR_LF(lcValue)
      
      Return lcValue
   Endproc



   Procedure parseDevInfo
      Lparameters tcDevInfo

      Try
         With This As CL_PROJECT Of 'CL_PROJECT.prg'
            ._Author            = .parseNullTerminatedValue( @tcDevInfo,    1,  45 )
            ._Company           = .parseNullTerminatedValue( @tcDevInfo,   47,  45 )
            ._Address           = .parseNullTerminatedValue( @tcDevInfo,   93,  45 )
            ._City              = .parseNullTerminatedValue( @tcDevInfo,  139,  20 )
            ._State             = .parseNullTerminatedValue( @tcDevInfo,  160,   5 )
            ._PostalCode        = .parseNullTerminatedValue( @tcDevInfo,  166,  10 )
            ._Country           = .parseNullTerminatedValue( @tcDevInfo,  177,  45 )
            ._Comments          = .parseNullTerminatedValue( @tcDevInfo,  223, 254 )
            ._CompanyName       = .parseNullTerminatedValue( @tcDevInfo,  478, 254 )
            ._FileDescription   = .parseNullTerminatedValue( @tcDevInfo,  733, 254 )
            ._LegalCopyright    = .parseNullTerminatedValue( @tcDevInfo,  988, 254 )
            ._LegalTrademark    = .parseNullTerminatedValue( @tcDevInfo, 1243, 254 )
            ._ProductName       = .parseNullTerminatedValue( @tcDevInfo, 1498, 254 )
            ._MajorVer          = .parseNullTerminatedValue( @tcDevInfo, 1753,   4 )
            ._MinorVer          = .parseNullTerminatedValue( @tcDevInfo, 1758,   4 )
            ._Revision          = .parseNullTerminatedValue( @tcDevInfo, 1763,   4 )
            ._LanguageID        = .parseNullTerminatedValue( @tcDevInfo, 1768,  19 )
            ._AutoIncrement     = Transform(Asc(Substr(tcDevInfo, 1788, 1)))
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

   Endproc



   Procedure getRowDevInfo
      Lparameters tcDevInfo

      Try
         If Vartype(tcDevInfo) # 'C' Or Len(tcDevInfo) = 0
            tcDevInfo   = Replicate( Chr(0), 1795 )
         Endif

         With This As CL_PROJECT Of 'CL_PROJECT.prg'
            tcDevInfo   = Stuff( tcDevInfo,    1, Len(._Author), ._Author)
            tcDevInfo   = Stuff( tcDevInfo,   47, Len(._Company), ._Company)
            tcDevInfo   = Stuff( tcDevInfo,   93, Len(._Address), ._Address)
            tcDevInfo   = Stuff( tcDevInfo,  139, Len(._City), ._City)
            tcDevInfo   = Stuff( tcDevInfo,  160, Len(._State), ._State)
            tcDevInfo   = Stuff( tcDevInfo,  166, Len(._PostalCode), ._PostalCode)
            tcDevInfo   = Stuff( tcDevInfo,  177, Len(._Country), ._Country)
            tcDevInfo   = Stuff( tcDevInfo,  223, Len(._Comments), ._Comments)
            tcDevInfo   = Stuff( tcDevInfo,  478, Len(._CompanyName), ._CompanyName)
            tcDevInfo   = Stuff( tcDevInfo,  733, Len(._FileDescription), ._FileDescription)
            tcDevInfo   = Stuff( tcDevInfo,  988, Len(._LegalCopyright), ._LegalCopyright)
            tcDevInfo   = Stuff( tcDevInfo, 1243, Len(._LegalTrademark), ._LegalTrademark)
            tcDevInfo   = Stuff( tcDevInfo, 1498, Len(._ProductName), ._ProductName)
            tcDevInfo   = Stuff( tcDevInfo, 1753, Len(._MajorVer), ._MajorVer)
            tcDevInfo   = Stuff( tcDevInfo, 1758, Len(._MinorVer), ._MinorVer)
            tcDevInfo   = Stuff( tcDevInfo, 1763, Len(._Revision), ._Revision)
            tcDevInfo   = Stuff( tcDevInfo, 1768, Len(._LanguageID), ._LanguageID)
            tcDevInfo   = Stuff( tcDevInfo, 1788, 1, Chr(Val(._AutoIncrement)))
            tcDevInfo   = Stuff( tcDevInfo, 1792, 1, Chr(1))
         Endwith

      Catch To loEx
         lnCodError  = loEx.ErrorNo

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return tcDevInfo
   Endproc



   Procedure getFormattedDevinfoText
      Try
         Local lcText
         lcText      = ''

         With This As CL_PROJECT Of 'CL_PROJECT.prg'
            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
               <<C_DEVINFO_I>>
               _Author = "<<._Author>>"
               _Company = "<<._Company>>"
               _Address = "<<._Address>>"
               _City = "<<._City>>"
               _State = "<<._State>>"
               _PostalCode = "<<._PostalCode>>"
               _Country = "<<._Country>>"
               _Comments = "<<._Comments>>"
               _CompanyName = "<<._CompanyName>>"
               _FileDescription = "<<._FileDescription>>"
               _LegalCopyright = "<<._LegalCopyright>>"
               _LegalTrademark = "<<._LegalTrademark>>"
               _ProductName = "<<._ProductName>>"
               _MajorVer = "<<._MajorVer>>"
               _MinorVer = "<<._MinorVer>>"
               _Revision = "<<._Revision>>"
               _LanguageID = "<<._LanguageID>>"
               _AutoIncrement = "<<._AutoIncrement>>"
               <<C_DEVINFO_F>>
               <<>>
            ENDTEXT
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcText
   Endproc


   Function getFilesNotFound(taFiles) As Integer
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taFiles                   (?@    OUT) Codifica los caracteres ASCII 10 y 13 de CHR(nCode) a {nCode}
      *---------------------------------------------------------------------------------------------------
      External Array taFiles

      Try
         Local I, lnCount, laDirFile(1,5), lcHomeDir

         With This As CL_PROJECT Of 'CL_PROJECT.prg'
            Dimension taFiles( Max(1,.Count), 2)
            taFiles(1,1)    = ''
            taFiles(1,2)    = .F.
            lnCount         = 0
            lcHomeDir       = Addbs( Evl(Justpath(.c_InputFile), ._HomeDir) )

            For I = 1 To .Count
               taFiles(m.I,1)  = .Item(m.I).Name
               taFiles(m.I,2)  = ( Adir(laDirFile, .get_AbsolutePath( taFiles(m.I,1), lcHomeDir) ) = 1 )

               If Not taFiles(m.I,2)
                  lnCount = lnCount + 1
               Endif
            Endfor

         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lnCount
   Endfunc


Enddefine
