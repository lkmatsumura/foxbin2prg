#INCLUDE foxbin2prg.h

Define Class CL_PROJ_FILE As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_PROJ_FILE Of 'cl_proj_file.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_comments" display="_Comments"/>] ;
      + [<memberdata name="_cpid" display="_CPID"/>] ;
      + [<memberdata name="_exclude" display="_Exclude"/>] ;
      + [<memberdata name="_id" display="_ID"/>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="_objrev" display="_ObjRev"/>] ;
      + [<memberdata name="_timestamp" display="_Timestamp"/>] ;
      + [<memberdata name="_type" display="_Type"/>] ;
      + [<memberdata name="_user" display="_User"/>] ;
      + [<memberdata name="_devinfo" display="_DevInfo"/>] ;
      + [</VFPData>]

   _Name               = ''
   _Type               = ''
   _Exclude            = .F.
   _Comments           = ''
   _cpid               = 0
   _ID                 = 0
   _ObjRev             = 0
   _TimeStamp          = 0
   _User               = ''
   _DevInfo            = ''

Enddefine
