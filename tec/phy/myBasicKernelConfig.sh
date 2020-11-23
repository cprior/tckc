


setFilesystemKernelConfig(){
    #https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation#Activating_required_options
    ./scripts/config --enable  EXT2_FS
    ./scripts/config --enable  EXT4_FS
    ./scripts/config --enable  MSDOS_FS
    ./scripts/config --enable  VFAT_FS
    ./scripts/config --enable  PROC_FS
    ./scripts/config --enable  TMPFS
    ./scripts/config --enable SQUASHFS
    ./scripts/config --enable SQUASHFS_XZ
}

setContainerKernelConfigFull(){

    # https://github.com/gg7/gentoo-kernel-guide
    # Docker (useful: contrib/check-config.sh)
    # "Generally Necessary"
    ./scripts/config --enable NAMESPACES                   # boolean
    ./scripts/config --enable NET_NS                       # boolean
    ./scripts/config --enable PID_NS                       # boolean
    ./scripts/config --enable IPC_NS                       # boolean
    ./scripts/config --enable UTS_NS                       # boolean
    ./scripts/config --enable CGROUPS                      # boolean
    ./scripts/config --enable CGROUP_CPUACCT               # boolean
    ./scripts/config --enable CGROUP_DEVICE                # boolean
    ./scripts/config --enable CGROUP_FREEZER               # boolean
    ./scripts/config --enable CGROUP_SCHED                 # boolean
    ./scripts/config --enable CPUSETS                      # boolean
    ./scripts/config --enable MEMCG                        # boolean
    ./scripts/config --enable KEYS                         # boolean
    ./scripts/config --module VETH                         # tristate
    ./scripts/config --module BRIDGE                       # tristate
    ./scripts/config --module NETFILTER_ADVANCED           # boolean, implicit requirement for BRIDGE_NETFILTER
    ./scripts/config --module BRIDGE_NETFILTER             # tristate
    ./scripts/config --module NF_NAT_IPV4                  # tristate
    ./scripts/config --module IP_NF_FILTER                 # tristate
    ./scripts/config --module IP_NF_TARGET_MASQUERADE      # tristate
    ./scripts/config --module NETFILTER_XT_MATCH_ADDRTYPE  # tristate
    ./scripts/config --module NETFILTER_XT_MATCH_CONNTRACK # tristate
    ./scripts/config --module NETFILTER_XT_MATCH_IPVS      # tristate
    ./scripts/config --module IP_NF_NAT                    # tristate
    ./scripts/config --module NF_NAT                       # tristate
    ./scripts/config --enable NF_NAT_NEEDED                # boolean
    ./scripts/config --enable POSIX_MQUEUE                 # boolean
    # "Optional Features"
    ./scripts/config --enable USER_NS                      # boolean
    ./scripts/config --enable SECCOMP                      # boolean
    ./scripts/config --enable CGROUP_PIDS                  # boolean
    ./scripts/config --enable MEMCG_SWAP                   # boolean
    ./scripts/config --enable MEMCG_SWAP_ENABLED           # boolean
    ./scripts/config --enable LEGACY_VSYSCALL_EMULATE      # boolean
    ./scripts/config --enable BLK_CGROUP                   # boolean
    ./scripts/config --enable BLK_DEV_THROTTLING           # boolean
    ./scripts/config --module IOSCHED_CFQ                  # tristate
    ./scripts/config --enable CFQ_GROUP_IOSCHED            # boolean
    ./scripts/config --enable CGROUP_PERF                  # boolean
    ./scripts/config --enable CGROUP_HUGETLB               # boolean
    ./scripts/config --module NET_CLS_CGROUP               # tristate
    ./scripts/config --enable CGROUP_NET_PRIO              # boolean
    ./scripts/config --enable CFS_BANDWIDTH                # boolean
    ./scripts/config --enable FAIR_GROUP_SCHED             # boolean
    ./scripts/config --enable RT_GROUP_SCHED               # boolean
    ./scripts/config --module IP_VS                        # tristate
    ./scripts/config --enable IP_VS_NFCT                   # boolean
    ./scripts/config --module IP_VS_RR                     # tristate
    ./scripts/config --enable EXT4_FS                      # tristate
    ./scripts/config --enable EXT4_FS_POSIX_ACL            # boolean
    ./scripts/config --enable EXT4_FS_SECURITY             # boolean
    # "Network Drivers/overlay"
    ./scripts/config --module VXLAN                        # tristate
    # "Network Drivers/overlay/Optional (for encrypted networks)":
    ./scripts/config --enable CRYPTO                       # tristate
    ./scripts/config --enable CRYPTO_AEAD                  # tristate
    ./scripts/config --enable CRYPTO_GCM                   # tristate
    ./scripts/config --enable CRYPTO_SEQIV                 # tristate
    ./scripts/config --enable CRYPTO_GHASH                 # tristate
    ./scripts/config --enable XFRM                         # boolean
    ./scripts/config --enable XFRM_USER                    # tristate
    ./scripts/config --enable XFRM_ALGO                    # tristate
    ./scripts/config --module INET_ESP                     # tristate
    ./scripts/config --enable INET_XFRM_MODE_TRANSPORT     # tristate
    # "Network Drivers/ipvlan"
    ./scripts/config --enable NET_L3_MASTER_DEV            # boolean, required for IPVLAN
    ./scripts/config --module IPVLAN                       # tristate
    # macvlan
    ./scripts/config --module MACVLAN                      # tristate
    ./scripts/config --module DUMMY                        # tristate
    # "ftp,tftp client in container"
    # ./scripts/config --module NF_NAT_FTP                   # tristate
    # ./scripts/config --module NF_CONNTRACK_FTP             # tristate
    # ./scripts/config --module NF_NAT_TFTP                  # tristate
    # ./scripts/config --module NF_CONNTRACK_TFTP            # tristate
    # "Storage Drivers"
    ./scripts/config --enable BTRFS_FS                     # tristate
    ./scripts/config --enable BTRFS_FS_POSIX_ACL           # boolean
    ./scripts/config --enable BLK_DEV_DM                   # tristate
    ./scripts/config --enable DM_THIN_PROVISIONING         # tristate
    ./scripts/config --module OVERLAY_FS                   # tristate
    # From the gentoo ebuild
    ./scripts/config --enable SYSVIPC                      # boolean
    ./scripts/config --enable IP_VS_PROTO_TCP              # boolean
    ./scripts/config --enable IP_VS_PROTO_UDP              # boolean

    # libvirt
    ./scripts/config --module MACVTAP # tristate
}


