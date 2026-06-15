#INCLUDE foxbin2prg.h

Define Class CL_OBJETO As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_OBJETO Of 'cl_objeto.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="add_procedure" display="add_Procedure"/>] ;
      + [<memberdata name="add_property" display="add_Property"/>] ;
      + [<memberdata name="c_texterr" display="c_TextErr"/>] ;
      + [<memberdata name="_aprocnames" display="_aProcNames"/>] ;
      + [<memberdata name="_baseclass" display="_BaseClass"/>] ;
      + [<memberdata name="_class" display="_Class"/>] ;
      + [<memberdata name="_classlib" display="_ClassLib"/>] ;
      + [<memberdata name="_nombre" display="_Nombre"/>] ;
      + [<memberdata name="_objname" display="_ObjName"/>] ;
      + [<memberdata name="_ole" display="_Ole"/>] ;
      + [<memberdata name="_ole2" display="_Ole2"/>] ;
      + [<memberdata name="_parent" display="_Parent"/>] ;
      + [<memberdata name="_writeorder" display="_WriteOrder"/>] ;
      + [<memberdata name="_procedures" display="_Procedures"/>] ;
      + [<memberdata name="_procedure_count" display="_Procedure_Count"/>] ;
      + [<memberdata name="_props" display="_Props"/>] ;
      + [<memberdata name="_prop_count" display="_Prop_Count"/>] ;
      + [<memberdata name="_timestamp" display="_TimeStamp"/>] ;
      + [<memberdata name="_uniqueid" display="_UniqueID"/>] ;
      + [<memberdata name="_user" display="_User"/>] ;
      + [<memberdata name="_zorder" display="_ZOrder"/>] ;
      + [</VFPData>]

   Dimension _Props[1,1], _Procedures[1], _aProcNames[1]
   c_TextErr           = ''
   _Nombre             = ''
   _ObjName            = ''
   _Parent             = ''
   _Class              = ''
   _ClassLib           = ''
   _BaseClass          = ''
   _UniqueID           = ''
   _TimeStamp          = 0
   _Ole                = ''
   _Ole2               = ''
   _Prop_Count         = 0
   _Procedure_Count    = 0
   _User               = ''
   _WriteOrder         = 0
   _ZOrder             = 0



   Procedure add_Procedure
      Lparameters toProcedure

      #If .F.
         Local toProcedure As CL_PROCEDURE Of 'cl_procedure.prg'
      #Endif

      With This As CL_OBJETO Of 'cl_objeto.prg'
         If '.' $ ._Nombre
            toProcedure._Nombre = Substr( toProcedure._Nombre, At( '.', toProcedure._Nombre, Occurs( '.', ._Nombre) ) + 1 )
         Endif

         *-- Verificación de Procedure repetido
         If ._Procedure_Count > 0 And Ascan( ._aProcNames, toProcedure._Nombre, 1, 0, 0, 1+2+4 ) > 0 Then
            .writeErrorLog( '* Duplicated Method "' + toProcedure._Nombre + '" of class.object "' ;
               + ._Nombre + '" @line ' + Transform(toProcedure._Inicio) )
         Endif

         ._Procedure_Count   = ._Procedure_Count + 1
         Dimension ._Procedures( ._Procedure_Count )
         Dimension ._aProcNames( ._Procedure_Count )
         ._Procedures( ._Procedure_Count )   = toProcedure
         ._aProcNames( ._Procedure_Count )   = toProcedure._Nombre
      Endwith && THIS
   Endproc



   Procedure add_Property
      Lparameters tcProperty As String, tcValue As String

      With This As CL_OBJETO Of 'cl_objeto.prg'
         ._Prop_Count    = ._Prop_Count + 1
         Dimension ._Props( ._Prop_Count, 2 )
         ._Props( ._Prop_Count, 1 )  = tcProperty
         ._Props( ._Prop_Count, 2 )  = tcValue
      Endwith && THIS
   Endproc


Enddefine
