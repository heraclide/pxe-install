#!/bin/sh

for i in $(seq 0 256); do
  if [ ! -e /dev/loop$i ]; then
	mknod -m0660 /dev/loop$i b 7 $i
	chown root.disk /dev/loop$i
  fi;
done
