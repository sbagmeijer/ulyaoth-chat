#!/usr/bin/perl

use CGI;
use Fcntl;
use DB_File;

$root = '/opt/ulyaothchat';


print "Content-type: text/html\n";

require "/opt/ulyaothchat/cookies/cookie.lib";

&GetCookies('bombastik');

&GetCookies('realip');


dbmopen(%USER,"$root/online/users/$DATA{'n'}",0777);

if($Cookies{'realip'}){

$USER{'realip'} = $Cookies{'realip'};

}else{

&SetCookies('realip',$ENV{'REMOTE_ADDR'});

$USER{'realip'} = $ENV{'REMOTE_ADDR'};

}


if($ENV{'HTTP_VIA'}){

$USER{'proxy'} = "<font color=red>active</font>";

}else{


$USER{'proxy'} = "none";

}


dbmclose(%USER);


open(WRNICKS,">$root/usednicks/$DATA{'n'}.txt");

if($Cookies{'bombastik'} =~ /$DATA{'n'}/){

print WRNICKS "$Cookies{'bombastik'}";

$crap = "$Cookies{'bombastik'}";

}else{

if(-e "$root/ops/$DATA{'n'}.txt"){

print WRNICKS "$Cookies{'bombastik'}\!\#$DATA{'n'}\#";

$crap = "$Cookies{'bombastik'}\!\#$DATA{'n'}\#";

}else{

print WRNICKS "$Cookies{'bombastik'}\!$DATA{'n'}";

$crap = "$Cookies{'bombastik'}\!$DATA{'n'}";

}}

close(WRNICKS);


&SetCookies('bombastik',$crap);


print "\n";

$DATA{'id'} = $id;


require "$root/inc/print_header.inc";


require "$root/inc/print_room.inc";

if($frames eq "yes"){


print "</body>\n";


}else{


require "$root/inc/print_footer.inc";



}




return true;

