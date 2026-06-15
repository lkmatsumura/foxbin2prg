Define Class frm_interactive As Form
   _MemberData = [<VFPData>] ;
      + [<memberdata name="n_conversiontype" display="n_ConversionType"/>] ;
      + [<memberdata name="l_filetimestampoptimization" display="l_FileTimeStampOptimization"/>] ;
      + [</VFPData>]


   Height = 114
   Width = 380
   ShowWindow = 2
   DoCreate = .T.
   AllowOutput = .F.
   AutoCenter = .T.
   BorderStyle = 2
   Caption = "FoxBin2Prg"
   Closable = .T.
   ControlBox = .T.
   AlwaysOnTop = .T.
   MaxButton = .F.
   MinButton = .F.
   BackColor = Rgb(255,255,255)
   n_ConversionType = 3
   l_FileTimeStampOptimization = .F.
   Name = "frm_interactive"



   Add Object chk_FileTimeStampOptimization As Checkbox With ;
      Alignment = 0, ;
      BackStyle = 0, ;
      Caption = "chk_FileTimeStampOptimization", ;
      ControlSource = "THISFORM.l_FileTimeStampOptimization", ;
      Enabled = .T., ;
      Height = 17, ;
      Left = 40, ;
      Name = "chk_FileTimeStampOptimization", ;
      Top = 92, ;
      Width = 300, ;
      Visible = .F.


   Add Object lbl_title As Label With ;
      WordWrap = .T., ;
      Alignment = 2, ;
      BackStyle = 0, ;
      Caption = "lbl_title", ;
      Height = 36, ;
      Left = 12, ;
      Top = 16, ;
      Width = 356, ;
      KeyPreview = .T., ;
      Name = "lbl_Title"


   Add Object cmd_Bin2Prg As CommandButton With ;
      Top = 58, ;
      Left = 40, ;
      Height = 27, ;
      Width = 92, ;
      Caption = "cmd_Bin2Prg", ;
      Name = "cmd_Bin2Prg"


   Add Object cmd_Prg2Bin As CommandButton With ;
      Top = 58, ;
      Left = 144, ;
      Height = 27, ;
      Width = 92, ;
      Caption = "cmd_Prg2Bin", ;
      Name = "cmd_Prg2Bin"


   Add Object cmd_None As CommandButton With ;
      Top = 58, ;
      Left = 248, ;
      Height = 27, ;
      Width = 92, ;
      Caption = "cmd_None", ;
      Cancel = .T., ;
      Name = "cmd_None"


   Procedure Init
      Lparameters toFoxBin2Prg

      #If .F.
         Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
      #Endif

      Local laDirInfo(1,5), loLang As CL_LANG Of 'cl_lang.prg'

      If Vartype(toFoxBin2Prg) = "O" Then
         If Vartype(_Screen.o_FoxBin2Prg_Lang) = "O" Then
            loLang          = _Screen.o_FoxBin2Prg_Lang

            If Pemstatus(_Screen, 'c_FB2PRG_EXE_Version', 5) Then
               Thisform.Caption = 'FoxBin2Prg ' + _Screen.c_FB2PRG_EXE_Version + ' - ' + loLang.C_CONVERT_FOLDER_LOC
            Endif

            Thisform.chk_FileTimeStampOptimization.Caption  = loLang.C_USE_FILE_TIMESTAMP_OPTIMIZATION_LOC
            Thisform.lbl_title.Caption                      = loLang.C_CONVERT_FOLDER_QUESTION_LOC
            Thisform.cmd_Bin2Prg.Caption                    = loLang.C_BINARY_TO_TEXT_LOC
            Thisform.cmd_Prg2Bin.Caption                    = loLang.C_TEXT_TO_BINARY_LOC
            Thisform.cmd_None.Caption                       = loLang.C_CONVERT_FOLDER_NONE_LOC
         Endif

         Thisform.l_FileTimeStampOptimization = (toFoxBin2Prg.getCfgValue('n_OptimizeByFilestamp') <> 0)

         If Adir( laDirInfo, Forceext( toFoxBin2Prg.c_Foxbin2prg_FullPath, 'ICO' ) ) > 0 Then
            Thisform.Icon = Forceext( toFoxBin2Prg.c_Foxbin2prg_FullPath, 'ICO' )
         Endif
      Endif
   Endproc


   Procedure QueryUnload
      Thisform.n_ConversionType = 3
      Nodefault
      Thisform.do_selection()

   Endproc

   Procedure do_selection
      Thisform.Hide()
      Clear Events
   Endproc


   Procedure cmd_Bin2Prg.Click
      *-- Selección
      Thisform.n_ConversionType = 1
      Thisform.do_selection()
   Endproc


   Procedure cmd_Prg2Bin.Click
      *-- Selección
      Thisform.n_ConversionType = 2
      Thisform.do_selection()
   Endproc


   Procedure cmd_None.Click
      *-- Selección
      Thisform.n_ConversionType = 3
      Thisform.do_selection()
   Endproc


Enddefine
