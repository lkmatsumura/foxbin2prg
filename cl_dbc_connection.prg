#INCLUDE foxbin2prg.h

Define Class CL_DBC_CONNECTION As CL_DBC_BASE Of 'cl_dbc_base.prg'
   #If .F.
      Local This As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_comment" display="_Comment"/>] ;
      + [<memberdata name="_datasource" display="_DataSource"/>] ;
      + [<memberdata name="_database" display="_Database"/>] ;
      + [<memberdata name="_connectstring" display="_ConnectString"/>] ;
      + [<memberdata name="_asynchronous" display="_Asynchronous"/>] ;
      + [<memberdata name="_batchmode" display="_BatchMode"/>] ;
      + [<memberdata name="_connecttimeout" display="_ConnectTimeout"/>] ;
      + [<memberdata name="_disconnectrollback" display="_DisconnectRollback"/>] ;
      + [<memberdata name="_displogin" display="_DispLogin"/>] ;
      + [<memberdata name="_dispwarnings" display="_DispWarnings"/>] ;
      + [<memberdata name="_idletimeout" display="_IdleTimeout"/>] ;
      + [<memberdata name="_packetsize" display="_PacketSize"/>] ;
      + [<memberdata name="_password" display="_PassWord"/>] ;
      + [<memberdata name="_querytimeout" display="_QueryTimeout"/>] ;
      + [<memberdata name="_transactions" display="_Transactions"/>] ;
      + [<memberdata name="_userid" display="_UserId"/>] ;
      + [<memberdata name="_waittime" display="_WaitTime"/>] ;
      + [</VFPData>]


   *-- Info
   _Name                   = ''
   _Comment                = ''
   _DataSource             = ''
   _Database               = ''
   _ConnectString          = ''
   _Asynchronous           = .F.
   _BatchMode              = .F.
   _ConnectTimeout         = 0
   _DisconnectRollback     = .F.
   _DispLogin              = 0
   _DispWarnings           = .F.
   _IdleTimeout            = 0
   _PacketSize             = 0
   _PassWord               = ''
   _QueryTimeout           = 0
   _Transactions           = ''
   _UserId                 = ''
   _WaitTime               = 0


   Procedure analyzeCodeBlock
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      Try
         Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_CONNECTION_I)) == C_CONNECTION_I
            llBloqueEncontrado  = .T.

            With This As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_CONNECTION_F $ tcLine    && Fin
                     Exit

                  Case '<Comment>' $ tcLine
                     .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                  Otherwise   && Propiedad de CONNECTION
                     *-- Estructura a reconocer:
                     *   <name>NOMBRE</name>
                     lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                     lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                     .add_Property( '_' + lcPropName, lcValue )
                  Endcase
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx
         If loEx.ErrorNo = 1470  && Incorrect property name.
            loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine) + ', PropName=[' + Transform(lcPropName) + '], Value=[' + Transform(lcValue) + ']'
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcConnection              (v! IN    ) Nombre de la Conexión
      *---------------------------------------------------------------------------------------------------
      Lparameters tcConnection

      Try
         Local lcText, loEx As Exception

         With This As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg'
            .read_BinDataToProperties(tcConnection)

            TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)+Chr(9)>><CONNECTION>
                    <<Chr(9)+Chr(9)+Chr(9)>><Name><<._Name>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)>><DataSource><<._DataSource>></DataSource>
                    <<Chr(9)+Chr(9)+Chr(9)>><Database><<._Database>></Database>
                    <<Chr(9)+Chr(9)+Chr(9)>><ConnectString><<._ConnectString>></ConnectString>
                    <<Chr(9)+Chr(9)+Chr(9)>><Asynchronous><<._Asynchronous>></Asynchronous>
                    <<Chr(9)+Chr(9)+Chr(9)>><BatchMode><<._BatchMode>></BatchMode>
                    <<Chr(9)+Chr(9)+Chr(9)>><ConnectTimeout><<._ConnectTimeout>></ConnectTimeout>
                    <<Chr(9)+Chr(9)+Chr(9)>><DisconnectRollback><<._DisconnectRollback>></DisconnectRollback>
                    <<Chr(9)+Chr(9)+Chr(9)>><DispLogin><<._DispLogin>></DispLogin>
                    <<Chr(9)+Chr(9)+Chr(9)>><DispWarnings><<._DispWarnings>></DispWarnings>
                    <<Chr(9)+Chr(9)+Chr(9)>><IdleTimeout><<._IdleTimeout>></IdleTimeout>
                    <<Chr(9)+Chr(9)+Chr(9)>><PacketSize><<._PacketSize>></PacketSize>
                    <<Chr(9)+Chr(9)+Chr(9)>><PassWord><<._PassWord>></PassWord>
                    <<Chr(9)+Chr(9)+Chr(9)>><QueryTimeout><<._QueryTimeout>></QueryTimeout>
                    <<Chr(9)+Chr(9)+Chr(9)>><Transactions><<._Transactions>></Transactions>
                    <<Chr(9)+Chr(9)+Chr(9)>><UserId><<._UserId>></UserId>
                    <<Chr(9)+Chr(9)+Chr(9)>><WaitTime><<._WaitTime>></WaitTime>
                    <<Chr(9)+Chr(9)>></CONNECTION>
            ENDTEXT

            ._ToText    = lcText
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcText
   Endproc


   Procedure getBinMemoFromProperties
      Local lcBinData
      lcBinData   = ''

      With This As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg'
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Asynchronous, .getDBCPropertyIDByName('Asynchronous', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._BatchMode, .getDBCPropertyIDByName('BatchMode', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DispWarnings, .getDBCPropertyIDByName('DispWarnings') )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DispLogin, .getDBCPropertyIDByName('DispLogin', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Transactions, .getDBCPropertyIDByName('Transactions', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DisconnectRollback, .getDBCPropertyIDByName('DisconnectRollback', .T.) ) && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ConnectTimeout , .getDBCPropertyIDByName('ConnectTimeout', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._QueryTimeout, .getDBCPropertyIDByName('QueryTimeout', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._IdleTimeout, .getDBCPropertyIDByName('IdleTimeout', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._WaitTime, .getDBCPropertyIDByName('WaitTime', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._PacketSize, .getDBCPropertyIDByName('PacketSize', .T.) ) && Undocumented
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DataSource, .getDBCPropertyIDByName('DataSource', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UserId, .getDBCPropertyIDByName('UserId', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._PassWord, .getDBCPropertyIDByName('PassWord', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Database, .getDBCPropertyIDByName('Database', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ConnectString, .getDBCPropertyIDByName('ConnectString', .T.) )
         lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
      Endwith

      Return lcBinData
   Endproc


   Procedure read_BinDataToProperties
      Lparameters tcConnection

      With This As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg'
         If Not ._Saved Then
            ._Name                  = Alltrim(tcConnection)
            ._Comment               = DBGetProp(tcConnection,"CONNECTION","Comment")
            ._DataSource            = DBGetProp(tcConnection,"CONNECTION","DataSource")
            ._Database              = DBGetProp(tcConnection,"CONNECTION","Database")
            ._ConnectString         = DBGetProp(tcConnection,"CONNECTION","ConnectString")
            ._Asynchronous          = DBGetProp(tcConnection,"CONNECTION","Asynchronous")
            ._BatchMode             = DBGetProp(tcConnection,"CONNECTION","BatchMode")
            ._ConnectTimeout        = DBGetProp(tcConnection,"CONNECTION","ConnectTimeout")
            ._DisconnectRollback    = DBGetProp(tcConnection,"CONNECTION","DisconnectRollback")
            ._DispLogin             = DBGetProp(tcConnection,"CONNECTION","DispLogin")
            ._DispWarnings          = DBGetProp(tcConnection,"CONNECTION","DispWarnings")
            ._IdleTimeout           = DBGetProp(tcConnection,"CONNECTION","IdleTimeout")
            ._PacketSize            = DBGetProp(tcConnection,"CONNECTION","PacketSize")
            ._PassWord              = DBGetProp(tcConnection,"CONNECTION","PassWord")
            ._QueryTimeout          = DBGetProp(tcConnection,"CONNECTION","QueryTimeout")
            ._Transactions          = DBGetProp(tcConnection,"CONNECTION","Transactions")
            ._UserId                = DBGetProp(tcConnection,"CONNECTION","UserId")
            ._WaitTime              = DBGetProp(tcConnection,"CONNECTION","WaitTime")
            *--
            ._Saved     = .T.
         Endif
      Endwith
   Endproc


Enddefine
