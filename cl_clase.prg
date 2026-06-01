Define Class CL_CLASE As CL_CUS_BASE OF 'cl_cus_base.prg'
    #If .F.
        Local This As CL_CLASE Of 'cl_clase.prg'
    #Endif

    _MemberData = [<VFPData>] ;
        + [<memberdata name="add_pathobjname" display="add_PathObjName"/>] ;
        + [<memberdata name="add_procedure" display="add_Procedure"/>] ;
        + [<memberdata name="add_property" display="add_Property"/>] ;
        + [<memberdata name="add_object" display="add_Object"/>] ;
        + [<memberdata name="c_texterr" display="c_TextErr"/>] ;
        + [<memberdata name="l_objectmetadatainheader" display="l_ObjectMetadataInHeader"/>] ;
        + [<memberdata name="_addobject_count" display="_AddObject_Count"/>] ;
        + [<memberdata name="_addobjects" display="_AddObjects"/>] ;
        + [<memberdata name="_apathobjname_count" display="_aPathObjName_Count"/>] ;
        + [<memberdata name="_apathobjnames" display="_aPathObjNames"/>] ;
        + [<memberdata name="_aprocnames" display="_aProcNames"/>] ;
        + [<memberdata name="_baseclass" display="_BaseClass"/>] ;
        + [<memberdata name="_checked" display="_Checked"/>] ;
        + [<memberdata name="_class" display="_Class"/>] ;
        + [<memberdata name="_classicon" display="_ClassIcon"/>] ;
        + [<memberdata name="_classloc" display="_ClassLoc"/>] ;
        + [<memberdata name="_comentario" display="_Comentario"/>] ;
        + [<memberdata name="_defined_pam" display="_Defined_PAM"/>] ;
        + [<memberdata name="_definicion" display="_Definicion"/>] ;
        + [<memberdata name="_fin" display="_Fin"/>] ;
        + [<memberdata name="_fin_cab" display="_Fin_Cab"/>] ;
        + [<memberdata name="_fin_cuerpo" display="_Fin_Cuerpo"/>] ;
        + [<memberdata name="_hiddenmethods" display="_HiddenMethods"/>] ;
        + [<memberdata name="_hiddenprops" display="_HiddenProps"/>] ;
        + [<memberdata name="_includefile" display="_IncludeFile"/>] ;
        + [<memberdata name="_inicio" display="_Inicio"/>] ;
        + [<memberdata name="_ini_cab" display="_Ini_Cab"/>] ;
        + [<memberdata name="_ini_cuerpo" display="_Ini_Cuerpo"/>] ;
        + [<memberdata name="_metadata" display="_MetaData"/>] ;
        + [<memberdata name="_nombre" display="_Nombre"/>] ;
        + [<memberdata name="_objname" display="_ObjName"/>] ;
        + [<memberdata name="_ole" display="_Ole"/>] ;
        + [<memberdata name="_ole2" display="_Ole2"/>] ;
        + [<memberdata name="_olepublic" display="_OlePublic"/>] ;
        + [<memberdata name="_parent" display="_Parent"/>] ;
        + [<memberdata name="_procedures" display="_Procedures"/>] ;
        + [<memberdata name="_procedure_count" display="_Procedure_Count"/>] ;
        + [<memberdata name="_projectclassicon" display="_ProjectClassIcon"/>] ;
        + [<memberdata name="_protectedmethods" display="_ProtectedMethods"/>] ;
        + [<memberdata name="_protectedprops" display="_ProtectedProps"/>] ;
        + [<memberdata name="_props" display="_Props"/>] ;
        + [<memberdata name="_prop_count" display="_Prop_Count"/>] ;
        + [<memberdata name="_scale" display="_Scale"/>] ;
        + [<memberdata name="_timestamp" display="_TimeStamp"/>] ;
        + [<memberdata name="_uniqueid" display="_UniqueID"/>] ;
        + [<memberdata name="_properties" display="_PROPERTIES"/>] ;
        + [<memberdata name="_protected" display="_PROTECTED"/>] ;
        + [<memberdata name="_methods" display="_METHODS"/>] ;
        + [<memberdata name="_reserved1" display="_RESERVED1"/>] ;
        + [<memberdata name="_reserved2" display="_RESERVED2"/>] ;
        + [<memberdata name="_reserved3" display="_RESERVED3"/>] ;
        + [<memberdata name="_reserved4" display="_RESERVED4"/>] ;
        + [<memberdata name="_reserved5" display="_RESERVED5"/>] ;
        + [<memberdata name="_reserved6" display="_RESERVED6"/>] ;
        + [<memberdata name="_reserved7" display="_RESERVED7"/>] ;
        + [<memberdata name="_reserved8" display="_RESERVED8"/>] ;
        + [<memberdata name="_user" display="_USER"/>] ;
        + [</VFPData>]


    Dimension _Props[1,2], _AddObjects[1], _Procedures[1], _aProcNames[1], _aPathObjNames[1,2]
    l_ObjectMetadataInHeader    = .F.
    c_TextErr                   = ''
    _Nombre                     = ''
    _ObjName                    = ''
    _Parent                     = ''
    _Checked                    = .F.   && Solo para Clases Externas: Permite saber si la clase fue checkeada contra la Clase Externa.
    _Definicion                 = ''
    _Class                      = ''
    _ClassLoc                   = ''
    _OlePublic                  = ''
    _Ole                        = ''
    _Ole2                       = ''
    _UniqueID                   = ''
    _Comentario                 = ''
    _ClassIcon                  = ''
    _ProjectClassIcon           = ''
    _Inicio                     = 0
    _Fin                        = 0
    _Ini_Cab                    = 0
    _Fin_Cab                    = 0
    _Ini_Cuerpo                 = 0
    _Fin_Cuerpo                 = 0
    _Prop_Count                 = 0
    _HiddenProps                = ''
    _ProtectedProps             = ''
    _HiddenMethods              = ''
    _ProtectedMethods           = ''
    _MetaData                   = ''
    _BaseClass                  = ''
    _TimeStamp                  = 0
    _Scale                      = ''
    _Defined_PAM                = ''
    _includeFile                = ''
    _AddObject_Count            = 0
    _aPathObjName_Count         = 0
    _Procedure_Count            = 0
    _PROPERTIES                 = ''
    _PROTECTED                  = ''
    _METHODS                    = ''
    _RESERVED1                  = ''
    _RESERVED2                  = ''
    _RESERVED3                  = ''
    _RESERVED4                  = ''
    _RESERVED5                  = ''
    _RESERVED6                  = ''
    _RESERVED7                  = ''
    _RESERVED8                  = ''
    _User                       = ''


    Procedure add_PathObjName
        Lparameters tcPathObjName, I

        With This As CL_CLASE Of 'cl_clase.prg'
            ._aPathObjName_Count    = ._aPathObjName_Count + 1
            Dimension ._aPathObjNames(._aPathObjName_Count,2)
            ._aPathObjNames(._aPathObjName_Count,1) = tcPathObjName
            ._aPathObjNames(._aPathObjName_Count,2) = m.I
        Endwith

        Return
    Endproc


    Procedure add_Procedure
        Lparameters toProcedure

        #If .F.
            Local toProcedure As CL_PROCEDURE Of 'FOXBIN2PRG.PRG'
        #Endif

        With This As CL_CLASE Of 'cl_clase.prg'
