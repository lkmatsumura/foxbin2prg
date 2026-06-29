
#INCLUDE foxbin2prg.h

Define Class c_conversor_base As Custom
   #If .F.
      Local This As c_conversor_base Of 'c_conversor_base.prg'
   #Endif
   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzeassignmentof_tag" display="analyzeAssignmentOf_TAG"/>] ;
      + [<memberdata name="updateprogressbar" display="updateProgressbar"/>] ;
      + [<memberdata name="o_specialprops" display="o_SpecialProps"/>] ;
      + [<memberdata name="ensurespecialprops" display="ensureSpecialProps"/>] ;
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
      + [<memberdata name="makedirtree" display="makeDirTree"/>] ;
      + [<memberdata name="get_mirroredoutputfile" display="get_MirroredOutputFile"/>] ;
      + [<memberdata name="cinputroot" display="cInputRoot"/>] ;
      + [</VFPData>]


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
   o_SpecialProps          = .Null.
   oFSO                    = .Null.
   n_Methods_LineNo        = 0         && Line number of the error within "Methods"
   cOutputFolder           = ''
   cInputRoot              = ''        && Source tree root (project). When set with cOutputFolder, the folder structure is mirrored



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
      C_FB2PRG_CODE   = ''    && Will hold all generated code
      This.c_CurDir   = Sys(5) + Curdir()
      This.oFSO       = Createobject( "Scripting.FileSystemObject")
      lcSys16         = Sys(16)

      If Left(lcSys16,10) == 'PROCEDURE '
         lnPosProg   = At(" ", lcSys16, 2) + 1
      Else
         lnPosProg   = 1
      Endif

      This.c_Foxbin2prg_FullPath      = Substr( lcSys16, lnPosProg )
      Release lcSys16, lnPosProg
      Return
   Endproc



   Procedure Destroy
      Local loLang As CL_LANG Of 'cl_lang.prg'
      C_FB2PRG_CODE   = ''
      Use In (Select("TABLABIN"))
      Use In (Select("foxbin2prg_keywords"))

      *-- This check is for TESTS, which sometimes do not load o_FoxBin2Prg_Lang
      If Vartype(_Screen.o_FoxBin2Prg_Lang) = "O" Then
         loLang          = _Screen.o_FoxBin2Prg_Lang
         This.writeLog( loLang.C_CONVERTER_UNLOAD_LOC )
      Endif

      This.oFSO   = .Null.
      This.o_SpecialProps = .Null.
   Endproc



   Procedure analyzeAssignmentOf_TAG
      *-- DETAILS: This method reads FB2P_VALUE and MEMBERDATA tags, which use this syntax:
      *
      *   _memberdata = <VFPData>
      *       <memberdata name="mimetodo" display="miMetodo"/>
      *       </VFPData>      && XML Metadata for customizable properties
      *
      *   <fb2p_value>This is a&#13;special value</fb2p_value>
      *
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcPropName                (v! IN    ) Property name
      * tcValue                   (v! IN    ) Property value (or start of the value)
      * taProps                   (!@ IN    ) Array of code lines to search
      * tnProp_Count              (!@ IN    ) Number of code lines
      * I                         (!@ IN    ) Line currently being evaluated
      * tcTAG_I                   (v! IN    ) Opening tag   <tag>
      * tcTAG_F                   (v! IN    ) Closing tag   </tag>
      * tnLEN_TAG_I               (v! IN    ) Length of the opening tag
      * tnLEN_TAG_F               (v! IN    ) Length of the closing tag
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcPropName, tcValue, taProps, tnProp_Count, I, tcTAG_I, tcTAG_F, tnLEN_TAG_I, tnLEN_TAG_F

      External Array taProps

      Local llBloqueEncontrado, loEx As Exception

      Try
         If Left( tcValue, tnLEN_TAG_I) == tcTAG_I
            llBloqueEncontrado  = .T.
            Local lcLine, lnArrayCols

            With This As c_conversor_base Of 'c_conversor_base.prg'

               *-- Special property
               If tcTAG_F $ tcValue        && Closing tag is inline
                  .denormalizePropertyValue( @tcPropName, @tcValue, '' )
                  Exit
               Endif

               tcValue         = ''
               lnArrayCols     = Alen(taProps,2)

               For I = m.I + 1 To tnProp_Count
                  If lnArrayCols = 0
                     lcLine = Ltrim( taProps(m.I), 0, ' ', Chr(9) )  && Strip leading spaces and TABs
                  Else
                     lcLine = Ltrim( taProps(m.I,1), 0, ' ', Chr(9) )    && Strip leading spaces and TABs
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
      *-- Case 1: A method on an object in the class
      *--     findMethodsObjectByName( 'command1', loClase )
      *-- Case 2: A method on an inherited object not defined in this library
      *--     findMethodsObjectByName( 'cnt_descripcion.Cntlista.cmgAceptarCancelar.cmdCancelar', loClase )
      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      Try
         Local lnObjeto, I, X, N, lcRutaDelNombre ;
            , loObjeto As CL_OBJETO Of 'cl_objeto.prg'
         Store 0 To N, lnObjeto

         *--   The method may belong to this class, to an object in this class,
         *-- or to an inherited object not defined in this class but in another,
         *-- for which the path to search is partial.
         *--   For example, in case 2 the object may be 'cnt_descripcion.Cntlista'
         *-- and the button is inherited, but its Click method was redefined here.
         For X = Occurs( '.', tcNombreObjeto + '.' ) To 1 Step -1
            N   = N + 1
            lcRutaDelNombre = Left( tcNombreObjeto, Rat( '.', tcNombreObjeto + '.', N ) - 1 )
            For I = 1 To toClase._AddObject_Count
               loObjeto    = toClase._AddObjects(m.I)

               *-- Search both the method [name] and [class.name]+[name]
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toModulo                  (!@    OUT) Generated object of the corresponding class with data read from text
      * toEx                      (!@    OUT) Object with error information
      * toFoxBin2Prg              (!@ IN    ) Reference to the main object
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      Local loLang As CL_LANG Of 'cl_lang.prg'

      loLang = _Screen.o_FoxBin2Prg_Lang

      This.writeLog( C_TAB + loLang.C_CONVERTING_FILE_LOC + ' ' + This.c_OutputFile + '...' )
      Release toModulo, toEx, toFoxBin2Prg, loLang
      Return
   Endproc


   Procedure currentLineIsPreviousLineContinuation
      Lparameters taCodeLines, I
      Local lcPrevLine, llIsContinuation

      EXTERNAL ARRAY taCodeLines

      *-- Check whether the previous line ends with ";" or "," and the current line is a continuation
      If m.I > 1
         lcPrevLine  = taCodeLines(m.I-1)
      Else
         lcPrevLine  = ''
      Endif

      This.get_SeparatedLineAndComment( @lcPrevLine )

      If Inlist( Right( lcPrevLine,1 ), ';', ',' )    && This line continues the previous one
         llIsContinuation    = .T.
      Endif

      Release taCodeLines, I, lcPrevLine

      Return llIsContinuation
   Endproc


   Procedure isIndicatedToken
      Lparameters tcLine, ta_ID_Bloques, tnLen_IDFinBQ, X, tnIniFin
      Local llEncontrado, lcWord, lcWord2, lcLine, lnWordCount

      Try
         *-- Pre-normalization
         lcLine  = tcLine

         If tnIniFin = 1
            *-- OPENING TOKENS
            If Upper( Left( lcLine, ta_ID_Bloques(m.X,3) ) ) == ta_ID_Bloques(m.X,1)
               *-- Evaluate special cases
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
                        * OK, it is TEXT TO...
                     Else
                        * After TEXT comes something else, so it may be
                        * a field, variable, etc. named TEXT.
                        Exit
                     Endif

                  Otherwise
                     * OK, plain TEXT.
                  Endcase
               Endif

               llEncontrado    = .T.
            Endif
         Else
            *-- CLOSING TOKENS
            If Upper( Left( lcLine, ta_ID_Bloques(m.X,4) ) ) == ta_ID_Bloques(m.X,2)    && Block end found (#ENDIF, ENDTEXT, etc.)
               *-- Evaluate special cases
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                    (!@ IN    ) Decodes the first 31 ASCII characters from {nCode} to CHR(nCode)
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                    (!@ IN    ) Decodes ASCII characters 10 and 13 from {nCode} to CHR(nCode)
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
      *-- This method runs when the binary is regenerated from the tx2 file
      Lparameters tcProp, tcValue, tcComentario
      Local lnCodError, lnPos, lcValue
      tcComentario    = ''

      *-- Adjustments for some special cases
      Do Case
      Case tcProp == '_memberdata'
         *-- Keep the important part and strip CHR(0) and length sometimes prepended
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
         *-- Special Fox value with CHR(1) header: prepend it and denormalize the value
         tcValue = Strtran( Strtran( Strextract( tcValue, C_FB2P_VALUE_I, C_FB2P_VALUE_F, 1, 1 ), '&#13;', C_CR ), '&#10;', C_LF  )
         tcValue = C_MPROPHEADER + Str( Len(tcValue), 8 ) + tcValue

      Endcase

      Release tcProp, tcComentario, lnCodError, lnPos, lcValue
      Return tcValue
   Endproc



   Procedure denormalizeXMLValue
      Lparameters tcValor
      *-- DENORMALIZES the given text, expanding special XML entities.
      Local lnPos, lnPos2, lnAscii
      tcValor = Strtran(tcValor, Chr(38)+'gt;', '>')          &&  >
      tcValor = Strtran(tcValor, Chr(38)+'lt;', '<')          &&  <
      tcValor = Strtran(tcValor, Chr(38)+'quot;', Chr(34))    &&  "
      tcValor = Strtran(tcValor, Chr(38)+'apos;', Chr(39))    &&  '
      tcValor = Strtran(tcValor, Chr(38)+'amp;', Chr(38))     &&  &

      *-- Decode hex entities
      Do While .T.
         lnPos   = At( Chr(38)+'#x', tcValor )
         If lnPos = 0
            Exit
         Endif
         lnPos2  = lnPos + 1 + At( ';', Substr( tcValor, lnPos + 2, 4 ) )
         lnAscii = Evaluate( '0' + Substr( tcValor, lnPos + 3, lnPos2 - lnPos - 3 ) )
         tcValor = Stuff(tcValor, lnPos, lnPos2 - lnPos + 1, Chr(lnAscii))       &&  ASCII
      Enddo

      *-- Decode decimal entities
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                    (!@ IN    ) Encodes the first 31 ASCII characters from CHR(nCode) to {nCode}
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcText                    (!@ IN    ) Encodes ASCII characters 10 and 13 from CHR(nCode) to {nCode}
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tnTimeStamp               (v! IN    ) Timestamp in numeric format
      *---------------------------------------------------------------------------------------------------
      Lparameters tnTimeStamp
      *-- CONVERTS A NUMERIC TIMESTAMP USED BY SCX/VCX/etc. FILES INTO DATETIME TYPE
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

                  *-- In my array, if the passed time has 32 seconds or more, round up to the next minute,
                  *-- since subsequent getTimeStamp decoding has that margin of error.
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
      *-- RETURNS THE ARRAY OF NAMES AND VALUES FROM THE INDICATED METADATA LINE
      *-- NOTE: Values CANNOT contain double quotes, as that would cause a parse error.
      *-- Example:
      *< FileMetadata: Type="V" Cpid="1252" Timestamp="1131901580" ID="1129207528" ObjRev="544" />
      *< OLE: Nombre="frm_form.Pageframe1.Page1.Cnt_controles_h.Olecontrol1" Parent="frm_form.Pageframe1.Page1.Cnt_controles_h" ObjName="Olecontrol1" Checksum="1685567300" Value="0M8R4KGxGuEAAAAAAAAAAAAAAAAAAAAAPg...ADAP7AAAA==" />
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcLineWithMetadata        (!@ IN    ) Line with metadata and a metadata tag
      * taPropsAndValues          (!@    OUT) Array to return with properties and values found
      * tnPropsAndValues_Count    (!@    OUT) Number of properties found
      * tcLeftTag                 (v! IN    ) Opening metadata tag
      * tcRightTag                (v! IN    ) Closing metadata tag
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcLineWithMetadata, taPropsAndValues, tnPropsAndValues_Count, tcLeftTag, tcRightTag

      External Array taPropsAndValues

      Local lcMetadatos, I, lcVirtualMeta, lnPos1, lnPos2, lnLastPos, lnCantComillas ;
         , loLang As CL_LANG Of 'cl_lang.prg' ;
         , loEx As Exception

      Try
         loLang          = _Screen.o_FoxBin2Prg_Lang
         Store '' To lcVirtualMeta
         Store 0 To lnPos1, lnPos2, lnLastPos, tnPropsAndValues_Count, I

         lcMetadatos     = Alltrim( Strextract( tcLineWithMetadata, tcLeftTag, tcRightTag, 1, 1) )

         If Empty(lcMetadatos)
            * The line may be split with an erroneous CR. The user should review it
            Error (Textmerge("Can't identify Metadata TAG '<<tcRightTag>>'. May be the Source line have an extra CR/LF?"))
         Endif

         lnCantComillas  = Occurs( '"', lcMetadatos )

         If lnCantComillas % 2 <> 0  && Validate that double quotes "" come in pairs
            *ERROR "Data error: Cannot parse because quotes are not paired on line [" + lcMetadatos + "]"
            Error (Textmerge(loLang.C_DATA_ERROR_CANT_PARSE_UNPAIRING_DOUBLE_QUOTES_LOC))
         Endif

         lnLastPos   = 1
         Dimension taPropsAndValues( lnCantComillas / 2, 2 )

         *-------------------------------------------------------------------------------------
         * IMPORTANT!!
         * ------------
         * IF EQUAL SIGNS ARE SEPARATED BY SPACES, THEY STOP BEING RECOGNIZED!!  (prop = "value" instead of prop="value")
         * KEEP THIS IN MIND WHEN GENERATING TEXT OR MANUALLY EDITING DURING MERGE
         *-------------------------------------------------------------------------------------
         For I = 1 To lnCantComillas Step 2
            tnPropsAndValues_Count  = tnPropsAndValues_Count + 1

            *  Type="V" Cpid="1252"
            *       ^ ^                 => Positions of the double-quote pair
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Line to separate from the comment
      * tcComment                 (@?    OUT) Comment
      * tlDeepCommentAnalysis     (v? IN    ) Perform deep comment analysis (to detect complex code with embedded '&&')
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

            *-- Mask substrings to find '&&' comments later (only if at least one '&&' exists)
            X       = 1
            lnAT1   = At(laSeparador(m.X,1), lcStr)

            *-- How it works:
            *-- Masking starts at the first double quote ["], then cancels up to the next one.
            *-- From there, search character by character for the next left delimiter ( '"[ ),
            *-- find its right pair, and mask the text between both.
            *-- Masking is temporary, only to determine the real comment position,
            *-- for example, this:
            *-- DEFINE BAR 2 OF OpciónAsub PROMPT ""+var+'aa'+["bb]+"Opción A&&2" && Comentario Opción A-2
            *-- temporarily becomes:
            *-- DEFINE BAR 2 OF OpciónAsub PROMPT XX+var+XXXX+XXXXX+XXXXXXXXXXXXX && Comentario Opción A-2
            *-- which makes it easier to find the real '&&' comment.
            *-- If an unclosed string delimiter is found, error 10 (Syntax Error) is raised.
            If lnAT1 > 0 Then
               For I = lnAT1+1 To lnLen
                  If m.X > 0 Then
                     lnAT2   = At(laSeparador(m.X,2), lcStr, laSeparador(m.X,3))

                     If lnAT2 > 0 Then
                        lcStr   = Stuff(lcStr, lnAT1, lnAT2-lnAT1+1, Replicate('X',lnAT2-lnAT1+1))
                     Else
                        ln_AT_Cmt   = At( '&'+'&', lcStr)

                        If ln_AT_Cmt = 0 Or ln_AT_Cmt < lnAT1
                           *-- No real '&&' comment, or there is one but it also contains a string delimiter as part of the comment
                           Exit
                        Else
                           Error 'Closing string delimiter <' + laSeparador(m.X,2) + '> not found: ' + tcLine
                        Endif
                     Endif
                  Endif

                  *-- Check whether the character is a string delimiter: '"[
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
            tcLine      = Rtrim( Left( tcLine, ln_AT_Cmt - 1 ), 0, Chr(9), ' ' )    && Strip TABs and spaces
         Endif

      Endif

      Return (ln_AT_Cmt > 0)
   Endproc


   Procedure get_SeparatedPropAndValue
      *-- Returns the value separated from the property.
      *-- If more than 3 parameters are passed, evaluates the full value across code lines (multi-line values)
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcAsignacion              (v! IN    ) Full assignment with variable, equals sign, and value
      * tcPropName                (@!    OUT) Variable name
      * tcValue                   (@?    OUT) Value
      * toClase                   (v! IN    )
      * taCodeLines               (@! IN    ) Code lines to analyze
      * tnCodeLines               (v! IN    ) Number of code lines
      * I                         (@! IN/OUT) Current line
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcAsignacion, tcPropName, tcValue, toClase, taCodeLines, tnCodeLines, I
      External Array taCodeLines
      Local ln_AT_Cmt

      Store '' To tcPropName, tcValue

      *-- EVALUATE A SPECIFIC INLINE ASSIGNMENT
      If '=' $ tcAsignacion
         ln_AT_Cmt       = At( '=', tcAsignacion)
         tcPropName      = Alltrim( Left( tcAsignacion, ln_AT_Cmt - 2 ), 0, ' ', Chr(9) )    && Strip spaces and TABs
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
            *-- EVALUATE AN ASSIGNMENT THAT MAY SPAN MULTIPLE LINES (memberdata, fb2p_value, etc.)
            With This As c_conversor_base Of 'c_conversor_base.prg'
               Do Case
               Case .analyzeAssignmentOf_TAG( @tcPropName, @tcValue, @taCodeLines, tnCodeLines, @m.I ;
                     , C_FB2P_VALUE_I, C_FB2P_VALUE_F, C_LEN_FB2P_VALUE_I, C_LEN_FB2P_VALUE_F )
                  *-- FB2P_VALUE

               Case .analyzeAssignmentOf_TAG( @tcPropName, @tcValue, @taCodeLines, tnCodeLines, @m.I ;
                     , C_MEMBERDATA_I, C_MEMBERDATA_F, C_LEN_MEMBERDATA_I, C_LEN_MEMBERDATA_F )
                  *-- MEMBERDATA

               Otherwise
                  *-- Normal property
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
      External Array taCodeLines
   Endproc


   Procedure identifyExclusionBlocks
      Lparameters taCodeLines, tnCodeLines, ta_ID_Bloques, taLineasExclusion, tnBloquesExclusion, taBloquesExclusion
      * EXCLUSION BLOCKS ARE THOSE WITH TEXT/ENDTEXT OR #IF/#ENDIF AND ARE USED TO AVOID
      * SEARCHING FOR INSTRUCTIONS SUCH AS "DEFINE CLASS" OR "PROCEDURE" INSIDE THEM.
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * taCodeLines               (!@ IN    ) Array of text code lines to search
      * tnCodeLines               (@? IN    ) Number of code lines
      * ta_ID_Bloques             (@? IN    ) Array of identifier pairs (2 cols). E.g. '#IF .F.','#ENDI' ; 'TEXT','ENDTEXT' ; etc
      * taLineasExclusion         (@?    OUT) One-dimensional array with .T. or .F. per exclusion line
      * tnBloquesExclusion        (@?    OUT) Number of exclusion blocks
      *--------------------------------------------------------------------------------------------------------------
      External Array ta_ID_Bloques, taLineasExclusion, taCodeLines

      Try
         Local lnBloques, I, X, lnPrimerID, lnLen_IDFinBQ, lnID_Bloques_Count, lcWord, lnAnidamientos, lcLine, lcPrevLine ;
            , loLang As CL_LANG Of 'cl_lang.prg'
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

            *-- Search for the block opening identifier
            With This As c_conversor_base Of 'c_conversor_base.prg'
               For I = 1 To tnCodeLines
                  * Collapse spaces. E.g. '#IF  .F. && cmt' ==> '#IF .F.&&cmt'
                  *lcLine = LTRIM( STRTRAN( STRTRAN( CHRTRAN( taCodeLines(m.I), CHR(9), ' ' ), '  ', ' ' ), '  ', ' ' ) )
                  lcLine      = Ltrim( taCodeLines(m.I), 0, Chr(9), ' ' )

                  If .lineIsOnlyCommentAndNoMetadata( @lcLine )
                     *-- Optimization: skip lines that are comments only
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

                  If lnPrimerID > 0   && An excluding block identifier was found
                     tnBloquesExclusion      = tnBloquesExclusion + 1
                     Dimension taBloquesExclusion(tnBloquesExclusion,2)
                     taBloquesExclusion(tnBloquesExclusion,1)    = m.I
                     taLineasExclusion(m.I)  = .T.

                     * Search for the block closing identifier
                     For I = m.I + 1 To tnCodeLines
                        * Collapse spaces. E.g. '#IF  .F. && cmt' ==> '#IF .F.&&cmt'
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
                           *-- Look for the first marker (#IF) NOTE: [TEXT] is not searched because it cannot nest.
                           lnAnidamientos  = lnAnidamientos + 1

                        Case .isIndicatedToken( @lcLine, @ta_ID_Bloques, 0, m.X, 2 )
                           *-- Look for the second marker (#ENDIF or ENDTEXT)
                           lnAnidamientos  = lnAnidamientos - 1

                           If lnAnidamientos = 0
                              taBloquesExclusion(tnBloquesExclusion,2)    = m.I
                              Exit
                           Endif
                        Endcase
                     Endfor

                     *-- Validation
                     If Empty(taBloquesExclusion(tnBloquesExclusion,2))
                        *ERROR 'Closing marker [' + ta_ID_Bloques(lnPrimerID,2) ;
                        + '] for opening marker [' + ta_ID_Bloques(lnPrimerID,1) ;
                        + '] on line ' + TRANSFORM(taBloquesExclusion(tnBloquesExclusion,1))
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcLine                        (!@ IN/OUT) Line to separate from the comment
      * tcComment                     (@?    OUT) Comment
      * tlDoNotSeparateLineAndComment (v? IN    ) Whether to separate the code line from the comment
      * tlDeepCommentAnalysis         (v? IN    ) Perform deep comment analysis (to detect complex code with embedded '&&')
      *---------------------------------------------------------------------------------------------------
      * NOTE: This function is often used together with Set_Line(), which strips leading TABs and spaces.
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
               OR Upper(Left(tcLine + ' ', 5)) == 'NOTE ' ; && Empty line or comments
            And Not Upper(Left(tcLine + ' ', 6)) == 'NOTE =' && Exclude assignments
            *
            lllineIsOnlyCommentAndNoMetadata = .T.

         Endcase
      Endwith

      Release tcLine, tcComment, ln_AT_Cmt
      Return lllineIsOnlyCommentAndNoMetadata
   Endproc



   Procedure loadModule
      *---------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * toModulo                  (!@    OUT) Generated object of the corresponding class with data read from text
      * toEx                      (!@    OUT) Object with error information
      * toFoxBin2Prg              (!@ IN    ) Reference to the main object
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      *LOCAL loLang as CL_LANG OF 'cl_lang.prg'
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
      *-- This method runs when the tx2 file is generated from the binary
      Lparameters tcProp, tcValue, tcComentario
      Local lcValue, I
      tcComentario    = ''

      *-- Strip unused characters
      *IF INLIST(tcValue, '..\', '..\..\' ) THEN
      *   MESSAGEBOX( 'Found value "' + tcValue + '" in property "' + tcProp, 4096, PROGRAM() )
      *   tcValue = ''
      *ENDIF

      *-- Adjustments for some special cases
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
         *-- Special Fox value with CHR(1) header: strip it and normalize the value
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
      *-- NORMALIZES the given text, compressing special XML entities.
      tcValor = Strtran(tcValor, Chr(38), Chr(38) + 'amp;')   && replace &  with  &amp;      &&
      tcValor = Strtran(tcValor, Chr(39), Chr(38) + 'apos;')  && replace '  with  &apos;     &&
      tcValor = Strtran(tcValor, Chr(34), Chr(38) + 'quot;')  && replace "  with  &quot;     &&
      tcValor = Strtran(tcValor, '<', Chr(38) + 'lt;')        &&  replace <  with  &lt;      &&
      tcValor = Strtran(tcValor, '>', Chr(38) + 'gt;')        &&  replace >  with  &gt;      &&
      tcValor = Strtran(tcValor, Chr(13)+Chr(10), Chr(10))    && replace CR+LF with LF
      tcValor = Chrtran(tcValor, Chr(13), Chr(10))            && replace CR with LF

      Return tcValor
   Endproc



   Function rowTimeStamp(ltDateTime)
      * Generate a FoxPro 3.0-style row timestamp
      *-- CONVERTS A DATETIME VALUE INTO THE NUMERIC TIMESTAMP USED BY SCX/VCX/etc. FILES
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
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcOperation               (v! IN    ) Operation to perform ("SETNAME" or "GETNAME")
      * tcPropName                (v! IN    ) Property name
      *--------------------------------------------------------------------------------------------------------------
      Lparameters tcOperation, tcPropName
      Try
         Local lcPropName, lcClass, lnPos ;
            , loEx As Exception ;
            , loLang As CL_LANG Of 'cl_lang.prg'

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
               *-- Support for per-class property sort evaluation
               This.ensureSpecialProps()
               lnPos = This.o_SpecialProps.getPropSortIndex( This.c_ClaseActual, lcPropName )

               *-- Builds a property in the form "A nnn Property", where higher values sort last,
               *-- so native props come first, then user props, and finally "name", which is special.
               *-- Ej: "A004ScaleMode", ..., "A998UserProp", "A999Name"
               lcPropName  = 'A' + Padl( Evl(lnPos,998), 3, '0' ) + lcPropName
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
      * 02/12/2013    FDBOZZO     Fidel Charny reported an example where properties are physically lost
      *                           when sorted alphabetically in an ADD OBJECT. It loses "picture" and others.
      *                           It seems the last one must be "Name".
      *--------------------------------------------------------------------------------------------------------------
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * taPropsAndValues          (!@ IN    ) Array of object or class properties and values
      * tnPropsAndValues_Count    (v! IN    ) Number of properties
      * tnSortType                (v! IN    ) Sort type:
      *                                           0=Only separate class properties from object properties (.)
      *                                           1=Full property sort (for the TEXT version)
      *                                           2=Full property sort with "Name" last (for the BIN version)
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
               * WITH SORT:
               * - Prefix entries without '.' with 'A', and the rest with 'B' so they sort last

               * WARNING:  10/07/2018
               * With multi-container ADD OBJECT (obj.obj.obj...), reordering
               * can cause collateral damage, such as misplaced objects.
               * (Expected: not everything can be sorted alphabetically)
               * A compromise could be to at least keep same-named objects together,
               * which in practice may all be mixed up. At least that would not break anything.
               * SEE: https://github.com/fdbozzo/foxbin2prg/issues/28
               *
               * STEP 1: Collect unique names and assign a sort code
               Create Cursor C_OBJ (OBJNAME C(50), IORDER I Autoinc)
               Index On OBJNAME Tag OBJNAME

               * STEP 2: Set sort priorities (properties first, then objects)
               For I = 1 To m.tnPropsAndValues_Count
                  If '.' $ laPropsAndValues(m.I,1)
                     If m.tnSortType = 2
                        * Build obj+props for BIN
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
                        * Build obj+props for TX2
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
                        * Build obj+props for BIN
                        laPropsAndValues(m.I,1) = .sortPropsAndValues_SetAndGetSCXPropNames( 'SETNAME', laPropsAndValues(m.I,1) )
                     Else
                        * Build obj+props for TX2
                        laPropsAndValues(m.I,1) = 'A000' + laPropsAndValues(m.I,1)
                     Endif
                  Endif
               Endfor

               * Step 3: Sort by the previous priority
               If .l_PropSort_Enabled
                  Asort( laPropsAndValues, 1, -1, 0, 1)
               Endif


               * Step 4: Remove metadata and rebuild the array
               For I = 1 To m.tnPropsAndValues_Count
                  *-- Remove characters added before SORT
                  If '.' $ laPropsAndValues(m.I,1)
                     If m.tnSortType = 2
                        * Build obj+props for BIN
                        taPropsAndValues(m.I,1) = Juststem( Substr( laPropsAndValues(m.I,1), 2+3 ) ) + '.' ;
                           + .sortPropsAndValues_SetAndGetSCXPropNames( 'GETNAME', Justext(laPropsAndValues(m.I,1)) )
                     Else
                        * Build obj+props for TX2
                        taPropsAndValues(m.I,1) = Substr( laPropsAndValues(m.I,1), 2+3 )
                     Endif
                  Else
                     If m.tnSortType = 2
                        * Build obj+props for BIN
                        taPropsAndValues(m.I,1) = .sortPropsAndValues_SetAndGetSCXPropNames( 'GETNAME', laPropsAndValues(m.I,1) )
                     Else
                        * Build obj+props for TX2
                        taPropsAndValues(m.I,1) = Substr( laPropsAndValues(m.I,1), 2+3 )
                     Endif
                  Endif

                  taPropsAndValues(m.I,2) = laPropsAndValues(m.I,2)

                  If lnArrayCols >= 3
                     taPropsAndValues(m.I,3) = laPropsAndValues(m.I,3)
                  Endif
               Endfor

            Else    && m.tnSortType = 0
               *-- WITHOUT SORT: Create 2 arrays, the main one and a temp one, then append temp to main.
               *-- Must separate normal props from object props (happens with ADD OBJECT)
               X   = 0

               *-- FIRST those without a dot
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

               *-- THEN the remaining props.
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



   Procedure ensureSpecialProps
      IF VARTYPE(This.o_SpecialProps) = 'O' AND !ISNULL(This.o_SpecialProps)
         RETURN
      ENDIF

      IF PEMSTATUS(This, 'o_Host', 5) AND VARTYPE(This.o_Host) = 'O' ;
            AND PEMSTATUS(This.o_Host, 'ensureSpecialProps', 5)
         This.o_Host.ensureSpecialProps()
         This.o_SpecialProps = This.o_Host.o_SpecialProps
         RETURN
      ENDIF

      This.o_SpecialProps = NewObject('cl_fb2prg_special_props', 'cl_fb2prg_special_props.prg', This.c_Foxbin2prg_FullPath )
   Endproc



   Procedure writeLog
      Lparameters tcText, tnTimeStamp

      Try
         With This As c_conversor_base Of 'c_conversor_base.prg'
            *-- Based on nTimestamp:
            *-- 0 = No timestamp
            *-- 1 = Timestamp prefix
            *-- 2 = Timestamp suffix
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
         With This As conversor_base Of 'conversor_base.prg'
            .c_TextErr  = .c_TextErr + Evl(tcText,'') + CR_LF
            .l_Error    = .T.
         Endwith
      Catch
      Endtry
   Endproc



   Procedure makeDirTree
      *---------------------------------------------------------------------------------------------------
      * Recursively creates the indicated directory tree (if it does not exist).
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcDir                     (v! IN    ) Folder to create (may include several missing levels)
      *---------------------------------------------------------------------------------------------------
      Lparameters tcDir
      Local lcDir, lnLevels, I, lcPartial, laParts(1)

      lcDir   = Rtrim( Evl(tcDir,''), 0, ' ', '\', '/' )

      If Empty(lcDir)
         Return .F.
      Endif

      *-- If it already exists, do nothing
      If Directory(lcDir) Or ( Vartype(This.oFSO) = 'O' And This.oFSO.FolderExists(lcDir) )
         Return .T.
      Endif

      *-- Build level by level. Keep the drive/UNC prefix of the first segment intact.
      lnLevels    = Alines( laParts, Chrtran( lcDir, '/', '\' ), 1, '\' )
      lcPartial   = ''

      For I = 1 To lnLevels
         If I = 1
            lcPartial   = laParts(1)             && drive (C:) or first UNC segment
         Else
            lcPartial   = lcPartial + '\' + laParts(m.I)
         Endif

         *-- Skip the drive prefix ("C:") and empty UNC path segments (\\server)
         If Right(lcPartial,1) == ':' Or Empty(laParts(m.I))
            Loop
         Endif

         If Not Directory(lcPartial)
            *-- A plain file with the same name blocks MD/CreateFolder (e.g. library.vc2 -> library.vc2\)
            If File(lcPartial)
               Erase (lcPartial)
            Endif
            Try
               If Vartype(This.oFSO) = 'O' And Not This.oFSO.FolderExists(lcPartial)
                  This.oFSO.CreateFolder( Lower(lcPartial) )
               Else
                  Md (Lower(lcPartial))
               Endif
            Catch
               *-- Ignore "already exists" errors caused by concurrency
            Endtry
         Endif
      Endfor

      Release lcDir, lnLevels, I, lcPartial, laParts
      Return Directory( Rtrim(tcDir,0,' ','\','/') )
   Endproc



   Procedure get_MirroredOutputFile
      *---------------------------------------------------------------------------------------------------
      * Returns the final output path applying cOutputFolder.
      *   - If cInputRoot is set and the file hangs off that root, REPLICATE the subfolder
      *     structure under cOutputFolder (mirrored tree).
      *   - Otherwise, use the historical behavior: flatten with FORCEPATH.
      * Also creates the destination directory tree if it does not exist.
      * PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
      * tcOutputFile              (v! IN    ) Original output path (same folder as the source)
      *---------------------------------------------------------------------------------------------------
      Lparameters tcOutputFile
      Local lcResult, lcRoot, lcDir, lcRel, lcOutDir

      lcResult    = tcOutputFile

      If Empty(This.cOutputFolder)
         Return lcResult
      Endif

      lcRoot      = Addbs( Upper( Fullpath( Evl(This.cInputRoot,'') ) ) )
      lcDir       = Addbs( Upper( Fullpath( Justpath(tcOutputFile) ) ) )

      Do Case
      Case Not Empty(This.cInputRoot) And Left( lcDir, Len(lcRoot) ) == lcRoot
         *-- File hangs off the project root: keep its relative subpath
         lcRel       = Substr( lcDir, Len(lcRoot) )
         lcResult    = Addbs( This.cOutputFolder ) + Iif( Empty(lcRel), '', lcRel ) + Justfname(tcOutputFile)

      Otherwise
         *-- No root, or file is outside it: historical behavior (flattened)
         lcResult    = Forcepath( tcOutputFile, This.cOutputFolder )

      Endcase

      *-- Ensure the destination folder exists (and is not blocked by a previous plain file)
      lcOutDir    = Justpath(lcResult)
      If File(lcOutDir) And Not Directory(lcOutDir)
         Erase (lcOutDir)
      Endif
      This.makeDirTree( lcOutDir )

      Release lcRoot, lcDir, lcRel
      Return lcResult
   Endproc

Enddefine
