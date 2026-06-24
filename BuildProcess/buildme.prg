*BuildMe.prg for [add your application]
*
* This program should perform any build tasks necessary for the project, such
* as updating version numbers in code or include files. This program can use the public
* variables discussed in the documentation as necessary.
LOCAL;
	lcVerno   as String,;
	lnProject as Integer,;
	llFound   as Boolean,;
	loProject as Project
	
*Get FoxBin2Prg verno from FoxBin2Prg.prg
lcVerno = DO main.prg WITH "-VERNO"

*Set Thor verno
pcVersion = m.lcVerno
pcFullVersion = m.lcVerno
pcPJXFile = pcPJXFile	&&"foxbin2prg.pjx"
*Set FoxBin2Prg.exe verno
For lnProject = 1 To _vfp.Projects.Count
	If Upper(Fullpath(m.pcPJXFile))==Upper(_vfp.Projects(m.lnProject).Name) Then
		_vfp.Projects(m.lnProject).VersionNumber = m.lcVerno
		llFound = .T.
		Exit

	Endif &&Upper(Fullpath(m.pcPJXFile))==Upper(_vfp.Projects(m.lnProject).Name)
Endfor &&lnProject

If !m.llFound
	If _Vfp.Projects.Count>0
		loProject = _vfp.ActiveProject
	Endif &&_Vfp.Projects.Count>0
	
	MODIFY PROJECT (Fullpath(m.pcPJXFile)) Noshow Nowait Noprojecthook
	_vfp.ActiveProject.VersionNumber = m.lcVerno
	_vfp.ActiveProject.Close

	If _Vfp.Projects.Count>0
		_vfp.ActiveProject = m.loProject
	Endif &&_Vfp.Projects.Count>0
Endif &&!m.llFound

*ToDo: legacy FOXBIN2PRG.CFG removed — configuration is programmatic (newConfig).

return

*Stuff we can do:
* - get version number (pcVersion) from an include file
* - set version number (pcVersion) to an include file
* - set version number to pjx used
* - set debug info off in pjx or include file
* - If FoxBin2Prg internal to VFPXDeployment is not fitting, run own way
* - create pcFullVersion like you use in the .VersionNumber of Version*.txt file for use in README.md
*   (else it will use pcVersion)
*   like the example in the Version text template:
pcFullVersion = pcVersion+' - ' + pcJulian
* - copy files to ../InstalledFiles subfolder
* - modify documentation
