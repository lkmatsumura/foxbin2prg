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
* LICENCIA:
* Esta obra está sujeta a la licencia Reconocimiento-CompartirIgual 4.0 Internacional de Creative Commons.
* Para ver una copia de esta licencia, visite http://creativecommons.org/licenses/by-sa/4.0/deed.es_ES.
*
*---------------------------------------------------------------------------------------------------
* DESCRIPCIÓN....: CONVIERTE EL ARCHIVO VCX/SCX/PJX INDICADO A UN "PRG HÍBRIDO" PARA POSTERIOR RECONVERSIÓN.
*                  * EL PRG HÍBRIDO ES UN PRG CON ALGUNAS SECCIONES BINARIAS (OLE DATA, ETC)
*                  * EL OBJETIVO ES PODER USARLO COMO REEMPLAZO DEL SCCTEXT.PRG, PODER HACER MERGE
*                  DEL CÓDIGO DIRECTAMENTE SOBRE ESTE NUEVO PRG Y GUARDARLO EN UNA HERRAMIENTA DE SCM
*                  COMO CVS O SIMILAR SIN NECESIDAD DE GUARDAR LOS BINARIOS ORIGINALES.
*                  * EXTENSIONES GENERADAS: VC2, SC2, PJ2   (...o VCA, SCA, PJA con archivo conf.)
*                  * CONFIGURACIÓN: SI SE CREA UN ARCHIVO FOXBIN2PRG.CFG, SE PUEDEN CAMBIAR LAS EXTENSIONES
*                    PARA PODER USARLO CON SOURCESAFE PONIENDO LAS EQUIVALENCIAS ASÍ:
*
*                        extension: VC2=VCA
*                        extension: SC2=SCA
*                        extension: PJ2=PJA
*
*   USO/USE:
*       DO FOXBIN2PRG.PRG WITH "<path>\FILE.VCX"    && Genera "<path>\FILE.VC2" (BIN TO PRG CONVERSION)
*       DO FOXBIN2PRG.PRG WITH "<path>\FILE.VC2"    && Genera "<path>\FILE.VCX" (PRG TO BIN CONVERSION)
*
*       DO FOXBIN2PRG.PRG WITH "<path>\FILE.SCX"    && Genera "<path>\FILE.SC2" (BIN TO PRG CONVERSION)
*       DO FOXBIN2PRG.PRG WITH "<path>\FILE.SC2"    && Genera "<path>\FILE.SCX" (PRG TO BIN CONVERSION)
*
*       DO FOXBIN2PRG.PRG WITH "<path>\FILE.PJX"    && Genera "<path>\FILE.PJ2" (BIN TO PRG CONVERSION)
*       DO FOXBIN2PRG.PRG WITH "<path>\FILE.PJ2"    && Genera "<path>\FILE.PJX" (PRG TO BIN CONVERSION)
*
*       DO FOXBIN2PRG.PRG WITH "-c", cOutputFile    && Generate a configuration (FoxBin2Prg.cfg) template
*
*---------------------------------------------------------------------------------------------------
* TRAMIENTOS ESPECIALES DE ASIGNACIONES DE PROPIEDADES:
*   PROPIEDAD               ARREGLO Y EJEMPLO
*-------------------------  --------------------------------------------------------------------------------------
*   _memberdata             Se separan las definiciones en lineas para evitar una sola muy larga
*
*---------------------------------------------------------------------------------------------------
*** LScheffler 2021-03-08: added optional set of parameters, config file
* Usage 1
* PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_InputFile              (v! IN    ) Nombre completo (fullpath) del archivo a convertir o nombre del directorio a procesar
*                                       - En modo compatibilidad con Visual SourceSafe, se usa para preguntar el tipo de soporte de conversión para el tipo de archivo indicado
* tcType                    (v? IN    ) Tipo de archivo de entrada
*                                       - Si se indica "BIN2PRG", se procesa el directorio indicado para generar los TX2
*                                       - Si se indica "PRG2BIN", se procesa el directorio indicado para generar los BIN
*                                       - Si se indica "SIMERR_I0", se simula un error de validación en el archivo de entrada
*                                       - Si se indica "SIMERR_I1", se simula un error de programa en el archivo de entrada
*                                       - Si se indica "SIMERR_O1", se simula un error de programa en el archivo de salida
*                                       - Si se indica "*" y tc_InputFile es un PJX, se procesa todo el proyecto
*                                       - En modo compatibilidad con Visual SourceSafe, indica el tipo de archivo a convertir
* tcTextName                (v? IN    ) Nombre del archivo texto. (Solo para compatibilidad con Visual SourceSafe)
* tlGenText                 (v? IN    ) .T.=Genera Texto, .F.=Genera Binario. (Solo para compatibilidad con Visual SourceSafe)
* tcDontShowErrors          (v? IN    ) '1' para NO mostrar errores con MESSAGEBOX
* tcDebug                   (v? IN    ) '1' para depurar en el sitio donde ocurre el error (solo modo desarrollo)
* tcDontShowProgress        (v? IN    ) '1' para NO mostrar la ventana de progreso
* tcOriginalFileName        (v? IN    ) Sirve para los casos en los que inputFile es un nombre temporal y se quiere generar
*                                       el nombre correcto dentro de la versión texto (por ej: en los PJ2 y las cabeceras)
* tcRecompile               (v? IN    ) Indica recompilar ('1') el binario una vez regenerado. [Cambio de funcionamiento por defecto]
*                                       Este cambio es para ganar tiempo, velocidad y seguridad. Además la recompilación que hace FoxBin2Prg
*                                       se hace desde el directorio del archivo, con lo que las referencias relativas pueden
*                                       generar errores de compilación, típicamente los #include.
*                                       NOTA: Si en vez de '1' se indica un Path (p.ej, el del proyecto, se usará como base para recompilar
* tcNoTimestamps            (v? IN    ) Indica si se debe anular el timestamp ('1') o no ('0' ó vacío)
* tcCFG_File                (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
*                                       Normal inheritance may or may not run, see setting AllowInheritance
* tcOutputFolder            (v? IN    ) The output folder to write to (optional: if it isn't specified, the same folder as the source is used)
*---------------------------------------------------------------------------------------------------
* Usage 2 : Create Config
* PARAMETERS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tcType            (c! IN    ) Modus (case sensitive)
*                               -c Create config template "tcType" with default values
*                               -C Create config "tcType" with values of directory named by outputfile
*                               -t Create config template "tcType" for config-per-table file
* tc_OutputFile     (v? IN    ) file to create
* tcCFG_File        (v? IN    ) Config file. If a config file is set, the normal chain of inheritance is reset and this file is read atop of the defaults
*                               Normal inheritance may or may not run, see setting AllowInheritance
* tcDebug           (v? IN    ) '1' write debug log (posiibly to GETENV("TEMP") )
*---------------------------------------------------------------------------------------------------
* Usage 3 : output version number
* PARAMETERS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
* tc_InputFile              (@! OUT   ) -VERNO Return version number (DC_FB2PRG_VERSION_REAL)
*---------------------------------------------------------------------------------------------------
Lparameters   tc_InputFile      , tcType             , tcTextName      ;
            , tlGenText         , tcDontShowErrors   , tcDebug         ;
            , tcDontShowProgress, tcOriginalFileName , tcRecompile     ;
            , tcNoTimestamps    , tcCFG_File         , tcOutputFolder

#INCLUDE foxbin2prg.h


*-- Predefine 64MB of RAM
Sys(3050,1,64*1024*1024)
Sys(3050,2,64*1024*1024)

If _vfp.StartMode > 0 Then
    Sys(2450,1)     && Set Application Search Path Order to APP/EXE 1st when not in Dev-Mode
Endif

LOCAL loCnv AS c_foxbin2prg OF 'FOXBIN2PRG.PRG' ;
    . loEx  AS Exception

LOCAL lnResp

*SET COVERAGE TO c:\desa\foxbin2prg\foxbin2prg_coverage.log
*SYS(2030,1)    && Enable system component debugging
*SYS(2335,0)    && Unnatended server mode
*IF PCOUNT() > 1 && Saltear las querys de SourceSafe sobre soporte de archivos
*   SET STEP ON
*   MESSAGEBOX( SYS(5)+CURDIR(),64+4096,PROGRAM(),5000)
*ENDIF

*MESSAGEBOX( 'tc_InputFile = ' + TRANSFORM(tc_InputFile) + C_CR + 'tcType = ' + TRANSFORM(tcType) )

tc_InputFile    = Evl(tc_InputFile,'')
tcType          = Evl(tcType,'')

* added option to return version number
IF Atc('-VERNO','-'+tc_InputFile) > 0
   tc_InputFile = DC_FB2PRG_VERSION_REAL
   RETURN DC_FB2PRG_VERSION_REAL
ENDIF

*-- En el caso de recibir "BIN2PRG" o "PRG2BIN" en el primer parámetro, los invierto.
IF    Atc('-BIN2PRG'    , '-'+tc_InputFile) > 0 ;
   Or Atc('-PRG2BIN'    , '-'+tc_InputFile) > 0 ;
   OR Atc('-BIN2TEXT'   , '-'+tc_InputFile) > 0 ;
   Or Atc('-TEXT2BIN'   , '-'+tc_InputFile) > 0 ;
   OR Atc('-SHOWMSG'    , '-'+tc_InputFile) > 0 ;
   Or Atc('-INTERACTIVE', '-'+tc_InputFile) > 0 ;
   Or Atc('-?'          , '-'+tc_InputFile) > 0 ;
   OR Atc('-SIMERR_I0'  , '-'+tc_InputFile) > 0 ;
   Or Atc('-SIMERR_I1'  , '-'+tc_InputFile) > 0 ;
   OR Atc('-SIMERR_O1'  , '-'+tc_InputFile) > 0 ;
   OR Upper(tc_InputFile) == '-C' ;
   OR Upper(tc_InputFile) ==  'C' ;
   Or tc_InputFile == '-t' ;
   Or tc_InputFile ==  't'

   pcParamX     = tc_InputFile
   tc_InputFile = tcType
   tcType       = pcParamX
   Release pcParamX

ENDIF

* -cCt Create config files
If    Upper(tcType) == '-C' ;
   OR Upper(tcType) ==  'C' ;
   OR tcType == '-t' ;
   OR tcType ==  't'

   If Pcount() > 2
      tcCFG_File = tcTextName

      IF Vartype(tcCFG_File) = "C" AND Empty(JustPath(tcCFG_File))
         tcCFG_File = FullPath(tcCFG_File, "")
      ENDIF

      tcTextName = .F.
   ENDIF

   If Pcount() > 3
      tcDebug   = tlGenText
      tlGenText = .F.
   ENDIF

   DO CASE
    CASE Pcount() > 4
         tc_InputFile = ""
         tcType       = ""

    Case ! Empty(tc_InputFile)

    CASE ( tcType == '-t' OR tcType == 't' ) And ! Empty( Dbf() )
         tc_InputFile = Dbf() + '._cfg'

    CASE ( Upper( tcType ) =='-C' OR Upper( tcType ) =='C' ) And tc_InputFile
         tc_InputFile = 'FoxBin2PRG._cfg'

    Endcase

ENDIF

TRY
   loEx  = .Null.
   loCnv = NewObject( "c_foxbin2prg", "foxbin2prg.prg", "foxbin2prg.exe" )

   *** handle tcOutputFolder
   IF Not Empty(tcOutputFolder)
      loCnv.cOutputFolder = tcOutputFolder
   ENDIF

   lnResp  = loCnv.execute( tc_InputFile              , tcType            , tcTextName        , tlGenText   ;
                          , tcDontShowErrors          , tcDebug           , tcDontShowProgress, .Null.      ;
                          , @loEx                     , .F.               , tcOriginalFileName, tcRecompile ;
                          , tcNoTimestamps            , .F.               , .F.               , .F.         ;
                          , tcCFG_File                )

CATCH TO loEx
   *-- Esto solo es para errores en el INIT, ya que los demás se deben capturar y tratar antes.
   lnResp      = loEx.ErrorNo
   Messagebox( 'Error ' + Transform(loEx.ErrorNo) + ', ' + loEx.Message + C_CR ;
             + loEx.Procedure + ', Line ' + Transform(loEx.Lineno) + C_CR ;
             + loEx.Details ;
             , 0+16+4096 ;
             , '' ;
             , 60000 )

ENDTRY

AddProperty(_Screen, 'ExitCode', lnResp)

If _vfp.StartMode <> 4 Or Not Sys(16) == Sys(16,0)
   && _vfp.StartMode 4 = Visual FoxPro was started as a distributable .app or .exe file.
   Store .Null. To loEx, loCnv
   Release loEx, loCnv

   * lnResp contiene un código de error, pero invocado desde SourceSafe puede contener el tipo de soporte de archivo (0,1,2).
   Return lnResp
Endif

If Empty(lnResp)
   Store .Null. To loEx, loCnv
   Release loEx, loCnv
   Quit
Endif

STORE .Null. To loEx, loCnv
RELEASE loEx, loCnv

*-- Muy útil para procesos batch que capturan el código de error
*KillMode 1
*DECLARE ExitProcess IN Win32API INTEGER ExitCode && To read returned error code with ERRORLEVEL from Windows
*ExitProcess(1) && Esta debe ser de las últimas instrucciones

*KillMode 2 - This one works better.
Declare Integer OpenProcess      In Win32API Integer dwDesiredAccess, Integer bInheritHandle, Integer dwProcessID
Declare Integer TerminateProcess In Win32API Integer hProcess, Integer uExitCode

lnHandle = OpenProcess(1, 1, _vfp.ProcessID)
=TerminateProcess(lnHandle,1)

*KillMode 3
*lcComputer = [.]
*loCIMV2 = GETOBJECT( [winmgmts:{impersonationLevel=impersonate}!\\] + lcComputer + [\root\cimv2] )
*loProcCols = loCIMV2.ExecQuery( [select * from Win32_Process where processid=] + TRANSFORM(_VFP.PROCESSID) + [] )
*loCIMV2 = .Null.
*loProcCols.ItemIndex(0).TERMINATE(1)
