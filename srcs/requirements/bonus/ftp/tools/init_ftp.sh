#!/bin/bash

service vsftpd stop

adduser $FTP_USER --disabled-password

echo "$FTP_USER:$FTP_PASSWORD" | chpasswd &> /dev/null

chown -R $FTP_USER:$FTP_USER /var/www/html
chmod -R 755 /var/www/html

echo "listen=YES
listen_ipv6=NO
anonymous_enable=NO
local_enable=YES
write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
chroot_local_user=YES
allow_writeable_chroot=YES
user_sub_token=$USER
local_root=/var/www/html
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30009
local_root=/var/www/html
ftpd_banner=Welcome $USER to the ftp server.
user_sub_token=$USER
local_umask=022" > /etc/vsftpd.conf

echo "<=== starting FTP on port 21 ===>"
exec "$@"
