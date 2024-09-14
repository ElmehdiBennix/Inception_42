#!/bin/bash

sleep 3

sh /execute/sync.sh

sed -i "s|listen = /run/php/php8.2-fpm.sock|listen = 9000|g" /etc/php/8.2/fpm/pool.d/www.conf

echo "Starting WP download..."
wp core download --allow-root

echo "Starting WP configuration ..."
wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb --allow-root
wp core install --url=localhost --title=leprissa --admin_user=$MARIADB_USER --admin_password=$MARIADB_PASSWORD --admin_email=$WP_EMAIL --allow-root
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWORD --allow-root

# ftp config
wp config set FTP_HOST ftp --allow-root
wp config set FTP_USER $FTP_USER --allow-root
wp config set FTP_PASS $FTP_PASSWORD --allow-root

# update plugins
wp plugin update --all --allow-root

# redis config
wp plugin install redis-cache --activate --allow-root
wp config set WP_REDIS_HOST redis_cache --allow-root
wp config set WP_REDIS_PORT 6379 --allow-root
wp redis enable --allow-root

echo "Starting PHP Fast Procces Manager:"
exec "$@"
