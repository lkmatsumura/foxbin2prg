#INCLUDE foxbin2prg.h

Define Class CL_PROJ_SRV_DATA As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_PROJ_SRV_DATA Of 'cl_proj_srv_data.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_classlibrary" display="_ClassLibrary"/>] ;
      + [<memberdata name="_clsid" display="_CLSID"/>] ;
      + [<memberdata name="_description" display="_Description"/>] ;
      + [<memberdata name="_helpcontextid" display="_HelpContextID"/>] ;
      + [<memberdata name="_helpfile" display="_HelpFile"/>] ;
      + [<memberdata name="_interface" display="_Interface"/>] ;
      + [<memberdata name="_instancing" display="_Instancing"/>] ;
      + [<memberdata name="_serverclass" display="_ServerClass"/>] ;
      + [<memberdata name="_servername" display="_ServerName"/>] ;
      + [<memberdata name="getformattedservertext" display="getFormattedServerText"/>] ;
      + [<memberdata name="getrowserverinfo" display="getRowServerInfo"/>] ;
      + [</VFPData>]

   _HelpContextID  = 0
   _ServerName     = ''
   _Description    = ''
   _HelpFile       = ''
   _ServerClass    = ''
   _ClassLibrary   = ''
   _Instancing     = 0
   _CLSID          = ''
   _Interface      = ''



   Procedure getRowServerInfo
      Try
         Local lcStr, lnLen, lnPos

         lcStr               = ''

         With This
            If Not Empty(._ServerName)
               lnPos               = 1
               lnLen               = 4

               *-- Data
               lcStr   = lcStr + Padl( Len(._HelpContextID), 4, ' ' ) + ._HelpContextID
               lcStr   = lcStr + Padl( Len(._ServerName), 4, ' ' ) + ._ServerName
               lcStr   = lcStr + Padl( Len(._Description), 4, ' ' ) + ._Description
               lcStr   = lcStr + Padl( Len(._HelpFile), 4, ' ' ) + ._HelpFile
               lcStr   = lcStr + Padl( Len(._ServerClass), 4, ' ' ) + ._ServerClass
               lcStr   = lcStr + Padl( Len(._ClassLibrary), 4, ' ' ) + ._ClassLibrary
               lcStr   = lcStr + Padl( Len(._Instancing), 4, ' ' ) + ._Instancing
               lcStr   = lcStr + Padl( Len(._CLSID), 4, ' ' ) + ._CLSID
               lcStr   = lcStr + Padl( Len(._Interface), 4, ' ' ) + ._Interface
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcStr
   Endproc



   Procedure getFormattedServerText
      Try
         Local lcText
         lcText  = ''

         With This
            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<C_SRV_DATA_I>>
                    _HelpContextID = '<<._HelpContextID>>'
                    _ServerName = '<<._ServerName>>'
                    _Description = '<<._Description>>'
                    _HelpFile = '<<._HelpFile>>'
                    _ServerClass = '<<._ServerClass>>'
                    _ClassLibrary = '<<._ClassLibrary>>'
                    _Instancing = '<<._Instancing>>'
                    _CLSID = '<<._CLSID>>'
                    _Interface = '<<._Interface>>'
                    <<C_SRV_DATA_F>>
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

Enddefine
