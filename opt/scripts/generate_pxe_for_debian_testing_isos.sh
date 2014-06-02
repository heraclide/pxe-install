#!/bin/bash

PATH_TO_FIND_MOUNT="/opt/tftp/debian-testing"

echo_menu() {
 
	echo "LABEL $1"
	echo "      MENU LABEL $1"
	echo "      KERNEL $3"
	echo "      APPEND vga=normal netboot=nfs root=/dev/nfs nfsroot=10.42.0.1:/opt/tftp/debian-testing/$2 initrd=$4 --"
	echo ""
	echo ""
}

find_and_echo () { 
   PATH_TO_FIND_MOUNT=$1

   for currentVersion in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d -exec basename '{}' \; | awk -F "-" '{ print $2 }' | sort -n -r | uniq`; do
      for currentDistro in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d | grep "\-"$currentVersion"\-" | grep -v server | sort | uniq`; do
         distroName=`basename $currentDistro`

         path_to_initrd=`find $currentDistro -type f -name initrd.gz | egrep -v "(netboot|xen|gtk)" | sed -e 's/\/opt\/tftp\///'`
         if [ "$path_to_initrd" == "" ]; then
            path_to_initrd=`find $currentDistro -type f -name initrd.lz | sed -e 's/\/opt\/tftp\///'`
         fi;
      
         path_to_kernel=`find $currentDistro -type f -name vmlinuz | egrep -v "(xen|gtk)" | head -n1 | sed -e 's/\/opt\/tftp\///'`
         if [ "$path_to_kernel" != "" ]; then
        echo_menu $distroName $distroName $path_to_kernel $path_to_initrd
          fi;

         done;
   done;
}

find_and_echo /opt/tftp/debian-testing > /opt/tftp/pxelinux.cfg/debian-testing.menu 

