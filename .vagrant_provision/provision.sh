#!/bin/bash
echo '=== START Provisioner ==='

# Stop nginx as we are going to use apache2 for this project
# The default webserver for this vagrant box package was nginx
echo '=== Stopping Nginx service ==='
service nginx stop

echo '=== Updating ubuntu packages ==='
apt-get update

export DEBIAN_FRONTEND=noninteractive

echo '=== Remove existing PHP installs. We reinstall it later.'
apt-get purge php*

echo '=== Install Apache2 & Apache2-Utils ==='
apt-get install -y aptitude apache2 apache2-utils php7.1-mysql php7.1-curl php7.1-json php7.1-cgi php7.1 php7.1-common libapache2-mod-php7.1

mkdir -p /vagrant/public_html

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

echo '=== Setting PATH for /.composer/vendor/bin'
#export PATH=$PATH:/home/vagrant/.composer/vendor/bin;

echo '=== END Provisioner ==='

echo '=== Do NOT forget to edit /etc/php/7.1/apache2/php.ini and comment out your PHP modules'