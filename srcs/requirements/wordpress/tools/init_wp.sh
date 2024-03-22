#!/bin/bash

sleep 5

sh /execute/sync.sh

wp core download --allow-root
echo "download finished \n"

wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb --allow-root

# wp config create --ftphost=ftp --ftuser=$FTP_USER --ftppass=$FTP_PASSWORD --allow-root

echo "config create finished \n"


wp core install --url=10.11.100.156 --title=leprissa --admin_user=$MARIADB_USER --admin_password=$MARIADB_PASSWORD --admin_email=bennixmehdi@gmail.com --allow-root
# wp core install --url=localhost --title=mysite --admin_user=$MARIADB_USER --admin_password=$MARIADB_PASSWORD --admin_email=bennixmehdi@gmail.com --allow-root
# wp core install --url=ebennix.42.fr --title=mysite --admin_user=$MARIADB_USER --admin_password=$MARIADB_PASSWORD --admin_email=bennixmehdi@gmail.com --allow-root

echo "core install finished \n"

wp user create ebennix info@gmail.com --role=author --user_pass=$MARIADB_PASSWORD --allow-root

echo "user creatation finished \n"


wp config set FTP_HOST ftp --allow-root
wp config set FTP_USER ftp_agent --allow-root
wp config set FTP_PASS ftp_agent1234 --allow-root
# echo "\ndefine('FTP_HOST', 'ftp');\ndefine('FTP_USER', 'ftp_agent');\ndefine('FTP_PASS', 'ftp_agent1234');" >> /var/www/html/wordpress/wp-config.php

wp plugin update --all --allow-root

wp plugin install redis-cache --activate --allow-root

wp config set WP_REDIS_HOST radis --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root

wp radis enable --allow-root

sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 9000|g" /etc/php/8.2/fpm/pool.d/www.conf

echo "starting php fast procces manager \n"
exec "$@"


