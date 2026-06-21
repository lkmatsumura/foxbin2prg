#INCLUDE foxbin2prg.h

Define Class c_conversor_dbc_a_prg As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   #If .F.
      Local This As c_conversor_dbc_a_prg Of 'c_conversor_dbc_a_prg.prg'
   #Endif
   c_Type                  = 'DBC'


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
         With This As c_conversor_dbc_a_prg Of 'c_conversor_dbc_a_prg.prg'
            Local lnCodError, laDatabases(1), lnDatabases_Count, lcEventsFile, lcExternalHeader, lcCodigo ;
               , lnClassCount, laClasses(1,3) ;
               , loConnection As CL_DBC_CONNECTION Of 'cl_dbc_connection.prg' ;
               , loTable As CL_DBC_TABLE Of 'cl_dbc_table.prg' ;
               , loView As CL_DBC_VIEW Of 'cl_dbc_view.prg'

            Store .Null. To loRelation, loView, loTable
            Store 0 To lnCodError, lnDatabases_Count, lnClassCount
            Store '' To laDatabases, lcEventsFile, lcExternalHeader, laClasses, lcCodigo, C_FB2PRG_CODE

            lnDatabases_Count   = Adatabases(laDatabases)
            Use (.c_InputFile) Shared Again Noupdate Alias TABLABIN

            *LScheffler 20.08.2023
            *issue #96, including issue #95, [KestasL] keep CodePage relavant information for binary sources
            toFoxBin2Prg.i_CPID = Cpdbf("TABLABIN")
            Set NoCPTrans To OBJECTNAME,User
            */LScheffler 20.08.2023

            If toFoxBin2Prg.l_ProcessFiles Then
               toDatabase          = NewObject('CL_DBC', 'cl_dbc.prg')
               toDatabase._DBC     = .c_InputFile
               toDatabase.read_DBC_Header()

               *-- Verifico si hay archivo de eventos, y si hay uno definido pero no existe el archivo,
               *-- creo uno temporalmente para poder abrir la BDD y luego lo elimino.
               If toDatabase._DBCEvents And Not Empty(toDatabase._DBCEventFilename) Then
                  *-- El archivo de eventos puede tener path relativo o absoluto
                  *-- Ajusto la ruta si no es absoluta
                  lcEventsFile    = toFoxBin2Prg.get_AbsolutePath( toDatabase._DBCEventFilename, .c_InputFile )
                  If File(lcEventsFile) Then
                     lcEventsFile    = ''
                  Else
                     Strtofile( '', lcEventsFile )
                     Compile (lcEventsFile)
                  Endif
               Endif

               Open Database (.c_InputFile) Shared Noupdate

               .updateProgressbar( 'Analyzing DBC metadata...', 1, 2, 1 )

               C_FB2PRG_CODE   = C_FB2PRG_CODE + toDatabase.toText(@toFoxBin2Prg)

               *-- Header
               If toFoxBin2Prg.getCfgValue('n_UseFilesPerDBC') > 0 Then
                  .write_EXTERNAL_MEMBER_HEADER( @toFoxBin2Prg, .F., .F., @lcExternalHeader )

                  *-- Connections
                  For Each loConnection In toDatabase._Connections &&FOXOBJECT
                     lnClassCount    = lnClassCount + 1
                     Dimension laClasses(lnClassCount,3)
                     laClasses(lnClassCount,1)   = Lower( loConnection._Name )
                     laClasses(lnClassCount,2)   = loConnection._ToText
                     laClasses(lnClassCount,3)   = 'connection'
                     .write_EXTERNAL_MEMBER_HEADER( @toFoxBin2Prg, laClasses(lnClassCount,1), laClasses(lnClassCount,3), @lcExternalHeader )
                  Endfor

                  *-- Tables
                  For Each loTable In toDatabase._Tables &&FOXOBJECT
                     lnClassCount    = lnClassCount + 1
                     Dimension laClasses(lnClassCount,3)
                     laClasses(lnClassCount,1)   = Lower( loTable._Name )
                     laClasses(lnClassCount,2)   = loTable._ToText
                     laClasses(lnClassCount,3)   = 'table'
                     .write_EXTERNAL_MEMBER_HEADER( @toFoxBin2Prg, laClasses(lnClassCount,1), laClasses(lnClassCount,3), @lcExternalHeader )
                  Endfor

                  *-- Views
                  For Each loView In toDatabase._Views &&FOXOBJECT
                     lnClassCount    = lnClassCount + 1
                     Dimension laClasses(lnClassCount,3)
                     laClasses(lnClassCount,1)   = Lower( loView._Name )
                     laClasses(lnClassCount,2)   = loView._ToText
                     laClasses(lnClassCount,3)   = 'view'
                     .write_EXTERNAL_MEMBER_HEADER( @toFoxBin2Prg, laClasses(lnClassCount,1), laClasses(lnClassCount,3), @lcExternalHeader )
                  Endfor

                  *-- Stored Procedures
                  If Not Empty(toDatabase._StoredProcedures) Then
                     lnClassCount    = lnClassCount + 1
                     Dimension laClasses(lnClassCount,3)
                     laClasses(lnClassCount,1)   = Lower( 'storedproceduressource' )
                     laClasses(lnClassCount,2)   = toDatabase._StoredProcedures
                     laClasses(lnClassCount,3)   = 'database'
                     .write_EXTERNAL_MEMBER_HEADER( @toFoxBin2Prg, laClasses(lnClassCount,1), laClasses(lnClassCount,3), @lcExternalHeader )
                  Endif

                  lcExternalHeader    = lcExternalHeader + CR_LF
               Endif

            Else
               *-- No procesar, solo reportar
               _Tally  = 0
               Select Lower(TB.OBJECTNAME), '', Lower(TB.ObjectType) ;
                  FROM TABLABIN TB ;
                  WHERE TB.ParentId = 1 And ( TB.ObjectType In (Padr('View',10), Padr('Table',10), Padr('Connection',10) ) ;
                  OR TB.ObjectType = Padr('Database',10) And TB.OBJECTNAME = Padr('StoredProceduresSource',128) And Not Empty(TB.Code) ) ;
                  INTO Array laClasses
               lnClassCount    = _Tally
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


            *-- Genero el DC2
            lcOutputFile    = .c_OutputFile

            If toFoxBin2Prg.l_ProcessFiles Then
               .updateProgressbar( 'Writing ' + toFoxBin2Prg.getCfgValue('c_DC2') + '...', 2, 2, 1 )
               lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + lcExternalHeader + C_FB2PRG_CODE
            Endif

            If .l_Test
               *FOR I = 1 TO lnClassCount
               *   lcCodigo    = lcCodigo + laClasses(m.I,2)
               *ENDFOR
               *toDatabase = lcCodigo
            Else

               If toFoxBin2Prg.getCfgValue('n_UseFilesPerDBC') > 0 Then
                  .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )

                  For I = 1 To lnClassCount
                     * lcOutputFile = '<path>DBCName' + '.' + 'MemberType' + '.' + 'MemberName' + '.' + 'dc2'
                     lcOutputFile    = Addbs( Justpath( .c_OutputFile ) ) + Juststem( .c_OutputFile ) + '.' + laClasses(m.I,3) + '.' + laClasses(m.I,1) + '.' + Justext( .c_OutputFile )
                     lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + laClasses(m.I,2)
                     .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                  Endfor
               Else
                  For I = 1 To lnClassCount
                     lcCodigo    = lcCodigo + laClasses(m.I,2)
                  Endfor

                  .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
               Endif
            Endif
         Endwith && THIS


      Catch To toEx
         This.set_UserValue(@toEx)

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Close Databases
         If Not Empty(lcEventsFile) Then
            Erase (lcEventsFile)
            Erase (Forceext(lcEventsFile,'FXP'))
         Endif
         Release toDatabase, toEx, toFoxBin2Prg ;
            , lnCodError, laDatabases, lnDatabases_Count
      Endtry

      Return
   Endproc

Enddefine
