# download os as base image
FROM debian:buster

# non-interacitive
ENV DEBIAN_FRONTEND=noninteractive

# download Nginx and OpenSSL
RUN apt-get update && apt-get install -y nginx openssl && apt-get clean

# create a directory for SSL certificates
RUN mkdir -p /etc/nginx/ssl

# generate a self-signed SSL certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=FR/ST=France/L=Paris/O=MyOrganization/CN=marschul.42.fr"

# copy the custom Nginx configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# set rights and ownership
RUN mkdir -p /var/www/html
RUN chmod -R 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# copy the entrypoint script
COPY tools/nginx-entrypoint.sh /usr/local/bin/

# start Nginx
ENTRYPOINT ["nginx-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
