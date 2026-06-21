#INCLUDE foxbin2prg.h

Define Class CL_DBC_COL_BASE As CL_COL_BASE Of 'cl_col_base.prg'
   #If .F.
      Local This As CL_DBC_COL_BASE Of 'cl_dbc_col_base.prg'
   #Endif

   _MemberData = [<VFPData>] ;
      + [<memberdata name="_name" display="_Name"/>] ;
      + [<memberdata name="__objectid" display="__ObjectID"/>] ;
      + [<memberdata name="updatedbc" display="updateDBC"/>] ;
      + [<memberdata name="read_bindatatoproperties" display="read_BinDataToProperties"/>] ;
      + [</VFPData>]

   __ObjectID      = 0
   _Name           = ''


   Procedure updateDBC
      *---------------------------------------------------------------------------------------------------
      * PARÁMETROS:               (v=Pasar por valor | @=Pasar por referencia) (!=Obligatorio | ?=Opcional) (IN/OUT)
      * tc_OutputFile             (v! IN    ) Nombre del archivo de salida
      * tnLastID                  (!@ IN    ) Último número de ID usado
      * tnParentID                (v! IN    ) ID del objeto Padre
      *---------------------------------------------------------------------------------------------------
      Lparameters tc_OutputFile, tnLastID, tnParentID
      Local loObject
      loObject    = .Null.

      For Each loObject In This FoxObject
         loObject.updateDBC( tc_OutputFile, @tnLastID, tnParentID )
         loObject    = .Null.
      Endfor

      Return
   Endproc


   Procedure __ObjectID_ACCESS
      Return This.Parent.__ObjectID
   Endproc


Enddefine
