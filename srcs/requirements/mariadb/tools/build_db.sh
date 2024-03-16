#!/bin/bash

# mysql -V


#add data base location to mariadb my.cnf file to specify the mounted volume
# echo -e "[mysqld]\ndatadir=/var/mysql" >> /etc/mysql/my.cnf
# edit in 50serv.cnf

# give rights to mysql user to acces the database for the demeon to start
# chown -R mysql:mysql /var/mysql
# chmod -R 777 /var/mysql

# Check if the data directory exists and is not empty
# if [ ! -d "/var/mysql" ] || [ -z "$(ls -A /var/mysql)" ]; then
#     echo "Data directory does not exist or is empty. Initializing database..."
#     mysql_install_db --datadir=/var/mysql
## Run mysql_secure_install script
#     # ./tools/install.exp
## add a reltaive path
#     echo "Database initialized."
# else
#     echo "Data directory already exists and is not empty. Skipping initialization."
# fi


# Start MariaDB service in background
echo "init data base if it dosnt exist\n"
mysql_install_db


echo "starting mariadb service in the background\n"
mysqld_safe &
echo "starting to sleep for the service to full start\n"
sleep 4


# Wait for MariaDB to start need a better way for this

# echo "________________________________\n\n"
# service mariadb status
# echo "\n\n________________________________\n"

echo "passing rules to my sql to make database and user and alter root passord\n"
# Create database, grant privileges, and alter root password
echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE;" \
     "GRANT ALL ON $MARIADB_DATABASE.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';" \
     "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';" \
     "FLUSH PRIVILEGES;" | mysql -u root -p${MARIADB_ROOT_PASSWORD}

echo "shutting down the mariadb service to start it in forground\n"
# Stop MariaDB service
mysqladmin -u root -p${MARIADB_ROOT_PASSWORD} shutdown
# sleep 5

# service mariadb stop wont work 
# echo true > ready.txt

echo "exec mysqld_safe to check if the database has no harm and starting it as forground procces for the container\n"

exec "!@"
