#INCLUDE 'foxbin2prg.h'

Define Class CL_MENU_OPTION As CL_MENU_COL_BASE OF 'cl_menu_col_base.prg'
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
      Local This As CL_MENU_OPTION Of 'cl_menu_option.prg'
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
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg'
         Store .Null. To loBarPop
         Store '' To lcComment

         With This As CL_MENU_OPTION Of 'cl_menu_option.prg'
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
                  loBarPop    = NewObject('CL_MENU_BARPOP','cl_menu_barpop.prg')
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

            With This As CL_MENU_OPTION Of 'cl_menu_option.prg'
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

            With This As CL_MENU_OPTION Of 'cl_menu_option.prg'
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
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg' ;
            , loOption As CL_MENU_OPTION Of 'cl_menu_option.prg'
         Store .Null. To loOption, loBarPop, loReg
         lcText      = ''
         lcProcName  = ''

         With This As CL_MENU_OPTION Of 'cl_menu_option.prg'
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
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg' ;
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
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg' ;
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
