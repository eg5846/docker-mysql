#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL database ..."
    mysqld --initialize --datadir=$VOLUME_HOME > /dev/null 2>&1
    echo "=> Done!"

    if [ -z "$MYSQL_ROOT_PASSWORD" ]; then
        echo "MYSQL_ROOT_PASSWORD is not set, use default value 'root'"
        MYSQL_ROOT_PASSWORD=root
    else
        echo "MYSQL_ROOT_PASSWORD is set to '$MYSQL_ROOT_PASSWORD'" 
    fi

	cat > /tmp/mysql-first-time.sql <<-EOSQL
		ALTER USER "root"@"localhost" IDENTIFIED BY "${MYSQL_ROOT_PASSWORD}" ;
		UPDATE mysql.user SET host = "%" WHERE user = "root" LIMIT 1 ;
		DROP DATABASE IF EXISTS test ;
		FLUSH PRIVILEGES ;
	EOSQL

    exec mysqld_safe --init-file=/tmp/mysql-first-time.sql
else
    echo "=> Using an existing volume of MySQL"
    exec mysqld_safe
fi
