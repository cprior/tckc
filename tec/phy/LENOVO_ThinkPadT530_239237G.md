

# network card

82579LM Gigabit Network Connection e1000e


# graphics card 

GF108M Nouveau

lspci -v | grep VGA
00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core processor Graphics Controller (rev 09) (prog-if 00 [VGA controller])
01:00.0 VGA compatible controller: NVIDIA Corporation GF108M [NVS 5400M] (rev a1) (prog-if 00 [VGA controller])


Support for the /proc/config.gz pseudo-file is enabled through the Kernel/IKCONFIG_Support feature.


# Intel wireless

`sudo lshw -short | grep network`
/0/100/19        enp0s25      network        82579LM Gigabit Network Connection (Lewisville)
/0/100/1c.1/0    wlp3s0       network        Centrino Advanced-N 6205 [Taylor Peak]
/2               wwp0s20u4i6  network        Ethernet interface

The kernel driver depends on firmware, typically located in /lib/firmware but can manually be installed on Ubuntu with `sudo apt-get install linux-firmware` or on Gentoo with `emerge --ask sys-kernel/linux-firmware`. Alternatively https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi lists the first official firmware version released.
The driver relies on specific firmware versions, if the wrong ones are available `dmesg` will show an error stating the correct versions.

During kernel configuration the Intel wireless chip's driver can be set to built-in if dependencies are also built-in AND the firmware is compiled into the kernel:

- mac80211 is set to y
- iwldvm is set to y
- iwlwifi is set to y

- CONFIG_EXTRA_FIRMWARE is set to e.g. iwlwifi-6000g2a-6.ucode
- CONFIG_EXTRA_FIRMWARE_DIR is set to /lib/firmware

```bash
./scripts/config --enable CONFIG_MAC80211
./scripts/config --enable CONFIG_IWLWIFI
./scripts/config --enable CONFIG_IWLWIFI_LEDS
./scripts/config --enable CONFIG_IWLDVM
./scripts/config --enable FIRMWARE_IN_KERNEL
./scripts/config --set-str CONFIG_EXTRA_FIRMWARE "iwlwifi-6000g2a-6.ucode"
./scripts/config --set-str CONFIG_EXTRA_FIRMWARE_DIR "/lib/firmware"
```

sudo apt-get install linux-firmware
Reading package lists... Done
Building dependency tree       
Reading state information... Done
linux-firmware is already the newest version (1.173.9).




sudo modprobe iwlwifi
modprobe: ERROR: could not insert 'iwlwifi': Exec format error

-> ich hatte `make` ohne `make modules` ausgefuehrt

ls /lib/firmware/iwlwifi-6050-5.*
/lib/firmware/iwlwifi-6050-5.ucode




cfg80211 - wireless configuration API
Generic IEEE 802.11 Networking Stack (mac80211)
Intel Wireless WiFi Next Gen AGN - Wireless-N/Advanced-N/Ultimate-N (iwlwifi)
iwldvm
Enable LED triggers

https://wiki.gentoo.org/wiki/Iwlwifi#When_using_built-in_configuration
When using built-in configuration
In case the driver is built into the kernel (<*>) instead as a module (<M>), also the firmware needs to be built into the kernel.

KERNEL linux-4.19
Device Drivers  --->
            Generic Driver Options  --->
                Firmware loader --->
 
                    -*- Firmware loading facility
                    (iwlwifi-xxxx.ucode) Build named firmware blobs into the kernel binary
                    (/lib/firmware) Firmware blobs root directory
                    [ ] Enable the firmware sysfs fallback mechanism
In this case replace iwlwifi-xxxx.ucode with the exact firmware name. Some attention seems to be needed for FW_LOADER_USER_HELPER_FALLBACK.

