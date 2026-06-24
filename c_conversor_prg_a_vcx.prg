#INCLUDE foxbin2prg.h

Define Class c_conversor_prg_a_vcx As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
   #If .F.
      Local This As c_conversor_prg_a_vcx Of 'c_conversor_prg_a_vcx.prg'
   #Endif
   *_MEMBERDATA    = [<VFPData>] ;
   + [<memberdata name="escribirarchivobin" display="escribirArchivoBin"/>] ;
   + [</VFPData>]
   c_Type                  = 'VC2'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (@!    OUT) Objeto generado de clase CL_CLASSLIB con la información leida del texto
      * toEx                      (@!    OUT) Objeto con información del error
      * toFoxBin2Prg              (@? IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

      Try
         Local lnCodError, laCodeLines(1), lnCodeLines, lcInputFile, lcInputFile_Class, lnFileCount, laFiles(1,5) ;
            , laLineasExclusion(1), lnBloquesExclusion, I, lcClassName, lnIDInputFile, llReplaceClass, lnRow ;
            , lcSearchDir, lcBaseFilename, lcHeader ;
            , loClase As CL_CLASE Of 'cl_clase.prg' ;
            , loLang As CL_LANG Of 'cl_lang.prg'

         Local;
            lnDots As Number

         With This As c_conversor_prg_a_vcx Of 'c_conversor_prg_a_vcx.prg'
            Store 0 To lnCodError, lnCodeLines
            Store '' To C_FB2PRG_CODE, lcClassName
            Store .Null. To toModulo

            loLang              = _Screen.o_FoxBin2Prg_Lang
            toModulo            = NewObject('CL_CLASSLIB', 'cl_classlib.prg')
            lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

            If toFoxBin2Prg.getCfgValue('n_UseClassPerFile') > 0 And toFoxBin2Prg.getCfgValue('l_RedirectClassPerFileToMain') ;
                  AND Empty(toFoxBin2Prg.c_ClassToConvert)

               If toFoxBin2Prg.getCfgValue('n_RedirectClassType') = 0 && Redireccionar todas las clases
                  lcHeader = toFoxBin2Prg.getPerFileOutputPath( Forceext(.c_InputFile, 'VCX'), '', toFoxBin2Prg.getCfgValue('c_VC2'), ;
                     toFoxBin2Prg.getCfgFlag('l_UseClassPerDir'), toFoxBin2Prg.getCfgInt('n_UseClassPerFile') )
                  If File(lcHeader)
                     .c_InputFile = lcHeader
                  Endif
                  C_FB2PRG_CODE       = toFoxBin2Prg.readTextFile( .c_InputFile )

                  lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

                  .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
                  .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toModulo, @toFoxBin2Prg )

                  .updateProgressbar( 'Loading Code...', 2, lnCodeLines, 1 )
               Endif

               *-- MÁSCARA DE BÚSQUEDA
               lcSearchDir         = toFoxBin2Prg.getPerFileSearchDir( .c_InputFile, Justext(.c_InputFile), ;
                  toFoxBin2Prg.getCfgFlag('l_UseClassPerDir'), toFoxBin2Prg.getCfgInt('n_UseClassPerFile') )

               If toFoxBin2Prg.getCfgValue('n_UseClassPerFile') = 1 Then
                  *-- Esto crea la máscara de búsqueda "filename.*.ext" para encontrar las partes
                  *-- con la sintaxis "<path>Classlib.Classname.ext" o "<path>Database.MemberName.ext"
                  lcBaseFilename      = Juststem( Juststem(.c_InputFile) )
                  lcInputFile         = Addbs( lcSearchDir ) + lcBaseFilename + '.*.' + Justext(.c_InputFile)
               Else && toFoxBin2Prg.getCfgValue('n_UseClassPerFile') = 2
                  *-- Esto crea la máscara de búsqueda "<path>filename.*.*.ext" para encontrar las partes
                  *-- con la sintaxis "<path>Classlib.ClassType.Classname.ext" o "<path>Database.MemberType.MemberName.ext"
                  lcBaseFilename      = Juststem( Juststem( Juststem(.c_InputFile) ) )
                  lcInputFile         = Addbs( lcSearchDir ) + lcBaseFilename + '.*.*.' + Justext(.c_InputFile)
               Endif

               If toFoxBin2Prg.getCfgValue('n_RedirectClassType') = 1 && Redireccionar solo esta clase
                  lcInputFile         = .c_InputFile
               Endif

               *!* Changed by: LScheffler 15.2.2021
               *!* change date="{^2021-02-15,16:09:00}"
               * problem with classes declared in multiple files, looks like merge problem of git
               * creates multiple classes in VCX
               * the problem is ADIR(laFiles,Name+".*.ext") will return files with AT LEAST 2 dots
               * so we simply remove files with to many dots
               lnDots = Occurs('.',m.lcInputFile)

               lnFileCount         = Adir( laFiles, lcInputFile, "", 1 )

               If lnFileCount > 1
                  For I = m.lnFileCount To 1 Step -1
                     If Occurs('.',laFiles(I,1))>m.lnDots Then
                        Adel(laFiles,I)
                        lnFileCount = m.lnFileCount-1
                     Endif &&OCCURS('.',laFiles(i,1))>m.lnDots
                  Next
                  Dimension;
                     laFiles(Evl(lnFileCount,1),Alen(laFiles,2))
                  *!* /Changed by: LScheffler 15.2.2021

                  Asort( laFiles, 1, 0, 0, 1)
               Endif

               For I = 1 To lnFileCount
                  If toFoxBin2Prg.getCfgValue('n_UseClassPerFile') = 1 Then
                     lcInputFile_Class   = Forcepath( Juststem( laFiles(m.I,1) ), lcSearchDir ) + '.' + Justext( .c_InputFile )
                     lcClassName         = Lower( Getwordnum( Justfname( lcInputFile_Class ), 2, '.' ) )

                     *-- Verificación de las Clases, si son Externas y se indicó chequearlas
                     If toFoxBin2Prg.getCfgValue('l_ClassPerFileCheck') And Empty(toFoxBin2Prg.c_ClassOperationType) ;
                           AND Ascan( toModulo._ExternalClasses , lcClassName, 1, 0, 1, 1+2+4 ) = 0
                        .writeLog( C_TAB + '- ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Class + ']' )
                        .writeErrorLog( C_TAB + '- ' + loLang.C_WARNING_LOC + ' ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Class + ']' )
                        Loop    && Salteo esta clase porque se indicó chequear y no concuerda con las anotadas
                     Endif
                  Else && toFoxBin2Prg.getCfgValue('n_UseClassPerFile') = 2
                     lcInputFile_Class   = Forcepath( Juststem( laFiles(m.I,1) ), lcSearchDir ) + '.' + Justext( .c_InputFile )
                     lcClassName         = Lower( Getwordnum( Justfname( lcInputFile_Class ), 2, '.' ) + '.' + Getwordnum( Justfname( lcInputFile_Class ), 3, '.' ) )

                     *-- Verificación de las Clases, si son Externas y se indicó chequearlas
                     If toFoxBin2Prg.getCfgValue('l_ClassPerFileCheck') And Empty(toFoxBin2Prg.c_ClassOperationType) ;
                           AND Ascan( toModulo._ExternalClasses , lcClassName, 1, 0, 2, 1+2+4 ) = 0
                        .writeLog( C_TAB + '- ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Class + ']' )
                        .writeErrorLog( C_TAB + '- ' + loLang.C_WARNING_LOC + ' ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Class + ']' )
                        Loop    && Salteo esta clase porque se indicó chequear y no concuerda con las anotadas
                     Endif
                  Endif

                  .writeLog( C_TAB + C_TAB + '+ ' + loLang.C_INCLUDING_CLASS_LOC + ' ' + Justfname( lcInputFile_Class ) )

                  *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                  If toFoxBin2Prg.addProcessedFile( lcInputFile_Class, 'I', 'P1', 'E0', 'S1', 'X1' ) Then
                     toFoxBin2Prg.updateProcessedFile()
                  Endif

                  If toFoxBin2Prg.l_ProcessFiles Then
                     toFoxBin2Prg.normalizeFileCapitalization( .T., lcInputFile_Class )
                     C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + toFoxBin2Prg.readTextFile( lcInputFile_Class )
                  Endif
               Endfor

               lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )
            Else
               *-- No es clase por archivo, o no se quiere redireccionar a Main, o se usó
               *-- la sintaxis "classlib.vcx::classname::import"
               If toFoxBin2Prg.l_ProcessFiles Then
                  C_FB2PRG_CODE       = toFoxBin2Prg.readTextFile( .c_InputFile )
                  lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

                  .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
                  .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toModulo, @toFoxBin2Prg )
               Endif

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
            .updateProgressbar( loLang.C_GENERATING_BINARY_LOC + '...', 0, lnCodeLines, 1 )

            If toFoxBin2Prg.getCfgValue('n_RedirectClassType') = 1 Or Not Empty(toFoxBin2Prg.c_ClassToConvert) && Redireccionar solo esta clase a main
               llReplaceClass  = .T.

               * - new operations of DBF
               If Empty(toFoxBin2Prg.c_ClassToConvert)
                  *!* Changed by: LScheffler 04.03.2021
                  *!* change date="{^2021-03-04,10:03:00}"
                  * If inputfile in the form classlib.class.vc2 AND toFoxBin2Prg.getCfgValue('n_RedirectClassType') = 1  and Execute parameter tcRecompile = 1
                  * the change of outputfile might generate an error
                  * toFoxBin2Prg.c_OutputFile is renamed to classlib.vcx, while this.c_OutputFile is classlib.class.vcx
                  * this will generate classlib.class.vcx, tries to recompile and toFoxBin2Prg recompiles classlib.vcx
                  * if classlib.vcx is not existing, it errors out, els it compiles the wrong file.
                  * So we do not rename if toFoxBin2Prg.getCfgValue('n_RedirectClassType') = 1
                  If toFoxBin2Prg.getCfgValue('n_RedirectClassType') = 0
                     toFoxBin2Prg.c_OutputFile = Fullpath( Forceext( lcBaseFilename, 'VCX' ), .c_InputFile)
                  Endif
                  *!* /Changed by: LScheffler 04.03.2021
               Else
                  loClase = toModulo._Clases(1)
                  * Ajusto el nombre interno de la clase al indicado en el nombre del archivo
                  loClase._Nombre     = toFoxBin2Prg.c_ClassToConvert
                  loClase._ObjName    = toFoxBin2Prg.c_ClassToConvert
                  * Reemplazo la propiedad Name
                  lnRow   = Ascan(loClase._Props, 'Name', 1, -1, 1, 2+4+8)
                  If lnRow > 0
                     loClase._Props(lnRow,2) = ["] + toFoxBin2Prg.c_ClassToConvert + ["]
                  Endif
                  * Y finalmente actualizo el memo
                  loClase._PROPERTIES     = .classProps2Memo( @loClase, @toFoxBin2Prg )
               Endif

               toFoxBin2Prg.doBackup( .F., .T., '', '', '' )

               If Adir( laFiles, toFoxBin2Prg.c_OutputFile, "", 1 ) = 1
                  Use (toFoxBin2Prg.c_OutputFile) Alias TABLABIN Again Shared
               Else
                  .createClasslib(toModulo)
               Endif
            Else
               toFoxBin2Prg.doBackup( .F., .T., '', '', '' )
               .createClasslib(toModulo)
            Endif

            .writeBinaryFile( @toModulo, @toFoxBin2Prg, llReplaceClass )
         Endwith && THIS


      Catch To toEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Store .Null. To loClase
         Release lnCodError, laCodeLines, lnCodeLines, lcInputFile, lcInputFile_Class, lnFileCount, laFiles ;
            , laLineasExclusion, lnBloquesExclusion, I
      Endtry

      Return
   Endproc




   Procedure writeBinaryFile
      Lparameters toModulo, toFoxBin2Prg, tlReplaceClass
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
         Local lcObjName, lnCodError, I, X, llReplace, laUniqueID(1,1), loEx As Exception ;
            , loClase As CL_CLASE Of 'cl_clase.prg' ;
            , loFSO As Scripting.FileSystemObject ;
            , loLang As CL_LANG Of 'cl_lang.prg'

         With This As c_conversor_prg_a_vcx Of 'c_conversor_prg_a_vcx.prg'
            loLang          = _Screen.o_FoxBin2Prg_Lang

            Store .Null. To loFSO, loClase
            loFSO   = .oFSO

            *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
            toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )


            Do Case
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
               Error 'OutputFile Error Simulation'
            Endcase

            If tlReplaceClass
               I           = 1
               loClase     = toModulo._Clases(m.I)
               Locate For PLATFORM == Padr('WINDOWS', Fsize('PLATFORM')) And Lower(OBJNAME) == loClase._ObjName
               llReplace   = Found()
            Endif

            If llReplace
               *-- Reemplazar los campos del registro actual
               If Empty(loClase._TimeStamp)
                  loClase._TimeStamp  = .rowTimeStamp( {^2013/11/04 20:00:00} )
               Endif
               If Empty(loClase._UniqueID)
                  loClase._UniqueID   = toFoxBin2Prg.unique_ID()
               Endif

               Replace ;
                  PLATFORM With 'WINDOWS' ;
                  , Timestamp With loClase._TimeStamp ;
                  , Class With loClase._Class ;
                  , CLASSLOC With loClase._ClassLoc ;
                  , BaseClass With loClase._BaseClass ;
                  , OBJNAME With loClase._ObjName ;
                  , Parent With loClase._Parent ;
                  , PROPERTIES With loClase._PROPERTIES ;
                  , Protected With loClase._PROTECTED ;
                  , METHODS With loClase._METHODS ;
                  , OLE With loClase._Ole ;
                  , OLE2 With loClase._Ole2 ;
                  , RESERVED1 With loClase._RESERVED1 ;
                  , RESERVED2 With loClase._RESERVED2 ;
                  , RESERVED3 With loClase._RESERVED3 ;
                  , RESERVED4 With loClase._RESERVED4 ;
                  , RESERVED5 With loClase._RESERVED5 ;
                  , RESERVED6 With loClase._RESERVED6 ;
                  , RESERVED7 With loClase._RESERVED7 ;
                  , RESERVED8 With loClase._RESERVED8 ;
                  , User With loClase._User

               * Si tiene objetos asociados, antes debo eliminar los existentes para no duplicarlos
               Delete All For PLATFORM == Padr('WINDOWS', Fsize('PLATFORM')) And Lower(Parent) == loClase._ObjName

               .insert_AllObjects( @loClase, @toFoxBin2Prg )

            Else
               *-- Creo el registro de cabecera
               If tlReplaceClass And Reccount() > 0
                  Select Max(Val(Substr(UNIQUEID,2))) From TABLABIN Into Array laUniqueID
                  toFoxBin2Prg.n_ID = laUniqueID(1)
               Else
                  .createClasslib_RecordHeader( toModulo )
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

                     *!* Changed by: LScheffler 07.12.2021
                     *!* <pdm>
                     *!* <change date="{^2021-12-07,09:14:00}">Changed by: LScheffler<br />
                     *!* https://github.com/fdbozzo/foxbin2prg/issues/72 / double classes in VCX
                     *!* The old code will write a class whether or not the class is already in the classlib
                     *!* Problem comes if a class is defined double by inconsistent UseClassPerFile,
                     *!* with same class defined in file.vc2 and in file[.baseclass].class.vc2
                     *!* </change>
                     *!* </pdm>

                     Select TABLABIN
                     *!* Changed by: LScheffler 23.02.2022
                     *!* <pdm>
                     *!* <change date="{^2022-02-23,19:44:00}">Changed by: LScheffler<br />
                     *!* https://github.com/fdbozzo/foxbin2prg/issues/77 / If a classname is used as objectname too, an error is reported
                     *!* A class is Objname with empty parent field, while an object has parent filled.
                     *!* </change>
                     *!* </pdm>

                     *                               LOCATE;
                     *                                   FOR OBJNAME==loClase._ObjName
                     Locate;
                        FOR OBJNAME==loClase._ObjName;
                        AND Empty(Parent)

                     *!* /Changed by LScheffler 07.12.2021
                     If Found() Then
                        Error loLang.C_ClassTwice_Header_LOC + ;
                           loLang.C_ClassTwice_Lib_LOC + Justfname( Dbf() ) + ;
                           loLang.C_ClassTwice_Class_LOC + loClase._ObjName+CR_LF
                     Endif &&FOUND()

                     *!* /Changed by LScheffler 07.12.2021

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


                     *-- Inserto el COMMENT
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
                        , loClase._ObjName ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , Iif(loClase._OlePublic, 'OLEPublic', '') ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , '' ;
                        , '' )

                  Endfor  && I = 1 TO toModulo._Clases_Count
                  If !Empty( lnCodError ) Then
                     Exit
                  Endif &&!EMPTY( lnCodError )
               Endfor  && X = 1 TO 2
            Endif

            Use In (Select("TABLABIN"))

            If toFoxBin2Prg.getCfgValue('l_Recompile') And Empty( lnCodError )
               toFoxBin2Prg.compileFoxProBinary(This.c_OutputFile)
            Endif

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
         Store .Null. To loFSO, loClase
         Release lcObjName, I, X, loClase, loFSO

      Endtry

      Return lnCodError

   Endproc

Enddefine
