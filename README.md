Ulyaoth Chat
============

PROJECT ULYAOTH CHAT:
My hope is to update this old chat server to use the newest version of perl and in a more strict coding way.
I would like to move away from Berkeley DB and use MariaDB/MySQL instead with proper sessions.

I also should become fully html5 validated.

TEST IT:
-------

http://www.ulyaothchat.net/cgi-bin/chat/chat.cgi

(Based on the Experimental Branch and nightly updated)

VERSIONS:
-------
Master Branch:
This is a stable Linux version and you should be able to run it without problems

Windows Branch:
This is a stable Windows Version and you should be able to run it without problems, you have to use "strawberry perl" installed in "C:/strawberry".

Experimental Branch:
This is a highly unstable version with many changes, things that work here and have been tested will be pushed to the master branch.

C++ Branch:
Just some fun you should not use it :)!


INSTALLATION:
-------
For this installation I am using a Red Hat bassed operatings system (Fedora 19).
I Personally use Nginx for all static content and Apache as backend to run the cgi stuff, however you can simpely use apache.

You will need to install the following packages on your server:

For a basic installation you need:
Perl
Apache/nginx
sendmail

Database:
MySQL or MariaDB


Optional: (if you choose to use the function)
memcached.x86_64 
libmemcached.x86_64

And the following perl modules: (It will not run without even you not use memcached)
CGI
CGI::Session
CGI::Session::Driver:memcached
Fcntl
DB_File
YAML
YAML::Tiny
DBD::mysql
DBI
warnings
strict


Again you can simpely just use Apache if you not want to use nginx, memcached is also only required if you choose to enable it.

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
