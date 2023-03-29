#!/bin/bash
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
aws_access_key_id=ASIAWVNGX3YRPKAFI6H7
aws_secret_access_key=lrZIrMvTuRum7npLdlluafX1GyHO/KEH7MpHpS+g
aws_session_token=FwoGZXIvYXdzEJT//////////wEaDKVjxQyHKkM0F6NPUiK8AfmDF9vFvfZ1Nlz+qovpcDSQ2Dfe+aI/0xnj+fefN6wGTd7JcCPBECGi5m393JbcLignciI8dyhv6rvZNL6HXMr8FP4lbl2LuUcGMoqfCAdsu5Z3a6H+xZcDrqpbdsVPrAdnQnC1/T+w58xHaCrNYNzmpfSBszKVpxrhzanJkZHeCJJ1YaETEOMUhI3XAA98ruSxkIn2WTFztusH2UYJJiF6HjetcdsHFuxaFgPLQW+h4yRshgok3iw8J5rWKO2nkKEGMi2NtV17wGOFDVk7XYaBI+4RO6NtneEuh/xVWYqW6MZGsSMZBbOXH2LxccGP+js=
END
touch /home/ec2-user/.aws/config
cat << END > /home/ec2-user/.aws/config
[default]
region = us-west-2
output = yaml
END
dbendpoint=$(aws rds describe-db-instances --db-instance-identifier db-aurora-instance --query "DBInstances[*].Endpoint.Address" --output text)
filename='/var/www/html/wp-config.php'
sudo sed -i 's/wordpressdb/db/g' $filename
sudo sed -i 's/wordpressuser/admin/g' $filename
sudo sed -i 's/pass/mysecretpassword/g' $filename
sudo sed -i "s/localhost/$dbendpoint/g" $filename
sudo systemctl restart httpd