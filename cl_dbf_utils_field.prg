#INCLUDE foxbin2prg.h

Define Class CL_DBF_UTILS_FIELD As Custom
   _MemberData = [<VFPData>] ;
      + [<memberdata name="fieldname" display="FieldName"/>] ;
      + [<memberdata name="fieldtype" display="FieldType"/>] ;
      + [<memberdata name="fieldwidth" display="FieldWidth"/>] ;
      + [<memberdata name="fielddecimals" display="FieldDecimals"/>] ;
      + [<memberdata name="fieldflags" display="FieldFlags"/>] ;
      + [<memberdata name="fielddisplacementinrecord" display="FieldDisplacementInRecord"/>] ;
      + [<memberdata name="allownulls" display="AllowNulls"/>] ;
      + [<memberdata name="nocodepagetranslation" display="NoCodePageTranslation"/>] ;
      + [<memberdata name="fieldvalidationexpression" display="FieldValidationExpression"/>] ;
      + [<memberdata name="fieldvalidationtext" display="FieldValidationText"/>] ;
      + [<memberdata name="fielddefaultvalue" display="FieldDefaultValue"/>] ;
      + [<memberdata name="tablevalidationexpression" display="TableValidationExpression"/>] ;
      + [<memberdata name="longtablename" display="LongTableName"/>] ;
      + [<memberdata name="tablevalidationtext" display="TableValidationText"/>] ;
      + [<memberdata name="inserttriggerexpression" display="InsertTriggerExpression"/>] ;
      + [<memberdata name="updatetriggerexpression" display="UpdateTriggerExpression"/>] ;
      + [<memberdata name="deletetriggerexpression" display="DeleteTriggerExpression"/>] ;
      + [<memberdata name="tablecomment" display="TableComment"/>] ;
      + [<memberdata name="nextvalueforautoinc" display="NextValueForAutoInc"/>] ;
      + [<memberdata name="stepforautoinc" display="StepForAutoInc"/>] ;
      + [<memberdata name="totext" display="toText"/>] ;
      + [</VFPData>]

   #If .F.
      Local This As CL_DBF_UTILS_FIELD Of 'cl_dbf_utils_field.prg'
   #Endif

   FieldName                   = ''
   FieldType                   = ''
   FieldWidth                  = 0
   FieldDecimals               = 0
   FieldFlags                  = 0
   FieldDisplacementInRecord   = 0
   AllowNulls                  = .F.
   NoCodePageTranslation       = .F.
   FieldValidationExpression   = ''
   FieldValidationText         = ''
   FieldDefaultValue           = ''
   TableValidationExpression   = ''
   TableValidationText         = ''
   LongTableName               = ''
   InsertTriggerExpression     = ''
   UpdateTriggerExpression     = ''
   DeleteTriggerExpression     = ''
   TableComment                = ''
   NextValueForAutoInc         = 0
   StepForAutoInc              = ''


   Procedure toText
      Lparameters tlHeader

      Local lcText
      lcText  = ''

      If tlHeader
         lcText  = lcText + Padr('FieldName',10) + '  ' + Padr('Type',4) + '  ' + Padr('Len',3) + '  ' ;
            + Padr('Dec',3) + '  ' + Padr('Flg',3) + '  ' + Padl('FDiR',4)
         lcText  = lcText + CR_LF + Replicate('-',10) + '  ' + Replicate('-',4) + '  ' + Replicate('-',3) + '  ' ;
            + Replicate('-',3) + '  ' + Replicate('-',3) + '  ' + Replicate('-',4)
      Else
         With This As CL_DBF_UTILS_FIELD Of 'cl_dbf_utils_field.prg'
            lcText  = lcText + Padr(.FieldName,10) + '  ' + Padc(.FieldType,4) + '  ' + Padl(.FieldWidth,3) + '  ' ;
               + Padl(.FieldDecimals,3) + '  ' + Padc(.FieldFlags,3) + '  ' + Padl(.FieldDisplacementInRecord,4)
         Endwith
      Endif

      Return lcText
   Endproc

Enddefine
