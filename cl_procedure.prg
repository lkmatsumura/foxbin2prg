#INCLUDE foxbin2prg.h

Define Class CL_PROCEDURE As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_PROCEDURE Of 'cl_procedure.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="add_line" display="add_Line"/>] ;
      + [<memberdata name="_comentario" display="_Comentario"/>] ;
      + [<memberdata name="_inicio" display="_Inicio"/>] ;
      + [<memberdata name="_nombre" display="_Nombre"/>] ;
      + [<memberdata name="_procline_count" display="_ProcLine_Count"/>] ;
      + [<memberdata name="_proclines" display="_ProcLines"/>] ;
      + [<memberdata name="_proctype" display="_ProcType"/>] ;
      + [</VFPData>]

   Dimension _ProcLines[1]
   _Nombre         = ''
   _ProcType       = ''
   _Comentario     = ''
   _ProcLine_Count = 0
   _Inicio         = 0



   Procedure add_Line
      Lparameters tcLine As String

      With This As CL_CLASE Of 'cl_clase.prg'
         ._ProcLine_Count    = ._ProcLine_Count + 1
         Dimension ._ProcLines( ._ProcLine_Count )
         ._ProcLines( ._ProcLine_Count ) = tcLine
      Endwith && THIS
   Endproc

Enddefine
