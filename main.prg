*---------------------------------------------------------------------------------------------------
* Module.........: FOXBIN2PRG.PRG - FOR VISUAL FOXPRO 9.0
* Author.........: Fernando D. Bozzo (mailto:fdbozzo@gmail.com) - http://fdbozzo.blogspot.com
* Project info...: https://vfpx.codeplex.com/wikipage?title=FoxBin2Prg
* Creation Date..: 2013/11/04
*
* LICENCE:
* This work is licensed under the Creative Commons Attribution 4.0 International License.
* To view a copy of this license, visit http://creativecommons.org/licenses/by/4.0/.
*
* LICENCIA (ES):
* Esta obra está sujeta a la licencia Reconocimiento-CompartirIgual 4.0 Internacional de Creative Commons.
* Para ver una copia de esta licencia, visite http://creativecommons.org/licenses/by-sa/4.0/deed.es_ES.
*
*---------------------------------------------------------------------------------------------------
* DESCRIPTION....: Converts the given VCX/SCX/PJX file to a "hybrid PRG" for later reconversion.
*                  * The hybrid PRG is a PRG with some binary sections (OLE data, etc.)
*                  * The goal is to use it as a replacement for SCCTEXT.PRG, merge code directly on
*                  this new PRG, and store it in an SCM tool such as CVS without keeping the original binaries.
*                  * Generated extensions: VC2, SC2, PJ2   (...or VCA, SCA, PJA with a config file)
*                  * CONFIGURATION: If a FOXBIN2PRG.CFG file is created, extensions can be changed
*                    for SourceSafe by setting equivalences such as:
*
*                        extension: VC2=VCA
*                        extension: SC2=SCA
*                        extension: PJ2=PJA
*
*   USAGE:
*       DO MAIN.PRG WITH "<path>\FILE.VCX"    && Generates "<path>\FILE.VC2" (BIN TO PRG CONVERSION)
*       DO MAIN.PRG WITH "<path>\FILE.VC2"    && Generates "<path>\FILE.VCX" (PRG TO BIN CONVERSION)
*
*       DO MAIN.PRG WITH "<path>\FILE.SCX"    && Generates "<path>\FILE.SC2" (BIN TO PRG CONVERSION)
*       DO MAIN.PRG WITH "<path>\FILE.SC2"    && Generates "<path>\FILE.SCX" (PRG TO BIN CONVERSION)
*
*       DO MAIN.PRG WITH "<path>\FILE.PJX"    && Generates "<path>\FILE.PJ2" (BIN TO PRG CONVERSION)
*       DO MAIN.PRG WITH "<path>\FILE.PJ2"    && Generates "<path>\FILE.PJX" (PRG TO BIN CONVERSION)
*
*       DO MAIN.PRG WITH "-c", cOutputFile    && Generate a configuration (FoxBin2Prg.cfg) template
*       DO MAIN.PRG WITH "-t", cOutputFile    && Generate a configuration (FoxBin2Prg.dbf.cfg) template
*
*  BIN TO PRG conversion of all project files (PJX included):
*       DO MAIN.PRG WITH "<path>\FILE.PJX" , "*"
*
*  BIN TO PRG conversion of all project files (PJX included) - Mirrored tree (Bin3Prg) example:
*       DO MAIN.PRG WITH "<path>\FILE.PJX" , "Bin3Prg"  , "d:\export\project\path"
*  PRG TO BIN conversion of all project files (PJX included) - Mirrored tree (Prg3Bin) example:
*       DO MAIN.PRG WITH "<path>\FILE.PJ2" , "Prg3Bin" , "d:\import\project\path"
*
*---------------------------------------------------------------------------------------------------
* Usage 1
* PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
* tc_InputFile              (v! IN    ) Full path of the file to convert or directory name to process
*                                       - In Visual SourceSafe compatibility mode, used to query conversion support for the given file type
* tcType                    (v? IN    ) Input file type
*                                       - If "BIN2PRG" is given, the directory in tc_InputFile is processed to generate TX2 files
*                                       - If "PRG2BIN" is given, the directory in tc_InputFile is processed to generate BIN files
*                                       - If "SIMERR_I0" is given, simulates a validation error on the input file
*                                       - If "SIMERR_I1" is given, simulates a program error on the input file
*                                       - If "SIMERR_O1" is given, simulates a program error on the output file
*                                       - If "*" is given and tc_InputFile is a PJX, the entire project is processed
*                                       - If "Bin3Prg" is given and tc_InputFile is a PJX, exports the project to a mirrored tree
*                                         (requires tcTextName or tcOutputFolder as the destination folder)
*                                       - If "Prg3Bin" is given and tc_InputFile is a PJ2, imports the project from a mirrored tree
*                                         (requires tcTextName or tcOutputFolder as the destination folder)
*                                       - In Visual SourceSafe compatibility mode, indicates the file type to convert
* tcTextName                (v? IN    ) Text file name (Visual SourceSafe compatibility only)
*                                       - With "Bin3Prg" or "Prg3Bin": mirrored destination root folder
* tlGenText                 (v? IN    ) .T.=Generate text, .F.=Generate binary (Visual SourceSafe compatibility only)
* tcDontShowErrors          (v? IN    ) '1' to suppress error MESSAGEBOXes
* tcDebug                   (v? IN    ) '1' to debug at the error site (development mode only)
* tcDontShowProgress        (v? IN    ) '1' to hide the progress window
* tcOriginalFileName        (v? IN    ) For cases where inputFile is a temporary name and the correct name should be generated
*                                       in the text version (e.g. in PJ2 files and headers)
* tcRecompile               (v? IN    ) Recompile ('1') the binary once regenerated [default behavior change]
*                                       This change saves time, speed, and safety. Also, recompilation by FoxBin2Prg
*                                       runs from the file directory, so relative references may
*                                       cause compilation errors, typically #include directives.
*                                       NOTE: If a path is given instead of '1' (e.g. the project path), it is used as the recompile base
* tcNoTimestamps            (v? IN    ) Whether to clear the timestamp ('1') or not ('0' or empty)
* tcCFG_File                (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
*                                       Normal inheritance may or may not run, see setting AllowInheritance
* tcOutputFolder            (v? IN    ) The output folder to write to (optional: if it isn't specified, the same folder as the source is used)
*                                       - With "Bin3Prg" or "Prg3Bin": mirrored destination root folder (typical with cfg as param 11)
*
* Example:
*
* Convert files from prg to scm (directory batch)
*       DO Main.prg WITH JUSTPATH(FULLPATH("","")),"Bin2Prg",,,,,,,,FULLPATH("example.cfg","")
*
* Convert files from scm to prg (directory batch)
*       DO Main.prg WITH JUSTPATH(FULLPATH("","")),"Prg2Bin",,,,,,,,FULLPATH("example.cfg","")
*
* Convert full project in-place to scm (with cfg)
*       DO Main.prg WITH "<path>\FILE.PJX","*",,,,,,,,FULLPATH("example.cfg","path\to\scm\")
*
* Convert full project in-place from scm (with cfg)
*       DO Main.prg WITH "<path>\FILE.PJ2","*",,,,,,,,FULLPATH("example.cfg","path\to\bin")
*
* Convert full project to scm in a mirrored tree (with cfg)
*       DO Main.prg WITH "<path>\FILE.PJX","Bin3Prg",,,,,,,,,FULLPATH("example.cfg"),"path\to\scm\"
*
* Convert full project from scm in a mirrored tree (with cfg)
*       DO Main.prg WITH "<path>\FILE.PJ2","Prg3Bin",,,,,,,,,FULLPATH("example.cfg"),"path\to\bin"
*
* Mirrored export/import (destination in tcTextName, cfg optional)
*       DO MAIN.PRG WITH "<path>\FILE.PJX","Bin3Prg","d:\export\project\path",,,,,,,,FULLPATH("example.cfg")
*       DO MAIN.PRG WITH "<path>\FILE.PJ2","Prg3Bin","d:\import\project\path",,,,,,,,FULLPATH("example.cfg")
*
* Create config templates
*       DO Main.prg WITH "-c","example.cfg.txt"     , FULLPATH("example.cfg","")
*       DO Main.prg WITH "-t","example.dbf.cfg.txt" , FULLPATH("example.dbf.cfg","")
*
*---------------------------------------------------------------------------------------------------
* Usage 2 : Create Config
* PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
* tcType            (c! IN    ) Mode (case sensitive)
*                               -c Create config template "tcType" with default values
*                               -C Create config "tcType" with values of directory named by outputfile
*                               -t Create config template "tcType" for config-per-table file
* tc_OutputFile     (v? IN    ) File to create
* tcCFG_File        (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
*                               Normal inheritance may or may not run, see setting AllowInheritance
* tcDebug           (v? IN    ) '1' write debug log (possibly to GETENV("TEMP"))
*
* Example:
* Create config templates
*       DO Main.prg WITH "-c","example.cfg.txt"     , FULLPATH("example.cfg","")
*       DO Main.prg WITH "-t","example.dbf.cfg.txt" , FULLPATH("example.dbf.cfg","")
*
*---------------------------------------------------------------------------------------------------
* Usage 3 : output version number
* PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
* tc_InputFile              (@! OUT   ) -VERNO Return version number (DC_FB2PRG_VERSION_REAL)
*
* Example:
*       lcVersion = DO Main.prg WITH "-VERNO"
*       MESSAGEBOX(lcVersion)
*---------------------------------------------------------------------------------------------------
Lparameters   tc_InputFile      , tcType             , tcTextName      ;
            , tlGenText         , tcDontShowErrors   , tcDebug         ;
            , tcDontShowProgress, tcOriginalFileName , tcRecompile     ;
            , tcNoTimestamps    , tcCFG_File         , tcOutputFolder

*{place_f2b_header}*
#INCLUDE foxbin2prg.h

*-- Predefine 64MB of RAM
SYS(3050, 1, 64*1024*1024)
SYS(3050, 2, 64*1024*1024)

IF _vfp.StartMode > 0 THEN
   Sys(2450,1)     && Set Application Search Path Order to APP/EXE 1st when not in Dev-Mode
ENDIF

LOCAL loCnv AS c_foxbin2prg OF 'c_foxbin2prg.PRG' ;
    , loEx  AS EXCEPTION

LOCAL lnResp

*SET COVERAGE TO c:\desa\foxbin2prg\foxbin2prg_coverage.log
*SYS(2030,1)    && Enable system component debugging
*SYS(2335,0)    && Unattended server mode
*IF PCOUNT() > 1 && Skip SourceSafe queries about file conversion support
*   SET STEP ON
*   MESSAGEBOX( SYS(5)+CURDIR(),64+4096,PROGRAM(),5000)
*ENDIF

*MESSAGEBOX( 'tc_InputFile = ' + TRANSFORM(tc_InputFile) + C_CR + 'tcType = ' + TRANSFORM(tcType) )

tc_InputFile = EVL(tc_InputFile,'')
tcType       = EVL(tcType,'')

* added option to return version number
IF ATC('-VERNO','-'+tc_InputFile) > 0
   tc_InputFile = DC_FB2PRG_VERSION_REAL
   RETURN DC_FB2PRG_VERSION_REAL
ENDIF

*-- If "BIN2PRG" or "PRG2BIN" is received in the first parameter, swap them.
IF    Atc('-BIN2PRG'    , '-' + tc_InputFile) > 0 ;
   OR Atc('-PRG2BIN'    , '-' + tc_InputFile) > 0 ;
   OR Atc('-BIN2TEXT'   , '-' + tc_InputFile) > 0 ;
   OR Atc('-TEXT2BIN'   , '-' + tc_InputFile) > 0 ;
   OR Atc('-SHOWMSG'    , '-' + tc_InputFile) > 0 ;
   OR Atc('-INTERACTIVE', '-' + tc_InputFile) > 0 ;
   OR Atc('-?'          , '-' + tc_InputFile) > 0 ;
   OR Atc('-SIMERR_I0'  , '-' + tc_InputFile) > 0 ;
   OR Atc('-SIMERR_I1'  , '-' + tc_InputFile) > 0 ;
   OR Atc('-SIMERR_O1'  , '-' + tc_InputFile) > 0 ;
   OR Upper(tc_InputFile) == '-C' ;
   OR Upper(tc_InputFile) ==  'C' ;
   OR tc_InputFile == '-t' ;
   OR tc_InputFile ==  't'

   pcParamX     = tc_InputFile
   tc_InputFile = tcType
   tcType       = pcParamX
   RELEASE pcParamX

ENDIF

* -cCt Create config files
IF    Upper(tcType) == '-C' ;
   OR Upper(tcType) ==  'C' ;
   OR tcType == '-t' ;
   OR tcType ==  't'

   IF PCOUNT() > 2
      tcCFG_File = tcTextName

      IF Vartype(tcCFG_File) = "C" AND Empty(JustPath(tcCFG_File))
         tcCFG_File = FullPath(tcCFG_File, "")
      ENDIF

      tcTextName = .F.
   ENDIF

   IF PCOUNT() > 3
      tcDebug   = tlGenText
      tlGenText = .F.
   ENDIF

   DO CASE
   CASE Pcount() > 4
      tc_InputFile = ""
      tcType       = ""

   CASE ! Empty(tc_InputFile)

   CASE ( tcType == '-t' OR tcType == 't' ) AND ! Empty( Dbf() )
      tc_InputFile = DBF() + '._cfg'

   CASE ( Upper( tcType ) =='-C' OR Upper( tcType ) =='C' ) AND tc_InputFile
      tc_InputFile = 'FoxBin2PRG._cfg'

   ENDCASE

ENDIF
TRY
   loEx  = .NULL.
   loCnv = GetObj_F2b()
   *** handle tcOutputFolder
   IF NOT Empty(tcOutputFolder)
      loCnv.cOutputFolder = tcOutputFolder
   ENDIF

   lnResp  = loCnv.execute( tc_InputFile     , tcType  , tcTextName         , tlGenText   ;
                          , tcDontShowErrors , tcDebug , tcDontShowProgress , .NULL.      ;
                          , @loEx            , .F.     , tcOriginalFileName , tcRecompile ;
                          , tcNoTimestamps   , .F.     , .F.                , .F.         ;
                          , tcCFG_File       )

CATCH TO loEx
   *-- This is only for INIT errors; all others should be caught and handled earlier.
   lnResp      = loEx.ErrorNo
   MessageBox( 'Error ' + Transform(loEx.ErrorNo) + ', ' + loEx.Message + C_CR ;
             + loEx.Procedure+ ', Line ' + Transform(loEx.LineNo) + C_CR ;
             + loEx.Details ;
             , 0+16+4096 ;
             , '' ;
             , 60000 )

ENDTRY

AddProperty(_screen, 'ExitCode', lnResp)


IF _VFP.STARTMODE <> 4 OR NOT SYS(16) == SYS(16,0)
   && _vfp.StartMode 4 = Visual FoxPro was started as a distributable .app or .exe file.
   STORE .NULL. TO loEx, loCnv
   RELEASE loEx, loCnv

   ? lnResp
   * lnResp contains an error code, but when invoked from SourceSafe it may contain the file support type (0,1,2).
   RETURN lnResp
ENDIF

IF EMPTY(lnResp)
   STORE .NULL. TO loEx, loCnv
   RELEASE loEx, loCnv
   QUIT
ENDIF

STORE .NULL. TO loEx, loCnv
RELEASE loEx, loCnv

*-- Very useful for batch processes that capture the error code
*KillMode 1
*DECLARE ExitProcess IN Win32API INTEGER ExitCode && To read returned error code with ERRORLEVEL from Windows
*ExitProcess(1) && This should be among the last instructions

*KillMode 2 - This one works better.
DECLARE INTEGER OpenProcess      IN Win32API INTEGER dwDesiredAccess, INTEGER bInheritHandle, INTEGER dwProcessID
DECLARE INTEGER TerminateProcess IN Win32API INTEGER hProcess, INTEGER uExitCode

lnHandle = OpenProcess(1, 1, _vfp.ProcessId)
=TerminateProcess(lnHandle, 1)

*KillMode 3
*lcComputer = [.]
*loCIMV2 = GETOBJECT( [winmgmts:{impersonationLevel=impersonate}!\\] + lcComputer + [\root\cimv2] )
*loProcCols = loCIMV2.ExecQuery( [select * from Win32_Process where processid=] + TRANSFORM(_VFP.PROCESSID) + [] )
*loCIMV2 = .Null.
*loProcCols.ItemIndex(0).TERMINATE(1)


* *------------------------*
* GetObj_F2b
* Requires:
* Modifies:
* Effects : Returns a c_foxbin2prg instance, use the parameter passed by reference if done by a external program
*
* PARAMETERS:               (v=Pass by value | @=Pass by reference) (!=Required | ?=Optional) (IN/OUT)
* poObj                     ( @! IN ) c_foxbin2prg object instance
* *------------------------*
* Ex:
* LOCAL loObj
* loObj = .f.
* Do GetObj_F2b IN foxbin2prg.exe WITH loObj
* *-*
PROCEDURE GetObj_F2b
LPARAMETERS poObj

poObj = NewObject( "c_foxbin2prg", "c_foxbin2prg.prg" )

RETURN poObj