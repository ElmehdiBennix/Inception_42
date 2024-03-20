
FROM debian:stable

RUN apt-get update && apt-get install vsftpd vim -y

RUN service vsftpd stop

RUN adduser --home /var/www/html/wordpress ftp_agent && echo "ftp_agent:ftp_agent1234" | chpasswd

# RUN chown -R ftp_agent /var/www/html

RUN echo "write_enable=YES" >> /etc/vsftpd.conf
# RUN echo "local_enable=YES" >> /etc/vsftpd.conf
# # RUN echo "chroot_local_user=YES" >> /etc/vsftpd.conf
# RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
RUN echo "pasv_enable=YES" >> /etc/vsftpd.conf
RUN echo "pasv_min_port=30000" >> /etc/vsftpd.conf
RUN echo "pasv_max_port=30009" >> /etc/vsftpd.conf

# Expose the FTP control port and passive ports
# COPY ./conf/vsftpd.conf /etc

EXPOSE 21/tcp 30000-30009/tcp
#  10090-10100/tcp

CMD [ "vsftpd", "/etc/vsftpd.conf" ]