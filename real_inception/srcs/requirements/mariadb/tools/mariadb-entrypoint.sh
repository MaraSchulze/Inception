#!/bin/bash
set -e

mkdir -p /var/run/mysqld/
chown mysql:mysql /var/run/mysqld/

# substitute environment variables into the conf script
envsubst < /etc/mysql/configuration.sql.template > /etc/mysql/configuration.sql

# check if the database was already initialized
if [ ! -f "/var/lib/mysql/initialized.flag" ]; then
    # Start MariaDB temporarily
    mysqld &
    
	# Wait for MariaDB to be ready
    while ! mysqladmin ping --silent; do
        sleep 1
    done
    
    # initialization
    mysql -u root -p${MYSQL_ROOT_PASSWORD} < /etc/mysql/configuration.sql

    # mark the initialization as done
    touch /var/lib/mysql/initialized.flag

    # stop Mariadb after initialization
    mysqladmin shutdown
fi

# start Mariadb
exec "$@"
