
FROM debian:stable

RUN apt-get update && apt-get install vsftpd vim -y

RUN service vsftpd stop

RUN adduser --home /var/www/html/wordpress ftp_agent --disabled-password && echo "ftp_agent:ftp_agent1234" | chpasswd

RUN chown -R ftp_agent:ftp_agent /var/www/html/wordpress

RUN chmod 755 /var/www/html/wordpress


# This enables FTP commands which change the filesystem, including commands like `STOR`, `DELE`, `RNFR`, `RNTO`, etc.
RUN echo "write_enable=YES" >> /etc/vsftpd.conf
# This enables local users to log in to the FTP server.
# RUN echo "local_enable=YES" >> /etc/vsftpd.conf
# This confines local users to their home directories by default, preventing them from navigating the entire filesystem.
RUN echo "chroot_local_user=YES" >> /etc/vsftpd.conf
RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
# enable ftp passive and ports
RUN echo "pasv_enable=YES" >> /etc/vsftpd.conf
RUN echo "pasv_min_port=30000" >> /etc/vsftpd.conf
RUN echo "pasv_max_port=30009" >> /etc/vsftpd.conf

# COPY ./conf/vsftpd.conf /etc

EXPOSE 21/tcp 20/tcp 30000-30009/tcp
#  10090-10100/tcp)

CMD [ "vsftpd", "/etc/vsftpd.conf" ]


#ftp commands lcd !ls |  put get mget mput