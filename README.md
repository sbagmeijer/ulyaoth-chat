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

(just as a reminder the configuration below is just for people that have no experience with php and nginx, you can create your own configuration nothing does say you must use this).

Nginx Configuration:
Create the following directories:
mkdir -p /etc/nginx/sites-available
mkdir -p /etc/nginx/sites-enabled
mkdir -p /etc/nginx/logrotate
mkdir -p /etc/nginx/ssl
mkdir -p /var/log/nginx/ulyaothchat 

Create & copy the following files from github:
copy the file "nginx.conf" to /etc/nginx (and overwrite the default one), you will need to edit the file and change the "worked_processes 2;" to a number that fits you cpus so if your server has 1 cpu change the 2 to a 1.
copy the file "ulyaothchat.net to /etc/nginx/sites-available" and rename the file to your vhost name, then open the file and change the server name to your server name. (server_name php.ulyaothchat.net;)

Browse to the directory "/etc/nginx/sites-enabled" and then run the following command: (change the command to your vhost name)
ln -s /etc/nginx/sites-available/php.ulyaothchat.net php.ulyaothchat.net

vi into the file "/etc/sysconfig/memcached" and change the content of the file to the following values:
PORT="11211"
USER="memcached"
MAXCONN="1024"
CACHESIZE="512"
OPTIONS="slab_reassign, slab_automove"



