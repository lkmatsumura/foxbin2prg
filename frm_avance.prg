
Define Class frm_avance As Form
    Height = 110
    Width = 628
    ShowWindow = 2
    DoCreate = .T.
    AllowOutput = .F.
    AutoCenter = .T.
    BorderStyle = 2
    ControlBox = .F.
    BackColor = Rgb(255,255,255)
    nMax_value = 100
    nMax_value2 = 100
    nSecsAtStart = (Seconds())
    nLastSecCount = 0
    nValue = 0
    nValue2 = 0
    l_Cancelled = .F.
    Name = "frm_avance"
    _MemberData = [<VFPData>] ;
        + [<memberdata name="updateprogressbar" display="updateProgressbar"/>] ;
        + [<memberdata name="width" display="Width"/>] ;
        + [<memberdata name="height" display="Height"/>] ;
        + [<memberdata name="nlastseccount" display="nLastSecCount"/>] ;
        + [<memberdata name="nsecsatstart" display="nSecsAtStart"/>] ;
        + [<memberdata name="nvalue2" display="nValue2"/>] ;
        + [<memberdata name="nvalue2_assign" display="nValue2_Assign"/>] ;
        + [<memberdata name="nvalue" display="nValue"/>] ;
        + [<memberdata name="nvalue_assign" display="nValue_assign"/>] ;
        + [<memberdata name="nmax_value" display="nMax_Value"/>] ;
        + [<memberdata name="nmax_value2" display="nMax_Value2"/>] ;
        + [<memberdata name="l_cancelled" display="l_Cancelled"/>] ;
        + [</VFPData>]

    Add Object shp_base As Shape With ;
        Top = 28, ;
        Left = 12, ;
        Height = 13, ;
        Width = 604, ;
        Curvature = 8, ;
        BorderWidth = 8, ;
        BackColor = 14215910, ;
        BorderColor = 14215910, ;
        Name = "shp_base"

    Add Object shp_avance As Shape With ;
        Top = 28, ;
        Left = 12, ;
        Height = 13, ;
        Width = 36, ;
        Curvature = 8, ;
        BackColor = 6734335, ;
        BorderColor = 10476031, ;
        BorderWidth = 1, ;
        Name = "shp_Avance"

    Add Object shp_base2 As Shape With ;
        Top = 64, ;
        Left = 12, ;
        Height = 13, ;
        Width = 604, ;
        Curvature = 8, ;
        BorderWidth = 0, ;
        BackColor = 14215910, ;
        BorderColor = 14215910, ;
        Name = "shp_base2"

    Add Object shp_avance2 As Shape With ;
        Top = 64, ;
        Left = 12, ;
        Height = 13, ;
        Width = 36, ;
        Curvature = 8, ;
        BackColor = 6734335, ;
        BorderColor = 10476031, ;
        BorderWidth = 1, ;
        Name = "shp_Avance2"

    Add Object cmdCancel As CommandButton With ;
        Top = 84, ;
        Left = 252, ;
        Height = 21, ;
        Width = 100, ;
        Caption = "Cancel", ;
        Enabled = .F., ;
        Name = "cmdCancel"

    Add Object lin_1 As Shape With ;
        Top = 28, ;
        Left = 32, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_1"

    Add Object lin_2 As Shape With ;
        Top = 28, ;
        Left = 52, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_2"

    Add Object lin_3 As Shape With ;
        Top = 28, ;
        Left = 72, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_3"

    Add Object lin_4 As Shape With ;
        Top = 28, ;
        Left = 92, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_4"

    Add Object lin_5 As Shape With ;
        Top = 28, ;
        Left = 112, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_5"

    Add Object lin_6 As Shape With ;
        Top = 28, ;
        Left = 132, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_6"

    Add Object lin_7 As Shape With ;
        Top = 28, ;
        Left = 152, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_7"

    Add Object lin_8 As Shape With ;
        Top = 28, ;
        Left = 172, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_8"

    Add Object lin_9 As Shape With ;
        Top = 28, ;
        Left = 192, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_9"

    Add Object lin_10 As Shape With ;
        Top = 28, ;
        Left = 212, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_10"

    Add Object lin_11 As Shape With ;
        Top = 28, ;
        Left = 232, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_11"

    Add Object lin_12 As Shape With ;
        Top = 28, ;
        Left = 252, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_12"

    Add Object lin_13 As Shape With ;
        Top = 28, ;
        Left = 272, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_13"

    Add Object lin_14 As Shape With ;
        Top = 28, ;
        Left = 292, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_14"

    Add Object lin_15 As Shape With ;
        Top = 28, ;
        Left = 312, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_15"

    Add Object lin_16 As Shape With ;
        Top = 28, ;
        Left = 332, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_16"

    Add Object lin_17 As Shape With ;
        Top = 28, ;
        Left = 352, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_17"

    Add Object lin_18 As Shape With ;
        Top = 28, ;
        Left = 372, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_18"

    Add Object lin_19 As Shape With ;
        Top = 28, ;
        Left = 392, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_19"

    Add Object lin_20 As Shape With ;
        Top = 28, ;
        Left = 412, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_20"

    Add Object lin_21 As Shape With ;
        Top = 28, ;
        Left = 432, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_21"

    Add Object lin_22 As Shape With ;
        Top = 28, ;
        Left = 452, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_22"

    Add Object lin_23 As Shape With ;
        Top = 28, ;
        Left = 472, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_23"

    Add Object lin_24 As Shape With ;
        Top = 28, ;
        Left = 492, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_24"

    Add Object lin_25 As Shape With ;
        Top = 28, ;
        Left = 512, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_25"

    Add Object lin_26 As Shape With ;
        Top = 28, ;
        Left = 532, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_26"

    Add Object lin_27 As Shape With ;
        Top = 28, ;
        Left = 552, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_27"

    Add Object lin_28 As Shape With ;
        Top = 28, ;
        Left = 572, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_28"

    Add Object lin_29 As Shape With ;
        Top = 28, ;
        Left = 592, ;
        Height = 53, ;
        Width = 0, ;
        BorderColor = 16777215, ;
        Name = "lin_29"

    Add Object lbl_tarea As Label With ;
        BackStyle = 0, ;
        Caption = ".", ;
        Height = 17, ;
        Left = 12, ;
        Top = 8, ;
        Width = 604, ;
        Name = "lbl_Tarea"

    Add Object lbl_tarea2 As Label With ;
        BackStyle = 0, ;
        Caption = ".", ;
        Height = 17, ;
        Left = 12, ;
        Top = 44, ;
        Width = 604, ;
        Name = "lbl_Tarea2"

    Add Object 'lblStartTime' As Label With ;
        BackStyle = 0, ;
        Caption = "Start time: __/__/____ __:__:__", ;
        Height = 17, ;
        Left = 12, ;
        Name = "lblStartTime", ;
        Top = 88, ;
        Width = 176

    Add Object 'lblElapsedTime' As Label With ;
        BackStyle = 0, ;
        Caption = "Elapsed Time: __:__:__", ;
        Height = 17, ;
        Left = 480, ;
        Name = "lblElapsedTime", ;
        Top = 88, ;
        Width = 136

    Procedure updateProgressbar
        Lparameters tcTexto, tnValor, tnTotal, tnTipo

        With Thisform As frm_avance Of foxbin2prg.prg
            Local lnSecs

            lnSecs  = Seconds()

            If lnSecs - .nLastSecCount > 0 Then
                .lblElapsedTime.Caption = 'Elapsed Time: ' + Ttoc( {^2000-1-1,00:00:00} + lnSecs - .nSecsAtStart, 2 )
                .nLastSecCount  = lnSecs
            Endif

