#!/bin/bash

#"/var/www/html" root directory for nginx
mkdir -p /var/www/html  
cd /var/www/html
# curl command is a command-line tool used for transferring data to or from a server using various network protocols.
# wp-cli.phar is a PHP Archive (PHAR) file that contains the WordPress Command Line Interface (CLI) tool.
# .phar = PHP Archive
# It's like a .zip file that bundles PHP code together
# It runs as a single executable file, using PHP
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
chmod +x wp-cli.phar
# we use mv to this path "/usr/local/bin/wp" because this is a common directory for executable files on Unix-like systems.
# This allows us to run the wp command from anywhere in the terminal without specifying the full path
# This is useful for convenience and makes it easier to use the wp-cli tool.
mv wp-cli.phar /usr/local/bin/wp

#The wp core download --allow-root command is used with WP-CLI to download the WordPress core files,
# and the --allow-root flag explicitly permits the execution of the command as the root user.
wp core download --allow-root
# the cp command is used to copy the wp-config-sample.php file to wp-config.php. because wordpress requires a configuration 
# file named wp-config.php to function properly.
cp wp-config-sample.php wp-config.php

# sed command is used to perform text replacement in the wp-config.php file.
# -i option is used to edit the file in place, meaning it modifies the file directly.
sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${MYSQL_DATABASE}' );/" wp-config.php
sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${MYSQL_USER}' );/" wp-config.php
sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );/" wp-config.php
sed -i "s/localhost/mariadb/" wp-config.php

sleep 5

# It sets up the actual WordPress website inside the database so it becomes usable.
wp core install \
  --url="mel-hadd.42.fr" \
  --title="${SITE_TITLE}" \
  --admin_user="${WP_ADMIN_USER}" \
  --admin_password="${WP_ADMIN_PASSWORD}" \
  --admin_email="${WP_ADMIN_EMAIL}" \
  --allow-root

# Adds a new WordPress user with the role of editor.
wp user create \
    "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" \
    --role=editor \
    --allow-root

# /run/php is a directory used by PHP-FPM (FastCGI Process Manager) to store runtime data such as process IDs and status information.
mkdir -p /run/php

# The command starts the PHP FastCGI Process Manager (PHP-FPM) service for PHP version 8.2 in the foreground.
# The -F option keeps the process in the foreground, allowing it to run continuously 
php-fpm8.2 -F