setBasicKernelConfig() {

# https://github.com/gg7/gentoo-kernel-guide
# /proc/config.gz
./scripts/config --enable IKCONFIG      # tristate
./scripts/config --enable IKCONFIG_PROC # boolean

# https://github.com/gg7/gentoo-kernel-guide
# Recommended by the Gentoo Handbook: "Also select Maintain a devtmpfs file
# system to mount at /dev so that critical device files are already available
# early in the boot process (CONFIG_DEVTMPFS and DEVTMPFS_MOUNT)":
./scripts/config --enable DEVTMPFS       # boolean
./scripts/config --enable DEVTMPFS_MOUNT # boolean

#https://wiki.gentoo.org/wiki/Handbook:AMD64/Full/Installation#Architecture_specific_kernel_configuration
./scripts/config --enable IA32_EMULATION





#https://github.com/gg7/gentoo-kernel-guide
# gentoo-sources ( https://gitweb.gentoo.org/proj/linux-patches.git/tree/4567_distro-Gentoo-Kconfig.patch ):
./scripts/config --enable DEVTMPFS # boolean
./scripts/config --enable TMPFS    # boolean
./scripts/config --enable UNIX     # tristate
./scripts/config --enable SHMEM    # boolean
# gentoo/portage:
./scripts/config --enable CGROUPS    # boolean
./scripts/config --enable NAMESPACES # boolean
./scripts/config --enable IPC_NS     # boolean
./scripts/config --enable NET_NS     # boolean
./scripts/config --enable SYSVIPC    # boolean

#from journalctl -xb
./scripts/config --enable CONFIG_VIRTIO # tristate
./scripts/config --enable CONFIG_SQUASHFS # tristate

# special hardware access
./scripts/config --enable ACPI_WMI
./scripts/config --enable WMI_BMOF
./scripts/config --enable I2C_CHARDEV

} #end function

setEfiKernelConfig() {
    ./scripts/config --enable CONFIG_EFI
    ./scripts/config --enable CONFIG_EFI_STUB
    ./scripts/config --enable CONFIG_EFI_MIXED
    ./scripts/config --enable CONFIG_EFI_VARS
}

