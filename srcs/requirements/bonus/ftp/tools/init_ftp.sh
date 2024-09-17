#!/bin/bash

useradd -m -d /var/www/html/wordpress $FTP_USER
echo "$FTP_USER:$FTP_PASSWORD" | chpasswd &> /dev/null
chown -R $FTP_USER:$FTP_USER /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

mkdir -p /var/run/vsftpd/empty

echo "listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30009"> /etc/vsftpd.conf

sleep 0.5
echo "<=== starting FTP on port 21 ===>"
exec "$@"
