#INCLUDE foxbin2prg.h

Define Class CL_MENU_BARPOP As CL_MENU_COL_BASE OF 'cl_menu_col_base.prg'
   _MemberData = [<VFPData>] ;
      + [<memberdata name="analyzecodeblock_definepopup" display="analyzeCodeBlock_DefinePOPUP"/>] ;
      + [<memberdata name="updatemenu" display="updateMENU"/>] ;
      + [<memberdata name="c_parentname" display="c_ParentName"/>] ;
      + [<memberdata name="n_parentcode" display="n_ParentCode"/>] ;
      + [<memberdata name="n_parenttype" display="n_ParentType"/>] ;
      + [</VFPData>]

   #If .F.
      Local This As CL_MENU_BARPOP Of 'cl_menu_barpop.prg'
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
      External Array taCodeLines

      #If .F.
         Local toConversor As c_conversor_prg_a_mnx Of 'c_conversor_prg_a_mnx.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcSubName, lcComment, lnLast_I, loReg, lcExpr, lcProcName, lcProcCode, lcMenuType ;
            , loEx As Exception ;
            , loOption As CL_MENU_OPTION Of 'cl_menu_option.prg'
         Store .Null. To loOption
         Store '' To lcSubName, lcComment, lcExpr, lcProcName, lcProcCode

         With This As CL_MENU_BARPOP Of 'cl_menu_barpop.prg'
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
                  loOption    = NewObject('CL_MENU_OPTION','cl_menu_option.prg')
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
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg' ;
            , loOption As CL_MENU_OPTION Of 'cl_menu_option.prg'
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
