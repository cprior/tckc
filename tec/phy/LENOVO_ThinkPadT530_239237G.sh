#!/usr/bin/env bash



./scripts/config --enable THINKPAD_ACPI
./scripts/config --enable SENSORS_HDAPS
#./scripts/config --enable 

./scripts/config --enable CONFIG_MAC80211
./scripts/config --enable CONFIG_IWLWIFI
./scripts/config --enable CONFIG_IWLWIFI_LEDS
./scripts/config --enable CONFIG_IWLDVM
./scripts/config --disable CONFIG_IWLMVM
./scripts/config --disable CONFIG_IWLWIFI_DEBUG
./scripts/config --disable CONFIG_IWLWIFI_DEVICE_TRACING
./scripts/config --enable FW_LOADER
./scripts/config --enable FIRMWARE_IN_KERNEL
./scripts/config --set-str CONFIG_EXTRA_FIRMWARE "iwlwifi-6000g2a-6.ucode"
./scripts/config --set-str CONFIG_EXTRA_FIRMWARE_DIR "/lib/firmware"



./scripts/config --enable CONFIG_E1000E
./scripts/config --enable CONFIG_DRM_NOUVEAU
#./scripts/config --disable DRM_LEGACY cannot be disabled
./scripts/config --enable NOUVEAU_LEGACY_CTX_SUPPORT
./scripts/config --set-val NOUVEAU_DEBUG 5
./scripts/config --set-val NOUVEAU_DEBUG_DEFAULT 3
./scripts/config --disable NOUVEAU_DEBUG_MMU
./scripts/config --enable DRM_NOUVEAU_BACKLIGHT
#./scripts/config --disable 

#make defconfig already enables several sound-related settings
./scripts/config --enable CONFIG_SND_HDA_CODEC_REALTEK
./scripts/config --enable snd_hda_codec_hdmi
./scripts/config --set-val SND_MAX_CARDS 32

#https://wiki.gentoo.org/wiki/Bluetooth#Kernel
./scripts/config --enable CONFIG_BT
./scripts/config --enable CONFIG_RFCOMM
./scripts/config --enable CONFIG_BT_HIDP
./scripts/config --enable CONFIG_BT_HCIBTUSB
./scripts/config --enable CONFIG_BT_HCIUART
./scripts/config --enable CONFIG_UHID
./scripts/config --enable CONFIG_BT_BREDR
./scripts/config --disable CONFIG_BT_RFCOMM
./scripts/config --disable CONFIG_BT_BNEP
./scripts/config --enable CONFIG_BT_HS
./scripts/config --enable CONFIG_BT_LE
./scripts/config --enable CONFIG_BT_LEDS
./scripts/config --disable CONFIG_BT_SELFTEST
./scripts/config --enable CONFIG_BT_DEBUGFS

./scripts/config --enable CONFIG_BT_HCIBTUSB_AUTOSUSPEND
./scripts/config --enable CONFIG_BT_HCIBTUSB_BCM
./scripts/config --enable CONFIG_BT_HCIBTUSB_MTK
./scripts/config --enable CONFIG_BT_HCIBTUSB_RTL
./scripts/config --disable CONFIG_BT_HCIUART_H4


./scripts/config --disable CONFIG_BT_HCIUART_BCSP
./scripts/config --disable CONFIG_BT_HCIUART_ATH3K
./scripts/config --disable CONFIG_BT_HCIUART_AG6XX
./scripts/config --disable CONFIG_BT_HCIBCM203X

./scripts/config --disable CONFIG_BT_HCIBPA10X
./scripts/config --disable CONFIG_BT_HCIBFUSB
./scripts/config --disable CONFIG_BT_HCIDTL1
./scripts/config --disable CONFIG_BT_HCIBT3C
./scripts/config --disable CONFIG_BT_HCIBLUECARD
./scripts/config --disable CONFIG_BT_HCIVHCI
./scripts/config --disable CONFIG_BT_MRVL
./scripts/config --disable CONFIG_BT_ATH3K


./scripts/config --enable CONFIG_HID_PLANTRONICS