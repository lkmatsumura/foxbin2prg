#INCLUDE foxbin2prg.h

Define Class c_conversor_bin_a_prg As c_conversor_base Of 'c_conversor_base.prg'
   #If .F.
      Local This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   #Endif

   _MemberData = [<VFPData>] ;
               + [<memberdata name="convert" display="convert"/>] ;
               + [<memberdata name="classify_pam_hidden_protected" display="classify_PAM_Hidden_Protected"/>] ;
               + [<memberdata name="exception2str" display="exception2Str"/>] ;
               + [<memberdata name="get_add_object_methods" display="get_ADD_OBJECT_METHODS"/>] ;
               + [<memberdata name="get_class_methods" display="get_CLASS_METHODS"/>] ;
               + [<memberdata name="get_olepublicobjectname" display="get_OLEPublicObjectName"/>] ;
               + [<memberdata name="get_propsfrom_protected" display="get_PropsFrom_PROTECTED"/>] ;
               + [<memberdata name="get_propsandcommentsfrom_reserved3" display="get_PropsAndCommentsFrom_RESERVED3"/>] ;
               + [<memberdata name="get_propsandvaluesfrom_properties" display="get_PropsAndValuesFrom_PROPERTIES"/>] ;
               + [<memberdata name="ignoreincorrectdefinedobjects" display="ignoreIncorrectDefinedObjects"/>] ;
               + [<memberdata name="indentmemo" display="indentMemo"/>] ;
               + [<memberdata name="memoinoneline" display="memoInOneLine"/>] ;
               + [<memberdata name="method2array" display="method2Array"/>] ;
               + [<memberdata name="normalizeassignment" display="normalizeAssignment"/>] ;
               + [<memberdata name="set_multilinememowithaddobjectproperties" display="set_MultilineMemoWithAddObjectProperties"/>] ;
               + [<memberdata name="sortmethod" display="sortMethod"/>] ;
               + [<memberdata name="write_add_objects_withproperties" display="write_ADD_OBJECTS_WithProperties"/>] ;
               + [<memberdata name="write_all_object_methods" display="write_ALL_OBJECT_METHODS"/>] ;
               + [<memberdata name="write_classmetadata" display="write_CLASSMETADATA"/>] ;
               + [<memberdata name="write_class_properties" display="write_CLASS_PROPERTIES"/>] ;
               + [<memberdata name="write_dbc_header" display="write_DBC_HEADER"/>] ;
               + [<memberdata name="write_dbc_connections" display="write_DBC_CONNECTIONS"/>] ;
               + [<memberdata name="write_dbc_tables" display="write_DBC_TABLES"/>] ;
               + [<memberdata name="write_dbc_table_fields" display="write_DBC_TABLE_FIELDS"/>] ;
               + [<memberdata name="write_dbc_table_indexes" display="write_DBC_TABLE_INDEXES"/>] ;
               + [<memberdata name="write_dbc_views" display="write_DBC_VIEWS"/>] ;
               + [<memberdata name="write_dbc_view_fields" display="write_DBC_VIEW_FIELDS"/>] ;
               + [<memberdata name="write_dbc_view_indexes" display="write_DBC_VIEW_INDEXES"/>] ;
               + [<memberdata name="write_dbc_relations" display="write_DBC_RELATIONS"/>] ;
               + [<memberdata name="write_dbf_header" display="write_DBF_HEADER"/>] ;
               + [<memberdata name="write_dbf_fields" display="write_DBF_FIELDS"/>] ;
               + [<memberdata name="write_dbf_indexes" display="write_DBF_INDEXES"/>] ;
               + [<memberdata name="write_defined_pam" display="write_DEFINED_PAM"/>] ;
               + [<memberdata name="write_define_class" display="write_DEFINE_CLASS"/>] ;
               + [<memberdata name="write_define_class_comments" display="write_Define_Class_COMMENTS"/>] ;
               + [<memberdata name="write_oleobjectdefinitions" display="write_OLEObjectDefinitions"/>] ;
               + [<memberdata name="write_enddefine_ifapplicable" display="write_ENDDEFINE_IfApplicable"/>] ;
               + [<memberdata name="write_external_class_header" display="write_EXTERNAL_CLASS_HEADER"/>] ;
               + [<memberdata name="write_external_member_header" display="write_EXTERNAL_MEMBER_HEADER"/>] ;
               + [<memberdata name="write_hidden_properties" display="write_HIDDEN_Properties"/>] ;
               + [<memberdata name="write_include" display="write_INCLUDE"/>] ;
               + [<memberdata name="write_objectmetadata" display="write_OBJECTMETADATA"/>] ;
               + [<memberdata name="write_outputfile" display="write_OutputFile"/>] ;
               + [<memberdata name="write_protected_properties" display="write_PROTECTED_Properties"/>] ;
               + [</VFPData>]


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@    OUT) Objeto generado de clase correspondiente con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )
   Endproc


   Procedure classify_PAM_Hidden_Protected
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tnPropsAndValues_Count    (@! IN    )
      * taPropsAndValues          (@! IN    )
      * tnProtected_Count         (@! IN    )
      * taProtected               (@! IN    )
      * tnPropsAndComments_Count  (@! IN    )
      * taPropsAndComments        (@! IN    )
      * tcHiddenProp              (@!    OUT) Lista de propiedades Hidden
      * tcProtectedProp           (@!    OUT) Lista de propiedades Protected
      *---------------------------------------------------------------------------------------------------
      Lparameters tnPropsAndValues_Count, taPropsAndValues, tnProtected_Count, taProtected ;
         , tnPropsAndComments_Count, taPropsAndComments, tcHiddenProp, tcProtectedProp

      If tnPropsAndValues_Count > 0 Then
         *-- Recorro las propiedades (campo Properties) para ir conformando
         *-- las definiciones HIDDEN y PROTECTED
         Local lcProp, I

         Store '' To tcHiddenProp, tcProtectedProp

         For I = 1 To tnProtected_Count
            Do Case
            Case Empty( taProtected(m.I) )
               Loop

            Case Right( taProtected(m.I), 1 ) == '^'
               *-- Hidden Property or method
               lcProp  = Chrtran( taProtected(m.I), '^', '' )
               If Ascan(taPropsAndComments, '*' + lcProp, 1, 0, 1, 1+2+4) > 0
                  Loop    && method
               Endif
               tcHiddenProp    = tcHiddenProp + ',' + lcProp

            Otherwise
               *-- Protected Property or method
               If Ascan(taPropsAndComments, '*' + taProtected(m.I), 1, 0, 1, 1+2+4) > 0
                  Loop    && method
               Endif
               tcProtectedProp = tcProtectedProp + ',' + taProtected(m.I)
            Endcase
         Endfor

      Endif
   Endproc



   Procedure get_ADD_OBJECT_METHODS
      Lparameters toRegObj, toRegClass, tcMethods, taMethods, taCode, tnMethodCount ;
         , taPropsAndComments, tnPropsAndComments_Count, taProtected, tnProtected_Count ;
         , toFoxBin2Prg

      External Array taPropsAndComments, taProtected

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcMethodName, lnMethodCount

         With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
            lnMethodCount   = tnMethodCount
            .method2Array( toRegObj.METHODS, @taMethods, @taCode, '', @tnMethodCount ;
               , @taPropsAndComments, tnPropsAndComments_Count, @taProtected, tnProtected_Count, @toFoxBin2Prg, @toRegObj )

            *-- Ubico los métodos protegidos y les cambio la definición.
            *-- Los métodos se deben generar con la ruta completa, porque si no es imposible saber a que objeto corresponden,
            *-- o si son de la clase.
            If tnMethodCount - lnMethodCount > 0 Then
               For I = lnMethodCount + 1 To tnMethodCount
                  If taMethods(m.I,2) = 0
                     Loop
                  Endif

                  If Empty(toRegObj.Parent)
                     lcMethodName    = toRegObj.OBJNAME + '.' + taMethods(m.I,1)
                  Else
                     Do Case
                     Case '.' $ toRegObj.Parent
                        lcMethodName    = Substr(toRegObj.Parent, At('.', toRegObj.Parent) + 1) + '.' + toRegObj.OBJNAME + '.' + taMethods(m.I,1)

                     Case Lower( Left(toRegObj.Parent + '.', Len( toRegClass.OBJNAME + '.' ) ) ) == Lower( toRegClass.OBJNAME + '.' )
                        lcMethodName    = toRegObj.OBJNAME + '.' + taMethods(m.I,1)

                     Otherwise
                        lcMethodName    = toRegObj.Parent + '.' + toRegObj.OBJNAME + '.' + taMethods(m.I,1)

                     Endcase
                  Endif

                  *-- Genero el método SIN indentar, ya que se hace luego
                  taCode(taMethods(m.I,2))    = 'PROCEDURE ' + lcMethodName + CR_LF + .indentMemo( taCode(taMethods(m.I,2)) ) + CR_LF + 'ENDPROC'
                  taMethods(m.I,1)    = lcMethodName
               Endfor
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toRegObj, toRegClass, tcMethods, taMethods, taCode, tnMethodCount ;
            , taPropsAndComments, tnPropsAndComments_Count, taProtected, tnProtected_Count ;
            , toFoxBin2Prg, lcMethodName, lnMethodCount
      Endtry

      Return
   Endproc



   Procedure get_CLASS_METHODS
      Lparameters tnMethodCount, taMethods, taCode, taProtected, taPropsAndComments, toFoxBin2Prg
      *-- DEFINIR MÉTODOS DE LA CLASE
      *-- Ubico los métodos protegidos y les cambio la definición
      External Array taMethods, taCode, taProtected, taPropsAndComments

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcMethod, lcMethodName, lnProtectedItem, lnCommentRow, lcProcDef, lcMethods, lnLen
         Store '' To lcMethod, lcMethodName, lcProcDef, lcMethods

         If tnMethodCount > 0 Then
            With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
               For I = 1 To tnMethodCount
                  lcMethodName    = Chrtran( taMethods(m.I,1), '^', '' )
                  lnProtectedItem = Ascan( taProtected, taMethods(m.I,1), 1, 0, 0, 1+2+4)

                  If lnProtectedItem = 0
                     lnProtectedItem = Ascan( taProtected, taMethods(m.I,1) + '^', 1, 0, 0, 1+2+4)

                     If lnProtectedItem = 0
                        *-- Método común
                        lcProcDef   = 'PROCEDURE'
                     Else
                        *-- Método oculto
                        lcProcDef   = 'HIDDEN PROCEDURE'
                     Endif
                  Else
                     *-- Método protegido
                     lcProcDef   = 'PROTECTED PROCEDURE'
                  Endif

                  lnCommentRow   = Ascan( taPropsAndComments, '*' + lcMethodName, 1, 0, 1, 1+2+4+8)

                  *-- Nombre del método
                  lcMethod    = lcProcDef + ' ' + taMethods(m.I,1)

                  *-- Comentarios del método (si tiene)
                  If lnCommentRow > 0 And Not Empty(taPropsAndComments(lnCommentRow,2))
                     * PRG_Compat_Level >= 1
                     If Bitand(toFoxBin2Prg.getCfgValue('n_PRG_Compat_Level'), 1) > 0
                        lcMethod    = lcMethod + C_TAB + C_TAB + 'HELPSTRING "' + taPropsAndComments(lnCommentRow,2) + '"'
                     Else
                        * PRG_Compat_Level = 0 (Default old setting)
                        lcMethod    = lcMethod + C_TAB + C_TAB + '&' + '& ' + taPropsAndComments(lnCommentRow,2)
                     Endif
                  Endif

                  *-- Código del método
                  If taMethods(m.I,2) > 0 Then
                     taCode(taMethods(m.I,2))    = lcMethod + CR_LF + .indentMemo( taCode(taMethods(m.I,2)) ) + CR_LF + 'ENDPROC'
                  Else
                     lnLen   = Alen(taCode,1) + 1
                     Dimension taCode( lnLen )
                     taCode( lnLen ) = lcMethod + CR_LF + 'ENDPROC'
                     taMethods(m.I,2)    = lnLen
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
         Release tnMethodCount, taMethods, taCode, taProtected, taPropsAndComments ;
            , lcMethod, lcMethodName, lnProtectedItem, lnCommentRow, lcProcDef, lcMethods, lnLen
      Endtry

      Return
   Endproc



   Procedure get_OLEPublicObjectName
      Lparameters ta_NombresObjsOle
      *-- Obtengo los objetos "OLEPublic"
      Local I

      Select Padr(OBJNAME,100) OBJNAME ;
         FROM TABLABIN ;
         WHERE TABLABIN.PLATFORM = "COMMENT" And TABLABIN.RESERVED2 == "OLEPublic" ;
         ORDER By 1 ;
         INTO Array ta_NombresObjsOle

      For I = 1 To _Tally
         ta_NombresObjsOle(m.I)  = Alltrim( ta_NombresObjsOle(m.I) )
      Endfor

      Return
   Endproc



   Procedure get_PropsAndCommentsFrom_RESERVED3
      *-- Sirve para el memo RESERVED3
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcMemo                    (v! IN    ) Contenido de un campo MEMO
      * tlSort                    (v? IN    ) Indica si se deben ordenar alfabéticamente los nombres
      * taPropsAndComments        (!@    OUT) Array con las propiedades y comentarios
      * tnPropsAndComments_Count  (!@    OUT) Cantidad de propiedades
      * tcSortedMemo              (@?    OUT) Contenido del campo memo ordenado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcMemo, tlSort, taPropsAndComments, tnPropsAndComments_Count, tcSortedMemo

      External Array taPropsAndComments

      Try
         Local laLines(1), I, lnPos, loEx As Exception
         tcSortedMemo = ''
         tnPropsAndComments_Count = Alines(laLines, tcMemo, 1+4)

         If tnPropsAndComments_Count <= 1 And Empty(laLines)
            tnPropsAndComments_Count = 0
            Exit
         Endif

         Dimension taPropsAndComments(tnPropsAndComments_Count,2)

         For I = 1 To tnPropsAndComments_Count
            lnPos = At(' ', laLines(m.I)) && Un espacio separa la propiedad de su comentario (si tiene)

            If lnPos = 0
               taPropsAndComments(m.I,1) = Lower( laLines(m.I) )
               taPropsAndComments(m.I,2) = ''
            Else
               taPropsAndComments(m.I,1) = Lower( Left( laLines(m.I), lnPos - 1 ) )
               taPropsAndComments(m.I,2) = Substr( laLines(m.I), lnPos + 1 )
            Endif
         Endfor

         If tlSort And This.l_PropSort_Enabled
            Asort( taPropsAndComments, 1, -1, 0, 1 )
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcMemo, tlSort, taPropsAndComments, tnPropsAndComments_Count, tcSortedMemo ;
            , laLines, I, lnPos, loEx
      Endtry

      Return
   Endproc



   Procedure get_PropsAndValuesFrom_PROPERTIES
      *-- Sirve para el memo PROPERTIES
      *---------------------------------------------------------------------------------------------------
      * KNOWLEDGE BASE:
      * 29/11/2013    FDBOZZO     En un pageframe, si las props.nativas del mismo no están antes que las de
      *                           los objetos contenidos, causa un error. Se deben ordenar primero las
      *                           props.nativas (sin punto) y luego las de los objetos (con punto)
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcMemo                    (v! IN    ) Contenido de un campo MEMO
      * tnSort                    (v? IN    ) Indica si se deben ordenar alfabéticamente los objetos y props (1), o no (0)
      * taPropsAndValues          (!@    OUT) Array con las propiedades y comentarios
      * tnPropsAndValues_Count    (!@    OUT) Cantidad de propiedades
      * tcSortedMemo              (?@    OUT) Contenido del campo memo ordenado
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters tcMemo, tnSort, taPropsAndValues, tnPropsAndValues_Count, tcSortedMemo, toFoxBin2Prg

      External Array taPropsAndValues

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local laItems(1), I, X, lnLenAcum, lnPosEQ, lcPropName, lnLenVal, lcValue, lcMethods, lcLastIncompletePropName
         Store '' To tcSortedMemo, lcLastIncompletePropName
         tnPropsAndValues_Count  = 0

         If Not Empty(m.tcMemo)
            With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
               lnItemCount = Alines(laItems, m.tcMemo, 0, CR_LF)   && Específicamente CR+LF para que no reconozca los CR o LF por separado
               X   = 0

               If lnItemCount <= 1 And Empty(laItems)
                  lnItemCount = 0
                  Exit
               Endif


               *-- 1) OBTENCIÓN Y SEPARACIÓN DE PROPIEDADES Y VALORES
               *-- Crear un array con los valores especiales que pueden estar repartidos entre varias lineas
               For I = 1 To m.lnItemCount
                  If Empty( laItems(m.I) )
                     Loop
                  Endif

                  If C_MPROPHEADER $ laItems(m.I)
                     *-- Solo entrará por aquí cuando se evalúe una propiedad de PROPERTIES con un valor especial (largo)
                     lnLenAcum   = 0
                     lnPosEQ     = At( '=', laItems(m.I) )
                     lcPropName  = lcLastIncompletePropName + Left( laItems(m.I), lnPosEQ - 2 )
                     lnLenVal    = Int( Val( Substr( laItems(m.I), lnPosEQ + 2 + 517, 8) ) )
                     lcValue     = Substr( laItems(m.I), lnPosEQ + 2 + 517 + 8 )

                     If Len( lcValue ) < lnLenVal
                        *-- Como el valor es multi-línea, debo agregarle los CR_LF que le quitó el ALINES()
                        For I = m.I + 1 To m.lnItemCount
                           lcValue = lcValue + CR_LF + laItems(m.I)

                           If Len( lcValue ) >= lnLenVal
                              Exit
                           Endif
                        Endfor

                        lcValue = C_FB2P_VALUE_I + CR_LF + lcValue + CR_LF + C_FB2P_VALUE_F
                     Else
                        lcValue = C_FB2P_VALUE_I + lcValue + C_FB2P_VALUE_F
                     Endif

                     *-- Es un valor especial, por lo que se encapsula en un marcador especial
                     X   = m.X + 1
                     Dimension taPropsAndValues(m.X,2)
                     taPropsAndValues(m.X,1) = lcPropName
                     taPropsAndValues(m.X,2) = .normalizePropertyValue( lcPropName, lcValue, '' )

                  Else
                     *-- Propiedad normal
                     lnPosEQ                 = At( '=', laItems(m.I) )

                     If lnPosEQ = 0 Then
                        *-- AUTOFIX DE PROPIEDAD PARTIDA:
                        *-- Esto solo puede ocurrir cuando en el memo de Propiedades hay alguna propiedad
                        *-- partida debido a una edición manual con un Enter erróneo, algo como esto:
                        * comm
                        * AND2.Caption = "Command2"
                        *
                        *-- En el caso anterior, las 2 líneas son realmente una:
                        * command2.Caption = "Command2"
                        *
                        *-- Solución: Guardar esta parte del nombre y agregarlo a la próxima propiedad.
                        lcLastIncompletePropName    = laItems(m.I)
                        Loop
                     Endif

                     * Skip ZOrderSet property if configured to
                     If toFoxBin2Prg.getCfgValue('l_RemoveZOrderSetFromProps') And Atc( '.ZOrderSet.', '.' + lcLastIncompletePropName + Left( laItems(m.I), lnPosEQ - 2 ) + '.' ) > 0 Then
                        lcLastIncompletePropName    = ''
                        Loop
                     Endif

                     X   = m.X + 1
                     Dimension taPropsAndValues(m.X,2)
                     taPropsAndValues(m.X,1) = lcLastIncompletePropName + Left( laItems(m.I), lnPosEQ - 2 )
                     *!* Changed by: LScheffler 16.3.2023
                     *!* <pdm>
                     *!* <change date="{^2023-03-16,06:12:00}">Changed by: LScheffler<br />
                     *!* Problems with property values with leading and trailing spaces
                     *!* and with double ampersand in value
                     *!* we just do not LTRIM so we keep the leading space here<br/>
                     *!* see issues #90, #91
                     *!* </change>
                     *!* </pdm>

                     *                               taPropsAndValues(m.X,2) = .normalizePropertyValue( taPropsAndValues(m.X,1), Ltrim( Substr( laItems(m.I), lnPosEQ + 2 ) ), '' )
                     taPropsAndValues(m.X,2) = .normalizePropertyValue( taPropsAndValues(m.X,1), Substr( laItems(m.I), lnPosEQ + 2 ), '' )

                     *!* /Changed by: LScheffler 16.3.2023
                  Endif

                  lcLastIncompletePropName    = ''
               Endfor


               tnPropsAndValues_Count  = m.X
               lcMethods   = ''


               *-- 2) SORT
               .sortPropsAndValues( @taPropsAndValues, tnPropsAndValues_Count, tnSort )


               *-- Agregar propiedades primero
               For I = 1 To m.tnPropsAndValues_Count
                  tcSortedMemo    = m.tcSortedMemo + m.taPropsAndValues(m.I,1) + ' = ' + m.taPropsAndValues(m.I,2) + CR_LF
               Endfor

               *-- Agregar métodos al final
               tcSortedMemo    = m.tcSortedMemo + m.lcMethods

            Endwith && THIS
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcMemo, tnSort, taPropsAndValues, tnPropsAndValues_Count, tcSortedMemo ;
            , laItems, I, X, lnLenAcum, lnPosEQ, lcPropName, lnLenVal, lcValue, lcMethods
      Endtry

      Return
   Endproc



   Procedure get_PropsFrom_PROTECTED
      *---------------------------------------------------------------------------------------------------
      *-- Sirve para el memo PROTECTED
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcMemo                    (v! IN    ) Contenido de un campo MEMO
      * tlSort                    (v? IN    ) Indica si se deben ordenar alfabéticamente los nombres
      * taProtected               (!@    OUT) Array con las propiedades y comentarios
      * tnProtected_Count         (!@    OUT) Cantidad de propiedades
      * tcSortedMemo              (@?    OUT) Contenido del campo memo ordenado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcMemo, tlSort, taProtected, tnProtected_Count, tcSortedMemo

      External Array taProtected

      Local I
      tcSortedMemo        = ''
      tnProtected_Count   = Alines(taProtected, tcMemo, 1+4)

      If tnProtected_Count <= 1 And Empty(taProtected)
         tnProtected_Count   = 0
      Else
         If tlSort And This.l_PropSort_Enabled
            Asort( taProtected, 1, -1, 0, 1 )
         Endif

         For I = tnProtected_Count To 1 Step -1
            *-- El ASCAN es para evitar valores repetidos, que se eliminarán. v1.19.29
            taProtected(m.I)    = taProtected(m.I)
            If Ascan( taProtected, taProtected(m.I), 1, -1, 0, 1+2+4 ) = m.I
               tcSortedMemo    = tcSortedMemo + taProtected(m.I) + CR_LF
            Else
               Adel( taProtected, m.I )
               tnProtected_Count   = tnProtected_Count - 1
            Endif
         Endfor

         Dimension taProtected(tnProtected_Count)
      Endif

      Release tcMemo, tlSort, taProtected, tnProtected_Count, tcSortedMemo, I
      Return
   Endproc



   Procedure ignoreCorruptedObjects(lcCursor)
      * Issue#17 - Error, The specified key already exists
      * Para evitar este error se deben ignorar los objetos corruptos (duplicados)
      * Se identifican porque la clase principal el campo Reserved1 tiene vacio en vez de "Class"
      Local lcParentObjName, lcSetDeleted
      Select (lcCursor)
      lcSetDeleted    = Set("Deleted")
      Set Deleted Off

      *!* Changed by: LScheffler 25.2.2022
      *!* <pdm>
      *!* <change date="{^2022-02-25,15:57:00}">Changed by: LScheffler<br />
      *!* https://github.com/fdbozzo/foxbin2prg/issues/78 / After vc2 convert back to vcx class is corrupted no errors reported
      *!* Better named: Missing class when building text file from corrupted VCX
      *!* If the VCX is corrupted and holds empty records, the original coed will delete the next class.
      *!* This because the while clause for an empty OBJNAME deletes the record with the class itself, since this never has a PARENT
      *!* Solution is from bjornhoeksel, see issue
      *!* </change>
      *!* </pdm>

      *       Scan For PLATFORM = "WINDOWS" And Empty(Parent) And Empty(RESERVED1)
      *           lcParentObjName = Lower(OBJNAME)
      *           Delete
      *           Skip
      *           Delete Rest While Getwordnum(Lower(Parent) + '.', 1, '.') == lcParentObjName
      *           Skip -1
      *       Endscan

      Scan For PLATFORM = "WINDOWS" And Empty(Parent) And Empty(RESERVED1)
         lcParentObjName = Lower(OBJNAME)
         Delete
         If (Not Empty(lcParentObjName)) Then
            Skip
            Delete Rest While Getwordnum(Lower(Parent) + '.', 1, '.') == lcParentObjName
            Skip -1
         Endif
      Endscan
      *!* /Changed by: LScheffler 25.2.2022

      Set Deleted &lcSetDeleted.
      Return
   Endproc



   Procedure ignoreIncorrectDefinedObjects(lcCursor)
      * Issue#15 - VFP Designer ignored objects should be ignored by FoxBin2Prg
      Local lcObjName, lcParent, lcParentObjName, loObjs As Collection
      loObjs      = Createobject("Collection")
      Select (lcCursor)

      Scan For PLATFORM = "WINDOWS"
         lcObjName   = Lower(OBJNAME)
         lcParent    = Lower(Parent)

         If Empty(lcParent)
            lcParentObjName = lcObjName
         Else
            lcParentObjName = lcParent + '.' + lcObjName
         Endif

         If Not Empty(lcParent)
            * Tiene Parent, y debe existir, si no es ignorado
            * NOTA: Del parent solo se puede comprobar el objeto primario.
            If loObjs.GetKey(Getwordnum(lcParent + '.', 1, '.')) > 0
               * Existe: se agrega al array el nuevo objeto
               * NOTA: Podría estar duplicado, pero no se trata ese caso aquí
               If Not Empty(lcParentObjName) And loObjs.GetKey(lcParentObjName) = 0
                  loObjs.Add( '', lcParentObjName )
               Endif
            Else
               * No existe: se ignora
               Delete
            Endif
         Else
            * No Existe: se agrega al array
            If Not Empty(lcParentObjName) And loObjs.GetKey(lcParentObjName) = 0
               loObjs.Add( '', lcParentObjName )
            Endif

         Endif
      Endscan

      Return
   Endproc



   Procedure indentMemo
      Lparameters tcMethod, tcIndentation, tlKeepProcHeader
      *-- INDENTA EL CÓDIGO DE UN MÉTODO DADO Y QUITA LA CABECERA DE MÉTODO (PROCEDURE/ENDPROC) SI LA ENCUENTRA
      Try
         Local I, X, lcMethod, llProcedure, lnInicio, lnFin, laLineas(1), lnOffset ;
            , loLang As CL_LANG Of 'cl_lang.prg'

         loLang          = _Screen.o_FoxBin2Prg_Lang
         lcMethod        = ''
         lnInicio        = 1
         lnOffset        = 0
         lnFin           = Alines(laLineas, tcMethod)
         llProcedure     = ( Left(laLineas(1),10) == 'PROCEDURE ' ;
            OR Left(laLineas(1),17) == 'HIDDEN PROCEDURE ' ;
            OR Left(laLineas(1),20) == 'PROTECTED PROCEDURE ' )

         If Vartype(tcIndentation) # 'C'
            tcIndentation   = ''
         Endif

         *-- Quito las líneas en blanco luego del final del ENDPROC
         X   = 0
         For I = lnFin To 1 Step -1
            If Not Empty(laLineas(m.I)) && Última línea de código
               If llProcedure And Left( Chrtran(laLineas(m.I), C_TAB, ' ') + ' ', 8 ) <> C_ENDPROC + ' ' Then
                  *ERROR 'Procedimiento sin cerrar. La última línea de código debe ser ENDPROC. [' + laLineas(1) + ']'
                  Error (Textmerge(loLang.C_PROCEDURE_NOT_CLOSED_ON_LINE_LOC))
               Endif
               Exit
            Endif
            X   = m.X + 1
         Endfor

         If m.X > 0
            lnFin   = lnFin - m.X
            Dimension laLineas(lnFin)
         Endif

         *-- Si encuentra la cabecera de un PROCEDURE, la saltea
         If llProcedure
            lnOffset    = 1
         Endif

         For I = lnInicio + lnOffset To lnFin - lnOffset
            *-- TEXT/ENDTEXT aquí da error 2044 de recursividad. No usar.
            lcMethod    = lcMethod + CR_LF + tcIndentation + laLineas(m.I)
         Endfor

         If llProcedure And tlKeepProcHeader
            lcMethod    = CR_LF + C_TAB + laLineas(lnInicio) + lcMethod + CR_LF + C_TAB + laLineas(lnFin)
         Endif

         lcMethod    = Substr(lcMethod,3)    && Quito el primer ENTER (CR+LF)

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcMethod, tcIndentation, tlKeepProcHeader ;
            , I, X, llProcedure, lnInicio, lnFin, laLineas, lnOffset
      Endtry

      Return lcMethod
   Endproc



   Procedure memoInOneLine
      Lparameters tcMethod

      Try
         Local lcLine, I
         lcLine  = ''

         If Not Empty(tcMethod)
            For I = 1 To Alines(laLines, m.tcMethod, 0)
               lcLine  = lcLine + ', ' + laLines(m.I)
            Endfor

            lcLine  = Substr(lcLine, 3)
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcMethod, I
      Endtry

      Return lcLine
   Endproc



   Procedure set_MultilineMemoWithAddObjectProperties
      Lparameters taPropsAndValues, tnPropCount, tcLeftIndentation, tlNormalizeLine

      External Array taPropsAndValues

      Try
         Local lcLine, I, lcComentarios, laLines(1), lcFinDeLinea
         lcLine          = ''
         lcFinDeLinea    = ', ;' + CR_LF

         If tnPropCount > 0
            If Vartype(tcLeftIndentation) # 'C'
               tcLeftIndentation   = ''
            Endif

            For I = 1 To tnPropCount
               lcLine          = lcLine + tcLeftIndentation + taPropsAndValues(m.I,1) + ' = ' + taPropsAndValues(m.I,2) + lcFinDeLinea
            Endfor

            *-- Quito el ", ;<CRLF>" final
            lcLine  = tcLeftIndentation + Substr(lcLine, 1 + Len(tcLeftIndentation), Len(lcLine) - Len(tcLeftIndentation) - Len(lcFinDeLinea))
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release taPropsAndValues, tnPropCount, tcLeftIndentation, tlNormalizeLine ;
            , I, lcComentarios, laLines, lcFinDeLinea
      Endtry

      Return lcLine
   Endproc


   Procedure set_UserValue
      *---------------------------------------------------------------------------------------------------
      * Intenta obtener información más precisa sobre el error a reportar dentro de methods
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toEx                      (v! IN    ) Objeto Exception
      *---------------------------------------------------------------------------------------------------
      Lparameters toEx As Exception

      Local lcMethods, I, lcLine, laCodeLines(1), lcMethod, lcLocation, lnErrorLine
      Store '' To lcMethods, lcLine, laCodeLines, lcMethod, lcLocation
      Store 0 To lnErrorLine, I

      With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
         toEx.UserValue = toEx.UserValue + CR_LF

         If Not Empty(Alias()) And Inlist(.c_Type, 'SCX', 'VCX') Then
            If Type("METHODS")#"U" Then
               lcMethods       = METHODS
            Endif
            toEx.UserValue  = toEx.UserValue + 'Error location ' + '..............................' + CR_LF

            If Type("PARENT")#"U" And Not Empty(Parent) Then
               lcLocation  = lcLocation + Parent + '.'
            Endif

            If Type("OBJNAME")#"U" Then
               lcLocation  = lcLocation + OBJNAME
            Endif

            *-- Busco el Procedure si hay un n_Methods_LineNo
            Alines(laCodeLines, lcMethods)

            For I = .n_Methods_LineNo To 1 Step -1
               lcLine  = Ltrim( laCodeLines(m.I), 0, ' ', Chr(9) )

               Do Case
               Case Left(lcLine, 10) == 'PROCEDURE '
                  lcMethod    = Alltrim( Substr( lcLine, 11) )
                  lnErrorLine = .n_Methods_LineNo - m.I
                  Exit

               Case Left(lcLine, 9) == 'FUNCTION '
                  lcMethod    = Alltrim( Substr( lcLine, 10) )
                  lnErrorLine = .n_Methods_LineNo - m.I
                  Exit

               Endcase

            Endfor

            If Empty(lcMethod) Then
               lcLocation  = 'Class: ' + lcLocation
            Else
               lcLocation  = 'Method: ' + lcLocation + '.' + lcMethod
            Endif

            If lnErrorLine > 0 Then
               lcLocation  = lcLocation + ', Line ' + Transform(lnErrorLine)
            Endif

            toEx.UserValue  = toEx.UserValue + lcLocation + CR_LF

            If .n_Methods_LineNo = 0 Then
               toEx.UserValue  = toEx.UserValue + '> (no evaluated code yet)' + CR_LF
            Else
               toEx.UserValue  = toEx.UserValue + '> ' + laCodeLines(.n_Methods_LineNo) + CR_LF
            Endif
         Endif

         toEx.UserValue = toEx.UserValue + 'Recno: ' + Transform(Recno()) + CR_LF
         toEx.UserValue = toEx.UserValue + '.............................................' + CR_LF
      Endwith
   Endproc


   Procedure sortMethod
      Lparameters tcMethod, taMethods, taCode, tcSorted, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
         , taProtected, tnProtected_Count, toFoxBin2Prg

      External Array taMethods, taCode, taPropsAndComments, taProtected

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, I2, laMethods(1,3), lnDeleted, lcMethodName, lnMethodPos, lcMethodType, loEx As Exception

         If tnMethodCount > 0 Then

            *-- taMethods[1,3]
            *--     1.Nombre Método
            *--     2.Posición Original
            *--     3.Tipo (HIDDEN/PROTECTED/NORMAL)

            *-- Alphabetical ordering of methods
            If This.l_MethodSort_Enabled
               Asort(taMethods,1,-1,0,1)
            Endif

            Dimension laMethods(tnMethodCount,3)
            lnDeleted   = 0

            For I = tnMethodCount To 1 Step -1
               If taMethods(m.I,2) > 0 Then
                  If '.' $ taMethods(m.I,1)
                     *-- Los métodos con '.' los mando a otro array
                     lnDeleted   = lnDeleted + 1
                     laMethods(lnDeleted,1)  = taMethods(m.I,1)
                     laMethods(lnDeleted,2)  = taMethods(m.I,2)
                     laMethods(lnDeleted,3)  = taMethods(m.I,3)
                     Adel( taMethods, m.I )
                  Endif
               Endif
            Endfor

            For I = lnDeleted To 1 Step -1
               *-- Los métodos con '.' los paso al final
               I2  = tnMethodCount - lnDeleted + (lnDeleted - m.I) + 1
               taMethods(I2,1) = laMethods(m.I,1)
               taMethods(I2,2) = laMethods(m.I,2)
               taMethods(I2,3) = laMethods(m.I,3)
            Endfor

         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcMethod, taMethods, taCode, tcSorted, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
            , taProtected, tnProtected_Count, toFoxBin2Prg ;
            , I, I2, laMethods, lnDeleted, lcMethodName, lnMethodPos, lcMethodType, loEx
      Endtry

      Return
   Endproc && SordMethod



   Procedure method2Array
      Lparameters tcMethod, taMethods, taCode, tcSorted, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
         , taProtected, tnProtected_Count, toFoxBin2Prg, toRegObj
      *-- 29/10/2013  Fernando D. Bozzo
      *-- Se tiene en cuenta la posibilidad de que haya un PROC/ENDPROC dentro de un TEXT/ENDTEXT
      *-- cuando es usado en un generador de código o similar.
      External Array taMethods, taCode, taPropsAndComments, taProtected

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      *-- ESTRUCTURA DE LOS ARRAYS CREADOS:
      *-- taMethods[1,3]
      *--     1.Nombre Método
      *--     2.Posición Original
      *--     3.Tipo (HIDDEN/PROTECTED/NORMAL)
      *-- taCode[1]
      *--     1.Bloque de código del método en su posición original
      Try
         Local lnLineCount, laLine(1), I, lnTextNodes, tcSorted, lnProtectedLine, lcMethod, lnLine_Len, lcLine, llProcOpen ;
            , laLineasExclusion(1), lnBloquesExclusion, lcLastLine ;
            , loEx As Exception

         If Not Empty(m.tcMethod) And Left(m.tcMethod,9) == "ENDPROC"+Chr(13)+Chr(10)
            tcMethod    = Substr(m.tcMethod,10)
         Endif

         If Not Empty(m.tcMethod)
            With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
               Dimension laLine(1)
               Store '' To laLine, lcLine, lcLastLine
               Store 0 To lnTextNodes

               lnLineCount = Alines(laLine, m.tcMethod)    && NO aplicar nungún formato ni limpieza, que es el CÓDIGO FUENTE

               *-- Delete beginning empty lines before first "PROCEDURE", that is the first not empty line.
               For I = 1 To lnLineCount
                  If Empty(laLine(m.I)) Or Left( Ltrim(laLine(m.I)),1 ) = '*'
                     *-- Skip empty and commented lines
                  Else
                     If m.I > 1
                        For X = m.I-1 To 1 Step -1
                           Adel(laLine, m.X)
                        Endfor
                        lnLineCount = lnLineCount - m.I + 1
                        Dimension laLine(lnLineCount)
                     Endif
                     Exit
                  Endif
               Endfor

               *-- Delete ending empty lines after last "ENDPROC", that is the last not empty line.
               For I = lnLineCount To 1 Step -1
                  If Empty(laLine(m.I)) Or Left( Ltrim(laLine(m.I)),1 ) = '*'
                     Adel(laLine, m.I)
                  Else
                     If m.I < lnLineCount
                        lnLineCount = m.I
                        Dimension laLine(lnLineCount)
                     Endif
                     Exit
                  Endif
               Endfor

               *-- Identifico los TEXT/ENDTEXT, #IF .F./#ENDIF
               .identifyExclusionBlocks( @laLine, lnLineCount, .F., @laLineasExclusion, @lnBloquesExclusion )

               *-- Analyze and count line methods, get method names and consolidate block code
               For I = 1 To lnLineCount
                  If toFoxBin2Prg.getCfgValue('l_RemoveNullCharsFromCode')
                     laLine(m.I) = Chrtran( laLine(m.I), C_NULL_CHAR, '' )
                  Endif

                  lnLine_Len  = Len( laLine(m.I) )
                  lcLastLine  = lcLine
                  toFoxBin2Prg.set_Line( @lcLine, @laLine, m.I )
                  .get_SeparatedLineAndComment( @lcLine )

                  Do Case
                  Case laLineasExclusion(m.I)
                     If tnMethodCount > 0 And llProcOpen
                        taCode(tnMethodCount)   = taCode(tnMethodCount) + laLine(m.I) + CR_LF
                     Else
                        *-- Invalid method code, as outer code added for tools like ReFox or others, is cleaned up
                     Endif

                  Case Right(lcLastLine,1) == ';'
                     *-- Saltear el análisis de esta línea, que es continuación de la anterior (lcLastLine).
                     taCode(tnMethodCount)   = taCode(tnMethodCount) + laLine(m.I) + CR_LF
                     Loop

                  Case lnTextNodes = 0 And Upper( Left(lcLine, 10) ) == 'PROCEDURE '
                     tnMethodCount   = tnMethodCount + 1
                     Dimension taMethods(tnMethodCount, 3), taCode(tnMethodCount)
                     taMethods(tnMethodCount, 1) = Rtrim( Substr(lcLine, 11), 0, Chr(9), Chr(0), ' ' )
                     taMethods(tnMethodCount, 2) = tnMethodCount
                     taMethods(tnMethodCount, 3) = ''
                     taCode(tnMethodCount)       = 'PROCEDURE ' + taMethods(tnMethodCount, 1) + CR_LF && laLine(m.I) + CR_LF
                     llProcOpen                  = .T.

                  Case lnTextNodes = 0 And Upper( Left(lcLine, 9) ) == 'FUNCTION '    && NOT VALID WITH VFP IDE, BUT 3rd. PARTY SOFTWARE CAN USE IT
                     tnMethodCount   = tnMethodCount + 1
                     Dimension taMethods(tnMethodCount, 3), taCode(tnMethodCount)
                     taMethods(tnMethodCount, 1) = Rtrim( Substr(lcLine, 10), 0, Chr(9), Chr(0), ' ' )
                     taMethods(tnMethodCount, 2) = tnMethodCount
                     taMethods(tnMethodCount, 3) = ''
                     taCode(tnMethodCount)       = 'PROCEDURE ' + taMethods(tnMethodCount, 1) + CR_LF && laLine(m.I) + CR_LF
                     llProcOpen                  = .T.

                  Case lnTextNodes = 0 And Upper( Left(lcLine, 17) ) == 'HIDDEN PROCEDURE '
                     tnMethodCount   = tnMethodCount + 1
                     Dimension taMethods(tnMethodCount, 3), taCode(tnMethodCount)
                     taMethods(tnMethodCount, 1) = Rtrim( Substr(lcLine, 18), 0, Chr(9), Chr(0), ' ' )
                     taMethods(tnMethodCount, 2) = tnMethodCount
                     taMethods(tnMethodCount, 3) = 'HIDDEN '
                     taCode(tnMethodCount)       = 'HIDDEN PROCEDURE ' + taMethods(tnMethodCount, 1) + CR_LF && laLine(m.I) + CR_LF
                     llProcOpen                  = .T.

                  Case lnTextNodes = 0 And Upper( Left(lcLine, 16) ) == 'HIDDEN FUNCTION '    && NOT VALID WITH VFP IDE, BUT 3rd. PARTY SOFTWARE CAN USE IT
                     tnMethodCount   = tnMethodCount + 1
                     Dimension taMethods(tnMethodCount, 3), taCode(tnMethodCount)
                     taMethods(tnMethodCount, 1) = Rtrim( Substr(lcLine, 17), 0, Chr(9), Chr(0), ' ' )
                     taMethods(tnMethodCount, 2) = tnMethodCount
                     taMethods(tnMethodCount, 3) = 'HIDDEN '
                     taCode(tnMethodCount)       = 'HIDDEN PROCEDURE ' + taMethods(tnMethodCount, 1) + CR_LF && laLine(m.I) + CR_LF
                     llProcOpen                  = .T.

                  Case lnTextNodes = 0 And Upper( Left(lcLine, 20) ) == 'PROTECTED PROCEDURE '
                     tnMethodCount   = tnMethodCount + 1
                     Dimension taMethods(tnMethodCount, 3), taCode(tnMethodCount)
                     taMethods(tnMethodCount, 1) = Rtrim( Substr(lcLine, 21), 0, Chr(9), Chr(0), ' ' )
                     taMethods(tnMethodCount, 2) = tnMethodCount
                     taMethods(tnMethodCount, 3) = 'PROTECTED '
                     taCode(tnMethodCount)       = 'PROTECTED PROCEDURE ' + taMethods(tnMethodCount, 1) + CR_LF && laLine(m.I) + CR_LF
                     llProcOpen                  = .T.

                  Case lnTextNodes = 0 And Upper( Left(lcLine, 19) ) == 'PROTECTED FUNCTION ' && NOT VALID WITH VFP IDE, BUT 3rd. PARTY SOFTWARE CAN USE IT
                     tnMethodCount   = tnMethodCount + 1
                     Dimension taMethods(tnMethodCount, 3), taCode(tnMethodCount)
                     taMethods(tnMethodCount, 1) = Rtrim( Substr(lcLine, 20), 0, Chr(9), Chr(0), ' ' )
                     taMethods(tnMethodCount, 2) = tnMethodCount
                     taMethods(tnMethodCount, 3) = 'PROTECTED '
                     taCode(tnMethodCount)       = 'PROTECTED PROCEDURE ' + taMethods(tnMethodCount, 1) + CR_LF && laLine(m.I) + CR_LF
                     llProcOpen                  = .T.

                  Case lnTextNodes = 0 And Left(lcLine, 7) == 'ENDPROC'
                     If lnLine_Len >= 7 And Left( Upper( Chrtran( lcLine , '&'+Chr(9)+Chr(0), '   ') ) + ' ' ,8) == 'ENDPROC '
                        *-- Es el final de estructura ENDPROC
                        If Not llProcOpen
                           *-- Esto no es normal, porque hay más de un ENDPROC, por lo que se ignora.
                           Loop
                        Endif
                     Else
                        *-- Es otra cosa (variable, etc)
                        taCode(tnMethodCount)   = taCode(tnMethodCount) + lcLine + CR_LF
                        Loop
                     Endif

                     taCode(tnMethodCount)   = taCode(tnMethodCount) + lcLine &&+ CR_LF
                     llProcOpen              = .F.

                  Case lnTextNodes = 0 And Left(laLine(m.I), 7) == 'ENDFUNC'  && NOT VALID WITH VFP IDE, BUT 3rd. PARTY SOFTWARE CAN USE IT
                     If lnLine_Len >= 7 And Left( Upper( Chrtran( laLine(m.I) , '&'+Chr(9)+Chr(0), '   ') ) + ' ' ,8) == 'ENDFUNC '
                        *-- Es el final de estructura ENDPROC
                        If Not llProcOpen
                           *-- Esto no es normal, porque hay más de un ENDFUNC, por lo que se ignora.
                           Loop
                        Endif
                        lcLine  = Strtran( lcLine, 'ENDFUNC', 'ENDPROC' )
                     Else
                        *-- Es otra cosa (variable, etc)
                        taCode(tnMethodCount)   = taCode(tnMethodCount) + lcLine + CR_LF
                        Loop
                     Endif

                     taCode(tnMethodCount)   = taCode(tnMethodCount) + lcLine &&+ CR_LF
                     llProcOpen              = .F.

                     *CASE tnMethodCount = 0 OR NOT llProcOpen AND LEFT( LTRIM(laLine(m.I)),1 ) = '*'
                  Case tnMethodCount = 0 Or Not llProcOpen
                     *-- Skip empty and commented lines before methods begin
                     *-- Aquí como condición podría poner: NOT llProcOpen AND LEFT(laLine(m.I), 7) # 'ENDPROC', pero abarcaría demasiado.

                  Otherwise && Method Code
                     taCode(tnMethodCount)   = taCode(tnMethodCount) + laLine(m.I) + CR_LF

                  Endcase
               Endfor

               *-- Agrego los métodos definidos, pero sin código (Protected/Reserved3)
               For I = 1 To tnPropsAndComments_Count
                  lcMethod    = Chrtran( taPropsAndComments(m.I,1), '*', '' )
                  If Left( taPropsAndComments(m.I,1), 1 ) == '*' And Ascan( taMethods, lcMethod, 1, 0, 1, 1+2+4+8 ) = 0
                     tnMethodCount   = tnMethodCount + 1
                     Dimension taMethods(tnMethodCount, 3) &&, taCode(tnMethodCount)
                     taMethods(tnMethodCount, 1) = lcMethod
                     taMethods(tnMethodCount, 2) = 0

                     lnProtectedLine = Ascan( taProtected, lcMethod, 1, 0, 1, 1+2+4+8 )

                     If lnProtectedLine = 0 Then
                        If tnProtected_Count = 0
                           lnProtectedLine = 0
                        Else
                           lnProtectedLine = Ascan( taProtected, lcMethod + '^', 1, 0, 1, 1+2+4+8 )
                        Endif

                        If lnProtectedLine = 0 Then
                           taMethods(tnMethodCount, 3) = ''
                        Else
                           taMethods(tnMethodCount, 3) = 'HIDDEN '
                        Endif
                     Else
                        taMethods(tnMethodCount, 3) = 'PROTECTED '
                     Endif
                  Endif
               Endfor
            Endwith && THIS As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcMethod, taMethods, taCode, tcSorted, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
            , taProtected, tnProtected_Count, toFoxBin2Prg ;
            , lnLineCount, laLine, I, lnTextNodes, tcSorted, lnProtectedLine, lcMethod, lnLine_Len, lcLine, llProcOpen ;
            , laLineasExclusion, lnBloquesExclusion ;
            , loEx
      Endtry

      Return
   Endproc && method2Array



   Procedure write_ADD_OBJECTS_WithProperties
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toRegObj                  (v! IN    ) Objeto de registro
      * tcCodigo                  (@?    OUT) Codigo generado
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toRegObj, tcCodigo, toFoxBin2Prg

      #If .F.
         Local toRegObj As CL_OBJETO Of 'cl_objeto.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcMemo, laPropsAndValues(1,2), lnPropsAndValues_Count

         With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
            *-- Defino los objetos a cargar
            .get_PropsAndValuesFrom_PROPERTIES( toRegObj.PROPERTIES, 1, @laPropsAndValues, @lnPropsAndValues_Count, @lcMemo, @toFoxBin2Prg )
            lcMemo  = .set_MultilineMemoWithAddObjectProperties( @laPropsAndValues, @lnPropsAndValues_Count, C_TAB + C_TAB, .T. )

            If '.' $ toRegObj.Parent
               *-- Este caso: clase.objeto.objeto ==> se quita clase
               TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                  <<Chr(9)>>ADD OBJECT '<<SUBSTR(toRegObj.Parent, AT('.', toRegObj.Parent)+1)>>.<<toRegObj.objName>>' AS <<LOWER(ALLTRIM(toRegObj.Class))>> <<>>
               ENDTEXT
            Else
               *-- Este caso: objeto
               TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                  <<Chr(9)>>ADD OBJECT '<<toRegObj.objName>>' AS <<LOWER(ALLTRIM(toRegObj.Class))>> <<>>
               ENDTEXT
            Endif

            If Not Empty(lcMemo)
               TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                  <<C_WITH>> ;
                  <<lcMemo>>
               ENDTEXT
            Endif

            TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
               <<C_TAB + C_TAB>><<C_END_OBJECT_I>> <<>>
            ENDTEXT

            If Not Empty(toRegObj.CLASSLOC)
               TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                  ClassLib="<<toRegObj.ClassLoc>>" <<>>
               ENDTEXT
            Endif

            TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
               BaseClass="<<toRegObj.Baseclass>>" <<>>
            ENDTEXT

            *-- Agrego metainformación para objetos OLE
            If toRegObj.BaseClass == 'olecontrol'
               TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
                  OLEObject="<<LOWER( STREXTRACT(toRegObj.ole2, 'OLEObject = ', CHR(13)+CHR(10), 1, 1+2) )>>"
                  Value="<<STRCONV(toRegObj.ole,13)>>" <<>>
               ENDTEXT
            Endif

            TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
               <<C_END_OBJECT_F>>
               <<>>
            ENDTEXT
         Endwith

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toRegObj, lcMemo, laPropsAndValues, lnPropsAndValues_Count
      Endtry

      Return
   Endproc



   Procedure write_ALL_OBJECT_METHODS
      Lparameters tcMethods, taMethods, taCode, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
         , taProtected, tnProtected_Count, toFoxBin2Prg, tcCodigo

      *-- Finalmente, todos los métodos los ordeno y escribo juntos
      Local laMethods(1), laCode(1), lnMethodCount, I, lcMethods

      If tnMethodCount > 0 Then
         Store '' To lcMethods
         Dimension laMethods(1,3)

         With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
            .sortMethod( @tcMethods, @taMethods, @taCode, '', @tnMethodCount ;
               , @taPropsAndComments, tnPropsAndComments_Count, @taProtected, tnProtected_Count, @toFoxBin2Prg )

            lcMethods   = C_TAB

            For I = 1 To tnMethodCount
               *-- Genero los métodos indentados
               *-- Sustituyo el TEXT/ENDTEXT aquí porque a veces quita espacios de la derecha, y eso es peligroso
               If taMethods(m.I,2) = 0
                  Loop
               Endif

               lcMethods   = lcMethods + CR_LF + .indentMemo( taCode(taMethods(m.I,2)), Chr(9) + Chr(9), .T. ) + CR_LF
            Endfor
         Endwith && THIS

         tcCodigo    = tcCodigo + lcMethods
      Endif

      Release tcMethods, taMethods, taCode, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count, taProtected, tnProtected_Count, toFoxBin2Prg ;
         , laMethods, laCode, lnMethodCount, I, lcMethods
      Return
   Endproc



   Procedure write_CLASS_PROPERTIES
      Lparameters toRegClass, taPropsAndValues, taPropsAndComments, taProtected ;
         , tnPropsAndValues_Count, tnPropsAndComments_Count, tnProtected_Count, tcCodigo, toFoxBin2Prg

      External Array taPropsAndValues, taPropsAndComments

      Try
         Local lcHiddenProp, lcProtectedProp, lcPropsMethodsDefd, I ;
            , lcPropName, lnProtectedItem, lcComentarios ;
            , loEx As Exception

         With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
            *-- DEFINIR PROPIEDADES ( HIDDEN, PROTECTED, *DEFINED_PAM )
            Dimension taProtected(1)

            Store '' To lcHiddenProp, lcProtectedProp, lcPropsMethodsDefd
            Store 0  To tnPropsAndValues_Count, tnPropsAndComments_Count, tnProtected_Count

            .get_PropsAndValuesFrom_PROPERTIES( toRegClass.PROPERTIES, 1, @taPropsAndValues, @tnPropsAndValues_Count, '', @toFoxBin2Prg )
            .get_PropsAndCommentsFrom_RESERVED3( toRegClass.RESERVED3, .T., @taPropsAndComments, @tnPropsAndComments_Count, '' )
            .get_PropsFrom_PROTECTED( toRegClass.Protected, .T., @taProtected, @tnProtected_Count, '' )

            If tnPropsAndValues_Count > 0 Then
               .classify_PAM_Hidden_Protected( @tnPropsAndValues_Count, @taPropsAndValues, @tnProtected_Count, @taProtected ;
                  , @tnPropsAndComments_Count, @taPropsAndComments, @lcHiddenProp, @lcProtectedProp )
               .write_DEFINED_PAM( @taPropsAndComments, tnPropsAndComments_Count, @tcCodigo )
               .write_HIDDEN_Properties( @lcHiddenProp, @tcCodigo )
               .write_PROTECTED_Properties( @lcProtectedProp, @tcCodigo )

               *-- Escribo las propiedades de la clase y sus comentarios (los comentarios aquí son redundantes)

               *!* Changed by: LScheffler 16.3.2023
               *!* <pdm>
               *!* <change date="{^2023-03-16,06:19:00}">Changed by: LScheffler<br />
               *!* Problems with property values with leading and trailing spaces
               *!* and with double ampersand in value
               *!* we just do not add the property comment, the comment will be recreated by the property definiton
               *!* section <em>DefinedPropArrayMethod<em/><br/>
               *!* see issues #90, #91
               *!* </change>
               *!* </pdm>
               If tnPropsAndValues_Count>0
                  *LScheffler 16.3.2023 set delimiters around properties value, so we know it's without comment and we can keep "&&" in value
                  tcCodigo = tcCodigo + Chr(13) + Chr(10) + Chr(9) + C_DEFINED_PROPVAL_I

                  For I = 1 To tnPropsAndValues_Count
                     tcCodigo = tcCodigo + Chr(13) + Chr(10) + Chr(9) + Chr(9) + taPropsAndValues(m.I,1) + ' = ' + taPropsAndValues(m.I,2)

                     *LScheffler 16.3.2023 without comment
                     *                           If tnPropsAndComments_Count > 0 Then
                     *                               lnComment   = Ascan( taPropsAndComments, taPropsAndValues(m.I,1), 1, 0, 1, 1+2+4+8)
                     *
                     *                               If lnComment > 0 And Not Empty(taPropsAndComments(lnComment,2))
                     *                                   tcCodigo = tcCodigo + Chr(9) + Chr(9) + '&' + '& ' + taPropsAndComments(lnComment,2)
                     *                               Endif
                     *                           Endif

                  Endfor

                  *LScheffler 16.3.2023 set delimiters around properties value, so we know it's without comment and we can keep "&&" in value
                  tcCodigo = tcCodigo + Chr(13) + Chr(10) + Chr(9) + C_DEFINED_PROPVAL_F
               Endif &&tnPropsAndValues_Count>0
               *!* /Changed by: LScheffler 16.3.2023

               TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<>>
               ENDTEXT
            Endif
         Endwith && THIS

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release toRegClass, taPropsAndValues, taPropsAndComments, taProtected ;
            , tnPropsAndValues_Count, tnPropsAndComments_Count, tnProtected_Count ;
            , lcHiddenProp, lcProtectedProp, lcPropsMethodsDefd, I ;
            , lcPropName, lnProtectedItem, lcComentarios, loEx
      Endtry

      Return
   Endproc



   Procedure write_DEFINED_PAM
      *-- Escribo propiedades DEFINED (Reserved3) en este formato:
      Lparameters taPropsAndComments, tnPropsAndComments_Count, tcCodigo

      *<DefinedPropArrayMethod>
      *m: *metodovacio_con_comentarios        && Este método no tiene código, pero tiene comentarios. A ver que pasa!
      *m: *mimetodo       && Mi metodo
      *p: prop1       && Mi prop 1
      *p: prop_especial_cr        &&
      *a: ^array_1_d[1,0]     && Array 1 dimensión (1)
      *a: ^array_2_d[1,2]     && Array una dimension (1,2)
      *p: _memberdata     && XML Metadata for customizable properties
      *</DefinedPropArrayMethod>

      If tnPropsAndComments_Count > 0
         Local I, lcPropsMethodsDefd, lcType
         lcPropsMethodsDefd  = ''

         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>><<C_DEFINED_PAM_I>>
         ENDTEXT

         For I = 1 To tnPropsAndComments_Count
            If Empty(taPropsAndComments(m.I,1))
               Loop
            Endif

            lcType  = Left( taPropsAndComments(m.I,1), 1 )
            lcType  = Icase( lcType == '*', 'm' ;
               , lcType == '^', 'a' ;
               , 'p' )

            If lcType == 'p' Then
               tcCodigo = tcCodigo + Chr(13) + Chr(10) + Chr(9) + Chr(9) + '*' + lcType + ': ' + taPropsAndComments(m.I,1)
            Else
               tcCodigo = tcCodigo + Chr(13) + Chr(10) + Chr(9) + Chr(9) + '*' + lcType + ': ' + Substr( taPropsAndComments(m.I,1), 2)
            Endif

            If Not Empty(taPropsAndComments(m.I,2))
               tcCodigo = tcCodigo + Chr(9) + Chr(9) + '&' + '& ' + taPropsAndComments(m.I,2)
            Endif
         Endfor

         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>><<C_DEFINED_PAM_F>>
         ENDTEXT

         tcCodigo    = tcCodigo + CR_LF

         Release I, lcPropsMethodsDefd, lcType
      Endif

      Release taPropsAndComments, tnPropsAndComments_Count
      Return
   Endproc



   Procedure write_DEFINE_CLASS
      Lparameters ta_NombresObjsOle, toRegClass, tcCodigo

      Local lcOF_Classlib, llOleObject
      lcOF_Classlib   = ''
      llOleObject     = ( Ascan( ta_NombresObjsOle, toRegClass.OBJNAME, 1, 0, 1, 1+2+4+8) > 0 )

      If Not Empty(toRegClass.CLASSLOC)
         lcOF_Classlib   = ' OF "' + Lower(Alltrim(toRegClass.CLASSLOC)) + '"'
      Endif

      *-- DEFINICIÓN DE LA CLASE ( DEFINE CLASS 'className' AS 'classType' [OF 'classLib'] [OLEPUBLIC] )
      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
         DEFINE CLASS <<ALLTRIM(toRegClass.ObjName)>> AS <<LOWER(ALLTRIM(toRegClass.Class)) + lcOF_Classlib + IIF(llOleObject, ' OLEPUBLIC', '')>>
      ENDTEXT

      Return
   Endproc



   Procedure write_DEFINE_CLASS_COMMENTS
      Lparameters toRegClass, tcCodigo
      *-- Comentario de la clase
      If Not Empty(toRegClass.RESERVED7) Then
         *-- Si es multilínea, debe ir en un tag <ClassComments> aparte
         If Occurs( Chr(13), toRegClass.RESERVED7 ) > 0 Then
            TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)>><<C_CLASSCOMMENTS_I>>
                    <<THIS.indentMemo( toRegClass.Reserved7, C_TAB + C_TAB + '*' )>>
                    <<Chr(9)>><<C_CLASSCOMMENTS_F>>
            ENDTEXT
         Else    && Comentario in-line
            TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                    <<Chr(9)+Chr(9)>><<'&'+'&'>> <<toRegClass.Reserved7>>
            ENDTEXT
         Endif
      Endif

      Return
   Endproc



   Procedure write_ENDDEFINE_IfApplicable
      Lparameters tnLastClass, tcCodigo
      If tnLastClass = 1
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<'ENDDEFINE'>>
                <<>>
         ENDTEXT
      Endif

      Return
   Endproc



   Procedure write_EXTERNAL_CLASS_HEADER
      Lparameters toRegClass, toFoxBin2Prg, tcCodigo
      *-- < EXTERNAL_CLASS Name = "class-name" Baseclass="base-class" />
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      If Empty(tcCodigo) Then
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                *-- EXTERNAL_CLASS identify external member Class names / EXTERNAL_CLASS identifica los nombres de las Clases externas
         ENDTEXT
      Endif

      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
            <<C_EXTERNAL_CLASS_I>> Name="<<toRegClass.objname>>" Baseclass="<<toRegClass.Baseclass>>" <<C_EXTERNAL_CLASS_F>>
      ENDTEXT

      Return
   Endproc



   Procedure write_EXTERNAL_MEMBER_HEADER
      Lparameters toFoxBin2Prg, tcMemberName, tcMemberType, tcCodigo
      *-- < EXTERNAL_MEMBER Name = "member-name" Type="member-type" />
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      If Empty(tcCodigo) Then
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                *-- EXTERNAL_MEMBER identify external member names / EXTERNAL_MEMBER identifica los nombres de los miembros externos
         ENDTEXT
      Endif

      If Not Empty(tcMemberName) And Not Empty(tcMemberType) Then
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<C_EXTERNAL_MEMBER_I>> Name="<<tcMemberName>>" Type="<<tcMemberType>>" <<C_EXTERNAL_MEMBER_F>>
         ENDTEXT
      Endif

      Return
   Endproc



   Procedure write_INCLUDE
      Lparameters toReg, tcCodigo
      *-- #INCLUDE
      If Not Empty(toReg.RESERVED8) Then
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>>#INCLUDE "<<toReg.Reserved8>>"
         ENDTEXT
      Endif

      Return
   Endproc



   Procedure write_CLASSMETADATA
      Lparameters toRegClass, tcCodigo

      *-- Agrego Metadatos de la clase (Baseclass, Timestamp, Scale, Uniqueid)
      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
            <<>>
      ENDTEXT

      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
            <<Chr(9)>><<C_CLASSDATA_I>>
            Baseclass="<<toRegClass.Baseclass>>"
            Timestamp="<<ALLTRIM(THIS.getTimeStamp(toRegClass.Timestamp))>>"
            Scale="<<toRegClass.Reserved6>>"
            Uniqueid="<<toRegClass.Uniqueid>>"
      ENDTEXT

      If Not Empty(toRegClass.OLE2)
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
                <<>> Nombre="<<IIF(EMPTY(toRegClass.Parent),'',toRegClass.Parent+'.') + toRegClass.objName>>"
                Parent="<<toRegClass.Parent>>"
                ObjName="<<toRegClass.objname>>"
                OLEObject="<<STREXTRACT(toRegClass.ole2, 'OLEObject = ', CHR(13)+CHR(10), 1, 1+2)>>"
                Value="<<STRCONV(toRegClass.ole,13)>>"
         ENDTEXT
      Endif

      If Not Empty(toRegClass.RESERVED5)
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2+4+8
                ProjectClassIcon="<<toRegClass.Reserved5>>"
         ENDTEXT
      Endif

      If Not Empty(toRegClass.RESERVED4)
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2+4+8
                ClassIcon="<<toRegClass.Reserved4>>"
         ENDTEXT
      Endif

      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2+4+8
            <<C_CLASSDATA_F>>
      ENDTEXT

      tcCodigo    = tcCodigo + CR_LF

      Return
   Endproc



   Procedure write_OBJECTMETADATA
      Lparameters toRegObj, tcCodigo
      Local lcNombre

      *-- Agrego Metadatos de los objetos (Timestamp, UniqueID)
      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
            <<>>
      ENDTEXT

      If '.' $ toRegObj.Parent
         *-- Este caso: clase.objeto.objeto ==> se quita clase
         lcNombre = Substr(toRegObj.Parent, At('.', toRegObj.Parent)+1) + '.' + toRegObj.OBJNAME
      Else
         *-- Este caso: objeto
         lcNombre = toRegObj.OBJNAME
      Endif

      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2+4+8
            <<Chr(9)>><<C_OBJECTDATA_I>>
            ObjPath="<<lcNombre>>"
            UniqueID="<<toRegObj.Uniqueid>>"
            Timestamp="<<ALLTRIM(THIS.getTimeStamp(toRegObj.Timestamp))>>"
      ENDTEXT

      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2+4+8
            <<C_OBJECTDATA_F>>
      ENDTEXT

      Return
   Endproc



   Procedure write_HIDDEN_Properties
      *-- Escribo la definición HIDDEN de propiedades
      Lparameters tcHiddenProp, tcCodigo

      If Not Empty(tcHiddenProp)
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>>HIDDEN <<SUBSTR(tcHiddenProp,2)>>
         ENDTEXT
      Endif

      Return
   Endproc



   Procedure write_PROTECTED_Properties
      *-- Escribo la definición PROTECTED de propiedades
      Lparameters tcProtectedProp, tcCodigo

      If Not Empty(tcProtectedProp)
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>>PROTECTED <<SUBSTR(tcProtectedProp,2)>>
         ENDTEXT
      Endif

      Return
   Endproc


   Procedure write_OLEObjectDefinitions
      *-- Crea la definición del tag *< OLE: /> con la información de todos los objetos OLE
      Lparameters toFoxBin2Prg

      Local laOLE(1)
      *!*         LOCAL lnOLECount, lcOLEChecksum, llOleExistente, loReg

      *!*         #IF .F.
      *!*             LOCAL toFoxBin2Prg AS c_foxbin2prg Of 'c_foxbin2prg.prg'
      *!*         #ENDIF

      *!*         TRY
      *!*             SELECT TABLABIN
      *!*             SET ORDER TO PARENT_OBJ
      *!*             lnOLECount  = 0

      *!*             SCAN ALL FOR TABLABIN.PLATFORM = "WINDOWS" AND BASECLASS = 'olecontrol'
      *!*                 loReg   = .Null.
      *!*                 SCATTER MEMO NAME loReg

      *!*                 IF toFoxBin2Prg.getCfgValue('l_NoTimestamps')
      *!*                     loReg.TIMESTAMP = 0
      *!*                 ENDIF
      *!*                 IF toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
      *!*                     loReg.UNIQUEID  = ''
      *!*                 ENDIF

      *!*                 lcOLEChecksum   = SYS(2007, loReg.OLE, 0, 1)
      *!*                 llOleExistente  = .F.

      *!*                 IF lnOLECount > 0 AND ASCAN(laOLE, lcOLEChecksum, 1, 0, 0, 0) > 0
      *!*                     llOleExistente  = .T.
      *!*                 ENDIF

      *!*                 lnOLECount  = lnOLECount + 1
      *!*                 DIMENSION laOLE( lnOLECount )
      *!*                 laOLE( lnOLECount ) = lcOLEChecksum

      *!*                 TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
      *!*                     <<>>
      *!*                 ENDTEXT

      *!*             ENDSCAN

      *-- LO QUE SIGUE LO COMENTÉ PORQUE POR CADA OBJETO OLE SE AGREGABA UNA LÍNEA VACÍA QUE QUEDA MUY MAL Y ES INNECESARIA.
      *-- COMO CONSECUENCIA, LOS FORMS O CLASES CON OBJETOS OLE DARÁN DIFERENCIA POR ÚNICA VEZ EN LA CABECERA. - fdbozzo. 29/11/2014 (v1.19.37)
      *
      *SELECT COUNT(*) FROM TABLABIN WHERE TABLABIN.PLATFORM = "WINDOWS" AND BASECLASS == 'olecontrol' INTO ARRAY laOLE

      *IF laOLE(1) > 0 THEN
      *   *-- Lo del <<>> para crear una línea vacía es solamente por compatibilidad con lo antiguo,
      *   *-- donde se creaba esta línea cuando el form o clase tenía al menos un objeto OLE.
      *   TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
      *       <<>>
      *       *
      *   ENDTEXT
      *ELSE

      TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
         *
      ENDTEXT
      *ENDIF

      *!*         CATCH TO loEx
      *!*             IF THIS.n_Debug > 0 AND _VFP.STARTMODE = 0
      *!*                 SET STEP ON
      *!*             ENDIF

      *!*             THROW

      *!*         FINALLY
      *!*             loReg   = .Null.
      *!*             RELEASE loReg

      *!*         ENDTRY

      *!*         RETURN
   Endproc



   Procedure write_OutputFile
      Lparameters tcCodigo, tcOutputFile, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcExpanded, llFileExists, lnBytes, lcOutputFile, laDirFile(1,5) ;
            , loLang As CL_LANG Of 'cl_lang.prg'

         * Default in lowercase
         tcOutputFile = Lower(tcOutputFile)

         *** + árbol espejo: si cInputRoot está indicado, se replica la estructura de carpetas
         If Not Empty(This.cOutputFolder)
            tcOutputFile = This.get_MirroredOutputFile(tcOutputFile)
         Endif Not Empty(This.cOutputFolder)

         lcExpanded  = Iif( '.' $ Juststem(tcOutputFile), 'X1', 'X0' )

         *-- addProcessedFile( tcFile, tcInOutType, tcProcessed, tcHasErrors, tcSupported, tcExpanded )
         If toFoxBin2Prg.addProcessedFile( tcOutputFile, 'O', 'P1', 'E0', 'S1', lcExpanded ) Then

            Do Case
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_O1'
               Error 'OutputFile Error Simulation'
            Endcase

            toFoxBin2Prg.updateProcessedFile()
         Endif

         If Not toFoxBin2Prg.l_ProcessFiles Then
            Exit    && Si se indicó no procesar, salgo del proceso. (Modo de simulación)
         Endif

         loLang          = _Screen.o_FoxBin2Prg_Lang
         lcOutputFile    = tcOutputFile
         llFileExists    = ( Adir(laDirFile, tcOutputFile) = 1 )

         If llFileExists And toFoxBin2Prg.readTextFile(tcOutputFile) == tcCodigo Then
            *.writeLog( 'El archivo de salida [' + .c_OutputFile + '] no se sobreescribe por ser igual al generado.' )
            This.writeLog( C_TAB + C_TAB + '* ' + Textmerge(loLang.C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC) )

         Else
            If llFileExists Then
               toFoxBin2Prg.doBackup( .F., .T., '', '', '', tcOutputFile )
               toFoxBin2Prg.changeFileAttribute( tcOutputFile, '-R' )
            ENDIF

            lnBytes = toFoxBin2Prg.writeTextFile( tcCodigo, tcOutputFile )

            This.writeLog( C_TAB + C_TAB + '- ' + loLang.C_FILENAME_LOC + ': ' + tcOutputFile + ' (' + Alltrim(Transform(lnBytes/1024,'######.##')) + '/' + Alltrim(Transform(Len(tcCodigo)/1024,'######.##')) + ' KiB)' )

            If lnBytes = 0
               *ERROR 'No se puede generar el archivo [' + .c_OutputFile + '] porque es ReadOnly'
               Error (Textmerge(loLang.C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC))
            Endif
         Endif

         toFoxBin2Prg.normalizeFileCapitalization( .F., tcOutputFile )
      Endtry
   Endproc




   Procedure FixOle2Fields

      * (This method is taken from Open Source project TwoFox, from Christof Wallenhaupt - http://www.foxpert.com/downloads.htm)
      * OLE2 contains the physical name of the OCX or DLL when a record refers to an ActiveX
      * control. On different developer machines these controls can be located in different
      * folders without affecting the code.
      *
      * When a control is stored outside the project directory, we assume that every developer
      * is responsible for installing and registering the control. Therefore we only leave
      * the file name which should be fixed. It's also sufficient for VFP to locate an OCX
      * file when the control is not registered and the OCX file is stored in the current
      * directory or the application path.
      *--------------------------------------------------------------------------------------
      * Project directory for comparision purposes
      *--------------------------------------------------------------------------------------
      Local lcProjDir
      lcProjDir = Upper(Alltrim(This.cHomeDir))
      If Right(m.lcProjDir,1) == "\"
         lcProjDir = Left(m.lcProjDir, Len(m.lcProjDir)-1)
      Endif

      *--------------------------------------------------------------------------------------
      * Check all OLE2 fields
      *--------------------------------------------------------------------------------------
      Local lcOcx
      Scan For Not Empty(OLE2)
         lcOcx = Strextract (OLE2, "OLEObject = ", Chr(13), 1, 1+2)
         If This.OcxOutsideProjDir (m.lcOcx, m.lcProjDir)
            This.TruncateOle2 (m.lcOcx)
         Endif
      Endscan

   Endproc



   Function OcxOutsideProjDir
      Lparameters tcOcx, tcProjDir
      * (This method is taken from Open Source project TwoFox, from Christof Wallenhaupt - http://www.foxpert.com/downloads.htm)
      * Returns .T. when the OCX control resides outside the project directory
      Local lcOcxDir, llOutside
      lcOcxDir = Upper (Justpath (m.tcOcx))
      If Left(m.lcOcxDir, Len(m.tcProjDir)) == m.tcProjDir
         llOutside = .F.
      Else
         llOutside = .T.
      Endif

      Return m.llOutside
   Endfunc


   Procedure TruncateOle2 (tcOcx)
      * (This method is taken from Open Source project TwoFox, from Christof Wallenhaupt - http://www.foxpert.com/downloads.htm)
      * Cambios de un campo OLE2 exclusivamente en el nombre del archivo
      Replace OLE2 With Strtran ( ;
         OLE2 ;
         ,"OLEObject = " + m.tcOcx ;
         ,"OLEObject = " + Justfname(m.tcOcx) ;
         )
   Endproc


Enddefine
