#!/bin/bash
set -x
HOMEDIR=/home/ec2-user
sudo yum update -y
sudo amazon-linux-extras install lamp-mariadb10.2-php7.2 -y
echo Installing packages...
echo Please ignore messages regarding SELinux...
sudo yum install -y \
httpd \
mariadb-server \
php \
php-gd \
php-mbstring \
php-mysqlnd \
php-xml \
php-xmlrpc
MYSQL_ROOT_PASSWORD=password
echo $MYSQL_ROOT_PASSWORD > $HOMEDIR/MYSQL_ROOT_PASSWORD
sudo chown ec2-user $HOMEDIR/MYSQL_ROOT_PASSWORD
echo Starting database service...
sudo systemctl start mariadb
sudo systemctl enable mariadb
echo Setting up basic database security...
mysql -u root <<DB_SEC
UPDATE mysql.user SET Password=PASSWORD('$MYSQL_ROOT_PASSWORD') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
FLUSH PRIVILEGES;
DB_SEC
echo Configuring Apache...
sudo usermod -a -G apache ec2-user
sudo chown -R ec2-user:apache /var/www
sudo chmod 2775 /var/www && find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
echo Starting Apache...
sudo systemctl start httpd
sudo systemctl enable httpd
echo installing wordpress and creating mysqluser
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz -C /home/ec2-user

mkdir /home/ec2-user/.aws
touch /home/ec2-user/.aws/config
cat << END > /home/ec2-user/.aws/config
[default]
region = us-west-2
output = yaml
END

sudo systemctl start mariadb

echo configuring wordpress
echo $dbendpoint
database_name=mydb
master_username=root
master_password=password
sudo cp /home/ec2-user/wordpress/wp-config-sample.php /home/ec2-user/wordpress/wp-config.php
sudo sed -i "s/database_name_here/$database_name/" /home/ec2-user/wordpress/wp-config.php
sudo sed -i "s/username_here/$master_username/" /home/ec2-user/wordpress/wp-config.php
sudo sed -i "s/password_here/$master_password/" /home/ec2-user/wordpress/wp-config.php
sudo sed -i "s/localhost/${dbendpoint}/" /home/ec2-user/wordpress/wp-config.php

sudo cp -r /home/ec2-user/wordpress/* /var/www/html/
sudo systemctl restart httpd

mysql -u root --password='password' -e "CREATE database exercise_base;"
mysql -u root --password='password' -e "use exercise_base; create table students (name char(50), height smallint, location char(50));"
mysql -u root --password='password' -e "use exercise_base; insert into students (name, height, location) values ('Hans August', 223, 'AWS_Homezone');"