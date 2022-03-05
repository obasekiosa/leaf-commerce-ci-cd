#!/usr/bash

sudo apt-get update

sudo apt-get install mysql-server


mysqladmin -u root -p create store_schema

mysql -u root -p -e "SHOW DATABASES"
mysql -uroot -p -e "DELETE FROM mysql.user WHERE user=''; FLUSH PRIVILEGES"

mysql -uroot -p -e "GRANT ALL PRIVILEGES ON store_schema.* TO 'store'@'%' IDENTIFIED BY 'storesecret';"

mysql -u store -p store_schema -e "SELECT database(), user()"

sudo apt-get install puppet