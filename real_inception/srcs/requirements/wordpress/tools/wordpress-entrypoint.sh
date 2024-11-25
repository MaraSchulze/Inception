#!/bin/bash
set -e

# Ensure the directory exists and set permissions
mkdir -p /var/www/html
chmod -R 755 /var/www/html
#chown -R www-data:www-data /var/www/html

# Only if wp-config.php doesn't exist:
if [ ! -f /var/www/html/wp-config.php ]; then

echo wordpress is not set up

sleep 5

# Create wp-config.php
wp-cli.phar config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER2 --dbpass=$MYSQL_USER2_PASSWORD --dbhost=mariadb --path=/var/www/html --allow-root --skip-check

# Install
wp-cli.phar core install --url=marschul.42.fr --title="Inception sucks" --admin_user=$WORDPRESS_ADMIN_USER --admin_password=$WORDPRESS_ADMIN_PASSWORD --admin_email=bogus@gmail.com --path=/var/www/html --allow-root && echo $?

# Set debugging on
wp-cli.phar config set WP_DEBUG true --raw --path=/var/www/html --allow-root
wp-cli.phar config set WP_DEBUG_LOG true --raw --path=/var/www/html --allow-root
wp-cli.phar config set WP_DEBUG_DISPLAY false --raw --path=/var/www/html --allow-root

# give all files to www-data
chown -R www-data:www-data /var/www/html

fi
#
echo wordpress is set up

# Start wordpress
exec "$@"