#!/bin/bash

PATH_TO_FIND_MOUNT="/opt/tftp/ubuntu"

echo_menu() {
 
	echo "LABEL $1"
	echo "      MENU LABEL $1"
	echo "      KERNEL $3"
	echo "      APPEND boot=casper $5 netboot=nfs nfsroot=172.17.192.1:${6}/${2} keyb=fr initrd=$4 only-ubiquity --"
	echo ""
	echo ""
}

find_and_echo () { 
   PATH_TO_FIND_MOUNT=$1

   for currentVersion in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d -exec basename '{}' \; | awk -F "-" '{ print $2 }' | sort -n -r | uniq`; do
      for currentDistro in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d | grep "\-"$currentVersion"\-" | grep -v server | sort | uniq`; do
         distroName=`basename $currentDistro`

         path_to_initrd=`find $currentDistro -type f -name initrd.gz | grep -v netboot | sed -e 's/\/opt\/tftp\///'`
         if [ "$path_to_initrd" == "" ]; then
            path_to_initrd=`find $currentDistro -type f -name initrd.lz | sed -e 's/\/opt\/tftp\///'`
         fi;
      
         test_fr=`echo $distroName | grep "\-fr"`          
         if [ "$test_fr" == "" ]; then
           LOCALE=" "
         else
           LOCALE="locale=fr_FR.UTF-8 console-setup/layoutcode=fr"
         fi;

         path_to_kernel_efi=`find $currentDistro -type f -name vmlinuz.efi | sed -e 's/\/opt\/tftp\///'`
         if [ "$path_to_kernel_efi" != "" ]; then
          label=$distroName"-EFI"
        echo_menu $label $distroName $path_to_kernel_efi $path_to_initrd "$LOCALE" $PATH_TO_FIND_MOUNT 
          fi;
          
         path_to_kernel=`find $currentDistro -type f -name vmlinuz | sed -e 's/\/opt\/tftp\///'`
         if [ "$path_to_kernel" != "" ]; then
        echo_menu $distroName $distroName $path_to_kernel $path_to_initrd "$LOCALE" $PATH_TO_FIND_MOUNT
          fi;

         done;
   done;
}

find_and_echo /opt/tftp/ubuntu-fr > /opt/tftp/pxelinux.cfg/ubuntu-fr.menu
find_and_echo /opt/tftp/ubuntu > /opt/tftp/pxelinux.cfg/ubuntu.menu 
find_and_echo /opt/tftp/xubuntu > /opt/tftp/pxelinux.cfg/xubuntu.menu
find_and_echo /opt/tftp/kubuntu > /opt/tftp/pxelinux.cfg/kubuntu.menu
find_and_echo /opt/tftp/lubuntu > /opt/tftp/pxelinux.cfg/lubuntu.menu

