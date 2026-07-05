#INCLUDE foxbin2prg.h

Define Class c_conversor_prg_a_bin As c_conversor_base Of 'c_conversor_base.prg'
   #If .F.
      Local This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzecodeblock_add_object" display="analyzeCodeBlock_ADD_OBJECT"/>] ;
      + [<memberdata name="analyzecodeblock_defined_pam" display="analyzeCodeBlock_DEFINED_PAM"/>] ;
      + [<memberdata name="analyzecodeblock_define_class" display="analyzeCodeBlock_DEFINE_CLASS"/>] ;
      + [<memberdata name="analyzecodeblock_enddefine" display="analyzeCodeBlock_ENDDEFINE"/>] ;
      + [<memberdata name="analyzecodeblock_foxbin2prg" display="analyzeCodeBlock_FoxBin2Prg"/>] ;
      + [<memberdata name="analyzecodeblock_libcomment" display="analyzeCodeBlock_LIBCOMMENT"/>] ;
      + [<memberdata name="analyzecodeblock_hidden" display="analyzeCodeBlock_HIDDEN"/>] ;
      + [<memberdata name="analyzecodeblock_include" display="analyzeCodeBlock_INCLUDE"/>] ;
      + [<memberdata name="analyzecodeblock_classcomments" display="analyzeCodeBlock_CLASSCOMMENTS"/>] ;
      + [<memberdata name="analyzecodeblock_classmetadata" display="analyzeCodeBlock_CLASSMETADATA"/>] ;
      + [<memberdata name="analyzecodeblock_external_class" display="analyzeCodeBlock_EXTERNAL_CLASS"/>] ;
      + [<memberdata name="analyzecodeblock_external_member" display="analyzeCodeBlock_EXTERNAL_MEMBER"/>] ;
      + [<memberdata name="analyzecodeblock_objectmetadata" display="analyzeCodeBlock_OBJECTMETADATA"/>] ;
      + [<memberdata name="analyzecodeblock_ole_def" display="analyzeCodeBlock_OLE_DEF"/>] ;
      + [<memberdata name="analyzecodeblock_procedure" display="analyzeCodeBlock_PROCEDURE"/>] ;
      + [<memberdata name="analyzecodeblock_protected" display="analyzeCodeBlock_PROTECTED"/>] ;
      + [<memberdata name="analyzeprocedurelines" display="analyzeProcedureLines"/>] ;
      + [<memberdata name="classmethods2memo" display="classMethods2Memo"/>] ;
      + [<memberdata name="classprops2memo" display="classProps2Memo"/>] ;
      + [<memberdata name="createclasslib" display="createClasslib"/>] ;
      + [<memberdata name="createclasslib_recordheader" display="createClasslib_RecordHeader"/>] ;
      + [<memberdata name="createform" display="createForm"/>] ;
      + [<memberdata name="createform_recordheader" display="createForm_RecordHeader"/>] ;
      + [<memberdata name="createreport" display="createReport"/>] ;
      + [<memberdata name="createmenu" display="createMenu"/>] ;
      + [<memberdata name="defined_pam2memo" display="defined_PAM2Memo"/>] ;
      + [<memberdata name="writebinaryfile" display="writeBinaryFile"/>] ;
      + [<memberdata name="evaluate_pam" display="evaluate_PAM"/>] ;
      + [<memberdata name="evaluateproceduredefinition" display="evaluateProcedureDefinition"/>] ;
      + [<memberdata name="getclassmethodcomment" display="getClassMethodComment"/>] ;
      + [<memberdata name="getclasspropertycomment" display="getClassPropertyComment"/>] ;
      + [<memberdata name="get_valuebyname_fromlistnameswithvalues" display="get_ValueByName_FromListNamesWithValues"/>] ;
      + [<memberdata name="hiddenandprotected_pam" display="hiddenAndProtected_PAM"/>] ;
      + [<memberdata name="insert_allobjects" display="insert_AllObjects"/>] ;
      + [<memberdata name="insert_object" display="insert_Object"/>] ;
      + [<memberdata name="objectmethods2memo" display="objectMethods2Memo"/>] ;
      + [<memberdata name="set_line" display="set_Line"/>] ;
      + [<memberdata name="strip_dimensions" display="strip_Dimensions"/>] ;
      + [<memberdata name="verify_external_classes" display="verify_EXTERNAL_CLASSES"/>] ;
      + [</VFPData>]



   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@    OUT) Objeto generado de clase correspondiente con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (!@ IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )
   Endproc



   Function get_ValueByName_FromListNamesWithValues
      *-- ASIGNO EL VALOR DEL ARRAY DE DATOS Y VALORES PARA LA PROPIEDAD INDICADA
      Lparameters tcPropName, tcValueType, taPropsAndValues
      Local lnPos, luPropValue

      EXTERNAL ARRAY taPropsAndValues

      lnPos   = Ascan( taPropsAndValues, tcPropName, 1, 0, 1, 1+2+4+8)

      If lnPos = 0 Or Empty( taPropsAndValues( lnPos, 2 ) )
         *-- Valores no encontrados o vacíos
         luPropValue = ''
      Else
         luPropValue = taPropsAndValues( lnPos, 2 )
      Endif

      Do Case
      Case tcValueType = 'I'
         luPropValue = Cast( luPropValue As Integer )

      Case tcValueType = 'N'
         luPropValue = Cast( luPropValue As Double )

      Case tcValueType = 'T'
         luPropValue = Cast( luPropValue As Datetime )

      Case tcValueType = 'D'
         luPropValue = Cast( luPropValue As Date )

      Case tcValueType = 'E'
         luPropValue = Evaluate( luPropValue )

      Otherwise && Asumo 'C' para lo demás
         luPropValue = luPropValue

      Endcase

      Release tcPropName, tcValueType, taPropsAndValues, lnPos
      Return luPropValue
   Endfunc


   Procedure analyzeCodeBlock_FoxBin2Prg
      *------------------------------------------------------
      *-- Analiza el bloque <FOXBIN2PRG>
      *------------------------------------------------------
      Lparameters toModulo, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      Local llBloqueEncontrado, laPropsAndValues(1,2), lnPropsAndValues_Count

      If Upper( Left( tcLine + ' ', Len(C_FB2PRG_META_I) + 1 ) ) == C_FB2PRG_META_I + ' '
         With This As c_conversor_prg_a_bin Of c_conversor_prg_a_bin.prg
            llBloqueEncontrado  = .T.

            *-- Metadatos del módulo
            .get_ListNamesWithValuesFrom_InLine_MetadataTag( @tcLine, @laPropsAndValues, @lnPropsAndValues_Count, C_FB2PRG_META_I, C_FB2PRG_META_F )
            toModulo._Version       = .get_ValueByName_FromListNamesWithValues( 'Version', 'N', @laPropsAndValues )
            toModulo._SourceFile    = .get_ValueByName_FromListNamesWithValues( 'SourceFile', 'C', @laPropsAndValues )
            *!* LScheffler 20.08.2023
            *issue #96, [KestasL] keep CodePage relavant information for binary sources
            toModulo._CPID          = .get_ValueByName_FromListNamesWithValues( 'CPID', 'I', @laPropsAndValues )
         Endwith
      Endif

      Release toModulo, tcLine, taCodeLines, I, tnCodeLines
      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_LIBCOMMENT
      *------------------------------------------------------
      *-- Analiza el bloque *<LIBCOMMENT: Comentarios />
      *------------------------------------------------------
      Lparameters toModulo, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      Local llBloqueEncontrado, laPropsAndValues(1,2), lnPropsAndValues_Count

      If Upper( Left( tcLine, Len(C_LIBCOMMENT_I) ) ) == C_LIBCOMMENT_I
         llBloqueEncontrado  = .T.

         *-- Metadatos del módulo
         toModulo._Comment       = Alltrim( Strextract( tcLine, C_LIBCOMMENT_I, C_LIBCOMMENT_F ) )
      Endif

      Release toModulo, tcLine, taCodeLines, I, tnCodeLines, laPropsAndValues, lnPropsAndValues_Count
      Return llBloqueEncontrado
   Endproc


   Procedure createClasslib
      Lparameters toModulo

      Local lcCodepage

      *!* LScheffler 20.08.2023
      *issue #96, [KestasL] keep CodePage relavant information for binary sources
      lcCodepage = Str(toModulo._CPID)

      Create Table (This.c_OutputFile) ;
         CODEPAGE = &lcCodepage.  ;
         ( PLATFORM      C(8) ;
         , UNIQUEID      C(10) ;
         , Timestamp     N(10) ;
         , Class         M ;
         , CLASSLOC      M ;
         , BaseClass     M ;
         , OBJNAME       M ;
         , Parent        M ;
         , PROPERTIES    M ;
         , Protected     M ;
         , METHODS       M ;
         , OBJCODE       M NoCPTrans ;
         , OLE           M NoCPTrans;
         , OLE2          M ;
         , RESERVED1     M ;
         , RESERVED2     M ;
         , RESERVED3     M ;
         , RESERVED4     M ;
         , RESERVED5     M ;
         , RESERVED6     M ;
         , RESERVED7     M ;
         , RESERVED8     M ;
         , User          M )

      Use (This.c_OutputFile) Alias TABLABIN Again Shared

      Set NoCPTrans To Class,CLASSLOC,BaseClass,OBJNAME,Parent,PROPERTIES,Protected,METHODS,OBJCODE,OLE,OLE2,;
         RESERVED1,RESERVED2,RESERVED3,RESERVED4,RESERVED5,RESERVED6,RESERVED7,RESERVED8,User

   Endproc


   Procedure createClasslib_RecordHeader
      Lparameters toModulo

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
      #Endif

      Insert Into TABLABIN ;
         ( PLATFORM ;
         , UNIQUEID ;
         , RESERVED1 ;
         , RESERVED7 ) ;
         VALUES ;
         ( 'COMMENT' ;
         , 'Class' ;
         , 'VERSION =   3.00' ;
         , toModulo._Comment )

   Endproc


   Procedure createForm
      Lparameters toModulo

      Local lcCodepage

      *!* LScheffler 20.08.2023
      *issue #96, [KestasL] keep CodePage relavant information for binary sources
      lcCodepage = Str(toModulo._CPID)

      Create Table (This.c_OutputFile) ;
         CODEPAGE = &lcCodepage.  ;
         ( PLATFORM      C(8) ;
         , UNIQUEID      C(10) ;
         , Timestamp     N(10) ;
         , Class         M ;
         , CLASSLOC      M ;
         , BaseClass     M ;
         , OBJNAME       M ;
         , Parent        M ;
         , PROPERTIES    M ;
         , Protected     M ;
         , METHODS       M ;
         , OBJCODE       M NoCPTrans ;
         , OLE           M NoCPTrans ;
         , OLE2          M ;
         , RESERVED1     M ;
         , RESERVED2     M ;
         , RESERVED3     M ;
         , RESERVED4     M ;
         , RESERVED5     M ;
         , RESERVED6     M ;
         , RESERVED7     M ;
         , RESERVED8     M ;
         , User          M )

      Use (This.c_OutputFile) Alias TABLABIN Again Shared

      Set NoCPTrans To Class,CLASSLOC,BaseClass,OBJNAME,Parent,PROPERTIES,Protected,METHODS;
         ,OBJCODE,OLE,OLE2,RESERVED1,RESERVED2,RESERVED3,RESERVED4,RESERVED5,RESERVED6,RESERVED7,RESERVED8,User

   Endproc


   Procedure createForm_RecordHeader
      Lparameters toModulo

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
      #Endif

      Insert Into TABLABIN ;
         ( PLATFORM ;
         , UNIQUEID ;
         , RESERVED1 ;
         , RESERVED7 ) ;
         VALUES ;
         ( 'COMMENT' ;
         , 'Screen' ;
         , 'VERSION =   3.00' ;
         , toModulo._Comment )

   Endproc



   Procedure createReport
      Lparameters tcTableOrCursor,toReport,tlFox2x    && 'TABLE' or 'CURSOR'


      Local lcCursorName,lcCodepage
      tlFox2x         = Evl( tlFox2x, .F. )
      tcTableOrCursor = Evl( tcTableOrCursor, 'TABLE' )

      If tlFox2x And tcTableOrCursor = 'TABLE'
         tcTableOrCursor = 'CURSOR'
      Endif

      lcCursorName    = Icase( tcTableOrCursor = 'TABLE', This.c_OutputFile, 'TABLABIN' )

      *!* LScheffler 20.08.2023
      *issue #96, [KestasL] keep CodePage relavant information for binary sources
      lcCodepage = Icase(Isnull(toReport),Str(Cpcurrent()),Str(toReport._CPID))

      If Not tlFox2x
         Create &tcTableOrCursor. (lcCursorName) ;
            CODEPAGE = &lcCodepage.  ;
            ( 'PLATFORM'    C(8) ;
            , 'UNIQUEID'    C(10) ;
            , 'TIMESTAMP'   N(10) ;
            , 'OBJTYPE'     N(2) ;
            , 'OBJCODE'     N(3) ;
            , 'NAME'        M ;
            , 'EXPR'        M ;
            , 'VPOS'        N(9,3) ;
            , 'HPOS'        N(9,3) ;
            , 'HEIGHT'      N(9,3) ;
            , 'WIDTH'       N(9,3) ;
            , 'STYLE'       M ;
            , 'PICTURE'     M ;
            , 'ORDER'       M NOCPTRANS;
            , 'UNIQUE'      L ;
            , 'COMMENT'     M ;
            , 'ENVIRON'     L ;
            , 'BOXCHAR'     C(1) ;
            , 'FILLCHAR'    C(1) ;
            , 'TAG'         M ;
            , 'TAG2'        M NOCPTRANS;
            , 'PENRED'      N(5) ;
            , 'PENGREEN'    N(5) ;
            , 'PENBLUE'     N(5) ;
            , 'FILLRED'     N(5) ;
            , 'FILLGREEN'   N(5) ;
            , 'FILLBLUE'    N(5) ;
            , 'PENSIZE'     N(5) ;
            , 'PENPAT'      N(5) ;
            , 'FILLPAT'     N(5) ;
            , 'FONTFACE'    M ;
            , 'FONTSTYLE'   N(3) ;
            , 'FONTSIZE'    N(3) ;
            , 'MODE'        N(3) ;
            , 'RULER'       N(1) ;
            , 'RULERLINES'  N(1) ;
            , 'GRID'        L ;
            , 'GRIDV'       N(2) ;
            , 'GRIDH'       N(2) ;
            , 'FLOAT'       L ;
            , 'STRETCH'     L ;
            , 'STRETCHTOP'  L ;
            , 'TOP'         L ;
            , 'BOTTOM'      L ;
            , 'SUPTYPE'     N(1) ;
            , 'SUPREST'     N(1) ;
            , 'NOREPEAT'    L ;
            , 'RESETRPT'    N(2) ;
            , 'PAGEBREAK'   L ;
            , 'COLBREAK'    L ;
            , 'RESETPAGE'   L ;
            , 'GENERAL'     N(3) ;
            , 'SPACING'     N(3) ;
            , 'DOUBLE'      L ;
            , 'SWAPHEADER'  L ;
            , 'SWAPFOOTER'  L ;
            , 'EJECTBEFOR'  L ;
            , 'EJECTAFTER'  L ;
            , 'PLAIN'       L ;
            , 'SUMMARY'     L ;
            , 'ADDALIAS'    L ;
            , 'OFFSET'      N(3) ;
            , 'TOPMARGIN'   N(3) ;
            , 'BOTMARGIN'   N(3) ;
            , 'TOTALTYPE'   N(2) ;
            , 'RESETTOTAL'  N(2) ;
            , 'RESOID'      N(3) ;
            , 'CURPOS'      L ;
            , 'SUPALWAYS'   L ;
            , 'SUPOVFLOW'   L ;
            , 'SUPRPCOL'    N(1) ;
            , 'SUPGROUP'    N(2) ;
            , 'SUPVALCHNG'  L ;
            , 'SUPEXPR'     M ;
            , 'USER'        M )
      Else
         Create &tcTableOrCursor. (lcCursorName) ;
            CODEPAGE = &lcCodepage.  ;
            ( 'PLATFORM'    C(8) ;
            , 'UNIQUEID'    C(10) ;
            , 'TIMESTAMP'   N(10) ;
            , 'OBJTYPE'     N(2) ;
            , 'OBJCODE'     N(3) ;
            , 'NAME'        M ;
            , 'EXPR'        M ;
            , 'VPOS'        N(9,3) ;
            , 'HPOS'        N(9,3) ;
            , 'HEIGHT'      N(9,3) ;
            , 'WIDTH'       N(9,3) ;
            , 'STYLE'       M ;
            , 'PICTURE'     M ;
            , 'ORDER'       M ;
            , 'UNIQUE'      L ;
            , 'COMMENT'     M ;
            , 'ENVIRON'     L ;
            , 'BOXCHAR'     C(1) ;
            , 'FILLCHAR'    C(1) ;
            , 'TAG'         M ;
            , 'TAG2'        M ;
            , 'PENRED'      N(5) ;
            , 'PENGREEN'    N(5) ;
            , 'PENBLUE'     N(5) ;
            , 'FILLRED'     N(5) ;
            , 'FILLGREEN'   N(5) ;
            , 'FILLBLUE'    N(5) ;
            , 'PENSIZE'     N(5) ;
            , 'PENPAT'      N(5) ;
            , 'FILLPAT'     N(5) ;
            , 'FONTFACE'    M ;
            , 'FONTSTYLE'   N(3) ;
            , 'FONTSIZE'    N(3) ;
            , 'MODE'        N(3) ;
            , 'RULER'       N(1) ;
            , 'RULERLINES'  N(1) ;
            , 'GRID'        L ;
            , 'GRIDV'       N(2) ;
            , 'GRIDH'       N(2) ;
            , 'FLOAT'       L ;
            , 'STRETCH'     L ;
            , 'STRETCHTOP'  L ;
            , 'TOP'         L ;
            , 'BOTTOM'      L ;
            , 'SUPTYPE'     N(1) ;
            , 'SUPREST'     N(1) ;
            , 'NOREPEAT'    L ;
            , 'RESETRPT'    N(2) ;
            , 'PAGEBREAK'   L ;
            , 'COLBREAK'    L ;
            , 'RESETPAGE'   L ;
            , 'GENERAL'     N(3) ;
            , 'SPACING'     N(3) ;
            , 'DOUBLE'      L ;
            , 'SWAPHEADER'  L ;
            , 'SWAPFOOTER'  L ;
            , 'EJECTBEFOR'  L ;
            , 'EJECTAFTER'  L ;
            , 'PLAIN'       L ;
            , 'SUMMARY'     L ;
            , 'ADDALIAS'    L ;
            , 'OFFSET'      N(3) ;
            , 'TOPMARGIN'   N(3) ;
            , 'BOTMARGIN'   N(3) ;
            , 'TOTALTYPE'   N(2) ;
            , 'RESETTOTAL'  N(2) ;
            , 'RESOID'      N(3) ;
            , 'CURPOS'      L ;
            , 'SUPALWAYS'   L ;
            , 'SUPOVFLOW'   L ;
            , 'SUPRPCOL'    N(1) ;
            , 'SUPGROUP'    N(2) ;
            , 'SUPVALCHNG'  L ;
            , 'SUPEXPR'     M )
      Endif

      If tcTableOrCursor = 'TABLE' Then
         Use (This.c_OutputFile) Alias TABLABIN Again Shared
      Endif

      If tlFox2x
         Set NoCPTrans To Name,Expr,Style,Picture,Order,Comment,Tag,TAG2,FONTFACE,SUPEXPR
      Else
         Set NoCPTrans To Name,Expr,Style,Picture,Order,Comment,Tag,TAG2,FONTFACE,SUPEXPR,User
      Endif

   Endproc



   Procedure createMenu
      Lparameters tcTableOrCursor,toMenu  && 'TABLE' or 'CURSOR'

      Local lcCursorName,lcCodepage
      tcTableOrCursor = Evl( tcTableOrCursor, 'TABLE' )
      lcCursorName    = Icase( tcTableOrCursor = 'TABLE', This.c_OutputFile, 'TABLABIN' )

      *!* LScheffler 20.08.2023
      *issue #96, [KestasL] keep CodePage relavant information for binary sources
      lcCodepage = Icase(Isnull(toMenu),Str(Cpcurrent()),Str(toMenu._CPID))

      Create &tcTableOrCursor. (lcCursorName) ;
         CODEPAGE = &lcCodepage.  ;
         ( 'OBJTYPE'     Numeric(2) ;
         , 'OBJCODE'     Numeric(2) ;
         , 'NAME'        Memo ;
         , 'PROMPT'      Memo ;
         , 'COMMAND'     Memo ;
         , 'MESSAGE'     Memo ;
         , 'PROCTYPE'    Numeric(1) ;
         , 'PROCEDURE'   Memo ;
         , 'SETUPTYPE'   Numeric(1) ;
         , 'SETUP'       Memo ;
         , 'CLEANTYPE'   Numeric(1) ;
         , 'CLEANUP'     Memo ;
         , 'MARK'        Character(1) ;
         , 'KEYNAME'     Memo ;
         , 'KEYLABEL'    Memo ;
         , 'SKIPFOR'     Memo ;
         , 'NAMECHANGE'  Logical ;
         , 'NUMITEMS'    Numeric(2) ;
         , 'LEVELNAME'   Character(10) ;
         , 'ITEMNUM'     Character(3) ;
         , 'COMMENT'     Memory(4) ;
         , 'LOCATION'    Numeric(2) ;
         , 'SCHEME'      Numeric(2) ;
         , 'SYSRES'      Numeric(1) ;
         , 'RESNAME'     Memory(4) )

      If tcTableOrCursor = 'TABLE' Then
         Use (This.c_OutputFile) Alias TABLABIN Again Shared
      Endif

      Set NoCPTrans To Name,Prompt,Command,Message,Procedure,Setup,CLEANUP,KEYNAME,KEYLABEL,SkipFor


   Endproc



   Procedure writeBinaryFile
      Lparameters toModulo
   Endproc



   Procedure classProps2Memo
      *--------------------------------------------------------------------------------------------------------------
      * ARMA EL MEMO DE PROPERTIES CON LAS PROPIEDADES Y SUS VALORES
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toClase                   (!@ IN    ) Objeto de la Clase
      * toFoxBin2Prg              (@? IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toClase, toFoxBin2Prg

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      *-- ESTRUCTURA A ANALIZAR: Propiedades normales, con CR codificado (<fb2p_value>) y con CR+LF (<fb2p_value>)
      *   HEIGHT =   2.73
      *   NAME = "c1"
      *   prop1 = .F.     && Mi prop 1
      *   prop_especial_cr = <fb2p_value>Este es el valor 1&#10;Este el 2&#10;Y Este bajo Shift_Enter el 3</fb2p_value>
      *   prop_especial_crlf = <fb2p_value>
      *   Este es el valor 1
      *   Este el 2
      *   Y Este bajo Shift_Enter el 3
      *   </fb2p_value>
      *   WIDTH =  27.40
      *   _MEMBERDATA = <VFPData>
      *   <memberdata NAME="mimetodo" DISPLAY="miMetodo"/>
      *   <memberdata NAME="mimetodo2" DISPLAY="miMetodo2"/>
      *   </VFPData>      && XML Metadata for customizable properties
      *-- Fin: ESTRUCTURA A ANALIZAR:

      Try
         Local I, lcMemo, laPropsAndValues(1,2), lnPropsAndValues_Count
         lcMemo  = ''

         If toClase._Prop_Count > 0
            With This As c_conversor_prg_a_bin Of c_conversor_prg_a_bin.prg
               .updateProgressbar( 'Generating Props for Class ' + toClase._Nombre + '...', 0, 1, 2 )
               .c_ClaseActual  = Lower(toClase._BaseClass)
               Dimension laPropsAndValues( toClase._Prop_Count, 3 )
               Acopy( toClase._Props, laPropsAndValues )
               lnPropsAndValues_Count  = toClase._Prop_Count

               *-- REORDENO LAS PROPIEDADES
               .sortPropsAndValues( @laPropsAndValues, lnPropsAndValues_Count, 2 )


               *-- ARMO EL MEMO A DEVOLVER
               For I = 1 To lnPropsAndValues_Count
                  *
                  * Skip ZOrderSet if configured to
                  *
                  If toFoxBin2Prg.getCfgValue('l_RemoveZOrderSetFromProps') And Atc( '.ZOrderSet.', '.' + laPropsAndValues(m.I, 1) + '.' ) > 0 Then
                     Loop
                  Endif
                  lcMemo  = lcMemo + laPropsAndValues(m.I,1) + ' = ' + laPropsAndValues(m.I,2) + CR_LF
               Endfor
            Endwith
         Endif && toClase._Prop_Count > 0

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toClase, I, laPropsAndValues, lnPropsAndValues_Count
      Endtry

      Return lcMemo
   Endproc



   Procedure objectProps2Memo
      *-- ARMA EL MEMO DE PROPERTIES CON LAS PROPIEDADES Y SUS VALORES
      Lparameters toObjeto, toClase

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg' ;
            , toObjeto As CL_OBJETO Of 'cl_objeto.prg'
      #Endif

      Local lcMemo, I, laPropsAndValues(1,2)
      lcMemo  = ''

      If toObjeto._Prop_Count > 0
         With This As c_conversor_prg_a_bin Of c_conversor_prg_a_bin.prg
            .c_ClaseActual  = Lower(toObjeto._BaseClass)
            Dimension laPropsAndValues( toObjeto._Prop_Count, 2 )
            Acopy( toObjeto._Props, laPropsAndValues )


            *-- REORDENO LAS PROPIEDADES
            .sortPropsAndValues( @laPropsAndValues, toObjeto._Prop_Count, 2 )


            *-- ARMO EL MEMO A DEVOLVER
            For I = 1 To toObjeto._Prop_Count
               lcMemo  = lcMemo + laPropsAndValues(m.I,1) + ' = ' + laPropsAndValues(m.I,2) + CR_LF
            Endfor
         Endwith
      Endif

      Release toObjeto, toClase, I, laPropsAndValues
      Return lcMemo
   Endproc



   Procedure classMethods2Memo
      Lparameters toClase

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local lcMemo, I, X, lcNombreObjeto ;
         , loProcedure As CL_PROCEDURE Of 'cl_procedure.prg'
      lcMemo  = ''

      *-- Recorrer los métodos
      With This As c_conversor_prg_a_bin Of c_conversor_prg_a_bin.prg
         For I = 1 To toClase._Procedure_Count
            loProcedure = .Null.
            loProcedure = toClase._Procedures(m.I)

            If loProcedure._ProcLine_Count > 0 Then
               .updateProgressbar( 'Generating Procedure ' + toClase._Nombre + '.' + loProcedure._Nombre + '...', m.I, toClase._Procedure_Count, 2 )

               If '.' $ loProcedure._Nombre
                  *-- cboNombre.InteractiveChange ==> No debe acortarse por ser método modificado de combobox heredado de la clase
                  *-- cntDatos.txtEdad.Valid      ==> Debe acortarse si cntDatos es un objeto existente
                  lcNombreObjeto  = Left( loProcedure._Nombre, At('.', loProcedure._Nombre) - 1 )

                  If .findMethodsObjectByName( lcNombreObjeto, toClase ) = 0
                     TEXT TO lcMemo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                                <<C_PROCEDURE>> <<loProcedure._Nombre>>
                     ENDTEXT
                     *lcMemo = lcMemo + C_PROCEDURE + ' ' + loProcedure._Nombre
                  Else
                     TEXT TO lcMemo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                                <<C_PROCEDURE>> <<SUBSTR( loProcedure._Nombre, AT('.', loProcedure._Nombre) + 1 )>>
                     ENDTEXT
                     *lcMemo = lcMemo + C_PROCEDURE + ' ' + SUBSTR( loProcedure._Nombre, AT('.', loProcedure._Nombre) + 1 )
                  Endif
               Else
                  TEXT TO lcMemo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                            <<C_PROCEDURE>> <<loProcedure._Nombre>>
                  ENDTEXT
                  *lcMemo = lcMemo + C_PROCEDURE + ' ' + loProcedure._Nombre
               Endif

               *-- Incluir las líneas del método
               *.updateProgressbar( 'Generating Lines of Procedure ' + toClase._Nombre + '.' + loProcedure._Nombre + '...', m.I, toClase._Procedure_Count, 2 )
               For X = 1 To loProcedure._ProcLine_Count
                  *TEXT TO lcMemo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                  *   <<loProcedure._ProcLines(m.X)>>
                  *ENDTEXT
                  lcMemo = lcMemo + Chr(13) + Chr(10) + loProcedure._ProcLines(m.X)
               Endfor

               TEXT TO lcMemo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<C_ENDPROC>>
                        <<>>
               ENDTEXT
            Endif
         Endfor
      Endwith

      loProcedure = .Null.
      Release toClase, I, X, lcNombreObjeto, loProcedure
      Return lcMemo
   Endproc



   Procedure objectMethods2Memo
      Lparameters toObjeto, toClase

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg' ;
            , toObjeto As CL_OBJETO Of 'cl_objeto.prg'
      #Endif

      Local lcMemo, I, X, lcNombreObjeto ;
         , loProcedure As CL_PROCEDURE Of 'cl_procedure.prg'
      lcMemo  = ''

      *-- Recorrer los métodos
      This.updateProgressbar( 'Generating Object Methods for ' + toClase._Nombre + '.' + toObjeto._ObjName + '...', 0, 1, 2 )
      For I = 1 To toObjeto._Procedure_Count
         loProcedure = .Null.
         loProcedure = toObjeto._Procedures(m.I)

         TEXT TO lcMemo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                <<C_PROCEDURE>> <<loProcedure._Nombre>>
         ENDTEXT

         *-- Incluir las líneas del método
         For X = 1 To loProcedure._ProcLine_Count
            lcMemo = lcMemo + Chr(13) + Chr(10) + loProcedure._ProcLines(m.X)
         Endfor

         TEXT TO lcMemo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<C_ENDPROC>>
                <<>>
         ENDTEXT
      Endfor

      loProcedure = .Null.
      Release toObjeto, toClase, I, X, lcNombreObjeto, loProcedure
      Return lcMemo
   Endproc



   Procedure getClassPropertyComment
      *-- Devuelve el comentario (columna 2 del array toClase._Props) de la propiedad indicada,
      *-- buscándola en la columna 2 por su nombre.
      Lparameters tcPropName As String, toClase

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local I, lcComentario
      lcComentario    = ''

      For I = 1 To toClase._Prop_Count
         If Rtrim( Getwordnum( toClase._Props(m.I,1), 1, '=' ) ) == tcPropName
            lcComentario    = toClase._Props( m.I, 2 )
            Exit
         Endif
      Endfor

      Release tcPropName, toClase, I
      Return lcComentario
   Endproc



   Procedure getClassMethodComment
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (@! IN/OUT) Línea a separar del comentario (En este punto, el único comentario puede ser un HELPSTRING)
      * tcComment                 (@?    OUT) Comentario
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine As String, tcComment As String

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local lnATC
      tcComment   = ''
      lnATC       = Atc("HELPSTRING", tcLine)

      If lnATC > 0
         tcComment   = Alltrim(Substr(tcLine, lnATC + 10 ))

         * Quitar comillas
         tcComment   = Substr(tcComment, 2, Len(tcComment) - 2)

         tcLine      = Rtrim(Left(tcLine, lnATC - 1 ), 0, Chr(9), Chr(0), ' ')
      Endif

      Return tcComment
   Endproc



   Procedure getTextFrom_BIN_FileStructure
      Try
         Local lcStructure, lnSelect
         lnSelect    = Select()
         Select 0
         Use (This.c_InputFile) Shared Again Alias _TABLABIN
         Copy Structure Extended To ( Forcepath( '_FRX_STRUC.DBF', Addbs( This.c_TempDir ) ) )
         **** CONTINUAR SI ES NECESARIO - SIN USO POR AHORA /// DO NOT USE - NOT IMPLEMENTED!

      Catch To loEx
         Throw

      Finally
         Use In (Select("_TABLABIN"))
         Select (lnSelect)
      Endtry

      Return lcStructure
   Endproc


   Procedure defined_PAM2Memo
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toClase                   (!@ IN    ) Objeto de la Clase
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toClase
      Return toClase._Defined_PAM
   Endproc


   Procedure strip_Dimensions
      Lparameters tcSeparatedCommaVars
      Local lnPos1, lnPos2, I

      For I = Occurs( '[', tcSeparatedCommaVars ) To 1 Step -1
         lnPos1  = At( '[', tcSeparatedCommaVars, m.I )
         lnPos2  = At( ']', tcSeparatedCommaVars, m.I )
         tcSeparatedCommaVars    = Stuff( tcSeparatedCommaVars, lnPos1, lnPos2 - lnPos1 + 1, '' )
      Endfor

      Release tcSeparatedCommaVars, lnPos1, lnPos2, I
      Return
   Endproc


   Procedure hiddenAndProtected_PAM
      Lparameters toClase

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local lcMemo, I, lcPAM, lcComentario
      lcMemo  = ''

      With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
         .evaluate_PAM( @lcMemo, toClase._ProtectedProps, 'property', 'protected' )
         .evaluate_PAM( @lcMemo, toClase._HiddenProps, 'property', 'hidden' )
         .evaluate_PAM( @lcMemo, toClase._ProtectedMethods, 'method', 'protected' )
         .evaluate_PAM( @lcMemo, toClase._HiddenMethods, 'method', 'hidden' )
      Endwith && THIS

      Release toClase, I, lcPAM, lcComentario
      Return lcMemo
   Endproc


   Procedure evaluate_PAM
      Lparameters tcMemo As String, tcPAM As String, tcPAM_Type As String, tcPAM_Visibility As String

      Local lcPAM, I

      For I = 1 To Occurs( ',', tcPAM + ',' )
         lcPAM   = Alltrim( Getwordnum( tcPAM, m.I, ',' ) )

         If Not Empty(lcPAM)
            If Evl(tcPAM_Visibility, 'normal') == 'hidden'
               lcPAM   = lcPAM + '^'
            Endif

            tcMemo  = tcMemo + lcPAM + CR_LF
         Endif
      Endfor

      Release tcMemo, tcPAM, tcPAM_Type, tcPAM_Visibility, lcPAM, I
      Return
   Endproc


   Procedure insert_Object
      Lparameters toClase, toObjeto, toFoxBin2Prg

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
         Local toObjeto As CL_OBJETO Of 'cl_objeto.prg'
      #Endif

      With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
         If Not .l_Test
            Local lcPropsMemo, lcMethodsMemo
            lcPropsMemo     = .objectProps2Memo( toObjeto, toClase )
            lcMethodsMemo   = .objectMethods2Memo( toObjeto, toClase )

            If Empty(toObjeto._TimeStamp)
               toObjeto._TimeStamp = .rowTimeStamp( {^2013/11/04 20:00:00} )
            Endif
            If Empty(toObjeto._UniqueID)
               toObjeto._UniqueID  = toFoxBin2Prg.unique_ID()
            Endif

            *-- Inserto el objeto
            If Justext(toFoxBin2Prg.c_InputFile) = toFoxBin2Prg.getCfgValue('c_PJ2')
               * Solo los PJX/PJ2 tienen el campo DEVINFO
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
                  , User ;
                  , DEVINFO ) ;
                  VALUES ;
                  ( 'WINDOWS' ;
                  , toObjeto._UniqueID ;
                  , toObjeto._TimeStamp ;
                  , toObjeto._Class ;
                  , toObjeto._ClassLib ;
                  , toObjeto._BaseClass ;
                  , toObjeto._ObjName ;
                  , toObjeto._Parent ;
                  , lcPropsMemo ;
                  , '' ;
                  , lcMethodsMemo ;
                  , toObjeto._Ole ;
                  , toObjeto._Ole2 ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , Strconv(toObjeto._User,14) ;
                  , Strconv(toObjeto._DevInfo,14) )
            Else
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
                  , User ) ;
                  VALUES ;
                  ( 'WINDOWS' ;
                  , toObjeto._UniqueID ;
                  , toObjeto._TimeStamp ;
                  , toObjeto._Class ;
                  , toObjeto._ClassLib ;
                  , toObjeto._BaseClass ;
                  , toObjeto._ObjName ;
                  , toObjeto._Parent ;
                  , lcPropsMemo ;
                  , '' ;
                  , lcMethodsMemo ;
                  , toObjeto._Ole ;
                  , toObjeto._Ole2 ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , '' ;
                  , Strconv(toObjeto._User,14) )
            Endif
         Endif
      Endwith && THIS

      Release toClase, toObjeto, toFoxBin2Prg, lcPropsMemo, lcMethodsMemo
      Return
   Endproc


   Procedure insert_AllObjects
      *-- Recorro primero los objetos con ZOrder definido, y luego los demás
      *-- NOTA: Como consecuencia de una integración de código, puede que se hayan agregado objetos nuevos (desconocidos),
      *--       pero todo lo demás tiene un ZOrder definido, que es el número de registro original * 100.
      Lparameters toClase, toFoxBin2Prg

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local N, X, lcObjName, loObjeto As CL_OBJETO Of 'cl_objeto.prg'
         loObjeto    = .Null.

         With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
            If toClase._AddObject_Count > 0
               N   = 0

               *-- Armo array con el orden Z de los objetos
               Dimension laObjNames( toClase._AddObject_Count, 2 )

               For X = 1 To toClase._AddObject_Count
                  loObjeto            = toClase._AddObjects( m.X )

                  If Empty(loObjeto._TimeStamp)
                     loObjeto._TimeStamp = .rowTimeStamp( {^2013/11/04 20:00:00} )
                  Endif
                  If Empty(loObjeto._UniqueID)
                     loObjeto._UniqueID  = toFoxBin2Prg.unique_ID()
                  Endif

                  laObjNames( m.X, 1 )    = loObjeto._Nombre
                  laObjNames( m.X, 2 )    = loObjeto._ZOrder
                  loObjeto            = .Null.
               Endfor

               Asort( laObjNames, 2, -1, 0, 1 )


               *-- Escribo los objetos en el orden Z
               For X = 1 To toClase._AddObject_Count
                  lcObjName   = laObjNames( m.X, 1 )

                  For Each loObjeto In toClase._AddObjects FoxObject
                     *-- Verifico que sea el objeto que corresponde
                     If loObjeto._WriteOrder = 0 And Lower(loObjeto._Nombre) == Lower(lcObjName)
                        N   = N + 1
                        loObjeto._WriteOrder    = N
                        .insert_Object( @toClase, @loObjeto, @toFoxBin2Prg )
                        Exit
                     Endif
                  Endfor
               Endfor


               *-- Recorro los objetos Desconocidos
               For Each loObjeto In toClase._AddObjects FoxObject
                  If loObjeto._WriteOrder = 0
                     .insert_Object( @toClase, @loObjeto, @toFoxBin2Prg )
                  Endif
               Endfor

            Endif   && toClase._AddObject_Count > 0
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         loObjeto    = .Null.
         Release toClase, toFoxBin2Prg, N, X, lcObjName, loObjeto

      Endtry

      Return
   Endproc


   Procedure set_Line
      Lparameters tcLine, taCodeLines, I

      External Array taCodeLines

      tcLine  = Ltrim( taCodeLines(m.I), 0, Chr(9), ' ' )
   Endproc


   Procedure analyzeProcedureLines
      Lparameters toClase, toObjeto, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto, tc_Comentario ;
         , taLineasExclusion, tnBloquesExclusion

      External Array taCodeLines

      #If .F.
         Local toObjeto As CL_OBJETO Of 'cl_objeto.prg'
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Try
         Local llEsProcedureDeClase ;
            , loProcedure As CL_PROCEDURE Of 'cl_procedure.prg' ;
            , loLang As CL_LANG Of 'cl_lang.prg'
         loLang      = _Screen.o_FoxBin2Prg_Lang
         loProcedure = .Null.

         If '.' $ tcProcedureAbierto And Vartype(toObjeto) = 'O' And toObjeto._Procedure_Count > 0
            loProcedure = toObjeto._Procedures(toObjeto._Procedure_Count)
         Else
            llEsProcedureDeClase    = .T.
            loProcedure = toClase._Procedures(toClase._Procedure_Count)
         Endif

         With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
            For I = m.I + 1 To tnCodeLines
               .set_Line( @tcLine, @taCodeLines, m.I )

               If Not .excludedLine( m.I, tnBloquesExclusion, @taLineasExclusion ) ;
                     AND Not .lineIsOnlyCommentAndNoMetadata( @tcLine, @tc_Comentario )

                  Do Case
                  Case Upper( Left( tcLine + ' ', 8 ) ) == 'ENDPROC ' ; && Fin del PROCEDURE
                     Or Upper( Left( tcLine + ' ', 8 ) ) == 'ENDFUNC ' && Fin de la FUNCTION

                     tcProcedureAbierto  = ''
                     Exit

                  Case Upper( Left( tcLine + ' ', 10 ) ) == 'ENDDEFINE '  && Fin de bloque (ENDDEFINE) encontrado
                     If llEsProcedureDeClase
                        *ERROR 'Error de anidamiento de estructuras. Se esperaba ENDPROC y se encontró ENDDEFINE en la clase ' ;
                        + toClase._Nombre + ' (' + loProcedure._Nombre + ')' ;
                        + ', línea ' + TRANSFORM(m.I) + ' del archivo ' + .c_InputFile
                        Error (Textmerge(loLang.C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_LOC))
                     Else
                        *ERROR 'Error de anidamiento de estructuras. Se esperaba ENDPROC y se encontró ENDDEFINE en la clase ' ;
                        + toClase._Nombre + ' (' + toObjeto._Nombre + '.' + loProcedure._Nombre + ')' ;
                        + ', línea ' + TRANSFORM(m.I) + ' del archivo ' + .c_InputFile
                        Error (Textmerge(loLang.C_STRUCTURE_NESTING_ERROR_ENDPROC_EXPECTED_2_LOC))
                     Endif
                  Endcase
               Endif

               *-- Quito 2 TABS de la izquierda (si se puede y si el integrador/desarrollador no la lió quitándolos)
               Do Case
               Case Left( taCodeLines(m.I),2 ) = C_TAB + C_TAB
                  loProcedure.add_Line( Substr(taCodeLines(m.I), 3) )
               Case Left( taCodeLines(m.I),1 ) = C_TAB
                  loProcedure.add_Line( Substr(taCodeLines(m.I), 2) )
               Otherwise
                  loProcedure.add_Line( taCodeLines(m.I) )
               Endcase
            Endfor
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         loProcedure = .Null.
         Release toClase, toObjeto, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto, tc_Comentario ;
            , taLineasExclusion, tnBloquesExclusion, llEsProcedureDeClase, loProcedure

      Endtry

      Return
   Endproc


   Procedure analyzeCodeBlock_ADD_OBJECT
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@ IN    ) Objeto del Modulo
      * toClase                   (!@ IN    ) Objeto de la Clase
      * tcLine                    (!@ IN    ) Línea de datos en evaluación
      * taCodeLines               (!@ IN    ) El array con las líneas del código de texto donde buscar
      * I                         (!@ IN    ) Número de línea en evaluación
      * tnCodeLines               (!@ IN    ) Cantidad de líneas de código
      * toFoxBin2Prg              (?@ IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toModulo, toClase, tcLine, I, taCodeLines, tnCodeLines, toFoxBin2Prg

      External Array taCodeLines

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toClase As CL_CLASE Of 'cl_clase.prg'
         Local toObjeto As CL_OBJETO Of 'cl_objeto.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local llBloqueEncontrado

         If Upper( Left( tcLine, 11 ) ) == 'ADD OBJECT '
            *-- Estructura a reconocer: ADD OBJECT 'frm_a.Check1' AS check [WITH]
            With This As c_conversor_prg_a_bin Of c_conversor_prg_a_bin.prg
               Local laPropsAndValues(1,2), lnPropsAndValues_Count, Z, lcProp, lcValue, lcNombre, lcObjName, lnPos ;
                  , loLang As CL_LANG Of 'cl_lang.prg'

               llBloqueEncontrado  = .T.
               loLang      = _Screen.o_FoxBin2Prg_Lang
               tcLine      = Chrtran( tcLine, ['], ["] )

               If Empty(toClase._Fin_Cab)
                  toClase._Fin_Cab    = m.I-1
                  toClase._Ini_Cuerpo = m.I
               Endif

               toObjeto    = .Null.
               lcNombre    = Alltrim( Chrtran( Strextract(tcLine, 'ADD OBJECT ', ' AS ', 1, 1), ['"], [] ) )
               lcObjName   = Justext( '.' + lcNombre )
               .updateProgressbar( 'Analyzing Block Add Object ' + toClase._Nombre + '.' + lcObjName + '...', m.I, tnCodeLines, 1 )

               If toClase.l_ObjectMetadataInHeader
                  For Z = 1 To toClase._AddObject_Count
                     If Lower(toClase._AddObjects(m.Z)._Nombre) == Lower(lcNombre) Then
                        toObjeto    = toClase._AddObjects(m.Z)
                        Exit
                     Endif
                  Endfor
               Endif

               If Isnull(toObjeto)
                  Z           = 0
                  toObjeto    = NewObject('CL_OBJETO', 'cl_objeto.prg')
                  *-- Luego se reasigna el ZOrder, pero si no lo hace, se pone último como si se acabara de agregar.
                  *-- Puede pasar si se agrega manualmente al TX2 y se olvida agregar la metadata OBJECTDATA.
                  toObjeto._ZOrder    = 9999
                  toObjeto._Nombre    = lcNombre
               Endif

               toObjeto._ObjName   = lcObjName

               If '.' $ toObjeto._Nombre
                  toObjeto._Parent    = toClase._ObjName + '.' + Juststem( toObjeto._Nombre )
               Else
                  toObjeto._Parent    = toClase._ObjName
               Endif

               toObjeto._Nombre    = toObjeto._Parent + '.' + toObjeto._ObjName
               toObjeto._Class     = Alltrim( Strextract(tcLine + ' WITH', ' AS ', ' WITH', 1, 1) )

               *-- Chequeo de nombre de objeto repetido para el mismo contenedor
               If toClase._aPathObjName_Count > 0
                  lnPos   = Ascan( toClase._aPathObjNames, toObjeto._Nombre, 1, 0, 1, 1+2+4+8 )

                  If lnPos > 0 Then
                     *-- ERROR: Objeto Duplicado
                     .writeErrorLog( '* ' + loLang.C_DUPLICATED_OBJECT_LOC + ' "' + toClase._Class + '.' + toObjeto._Nombre ;
                        + '" @line ' + Transform(m.I) + ', (1st.Line:' + Transform(toClase._aPathObjNames(lnPos,2)) + ')' )
                  Endif
               Endif

               If Not toClase.l_ObjectMetadataInHeader Or m.Z=0
                  toClase.add_Object( toObjeto )
               Endif

               toClase.add_PathObjName(toObjeto._Nombre, m.I)

               *-- Propiedades del ADD OBJECT
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  If Upper( Left( tcLine, C_LEN_END_OBJECT_I) ) == C_END_OBJECT_I && Fin del ADD OBJECT y METADATOS
                     *< END OBJECT: baseclass = "olecontrol" Uniqueid = "_3X50L3I7V" OLEObject = "C:\WINDOWS\system32\FOXTLIB.OCX" checksum = "4101493921" />

                     .get_ListNamesWithValuesFrom_InLine_MetadataTag( @tcLine, @laPropsAndValues, @lnPropsAndValues_Count ;
                        , C_END_OBJECT_I, C_END_OBJECT_F )

                     toObjeto._ClassLib          = .get_ValueByName_FromListNamesWithValues( 'ClassLib', 'C', @laPropsAndValues )
                     toObjeto._BaseClass         = .get_ValueByName_FromListNamesWithValues( 'BaseClass', 'C', @laPropsAndValues )

                     If Not toClase.l_ObjectMetadataInHeader
                        toObjeto._UniqueID          = .get_ValueByName_FromListNamesWithValues( 'UniqueID', 'C', @laPropsAndValues )
                        toObjeto._TimeStamp         = Int( .rowTimeStamp( .get_ValueByName_FromListNamesWithValues( 'TimeStamp', 'T', @laPropsAndValues ) ) )
                        toObjeto._ZOrder            = .get_ValueByName_FromListNamesWithValues( 'ZOrder', 'I', @laPropsAndValues )
                     Endif

                     toObjeto._Ole2              = .get_ValueByName_FromListNamesWithValues( 'OLEObject', 'C', @laPropsAndValues )
                     toObjeto._Ole               = Strconv( .get_ValueByName_FromListNamesWithValues( 'Value', 'C', @laPropsAndValues ), 14 )

                     If Not Empty( toObjeto._Ole2 )  && Le agrego "OLEObject = " delante
                        toObjeto._Ole2      = 'OLEObject = ' + toObjeto._Ole2 + CR_LF
                     Endif

                     *-- Ubico el objeto ole por su nombre (parent+objname), que no se repite.
                     If Empty(toObjeto._Ole) && Si _Ole está vacío es porque el propio control no tiene la info y está en la cabecera (antiguo guardado)
                        If toModulo.existeObjetoOLE( toObjeto._Nombre, @m.Z )
                           toObjeto._Ole   = toModulo._Ole_Objs(m.Z)._Value
                        Endif
                     Endif

                     Exit
                  Endif

                  If Right(tcLine, 3) == ', ;'    && VALOR INTERMEDIO CON ", ;"
                     .get_SeparatedPropAndValue( Left(tcLine, Len(tcLine) - 3), @lcProp, @lcValue, toClase, @taCodeLines, @tnCodeLines, @m.I )

                     *
                     * Skip ZOrderSet if configured to
                     *
                     If toFoxBin2Prg.getCfgValue('l_RemoveZOrderSetFromProps') And Atc( '.ZOrderSet.', '.' + lcProp + '.' ) > 0 Then
                        Loop
                     Endif
                     toObjeto.add_Property( @lcProp, @lcValue )
                  Else    && VALOR FINAL SIN ", ;" (JUSTO ANTES DEL <END OBJECT>)
                     .get_SeparatedPropAndValue( tcLine, @lcProp, @lcValue, toClase, @taCodeLines, @tnCodeLines, @m.I )

                     *
                     * Skip ZOrderSet if configured to
                     *
                     If toFoxBin2Prg.getCfgValue('l_RemoveZOrderSetFromProps') And Atc( '.ZOrderSet.', '.' + lcProp + '.' ) > 0 Then
                        Loop
                     Endif
                     toObjeto.add_Property( @lcProp, @lcValue )
                  Endif

               Endfor
            Endwith && THIS
         Endif

      Catch To loEx
         loEx.UserValue = loEx.UserValue + Textmerge('Source line=<<I>>') + CR_LF
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toModulo, toClase, tcLine, I, taCodeLines, tnCodeLines ;
            , laPropsAndValues, lnPropsAndValues_Count, Z, lcProp, lcValue, lcNombre, lcObjName
      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_DEFINED_PAM
      *--------------------------------------------------------------------------------------------------------------
      * 07/01/2014    FDBOZZO     Los *métodos deben ir siempre al final, si no los eventos ACCESS no se ejecutan!
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toClase                   (!@ IN    ) Objeto de la Clase
      * tcLine                    (!@ IN    ) Línea de datos en evaluación
      * taCodeLines               (!@ IN    ) El array con las líneas del código de texto donde buscar
      * tnCodeLines               (!@ IN    ) Cantidad de líneas de código
      * I                         (!@ IN    ) Número de línea en evaluación
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toClase, tcLine, taCodeLines, tnCodeLines, I
      External Array taCodeLines

      *-- ESTRUCTURA A ANALIZAR (también se admite sin los símbolos ^ y *):
      *<DefinedPropArrayMethod>
      *m: *metodovacio_con_comentarios        && Este método no tiene código, pero tiene comentarios. A ver que pasa!
      *m: *mimetodo       && Mi metodo
      *p: prop1       && Mi prop 1
      *p: prop_especial_cr        &&
      *a: ^array_1_d[1,0]     && Array 1 dimensión (1)
      *a: ^array_2_d[1,2]     && Array una dimension (1,2)
      *p: _memberdata     && XML Metadata for customizable properties
      *</DefinedPropArrayMethod>

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcDefinedPAM, lnPos, lnPos2, lcPAM_Name, lcItem, lcMethods, lcPAM_Type

         If Left( tcLine, C_LEN_DEFINED_PAM_I) == C_DEFINED_PAM_I
            llBloqueEncontrado  = .T.
            Store '' To lcDefinedPAM, lcItem, lcMethods

            With This As c_conversor_prg_a_bin Of c_conversor_prg_a_bin.prg
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Left( tcLine, C_LEN_DEFINED_PAM_F ) == C_DEFINED_PAM_F
                     I = m.I + 1
                     Exit

                  Otherwise
                     lnPos       = At( ':', tcLine, 1 )
                     lnPos2      = At( '&'+'&', tcLine )
                     lcPAM_Type  = Left(tcLine,3)    && *p:, *a:, *m:

                     If lnPos2 > 0
                        *-- Con comentarios
                        lcPAM_Name  = Lower( Alltrim( Substr( tcLine, lnPos+1, lnPos2 - lnPos - 1 ), 0, ' ', Chr(9) ) )
                        lcItem      = lcPAM_Name + ' ' + Substr( tcLine, lnPos2 + 3 ) + CR_LF

                     Else
                        *-- Sin comentarios
                        lcPAM_Name  = Lower( Alltrim( Substr( tcLine, lnPos+1 ), 0, ' ', Chr(9) ) )
                        lcItem      = lcPAM_Name + Iif( lcPAM_Type == '*p:' , '', ' ') + CR_LF

                     Endif

                     *-- Separo propiedades y métodos
                     If lcPAM_Type == '*m:'
                        If Left(lcItem,1) == '*'
                           lcMethods       = lcMethods + lcItem
                        Else
                           lcMethods       = lcMethods + '*' + lcItem
                        Endif
                     Else
                        If lcPAM_Type == '*a:' And Left(lcItem,1) <> '^'
                           lcDefinedPAM    = lcDefinedPAM + '^' + lcItem
                        Else
                           lcDefinedPAM    = lcDefinedPAM + lcItem
                        Endif
                     Endif
                  Endcase
               Endfor
            Endwith && THIS

            *-- Junto propiedades y los métodos al final.
            toClase._Defined_PAM    = lcDefinedPAM + lcMethods
            I = m.I - 1
         Endif

      Catch To loEx
         lnCodError  = loEx.ErrorNo

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toClase, tcLine, taCodeLines, tnCodeLines, I ;
            , lcDefinedPAM, lnPos, lnPos2, lcPAM_Name, lcItem, lcMethods, lcPAM_Type
      Endtry

      Return llBloqueEncontrado
   Endproc

   *!* Changed by: LScheffler 16.3.2023
   *!* <pdm>
   *!* <change date="{^2023-03-16,13:39:00}">Changed by: LScheffler<br />
   *!* get the newly introduced Class-property-value-block
   *!* </change>
   *!* </pdm>

   Procedure analyzeCodeBlock_DEFINED_PROPVAL
      *--------------------------------------------------------------------------------------------------------------
      * 16/03/2023    LutzScheffler   old version (pre v1.19.77) stored the comment on the property value, so it was impossible to to keep && in value
      * the method is basically a copy of analyzeCodeBlock_DEFINED_PAM
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toClase                   (!@ IN    ) Objeto de la Clase
      * tcLine                    (!@ IN    ) Línea de datos en evaluación
      * taCodeLines               (!@ IN    ) El array con las líneas del código de texto donde buscar
      * tnCodeLines               (!@ IN    ) Cantidad de líneas de código
      * I                         (!@ IN    ) Número de línea en evaluación
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toClase, tcLine, taCodeLines, tnCodeLines, I
      External Array taCodeLines

      *-- Structur to store properties without comment
      *(versions older then 1.19.77 are without this section, and values with trailing inline)
      *<PropValue>
      *Property = Property_Value
      *Number:
      *prop1 = 0
      *String:
      *prop2 = Number
      *String with leading and trailing space:
      *prop3 =  with spaces
      *String with inline comment:
      *prop4 = with && text
      *Property = Property_Expression (in Property sheet as =....)
      *prop5 = (Expression after =)
      *_memberdata
      *_memberdata = <VFPData> ..
      *</PropValue>

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcPAM_Type
         Local lcProp, lcValue


         If Left( tcLine, C_LEN_DEFINED_PROPVAL_I) == C_DEFINED_PROPVAL_I
            llBloqueEncontrado  = .T.

            With This As c_conversor_prg_a_bin Of c_conversor_prg_a_bin.prg
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Left( tcLine, C_LEN_DEFINED_PROPVAL_F ) == C_DEFINED_PROPVAL_F
                     I = m.I + 1
                     Exit

                  Otherwise
                     .get_SeparatedPropAndValue( tcLine, @lcProp, @lcValue, @toClase, @taCodeLines, tnCodeLines, @m.I )
                     toClase.add_Property( @lcProp, @lcValue, "" )

                  Endcase
               Endfor
            Endwith && THIS

            *-- Junto propiedades y los métodos al final.
            I = m.I - 1
         Endif

      Catch To loEx
         lnCodError  = loEx.ErrorNo

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toClase, tcLine, taCodeLines, tnCodeLines, I
      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_DEFINE_CLASS
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@ IN    ) Objeto del Modulo
      * toClase                   (!@ IN    ) Objeto de la Clase
      * tcLine                    (!@ IN    ) Línea de datos en evaluación
      * taCodeLines               (!@ IN    ) El array con las líneas del código de texto donde buscar
      * I                         (!@ IN    ) Número de línea en evaluación
      * tnCodeLines               (!@ IN    ) Cantidad de líneas de código
      * tcProcedureAbierto        (!v IN    ) Nombre del Procedure abierto
      * taLineasExclusion         (!@ IN    ) Array de líneas de exclusión
      * tnBloquesExclusion        (!@ IN    ) Cantidad de líneas de exclusión
      * tc_Comentario             (!v IN    ) Comentario
      * toFoxBin2Prg              (@? IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toModulo, toClase, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto ;
         , taLineasExclusion, tnBloquesExclusion, tc_Comentario, toFoxBin2Prg

      External Array taCodeLines, tnBloquesExclusion, taLineasExclusion

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toClase As CL_CLASE Of 'cl_clase.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Local llBloqueEncontrado

      *toModulo
      If Upper(Left(tcLine + ' ', 13)) == C_DEFINE_CLASS + ' '
         Try
            llBloqueEncontrado = .T.
            Local Z, lcProp, lcValue, loEx As Exception ;
               , llCLASSMETADATA_Completed, llPROTECTED_Completed, llHIDDEN_Completed, llDEFINED_PAM_Completed ;
               , llINCLUDE_Completed, llCLASS_PROPERTY_Completed, llOBJECTMETADATA_Completed ;
               , llCLASSCOMMENTS_Completed ;
               , loObjeto As CL_OBJETO Of 'cl_objeto.prg' ;
               , loLang As CL_LANG Of 'cl_lang.prg'

            loLang          = _Screen.o_FoxBin2Prg_Lang
            Store '' To tcProcedureAbierto
            toClase                 = NewObject('CL_CLASE','cl_clase.prg')
            toClase._Nombre         = Lower( Alltrim( Strextract( tcLine, 'DEFINE CLASS ', ' AS ', 1, 1 ) ) )
            toClase._ObjName        = Lower( toClase._Nombre )
            toClase._Definicion     = Alltrim( tcLine )
            If Not ' OF ' $ Upper(tcLine)   && Puede no tener "OF libreria.vcx"
               toClase._Class          = Alltrim( Chrtran( Strextract( tcLine + ' OLEPUBLIC', ' AS ', ' OLEPUBLIC', 1, 1 ), ["'], [] ) )
            Else
               toClase._Class          = Alltrim( Chrtran( Strextract( tcLine + ' OF ', ' AS ', ' OF ', 1, 1 ), ["'], [] ) )
            Endif
            toClase._ClassLoc       = Lower( Alltrim( Chrtran( Strextract( tcLine + ' OLEPUBLIC', ' OF ', ' OLEPUBLIC', 1, 1 ), ["'], [] ) ) )
            toClase._OlePublic      = ' OLEPUBLIC' $ Upper(tcLine)
            toClase._Comentario     = tc_Comentario
            toClase._Inicio         = m.I
            toClase._Ini_Cab        = m.I + 1

            toModulo.add_Class( toClase )

            *-- Ubico el objeto ole por su nombre (parent+objname), que no se repite.
            If toModulo.existeObjetoOLE( toClase._Nombre, @m.Z )
               toClase._Ole    = toModulo._Ole_Objs(m.Z)._Value
            Endif

            * Búsqueda del ID de fin de bloque (ENDDEFINE)
            With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
               For I = toClase._Ini_Cab To tnCodeLines
                  tc_Comentario   = ''
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @tcLine, @tc_Comentario )
                     Loop

                  Case .analyzeCodeBlock_PROCEDURE( @toModulo, @toClase, @loObjeto, @tcLine, @taCodeLines, @m.I, @tnCodeLines ;
                        , @tcProcedureAbierto, @tc_Comentario, @taLineasExclusion, @tnBloquesExclusion )
                     *-- OJO: Esta se analiza primero a propósito, solo porque no puede estar detrás de PROTECTED y HIDDEN
                     Store .T. To llCLASSCOMMENTS_Completed ;
                        , llCLASS_PROPERTY_Completed ;
                        , llPROTECTED_Completed ;
                        , llHIDDEN_Completed ;
                        , llINCLUDE_Completed ;
                        , llCLASSMETADATA_Completed ;
                        , llOBJECTMETADATA_Completed ;
                        , llDEFINED_PAM_Completed


                  Case Not llPROTECTED_Completed And .analyzeCodeBlock_PROTECTED( @toClase, @tcLine )
                     llPROTECTED_Completed   = .T.


                  Case Not llHIDDEN_Completed And .analyzeCodeBlock_HIDDEN( @toClase, @tcLine )
                     llHIDDEN_Completed  = .T.


                  Case Not llINCLUDE_Completed And .c_Type <> "SCX" And .analyzeCodeBlock_INCLUDE( @toModulo, @toClase, @tcLine, @taCodeLines ;
                        , @m.I, @tnCodeLines, @tcProcedureAbierto )
                     llINCLUDE_Completed = .T.


                  Case Not llCLASSCOMMENTS_Completed And .analyzeCodeBlock_CLASSCOMMENTS( @toClase, @tcLine ,@taCodeLines, tnCodeLines, @m.I )
                     llCLASSCOMMENTS_Completed   = .T.


                  Case Not llCLASSMETADATA_Completed And .analyzeCodeBlock_CLASSMETADATA( @toClase, @tcLine )
                     llCLASSMETADATA_Completed   = .T.


                  Case Not llOBJECTMETADATA_Completed And .analyzeCodeBlock_OBJECTMETADATA( @toClase, @tcLine )
                     * No se usa flag porque puede haber múltiples ObjectMetadata.


                  Case Not llDEFINED_PAM_Completed And .analyzeCodeBlock_DEFINED_PAM( @toClase, @tcLine, @taCodeLines, tnCodeLines, @m.I )
                     llDEFINED_PAM_Completed = .T.

                  Case Not llCLASS_PROPERTY_Completed And .analyzeCodeBlock_DEFINED_PROPVAL( @toClase, @tcLine, @taCodeLines, tnCodeLines, @m.I )
                     llCLASS_PROPERTY_Completed  = .T.


                  Case .analyzeCodeBlock_ADD_OBJECT( @toModulo, @toClase, @tcLine, @m.I, @taCodeLines, @tnCodeLines, @toFoxBin2Prg )
                     Store .T. To llCLASSCOMMENTS_Completed ;
                        , llCLASS_PROPERTY_Completed ;
                        , llPROTECTED_Completed ;
                        , llHIDDEN_Completed ;
                        , llINCLUDE_Completed ;
                        , llCLASSMETADATA_Completed ;
                        , llOBJECTMETADATA_Completed ;
                        , llDEFINED_PAM_Completed


                  Case .analyzeCodeBlock_ENDDEFINE( @toClase, @tcLine, @m.I, @tcProcedureAbierto )
                     Exit


                  Case Not llCLASS_PROPERTY_Completed And Empty( toClase._Fin_Cab )
                     *-- Propiedades de la CLASE
                     *--
                     *-- NOTA: Las propiedades se agregan tal cual, incluso aunque estén separadas en
                     *--       varias líneas (memberdata y fb2p_value), ya que luego se ensamblan en classProps2Memo().
                     *
                     .get_SeparatedPropAndValue( tcLine, @lcProp, @lcValue, @toClase, @taCodeLines, tnCodeLines, @m.I )
                     toClase.add_Property( @lcProp, @lcValue, Rtrim(tc_Comentario) )


                  Otherwise
                     *-- Las líneas que pasan por aquí deberían estar vacías y ser de relleno del embellecimiento

                  Endcase

               Endfor

               *-- Validación
               If Empty( toClase._Fin )
                  *ERROR 'No se ha encontrado el marcador de fin [ENDDEFINE] ' ;
                  + 'que cierra al marcador de inicio [DEFINE CLASS] ' ;
                  + 'de la línea ' + TRANSFORM( toClase._Inicio ) + ' ' ;
                  + 'para el identificador [' + toClase._Nombre + ']'
                  Error (Textmerge(loLang.C_ENDDEFINE_MARKER_NOT_FOUND_LOC))
               Endif

               toClase._PROPERTIES     = .classProps2Memo( @toClase, @toFoxBin2Prg )
               toClase._PROTECTED      = .hiddenAndProtected_PAM( @toClase )
               toClase._METHODS        = .classMethods2Memo( @toClase )
               toClase._RESERVED1      = Iif( .c_Type = 'SCX', '', 'Class' )
               toClase._RESERVED2      = Iif( .c_Type = 'VCX' Or Proper(toClase._Class) == 'Dataenvironment', Transform( toClase._AddObject_Count + 1 ), '' )
               toClase._RESERVED3      = .defined_PAM2Memo( @toClase )
               toClase._RESERVED4      = toClase._ClassIcon
               toClase._RESERVED5      = toClase._ProjectClassIcon
               toClase._RESERVED6      = toClase._Scale
               toClase._RESERVED7      = toClase._Comentario
               toClase._RESERVED8      = toClase._includeFile
            Endwith && THIS

         Catch To loEx
            If This.n_Debug > 0 And _vfp.StartMode = 0
               Set Step On
            Endif

            Throw

         Finally
            Release toModulo, toClase, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto ;
               , taLineasExclusion, tnBloquesExclusion, tc_Comentario, Z, lcProp, lcValue, loEx ;
               , llCLASSMETADATA_Completed, llPROTECTED_Completed, llHIDDEN_Completed, llDEFINED_PAM_Completed ;
               , llINCLUDE_Completed, llCLASS_PROPERTY_Completed, llOBJECTMETADATA_Completed ;
               , llCLASSCOMMENTS_Completed, loObjeto
         Endtry
      Endif

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_ENDDEFINE
      Lparameters toClase, tcLine, I, tcProcedureAbierto

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local llBloqueEncontrado

      If Upper( Left( tcLine + ' ', 10 ) ) == C_ENDDEFINE + ' '   && Fin de bloque (ENDDEF / ENDPROC) encontrado
         llBloqueEncontrado  = .T.
         toClase._Fin        = m.I

         If Empty( toClase._Ini_Cuerpo )
            toClase._Ini_Cuerpo = m.I-1
         Endif

         toClase._Fin_Cuerpo = m.I-1

         If Empty( toClase._Fin_Cab )
            toClase._Fin_Cab    = m.I-1
         Endif

         Store '' To tcProcedureAbierto
      Endif

      Release toClase, tcLine, I, tcProcedureAbierto
      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_HIDDEN
      Lparameters toClase, tcLine

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local llBloqueEncontrado

      If Upper(Left(tcLine, 7)) == 'HIDDEN '
         llBloqueEncontrado  = .T.
         * LScheffler 20221201. reset to original state of #87
         *t-zuidema, 2022/11/25
         *old
         toClase._HiddenProps        = Lower( Alltrim( Substr( tcLine, 8 ) ) )
         *new of t-zuidema
         *           toClase._HiddenProps        = Alltrim( Substr( tcLine, 8 ) )
         */t-zuidema, 2022/11/25
         */LScheffler 20221201
      Endif

      Release toClase, tcLine
      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_INCLUDE
      Lparameters toModulo, toClase, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto
      External Array taCodeLines
      Local llBloqueEncontrado

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      If Upper(Left(tcLine, 9)) == '#INCLUDE '
         llBloqueEncontrado      = .T.
         If This.c_Type = 'SCX'
            toModulo._includeFile   = Lower( Alltrim( Chrtran( Substr( tcLine, 10 ), ["'], [] ) ) )
         Else
            toClase._includeFile    = Lower( Alltrim( Chrtran( Substr( tcLine, 10 ), ["'], [] ) ) )
         Endif
      Endif

      Release toModulo, toClase, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto
      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_CLASSCOMMENTS
      Lparameters toClase, tcLine ,taCodeLines, tnCodeLines, I

      External Array taCodeLines

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Try
         Local llBloqueEncontrado

         If Left( tcLine, C_LEN_CLASSCOMMENTS_I ) == C_CLASSCOMMENTS_I
            llBloqueEncontrado  = .T.
            toClase._Comentario = ''

            With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Left( tcLine, C_LEN_CLASSCOMMENTS_F ) == C_CLASSCOMMENTS_F
                     I = m.I + 1
                     Exit

                  Otherwise
                     toClase._Comentario = toClase._Comentario + CR_LF + Substr( tcLine, 2 ) && Le quito el '*' inicial
                  Endcase
               Endfor
            Endwith && THIS

            I = m.I - 1

            If Not Empty(toClase._Comentario)
               toClase._Comentario = Substr( toClase._Comentario, 3 ) + CR_LF  && Quito el primer CR+LF
            Endif
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toClase, tcLine ,taCodeLines, tnCodeLines, I
      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_CLASSMETADATA
      Lparameters toClase, tcLine

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local llBloqueEncontrado

      If Upper(Left(tcLine, C_LEN_CLASSDATA_I)) == C_CLASSDATA_I  && METADATA de la CLASE
         *< CLASSDATA: Baseclass="custom" Timestamp="2013/11/19 11:51:04" Scale="Foxels" Uniqueid="_3WF0VSTN1" ProjectClassIcon="container.ico" ClassIcon="toolbar.ico" />
         Local laPropsAndValues(1,2), lnPropsAndValues_Count
         llBloqueEncontrado  = .T.
         With This
            .get_ListNamesWithValuesFrom_InLine_MetadataTag( @tcLine, @laPropsAndValues, @lnPropsAndValues_Count, C_CLASSDATA_I, C_CLASSDATA_F )

            toClase._BaseClass          = .get_ValueByName_FromListNamesWithValues( 'BaseClass', 'C', @laPropsAndValues )
            toClase._TimeStamp          = Int( .rowTimeStamp(  .get_ValueByName_FromListNamesWithValues( 'TimeStamp', 'T', @laPropsAndValues ) ) )
            toClase._Scale              = .get_ValueByName_FromListNamesWithValues( 'Scale', 'C', @laPropsAndValues )
            toClase._UniqueID           = .get_ValueByName_FromListNamesWithValues( 'UniqueID', 'C', @laPropsAndValues )
            toClase._ProjectClassIcon   = .get_ValueByName_FromListNamesWithValues( 'ProjectClassIcon', 'C', @laPropsAndValues )
            toClase._ClassIcon          = .get_ValueByName_FromListNamesWithValues( 'ClassIcon', 'C', @laPropsAndValues )
            toClase._Ole2               = .get_ValueByName_FromListNamesWithValues( 'OLEObject', 'C', @laPropsAndValues )
            If Empty(toClase._Ole)
               toClase._Ole                = Strconv( .get_ValueByName_FromListNamesWithValues( 'Value', 'C', @laPropsAndValues ), 14 )
            Endif
         Endwith && THIS

         If Not Empty( toClase._Ole2 )   && Le agrego "OLEObject = " delante
            toClase._Ole2   = 'OLEObject = ' + toClase._Ole2 + CR_LF
         Endif
      Endif

      Release toClase, tcLine, laPropsAndValues, lnPropsAndValues_Count
      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_EXTERNAL_CLASS
      *------------------------------------------------------
      *-- Analiza el bloque *< EXTERNAL_CLASS: Name="nombre-clase" Baseclass="clase-base" />
      *------------------------------------------------------
      Lparameters toModulo, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
      #Endif

      Local llBloqueEncontrado

      If Upper(Left(tcLine, C_LEN_EXTERNAL_CLASS_I)) == C_EXTERNAL_CLASS_I
         Local laPropsAndValues(1,2), lnPropsAndValues_Count
         llBloqueEncontrado  = .T.

         With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
            .get_ListNamesWithValuesFrom_InLine_MetadataTag( @tcLine, @laPropsAndValues, @lnPropsAndValues_Count, C_EXTERNAL_CLASS_I, C_EXTERNAL_CLASS_F )

            toModulo._ExternalClasses_Count     = toModulo._ExternalClasses_Count + 1
            Dimension toModulo._ExternalClasses( toModulo._ExternalClasses_Count, 2 )
            toModulo._ExternalClasses( toModulo._ExternalClasses_Count, 1 ) = .get_ValueByName_FromListNamesWithValues( 'Name', 'C', @laPropsAndValues )
            toModulo._ExternalClasses( toModulo._ExternalClasses_Count, 2 ) = .get_ValueByName_FromListNamesWithValues( 'Baseclass', 'C', @laPropsAndValues ) ;
               + '.' + toModulo._ExternalClasses( toModulo._ExternalClasses_Count, 1 )
         Endwith && THIS
      Endif

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_EXTERNAL_MEMBER
      *------------------------------------------------------
      *-- Analiza el bloque *< EXTERNAL_MEMBER: Name="nombre-miembro" Type="tipo-de-miembro" />
      *------------------------------------------------------
      Lparameters toDatabase, tcLine, taCodeLines, I, tnCodeLines
      External Array taCodeLines

      #If .F.
         Local toDatabase As CL_DBC Of 'cl_dbc.prg'
      #Endif

      Local llBloqueEncontrado

      If Upper(Left(tcLine, C_LEN_EXTERNAL_MEMBER_I)) == C_EXTERNAL_MEMBER_I
         Local laPropsAndValues(1,2), lnPropsAndValues_Count
         llBloqueEncontrado  = .T.

         With This
            .get_ListNamesWithValuesFrom_InLine_MetadataTag( @tcLine, @laPropsAndValues, @lnPropsAndValues_Count, C_EXTERNAL_MEMBER_I, C_EXTERNAL_MEMBER_F )

            toDatabase._ExternalClasses_Count       = toDatabase._ExternalClasses_Count + 1
            Dimension toDatabase._ExternalClasses( toDatabase._ExternalClasses_Count, 2 )
            toDatabase._ExternalClasses( toDatabase._ExternalClasses_Count, 1 ) = .get_ValueByName_FromListNamesWithValues( 'Type', 'C', @laPropsAndValues ) ;
               + '.' + .get_ValueByName_FromListNamesWithValues( 'Name', 'C', @laPropsAndValues )
            *toDatabase._ExternalClasses( toDatabase._ExternalClasses_Count, 2 )    = .get_ValueByName_FromListNamesWithValues( 'Type', 'C', @laPropsAndValues )
         Endwith && THIS
      Endif

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_OBJECTMETADATA
      Lparameters toClase, tcLine

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local llBloqueEncontrado

      If Upper(Left(tcLine, C_LEN_OBJECTDATA_I)) == C_OBJECTDATA_I    && METADATA del ADD OBJECT
         *< OBJECTDATA: ObjName="txtValor" Timestamp="2013/11/19 11:51:04" Uniqueid="_3WF0VSTN1" />
         Local laPropsAndValues(1,2), lnPropsAndValues_Count, loObjeto As CL_OBJETO Of 'cl_objeto.prg'
         llBloqueEncontrado  = .T.
         toClase.l_ObjectMetadataInHeader = .T.

         loObjeto    = .Null.
         loObjeto    = NewObject('CL_OBJETO', 'cl_objeto.prg')
         toClase.add_Object( loObjeto )

         With This
            .get_ListNamesWithValuesFrom_InLine_MetadataTag( @tcLine, @laPropsAndValues, @lnPropsAndValues_Count, C_OBJECTDATA_I, C_OBJECTDATA_F )
            loObjeto._Nombre            = .get_ValueByName_FromListNamesWithValues( 'ObjPath', 'C', @laPropsAndValues )
            loObjeto._TimeStamp         = Int( .rowTimeStamp(  .get_ValueByName_FromListNamesWithValues( 'TimeStamp', 'T', @laPropsAndValues ) ) )
            loObjeto._UniqueID          = .get_ValueByName_FromListNamesWithValues( 'UniqueID', 'C', @laPropsAndValues )
         Endwith && THIS

         loObjeto    = .Null.
         Release toClase, tcLine, laPropsAndValues, lnPropsAndValues_Count, loObjeto
      Endif

      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_OLE_DEF
      Lparameters toModulo, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto
      External Array taCodeLines
      Local llBloqueEncontrado

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
      #Endif

      If Left( tcLine + ' ', C_LEN_OLE_I + 1 ) == C_OLE_I + ' '
         llBloqueEncontrado  = .T.
         *-- Se encontró una definición de objeto OLE
         *< OLE: Nombre="frm_d.ole_ImageControl2" parent="frm_d" objname="ole_ImageControl2" checksum="4171274922" value="b64-value" />
         Local laPropsAndValues(1,2), lnPropsAndValues_Count ;
            , loOle As CL_OLE Of 'cl_ole.prg'
         loOle           = .Null.
         loOle           = NewObject('CL_OLE', 'cl_ole.prg')

         With This
            .get_ListNamesWithValuesFrom_InLine_MetadataTag( @tcLine, @laPropsAndValues, @lnPropsAndValues_Count, C_OLE_I, C_OLE_F )

            loOle._Nombre       = .get_ValueByName_FromListNamesWithValues( 'Nombre', 'C', @laPropsAndValues )
            loOle._Parent       = .get_ValueByName_FromListNamesWithValues( 'Parent', 'C', @laPropsAndValues )
            loOle._ObjName      = .get_ValueByName_FromListNamesWithValues( 'ObjName', 'C', @laPropsAndValues )
            loOle._CheckSum     = .get_ValueByName_FromListNamesWithValues( 'CheckSum', 'C', @laPropsAndValues )
            loOle._Value        = Strconv( .get_ValueByName_FromListNamesWithValues( 'Value', 'C', @laPropsAndValues ), 14 )
         Endwith

         toModulo.add_OLE( loOle )

         If Empty( loOle._Value )
            *-- Si el objeto OLE no tiene VALUE, es porque hay otro con el mismo contenido y no se duplicó para preservar espacio.
            *-- Busco el VALUE del duplicado que se guardó y lo asigno nuevamente
            For Z = 1 To toModulo._Ole_Obj_count - 1
               If toModulo._Ole_Objs(m.Z)._CheckSum == loOle._CheckSum And Not Empty( toModulo._Ole_Objs(m.Z)._Value )
                  loOle._Value    = toModulo._Ole_Objs(m.Z)._Value
                  Exit
               Endif
            Endfor
         Endif

         loOle   = .Null.
         Release loOle, laPropsAndValues, lnPropsAndValues_Count
      Endif

      Release toModulo, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto
      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_PROCEDURE
      Lparameters toModulo, toClase, toObjeto, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto ;
         , tc_Comentario, taLineasExclusion, tnBloquesExclusion
      External Array taCodeLines

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toObjeto As CL_OBJETO Of 'cl_objeto.prg'
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local llBloqueEncontrado

      With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
         Do Case
         Case Upper( Left( tcLine, 20 ) ) == 'PROTECTED PROCEDURE '
            *-- Estructura a reconocer: PROTECTED PROCEDURE nombre_del_procedimiento
            llBloqueEncontrado  = .T.
            tcProcedureAbierto  = Alltrim( Substr( tcLine, 21 ) )
            .getClassMethodComment( @tcProcedureAbierto, @tc_Comentario )
            .evaluateProcedureDefinition( @toClase, m.I, @tc_Comentario, tcProcedureAbierto, 'protected', @toObjeto )


         Case Upper( Left( tcLine, 17 ) ) == 'HIDDEN PROCEDURE '
            *-- Estructura a reconocer: HIDDEN PROCEDURE nombre_del_procedimiento
            llBloqueEncontrado  = .T.
            tcProcedureAbierto  = Alltrim( Substr( tcLine, 18 ) )
            .getClassMethodComment( @tcProcedureAbierto, @tc_Comentario )
            .evaluateProcedureDefinition( @toClase, m.I, @tc_Comentario, tcProcedureAbierto, 'hidden', @toObjeto )

         Case Upper( Left( tcLine, 10 ) ) == 'PROCEDURE '
            *-- Estructura a reconocer: PROCEDURE [objeto.]nombre_del_procedimiento
            llBloqueEncontrado  = .T.
            tcProcedureAbierto  = Alltrim( Substr( tcLine, 11 ) )
            .getClassMethodComment( @tcProcedureAbierto, @tc_Comentario )
            .evaluateProcedureDefinition( @toClase, m.I, @tc_Comentario, tcProcedureAbierto, 'normal', @toObjeto )

         Case Upper( Left( tcLine, 19 ) ) == 'PROTECTED FUNCTION '
            *-- Estructura a reconocer: PROTECTED PROCEDURE nombre_del_procedimiento
            llBloqueEncontrado  = .T.
            tcProcedureAbierto  = Alltrim( Substr( tcLine, 20 ) )
            .getClassMethodComment( @tcProcedureAbierto, @tc_Comentario )
            .evaluateProcedureDefinition( @toClase, m.I, @tc_Comentario, tcProcedureAbierto, 'protected', @toObjeto )


         Case Upper( Left( tcLine, 16 ) ) == 'HIDDEN FUNCTION '
            *-- Estructura a reconocer: HIDDEN FUNCTION nombre_del_procedimiento
            llBloqueEncontrado  = .T.
            tcProcedureAbierto  = Alltrim( Substr( tcLine, 17 ) )
            .getClassMethodComment( @tcProcedureAbierto, @tc_Comentario )
            .evaluateProcedureDefinition( @toClase, m.I, @tc_Comentario, tcProcedureAbierto, 'hidden', @toObjeto )

         Case Upper( Left( tcLine, 9 ) ) == 'FUNCTION '
            *-- Estructura a reconocer: FUNCTION [objeto.]nombre_del_procedimiento
            llBloqueEncontrado  = .T.
            tcProcedureAbierto  = Alltrim( Substr( tcLine, 10 ) )
            .getClassMethodComment( @tcProcedureAbierto, @tc_Comentario )
            .evaluateProcedureDefinition( @toClase, m.I, @tc_Comentario, tcProcedureAbierto, 'normal', @toObjeto )

         Endcase

         If llBloqueEncontrado
            *-- Evalúo todo el contenido del PROCEDURE
            .updateProgressbar( 'Analyzing Procedure ' + toClase._Nombre + '.' + tcProcedureAbierto + '...', m.I, tnCodeLines, 1 )
            .analyzeProcedureLines( @toClase, @toObjeto, @tcLine, @taCodeLines, @m.I, @tnCodeLines, @tcProcedureAbierto ;
               , @tc_Comentario, @taLineasExclusion, @tnBloquesExclusion )
         Endif
      Endwith

      Release toModulo, toClase, toObjeto, tcLine, taCodeLines, I, tnCodeLines, tcProcedureAbierto ;
         , tc_Comentario, taLineasExclusion, tnBloquesExclusion
      Return llBloqueEncontrado
   Endproc


   Procedure analyzeCodeBlock_PROTECTED
      Lparameters toClase, tcLine

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Local llBloqueEncontrado

      If Upper(Left(tcLine, 10)) == 'PROTECTED '
         llBloqueEncontrado  = .T.
         toClase._ProtectedProps     = Lower( Alltrim( Substr( tcLine, 11 ) ) )
      Endif

      Release toClase, tcLine
      Return llBloqueEncontrado
   Endproc


   Procedure evaluateProcedureDefinition
      Lparameters toClase, I, tc_Comentario, tcProcName, tcProcType, toObjeto
      *--------------------------------------------------------------------------------------------------------------
      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg' ;
            , toObjeto As CL_OBJETO Of 'cl_objeto.prg'
      #Endif

      Try
         Local lcNombreObjeto, lnObjProc ;
            , loProcedure As CL_PROCEDURE Of 'cl_procedure.prg'

         If Empty(toClase._Fin_Cab)
            toClase._Fin_Cab    = m.I-1
            toClase._Ini_Cuerpo = m.I
         Endif

         loProcedure     = .Null.
         loProcedure     = NewObject('CL_PROCEDURE', 'cl_procedure.prg')
         loProcedure._Nombre         = tcProcName
         loProcedure._ProcType       = tcProcType
         loProcedure._Comentario     = tc_Comentario
         loProcedure._Inicio         = m.I

         *-- Anoto en HiddenMethods y ProtectedMethods según corresponda
         Do Case
         Case loProcedure._ProcType == 'hidden'
            toClase._HiddenMethods  = toClase._HiddenMethods + ',' + tcProcName

         Case loProcedure._ProcType == 'protected'
            toClase._ProtectedMethods   = toClase._ProtectedMethods + ',' + tcProcName

         Endcase

         *-- Agrego el objeto Procedimiento a la clase, o a un objeto de la clase.
         If '.' $ tcProcName
            *-- Procedimiento de objeto
            lcNombreObjeto  = Lower( Juststem( tcProcName ) )

            *-- Busco el objeto al que corresponde el método
            lnObjProc   = This.findMethodsObjectByName( lcNombreObjeto, toClase )

            If lnObjProc = 0
               *-- Procedimiento de clase
               toClase.add_Procedure( loProcedure )
               toObjeto    = .Null.
            Else
               *-- Procedimiento de objeto
               toObjeto    = toClase._AddObjects( lnObjProc )
               toObjeto.add_Procedure( loProcedure )

               *-- Paso el log de errores
               If Not Empty(toObjeto.c_TextErr) Then
                  toClase.writeErrorLog(toObjeto.c_TextErr)
                  toObjeto.c_TextErr  = ''
               Endif
            Endif
         Else
            *-- Procedimiento de clase
            toClase.add_Procedure( loProcedure )
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loProcedure
         Release loProcedure, I, lcNombreObjeto, lnObjProc ;
            , toClase, tc_Comentario, tcProcName, tcProcType, toObjeto
      Endtry

      Return
   Endproc


   Procedure identifyCodeBlocks
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (@! IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (@! IN    ) Cantidad de líneas de código
      * taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@! IN    ) Cantidad de bloques de exclusión
      * toModulo                  (@?    OUT) Objeto con toda la información del módulo analizado
      * toFoxBin2Prg              (@? IN    ) Referencia al objeto principal
      *
      * NOTA:
      * Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
      *--------------------------------------------------------------------------------------------------------------
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toModulo, toFoxBin2Prg

      External Array taCodeLines, taLineasExclusion

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, loEx As Exception ;
            , llFoxBin2Prg_Completed, llOLE_DEF_Completed, llINCLUDE_SCX_Completed, llLIBCOMMENT_Completed, llEXTERNAL_CLASS_Completed ;
            , lc_Comentario, lcProcedureAbierto, lcLine ;
            , loClase As CL_CLASE Of 'cl_clase.prg'

         With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
            Store '' To lcProcedureAbierto

            .c_Type = Upper(Justext(.c_OutputFile))

            If tnCodeLines > 1

               *-- Búsqueda del ID de inicio de bloque (DEFINE CLASS / PROCEDURE)
               For I = 1 To tnCodeLines
                  Store '' To lc_Comentario
                  .set_Line( @lcLine, @taCodeLines, m.I )

                  Do Case
                  Case .excludedLine( m.I, tnBloquesExclusion, @taLineasExclusion ) ;
                        OR .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Excluida, vacía o solo Comentarios

                  Case .analyzeCodeBlock_DEFINE_CLASS( @toModulo, @loClase, @lcLine, @taCodeLines, @m.I, tnCodeLines ;
                        , @lcProcedureAbierto, @taLineasExclusion, @tnBloquesExclusion, @lc_Comentario, @toFoxBin2Prg )
                     *-- Puede haber varias clases definidas
                     *   llEXTERNAL_CLASS_Completed  = .T.

                     *-- Logueo los errores
                     If Not Empty(loClase.c_TextErr) Then
                        .writeErrorLog( loClase.c_TextErr )
                     Endif
                  Endcase

               Endfor

               .verify_EXTERNAL_CLASSES( @toModulo, @toFoxBin2Prg )

            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loClase
         Release loClase, I ;
            , llFoxBin2Prg_Completed, llOLE_DEF_Completed, llINCLUDE_SCX_Completed, llLIBCOMMENT_Completed ;
            , lc_Comentario, lcProcedureAbierto, lcLine
      Endtry

      Return
   Endproc


   Procedure identifyHeaderBlocks
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (@! IN    ) El array con las líneas del código donde buscar
      * tnCodeLines               (@! IN    ) Cantidad de líneas de código
      * taLineasExclusion         (@! IN    ) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@! IN    ) Cantidad de bloques de exclusión
      * toModulo                  (@?    OUT) Objeto con toda la información del módulo analizado
      * toFoxBin2Prg              (@? IN    ) Referencia al objeto principal
      *
      * NOTA:
      * Como identificador se usa el nombre de clase o de procedimiento, según corresponda.
      *--------------------------------------------------------------------------------------------------------------
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toModulo, toFoxBin2Prg

      External Array taCodeLines, taLineasExclusion

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, loEx As Exception ;
            , llFoxBin2Prg_Completed, llOLE_DEF_Completed, llINCLUDE_SCX_Completed, llLIBCOMMENT_Completed, llEXTERNAL_CLASS_Completed ;
            , lc_Comentario, lcProcedureAbierto, lcLine, lcExtension ;
            , loClase As CL_CLASE Of 'cl_clase.prg',;
            ln_UseXPerFile,;
            ll_RedirectXPerFileToMain

         With This As c_conversor_prg_a_bin Of 'c_conversor_prg_a_bin.prg'
            Store '' To lcProcedureAbierto

            .c_Type = Upper(Justext(.c_OutputFile))

            If tnCodeLines > 1

               lcExtension     = Upper( Justext(toFoxBin2Prg.c_InputFile) )
               Do Case
               Case Inlist(lcExtension,"SCX",toFoxBin2Prg.getCfgValue('c_SC2'))
                  ln_UseXPerFile            = toFoxBin2Prg.getCfgValue('n_UseFormPerFile')
                  ll_RedirectXPerFileToMain = toFoxBin2Prg.getCfgValue('l_RedirectFormPerFileToMain')
               Case Inlist(lcExtension,"DBC",toFoxBin2Prg.getCfgValue('c_DB2'))
                  ln_UseXPerFile            = toFoxBin2Prg.getCfgValue('n_UseFilesPerDBC')
                  ll_RedirectXPerFileToMain = toFoxBin2Prg.getCfgValue('l_RedirectFilePerDBCToMain')
               Otherwise
                  ln_UseXPerFile            = toFoxBin2Prg.getCfgValue('n_UseClassPerFile')
                  ll_RedirectXPerFileToMain = toFoxBin2Prg.getCfgValue('l_RedirectClassPerFileToMain')

               Endcase

               If !( ln_UseXPerFile > 0 And ll_RedirectXPerFileToMain)
                  llEXTERNAL_CLASS_Completed  = .T.
               Endif

               *-- Búsqueda del ID de inicio de bloque (DEFINE CLASS / PROCEDURE)
               For I = 1 To tnCodeLines
                  Store '' To lc_Comentario
                  .set_Line( @lcLine, @taCodeLines, m.I )

                  Do Case
                  Case .lineIsOnlyCommentAndNoMetadata( @lcLine, @lc_Comentario ) && Excluida, vacía o solo Comentarios

                  Case Not llFoxBin2Prg_Completed And .analyzeCodeBlock_FoxBin2Prg( @toModulo, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     llFoxBin2Prg_Completed  = .T.

                  Case Not llEXTERNAL_CLASS_Completed And .analyzeCodeBlock_EXTERNAL_CLASS( @toModulo, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     *-- Puede haber varias clases externas

                  Case Not llLIBCOMMENT_Completed And .analyzeCodeBlock_LIBCOMMENT( @toModulo, @lcLine, @taCodeLines, @m.I, tnCodeLines )
                     llLIBCOMMENT_Completed  = .T.
                     llEXTERNAL_CLASS_Completed  = .T.

                  Case Not llOLE_DEF_Completed And .analyzeCodeBlock_OLE_DEF( @toModulo, @lcLine, @taCodeLines ;
                        , @m.I, tnCodeLines, @lcProcedureAbierto )
                     *-- Puede haber varios objetos OLE

                  Case Not llINCLUDE_SCX_Completed And .c_Type = 'SCX' And .analyzeCodeBlock_INCLUDE( @toModulo, @loClase, @lcLine ;
                        , @taCodeLines, @m.I, tnCodeLines, @lcProcedureAbierto )
                     * Específico para SCX que lo tiene al inicio
                     llINCLUDE_SCX_Completed = .T.
                     llEXTERNAL_CLASS_Completed  = .T.

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
         Release taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toModulo, loClase, I ;
            , llFoxBin2Prg_Completed, llOLE_DEF_Completed, llINCLUDE_SCX_Completed, llLIBCOMMENT_Completed ;
            , lc_Comentario, lcProcedureAbierto, lcLine
      Endtry

      Return
   Endproc


   Procedure verify_EXTERNAL_CLASSES
      *--------------------------------------------------------------------------------
      *-- Compara las clases definidas en la cabecera con las clases encontradas luego
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (@?    OUT) Objeto con toda la información del módulo analizado
      * toFoxBin2Prg              (@? IN    ) Referencia al objeto principal
      *--------------------------------------------------------------------------------------------------------------
      Lparameters toModulo, toFoxBin2Prg

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Local lnItem, I, X, lcClaseExterna, lcExtension
      Local loLang As CL_LANG Of 'cl_lang.prg',;
         lcExtension,;
         ln_UseXPerFile,;
         ll_RedirectXPerFileToMain,;
         l_XPerFileCheck

      loLang          = _Screen.o_FoxBin2Prg_Lang

      lcExtension     = Upper( Justext(toFoxBin2Prg.c_InputFile) )

      Do Case
      Case Inlist(lcExtension,"SCX",toFoxBin2Prg.getCfgValue('c_SC2'))
         ln_UseXPerFile   = toFoxBin2Prg.getCfgValue('n_UseFormPerFile')
         ll_XPerFileCheck = toFoxBin2Prg.getCfgValue('l_FormPerFileCheck')
      Case Inlist(lcExtension,"DBC",toFoxBin2Prg.getCfgValue('c_DB2'))
         ln_UseXPerFile   = toFoxBin2Prg.getCfgValue('n_UseFilesPerDBC')
         ll_XPerFileCheck = toFoxBin2Prg.ItemPerDBCCheck
      Otherwise
         ln_UseXPerFile   = toFoxBin2Prg.getCfgValue('n_UseClassPerFile')
         ll_XPerFileCheck = toFoxBin2Prg.getCfgValue('l_ClassPerFileCheck')

      Endcase

      *-- Verificación de las Clases, si son Externas y se indicó chequearlas
      Do Case
      Case ln_UseXPerFile = 1 And ll_XPerFileCheck And Empty(toFoxBin2Prg.c_ClassOperationType)
         *-- El ClassPerFile original, con nomenclatura 'Libreria.NombreClase.vc2'
         For I = 1 To toModulo._ExternalClasses_Count
            lnItem  = 0

            For X = 1 To toModulo._Clases_Count
               If Lower( toModulo._Clases(m.X)._ObjName ) == Lower( toModulo._ExternalClasses(m.I,1) )
                  lnItem  = m.X
                  Exit
               Endif
            Endfor

            If lnItem = 0 Then
               lcClaseExterna  = Forcepath( Juststem(toFoxBin2Prg.c_InputFile) + '.' + toModulo._ExternalClasses(m.I,1) + '.' + Justext(toFoxBin2Prg.c_InputFile), Justpath(toFoxBin2Prg.c_InputFile) )
               *ERROR 'No se ha encontrado la clase externa [' + toModulo._ExternalClasses(m.I,1) + '] en el archivo [' + toFoxBin2Prg.c_InputFile + ']'
               Error ( loLang.C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC + ' [' + lcClaseExterna + ']' )
            Endif

            toModulo._Clases(lnItem)._Checked = .T.
         Endfor

      Case ln_UseXPerFile = 2 And ll_XPerFileCheck And Empty(toFoxBin2Prg.c_ClassOperationType)
         *-- El nuevo ClassPerFile, con nomenclatura 'Libreria.ClaseBase.NombreClase.vc2'
         For I = 1 To toModulo._ExternalClasses_Count
            lnItem  = 0

            For X = 1 To toModulo._Clases_Count
               If Lower( toModulo._Clases(m.X)._BaseClass + '.' + toModulo._Clases(m.X)._ObjName ) == Lower( toModulo._ExternalClasses(m.I,2) )
                  lnItem  = m.X
                  Exit
               Endif
            Endfor

            If lnItem = 0 Then
               lcClaseExterna  = Forcepath( Juststem(toFoxBin2Prg.c_InputFile) + '.' + toModulo._ExternalClasses(m.I,1) + '.' + Justext(toFoxBin2Prg.c_InputFile), Justpath(toFoxBin2Prg.c_InputFile) )
               *ERROR 'No se ha encontrado la clase externa [' + toModulo._ExternalClasses(m.I,1) + '] en el archivo [' + toFoxBin2Prg.c_InputFile + ']'
               Error ( loLang.C_EXTERNAL_CLASS_NAME_WAS_NOT_FOUND_LOC + ' [' + lcClaseExterna + ']' )
            Endif

            toModulo._Clases(lnItem)._Checked = .T.
         Endfor

      Endcase
   Endproc

Enddefine
