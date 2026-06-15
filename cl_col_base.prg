#INCLUDE foxbin2prg.h

Define Class CL_COL_BASE As Collection
   #If .F.
      Local This As CL_COL_BASE Of 'cl_col_base.prg'
   #Endif

   *-- Propiedades (Se preservan: COUNT, KEYSORT, NAME)
   **HIDDEN BASECLASS, CLASS, CLASSLIBRARY, COUNT, COMMENT ;
   , PARENT, PARENTCLASS, TAG

   _MemberData = [<VFPData>] ;
      + [<memberdata name="n_debug" display="n_Debug"/>] ;
      + [<memberdata name="_saved" display="_Saved"/>] ;
      + [<memberdata name="analyzecodeblock" display="analyzeCodeBlock"/>] ;
      + [<memberdata name="get_separatedlineandcomment" display="get_SeparatedLineAndComment"/>] ;
      + [<memberdata name="get_absolutepath" display="get_AbsolutePath"/>] ;
      + [<memberdata name="set_line" display="set_Line"/>] ;
      + [<memberdata name="totext" display="toText"/>] ;
      + [</VFPData>]

   n_Debug             = 0
   _Saved              = .F.       && Indica si la información fue leida y guardada en las propiedades.


   Procedure Init
      Set Deleted On
      Set Date YMD
      Set Hours To 24
      Set Century On
      Set Safety Off
      Set TablePrompt Off

      This.n_Debug    = Iif(_vfp.StartMode=0, 1, 0)
   Endproc


   Procedure analyzeCodeBlock
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
      tcLine  = Ltrim( taCodeLines(m.I), 0, Chr(9), ' ' )
   Endproc


   Procedure get_AbsolutePath
      Lparameters tc_InputFile, tc_FullPath

      *-- Ajusto la ruta si no es absoluta
      tc_InputFile    = Evl(tc_InputFile,'')

      If Not Empty( Justext(tc_FullPath) ) Then
         *-- Se indicó PATH+archivo.ext
         tc_FullPath = Justpath(tc_FullPath)
      Endif

      tc_FullPath = Addbs( tc_FullPath )

      If Len(tc_InputFile) > 1 ;
            AND Left(Ltrim(tc_InputFile),2) <> '\\' ;
            AND Substr(Ltrim(tc_InputFile),2,1) <> ':' Then
         tc_InputFile    = Fullpath(tc_InputFile, tc_FullPath)
      Endif

      Return tc_InputFile
   Endproc


   Procedure get_SeparatedLineAndComment
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcLine                    (!@ IN/OUT) Línea a separar del comentario
      * tcComment                 (@?    OUT) Comentario
      * tlDeepCommentAnalysis     (v? IN    ) Indica realizar un análisis profundo de comentarios (para detectar casos complejos de código con '&&' embebido)
      *---------------------------------------------------------------------------------------------------
      Lparameters tcLine As String, tcComment As String, tlDeepCommentAnalysis As Boolean
      Local ln_AT_Cmt
      tcComment   = ''
      ln_AT_Cmt   = At( '&'+'&', tcLine)

      If ln_AT_Cmt > 0
         If tlDeepCommentAnalysis Then
            Local laSeparador(3,3), lcSeparadoresIzq, lcSeparadoresDer, lcStr, lnAT_Amp, lnAT1, lnAT2, lnLen, I, X

            lcStr   = tcLine    &&EVL(tcStr, [DEFINE BAR 2 OF OpciónAsub PROMPT "Opción A&]+[&2" &]+[& Comentario Opción A-2])
            laSeparador(1,1)    = '"'
            laSeparador(1,2)    = '"'
            laSeparador(1,3)    = 2
            laSeparador(2,1)    = "'"
            laSeparador(2,2)    = "'"
            laSeparador(2,3)    = 2
            laSeparador(3,1)    = '['
            laSeparador(3,2)    = ']'
            laSeparador(3,3)    = 1
            lcSeparadoresIzq    = laSeparador(1,1) + laSeparador(2,1) + laSeparador(3,1)
            lcSeparadoresDer    = laSeparador(1,2) + laSeparador(2,2) + laSeparador(3,2)
            lnLen               = Len(lcStr)

            *-- Anular subcadenas para luego encontrar comentarios '&&' (y analizar solo si existe al menos un '&&')
            X       = 1
            lnAT1   = At(laSeparador(m.X,1), lcStr)

            *-- Funcionamiento:
            *-- La anulación de subcadenas se hace comenzando desde la primer comilla doble ["], y luego se va
            *-- cancelando hasta la siguiente. A partir de ahi, se busca carácter a carácter el siguiente separador
            *-- izquierdo de cadena ( '"[ ), se busca su pareja derecha y se cancela el texto entre ambos.
            *-- La anulación de subcadenas es temporal, solo para determinar la verdadera posición del comentario,
            *-- por ejemplo, esto:
            *-- DEFINE BAR 2 OF OpciónAsub PROMPT ""+var+'aa'+["bb]+"Opción A&&2" && Comentario Opción A-2
            *-- se convierte temporalmente en esto:
            *-- DEFINE BAR 2 OF OpciónAsub PROMPT XX+var+XXXX+XXXXX+XXXXXXXXXXXXX && Comentario Opción A-2
            *-- lo que facilita encontrar el comentario '&&' real.
            *-- Si se encuentra algún separador de cadena que no cierre, se genera un error 10 (Syntax Error).
            If lnAT1 > 0 Then
               For I = lnAT1+1 To lnLen
                  If m.X > 0 Then
                     lnAT2   = At(laSeparador(m.X,2), lcStr, laSeparador(m.X,3))

                     If lnAT2 > 0 Then
                        lcStr   = Stuff(lcStr, lnAT1, lnAT2-lnAT1+1, Replicate('X',lnAT2-lnAT1+1))
                     Else
                        ln_AT_Cmt   = At( '&'+'&', lcStr)

                        If ln_AT_Cmt = 0 Or ln_AT_Cmt < lnAT1
                           *-- No tiene comentario '&&' real, o sí lo tiene y además contiene un delimitador de cadena como parte del comentario
                           Exit
                        Else
                           Error 'Closing string delimiter <' + laSeparador(m.X,2) + '> not found: ' + tcLine
                        Endif
                     Endif
                  Endif

                  *-- Verifico si el carácter es un separador de cadenas: '"[
                  X   = At( Substr(lcStr, m.I, 1), lcSeparadoresIzq)

                  If m.X > 0 Then
                     lnAT1   = At(laSeparador(m.X,1), lcStr)
                  Endif
               Endfor
            Endif

            ln_AT_Cmt   = At( '&'+'&', lcStr)
         Endif && tlDeepCommentAnalysis

         If ln_AT_Cmt > 0
            tcComment   = Ltrim( Substr( tcLine, ln_AT_Cmt + 2 ) )
            tcLine      = Rtrim( Left( tcLine, ln_AT_Cmt - 1 ), 0, Chr(9), ' ' )    && Quito TABS y espacios
         Endif

      Endif

      Return (ln_AT_Cmt > 0)
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * taArray                   (@?    OUT) Array de conexiones
      * tnArray_Count             (@?    OUT) Cantidad de conexiones
      *---------------------------------------------------------------------------------------------------
   Endproc
Enddefine
