#!/bin/bash

wp core download --allow-root

wp core install --url=ebennix.42.fr --title=mysite --admin_user=$MARIADB_USER --admin_password=$MARIADB_PASSWORD --admin_email=bennixmehdi@gmail.com --allow-root

wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb --allow-root

wp user create ebennix info@gmail.com --role=author --user_pass=$MARIADB_PASSWORD --allow-root

/usr/sbin/php-fpm8.2 -F