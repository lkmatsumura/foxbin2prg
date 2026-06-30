#INCLUDE foxbin2prg.h

Define Class CL_MENU_COL_BASE As CL_COL_BASE Of 'cl_col_base.prg'
   _MemberData = [<VFPData>] ;
      + [<memberdata name="oreg" display="oReg"/>] ;
      + [<memberdata name="analizarsiexpresionescomandooprocedimiento" display="AnalizarSiExpresionEsComandoOProcedimiento"/>] ;
      + [<memberdata name="get_datafromtablabin" display="get_DataFromTablabin"/>] ;
      + [<memberdata name="updatemenu" display="updateMENU"/>] ;
      + [</VFPData>]


   #If .F.
      Local This As CL_MENU_COL_BASE Of 'CL_MENU_COL_BASE.PRG'
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
            , loBarPop As CL_MENU_BARPOP Of 'cl_menu_barpop.prg' ;
            , loOption As CL_MENU_OPTION Of 'cl_menu_option.prg'
         Store .Null. To loOption, loBarPop

         With This As CL_MENU_COL_BASE Of 'CL_MENU_COL_BASE.PRG'
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
                  loBarPop    = NewObject('CL_MENU_BARPOP','cl_menu_barpop.prg')
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
                  loOption    = NewObject('CL_MENU_OPTION','cl_menu_option.prg')
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
      If Not Empty(tcProcCode)
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
               tcProcCode  = tcProcCode + Rtrim( laProcLines(m.I), 0, Chr(9), ' ' ) + CR_LF
            Endfor

         Case tnIndentation > 0
            For I = 1 To lnLine_Count
               *-- Indentar
               tcProcCode  = tcProcCode + C_TAB + Rtrim( laProcLines(m.I), 0, Chr(9), ' ' ) + CR_LF
            Endfor

         Otherwise
            For I = 1 To lnLine_Count
               *-- Quitar indentación
               If Inlist( Left(laProcLines(m.I),1), Space(1), C_TAB )
                  tcProcCode  = tcProcCode + Rtrim( Substr( laProcLines(m.I), 2 ), 0, Chr(9), ' ' ) + CR_LF
               Else
                  tcProcCode  = tcProcCode + Rtrim( laProcLines(m.I), 0, Chr(9), ' ' ) + CR_LF
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
