#!/bin/bash

sh /execute/sync.sh

adduser --home /var/www/html/wordpress $FTP_USER --disabled-password && echo "$FTP_USER:$FTP_PASSWORD" | chpasswd &> /dev/null

chown -R $FTP_USER:$FTP_USER /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress

# echo $FTP_USRER | tee -a /etc/vsftpd.userlist &> /dev/null

# This enables FTP commands which change the filesystem, including commands like `STOR`, `DELE`, `RNFR`, `RNTO`, etc.
echo "write_enable=YES" >> /etc/vsftpd.conf

# This enables local users to log in to the FTP server.
# echo "local_enable=YES" >> /etc/vsftpd.conf

# This confines local users to their home directories by default, preventing them from navigating the entire filesystem.
echo "chroot_local_user=YES" >> /etc/vsftpd.conf

# maybe wordpress dont work with this on
echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf



# enable ftp passive and ports
echo "pasv_enable=YES" >> /etc/vsftpd.conf
echo "pasv_min_port=30000" >> /etc/vsftpd.conf
echo "pasv_max_port=30009" >> /etc/vsftpd.conf


echo "<=== starting FTP on port 21 ===>"
exec "$@"
