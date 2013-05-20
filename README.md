ulyaoth-chat
============

TEST IT:
http://chat.ulyaothchat.net/cgi-bin/chat/chat.cgi

INSTALLATION:

For this installation I am using a Red Hat bassed operating system however it should work on any other Linux distro and even on a Windows machine.
For windows you would need to alter many files to use the correct perl path (future update will automate this)

You will need to install the following packages on your server:
yum install postgresql.x86_64 postgresql-libs.x86_64 perl-DBD-Pg.x86_64 perl-DBI.x86_64 perl-BerkeleyDB.x86_64 perl-CGI perl-FCGI perl-File-FcntlLock.x86_64 perl-libwww-perl httpd sendmail 

Installation:
Copy the content of the "cgi-bin" folder into your servers "cgi-bin" folder.
Copy the folder "ulyaothchat" to "/opt/ulyaothchat"

Now create a linux group "ulyaoth" And add your own user to that group.
sudo groupadd ulyaoth

Create the following directories:
mkdir -p /var/www/html/upload
mkdir -p /var/www/html/banlogs

Permissions:
sudo chown -R apache:ulyaoth /var/www/
sudo chown -R apache:ulyaoth /opt/ulyaothchat/
sudo chmod -R 570 /var/www/html/banlogs
sudo chmod -R 570 /var/www/html/upload
sudo chmod u+w /var/www/html/banlogs
sudo chmod u+w /var/www/html/upload
sudo chmod -x /var/www/html/banlogs
sudo chmod -x /var/www/html/upload
sudo chcon -R -t httpd_sys_content_t /opt/ulyaothchat/
chcon -Rt httpd_sys_script_exec_t /opt/ulyaothchat/

This one below the permissions we will fix later
chmod -R 755 /opt/ulyaothchat

Firewall on Fedora 19:
firewall-cmd --permanent --add-service=http

Perl Modules required that you probably need to manually install:
DB_File
CGI-Application-Plugin-Config-Perl

$root = '/var/www/ulyaothchat';

Admin Account:
You can login with the account "Admin" and the password "admin007" be sure to change the password directly with the /account command.