`modinfo iwlwifi`
filename:       /lib/modules/5.3.6/kernel/drivers/net/wireless/intel/iwlwifi/iwlwifi.ko
license:        GPL
author:         Copyright(c) 2003- 2015 Intel Corporation <linuxwifi@intel.com>
description:    Intel(R) Wireless WiFi driver for Linux
firmware:       iwlwifi-100-5.ucode
firmware:       iwlwifi-1000-5.ucode
firmware:       iwlwifi-135-6.ucode
firmware:       iwlwifi-105-6.ucode
firmware:       iwlwifi-2030-6.ucode
firmware:       iwlwifi-2000-6.ucode
firmware:       iwlwifi-5150-2.ucode
firmware:       iwlwifi-5000-5.ucode
firmware:       iwlwifi-6000g2b-6.ucode
firmware:       iwlwifi-6000g2a-6.ucode
firmware:       iwlwifi-6050-5.ucode
firmware:       iwlwifi-6000-6.ucode
srcversion:     A03E139CF2220AB3E9C6BE7

 ls /lib/firmware/iwlwifi-*
/lib/firmware/iwlwifi-1000-5.ucode
/lib/firmware/iwlwifi-100-5.ucode
/lib/firmware/iwlwifi-105-6.ucode
/lib/firmware/iwlwifi-135-6.ucode
/lib/firmware/iwlwifi-2000-6.ucode
/lib/firmware/iwlwifi-2030-6.ucode
/lib/firmware/iwlwifi-3160-10.ucode
/lib/firmware/iwlwifi-3160-12.ucode
/lib/firmware/iwlwifi-3160-13.ucode
/lib/firmware/iwlwifi-3160-16.ucode
/lib/firmware/iwlwifi-3160-17.ucode
/lib/firmware/iwlwifi-3160-7.ucode
/lib/firmware/iwlwifi-3160-8.ucode
/lib/firmware/iwlwifi-3160-9.ucode
/lib/firmware/iwlwifi-3168-21.ucode
/lib/firmware/iwlwifi-3168-22.ucode
/lib/firmware/iwlwifi-3168-27.ucode
/lib/firmware/iwlwifi-3168-29.ucode
/lib/firmware/iwlwifi-3945-2.ucode
/lib/firmware/iwlwifi-4965-2.ucode
/lib/firmware/iwlwifi-5000-5.ucode
/lib/firmware/iwlwifi-5150-2.ucode
/lib/firmware/iwlwifi-6000-4.ucode
/lib/firmware/iwlwifi-6000g2a-5.ucode
/lib/firmware/iwlwifi-6000g2a-6.ucode
/lib/firmware/iwlwifi-6000g2b-6.ucode
/lib/firmware/iwlwifi-6050-5.ucode
/lib/firmware/iwlwifi-7260-10.ucode
/lib/firmware/iwlwifi-7260-12.ucode
/lib/firmware/iwlwifi-7260-13.ucode
/lib/firmware/iwlwifi-7260-16.ucode
/lib/firmware/iwlwifi-7260-17.ucode
/lib/firmware/iwlwifi-7260-7.ucode
/lib/firmware/iwlwifi-7260-8.ucode
/lib/firmware/iwlwifi-7260-9.ucode
/lib/firmware/iwlwifi-7265-10.ucode
/lib/firmware/iwlwifi-7265-12.ucode
/lib/firmware/iwlwifi-7265-13.ucode
/lib/firmware/iwlwifi-7265-16.ucode
/lib/firmware/iwlwifi-7265-17.ucode
/lib/firmware/iwlwifi-7265-8.ucode
/lib/firmware/iwlwifi-7265-9.ucode
/lib/firmware/iwlwifi-7265D-10.ucode
/lib/firmware/iwlwifi-7265D-12.ucode
/lib/firmware/iwlwifi-7265D-13.ucode
/lib/firmware/iwlwifi-7265D-16.ucode
/lib/firmware/iwlwifi-7265D-17.ucode
/lib/firmware/iwlwifi-7265D-21.ucode
/lib/firmware/iwlwifi-7265D-22.ucode
/lib/firmware/iwlwifi-7265D-27.ucode
/lib/firmware/iwlwifi-7265D-29.ucode
/lib/firmware/iwlwifi-8000C-13.ucode
/lib/firmware/iwlwifi-8000C-16.ucode
/lib/firmware/iwlwifi-8000C-21.ucode
/lib/firmware/iwlwifi-8000C-22.ucode
/lib/firmware/iwlwifi-8000C-27.ucode
/lib/firmware/iwlwifi-8000C-31.ucode
/lib/firmware/iwlwifi-8000C-34.ucode
/lib/firmware/iwlwifi-8000C-36.ucode
/lib/firmware/iwlwifi-8265-21.ucode
/lib/firmware/iwlwifi-8265-22.ucode
/lib/firmware/iwlwifi-8265-27.ucode
/lib/firmware/iwlwifi-8265-31.ucode
/lib/firmware/iwlwifi-8265-34.ucode
/lib/firmware/iwlwifi-8265-36.ucode
/lib/firmware/iwlwifi-9000-pu-b0-jf-b0-33.ucode
/lib/firmware/iwlwifi-9000-pu-b0-jf-b0-34.ucode
/lib/firmware/iwlwifi-9000-pu-b0-jf-b0-38.ucode
/lib/firmware/iwlwifi-9000-pu-b0-jf-b0-41.ucode
/lib/firmware/iwlwifi-9000-pu-b0-jf-b0-43.ucode
/lib/firmware/iwlwifi-9260-th-b0-jf-b0-33.ucode
/lib/firmware/iwlwifi-9260-th-b0-jf-b0-34.ucode
/lib/firmware/iwlwifi-9260-th-b0-jf-b0-38.ucode
/lib/firmware/iwlwifi-9260-th-b0-jf-b0-41.ucode
/lib/firmware/iwlwifi-9260-th-b0-jf-b0-43.ucode
/lib/firmware/iwlwifi-cc-a0-46.ucode
/lib/firmware/iwlwifi-Qu-b0-hr-b0-48.ucode
/lib/firmware/iwlwifi-Qu-b0-jf-b0-48.ucode
/lib/firmware/iwlwifi-Qu-c0-hr-b0-48.ucode
/lib/firmware/iwlwifi-Qu-c0-jf-b0-48.ucode
/lib/firmware/iwlwifi-QuZ-a0-hr-b0-48.ucode
/lib/firmware/iwlwifi-QuZ-a0-jf-b0-48.ucode


