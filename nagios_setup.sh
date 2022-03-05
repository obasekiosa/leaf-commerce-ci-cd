#!/usr/bash

NAGIOS_PULGIN_VERSION=2.4.0
NAGIOS_PULGIN_SOURCE=https://github.com/nagios-plugins/nagios-plugins/archive/release-$NAGIOS_PULGIN_VERSION.tar.gz
NAGIOS_VERSION=4.4.6
NAGIOS_SOURCE=https://github.com/NagiosEnterprises/nagioscore/archive/nagios-$NAGIOS_VERSION.tar.gz

sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.0 libgd2-xpm-dev

# Download source
cd /tmp
wget -O nagioscore.tar.gz $NAGIOS_SOURCE
tar xzf nagioscore.tar.gz


# Compile
cd /tmp/nagioscore-nagios-$NAGIOS_VERSION/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all

# Create User and Group
sudo make install-groups-users
sudo usermod -a -G nagios www-data

#Install Binaries
sudo make install

# Install Service / Daemon
sudo make install-daemoninit

# Install Command Mode
sudo make install-commandmode

# Install Configuration Files
sudo make install-config

# Install Apache Config Files
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi

# Configure Firewall if enabled
sudo ufw allow Apache
sudo ufw reload

# Create nagiosadmin User Account
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin # requries password


# Start Apache Web Server
sudo systemctl restart apache2.service

# Start Service / Daemon
sudo systemctl start nagios.service

# =================INSTALL PLUGINS===========

# Install dependencies
sudo apt-get install -y autoconf gcc libc6 libmcrypt-dev make libssl-dev wget bc gawk dc build-essential snmp libnet-snmp-perl gettext

# Download Source
cd /tmp
wget --no-check-certificate -O nagios-plugins.tar.gz $NAGIOS_PULGIN_SOURCE
tar zxf nagios-plugins.tar.gz

# Compile + Install
cd /tmp/nagios-plugins-release-$NAGIOS_PULGIN_VERSION/
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install

# Restart Service / Daemon
sudo systemctl start nagios.service
sudo systemctl stop nagios.service
sudo systemctl restart nagios.service
sudo systemctl status nagios.service