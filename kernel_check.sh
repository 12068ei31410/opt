#!/bin/bash
# This script checks kernel and initramfs versions to be sure they match and are the latest.

rhelversion=`cat /etc/redhat-release | tr -d '[[:punct:]]' | tr -d '[[:alpha:]]' | while read line;do echo $line | cut -c1;done`
echo "rhelversion = $rhelversion"

currkernel=`uname -r | tr -d '[[:alpha:]]' | tr -d '[[:punct:]]'`

newestkernel=`rpm -qa --last kernel |head -1 | awk '{print $1}' | tr -d '[[:alpha:]]' | tr -d '[[:punct:]]'`



# Determine if UEFI or BIOS. Changes where the files are located.
bootmode=`[ -d /sys/firmware/efi ] && echo UEFI || echo BIOS`
echo "bootmode = $bootmode"


newestinitramfs1=`rpm -qa --last kernel |head -1 | awk '{print $1}' | cut -d "_" -f 1 | cut -d "-" -f 2,3 | while read line;do ls /boot | grep -v kdump | grep initramfs-$line;done`
echo "newestinitramfs1 = $newestinitramfs1"


newestinitramfs2=`rpm -qa --last kernel |head -1 | awk '{print $1}' | cut -d "_" -f 1 | cut -d "-" -f 2,3 | while read line;do ls /boot | grep -v kdump | grep initramfs-$line;done | cut -d "-" -f 2,3 | tr -d '[[:punct:]]' | tr -d '[[:alpha:]]'`
echo "newestinitramfs2 = $newestinitramfs2"

# Determine bios and efi based on OS
case $rhelversion in

  6)
    bios=`grep -v '^#' /boot/grub/grub.conf 2>/dev/null | grep -m1 vmlinuz | awk '{print $2}' | cut -d "-" -f 2,3 | tr -d '[[:punct:]]' | tr -d '[[:alpha:]]'`
    echo "bios = $bios"
    efi=`grep -v '^#' /boot/efi/EFI/redhat/grub.conf 2>/dev/null | grep -m1 vmlinuz | awk '{print $2}' | cut -d "-" -f 2,3 | tr -d '[[:punct:]]' | tr -d '[[:alpha:]]'`
    echo "efi = $efi"
    ;;

  7)
    bios=`grep saved /boot/grub2/grubenv 2>/dev/null | cut -d " " -f 6 | tr -d '[[:punct:]]' | tr -d '[[:alpha:]]'`
    echo "bios = $bios"
    efi=`grep saved /boot/efi/EFI/redhat/grubenv 2>/dev/null | cut -d " " -f 6 | tr -d '[[:punct:]]' | tr -d '[[:alpha:]]'`
    echo "efi = $efi"
    ;;

  8)
    bios=`grep saved /boot/grub2/grubenv 2>/dev/null | cut -d "-" -f 2,3 | tr -d '[[:punct:]]' | tr -d '[[:alpha:]]'`
    echo "bios = $bios"
    efi=`grep saved /boot/efi/EFI/redhat/grubenv 2>/dev/null | cut -d "-" -f 2,3 | tr -d '[[:punct:]]' | tr -d '[[:alpha:]]'`
    echo "efi = $efi"
    ;;

  *)
    echo "Unknown OS Version $rhelversion"
    ;;
esac

# Check if newest kernel is the default based on boot mode then check if initrmfs is set to the same.
if [ $bootmode = UEFI ] && [ $efi = $newestkernel ] || [ $bootmode = BIOS ] && [ $bios = $newestkernel ];then
  echo "Default kernel entry is set to the newest kernel. Checking initramfs..."
else
  echo "Default kernel entry was not updated. Please run the following commands:

yum-complete-transaction
yum clean all
yum update
yum remove kernel
yum install kernel
yum-complete-transaction
"
  exit 255
fi

if [ $newestkernel -gt $newestinitramfs2 ]
then
  echo "Warning: initramfs might not have installed. Checking for newest initramfs image in the /boot directory..."
  echo "$newestinitramfs1"
  echo "
If no initramfs image is found, please run the following commands:

yum-complete-transaction
yum clean all
yum remove kernel
yum install kernel
yum-complete-transaction

Run this script again. If an initramfs image is not being listed by the script, contact your System Administrator or submit a Remedy ticket.
"
  exit 255
elif [ $newestkernel -eq $newestinitramfs2 ] && [ $newestkernel -eq $currkernel ]
then
  echo "Kernel is up to date and matches initramfs version."
else
  echo "Kernel was updated. Please reboot."
fi
