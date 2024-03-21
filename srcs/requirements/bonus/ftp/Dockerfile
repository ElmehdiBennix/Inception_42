
FROM debian:stable

RUN apt-get update && apt-get install vsftpd vim -y

RUN service vsftpd stop

RUN adduser --home /var/www/html/wordpress ftp_agent --disabled-password && echo "ftp_agent:ftp_agent1234" | chpasswd

COPY ./tools/init_ftp.sh /execute/init_ftp.sh

EXPOSE 21/tcp 30000-30009/tcp
#  20/tcp

RUN chmod +x /execute/init_ftp.sh

ENTRYPOINT [ "sh", "/execute/init_ftp.sh" ]

CMD [ "vsftpd", "/etc/vsftpd.conf" ]

#ftp commands lcd !ls |  put get mget mput