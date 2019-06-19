#!/bin/bash 

# config
mount="/path/to/mount"
targetBasePath="/path/to/mount/backup"
list="/path/to/files.txt"
listContext="/"

mkdir -p "$backupPath"

function backup {
    # (u) update, (r) recursive, (R) keep folder structure, (v) verbose
    rsync -urRv --no-perms --no-owner --no-group --recursive --files-from="$list" "$listContext" "$targetBasePath"
}

# Verify mount before attempting backup
if grep -qs "$mount" /proc/mounts; then
  echo "$mount is already mounted."
  backup
else
  echo "$mount is not mounted. Attempting to mount..."
  mount "$mount"
  if [ $? -eq 0 ]; then
   echo "Mount success!"
   backup
  else
   echo "Something went wrong with the mount..."
  fi
fi