`sudo lshw`
...
           *-network
                description: Wireless interface
                product: Centrino Advanced-N 6205 [Taylor Peak]
                vendor: Intel Corporation
                physical id: 0
                bus info: pci@0000:03:00.0
                logical name: wlp3s0
                version: 34
                serial: 60:67:20:ed:4d:04
                width: 64 bits
                clock: 33MHz
                capabilities: pm msi pciexpress bus_master cap_list ethernet physical wireless
                configuration: broadcast=yes driver=iwlwifi driverversion=5.3.6 firmware=18.168.6.1 ip=192.168.1.2 latency=0 link=yes multicast=yes wireless=IEEE 802.11
                resources: irq:32 memory:f3000000-f3001fff
...



`dmesg`
[    1.819052] PPP generic driver version 2.4.2
[    1.819122] Intel(R) Wireless WiFi driver for Linux
[    1.819123] Copyright(c) 2003- 2015 Intel Corporation
[    1.819367] iwlwifi 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
[    1.819971] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-6000g2a-6.ucode failed with error -2
[    1.819981] iwlwifi 0000:03:00.0: Direct firmware load for iwlwifi-6000g2a-5.ucode failed with error -2
[    1.819983] iwlwifi 0000:03:00.0: no suitable firmware found!
[    1.819984] iwlwifi 0000:03:00.0: minimum version required: iwlwifi-6000g2a-5
[    1.819985] iwlwifi 0000:03:00.0: maximum version supported: iwlwifi-6000g2a-6
[    1.819986] iwlwifi 0000:03:00.0: check git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git


# bluetooth

https://wiki.gentoo.org/wiki/Bluetooth#Kernel

In most cases enabling RFCOMM (CONFIG_RFCOMM), HIDP (CONFIG_BT_HIDP), HCI USB (CONFIG_BT_HCIBTUSB) and/or HCI UART (CONFIG_BT_HCIUART) should be sufficient. The User-space I/O driver for HID input devices (CONFIG_UHID) should be enabled for Bluetooth keyboards and mice.

https://wiki.gentoo.org/wiki/Bluetooth#Firmware

Most Bluetooth controllers need firmware to function. If the controller is supported by Linux, dmesg will usually indicate if firmware is needed. The sys-kernel/linux-firmware package should provide the needed firmware, although some devices may need firmware that is only available from the manufacturer.


