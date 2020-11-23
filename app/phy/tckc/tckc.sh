#!/usr/bin/env bash
#/** 
#  * This script ...
#  * 
#  * Copyright (c) 2019 Christian Prior
#  * Licensed under the MIT License. See LICENSE file in the project root for full license information.
#  * 
#  * Usage: ...
#  * 
#  * @TODO: ...
#  * 
#  */


set -o nounset #exit on undeclared variable

__PRODUCTID=""
__VENDOR=""
__MODEL=""
__SCRIPTDIR=$(dirname "$0")
__SCRIPTNAME=$(basename "$0")
__LOCALVERSION="custom"        #l no underscores allowed
__LOCALYESVERSION="false"    #b
__VERBOSE=""                 #v
__SILENT="-s"                #v
__STARTCLEAN="false"         #c
__INSTALL="false"            #i
__MAKE="false"               #m
__ARCH=$(uname -i)           #a
__REQUESTINPUT="false"       #r

__TEMP=$(mktemp /tmp/output.XXXXXXXXXX) || { echo "Failed to create temp file"; exit 1; }
trap "{ rm -f ${__TEMP}; }" EXIT

__usage() {
    cat << EOT
  Usage :  ${__SCRIPTNAME} [options]
  Examples:
    - ${__SCRIPTNAME}
    - ${__SCRIPTNAME} -a x86_64
    - ${__SCRIPTNAME} -a amd
    - ${__SCRIPTNAME} -l mine -b -v -i
  Options:
    -a  The architecture to build for. Detaults to \`uname -i\` $(uname -i).
    -b  Call make localyesversion to change modules to builtin.
        Implies -c
    -c  Start clean with make mrproper
    -h  Display this message
    -i  Also install the kernel with make install modules_install.
        Implies -m
    -l  Set a localversion string to be appended to kernel name
    -m  Make the kernel with make bzImage.
        Takes some time.
    -r  Request input from user, e.g. config choices. (not implemented yet)
EOT
}

while getopts ":a:bchil:mv" opt; do
  case $opt in
    a) __ARCH=$OPTARG                   ;;
    b) __LOCALYESVERSION="true";
       __STARTCLEAN="true"
       ;;
    c) __STARTCLEAN="true"              ;;
    h) __usage; exit 0                  ;;
    i) __INSTALL="true"; __MAKE="true"  ;;
    l) __LOCALVERSION=$OPTARG           ;;
    m) __MAKE="true"                    ;;
    r) __REQUESTINPUT="true"            ;;
    v) __VERBOSE="-v"; __SILENT=""      ;;
    \?) echo "Invalid option -$OPTARG" >&2; echo -n "continuing "; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; echo ".";
        ;;
  esac;
done

#http://stackoverflow.com/questions/18215973/how-to-check-if-running-as-root-in-a-bash-script
#The script needs root permissions to get the full output of \`lshw\`
_SUDO=''
if (( $EUID != 0 )); then
    echo "This script needs root permissions to get the full output of \`lshw\`"
    while true; do sudo lshw -quiet > ${__TEMP}; break; done
  _SUDO='sudo'
fi; #from now on this is possible: $SUDO some_command
_SUDO='' #revert potential security hole until \`sudo\` is really needed further on


#Trying to keep this to a minimum.
#Script tested and developed on Ubuntu 18.04
checkrequirements() {
    echo -n "Checking requirements."
    i=0;
    type awk >/dev/null 2>&1 || { echo >&2 "This script requires awk but it is not installed. ";  i=$((i + 1)); }
    type lshw >/dev/null 2>&1 || { echo >&2 "This script requires lshw but it is not installed. ";  i=$((i + 1)); }
    type make >/dev/null 2>&1 || { echo >&2 "This script requires make but it is not installed. ";  i=$((i + 1)); }
    type gcc >/dev/null 2>&1 || { echo >&2 "This script requires gcc but it is not installed. ";  i=$((i + 1)); }

    echo "..done."
    if [[ $i > 0 ]]; then echo "Aborting."; echo "Please install the missing dependency."; exit 1; fi
} #end function checkrequirements

startclean() {
  :
  # if [ "${__STARTCLEAN}" == "true" ]; then
  #   echo -n "make mrproper; make defconfig."
  #   make ${__SILENT} mrproper;
  #   make ARCH=${__ARCH} ${__SILENT} defconfig;
  #   # echo -n "make mrproper; make alldefconfig."
  #   # make ${__SILENT} mrproper;
  #   # if [ "x${__VERBOSE}" != "x" ]; then #verbose is not ""
  #   #   # defconfig takes defaults from arch/$(ARCH)/configs
  #   #   # this means later on more configs are to be confirmed by the user
  #   #   make ARCH=${__ARCH} defconfig;
  #   # else
  #   #   # alldefconfig sets all symbols to default
  #   #   # this means later on there is less to confirm
  #   #   make ARCH=${__ARCH} ${__SILENT} alldefconfig; #FIXME this also sets all built-in?
  #   # fi
  #   echo "..done."
  # fi
}

# What is a basic kernel config AFTER defconfig has set arch defaults?
# Most of the following comes from Gentoo and ArchLinux docs
# https://wiki.gentoo.org/wiki/Kernel/Gentoo_Kernel_Configuration_Guide
# 

source ${__SCRIPTDIR}/../../../tec/phy/myBasicKernelConfig.sh

######################################################################
#/**
#  * Main part
#  *
#  */

#clear
echo -e "Linux kernel config script leveraging ./scripts/config\n"
checkrequirements

echo -n "Probing vendor, model and productID."
__VENDOR=$( head -10 ${__TEMP} | grep "vendor:" | awk '{gsub (" ", "", $2); print $2; }');
__MODEL=$( head -10 ${__TEMP} | grep "version:" | awk 'OFS=""; {gsub (" ", "", $2); print $2,$3; }');
__PRODUCTID=$( head -10 ${__TEMP} | grep "product:" | awk '{gsub (" ", "", $2); print $2; }');
echo "..done."


if [ "${__STARTCLEAN}" == "true" ]; then
    # startclean
    echo -n "make mrproper; make defconfig."
    make ${__SILENT} mrproper;
    make ARCH=${__ARCH} ${__SILENT} defconfig;
fi

#/**
#  * Now ...
#  *
#  */

./scripts/config --enable CONFIG_MODULES # boolean

setBasicKernelConfig
setFilesystemKernelConfig
setSystemdKernelConfigFull
#setContainerKernelConfigFull
setVirtualizationConfig

setSoundConfig
setVideo4LinuxConfig
setNtfsConfig

#remove this for general use
#${__SCRIPTDIR}/../../../tec/phy/LENOVO_ThinkPadT530_239237G.sh

#setGptPartitionLabelSupportKernelConfig
#setEfiKernelConfig
setPrinterKernelConfig

if [ -f ${__SCRIPTDIR}/../../../tec/phy/${__VENDOR}_${__MODEL}_${__PRODUCTID}.sh ]; then
    echo -n "Applying configuration for ${__VENDOR} ${__MODEL} with productID ${__PRODUCTID}."
    ${__SCRIPTDIR}/../../../tec/phy/${__VENDOR}_${__MODEL}_${__PRODUCTID}.sh
    echo "..done."
fi

./scripts/config --set-str LOCALVERSION ".${__LOCALVERSION}"

if [ "${__LOCALYESVERSION}" == "true" ]; then
    echo -n "Changing modules to built-in."
    if [ "x${__VERBOSE}" != "x" ]; then #verbose is not ""
      make ${__SILENT} localyesconfig
    else
      yes "" | make ${__SILENT} localyesconfig 1>/dev/null
    fi
    echo "..done."
    sleep 4
fi #end if else ...


#/**
#  * Now ...
#  *
#  */

if [ "${__MAKE}" == "true" ]; then
    if [ "x${__VERBOSE}" != "x" ]; then
      echo -n "make bzImage."
      make -j5 bzImage
      echo "..done."
      echo -n "make modules."
      make -j5 modules
      echo "..done."   
      echo -n "make headers_install."
      make headers_install
      echo "..done."      
    else
      echo -n "make bzImage (silent)."
      yes "" | make -s -j5 bzImage
      echo "..done."
      echo -n "make modules (silent)."
      make ${__SILENT} -j5 modules
      echo "..done."
      echo -n "make headers_install (silent)."
      make ${__SILENT} headers_install
      echo "..done."      
    fi
fi #end if ...


if [ "${__INSTALL}" == "true" ]; then
  echo -n "make install modules_install"
  sudo make ${__SILENT} install modules_install
  echo "..done."
fi #end if ...



exit 0