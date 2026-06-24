#INCLUDE foxbin2prg.h

Define Class CL_DBF_CFG As Custom
   _MemberData = [<VFPData>] ;
      + [<memberdata name="dbf_conversion_support" display="DBF_Conversion_Support"/>] ;
      + [<memberdata name="dbf_conversion_order" display="DBF_Conversion_Order"/>] ;
      + [<memberdata name="dbf_conversion_condition" display="DBF_Conversion_Condition"/>] ;
      + [<memberdata name="dbf_indexlist" display="DBF_IndexList"/>] ;
      + [<memberdata name="l_dbf_binchar_base64" display="l_DBF_BinChar_Base64"/>] ;
      + [<memberdata name="l_dbf_includedeleted" display="l_DBF_IncludeDeleted"/>] ;
      + [</VFPData>]

   n_DBF_Conversion_Support    = .Null.
   DBF_Conversion_Order        = ''
   DBF_Conversion_Condition    = ''
   DBF_IndexList               = ''
   l_DBF_BinChar_Base64        = .Null.
   l_DBF_IncludeDeleted        = .Null.

   *---------------------------------------------------------------------------------------------------
   * Build DBF settings from session/global CFG (no table.dbf.cfg on disk).
   *---------------------------------------------------------------------------------------------------
   FUNCTION FromGlobal
      LPARAMETERS toHost, tlGenerateLog
      LOCAL loCfg

      loCfg = NewObject('CL_DBF_CFG', 'cl_dbf_cfg.prg')

      IF VARTYPE(toHost) <> 'O' OR !PEMSTATUS(toHost, 'getCfgValue', 5)
         RETURN loCfg
      ENDIF

      loCfg.n_DBF_Conversion_Support = toHost.getCfgValue('n_DBF_Conversion_Support')
      loCfg.l_DBF_BinChar_Base64     = toHost.getCfgValue('l_DBF_BinChar_Base64')
      loCfg.l_DBF_IncludeDeleted     = toHost.getCfgValue('l_DBF_IncludeDeleted')

      IF tlGenerateLog AND PEMSTATUS(toHost, 'writeLog', 5)
         toHost.writeLog(' > DBF configuration from session CFG (no per-table .dbf.cfg)')
         toHost.writeLog('     DBF_Conversion_Support: ' + TRANSFORM(loCfg.n_DBF_Conversion_Support))
      ENDIF

      RETURN loCfg
   ENDFUNC

Enddefine
