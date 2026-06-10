*Create config templates
DO Main.prg WITH "-c","foxbin2prg.cfg.txt"     , FULLPATH("Create_FoxBin2Prg.cfg","")
DO Main.prg WITH "-t","foxbin2prg.dbf.cfg.txt" , FULLPATH("Create_FoxBin2Prg.cfg","")

*create binaries 
DO Main.PRG WITH JUSTPATH(FULLPATH("","")),"Bin2Prg",,,,,,,,,FULLPATH("Create_FoxBin2Prg.cfg","")
