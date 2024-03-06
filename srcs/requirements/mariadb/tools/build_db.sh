#!/bin/bash

mysql -V

# Bind address to 0.0.0.0 to allow connections from any IP address
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

#add data base location to mariadb my.cnf file to specify the mounted volume
echo -e "[mysqld]\ndatadir=/var/mysql" >> /etc/mysql/my.cnf

# Start MariaDB service
mysqld_safe  &
# service mariadb start

# Wait for MariaDB to start
sleep 10

# Run mysql_secure_install script
# add a reltaive path
./tools/install.exp

# Create database, grant privileges, and alter root password
mysql -u root -e "
CREATE DATABASE IF NOT EXISTS \`$MARIADB_DATABASE\`;
GRANT ALL ON \`$MARIADB_DATABASE\`.* TO '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PASSWORD';
FLUSH PRIVILEGES;"

# Stop MariaDB service
service mariadb stop

mysqld_safe


#maybe a problem with chmod or chown access right verify 
