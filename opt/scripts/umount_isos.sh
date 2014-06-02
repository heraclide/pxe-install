#!/bin/bash

usage() {
    cat <<EOF >&2
$@
Usage: $0 /path/to/umount/iso
Use $0 to automatically umount iso files
EOF
    exit 1
}


PATH_TO_MOUNT=$1

/etc/init.d/nfs-kernel-server stop
for toBeUmounted in `mount | grep $PATH_TO_MOUNT | awk '{ print $3 }'`; do
  umount -f $toBeUmounted
done;
/etc/init.d/nfs-kernel-server start


