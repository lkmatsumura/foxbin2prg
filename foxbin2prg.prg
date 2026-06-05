
#INCLUDE foxbin2prg.h


Define Class c_conversor_prg_a_vcx As c_conversor_prg_a_bin OF 'c_conversor_prg_a_bin.prg'
    #If .F.
        Local This As c_conversor_prg_a_vcx Of 'FOXBIN2PRG.PRG'
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
            Local toModulo As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif
        DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

        Try
                Local lnCodError, laCodeLines(1), lnCodeLines, lcInputFile, lcInputFile_Class, lnFileCount, laFiles(1,5) ;
                    , laLineasExclusion(1), lnBloquesExclusion, I, lcClassName, lnIDInputFile, llReplaceClass, lnRow ;
                    , loClase As CL_CLASE Of 'cl_clase.prg' ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

                Local;
                    lnDots As Number

                With This As c_conversor_prg_a_vcx Of 'FOXBIN2PRG.PRG'
                    Store 0 To lnCodError, lnCodeLines
                    Store '' To C_FB2PRG_CODE, lcClassName
                    Store .Null. To toModulo

                    loLang              = _Screen.o_FoxBin2Prg_Lang
                    toModulo            = Createobject('CL_CLASSLIB')
                    lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

                    If toFoxBin2Prg.n_UseClassPerFile > 0 And toFoxBin2Prg.l_RedirectClassPerFileToMain ;
                            AND Empty(toFoxBin2Prg.c_ClassToConvert)

                        If toFoxBin2Prg.n_RedirectClassType = 0 && Redireccionar todas las clases
                            C_FB2PRG_CODE       = Filetostr( .c_InputFile )

                            lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

                            .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
                            .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toModulo, @toFoxBin2Prg )

                            .updateProgressbar( 'Loading Code...', 2, lnCodeLines, 1 )
                        Endif

*-- MÁSCARA DE BÚSQUEDA
                        If toFoxBin2Prg.n_UseClassPerFile = 1 Then
*-- Esto crea la máscara de búsqueda "filename.*.ext" para encontrar las partes
*-- con la sintaxis "<path>Classlib.Classname.ext" o "<path>Database.MemberName.ext"
                            lcBaseFilename      = Juststem( Juststem(.c_InputFile) )
                            lcInputFile         = Addbs( Justpath(.c_InputFile) ) + lcBaseFilename + '.*.' + Justext(.c_InputFile)
                        Else && toFoxBin2Prg.n_UseClassPerFile = 2
*-- Esto crea la máscara de búsqueda "<path>filename.*.*.ext" para encontrar las partes
*-- con la sintaxis "<path>Classlib.ClassType.Classname.ext" o "<path>Database.MemberType.MemberName.ext"
                            lcBaseFilename      = Juststem( Juststem( Juststem(.c_InputFile) ) )
                            lcInputFile         = Addbs( Justpath(.c_InputFile) ) + lcBaseFilename + '.*.*.' + Justext(.c_InputFile)
                        Endif

                        If toFoxBin2Prg.n_RedirectClassType = 1 && Redireccionar solo esta clase
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
                            If toFoxBin2Prg.n_UseClassPerFile = 1 Then
                                lcInputFile_Class   = Forcepath( Juststem( laFiles(m.I,1) ), Justpath( .c_InputFile ) ) + '.' + Justext( .c_InputFile )
                                lcClassName         = Lower( Getwordnum( Justfname( lcInputFile_Class ), 2, '.' ) )

*-- Verificación de las Clases, si son Externas y se indicó chequearlas
                                If toFoxBin2Prg.l_ClassPerFileCheck And Empty(toFoxBin2Prg.c_ClassOperationType) ;
                                        AND Ascan( toModulo._ExternalClasses , lcClassName, 1, 0, 1, 1+2+4 ) = 0
                                    .writeLog( C_TAB + '- ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Class + ']' )
                                    .writeErrorLog( C_TAB + '- ' + loLang.C_WARNING_LOC + ' ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Class + ']' )
                                    Loop    && Salteo esta clase porque se indicó chequear y no concuerda con las anotadas
                                Endif
                            Else && toFoxBin2Prg.n_UseClassPerFile = 2
                                lcInputFile_Class   = Forcepath( Juststem( laFiles(m.I,1) ), Justpath( .c_InputFile ) ) + '.' + Justext( .c_InputFile )
                                lcClassName         = Lower( Getwordnum( Justfname( lcInputFile_Class ), 2, '.' ) + '.' + Getwordnum( Justfname( lcInputFile_Class ), 3, '.' ) )

*-- Verificación de las Clases, si son Externas y se indicó chequearlas
                                If toFoxBin2Prg.l_ClassPerFileCheck And Empty(toFoxBin2Prg.c_ClassOperationType) ;
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
                                C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + Filetostr( lcInputFile_Class )
                            Endif
                        Endfor

                        lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )
                    Else
*-- No es clase por archivo, o no se quiere redireccionar a Main, o se usó
*-- la sintaxis "classlib.vcx::classname::import"
                        If toFoxBin2Prg.l_ProcessFiles Then
                            C_FB2PRG_CODE       = Filetostr( .c_InputFile )
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

                    If toFoxBin2Prg.n_RedirectClassType = 1 Or Not Empty(toFoxBin2Prg.c_ClassToConvert) && Redireccionar solo esta clase a main
                        llReplaceClass  = .T.

* - new operations of DBF
                        If Empty(toFoxBin2Prg.c_ClassToConvert)
*!* Changed by: LScheffler 04.03.2021
*!* change date="{^2021-03-04,10:03:00}"
* If inputfile in the form classlib.class.vc2 AND toFoxBin2Prg.n_RedirectClassType = 1  and Execute parameter tcRecompile = 1
* the change of outputfile might generate an error
* toFoxBin2Prg.c_OutputFile is renamed to classlib.vcx, while this.c_OutputFile is classlib.class.vcx
* this will generate classlib.class.vcx, tries to recompile and toFoxBin2Prg recompiles classlib.vcx
* if classlib.vcx is not existing, it errors out, els it compiles the wrong file.
* So we do not rename if toFoxBin2Prg.n_RedirectClassType = 1
                            If toFoxBin2Prg.n_RedirectClassType = 0
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
            Local toModulo As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcObjName, lnCodError, I, X, llReplace, laUniqueID(1,1), loEx As Exception ;
                    , loClase As CL_CLASE Of 'cl_clase.prg' ;
                    , loFSO As Scripting.FileSystemObject ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

                With This As c_conversor_prg_a_vcx Of 'FOXBIN2PRG.PRG'
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

                    If toFoxBin2Prg.l_Recompile And Empty( lnCodError )
                        toFoxBin2Prg.compileFoxProBinary()
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




Define Class c_conversor_prg_a_scx As c_conversor_prg_a_bin OF 'c_conversor_prg_a_bin.prg'
    #If .F.
        Local This As c_conversor_prg_a_scx Of 'FOXBIN2PRG.PRG'
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
            Local toModulo As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif
        DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

        Try
                Local lnCodError, laCodeLines(1), lnCodeLines, lcInputFile, lcInputFile_Form, lnFileCount, laFiles(1,5) ;
                    , laLineasExclusion(1), lnBloquesExclusion, I, lnIDInputFile ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

                With This As c_conversor_prg_a_vcx Of 'FOXBIN2PRG.PRG'
                    Store 0 To lnCodError, lnCodeLines
                    Store '' To C_FB2PRG_CODE
                    Store .Null. To toModulo

                    loLang              = _Screen.o_FoxBin2Prg_Lang
                    toModulo            = Createobject('CL_CLASSLIB')
                    lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

                    If toFoxBin2Prg.n_UseFormPerFile > 0 And toFoxBin2Prg.l_RedirectFormPerFileToMain
                        C_FB2PRG_CODE       = Filetostr( .c_InputFile )

                        lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

                        .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
                        .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toModulo, @toFoxBin2Prg )

                        .updateProgressbar( 'Loading Code...', 2, lnCodeLines, 1 )

*-- MÁSCARA DE BÚSQUEDA
                        If toFoxBin2Prg.n_UseFormPerFile = 1 Then
*-- Esto crea la máscara de búsqueda "filename.*.ext" para encontrar las partes
                            lcBaseFilename      = Juststem( Juststem(.c_InputFile) )
                            lcInputFile         = Addbs( Justpath(.c_InputFile) ) + lcBaseFilename + '.*.' + Justext(.c_InputFile)
                        Else && toFoxBin2Prg.n_UseFormPerFile = 2
*-- Esto crea la máscara de búsqueda "<path>Database.*.*.ext" para encontrar las partes
*-- con la sintaxis "<path>Database.MemberType.MemberName.ext"
                            lcBaseFilename      = Juststem( Juststem( Juststem(.c_InputFile) ) )
                            lcInputFile         = Addbs( Justpath(.c_InputFile) ) + lcBaseFilename + '.*.*.' + Justext(.c_InputFile)
                        Endif

                        lnFileCount         = Adir( laFiles, lcInputFile, "", 1 )
                        Asort( laFiles, 1, 0, 0, 1)

                        For I = 1 To lnFileCount
                            If toFoxBin2Prg.n_UseFormPerFile = 1 Then
                                lcInputFile_Form    = Forcepath( Juststem( laFiles(m.I,1) ), Justpath( .c_InputFile ) ) + '.' + Justext( .c_InputFile )
                                lcFormName          = Lower( Getwordnum( Justfname( lcInputFile_Form ), 2, '.' ) )

*-- Verificación de las Clases, si son Externas y se indicó chequearlas
                                If toFoxBin2Prg.l_FormPerFileCheck And Empty(toFoxBin2Prg.c_ClassOperationType) ;
                                        AND Ascan( toModulo._ExternalClasses , lcFormName, 1, 0, 1, 1+2+4 ) = 0
                                    .writeLog( C_TAB + '- ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Form + ']' )
                                    .writeErrorLog( C_TAB + '- ' + loLang.C_WARNING_LOC + ' ' + loLang.C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC + ' [' + lcInputFile_Form + ']' )
                                    Loop    && Salteo esta clase
                                Endif
                            Else && toFoxBin2Prg.n_UseFormPerFile = 2
                                lcInputFile_Form    = Forcepath( Juststem( laFiles(m.I,1) ), Justpath( .c_InputFile ) ) + '.' + Justext( .c_InputFile )
                                lcFormName          = Lower( Getwordnum( Justfname( lcInputFile_Form ), 2, '.' ) + '.' + Getwordnum( Justfname( lcInputFile_Form ), 3, '.' ) )

*-- Verificación de las Clases, si son Externas y se indicó chequearlas
                                If toFoxBin2Prg.l_FormPerFileCheck And Empty(toFoxBin2Prg.c_ClassOperationType) ;
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
            Local toModulo As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcObjName, lnCodError, I, X, loEx As Exception ;
                    , loClase As CL_CLASE Of 'cl_clase.prg'

                With This As c_conversor_prg_a_scx Of 'FOXBIN2PRG.PRG'
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

                    If toFoxBin2Prg.l_Recompile
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


Define Class c_conversor_prg_a_frx As c_conversor_prg_a_bin OF 'c_conversor_prg_a_bin.prg'
    #If .F.
        Local This As c_conversor_prg_a_frx Of 'FOXBIN2PRG.PRG'
    #Endif
    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzecodeblock_cdata_inline" display="analyzeCodeBlock_CDATA_inline"/>] ;
        + [<memberdata name="analyzecodeblock_platform" display="analyzeCodeBlock_platform"/>] ;
        + [<memberdata name="analyzecodeblock_reportes" display="analyzeCodeBlock_Reportes"/>] ;
        + [</VFPData>]
    c_Type                  = 'FR2'


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toReport                  (!@    OUT) Objeto generado de clase CL_REPORT con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toReport, toEx As Exception, toFoxBin2Prg
        DoDefault( @toReport, @toEx, @toFoxBin2Prg )

        #If .F.
            Local toReport As CL_REPORT Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lnCodError, loEx As Exception, laCodeLines(1), lnCodeLines ;
                    , laLineasExclusion(1), lnBloquesExclusion, I, lnIDInputFile

                With This As c_conversor_prg_a_frx Of 'FOXBIN2PRG.PRG'
                    Store 0 To lnCodError, lnCodeLines
                    Store .Null. To toReport
                    lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

                    If Not toFoxBin2Prg.l_ProcessFiles Then
*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                        If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                            toFoxBin2Prg.updateProcessedFile()
                        Endif

                        Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
                    Endif

                    C_FB2PRG_CODE       = Filetostr( .c_InputFile )
                    lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

                    .createReport('CURSOR',toReport)

*-- Identifico el inicio/fin de bloque, definición, cabecera y cuerpo del reporte
                    .updateProgressbar( 'Identifying Code Blocks...', 1, 2, 1 )
                    .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toReport )
                    Use In (Select('TABLABIN'))

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
                    .createReport(.F.,toReport)
                    .writeBinaryFile( @toReport, @toFoxBin2Prg )
                Endwith && THIS


            Catch To loEx
                lnCodError  = loEx.ErrorNo

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("TABLABIN"))
        Endtry

        Return lnCodError
    Endproc



    Procedure writeBinaryFile
        Lparameters toReport, toFoxBin2Prg
*-- -----------------------------------------------------------------------------------------------------------
        #If .F.
            Local toReport As CL_REPORT Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local loReg, I, lcFieldType, lnFieldLen, lnFieldDec, lnNumCampo, laFieldTypes(1,18) ;
                    , luValor, lnCodError, loEx As Exception ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

                loLang          = _Screen.o_FoxBin2Prg_Lang
                Select TABLABIN
                Afields( laFieldTypes )
                loReg   = .Null.

*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                toFoxBin2Prg.addProcessedFile( This.c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

                Do Case
                    Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
                        Error 'OutputFile Error Simulation'
                Endcase

*-- Agrego los registros
                For Each loReg In toReport FoxObject

*IF toFoxBin2Prg.l_NoTimestamps
*   loReg.TIMESTAMP = 0
*ENDIF
*IF toFoxBin2Prg.l_ClearUniqueID
*   loReg.UNIQUEID  = ''
*ENDIF
                    If Empty(loReg.Timestamp)
                        loReg.Timestamp = .rowTimeStamp( {^2013/11/04 20:00:00} )
                    Endif
                    If Empty(loReg.UNIQUEID) Or Alltrim(loReg.UNIQUEID) = '0'
                        loReg.UNIQUEID  = toFoxBin2Prg.unique_ID()
                    Endif

*-- Ajuste de los tipos de dato
                    For I = 1 To Amembers(laProps, loReg, 0)
                        lnNumCampo  = Ascan( laFieldTypes, laProps(m.I), 1, -1, 1, 1+2+4+8 )

                        If lnNumCampo = 0
*ERROR 'No se encontró el campo [' + laProps(m.I) + '] en la estructura del archivo ' + DBF("TABLABIN")
                            Error (Textmerge(loLang.C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC))
                        Endif

                        lcFieldType = laFieldTypes(lnNumCampo,2)
                        lnFieldLen  = laFieldTypes(lnNumCampo,3)
                        lnFieldDec  = laFieldTypes(lnNumCampo,4)
                        luValor     = Evaluate('loReg.' + laProps(m.I))

                        Do Case
                            Case Inlist(lcFieldType, 'B')   && Double
                                AddProperty( loReg, laProps(m.I), Cast( luValor As &lcFieldType. (lnFieldPrec) ) )

                            Case Inlist(lcFieldType, 'F', 'N', 'Y') && Float, Numeric, Currency
                                AddProperty( loReg, laProps(m.I), Cast( luValor As &lcFieldType. (lnFieldLen, lnFieldDec) ) )

                            Case Inlist(lcFieldType, 'W', 'G', 'M', 'Q', 'V', 'C')  && Blob, General, Memo, Varbinary, Varchar, Character
                                AddProperty( loReg, laProps(m.I), luValor )

                            Otherwise   && Demás tipos
                                AddProperty( loReg, laProps(m.I), Cast( luValor As &lcFieldType. (lnFieldLen) ) )

                        Endcase

                    Endfor

                    Insert Into TABLABIN From Name loReg
                    loReg   = .Null.
                Endfor

                Use In (Select("TABLABIN"))

                If toFoxBin2Prg.l_Recompile
                    toFoxBin2Prg.compileFoxProBinary()
                Endif

                toFoxBin2Prg.updateProcessedFile()


            Catch To loEx
                lnCodError  = loEx.ErrorNo
                toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("TABLABIN"))
                loReg   = .Null.
                Release loReg, I, lcFieldType, lnFieldLen, lnFieldDec, lnNumCampo, laFieldTypes, luValor

        Endtry

        Return lnCodError
    Endproc



    Procedure identifyCodeBlocks
        Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toReport
*--------------------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taCodeLines               (!@ IN    ) El array con las líneas del código donde buscar
* tnCodeLines               (!@ IN    ) Cantidad de líneas de código
* taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
* tnBloquesExclusion        (@? IN    ) Cantidad de bloques de exclusion
* toReport                  (@?    OUT) Objeto con toda la información del reporte analizado
*
* NOTA:
* Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
*--------------------------------------------------------------------------------------------------------------
        External Array taCodeLines, taLineasExclusion

        #If .F.
            Local toReport As CL_REPORT Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, lc_Comentario, lcLine, llFoxBin2Prg_Completed
                Store 0 To I

                With This As c_conversor_prg_a_frx Of 'FOXBIN2PRG.PRG'
                    .c_Type = Upper(Justext(.c_OutputFile))

                    If tnCodeLines > 1
                        toReport            = .Null.
                        toReport            = Createobject('CL_REPORT')

                        For I = 1 To tnCodeLines
                            .set_Line( @lcLine, @taCodeLines, m.I )

                            Do Case
                                Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Vacía o solo Comentarios
                                    Loop

                                Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( toReport, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llFoxBin2Prg_Completed  = .T.

                                Case .analyzeCodeBlock_Reportes( toReport, @lcLine, @taCodeLines, @m.I, tnCodeLines )

                            Endcase
                        Endfor
                    Endif
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return
    Endproc



    Procedure analyzeCodeBlock_CDATA_inline
*------------------------------------------------------
*-- Analiza el bloque <picture>
*------------------------------------------------------
        Lparameters toReport, tcLine, taCodeLines, I, tnCodeLines, toReg, tcPropName

        #If .F.
            Local toReport As CL_REPORT Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcValue, loEx As Exception

                If Left(tcLine, 1 + Len(tcPropName) + 1 + 9) == '<' + tcPropName + '>' + C_DATA_I
                    llBloqueEncontrado  = .T.

                    If C_DATA_F $ tcLine
                        lcValue = Strextract( tcLine, C_DATA_I, C_DATA_F )
                        AddProperty( toReg, tcPropName, lcValue )
                        Exit
                    Endif

*-- Tomo la primera parte del valor
                    lcValue = Strextract( tcLine, C_DATA_I )

*-- Recorro las fracciones del valor
                    For I = m.I + 1 To tnCodeLines
                        tcLine  = taCodeLines(m.I)

                        If C_DATA_F $ tcLine    && Fin del valor
                            lcValue = lcValue + CR_LF + Strextract( tcLine, '', C_DATA_F )

*-- Ajustes: En los labels, no se usa CR+LF, sino que se usa solo CR
                            If toReg.ObjType = "5" Then
                                lcValue = Strtran(lcValue, CR_LF, C_CR)
                            Endif

                            AddProperty( toReg, tcPropName, lcValue )
                            Exit

                        Else    && Otra fracción del valor
                            lcValue = lcValue + CR_LF + tcLine
                        Endif
                    Endfor

                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'PropName=[' + Transform(tcPropName) + '], Value=[' + Transform(lcValue) + ']'
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Release toReport, tcLine, taCodeLines, I, tnCodeLines, toReg, tcPropName ;
                    , lcValue, loEx
        Endtry

        Return llBloqueEncontrado
    Endproc



    Procedure analyzeCodeBlock_platform
*------------------------------------------------------
*-- Analiza el bloque <platform=>
*------------------------------------------------------
        Lparameters toReport, tcLine, taCodeLines, I, tnCodeLines, toReg

        #If .F.
            Local toReport As CL_REPORT Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, X, lnPos, lnPos2, lcValue, lnLenPropName, laProps(1)

                If Lower( Left(tcLine, 10) ) == 'platform="'
                    llBloqueEncontrado  = .T.
                    lnLastPos           = 1
                    tcLine              = ' ' + tcLine

                    For X = 1 To Amembers( laProps, toReg, 0 )
                        laProps(m.X)    = ' ' + laProps(m.X)
                        lnPos       = At( Lower(laProps(m.X)) + '="', tcLine )

                        If lnPos > 0
                            lnLenPropName   = Len(laProps(m.X))
                            lnPos2          = At( '"', Substr( tcLine, lnPos + lnLenPropName + 2 ) )
                            lcValue         = Substr( tcLine, lnPos + lnLenPropName + 2, lnPos2 - 1 )

                            If laProps(m.X) == ' NAME' And Not Empty(lcValue)
                                lcValue = This.denormalizeXMLValue(lcValue)
                            Endif

                            AddProperty( toReg, laProps(m.X), lcValue )
                        Endif
                    Endfor

                Endif

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Release toReport, tcLine, taCodeLines, I, tnCodeLines, toReg ;
                    , X, lnPos, lnPos2, lcValue, lnLenPropName, laProps
        Endtry

        Return llBloqueEncontrado
    Endproc



    Procedure analyzeCodeBlock_Reportes
*------------------------------------------------------
*-- Analiza el bloque <reportes>
*------------------------------------------------------
        Lparameters toReport, tcLine, taCodeLines, I, tnCodeLines

        #If .F.
            Local toReport As CL_REPORT Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcComment, lcMetadatos, luValor ;
                    , laPropsAndValues(1,2), lnPropsAndValues_Count ;
                    , loReg

                If Left( tcLine, Len(C_TAG_REPORTE) + 1 ) == '<' + C_TAG_REPORTE + ''
                    llBloqueEncontrado  = .T.
                    loReg   = .Null.

                    With This As c_conversor_prg_a_frx Of 'FOXBIN2PRG.PRG'
                        Scatter Memo Blank Name loReg

                        For I = m.I + 1 To tnCodeLines
                            lcComment   = ''
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Left( tcLine, Len(C_TAG_REPORTE_F) ) == C_TAG_REPORTE_F
                                    I = m.I + 1
                                    Exit

                                Case .analyzeCodeBlock_platform( toReport, @tcLine, @taCodeLines, @m.I, @tnCodeLines, @loReg )

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'picture' )

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'tag' )
*-- ARREGLO ALGUNOS VALORES CAMBIADOS AL TEXTUALIZAR
                                    Do Case
                                        Case loReg.ObjType == "1"
                                            loReg.Tag   = .decode_SpecialCodes_1_31( loReg.Tag )
                                        Case Inlist(loReg.ObjType, "25", "26")  && Dataenvironment, cursors and relations
                                            loReg.Tag   = Iif( Empty( Chrtran( loReg.Tag, CR_LF+C_TAB, '') ), '', Substr(loReg.Tag,3) ) && Quito el ENTER agregado antes
                                        Otherwise
                                            loReg.Tag   = .decode_SpecialCodes_1_31( loReg.Tag )
                                    Endcase

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'tag2' )
*-- ARREGLO ALGUNOS VALORES CAMBIADOS AL TEXTUALIZAR
                                    If Not Inlist(loReg.ObjType,"5","6","8")
                                        loReg.TAG2  = Strconv( loReg.TAG2,14 )
                                    Endif

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'penred' )

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'style' )

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'expr' )

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'supexpr' )

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'comment' )

                                Case .analyzeCodeBlock_CDATA_inline( toReport, @tcLine, @taCodeLines, @m.I, tnCodeLines, @loReg, 'user' )

                            Endcase

                        Endfor
                    Endwith && THIS

                    I = m.I - 1
                    toReport.Add( loReg )
                Endif

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                loReg   = .Null.
                Release lcComment, lcMetadatos, luValor, laPropsAndValues, lnPropsAndValues_Count, loReg

        Endtry

        Return llBloqueEncontrado
    Endproc


Enddefine   && CLASS c_conversor_prg_a_frx AS c_conversor_prg_a_bin



Define Class c_conversor_prg_a_dbf As c_conversor_prg_a_bin OF 'c_conversor_prg_a_bin.prg'
    #If .F.
        Local This As c_conversor_prg_a_dbf Of 'FOXBIN2PRG.PRG'
    #Endif
    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzecodeblock_table" display="analyzeCodeBlock_TABLE"/>] ;
        + [<memberdata name="analyzecodeblock_fields" display="analyzeCodeBlock_FIELDS"/>] ;
        + [<memberdata name="analyzecodeblockC_CDX_I" display="analyzeCodeBlock_INDEXES"/>] ;
        + [<memberdata name="writebinaryfile_structure" display="writeBinaryFile_STRUCTURE"/>] ;
        + [<memberdata name="writebinaryfile_indexes" display="writeBinaryFile_INDEXES"/>] ;
        + [</VFPData>]
    c_Type                  = 'DB2'


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toTable                   (!@    OUT) Objeto generado de clase CL_TABLE con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toTable, toEx As Exception, toFoxBin2Prg
        DoDefault( @toTable, @toEx, @toFoxBin2Prg )

        #If .F.
            Local toTable As CL_DBF_TABLE Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lnCodError, loEx As Exception, laCodeLines(1), lnCodeLines, laLineasExclusion(1), lnBloquesExclusion, I ;
                    , lnIDInputFile, lnFileCount, laConfig(1), lcConfigItem, lc_DBF_Conversion_Support, lcAlterTable ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
                    , lcTempDBC, llImportData ;
                    , loDBF_CFG As CL_DBF_CFG Of 'FOXBIN2PRG.PRG', ln_DBF_Conversion_Support
                Store 0 To lnCodError, lnCodeLines

                With This As c_conversor_prg_a_dbf Of 'FOXBIN2PRG.PRG'
                    lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles
                    loLang              = _Screen.o_FoxBin2Prg_Lang

*-- If table CFG exists, use it for DBF-specific configuration. FDBOZZO. 2014/06/15
                    lnFileCount = toFoxBin2Prg.get_DBF_Configuration( Forceext(.c_InputFile, 'DBF'), @loDBF_CFG, .T. )
                    lcTempDBC   = Forcepath( '_FB2P', Justpath(.c_OutputFile) )

                    ln_DBF_Conversion_Support = Iif(Isnull(loDBF_CFG), toFoxBin2Prg.n_DBF_Conversion_Support, loDBF_CFG.n_DBF_Conversion_Support )

                    Do Case
                        Case Not Inlist(ln_DBF_Conversion_Support, 2, 8)
                            With toFoxBin2Prg
                                Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
                            Endwith

*!*                         Case lnFileCount = 1 And loDBF_CFG.n_DBF_Conversion_Support > 0 && Implica 2 u 8
*!*                             llImportData    = (loDBF_CFG.n_DBF_Conversion_Support = 8)

*                       Case toFoxBin2Prg.n_DBF_Conversion_Support = 8  && TXT2BIN (DATA IMPORT)
                        CASE ln_DBF_Conversion_Support = 8  && TXT2BIN (DATA IMPORT)
                            llImportData    = .T.

*!*                         Case toFoxBin2Prg.n_DBF_Conversion_Support <> 2
*!*                             With toFoxBin2Prg
*!*                                 Error (Textmerge(loLang.C_FILE_NAME_IS_NOT_SUPPORTED_LOC))
*!*                             Endwith

                        Otherwise
* Asume llImportData = .F.

                    Endcase

                    If Not toFoxBin2Prg.l_ProcessFiles Then
*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                        If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                            toFoxBin2Prg.updateProcessedFile()
                        Endif

                        Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
                    Endif

                    C_FB2PRG_CODE       = Filetostr( .c_InputFile )
                    lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

                    toFoxBin2Prg.doBackup( .F., .T., '', '', '' )

*-- Identifico el inicio/fin de bloque, campos e índices de la tabla
                    .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toTable )

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
                    .writeBinaryFile_STRUCTURE( @toTable, @toFoxBin2Prg, @lcAlterTable )

                    If llImportData And lnCodeLines > 1 And toTable._I > 1 Then
*-- Identifico los registros de la tabla y los agrego
                        I = toTable._I - 1

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF
                        toTable.analyzeCodeBlock( C_TABLE_I, @laCodeLines, @m.I, lnCodeLines, @toFoxBin2Prg,;
                            IIF( m.lnFileCount = 1, Nvl( m.loDBF_CFG.l_DBF_BinChar_Base64, m.toFoxBin2Prg.l_DBF_BinChar_Base64 ), m.toFoxBin2Prg.l_DBF_BinChar_Base64 ),;
                            IIF( m.lnFileCount = 1, Nvl( m.loDBF_CFG.l_DBF_IncludeDeleted, m.toFoxBin2Prg.l_DBF_IncludeDeleted ), m.toFoxBin2Prg.l_DBF_IncludeDeleted ) )
*!* /Changed by: LScheffler 21.02.2021

                    Endif

                    If Not Empty(lcAlterTable)
                        Execscript(lcAlterTable)
                    Endif

                    .writeBinaryFile_INDEXES( @toTable, @toFoxBin2Prg )

                Endwith && THIS


            Catch To loEx
                lnCodError  = loEx.ErrorNo

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("TABLABIN"))
                Use In (Select(Juststem(This.c_OutputFile)))

                If Not Empty(lcTempDBC)
                    Close Databases
                    Erase (Forceext(lcTempDBC,'DBC'))
                    Erase (Forceext(lcTempDBC,'DCT'))
                    Erase (Forceext(lcTempDBC,'DCX'))
                Endif

                Store .Null. To loDBF_CFG
                Release loDBF_CFG

        Endtry

        Return lnCodError
    Endproc



    Procedure writeBinaryFile_STRUCTURE
        Lparameters toTable, toFoxBin2Prg, tcAlterTable
*-- -----------------------------------------------------------------------------------------------------------
        #If .F.
            Local toTable As CL_DBF_TABLE Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, lnCodError, loEx As Exception ;
                    , loField As CL_DBF_FIELD Of 'FOXBIN2PRG.PRG' ;
                    , loDBFUtils As CL_DBF_UTILS Of 'FOXBIN2PRG.PRG' ;
                    , lcCreateTable, lcLongDec, lcFieldDef, lcIndex, lcTempDBC, lnDataSessionID, lnSelect

                With This As c_conversor_prg_a_dbf Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loField, loIndex, loDBFUtils
                    loDBFUtils          = Createobject('CL_DBF_UTILS')

                    Store 0 To lnCodError
                    Store '' To lcIndex, lcFieldDef, tcAlterTable
                    lnDataSessionID = toFoxBin2Prg.DataSessionId

*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                    toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

                    Do Case
                        Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
                            Error 'OutputFile Error Simulation'
                    Endcase

                    Erase (Forceext(.c_OutputFile, 'DBF'))
                    Erase (Forceext(.c_OutputFile, 'FPT'))
                    Erase (Forceext(.c_OutputFile, 'CDX'))

                    If Empty(toTable._Database)
                        lcCreateTable   = 'CREATE TABLE "' + .c_OutputFile + '" FREE CodePage=' + toTable._CodePage + ' ;' + CR_LF + ' ('
                    Else
                        lcTempDBC   = Forcepath( '_FB2P', Justpath(.c_OutputFile) )
                        Create Database ( lcTempDBC )
                        lcCreateTable   = 'CREATE TABLE "' + .c_OutputFile + '" CodePage=' + toTable._CodePage + ' ;' + CR_LF + ' ('
                    Endif

                    toTable._TableName  = .c_OutputFile

*-- Conformo los campos
                    For Each loField In toTable._Fields FoxObject
                        lcLongDec       = ''

                        If Not Empty(lcFieldDef)
                            lcFieldDef  = lcFieldDef + ';' + CR_LF + ', '
                        Endif

*-- Nombre, Tipo
                        lcFieldDef  = lcFieldDef + '"' + loField._Name + '" ' + loField._Type

*-- Longitud
                        If Inlist( loField._Type, 'C', 'N', 'F', 'Q', 'V' )
                            lcLongDec   = lcLongDec + '(' + loField._Width
                        Endif

*-- Decimales
                        If Inlist( loField._Type, 'N', 'F' ) And loField._Decimals > '0' Or loField._Type = 'B'
                            If Empty(lcLongDec)
                                lcLongDec   = lcLongDec + '('
                            Else
                                lcLongDec   = lcLongDec + ','
                            Endif
                            lcLongDec   = lcLongDec + loField._Decimals
                        Endif

                        If Not Empty(lcLongDec)
                            lcLongDec   = lcLongDec + ')'
                        Endif

                        lcFieldDef  = lcFieldDef + lcLongDec

*-- .Null.
                        lcFieldDef  = lcFieldDef + Iif( loField._Null = '.T.', ' Null', ' NOT Null' )

*-- NoCPTran
                        If loField._NoCPTran = '.T.'
                            lcFieldDef  = lcFieldDef + ' NOCPTRANS'
                        Endif

*-- AutoInc
                        If loField._AutoInc_NextVal <> '0'
                            If toFoxBin2Prg.n_ExcludeDBFAutoincNextval = 1
*-- If AutoIncNextVal is excluded from text, then assign 1 for allowing regeneration
*-- of DBF with this field.
                                tcAlterTable    = tcAlterTable + ' ;' + CR_LF + ' ALTER ' + loField._Name + ' ' + loField._Type + ' AUTOINC NEXTVAL 1 STEP ' + loField._AutoInc_Step
                            Else
                                tcAlterTable    = tcAlterTable + ' ;' + CR_LF + ' ALTER ' + loField._Name + ' ' + loField._Type + ' AUTOINC NEXTVAL ' + loField._AutoInc_NextVal + ' STEP ' + loField._AutoInc_Step
                            Endif
                        Endif

                        loField         = .Null.
                    Endfor

                    lcCreateTable   = lcCreateTable + lcFieldDef + ')'
                    Execscript(lcCreateTable)

                    If Not Empty(tcAlterTable)
                        tcAlterTable    = 'ALTER TABLE "' + .c_OutputFile + '" ' + tcAlterTable
                    Endif

*-- Hook para permitir ejecución externa (por ejemplo, para rellenar la tabla con datos)
                    If Not Empty(toFoxBin2Prg.run_AfterCreateTable)
                        lnSelect    = Select()
                        Do (toFoxBin2Prg.run_AfterCreateTable) With (lnDataSessionID), (.c_OutputFile), (toTable)
                        Set DataSession To (lnDataSessionID)    && Por las dudas externamente se cambie
                        Select (lnSelect)
                    Endif

                Endwith && THIS


            Catch To loEx
                lnCodError      = loEx.ErrorNo
                toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )
                loEx.UserValue  = 'lcFieldDef="' + Transform(lcFieldDef) + '"' + CR_LF ;
                    + 'lcCreateTable="' + Transform(lcCreateTable) + '"'

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField, loDBFUtils
                Release I, loField, loDBFUtils ;
                    , lcCreateTable, lcLongDec, lcFieldDef, lcTempDBC, lnDataSessionID, lnSelect

        Endtry

        Return lnCodError
    Endproc


* LScheffler
    Procedure writeBinaryFile_INDEXES
        Lparameters toTable, toFoxBin2Prg
*-- -----------------------------------------------------------------------------------------------------------
        #If .F.
            Local toTable As CL_DBF_TABLE Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, lnCodError, loEx As Exception ;
                    , loIndex As CL_DBF_INDEX Of 'FOXBIN2PRG.PRG' ;
                    , loDBFUtils As CL_DBF_UTILS Of 'FOXBIN2PRG.PRG' ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
                    , ldLastUpdate ;
                    , lcIndexFile

                With This As c_conversor_prg_a_dbf Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loIndex
                    Store 0 To lnCodError
                    Store '' To lcIndex
                    Store .Null. To lcIndexFile

                    loDBFUtils          = Createobject('CL_DBF_UTILS')

                    If toTable._Indexes.Count # 0 Then

                        loLang          = _Screen.o_FoxBin2Prg_Lang
                        toFoxBin2Prg.writeLog( Replicate('+', 100) )
                        toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_PROCESSING_LOC )
                        toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )

*-- Regenero los índices
                        For Each loIndex In toTable._Indexes FoxObject
                            Do Case
                                Case Isnull ( m.lcIndexFile ) And Empty (m.loIndex._IndexFile)
                                    toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_STRUCTURAL_LOC )
                                    toFoxBin2Prg.writeLog( ' ' + Replicate('- ', 49) )

                                Case Isnull ( m.lcIndexFile ) And m.loIndex._StandAlone
                                    toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_STANDALONE_LOC + m.loIndex._IndexFile )

                                Case Isnull ( m.lcIndexFile )
                                    toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_COMPOUND_LOC + m.loIndex._IndexFile )
                                    toFoxBin2Prg.writeLog( ' ' + Replicate('- ', 59) )

                                Case ! m.lcIndexFile == m.loIndex._IndexFile And m.loIndex._StandAlone
                                    toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )
                                    toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_STANDALONE_LOC + m.loIndex._IndexFile )

                                Case ! m.lcIndexFile == m.loIndex._IndexFile
                                    toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )
                                    toFoxBin2Prg.writeLog( loLang.C_INDEX2BIN_COMPOUND_LOC + m.loIndex._IndexFile )
                                    toFoxBin2Prg.writeLog( ' ' + Replicate('- ', 59) )
                            Endcase
                            lcIndexFile = m.loIndex._IndexFile

                            lcIndex = 'INDEX ON ' + loIndex._Key

                            If loIndex._TagType = 'BINARY'
                                lcIndex = lcIndex + ' BINARY'
                            Else
                                lcIndex = lcIndex + ' COLLATE "' + loIndex._Collate + '"'

                                If Not Empty(loIndex._Filter)
                                    lcIndex = lcIndex + ' FOR ' + loIndex._Filter
                                Endif

                                lcIndex = lcIndex + ' ' + loIndex._Order

                                If Not Inlist(loIndex._TagType, 'NORMAL', 'REGULAR')
*-- Si es PRIMARY lo cambio a CANDIDATE y luego lo recodifico
                                    lcIndex = lcIndex + ' ' + Strtran( loIndex._TagType, 'PRIMARY', 'CANDIDATE' )
                                Endif
                            Endif

                            If m.loIndex._StandAlone Then
                                lcIndex = m.lcIndex + ' TO ' +  m.lcIndexFile
                            Else  &&m.loIndex._StandAlone
                                lcIndex = m.lcIndex + ' TAG ' + loIndex._TagName + Iif( Empty( m.lcIndexFile ), '', ' OF ' + m.lcIndexFile )
                                toFoxBin2Prg.writeLog( '   ' + m.loIndex._TagName )
                            Endif &&m.loIndex._StandAlone

                            &lcIndex.
                        Endfor

                        toFoxBin2Prg.writeLog( Replicate('+', 100) + CR_LF )

                    Endif &&toTable._Indexes.COUNT # 0

                    Use In (Select(Juststem(.c_OutputFile)))

*-- La actualización de la fecha sirve para evitar diferencias al regenerar el DBF
                    If toFoxBin2Prg.l_ClearDBFLastUpdate Then
                        ldLastUpdate    = Evaluate( '{^2013/11/04}' )
                    Else
                        ldLastUpdate    = Evaluate( '{^' + toTable._LastUpdate + '}' )
                    Endif

                    loDBFUtils.write_DBC_BackLink( .c_OutputFile, toTable._Database, ldLastUpdate )

                    toFoxBin2Prg.updateProcessedFile()

                    toFoxBin2Prg.writeLog( Replicate('+', 100) )
                Endwith && THIS


            Catch To loEx
                lnCodError      = loEx.ErrorNo
                toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )
                loEx.UserValue  = 'lcIndex="' + Transform(lcIndex) + '"'

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loIndex
                Release I, loIndex, lcIndex, ldLastUpdate

        Endtry

        Return lnCodError
    Endproc



    Procedure identifyCodeBlocks
*--------------------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taCodeLines               (!@ IN    ) El array con las líneas del código donde buscar
* tnCodeLines               (!@ IN    ) Cantidad de líneas de código
* taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
* tnBloquesExclusion        (@? IN    ) Sin uso
* toTable                   (@?    OUT) Objeto con toda la información de la tabla analizada
*--------------------------------------------------------------------------------------------------------------
        Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toTable

        External Array taCodeLines, taLineasExclusion

        #If .F.
            Local toTable As CL_DBF_TABLE Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueTable_Completed
                Store 0 To I

                With This As c_conversor_prg_a_dbf Of 'FOXBIN2PRG.PRG'
                    .c_Type = Upper(Justext(.c_OutputFile))

                    If tnCodeLines > 1
                        toTable     = .Null.
                        toTable     = Createobject('CL_DBF_TABLE')

                        For I = 1 To tnCodeLines
                            .set_Line( @lcLine, @taCodeLines, m.I )

                            Do Case
                                Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Vacía o solo Comentarios
                                    Loop

                                Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( toTable, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llFoxBin2Prg_Completed  = .T.

                                Case Not llBloqueTable_Completed And toTable.analyzeCodeBlock( @lcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llBloqueTable_Completed = .T.
                                    Exit

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
                Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toTable ;
                    , I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueTable_Completed
        Endtry

        Return
    Endproc


Enddefine   && CLASS c_conversor_prg_a_dbf AS c_conversor_prg_a_bin


* LScheffler, Analyse, just locate
Define Class c_conversor_prg_a_dbc As c_conversor_prg_a_bin OF 'c_conversor_prg_a_bin.prg'
    #If .F.
        Local This As c_conversor_prg_a_dbc Of 'FOXBIN2PRG.PRG'
    #Endif
    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzecodeblock_tables" display="analyzeCodeBlock_TABLES"/>] ;
        + [<memberdata name="analyzecodeblock_views" display="analyzeCodeBlock_VIEWS"/>] ;
        + [<memberdata name="analyzecodeblock_tablefields" display="analyzeCodeBlock_TABLEFIELDS"/>] ;
        + [<memberdata name="analyzecodeblock_viewfields" display="analyzeCodeBlock_VIEWFIELDS"/>] ;
        + [<memberdata name="analyzecodeblock_relations" display="analyzeCodeBlock_RELATIONS"/>] ;
        + [<memberdata name="analyzecodeblock_connections" display="analyzeCodeBlock_CONNECTIONS"/>] ;
        + [<memberdata name="analyzecodeblock_database" display="analyzeCodeBlock_DATABASE"/>] ;
        + [<memberdata name="verify_external_members" display="verify_EXTERNAL_MEMBERS"/>] ;
        + [</VFPData>]
    c_Type                  = 'DC2'


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
            Local toDatabase As CL_DBC Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lnCodError, loEx As Exception, loReg, lcLine, laCodeLines(1), lnCodeLines, lcBaseFilename, lcInputFile ;
                    , lcMemberType, lcMemberName, lcLastMemberType, lnIDInputFile ;
                    , laLineasExclusion(1), lnBloquesExclusion, I, X, Y, laFiles(1,5), lnFileCount, lcTempTxt, laLines(1) ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
                Store 0 To lnCodError, lnCodeLines, lnFileCount
                Store '' To lcLine, laLines, laCodeLines, lcBaseFilename, lcMemberType, lcLastMemberType, lcMemberName, lcInputFile
                Store .Null. To loReg, toDatabase

                With This As c_conversor_prg_a_dbc Of 'FOXBIN2PRG.PRG'
                    loLang              = _Screen.o_FoxBin2Prg_Lang
                    toDatabase          = Createobject('CL_DBC')
                    lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

                    If toFoxBin2Prg.n_UseFilesPerDBC > 0 And toFoxBin2Prg.l_RedirectFilePerDBCToMain
                        C_FB2PRG_CODE       = Filetostr( .c_InputFile )
                        lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )
                        C_FB2PRG_CODE       = ''

*-- Quito la última parte del cierre de </DATABASE> para anexar lo intermedio
                        For X = 1 To lnCodeLines
                            If C_DATABASE_F $ laCodeLines(m.X) Then
                                Exit
                            Endif
                            C_FB2PRG_CODE   = C_FB2PRG_CODE + laCodeLines(m.X) + CR_LF
                        Endfor

                        .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
                        .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toDatabase, @toFoxBin2Prg )

                        .updateProgressbar( 'Loading Code...', 2, lnCodeLines, 1 )

*-- Esto crea la máscara de búsqueda "<path>Database.*.*.ext" para encontrar las partes
*-- con la sintaxis "<path>Database.MemberType.MemberName.ext"
                        lcBaseFilename      = Juststem( Juststem( Juststem(.c_InputFile) ) )
                        lcInputFile         = Addbs( Justpath(.c_InputFile) ) + lcBaseFilename + '.*.*.' + Justext(.c_InputFile)
                        lnFileCount         = Adir( laFiles, lcInputFile, "", 1 )

*-- Busco "storedprocedures" y le pongo "z" al inicio
                        For I = 1 To lnFileCount
                            If Lower( laFiles(m.I,1)) == lcBaseFilename + '.database.storedproceduressource.' + Justext(.c_InputFile) Then
                                laFiles(m.I,1)  = lcBaseFilename + '.zdatabase.storedproceduressource.' + Justext(.c_InputFile)
                                Exit
                            Endif
                        Endfor

                        Asort( laFiles, 1, -1, 0, 1)    && "zstoredprocedures" quedará al final

*-- Busco "zstoredprocedures" y le quito la "z" del inicio
                        For I = 1 To lnFileCount
                            If Lower( laFiles(m.I,1)) == lcBaseFilename + '.zdatabase.storedproceduressource.' + Justext(.c_InputFile) Then
                                laFiles(m.I,1)  = lcBaseFilename + '.database.storedproceduressource.' + Justext(.c_InputFile)
                                Exit
                            Endif
                        Endfor

                        For I = 1 To lnFileCount
                            lcInputFile_Class   = Forcepath( Juststem( laFiles(m.I,1) ), Justpath( .c_InputFile ) ) + '.' + Justext( .c_InputFile )
                            lcMemberType        = Lower( Getwordnum( Justfname( lcInputFile_Class ), 2, '.' ) )
                            lcMemberName        = Lower( Getwordnum( Justfname( lcInputFile_Class ), 3, '.' ) )

                            If toFoxBin2Prg.l_ProcessFiles Then
                                If Not lcMemberType == lcLastMemberType Then
                                    If Not Empty(lcLastMemberType) Then
*-- Cambio de tipo de miembro, fin del anterior (connection, table, view, storedprocedures)
                                        Do Case
                                            Case lcLastMemberType == 'connection'
                                                C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_CONNECTIONS_F + CR_LF
                                            Case lcLastMemberType == 'table'
                                                C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_TABLES_F + CR_LF
                                            Case lcLastMemberType == 'view'
                                                C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_VIEWS_F + CR_LF
                                            Case lcLastMemberType == 'database'
*C_FB2PRG_CODE  = C_FB2PRG_CODE + CR_LF + CR_LF
                                        Endcase

                                        lcLastMemberType    = ''
                                    Endif

*-- Cambio de tipo de miembro, inicio del actual (connection, table, view, storedprocedures)
                                    Do Case
                                        Case lcMemberType == 'connection'
                                            C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + CR_LF + C_TAB + C_CONNECTIONS_I + CR_LF
                                        Case lcMemberType == 'table'
                                            C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + CR_LF + C_TAB + C_TABLES_I + CR_LF
                                        Case lcMemberType == 'view'
                                            C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + CR_LF + C_TAB + C_VIEWS_I + CR_LF
                                        Case lcMemberType == 'database'
                                            C_FB2PRG_CODE   = C_FB2PRG_CODE + CR_LF + CR_LF
                                    Endcase
                                Endif
                            Endif

*-- Verificación de los Miembros, si son Externos y se indicó chequearlos
                            If toFoxBin2Prg.l_ItemPerDBCCheck And Empty(toFoxBin2Prg.c_ClassOperationType) ;
                                    AND Ascan( toDatabase._ExternalClasses, lcMemberType + '.' + lcMemberName, 1, 0, 1, 1+2+4 ) = 0
                                .writeLog( C_TAB + '- ' + loLang.C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC + ' [' + lcInputFile_Class + ']' )
                                .writeErrorLog( C_TAB + '- ' + loLang.C_WARNING_LOC + ' ' + loLang.C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC + ' [' + lcInputFile_Class + ']' )
                                Loop    && Salteo este miembro porque no concuerda con los anotados
                            Endif

                            .writeLog( C_TAB + C_TAB + '+ ' + loLang.C_INCLUDING_MEMBER_LOC + ' ' + Justfname( lcInputFile_Class ) )

*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                            If toFoxBin2Prg.addProcessedFile( lcInputFile_Class, 'I', 'P1', 'E0', 'S1', 'X1' ) Then
                                toFoxBin2Prg.updateProcessedFile()
                            Endif

                            If toFoxBin2Prg.l_ProcessFiles Then
                                toFoxBin2Prg.normalizeFileCapitalization( .T., lcInputFile_Class )
                                lcTempTxt       = Filetostr( lcInputFile_Class )

*!* Changed by: SF 19.11.2023
*!* <pdm>
*!* <change date="{^2023-11-19,14:12:00}">Changed by: SF<br />
*!* Problem with removed Spanish comment, the fixed start at line 7 failes
*!* </change>
*!* </pdm>

*                               For Y = 7 To Alines( laLines, lcTempTxt )
                                Local;
                                    lnHeaderEnd as number
* we just asume, Header is not longer then 9 lines
                                lnHeaderEnd = 10
                                For Y = 1 To Alines( laLines, lcTempTxt )
                                    If m.Y < lnHeaderEnd Then
                                        IF LEFT( laLines( m.Y), 23 ) = '*< FOXBIN2PRG: Version=' Then
*Header ends two lines below
                                            lnHeaderEnd = m.Y + 2
                                        Endif &&LEFT( laLines( m.Y), 23 )  = '*< FOXBIN2PRG: Version='
                                        Loop
                                    Endif &&m.Y < lnHeaderEnd

*!* /Changed by: SF 19.11.2023
                                    C_FB2PRG_CODE   = C_FB2PRG_CODE + laLines(m.Y) + CR_LF
                                Endfor

                                lcLastMemberType    = lcMemberType
                            Endif
                        Endfor

                        If Not toFoxBin2Prg.l_ProcessFiles Then
*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                            If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                                toFoxBin2Prg.updateProcessedFile()
                            Endif

                            Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
                        Endif

                        If Not Empty(lcLastMemberType) Then
*-- Cambio de tipo de miembro, fin del anterior (connection, table, view, storedprocedures)
                            Do Case
                                Case lcLastMemberType == 'connection'
                                    C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_CONNECTIONS_F + CR_LF
                                Case lcLastMemberType == 'table'
                                    C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_TABLES_F + CR_LF
                                Case lcLastMemberType == 'view'
                                    C_FB2PRG_CODE   = C_FB2PRG_CODE + C_TAB + C_VIEWS_F + CR_LF
                                Case lcLastMemberType == 'database'
*C_FB2PRG_CODE  = C_FB2PRG_CODE + CR_LF + CR_LF
                            Endcase
                        Endif

*-- Agrego la última parte con el cierre de </DATABASE>
                        For X = m.X To lnCodeLines
                            C_FB2PRG_CODE   = C_FB2PRG_CODE + laCodeLines(m.X) + CR_LF
                        Endfor

                        lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )
                    Else
*-- No es clase por archivo, o no se quiere redireccionar a Main.
                        If Not toFoxBin2Prg.l_ProcessFiles Then
*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                            If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                                toFoxBin2Prg.updateProcessedFile()
                            Endif

                            Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
                        Endif

                        C_FB2PRG_CODE       = Filetostr( .c_InputFile )

                        lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

                        .updateProgressbar( 'Identifying Header Blocks...', 1, lnCodeLines, 1 )
                        .identifyHeaderBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toDatabase, @toFoxBin2Prg )

                    Endif

*-- Identifico el inicio/fin de bloque, definición, cabecera y cuerpo del reporte
                    .updateProgressbar( 'Identifying Code Blocks...', 1, 2, 1 )
                    .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toDatabase, @toFoxBin2Prg )

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
*.createTable()
                    .writeBinaryFile( @toDatabase, @toFoxBin2Prg )
                Endwith && THIS


            Catch To loEx
                lnCodError  = loEx.ErrorNo

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("TABLABIN"))
        Endtry

        Return lnCodError
    Endproc



    Procedure writeBinaryFile
        Lparameters toDatabase, toFoxBin2Prg
*-- -----------------------------------------------------------------------------------------------------------
        #If .F.
            Local toDatabase As CL_DBC Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lnCodError, lcEventsFile
                lnCodError  = 0

*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                toFoxBin2Prg.addProcessedFile( This.c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

                Do Case
                    Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
                        Error 'OutputFile Error Simulation'
                Endcase

                If Not Empty(toDatabase._DBCEventFilename)
                    If Left(toDatabase._DBCEventFilename,1) = '.' Then
                        lcEventsFile    = Addbs( Justpath(.c_InputFile) ) + toDatabase._DBCEventFilename
                    Else
                        lcEventsFile    = toDatabase._DBCEventFilename
                    Endif
                    If File(lcEventsFile) Then
                        lcEventsFile    = ''
                    Else
                        Strtofile( '', lcEventsFile )
                    Endif

*-- Si no recompilo el EventFilename.prg, el EXE dará un error (aunque el PRG no)
                    Compile ( Addbs( Justpath( This.c_OutputFile ) ) + toDatabase._DBCEventFilename )
                Endif

                toDatabase.updateDBC( This.c_OutputFile )

                If toFoxBin2Prg.l_Recompile
                    toFoxBin2Prg.compileFoxProBinary()
                Endif

                toFoxBin2Prg.updateProcessedFile()


            Catch To loEx
                lnCodError  = loEx.ErrorNo
                toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                If Not Empty(lcEventsFile) Then
                    Erase (lcEventsFile)
                    Erase (Forceext(lcEventsFile,'FXP'))
                Endif

        Endtry

        Return lnCodError
    Endproc



    Procedure identifyHeaderBlocks
*--------------------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taCodeLines               (@! IN    ) El array con las líneas del código donde buscar
* tnCodeLines               (@! IN    ) Cantidad de líneas de código
* taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
* tnBloquesExclusion        (@! IN    ) Cantidad de bloques de exclusión
* toDatabase                    (@?    OUT) Objeto con toda la información del módulo analizado
* toFoxBin2Prg              (@? IN    ) Referencia al objeto principal
*--------------------------------------------------------------------------------------------------------------
* NOTA:
* Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
*--------------------------------------------------------------------------------------------------------------
        Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toDatabase, toFoxBin2Prg

        External Array taCodeLines, taLineasExclusion

        #If .F.
            Local toDatabase As CL_DBC Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, loEx As Exception ;
                    , llFoxBin2Prg_Completed, llOLE_DEF_Completed, llINCLUDE_SCX_Completed, llLIBCOMMENT_Completed, llEXTERNAL_MEMBER_Completed ;
                    , lc_Comentario, lcProcedureAbierto, lcLine ;
                    , loClase As CL_CLASE Of 'cl_clase.prg'

                With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
                    Store '' To lcProcedureAbierto

                    .c_Type = Upper(Justext(.c_OutputFile))

                    If tnCodeLines > 1

                        If toFoxBin2Prg.n_UseFilesPerDBC > 0 And toFoxBin2Prg.l_RedirectFilePerDBCToMain
                        Else
                            llEXTERNAL_MEMBER_Completed = .T.
                        Endif

*-- Búsqueda del ID de inicio de bloque (DEFINE CLASS / PROCEDURE)
                        For I = 1 To tnCodeLines
                            Store '' To lc_Comentario
                            .set_Line( @lcLine, @taCodeLines, m.I )

                            Do Case
                                Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Excluida, vacía o solo Comentarios
                                    Loop

                                Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( @toDatabase, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llFoxBin2Prg_Completed  = .T.

                                Case Not llEXTERNAL_MEMBER_Completed And .analyzeCodeBlock_EXTERNAL_MEMBER( @toDatabase, @lcLine, @taCodeLines, @m.I, tnCodeLines )
*-- Puede haber varias clases externas

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
                Store .Null. To loClase
                Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toDatabase, loClase, I ;
                    , llFoxBin2Prg_Completed, llOLE_DEF_Completed, llINCLUDE_SCX_Completed, llLIBCOMMENT_Completed ;
                    , lc_Comentario, lcProcedureAbierto, lcLine
        Endtry

        Return
    Endproc



    Procedure identifyCodeBlocks
*--------------------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taCodeLines               (!@ IN    ) El array con las líneas del código donde buscar
* tnCodeLines               (!@ IN    ) Cantidad de líneas de código
* taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
* tnBloquesExclusion        (@? IN    ) Sin uso
* toDatabase                (@! IN    ) Objeto con toda la información de la base de datos analizada
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*--------------------------------------------------------------------------------------------------------------
* NOTA:
* Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
*--------------------------------------------------------------------------------------------------------------
        Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toDatabase, toFoxBin2Prg

        External Array taCodeLines, taLineasExclusion

        #If .F.
            Local toDatabase As CL_DBC Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueDatabase_Completed
                Store 0 To I

                With This As c_conversor_prg_a_dbc Of 'FOXBIN2PRG.PRG'
                    .c_Type = Upper(Justext(.c_OutputFile))

                    If tnCodeLines > 1

                        For I = 1 To tnCodeLines
                            .set_Line( @lcLine, @taCodeLines, m.I )

                            Do Case
                                Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Vacía o solo Comentarios
                                    Loop

                                Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( toDatabase, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llFoxBin2Prg_Completed  = .T.

                                Case Not llBloqueDatabase_Completed And toDatabase.analyzeCodeBlock( @lcLine, @taCodeLines, @m.I, tnCodeLines, @toFoxBin2Prg )
                                    llBloqueDatabase_Completed  = .T.

                            Endcase
                        Endfor

                        .verify_EXTERNAL_MEMBERS( @toDatabase, @toFoxBin2Prg )
                    Endif
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toDatabase ;
                    , I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueDatabase_Completed
        Endtry

        Return
    Endproc


    Procedure verify_EXTERNAL_MEMBERS
*--------------------------------------------------------------------------------
* Compara los miembros definidos en la cabecera con los miembros encontrados luego
*--------------------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toDatabase                (@! IN    ) Objeto con toda la información del módulo analizado
* toFoxBin2Prg              (@! IN    ) Referencia al objeto principal
*--------------------------------------------------------------------------------------------------------------
        Lparameters toDatabase, toFoxBin2Prg

        #If .F.
            Local toDatabase As CL_DBC Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Local lnItem, I, X, lcClaseExterna ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

        loLang          = _Screen.o_FoxBin2Prg_Lang

*-- Verificación de los Miembros, si son Externos y se indicó chequearlos
        If toFoxBin2Prg.n_UseFilesPerDBC > 0 And toFoxBin2Prg.l_ItemPerDBCCheck And Empty(toFoxBin2Prg.c_ClassOperationType)
            For I = 1 To toDatabase._ExternalClasses_Count
                lnItem  = 0

                For X = 1 To toDatabase._Members_Count
                    If Lower( toDatabase._Members(m.X,1) ) == Lower( toDatabase._ExternalClasses(m.I,1) )
                        lnItem  = m.X
                        Exit
                    Endif
                Endfor

                If lnItem = 0 Then
                    lcClaseExterna  = Forcepath( Juststem(toFoxBin2Prg.c_InputFile) + '.' + toDatabase._ExternalClasses(m.I,1) + '.' + Justext(toFoxBin2Prg.c_InputFile), Justpath(toFoxBin2Prg.c_InputFile) )
*ERROR 'No se ha encontrado la clase externa [' + toDatabase._ExternalClasses(m.I,1) + '] en el archivo [' + toFoxBin2Prg.c_InputFile + ']'
                    Error ( loLang.C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC + ' [' + lcClaseExterna + ']' )
                Endif

                toDatabase._Members(lnItem,2) = .T. && Checked
            Endfor
        Endif
    Endproc


Enddefine   && CLASS c_conversor_prg_a_dbc AS c_conversor_prg_a_bin



Define Class c_conversor_prg_a_mnx As c_conversor_prg_a_bin OF 'c_conversor_prg_a_bin.prg'
    #If .F.
        Local This As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
    #Endif
    _MemberData = [<VFPData>] ;
        + [<memberdata name="c_menulocation" display="c_MenuLocation"/>] ;
        + [<memberdata name="n_menutype" display="n_MenuType"/>] ;
        + [</VFPData>]

    c_Type                  = 'MN2'
    n_MenuType              = 0
    c_MenuLocation          = ''


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toMenu                    (!@    OUT) Objeto generado de clase CL_DBC con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toMenu, toEx As Exception, toFoxBin2Prg
        DoDefault( @toMenu, @toEx, @toFoxBin2Prg )

        #If .F.
            Local toMenu As CL_MENU Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lnCodError, loEx As Exception, loReg, lcLine, laCodeLines(1), lnCodeLines ;
                    , laLineasExclusion(1), lnBloquesExclusion, lnIDInputFile
                Store 0 To lnCodError, lnCodeLines
                Store '' To lcLine
                Store .Null. To toMenu

                With This As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
                    lnIDInputFile       = toFoxBin2Prg.n_ProcessedFiles

                    If Not toFoxBin2Prg.l_ProcessFiles Then
*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                        If toFoxBin2Prg.addProcessedFile( .c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' ) Then
                            toFoxBin2Prg.updateProcessedFile()
                        Endif

                        Exit    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
                    Endif

                    C_FB2PRG_CODE       = Filetostr( .c_InputFile )
                    lnCodeLines         = Alines( laCodeLines, C_FB2PRG_CODE )

                    .createMenu('CURSOR',toMenu )

*-- Identifico el inicio/fin de bloque, definición, cabecera y cuerpo del reporte
                    .updateProgressbar( 'Identifying Code Blocks...', 1, 2, 1 )
                    .identifyCodeBlocks( @laCodeLines, lnCodeLines, @laLineasExclusion, lnBloquesExclusion, @toMenu )
                    Use In (Select('TABLABIN'))

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
                    .updateProgressbar( 'Generating Binary...', 1, 2, 1 )
                    toFoxBin2Prg.doBackup( .F., .T., '', '', '' )
                    .createMenu(.F.,toMenu )
                    .writeBinaryFile( @toMenu, @toFoxBin2Prg )
                Endwith && THIS


            Catch To loEx
                lnCodError  = loEx.ErrorNo

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("TABLABIN"))
        Endtry

        Return lnCodError
    Endproc


    Procedure identifyCodeBlocks
*--------------------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taCodeLines               (!@ IN    ) El array con las líneas del código donde buscar
* tnCodeLines               (!@ IN    ) Cantidad de líneas de código
* taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
* tnBloquesExclusion        (@? IN    ) Sin uso
* toMenu                    (@?    OUT) Objeto con toda la información del menú analizado
*
* NOTA:
* Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
*--------------------------------------------------------------------------------------------------------------
        Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toMenu

        External Array taCodeLines, taLineasExclusion

        #If .F.
            Local toMenu As CL_MENU Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueMenu_Completed
                Store 0 To I

                With This As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
                    .c_Type = Upper(Justext(.c_OutputFile))

                    If tnCodeLines > 1
                        toMenu      = .Null.
                        toMenu      = Createobject('CL_MENU')

                        For I = 1 To tnCodeLines
                            .set_Line( @lcLine, @taCodeLines, m.I )

                            Do Case
                                Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Vacía o solo Comentarios
                                    Loop

                                Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( toMenu, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llFoxBin2Prg_Completed  = .T.

                                Case Not llBloqueMenu_Completed And toMenu.analyzeCodeBlock( @lcLine, @taCodeLines, @m.I, tnCodeLines, This )
                                    llBloqueMenu_Completed  = .T.

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
                Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toMenu ;
                    , I, lc_Comentario, lcLine, llFoxBin2Prg_Completed, llBloqueMenu_Completed
        Endtry

        Return
    Endproc


    Procedure writeBinaryFile
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toMenu                    (!@    OUT) Objeto generado de clase CL_DBC con la información leida del texto
*---------------------------------------------------------------------------------------------------
        Lparameters toMenu, toFoxBin2Prg

        #If .F.
            Local toMenu As CL_MENU Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lnCodError
                lnCodError  = 0

*-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
                toFoxBin2Prg.addProcessedFile( This.c_OutputFile, 'O', 'P1', 'E0', 'S1', 'X0' )

                Do Case
                    Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
                        Error 'OutputFile Error Simulation'
                Endcase

                toMenu.updateMENU( This )

                toFoxBin2Prg.updateProcessedFile()


            Catch To loEx
                lnCodError  = loEx.ErrorNo
                toFoxBin2Prg.updateProcessedFile( 0, '', '', 'E1' )

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select(Juststem(This.c_OutputFile)))

        Endtry

        Return lnCodError
    Endproc


Enddefine   && CLASS c_conversor_prg_a_mnx AS c_conversor_prg_a_bin



Define Class c_conversor_vcx_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    #If .F.
        Local This As c_conversor_vcx_a_prg Of 'FOXBIN2PRG.PRG'
    #Endif
    c_Type = 'VCX'


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toModulo                  (!@    OUT) Objeto generado de clase CL_CLASSLIB con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toModulo, toEx As Exception, toFoxBin2Prg
        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif
        DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

        Try
                Local lnCodError, loRegClass, loRegObj, lnMethodCount, laMethods(1), laCode(1), laProtected(1), lnLen, lnObjCount ;
                    , laPropsAndValues(1), laPropsAndComments(1), lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle(1) ;
                    , laObjs(1,4), I, lnPropsAndValues_Count, lnPropsAndComments_Count, lnProtected_Count, lcCodigo, laClasses(1,3) ;
                    , lnClassCount, lcOutputFile, lcExternalHeader, lnClassTotal, lnStepCount, lnStep, lcObjPathInsideClass, lnPos ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
                Store 0 To lnCodError, lnLastClass, lnObjCount, lnPropsAndValues_Count, lnPropsAndComments_Count, lnProtected_Count ;
                    , lnMethodCount, lnClassCount, lnStepCount, lnStep
                Store '' To laMethods, laCode, laProtected, laPropsAndComments, laObjs, lcCodigo, laClasses, lcOutputFile ;
                    , C_FB2PRG_CODE, lcExternalHeader
                Store .Null. To loRegClass, loRegObj
                loLang  = _Screen.o_FoxBin2Prg_Lang

                With This As c_conversor_vcx_a_prg Of 'FOXBIN2PRG.PRG'
                    Use (.c_InputFile) Shared Again Noupdate Alias _TABLAORIG

*LScheffler 20.08.2023
*issue #96, including issue #95, [KestasL] keep CodePage relavant information for binary sources
                    toFoxBin2Prg.i_CPID = Cpdbf("_TABLAORIG")
                    SET NOCPTRANS TO Class,CLASSLOC,BaseClass,OBJNAME,Parent,PROPERTIES,Protected,METHODS,OBJCODE,OLE,OLE2,;
                        RESERVED1,RESERVED2,RESERVED3,RESERVED4,RESERVED5,RESERVED6,RESERVED7,RESERVED8,User
*/LScheffler 20.08.2023

                    If toFoxBin2Prg.n_UseClassPerFile = 0 Or Empty(toFoxBin2Prg.c_ClassToConvert) Then
*-- Exportar la librería entera a texto
                        Select _TABLAORIG.*,Recno() regnum From _TABLAORIG Into Cursor TABLABIN Readwrite
                    Else
*-- Exportar solo una clase a texto cuando se usa ClassPerFile y se indicó una clase
                        Select _TABLAORIG.*,Recno() regnum From _TABLAORIG Into Cursor TABLABIN ;
                            WHERE PLATFORM == 'WINDOWS ' ;
                            AND ( Proper(RESERVED1) == "Class" And Lower(OBJNAME) == toFoxBin2Prg.c_ClassToConvert ;
                            OR Lower( Alltrim( Getwordnum( _TABLAORIG.Parent + '.', 1, '.' ) ) ) == toFoxBin2Prg.c_ClassToConvert ) ;
                            OR PLATFORM == 'COMMENT ' And Lower(OBJNAME) == toFoxBin2Prg.c_ClassToConvert
                    Endif

                    lnStepCount = 7
                    Use In (Select("_TABLAORIG"))

* Issue#17: Error, The Specified Key already exists (Kirides)
                    .ignoreCorruptedObjects('TABLABIN')

* Issue#15: Ignorar objetos mal definidos (Doug Hennig)
                    .ignoreIncorrectDefinedObjects('TABLABIN')

                    Index On Padr(Lower(PLATFORM + Iif(Empty(Parent),'',Alltrim(Parent)+'.')+OBJNAME),239) Tag PARENT_OBJ Additive
                    Set Order To 0 In TABLABIN

                    .get_OLEPublicObjectName( @la_NombresObjsOle )

                    .write_OLEObjectDefinitions( @toFoxBin2Prg )

*-- Escribo los métodos ordenados
                    lnLastClass     = 0

*----------------------------------------------
*-- RECORRO LAS CLASES
*----------------------------------------------
                    Select TABLABIN
                    Set Order To PARENT_OBJ

                    If toFoxBin2Prg.n_UseClassPerFile = 0 Or Empty(toFoxBin2Prg.c_ClassToConvert) Then
                        Goto Record 1   && Class Library Header/Form Header
                        Scatter Fields RESERVED7 Memo Name loRegClass

                        If Not Empty(loRegClass.RESERVED7) Then
                            TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<C_LIBCOMMENT_I>> <<loRegClass.Reserved7>> <<C_LIBCOMMENT_F>>
                            *
                            ENDTEXT
                        Endif
                    Endif

                    Count All For Upper( TABLABIN.PLATFORM ) = "WINDOWS" And Proper( TABLABIN.RESERVED1 ) == "Class" To lnClassTotal

                    Scan All For Upper( TABLABIN.PLATFORM ) = "WINDOWS" And Proper( TABLABIN.RESERVED1 ) == "Class"
                        Store 0 To lnMethodCount
                        Store '' To laMethods, laCode, lcCodigo
                        lnClassCount    = lnClassCount + 1
                        Dimension laClasses(lnClassCount,3)

                        loRegClass  = .Null.
                        Scatter Memo Name loRegClass

*-- Normalización de capitalización y de datos según parametrización
                        loRegClass.BaseClass    = Lower( loRegClass.BaseClass )
                        loRegClass.CLASSLOC     = Lower( loRegClass.CLASSLOC )
                        loRegClass.Class        = Lower( loRegClass.Class )
                        loRegClass.OBJNAME      = Lower( loRegClass.OBJNAME )

                        If toFoxBin2Prg.l_NoTimestamps
                            loRegClass.Timestamp    = 0
                        Endif
                        If toFoxBin2Prg.l_ClearUniqueID
                            loRegClass.UNIQUEID = ''
                        Else
                            loRegClass.UNIQUEID = Alltrim(loRegClass.UNIQUEID)
                        Endif

                        lcObjName   = Alltrim( loRegClass.OBJNAME )
                        laClasses(lnClassCount,1)   = Lower( lcObjName )
                        laClasses(lnClassCount,2)   = ''
                        laClasses(lnClassCount,3)   = loRegClass.BaseClass

                        If Not toFoxBin2Prg.l_ProcessFiles Then
                            Loop    && Si se indicó no procesar, salteo el resto del proceso. (Modo de simulación)
                        Endif

                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Class ' + lcObjName + '...', lnStep, lnClassTotal*lnStepCount, 1 )

                        .write_DEFINE_CLASS( @la_NombresObjsOle, @loRegClass, @lcCodigo )

                        .write_DEFINE_CLASS_COMMENTS( @loRegClass, @lcCodigo )

                        .write_CLASSMETADATA( @loRegClass, @lcCodigo )

                        If toFoxBin2Prg.n_UseClassPerFile > 0 Or Not Empty(toFoxBin2Prg.c_ClassToConvert) Then
                            .write_EXTERNAL_CLASS_HEADER( @loRegClass, @toFoxBin2Prg, @lcExternalHeader )
                        Endif

*-------------------------------------------------------------------------------
*-- RECORRO LOS OBJETOS DENTRO DE LA CLASE ACTUAL PARA EXPORTAR SU DEFINICIÓN
*-------------------------------------------------------------------------------
                        lnObjCount  = 0
                        lnRecno = Recno()
                        Locate For Upper( TABLABIN.PLATFORM ) = "WINDOWS" ;
                            AND Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

                        Scan Rest While Upper( TABLABIN.PLATFORM ) = "WINDOWS" ;
                                AND Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

                            lnObjCount  = lnObjCount + 1
                            loRegObj    = .Null.
                            Scatter Memo Name loRegObj

*-- Normalización de capitalización y de datos según parametrización
                            loRegObj.BaseClass      = Lower( loRegObj.BaseClass )
                            loRegObj.CLASSLOC       = Lower( loRegObj.CLASSLOC )
                            loRegObj.Class          = Lower( loRegObj.Class )
                            lcObjPathInsideClass    = Lower( loRegObj.Parent ) + '.' + Lower( loRegObj.OBJNAME )

                            If lnObjCount > 1 Then
                                lnPos   = Ascan( laObjs, lcObjPathInsideClass, 1, 0, 4, 1+2+4+8 )

                                If lnPos > 0 Then
*-- ERROR: Objeto Duplicado
                                    .writeErrorLog( '* ' + loLang.C_DUPLICATED_OBJECT_LOC + ' "' + loRegObj.Class + '.' + lcObjPathInsideClass ;
                                        + '" @Recno ' + Transform(loRegObj.regnum) + ', (1st.Recno:' + Transform(laObjs(lnPos,2)) + ')' )
                                Endif
                            Endif

                            Dimension laObjs(lnObjCount,4)
                            laObjs(lnObjCount,1)    = loRegObj
                            laObjs(lnObjCount,2)    = loRegObj.regnum       && ZOrder
                            laObjs(lnObjCount,3)    = lnObjCount            && Alphabetic order
                            laObjs(lnObjCount,4)    = lcObjPathInsideClass  && To check duplicates

                            If toFoxBin2Prg.l_NoTimestamps
                                loRegObj.Timestamp  = 0
                            Endif
                            If toFoxBin2Prg.l_ClearUniqueID
                                loRegObj.UNIQUEID   = ''
                            Else
                                loRegObj.UNIQUEID   = Alltrim(loRegObj.UNIQUEID)
                            Endif

                            loRegObj    = .Null.
                        Endscan

                        Goto Record (lnRecno)
                        Asort(laObjs, 2, -1, 0, 0)  && Orden por ZOrder

                        If lnObjCount > 0
                            lcCodigo    = lcCodigo + CR_LF + '  *-- OBJECTDATA items order determines ZOrder / El orden de los items OBJECTDATA determina el ZOrder '

                            For I = 1 To lnObjCount
                                .write_OBJECTMETADATA( laObjs(m.I,1), @lcCodigo )
                            Endfor

                            lcCodigo    = lcCodigo + CR_LF
                        Endif

                        .write_INCLUDE( @loRegClass, @lcCodigo )

                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Class ' + lcObjName + ' > Writing Properties...', lnStep, lnClassTotal*lnStepCount, 1 )

                        .write_CLASS_PROPERTIES( @loRegClass, @laPropsAndValues, @laPropsAndComments, @laProtected ;
                            , @lnPropsAndValues_Count, @lnPropsAndComments_Count, @lnProtected_Count, @lcCodigo, @toFoxBin2Prg )

                        Asort(laObjs, 3, -1, 0, 0)  && Orden Alfabético de objetos (del SCAN original)

                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Class ' + lcObjName + ' > Writing Obtects with Properties...', lnStep, lnClassTotal*lnStepCount, 1 )

                        For I = 1 To lnObjCount
                            .write_ADD_OBJECTS_WithProperties( laObjs(m.I,1), @lcCodigo, @toFoxBin2Prg )
                        Endfor


*-- OBTENGO LOS MÉTODOS DE LA CLASE PARA POSTERIOR TRATAMIENTO
                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Class ' + lcObjName + ' > Getting Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

                        Dimension laMethods(1,3), laCode(1)
                        Store '' To laMethods, laCode
                        lnMethodCount   = 0

                        .method2Array( loRegClass.METHODS, @laMethods, @laCode, '', @lnMethodCount ;
                            , @laPropsAndComments, lnPropsAndComments_Count, @laProtected, lnProtected_Count, @toFoxBin2Prg, @loRegClass )

                        .get_CLASS_METHODS( @lnMethodCount, @laMethods, @laCode, @laProtected, @laPropsAndComments, @toFoxBin2Prg )

                        lnLastClass     = 1
                        lcMethods       = ''

*-- RECORRO LOS OBJETOS DENTRO DE LA CLASE ACTUAL PARA OBTENER SUS MÉTODOS
                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Class ' + lcObjName + ' > Getting Objects Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

                        lnRecno = Recno()
                        Locate For Upper( TABLABIN.PLATFORM ) = "WINDOWS" And Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

                        Scan Rest ;
                                FOR Upper( TABLABIN.PLATFORM ) = "WINDOWS" And Not Proper( TABLABIN.RESERVED1 ) == "Class" ;
                                WHILE Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

                            loRegObj    = .Null.
                            Scatter Memo Name loRegObj

*-- Normalización de capitalización y de datos según parametrización
                            loRegObj.BaseClass  = Lower( loRegObj.BaseClass )
                            loRegObj.CLASSLOC   = Lower( loRegObj.CLASSLOC )
                            loRegObj.Class      = Lower( loRegObj.Class )

                            If toFoxBin2Prg.l_NoTimestamps
                                loRegObj.Timestamp  = 0
                            Endif
                            If toFoxBin2Prg.l_ClearUniqueID
                                loRegObj.UNIQUEID   = ''
                            Else
                                loRegObj.UNIQUEID   = Alltrim(loRegObj.UNIQUEID)
                            Endif

                            .get_ADD_OBJECT_METHODS( @loRegObj, @loRegClass, @lcMethods, @laMethods, @laCode, @lnMethodCount ;
                                , @laPropsAndComments, lnPropsAndComments_Count, @laProtected, lnProtected_Count, @toFoxBin2Prg )
                        Endscan

                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Class ' + lcObjName + ' > Writing Objects Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

                        .write_ALL_OBJECT_METHODS( @lcMethods, @laMethods, @laCode, @lnMethodCount, @laPropsAndComments, lnPropsAndComments_Count, @laProtected ;
                            , lnProtected_Count, @toFoxBin2Prg, @lcCodigo )

                        Goto Record (lnRecno)
                        .write_ENDDEFINE_IfApplicable( lnLastClass, @lcCodigo )
                        laClasses(lnClassCount,2)   = lcCodigo
                    Endscan

                    If toFoxBin2Prg.n_UseClassPerFile > 0 Then
                        lcExternalHeader    = lcExternalHeader + CR_LF
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


*-- Genero el VC2
                    lnStep          = lnStep + 1
                    lcOutputFile    = .c_OutputFile

                    .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_VC2 + '...', lnStep, lnClassTotal*lnStepCount, 1 )
                    lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + lcExternalHeader + C_FB2PRG_CODE

                    If .l_Test
*FOR I = 1 TO lnClassCount
*   lcCodigo    = lcCodigo + laClasses(m.I,2)
*ENDFOR
*toModulo   = lcCodigo
                    Else
                        Do Case
                            Case (toFoxBin2Prg.n_UseClassPerFile = 0 And Not Empty(toFoxBin2Prg.c_ClassToConvert))  && LibName.ClassName.SC2
                                For I = 1 To lnClassCount
                                    lcOutputFile    = Addbs( Justpath( .c_OutputFile ) ) + Juststem( .c_OutputFile ) + '.' + laClasses(m.I,1) + '.' + Justext( .c_OutputFile )
                                    lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + laClasses(m.I,2)
                                    .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                                Endfor

                            Case toFoxBin2Prg.n_UseClassPerFile = 1 && LibName.ClassName.SC2
                                If Empty(toFoxBin2Prg.c_ClassToConvert) Then
                                    .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                                Endif

                                For I = 1 To lnClassCount
                                    lcOutputFile    = Addbs( Justpath( .c_OutputFile ) ) + Juststem( .c_OutputFile ) + '.' + laClasses(m.I,1) + '.' + Justext( .c_OutputFile )
                                    lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + laClasses(m.I,2)
                                    .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                                Endfor

                            Case toFoxBin2Prg.n_UseClassPerFile = 2 && LibName.BaseClass.ClassName.SC2
                                If Empty(toFoxBin2Prg.c_ClassToConvert) Then
                                    .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                                Endif

                                For I = 1 To lnClassCount
                                    lcOutputFile    = Addbs( Justpath( .c_OutputFile ) ) + Juststem( .c_OutputFile ) + '.' + laClasses(m.I,3) + '.' + laClasses(m.I,1) + '.' + Justext( .c_OutputFile )
                                    lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + laClasses(m.I,2)
                                    .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                                Endfor

                            Otherwise
                                For I = 1 To lnClassCount
                                    lcCodigo    = lcCodigo + laClasses(m.I,2)
                                Endfor

                                .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                        Endcase
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
                Use In (Select("_TABLAORIG"))
                Store .Null. To loRegClass, loRegObj
                Release toModulo, toEx, toFoxBin2Prg ;
                    , lnCodError, loRegClass, loRegObj, lnMethodCount, laMethods, laCode, laProtected, lnLen, lnObjCount ;
                    , laPropsAndValues, laPropsAndComments, lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle ;
                    , laObjs, I, lnPropsAndValues_Count, lnPropsAndComments_Count, lnProtected_Count ;
                    , lcCodigo, laClasses, lnClassCount, lcOutputFile

        Endtry

        Return
    Endproc
Enddefine



Define Class c_conversor_scx_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    #If .F.
        Local This As c_conversor_scx_a_prg Of 'FOXBIN2PRG.PRG'
    #Endif
    c_Type                  = 'SCX'


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toModulo                  (!@    OUT) Objeto generado de clase CL_CLASSLIB con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toModulo, toEx As Exception, toFoxBin2Prg
        DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

        #If .F.
            Local toModulo As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lnCodError, loRegClass, loRegObj, lnMethodCount, laMethods(1), laCode(1), laProtected(1), lnLen, lnObjCount ;
                    , laPropsAndValues(1), laPropsAndComments(1), lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle(1) ;
                    , laObjs(1,4), I, lnPropsAndValues_Count, lnPropsAndComments_Count, lnProtected_Count, lcCodigo, laClasses(1,3) ;
                    , lnClassCount, lcOutputFile, lcExternalHeader, lnClassTotal, lnStepCount, lnStep, lcObjPathInsideClass, lnPos ;
                    , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
                Store 0 To lnCodError, lnLastClass, lnObjCount, lnPropsAndValues_Count, lnPropsAndComments_Count, lnProtected_Count ;
                    , lnMethodCount, lnClassCount, lnStepCount, lnStep
                Store '' To laMethods, laCode, laProtected, laPropsAndComments, laObjs, lcCodigo, laClasses, lcOutputFile ;
                    , C_FB2PRG_CODE, lcExternalHeader
                Store .Null. To loRegClass, loRegObj
                loLang  = _Screen.o_FoxBin2Prg_Lang

                With This As c_conversor_scx_a_prg Of 'FOXBIN2PRG.PRG'
                    Use (.c_InputFile) Shared Again Noupdate Alias _TABLAORIG

*!* LScheffler 20.08.2023
*issue #96, including issue #95, [KestasL] keep CodePage relavant information for binary sources
                    toFoxBin2Prg.i_CPID = Cpdbf("_TABLAORIG")
                    SET NOCPTRANS TO CLASS,CLASSLOC,BASECLASS,OBJNAME,PARENT,PROPERTIES,PROTECTED,METHODS;
                        ,OBJCODE,OLE,OLE2,RESERVED1,RESERVED2,RESERVED3,RESERVED4,RESERVED5,RESERVED6,RESERVED7,RESERVED8,USER
*/LScheffler 20.08.2023

                    Select _TABLAORIG.*,Recno() regnum From _TABLAORIG Into Cursor TABLABIN Readwrite

                    Use In (Select("_TABLAORIG"))

* Issue#15: Ignorar objetos mal definidos
                    .ignoreIncorrectDefinedObjects('TABLABIN')

                    Index On Padr(Lower(PLATFORM + Iif(Empty(Parent),'',Alltrim(Parent)+'.')+OBJNAME),239) Tag PARENT_OBJ Additive
                    Set Order To 0 In TABLABIN

                    .get_OLEPublicObjectName( @la_NombresObjsOle )

                    .write_OLEObjectDefinitions( @toFoxBin2Prg )

*-- Escribo los métodos ordenados
                    lnLastObj       = 0
                    lnLastClass     = 0

*----------------------------------------------
*-- RECORRO LAS CLASES
*----------------------------------------------
                    Select TABLABIN
                    Set Order To PARENT_OBJ
                    Goto Record 1   && Class Library Header/Form Header

                    loRegClass  = .Null.
                    Scatter Fields RESERVED8,RESERVED7 Memo Name loRegClass

                    If Not Empty(loRegClass.RESERVED7) Then
                        TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<C_LIBCOMMENT_I>> <<loRegClass.Reserved7>> <<C_LIBCOMMENT_F>>
                        *
                        ENDTEXT
                    Endif


                    If Not Empty(loRegClass.RESERVED8) Then
                        TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        #INCLUDE "<<loRegClass.Reserved8>>"
                        <<>>
                        ENDTEXT
                    Endif


                    Count All For TABLABIN.PLATFORM = "WINDOWS" ;
                        AND ( Empty( TABLABIN.Parent ) ;
                        AND Inlist( Lower( TABLABIN.BaseClass ), 'dataenvironment', 'form', 'formset' ) ) To lnClassTotal

                    Scan All For TABLABIN.PLATFORM = "WINDOWS" ;
                            AND ( Empty( TABLABIN.Parent ) ;
                            AND Inlist( Lower( TABLABIN.BaseClass ), 'dataenvironment', 'form', 'formset' ) )

                        Store 0 To lnMethodCount
                        Store '' To laMethods, laCode, lcCodigo
                        lnClassCount    = lnClassCount + 1
                        Dimension laClasses(lnClassCount,3)

                        loRegClass  = .Null.
                        Scatter Memo Name loRegClass

*-- Normalización de capitalización y de datos según parametrización
                        loRegClass.BaseClass    = Lower( loRegClass.BaseClass )
                        loRegClass.CLASSLOC     = Lower( loRegClass.CLASSLOC )
                        loRegClass.Class        = Lower( loRegClass.Class )
                        loRegClass.OBJNAME      = Lower( loRegClass.OBJNAME )

                        If toFoxBin2Prg.l_NoTimestamps
                            loRegClass.Timestamp    = 0
                        Endif
                        If toFoxBin2Prg.l_ClearUniqueID
                            loRegClass.UNIQUEID = ''
                        Else
                            loRegClass.UNIQUEID = Alltrim(loRegClass.UNIQUEID)
                        Endif

                        lcObjName   = Alltrim(loRegClass.OBJNAME)
                        laClasses(lnClassCount,1)   = Lower( lcObjName )
                        laClasses(lnClassCount,2)   = ''
                        laClasses(lnClassCount,3)   = loRegClass.BaseClass

                        If Not toFoxBin2Prg.l_ProcessFiles Then
                            Loop    && Si se indicó no procesar, salteo el resto del proceso. (Modo de simulación)
                        Endif

                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Form ' + lcObjName + '...', lnStep, lnClassTotal*lnStepCount, 1 )

                        .write_DEFINE_CLASS( @la_NombresObjsOle, @loRegClass, @lcCodigo )

                        .write_DEFINE_CLASS_COMMENTS( @loRegClass, @lcCodigo )

                        .write_CLASSMETADATA( @loRegClass, @lcCodigo )

                        If toFoxBin2Prg.n_UseFormPerFile > 0 Then
                            .write_EXTERNAL_CLASS_HEADER( @loRegClass, @toFoxBin2Prg, @lcExternalHeader )
                        Endif

*-------------------------------------------------------------------------------
*-- RECORRO LOS OBJETOS DENTRO DE LA CLASE ACTUAL PARA EXPORTAR SU DEFINICIÓN
*-------------------------------------------------------------------------------
                        lnObjCount  = 0
                        lnRecno = Recno()
                        Locate For Upper( TABLABIN.PLATFORM ) = "WINDOWS" And Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)
*!* LScheffler 04.08.2023
                        Scan Rest While Upper( TABLABIN.PLATFORM ) = "WINDOWS" And Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)
                            lnObjCount  = lnObjCount + 1
                            loRegObj    = .Null.
                            Scatter Memo Name loRegObj

*-- Normalización de capitalización y de datos según parametrización
                            loRegObj.BaseClass      = Lower( loRegObj.BaseClass )
                            loRegObj.CLASSLOC       = Lower( loRegObj.CLASSLOC )
                            loRegObj.Class          = Lower( loRegObj.Class )
                            lcObjPathInsideClass    = Lower( loRegObj.Parent ) + '.' + Lower( loRegObj.OBJNAME )

                            If lnObjCount > 1 Then
                                lnPos   = Ascan( laObjs, lcObjPathInsideClass, 1, 0, 4, 1+2+4+8 )

                                If lnPos > 0 Then
*-- ERROR: Objeto Duplicado
                                    .writeErrorLog( '* ' + loLang.C_DUPLICATED_OBJECT_LOC + ' "' + loRegObj.Class + '.' + lcObjPathInsideClass ;
                                        + '" @Recno ' + Transform(loRegObj.regnum) + ', (1st.Recno:' + Transform(laObjs(lnPos,2)) + ')' )
                                Endif
                            Endif

                            Dimension laObjs(lnObjCount,4)
                            laObjs(lnObjCount,1)    = loRegObj
                            laObjs(lnObjCount,2)    = loRegObj.regnum       && ZOrder
                            laObjs(lnObjCount,3)    = lnObjCount            && Alphabetic order
                            laObjs(lnObjCount,4)    = lcObjPathInsideClass  && To check duplicates

                            If toFoxBin2Prg.l_NoTimestamps
                                loRegObj.Timestamp  = 0
                            Endif
                            If toFoxBin2Prg.l_ClearUniqueID
                                loRegObj.UNIQUEID   = ''
                            Else
                                loRegObj.UNIQUEID   = Alltrim(loRegObj.UNIQUEID)
                            Endif

                            loRegObj    = .Null.
                        Endscan

                        Goto Record (lnRecno)
                        Asort(laObjs, 2, -1, 0, 0)  && Orden por ZOrder

                        If lnObjCount > 0
                            lcCodigo    = lcCodigo + CR_LF + '  *-- OBJECTDATA items order determines ZOrder / El orden de los items OBJECTDATA determina el ZOrder '

                            For I = 1 To lnObjCount
                                .write_OBJECTMETADATA( laObjs(m.I,1), @lcCodigo )
                            Endfor

                            lcCodigo    = lcCodigo + CR_LF
                        Endif

                        .write_INCLUDE( @loRegClass, @lcCodigo )

                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Form ' + lcObjName + ' > Writing Properties...', lnStep, lnClassTotal*lnStepCount, 1 )

                        .write_CLASS_PROPERTIES( @loRegClass, @laPropsAndValues, @laPropsAndComments, @laProtected ;
                            , @lnPropsAndValues_Count, @lnPropsAndComments_Count, @lnProtected_Count, @lcCodigo, @toFoxBin2Prg )

                        Asort(laObjs, 3, -1, 0, 0)  && Orden Alfabético de objetos (del SCAN original)

                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Form ' + lcObjName + ' > Writing Obtects with Properties...', lnStep, lnClassTotal*lnStepCount, 1 )

                        For I = 1 To lnObjCount
                            .write_ADD_OBJECTS_WithProperties( laObjs(m.I,1), @lcCodigo, @toFoxBin2Prg )
                        Endfor


*-- OBTENGO LOS MÉTODOS DE LA CLASE PARA POSTERIOR TRATAMIENTO
                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Form ' + lcObjName + ' > Getting Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

                        Dimension laMethods(1,3), laCode(1)
                        Store '' To laMethods, laCode
                        lnMethodCount   = 0

                        .method2Array( loRegClass.METHODS, @laMethods, @laCode, '', @lnMethodCount ;
                            , @laPropsAndComments, lnPropsAndComments_Count, @laProtected, lnProtected_Count, @toFoxBin2Prg, @loRegClass )

                        .get_CLASS_METHODS( @lnMethodCount, @laMethods, @laCode, @laProtected, @laPropsAndComments, @toFoxBin2Prg )

                        lnLastClass     = 1
                        lcMethods       = ''

*-- RECORRO LOS OBJETOS DENTRO DE LA CLASE ACTUAL PARA OBTENER SUS MÉTODOS
                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Form ' + lcObjName + ' > Getting Objects Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

                        lnRecno = Recno()
                        Locate For TABLABIN.PLATFORM = "WINDOWS" And Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

                        Scan Rest ;
                                FOR Upper( TABLABIN.PLATFORM ) = "WINDOWS" ;
                                AND Not (Empty(TABLABIN.Parent) ;
                                AND ( Inlist( Lower( TABLABIN.BaseClass ), 'dataenvironment' , 'form', 'formset' ) ) ) ;
                                WHILE Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

                            loRegObj    = .Null.
                            Scatter Memo Name loRegObj

*-- Normalización de capitalización y de datos según parametrización
                            loRegObj.BaseClass  = Lower( loRegObj.BaseClass )
                            loRegObj.CLASSLOC   = Lower( loRegObj.CLASSLOC )
                            loRegObj.Class      = Lower( loRegObj.Class )

                            If toFoxBin2Prg.l_NoTimestamps
                                loRegObj.Timestamp  = 0
                            Endif
                            If toFoxBin2Prg.l_ClearUniqueID
                                loRegObj.UNIQUEID   = ''
                            Else
                                loRegObj.UNIQUEID   = Alltrim(loRegObj.UNIQUEID)
                            Endif

                            .get_ADD_OBJECT_METHODS( @loRegObj, @loRegClass, @lcMethods, @laMethods, @laCode, @lnMethodCount ;
                                , @laPropsAndComments, lnPropsAndComments_Count, @laProtected, lnProtected_Count, @toFoxBin2Prg )
                        Endscan

                        lnStep          = lnStep + 1
                        .updateProgressbar( 'Processing Form ' + lcObjName + ' > Writing Objects Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

                        .write_ALL_OBJECT_METHODS( @lcMethods, @laMethods, @laCode, @lnMethodCount, @laPropsAndComments, lnPropsAndComments_Count, @laProtected ;
                            , lnProtected_Count, @toFoxBin2Prg, @lcCodigo )

                        Goto Record (lnRecno)
                        .write_ENDDEFINE_IfApplicable( lnLastClass, @lcCodigo )
                        laClasses(lnClassCount,2)   = lcCodigo
                    Endscan

                    If toFoxBin2Prg.n_UseFormPerFile > 0 Then
                        lcExternalHeader    = lcExternalHeader + CR_LF
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


*-- Genero el SC2
                    lnStep          = lnStep + 1
                    lcOutputFile    = .c_OutputFile

                    .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_SC2 + '...', lnStep, lnClassTotal*lnStepCount, 1 )
                    lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + lcExternalHeader + C_FB2PRG_CODE

                    If .l_Test
*FOR I = 1 TO lnClassCount
*   lcCodigo    = lcCodigo + laClasses(m.I,2)
*ENDFOR
*toModulo   = lcCodigo
                    Else
                        Do Case
                            Case toFoxBin2Prg.n_UseFormPerFile = 1  && LibName.ClassName.SC2
                                .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )

                                For I = 1 To lnClassCount
                                    lcOutputFile    = Addbs( Justpath( .c_OutputFile ) ) + Juststem( .c_OutputFile ) + '.' + laClasses(m.I,1) + '.' + Justext( .c_OutputFile )
                                    lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + laClasses(m.I,2)
                                    .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                                Endfor

                            Case toFoxBin2Prg.n_UseFormPerFile = 2  && LibName.BaseClass.ClassName.SC2
                                .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )

                                For I = 1 To lnClassCount
                                    lcOutputFile    = Addbs( Justpath( .c_OutputFile ) ) + Juststem( .c_OutputFile ) + '.' + laClasses(m.I,3) + '.' + laClasses(m.I,1) + '.' + Justext( .c_OutputFile )
                                    lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + laClasses(m.I,2)
                                    .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                                Endfor

                            Otherwise
                                For I = 1 To lnClassCount
                                    lcCodigo    = lcCodigo + laClasses(m.I,2)
                                Endfor

                                .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                        Endcase
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
                Use In (Select("_TABLAORIG"))
                Store .Null. To loRegClass, loRegObj
                Release toModulo, toEx, toFoxBin2Prg ;
                    , lnCodError, loRegClass, loRegObj, lnMethodCount, laMethods, laCode, laProtected, lnLen, lnObjCount ;
                    , laPropsAndValues, laPropsAndComments, lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle ;
                    , laObjs, I, lnPropsAndValues_Count, lnPropsAndComments_Count, lnProtected_Count ;
                    , lcCodigo, laClasses, lnClassCount, lcOutputFile

        Endtry

        Return
    Endproc
Enddefine



Define Class c_conversor_pjm_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    _MemberData = [<VFPData>] ;
        + [<memberdata name="strextract_cr" display="strExtract_CR"/>] ;
        + [</VFPData>]

    #If .F.
        Local This As c_conversor_pjm_a_prg Of 'FOXBIN2PRG.PRG'
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
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif
        DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

        Try
                If toFoxBin2Prg.l_ProcessFiles Then
                    Local lnCodError, lcStr, lnPos, lnLen, lnServerCount, loReg, lnLen ;
                        , lcStrPJM, laLines(1), laProps(1) ;
                        , loEx As Exception ;
                        , loProject As CL_PROJECT Of 'FOXBIN2PRG.PRG' ;
                        , loServerHead As CL_PROJ_SRV_HEAD Of 'FOXBIN2PRG.PRG' ;
                        , loServerData As CL_PROJ_SRV_DATA Of 'FOXBIN2PRG.PRG' ;
                        , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

                    loLang          = _Screen.o_FoxBin2Prg_Lang
                    Store .Null. To loProject, loReg, loServerHead, loServerData
                    lcStrPJM        = Filetostr( This.c_InputFile )
                    This.updateProgressbar( 'Scanning PJM...', 1, 2, 1 )


*-- Obtengo los archivos del proyecto
                    loProject       = Createobject('CL_PROJECT')
                    loServerHead    = loProject._ServerHead

                    With loProject As CL_PROJECT Of 'FOXBIN2PRG.PRG'
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
                            With loServerHead As CL_PROJ_SRV_HEAD Of 'FOXBIN2PRG.PRG'
                                ._LibraryName   = laProps(1)
                                ._InternalName  = laProps(2)
                                ._ProjectName   = laProps(3)
                                ._TypeLibDesc   = laProps(4)
                                ._ServerType    = Padl(laProps(5),4)
                                ._TypeLib       = laProps(6)
                            Endwith

                        Else
                            loServerData = loServerHead.getServerDataObject()

                            With loServerData As CL_PROJ_SRV_DATA Of 'FOXBIN2PRG.PRG'
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
                        AddProperty( loReg, 'ID', Iif( toFoxBin2Prg.l_ClearUniqueID, 0, Val( laProps(1) ) ) )
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


*-- Información del programa
                    C_FB2PRG_CODE   = C_FB2PRG_CODE + loProject.getFormattedDeviceInfoText() + CR_LF


*-- Información de los Servidores definidos
                    If Not Empty(loProject._ServerInfo)
                        C_FB2PRG_CODE   = C_FB2PRG_CODE + loServerHead.getFormattedServerText() + CR_LF
                        loServerHead    = .Null.
                    Endif

                    With This As c_conversor_pjm_a_prg Of 'FOXBIN2PRG.PRG'

*-- Generación del proyecto
*** DH 2021-03-04: only output HomeDir if we're supposed to
                        If toFoxBin2Prg.n_HomeDir = 1
                            TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<C_BUILDPROJ_I>>
                            <<>>*<.HomeDir = <<loProject._HomeDir>> />
                            ENDTEXT
                        Else
                            TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<C_BUILDPROJ_I>>
                            ENDTEXT
                        Endif toFoxBin2Prg.n_HomeDir = 1
*** DH 2021-03-04: end of updated code
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

messagebox('convert')
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
                        _VFP.Projects('<<JUSTFNAME( EVL( .c_OriginalFileName, .c_InputFile ) )>>').Close()
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
                This.updateProgressbar( 'Writing ' + toFoxBin2Prg.c_PJ2 + '...', 2, 2, 1 )

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



Define Class c_conversor_frx_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    #If .F.
        Local This As c_conversor_frx_a_prg Of 'FOXBIN2PRG.PRG'
    #Endif

    c_Type                  = 'FRX'



    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toModulo                  (!@    OUT) Objeto generado de clase CL_PROJECT con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toModulo, toEx As Exception, toFoxBin2Prg
        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif
        DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

        Try
                With This As c_conversor_frx_a_prg Of 'FOXBIN2PRG.PRG'
                    If toFoxBin2Prg.l_ProcessFiles Then
                        Local lnCodError, loRegCab, loRegDataEnv, loRegCur, loRegObj, lnMethodCount, laMethods(1), laCode(1), laProtected(1), lnLen ;
                            , laPropsAndValues(1), laPropsAndComments(1), lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle(1) ;
                            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

                        loLang          = _Screen.o_FoxBin2Prg_Lang
                        Store 0 To lnCodError, lnLastClass
                        Store '' To laMethods(1), laCode(1), laProtected(1), laPropsAndComments(1)
                        Store .Null. To loRegObj, loRegCab, loRegDataEnv, loRegCur

                        Use (.c_InputFile) Shared Again Noupdate Alias _TABLAORIG

                        *  keep CodePage relavant information for binary sources
                        toFoxBin2Prg.i_CPID = Cpdbf("_TABLAORIG")
                        SET NOCPTRANS TO NAME,EXPR,STYLE,PICTURE,ORDER,COMMENT,TAG,TAG2,FONTFACE,SUPEXPR,USER

                        This.updateProgressbar( 'Scanning FRX...', 1, 2, 1 )

                        *-- Verificación de REPORTE VFP 9
                        If Fcount() < 75 Or Empty(Field("USER"))
                            * ERROR 'Report [' + (.c_InputFile) + '] is NOT VFP 9 Format! - Please convert to VFP 9 with MODIFY REPORT ' + JUSTFNAME((.c_InputFile))
                            Error (Textmerge(loLang.C_REPORT_NOT_IN_VFP9_FORMAT_LOC))
                        Endif

                        C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

*SELECT * FROM _TABLAORIG ;
WHERE ObjType IN (1,25,26) ;
ORDER BY ObjType ASC ;
INTO CURSOR TABLABIN_0 READWRITE
*-- Arreglo bug agrupación de controles. 29/10/2015
                        Select * From _TABLAORIG ;
                        WHERE  ObjType In (1,25,26) ;
                        INTO   CURSOR TABLABIN_0 Readwrite

*-- Header
                        Select TABLABIN_0
                        Locate For ObjType = 1

                        If Found()
                            loRegCab    = .Null.
                            Scatter Memo Name loRegCab

                            If toFoxBin2Prg.l_NoTimestamps
                                loRegCab.Timestamp  = 0
                            Endif
                            If toFoxBin2Prg.l_ClearUniqueID
                                loRegCab.UNIQUEID   = ''
                            Endif
                        Endif

                        If .l_ReportSort_Enabled
*-- ORDENADO
                            Select * From _TABLAORIG ;
                                WHERE ObjType Not In (1,25,26) ;
                                ORDER By vpos,hpos Asc ;
                                INTO Cursor TABLABIN Readwrite
                        Else
*-- SIN ORDENAR (Sólo para poder comparar con el original)
                            Select * From _TABLAORIG ;
                                WHERE ObjType Not In (1,25,26) ;
                                INTO Cursor TABLABIN
                        Endif

                        loRegObj    = .Null.


*-- Recorro los registros y genero el texto
                        If Vartype(loRegCab) = "O"
                            .write_TXT_REPORTE( @loRegCab )
                        Endif

                        Select TABLABIN

                        Scan All
                            loRegObj    = .Null.
                            Scatter Memo Name loRegObj

                            If toFoxBin2Prg.l_NoTimestamps
                                loRegObj.Timestamp  = 0
                            Endif
                            If toFoxBin2Prg.l_ClearUniqueID
                                loRegObj.UNIQUEID   = ''
                            Endif

                            .write_TXT_REPORTE( @loRegObj )
                        Endscan

*-- Dataenvironment
                        Select TABLABIN_0
                        Locate For ObjType = 25

                        If Found()
                            loRegDataEnv    = .Null.
                            Scatter Memo Name loRegDataEnv

                            If toFoxBin2Prg.l_NoTimestamps
                                loRegDataEnv.Timestamp  = 0
                            Endif
                            If toFoxBin2Prg.l_ClearUniqueID
                                loRegDataEnv.UNIQUEID   = ''
                            Endif

                            .write_TXT_REPORTE( @loRegDataEnv )
                        Endif

*-- Cursors and Relations
                        Select TABLABIN_0

                        Scan All For ObjType = 26
                            loRegCur    = .Null.
                            Scatter Memo Name loRegCur

                            If toFoxBin2Prg.l_NoTimestamps
                                loRegCur.Timestamp  = 0
                            Endif
                            If toFoxBin2Prg.l_ClearUniqueID
                                loRegCur.UNIQUEID   = ''
                            Endif

                            .write_TXT_REPORTE( @loRegCur )
                        Endscan
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


*-- Genero el FR2
                    .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_FR2 + '...', 2, 2, 1 )

                    If .l_Test
                        toModulo    = C_FB2PRG_CODE
                    Else
                        .write_OutputFile( (C_FB2PRG_CODE), .c_OutputFile, @toFoxBin2Prg )
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
                Use In (Select("TABLABIN_0"))
                Use In (Select("_TABLAORIG"))
                Store .Null. To loRegObj, loRegCab, loRegDataEnv, loRegCur
                Release toModulo, toEx, toFoxBin2Prg ;
                    , lnCodError, loRegCab, loRegDataEnv, loRegCur, loRegObj, lnMethodCount, laMethods, laCode, laProtected, lnLen ;
                    , laPropsAndValues, laPropsAndComments, lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle

        Endtry

        Return
    Endproc
Enddefine



Define Class c_conversor_dbf_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    #If .F.
        Local This As c_conversor_dbf_a_prg Of 'FOXBIN2PRG.PRG'
    #Endif
    c_Type                  = 'DBF'


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toModulo                  (!@    OUT) Contenido del texto generado
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toModulo, toEx As Exception, toFoxBin2Prg
        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif
        DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

*!* Changed by: LScheffler 11.2.2021
*!* change date="{^2021-02-11,08:50:00}"
* If toFoxBin2Prg.l_ProcessFiles is not true
* and the try block was exited
* the stuff below was never instatiated

*so the whole try / catch block should not run

        If Not toFoxBin2Prg.l_ProcessFiles Then
            This.write_OutputFile( '', This.c_OutputFile, @toFoxBin2Prg )
        Else  &&NOT toFoxBin2Prg.l_ProcessFiles
*!* /Changed by: LScheffler 11.2.2021

            Try
                    With This As c_conversor_dbf_a_prg Of 'FOXBIN2PRG.PRG'
*!* Changed by: LScheffler 11.2.2021
*!* change date="{^2021-02-11,08:50:00}"
*moved up:
*               IF NOT toFoxBin2Prg.l_ProcessFiles THEN
*                   .write_OutputFile( '', .c_OutputFile, @toFoxBin2Prg )
*                   EXIT    && Si se indicó no procesar, se sale aquí. (Modo de simulación)
*               ENDIF
*!* /Changed by: LScheffler 11.2.2021

                        Local lnCodError, laDatabases(1), lnDatabases_Count, laDatabases2(1) ;
                            , lnLen, lc_FileTypeDesc, laLines(1), lcOutputFile ;
                            , ln_HexFileType, ll_FileHasCDX, ll_FileHasMemo, ll_FileIsDBC ;
                            , lc_DBC_Name, lnDataSessionID, lnSelect, laDirInfo(1,5) ;
                            , llDBCEventsEnabled ;
                            , loTable As CL_DBF_TABLE Of 'FOXBIN2PRG.PRG' ;
                            , loDBFUtils As CL_DBF_UTILS Of 'FOXBIN2PRG.PRG' ;
                            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
                            , loFSO As Scripting.FileSystemObject ;
                            , loTextStream As Scripting.TextStream ;
                            , loDBC As CL_DBC Of 'FOXBIN2PRG.PRG'

                        loLang          = _Screen.o_FoxBin2Prg_Lang
                        loFSO           = toFoxBin2Prg.o_FSO
                        Store .Null. To loTable, loDBFUtils
                        Store 0 To lnCodError
                        loDBFUtils          = Createobject('CL_DBF_UTILS')
                        loDBC               = Createobject('CL_DBC')

*-- EVALUAR OPCIONES ESPECÍFICAS DE DBF
                        .updateProgressbar( 'Scanning DBF Structure...', 1, 3, 1 )

*-- Include
                        If Not Empty(toFoxBin2Prg.c_DBF_Conversion_Included) And Not toFoxBin2Prg.c_DBF_Conversion_Included == '*' ;
                                AND Not toFoxBin2Prg.filenameFoundInFilter( Justfname(.c_InputFile), toFoxBin2Prg.c_DBF_Conversion_Included )
                            toFoxBin2Prg.writeLog('  ' + Justfname(.c_InputFile) + ' no está en el filtro DBF_Conversion_Included (' + toFoxBin2Prg.c_DBF_Conversion_Included + ')' )
                            Exit
                        Endif

*-- Exclude
                        If Not Empty(toFoxBin2Prg.c_DBF_Conversion_Excluded) ;
                                AND toFoxBin2Prg.filenameFoundInFilter( Justfname(.c_InputFile), toFoxBin2Prg.c_DBF_Conversion_Excluded )
                            toFoxBin2Prg.writeLog('  ' + Justfname(.c_InputFile) + ' está en el filtro DBF_Conversion_Excluded (' + toFoxBin2Prg.c_DBF_Conversion_Excluded + ')' )
                            Exit
                        Endif

                        loDBFUtils.getDBFmetadata( .c_InputFile, @ln_HexFileType, @ll_FileHasCDX, @ll_FileHasMemo, @ll_FileIsDBC, @lc_DBC_Name )
                        lc_FileTypeDesc     = loDBFUtils.fileTypeDescription(ln_HexFileType)
                        lnDatabases_Count   = Adatabases(laDatabases)

* Si la tabla pertenece a un DBC, desactivar temporalmente los eventos
                        If Not Empty(lc_DBC_Name) And Adir(laDirInfo, Fullpath(lc_DBC_Name, .c_InputFile)) = 1
                            loDBC._DBC          = Fullpath(lc_DBC_Name, .c_InputFile)
                            llDBCEventsEnabled  = loDBC.DBGetProp(lc_DBC_Name,"DATABASE","DBCEvents")

* llDBCEventsEnabled no siempre devuelve .T./.F., a veces devuelve ""
                            If Empty(llDBCEventsEnabled)
                                llDBCEventsEnabled  = .F.
                            Endif

                            If llDBCEventsEnabled
                                If Not loDBC.DBSetProp(lc_DBC_Name,"DATABASE","DBCEvents",.F.)
                                    llDBCEventsEnabled  = .F.
                                Endif
                            Endif
                        Endif
* LScheffler
                        Use (.c_InputFile) Shared Again Noupdate Alias TABLABIN
*LScheffler 20.08.2023
*issue #96, including issue #95, [KestasL] keep CodePage relavant information for binary sources
                        toFoxBin2Prg.i_CPID = Cpdbf("TABLABIN")

                        lnDataSessionID = toFoxBin2Prg.DataSessionId
                        .RestoreDBCEvents(loDBC, @llDBCEventsEnabled)

                        C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

*-- Header
                        loTable         = Createobject('CL_DBF_TABLE')

*-- Exportación de estructura y datos (para Diff solamente)
                        Erase (.c_OutputFile + '.TMP' )
                        loTextStream    = loFSO.CreateTextFile(.c_OutputFile + '.TMP' )     && Replace VFP low-level file funcs.because the 8-16KB limit.
                        toFoxBin2Prg.o_TextStream = loTextStream

                        If toFoxBin2Prg.n_FileHandle = -1 Then
                            Error 102, (.c_OutputFile)
                        Endif

                        loTextStream.WriteLine( C_FB2PRG_CODE )     && Replace VFP low-level file funcs.because the 8-16KB limit.
* LScheffler, Analyse, call table
                        loTable.toText( ln_HexFileType, ll_FileHasCDX, ll_FileHasMemo, ll_FileIsDBC, lc_DBC_Name, .c_InputFile, lc_FileTypeDesc, @toFoxBin2Prg )

                        loTextStream.Close()

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


*-- Genero el DB2, renombrando el TMP
                        .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_DB2 + '...', 3, 3, 1 )
                        If .l_Test
                            toModulo    = C_FB2PRG_CODE
                        Else
                            Do Case
                                Case Adir(laDirInfo, .c_OutputFile) > 0 And toFoxBin2Prg.comparedFilesAreEqual( .c_OutputFile + '.TMP', .c_OutputFile ) = 1
                                    Erase (.c_OutputFile + '.TMP')
*.writeLog( 'El archivo de salida [' + .c_OutputFile + '] no se sobreescribe por ser igual al generado.' )
                                    lcOutputFile    = .c_OutputFile
                                    .writeLog( C_TAB + C_TAB + '* ' + Textmerge(loLang.C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC) )
                                Case toFoxBin2Prg.doBackup( .F., .T., '', '', '' ) ;
                                        AND toFoxBin2Prg.changeFileAttribute( .c_OutputFile + '.TMP', '-R' ) > 0 ;
                                        AND Not toFoxBin2Prg.renameTmpFile2Tx2File( .c_OutputFile )
*ERROR 'No se puede generar el archivo [' + .c_OutputFile + '] porque es ReadOnly'
                                    Error (Textmerge(loLang.C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC))
                            Endcase
                        Endif


*-- Hook para permitir ejecución externa (por ejemplo, para exportar datos)
                        If Not Empty(toFoxBin2Prg.run_AfterCreate_DB2)
                            lnSelect    = Select()
                            Do (toFoxBin2Prg.run_AfterCreate_DB2) With (lnDataSessionID), (.c_OutputFile), (loTable)
                            Set DataSession To (lnDataSessionID)    && Por las dudas externamente se cambie
                            Select (lnSelect)
                        Endif

                    Endwith && THIS


                Catch To toEx
                    This.set_UserValue(@toEx)

                    Do Case
                        Case toEx.ErrorNo = 13 && Alias not found
                            toEx.UserValue = toEx.UserValue + Textmerge(loLang.C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC)

*!* CASE toEx.ErrorNo = 1976 && Cannot resolve backlink
*!*     toEx.UserValue = 'WARNING!!' + CR_LF ;
*!*         + "MAY BE DATABASE FIELDS DOESN'T" ;
*!*         + UPPER(JUSTSTEM(THIS.c_InputFile)) + '.field tag keyname)' + CR_LF + CR_LF ;
*!*         + '¡¡ATENCIÓN!!' + CR_LF ;
*!*         + 'ASEGÚRESE DE QUE NO ESTÁ USANDO UN ALIAS DE TABLA EN LAS EXPRESIONES DE LOS ÍNDICES!! (ej: index on ' ;
*!*         + UPPER(JUSTSTEM(THIS.c_InputFile)) + '.campo tag nombreclave)'

                    Endcase
                    If This.n_Debug > 0 And _vfp.StartMode = 0
                        Set Step On
                    Endif

                    Throw

                Finally
                    Use In (Select("TABLABIN"))
                    This.RestoreDBCEvents(loDBC, @llDBCEventsEnabled)

                    If Vartype(loTextStream) = "O" Then
                        loTextStream.Close()
                    Endif

*-- Cierro DBC
                    For I = 1 To Adatabases(laDatabases2)
                        If Ascan( laDatabases, laDatabases2(m.I), 1, 0, 0, 1+2+4 ) = 0
                            Set Database To (laDatabases2(m.I))
                            Close Databases
                            Exit
                        Endif
                    Endfor

                    Store .Null. To loTable, loDBFUtils, loTextStream, toFoxBin2Prg.o_TextStream
*!* Changed by: LScheffler 11.2.2021
*!* change date="{^2021-02-11,08:50:00}"
* Release different, parts moved outsidef IF .. ENDIF
                    Release loTextStream ;
                        , lnCodError, laDatabases, lnDatabases_Count, laDatabases2, lnLen, lc_FileTypeDesc ;
                        , ln_HexFileType, ll_FileHasCDX, ll_FileHasMemo, ll_FileIsDBC, lc_DBC_Name, lnDataSessionID, lnSelect ;
                        , loTable, loDBFUtils
            Endtry
*!* Changed by: LScheffler 11.2.2021
*!* change date="{^2021-02-11,08:50:00}"
* so the whole try / catch block should not run if in simulation

        Endif  &&NOT toFoxBin2Prg.l_ProcessFiles

* Release  from above
        Release toModulo, toEx, toFoxBin2Prg, loTextStream ;
*!* /Changed by: LScheffler 11.2.2021

        Return
    Endproc


    Procedure RestoreDBCEvents(toDBC, tlDBCEventsEnabled)
        #If .F.
            Local toDBC As CL_DBC Of 'FOXBIN2PRG.PRG'
        #Endif
        If tlDBCEventsEnabled And Vartype(toDBC)="O"
            toDBC.DBSetProp('',"DATABASE","DBCEvents",.T.)
            tlDBCEventsEnabled  = .F.
        Endif
    Endproc


Enddefine


* LScheffler, Analyse, just locate
Define Class c_conversor_dbc_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    #If .F.
        Local This As c_conversor_dbc_a_prg Of 'FOXBIN2PRG.PRG'
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
            Local toDatabase As CL_DBC Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As c_conversor_dbc_a_prg Of 'FOXBIN2PRG.PRG'
                    Local lnCodError, laDatabases(1), lnDatabases_Count, lcEventsFile, lcExternalHeader, lcCodigo ;
                        , lnClassCount, laClasses(1,3) ;
                        , loConnection As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG' ;
                        , loTable As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG' ;
                        , loView As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'

                    Store .Null. To loRelation, loView, loTable
                    Store 0 To lnCodError, lnDatabases_Count, lnClassCount
                    Store '' To laDatabases, lcEventsFile, lcExternalHeader, laClasses, lcCodigo, C_FB2PRG_CODE

                    lnDatabases_Count   = Adatabases(laDatabases)
                    Use (.c_InputFile) Shared Again Noupdate Alias TABLABIN

*LScheffler 20.08.2023
*issue #96, including issue #95, [KestasL] keep CodePage relavant information for binary sources
                    toFoxBin2Prg.i_CPID = Cpdbf("TABLABIN")
                    SET NOCPTRANS TO OBJECTNAME,USER
*/LScheffler 20.08.2023

                    If toFoxBin2Prg.l_ProcessFiles Then
                        toDatabase          = Createobject('CL_DBC')
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
                        If toFoxBin2Prg.n_UseFilesPerDBC > 0 Then
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
                        Select Lower(TB.ObjectName), '', Lower(TB.ObjectType) ;
                            FROM TABLABIN TB ;
                            WHERE TB.ParentId = 1 And ( TB.ObjectType In (Padr('View',10), Padr('Table',10), Padr('Connection',10) ) ;
                            OR TB.ObjectType = Padr('Database',10) And TB.ObjectName = Padr('StoredProceduresSource',128) And Not Empty(TB.Code) ) ;
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
                        .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_DC2 + '...', 2, 2, 1 )
                        lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + lcExternalHeader + C_FB2PRG_CODE
                    Endif

                    If .l_Test
*FOR I = 1 TO lnClassCount
*   lcCodigo    = lcCodigo + laClasses(m.I,2)
*ENDFOR
*toDatabase = lcCodigo
                    Else

                        If toFoxBin2Prg.n_UseFilesPerDBC > 0 Then
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



Define Class c_conversor_mnx_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    #If .F.
        Local This As c_conversor_mnx_a_prg Of 'FOXBIN2PRG.PRG'
    #Endif
    c_Type                  = 'MNX'


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* totoMenu                  (!@    OUT) Objeto generado de clase CL_MENU con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toMenu, toEx As Exception, toFoxBin2Prg
        DoDefault( @toMenu, @toEx, @toFoxBin2Prg )

        #If .F.
            Local toMenu As CL_MENU Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As c_conversor_mnx_a_prg Of 'FOXBIN2PRG.PRG'
                    If toFoxBin2Prg.l_ProcessFiles Then
                        Local lnCodError, lnLen ;
                            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

                        loLang          = _Screen.o_FoxBin2Prg_Lang
                        Store 0 To lnCodError

                        Use (.c_InputFile) Shared Again Noupdate Alias _TABLAORIG

*LScheffler 20.08.2023
*issue #96, [KestasL] keep CodePage relavant information for binary sources
                        toFoxBin2Prg.i_CPID = Cpdbf("_TABLAORIG")
                        SET NOCPTRANS TO NAME,PROMPT,COMMAND,MESSAGE,PROCEDURE,SETUP,CLEANUP,KEYNAME,KEYLABEL,SKIPFOR
*/LScheffler 20.08.2023


                        Select * From _TABLAORIG Into Cursor TABLABIN
                        Use In (Select("_TABLAORIG"))
                        .updateProgressbar( 'Analyzing MNX...', 1, 2, 1 )

*-- Verificación de menú VFP 9
                        If Fcount() < 25 Or Empty(Field("RESNAME")) Or Empty(Field("SYSRES"))
*ERROR 'Menu [' + (.c_InputFile) + '] is NOT VFP 9 Format! - Please convert to VFP 9 with MODIFY MENU ' + JUSTFNAME((.c_InputFile))
                            Error (Textmerge(loLang.C_MENU_NOT_IN_VFP9_FORMAT_LOC))
                        Endif

*-- Header
                        C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

                        toMenu          = Createobject('CL_MENU')
                        toMenu.get_DataFromTablabin()
                        C_FB2PRG_CODE   = C_FB2PRG_CODE + toMenu.toText()
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


*-- Genero el MN2
                    If toFoxBin2Prg.l_ProcessFiles Then
                        .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_MN2 + '...', 2, 2, 1 )
                    Endif

                    If .l_Test
                        toMenu  = C_FB2PRG_CODE
                    Else
                        .write_OutputFile( (C_FB2PRG_CODE), .c_OutputFile, @toFoxBin2Prg )
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
                Use In (Select("_TABLAORIG"))
                Release toMenu, toEx, toFoxBin2Prg, lnCodError, lnLen
        Endtry

        Return
    Endproc
Enddefine



Define Class c_conversor_fky_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    #If .F.
        Local This As c_conversor_fky_a_prg Of 'FOXBIN2PRG.PRG'
    #Endif
    c_Type                  = 'FKY'


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toMacro                   (!@    OUT) Objeto generado de clase CL_MACRO con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toMacro, toEx As Exception, toFoxBin2Prg
        DoDefault( @toMacro, @toEx, @toFoxBin2Prg )

        #If .F.
            Local toMacro As CL_MACRO Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Local lnCodError, lnLen, lnHandle ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

        Try
                With This As c_conversor_fky_a_prg Of 'FOXBIN2PRG.PRG'
                    lnHandle    = -1

                    If toFoxBin2Prg.l_ProcessFiles Then
                        loLang          = _Screen.o_FoxBin2Prg_Lang
                        Store 0 To lnCodError

                        .updateProgressbar( 'Analyzing FKY...', 1, 2, 1 )

*-- Verificación de archivo de macros válido
*IF FCOUNT() < 25 OR EMPTY(FIELD("RESNAME")) OR EMPTY(FIELD("SYSRES"))
*   *ERROR 'Menu [' + (.c_InputFile) + '] is NOT VFP 9 Format! - Please convert to VFP 9 with MODIFY MENU ' + JUSTFNAME((.c_InputFile))
*   ERROR (TEXTMERGE(loLang.C_MENU_NOT_IN_VFP9_FORMAT_LOC))
*ENDIF

*-- Header
                        C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

                        toMacro         = Createobject('CL_MACRO')
                        toMacro.get_DataFromMacroFKY(.c_InputFile, @toFoxBin2Prg)
                        C_FB2PRG_CODE   = C_FB2PRG_CODE + toMacro.toText()
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


*-- Genero el FK2
                    If toFoxBin2Prg.l_ProcessFiles Then
                        .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_FK2 + '...', 2, 2, 1 )
                    Endif

                    If .l_Test
                        toMacro = C_FB2PRG_CODE
                    Else
                        .write_OutputFile( (C_FB2PRG_CODE), .c_OutputFile, @toFoxBin2Prg )
                    Endif
                Endwith && THIS


            Catch To toEx
                This.set_UserValue(@toEx)

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
*
        Endtry

        Return
    Endproc
Enddefine



Define Class c_conversor_mem_a_prg As c_conversor_bin_a_prg OF 'c_conversor_bin_a_prg.prg'
    #If .F.
        Local This As c_conversor_mem_a_prg Of 'FOXBIN2PRG.PRG'
    #Endif
    c_Type                  = 'MEM'


    Procedure convert
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toMacro                   (!@    OUT) Objeto generado de clase CL_MACRO con la información leida del texto
* toEx                      (!@    OUT) Objeto con información del error
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        Lparameters toMemVar, toEx As Exception, toFoxBin2Prg
        DoDefault( @toMemVar, @toEx, @toFoxBin2Prg )

        #If .F.
            Local toMemVar As CL_MEMVAR Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Local lnCodError, lnLen, lnHandle ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

        Private pnCols, pnRows, pnElement
        Store 0 To pnCols, pnRows, pnElement

        Try
                With This As c_conversor_mem_a_prg Of 'FOXBIN2PRG.PRG'
                    lnHandle    = -1

                    If toFoxBin2Prg.l_ProcessFiles Then
                        loLang          = _Screen.o_FoxBin2Prg_Lang
                        Store 0 To lnCodError

                        .updateProgressbar( 'Analyzing MEM...', 1, 2, 1 )

*-- Verificación de archivo de macros válido
*IF FCOUNT() < 25 OR EMPTY(FIELD("RESNAME")) OR EMPTY(FIELD("SYSRES"))
*   *ERROR 'Menu [' + (.c_InputFile) + '] is NOT VFP 9 Format! - Please convert to VFP 9 with MODIFY MENU ' + JUSTFNAME((.c_InputFile))
*   ERROR (TEXTMERGE(loLang.C_MENU_NOT_IN_VFP9_FORMAT_LOC))
*ENDIF

*-- Header
                        C_FB2PRG_CODE   = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()

                        toMemVar        = Createobject('CL_MEMVAR')
                        toMemVar.get_DataFromMEM(.c_InputFile, @toFoxBin2Prg)
                        C_FB2PRG_CODE   = C_FB2PRG_CODE + toMemVar.toText()
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


*-- Genero el FK2
                    If toFoxBin2Prg.l_ProcessFiles Then
                        .updateProgressbar( 'Writing ' + toFoxBin2Prg.c_ME2 + '...', 2, 2, 1 )
                    Endif

                    If .l_Test
                        toMemVar    = C_FB2PRG_CODE
                    Else
                        .write_OutputFile( (C_FB2PRG_CODE), .c_OutputFile, @toFoxBin2Prg )
                    Endif
                Endwith && THIS


            Catch To toEx
                This.set_UserValue(@toEx)

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
*
        Endtry

        Return
    Endproc
Enddefine



Define Class CL_COL_BASE As Collection
    #If .F.
        Local This As CL_COL_BASE Of 'FOXBIN2PRG.PRG'
    #Endif

*-- Propiedades (Se preservan: COUNT, KEYSORT, NAME)
**HIDDEN BASECLASS, CLASS, CLASSLIBRARY, COUNT, COMMENT ;
, PARENT, PARENTCLASS, TAG

    _MemberData = [<VFPData>] ;
        + [<memberdata name="n_debug" display="n_Debug"/>] ;
        + [<memberdata name="_saved" display="_Saved"/>] ;
        + [<memberdata name="analyzecodeblock" display="analyzeCodeBlock"/>] ;
        + [<memberdata name="get_separatedlineandcomment" display="get_SeparatedLineAndComment"/>] ;
        + [<memberdata name="get_absolutepath" display="get_AbsolutePath"/>] ;
        + [<memberdata name="set_line" display="set_Line"/>] ;
        + [<memberdata name="totext" display="toText"/>] ;
        + [</VFPData>]

    n_Debug             = 0
    _Saved              = .F.       && Indica si la información fue leida y guardada en las propiedades.


    Procedure Init
        Set Deleted On
        Set Date YMD
        Set Hours To 24
        Set Century On
        Set Safety Off
        Set TablePrompt Off

        This.n_Debug    = Iif(_vfp.StartMode=0, 1, 0)
    Endproc


    Procedure analyzeCodeBlock
    Endproc


    Procedure set_Line
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@    OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (v! IN    ) Número de línea en análisis
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I
        tcLine  = Ltrim( taCodeLines(m.I), 0, Chr(9), ' ' )
    Endproc


    Procedure get_AbsolutePath
        Lparameters tc_InputFile, tc_FullPath

*-- Ajusto la ruta si no es absoluta
        tc_InputFile    = Evl(tc_InputFile,'')

        If Not Empty( Justext(tc_FullPath) ) Then
*-- Se indicó PATH+archivo.ext
            tc_FullPath = Justpath(tc_FullPath)
        Endif

        tc_FullPath = Addbs( tc_FullPath )

        If Len(tc_InputFile) > 1 ;
                AND Left(Ltrim(tc_InputFile),2) <> '\\' ;
                AND Substr(Ltrim(tc_InputFile),2,1) <> ':' Then
            tc_InputFile    = Fullpath(tc_InputFile, tc_FullPath)
        Endif

        Return tc_InputFile
    Endproc


    Procedure get_SeparatedLineAndComment
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Línea a separar del comentario
* tcComment                 (@?    OUT) Comentario
* tlDeepCommentAnalysis     (v? IN    ) Indica realizar un análisis profundo de comentarios (para detectar casos complejos de código con '&&' embebido)
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine As String, tcComment As String, tlDeepCommentAnalysis As Boolean
        Local ln_AT_Cmt
        tcComment   = ''
        ln_AT_Cmt   = At( '&'+'&', tcLine)

        If ln_AT_Cmt > 0
            If tlDeepCommentAnalysis Then
                Local laSeparador(3,3), lcSeparadoresIzq, lcSeparadoresDer, lcStr, lnAT_Amp, lnAT1, lnAT2, lnLen, I, X

                lcStr   = tcLine    &&EVL(tcStr, [DEFINE BAR 2 OF OpciónAsub PROMPT "Opción A&]+[&2" &]+[& Comentario Opción A-2])
                laSeparador(1,1)    = '"'
                laSeparador(1,2)    = '"'
                laSeparador(1,3)    = 2
                laSeparador(2,1)    = "'"
                laSeparador(2,2)    = "'"
                laSeparador(2,3)    = 2
                laSeparador(3,1)    = '['
                laSeparador(3,2)    = ']'
                laSeparador(3,3)    = 1
                lcSeparadoresIzq    = laSeparador(1,1) + laSeparador(2,1) + laSeparador(3,1)
                lcSeparadoresDer    = laSeparador(1,2) + laSeparador(2,2) + laSeparador(3,2)
                lnLen               = Len(lcStr)

*-- Anular subcadenas para luego encontrar comentarios '&&' (y analizar solo si existe al menos un '&&')
                X       = 1
                lnAT1   = At(laSeparador(m.X,1), lcStr)

*-- Funcionamiento:
*-- La anulación de subcadenas se hace comenzando desde la primer comilla doble ["], y luego se va
*-- cancelando hasta la siguiente. A partir de ahi, se busca carácter a carácter el siguiente separador
*-- izquierdo de cadena ( '"[ ), se busca su pareja derecha y se cancela el texto entre ambos.
*-- La anulación de subcadenas es temporal, solo para determinar la verdadera posición del comentario,
*-- por ejemplo, esto:
*-- DEFINE BAR 2 OF OpciónAsub PROMPT ""+var+'aa'+["bb]+"Opción A&&2" && Comentario Opción A-2
*-- se convierte temporalmente en esto:
*-- DEFINE BAR 2 OF OpciónAsub PROMPT XX+var+XXXX+XXXXX+XXXXXXXXXXXXX && Comentario Opción A-2
*-- lo que facilita encontrar el comentario '&&' real.
*-- Si se encuentra algún separador de cadena que no cierre, se genera un error 10 (Syntax Error).
                If lnAT1 > 0 Then
                    For I = lnAT1+1 To lnLen
                        If m.X > 0 Then
                            lnAT2   = At(laSeparador(m.X,2), lcStr, laSeparador(m.X,3))

                            If lnAT2 > 0 Then
                                lcStr   = Stuff(lcStr, lnAT1, lnAT2-lnAT1+1, Replicate('X',lnAT2-lnAT1+1))
                            Else
                                ln_AT_Cmt   = At( '&'+'&', lcStr)

                                If ln_AT_Cmt = 0 Or ln_AT_Cmt < lnAT1
*-- No tiene comentario '&&' real, o sí lo tiene y además contiene un delimitador de cadena como parte del comentario
                                    Exit
                                Else
                                    Error 'Closing string delimiter <' + laSeparador(m.X,2) + '> not found: ' + tcLine
                                Endif
                            Endif
                        Endif

*-- Verifico si el carácter es un separador de cadenas: '"[
                        X   = At( Substr(lcStr, m.I, 1), lcSeparadoresIzq)

                        If m.X > 0 Then
                            lnAT1   = At(laSeparador(m.X,1), lcStr)
                        Endif
                    Endfor
                Endif

                ln_AT_Cmt   = At( '&'+'&', lcStr)
            Endif && tlDeepCommentAnalysis

            If ln_AT_Cmt > 0
                tcComment   = Ltrim( Substr( tcLine, ln_AT_Cmt + 2 ) )
                tcLine      = Rtrim( Left( tcLine, ln_AT_Cmt - 1 ), 0, Chr(9), ' ' )    && Quito TABS y espacios
            Endif

        Endif

        Return (ln_AT_Cmt > 0)
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taArray                   (@?    OUT) Array de conexiones
* tnArray_Count             (@?    OUT) Cantidad de conexiones
*---------------------------------------------------------------------------------------------------
    Endproc
Enddefine



Define Class CL_CLASSLIB As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="add_ole" display="add_OLE"/>] ;
        + [<memberdata name="add_class" display="add_Class"/>] ;
        + [<memberdata name="existeobjetoole" display="existeObjetoOLE"/>] ;
        + [<memberdata name="_clases" display="_Clases"/>] ;
        + [<memberdata name="_clases_count" display="_Clases_Count"/>] ;
        + [<memberdata name="_externalclasses" display="_ExternalClasses"/>] ;
        + [<memberdata name="_externalclasses_count" display="_ExternalClasses_Count"/>] ;
        + [<memberdata name="_includefile" display="_IncludeFile"/>] ;
        + [<memberdata name="_comment" display="_Comment"/>] ;
        + [<memberdata name="_ole_objs" display="_Ole_Objs"/>] ;
        + [<memberdata name="_ole_objs" display="_Ole_Objs"/>] ;
        + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
        + [<memberdata name="_version" display="_Version"/>] ;
        + [<memberdata name="_cpid" display="_CPID"/>] ;
        + [</VFPData>]


    Dimension _Ole_Objs[1], _Clases[1], _ExternalClasses(1,2)
    _Version                = 0
    _SourceFile             = ''
*LScheffler 20.08.2023
*issue #96, [KestasL] keep CodePage relavant information for binary sources
    _cpid                   = Cpcurrent()
    _ExternalClasses_Count  = 0
    _Ole_Obj_count          = 0
    _Clases_Count           = 0
    _includeFile            = ''
    _Comment                = ''



    Procedure add_OLE
        Lparameters toOle

        #If .F.
            Local toOle As CL_OLE Of 'FOXBIN2PRG.PRG'
        #Endif

        With This As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
            ._Ole_Obj_count = ._Ole_Obj_count + 1
            Dimension ._Ole_Objs( ._Ole_Obj_count )
            ._Ole_Objs( ._Ole_Obj_count )   = toOle
        Endwith && THIS
    Endproc



    Procedure add_Class
        Lparameters toClase

        #If .F.
            Local toClase As CL_CLASE Of 'cl_clase.prg'
        #Endif

        With This As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
            ._Clases_Count  = ._Clases_Count + 1
            Dimension ._Clases( ._Clases_Count )
            ._Clases( ._Clases_Count )  = toClase
        Endwith && THIS
    Endproc



    Procedure existeObjetoOLE
*-- Ubico el objeto ole por su nombre (parent+objname), que no se repite.
        Lparameters tcNombre, X
        Local llExiste

        With This As CL_CLASSLIB Of 'FOXBIN2PRG.PRG'
            For X = 1 To ._Ole_Obj_count
                If Lower(._Ole_Objs(m.X)._Nombre) == Lower(tcNombre)
                    llExiste = .T.
                    Exit
                Endif
            Endfor
        Endwith && THIS

        Return llExiste
    Endproc


Enddefine



Define Class CL_OLE As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_OLE Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_checksum" display="_CheckSum"/>] ;
        + [<memberdata name="_nombre" display="_Nombre"/>] ;
        + [<memberdata name="_objname" display="_ObjName"/>] ;
        + [<memberdata name="_parent" display="_Parent"/>] ;
        + [<memberdata name="_value" display="_Value"/>] ;
        + [</VFPData>]

    _Nombre     = ''
    _Parent     = ''
    _ObjName    = ''
    _CheckSum   = ''
    _Value      = ''
Enddefine



Define Class CL_PROCEDURE As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_PROCEDURE Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="add_line" display="add_Line"/>] ;
        + [<memberdata name="_comentario" display="_Comentario"/>] ;
        + [<memberdata name="_inicio" display="_Inicio"/>] ;
        + [<memberdata name="_nombre" display="_Nombre"/>] ;
        + [<memberdata name="_procline_count" display="_ProcLine_Count"/>] ;
        + [<memberdata name="_proclines" display="_ProcLines"/>] ;
        + [<memberdata name="_proctype" display="_ProcType"/>] ;
        + [</VFPData>]

    Dimension _ProcLines[1]
    _Nombre         = ''
    _ProcType       = ''
    _Comentario     = ''
    _ProcLine_Count = 0
    _Inicio         = 0



    Procedure add_Line
        Lparameters tcLine As String

        With This As CL_CLASE Of 'cl_clase.prg'
            ._ProcLine_Count    = ._ProcLine_Count + 1
            Dimension ._ProcLines( ._ProcLine_Count )
            ._ProcLines( ._ProcLine_Count ) = tcLine
        Endwith && THIS
    Endproc


Enddefine



Define Class CL_OBJETO As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_OBJETO Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="add_procedure" display="add_Procedure"/>] ;
        + [<memberdata name="add_property" display="add_Property"/>] ;
        + [<memberdata name="c_texterr" display="c_TextErr"/>] ;
        + [<memberdata name="_aprocnames" display="_aProcNames"/>] ;
        + [<memberdata name="_baseclass" display="_BaseClass"/>] ;
        + [<memberdata name="_class" display="_Class"/>] ;
        + [<memberdata name="_classlib" display="_ClassLib"/>] ;
        + [<memberdata name="_nombre" display="_Nombre"/>] ;
        + [<memberdata name="_objname" display="_ObjName"/>] ;
        + [<memberdata name="_ole" display="_Ole"/>] ;
        + [<memberdata name="_ole2" display="_Ole2"/>] ;
        + [<memberdata name="_parent" display="_Parent"/>] ;
        + [<memberdata name="_writeorder" display="_WriteOrder"/>] ;
        + [<memberdata name="_procedures" display="_Procedures"/>] ;
        + [<memberdata name="_procedure_count" display="_Procedure_Count"/>] ;
        + [<memberdata name="_props" display="_Props"/>] ;
        + [<memberdata name="_prop_count" display="_Prop_Count"/>] ;
        + [<memberdata name="_timestamp" display="_TimeStamp"/>] ;
        + [<memberdata name="_uniqueid" display="_UniqueID"/>] ;
        + [<memberdata name="_user" display="_User"/>] ;
        + [<memberdata name="_zorder" display="_ZOrder"/>] ;
        + [</VFPData>]

    Dimension _Props[1,1], _Procedures[1], _aProcNames[1]
    c_TextErr           = ''
    _Nombre             = ''
    _ObjName            = ''
    _Parent             = ''
    _Class              = ''
    _ClassLib           = ''
    _BaseClass          = ''
    _UniqueID           = ''
    _TimeStamp          = 0
    _Ole                = ''
    _Ole2               = ''
    _Prop_Count         = 0
    _Procedure_Count    = 0
    _User               = ''
    _WriteOrder         = 0
    _ZOrder             = 0



    Procedure add_Procedure
        Lparameters toProcedure

        #If .F.
            Local toProcedure As CL_PROCEDURE Of 'FOXBIN2PRG.PRG'
        #Endif

        With This As CL_OBJETO Of 'FOXBIN2PRG.PRG'
            If '.' $ ._Nombre
                toProcedure._Nombre = Substr( toProcedure._Nombre, At( '.', toProcedure._Nombre, Occurs( '.', ._Nombre) ) + 1 )
            Endif

*-- Verificación de Procedure repetido
            If ._Procedure_Count > 0 And Ascan( ._aProcNames, toProcedure._Nombre, 1, 0, 0, 1+2+4 ) > 0 Then
                .writeErrorLog( '* Duplicated Method "' + toProcedure._Nombre + '" of class.object "' ;
                    + ._Nombre + '" @line ' + Transform(toProcedure._Inicio) )
            Endif

            ._Procedure_Count   = ._Procedure_Count + 1
            Dimension ._Procedures( ._Procedure_Count )
            Dimension ._aProcNames( ._Procedure_Count )
            ._Procedures( ._Procedure_Count )   = toProcedure
            ._aProcNames( ._Procedure_Count )   = toProcedure._Nombre
        Endwith && THIS
    Endproc



    Procedure add_Property
        Lparameters tcProperty As String, tcValue As String

        With This As CL_OBJETO Of 'FOXBIN2PRG.PRG'
            ._Prop_Count    = ._Prop_Count + 1
            Dimension ._Props( ._Prop_Count, 2 )
            ._Props( ._Prop_Count, 1 )  = tcProperty
            ._Props( ._Prop_Count, 2 )  = tcValue
        Endwith && THIS
    Endproc


Enddefine



Define Class CL_REPORT As CL_COL_BASE
    #If .F.
        Local This As CL_REPORT Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_timestamp" display="_TimeStamp"/>] ;
        + [<memberdata name="_version" display="_Version"/>] ;
        + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
        + [<memberdata name="_cpid" display="_CPID"/>] ;
        + [</VFPData>]

*-- Report.Info
    _TimeStamp          = 0
    _Version            = ''
    _SourceFile         = ''
*LScheffler 20.08.2023
*issue #96, [KestasL] keep CodePage relavant information for binary sources
    _cpid =      Cpcurrent()


Enddefine



Define Class CL_PROJECT As CL_COL_BASE
    #If .F.
        Local This As CL_PROJECT Of 'FOXBIN2PRG.PRG'
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
        + [<memberdata name="getformatteddeviceinfotext" display="getFormattedDeviceInfoText"/>] ;
        + [<memberdata name="getfilesnotfound" display="getFilesNotFound"/>] ;
        + [<memberdata name="parsedeviceinfo" display="parseDeviceInfo"/>] ;
        + [<memberdata name="parsenullterminatedvalue" display="parseNullTerminatedValue"/>] ;
        + [<memberdata name="setparsedinfoline" display="setParsedInfoLine"/>] ;
        + [<memberdata name="setparsedprojinfoline" display="setParsedProjInfoLine"/>] ;
        + [<memberdata name="getrowdeviceinfo" display="getRowDeviceInfo"/>] ;
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
*LScheffler 20.08.2023
*issue #96, [KestasL] keep CodePage relavant information for binary sources
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
        This._ServerHead    = Createobject('CL_PROJ_SRV_HEAD')
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
        lcStr       = Substr( tcDevInfo, tnPos, tnLen )
        lnNullPos   = At(Chr(0), lcStr )
        If lnNullPos = 0
           lcValue = Chrtran( Left( lcStr, tnLen ), ['], ["] )
        Else
           lcValue = Chrtran( Left( lcStr, Min(tnLen, lnNullPos - 1 ) ), ['], ["] )
        Endif
        lcValue = This.encode_SpecialCodes_CR_LF(lcValue)
        Return lcValue
    Endproc



    Procedure parseDeviceInfo
        Lparameters tcDevInfo

        Try
                With This As CL_PROJECT Of "FOXBIN2PRG.PRG"
                    ._Author            = .parseNullTerminatedValue( @tcDevInfo, 1, 45 )
                    ._Company           = .parseNullTerminatedValue( @tcDevInfo, 47, 45 )
                    ._Address           = .parseNullTerminatedValue( @tcDevInfo, 93, 45 )
                    ._City              = .parseNullTerminatedValue( @tcDevInfo, 139, 20 )
                    ._State             = .parseNullTerminatedValue( @tcDevInfo, 160, 5 )
                    ._PostalCode        = .parseNullTerminatedValue( @tcDevInfo, 166, 10 )
                    ._Country           = .parseNullTerminatedValue( @tcDevInfo, 177, 45 )
*--
                    ._Comments          = .parseNullTerminatedValue( @tcDevInfo, 223, 254 )
                    ._CompanyName       = .parseNullTerminatedValue( @tcDevInfo, 478, 254 )
                    ._FileDescription   = .parseNullTerminatedValue( @tcDevInfo, 733, 254 )
                    ._LegalCopyright    = .parseNullTerminatedValue( @tcDevInfo, 988, 254 )
                    ._LegalTrademark    = .parseNullTerminatedValue( @tcDevInfo, 1243, 254 )
                    ._ProductName       = .parseNullTerminatedValue( @tcDevInfo, 1498, 254 )
                    ._MajorVer          = .parseNullTerminatedValue( @tcDevInfo, 1753, 4 )
                    ._MinorVer          = .parseNullTerminatedValue( @tcDevInfo, 1758, 4 )
                    ._Revision          = .parseNullTerminatedValue( @tcDevInfo, 1763, 4 )
                    ._LanguageID        = .parseNullTerminatedValue( @tcDevInfo, 1768, 19 )
*._AutoIncrement        = IIF( SUBSTR( tcDevInfo, 1788, 1 ) = CHR(1), '1', '0' )
                    ._AutoIncrement     = Transform(Asc(Substr(tcDevInfo, 1788, 1)))    && Proposed by Doug Hennig
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

    Endproc



    Procedure getRowDeviceInfo
        Lparameters tcDevInfo

        Try
                If Vartype(tcDevInfo) # 'C' Or Len(tcDevInfo) = 0
                    tcDevInfo   = Replicate( Chr(0), 1795 )
                Endif

                With This As CL_PROJECT Of "FOXBIN2PRG.PRG"
                    tcDevInfo   = Stuff( tcDevInfo, 1, Len(._Author), ._Author)
                    tcDevInfo   = Stuff( tcDevInfo, 47, Len(._Company), ._Company)
                    tcDevInfo   = Stuff( tcDevInfo, 93, Len(._Address), ._Address)
                    tcDevInfo   = Stuff( tcDevInfo, 139, Len(._City), ._City)
                    tcDevInfo   = Stuff( tcDevInfo, 160, Len(._State), ._State)
                    tcDevInfo   = Stuff( tcDevInfo, 166, Len(._PostalCode), ._PostalCode)
                    tcDevInfo   = Stuff( tcDevInfo, 177, Len(._Country), ._Country)
                    tcDevInfo   = Stuff( tcDevInfo, 223, Len(._Comments), ._Comments)
                    tcDevInfo   = Stuff( tcDevInfo, 478, Len(._CompanyName), ._CompanyName)
                    tcDevInfo   = Stuff( tcDevInfo, 733, Len(._FileDescription), ._FileDescription)
                    tcDevInfo   = Stuff( tcDevInfo, 988, Len(._LegalCopyright), ._LegalCopyright)
                    tcDevInfo   = Stuff( tcDevInfo, 1243, Len(._LegalTrademark), ._LegalTrademark)
                    tcDevInfo   = Stuff( tcDevInfo, 1498, Len(._ProductName), ._ProductName)
                    tcDevInfo   = Stuff( tcDevInfo, 1753, Len(._MajorVer), ._MajorVer)
                    tcDevInfo   = Stuff( tcDevInfo, 1758, Len(._MinorVer), ._MinorVer)
                    tcDevInfo   = Stuff( tcDevInfo, 1763, Len(._Revision), ._Revision)
                    tcDevInfo   = Stuff( tcDevInfo, 1768, Len(._LanguageID), ._LanguageID)
                    tcDevInfo   = Stuff( tcDevInfo, 1788, 1, Chr(Val(._AutoIncrement)))
                    tcDevInfo   = Stuff( tcDevInfo, 1792, 1, Chr(1))
                Endwith && THIS

            Catch To loEx
                lnCodError  = loEx.ErrorNo

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return tcDevInfo
    Endproc



    Procedure getFormattedDeviceInfoText
        Try
                Local lcText
                lcText      = ''

                With This As CL_PROJECT Of "FOXBIN2PRG.PRG"
                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<C_DEVINFO_I>>
                    _Author = "<<._Author>>"
                    _Company = "<<._Company>>"
                    _Address = "<<._Address>>"
                    _City = "<<._City>>"
                    _State = "<<._State>>"
                    _PostalCode = "<<._PostalCode>>"
                    _Country = "<<._Country>>"
                    *--
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
                Endwith && THIS

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

                With This As CL_PROJECT Of "FOXBIN2PRG.PRG"
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

                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return lnCount
    Endfunc


Enddefine




Define Class CL_DBC_COL_BASE As CL_COL_BASE
    #If .F.
        Local This As CL_DBC_COL_BASE Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="__objectid" display="__ObjectID"/>] ;
        + [<memberdata name="updatedbc" display="updateDBC"/>] ;
        + [<memberdata name="read_bindatatoproperties" display="read_BinDataToProperties"/>] ;
        + [</VFPData>]

    __ObjectID      = 0
    _Name           = ''


    Procedure updateDBC
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_OutputFile             (v! IN    ) Nombre del archivo de salida
* tnLastID                  (!@ IN    ) Último número de ID usado
* tnParentID                (v! IN    ) ID del objeto Padre
*---------------------------------------------------------------------------------------------------
        Lparameters tc_OutputFile, tnLastID, tnParentID
        Local loObject
        loObject    = .Null.

        For Each loObject In This FoxObject
            loObject.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
            loObject    = .Null.
        Endfor

        Return
    Endproc


    Procedure __ObjectID_ACCESS
        Return This.Parent.__ObjectID
    Endproc


Enddefine



Define Class CL_DBC_BASE As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="add_property" display="Add_Property"/>] ;
        + [<memberdata name="analyzecodeblock_comment" display="analyzeCodeBlock_Comment"/>] ;
        + [<memberdata name="_dbc" display="_DBC"/>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="_saved" display="_Saved"/>] ;
        + [<memberdata name="_totext" display="_ToText"/>] ;
        + [<memberdata name="__objectid" display="__ObjectID"/>] ;
        + [<memberdata name="dbgetprop" display="DBGETPROP"/>] ;
        + [<memberdata name="dbsetprop" display="DBSETPROP"/>] ;
        + [<memberdata name="getallpropertiesfromobjectname" display="getAllPropertiesFromObjectname"/>] ;
        + [<memberdata name="getbinpropertydatarecord" display="getBinPropertyDataRecord"/>] ;
        + [<memberdata name="getcodememo" display="getCodeMemo"/>] ;
        + [<memberdata name="getdbcpropertyidbyname" display="getDBCPropertyIDByName"/>] ;
        + [<memberdata name="getdbcpropertynamebyid" display="getDBCPropertyNameByID"/>] ;
        + [<memberdata name="getdbcpropertyvaluetypebypropertyid" display="getDBCPropertyValueTypeByPropertyID"/>] ;
        + [<memberdata name="getid" display="getID"/>] ;
        + [<memberdata name="getobjecttype" display="getObjectType"/>] ;
        + [<memberdata name="read_bindatatoproperties" display="read_BinDataToProperties"/>] ;
        + [<memberdata name="getbinmemofromproperties" display="getBinMemoFromProperties"/>] ;
        + [<memberdata name="getreferentialintegrityinfo" display="getReferentialIntegrityInfo"/>] ;
        + [<memberdata name="getusermemo" display="getUserMemo"/>] ;
        + [<memberdata name="read_dbc_header" display="read_DBC_Header"/>] ;
        + [<memberdata name="readnext_dbc_headerdatarecord" display="readNext_DBC_HeaderDataRecord"/>] ;
        + [<memberdata name="setnextid" display="setNextID"/>] ;
        + [<memberdata name="updatedbc" display="updateDBC"/>] ;
        + [</VFPData>]


    __ObjectID      = 0
    _DBC            = ''
    _Name           = ''
    _Saved          = .F.       && Indica si la información fue leida y guardada en las propiedades.
    _ToText         = ''        && Propiedades pasadas a Texto para guardar en archivo externo xx2


    Function add_Property
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcPropertyName            (v! IN    ) Nombre de la propiedad a agregar o modificar
* teValue                   (v! IN    ) Valor de la propiedad
*---------------------------------------------------------------------------------------------------
        Lparameters tcPropertyName, teValue

        Local lnPropertyID, tcDataType, leValue, llRetorno, lnDataLen

        With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
            lnPropertyID    = .getDBCPropertyIDByName( Substr(tcPropertyName,2) )

            If lnPropertyID = -1
                If Pcount()=1
                    llRetorno   = .AddProperty( tcPropertyName )
                Else
                    llRetorno   = .AddProperty( tcPropertyName, teValue )
                Endif
            Else
                tcDataType  = .getDBCPropertyValueTypeByPropertyID( lnPropertyID )
                lnDataLen   = Len(teValue)

                Do Case
                    Case tcDataType = 'L'
                        If lnDataLen = 0
                            leValue     = .F.
                        Else
                            leValue     = Cast( teValue As (tcDataType) )
                        Endif

                    Case Inlist(tcDataType, 'N', 'B')
                        If lnDataLen = 0
                            leValue     = 0
                        Else
                            leValue     = Cast( teValue As (tcDataType) (lnDataLen) )
                        Endif

                    Otherwise   && Asumo 'C'
                        If lnDataLen = 0
                            leValue     = ''
                        Else
                            leValue     = teValue
                        Endif

                Endcase

                llRetorno   = .AddProperty( tcPropertyName, leValue )
            Endif
        Endwith && THIS

        Return llRetorno
    Endfunc


    Procedure analyzeCodeBlock_Comment
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        If Left(tcLine, Len('<Comment>')) == '<Comment>'
            Local lcValue
            llBloqueEncontrado  = .T.
            lcValue = Strextract( taCodeLines(m.I), '<Comment>', '</Comment>', 1, 2 )

            With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                If Not '</Comment>' $ tcLine Then
                    For I = m.I + 1 To tnCodeLines
                        .set_Line( @tcLine, @taCodeLines, m.I )

                        Do Case
                            Case '</Comment>' $ tcLine  && Fin
                                lcValue = lcValue + CR_LF + Left( taCodeLines(m.I), At( '</Comment>', taCodeLines(m.I) ) - 1 )
                                Exit

                            Otherwise   && Línea de Stored Procedure
                                lcValue = lcValue + CR_LF + taCodeLines(m.I)
                        Endcase
                    Endfor
                Endif

                .AddProperty( '_Comment', lcValue )
            Endwith && THIS
        Endif
    Endproc


    Procedure getAllPropertiesFromObjectname
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcName                    (v! IN    ) Nombre del objeto
* tcType                    (v! IN    ) Tipo de objeto (Table, Index, Field, View, Relation)
* taProperties              (!@    OUT) Array con las propiedades encontradas y sus valores
* tnProperty_Count          (!@    OUT) Cantidad de propiedades encontradas
*---------------------------------------------------------------------------------------------------
        Lparameters tcName, tcType, taProperties, tnProperty_Count

        External Array taProperties && STRUCTURE: PropName,RecordLen,DataIDLen,DataID,DataType,Data

        Try
                Local lcValue, leValue, lnSelect, laProperty(1,1), lnRecordLen, lcBinRecord, lnPropertyID ;
                    , lnLastPos, lnLenCCode, lcDataType, lcPropName, lcDBF, lnLenData, lnLenHeader

                With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                    tnProperty_Count    = 0
                    lnSelect    = Select()
                    leValue     = ''
                    tcName      = Proper(Rtrim(tcName))
                    tcType      = Proper(Rtrim(tcType))
                    tcProperty  = Proper(Rtrim(tcProperty))
                    lcDBF       = Dbf()

                    Select 0
                    Use (lcDBF) Shared Again Noupdate Alias C_TABLABIN2

                    If Inlist( tcType, 'Index', 'Field' )
                        Select TB.Property From C_TABLABIN2 TB ;
                            INNER Join C_TABLABIN2 TB2 On Str(TB.ParentId)+TB.ObjectType+Lower(TB.ObjectName) = Str(TB2.ObjectID)+Padr(tcType,10)+Padr(Lower(Justext(tcName)),128) ;
                            AND TB2.ObjectName = Padr(Lower(Juststem(tcName)),128) ;
                            INTO Array laProperty

                    Else
                        Select TB.Property From C_TABLABIN2 TB ;
                            INNER Join C_TABLABIN2 TB2 On Str(TB.ParentId)+TB.ObjectType+Lower(TB.ObjectName) = Str(TB2.ObjectID)+Padr(tcType,10)+Padr(Lower(tcName),128) ;
                            INTO Array laProperty

                    Endif

                    If _Tally > 0
                        If Empty(laProperty(1,1))
                            Exit
                        Endif

                        lnLastPos       = 1

                        Do While lnLastPos < Len(laProperty(1,1))
                            tnProperty_Count    = tnProperty_Count + 1
                            Dimension taProperties( tnProperty_Count,6 )

                            lnRecordLen     = CToBin( Substr(laProperty(1,1), lnLastPos, 4), "4RS" )
                            lcBinRecord     = Substr(laProperty(1,1), lnLastPos, lnRecordLen)
                            lnLenCCode      = CToBin( Substr(lcBinRecord, 4+1, 2), "2RS" )
                            lnPropertyID    = Asc( Substr(lcBinRecord, 4+2+1, lnLenCCode) )
                            lcPropName      = .getDBCPropertyNameByID( lnPropertyID )
                            lcDataType      = .getDBCPropertyValueTypeByPropertyID( lnPropertyID )
                            lnLenHeader     = 4 + 2 + lnLenCCode
                            lcValue         = Substr(lcBinRecord, lnLenHeader + 1)

                            Do Case
                                Case lcDataType = 'B'
                                    If lnLenHeader = lnRecordLen
                                        leValue     = 0
                                    Else
                                        leValue     = Asc( lcValue )
                                    Endif

                                Case lcDataType = 'L'
                                    If lnLenHeader = lnRecordLen
                                        leValue     = .F.
                                    Else
                                        leValue     = ( CToBin( lcValue, "1S" ) = 1 )
                                    Endif

                                Case lcDataType = 'N'
                                    If lnLenHeader = lnRecordLen
                                        leValue     = 0
                                    Else
                                        leValue     = CToBin( lcValue, "4S" )
                                    Endif

                                Otherwise && Asume 'C'
                                    If lnLenHeader = lnRecordLen
                                        leValue     = ''
                                    Else
                                        leValue     = Left( lcValue, At( Chr(0), lcValue ) - 1 )
                                    Endif
                            Endcase

                            taProperties( tnProperty_Count,1 )  = lcPropName
                            taProperties( tnProperty_Count,2 )  = lnRecordLen
                            taProperties( tnProperty_Count,3 )  = lnLenCCode
                            taProperties( tnProperty_Count,4 )  = lnPropertyID
                            taProperties( tnProperty_Count,5 )  = lcDataType
                            taProperties( tnProperty_Count,6 )  = leValue

                            lnLastPos   = lnLastPos + lnRecordLen
                        Enddo
                    Else
                        Error 1562, (tcName)
                    Endif
                Endwith && THIS


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("C_TABLABIN2"))
                Select (lnSelect)
        Endtry

        Return leValue
    Endproc


    Procedure getDBCPropertyIDByName
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcPropertyName            (v! IN    ) Nombre de la propiedad
* tlRethrowError            (v? IN    ) Indica si se debe relanzar el error o solo devolver -1
*---------------------------------------------------------------------------------------------------
        Lparameters tcPropertyName, tlRethrowError
        Local lnPropertyID
        tcPropertyName  = Lower(Rtrim(tcPropertyName))

        Do Case
            Case tcPropertyName == 'null'
                lnPropertyID    = 0
            Case tcPropertyName == 'path'
                lnPropertyID    = 1
            Case tcPropertyName == 'class'
                lnPropertyID    = 2
            Case tcPropertyName == 'comment'
                lnPropertyID    = 7
            Case tcPropertyName == 'ruleexpression'
                lnPropertyID    = 9
            Case tcPropertyName == 'ruletext'
                lnPropertyID    = 10
            Case tcPropertyName == 'defaultvalue'
                lnPropertyID    = 11
            Case tcPropertyName == 'parameterlist'
                lnPropertyID    = 12
            Case tcPropertyName == 'childtag'
                lnPropertyID    = 13
            Case tcPropertyName == 'inserttrigger'
                lnPropertyID    = 14
            Case tcPropertyName == 'updatetrigger'
                lnPropertyID    = 15
            Case tcPropertyName == 'deletetrigger'
                lnPropertyID    = 16
            Case tcPropertyName == 'isunique'
                lnPropertyID    = 17
            Case tcPropertyName == 'parenttable'
                lnPropertyID    = 18
            Case tcPropertyName == 'parenttag'
                lnPropertyID    = 19
            Case tcPropertyName == 'primarykey'
                lnPropertyID    = 20
            Case tcPropertyName == 'version'
                lnPropertyID    = 24
            Case tcPropertyName == 'batchupdatecount'
                lnPropertyID    = 28
            Case tcPropertyName == 'datasource'
                lnPropertyID    = 29
            Case tcPropertyName == 'connectname'
                lnPropertyID    = 32
            Case tcPropertyName == 'updatename'
                lnPropertyID    = 35
            Case tcPropertyName == 'fetchmemo'
                lnPropertyID    = 36
            Case tcPropertyName == 'fetchsize'
                lnPropertyID    = 37
            Case tcPropertyName == 'keyfield'
                lnPropertyID    = 38
            Case tcPropertyName == 'maxrecords'
                lnPropertyID    = 39
            Case tcPropertyName == 'shareconnection'
                lnPropertyID    = 40
            Case tcPropertyName == 'sourcetype'
                lnPropertyID    = 41
            Case tcPropertyName == 'sql'
                lnPropertyID    = 42
            Case tcPropertyName == 'tables'
                lnPropertyID    = 43
            Case tcPropertyName == 'sendupdates'
                lnPropertyID    = 44
            Case tcPropertyName == 'updatablefield' Or tcPropertyName == 'updatable'
                lnPropertyID    = 45
            Case tcPropertyName == 'updatetype'
                lnPropertyID    = 46
            Case tcPropertyName == 'usememosize'
                lnPropertyID    = 47
            Case tcPropertyName == 'wheretype'
                lnPropertyID    = 48
            Case tcPropertyName == 'displayclass'   && Undocumented
                lnPropertyID    = 50
            Case tcPropertyName == 'displayclasslibrary'    && Undocumented
                lnPropertyID    = 51
            Case tcPropertyName == 'inputmask'  && Undocumented
                lnPropertyID    = 54
            Case tcPropertyName == 'format' && Undocumented
                lnPropertyID    = 55
            Case tcPropertyName == 'caption'
                lnPropertyID    = 56
            Case tcPropertyName == 'asynchronous'
                lnPropertyID    = 64
            Case tcPropertyName == 'batchmode'
                lnPropertyID    = 65
            Case tcPropertyName == 'connectstring'
                lnPropertyID    = 66
            Case tcPropertyName == 'connecttimeout'
                lnPropertyID    = 67
            Case tcPropertyName == 'displogin'
                lnPropertyID    = 68
            Case tcPropertyName == 'dispwarnings'
                lnPropertyID    = 69
            Case tcPropertyName == 'idletimeout'
                lnPropertyID    = 70
            Case tcPropertyName == 'querytimeout'
                lnPropertyID    = 71
            Case tcPropertyName == 'password'
                lnPropertyID    = 72
            Case tcPropertyName == 'transactions'
                lnPropertyID    = 73
            Case tcPropertyName == 'userid'
                lnPropertyID    = 74
            Case tcPropertyName == 'waittime'
                lnPropertyID    = 75
            Case tcPropertyName == 'timestamp'
                lnPropertyID    = 76
            Case tcPropertyName == 'datatype'
                lnPropertyID    = 77
            Case tcPropertyName == 'packetsize' && Undocumented
                lnPropertyID    = 78
            Case tcPropertyName == 'database'   && Undocumented
                lnPropertyID    = 79
            Case tcPropertyName == 'prepared'   && Undocumented
                lnPropertyID    = 80
            Case tcPropertyName == 'comparememo'    && Undocumented
                lnPropertyID    = 81
            Case tcPropertyName == 'fetchasneeded'  && Undocumented
                lnPropertyID    = 82
            Case tcPropertyName == 'offline'    && Undocumented
                lnPropertyID    = 83
            Case tcPropertyName == 'recordcount'    && Undocumented
                lnPropertyID    = 84
            Case tcPropertyName == 'undocumented_view_prop_85'  && Undocumented
                lnPropertyID    = 85
            Case tcPropertyName == 'dbcevents'  && Undocumented
                lnPropertyID    = 86
            Case tcPropertyName == 'dbceventfilename'   && Undocumented
                lnPropertyID    = 87
            Case tcPropertyName == 'allowsimultaneousfetch' && Undocumented
                lnPropertyID    = 88
            Case tcPropertyName == 'disconnectrollback' && Undocumented
                lnPropertyID    = 89
            Otherwise
                If tlRethrowError
                    Error 1559, (tcPropertyName)
                Else
                    lnPropertyID    = -1
                Endif
        Endcase

        Return lnPropertyID
    Endproc


    Procedure getDBCPropertyNameByID
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcPropertyID              (v! IN    ) Nombre de la propiedad
* tlRethrowError            (v? IN    ) Indica si se debe relanzar el error o solo devolver -1
*---------------------------------------------------------------------------------------------------
        Lparameters tnPropertyID, tlRethrowError
        Local lcPropertyName

        Do Case
            Case tnPropertyID   = 0
                lcPropertyName = 'null'
            Case tnPropertyID   = 1
                lcPropertyName = 'path'
            Case tnPropertyID   = 2
                lcPropertyName = 'class'
            Case tnPropertyID   = 7
                lcPropertyName = 'comment'
            Case tnPropertyID   = 9
                lcPropertyName = 'ruleexpression'
            Case tnPropertyID   = 10
                lcPropertyName = 'ruletext'
            Case tnPropertyID   = 11
                lcPropertyName = 'defaultvalue'
            Case tnPropertyID   = 12
                lcPropertyName = 'parameterlist'
            Case tnPropertyID   = 13
                lcPropertyName = 'childtag'
            Case tnPropertyID   = 14
                lcPropertyName = 'inserttrigger'
            Case tnPropertyID   = 15
                lcPropertyName = 'updatetrigger'
            Case tnPropertyID   = 16
                lcPropertyName = 'deletetrigger'
            Case tnPropertyID   = 17
                lcPropertyName = 'isunique'
            Case tnPropertyID   = 18
                lcPropertyName = 'parenttable'
            Case tnPropertyID   = 19
                lcPropertyName = 'parenttag'
            Case tnPropertyID   = 20
                lcPropertyName = 'primarykey'
            Case tnPropertyID   = 24
                lcPropertyName = 'version'
            Case tnPropertyID   = 28
                lcPropertyName = 'batchupdatecount'
            Case tnPropertyID   = 29
                lcPropertyName = 'datasource'
            Case tnPropertyID   = 32
                lcPropertyName = 'connectname'
            Case tnPropertyID   = 35
                lcPropertyName = 'updatename'
            Case tnPropertyID   = 36
                lcPropertyName = 'fetchmemo'
            Case tnPropertyID   = 37
                lcPropertyName = 'fetchsize'
            Case tnPropertyID   = 38
                lcPropertyName = 'keyfield'
            Case tnPropertyID   = 39
                lcPropertyName = 'maxrecords'
            Case tnPropertyID   = 40
                lcPropertyName = 'shareconnection'
            Case tnPropertyID   = 41
                lcPropertyName = 'sourcetype'
            Case tnPropertyID   = 42
                lcPropertyName = 'sql'
            Case tnPropertyID   = 43
                lcPropertyName = 'tables'
            Case tnPropertyID   = 44
                lcPropertyName = 'sendupdates'
            Case tnPropertyID   = 45
                lcPropertyName = 'updatablefield'
            Case tnPropertyID   = 46
                lcPropertyName = 'updatetype'
            Case tnPropertyID   = 47
                lcPropertyName = 'usememosize'
            Case tnPropertyID   = 48
                lcPropertyName = 'wheretype'
            Case tnPropertyID   = 50
                lcPropertyName = 'displayclass' && Undocumented
            Case tnPropertyID   = 51
                lcPropertyName = 'displayclasslibrary'  && Undocumented
            Case tnPropertyID   = 54
                lcPropertyName = 'inputmask'    && Undocumented
            Case tnPropertyID   = 55
                lcPropertyName = 'format'   && Undocumented
            Case tnPropertyID   = 56
                lcPropertyName = 'caption'
            Case tnPropertyID   = 64
                lcPropertyName = 'asynchronous'
            Case tnPropertyID   = 65
                lcPropertyName = 'batchmode'
            Case tnPropertyID   = 66
                lcPropertyName = 'connectstring'
            Case tnPropertyID   = 67
                lcPropertyName = 'connecttimeout'
            Case tnPropertyID   = 68
                lcPropertyName = 'displogin'
            Case tnPropertyID   = 69
                lcPropertyName = 'dispwarnings'
            Case tnPropertyID   = 70
                lcPropertyName = 'idletimeout'
            Case tnPropertyID   = 71
                lcPropertyName = 'querytimeout'
            Case tnPropertyID   = 72
                lcPropertyName = 'password'
            Case tnPropertyID   = 73
                lcPropertyName = 'transactions'
            Case tnPropertyID   = 74
                lcPropertyName = 'userid'
            Case tnPropertyID   = 75
                lcPropertyName = 'waittime'
            Case tnPropertyID   = 76
                lcPropertyName = 'timestamp'
            Case tnPropertyID   = 77
                lcPropertyName = 'datatype'
            Case tnPropertyID   = 78
                lcPropertyName = 'packetsize'   && Undocumented
            Case tnPropertyID   = 79
                lcPropertyName = 'database' && Undocumented
            Case tnPropertyID   = 80
                lcPropertyName = 'prepared' && Undocumented
            Case tnPropertyID   = 81
                lcPropertyName = 'comparememo'  && Undocumented
            Case tnPropertyID   = 82
                lcPropertyName = 'fetchasneeded'    && Undocumented
            Case tnPropertyID   = 83
                lcPropertyName = 'offline'  && Undocumented
            Case tnPropertyID   = 84
                lcPropertyName = 'recordcount'  && Undocumented
            Case tnPropertyID   = 85
                lcPropertyName = 'undocumented_view_prop_85'    && Undocumented
            Case tnPropertyID   = 86
                lcPropertyName = 'dbcevents'    && Undocumented
            Case tnPropertyID   = 87
                lcPropertyName = 'dbceventfilename' && Undocumented
            Case tnPropertyID   = 88
                lcPropertyName = 'allowsimultaneousfetch'   && Undocumented
            Case tnPropertyID   = 89
                lcPropertyName = 'disconnectrollback'   && Undocumented
            Otherwise
                If tlRethrowError
                    Error 1559, (Transform(tnPropertyID))
                Else
                    lcPropertyName  = ''
                Endif
        Endcase

        Return lcPropertyName
    Endproc


    Procedure getDBCPropertyValueTypeByPropertyID
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tnPropertyID              (v! IN    ) ID de la Propiedad
*---------------------------------------------------------------------------------------------------
        Lparameters tnPropertyID
        Local lcValueType ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

        loLang          = _Screen.o_FoxBin2Prg_Lang
        lcValueType = ''

        Do Case
            Case Inlist(tnPropertyID,2,41,46,48,68,73)
                lcValueType = 'B'   && Byte

            Case Inlist(tnPropertyID,17,36,38,40,44,45,64,65,69,80,81,82,83,86,88,89)
                lcValueType = 'L'

            Case Inlist(tnPropertyID,24,28,37,39,47,67,70,71,75,76,78,84,85)
                lcValueType = 'N'

            Case Inlist(tnPropertyID,0,1,7,9,10,11,12,13,14,15,16,18,19,20,29,30,32,35) ;
                    OR Inlist(tnPropertyID,42,43,49,50,51,54,55,56,66,67,72,74,77,79,87)
                lcValueType = 'C'

            Otherwise
*ERROR 'Propiedad [' + TRANSFORM(tnPropertyID) + '] no reconocida.'
                Error (Textmerge(loLang.C_PROPERTY_NAME_NOT_RECOGNIZED_LOC))
        Endcase

        Return lcValueType
    Endproc


    Procedure DBGetProp
*---------------------------------------------------------------------------------------------------
* Emula el comando DBGETPROP interno de VFP
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcName                    (v! IN    ) Nombre del objeto
* tcType                    (v! IN    ) Tipo de objeto (Table, Index, Field, View, Relation)
* tcProperty                (v! IN    ) Nombre de la propiedad
*---------------------------------------------------------------------------------------------------
        Lparameters tcName, tcType, tcProperty

        Try
                Local lcValue, lxValue, lnSelect, lcInfo, lnRecno, lnRecordLen, lcBinRecord, lnPropertyID ;
                    , lnLastPos, lnLenCCode, lcDataType, lnSerchedDataCC, lcDBF, lnLenData, lnLenHeader ;
                    , lcInfo, lnRecno ;
                    , loEx As Exception

                With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                    lnSelect    = Select()
                    lxValue     = ''

                    If .DBPROP_INFO_RECNO(tcName, tcType, tcProperty, @lcInfo, @lnRecno) > 0
                        If Empty(lcInfo)
                            Exit
                        Endif

                        If .DBGETPROP_POS_AND_LEN(tcProperty, @lcInfo, @lnLastPos, @lnRecordLen ;
                                , @lcBinRecord, @lnLenCCode, @lnPropertyID)

                            lcDataType      = .getDBCPropertyValueTypeByPropertyID( lnPropertyID )
                            lnLenHeader     = 4 + 2 + lnLenCCode
                            lcValue         = Substr(lcBinRecord, lnLenHeader + 1)

                            Do Case
                                Case lcDataType = 'B'
                                    If lnLenHeader = lnRecordLen
                                        lxValue     = 0
                                    Else
                                        lxValue     = Asc( lcValue )
                                    Endif

                                Case lcDataType = 'L'
                                    If lnLenHeader = lnRecordLen
                                        lxValue     = .F.
                                    Else
                                        lxValue     = ( CToBin( lcValue, "1S" ) = 1 )
                                    Endif

                                Case lcDataType = 'N'
                                    If lnLenHeader = lnRecordLen
                                        lxValue     = 0
                                    Else
                                        lxValue     = CToBin( lcValue, "4S" )
                                    Endif

                                Otherwise && Asume 'C'
                                    If lnLenHeader = lnRecordLen
                                        lxValue     = ''
                                    Else
                                        lxValue     = Left( lcValue, At( Chr(0), lcValue ) - 1 )
                                    Endif
                            Endcase

                        Endif

                    Else
                        Error 1562, (tcName)
                    Endif
                Endwith && THIS


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("C_TABLABIN2"))
                Select (lnSelect)
        Endtry

        Return lxValue
    Endproc


    Procedure DBSetProp
*---------------------------------------------------------------------------------------------------
* Emula el comando DBSETPROP interno de VFP
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcName                    (v! IN    ) Nombre del objeto
* tcType                    (v! IN    ) Tipo de objeto (Table, Index, Field, View, Relation)
* tcProperty                (v! IN    ) Nombre de la propiedad
* txPropertyValue           (v! IN    ) Valor de la propiedad
*---------------------------------------------------------------------------------------------------
        Lparameters tcName, tcType, tcProperty, txPropertyValue

        Try
                Local lnSelect, laProperty(1,1), lnRecordLen, lcBinRecord, lnPropertyID ;
                    , lnLastPos, lnLenCCode, lcDataType, lnSerchedDataCC, lnLenData, lnLenHeader ;
                    , lcInfo, lnRecno, llSet ;
                    , loEx As Exception

                With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                    lnSelect    = Select()
                    lcInfo      = ''

                    If .DBPROP_INFO_RECNO(tcName, tcType, tcProperty, @lcInfo, @lnRecno) > 0
                        If Empty(lcInfo)
                            Exit
                        Endif

                        If .DBGETPROP_POS_AND_LEN(tcProperty, @lcInfo, @lnLastPos, @lnRecordLen ;
                                , @lcBinRecord, @lnLenCCode, @lnPropertyID)

                            lcDataType      = .getDBCPropertyValueTypeByPropertyID( lnPropertyID )
                            lcBinRecord     = .getBinPropertyDataRecord( @txPropertyValue, lnPropertyID )

                            If Empty(lcInfo)
                                lcInfo  = lcBinRecord
                            Else
                                lcInfo  = Stuff(lcInfo, lnLastPos, lnRecordLen, lcBinRecord)
                            Endif

                            Goto Record (lnRecno)
                            Replace Property With lcInfo
                        Endif

                        llSet   = .T.

                    Else
                        Error 1562, (tcName)
                    Endif
                Endwith && THIS


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("C_TABLABIN2"))
                Select (lnSelect)
        Endtry

        Return llSet
    Endproc


    Hidden Procedure DBPROP_INFO_RECNO
*---------------------------------------------------------------------------------------------------
* Devuelve el campo property y el número de registro donde lo encontró
* para ser usado por DBGETPROP y DBSETPROP
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcName                    (v! IN    ) Nombre del objeto
* tcType                    (v! IN    ) Tipo de objeto (Table, Index, Field, View, Relation)
* tcProperty                (v! IN    ) Nombre de la propiedad
* tcInfo                    (@!    OUT) Información del campo memo "Property" que contiene el dato indicado
* tnRecno                   (@!    OUT) Número de registro del campo encontrado
*---------------------------------------------------------------------------------------------------
        Lparameters tcName, tcType, tcProperty, tcInfo, tnRecno

        Try
                Local laProperty(1,1), lcDBF, lnTally ;
                    , loEx As Exception

                With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                    tcType      = Proper(Rtrim(tcType))
                    tcName      = Iif(tcType = 'Database', 'Database', Proper(Rtrim(tcName)) )
                    tcProperty  = Proper(Rtrim(tcProperty))
                    lcDBF       = Iif(tcType = 'Database', Evl(._DBC, tcName), Dbf())
                    tcInfo      = ''
                    tnRecno     = 0
                    lnTally     = 0

                    Select 0
                    Use (lcDBF) Shared Again Alias C_TABLABIN2

                    If Inlist( tcType, 'Index', 'Field' )
                        Select TB.Property, Recno() From C_TABLABIN2 TB ;
                            INNER Join C_TABLABIN2 TB2 On Str(TB.ParentId)+TB.ObjectType+Lower(TB.ObjectName) = Str(TB2.ObjectID)+Padr(tcType,10)+Padr(Lower(Justext(tcName)),128) ;
                            AND TB2.ObjectName = Padr(Lower(Juststem(tcName)),128) ;
                            INTO Array laProperty

                    Else
                        Select TB.Property, Recno() From C_TABLABIN2 TB ;
                            INNER Join C_TABLABIN2 TB2 On Str(TB.ParentId)+TB.ObjectType+Lower(TB.ObjectName) = Str(TB2.ObjectID)+Padr(tcType,10)+Padr(Lower(tcName),128) ;
                            INTO Array laProperty

                    Endif

                    If _Tally > 0
                        lnTally = _Tally
                        tcInfo  = laProperty(1,1)
                        tnRecno = laProperty(1,2)
                    Endif
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return lnTally
    Endproc


    Hidden Procedure DBGETPROP_POS_AND_LEN
*---------------------------------------------------------------------------------------------------
* Devuelve la posición y longitud del dato asociado a la propiedad indicada
* para ser usado por DBGETPROP y DBSETPROP
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcProperty                (v! IN    ) Nombre de la propiedad
* tcInfo                    (@! IN    ) Información del campo memo "Property" que contiene el dato indicado
* tnLastPos                 (@!    OUT) Posición del campo Property donde se encontró el dato
* tnRecordLen               (@!    OUT) Longitud del registro del dato
* tcBinRecord               (@!    OUT) Registro de datos de la propiedad indicada
* tnLenCCode                (@!    OUT) Longitud del valor de la propiedad indicada
* tnPropertyID              (@!    OUT) ID de la propiedad indicada
*---------------------------------------------------------------------------------------------------
        Lparameters tcProperty, tcInfo, tnLastPos, tnRecordLen, tcBinRecord, tnLenCCode, tnPropertyID

        Try
                Local lnSerchedDataCC, llFound ;
                    , loEx As Exception

                With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                    tnLastPos       = 1
                    lnSerchedDataCC = .getDBCPropertyIDByName( tcProperty, .T. )

                    Do While tnLastPos < Len(tcInfo)
* Estructura de tcBinRecord
* ----------------------
* |RLen|LC|ID|Value    |
* ----------------------

                        tnRecordLen     = CToBin( Substr(tcInfo, tnLastPos, 4), "4RS" )
                        tcBinRecord     = Substr(tcInfo, tnLastPos, tnRecordLen)
                        tnLenCCode      = CToBin( Substr(tcBinRecord, 4+1, 2), "2RS" )
                        tnPropertyID    = Asc( Substr(tcBinRecord, 4+2+1, tnLenCCode) )

                        If tnPropertyID = lnSerchedDataCC
                            llFound = .T.
                            Exit
                        Endif

                        tnLastPos   = tnLastPos + tnRecordLen
                    Enddo
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return llFound
    Endproc


    Procedure getBinPropertyDataRecord
        Lparameters teData, tnPropertyID
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* teData                    (v! IN    ) Dato a codificar
* tnPropertyID              (v! IN    ) ID de la propiedad a la que pertenece
*---------------------------------------------------------------------------------------------------

        Try
                Local lcBinRecord, lnLen, lcDataType

* Estructura de tcBinRecord
* ----------------------
* |RLen|LC|ID|Value    |
* ----------------------

                lcBinRecord = ''
                lcDataType  = This.getDBCPropertyValueTypeByPropertyID( tnPropertyID )

                Do Case
                    Case lcDataType = 'B'
                        teData          = Chr(teData)
                        lnLen           = 4 + 2 + 1 + 1
                        lcBinRecord     = BinToC( lnLen, "4RS" ) + BinToC( 1, "2RS" ) + Chr(tnPropertyID) + teData

                    Case lcDataType = 'L'
                        teData          = BinToC( Iif(teData,1,0), "1S" )
                        lnLen           = 4 + 2 + 1 + 1
                        lcBinRecord     = BinToC( lnLen, "4RS" ) + BinToC( 1, "2RS" ) + Chr(tnPropertyID) + teData

                    Case lcDataType = 'N'
                        teData          = BinToC( teData, "4S" )
                        lnLen           = 4 + 2 + 1 + 4
                        lcBinRecord     = BinToC( lnLen, "4RS" ) + BinToC( 1, "2RS" ) + Chr(tnPropertyID) + teData

                    Otherwise   && Asume 'C'
                        If Empty(teData)
                            Exit
                        Endif
                        lnLen           = 4 + 2 + 1 + Len(teData) + 1
                        lcBinRecord     = BinToC( lnLen, "4RS" ) + BinToC( 1, "2RS" ) + Chr(tnPropertyID) + teData + Chr(0)

                Endcase


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return lcBinRecord
    Endproc


    Procedure getID
        Return This.__ObjectID
    Endproc


    Procedure getCodeMemo
        Return ''
    Endproc


    Procedure getUserMemo
        Return ''
    Endproc


    Procedure getBinMemoFromProperties
        Return ''
    Endproc


    Procedure getReferentialIntegrityInfo
        Return ''
    Endproc


    Procedure getObjectType
        Local lcType

        With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
            Do Case
                Case .Class == 'Cl_dbc'
                    lcType  = 'Database'

                Case .Class == 'Cl_dbc_connection'
                    lcType  = 'Connection'

                Case .Class == 'Cl_dbc_table'
                    lcType  = 'Table'

                Case .Class == 'Cl_dbc_view'
                    lcType  = 'View'

                Case .Class == 'Cl_dbc_index_db' Or .Class == 'Cl_dbc_index_vw'
                    lcType  = 'Index'

                Case .Class == 'Cl_dbc_relation'
                    lcType  = 'Relation'

                Case .Class == 'Cl_dbc_field_db' Or .Class == 'Cl_dbc_field_vw'
                    lcType  = 'Field'

                Otherwise
*ERROR 'Clase [' + .CLASS + '] desconocida'
                    Error (Textmerge(C_UNKNOWN_CLASS_NAME_LOC))

            Endcase
        Endwith && THIS

        Return lcType
    Endproc


    Procedure readNext_DBC_HeaderDataRecord
        Lparameters tcHeader, tnPos, tnLen, tnID, tcDataType, tcPropName, teData

        Local lnOffset, llRetorno

        Try
                With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                    tnPos       = Evl(tnPos,1)

                    If tnPos >= Len(tcHeader) Then
                        Exit
                    Endif

                    tnLen       = CToBin( Substr(tcHeader, tnPos, 4), '4RS' )
                    tnID        = Asc( Substr(tcHeader, tnPos + 4 + 2, 1) )
                    tcDataType  = .getDBCPropertyValueTypeByPropertyID(tnID)
                    lnOffset    = Iif(tcDataType = 'C', 1, 0)
                    tcPropName  = .getDBCPropertyNameByID(tnID, .T.)
                    teData      = Substr(tcHeader, tnPos + 4 + 2 + 1, tnLen - 4 - 2 - 1 - lnOffset)

                    Do Case
                        Case tcDataType = 'B'
                            teData          = Asc(teData)

                        Case tcDataType = 'L'
                            teData          = ( CToBin( teData, "1S" ) = 1 )

                        Case tcDataType = 'N'
                            teData          = CToBin( teData, "4S" )

                    Endcase

                    tnPos       = tnPos + tnLen
                    llRetorno   = .T.
                Endwith
        Endtry

        Return llRetorno
    Endproc


    Procedure read_DBC_Header
        Local lnLen, lnID, leData, lcHeader, lnPos, lcPropName, lcDataType, lnOffset

        Try
                With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                    Go Top In TABLABIN
                    lcHeader    = TABLABIN.Property
                    ._Name  = Upper( Justfname( Dbf("TABLABIN") ) )

                    Do While .readNext_DBC_HeaderDataRecord( @lcHeader, @lnPos, @lnLen, @lnID, @lcDataType, @lcPropName, @leData )
                        .AddProperty( '_' + lcPropName, leData )
                    Enddo

                Endwith
        Endtry
    Endproc


    Procedure setNextID
        Lparameters tnLastID
        tnLastID    = tnLastID + 1
        This.__ObjectID = tnLastID
    Endproc


    Procedure updateDBC
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_OutputFile             (v! IN    ) Nombre del archivo de salida
* tnLastID                  (!@ IN    ) Último número de ID usado
* tnParentID                (v! IN    ) ID del objeto Padre
*---------------------------------------------------------------------------------------------------
        Lparameters tc_OutputFile, tnLastID, tnParentID

        Try
                Local lcMemoWithProperties, lcCodeMemo, lcObjectType, lcRI_Info, lcUserMemo, lcID

                With This As CL_DBC_BASE Of 'FOXBIN2PRG.PRG'
                    .setNextID( @tnLastID )
                    lcMemoWithProperties    = .getBinMemoFromProperties()
                    lcCodeMemo              = .getCodeMemo()
                    lcObjectType            = .getObjectType()
                    lcRI_Info               = .getReferentialIntegrityInfo()
                    lcUserMemo              = .getUserMemo()
                    lcID                    = .getID()

                    Insert Into TABLABIN ;
                        ( ObjectID ;
                        , ParentId ;
                        , ObjectType ;
                        , ObjectName ;
                        , Property ;
                        , Code ;
                        , RIInfo ;
                        , User ) ;
                        VALUES ;
                        ( lcID ;
                        , tnParentID ;
                        , lcObjectType ;
                        , Iif(lcObjectType == 'View', ._Name, Lower(._Name)) ;
                        , lcMemoWithProperties ;
                        , lcCodeMemo ;
                        , lcRI_Info ;
                        , lcUserMemo )
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return
    Endproc


Enddefine



Define Class CL_DBC As CL_DBC_BASE
    #If .F.
        Local This As CL_DBC Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzecodeblock_sp" display="analyzeCodeBlock_SP"/>] ;
        + [<memberdata name="_comment" display="_Comment"/>] ;
        + [<memberdata name="_version" display="_Version"/>] ;
        + [<memberdata name="_dbcevents" display="_DBCEvents"/>] ;
        + [<memberdata name="_dbceventfilename" display="_DBCEventFilename"/>] ;
        + [<memberdata name="_connections" display="_Connections"/>] ;
        + [<memberdata name="_tables" display="_Tables"/>] ;
        + [<memberdata name="_views" display="_Views"/>] ;
        + [<memberdata name="_relations" display="_Relations"/>] ;
        + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
        + [<memberdata name="_cpid" display="_CPID"/>] ;
        + [<memberdata name="_storedprocedures" display="_StoredProcedures"/>] ;
        + [<memberdata name="_version" display="_Version"/>] ;
        + [<memberdata name="_externalclasses" display="_ExternalClasses"/>] ;
        + [<memberdata name="_externalclasses_count" display="_ExternalClasses_Count"/>] ;
        + [<memberdata name="_members" display="_Members"/>] ;
        + [<memberdata name="_members_count" display="_Members_Count"/>] ;
        + [<memberdata name="add_dbcmember" display="add_DBCMember"/>] ;
        + [</VFPData>]


*-- Modulo
    Dimension _ExternalClasses(1,2), _Members(1,2)
    _ExternalClasses_Count  = 0
    _Members_Count          = 0
    _Version                = 0
    _SourceFile             = ''
*LScheffler 20.08.2023
*issue #96, [KestasL] keep CodePage relavant information for binary sources
    _cpid =      Cpcurrent()


*-- Database Info
    _Name                   = ''
    _Comment                = ''
    _Version                = 0
    _DBCEvents              = .F.
    _DBCEventFilename       = ''
    _StoredProcedures       = ''


    Procedure Init
        DoDefault()
*--
        With This As CL_DBC Of 'FOXBIN2PRG.PRG'
            .AddObject("_Connections", "CL_DBC_CONNECTIONS")
            .AddObject("_Tables", "CL_DBC_TABLES")
            .AddObject("_Views", "CL_DBC_VIEWS")
        Endwith && THIS
    Endproc


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
*--------------------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toFoxBin2Prg

        External Array taCodeLines

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local loConnections As CL_DBC_CONNECTIONS Of 'FOXBIN2PRG.PRG' ;
                    , loConnection As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG' ;
                    , loTables As CL_DBC_TABLES Of 'FOXBIN2PRG.PRG' ;
                    , loTable As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG' ;
                    , loViews As CL_DBC_VIEWS Of 'FOXBIN2PRG.PRG' ;
                    , loView As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG' ;
                    , llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
                Store '' To lcPropName, lcValue
                Store .Null. To loConnections, loTables, loViews, loConnection, loTable, loView

                If Left(tcLine, Len(C_DATABASE_I)) == C_DATABASE_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_DATABASE_F $ tcLine  && Fin
                                    Exit

                                Case C_CONNECTIONS_I $ tcLine
                                    loConnections   = ._Connections
                                    loConnections.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                    loConnections.KeySort=2
                                    For Each loConnection In loConnections &&FOXOBJECT
                                        .add_DBCMember('connection.' + loConnection._Name)
                                    Endfor

                                Case C_TABLES_I $ tcLine
                                    loTables    = ._Tables
                                    loTables.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                    loTables.KeySort=2
                                    For Each loTable In loTables &&FOXOBJECT
                                        .add_DBCMember('table.' + loTable._Name)
                                    Endfor

                                Case C_VIEWS_I $ tcLine
                                    loViews = ._Views
                                    loViews.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                    loViews.KeySort=2
                                    For Each loView In loViews &&FOXOBJECT
                                        .add_DBCMember('view.' + loView._Name)
                                    Endfor

                                Case C_STORED_PROC_I $ tcLine
                                    .analyzeCodeBlock_SP( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                                    .add_DBCMember('database.storedproceduressource')

                                Case '<Comment>' $ tcLine
                                    .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Otherwise   && Otro valor
*-- Estructura a reconocer:
*   <tagname>ID<tagname>
                                    lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                                    lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                                    .add_Property( '_' + lcPropName, lcValue )
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', PropName=[' + Transform(lcPropName) + '], Value=[' + Transform(lcValue) + ']'
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loConnections, loTables, loViews, loConnection, loTable, loView
                Release loConnections, loTables, loViews, loConnection, loTable, loView
        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure analyzeCodeBlock_SP
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        If Left(tcLine, Len(C_STORED_PROC_I)) == C_STORED_PROC_I
            Local lcValue
            lcValue = ''

            With This As CL_DBC Of 'FOXBIN2PRG.PRG'
                For I = m.I + 1 To tnCodeLines
                    .set_Line( @tcLine, @taCodeLines, m.I )

                    Do Case
                        Case C_STORED_PROC_F $ tcLine   && Fin
                            Exit

                        Otherwise   && Línea de Stored Procedure
                            lcValue = lcValue + CR_LF + taCodeLines(m.I)
                    Endcase
                Endfor

                .AddProperty( '_StoredProcedures', Substr(lcValue,3) )
            Endwith && THIS
        Endif
    Endproc


    Procedure updateDBC
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_OutputFile             (v! IN    ) Nombre del archivo de salida
* tnLastID                  (!@ IN    ) Último número de ID usado
* tnParentID                (v! IN    ) ID del objeto Padre
*---------------------------------------------------------------------------------------------------
        Lparameters tc_OutputFile, tnLastID, tnParentID

        Try
                Local loTables As CL_DBC_TABLES Of 'FOXBIN2PRG.PRG' ;
                    , loConnections As CL_DBC_CONNECTIONS Of 'FOXBIN2PRG.PRG' ;
                    , loViews As CL_DBC_VIEWS Of 'FOXBIN2PRG.PRG'
                Local lcStoredProcedures
                Store .Null. To loTables, loConnections, loViews

                With This As CL_DBC Of 'FOXBIN2PRG.PRG'
                    loTables            = ._Tables
                    loConnections       = ._Connections
                    loViews             = ._Views
                    lcStoredProcedures  = ._StoredProcedures

                    Erase (tc_OutputFile)
                    Erase (Forceext(tc_OutputFile,'DCX'))
                    Erase (Forceext(tc_OutputFile,'DCT'))
                    Create Database (tc_OutputFile)

                    Close Databases
                    Open Database (tc_OutputFile) Shared
                    Use (tc_OutputFile) Shared Again Alias TABLABIN
                    tnLastID    = 5
                    .setNextID(0)
                    tnParentID  = .__ObjectID

                    lcMemoWithProperties    = .getBinMemoFromProperties()
                    Update TABLABIN ;
                        SET Property = lcMemoWithProperties ;
                        WHERE Str(ParentId) + ObjectType + Lower(ObjectName) = Str(1) + Padr('Database',10) + Padr(Lower('Database'),128)

                    If Not Empty(lcStoredProcedures)
                        Update TABLABIN ;
                            SET Code = lcStoredProcedures ;
                            WHERE Str(ParentId) + ObjectType + Lower(ObjectName) = Str(1) + Padr('Database',10) + Padr(Lower('StoredProceduresSource'),128)
                    Endif

                    loTables.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
                    loViews.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
                    loConnections.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
                Endwith && THIS


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Close Databases
                Use In (Select("TABLABIN"))
                Store .Null. To loTables, loConnections, loViews
                Release loTables, loConnections, loViews

        Endtry

        Return
    Endproc



    Procedure toText
        Lparameters toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, lcText, lcDBC, laCode(1,1), lcConnections, lcTables, lcViews, loEx As Exception ;
                    , loConnections As CL_DBC_CONNECTIONS Of 'FOXBIN2PRG.PRG' ;
                    , loTables As CL_DBC_TABLES Of 'FOXBIN2PRG.PRG' ;
                    , loViews As CL_DBC_VIEWS Of 'FOXBIN2PRG.PRG' ;
                    , loRelations As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'
                Store .Null. To loRelations, loViews, loTables, loTables

                With This As CL_DBC Of 'FOXBIN2PRG.PRG'
                    Store '' To lcText, lcConnections, lcTables, lcViews
                    lcDBC   = Juststem(Dbc())

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<>>
                    <DATABASE>
                    <<Chr(9)>><Name><<lcDBC>></Name>
                    <<Chr(9)>><Comment><<DBGETPROP(lcDBC,"DATABASE","Comment")>></Comment>
                    <<Chr(9)>><Version><<DBGETPROP(lcDBC,"DATABASE","Version")>></Version>
                    <<Chr(9)>><DBCEvents><<DBGETPROP(lcDBC,"DATABASE","DBCEvents")>></DBCEvents>
                    <<Chr(9)>><DBCEventFilename><<DBGETPROP(lcDBC,"DATABASE","DBCEventFilename")>></DBCEventFilename>
                    ENDTEXT

*-- Connections
                    loConnections   = ._Connections
                    lcConnections   = loConnections.toText( @toFoxBin2Prg )

*-- Tables
                    loTables        = ._Tables
                    lcTables        = loTables.toText( @toFoxBin2Prg )

*-- Views
                    loViews         = ._Views
                    lcViews         = loViews.toText( @toFoxBin2Prg )

                    Select Code ;
                        FROM TABLABIN ;
                        WHERE Str(ParentId) + ObjectType + Lower(ObjectName) = Str(1) + Padr('Database',10) + Padr(Lower('StoredProceduresSource'),128) ;
                        INTO Array laCode
                    TEXT TO ._StoredProcedures TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)>><<C_STORED_PROC_I>>
                    <<laCode(1,1)>>
                    <<Chr(9)>><<C_STORED_PROC_F>>
                    ENDTEXT

                    If Not toFoxBin2Prg.n_UseFilesPerDBC > 0 Then
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<lcConnections>>
                        <<lcTables>>
                        <<lcViews>>
                        <<>>
                        <<._StoredProcedures>>
                        ENDTEXT
                    Endif

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    </DATABASE>
                    ENDTEXT
                Endwith && THIS


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loRelations, loViews, loTables, loTables
                Release I, lcDBC, laCode, loConnections, loTables, loViews, loRelations

        Endtry

        Return lcText
    Endproc


    Procedure getBinMemoFromProperties
        Local lcBinData
        lcBinData   = ''

        With This As CL_DBC Of 'FOXBIN2PRG.PRG'
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Version, .getDBCPropertyIDByName('Version', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DBCEvents, .getDBCPropertyIDByName('DBCEvents', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DBCEventFilename, .getDBCPropertyIDByName('DBCEventFilename', .T.) )
        Endwith && THIS

        Return lcBinData
    Endproc


    Procedure add_DBCMember
        Lparameters tcMemberName

        With This As CL_DBC Of 'FOXBIN2PRG.PRG'
            ._Members_Count = ._Members_Count + 1
            Dimension ._Members( ._Members_Count, 2 )
            ._Members( ._Members_Count, 1 ) = Lower(tcMemberName)
        Endwith && THIS
    Endproc


Enddefine



Define Class CL_DBC_CONNECTIONS As CL_DBC_COL_BASE
    #If .F.
        Local This As CL_DBC_CONNECTIONS Of 'FOXBIN2PRG.PRG'
    #Endif



    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loConnection As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG'
                Store .Null. To loConnection
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_CONNECTIONS_I)) == C_CONNECTIONS_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_CONNECTIONS Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_CONNECTIONS_F $ tcLine   && Fin
                                    Exit

                                Case C_CONNECTION_I $ tcLine
                                    loConnection = Createobject("CL_DBC_CONNECTION")
                                    loConnection.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                                    .Add( loConnection, Padr(loConnection._Name,128) )

                                Case '<Comment>' $ tcLine
                                    .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loConnection
                Release lcPropName, lcValue, loConnection

        Endtry

        Return llBloqueEncontrado
    Endproc



    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, loEx As Exception ;
                    , loConnection As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG'

                With This As CL_DBC_CONNECTIONS Of 'FOXBIN2PRG.PRG'
                    loConnection        = .Null.
                    lcText              = ''
                    .read_BinDataToProperties()

                    If .Count > 0 Then

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><CONNECTIONS>
                        ENDTEXT

                        .KeySort = 2
                        For Each loConnection In This &&FOXOBJECT
                            lcText          = lcText + loConnection.toText( loConnection._Name )
                        Endfor

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>></CONNECTIONS>
                        <<>>
                        ENDTEXT
                    Endif

                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                loConnection    = .Null.
                Release loConnection

        Endtry

        Return lcText
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As CL_DBC_CONNECTIONS Of 'FOXBIN2PRG.PRG'
                    Local I, lnConnection_Count, laConnections(1), loEx As Exception ;
                        , loConnection As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG'

                    If ._Saved Then
                        lnConnection_Count  = .Count
                        Exit
                    Endif

                    loConnection        = .Null.
                    lnConnection_Count  = Adbobjects( laConnections,"CONNECTION" )

                    If lnConnection_Count > 0
                        For I = 1 To lnConnection_Count
                            loConnection    = Createobject('CL_DBC_CONNECTION')
                            loConnection.read_BinDataToProperties( laConnections(m.I) )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                            .Add( loConnection, Padr(Lower(loConnection._Name),128) )
                        Endfor
                    Endif
                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                loConnection    = .Null.
                Release I, loConnection

        Endtry

        Return lnConnection_Count
    Endproc


Enddefine



Define Class CL_DBC_CONNECTION As CL_DBC_BASE
    #If .F.
        Local This As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG'
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

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_CONNECTION_I)) == C_CONNECTION_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG'
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

                With This As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG'
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

        With This As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG'
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

        With This As CL_DBC_CONNECTION Of 'FOXBIN2PRG.PRG'
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



Define Class CL_DBC_TABLES As CL_DBC_COL_BASE
    #If .F.
        Local This As CL_DBC_TABLES Of 'FOXBIN2PRG.PRG'
    #Endif



    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loTable As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
                Store .Null. To loTable
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_TABLES_I)) == C_TABLES_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_TABLES Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_TABLES_F $ tcLine    && Fin
                                    Exit

                                Case C_TABLE_I $ tcLine
                                    loTable = Createobject("CL_DBC_TABLE")
                                    loTable.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                                    .Add( loTable, Padr(Lower(loTable._Name),128) )

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loTable
                Release lcPropName, lcValue, loTable

        Endtry

        Return llBloqueEncontrado
    Endproc



    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, loEx As Exception ;
                    , loTable As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'

                With This As CL_DBC_TABLES Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loTable
                    lcText  = ''
                    .read_BinDataToProperties()

                    If .Count > 0 Then
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><TABLES>
                        ENDTEXT

                        .KeySort = 2
                        For Each loTable In This &&FOXOBJECT
                            lcText  = lcText + loTable.toText( loTable._Name )
                        Endfor

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>></TABLES>
                        <<>>
                        ENDTEXT
                    Endif


                Endwith


            Catch To loEx
                If Vartype(loTable) = "O" Then
                    loEx.UserValue  = loEx.UserValue + CR_LF + "loTable._Name = " + Transform(loTable._Name)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loTable
                Release loTable

        Endtry

        Return lcText
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As CL_DBC_TABLES Of 'FOXBIN2PRG.PRG'
                    Local I, lnTable_Count, laTables(1), loEx As Exception ;
                        , loTable As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'

                    If ._Saved Then
                        lnTable_Count   = .Count
                        Exit
                    Endif

                    Store .Null. To loTable
                    Store 0 To I, lnTable_Count
                    lnTable_Count   = Adbobjects( laTables,"TABLE" )

                    If lnTable_Count > 0
                        For I = 1 To lnTable_Count
                            loTable = Createobject("CL_DBC_TABLE")
                            loTable.read_BinDataToProperties( laTables(m.I) )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                            .Add( loTable, Padr(Lower(loTable._Name),128) )
                        Endfor
                    Endif

                    ._Saved     = .T.
                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                loTable = .Null.
                Release I, loTable

        Endtry

        Return lnTable_Count
    Endproc


Enddefine



Define Class CL_DBC_TABLE As CL_DBC_BASE
    #If .F.
        Local This As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="_comment" display="_Comment"/>] ;
        + [<memberdata name="_path" display="_Path"/>] ;
        + [<memberdata name="_deletetrigger" display="_DeleteTrigger"/>] ;
        + [<memberdata name="_inserttrigger" display="_InsertTrigger"/>] ;
        + [<memberdata name="_updatetrigger" display="_UpdateTrigger"/>] ;
        + [<memberdata name="_primarykey" display="_PrimaryKey"/>] ;
        + [<memberdata name="_ruleexpression" display="_RuleExpression"/>] ;
        + [<memberdata name="_ruletext" display="_RuleText"/>] ;
        + [<memberdata name="_fields" display="_Fields"/>] ;
        + [<memberdata name="_indexes" display="_Indexes"/>] ;
        + [</VFPData>]


*-- Info
    _Name                   = ''
    _Comment                = ''
    _Path                   = ''
    _DeleteTrigger          = ''
    _InsertTrigger          = ''
    _UpdateTrigger          = ''
    _PrimaryKey             = ''
    _RuleExpression         = ''
    _RuleText               = ''


    Procedure Init
        DoDefault()
*--
        With This As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
            .AddObject("_Fields", "CL_DBC_FIELDS_DB")
            .AddObject("_Indexes", "CL_DBC_INDEXES_DB")
            .AddObject("_Relations", "CL_DBC_RELATIONS")
        Endwith && THIS
    Endproc


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loFields As CL_DBC_FIELDS_DB Of 'FOXBIN2PRG.PRG' ;
                    , loIndexes As CL_DBC_INDEXES_DB Of 'FOXBIN2PRG.PRG' ;
                    , loRelations As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'
                Store .Null. To loRelations, loIndexes, loFields
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_TABLE_I)) == C_TABLE_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_TABLE_F $ tcLine && Fin
                                    Exit

                                Case C_FIELD_ORDER_I $ tcLine
                                    loFields = ._Fields
                                    loFields.analyzeOrderCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Case C_FIELDS_I $ tcLine
                                    loFields = ._Fields
                                    loFields.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Case C_INDEXES_I $ tcLine
                                    loIndexes = ._Indexes
                                    loIndexes.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Case C_RELATIONS_I $ tcLine
                                    loRelations = ._Relations
                                    loRelations.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Case '<Comment>' $ tcLine
                                    .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Otherwise   && Propiedad de TABLE
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

            Finally
                Store .Null. To loRelations, loIndexes, loFields
                Release lcPropName, lcValue, loFields, loIndexes, loRelations

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcTable                   (v! IN    ) Nombre de la Tabla
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcTable, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, lcFields, lcIndexes, lcRelations, loEx As Exception ;
                    , loIndexes As CL_DBC_INDEXES_DB Of 'FOXBIN2PRG.PRG' ;
                    , loFields As CL_DBC_FIELDS_DB Of 'FOXBIN2PRG.PRG' ;
                    , loRelations As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'

                With This As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loRelations, loFields, loIndexes
                    Store '' To lcText, lcFields, lcIndexes, lcRelations
                    .read_BinDataToProperties(tcTable)

                    loFields    = Createobject('CL_DBC_FIELDS_DB')
                    lcFields    = loFields.toText( tcTable, @toFoxBin2Prg )

                    loIndexes   = Createobject('CL_DBC_INDEXES_DB')
                    lcIndexes   = loIndexes.toText( tcTable, @toFoxBin2Prg )

                    loRelations = Createobject('CL_DBC_RELATIONS')
                    lcRelations = loRelations.toText( tcTable, @toFoxBin2Prg )

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<>>
                    <<Chr(9)+Chr(9)>><TABLE>
                    <<Chr(9)+Chr(9)+Chr(9)>><Name><<._Name>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)>><Path><<._Path>></Path>
                    <<Chr(9)+Chr(9)+Chr(9)>><DeleteTrigger><<._DeleteTrigger>></DeleteTrigger>
                    <<Chr(9)+Chr(9)+Chr(9)>><InsertTrigger><<._InsertTrigger>></InsertTrigger>
                    <<Chr(9)+Chr(9)+Chr(9)>><UpdateTrigger><<._UpdateTrigger>></UpdateTrigger>
                    <<Chr(9)+Chr(9)+Chr(9)>><PrimaryKey><<._PrimaryKey>></PrimaryKey>
                    <<Chr(9)+Chr(9)+Chr(9)>><RuleExpression><<._RuleExpression>></RuleExpression>
                    <<Chr(9)+Chr(9)+Chr(9)>><RuleText><<._RuleText>></RuleText>
                    <<lcFields>>
                    <<lcIndexes>>
                    <<lcRelations>>
                    <<Chr(9)+Chr(9)>></TABLE>
                    ENDTEXT

                    ._ToText    = lcText
                Endwith


            Catch To loEx
                loEx.UserValue  = loEx.UserValue + CR_LF + "tcTable = " + Rtrim(Transform(tcTable))

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loRelations, loFields, loIndexes
                Release loIndexes, loFields, loRelations

        Endtry

        Return lcText
    Endproc


    Procedure updateDBC
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_OutputFile             (v! IN    ) Nombre del archivo de salida
* tnLastID                  (!@ IN    ) Último número de ID usado
* tnParentID                (v! IN    ) ID del objeto Padre
*---------------------------------------------------------------------------------------------------
        Lparameters tc_OutputFile, tnLastID, tnParentID

        DoDefault( tc_OutputFile, @tnLastID, tnParentID)

        With This As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
            tnParentID  = .__ObjectID
            ._Fields.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
            ._Indexes.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
            ._Relations.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
        Endwith && THIS
    Endproc


    Procedure getBinMemoFromProperties
        Local lcBinData
        lcBinData   = ''

        With This As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
            lcBinData   = lcBinData + .getBinPropertyDataRecord( 1, .getDBCPropertyIDByName('Class', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Path, .getDBCPropertyIDByName('Path', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._PrimaryKey, .getDBCPropertyIDByName('PrimaryKey', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleExpression, .getDBCPropertyIDByName('RuleExpression', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleText, .getDBCPropertyIDByName('RuleText', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._InsertTrigger, .getDBCPropertyIDByName('InsertTrigger', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UpdateTrigger, .getDBCPropertyIDByName('UpdateTrigger', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DeleteTrigger, .getDBCPropertyIDByName('DeleteTrigger', .T.) )
        Endwith && THIS

        Return lcBinData
    Endproc


    Procedure read_BinDataToProperties
        Lparameters tcTable

        With This As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
            If Not ._Saved Then
                ._Name                  = Alltrim(tcTable)
                ._Comment               = DBGetProp(tcTable,"TABLE","Comment")
                ._Path                  = DBGetProp(tcTable,"TABLE","Path")
                ._DeleteTrigger         = DBGetProp(tcTable,"TABLE","DeleteTrigger")
                ._InsertTrigger         = DBGetProp(tcTable,"TABLE","InsertTrigger")
                ._UpdateTrigger         = DBGetProp(tcTable,"TABLE","UpdateTrigger")
                ._PrimaryKey            = DBGetProp(tcTable,"TABLE","PrimaryKey")
                ._RuleExpression        = DBGetProp(tcTable,"TABLE","RuleExpression")
                ._RuleText              = DBGetProp(tcTable,"TABLE","RuleText")
*--
                ._Saved     = .T.
            Endif
        Endwith
    Endproc


Enddefine



Define Class CL_DBC_FIELDS_DB As CL_DBC_COL_BASE
    #If .F.
        Local This As CL_DBC_FIELDS_DB Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzeordercodeblock" display="analyzeOrderCodeBlock"/>] ;
        + [<memberdata name="a_campos" display="a_Campos"/>] ;
        + [<memberdata name="n_campos" display="n_Campos"/>] ;
        + [</VFPData>]


    Dimension a_Campos(1,2) && col.1=campo, col.2=definición
    n_Campos        = 0


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, lnPos, loEx As Exception ;
                    , loField As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'
                Store .Null. To loField
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_FIELDS_I)) == C_FIELDS_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_FIELDS_DB Of 'FOXBIN2PRG.PRG'
*.n_Campos = 0  && Descomentar para forzar modo LEGACY
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_FIELDS_F $ tcLine    && Fin
                                    Exit

                                Case C_FIELD_I $ tcLine
                                    loField = Createobject("CL_DBC_FIELD_DB")
                                    loField.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                    If .n_Campos = 0 Then
*-- MODO LEGACY: Cuando no existe tag de ordenamiento de campos, se agregan en el orden que se leen
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                                        .Add( loField, Padr(Lower(loField._Name),128) )
                                    Else
                                        lnPos   = Ascan( .a_Campos, loField._Name, 1, 0, 1, 1+2+4+8 )
                                        .a_Campos( lnPos, 2)    = loField
                                    Endif

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor

*-- Restablezco el orden de los campos (Solo si n_Campos > 0, que significa que tiene el nuevo tag especial de orden)
                        For lnPos = 1 To .n_Campos
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                            .Add( .a_Campos( lnPos, 2), Padr(Lower(.a_Campos( lnPos, 1)),128) )
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField
                Release lcPropName, lcValue, loField

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure analyzeOrderCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loField As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'
                Store .Null. To loField
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_FIELD_ORDER_I)) == C_FIELD_ORDER_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_FIELDS_DB Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_FIELD_ORDER_F $ tcLine   && Fin
                                    Exit

                                Otherwise   && nombre del campo en el orden original
                                    .n_Campos   = .n_Campos + 1
                                    Dimension .a_Campos(.n_Campos, 2)
                                    .a_Campos(.n_Campos, 1) = tcLine

                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField
                Release lcPropName, lcValue, loField

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcTable                   (v! IN    ) Nombre de la Tabla
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcTable, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local X, lcText, lnField_Count, laFields(1), loEx As Exception ;
                    , loField As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'

                With This As CL_DBC_FIELDS_DB Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loField
                    Store 0 To X, lnField_Count
                    lcText  = ''

                    .read_BinDataToProperties( tcTable, @toFoxBin2Prg )

                    If .Count > 0 Then
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>><FIELD_ORDER>
                        <<>>
                        ENDTEXT

                        Set Textmerge To Memvar lcText Additive Noshow
                        Set Textmerge On

                        .KeySort = 0
                        For Each loField In This &&FOXOBJECT
                        \<<Chr(9)+Chr(9)+Chr(9)+Chr(9)>><<loField._Name>>
                        Endfor

                        Set Textmerge Off
                        Set Textmerge To

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>></FIELD_ORDER>
                        <<>>
                        <<Chr(9)+Chr(9)+Chr(9)>><FIELDS>
                        ENDTEXT

                        .KeySort = 2    && Comentar para forzar modo LEGACY
                        For Each loField In This &&FOXOBJECT
                            lcText  = lcText + loField.toText( tcTable, loField._Name )
                        Endfor

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>></FIELDS>
                        ENDTEXT
                    Endif
                Endwith


            Catch To loEx
                If Vartype(loField) = "O" Then
                    loEx.UserValue  = loEx.UserValue + CR_LF + "tcTable = " + Rtrim(Transform(tcTable)) + ", loField._Name = " + Transform(loField._Name)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField
                Release loField

        Endtry

        Return lcText
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcTable                   (@! IN    ) Nombre de la tabla de la que se obtendrán los campos
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcTable, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As CL_DBC_FIELDS_DB Of 'FOXBIN2PRG.PRG'
                    Local I, lnField_Count, laFields(1), loEx As Exception ;
                        , loField As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'

                    If ._Saved Then
                        lnField_Count   = .Count
                        Exit
                    Endif

                    Store .Null. To loField
                    Store 0 To I, lnField_Count
                    _Tally  = 0

                    Select Lower(TB.ObjectName) From TABLABIN TB ;
                        INNER Join TABLABIN TB2 On Str(TB.ParentId)+TB.ObjectType = Str(TB2.ObjectID)+Padr('Field',10) ;
                        AND Lower(TB2.ObjectName) = Padr(Lower(tcTable),128) ;
                        INTO Array laFields
                    lnField_Count   = _Tally

                    If lnField_Count > 0
                        For I = 1 To lnField_Count
                            loField = Createobject("CL_DBC_FIELD_DB")
                            loField.read_BinDataToProperties( tcTable, laFields(m.I) )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                            .Add( loField, Padr(Lower(loField._Name),128) )
                        Endfor
                    Endif

                    ._Saved     = .T.
                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("TB"))
                Use In (Select("TB2"))
                loField = .Null.
                Release I, loField

        Endtry

        Return lnField_Count
    Endproc


Enddefine



Define Class CL_DBC_FIELD_DB As CL_DBC_BASE
    #If .F.
        Local This As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="_caption" display="_Caption"/>] ;
        + [<memberdata name="_comment" display="_Comment"/>] ;
        + [<memberdata name="_defaultvalue" display="_DefaultValue"/>] ;
        + [<memberdata name="_displayclass" display="_DisplayClass"/>] ;
        + [<memberdata name="_displayclasslibrary" display="_DisplayClassLibrary"/>] ;
        + [<memberdata name="_format" display="_Format"/>] ;
        + [<memberdata name="_inputmask" display="_InputMask"/>] ;
        + [<memberdata name="_ruleexpression" display="_RuleExpression"/>] ;
        + [<memberdata name="_ruletext" display="_RuleText"/>] ;
        + [</VFPData>]


*-- Info
    _Name                   = ''
    _Caption                = ''
    _Comment                = ''
    _DefaultValue           = ''
    _DisplayClass           = ''
    _DisplayClassLibrary    = ''
    _Format                 = ''
    _InputMask              = ''
    _RuleExpression         = ''
    _RuleText               = ''


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_FIELD_I)) == C_FIELD_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_FIELD_F $ tcLine && Fin
                                    Exit

                                Case '<Comment>' $ tcLine
                                    .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Otherwise   && Propiedad de FIELD
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
* tcTable                   (v! IN    ) Nombre de la Tabla
* tcField                   (v! IN    ) Nombre del campo
*---------------------------------------------------------------------------------------------------
        Lparameters tcTable, tcField

        Try
                Local lcText, loEx As Exception
                lcText  = ''

                With This As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'
                    .read_BinDataToProperties(tcTable, tcField)

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)>><FIELD>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Name><<._Name>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Caption><<._Caption>></Caption>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><DefaultValue><<._DefaultValue>></DefaultValue>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><DisplayClass><<._DisplayClass>></DisplayClass>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><DisplayClassLibrary><<._DisplayClassLibrary>></DisplayClassLibrary>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Format><<._Format>></Format>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><InputMask><<._InputMask>></InputMask>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><RuleExpression><<._RuleExpression>></RuleExpression>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><RuleText><<._RuleText>></RuleText>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)>></FIELD>
                    ENDTEXT

                    ._ToText    = lcText
                Endwith


            Catch To loEx
                loEx.UserValue  = loEx.UserValue + CR_LF + "tcTable = " + Rtrim(Transform(tcTable)) + ", tcField = " + Rtrim(Transform(tcField))

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

        With This As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DefaultValue, .getDBCPropertyIDByName('DefaultValue', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DisplayClass, .getDBCPropertyIDByName('DisplayClass', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DisplayClassLibrary, .getDBCPropertyIDByName('DisplayClassLibrary', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Caption, .getDBCPropertyIDByName('Caption', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Format, .getDBCPropertyIDByName('Format', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._InputMask, .getDBCPropertyIDByName('InputMask', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleExpression, .getDBCPropertyIDByName('RuleExpression', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleText, .getDBCPropertyIDByName('RuleText', .T.) )
        Endwith && THIS

        Return lcBinData
    Endproc


    Procedure read_BinDataToProperties
        Lparameters tcTable, tcField
        Local lcFullFieldName

        With This As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'
            If Not ._Saved Then
                ._Name                  = Alltrim(tcField)
                lcFullFieldName         = Rtrim(tcTable) + '.' + Rtrim(tcField)
                ._Caption               = DBGetProp( lcFullFieldName,"FIELD","Caption")
                ._Comment               = DBGetProp( lcFullFieldName,"FIELD","Comment")
                ._DefaultValue          = DBGetProp( lcFullFieldName,"FIELD","DefaultValue")
                ._DisplayClass          = DBGetProp( lcFullFieldName,"FIELD","DisplayClass")
                ._DisplayClassLibrary   = DBGetProp( lcFullFieldName,"FIELD","DisplayClassLibrary")
                ._Format                = DBGetProp( lcFullFieldName,"FIELD","Format")
                ._InputMask             = DBGetProp( lcFullFieldName,"FIELD","InputMask")
                ._RuleExpression        = DBGetProp( lcFullFieldName,"FIELD","RuleExpression")
                ._RuleText              = DBGetProp( lcFullFieldName,"FIELD","RuleText")
*--
                ._Saved     = .T.
            Endif
        Endwith
    Endproc


Enddefine



Define Class CL_DBC_INDEXES_DB As CL_DBC_COL_BASE
    #If .F.
        Local This As CL_DBC_INDEXES_DB Of 'FOXBIN2PRG.PRG'
    #Endif


*-- Info
    _Name                   = ''

    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loIndex As CL_DBC_INDEX_DB Of 'FOXBIN2PRG.PRG'
                Store .Null. To loIndex
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_INDEXES_I)) == C_INDEXES_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_INDEXES_DB Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_INDEXES_F $ tcLine   && Fin
                                    Exit

                                Case C_INDEX_I $ tcLine
                                    loIndex = .Null.
                                    loIndex = Createobject("CL_DBC_INDEX_DB")
                                    loIndex.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                                    .Add( loIndex, Padr(Lower(loIndex._Name),128) )

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loIndex
                Release lcPropName, lcValue, loIndex

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcTable                   (v! IN    ) Nombre de la Tabla
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcTable, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, loEx As Exception ;
                    , loIndex As CL_DBC_INDEX_DB Of 'FOXBIN2PRG.PRG'

                With This As CL_DBC_INDEXES_DB Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loIndex
                    lcText  = ''
                    .read_BinDataToProperties(tcTable, @toFoxBin2Prg)

                    If .Count > 0 Then
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>><<C_INDEXES_I>>
                        ENDTEXT

                        .KeySort = 2    && Comentar para forzar modo LEGACY
                        For Each loIndex In This &&FOXOBJECT
                            lcText  = lcText + loIndex.toText( tcTable + '.' + loIndex._Name )
                        Endfor

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>><<C_INDEXES_F>>
                        ENDTEXT
                    Endif

                Endwith

            Catch To loEx
                If Vartype(loIndex) = "O" Then
                    loEx.UserValue  = loEx.UserValue + CR_LF + "loIndex._Name = " + Rtrim(loIndex._Name)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loIndex
                Release loIndex

        Endtry

        Return lcText
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcTable                   (v! IN    ) Nombre de la Tabla
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcTable, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As CL_DBC_FIELDS_DB Of 'FOXBIN2PRG.PRG'
                    Local I, lnIndex_Count, laIndexes(1), loEx As Exception ;
                        , loIndex As CL_DBC_INDEX_DB Of 'FOXBIN2PRG.PRG'

                    If ._Saved Then
                        lnIndex_Count   = .Count
                        Exit
                    Endif

                    Store .Null. To loIndex
                    Store 0 To I, lnIndex_Count
                    _Tally  = 0
                    Select Lower(TB.ObjectName) From TABLABIN TB ;
                        INNER Join TABLABIN TB2 On Str(TB.ParentId)+TB.ObjectType = Str(TB2.ObjectID)+Padr('Index',10) ;
                        AND Lower(TB2.ObjectName) = Padr(Lower(tcTable),128) ;
                        INTO Array laIndexes
                    lnIndex_Count   = _Tally

                    If lnIndex_Count > 0
                        For I = 1 To lnIndex_Count
                            loIndex = Createobject("CL_DBC_INDEX_DB")
                            loIndex.read_BinDataToProperties( tcTable + '.' + laIndexes(m.I) )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                            .Add( loIndex, Padr(Lower(loIndex._Name),128) )
                        Endfor
                    Endif

                    ._Saved     = .T.
                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("TB"))
                Use In (Select("TB2"))
                loIndex = .Null.
                Release I, loIndex

        Endtry

        Return lnIndex_Count
    Endproc


Enddefine



Define Class CL_DBC_INDEX_DB As CL_DBC_BASE
    #If .F.
        Local This As CL_DBC_INDEX_DB Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="_isunique" display="_IsUnique"/>] ;
        + [<memberdata name="_comment" display="_Comment"/>] ;
        + [</VFPData>]


*-- Info
    _Name                   = ''
    _IsUnique               = .F.
    _Comment                = ''


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_INDEX_I)) == C_INDEX_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_INDEX_DB Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_INDEX_F $ tcLine && Fin
                                    Exit

                                Case '<Comment>' $ tcLine
                                    .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Otherwise   && Propiedad de FIELD
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
* tcIndex                   (v! IN    ) Nombre del índice en la forma "tabla.indice"
*---------------------------------------------------------------------------------------------------
        Lparameters tcIndex

        Try
                Local lcText, loEx As Exception
                lcText  = ''

                With This As CL_DBC_INDEX_DB Of 'FOXBIN2PRG.PRG'
                    .read_BinDataToProperties(tcIndex)

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)>><<C_INDEX_I>>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Name><<._Name>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)+Chr(9)>><IsUnique><<._IsUnique>></IsUnique>
                    <<Chr(9)+Chr(9)+Chr(9)+Chr(9)>><<C_INDEX_F>>
                    ENDTEXT

                    ._ToText    = lcText
                Endwith && THIS

            Catch To loEx
                loEx.UserValue  = loEx.UserValue + CR_LF + "tcIndex = " + Rtrim(Transform(tcIndex))

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

        With This As CL_DBC_INDEX_DB Of 'FOXBIN2PRG.PRG'
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._IsUnique, .getDBCPropertyIDByName('IsUnique', .T.) )
        Endwith && THIS

        Return lcBinData
    Endproc


    Procedure read_BinDataToProperties
        Lparameters tcIndex

        With This As CL_DBC_INDEX_DB Of 'FOXBIN2PRG.PRG'
            If Not ._Saved Then
                ._Name                  = Alltrim(Justext(tcIndex))
                ._Comment               = Rtrim( .DBGetProp(tcIndex,'Index','Comment') )
                ._IsUnique              = .DBGetProp(tcIndex,'Index','IsUnique')
*--
                ._Saved     = .T.
            Endif
        Endwith
    Endproc


Enddefine



Define Class CL_DBC_INDEXES_VW As CL_DBC_INDEXES_DB
Enddefine



Define Class CL_DBC_INDEX_VW As CL_DBC_INDEX_DB
Enddefine



Define Class CL_DBC_VIEWS As CL_DBC_COL_BASE
    #If .F.
        Local This As CL_DBC_VIEWS Of 'FOXBIN2PRG.PRG'
    #Endif


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loView As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'
                Store .Null. To loView
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_VIEWS_I)) == C_VIEWS_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_VIEWS Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_VIEWS_F $ tcLine && Fin
                                    Exit

                                Case C_VIEW_I $ tcLine
                                    loView = .Null.
                                    loView = Createobject("CL_DBC_VIEW")
                                    loView.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                                    .Add( loView, Padr(Lower(loView._Name),128) )

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loView
                Release lcPropName, lcValue, loView

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, lcDBC, loEx As Exception ;
                    , loView As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'

                With This As CL_DBC_VIEWS Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loView
                    lcText  = ''
                    .read_BinDataToProperties()

                    If .Count > 0 Then
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>><VIEWS>
                        ENDTEXT

                        .KeySort    = 2
                        For Each loView In This &&FOXOBJECT
                            lcText  = lcText + loView.toText( loView._Name )
                        Endfor

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)>></VIEWS>
                        <<>>
                        ENDTEXT
                    Endif

                    ._Saved     = .T.
                Endwith


            Catch To loEx
                If Vartype(loView) = "O" Then
                    loEx.UserValue  = loEx.UserValue + CR_LF + "loView._Name = " + Rtrim(loView._Name)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loView
                Release loView

        Endtry

        Return lcText
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As CL_DBC_VIEWS Of 'FOXBIN2PRG.PRG'
                    Local I, lnView_Count, laViews(1), loEx As Exception ;
                        , loTable As CL_DBC_TABLE Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loTable
                    Store 0 To I, tnTable_Count

                    If ._Saved Then
                        lnView_Count    = .Count
                        Exit
                    Endif

*LG lnView_Count    = ADBOBJECTS( laViews, "VIEW" )
                    Select Cast(Alltrim(ObjectName) As Varchar(128)) ;
                        FROM TABLABIN ;
                        WHERE Upper(ObjectType) = 'VIEW' ;
                        ORDER By 1 ;
                        INTO Array laViews
                    lnView_Count    = _Tally

                    If lnView_Count > 0
                        For I = 1 To lnView_Count
                            loView = Createobject("CL_DBC_VIEW")
                            loView.read_BinDataToProperties( laViews(m.I) )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                            .Add( loView, Padr(Lower(loView._Name),128) )
                        Endfor
                    Endif

                    ._Saved     = .T.
                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                loView  = .Null.
                Release I, loView

        Endtry

        Return lnView_Count
    Endproc


Enddefine



Define Class CL_DBC_VIEW As CL_DBC_BASE
    #If .F.
        Local This As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="_comment" display="_Comment"/>] ;
        + [<memberdata name="_tables" display="_Tables"/>] ;
        + [<memberdata name="_sql" display="_SQL"/>] ;
        + [<memberdata name="_allowsimultaneousfetch" display="_AllowSimultaneousFetch"/>] ;
        + [<memberdata name="_batchupdatecount" display="_BatchUpdateCount"/>] ;
        + [<memberdata name="_comparememo" display="_CompareMemo"/>] ;
        + [<memberdata name="_connectname" display="_ConnectName"/>] ;
        + [<memberdata name="_fetchasneeded" display="_FetchAsNeeded"/>] ;
        + [<memberdata name="_fetchmemo" display="_FetchMemo"/>] ;
        + [<memberdata name="_fetchsize" display="_FetchSize"/>] ;
        + [<memberdata name="_maxrecords" display="_MaxRecords"/>] ;
        + [<memberdata name="_offline" display="_Offline"/>] ;
        + [<memberdata name="_recordcount" display="_RecordCount"/>] ;
        + [<memberdata name="_path" display="_Path"/>] ;
        + [<memberdata name="_parameterlist" display="_ParameterList"/>] ;
        + [<memberdata name="_prepared" display="_Prepared"/>] ;
        + [<memberdata name="_ruleexpression" display="_RuleExpression"/>] ;
        + [<memberdata name="_ruletext" display="_RuleText"/>] ;
        + [<memberdata name="_sendupdates" display="_SendUpdates"/>] ;
        + [<memberdata name="_shareconnection" display="_ShareConnection"/>] ;
        + [<memberdata name="_sourcetype" display="_SourceType"/>] ;
        + [<memberdata name="_updatetype" display="_UpdateType"/>] ;
        + [<memberdata name="_usememosize" display="_UseMemoSize"/>] ;
        + [<memberdata name="_wheretype" display="_WhereType"/>] ;
        + [<memberdata name="_fields" display="_Fields"/>] ;
        + [<memberdata name="_indexes" display="_Indexes"/>] ;
        + [</VFPData>]


*-- Info
    _Name                   = ''
    _Comment                = ''
    _Tables                 = ''
    _Sql                    = ''
    _AllowSimultaneousFetch = .F.
    _BatchUpdateCount       = 0
    _CompareMemo            = .F.
    _ConnectName            = ''
    _FetchAsNeeded          = .F.
    _FetchMemo              = .F.
    _FetchSize              = 0
    _MaxRecords             = 0
    _Offline                = .F.
    _RecordCount            = 0
    _Path                   = ''
    _ParameterList          = ''
    _Prepared               = .F.
    _RuleExpression         = ''
    _RuleText               = ''
    _SendUpdates            = .F.
    _ShareConnection        = .F.
    _SourceType             = 0
    _UpdateType             = 0
    _UseMemoSize            = 0
    _WhereType              = 0

*-- Sub-objects
*_Fields                = .Null.
*_Indexes               = .Null.
*_Relations             = .Null.


    Procedure Init
        DoDefault()
*--
        With This As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'
            .AddObject("_Fields", "CL_DBC_FIELDS_VW")
            .AddObject("_Indexes", "CL_DBC_INDEXES_VW")
            .AddObject("_Relations", "CL_DBC_RELATIONS")
        Endwith && THIS
    Endproc


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loFields As CL_DBC_FIELDS_VW Of 'FOXBIN2PRG.PRG' ;
                    , loIndexes As CL_DBC_INDEXES_VW Of 'FOXBIN2PRG.PRG' ;
                    , loRelations As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'
                Store .Null. To loRelations, loIndexes, loFields
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_VIEW_I)) == C_VIEW_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_VIEW_F $ tcLine  && Fin
                                    Exit

                                Case C_FIELD_ORDER_I $ tcLine
                                    loFields = ._Fields
                                    loFields.analyzeOrderCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Case C_FIELDS_I $ tcLine
                                    loFields    = .Null.
                                    loFields    = ._Fields
                                    loFields.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Case C_INDEXES_I $ tcLine
                                    loIndexes   = .Null.
                                    loIndexes   = ._Indexes
                                    loIndexes.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Case C_RELATIONS_I $ tcLine
                                    loRelations = .Null.
                                    loRelations = ._Relations
                                    loRelations.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Case '<Comment>' $ tcLine
                                    .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Otherwise   && Propiedad de VIEW
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

            Finally
                Store .Null. To loRelations, loIndexes, loFields
                Local lcPropName, lcValue, loFields, loIndexes, loRelations

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcView                    (v! IN    ) Vista en evaluación
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcView, toFoxBin2Prg
        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, lcFields, lcIndexes, lcRelations, lcDBC, loEx As Exception ;
                    , loFields As CL_DBC_FIELDS_VW Of 'FOXBIN2PRG.PRG' ;
                    , loIndexes As CL_DBC_INDEXES_VW Of 'FOXBIN2PRG.PRG' ;
                    , loRelations As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'
                Store .Null. To loRelations, loIndexes, loFields
                Store '' To lcText, lcFields, lcIndexes, lcRelations

                With This As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'
                    .read_BinDataToProperties(tcView)

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<>>
                    <<Chr(9)+Chr(9)>><VIEW>
                    <<Chr(9)+Chr(9)+Chr(9)>><Name><<tcView>></Name>
                    <<Chr(9)+Chr(9)+Chr(9)>><Comment><<._Comment>></Comment>
                    <<Chr(9)+Chr(9)+Chr(9)>><Tables><<._Tables>></Tables>
                    <<Chr(9)+Chr(9)+Chr(9)>><SQL><<._SQL>></SQL>
                    <<Chr(9)+Chr(9)+Chr(9)>><AllowSimultaneousFetch><<._AllowSimultaneousFetch>></AllowSimultaneousFetch>
                    <<Chr(9)+Chr(9)+Chr(9)>><BatchUpdateCount><<._BatchUpdateCount>></BatchUpdateCount>
                    <<Chr(9)+Chr(9)+Chr(9)>><CompareMemo><<._CompareMemo>></CompareMemo>
                    <<Chr(9)+Chr(9)+Chr(9)>><ConnectName><<._ConnectName>></ConnectName>
                    <<Chr(9)+Chr(9)+Chr(9)>><FetchAsNeeded><<._FetchAsNeeded>></FetchAsNeeded>
                    <<Chr(9)+Chr(9)+Chr(9)>><FetchMemo><<._FetchMemo>></FetchMemo>
                    <<Chr(9)+Chr(9)+Chr(9)>><FetchSize><<._FetchSize>></FetchSize>
                    <<Chr(9)+Chr(9)+Chr(9)>><MaxRecords><<._MaxRecords>></MaxRecords>
                    <<Chr(9)+Chr(9)+Chr(9)>><Offline><<._Offline>></Offline>
                    <<Chr(9)+Chr(9)+Chr(9)>><ParameterList><<._ParameterList>></ParameterList>
                    <<Chr(9)+Chr(9)+Chr(9)>><Prepared><<._Prepared>></Prepared>
                    <<Chr(9)+Chr(9)+Chr(9)>><RuleExpression><<._RuleExpression>></RuleExpression>
                    <<Chr(9)+Chr(9)+Chr(9)>><RuleText><<._RuleText>></RuleText>
                    <<Chr(9)+Chr(9)+Chr(9)>><SendUpdates><<._SendUpdates>></SendUpdates>
                    <<Chr(9)+Chr(9)+Chr(9)>><ShareConnection><<._ShareConnection>></ShareConnection>
                    <<Chr(9)+Chr(9)+Chr(9)>><SourceType><<._SourceType>></SourceType>
                    <<Chr(9)+Chr(9)+Chr(9)>><UpdateType><<._UpdateType>></UpdateType>
                    <<Chr(9)+Chr(9)+Chr(9)>><UseMemoSize><<._UseMemoSize>></UseMemoSize>
                    <<Chr(9)+Chr(9)+Chr(9)>><WhereType><<._WhereType>></WhereType>
                    ENDTEXT

*-- ALGUNOS VALORES QUE EL DBGETPROP OFICIAL NO DEVUELVE
*--     Path
*--     OfflineRecordCount
                    If ._Offline Then
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<Chr(9)+Chr(9)+Chr(9)>><Path><<._Path>></Path>
                        <<Chr(9)+Chr(9)+Chr(9)>><RecordCount><<._RecordCount>></RecordCount>
                        ENDTEXT
                    Endif
*--

                    loFields    = ._Fields
                    lcFields    = loFields.toText( tcView )

                    loIndexes   = ._Indexes
                    lcIndexes   = loIndexes.toText( tcView )

                    loRelations = ._Relations
                    lcRelations = loRelations.toText( tcView )

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<lcFields>>
                    <<lcIndexes>>
                    <<lcRelations>>
                    <<Chr(9)+Chr(9)>></VIEW>
                    ENDTEXT

                    ._ToText    = lcText
                Endwith && THIS


            Catch To loEx
                loEx.UserValue  = loEx.UserValue + CR_LF + "tcView = " + Rtrim(Transform(tcView))

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loRelations, loIndexes, loFields
                Release loFields, loIndexes, loRelations

        Endtry

        Return lcText
    Endproc


    Procedure updateDBC
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_OutputFile             (v! IN    ) Nombre del archivo de salida
* tnLastID                  (!@ IN    ) Último número de ID usado
* tnParentID                (v! IN    ) ID del objeto Padre
*---------------------------------------------------------------------------------------------------
        Lparameters tc_OutputFile, tnLastID, tnParentID

        DoDefault( tc_OutputFile, @tnLastID, tnParentID)

        With This As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'
            tnParentID  = .__ObjectID
            ._Fields.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
            ._Indexes.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
            ._Relations.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
        Endwith && THIS
    Endproc


    Procedure getBinMemoFromProperties
        Local lcBinData
        lcBinData   = ''

        With This As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'
            If ._SourceType = 1
                lcBinData   = lcBinData + .getBinPropertyDataRecord( 6, .getDBCPropertyIDByName('Class', .T.) )
            Else
                lcBinData   = lcBinData + .getBinPropertyDataRecord( 7, .getDBCPropertyIDByName('Class', .T.) )
            Endif
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UpdateType, .getDBCPropertyIDByName('UpdateType', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._WhereType, .getDBCPropertyIDByName('WhereType', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._FetchMemo, .getDBCPropertyIDByName('FetchMemo', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ShareConnection, .getDBCPropertyIDByName('ShareConnection', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._AllowSimultaneousFetch, .getDBCPropertyIDByName('AllowSimultaneousFetch', .T.) ) && Undocumented
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._SendUpdates, .getDBCPropertyIDByName('SendUpdates', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Prepared, .getDBCPropertyIDByName('Prepared', .T.) ) && Undocumented
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._CompareMemo, .getDBCPropertyIDByName('CompareMemo', .T.) )   && Undocumented
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._FetchAsNeeded, .getDBCPropertyIDByName('FetchAsNeeded', .T.) )   && Undocumented
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._FetchSize, .getDBCPropertyIDByName('FetchSize', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._MaxRecords, .getDBCPropertyIDByName('MaxRecords', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Tables, .getDBCPropertyIDByName('Tables', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Sql, .getDBCPropertyIDByName('SQL', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._SourceType, .getDBCPropertyIDByName('SourceType', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._BatchUpdateCount, .getDBCPropertyIDByName('BatchUpdateCount', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleExpression, .getDBCPropertyIDByName('RuleExpression', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleText, .getDBCPropertyIDByName('RuleText', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ParameterList, .getDBCPropertyIDByName('ParameterList', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ConnectName, .getDBCPropertyIDByName('ConnectName', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UseMemoSize, .getDBCPropertyIDByName('UseMemoSize', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Offline, .getDBCPropertyIDByName('Offline', .T.) )   && Undocumented
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RecordCount, .getDBCPropertyIDByName('RecordCount', .T.) )   && Undocumented
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Path, .getDBCPropertyIDByName('Path', .T.) ) && Undocumented
            lcBinData   = lcBinData + .getBinPropertyDataRecord( 0, .getDBCPropertyIDByName('undocumented_view_prop_85', .T.) ) && Undocumented
        Endwith && THIS

        Return lcBinData
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcView                    (v! IN    ) Vista en evaluación
*---------------------------------------------------------------------------------------------------
        Lparameters tcView

        With This As CL_DBC_VIEW Of 'FOXBIN2PRG.PRG'
            If Not ._Saved Then
                ._Name                      = Alltrim(tcView)
                ._Comment                   = DBGetProp(tcView,"VIEW","Comment")
                ._Tables                    = DBGetProp(tcView,"VIEW","Tables")
                ._Sql                       = DBGetProp(tcView,"VIEW","SQL")
                ._AllowSimultaneousFetch    = DBGetProp(tcView,"VIEW","AllowSimultaneousFetch")
                ._BatchUpdateCount          = DBGetProp(tcView,"VIEW","BatchUpdateCount")
                ._CompareMemo               = DBGetProp(tcView,"VIEW","CompareMemo")
                ._ConnectName               = DBGetProp(tcView,"VIEW","ConnectName")
                ._FetchAsNeeded             = DBGetProp(tcView,"VIEW","FetchAsNeeded")
                ._FetchMemo                 = DBGetProp(tcView,"VIEW","FetchMemo")
                ._FetchSize                 = DBGetProp(tcView,"VIEW","FetchSize")
                ._MaxRecords                = DBGetProp(tcView,"VIEW","MaxRecords")
                ._Offline                   = DBGetProp(tcView,"VIEW","Offline")
                ._ParameterList             = DBGetProp(tcView,"VIEW","ParameterList")
                ._Prepared                  = DBGetProp(tcView,"VIEW","Prepared")
                ._RuleExpression            = DBGetProp(tcView,"VIEW","RuleExpression")
                ._RuleText                  = DBGetProp(tcView,"VIEW","RuleText")
                ._SendUpdates               = DBGetProp(tcView,"VIEW","SendUpdates")
                ._ShareConnection           = DBGetProp(tcView,"VIEW","ShareConnection")
                ._SourceType                = DBGetProp(tcView,"VIEW","SourceType")
                ._UpdateType                = DBGetProp(tcView,"VIEW","UpdateType")
                ._UseMemoSize               = DBGetProp(tcView,"VIEW","UseMemoSize")
                ._WhereType                 = DBGetProp(tcView,"VIEW","WhereType")
*--
                ._Path                      = .DBGetProp(tcView,"VIEW","Path")          && Para las Vistas el DBGETPROP oficial no funciona con Path
                ._RecordCount               = .DBGetProp(tcView,"VIEW","RecordCount")   && Para las Vistas el DBGETPROP oficial no funciona con RecordCount
*--
                ._Saved     = .T.
            Endif
        Endwith
    Endproc


Enddefine



Define Class CL_DBC_FIELDS_VW As CL_DBC_COL_BASE
    #If .F.
        Local This As CL_DBC_FIELDS_VW Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzeordercodeblock" display="analyzeOrderCodeBlock"/>] ;
        + [<memberdata name="a_campos" display="a_Campos"/>] ;
        + [<memberdata name="n_campos" display="n_Campos"/>] ;
        + [</VFPData>]

    Dimension a_Campos(1,2) && col.1=campo, col.2=definición
    n_Campos        = 0


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loField As CL_DBC_FIELD_VW Of 'FOXBIN2PRG.PRG'
                Store .Null. To loField
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_FIELDS_I)) == C_FIELDS_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_FIELDS_VW Of 'FOXBIN2PRG.PRG'
*.n_Campos = 0  && Descomentar para forzar modo LEGACY
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_FIELDS_F $ tcLine    && Fin
                                    Exit

                                Case C_FIELD_I $ tcLine
                                    loField = .Null.
                                    loField = Createobject("CL_DBC_FIELD_VW")
                                    loField.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                    If .n_Campos = 0 Then
*-- MODO LEGACY: Cuando no existe tag de ordenamiento de campos, se agregan en el orden que se leen
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                                        .Add( loField, Padr(Lower(loField._Name),128) )
                                    Else
                                        lnPos   = Ascan( .a_Campos, loField._Name, 1, 0, 1, 1+2+4+8 )
                                        .a_Campos( lnPos, 2)    = loField
                                    Endif

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor

*-- Restablezco el orden de los campos (Solo si n_Campos > 0, que significa que tiene el nuevo tag especial de orden)
                        For lnPos = 1 To .n_Campos
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                            .Add( .a_Campos( lnPos, 2), Padr(Lower(.a_Campos( lnPos, 1)),128) )
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField
                Release lcPropName, lcValue, loField

        Endtry

        Return llBloqueEncontrado
    Endproc



    Procedure analyzeOrderCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loField As CL_DBC_FIELD_DB Of 'FOXBIN2PRG.PRG'
                Store .Null. To loField
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_FIELD_ORDER_I)) == C_FIELD_ORDER_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_FIELDS_VW Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_FIELD_ORDER_F $ tcLine   && Fin
                                    Exit

                                Otherwise   && nombre del campo en el orden original
                                    .n_Campos   = .n_Campos + 1
                                    Dimension .a_Campos(.n_Campos, 2)
                                    .a_Campos(.n_Campos, 1) = tcLine

                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField
                Release lcPropName, lcValue, loField

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcView                    (v! IN    ) Nombre de la Vista
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcView, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, loEx As Exception ;
                    , loField As CL_DBC_FIELD_VW Of 'FOXBIN2PRG.PRG'
                Store .Null. To loField
                lcText  = ''

                With This As CL_DBC_FIELDS_VW Of 'FOXBIN2PRG.PRG'
                    .read_BinDataToProperties(tcView, @toFoxBin2Prg)

                    If .Count > 0 Then
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>><FIELD_ORDER>
                        <<>>
                        ENDTEXT

                        Set Textmerge To Memvar lcText Additive Noshow
                        Set Textmerge On

                        .KeySort = 0
                        For Each loField In This &&FOXOBJECT
                        \<<chr(9)+chr(9)+chr(9)+chr(9)>><<loField._Name>>
                        Endfor

                        Set Textmerge Off
                        Set Textmerge To

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>></FIELD_ORDER>
                        <<>>
                        <<chr(9)+chr(9)+chr(9)>><FIELDS>
                        ENDTEXT

                        .KeySort = 2    && Comentar para forzar modo LEGACY
                        For Each loField In This &&FOXOBJECT
                            lcText  = lcText + loField.toText( tcView, loField._Name )
                        Endfor

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>></FIELDS>
                        ENDTEXT
                    Endif
                Endwith


            Catch To loEx
                If Vartype(loField) = "O" Then
                    loEx.UserValue  = loEx.UserValue + CR_LF + "loField._Name = " + Rtrim(loField._Name)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField
                Release loField

        Endtry

        Return lcText
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcView                    (@! IN    ) Nombre de la vista de la que se obtendrán los campos
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcView, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local I, lcText, lnField_Count, laFields(1), loEx As Exception ;
                    , loField As CL_DBC_FIELD_VW Of 'FOXBIN2PRG.PRG'
                Store .Null. To loField
                Store 0 To I, lnField_Count
                lcText  = ''

                With This As CL_DBC_FIELDS_VW Of 'FOXBIN2PRG.PRG'
                    If ._Saved Then
                        lnField_Count   = .Count
                        Exit
                    Endif

                    _Tally  = 0
                    Select Lower(TB.ObjectName) From TABLABIN TB ;
                        INNER Join TABLABIN TB2 On Str(TB.ParentId)+TB.ObjectType = Str(TB2.ObjectID)+Padr('Field',10) ;
                        AND Lower(TB2.ObjectName) = Padr(Lower(tcView),128) ;
                        INTO Array laFields
                    lnField_Count   = _Tally

                    If lnField_Count > 0
                        For I = 1 To lnField_Count
                            loField = Createobject("CL_DBC_FIELD_VW")
                            loField.read_BinDataToProperties( tcView, laFields(m.I) )
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                            .Add( loField, Padr(Lower(loField._Name),128) )
                        Endfor
                    Endif

                    ._Saved     = .T.
                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Use In (Select("TB"))
                Use In (Select("TB2"))
                loField = .Null.
                Release loField

        Endtry

        Return lnField_Count
    Endproc


Enddefine



Define Class CL_DBC_FIELD_VW As CL_DBC_BASE
    #If .F.
        Local This As CL_DBC_FIELD_VW Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="_caption" display="_Caption"/>] ;
        + [<memberdata name="_comment" display="_Comment"/>] ;
        + [<memberdata name="_datatype" display="_DataType"/>] ;
        + [<memberdata name="_defaultvalue" display="_DefaultValue"/>] ;
        + [<memberdata name="_displayclass" display="_DisplayClass"/>] ;
        + [<memberdata name="_displayclasslibrary" display="_DisplayClassLibrary"/>] ;
        + [<memberdata name="_format" display="_Format"/>] ;
        + [<memberdata name="_inputmask" display="_InputMask"/>] ;
        + [<memberdata name="_keyfield" display="_KeyField"/>] ;
        + [<memberdata name="_ruleexpression" display="_RuleExpression"/>] ;
        + [<memberdata name="_ruletext" display="_RuleText"/>] ;
        + [<memberdata name="_updatable" display="_Updatable"/>] ;
        + [<memberdata name="_updatename" display="_UpdateName"/>] ;
        + [</VFPData>]


*-- Info
    _Name                   = ''
    _Caption                = ''
    _Comment                = ''
    _DataType               = ''
    _DefaultValue           = ''
    _DisplayClass           = ''
    _DisplayClassLibrary    = ''
    _Format                 = ''
    _InputMask              = ''
    _KeyField               = .F.
    _RuleExpression         = ''
    _RuleText               = ''
    _Updatable              = .F.
    _UpdateName             = ''


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_FIELD_I)) == C_FIELD_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_FIELD_VW Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_FIELD_F $ tcLine && Fin
                                    Exit

                                Case '<Comment>' $ tcLine
                                    .analyzeCodeBlock_Comment( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Otherwise   && Propiedad de FIELD
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
* tcView                    (v! IN    ) Nombre de la Vista
* tcField                   (v! IN    ) Nombre del campo
*---------------------------------------------------------------------------------------------------
        Lparameters tcView, tcField

        Try
                With This As CL_DBC_FIELD_VW Of 'FOXBIN2PRG.PRG'
                    Local lcText, loEx As Exception
                    lcText  = ''

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<chr(9)+chr(9)+chr(9)+chr(9)>><FIELD>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Name><<._Name>></Name>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Caption><<._Caption>></Caption>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Comment><<._Comment>></Comment>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><DataType><<._DataType>></DataType>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><DefaultValue><<._DefaultValue>></DefaultValue>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><DisplayClass><<._DisplayClass>></DisplayClass>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><DisplayClassLibrary><<._DisplayClassLibrary>></DisplayClassLibrary>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Format><<._Format>></Format>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><InputMask><<._InputMask>></InputMask>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><KeyField><<._KeyField>></KeyField>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><RuleExpression><<._RuleExpression>></RuleExpression>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><RuleText><<._RuleText>></RuleText>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Updatable><<._Updatable>></Updatable>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><UpdateName><<._UpdateName>></UpdateName>
                    <<chr(9)+chr(9)+chr(9)+chr(9)>></FIELD>
                    ENDTEXT

                    ._ToText    = lcText
                Endwith

            Catch To loEx
                loEx.UserValue  = loEx.UserValue + CR_LF + "tcView.tcField = " + Transform(tcView) + '.' + Transform(tcField)

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

        With This As CL_DBC_FIELD_VW Of 'FOXBIN2PRG.PRG'
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Comment, .getDBCPropertyIDByName('Comment', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DataType, .getDBCPropertyIDByName('DataType', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._KeyField, .getDBCPropertyIDByName('KeyField', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Updatable, .getDBCPropertyIDByName('UpdatableField', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._UpdateName, .getDBCPropertyIDByName('UpdateName', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DefaultValue, .getDBCPropertyIDByName('DefaultValue', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DisplayClass, .getDBCPropertyIDByName('DisplayClass', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._DisplayClassLibrary, .getDBCPropertyIDByName('DisplayClassLibrary', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Caption, .getDBCPropertyIDByName('Caption', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._Format, .getDBCPropertyIDByName('Format', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._InputMask, .getDBCPropertyIDByName('InputMask', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleExpression, .getDBCPropertyIDByName('RuleExpression', .T.) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._RuleText, .getDBCPropertyIDByName('RuleText', .T.) )
        Endwith && THIS

        Return lcBinData
    Endproc


    Procedure read_BinDataToProperties
        Lparameters tcView, tcField

        With This As CL_DBC_FIELD_VW Of 'FOXBIN2PRG.PRG'
            If Not ._Saved Then
                ._Name                  = Alltrim(tcField)
                ._Caption               = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","Caption")
                ._Comment               = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","Comment")
                ._DataType              = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","DataType")
                ._DefaultValue          = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","DefaultValue")
                ._DisplayClass          = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","DisplayClass")
                ._DisplayClassLibrary   = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","DisplayClassLibrary")
                ._Format                = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","Format")
                ._InputMask             = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","InputMask")
                ._KeyField              = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","KeyField")
                ._RuleExpression        = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","RuleExpression")
                ._RuleText              = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","RuleText")
                ._Updatable             = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","Updatable")
                ._UpdateName            = DBGetProp( Rtrim(tcView) + '.' + Rtrim(tcField),"FIELD","UpdateName")
*--
                ._Saved     = .T.
            Endif
        Endwith
    Endproc


Enddefine



Define Class CL_DBC_RELATIONS As CL_DBC_COL_BASE
    #If .F.
        Local This As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'
    #Endif


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loRelation As CL_DBC_RELATION Of 'FOXBIN2PRG.PRG'
                Store .Null. To loRelation
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_RELATIONS_I)) == C_RELATIONS_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_RELATIONS_F $ tcLine && Fin
                                    Exit

                                Case C_RELATION_I $ tcLine
                                    loRelation = .Null.
                                    loRelation = Createobject("CL_DBC_RELATION")
                                    loRelation.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                    Try
*-- El siguiente PADR() es porque si no "estoXXX" está antes que "esto" cuando keysort=2 (raro...)
                                            .Add( loRelation, Padr(Lower(loRelation._Name),128) )
                                        Catch To loEx When loEx.ErrorNo = 2062  && The specified Key already exists.
*-- Saltear este error, porque implica que la relación está duplicada
                                    Endtry

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loRelation
                Release lcPropName, lcValue, loRelation

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcTable                   (v! IN    ) Tabla de la que obtener las relaciones
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcTable, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'
                    Local lcText, loEx As Exception ;
                        , loRelation As CL_DBC_RELATION Of 'FOXBIN2PRG.PRG'
                    Store .Null. To loRelation
                    lcText  = ''
                    .read_BinDataToProperties(tcTable, @toFoxBin2Prg)

                    If .Count > 0 Then
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>><RELATIONS>
                        ENDTEXT

                        .KeySort=2  && Comentar para forzar modo LEGACY
                        For Each loRelation In This &&FOXOBJECT
                            lcText  = lcText + loRelation.toText()
                        Endfor

                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<chr(9)+chr(9)+chr(9)>></RELATIONS>
                        <<>>
                        ENDTEXT
                    Endif
                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loRelation
                Release I, X, loRelation

        Endtry

        Return lcText
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcTable                   (v! IN    ) Tabla de la que obtener las relaciones
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tcTable, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As CL_DBC_RELATIONS Of 'FOXBIN2PRG.PRG'
                    Local I, lnRelation_Count, laRelations(1,5), lcText, loEx As Exception ;
                        , loRelation As CL_DBC_RELATION Of 'FOXBIN2PRG.PRG'

                    Store .Null. To loRelation
                    lcText  = ''
                    I       = 0

                    lnRelation_Count    = Adbobjects( laRelations, "RELATION" )

                    If lnRelation_Count > 0
*-- Ordenamiento: Comentar los ASORT para el orden original
                        Asort( laRelations, 3, -1, 0, 1 )
                        Asort( laRelations, 1, -1, 0, 1 )
                        Asort( laRelations, 4, -1, 0, 1 )
                        Asort( laRelations, 2, -1, 0, 1 )

                        For I = 1 To lnRelation_Count
                            If laRelations(m.I,1) == Upper( Rtrim( tcTable ) )
                                loRelation  = Createobject('CL_DBC_RELATION')
                                loRelation.read_BinDataToProperties( @laRelations, m.I )
                                Try
                                        .Add( loRelation, Padr(Lower(loRelation._Name),128) )
                                    Catch To loEx When loEx.ErrorNo = 2062  && The specified Key already exists.
*-- Saltear este error, porque implica que la relación está duplicada
                                Endtry
                            Endif
                        Endfor

                    Endif

                Endwith

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loRelation
                Release loRelation

        Endtry

        Return lcText
    Endproc


Enddefine



Define Class CL_DBC_RELATION As CL_DBC_BASE
    #If .F.
        Local This As CL_DBC_RELATION Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_childtable" display="_ChildTable"/>] ;
        + [<memberdata name="_parenttable" display="_ParentTable"/>] ;
        + [<memberdata name="_childindex" display="_ChildIndex"/>] ;
        + [<memberdata name="_parentindex" display="_ParentIndex"/>] ;
        + [<memberdata name="_refintegrity" display="_RefIntegrity"/>] ;
        + [</VFPData>]


*-- Info
    _ChildTable     = ''
    _ParentTable    = ''
    _ChildIndex     = ''
    _ParentIndex    = ''
    _RefIntegrity   = ''



    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_RELATION_I)) == C_RELATION_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBC_RELATION Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_RELATION_F $ tcLine  && Fin
                                    Exit

                                Otherwise   && Propiedad de RELATION
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
* taRelations               (!@ IN    ) Array de relaciones
* X                         (!@ IN    ) Número de relación evaluado
*---------------------------------------------------------------------------------------------------
        Lparameters taRelations, X

        External Array taRelations

        Try
                With This As CL_DBC_RELATION Of 'FOXBIN2PRG.PRG'
                    Local lcText, loEx As Exception
                    lcText  = ''
                    .read_BinDataToProperties(@taRelations, m.X)

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<chr(9)+chr(9)+chr(9)+chr(9)>><RELATION>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Name><<._Name>></Name>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><ChildTable><<._ChildTable>></ChildTable>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><ParentTable><<._ParentTable>></ParentTable>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><ChildIndex><<._ChildIndex>></ChildIndex>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><ParentIndex><<._ParentIndex>></ParentIndex>
                    <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><RefIntegrity><<._RefIntegrity>></RefIntegrity>
                    <<chr(9)+chr(9)+chr(9)+chr(9)>></RELATION>
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


    Procedure getReferentialIntegrityInfo
        Return This._RefIntegrity
    Endproc


    Procedure getBinMemoFromProperties
        Local lcBinData
        lcBinData   = ''

        With This As CL_DBC_RELATION Of 'FOXBIN2PRG.PRG'
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ChildIndex, .getDBCPropertyIDByName( 'ChildTag', .T. ) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ParentTable, .getDBCPropertyIDByName( 'ParentTable', .T. ) )
            lcBinData   = lcBinData + .getBinPropertyDataRecord( ._ParentIndex, .getDBCPropertyIDByName( 'ParentTag', .T. ) )
*_ChildTable is used to link the name of the related table.
        Endwith && THIS

        Return lcBinData
    Endproc


    Procedure read_BinDataToProperties
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taRelations               (!@ IN    ) Array de relaciones
* I                         (!@ IN    ) Número de relación evaluado
*---------------------------------------------------------------------------------------------------
        Lparameters taRelations, I

        External Array taRelations

        With This As CL_DBC_RELATION Of 'FOXBIN2PRG.PRG'
            If Not ._Saved Then
                ._Name                  = 'Relation ' + Transform(m.I)
                ._ChildTable            = Alltrim(taRelations(m.I,1))
                ._ParentTable           = Alltrim(taRelations(m.I,2))
                ._ChildIndex            = Alltrim(taRelations(m.I,3))
                ._ParentIndex           = Alltrim(taRelations(m.I,4))
                ._RefIntegrity          = Alltrim(taRelations(m.I,5))
*--
                ._Saved     = .T.
            Endif
        Endwith
    Endproc


Enddefine



Define Class CL_DBF_TABLE As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_DBF_TABLE Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_codepage" display="_CodePage"/>] ;
        + [<memberdata name="_cpid" display="_CPID"/>] ;
        + [<memberdata name="_database" display="_Database"/>] ;
        + [<memberdata name="_filetype" display="_FileType"/>] ;
        + [<memberdata name="_filetype_descrip" display="_FileType_Descrip"/>] ;
        + [<memberdata name="_indexfile" display="_IndexFile"/>] ;
        + [<memberdata name="_memofile" display="_MemoFile"/>] ;
        + [<memberdata name="_lastupdate" display="_LastUpdate"/>] ;
        + [<memberdata name="_fields" display="_Fields"/>] ;
        + [<memberdata name="_indexes" display="_Indexes"/>] ;
        + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
        + [<memberdata name="_version" display="_Version"/>] ;
        + [<memberdata name="_fields" display="_Fields"/>] ;
        + [<memberdata name="_indexes" display="_Indexes"/>] ;
        + [<memberdata name="_i" display="_I"/>] ;
        + [<memberdata name="_tablename" display="_TableName"/>] ;
        + [</VFPData>]


*-- Modulo
    _Version            = 0
    _SourceFile         = ''
*LScheffler 20.08.2023
*issue #96, [KestasL] keep CodePage relavant information for binary sources
    _cpid               = Cpcurrent()
    _I                  = 0

*-- Table Info
    _TableName          = ''
    _CodePage           = 0
    _Database           = ''
    _FileType           = ''
    _FileType_Descrip   = ''
    _IndexFile          = ''
    _MemoFile           = ''
    _LastUpdate         = {}

*-- Fields and Indexes
*_Fields                = .Null.
*_Indexes           = .Null.


    Procedure Init
        DoDefault()
*--
        This.AddObject("_Fields", "CL_DBF_FIELDS")
        This.AddObject("_Indexes", "CL_DBF_INDEXES")
*** DH 06/02/2014: added _Records
        This.AddObject("_Records", "CL_DBF_RECORDS")
    Endproc


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
* tl_DBF_BinChar_Base64     out of settings (folder or per-file) Transform NocPTrans fields base64
* tl_DBF_IncludeDeleted     out of settings (folder or per-file) Include deleted records
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toFoxBin2Prg, tl_DBF_BinChar_Base64, tl_DBF_IncludeDeleted

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, llFieldsEvaluated, llIndexesEvaluated ;
                    , loEx As Exception ;
                    , loFields As CL_DBF_FIELDS Of 'FOXBIN2PRG.PRG' ;
                    , loIndexes As CL_DBF_INDEXES Of 'FOXBIN2PRG.PRG' ;
                    , loRecords As CL_DBF_RECORDS Of 'FOXBIN2PRG.PRG'
                Store .Null. To loIndexes, loFields, loRecords
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_TABLE_I)) == C_TABLE_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBF_TABLE Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_TABLE_F $ tcLine && Fin
                                    Exit

                                Case C_CDX_F $ tcLine   && End of index file, temporary ignore
                                    Loop

                                Case Not llFieldsEvaluated And C_FIELDS_I $ tcLine
                                    loFields    = ._Fields
                                    loFields.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llFieldsEvaluated   = .T.

* new style, multiple index files
                                Case Not llIndexesEvaluated And C_CDXIDX_I $ tcLine
                                    loIndexes   = ._Indexes
                                    loIndexes.analyzeIndexFilesBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llIndexesEvaluated  = .T.

                                Case Not llIndexesEvaluated And C_INDEXES_I $ tcLine
                                    loIndexes   = ._Indexes
                                    loIndexes.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                                    llIndexesEvaluated  = .T.

                                Case C_RECORDS_I $ tcLine
                                    If llFieldsEvaluated
* Pensado para poder llamar a este método 2 veces:
* > La 1ra.para evaluar Campos e Indices, y poder crear la estructura de la tabla
*   al finalizar este paso.
* > La 2da.para cargar los registros, luego de que se haya creado la tabla,
*   así se van volcando directamente y no se guardan en memoria.
                                        Exit
                                    Endif

                                    loRecords   = ._Records
*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF
                                    loRecords.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, ._Fields, @toFoxBin2Prg,;
                                        tl_DBF_BinChar_Base64, tl_DBF_IncludeDeleted )
*!* /Changed by: LScheffler 21.02.2021
                                Otherwise   && Otro valor
*-- Estructura a reconocer:
*   <tagname>ID<tagname>
                                    lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                                    lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                                    .AddProperty( '_' + lcPropName, lcValue )
                            Endcase
                        Endfor

                        ._I = m.I
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', PropName=[' + Transform(lcPropName) + '], Value=[' + Transform(lcValue) + ']'
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loIndexes, loFields, loRecords
                Release lcPropName, lcValue, loFields, loIndexes, loRecords

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_FileTypeDesc           (v! IN    ) Tipo de archivo (en Hex)
* tl_FileHasCDX             (v! IN    ) Indica si el archivo tiene CDX asociado
* tl_FileHasMemo            (v! IN    ) Indica si el archivo tiene MEMO (FPT) asociado
* tl_FileIsDBC              (v! IN    ) Indica si el archivo es un DBC
* tc_DBC_Name               (v! IN    ) Nombre del DBC (si tiene)
* tc_InputFile              (v! IN    ) Nombre del archivo de salida
* tc_FileTypeDesc           (v! IN    ) Descripción del Tipo de archivo
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters tn_HexFileType, tl_FileHasCDX, tl_FileHasMemo, tl_FileIsDBC, tc_DBC_Name, tc_InputFile, tc_FileTypeDesc, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, lcIndexKey, lcIndexFile, laConfig(1), lcValue, lcConfigItem ;
                    , lc_DBF_Conversion_Order, lc_DBF_Conversion_Condition, lc_DBF_IndexList, llExportData, laDirFile(1,5), lnFileCount ;
                    , loEx As Exception ;
                    , loFSO As Scripting.FileSystemObject ;
                    , loTextStream As Scripting.TextStream ;
                    , loDBF_CFG As CL_DBF_CFG Of 'FOXBIN2PRG.PRG' ;
                    , loRecords As CL_DBF_RECORDS Of 'FOXBIN2PRG.PRG' ;
                    , loFields As CL_DBF_FIELDS Of 'FOXBIN2PRG.PRG' ;
                    , loIndexes As CL_DBF_INDEXES Of 'FOXBIN2PRG.PRG', ln_DBF_Conversion_Support

*** DH 06/02/2014: created variables
                Local laFields[1], lnFieldCount
                loFSO           = toFoxBin2Prg.o_FSO
                loTextStream    = toFoxBin2Prg.o_TextStream
                Store .Null. To loIndexes, loFields, loRecords
                Store 0 To lnFileCount
                lcText  = ''

                TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<>>
                <<C_TABLE_I>>
                <<chr(9)>><MemoFile><<IIF( tl_FileHasMemo, FORCEEXT(tc_InputFile, 'FPT'), '' )>></MemoFile>
                <<chr(9)>><CodePage><<Cpdbf('TABLABIN')>></CodePage>
                <<chr(9)>><LastUpdate><<IIF( toFoxBin2Prg.l_ClearDBFLastUpdate, '', LUPDATE('TABLABIN') )>></LastUpdate>
                <<chr(9)>><Database><<tc_DBC_Name>></Database>
                <<chr(9)>><FileType><<TRANSFORM(tn_HexFileType, '@0')>></FileType>
                <<chr(9)>><FileType_Descrip><<tc_FileTypeDesc>></FileType_Descrip>
                ENDTEXT

*-- Fields
                loFields    = This._Fields

*** DH 06/02/2014: passed variables to toText
                lcText      = lcText + loFields.toText(@laFields, @lnFieldCount, @toFoxBin2Prg)

*-- If table CFG exists, use it for DBF-specific configuration. FDBOZZO. 2014/06/15
                lnFileCount = toFoxBin2Prg.get_DBF_Configuration( Forceext(tc_InputFile, 'DBF'), @loDBF_CFG, .T. )

                ln_DBF_Conversion_Support = Iif(Isnull(loDBF_CFG), toFoxBin2Prg.n_DBF_Conversion_Support, loDBF_CFG.n_DBF_Conversion_Support )

                Do Case
                    Case Inlist(ln_DBF_Conversion_Support, 4, 8)
*-- Si hay un archivo DBF.CFG, manda sobre la configuración general
                        llExportData        = .T.

                    Case ln_DBF_Conversion_Support > 0
*-- Si hay un archivo DBF.CFG, manda sobre la configuración general
* Asume llExportData=.F.

*!*                     Case Inlist(toFoxBin2Prg.n_DBF_Conversion_Support, 4, 8)    && BIN2TXT (DATA EXPORT FOR DIFF)
*!*                         llExportData        = .T.

                    Otherwise
* Asume llExportData=.F.

                Endcase

* LScheffler 18.03.2021 added handling DBF_IndexList:
                If lnFileCount = 1
                    lc_DBF_IndexList = loDBF_CFG.DBF_IndexList
                    If Not Empty(lc_DBF_IndexList)
                        toFoxBin2Prg.writeLog('  > Using non structural index files: ' + lc_DBF_IndexList)
                    Endif

                Endif

* LScheffler 18.03.2021 moved index to get Settings per DBF
*-- Indexes
                loIndexes   = This._Indexes
                lcText      = lcText + loIndexes.toText( '', '', tc_InputFile, @toFoxBin2Prg, lc_DBF_IndexList)
* /LScheffler 18.03.2021

* setting temporary order
                If llExportData Then
                    If lnFileCount = 1
                        lc_DBF_Conversion_Order     = loDBF_CFG.DBF_Conversion_Order

                        If Not Empty(lc_DBF_Conversion_Order)
                            lcIndexFile = Forceext(tc_InputFile,'IDX')
                            Index On &lc_DBF_Conversion_Order. To (lcIndexFile) Compact
                            toFoxBin2Prg.writeLog('  > Using Index order key:            ' + lc_DBF_Conversion_Order)
                        Endif
* LScheffler 18.03.2021 added handling DBF_Conversion_Condition:
                        lc_DBF_Conversion_Condition = loDBF_CFG.DBF_Conversion_Condition
                        If Not Empty(lc_DBF_Conversion_Condition)
                            toFoxBin2Prg.writeLog('  > Using Conversion Condition:       ' + lc_DBF_Conversion_Condition)
                        Endif
* /LScheffler 18.03.2021

                    Endif
                Endif
* /setting temporary order

*** DH 06/02/2014: added _Records
                If llExportData
                    loRecords   = This._Records
*FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
                    loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF
                    loRecords.toText(@laFields, lnFieldCount, lc_DBF_Conversion_Condition, @toFoxBin2Prg,;
                        IIF( m.lnFileCount = 1, Nvl( m.loDBF_CFG.l_DBF_BinChar_Base64, m.toFoxBin2Prg.l_DBF_BinChar_Base64 ), m.toFoxBin2Prg.l_DBF_BinChar_Base64 ),;
                        IIF( m.lnFileCount = 1, Nvl( m.loDBF_CFG.l_DBF_IncludeDeleted, m.toFoxBin2Prg.l_DBF_IncludeDeleted ), m.toFoxBin2Prg.l_DBF_IncludeDeleted ))
*!* /Changed by: LScheffler 21.02.2021
                    lcText  = ''
                Endif

                TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<C_TABLE_F>>
                <<>>
                ENDTEXT

*FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
                loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
                lcText  = ''


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
* remove temporary order
                If Not Empty(lcIndexFile) And File(lcIndexFile)
                    Set Index To
                    Erase (lcIndexFile)
                Endif
* /remove temporary order

                Store .Null. To loIndexes, loFields, loRecords, loDBF_CFG, loTextStream
                Release loFields, loIndexes, loRecords, loDBF_CFG, loTextStream
        Endtry

        Return lcText
    Endproc


Enddefine



Define Class CL_DBF_FIELDS As CL_COL_BASE
    #If .F.
        Local This As CL_DBF_FIELDS Of 'FOXBIN2PRG.PRG'
    #Endif



    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception ;
                    , loField As CL_DBF_FIELD Of 'FOXBIN2PRG.PRG' ;
                    , loIndex As CL_DBF_INDEX Of 'FOXBIN2PRG.PRG'
                Store .Null. To loIndex, loField
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_FIELDS_I)) == C_FIELDS_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBF_FIELDS Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_FIELDS_F $ tcLine    && Fin
                                    Exit

                                Case C_FIELD_I $ tcLine
                                    loField = .Null.
                                    loField = Createobject("CL_DBF_FIELD")
                                    loField.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )
                                    .Add( loField, loField._Name )

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loIndex, loField
                Release lcPropName, lcValue, loField, loIndex

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taFields                  (@?    OUT) Array de información de campos
* tnField_Count             (@?    OUT) Cantidad de campos
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
*---------------------------------------------------------------------------------------------------
        Lparameters taFields, tnField_Count, toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        External Array taFields

        Try
                Local I, lcText, loEx As Exception ;
                    , loField As CL_DBF_FIELD Of 'FOXBIN2PRG.PRG'
                Store .Null. To loField
                lcText  = ''
                Dimension taFields(1,18)

                TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<>>
                <<Chr(9)>><<C_FIELDS_I>>
                ENDTEXT

                tnField_Count   = Afields(taFields)
                loField         = Createobject('CL_DBF_FIELD')

                For I = 1 To tnField_Count
                    If taFields(m.I,17) > 0 And toFoxBin2Prg.n_ExcludeDBFAutoincNextval = 1
*-- If AutoIncNextVal is excluded from text, then assign 1 for allowing regeneration
*-- of DBF with this field.
                        taFields(m.I,17)    = 1
                    Endif

                    lcText  = lcText + loField.toText( @taFields, m.I )
                Endfor

                TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>><<C_FIELDS_F>>
                <<>>
                ENDTEXT


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField
                Release I, loField

        Endtry

        Return lcText
    Endproc


Enddefine



Define Class CL_DBF_FIELD As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_DBF_FIELD Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="_type" display="_Type"/>] ;
        + [<memberdata name="_width" display="_Width"/>] ;
        + [<memberdata name="_decimals" display="_Decimals"/>] ;
        + [<memberdata name="_null" display="_Null"/>] ;
        + [<memberdata name="_nocptran" display="_NoCPTran"/>] ;
        + [<memberdata name="_field_valid_exp" display="_Field_Valid_Exp"/>] ;
        + [<memberdata name="_field_valid_text" display="_Field_Valid_Text"/>] ;
        + [<memberdata name="_field_default_value" display="_Field_Default_Value"/>] ;
        + [<memberdata name="_table_valid_exp" display="_Table_Valid_Exp"/>] ;
        + [<memberdata name="_table_valid_text" display="_Table_Valid_Text"/>] ;
        + [<memberdata name="_longtablename" display="_LongTableName"/>] ;
        + [<memberdata name="_ins_trig_exp" display="_Ins_Trig_Exp"/>] ;
        + [<memberdata name="_upd_trig_exp" display="_Upd_Trig_Exp"/>] ;
        + [<memberdata name="_del_trig_exp" display="_Del_Trig_Exp"/>] ;
        + [<memberdata name="_tablecomment" display="_TableComment"/>] ;
        + [<memberdata name="_autoinc_nextval" display="_AutoInc_NextVal"/>] ;
        + [<memberdata name="_autoinc_step" display="_AutoInc_Step"/>] ;
        + [</VFPData>]


*-- Field Info
    _Name                   = ''    &&  1
    _Type                   = ''    &&  2
    _Width                  = 0     &&  3
    _Decimals               = 0     &&  4
    _Null                   = .F.   &&  5
    _NoCPTran               = .F.   &&  6
    _Field_Valid_Exp        = ''    &&  7   - DBC
    _Field_Valid_Text       = ''    &&  8   - DBC
    _Field_Default_Value    = ''    &&  9   - DBC
    _Table_Valid_Exp        = ''    && 10   - DBC
    _Table_Valid_Text       = ''    && 11   - DBC
    _LongTableName          = ''    && 12   - DBC
    _Ins_Trig_Exp           = ''    && 13   - DBC
    _Upd_Trig_Exp           = ''    && 14   - DBC
    _Del_Trig_Exp           = ''    && 15   - DBC
    _TableComment           = ''    && 16   - DBC
    _AutoInc_NextVal        = 0     && 17
    _AutoInc_Step           = 0     && 18



    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_FIELD_I)) == C_FIELD_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBF_FIELD Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_FIELD_F $ tcLine && Fin
                                    Exit

                                Otherwise   && Propiedad de FIELD
*-- Estructura a reconocer:
*   <name>NOMBRE</name>
                                    lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                                    lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                                    .AddProperty( '_' + lcPropName, lcValue )
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
* taFields                  (!@ IN    ) Array de información de campos
* I                         (!@ IN    ) Campo en evaluación
*---------------------------------------------------------------------------------------------------
        Lparameters taFields, I

        External Array taFields

        Try
                Local lcText, loEx As Exception
                lcText  = ''

                TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<chr(9)+chr(9)>><<C_FIELD_I>>
                <<chr(9)+chr(9)+chr(9)>><Name><<taFields(m.I,1)>></Name>
                <<chr(9)+chr(9)+chr(9)>><Type><<taFields(m.I,2)>></Type>
                <<chr(9)+chr(9)+chr(9)>><Width><<taFields(m.I,3)>></Width>
                <<chr(9)+chr(9)+chr(9)>><Decimals><<taFields(m.I,4)>></Decimals>
                <<chr(9)+chr(9)+chr(9)>><Null><<taFields(m.I,5)>></Null>
                <<chr(9)+chr(9)+chr(9)>><NoCPTran><<taFields(m.I,6)>></NoCPTran>
                <<chr(9)+chr(9)+chr(9)>><Field_Valid_Exp><<taFields(m.I,7)>></Field_Valid_Exp>
                <<chr(9)+chr(9)+chr(9)>><Field_Valid_Text><<taFields(m.I,8)>></Field_Valid_Text>
                <<chr(9)+chr(9)+chr(9)>><Field_Default_Value><<taFields(m.I,9)>></Field_Default_Value>
                <<chr(9)+chr(9)+chr(9)>><Table_Valid_Exp><<taFields(m.I,10)>></Table_Valid_Exp>
                <<chr(9)+chr(9)+chr(9)>><Table_Valid_Text><<taFields(m.I,11)>></Table_Valid_Text>
                <<chr(9)+chr(9)+chr(9)>><LongTableName><<taFields(m.I,12)>></LongTableName>
                <<chr(9)+chr(9)+chr(9)>><Ins_Trig_Exp><<taFields(m.I,13)>></Ins_Trig_Exp>
                <<chr(9)+chr(9)+chr(9)>><Upd_Trig_Exp><<taFields(m.I,14)>></Upd_Trig_Exp>
                <<chr(9)+chr(9)+chr(9)>><Del_Trig_Exp><<taFields(m.I,15)>></Del_Trig_Exp>
                <<chr(9)+chr(9)+chr(9)>><TableComment><<taFields(m.I,16)>></TableComment>
                <<chr(9)+chr(9)+chr(9)>><Autoinc_Nextval><<taFields(m.I,17)>></Autoinc_Nextval>
                <<chr(9)+chr(9)+chr(9)>><Autoinc_Step><<taFields(m.I,18)>></Autoinc_Step>
                <<chr(9)+chr(9)>><<C_FIELD_F>>
                ENDTEXT


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return lcText
    Endproc


Enddefine



Define Class CL_DBF_INDEXES As CL_COL_BASE
    #If .F.
        Local This As CL_DBF_INDEXES Of 'FOXBIN2PRG.PRG'
    #Endif

* LScheffler
    Procedure analyzeIndexFilesBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, loEx As Exception

                If Left(tcLine, Len(C_CDXIDX_I)) == C_CDXIDX_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBF_INDEXES Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_CDXIDX_F $ tcLine    && Fin
                                    Exit

                                Case C_CDX_I $ tcLine
                                    .analyzeIndexFileBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines )

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally

        Endtry

        Return llBloqueEncontrado
    Endproc &&analyzeIndexFilesBlock


    Procedure analyzeIndexFileBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines

        Try
                Local llBloqueEncontrado, loEx As Exception
                Local lcFile As String, llStandAlone As Boolean

                If Left(tcLine, Len(C_CDX_I)) == C_CDX_I
                    llBloqueEncontrado  = .T.

                    lcFile       = Strextract(m.tcLine,C_CDX_File_,'"',1)
                    llStandAlone = Strextract(m.tcLine,C_CDX_Type_,'"',1) == C_CDX_Type_IDX
                    With This As CL_DBF_INDEXES Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_CDX_F $ tcLine   && Fin
                                    Exit

                                Case C_INDEXES_I $ tcLine
                                    .analyzeCodeBlock( @tcLine, @taCodeLines, @I, m.tnCodeLines, m.lcFile, m.llStandAlone )

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally

        Endtry

        Return llBloqueEncontrado
    Endproc &&analyzeIndexFileBlock
* /LScheffler

    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, tcIndexFile, tlStandAlone

        Try
                Local llBloqueEncontrado, loEx As Exception ;
                    , loIndex As CL_DBF_INDEX Of 'FOXBIN2PRG.PRG'
                Store .Null. To loIndex

                If Left(tcLine, Len(C_INDEXES_I)) == C_INDEXES_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBF_INDEXES Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_INDEXES_F $ tcLine   && Fin
                                    Exit

                                Case C_INDEX_I $ tcLine
                                    loIndex = .Null.
                                    loIndex = Createobject("CL_DBF_INDEX")
                                    loIndex.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, tcIndexFile, tlStandAlone )
                                    .Add( loIndex, loIndex._TagName )

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loIndex
                Release loIndex

        Endtry

        Return llBloqueEncontrado
    Endproc


* LScheffler proc wrapping index
    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* taTagInfo                 (@?    OUT) Array de información de indices
* tnTagInfo_Count           (@?    OUT) Cantidad de índices
* tc_InputFile              (v! IN    ) Archivo de entrada (el DBF)
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
* tc_DBF_IndexList          (?  IN    ) comm a delimited list of non structuiral index files
*---------------------------------------------------------------------------------------------------
        Lparameters taTagInfo, tnTagInfo_Count, tc_InputFile, toFoxBin2Prg, tc_DBF_IndexList

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        External Array taTagInfo

        Try
                Local I, lcText, loEx As Exception ;
                    , loIndex As CL_DBF_INDEX Of 'FOXBIN2PRG.PRG' ;
                    loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
                Store .Null. To loIndex
                lcText  = ''
                Dimension taTagInfo(1,6)

                Local;
                    lcText As String,;
                    loIndex As "CL_DBF_INDEX"

                Local Array;
                    taTagInfo (1,6)
                Local;
                    lcIndexFile As String,;
                    lcIndexType As String

                loLang          = _Screen.o_FoxBin2Prg_Lang
                toFoxBin2Prg.writeLog( Replicate('+', 100) )
                toFoxBin2Prg.writeLog( loLang.C_INDEX2TXT_PROCESSING_LOC )


*!* Changed by: LScheffler 18.3.2021
*!* <pdm>
*!* <change date="{^2021-03-18,10:34:00}">Changed by: LScheffler<br />
*!* Standalone index <em>tc_InputFile.IDX</em> will be included if <em>DBF_Conversion_Order</em> is activated
*!* use only tags of structural compound index file
*!* </change>
*!* </pdm>
                lcIndexFile = Juststem( Dbf() ) + '.CDX'

*               If Tagcount() > 0
                If Tagcount( m.lcIndexFile ) > 0
                    lcIndexType = C_CDX_Type_Struct
                    toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )
                    toFoxBin2Prg.writeLog( '  ' + m.lcIndexType )
                    TEXT To m.lcText Additive Textmerge Noshow Flags 1+2 Pretext 1+2
                    <<>>
                    <<chr(9)+chr(9)>><<C_CDX_I>> <<C_CDX_Type_>><<m.lcIndexType>>" >
                    <<>>
                    <<chr(9)+chr(9)+chr(9)>><<C_INDEXES_I>>
                    ENDTEXT

*                   tnTagInfo_Count = Ataginfo( taTagInfo )
                    tnTagInfo_Count = Ataginfo( taTagInfo, m.lcIndexFile )

*!* /Changed by: LScheffler 18.3.2021
                    Asort( m.taTagInfo, 1, -1, 0, 1 )
                    loIndex         = Createobject("CL_DBF_INDEX")

                    For I = 1 To m.tnTagInfo_Count
                        lcText  = m.lcText + m.loIndex.toText( @taTagInfo, m.I )
                    Endfor

                    TEXT To m.lcText Additive Textmerge Noshow Flags 1+2 Pretext 1+2
                    <<chr(9)+chr(9)+chr(9)>><<C_INDEXES_F>>
                    <<chr(9)+chr(9)>><<C_CDX_F>>
                    <<>>
                    ENDTEXT
                Endif

                If ! Empty( m.tc_DBF_IndexList ) And Vartype( m.tc_DBF_IndexList ) = 'C' Then
                    Local Array;
                        laIndexFiles( 1 )

                    toFoxBin2Prg.writeLog( ' ' + Replicate('-', 98) )
                    toF1oxBin2Prg.writeLog( loLang.C_INDEX2TXT_EXTRAFILES_LOC )
                    toFoxBin2Prg.writeLog( ' ' + Replicate('- ', 49) )

*Additional index files
                    Alines( laIndexFiles, m.tc_DBF_IndexList ,5 , ',' )
                    For Each lcIndexFile In laIndexFiles
                        Try
                                lcIndexFile = Sys(2014, ''+m.lcIndexFile, Addbs(Justpath(tc_InputFile) ) )
                                lcIndexType = Substr(Filetostr(m.lcIndexFile),5,4)
                                lcIndexType = Iif( m.lcIndexType = 0hFFFFFFFF, C_CDX_Type_IDX, C_CDX_Type_Compound )
                                toFoxBin2Prg.writeLog( '   '+m.lcIndexType + ' ' + m.lcIndexFile )
                                Set Index To ( m.lcIndexFile )
                                If Tagcount( m.lcIndexFile ) > 0 Then
                                    lnTagInfo_Count = Ataginfo( taTagInfo , m.lcIndexFile )
                                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                                    <<>>
                                    <<+chr(9)+chr(9)>><<C_CDX_I>> <<C_CDX_Type_>><<m.lcIndexType+'"'>> <<C_CDX_File_>><<m.lcIndexFile+'"'>> >
                                    <<>>
                                    <<+chr(9)+chr(9)+chr(9)>><<C_INDEXES_I>>
                                    ENDTEXT

                                    lnTagInfo_Count = Ataginfo( laTagInfo , m.lcIndexFile)
                                    Asort( laTagInfo, 1, -1, 0, 1 )
                                    loIndex         = Createobject("CL_DBF_INDEX")

                                    For I = 1 To lnTagInfo_Count
                                        lcText  = lcText + loIndex.toText( @laTagInfo, m.I )
                                    Endfor

                                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                                    <<+chr(9)+chr(9)+chr(9)>><<C_INDEXES_F>>
                                    <<+chr(9)+chr(9)>><<C_CDX_F>>
                                    <<>>
                                    ENDTEXT
                                Endif &&TAGCOUNT( m.lcIndexFile ) > 0

                            Catch To m.loEx When m.loEx.ErrorNo = 1
*File Not found
                                toFoxBin2Prg.writeLog( loLang.C_INDEX2TXT_NOFILE_LOC + m.lcIndexFile)

                            Catch To m.loEx When m.loEx.ErrorNo=114
*INDEX does not match
                                toFoxBin2Prg.writeLog( loLang.C_INDEX2TXT_NOTTHISTABLE_LOC + m.lcIndexFile)

                            Catch To m.loEx
                                If This.n_Debug > 0 And _vfp.StartMode = 0
                                    Set Step On
                                Endif

                                Throw

                            Finally
                                Store .Null. To m.loIndex
                                Release I, m.loIndex

                        Endtry
                    Endfor &&lcIndexFile
                Endif &&! EMPTY(toFoxBin2Prg.a_InputFiles)

                If !Empty(m.lcText) Then
                    TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)>><<C_CDXIDX_I>><<m.lcText>>
                    <<Chr(9)>><<C_CDXIDX_F>>
                    ENDTEXT
                Endif &&!EMPTY(m.lcText)

                toFoxBin2Prg.writeLog( Replicate('+', 100)+CR_LF )
* /LScheffler

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loIndex
                Release I, loIndex

        Endtry

        Return lcText
    Endproc

Enddefine



Define Class CL_DBF_INDEX As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_DBF_INDEX Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_indexfile" display="_IndexFile"/>] ;
        + [<memberdata name="_standalone" display="_StandAlone"/>] ;
        + [<memberdata name="_tagname" display="_TagName"/>] ;
        + [<memberdata name="_tagname" display="_TagName"/>] ;
        + [<memberdata name="_tagtype" display="_TagType"/>] ;
        + [<memberdata name="_key" display="_Key"/>] ;
        + [<memberdata name="_filter" display="_Filter"/>] ;
        + [<memberdata name="_order" display="_Order"/>] ;
        + [<memberdata name="_collate" display="_Collate"/>] ;
        + [</VFPData>]


*-- Index Info
    _IndexFile      = ''
    _StandAlone     = .F.
    _TagName        = ''
    _TagType        = ''
    _Key            = ''
    _Filter         = ''
    _Order          = ''
    _Collate        = ''


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, tcIndexFile, tlStandAlone

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
                Store '' To lcPropName, lcValue

                If Left(tcLine, Len(C_INDEX_I)) == C_INDEX_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBF_INDEX Of 'FOXBIN2PRG.PRG'
                        ._IndexFile      = Evl( m.tcIndexFile, '')
                        ._StandAlone     = m.tlStandAlone

                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_INDEX_F $ tcLine && Fin
                                    Exit

                                Otherwise   && Propiedad de INDEX
*-- Estructura a reconocer:
*   <name>NOMBRE</name>
                                    lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                                    lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                                    .AddProperty( '_' + lcPropName, lcValue )
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
* taTagInfo                 (@! IN    ) Array de información de indices
* I                         (@! IN    ) Indice en evaluación
*---------------------------------------------------------------------------------------------------
        Lparameters taTagInfo, I

        External Array taTagInfo

        Try
                Local X, lcText, loEx As Exception
                lcText  = ''

                For m.X = 1 To Alen(taTagInfo,1)
                    If Tag(m.X) == taTagInfo(m.I,1) Then
                        Exit
                    Endif
                Endfor

                TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<chr(9)+chr(9)+chr(9)+chr(9)>><<C_INDEX_I>>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><TagName><<taTagInfo(m.I,1)>></TagName>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><TagType><<ICASE(LEFT(taTagInfo(m.I,2),3)='BIN','BINARY',PRIMARY(m.X),'PRIMARY',CANDIDATE(m.X),'CANDIDATE',UNIQUE(m.X),'UNIQUE','REGULAR'))>></TagType>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Key><<taTagInfo(m.I,3)>></Key>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Filter><<taTagInfo(m.I,4)>></Filter>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Order><<IIF(DESCENDING(m.X), 'DESCENDING', 'ASCENDING')>></Order>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Collate><<taTagInfo(m.I,6)>></Collate>
                <<chr(9)+chr(9)+chr(9)+chr(9)>><<C_INDEX_F>>
                ENDTEXT

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return lcText
    Endproc


Enddefine

*** DH 06/02/2014: added classes CL_DBF_RECORDS and CL_DBF_RECORD


Define Class CL_DBF_RECORDS As CL_COL_BASE
    #If .F.
        Local This As CL_DBF_RECORDS Of 'FOXBIN2PRG.PRG'
    #Endif



    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (!=Obligatorio | ?=Opcional) (@=Pasar por referencia | v=Pasar por valor) (IN/OUT)
* tcLine                    (@! IN/OUT) Contenido de la línea en análisis
* taCodeLines               (@! IN    ) Array de líneas del programa analizado
* I                         (@! IN/OUT) Número de línea en análisis
* tnCodeLines               (@! IN    ) Cantidad de líneas del programa analizado
* toFields                  (@! IN    ) Estructura de los campos
* toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
* tl_DBF_BinChar_Base64     out of settings (folder or per-file) Transform NocPTrans fields base64
* tl_DBF_IncludeDeleted     out of settings (folder or per-file) Include deleted records
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toFields, toFoxBin2Prg, tl_DBF_BinChar_Base64, tl_DBF_IncludeDeleted

        #If .F.
            Local toFields As CL_DBF_FIELDS Of 'FOXBIN2PRG.PRG'
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcPropName, lcValue, lcAlias, loEx As Exception ;
                    , loRecord As CL_DBF_RECORD Of 'FOXBIN2PRG.PRG' ;
                    , loRecordData As Object
                Store .Null. To loIndex
                Store '' To lcPropName, lcValue, lcAlias

                If Left(tcLine, Len(C_RECORDS_I)) == C_RECORDS_I
                    llBloqueEncontrado  = .T.

                    With This As CL_DBF_RECORDSS Of 'FOXBIN2PRG.PRG'
                        lcAlias     = Alias()
                        CursorSetProp("Buffering", 3)
                        loRecord    = .Null.
                        loRecord    = Createobject("CL_DBF_RECORD")

                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case C_RECORDS_F $ tcLine   && Fin
                                    Exit

                                Case '<RECORD' $ tcLine
                                    Append Blank

                                    loRecord.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, @toFields, tl_DBF_BinChar_Base64 )

                                    If Mod(m.I,1000) = 0 Then
                                        toFoxBin2Prg.updateProgressbar( 'Importing DBF Data... ' + Transform(m.I) + '/' + Transform(tnCodeLines) + '', 1+(m.I/tnCodeLines), 3, 2 )
                                        DoEvents
*FFLUSH( toFoxBin2Prg.n_FileHandle, .T. )
                                    Endif

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF, handle include of deleted records
*!* /Changed by: LScheffler 21.02.2021
                                Case m.tl_DBF_IncludeDeleted And '<DELRECORD' $ tcLine
                                    Append Blank
                                    loRecord.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, @toFields, tl_DBF_BinChar_Base64 )

                                    Delete

                                    If Mod(m.I,1000) = 0 Then
                                        toFoxBin2Prg.updateProgressbar( 'Importing DBF Data... ' + Transform(m.I) + '/' + Transform(tnCodeLines) + '', 1+(m.I/tnCodeLines), 3, 2 )
                                        DoEvents
*FFLUSH( toFoxBin2Prg.n_FileHandle, .T. )
                                    Endif
*!* /Changed by: LScheffler 21.02.2021

                                Otherwise   && Otro valor
*-- No hay otros valores
                            Endcase
                        Endfor

                        Tableupdate(.T.)
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Tablerevert(.T.)
                CursorSetProp("Buffering", 1)

                Store .Null. To loRecord
                Release lcPropName, lcValue, loRecord

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:                   (!=Obligatorio | ?=Opcional) (@=Pasar por referencia | v=Pasar por valor) (IN/OUT)
* taFields                      (@! IN    ) Array de información de campos
* tnField_Count                 (v! IN    ) Cantidad de campos
* tc_DBF_Conversion_Condition   (v? IN    ) Condición de filtro para la conversión. Solo se exporta lo que la cumpla.
* toFoxBin2Prg                  (@! IN    ) Referencia de toFoxBin2Prg
* tl_DBF_BinChar_Base64         out of settings (folder or per-file) Transform NocPTrans fields base64
* tl_DBF_IncludeDeleted         out of settings (folder or per-file) Include deleted records
*---------------------------------------------------------------------------------------------------
        Lparameters taFields, tnField_Count, tc_DBF_Conversion_Condition, toFoxBin2Prg, tl_DBF_BinChar_Base64, tl_DBF_IncludeDeleted

        External Array taFields

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Try
                Local lcText, loEx As Exception, I, lnReccount ;
                    , loRecord As CL_DBF_RECORD Of 'FOXBIN2PRG.PRG' ;
                    , loTextStream As Scripting.TextStream
                Local lcOldDeleted As String

                lcText      = ''
                I           = 0
                lnReccount  = Reccount()    && Realmente no es muy exacto, pero al menos muestra el avance.
                loTextStream    = toFoxBin2Prg.o_TextStream

                TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<>>
                <<Chr(9)>><<C_RECORDS_I>>
                ENDTEXT

*FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
                loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
                lcText  = ''
                loRecord = Createobject('CL_DBF_RECORD')

                If Empty(tc_DBF_Conversion_Condition)
                    tc_DBF_Conversion_Condition = '.T.'
                Endif

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF, handle include of deleted records
                lcOldDeleted = Set("Deleted")
                If m.tl_DBF_IncludeDeleted Then
                    Set Deleted Off
                Endif
*!* /Changed by: LScheffler 21.02.2021

*!* Changed by: LScheffler 01.03.2021
*!* change date="{^2021-03-01,12:45:00}"
* failure with macro substitution<br/>
* for wharever reason, macro substitution failed
* EVALUATE() should do
*               Scan For &tc_DBF_Conversion_Condition.
                Scan For Evaluate(m.tc_DBF_Conversion_Condition)
*!* /Changed by: LScheffler 01.03.2021

                    I   = m.I + 1

                    lcText  = loRecord.toText(@taFields, tnField_Count, tl_DBF_BinChar_Base64 )

*FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
                    loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
                    If Mod(m.I,100) = 0 Or Len(lcText) > 8*1024 Then
                        toFoxBin2Prg.updateProgressbar( 'Exporting DBF Data... ' + Transform(m.I) + '/' + Transform(lnReccount) + '', 1+(m.I/lnReccount), 3, 2 )
                        DoEvents
*FFLUSH( toFoxBin2Prg.n_FileHandle, .T. )
                    Endif
                Endscan
                Set Deleted &lcOldDeleted.

                toFoxBin2Prg.updateProgressbar( 'Data exported! ', 1+(lnReccount/lnReccount), 3, 2 )
                lcText  = ''

                TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>><<C_RECORDS_F>>
                <<>>
                ENDTEXT

*FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
                loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
                lcText  = ''


            Catch To loEx
                loEx.UserValue = loEx.UserValue + 'tc_DBF_Conversion_Condition = [' + Transform(tc_DBF_Conversion_Condition) + ']' + CR_LF
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loRecord, loTextStream
                Release loRecord, loTextStream

        Endtry

        Return lcText
    Endproc


    Procedure set_Line
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@    OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (v! IN    ) Número de línea en análisis
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I
        tcLine  = taCodeLines(m.I)
    Endproc


Enddefine



Define Class CL_DBF_RECORD As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_DBF_RECORD Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [</VFPData>]


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (!=Obligatorio | ?=Opcional) (@=Pasar por referencia | v=Pasar por valor) (IN/OUT)
* tcLine                    (@! IN/OUT) Contenido de la línea en análisis
* taCodeLines               (@! IN    ) Array de líneas del programa analizado
* I                         (@! IN/OUT) Número de línea en análisis
* tnCodeLines               (@! IN    ) Cantidad de líneas del programa analizado
* toFields                  (@! IN    ) Estructura de los campos
* tl_DBF_BinChar_Base64     out of settings (folder or per-file) Transform NocPTrans fields base64
*---------------------------------------------------------------------------------------------------

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* general note:
* - added code to handle NoCPTrans coding with or without basr64, just like the flag 4096 of CURSORTOXML
* - added code parse out deleted records.
*   deleted records should only occur if calling method sends them, so we just accept

        Lparameters tcLine, taCodeLines, I, tnCodeLines, toFields, tl_DBF_BinChar_Base64

        #If .F.
            Local toFields As CL_DBF_FIELDS Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcFieldName, lcValue, luValue, llOneLineOnly, loEx As Exception ;
                    , loField As CL_DBF_FIELD Of 'FOXBIN2PRG.PRG'
                Store '' To lcFieldName, lcValue

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF, handle include of deleted records
* Note, the inclusion of records deleted is done in the method calling, so here it will just be read
                If '<RECORD' $ tcLine Or '<DELRECORD' $ tcLine
*!* /Changed by: LScheffler 21.02.2021
                    llBloqueEncontrado  = .T.

                    With This As CL_DBF_RECORD Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine ) Or Left(tcLine, 1) == '*'
                                    Loop

                                Case C_RECORD_F $ tcLine    && Fin
                                    Exit

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF, handle include of deleted records
* just end-of-record deleted
                                Case C_DEL_RECORD_F $ tcLine    && Fin
                                    Exit

*!* /Changed by: LScheffler 21.02.2021
                                Otherwise   && Campo de RECORD
*-- Estructura a reconocer:
*   <fieldName>VALOR</fieldName>
                                    lcFieldName     = Strextract( tcLine, '<', '>', 1, 0 )
                                    lcValue         = Strextract( tcLine, '<' + lcFieldName + '>', '</' + lcFieldName + '>', 1, 0+2 )
                                    loField         = toFields.Item(lcFieldName)
                                    llOneLineOnly   = ('</' + lcFieldName + '>' $ tcLine)

                                    lcFieldType     = loField._Type
                                    llNoCPTran      = Cast( loField._NoCPTran As Logical)
*!* Changed by: LScheffler 14.2.2021
*!* change date="{^2021-02-14,20:35:00}"
* Does not recreate .NULL. Field values
* CAST(.. does not tronsform ".NULL." to .NULL.
* so we test field for NULL flag and is cValue is ".NULL.", we use .NULL.

                                    llNull          = Cast( loField._Null As Logical)

                                    Do Case
                                        Case m.llNull And Upper(m.lcValue)=='.NULL.'        && .NULL.
                                            luValue = .Null.

*!* /Changed by: LScheffler 14.2.2021

                                        Case lcFieldType == 'L' && Logical (Boolean)
                                            luValue = Cast(lcValue As Logical)

                                        Case lcFieldType == 'G' && General (NOT SUPPORTED)
                                            luValue     = ''

                                        Case lcFieldType == 'W' && Blob (Memo binario)
                                            luValue     = Strconv(lcValue,14)

                                        Case lcFieldType == 'Q' && Varbinary
                                            luValue     = Strconv(lcValue,14)

                                        Case lcFieldType == 'V' && Varchar
                                            If llNoCPTran And m.tl_DBF_BinChar_Base64 Then
*-- If NoCPTran, then must encode in b64binary
*-- LScheffler: might, not must, see XMLTOCURSOR, flag 4096
                                                luValue     = Strconv(lcValue,14)
                                            Else
                                                luValue = .Decode(lcValue)
                                            Endif

                                        Case lcFieldType == 'M' && Memo
                                            If llNoCPTran And m.tl_DBF_BinChar_Base64 Then
*-- If NoCPTran, then must encode in b64binary
*--LScheffler: might, not must, see XMLTOCURSOR, flag 4096
                                                luValue     = Strconv(lcValue,14)
                                            Else
                                                If llOneLineOnly And Atc('<![CDATA[', lcValue) = 0
                                                    luValue = .Decode(lcValue, .F.)
                                                Else
* Si el memo es multi-línea, leer hasta encontrar el final ']]>' del CDATA.
                                                    luValue = ''
                                                    Do While Not Empty(lcValue)
                                                        If ']]>' $ tcLine Or '</' + lcFieldName + '>' $ tcLine Then
                                                            luValue = .Decode(lcValue, .T.)
                                                            Exit
                                                        Else
                                                            I = m.I + 1
                                                            .set_Line( @tcLine, @taCodeLines, m.I )
                                                            lcValue = lcValue + CR_LF + tcLine
                                                        Endif
                                                    Enddo
                                                Endif
                                            Endif

                                        Case lcFieldType == 'D' && Date
                                            luValue = Cast(lcValue As Date)

                                        Case lcFieldType == 'T' && Datetime
                                            luValue = Cast(lcValue As Datetime)

                                        Case lcFieldType == 'Y' && Currency
                                            luValue = Cast(lcValue As Currency)

                                        Case lcFieldType == 'I' && Integer
                                            luValue = Cast(lcValue As Integer)

                                        Case lcFieldType == 'B' && Double
                                            luValue = Cast(lcValue As Double)

                                        Case lcFieldType == 'F' && Float
                                            luValue = Cast(lcValue As Float)

                                        Case lcFieldType == 'N' && Numeric
                                            luValue = Cast(lcValue As Numeric)

                                        Otherwise   && Asume 'C'    && Character
                                            If llNoCPTran And m.tl_DBF_BinChar_Base64 Then
*-- If NoCPTran, then must encode in b64binary
*--LScheffler: might, not must, see XMLTOCURSOR, flag 4096

*-- If NoCPTran, then must encode in b64binary
                                                luValue     = Strconv(lcValue,14)
                                            Else
                                                luValue = .Decode(Rtrim(lcValue))
                                            Endif

                                    Endcase

                                    If lcFieldType == 'G'
*-- Saltar campos General
                                    Else
                                        Replace (lcFieldName) With (luValue)
                                    Endif

                            Endcase
                        Endfor
                    Endwith && THIS
                Endif

            Catch To loEx
                If loEx.ErrorNo = 1470  && Incorrect property name.
                    loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine) + ', lcFieldName=[' + Transform(lcFieldName) + '], Value=[' + Transform(lcValue) + ']'
                Endif

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loField
                Release loField

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (!=Obligatorio | ?=Opcional) (@=Pasar por referencia | v=Pasar por valor) (IN/OUT)
* taFields                  (@! IN    ) Array de información de campos
* tnField_Count             (@! IN    ) Cantidad de campos
* tl_DBF_BinChar_Base64     out of settings (folder or per-file) Transform NocPTrans fields base64
*---------------------------------------------------------------------------------------------------
* LScheffler, Analyse, calling method decides if deleted records will be included, we just process

*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* general note:
* - added code to handle NoCPTrans coding with or without base64, just like the flag 4096 of CURSORTOXML
        Lparameters taFields, tnField_Count, tl_DBF_BinChar_Base64

        External Array taFields

        Try
                Local I, lcText, loEx As Exception, lcField, luValue, lcFieldType, llNoCPTran
                Local lcStartTag, lcEndTag As String
                lcText  = ''

                With This As CL_DBF_RECORD Of 'FOXBIN2PRG.PRG'
*** FDBOZZO 2014/07/15: New "num" property invalidates the use of REGNUM field
*!* Changed by: LScheffler 21.02.2021
*!* change date="{^2021-02-21,10:57:00}"
* additional options controlling
* - new operations of DBF, handle include of deleted records
* Note: used in the TEXTEMERGEs for start and end tag below, not extra commented
                    If Deleted() Then
                        lcStartTag = C_DEL_RECORD_I
                        lcEndTag   = C_DEL_RECORD_F
                    Else
                        lcStartTag = C_RECORD_I
                        lcEndTag   = C_RECORD_F
                    Endif
*!* /Changed by: LScheffler 21.02.2021

                    TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)+Chr(9)>><<m.lcStartTag>>
                    ENDTEXT

                    For I = 1 To tnField_Count
                        lcField     = taFields[m.I, 1]
                        lcFieldType = taFields[m.I, 2]
                        llNoCPTran  = taFields[m.I, 6]
                        If lcFieldType == 'G'
*-- Saltar campos de tipo General
                        Else

                            luValue     = Evaluate("TABLABIN."+lcField)

                            Do Case
                                Case lcFieldType $ 'GWQVCM' And luValue == '' ; && Vacío
                                    Or lcFieldType $ 'DT' And luValue == {} ;
                                        OR lcFieldType $ 'YIBFN' And luValue == 0

                                Case lcFieldType == 'W' && Blob (Memo binario)
                                    luValue     = Strconv(luValue,13)

                                Case lcFieldType == 'Q' && Varbinary
                                    luValue     = Strconv(luValue,13)

                                Case lcFieldType == 'V' && Varchar
                                    If llNoCPTran And m.tl_DBF_BinChar_Base64 Then
*-- If NoCPTran, then must encode in b64binary
*-- LScheffler: might, not must, see XMLTOCURSOR, flag 4096
                                        luValue     = Strconv(luValue,13)
                                    Else
                                        luValue = .Encode(luValue)
                                    Endif

                                Case lcFieldType $ 'C'  && Character
                                    If llNoCPTran And m.tl_DBF_BinChar_Base64 Then
*-- If NoCPTran, then must encode in b64binary
*-- LScheffler: might, not must, see XMLTOCURSOR, flag 4096
                                        luValue     = Strconv(luValue,13)
                                    Else
                                        luValue = .Encode(Rtrim(luValue))
                                    Endif

                                Case lcFieldType $ 'M'  && Memo
                                    If llNoCPTran And m.tl_DBF_BinChar_Base64 Then
*-- If NoCPTran, then must encode in b64binary
*-- LScheffler: might, not must, see XMLTOCURSOR, flag 4096
                                        luValue     = Strconv(luValue,13)
                                    Else
*!* Changed by: LScheffler 07.4.2022
*!* <pdm>
*!* <change date="{^2022-04-07,15:11:00}">Changed by: LScheffler<br />
*!* https://github.com/fdbozzo/foxbin2prg/issues/81 / Trailing spaces are lost for memo fields converting dbf with including data.
*!* RTRIM removed trsiling spaces from memo
*!* </change>
*!* </pdm>
                                        luValue = .Encode(luValue, .T.)
                                    Endif

                            Endcase

*!* Changed by: LScheffler 07.4.2022
*!* TEXT .. ENDTEXT removes trailing spaces from lines inserted with TEXXTMERGE
*!* Char etc are processed special
                            If Vartype(luValue) = 'C'
                                lcText = lcText + CR_LF + Chr(9)+Chr(9)+Chr(9) + '<' + lcField + '>' + luValue + '</' + lcField + '>'
                            Else
                                TEXT TO lcText TEXTMERGE NOSHOW flags 1+2 PRETEXT 1+2 additive
                                <<Chr(9)+Chr(9)+Chr(9)>><<'<' + lcField + '>'>><<luValue>><<'</' + lcField + '>'>>
                                ENDTEXT
                            Endif
*!* /Changed by LScheffler 07.4.2022
                        Endif
                    Next

                    TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2 additive
                    <<Chr(9)+Chr(9)>><<m.lcEndTag>>
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


    Procedure Encode
        Lparameters tcString, tl_isCDATA
        Local lcString
        If tl_isCDATA Then
*lcString = '<![CDATA[' + STRTRAN(tcString, ']]>',   ']]]]><![CDATA[>') + ']]>'
            lcString = '<![CDATA[' + Strtran( Strtran( tcString, '<![CDATA[', '&lt;![CDATA['), ']]>', ']]&gt;') + ']]>'
        Else
            lcString = Strtran(tcString, '&',     '&amp;')
            lcString = Strtran(lcString, '>',     '&gt;')
            lcString = Strtran(lcString, '<',     '&lt;')
            lcString = Strtran(lcString, '"',     '&quot;')
            lcString = Strtran(lcString, "'",     '&#39;')
            lcString = Strtran(lcString, '/',     '&#47;')
            lcString = Strtran(lcString, Chr(13), '&#13;')
            lcString = Strtran(lcString, Chr(10), '&#10;')
            lcString = Strtran(lcString, Chr(9),  '&#9;')
        Endif
        Return lcString
    Endproc


    Procedure Decode
        Lparameters tcString, tl_isCDATA
        Local lcString
        If tl_isCDATA Then
            lcString = Strtran( Strtran( Strextract( tcString, '<![CDATA[', ']]>'), '&lt;![CDATA[', '<![CDATA['), ']]&gt;', ']]>')
        Else
            lcString = Strtran(tcString, '&#9;',   Chr(9))
            lcString = Strtran(lcString, '&#10;',  Chr(10))
            lcString = Strtran(lcString, '&#13;',  Chr(13))
            lcString = Strtran(lcString, '&#47;',  '/')
            lcString = Strtran(lcString, '&#39;',  "'")
            lcString = Strtran(lcString, '&quot;', '"')
            lcString = Strtran(lcString, '&lt;',   '<')
            lcString = Strtran(lcString, '&gt;',   '>')
            lcString = Strtran(lcString, '&amp;',  '&')
        Endif
        Return lcString
    Endproc


    Procedure set_Line
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@    OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (v! IN    ) Número de línea en análisis
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I
        tcLine  = taCodeLines(m.I)
    Endproc


Enddefine

*** DH 06/02/2014: end of added classes



Define Class CL_PROJ_SRV_HEAD As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_PROJ_SRV_HEAD Of 'FOXBIN2PRG.PRG'
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
            Local toServerData As CL_PROJ_SRV_DATA Of 'FOXBIN2PRG.PRG'
        #Endif

        With This As CL_PROJ_SRV_HEAD Of 'FOXBIN2PRG.PRG'
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
        Return Createobject('CL_PROJ_SRV_DATA')
    Endproc



    Procedure parseServerInfo
        Lparameters tcServerInfo

        If Not Empty(tcServerInfo)
            Try
                    Local loServerData As CL_PROJ_SRV_DATA Of 'FOXBIN2PRG.PRG'

                    With This As CL_PROJ_SRV_HEAD Of 'FOXBIN2PRG.PRG'
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
                    , loServerData As CL_PROJ_SRV_DATA Of 'FOXBIN2PRG.PRG'
                Store .Null. To loServerData
                lcStr               = ''

                With This As CL_PROJ_SRV_HEAD Of 'FOXBIN2PRG.PRG'
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
                    , loServerData As CL_PROJ_SRV_DATA Of 'FOXBIN2PRG.PRG'
                Store .Null. To loServerData
                lcText  = ''

                With This As CL_PROJ_SRV_HEAD Of 'FOXBIN2PRG.PRG'
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



Define Class CL_PROJ_SRV_DATA As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_PROJ_SRV_DATA Of 'FOXBIN2PRG.PRG'
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



Define Class CL_PROJ_FILE As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_PROJ_FILE Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="_comments" display="_Comments"/>] ;
        + [<memberdata name="_cpid" display="_CPID"/>] ;
        + [<memberdata name="_exclude" display="_Exclude"/>] ;
        + [<memberdata name="_id" display="_ID"/>] ;
        + [<memberdata name="_name" display="_Name"/>] ;
        + [<memberdata name="_objrev" display="_ObjRev"/>] ;
        + [<memberdata name="_timestamp" display="_Timestamp"/>] ;
        + [<memberdata name="_type" display="_Type"/>] ;
        + [<memberdata name="_user" display="_User"/>] ;
        + [<memberdata name="_devinfo" display="_DevInfo"/>] ;
        + [</VFPData>]

    _Name               = ''
    _Type               = ''
    _Exclude            = .F.
    _Comments           = ''
    _CPID               = 0
    _ID                 = 0
    _ObjRev             = 0
    _TimeStamp          = 0
    _User               = ''
    _DevInfo            = ''

Enddefine



Define Class CL_MENU_COL_BASE As CL_COL_BASE
    _MemberData = [<VFPData>] ;
        + [<memberdata name="oreg" display="oReg"/>] ;
        + [<memberdata name="analizarsiexpresionescomandooprocedimiento" display="AnalizarSiExpresionEsComandoOProcedimiento"/>] ;
        + [<memberdata name="get_datafromtablabin" display="get_DataFromTablabin"/>] ;
        + [<memberdata name="updatemenu" display="updateMENU"/>] ;
        + [</VFPData>]


    #If .F.
        Local This As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG'
    #Endif

    oReg            = .Null.


    Procedure get_DataFromTablabin
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toReg                     (v! IN    ) Objeto de datos del registro
* toCol_LastLevelName       (v! IN    ) Objeto collection con la pila de niveles analizados
*---------------------------------------------------------------------------------------------------
        Lparameters toReg, toCol_LastLevelName As Collection

        Try
                Local I, lcLevelName, lnLastKey, llRetorno, llHayDatos, loReg ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG' ;
                    , loOption As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                Store .Null. To loOption, loBarPop

                With This As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG'
                    lnLastKey   = 0
                    .oReg   = toReg
                    lcLevelName = toReg.LevelName
                    lnLastKey   = Iif( toCol_LastLevelName.Count=0, 0, toCol_LastLevelName.GetKey(toReg.LevelName ) )

                    If lnLastKey = 0
                        toCol_LastLevelName.Add( toReg.LevelName, toReg.LevelName )
                    Endif

                    Do While Not Eof()
                        loReg       = .Null.
                        Skip 1

                        If Eof()
                            Exit
                        Endif

                        loReg   = .Null.
                        Scatter Memo Name loReg

                        lnLastKey   = toCol_LastLevelName.GetKey(loReg.LevelName)

                        Do Case
                            Case Eof()
                                llRetorno   = .T.
                                Exit

                            Case lnLastKey > 0 And lnLastKey < toCol_LastLevelName.Count
*-- El nombre del analizado actual ya existe y no es el último,
*-- así que corresponde a un nivel superior.
                                Skip -1
                                llRetorno   = .F.
                                Exit

                            Case Inlist( loReg.ObjType, C_OBJTYPE_MENUTYPE_OPTION, C_OBJTYPE_MENUTYPE_BARorPOPUP ) ;
                                    AND toReg.ObjType = loReg.ObjType
*-- Un objeto Option no puede anidar a otro Option,
*-- y un objeto Bar/Popup no puede anidar a otro Bar/Popup
                                Skip -1
                                llRetorno   = .F.
                                Exit

                            Case loReg.ObjType = C_OBJTYPE_MENUTYPE_BARorPOPUP  && Bar or Popup
                                loBarPop    = .Null.
                                loBarPop    = Createobject('CL_MENU_BARPOP')
                                llHayDatos  = loBarPop.get_DataFromTablabin( loReg, toCol_LastLevelName )
                                llRetorno   = .T.
                                llRetorno   = llHayDatos
                                .Add( loBarPop )
                                loBarPop    = .Null.
                                If Not llHayDatos And toReg.ObjType = C_OBJTYPE_MENUTYPE_OPTION
                                    Exit
                                Endif

                            Case loReg.ObjType = C_OBJTYPE_MENUTYPE_OPTION  && Option
                                loOption    = .Null.
                                loOption    = Createobject('CL_MENU_OPTION')
                                llHayDatos  = loOption.get_DataFromTablabin( loReg, toCol_LastLevelName )
                                llRetorno   = llHayDatos
                                .Add( loOption )
                                loOption    = .Null.
                                If Not llHayDatos And toReg.ObjType = C_OBJTYPE_MENUTYPE_OPTION
                                    Exit
                                Endif

                            Otherwise
                                llRetorno   = .T.
                                Exit

                        Endcase
                    Enddo
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                If toReg.ObjType = C_OBJTYPE_MENUTYPE_BARorPOPUP
                    lnLastKey   = toCol_LastLevelName.GetKey(toReg.LevelName)
                    If lnLastKey > 0
                        toCol_LastLevelName.Remove(lnLastKey)
                    Endif
                Endif
                Store .Null. To loBarPop, loOption
                Release I, lcLevelName, lnLastKey, llHayDatos, loReg, loBarPop, loOption
        Endtry

        Return llRetorno
    Endproc


    Procedure updateMENU
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters toConversor
    Endproc


    Procedure AnalizarSiExpresionEsComandoOProcedimiento
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcExpr                    (v! IN    ) Expresión a analizar (puede ser una línea o un Procedure)
* tcProcName                (!@    OUT) Nombre del Procedimiento, si se encuentra uno
* tcProcCode                (!@    OUT) Código del Procedimiento, si se encuentra uno
* tcSourceCode              (@? IN    ) Si se indica, se buscará el nombre de Procedure para obtener su código
* tnIndentation             (v? IN    ) En caso de devolver código, indica si se debe indentar o quitar indentación
* tlAddProcEndproc          (v? IN    ) En caso de devolver código, indica si se debe encerrar con PROCEDURE/ENDPROC
* tlForceProcedure          (v? IN    ) Indica que se evalúe como Procedure, no como Command
*---------------------------------------------------------------------------------------------------
* DETALLE: Los menus guardan en los primeros registros los Comandos o Procedimientos en el campo PROCEDURE,
*       y luego al generar el código lo muestran como Comando si es una sola línea, y si no como Procedure.
*---------------------------------------------------------------------------------------------------
        Lparameters tcExpr, tcProcName, tcProcCode, tcSourceCode, tnIndentation, tlAddProcEndproc, tlForceProcedure

        Local laProcLines(1), lnLine_Count, I
        tcProcName      = ''
        tcProcCode      = ''
        tnIndentation   = Evl(tnIndentation,0)
        lnLine_Count    = Alines( laProcLines, tcExpr )

        If lnLine_Count > 1 Or tlForceProcedure
*-- ES UN PROCEDIMIENTO
            tcProcCode  = tcExpr

            For I = 1 To lnLine_Count
*-- Si existe el snippet #NAME, lo usa
                If Empty(tcProcName) And Upper( Left( Chrtran( Alltrim(laProcLines(m.I)), C_TAB, ' ' ), 6 ) ) == '#NAME '
                    tcProcName  = Alltrim( Substr( Alltrim( Chrtran( laProcLines(m.I), C_TAB, ' ' ) ), 7 ) )
                    Exit
                Endif
            Endfor
        Else
*-- ES UN COMANDO, PERO PODRÍA REFERENCIAR A UN PROCEDURE DEL MENU, SE VERIFICA.
            If Not Empty(tcSourceCode)
                If Left( tcExpr, 3 ) == 'DO '
*-- Parece un Procedimiento, vamos a confirmarlo.
                    tcProcName  = Alltrim( Strextract( tcExpr, 'DO ', '&'+'&', 1, 2 ) )
                    tcProcCode  = Strextract( tcSourceCode, 'PROCEDURE ' + tcProcName + CR_LF, CR_LF + 'ENDPROC &'+'& ' + tcProcName )
                    If Empty(tcProcCode)
*-- Era un Command al final, o un Procedure externo,
*-- que para el caso es lo mismo porque no es del Menu.
                        tcProcName  = ''
                    Endif
                Endif
            Endif
        Endif

*-- Si se indicó indentación, se reprocesa el código del procedimiento
        If Not Empty(tcProcCode) And (tnIndentation <> 0 Or tlAddProcEndproc)
            lnLine_Count    = Alines( laProcLines, tcProcCode )
            tcProcCode      = ''

            If tlAddProcEndproc
*tcProcCode = '*' + REPLICATE('-',34) + CR_LF + 'PROCEDURE <<ProcName>>' + CR_LF
                tcProcCode  = 'PROCEDURE <<ProcName>>' + CR_LF
            Endif

            Do Case
                Case tnIndentation = 0
                    For I = 1 To lnLine_Count
*-- No Indentar
                        tcProcCode  = tcProcCode + laProcLines(m.I) + CR_LF
                    Endfor

                Case tnIndentation > 0
                    For I = 1 To lnLine_Count
*-- Indentar
                        tcProcCode  = tcProcCode + C_TAB + laProcLines(m.I) + CR_LF
                    Endfor

                Otherwise
                    For I = 1 To lnLine_Count
*-- Quitar indentación
                        If Inlist( Left(laProcLines(m.I),1), Space(1), C_TAB )
                            tcProcCode  = tcProcCode + Substr( laProcLines(m.I), 2 ) + CR_LF
                        Else
                            tcProcCode  = tcProcCode + laProcLines(m.I) + CR_LF
                        Endif
                    Endfor
            Endcase

            If tlAddProcEndproc
                tcProcCode  = tcProcCode + 'ENDPROC &' + '& <<ProcName>>' + CR_LF
            Endif
        Endif

        Return
    Endproc


Enddefine



Define Class CL_MENU As CL_MENU_COL_BASE
    #If .F.
        Local This As CL_MENU Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzecodeblock_cleanupcode" display="analyzeCodeBlock_CleanupCode"/>] ;
        + [<memberdata name="analyzecodeblock_menucode" display="analyzeCodeBlock_MenuCode"/>] ;
        + [<memberdata name="analyzecodeblock_procedure" display="analyzeCodeBlock_PROCEDURE"/>] ;
        + [<memberdata name="analyzecodeblock_setupcode" display="analyzeCodeBlock_SetupCode"/>] ;
        + [<memberdata name="updatemenu_recursivo" display="UpdateMenu_Recursivo"/>] ;
        + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
        + [<memberdata name="_cpid" display="_CPID"/>] ;
        + [<memberdata name="_version" display="_Version"/>] ;
        + [</VFPData>]


*-- Modulo
    _Version            = 0
    _SourceFile         = ''
*LScheffler 20.08.2023
*issue #96, [KestasL] keep CodePage relavant information for binary sources
    _cpid               = Cpcurrent()


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, loReg, lcComment, lcExpr, lcProcName, lcProcCode, loEx As Exception ;
                    , llBloque_SetupCode_Analizado, llBloque_CleanupCode_Analizado, llBloque_MenuCode_Analizado ;
                    , llBloque_MenuType_Analizado, llBloque_Procedure_Analizado, llBloque_MenuLocation_Analizado ;
                    , loOptions As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG' ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG'
                Store .Null. To loBarPop, loOptions
                Store '' To lcComment

                llBloqueEncontrado  = .T.

                With This As CL_MENU Of 'FOXBIN2PRG.PRG'
*-- CABECERA DEL MENU
                    Scatter Memo Blank Name .oReg
                    loReg       = .oReg

                    For I = m.I + 0 To tnCodeLines
                        .set_Line( @tcLine, @taCodeLines, m.I )

                        Do Case
                            Case Empty( tcLine )
                                Loop

                            Case toConversor.lineIsOnlyCommentAndNoMetadata( @tcLine, @lcComment, .F., .T. )
                                Loop    && Saltear comentarios

                            Case Not llBloque_MenuType_Analizado And Left( tcLine, Len(C_MENUTYPE_I) ) == C_MENUTYPE_I
                                toConversor.n_MenuType      = Int( Val( Strextract( tcLine, C_MENUTYPE_I, C_MENUTYPE_F ) ) )
                                loReg.ObjType       = toConversor.n_MenuType
                                llBloque_MenuType_Analizado = .T.

                            Case Not llBloque_MenuLocation_Analizado And Left( tcLine, Len(C_MENULOCATION_I) ) == C_MENULOCATION_I
                                toConversor.c_MenuLocation  = Strextract( tcLine, C_MENULOCATION_I, C_MENULOCATION_F )
                                Do Case
                                    Case toConversor.c_MenuLocation == 'REPLACE'
                                        loReg.Location      = C_MENULOCATION_REPLACE
                                    Case toConversor.c_MenuLocation == 'APPEND'
                                        loReg.Location      = C_MENULOCATION_APPEND
                                    Otherwise
                                        If Left(toConversor.c_MenuLocation,6) == 'BEFORE'
                                            loReg.Location      = C_MENULOCATION_BEFORE
                                        Else
                                            loReg.Location      = C_MENULOCATION_AFTER
                                        Endif
                                        loReg.Name  = Getwordnum(toConversor.c_MenuLocation,2)
                                Endcase
                                llBloque_MenuLocation_Analizado = .T.

                            Case Not llBloque_SetupCode_Analizado And .analyzeCodeBlock_SetupCode( @tcLine, @taCodeLines, @m.I, tnCodeLines, toConversor )
                                llBloque_SetupCode_Analizado    = .T.

                            Case Not llBloque_MenuCode_Analizado And .analyzeCodeBlock_MenuCode( @tcLine, @taCodeLines, @m.I, tnCodeLines, toConversor )
                                llBloque_MenuCode_Analizado     = .T.

                            Case Not llBloque_CleanupCode_Analizado And .analyzeCodeBlock_CleanupCode( @tcLine, @taCodeLines, @m.I, tnCodeLines, toConversor )
                                llBloque_CleanupCode_Analizado  = .T.

                            Case Not llBloque_Procedure_Analizado And .analyzeCodeBlock_PROCEDURE( @tcLine, @taCodeLines, @m.I, tnCodeLines, toConversor )
                                llBloque_Procedure_Analizado    = .T.

                            Otherwise   && Otro valor
*EXIT
                        Endcase
                    Endfor
                Endwith && THIS


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loBarPop, loOptions
                Release loReg, lcComment, lcExpr, lcProcName, lcProcCode ;
                    , llBloque_SetupCode_Analizado, llBloque_CleanupCode_Analizado, llBloque_MenuCode_Analizado ;
                    , llBloque_MenuType_Analizado, llBloque_Procedure_Analizado, llBloque_MenuLocation_Analizado ;
                    , loOptions, loBarPop

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure analyzeCodeBlock_SetupCode
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcText, lcComment, loEx As Exception
                Store '' To lcText, lcComment

                If Left(tcLine, Len(C_SETUPCODE_I)) == C_SETUPCODE_I
                    llBloqueEncontrado  = .T.

                    With This As CL_MENU Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case C_SETUPCODE_F $ tcLine && Fin
                                    I = m.I + 1
                                    Exit

                                Otherwise   && Líneas de procedure
                                    lcText  = lcText + CR_LF + taCodeLines(m.I)
                            Endcase
                        Endfor

                        I = m.I - 1
                        .oReg.Setup = Substr( lcText, 3 )   && Quito el primer CR_LF
                    Endwith && THIS
                Endif

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure analyzeCodeBlock_CleanupCode
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcText, lcComment, loEx As Exception
                Store '' To lcText, lcComment

                If Left(tcLine, Len(C_CLEANUPCODE_I)) == C_CLEANUPCODE_I
                    llBloqueEncontrado  = .T.

                    With This As CL_MENU Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case C_CLEANUPCODE_F $ tcLine   && Fin
                                    I = m.I + 1
                                    Exit

                                Otherwise   && Líneas de procedure
                                    lcText  = lcText + CR_LF + taCodeLines(m.I)
                            Endcase
                        Endfor

                        I = m.I - 1
                        .oReg.Cleanup = Substr( lcText, 3 ) && Quito el primer CR_LF
                    Endwith && THIS
                Endif

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure analyzeCodeBlock_MenuCode
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcExpr, lcProcName, lcProcCode, lcComment, loReg, loEx As Exception ;
                    , llBloque_SetupCode_Analizado ;
                    , loOptions As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG' ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG'
                Store .Null. To loBarPop, loOptions
                Store '' To lcExpr, lcProcName, lcProcCode, lcComment

                With This As CL_MENU Of 'FOXBIN2PRG.PRG'
                    loReg       = .oReg

                    If Left(tcLine, Len(C_MENUCODE_I)) == C_MENUCODE_I
                        llBloqueEncontrado  = .T.


                        For I = m.I + 0 To tnCodeLines
                            Store '' To lcExpr, lcProcName, lcProcCode
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case toConversor.lineIsOnlyCommentAndNoMetadata( @tcLine, @lcComment )
                                    Loop    && Saltear comentarios

                                Case Left( tcLine, Len(C_MENUCODE_F) ) == C_MENUCODE_F
                                    Exit

                                Case Left( tcLine, Len(C_MENUCODE_I) ) == C_MENUCODE_I

                                Case Left( tcLine, 12 ) == 'DEFINE MENU '
                                    loReg.OBJCODE       = C_OBJCODE_MENUDEFAULT_DEFAULT
                                    loReg.ProcType      = 1
                                    loReg.Mark          = Chr(4)
                                    loReg.SetupType     = 1
                                    loReg.CleanType     = 1
                                    loReg.ItemNum       = Str(0,3)
                                    lcMenuType          = Alltrim( Getwordnum( tcLine, 3 ) )
*loReg.ObjType      = IIF( UPPER(lcMenuType) = '_MSYSMENU', 1, 5 )

                                    lcExpr          = Alltrim( Strextract( C_FB2PRG_CODE, 'ON SELECTION MENU _MSYSMENU ', CR_LF ) )

                                    If Not Empty(lcExpr)
                                        .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, @C_FB2PRG_CODE, -1, .F. )

                                        If Empty(lcProcCode)
*-- Comando
                                            loReg.Procedure = lcExpr
                                        Else
*-- Procedure
                                            lcProcCode  = Strtran( lcProcCode, '<<ProcName>>', lcProcName )
                                            loReg.Procedure = lcProcCode
                                        Endif
                                    Endif

                                    loBarPop    = .Null.
                                    loBarPop    = Createobject('CL_MENU_BARPOP')
                                    loBarPop.c_ParentName   = ''
                                    loBarPop.n_ParentCode   = .oReg.OBJCODE
                                    loBarPop.n_ParentType   = .oReg.ObjType
                                    loBarPop.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, @tnCodeLines, toConversor )
                                    .Add( loBarPop )
                                    Exit

                                Case Left( tcLine, 13 ) == 'DEFINE POPUP '
                                    loReg.OBJCODE       = C_OBJCODE_MENUDEFAULT_DEFAULT
                                    loReg.ProcType      = 1
                                    loReg.Mark          = Chr(4)
                                    loReg.SetupType     = 1
                                    loReg.CleanType     = 1
                                    loReg.ItemNum       = Str(0,3)
                                    loReg.Scheme        = 0
                                    lcExpr              = Alltrim( Strextract( C_FB2PRG_CODE, 'ON SELECTION POPUP ALL ', CR_LF ) )
                                    .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, @C_FB2PRG_CODE, -1, .F. )

                                    If Empty(lcProcCode)
*-- Comando
                                        loReg.Procedure = lcExpr
                                    Else
*-- Procedure
                                        lcProcCode  = Strtran( lcProcCode, '<<ProcName>>', lcProcName )
                                        loReg.Procedure = lcProcCode
                                    Endif

                                    loBarPop    = .Null.
                                    loBarPop    = Createobject('CL_MENU_BARPOP')
                                    loBarPop.c_ParentName   = ''
                                    loBarPop.n_ParentCode   = .oReg.OBJCODE
                                    loBarPop.n_ParentType   = .oReg.ObjType
                                    loBarPop.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, @tnCodeLines, toConversor )
                                    .Add( loBarPop )

*-- Creo option
                                    loOption        = .Null.
                                    loOption        = Createobject("CL_MENU_OPTION")
                                    Scatter Memo Blank Name loOption.oReg

                                    With loOption.oReg
                                        .ObjType    = C_OBJTYPE_MENUTYPE_OPTION
                                        .OBJCODE    = C_OBJCODE_MENUOPTION_SUBMENU
                                        .Mark       = Chr(0)
                                        .Prompt     = '\<Shortcut'
                                        .LevelName  = '_MSYSMENU'
                                        loBarPop.Add( loOption )
                                        loBarPop.oReg.NUMITEMS  = loBarPop.Count
                                        .ItemNum    = Str(loBarPop.Count,3)
                                        .Scheme = 0
                                        loBarPop        = .Null.
                                    Endwith

*-- Creo BarPop
                                    loBarPop        = .Null.
                                    loBarPop        = Createobject('CL_MENU_BARPOP')
                                    loBarPop.c_ParentName   = ''
                                    loBarPop.n_ParentCode   = loOption.oReg.OBJCODE
                                    loBarPop.n_ParentType   = loOption.oReg.ObjType
                                    loBarPop.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, @tnCodeLines, toConversor )
                                    loOption.Add( loBarPop )
                                    loBarPop        = .Null.
                                    loOption        = .Null.
                                    Exit

                                Otherwise   && Otro valor
                                    I   = m.I - 1
                                    Exit
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
                Store .Null. To loBarPop, loOptions
                Release lcExpr, lcProcName, lcProcCode, lcComment, loReg, llBloque_SetupCode_Analizado ;
                    , loOptions, loBarPop

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure analyzeCodeBlock_PROCEDURE
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcText, lcComment, lcProcName, loEx As Exception
                Store '' To lcText, lcComment

                If Left(tcLine, Len(C_PROC_CODE_I)) == C_PROC_CODE_I
                    llBloqueEncontrado  = .T.

                    With This As CL_MENU Of 'FOXBIN2PRG.PRG'
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case C_PROC_CODE_F $ tcLine && Fin
                                    I = m.I + 1
                                    Exit

                                Otherwise   && Líneas de procedure
*-- Las saltea
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


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------

        Try
                Local lcText, loReg, loHeader, lnNivel, lcEndProcedures, lcExpr, lcProcName, lcProcCode, lcLocation ;
                    , loEx As Exception ;
                    , loCol_LastLevelName As Collection ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG' ;
                    , loOption As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                Store .Null. To loOption, loBarPop, loCol_LastLevelName
                Store '' To lcText, lcEndProcedures

                With This As CL_MENU Of 'FOXBIN2PRG.PRG'
                    loReg       = .oReg
                    loHeader    = loReg
                    loBarPop    = .Item(1).oReg
                    lnNivel     = 0

                    Do Case
                        Case loReg.Location = C_MENULOCATION_REPLACE
                            lcLocation  = 'REPLACE'
                        Case loReg.Location = C_MENULOCATION_APPEND
                            lcLocation  = 'APPEND'
                        Case loReg.Location = C_MENULOCATION_BEFORE
                            lcLocation  = 'BEFORE ' + loReg.Name
                        Case loReg.Location = C_MENULOCATION_AFTER
                            lcLocation  = 'AFTER ' + loReg.Name
                    Endcase

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<C_MENUTYPE_I>><<loReg.ObjType>><<C_MENUTYPE_F>>
                    <<C_MENULOCATION_I>><<lcLocation>><<C_MENULOCATION_F>>
                    ENDTEXT

                    If Not Empty(loReg.Setup)
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<>>
                        <<C_SETUPCODE_I>>
                        <<loReg.Setup>>
                        <<C_SETUPCODE_F>>
                        ENDTEXT
                    Endif

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<>>
                    <<C_MENUCODE_I>>
                    ENDTEXT

                    Do Case
                        Case loHeader.ObjType = C_OBJTYPE_MENUTYPE_DEFAULT  && Menu Bar (Sistema)
                            lcText  = lcText + CR_LF + 'DEFINE MENU ' + loBarPop.Name + ' BAR'

                        Case loHeader.ObjType = C_OBJTYPE_MENUTYPE_MENUBARONTOP && Menu Bar (On top)
                            lcText  = lcText + CR_LF + 'DEFINE MENU ' + loBarPop.Name + ' BAR'

                        Case loHeader.ObjType = C_OBJTYPE_MENUTYPE_SHORTCUT && Shortcut
                            lcText  = lcText + CR_LF + 'DEFINE POPUP ' + .Item(1).Item(1).Item(1).oReg.Name + ' SHORTCUT RELATIVE FROM MROW(),MCOL()'

                    Endcase


*-- Bars and Popups
                    If .Count > 0
                        For Each loBarPop In This FoxObject
                            lcText      = lcText + loBarPop.toText(loReg, lnNivel+0, @lcEndProcedures, loHeader)
                        Endfor
                    Endif

                    loBarPop    = .Item(1).oReg

                    Do Case
                        Case loHeader.ObjType = C_OBJTYPE_MENUTYPE_DEFAULT Or loHeader.ObjType = C_OBJTYPE_MENUTYPE_MENUBARONTOP
*-- Propecimiento principal de _MSYSMENU (ObjType:1, ObjCode:22) (C_OBJTYPE_MENUTYPE_DEFAULT, C_OBJCODE_MENUDEFAULT_DEFAULT)
                            If Not Empty(loHeader.Procedure)
                                lcExpr      = loHeader.Procedure
                                .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, '', 1, .T. )

                                If Empty(lcProcCode)
*-- Comando
                                    lcText  = lcText + 'ON SELECTION MENU ' + loBarPop.Name + ' ' + lcExpr + CR_LF
                                Else
*-- Procedure
                                    lcProcName  = Evl( lcProcName, Chrtran('SELECTION MENU ' + loBarPop.Name, ' ', '_') + '_FB2P' )
                                    lcText  = lcText + 'ON SELECTION MENU ' + loBarPop.Name + ' DO ' + lcProcName + CR_LF
                                    lcProcCode      = Strtran( lcProcCode, '<<ProcName>>', lcProcName )
                                    lcEndProcedures = lcEndProcedures + lcProcCode + CR_LF
                                Endif
                            Endif

                        Case loHeader.ObjType = C_OBJTYPE_MENUTYPE_SHORTCUT
                            If Not Empty(loHeader.Procedure)
                                lcExpr      = loHeader.Procedure
                                .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, '', 1, .T. )

                                If Empty(lcProcCode)
*-- Comando
                                    lcText  = lcText + 'ON SELECTION POPUP ALL ' + lcExpr + CR_LF
                                Else
*-- Procedure
                                    lcText  = lcText + 'ON SELECTION POPUP ALL ' + loBarPop.Name + ' DO ' + lcProcName + CR_LF
                                    lcProcCode      = Strtran( lcProcCode, '<<ProcName>>', lcProcName )
                                    lcEndProcedures = lcEndProcedures + lcProcCode + CR_LF
                                Endif
                            Endif

                            lcText  = lcText + 'ACTIVATE POPUP ' + .Item(1).Item(1).Item(1).oReg.Name + CR_LF
                    Endcase

                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<C_MENUCODE_F>>
                    ENDTEXT

*-- Procedimientos finales
                    If Not Empty(lcEndProcedures)
                        lcText  = lcText + CR_LF + CR_LF ;
                            + C_PROC_CODE_I + CR_LF ;
                            + lcEndProcedures ;
                            + C_PROC_CODE_F + CR_LF
                    Endif

                    If Not Empty(loReg.Cleanup)
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<>>
                        <<C_CLEANUPCODE_I>>
                        <<loReg.Cleanup>>
                        <<C_CLEANUPCODE_F>>
                        ENDTEXT
                    Endif

                Endwith && THIS


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loOption, loBarPop, loCol_LastLevelName
                Release loReg, loHeader, lnNivel, lcEndProcedures, lcExpr, lcProcName, lcProcCode, lcLocation ;
                    , loCol_LastLevelName, loBarPop, loOption

        Endtry

        Return lcText
    Endproc


    Procedure get_DataFromTablabin
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------
        Local loReg, loCol_LastLevelName As Collection
        Store .Null. To loReg, loCol_LastLevelName
        Go Top
        Scatter Memo Name loReg
        loCol_LastLevelName = Createobject('COLLECTION')
        CL_MENU_COL_BASE::get_DataFromTablabin( loReg, loCol_LastLevelName )
        Store .Null. To loReg, loCol_LastLevelName
        Release loReg, loCol_LastLevelName
    Endproc


    Procedure updateMENU
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Select TABLABIN

        With This As CL_MENU Of 'FOXBIN2PRG.PRG'
            If .n_Debug > 0 Then
                toConversor.writeLog( '' )
                toConversor.writeLog( Replicate('-',80) )
            Endif

            .UpdateMenu_Recursivo( This, 0, @toConversor )

            If .n_Debug > 0 Then
                toConversor.writeLog( Replicate('-',80) )
            Endif
        Endwith && THIS

    Endproc


    Procedure UpdateMenu_Recursivo
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toObj                     (v! IN    ) Referencia del objeto CL_MENU_BARPOP o CL_MENU_OPTION
* tnNivel                   (v! IN    ) Nivel de indentación (solo para debug)
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters toObj As Collection, tnNivel, toConversor

        Local loReg, lcTempName, loEx As Exception
        Store .Null. To loReg

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                With This As CL_MENU Of 'FOXBIN2PRG.PRG'
                    If Vartype( toObj.oReg ) = 'O'
                        loReg   = toObj.oReg

                        If loReg.ObjType = C_OBJTYPE_MENUTYPE_OPTION
                            lcTempName  = '_' + Padl( Int( Val(loReg.ItemNum) ), 9, '0')

*-- Si el nombre es del tipo "_0000000001" y coincide con el itemNum
*-- que uso para darle un nombre temporal, lo vuelvo a quitar en el binario.
                            If loReg.Name = lcTempName Then
                                loReg.Name = ''
                            Endif
                        Endif

                        Insert Into TABLABIN From Name loReg

                        If .n_Debug > 0 Then
                            toConversor.writeLog( Replicate(C_TAB,tnNivel) ;
                                + 'ObjType=' + Transform(loReg.ObjType) ;
                                + ', ObjCode=' + Transform(loReg.OBJCODE) ;
                                + ', Name=' + Transform(loReg.Name) ;
                                + ', LevelName=' + Transform(loReg.LevelName) ;
                                + ', ItemNum=' + Transform(loReg.ItemNum) ;
                                + ', Location=' + Transform(loReg.Location) ;
                                + ', Prompt=' + Transform(loReg.Prompt) ;
                                + ', Message=' + Transform(loReg.Message) ;
                                + ', KeyName=' + Transform(loReg.KEYNAME) ;
                                + ', KeyLabel=' + Transform(loReg.KeyLabel) ;
                                + ', Comment=' + Transform(loReg.Comment) ;
                                + ', SkipFor=' + Transform(loReg.SkipFor) )
                        Endif

                    Else
                        If .n_Debug > 0 Then
*toConversor.writeLog( REPLICATE(C_TAB,tnNivel) ;
+ 'Objeto [' + toObj.CLASS + '] no contiene el objeto oReg (nivel ' + TRANSFORM(tnNivel) + ')' )
                            toConversor.writeLog( Replicate(C_TAB,tnNivel) + Textmerge(C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC) )
                        Endif

                    Endif

                    If toObj.Count > 0 Then
                        For Each loReg In toObj FoxObject
                            .UpdateMenu_Recursivo( loReg, tnNivel + 1, @toConversor )
                        Endfor
                    Endif
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loReg
                Release loReg

        Endtry
    Endproc


Enddefine



Define Class CL_MENU_BARPOP As CL_MENU_COL_BASE
    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzecodeblock_definepopup" display="analyzeCodeBlock_DefinePOPUP"/>] ;
        + [<memberdata name="updatemenu" display="updateMENU"/>] ;
        + [<memberdata name="c_parentname" display="c_ParentName"/>] ;
        + [<memberdata name="n_parentcode" display="n_ParentCode"/>] ;
        + [<memberdata name="n_parenttype" display="n_ParentType"/>] ;
        + [</VFPData>]

    #If .F.
        Local This As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG'
    #Endif

    c_ParentName    = ''
    n_ParentCode    = 0
    n_ParentType    = 0


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcSubName, lcComment, lnLast_I, loReg, lcExpr, lcProcName, lcProcCode, lcMenuType ;
                    , loEx As Exception ;
                    , loOption As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                Store .Null. To loOption
                Store '' To lcSubName, lcComment, lcExpr, lcProcName, lcProcCode

                With This As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG'
                    Scatter Memo Blank Name .oReg
                    loReg               = .oReg
                    loReg.ObjType       = C_OBJTYPE_MENUTYPE_BARorPOPUP
                    loReg.ProcType      = 1
                    loReg.Mark          = Chr(0)
                    loReg.ItemNum       = Str(0,3)
                    llBloqueEncontrado  = .T.

                    For I = m.I + 0 To tnCodeLines
                        Store '' To lcExpr, lcProcName, lcProcCode
                        .set_Line( @tcLine, @taCodeLines, m.I )

                        Do Case
                            Case Empty( tcLine )
                                Loop

                            Case toConversor.lineIsOnlyCommentAndNoMetadata( @tcLine, @lcComment, .F., .T. )
                                Loop    && Saltear comentarios

                            Case Left( tcLine, Len(C_MENUCODE_F) ) == C_MENUCODE_F
                                Exit

                            Case Left( tcLine, Len('ON SELECTION POPUP ' + loReg.Name) ) == 'ON SELECTION POPUP ' + loReg.Name
                                Exit

                            Case Left( tcLine, 12 ) == 'DEFINE MENU '
                                loReg.OBJCODE       = C_OBJCODE_MENUBARPOPUP_MENUBAR
                                loReg.Name          = Strextract( tcLine, 'DEFINE MENU ', ' BAR' )
*loReg.NAME         = '_MSYSMENU'
                                loReg.LevelName     = loReg.Name
                                loReg.Scheme        = Iif( loReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUBAR, 3, 4 )

                                lcExpr          = Strextract( C_FB2PRG_CODE, 'ON SELECTION POPUP ALL ', CR_LF )
                                .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, @C_FB2PRG_CODE, -1 )
                                loReg.Procedure = Evl(lcProcCode, lcExpr)

                            Case Left( tcLine, 13 ) == 'DEFINE POPUP '
                                If .n_ParentCode = C_OBJCODE_MENUDEFAULT_DEFAULT
                                    loReg.OBJCODE       = C_OBJCODE_MENUBARPOPUP_MENUBAR
                                    loReg.Name          = '_MSYSMENU'
                                    loReg.LevelName     = loReg.Name
                                    loReg.Scheme        = 3

                                    If .n_ParentType = C_OBJTYPE_MENUTYPE_SHORTCUT
                                        Exit
                                    Endif
                                Else
                                    loReg.OBJCODE       = C_OBJCODE_MENUBARPOPUP_MENUPAD
                                    loReg.Scheme        = 4
                                    loReg.Name          = Alltrim( Getwordnum( tcLine, 3 ) )

                                    If Right(loReg.Name,5) == '_FB2P'   && Originalmente era vacío y se la había puesto un nombre temporal.
                                        loReg.Name      = ''
                                    Endif

                                    loReg.LevelName     = loReg.Name
                                    lcExpr              = Alltrim( Strextract( C_FB2PRG_CODE, 'ON SELECTION POPUP ' + loReg.Name + ' ', CR_LF ) )
                                    .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, @C_FB2PRG_CODE, -1 )
                                    loReg.Procedure     = Evl(lcProcCode, lcExpr)
                                Endif

                            Case Left( tcLine, 11 ) == 'DEFINE PAD ' Or Left( tcLine, 11 ) == 'DEFINE BAR '
                                loOption    = .Null.
                                loOption    = Createobject("CL_MENU_OPTION")
                                lnLast_I    = m.I
                                loOption.c_ParentName   = loReg.LevelName
                                loOption.n_ParentCode   = loReg.OBJCODE
                                loOption.n_ParentType   = loReg.ObjType

                                If Not loOption.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, toConversor )
                                    I = lnLast_I
                                    llBloqueEncontrado  = .F.
                                    Exit
                                Endif

                                .Add( loOption )
                                loOption.oReg.ItemNum   = Str(.Count,3)
                                loReg.NUMITEMS          = .Count
                                loReg.Scheme            = Iif( loReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUBAR, 3, 4 )
                                loOption    = .Null.

                                If I = lnLast_I && No avanzó, debe salir.
                                    Exit
                                Endif

                            Otherwise   && Otro valor
                                I   = m.I - 1
                                Exit
                        Endcase
                    Endfor
                Endwith && THIS

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loOption
                Release lcSubName, lcComment, lnLast_I, loReg, lcExpr, lcProcName, lcProcCode, lcMenuType, loOption

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toParentReg               (v! IN    ) Objeto registro Padre
* tnNivel                   (v! IN    ) Nivel para indentar
* tcEndProcedures           (!@    OUT) Agregar aquí los procedimientos que irán al final
* toHeader                  (v! IN    ) Objeto Registro de cabecera del menu
*---------------------------------------------------------------------------------------------------
        Lparameters toParentReg, tnNivel, tcEndProcedures, toHeader

        Try
                Local loReg, I, lcText, lcTab, lcExpr, lcProcName, lcProcCode, loEx As Exception ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG' ;
                    , loOption As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                Store .Null. To loOption, loBarPop
                Store '' To lcText, lcExpr, lcProcName, lcProcCode
                loReg   = This.oReg
                lcTab   = Replicate(Chr(9),tnNivel)

*-- Menu Bar or Popup (ObjType:2, ObjCode:0 ó 1)
                If loReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUPAD   && (Menu Pad)
                    If toHeader.ObjType = C_OBJTYPE_MENUTYPE_SHORTCUT
*-- Shortcut
                        If Not Pemstatus(toHeader,'_MenuInicializado', 5)   && Header
                            AddProperty(toHeader,'_MenuInicializado', .T.)
                        Else    && Rest
                            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<lcTab>>*----------------------------------
                            <<lcTab>>DEFINE POPUP <<loReg.Name>> SHORTCUT RELATIVE
                            ENDTEXT
                        Endif
                    Else    && ObjType = C_OBJTYPE_MENUTYPE_DEFAULT o C_OBJTYPE_MENUTYPE_MENUBARONTOP
*-- Menu
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<lcTab>>*----------------------------------
                        <<lcTab>>DEFINE POPUP <<loReg.Name>> MARGIN RELATIVE SHADOW COLOR SCHEME <<loReg.Scheme>>
                        ENDTEXT
                    Endif
                Endif

*-- Options (ObjType:3)
                If This.Count > 0
                    For Each loOption In This FoxObject
                        lcText      = lcText + loOption.toText(loReg, tnNivel+0, @tcEndProcedures, toHeader)
                    Endfor
                Endif

*-- Procedure del POPUP o MENU
                If Not Empty(loReg.Procedure)
                    lcExpr      = loReg.Procedure
                    This.AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, '', 1, .T. )

                    If Empty(lcProcCode)
*-- Comando
                        lcText          = lcText + lcTab + 'ON SELECTION POPUP ' ;
                            + Iif( loReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUPAD, loReg.Name, 'ALL' ) + ' ' + lcExpr + CR_LF
                    Else
*-- Procedure
                        If Empty(lcProcName)
                            lcProcName  = Chrtran( Alltrim( Iif( loReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUPAD, loReg.Name, 'ALL' ) ), ' ', '_' ) + '_FB2P'
                        Endif
                        lcText          = lcText + lcTab + 'ON SELECTION POPUP ' ;
                            + Iif( loReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUPAD, loReg.Name, 'ALL' ) + ' DO ' + lcProcName + CR_LF
                        tcEndProcedures = tcEndProcedures + Strtran( lcProcCode, '<<ProcName>>', lcProcName ) + CR_LF
                    Endif

                Endif


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loOption, loBarPop
                Release loReg, I, lcTab, lcExpr, lcProcName, lcProcCode, loBarPop, loOption

        Endtry

        Return lcText
    Endproc


    Procedure updateMENU
    Endproc


Enddefine


Define Class CL_MENU_OPTION As CL_MENU_COL_BASE
    _MemberData = [<VFPData>] ;
        + [<memberdata name="analyzecodeblock_definebar" display="analyzeCodeBlock_DefineBAR"/>] ;
        + [<memberdata name="analyzecodeblock_definepad" display="analyzeCodeBlock_DefinePAD"/>] ;
        + [<memberdata name="get_definebartext" display="get_DefineBarText"/>] ;
        + [<memberdata name="get_definepadtext" display="get_DefinePadText"/>] ;
        + [<memberdata name="get_procnamefromsnippet" display="get_ProcNameFromSnippet"/>] ;
        + [<memberdata name="c_parentname" display="c_ParentName"/>] ;
        + [<memberdata name="n_parentcode" display="n_ParentCode"/>] ;
        + [<memberdata name="n_parenttype" display="n_ParentType"/>] ;
        + [</VFPData>]

    #If .F.
        Local This As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
    #Endif

    c_ParentName    = ''
    n_ParentCode    = 0
    n_ParentType    = 0


    Procedure analyzeCodeBlock
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcComment, loReg, lnLast_I, loEx As Exception, llPadOBar_Analizado ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG'
                Store .Null. To loBarPop
                Store '' To lcComment

                With This As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                    Scatter Memo Blank Name .oReg
                    loReg           = .oReg
                    loReg.Mark      = Chr(0)
                    loReg.ItemNum   = Str(0,3)

                    llBloqueEncontrado  = .T.

                    For I = m.I + 0 To tnCodeLines
                        .set_Line( @tcLine, @taCodeLines, m.I )

                        Do Case
                            Case Empty( tcLine )
                                Loop

                            Case toConversor.lineIsOnlyCommentAndNoMetadata( @tcLine, @lcComment, .F., .T. )
                                Loop    && Saltear comentarios

                            Case Left( tcLine, Len(C_MENUCODE_F) ) == C_MENUCODE_F
                                Exit

                            Case Left( tcLine, Len(C_MENUCODE_I) ) == C_MENUCODE_I
                                loReg.ObjType = C_OBJTYPE_MENUTYPE_BARorPOPUP
                                loReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUBAR

                            Case .analyzeCodeBlock_DefinePAD( @tcLine, @taCodeLines, @m.I, tnCodeLines, toConversor )
                                If loReg.Prompt == ''
*-- Esta opción no corresponde a este nivel. Debe subir.
                                    llBloqueEncontrado = .F.
                                    Exit
                                Endif
                                If loReg.OBJCODE <> C_OBJCODE_MENUOPTION_SUBMENU
                                    Exit
                                Endif

                            Case .analyzeCodeBlock_DefineBAR( @tcLine, @taCodeLines, @m.I, tnCodeLines, toConversor )
                                If loReg.Prompt == ''
*-- Esta opción no corresponde a este nivel. Debe subir.
                                    llBloqueEncontrado = .F.
                                    Exit
                                Endif
                                If loReg.OBJCODE <> C_OBJCODE_MENUOPTION_SUBMENU
                                    Exit
                                Endif

                            Case Left( tcLine, 13 ) == 'DEFINE POPUP '
                                loBarPop    = .Null.
                                loBarPop    = Createobject("CL_MENU_BARPOP")
                                lnLast_I    = m.I
                                loBarPop.c_ParentName   = loReg.LevelName
                                loBarPop.n_ParentCode   = loReg.OBJCODE
                                loBarPop.n_ParentType   = loReg.ObjType
                                .Add( loBarPop )
                                If Not loBarPop.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, toConversor )
                                    I   = m.I - 1
                                Endif
                                loBarPop    = .Null.
                                Exit

                            Otherwise   && Otro valor
                                I   = m.I - 1
                                Exit
                        Endcase
                    Endfor
                Endwith && THIS


            Catch To loEx When loEx.Message = 'Nivel_Anterior'
*-- OK. Volver a evaluar en el nivel anterior
                llBloqueEncontrado  = .F.

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loBarPop
                Release lcComment, loReg, lnLast_I, llPadOBar_Analizado, loBarPop
        Endtry

        Return llBloqueEncontrado
    Endproc

*!* Changd By: BH 30.3.2022
*!* <pdm>
*!* <change date="{^2022-03-16,19:41:00}">Changd By: BH <br />
*!* <a href"https://github.com/fdbozzo/foxbin2prg/issues/80">Issue #80</a>, by bjornhoeksel
*!*     Support ; sign in skip for expression between quotes
*!* </change>
*!* </pdm>

    Procedure remove_strings
*---------------------------------------------------------------------------------------------------
* Remove all things between quotes
* PARÁMETROS:
* tcLine                         Contenido de la línea en análisis
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine
* m.p_format_class      = parameter object

        Local lnStringCount, lnStringNumber, lnStartPosition, lnEndPosition

* Count the number of '
        lnStringCount = Occurs("'", tcLine) / 2

        For lnStringNumber = 1 To lnStringCount
* Loop for the number of '

* Get start position of  '
            lnStartPosition = Atc("'", tcLine, lnStringNumber)
* Get end position of  '
            lnEndPosition =     Atc("'", tcLine, lnStringNumber + 1) - lnStartPosition

* Replace all that stand between ' with ***
            tcLine = Stuff(tcLine, lnStartPosition, lnEndPosition, '********')
        Next

* Count the number of "
        lnStringCount = Occurs(["], tcLine) / 2

        For lnStringNumber = 1 To lnStringCount
* Loop for the number of "

* Get start position of  "
            lnStartPosition = Atc(["], tcLine, lnStringNumber)
* Get end position of  '
            lnEndPosition =     Atc(["], tcLine, lnStringNumber + 1) - lnStartPosition

* Replace all that stand between " with ***
            tcLine = Stuff(tcLine, lnStartPosition, lnEndPosition, '********')
        Next

* Count the number of [
        lnStringCount = Occurs("[", tcLine)

        For lnStringNumber = 1 To lnStringCount
* Loop for the number of [

* Get start position of  [
            lnStartPosition = At("[", tcLine, lnStringNumber) + 1

* Get end position of  ]
            lnEndPosition =     At("]", tcLine, lnStringNumber) - lnStartPosition

* Replace all that stand between [ with ***
            tcLine = Stuff(tcLine, lnStartPosition, lnEndPosition, '********')
        Next

* Return line without string content
        Return tcLine

    Endproc

*!* /Changd By: BH 30.3.2022

    Procedure analyzeCodeBlock_DefineBAR
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcText, loReg, lnPos, lcBarName, lcExpr, lcComment, lcProcName, lcProcCode, loEx As Exception ;
                    , lnNegContainer, lnNegObject, lnLineEnd, lcLineNoStrings
                Store '' To lcText, lcComment, lcBarName

* Estructura ejemplo a analizar:
*--------------------------------
*       DEFINE BAR _3YM1DR90Z OF _MSYSMENU PROMPT "Opción A con submenú" COLOR SCHEME 3 ;
*           NEGOTIATE NONE, LEFT ;
*           KEY DEL, "Pulsar <DEL>" ;
*           SKIP FOR SKIP_FOR() ;
*           MESSAGE "Mensaje para Opción A con submenú" && Comentario
*
*       ON BAR _3YM1DR90Z OF _MSYSMENU ACTIVATE POPUP OpciónA_CS
*
*       DEFINE BAR 1 OF _MSYSMENU PROMPT "Opción A con submenú" ;
*           NEGOTIATE NONE, LEFT ;
*           KEY DEL, "Pulsar <DEL>" ;
*           SKIP FOR SKIP_FOR() ;
*           MESSAGE "Mensaje para Opción A con submenú" && Comentario
*
*       ON BAR 1 OF _MSYSMENU ACTIVATE POPUP OpciónA_CS
*--------------------------------
                If Left( tcLine, 11 ) == 'DEFINE BAR '
                    llBloqueEncontrado  = .T.

                    With This As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                        loReg               = .oReg
                        loReg.ObjType       = C_OBJTYPE_MENUTYPE_OPTION
                        lcBarName           = Alltrim( Strextract( tcLine, 'BAR ' , ' OF' ) )
*!* Changd By: LScheffler 22.4.2021
*!* <pdm>
*!* <change date="{^2021-04-22,06:49:00}">Changd By: LScheffler<br />
*!* Old style determeines generic name from set name by testing as digit. It could be only digit. :(
*!* New style wraps it in ", so anything in " is set name
*!* </change>
*!* </pdm>

                        Do Case
                            Case Left ( m.lcBarName, 1 ) = '"'
                                lcBarName       = Substr( m.lcBarName, 2, Len( m.lcBarName ) - 2 )
                                loReg.Name      = m.lcBarName
*                               loReg.OBJCODE   = C_OBJCODE_MENUOPTION_BARNUM

                            Case Isdigit( m.lcBarName )
*-- Bar#
*                               loReg.OBJCODE   = C_OBJCODE_MENUOPTION_BARNUM

                            Otherwise
*-- Es un BAR del sistema
                                loReg.Name    = m.lcBarName
*                               loReg.OBJCODE = C_OBJCODE_MENUOPTION_BARNUM

                        Endcase
*!* Changd By: LScheffler 16.3.2022
*!* <pdm>
*!* <change date="{^2022-03-16,19:41:00}">Changd By: LScheffler <br />
*!* <a href"https://github.com/fdbozzo/foxbin2prg/issues/79">Issue #79</a>, by bjornhoeksel
* loReg.OBJCODE = C_OBJCODE_MENUOPTION_BARNUM for OTHERWISE too,
* just move it out of the case
*!* </change>
*!* </pdm>

                        loReg.OBJCODE = C_OBJCODE_MENUOPTION_BARNUM

*!* /Changd By: LScheffler 16.3.2022
*!* /Changd By: LScheffler 22.4.2021
                        loReg.LevelName     = Alltrim( Strextract( tcLine, ' OF ', ' PROMPT ' ) )

                        If Upper(loReg.LevelName) # Upper(.c_ParentName)
                            Exit
                        Endif

                        loReg.Prompt        = Alltrim( Strextract( tcLine, ' PROMPT ', ';', 1, 2 ) )
                        loReg.Prompt        = Substr( loReg.Prompt, 2, Len( loReg.Prompt ) - 2 )

*-- ANALISIS DEL "DEFINE BAR"
                        Do Case
                            Case ';' $ tcLine

                                For I = m.I + 1 To tnCodeLines
                                    .set_Line( @tcLine, @taCodeLines, m.I )

                                    If Empty(loReg.Comment) && No volver a buscar el comentario si ya existe
*-- Busco si tiene comentario
                                        If .get_SeparatedLineAndComment( @tcLine, @lcComment )
                                            loReg.Comment   = Strtran( Strtran( lcComment, '<CR>', Chr(13) ), '<LF>', Chr(10) )
                                        Endif
                                    Endif

*!* Changd By: BH 30.3.2022
*!* <pdm>
*!* <change date="{^2022-03-16,19:41:00}">Changd By: BH <br />
*!* <a href"https://github.com/fdbozzo/foxbin2prg/issues/80">Issue #80</a>, by bjornhoeksel
*!*     Support ; sign in skip for expression between quotes
*!* </change>
*!* </pdm>
                                    lcLineNoStrings = This.remove_strings(tcLine)
                                    lnLineEnd = Occurs(";", lcLineNoStrings)

                                    If lnLineEnd > 0
* We have ; end line markers not between quotes
* Calc first ; not between quotes

*!* Changd By: BH 10.5.2022
*!* <pdm>
*!* <change date="{^2022-05-10,14:20:00}">Changd By: BH <br />
*!* <a href"https://github.com/fdbozzo/foxbin2prg/issues/83">Issue #83</a>, by DanLauer
*!*     Fix menu bars with shortcuts keys like KEY F6, "F6"; are lost.
*!* </change>
*!* </pdm>
                                        lnLineEnd = Occurs(";", tcLine) -  lnLineEnd + 1
*!* /Changd By: BH 10.5.2022
                                    Else
* No line markers not between quotes
                                        lnLineEnd = 0
                                    Endif

*!* Changed by: LScheffler 8.6.2022
*!* <pdm>
*!* <change date="{^2022-06-08,16:16:00}">Changed by: LScheffler<br />
*!* https://github.com/fdbozzo/foxbin2prg/issues/84 / Multiple text2bin and bin2text conversion on MNX causes space grow
*!* Bin2Text is formated like "xxx ;", trailing space must be removed, TRIM() added for SKIP FOR and PICTRES
*!* </change>
*!* </pdm>
                                    Do Case
                                        Case Left( tcLine, 10 ) == 'NEGOTIATE '
                                            lcExpr  = Alltrim( Strextract( tcLine, 'NEGOTIATE ', ';', 1, 2 ) )
                                            lnNegContainer  = Int( At( ',' + Padr( Alltrim(Getwordnum( lcExpr, 1, ',' )), 6, '_' ) ;
                                                , '______,NONE__,LEFT__,MIDDLE,RIGHT_' ) / 7 - 1 )
                                            lnNegObject     = Int( At( ',' + Padr( Alltrim(Getwordnum( lcExpr, 2, ',' )), 6, '_' ) ;
                                                , '______,NONE__,LEFT__,MIDDLE,RIGHT_' ) / 7 - 1 )
                                            loReg.Location  = lnNegContainer + lnNegObject * 2^4

                                        Case Left( tcLine, 4 ) == 'KEY '
                                            lcExpr  = Alltrim( Strextract( tcLine, 'KEY ') )
                                            If lnLineEnd > 0
                                                lcExpr = Substr(lcExpr, 1, Atc(';', lcExpr, lnLineEnd)-1)
                                            Endif

                                            lnPos   = At( ',', lcExpr )
                                            loReg.KEYNAME   = Alltrim( Left( lcExpr, lnPos-1 ) )
                                            loReg.KeyLabel  = Alltrim( Strextract( lcExpr, '"', '"' ) )

                                        Case Left( tcLine, 9 ) == 'SKIP FOR '
                                            loReg.SkipFor   = Alltrim( Strextract( tcLine, 'SKIP FOR ') )
                                            If lnLineEnd > 0
*!* Changed by: LScheffler 8.6.2022
                                                loReg.SkipFor = Trim( Substr( loReg.SkipFor, 1, Atc(';', loReg.SkipFor, lnLineEnd)-1) )
                                            Endif


                                        Case Left( tcLine, 8 ) == 'MESSAGE '
                                            loReg.Message   = Alltrim( Substr( tcLine, 9 ) )

                                        Case Left( tcLine, 8 ) == 'PICTURE '
                                            loReg.RESNAME   = Alltrim( Strextract( tcLine, '"', '"' ) )

                                        Case Left( tcLine, 8 ) == 'PICTRES '
                                            loReg.RESNAME   = Alltrim( Strextract( tcLine, 'PICTRES ') )

                                            If lnLineEnd > 0
*!* Changed by: LScheffler 8.6.2022
                                                loReg.RESNAME = Trim( Substr( loReg.RESNAME, 1, Atc(';', loReg.RESNAME, lnLineEnd)-1) )
                                            Else

                                            Endif
                                            loReg.SYSRES    = 1

                                        Otherwise
* Nada
                                    Endcase
*!* /Changed by: LScheffler 8.6.2022
*!* /Changd By: BH 30.3.2022


                                    If Not ';' $ tcLine && Fin
                                        Exit
                                    Endif
                                Endfor

                            Case .set_Line( @tcLine, @taCodeLines, m.I ) And .get_SeparatedLineAndComment( @tcLine, @lcComment )
*-- Es un Bar de una sola línea y con comentarios
                                loReg.Comment   = Strtran( Strtran( lcComment, '<CR>', Chr(13) ), '<LF>', Chr(10) )

                        Endcase

*!* Changd By: LScheffler 22.4.2021
*!* <pdm>
*!* <change date="{^2021-04-22,15:26:00}">Changd By: LScheffler<br />
*!* This is not valid here - "_" is never set in get_DefineBarText
*!* </change>
*!* </pdm>

*!*                         If Left(lcBarName,1) == '_'
*!* *-- Es un BAR del Sistema, así que no tiene ON BAR ni nada más.
*!*                             loReg.OBJCODE   = C_OBJCODE_MENUOPTION_BARNUM   && Bar#
*!*                             I = m.I + 1
*!*                             Exit
*!*                         Endif

*!* /Changd By: LScheffler 22.4.2021


* Estructuras ejemplo a analizar:
*--------------------------------
*   ON BAR _3YM1DR90Z OF _MSYSMENU ACTIVATE POPUP OpciónA_CS
*   ON BAR _3YM1DR90Z OF _MSYSMENU wait window "algo"
*   ON BAR _3YM1DR90Z OF _MSYSMENU DO Menu1_Opción_A_2_Sub_SNIPPET
*   ON SELECTION BAR 1 OF Contracts DO BAR_1_OF_Contracts_FB2P
*--------------------------------

*-- ANALISIS DEL "ON BAR" U "ON SELECTION BAR"
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case Inlist( Left( tcLine, 11 ), 'DEFINE BAR ', 'DEFINE PAD ' )
*-- Se encontró el siguiente DEFINE BAR/PAD, por lo que el analizado es de tipo #BAR vacío
*-- y no tiene ON BAR ni nada más.
                                    loReg.OBJCODE   = C_OBJCODE_MENUOPTION_BARNUM   && Bar#
                                    Exit

                                Case Left( tcLine, 7 ) == 'ON BAR '
                                    loReg.OBJCODE   = C_OBJCODE_MENUOPTION_SUBMENU  && Submenu

                                    I = m.I + 1
                                    Exit

                                Case Left( tcLine, 17 ) == 'ON SELECTION BAR '
                                    lcExpr  = Alltrim( Strextract( tcLine, ' OF ' + loReg.LevelName + ' ', '', 1, 2 ) )
                                    .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, @C_FB2PRG_CODE, -1, .F. )

                                    Do Case
                                        Case Not Empty(lcProcCode)
                                            loReg.Procedure = Strtran( lcProcCode, '<<ProcName>>', lcProcName )

                                            If Empty( loReg.Procedure )
                                                loReg.OBJCODE   = C_OBJCODE_MENUOPTION_COMMAND
                                                loReg.Command   = lcExpr
                                            Else
                                                loReg.OBJCODE   = C_OBJCODE_MENUOPTION_PROCEDURE
                                                loReg.ProcType  = 1
                                            Endif

                                        Otherwise
                                            loReg.OBJCODE   = C_OBJCODE_MENUOPTION_COMMAND  && Command
                                            loReg.Command   = lcExpr

                                    Endcase

                                    I = m.I + 1
                                    Exit

                                Case Left( tcLine, 19 ) == 'ON SELECTION POPUP '
                                    Exit

                                Otherwise
* Nada
                            Endcase

                            If Not ';' $ tcLine && Fin
                                I = m.I + 1
                                Exit
                            Endif
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



    Procedure analyzeCodeBlock_DefinePAD
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
* taCodeLines               (!@ IN    ) Array de líneas del programa analizado
* I                         (!@ IN/OUT) Número de línea en análisis
* tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
* toConversor               (v! IN    ) Referencia al conversor para poder usar sus métodos
*---------------------------------------------------------------------------------------------------
        Lparameters tcLine, taCodeLines, I, tnCodeLines, toConversor

        #If .F.
            Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
        #Endif

        Try
                Local llBloqueEncontrado, lcText, loReg, lnPos, lcPadName, lcExpr, lcComment, lcProcName, lcProcCode, loEx As Exception ;
                    , lnNegContainer, lnNegObject
                Store .Null. To loReg
                Store '' To lcText, lcComment, lcPadName

* Estructura ejemplo a analizar:
*--------------------------------
*       DEFINE PAD _3YM1DR90Z OF _MSYSMENU PROMPT "Opción A con submenú" COLOR SCHEME 3 ;
*           NEGOTIATE NONE, LEFT ;
*           KEY DEL, "Pulsar <DEL>" ;
*           SKIP FOR SKIP_FOR() ;
*           MESSAGE "Mensaje para Opción A con submenú" && Comentario
*
*       ON PAD _3YM1DR90Z OF _MSYSMENU ACTIVATE POPUP OpciónA_CS
*--------------------------------
                If Left( tcLine, 11 ) == 'DEFINE PAD '
                    llBloqueEncontrado  = .T.

                    With This As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                        loReg               = .oReg
                        loReg.ObjType       = C_OBJTYPE_MENUTYPE_OPTION
                        lcPadName           = Alltrim( Strextract( tcLine, 'PAD ' , ' OF' ) )

*!* Changd By: LScheffler 22.4.2021
*!* <pdm>
*!* <change date="{^2021-04-22,15:56:00}">Changd By: LScheffler<br />
*!* Old style determines generic name from set name by testing as digit. It could be only digit. :(
*!* New style wraps it in ", so anything in " is set name
*!* </change>
*!* </pdm>

*!*                         loReg.Name          = lcPadName
                        If Left ( m.lcPadName, 1 ) = '"' Then
                            lcPadName       = Substr( m.lcPadName, 2, Len( m.lcPadName ) - 2 )
                            loReg.Name      = m.lcPadName

*!* Changed by: LScheffler 18.1.2022
*!* <pdm>
*!* <change date="{^2022-01-18,19:34:00}">Changed by LScheffler<br />
*!* <a href"https://github.com/fdbozzo/foxbin2prg/issues/74">Issue 74</a>, by Jimrnelson
*!* Does not work for padname without '"'.
*!* </change>
*!* </pdm>
                        Else  &&LEFT ( m.lcPadName, 1 ) = '"'
                            loReg.Name      = m.lcPadName
*!* /Changed by LScheffler 18.1.2022

                        Endif &&LEFT ( m.lcPadName, 1 ) = '"'

*!* /Changd By: LScheffler 22.4.2021
                        loReg.LevelName     = Alltrim( Strextract( tcLine, ' OF ', ' PROMPT ' ) )

                        If Upper(loReg.LevelName) # Upper(.c_ParentName)
                            Exit
                        Endif

                        loReg.Prompt        = Alltrim( Strextract( tcLine, ' PROMPT ', ' COLOR ' ) )
                        loReg.Prompt        = Substr( loReg.Prompt, 2, Len( loReg.Prompt ) - 2 )

*-- ANALISIS DEL "DEFINE PAD"
                        Do Case
                            Case ';' $ tcLine
                                For I = m.I + 1 To tnCodeLines
                                    .set_Line( @tcLine, @taCodeLines, m.I )

                                    If Empty(loReg.Comment) && No volver a buscar el comentario si ya existe
*-- Busco si tiene comentario
                                        If .get_SeparatedLineAndComment( @tcLine, @lcComment )
                                            loReg.Comment   = Strtran( Strtran( lcComment, '<CR>', Chr(13) ), '<LF>', Chr(10) )
                                        Endif
                                    Endif

                                    Do Case
                                        Case Left( tcLine, 10 ) == 'NEGOTIATE '
                                            lcExpr  = Alltrim( Strextract( tcLine, 'NEGOTIATE ', ';', 1, 2 ) )
                                            lnNegContainer  = Int( At( ',' + Padr( Alltrim(Getwordnum( lcExpr, 1, ',' )), 6, '_' ) ;
                                                , '______,NONE__,LEFT__,MIDDLE,RIGHT_' ) / 7 - 1 )
                                            lnNegObject     = Int( At( ',' + Padr( Alltrim(Getwordnum( lcExpr, 2, ',' )), 6, '_' ) ;
                                                , '______,NONE__,LEFT__,MIDDLE,RIGHT_' ) / 7 - 1 )
                                            loReg.Location  = lnNegContainer + lnNegObject * 2^4

                                        Case Left( tcLine, 4 ) == 'KEY '
                                            lcExpr  = Alltrim( Strextract( tcLine, 'KEY ', ';', 1, 2 ) )
                                            lnPos   = At( ',', lcExpr )
                                            loReg.KEYNAME   = Alltrim( Left( lcExpr, lnPos-1 ) )
                                            loReg.KeyLabel  = Alltrim( Strextract( lcExpr, '"', '"' ) )

                                        Case Left( tcLine, 9 ) == 'SKIP FOR '
                                            loReg.SkipFor   = Alltrim( Strextract( tcLine, 'SKIP FOR ', ';', 1, 2 ) )

                                        Case Left( tcLine, 8 ) == 'MESSAGE '
                                            loReg.Message   = Alltrim( Substr( tcLine, 9 ) )

                                        Case Left( tcLine, 8 ) == 'PICTURE '
                                            loReg.RESNAME   = Alltrim( Strextract( tcLine, '"', '"' ) )

                                        Case Left( tcLine, 8 ) == 'PICTRES '
                                            loReg.RESNAME   = Alltrim( Strextract( tcLine, 'PICTRES ', ';', 1, 2 ) )
                                            loReg.SYSRES    = 1

                                        Otherwise
* Nada
                                    Endcase

                                    If Not ';' $ tcLine && Fin
                                        Exit
                                    Endif
                                Endfor

                            Case .set_Line( @tcLine, @taCodeLines, m.I ) And .get_SeparatedLineAndComment( @tcLine, @lcComment )
*-- Es un Bar de una sola línea y con comentarios
                                loReg.Comment   = Strtran( Strtran( lcComment, '<CR>', Chr(13) ), '<LF>', Chr(10) )

                        Endcase


* Estructuras ejemplo a analizar:
*--------------------------------
*   ON PAD _3YM1DR90Z OF _MSYSMENU ACTIVATE POPUP OpciónA_CS
*   ON PAD _3YM1DR90Z OF _MSYSMENU wait window "algo"
*   ON PAD _3YM1DR90Z OF _MSYSMENU DO Menu1_Opción_A_2_Sub_SNIPPET
*--------------------------------

*-- ANALISIS DEL "ON PAD" u "ON SELECTION PAD"
                        For I = m.I + 1 To tnCodeLines
                            .set_Line( @tcLine, @taCodeLines, m.I )

                            Do Case
                                Case Empty( tcLine )
                                    Loop

                                Case Left( tcLine, 7 ) == 'ON PAD '
                                    loReg.OBJCODE   = C_OBJCODE_MENUOPTION_SUBMENU  && Submenu

                                    I = m.I + 1
                                    Exit

                                Case Left( tcLine, 17 ) == 'ON SELECTION PAD '
                                    lcExpr  = Alltrim( Strextract( tcLine, ' OF ' + loReg.LevelName + ' ', '', 1, 2 ) )
                                    .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, @C_FB2PRG_CODE, -1, .F. )

                                    Do Case
                                        Case Empty(lcProcCode)
                                            loReg.OBJCODE   = C_OBJCODE_MENUOPTION_COMMAND
                                            loReg.Command   = lcExpr

                                        Otherwise
                                            loReg.Procedure = Strtran( lcProcCode, '<<ProcName>>', lcProcName )

                                            If Empty( loReg.Procedure )
                                                loReg.OBJCODE   = C_OBJCODE_MENUOPTION_COMMAND
                                                loReg.Command   = lcExpr
                                            Else
                                                loReg.OBJCODE   = C_OBJCODE_MENUOPTION_PROCEDURE
                                                loReg.ProcType  = 1
                                            Endif

                                    Endcase

                                    I = m.I + 1
                                    Exit

                                Otherwise
* Nada
                            Endcase

                            If Not ';' $ tcLine && Fin
                                I = m.I + 1
                                Exit
                            Endif
                        Endfor

                        I = m.I - 1
                    Endwith && THIS
                Endif


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loReg
                Release tcLine, taCodeLines, I, tnCodeLines, toConversor ;
                    , lcText, loReg, lnPos, lcPadName, lcExpr, lcComment, lcProcName, lcProcCode, lnNegContainer, lnNegObject

        Endtry

        Return llBloqueEncontrado
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toParentReg               (v? IN    ) Objeto registro Padre
* tnNivel                   (v? IN    ) Nivel para indentar
* tcEndProcedures           (!@    OUT) Agregar aquí los procedimientos que irán al final
* toHeader                  (v! IN    ) Objeto Registro de cabecera del menu
*---------------------------------------------------------------------------------------------------
        Lparameters toParentReg, tnNivel, tcEndProcedures, toHeader

        Try
                Local loReg, I, lcText, lcTab, lcExpr, lcProcName, lcProcCode, loEx As Exception ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG' ;
                    , loOption As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                Store .Null. To loOption, loBarPop, loReg
                lcText      = ''
                lcProcName  = ''

                With This As CL_MENU_OPTION Of 'FOXBIN2PRG.PRG'
                    loReg       = .oReg
                    lcTab       = Replicate(Chr(9),tnNivel)
                    loBarPop    = toParentReg

*-- Options (ObjType:3 = C_OBJTYPE_MENUTYPE_OPTION)
                    Do Case
                        Case toParentReg.ObjType = C_OBJTYPE_MENUTYPE_BARorPOPUP And toParentReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUPAD
*-- Define Bar
                            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<.get_DefineBarText(loReg, loBarPop, tnNivel, toHeader)>>
                            ENDTEXT

                        Case toParentReg.ObjType = C_OBJTYPE_MENUTYPE_BARorPOPUP And toParentReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUBAR ;
                                AND (toHeader.ObjType = C_OBJTYPE_MENUTYPE_DEFAULT Or toHeader.ObjType = C_OBJTYPE_MENUTYPE_MENUBARONTOP)
*-- Define Pad
                            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                            <<.get_DefinePadText(loReg, loBarPop, tnNivel, toHeader)>>
                            ENDTEXT

                    Endcase

                    If loReg.OBJCODE = C_OBJCODE_MENUOPTION_PROCEDURE   && Procedure de BAR o PAD
*-- Reemplazo el nombre definitivo
                        lcExpr      = loReg.Procedure
                        .AnalizarSiExpresionEsComandoOProcedimiento( lcExpr, @lcProcName, @lcProcCode, '', 1, .T., .T. )

                        If Empty(lcProcCode)
*-- Comando
                            If Empty(lcExpr)
                                lcText          = Strtran( lcText, 'DO <<ProcName>>', '' )
                            Else
                                lcText          = Strtran( lcText, 'DO <<ProcName>>', lcExpr )
                            Endif
                        Else

*-- Procedure
                            If Empty(lcProcName)
                                lcProcName  = Chrtran( Alltrim( Strextract( lcText, 'DEFINE ', 'PROMPT ' ) ), ' ', '_' ) + '_FB2P'
                            Endif
                            lcProcCode      = Strtran( lcProcCode, '<<ProcName>>', lcProcName )
                            lcText          = Strtran( lcText, '<<ProcName>>', lcProcName )
                            tcEndProcedures = tcEndProcedures + lcProcCode + CR_LF
                        Endif
                    Endif


*-- Menu Bar or Popup (ObjType:2 [C_OBJTYPE_MENUTYPE_BARorPOPUP], ObjCode:0 ó 1 [C_OBJCODE_MENUBARPOPUP_MENUPAD o C_OBJCODE_MENUBARPOPUP_MENUBAR])
                    If .Count > 0
                        For Each loBarPop In This FoxObject
                            If toParentReg.ObjType = C_OBJTYPE_MENUTYPE_BARorPOPUP ;
                                    AND toParentReg.OBJCODE = C_OBJCODE_MENUBARPOPUP_MENUBAR  ;
                                    AND toHeader.ObjType = C_OBJTYPE_MENUTYPE_SHORTCUT
*-- Shortcut
                                lcText      = lcText + loBarPop.toText(loReg, tnNivel + 0, @tcEndProcedures, toHeader)
                            Else
*-- Menu
                                lcText      = lcText + loBarPop.toText(loReg, tnNivel + 1, @tcEndProcedures, toHeader)
                            Endif
                        Endfor
                    Endif
                Endwith && THIS


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loOption, loBarPop, loReg
                Release loReg, I, lcTab, lcExpr, lcProcName, lcProcCode, loBarPop, loOption

        Endtry

        Return lcText
    Endproc


    Procedure get_DefineBarText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toReg                     (v? IN    ) Objeto registro
* toBarPop                  (v? IN    ) Bar o Popup hijo
* tnNivel                   (v? IN    ) Nivel para indentar
* toHeader                  (v! IN    ) Objeto Registro de cabecera del menu
*---------------------------------------------------------------------------------------------------
        Lparameters toReg, toBarPop, tnNivel, toHeader

        Try
                Local lcText, lcTab, loEx As Exception ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG' ;
                    , lcName , lcName2
                Store .Null. To loBarPop
                lcTab       = Replicate(Chr(9),tnNivel)
                lcText      = ''
*!* Changed by LScheffler 22.4.2021
*!* <pdm>
*!* <change date="{^2021-04-22,06:24:00}">Changed by LScheffler<br />
*!* If the BAR real name starts (legaly) with a digit it could not be recreated
*!* added code to add additional information to recreate the name
*!* name will wrap into " , so we got DEFINE BAR "Number" OF
*!* also use variable on all places instead of EVL(..
*!* </change>
*!* </pdm>
                If !Empty(toReg.Name) And Isdigit( toReg.Name ) Then
                    lcName  = Alltrim( toReg.Name )
                    lcName2 = '"' + Alltrim(toReg.Name) + '"'
                Else  &&!Empty(toReg.Name) And ISDIGIT( toReg.Name )
                    lcName  = Alltrim( Evl( toReg.Name, toReg.ItemNum ) )
                    lcName2 = m.lcName
                Endif &&!Empty(toReg.Name) And ISDIGIT( toReg.Name )

* LScheffler
* location of definition  of MENU BAR Evl( toReg.Name, toReg.ItemNum )
* /LScheffler
*-- DEFINE BAR
*lcText = lcTab + '*----------------------------------' + CR_LF
                lcText  = lcText + lcTab + 'DEFINE BAR ' + m.lcName2 + ' OF ' + Alltrim(toReg.LevelName) ;
                    + ' PROMPT "' + toReg.Prompt + '"'

                If Not Empty(toReg.KEYNAME)
                    lcText  = lcText + ' ;' + CR_LF + lcTab + ' KEY ' + toReg.KEYNAME + ', "' + toReg.KeyLabel + '"'
                Endif

                If Not Empty(toReg.SkipFor)
                    lcText  = lcText + ' ;' + CR_LF + lcTab + ' SKIP FOR ' + toReg.SkipFor
                Endif

                If Not Empty(toReg.RESNAME)
                    If toReg.SYSRES = 1
                        lcText  = lcText + ' ;' + CR_LF + lcTab + ' PICTRES ' + toReg.RESNAME
                    Else
                        lcText  = lcText + ' ;' + CR_LF + lcTab + ' PICTURE "' + toReg.RESNAME + '"'
                    Endif
                Endif

                If Not Empty(toReg.Message)
                    lcText  = lcText + ' ;' + CR_LF + lcTab + ' MESSAGE ' + toReg.Message
                Endif

                If Not Empty(toReg.Comment)
                    lcText  = lcText + ' &' + '& ' + Strtran( Strtran( toReg.Comment, Chr(13), '<CR>' ), Chr(10), '<LF>' )
                Endif

*-- ON BAR
                If toReg.OBJCODE <> C_OBJCODE_MENUOPTION_BARNUM && Bar#
                    lcText  = lcText + CR_LF

                    If toReg.OBJCODE = C_OBJCODE_MENUOPTION_SUBMENU && Submenu
                        loBarPop    = This.Item(1).oReg
                        lcText  = lcText + lcTab + 'ON BAR ' + m.lcName + ' OF ' + Alltrim(toReg.LevelName) ;
                            + ' ACTIVATE POPUP ' + Alltrim(loBarPop.Name)
                    Else
                        lcText  = lcText + lcTab + 'ON SELECTION BAR ' + m.lcName + ' OF ' + Alltrim(toReg.LevelName)

                        Do Case
                            Case toReg.OBJCODE = C_OBJCODE_MENUOPTION_COMMAND   && Command
                                If Not Empty(toReg.Command)
                                    lcText  = lcText + ' ' + Alltrim(toReg.Command)
                                Endif
                            Case toReg.OBJCODE = C_OBJCODE_MENUOPTION_PROCEDURE && Procedure
                                If Not Empty(toReg.Procedure)
                                    lcText  = lcText + ' DO <<ProcName>>'
                                Endif
                        Endcase
                    Endif
                Endif

                lcText  = lcText + CR_LF

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loBarPop
                Release lcTab, loBarPop

        Endtry
*!* /Changed by LScheffler 22.4.2021

        Return lcText
    Endproc


    Procedure get_DefinePadText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* toReg                     (v? IN    ) Objeto registro
* toBarPop                  (v? IN    ) Bar o Popup hijo
* tnNivel                   (v? IN    ) Nivel para indentar
* toHeader                  (v! IN    ) Objeto Registro de cabecera del menu
*---------------------------------------------------------------------------------------------------
        Lparameters toReg, toBarPop, tnNivel, toHeader
*!* Changed by LScheffler 21.4.2021
*!* <pdm>
*!* <change date="{^2021-04-21,22:33:00}">Changed by LScheffler<br />
*!* If the PAD real name starts (leagly) with "_" it could not be recreated
*!* added code to add additional information to recreate the name
*!* name will simple wrapped into ", so we got DEFINE PAD "_Name" OF
*!* </change>
*!* </pdm>

        Try
                Local lcText, lcTab, lnContainer, lnObject, loEx As Exception ;
                    , loBarPop As CL_MENU_BARPOP Of 'FOXBIN2PRG.PRG' ;
                    , lcName2
                Store .Null. To loBarPop
                lcTab       = Replicate(Chr(9),tnNivel)
                If !Empty(toReg.Name) And Left( toReg.Name, 1 ) = '_' Then
                    lcName2     = '"' + Alltrim(toReg.Name) + '"'
                    toReg.Name  = toReg.Name
                Else  &&!EMPTY(toReg.Name) AND toReg.Name = '_'
                    toReg.Name  = Evl(toReg.Name, '_' + Transform( Int( Val( toReg.ItemNum ) ), '@L #########') )
                    lcName2     = Alltrim(toReg.Name)
                Endif &&!EMPTY(toReg.Name) AND toReg.Name = '_'
*!* /Changed by LScheffler 21.4.2021

                lcText      = ''

*-- DEFINE PAD
*lcText = lcTab + '*----------------------------------' + CR_LF
                lcText  = lcText + lcTab + 'DEFINE PAD ' + m.lcName2 + ' OF ' + Alltrim(toReg.LevelName) ;
                    + ' PROMPT "' + toReg.Prompt + '"' ;
                    + ' COLOR SCHEME ' + Transform(toBarPop.Scheme)

                If Not Empty(toReg.Location)
                    lnContainer = toReg.Location % 2^4
                    lnObject    = Int( (toReg.Location - lnContainer) / 2^4 )
                    lcText      = lcText + ' ;' + CR_LF + lcTab + ' NEGOTIATE ' + Getwordnum('NONE,LEFT,MIDDLE,RIGHT',lnContainer+1,',') ;
                        + ', ' + Getwordnum('NONE,LEFT,MIDDLE,RIGHT',lnObject+1,',')
                Endif

                If Not Empty(toReg.KEYNAME)
                    lcText  = lcText + ' ;' + CR_LF + lcTab + ' KEY ' + toReg.KEYNAME + ', "' + toReg.KeyLabel + '"'
                Endif

                If Not Empty(toReg.SkipFor)
                    lcText  = lcText + ' ;' + CR_LF + lcTab + ' SKIP FOR ' + toReg.SkipFor
                Endif

                If Not Empty(toReg.RESNAME)
                    If toReg.SYSRES = 1
                        lcText  = lcText + ' ;' + CR_LF + lcTab + ' PICTRES ' + toReg.RESNAME
                    Else
                        lcText  = lcText + ' ;' + CR_LF + lcTab + ' PICTURE "' + toReg.RESNAME + '"'
                    Endif
                Endif

                If Not Empty(toReg.Message)
                    lcText  = lcText + ' ;' + CR_LF + lcTab + ' MESSAGE ' + toReg.Message
                Endif

                If Not Empty(toReg.Comment)
                    lcText  = lcText + ' &' + '& ' + Strtran( Strtran( toReg.Comment, Chr(13), '<CR>' ), Chr(10), '<LF>' )
                Endif

                lcText  = lcText + CR_LF

*-- ON PAD
                If toReg.OBJCODE <> C_OBJCODE_MENUOPTION_BARNUM && Bar#
                    lcText  = lcText + CR_LF

                    If toReg.OBJCODE = C_OBJCODE_MENUOPTION_SUBMENU && Submenu
                        loBarPop    = This.Item(1).oReg
                        lcText  = lcText + lcTab + 'ON PAD ' + Alltrim(toReg.Name) + ' OF ' + Alltrim(toReg.LevelName) ;
                            + ' ACTIVATE POPUP ' + Alltrim(loBarPop.Name)
                    Else
                        lcText  = lcText + lcTab + 'ON SELECTION PAD ' + Alltrim(toReg.Name) + ' OF ' + Alltrim(toReg.LevelName)

                        Do Case
                            Case toReg.OBJCODE = C_OBJCODE_MENUOPTION_COMMAND   && Command
                                If Not Empty(toReg.Command)
                                    lcText  = lcText + ' ' + Alltrim(toReg.Command)
                                Endif
                            Case toReg.OBJCODE = C_OBJCODE_MENUOPTION_PROCEDURE && Procedure
                                If Not Empty(toReg.Procedure)
                                    lcText  = lcText + ' DO <<ProcName>>'
                                Endif
                        Endcase
                    Endif
                Endif

                lcText  = lcText + CR_LF

            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Store .Null. To loBarPop
                Release lcTab, lnContainer, lnObject, loBarPop

        Endtry

        Return lcText
    Endproc


    Procedure updateMENU
    Endproc


Enddefine


Define Class CL_DBF_UTILS As Session
    _MemberData = [<VFPData>] ;
        + [<memberdata name="fields" display="Fields"/>] ;
        + [<memberdata name="c_backlink_dbc_name" display="c_Backlink_DBC_Name"/>] ;
        + [<memberdata name="c_filename" display="c_FileName"/>] ;
        + [<memberdata name="n_headersize" display="n_HeaderSize"/>] ;
        + [<memberdata name="n_filesize" display="n_FileSize"/>] ;
        + [<memberdata name="c_lastupdate" display="c_LastUpdate"/>] ;
        + [<memberdata name="n_debug" display="n_Debug"/>] ;
        + [<memberdata name="l_filehascdx" display="l_FileHasCDX"/>] ;
        + [<memberdata name="l_fileisdbc" display="l_FileIsDBC"/>] ;
        + [<memberdata name="l_filehasmemo" display="l_FileHasMemo"/>] ;
        + [<memberdata name="n_codepage" display="n_CodePage"/>] ;
        + [<memberdata name="c_codepagedesc" display="c_CodePageDesc"/>] ;
        + [<memberdata name="n_datarecordlength" display="n_DataRecordLength"/>] ;
        + [<memberdata name="n_fieldcount" display="n_FieldCount"/>] ;
        + [<memberdata name="n_hexfiletype" display="n_HexFileType"/>] ;
        + [<memberdata name="n_numberofrecords" display="n_NumberOfRecords"/>] ;
        + [<memberdata name="n_numberofrecordsreal" display="n_NumberOfRecordsReal"/>] ;
        + [<memberdata name="n_posoffirstdatarecord" display="n_PosOfFirstDataRecord"/>] ;
        + [<memberdata name="filetypedescription" display="fileTypeDescription"/>] ;
        + [<memberdata name="getcodepageinfo" display="getCodePageInfo"/>] ;
        + [<memberdata name="getdbfmetadata" display="getDBFmetadata"/>] ;
        + [<memberdata name="get_bintableflags" display="get_BinTableFlags"/>] ;
        + [<memberdata name="get_numtableflags" display="get_NumTableFlags"/>] ;
        + [<memberdata name="get_structure" display="get_Structure"/>] ;
        + [<memberdata name="set_bintableflags" display="set_BinTableFlags"/>] ;
        + [<memberdata name="set_numtableflags" display="set_NumTableFlags"/>] ;
        + [<memberdata name="totext" display="toText"/>] ;
        + [<memberdata name="write_dbc_backlink" display="write_DBC_BackLink"/>] ;
        + [</VFPData>]

    #If .F.
        Local This As CL_DBF_UTILS Of 'FOXBIN2PRG.PRG'
    #Endif

    n_Debug                 = 0
    c_Backlink_DBC_Name     = ''
    c_FileName              = ''
    n_FileSize              = 0
    n_HeaderSize            = 0
    c_LastUpdate            = ''
    l_FileHasCDX            = .F.
    l_FileIsDBC             = .F.
    l_FileHasMemo           = .F.
    n_CodePage              = 0
    c_CodePageDesc          = ''
    n_DataRecordLength      = 0
    n_HexFileType           = 0
    n_FieldCount            = 0
    n_NumberOfRecords       = 0
    n_NumberOfRecordsReal   = 0
    n_PosOfFirstDataRecord  = 0
    Fields                  = .Null.


    Procedure Init
        This.Fields = Createobject("COLLECTION")
    Endproc


    Procedure getDBFmetadata
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_FileName               (v! IN    ) Nombre del DBF a analizar
* tn_HexFileType            (@?    OUT) Tipo de archivo en hexadecimal (Está detallado en la ayuda de Fox)
* tl_FileHasCDX             (@?    OUT) Indica si el archivo tiene CDX asociado
* tl_FileHasMemo            (@?    OUT) Indica si el archivo tiene archivo MEMO asociado
* tl_FileIsDBC              (@?    OUT) Indica si el archivo es un DBC (base de datos)
* tcDBC_Name                (@?    OUT) Si tiene DBC, contiene el nombre del DBC asociado
*---------------------------------------------------------------------------------------------------
        Lparameters tc_FileName, tn_HexFileType, tl_FileHasCDX, tl_FileHasMemo, tl_FileIsDBC, tcDBC_Name

        Try
                Local lnHandle, lcStr, lnDataPos, lnFieldCount, lnVal, I, loEx As Exception ;
                    , lnCodePage, lcCodePageDesc, lnFileLength ;
                    , loField As CL_DBF_UTILS_FIELD Of 'FOXBIN2PRG.PRG'
                Store .Null. To loField
                tn_HexFileType  = 0
                Store '' To tcDBC_Name, lcStr
                lnHandle        = Fopen(tc_FileName,0)
                lnFileLength    = Fseek(lnHandle,0,2)
                = Fseek(lnHandle,0)

                If lnHandle = -1
                    Exit
                Endif

*                                                       Bytes       Description
*------------------------------------------------------ ----------- ------------------------------------------
                With This As CL_DBF_UTILS Of 'FOXBIN2PRG.PRG'
                    .c_FileName                 = tc_FileName
                    lcStr                       = Fread(lnHandle,1)     && 0        File type
                    tn_HexFileType              = Evaluate( Transform(Asc(lcStr),'@0') )

                    Do Case
                        Case lnFileLength < 65
                            Error 15, tc_FileName + ' (FileLength < 65)'
                        Case .fileTypeDescription(tn_HexFileType) = 'Unknown'
                            Error 15, tc_FileName
                    Endcase

                    .n_HexFileType              = tn_HexFileType
                    lcStr                       = Fread(lnHandle,3)     && 1-3      Last update (YYMMDD)
                    .c_LastUpdate               = Padl(Asc(Left(lcStr,1)),2,'0') + '/' + Padl(Asc(Substr(lcStr,2,1)),2,'0') + '/' + Padl(Asc(Right(lcStr,1)),2,'0')
                    lcStr                       = Fread(lnHandle,4)     && 4-7      Number of records in file
                    .n_NumberOfRecords          = CToBin(lcStr,"4RS")
                    lcStr                       = Fread(lnHandle,2)     && 8-9      Position of first data record
                    .n_PosOfFirstDataRecord     = CToBin(lcStr,"2RS")
                    .n_HeaderSize               = Int(.n_PosOfFirstDataRecord + 1)
                    If Inlist(tn_HexFileType, 0x30, 0x31, 0x32) Then
                        .n_FieldCount   = Int( (.n_PosOfFirstDataRecord - 296) / 32 )   && Visual FoxPro
                    Else
                        .n_FieldCount   = Int( (.n_PosOfFirstDataRecord - 33) / 32 )
                    Endif
                    lcStr                       = Fread(lnHandle,2)     && 10-11    Length of one data record, including delete flag
                    .n_DataRecordLength         = CToBin(lcStr,"2RS")
                    lcStr                       = Fread(lnHandle,16)    && 16-27    Reserved
                    lcStr                       = Fread(lnHandle,1)     && 28       Table flags: 0x01=Has CDX, 0x02=Has Memo, 0x04=Id DBC (flags acumulativos)
                    .l_FileHasCDX               = ( Bitand( Evaluate(Transform(Asc(lcStr),'@0')), 0x01 ) > 0 )
                    .l_FileHasMemo              = ( Bitand( Evaluate(Transform(Asc(lcStr),'@0')), 0x02 ) > 0 )
                    .l_FileIsDBC                = ( Bitand( Evaluate(Transform(Asc(lcStr),'@0')), 0x04 ) > 0 )
                    lcStr                       = Fread(lnHandle,1)     && 29       Code page mark (0=, 2=850,3=1252)
                    lnVal                       = Evaluate( Transform(Asc(lcStr),'@0') )
                    .getCodePageInfo( lnVal, @lnCodePage, @lcCodePageDesc )
                    .n_CodePage                 = lnCodePage
                    .c_CodePageDesc             = lcCodePageDesc
                    lcStr                       = Fread(lnHandle,2)     && 30-31    Reserved, contains 0x00
*lcStr                      = FREAD(lnHandle,32 * lnFieldCount) && 32-n         Field subrecords (los salteo)
*---
                    For I = 1 To .n_FieldCount
                        loField = Createobject("CL_DBF_UTILS_FIELD")

                        With loField As CL_DBF_UTILS_FIELD Of 'FOXBIN2PRG.PRG'
                            lcStr                       = Fread(lnHandle,11)
                            .FieldName                  = Rtrim( lcStr, 0, Chr(0), ' ' )
                            lcStr                       = Fread(lnHandle,1)
                            .FieldType                  = lcStr
                            lcStr                       = Fread(lnHandle,4)
                            .FieldDisplacementInRecord  = CToBin(lcStr,"4RS")
                            lcStr                       = Fread(lnHandle,1)
                            .FieldWidth                 = Asc(lcStr)
                            lcStr                       = Fread(lnHandle,1)
                            .FieldDecimals              = Asc(lcStr)
                            lcStr                       = Fread(lnHandle,1)
                            .FieldFlags                 = Asc(lcStr)
                            lcStr                       = Fread(lnHandle,4)
                            .NextValueForAutoInc        = CToBin(lcStr,"4RS")
                            lcStr                       = Fread(lnHandle,1)
                            .StepForAutoInc             = Asc(lcStr)
                            lcStr                       = Fread(lnHandle,8)
                        Endwith

                        .Fields.Add(loField)
                        loField = .Null.
                    Endfor
*---
                    lcStr                       = Fread(lnHandle,1)     && n+1          Header Record Terminator (0x0D)

                    If Inlist(tn_HexFileType, 0x30, 0x31, 0x32) Then
                        lcStr                   = Fread(lnHandle,263)   && n+2 to n+264 Backlink (relative path of an associated database (.dbc) file)
                        tcDBC_Name              = Rtrim(lcStr,0,Chr(0)) && DBC Name (si tiene)
                        .c_Backlink_DBC_Name    = tcDBC_Name
                    Endif

                    .n_FileSize             = Fseek(lnHandle, 0, 2)
                    .n_NumberOfRecordsReal  = Int( (.n_FileSize - .n_HeaderSize) / .n_DataRecordLength )
                Endwith

            Catch To loEx
                loEx.UserValue = loEx.UserValue + 'lcStr = [' + Transform(lcStr) + '] / LenStr = ' + Transform(Len(Transform(lcStr))) + CR_LF
                If loEx.ErrorNo = 11 Then   && Function argument value, type, or count is invalid
                    loEx.UserValue = loEx.UserValue + '> POSSIBLE CORRUPTED TABLE' + CR_LF
                Endif
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Fclose(lnHandle)
                Store .Null. To loField
                Release lcStr, lnDataPos, lnFieldCount, lnVal, I, lnCodePage, lcCodePageDesc, loField

        Endtry

        Return lnHandle
    Endproc


    Procedure fileTypeDescription
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tn_HexFileType            (@? IN    ) Tipo de archivo en hexadecimal (Está detallado en la ayuda de Fox)
*---------------------------------------------------------------------------------------------------
        Lparameters tn_HexFileType
        Local lcFileType

        Do Case
            Case tn_HexFileType = 0x02                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'FoxBASE / dBase II'
            Case tn_HexFileType = 0x03                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'FoxBASE+ / FoxPro /dBase III PLUS / dBase IV, no memo'
            Case tn_HexFileType = 0x05                                                  && http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'dBase V, no memo'
            Case tn_HexFileType = 0x2F                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
                lcFileType  = 'dBase+/dBase III PLUS, no memo'
            Case tn_HexFileType = 0x30                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'Visual FoxPro'
            Case tn_HexFileType = 0x31                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'Visual FoxPro, autoincrement enabled'
            Case tn_HexFileType = 0x32                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'Visual FoxPro, Varchar, Varbinary, or Blob-enabled'
            Case tn_HexFileType = 0x43                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'dBASE IV SQL table files, no memo'
            Case tn_HexFileType = 0x62                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
                lcFileType  = 'dBASE IV SQL table files, no memo'
            Case tn_HexFileType = 0x63                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'dBASE IV SQL system files, no memo'
            Case tn_HexFileType = 0x7B                                                  && http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'dBASE IV, with memo'
            Case tn_HexFileType = 0x82                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
                lcFileType  = 'dBASE IV SQL system files, no memo'
            Case tn_HexFileType = 0x83                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'FoxBASE+/dBASE III PLUS, with memo'
            Case tn_HexFileType = 0x8B                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'dBASE IV with memo'
            Case tn_HexFileType = 0x8E                                                  && http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'dBASE IV with SQL table'
            Case tn_HexFileType = 0xCA                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
                lcFileType  = 'dBASE IV with memo'
            Case tn_HexFileType = 0xCB                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'dBASE IV SQL table files, with memo'
            Case tn_HexFileType = 0xE5                                                  && http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'Clipper SIX driver, with SMT memo'
            Case tn_HexFileType = 0xF5                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'FoxPro 2.x (or earlier) with memo'
            Case tn_HexFileType = 0xFA                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
                lcFileType  = 'FoxPro 2.x (or earlier) with memo'
            Case tn_HexFileType = 0xFB                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
                lcFileType  = 'FoxBASE (with memo?)'
            Otherwise
                lcFileType  = 'Unknown'
        Endcase

        Return lcFileType
    Endproc


    Procedure getCodePageInfo
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tnHexCodePage             (v! IN    ) Código de página en hexadecimal (Está detallado en la ayuda de Fox)
* tnCodePage                (@?    OUT) Código de página normal
* tcDescrip                 (@?    OUT) Descripción del código de página
*---------------------------------------------------------------------------------------------------
        Lparameters tnHexCodePage, tnCodePage, tcDescrip

        Local laCodePage(27,3), lnPos
*Code page  Platform  Code page identifier
        laCodePage( 1,1)    = 437
        laCodePage( 1,2)    = 'U.S. MS-DOS'
        laCodePage( 1,3)    = 0x01

        laCodePage( 2,1)    = 620
        laCodePage( 2,2)    = 'Mazovia (Polish) MS-DOS'
        laCodePage( 2,3)    = 0x69

        laCodePage( 3,1)    = 737
        laCodePage( 3,2)    = 'Greek MS-DOS (437G)'
        laCodePage( 3,3)    = 0x6A

        laCodePage( 4,1)    = 850
        laCodePage( 4,2)    = 'International MS-DOS'
        laCodePage( 4,3)    = 0x02

        laCodePage( 5,1)    = 852
        laCodePage( 5,2)    = 'Eastern European MS-DOS'
        laCodePage( 5,3)    = 0x64

        laCodePage( 6,1)    = 857
        laCodePage( 6,2)    = 'Turkish MS-DOS'
        laCodePage( 6,3)    = 0x6B

        laCodePage( 7,1)    = 861
        laCodePage( 7,2)    = 'Icelandic MS-DOS'
        laCodePage( 7,3)    = 0x67

        laCodePage( 8,1)    = 865
        laCodePage( 8,2)    = 'Nordic MS-DOS'
        laCodePage( 8,3)    = 0x66

        laCodePage( 9,1)    = 866
        laCodePage( 9,2)    = 'Russian MS-DOS'
        laCodePage( 9,3)    = 0x65

        laCodePage(10,1)    = 874
        laCodePage(10,2)    = 'Thai Windows'
        laCodePage(10,3)    = 0x7C

        laCodePage(12,1)    = 895
        laCodePage(12,2)    = 'Kamenicky (Czech) MS-DOS'
        laCodePage(12,3)    = 0x68

        laCodePage(13,1)    = 932
        laCodePage(13,2)    = 'Japanese Windows'
        laCodePage(13,3)    = 0x7B

        laCodePage(14,1)    = 936
        laCodePage(14,2)    = 'Chinese Simplified (PRC, Singapore) Windows'
        laCodePage(14,3)    = 0x7A

        laCodePage(15,1)    = 949
        laCodePage(15,2)    = 'Korean Windows'
        laCodePage(15,3)    = 0x79

        laCodePage(16,1)    = 950
        laCodePage(16,2)    = 'Traditional Chinese (Hong Kong SAR, Taiwan) Windows'
        laCodePage(16,3)    = 0x78

        laCodePage(17,1)    = 1250
        laCodePage(17,2)    = 'Eastern European Windows'
        laCodePage(17,3)    = 0xC8

        laCodePage(18,1)    = 1251
        laCodePage(18,2)    = 'Russian Windows'
        laCodePage(18,3)    = 0xC9

        laCodePage(19,1)    = 1252
        laCodePage(19,2)    = 'Windows ANSI'
        laCodePage(19,3)    = 0x03

        laCodePage(20,1)    = 1253
        laCodePage(20,2)    = 'Greek Windows'
        laCodePage(20,3)    = 0xCB

        laCodePage(21,1)    = 1254
        laCodePage(21,2)    = 'Turkish Windows'
        laCodePage(21,3)    = 0xCA

        laCodePage(22,1)    = 1255
        laCodePage(22,2)    = 'Hebrew Windows'
        laCodePage(22,3)    = 0x7D

        laCodePage(23,1)    = 1256
        laCodePage(23,2)    = 'Arabic Windows'
        laCodePage(23,3)    = 0x7E

        laCodePage(24,1)    = 10000
        laCodePage(24,2)    = 'Standard Macintosh'
        laCodePage(24,3)    = 0x04

        laCodePage(25,1)    = 10006
        laCodePage(25,2)    = 'Greek Macintosh'
        laCodePage(25,3)    = 0x98

        laCodePage(26,1)    = 10007
        laCodePage(26,2)    = 'Russian Macintosh'
        laCodePage(26,3)    = 0x96

        laCodePage(27,1)    = 10029
        laCodePage(27,2)    = 'Macintosh EE'
        laCodePage(27,3)    = 0x97

        lnPos   = Ascan( laCodePage, tnHexCodePage, 1, -1, 3, 8 )

        If lnPos > 0
            tnCodePage  = laCodePage(lnPos,1)
            tcDescrip   = laCodePage(lnPos,2)
        Else
            tnCodePage  = 0
            tcDescrip   = ''
        Endif

        Return
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------
        Local lcText, loField As CL_DBF_UTILS_FIELD Of 'FOXBIN2PRG.PRG'
        lcText  = ''

        With This As CL_DBF_UTILS Of 'FOXBIN2PRG.PRG'
            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                ---------------------------------------------------
                FileName                : <<JUSTFNAME(.c_FileName)>>
                ---------------------------------------------------
                Backlink_DBC_Name       : <<.c_Backlink_DBC_Name>>
                HexFileType             : <<TRANSFORM(.n_HexFileType, '@0')>> - <<.fileTypeDescription(.n_HexFileType)>>
                FileSize                : <<.n_FileSize>> bytes
                LastUpdate              : <<.c_LastUpdate>>
                NumberOfRecords         : <<.n_NumberOfRecords>> - REAL: <<.n_NumberOfRecordsReal>>
                PosOfFirstDataRecord    : <<.n_PosOfFirstDataRecord>>
                FieldCount              : <<.n_FieldCount>>
                DataRecordLength        : <<.n_DataRecordLength>>
                FileHasCDX              : <<.l_FileHasCDX>>
                FileHasMemo             : <<.l_FileHasMemo>>
                FileIsDBC               : <<.l_FileIsDBC>>
                CodePage                : <<.n_CodePage>> - <<.c_CodePageDesc>>

                ---------------------------------------------------
            ENDTEXT

*-- Fields
            loField = .Fields.Item(1)
            lcText  = lcText + CR_LF + loField.toText(.T.)

            For Each loField As CL_DBF_UTILS_FIELD Of 'FOXBIN2PRG.PRG' In .Fields
                lcText  = lcText + CR_LF + loField.toText()
            Endfor

            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2

                ---------------------------------------------------
                Field flags Reference:
                0x01   System Column (not visible to user)
                0x02   Column can store .Null. values
                0x04   Binary column (for CHAR and MEMO only)
                0x06   (0x02+0x04) When a field is .Null. and binary (Integer, Currency, and Character/Memo fields)
                0x0C   Column is autoincrementing

            ENDTEXT

        Endwith

        Return lcText
    Endproc


    Procedure write_DBC_BackLink
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_FileName               (v! IN    ) Nombre del DBF a analizar
* tcDBC_Name                (v! IN    ) Nombre del DBC a asociar
* tdLastUpdate              (v! IN    ) Fecha de última actualización
*---------------------------------------------------------------------------------------------------
        Lparameters tc_FileName, tcDBC_Name, tdLastUpdate

        Try
                Local lnHandle, ln_HexFileType, lcStr, lnDataPos, lnFieldCount, loEx As Exception

                tcDBC_Name  = Evl(tcDBC_Name,'')

*IF NOT EMPTY(tcDBC_Name)
                ln_HexFileType  = 0
                lnHandle        = Fopen(tc_FileName,2)

                If lnHandle = -1
                    Exit
                Endif

                lcStr           = Fread(lnHandle,1)     && File type
                ln_HexFileType  = Evaluate( Transform(Asc(lcStr),'@0') )

                If Empty(tdLastUpdate)
                    lcStr   = Fread(lnHandle,3)     && Last update (YYMMDD)
                Else
                    lcStr   = Chr( Val( Right( Padl( Year( tdLastUpdate ),4,'0'), 2 ) ) ) ;
                        + Chr( Val( Padl( Month( tdLastUpdate ),2,'0' ) ) ) ;
                        + Chr( Val( Padl( Day( tdLastUpdate ),2,'0' ) ) )       &&  Last update (YYMMDD)
                    =Fwrite( lnHandle, Padr(lcStr,3,Chr(0)) )
                Endif

                =Fread(lnHandle,4)      && Number of records in file
                lcStr           = Fread(lnHandle,2)     && Position of first data record
                lnDataPos       = CToBin(lcStr,"2RS")
                If Inlist(ln_HexFileType, 0x30, 0x31, 0x32) Then
                    lnFieldCount    = (lnDataPos - 296) / 32
                Else
                    Exit    && No DBC BackLink on older versions!
                Endif
                =Fread(lnHandle,2)      && Length of one data record, including delete flag
                =Fread(lnHandle,16)     && Reserved
                =Fread(lnHandle,1)      && Table flags: 0x01=Has CDX, 0x02=Has Memo, 0x04=Id DBC (flags acumulativos)
                =Fread(lnHandle,1)      && Code page mark
                =Fread(lnHandle,2)      && Reserved, contains 0x00
                =Fread(lnHandle,32 * lnFieldCount)      && Field subrecords (los salteo)
                =Fread(lnHandle,1)      && Header Record Terminator (0x0D)

                If Inlist(ln_HexFileType, 0x30, 0x31, 0x32) Then
                    If Fwrite( lnHandle, Padr(tcDBC_Name,263,Chr(0)) ) = 0
*-- No se pudo actualizar el backlink [] de la tabla []
                        Error C_BACKLINK_CANT_UPDATE_BL_LOC + ' [' + tcDBC_Name + '] ' + C_BACKLINK_OF_TABLE_LOC + ' [' + tc_FileName + ']'
                    Endif
                Endif
*ENDIF


            Catch To loEx
                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                Fclose(lnHandle)
        Endtry

        Return lnHandle
    Endproc


    Function get_Structure
        Lparameters taFields, tc_FileName

        With This As CL_DBF_UTILS Of 'lib_indices.prg'
            Local lnFieldCount
            lnFieldCount = 0

            If Not Empty(tc_FileName)
                .getDBFmetadata(tc_FileName)
            Endif

            lnFieldCount    = .n_FieldCount
            Dimension taFields(lnFieldCount,4)

            For I = 1 To lnFieldCount
                With .Fields.Item(m.I)
                    taFields(m.I,1) = .FieldName
                    taFields(m.I,2) = .FieldType
                    taFields(m.I,3) = .FieldWidth
                    taFields(m.I,4) = .FieldDecimals
                Endwith
            Endfor
        Endwith

        Return lnFieldCount
    Endfunc


    Procedure get_BinTableFlags
*-- Leo los flags de la tabla indicada
        Lparameters tcFile

        Local lnHandle, lcTableFlags
        lnHandle        = Fopen(tcFile,0)
        Fseek(lnHandle,28)
        lcTableFlags    = Fread(lnHandle,1)
        Fclose(lnHandle)
        Return lcTableFlags
    Endproc


    Procedure get_NumTableFlags
*-- Leo los flags de la tabla indicada
        Lparameters tcFile
        Return Asc( This.get_BinTableFlags(tcFile) )
    Endproc


    Procedure set_BinTableFlags
*-- Seteo los flags en la tabla indicada
        Lparameters tcFile, tcBinTableFlags

        Local lnHandle, lnWritten
        lnHandle        = Fopen(tcFile,1)
        Fseek(lnHandle,28)
        lnWritten   = Fwrite(lnHandle, tcTableFlags, 1)
        Fclose(lnHandle)
        Return lnWritten
    Endproc


    Procedure set_NumTableFlags
*-- Seteo los flags en la tabla indicada
        Lparameters tcFile, tnNumTableFlags
        Return This.set_BinTableFlags( tcFile, Chr(tnNumTableFlags) )
    Endproc


Enddefine


Define Class CL_DBF_UTILS_FIELD As Custom
    _MemberData = [<VFPData>] ;
        + [<memberdata name="fieldname" display="FieldName"/>] ;
        + [<memberdata name="fieldtype" display="FieldType"/>] ;
        + [<memberdata name="fieldwidth" display="FieldWidth"/>] ;
        + [<memberdata name="fielddecimals" display="FieldDecimals"/>] ;
        + [<memberdata name="fieldflags" display="FieldFlags"/>] ;
        + [<memberdata name="fielddisplacementinrecord" display="FieldDisplacementInRecord"/>] ;
        + [<memberdata name="allownulls" display="AllowNulls"/>] ;
        + [<memberdata name="nocodepagetranslation" display="NoCodePageTranslation"/>] ;
        + [<memberdata name="fieldvalidationexpression" display="FieldValidationExpression"/>] ;
        + [<memberdata name="fieldvalidationtext" display="FieldValidationText"/>] ;
        + [<memberdata name="fielddefaultvalue" display="FieldDefaultValue"/>] ;
        + [<memberdata name="tablevalidationexpression" display="TableValidationExpression"/>] ;
        + [<memberdata name="longtablename" display="LongTableName"/>] ;
        + [<memberdata name="tablevalidationtext" display="TableValidationText"/>] ;
        + [<memberdata name="inserttriggerexpression" display="InsertTriggerExpression"/>] ;
        + [<memberdata name="updatetriggerexpression" display="UpdateTriggerExpression"/>] ;
        + [<memberdata name="deletetriggerexpression" display="DeleteTriggerExpression"/>] ;
        + [<memberdata name="tablecomment" display="TableComment"/>] ;
        + [<memberdata name="nextvalueforautoinc" display="NextValueForAutoInc"/>] ;
        + [<memberdata name="stepforautoinc" display="StepForAutoInc"/>] ;
        + [<memberdata name="totext" display="toText"/>] ;
        + [</VFPData>]

    #If .F.
        Local This As CL_DBF_UTILS_FIELD Of 'FOXBIN2PRG.PRG'
    #Endif

    FieldName                   = ''
    FieldType                   = ''
    FieldWidth                  = 0
    FieldDecimals               = 0
    FieldFlags                  = 0
    FieldDisplacementInRecord   = 0
    AllowNulls                  = .F.
    NoCodePageTranslation       = .F.
    FieldValidationExpression   = ''
    FieldValidationText         = ''
    FieldDefaultValue           = ''
    TableValidationExpression   = ''
    TableValidationText         = ''
    LongTableName               = ''
    InsertTriggerExpression     = ''
    UpdateTriggerExpression     = ''
    DeleteTriggerExpression     = ''
    TableComment                = ''
    NextValueForAutoInc         = 0
    StepForAutoInc              = ''


    Procedure toText
        Lparameters tlHeader

        Local lcText
        lcText  = ''

        If tlHeader
            lcText  = lcText + Padr('FieldName',10) + '  ' + Padr('Type',4) + '  ' + Padr('Len',3) + '  ' ;
                + Padr('Dec',3) + '  ' + Padr('Flg',3) + '  ' + Padl('FDiR',4)
            lcText  = lcText + CR_LF + Replicate('-',10) + '  ' + Replicate('-',4) + '  ' + Replicate('-',3) + '  ' ;
                + Replicate('-',3) + '  ' + Replicate('-',3) + '  ' + Replicate('-',4)
        Else
            With This As CL_DBF_UTILS_FIELD Of 'FOXBIN2PRG.PRG'
                lcText  = lcText + Padr(.FieldName,10) + '  ' + Padc(.FieldType,4) + '  ' + Padl(.FieldWidth,3) + '  ' ;
                    + Padl(.FieldDecimals,3) + '  ' + Padc(.FieldFlags,3) + '  ' + Padl(.FieldDisplacementInRecord,4)
            Endwith
        Endif

        Return lcText
    Endproc


Enddefine


Define Class CL_LANG As Custom
    _MemberData = [<VFPData>] ;
        + [<memberdata name="n_languageselectedmethod" display="n_LanguageSelectedMethod"/>] ;
        + [</VFPData>]

    #If .F.
        Local This As CL_LANG Of 'FOXBIN2PRG.PRG'
    #Endif

    n_LanguageSelectedMethod    = 0 && 0=Automatic by version(3)

    C_ALLOWED_VALUES_ARE_LOC                                        = ""
    C_ASTERISK_EXT_NOT_ALLOWED_LOC                                  = ""
    C_BACKLINK_CANT_UPDATE_BL_LOC                                   = ""
    C_BACKLINK_OF_TABLE_LOC                                         = ""
    C_BACKUP_OF_LOC                                                 = ""
    C_CACHING_CONFIG_FOR_DIRECTORY_LOC                              = ""
    C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                 = ""
    C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC          = ""
    C_CONFIGFILE_LOC                                                = ""
    C_CONVERSION_CANCELLED_BY_USER_LOC                              = ""
    C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                            = ""
    C_CONVERT_FOLDER_LOC                                            = ""
    C_BINARY_TO_TEXT_LOC                                            = ""
    C_TEXT_TO_BINARY_LOC                                            = ""
    C_CONVERT_FOLDER_NONE_LOC                                       = ""
    C_CONVERT_FOLDER_QUESTION_LOC                                   = ""
    C_CONVERTER_UNLOAD_LOC                                          = ""
    C_CONVERTING_FILE_LOC                                           = ""
    C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC             = ""
    C_DUPLICATED_FILE_LOC                                           = ""
    C_DUPLICATED_OBJECT_LOC                                         = ""
    C_ENDDEFINE_MARKER_NOT_FOUND_LOC                                = ""
    C_END_MARKER_NOT_FOUND_LOC                                      = ""
    C_END_OF_PROCESS_LOC                                            = ""
    C_ERROR_LOC                                                     = ""
    C_ERRORS_FOUND_IN_FILE_LOC                                      = ""
    C_EXTENSION_RECONFIGURATION_LOC                                 = ""
    C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC         = ""
    C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                         = ""
    C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                        = ""
    C_EXTERNAL_PARAMETERS_LOC                                       = ""
    C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                         = ""
    C_FILE_DOESNT_EXIST_LOC                                         = ""
    C_FILE_NAME_IS_NOT_SUPPORTED_LOC                                = ""
    C_FILE_NOT_FOUND_LOC                                            = ""
    C_FILENAME_LOC                                                  = ""
    C_FOXBIN2PRG_ERROR_CAPTION_LOC                                  = ""
    C_FOXBIN2PRG_SYNTAX_INFO_LOC                                    = ""
    C_ClassTwice_Header_LOC                                         = ""
    C_ClassTwice_Lib_LOC                                            = ""
    C_ClassTwice_Class_LOC                                          = ""
    C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC                            = ""
    C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4                    = ""
    C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg                        = ""
    C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg                    = ""
    C_FOXBIN2PRG_JUST_VFP_9_LOC                                     = ""
    C_FOXBIN2PRG_WARN_CAPTION_LOC                                   = ""
    C_GENERATED_FILE_SIZE_LOC                                       = ""
    C_GENERATING_BINARY_LOC                                         = ""
    C_INCLUDING_CLASS_LOC                                           = ""
    C_INCLUDING_MEMBER_LOC                                          = ""
    C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                       = ""
    C_INHERITING_FROM_LOC                                           = ""
    C_INTERACTIVE_DIRECTORY_SELECTION_LOC                           = ""
    C_INVALID_PARAMETER_LOC                                         = ""
    C_IS_A_FILE_LOC                                                 = ""
    C_IS_A_DIRECTORY_LOC                                            = ""
    C_IS_UNSUPPORTED_LOC                                            = ""
    C_LANGUAGE_LOC                                                  = ""
    C_MAIN_EXECUTION_LOC                                            = ""
    C_MENU_NOT_IN_VFP9_FORMAT_LOC                                   = ""
    C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                        = ""
    C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                    = ""
    C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                           = ""
    C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                       = ""
    C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC              = ""
    C_OPTION_LOC                                                    = ""
    C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                  = ""
    C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                 = ""
    C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                             = ""
    C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC       = ""
    C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC       = ""
    C_PRESS_ESC_TO_CANCEL                                           = ""
    C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                              = ""
    C_PROCESSING_LOC                                                = ""
    C_PROCESS_PROGRESS_LOC                                          = ""
    C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                              = ""
    C_READING_CFG_VALUES_FROM_DISK_LOC                              = ""
    C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                 = ""
    C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                         = ""
    C_SCANNING_FILE_AND_DIR_INFO_LOC                                = ""
    C_SOURCEFILE_LOC                                                = ""
    C_SOURCESAFE_COMPATIBILITY_MODE_LOC                             = ""
    C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                  = ""
    C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC                = ""
    C_UNKNOWN_CLASS_NAME_LOC                                        = ""
    C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                           = ""
    C_USING_THIS_SETTINGS_LOC                                       = ""
    C_USING_THIS_SETTINGS_LOC1                                      = ""
    C_USING_THIS_SETTINGS_LOC2                                      = ""
    C_USING_THIS_SETTINGS_LOC3                                      = ""
    C_USING_THIS_SETTINGS_LOC4                                      = ""
    C_USING_THIS_SETTINGS_LOC5                                      = ""
    C_USING_THIS_SETTINGS_LOC6                                      = ""
    C_USING_THIS_SETTINGS_LOC7                                      = ""
    C_WARNING_LOC                                                   = ""
    C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                      = ""
    C_WITH_ERRORS_LOC                                               = ""
    C_LOCKINGFOLDER_LOC                                             = ""

    C_INDEX2TXT_PROCESSING_LOC                                      = ""
    C_INDEX2TXT_EXTRAFILES_LOC                                      = ""
    C_INDEX2TXT_NOFILE_LOC                                          = ""
    C_INDEX2TXT_NOTTHISTABLE_LOC                                    = ""
    C_INDEX2BIN_PROCESSING_LOC                                      = ""
    C_INDEX2BIN_STRUCTURAL_LOC                                      = ""
    C_INDEX2BIN_STANDALONE_LOC                                      = ""
    C_INDEX2BIN_COMPOUND_LOC                                        = ""

    C_PJXPATH_ERR_LOC1                                              = ""
    C_PJXPATH_ERR_LOC2                                              = ""
    C_PJXPATH_ERR_LOC3                                              = ""
    C_PJXPATH_ERR_LOC4                                              = ""
    C_PJXPATH_ERR_LOC5                                              = ""

    Procedure Init
        Lparameters tcLanguage

        Try
                Local lcSys16, lnPosProg, laDirInfo(1,5), lcLangStr ;
                    , loEx As Exception

                With This As CL_LANG Of 'FOXBIN2PRG.PRG'
*-- El lenguaje pasado por parámetro prevalece sobre el existente.
                    tcLanguage  = Evl(tcLanguage,'')

                    If Empty(tcLanguage)
                        .n_LanguageSelectedMethod   = 0 && 0=Automatic by version(3)
                    Else
                        .n_LanguageSelectedMethod   = 1 && 1=Assigned by Parameter
                    Endif

                    tcLanguage  = Upper( Evl(tcLanguage, Version(3)) )

                    Do Case
                        Case Inlist(tcLanguage, '33', 'FR') && French (Francés)
*-------------------------------------------------------------------------------------------------------------------------------------------
*-- NOTE: MUST USE DOUBLE QUOTES, OR SYNTAX ERRORS HAPPEN WHEN COMPILING. STRANGE :(
*-------------------------------------------------------------------------------------------------------------------------------------------
                            .C_ALLOWED_VALUES_ARE_LOC                                       = "Les valeurs autorisées sont"
                            .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "* Et ? extensions ne sont pas autorisées car il est dangereux (binaires peuvent être remplacés par des fichiers vides de XX2)"
                            .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Impossible de mettre à jour backlink"
                            .C_BACKLINK_OF_TABLE_LOC                                        = "de la table"
                            .C_BACKUP_OF_LOC                                                = "Faire de sauvegarde des: "
                            .C_CACHING_CONFIG_FOR_DIRECTORY_LOC                             = "La mise en cache pour le répertoire config"
                            .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Vous ne pouvez pas générer un fichier [<<THIS.c_OutputFile>>] car il est en lecture seule"
                            .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimisation: Fichier de base [<<JUSTFNAME(.c_InputFile)>>] Déjà traitée, en sautant traitement de fichier [<<tc_InputFile>>]"
                            .C_CONFIGFILE_LOC                                               = "Utilisation du fichier de configuration:"
                            .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Conversion Annulé par l'utilisateur"
                            .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "Convertir tous les fichiers dans un Projet"
                            .C_CONVERT_FOLDER_LOC                                           = "Convertir un Dossier"
                            .C_BINARY_TO_TEXT_LOC                                           = "Binaire en Texte"
                            .C_TEXT_TO_BINARY_LOC                                           = "Texte à Binaire"
                            .C_CONVERT_FOLDER_NONE_LOC                                      = "Aucun"
                            .C_CONVERT_FOLDER_QUESTION_LOC                                  = "Que la conversion doit être effectuée sur les fichiers de ce dossier?"
                            .C_CONVERTER_UNLOAD_LOC                                         = "Convertisseur déchargement"
                            .C_CONVERTING_FILE_LOC                                          = "Conversion de fichiers"
                            .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Erreur de données: ne peut pas analyser en raison de guillemets non appariés en ligne <<lcMetadatos>>"
                            .C_DUPLICATED_FILE_LOC                                          = "fichier dupliqué"
                            .C_DUPLICATED_OBJECT_LOC                                        = "Object dupliqué"
                            .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "Vous ne trouvez pas marqueur de fin [ENDDEFINE] de la ligne <<TRANSFORM(toClase._Inicio)>> ID [<<toClase._Nombre>>]"
                            .C_END_MARKER_NOT_FOUND_LOC                                     = "Vous ne trouvez pas fin marqueur [<<ta_ID_Bloques(lnPrimerID, 2)>>] qui ferme marqueur de début [<<ta_ID_Bloques(lnPrimerID, 1) >>] en ligne <<TRANSFORM(taBloquesExclusion (tnBloquesExclusion, 1))>>"
                            .C_END_OF_PROCESS_LOC                                           = "Fin du processus"
                            .C_ERROR_LOC                                                    = "ERREUR"
                            .C_ERRORS_FOUND_IN_FILE_LOC                                     = "ERREURS TROUVÉ DANS LE FICHIER"
                            .C_EXTENSION_RECONFIGURATION_LOC                                = "Extension Reconfiguration:"
                            .C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC        = "Nombre de classe externe (<<toModulo._ExternalClasses_Count>>) ne correspond pas classes trouvées (<<toModulo._Clases_Count>>) pour le fichier [<<toFoxBin2Prg.c_InputFile>>]"
                            .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "Aucune classe externe est trouvé"
                            .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "Nom de membre externe n'a pas été trouvé"
                            .C_EXTERNAL_PARAMETERS_LOC                                      = "PARAMÈTRES EXTERNES"
                            .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Champ [<< laProps (m.I) >>] ne trouve pas dans la structure du fichier DBF <<('TABLABIN')>>"
                            .C_FILE_DOESNT_EXIST_LOC                                        = "Fichier ne existe pas:"
                            .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "File [<<.c_InputFile>>] ne est pas supporté"
                            .C_FILE_NOT_FOUND_LOC                                           = "Fichier introuvable"
                            .C_FILENAME_LOC                                                 = "Fichier"
                            .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERREUR"
                            .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "SYNTAX AND PARAMETERS INFO"
                            .C_ClassTwice_Header_LOC                                        = CR_LF+"Class defined twice."+0h0D0A
                            .C_ClassTwice_Lib_LOC                                           = CR_LF+"Library: "
                            .C_ClassTwice_Class_LOC                                         = CR_LF+"Class: "
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FoxBin2Prg Home Page and download: https://github.com/fdbozzo/foxbin2prg/wiki  -  Fernando D. Bozzo (2013.11.25)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>FOXBIN2PRG.EXE <cFileSpec.Ext> [cType [cTextName [cGenText [cDontShowErrors [cDebug [cDontShowProgress [cOriginalFileName [cRecompile [cNoTimestamps [cCFG_File [cOutputFolder] ] ] ] ] ] ] ] ] ] ]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>cFileSpec.Ext:     ? | interactive This help
                        <<>>                   Full name (fullpath) of the file to convert or directory name to process
                        <<>>                     - If 'BIN2PRG' is specified, the directory specified in tcType is processed for generating TX2
                        <<>>                     - If 'PRG2BIN' is specified, the directory specified in tcType is processed for regenerating BIN
                        <<>>                     - In SCCAPI (VSS) compatibility mode, it is used to query the conversion support for the file type specified
                        <<>>                       VSS Types: d=DBC, D=DBF, K=Form, B=Label, M=Menu, R=Report, V=Class
                        <<>>cType:             In SCCAPI (VSS) compatibility mode indicates the input file type.
                        <<>>                        - If specified '*' or '*-' and tc_InputFile is a PJX, all project files are processed
                        <<>>cTextName          = Text filename. Only for SCCAPI (VSS) compatibility mode.
                        <<>>lGenText:          .T.=Generates Text, .F.=Regenerates Binary. Only for SCCAPI (VSS) compatibility mode.
                        <<>>cDontShowErrors:   '1' for NOT showing errors
                        <<>>cDebug:            '1' for generating process LOGs, stop on errors
                        <<>>cDontShowProgress: '1' for NOT showing the process window
                        <<>>cOriginalFileName: used in those cases in which inputFile is a temporary filename and you want to generate the correct filename on the header of the text version
                        <<>>cRecompile:        Indicates recompile ('1') the binary once regenerated. You can specify a Path too (ie, the project one)
                        <<>>cNoTimestamps:     Indicates if timestamp of several file types must be cleared ('1' or empty) or not ('0')
                        <<>>cCFG_File:         Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cOutputFolder:     The output folder to write to. If it isn't specified, the same folder as the source is used.
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE c|C|t [OutFileName [ cCFG_File[ cDebug]]]
                        <<>>DO FOXBIN2PRG.EXE WITH -c|-C|-t [, OutFileName [, cCFG_File[, cDebug]]]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>No parameter: Calls this info screen
                        <<>>-c (c)        Creates a template config-file <OutFileName> (like FOXBIN2PRG.CFG)
                        <<>>-C (C)        Creates a config-file <OutFileName> (like FOXBIN2PRG.CFG) with current options of folder of <OutFileName>
                        <<>>              If OutFileName is not given a FoxBin2Prg._cfg config file will be created at default folder
                        <<>>-t (t)        Creates a template table-config-file <OutFileName> (like <Tablename>.dbf.cfg)
                        <<>>              If OutFileName is not given, and a table is open a <Tablename>.dbf._cfg config file will be created at table folder.
                        <<>>cCFG_File:    Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cDebug:       '1' for generating process LOGs, stop on errors
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE VERNO
                        <<>>DO FOXBIN2PRG.EXE WITH "VERNO"|cPara
                        <<>>
                        <<>>-- Parameter details:
                        <<>>-VERNO (VERNO) Return version number of FoxBin2Prg
                        <<>>cPara          A parameter with the Value "VERNO", the version number is returned to this parameter
                        <<>>
                        <<>>
                            ENDTEXT
*** DH 2021-03-04: added HomeDir to text
*** DH 2024-08-26: added text for option 2 for BodyDevInfo
                            .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 = "*Options for folder <<.c_Recompile>>, read as of <<DATETIME()>>"
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FOXBIN2PRG.CFG configuration options: (If no values given, these are the DEFAULTS)
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>> Note, configuration files will follow an inheritance.
                        <<>> 1.  Default values
                        <<>> 2., optional FOXBIN2PRG.CFG in folder of FOXBIN2PRG.EXE
                        <<>>  or, if defined, a config file given by a parameter calling FOXBIN2PRG
                        <<>>      if used, the InhibitInheritance setting controls if other config files will be evaluated (default)
                        <<>> 3., optional FOXBIN2PRG.CFG in root of working directory
                        <<>> 4., optional FOXBIN2PRG.CFG in every folder up to the working directory
                        <<>> 5., optional Special settings per single DBF's Syntax: <TableName>.dbf.cfg in tables folder)
                        <<>>
                        <<>> Some Parameter calling FOXBIN2PRG.EXE overturn this settings (except Defaults)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>-- Settings for internal work, not processing
                        <<>>Language: (auto)               && Language of shown messages and LOGs. EN=English, FR=French, ES=Español, DE=German, Not defined = AUTOMATIC [DEFAULT]
                        <<>>ShowProgressbar: 1             && 0=Don't show, 1=Allways show, 2=Show only for multi-file processing
                        <<>>DontShowErrors: 0              && Show message errors by default
                        <<>>ExtraBackupLevels: 1           && By default 1 BAK is created. With this you can make more .N.BAK, or none
                        <<>>Debug: 0                       && 0=Don't Activate individual <file>.Log by default
                        <<>>                               && 1=Activate individual <file>.Log by default
                        <<>>                               && 2=???
                        <<>>                               && Only valid if not controlled by parameter
                        <<>>BackgroundImage: <cFile>       && Backgroundimage for process form. Empty for empty Background. File not found uses default.
                        <<>>HomeDir: 1                     && Home directory in PJX
                        <<>>                               && 0 don't save HomeDir in PJ2
                        <<>>                               && 1 save HomeDir in PJ2
                        <<>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        <<>>-- Settings for config file via parameter only
                        <<>>InhibitInheritance: 0          && 0=Allow scanning "regular" config files (file via parameter is just additional default)
                        <<>>                               && 1=Only read directory branch from root to parent of folder and below, not FoxBin2Prg default
                        <<>>                               && 2=Only read folder and subfolder of the file given by parameter
                        <<>>                               && 3=Read no other file
                        <<>>                               && This is like
                        <<>>                               && 0 Default | Parameter file | Default near FoxBin2Prg | all other config files
                        <<>>                               && 1 Default | Parameter file | Inheritance from root to parent of folder | folder and subdirs
                        <<>>                               && 2 Default | Parameter file | folder and subdirs
                        <<>>                               && 3 Default | Parameter file
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Conversion operation by type
                        <<>>PJX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>VCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>SCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>FRX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>LBX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>MNX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBC_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBF_Conversion_Support: 1      && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>FKY_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>MEM_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for pjx files
                        <<>>CheckFileInPath: 0             && Determines 2Txt deals with files not in the subfolders of the PJX. No handler for UNC paths.
                        <<>>                               && 0 Ignore. Default
                        <<>>                               && 1 Check and error out if file is not on same structure (for source control)
                        <<>>                               && 2 Create absolute path if file is on different drive.
                        <<>>                               && 3 Create absolute path if file is not in structure
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for container files (not pjx)
                        <<>>-- CLASS (, FORM and DBC) options (tx2 is to read as vc2 or sc2, VCX might be SCX)
                        <<>>-- FORM and DBC options default to this settings, id not set otherwise. See below.
                        <<>>- Class per file options (UseClassPerFile: 1)
                        <<>>UseClassPerFile: 0             && Determines how a library (or form) will handle included class (or, for forms, objects)
                        <<>>                               && 0 One library.tx2 file
                        <<>>                               && 1 Multiple file.class.tx2 files
                        <<>>                               && 2 Multiple file.baseclass.class.tx2 files
                        <<>>RedirectClassPerFileToMain: 0  && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to file.vcx/scx
                        <<>>                               && 1 Redirect to file.vcx/scx when selecting file[.baseclass].class.tx2
                        <<>>                               &&   RedirectClassType: 1 has precedence
                        <<>>RedirectClassType: 0           && For classes created with UseClassPerFile>0 in the form file[.baseclass].class.tx2
                        <<>>                               && Those files could be imported like file.tx2::Class::import or like file[.baseclass].class.tx2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect file[.baseclass].class.tx2 to file.VCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect file[.baseclass].class.tx2 to file[.baseclass].class.VCX and do not touch file.VCX
                        <<>>                               && 2 Redirect file[.baseclass].class.tx2 to file.VCX and do not touch other classes of file.VCX
                        <<>>ClassPerFileCheck: 0           && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check file[.baseclass].class.tx2 inclusion
                        <<>>                               &&   Only used if import file is in file[.baseclass].class.tx2 syntax
                        <<>>                               &&   Ignored for RedirectClassType: 2
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- FORM options
                        <<>>- Form per file options (UseFormSettings: 1)
                        <<>>UseFormSettings: 0             && 1=Turns the File per SCX options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if UseFormSettings is set 1 before!
                        <<>>                               &&   If UseFormSettings is set 0 later, all setting will be lost
                        <<>>UseFormPerFile: 0              && Determines how a form will handle included objects
                        <<>>                               && 0 One Form.sc2 file
                        <<>>                               && 1 Multiple Form.Obj.sc2 files
                        <<>>                               && 2 Multiple Form.baseclass.Obj.sc2 files
                        <<>>RedirectFormPerFileToMain: 0   && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to Form.scx
                        <<>>                               && 1 Redirect to Form.scx when selecting Form[.baseclass].Obj.sc2
                        <<>>                               &&   RedirectFormType: 1 has precedence
                        <<>>RedirectFormType: 0            && For classes created with UseFormPerFile>0 in the form Form[.baseclass].Obj.sc2
                        <<>>                               && Those files could be imported like Form.sc2::Class::import or like Form[.baseclass].Obj.sc2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect Form[.baseclass].Obj.sc2 to Form[.baseclass].Obj.SCX and do not touch Form.SCX
                        <<>>                               && 2 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and do not touch other classes of Form.SCX
                        <<>>FormPerFileCheck: 0            && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check Form[.baseclass].Obj.sc2 inclusion
                        <<>>                               &&   Only used if import file is in Form[.baseclass].Obj.sc2 syntax
                        <<>>                               &&   Ignored for RedirectFormType: 2
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- DBC options
                        <<>>- File per DBC options (UseFilesPerDBC: 1)
                        <<>>OldFilesPerDBC: 0              && 1=Turns the File per DBC options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if OldFilesPerDBC is set 1 before!
                        <<>>                               &&   If OldFilesPerDBC is set 0 later, all setting will be lost
                        <<>>UseFilesPerDBC: 0              && 0=One database dc2 file, 1=Multiple file.*.*.dc2 files
                        <<>>                               && 0 creates only a file.dc2 with all DBC (file) data
                        <<>>                               && 1 creates a file.dc2 with DBC properties
                        <<>>                               &&   and additional DBC files per DBC item (stored-proc, table, ..)
                        <<>>                               &&   Note: recration only if RedirectFilePerDBCToMain is 1
                        <<>>RedirectFilePerDBCToMain: 0    && 0=Don't redirect to file.dc2, 1=Redirect to file.dc2 when selecting file.item.*.dc2
                        <<>>ItemPerDBCCheck: 0             && 0=Don't check file.item.*.dc2 inclusion, 1=Check file.item.*.dc2 inclusion
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- General files
                        <<>>NoTimestamps: 1                && Clear timestamps of several file types by default for minimize text-file differences
                        <<>>ClearUniqueID: 1               && 0=Keep UniqueID in text files, 1=Clear Unique ID. Useful for Diff and Merge
                        <<>>OptimizeByFilestamp: 0         && 1=Optimize file regeneration depending on file timestamp. Dangerous while working with branches!
                        <<>>RemoveNullCharsFromCode: 1     && 1=Drop .Null. chars from source code
                        <<>>RemoveZOrderSetFromProps: 0    && 0=Do not remove ZOrderSet property from object, 1=Remove ZOrderSet property from object
                        <<>>PRG_Compat_Level: 0            && 0=Legacy, 1=Use HELPSTRING as Class Procedure comment
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- PJX special
                        <<>>BodyDevInfo: 0                 && 0=Don't keep DevInfo for body pjx records, 1=Keep DevInfo, 2 = Don't keep DevInfo or ObjRev
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- DBF special
                        <<>>ClearDBFLastUpdate: 1          && 0=Keep DBF LastUpdate, 1=Clear DBF LastUpdate. Useful for Diff.
                        <<>>ExcludeDBFAutoincNextval: 0    && 0=Do not exclude this value from db2, 1=Exclude this value from db2
                        <<>>DBF_Conversion_Included: *     && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_Conversion_Excluded:       && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_BinChar_Base64: 1          && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform (default)
                        <<>>DBF_IncludeDeleted: 0          && 0=Do not include deleted records (default), 1=Include deleted records
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Text file extensions
                        <<>>extension: tx2=newext          && Specify extensions to use. Default FoxBin2Prg extensions ends in '2' (see at the bottom)
                        <<>>-- Example configuration for SourceSafe compatibility:
                        <<>>extension: pj2=pja             && Text file to PJX
                        <<>>extension: vc2=vca             && Text file to VCX
                        <<>>extension: sc2=sca             && Text file to SCX
                        <<>>extension: fr2=fra             && Text file to FRX
                        <<>>extension: lb2=lba             && Text file to LBX
                        <<>>extension: mn2=mna             && Text file to MNX
                        <<>>extension: db2=dba             && Text file to DBF
                        <<>>extension: dc2=dca             && Text file to DBC
                        <<>>-- Additional extensions
                        <<>>extension: fk2=fkx             && Text file to FKY
                        <<>>extension: me2=fkx             && Text file to MEM
                        <<>>
                            ENDTEXT
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>-- Individual DBF configuration file (syntax: filename.dbf.cfg) Defaults see FoxBin2prg.cfg
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>DBF_Conversion_Support: <1,2,4,8>           && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>DBF_Conversion_Order: <c_Expression>        && Field expresion. ie: name+str(age,3)
                        <<>>DBF_Conversion_Condition: <c_Expression>    && Logical expression. ie: age > 10 AND NOT DELETED()
                        <<>>DBF_IndexList: <cFile_List>                 && comma delimited list of additonal non structural index files, cdx or idx
                        <<>>DBF_BinChar_Base64: <0,1>                   && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform
                        <<>>DBF_IncludeDeleted: <0,1>                   && 0=Do not include deleted records, 1=Include deleted records
                        <<>>
                            ENDTEXT
                            .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG est seulement pour Visual FoxPro 9.0!"
                            .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "AVERTISSEMENT!"
                            .C_GENERATED_FILE_SIZE_LOC                                      = "Taille du fichier généré"
                            .C_GENERATING_BINARY_LOC                                        = "Génération Binaire"
                            .C_INCLUDING_CLASS_LOC                                          = "classe, y compris"
                            .C_INCLUDING_MEMBER_LOC                                         = "membres, y compris"
                            .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "SourceSafe Compatibilité ModeIncorrect VFP 9 Version - SP1 manquant! Prévue: 3504 ou plus tard, réelle: " + Version(4)
                            .C_INHERITING_FROM_LOC                                          = "Héritant de"
                            .C_INTERACTIVE_DIRECTORY_SELECTION_LOC                          = "Sélection répertoire interactive"
                            .C_INVALID_PARAMETER_LOC                                        = "Paramètre non valide"
                            .C_IS_A_FILE_LOC                                                = "est un FICHIER"
                            .C_IS_A_DIRECTORY_LOC                                           = "est un RÉPERTOIRE"
                            .C_IS_UNSUPPORTED_LOC                                           = "ne est pas supporté"
                            .C_LANGUAGE_LOC                                                 = "FR"
                            .C_MAIN_EXECUTION_LOC                                           = "EXÉCUTION PRINCIPALE"
                            .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "Menu [<<THIS.c_InputFile>>] ne est pas dans VFP 9 Format! - Se il vous plaît se convertir à VFP 9 avec MODIFY MENU '<<THIS.c_InputFile>>'"
                            .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Programme des noms de capitalisation [<<lcEXE_CAPS>>] trouvé"
                            .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* Programme des noms de capitalisation [<<lcEXE_CAPS>>] introuvables"
                            .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Object [<<toObj.CLASS>>] ne contient pas l'objet oReg (niveau <<TRANSFORM(tnNivel)>>)"
                            .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Opération non reconnu. Seulement SETNAME et GETNAME permis."
                            .C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC             = "Optimisation: sauter fichier déjà traité [<<(lcFile)>>]"
                            .C_OPTION_LOC                                                   = "Option"
                            .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "La classe externe ne correspond pas à la classe interne"
                            .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "L'élément extérieur ne correspond pas aux éléments intérieur"
                            .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimisation: fichier de sortie [<<lcOutputFile>>] ne était pas écrasé parce que ce est la même que celle générée."
                            .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimisation: le fichier de sortie [<<THIS.c_OutputFile>>] pas régénéré en ayant le même horodatage que l'entrée."
                            .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimisation: le fichier de sortie [<<THIS.c_OutputFile>>] n'a pas été régénéré car il est plus récent que le fichier d'entrée."
                            .C_PRESS_ESC_TO_CANCEL                                          = "Appuyez sur Esc pour Annuler"
                            .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Procédure pas fermé. Dernière ligne de code doit être ENDPROC. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
                            .C_PROCESSING_LOC                                               = "Traitement du fichier"
                            .C_PROCESS_PROGRESS_LOC                                         = "Processus Progrès:"
                            .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Propriété [<<TRANSFORM(tnPropertyID)>>] ne est pas reconnu."
                            .C_READING_CFG_VALUES_FROM_DISK_LOC                             = "VALEURS LECTURE CFG À PARTIR DU DISQUE"
                            .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Rapport [<<THIS.c_InputFile>>] ne est pas dans VFP 9 Format! - Se il vous plaît se convertir à VFP 9 avec MODIFY REPORT '<<THIS.c_InputFile>>'"
                            .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Demande de capitalisation de fichier [<<tcFileName>>]"
                            .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Fichier de numérisation et de l'information de répertoire pour"
                            .C_SOURCEFILE_LOC                                               = "Fichier source: "
                            .C_SOURCESAFE_COMPATIBILITY_MODE_LOC                            = "Mode de compatibilité SourceSafe"
                            .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Nesting erreur de structure. ENDPROC prévu, mais a trouvé ENDDEFINE sur la classe <<toClase._Nombre>> (<<loProcedure._Nombre>>), ligne <<TRANSFORM(m.I)>> du fichier <<THIS.c_InputFile>>"
                            .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Nesting erreur de structure. ENDPROC attendue, mais ENDDEFINE sur la classe <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), ligne <<TRANSFORM(m.I)>> du fichier <<THIS.c_InputFile>>"
                            .C_UNKNOWN_CLASS_NAME_LOC                                       = "Classe inconnue[<<THIS.CLASS>>]"
                            .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Utilisez le fichier Optimisation d'horodatage"
                            .C_USING_THIS_SETTINGS_LOC                                      = "Utilisation de ce paramètre"
                            .C_USING_THIS_SETTINGS_LOC1                                     = " BY PARAMETER, skipping all previous config!"
                            .C_USING_THIS_SETTINGS_LOC2                                     = " Parsing of full configuration allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC3                                     = " Parsing configuration in parent~ and subdirectories allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC4                                     = " Parsing configuration in subdirectories allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC5                                     = " Parsing of other configuration not allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC6                                     = "External configuration file set: "
                            .C_USING_THIS_SETTINGS_LOC7                                     = ", using cached config."
                            .C_WARNING_LOC                                                  = "AVERTISSEMENT!"
                            .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "AVERTISSEMENT!" + CR_LF+ "ASSUREZ VOUS NE UTILISEZ PAS UN ALIAS DE TABLE SUR LES EXPRESSIONS INDEX CLÉS!! (exemple: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
                            .C_WITH_ERRORS_LOC                                              = "avec des erreurs"

                            .C_LOCKINGFOLDER_LOC                                            = " found, proccessing directory and subdirectories inhibited."
                            .C_INDEX2TXT_PROCESSING_LOC                                     = " Processing index"
                            .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Additional index files"
                            .C_INDEX2TXT_NOFILE_LOC                                         = "     Not a File "
                            .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index does not match table "
                            .C_INDEX2BIN_PROCESSING_LOC                                     = " Creating index"
                            .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs for structural index"
                            .C_INDEX2BIN_STANDALONE_LOC                                     = "  Standalone index "
                            .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs for compound index "
                            .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Main file "'
                            .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Project icon file "'
                            .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'File ""'
                            .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'not in PJX folder structure, "'
                            .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'check option "CheckFileInPath".' + CR_LF+CR_LF

                        Case Inlist(tcLanguage, '34', 'ES') && Spanish (Español)
*-------------------------------------------------------------------------------------------------------------------------------------------
*-- NOTA: SE DEBEN USAR COMILLAS DOBLES, O ERRORES DE SINTAXIS OCURREN AL COMPILAR. EXTRAÑO :(
*-------------------------------------------------------------------------------------------------------------------------------------------
                            .C_ALLOWED_VALUES_ARE_LOC                                       = "Los valores permitidos son"
                            .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "No se admiten extensiones * o ? porque es peligroso (se pueden pisar binarios con archivo xx2 vacíos)."
                            .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "No se pudo actualizar el backlink"
                            .C_BACKLINK_OF_TABLE_LOC                                        = "de la tabla"
                            .C_BACKUP_OF_LOC                                                = "Haciendo Backup de: "
                            .C_CACHING_CONFIG_FOR_DIRECTORY_LOC                             = "Cacheando configuración para directorio"
                            .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "No se puede generar el archivo [<<THIS.c_OutputFile>>] porque es ReadOnly"
                            .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimización: El archivo Base [<<JUSTFNAME(.c_InputFile)>>] ya fue procesado, ignorando el procesamiento del archivo [<<tc_InputFile>>]"
                            .C_CONFIGFILE_LOC                                               = "Usando archivo de configuración:"
                            .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Conversión Cancelada por el usuario"
                            .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "Convertir todos los archivos de un Proyecto"
                            .C_CONVERT_FOLDER_LOC                                           = "Convertir Carpeta"
                            .C_BINARY_TO_TEXT_LOC                                           = "Binario a Texto"
                            .C_TEXT_TO_BINARY_LOC                                           = "Texto a Binario"
                            .C_CONVERT_FOLDER_NONE_LOC                                      = "Ninguna"
                            .C_CONVERT_FOLDER_QUESTION_LOC                                  = "¿Qué tipo de conversión se debe hacer en esta carpeta?"
                            .C_CONVERTER_UNLOAD_LOC                                         = "Descarga del conversor"
                            .C_CONVERTING_FILE_LOC                                          = "Convirtiendo archivo"
                            .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Error de datos: No se puede parsear porque las comillas no son pares en la línea <<lcMetadatos>>"
                            .C_DUPLICATED_FILE_LOC                                          = "Archivo duplicado"
                            .C_DUPLICATED_OBJECT_LOC                                        = "Objeto Duplicado"
                            .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "No se ha encontrado el marcador de fin [ENDDEFINE] de la línea <<TRANSFORM( toClase._Inicio )>> para el identificador [<<toClase._Nombre>>]"
                            .C_END_MARKER_NOT_FOUND_LOC                                     = "No se ha encontrado el marcador de fin [<<ta_ID_Bloques(lnPrimerID,2)>>] que cierra al marcador de inicio [<<ta_ID_Bloques(lnPrimerID,1)>>] de la línea <<TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))>>"
                            .C_END_OF_PROCESS_LOC                                           = "Fin del Proceso"
                            .C_ERROR_LOC                                                    = "ERROR"
                            .C_ERRORS_FOUND_IN_FILE_LOC                                     = "SE HAN ENCONTRADOS ERRORES EN EL ARCHIVO"
                            .C_EXTENSION_RECONFIGURATION_LOC                                = "Reconfiguración de extensión:"
                            .C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC        = "El conteo de clases externas (<<toModulo._ExternalClasses_Count>>) no coincide con la cantidad encontrada (<<toModulo._Clases_Count>>) para el archivo [<<toFoxBin2Prg.c_InputFile>>]"
                            .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "No se encontró la clase externa"
                            .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "No se encontró el miembro externo"
                            .C_EXTERNAL_PARAMETERS_LOC                                      = "PARÁMETROS EXTERNOS"
                            .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "No se encontró el campo [<<laProps(m.I)>>] en la estructura del archivo <<DBF('TABLABIN')>>"
                            .C_FILE_DOESNT_EXIST_LOC                                        = "El archivo no existe:"
                            .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "El archivo [<<.c_InputFile>>] no está soportado"
                            .C_FILE_NOT_FOUND_LOC                                           = "No se encontró el archivo"
                            .C_FILENAME_LOC                                                 = "Archivo"
                            .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERROR"
                            .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "INFORMACIÓN DE SINTAXIS Y PARÁMETROS"
                            .C_ClassTwice_Header_LOC                                        = CR_LF+"Class defined twice."+CR_LF
                            .C_ClassTwice_Lib_LOC                                           = CR_LF+"Library: "
                            .C_ClassTwice_Class_LOC                                         = CR_LF+"Class: "
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>Página principal y descarga de FoxBin2Prg: https://github.com/fdbozzo/foxbin2prg/wiki  -  Fernando D. Bozzo (2013.11.25)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>FOXBIN2PRG.EXE <cFileSpec.Ext> [cType [cTextName [cGenText [cDontShowErrors [cDebug [cDontShowProgress [cOriginalFileName [cRecompile [cNoTimestamps [cCFG_File [cOutputFolder] ] ] ] ] ] ] ] ] ] ]
                        <<>>
                        <<>>-- Detalle de parámetros:
                        <<>>cFileSpec.Ext:     ? | interactive This help
                        <<>>                   Nombre completo (fullpath) del archivo a convertir o del directorio a procesar
                        <<>>                   - Si indica 'BIN2PRG', se procesa el directorio indicado en tcType para generar los TX2
                        <<>>                   - Si indica 'PRG2BIN', se procesa el directorio indicado en tcType para generar los BIN
                        <<>>                   - En modo compatibilidad con SCCAPI (VSS), se usa para preguntar el tipo de soporte de conversión para el tipo de archivo indicado
                        <<>>                     VSS Types: d=DBC, D=DBF, K=Form, B=Label, M=Menu, R=Report, V=Class
                        <<>>cType:             En modo compatibilidad con SCCAPI (VSS) es el Tipo de archivo de entrada.
                        <<>>                    - i indica '*' o '*-' y tc_InputFile es un PJX, se procesa todo el proyecto
                        <<>>cTextName          = Nombre del archivo texto. (Solo para compatibilidad con Visual SourceSafe)
                        <<>>lGenText:          .T.=Genera Texto, .F.=Genera Binario. Solo para compatibilidad con SCCAPI (VSS)
                        <<>>cDontShowErrors:   '1' para NO mostrar errores
                        <<>>cDebug:            '1' para generar LOGs del proceso, stop on errors
                        <<>>cDontShowProgress: '1' para NO mostrar la ventana de progreso
                        <<>>cOriginalFileName: Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar el nombre correcto en la cabecera de la versión texto
                        <<>>cRecompile:        Indica recompilar ('1') el binario una vez regenerado. También se puede indicar un Path (p.ej, el del proyecto)
                        <<>>cNoTimestamps:     Indica si se debe anular el timestamp ('1' o vacío) o no ('0')
                        <<>>cCFG_File:         Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cOutputFolder:     The output folder to write to. If it isn't specified, the same folder as the source is used.
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE c|C|t [OutFileName [ cCFG_File[ cDebug]]]
                        <<>>DO FOXBIN2PRG.EXE WITH -c|-C|-t [, OutFileName [, cCFG_File[, cDebug]]]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>No parameter: Calls this info screen
                        <<>>-c (c)        Creates a template config-file <OutFileName> (like FOXBIN2PRG.CFG)
                        <<>>-C (C)        Creates a config-file <OutFileName> (like FOXBIN2PRG.CFG) with current options of folder of <OutFileName>
                        <<>>              If OutFileName is not given a FoxBin2Prg._cfg config file will be created at default folder
                        <<>>-t (t)        Creates a template table-config-file <OutFileName> (like <Tablename>.dbf.cfg)
                        <<>>              If OutFileName is not given, and a table is open a <Tablename>.dbf._cfg config file will be created at table folder.
                        <<>>cCFG_File:    Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cDebug:       '1' for generating process LOGs, stop on errors ()
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE VERNO
                        <<>>DO FOXBIN2PRG.EXE WITH "VERNO"|cPara
                        <<>>
                        <<>>-- Parameter details:
                        <<>>-VERNO (VERNO) Return version number of FoxBin2Prg
                        <<>>cPara          A parameter with the Value "VERNO", the version number is returned to this parameter
                        <<>>
                        <<>>
                            ENDTEXT
*** DH 2021-03-04: added HomeDir to text
*** DH 2024-08-26: added text for option 2 for BodyDevInfo
                            .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 = "*Options for folder <<.c_Recompile>>, read as of <<DATETIME()>>"
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FOXBIN2PRG.CFG configuration options: (If no values given, these are the DEFAULTS)
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>> Note, configuration files will follow an inheritance.
                        <<>> 1.  Default values
                        <<>> 2., optional FOXBIN2PRG.CFG in folder of FOXBIN2PRG.EXE
                        <<>>  or, if defined, a config file given by a parameter calling FOXBIN2PRG
                        <<>>      if used, the InhibitInheritance setting controls if other config files will be evaluated (default)
                        <<>> 3., optional FOXBIN2PRG.CFG in root of working directory
                        <<>> 4., optional FOXBIN2PRG.CFG in every folder up to the working directory
                        <<>> 5., optional Special settings per single DBF's Syntax: <TableName>.dbf.cfg in tables folder)
                        <<>>
                        <<>> Some Parameter calling FOXBIN2PRG.EXE overturn this settings (except Defaults)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>-- Settings for internal work, not processing
                        <<>>Language: (auto)               && Language of shown messages and LOGs. EN=English, FR=French, ES=Español, DE=German, Not defined = AUTOMATIC [DEFAULT]
                        <<>>ShowProgressbar: 1             && 0=Don't show, 1=Allways show, 2=Show only for multi-file processing
                        <<>>DontShowErrors: 0              && Show message errors by default
                        <<>>ExtraBackupLevels: 1           && By default 1 BAK is created. With this you can make more .N.BAK, or none
                        <<>>Debug: 0                       && 0=Don't Activate individual <file>.Log by default
                        <<>>                               && 1=Activate individual <file>.Log by default
                        <<>>                               && 2=???
                        <<>>                               && Only valid if not controlled by parameter
                        <<>>BackgroundImage: <cFile>       && Backgroundimage for process form. Empty for empty Background. File not found uses default.
                        <<>>HomeDir: 1                     && Home directory in PJX
                        <<>>                               && 0 don't save HomeDir in PJ2
                        <<>>                               && 1 save HomeDir in PJ2
                        <<>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        <<>>-- Settings for config file via parameter only
                        <<>>InhibitInheritance: 0          && 0=Allow scanning "regular" config files (file via parameter is just additional default)
                        <<>>                               && 1=Only read directory branch from root to parent of folder and below, not FoxBin2Prg default
                        <<>>                               && 2=Only read folder and subfolder of the file given by parameter
                        <<>>                               && 3=Read no other file
                        <<>>                               && This is like
                        <<>>                               && 0 Default | Parameter file | Default near FoxBin2Prg | all other config files
                        <<>>                               && 1 Default | Parameter file | Inheritance from root to parent of folder | folder and subdirs
                        <<>>                               && 2 Default | Parameter file | folder and subdirs
                        <<>>                               && 3 Default | Parameter file
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Conversion operation by type
                        <<>>PJX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>VCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>SCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>FRX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>LBX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>MNX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBC_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBF_Conversion_Support: 1      && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>FKY_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>MEM_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for pjx files
                        <<>>CheckFileInPath: 0             && Determines 2Txt deals with files not in the subfolders of the PJX. No handler for UNC paths.
                        <<>>                               && 0 Ignore. Default
                        <<>>                               && 1 Check and error out if file is not on same structure (for source control)
                        <<>>                               && 2 Create absolute path if file is on different drive.
                        <<>>                               && 3 Create absolute path if file is not in structure
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for container files (not pjx)
                        <<>>-- CLASS (, FORM and DBC) options (tx2 is to read as vc2 or sc2, VCX might be SCX)
                        <<>>-- FORM and DBC options default to this settings, if not set otherwise. See below.
                        <<>>- Class per file options (UseClassPerFile: 1)
                        <<>>UseClassPerFile: 0             && Determines how a library (or form) will handle included class (or, for forms, objects)
                        <<>>                               && 0 One library.tx2 file
                        <<>>                               && 1 Multiple file.class.tx2 files
                        <<>>                               && 2 Multiple file.baseclass.class.tx2 files
                        <<>>RedirectClassPerFileToMain: 0  && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to file.vcx/scx
                        <<>>                               && 1 Redirect to file.vcx/scx when selecting file[.baseclass].class.tx2
                        <<>>                               &&   RedirectClassType: 1 has precedence
                        <<>>RedirectClassType: 0           && For classes created with UseClassPerFile>0 in the form file[.baseclass].class.tx2
                        <<>>                               && Those files could be imported like file.tx2::Class::import or like file[.baseclass].class.tx2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect file[.baseclass].class.tx2 to file.VCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect file[.baseclass].class.tx2 to file[.baseclass].class.VCX and do not touch file.VCX
                        <<>>                               && 2 Redirect file[.baseclass].class.tx2 to file.VCX and do not touch other classes of file.VCX
                        <<>>ClassPerFileCheck: 0           && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check file[.baseclass].class.tx2 inclusion
                        <<>>                               &&   Only used if import file is in file[.baseclass].class.tx2 syntax
                        <<>>                               &&   Ignored for RedirectClassType: 2
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- FORM options
                        <<>>- Form per file options (UseFormSettings 1)
                        <<>>UseFormSettings: 0             && 1=Turns the File per SCX options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if UseFormSettings is set 1 before!
                        <<>>                               &&   If UseFormSettings is set 0 later, all setting will be lost
                        <<>>UseFormPerFile: 0              && Determines how a form will handle included objects
                        <<>>                               && 0 One Form.sc2 file
                        <<>>                               && 1 Multiple Form.Obj.sc2 files
                        <<>>                               && 2 Multiple Form.baseclass.Obj.sc2 files
                        <<>>RedirectFormPerFileToMain: 0   && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to Form.scx
                        <<>>                               && 1 Redirect to Form.scx when selecting Form[.baseclass].Obj.sc2
                        <<>>                               &&   RedirectFormType: 1 has precedence
                        <<>>RedirectFormType: 0            && For classes created with UseFormPerFile>0 in the form Form[.baseclass].Obj.sc2
                        <<>>                               && Those files could be imported like Form.sc2::Class::import or like Form[.baseclass].Obj.sc2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect Form[.baseclass].Obj.sc2 to Form[.baseclass].Obj.SCX and do not touch Form.SCX
                        <<>>                               && 2 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and do not touch other classes of Form.SCX
                        <<>>FormPerFileCheck: 0            && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check Form[.baseclass].Obj.sc2 inclusion
                        <<>>                               &&   Only used if import file is in Form[.baseclass].Obj.sc2 syntax
                        <<>>                               &&   Ignored for RedirectFormType: 2
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- DBC options
                        <<>>- File per DBC options (UseFilesPerDBC: 1)
                        <<>>OldFilesPerDBC: 0              && 1=Turns the File per DBC options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if OldFilesPerDBC is set 1 before!
                        <<>>                               &&   If OldFilesPerDBC is set 0 later, all setting will be lost
                        <<>>UseFilesPerDBC: 0              && 0=One database dc2 file, 1=Multiple file.*.*.dc2 files
                        <<>>                               && 0 creates only a file.dc2 with all DBC (file) data
                        <<>>                               && 1 creates a file.dc2 with DBC properties
                        <<>>                               &&   and additional DBC files per DBC item (stored-proc, table, ..)
                        <<>>                               &&   Note: recration only if RedirectFilePerDBCToMain is 1
                        <<>>RedirectFilePerDBCToMain: 0    && 0=Don't redirect to file.dc2, 1=Redirect to file.tx2 when selecting file.item.*.dc2
                        <<>>ItemPerDBCCheck: 0             && 0=Don't check file.item.*.dc2 inclusion, 1=Check file.item.*.dc2 inclusion
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- General files
                        <<>>NoTimestamps: 1                && Clear timestamps of several file types by default for minimize text-file differences
                        <<>>ClearUniqueID: 1               && 0=Keep UniqueID in text files, 1=Clear Unique ID. Useful for Diff and Merge
                        <<>>OptimizeByFilestamp: 0         && 1=Optimize file regeneration depending on file timestamp. Dangerous while working with branches!
                        <<>>RemoveNullCharsFromCode: 1     && 1=Drop .Null. chars from source code
                        <<>>RemoveZOrderSetFromProps: 0    && 0=Do not remove ZOrderSet property from object, 1=Remove ZOrderSet property from object
                        <<>>PRG_Compat_Level: 0            && 0=Legacy, 1=Use HELPSTRING as Class Procedure comment
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- PJX special
                        <<>>BodyDevInfo: 0                 && 0=Don't keep DevInfo for body pjx records, 1=Keep DevInfo, 2 = Don't keep DevInfo or ObjRev
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- DBF special
                        <<>>ClearDBFLastUpdate: 1          && 0=Keep DBF LastUpdate, 1=Clear DBF LastUpdate. Useful for Diff.
                        <<>>ExcludeDBFAutoincNextval: 0    && 0=Do not exclude this value from db2, 1=Exclude this value from db2
                        <<>>DBF_Conversion_Included: *     && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_Conversion_Excluded:       && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_BinChar_Base64: 1          && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform (default)
                        <<>>DBF_IncludeDeleted: 0          && 0=Do not include deleted records (default), 1=Include deleted records
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Text file extensions
                        <<>>extension: tx2=newext          && Specify extensions to use. Default FoxBin2Prg extensions ends in '2' (see at the bottom)
                        <<>>-- Example configuration for SourceSafe compatibility:
                        <<>>extension: pj2=pja             && Text file to PJX
                        <<>>extension: vc2=vca             && Text file to VCX
                        <<>>extension: sc2=sca             && Text file to SCX
                        <<>>extension: fr2=fra             && Text file to FRX
                        <<>>extension: lb2=lba             && Text file to LBX
                        <<>>extension: mn2=mna             && Text file to MNX
                        <<>>extension: db2=dba             && Text file to DBF
                        <<>>extension: dc2=dca             && Text file to DBC
                        <<>>-- Additional extensions
                        <<>>extension: fk2=fkx             && Text file to FKY
                        <<>>extension: me2=fkx             && Text file to MEM
                        <<>>
                            ENDTEXT
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>-- Archivo de configuración individual para DBF (sintaxis: archivo.dbf.cfg) Defaults see FoxBin2prg.cfg
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>DBF_Conversion_Support: <1,2,4,8>           && Ver esta misma configuración más arriba
                        <<>>DBF_Conversion_Order: <c_Expression>        && Expresión de campo. ej: nombre+str(edad,3)
                        <<>>DBF_Conversion_Condition: <c_Expression>    && Expresión lógica. ej: edad > 10 AND NOT DELETED()
                        <<>>DBF_IndexList: <cFile_List>                 && comma delimited list of additonal non structural index files, cdx or idx
                        <<>>DBF_BinChar_Base64: <0,1>                   && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform
                        <<>>DBF_IncludeDeleted: <0,1>                   && 0=Do not include deleted records, 1=Include deleted records
                        <<>>
                            ENDTEXT
                            .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "¡FOXBIN2PRG es solo para Visual FoxPro 9.0!"
                            .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "¡ATENCIÓN!"
                            .C_GENERATED_FILE_SIZE_LOC                                      = "Tamaño del archivo generado"
                            .C_GENERATING_BINARY_LOC                                        = "Generando Binario"
                            .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "El Menú [<<THIS.c_InputFile>>] NO está en formato VFP 9! - Por favor convertirlo a VFP 9 con MODIFY MENU '<<THIS.c_InputFile>>'"
                            .C_INCLUDING_CLASS_LOC                                          = "Incluyendo clase"
                            .C_INCLUDING_MEMBER_LOC                                         = "Incluyendo miembro"
                            .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Versión Incorrecta de VFP 9 - Falta el SP1! Esperado: 3504 o posterior, actual: " + Version(4)
                            .C_INHERITING_FROM_LOC                                          = "Heredando desde"
                            .C_INTERACTIVE_DIRECTORY_SELECTION_LOC                          = "Selección Interactiva de Directorio"
                            .C_INVALID_PARAMETER_LOC                                        = "Parámetro inválido"
                            .C_IS_A_FILE_LOC                                                = "es un ARCHIVO"
                            .C_IS_A_DIRECTORY_LOC                                           = "es un DIRECTORIO"
                            .C_IS_UNSUPPORTED_LOC                                           = "no está soportado"
                            .C_LANGUAGE_LOC                                                 = "ES"
                            .C_MAIN_EXECUTION_LOC                                           = "EJECUCIÓN PRINCIPAL"
                            .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Se ha encontrado el programa de capitalización de nombres [<<lcEXE_CAPS>>]"
                            .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* No se ha encontrado el programa de capitalización de nombres [<<lcEXE_CAPS>>]"
                            .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Objeto [<<toObj.CLASS>>] no contiene el objeto oReg (nivel <<TRANSFORM(tnNivel)>>)"
                            .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Operación no reconocida. Solo re reconoce SETNAME y GETNAME."
                            .C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC             = "Optimización: saltando el archivo ya procesado [<<(lcFile)>>]"
                            .C_OPTION_LOC                                                   = "Opción"
                            .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "La clase externa no coincide con las clases internas"
                            .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "El miembro externo no coincide con los miembros internos"
                            .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimización: el archivo de salida [<<lcOutputFile>>] no se sobreescribe por ser igual al ya existente."
                            .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimización: el archivo de salida [<<THIS.c_OutputFile>>] no se regenera por tener el mismo timestamp que el de entrada."
                            .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimización: el archivo de salida [<<THIS.c_OutputFile>>] no se regenera por tener un timestamp más nuevo que el de entrada."
                            .C_PRESS_ESC_TO_CANCEL                                          = "Pulse Esc para Cancelar"
                            .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Procedimiento sin cerrar. La última línea de código debe ser ENDPROC. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
                            .C_PROCESSING_LOC                                               = "Procesando archivo"
                            .C_PROCESS_PROGRESS_LOC                                         = "Avance del proceso:"
                            .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Propiedad [<<TRANSFORM(tnPropertyID)>>] no reconocida."
                            .C_READING_CFG_VALUES_FROM_DISK_LOC                             = "LEYENDO VALORES DEL ARCHIVO CFG DEL DISCO"
                            .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "El Reporte [<<THIS.c_InputFile>>] NO está en formato VFP 9! - Por favor convertirlo a VFP 9 con MODIFY REPORT '<<THIS.c_InputFile>>'"
                            .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Solicitado capitalizar el archivo [<<tcFileName>>]"
                            .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Escaneando archivos e información de directorio para"
                            .C_SOURCEFILE_LOC                                               = "Archivo origen: "
                            .C_SOURCESAFE_COMPATIBILITY_MODE_LOC                            = "Modo de Compatibilidad SourceSafe"
                            .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Error de anidamiento de estructuras. Se esperaba ENDPROC pero se encontró ENDDEFINE en la clase <<toClase._Nombre>> (<<loProcedure._Nombre>>), línea <<TRANSFORM(m.I)>> del archivo <<THIS.c_InputFile>>"
                            .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Error de anidamiento de estructuras. Se esperaba ENDPROC pero se encontró ENDDEFINE en la clase <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), línea <<TRANSFORM(m.I)>> del archivo <<THIS.c_InputFile>>"
                            .C_UNKNOWN_CLASS_NAME_LOC                                       = "Clase [<<THIS.CLASS>>] desconocida"
                            .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Usar Optimización de filestamp de archivo"
                            .C_USING_THIS_SETTINGS_LOC                                      = "Usando esta configuración"
                            .C_USING_THIS_SETTINGS_LOC1                                     = " BY PARAMETER, skipping all previous config!"
                            .C_USING_THIS_SETTINGS_LOC2                                     = " Parsing of full configuration allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC3                                     = " Parsing configuration in parent~ and subdirectories allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC4                                     = " Parsing configuration in subdirectories allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC5                                     = " Parsing of other configuration not allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC6                                     = "External configuration file set: "
                            .C_USING_THIS_SETTINGS_LOC7                                     = ", using cached config."
                            .C_WARNING_LOC                                                  = "¡ATENCIÓN!"
                            .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "¡ATENCIÓN!" + CR_LF+ "ASEGÚRESE DE QUE NO ESTÁ USANDO UN ALIAS DE TABLA EN LAS EXPRESIONES DE LOS ÍNDICES!! (ej: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag nombreclave)"
                            .C_WITH_ERRORS_LOC                                              = "con errores"
                            .C_LOCKINGFOLDER_LOC                                            = " found, proccessing directory and subdirectories inhibited."

                            .C_INDEX2TXT_PROCESSING_LOC                                     = " Processing index"
                            .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Additional index files"
                            .C_INDEX2TXT_NOFILE_LOC                                         = "     Not a File "
                            .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index does not match table "
                            .C_INDEX2BIN_PROCESSING_LOC                                     = " Creating index"
                            .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs for structural index"
                            .C_INDEX2BIN_STANDALONE_LOC                                     = "  Standalone index "
                            .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs for compound index "
                            .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Main file "'
                            .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Project icon file "'
                            .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'File ""'
                            .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'not in PJX folder structure, "'
                            .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'check option "CheckFileInPath".' + CR_LF+CR_LF

                        Case Inlist(tcLanguage, '49', 'DE') && German (Alemán)
*-------------------------------------------------------------------------------------------------------------------------------------------
*-- NOTE: ES MÜSSEN ANFÜHRUNGSZEICHEN BENUTZT WERDEN, ODER SYNTAX ERRORS PASSIEREN BEIM COMPILE. SELTSAM :(
*-------------------------------------------------------------------------------------------------------------------------------------------
                            .C_ALLOWED_VALUES_ARE_LOC                                       = "Erlaubte Werte sind"
                            .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "Die Erweiterungen * und ? sind nicht erlaubt, da sie gefährlich sind (Binaries könnten mit xx2 leeren Dateien überschrieben werden)"
                            .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Backlink kann nicht aktualisiert werden"
                            .C_BACKLINK_OF_TABLE_LOC                                        = "von Tabelle"
                            .C_BACKUP_OF_LOC                                                = "Erzeuge Backup von: "
                            .C_CACHING_CONFIG_FOR_DIRECTORY_LOC                             = "Caching Konfiguration für Verzeichnis"
                            .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Kann Datei [<<THIS.c_OutputFile>>] nicht generieren, da sie schreibgeschützt ist"
                            .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimierung: Grund Datei [<<JUSTFNAME(.c_InputFile)>>] Schon verarbeitet, das Überspringen Verarbeitung der Datei [<<tc_InputFile>>]"
                            .C_CONFIGFILE_LOC                                               = "Benutzte Konfigurationsdatei:"
                            .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Konvertierung durch den Benutzer abgebrochen"
                            .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "alle Dateien in einem Projekt zu konvertieren"
                            .C_CONVERT_FOLDER_LOC                                           = "Konvertieren Verzeichnis"
                            .C_BINARY_TO_TEXT_LOC                                           = "Binär zu Text"
                            .C_TEXT_TO_BINARY_LOC                                           = "Text zu Binär"
                            .C_CONVERT_FOLDER_NONE_LOC                                      = "Nichts"
                            .C_CONVERT_FOLDER_QUESTION_LOC                                  = "Welche Umwandlung sollte sich auf die Dateien dieses Verzeichnis durchgeführt werden?"
                            .C_CONVERTER_UNLOAD_LOC                                         = "Konverter wird entladen"
                            .C_CONVERTING_FILE_LOC                                          = "Konvertiere Datei"
                            .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Datenfehler: Keine Analyse möglich, da ungepaarte Anführungszeichen in Zeile <<lcMetadatos>> sind."
                            .C_DUPLICATED_FILE_LOC                                          = "Doppelte Datei"
                            .C_DUPLICATED_OBJECT_LOC                                        = "Doppelte Objekt"
                            .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "Kann keinen Ende Marker [ENDDEFINE] in Zeile <<TRANSFORM( toClase._Inicio )>> für die ID [<<toClase._Nombre>>] finden"
                            .C_END_MARKER_NOT_FOUND_LOC                                     = "Kann keinen Ende Marker [<<ta_ID_Bloques(lnPrimerID,2)>>] welcher den Start Marker [<<ta_ID_Bloques(lnPrimerID,1)>>] in Zeile <<TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))>> schließt"
                            .C_END_OF_PROCESS_LOC                                           = "Ende des Prozesses"
                            .C_ERROR_LOC                                                    = "FEHLER"
                            .C_ERRORS_FOUND_IN_FILE_LOC                                     = "FEHLER IN FILE GEFUNDEN"
                            .C_EXTENSION_RECONFIGURATION_LOC                                = "Neukonfiguration der Erweiterungen:"     &&wir wollen es mal nicht übertreiben, mit den zusammengesetzten Substantiven
                            .C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC        = "Die Anzahl externee Klassen (<< toModulo._ExternalClasses_Count >>) entspricht nicht der der gefunden Klassen (<< toModulo._Clases_Count >>), Datei: [<< toFoxBin2Prg.c_InputFile >>]"
                            .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "Keine externe Klasse gefunden"
                            .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "Externe Mitglied wurde nicht gefunden"
                            .C_EXTERNAL_PARAMETERS_LOC                                      = "EXTERNE PARAMETER"
                            .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Feld [<<laProps(m.I)>>] nicht in der Struktur von Datei <<DBF('TABLABIN')>> gefunden"
                            .C_FILE_DOESNT_EXIST_LOC                                        = "Datei existiert nicht:"
                            .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "Datei [<<.c_InputFile>>] wird nicht unterstützt"
                            .C_FILE_NOT_FOUND_LOC                                           = "Datei nicht gefunden"
                            .C_FILENAME_LOC                                                 = "Datei"
                            .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "FEHLER"
                            .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "SYNTAX UND PARAMETER INFORMATION"
                            .C_ClassTwice_Header_LOC                                        = CR_LF+"Klasse doppelt deklariert."+CR_LF
                            .C_ClassTwice_Lib_LOC                                           = CR_LF+"Bibliothek: "
                            .C_ClassTwice_Class_LOC                                         = CR_LF+"Klasse: "
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FoxBin2Prg Home Page and download: https://github.com/fdbozzo/foxbin2prg/wiki  -  Fernando D. Bozzo (2013.11.25)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>FOXBIN2PRG.EXE <cFileSpec.Ext> [cType [cTextName [cGenText [cDontShowErrors [cDebug [cDontShowProgress [cOriginalFileName [cRecompile [cNoTimestamps [cCFG_File [cOutputFolder] ] ] ] ] ] ] ] ] ] ]
                        <<>>
                        <<>>-- Parameter:
                        <<>>cFileSpec.Ext:     ? | interactive Diese Hilfe
                        <<>>                   Vollständiger Name der Datei (mit Pfad) zum Konvertieren, oder das Verzeichnis zum Konvertieren
                        <<>>                    - wenn 'BIN2PRG' spezifiziert ist, wird das Verzeichnis in cType (!!) zum Erstellen der Textdateien genutzt
                        <<>>                    - wenn 'PRG2BIN' spezifiziert ist, wird das Verzeichnis in cType (!!) zum Erstellen der Binärdateien genutzt
                        <<>>                    - Im SCCAPI (VSS) Kompatibilitätsmodus, wird dies zur Abfrage der Unterstützung der Umwandlung für den genannten Dateityp genutzt
                        <<>>                      VSS Types: d=DBC, D=DBF, K=Form, B=Label, M=Menu, R=Report, V=Class
                        <<>>cType:             Im SCCAPI (VSS) Kompatibilitätsmodus wird hier der Dateityp der Input-Datei festgelegt
                        <<>>                    - Wird hier '*' oder '*-' angegeben, und tc_InputFile ist ein PJX, werden alle Dateien im PJX konvertiert
                        <<>>cTextName:         Text Dateiname. Nur im SCCAPI (VSS) Kompatibilitätsmodus.
                        <<>>lGenText:          .T.=Erzeuge Text, .F.=Erzeuge Binary. Nur im SCCAPI (VSS) Kompatibilitätsmodus.
                        <<>>cDontShowErrors:   '1' Unterdrückt die Anzeige von Fehlern
                        <<>>cDebug:            '1' Erzeugt LOG Dateien, hält bei Fehlern an
                        <<>>cDontShowProgress: '1' Zeige kein Fortschrittsfenster
                        <<>>cOriginalFileName: Falls als Inputdatei eine temporäre Datei genutzt wird, kann hier für den Kopf der Textdatei der richtige Name angegeben werden.
                        <<>>cRecompile:        '1' Die erzeugten Binädateien werden nach dem Erzeugen kompiliert. Eine Pfadangabe (d.h., die des Projektes) ist möglich.
                        <<>>cNoTimestamps:     Legt fest ob der Zeitstempel einiger Dateiarten gelöscht werden soll ('1' oder leer) oder nicht ('0')
                        <<>>cCFG_File:         Legt eine alternative Konfigurationsdatei (CFG) fest, die als Standard statt der im foxbin2prg Verzeichnis genutzt werden soll.
                        <<>>cOutputFolder:     Der Ordner in die die Ausgabedatei geschrieben werden soll. Wenn nicht angegeben, das Verzeichnis der Quelle.
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE c|C|t [OutFileName [ cCFG_File[ cDebug]]]
                        <<>>DO FOXBIN2PRG.EXE WITH -c|-C|-t [, OutFileName [, cCFG_File[, cDebug]]]
                        <<>>
                        <<>>-- Parameter:
                        <<>>Keine Parameter:   Startet dieses Formular
                        <<>>-c (c)             Erzeugt eine Vorlage <OutFileName> für eine Config-Datei (wie FOXBIN2PRG.CFG)
                        <<>>-C (C)             Erzeugt eine  Config-Datei <OutFileName>  (wie FOXBIN2PRG.CFG) mit den aktuellen Optionen des Pfades von <OutFileName>
                        <<>>                   Wird OutFileName nicht angegeben, so wird eine Konfigurationsdatei FoxBin2Prg._cfg angelegt.
                        <<>>-t (t)             Erzeugt eine Vorlage <OutFileName> für eine Tabellen-Config-Datei (wie <Tabellenname>.dbf.cfg)
                        <<>>                   Wird OutFileName nicht angegeben und ist eine Tabelle offen,
                        <<>>                   so wird eine Konfigurationsdatei <Tabellenname>.dbf._cfg im Verzeichnis der Tabelle angelegt.
                        <<>>cCFG_File:         Legt eine alternative Konfigurationsdatei (CFG) fest, die als Standard statt der im foxbin2prg Verzeichnis genutzt werden soll.
                        <<>>cDebug:            '1' Erzeugt LOG Dateien, hält bei Fehlern an
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE VERNO
                        <<>>DO FOXBIN2PRG.EXE WITH "VERNO"|cPara
                        <<>>
                        <<>>-- Parameter:
                        <<>>-VERNO (VERNO) Return version number of FoxBin2Prg
                        <<>>cPara          A Ein Parameter mit dem Wert "VERNO", der Rückgabewert des Parameters die Versionsnummer
                        <<>>
                        <<>>
                            ENDTEXT
*** DH 2021-03-04: added HomeDir to text
                            .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 = "*Optionen für Verzeichnis <<.c_Recompile>>, gelesen am <<DATETIME() gelesen.>>"
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FOXBIN2PRG.CFG Konfigurations-Optionen: (Wird die Option nicht aufgeführt, ist der Wert im Beispiel der Default)
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>> Achtung, die Konfigurationsdateien werden vererbt.
                        <<>> 1.  Defaultwerte
                        <<>> 2., optional FOXBIN2PRG.CFG im Vereichnis aus dem FOXBIN2PRG.EXE startet
                        <<>>   Oder, wenn definiert, eine Konfigurationsdatei die per Parameter an FOXBIN2PRG übergeben wurde.
                        <<>>       Wird diese genutzt, steuert die Einstellung InhibitInheritance, ob folgende Konfigurationsdateien ausgewertet werden.  (default)
                        <<>> 3., optional FOXBIN2PRG.CFG in der Wurzel des Arbeitsverzeichnises
                        <<>> 4., optional FOXBIN2PRG.CFG in jedem Verzeichnis bis zum Arbeitsverzeichnis
                        <<>> 5., optional Es können spezielle Einstellungen für einzelne DBF's erzeugt werden (Syntax: <TableName>.dbf.cfg im Verzeichnis der Tabelle)
                        <<>>
                        <<>> Einige Parameter im Aufruf von FOXBIN2PRG.EXE übersteueren diese Vorgaben (bis auf die Defaults)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>Interne Einstellungen
                        <<>>Language: (auto)               && Sprache für Anzeigen und Logs. EN=English, FR=Français, ES=Español, DE=Deutsch, Nicht definiert = Automatisch [DEFAULT]
                        <<>>ShowProgressbar: 1             && 0=Zeige Fortschrittsfenster, 1=Zeige es nicht, 2=Zeige Fortschrittsfenster nur, wenn mehrere Dateien konvertiert werden.
                        <<>>DontShowErrors: 0              && 0=Zeige Fehler an, 1=Zeige keine Fehler an
                        <<>>ExtraBackupLevels: 1           && Anzahl der Backup-Ebenen der Binärdateien 0=kein Backup, 1=<Datei>.BAK, n>1= n-Backup-Ebenen, <Datei>.n.BAK
                        <<>>Debug: 0                       && 0=Individuelles Logging ist aus
                        <<>>                               && 1=Individuelles Log per Datei <Datei>.Log
                        <<>>                               && 2=???
                        <<>>                               && Nur gültig, wenn nicht durch einen Parameter übersteuert
                        <<>>BackgroundImage: <cFile>       && Hintergrundbild für das Formular zur Fortschrittsanzeige.
                        <<>>                               && Leer erzeugt kein Hintergrundbild. Wird die Datei nicht gefunden, wird der Standardhintergrund verwendet.
                        <<>>HomeDir: 1                     && Speichern der HomeDir Eigenschaft in die PJX
                        <<>>                               && 0 Die Eigenschaft HomeDir wird nicht in die PJ2 gespeichert
                        <<>>                               && 1 Die Eigenschaft wird gespeichert
                        <<>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        <<>>-- Settings for config file via parameter only
                        <<>>InhibitInheritance: 0          && 0=Alle Konfiguration wird gelesen (Die Datei aus dem Parameter ist nur ein zusätzlicher default)
                        <<>>                               && 1=Nur die Vererbung in den Verezeichnissen , Im Verzeichnis der Konfiguration und Unterverzeichnisse werden gelesen
                        <<>>                               && 2=Nur die Konfiguration des Veruzeichnisses der Parameterdatei und Unterverzeichnisse werden gelesen
                        <<>>                               && 3=Keine weiter Konfiguration wird gelesen
                        <<>>                               && This is like
                        <<>>                               && 0 Default | Parameter Datei | Konfiguration im Programmverzeichnis von FoxBin2Prg | Alle anderen Konfigurationen
                        <<>>                               && 1 Default | Parameter Datei | Vererbung bis zum Verzeichnis der Parameter Datei | Das Verzeichnis und Unterverzeichnise der Parameter Datei
                        <<>>                               && 2 Default | Parameter Datei | Das Verzeichnis und Unterverzeichnise der Parameter Datei
                        <<>>                               && 3 Default | Parameter Datei

                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Konvertierungs Optionen:
                        <<>>PJX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>VCX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>SCX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>FRX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>LBX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>MNX_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>DBC_Conversion_Support: 2      && 0=Aus, 1=Erzeuge nur Textdatei (Diff), 2=Erzeuge Text- und Binärdatei (Merge)
                        <<>>DBF_Conversion_Support: 1      && 0=Aus
                        <<>>                               && 1=Erzeuge Textdatei nur für Struktur (Diff)
                        <<>>                               && 2=Erzeuge Text- und Binärdatei nur für Struktur (Merge)
                        <<>>                               && 4=Erzeuge Textdatei nur für Struktur und Daten (Diff)
                        <<>>                               && 8=Erzeuge Text- und Binärdatei nur für Struktur und Daten (Merge)
                        <<>>FKY_Conversion_Support: 1      && 0=Aus, 1=Erzeuge nur Textdatei (Diff)
                        <<>>MEM_Conversion_Support: 1      && 0=Aus, 1=Erzeuge nur Textdatei (Diff)
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for pjx files
                        <<>>CheckFileInPath: 0             && Bestimmt, ob bein Erstellen von pj2 Dateien Dateien in der ordnerstruktur des PJX sein müssen.
                        <<>>                               && Keine Behandlung für UNC Pfade.
                        <<>>                               && 0 Ignorieren. Default
                        <<>>                               && 1 Teste, und breche ab wenn die Datei nicht in der Struktur ist (für Quellcodeverwaltung)
                        <<>>                               && 2 Erstelle absoluten Pfad für Dateien auf einem anderen Laufwerk.
                        <<>>                               && 3 Erstelle absoluten Pfad für Dateien die nicht in der Ordnerstruktur sind.
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>> ------Einstellungen für Container-Dateien (nicht pjx)
                        <<>>-- Optionen für CLASS und FORM
                        <<>>-- CLASS (, FORM und DBC) Einstellungen (tx2 versteht sich als vc2 oder sc2, VCX kann auch SCX meinen)
                        <<>>-- FORM und DBC Einstellungen nutzen die folgenden Werte, solange nicht anders definiert. Siehe unten.
                        <<>>- Optionen für Datei per Klasse ( 1) (für VCX: vc2, für SCX: sc2)
                        <<>>UseClassPerFile: 0             && Bestimmt wie die Klassen einer Bibliothek oder die Objekte eines Formulars behandelt werden
                        <<>>                               && 0 Eine Textdatei pro VCX/SCX
                        <<>>                               && 1 Mehrere Dateien <Dateiname>.KlassenName.vc2
                        <<>>                               && 2 Mehrere Dateien <Dateiname>.Basisklasse.KlassenName.vc2
                        <<>>                               &&   Für 1, 2 wird jeweils auch ein Headerdatei <Dateiname>.vc2 erzeugt
                        <<>>RedirectClassPerFileToMain: 0  && Bestimmt beim Erzeugen von Binardateien für Klassenbibliotheken und Formulare die Zieldatei
                        <<>>                               && 0 Keine Umlenkung
                        <<>>                               && 1 Klassen (und Objekte) werden in die VCX/SCX geschrieben wenn eine Datei <Dateiname>[.Basisklasse].KlassenName.tx2 gewählt wurde
                        <<>>                               &&   RedirectClassType: 1 hat Vorrang
                        <<>>RedirectClassType: 0           && Für Textdateien die mit UseClassPerFile>0 in der Form <Dateiname>[.Basisklasse].KlassenName.tx2 erstellt wurden.
                        <<>>                               && diese Dateien können als Dateiname.tx2::KlassenName::import oder als <Dateiname>[.Basisklasse].KlassenName.tx2 importiert werden.
                        <<>>                               && Für die zweite Form gilt (jeweils VCX oder SCX ):
                        <<>>                               && 0 Aus <Dateiname>[.Basisklasse].KlassenName.tx2 wird <Dateiname>.VCX und alle Klassen dieser Bibliothek werden neu gelesen
                        <<>>                               && 1 Aus <Dateiname>[.Basisklasse].KlassenName.tx2 wird <Dateiname>[.Basisklasse].KlassenName.VCX, die Bibliothek file.VCX wird ignoriert
                        <<>>                               && 2 Aus <Dateiname>[.Basisklasse].KlassenName.tx2 wird <Dateiname>.VCX aber alle anderen Klassen bleiben unverändert
                        <<>>ClassPerFileCheck: 0           && Test, ob Dateien die in der Basisdatei definert wurden, einbezogen wurden.
                        <<>>                               && 0 Kein Test
                        <<>>                               && 1 Teste, ob die Datei <Dateiname>[.Basisklasse].KlassenName.tx2 einbezogen wurde
                        <<>>                               &&   Nur für die <Dateiname>[.Basisklasse].KlassenName.tx2 Syntax
                        <<>>                               &&   Wird für RedirectClassType: 2 ignoriert
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- Optionen für FORM
                        <<>>- Optionen für Datei per Form (UseFormPerFile: 1)
                        <<>>UseFormSettings: 0             && 1=Die unten stehenden Form Optionen werden aktiviert, 0=Die UseClassPerFile Einstellungen werden genutzt.
                        <<>>                               &&   Die unten stehenden Optionen werden nur gelesen, wenn UseFormSettings vorher 1 ist!
                        <<>>                               &&   Wird UseFormSettings wieder auf 0 gesetzt, gehen diese Einstellungen verloren.
                        <<>>UseFormPerFile: 0              && Bestimmt wie die Objekte eines Formulars behandelt werden
                        <<>>                               && 0 Eine Textdatei Form.sc2  pro SCX
                        <<>>                               && 1 Mehrere Dateien Form.Obj.sc2 pro SCX
                        <<>>                               && 2 Mehrere Dateien Form.baseclass.Obj.sc2 pro SCX
                        <<>>                               && Für 1, 2 wird jeweils auch ein Headerdatei <Form>.sc2 erzeugt
                        <<>>RedirectFormPerFileToMain: 0   && Bestimmt beim Erzeugen von Binardateien für Formulare die Zieldatei
                        <<>>                               && 0 Keine Umlenkung
                        <<>>                               && 1 Objekte werden in die SCX geschrieben wenn eine Datei Form.sc2 when selecting Form[.baseclass].Obj.sc2 gewählt wurde
                        <<>>                               &&   RedirectFormType: 1 1 hat Vorrang
                        <<>>RedirectFormType: 0            && Für Textdateien die mit UseFormPerFile>0 in der Form Form[.baseclass].Obj.sc2 erstellt wurden.
                        <<>>                               && diese Dateien können als Form.sc2::Class::import oder als Form[.baseclass].Obj.sc2 importiert werden.
                        <<>>                               && Für die zweite Form gilt (jeweils VCX oder SCX ):
                        <<>>                               && 0 Aus Form[.baseclass].Obj.sc2 wird Form.SCX und alle Klassen dieser Bibliothek werden neu gelesen
                        <<>>                               && 1 Aus Form[.baseclass].Obj.sc2 wird Form[.baseclass].Obj.SCX, die Bibliothek file.VCX wird ignoriert
                        <<>>                               && 2 Aus Form[.baseclass].Obj.sc2 wird Form.SCX aber alle anderen Klassen bleiben unverändert
                        <<>>FormPerFileCheck: 0            && Test, ob Dateien die in der Basisdatei definert wurden, einbezogen wurden.
                        <<>>                               && 0 Kein Test
                        <<>>                               && 1 Teste, ob die Datei Form[.baseclass].Obj.sc2 einbezogen wurde
                        <<>>                               &&   Nur für die  Form[.baseclass].Obj.sc2 Syntax
                        <<>>                               &&   Wird für RedirectFormType: 2 ignoriert
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- Optionen für DBC
                        <<>>- Optionen für Datei per DBC (UseFilesPerDBC: 1)
                        <<>>OldFilesPerDBC: 0              && 1=Die unten stehenden DBC Optionen werden aktiviert, 0=Die UseClassPerFile Einstellungen werden genutzt.
                        <<>>                               &&   Die unten stehenden Optionen werden nur gelesen, wenn OldFilesPerDBC vorher 1 ist!
                        <<>>                               &&   Wird OldFilesPerDBC wieder auf 0 gesetzt, gehen diese Einstellungen verloren.
                        <<>>UseFilesPerDBC: 0              && 0=Erzeuge eine dc2 Datei, 1=Erzeuge mehrfache Dateien.*.*.dc2
                        <<>>                               && 0 Erzeugt eine Datei <Datenbank>.db2 mit allem Inhalt der DBC
                        <<>>                               && 1 Erzeugt eine Datei <Datenbank>.dc2 mit den Eigenschaften der Datenbank
                        <<>>                               &&   und zusätzlich eine Datei für jedes Item der Datenbank (Gespeicherte Prozeduren, Tabellen, Views, ..)
                        <<>>                               &&   Achtung! Diese Dateien werden nur dann in die Binädatei einbezogen, wenn RedirectFilePerDBCToMain 1 ist
                        <<>>RedirectFilePerDBCToMain: 0    && Originale Dokumentation: 0=Keine Umlenkung, 1=Erzeuge <Datenbank>.dbc, wenn <Datenbank>.item.*.dc2 gewählt wurde
                        <<>>                               &&   Die Binär-Datenbank wird nur dann automatisch zusammen gefügt, wenn diese Option 1 ist!
                        <<>>ItemPerDBCCheck: 0             && 0=Aus, 1=Teste, ob <Datenbank>.item.*.dc2 einbezogen wird.
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Allgemeine Dateien
                        <<>>NoTimestamps: 1                && 0=Zeitstempel einiger Dateiarten werden nicht gelöscht 1=Zeitstempel werden zum Minimieren der Text-Datei-Unterschiede gelöscht
                        <<>>ClearUniqueID: 1               && 0=Erhalte die Unique ID in den Text-Dateien, 1=Lösche Unique ID. Nützlich für Diff und Merge
                        <<>>OptimizeByFilestamp: 0         && 0=Aus, 1=Optimierte Erzeugung der Binärdateien in Abhängigkeit vom Zeitstempel. Gefährlich beim Arbeiten mit Zweigen!
                        <<>>RemoveNullCharsFromCode: 1     && 0=Aus 1=Lösche .Null. (CHR(0)) Zeichen aus dem Quellcode
                        <<>>RemoveZOrderSetFromProps: 0    && 0=Aus, 1=Entferne ZOrderSet Eigenschaft von Objekten
                        <<>>PRG_Compat_Level: 0            && 0=Legacy, 1=Nutze HELPSTRING als Class Procedure Kommentar
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- speziell PJX
                        <<>>BodyDevInfo: 0                 && 0=DevInfo im body-pjx-Datensatz wird nicht erhalten], 1=DevInfo wird erhalten
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- speziell DBF
                        <<>>ClearDBFLastUpdate: 1          && 0=Erhalte DBF LastUpdate, 1=Lösche DBF LastUpdate. Nützlich für Diff und Merge
                        <<>>ExcludeDBFAutoincNextval: 0    && 0=Aus, 1=Entferne diesen Wert aus der Textdate der Datenbank (db2)
                        <<>>DBF_Conversion_Included: *     && Für DBF_Conversion_Support: 4 kann eine mehrfache Dateimaske zum Einbeziehen angegeben werden, z.B.: www,fb2p_free.dbf
                        <<>>                               && *=Alle, Die Maske darf Wildcards (*,?) enthalten
                        <<>>                               &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>DBF_Conversion_Excluded:       && Für DBF_Conversion_Support: 4 kann eine mehrfache Dateimaske zum Ausschließen angegeben werden, z.B.: www,fb2p_free.dbf
                        <<>>                               && Leer=Keine Datei auschließen
                        <<>>DBF_BinChar_Base64: 1          && Für Felder mit Zeichen Typ (C,V,M), wenn NoCPTrans, dann 0=nicht transform,ieren, 1=Führe Base64 Transformation aus (default)
                        <<>>                               &&   Dies entspricht dem Flag 4096 in CursorToXML()
                        <<>>                               &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>DBF_IncludeDeleted: 0          && 0=Ohne gelöschte Datensätze (default), 1=Mit gelöschten Datensätzen
                        <<>>                               &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Text-Datei Endungen
                        <<>>extension: tx2=newext          && Umdefinition der Dateiendung der Textdateien. Die vordefinierten Endungen enden mit '2' (Beispiel siehe Ende dieser Datei)
                        <<>>-- Beispiel für geänderte Textdatei Endungen, hier für SourceSafe Kompatibiltät:
                        <<>>extension: pj2=pja             && Text Datei für PJX
                        <<>>extension: vc2=vca             && Text Datei für VCX
                        <<>>extension: sc2=sca             && Text Datei für SCX
                        <<>>extension: fr2=fra             && Text Datei für FRX
                        <<>>extension: lb2=lba             && Text Datei für LBX
                        <<>>extension: mn2=mna             && Text Datei für MNX
                        <<>>extension: db2=dba             && Text Datei für DBF
                        <<>>extension: dc2=dca             && Text Datei für DBC
                        <<>>-- Zusätzliche Endungen
                        <<>>extension: fk2=fkx             && Text Datei für FKY
                        <<>>extension: me2=fkx             && Text Datei für MEM
                        <<>>
                            ENDTEXT
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>-- Individuelle DBF Konfigurations-Datei (Syntax: <Tabellenname>.dbf.cfg im Verzeichnis der Tabelle) Defaults siehe FoxBin2prg.cfg
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>DBF_Conversion_Support: <1,2,4,8>           && 0=Aus
                        <<>>                                            && 1=Erzeuge Textdatei nur für Struktur (Diff)
                        <<>>                                            && 2=Erzeuge Text- und Binärdatei nur für Struktur (Merge)
                        <<>>                                            && 4=Erzeuge Textdatei nur für Struktur und Daten (Diff)
                        <<>>                                            && 8=Erzeuge Text- und Binärdatei nur für Struktur und Daten (Merge)
                        <<>>DBF_Conversion_Order: <c_Expression>        && Optional, Reihenfolge der Datensätze. Ausdruck für INDEX ON. ie: name+str(age,3)
                        <<>>                                            && leer: normale Reihenfolge
                        <<>>DBF_Conversion_Condition: <c_Expression>    && Optional, Ausdruck für SELECT FOR. ie: age > 10 AND NOT DELETED()
                        <<>>                                            && leer: Alle, außer DBF_IncludeDeleted
                        <<>>DBF_IndexList: <cFile_List>                 && Kommagetrennte Liste von Dateien. Zusätzliche Index - Dateien. CDX oder IDX. Nicht der Strukturelle Index
                        <<>>DBF_BinChar_Base64: <0,1>                   && Für Felder mit Zeichen Typ (C,V,M), wenn NoCPTrans, dann 0=nicht transform,ieren, 1=Führe Base64 Transformation aus
                        <<>>                                            &&   Dies entspricht dem Flag 4096 in CursorToXML()
                        <<>>                                            &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>DBF_IncludeDeleted: <0,1>                   && 0=Ohne gelöschte Datensätze, 1=Mit gelöschten Datensätzen
                        <<>>                                            &&   Diese Option kann auch per Tabelle gesetzt werden.
                        <<>>
                            ENDTEXT
                            .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG arbeitet nur für Visual FoxPro 9.0!"
                            .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "WARNUNG!"
                            .C_GENERATED_FILE_SIZE_LOC                                      = "Generierte Dateigröße"
                            .C_GENERATING_BINARY_LOC                                        = "Gene Binary"
                            .C_INCLUDING_CLASS_LOC                                          = "einschließlich Klasse"
                            .C_INCLUDING_MEMBER_LOC                                         = "inklusive Mitglied"
                            .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Quell-Kompatibilitäts-Mode Incorrect VFP 9 Version - Fehlende SP1! Erwartet: 3504 oder größer, aktuell:" + Version(4)
                            .C_INHERITING_FROM_LOC                                          = "Ererbt von"
                            .C_INTERACTIVE_DIRECTORY_SELECTION_LOC                          = "Interaktives Auswählen des Verzeichnises"
                            .C_INVALID_PARAMETER_LOC                                        = "Ungültige Parameter"
                            .C_IS_A_FILE_LOC                                                = "ist eine DATEI"
                            .C_IS_A_DIRECTORY_LOC                                           = "ist ein VERZEICHNIS"
                            .C_IS_UNSUPPORTED_LOC                                           = "wird nicht unterstützt"
                            .C_LANGUAGE_LOC                                                 = "DE"
                            .C_MAIN_EXECUTION_LOC                                           = "HAUPTAUSFÜHRUNG"
                            .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "Menü [<<THIS.c_InputFile>>] ist NICHT im VFP 9 Format! - Bitte zuerst mit MODIFY MENU '<<THIS.c_InputFile>>' nach VFP 9 konvertieren."
                            .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Programm für Großschreibungssetzung [<<lcEXE_CAPS>>] gefunden"
                            .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* Programm für Großschreibungssetzung [<<lcEXE_CAPS>>] nicht gefunden"
                            .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Objekt [<<toObj.CLASS>>] enthält nicht das oReg Objekt (level <<TRANSFORM(tnNivel)>>)"
                            .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Befehl nicht erkannt. Nur SETNAME und GETNAME erlaubt."
                            .C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC             = "Optimierung: Überspringen von bereits bearbeiteten Datei [<<(lcFile)>>]"
                            .C_OPTION_LOC                                                   = "Option"
                            .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "Die äußere Klasse zeigt nicht die die innere Klassifizierung an"
                            .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "Das äußere Element entspricht nicht den inneren Elementen"
                            .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimierung: Ausgabedatei [<<lcOutputFile>>] wurde nicht überschrieben, da sie dieselbe ist wie die neu generierte."
                            .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimierung: Ausgabedatei [<<THIS.c_OutputFile>>] wurde nicht verlängert, weil ihre Zeitmarke die gleiche der Quelldatei ist."
                            .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimierung: Ausgabedatei [<<THIS.c_OutputFile>>] wurde nicht erneuert, da sie neuer als die Ursprungsdatei ist."
                            .C_PRESS_ESC_TO_CANCEL                                          = "Drücken Sie Esc zum Abbrechen"
                            .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Prozedur nicht geschlossen. Letzte Zeile des Codes muss ENDPROC sein. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
                            .C_PROCESSING_LOC                                               = "Bearbeite Datei"
                            .C_PROCESS_PROGRESS_LOC                                         = "Bearbeitungsfortschritt:"
                            .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Eigenschaft [<<TRANSFORM(tnPropertyID)>>] nicht erkannt."
                            .C_READING_CFG_VALUES_FROM_DISK_LOC                             = "Von der Festplatte gelesene Werte der CFG-DATEI"
                            .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Report [<<THIS.c_InputFile>>] ist NICHT in VFP 9 Format! - Bitte zuerst nach VFP 9 konvertieren mit MODIFY REPORT '<<THIS.c_InputFile>>'"
                            .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Fordere Großschreibung für Datei [<<tcFileName>>] an"
                            .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Scanne Datei- und Verzeichnisinformationen für"
                            .C_SOURCEFILE_LOC                                               = "Quell Datei: "
                            .C_SOURCESAFE_COMPATIBILITY_MODE_LOC                            = "Sourcesafe-Kompatibilitätsmodus"
                            .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Fehler in Verschachtelungsstruktur. ENDPROC erwartet, aber es wurde ENDDEFINE in Klasse <<toClase._Nombre>> (<<loProcedure._Nombre>>), Zeile <<TRANSFORM(m.I)>> der Datei <<THIS.c_InputFile>> gefunden"
                            .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Fehler in Verschachtelungsstruktur. ENDPROC wurde erwartet, aber es wurde ENDDEFINE in Klasse <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), Zeile <<TRANSFORM(m.I)>> der Datei <<THIS.c_InputFile>> gefunden"
                            .C_UNKNOWN_CLASS_NAME_LOC                                       = "Unbekannte Klasse [<<THIS.CLASS>>]"
                            .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Verwenden Sie die Datei-Zeitstempel-Optimierung"
                            .C_USING_THIS_SETTINGS_LOC                                      = "Mit dieser Einstellung"
                            .C_USING_THIS_SETTINGS_LOC1                                     = " BY PARAMETER, alle vorherigen Einstellungen werden zurückgesetzt!"
                            .C_USING_THIS_SETTINGS_LOC2                                     = " Komplette Auswertung der Konfiguration gestattet."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC3                                     = " Konfigurationsdateien von Unterverzeichnissen und ererbete Konfigurationen aus dem Baum werden ausgewertet."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC4                                     = " Konfigurationsdateien von Unterverzeichnissen werden ausgewertet."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC5                                     = " Es werden keine anderen Konfigurationsdateien gelesen."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC6                                     = "Externe Konfigurationsdatei übergeben: "
                            .C_USING_THIS_SETTINGS_LOC7                                     = ", nutze gespeicherte Konfiguration."
                            .C_WARNING_LOC                                                  = "WARNUNG!"
                            .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "WARNUNG!" + CR_LF+ "STELLEN SIE SICHER, DAS KEIN TABELLENALIAS IM INDEXAUSDRUCK BENUTZT WIRD!! (z.B.: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
                            .C_WITH_ERRORS_LOC                                              = "mit Fehlern"
                            .C_LOCKINGFOLDER_LOC                                            = " gefunden, das Verzeichnis und Unterverzeichnisse werden ignoriert."

                            .C_INDEX2TXT_PROCESSING_LOC                                     = " Ermittle Index"
                            .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Zusätzliche Index Dateien"
                            .C_INDEX2TXT_NOFILE_LOC                                         = "     Keine Datei "
                            .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index passt nicht zur Tabelle "
                            .C_INDEX2BIN_PROCESSING_LOC                                     = " Erstelle Index"
                            .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs für den strukturellen Index"
                            .C_INDEX2BIN_STANDALONE_LOC                                     = "  Eigenständige Indexdatei: "
                            .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs für verbundene Indexdatei: "
                            .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Hauptdatei "'
                            .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Projekt-Icon Datei "'
                            .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'Datei ""'
                            .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'ist nicht in der PJX Ordner Struktur, "'
                            .C_PJXPATH_ERR_LOC5                                             = '",' + CR_LF + 'siehe Option "CheckFileInPath".' + CR_LF+CR_LF


                        Otherwise   && English (Inglés)
*-------------------------------------------------------------------------------------------------------------------------------------------
*-- NOTE: MUST USE DOUBLE QUOTES, OR SYNTAX ERRORS HAPPEN WHEN COMPILING. STRANGE :(
*-------------------------------------------------------------------------------------------------------------------------------------------
                            .C_ALLOWED_VALUES_ARE_LOC                                       = "Allowed values are"
                            .C_ASTERISK_EXT_NOT_ALLOWED_LOC                                 = "* and ? extensions are not allowed because it's dangerous (binaries can be overwritten with xx2 empty files)"
                            .C_BACKLINK_CANT_UPDATE_BL_LOC                                  = "Could not update backlink"
                            .C_BACKLINK_OF_TABLE_LOC                                        = "of table"
                            .C_BACKUP_OF_LOC                                                = "Doing Backup of: "
                            .C_CACHING_CONFIG_FOR_DIRECTORY_LOC                             = "Caching config for directory"
                            .C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC                = "Cannot generate file [<<THIS.c_OutputFile>>] because it is ReadOnly"
                            .C_CLASSPERFILE_OPTIMIZATION_BASE_ALREADY_PROCESSED_LOC         = "Optimization: Base File [<<JUSTFNAME(.c_InputFile)>>] already processed, skipping processing of file [<<tc_InputFile>>]"
                            .C_CONFIGFILE_LOC                                               = "Using configuration file:"
                            .C_CONVERSION_CANCELLED_BY_USER_LOC                             = "Conversion Cancelled by the user"
                            .C_CONVERT_ALL_FILES_IN_A_PROJECT_LOC                           = "Convert all files in a Project"
                            .C_CONVERT_FOLDER_LOC                                           = "Convert Folder"
                            .C_BINARY_TO_TEXT_LOC                                           = "Binary to Text"
                            .C_TEXT_TO_BINARY_LOC                                           = "Text to Binary"
                            .C_CONVERT_FOLDER_NONE_LOC                                      = "None"
                            .C_CONVERT_FOLDER_QUESTION_LOC                                  = "What conversion should be performed on the files of this folder?"
                            .C_CONVERTER_UNLOAD_LOC                                         = "Converter unload"
                            .C_CONVERTING_FILE_LOC                                          = "Converting file"
                            .C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC            = "Data Error: Can't parse because of unpaired double-quotes on line <<lcMetadatos>>"
                            .C_DUPLICATED_FILE_LOC                                          = "Duplicated file"
                            .C_DUPLICATED_OBJECT_LOC                                        = "Duplicated Object"
                            .C_ENDDEFINE_MARKER_NOT_FOUND_LOC                               = "Cannot find end marker [ENDDEFINE] of line <<TRANSFORM( toClase._Inicio )>> for ID [<<toClase._Nombre>>]"
                            .C_END_MARKER_NOT_FOUND_LOC                                     = "Cannot find end marker [<<ta_ID_Bloques(lnPrimerID,2)>>] that closes start marker [<<ta_ID_Bloques(lnPrimerID,1)>>] on line <<TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))>>"
                            .C_END_OF_PROCESS_LOC                                           = "End of Process"
                            .C_ERROR_LOC                                                    = "ERROR"
                            .C_ERRORS_FOUND_IN_FILE_LOC                                     = "ERRORS FOUND IN FILE"
                            .C_EXTENSION_RECONFIGURATION_LOC                                = "Extension Reconfiguration:"
                            .C_EXTERNAL_CLASS_COUNT_DOES_NOT_MATCH_FOUND_CLASSES_LOC        = "External class count (<<toModulo._ExternalClasses_Count>>) does not match found classes (<<toModulo._Clases_Count>>) for file [<<toFoxBin2Prg.c_InputFile>>]"
                            .C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC                        = "External class was not found"
                            .C_EXTERNAL_MEMBER_NAME_WAS_NOT_FOUND_LOC                       = "External member name was not found"
                            .C_EXTERNAL_PARAMETERS_LOC                                      = "EXTERNAL PARAMETERS"
                            .C_FIELD_NOT_FOUND_ON_FILE_STRUCTURE_LOC                        = "Field [<<laProps(m.I)>>] not found in structure of file <<DBF('TABLABIN')>>"
                            .C_FILE_DOESNT_EXIST_LOC                                        = "File does not exist:"
                            .C_FILE_NAME_IS_NOT_SUPPORTED_LOC                               = "File [<<.c_InputFile>>] is not supported"
                            .C_FILE_NOT_FOUND_LOC                                           = "File not found"
                            .C_FILENAME_LOC                                                 = "File"
                            .C_FOXBIN2PRG_ERROR_CAPTION_LOC                                 = "ERROR"
                            .C_FOXBIN2PRG_SYNTAX_INFO_LOC                                   = "SYNTAX AND PARAMETERS INFO"
                            .C_ClassTwice_Header_LOC                                        = CR_LF+"Class defined twice."+CR_LF
                            .C_ClassTwice_Lib_LOC                                           = CR_LF+"Library: "
                            .C_ClassTwice_Class_LOC                                         = CR_LF+"Class: "
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FoxBin2Prg Home Page and download: https://github.com/fdbozzo/foxbin2prg/wiki  -  Fernando D. Bozzo (2013.11.25)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>FOXBIN2PRG.EXE <cFileSpec.Ext> [cType [cTextName [cGenText [cDontShowErrors [cDebug [cDontShowProgress [cOriginalFileName [cRecompile [cNoTimestamps [cCFG_File [cOutputFolder] ] ] ] ] ] ] ] ] ] ]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>cFileSpec.Ext:     ? | interactive This help
                        <<>>                   Full name (fullpath) of the file to convert or directory name to process
                        <<>>                     - If 'BIN2PRG' is specified, the directory specified in tcType is processed for generating TX2
                        <<>>                     - If 'PRG2BIN' is specified, the directory specified in tcType is processed for regenerating BIN
                        <<>>                     - In SCCAPI (VSS) compatibility mode, it is used to query the conversion support for the file type specified
                        <<>>                       VSS Types: d=DBC, D=DBF, K=Form, B=Label, M=Menu, R=Report, V=Class
                        <<>>cType:             In SCCAPI (VSS) compatibility mode indicates the input file type.
                        <<>>                        - If specified '*' or '*-' and tc_InputFile is a PJX, all project files are processed
                        <<>>cTextName          = Text filename. Only for SCCAPI (VSS) compatibility mode.
                        <<>>lGenText:          .T.=Generates Text, .F.=Regenerates Binary. Only for SCCAPI (VSS) compatibility mode.
                        <<>>cDontShowErrors:   '1' for NOT showing errors
                        <<>>cDebug:            '1' for generating process LOGs, stop on errors
                        <<>>cDontShowProgress: '1' for NOT showing the process window
                        <<>>cOriginalFileName: used in those cases in which inputFile is a temporary filename and you want to generate the correct filename on the header of the text version
                        <<>>cRecompile:        Indicates recompile ('1') the binary once regenerated. You can specify a Path too (ie, the project one)
                        <<>>cNoTimestamps:     Indicates if timestamp of several file types must be cleared ('1' or empty) or not ('0')
                        <<>>cCFG_File:         Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cOutputFolder:     The output folder to write to. If it isn't specified, the same folder as the source is used.
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE c|C|t [OutFileName [ cCFG_File[ cDebug]]]
                        <<>>DO FOXBIN2PRG.EXE WITH -c|-C|-t [, OutFileName [, cCFG_File[, cDebug]]]
                        <<>>
                        <<>>-- Parameter details:
                        <<>>No parameter: Calls this info screen
                        <<>>-c (c)        Creates a template config-file <OutFileName> (like FOXBIN2PRG.CFG)
                        <<>>-C (C)        Creates a config-file <OutFileName> (like FOXBIN2PRG.CFG) with current options of folder of <OutFileName>
                        <<>>              If OutFileName is not given a FoxBin2Prg._cfg config file will be created at default folder
                        <<>>-t (t)        Creates a template table-config-file <OutFileName> (like <Tablename>.dbf.cfg)
                        <<>>              If OutFileName is not given, and a table is open a <Tablename>.dbf._cfg config file will be created at table folder.
                        <<>>cCFG_File:    Indicates a CFG filename for using special default instead of the config file in foxbin2prg directory.
                        <<>>cDebug:       '1' for generating process LOGs, stop on errors
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>FOXBIN2PRG.EXE VERNO
                        <<>>DO FOXBIN2PRG.EXE WITH "VERNO"|cPara
                        <<>>
                        <<>>-- Parameter details:
                        <<>>-VERNO (VERNO) Return version number of FoxBin2Prg
                        <<>>cPara          A parameter with the Value "VERNO", the version number is returned to this parameter
                        <<>>
                        <<>>
                            ENDTEXT
*** DH 2021-03-04: added HomeDir to text
*** DH 2024-08-26: added text for option 2 for BodyDevInfo
                            .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_Header4 = "*Options for folder <<.c_Recompile>>, read as of <<DATETIME()>>"
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>FOXBIN2PRG.CFG configuration options: (If no values given, these are the DEFAULTS)
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>> Note, configuration files will follow an inheritance.
                        <<>> 1.  Default values
                        <<>> 2., optional FOXBIN2PRG.CFG in folder of FOXBIN2PRG.EXE
                        <<>>  or, if defined, a config file given by a parameter calling FOXBIN2PRG
                        <<>>      if used, the InhibitInheritance setting controls if other config files will be evaluated (default). See below.
                        <<>> 3., optional FOXBIN2PRG.CFG in root of working directory
                        <<>> 4., optional FOXBIN2PRG.CFG in every folder up to the working directory
                        <<>> 5., optional Special settings per single DBF's Syntax: <TableName>.dbf.cfg in tables folder)
                        <<>>
                        <<>> Some Parameter calling FOXBIN2PRG.EXE overturn this settings (except Defaults)
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>-- Settings for internal work, not processing
                        <<>>Language: (auto)               && Language of shown messages and LOGs. EN=English, FR=French, ES=Español, DE=German, Not defined = AUTOMATIC [DEFAULT]
                        <<>>ShowProgressbar: 1             && 0=Don't show, 1=Allways show, 2=Show only for multi-file processing
                        <<>>DontShowErrors: 0              && Show message errors by default
                        <<>>ExtraBackupLevels: 1           && By default 1 BAK is created. With this you can make more .N.BAK, or none
                        <<>>Debug: 0                       && 0=Don't Activate individual <file>.Log by default
                        <<>>                               && 1=Activate individual <file>.Log by default
                        <<>>                               && 2=???
                        <<>>                               && Only valid if not controlled by parameter
                        <<>>BackgroundImage: <cFile>       && Backgroundimage for process form. Empty for empty Background. File not found uses default.
                        <<>>HomeDir: 1                     && Home directory in PJX
                        <<>>                               && 0 don't save HomeDir in PJ2
                        <<>>                               && 1 save HomeDir in PJ2
                        <<>>~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                        <<>>-- Settings for config file via parameter only
                        <<>>InhibitInheritance: 0          && 0=Allow scanning "regular" config files (file via parameter is just additional default)
                        <<>>                               && 1=Only read tree from root of the file given by parameter, not FoxBin2Prg default
                        <<>>                               && 2=Only read folder and subfolder of the file given by parameter
                        <<>>                               && 3=Read no other file
                        <<>>                               && This is like
                        <<>>                               && 0 Default | Parameter file | Default near FoxBin2Prg | all other config files
                        <<>>                               && 1 Default | Parameter file | Inheritance from root to parent of folder | folder and subdirs
                        <<>>                               && 2 Default | Parameter file | folder and subdirs
                        <<>>                               && 3 Default | Parameter file
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Conversion operation by type
                        <<>>PJX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>VCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>SCX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>FRX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>LBX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>MNX_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBC_Conversion_Support: 2      && 0=No support, 1=Generate TXT only (Diff), 2=Generate TXT and BIN (Merge)
                        <<>>DBF_Conversion_Support: 1      && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>FKY_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>MEM_Conversion_Support: 1      && 0=No support, 1=Generate TXT only (Diff)
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for pjx files
                        <<>>CheckFileInPath: 0             && Determines 2Txt deals with files not in the subfolders of the PJX. No handler for UNC paths.
                        <<>>                               && 0 Ignore. Default
                        <<>>                               && 1 Check and error out if file is not on same structure (for source control)
                        <<>>                               && 2 Create absolute path if file is on different drive.
                        <<>>                               && 3 Create absolute path if file is not in structure
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>Setting for container files (not pjx)
                        <<>>-- CLASS (, FORM and DBC) options (tx2 is to read as vc2 or sc2, VCX might be SCX)
                        <<>>-- FORM and DBC options default to this settings, if not set otherwise. See below.
                        <<>>- Class per file options (UseClassPerFile: 1)
                        <<>>UseClassPerFile: 0             && Determines how a library (or form) will handle included class (or, for forms, objects)
                        <<>>                               && 0 One library.tx2 file
                        <<>>                               && 1 Multiple file.class.tx2 files
                        <<>>                               && 2 Multiple file.baseclass.class.tx2 files
                        <<>>RedirectClassPerFileToMain: 0  && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to file.vcx/scx
                        <<>>                               && 1 Redirect to file.vcx/scx when selecting file[.baseclass].class.tx2
                        <<>>                               &&   RedirectClassType: 1 has precedence
                        <<>>RedirectClassType: 0           && For classes created with UseClassPerFile>0 in the form file[.baseclass].class.tx2
                        <<>>                               && Those files could be imported like file.tx2::Class::import or like file[.baseclass].class.tx2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect file[.baseclass].class.tx2 to file.VCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect file[.baseclass].class.tx2 to file[.baseclass].class.VCX and do not touch file.VCX
                        <<>>                               && 2 Redirect file[.baseclass].class.tx2 to file.VCX and do not touch other classes of file.VCX
                        <<>>ClassPerFileCheck: 0           && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check file[.baseclass].class.tx2 inclusion
                        <<>>                               &&   Only used if import file is in file[.baseclass].class.tx2 syntax
                        <<>>                               &&   Ignored for RedirectClassType: 2
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- FORM options
                        <<>>- Form per file options (UseFormSettings: 1)
                        <<>>UseFormSettings: 0             && 1=Turns the File per SCX options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if UseFormSettings is set 1 before!
                        <<>>                               &&   If UseFormSettings is set 0 later, all setting will be lost
                        <<>>UseFormPerFile: 0              && Determines how a form will handle included objects
                        <<>>                               && 0 One Form.sc2 file
                        <<>>                               && 1 Multiple Form.Obj.sc2 files
                        <<>>                               && 2 Multiple Form.baseclass.Obj.sc2 files
                        <<>>RedirectFormPerFileToMain: 0   && When regenerating binary files, determine target file
                        <<>>                               && 0 Don't redirect to Form.scx
                        <<>>                               && 1 Redirect to Form.scx when selecting Form[.baseclass].Obj.sc2
                        <<>>                               &&   RedirectFormType: 1 has precedence
                        <<>>RedirectFormType: 0            && For classes created with UseFormPerFile>0 in the form Form[.baseclass].Obj.sc2
                        <<>>                               && Those files could be imported like Form.sc2::Class::import or like Form[.baseclass].Obj.sc2
                        <<>>                               && For the second form:
                        <<>>                               && 0 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and add / replace all other classes of this library
                        <<>>                               && 1 Redirect Form[.baseclass].Obj.sc2 to Form[.baseclass].Obj.SCX and do not touch Form.SCX
                        <<>>                               && 2 Redirect Form[.baseclass].Obj.sc2 to Form.SCX and do not touch other classes of Form.SCX
                        <<>>FormPerFileCheck: 0            && Check, if files listed in the main file of a library or form will be included
                        <<>>                               && 0 Don't check file inclusion
                        <<>>                               && 1 Check Form[.baseclass].Obj.sc2 inclusion
                        <<>>                               &&   Only used if import file is in Form[.baseclass].Obj.sc2 syntax
                        <<>>                               &&   Ignored for RedirectFormType: 2
                        <<>>- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
                        <<>>
                        <<>>-- DBC options
                        <<>>- File per DBC options (UseFilesPerDBC: 1)
                        <<>>OldFilesPerDBC: 0              && 1=Turns the File per DBC options on, 0 uses the old UseClassPerFile etc settings.
                        <<>>                               &&   Options below will only read if OldFilesPerDBC is set 1 before!
                        <<>>                               &&   If OldFilesPerDBC is set 0 later, all setting will be lost
                        <<>>UseFilesPerDBC: 0              && 0=One database dc2 file, 1=Multiple file.*.*.dc2 files
                        <<>>                               && 0 creates only a file.dc2 with all DBC (file) data
                        <<>>                               && 1 creates a file.dc2 with DBC properties
                        <<>>                               &&   and additional DBC files per DBC item (stored-proc, table, ..)
                        <<>>                               &&   Note: recration only if RedirectFilePerDBCToMain is 1
                        <<>>RedirectFilePerDBCToMain: 0    && 0=Don't redirect to file.dc2, 1=Redirect to file.tx2 when selecting file.item.*.dc2
                        <<>>ItemPerDBCCheck: 0             && 0=Don't check file.item.*.dc2 inclusion, 1=Check file.item.*.dc2 inclusion
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- General files
                        <<>>NoTimestamps: 1                && Clear timestamps of several file types by default for minimize text-file differences
                        <<>>ClearUniqueID: 1               && 0=Keep UniqueID in text files, 1=Clear Unique ID. Useful for Diff and Merge
                        <<>>OptimizeByFilestamp: 0         && 1=Optimize file regeneration depending on file timestamp. Dangerous while working with branches!
                        <<>>RemoveNullCharsFromCode: 1     && 1=Drop .Null. chars from source code
                        <<>>RemoveZOrderSetFromProps: 0    && 0=Do not remove ZOrderSet property from object, 1=Remove ZOrderSet property from object
                        <<>>PRG_Compat_Level: 0            && 0=Legacy, 1=Use HELPSTRING as Class Procedure comment
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- PJX special
                        <<>>BodyDevInfo: 0                 && 0=Don't keep DevInfo for body pjx records, 1=Keep DevInfo, 2 = Don't keep DevInfo or ObjRev
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- DBF special
                        <<>>ClearDBFLastUpdate: 1          && 0=Keep DBF LastUpdate, 1=Clear DBF LastUpdate. Useful for Diff.
                        <<>>ExcludeDBFAutoincNextval: 0    && 0=Do not exclude this value from db2, 1=Exclude this value from db2
                        <<>>DBF_Conversion_Included: *     && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_Conversion_Excluded:       && If DBF_Conversion_Support:4, you can specify multiple filemasks: www,fb2p_free.dbf
                        <<>>DBF_BinChar_Base64: 1          && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform (default)
                        <<>>DBF_IncludeDeleted: 0          && 0=Do not include deleted records (default), 1=Include deleted records
                        <<>>----------------------------------------------------------------------------------------------------------------
                        <<>>
                        <<>>-- Text file extensions
                        <<>>extension: tx2=newext          && Specify extensions to use. Default FoxBin2Prg extensions ends in '2' (see at the bottom)
                        <<>>-- Example configuration for SourceSafe compatibility:
                        <<>>extension: pj2=pja             && Text file to PJX
                        <<>>extension: vc2=vca             && Text file to VCX
                        <<>>extension: sc2=sca             && Text file to SCX
                        <<>>extension: fr2=fra             && Text file to FRX
                        <<>>extension: lb2=lba             && Text file to LBX
                        <<>>extension: mn2=mna             && Text file to MNX
                        <<>>extension: db2=dba             && Text file to DBF
                        <<>>extension: dc2=dca             && Text file to DBC
                        <<>>-- Additional extensions
                        <<>>extension: fk2=fkx             && Text file to FKY
                        <<>>extension: me2=fkx             && Text file to MEM
                        <<>>
                            ENDTEXT
                            TEXT TO .C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<>>################################################################################################################
                        <<>>-- Individual DBF configuration file (syntax: filename.dbf.cfg) Defaults see FoxBin2prg.cfg
                        <<>>Version: <<_Screen.c_FB2PRG_EXE_Version>>
                        <<>>****************************************************************************************************************
                        <<>>
                        <<>>DBF_Conversion_Support: <0,1,2,4,8>         && 0=No support, 1=Generate Header TXT only (Diff), 2=Generate Header TXT and BIN (Merge/Only Structure!), 4=Generate TXT with DATA (Diff), 8=Export and Import DATA (Merge/Structure & Data)
                        <<>>DBF_Conversion_Order: <c_Expression>        && Field expresion. ie: name+str(age,3)
                        <<>>DBF_Conversion_Condition: <c_Expression>    && Logical expression. ie: age > 10 AND NOT DELETED()
                        <<>>DBF_IndexList: <cFile_List>                 && comma delimited list of additonal non structural index files, cdx or idx
                        <<>>DBF_BinChar_Base64: <0,1>                   && For character type fields, if NoCPTrans 0=do not transform, 1=use Base64 transform
                        <<>>DBF_IncludeDeleted: <0,1>                   && 0=Do not include deleted records, 1=Include deleted records
                        <<>>
                            ENDTEXT
                            .C_FOXBIN2PRG_JUST_VFP_9_LOC                                    = "FOXBIN2PRG is only for Visual FoxPro 9.0!"
                            .C_FOXBIN2PRG_WARN_CAPTION_LOC                                  = "WARNING!"
                            .C_GENERATED_FILE_SIZE_LOC                                      = "Generated file size"
                            .C_GENERATING_BINARY_LOC                                        = "Generating Binary"
                            .C_INCLUDING_CLASS_LOC                                          = "Including class"
                            .C_INCLUDING_MEMBER_LOC                                         = "Including member"
                            .C_INCORRECT_VFP9_VERSION__MISSING_SP1_LOC                      = "Incorrect VFP 9 version - Missing SP1! Expected: 3504 or later, actual: " + Version(4)
                            .C_INHERITING_FROM_LOC                                          = "Inheriting from"
                            .C_INTERACTIVE_DIRECTORY_SELECTION_LOC                          = "Interactive Directory Selection"
                            .C_INVALID_PARAMETER_LOC                                        = "Invalid parameter"
                            .C_IS_A_FILE_LOC                                                = "is a FILE"
                            .C_IS_A_DIRECTORY_LOC                                           = "is a DIRECTORY"
                            .C_IS_UNSUPPORTED_LOC                                           = "is unsupported"
                            .C_LANGUAGE_LOC                                                 = "EN"
                            .C_MAIN_EXECUTION_LOC                                           = "MAIN EXECUTION"
                            .C_MENU_NOT_IN_VFP9_FORMAT_LOC                                  = "Menu [<<THIS.c_InputFile>>] is NOT in VFP 9 Format! - Please convert to VFP 9 with MODIFY MENU '<<THIS.c_InputFile>>'"
                            .C_NAMES_CAPITALIZATION_PROGRAM_FOUND_LOC                       = "* Names capitalization program [<<lcEXE_CAPS>>] found"
                            .C_NAMES_CAPITALIZATION_PROGRAM_NOT_FOUND_LOC                   = "* Names capitalization program [<<lcEXE_CAPS>>] not found"
                            .C_OBJECT_NAME_WITHOUT_OBJECT_OREG_LOC                          = "Object [<<toObj.CLASS>>] does not contain oReg object (level <<TRANSFORM(tnNivel)>>)"
                            .C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC                      = "Operation not recognized. Only SETNAME and GETNAME allowed."
                            .C_OPTIMIZATION_SKIPPING_ALREADY_PROCESSED_FILE_LOC             = "Optimization: skipping already processed file [<<(lcFile)>>]"
                            .C_OPTION_LOC                                                   = "Option"
                            .C_OUTER_CLASS_DOES_NOT_MATCH_INNER_CLASSES_LOC                 = "The outer class does not match the inner classes"
                            .C_OUTER_MEMBER_DOES_NOT_MATCH_INNER_MEMBERS_LOC                = "The outer member does not match the inner members"
                            .C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC                            = "Optimization: output file [<<lcOutputFile>>] was not overwritten because it is the same as the existing one."
                            .C_OUTPUTFILE_TIMESTAMP_EQUAL_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimization: output file [<<THIS.c_OutputFile>>] was not regenerated because it's filestamp is equal than the inputfile."
                            .C_OUTPUTFILE_TIMESTAMP_NEWER_THAN_INPUTFILE_TIMESTAMP_LOC      = "Optimization: output file [<<THIS.c_OutputFile>>] was not regenerated because it's filestamp is newer than the inputfile."
                            .C_PRESS_ESC_TO_CANCEL                                          = "Press Esc to Cancel"
                            .C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC                             = "Procedure not closed. Last line of code must be ENDPROC. [<<laLineas(1)>>, Recno:<<RECNO()>>]"
                            .C_PROCESSING_LOC                                               = "Processing file"
                            .C_PROCESS_PROGRESS_LOC                                         = "Process Progress:"
                            .C_PROPERTY_NAME_NOT_RECOGNIZED_LOC                             = "Property [<<TRANSFORM(tnPropertyID)>>] is not recognized."
                            .C_READING_CFG_VALUES_FROM_DISK_LOC                             = "READING CFG VALUES FROM DISK"
                            .C_REPORT_NOT_IN_VFP9_FORMAT_LOC                                = "Report [<<THIS.c_InputFile>>] is NOT in VFP 9 Format! - Please convert to VFP 9 with MODIFY REPORT '<<THIS.c_InputFile>>'"
                            .C_REQUESTING_CAPITALIZATION_OF_FILE_LOC                        = "- Requesting capitalization of file [<<tcFileName>>]"
                            .C_SCANNING_FILE_AND_DIR_INFO_LOC                               = "Scanning file and directory information for"
                            .C_SOURCEFILE_LOC                                               = "Source file: "
                            .C_SOURCESAFE_COMPATIBILITY_MODE_LOC                            = "SourceSafe Compatibility Mode"
                            .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC                 = "Nesting structure error. ENDPROC expected but found ENDDEFINE on class <<toClase._Nombre>> (<<loProcedure._Nombre>>), line <<TRANSFORM(m.I)>> of file <<THIS.c_InputFile>>"
                            .C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC               = "Nesting structure error. ENDPROC expected but found ENDDEFINE on class <<toClase._Nombre>> (<<toObjeto._Nombre>>.<<loProcedure._Nombre>>), line <<TRANSFORM(m.I)>> of file <<THIS.c_InputFile>>"
                            .C_UNKNOWN_CLASS_NAME_LOC                                       = "Unknown class [<<THIS.CLASS>>]"
                            .C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC                          = "Use file timestamp Optimization"
                            .C_USING_THIS_SETTINGS_LOC                                      = "Using this settings"
                            .C_USING_THIS_SETTINGS_LOC1                                     = " BY PARAMETER, skipping all previous config!"
                            .C_USING_THIS_SETTINGS_LOC2                                     = " Parsing of full configuration allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC3                                     = " Parsing configuration in parent~ and subdirectories allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC4                                     = " Parsing configuration in subdirectories allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC5                                     = " Parsing of other configuration not allowed."+CR_LF
                            .C_USING_THIS_SETTINGS_LOC6                                     = "External configuration file set: "
                            .C_USING_THIS_SETTINGS_LOC7                                     = ", using cached config."
                            .C_WARNING_LOC                                                  = "WARNING!"
                            .C_WARN_TABLE_ALIAS_ON_INDEX_EXPRESSION_LOC                     = "WARNING!" + CR_LF+ "MAKE SURE YOU ARE NOT USING A TABLE ALIAS ON INDEX KEY EXPRESSIONS!! (ex: index on <<UPPER(JUSTSTEM(THIS.c_InputFile))>>.campo tag keyname)"
                            .C_WITH_ERRORS_LOC                                              = "with errors"
                            .C_LOCKINGFOLDER_LOC                                            = " found, proccessing directory and subdirectories inhibited."

                            .C_INDEX2TXT_PROCESSING_LOC                                     = " Processing index"
                            .C_INDEX2TXT_EXTRAFILES_LOC                                     = "  Additional index files"
                            .C_INDEX2TXT_NOFILE_LOC                                         = "     Not a File "
                            .C_INDEX2TXT_NOTTHISTABLE_LOC                                   = "   Index does not match table "
                            .C_INDEX2BIN_PROCESSING_LOC                                     = " Creating index"
                            .C_INDEX2BIN_STRUCTURAL_LOC                                     = "  TAGs for structural index"
                            .C_INDEX2BIN_STANDALONE_LOC                                     = "  Standalone index "
                            .C_INDEX2BIN_COMPOUND_LOC                                       = "  TAGs for compound index "
                            .C_PJXPATH_ERR_LOC1                                             = CR_LF + 'Main file "'
                            .C_PJXPATH_ERR_LOC2                                             = CR_LF + 'Project icon file "'
                            .C_PJXPATH_ERR_LOC3                                             = CR_LF + 'File ""'
                            .C_PJXPATH_ERR_LOC4                                             = '"' + CR_LF + 'not in PJX folder structure, "'
                            .C_PJXPATH_ERR_LOC5                                             = '",' + 0h0D0A + 'check option "CheckFileInPath".' + CR_LF+CR_LF

                            .n_LanguageSelectedMethod   = 0 && 0=Automatic with VERSION(3)

                    Endcase
                Endwith && THIS AS CL_LANG OF 'FOXBIN2PRG.PRG'
        Endtry
    Endproc

Enddefine



Define Class CL_DBF_CFG As Custom
    _MemberData = [<VFPData>] ;
        + [<memberdata name="dbf_conversion_support" display="DBF_Conversion_Support"/>] ;
        + [<memberdata name="dbf_conversion_order" display="DBF_Conversion_Order"/>] ;
        + [<memberdata name="dbf_conversion_condition" display="DBF_Conversion_Condition"/>] ;
        + [<memberdata name="dbf_indexlist" display="DBF_IndexList"/>] ;
        + [<memberdata name="l_dbf_binchar_base64" display="l_DBF_BinChar_Base64"/>] ;
        + [<memberdata name="l_dbf_includedeleted" display="l_DBF_IncludeDeleted"/>] ;
        + [</VFPData>]

    #If .F.
        Local This As CL_DBF_CFG Of 'FOXBIN2PRG.PRG'
    #Endif


*-- Configuration class. By default asumes master value, except when overriding one.
    n_DBF_Conversion_Support    = .Null.
    DBF_Conversion_Order        = ''
    DBF_Conversion_Condition    = ''
    DBF_IndexList               = ''
    l_DBF_BinChar_Base64        = .Null.
    l_DBF_IncludeDeleted        = .Null.
Enddefine



Define Class CL_MACRO As CL_COL_BASE
    #If .F.
        Local This As CL_MACRO Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="c_inputfile" display="c_InputFile"/>] ;
        + [<memberdata name="_numberofmacros" display="_NumberOfMacros"/>] ;
        + [<memberdata name="_debug" display="_Debug"/>] ;
        + [<memberdata name="_signature" display="_Signature"/>] ;
        + [<memberdata name="get_datafrommacrofky" display="get_DataFromMacroFKY"/>] ;
        + [<memberdata name="_macros" display="_Macros"/>] ;
        + [</VFPData>]


    c_InputFile         = ''

*-- Macro Header
    _Signature          = ''
    _Debug              = .F.
    _NumberOfMacros     = ''
    _Macros             = .Null.        && Colección de macros



    Procedure Init
        DoDefault()
        This._Macros = Createobject("COLLECTION")
    Endproc


    Procedure get_DataFromMacroFKY(tcInputFile As String, toFoxBin2Prg)
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcInputFile               (!v IN    ) Archivo de entrada
* toFoxBin2Prg              (!@ IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Local lnHandle, lnFileLen, lcMsg, lcStr, lnNumberOfMacros ;
            , loMRec As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG' ;
            , loColl As Collection ;
            , loEx As Exception

        Try
                lnHandle    = -1

                With This As CL_MACRO Of 'FOXBIN2PRG.PRG'
                    loColl      = ._Macros
                    lnHandle    = Fopen(tcInputFile, 0)

                    If lnHandle = -1
                        lcMsg   = toFoxBin2Prg.FERROR_Message(tcInputFile)
                        Error (lcMsg)
                    Endif

                    lnFileLen   = Fseek(lnHandle, 0, 2)

                    If lnFileLen < 17
                        Error 'Invalid FKY Macro File size'
                    Else
                        =Fseek(lnHandle, 0, 0)
                    Endif

                    ._Signature = Fread(lnHandle, 2)

                    If ._Signature <> Chr(0xFF)+Chr(0x79)
                        Error 'Invalid FKY Macro signature'
                    Endif

                    =Fseek(lnHandle, 14, 1) && Saltar bytes ignorados

                    ._NumberOfMacros    = Fread(lnHandle, 2)
                    lnNumberOfMacros    = CToBin(._NumberOfMacros,'2RS')

                    If lnFileLen < 17 + 25 * lnNumberOfMacros
* 25 caracteres es el tamaño mínimo de una macro sin teclas guardadas (solo la estructura)
                        Error 'Invalid FKY Macro File size'
                    Endif

                    For I = 1 To lnNumberOfMacros
                        loMRec  = Createobject("CL_MACRO_RECORD")

                        If Not loMRec.ReadNextMacro(lnHandle)
                            Exit
                        Endif

                        loColl.Add( loMRec, loMRec.get_Macro_Keystrokes(loMRec.Keystroke, .T.) )
                        loMRec  = .Null.
                    Endfor

* Ordenar alfabéticamente por keystroke
                    loColl.KeySort = 2

                Endwith

            Catch To loEx
*loEx.UserValue = loEx.UserValue + 'lcAsignacion = [' + TRANSFORM(lcAsignacion) + ']' + CR_LF

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                If lnHandle <> -1
                    =Fclose(lnHandle)
                Endif
        Endtry

        Return
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------
        Local lcText, loMRec As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG'
        lcText  = ''

        With This As CL_MACRO Of 'FOXBIN2PRG.PRG'

*-- Macros
            For Each loMRec As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG' In ._Macros
                lcText  = lcText + CR_LF + loMRec.toText()
            Endfor

        Endwith

        Return lcText
    Endproc


Enddefine



Define Class CL_MACRO_RECORD As CL_CUS_BASE OF 'cl_cus_base.prg'
    _MemberData = [<VFPData>] ;
        + [<memberdata name="macro_name" display="Macro_Name"/>] ;
        + [<memberdata name="macro_length" display="Macro_Length"/>] ;
        + [<memberdata name="keystroke" display="Keystroke"/>] ;
        + [<memberdata name="macro_keystrokes" display="Macro_Keystrokes"/>] ;
        + [<memberdata name="readnextmacro" display="ReadNextMacro"/>] ;
        + [<memberdata name="totext" display="toText"/>] ;
        + [<memberdata name="tobin" display="toBin"/>] ;
        + [<memberdata name="get_macro_keystrokes" display="get_Macro_Keystrokes"/>] ;
        + [<memberdata name="get_keytext" display="get_KeyText"/>] ;
        + [</VFPData>]

*--
    Macro_Name                  = ''
    Macro_Length                = ''
    Keystroke                   = ''
    Macro_Keystrokes            = ''


    Procedure ReadNextMacro(tnHandle As Integer)
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tnHandle                  (!v IN    ) FKY file handle
*---------------------------------------------------------------------------------------------------
        Local lnMacro_Length

        Try
                With This As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG'
                    .Macro_Name         = Fread(tnHandle, 20)
                    .Macro_Length       = Fread(tnHandle, 2)
                    .Keystroke          = Fread(tnHandle, 2)
                    lnMacro_Length      = CToBin(.Macro_Length, '2RS')
                    .Macro_Keystrokes   = Fread(tnHandle, lnMacro_Length * 2)
                Endwith
        Endtry

        Return
    Endproc


    Procedure toBin As String
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------
        Local lcText

        With This As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG'

        Endwith

        Return lcText
    Endproc


    Procedure toText As String
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------
        Local lcText, loField As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG'
        lcText  = ''

        With This As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG'
            TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
             <<>><MACRO>
             <<Chr(9)>>Macro_Name      : <<ALLTRIM(.Macro_Name, 0, CHR(0), CHR(32))>>
             <<Chr(9)>>Keystroke       : <<.get_Macro_Keystrokes(.Keystroke, .T.)>>
             <<Chr(9)>>Macro_Keystrokes: <<.get_Macro_Keystrokes(.Macro_Keystrokes)>>
             <<>></MACRO>
            ENDTEXT

        Endwith

        Return lcText
    Endproc


    Function get_Macro_Keystrokes(tcMacroStr, tlLiteralForCaption)
*---------------------------------------------------------------------------------------------------
* DEVLUELVE LOS LITERALES DE TODAS LAS TECLAS
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------
        Local lcKeystrokes, I

        With This As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG'
            lcKeystrokes    = ''

            For I = 1 To Len(tcMacroStr) Step 2
                lcKeystrokes    = lcKeystrokes + .get_KeyText(@tcMacroStr, @I, tlLiteralForCaption)
            Endfor
        Endwith

        Return lcKeystrokes
    Endfunc


    Function get_KeyText(tcMacroStr As String, I As Integer, tlLiteralForCaption As Boolean) As String
*---------------------------------------------------------------------------------------------------
* DEVLUELVE EL LITERAL DE UNA TECLA
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcMacroStr                (!@ IN    ) Cadena de teclas de la macro
* I                         (!@ IN    ) Posición actualmente analizada de la cadena
* tlLiteralForCaption       (?v IN    ) Indica si algunos caracteres especiales se deben convertir a literal (ej: ";" => "SHIFT+SEMICOLON")
*---------------------------------------------------------------------------------------------------
        Local lcMod, lcKey, lcKeyName, lcKeyMod, lcTecla, lnKeyVal, lcKeyPair, lnCntMod ;
            , llComplementar, llKeyCodeShift, llKeyCodeCtrl, llKeyCodeAlt, lnMod, lnKey

        Store '' To lcTecla, lcKeyName, lcKeyMod, lcKey
        lcKeyPair   = Substr(tcMacroStr,I,2)
        lnKeyVal    = CToBin(lcKeyPair, '2RS')
        lcKey       = Left(lcKeyPair,1)
        lcMod       = Right(lcKeyPair,1)
        lnMod       = Asc(lcMod)
        lnKey       = Asc(lcKey)
        lnCntMod    = 0

* Tratamiento de modificadores
        If Not lcKeyPair == Chr(0xFE)+Chr(0xFF)
            If Bitand(lnMod, 0x80) = 0x80   && LITERAL
                lcKeyMod        = lcKeyMod + Iif(Empty(lcKeyMod),'','+') + 'LITERAL'
            Endif
            If Bitand(lnMod, 0x40) = 0x40   && ALT
*lcKeyMod       = lcKeyMod + IIF(EMPTY(lcKeyMod),'','+') + 'ALT'
                llKeyCodeAlt    = .T.
                lnCntMod        = lnCntMod + 1
            Endif
            If Bitand(lnMod, 0x20) = 0x20   && CTRL
*lcKeyMod       = lcKeyMod + IIF(EMPTY(lcKeyMod),'','+') + 'CTRL'
                llKeyCodeCtrl   = .T.
                lnCntMod        = lnCntMod + 1
            Endif
            If Bitand(lnMod, 0x10) = 0x10   && SHIFT
*lcKeyMod       = lcKeyMod + IIF(EMPTY(lcKeyMod),'','+') + 'SHIFT'
                llKeyCodeShift  = .T.
                lnCntMod        = lnCntMod + 1
            Endif
        Endif

        llComplementar  = llKeyCodeAlt Or llKeyCodeCtrl Or llKeyCodeShift
*llComplementar = llKeyCodeShift

* Tratamiento de teclas normales
* (Ordenar de mayor valor a menor: 0xFFF > 0x000)
        Do Case
            Case lcKeyPair == Chr(0xFE)+Chr(0xFF)
                lcKeyName   = 'PAUSE '
* Buscar el tiempo
                I   = I + 2
                lcKeyPair   = Substr(tcMacroStr,I,2)

                If lcKeyPair == Chr(0xFF)+Chr(0xFF)
                    lcKeyName   = lcKeyName + 'KEY'
                Else
                    lnKeyVal    = CToBin(lcKeyPair, '2RS')
                    lcKeyName   = lcKeyName + Ltrim(Str(lnKeyVal/100,5,2))
                Endif

            Case Bitand(lnMod, 0x01) = 0x01 ;
                    OR Bitand(lnMod, 0x10) = 0x10 ;
                    OR Bitand(lnMod, 0x20) = 0x20 ;
                    OR Bitand(lnMod, 0x40) = 0x40
*llComplementar = .F.

                Do Case
                    Case Bitand(lnKeyVal, 0x41A3) = 0x41A3
                        lcKeyName   = 'ALT+DEL'

                    Case Bitand(lnKeyVal, 0x41A2) = 0x41A2
                        lcKeyName   = 'ALT+INS'

                    Case Bitand(lnKeyVal, 0x41A1) = 0x41A1
                        lcKeyName   = 'ALT+PGND'

                    Case Bitand(lnKeyVal, 0x41A0) = 0x41A0
                        lcKeyName   = 'ALT+DNARROW'

                    Case Bitand(lnKeyVal, 0x419F) = 0x419F
                        lcKeyName   = 'ALT+END'

                    Case Bitand(lnKeyVal, 0x419D) = 0x419D
                        lcKeyName   = 'ALT+RIGHTARROW'

                    Case Bitand(lnKeyVal, 0x419B) = 0x419B
                        lcKeyName   = 'ALT+LEFTARROW'

                    Case Bitand(lnKeyVal, 0x4199) = 0x4199
                        lcKeyName   = 'ALT+PGUP'

                    Case Bitand(lnKeyVal, 0x4198) = 0x4198
                        lcKeyName   = 'ALT+UPARROW'

                    Case Bitand(lnKeyVal, 0x4197) = 0x4197
                        lcKeyName   = 'ALT+HOME'

                    Case Bitand(lnKeyVal, 0x418C) = 0x418C
                        lcKeyName   = 'ALT+F12'

                    Case Bitand(lnKeyVal, 0x418B) = 0x418B
                        lcKeyName   = 'ALT+F11'

                    Case Bitand(lnKeyVal, 0x4181) = 0x4181
                        lcKeyName   = 'ALT+0'

                    Case Bitand(lnKeyVal, 0x4180) = 0x4180
                        lcKeyName   = 'ALT+9'

                    Case Bitand(lnKeyVal, 0x417F) = 0x417F
                        lcKeyName   = 'ALT+8'

                    Case Bitand(lnKeyVal, 0x417E) = 0x417E
                        lcKeyName   = 'ALT+7'

                    Case Bitand(lnKeyVal, 0x417D) = 0x417D
                        lcKeyName   = 'ALT+6'

                    Case Bitand(lnKeyVal, 0x417C) = 0x417C
                        lcKeyName   = 'ALT+5'

                    Case Bitand(lnKeyVal, 0x417B) = 0x417B
                        lcKeyName   = 'ALT+4'

                    Case Bitand(lnKeyVal, 0x417A) = 0x417A
                        lcKeyName   = 'ALT+3'

                    Case Bitand(lnKeyVal, 0x4179) = 0x4179
                        lcKeyName   = 'ALT+2'

                    Case Bitand(lnKeyVal, 0x4178) = 0x4178
                        lcKeyName   = 'ALT+1'

                    Case Bitand(lnKeyVal, 0x4171) = 0x4171
                        lcKeyName   = 'ALT+F10'

                    Case Bitand(lnKeyVal, 0x4170) = 0x4170
                        lcKeyName   = 'ALT+F9'

                    Case Bitand(lnKeyVal, 0x416F) = 0x416F
                        lcKeyName   = 'ALT+F8'

                    Case Bitand(lnKeyVal, 0x416E) = 0x416E
                        lcKeyName   = 'ALT+F7'

                    Case Bitand(lnKeyVal, 0x416D) = 0x416D
                        lcKeyName   = 'ALT+F6'

                    Case Bitand(lnKeyVal, 0x416C) = 0x416C
                        lcKeyName   = 'ALT+F5'

                    Case Bitand(lnKeyVal, 0x416B) = 0x416B
                        lcKeyName   = 'ALT+F4'

                    Case Bitand(lnKeyVal, 0x416A) = 0x416A
                        lcKeyName   = 'ALT+F3'

                    Case Bitand(lnKeyVal, 0x4169) = 0x4169
                        lcKeyName   = 'ALT+F2'

                    Case Bitand(lnKeyVal, 0x4168) = 0x4168
                        lcKeyName   = 'ALT+F1'

                    Case Bitand(lnKeyVal, 0x4132) = 0x4132
                        lcKeyName   = 'ALT+M'

                    Case Bitand(lnKeyVal, 0x4131) = 0x4131
                        lcKeyName   = 'ALT+N'

                    Case Bitand(lnKeyVal, 0x4130) = 0x4130
                        lcKeyName   = 'ALT+B'

                    Case Bitand(lnKeyVal, 0x412F) = 0x412F
                        lcKeyName   = 'ALT+V'

                    Case Bitand(lnKeyVal, 0x412E) = 0x412E
                        lcKeyName   = 'ALT+C'

                    Case Bitand(lnKeyVal, 0x412D) = 0x412D
                        lcKeyName   = 'ALT+X'

                    Case Bitand(lnKeyVal, 0x412C) = 0x412C
                        lcKeyName   = 'ALT+Z'

                    Case Bitand(lnKeyVal, 0x4126) = 0x4126
                        lcKeyName   = 'ALT+L'

                    Case Bitand(lnKeyVal, 0x4125) = 0x4125
                        lcKeyName   = 'ALT+K'

                    Case Bitand(lnKeyVal, 0x4124) = 0x4124
                        lcKeyName   = 'ALT+J'

                    Case Bitand(lnKeyVal, 0x4123) = 0x4123
                        lcKeyName   = 'ALT+H'

                    Case Bitand(lnKeyVal, 0x4122) = 0x4122
                        lcKeyName   = 'ALT+G'

                    Case Bitand(lnKeyVal, 0x4121) = 0x4121
                        lcKeyName   = 'ALT+F'

                    Case Bitand(lnKeyVal, 0x4120) = 0x4120
                        lcKeyName   = 'ALT+D'

                    Case Bitand(lnKeyVal, 0x411F) = 0x411F
                        lcKeyName   = 'ALT+S'

                    Case Bitand(lnKeyVal, 0x411E) = 0x411E
                        lcKeyName   = 'ALT+A'

                    Case Bitand(lnKeyVal, 0x4119) = 0x4119
                        lcKeyName   = 'ALT+P'

                    Case Bitand(lnKeyVal, 0x4118) = 0x4118
                        lcKeyName   = 'ALT+O'

                    Case Bitand(lnKeyVal, 0x4117) = 0x4117
                        lcKeyName   = 'ALT+I'

                    Case Bitand(lnKeyVal, 0x4116) = 0x4116
                        lcKeyName   = 'ALT+U'

                    Case Bitand(lnKeyVal, 0x4115) = 0x4115
                        lcKeyName   = 'ALT+Y'

                    Case Bitand(lnKeyVal, 0x4114) = 0x4114
                        lcKeyName   = 'ALT+T'

                    Case Bitand(lnKeyVal, 0x4113) = 0x4113
                        lcKeyName   = 'ALT+R'

                    Case Bitand(lnKeyVal, 0x4112) = 0x4112
                        lcKeyName   = 'ALT+E'

                    Case Bitand(lnKeyVal, 0x4111) = 0x4111
                        lcKeyName   = 'ALT+U'

                    Case Bitand(lnKeyVal, 0x4110) = 0x4110
                        lcKeyName   = 'ALT+Q'

                    Case Bitand(lnKeyVal, 0x410C) = 0x410C
                        lcKeyName   = [ALT+']   && No está en la ayuda de VFP

                    Case Bitand(lnKeyVal, 0x2194) = 0x2194
                        lcKeyName   = 'CTRL+TAB'

                    Case Bitand(lnKeyVal, 0x2193) = 0x2193
                        lcKeyName   = 'CTRL+DEL'

                    Case Bitand(lnKeyVal, 0x2192) = 0x2192
                        lcKeyName   = 'CTRL+INS'

                    Case Bitand(lnKeyVal, 0x2191) = 0x2191
                        lcKeyName   = 'CTRL+DNARROW'

                    Case Bitand(lnKeyVal, 0x218D) = 0x218D
                        lcKeyName   = 'CTRL+UPARROW'

                    Case Bitand(lnKeyVal, 0x218A) = 0x218A
                        lcKeyName   = 'CTRL+F12'

                    Case Bitand(lnKeyVal, 0x2189) = 0x2189
                        lcKeyName   = 'CTRL+F11'

                    Case Bitand(lnKeyVal, 0x2184) = 0x2184
                        lcKeyName   = 'CTRL+PGUP'

                    Case Bitand(lnKeyVal, 0x2177) = 0x2177
                        lcKeyName   = 'CTRL+HOME'

                    Case Bitand(lnKeyVal, 0x2176) = 0x2176
                        lcKeyName   = 'CTRL+PGDN'

                    Case Bitand(lnKeyVal, 0x2175) = 0x2175
                        lcKeyName   = 'CTRL+END'

                    Case Bitand(lnKeyVal, 0x2174) = 0x2174
                        lcKeyName   = 'CTRL+RIGHTARROW'

                    Case Bitand(lnKeyVal, 0x2173) = 0x2173
                        lcKeyName   = 'CTRL+LEFTARROW'

                    Case Bitand(lnKeyVal, 0x2167) = 0x2167
                        lcKeyName   = 'CTRL+F10'

                    Case Bitand(lnKeyVal, 0x2166) = 0x2166
                        lcKeyName   = 'CTRL+F9'

                    Case Bitand(lnKeyVal, 0x2165) = 0x2165
                        lcKeyName   = 'CTRL+F8'

                    Case Bitand(lnKeyVal, 0x2164) = 0x2164
                        lcKeyName   = 'CTRL+F7'

                    Case Bitand(lnKeyVal, 0x2163) = 0x2163
                        lcKeyName   = 'CTRL+F6'

                    Case Bitand(lnKeyVal, 0x2162) = 0x2162
                        lcKeyName   = 'CTRL+F5'

                    Case Bitand(lnKeyVal, 0x2161) = 0x2161
                        lcKeyName   = 'CTRL+F4'

                    Case Bitand(lnKeyVal, 0x2160) = 0x2160
                        lcKeyName   = 'CTRL+F3'

                    Case Bitand(lnKeyVal, 0x215F) = 0x215F
                        lcKeyName   = 'CTRL+F2'

                    Case Bitand(lnKeyVal, 0x215E) = 0x215E
                        lcKeyName   = 'CTRL+F1'

                    Case Bitand(lnKeyVal, 0x2020) = 0x2020
                        lcKeyName   = 'CTRL+SPACEBAR'

                    Case Bitand(lnKeyVal, 0x201F) = 0x201F
                        lcKeyName   = 'CTRL+HYPHEN'

                    Case Bitand(lnKeyVal, 0x201E) = 0x201E
                        lcKeyName   = 'CTRL+CARET'

                    Case Bitand(lnKeyVal, 0x201D) = 0x201D
                        lcKeyName   = 'CTRL+RBRACKET'

                    Case Bitand(lnKeyVal, 0x201C) = 0x201C
                        lcKeyName   = 'CTRL+BACKSLASH'

                    Case Bitand(lnKeyVal, 0x201B) = 0x201B
                        lcKeyName   = 'CTRL+LBRACKET'

                    Case Bitand(lnKeyVal, 0x201A) = 0x201A
                        lcKeyName   = 'CTRL+Z'

                    Case Bitand(lnKeyVal, 0x2019) = 0x2019
                        lcKeyName   = 'CTRL+Y'

                    Case Bitand(lnKeyVal, 0x2018) = 0x2018
                        lcKeyName   = 'CTRL+X'

                    Case Bitand(lnKeyVal, 0x2017) = 0x2017
                        lcKeyName   = 'CTRL+W'

                    Case Bitand(lnKeyVal, 0x2016) = 0x2016
                        lcKeyName   = 'CTRL+V'

                    Case Bitand(lnKeyVal, 0x2015) = 0x2015
                        lcKeyName   = 'CTRL+U'

                    Case Bitand(lnKeyVal, 0x2014) = 0x2014
                        lcKeyName   = 'CTRL+T'

                    Case Bitand(lnKeyVal, 0x2013) = 0x2013
                        lcKeyName   = 'CTRL+S'

                    Case Bitand(lnKeyVal, 0x2012) = 0x2012
                        lcKeyName   = 'CTRL+R'

                    Case Bitand(lnKeyVal, 0x2011) = 0x2011
                        lcKeyName   = 'CTRL+Q'

                    Case Bitand(lnKeyVal, 0x2010) = 0x2010
                        lcKeyName   = 'CTRL+P'

                    Case Bitand(lnKeyVal, 0x200F) = 0x200F
                        lcKeyName   = 'CTRL+O'

                    Case Bitand(lnKeyVal, 0x200E) = 0x200E
                        lcKeyName   = 'CTRL+N'

                    Case Bitand(lnKeyVal, 0x200D) = 0x200D
                        lcKeyName   = 'CTRL+M'

                    Case Bitand(lnKeyVal, 0x200C) = 0x200C
                        lcKeyName   = 'CTRL+L'

                    Case Bitand(lnKeyVal, 0x200B) = 0x200B
                        lcKeyName   = 'CTRL+K'

                    Case Bitand(lnKeyVal, 0x200A) = 0x200A
                        lcKeyName   = 'CTRL+ENTER'

                    Case Bitand(lnKeyVal, 0x200A) = 0x200A
                        lcKeyName   = 'CTRL+J'

                    Case Bitand(lnKeyVal, 0x2009) = 0x2009
                        lcKeyName   = 'CTRL+I'

                    Case Bitand(lnKeyVal, 0x2008) = 0x2008
                        lcKeyName   = 'CTRL+H'

                    Case Bitand(lnKeyVal, 0x2007) = 0x2007
                        lcKeyName   = 'CTRL+G'

                    Case Bitand(lnKeyVal, 0x2006) = 0x2006
                        lcKeyName   = 'CTRL+F'

                    Case Bitand(lnKeyVal, 0x2005) = 0x2005
                        lcKeyName   = 'CTRL+E'

                    Case Bitand(lnKeyVal, 0x2004) = 0x2004
                        lcKeyName   = 'CTRL+D'

                    Case Bitand(lnKeyVal, 0x2003) = 0x2003
                        lcKeyName   = 'CTRL+C'

                    Case Bitand(lnKeyVal, 0x2002) = 0x2002
                        lcKeyName   = 'CTRL+B'

                    Case Bitand(lnKeyVal, 0x2001) = 0x2001
                        lcKeyName   = 'CTRL+A'

                    Case Bitand(lnKeyVal, 0x1188) = 0x1188
                        lcKeyName   = 'SHIFT+F12'

                    Case Bitand(lnKeyVal, 0x1187) = 0x1187
                        lcKeyName   = 'SHIFT+F11'

                    Case Bitand(lnKeyVal, 0x115D) = 0x115D
                        lcKeyName   = 'SHIFT+F10'

                    Case Bitand(lnKeyVal, 0x115C) = 0x115C
                        lcKeyName   = 'SHIFT+F9'

                    Case Bitand(lnKeyVal, 0x115B) = 0x115B
                        lcKeyName   = 'SHIFT+F8'

                    Case Bitand(lnKeyVal, 0x115A) = 0x115A
                        lcKeyName   = 'SHIFT+F7'

                    Case Bitand(lnKeyVal, 0x1159) = 0x1159
                        lcKeyName   = 'SHIFT+F6'

                    Case Bitand(lnKeyVal, 0x1158) = 0x1158
                        lcKeyName   = 'SHIFT+F5'

                    Case Bitand(lnKeyVal, 0x1157) = 0x1157
                        lcKeyName   = 'SHIFT+F4'

                    Case Bitand(lnKeyVal, 0x1156) = 0x1156
                        lcKeyName   = 'SHIFT+F3'

                    Case Bitand(lnKeyVal, 0x1155) = 0x1155
                        lcKeyName   = 'SHIFT+F2'

                    Case Bitand(lnKeyVal, 0x1154) = 0x1154
                        lcKeyName   = 'SHIFT+F1'

                    Case Bitand(lnKeyVal, 0x0186) = 0x0186
                        lcKeyName   = 'F12'

                    Case Bitand(lnKeyVal, 0x0185) = 0x0185
                        lcKeyName   = 'F11'

                    Case Inlist(lnKeyVal, 0x0153, 0x1153)
                        lcKeyName   = 'DEL'

                    Case Inlist(lnKeyVal, 0x0152, 0x1152)
                        lcKeyName   = 'INS'

                    Case Inlist(lnKeyVal, 0x0151, 0x1151)
                        lcKeyName   = 'PGDN'

                    Case Inlist(lnKeyVal, 0x0150, 0x1150)
                        lcKeyName   = 'DNARROW'

                    Case Inlist(lnKeyVal, 0x014F, 0x114F)
                        lcKeyName   = 'END'

                    Case Inlist(lnKeyVal, 0x014D, 0x114D)
                        lcKeyName   = 'RIGHTARROW'

                    Case Inlist(lnKeyVal, 0x014B, 0x114B)
                        lcKeyName   = 'LEFTARROW'

                    Case Inlist(lnKeyVal, 0x0149, 0x1149)
                        lcKeyName   = 'PGUP'

                    Case Inlist(lnKeyVal, 0x0148, 0x1148)
                        lcKeyName   = 'UPARROW'

                    Case Bitand(lnKeyVal, 0x0147) = 0x0147
                        lcKeyName   = 'HOME'

                    Case lnKeyVal = 0x0144
                        lcKeyName   = 'F10'

                    Case lnKeyVal = 0x0143
                        lcKeyName   = 'F9'

                    Case lnKeyVal = 0x0142
                        lcKeyName   = 'F8'

                    Case lnKeyVal = 0x0141
                        lcKeyName   = 'F7'

                    Case lnKeyVal = 0x0140
                        lcKeyName   = 'F6'

                    Case lnKeyVal = 0x013F
                        lcKeyName   = 'F5'

                    Case lnKeyVal = 0x013E
                        lcKeyName   = 'F4'

                    Case lnKeyVal = 0x013D
                        lcKeyName   = 'F3'

                    Case lnKeyVal = 0x013C
                        lcKeyName   = 'F2'

                    Case lnKeyVal = 0x013B
                        lcKeyName   = 'F1'

                    Case lnKeyVal = 0x010F
                        lcKeyName   = 'BACKTAB'

                    Case lnKeyVal = 0x0100
                        lcKeyName   = 'LEFTMOUSE'

                    Otherwise
*lcKeyName  = CHR(lnKeyVal)

                Endcase

        Endcase

        If Empty(lcKeyName)

            Do Case
                Case Between(lnKey, 0x41, 0x5A) Or Between(lnKey, 0x61, 0x7A) Or Inlist(lnKey, 0x7C, 0x7E)  && A..Z, a..z, |, ~
                    lcKeyName   = lcKey
                    llKeyCodeShift  = .F.

                Case Between(lnKey, 0x21, 0x7A) And Not (lnKey = 0x3B)
                    llKeyCodeShift  = .F.
                    lcKeyName   = lcKey

                Case lnKey = 0x7F
                    lcKeyName   = 'DEL'

                Case lnKey = 0x7D   && "{"
                    lcKeyName   = 'RBRACE'

                Case lnKey = 0x7B   && "}"
                    lcKeyName   = 'LBRACE'

                Case lnKey = 0x3B   && ";"
                    lcKeyName   = 'SEMICOLON'

                Case lnKey = 0x2C   && ","
                    lcKeyName   = 'SEMICOLON'

                Case lnKey = 0x20   && " "
                    lcKeyName   = 'SPACEBAR'

                Case lnKey = 0x1B
                    lcKeyName   = 'ESCAPE'

                Case lnKey = 0x0D
                    lcKeyName   = 'ENTER'

                Case lnKey = 0x09
                    lcKeyName   = 'TAB'

                Case lnKey = 0x08
                    lcKeyName   = 'BACKSPACE'

                Otherwise
                    llComplementar  = .F.
                    lcKeyName   = 'x' + Right( Transform(lnKeyVal,'@0'), 4)

            Endcase

*ENDCASE
        Endif

* Tratamiento de modificadores
        If Not lcKeyPair == Chr(0xFE)+Chr(0xFF) And llComplementar
            If llKeyCodeShift And At("SHIFT",lcKeyName) = 0 && SHIFT
                lcKeyMod        = lcKeyMod + Iif(Empty(lcKeyMod),'','+') + 'SHIFT'
            Endif
            If llKeyCodeCtrl And At("CTRL",lcKeyName) = 0   && CTRL
                lcKeyMod        = lcKeyMod + Iif(Empty(lcKeyMod),'','+') + 'CTRL'
            Endif
            If llKeyCodeAlt And At("ALT",lcKeyName) = 0 && ALT
                lcKeyMod        = lcKeyMod + Iif(Empty(lcKeyMod),'','+') + 'ALT'
            Endif
*IF BITAND(lnKeyVal, 0x8000) = 0x8000   && LITERAL
*   lcKeyMod        = lcKeyMod + IIF(EMPTY(lcKeyMod),'','+') + 'LITERAL'
*ENDIF
        Endif

* Tratamiento de combinación final
        Do Case
            Case Len(lcKeyName) > 1 And (Not llComplementar Or Empty(lcKeyMod))
                If tlLiteralForCaption
                    lcTecla = lcKeyName
                Else
                    lcTecla = '{' + lcKeyName + '}'
                Endif

            Case Empty(lcKeyMod)
                lcTecla = lcKeyName

            Otherwise
                If tlLiteralForCaption
                    lcTecla = lcKeyMod + '+' + lcKeyName
                Else
                    lcTecla = '{' + lcKeyMod + '+' + lcKeyName + '}'
                Endif

        Endcase

        Return lcTecla
    Endfunc


Enddefine



Define Class CL_MEMVAR As CL_COL_BASE
*   .MEM FILE STRUCTURE (Based on observation and testing) - Fernando D. Bozzo. 2018/03/24
*   Complementary documentation: https://www.clicketyclick.dk/databases/xbase/format/mem.html#MEM_STRUCT


*   STRUCTURE OF VARIABLES
*   Byte Offset Description
*   ----------- -------------------------------------------------------------------------------------------------
*   0 - 10      .Null. terminated VarName. If VarName is empty, then VarName starts at offset 32
*   11          VarType (A,C,N,Y,B,F,I,Q,D,T,L,0). If VarType is lowercase, then next VarName
*               begins with 2 bytes for VarName length.
*   12 - 15     Reserved
*   16          Value length
*   17          Decimal count
*   18 - 24     Reserved
*   25          0x00 if it is an array element, 0x03 if it isn't an array element
*   26 - 31     Reserved
*   32 - n      If VarName (offset 0-10) is .Null. then goto TABLE 1, If VarType=A then continue in TABLE 2,
*               if VarType=0 then continue in TABLE 3, else continue in TABLE 4
*   ...
*   eof         Last character is EOF (0x1A) character
*   ----------- -------------------------------------------------------------------------------------------------


*   TABLE 1 - ARRAY STRUCTURE (VarType=A)
*   Byte Offset Description
*   ----------- -------------------------------------------------------------------------------------------------
*   32 - 33     VarName length
*   34 - n      VarName
*   n  + 1      Next TABLE: If VarType=A then continue in TABLE 2, if VarType=0 then continue in TABLE 3,
*               else continue in TABLE 4
*   ----------- -------------------------------------------------------------------------------------------------


*   TABLE 2 - ARRAY STRUCTURE (VarType=A)
*   Byte Offset Description
*   ----------- -------------------------------------------------------------------------------------------------
*   n   - n+1   Array rows
*   n+2 - n+3   Array cols
*   n+4 - x     Next Variable structure, or EOF (0x1A)
*   ----------- -------------------------------------------------------------------------------------------------


*   TABLE 3 - .Null. VALUE STRUCTURE (VarType=0)
*   Byte Offset Description
*   ----------- -------------------------------------------------------------------------------------------------
*   n           VarType.
*   n+1 - x     Next Variable structure, or EOF (0x1A)
*   ----------- -------------------------------------------------------------------------------------------------


*   TABLE 4 - NORMAL VALUE STRUCTURE
*   Byte Offset Description
*   ----------- -------------------------------------------------------------------------------------------------
*   n - x       Value of length "value length". If ValTye is a Char type then Value length is the value's width,
*               else the width is 8 for numbers and dates
*   x           Next Variable structure, or EOF (0x1A)
*   ----------- -------------------------------------------------------------------------------------------------

    #If .F.
        Local This As CL_MEMVAR Of 'FOXBIN2PRG.PRG'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="c_inputfile" display="c_InputFile"/>] ;
        + [<memberdata name="_debug" display="_Debug"/>] ;
        + [<memberdata name="get_datafrommem" display="get_DataFromMEM"/>] ;
        + [<memberdata name="_memvars" display="_MemVars"/>] ;
        + [</VFPData>]


    c_InputFile         = ''
    _Debug              = .F.
    _MemVars            = .Null.        && Colección de variables de memoria



    Procedure Init
        DoDefault()
        This._MemVars = Createobject("COLLECTION")
    Endproc


    Procedure get_DataFromMEM(tcInputFile As String, toFoxBin2Prg)
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcInputFile               (!v IN    ) Archivo de entrada
* toFoxBin2Prg              (!@ IN    ) Referencia al objeto principal
*---------------------------------------------------------------------------------------------------
        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
        #Endif

        Local lnHandle, lnFileLen, lcMsg, lcStr, lnNumberOfMacros ;
            , loMVRec As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG' ;
            , loColl As Collection ;
            , loEx As Exception

        Try
                lnHandle    = -1

                With This As CL_MEMVAR Of 'FOXBIN2PRG.PRG'
                    loColl      = ._MemVars
                    lnHandle    = Fopen(tcInputFile, 0)

                    If lnHandle = -1
                        lcMsg   = toFoxBin2Prg.FERROR_Message(tcInputFile)
                        Error (lcMsg)
                    Endif

                    lnFileLen   = Fseek(lnHandle, 0, 2)

                    If lnFileLen < 1
                        Error 'Invalid MEM File size'
                    Else
                        =Fseek(lnHandle, 0, 0)
                    Endif

*IF lnFileLen < 17 + 25 * lnNumberOfMacros
*   * 25 caracteres es el tamaño mínimo de una macro sin teclas guardadas (solo la estructura)
*   ERROR 'Invalid FKY Macro File size'
*ENDIF

                    If lnFileLen > 1
                        Do While Not Feof(lnHandle) And Fseek(lnHandle, 0, 1) < (lnFileLen - 1)
                            loMVRec = Createobject("CL_MEMVAR_RECORD")

                            If Not loMVRec.ReadNextMemVar(lnHandle)
                                Exit
                            Endif

                            loColl.Add( loMVRec, loMVRec.getName() + Padl(pnElement, 5, '0') )
                            loMVRec = .Null.
                        Enddo

* Ordenar alfabéticamente por nombre de variable
                        loColl.KeySort = 2
                    Endif

                Endwith

            Catch To loEx
*loEx.UserValue = loEx.UserValue + 'lcAsignacion = [' + TRANSFORM(lcAsignacion) + ']' + CR_LF

                If This.n_Debug > 0 And _vfp.StartMode = 0
                    Set Step On
                Endif

                Throw

            Finally
                If lnHandle <> -1
                    =Fclose(lnHandle)
                Endif
        Endtry

        Return
    Endproc


    Procedure toText
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------
        Local lcText, loMVRec As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
        lcText  = ''

        With This As CL_MEMVAR Of 'FOXBIN2PRG.PRG'

*-- Macros
            For Each loMVRec In ._MemVars &&FOXOBJECT
                lcText  = lcText + CR_LF + loMVRec.toText()
            Endfor

        Endwith

        Return lcText
    Endproc


Enddefine



Define Class CL_MEMVAR_RECORD As CL_CUS_BASE OF 'cl_cus_base.prg'
    _MemberData = [<VFPData>] ;
        + [<memberdata name="memvar_name" display="MemVar_Name"/>] ;
        + [<memberdata name="memvar_namelength" display="MemVar_NameLength"/>] ;
        + [<memberdata name="memvar_type" display="MemVar_Type"/>] ;
        + [<memberdata name="memvar_rows" display="MemVar_Rows"/>] ;
        + [<memberdata name="memvar_cols" display="MemVar_Cols"/>] ;
        + [<memberdata name="memvar_length" display="MemVar_Length"/>] ;
        + [<memberdata name="memvar_dec" display="MemVar_Dec"/>] ;
        + [<memberdata name="memvar_value" display="MemVar_Value"/>] ;
        + [<memberdata name="memvar_elemtype" display="MemVar_ElemType"/>] ;
        + [<memberdata name="readnextmemvar" display="ReadNextMemVar"/>] ;
        + [<memberdata name="totext" display="toText"/>] ;
        + [<memberdata name="get_memvardata" display="get_MemVarData"/>] ;
        + [<memberdata name="getrows" display="getRows"/>] ;
        + [<memberdata name="getcols" display="getCols"/>] ;
        + [<memberdata name="getlength" display="getLength"/>] ;
        + [<memberdata name="getdec" display="getDec"/>] ;
        + [<memberdata name="getvalue" display="getValue"/>] ;
        + [<memberdata name="getname" display="getName"/>] ;
        + [<memberdata name="juliantodatetime" display="julianToDateTime"/>] ;
        + [<memberdata name="isarrayelement" display="isArrayElement"/>] ;
        + [</VFPData>]

*--
    MemVar_Name                 = ''
    MemVar_NameLength           = ''
    MemVar_Type                 = ''
    MemVar_Rows                 = ''
    MemVar_Cols                 = ''
    MemVar_Length               = ''
    MemVar_Dec                  = ''
    MemVar_Value                = ''
    MemVar_ElemType             = ''


    Procedure ReadNextMemVar(tnHandle As Integer)
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tnHandle                  (!v IN    ) FKY file handle
*---------------------------------------------------------------------------------------------------
        Local lnVarLength, lnVarDec, lnVarNameLength, lcVarNameLength, llVarTypeIsChar

        Try
                With This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
                    .MemVar_Name        = Fread(tnHandle, 11)
                    .MemVar_Type        = Fread(tnHandle, 1)
                    =Fseek(tnHandle, 4, 1)  && Skip 4 bytes
                    .MemVar_Length      = Fread(tnHandle, 1)
                    .MemVar_Dec         = Fread(tnHandle, 1)

                    Do Case
                        Case Inlist( Upper(.MemVar_Type), 'C', 'Q', 'L')
                            llVarTypeIsChar     = .T.
                            lnVarLength         = .getLength()

                        Case Upper(.MemVar_Type) = 'A'
* Array

                        Otherwise && Numeric
                            lnVarLength         = 8
                            lnVarDec            = .getDec()

                    Endcase

                    =Fseek(tnHandle, 7, 1)  && Skip 7 bytes
                    .MemVar_ElemType    = Fread(tnHandle, 1)    && 0x00 if it is an array element, else 0x03
                    =Fseek(tnHandle, 6, 1)  && Skip 6 bytes

                    If .isArrayElement()
* Mantiene el contador de elemento
                        pnElement   = pnElement + 1
                    Else
* Reinicia el conteo de filas, columnas y elemento actual
                        Store 0 To pnCols, pnRows, pnElement
                    Endif

                    If Empty( Rtrim(.MemVar_Name, 0, Chr(0)) )
* Long VarName
                        lcVarNameLength = Fread(tnHandle, 2)
                        lnVarNameLength = CToBin(lcVarNameLength, '2RS')
                        .MemVar_Name    = Fread(tnHandle, lnVarNameLength)
                    Endif

                    Do Case
                        Case Inlist(.MemVar_Type, 'A', 'a')
* ARRAY
* Rows/Cols
                            .MemVar_Rows        = Fread(tnHandle, 2)
                            .MemVar_Cols        = Fread(tnHandle, 2)
                            pnCols              = .getCols()
                            pnRows              = .getRows()

                        Case .MemVar_Type = '0'
* .Null.
* VarType
                            .MemVar_Type    = Fread(tnHandle, 1)
                            .MemVar_Value   = .Null.

                        Otherwise
* NORMAL VALUE
* Value
                            .MemVar_Value   = Fread(tnHandle, lnVarLength)

                    Endcase
                Endwith
        Endtry

        Return
    Endproc


    Function isArrayElement
        #If .F.
            Local This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
        #Endif
        Return Asc(This.MemVar_ElemType) = 0
    Endfunc


    Function getRows
        #If .F.
            Local This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
        #Endif
        Return CToBin(This.MemVar_Rows, '2RS')
    Endfunc


    Function getCols
        #If .F.
            Local This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
        #Endif
        Return CToBin(This.MemVar_Cols, '2RS')
    Endfunc


    Function getLength
        #If .F.
            Local This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
        #Endif
        Return Asc(This.MemVar_Length)
    Endfunc


    Function getDec
        #If .F.
            Local This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
        #Endif
        Return Asc(This.MemVar_Dec)
    Endfunc


    Function getName
        #If .F.
            Local This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
        #Endif
        Return Rtrim(This.MemVar_Name, 0, Chr(0))
    Endfunc


    Function getValue
        With This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
            Local lxValue

            Do Case
                Case Isnull(.MemVar_Value)
                    lxValue = .Null.

                Case Upper(.MemVar_Type) = 'L'
                    lxValue = ( Asc(.MemVar_Value) = 1 )

                Case Inlist( Upper(.MemVar_Type), 'C', 'M')
                    lxValue = ["] + Rtrim(.MemVar_Value, 0, Chr(0)) + ["]

                Case Inlist( Upper(.MemVar_Type), 'Q')
                    lxValue = '0h' + Strconv(.MemVar_Value,15)

                Case Upper(.MemVar_Type) = 'D'
                    lxValue = Sys(10, CToBin(.MemVar_Value, '8S'))

                Case Upper(.MemVar_Type) = 'T'
                    lxValue =.julianToDateTime( CToBin(.MemVar_Value, '8S') )

                Case Upper(.MemVar_Type) = 'Y'
                    lxValue = CToBin(.MemVar_Value, '8YRS')

                Case Upper(.MemVar_Type) = 'B'
                    lxValue = CToBin(.MemVar_Value, '8BRS')

                Otherwise && 'N'
                    lxValue = CToBin(.MemVar_Value, '8S')

*IF .getDec() = 0
*   lxValue = ROUND(lxValue,0)
*ENDIF

            Endcase
        Endwith

        Return lxValue
    Endfunc


    Function julianToDateTime(tnJulian As Double)
        Local lnInt, lnDec, ltValue, ldDate, lcTime ;
            , lnSecs, lnMins, lnHours

        ltValue = {/:}
        lnInt   = Int(tnJulian)
        lnDec   = tnJulian - lnInt
        ldDate  = Evaluate( '{^' + Sys(10, lnInt) + '}' )
        lnSecs  = 24 * 60 * 60 * lnDec
        lnHours = Int(lnSecs / 3600)
        lnSecs  = lnSecs - lnHours * 3600
        lnMins  = Int(lnSecs / 60)
        lnSecs  = lnSecs - lnMins * 60
        ltValue = Datetime( Year(ldDate), Month(ldDate), Day(ldDate), lnHours, lnMins, lnSecs)

        Return ltValue
    Endfunc


    Procedure toText As String
*---------------------------------------------------------------------------------------------------
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
*---------------------------------------------------------------------------------------------------
        Local lcText, lcVarName, lcVarType, lnVarLen, lnVarDec, lcPrecision, lnLenName ;
            , loField As CL_MACRO_RECORD Of 'FOXBIN2PRG.PRG'
        lnLenName   = 16
        lcText      = ''
        lcPrecision = ''
        lcVarName   = ''

        With This As CL_MEMVAR_RECORD Of 'FOXBIN2PRG.PRG'
            lcVarType   = Upper(.MemVar_Type)
            lnVarLen    = .getLength()
            lnVarDec    = .getDec()
            lcVarName   = .getName()

            If Len(lcVarName) < lnLenName
                lcVarName   = Padr(lcVarName, lnLenName)
            Endif

            If lcVarType = 'N'
                If lnVarDec > 0
                    lcPrecision = Textmerge( '(<<lnVarLen>>,<<lnVarDec>>)' )
                Else
                    lcPrecision = Textmerge( '(<<lnVarLen>>)' )
                Endif
            Endif

            lcPrecision = Padr(lcPrecision, 10)

            If lcVarType = 'A'
                pnCols      = .getCols()
                pnRows      = .getRows()
                pnElement   = 0

                If CToBin(.MemVar_Cols, '2RS') = 0
* Array Unidimensional
                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<lcVarName>>   <<lcVarType>>(<<.getRows()>>)
                    ENDTEXT
                Else
* Array Bidimensional
                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<lcVarName>>   <<lcVarType>>(<<.getRows()>>,<<.getCols()>>)
                    ENDTEXT
                Endif

            Else

                If .isArrayElement()
* Elemento de array
                    pnElement   = pnElement + 1

                    If pnCols = 0
* Elemento de Array Unidimensional
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                            <<>>         (<<Str(pnElement,5)>>)   <<lcVarType>><<lcPrecision>>   <<.getValue()>>
                        ENDTEXT

                    Else
* Elemento de Array Bidimensional
                        TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                            <<>>   (<<Str(CEILING(pnElement/pnCols),5)>>,<<Str(EVL( MOD(pnElement,pnCols), pnCols),5)>>)   <<lcVarType>><<lcPrecision>>   <<.getValue()>>
                        ENDTEXT

                    Endif

                Else
* Variable normal
                    TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<lcVarName>>   <<lcVarType>><<lcPrecision>>   <<.getValue()>>
                    ENDTEXT
                Endif

            Endif

        Endwith

        Return lcText
    Endproc


Enddefine