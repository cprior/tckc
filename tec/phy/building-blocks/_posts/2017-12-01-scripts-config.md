---
layout: post
title: "Linux kernel config with ./scripts/config"
categories: [ technology_physical_building-blocks ]
date:   2019-09-15 12:00:00 +0100
abstract: Manipulate options in a .config file from the command line.
---

# The central helper script in the kernel source

```
./scripts/config
Manipulate options in a .config file from the command line.
Usage:
config options command ...
commands:
	--enable|-e option   Enable option
	--disable|-d option  Disable option
	--module|-m option   Turn option into a module
	--set-str option string
	                     Set option to "string"
	--set-val option value
	                     Set option to value
	--undefine|-u option Undefine option
	--state|-s option    Print state of option (n,y,m,undef)

	--enable-after|-E beforeopt option
                             Enable option directly after other option
	--disable-after|-D beforeopt option
                             Disable option directly after other option
	--module-after|-M beforeopt option
                             Turn option into module directly after other option

	commands can be repeated multiple times

options:
	--file config-file   .config file to change (default .config)
	--keep-case|-k       Keep next symbols' case (dont' upper-case it)

config doesn't check the validity of the .config file. This is done at next
make time.

By default, config will upper-case the given symbol. Use --keep-case to keep
the case of all following symbols unchanged.

config uses 'CONFIG_' as the default symbol prefix. Set the environment
```