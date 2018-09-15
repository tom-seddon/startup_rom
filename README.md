# Startup ROM

A simple BBC Micro ROM that executes some `*` commands on startup.

In principle, you could use this for pretty much anything, but I just
wrote it as a BBC B/B+ sort-of substitute for the Master's `*CONFIG`
functionality. I can build the ROM image, store it in EEPROM, and have
my preferred settings for `*FX11`, `*FX12` and `*TV` set up on every
boot.

# Building

Prerequisites:

- 64tass
- Python 2.x
- GNU make

Type `make`. The ROM is built to `.build/startup_rom/0/R.STARTUP` in
the working copy. (Note that `.build/startup_rom` is a valid volume
for [BeebLink](https://github.com/tom-seddon/beeblink), if you want
quick turnaround when experimenting.)

The default configuration builds with the following commands:

    *TV255 1
	*FX12 2
	*FX11 20
	
To change this, edit the file `commands.txt`, putting your own
commands in, one per line. Leading `*`s are optional.

Take care if invoking commands from other ROMs - the commands are
executed during ROM auto-boot, so not all ROMs may be initialised, and
errors at this stage are not handled particularly gracefully.

# Skipping the commands

`S+BREAK` will cause the startup ROM to do nothing.

Anything else (no key, or a key other than `S`), and it will run the
commands.

# Showing the commands

Type `*HELP STARTUP`.

