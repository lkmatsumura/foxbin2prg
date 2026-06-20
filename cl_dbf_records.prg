#INCLUDE foxbin2prg.h

Define Class CL_DBF_RECORDS As CL_COL_BASE Of 'cl_col_base.prg'
   #If .F.
      Local This As CL_DBF_RECORDS Of 'cl_dbf_records.prg'
   #Endif



   Procedure analyzeCodeBlock
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (!=Obligatorio | ?=Opcional) (@=Pasar por referencia | v=Pasar por valor) (IN/OUT)
      * tcLine                    (@! IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (@! IN    ) Array de líneas del programa analizado
      * I                         (@! IN/OUT) Número de línea en análisis
      * tnCodeLines               (@! IN    ) Cantidad de líneas del programa analizado
      * toFields                  (@! IN    ) Estructura de los campos
      * toFoxBin2Prg              (@! IN    ) Referencia de toFoxBin2Prg
      * tl_DBF_BinChar_Base64     out of settings (folder or per-file) Transform NocPTrans fields base64
      * tl_DBF_IncludeDeleted     out of settings (folder or per-file) Include deleted records
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines, toFields, toFoxBin2Prg, tl_DBF_BinChar_Base64, tl_DBF_IncludeDeleted
      External Array taCodeLines

      #If .F.
         Local toFields As CL_DBF_FIELDS Of 'cl_dbf_fields.prg'
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local llBloqueEncontrado, lcPropName, lcValue, lcAlias, loEx As Exception ;
            , loRecord As CL_DBF_RECORD Of 'cl_dbf_record.prg' ;
            , loRecordData As Object
         Store .Null. To loIndex
         Store '' To lcPropName, lcValue, lcAlias

         If Left(tcLine, Len(C_RECORDS_I)) == C_RECORDS_I
            llBloqueEncontrado  = .T.

            With This As CL_DBF_RECORDS Of 'cl_dbf_records.prg'
               lcAlias     = Alias()
               CursorSetProp("Buffering", 3)
               loRecord    = .Null.
               loRecord    = NewObject('CL_DBF_RECORD', 'cl_dbf_record.prg')

               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_RECORDS_F $ tcLine   && Fin
                     Exit

                  Case '<RECORD' $ tcLine
                     Append Blank

                     loRecord.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, @toFields, tl_DBF_BinChar_Base64 )

                     If Mod(m.I,1000) = 0 Then
                        toFoxBin2Prg.updateProgressbar( 'Importing DBF Data... ' + Transform(m.I) + '/' + Transform(tnCodeLines) + '', 1+(m.I/tnCodeLines), 3, 2 )
                        DoEvents
                        *FFLUSH( toFoxBin2Prg.n_FileHandle, .T. )
                     Endif

                     *!* Changed by: LScheffler 21.02.2021
                     *!* change date="{^2021-02-21,10:57:00}"
                     * additional options controlling
                     * - new operations of DBF, handle include of deleted records
                     *!* /Changed by: LScheffler 21.02.2021
                  Case m.tl_DBF_IncludeDeleted And '<DELRECORD' $ tcLine
                     Append Blank
                     loRecord.analyzeCodeBlock( @tcLine, @taCodeLines, @m.I, tnCodeLines, @toFields, tl_DBF_BinChar_Base64 )

                     Delete

                     If Mod(m.I,1000) = 0 Then
                        toFoxBin2Prg.updateProgressbar( 'Importing DBF Data... ' + Transform(m.I) + '/' + Transform(tnCodeLines) + '', 1+(m.I/tnCodeLines), 3, 2 )
                        DoEvents
                        *FFLUSH( toFoxBin2Prg.n_FileHandle, .T. )
                     Endif
                     *!* /Changed by: LScheffler 21.02.2021

                  Otherwise   && Otro valor
                     *-- No hay otros valores
                  Endcase
               Endfor

               Tableupdate(.T.)
            Endwith && THIS
         Endif

      Catch To loEx
         If loEx.ErrorNo = 1470  && Incorrect property name.
            loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine)
         Endif

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Tablerevert(.T.)
         CursorSetProp("Buffering", 1)

         Store .Null. To loRecord
         Release lcPropName, lcValue, loRecord

      Endtry

      Return llBloqueEncontrado
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:                   (!=Obligatorio | ?=Opcional) (@=Pasar por referencia | v=Pasar por valor) (IN/OUT)
      * taFields                      (@! IN    ) Array de información de campos
      * tnField_Count                 (v! IN    ) Cantidad de campos
      * tc_DBF_Conversion_Condition   (v? IN    ) Condición de filtro para la conversión. Solo se exporta lo que la cumpla.
      * toFoxBin2Prg                  (@! IN    ) Referencia de toFoxBin2Prg
      * tl_DBF_BinChar_Base64         out of settings (folder or per-file) Transform NocPTrans fields base64
      * tl_DBF_IncludeDeleted         out of settings (folder or per-file) Include deleted records
      *---------------------------------------------------------------------------------------------------
      Lparameters taFields, tnField_Count, tc_DBF_Conversion_Condition, toFoxBin2Prg, tl_DBF_BinChar_Base64, tl_DBF_IncludeDeleted

      External Array taFields

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Try
         Local lcText, loEx As Exception, I, lnReccount ;
            , loRecord As CL_DBF_RECORD Of 'cl_dbf_record.prg' ;
            , loTextStream As Scripting.TextStream
         Local lcOldDeleted As String

         lcText      = ''
         I           = 0
         lnReccount  = Reccount()    && Realmente no es muy exacto, pero al menos muestra el avance.
         loTextStream    = toFoxBin2Prg.o_TextStream

         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<>>
                <<Chr(9)>><<C_RECORDS_I>>
         ENDTEXT

         *FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
         loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
         lcText  = ''
         loRecord = NewObject('CL_DBF_RECORD', 'cl_dbf_record.prg')

         If Empty(tc_DBF_Conversion_Condition)
            tc_DBF_Conversion_Condition = '.T.'
         Endif

         *!* Changed by: LScheffler 21.02.2021
         *!* change date="{^2021-02-21,10:57:00}"
         * additional options controlling
         * - new operations of DBF, handle include of deleted records
         lcOldDeleted = Set("Deleted")
         If m.tl_DBF_IncludeDeleted Then
            Set Deleted Off
         Endif
         *!* /Changed by: LScheffler 21.02.2021

         *!* Changed by: LScheffler 01.03.2021
         *!* change date="{^2021-03-01,12:45:00}"
         * failure with macro substitution<br/>
         * for wharever reason, macro substitution failed
         * EVALUATE() should do
         *               Scan For &tc_DBF_Conversion_Condition.
         Scan For Evaluate(m.tc_DBF_Conversion_Condition)
            *!* /Changed by: LScheffler 01.03.2021

            I   = m.I + 1

            lcText  = loRecord.toText(@taFields, tnField_Count, tl_DBF_BinChar_Base64 )

            *FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
            loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
            If Mod(m.I,100) = 0 Or Len(lcText) > 8*1024 Then
               toFoxBin2Prg.updateProgressbar( 'Exporting DBF Data... ' + Transform(m.I) + '/' + Transform(lnReccount) + '', 1+(m.I/lnReccount), 3, 2 )
               DoEvents
               *FFLUSH( toFoxBin2Prg.n_FileHandle, .T. )
            Endif
         Endscan
         Set Deleted &lcOldDeleted.

         toFoxBin2Prg.updateProgressbar( 'Data exported! ', 1+(lnReccount/lnReccount), 3, 2 )
         lcText  = ''

         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<Chr(9)>><<C_RECORDS_F>>
                <<>>
         ENDTEXT

         *FWRITE( toFoxBin2Prg.n_FileHandle, lcText )
         loTextStream.WriteLine( lcText )        && Replace VFP low-level file funcs.because the 8-16KB limit.
         lcText  = ''


      Catch To loEx
         loEx.UserValue = loEx.UserValue + 'tc_DBF_Conversion_Condition = [' + Transform(tc_DBF_Conversion_Condition) + ']' + CR_LF
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Store .Null. To loRecord, loTextStream
         Release loRecord, loTextStream

      Endtry

      Return lcText
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
