#!/bin/bash

PATH_TO_FIND_MOUNT="/opt/tftp/fedora"


echo_menu() {
 
	echo "LABEL $1"
	echo "      MENU LABEL $1"
	echo "      KERNEL $2"
       echo "      APPEND initrd=$3 stage2=http://fedora/releases/releases/$4/os/ inst.repo=http://fedora/releases/releases/$4/os/ ip=eth0:dhcp"
	echo ""
	echo ""
}

find_and_echo () { 
   PATH_TO_FIND_MOUNT=$1

   for currentVersion in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d -exec basename '{}' \; | awk -F "-" '{ print $2 }' | sort -n -r | uniq`; do
      for currentDistro in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d | grep "\-"$currentVersion"\-" | grep -v server | sort | uniq`; do
         distroName=`basename $currentDistro`

         path_to_initrd=`find $currentDistro -type f -name initrd.img | egrep -v "(netboot|xen|gtk)" | sed -e 's/\/opt\/tftp\///'`
      
         path_to_kernel=`find $currentDistro -type f -name vmlinuz | egrep -v "(xen|gtk)" | head -n1 | sed -e 's/\/opt\/tftp\///'`

         url=`echo $distroName | sed -e 's/Fedora.*-\([0-9]+\)-\(amd64|i386\).*/\1\/Fedora\/\2/'` 

         if [ "$path_to_kernel" != "" ]; then
        echo_menu $distroName $path_to_kernel $path_to_initrd $url
          fi;

         done;
   done;
}

find_and_echo /opt/tftp/fedora > /opt/tftp/pxelinux.cfg/fedora.menu 
#find_and_echo /opt/tftp/fedora

