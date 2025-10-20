#!/bin/sh


if [ -f "/var/www/rel-fila/wordpress/wp-config.php" ]
then
    echo "WordPress already configured"
else
    echo "Waiting for MariaDB to be ready..."
    
    # Better wait mechanism
    until mariadb -h mariadb -u${SQL_USER} -p${SQL_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; do
        echo "Waiting for database connection..."
        sleep 3
    done
    
    echo "Database is ready, installing WordPress..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    wp core download --allow-root --version=6.4 --path=/var/www/rel-fila/wordpress
    cd /var/www/rel-fila/wordpress
    wp config create --allow-root --dbname=${SQL_DATABASE} --dbuser=${SQL_USER} --dbpass=${SQL_PASSWORD} --dbhost="mariadb"
    wp core install --allow-root --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${SQL_USER} --admin_password=${SQL_PASSWORD} --admin_email=${WP_EMAIL} --skip-email
    wp user create --allow-root ${WP_EDITOR_LOGIN} ${WP_EDITOR_MAIL} --role=${WP_EDITOR_ROLE} --user_pass=${WP_EDITOR_PASS}

fi

# Fix permissions
chown -R www-data:www-data /var/www/rel-fila/wordpress
    
echo "WordPress installation complete"

exec /usr/sbin/php-fpm7.4 -F
