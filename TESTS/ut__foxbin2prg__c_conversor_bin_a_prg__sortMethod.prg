DEFINE CLASS ut__foxbin2prg__c_conversor_bin_a_prg__sortMethod AS FxuTestCase OF FxuTestCase.prg

	#IF .F.
		LOCAL THIS AS ut__foxbin2prg__c_conversor_bin_a_prg__sortMethod OF ut__foxbin2prg__c_conversor_bin_a_prg__sortMethod.PRG
	#ENDIF

	icObj = NULL


	*******************************************************************************************************************************************
	FUNCTION SETUP
		PUBLIC oFXU_LIB AS CL_FXU_CONFIG OF 'TESTS\fxu_lib_objetos_y_funciones_de_soporte.PRG'
		LOCAL loObj AS c_conversor_bin_a_prg OF "c_conversor_bin_a_prg.prg"
		SET PROCEDURE TO 'TESTS\fxu_lib_objetos_y_funciones_de_soporte.PRG', 'c_conversor_bin_a_prg.prg', 'c_conversor_base.prg'
		oFXU_LIB = CREATEOBJECT('CL_FXU_CONFIG')
		oFXU_LIB.setup_comun()

		THIS.icObj = CREATEOBJECT("c_conversor_bin_a_prg")
		loObj = THIS.icObj
		loObj.l_Test = .T.
		loObj.l_MethodSort_Enabled = .T.

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION TearDown
		#IF .F.
			PUBLIC oFXU_LIB AS CL_FXU_CONFIG OF 'TESTS\fxu_lib_objetos_y_funciones_de_soporte.PRG'
		#ENDIF
		THIS.icObj = NULL

		IF VARTYPE(oFXU_LIB) = "O"
			oFXU_LIB.teardown_comun()
			oFXU_LIB = NULL
		ENDIF
		RELEASE PROCEDURE 'TESTS\fxu_lib_objetos_y_funciones_de_soporte.PRG', 'c_conversor_bin_a_prg.prg', 'c_conversor_base.prg'

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION getMethodOrder
		LPARAMETERS taMethods, tnMethodCount
		LOCAL lcOrder, I

		lcOrder = ''
		FOR I = 1 TO tnMethodCount
			IF taMethods(m.I, 2) > 0
				lcOrder = lcOrder + IIF(EMPTY(lcOrder), '', '|') + taMethods(m.I, 1)
			ENDIF
		ENDFOR

		RETURN lcOrder
	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_priorizarInitEDestroyNaClasseEEmCadaObjeto
		LOCAL loObj AS c_conversor_bin_a_prg OF "c_conversor_bin_a_prg.prg"
		LOCAL laMethods(8, 3), laCode(8), laProps(1), laProtected(1), lnMethodCount, lcOrder
		loObj = THIS.icObj
		lnMethodCount = 8

		DIMENSION laMethods(lnMethodCount, 3), laCode(lnMethodCount)

		laMethods(1, 1) = 'Load'           && classe
		laMethods(1, 2) = 1
		laMethods(1, 3) = ''
		laCode(1) = 'PROCEDURE Load'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(2, 1) = 'Destroy'        && classe
		laMethods(2, 2) = 2
		laMethods(2, 3) = ''
		laCode(2) = 'PROCEDURE Destroy'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(3, 1) = 'Init'           && classe
		laMethods(3, 2) = 3
		laMethods(3, 3) = ''
		laCode(3) = 'PROCEDURE Init'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(4, 1) = 'cmdOk.Click'    && objeto cmdOk
		laMethods(4, 2) = 4
		laMethods(4, 3) = ''
		laCode(4) = 'PROCEDURE cmdOk.Click'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(5, 1) = 'cmdOk.Destroy'
		laMethods(5, 2) = 5
		laMethods(5, 3) = ''
		laCode(5) = 'PROCEDURE cmdOk.Destroy'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(6, 1) = 'cmdOk.Init'
		laMethods(6, 2) = 6
		laMethods(6, 3) = ''
		laCode(6) = 'PROCEDURE cmdOk.Init'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(7, 1) = 'lblTitle.Valid' && objeto lblTitle
		laMethods(7, 2) = 7
		laMethods(7, 3) = ''
		laCode(7) = 'PROCEDURE lblTitle.Valid'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(8, 1) = 'lblTitle.Init'
		laMethods(8, 2) = 8
		laMethods(8, 3) = ''
		laCode(8) = 'PROCEDURE lblTitle.Init'+CHR(13)+CHR(10)+'ENDPROC'

		loObj.sortMethod('', @laMethods, @laCode, '', @lnMethodCount, @laProps, 0, @laProtected, 0, NULL, '')

		lcOrder = THIS.getMethodOrder(@laMethods, lnMethodCount)

		THIS.messageout('Ordem obtida: ' + lcOrder)
		THIS.assertequals('Init|Destroy|Load|cmdOk.Init|cmdOk.Destroy|cmdOk.Click|lblTitle.Init|lblTitle.Valid', lcOrder, 'Ordem dos métodos após sortMethod (não-form)')

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_priorizarLoadInitDestroyUnloadEmForm
		LOCAL loObj AS c_conversor_bin_a_prg OF "c_conversor_bin_a_prg.prg"
		LOCAL laMethods(5, 3), laCode(5), laProps(1), laProtected(1), lnMethodCount, lcOrder
		loObj = THIS.icObj
		lnMethodCount = 5

		DIMENSION laMethods(lnMethodCount, 3), laCode(lnMethodCount)

		laMethods(1, 1) = 'Init'
		laMethods(1, 2) = 1
		laMethods(1, 3) = ''
		laCode(1) = 'PROCEDURE Init'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(2, 1) = 'Unload'
		laMethods(2, 2) = 2
		laMethods(2, 3) = ''
		laCode(2) = 'PROCEDURE Unload'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(3, 1) = 'Load'
		laMethods(3, 2) = 3
		laMethods(3, 3) = ''
		laCode(3) = 'PROCEDURE Load'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(4, 1) = 'Activate'
		laMethods(4, 2) = 4
		laMethods(4, 3) = ''
		laCode(4) = 'PROCEDURE Activate'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(5, 1) = 'Destroy'
		laMethods(5, 2) = 5
		laMethods(5, 3) = ''
		laCode(5) = 'PROCEDURE Destroy'+CHR(13)+CHR(10)+'ENDPROC'

		loObj.sortMethod('', @laMethods, @laCode, '', @lnMethodCount, @laProps, 0, @laProtected, 0, NULL, 'form')

		lcOrder = THIS.getMethodOrder(@laMethods, lnMethodCount)

		THIS.assertequals('Load|Init|Destroy|Unload|Activate', lcOrder, 'Ordem dos métodos de form: Load, Init, Destroy, Unload')

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_manterDestroyPrimeiroQuandoInitNaoExistir
		LOCAL loObj AS c_conversor_bin_a_prg OF "c_conversor_bin_a_prg.prg"
		LOCAL laMethods(2, 3), laCode(2), laProps(1), laProtected(1), lnMethodCount, lcOrder
		loObj = THIS.icObj
		lnMethodCount = 2

		DIMENSION laMethods(lnMethodCount, 3), laCode(lnMethodCount)

		laMethods(1, 1) = 'Load'
		laMethods(1, 2) = 1
		laMethods(1, 3) = ''
		laCode(1) = 'PROCEDURE Load'+CHR(13)+CHR(10)+'ENDPROC'

		laMethods(2, 1) = 'Destroy'
		laMethods(2, 2) = 2
		laMethods(2, 3) = ''
		laCode(2) = 'PROCEDURE Destroy'+CHR(13)+CHR(10)+'ENDPROC'

		loObj.sortMethod('', @laMethods, @laCode, '', @lnMethodCount, @laProps, 0, @laProtected, 0, NULL, '')

		lcOrder = THIS.getMethodOrder(@laMethods, lnMethodCount)

		THIS.assertequals('Destroy|Load', lcOrder, 'Destroy deve ser o primeiro quando Init não existe (não-form)')

	ENDFUNC


ENDDEFINE
