#!/bin/bash

# backup location
backupPath="/home/tharris/box.com/ubu/backup"
mkdir -p "$backupPath"
# files to backup
declare -a files=(
	"/home/tharris/backupConfigs.sh"
	"/etc/fstab"
	"/home/tharris/commands.txt"
	"/etc/nginx/nginx.conf"
	"/etc/nginx/sites-available/tdh" 
	"/var/www/index.html" 
	"/var/www/src/tdh.css"
	"/var/www/src/img/cloud.ico"
	"/var/www/src/img/debut_dark.png"
	"/etc/openvpn/ca-toronto.conf"
	"/etc/openvpn/us-ca.conf"
	"/etc/openvpn/auth.txt"
	"/etc/openvpn/ca.crt"
	"/etc/openvpn/crl.pem"
	"/usr/local/bin/openvpn-up.sh"
	"/usr/local/bin/openvpn-down.sh"
	"/etc/default/openvpn"
	"/home/rtorrent/.rtorrent.rc"
	"/etc/init.d/rtorrent"
	"/home/rtorrent/scripts/rtorrent_vpn_ip_bind.sh"
	"/home/rtorrent/scripts/notify_sickrage_postprocess.sh"
	"/etc/samba/smb.conf"
	"/home/rtorrent/.sickrage/config.ini"
	"/home/rtorrent/.couchpotato/settings.conf"
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