* Create config templates
DO Main.prg WITH "-c","foxbin2prg.cfg.txt"     , FULLPATH("Create_FoxBin2Prg.cfg","")
DO Main.prg WITH "-t","foxbin2prg.dbf.cfg.txt" , FULLPATH("Create_FoxBin2Prg.cfg","")

* Convert files to txt (scm)
DO Main.prg WITH JUSTPATH(FULLPATH("","")),"Bin2Prg",,,,,,,,,FULLPATH("Create_FoxBin2Prg.cfg","")
