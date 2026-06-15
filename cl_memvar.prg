#INCLUDE foxbin2prg.h

Define Class CL_MEMVAR As CL_COL_BASE Of 'cl_col_base.prg'
   *   .MEM FILE STRUCTURE (Based on observation and testing) - Fernando D. Bozzo. 2018/03/24
   *   Complementary documentation: https://www.clicketyclick.dk/databases/xbase/format/mem.html#MEM_STRUCT


   *   STRUCTURE OF VARIABLES
   *   Byte Offset Description
   *   ----------- -------------------------------------------------------------------------------------------------
   *   0 - 10      .Null. terminated VarName. If VarName is empty, then VarName starts at offset 32
   *   11          VarType (A,C,N,Y,B,F,I,Q,D,T,L,0). If VarType is lowercase, then next VarName
   *               begins with 2 bytes for VarName length.
   *   12 - 15     Reserved
   *   16          Value length
   *   17          Decimal count
   *   18 - 24     Reserved
   *   25          0x00 if it is an array element, 0x03 if it isn't an array element
   *   26 - 31     Reserved
   *   32 - n      If VarName (offset 0-10) is .Null. then goto TABLE 1, If VarType=A then continue in TABLE 2,
   *               if VarType=0 then continue in TABLE 3, else continue in TABLE 4
   *   ...
   *   eof         Last character is EOF (0x1A) character
   *   ----------- -------------------------------------------------------------------------------------------------


   *   TABLE 1 - ARRAY STRUCTURE (VarType=A)
   *   Byte Offset Description
   *   ----------- -------------------------------------------------------------------------------------------------
   *   32 - 33     VarName length
   *   34 - n      VarName
   *   n  + 1      Next TABLE: If VarType=A then continue in TABLE 2, if VarType=0 then continue in TABLE 3,
   *               else continue in TABLE 4
   *   ----------- -------------------------------------------------------------------------------------------------


   *   TABLE 2 - ARRAY STRUCTURE (VarType=A)
   *   Byte Offset Description
   *   ----------- -------------------------------------------------------------------------------------------------
   *   n   - n+1   Array rows
   *   n+2 - n+3   Array cols
   *   n+4 - x     Next Variable structure, or EOF (0x1A)
   *   ----------- -------------------------------------------------------------------------------------------------


   *   TABLE 3 - .Null. VALUE STRUCTURE (VarType=0)
   *   Byte Offset Description
   *   ----------- -------------------------------------------------------------------------------------------------
   *   n           VarType.
   *   n+1 - x     Next Variable structure, or EOF (0x1A)
   *   ----------- -------------------------------------------------------------------------------------------------


   *   TABLE 4 - NORMAL VALUE STRUCTURE
   *   Byte Offset Description
   *   ----------- -------------------------------------------------------------------------------------------------
   *   n - x       Value of length "value length". If ValTye is a Char type then Value length is the value's width,
   *               else the width is 8 for numbers and dates
   *   x           Next Variable structure, or EOF (0x1A)
   *   ----------- -------------------------------------------------------------------------------------------------

   #If .F.
      Local This As CL_MEMVAR Of 'cl_memvar.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="c_inputfile" display="c_InputFile"/>] ;
      + [<memberdata name="_debug" display="_Debug"/>] ;
      + [<memberdata name="get_datafrommem" display="get_DataFromMEM"/>] ;
      + [<memberdata name="_memvars" display="_MemVars"/>] ;
      + [</VFPData>]


   c_InputFile         = ''
   _Debug              = .F.
   _MemVars            = .Null.        && Colección de variables de memoria



   Procedure Init
      DoDefault()
      This._MemVars = Createobject("COLLECTION")
   Endproc


   Procedure get_DataFromMEM(tcInputFile As String, toFoxBin2Prg)
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcInputFile               (!v IN    ) Archivo de entrada
      * toFoxBin2Prg              (!@ IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Local lnHandle, lnFileLen, lcMsg, lcStr, lnNumberOfMacros ;
         , loMVRec As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg' ;
         , loColl As Collection ;
         , loEx As Exception

      Try
         lnHandle    = -1

         With This As CL_MEMVAR Of 'cl_memvar.prg'
            loColl      = ._MemVars
            lnHandle    = Fopen(tcInputFile, 0)

            If lnHandle = -1
               lcMsg   = toFoxBin2Prg.FERROR_Message(tcInputFile)
               Error (lcMsg)
            Endif

            lnFileLen   = Fseek(lnHandle, 0, 2)

            If lnFileLen < 1
               Error 'Invalid MEM File size'
            Else
               =Fseek(lnHandle, 0, 0)
            Endif

            *IF lnFileLen < 17 + 25 * lnNumberOfMacros
            *   * 25 caracteres es el tamaño mínimo de una macro sin teclas guardadas (solo la estructura)
            *   ERROR 'Invalid FKY Macro File size'
            *ENDIF

            If lnFileLen > 1
               Do While Not Feof(lnHandle) And Fseek(lnHandle, 0, 1) < (lnFileLen - 1)
                  loMVRec = NewObject('CL_MEMVAR_RECORD', 'cl_memvar_record.prg')

                  If Not loMVRec.ReadNextMemVar(lnHandle)
                     Exit
                  Endif

                  loColl.Add( loMVRec, loMVRec.getName() + Padl(pnElement, 5, '0') )
                  loMVRec = .Null.
               Enddo

               * Ordenar alfabéticamente por nombre de variable
               loColl.KeySort = 2
            Endif

         Endwith

      Catch To loEx
         *loEx.UserValue = loEx.UserValue + 'lcAsignacion = [' + TRANSFORM(lcAsignacion) + ']' + CR_LF

         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         If lnHandle <> -1
            =Fclose(lnHandle)
         Endif
      Endtry

      Return
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      *---------------------------------------------------------------------------------------------------
      Local lcText, loMVRec As CL_MEMVAR_RECORD Of 'cl_memvar_record.prg'
      lcText  = ''

      With This As CL_MEMVAR Of 'cl_memvar.prg'

         *-- Macros
         For Each loMVRec In ._MemVars &&FOXOBJECT
            lcText  = lcText + CR_LF + loMVRec.toText()
         Endfor

      Endwith

      Return lcText
   Endproc


Enddefine
