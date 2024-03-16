#!/bin/bash

sh /execute/sync.sh

wp core download --allow-root
echo "download finished \n"

wp config create --dbname=$MARIADB_DATABASE --dbuser=$MARIADB_USER --dbpass=$MARIADB_PASSWORD --dbhost=mariadb --allow-root
echo "config create finished \n"

wp core install --url=ebennix.42.fr --title=mysite --admin_user=$MARIADB_USER --admin_password=$MARIADB_PASSWORD --admin_email=bennixmehdi@gmail.com --allow-root
echo "core install finished \n"

wp user create ebennix info@gmail.com --role=author --user_pass=$MARIADB_PASSWORD --allow-root
echo "user create finished finished \n"

echo "starting php fast procces manager \n"
