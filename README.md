Ulyaoth Chat
============

PROJECT ULYAOTH CHAT:
My hope is to update the old script to use a newer perl version and to move to a mysql/postgresql database, in a perfect world people should be allowed to choose what database.

TEST IT:
-------

http://www.ulyaothchat.net/cgi-bin/chat/chat.cgi

INSTALLATION:
-------

For this installation I am using a Red Hat bassed operatings system (Fedora 19) it should however work on other distributions also but the instructions below where based a Fedora machine.

You will need to install the following packages on your server:
yum install postgresql.x86_64 postgresql-libs.x86_64 sendmail nginx memcached.x86_64 libmemcached.x86_64 libmemcached-devel.x86_64 memcached-devel.x86_64 git 

Installation:
you will be able to find the configuration files for nginx inside the "OS/configuration/" folder on github.

Now create a linux group "ulyaoth" and a usernamed ulyaoth
sudo groupadd ulyaoth
sudo adduser -M -s /sbin/nologin ulyaoth -g ulyaoth

Create the following directories:
mkdir -p /var/www/ulyaothchat/html

Permissions:
sudo chown -R nginx:ulyaoth /var/www/ulyaothchat/

Firewall on Fedora 19:
firewall-cmd --permanent --add-service=http



