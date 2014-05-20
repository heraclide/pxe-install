#!/bin/sh

path_to_error_log="/var/log/apache2/ubuntu_error.log"

#for currentMissingDeb in `grep "File does not exist" $path_to_error_log | grep deb | awk -F "File does not exist: " '{ print $2 }'`; do
for currentMissingDeb in `grep "File does not exist" $path_to_error_log | awk -F "File does not exist: " '{ print $2 }'`; do
  sourceMissingDeb=`echo $currentMissingDeb | sed -e 's/\/opt\/www\/ubuntu\/ubuntu\///'`
  rsync rsync://fr.archive.ubuntu.com/ubuntu/$sourceMissingDeb $currentMissingDeb 
done;
