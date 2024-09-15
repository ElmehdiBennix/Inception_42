#!/bin/bash

echo "Starting mariadb installation..."
mysql_install_db

mysqld_safe &
sleep 0.5

mysql -v
echo "Passing rules to mysql for configuration"

echo "DROP DATABASE IF EXISTS test;" \
     "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;" \
     "GRANT ALL ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';" \
     "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';" \
     "FLUSH PRIVILEGES;" | mysql -u root -p$MARIADB_ROOT_PASSWORD

mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown
echo "Database is ready for connections:"

exec "$@"
