#INCLUDE foxbin2prg.h

Define Class CL_DBF_RECORD As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_DBF_RECORD Of 'cl_dbf_record.prg'
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
      External Array taCodeLines

      #If .F.
         Local toFields As CL_DBF_FIELDS Of 'cl_dbf_fields.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcFieldName, lcValue, luValue, llOneLineOnly, loEx As Exception ;
            , loField As CL_DBF_FIELD Of 'cl_dbf_field.prg'
         Store '' To lcFieldName, lcValue

         *!* Changed by: LScheffler 21.02.2021
         *!* change date="{^2021-02-21,10:57:00}"
         * additional options controlling
         * - new operations of DBF, handle include of deleted records
         * Note, the inclusion of records deleted is done in the method calling, so here it will just be read
         If '<RECORD' $ tcLine Or '<DELRECORD' $ tcLine
            *!* /Changed by: LScheffler 21.02.2021
            llBloqueEncontrado  = .T.

            With This As CL_DBF_RECORD Of 'cl_dbf_record.prg'
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

         With This As CL_DBF_RECORD Of 'cl_dbf_record.prg'
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
      External Array taCodeLines
      tcLine  = taCodeLines(m.I)
   Endproc


Enddefine
