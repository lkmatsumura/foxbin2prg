#INCLUDE foxbin2prg.h

Define Class CL_MACRO_RECORD As CL_CUS_BASE Of 'cl_cus_base.prg'
   _MemberData = [<VFPData>] ;
      + [<memberdata name="macro_name" display="Macro_Name"/>] ;
      + [<memberdata name="macro_length" display="Macro_Length"/>] ;
      + [<memberdata name="keystroke" display="Keystroke"/>] ;
      + [<memberdata name="macro_keystrokes" display="Macro_Keystrokes"/>] ;
      + [<memberdata name="readnextmacro" display="ReadNextMacro"/>] ;
      + [<memberdata name="totext" display="toText"/>] ;
      + [<memberdata name="tobin" display="toBin"/>] ;
      + [<memberdata name="get_macro_keystrokes" display="get_Macro_Keystrokes"/>] ;
      + [<memberdata name="get_keytext" display="get_KeyText"/>] ;
      + [</VFPData>]

   *--
   Macro_Name                  = ''
   Macro_Length                = ''
   Keystroke                   = ''
   Macro_Keystrokes            = ''


   Procedure ReadNextMacro(tnHandle As Integer)
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tnHandle                  (!v IN    ) FKY file handle
      *---------------------------------------------------------------------------------------------------
      Local lnMacro_Length

      Try
         With This As CL_MACRO_RECORD Of 'cl_macro_record.prg'
            .Macro_Name         = Fread(tnHandle, 20)
            .Macro_Length       = Fread(tnHandle, 2)
            .Keystroke          = Fread(tnHandle, 2)
            lnMacro_Length      = CToBin(.Macro_Length, '2RS')
            .Macro_Keystrokes   = Fread(tnHandle, lnMacro_Length * 2)
         Endwith
      Endtry

      Return
   Endproc


   Procedure toBin As String
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      *---------------------------------------------------------------------------------------------------
      Local lcText

      With This As CL_MACRO_RECORD Of 'cl_macro_record.prg'

      Endwith

      Return lcText
   Endproc


   Procedure toText As String
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      *---------------------------------------------------------------------------------------------------
      Local lcText, loField As CL_MACRO_RECORD Of 'cl_macro_record.prg'
      lcText  = ''

      With This As CL_MACRO_RECORD Of 'cl_macro_record.prg'
         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
             <<>><MACRO>
             <<Chr(9)>>Macro_Name      : <<ALLTRIM(.Macro_Name, 0, CHR(0), CHR(32))>>
             <<Chr(9)>>Keystroke       : <<.get_Macro_Keystrokes(.Keystroke, .T.)>>
             <<Chr(9)>>Macro_Keystrokes: <<.get_Macro_Keystrokes(.Macro_Keystrokes)>>
             <<>></MACRO>
         ENDTEXT

      Endwith

      Return lcText
   Endproc


   Function get_Macro_Keystrokes(tcMacroStr, tlLiteralForCaption)
      *---------------------------------------------------------------------------------------------------
      * DEVLUELVE LOS LITERALES DE TODAS LAS TECLAS
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      *---------------------------------------------------------------------------------------------------
      Local lcKeystrokes, I

      With This As CL_MACRO_RECORD Of 'cl_macro_record.prg'
         lcKeystrokes    = ''

         For I = 1 To Len(tcMacroStr) Step 2
            lcKeystrokes    = lcKeystrokes + .get_KeyText(@tcMacroStr, @I, tlLiteralForCaption)
         Endfor
      Endwith

      Return lcKeystrokes
   Endfunc


   Function get_KeyText(tcMacroStr As String, I As Integer, tlLiteralForCaption As Boolean) As String
      *---------------------------------------------------------------------------------------------------
      * DEVLUELVE EL LITERAL DE UNA TECLA
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcMacroStr                (!@ IN    ) Cadena de teclas de la macro
      * I                         (!@ IN    ) Posición actualmente analizada de la cadena
      * tlLiteralForCaption       (?v IN    ) Indica si algunos caracteres especiales se deben convertir a literal (ej: ";" => "SHIFT+SEMICOLON")
      *---------------------------------------------------------------------------------------------------
      Local lcMod, lcKey, lcKeyName, lcKeyMod, lcTecla, lnKeyVal, lcKeyPair, lnCntMod ;
         , llComplementar, llKeyCodeShift, llKeyCodeCtrl, llKeyCodeAlt, lnMod, lnKey

      Store '' To lcTecla, lcKeyName, lcKeyMod, lcKey
      lcKeyPair   = Substr(tcMacroStr,I,2)
      lnKeyVal    = CToBin(lcKeyPair, '2RS')
      lcKey       = Left(lcKeyPair,1)
      lcMod       = Right(lcKeyPair,1)
      lnMod       = Asc(lcMod)
      lnKey       = Asc(lcKey)
      lnCntMod    = 0

      * Tratamiento de modificadores
      If Not lcKeyPair == Chr(0xFE)+Chr(0xFF)
         If Bitand(lnMod, 0x80) = 0x80   && LITERAL
            lcKeyMod        = lcKeyMod + Iif(Empty(lcKeyMod),'','+') + 'LITERAL'
         Endif
         If Bitand(lnMod, 0x40) = 0x40   && ALT
            *lcKeyMod       = lcKeyMod + IIF(EMPTY(lcKeyMod),'','+') + 'ALT'
            llKeyCodeAlt    = .T.
            lnCntMod        = lnCntMod + 1
         Endif
         If Bitand(lnMod, 0x20) = 0x20   && CTRL
            *lcKeyMod       = lcKeyMod + IIF(EMPTY(lcKeyMod),'','+') + 'CTRL'
            llKeyCodeCtrl   = .T.
            lnCntMod        = lnCntMod + 1
         Endif
         If Bitand(lnMod, 0x10) = 0x10   && SHIFT
            *lcKeyMod       = lcKeyMod + IIF(EMPTY(lcKeyMod),'','+') + 'SHIFT'
            llKeyCodeShift  = .T.
            lnCntMod        = lnCntMod + 1
         Endif
      Endif

      llComplementar  = llKeyCodeAlt Or llKeyCodeCtrl Or llKeyCodeShift
      *llComplementar = llKeyCodeShift

      * Tratamiento de teclas normales
      * (Ordenar de mayor valor a menor: 0xFFF > 0x000)
      Do Case
      Case lcKeyPair == Chr(0xFE)+Chr(0xFF)
         lcKeyName   = 'PAUSE '
         * Buscar el tiempo
         I   = I + 2
         lcKeyPair   = Substr(tcMacroStr,I,2)

         If lcKeyPair == Chr(0xFF)+Chr(0xFF)
            lcKeyName   = lcKeyName + 'KEY'
         Else
            lnKeyVal    = CToBin(lcKeyPair, '2RS')
            lcKeyName   = lcKeyName + Ltrim(Str(lnKeyVal/100,5,2))
         Endif

      Case Bitand(lnMod, 0x01) = 0x01 ;
            OR Bitand(lnMod, 0x10) = 0x10 ;
            OR Bitand(lnMod, 0x20) = 0x20 ;
            OR Bitand(lnMod, 0x40) = 0x40
         *llComplementar = .F.

         Do Case
         Case Bitand(lnKeyVal, 0x41A3) = 0x41A3
            lcKeyName   = 'ALT+DEL'

         Case Bitand(lnKeyVal, 0x41A2) = 0x41A2
            lcKeyName   = 'ALT+INS'

         Case Bitand(lnKeyVal, 0x41A1) = 0x41A1
            lcKeyName   = 'ALT+PGND'

         Case Bitand(lnKeyVal, 0x41A0) = 0x41A0
            lcKeyName   = 'ALT+DNARROW'

         Case Bitand(lnKeyVal, 0x419F) = 0x419F
            lcKeyName   = 'ALT+END'

         Case Bitand(lnKeyVal, 0x419D) = 0x419D
            lcKeyName   = 'ALT+RIGHTARROW'

         Case Bitand(lnKeyVal, 0x419B) = 0x419B
            lcKeyName   = 'ALT+LEFTARROW'

         Case Bitand(lnKeyVal, 0x4199) = 0x4199
            lcKeyName   = 'ALT+PGUP'

         Case Bitand(lnKeyVal, 0x4198) = 0x4198
            lcKeyName   = 'ALT+UPARROW'

         Case Bitand(lnKeyVal, 0x4197) = 0x4197
            lcKeyName   = 'ALT+HOME'

         Case Bitand(lnKeyVal, 0x418C) = 0x418C
            lcKeyName   = 'ALT+F12'

         Case Bitand(lnKeyVal, 0x418B) = 0x418B
            lcKeyName   = 'ALT+F11'

         Case Bitand(lnKeyVal, 0x4181) = 0x4181
            lcKeyName   = 'ALT+0'

         Case Bitand(lnKeyVal, 0x4180) = 0x4180
            lcKeyName   = 'ALT+9'

         Case Bitand(lnKeyVal, 0x417F) = 0x417F
            lcKeyName   = 'ALT+8'

         Case Bitand(lnKeyVal, 0x417E) = 0x417E
            lcKeyName   = 'ALT+7'

         Case Bitand(lnKeyVal, 0x417D) = 0x417D
            lcKeyName   = 'ALT+6'

         Case Bitand(lnKeyVal, 0x417C) = 0x417C
            lcKeyName   = 'ALT+5'

         Case Bitand(lnKeyVal, 0x417B) = 0x417B
            lcKeyName   = 'ALT+4'

         Case Bitand(lnKeyVal, 0x417A) = 0x417A
            lcKeyName   = 'ALT+3'

         Case Bitand(lnKeyVal, 0x4179) = 0x4179
            lcKeyName   = 'ALT+2'

         Case Bitand(lnKeyVal, 0x4178) = 0x4178
            lcKeyName   = 'ALT+1'

         Case Bitand(lnKeyVal, 0x4171) = 0x4171
            lcKeyName   = 'ALT+F10'

         Case Bitand(lnKeyVal, 0x4170) = 0x4170
            lcKeyName   = 'ALT+F9'

         Case Bitand(lnKeyVal, 0x416F) = 0x416F
            lcKeyName   = 'ALT+F8'

         Case Bitand(lnKeyVal, 0x416E) = 0x416E
            lcKeyName   = 'ALT+F7'

         Case Bitand(lnKeyVal, 0x416D) = 0x416D
            lcKeyName   = 'ALT+F6'

         Case Bitand(lnKeyVal, 0x416C) = 0x416C
            lcKeyName   = 'ALT+F5'

         Case Bitand(lnKeyVal, 0x416B) = 0x416B
            lcKeyName   = 'ALT+F4'

         Case Bitand(lnKeyVal, 0x416A) = 0x416A
            lcKeyName   = 'ALT+F3'

         Case Bitand(lnKeyVal, 0x4169) = 0x4169
            lcKeyName   = 'ALT+F2'

         Case Bitand(lnKeyVal, 0x4168) = 0x4168
            lcKeyName   = 'ALT+F1'

         Case Bitand(lnKeyVal, 0x4132) = 0x4132
            lcKeyName   = 'ALT+M'

         Case Bitand(lnKeyVal, 0x4131) = 0x4131
            lcKeyName   = 'ALT+N'

         Case Bitand(lnKeyVal, 0x4130) = 0x4130
            lcKeyName   = 'ALT+B'

         Case Bitand(lnKeyVal, 0x412F) = 0x412F
            lcKeyName   = 'ALT+V'

         Case Bitand(lnKeyVal, 0x412E) = 0x412E
            lcKeyName   = 'ALT+C'

         Case Bitand(lnKeyVal, 0x412D) = 0x412D
            lcKeyName   = 'ALT+X'

         Case Bitand(lnKeyVal, 0x412C) = 0x412C
            lcKeyName   = 'ALT+Z'

         Case Bitand(lnKeyVal, 0x4126) = 0x4126
            lcKeyName   = 'ALT+L'

         Case Bitand(lnKeyVal, 0x4125) = 0x4125
            lcKeyName   = 'ALT+K'

         Case Bitand(lnKeyVal, 0x4124) = 0x4124
            lcKeyName   = 'ALT+J'

         Case Bitand(lnKeyVal, 0x4123) = 0x4123
            lcKeyName   = 'ALT+H'

         Case Bitand(lnKeyVal, 0x4122) = 0x4122
            lcKeyName   = 'ALT+G'

         Case Bitand(lnKeyVal, 0x4121) = 0x4121
            lcKeyName   = 'ALT+F'

         Case Bitand(lnKeyVal, 0x4120) = 0x4120
            lcKeyName   = 'ALT+D'

         Case Bitand(lnKeyVal, 0x411F) = 0x411F
            lcKeyName   = 'ALT+S'

         Case Bitand(lnKeyVal, 0x411E) = 0x411E
            lcKeyName   = 'ALT+A'

         Case Bitand(lnKeyVal, 0x4119) = 0x4119
            lcKeyName   = 'ALT+P'

         Case Bitand(lnKeyVal, 0x4118) = 0x4118
            lcKeyName   = 'ALT+O'

         Case Bitand(lnKeyVal, 0x4117) = 0x4117
            lcKeyName   = 'ALT+I'

         Case Bitand(lnKeyVal, 0x4116) = 0x4116
            lcKeyName   = 'ALT+U'

         Case Bitand(lnKeyVal, 0x4115) = 0x4115
            lcKeyName   = 'ALT+Y'

         Case Bitand(lnKeyVal, 0x4114) = 0x4114
            lcKeyName   = 'ALT+T'

         Case Bitand(lnKeyVal, 0x4113) = 0x4113
            lcKeyName   = 'ALT+R'

         Case Bitand(lnKeyVal, 0x4112) = 0x4112
            lcKeyName   = 'ALT+E'

         Case Bitand(lnKeyVal, 0x4111) = 0x4111
            lcKeyName   = 'ALT+U'

         Case Bitand(lnKeyVal, 0x4110) = 0x4110
            lcKeyName   = 'ALT+Q'

         Case Bitand(lnKeyVal, 0x410C) = 0x410C
            lcKeyName   = [ALT+']   && No está en la ayuda de VFP

         Case Bitand(lnKeyVal, 0x2194) = 0x2194
            lcKeyName   = 'CTRL+TAB'

         Case Bitand(lnKeyVal, 0x2193) = 0x2193
            lcKeyName   = 'CTRL+DEL'

         Case Bitand(lnKeyVal, 0x2192) = 0x2192
            lcKeyName   = 'CTRL+INS'

         Case Bitand(lnKeyVal, 0x2191) = 0x2191
            lcKeyName   = 'CTRL+DNARROW'

         Case Bitand(lnKeyVal, 0x218D) = 0x218D
            lcKeyName   = 'CTRL+UPARROW'

         Case Bitand(lnKeyVal, 0x218A) = 0x218A
            lcKeyName   = 'CTRL+F12'

         Case Bitand(lnKeyVal, 0x2189) = 0x2189
            lcKeyName   = 'CTRL+F11'

         Case Bitand(lnKeyVal, 0x2184) = 0x2184
            lcKeyName   = 'CTRL+PGUP'

         Case Bitand(lnKeyVal, 0x2177) = 0x2177
            lcKeyName   = 'CTRL+HOME'

         Case Bitand(lnKeyVal, 0x2176) = 0x2176
            lcKeyName   = 'CTRL+PGDN'

         Case Bitand(lnKeyVal, 0x2175) = 0x2175
            lcKeyName   = 'CTRL+END'

         Case Bitand(lnKeyVal, 0x2174) = 0x2174
            lcKeyName   = 'CTRL+RIGHTARROW'

         Case Bitand(lnKeyVal, 0x2173) = 0x2173
            lcKeyName   = 'CTRL+LEFTARROW'

         Case Bitand(lnKeyVal, 0x2167) = 0x2167
            lcKeyName   = 'CTRL+F10'

         Case Bitand(lnKeyVal, 0x2166) = 0x2166
            lcKeyName   = 'CTRL+F9'

         Case Bitand(lnKeyVal, 0x2165) = 0x2165
            lcKeyName   = 'CTRL+F8'

         Case Bitand(lnKeyVal, 0x2164) = 0x2164
            lcKeyName   = 'CTRL+F7'

         Case Bitand(lnKeyVal, 0x2163) = 0x2163
            lcKeyName   = 'CTRL+F6'

         Case Bitand(lnKeyVal, 0x2162) = 0x2162
            lcKeyName   = 'CTRL+F5'

         Case Bitand(lnKeyVal, 0x2161) = 0x2161
            lcKeyName   = 'CTRL+F4'

         Case Bitand(lnKeyVal, 0x2160) = 0x2160
            lcKeyName   = 'CTRL+F3'

         Case Bitand(lnKeyVal, 0x215F) = 0x215F
            lcKeyName   = 'CTRL+F2'

         Case Bitand(lnKeyVal, 0x215E) = 0x215E
            lcKeyName   = 'CTRL+F1'

         Case Bitand(lnKeyVal, 0x2020) = 0x2020
            lcKeyName   = 'CTRL+SPACEBAR'

         Case Bitand(lnKeyVal, 0x201F) = 0x201F
            lcKeyName   = 'CTRL+HYPHEN'

         Case Bitand(lnKeyVal, 0x201E) = 0x201E
            lcKeyName   = 'CTRL+CARET'

         Case Bitand(lnKeyVal, 0x201D) = 0x201D
            lcKeyName   = 'CTRL+RBRACKET'

         Case Bitand(lnKeyVal, 0x201C) = 0x201C
            lcKeyName   = 'CTRL+BACKSLASH'

         Case Bitand(lnKeyVal, 0x201B) = 0x201B
            lcKeyName   = 'CTRL+LBRACKET'

         Case Bitand(lnKeyVal, 0x201A) = 0x201A
            lcKeyName   = 'CTRL+Z'

         Case Bitand(lnKeyVal, 0x2019) = 0x2019
            lcKeyName   = 'CTRL+Y'

         Case Bitand(lnKeyVal, 0x2018) = 0x2018
            lcKeyName   = 'CTRL+X'

         Case Bitand(lnKeyVal, 0x2017) = 0x2017
            lcKeyName   = 'CTRL+W'

         Case Bitand(lnKeyVal, 0x2016) = 0x2016
            lcKeyName   = 'CTRL+V'

         Case Bitand(lnKeyVal, 0x2015) = 0x2015
            lcKeyName   = 'CTRL+U'

         Case Bitand(lnKeyVal, 0x2014) = 0x2014
            lcKeyName   = 'CTRL+T'

         Case Bitand(lnKeyVal, 0x2013) = 0x2013
            lcKeyName   = 'CTRL+S'

         Case Bitand(lnKeyVal, 0x2012) = 0x2012
            lcKeyName   = 'CTRL+R'

         Case Bitand(lnKeyVal, 0x2011) = 0x2011
            lcKeyName   = 'CTRL+Q'

         Case Bitand(lnKeyVal, 0x2010) = 0x2010
            lcKeyName   = 'CTRL+P'

         Case Bitand(lnKeyVal, 0x200F) = 0x200F
            lcKeyName   = 'CTRL+O'

         Case Bitand(lnKeyVal, 0x200E) = 0x200E
            lcKeyName   = 'CTRL+N'

         Case Bitand(lnKeyVal, 0x200D) = 0x200D
            lcKeyName   = 'CTRL+M'

         Case Bitand(lnKeyVal, 0x200C) = 0x200C
            lcKeyName   = 'CTRL+L'

         Case Bitand(lnKeyVal, 0x200B) = 0x200B
            lcKeyName   = 'CTRL+K'

         Case Bitand(lnKeyVal, 0x200A) = 0x200A
            lcKeyName   = 'CTRL+ENTER'

         Case Bitand(lnKeyVal, 0x200A) = 0x200A
            lcKeyName   = 'CTRL+J'

         Case Bitand(lnKeyVal, 0x2009) = 0x2009
            lcKeyName   = 'CTRL+I'

         Case Bitand(lnKeyVal, 0x2008) = 0x2008
            lcKeyName   = 'CTRL+H'

         Case Bitand(lnKeyVal, 0x2007) = 0x2007
            lcKeyName   = 'CTRL+G'

         Case Bitand(lnKeyVal, 0x2006) = 0x2006
            lcKeyName   = 'CTRL+F'

         Case Bitand(lnKeyVal, 0x2005) = 0x2005
            lcKeyName   = 'CTRL+E'

         Case Bitand(lnKeyVal, 0x2004) = 0x2004
            lcKeyName   = 'CTRL+D'

         Case Bitand(lnKeyVal, 0x2003) = 0x2003
            lcKeyName   = 'CTRL+C'

         Case Bitand(lnKeyVal, 0x2002) = 0x2002
            lcKeyName   = 'CTRL+B'

         Case Bitand(lnKeyVal, 0x2001) = 0x2001
            lcKeyName   = 'CTRL+A'

         Case Bitand(lnKeyVal, 0x1188) = 0x1188
            lcKeyName   = 'SHIFT+F12'

         Case Bitand(lnKeyVal, 0x1187) = 0x1187
            lcKeyName   = 'SHIFT+F11'

         Case Bitand(lnKeyVal, 0x115D) = 0x115D
            lcKeyName   = 'SHIFT+F10'

         Case Bitand(lnKeyVal, 0x115C) = 0x115C
            lcKeyName   = 'SHIFT+F9'

         Case Bitand(lnKeyVal, 0x115B) = 0x115B
            lcKeyName   = 'SHIFT+F8'

         Case Bitand(lnKeyVal, 0x115A) = 0x115A
            lcKeyName   = 'SHIFT+F7'

         Case Bitand(lnKeyVal, 0x1159) = 0x1159
            lcKeyName   = 'SHIFT+F6'

         Case Bitand(lnKeyVal, 0x1158) = 0x1158
            lcKeyName   = 'SHIFT+F5'

         Case Bitand(lnKeyVal, 0x1157) = 0x1157
            lcKeyName   = 'SHIFT+F4'

         Case Bitand(lnKeyVal, 0x1156) = 0x1156
            lcKeyName   = 'SHIFT+F3'

         Case Bitand(lnKeyVal, 0x1155) = 0x1155
            lcKeyName   = 'SHIFT+F2'

         Case Bitand(lnKeyVal, 0x1154) = 0x1154
            lcKeyName   = 'SHIFT+F1'

         Case Bitand(lnKeyVal, 0x0186) = 0x0186
            lcKeyName   = 'F12'

         Case Bitand(lnKeyVal, 0x0185) = 0x0185
            lcKeyName   = 'F11'

         Case Inlist(lnKeyVal, 0x0153, 0x1153)
            lcKeyName   = 'DEL'

         Case Inlist(lnKeyVal, 0x0152, 0x1152)
            lcKeyName   = 'INS'

         Case Inlist(lnKeyVal, 0x0151, 0x1151)
            lcKeyName   = 'PGDN'

         Case Inlist(lnKeyVal, 0x0150, 0x1150)
            lcKeyName   = 'DNARROW'

         Case Inlist(lnKeyVal, 0x014F, 0x114F)
            lcKeyName   = 'END'

         Case Inlist(lnKeyVal, 0x014D, 0x114D)
            lcKeyName   = 'RIGHTARROW'

         Case Inlist(lnKeyVal, 0x014B, 0x114B)
            lcKeyName   = 'LEFTARROW'

         Case Inlist(lnKeyVal, 0x0149, 0x1149)
            lcKeyName   = 'PGUP'

         Case Inlist(lnKeyVal, 0x0148, 0x1148)
            lcKeyName   = 'UPARROW'

         Case Bitand(lnKeyVal, 0x0147) = 0x0147
            lcKeyName   = 'HOME'

         Case lnKeyVal = 0x0144
            lcKeyName   = 'F10'

         Case lnKeyVal = 0x0143
            lcKeyName   = 'F9'

         Case lnKeyVal = 0x0142
            lcKeyName   = 'F8'

         Case lnKeyVal = 0x0141
            lcKeyName   = 'F7'

         Case lnKeyVal = 0x0140
            lcKeyName   = 'F6'

         Case lnKeyVal = 0x013F
            lcKeyName   = 'F5'

         Case lnKeyVal = 0x013E
            lcKeyName   = 'F4'

         Case lnKeyVal = 0x013D
            lcKeyName   = 'F3'

         Case lnKeyVal = 0x013C
            lcKeyName   = 'F2'

         Case lnKeyVal = 0x013B
            lcKeyName   = 'F1'

         Case lnKeyVal = 0x010F
            lcKeyName   = 'BACKTAB'

         Case lnKeyVal = 0x0100
            lcKeyName   = 'LEFTMOUSE'

         Otherwise
            *lcKeyName  = CHR(lnKeyVal)

         Endcase

      Endcase

      If Empty(lcKeyName)

         Do Case
         Case Between(lnKey, 0x41, 0x5A) Or Between(lnKey, 0x61, 0x7A) Or Inlist(lnKey, 0x7C, 0x7E)  && A..Z, a..z, |, ~
            lcKeyName   = lcKey
            llKeyCodeShift  = .F.

         Case Between(lnKey, 0x21, 0x7A) And Not (lnKey = 0x3B)
            llKeyCodeShift  = .F.
            lcKeyName   = lcKey

         Case lnKey = 0x7F
            lcKeyName   = 'DEL'

         Case lnKey = 0x7D   && "{"
            lcKeyName   = 'RBRACE'

         Case lnKey = 0x7B   && "}"
            lcKeyName   = 'LBRACE'

         Case lnKey = 0x3B   && ";"
            lcKeyName   = 'SEMICOLON'

         Case lnKey = 0x2C   && ","
            lcKeyName   = 'SEMICOLON'

         Case lnKey = 0x20   && " "
            lcKeyName   = 'SPACEBAR'

         Case lnKey = 0x1B
            lcKeyName   = 'ESCAPE'

         Case lnKey = 0x0D
            lcKeyName   = 'ENTER'

         Case lnKey = 0x09
            lcKeyName   = 'TAB'

         Case lnKey = 0x08
            lcKeyName   = 'BACKSPACE'

         Otherwise
            llComplementar  = .F.
            lcKeyName   = 'x' + Right( Transform(lnKeyVal,'@0'), 4)

         Endcase

         *ENDCASE
      Endif

      * Tratamiento de modificadores
      If Not lcKeyPair == Chr(0xFE)+Chr(0xFF) And llComplementar
         If llKeyCodeShift And At("SHIFT",lcKeyName) = 0 && SHIFT
            lcKeyMod        = lcKeyMod + Iif(Empty(lcKeyMod),'','+') + 'SHIFT'
         Endif
         If llKeyCodeCtrl And At("CTRL",lcKeyName) = 0   && CTRL
            lcKeyMod        = lcKeyMod + Iif(Empty(lcKeyMod),'','+') + 'CTRL'
         Endif
         If llKeyCodeAlt And At("ALT",lcKeyName) = 0 && ALT
            lcKeyMod        = lcKeyMod + Iif(Empty(lcKeyMod),'','+') + 'ALT'
         Endif
         *IF BITAND(lnKeyVal, 0x8000) = 0x8000   && LITERAL
         *   lcKeyMod        = lcKeyMod + IIF(EMPTY(lcKeyMod),'','+') + 'LITERAL'
         *ENDIF
      Endif

      * Tratamiento de combinación final
      Do Case
      Case Len(lcKeyName) > 1 And (Not llComplementar Or Empty(lcKeyMod))
         If tlLiteralForCaption
            lcTecla = lcKeyName
         Else
            lcTecla = '{' + lcKeyName + '}'
         Endif

      Case Empty(lcKeyMod)
         lcTecla = lcKeyName

      Otherwise
         If tlLiteralForCaption
            lcTecla = lcKeyMod + '+' + lcKeyName
         Else
            lcTecla = '{' + lcKeyMod + '+' + lcKeyName + '}'
         Endif

      Endcase

      Return lcTecla
   Endfunc


Enddefine
