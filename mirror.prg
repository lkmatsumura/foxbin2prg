LOCAL lcF2bExe , loCfg, loF2b
LOCAL lOk

CLEAR
*-- Default sample paths (replace with your project paths)

lOk =  .T.

lcF2bExe  = 'foxbin2prg.prg'

IF File( '.gitignore' )
   lcSrcRoot = Addbs( FullPath( JustPath( Sys(16) ) ) )
   lcPjxRoot = Addbs( FullPath( lcSrcRoot + '..\' ) )
ELSE
   lcSrcRoot = Addbs( FullPath( JustPath( Sys(16) ) ) ) + 'scm\'
   lcPjxRoot = Addbs( FullPath( JustPath( Sys(16) ) ) )
ENDIF

? 'Directories'
? 'Source (scm) :' , lcSrcRoot
? 'Binary       :' , lcPjxRoot
?

IF lOk AND MessageBox( 'Is the directories correct ?' , 4+256 ) != 6
   lOk = .F.
ENDIF

IF lOk
   Do GetObj_F2b IN (lcF2bExe) WITH loF2b

   loCfg = loF2b.newConfig()

   loCfg.l_Recompile        = .F.        && default .T.; do not recompile when regenerating binaries
   loCfg.l_NoTimestamps     = .T.        && strip timestamps (better for version control / merge)
   loCfg.n_UseClassPerFile  = 0          && 0 = one VC2 per VCX, 1 = one VC2 per class
   loCfg.n_ShowProgressbar  = 1          && default 1 Allway show; 0 = no progress bar (batch / unattended mode)
   loCfg.n_ExtraBackupLevels = 0         && 0 = Sem backups , > 0 qtde de niveis de backup (default = 1)

   loCfg.l_ExportUtf8 = .T.
   loCfg.n_Homedir = 0
   loCfg.n_Debug = 0

   *-- Class export behahior
   loCfg.n_UseClassPerFile            = 1
   loCfg.l_UseClassPerDir             = .T.
   loCfg.l_RedirectClassPerFileToMain = .T.
   loCfg.n_RedirectClassType          = 0
   loCfg.l_ClassPerFileCheck          = .F.

   *-- Form export behahior
   loCfg.l_UseFormSettings           = 1
   loCfg.n_UseFormPerFile            = 0
   loCfg.l_UseFormPerDir            = .F.
   loCfg.l_FormPerFileCheck          = 0
   loCfg.n_RedirectFormType          = 0
   loCfg.l_RedirectFormPerFileToMain = 0

   *-- Mirrored tree behavior:
   loCfg.l_CopyNonConvertible = .T.      && copy non-convertible files into the mirrored tree
   loCfg.l_CopyLowercaseNames = .T.      && when copying, use lowercase file names
   loCfg.c_ExcludedSubdirs    = 'deps'   && subdirs to skip (not copied or converted)

ENDIF

IF lOk AND MessageBox( 'Import from scm (Convert PRG -> BIN) ?' , 4+256 ) = 6
   ?
   ? 'Importing files from scm'
   ?
   lOk = lOk AND Import( "foxbin2prg"      , ""              , lcSrcRoot , lcPjxRoot , loCfg , loF2b )
   lOk = lOk AND Import( "Others"          , ""              , lcSrcRoot , lcPjxRoot , loCfg , loF2b )
   lOk = lOk AND Import( "Fb2P_Diff"       , "Fb2P_Diff"     , lcSrcRoot , lcPjxRoot , loCfg , loF2b )
   lOk = lOk AND Import( "FileName_Caps"   , "FileName_Caps" , lcSrcRoot , lcPjxRoot , loCfg , loF2b )

   * Do not convert from UTF8
   loCfg.l_ExportUtf8 = .F.
   lOk = lOk AND Import( "dont_convert"    , ""              , lcSrcRoot , lcPjxRoot , loCfg , loF2b )

ENDIF
IF lOk AND MessageBox( 'Export to scm (Convert BIN -> PRG)?' , 4+256 ) = 6
   ?
   ? 'Exporting files to scm'
   ?
   lOk = lOk AND Export( "foxbin2prg"      , ""              , lcPjxRoot , lcSrcRoot , loCfg , loF2b )
   lOk = lOk AND Export( "Others"          , ""              , lcPjxRoot , lcSrcRoot , loCfg , loF2b )
   lOk = lOk AND Export( "Fb2P_Diff"       , "Fb2P_Diff"     , lcPjxRoot , lcSrcRoot , loCfg , loF2b )
   lOk = lOk AND Export( "FileName_Caps"   , "FileName_Caps" , lcPjxRoot , lcSrcRoot , loCfg , loF2b )

   * Do not convert to UTF8
   loCfg.l_ExportUtf8 = .F.
   lOk = lOk AND Export( "dont_convert"    , ""              , lcPjxRoot , lcSrcRoot , loCfg , loF2b )

ENDIF

RELEASE loF2b
CLEAR ALL
RELEASE ALL
CLEAR PROGRAM
CLEAR RESOURCES

RETURN

*
* Export
* Export the files in the pjx (pcPjx) in pcPrjDir + pcSub to the mirrored tree in pcDestRoot + pcSub
*
FUNCTION Export
LPARAMETERS pcPjx , pcSub , pcPrjDir , pcDestRoot , poCfg, poF2b
LOCAL lnSec , lcArqOrig , lcDestDir , lnResp

   lcArqOrig = Addbs( pcPrjDir   ) + iif( Empty(pcSub) , '' , Addbs( pcSub ) ) + ForceExt( pcPjx , 'pjx' )
   lcDestDir = Addbs( pcDestRoot ) + iif( Empty(pcSub) , '' , Addbs( pcSub ) )

   lnSec = Seconds()
   lnResp = poF2b.exportProjectTree( lcArqOrig , lcDestDir , poCfg )
   ? Padr(pcPjx,32), 'Resp:' , lnResp , 'Time (sec):' , Seconds() - lnSec

RETURN lnResp = 0

*
* Import
* Import the files in the pj2 (pcPjx) in pcSrcDir + pcSub to the mirrored tree in pcDestRoot + pcSub
*
FUNCTION Import
LPARAMETERS pcPjx , pcSub , pcSrcDir , pcDestRoot , poCfg, poF2b
LOCAL lnSec , lcArqOrig , lcDestDir , lnResp

   lcArqOrig = Addbs( pcSrcDir   ) + iif( Empty(pcSub) , '' , Addbs( pcSub ) ) + ForceExt( pcPjx , 'pj2' )
   lcDestDir = Addbs( pcDestRoot ) + iif( Empty(pcSub) , '' , Addbs( pcSub ) )

   lnSec = Seconds()
   lnResp = poF2b.importProjectTree( lcArqOrig , lcDestDir , poCfg )
   ? Padr(pcPjx,32) , 'Resp:' , lnResp , 'Time (sec):' , Seconds() - lnSec

RETURN lnResp = 0