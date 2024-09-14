#!/bin/bash

sh /execute/sync.sh

chown -R ftp_agent:ftp_agent /var/www/html
#/wordpress

chmod -R 755 /var/www/html
#/wordpress

# This enables FTP commands which change the filesystem, including commands like `STOR`, `DELE`, `RNFR`, `RNTO`, etc.
echo "write_enable=YES" >> /etc/vsftpd.conf
# This enables local users to log in to the FTP server.
# echo "local_enable=YES" >> /etc/vsftpd.conf
# This confines local users to their home directories by default, preventing them from navigating the entire filesystem.
echo "chroot_local_user=YES" >> /etc/vsftpd.conf
# // maybe wordpress dont work with this on
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
# enable ftp passive and ports
echo "pasv_enable=YES" >> /etc/vsftpd.conf
echo "pasv_min_port=30000" >> /etc/vsftpd.conf
echo "pasv_max_port=30009" >> /etc/vsftpd.conf

exec "$@"
