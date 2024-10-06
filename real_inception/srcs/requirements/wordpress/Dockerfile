# download os as base image
FROM debian:buster

# non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# download php
RUN apt-get update && apt-get install -y php php-fpm php-mysql wget && apt-get clean

# create document root
RUN mkdir -p /var/www/html

# download wordpress
RUN  cd /var/www/html \
  && wget https://wordpress.org/latest.tar.gz \
  && tar -xzvf latest.tar.gz \
  && mv wordpress/* . \
  && rm -rf wordpress latest.tar.gz

# set permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html
  
# download wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x wp-cli.phar \
  && mv wp-cli.phar /usr/local/bin/

# create directory for pid file
RUN mkdir -p /run/php

# listen on port 9000
RUN sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/' /etc/php/7.3/fpm/pool.d/www.conf

# copy the entrypoint script
COPY tools/wordpress-entrypoint.sh /usr/local/bin/

# start wordpress
ENTRYPOINT ["wordpress-entrypoint.sh"]

CMD ["php-fpm7.3", "-F"]