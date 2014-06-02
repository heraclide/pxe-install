#!/bin/bash

usage() {
    cat <<EOF >&2
$@
Usage: $0 /path/to/mount/iso /path/to/search/iso
Use $0 to automatically find and mount iso files
EOF
    exit 1
}


make_things_clean() {
  PATH_TO_MOUNT=$1

  /etc/init.d/nfs-kernel-server stop
  for toBeUmounted in `mount | grep $PATH_TO_MOUNT | awk '{ print $3 }'`; do
    umount -f $toBeUmounted
  done;

  rm -fR $PATH_TO_MOUNT/*
}


find_and_mount () {
   PATH_TO_MOUNT=$1
   PATH_TO_SEARCH=$2
   for currentIso in `find $PATH_TO_SEARCH -type f -name \*.iso`; do
      SHORTNAME=`basename $currentIso | sed -e 's/\.iso$//'`
      mkdir -p $PATH_TO_MOUNT/$SHORTNAME
      mount -o loop $currentIso $PATH_TO_MOUNT/$SHORTNAME
   done;
}

generate_exports() {
  PATH_TO_FIND_MOUNT=$1
  for currentDistro in `find $PATH_TO_FIND_MOUNT -mindepth 1 -maxdepth 1 -type d | sort -k7,12 -r -n`; do
    distroName=`basename $currentDistro`
    echo "$PATH_TO_FIND_MOUNT/$distroName 10.42.0.0/16(ro,sync,no_root_squash,no_subtree_check)" >> /etc/exports
  done;
}

export_and_start() {
  echo "" > /etc/exports
  for curPath in `find /opt/tftp -mindepth 1 -maxdepth 1 -type d | grep -v pxelinux`; do
    generate_exports $curPath
  done;

  /etc/init.d/nfs-kernel-server start
}


[ $# -ne 2 ] && usage
PATH_TO_MOUNT=$1
PATH_TO_SEARCH=$2

# make things clean
make_things_clean $PATH_TO_MOUNT
# and now work !
find_and_mount $PATH_TO_MOUNT $PATH_TO_SEARCH

export_and_start

