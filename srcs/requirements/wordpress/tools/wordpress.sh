#!/bin/bash

cd /var/www/html

echo "Waiting for MariaDB to be ready..."
until mysqladmin -h mariadb -u root -p"$MYSQL_ROOT_PASSWORD" ping --silent; do
    sleep 1
done
echo "MariaDB is up and running!"

if [ ! -f "wp-config.php" ]; then
    echo "Downloading and setting up WordPress..."

    wp core download --allow-root

    
    wp config create --dbname=${MYSQL_DATABASE} \
                     --dbuser=${MYSQL_USER} \
                     --dbpass=${MYSQL_PASSWORD} \
                     --dbhost=mariadb \
                     --skip-check \
                     --allow-root

    
    wp core install --url=${DOMAIN_NAME} \
                    --title="Inception Project" \
                    --admin_user=${WP_ADMIN_USER} \
                    --admin_password=${WP_ADMIN_PASSWORD} \
                    --admin_email=${WP_ADMIN_EMAIL} \
                    --allow-root
    
    wp user create ${WP_USER} ${WP_EMAIL} \
                   --user_pass=${WP_PASSWORD} \
                   --role=author \
                   --allow-root
    
    echo "WordPress setup is done!"
fi

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F