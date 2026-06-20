#INCLUDE foxbin2prg.h

Define Class c_conversor_frx_a_prg As c_conversor_bin_a_prg Of 'c_conversor_bin_a_prg.prg'
   #If .F.
      Local This As c_conversor_frx_a_prg Of 'c_conversor_frx_a_prg.prg'
   #Endif

   c_Type = 'FRX'
   l_Fox2x = .F.


   Procedure convert
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * toModulo                  (!@    OUT) Objeto generado de clase CL_PROJECT con la información leida del texto
      * toEx                      (!@    OUT) Objeto con información del error
      * toFoxBin2Prg              (v! IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      Lparameters toModulo, toEx As Exception, toFoxBin2Prg
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      DoDefault( @toModulo, @toEx, @toFoxBin2Prg )

      Try
         With This As c_conversor_frx_a_prg Of 'c_conversor_frx_a_prg.prg'
            If toFoxBin2Prg.l_ProcessFiles Then
               Local lnCodError, loRegCab, loRegDataEnv, loRegCur, loRegObj, lnMethodCount, laMethods(1), laCode(1), laProtected(1), lnLen ;
                  , laPropsAndValues(1), laPropsAndComments(1), lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle(1) ;
                  , loLang As CL_LANG Of 'cl_lang.prg'

               loLang          = _Screen.o_FoxBin2Prg_Lang
               Store 0 To lnCodError, lnLastClass
               Store '' To laMethods(1), laCode(1), laProtected(1), laPropsAndComments(1)
               Store .Null. To loRegObj, loRegCab, loRegDataEnv, loRegCur

               Use (.c_InputFile) Shared Again Noupdate Alias _TABLAORIG

               *  keep CodePage relavant information for binary sources
               toFoxBin2Prg.i_CPID = Cpdbf("_TABLAORIG")

               If This.l_Fox2x
                  If Fcount() <> 74 Or Not Empty(Field("USER"))
                     Error (Textmerge(loLang.C_REPORT_NOT_IN_VFP9_FORMAT_LOC))
                  Endif
                  Set NoCPTrans To Name,Expr,Style,Picture,Order,Comment,Tag,TAG2,FONTFACE,SUPEXPR
               Else
                  If Fcount() < 75 Or Empty(Field("USER"))
                     Error (Textmerge(loLang.C_REPORT_NOT_IN_VFP9_FORMAT_LOC))
                  Endif
                  Set NoCPTrans To Name,Expr,Style,Picture,Order,Comment,Tag,TAG2,FONTFACE,SUPEXPR,User
               Endif

               This.updateProgressbar( 'Scanning ' + Upper(Justext(.c_InputFile)) + '...', 1, 2, 1 )

               C_FB2PRG_CODE = C_FB2PRG_CODE + toFoxBin2Prg.get_PROGRAM_HEADER()


               *-- Arreglo bug agrupación de controles. 29/10/2015
               SELECT * ;
               FROM   _TABLAORIG ;
               WHERE  ObjType In (1,25,26) ;
               INTO   Cursor TABLABIN_0 Readwrite

               *-- Header
               Select TABLABIN_0
               Locate For ObjType = 1

               If Found()
                  loRegCab    = .Null.
                  Scatter Memo Name loRegCab

                  If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
                     loRegCab.Timestamp  = 0
                  Endif
                  If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
                     loRegCab.UNIQUEID   = ''
                  Endif
               Endif

               If .l_ReportSort_Enabled
                  *-- ORDENADO
                  SELECT * ;
                  FROM   _TABLAORIG ;
                  WHERE  ObjType Not In (1,25,26) ;
                  ORDER  By vpos,hpos Asc ;
                  INTO   Cursor TABLABIN Readwrite
               Else
                  *-- SIN ORDENAR (Sólo para poder comparar con el original)
                  SELECT * ;
                  FROM   _TABLAORIG ;
                  WHERE  ObjType Not In (1,25,26) ;
                  INTO   Cursor TABLABIN
               Endif

               loRegObj = .Null.

               *-- Recorro los registros y genero el texto
               If Vartype(loRegCab) = "O"
                  .write_TXT_REPORTE( @loRegCab )
               Endif

               Select TABLABIN

               Scan All
                  loRegObj    = .Null.
                  Scatter Memo Name loRegObj

                  If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
                     loRegObj.Timestamp  = 0
                  Endif
                  If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
                     loRegObj.UNIQUEID   = ''
                  Endif

                  .write_TXT_REPORTE( @loRegObj )
               Endscan

               *-- Dataenvironment
               Select TABLABIN_0
               Locate For ObjType = 25

               If Found()
                  loRegDataEnv    = .Null.
                  Scatter Memo Name loRegDataEnv

                  If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
                     loRegDataEnv.Timestamp  = 0
                  Endif
                  If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
                     loRegDataEnv.UNIQUEID   = ''
                  Endif

                  .write_TXT_REPORTE( @loRegDataEnv )
               Endif

               *-- Cursors and Relations
               Select TABLABIN_0

               Scan All For ObjType = 26
                  loRegCur    = .Null.
                  Scatter Memo Name loRegCur

                  If toFoxBin2Prg.getCfgValue('l_NoTimestamps')
                     loRegCur.Timestamp  = 0
                  Endif
                  If toFoxBin2Prg.getCfgValue('l_ClearUniqueID')
                     loRegCur.UNIQUEID   = ''
                  Endif

                  .write_TXT_REPORTE( @loRegCur )
               Endscan
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


            *-- Genero el FR2 / FR2D / LB2 / LB2D
            .updateProgressbar( 'Writing ' + Upper(Justext(.c_OutputFile)) + '...', 2, 2, 1 )

            If .l_Test
               toModulo    = C_FB2PRG_CODE
            Else
               .write_OutputFile( (C_FB2PRG_CODE), .c_OutputFile, @toFoxBin2Prg )
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
         Use In (Select("TABLABIN_0"))
         Use In (Select("_TABLAORIG"))
         Store .Null. To loRegObj, loRegCab, loRegDataEnv, loRegCur
         Release toModulo, toEx, toFoxBin2Prg ;
            , lnCodError, loRegCab, loRegDataEnv, loRegCur, loRegObj, lnMethodCount, laMethods, laCode, laProtected, lnLen ;
            , laPropsAndValues, laPropsAndComments, lnLastClass, lnRecno, lcMethods, lcObjName, la_NombresObjsOle

      Endtry

      Return
   Endproc


   Procedure write_TXT_REPORTE
      Lparameters toReg

      Try
         Local lc_TAG_REPORTE_I, lc_TAG_REPORTE_F, loEx As Exception
         lc_TAG_REPORTE_I = '<'  + C_TAG_REPORTE
         lc_TAG_REPORTE_F = '</' + C_TAG_REPORTE + '>'

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
            <<lc_TAG_REPORTE_I>>
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
            <<Chr(9)>>platform="<<toReg.Platform>>" uniqueid="<<toReg.UniqueID>>" timestamp="<<toReg.TimeStamp>>" objtype="<<toReg.ObjType>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> objcode="<<toReg.ObjCode>>" name="<<THIS.normalizeXMLValue(toReg.Name)>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> vpos="<<toReg.vpos>>" hpos="<<toReg.hpos>>" height="<<toReg.height>>" width="<<toReg.width>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> order="<<toReg.order>>" unique="<<toReg.unique>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> environ="<<toReg.environ>>" boxchar="<<toReg.boxchar>>" fillchar="<<toReg.fillchar>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> pengreen="<<toReg.pengreen>>" penblue="<<toReg.penblue>>" fillred="<<toReg.fillred>>" fillgreen="<<toReg.fillgreen>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> fillblue="<<toReg.fillblue>>" pensize="<<toReg.pensize>>" penpat="<<toReg.penpat>>" fillpat="<<toReg.fillpat>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> fontface="<<toReg.fontface>>" fontstyle="<<toReg.fontstyle>>" fontsize="<<toReg.fontsize>>" mode="<<toReg.mode>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> ruler="<<toReg.ruler>>" rulerlines="<<toReg.rulerlines>>" grid="<<toReg.grid>>" gridv="<<toReg.gridv>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> gridh="<<toReg.gridh>>" float="<<toReg.float>>" stretch="<<toReg.stretch>>" stretchtop="<<toReg.stretchtop>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> top="<<toReg.top>>" bottom="<<toReg.bottom>>" suptype="<<toReg.suptype>>" suprest="<<toReg.suprest>>" norepeat="<<toReg.norepeat>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> resetrpt="<<toReg.resetrpt>>" pagebreak="<<toReg.pagebreak>>" colbreak="<<toReg.colbreak>>" resetpage="<<toReg.resetpage>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> general="<<toReg.general>>" spacing="<<toReg.spacing>>" double="<<toReg.double>>" swapheader="<<toReg.swapheader>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> swapfooter="<<toReg.swapfooter>>" ejectbefor="<<toReg.ejectbefor>>" ejectafter="<<toReg.ejectafter>>" plain="<<toReg.plain>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> summary="<<toReg.summary>>" addalias="<<toReg.addalias>>" offset="<<toReg.offset>>" topmargin="<<toReg.topmargin>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> botmargin="<<toReg.botmargin>>" totaltype="<<toReg.totaltype>>" resettotal="<<toReg.resettotal>>" resoid="<<toReg.resoid>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>>  curpos="<<toReg.curpos>>" supalways="<<toReg.supalways>>" supovflow="<<toReg.supovflow>>" suprpcol="<<toReg.suprpcol>>"
         ENDTEXT

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
            <<>> supgroup="<<toReg.supgroup>>" supvalchng="<<toReg.supvalchng>>"
         ENDTEXT

         C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<picture><![CDATA[" + toReg.Picture + "]]>"

         If Inlist(toReg.ObjType, 25, 26) && Dataenvironment, cursors and relations
            C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<tag><![CDATA[" + Iif( Empty( Chrtran( toReg.Tag, CR_LF+C_TAB, '') ), '', CR_LF + toReg.Tag) + "]]>"
            C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<tag2><![CDATA[]]>"
         Else
            C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<tag><![CDATA[" + This.encode_SpecialCodes_1_31( toReg.Tag ) + "]]>"
            C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<tag2><![CDATA[" + Iif( Inlist(toReg.ObjType,5,6,8), toReg.TAG2, Strconv( toReg.TAG2,13 ) ) + "]]>"
         Endif

         C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<penred><![CDATA[" + Transform(toReg.penred) + "]]>"
         C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<style><![CDATA[" + toReg.Style + "]]>"

         If Inlist(toReg.ObjType, 25, 26) && Dataenvironment, cursors and relations
            C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<expr><![CDATA[" + Chrtran( toReg.Expr, C_NULL_CHAR, '' ) + "]]>"
         Else
            C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<expr><![CDATA[" + toReg.Expr + "]]>"
         Endif

         C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<supexpr><![CDATA[" + toReg.supexpr + "]]>"
         C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<comment><![CDATA[" + toReg.Comment + "]]>"

         If Not This.l_Fox2x
            C_FB2PRG_CODE = C_FB2PRG_CODE + CR_LF + Chr(9) + "<user><![CDATA[" + toReg.User + "]]>"
         Endif

         TEXT TO C_FB2PRG_CODE ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<lc_TAG_REPORTE_F>>
         ENDTEXT

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return
   Endproc

Enddefine
