#INCLUDE foxbin2prg.h

Define Class frm_main As Form
   AllowOutput = .F.
   AlwaysOnTop = .T.
   AutoCenter = .T.
   BackColor = (Rgb(255,255,255))
   BorderStyle = 3
   Caption = "FoxBin2Prg <x>"
   Closable = .T.
   ControlBox = .T.
   DoCreate = .T.
   Height = 800
   KeyPreview = .T.
   MaxButton = .T.
   MinButton = .F.
   MinHeight = 800
   MinWidth = 1024
   Name = "FRM_MAIN"
   ShowWindow = 2
   Width = 1024

   Add Object 'edt_Help' As EditBox With ;
      Anchor = 1+2+4+8, ;
      BackStyle = 0, ;
      BorderStyle = 0, ;
      DisabledForeColor = (Rgb(0,0,0)), ;
      Enabled = .T., ;
      FontName = "Courier New", ;
      FontSize = 9, ;
      Height = 744, ;
      Left = 12, ;
      Name = "edt_Help", ;
      ReadOnly = .T., ;
      ScrollBars = 2, ;
      Top = 12, ;
      Width = 996

   Add Object 'cmd_Close' As CommandButton With ;
      Anchor = 4+8, ;
      Cancel = .T., ;
      Caption = "Close", ;
      Height = 27, ;
      Left = 924, ;
      Name = "cmd_Close", ;
      Top = 764, ;
      Width = 84

   Procedure Init
      Lparameters toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Local laDirInfo(1,5), loLang As CL_LANG Of 'cl_lang.prg'

      If Vartype(toFoxBin2Prg) = "O" Then
         If Vartype(_Screen.o_FoxBin2Prg_Lang) = "O" Then
            loLang = _Screen.o_FoxBin2Prg_Lang

            If Pemstatus(_Screen, 'c_FB2PRG_EXE_Version', 5) Then
               Thisform.Caption = 'FoxBin2Prg ' + _Screen.c_FB2PRG_EXE_Version + ' - ' + loLang.C_FOXBIN2PRG_SYNTAX_INFO_LOC
            Endif

            Thisform.edt_help.Value = loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC+CR_LF ;
                                    + Strtran(loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_cfg,'&'+'&','')+CR_LF ;
                                    + Strtran(loLang.C_FOXBIN2PRG_SYNTAX_INFO_EXAMPLE_LOC_tab_cfg,'&'+'&','')

         Endif

         If Adir( laDirInfo, ForceExt( toFoxBin2Prg.c_Foxbin2prg_FullPath, 'ICO' ) ) > 0 Then
            Thisform.Icon = ForceExt( toFoxBin2Prg.c_Foxbin2prg_FullPath, 'ICO' )
         Endif
      Endif

   Endproc

   Procedure QueryUnload
      Clear Events
      Nodefault

   Endproc

   Procedure cmd_Close.Click
      Thisform.Hide()
      Clear Events

   Endproc

Enddefine
