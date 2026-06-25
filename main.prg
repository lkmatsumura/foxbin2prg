*---------------------------------------------------------------------------------------------------
* FOXBIN2PRG - Visual FoxPro 9 binary/text converter (minimal CLI entry point)
*
* USAGE:
*   DO main.prg                              && Configuration reference (frm_main)
*   DO main.prg WITH "<path>\file.vcx"        && Bin -> text (extension sets direction)
*   DO main.prg WITH "<path>\file.vc2"        && Text -> bin
*   DO main.prg WITH "<path>\file.vcx", "", loCfg   && With newConfig() object
*   lcVer = DO main.prg WITH "-VERNO"
*
* Programmatic API (mirror.prg style):
*   Do GetObj_F2b IN (lcF2bExe) WITH loF2b
*   loCfg = loF2b.newConfig()
*   loF2b.exportProjectTree( lcPjx, lcDest, loCfg )
*   loF2b.importProjectTree( lcPj2, lcDest, loCfg )
*---------------------------------------------------------------------------------------------------
LPARAMETERS tc_InputFile, tcType, toCfg

*{place_f2b_header}*
#INCLUDE foxbin2prg.h

SYS(3050, 1, 64*1024*1024)
SYS(3050, 2, 64*1024*1024)

IF _vfp.StartMode > 0 THEN
   Sys(2450,1)
ENDIF

LOCAL loCnv AS c_foxbin2prg OF 'c_foxbin2prg.PRG' ;
    , loEx  AS EXCEPTION ;
    , loFrm_Main AS frm_main OF 'frm_main.PRG'

LOCAL lnResp

tc_InputFile = EVL(tc_InputFile,'')
tcType       = EVL(tcType,'')

IF ATC('-VERNO','-'+tc_InputFile) > 0
   RETURN DC_FB2PRG_VERSION_REAL
ENDIF

TRY
   loEx  = .NULL.
   loCnv = GetObj_F2b()

   IF EMPTY(tc_InputFile) AND NOT INLIST( UPPER(tcType), 'BIN3PRG', 'PRG3BIN' )
      loFrm_Main = NewObject( 'frm_main', 'frm_main.prg', NULL, loCnv )
      loFrm_Main.SHOW()
      READ EVENTS
      lnResp = 0
   ELSE
      lnResp = loCnv.execute( tc_InputFile, tcType, toCfg, @loEx )
   ENDIF

CATCH TO loEx
   lnResp = loEx.ErrorNo
   MessageBox( 'Error ' + Transform(loEx.ErrorNo) + ', ' + loEx.Message + C_CR ;
             + loEx.Procedure+ ', Line ' + Transform(loEx.LineNo) + C_CR ;
             + loEx.Details ;
             , 0+16+4096 ;
             , '' ;
             , 60000 )

ENDTRY

AddProperty(_screen, 'ExitCode', lnResp)

IF _VFP.STARTMODE <> 4 OR NOT SYS(16) == SYS(16,0)
   STORE .NULL. TO loEx, loCnv, loFrm_Main
   RELEASE loEx, loCnv, loFrm_Main
   RETURN lnResp
ENDIF

IF EMPTY(lnResp)
   STORE .NULL. TO loEx, loCnv, loFrm_Main
   RELEASE loEx, loCnv, loFrm_Main
   QUIT
ENDIF

STORE .NULL. TO loEx, loCnv, loFrm_Main
RELEASE loEx, loCnv, loFrm_Main

DECLARE INTEGER OpenProcess      IN Win32API INTEGER dwDesiredAccess, INTEGER bInheritHandle, INTEGER dwProcessID
DECLARE INTEGER TerminateProcess IN Win32API INTEGER hProcess, INTEGER uExitCode

lnHandle = OpenProcess(1, 1, _vfp.ProcessId)
=TerminateProcess(lnHandle, 1)


PROCEDURE GetObj_F2b
LPARAMETERS poObj

poObj = NewObject( "c_foxbin2prg", "c_foxbin2prg.prg" )

RETURN poObj
