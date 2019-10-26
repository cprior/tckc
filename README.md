# Configuring the Linux kernel beyond university years

It was a huge revelation to me reading [https://github.com/gg7/gentoo-kernel-guide](https://github.com/gg7/gentoo-kernel-guide) which describes kernel configuration not via `make menuconfig` but the included `./scripts/config` helper.

In my household is a variety of rather ageing PC hardware from two or three vendors, a network printer, several modems and switches as well as a whole bunch of single-board computers. The notebooks were migrated over the years from Gentoo to Ubuntu because time is much more limited, usually two PCs with Windows are also around as well as one or two Apple things.

When I resurfaced an HP ProLiant Microserver (a small NAS-type of formfactor) the quest to use this energy-efficient device for as much as possible soon led me down the rabbit hole of custom kernel compilation. Armed with years of Gentoo-experience the task did not scare me, but when this took almost two weeks of hand-wrought spare time in late evenings I started to look for a better approach than following Gentoo or ArchLinux documentation.

All my Linux installations have a pretty standardized set of features, typically ext4 on LVM, get connected to the same peripherals and even on Gentoo I prefer systemd.

Typically after a few years when upgrading/replacing harddrives I tend to install the OS from scratch, on otherwise identical hardware.

It certainly itched me that the kernel configuration did not align with current devops- and infrastructure-as-code-paradigms.

With this background a few requirements manifested a hopefully decade-long approach for my future needs:

## Requirements for the time-constrained kernel builder

Must-have:

- no GUI usage to edit .config
- standard set of features to enable/disable
- per-model set of features on top
- solid upgrade path

Nice to have:

- snappy boot times

As the time-contrained Linux admin-at-home I want scripts to configure my kernel during an upgrade producing stable and snappy user experiences.

# Organization of this repository

This repository contains the full project and is therefore in an usual structure. When combining IT and business aspects (and a website is marketing is business) there exists a vey helpful method with [TOGAF](www.opengroup.org/subjectareas/enterprise/togaf "The TOGAF® framework is the de facto global standard for Enterprise Architecture.").

# ![biz][dot-app-16] applications deployed

These applications are deployed within the solution, are specificially written for it and far from off-the-shelf.

## ![biz][dot-app-16] tckc

[./app/phy/tckc](./app/phy/tckc)

# ![biz][dot-biz-16] business

I am a business administration guy by trade and can't help but spot "biz" where I see it. The latest when hardware comes into play there is purchasing, maybe even a boll of materials 'BOM' and it doesn't help to put the ~~customer~~ user is in focus the terminology just fits.

# ![biz][dot-dat-16] data

This folder is typically used by scripts in ./application/physical to hold data in a predictable place. I tend to do a lot of curl'ing with checks for If-Modified-Since to be nice to the (mirror) servers.

# ![biz][dot-tec-16] technology

About off-the-shelf technology used by the project.



[dot-biz-16]: https://user-images.githubusercontent.com/943871/32907435-4c388e1a-cb00-11e7-85e7-b060c9028399.png "biz"
[dot-dat-16]: https://user-images.githubusercontent.com/943871/32907437-4d9e39f8-cb00-11e7-8dcf-697f7439860f.png "dat"
[dot-app-16]: https://user-images.githubusercontent.com/943871/32907438-4f141938-cb00-11e7-8d9c-50723c4decef.png "app"
[dot-tec-16]: https://user-images.githubusercontent.com/943871/32907440-5032be96-cb00-11e7-8cad-d7d16083ee5b.png "tec"