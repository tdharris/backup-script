#!/bin/bash 

# backup location
backupPath="/home/tharris/box.com/ubu/backup"
backupList="/home/tharris/backup-script/files.txt"
backupListContext="/"
mkdir -p "$backupPath"

function backup {
    # (u) update, (r) recursive, (R) keep folder structure, (v) verbose
    rsync -urRv --no-perms --no-owner --no-group --recursive --files-from="$backupList" "$backupListContext" "$backupPath"
    # exit 0
}

# Make sure box.com is mounted
mount="/home/tharris/box.com"

if grep -qs "$mount" /proc/mounts; then
  echo "It's mounted."
  backup
else
  echo "It's not mounted."
  mount "$mount"
  if [ $? -eq 0 ]; then
   echo "Mount success!"
   backup
  else
   echo "Something went wrong with the mount..."
  fi
fi

