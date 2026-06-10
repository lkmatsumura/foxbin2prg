#INCLUDE foxbin2prg.h

Define Class CL_MENU As CL_MENU_COL_BASE OF 'cl_menu_col_base.prg'
   #If .F.
      Local This As CL_MENU Of 'cl_menu.prg'
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
            , loOptions As CL_MENU_OPTION Of 'cl_menu_option.prg' ;
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg'
         Store .Null. To loBarPop, loOptions
         Store '' To lcComment

         llBloqueEncontrado  = .T.

         With This As CL_MENU Of 'cl_menu.prg'
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
      
      EXTERNAL ARRAY taCodeLines

      #If .F.
         Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
      #Endif

      Try
         Local llBloqueEncontrado, lcText, lcComment, loEx As Exception
         Store '' To lcText, lcComment

         If Left(tcLine, Len(C_SETUPCODE_I)) == C_SETUPCODE_I
            llBloqueEncontrado  = .T.

            With This As CL_MENU Of 'cl_menu.prg'
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

      EXTERNAL ARRAY taCodeLines

      #If .F.
         Local toConversor As c_conversor_prg_a_mnx Of 'FOXBIN2PRG.PRG'
      #Endif

      Try
         Local llBloqueEncontrado, lcText, lcComment, loEx As Exception
         Store '' To lcText, lcComment

         If Left(tcLine, Len(C_CLEANUPCODE_I)) == C_CLEANUPCODE_I
            llBloqueEncontrado  = .T.

            With This As CL_MENU Of 'cl_menu.prg'
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
            , loOptions As CL_MENU_OPTION Of 'cl_menu_option.prg' ;
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg'
         Store .Null. To loBarPop, loOptions
         Store '' To lcExpr, lcProcName, lcProcCode, lcComment

         With This As CL_MENU Of 'cl_menu.prg'
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
                     loBarPop    = NewObject('CL_MENU_BARPOP','cl_menu_barpop.prg')
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
                     loBarPop    = NewObject('CL_MENU_BARPOP','cl_menu_barpop.prg')
                     loBarPop.c_ParentName   = ''
                     loBarPop.n_ParentCode   = .oReg.OBJCODE
                     loBarPop.n_ParentType   = .oReg.ObjType
                     loBarPop.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, @tnCodeLines, toConversor )
                     .Add( loBarPop )

                     *-- Creo option
                     loOption        = .Null.
                     loOption        = NewObject('CL_MENU_OPTION','cl_menu_option.prg')
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
                     loBarPop        = NewObject('CL_MENU_BARPOP','cl_menu_barpop.prg')
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

            With This As CL_MENU Of 'cl_menu.prg'
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
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg' ;
            , loOption As CL_MENU_OPTION Of 'cl_menu_option.prg'
         Store .Null. To loOption, loBarPop, loCol_LastLevelName
         Store '' To lcText, lcEndProcedures

         With This As CL_MENU Of 'cl_menu.prg'
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

      With This As CL_MENU Of 'cl_menu.prg'
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
         With This As CL_MENU Of 'cl_menu.prg'
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
