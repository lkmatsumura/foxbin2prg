#INCLUDE foxbin2prg.h

Define Class c_conversor_prg_a_scx As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
   #If .F.
      Local This As c_conversor_prg_a_scx Of 'c_conversor_prg_a_scx.prg'
   #Endif
   *_MEMBERDATA    = [<VFPData>] ;
   + [<memberdata name="escribirarchivobin" display="escribirArchivoBin"/>] ;
   + [</VFPData>]
   c_Type                  = 'SC2'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (@!    OUT) Objeto generado de clase CL_CLASSLIB con la información leida del texto
      * toEx                      (@!    OUT) Objeto con información del error
      * toFoxBin2Prg              (@! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

      Try
         Local lnCodError, laCodeLines(1), lnCodeLines, lcInputFile, lcInputFile_Form, lnFileCount, laFiles(1,5) ;
            , laLineasExclusion(1), lnBloquesExclusion, I, lnIDInputFile, lcFormName ;
            , lcSearchDir, lcBaseFilename, lcHeader ;
            , loLang As CL_LANG Of 'cl_lang.prg'

         With This As c_conversor_prg_a_vcx Of 'c_conversor_prg_a_vcx.prg'
            Store 0 To lnCodError, lnCodeLines
            Store '' To C_FB2PRG_CODE
            Store .Null. To toModulo

            loLang              = _Screen.o_FoxBin2Prg_Lang
            toModulo            = NewObject('CL_CLASSLIB', 'cl_classlib.prg')
            lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

            If toFoxBin2Prg.getCfgValue('n_UseFormPerFile') > 0 And toFoxBin2Prg.getCfgValue('l_RedirectFormPerFileToMain')
               lcHeader = toFoxBin2Prg.getPerFileOutputPath( Forceext(.c_InputFile, 'SCX'), '', toFoxBin2Prg.getCfgValue('c_SC2'), ;
                  toFoxBin2Prg.getCfgFlag('l_UseFormsPerDir'), toFoxBin2Prg.getCfgInt('n_UseFormPerFile') )
               If File(lcHeader)
                  .c_InputFile = lcHeader
               Endif
               C_FB2PRG_CODE       = Filetostr( .c_InputFile )

               lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

               .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
               .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toModulo, @toFoxBin2Prg )

               .updateProgressbar( 'Loading Code...', 2, lnCodeLines, 1 )

               *-- MÁSCARA DE BÚSQUEDA
               lcSearchDir         = toFoxBin2Prg.getPerFileSearchDir( .c_InputFile, Justext(.c_InputFile), ;
                  toFoxBin2Prg.getCfgFlag('l_UseFormsPerDir'), toFoxBin2Prg.getCfgInt('n_UseFormPerFile') )

               If toFoxBin2Prg.getCfgValue('n_UseFormPerFile') = 1 Then
                  *-- Esto crea la máscara de búsqueda "filename.*.ext" para encontrar las partes
                  lcBaseFilename      = Juststem( Juststem(.c_InputFile) )
                  lcInputFile         = Addbs( lcSearchDir ) + lcBaseFilename + '.*.' + Justext(.c_InputFile)
               Else && toFoxBin2Prg.getCfgValue('n_UseFormPerFile') = 2
                  *-- Esto crea la máscara de búsqueda "<path>Database.*.*.ext" para encontrar las partes
                  *-- con la sintaxis "<path>Database.MemberType.MemberName.ext"
                  lcBaseFilename      = Juststem( Juststem( Juststem(.c_InputFile) ) )
                  lcInputFile         = Addbs( lcSearchDir ) + lcBaseFilename + '.*.*.' + Justext(.c_InputFile)
               Endif

               lnFileCount         = Adir( laFiles, lcInputFile, "", 1 )
               Asort( laFiles, 1, 0, 0, 1)

               For I = 1 To lnFileCount
                  If toFoxBin2Prg.getCfgValue('n_UseFormPerFile') = 1 Then
                     lcInputFile_Form    = Forcepath( Juststem( laFiles(m.I,1) ), lcSearchDir ) + '.' + Justext( .c_InputFile )
                     lcFormName          = Lower( Getwordnum( Justfname( lcInputFile_Form ), 2, '.' ) )

                     *-- Verificación de las Clases, si son Externas y se indicó chequearlas
                     If toFoxBin2Prg.getCfgValue('l_FormPerFileCheck') And Empty(toFoxBin2Prg.c_ClassOperationType) ;
                           AND Ascan( toModulo._ExternalClasses , lcFormName, 1, 0, 1, 1+2+4 ) = 0
                        .writeLog( C_TAB + '- ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Form + ']' )
                        .writeErrorLog( C_TAB + '- ' + loLang.C_WARNING_LOC + ' ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Form + ']' )
                        Loop    && Salteo esta clase
                     Endif
                  Else && toFoxBin2Prg.getCfgValue('n_UseFormPerFile') = 2
                     lcInputFile_Form    = Forcepath( Juststem( laFiles(m.I,1) ), lcSearchDir ) + '.' + Justext( .c_InputFile )
                     lcFormName          = Lower( Getwordnum( Justfname( lcInputFile_Form ), 2, '.' ) + '.' + Getwordnum( Justfname( lcInputFile_Form ), 3, '.' ) )

                     *-- Verificación de las Clases, si son Externas y se indicó chequearlas
                     If toFoxBin2Prg.getCfgValue('l_FormPerFileCheck') And Empty(toFoxBin2Prg.c_ClassOperationType) ;
                           AND Ascan( toModulo._ExternalClasses , lcFormName, 1, 0, 2, 1+2+4 ) = 0
                        .writeLog( C_TAB + '- ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Form + ']' )
                        .writeErrorLog( C_TAB + '- ' + loLang.C_WARNING_LOC + ' ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Form + ']' )
                        Loop    && Salteo esta clase
                     Endif
                  Endif

                  .writeLog( C_TAB + C_TAB + '+ ' + loLang.C_INCLUDING_CLASS_LOC + ' ' + Justfname( lcInputFile_Form ) )

                  *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                  If toFoxBin2Prg.addProcessedFile( lcInputFile_Form, 'I', 'P1', 'E0', 'S1', 'X1' ) Then
                     toFoxBin2Prg.updateProcessedFile()
                  Endif

                  toFoxBin2Prg.normalizeFileCapitalization( .T., lcInputFile_Form )
                  C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + Filetostr( lcInputFile_Form )
               Endfor

               lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )
            Else
               *-- No es clase por archivo, o no se quiere redireccionar a Main.
               C_FB2PRG_CODE       = Filetostr( .c_InputFile )
               lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

               .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
               .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toModulo, @toFoxBin2Prg )

            Endif

            If Not toFoxBin2Prg.l_ProcessFiles Then
               *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
               If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                  toFoxBin2Prg.updateProcessedFile()
               Endif

               Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
            Endif

            *-- Identifico los TEXT/ENDTEXT, #IF .F./#ENDIF
            .updateProgressbar( 'Identifying Excluded Blocks...', 3, lnCodeLines, 1 )
            .identifyExclusionBlocks( @laCodeLines, lnCodeLines, .F., @laLineasExclusion, @lnBloquesExclusion )

            *-- Identifico el inicio/fin de bloque, definición, cabecera y cuerpo de cada clase
            .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toModulo, @toFoxBin2Prg )

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
            .updateProgressbar( 'Generating Binary...', 0, lnCodeLines, 1 )
            toFoxBin2Prg.doBackup( .F., .T., '', '', '' )
            .createForm(toModulo)
            .writeBinaryFile( @toModulo, @toFoxBin2Prg )
         Endwith && THIS


      Catch To toEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Release lnCodError, laCodeLines, lnCodeLines, lcInputFile, lcInputFile_Form, lnFileCount, laFiles ;
            , laLineasExclusion, lnBloquesExclusion, I
      Endtry

      Return
   Endproc




   Procedure writeBinaryFile
      Lparameters toModulo, toFoxBin2Prg
      *-- Estructura del objeto toModulo generado:
      *-- -----------------------------------------------------------------------------------------------------------
      *-- Version                 Versión usada para generar la versión PRG analizada
      *-- SourceFile              Nombre original del archivo fuente de la conversión
      *-- Ole_Obj_Count           Cantidad de objetos definidos en el array ole_objs[]
      *-- Ole_Objs[1]             Array de objetos OLE definidos como clases
      *--     ObjName                 Nombre del objeto OLE (OLE2)
      *--     Parent                  Nombre del objeto Padre
      *--     CheckSum                Suma de verificación
      *--     Value                   Valor del campo OLE
      *-- Clases_Count                Array con las posiciones de los addobjects, definicion y propiedades
      *-- Clases[1]               Array con los datos de las clases, definicion, propiedades y métodos
      *--     Nombre                  El nombre de la clase (ej: "miClase")
      *--     ObjName                 Nombre del objeto
      *--     Parent                  Nombre del objeto Padre
      *--     Class                   Clase de la que hereda la definición
      *--     Classloc                Librería donde está la definición de la clase
      *--     Ole                     Información campo ole
      *--     Ole2                    Información campo ole2
      *--     OlePublic               Indica si la clase es OLEPublic o no (.T. / .F.)
      *--     Uniqueid                ID único
      *--     Comentario              El comentario de la clase (ej: "&& Mis comentarios")
      *--     MetaData                Información de metadata de la clase (baseclass, timestamp, scale)
      *--     BaseClass               Clase de base de la clase
      *--     TimeStamp               Timestamp de la clase
      *--     Scale                   Scale de la clase (pixels, foxels)
      *--     Definicion              La definición de la clase (ej: "AS Custom OF LIBRERIA.VCX")
      *--     Inicio/Fin              Línea de inicio/fin de la clase (DEFINE CLASS/ENDDEFINE)
      *--     Ini_Cab/Fin_Cab         Línea de inicio/fin de la cabecera (def.propiedades, Hidden, Protected, #Include, CLASSDATA, DEFINED_PAM)
      *--     Ini_Cuerpo/Fin_Cuerpo   Línea de inicio/fin del cuerpo (ADD OBJECTs y PROCEDURES)
      *--     HiddenProps             Propiedades definidas como HIDDEN (ocultas)
      *--     ProtectedProps          Propiedades definidas como PROTECTED (protegidas)
      *--     Defined_PAM             Propiedades, eventos o métodos definidos por el usuario
      *--     IncludeFile             Nombre del archivo de inclusión
      *--     Props_Count             Cantidad de propiedades de la clase definicas en el array props[]
      *--     Props[1,2]              Array con todas las propiedades de la clase y sus valores. (col.1=Nombre, col.2=Comentario)
      *--     AddObject_Count         Cantidad de objetos definidos en el array addobjects[]
      *--     AddObjects[1]           Array con las posiciones de los addobjects, definicion y propiedades
      *--         Nombre                  Nombre del objeto
      *--         ObjName                 Nombre del objeto
      *--         Parent                  Nombre del objeto Padre
      *--         Clase                   Clase del objeto
      *--         ClassLib                Librería de clases de la que deriva la clase
      *--         Baseclass               Clase de base del objeto
      *--         Uniqueid                ID único
      *--         Ole                     Información campo ole
      *--         Ole2                    Información campo ole2
      *--         ZOrder                  Orden Z del objeto
      *--         Props_Count             Cantidad de propiedades del objeto
      *--         Props[1]                Array con todas las propiedades del objeto y sus valores
      *--         Procedure_count         Cantidad de procedimientos definidos en el array procedures[]
      *--         Procedures[1]           Array con las posiciones de los procedures, definicion y comentarios
      *--             Nombre                  Nombre del procedure
      *--             ProcType                Tipo de procedimiento (normal, hidden, protected)
      *--             Comentario              Comentario el procedure
      *--             ProcLine_Count          Cantidad de líneas del procedimiento
      *--             ProcLines[1]            Líneas del procedimiento
      *--     Procedure_count         Cantidad de procedimientos definidos en el array procedures[]
      *--     Procedures[1]           Array con las posiciones de los procedures, definicion y comentarios
      *--         Nombre                  Nombre del procedure
      *--         ProcType                Tipo de procedimiento (normal, hidden, protected)
      *--         Comentario              Comentario el procedure
      *--         ProcLine_Count          Cantidad de líneas del procedimiento
      *--         ProcLines[1]            Líneas del procedimiento
      *-- -----------------------------------------------------------------------------------------------------------
      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcObjName, lnCodError, I, X, loEx As Exception ;
            , loClase As CL_CLASE Of 'cl_clase.prg'

         With This As c_conversor_prg_a_scx Of 'c_conversor_prg_a_scx.prg'
            *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
            toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

            Do Case
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
               Error 'OutputFile Error Simulation'
            Endcase

            *-- Creo el registro de cabecera
            .createForm_RecordHeader( toModulo )

            *-- El SCX tiene el INCLUDE en el primer registro
            If Not Empty(toModulo._includeFile)
               Replace RESERVED8 With toModulo._includeFile
            Endif


            *-- Recorro las CLASES
            For X = 1 To 2
               For I = 1 To toModulo._Clases_Count
                  loClase = .Null.
                  loClase = toModulo._Clases(m.I)

                  *-- El dataenvironment debe estar primero, luego lo demás.
                  If m.X = 1 And Not loClase._BaseClass == 'dataenvironment' ;
                        OR m.X = 2 And loClase._BaseClass == 'dataenvironment'
                     Loop
                  Endif

                  If Empty(loClase._TimeStamp)
                     loClase._TimeStamp  = .rowTimeStamp( {^2013/11/04 20:00:00} )
                  Endif
                  If Empty(loClase._UniqueID)
                     loClase._UniqueID   = toFoxBin2Prg.unique_ID()
                  Endif

                  *-- Inserto la clase
                  Insert Into TABLABIN ;
                     ( PLATFORM ;
                     , UNIQUEID ;
                     , Timestamp ;
                     , Class ;
                     , CLASSLOC ;
                     , BaseClass ;
                     , OBJNAME ;
                     , Parent ;
                     , PROPERTIES ;
                     , Protected ;
                     , METHODS ;
                     , OLE ;
                     , OLE2 ;
                     , RESERVED1 ;
                     , RESERVED2 ;
                     , RESERVED3 ;
                     , RESERVED4 ;
                     , RESERVED5 ;
                     , RESERVED6 ;
                     , RESERVED7 ;
                     , RESERVED8 ;
                     , User) ;
                     VALUES ;
                     ( 'WINDOWS' ;
                     , loClase._UniqueID ;
                     , loClase._TimeStamp ;
                     , loClase._Class ;
                     , loClase._ClassLoc ;
                     , loClase._BaseClass ;
                     , loClase._ObjName ;
                     , loClase._Parent ;
                     , loClase._PROPERTIES ;
                     , loClase._PROTECTED ;
                     , loClase._METHODS ;
                     , loClase._Ole ;
                     , loClase._Ole2 ;
                     , loClase._RESERVED1 ;
                     , loClase._RESERVED2 ;
                     , loClase._RESERVED3 ;
                     , loClase._ClassIcon ;
                     , loClase._ProjectClassIcon ;
                     , loClase._Scale ;
                     , loClase._Comentario ;
                     , loClase._includeFile ;
                     , loClase._User )


                  .insert_AllObjects( @loClase, @toFoxBin2Prg )

               Endfor  && I = 1 TO toModulo._Clases_Count
            Endfor  && m.X = 1 TO 2

            *-- Inserto el COMMENT final
            Insert Into TABLABIN ;
               ( PLATFORM ;
               , UNIQUEID ;
               , Timestamp ;
               , Class ;
               , CLASSLOC ;
               , BaseClass ;
               , OBJNAME ;
               , Parent ;
               , PROPERTIES ;
               , Protected ;
               , METHODS ;
               , OLE ;
               , OLE2 ;
               , RESERVED1 ;
               , RESERVED2 ;
               , RESERVED3 ;
               , RESERVED4 ;
               , RESERVED5 ;
               , RESERVED6 ;
               , RESERVED7 ;
               , RESERVED8 ;
               , User) ;
               VALUES ;
               ( 'COMMENT' ;
               , 'RESERVED' ;
               , 0 ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' ;
               , '' )

            Use In (Select("TABLABIN"))

            If toFoxBin2Prg.getCfgValue('l_Recompile')
               toFoxBin2Prg.compileFoxProBinary()
            Endif

            toFoxBin2Prg.updateProcessedFile()
         Endwith && THIS


      Catch To loEx
         toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Store .Null. To loClase, loEx
         Release lcObjName, lnCodError, I, X, loClase
      Endtry

      Return

   Endproc

Enddefine
