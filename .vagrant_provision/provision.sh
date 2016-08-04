#!/bin/bash
echo '=== START Provisioner ==='

# Stop nginx as we are going to use apache2 for this project
# The default webserver for this vagrant box package was nginx
echo '=== Stopping Nginx service ==='
service nginx stop

echo '=== Updating ubuntu packages ==='
apt-get update

echo '=== Install Apache2 & Apache2-Utils ==='
#apt-get install -y apache2 apache2-utils libapache2-mod-php7.0
apt-get install -y apache2 apache2-utils


echo "ServerName localhost" > "/etc/apache2/conf-available/fqdn.conf"
a2enmod rewrite
cp /vagrant/.vagrant_provision/site-vagrant.conf /etc/apache2/sites-available/site-vagrant.conf
a2dissite 000-default.conf
a2ensite site-vagrant.conf

apt-get -y autoremove

echo '=== Restarting Apache2 ==='
service apache2 restart

echo '=== Adding mysql global user vagrant:vagrant ===';
mysql -u root -e "CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrant'; GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;" mysql

echo '=== END Provisioner ==='