*-- Verificación de Procedure repetido
            If ._Procedure_Count > 0 And Ascan( ._aProcNames, toProcedure._Nombre, 1, 0, 0, 1+2+4 ) > 0 Then
                .writeErrorLog( '* Duplicated Method "' + toProcedure._Nombre + '" of class "' ;
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
        Lparameters tcProperty As String, tcValue As String, tcComment As String

        With This As CL_CLASE Of 'cl_clase.prg'
            ._Prop_Count    = ._Prop_Count + 1
            Dimension ._Props( ._Prop_Count, 3 )
            ._Props( ._Prop_Count, 1 )  = tcProperty
            ._Props( ._Prop_Count, 2 )  = tcValue
            ._Props( ._Prop_Count, 3 )  = tcComment
        Endwith && THIS
    Endproc


    Procedure add_Object
        Lparameters toObjeto

        #If .F.
            Local toObjeto As CL_OBJETO Of 'FOXBIN2PRG.PRG'
        #Endif

        With This As CL_CLASE Of 'cl_clase.prg'
            ._AddObject_Count   = ._AddObject_Count + 1
            Dimension ._AddObjects( ._AddObject_Count )
            ._AddObjects( ._AddObject_Count )   = toObjeto
        Endwith && THIS
    Endproc


Enddefine
