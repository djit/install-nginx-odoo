#!/usr/bin/env bash

# odoo instal script and config on Linux Ubuntu Server 16.04
# author: Djilali Tabbouche
# email: dtabbouche@gmail.com
# version: 0.1


# update & upgrade repositories
sudo apt-get update && sudo apt-get -y upgrade

# install odoo 8.0
wget -qO - https://nightly.odoo.com/odoo.key | sudo apt-key add -
sudo sh -c 'echo "deb http://nightly.odoo.com/8.0/nightly/deb/ ./" > /etc/apt/sources.list.d/odoo.list'
sudo apt-get update && sudo apt-get install odoo

# update databases master password
sudo nano /etc/odoo/openerp-server.conf
# set "admin_passwd = NEW_PASSWORD"

# restart odoo
sudo service odoo restart

# install Wkhtmltopdf package (pdf generation)
sudo apt-get -y install wkhtmltopdf

# install nginx
wget -qO - http://www.dotdeb.org/dotdeb.gpg | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list'
sudo apt-get update && sudo apt-get -y install nginx

# create odoo server config file
# download default odoo server conf
wget https://raw.githubusercontent.com/djit/install-nginx-odoo/master/odoo.site.conf
sudo mv odoo.site.conf /etc/nginx/sites-enabled

# remove default site
sudo rm /etc/nginx/sites-enabled/default

# add timeout setting for odoo requets
wget https://raw.githubusercontent.com/djit/install-nginx-odoo/master/odoo.timeout.conf
sudo mv odoo.timeout.conf /etc/nginx/conf.d

# restart nginx server
sudo service nginx restart
