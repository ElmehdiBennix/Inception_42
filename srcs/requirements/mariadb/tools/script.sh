#!/bin/bash



# service mariadb stop

# sleep 4

# mysql_secure_installation

# Set a predefined root password

# # Set the root password
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

# # Remove anonymous users
# mysql -e "DELETE FROM mysql.user WHERE User='';"
# mysql -e "FLUSH PRIVILEGES;"

# # Disallow remote root login
# mysql -e "UPDATE mysql.user SET Host='localhost' WHERE User='root';"
# mysql -e "FLUSH PRIVILEGES;"

# # Remove the test database
# mysql -e "DROP DATABASE IF EXISTS test;"

# # Reload privileges
# mysql -e "FLUSH PRIVILEGES;"

# # Remove the anonymous users table
# mysql -e "DROP TABLE IF EXISTS mysql.user;"

# echo "mysql_secure_installation script completed."

# mysql