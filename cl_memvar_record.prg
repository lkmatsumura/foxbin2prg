#INCLUDE foxbin2prg.h

Define Class CL_MEMVAR_RECORD As CL_CUS_BASE Of 'cl_cus_base.prg'
   _MemberData = [<VFPData>] ;
      + [<memberdata name="memvar_name" display="MemVar_Name"/>] ;
      + [<memberdata name="memvar_namelength" display="MemVar_NameLength"/>] ;
      + [<memberdata name="memvar_type" display="MemVar_Type"/>] ;
      + [<memberdata name="memvar_rows" display="MemVar_Rows"/>] ;
      + [<memberdata name="memvar_cols" display="MemVar_Cols"/>] ;
      + [<memberdata name="memvar_length" display="MemVar_Length"/>] ;
      + [<memberdata name="memvar_dec" display="MemVar_Dec"/>] ;
      + [<memberdata name="memvar_value" display="MemVar_Value"/>] ;
      + [<memberdata name="memvar_elemtype" display="MemVar_ElemType"/>] ;
      + [<memberdata name="readnextmemvar" display="ReadNextMemVar"/>] ;
      + [<memberdata name="totext" display="toText"/>] ;
      + [<memberdata name="get_memvardata" display="get_MemVarData"/>] ;
      + [<memberdata name="getrows" display="getRows"/>] ;
      + [<memberdata name="getcols" display="getCols"/>] ;
      + [<memberdata name="getlength" display="getLength"/>] ;
      + [<memberdata name="getdec" display="getDec"/>] ;
      + [<memberdata name="getvalue" display="getValue"/>] ;
      + [<memberdata name="getname" display="getName"/>] ;
      + [<memberdata name="juliantodatetime" display="julianToDateTime"/>] ;
      + [<memberdata name="isarrayelement" display="isArrayElement"/>] ;
      + [</VFPData>]

   *--
   MemVar_Name                 = ''
   MemVar_NameLength           = ''
   MemVar_Type                 = ''
   MemVar_Rows                 = ''
   MemVar_Cols                 = ''
   MemVar_Length               = ''
   MemVar_Dec                  = ''
   MemVar_Value                = ''
   MemVar_ElemType             = ''


   Procedure ReadNextMemVar(tnHandle As Integer)
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tnHandle                  (!v IN    ) FKY file handle
      *---------------------------------------------------------------------------------------------------
      Local lnVarLength, lnVarDec, lnVarNameLength, lcVarNameLength, llVarTypeIsChar

      Try
         With This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
            .MemVar_Name        = Fread(tnHandle, 11)
            .MemVar_Type        = Fread(tnHandle, 1)
            =Fseek(tnHandle, 4, 1)  && Skip 4 bytes
            .MemVar_Length      = Fread(tnHandle, 1)
            .MemVar_Dec         = Fread(tnHandle, 1)

            Do Case
            Case Inlist( Upper(.MemVar_Type), 'C', 'Q', 'L')
               llVarTypeIsChar     = .T.
               lnVarLength         = .getLength()

            Case Upper(.MemVar_Type) = 'A'
               * Array

            Otherwise && Numeric
               lnVarLength         = 8
               lnVarDec            = .getDec()

            Endcase

            =Fseek(tnHandle, 7, 1)  && Skip 7 bytes
            .MemVar_ElemType    = Fread(tnHandle, 1)    && 0x00 if it is an array element, else 0x03
            =Fseek(tnHandle, 6, 1)  && Skip 6 bytes

            If .isArrayElement()
               * Mantiene el contador de elemento
               pnElement   = pnElement + 1
            Else
               * Reinicia el conteo de filas, columnas y elemento actual
               Store 0 To pnCols, pnRows, pnElement
            Endif

            If Empty( Rtrim(.MemVar_Name, 0, Chr(0)) )
               * Long VarName
               lcVarNameLength = Fread(tnHandle, 2)
               lnVarNameLength = CToBin(lcVarNameLength, '2RS')
               .MemVar_Name    = Fread(tnHandle, lnVarNameLength)
            Endif

            Do Case
            Case Inlist(.MemVar_Type, 'A', 'a')
               * ARRAY
               * Rows/Cols
               .MemVar_Rows        = Fread(tnHandle, 2)
               .MemVar_Cols        = Fread(tnHandle, 2)
               pnCols              = .getCols()
               pnRows              = .getRows()

            Case .MemVar_Type = '0'
               * .Null.
               * VarType
               .MemVar_Type    = Fread(tnHandle, 1)
               .MemVar_Value   = .Null.

            Otherwise
               * NORMAL VALUE
               * Value
               .MemVar_Value   = Fread(tnHandle, lnVarLength)

            Endcase
         Endwith
      Endtry

      Return
   Endproc


   Function isArrayElement
      #If .F.
         Local This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
      #Endif
      Return Asc(This.MemVar_ElemType) = 0
   Endfunc


   Function getRows
      #If .F.
         Local This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
      #Endif
      Return CToBin(This.MemVar_Rows, '2RS')
   Endfunc


   Function getCols
      #If .F.
         Local This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
      #Endif
      Return CToBin(This.MemVar_Cols, '2RS')
   Endfunc


   Function getLength
      #If .F.
         Local This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
      #Endif
      Return Asc(This.MemVar_Length)
   Endfunc


   Function getDec
      #If .F.
         Local This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
      #Endif
      Return Asc(This.MemVar_Dec)
   Endfunc


   Function getName
      #If .F.
         Local This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
      #Endif
      Return Rtrim(This.MemVar_Name, 0, Chr(0))
   Endfunc


   Function getValue
      With This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
         Local lxValue

         Do Case
         Case Isnull(.MemVar_Value)
            lxValue = .Null.

         Case Upper(.MemVar_Type) = 'L'
            lxValue = ( Asc(.MemVar_Value) = 1 )

         Case Inlist( Upper(.MemVar_Type), 'C', 'M')
            lxValue = ["] + Rtrim(.MemVar_Value, 0, Chr(0)) + ["]

         Case Inlist( Upper(.MemVar_Type), 'Q')
            lxValue = '0h' + Strconv(.MemVar_Value,15)

         Case Upper(.MemVar_Type) = 'D'
            lxValue = Sys(10, CToBin(.MemVar_Value, '8S'))

         Case Upper(.MemVar_Type) = 'T'
            lxValue =.julianToDateTime( CToBin(.MemVar_Value, '8S') )

         Case Upper(.MemVar_Type) = 'Y'
            lxValue = CToBin(.MemVar_Value, '8YRS')

         Case Upper(.MemVar_Type) = 'B'
            lxValue = CToBin(.MemVar_Value, '8BRS')

         Otherwise && 'N'
            lxValue = CToBin(.MemVar_Value, '8S')

            *IF .getDec() = 0
            *   lxValue = ROUND(lxValue,0)
            *ENDIF

         Endcase
      Endwith

      Return lxValue
   Endfunc


   Function julianToDateTime(tnJulian As Double)
      Local lnInt, lnDec, ltValue, ldDate, lcTime ;
         , lnSecs, lnMins, lnHours

      ltValue = {/:}
      lnInt   = Int(tnJulian)
      lnDec   = tnJulian - lnInt
      ldDate  = Evaluate( '{^' + Sys(10, lnInt) + '}' )
      lnSecs  = 24 * 60 * 60 * lnDec
      lnHours = Int(lnSecs / 3600)
      lnSecs  = lnSecs - lnHours * 3600
      lnMins  = Int(lnSecs / 60)
      lnSecs  = lnSecs - lnMins * 60
      ltValue = Datetime( Year(ldDate), Month(ldDate), Day(ldDate), lnHours, lnMins, lnSecs)

      Return ltValue
   Endfunc


   Procedure toText As String
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      *---------------------------------------------------------------------------------------------------
      Local lcText, lcVarName, lcVarType, lnVarLen, lnVarDec, lcPrecision, lnLenName ;
         , loField As CL_MACRO_RECORD Of 'cl_macro_record.prg'
      lnLenName   = 16
      lcText      = ''
      lcPrecision = ''
      lcVarName   = ''

      With This As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
         lcVarType   = Upper(.MemVar_Type)
         lnVarLen    = .getLength()
         lnVarDec    = .getDec()
         lcVarName   = .getName()

         If Len(lcVarName) < lnLenName
            lcVarName   = Padr(lcVarName, lnLenName)
         Endif

         If lcVarType = 'N'
            If lnVarDec > 0
               lcPrecision = Textmerge( '(<<lnVarLen>>,<<lnVarDec>>)' )
            Else
               lcPrecision = Textmerge( '(<<lnVarLen>>)' )
            Endif
         Endif

         lcPrecision = Padr(lcPrecision, 10)

         If lcVarType = 'A'
            pnCols      = .getCols()
            pnRows      = .getRows()
            pnElement   = 0

            If CToBin(.MemVar_Cols, '2RS') = 0
               * Array Unidimensional
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<lcVarName>>   <<lcVarType>>(<<.getRows()>>)
               ENDTEXT
            Else
               * Array Bidimensional
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<lcVarName>>   <<lcVarType>>(<<.getRows()>>,<<.getCols()>>)
               ENDTEXT
            Endif

         Else

            If .isArrayElement()
               * Elemento de array
               pnElement   = pnElement + 1

               If pnCols = 0
                  * Elemento de Array Unidimensional
                  TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                            <<>>         (<<Str(pnElement,5)>>)   <<lcVarType>><<lcPrecision>>   <<.getValue()>>
                  ENDTEXT

               Else
                  * Elemento de Array Bidimensional
                  TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                            <<>>   (<<Str(CEILING(pnElement/pnCols),5)>>,<<Str(EVL( MOD(pnElement,pnCols), pnCols),5)>>)   <<lcVarType>><<lcPrecision>>   <<.getValue()>>
                  ENDTEXT

               Endif

            Else
               * Variable normal
               TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1 PRETEXT 1+2
                        <<lcVarName>>   <<lcVarType>><<lcPrecision>>   <<.getValue()>>
               ENDTEXT
            Endif

         Endif

      Endwith

      Return lcText
   Endproc


Enddefine