*-- Habilita el botón de cancelar una vez que se comienzan a pasar valores
            If Not Empty(tnValor) Then
                If Not .cmdCancel.Enabled Then
                    .cmdCancel.Enabled = .T.
                Endif
                DoEvents
            Endif

            Do Case
                Case tnTipo = 0
                    If Not Empty(tcTexto) Then
                        .lbl_tarea.Caption      = tcTexto
                    Endif

                    .nValue2                = 0

                    If tnTotal > 0 Then
                        .nMax_value             = tnTotal
                        .nValue                 = tnValor
                    Endif

                Case tnTipo = 1
                    If Not Empty(tcTexto) Then
                        .lbl_tarea2.Caption     = tcTexto
                    Endif

                    If tnTotal > 0 Then
                        .nMax_value2            = tnTotal
                        .nValue2                = tnValor
                    Endif

                Case tnTipo = 2
                    If Not Empty(tcTexto) Then
                        .lbl_tarea2.Caption     = tcTexto
                    Endif

                    If tnTotal > 0 Then
                        .nMax_value2            = tnTotal
                        .nValue2                = tnValor
                    Endif

            Endcase
        Endwith && THIS

        Return
    Endproc


    Procedure nValue_assign
        Lparameters vNewVal

        With This
            .nValue = m.vNewVal
            .shp_avance.Width = m.vNewVal * .shp_base.Width / .nMax_value
        Endwith
    Endproc


    Procedure Init
        Lparameters toFoxBin2Prg

        #If .F.
            Local toFoxBin2Prg As c_foxbin2prg Of 'c_foxbin2prg.prg'
            Local Thisform As frm_avance Of foxbin2prg.prg
        #Endif

        Local laDirInfo(1,5), loLang As CL_LANG Of 'cl_lang.prg', lcBackgroundImage As String

        If Vartype(toFoxBin2Prg) = "O" Then
            If Type("_SCREEN.o_FoxBin2Prg_Lang") = "O" Then
                loLang                  = _Screen.o_FoxBin2Prg_Lang
                Thisform.Caption        = 'FoxBin2Prg ' + _Screen.c_FB2PRG_EXE_Version + ' > - ' + loLang.C_PROCESS_PROGRESS_LOC + '  (' + loLang.C_PRESS_ESC_TO_CANCEL + ')'
            Endif

            If File( Forceext( toFoxBin2Prg.c_Foxbin2prg_FullPath, 'ICO' ) ) Then
                Thisform.Icon = Forceext( toFoxBin2Prg.c_Foxbin2prg_FullPath, 'ICO' )
            Endif

            lcBackgroundImage = toFoxBin2Prg.getCfgValue('c_BackgroundImage')
            If File( m.lcBackgroundImage ) Then
                Clear Resources
                Thisform.Picture = m.lcBackgroundImage
            Endif
        Endif

        Thisform.nValue         = 0
        Thisform.nValue2        = 0
        Thisform.nLastSecCount  = Seconds()
    Endproc


    Procedure nValue2_assign
        Lparameters vNewVal

        With This
            .nValue2 = m.vNewVal
            .shp_avance2.Width = m.vNewVal * .shp_base2.Width / .nMax_value2
        Endwith
    Endproc


    Procedure cmdCancel.Click
        Thisform.l_Cancelled = .T.
    Endproc


    Procedure lblStartTime.Init
        This.Caption = "Start Time: " + Ttoc(Datetime())
    Endproc

Enddefine
