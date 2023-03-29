#!/bin/bash
# This script is given by yasdou: https://github.com/yasdou/Terraform-Wordpress-highly-scalable-and-available
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
MYSQL_ROOT_PASSWORD=pass
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
sudo systemctl start mariadb
#provide AWS credentials
mkdir /home/ec2-user/.aws
touch /home/ec2-user/.aws/credentials
cat << END > /home/ec2-user/.aws/credentials
[default]
aws_access_key_id=ASIAWVNGX3YRGRV5PETT
aws_secret_access_key=0kM8sxw8mK7ihS9+ILCwqEJwU+wzLjp1y68xqGcG
aws_session_token=FwoGZXIvYXdzEHkaDIcHICRTW1p1yKzUWSK8Adm/7wJ+u7sOPFHiU9hmOIoenmvQCzZep9b4O8cYnUiKCnAvLPBqlD6ziue9WOD923j/iZedq5177lfpjIWI8hyKJf3GgB/SjGD8avtXn3cc9cWHyZxDy1JD9cOpEwakeLM2DA+a5n7j5g+OUDXoBy3nIjosNGUyPiH30CgtV/N5WJrbj0Zqw5KHFJmwEHVx3D88k3Ggkc42C4tsZARuZ7HTMAtBeB1FyTaj7zRHKUA/ZCst9lg3w//dDy2FKPCniqEGMi2ehMxGKf3KgGbJ6QVfxRpSwVk7ojdQLwz/5AJyN+8344RDeiP7MxTQIhVVhR0=
END
touch /home/ec2-user/.aws/config
cat << END > /home/ec2-user/.aws/config
[default]
region = us-west-2
output = json
END
sudo cp /home/ec2-user/wordpress/wp-config-sample.php /home/ec2-user/wordpress/wp-config.php
sudo sed -i "s/database_name_here/DBWordpress/" /home/ec2-user/wordpress/wp-config.php
sudo sed -i "s/username_here/root/" /home/ec2-user/wordpress/wp-config.php
sudo sed -i "s/password_here/12345678/" /home/ec2-user/wordpress/wp-config.php
sudo sed -i "s/localhost/$(aws rds describe-db-instances --filters Name=db-cluster-id,Values=wordpresscluster --query 'DBInstances[0].Endpoint.Address' --output text)/" /home/ec2-user/wordpress/wp-config.php
sudo cp -r /home/ec2-user/wordpress/* /var/www/html/
sudo systemctl restart httpd