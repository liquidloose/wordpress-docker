#
#
# Adds the default Ubuntu uid(1000) to the www-data user. This is so
# both of the uid's  on the host and the container match. The www-data user
# is used by Apache to make directory/file level changes to I changed it to
# that user
#
#
# It also grants ownership to the /var/www folder to the www-data user. 
# All new files and subdirectories in the www/ folder will inherit the group id # of the www/ directory.
#
#
 
FROM wordpress:latest

RUN groupmod -g 1000 www-data \
    && usermod -u 1000 www-data \
    && usermod -g 1000 www-data \
    && chown -R www-data:www-data /var/www \
    && chmod g+s /var/www
    
