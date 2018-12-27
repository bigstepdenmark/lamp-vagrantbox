#!/bin/bash

SYNC_DIR="/vagrant_data/"
PUBLIC_DIR="/vagrant_data/pub"

# Update sync-folder permission.
chmod -R 777 ${SYNC_DIR}

# Remove /var/www default
rm -rf /var/www

# Symlink /vagrant to /var/www
ln -fs ${PUBLIC_DIR} /var/www

# Setup hosts file
VHOST=$(cat <<EOF

<VirtualHost *:80>
        ServerName localhost

        ServerAdmin webmaster@localhost
        DocumentRoot ${PUBLIC_DIR}

        <Directory "${PUBLIC_DIR}">
          Options +ExecCGI -Indexes +Includes -FollowSymLinks +SymLinksIfOwnerMatch +MultiViews
          AllowOverride All
          Order allow,deny
          Allow from all
          Require all granted
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

EOF
)

# Update host file
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf

# Enable mod_rewrite
a2enmod rewrite

# Restart apache2
service apache2 restart
