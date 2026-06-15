#INCLUDE foxbin2prg.h

Define Class CL_DBF_INDEX As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_DBF_INDEX Of 'cl_dbf_index.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_indexfile" display="_IndexFile"/>] ;
      + [<memberdata name="_standalone" display="_StandAlone"/>] ;
      + [<memberdata name="_tagname" display="_TagName"/>] ;
      + [<memberdata name="_tagname" display="_TagName"/>] ;
      + [<memberdata name="_tagtype" display="_TagType"/>] ;
      + [<memberdata name="_key" display="_Key"/>] ;
      + [<memberdata name="_filter" display="_Filter"/>] ;
      + [<memberdata name="_order" display="_Order"/>] ;
      + [<memberdata name="_collate" display="_Collate"/>] ;
      + [</VFPData>]


   *-- Index Info
   _IndexFile      = ''
   _StandAlone     = .F.
   _TagName        = ''
   _TagType        = ''
   _Key            = ''
   _Filter         = ''
   _Order          = ''
   _Collate        = ''


   Procedure analyzeCodeBlock
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Contenido de la línea en análisis
      * taCodeLines               (!@ IN    ) Array de líneas del programa analizado
      * I                         (!@ IN/OUT) Número de línea en análisis
      * tnCodeLines               (!@ IN    ) Cantidad de líneas del programa analizado
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine, taCodeLines, I, tnCodeLines, tcIndexFile, tlStandAlone
      External Array taCodeLines

      Try
         Local llBloqueEncontrado, lcPropName, lcValue, loEx As Exception
         Store '' To lcPropName, lcValue

         If Left(tcLine, Len(C_INDEX_I)) == C_INDEX_I
            llBloqueEncontrado  = .T.

            With This As CL_DBF_INDEX Of 'cl_dbf_index.prg'
               ._IndexFile      = Evl( m.tcIndexFile, '')
               ._StandAlone     = m.tlStandAlone

               For I = m.I + 1 To tnCodeLines
                  .set_Line( @tcLine, @taCodeLines, m.I )

                  Do Case
                  Case Empty( tcLine )
                     Loop

                  Case C_INDEX_F $ tcLine && Fin
                     Exit

                  Otherwise   && Propiedad de INDEX
                     *-- Estructura a reconocer:
                     *   <name>NOMBRE</name>
                     lcPropName  = Strextract( tcLine, '<', '>', 1, 0 )
                     lcValue     = Strextract( tcLine, '<' + lcPropName + '>', '</' + lcPropName + '>', 1, 0 )
                     .AddProperty( '_' + lcPropName, lcValue )
                  Endcase
               Endfor
            Endwith && THIS
         Endif

      Catch To loEx
         If loEx.ErrorNo = 1470  && Incorrect property name.
            loEx.UserValue  = 'I=' + Transform(m.I) + ', tcLine=' + Transform(tcLine) + ', PropName=[' + Transform(lcPropName) + '], Value=[' + Transform(lcValue) + ']'
         Endif

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
      * taTagInfo                 (@! IN    ) Array de información de indices
      * I                         (@! IN    ) Indice en evaluación
      *---------------------------------------------------------------------------------------------------
      Lparameters taTagInfo, I

      External Array taTagInfo

      Try
         Local X, lcText, loEx As Exception
         lcText  = ''

         For m.X = 1 To Alen(taTagInfo,1)
            If Tag(m.X) == taTagInfo(m.I,1) Then
               Exit
            Endif
         Endfor

         TEXT TO lcText TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                <<chr(9)+chr(9)+chr(9)+chr(9)>><<C_INDEX_I>>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><TagName><<taTagInfo(m.I,1)>></TagName>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><TagType><<ICASE(LEFT(taTagInfo(m.I,2),3)='BIN','BINARY',PRIMARY(m.X),'PRIMARY',CANDIDATE(m.X),'CANDIDATE',UNIQUE(m.X),'UNIQUE','REGULAR'))>></TagType>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Key><<taTagInfo(m.I,3)>></Key>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Filter><<taTagInfo(m.I,4)>></Filter>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Order><<IIF(DESCENDING(m.X), 'DESCENDING', 'ASCENDING')>></Order>
                <<chr(9)+chr(9)+chr(9)+chr(9)+chr(9)>><Collate><<taTagInfo(m.I,6)>></Collate>
                <<chr(9)+chr(9)+chr(9)+chr(9)>><<C_INDEX_F>>
         ENDTEXT

      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Endtry

      Return lcText
   Endproc


Enddefine
