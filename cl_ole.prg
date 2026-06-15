#INCLUDE foxbin2prg.h

Define Class CL_OLE As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_OLE Of 'cl_ole.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_checksum" display="_CheckSum"/>] ;
      + [<memberdata name="_nombre" display="_Nombre"/>] ;
      + [<memberdata name="_objname" display="_ObjName"/>] ;
      + [<memberdata name="_parent" display="_Parent"/>] ;
      + [<memberdata name="_value" display="_Value"/>] ;
      + [</VFPData>]

   _Nombre     = ''
   _Parent     = ''
   _ObjName    = ''
   _CheckSum   = ''
   _Value      = ''
Enddefine
