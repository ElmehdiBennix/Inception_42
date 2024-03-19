
FROM debian:stable

RUN apt-get update && apt-get install vsftpd vim -y

RUN service vsftpd stop

RUN adduser --home /var/html/wordpress ftp_agent
RUN sed -i "s/^#write_enable=YES/write_enable=YES/" /etc/vsftpd.conf

EXPOSE 21

# RUN echo 