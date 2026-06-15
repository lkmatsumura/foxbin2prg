#INCLUDE foxbin2prg.h

Define Class CL_PROJ_SRV_HEAD As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_internalname" display="_InternalName"/>] ;
      + [<memberdata name="_libraryname" display="_LibraryName"/>] ;
      + [<memberdata name="_projectname" display="_ProjectName"/>] ;
      + [<memberdata name="_servercount" display="_ServerCount"/>] ;
      + [<memberdata name="_servers" display="_Servers"/>] ;
      + [<memberdata name="_servertype" display="_ServerType"/>] ;
      + [<memberdata name="_typelib" display="_TypeLib"/>] ;
      + [<memberdata name="_typelibdesc" display="_TypeLibDesc"/>] ;
      + [<memberdata name="add_server" display="add_Server"/>] ;
      + [<memberdata name="decode_specialcodes_cr_lf" display="decode_SpecialCodes_CR_LF"/>] ;
      + [<memberdata name="encode_specialcodes_cr_lf" display="encode_SpecialCodes_CR_LF"/>] ;
      + [<memberdata name="getdatafrompair_lendata_structure" display="getDataFromPair_LenData_Structure"/>] ;
      + [<memberdata name="getformattedservertext" display="getFormattedServerText"/>] ;
      + [<memberdata name="getrowserverinfo" display="getRowServerInfo"/>] ;
      + [<memberdata name="getserverdataobject" display="getServerDataObject"/>] ;
      + [<memberdata name="parseserverinfo" display="parseServerInfo"/>] ;
      + [<memberdata name="setparsedheadinfoline" display="setParsedHeadInfoLine"/>] ;
      + [<memberdata name="setparsedinfoline" display="setParsedInfoLine"/>] ;
      + [</VFPData>]

   *-- Información interesante sobre Servidores OLE y corrupción de IDs: http://www.west-wind.com/wconnect/weblog/ShowEntry.blog?id=880

   *-- Server Head info
   Dimension _Servers[1]
   _ServerCount        = 0
   _LibraryName        = ''
   _InternalName       = ''
   _ProjectName        = ''
   _TypeLibDesc        = ''
   _ServerType         = ''
   _TypeLib            = ''



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



   Procedure setParsedHeadInfoLine
      Lparameters tcHeadInfoLine
      This.setParsedInfoLine( This, tcHeadInfoLine )
   Endproc



   Procedure setParsedInfoLine
      Lparameters toObject, tcInfoLine

      Local lcAsignacion, lcCurDir, lcValue, loEx As Exception

      Try
         If Left(tcInfoLine,1) == '.'
            lcAsignacion    = 'toObject' + tcInfoLine
         Else
            lcAsignacion    = 'toObject.' + tcInfoLine
         Endif

         lcValue = Getwordnum(lcAsignacion, 2, '=')

         If Type(lcValue) = "C" Then
            lcAsignacion    = Getwordnum(lcAsignacion, 1, '=') + '= THIS.encode_SpecialCodes_CR_LF(' + Getwordnum(lcAsignacion, 2, '=') + ')'
         Endif

         &lcAsignacion.

      Catch To loEx
         loEx.UserValue = loEx.UserValue + 'lcAsignacion = [' + Transform(lcAsignacion) + ']' + CR_LF
         Throw
      Endtry

      Return
   Endproc



   Procedure add_Server
      Lparameters toServerData

      #If .F.
         Local toServerData As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg'
      #Endif

      With This As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg'
         ._ServerCount   = ._ServerCount + 1
         Dimension ._Servers( ._ServerCount )
         ._Servers( ._ServerCount )  = toServerData
      Endwith && THIS
   Endproc



   Procedure getDataFromPair_LenData_Structure
      Lparameters tcData, tnPos, tnLen
      Local lcData, lnLen
      tnPos   = tnPos + 4 + tnLen
      tnLen   = Int( Val( Substr( tcData, tnPos, 4 ) ) )
      lcData  = Substr( tcData, tnPos + 4, tnLen )
      Return lcData
   Endproc


   Procedure getServerDataObject
      Return NewObject('CL_PROJ_SRV_DATA', 'cl_proj_srv_data.prg')
   Endproc



   Procedure parseServerInfo
      Lparameters tcServerInfo

      If Not Empty(tcServerInfo)
         Try
            Local loServerData As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg'

            With This As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg'
               lcStr           = ''
               lnPos           = 1
               lnLen           = 4

               lnServerCount   = Int( Val( .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen ) ) )
               ._LibraryName   = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
               ._InternalName  = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
               ._ProjectName   = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
               ._TypeLibDesc   = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
               ._ServerType    = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
               ._TypeLib       = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )

               *-- Información de los servidores
               For I = 1 To lnServerCount
                  loServerData    = .Null.
                  loServerData    = .getServerDataObject()

                  loServerData._HelpContextID = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
                  loServerData._ServerName    = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
                  loServerData._Description   = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
                  loServerData._HelpFile      = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
                  loServerData._ServerClass   = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
                  loServerData._ClassLibrary  = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
                  loServerData._Instancing    = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
                  loServerData._CLSID         = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )
                  loServerData._Interface     = .getDataFromPair_LenData_Structure( @tcServerInfo, @lnPos, @lnLen )

                  .add_Server( loServerData )
               Endfor

            Endwith && THIS

         Catch To loEx
            If This.n_Debug > 0 And _vfp.StartMode = 0
               Set Step On
            Endif

            Throw

         Finally
            loServerData    = .Null.
            Release loServerData

         Endtry

      Endif
   Endproc



   Procedure getRowServerInfo
      Try
         Local lcStr, lnLenH, lnLen, lnPos ;
            , loServerData As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg'
         Store .Null. To loServerData
         lcStr               = ''

         With This As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg'
            If ._ServerCount > 0
               lnPos       = 1
               lnLen       = 4
               lnLenH      = 103 && Al final es una constante fija :(    4 + 8 + 4 + LEN(._LibraryName) + 4 + LEN(._InternalName) + 4 + LEN(._ProjectName) + 4 + LEN(._TypeLibDesc) - 1

               *-- Header
               lcStr       = lcStr + Padl( 4, 4, ' ' ) + Padl( lnLenH, 4, ' ' )
               lcStr       = lcStr + Padl( 4, 4, ' ' ) + Padl( ._ServerCount, 4, ' ' )
               lcStr       = lcStr + Padl( Len(._LibraryName), 4, ' ' ) + ._LibraryName
               lcStr       = lcStr + Padl( Len(._InternalName), 4, ' ' ) + ._InternalName
               lcStr       = lcStr + Padl( Len(._ProjectName), 4, ' ' ) + ._ProjectName
               lcStr       = lcStr + Padl( Len(._TypeLibDesc), 4, ' ' ) + ._TypeLibDesc
               lcStr       = lcStr + Padl( Len(._ServerType), 4, ' ' ) + ._ServerType
               lcStr       = lcStr + Padl( Len(._TypeLib), 4, ' ' ) + ._TypeLib

               For I = 1 To ._ServerCount
                  loServerData    = ._Servers(m.I)
                  lcStr       = lcStr + loServerData.getRowServerInfo()
               Endfor
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loServerData
         Release lnLenH, lnLen, lnPos, loServerData

      Endtry

      Return lcStr
   Endproc



   Procedure getFormattedServerText
      Try
         Local lcText ;
            , loServerData As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg'
         Store .Null. To loServerData
         lcText  = ''

         With This As CL_PROJ_SRV_HEAD Of 'cl_proj_srv_head.prg'
            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<C_SRV_HEAD_I>>
                    _LibraryName = '<<._LibraryName>>'
                    _InternalName = '<<._InternalName>>'
                    _ProjectName = '<<._ProjectName>>'
                    _TypeLibDesc = '<<._TypeLibDesc>>'
                    _ServerType = '<<._ServerType>>'
                    _TypeLib = '<<._TypeLib>>'
                    <<C_SRV_HEAD_F>>
            ENDTEXT

            *-- Recorro los servidores
            For I = 1 To ._ServerCount
               loServerData    = ._Servers(m.I)
               lcText          = lcText + loServerData.getFormattedServerText()
               loServerData    = .Null.
            Endfor
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loServerData
         Release loServerData

      Endtry

      Return lcText
   Endproc
Enddefine
