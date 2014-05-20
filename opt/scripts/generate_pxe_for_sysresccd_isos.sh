#!/bin/bash

PATH_TO_FIND_MOUNT="/opt/tftp/sysresccd"

echo_menu() {
 
	echo "LABEL $1"
	echo "      MENU LABEL $1"
	echo "      KERNEL $3"
	echo "      APPEND scandelay=5 netboot=tftp://172.17.192.1/$5 setkeymap=fr initrd=$4 --"
	echo ""
	echo ""
}

find_and_echo () { 
   PATH_TO_FIND_MOUNT=$1

   for currentVersion in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d -exec basename '{}' \; | awk -F "-" '{ print $2 }' | sort -n -r | uniq`; do
      for currentDistro in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d | grep "\-"$currentVersion"\-" | grep -v server | sort | uniq`; do
         distroName=`basename $currentDistro`

         path_to_dat=`find $currentDistro -type f -name sysrcd.dat | sed -e 's/\/opt\/tftp\///'`
         path_to_initrd=`find $currentDistro -type f -name initram.igz | egrep -v "(netboot|xen|gtk)" | sed -e 's/\/opt\/tftp\///'`
      
         path_to_kernel=`find $currentDistro -type f -name rescuecd | egrep -v "(xen|gtk)" | head -n1 | sed -e 's/\/opt\/tftp\///'`
         if [ "$path_to_kernel" != "" ]; then
        echo_menu $distroName $distroName $path_to_kernel $path_to_initrd $path_to_dat
          fi;

         done;
   done;
}

find_and_echo $PATH_TO_FIND_MOUNT  > /opt/tftp/pxelinux.cfg/sysresccd.menu 

