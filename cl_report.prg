#INCLUDE foxbin2prg.h

Define Class CL_REPORT As CL_COL_BASE Of 'cl_col_base.prg'
   #If .F.
      Local This As CL_REPORT Of 'cl_report.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_timestamp" display="_TimeStamp"/>] ;
      + [<memberdata name="_version" display="_Version"/>] ;
      + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
      + [<memberdata name="_cpid" display="_CPID"/>] ;
      + [</VFPData>]

   *-- Report.Info
   _TimeStamp          = 0
   _Version            = ''
   _SourceFile         = ''
   *LScheffler 20.08.2023
   *issue #96, [KestasL] keep CodePage relavant information for binary sources
   _cpid =      Cpcurrent()


Enddefine
