
FROM debian:stable

RUN apt-get update \
    && apt-get install vsftpd netcat-traditional -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN service vsftpd stop

RUN adduser --home /var/www/html/wordpress ftp_agent --disabled-password && echo "ftp_agent:ftp_agent1234" | chpasswd

COPY ./tools /execute

EXPOSE 21/tcp 30000-30009/tcp
#  20/tcp

RUN chmod -R +x /execute

ENTRYPOINT [ "sh", "/execute/init_ftp.sh" ]

CMD [ "vsftpd", "/etc/vsftpd.conf" ]

#ftp commands lcd !ls |  put get mget mput

# enetry point
