#INCLUDE foxbin2prg.h

DEFINE CLASS cl_fb2prg_special_props AS Custom

   DIMENSION a_SpecialProps(1)     , a_SpecialProps_Chk(1) , a_SpecialProps_Coll(1) ;
           , a_SpecialProps_Cbo(1) , a_SpecialProps_Cmg(1) , a_SpecialProps_Cmd(1)  ;
           , a_SpecialProps_Cur(1) , a_SpecialProps_CA(1)  , a_SpecialProps_DE(1)   ;
           , a_SpecialProps_Edt(1) , a_SpecialProps_Frs(1) , a_SpecialProps_Grd(1)  ;
           , a_SpecialProps_Grc(1) , a_SpecialProps_Grh(1) , a_SpecialProps_Hlk(1)  ;
           , a_SpecialProps_Img(1) , a_SpecialProps_Lbl(1) , a_SpecialProps_Lin(1)  ;
           , a_SpecialProps_Lst(1) , a_SpecialProps_Ole(1) , a_SpecialProps_Opg(1)  ;
           , a_SpecialProps_Opb(1) , a_SpecialProps_Phk(1) , a_SpecialProps_Rel(1)  ;
           , a_SpecialProps_Rls(1) , a_SpecialProps_Sep(1) , a_SpecialProps_Shp(1)  ;
           , a_SpecialProps_Spn(1) , a_SpecialProps_Txt(1) , a_SpecialProps_Tmr(1)  ;
           , a_SpecialProps_Tbr(1)

   DIMENSION a_SpecialProps_XMLAda(1) ;
           , a_SpecialProps_XMLFld(1) ;
           , a_SpecialProps_XMLTbl(1)

   DIMENSION a_SpecialPropsFiles(1)

   l_Loaded    = .F.
   c_PropsDir  = 'props\'
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
      LOCAL lcPropsFile, lcPropsDir, lnI, lcProperty

      lcPropsFile = ''

      TRY

         WITH This AS cl_fb2prg_special_props OF 'cl_fb2prg_special_props.prg'
            .SpecialPropsFiles_Add( "props_all.txt"                , "a_SpecialProps"        , "all"             )
            .SpecialPropsFiles_Add( "props_checkbox.txt"           , "a_SpecialProps_Chk"    , "checkbox"        )
            .SpecialPropsFiles_Add( "props_collection.txt"         , "a_SpecialProps_Coll"   , "collection"      )
            .SpecialPropsFiles_Add( "props_combobox.txt"           , "a_SpecialProps_Cbo"    , "combobox"        )
            .SpecialPropsFiles_Add( "props_commandgroup.txt"       , "a_SpecialProps_Cmg"    , "commandgroup"    )
            .SpecialPropsFiles_Add( "props_commandbutton.txt"      , "a_SpecialProps_Cmd"    , "commandbutton"   )
            .SpecialPropsFiles_Add( "props_cursor.txt"             , "a_SpecialProps_Cur"    , "cursor"          )
            .SpecialPropsFiles_Add( "props_cursoradapter.txt"      , "a_SpecialProps_CA"     , "cursoradapter"   )
            .SpecialPropsFiles_Add( "props_dataenvironment.txt"    , "a_SpecialProps_DE"     , "dataenvironment" )
            .SpecialPropsFiles_Add( "props_editbox.txt"            , "a_SpecialProps_Edt"    , "editbox"         )
            .SpecialPropsFiles_Add( "props_formset.txt"            , "a_SpecialProps_Frs"    , "formset"         )
            .SpecialPropsFiles_Add( "props_grid_column.txt"        , "a_SpecialProps_Grc"    , "column"          )
            .SpecialPropsFiles_Add( "props_grid_header.txt"        , "a_SpecialProps_Grh"    , "header"          )
            .SpecialPropsFiles_Add( "props_hyperlink.txt"          , "a_SpecialProps_Hlk"    , "hyperlink"       )
            .SpecialPropsFiles_Add( "props_image.txt"              , "a_SpecialProps_Img"    , "image"           )
            .SpecialPropsFiles_Add( "props_label.txt"              , "a_SpecialProps_Lbl"    , "label"           )
            .SpecialPropsFiles_Add( "props_line.txt"               , "a_SpecialProps_Lin"    , "line"            )
            .SpecialPropsFiles_Add( "props_listbox.txt"            , "a_SpecialProps_Lst"    , "listbox"         )
            .SpecialPropsFiles_Add( "props_olebound.txt"           , "a_SpecialProps_Ole"    , "olebound"        )
            .SpecialPropsFiles_Add( "props_optiongroup.txt"        , "a_SpecialProps_Opg"    , "optiongroup"     )
            .SpecialPropsFiles_Add( "props_optiongroup_option.txt" , "a_SpecialProps_Opb"    , "optionbutton"    )
            .SpecialPropsFiles_Add( "props_projecthook.txt"        , "a_SpecialProps_Phk"    , "projecthook"     )
            .SpecialPropsFiles_Add( "props_relation.txt"           , "a_SpecialProps_Rel"    , "relation"        )
            .SpecialPropsFiles_Add( "props_reportlistener.txt"     , "a_SpecialProps_Rls"    , "reportlistener"  )
            .SpecialPropsFiles_Add( "props_separator.txt"          , "a_SpecialProps_Sep"    , "separator"       )
            .SpecialPropsFiles_Add( "props_shape.txt"              , "a_SpecialProps_Shp"    , "shape"           )
            .SpecialPropsFiles_Add( "props_spinner.txt"            , "a_SpecialProps_Spn"    , "spinner"         )
            .SpecialPropsFiles_Add( "props_textbox.txt"            , "a_SpecialProps_Txt"    , "textbox"         )
            .SpecialPropsFiles_Add( "props_timer.txt"              , "a_SpecialProps_Tmr"    , "timer"           )
            .SpecialPropsFiles_Add( "props_xmladapter.txt"         , "a_SpecialProps_XMLAda" , "xmladapter"      )
            .SpecialPropsFiles_Add( "props_xmlfield.txt"           , "a_SpecialProps_XMLFld" , "xmlfield"        )
            .SpecialPropsFiles_Add( "props_xmltable.txt"           , "a_SpecialProps_XMLTbl" , "xmltable"        )

            #IFDEF MONO_FOXBIN2PRG
               lcPropsDir = Addbs( Justpath( .c_Foxbin2prg_FullPath ) ) + .c_PropsDir
            #ELSE
               lcPropsDir = .c_PropsDir
            #ENDIF

            FOR lnI = 1 TO Alen( .a_SpecialPropsFiles, 1 )
               lcPropsFile = lcPropsDir + .a_SpecialPropsFiles( lnI, 1 )
               lcProperty  = .a_SpecialPropsFiles( lnI, 2 )
               =Alines( .&lcProperty, Filetostr( lcPropsFile ), 1+4 )
            ENDFOR

            .l_Loaded = .T.
         ENDWITH

      CATCH TO loEx
         loEx.UserValue = 'lcPropsFile = ' + lcPropsFile
         THROW
      ENDTRY

      RETURN
   ENDPROC


   PROCEDURE SpecialPropsFiles_Add
      LPARAMETERS pcFile, pcPropArrayName, pcBaseClass
      LOCAL lnI

      IF Alen( This.a_SpecialPropsFiles ) = 1
         lnI = 1
      ELSE
         lnI = Alen( This.a_SpecialPropsFiles, 1 ) + 1
      ENDIF

      DIMENSION This.a_SpecialPropsFiles[ lnI, 3 ]

      This.a_SpecialPropsFiles[ lnI, 1 ] = pcFile
      This.a_SpecialPropsFiles[ lnI, 2 ] = pcPropArrayName
      This.a_SpecialPropsFiles[ lnI, 3 ] = Lower( pcBaseClass )

      RETURN lnI
   ENDPROC

ENDDEFINE
