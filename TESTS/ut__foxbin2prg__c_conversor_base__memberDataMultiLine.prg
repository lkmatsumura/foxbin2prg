DEFINE CLASS ut__foxbin2prg__c_conversor_base__memberDataMultiLine AS FxuTestCase OF FxuTestCase.prg

	#IF .F.
		LOCAL THIS AS ut__foxbin2prg__c_conversor_base__memberDataMultiLine OF ut__foxbin2prg__c_conversor_base__memberDataMultiLine.prg
	#ENDIF

	icObj = NULL


	*******************************************************************************************************************************************
	FUNCTION SETUP
		PUBLIC oFXU_LIB AS CL_FXU_CONFIG OF 'TESTS\fxu_lib_objetos_y_funciones_de_soporte.PRG'
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		SET PROCEDURE TO 'TESTS\fxu_lib_objetos_y_funciones_de_soporte.PRG', 'c_conversor_base.prg'
		oFXU_LIB = CREATEOBJECT('CL_FXU_CONFIG')
		oFXU_LIB.setup_comun()

		THIS.icObj = CREATEOBJECT("c_conversor_base")
		loObj = THIS.icObj
		loObj.l_Test = .T.

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
		RELEASE PROCEDURE 'TESTS\fxu_lib_objetos_y_funciones_de_soporte.PRG', 'c_conversor_base.prg'

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_detectarMultiLineNoBinarioComLF
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL lcSource, llMultiLine
		loObj = THIS.icObj
		lcSource = '<VFPData><memberdata name="foo" display="Foo"/>' + CHR(10) + '<memberdata name="bar" display="Bar"/></VFPData>'
		llMultiLine = loObj.memberDataHasLineBreaksBetweenTags( lcSource )
		THIS.assertequals( .T., llMultiLine, 'Deve detectar LF entre tags memberdata no binario' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_exportarMultiLineQuandoBinarioTemLF
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL lcSource, lcExported, lcProp
		loObj = THIS.icObj
		lcProp = '_memberdata'
		lcSource = '<VFPData><memberdata name="foo" display="Foo"/>' + CHR(10) + '<memberdata name="bar" display="Bar"/></VFPData>'
		lcExported = loObj.normalizePropertyValue( lcProp, lcSource, '' )
		THIS.assertequals( .T., loObj.getVFPDataMultiLineFlag( lcExported ), 'Exportacao deve incluir multi-line="true"' )
		THIS.assertequals( .T., 'multi-line="true"' $ lcExported, 'Texto exportado deve conter o atributo multi-line' )
		THIS.assertequals( .F., '<memberdata <memberdata' $ lcExported, 'Nao deve duplicar a tag memberdata na exportacao' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_exportarSemMultiLineQuandoBinarioComprimido
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL lcSource, lcExported, lcProp
		loObj = THIS.icObj
		lcProp = '_memberdata'
		lcSource = '<VFPData><memberdata name="foo" display="Foo"/><memberdata name="bar" display="Bar"/></VFPData>'
		lcExported = loObj.normalizePropertyValue( lcProp, lcSource, '' )
		THIS.assertequals( .F., loObj.getVFPDataMultiLineFlag( lcExported ), 'Exportacao comprimida nao deve incluir multi-line="true"' )
		THIS.assertequals( .F., '<memberdata <memberdata' $ lcExported, 'Nao deve duplicar a tag memberdata na exportacao comprimida' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_restaurarMultiLineComLFNoBinario
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL lcText, lcBinary, lcProp, lcExpected
		loObj = THIS.icObj
		lcProp = '_MemberData'
		lcText = '<VFPData multi-line="true">' + CHR(13) + CHR(10) ;
			+ CHR(9) + CHR(9) + CHR(9) + '<memberdata name="foo" display="Foo"/>' + CHR(13) + CHR(10) ;
			+ CHR(9) + CHR(9) + CHR(9) + '<memberdata name="bar" display="Bar"/>' + CHR(13) + CHR(10) ;
			+ CHR(9) + CHR(9) + '</VFPData>'
		lcBinary = loObj.denormalizePropertyValue( lcProp, lcText, '' )
		lcExpected = '<VFPData>' + CHR(10) + '<memberdata name="foo" display="Foo"/>' + CHR(10) ;
			+ '<memberdata name="bar" display="Bar"/>' + CHR(10) + '</VFPData>'
		THIS.assertequals( lcExpected, lcBinary, 'Restauracao multiline deve usar LF apos VFPData, entre tags e antes de fechar' )
		THIS.assertequals( .F., 'multi-line="true"' $ lcBinary, 'Binario nao deve conter o atributo multi-line' )
		THIS.assertequals( .F., CHR(9) $ lcBinary, 'Binario multiline nao deve conter tabs de indentacao' )
		THIS.assertequals( .F., RIGHT( lcBinary, 1 ) $ CHR(13) + CHR(10), 'Binario nao deve terminar com salto de linha apos </VFPData>' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_restaurarComprimidoSemMultiLine
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL lcText, lcBinary, lcProp, lcExpected
		loObj = THIS.icObj
		lcProp = '_memberdata'
		lcText = '<VFPData>' + CHR(13) + CHR(10) ;
			+ CHR(9) + CHR(9) + CHR(9) + '<memberdata name="foo" display="Foo"/>' + CHR(13) + CHR(10) ;
			+ CHR(9) + CHR(9) + CHR(9) + '<memberdata name="bar" display="Bar"/>' + CHR(13) + CHR(10) ;
			+ CHR(9) + CHR(9) + '</VFPData>'
		lcBinary = loObj.denormalizePropertyValue( lcProp, lcText, '' )
		lcExpected = '<VFPData><memberdata name="foo" display="Foo"/><memberdata name="bar" display="Bar"/></VFPData>'
		THIS.assertequals( lcExpected, lcBinary, 'Restauracao sem multi-line deve comprimir o XML' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_fazerRoundTripMultiLineEstavel
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL lcSource, lcExported, lcBinary, lcProp
		loObj = THIS.icObj
		lcProp = '_memberdata'
		lcSource = '<VFPData>' + CHR(10) + '<memberdata name="foo" display="Foo"/>' + CHR(10) ;
			+ '<memberdata name="bar" display="Bar"/>' + CHR(10) + '</VFPData>'
		lcExported = loObj.normalizePropertyValue( lcProp, lcSource, '' )
		lcBinary = loObj.denormalizePropertyValue( lcProp, lcExported, '' )
		THIS.assertequals( lcSource, lcBinary, 'Round-trip multiline deve preservar LF no binario' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_exportarTagsMemberDataSemDuplicar
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL lcSource, lcExported, lcProp
		loObj = THIS.icObj
		lcProp = '_memberdata'
		lcSource = '<VFPData><memberdata name="abrirpasta" type="method" display="AbrirPasta"/>' + CHR(10) ;
			+ '<memberdata name="addprojeto" type="method" display="AddProjeto"/>' + CHR(10) ;
			+ '<memberdata name="aprojeto" type="property" display="aProjeto"/>' + CHR(10) ;
			+ '<memberdata name="validpath_reduce" type="method" display="ValidPath_Reduce"/></VFPData>'
		lcExported = loObj.normalizePropertyValue( lcProp, lcSource, '' )
		THIS.assertequals( .F., '<memberdata <memberdata' $ lcExported, 'Nao deve duplicar a tag memberdata na exportacao' )
		THIS.assertequals( .T., loObj.getVFPDataMultiLineFlag( lcExported ), 'Binario multiline deve exportar multi-line=true' )
		THIS.assertequals( .T., '<memberdata name="abrirpasta" type="method" display="AbrirPasta"/>' $ lcExported, 'Tag com type=method intacta' )
		THIS.assertequals( .T., '<memberdata name="aprojeto" type="property" display="aProjeto"/>' $ lcExported, 'Tag com type=property intacta' )
		THIS.assertequals( .T., 4, OCCURS( '<memberdata name=', lcExported ), 'Deve exportar todas as tags memberdata' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_importarMultiLineViaLinhasVC2
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL taLines[1], tnLines, I, lcProp, lcValue, lcExpected
		loObj = THIS.icObj
		DIMENSION taLines[4]
		taLines[1] = '_memberdata = <VFPData multi-line="true">'
		taLines[2] = CHR(9) + CHR(9) + CHR(9) + '<memberdata name="foo" display="Foo"/>'
		taLines[3] = CHR(9) + CHR(9) + CHR(9) + '<memberdata name="bar" display="Bar"/>'
		taLines[4] = CHR(9) + CHR(9) + '</VFPData>'
		tnLines = 4
		I = 1
		loObj.get_SeparatedPropAndValue( taLines[1], @lcProp, @lcValue, NULL, @taLines, tnLines, @I )
		lcExpected = '<VFPData>' + CHR(10) + '<memberdata name="foo" display="Foo"/>' + CHR(10) ;
			+ '<memberdata name="bar" display="Bar"/>' + CHR(10) + '</VFPData>'
		THIS.assertequals( lcExpected, lcValue, 'Importacao VC2 multiline deve restaurar LF apos VFPData, entre tags e antes de fechar' )
		THIS.assertequals( .F., '<memberdata <memberdata' $ lcValue, 'Importacao nao deve duplicar tags memberdata' )
		THIS.assertequals( .F., CHR(9) $ lcValue, 'Importacao VC2 nao deve incluir tabs de indentacao no binario' )
		THIS.assertequals( .F., RIGHT( lcValue, 1 ) $ CHR(13) + CHR(10), 'Importacao nao deve terminar com salto de linha apos </VFPData>' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_ignorarLinhaVaziaAntesDeFechar
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL taLines[1], tnLines, I, lcProp, lcValue, lcExpected
		loObj = THIS.icObj
		DIMENSION taLines[5]
		taLines[1] = CHR(9) + CHR(9) + '_memberdata = <VFPData multi-line="true">'
		taLines[2] = CHR(9) + CHR(9) + CHR(9) + CHR(9) + CHR(9) + '<memberdata name="foo" display="Foo"/>'
		taLines[3] = CHR(9) + CHR(9) + CHR(9) + CHR(9) + CHR(9) + '<memberdata name="bar" display="Bar"/>'
		taLines[4] = CHR(9) + CHR(9) + CHR(9) + CHR(9)
		taLines[5] = CHR(9) + CHR(9) + CHR(9) + CHR(9) + '</VFPData>'
		tnLines = 5
		I = 1
		loObj.get_SeparatedPropAndValue( taLines[1], @lcProp, @lcValue, NULL, @taLines, tnLines, @I )
		lcExpected = '<VFPData>' + CHR(10) + '<memberdata name="foo" display="Foo"/>' + CHR(10) ;
			+ '<memberdata name="bar" display="Bar"/>' + CHR(10) + '</VFPData>'
		THIS.assertequals( lcExpected, lcValue, 'Linha vazia antes do fechamento nao deve gerar LF extra' )
		THIS.assertequals( .F., CHR(9) $ lcValue, 'Binario nao deve conter tabs' )
		THIS.assertequals( .F., RIGHT( lcValue, 1 ) $ CHR(13) + CHR(10), 'Binario nao deve terminar com salto de linha apos </VFPData>' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_importarComprimidoViaLinhasVC2
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL taLines[1], tnLines, I, lcProp, lcValue, lcExpected
		loObj = THIS.icObj
		DIMENSION taLines[4]
		taLines[1] = '_memberdata = <VFPData>'
		taLines[2] = CHR(9) + CHR(9) + CHR(9) + '<memberdata name="foo" display="Foo"/>'
		taLines[3] = CHR(9) + CHR(9) + CHR(9) + '<memberdata name="bar" display="Bar"/>'
		taLines[4] = CHR(9) + CHR(9) + '</VFPData>'
		tnLines = 4
		I = 1
		loObj.get_SeparatedPropAndValue( taLines[1], @lcProp, @lcValue, NULL, @taLines, tnLines, @I )
		lcExpected = '<VFPData><memberdata name="foo" display="Foo"/><memberdata name="bar" display="Bar"/></VFPData>'
		THIS.assertequals( lcExpected, lcValue, 'Importacao VC2 sem multi-line deve comprimir o XML' )

	ENDFUNC


	*******************************************************************************************************************************************
	FUNCTION Deberia_fazerRoundTripComprimidoEstavel
		LOCAL loObj AS c_conversor_base OF "c_conversor_base.prg"
		LOCAL lcSource, lcExported, lcBinary, lcProp
		loObj = THIS.icObj
		lcProp = '_memberdata'
		lcSource = '<VFPData><memberdata name="foo" display="Foo"/><memberdata name="bar" display="Bar"/></VFPData>'
		lcExported = loObj.normalizePropertyValue( lcProp, lcSource, '' )
		lcBinary = loObj.denormalizePropertyValue( lcProp, lcExported, '' )
		THIS.assertequals( lcSource, lcBinary, 'Round-trip comprimido deve permanecer comprimido' )

	ENDFUNC


ENDDEFINE
