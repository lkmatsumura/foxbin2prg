#INCLUDE foxbin2prg.h

Define Class CL_MACRO As CL_COL_BASE Of 'cl_col_base.prg'
   #If .F.
      Local This As CL_MACRO Of 'cl_macro.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="c_inputfile" display="c_InputFile"/>] ;
      + [<memberdata name="_numberofmacros" display="_NumberOfMacros"/>] ;
      + [<memberdata name="_debug" display="_Debug"/>] ;
      + [<memberdata name="_signature" display="_Signature"/>] ;
      + [<memberdata name="get_datafrommacrofky" display="get_DataFromMacroFKY"/>] ;
      + [<memberdata name="_macros" display="_Macros"/>] ;
      + [</VFPData>]


   c_InputFile         = ''

   *-- Macro Header
   _Signature          = ''
   _Debug              = .F.
   _NumberOfMacros     = ''
   _Macros             = .Null.        && Colección de macros



   Procedure Init
      DoDefault()
      This._Macros = Createobject("COLLECTION")
   Endproc


   Procedure get_DataFromMacroFKY(tcInputFile As String, toFoxBin2Prg)
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcInputFile               (!v IN    ) Archivo de entrada
      * toFoxBin2Prg              (!@ IN    ) Referencia al objeto principal
      *---------------------------------------------------------------------------------------------------
      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Local lnHandle, lnFileLen, lcMsg, lcStr, lnNumberOfMacros ;
         , loMRec As CL_MACRO_RECORD Of 'cl_macro_record.prg' ;
         , loColl As Collection ;
         , loEx As Exception

      Try
         lnHandle    = -1

         With This As CL_MACRO Of 'cl_macro.prg'
            loColl      = ._Macros
            lnHandle    = Fopen(tcInputFile, 0)

            If lnHandle = -1
               lcMsg   = toFoxBin2Prg.FERROR_Message(tcInputFile)
               Error (lcMsg)
            Endif

            lnFileLen   = Fseek(lnHandle, 0, 2)

            If lnFileLen < 17
               Error 'Invalid FKY Macro File size'
            Else
               =Fseek(lnHandle, 0, 0)
            Endif

            ._Signature = Fread(lnHandle, 2)

            If ._Signature <> Chr(0xFF)+Chr(0x79)
               Error 'Invalid FKY Macro signature'
            Endif

            =Fseek(lnHandle, 14, 1) && Saltar bytes ignorados

            ._NumberOfMacros    = Fread(lnHandle, 2)
            lnNumberOfMacros    = CToBin(._NumberOfMacros,'2RS')

            If lnFileLen < 17 + 25 * lnNumberOfMacros
               * 25 caracteres es el tamaño mínimo de una macro sin teclas guardadas (solo la estructura)
               Error 'Invalid FKY Macro File size'
            Endif

            For I = 1 To lnNumberOfMacros
               loMRec  = NewObject('CL_MACRO_RECORD', 'cl_macro_record.prg')

               If Not loMRec.ReadNextMacro(lnHandle)
                  Exit
               Endif

               loColl.Add( loMRec, loMRec.get_Macro_Keystrokes(loMRec.Keystroke, .T.) )
               loMRec  = .Null.
            Endfor

            * Ordenar alfabéticamente por keystroke
            loColl.KeySort = 2

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
      Local lcText, loMRec As CL_MACRO_RECORD Of 'cl_macro_record.prg'
      lcText  = ''

      With This As CL_MACRO Of 'cl_macro.prg'

         *-- Macros
         For Each loMRec As CL_MACRO_RECORD Of 'cl_macro_record.prg' In ._Macros
            lcText  = lcText + CR_LF + loMRec.toText()
         Endfor

      Endwith

      Return lcText
   Endproc


Enddefine
