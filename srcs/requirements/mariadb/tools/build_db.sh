#!/bin/bash

DATA_DIR="/var/mysql"

mysql -V

# Bind address to 0.0.0.0 to allow connections from any IP address
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

#add data base location to mariadb my.cnf file to specify the mounted volume
echo -e "[mysqld]\ndatadir=/var/mysql" >> /etc/mysql/my.cnf

# Replace /var/mysql with your actual data directory path

# Check if the data directory exists and is not empty
if [ ! -d "$DATA_DIR" ] || [ -z "$(ls -A $DATA_DIR)" ]; then
    echo "Data directory does not exist or is empty. Initializing database..."
    mysql_install_db
    echo "Database initialized."
else
    echo "Data directory already exists and is not empty. Skipping initialization."
fi

# Start MariaDB service in background
# service mariadb start
mysqld_safe &

# Wait for MariaDB to start need a better way for this
sleep 2

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
# service mariadb stop wont work 
mysqladmin -u root -p$MARIADB_ROOT_PASSWORD shutdown

mysqld_safe