setGptPartitionLabelSupportKernelConfig() {
    ./scripts/config --enable CONFIG_PARTITION_ADVANCED
    ./scripts/config --enable CONFIG_EFI_PARTITION
}

setPrinterKernelConfig() {
    ./scripts/config --enable USB_PRINTER
}

setSoundConfig() {
    ./scripts/config --enable SND_USB_AUDIO
    ./scripts/config --enable SND_HDA_CODEC_HDMI
    ./scripts/config --enable USB_GADGET
    ./scripts/config --enable VIDEOBUF2_V4L2
    ./scripts/config --enable videobuf2_vmalloc
    ./scripts/config --enable videobuf2_memops
    ./scripts/config --enable videobuf2_core
    ./scripts/config --enable MEDIA_SUPPORT
    ./scripts/config --enable snd_usb_audio
    ./scripts/config --enable snd_seq
#    ./scripts/config --enable 
#    ./scripts/config --enable 
}

setVideo4LinuxConfig() {
    ./scripts/config --enable VIDEO_V4L2
    ./scripts/config --enable MEDIA_SUPPORT
    ./scripts/config --enable MEDIA_USB_SUPPORT
    ./scripts/config --enable VIDEO_ADV_DEBUG
    ./scripts/config --enable MEDIA_CAMERA_SUPPORT
    ./scripts/config --enable USB_VIDEO_CLASS
}

setNtfsConfig() {
    ./scripts/config --enable NTFS_FS
    ./scripts/config --enable NTFS_RW
    ./scripts/config --module FUSE_FS
}


setSystemdKernelConfigFull(){
    # Systemd
    #https://cgit.freedesktop.org/systemd/systemd/tree/README
    #via https://github.com/gg7/gentoo-kernel-guide
    ./scripts/config --enable CONFIG_DEVTMPFS
    ./scripts/config --enable CONFIG_CGROUPS
    ./scripts/config --enable CONFIG_INOTIFY_USER
    ./scripts/config --enable CONFIG_SIGNALFD
    ./scripts/config --enable CONFIG_TIMERFD
    ./scripts/config --enable CONFIG_EPOLL
    ./scripts/config --enable CONFIG_NET
    ./scripts/config --enable CONFIG_SYSFS
    ./scripts/config --enable CONFIG_PROC_FS
    ./scripts/config --enable CONFIG_FHANDLE

    ./scripts/config --disable CONFIG_SYSFS_DEPRECATED
    ./scripts/config --set-str CONFIG_UEVENT_HELPER_PATH ""
    ./scripts/config --disable CONFIG_FW_LOADER_USER_HELPER
    ./scripts/config --enable CONFIG_DMIID
    ./scripts/config --enable CONFIG_BLK_DEV_BSG
    ./scripts/config --enable CONFIG_NET_NS
    ./scripts/config --enable CONFIG_DEVPTS_MULTIPLE_INSTANCES
    ./scripts/config --enable CONFIG_IPV6
    ./scripts/config --enable CONFIG_AUTOFS4_FS
    ./scripts/config --enable CONFIG_TMPFS_XATTR
    ./scripts/config --enable CONFIG_TMPFS_POSIX_ACL
    ./scripts/config --enable CONFIG_EXT4_POSIX_ACL
    ./scripts/config --enable CONFIG_XFS_POSIX_ACL
    ./scripts/config --enable CONFIG_SECCOMP
    ./scripts/config --enable CONFIG_CHECKPOINT_RESTORE

    ./scripts/config --enable CONFIG_CGROUP_SCHED
    ./scripts/config --enable CONFIG_FAIR_GROUP_SCHED
    ./scripts/config --enable CONFIG_CFS_BANDWIDTH
    ./scripts/config --enable CONFIG_SCHEDSTATS
    ./scripts/config --enable CONFIG_SCHED_DEBUG
    ./scripts/config --enable CONFIG_EFIVAR_FS
    ./scripts/config --enable CONFIG_EFI_PARTITION

    ./scripts/config --disable CONFIG_RT_GROUP_SCHED

    ./scripts/config --disable CONFIG_AUDIT
}

setVirtualizationConfig() {
    ./scripts/config --enable CONFIG_KVM
    ./scripts/config --enable CONFIG_KVM_INTEL
    ./scripts/config --enable VIRTIO
    ./scripts/config --enable VIRT_DRIVERS
    ./scripts/config --enable DRM_VBOXVIDEO
    ./scripts/config --enable VBOXGUEST
    ./scripts/config --enable VBOXSF_FS
}