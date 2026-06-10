
#INCLUDE foxbin2prg.h

Define Class c_conversor_base As Custom
   #If .F.
      Local This As c_conversor_base Of 'c_conversor_base.prg'
   #Endif
   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzeassignmentof_tag" display="analyzeAssignmentOf_TAG"/>] ;
      + [<memberdata name="updateprogressbar" display="updateProgressbar"/>] ;
      + [<memberdata name="a_specialprops" display="a_SpecialProps"/>] ;
      + [<memberdata name="findmethodsobjectbyname" display="findMethodsObjectByName"/>] ;
      + [<memberdata name="verifyvalidexpression" display="verifyValidExpression"/>] ;
      + [<memberdata name="convert" display="convert"/>] ;
      + [<memberdata name="currentlineispreviouslinecontinuation" display="currentLineIsPreviousLineContinuation"/>] ;
      + [<memberdata name="decode_specialcodes_1_31" display="decode_SpecialCodes_1_31"/>] ;
      + [<memberdata name="decode_specialcodes_cr_lf" display="decode_SpecialCodes_CR_LF"/>] ;
      + [<memberdata name="denormalizeassignment" display="denormalizeAssignment"/>] ;
      + [<memberdata name="denormalizepropertyvalue" display="denormalizePropertyValue"/>] ;
      + [<memberdata name="denormalizexmlvalue" display="denormalizeXMLValue"/>] ;
      + [<memberdata name="isindicatedtoken" display="isIndicatedToken"/>] ;
      + [<memberdata name="encode_specialcodes_1_31" display="encode_SpecialCodes_1_31"/>] ;
      + [<memberdata name="encode_specialcodes_cr_lf" display="encode_SpecialCodes_CR_LF"/>] ;
      + [<memberdata name="exception2str" display="exception2Str"/>] ;
      + [<memberdata name="filetypecode" display="fileTypeCode"/>] ;
      + [<memberdata name="get_listnameswithvaluesfrom_inline_metadatatag" display="get_ListNamesWithValuesFrom_InLine_MetadataTag"/>] ;
      + [<memberdata name="get_separatedlineandcomment" display="get_SeparatedLineAndComment"/>] ;
      + [<memberdata name="get_separatedpropandvalue" display="get_SeparatedPropAndValue"/>] ;
      + [<memberdata name="get_textfilenames" display="get_TextFileNames"/>] ;
      + [<memberdata name="get_valuefromnullterminatedvalue" display="get_ValueFromNullTerminatedValue"/>] ;
      + [<memberdata name="identifyexclusionblocks" display="identifyExclusionBlocks"/>] ;
      + [<memberdata name="lineisonlycommentandnometadata" display="lineIsOnlyCommentAndNoMetadata"/>] ;
      + [<memberdata name="loadmodule" display="loadModule"/>] ;
      + [<memberdata name="normalizeassignment" display="normalizeAssignment"/>] ;
      + [<memberdata name="normalizepropertyvalue" display="normalizePropertyValue"/>] ;
      + [<memberdata name="normalizexmlvalue" display="normalizeXMLValue"/>] ;
      + [<memberdata name="set_uservalue" display="set_UserValue"/>] ;
      + [<memberdata name="sortpropsandvalues" display="sortPropsAndValues"/>] ;
      + [<memberdata name="sortspecialprops" display="sortSpecialProps"/>] ;
      + [<memberdata name="sortpropsandvalues_setandgetscxpropnames" type="method" display="sortPropsAndValues_SetAndGetSCXPropNames"/>] ;
      + [<memberdata name="writelog" display="writeLog"/>] ;
      + [<memberdata name="writeerrorlog" display="writeErrorLog"/>] ;
      + [<memberdata name="c_claseactual" display="c_ClaseActual"/>] ;
      + [<memberdata name="c_curdir" display="c_CurDir"/>] ;
      + [<memberdata name="c_foxbin2prg_fullpath" display="c_Foxbin2prg_FullPath"/>] ;
      + [<memberdata name="c_inputfile" display="c_InputFile"/>] ;
      + [<memberdata name="c_logfile" display="c_LogFile"/>] ;
      + [<memberdata name="c_originalfilename" display="c_OriginalFileName"/>] ;
      + [<memberdata name="c_outputfile" display="c_OutputFile"/>] ;
      + [<memberdata name="c_textlog" display="c_TextLog"/>] ;
      + [<memberdata name="c_texterr" display="c_TextErr"/>] ;
      + [<memberdata name="c_type" display="c_Type"/>] ;
      + [<memberdata name="n_debug" display="n_Debug"/>] ;
      + [<memberdata name="l_error" display="l_Error"/>] ;
      + [<memberdata name="l_test" display="l_Test"/>] ;
      + [<memberdata name="l_methodsort_enabled" display="l_MethodSort_Enabled"/>] ;
      + [<memberdata name="l_propsort_enabled" display="l_PropSort_Enabled"/>] ;
      + [<memberdata name="l_reportsort_enabled" display="l_ReportSort_Enabled"/>] ;
      + [<memberdata name="n_fb2prg_version" display="n_FB2PRG_Version"/>] ;
      + [<memberdata name="n_methods_lineno" display="n_Methods_LineNo"/>] ;
      + [<memberdata name="ofso" display="oFSO"/>] ;
      + [</VFPData>]


   DIMENSION a_SpecialProps(1)     , a_SpecialProps_Chk(1) , a_SpecialProps_Coll(1) ;
           , a_SpecialProps_Cbo(1) , a_SpecialProps_Cmg(1) , a_SpecialProps_Cmd(1)  ;
           , a_SpecialProps_Cur(1) , a_SpecialProps_CA(1)  , a_SpecialProps_DE(1)   ;
           , a_SpecialProps_Edt(1) , a_SpecialProps_Frs(1) , a_SpecialProps_Grd(1)  ;
           , a_SpecialProps_Grc(1) , a_SpecialProps_Grh(1) , a_SpecialProps_Hlk(1)  ;
           , a_SpecialProps_Img(1) , a_SpecialProps_Lbl(1) , a_SpecialProps_Lin(1)  ;
           , a_SpecialProps_Lst(1) , a_SpecialProps_Ole(1) , a_SpecialProps_Opg(1)  ;
           , a_SpecialProps_Opb(1) , a_SpecialProps_Phk(1) , a_SpecialProps_Rel(1)  ;
           , a_SpecialProps_Rls(1) , a_SpecialProps_Sep(1) , a_SpecialProps_Shp(1)  ;
           , a_SpecialProps_Spn(1) , a_SpecialProps_Txt(1) , a_SpecialProps_Tmr(1)  ;
           , a_SpecialProps_Tbr(1)

   DIMENSION a_SpecialProps_XMLAda(1) ;
           , a_SpecialProps_XMLFld(1) ;
           , a_SpecialProps_XMLTbl(1)

   DIMENSION a_SpecialPropsFiles(1)

   n_Debug                 = 0
   l_Error                 = .F.
   l_Test                  = .F.
   c_InputFile             = ''
   c_OutputFile            = ''
   lFileMode               = .F.
   n_ClassTimeStamp        = 0
   n_FB2PRG_Version        = 1.0
   c_Foxbin2prg_FullPath   = ''
   c_Type                  = ''
   c_CurDir                = ''
   c_LogFile               = ''
   c_TextLog               = ''
   c_TextErr               = ''
   l_MethodSort_Enabled    = .T.
   l_PropSort_Enabled      = .T.
   l_ReportSort_Enabled    = .T.
   c_OriginalFileName      = ''
   c_ClaseActual           = ''
   oFSO                    = .Null.
   n_Methods_LineNo        = 0         && Número de línea del error dentro de "Methods"
   cOutputFolder           = ''



   Procedure Init
      Local lcSys16, lnPosProg

      Set Deleted On
      Set Date YMD
      Set Hours To 24
      Set Century On
      Set Safety Off
      Set Multilocks On
      Set TablePrompt Off

      * Operation set to standard value
      * anywhere else it will respect this to,
      * so it's in the general settings or not
      Set Blocksize To 0

      Set Exact On
      If Not Empty( On("ESCAPE") ) Then
         Set Escape On
      Endif

      Public C_FB2PRG_CODE
      C_FB2PRG_CODE   = ''    && Contendrá todo el código generado
      This.c_CurDir   = Sys(5) + Curdir()
      This.oFSO       = Createobject( "Scripting.FileSystemObject")
      lcSys16         = Sys(16)

      If Left(lcSys16,10) == 'PROCEDURE '
         lnPosProg   = At(" ", lcSys16, 2) + 1
      Else
         lnPosProg   = 1
      Endif

      This.c_Foxbin2prg_FullPath      = Substr( lcSys16, lnPosProg )
      This.SpecialProps_init()
      Release lcSys16, lnPosProg
      Return
   Endproc



   Procedure Destroy
      Local loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
      C_FB2PRG_CODE   = ''
      Use In (Select("TABLABIN"))
      Use In (Select("foxbin2prg_keywords"))

      *-- Esta comprobación es por los TESTS, que a veces no cargan o_FoxBin2Prg_Lang
      If Vartype(_Screen.o_FoxBin2Prg_Lang) = "O" Then
         loLang          = _Screen.o_FoxBin2Prg_Lang
         This.writeLog( loLang.C_CONVERTER_UNLOAD_LOC )
      Endif

      This.oFSO   = .Null.
   Endproc



   Procedure analyzeAssignmentOf_TAG
      *-- DETALLES: Este método está pensado para leer los tags FB2P_VALUE y MEMBERDATA, que tienen esta sintaxis:
      *
      *   _memberdata = <VFPData>
      *       <memberdata name="mimetodo" display="miMetodo"/>
      *       </VFPData>      && XML Metadata for customizable properties
      *
      *   <fb2p_value>Este es un&#13;valor especial</fb2p_value>
      *
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcPropName                (v! IN    ) Nombre de la propiedad
      * tcValue                   (v! IN    ) Valor (o inicio del valor) de la propiedad
      * taProps                   (!@ IN    ) El array con las líneas del código donde buscar
      * tnProp_Count              (!@ IN    ) Cantidad de líneas de código
      * I                         (!@ IN    ) Línea actualmente evaluada
      * tcTAG_I                   (v! IN    ) TAG de inicio   <tag>
      * tcTAG_F                   (v! IN    ) TAG de fin      </tag>
      * tnLEN_TAG_I               (v! IN    ) Longitud del tag de inicio
      * tnLEN_TAG_F               (v! IN    ) Longitud del tag de fin
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcPropName, tcValue, taProps, tnProp_Count, I, tcTAG_I, tcTAG_F, tnLEN_TAG_I, tnLEN_TAG_F

      External Array taProps

      Local llBloqueEncontrado, loEx As Exception

      Try
         If Left( tcValue, tnLEN_TAG_I) == tcTAG_I
            llBloqueEncontrado  = .T.
            Local lcLine, lnArrayCols

            With This As c_conversor_base Of 'c_conversor_base.prg'

               *-- Propiedad especial
               If tcTAG_F $ tcValue        && El fin de tag está "inline"
                  .denormalizePropertyValue( @tcPropName, @tcValue, '' )
                  Exit
               Endif

               tcValue         = ''
               lnArrayCols     = Alen(taProps,2)

               For I = m.I + 1 To tnProp_Count
                  If lnArrayCols = 0
                     lcLine = Ltrim( taProps(m.I), 0, ' ', Chr(9) )  && Quito espacios y TABS de la izquierda
                  Else
                     lcLine = Ltrim( taProps(m.I,1), 0, ' ', Chr(9) )    && Quito espacios y TABS de la izquierda
                  Endif

                  Do Case
                  Case Left( lcLine, tnLEN_TAG_F ) == tcTAG_F
                     *-- <EndTag>
                     tcValue = tcTAG_I + Substr( tcValue, 3 ) + tcTAG_F
                     .denormalizePropertyValue( @tcPropName, @tcValue, '' )
                     I = m.I + 1
                     Exit

                  Case tcTAG_F $ lcLine
                     *-- Data-Data-Data-<EndTag>
                     tcValue = tcTAG_I + Substr( tcValue, 3 ) + Left( lcLine, At( tcTAG_F, lcLine )-1 ) + tcTAG_F
                     .denormalizePropertyValue( @tcPropName, @tcValue, '' )
                     I = m.I + 1
                     Exit

                  Otherwise
                     *-- Data
                     tcValue = tcValue + CR_LF + lcLine
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

      Finally
         Release tcPropName, tcValue, taProps, tnProp_Count, I, tcTAG_I, tcTAG_F, tnLEN_TAG_I, tnLEN_TAG_F, loEx
      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure updateProgressbar
      Lparameters tcTexto, tnValor, tnTotal, tnTipo
   Endproc



   Procedure findMethodsObjectByName
      Lparameters tcNombreObjeto, toClase
      *-- Caso 1: Un método de un objeto de la clase
      *--     findMethodsObjectByName( 'command1', loClase )
      *-- Caso 2: Un método de un objeto heredado que no está definido en esta librería
      *--     findMethodsObjectByName( 'cnt_descripcion.Cntlista.cmgAceptarCancelar.cmdCancelar', loClase )
      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Try
         Local lnObjeto, I, X, N, lcRutaDelNombre ;
            , loObjeto As CL_OBJETO Of 'FOXBIN2PRG.PRG'
         Store 0 To N, lnObjeto

         *--   El método puede pertenecer a esta clase, a un objeto de esta clase,
         *-- o a un objeto heredado que no está definido en esta clase, sino en otra,
         *-- y para la cual la ruta a buscar es parcial.
         *--   Por ejemplo, el caso 2 puede que el objeto que hay sea 'cnt_descripcion.Cntlista'
         *-- y el botón sea heredado, pero se le haya redefinido su método Click aquí.
         For X = Occurs( '.', tcNombreObjeto + '.' ) To 1 Step -1
            N   = N + 1
            lcRutaDelNombre = Left( tcNombreObjeto, Rat( '.', tcNombreObjeto + '.', N ) - 1 )
            For I = 1 To toClase._AddObject_Count
               loObjeto    = toClase._AddObjects(m.I)

               *-- Busco tanto el [nombre] del método como [class.nombre]+[nombre] del método
               If Lower(loObjeto._Nombre) == Lower(toClase._ObjName) + '.' + lcRutaDelNombre ;
                     OR Lower(loObjeto._Nombre) == lcRutaDelNombre
                  lnObjeto    = m.I
                  Exit
               Endif

               loObjeto    = .Null.
            Endfor
            If lnObjeto > 0
               Exit
            Endif
         Endfor

      Catch To loEx
         lnCodError  = loEx.ErrorNo

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcNombreObjeto, toClase, I, X, N, lcRutaDelNombre, loObjeto
      Endtry

      Return lnObjeto
   Endproc



   Function verifyValidExpression
      Lparameters tcAsignacion, tnCodError, tcExpNormalizada
      Local llError, loEx As Exception

      Try
         tcExpNormalizada    = Normalize( tcAsignacion )

      Catch To loEx
         llError     = .T.
         tnCodError  = loEx.ErrorNo

      Finally
         Release tcAsignacion, tnCodError, tcExpNormalizada, loEx
      Endtry

      Return Not llError
   Endfunc


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@    OUT) Objeto generado de clase correspondiente con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (!@ IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
      #Endif
      Local loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

      loLang = _Screen.o_FoxBin2Prg_Lang

      This.writeLog( C_TAB + loLang.C_CONVERTING_FILE_LOC + ' ' + This.c_OutputFile + '...' )
      Release toModulo, toEx, toFoxBin2Prg, loLang
      Return
   Endproc


   Procedure currentLineIsPreviousLineContinuation
      Lparameters taCodeLines, I
      Local lcPrevLine, llIsContinuation

      EXTERNAL ARRAY taCodeLines

      *-- Analizo la línea anterior para saber si termina con ";" o "," y la actual es continuación
      If m.I > 1
         lcPrevLine  = taCodeLines(m.I-1)
      Else
         lcPrevLine  = ''
      Endif

      This.get_SeparatedLineAndComment( @lcPrevLine )

      If Inlist( Right( lcPrevLine,1 ), ';', ',' )    && Esta línea es continuación de la anterior
         llIsContinuation    = .T.
      Endif

      Release taCodeLines, I, lcPrevLine

      Return llIsContinuation
   Endproc


   Procedure isIndicatedToken
      Lparameters tcLine, ta_ID_Bloques, tnLen_IDFinBQ, X, tnIniFin
      Local llEncontrado, lcWord, lcWord2, lcLine, lnWordCount

      Try
         *-- Pre-normalización
         lcLine  = tcLine

         If tnIniFin = 1
            *-- TOKENS DE INICIO
            If Upper( Left( lcLine, ta_ID_Bloques(m.X,3) ) ) == ta_ID_Bloques(m.X,1)
               *-- Evaluar casos especiales
               lcWord  = Upper( Alltrim(Getwordnum(lcLine,1) ) )

               If ta_ID_Bloques(m.X,1) == 'TEXT' Then
                  lcLine      = Upper( lcLine ) + ' '
                  lnWordCount = Getwordcount(lcLine)

                  If lnWordCount >= 2
                     lcWord2 = Alltrim(Getwordnum(lcLine,2) )
                  Endif

                  Do Case
                  Case Not lcWord == 'TEXT'
                     Exit

                     *CASE UPPER( LEFT( CHRTRAN( lcLine, ' ', '' ), 5 ) ) == 'TEXT='
                     *   EXIT
                  Case lnWordCount >= 2
                     If lcWord2 == "TO"
                        * OK, es TEXT TO...
                     Else
                        * Luego de TEXT sigue cualquier otra cosa, así que puede ser
                        * un campo, variable, etc, que lo han llamado TEXT.
                        Exit
                     Endif

                  Otherwise
                     * OK, es TEXT sin más.
                  Endcase
               Endif

               llEncontrado    = .T.
            Endif
         Else
            *-- TOKENS DE FIN
            If Upper( Left( lcLine, ta_ID_Bloques(m.X,4) ) ) == ta_ID_Bloques(m.X,2)    && Fin de bloque encontrado (#ENDI, ENDTEXT, etc)
               *-- Evaluar casos especiales
               lcWord  = Upper( Alltrim(Getwordnum(lcLine,1) ) )

               If ta_ID_Bloques(m.X,2) == 'ENDT' And Not lcWord == Left( 'ENDTEXT', Len(lcWord) )
                  Exit
               Endif

               llEncontrado    = .T.
            Endif
         Endif

      Finally
         Release tcLine, ta_ID_Bloques, tnLen_IDFinBQ, X, tnIniFin, lcLine
      Endtry

      Return llEncontrado
   Endproc


   Procedure decode_SpecialCodes_1_31
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcText                    (!@ IN    ) Decodifica los primeros 31 caracteres ASCII de {nCode} a CHR(nCode)
      *---------------------------------------------------------------------------------------------------
      Lparameters tcText
      Local I
      For I = 0 To 31
         tcText  = Strtran( tcText, '{' + Transform(m.I) + '}', Chr(m.I) )
      Endfor
      Release I
      Return tcText
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



   Procedure denormalizeAssignment
      Lparameters tcAsignacion
      Local lcPropName, lcValor, lnCodError, lcExpNormalizada, lnPos, lcComentario

      With This As c_conversor_base Of 'c_conversor_base.prg'
         .get_SeparatedPropAndValue( @tcAsignacion, @lcPropName, @lcValor )

         lcComentario = ''
         .denormalizePropertyValue( @lcPropName, @lcValor, @lcComentario )
         tcAsignacion = lcPropName + ' = ' + lcValor
      Endwith

      Release lcPropName, lcValor, lnCodError, lcExpNormalizada, lnPos, lcComentario
      Return tcAsignacion
   Endproc



   Procedure denormalizePropertyValue
      *-- Este método se ejecuta cuando se regenera el binario desde el tx2
      Lparameters tcProp, tcValue, tcComentario
      Local lnCodError, lnPos, lcValue
      tcComentario    = ''

      *-- Ajustes de algunos casos especiales
      Do Case
      Case tcProp == '_memberdata'
         *-- Me quedo con lo importante y quito los CHR(0) y longitud que a veces agrega al inicio
         lcValue = ''

         For I = 1 To Occurs( '/>', tcValue )
            * issue#16: memberdata property should be saved in compressed format
            lcValue = lcValue + Chrtran( Strextract( tcValue, '<memberdata ', '/>', m.I, 1+4 ), CR_LF, '  ' )
         Endfor

         * issue#16: memberdata property should be saved in compressed format
         TEXT TO tcValue TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                <VFPData><<SUBSTR( lcValue, 1)>></VFPData>
         ENDTEXT

         If Len(lcValue) > 255
            tcValue = C_MPROPHEADER + Str( Len(tcValue), 8 ) + tcValue
         Else
            tcValue = Chrtran( tcValue, CR_LF, '' )
         Endif

      Case Left( tcValue, C_LEN_FB2P_VALUE_I ) == C_FB2P_VALUE_I
         *-- Valor especial Fox con cabecera CHR(1): Debo agregarla y desnormalizar el valor
         tcValue = Strtran( Strtran( Strextract( tcValue, C_FB2P_VALUE_I, C_FB2P_VALUE_F, 1, 1 ), '&#13;', C_CR ), '&#10;', C_LF  )
         tcValue = C_MPROPHEADER + Str( Len(tcValue), 8 ) + tcValue

      Endcase

      Release tcProp, tcComentario, lnCodError, lnPos, lcValue
      Return tcValue
   Endproc



   Procedure denormalizeXMLValue
      Lparameters tcValor
      *-- DESNORMALIZA EL TEXTO INDICADO, EXPANDIENDO LOS SÍMBOLOS XML ESPECIALES.
      Local lnPos, lnPos2, lnAscii
      tcValor = Strtran(tcValor, Chr(38)+'gt;', '>')          &&  >
      tcValor = Strtran(tcValor, Chr(38)+'lt;', '<')          &&  <
      tcValor = Strtran(tcValor, Chr(38)+'quot;', Chr(34))    &&  "
      tcValor = Strtran(tcValor, Chr(38)+'apos;', Chr(39))    &&  '
      tcValor = Strtran(tcValor, Chr(38)+'amp;', Chr(38))     &&  &

      *-- Obtengo los Hex
      Do While .T.
         lnPos   = At( Chr(38)+'#x', tcValor )
         If lnPos = 0
            Exit
         Endif
         lnPos2  = lnPos + 1 + At( ';', Substr( tcValor, lnPos + 2, 4 ) )
         lnAscii = Evaluate( '0' + Substr( tcValor, lnPos + 3, lnPos2 - lnPos - 3 ) )
         tcValor = Stuff(tcValor, lnPos, lnPos2 - lnPos + 1, Chr(lnAscii))       &&  ASCII
      Enddo

      *-- Obtengo los Dec
      Do While .T.
         lnPos   = At( Chr(38)+'#', tcValor )
         If lnPos = 0
            Exit
         Endif
         lnPos2  = lnPos + 1 + At( ';', Substr( tcValor, lnPos + 2, 4 ) )
         lnAscii = Evaluate( Substr( tcValor, lnPos + 2, lnPos2 - lnPos - 2 ) )
         tcValor = Stuff(tcValor, lnPos, lnPos2 - lnPos + 1, Chr(lnAscii))       &&  ASCII
      Enddo

      Release lnPos, lnPos2, lnAscii
      Return tcValor
   Endproc



   Procedure encode_SpecialCodes_1_31
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcText                    (!@ IN    ) Decodifica los primeros 31 caracteres ASCII de CHR(nCode) a {nCode}
      *---------------------------------------------------------------------------------------------------
      Lparameters tcText
      Local I
      For I = 0 To 31
         tcText  = Strtran( tcText, Chr(m.I), '{' + Transform(m.I) + '}' )
      Endfor
      Release I
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



   Hidden Procedure exception2Str
      Lparameters toEx As Exception
      Local lcError
      lcError     = 'Error ' + Transform(toEx.ErrorNo) + ', ' + toEx.Message + Chr(13) + Chr(13) ;
         + toEx.Procedure + ', ' + Transform(toEx.Lineno) + Chr(13) + Chr(13) ;
         + toEx.LineContents
      Release toEx
      Return lcError
   Endproc



   Procedure fileTypeCode
      Lparameters tcExtension, tcOriginalType
      tcExtension = Upper(tcExtension)
      Return Icase( tcExtension = 'DBC', 'd' ;
         , tcExtension = 'DBF', Evl(tcOriginalType, 'D') ;
         , tcExtension = 'QPR', 'Q' ;
         , tcExtension = 'SCX', 'K' ;
         , tcExtension = 'FRX', 'R' ;
         , tcExtension = 'LBX', 'B' ;
         , tcExtension = 'VCX', 'V' ;
         , tcExtension = 'PRG', 'P' ;
         , tcExtension = 'FLL', 'L' ;
         , tcExtension = 'APP', 'Z' ;
         , tcExtension = 'EXE', 'Z' ;
         , tcExtension = 'MNX', 'M' ;
         , tcExtension = 'TXT', 'T' ;
         , tcExtension = 'FPW', 'T' ;
         , tcExtension = 'H'  , 'T' ;
         , tcExtension = 'SPR', 'E' ;
         , tcExtension = 'MPR', 'P' ;
         , Evl(tcOriginalType, 'x') )
   Endproc


   Function getTimeStamp
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tnTimeStamp               (v! IN    ) Timestamp en formato numérico
      *---------------------------------------------------------------------------------------------------
      Lparameters tnTimeStamp
      *-- CONVIERTE UN DATO TIMESTAMP NUMERICO USADO POR LOS ARCHIVOS SCX/VCX/etc. EN TIPO DATETIME
      Try
         Local lcTimeStamp,lnYear,lnMonth,lnDay,lnHour,lnMinutes,lnSeconds,lcTime,lnHour,ltTimeStamp,lnResto ;
            ,lcTimeStamp_Ret, laDirInfo[1,5], loEx As Exception

         With This As c_conversor_base Of 'c_conversor_base.prg'
            lcTimeStamp_Ret = ''

            If Empty(tnTimeStamp)
               If .lFileMode
                  If Adir(laDirInfo,.c_InputFile)=0
                     Exit
                  Endif

                  ltTimeStamp = Evaluate( '{^' + Dtoc(laDirInfo(1,3)) + ' ' + Transform(laDirInfo(1,4)) + '}' )

                  *-- En mi arreglo, si la hora pasada tiene 32 segundos o más, redondeo al siguiente minuto, ya que
                  *-- la descodificación posterior de getTimeStamp tiene ese margen de error.
                  If Sec(m.ltTimeStamp) >= 32
                     ltTimeStamp = m.ltTimeStamp + 28
                  Endif

                  lcTimeStamp_Ret = Ttoc( ltTimeStamp )
                  Exit
               Endif

               tnTimeStamp = .n_ClassTimeStamp

               If Empty(tnTimeStamp)
                  Exit
               Endif
            Endif

            *-- YYYY YYYM MMMD DDDD HHHH HMMM MMMS SSSS
            lnResto     = tnTimeStamp
            lnYear      = Int( lnResto / 2**25 + 1980)
            lnResto     = lnResto % 2**25
            lnMonth     = Int( lnResto / 2**21 )
            lnResto     = lnResto % 2**21
            lnDay       = Int( lnResto / 2**16 )
            lnResto     = lnResto % 2**16
            lnHour      = Int( lnResto / 2**11 )
            lnResto     = lnResto % 2**11
            lnMinutes   = Int( lnResto / 2**5 )
            lnResto     = lnResto % 2**5
            lnSeconds   = lnResto

            lcTimeStamp = Padl(lnYear,4,'0') + "/" + Padl(lnMonth,2,'0') + "/" + Padl(lnDay,2,'0') + " " ;
               + Padl(lnHour,2,'0') + ":" + Padl(lnMinutes,2,'0') + ":" + Padl(lnSeconds,2,'0')

            ltTimeStamp = Evaluate( "{^" + lcTimeStamp + "}" )

            lcTimeStamp_Ret = Ttoc( ltTimeStamp )
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcTimeStamp_Ret
   Endfunc


   Procedure get_ListNamesWithValuesFrom_InLine_MetadataTag
      *-- OBTENGO EL ARRAY DE DATOS Y VALORES DE LA LINEA DE METADATOS INDICADA
      *-- NOTA: Los valores NO PUEDEN contener comillas dobles en su valor, ya que generaría un error al parsearlos.
      *-- Ejemplo:
      *< FileMetadata: Type="V" Cpid="1252" Timestamp="1131901580" ID="1129207528" ObjRev="544" />
      *< OLE: Nombre="frm_form.Pageframe1.Page1.Cnt_controles_h.Olecontrol1" Parent="frm_form.Pageframe1.Page1.Cnt_controles_h" ObjName="Olecontrol1" Checksum="1685567300" Value="0M8R4KGxGuEAAAAAAAAAAAAAAAAAAAAAPg...ADAP7AAAA==" />
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLineWithMetadata        (!@ IN    ) Línea con metadatos y un tag de metadatos
      * taPropsAndValues          (!@    OUT) Array a devolver con las propiedades y valores encontrados
      * tnPropsAndValues_Count    (!@    OUT) Cantidad de propiedades encontradas
      * tcLeftTag                 (v! IN    ) TAG de inicio de los metadatos
      * tcRightTag                (v! IN    ) TAG de fin de los metadatos
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcLineWithMetadata, taPropsAndValues, tnPropsAndValues_Count, tcLeftTag, tcRightTag

      External Array taPropsAndValues

      Local lcMetadatos, I, lcVirtualMeta, lnPos1, lnPos2, lnLastPos, lnCantComillas ;
         , loLang As CL_LANG Of 'FOXBIN2PRG.PRG' ;
         , loEx As Exception

      Try
         loLang          = _Screen.o_FoxBin2Prg_Lang
         Store '' To lcVirtualMeta
         Store 0 To lnPos1, lnPos2, lnLastPos, tnPropsAndValues_Count, I

         lcMetadatos     = Alltrim( Strextract( tcLineWithMetadata, tcLeftTag, tcRightTag, 1, 1) )

         If Empty(lcMetadatos)
            * Puede que la línea esté separada con un CR erróneo. El usuario debe revisarlo
            Error (Textmerge("Can't identify Metadata TAG '<<tcRightTag>>'. May be the Source line have an extra CR/LF?"))
         Endif

         lnCantComillas  = Occurs( '"', lcMetadatos )

         If lnCantComillas % 2 <> 0  && Valido que las comillas "" sean pares
            *ERROR "Error de datos: No se puede parsear porque las comillas no son pares en la línea [" + lcMetadatos + "]"
            Error (Textmerge(loLang.C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC))
         Endif

         lnLastPos   = 1
         Dimension taPropsAndValues( lnCantComillas / 2, 2 )

         *-------------------------------------------------------------------------------------
         * IMPORTANTE!!
         * ------------
         * SI SE SEPARAN LAS IGUALDADES CON ESPACIOS, ÉSTAS DEJAN DE RECONOCERSE!!  (prop = "valor" en vez de prop="valor")
         * TENER EN CUENTA AL GENERAR EL TEXTO O AL MODIFICARLO MANUALMENTE AL MERGEAR
         *-------------------------------------------------------------------------------------
         For I = 1 To lnCantComillas Step 2
            tnPropsAndValues_Count  = tnPropsAndValues_Count + 1

            *  Type="V" Cpid="1252"
            *       ^ ^                 => Posiciones del par de comillas dobles
            lnPos1  = At( '"', lcMetadatos, m.I )
            lnPos2  = At( '"', lcMetadatos, m.I + 1 )

            *  Type="V" Cpid="1252"
            *          ^     ^    ^         => LastPos, lnPos1 y lnPos2
            taPropsAndValues(tnPropsAndValues_Count,1)  = Alltrim( Getwordnum( Substr( lcMetadatos, lnLastPos, lnPos1 - lnLastPos ), 1, '=' ) )
            taPropsAndValues(tnPropsAndValues_Count,2)  = Substr( lcMetadatos, lnPos1 + 1, lnPos2 - lnPos1 - 1 )

            lnLastPos = lnPos2 + 1
         Endfor

      Catch To loEx
         loEx.UserValue = loEx.UserValue + Textmerge('I=<<I>>, lcMetadatos="<<lcMetadatos>>", tcLineWithMetadata="<<tcLineWithMetadata>>"') + CR_LF
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcLineWithMetadata, taPropsAndValues, tnPropsAndValues_Count, tcLeftTag, tcRightTag ;
            , lcMetadatos, I, lcVirtualMeta, lnPos1, lnPos2, lnLastPos, lnCantComillas

      Endtry

      Return
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


   Procedure get_SeparatedPropAndValue
      *-- Devuelve el valor separado de la propiedad.
      *-- Si se indican más de 3 parámetros, evalúa el valor completo a través de las líneas de código (valores multi-línea)
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcAsignacion              (v! IN    ) Asignación completa con variable, igualdad y valor
      * tcPropName                (@!    OUT) Nombre de la variable
      * tcValue                   (@?    OUT) Valor
      * toClase                   (v! IN    )
      * taCodeLines               (@! IN    ) Líneas de código a analizar
      * tnCodeLines               (v! IN    ) Cantidad de líneas de código
      * I                         (@! IN/OUT) Línea actual
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcAsignacion, tcPropName, tcValue, toClase, taCodeLines, tnCodeLines, I
      Local ln_AT_Cmt

      Store '' To tcPropName, tcValue

      *-- EVALUAR UNA ASIGNACIÓN ESPECÍFICA INLINE
      If '=' $ tcAsignacion
         ln_AT_Cmt       = At( '=', tcAsignacion)
         tcPropName      = Alltrim( Left( tcAsignacion, ln_AT_Cmt - 2 ), 0, ' ', Chr(9) )    && Quito espacios y TABS
         *!* Changed by: LScheffler 16.3.2023
         *!* <pdm>
         *!* <change date="{^2023-03-16,09:02:00}">Changed by: LScheffler<br />
         *!* Problems with property values with leading and trailing spaces
         *!* and with double ampersand in value
         *!* we just do not LTRIM so we keep the leading space here
         *!* and we start after the space after the equal sign.<br/>
         *!* see issues #90, #91
         *!* </change>
         *!* </pdm>

         *           tcValue         = Ltrim( Substr( tcAsignacion, ln_AT_Cmt + 2 ) )
         tcValue         = Substr( tcAsignacion, ln_AT_Cmt + 2 )

         *!* /Changed by: LScheffler 16.3.2023

         If Pcount() > 3
            *-- EVALUAR UNA ASIGNACIÓN QUE PUEDE SER MULTILÍNEA (memberdata, fb2p_value, etc)
            With This As c_conversor_base Of 'c_conversor_base.prg'
               Do Case
               Case .analyzeAssignmentOf_TAG( @tcPropName, @tcValue, @taCodeLines, tnCodeLines, @m.I ;
                     , C_FB2P_VALUE_I, C_FB2P_VALUE_F, C_LEN_FB2P_VALUE_I, C_LEN_FB2P_VALUE_F )
                  *-- FB2P_VALUE

               Case .analyzeAssignmentOf_TAG( @tcPropName, @tcValue, @taCodeLines, tnCodeLines, @m.I ;
                     , C_MEMBERDATA_I, C_MEMBERDATA_F, C_LEN_MEMBERDATA_I, C_LEN_MEMBERDATA_F )
                  *-- MEMBERDATA

               Otherwise
                  *-- Propiedad normal
                  .denormalizePropertyValue( @tcPropName, @tcValue, '' )

               Endcase
            Endwith && THIS
         Endif
      Endif

      Release tcAsignacion, tcPropName, tcValue, toClase, taCodeLines, tnCodeLines, I, ln_AT_Cmt
      Return
   Endproc


   Procedure get_ValueFromNullTerminatedValue
      Lparameters tcNullTerminatedValue
      Local lcValue, lnNullPos
      lnNullPos   = At(Chr(0), tcNullTerminatedValue )
      If lnNullPos = 0
         lcValue     = Chrtran( tcNullTerminatedValue, ['], ["] )
      Else
         lcValue     = Chrtran( Left( tcNullTerminatedValue, lnNullPos - 1 ), ['], ["] )
      Endif
      lcValue = This.encode_SpecialCodes_CR_LF(lcValue)
      Release tcNullTerminatedValue, lnNullPos
      Return lcValue
   Endproc



   Procedure identifyCodeBlocks
      Lparameters taCodeLines, tnCodeLines, taLineasExclusion, tnBloquesExclusion, toModulo
   Endproc


   Procedure identifyExclusionBlocks
      Lparameters taCodeLines, tnCodeLines, ta_ID_Bloques, taLineasExclusion, tnBloquesExclusion, taBloquesExclusion
      * LOS BLOQUES DE EXCLUSIÓN SON AQUELLOS QUE TIENEN TEXT/ENDTEXT OF #IF/#ENDIF Y SE USAN PARA NO BUSCAR
      * INSTRUCCIONES COMO "DEFINE CLASS" O "PROCEDURE" EN LOS MISMOS.
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taCodeLines               (!@ IN    ) El array con las líneas del código de texto donde buscar
      * tnCodeLines               (@? IN    ) Cantidad de líneas de código
      * ta_ID_Bloques             (@? IN    ) Array de pares de identificadores (2 cols). Ej: '#IF .F.','#ENDI' ; 'TEXT','ENDTEXT' ; etc
      * taLineasExclusion         (@?    OUT) Array unidimensional con un .T. o .F. según la línea sea de exclusión o no
      * tnBloquesExclusion        (@?    OUT) Cantidad de bloques de exclusión
      *--------------------------------------------------------------------------------------------------------------
      External Array ta_ID_Bloques, taLineasExclusion, taCodeLines

      Try
         Local lnBloques, I, X, lnPrimerID, lnLen_IDFinBQ, lnID_Bloques_Count, lcWord, lnAnidamientos, lcLine, lcPrevLine ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'
         loLang          = _Screen.o_FoxBin2Prg_Lang
         Dimension taLineasExclusion(tnCodeLines), taBloquesExclusion(1,2)
         Store 0 To tnBloquesExclusion, lnPrimerID, I, X

         If tnCodeLines > 1
            If Empty(ta_ID_Bloques)
               Dimension ta_ID_Bloques(2,4)
               ta_ID_Bloques(1,1)  = '#IF'
               ta_ID_Bloques(1,2)  = '#ENDI'
               ta_ID_Bloques(1,3)  = Len( ta_ID_Bloques(1,1) )
               ta_ID_Bloques(1,4)  = Len( ta_ID_Bloques(1,2) )
               ta_ID_Bloques(2,1)  = 'TEXT'
               ta_ID_Bloques(2,2)  = 'ENDT'
               ta_ID_Bloques(2,3)  = Len( ta_ID_Bloques(2,1) )
               ta_ID_Bloques(2,4)  = Len( ta_ID_Bloques(2,2) )
               lnID_Bloques_Count  = Alen( ta_ID_Bloques, 1 )
            Endif

            *-- Búsqueda del ID de inicio de bloque
            With This As c_conversor_base Of 'c_conversor_base.prg'
               For I = 1 To tnCodeLines
                  * Reduzco los espacios. Ej: '#IF  .F. && cmt' ==> '#IF .F.&&cmt'
                  *lcLine = LTRIM( STRTRAN( STRTRAN( CHRTRAN( taCodeLines(m.I), CHR(9), ' ' ), '  ', ' ' ), '  ', ' ' ) )
                  lcLine      = Ltrim( taCodeLines(m.I), 0, Chr(9), ' ' )

                  If .lineIsOnlyCommentAndNoMetadata( @lcLine )
                     *-- Optimización: Excluyo las líneas que solo son comentarios
                     taLineasExclusion(m.I)  = .T.
                     *--
                     Loop
                  Endif

                  lcLine      = Upper( Left( lcLine,1 ) ) + Upper( Ltrim( Substr( lcLine, 2 ) ) )
                  lnPrimerID  = 0

                  For X = 1 To lnID_Bloques_Count
                     lnLen_IDFinBQ   = Len( ta_ID_Bloques(m.X,2) )
                     If .isIndicatedToken( @lcLine, @ta_ID_Bloques, lnLen_IDFinBQ, m.X, 1 ) ;
                           AND Not .currentLineIsPreviousLineContinuation( @taCodeLines, m.I )
                        lnPrimerID      = m.X
                        lnAnidamientos  = 1
                        Exit
                     Endif
                  Endfor

                  If lnPrimerID > 0   && Se ha identificado un ID de bloque excluyente
                     tnBloquesExclusion      = tnBloquesExclusion + 1
                     Dimension taBloquesExclusion(tnBloquesExclusion,2)
                     taBloquesExclusion(tnBloquesExclusion,1)    = m.I
                     taLineasExclusion(m.I)  = .T.

                     * Búsqueda del ID de fin de bloque
                     For I = m.I + 1 To tnCodeLines
                        * Reduzco los espacios. Ej: '#IF  .F. && cmt' ==> '#IF .F.&&cmt'
                        *lcLine = LTRIM( STRTRAN( STRTRAN( CHRTRAN( taCodeLines(m.I), CHR(9), ' ' ), '  ', ' ' ), '  ', ' ' ) )
                        *lcLine     = LTRIM( CHRTRAN( taCodeLines(m.I), CHR(9), ' ' ) )
                        lcLine      = Ltrim( taCodeLines(m.I), 0, Chr(9), ' ' )
                        taLineasExclusion(m.I)  = .T.

                        If .lineIsOnlyCommentAndNoMetadata( @lcLine )
                           Loop
                        Endif

                        lcLine      = Upper( Left( lcLine,1 ) ) + Upper( Ltrim( Substr( lcLine, 2 ) ) )

                        Do Case
                        Case lnPrimerID = 1 And .isIndicatedToken( @lcLine, @ta_ID_Bloques, 0, m.X, 1 ) ;
                              AND Not .currentLineIsPreviousLineContinuation( @taCodeLines, m.I )
                           *-- Busca el primer marcador (#IF) NOTA: No busco [TEXT] porque no se pueden anidar.
                           lnAnidamientos  = lnAnidamientos + 1

                        Case .isIndicatedToken( @lcLine, @ta_ID_Bloques, 0, m.X, 2 )
                           *-- Busca el segundo marcador (#ENDIF o ENDTEXT)
                           lnAnidamientos  = lnAnidamientos - 1

                           If lnAnidamientos = 0
                              taBloquesExclusion(tnBloquesExclusion,2)    = m.I
                              Exit
                           Endif
                        Endcase
                     Endfor

                     *-- Validación
                     If Empty(taBloquesExclusion(tnBloquesExclusion,2))
                        *ERROR 'No se ha encontrado el marcador de fin [' + ta_ID_Bloques(lnPrimerID,2) ;
                        + '] que cierra al marcador de inicio [' + ta_ID_Bloques(lnPrimerID,1) ;
                        + '] de la línea ' + TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))
                        .n_Methods_LineNo = taBloquesExclusion(tnBloquesExclusion,1)
                        Error (Textmerge(loLang.C_END_MARKER_NOT_FOUND_LOC))
                     Endif
                  Endif
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release taCodeLines, tnCodeLines, ta_ID_Bloques, taLineasExclusion, tnBloquesExclusion, taBloquesExclusion, loLang ;
            , lnBloques, I, X, lnPrimerID, lnID_Bloques_Count, lcWord, lnAnidamientos, lcLine, lcPrevLine
      Endtry

      Return
   Endproc



   Procedure excludedLine
      Lparameters tn_Linea, tnBloquesExclusion, taLineasExclusion

      Return taLineasExclusion(tn_Linea)
   Endproc



   Procedure lineIsOnlyCommentAndNoMetadata
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                        (!@ IN/OUT) Línea a separar del comentario
      * tcComment                     (@?    OUT) Comentario
      * tlDoNotSeparateLineAndComment (v? IN    ) Indica o separar la línea de código del comentario
      * tlDeepCommentAnalysis         (v? IN    ) Indica realizar un análisis profundo de comentarios (para detectar casos complejos de código con '&&' embebido)
      *---------------------------------------------------------------------------------------------------
      * NOTA: Recordar que esta función suele usarse junto a Set_Line(), que quita TABS y espacios a la izquierda.
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine As String, tcComment As String, tlDoNotSeparateLineAndComment As Boolean, tlDeepCommentAnalysis As Boolean
      Local lllineIsOnlyCommentAndNoMetadata, ln_AT_Cmt

      With This As c_conversor_base Of 'c_conversor_base.prg'
         If tlDoNotSeparateLineAndComment
            tcComment   = ''
         Else
            .get_SeparatedLineAndComment( @tcLine, @tcComment, tlDeepCommentAnalysis )
         Endif

         Do Case
         Case Left(tcLine,2) == '*<'
            tcComment   = tcLine

         Case Empty(tcLine) Or Left(tcLine, 1) == '*' ;
               OR Upper(Left(tcLine + ' ', 5)) == 'NOTE ' ; && Vacía o Comentarios
            And Not Upper(Left(tcLine + ' ', 6)) == 'NOTE =' && Excluir asignaciones
            *
            lllineIsOnlyCommentAndNoMetadata = .T.

         Endcase
      Endwith

      Release tcLine, tcComment, ln_AT_Cmt
      Return lllineIsOnlyCommentAndNoMetadata
   Endproc



   Procedure loadModule
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@    OUT) Objeto generado de clase correspondiente con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (!@ IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'C_FOXBIN2PRG.PRG'
      #Endif
      *LOCAL loLang as CL_LANG OF 'FOXBIN2PRG.PRG'
      *loLang         = _SCREEN.o_FoxBin2Prg_Lang
      *THIS.writeLog( C_TAB + loLang.C_CONVERTING_FILE_LOC + ' ' + THIS.c_OutputFile + '...' )
      *RELEASE loLang
      Return
   Endproc



   Procedure normalizeAssignment
      Lparameters tcAsignacion, tcComentario
      Local lcPropName, lcValor, lnCodError, lcExpNormalizada, lnPos

      With This As c_conversor_base Of 'c_conversor_base.prg'
         .get_SeparatedPropAndValue( @tcAsignacion, @lcPropName, @lcValor )
         tcComentario    = ''
         .normalizePropertyValue( @lcPropName, @lcValor, @tcComentario )
         tcAsignacion    = lcPropName + ' = ' + lcValor
      Endwith

      Release tcComentario, lcPropName, lcValor, lnCodError, lcExpNormalizada, lnPos
      Return tcAsignacion
   Endproc



   Procedure normalizePropertyValue
      *-- Este método se ejecuta cuando se genera el tx2 desde el binario
      Lparameters tcProp, tcValue, tcComentario
      Local lcValue, I
      tcComentario    = ''

      *-- Limpieza de caracteres sin uso
      *IF INLIST(tcValue, '..\', '..\..\' ) THEN
      *   MESSAGEBOX( 'Encontrado valor "' + tcValue + '" en propiedad "' + tcProp, 4096, PROGRAM() )
      *   tcValue = ''
      *ENDIF

      *-- Ajustes de algunos casos especiales
      Do Case
      Case tcProp == '_memberdata'
         lcValue = ''

         For I = 1 To Occurs( '/>', tcValue )
            *TEXT TO lcValue TEXTMERGE ADDITIVE NOSHOW FLAGS 1+2 PRETEXT 1+2
            *   <<>>        <<CHRTRAN( STREXTRACT( tcValue, '<memberdata ', '/>', m.I, 1+4 ), CR_LF, '  ' )>>
            *ENDTEXT
            lcValue = lcValue + Chr(13) + Chr(10) + Chr(9) + Chr(9) + Chr(9) + Chrtran( Strextract( tcValue, '<memberdata ', '/>', m.I, 1+4 ), CR_LF, '  ' )
         Endfor

         TEXT TO tcValue TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                <VFPData>
                <<SUBSTR( lcValue, 3)>>
                <<Chr(9)+Chr(9)>></VFPData>
         ENDTEXT

      Case Left( tcValue, C_LEN_FB2P_VALUE_I ) == C_FB2P_VALUE_I
         *-- Valor especial Fox con cabecera CHR(1): Debo quitarla y normalizar el valor
         tcValue = C_FB2P_VALUE_I ;
            + Strtran( Strtran( Strtran( Strtran( ;
            STREXTRACT( tcValue, C_FB2P_VALUE_I, C_FB2P_VALUE_F, 1, 1 ) ;
            , CR_LF, '&#13+10;' ), C_CR, '&#13;' ), C_LF, '&#10;' ), '&#13+10;', CR_LF ) ;
            + C_FB2P_VALUE_F

      Endcase

      Release tcProp, lcValue, I, tcComentario
      Return tcValue
   Endproc



   Procedure normalizeXMLValue
      Lparameters tcValor
      *-- NORMALIZA EL TEXTO INDICADO, COMPRIMIENDO LOS SÍMBOLOS XML ESPECIALES.
      tcValor = Strtran(tcValor, Chr(38), Chr(38) + 'amp;')   && reemplaza &  por  &amp;      &&
      tcValor = Strtran(tcValor, Chr(39), Chr(38) + 'apos;')  && reemplaza '  por  &apos;     &&
      tcValor = Strtran(tcValor, Chr(34), Chr(38) + 'quot;')  && reemplaza "  por  &quot;     &&
      tcValor = Strtran(tcValor, '<', Chr(38) + 'lt;')        &&  reemplaza <  por  &lt;      &&
      tcValor = Strtran(tcValor, '>', Chr(38) + 'gt;')        &&  reemplaza >  por  &gt;      &&
      tcValor = Strtran(tcValor, Chr(13)+Chr(10), Chr(10))    && reeemplaza CR+LF por LF
      tcValor = Chrtran(tcValor, Chr(13), Chr(10))            && reemplaza CR por LF

      Return tcValor
   Endproc



   Function rowTimeStamp(ltDateTime)
      * Generate a FoxPro 3.0-style row timestamp
      *-- CONVIERTE UN DATO TIPO DATETIME EN TIMESTAMP NUMERICO USADO POR LOS ARCHIVOS SCX/VCX/etc.
      Local lcTimeValue, tnTimeStamp

      Try
         If Empty(ltDateTime)
            tnTimeStamp = 0
            Exit
         Endif

         If Vartype(m.ltDateTime) <> 'T'
            m.ltDateTime        = Datetime()
         Endif

         tnTimeStamp = ( Year(m.ltDateTime) - 1980) * 2^25 ;
            + Month(m.ltDateTime) * 2^21 ;
            + Day(m.ltDateTime) * 2^16 ;
            + Hour(m.ltDateTime) * 2^11 ;
            + Minute(m.ltDateTime) * 2^5 ;
            + Sec(m.ltDateTime)
      Endtry

      Return Int(tnTimeStamp)
   Endfunc


   Procedure set_UserValue
      Lparameters toEx As Exception
   Endproc


   Procedure sortPropsAndValues_SetAndGetSCXPropNames
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcOperation               (v! IN    ) Operación a realizar ("SETNAME" o "GETNAME")
      * tcPropName                (v! IN    ) Nombre de la propiedad
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcOperation, tcPropName
      Try
         Local lcPropName, lcClass, lnPos ;
            , loEx As Exception ;
            , loLang As CL_LANG Of 'FOXBIN2PRG.PRG'

         loLang      = _Screen.o_FoxBin2Prg_Lang
         lcPropName  = tcPropName
         tcOperation = Upper(Evl(tcOperation,''))

         Do Case
          Case tcOperation == 'GETNAME'
               lcPropName  = Substr(tcPropName,5)

          Case Not tcOperation == 'SETNAME'
               Error loLang.C_ONLY_SETNAME_AND_GETNAME_RECOGNIZED_LOC

          Case lcPropName == 'Name'   && System "Name" property
               lcPropName  = 'A999' + lcPropName

          Otherwise
               *-- Soporte de evaluación de propiedades por clase evaluada
               LOCAL lnArray, lcPropsArray
               WITH This
                  lnArray = Ascan( This.a_specialpropsfiles ,Lower( Alltrim(.c_ClaseActual) ) , 1 , 0 , 3 , 2+4+8 )
                  IF lnArray = 0
                     lnArray = Ascan( This.a_specialpropsfiles , 'all' , 1 , 0 , 3 , 2+4+8 )
                  ENDIF
                  lcPropsArray = This.a_specialpropsfiles[ lnArray , 2 ]

                  lnPos = Ascan( .&lcPropsArray, lcPropName, 1, 0, 1, 1+2+4 )

                  *-- Genera una propiedad con el formato "A nnn Propiedad", donde los valores más altos quedan al final,
                  *-- de modo que primero van las props nativas, luego las del usuario y al final "name", que es especial.
                  *-- Ej: "A004ScaleMode", ..., "A998UserProp", "A999Name"
                  lcPropName  = 'A' + Padl( Evl(lnPos,998), 3, '0' ) + lcPropName
               ENDWITH
         ENDCASE

      Catch To loEx
            If This.n_Debug > 0 And _vfp.StartMode = 0
               Set Step On
            Endif
            Throw

      Finally
            Release tcOperation, tcPropName, lnPos, loEx

      Endtry
      Return lcPropName

   Endproc


   Procedure sortPropsAndValues
      * KNOWLEDGE BASE:
      * 02/12/2013    FDBOZZO     Fidel Charny me pasó un ejemplo donde se pierden propiedades físicamente
      *                           si se ordenan alfabéticamente en un ADD OBJECT. Pierde "picture" y otras más.
      *                           Pareciera que la última debe ser "Name".
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taPropsAndValues          (!@ IN    ) El array con las propiedades y valores del objeto o clase
      * tnPropsAndValues_Count    (v! IN    ) Cantidad de propiedades
      * tnSortType                (v! IN    ) Tipo de sort:
      *                                           0=Solo separar propiedades de clase y de objetos (.)
      *                                           1=Sort completo de propiedades (para la versión TEXTO)
      *                                           2=Sort completo de propiedades con "Name" al final (para la versión BIN)
      *--------------------------------------------------------------------------------------------------------------
      Lparameters taPropsAndValues, tnPropsAndValues_Count, tnSortType

      External Array taPropsAndValues

      Try
         Local I, X, lnArrayCols, laPropsAndValues(1,2), lcPropName, lcSortedMemo, lcMethods ;
            , lnSelect, lcObjName
         lnArrayCols = Alen( taPropsAndValues, 2 )
         lnSelect    = Select()
         Dimension laPropsAndValues( tnPropsAndValues_Count, lnArrayCols )
         Acopy( taPropsAndValues, laPropsAndValues )

         With This As c_conversor_base Of 'c_conversor_base.prg'
            If m.tnSortType > 0
               * CON SORT:
               * - A las que no tienen '.' les pongo 'A' por delante, y al resto 'B' por delante para que queden al final

               * ATENCIÓN:  10/07/2018
               * Cuando hay ADD OBJECT multicontenedor (obj.obj.obj...), el reordenamiento
               * puede producir daños colaterales, como objetos mal colocados.
               * (Era de esperar: No todo se puede ordenar alfabéticamente)
               * Un solución de compromiso podría ser al menos mantener juntos los objetos de mismo nombre,
               * que en la práctica pueden estar todos mezclados. Al menos eso no rompería nada.
               * VER: https://github.com/fdbozzo/foxbin2prg/issues/28
               *
               * PASO 1: Obtener los nombres únicos y asignarles un código de orden
               Create Cursor C_OBJ (OBJNAME C(50), IORDER I Autoinc)
               Index On OBJNAME Tag OBJNAME

               * PASO 2: Configurar las prioridades de ordenamiento (primero props, luego objs)
               For I = 1 To m.tnPropsAndValues_Count
                  If '.' $ laPropsAndValues(m.I,1)
                     If m.tnSortType = 2
                        * Genera obj+props para BIN
                        lcObjName   = Getwordnum(laPropsAndValues(m.I,1), 1, '.')

                        If Not Seek(Lower(lcObjName), "C_OBJ")
                           Insert Into C_OBJ (OBJNAME) Values (Lower(lcObjName))
                        Endif

                        laPropsAndValues(m.I,1) = 'B' + Padl(C_OBJ.IORDER,3,'0') ;
                           + Juststem(laPropsAndValues(m.I,1)) + '.' ;
                           + .sortPropsAndValues_SetAndGetSCXPropNames( 'SETNAME', Justext(laPropsAndValues(m.I,1)) )

                        *laPropsAndValues(m.I,1)    = 'B000' + lcObjName + '.' ;
                        + .sortPropsAndValues_SetAndGetSCXPropNames( 'SETNAME', JUSTEXT(laPropsAndValues(m.I,1)) )
                     Else
                        * Genera obj+props para TX2
                        lcObjName   = Getwordnum(laPropsAndValues(m.I,1), 1, '.')

                        If Not Seek(Lower(lcObjName), "C_OBJ")
                           Insert Into C_OBJ (OBJNAME) Values (Lower(lcObjName))
                        Endif

                        laPropsAndValues(m.I,1) = 'B' + Padl(C_OBJ.IORDER,3,'0') ;
                           + Juststem(laPropsAndValues(m.I,1)) + '.' ;
                           + Justext(laPropsAndValues(m.I,1))

                        *laPropsAndValues(m.I,1)    = 'B' + PADL(I,3,'0') + laPropsAndValues(m.I,1)
                     Endif
                  Else
                     If m.tnSortType = 2
                        * Genera obj+props para BIN
                        laPropsAndValues(m.I,1) = .sortPropsAndValues_SetAndGetSCXPropNames( 'SETNAME', laPropsAndValues(m.I,1) )
                     Else
                        * Genera obj+props para TX2
                        laPropsAndValues(m.I,1) = 'A000' + laPropsAndValues(m.I,1)
                     Endif
                  Endif
               Endfor

               * Paso 3: Ordenar según la prioridad previa
               If .l_PropSort_Enabled
                  Asort( laPropsAndValues, 1, -1, 0, 1)
               Endif


               * Paso 4: Quitar metadatos y rearmar array
               For I = 1 To m.tnPropsAndValues_Count
                  *-- Quitar caracteres agregados antes del SORT
                  If '.' $ laPropsAndValues(m.I,1)
                     If m.tnSortType = 2
                        * Genera obj+props para BIN
                        taPropsAndValues(m.I,1) = Juststem( Substr( laPropsAndValues(m.I,1), 2+3 ) ) + '.' ;
                           + .sortPropsAndValues_SetAndGetSCXPropNames( 'GETNAME', Justext(laPropsAndValues(m.I,1)) )
                     Else
                        * Genera obj+props para TX2
                        taPropsAndValues(m.I,1) = Substr( laPropsAndValues(m.I,1), 2+3 )
                     Endif
                  Else
                     If m.tnSortType = 2
                        * Genera obj+props para BIN
                        taPropsAndValues(m.I,1) = .sortPropsAndValues_SetAndGetSCXPropNames( 'GETNAME', laPropsAndValues(m.I,1) )
                     Else
                        * Genera obj+props para TX2
                        taPropsAndValues(m.I,1) = Substr( laPropsAndValues(m.I,1), 2+3 )
                     Endif
                  Endif

                  taPropsAndValues(m.I,2) = laPropsAndValues(m.I,2)

                  If lnArrayCols >= 3
                     taPropsAndValues(m.I,3) = laPropsAndValues(m.I,3)
                  Endif
               Endfor

            Else    && m.tnSortType = 0
               *-- SIN SORT: Creo 2 arrays, el bueno y el temporal, y al terminar agrego el temporal al bueno.
               *-- Debo separar las props.normales de las de los objetos (ocurre cuando es un ADD OBJECT)
               X   = 0

               *-- PRIMERO las que no tienen punto
               For I = 1 To m.tnPropsAndValues_Count
                  If Empty( laPropsAndValues(m.I,1) )
                     Loop
                  Endif

                  If Not '.' $ laPropsAndValues(m.I,1)
                     X   = m.X + 1
                     taPropsAndValues(m.X,1) = laPropsAndValues(m.I,1)
                     taPropsAndValues(m.X,2) = laPropsAndValues(m.I,2)
                     If lnArrayCols >= 3
                        taPropsAndValues(m.X,3) = laPropsAndValues(m.I,3)
                     Endif
                  Endif
               Endfor

               *-- LUEGO las demás props.
               For I = 1 To m.tnPropsAndValues_Count
                  If Empty( laPropsAndValues(m.I,1) )
                     Loop
                  Endif

                  If '.' $ laPropsAndValues(m.I,1)
                     X   = m.X + 1
                     taPropsAndValues(m.X,1) = laPropsAndValues(m.I,1)
                     taPropsAndValues(m.X,2) = laPropsAndValues(m.I,2)
                     If lnArrayCols >= 3
                        taPropsAndValues(m.X,3) = laPropsAndValues(m.I,3)
                     Endif
                  Endif
               Endfor
            Endif
         Endwith && THIS AS C_CONVERSOR_BASE OF 'c_conversor_base.prg'


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release taPropsAndValues, tnPropsAndValues_Count, tnSortType ;
            , I, X, lnArrayCols, laPropsAndValues, lcPropName, lcSortedMemo, lcMethods
         Use In (Select("C_OBJ"))
         Select (lnSelect)
      Endtry

      Return
   Endproc



   Procedure SpecialProps_Init
      Try
         Local loEx As Exception
         Local lcPropsFile, lcPropsDir, lnI , lnLen

         lcPropsFile = ''

         With This As conversor_base Of "FOXBIN2PRG.PRG"
            .SpecialPropsFiles_Add( "props_all.txt"                , "a_SpecialProps"        , "all"             )
            .SpecialPropsFiles_Add( "props_checkbox.txt"           , "a_SpecialProps_Chk"    , "checkbox"        )
            .SpecialPropsFiles_Add( "props_collection.txt"         , "a_SpecialProps_Coll"   , "collection"      )
            .SpecialPropsFiles_Add( "props_combobox.txt"           , "a_SpecialProps_Cbo"    , "combobox"        )
            .SpecialPropsFiles_Add( "props_commandgroup.txt"       , "a_SpecialProps_Cmg"    , "commandgroup"    )
            .SpecialPropsFiles_Add( "props_commandbutton.txt"      , "a_SpecialProps_Cmd"    , "commandbutton"   )
            .SpecialPropsFiles_Add( "props_cursor.txt"             , "a_SpecialProps_Cur"    , "cursor"          )
            .SpecialPropsFiles_Add( "props_cursoradapter.txt"      , "a_SpecialProps_CA"     , "cursoradapter"   )
            .SpecialPropsFiles_Add( "props_dataenvironment.txt"    , "a_SpecialProps_DE"     , "dataenvironment" )
            .SpecialPropsFiles_Add( "props_editbox.txt"            , "a_SpecialProps_Edt"    , "editbox"         )
            .SpecialPropsFiles_Add( "props_formset.txt"            , "a_SpecialProps_Frs"    , "formset"         )
            .SpecialPropsFiles_Add( "props_grid_column.txt"        , "a_SpecialProps_Grc"    , "column"          )
            .SpecialPropsFiles_Add( "props_grid_header.txt"        , "a_SpecialProps_Grh"    , "header"          )
            .SpecialPropsFiles_Add( "props_hyperlink.txt"          , "a_SpecialProps_Hlk"    , "hyperlink"       )
            .SpecialPropsFiles_Add( "props_image.txt"              , "a_SpecialProps_Img"    , "image"           )
            .SpecialPropsFiles_Add( "props_label.txt"              , "a_SpecialProps_Lbl"    , "label"           )
            .SpecialPropsFiles_Add( "props_line.txt"               , "a_SpecialProps_Lin"    , "line"            )
            .SpecialPropsFiles_Add( "props_listbox.txt"            , "a_SpecialProps_Lst"    , "listbox"         )
            .SpecialPropsFiles_Add( "props_olebound.txt"           , "a_SpecialProps_Ole"    , "olebound"        )
            .SpecialPropsFiles_Add( "props_optiongroup.txt"        , "a_SpecialProps_Opg"    , "optiongroup"     )
            .SpecialPropsFiles_Add( "props_optiongroup_option.txt" , "a_SpecialProps_Opb"    , "optionbutton"    )
            .SpecialPropsFiles_Add( "props_projecthook.txt"        , "a_SpecialProps_Phk"    , "projecthook"     )
            .SpecialPropsFiles_Add( "props_relation.txt"           , "a_SpecialProps_Rel"    , "relation"        )
            .SpecialPropsFiles_Add( "props_reportlistener.txt"     , "a_SpecialProps_Rls"    , "reportlistener"  )
            .SpecialPropsFiles_Add( "props_separator.txt"          , "a_SpecialProps_Sep"    , "separator"       )
            .SpecialPropsFiles_Add( "props_shape.txt"              , "a_SpecialProps_Shp"    , "shape"           )
            .SpecialPropsFiles_Add( "props_spinner.txt"            , "a_SpecialProps_Spn"    , "spinner"         )
            .SpecialPropsFiles_Add( "props_textbox.txt"            , "a_SpecialProps_Txt"    , "textbox"         )
            .SpecialPropsFiles_Add( "props_timer.txt"              , "a_SpecialProps_Tmr"    , "timer"           )
            .SpecialPropsFiles_Add( "props_xmladapter.txt"         , "a_SpecialProps_XMLAda" , "xmladapter"      )
            .SpecialPropsFiles_Add( "props_xmlfield.txt"           , "a_SpecialProps_XMLFld" , "xmlfield"        )
            .SpecialPropsFiles_Add( "props_xmltable.txt"           , "a_SpecialProps_XMLTbl" , "xmltable"        )

            * lcPropsDir = Justpath( .c_Foxbin2prg_FullPath ) + '\props\'
            lcPropsDir = 'props\'

            FOR lnI = 1 TO Alen( .a_SpecialPropsFiles , 1 )
               lcPropsFile = lcPropsDir + .a_SpecialPropsFiles( lnI, 1 )
               lcProperty  = .a_SpecialPropsFiles( lnI , 2 )
               =Alines( .&lcProperty, Filetostr( lcPropsFile ), 1+4 )
            ENDFOR

         Endwith

      Catch To loEx
         loEx.UserValue  = 'lcPropsFile = ' + lcPropsFile

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return
   Endproc


   PROCEDURE SpecialPropsFiles_Add
   LPARAMETERS pcFile , pcPropArrayName, pcBaseClass
   LOCAL lnI

   IF Alen( This.a_SpecialPropsFiles ) = 1
      lnI = 1
   ELSE
      lnI = Alen( This.a_SpecialPropsFiles , 1 ) + 1
   ENDIF

   DIMENSION This.a_SpecialPropsFiles[ lnI ,3 ]

   This.a_SpecialPropsFiles[ lnI ,1 ] = pcFile
   This.a_SpecialPropsFiles[ lnI ,2 ] = pcPropArrayName
   This.a_SpecialPropsFiles[ lnI ,3 ] = Lower( pcBaseClass )

   RETURN lnI

   ENDPROC



   Procedure writeLog
      Lparameters tcText, tnTimeStamp

      Try
         With This As c_conversor_base Of 'c_conversor_base.prg'
            *-- Según el valor de nTimestamp:
            *-- 0 = Sin timestamp
            *-- 1 = Timestamp por delante
            *-- 2 = Timestamp por detrás
            .c_TextLog  = .c_TextLog ;
               + Iif( Evl(tnTimeStamp,0) = 1, Ttoc(Datetime(),3) + '  ', '' ) ;
               + Evl(tcText,'') ;
               + Iif( Evl(tnTimeStamp,0) = 2, '  ' + Ttoc(Datetime(),3), '' ) ;
               + CR_LF
         Endwith
      Catch
      Endtry
   Endproc


   Procedure writeErrorLog
      Lparameters tcText

      Try
         With This As conversor_base Of "FOXBIN2PRG.PRG"
            .c_TextErr  = .c_TextErr + Evl(tcText,'') + CR_LF
            .l_Error    = .T.
         Endwith
      Catch
      Endtry
   Endproc


Enddefine
