# creating the os as base image
FROM debian:buster

# non-interactive
ENV DEBIAN_FRONTEND noninteractive

# download Mariadb
RUN apt-get update && apt-get install -y mariadb-server gettext

# copy configuration file
COPY conf/my.cnf /etc/mysql/my.cnf

# copy configuration template for SQL
COPY conf/configuration.sql.template /etc/mysql/configuration.sql.template

# copy the entrypoint script
COPY tools/mariadb-entrypoint.sh /usr/local/bin/

# set rights
RUN chmod +x /usr/local/bin/mariadb-entrypoint.sh

# set the entry point to init the database and run Mariadb
ENTRYPOINT ["mariadb-entrypoint.sh"]
CMD ["mysqld", "--console"]
