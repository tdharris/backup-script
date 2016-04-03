#!/bin/bash

# backup location
backupPath="/home/tharris/box.com/ubu/backup"
mkdir -p "$backupPath"
# files to backup
declare -a files=(
	"/etc/fstab"
	"/etc/nginx/nginx.conf"
	"/etc/samba/smb.conf"
	"/etc/vsftpd.conf"
)

## now loop through the above array
echo "Backup path: $backupPath"
for file in "${files[@]}"
do
   if [ -e "$file" ]; then
   	if [ "$file" -nt "$backupPath$file" ]; then
	    sudo cp -apvdf --parents "$file" "$backupPath"
	else echo "File hasn't been modified, skipping: $file"
	fi
   else echo "File doesn't exist: $file"
   fi
done

exit 0
