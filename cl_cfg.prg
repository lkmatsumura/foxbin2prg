
Define Class CL_CFG As Custom
   _MemberData = [<VFPData>] ;
      + [<memberdata name="c_curdir" display="c_CurDir"/>] ;
      + [<memberdata name="c_foxbin2prg_fullpath" display="c_Foxbin2prg_FullPath"/>] ;
      + [<memberdata name="c_foxbin2prg_configfile" display="c_Foxbin2prg_ConfigFile"/>] ;
      + [<memberdata name="c_db2" display="c_DB2"/>] ;
      + [<memberdata name="c_dc2" display="c_DC2"/>] ;
      + [<memberdata name="c_fr2" display="c_FR2"/>] ;
      + [<memberdata name="c_lb2" display="c_LB2"/>] ;
      + [<memberdata name="c_mn2" display="c_MN2"/>] ;
      + [<memberdata name="c_fk2" display="c_FK2"/>] ;
      + [<memberdata name="c_me2" display="c_ME2"/>] ;
      + [<memberdata name="c_pj2" display="c_PJ2"/>] ;
      + [<memberdata name="c_sc2" display="c_SC2"/>] ;
      + [<memberdata name="c_vc2" display="c_VC2"/>] ;
      + [<memberdata name="l_classperfilecheck" display="l_ClassPerFileCheck"/>] ;
      + [<memberdata name="l_clearuniqueid" display="l_ClearUniqueID"/>] ;
      + [<memberdata name="l_cleardbflastupdate" display="l_ClearDBFLastUpdate"/>] ;
      + [<memberdata name="n_debug" display="n_Debug"/>] ;
      + [<memberdata name="n_bodydevinfo" display="n_BodyDevInfo"/>] ;
      + [<memberdata name="l_notimestamps" display="l_NoTimestamps"/>] ;
      + [<memberdata name="n_optimizebyfilestamp" display="n_OptimizeByFilestamp"/>] ;
      + [<memberdata name="n_excludedbfautoincnextval" display="n_ExcludeDBFAutoincNextval"/>] ;
      + [<memberdata name="l_recompile" display="l_Recompile"/>] ;
      + [<memberdata name="l_redirectclassperfiletomain" display="l_RedirectClassPerFileToMain"/>] ;
      + [<memberdata name="n_redirectclasstype" display="n_RedirectClassType"/>] ;
      + [<memberdata name="l_showerrors" display="l_ShowErrors"/>] ;
      + [<memberdata name="n_showprogressbar" display="n_ShowProgressbar"/>] ;
      + [<memberdata name="n_useclassperfile" display="n_UseClassPerFile"/>] ;
      + [<memberdata name="l_oldfilesperdbc" display="l_OldFilesPerDBC"/>] ;
      + [<memberdata name="n_usefilesperdbc" display="n_UseFilesPerDBC"/>] ;
      + [<memberdata name="l_redirectfileperdbctomain" display="l_RedirectFilePerDBCToMain"/>] ;
      + [<memberdata name="l_itemperdbccheck" display="l_ItemPerDBCCheck"/>] ;
      + [<memberdata name="l_dbf_binchar_base64" display="l_DBF_BinChar_Base64"/>] ;
      + [<memberdata name="l_dbf_includedeleted" display="l_DBF_IncludeDeleted"/>] ;
      + [<memberdata name="n_pjx_conversion_support" display="PJX_Conversion_Support"/>] ;
      + [<memberdata name="n_vcx_conversion_support" display="n_VCX_Conversion_Support"/>] ;
      + [<memberdata name="n_scx_conversion_support" display="n_SCX_Conversion_Support"/>] ;
      + [<memberdata name="n_frx_conversion_support" display="n_FRX_Conversion_Support"/>] ;
      + [<memberdata name="n_lbx_conversion_support" display="n_LBX_Conversion_Support"/>] ;
      + [<memberdata name="n_mnx_conversion_support" display="n_MNX_Conversion_Support"/>] ;
      + [<memberdata name="n_dbc_conversion_support" display="n_DBC_Conversion_Support"/>] ;
      + [<memberdata name="n_dbf_conversion_support" display="n_DBF_Conversion_Support"/>] ;
      + [<memberdata name="n_fky_conversion_support" display="n_FKY_Conversion_Support"/>] ;
      + [<memberdata name="n_mem_conversion_support" display="n_MEM_Conversion_Support"/>] ;
      + [<memberdata name="c_dbf_conversion_included" display="c_DBF_Conversion_Included"/>] ;
      + [<memberdata name="c_dbf_conversion_excluded" display="c_DBF_Conversion_Excluded"/>] ;
      + [<memberdata name="c_backgroundimage" display="c_BackgroundImage"/>] ;
      + [<memberdata name="n_prg_compat_level" display="n_PRG_Compat_Level"/>] ;
      + [<memberdata name="copyfrom" display="CopyFrom"/>] ;
      + [<memberdata name="c_language_in" display="c_Language_In"/>] ;
      + [</VFPData>]

   #If .F.
      Local This As CL_CFG Of 'cl_cfg.prg'
   #Endif


   *-- Configuration class. By default asumes master value, except when overriding one.
   c_Foxbin2prg_FullPath           = ''
   c_Foxbin2prg_ConfigFile         = ''
   c_CurDir                        = ''
   c_Language_In                   = .Null.
   n_Debug                         = .Null.
   n_BodyDevInfo                   = .Null.
   l_ShowErrors                    = .Null.
   n_ShowProgressbar               = .Null.
   n_OptimizeByFilestamp           = .Null.
   n_ExcludeDBFAutoincNextval      = .Null.

   l_Recompile                     = .Null.
   l_NoTimestamps                  = .Null.
   l_ClearUniqueID                 = .Null.
   l_ClearDBFLastUpdate            = .Null.

   l_RemoveNullCharsFromCode       = .Null.
   l_RemoveZOrderSetFromProps      = .Null.
   n_UseClassPerFile               = .Null.

   l_RedirectClassPerFileToMain    = .Null.
   n_RedirectClassType             = .Null.
   l_ClassPerFileCheck             = .Null.
   l_UseFormSettings               = .Null.
   n_UseFormPerFile                = .Null.
   l_RedirectFormPerFileToMain     = .Null.
   n_RedirectFormType              = .Null.
   l_FormPerFileCheck              = .Null.
   n_CheckFileInPath               = .Null.
   l_OldFilesPerDBC                = .Null.
   n_UseFilesPerDBC                = .Null.
   l_RedirectFilePerDBCToMain      = .Null.
   l_ItemPerDBCCheck               = .Null.
   l_DBF_BinChar_Base64            = .Null.
   l_DBF_IncludeDeleted            = .Null.
   n_InhibitInheritance            = .Null.
   n_ExtraBackupLevels             = .Null.
   c_VC2                           = .Null.
   c_SC2                           = .Null.
   c_PJ2                           = .Null.
   c_FR2                           = .Null.
   c_LB2                           = .Null.
   c_DB2                           = .Null.
   c_DC2                           = .Null.
   c_MN2                           = .Null.
   c_FK2                           = .Null.
   c_ME2                           = .Null.
   n_PJX_Conversion_Support        = .Null.
   n_VCX_Conversion_Support        = .Null.
   n_SCX_Conversion_Support        = .Null.
   n_FRX_Conversion_Support        = .Null.
   n_LBX_Conversion_Support        = .Null.
   n_MNX_Conversion_Support        = .Null.
   n_DBC_Conversion_Support        = .Null.
   n_DBF_Conversion_Support        = .Null.
   n_FKY_Conversion_Support        = .Null.
   n_MEM_Conversion_Support        = .Null.
   c_DBF_Conversion_Included       = .Null.
   c_DBF_Conversion_Excluded       = .Null.
   c_BackgroundImage               = .Null.
   n_PRG_Compat_Level              = .Null.
   n_HomeDir                       = .Null.
   l_AllowFolder                   = .T.

   Procedure CopyFrom
      *-- Copia las propiedades del CFG indicado
      Lparameters toParentCFG,toSourceCFG

      If Pcount()=1 Then
         toSourceCFG = This
      Endif &&PCOUNT()=1

      With toSourceCFG As CL_CFG Of 'cl_cfg.prg'
         .c_Foxbin2prg_FullPath          = toParentCFG.c_Foxbin2prg_FullPath
         .c_Foxbin2prg_ConfigFile        = toParentCFG.c_Foxbin2prg_ConfigFile
         .c_CurDir                       = toParentCFG.c_CurDir
         .n_Debug                        = toParentCFG.n_Debug
         .c_Language_In                  = toParentCFG.c_Language_In
         .n_BodyDevInfo                  = toParentCFG.n_BodyDevInfo
         .n_OptimizeByFilestamp          = toParentCFG.n_OptimizeByFilestamp
         .n_ExcludeDBFAutoincNextval     = toParentCFG.n_ExcludeDBFAutoincNextval

         .l_ShowErrors                   = toParentCFG.l_ShowErrors
         .n_ShowProgressbar              = toParentCFG.n_ShowProgressbar
         .l_Recompile                    = toParentCFG.l_Recompile
         .l_NoTimestamps                 = toParentCFG.l_NoTimestamps
         .l_ClearUniqueID                = toParentCFG.l_ClearUniqueID
         .l_ClearDBFLastUpdate           = toParentCFG.l_ClearDBFLastUpdate

         .l_RemoveNullCharsFromCode      = toParentCFG.l_RemoveNullCharsFromCode
         .l_RemoveZOrderSetFromProps     = toParentCFG.l_RemoveZOrderSetFromProps
         .n_UseClassPerFile              = toParentCFG.n_UseClassPerFile
         .l_RedirectClassPerFileToMain   = toParentCFG.l_RedirectClassPerFileToMain
         .n_RedirectClassType            = toParentCFG.n_RedirectClassType
         .l_ClassPerFileCheck            = toParentCFG.l_ClassPerFileCheck
         .l_UseFormSettings              = toParentCFG.l_UseFormSettings
         .n_UseFormPerFile               = toParentCFG.n_UseFormPerFile
         .l_RedirectFormPerFileToMain    = toParentCFG.l_RedirectFormPerFileToMain
         .n_RedirectFormType             = toParentCFG.n_RedirectFormType
         .l_FormPerFileCheck             = toParentCFG.l_FormPerFileCheck
         .l_OldFilesPerDBC               = toParentCFG.l_OldFilesPerDBC
         .n_UseFilesPerDBC               = toParentCFG.n_UseFilesPerDBC
         .l_RedirectFilePerDBCToMain     = toParentCFG.l_RedirectFilePerDBCToMain
         .l_ItemPerDBCCheck              = toParentCFG.l_ItemPerDBCCheck
         .l_DBF_BinChar_Base64           = toParentCFG.l_DBF_BinChar_Base64
         .l_DBF_IncludeDeleted           = toParentCFG.l_DBF_IncludeDeleted
         .n_InhibitInheritance           = toParentCFG.n_InhibitInheritance
         .n_ExtraBackupLevels            = toParentCFG.n_ExtraBackupLevels

         .c_VC2                          = toParentCFG.c_VC2
         .c_SC2                          = toParentCFG.c_SC2
         .c_PJ2                          = toParentCFG.c_PJ2
         .c_FR2                          = toParentCFG.c_FR2
         .c_LB2                          = toParentCFG.c_LB2
         .c_DB2                          = toParentCFG.c_DB2
         .c_DC2                          = toParentCFG.c_DC2
         .c_MN2                          = toParentCFG.c_MN2
         .c_FK2                          = toParentCFG.c_FK2
         .c_ME2                          = toParentCFG.c_ME2

         .n_PJX_Conversion_Support       = toParentCFG.n_PJX_Conversion_Support
         .n_VCX_Conversion_Support       = toParentCFG.n_VCX_Conversion_Support
         .n_SCX_Conversion_Support       = toParentCFG.n_SCX_Conversion_Support
         .n_FRX_Conversion_Support       = toParentCFG.n_FRX_Conversion_Support
         .n_LBX_Conversion_Support       = toParentCFG.n_LBX_Conversion_Support
         .n_MNX_Conversion_Support       = toParentCFG.n_MNX_Conversion_Support
         .n_DBC_Conversion_Support       = toParentCFG.n_DBC_Conversion_Support
         .n_DBF_Conversion_Support       = toParentCFG.n_DBF_Conversion_Support
         .n_FKY_Conversion_Support       = toParentCFG.n_FKY_Conversion_Support
         .n_MEM_Conversion_Support       = toParentCFG.n_MEM_Conversion_Support
         .c_DBF_Conversion_Included      = toParentCFG.c_DBF_Conversion_Included
         .c_DBF_Conversion_Excluded      = toParentCFG.c_DBF_Conversion_Excluded

         .c_BackgroundImage              = toParentCFG.c_BackgroundImage
         .n_PRG_Compat_Level             = toParentCFG.n_PRG_Compat_Level
         .n_HomeDir                      = toParentCFG.n_HomeDir
         .l_AllowFolder                  = toParentCFG.l_AllowFolder
      Endwith
   Endproc


Enddefine
