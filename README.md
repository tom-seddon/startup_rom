# Startup ROM

A simple BBC Micro ROM that executes some `*` commands on startup.

In principle, you could use this for pretty much anything, but I just
wrote it as a BBC B/B+ sort-of substitute for the Master's `*CONFIG`
functionality. I can build the ROM image, store it in EEPROM, and have
my preferred settings for `*FX11`, `*FX12` and `*TV` set up on every
boot.

# Licence

GPL v3 - see [`COPYING.txt`](./COPYING.txt).

# Building

This repo contains submodules. Clone it with `git clone --recursive`,
or clone it normally then do `git submodule init` and `git submodule
update`.

Prerequisites:

- [64tass](http://tass64.sourceforge.net/)
- Python 2.x
- GNU make
- Some kind of Unix

Type `make`. The ROM is built to `.build/startup_rom/0/R.STARTUP` in
the working copy. (Note that `.build/startup_rom` is a valid volume
for [BeebLink](https://github.com/tom-seddon/beeblink), if you want
quick turnaround when experimenting.)

# Choosing commands

To change the commands executed, edit the file `commands.txt`, putting
your own commands in, one per line. Leading `*`s are optional.

The default configuration runs the following:

    *TV255 1
	*FX12 2
	*FX11 20

Take care if invoking commands from other ROMs - the commands are
executed during the ROM initialisation process, and I'm sure many ROMs
won't be expecting this :(

Errors at this stage are also not handled particularly gracefully.

# Skipping the commands

`S+BREAK` will cause the startup ROM to do nothing. Anything else (no
key, or a key other than `S`), and it will run the commands.

# Showing the commands

Type `*HELP STARTUP`.

# Sideways ROM module

The ROM is perfectly usable just as is, but being <0.5K it's a bit of
a waste of a ROM bank. It's therefore intended to be added to another
ROM as a
[relocatable sideways RAM module](http://mdfs.net/Software/BBC/Modules/ModWriting).
(I have it added to a filing system, along with the Tube host code.)

The build process produces a relocatable module:
`.build/.tmp/startup_module.rom`.
