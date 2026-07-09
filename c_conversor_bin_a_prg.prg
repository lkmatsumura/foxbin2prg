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
               + [<memberdata name="prioritizelifecyclemethods" display="prioritizeLifecycleMethods"/>] ;
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
      * PURPOSE:   Entry point for binary-to-text conversion; delegates to the base convert implementation.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toModulo                  (!@    OUT) Generated module object with data read from the binary
      * toEx                      (!@    OUT) Exception object with error information
      * toFoxBin2Prg              (v! IN    ) Reference to the main FoxBin2Prg instance
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )
   Endproc


   Procedure classify_PAM_Hidden_Protected
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Build comma-separated HIDDEN and PROTECTED property lists from the Protected memo,
      *            skipping members that are methods (present in RESERVED3 as *name).
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tnPropsAndValues_Count    (@! IN    ) Count of property name/value pairs
      * taPropsAndValues          (@! IN    ) Property name/value array
      * tnProtected_Count         (@! IN    ) Count of protected/hidden members
      * taProtected               (@! IN    ) Protected/hidden member names (^ suffix = Hidden)
      * tnPropsAndComments_Count  (@! IN    ) Count of RESERVED3 DEFINED entries
      * taPropsAndComments        (@! IN    ) RESERVED3 DEFINED entries (used to skip methods)
      * tcHiddenProp              (@!    OUT) Comma-prefixed list of Hidden properties
      * tcProtectedProp           (@!    OUT) Comma-prefixed list of Protected properties
      *---------------------------------------------------------------------------------------------------
      Lparameters tnPropsAndValues_Count, taPropsAndValues, tnProtected_Count, taProtected ;
         , tnPropsAndComments_Count, taPropsAndComments, tcHiddenProp, tcProtectedProp

      If tnPropsAndValues_Count > 0 Then
         *-- Walk Protected entries to build HIDDEN and PROTECTED property lists
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Parse nested-object METHODS memo and rename methods with full object path
      *            (obj.method / parent.obj.method) so they can be distinguished from class methods.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toRegObj                  (v! IN    ) Nested object record (SCX/VCX row)
      * toRegClass                (v! IN    ) Parent class record
      * tcMethods                 (v? IN    ) Unused (shared call pattern)
      * taMethods                 (@! IN/OUT) Method metadata array
      * taCode                    (@! IN/OUT) Method code blocks
      * tnMethodCount             (@! IN/OUT) Method count
      * taPropsAndComments        (@? IN    ) RESERVED3 DEFINED entries
      * tnPropsAndComments_Count  (v? IN    ) DEFINED entry count
      * taProtected               (@? IN    ) Protected member list
      * tnProtected_Count         (v? IN    ) Protected member count
      * toFoxBin2Prg              (v! IN    ) Main FoxBin2Prg instance
      *---------------------------------------------------------------------------------------------------
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

            *-- Locate protected methods and adjust their definition.
            *-- Methods must be generated with the full path; otherwise it is impossible to know
            *-- which object they belong to, or whether they are class methods.
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

                  *-- Build method without indentation (indent applied later)
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Finalize class-level method headers (PROCEDURE / HIDDEN / PROTECTED), attach
      *            HELPSTRING or && comments from RESERVED3, and wrap bodies with ENDPROC.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tnMethodCount             (@! IN    ) Method count
      * taMethods                 (@! IN/OUT) Method metadata [name, originalPos, type]
      * taCode                    (@! IN/OUT) Method code blocks
      * taProtected               (@! IN    ) Protected/hidden member list
      * taPropsAndComments        (@! IN    ) RESERVED3 DEFINED entries (comments)
      * toFoxBin2Prg              (v! IN    ) Main FoxBin2Prg instance
      *---------------------------------------------------------------------------------------------------
      Lparameters tnMethodCount, taMethods, taCode, taProtected, taPropsAndComments, toFoxBin2Prg
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
                        *-- Normal method
                        lcProcDef   = 'PROCEDURE'
                     Else
                        *-- Hidden method
                        lcProcDef   = 'HIDDEN PROCEDURE'
                     Endif
                  Else
                     *-- Protected method
                     lcProcDef   = 'PROTECTED PROCEDURE'
                  Endif

                  lnCommentRow   = Ascan( taPropsAndComments, '*' + lcMethodName, 1, 0, 1, 1+2+4+8)

                  *-- Method name / header
                  lcMethod    = lcProcDef + ' ' + taMethods(m.I,1)

                  *-- Method comments (if any)
                  If lnCommentRow > 0 And Not Empty(taPropsAndComments(lnCommentRow,2))
                     * PRG_Compat_Level >= 1
                     If Bitand(toFoxBin2Prg.getCfgValue('n_PRG_Compat_Level'), 1) > 0
                        lcMethod    = lcMethod + C_TAB + C_TAB + 'HELPSTRING "' + taPropsAndComments(lnCommentRow,2) + '"'
                     Else
                        * PRG_Compat_Level = 0 (Default old setting)
                        lcMethod    = lcMethod + C_TAB + C_TAB + '&' + '& ' + taPropsAndComments(lnCommentRow,2)
                     Endif
                  Endif

                  *-- Method body
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Collect OLEPublic object names from the binary table into an array.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * ta_NombresObjsOle         (@!    OUT) Array of OLE public object names
      *---------------------------------------------------------------------------------------------------
      Lparameters ta_NombresObjsOle
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Parse the RESERVED3 memo into a [name, comment] array; optionally sort alphabetically.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcMemo                    (v! IN    ) RESERVED3 memo content
      * tlSort                    (v? IN    ) .T. = sort names alphabetically when PropSort is enabled
      * taPropsAndComments        (!@    OUT) Array of property/method names and comments
      * tnPropsAndComments_Count  (!@    OUT) Number of entries
      * tcSortedMemo              (@?    OUT) Sorted memo content (may remain empty)
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
            lnPos = At(' ', laLines(m.I)) && A space separates the name from its comment (if any)

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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Parse the PROPERTIES memo into a [name, value] array; handle multi-line special
      *            values, autofix split property names, optional ZOrderSet removal, and sorting.
      * KNOWLEDGE BASE:
      * 29/11/2013    FDBOZZO     In a pageframe, if native props are not listed before contained
      *                           object props, an error occurs. Sort native props (no dot) first,
      *                           then object props (with dot).
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcMemo                    (v! IN    ) PROPERTIES memo content
      * tnSort                    (v? IN    ) 1 = sort objects/props alphabetically; 0 = do not
      * taPropsAndValues          (!@    OUT) Array of property names and values
      * tnPropsAndValues_Count    (!@    OUT) Number of properties
      * tcSortedMemo              (?@    OUT) Sorted memo content rebuilt from the array
      * toFoxBin2Prg              (v! IN    ) Main FoxBin2Prg instance
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
               lnItemCount = Alines(laItems, m.tcMemo, 0, CR_LF)   && Specifically CR+LF so lone CR or LF are not treated as separators
               X   = 0

               If lnItemCount <= 1 And Empty(laItems)
                  lnItemCount = 0
                  Exit
               Endif


               *-- 1) EXTRACT AND SPLIT PROPERTIES AND VALUES
               *-- Build array; special (long) values may span multiple lines
               For I = 1 To m.lnItemCount
                  If Empty( laItems(m.I) )
                     Loop
                  Endif

                  If C_MPROPHEADER $ laItems(m.I)
                     *-- Only reached when evaluating a PROPERTIES entry with a special (long) value
                     lnLenAcum   = 0
                     lnPosEQ     = At( '=', laItems(m.I) )
                     lcPropName  = lcLastIncompletePropName + Left( laItems(m.I), lnPosEQ - 2 )
                     lnLenVal    = Int( Val( Substr( laItems(m.I), lnPosEQ + 2 + 517, 8) ) )
                     lcValue     = Substr( laItems(m.I), lnPosEQ + 2 + 517 + 8 )

                     If Len( lcValue ) < lnLenVal
                        *-- Multi-line value: restore CR_LF removed by ALINES()
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

                     *-- Special value: wrap with FB2P value markers
                     X   = m.X + 1
                     Dimension taPropsAndValues(m.X,2)
                     taPropsAndValues(m.X,1) = lcPropName
                     taPropsAndValues(m.X,2) = .normalizePropertyValue( lcPropName, lcValue, '' )

                  Else
                     *-- Normal property
                     lnPosEQ                 = At( '=', laItems(m.I) )

                     If lnPosEQ = 0 Then
                        *-- AUTOFIX FOR SPLIT PROPERTY NAME:
                        *-- Can happen when the Properties memo was edited manually with a stray Enter, e.g.:
                        * comm
                        * AND2.Caption = "Command2"
                        *
                        *-- Those two lines are really one:
                        * command2.Caption = "Command2"
                        *
                        *-- Fix: keep this name fragment and prepend it to the next property.
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


               *-- Append properties first
               For I = 1 To m.tnPropsAndValues_Count
                  tcSortedMemo    = m.tcSortedMemo + m.taPropsAndValues(m.I,1) + ' = ' + m.taPropsAndValues(m.I,2) + CR_LF
               Endfor

               *-- Append methods at the end
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
      * PURPOSE:   Parse the PROTECTED memo into an array; optionally sort and remove duplicates.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcMemo                    (v! IN    ) PROTECTED memo content
      * tlSort                    (v? IN    ) .T. = sort names alphabetically when PropSort is enabled
      * taProtected               (!@    OUT) Array of protected/hidden member names
      * tnProtected_Count         (!@    OUT) Number of members
      * tcSortedMemo              (@?    OUT) Deduplicated memo content
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
            *-- ASCAN avoids duplicate values, which are removed. v1.19.29
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Ignore corrupted (duplicate) objects to avoid "The specified key already exists"
      *            (Issue#17). Identified when the main class has Reserved1 empty instead of "Class".
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * lcCursor                  (v! IN    ) Alias of the binary cursor to scan and mark deleted
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Ignore objects that the VFP Designer would ignore (Issue#15): child objects whose
      *            primary parent is missing from the hierarchy are deleted from the cursor.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * lcCursor                  (v! IN    ) Alias of the binary cursor to scan and mark deleted
      *---------------------------------------------------------------------------------------------------
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
            * Has Parent; parent must exist, otherwise the object is ignored
            * NOTE: Only the primary (top-level) parent can be checked.
            If loObjs.GetKey(Getwordnum(lcParent + '.', 1, '.')) > 0
               * Exists: add the new object to the collection
               * NOTE: It could be duplicated, but that case is not handled here
               If Not Empty(lcParentObjName) And loObjs.GetKey(lcParentObjName) = 0
                  loObjs.Add( '', lcParentObjName )
               Endif
            Else
               * Does not exist: ignore (delete)
               Delete
            Endif
         Else
            * No parent: add to the collection
            If Not Empty(lcParentObjName) And loObjs.GetKey(lcParentObjName) = 0
               loObjs.Add( '', lcParentObjName )
            Endif

         Endif
      Endscan

      Return
   Endproc



   Procedure indentMemo
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Indent the code of a given method and strip the PROCEDURE/ENDPROC header/footer
      *            when found (unless tlKeepProcHeader keeps them).
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcMethod                  (v! IN    ) Method source code (memo)
      * tcIndentation             (v? IN    ) Left indentation string to prepend to each line
      * tlKeepProcHeader          (v? IN    ) .T. = keep PROCEDURE/ENDPROC lines (indented)
      *---------------------------------------------------------------------------------------------------
      Lparameters tcMethod, tcIndentation, tlKeepProcHeader
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

         *-- Remove blank lines after the ENDPROC
         X   = 0
         For I = lnFin To 1 Step -1
            If Not Empty(laLineas(m.I)) && Last code line
               If llProcedure And Left( Chrtran(laLineas(m.I), C_TAB, ' ') + ' ', 8 ) <> C_ENDPROC + ' ' Then
                  *ERROR 'Unclosed procedure. The last code line must be ENDPROC. [' + laLineas(1) + ']'
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

         *-- If a PROCEDURE header is found, skip it
         If llProcedure
            lnOffset    = 1
         Endif

         .rtrimProcCodeLines( @laLineas, lnFin )

         For I = lnInicio + lnOffset To lnFin - lnOffset
            *-- TEXT/ENDTEXT here causes recursion error 2044. Do not use.
            lcMethod    = lcMethod + CR_LF + iif( Empty(laLineas(m.I)), '', tcIndentation + laLineas(m.I) )
         Endfor

         If llProcedure And tlKeepProcHeader
            lcMethod    = CR_LF + C_TAB + laLineas(lnInicio) + lcMethod + CR_LF + C_TAB + laLineas(lnFin)
         Endif

         lcMethod    = Substr(lcMethod,3)    && Remove the leading CR+LF

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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Flatten a multi-line memo into a single comma-separated line.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcMethod                  (v! IN    ) Multi-line memo content to flatten
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Build a multi-line WITH property list for ADD OBJECT from a name/value array,
      *            using ", ;" line continuations.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * taPropsAndValues          (@! IN    ) Array of property names and values
      * tnPropCount               (v! IN    ) Number of properties in the array
      * tcLeftIndentation         (v? IN    ) Left indentation for each property line
      * tlNormalizeLine           (v? IN    ) Reserved/unused normalize flag
      *---------------------------------------------------------------------------------------------------
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

            *-- Remove the trailing ", ;<CRLF>"
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
      * PURPOSE:   Enrich the exception UserValue with a more precise error location inside METHODS
      *            (class/object path, method name, and relative line when available).
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toEx                      (v! IN/OUT) Exception object whose UserValue is appended
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

            *-- Find the Procedure when n_Methods_LineNo is set
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


   Procedure prioritizeLifecycleMethods
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Move lifecycle methods to the first positions of a method segment
      *            (class-level or object-level group), when they exist.
      *            Default order: Init, Destroy.
      *            Form class methods (Baseclass=form, not object suffix): Load, Init, Destroy, Unload.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * taMethods                 (@! IN/OUT) Method array [name, originalPos, type]
      * tnFrom                    (v! IN    ) First index of the segment to reorder
      * tnTo                      (@! IN/OUT) Last index of the segment (may shrink temporarily during Adel/Ains)
      * tlBySuffix                (v! IN    ) .T. = match last segment after '.' (object methods);
      *                                       .F. = match full name (class methods)
      * tcBaseClass               (v? IN    ) Class Baseclass (e.g. form); used when tlBySuffix is .F.
      *---------------------------------------------------------------------------------------------------
      Lparameters taMethods, tnFrom, tnTo, tlBySuffix, tcBaseClass
      External Array taMethods

      Try
         Local lnInsertPos, lcPriority, I, lnFound, lcMatchName, lnDot, lnP, laSave(3), laPriority(1) ;
            , lnPriorityCount, loEx As Exception

         If Type('tcBaseClass') # 'C'
            tcBaseClass = ''
         Endif

         If Not tlBySuffix And Lower(Alltrim(tcBaseClass)) == 'form'
            lnPriorityCount = 4
            Dimension laPriority(lnPriorityCount)
            laPriority(1)   = 'LOAD'
            laPriority(2)   = 'INIT'
            laPriority(3)   = 'DESTROY'
            laPriority(4)   = 'UNLOAD'
         Else
            lnPriorityCount = 2
            Dimension laPriority(lnPriorityCount)
            laPriority(1)   = 'INIT'
            laPriority(2)   = 'DESTROY'
         Endif

         lnInsertPos = tnFrom

         For lnP = 1 To lnPriorityCount
            lcPriority  = laPriority(m.lnP)
            lnFound     = 0

            For I = tnFrom To tnTo
               If taMethods(m.I, 2) = 0
                  Loop
               Endif

               lcMatchName = taMethods(m.I, 1)
               If tlBySuffix
                  lnDot       = RAt('.', lcMatchName)
                  lcMatchName = Iif(lnDot > 0, Substr(lcMatchName, lnDot + 1), lcMatchName)
               Endif

               If Upper(Alltrim(lcMatchName)) == lcPriority
                  lnFound = m.I
                  Exit
               Endif
            Endfor

            If lnFound > 0
               If lnFound # lnInsertPos
                  laSave(1)   = taMethods(lnFound, 1)
                  laSave(2)   = taMethods(lnFound, 2)
                  laSave(3)   = taMethods(lnFound, 3)
                  Adel( taMethods, lnFound )

                  If lnFound < lnInsertPos
                     lnInsertPos = lnInsertPos - 1
                  Endif

                  tnTo = tnTo - 1
                  Ains( taMethods, lnInsertPos )
                  taMethods(lnInsertPos, 1)   = laSave(1)
                  taMethods(lnInsertPos, 2)   = laSave(2)
                  taMethods(lnInsertPos, 3)   = laSave(3)
               Endif

               lnInsertPos = lnInsertPos + 1
            Endif
         Endfor

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release taMethods, tnFrom, tnTo, tlBySuffix, tcBaseClass ;
            , lnInsertPos, lcPriority, I, lnFound, lcMatchName, lnDot, lnP, laSave, laPriority ;
            , lnPriorityCount, loEx
      Endtry

      Return
   Endproc



   Procedure sortMethod
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Sort methods for text export (SCX/VCX DEFINE CLASS blocks).
      *            When l_MethodSort_Enabled is .T.: class methods first (Init, Destroy, then alphabetical;
      *            forms also prioritize Load before Init and Unload after Destroy), then object methods
      *            grouped by prefix (each group with Init/Destroy first).
      *            When .F.: keep original order, only move dotted object methods to the end.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcMethod                  (v? IN    ) Unused (shared signature with method2Array)
      * taMethods                 (@! IN/OUT) Method array [name, originalPos, type]
      * taCode                    (@! IN    ) Method code blocks (not reordered here; indexed via taMethods col 2)
      * tcSorted                  (v? IN    ) Unused (shared signature with method2Array)
      * tnMethodCount             (@! IN    ) Number of methods in taMethods
      * taPropsAndComments        (@? IN    ) Unused (shared signature with method2Array)
      * tnPropsAndComments_Count  (v? IN    ) Unused (shared signature with method2Array)
      * taProtected               (@? IN    ) Unused (shared signature with method2Array)
      * tnProtected_Count         (v? IN    ) Unused (shared signature with method2Array)
      * toFoxBin2Prg              (v? IN    ) Unused (shared signature with method2Array)
      * tcBaseClass               (v? IN    ) Class Baseclass (e.g. form) for lifecycle ordering
      *---------------------------------------------------------------------------------------------------
      Lparameters tcMethod, taMethods, taCode, tcSorted, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
         , taProtected, tnProtected_Count, toFoxBin2Prg, tcBaseClass

      External Array taMethods, taCode, taPropsAndComments, taProtected

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local I, I2, J, laMethods(1,3), lnDeleted, lcMethodName, lnMethodPos, lcMethodType ;
            , laClass(1,3), laObj(1,3), laStub(1,3), laObjSorted(1,3), laPrefixes(1), laGroup(1,3) ;
            , lnClassCount, lnObjCount, lnStubCount, lnObjSortedCount, lnPrefixCount, lnGroupCount ;
            , lcPrefix, lnPos, loEx As Exception

         If Type('tcBaseClass') # 'C'
            tcBaseClass = ''
         Endif

         If tnMethodCount > 0 Then

            *-- taMethods[1,3]
            *--     1.Method name
            *--     2.Original position
            *--     3.Type (HIDDEN/PROTECTED/NORMAL)

            If This.l_MethodSort_Enabled
               lnClassCount    = 0
               lnObjCount      = 0
               lnStubCount     = 0

               For I = 1 To tnMethodCount
                  If taMethods(m.I, 2) = 0
                     lnStubCount = lnStubCount + 1
                     Dimension laStub(lnStubCount, 3)
                     laStub(lnStubCount, 1)  = taMethods(m.I, 1)
                     laStub(lnStubCount, 2)  = taMethods(m.I, 2)
                     laStub(lnStubCount, 3)  = taMethods(m.I, 3)
                  Else
                     If '.' $ taMethods(m.I, 1)
                        lnObjCount  = lnObjCount + 1
                        Dimension laObj(lnObjCount, 3)
                        laObj(lnObjCount, 1)    = taMethods(m.I, 1)
                        laObj(lnObjCount, 2)    = taMethods(m.I, 2)
                        laObj(lnObjCount, 3)    = taMethods(m.I, 3)
                     Else
                        lnClassCount    = lnClassCount + 1
                        Dimension laClass(lnClassCount, 3)
                        laClass(lnClassCount, 1)    = taMethods(m.I, 1)
                        laClass(lnClassCount, 2)    = taMethods(m.I, 2)
                        laClass(lnClassCount, 3)    = taMethods(m.I, 3)
                     Endif
                  Endif
               Endfor

               If lnClassCount > 1
                  Asort(laClass, 1, -1, 0, 1)
               Endif

               If lnClassCount > 0
                  .prioritizeLifecycleMethods( @laClass, 1, lnClassCount, .F., tcBaseClass )
               Endif

               If lnStubCount > 1
                  Asort(laStub, 1, -1, 0, 1)
               Endif

               lnObjSortedCount    = 0
               lnPrefixCount       = 0
               Dimension laPrefixes(1)

               For I = 1 To lnObjCount
                  lcPrefix    = Left(laObj(m.I, 1), RAt('.', laObj(m.I, 1)) - 1)

                  If Ascan(laPrefixes, lcPrefix, 1, 0, 1, 1+8) = 0
                     lnPrefixCount   = lnPrefixCount + 1
                     Dimension laPrefixes(lnPrefixCount)
                     laPrefixes(lnPrefixCount)   = lcPrefix
                  Endif
               Endfor

               If lnPrefixCount > 1
                  Asort(laPrefixes, 1, -1, 0, 1)
               Endif

               For I = 1 To lnPrefixCount
                  lcPrefix        = laPrefixes(m.I)
                  lnGroupCount    = 0

                  For J = 1 To lnObjCount
                     If Lower( Left(laObj(m.J, 1), RAt('.', laObj(m.J, 1)) - 1) ) == Lower(lcPrefix)
                        lnGroupCount    = lnGroupCount + 1
                        Dimension laGroup(lnGroupCount, 3)
                        laGroup(lnGroupCount, 1)    = laObj(m.J, 1)
                        laGroup(lnGroupCount, 2)    = laObj(m.J, 2)
                        laGroup(lnGroupCount, 3)    = laObj(m.J, 3)
                     Endif
                  Endfor

                  If lnGroupCount > 1
                     Asort(laGroup, 1, -1, 0, 1)
                  Endif

                  If lnGroupCount > 0
                     .prioritizeLifecycleMethods( @laGroup, 1, lnGroupCount, .T., '' )
                  Endif

                  For J = 1 To lnGroupCount
                     lnObjSortedCount    = lnObjSortedCount + 1
                     Dimension laObjSorted(lnObjSortedCount, 3)
                     laObjSorted(lnObjSortedCount, 1)    = laGroup(m.J, 1)
                     laObjSorted(lnObjSortedCount, 2)    = laGroup(m.J, 2)
                     laObjSorted(lnObjSortedCount, 3)    = laGroup(m.J, 3)
                  Endfor
               Endfor

               lnPos   = 0

               For I = 1 To lnClassCount
                  lnPos   = lnPos + 1
                  taMethods(lnPos, 1) = laClass(m.I, 1)
                  taMethods(lnPos, 2) = laClass(m.I, 2)
                  taMethods(lnPos, 3) = laClass(m.I, 3)
               Endfor

               For I = 1 To lnStubCount
                  lnPos   = lnPos + 1
                  taMethods(lnPos, 1) = laStub(m.I, 1)
                  taMethods(lnPos, 2) = laStub(m.I, 2)
                  taMethods(lnPos, 3) = laStub(m.I, 3)
               Endfor

               For I = 1 To lnObjSortedCount
                  lnPos   = lnPos + 1
                  taMethods(lnPos, 1) = laObjSorted(m.I, 1)
                  taMethods(lnPos, 2) = laObjSorted(m.I, 2)
                  taMethods(lnPos, 3) = laObjSorted(m.I, 3)
               Endfor

            Else
               Dimension laMethods(tnMethodCount, 3)
               lnDeleted   = 0

               For I = tnMethodCount To 1 Step -1
                  If taMethods(m.I, 2) > 0 Then
                     If '.' $ taMethods(m.I, 1)
                        *-- Move methods with '.' to a temporary array
                        lnDeleted   = lnDeleted + 1
                        laMethods(lnDeleted, 1) = taMethods(m.I, 1)
                        laMethods(lnDeleted, 2) = taMethods(m.I, 2)
                        laMethods(lnDeleted, 3) = taMethods(m.I, 3)
                        Adel( taMethods, m.I )
                     Endif
                  Endif
               Endfor

               For I = lnDeleted To 1 Step -1
                  *-- Append methods with '.' at the end
                  I2  = tnMethodCount - lnDeleted + (lnDeleted - m.I) + 1
                  taMethods(I2, 1)    = laMethods(m.I, 1)
                  taMethods(I2, 2)    = laMethods(m.I, 2)
                  taMethods(I2, 3)    = laMethods(m.I, 3)
               Endfor
            Endif

         Endif

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Release tcMethod, taMethods, taCode, tcSorted, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
            , taProtected, tnProtected_Count, toFoxBin2Prg, tcBaseClass ;
            , I, I2, J, laMethods, lnDeleted, lcMethodName, lnMethodPos, lcMethodType ;
            , laClass, laObj, laStub, laObjSorted, laPrefixes, laGroup ;
            , lnClassCount, lnObjCount, lnStubCount, lnObjSortedCount, lnPrefixCount, lnGroupCount ;
            , lcPrefix, lnPos, loEx
      Endtry

      Return
   Endproc && sortMethod



   Procedure method2Array
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Parse a METHODS memo into taMethods/taCode arrays; handle PROC/ENDPROC inside
      *            TEXT/ENDTEXT (code generators); append stub methods from Protected/RESERVED3.
      *            29/10/2013  Fernando D. Bozzo — accounts for PROC/ENDPROC inside TEXT/ENDTEXT
      *            when used in a code generator or similar.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcMethod                  (v! IN    ) METHODS memo content to parse
      * taMethods                 (@! IN/OUT) Method array [name, originalPos, type]
      * taCode                    (@! IN/OUT) Method code blocks at original positions
      * tcSorted                  (v? IN    ) Unused (shared signature with sortMethod)
      * tnMethodCount             (@! IN/OUT) Number of methods found
      * taPropsAndComments        (@? IN    ) RESERVED3 DEFINED entries (stub methods)
      * tnPropsAndComments_Count  (v? IN    ) Count of RESERVED3 DEFINED entries
      * taProtected               (@? IN    ) Protected/hidden member names
      * tnProtected_Count         (v? IN    ) Count of protected/hidden members
      * toFoxBin2Prg              (v! IN    ) Reference to the main FoxBin2Prg instance
      * toRegObj                  (v? IN    ) Optional object register (shared call sites)
      *---------------------------------------------------------------------------------------------------
      Lparameters tcMethod, taMethods, taCode, tcSorted, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
         , taProtected, tnProtected_Count, toFoxBin2Prg, toRegObj
      External Array taMethods, taCode, taPropsAndComments, taProtected

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      *-- STRUCTURE OF THE ARRAYS CREATED:
      *-- taMethods[1,3]
      *--     1.Method name
      *--     2.Original position
      *--     3.Type (HIDDEN/PROTECTED/NORMAL)
      *-- taCode[1]
      *--     1.Method code block at its original position
      Try
         Local lnLineCount, laLine(1), I, lnTextNodes, tcSorted, lnProtectedLine, lcMethod, lnLine_Len, lcLine, llProcOpen ;
            , laLineasExclusion(1), lnBloquesExclusion, lcLastLine, lcAppendLine ;
            , loEx As Exception

         If Not Empty(m.tcMethod) And Left(m.tcMethod,9) == "ENDPROC"+Chr(13)+Chr(10)
            tcMethod    = Substr(m.tcMethod,10)
         Endif

         If Not Empty(m.tcMethod)
            With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
               Dimension laLine(1)
               Store '' To laLine, lcLine, lcLastLine
               Store 0 To lnTextNodes

               lnLineCount = Alines(laLine, m.tcMethod)    && Do NOT apply any format or cleanup; this is SOURCE CODE

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

               *-- Identify TEXT/ENDTEXT, #IF .F./#ENDIF exclusion blocks
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
                        lcAppendLine  = laLine(m.I)
                        taCode(tnMethodCount)   = taCode(tnMethodCount) + lcAppendLine + CR_LF
                     Else
                        *-- Invalid method code, as outer code added for tools like ReFox or others, is cleaned up
                     Endif

                  Case Right(lcLastLine,1) == ';'
                     *-- Skip analysis of this line; it continues the previous one (lcLastLine).
                     lcAppendLine  = Iif( laLineasExclusion(m.I), laLine(m.I), .rtrimProcCodeLine( laLine(m.I) ) )
                     taCode(tnMethodCount)   = taCode(tnMethodCount) + lcAppendLine + CR_LF
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
                        *-- End of ENDPROC structure
                        If Not llProcOpen
                           *-- Abnormal: more than one ENDPROC; ignore this one.
                           Loop
                        Endif
                     Else
                        *-- Something else (variable, etc.)
                        lcAppendLine  = Iif( laLineasExclusion(m.I), lcLine, .rtrimProcCodeLine( lcLine ) )
                        taCode(tnMethodCount)   = taCode(tnMethodCount) + lcAppendLine + CR_LF
                        Loop
                     Endif

                     lcAppendLine  = Iif( laLineasExclusion(m.I), lcLine, .rtrimProcCodeLine( lcLine ) )
                     taCode(tnMethodCount)   = taCode(tnMethodCount) + lcAppendLine &&+ CR_LF
                     llProcOpen              = .F.

                  Case lnTextNodes = 0 And Left(laLine(m.I), 7) == 'ENDFUNC'  && NOT VALID WITH VFP IDE, BUT 3rd. PARTY SOFTWARE CAN USE IT
                     If lnLine_Len >= 7 And Left( Upper( Chrtran( laLine(m.I) , '&'+Chr(9)+Chr(0), '   ') ) + ' ' ,8) == 'ENDFUNC '
                        *-- End of ENDFUNC structure (normalized to ENDPROC)
                        If Not llProcOpen
                           *-- Abnormal: more than one ENDFUNC; ignore this one.
                           Loop
                        Endif
                        lcLine  = Strtran( lcLine, 'ENDFUNC', 'ENDPROC' )
                     Else
                        *-- Something else (variable, etc.)
                        lcAppendLine  = Iif( laLineasExclusion(m.I), lcLine, .rtrimProcCodeLine( lcLine ) )
                        taCode(tnMethodCount)   = taCode(tnMethodCount) + lcAppendLine + CR_LF
                        Loop
                     Endif

                     lcAppendLine  = Iif( laLineasExclusion(m.I), lcLine, .rtrimProcCodeLine( lcLine ) )
                     taCode(tnMethodCount)   = taCode(tnMethodCount) + lcAppendLine &&+ CR_LF
                     llProcOpen              = .F.

                     *CASE tnMethodCount = 0 OR NOT llProcOpen AND LEFT( LTRIM(laLine(m.I)),1 ) = '*'
                  Case tnMethodCount = 0 Or Not llProcOpen
                     *-- Skip empty and commented lines before methods begin
                     *-- Could use: NOT llProcOpen AND LEFT(laLine(m.I), 7) # 'ENDPROC', but that would be too broad.

                  Otherwise && Method Code
                     lcAppendLine  = Iif( laLineasExclusion(m.I), laLine(m.I), .rtrimProcCodeLine( laLine(m.I) ) )
                     taCode(tnMethodCount)   = taCode(tnMethodCount) + lcAppendLine + CR_LF

                  Endcase
               Endfor

               *-- Add defined methods that have no code (Protected/Reserved3)
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
            , laLineasExclusion, lnBloquesExclusion, lcLastLine, lcAppendLine ;
            , loEx
      Endtry

      Return
   Endproc && method2Array



   Procedure write_ADD_OBJECTS_WithProperties
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit an ADD OBJECT ... WITH ... END OBJECT block (plus ClassLib/BaseClass/OLE
      *            metadata) for a contained object into the generated text.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toRegObj                  (v! IN    ) Object register (CL_OBJETO) for the contained object
      * tcCodigo                  (@? IN/OUT) Generated source text being appended
      * toFoxBin2Prg              (v! IN    ) Reference to the main FoxBin2Prg instance
      *---------------------------------------------------------------------------------------------------
      Lparameters toRegObj, tcCodigo, toFoxBin2Prg

      #If .F.
         Local toRegObj As CL_OBJETO Of 'cl_objeto.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcMemo, laPropsAndValues(1,2), lnPropsAndValues_Count

         With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
            *-- Define the objects to load
            .get_PropsAndValuesFrom_PROPERTIES( toRegObj.PROPERTIES, 1, @laPropsAndValues, @lnPropsAndValues_Count, @lcMemo, @toFoxBin2Prg )
            lcMemo  = .set_MultilineMemoWithAddObjectProperties( @laPropsAndValues, @lnPropsAndValues_Count, C_TAB + C_TAB, .T. )

            If '.' $ toRegObj.Parent
               *-- This case: class.object.object ==> strip the class name
               TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                  <<Chr(9)>>ADD OBJECT '<<SUBSTR(toRegObj.Parent, AT('.', toRegObj.Parent)+1)>>.<<toRegObj.objName>>' AS <<LOWER(ALLTRIM(toRegObj.Class))>> <<>>
               ENDTEXT
            Else
               *-- This case: object
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

            *-- Add meta-information for OLE objects
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Sort all methods and append their indented PROCEDURE blocks to the generated text.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcMethods                 (@? IN    ) Unused METHODS memo (shared signature with sortMethod)
      * taMethods                 (@! IN/OUT) Method array [name, originalPos, type]
      * taCode                    (@! IN    ) Method code blocks indexed via taMethods col 2
      * tnMethodCount             (@! IN    ) Number of methods in taMethods
      * taPropsAndComments        (@? IN    ) RESERVED3 DEFINED entries (passed through to sortMethod)
      * tnPropsAndComments_Count  (v? IN    ) Count of RESERVED3 DEFINED entries
      * taProtected               (@? IN    ) Protected/hidden members (passed through to sortMethod)
      * tnProtected_Count         (v? IN    ) Count of protected/hidden members
      * toFoxBin2Prg              (v? IN    ) Reference to the main FoxBin2Prg instance
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      * tcBaseClass               (v? IN    ) Class Baseclass (e.g. form) for lifecycle ordering
      *---------------------------------------------------------------------------------------------------
      Lparameters tcMethods, taMethods, taCode, tnMethodCount, taPropsAndComments, tnPropsAndComments_Count ;
         , taProtected, tnProtected_Count, toFoxBin2Prg, tcCodigo, tcBaseClass

      *-- Finally, sort all methods and write them together
      Local laMethods(1), laCode(1), lnMethodCount, I, lcMethods

      If Type('tcBaseClass') # 'C'
         tcBaseClass = ''
      Endif

      If tnMethodCount > 0 Then
         Store '' To lcMethods
         Dimension laMethods(1,3)

         With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
            .sortMethod( @tcMethods, @taMethods, @taCode, '', @tnMethodCount ;
               , @taPropsAndComments, tnPropsAndComments_Count, @taProtected, tnProtected_Count, @toFoxBin2Prg, tcBaseClass )

            For I = 1 To tnMethodCount
               *-- Generate the indented methods
               *-- Avoid TEXT/ENDTEXT here because it sometimes strips trailing spaces, which is unsafe
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit class-level DEFINED_PAM, HIDDEN/PROTECTED lists, and property name=value
      *            blocks (with DefinedPropVal delimiters) into the generated text.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toRegClass                (v! IN    ) Class register with PROPERTIES/RESERVED3/Protected
      * taPropsAndValues          (@! IN/OUT) Property name/value array filled from PROPERTIES
      * taPropsAndComments        (@! IN/OUT) RESERVED3 DEFINED entries array
      * taProtected               (@! IN/OUT) Protected/hidden member names array
      * tnPropsAndValues_Count    (@! IN/OUT) Count of property name/value pairs
      * tnPropsAndComments_Count  (@! IN/OUT) Count of RESERVED3 DEFINED entries
      * tnProtected_Count         (@! IN/OUT) Count of protected/hidden members
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      * toFoxBin2Prg              (v! IN    ) Reference to the main FoxBin2Prg instance
      *---------------------------------------------------------------------------------------------------
      Lparameters toRegClass, taPropsAndValues, taPropsAndComments, taProtected ;
         , tnPropsAndValues_Count, tnPropsAndComments_Count, tnProtected_Count, tcCodigo, toFoxBin2Prg

      External Array taPropsAndValues, taPropsAndComments

      Try
         Local lcHiddenProp, lcProtectedProp, lcPropsMethodsDefd, I ;
            , lcPropName, lnProtectedItem, lcComentarios ;
            , loEx As Exception

         With This As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
            *-- DEFINE PROPERTIES ( HIDDEN, PROTECTED, *DEFINED_PAM )
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

               *-- Write class properties and their comments (comments here are redundant)

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
                  tcCodigo = tcCodigo + CR_LF + C_TAB + C_DEFINED_PROPVAL_I

                  For I = 1 To tnPropsAndValues_Count
                     tcCodigo = tcCodigo + CR_LF + C_TAB + C_TAB + taPropsAndValues(m.I,1) + ' = ' + taPropsAndValues(m.I,2)
                  Endfor

                  tcCodigo = tcCodigo + CR_LF + C_TAB + C_DEFINED_PROPVAL_F
               Endif

               tcCodigo = tcCodigo + CR_LF
            Endif
         Endwith

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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Write DEFINED (Reserved3) properties/methods/arrays in DefinedPropArrayMethod format.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * taPropsAndComments        (@! IN    ) RESERVED3 DEFINED entries [name, comment]
      * tnPropsAndComments_Count  (v! IN    ) Count of RESERVED3 DEFINED entries
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
      *-- Write DEFINED properties (Reserved3) in this format:
      Lparameters taPropsAndComments, tnPropsAndComments_Count, tcCodigo

      *<DefinedPropArrayMethod>
      *m: *empty_method_with_comments        && This method has no code, but has comments. Let's see what happens!
      *m: *mymethod       && My method
      *p: prop1       && My prop 1
      *p: prop_especial_cr        &&
      *a: ^array_1_d[1,0]     && 1-dimension array (1)
      *a: ^array_2_d[1,2]     && One-dimension array (1,2)
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit the DEFINE CLASS ... AS ... [OF ...] [OLEPUBLIC] header line.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * ta_NombresObjsOle         (@! IN    ) Array of OLE public object names
      * toRegClass                (v! IN    ) Class register (ObjName, Class, ClassLoc, etc.)
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
      Lparameters ta_NombresObjsOle, toRegClass, tcCodigo

      Local lcOF_Classlib, llOleObject
      lcOF_Classlib   = ''
      llOleObject     = ( Ascan( ta_NombresObjsOle, toRegClass.OBJNAME, 1, 0, 1, 1+2+4+8) > 0 )

      If Not Empty(toRegClass.CLASSLOC)
         lcOF_Classlib   = ' OF "' + Lower(Alltrim(toRegClass.CLASSLOC)) + '"'
      Endif

      *-- CLASS DEFINITION ( DEFINE CLASS 'className' AS 'classType' [OF 'classLib'] [OLEPUBLIC] )
      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
         DEFINE CLASS <<ALLTRIM(toRegClass.ObjName)>> AS <<LOWER(ALLTRIM(toRegClass.Class)) + lcOF_Classlib + IIF(llOleObject, ' OLEPUBLIC', '')>>
      ENDTEXT

      Return
   Endproc



   Procedure write_DEFINE_CLASS_COMMENTS
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit class comments from RESERVED7 as an inline && comment or a ClassComments block.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toRegClass                (v! IN    ) Class register containing RESERVED7 comments
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
      Lparameters toRegClass, tcCodigo
      *-- Class comment
      If Not Empty(toRegClass.RESERVED7) Then
         *-- If multi-line, emit a separate <ClassComments> tag
         If Occurs( Chr(13), toRegClass.RESERVED7 ) > 0 Then
            TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                    <<Chr(9)>><<C_CLASSCOMMENTS_I>>
                    <<THIS.indentMemo( toRegClass.Reserved7, C_TAB + C_TAB + '*' )>>
                    <<Chr(9)>><<C_CLASSCOMMENTS_F>>
            ENDTEXT
         Else    && Inline comment
            TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                    <<Chr(9)+Chr(9)>><<'&'+'&'>> <<toRegClass.Reserved7>>
            ENDTEXT
         Endif
      Endif

      Return
   Endproc



   Procedure write_ENDDEFINE_IfApplicable
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit ENDDEFINE when finishing the last class in the module.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tnLastClass               (v! IN    ) 1 = this is the last class; otherwise skip
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit an EXTERNAL_CLASS header line identifying an external member class name.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toRegClass                (v! IN    ) Class register (objname, Baseclass)
      * toFoxBin2Prg              (v! IN    ) Reference to the main FoxBin2Prg instance
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit an EXTERNAL_MEMBER header line identifying an external member name and type.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toFoxBin2Prg              (v! IN    ) Reference to the main FoxBin2Prg instance
      * tcMemberName              (v! IN    ) External member name
      * tcMemberType              (v! IN    ) External member type
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit a #INCLUDE directive from RESERVED8 when present.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toReg                     (v! IN    ) Register containing RESERVED8 include path
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit class metadata (Baseclass, Timestamp, Scale, Uniqueid, OLE, icons) tags.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toRegClass                (v! IN    ) Class register with metadata fields
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
      Lparameters toRegClass, tcCodigo

      *-- Add class metadata (Baseclass, Timestamp, Scale, Uniqueid)
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit object metadata (ObjPath, UniqueID, Timestamp) tags for a contained object.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toRegObj                  (v! IN    ) Object register with Parent/OBJNAME/Uniqueid/Timestamp
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
      Lparameters toRegObj, tcCodigo
      Local lcNombre

      *-- Add object metadata (Timestamp, UniqueID)
      TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
            <<>>
      ENDTEXT

      If '.' $ toRegObj.Parent
         *-- This case: class.object.object ==> strip the class name
         lcNombre = Substr(toRegObj.Parent, At('.', toRegObj.Parent)+1) + '.' + toRegObj.OBJNAME
      Else
         *-- This case: object
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit the HIDDEN property declaration line when Hidden properties exist.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcHiddenProp              (v! IN    ) Comma-prefixed list of Hidden property names
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
      *-- Write the HIDDEN property definition
      Lparameters tcHiddenProp, tcCodigo

      If Not Empty(tcHiddenProp)
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>>HIDDEN <<SUBSTR(tcHiddenProp,2)>>
         ENDTEXT
      Endif

      Return
   Endproc



   Procedure write_PROTECTED_Properties
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit the PROTECTED property declaration line when Protected properties exist.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcProtectedProp           (v! IN    ) Comma-prefixed list of Protected property names
      * tcCodigo                  (@! IN/OUT) Generated source text being appended
      *---------------------------------------------------------------------------------------------------
      *-- Write the PROTECTED property definition
      Lparameters tcProtectedProp, tcCodigo

      If Not Empty(tcProtectedProp)
         TEXT TO tcCodigo ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>>PROTECTED <<SUBSTR(tcProtectedProp,2)>>
         ENDTEXT
      Endif

      Return
   Endproc


   Procedure write_OLEObjectDefinitions
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Emit the OLE object definition header marker for forms/classes that may contain OLE.
      *            Historical note (fdbozzo 29/11/2014 v1.19.37): per-OLE blank lines were removed
      *            because they looked bad and were unnecessary; forms/classes with OLE objects will
      *            differ once in the header.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * toFoxBin2Prg              (v! IN    ) Reference to the main FoxBin2Prg instance
      *---------------------------------------------------------------------------------------------------
      *-- Create the *< OLE: /> tag definition with information for all OLE objects
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

      *-- THE FOLLOWING WAS COMMENTED OUT BECAUSE EACH OLE OBJECT ADDED AN EMPTY LINE THAT LOOKED BAD AND WAS UNNECESSARY.
      *-- AS A RESULT, FORMS OR CLASSES WITH OLE OBJECTS WILL DIFFER ONCE IN THE HEADER. - fdbozzo. 29/11/2014 (v1.19.37)
      *
      *SELECT COUNT(*) FROM TABLABIN WHERE TABLABIN.PLATFORM = "WINDOWS" AND BASECLASS == 'olecontrol' INTO ARRAY laOLE

      *IF laOLE(1) > 0 THEN
      *   *-- The <<>> to create an empty line is only for compatibility with the old format,
      *   *-- where this line was created when the form or class had at least one OLE object.
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Write the generated text to the output file (mirrored path, backup, skip if unchanged).
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcCodigo                  (v! IN    ) Generated source text to write
      * tcOutputFile              (v! IN/OUT) Output file path (may be remapped to mirrored folder)
      * toFoxBin2Prg              (v! IN    ) Reference to the main FoxBin2Prg instance
      *---------------------------------------------------------------------------------------------------
      Lparameters tcCodigo, tcOutputFile, toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcExpanded, llFileExists, lnBytes, lcOutputFile, laDirFile(1,5) ;
            , loLang As CL_LANG Of 'cl_lang.prg'

         * Default in lowercase
         tcOutputFile = Lower(tcOutputFile)

         *** + mirror tree: if cInputRoot is set, replicate the folder structure
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
            Exit    && If processing was disabled, leave the process. (Simulation mode)
         Endif

         loLang          = _Screen.o_FoxBin2Prg_Lang
         lcOutputFile    = tcOutputFile
         llFileExists    = ( Adir(laDirFile, tcOutputFile) = 1 )

         If llFileExists And toFoxBin2Prg.readTextFile(tcOutputFile) == tcCodigo Then
            *.writeLog( 'Output file [' + .c_OutputFile + '] is not overwritten because it matches the generated content.' )
            This.writeLog( C_TAB + C_TAB + '* ' + Textmerge(loLang.C_OUTPUT_FILE_IS_NOT_OVERWRITEN_LOC) )

         Else
            If llFileExists Then
               toFoxBin2Prg.doBackup( .F., .T., '', '', '', tcOutputFile )
               toFoxBin2Prg.changeFileAttribute( tcOutputFile, '-R' )
            ENDIF

            lnBytes = toFoxBin2Prg.writeTextFile( tcCodigo, tcOutputFile )

            This.writeLog( C_TAB + C_TAB + '- ' + loLang.C_FILENAME_LOC + ': ' + tcOutputFile + ' (' + Alltrim(Transform(lnBytes/1024,'######.##')) + '/' + Alltrim(Transform(Len(tcCodigo)/1024,'######.##')) + ' KiB)' )

            If lnBytes = 0
               *ERROR 'Cannot generate file [' + .c_OutputFile + '] because it is ReadOnly'
               Error (Textmerge(loLang.C_CANT_GENERATE_FILE_BECAUSE_IT_IS_READONLY_LOC))
            Endif
         Endif

         toFoxBin2Prg.normalizeFileCapitalization( .F., tcOutputFile )
      Endtry
   Endproc




   Procedure FixOle2Fields
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Normalize OLE2 paths for ActiveX controls stored outside the project directory
      *            (from TwoFox by Christof Wallenhaupt — http://www.foxpert.com/downloads.htm).
      *            When a control is outside the project dir, keep only the file name so paths do not
      *            differ across developer machines.
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * (none)                    Operates on the current work area's OLE2 field via Scan
      *---------------------------------------------------------------------------------------------------

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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Return .T. when the OCX control path resides outside the project directory
      *            (from TwoFox by Christof Wallenhaupt — http://www.foxpert.com/downloads.htm).
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcOcx                     (v! IN    ) Full OCX/DLL path from OLE2
      * tcProjDir                 (v! IN    ) Project directory (uppercase, no trailing backslash)
      *---------------------------------------------------------------------------------------------------
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
      *---------------------------------------------------------------------------------------------------
      * PURPOSE:   Replace the OLE2 OLEObject path with the file name only
      *            (from TwoFox by Christof Wallenhaupt — http://www.foxpert.com/downloads.htm).
      * PARAMETERS:               (v=by value | @=by reference) (!=required | ?=optional) (IN/OUT)
      * tcOcx                     (v! IN    ) Full OCX/DLL path to truncate in the current OLE2 field
      *---------------------------------------------------------------------------------------------------
      * (This method is taken from Open Source project TwoFox, from Christof Wallenhaupt - http://www.foxpert.com/downloads.htm)
      * Change an OLE2 field to the file name only
      Replace OLE2 With Strtran ( ;
         OLE2 ;
         ,"OLEObject = " + m.tcOcx ;
         ,"OLEObject = " + Justfname(m.tcOcx) ;
         )
   Endproc


Enddefine
