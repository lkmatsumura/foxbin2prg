* Unify all the prgs in foxbin2prg.prg

*
* Made basic validations just to be able to have a valid foxbin2prg
*
RELEASE ALL
CLEAR ALL
CLOSE ALL
CLEAR PROGRAM


ERASE foxbin2prg.prg

LOCAL lcF2bPrg, lnI, lnH, lnQtOf , lnOf
LOCAL lcPrg, lcSearch, lcClassPrg, lcReplace , lcF2bHeader
LOCAL laF2bFiles(1)

lnI = Alines( laF2bFiles , Filetostr( 'unify.txt' ), 1+4 )
lcF2bPrg = 'foxbin2prg.prg'

IF lnI > 0
   lnH = fcreate( lcF2bPrg )

   FOR lnI = 1 TO Alen( laF2bFiles , 1 )
      lcPrgOrig= FileToStr( laF2bFiles[ lnI ] )
      lcPrg = lcPrgOrig

      lcPrg = Strtran( lcPrg , "#INCLUDE foxbin2prg.h"   , '' ,1, -1 , 1)

      IF Occurs( "*{place_f2b_header}*" , lcPrg ) > 0
         lcF2bHeader = FileToStr( 'foxbin2prg.h' )
         lcF2bHeader = "#DEFINE MONO_FOXBIN2PRG     1" + Chr(13)+Chr(10) + lcF2bHeader
         lcPrg = Strtran( lcPrg , "*{place_f2b_header}*" , lcF2bHeader ,1, -1 , 1)
         lcF2bHeader = null
      ENDIF

      lnQtOf = Occurs( [ of '] , Lower( lcPrgOrig ) )

      FOR lnOf = 1 TO lnQtOf
          lcSearch   = StrExtract( lcPrgOrig, [ Of '] , ['] , lnOf , 5 )
          lcClassPrg = StrExtract( lcPrgOrig, [ Of '] , ['] , lnOf , 1 )

          IF Is_ValidClassFile( lcClassPrg , .T. ) ;
             AND ! lcClassPrg == lcF2bPrg

             lcReplace = [ Of '] + lcF2bPrg + [']
             lcPrg = Strtran( lcPrg , lcSearch , lcReplace, 1, -1 , 1)
          ENDIF
      ENDFOR

      lnQtOf = Occurs( [.newobject(] , Lower( lcPrgOrig ) )
      FOR lnOf = 1 TO lnQtOf
          lcSearch   = StrExtract( lcPrgOrig , [.NewObject(] , [)] , lnOf , 5 )
          lcClassPrg = StrExtract( lcPrgOrig , [.NewObject(] , [)] , lnOf , 1 )

          lcReplace = ''

          IF ReplaceParam_AddObj( lcClassPrg , @lcReplace)
             lcReplace = [.AddObject(] + lcReplace + [)]
             lcPrg = Strtran( lcPrg , lcSearch , lcReplace , 1, -1 , 1)
          ENDIF

      ENDFOR

      lnQtOf = Occurs( [ newobject(] , Lower( lcPrgOrig ) )

      FOR lnOf = 1 TO lnQtOf
          lcSearch   = StrExtract( lcPrgOrig , [ NewObject(] , [)] , lnOf , 5 )
          lcClassPrg = StrExtract( lcPrgOrig , [ NewObject(] , [)] , lnOf , 1 )

          lcReplace = ''

          IF ReplaceParam_CreateObj( lcClassPrg , @lcReplace)
             lcReplace = [ CreateObject(] + lcReplace + [)]
             lcPrg = Strtran( lcPrg , lcSearch , lcReplace , 1, -1 , 1)
          ENDIF

      ENDFOR

      Fwrite( lnH , lcPrg )
      Fputs( lnH , '' )
   ENDFOR

   Fclose( lnH )
ELSE
   ? 'Erro, não foi possivel carregar lista de prgs a serem reunidos'
ENDIF


*
*
*
PROCEDURE Is_ValidClassFile
LPARAMETERS pcClassfile , plWithExtension
LOCAL lRet , lcValidChars, lcExt

lcValidChars = 'abcdefghijklmnopqrstuvxwyzABCDEFGHIJKLMNOPQRSTUVXWYZ1234567890_'

IF plWithExtension
   lcValidChars = lcValidChars + '.'
ENDIF

lRet = Len( Chrtran( pcClassfile , lcValidChars , '' )) = 0

IF lRet AND plWithExtension
   lcExt = lower( JustExt( pcClassfile ) )
   lRet = ( lcExt == 'prg' )
ENDIF

RETURN lRet

*
*
*
PROCEDURE ReplaceParam_CreateObj
LPARAMETERS  pParOrig , pcReplace
LOCAL lRet  , laPar[1] , lnPar , lcPar2

lnPar = ALines( laPar , pParOrig , 5 , ',' )

lRet = .F.

IF lnPar > 1
   lcPar2 = laPar[2]

   IF InList( Left( lcPar2 , 1 ) , '"' , ['] , "[" )
      lcLDelim = Left( lcPar2 , 1 )
      lcRDelim = ICase( lcLDelim == '[' , ']' , lcLDelim )

      IF Right( lcPar2 , 1 ) == lcRDelim
         lRet = .T.
      ENDIF
   ENDIF

   lRet = lRet AND Is_ValidClassFile( Substr( lcPar2 , 2 , Len( lcPar2 ) - 2 ) , .T. )

   IF lRet
      pcReplace = Strtran( pParOrig  , laPar[2] , [] , 1 , 1 , 2 )
      pcReplace = Strtran( pcReplace , [,] , [] , 1 , 1 , 2 )
   ENDIF

   IF lRet AND lnPar > 2
      pcReplace = Strtran( pcReplace , laPar[3] , [] , 1 , 1 , 2 )
      pcReplace = Strtran( pcReplace , [,] , [] , 2 , 1 , 2 )
   ENDIF

ENDIF

RETURN lRet

*
*
*
PROCEDURE ReplaceParam_AddObj
LPARAMETERS  pParOrig , pcReplace
LOCAL lRet  , laPar[1] , lnPar , lcPar3

lnPar = ALines( laPar , pParOrig , 5 , ',' )

lRet = .F.

IF lnPar > 2
   lcPar3 = laPar[3]

   IF InList( Left( lcPar3 , 1 ) , '"' , ['] , "[" )
      lcLDelim = Left( lcPar3 , 1 )
      lcRDelim = ICase( lcLDelim == '[' , ']' , lcLDelim )

      IF Right( lcPar3 , 1 ) == lcRDelim
         lRet = .T.
      ENDIF
   ENDIF

   lRet = lRet AND Is_ValidClassFile( Substr( lcPar3 , 2 , Len( lcPar3 ) - 2 ) , .T. )

   IF lRet
      pcReplace = Strtran( pParOrig  , laPar[3] , [] , 1 , 1 , 2 )
      pcReplace = Strtran( pcReplace , [,] , [] , 2 , 1 , 2 )
   ENDIF

ENDIF

RETURN lRet