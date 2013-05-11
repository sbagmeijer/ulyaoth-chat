ulyaoth-chat
============

For this installation I am using a Red Hat bassed operating system however it should work on any other Linux distro and even on a Windows machine.
For windows you would need to alter many files to use the correct perl path (future update will automate this)

You will need to install the following packages on your server:
yum install mariadb.x86_64 perl-DBI.x86_64 perl-BerkeleyDB.x86_64 perl-CGI perl-FCGI perl-File-FcntlLock.x86_64 perl-libwww-perl httpd sendmail

Installation:
Copy the content of the "cgi-bin" folder into your servers "cgi-bin" folder.
And make sure all files and directories have permission 755

Copy the folder "ulyaothchat" to "/opt/ulyaothchat"
chmod -R 755 /opt/ulyaothchat

(the permissions on "ulyaothchat" are technically not needed as 755 but I will update this later)

Create the following folders in your html folder:
mkdir banlogs
mkdir upload

They need to have write permission but "no" execute permission.
