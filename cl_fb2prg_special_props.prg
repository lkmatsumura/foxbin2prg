#INCLUDE foxbin2prg.h

DEFINE CLASS cl_fb2prg_special_props AS Custom

   DIMENSION a_SpecialProps(1)     , a_SpecialProps_Chk(1) , a_SpecialProps_Coll(1) ;
           , a_SpecialProps_Cbo(1) , a_SpecialProps_Cmg(1) , a_SpecialProps_Cmd(1)  ;
           , a_SpecialProps_Cur(1) , a_SpecialProps_CA(1)  , a_SpecialProps_DE(1)   ;
           , a_SpecialProps_Edt(1) , a_SpecialProps_Frs(1) , a_SpecialProps_Grc(1)  ;
           , a_SpecialProps_Grh(1) , a_SpecialProps_Hlk(1) , a_SpecialProps_Img(1)  ;
           , a_SpecialProps_Lbl(1) , a_SpecialProps_Lin(1) , a_SpecialProps_Lst(1)  ;
           , a_SpecialProps_Ole(1) , a_SpecialProps_Opg(1) , a_SpecialProps_Opb(1)  ;
           , a_SpecialProps_Phk(1) , a_SpecialProps_Rel(1) , a_SpecialProps_Rls(1)  ;
           , a_SpecialProps_Sep(1) , a_SpecialProps_Shp(1) , a_SpecialProps_Spn(1)  ;
           , a_SpecialProps_Txt(1) , a_SpecialProps_Tmr(1)

   DIMENSION a_SpecialProps_XMLAda(1) ;
           , a_SpecialProps_XMLFld(1) ;
           , a_SpecialProps_XMLTbl(1)

   DIMENSION a_SpecialPropsFiles(1)

   l_Loaded    = .F.
   c_Foxbin2prg_FullPath = ''


   PROCEDURE Init
      LPARAMETERS tcFoxbin2prg_FullPath

      IF ! Empty( tcFoxbin2prg_FullPath )
         This.c_Foxbin2prg_FullPath = tcFoxbin2prg_FullPath
      ENDIF

      This.SpecialProps_Init()
   ENDPROC


   FUNCTION getPropSortIndex
      *--------------------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tcBaseClass               (v! IN    ) BaseClass del objeto o clase evaluada
      * tcPropName                (v! IN    ) Nombre de la propiedad
      *--------------------------------------------------------------------------------------------------------------
      LPARAMETERS tcBaseClass, tcPropName
      LOCAL lnArray, lcPropsArray, lnPos

      lnArray = Ascan( This.a_SpecialPropsFiles, Lower( Alltrim(tcBaseClass) ), 1, 0, 3, 2+4+8 )
      IF lnArray = 0
         lnArray = Ascan( This.a_SpecialPropsFiles, 'all', 1, 0, 3, 2+4+8 )
      ENDIF
      lcPropsArray = This.a_SpecialPropsFiles[ lnArray, 2 ]
      lnPos = Ascan( This.&lcPropsArray, tcPropName, 1, 0, 1, 1+2+4 )

      RETURN lnPos
   ENDFUNC


   PROCEDURE SpecialProps_Init
      IF This.l_Loaded
         RETURN
      ENDIF
      LOCAL loEx AS Exception
      LOCAL lcMethod, lnI, lcProperty

      lcMethod = ''

      TRY

         WITH This AS cl_fb2prg_special_props OF 'cl_fb2prg_special_props.prg'
            .SpecialPropsFiles_Add( "getprops_all"                , "a_SpecialProps"        , "all"             )
            .SpecialPropsFiles_Add( "getprops_checkbox"           , "a_SpecialProps_Chk"    , "checkbox"        )
            .SpecialPropsFiles_Add( "getprops_collection"         , "a_SpecialProps_Coll"   , "collection"      )
            .SpecialPropsFiles_Add( "getprops_combobox"           , "a_SpecialProps_Cbo"    , "combobox"        )
            .SpecialPropsFiles_Add( "getprops_commandgroup"       , "a_SpecialProps_Cmg"    , "commandgroup"    )
            .SpecialPropsFiles_Add( "getprops_commandbutton"      , "a_SpecialProps_Cmd"    , "commandbutton"   )
            .SpecialPropsFiles_Add( "getprops_cursor"             , "a_SpecialProps_Cur"    , "cursor"          )
            .SpecialPropsFiles_Add( "getprops_cursoradapter"      , "a_SpecialProps_CA"     , "cursoradapter"   )
            .SpecialPropsFiles_Add( "getprops_dataenvironment"    , "a_SpecialProps_DE"     , "dataenvironment" )
            .SpecialPropsFiles_Add( "getprops_editbox"            , "a_SpecialProps_Edt"    , "editbox"         )
            .SpecialPropsFiles_Add( "getprops_formset"            , "a_SpecialProps_Frs"    , "formset"         )
            .SpecialPropsFiles_Add( "getprops_grid_column"        , "a_SpecialProps_Grc"    , "column"          )
            .SpecialPropsFiles_Add( "getprops_grid_header"        , "a_SpecialProps_Grh"    , "header"          )
            .SpecialPropsFiles_Add( "getprops_hyperlink"          , "a_SpecialProps_Hlk"    , "hyperlink"       )
            .SpecialPropsFiles_Add( "getprops_image"              , "a_SpecialProps_Img"    , "image"           )
            .SpecialPropsFiles_Add( "getprops_label"              , "a_SpecialProps_Lbl"    , "label"           )
            .SpecialPropsFiles_Add( "getprops_line"               , "a_SpecialProps_Lin"    , "line"            )
            .SpecialPropsFiles_Add( "getprops_listbox"            , "a_SpecialProps_Lst"    , "listbox"         )
            .SpecialPropsFiles_Add( "getprops_olebound"           , "a_SpecialProps_Ole"    , "olebound"        )
            .SpecialPropsFiles_Add( "getprops_optiongroup"        , "a_SpecialProps_Opg"    , "optiongroup"     )
            .SpecialPropsFiles_Add( "getprops_optiongroup_option" , "a_SpecialProps_Opb"    , "optionbutton"    )
            .SpecialPropsFiles_Add( "getprops_projecthook"        , "a_SpecialProps_Phk"    , "projecthook"     )
            .SpecialPropsFiles_Add( "getprops_relation"           , "a_SpecialProps_Rel"    , "relation"        )
            .SpecialPropsFiles_Add( "getprops_reportlistener"     , "a_SpecialProps_Rls"    , "reportlistener"  )
            .SpecialPropsFiles_Add( "getprops_separator"          , "a_SpecialProps_Sep"    , "separator"       )
            .SpecialPropsFiles_Add( "getprops_shape"              , "a_SpecialProps_Shp"    , "shape"           )
            .SpecialPropsFiles_Add( "getprops_spinner"            , "a_SpecialProps_Spn"    , "spinner"         )
            .SpecialPropsFiles_Add( "getprops_textbox"            , "a_SpecialProps_Txt"    , "textbox"         )
            .SpecialPropsFiles_Add( "getprops_timer"              , "a_SpecialProps_Tmr"    , "timer"           )
            .SpecialPropsFiles_Add( "getprops_xmladapter"         , "a_SpecialProps_XMLAda" , "xmladapter"      )
            .SpecialPropsFiles_Add( "getprops_xmlfield"           , "a_SpecialProps_XMLFld" , "xmlfield"        )
            .SpecialPropsFiles_Add( "getprops_xmltable"           , "a_SpecialProps_XMLTbl" , "xmltable"        )

            FOR lnI = 1 TO Alen( .a_SpecialPropsFiles, 1 )
               lcMethod   = .a_SpecialPropsFiles( lnI, 1 )
               lcProperty = .a_SpecialPropsFiles( lnI, 2 )
               =Alines( .&lcProperty, Evaluate( 'This.' + lcMethod + '()' ), 1+4 )
            ENDFOR

            .l_Loaded = .T.
         ENDWITH

      CATCH TO loEx
         loEx.UserValue = 'lcMethod = ' + lcMethod
         THROW
      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE SpecialPropsFiles_Add
      LPARAMETERS pcMethod, pcPropArrayName, pcBaseClass
      LOCAL lnI

      IF Alen( This.a_SpecialPropsFiles ) = 1
         lnI = 1
      ELSE
         lnI = Alen( This.a_SpecialPropsFiles, 1 ) + 1
      ENDIF

      DIMENSION This.a_SpecialPropsFiles[ lnI, 3 ]

      This.a_SpecialPropsFiles[ lnI, 1 ] = pcMethod
      This.a_SpecialPropsFiles[ lnI, 2 ] = pcPropArrayName
      This.a_SpecialPropsFiles[ lnI, 3 ] = Lower( pcBaseClass )

      RETURN lnI
   ENDPROC

   PROCEDURE getprops_all
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         DEClassLibrary
         DEClass
         DataSession
         ScaleMode
         ErasePage
         AutoSize
         MemberClassLibrary
         MemberClass
         PageCount
         ColumnCount
         ButtonCount
         TabStretch
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Desktop
         ShowWindow
         ScrollBars
         ShowInTaskBar
         DoCreate
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         TabStyle
         ShowTips
         BufferMode
         Picture
         ControlBox
         Closable
         ActivePage
         Top
         Left
         Height
         Width
         AutoCenter
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         DateFormat
         DateMark
         Century
         Hours
         Seconds
         StrictDateEntry
         Anchor
         HalfHeightCaption
         MaxButton
         MinButton
         Tabs
         Movable
         MaxHeight
         MaxWidth
         MinHeight
         MinWidth
         MaxTop
         MaxLeft
         MaxLength
         WordWrap
         Stretch
         DownPicture
         DisabledPicture
         PicturePosition
         PictureMargin
         PictureSpacing
         MDIForm
         AddLineFeeds
         ClipControls
         HeaderClassLibrary
         HeaderClass
         Alignment
         AllowTabs
         Centered
         BackStyle
         BorderStyle
         BorderWidth
         BoundColumn
         Curvature
         PictureSelectionDisplay
         Caption
         Bound
         ColumnOrder
         DrawMode
         DrawStyle
         DrawWidth
         ColumnCount
         ColumnWidths
         RowSourceType
         RowSource
         DisplayValue
         Value
         ControlSource
         CurrentControl
         AllowAddNew
         AllowHeaderSizing
         AllowRowSizing
         ChildOrder
         DeleteMark
         Cancel
         Default
         Enabled
         KeySort
         FillStyle
         Icon
         KeyPreview
         TitleBar
         WindowType
         WindowState
         LockScreen
         AlwaysOnTop
         AlwaysOnBottom
         SizeBox
         ZoomBox
         Resizable
         GridLines
         GridLineWidth
         HeaderHeight
         FirstElement
         Format
         HelpContextID
         WhatsThisHelpID
         WhatsThisHelp
         WhatsThisButton
         RightToLeft
         DefOleLCID
         MacDesktop
         Highlight
         HighlightRow
         HighlightRowLineWidth
         HideSelection
         ColumnLines
         IncrementalSearch
         Increment
         InputMask
         KeyboardHighValue
         KeyboardLowValue
         HostName
         AutoVerbMenu
         AutoActivate
         LinkMaster
         Margin
         MaxLength
         MousePointer
         MouseIcon
         Panel
         PanelLink
         ReadOnly
         RecordMark
         RecordSource
         RecordSourceType
         RelationalExpr
         RowHeight
         Sparse
         SelectOnEntry
         DynamicBackColor
         DynamicForeColor
         DynamicFontBold
         DynamicFontItalic
         DynamicFontName
         DynamicFontOutline
         DynamicFontSize
         DynamicFontShadow
         DynamicFontStrikethru
         DynamicFontUnderline
         DynamicAlignment
         DynamicCurrentControl
         DynamicInputMask
         MoverBars
         MultiSelect
         NumberOfElements
         SelectOnEntry
         Sorted
         SpecialEffect
         PageOrder
         TabOrientation
         SpinnerHighValue
         SpinnerLowValue
         StatusBarText
         Style
         TabIndex
         TabStop
         TerminateRead
         ToolTipText
         WordWrap
         Sizable
         Interval
         BufferMode
         AutoRelease
         Visible
         MemoWindow
         OpenWindow
         PasswordChar
         EnableHyperlinks
         PicturePosition
         PictureMargin
         PictureSpacing
         LineSlant
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         FillColor
         BorderColor
         WordWrap
         SplitBar
         View
         WindowList
         ReadSave
         ReadTimeout
         ReadMouse
         ReadCycle
         ReadLock
         PolyPoints
         Partition
         GridLineColor
         HighlightBackColor
         HighlightForeColor
         ItemForeColor
         ItemBackColor
         DisabledItemBackColor
         DisabledBackColor
         SelectedForeColor
         DisabledForeColor
         SelectedBackColor
         ItemForeColor
         ItemBackColor
         DisabledItemBackColor
         SelectedItemForeColor
         SelectedItemBackColor
         DisabledItemForeColor
         RightToLeft
         LockColumns
         LockColumnsLeft
         AllowAutoColumnFit
         AllowCellSelection
         RightToLeft
         NullDisplay
         IntegralHeight
         ItemTips
         BoundTo
         IMEMode
         Rotation
         DisplayCount
         OLEDropTextInsertion
         HScrollSmallChange
         VScrollSmallChange
         ContinuousScroll
         Themes
         AutoHideScrollbar
         AutoComplete
         AutoCompSource
         AutoCompTable
         BindControls
         AllowOutput
         Dockable
         Optimize
         UseDeDataSource
         SelectCmd
         UpdateCmd
         InsertCmd
         DeleteCmd
         AllowUpdate
         AllowInsert
         AllowDelete
         CursorSchema
         Alias
         BufferModeOverride
         DataSource
         DataSourceType
         InsertCmdDataSource
         InsertCmdDataSourceType
         UpdateCmdDataSource
         UpdateCmdDataSourceType
         DeleteCmdDataSource
         DeleteCmdDataSourceType
         Flags
         CompareMemo
         OpenViews
         AutoOpenTables
         AutoCloseTables
         InitialSelectedAlias
         DataSource
         DataSourceType
         Order
         OrderDirection
         Database
         CursorSource
         Exclusive
         Filter
         NoDataOnLoad
         FetchAsNeeded
         FetchMemo
         Prepared
         SendUpdates
         BatchUpdateCount
         FetchSize
         MaxRecords
         UseMemoSize
         UpdateType
         WhereType
         KeyFieldList
         Tables
         UpdatableFieldList
         UpdateNameList
         ConversionFunc
         AllowSimultaneousFetch
         BreakOnError
         UpdateGramSchemaLocation
         ConflictCheckType
         ConflictCheckCmd
         PreserveWhiteSpace
         MapN19_4ToCurrency
         IsDiffgram
         XMLName
         XMLNamespace
         XMLPrefix
         XSDtype
         XSDtotalDigits
         XSDfractionDigits
         XSDmaxLength
         IsAttribute
         DataType
         FractionDigits
         NoCpTrans
         Unicode
         IsNull
         IsBinary
         IsBase64
         WrapInCDATA
         DisableEncode
         Keyfield
         ChildTable
         NestedInto
         FirstNestedTable
         NextSiblingTable
         FormattedOutput
         ForceCloseTag
         RespectCursorCP
         UTF8Encoded
         XMLSchemaLocation
         WrapMemoInCDATA
         WrapCharInCDATA
         Unicode
         MapVarchar
         MapBinary
         RespectNesting
         SelectionNamespaces
         XMLNameIsXPath
         DeclareXMLPrefix
         CurrentPass
         TwoPassProcess
         FRXDataSession
         PreviewContainer
         DynamicLineHeight
         CommandClauses
         AllowModalMessages
         QuietMode
         CurrentDataSession
         SendGDIPlusImage
         PrintJobName
         CallAdjustObjectSize
         CallEvaluateContents
         ParentAlias
         RelationalExpr
         ChildAlias
         ChildOrder
         OneToMany
         UseCursorSchema
         NoData
         TimestampFieldList
         InsertCmdRefreshFieldList
         InsertCmdRefreshKeyFieldList
         UpdateCmdRefreshFieldList
         UpdateCmdRefreshKeyFieldList
         RefreshTimestamp
         RefreshCmd
         RefreshCmdDataSource
         RefreshCmdDataSourceType
         InsertCmdRefreshCmd
         UpdateCmdRefreshCmd
         RefreshIgnoreFieldList
         FetchMemoDataSource
         FetchMemoDataSourceType
         FetchMemoCmdList
         UseTransactions
         ADOCodePage
         CodePage
         UseCodePage
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_checkbox
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Top
         Left
         Height
         Width
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         WordWrap
         AutoSize
         Picture
         DownPicture
         DisabledPicture
         Alignment
         Centered
         BackStyle
         Caption
         Value
         ControlSource
         Enabled
         HelpContextID
         WhatsThisHelpID
         MousePointer
         MouseIcon
         SpecialEffect
         StatusBarText
         Style
         TabStop
         ToolTipText
         TerminateRead
         Visible
         PicturePosition
         PictureMargin
         PictureSpacing
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         DisabledForeColor
         DisabledBackColor
         RightToLeft
         ReadOnly
         Themes
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_collection
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Top
         Left
         Height
         Width
         KeySort
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_combobox
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         MaxLength
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Alignment
         BoundColumn
         Picture
         PictureSelectionDisplay
         ColumnCount
         ColumnWidths
         RowSourceType
         RowSource
         DisplayValue
         Value
         ControlSource
         Enabled
         FirstElement
         Height
         HelpContextID
         WhatsThisHelpID
         ColumnLines
         IncrementalSearch
         Left
         Margin
         MousePointer
         MouseIcon
         NumberOfElements
         SelectOnEntry
         Sorted
         SpecialEffect
         StatusBarText
         Style
         TabIndex
         TabStop
         TerminateRead
         ToolTipText
         Top
         Visible
         Width
         RightToLeft
         HideSelection
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         SelectedForeColor
         ItemForeColor
         ItemBackColor
         SelectedItemForeColor
         DisabledItemBackColor
         DisabledBackColor
         DisabledForeColor
         SelectedBackColor
         SelectedItemBackColor
         DisabledItemForeColor
         BorderColor
         NullDisplay
         Format
         InputMask
         ItemTips
         BorderStyle
         BoundTo
         IMEMode
         ReadOnly
         DisplayCount
         OLEDropTextInsertion
         Themes
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_commandgroup
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         AutoSize
         MemberClassLibrary
         MemberClass
         ButtonCount
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         Anchor
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Top
         Left
         Height
         Width
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         BackStyle
         BorderStyle
         Value
         ControlSource
         WordWrap
         Picture
         DownPicture
         DisabledPicture
         Cancel
         Caption
         Default
         Enabled
         HelpContextID
         WhatsThisHelpID
         MousePointer
         MouseIcon
         SpecialEffect
         Style
         TabIndex
         TabStop
         TerminateRead
         Visible
         PicturePosition
         PictureMargin
         PictureSpacing
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         BorderColor
         DisabledForeColor
         DisabledBackColor
         RightToLeft
         ToolTipText
         StatusBarText
         Themes
         Alignment
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_commandbutton
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         AutoSize
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Top
         Left
         Height
         Width
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         WordWrap
         Picture
         DownPicture
         DisabledPicture
         Cancel
         Caption
         Default
         Enabled
         HelpContextID
         WhatsThisHelpID
         MousePointer
         MouseIcon
         StatusBarText
         Style
         TabIndex
         TabStop
         ToolTipText
         TerminateRead
         Visible
         SpecialEffect
         PicturePosition
         PictureMargin
         PictureSpacing
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         DisabledForeColor
         DisabledBackColor
         RightToLeft
         Themes
         Alignment
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_cursor
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Top
         Left
         Height
         Width
         Alias
         BufferModeOverride
         Order
         OrderDirection
         Database
         CursorSource
         Exclusive
         Filter
         ReadOnly
         NoDataOnLoad
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_cursoradapter
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Height
         Width
         UseDeDataSource
         SelectCmd
         UpdateCmd
         InsertCmd
         DeleteCmd
         AllowUpdate
         AllowInsert
         AllowDelete
         CursorSchema
         Alias
         BufferModeOverride
         DataSource
         DataSourceType
         InsertCmdDataSource
         InsertCmdDataSourceType
         UpdateCmdDataSource
         UpdateCmdDataSourceType
         DeleteCmdDataSource
         DeleteCmdDataSourceType
         Flags
         CompareMemo
         FetchAsNeeded
         FetchMemo
         Prepared
         SendUpdates
         BatchUpdateCount
         FetchSize
         MaxRecords
         UseMemoSize
         UpdateType
         WhereType
         KeyFieldList
         Tables
         UpdatableFieldList
         UpdateNameList
         ConversionFunc
         AllowSimultaneousFetch
         BreakOnError
         UpdateGramSchemaLocation
         ConflictCheckType
         ConflictCheckCmd
         MapVarchar
         MapBinary
         UseCursorSchema
         NoData
         TimestampFieldList
         InsertCmdRefreshFieldList
         InsertCmdRefreshKeyFieldList
         UpdateCmdRefreshFieldList
         UpdateCmdRefreshKeyFieldList
         RefreshTimestamp
         RefreshCmd
         RefreshCmdDataSource
         RefreshCmdDataSourceType
         InsertCmdRefreshCmd
         UpdateCmdRefreshCmd
         RefreshIgnoreFieldList
         FetchMemoDataSource
         FetchMemoDataSourceType
         FetchMemoCmdList
         UseTransactions
         ADOCodePage
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_dataenvironment
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Top
         Left
         Width
         Height
         OpenViews
         AutoOpenTables
         AutoCloseTables
         InitialSelectedAlias
         DataSource
         DataSourceType
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_editbox
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         DefTop
         DefLeft
         DefHeight
         DefWidth
         AddLineFeeds
         Alignment
         AllowTabs
         BackStyle
         BorderStyle
         Enabled
         Format
         Height
         HelpContextID
         WhatsThisHelpID
         HideSelection
         Left
         Margin
         MaxLength
         MousePointer
         MouseIcon
         ReadOnly
         ScrollBars
         SelectOnEntry
         SpecialEffect
         StatusBarText
         TabIndex
         TabStop
         TerminateRead
         ToolTipText
         Top
         Visible
         Width
         PasswordChar
         EnableHyperlinks
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         DisabledBackColor
         SelectedForeColor
         DisabledForeColor
         SelectedBackColor
         BorderColor
         Value
         ControlSource
         RightToLeft
         NullDisplay
         IntegralHeight
         IMEMode
         OLEDropTextInsertion
         Themes
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_formset
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         DataSession
         Comment
         Tag
         BufferMode
         AutoRelease
         Visible
         WindowList
         WindowType
         ReadSave
         ReadTimeout
         ReadMouse
         ReadCycle
         ReadLock
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_grid_column
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         HeaderClassLibrary
         HeaderClass
         Alignment
         Bound
         ColumnOrder
         ControlSource
         CurrentControl
         Enabled
         Width
         Movable
         Resizable
         ReadOnly
         Sparse
         Visible
         SelectOnEntry
         DynamicBackColor
         DynamicForeColor
         DynamicFontBold
         DynamicFontItalic
         DynamicFontName
         DynamicFontOutline
         DynamicFontSize
         DynamicFontShadow
         DynamicFontStrikethru
         DynamicFontUnderline
         DynamicAlignment
         DynamicCurrentControl
         DynamicInputMask
         Format
         InputMask
         ForeColor
         BackColor
         ToolTipText
         StatusBarText
         MousePointer
         MouseIcon
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_grid_header
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Alignment
         Caption
         ForeColor
         BackColor
         Picture
         WordWrap
         ToolTipText
         StatusBarText
         MousePointer
         MouseIcon
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_hyperlink
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Top
         Left
         Height
         Width
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_image
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         Anchor
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Picture
         Stretch
         BackStyle
         BorderStyle
         Enabled
         Height
         HelpContextID
         WhatsThisHelpID
         Left
         MousePointer
         MouseIcon
         Top
         Visible
         Width
         ColorSource
         BorderColor
         ToolTipText
         StatusBarText
         Themes
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_label
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         AutoSize
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         WordWrap
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Alignment
         BackStyle
         BorderStyle
         Caption
         Height
         HelpContextID
         WhatsThisHelpID
         Left
         MousePointer
         MouseIcon
         Top
         Visible
         Width
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         DisabledForeColor
         DisabledBackColor
         RightToLeft
         ToolTipText
         StatusBarText
         Style
         Rotation
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_line
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         Anchor
         DefTop
         DefLeft
         DefHeight
         DefWidth
         BorderStyle
         BorderWidth
         DrawMode
         Height
         HelpContextID
         WhatsThisHelpID
         Left
         MousePointer
         MouseIcon
         Top
         Visible
         Width
         LineSlant
         ColorSource
         BorderColor
         ToolTipText
         StatusBarText
         PolyPoints
         Rotation
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_listbox
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         DragMode
         DragIcon
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         DefTop
         DefLeft
         DefHeight
         DefWidth
         BoundColumn
         Picture
         ColumnCount
         ColumnWidths
         RowSourceType
         RowSource
         Value
         ControlSource
         Enabled
         FirstElement
         Height
         HelpContextID
         WhatsThisHelpID
         ColumnLines
         IncrementalSearch
         Left
         MousePointer
         MouseIcon
         MoverBars
         MultiSelect
         NumberOfElements
         Sorted
         SpecialEffect
         StatusBarText
         TabIndex
         TabStop
         TerminateRead
         ToolTipText
         Top
         Visible
         Width
         ColorSource
         ColorScheme
         DisabledBackColor
         ItemForeColor
         ItemBackColor
         DisabledItemBackColor
         SelectedItemForeColor
         SelectedItemBackColor
         DisabledItemForeColor
         DisabledForeColor
         BorderColor
         RightToLeft
         IntegralHeight
         NullDisplay
         ItemTips
         BoundTo
         Themes
         AutoHideScrollbar
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_olebound
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         DragMode
         DragIcon
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Top
         Left
         Height
         Width
         Visible
         Enabled
         TabStop
         Anchor
         ControlSource
         Stretch
         MousePointer
         MouseIcon
         AutoSize
         Sizable
         HelpContextID
         WhatsThisHelpID
         HostName
         AutoVerbMenu
         AutoActivate
         ToolTipText
         StatusBarText
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_optiongroup
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         AutoSize
         MemberClassLibrary
         MemberClass
         ButtonCount
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         Picture
         DownPicture
         DisabledPicture
         PicturePosition
         PictureMargin
         PictureSpacing
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Alignment
         BackStyle
         BorderStyle
         Caption
         Value
         ControlSource
         Enabled
         Height
         HelpContextID
         WhatsThisHelpID
         Left
         MousePointer
         MouseIcon
         SpecialEffect
         StatusBarText
         Style
         TabIndex
         TabStop
         TerminateRead
         ToolTipText
         Top
         Width
         WordWrap
         TabIndex
         Visible
         AutoSize
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         BorderColor
         DisabledForeColor
         DisabledBackColor
         RightToLeft
         ToolTipText
         StatusBarText
         Themes
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_optiongroup_option
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         Picture
         DownPicture
         DisabledPicture
         PicturePosition
         PictureMargin
         PictureSpacing
         DefTop
         DefWidth
         Alignment
         BackStyle
         Caption
         Value
         ControlSource
         Enabled
         Height
         HelpContextID
         WhatsThisHelpID
         Left
         MousePointer
         MouseIcon
         SpecialEffect
         StatusBarText
         Style
         TabIndex
         TabStop
         TerminateRead
         ToolTipText
         Top
         Visible
         Width
         WordWrap
         AutoSize
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         DisabledForeColor
         DisabledBackColor
         RightToLeft
         Themes
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_projecthook
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Height
         Width
         OLEDropMode
         OLEDropEffects
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_relation
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Height
         Width
         ParentAlias
         RelationalExpr
         ChildAlias
         ChildOrder
         OneToMany
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_reportlistener
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Height
         Width
         CurrentPass
         TwoPassProcess
         FRXDataSession
         PreviewContainer
         DynamicLineHeight
         CommandClauses
         AllowModalMessages
         QuietMode
         CurrentDataSession
         SendGDIPlusImage
         PrintJobName
         CallAdjustObjectSize
         CallEvaluateContents
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_separator
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Top
         Left
         Height
         Width
         Enabled
         Style
         Visible
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_shape
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Top
         Left
         Height
         Width
         Anchor
         BackStyle
         BorderStyle
         BorderWidth
         Curvature
         DrawMode
         FillStyle
         HelpContextID
         WhatsThisHelpID
         MousePointer
         MouseIcon
         ToolTipText
         StatusBarText
         Visible
         SpecialEffect
         ColorSource
         ColorScheme
         BackColor
         FillColor
         BorderColor
         Style
         PolyPoints
         Rotation
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_spinner
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         Anchor
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Alignment
         BorderStyle
         Enabled
         Height
         HelpContextID
         WhatsThisHelpID
         HideSelection
         Increment
         InputMask
         KeyboardHighValue
         KeyboardLowValue
         Left
         Margin
         MousePointer
         MouseIcon
         ReadOnly
         SelectOnEntry
         SpecialEffect
         SpinnerHighValue
         SpinnerLowValue
         StatusBarText
         TabIndex
         TabStop
         TerminateRead
         ToolTipText
         Top
         Visible
         Width
         Format
         ColorSource
         ColorScheme
         BackColor
         ForeColor
         DisabledBackColor
         SelectedForeColor
         DisabledForeColor
         SelectedBackColor
         BorderColor
         Value
         ControlSource
         RightToLeft
         NullDisplay
         OLEDropTextInsertion
         Themes
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_textbox
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         OLEDragMode
         OLEDragPicture
         OLEDropMode
         OLEDropEffects
         DragMode
         DragIcon
         FontBold
         FontItalic
         FontName
         FontOutline
         FontShadow
         FontSize
         FontStrikethru
         FontUnderline
         FontCondense
         FontExtend
         FontCharSet
         DateFormat
         DateMark
         Century
         Hours
         Seconds
         StrictDateEntry
         Anchor
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Alignment
         BackStyle
         BorderStyle
         Value
         ControlSource
         Enabled
         Format
         Height
         HelpContextID
         WhatsThisHelpID
         HideSelection
         InputMask
         Left
         Margin
         MaxLength
         MousePointer
         MouseIcon
         ReadOnly
         SelectOnEntry
         SpecialEffect
         StatusBarText
         TabIndex
         TabStop
         TerminateRead
         ToolTipText
         Top
         Visible
         Width
         Style
         MemoWindow
         OpenWindow
         PasswordChar
         EnableHyperlinks
         ColorSource
         ColorScheme
         ForeColor
         BackColor
         DisabledBackColor
         SelectedForeColor
         DisabledForeColor
         SelectedBackColor
         BorderColor
         RightToLeft
         NullDisplay
         IntegralHeight
         IMEMode
         OLEDropTextInsertion
         Themes
         AutoComplete
         AutoCompSource
         AutoCompTable
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_timer
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         DefTop
         DefLeft
         DefHeight
         DefWidth
         Top
         Left
         Height
         Width
         Enabled
         Interval
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_xmladapter
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Height
         Width
         PreserveWhiteSpace
         NoCpTrans
         MapN19_4ToCurrency
         DisableEncode
         IsDiffgram
         XMLName
         XMLNamespace
         XMLPrefix
         FormattedOutput
         ForceCloseTag
         RespectCursorCP
         UTF8Encoded
         XMLSchemaLocation
         WrapMemoInCDATA
         WrapCharInCDATA
         Unicode
         MapVarchar
         MapBinary
         RespectNesting
         SelectionNamespaces
         XMLNameIsXPath
         DeclareXMLPrefix
         CodePage
         UseCodePage
         Name
         ***XMLField********
         XSDtype
         XSDtotalDigits
         XSDfractionDigits
         XSDmaxLength
         IsAttribute
         DataType
         MaxLength
         FractionDigits
         NoCpTrans
         Unicode
         IsNull
         IsBinary
         IsBase64
         WrapInCDATA
         DisableEncode
         Keyfield
         Name
         ***XMLTable*******
         ChildTable
         NestedInto
         FirstNestedTable
         NextSiblingTable
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_xmlfield
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Height
         Width
         Alias
         XMLName
         XSDtype
         XSDtotalDigits
         XSDfractionDigits
         XSDmaxLength
         IsAttribute
         DataType
         MaxLength
         FractionDigits
         NoCpTrans
         Unicode
         IsNull
         IsBinary
         IsBase64
         WrapInCDATA
         DisableEncode
         Keyfield
         XMLNameIsXPath
         CodePage
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

   PROCEDURE getprops_xmltable
      LOCAL lcProps
      TEXT TO lcProps TEXTMERGE NOSHOW FLAGS 1 PRETEXT 7
         Comment
         Tag
         Height
         Width
         Alias
         XMLName
         XMLNamespace
         XMLPrefix
         ChildTable
         NestedInto
         FirstNestedTable
         NextSiblingTable
         XMLNameIsXPath
         DeclareXMLPrefix
         CodePage
         Name
      ENDTEXT
      RETURN lcProps
   ENDPROC

ENDDEFINE
