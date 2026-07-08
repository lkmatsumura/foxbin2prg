
#INCLUDE foxbin2prg.h

Define Class c_conversor_scx_a_prg As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   #If .F.
      Local This As c_conversor_scx_a_prg Of 'c_conversor_scx_a_prg.prg'
   #Endif
   c_Type = 'SCX'


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@    OUT) Objeto generado de clase CL_CLASSLIB con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

      #If .F.
         Local toModulo As CL_CLASSLIB Of 'cl_classlib.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lnCodError, loRegClass, loRegObj  , lnMethodCount, lnLen, lnObjCount, lnLastClass, lnRecno ;
             , lcMethods, lcObjName, I, lnPropsAndValues_Count, lnPropsAndComments_Count, lnProtected_Count ;
             , lcCodigo , lnClassCount, lcOutputFile, lcExternalHeader, lnClassTotal, lnStepCount, lnStep ;
             , lcObjPathInsideClass, lnPos, lcSc2Ext, llUseFormPerDir, lnUseFormPerFile, lnDataEnvCount

         LOCAL loLang As CL_LANG Of 'cl_lang.prg'

         LOCAL laMethods(1), laCode(1), laProtected(1), laPropsAndValues(1), laPropsAndComments(1), la_NombresObjsOle(1) ;
             , laObjs(1,4), laClasses(1,3), laDataEnvNames(1)


         Store 0 To lnCodError, lnLastClass, lnObjCount, lnPropsAndValues_Count, lnPropsAndComments_Count ;
                  , lnProtected_Count, lnMethodCount, lnClassCount, lnStepCount, lnStep, lnDataEnvCount

         Store '' To laMethods, laCode, laProtected, laPropsAndComments, laObjs, lcCodigo, laClasses, lcOutputFile ;
                   , C_FB2PRG_CODE, lcExternalHeader, laDataEnvNames

         Store .Null. To loRegClass, loRegObj

         loLang  = _Screen.o_FoxBin2Prg_Lang

         With This As c_conversor_scx_a_prg Of 'c_conversor_scx_a_prg.prg'
            Use (.c_InputFile) Shared Again Noupdate Alias _TABLAORIG

            *issue #96, including issue #95, [KestasL] keep CodePage relavant information for binary sources
            toFoxBin2Prg.i_CPID = Cpdbf("_TABLAORIG")

            Set NoCPTrans To Class,CLASSLOC,BaseClass,OBJNAME,Parent,PROPERTIES,Protected,METHODS;
               ,OBJCODE,OLE,OLE2,RESERVED1,RESERVED2,RESERVED3,RESERVED4,RESERVED5,RESERVED6,RESERVED7,RESERVED8,User

            Select _TABLAORIG.*,Recno() regnum From _TABLAORIG Into Cursor TABLABIN Readwrite

            Use In (Select("_TABLAORIG"))

            * Issue#15: Ignorar objetos mal definidos
            .ignoreIncorrectDefinedObjects('TABLABIN')

            Index On Padr(Lower(PLATFORM + Iif(Empty(Parent),'',Alltrim(Parent)+'.')+OBJNAME),239) Tag PARENT_OBJ Additive
            Set Order To 0 In TABLABIN

            .get_OLEPublicObjectName( @la_NombresObjsOle )

            .write_OLEObjectDefinitions( @toFoxBin2Prg )

            lnDataEnvCount = 0
            Select TABLABIN
            Scan For Lower( Alltrim( TABLABIN.BaseClass ) ) = 'dataenvironment'
               lnDataEnvCount = lnDataEnvCount + 1
               Dimension laDataEnvNames( lnDataEnvCount )
               laDataEnvNames( lnDataEnvCount ) = Lower( Alltrim( TABLABIN.OBJNAME ) )
            Endscan

            *-- Escribo los métodos ordenados
            lnLastObj       = 0
            lnLastClass     = 0

            *----------------------------------------------
            *-- RECORRO LAS CLASES
            *----------------------------------------------
            Select TABLABIN
            Set Order To PARENT_OBJ
            Goto Record 1   && Class Library Header/Form Header

            loRegClass  = .Null.
            Scatter Fields RESERVED8,RESERVED7 Memo Name loRegClass

            If Not Empty(loRegClass.RESERVED7) Then
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        <<C_LIBCOMMENT_I>> <<loRegClass.Reserved7>> <<C_LIBCOMMENT_F>>
                        *
               ENDTEXT
            Endif


            If Not Empty(loRegClass.RESERVED8) Then
               TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                        #INCLUDE "<<loRegClass.Reserved8>>"
                        <<>>
               ENDTEXT
            Endif


            Count All For TABLABIN.PLATFORM = "WINDOWS" ;
               AND ( Empty( TABLABIN.Parent ) ;
               AND Inlist( Lower( TABLABIN.BaseClass ), 'dataenvironment', 'form', 'formset' ) ) To lnClassTotal

            Scan All For TABLABIN.PLATFORM = "WINDOWS" ;
                  AND ( Empty( TABLABIN.Parent ) ;
                  AND Inlist( Lower( TABLABIN.BaseClass ), 'dataenvironment', 'form', 'formset' ) )

               Store 0 To lnMethodCount
               Store '' To laMethods, laCode, lcCodigo
               lnClassCount    = lnClassCount + 1
               Dimension laClasses(lnClassCount,3)

               loRegClass  = .Null.
               Scatter Memo Name loRegClass

               *-- Normalización de capitalización y de datos según parametrización
               loRegClass.BaseClass    = Lower( loRegClass.BaseClass )
               loRegClass.CLASSLOC     = Lower( loRegClass.CLASSLOC )
               loRegClass.Class        = Lower( loRegClass.Class )
               loRegClass.OBJNAME      = Lower( loRegClass.OBJNAME )

               If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
                  loRegClass.Timestamp    = 0
               Endif
               If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
                  loRegClass.UNIQUEID = ''
               Else
                  loRegClass.UNIQUEID = Alltrim(loRegClass.UNIQUEID)
               Endif

               lcObjName   = Alltrim(loRegClass.OBJNAME)
               laClasses(lnClassCount,1)   = Lower( lcObjName )
               laClasses(lnClassCount,2)   = ''
               laClasses(lnClassCount,3)   = loRegClass.BaseClass

               If Not toFoxBin2Prg.l_ProcessFiles Then
                  Loop    && Si se indicó no procesar, salteo el resto del proceso. (Modo de simulación)
               Endif

               lnStep          = lnStep + 1
               .updateProgressbar( 'Processing Form ' + lcObjName + '...', lnStep, lnClassTotal*lnStepCount, 1 )

               .write_DEFINE_CLASS( @la_NombresObjsOle, @loRegClass, @lcCodigo )

               .write_DEFINE_CLASS_COMMENTS( @loRegClass, @lcCodigo )

               .write_CLASSMETADATA( @loRegClass, @lcCodigo )

               If toFoxBin2Prg.getCfgValue('n_UseFormPerFile') > 0 Then
                  .write_EXTERNAL_CLASS_HEADER( @loRegClass, @toFoxBin2Prg, @lcExternalHeader )
               Endif

               *-------------------------------------------------------------------------------
               *-- RECORRO LOS OBJETOS DENTRO DE LA CLASE ACTUAL PARA EXPORTAR SU DEFINICIÓN
               *-------------------------------------------------------------------------------
               lnObjCount  = 0
               lnRecno = Recno()
               Locate For Upper( TABLABIN.PLATFORM ) = "WINDOWS" And Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

               Scan Rest While Upper( TABLABIN.PLATFORM ) = "WINDOWS" And Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)
                  lnObjCount  = lnObjCount + 1
                  loRegObj    = .Null.
                  Scatter Memo Name loRegObj

                  *-- Normalización de capitalización y de datos según parametrización
                  loRegObj.BaseClass      = Lower( loRegObj.BaseClass )
                  loRegObj.CLASSLOC       = Lower( loRegObj.CLASSLOC )
                  loRegObj.Class          = Lower( loRegObj.Class )
                  lcObjPathInsideClass    = Lower( loRegObj.Parent ) + '.' + Lower( loRegObj.OBJNAME )

                  If lnObjCount > 1 Then
                     lnPos   = Ascan( laObjs, lcObjPathInsideClass, 1, 0, 4, 1+2+4+8 )

                     If lnPos > 0 Then
                        *-- ERROR: Objeto Duplicado
                        .writeErrorLog( '* ' + loLang.C_DUPLICATED_OBJECT_LOC + ' "' + loRegObj.Class + '.' + lcObjPathInsideClass ;
                           + '" @Recno ' + Transform(loRegObj.regnum) + ', (1st.Recno:' + Transform(laObjs(lnPos,2)) + ')' )
                     Endif
                  Endif

                  Dimension laObjs(lnObjCount,4)

                  If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
                     loRegObj.Timestamp  = 0
                  Endif
                  If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
                     loRegObj.UNIQUEID   = ''
                  Else
                     loRegObj.UNIQUEID   = Alltrim(loRegObj.UNIQUEID)
                  Endif

                  If toFoxBin2Prg.getCfgValue('l_StripDataEnvCursorPaths') ;
                        And .isDataEnvCursor( @loRegObj, @laDataEnvNames, lnDataEnvCount )
                     loRegObj.Properties = .stripDataEnvCursorProperties( loRegObj.Properties )
                  Endif

                  laObjs(lnObjCount,1)    = loRegObj
                  laObjs(lnObjCount,2)    = loRegObj.regnum       && ZOrder
                  laObjs(lnObjCount,3)    = lnObjCount            && Alphabetic order
                  laObjs(lnObjCount,4)    = lcObjPathInsideClass  && To check duplicates

                  loRegObj    = .Null.
               Endscan

               Goto Record (lnRecno)
               Asort(laObjs, 2, -1, 0, 0)  && Orden por ZOrder

               If lnObjCount > 0
                  lcCodigo    = lcCodigo + CR_LF + C_TAB +'*-- OBJECTDATA items order determines ZOrder / El orden de los items OBJECTDATA determina el ZOrder '

                  For I = 1 To lnObjCount
                     .write_OBJECTMETADATA( laObjs(m.I,1), @lcCodigo )
                  Endfor

                  lcCodigo    = lcCodigo + CR_LF
               Endif

               .write_INCLUDE( @loRegClass, @lcCodigo )

               lnStep          = lnStep + 1
               .updateProgressbar( 'Processing Form ' + lcObjName + ' > Writing Properties...', lnStep, lnClassTotal*lnStepCount, 1 )

               .write_CLASS_PROPERTIES( @loRegClass, @laPropsAndValues, @laPropsAndComments, @laProtected ;
                  , @lnPropsAndValues_Count, @lnPropsAndComments_Count, @lnProtected_Count, @lcCodigo, @toFoxBin2Prg )

               Asort(laObjs, 3, -1, 0, 0)  && Orden Alfabético de objetos (del SCAN original)

               lnStep          = lnStep + 1
               .updateProgressbar( 'Processing Form ' + lcObjName + ' > Writing Obtects with Properties...', lnStep, lnClassTotal*lnStepCount, 1 )

               For I = 1 To lnObjCount
                  .write_ADD_OBJECTS_WithProperties( laObjs(m.I,1), @lcCodigo, @toFoxBin2Prg )
               Endfor


               *-- OBTENGO LOS MÉTODOS DE LA CLASE PARA POSTERIOR TRATAMIENTO
               lnStep          = lnStep + 1
               .updateProgressbar( 'Processing Form ' + lcObjName + ' > Getting Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

               Dimension laMethods(1,3), laCode(1)
               Store '' To laMethods, laCode
               lnMethodCount   = 0

               .method2Array( loRegClass.METHODS, @laMethods, @laCode, '', @lnMethodCount ;
                  , @laPropsAndComments, lnPropsAndComments_Count, @laProtected, lnProtected_Count, @toFoxBin2Prg, @loRegClass )

               .get_CLASS_METHODS( @lnMethodCount, @laMethods, @laCode, @laProtected, @laPropsAndComments, @toFoxBin2Prg )

               lnLastClass     = 1
               lcMethods       = ''

               *-- RECORRO LOS OBJETOS DENTRO DE LA CLASE ACTUAL PARA OBTENER SUS MÉTODOS
               lnStep          = lnStep + 1
               .updateProgressbar( 'Processing Form ' + lcObjName + ' > Getting Objects Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

               lnRecno = Recno()
               Locate For TABLABIN.PLATFORM = "WINDOWS" And Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

               Scan Rest ;
                     FOR Upper( TABLABIN.PLATFORM ) = "WINDOWS" ;
                     AND Not (Empty(TABLABIN.Parent) ;
                     AND ( Inlist( Lower( TABLABIN.BaseClass ), 'dataenvironment' , 'form', 'formset' ) ) ) ;
                     WHILE Lower( Alltrim( Getwordnum( TABLABIN.Parent, 1, '.' ) ) ) == Lower(lcObjName)

                  loRegObj    = .Null.
                  Scatter Memo Name loRegObj

                  *-- Normalización de capitalización y de datos según parametrización
                  loRegObj.BaseClass  = Lower( loRegObj.BaseClass )
                  loRegObj.CLASSLOC   = Lower( loRegObj.CLASSLOC )
                  loRegObj.Class      = Lower( loRegObj.Class )

                  If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
                     loRegObj.Timestamp  = 0
                  Endif
                  If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
                     loRegObj.UNIQUEID   = ''
                  Else
                     loRegObj.UNIQUEID   = Alltrim(loRegObj.UNIQUEID)
                  Endif

                  .get_ADD_OBJECT_METHODS( @loRegObj, @loRegClass, @lcMethods, @laMethods, @laCode, @lnMethodCount ;
                     , @laPropsAndComments, lnPropsAndComments_Count, @laProtected, lnProtected_Count, @toFoxBin2Prg )
               Endscan

               lnStep          = lnStep + 1
               .updateProgressbar( 'Processing Form ' + lcObjName + ' > Writing Objects Methods...', lnStep, lnClassTotal*lnStepCount, 1 )

               .write_ALL_OBJECT_METHODS( @lcMethods, @laMethods, @laCode, @lnMethodCount, @laPropsAndComments, lnPropsAndComments_Count, @laProtected ;
                  , lnProtected_Count, @toFoxBin2Prg, @lcCodigo, loRegClass.Baseclass )

               Goto Record (lnRecno)
               .write_ENDDEFINE_IfApplicable( lnLastClass, @lcCodigo )
               laClasses(lnClassCount,2)   = lcCodigo
            Endscan

            If toFoxBin2Prg.getCfgValue('n_UseFormPerFile') > 0 Then
               lcExternalHeader    = lcExternalHeader + CR_LF
            Endif

            Do Case
            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_I1'
               Error 'InputFile Error Simulation'

            Case toFoxBin2Prg.c_SimulateError = 'SIMERR_I0'
               .writeErrorLog( '*** SIMULATED ERROR' )

            Endcase

            If .l_Error
               .writeLog( '*** ERRORS found - Generation Cancelled' )
               Exit
            Endif

            toFoxBin2Prg.updateProcessedFile()


            *-- Genero el SC2
            lnStep          = lnStep + 1
            lcOutputFile    = .c_OutputFile

            .updateProgressbar( 'Writing ' + toFoxBin2Prg.getCfgValue('c_SC2') + '...', lnStep, lnClassTotal*lnStepCount, 1 )
            lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + lcExternalHeader + C_FB2PRG_CODE

            If .l_Test
               *FOR I = 1 TO lnClassCount
               *   lcCodigo    = lcCodigo + laClasses(m.I,2)
               *ENDFOR
               *toModulo   = lcCodigo
            Else
               lcSc2Ext            = toFoxBin2Prg.getCfgValue('c_SC2')
               llUseFormPerDir    = toFoxBin2Prg.getCfgFlag('l_UseFormPerDir')
               lnUseFormPerFile    = toFoxBin2Prg.getCfgInt('n_UseFormPerFile')

               *-- En árbol espejo, ensurePerFileDir se aplica en destino dentro de write_OutputFile/get_MirroredOutputFile
               If lnUseFormPerFile > 0 And Empty(.cOutputFolder) Then
                  toFoxBin2Prg.ensurePerFileDir( .c_InputFile, lcSc2Ext, llUseFormPerDir, lnUseFormPerFile )
               Endif

               Do Case
               Case toFoxBin2Prg.getCfgValue('n_UseFormPerFile') = 1  && LibName.ClassName.SC2
                  lcOutputFile    = toFoxBin2Prg.getPerFileOutputPath( .c_InputFile, '', lcSc2Ext, llUseFormPerDir, lnUseFormPerFile )
                  .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )

                  For I = 1 To lnClassCount
                     lcOutputFile    = toFoxBin2Prg.getPerFileOutputPath( .c_InputFile, laClasses(m.I,1), lcSc2Ext, llUseFormPerDir, lnUseFormPerFile )
                     lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + laClasses(m.I,2)
                     .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                  Endfor

               Case toFoxBin2Prg.getCfgValue('n_UseFormPerFile') = 2  && LibName.BaseClass.ClassName.SC2
                  lcOutputFile    = toFoxBin2Prg.getPerFileOutputPath( .c_InputFile, '', lcSc2Ext, llUseFormPerDir, lnUseFormPerFile )
                  .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )

                  For I = 1 To lnClassCount
                     lcOutputFile    = toFoxBin2Prg.getPerFileOutputPath( .c_InputFile, laClasses(m.I,3) + '.' + laClasses(m.I,1), lcSc2Ext, llUseFormPerDir, lnUseFormPerFile )
                     lcCodigo        = toFoxBin2Prg.get_PROGRAM_HEADER() + laClasses(m.I,2)
                     .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
                  Endfor

               Otherwise
                  For I = 1 To lnClassCount
                     lcCodigo    = lcCodigo + laClasses(m.I,2)
                  Endfor

                  .write_OutputFile( @lcCodigo, lcOutputFile, @toFoxBin2Prg )
               Endcase
            Endif
         Endwith && THIS


      Catch To toEx
         This.set_UserValue(@toEx)

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Use In (Select("TABLABIN"))
         Use In (Select("_TABLAORIG"))
         Store .Null. To loRegClass, loRegObj
         Release toModulo, toEx, toFoxBin2Prg ;
            , lnCodError, loRegClass, loRegObj, lnMethodCount, laMethods, laCode, laProtected, lnLen, lnObjCount ;
            , laPropsAndValues, laPropsAndComments, lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle ;
            , laObjs, I, lnPropsAndValues_Count, lnPropsAndComments_Count, lnProtected_Count ;
            , lcCodigo, laClasses, lnClassCount, lcOutputFile, laDataEnvNames, lnDataEnvCount

      Endtry

      Return
   Endproc


   Function isDataEnvCursor
      *---------------------------------------------------------------------------------------------------
      * True when the object is a cursor whose immediate parent is a DataEnvironment.
      *---------------------------------------------------------------------------------------------------
      Lparameters toRegObj, taDataEnvNames, tnDataEnvCount
      Local lcParent, lcImmediateParent

      If Lower( Alltrim( toRegObj.BaseClass ) ) # 'cursor' Or tnDataEnvCount < 1
         Return .F.
      Endif

      lcParent = Lower( Alltrim( toRegObj.Parent ) )
      If Empty( lcParent )
         Return .F.
      Endif

      If '.' $ lcParent
         lcImmediateParent = Lower( Getwordnum( lcParent, Getwordcount( lcParent, '.' ), '.' ) )
      Else
         lcImmediateParent = lcParent
      Endif

      Return Ascan( taDataEnvNames, lcImmediateParent, 1, 0, 0, 1+2 ) > 0
   Endfunc


   Function stripDataEnvCursorProperties
      *---------------------------------------------------------------------------------------------------
      * Removes directory paths from Database and CursorSource lines in PROPERTIES (CR+LF separated).
      *---------------------------------------------------------------------------------------------------
      Lparameters tcProperties
      Local laLines(1), lnLines, lnI, lcLine, lnEqPos, lcProp, lcValue, lcNewValue, lcResult

      If Empty( tcProperties )
         Return tcProperties
      Endif

      lnLines = Alines( laLines, tcProperties, 0, CR_LF )
      lcResult = ''

      For lnI = 1 To lnLines
         lcLine = laLines(lnI)

         If Empty( lcLine ) Or C_MPROPHEADER $ lcLine
            lcResult = lcResult + Iif( Empty( lcResult ), '', CR_LF ) + lcLine
            Loop
         Endif

         lnEqPos = At( '=', lcLine )
         If lnEqPos < 2
            lcResult = lcResult + Iif( Empty( lcResult ), '', CR_LF ) + lcLine
            Loop
         Endif

         lcProp = Lower( Alltrim( Left( lcLine, lnEqPos - 1 ) ) )
         lcValue = Substr( lcLine, lnEqPos + 1 )

         Do Case
         Case lcProp == 'database'
            lcNewValue = This.normalizeCursorPathPropertyValue( lcValue )
            lcLine = Alltrim( Left( lcLine, lnEqPos - 1 ) ) + ' = ' + lcNewValue

         Case lcProp == 'cursorsource'
            If This.propertyValueHasPath( lcValue )
               lcNewValue = This.normalizeCursorPathPropertyValue( lcValue )
               lcLine = Alltrim( Left( lcLine, lnEqPos - 1 ) ) + ' = ' + lcNewValue
            Endif
         Endcase

         lcResult = lcResult + Iif( Empty( lcResult ), '', CR_LF ) + lcLine
      Endfor

      Return lcResult
   Endfunc


   Function propertyValueHasPath
      Lparameters tcValue
      Local lcVal

      lcVal = Alltrim( tcValue )
      If Left( lcVal, 1 ) == '"' And Right( lcVal, 1 ) == '"'
         lcVal = Substr( lcVal, 2, Len( lcVal ) - 2 )
      Endif

      Return ( '\' $ lcVal Or '/' $ lcVal Or ( Len( lcVal ) > 1 And Substr( lcVal, 2, 1 ) == ':' ) )
   Endfunc


   Function normalizeCursorPathPropertyValue
      Lparameters tcValue
      Local lcVal, lcOrig, llQuoted

      lcOrig = tcValue
      lcVal = Alltrim( tcValue )
      llQuoted = ( Left( lcVal, 1 ) == '"' And Right( lcVal, 1 ) == '"' )
      If llQuoted
         lcVal = Substr( lcVal, 2, Len( lcVal ) - 2 )
      Endif

      If This.propertyValueHasPath( lcVal )
         Return JustFname( lcVal )
      Endif

      Return lcOrig
   Endfunc

Enddefine
