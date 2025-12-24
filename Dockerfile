# Adds the default Ubuntu uid(1000) to the www-data user. This is so
# both of the uid's  on the host and the container match. The www-data user
# is used by Apache to make directory/file level changes.
#
#
# It also grants ownership to the /var/www folder to the www-data user. 
# All new files and subdirectories in the www/ folder will inherit the group id # of the www/ directory.
#
#
 
FROM wordpress:latest

RUN apt-get update

# Installs pdo_mysql so I can use the Prime Mover plugin. See more about installing PHP extenstions here:
# https://github.com/docker-library/docs/blob/master/php/README.md#how-to-install-more-php-extensions
RUN docker-php-ext-install pdo_mysql

# This creates a docker development environment.
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

# Uncomment below and comment out dev environment in order to build a production environment
# RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

# Keeps the host user and www-data as the same uid so Docker doesn't see
# a different number and complain
RUN groupmod -g 1000 www-data \
    && usermod -u 1000 www-data \
    && usermod -g 1000 www-data \
    && chown -R www-data:www-data /var/www \
    && chmod g+s /var/www


