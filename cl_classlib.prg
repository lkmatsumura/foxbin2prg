#INCLUDE foxbin2prg.h

Define Class CL_CLASSLIB As CL_CUS_BASE Of 'cl_cus_base.prg'
   #If .F.
      Local This As CL_CLASSLIB Of 'cl_classlib.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="add_ole" display="add_OLE"/>] ;
      + [<memberdata name="add_class" display="add_Class"/>] ;
      + [<memberdata name="existeobjetoole" display="existeObjetoOLE"/>] ;
      + [<memberdata name="_clases" display="_Clases"/>] ;
      + [<memberdata name="_clases_count" display="_Clases_Count"/>] ;
      + [<memberdata name="_externalclasses" display="_ExternalClasses"/>] ;
      + [<memberdata name="_externalclasses_count" display="_ExternalClasses_Count"/>] ;
      + [<memberdata name="_includefile" display="_IncludeFile"/>] ;
      + [<memberdata name="_comment" display="_Comment"/>] ;
      + [<memberdata name="_ole_objs" display="_Ole_Objs"/>] ;
      + [<memberdata name="_ole_objs" display="_Ole_Objs"/>] ;
      + [<memberdata name="_sourcefile" display="_SourceFile"/>] ;
      + [<memberdata name="_version" display="_Version"/>] ;
      + [<memberdata name="_cpid" display="_CPID"/>] ;
      + [</VFPData>]


   Dimension _Ole_Objs[1], _Clases[1], _ExternalClasses(1,2)
   _Version                = 0
   _SourceFile             = ''
   *LScheffler 20.08.2023
   *issue #96, [KestasL] keep CodePage relavant information for binary sources
   _cpid                   = Cpcurrent()
   _ExternalClasses_Count  = 0
   _Ole_Obj_count          = 0
   _Clases_Count           = 0
   _includeFile            = ''
   _Comment                = ''



   Procedure add_OLE
      Lparameters toOle

      #If .F.
         Local toOle As CL_OLE Of 'cl_ole.prg'
      #Endif

      With This As CL_CLASSLIB Of 'cl_classlib.prg'
         ._Ole_Obj_count = ._Ole_Obj_count + 1
         Dimension ._Ole_Objs( ._Ole_Obj_count )
         ._Ole_Objs( ._Ole_Obj_count )   = toOle
      Endwith && THIS
   Endproc



   Procedure add_Class
      Lparameters toClase

      #If .F.
         Local toClase As CL_CLASE Of 'cl_clase.prg'
      #Endif

      With This As CL_CLASSLIB Of 'cl_classlib.prg'
         ._Clases_Count  = ._Clases_Count + 1
         Dimension ._Clases( ._Clases_Count )
         ._Clases( ._Clases_Count )  = toClase
      Endwith && THIS
   Endproc



   Procedure existeObjetoOLE
      *-- Ubico el objeto ole por su nombre (parent+objname), que no se repite.
      Lparameters tcNombre, X
      Local llExiste

      With This As CL_CLASSLIB Of 'cl_classlib.prg'
         For X = 1 To ._Ole_Obj_count
            If Lower(._Ole_Objs(m.X)._Nombre) == Lower(tcNombre)
               llExiste = .T.
               Exit
            Endif
         Endfor
      Endwith && THIS

      Return llExiste
   Endproc


Enddefine
