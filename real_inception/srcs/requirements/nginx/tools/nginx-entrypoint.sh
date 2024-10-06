#!/bin/bash
set -e

# ensure the directory exists and set permissions
mkdir -p /var/www/html
chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html

# start nginx
exec "$@"
