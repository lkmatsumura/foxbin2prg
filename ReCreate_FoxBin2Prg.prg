*ReCreate all FoxBin2Prg files from there text representation and compile

DO Main.PRG WITH JUSTPATH(FULLPATH("","")),"Prg2Bin",,,,,,,,,FULLPATH("Create_FoxBin2Prg.cfg","")

BUILD EXE FoxBin2Prg.EXE FROM FoxBin2Prg.pjx RECOMPILE

CD Fb2P_Diff
BUILD EXE Fb2P_Diff.EXE FROM Fb2P_Diff.pjx RECOMPILE

CD ..\FileName_Caps
BUILD EXE FileName_Caps.EXE FROM FileName_Caps.pjx RECOMPILE
CD ..