# hardware info

sudo dmidecode 

System Information
	Manufacturer: LENOVO
	Product Name: 239237G
	Version: ThinkPad T530
	Serial Number: R9VYHPN
	UUID: C5069401-514F-11CB-92C8-C1DCC3D01979
	Wake-up Type: Power Switch
	SKU Number: LENOVO_MT_2392
	Family: ThinkPad T530


sudo lshw -short

H/W path         Device       Class          Description
========================================================
                              system         239237G (LENOVO_MT_2392)
/0                            bus            239237G
/0/1                          processor      Intel(R) Core(TM) i5-3210M CPU @ 2.50GHz
/0/1/3                        memory         32KiB L1 cache
/0/1/4                        memory         256KiB L2 cache
/0/1/5                        memory         3MiB L3 cache
/0/2                          memory         32KiB L1 cache
/0/7                          memory         16GiB System Memory
/0/7/0                        memory         8GiB SODIMM DDR3 Synchronous 1600 MHz (0,6 ns)
/0/7/1                        memory         8GiB SODIMM DDR3 Synchronous 1600 MHz (0,6 ns)
/0/c                          memory         128KiB BIOS
/0/100                        bridge         3rd Gen Core processor DRAM Controller
/0/100/1                      bridge         Xeon E3-1200 v2/3rd Gen Core processor PCI Express Root Port
/0/100/1/0                    display        GF108M [NVS 5400M]
/0/100/1/0.1                  multimedia     GF108 High Definition Audio Controller
/0/100/2                      display        3rd Gen Core processor Graphics Controller
/0/100/14                     bus            7 Series/C210 Series Chipset Family USB xHCI Host Controller
/0/100/14/0      usb3         bus            xHCI Host Controller
/0/100/14/0/4                 communication  H5321 gw
/0/100/14/1      usb4         bus            xHCI Host Controller
/0/100/16                     communication  7 Series/C216 Chipset Family MEI Controller #1
/0/100/19        enp0s25      network        82579LM Gigabit Network Connection (Lewisville)
/0/100/1a                     bus            7 Series/C216 Chipset Family USB Enhanced Host Controller #2
/0/100/1a/1      usb1         bus            EHCI Host Controller
/0/100/1a/1/1                 bus            Integrated Rate Matching Hub
/0/100/1a/1/1/1               generic        Integrated Smart Card Reader
/0/100/1a/1/1/6               multimedia     Integrated Camera
/0/100/1b                     multimedia     7 Series/C216 Chipset Family High Definition Audio Controller
/0/100/1c                     bridge         7 Series/C216 Chipset Family PCI Express Root Port 1
/0/100/1c/0                   generic        MMC/SD Host Controller
/0/100/1c/0.3                 bus            R5C832 PCIe IEEE 1394 Controller
/0/100/1c.1                   bridge         7 Series/C210 Series Chipset Family PCI Express Root Port 2
/0/100/1c.1/0    wlp3s0       network        Centrino Advanced-N 6205 [Taylor Peak]
/0/100/1c.2                   bridge         7 Series/C210 Series Chipset Family PCI Express Root Port 3
/0/100/1d                     bus            7 Series/C216 Chipset Family USB Enhanced Host Controller #1
/0/100/1d/1      usb2         bus            EHCI Host Controller
/0/100/1d/1/1                 bus            Integrated Rate Matching Hub
/0/100/1f                     bridge         QM77 Express Chipset LPC Controller
/0/100/1f.2                   storage        7 Series Chipset Family 6-port SATA Controller [AHCI mode]
/0/100/1f.3                   bus            7 Series/C216 Chipset Family SMBus Controller
/0/0             scsi0        storage        
/0/0/0.0.0       /dev/sda     disk           240GB SanDisk SDSSDA24
/0/0/0.0.0/1     /dev/sda1    volume         223GiB EXT4 volume
/0/3             scsi1        storage        
/0/3/0.0.0       /dev/sdb     disk           500GB TOSHIBA MK5061GS
/0/3/0.0.0/1     /dev/sdb1    volume         465GiB EXT4 volume
/1                            power          45N1001
/2               wwp0s20u4i6  network        Ethernet interface
