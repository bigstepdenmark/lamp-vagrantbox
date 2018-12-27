#!/bin/bash

# ---------------------------------------
# Update and upgrade repositories
# ---------------------------------------
apt-get update && apt-get upgrade


# ---------------------------------------
# Install repositories
# htop, wget, git-core, curl, zsh
# ---------------------------------------
apt-get install -y htop wget git-core curl zsh


# ---------------------------------------
# Install nodejs v11
# ---------------------------------------
apt-get install -y python-software-properties
curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
apt-get install -y nodejs


# ---------------------------------------
# Install PHP 7.2 and PHP modules
# ---------------------------------------
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get install -y php7.2
apt-get install -y php-pear php7.2-curl php7.2-dev php7.2-gd php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml php7.2-json php7.2-intl


# ---------------------------------------
# Install Composer
# ---------------------------------------
curl -s https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer


# ---------------------------------------
# Install MySQL 5.7
# ---------------------------------------
export DEBIAN_FRONTEND=noninteractive
# Setting MySQL root user password root/root
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

apt-get install -qq -y mysql-server mysql-client

# Allow External Connections on your MySQL Service
sed -i -e 's/bind-addres/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i -e 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
mysql -u root -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root'; FLUSH privileges;"

# Restart mysql
service mysql restart

# create client database
mysql -u root -proot -e "CREATE DATABASE myDatabase;"
