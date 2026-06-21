#INCLUDE foxbin2prg.h

Define Class CL_DBF_UTILS As Session
   _MemberData = [<VFPData>] ;
      + [<memberdata name="fields" display="Fields"/>] ;
      + [<memberdata name="c_backlink_dbc_name" display="c_Backlink_DBC_Name"/>] ;
      + [<memberdata name="c_filename" display="c_FileName"/>] ;
      + [<memberdata name="n_headersize" display="n_HeaderSize"/>] ;
      + [<memberdata name="n_filesize" display="n_FileSize"/>] ;
      + [<memberdata name="c_lastupdate" display="c_LastUpdate"/>] ;
      + [<memberdata name="n_debug" display="n_Debug"/>] ;
      + [<memberdata name="l_filehascdx" display="l_FileHasCDX"/>] ;
      + [<memberdata name="l_fileisdbc" display="l_FileIsDBC"/>] ;
      + [<memberdata name="l_filehasmemo" display="l_FileHasMemo"/>] ;
      + [<memberdata name="n_codepage" display="n_CodePage"/>] ;
      + [<memberdata name="c_codepagedesc" display="c_CodePageDesc"/>] ;
      + [<memberdata name="n_datarecordlength" display="n_DataRecordLength"/>] ;
      + [<memberdata name="n_fieldcount" display="n_FieldCount"/>] ;
      + [<memberdata name="n_hexfiletype" display="n_HexFileType"/>] ;
      + [<memberdata name="n_numberofrecords" display="n_NumberOfRecords"/>] ;
      + [<memberdata name="n_numberofrecordsreal" display="n_NumberOfRecordsReal"/>] ;
      + [<memberdata name="n_posoffirstdatarecord" display="n_PosOfFirstDataRecord"/>] ;
      + [<memberdata name="filetypedescription" display="fileTypeDescription"/>] ;
      + [<memberdata name="getcodepageinfo" display="getCodePageInfo"/>] ;
      + [<memberdata name="getdbfmetadata" display="getDBFmetadata"/>] ;
      + [<memberdata name="get_bintableflags" display="get_BinTableFlags"/>] ;
      + [<memberdata name="get_numtableflags" display="get_NumTableFlags"/>] ;
      + [<memberdata name="get_structure" display="get_Structure"/>] ;
      + [<memberdata name="set_bintableflags" display="set_BinTableFlags"/>] ;
      + [<memberdata name="set_numtableflags" display="set_NumTableFlags"/>] ;
      + [<memberdata name="totext" display="toText"/>] ;
      + [<memberdata name="write_dbc_backlink" display="write_DBC_BackLink"/>] ;
      + [</VFPData>]

   #If .F.
      Local This As CL_DBF_UTILS Of 'cl_dbf_utils.prg'
   #Endif

   n_Debug                 = 0
   c_Backlink_DBC_Name     = ''
   c_FileName              = ''
   n_FileSize              = 0
   n_HeaderSize            = 0
   c_LastUpdate            = ''
   l_FileHasCDX            = .F.
   l_FileIsDBC             = .F.
   l_FileHasMemo           = .F.
   n_CodePage              = 0
   c_CodePageDesc          = ''
   n_DataRecordLength      = 0
   n_HexFileType           = 0
   n_FieldCount            = 0
   n_NumberOfRecords       = 0
   n_NumberOfRecordsReal   = 0
   n_PosOfFirstDataRecord  = 0
   Fields                  = .Null.


   Procedure Init
      This.Fields = Createobject("COLLECTION")
   Endproc


   Procedure getDBFmetadata
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_FileName               (v! IN    ) Nombre del DBF a analizar
      * tn_HexFileType            (@?    OUT) Tipo de archivo en hexadecimal (Está detallado en la ayuda de Fox)
      * tl_FileHasCDX             (@?    OUT) Indica si el archivo tiene CDX asociado
      * tl_FileHasMemo            (@?    OUT) Indica si el archivo tiene archivo MEMO asociado
      * tl_FileIsDBC              (@?    OUT) Indica si el archivo es un DBC (base de datos)
      * tcDBC_Name                (@?    OUT) Si tiene DBC, contiene el nombre del DBC asociado
      *---------------------------------------------------------------------------------------------------
      Lparameters tc_FileName, tn_HexFileType, tl_FileHasCDX, tl_FileHasMemo, tl_FileIsDBC, tcDBC_Name

      Try
         Local lnHandle, lcStr, lnDataPos, lnFieldCount, lnVal, I, loEx As Exception ;
            , lnCodePage, lcCodePageDesc, lnFileLength ;
            , loField As CL_DBF_UTILS_FIELD Of 'cl_dbf_utils_field.prg'
         Store .Null. To loField
         tn_HexFileType  = 0
         Store '' To tcDBC_Name, lcStr
         lnHandle        = Fopen(tc_FileName,0)
         lnFileLength    = Fseek(lnHandle,0,2)
         = Fseek(lnHandle,0)

         If lnHandle = -1
            Exit
         Endif

         *                                                       Bytes       Description
         *------------------------------------------------------ ----------- ------------------------------------------
         With This As CL_DBF_UTILS Of 'cl_dbf_utils.prg'
            .c_FileName                 = tc_FileName
            lcStr                       = Fread(lnHandle,1)     && 0        File type
            tn_HexFileType              = Evaluate( Transform(Asc(lcStr),'@0') )

            Do Case
            Case lnFileLength < 65
               Error 15, tc_FileName + ' (FileLength < 65)'
            Case .fileTypeDescription(tn_HexFileType) = 'Unknown'
               Error 15, tc_FileName
            Endcase

            .n_HexFileType              = tn_HexFileType
            lcStr                       = Fread(lnHandle,3)     && 1-3      Last update (YYMMDD)
            .c_LastUpdate               = Padl(Asc(Left(lcStr,1)),2,'0') + '/' + Padl(Asc(Substr(lcStr,2,1)),2,'0') + '/' + Padl(Asc(Right(lcStr,1)),2,'0')
            lcStr                       = Fread(lnHandle,4)     && 4-7      Number of records in file
            .n_NumberOfRecords          = CToBin(lcStr,"4RS")
            lcStr                       = Fread(lnHandle,2)     && 8-9      Position of first data record
            .n_PosOfFirstDataRecord     = CToBin(lcStr,"2RS")
            .n_HeaderSize               = Int(.n_PosOfFirstDataRecord + 1)
            If Inlist(tn_HexFileType, 0x30, 0x31, 0x32) Then
               .n_FieldCount   = Int( (.n_PosOfFirstDataRecord - 296) / 32 )   && Visual FoxPro
            Else
               .n_FieldCount   = Int( (.n_PosOfFirstDataRecord - 33) / 32 )
            Endif
            lcStr                       = Fread(lnHandle,2)     && 10-11    Length of one data record, including delete flag
            .n_DataRecordLength         = CToBin(lcStr,"2RS")
            lcStr                       = Fread(lnHandle,16)    && 16-27    Reserved
            lcStr                       = Fread(lnHandle,1)     && 28       Table flags: 0x01=Has CDX, 0x02=Has Memo, 0x04=Id DBC (flags acumulativos)
            .l_FileHasCDX               = ( Bitand( Evaluate(Transform(Asc(lcStr),'@0')), 0x01 ) > 0 )
            .l_FileHasMemo              = ( Bitand( Evaluate(Transform(Asc(lcStr),'@0')), 0x02 ) > 0 )
            .l_FileIsDBC                = ( Bitand( Evaluate(Transform(Asc(lcStr),'@0')), 0x04 ) > 0 )
            lcStr                       = Fread(lnHandle,1)     && 29       Code page mark (0=, 2=850,3=1252)
            lnVal                       = Evaluate( Transform(Asc(lcStr),'@0') )
            .getCodePageInfo( lnVal, @lnCodePage, @lcCodePageDesc )
            .n_CodePage                 = lnCodePage
            .c_CodePageDesc             = lcCodePageDesc
            lcStr                       = Fread(lnHandle,2)     && 30-31    Reserved, contains 0x00
            *lcStr                      = FREAD(lnHandle,32 * lnFieldCount) && 32-n         Field subrecords (los salteo)
            *---
            For I = 1 To .n_FieldCount
               loField = NewObject('CL_DBF_UTILS_FIELD', 'cl_dbf_utils_field.prg')

               With loField As CL_DBF_UTILS_FIELD Of 'cl_dbf_utils_field.prg'
                  lcStr                       = Fread(lnHandle,11)
                  .FieldName                  = Rtrim( lcStr, 0, Chr(0), ' ' )
                  lcStr                       = Fread(lnHandle,1)
                  .FieldType                  = lcStr
                  lcStr                       = Fread(lnHandle,4)
                  .FieldDisplacementInRecord  = CToBin(lcStr,"4RS")
                  lcStr                       = Fread(lnHandle,1)
                  .FieldWidth                 = Asc(lcStr)
                  lcStr                       = Fread(lnHandle,1)
                  .FieldDecimals              = Asc(lcStr)
                  lcStr                       = Fread(lnHandle,1)
                  .FieldFlags                 = Asc(lcStr)
                  lcStr                       = Fread(lnHandle,4)
                  .NextValueForAutoInc        = CToBin(lcStr,"4RS")
                  lcStr                       = Fread(lnHandle,1)
                  .StepForAutoInc             = Asc(lcStr)
                  lcStr                       = Fread(lnHandle,8)
               Endwith

               .Fields.Add(loField)
               loField = .Null.
            Endfor
            *---
            lcStr                       = Fread(lnHandle,1)     && n+1          Header Record Terminator (0x0D)

            If Inlist(tn_HexFileType, 0x30, 0x31, 0x32) Then
               lcStr                   = Fread(lnHandle,263)   && n+2 to n+264 Backlink (relative path of an associated database (.dbc) file)
               tcDBC_Name              = Rtrim(lcStr,0,Chr(0)) && DBC Name (si tiene)
               .c_Backlink_DBC_Name    = tcDBC_Name
            Endif

            .n_FileSize             = Fseek(lnHandle, 0, 2)
            .n_NumberOfRecordsReal  = Int( (.n_FileSize - .n_HeaderSize) / .n_DataRecordLength )
         Endwith

      Catch To loEx
         loEx.UserValue = loEx.UserValue + 'lcStr = [' + Transform(lcStr) + '] / LenStr = ' + Transform(Len(Transform(lcStr))) + CR_LF
         If loEx.ErrorNo = 11 Then   && Function argument value, type, or count is invalid
            loEx.UserValue = loEx.UserValue + '> POSSIBLE CORRUPTED TABLE' + CR_LF
         Endif
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Fclose(lnHandle)
         Store .Null. To loField
         Release lcStr, lnDataPos, lnFieldCount, lnVal, I, lnCodePage, lcCodePageDesc, loField

      Endtry

      Return lnHandle
   Endproc


   Procedure fileTypeDescription
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tn_HexFileType            (@? IN    ) Tipo de archivo en hexadecimal (Está detallado en la ayuda de Fox)
      *---------------------------------------------------------------------------------------------------
      Lparameters tn_HexFileType
      Local lcFileType

      Do Case
      Case tn_HexFileType = 0x02                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'FoxBASE / dBase II'
      Case tn_HexFileType = 0x03                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'FoxBASE+ / FoxPro /dBase III PLUS / dBase IV, no memo'
      Case tn_HexFileType = 0x05                                                  && http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'dBase V, no memo'
      Case tn_HexFileType = 0x2F                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
         lcFileType  = 'dBase+/dBase III PLUS, no memo'
      Case tn_HexFileType = 0x30                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'Visual FoxPro'
      Case tn_HexFileType = 0x31                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'Visual FoxPro, autoincrement enabled'
      Case tn_HexFileType = 0x32                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'Visual FoxPro, Varchar, Varbinary, or Blob-enabled'
      Case tn_HexFileType = 0x43                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'dBASE IV SQL table files, no memo'
      Case tn_HexFileType = 0x62                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
         lcFileType  = 'dBASE IV SQL table files, no memo'
      Case tn_HexFileType = 0x63                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'dBASE IV SQL system files, no memo'
      Case tn_HexFileType = 0x7B                                                  && http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'dBASE IV, with memo'
      Case tn_HexFileType = 0x82                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
         lcFileType  = 'dBASE IV SQL system files, no memo'
      Case tn_HexFileType = 0x83                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'FoxBASE+/dBASE III PLUS, with memo'
      Case tn_HexFileType = 0x8B                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'dBASE IV with memo'
      Case tn_HexFileType = 0x8E                                                  && http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'dBASE IV with SQL table'
      Case tn_HexFileType = 0xCA                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
         lcFileType  = 'dBASE IV with memo'
      Case tn_HexFileType = 0xCB                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'dBASE IV SQL table files, with memo'
      Case tn_HexFileType = 0xE5                                                  && http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'Clipper SIX driver, with SMT memo'
      Case tn_HexFileType = 0xF5                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'FoxPro 2.x (or earlier) with memo'
      Case tn_HexFileType = 0xFA                                                  && https://msdn.microsoft.com/en-us/subscriptions/securedownloads/st4a0s68%28v=vs.80%29
         lcFileType  = 'FoxPro 2.x (or earlier) with memo'
      Case tn_HexFileType = 0xFB                                                  && VFP 9 SP2 Help file, VFPX Edition v1.07.2 debug (beta) // http://stackoverflow.com/questions/3391525/which-header-format-can-be-assumed-by-reading-an-initial-dbf-byte
         lcFileType  = 'FoxBASE (with memo?)'
      Otherwise
         lcFileType  = 'Unknown'
      Endcase

      Return lcFileType
   Endproc


   Procedure getCodePageInfo
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tnHexCodePage             (v! IN    ) Código de página en hexadecimal (Está detallado en la ayuda de Fox)
      * tnCodePage                (@?    OUT) Código de página normal
      * tcDescrip                 (@?    OUT) Descripción del código de página
      *---------------------------------------------------------------------------------------------------
      Lparameters tnHexCodePage, tnCodePage, tcDescrip

      Local laCodePage(27,3), lnPos
      *Code page  Platform  Code page identifier
      laCodePage( 1,1)    = 437
      laCodePage( 1,2)    = 'U.S. MS-DOS'
      laCodePage( 1,3)    = 0x01

      laCodePage( 2,1)    = 620
      laCodePage( 2,2)    = 'Mazovia (Polish) MS-DOS'
      laCodePage( 2,3)    = 0x69

      laCodePage( 3,1)    = 737
      laCodePage( 3,2)    = 'Greek MS-DOS (437G)'
      laCodePage( 3,3)    = 0x6A

      laCodePage( 4,1)    = 850
      laCodePage( 4,2)    = 'International MS-DOS'
      laCodePage( 4,3)    = 0x02

      laCodePage( 5,1)    = 852
      laCodePage( 5,2)    = 'Eastern European MS-DOS'
      laCodePage( 5,3)    = 0x64

      laCodePage( 6,1)    = 857
      laCodePage( 6,2)    = 'Turkish MS-DOS'
      laCodePage( 6,3)    = 0x6B

      laCodePage( 7,1)    = 861
      laCodePage( 7,2)    = 'Icelandic MS-DOS'
      laCodePage( 7,3)    = 0x67

      laCodePage( 8,1)    = 865
      laCodePage( 8,2)    = 'Nordic MS-DOS'
      laCodePage( 8,3)    = 0x66

      laCodePage( 9,1)    = 866
      laCodePage( 9,2)    = 'Russian MS-DOS'
      laCodePage( 9,3)    = 0x65

      laCodePage(10,1)    = 874
      laCodePage(10,2)    = 'Thai Windows'
      laCodePage(10,3)    = 0x7C

      laCodePage(12,1)    = 895
      laCodePage(12,2)    = 'Kamenicky (Czech) MS-DOS'
      laCodePage(12,3)    = 0x68

      laCodePage(13,1)    = 932
      laCodePage(13,2)    = 'Japanese Windows'
      laCodePage(13,3)    = 0x7B

      laCodePage(14,1)    = 936
      laCodePage(14,2)    = 'Chinese Simplified (PRC, Singapore) Windows'
      laCodePage(14,3)    = 0x7A

      laCodePage(15,1)    = 949
      laCodePage(15,2)    = 'Korean Windows'
      laCodePage(15,3)    = 0x79

      laCodePage(16,1)    = 950
      laCodePage(16,2)    = 'Traditional Chinese (Hong Kong SAR, Taiwan) Windows'
      laCodePage(16,3)    = 0x78

      laCodePage(17,1)    = 1250
      laCodePage(17,2)    = 'Eastern European Windows'
      laCodePage(17,3)    = 0xC8

      laCodePage(18,1)    = 1251
      laCodePage(18,2)    = 'Russian Windows'
      laCodePage(18,3)    = 0xC9

      laCodePage(19,1)    = 1252
      laCodePage(19,2)    = 'Windows ANSI'
      laCodePage(19,3)    = 0x03

      laCodePage(20,1)    = 1253
      laCodePage(20,2)    = 'Greek Windows'
      laCodePage(20,3)    = 0xCB

      laCodePage(21,1)    = 1254
      laCodePage(21,2)    = 'Turkish Windows'
      laCodePage(21,3)    = 0xCA

      laCodePage(22,1)    = 1255
      laCodePage(22,2)    = 'Hebrew Windows'
      laCodePage(22,3)    = 0x7D

      laCodePage(23,1)    = 1256
      laCodePage(23,2)    = 'Arabic Windows'
      laCodePage(23,3)    = 0x7E

      laCodePage(24,1)    = 10000
      laCodePage(24,2)    = 'Standard Macintosh'
      laCodePage(24,3)    = 0x04

      laCodePage(25,1)    = 10006
      laCodePage(25,2)    = 'Greek Macintosh'
      laCodePage(25,3)    = 0x98

      laCodePage(26,1)    = 10007
      laCodePage(26,2)    = 'Russian Macintosh'
      laCodePage(26,3)    = 0x96

      laCodePage(27,1)    = 10029
      laCodePage(27,2)    = 'Macintosh EE'
      laCodePage(27,3)    = 0x97

      lnPos   = Ascan( laCodePage, tnHexCodePage, 1, -1, 3, 8 )

      If lnPos > 0
         tnCodePage  = laCodePage(lnPos,1)
         tcDescrip   = laCodePage(lnPos,2)
      Else
         tnCodePage  = 0
         tcDescrip   = ''
      Endif

      Return
   Endproc


   Procedure toText
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      *---------------------------------------------------------------------------------------------------
      Local lcText, loField As CL_DBF_UTILS_FIELD Of 'cl_dbf_utils_field.prg'
      lcText  = ''

      With This As CL_DBF_UTILS Of 'cl_dbf_utils.prg'
         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2
                ---------------------------------------------------
                FileName                : <<JUSTFNAME(.c_FileName)>>
                ---------------------------------------------------
                Backlink_DBC_Name       : <<.c_Backlink_DBC_Name>>
                HexFileType             : <<TRANSFORM(.n_HexFileType, '@0')>> - <<.fileTypeDescription(.n_HexFileType)>>
                FileSize                : <<.n_FileSize>> bytes
                LastUpdate              : <<.c_LastUpdate>>
                NumberOfRecords         : <<.n_NumberOfRecords>> - REAL: <<.n_NumberOfRecordsReal>>
                PosOfFirstDataRecord    : <<.n_PosOfFirstDataRecord>>
                FieldCount              : <<.n_FieldCount>>
                DataRecordLength        : <<.n_DataRecordLength>>
                FileHasCDX              : <<.l_FileHasCDX>>
                FileHasMemo             : <<.l_FileHasMemo>>
                FileIsDBC               : <<.l_FileIsDBC>>
                CodePage                : <<.n_CodePage>> - <<.c_CodePageDesc>>

                ---------------------------------------------------
         ENDTEXT

         *-- Fields
         loField = .Fields.Item(1)
         lcText  = lcText + CR_LF + loField.toText(.T.)

         For Each loField As CL_DBF_UTILS_FIELD Of 'cl_dbf_utils_field.prg' In .Fields
            lcText  = lcText + CR_LF + loField.toText()
         Endfor

         TEXT TO lcText ADDITIVE TEXTMERGE NOSHOW FLAGS 1+2 PRETEXT 1+2

                ---------------------------------------------------
                Field flags Reference:
                0x01   System Column (not visible to user)
                0x02   Column can store .Null. values
                0x04   Binary column (for CHAR and MEMO only)
                0x06   (0x02+0x04) When a field is .Null. and binary (Integer, Currency, and Character/Memo fields)
                0x0C   Column is autoincrementing

         ENDTEXT

      Endwith

      Return lcText
   Endproc


   Procedure write_DBC_BackLink
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_FileName               (v! IN    ) Nombre del DBF a analizar
      * tcDBC_Name                (v! IN    ) Nombre del DBC a asociar
      * tdLastUpdate              (v! IN    ) Fecha de última actualización
      *---------------------------------------------------------------------------------------------------
      Lparameters tc_FileName, tcDBC_Name, tdLastUpdate

      Try
         Local lnHandle, ln_HexFileType, lcStr, lnDataPos, lnFieldCount, loEx As Exception

         tcDBC_Name  = Evl(tcDBC_Name,'')

         *IF NOT EMPTY(tcDBC_Name)
         ln_HexFileType  = 0
         lnHandle        = Fopen(tc_FileName,2)

         If lnHandle = -1
            Exit
         Endif

         lcStr           = Fread(lnHandle,1)     && File type
         ln_HexFileType  = Evaluate( Transform(Asc(lcStr),'@0') )

         If Empty(tdLastUpdate)
            lcStr   = Fread(lnHandle,3)     && Last update (YYMMDD)
         Else
            lcStr   = Chr( Val( Right( Padl( Year( tdLastUpdate ),4,'0'), 2 ) ) ) ;
               + Chr( Val( Padl( Month( tdLastUpdate ),2,'0' ) ) ) ;
               + Chr( Val( Padl( Day( tdLastUpdate ),2,'0' ) ) )       &&  Last update (YYMMDD)
            =Fwrite( lnHandle, Padr(lcStr,3,Chr(0)) )
         Endif

         =Fread(lnHandle,4)      && Number of records in file
         lcStr           = Fread(lnHandle,2)     && Position of first data record
         lnDataPos       = CToBin(lcStr,"2RS")
         If Inlist(ln_HexFileType, 0x30, 0x31, 0x32) Then
            lnFieldCount    = (lnDataPos - 296) / 32
         Else
            Exit    && No DBC BackLink on older versions!
         Endif
         =Fread(lnHandle,2)      && Length of one data record, including delete flag
         =Fread(lnHandle,16)     && Reserved
         =Fread(lnHandle,1)      && Table flags: 0x01=Has CDX, 0x02=Has Memo, 0x04=Id DBC (flags acumulativos)
         =Fread(lnHandle,1)      && Code page mark
         =Fread(lnHandle,2)      && Reserved, contains 0x00
         =Fread(lnHandle,32 * lnFieldCount)      && Field subrecords (los salteo)
         =Fread(lnHandle,1)      && Header Record Terminator (0x0D)

         If Inlist(ln_HexFileType, 0x30, 0x31, 0x32) Then
            If Fwrite( lnHandle, Padr(tcDBC_Name,263,Chr(0)) ) = 0
               *-- No se pudo actualizar el backlink [] de la tabla []
               Error C_BACKLINK_CANT_UPDATE_BL_LOC + ' [' + tcDBC_Name + '] ' + C_BACKLINK_OF_TABLE_LOC + ' [' + tc_FileName + ']'
            Endif
         Endif
         *ENDIF


      Catch To loEx
         If This.n_Debug > 0 And _vfp.StartMode = 0
            Set Step On
         Endif

         Throw

      Finally
         Fclose(lnHandle)
      Endtry

      Return lnHandle
   Endproc


   Function get_Structure
      Lparameters taFields, tc_FileName

      With This As CL_DBF_UTILS Of 'lib_indices.prg'
         Local lnFieldCount
         lnFieldCount = 0

         If Not Empty(tc_FileName)
            .getDBFmetadata(tc_FileName)
         Endif

         lnFieldCount    = .n_FieldCount
         Dimension taFields(lnFieldCount,4)

         For I = 1 To lnFieldCount
            With .Fields.Item(m.I)
               taFields(m.I,1) = .FieldName
               taFields(m.I,2) = .FieldType
               taFields(m.I,3) = .FieldWidth
               taFields(m.I,4) = .FieldDecimals
            Endwith
         Endfor
      Endwith

      Return lnFieldCount
   Endfunc


   Procedure get_BinTableFlags
      *-- Leo los flags de la tabla indicada
      Lparameters tcFile

      Local lnHandle, lcTableFlags
      lnHandle        = Fopen(tcFile,0)
      Fseek(lnHandle,28)
      lcTableFlags    = Fread(lnHandle,1)
      Fclose(lnHandle)
      Return lcTableFlags
   Endproc


   Procedure get_NumTableFlags
      *-- Leo los flags de la tabla indicada
      Lparameters tcFile
      Return Asc( This.get_BinTableFlags(tcFile) )
   Endproc


   Procedure set_BinTableFlags
      *-- Seteo los flags en la tabla indicada
      Lparameters tcFile, tcBinTableFlags

      Local lnHandle, lnWritten
      lnHandle        = Fopen(tcFile,1)
      Fseek(lnHandle,28)
      lnWritten   = Fwrite(lnHandle, tcTableFlags, 1)
      Fclose(lnHandle)
      Return lnWritten
   Endproc


   Procedure set_NumTableFlags
      *-- Seteo los flags en la tabla indicada
      Lparameters tcFile, tnNumTableFlags
      Return This.set_BinTableFlags( tcFile, Chr(tnNumTableFlags) )
   Endproc

Enddefine
