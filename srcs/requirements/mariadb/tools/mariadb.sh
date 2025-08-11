#!/bin/bash

# start mariadb service
#Starts the MariaDB daemon process (mysqld)
# Reads configuration from /etc/my.cnf or /etc/mysql/my.cnf
# Initializes database files if this is the first start
# Opens network ports (default is 3306 for MySQL/MariaDB)
# Begins accepting client connections

service mariadb start

sleep 5 # Wait for mariadb to start properly

# mysql command-line client to talk to mariadb server
# -u root: Connects as the root user
# -e: Execute command and exit
#This flag tells MySQL to run the following SQL statement rather than enter interactive mode
# After execution, the client will automatically exit
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
# @'%' allows connections from any host
mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
# grant all privileges on the database to the user
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
# *.* means all database in the server
# This grants the user all privileges on all databases and tables in the server
# IDENTIFIED BY sets the password for the user
# WITH GRANT OPTION allows the user to grant privileges to other users
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' WITH GRANT OPTION;"
# Flush Privileges statement reloads the grant tables' privileges, ensuring that any changes made to user 
# permissions  are immediately applied without requiring a restart of the MySQL server
mysql -u root -e "FLUSH PRIVILEGES;"
# mysqladmin: A client utility to perform administrative tasks.
# -p tells the MySQL client that you will provide a password.
# shutdown: Tells the MySQL server to shut down gracefully.
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# start mariadb in safe mode
# mysqld_safe is a script that starts the MySQL server (mysqld)
# It is designed to run the server in a more secure and stable way.
# It handles errors and restarts the server if it crashes.
exec mysqld_safe