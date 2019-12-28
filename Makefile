# -*- mode:makefile-gmake; -*-
DEST:=.build/startup_rom/0/R.STARTUP
TMP:=.build/.tmp
TASS:=64tass --m65xx --nostart -Wall -Wno-implied-reg -C
VER?=$(shell date '+%Y-%m-%d %H:%M:%S')
CP:=cp -v
TOUCH:=touch
SMLOAD_MAKE_RELOC:=python ./submodules/beeb/bin/smload_make_reloc.py

##########################################################################
##########################################################################

.PHONY:build
build:
	mkdir -p $(dir $(DEST)) $(TMP)
	python ./make_cmds.py ./commands.txt > .build/cmds.s65
	$(TASS) startup.s65 -L$(TMP)/startup_8000.lst -o$(TMP)/startup_8000.rom "-DVERSION=\"$(VER)\"" '-DORIGIN=$$8000'
	$(TASS) startup.s65 -L$(TMP)/startup_8100.lst -o$(TMP)/startup_8100.rom "-DVERSION=\"$(VER)\"" '-DORIGIN=$$8100'
	$(CP) $(TMP)/startup_8000.rom $(DEST)
	$(TOUCH) $(DEST).inf
	$(SMLOAD_MAKE_RELOC) -v -o $(TMP)/startup_module.rom $(TMP)/startup_8000.rom $(TMP)/startup_8100.rom

.PHONY:clean
clean:
	rm -Rf $(TMP)
	rm -f $(DEST)
	rm -f $(DEST).inf
