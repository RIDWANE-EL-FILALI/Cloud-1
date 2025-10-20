#!/bin/sh

if [ ! -d "/var/lib/mysql/wordpress" ]
then
    echo "Initializing MariaDB..."
    
    # Start MariaDB temporarily for setup
    mysqld --user=mysql --bootstrap <<-EOSQL
        USE mysql;
        FLUSH PRIVILEGES;
        CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
        CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
        FLUSH PRIVILEGES;
EOSQL

    echo "MariaDB initialized successfully"
fi

echo "Starting MariaDB server..."
exec mysqld --user=mysql